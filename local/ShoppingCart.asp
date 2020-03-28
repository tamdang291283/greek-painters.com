<% if session("restaurantid") & "" = "" Then
    session("restaurantid")=Request.QueryString("id_r")
        
    End If %>
<!-- #include file="Config.asp" -->
<!-- #include file="../timezone.asp" -->
<!-- #include file="../restaurantsettings.asp" -->
<% 

Set objCon = Server.CreateObject("ADODB.Connection")
Set objRds = Server.CreateObject("ADODB.Recordset") 
           
dim vOrderId
dim vRestaurantId
Dim sIsOpen
Dim sDayOfWeek
Dim sDate
Dim sHour
            
sDayOfWeek = DatePart("w", DateAdd("h",houroffset,now), vbMonday, 1)
sDate = FormatISODate(DateAdd("h",houroffset,now))
sHour = CDate(FormatDateTime(DateAdd("h",houroffset,now), vbShortTime))
vRestaurantId = Request.QueryString("id_r")
vouchercode = Request.QueryString("vouchercode")

objCon.Open sConnString
objRds.Open "SELECT * from BusinessDetails WHERE Id = " & vRestaurantId, objCon




	
	sPostalCode = objRds("PostalCode")
    sDeliveryMaxDistance = Cdbl(objRds("DeliveryMaxDistance"))
    sDeliveryFreeDistance= Cdbl(objRds("DeliveryFreeDistance"))

	sDeliveryChargeOverrideByOrderValue = 1000000000
    If Not Isnull(objRds("DeliveryChargeOverrideByOrderValue")) Then
	    sDeliveryChargeOverrideByOrderValue= Cdbl(objRds("DeliveryChargeOverrideByOrderValue"))
    End If
'	vOrderShipTotal = Cdbl(objRds("DeliveryFee"))
objRds.Close
'objCon.Close 



'objCon.Open sConnString
objRds.Open "SELECT bd.*,  oi.ID as IsOpen, " & _
        " convert(varchar, Hour_From, 8)  as OpenFrom, convert(varchar, Hour_To, 8)  as OpenUntil   " & _
        " FROM BusinessDetails bd " & _
        " LEFT JOIN openingtimes oi ON (" & _
        " (bd.ID = oi.IdBusinessDetail ) " & _
        " and (oi.DayOfWeek = " & sDayOfWeek & ") " & _        
        " ) WHERE bd.Id = " & vRestaurantId, objCon

sIsOpen = Not IsNull(objRds("IsOpen")) And ((objRds("OpenFrom") <= sHour and objRds("OpenUntil") >= sHour))


objRds.Close
'objCon.Close 

'objCon.Open sConnString
objRds.Open "select o.* from [OrdersLocal] o " & _
        " Where o.IdBusinessDetail = " & vRestaurantId & _
        " And o.SessionId = '" & Session.SessionID & "'", objCon
   
If Not objRds.Eof Then
    vOrderId = objRds("Id")
    vSubTotal = cdbl(objRds("SubTotal"))
	 vdeliverytype = objRds("deliverytype")
	' vdeliveryDistance = objRds("deliveryDistance")
Else
    vOrderId =  ""
End if
    
objRds.Close
'objCon.Close 

  dim vouchertype : vouchertype = "" 

If vOrderId = "" then
    
    vSubTotal = 0

   ' objCon.Open sConnString
    objRds.Open "SELECT * FROM [OrdersLocal] WHERE 1 = 0", objCon, 1, 3 
    objRds.AddNew 
    objRds("CreationDate") = DateAdd("h",houroffset,now)
    objRds("IdBusinessDetail") = vRestaurantId
      objRds("deliverytype") = "c" 'Always for in-restaurant orders
    vdeliverytype = "c"
    objRds("PaymentSurcharge") = 0
    objRds("SessionId") = Session.SessionID
    objRds("SubTotal") = vSubTotal
    objRds.Update 
    
    vOrderId = objRds("Id") 
     
     objRds.Close
    ' objCon.Close    

