
<% 
    
    Function Latitude_DMS (Lat)
      n = Sgn(Lat)
     ' sign = Trim(Mid("-  ", n + 2, 1))
    '  sign = Trim(Mid("- +", n + 2, 1))
      sign = Trim(Mid("S N", n + 2, 1))
      s = Abs(Lat) * 3600
      s = Int(s * 10000 + 0.5) / 10000
      m = Int(s / 60)
      d = Int(m / 60)
      m = m - d * 60
      s = s - m * 60 - d * 3600
      s = Int(s * 100  + 0.5) / 100
    'For leading - and/or + (adjust sign setting above)
      Latitude_DMS =   CStr(d) & "&deg;" & _
        CStr(m) & Chr(39) & Chr(32) & CStr(s) & Chr(34) & Chr(32) & sign
    'For trailing cardinal letter (adjust sign setting above)
    '  Latitude_DMS = CStr(d) & Chr(176) & Chr(32) & _
    '    CStr(m) & Chr(39) & Chr(32) & CStr(s) & Chr(34) & Chr(32) & sign
    End Function

    Function Longitude_DMS(Lng)
      n = Sgn(Lng)
     ' sign = LTrim(Mid("-  ", n + 2, 1))
    '  sign = LTrim(Mid("- +", n + 2, 1))
      sign = LTrim(Mid("W E", n + 2, 1))
      s = Abs(Lng) * 3600
      s = Int(s * 10000 + 0.5) / 10000
      m = Int(s / 60)
      d = Int(m / 60)
      m = m - d * 60
      s = s - m * 60 - d * 3600
      s = Int(s * 100  + 0.5) / 100
    'For leading - and/or + (adjust sign setting above)
      Longitude_DMS = CStr(d) & "&deg;" & _
        CStr(m) & Chr(39) & Chr(32) & CStr(s) & Chr(34) & Chr(32) & sign
    'For trailing cardinal letter (adjust sign setting above)
    '  Longitude_DMS = CStr(d) & Chr(176) & Chr(32) & _
    '    CStr(m) & Chr(39) & Chr(32) & CStr(s) & Chr(34) & Chr(32) & sign
    End Function 
    Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 

    Dim vRestaurantId
    dim vOrderId
     Dim sAverageDeliveryTime
    Dim sAverageCollectionTime

    if Request.QueryString("id_r") & "" <> "" then
             vRestaurantId = Request.QueryString("id_r")
    else
               vRestaurantId = Session("ResID") 
    end if
    if Request.QueryString("id_o") & "" <> "" then
        vOrderId = Request.QueryString("id_o")
    else
        vOrderId =  Session("OrderID")
    end if
   
    Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 
    objCon.Open sConnString
    objRds.Open "SELECT * FROM BusinessDetails WHERE Id = " & vRestaurantId, objCon 
    
    if Not IsNull(objRds("AverageDeliveryTime")) Then sAverageDeliveryTime = Cdbl(objRds("AverageDeliveryTime"))
    if Not IsNull(objRds("AverageCollectionTime")) Then sAverageCollectionTime = Cdbl(objRds("AverageCollectionTime"))  
	vaveragedel = objRds("AverageDeliveryTime")
	vaveragecol = objRds("AverageCollectionTime")
	bringgcompanyid=objRds("bringgcompanyid")
	bringgcompanyname=objRds("name")
	bringgcompanyaddress=objRds("address")
	bringgcompanytelephone=objRds("telephone")
	'session("restaurantid")=Request.QueryString("id_r")
 

%>
<!-- #include file="../restaurantsettings.asp" --> 
<% If UCase(Request.QueryString("notifyemail") & "") <> "Y" Then %>
 <div class="row">
        <div class="span12">
           <div align="center"> <h2 class="hero-unit">
			In-Store - Order <%=vOrderId%> </h2></div>
        </div>
    </div>
