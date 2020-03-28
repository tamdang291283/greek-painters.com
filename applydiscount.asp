<% if session("restaurantid") & "" = "" Then
    session("restaurantid")=Request.QueryString("id_r")
        
    End If %>
<!-- #include file="Config.asp" -->
<!-- #include file="timezone.asp" -->
<!-- #include file="restaurantsettings.asp" -->

<%
    
Set objCon = Server.CreateObject("ADODB.Connection")
Set objRds = Server.CreateObject("ADODB.Recordset")   
    function ShippingFee(byval DistanceMile,byval UserDistance, byval DeliveryFeev, byval freeDistnace,byval DeliveryCostUpTo, byval DeliveryUptoMile)
   
            Dim Ratio,numbermod  
            Dim Result : Result = 0
          '  Response.Write("DeliveryFeev " & DeliveryFeev & " DistanceMile " & DistanceMile & " UserDistance " & UserDistance & " freeDistnace " & freeDistnace & "<br/>")
            if UserDistance & "" = "" then
                    UserDistance = 0
            end if
             ' Response.Write("UserDistance " & UserDistance & " freeDistnace " & freeDistnace & "<br/>")
            if cdbl(UserDistance) <= cdbl(freeDistnace) and cdbl(freeDistnace) > 0 then
                Result = 0
            elseif ( DistanceMile & "" <> "" and DistanceMile & "" <> "0")  or (cdbl(DeliveryCostUpTo) > 0 and   cdbl(DeliveryUptoMile) > 0)  then
               
                'UserDistance =cdbl( UserDistance) - cdbl(freeDistnace)
                UserDistance =cdbl( UserDistance)
                dim DeliveryExtraCost : DeliveryExtraCost = 0
                if  cdbl( DeliveryCostUpTo) > 0 and  cdbl( DeliveryUptoMile) > 0 then
                    if cdbl( UserDistance) > cdbl(DeliveryUptoMile) then
                        UserDistance =cdbl( UserDistance) - cdbl(DeliveryUptoMile)
                        DeliveryExtraCost = cdbl(DeliveryCostUpTo)
                    else
                        UserDistance = 0
                        DeliveryExtraCost = cdbl(DeliveryCostUpTo)
                    end if

                end if  
        
                DistanceMile = cdbl(DistanceMile)
                if (UserDistance * 100) mod (DistanceMile * 100) > 0  then
                    Ratio = 1 + ( UserDistance * 100 - ((UserDistance * 100) mod (DistanceMile * 100))) / (DistanceMile * 100 )
                else
                    Ratio = ( UserDistance * 100 ) / (DistanceMile * 100)
                end if
                      
                  Result = Ratio * DeliveryFeev + DeliveryExtraCost
  
                       ' Response.End
            else
                   Result = distancefee
            end if
            'Response.Write("Result " & Result & "<br/>")
            ShippingFee = Result

    end function 

function HaveDiscount(byval OrderID,byval listID,byval mode)
dim result : result =  true
if lcase( mode & "") = "dishes" or lcase(mode & "") = "categories"  then
        if ( lcase( mode & "") = "dishes" and listID & "" = "" ) or (lcase( mode & "") = "categories" and listID & "" = "") then
            result =  false
        else
            result = false
            dim SQL : SQL = "" 
                SQL = "select  MenuItemId,Total,IdMenuCategory from  OrderItems oi with(nolock)   " 
			    SQL= SQL & "  join MenuItems mi with(nolock) on oi.MenuItemId = mi.id "
			    SQL= SQL & " where oi.orderid  = " & orderID
                    dim RS_OrderTotal : set RS_OrderTotal = Server.CreateObject("ADODB.Recordset")
                        RS_OrderTotal.Open SQL , objCon
                    while not RS_OrderTotal.EOF
                    if lcase(mode) = "dishes" then        
                        if  instr("," & ListID,"," &  RS_OrderTotal("MenuItemId") & ",") > 0 then                            
                            result =  true                                           
                        end if
                    elseif lcase(mode) = "categories" then
                            if  instr("," & ListID,RS_OrderTotal("IdMenuCategory")) > 0 then
                                result =  true                     
                        end if
                    end if
                    RS_OrderTotal.movenext()
                wend
                    RS_OrderTotal.close()
                    set RS_OrderTotal = nothing   
        end if
end if
    HaveDiscount = result
end function    
     