end if


Dim vOperator
Dim vMenuItemId
dim vMenuItemPrice
Dim vMenuItemPropertyId  

vOperator = Request.QueryString("op")

if vOperator <> "" Then 

    Select Case vOperator

        Case "add"
        
            vMenuItemId = Request.QueryString("mi")
            vMenuItemPrice = 0
            vMenuItemPropertyId = Request.QueryString("mip")
			toppingids = Request.QueryString("toppingids")
            dishpropertiesids = Request.QueryString("dishproperties")
			
           ' objCon.Open sConnString
        
            if(vMenuItemPropertyId >= 0) then
                objRds.Open "SELECT mi.Price as mPrice, mip.Price as pPrice FROM MenuItems mi " & _
                    "LEFT JOIN ( SELECT  * FROM   MenuItemProperties Where ID = " & vMenuItemPropertyId & ") as mip " & _
                    " ON mip.IdMenuItem = mi.Id " & _
                    " WHERE mi.Id = " & vMenuItemId, objCon
                If Not objRds.Eof Then
                    vMenuItemPrice = objRds("mPrice")
                    if objRds("pPrice") <> "" then vMenuItemPrice = objRds("pPrice")
                End If
            else 
                objRds.Open "SELECT * FROM MenuItems mi " & _
                    " WHERE mi.Id = " & vMenuItemId, objCon
                If Not objRds.Eof Then vMenuItemPrice = objRds("Price")
            end if
    
            objRds.Close
           ' objCon.Close    

           ' objCon.Open sConnString
            If(vMenuItemPropertyId >= 0) Then 
			
			sql = "SELECT * FROM [orderitemslocal] WHERE OrderId = " & vOrderId & " And MenuItemId = " &  vMenuItemId & " And MenuItemPropertyId = " & vMenuItemPropertyId
            Else 
               sql= "SELECT * FROM [orderitemslocal] WHERE OrderId = " & vOrderId & " And MenuItemId = " &  vMenuItemId & " And MenuItemPropertyId Is Null"
            End If
			
			if toppingids & "" <>"" then
			    sql = sql & " And toppingids = '" &  toppingids & "'"
            else
                sql = sql & " And ( toppingids is null or toppingids = '')   "
			end if
			
			if dishpropertiesids & "" <>"" then
			    sql = sql & " And dishpropertiesids = '" &  dishpropertiesids & "'"
            else
                sql = sql & " And (dishpropertiesids is null or dishpropertiesids = '')  "
			end if
			
		
			
			objRds.Open sql, objCon, 2, 3 
			toppingprice=0
				if toppingids<>"" then  
					'Set objCon_toppingprice = Server.CreateObject("ADODB.Connection")
					Set objRds_toppingprice = Server.CreateObject("ADODB.Recordset") 
					'objCon_toppingprice.Open sConnString
	                objRds_toppingprice.Open "SELECT * FROM MenuToppings where id in (" & toppingids & ")", objCon
					Do While NOT objRds_toppingprice.Eof 
					toppingprice=toppingprice+objRds_toppingprice("toppingprice") 
					objRds_toppingprice.MoveNext
					loop
				end if
				' it item has properties loop through them and calc price
				dishpropertyprice=0
				dishpropertypriceaddons=0
				if dishpropertiesids<>"" then  
					
					dishpropertiessplit=split(dishpropertiesids,",")
					
					for i=0 to ubound(dishpropertiessplit)
					dishpropertiessplit2=split(dishpropertiessplit(i),"|")
					if dishpropertiessplit2(1)<>0 then
					'Set objCon_dishpropertiesprice = Server.CreateObject("ADODB.Connection")
					Set objRds_dishpropertiesprice = Server.CreateObject("ADODB.Recordset") 
					'objCon_dishpropertiesprice.Open sConnString
	                objRds_dishpropertiesprice.Open "SELECT MenuDishproperties.ID, MenuDishproperties.dishproperty, MenuDishproperties.dishpropertyprice, MenuDishpropertiesGroups.dishpropertypricetype FROM MenuDishproperties INNER JOIN MenuDishpropertiesGroups ON MenuDishproperties.dishpropertygroupid = MenuDishpropertiesGroups.ID where (((MenuDishproperties.ID)=" & dishpropertiessplit2(1)  & "))", objCon
					
					if objRds_dishpropertiesprice("dishpropertypricetype")="price" then
					vMenuItemPrice=objRds_dishpropertiesprice("dishpropertyprice")
					else
					dishpropertypriceaddons=dishpropertypriceaddons+objRds_dishpropertiesprice("dishpropertyprice")
					end if
					end if
					next
				end if
        
            If objRds.BOF AND objRds.EOF Then
                objRds.AddNew
                objRds("OrderId") = vOrderId
                objRds("MenuItemId") = vMenuItemId
				objRds("toppingids") = toppingids
				objRds("dishpropertiesids") = dishpropertiesids
                if vMenuItemPropertyId >= 0 then objRds("MenuItemPropertyId") = vMenuItemPropertyId
				' if item has toppings then calculate price
                objRds("Price") = clng(vMenuItemPrice) + clng(toppingprice) + clng(dishpropertypriceaddons)
                objRds("Qta") = 0
            End If 
        
            objRds("Qta") = objRds("Qta") + 1
            objRds("Total") = cdbl(objRds("Qta")) * (cdbl(vMenuItemPrice) + toppingprice + dishpropertypriceaddons)
            objRds.Update 
              objCon.execute("update OrdersLocal set PaymentSurcharge = 0 where ID=" & vOrderId )
            objRds.Close
            'objCon.Close    
             
    
         Case "del"

            dim vId
            vId = Request.QueryString("id")
        
           ' objCon.Open sConnString
            objRds.Open "SELECT * FROM [orderitemslocal] WHERE Id = " & vId, objCon, 1, 3         
			currentqta= objRds("qta")
			if cint(currentqta)>1 then
            objRds("qta") = currentqta-1
			ppp=(cdbl(objRds("total"))/cdbl(currentqta))*(cdbl(currentqta)-1)
			 objRds("total")=ppp
	        objRds.Update 
			else
			objRds.delete
			end if
              objCon.execute("update OrdersLocal set PaymentSurcharge = 0 where ID=" & vOrderId )
            objRds.Close
           ' objCon.Close   
			
		' code to hadle vouchers
		Case "vouchercode"

           ' objCon.Open sConnString
             dim sqlDelete : sqlDelete = ""
                'sqlDelete =  " delete from [orderitemslocal] WHERE OrderId = " & vOrderId & "  And Price = 0 And MenuItemPropertyId Is Null "
                sqlDelete =  " delete from [orderitemslocal] WHERE OrderId = " & vOrderId & " And MenuItemPropertyId Is Null and  MenuItemId in (select Id from MenuItems where hidedish  = 1 ) "
                objCon.execute(sqlDelete)
			validvouchercode=0
            voucherminimumamount = 0
          	objRds.Open "SELECT *, convert(varchar(10), startdate, 105) as StartDateF, convert(varchar(10), enddate, 105)   as enddatef FROM vouchercodes where IdBusinessDetail=" & vRestaurantId & " and vouchercode='" & vouchercode & "'", objCon, 1, 3 
           'Response.Write(" SELECT *, convert(varchar(10), startdate, 105) as StartDateF, convert(varchar(10), enddate, 105)   as enddatef FROM vouchercodes where IdBusinessDetail=" & vRestaurantId & " and vouchercode='" & vouchercode & "' <br/> " )
			if not objRds.EOF then
               ' Response.Write("MenuItemID " & objRds("MenuItemID")  )
			     if objRds("MenuItemID")& "" <> "" and  objRds("MenuItemID")& "" <> "0" then
                        vouchertype = "product"
                       vMenuItemId = objRds("MenuItemID")
                        dim objRds1 : set objRds1 = Server.CreateObject("ADODB.Recordset")
                        dim SQL
                            SQL = "SELECT * FROM MenuItems mi  WHERE mi.Id = " & vMenuItemId
                        objRds1.Open SQL , objCon
                        If Not objRds1.Eof Then 
                            vMenuItemPrice = objRds1("Price")
                        end if
                        'Response.Write("vMenuItemPrice " & vMenuItemPrice & "<br/>")
                        objRds1.Close
                        set objRds1 = nothing
                       'vMenuItemPrice = 0  
                end if

                If objRds("vouchertype")="once" Then
                    validvouchercode=1
			        vouchercodediscount=objRds("vouchercodediscount")
                    If Not IsNull(objRds("minimumamount"))  AND objRds("minimumamount") & "" <> "" Then
                        voucherminimumamount = objRds("minimumamount")
                    End if
                elseif objRds("vouchertype")="date"   then
                  '  Response.Write("Test " &  DateDiff("d", objRds("StartDateF"), date()) & "<br/>")
                    If  DateDiff("d", objRds("StartDateF"), date())>0 and DateDiff("d",date(), objRds("enddatef"))>0 Then
			            validvouchercode=1
			            vouchercodediscount=objRds("vouchercodediscount")
                        If Not IsNull(objRds("minimumamount"))  AND objRds("minimumamount") & "" <> "" Then
                            voucherminimumamount = objRds("minimumamount")
                        End if
                    End If
			    end if
			
			
			end if

          
			 objRds.Close
           ' objCon.Close   
            if Cdbl(voucherminimumamount) > 0 AND validvouchercode Then
               ' objCon.Open sConnString
                objRds.Open "Select Sum(Total) As Total from [orderitemslocal]  " & _
                        " Where OrderId = " & vOrderId, objCon
   
                If Not objRds.Eof and Not IsNull(objRds("Total")) Then
                    vtemsubtotal = cdbl(objRds("Total"))
                Else
                    vtemsubtotal  = 0
                End if
    
                objRds.Close
               ' objCon.Close 
                If vtemsubtotal < Cdbl(voucherminimumamount) Then
                    validvouchercode = 0
                End If
            End if

            ' Response.Write("validvouchercode " & validvouchercode  & "  vouchertype " & vouchertype )
			  if validvouchercode=1 then
			 ' objCon.Open sConnString
                 if vouchertype = "product" then
                        dim objRdsUpdate : set objRdsUpdate = Server.CreateObject("ADODB.Recordset")
                        sql= "SELECT * FROM [orderitemslocal] WHERE OrderId = " & vOrderId & " And MenuItemId = " &  vMenuItemId & " And MenuItemPropertyId Is Null"
                        objRdsUpdate.Open sql, objCon, 2, 3 
                         If objRdsUpdate.BOF AND objRdsUpdate.EOF Then
                            objRdsUpdate.AddNew
                            objRdsUpdate("OrderId") = vOrderId
                            objRdsUpdate("MenuItemId") = vMenuItemId
				            objRdsUpdate("toppingids") = toppingids
				            objRdsUpdate("dishpropertiesids") = dishpropertiesids
                            objRdsUpdate("Price") = vMenuItemPrice
                            objRdsUpdate("Qta") = 1
                            objRdsUpdate("Total") = vMenuItemPrice
                            
                        End If 
                        objRdsUpdate.Update     
                        objRdsUpdate.close()
                        set objRdsUpdate = nothing
                  end if

			  objRds.Open "SELECT * FROM orderslocal where id=" & vOrderId, objCon, 1, 3    
	
			
			objRds("vouchercode") = vouchercode
			objRds("vouchercodediscount") = vouchercodediscount
    		objRds.Update
            
			objRds.Close
           ' objCon.Close 
            %>
            <script>
                    $("#divVoucherCodeAlert").html("");
                    scrollToV2("basket");
                </script>
            <%
            elseif vtemsubtotal < Cdbl(voucherminimumamount) AND Cdbl(voucherminimumamount)  > 0 Then
                %>
                <script>
                     $("#divVoucherCode1").show();
                    $("#divVoucherCodeAlert").html("The order must be at least <%=CURRENCYSYMBOL%><%= FormatNumber(voucherminimumamount, 2) %> to apply this voucher code!");
                </script>
            <%
            else 'voucher code not valid 
            %>
                <script>
                     $("#divVoucherCode1").show();
                    $("#divVoucherCodeAlert").html("Invalid Voucher Code");
                </script>
            <%
			end if
              
                 
    End select 

   ' objCon.Open sConnString
    objRds.Open "Select Sum(Total) As Total from [orderitemslocal]  " & _
            " Where OrderId = " & vOrderId, objCon
   
    If Not objRds.Eof and Not IsNull(objRds("Total")) Then
        vSubTotal = cdbl(objRds("Total"))
    Else
        vSubTotal  = 0
    End if
    
    objRds.Close
   ' objCon.Close 

   ' objCon.Open sConnString
    objRds.Open "SELECT * FROM [orderslocal] WHERE Id = " & vOrderId, objCon, 1, 3 
	discountcodeused=""
	if objRds("vouchercodediscount")<>0 or objRds("Vouchercode") & "" <> ""  then
	    Dim objRdsV
        Set objRdsV = Server.CreateObject("ADODB.Recordset") 
        objRdsV.Open "SELECT *,convert(varchar(10), startdate, 105)   as StartDateF,convert(varchar(10), enddate, 105)    as enddatef FROM vouchercodes where IdBusinessDetail=" & vRestaurantId & " and vouchercode='" & objRds("Vouchercode") & "'", objCon, 1, 3 

        If Not IsNull(objRdsV("minimumamount"))  AND objRdsV("minimumamount") & "" <> "" Then
            if Cdbl( objRdsV("minimumamount")) > vSubTotal Then
                 objRds("vouchercodediscount") = 0
                 objRds("Vouchercode")  = "" 
                 dim RS_OrderItem : set  RS_OrderItem = Server.CreateObject("ADODB.Recordset")
                         RS_OrderItem.Open "Select Sum(Total) As Total from [orderitemslocal]  " & _
                        " Where OrderId = " & vOrderId & " And MenuItemPropertyId Is Null and  MenuItemId in (select Id from MenuItems where hidedish  = 1 )  ", objCon
                        if vSubTotal & "" <> "" and RS_OrderItem("Total") & "" <> "" then
                            vSubTotal  = CDbl(vSubTotal) - CDbl(RS_OrderItem("Total") )
                        end if
                        RS_OrderItem.close()
                    set RS_OrderItem = nothing
                        objCon.execute(" delete from [orderitemslocal] WHERE OrderId = " & vOrderId & " And MenuItemPropertyId Is Null and  MenuItemId in (select Id from MenuItems where hidedish  = 1 ) ")

            Else
                discountcodeused= "-" & objRds("vouchercodediscount") & "%"
	            vSubTotal=vSubTotal-((vSubTotal/100)*objRds("vouchercodediscount"))
                vouchercodediscount = objRds("vouchercodediscount")  
            End If             
        End if
	    objRdsV.Close
        set objRdsV = nothing
	end if
    objRds("SubTotal") = vSubTotal
    objRds.Update 
    
    objRds.Close
   ' objCon.Close 