<% end if %>
 
    
        
    <%   
	name=objRds("Name")
	address= objRds("Address") 
	telephone=objRds("telephone") 
	email=  objRds("email") 
	 
	analyticsitems=""    
         
        objRds.Close
        'objCon.Close       
        
        ' objCon.Open sConnString
        objRds.Open "select * from [Orderslocal]  " & _
            "where Id = " & vOrderId, objCon

        dim vShippingFee
        dim vSubTotal
        dim vOrderTotal
		dim vdeliverytype
		
		'If objRds("DeliveryType") & ""  = "d" Then 
	'vdeliverytype="delivery"
	'Else
	vdeliverytype="collection"
	'End If 

        vShippingFee = objRds("ShippingFee")
        
        If vShippingFee & "" = "" Then
            vShippingFee = 0
        End If
        vSubTotal = objRds("SubTotal")
        vOrderTotal = objRds("OrderTotal")
		vvouchercodediscount = objRds("vouchercodediscount")
		vvouchercode=objRds("vouchercode")
        VoucherDiscontType = objRds("DiscountType")
         vnotes=objRds("notes")   
        PaymentSurcharge = objRds("PaymentSurcharge")
        If PaymentSurcharge & "" = "" Then
            PaymentSurcharge = 0
        End If
        ServiceCharge = objRds("ServiceCharge")
        If ServiceCharge & "" = "" Then
            ServiceCharge = 0
        End If
        dim TaxAmount,TipAmount
        TaxAmount = objRds("Tax_Amount")
        TipAmount = objRds("Tip_Amount")
        Dim TipRate : TipRate = objRds("Tip_Rate")
        if TipRate  & "" = "" then
            TipRate = "0"
        end if
        if TipRate & "" <> "custom" then
            TipRate =  TipRate & "%"
        end if
        if TaxAmount & "" = "" then
            TaxAmount = 0
        end if
        if TipAmount & "" = "" then
            TipAmount = 0
        end if
        
    %>
	<div style="width: 300px;margin-left:auto;margin-right:auto;margin-bottom:30px;">
        <div class="">
           <div class="">
               <div align="center">  <div align="center"> <img src="<%=SITE_URL %>/images/in-restaurant.png" style="vertical-align: middle;"> <span class="shop-name heading-size" style="border-bottom: 1px solid #e5e5e5;width: 100%;"><%if objRds("PaymentType")="Stripe-Paid" or objRds("PaymentType")="Paypal-Paid" or objRds("PaymentType")="NoChex-Paid" or objRds("PaymentType")="Worldpay-Paid" or Ucase(objRds("Payment_status") & "")="PAID"  then  %><b>ORDER PAID</b><%else%><b>ORDER UNPAID</b><%end if%></span>  </div> </div>
            </div>
        </div>
    </div>
	<% if 1=2 then %>
	   <div style="width: 300px;margin-left:auto;margin-right:auto;">
        <div class="">
           <div class="shop-info">
                <span class="shop-name"><b><%=name %></b></span><br />
                <span class="shop-address"><b><%=address%></b></span><br />
                <span class="shop-name">Tel. <%=telephone %></span><br />                       
                <span class="shop-address">Email: <%=email %></span><br /><br>
				
            </div>
        </div>
    </div>
	<% end if %>
	

    <div style="width: 300px; clear:both;margin-left:auto;margin-right:auto;">
       
          
			<div style="   display: block;width: 100%;padding: 0;margin-bottom: 3px;font-size: 21px; line-height: inherit;color: #333;border: 0; border-bottom: 1px solid #e5e5e5;">Customer</div>
			
				<% If request.QueryString("table") & "" <> "" Then 
                    Response.Write(request.QueryString("table"))
               Else %>
                    <%= objRds("FirstName") %>&nbsp;<%= objRds("LastName") %>
                 
                    <% if 1 = 2 then %>
                    <%= objRds("Address") %>,&nbsp;<%= objRds("PostalCode") %><br />
                    <%= objRds("Phone") %><br />
                    <%= objRds("Email") %>
                    <% end if %>
                    <% If objRds("DeliveryLat") & "" <> "" Then %>
                   <br>Lat/Long: <%= objRds("DeliveryLat") & "," & objRds("DeliveryLng")%>
                   <br>GPS: <%=Latitude_DMS(objRds("DeliveryLat")) & " ," & Longitude_DMS(objRds("DeliveryLng")) %>
                    <% End If %>
            <% end if %>
               
			  <br> 
   
    </div>
      <br>       
   <br> 

    


    <div style="width: 300px;margin-left:auto;margin-right:auto;">

            <div style="   display: block;width: 100%;padding: 0;margin-bottom: 3px;font-size: 21px; line-height: inherit;color: #333;border: 0; border-bottom: 1px solid #e5e5e5;">Order Details</div>
		    
				Order Number:&nbsp;<%=vOrderId%>


<br>
			
Order Time:&nbsp;<%response.write(formatDateTimeC(objRds("orderdate")))%>
<br >

    <% 
         
            dim paymentstatus 
         if objRds("PaymentType")="Stripe-Paid" or objRds("PaymentType")="Paypal-Paid" or objRds("PaymentType")="NoChex-Paid" or objRds("PaymentType")="Worldpay-Paid" or Ucase(objRds("Payment_status") & "")="PAID"  then
            paymentstatus = "ORDER PAID"
         else
            paymentstatus = "ORDER UNPAID"
         end if
          %>     