function CalculateSubtotalWithDiscount( byval orderID, byval discountvalue,byval VoucherMainType, byval ListID)
    dim result : result = 0
       
    if ( VoucherMainType = "Dishes" or VoucherMainType ="Categories" )  then
            result = 0 
        dim SQL : SQL = "" 
            SQL = "select  MenuItemId,Total,IdMenuCategory from  OrderItems oi with(nolock)   " 
			SQL= SQL & "  join MenuItems mi with(nolock) on oi.MenuItemId = mi.id "
			SQL= SQL & " where oi.orderid  = " & orderID
            '   Response.Write(SQL & " ListID " & ListID  )
            '   Response.End
            
            dim RS_OrderTotal : set RS_OrderTotal = Server.CreateObject("ADODB.Recordset")
            RS_OrderTotal.Open SQL , objCon
            while not RS_OrderTotal.EOF
                if VoucherMainType = "Dishes" then
        
                    if  instr("," & ListID,"," &  RS_OrderTotal("MenuItemId") & ",") > 0 then                            
                            result = result +  0.01 * cdbl(RS_OrderTotal("Total")) *  discountvalue    
                                        
                    end if
                elseif VoucherMainType = "Categories" then
                        if  instr("," & ListID,RS_OrderTotal("IdMenuCategory")) > 0 then
                            result = result + 0.01*  cdbl(RS_OrderTotal("Total")) *  discountvalue 
                               
                    end if
                end if
                RS_OrderTotal.movenext()
            wend
                RS_OrderTotal.close()
                set RS_OrderTotal = nothing   
    end if
    CalculateSubtotalWithDiscount =   result
end function 
          

dim vRestaurantId
Dim sIsOpen
Dim sDayOfWeek
Dim sDate
Dim sHour

    dim     DateCondition : DateCondition = cdate(DateAdd("h",houroffset,now))
            DateCondition = DatePart("m", DateCondition)&"/"&DatePart("d", DateCondition)&_
                            "/"&DatePart("yyyy", DateCondition)&" "&DatePart("h", DateCondition)&":"&_
                            DatePart("n", DateCondition)&":" & DatePart("s", DateCondition)


dim discountValueDisCat     : discountValueDisCat  = -1       
    sDayOfWeek = DatePart("w", DateAdd("h",houroffset,now), vbMonday, 1)
    sDate = FormatISODate(DateAdd("h",houroffset,now))
    sHour = CDate(FormatDateTime(DateAdd("h",houroffset,now), vbShortTime))
    vRestaurantId = Request.QueryString("id_r")
    vouchercode = Request.QueryString("vouchercode")
    objCon.Open sConnString

    Dim vOperator
    Dim vMenuItemId
    dim vMenuItemPrice
    Dim vMenuItemPropertyId  
    Dim IncludeDishes_Categories : IncludeDishes_Categories  = ""
    Dim IncludeDelivery_Collection : IncludeDelivery_Collection = ""
    Dim ListIncludeID  : ListIncludeID = ""
    dim VoucherDiscontType  : VoucherDiscontType = ""
      Dim vSubTotal
      Dim vOrderId : vOrderId = Request.QueryString("o")
      Dim vdeliverytype 
      Dim vOrderShipTotal
   
      
      Dim Tax_Rate,Tip_Rate        
      dim TaxAmount : TaxAmount = 0
      dim TipAmount : TipAmount = 0 
      dim serviceChargeAmount : serviceChargeAmount = 0
      dim orderTotalAmount : orderTotalAmount  = 0 
  

Set objRds = Server.CreateObject("ADODB.Recordset") 
 
    objRds.Open "select Id,SubTotal,deliverytype,deliveryDistance,ServiceCharge,ShippingFee,Tax_Rate,Tip_Rate,Tip_Amount,Tax_Amount from [Orders] o with(nolock)  " & _
            " Where o.IdBusinessDetail = " & vRestaurantId & _
            " And o.ID = " & vOrderId , objCon
  
If Not objRds.Eof Then
    vOrderId = objRds("Id")
    vSubTotal = cdbl(objRds("SubTotal"))
	vdeliverytype = objRds("deliverytype")
	vdeliveryDistance = objRds("deliveryDistance")
    serviceChargeAmount = objRds("ServiceCharge")
    vOrderShipTotal = objRds("ShippingFee")
    TaxAmount = objRds("Tax_Amount")
    TipAmount = objRds("Tip_Amount")
    Tax_Rate = objRds("Tax_Rate")
    Tip_Rate = objRds("Tip_Rate")