End If

'objCon.Open sConnString
objRds.Open "select oi.*," & _
        "mi.Name, mip.Name as PropertyName " & _
        "from ( orderitemslocal oi " & _
        "inner join MenuItems mi on oi.MenuItemId = mi.Id ) " & _
        "left join MenuItemProperties mip on oi.MenuItemPropertyId = mip.Id " & _
        "where oi.OrderId = " & vOrderId & " order by oi.ID desc " , objCon

if objRds.Eof then %>
    
    No Items In Your Order.
	
	<script>

$( "#shoppingcart2" ).text( "0" );
$( "#butcontinue" ).hide();
</script>

<% 
    objRds.Close
   ' objCon.Close

else %>
    <div id="divShoppingCartSroll" class="shoppingCartScroll">
    <table style="width: 100%">  

    <%
        Do While NOT objRds.Eof  %>
                <tr>
                     <td style="padding:5px 0 5px 5px;"><button type="button" class="btn" onclick="Del(<%= objRds("Id") %>)" >X</button></td>
                    <td>  <%If objRds("Qta") > 1 Then %> 
                            (x <%= objRds("Qta") %>)
                        <% End If %>
                        <%= objRds("Name") %>&nbsp;<%= objRds("PropertyName") %>                    
                      
						<%
						'display toppings in basket area
						If objRds("dishpropertiesids") <> "" Then
						 
						dishpropertiessplit=split(objRds("dishpropertiesids"),",")
					for i=0 to ubound(dishpropertiessplit)
					
					dishpropertiessplit2=split(dishpropertiessplit(i),"|")
					if dishpropertiessplit2(1)<>0 then
					'Set objCon_dishpropertiesprice = Server.CreateObject("ADODB.Connection")
					Set objRds_dishpropertiesprice = Server.CreateObject("ADODB.Recordset") 
					
					'objCon_dishpropertiesprice.Open sConnString
	                objRds_dishpropertiesprice.Open "SELECT MenuDishproperties.ID, MenuDishproperties.dishproperty, MenuDishproperties.dishpropertyprice, MenuDishpropertiesGroups.dishpropertypricetype, MenuDishpropertiesGroups.dishpropertygroup FROM MenuDishproperties INNER JOIN MenuDishpropertiesGroups ON MenuDishproperties.dishpropertygroupid = MenuDishpropertiesGroups.ID where (((MenuDishproperties.ID)=" & dishpropertiessplit2(1)  & "))", objCon

					response.write "<BR> <small>" & objRds_dishpropertiesprice("dishpropertygroup") & ":" & objRds_dishpropertiesprice("dishproperty") & "</small>"
					
					end if
					
					next
					end if%>
						 
						 <%
						'display dish properties in basket area
						toppingtext=""
						If objRds("toppingids") <> "" Then 
						'Set objCon_toppingids = Server.CreateObject("ADODB.Connection")
								Set objRds_toppingids = Server.CreateObject("ADODB.Recordset") 
          
				 Dim SQLTopping 
                Dim toppinggroup : toppinggroup  =""
                    SQLTopping = "SELECT m.topping,isnull(mp.toppingsgroup,'') as toppingsgroup FROM MenuToppings m "
                    SQLTopping =SQLTopping & "  left join Menutoppingsgroups mp on  m.toppinggroupid = mp.ID"
                    SQLTopping =SQLTopping & "    where m.id in ("& objRds("toppingids") &")"
                objRds_toppingids.Open SQLTopping, objCon
				toppingtext=""
				Do While NOT objRds_toppingids.Eof 
						     toppingtext = toppingtext & objRds_toppingids("topping") & ", "
                             toppinggroup = objRds_toppingids("toppingsgroup")
						objRds_toppingids.MoveNext
						loop
						if toppingtext<>"" then
                             if toppinggroup & "" = "" then
                                toppinggroup = "Toppings"
                            end if
							toppingtext=left(toppingtext,len(toppingtext)-2)
						response.write "<small><br>"&toppinggroup&": " & toppingtext & "</small>"
						end if
						 End If %>
						 
                    </td>
                    <td><%=CURRENCYSYMBOL%><%= FormatNumber(objRds("Total"), 2) %></td>
                   
                </tr>
        <%  
            objRds.MoveNext
        Loop 
    
        objRds.Close
        'objCon.Close
        %>
     
         </table>
        </div>
        <table style="width: 100%">
     
		<%if discountcodeused<>"" then%>
		<tr>
            <td style="padding-top: 5px; border-top: 1px dotted black;"><b>Voucher</b>
             <br /> <%=vouchercode %> (<%=discountcodeused%>) 
            </td>
            <td style="padding-top: 5px; border-top: 1px dotted black;">
			
			
			<span id="subtotal">-<%=CURRENCYSYMBOL%><%= FormatNumber((( vSubTotal * 100 )/(100- vouchercodediscount) - vSubTotal ),2) %>   </span></td>
            <td style="padding-top: 5px; border-top: 1px dotted black;">&nbsp;</td>
        </tr>
		<%end if%>
		
		
		<% 
		
		
		If vdeliverytype <> "d" Then
            vOrderShipTotal = 0
        elseIf vdeliveryDistance <> "" and sDeliveryFreeDistance<>0 Then
            dim UserDistance
            UserDistance = cdbl(vdeliveryDistance)
            If UserDistance <= sDeliveryFreeDistance Then vOrderShipTotal = 0                              
        end if

		if vSubTotal >sDeliveryChargeOverrideByOrderValue then
	
			vOrderShipTotal = 0
		end if

       %>
	     <tr>
            <td style="padding-top: 5px; border-top: 1px dotted black;font-size:11px;width:173px;">Subtotal</td>
            <td style="padding-top: 5px; border-top: 1px dotted black;">
			
			
			<span id="subtotal" style="font-size:11px;"><%=CURRENCYSYMBOL%><%= FormatNumber(vSubTotal, 2)  %></span></td>
            <td style="padding-top: 5px; border-top: 1px dotted black;">&nbsp;</td>
        </tr> 
        
		<!--  <tr>
            <td style="padding-top: 5px; border-top: 1px dotted black;font-size:11px;">Delivery</td>
            <td style="padding-top: 5px; border-top: 1px dotted black;">
			
			
			<span id="subtotal" style="font-size:11px;"><%=CURRENCYSYMBOL%><%= FormatNumber(vOrderShipTotal, 2)  %></span></td>
            <td style="padding-top: 5px; border-top: 1px dotted black;">&nbsp;</td>
        </tr> -->
		
         <tr>
            <td style="padding-top: 5px; border-top: 1px dotted black;"><b>Total</b></td>
            <td style="padding-top: 5px; border-top: 1px dotted black;">
			
			
			<span id="subtotal"><strong><%=CURRENCYSYMBOL%><%= FormatNumber(vSubTotal + vOrderShipTotal, 2)  %></strong></span></td>
            <td style="padding-top: 5px; border-top: 1px dotted black;">&nbsp;</td>
        </tr>   
		<tr>
            <td style="padding-top: 5px; border-top: 1px dotted black;"></td>
            <td style="padding-top: 5px; border-top: 1px dotted black;"></td>
			
			
			
            <td style="padding-top: 5px; border-top: 1px dotted black;"></td>
        </tr>    

    </table>   
	
	 <button type="button" class="btn btn-silver btn-xs btn-block" id="specialshow"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> Special Instructions</button>
	<button type="button" class="btn btn-silver btn-xs btn-block" id="specialhide" style="display:none;"><span class="glyphicon glyphicon-minus" aria-hidden="true"></span> Close</button>
	
	<div class="control-group" style="display:none;" id="specialbox">
                   
                    <div class="controls">
                        <textarea id="Specialinput" name="Specialinput" rows="4" class="form-control" ></textarea>
                    </div>
                </div>
	
    <div id="divVoucherCode" style="padding-top:15px;">
     <button type="button" class="btn btn-xs btn-block" id="vouchercodeshow" style="background-color:#eeeeee;color:#7d7c7c  ;"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> Add Voucher Code</button>
	<button type="button" class="btn  btn-xs btn-block" id="vouchercodehide"  style="display:none;background-color: #eeeeee;color:#7d7c7c  ;"><span class="glyphicon glyphicon-minus" aria-hidden="true"></span> Close</button>
	
    <div class="panel panel-default" style="display:none;" id="divVoucherCode1" >
  <!--<div class="panel-heading"  >
          <h3 class="panel-title" style="font-size:15px;">Voucher code</h3>
  </div>-->
        <div class="panel-body">           
                        
						
						
						<div class="row">
  <div class="col-xs-7">
  
    <label class="sr-only" for="vouchercode">Enter code</label>
    <input type="text" class="form-control noSubmit" id="vouchercode" name="vouchercode" placeholder="Enter code">
  </div> <div class="col-xs-3">
  
   
  
   <button  class="btn btn-default" onclick="VoucherCode();">Submit</button>
 </div>
 
 <div class="col-xs-1">&nbsp;</div>
 
              
                    </div>
    </div>
    <div id="divVoucherCodeAlert" style="margin: 1px auto;text-align: center;color:red;"> </div>
 </div>
        </div>
    <input type="hidden" name="SubTotal" id="SubTotal" value="<%=vSubTotal %>" />
    
    <p class="text-centered">

        <div class="panel panel-default" >
        <div class="panel-heading"  >
          <h3 class="panel-title">Customer</h3>
        </div>
        <div class="panel-body">           
                        
						
						
						<div class="row">
  <div class="col-xs-12">
  
    <label class="sr-only" for="vouchercode">Enter code</label>
    <input type="text" class="form-control noSubmit" id="tablenumber" name="tablenumber" placeholder="Enter your Name or Table number">
  </div> 
 <div class="col-xs-1">&nbsp;</div>
 
              
                    </div>
    </div>
  </div>
       <div style="text-align:center;"> <button type="button" onclick="CheckOrder();" class="btn btn-success" style="width: 160px; padding: 8px">
        Checkout</button>
        <br>
		<br>
           </div>

    </p>
    
   