<div style="border-bottom: 1px solid #e5e5e5;width: 100%;">
Payment Status:&nbsp;<%=paymentstatus%>
</div>
<br>
<br>
    <%
	notes=objRds("notes")
    if notes & "" = "" And Request.Cookies("Specialinput") & "" <> "" Then
        notes = (Request.Cookies("Specialinput"))
      End if
        objRds.Close
       ' objCon.Close
     %>
        
			
        <%
             
          '  objCon.Open sConnString
            objRds.Open "select oi.*," & _
                    "mi.Name, mip.Name as PropertyName  ,  mi.PrintingName " & _
                    "from ( OrderItemslocal oi " & _
                    "inner join MenuItems mi on oi.MenuItemId = mi.Id ) " & _
                    "left join MenuItemProperties mip on oi.MenuItemPropertyId = mip.Id " & _
                    "where oi.OrderId = " & vOrderId, objCon

             
        if objRds.Eof then %>
    
            No Items In Your Order.

        <% 
            objRds.Close
            objCon.Close

        else
           Do While NOT objRds.Eof
            If objRds("PrintingName") & "" = "" Then
                isDualPrint = false
            End If                    
            objRds.MoveNext   
        Loop
        objRds.MoveFirst   
            
             %>

               
                <table style="width: 100%">  

                <%
                    Do While NOT objRds.Eof  
					analyticsitems = analyticsitems & vbCrLf & "ga('ecommerce:addItem', {'id': '" & vOrderId & "', 'name': '" & objRds("Name") &"','sku': '" & objRds("id") &"','price': '" & FormatNumber(clng(objRds("Total"))/clng(objRds("Qta")), 2) & "','quantity': '" & objRds("Qta") & "'});"
					%>
                            <tr>
                                <td><%If objRds("Qta") > 1 Then %> 
                             <%= objRds("Qta") %> X
                        <% End If %> <%= objRds("Name") %>&nbsp;<%= objRds("PropertyName") %> 
						
						<%
						'display toppings in basket area
						If objRds("dishpropertiesids") <> "" Then
						 
						    dishpropertiessplit=split(objRds("dishpropertiesids"),",")
					            for i=0 to ubound(dishpropertiessplit)
					                        dishpropertiessplit2=split(dishpropertiessplit(i),"|")
					                    Set objRds_dishpropertiesprice = Server.CreateObject("ADODB.Recordset") 					
	                                    objRds_dishpropertiesprice.Open "SELECT MenuDishproperties.ID, MenuDishproperties.dishproperty, MenuDishproperties.dishpropertyprice, MenuDishpropertiesGroups.dishpropertypricetype, MenuDishpropertiesGroups.dishpropertygroup FROM MenuDishproperties INNER JOIN MenuDishpropertiesGroups ON MenuDishproperties.dishpropertygroupid = MenuDishpropertiesGroups.ID where (((MenuDishproperties.ID)=" & dishpropertiessplit2(1)  & "))", objCon
                                        if not objRds_dishpropertiesprice.EOF then
					                        response.write "<BR> <small>" & objRds_dishpropertiesprice("dishpropertygroup") & ":" & objRds_dishpropertiesprice("dishproperty") & "</small>"
                                        end if
                                            objRds_dishpropertiesprice.close()
                                        set objRds_dishpropertiesprice = nothing
					            next
					    end if%>
						
						<%
                 
						toppingtext=""
						        If objRds("toppingids") <> "" Then 								        
                                    Dim SQLTopping 
                                        SQL = "  SELECT distinct a.toppinggroupid,ap.toppingsgroup FROM MenuToppings a with(nolock)  "
                                        SQL = SQL & "  join Menutoppingsgroups ap with(nolock) on a.toppinggroupid = ap.ID "
                                        SQL = SQL & " where a.id in  (" & objRds("toppingids") & ") "
                                    dim objRds_toppingids_group : Set objRds_toppingids_group = Server.CreateObject("ADODB.Recordset") 
                                        objRds_toppingids_group.Open SQL, objCon
                                    Dim toppinggroup : toppinggroup = ""
                                    while not objRds_toppingids_group.EOF 
                                        toppingtext=""    
                                        toppinggroup = objRds_toppingids_group("toppingsgroup")

                                        Set objRds_toppingids = Server.CreateObject("ADODB.Recordset") 
                                                SQLTopping = "SELECT m.topping,isnull(mp.toppingsgroup,'') as toppingsgroup FROM MenuToppings m "
                                                SQLTopping =SQLTopping & "  left join Menutoppingsgroups mp on  m.toppinggroupid = mp.ID"
                                                SQLTopping =SQLTopping & "    where m.id in ("& objRds("toppingids") &") and m.toppinggroupid=  " & objRds_toppingids_group("toppinggroupid")
                                            objRds_toppingids.Open SQLTopping, objCon                          
				                            Do While NOT objRds_toppingids.Eof 
						                           toppingtext = toppingtext & objRds_toppingids("topping") & ", "                                                    
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
                                         objRds_toppingids_group.movenext()
                                    wend
                                        objRds_toppingids_group.close()    
                                    set objRds_toppingids_group = nothing
						         End If  %>
						        </td>
                                        <td style="padding-right: 20px; text-align: right;" valign="top"><%=CURRENCYSYMBOL%><%= FormatNumber(objRds("Total"), 2) %></td>                                    
                                    </tr>
                            <%  
                        objRds.MoveNext        
                    Loop 
                                       
                    objRds.Close
                    objCon.Close

                    %>
     
                        <tr>
                        <td style="padding-top: 5px">&nbsp;</td>
                        <td style="padding-top: 5px">&nbsp;</td>
                    </tr>
				<%if vvouchercode<>"" then%>
					<tr>
                        <td style="padding-top: 5px; text-align: right; border-top: 1px dotted black;">Discount code:&nbsp;<br /><%=vvouchercode%> <%if VoucherDiscontType <> "Amount" then %>(-<%=vvouchercodediscount%>%)<%end if %>&nbsp; </td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right; border-top: 1px dotted black;"> -<%=CURRENCYSYMBOL%> <%if VoucherDiscontType <> "Amount" then %>  <%= FormatNumber((( vSubTotal * 100 )/(100- Cdbl(Replace(Replace(Replace(vvouchercodediscount,"-",""),"%","")," ",""))) - vSubTotal ),2) %> <%else %> <%=FormatNumber(Cdbl(Replace(Replace(Replace(vvouchercodediscount,"-",""),"%","")," ","")),2) %> <%end if %> </td>
                    </tr>
					<%end if%>
        
        
                        <tr>
                        <td style="padding-top: 5px; text-align: right; border-top: 1px dotted black;"><b>SubTotal:&nbsp;</b></td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right; border-top: 1px dotted black;"><%=CURRENCYSYMBOL%><%= FormatNumber(vSubTotal, 2)  %></td>
                    </tr>       
                     <% if 1= 2 then ' remove local %>   
                    <tr>
                        <td style="padding-top: 5px; text-align: right;">Delivery Fee:&nbsp;</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right;"><%=CURRENCYSYMBOL%><%= FormatNumber(vShippingFee, 2)  %></td>
                    </tr>    
                     <% end if '1=2 %>   
                      <%if CDBL(PaymentSurcharge) > 0  then  %>
					<tr>
                        <td style="padding-top: 5px; text-align: right;">Payment surcharge:&nbsp;</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right;"> <%=CURRENCYSYMBOL%><%= FormatNumber(PaymentSurcharge, 2)  %>  </td>
                    </tr>
					<%end if%>       
                     <%if CDBL(ServiceCharge) > 0  then  %>
					<tr>
                        <td style="padding-top: 5px; text-align: right;">Service charge:&nbsp;</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right;"> <%=CURRENCYSYMBOL%><%= FormatNumber(ServiceCharge, 2)  %>  </td>
                    </tr>
					<%end if%>     
                      <%if CDBL(TaxAmount) > 0  then  %>
					<tr>
                        <td style="padding-top: 5px; text-align: right;">Tax(<%=Tax_Percent %>):&nbsp;</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right;"> <%=CURRENCYSYMBOL%><%= FormatNumber(TaxAmount, 2)  %>  </td>
                    </tr>
					<%end if%>  
                      <%if CDBL(TipAmount) > 0  then  %>
					<tr>
                        <td style="padding-top: 5px; text-align: right;">Tip:(<%=TipRate %>)&nbsp;</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right;"> <%=CURRENCYSYMBOL%><%= FormatNumber(TipAmount, 2)  %>  </td>
                    </tr>
					<%end if%>       
                    <tr>
                        <td style="padding-top: 5px;text-align: right;"><b>Total:&nbsp;</b></td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right;"> <b><%=CURRENCYSYMBOL%><%= FormatNumber(vOrderTotal, 2)  %></b></td>
                    </tr>    
                 
                </table>
          
            <% End If
			 %>  
       	
		
		     <% If notes <> "" Then %>
      <div style="width: 300px;margin-left:auto;margin-right:auto;">
          <br><br>  <div style="   display: block;width: 100%;padding: 0;margin-bottom: 3px;font-size: 21px; line-height: inherit;color: #333;border: 0; border-bottom: 1px solid #e5e5e5;">Special instructions:</div>
        <%= (replace(notes,chr(10),"<br />"))    %> <%''(replace(notes,chr(13),"<br />")) %>
             <br><br>           
        </div>
    <% End If %>
       
     <%  set objRds = nothing
    set objCon = nothing
          %>               
	</div>
	
	