Else
    vOrderId =  ""
End if
    

    objRds.Close
set objRds = nothing
    if vOrderId = "" then
       Response.End
    end if
        
        dim sqlDelete : sqlDelete = ""               
            sqlDelete =  " delete from [OrderItems] WHERE OrderId = " & vOrderId & " And MenuItemPropertyId Is Null and  MenuItemId in (select Id from MenuItems where hidedish  = 1 ) "
            objCon.execute(sqlDelete)
			    validvouchercode=0
                voucherminimumamount = 0
             Set objRds = Server.CreateObject("ADODB.Recordset") 
       
          	    objRds.Open "SELECT *, convert(varchar(10), startdate, 105) as StartDateF, convert(varchar(10), enddate, 105)   as enddatef,isnull(applyto,'both') as applyto,isnull(ListID,'') as ListID,isnull(IncludeDishes_Categories,'') as IncludeDishes_Categories,isnull(IncludeDelivery_Collection,'') as IncludeDelivery_Collection  FROM vouchercodes with(nolock)  where IdBusinessDetail=" & vRestaurantId & " and vouchercode='" & vouchercode & "' ", objCon, 1, 3 
            	if not objRds.EOF then
                    VoucherDiscontType = objRds("VoucherMainType")
                     if  lcase(objRds("applyto")& "") = "local" then
                            validvouchercode = 2
                     end if
                            IncludeDelivery_Collection =  objRds("IncludeDelivery_Collection")
                            if IncludeDelivery_Collection & "" = ""  then
                                IncludeDelivery_Collection = "both"
                            end if
                            if IncludeDelivery_Collection = "Delivery"  then
                                IncludeDelivery_Collection  ="d"
                            end if
                            if IncludeDelivery_Collection = "Collection"  then
                                IncludeDelivery_Collection  ="c"
                            end if
                            ListIncludeID = objRds("ListID")
                            IncludeDishes_Categories = objRds("IncludeDishes_Categories")
               if IncludeDelivery_Collection & "" <> "both" and  trim(IncludeDelivery_Collection & "") & ""  <> vdeliverytype & "" and validvouchercode  <> 2   then                   
                    validvouchercode = 5
               end if

               if validvouchercode  <> 2 and  validvouchercode <> 5 then 
			           if objRds("MenuItemID")& "" <> "" and  objRds("MenuItemID")& "" <> "0" then
                                vouchertype = "product"
                               vMenuItemId = objRds("MenuItemID")
                               dim objRds1 : set objRds1 = Server.CreateObject("ADODB.Recordset")
                                dim SQL
                                    SQL = "SELECT Price FROM MenuItems mi    WHERE mi.Id = " & vMenuItemId
                                objRds1.Open SQL , objCon
                                If Not objRds1.Eof Then 
                                    vMenuItemPrice = objRds1("Price")
                                end if                                
                                objRds1.Close
                                set objRds1 = nothing                           
                        end if                                          
                        If objRds("vouchertype")="once" Then
                            validvouchercode=1
			                vouchercodediscount=objRds("vouchercodediscount")
                            If Not IsNull(objRds("minimumamount"))  AND objRds("minimumamount") & "" <> "" Then
                                voucherminimumamount = objRds("minimumamount")
                            End if
                        elseif objRds("vouchertype")="date"   then
                            If  DateDiff("d", objRds("StartDateF"), date())>= 0 and DateDiff("d",date(), objRds("enddatef"))>= 0 Then
			                    validvouchercode=1
			                    vouchercodediscount=objRds("vouchercodediscount") 
                        
                                If Not IsNull(objRds("minimumamount"))  AND objRds("minimumamount") & "" <> "" Then
                                    voucherminimumamount = objRds("minimumamount")
                                End if
                            End If
			            end if
                end if
			end if
			objRds.Close
            set objRds = nothing
    
            if Cdbl(voucherminimumamount) > 0 AND validvouchercode Then
                set objRds = Server.CreateObject("ADODB.Recordset")         

                objRds.Open "Select Sum(Total) As Total from OrderItems with(nolock)   " & _
                        " Where OrderId = " & vOrderId, objCon
                If Not objRds.Eof and Not IsNull(objRds("Total")) Then
                    vtemsubtotal = cdbl(objRds("Total"))
                Else
                    vtemsubtotal  = 0
                End if
    
                objRds.Close
                set objRds = nothing
                If vtemsubtotal < Cdbl(voucherminimumamount) Then
                    validvouchercode = 0
                End If
            End if

               dim havediscountproduct 
               if validvouchercode = 1 then 
                     havediscountproduct =  HaveDiscount(vOrderId,ListIncludeID,IncludeDishes_Categories)                      
                  if havediscountproduct = false then                      
                        if IncludeDishes_Categories & "" = "Dishes" then
                            validvouchercode = 3
                        else
                            validvouchercode = 4
                        end if                          
                  end if  
              end if

    %>
    <tr style="display:none;"><td colspan="2">   