<script type="text/javascript">
     $("#vouchercodeshow").click(function(){
        $("#divVoucherCode1").show();
        $("#vouchercodeshow").hide();
        $("#vouchercodehide").show();
    });

    $("#vouchercodehide").click(function(){
        $("#divVoucherCode1").hide();
        $("#vouchercodeshow").show();
        $("#vouchercodehide").hide();
    });
function printOrder(){
    if($("#tablenumber").val() == "")
        {
            alert("Please enter table number to order!");
    $("#tablenumber").focus();
            return;
        }
        //openWin("../printers/print_local.asp?id_o=<%=vOrderId %>&id_r=<%=session("restaurantid") %>&table=" + $("#tablenumber").val());
    
      
        window.location.href = "Thanks.asp?id_o=<%=vOrderId %>&id_r=<%= session("restaurantid") %>&table=" + $("#tablenumber").val();
   


    }

 function openWin(url)
  {

    var myWindow=window.open(url,'','fullscreen=yes');
 


    
  }
$( "#shoppingcart2" ).text( "<%= FormatNumber(vSubTotal, 2)  %>" );
$( "#butcontinue" ).show();

$("#specialshow").click(function(){
    $("#specialbox").show();
	$("#specialshow").hide();
	$("#specialhide").show();
});

$("#specialhide").click(function(){
    $("#specialbox").hide();
	$("#specialshow").show();
	$("#specialhide").hide();
});

$('#Specialinput').bind('input propertychange', function() {

      

      if(this.value.length){
       $.cookie("Specialinput", this.value,{ path: "/" }); 
      }
	  

});

$("textarea#Specialinput").val($.cookie("Specialinput"));

//  if( getCookie("TableNumber") != ''){
//        $("#tablenumber").val(getCookie('TableNumber'));
//    }

    $('#tablenumber').bind('input propertychange', function() {
      if(this.value.length){
      // $.cookie("TableNumber", this.value); 
      //  debugger
       setCookie("TableNumber",this.value,15);   
      }
    });

    $("input#tablenumber").val(getCookie("TableNumber"));


   if( $(window).width() < 992) { 

   $("#divShoppingCartSroll").removeClass("shoppingCartScroll");
    }
   


</script>
<%
End If
    set objRds = nothing
    objCon.close()
    set objCon = nothing
          %>       