<%
			  if validvouchercode=1 then   
                                   
                  if vouchertype = "product" then                      
                     if havediscountproduct = true then
                        dim objRdsUpdate : set objRdsUpdate = Server.CreateObject("ADODB.Recordset")
                            sql= "SELECT * FROM [OrderItems]   WHERE OrderId = " & vOrderId & " And MenuItemId = " &  vMenuItemId & " And MenuItemPropertyId Is Null"
                          
                        objRdsUpdate.Open sql, objCon, 2, 3 
                         If objRdsUpdate.BOF AND objRdsUpdate.EOF Then
                            objRdsUpdate.AddNew
                            objRdsUpdate("OrderId") = vOrderId
                            objRdsUpdate("MenuItemId") = vMenuItemId
				            objRdsUpdate("toppingids") = toppingids
				            objRdsUpdate("dishpropertiesids") = dishpropertiesids
                            objRdsUpdate("Price") = vMenuItemPrice
                            objRdsUpdate("Total") = vMenuItemPrice    
                            objRdsUpdate("Qta") = 1
                        End If 
                        objRdsUpdate.Update     
                        objRdsUpdate.close()
                        set objRdsUpdate = nothing
                     end if
                  end if
                 
                       
                   if validvouchercode  = 1 then
			          set objRds = Server.CreateObject("ADODB.Recordset")
			          objRds.Open "SELECT * FROM orders   where id=" & vOrderId, objCon, 1, 3    			
			          objRds("vouchercode") = vouchercode
			          objRds("vouchercodediscount") = vouchercodediscount
                      objRds("DiscountType") = VoucherDiscontType
    		          objRds.Update
			          objRds.Close
                      set objRds = nothing
                  end if
            %>
              <script>
                    $("#divVoucherCodeAlert").html("");
                </script>
            <%
            elseif validvouchercode = 5 then
            %>
                <script>
                    <%  if vdeliverytype & "" = "d"  then %>
                        $("#divVoucherCodeAlert").html("The voucher used does not apply to Delivery.  Please use another one.");  
                    <%else %>
                        $("#divVoucherCodeAlert").html("The voucher used does not apply to Collection.  Please use another one.");  
                    <% end if %>             
                </script>
            <%
            elseif validvouchercode = 2 then
                %>
                  <script>
                    $("#divVoucherCodeAlert").html("This voucher is for in-store use only.");
                </script>
                <%
            elseif validvouchercode = 3 then
                    %>
                     <script>
                    $("#divVoucherCodeAlert").html("This voucher cannot be applied.");
                </script>
                    <%
            elseif validvouchercode = 4 then
                    %>
                    <script>
                        $("#divVoucherCodeAlert").html("This voucher cannot be applied.");
                    </script> 
                    <%
            elseif vtemsubtotal < Cdbl(voucherminimumamount) AND Cdbl(voucherminimumamount)  > 0 Then
                %>
                <script>
                    $("#divVoucherCodeAlert").html("The order must be at least <%=CURRENCYSYMBOL%><%= FormatNumber(voucherminimumamount, 2) %> to apply this voucher code!");
                </script>
            <%
            else 'voucher code not valid 
            %>
                <script>
                    $("#divVoucherCodeAlert").html("Invalid Voucher Code");
                </script>
            <%
			end if
            %>
                </td></tr> 
            <%    
            ' Calculate Sub total
                 set    objRds = Server.CreateObject("ADODB.Recordset")
                    
                       
                        objRds.Open "Select Sum(Total) As Total from [OrderItems]  with(nolock)  " & _
                            " Where OrderId = " & vOrderId, objCon   
                    If Not objRds.Eof and Not IsNull(objRds("Total")) Then
                        vSubTotal = cdbl(objRds("Total"))
                    Else
                        vSubTotal  = 0
                    End if
    
                        objRds.Close
                        set objRds = nothing

           
            
            
           
            set objRds = Server.CreateObject("ADODB.Recordset")
                objRds.Open "SELECT * FROM [Orders]  WHERE Id = " & vOrderId, objCon, 1, 3 
	            discountcodeused=""
                vouchercodediscount = 0
             
            if not objRds.eof then
	                if ( objRds("vouchercodediscount") & "" <> "" and   objRds("vouchercodediscount") <> 0) or objRds("Vouchercode") & "" <> ""  then
                
	                    Dim objRdsV
                        Set objRdsV = Server.CreateObject("ADODB.Recordset") 
                        objRdsV.Open "SELECT *,convert(varchar(10), startdate, 105)   as StartDateF, convert(varchar(10), enddate, 105)   as enddatef FROM vouchercodes   where IdBusinessDetail=" & vRestaurantId & " and vouchercode='" & objRds("Vouchercode") & "'", objCon, 1, 3 
                        IncludeDelivery_Collection = objRdsV("IncludeDelivery_Collection")& ""
                        
                        If Not IsNull(objRdsV("minimumamount"))  AND objRdsV("minimumamount") & "" <> ""  Then
                            if Cdbl( objRdsV("minimumamount")) > vSubTotal or HaveDiscount(vOrderId,objRdsV("ListID") & "" ,objRdsV("IncludeDishes_Categories") & "" ) = false Then
                                 IncludeDelivery_Collection = ""
                                 objRds("vouchercodediscount") = 0
                                 objRds("Vouchercode")  = "" 
                                 objRdsV("DiscountType") = ""
                                  dim RS_OrderItem : set  RS_OrderItem = Server.CreateObject("ADODB.Recordset")
                                 RS_OrderItem.Open "Select Sum(Total) As Total from [OrderItems]     " & _
                                " Where OrderId = " & vOrderId & " And MenuItemPropertyId Is Null and  MenuItemId in (select Id from MenuItems   where hidedish  = 1 )  ", objCon
                                   if vSubTotal & "" <> "" and RS_OrderItem("Total")  & "" <> "" then
                                        vSubTotal  = CDbl(vSubTotal) - CDbl(RS_OrderItem("Total") )
                                   end if
                                RS_OrderItem.close()
                            set RS_OrderItem = nothing
                                objCon.execute(" delete from [OrderItems]  WHERE OrderId = " & vOrderId & " And MenuItemPropertyId Is Null and  MenuItemId in (select Id from MenuItems where hidedish  = 1 ) ")
                            Else
                                 vouchercode = objRds("Vouchercode")
                          
                             
                                        ListIncludeID = objRdsV("ListID")
                                        IncludeDishes_Categories = objRdsV("IncludeDishes_Categories")
                                      
                                if VoucherDiscontType = "Amount" then
                                       vSubTotal=vSubTotal - objRds("vouchercodediscount") 
                                else
                                         if (IncludeDishes_Categories = "Dishes" or IncludeDishes_Categories = "Categories") and ListIncludeID & "" <> ""  then
                                                discountValueDisCat  = CalculateSubtotalWithDiscount(vOrderId,objRds("vouchercodediscount"),IncludeDishes_Categories,ListIncludeID)                             
                                                vSubTotal = vSubTotal - discountValueDisCat
                                         else                                   
                                                vSubTotal=vSubTotal-((vSubTotal/100)*objRds("vouchercodediscount"))                                 
                                         end if
                                 end if
                                 discountcodeused= "-" & objRds("vouchercodediscount") & "%"
	                            ' vSubTotal=vSubTotal-((vSubTotal/100)*objRds("vouchercodediscount"))
                                 vouchercodediscount = objRds("vouchercodediscount")  
                                 VoucherDiscontType = objRds("DiscountType")  
                            End If             
                        End if
	                    objRdsV.Close
                        set objRdsV = nothing
	                end if
                    If ServiceChargePercentage & "" <> "" AND ServiceChargePercentage & "" <> "0"  Then
                        objRds("ServiceCharge")  = (Cdbl(ServiceChargePercentage)*0.01*CDbl(vSubTotal))       
                        serviceChargeAmount =      (Cdbl(ServiceChargePercentage)*0.01*CDbl(vSubTotal))                   
                    Else
                        objRds("ServiceCharge") = 0
                        serviceChargeAmount =  0
                    End If
                    objRds("SubTotal") = vSubTotal
                    objRds.Update 
            end if
            objRds.Close
            set objRds = nothing

            If Tax_Percent & "" <> "" AND Tax_Percent & "" <> "0" AND InRestaurantTaxChargeOnly = "0" Then
                TaxAmount  = (Cdbl(Tax_Percent)*0.01*CDbl(vSubTotal + ShippingFee))                
            Else
                TaxAmount = 0                
            End If

            If Tip_percent & "" <> "" AND Tip_percent & "" <> "0" AND InRestaurantTipChargeOnly = "0" Then
                 if Tip_Rate & "" <> "custom" and Tip_Rate & ""  <> "" then
                    Tip_percent = Tip_Rate
                 end if
                if Tip_Rate & "" <> "custom"   then
                     TipAmount  = (Cdbl(Tip_Percent)*0.01*CDbl(vSubTotal ))                                       
                end if
            Else
                Tip_Amount = 0       
            End If

            orderTotalAmount = vSubTotal + vOrderShipTotal + round(serviceChargeAmount,2) + round(TaxAmount,2) + round(TipAmount,2)

function WriteCheck(byval value1, byval value2)
                dim result : result = "" 
                if value1 & "" = value2 & ""  then
                    result = "selected"
                end if
                WriteCheck = result
            end function
                             '    Response.Write("Tip_Rate " & Tip_Rate & "<br/>")
                       
        
                
                'objCon.Open sConnString
                Set objRds = Server.CreateObject("ADODB.Recordset") 
                objRds.Open "select oi.*," & _
                        "mi.Name, mip.Name as PropertyName " & _
                        "from ( OrderItems oi " & _
                        "inner join MenuItems mi on oi.MenuItemId = mi.Id ) " & _
                        "left join MenuItemProperties mip on oi.MenuItemPropertyId = mip.Id " & _
                        "where oi.OrderId = " & vOrderId, objCon


            if objRds.Eof then %>
    
                No Items In Your Order.

            <% 
                objRds.Close
                set objRds = nothing
                objCon.Close
                set objCon = nothing
                
            else %>

               
         

                      <%
                    Do While NOT objRds.Eof  %>
                            <tr>
                                <td><%If objRds("Qta") > 1 Then %> 
                            (x <%= objRds("Qta") %>)
                        <% End If %> <%= objRds("Name") %>&nbsp;<%= objRds("PropertyName") %> 
						
						<%
						'display toppings in basket area
						If objRds("dishpropertiesids") <> "" Then
						 
						        dishpropertiessplit=split(objRds("dishpropertiesids"),",")
					        for i=0 to ubound(dishpropertiessplit)					
					            dishpropertiessplit2=split(dishpropertiessplit(i),"|")
					            Set objRds_dishpropertiesprice = Server.CreateObject("ADODB.Recordset") 
	                                objRds_dishpropertiesprice.Open "SELECT MenuDishproperties.ID, MenuDishproperties.dishproperty, MenuDishproperties.dishpropertyprice, MenuDishpropertiesGroups.dishpropertypricetype, MenuDishpropertiesGroups.dishpropertygroup FROM MenuDishproperties   INNER JOIN MenuDishpropertiesGroups   ON MenuDishproperties.dishpropertygroupid = MenuDishpropertiesGroups.ID where (((MenuDishproperties.ID)=" & dishpropertiessplit2(1)  & "))", objCon
					            if not objRds_dishpropertiesprice.EOF then
					                response.write "<BR> <small>" & objRds_dishpropertiesprice("dishpropertygroup") & ":" & objRds_dishpropertiesprice("dishproperty") & "</small>"
                                end if
					            objRds_dishpropertiesprice.close()
                                set objRds_dishpropertiesprice =  nothing
					        next
					    end if%>
						<%
						toppingtext=""
						If objRds("toppingids") <> "" Then 						
					        Set objRds_toppingids = Server.CreateObject("ADODB.Recordset") 
                             Dim SQLTopping 
                             Dim toppinggroup : toppinggroup  =""
                                SQLTopping = "SELECT m.topping,isnull(mp.toppingsgroup,'') as toppingsgroup FROM MenuToppings m "
                                SQLTopping =SQLTopping & "  left join Menutoppingsgroups mp on  m.toppinggroupid = mp.ID"
                                SQLTopping =SQLTopping & "    where m.id in ("& objRds("toppingids") &")"
                            objRds_toppingids.Open SQLTopping, objCon
				            Do While NOT objRds_toppingids.Eof 
						            toppingtext = toppingtext & objRds_toppingids("topping") & ", "
                                    toppinggroup = objRds_toppingids("toppingsgroup")
						            objRds_toppingids.MoveNext
						    loop
                                objRds_toppingids.close()
                            set objRds_toppingids = nothing
						    if toppingtext<>"" then
                                if toppinggroup & "" = "" then
                                    toppinggroup = "Toppings"
                                  end if 
							    toppingtext=left(toppingtext,len(toppingtext)-2)
						        response.write "<small><br>"&toppinggroup&": " & toppingtext & "</small>"
						    end if
						 End If  %>
						</td>
                                <td style="padding-right: 20px; text-align: right;" valign="top"><%=CURRENCYSYMBOL%><%= FormatNumber(objRds("Total"), 2) %></td>                                    
                            </tr>
                    <%  
                        objRds.MoveNext        
                    Loop 
    
                            objRds.Close
                        set objRds = nothing
                          
                    %>
     
                         <tr>
                            <td style="padding-top: 5px">&nbsp;</td>
                            <td style="padding-top: 5px">&nbsp;</td>
                            <td style="padding-top: 5px">&nbsp;</td>
                        </tr>
						

							<%
      
                                dim discountValueDisCat1 : discountValueDisCat1 = -1
                                if discountcodeused <>"" then   
                                     if VoucherDiscontType & "" <> "Amount" then                                       
                                             Dim objRdsV1,ListIncludeID1,IncludeDishes_Categories1
                                            Set objRdsV1 = Server.CreateObject("ADODB.Recordset") 
                                                objRdsV1.Open "SELECT ListID,IncludeDishes_Categories FROM vouchercodes  with(nolock)  where IdBusinessDetail=" & vRestaurantId & " and vouchercode='" & vouchercode & "'", objCon, 1, 3 
                                            if not objRdsV1.eof then
                                                 ListIncludeID1 = objRdsV1("ListID")
                                                 IncludeDishes_Categories1 = objRdsV1("IncludeDishes_Categories")
                                            end if
                                             if (IncludeDishes_Categories1 = "Dishes" or IncludeDishes_Categories1 = "Categories") and ListIncludeID1 & "" <> ""  then
                                                    discountValueDisCat1  = CalculateSubtotalWithDiscount(vOrderId,abs(Replace(discountcodeused,"%","")),IncludeDishes_Categories1,ListIncludeID1)                         
                                             end if
                                                objRdsV1.close()
                                            set objRdsV1 = nothing
                                    end if
                         
                                %>
		                        <tr>
                                    <td style="padding-top: 5px; border-top: 1px dotted black;"><b>Voucher</b><br /><%=vouchercode %><%if  VoucherDiscontType & "" <> "Amount" then%>(<%=discountcodeused%>)<%end if %></td>
                                    <td style="padding-top: 5px; border-top: 1px dotted black;text-align: right;padding-right: 20px;">
			
			                        <% 
                                        if discountValueDisCat1 >= 0 then  %>
			                            <span id="voucher">-<%=CURRENCYSYMBOL%><%= FormatNumber(discountValueDisCat1,2) %> </span></td>
                                    <%else 
                                          if VoucherDiscontType & "" = "Amount" then
                                          %>
                                             <span id="voucher">-<%=CURRENCYSYMBOL%><%= FormatNumber(  Cdbl(Replace(Replace(Replace(discountcodeused,"-",""),"%","")," ","")) ,2) %> </span></td>
                                          <%
                                          else
                                            %>
                                             <span id="voucher">-<%=CURRENCYSYMBOL%><%= FormatNumber((( vSubTotal * 100 )/(100- Cdbl(Replace(Replace(Replace(discountcodeused,"-",""),"%","")," ",""))) - vSubTotal ),2) %> </span></td>
                                            <%
                                        end if
                                        %>
                                       
                                    <%end if %>
                                    <td style="padding-top: 5px; border-top: 1px dotted black;">&nbsp;</td>
                                </tr>
		                        <%end if%>
        

                         <tr>
                            <td style="padding-top: 5px; border-top: 1px dotted black;">SubTotal</td>
                            <td style="padding-top: 5px; padding-right: 20px; text-align: right; border-top: 1px dotted black;"><%=CURRENCYSYMBOL%><%= FormatNumber(vSubTotal, 2)  %>
                                <input type="hidden" id="subtotal" value="<%=vSubTotal %>"/>

                            </td>
                            <td style="padding-top: 5px; border-top: 1px dotted black;">&nbsp;</td>

                        </tr>       
                        
                        <% if CDbl(vOrderShipTotal) > 0 Then %>
                        <tr>
                            <td style="padding-top: 5px;">Delivery Fee</td>
                            <td style="padding-top: 5px; padding-right: 20px; text-align: right;"><%=CURRENCYSYMBOL%><%= FormatNumber(vOrderShipTotal, 2)  %></td>
                            <td style="padding-top: 5px;">&nbsp;</td>
                        </tr>       
                        <% End if 
                        If CDBl(serviceChargeAmount) > 0 Then
                            %>
                         <tr>
                            <td style="padding-top: 5px;">Service Charge</td>
                            <td style="padding-top: 5px; padding-right: 20px; text-align: right;"><%=CURRENCYSYMBOL%><%= FormatNumber(serviceChargeAmount, 2)  %></td>
                            <td style="padding-top: 5px;">&nbsp;</td>
                        </tr>       
                        <% End If %>
                        <% if cdbl(TaxAmount) > 0 then  %>
                            <tr>
                                <td style="padding-top: 5px;">Tax(<%=Tax_Percent %>%)</td>
                                <td style="padding-top: 5px; padding-right: 20px; text-align: right;"><%=CURRENCYSYMBOL%><%= FormatNumber(TaxAmount, 2)  %></td>
                                <td style="padding-top: 5px;">&nbsp;</td>
                            </tr>   
                        <% end if %>
                        <% if cdbl(TipAmount) > 0 then  %>
                            <tr>
                                <td style="padding-top: 5px;">Tip<select  id="tip_custom" style="display:none;margin-left:10px;width:80px;" onchange="ChangeTip(this);">
                                                                    <% 
                                                                         dim x
                                                                        for x = 1 to 25 
                                                                        if x mod 5 = 0 then
                                                                         %>
                                                                        <option <%=WriteCheck(x,Tip_Rate) %> value="<%=x %>" style="font-weight:bold"><%=x %>%</option>
                                                                        <% else %>
                                                                        <option <%=WriteCheck(x,Tip_Rate) %> value="<%=x %>"><%=x %>%</option>
                                                                        <% end if %>
                                                                     <%next %>       
                                                                   
                                                                    <option <%=WriteCheck("custom",Tip_Rate) %> value="custom">custom</option>
                                                                 </select>
                                    <% if Tip_Rate = "custom" then %>
                                     <input type="text" id ="tip_value" value="<%=FormatNumber(TipAmount, 2) %>" style="display:none;width:50px;"/>
                                    <%else %>
                                    <input type="text" readonly="readonly" id ="tip_value" value="<%=FormatNumber(TipAmount, 2) %>" style="display:none;width:70px;"/>
                                    <% end if %>

                                    <span style="text-decoration:underline;color:blue;cursor:pointer;" id="tip_edit" onclick="edit();">Edit</span>
                                    <span style="text-decoration:underline;color:blue;cursor:pointer;display:none;" id="tip_update" onclick="UpdateTip();">Update</span></td>
                                <td style="padding-top: 5px; padding-right: 20px; text-align: right;" id="lbTipmount"><%=CURRENCYSYMBOL%><%= FormatNumber(TipAmount, 2)  %></td>
                                <td style="padding-top: 5px;">&nbsp;</td>
                            </tr>   
                        <% end if %>
                        <tr>
                            <td style="padding-top: 5px;"><b>Total</b></td>
                            <td style="padding-top: 5px; padding-right: 20px; text-align: right;"><%=CURRENCYSYMBOL%><b id="ordertotal"><%= FormatNumber(orderTotalAmount, 2)  %></b></td>
                            <td style="padding-top: 5px;">&nbsp;</td>
                        </tr>    
                         
                        <tr>
                            <td colspan="3">&nbsp;
                                <script type="text/javascript">
                                    $("[name='amount']").val('<%=FormatNumber(orderTotalAmount, 2) %>');
                                    $("[name='vSubTotal']").val('<%=vSubTotal%>');
                                    $("#subtotal").val('<%=vSubTotal%>');
                                    
                                </script>

                            </td>    
                        </tr>
               
               <% end if %>

