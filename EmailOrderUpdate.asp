<!-- #include file="Config.asp" -->
<!-- #include file="timezone.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta charset="utf-8">
    <title>Order Confirmation</title> 
	<style type="text/css">
	
	legend {
      display: block;
    width: 100%;
    padding: 0;
    margin-bottom: 3px;
    font-size: 21px;
    line-height: inherit;
    color: #333;
    border: 0;
    border-bottom: 1px solid #e5e5e5;
  }
  
  </style>   
</head>
<body>

<div align="center">
<table width="300" cellspacing="0" cellpadding="0" border="0">
<tr>
	<td>


<div class="container" style="width:300px;">    
    
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
   
    Dim vRestaurantId
    dim vOrderId
     Dim sAverageDeliveryTime
    Dim sAverageCollectionTime
    Dim CreditSurcharge
    
    
    vRestaurantId = Request.QueryString("id_r")
    vOrderId = Request.QueryString("id_o")

       dim hidefullemail : hidefullemail = 1
        if Request.QueryString("message")="Order Acknowledged" OR Request.QueryString("message")="Order Out For Delivery" then
		    hidefullemail=0
        Else
            hidefullemail=1
        End IF
		 
%>
    <% if hidefullemail = 1 then %>

  
        <%   
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
	    session("restaurantid")=Request.QueryString("id_r")
        CreditSurcharge = objRds("CREDITCARDSURCHARGE")
        If CreditSurcharge & "" = "" Then
            CreditSurcharge = "0"
        End If 
 
	    name=objRds("Name")
	    address= objRds("Address") 
	    telephone=objRds("telephone") 
	    email=  objRds("email") 
	 
	    analyticsitems=""    
        objRds.Close
        set objRds = nothing
        'objCon.Close   
        'objCon.Open sConnString
        Set objRds = Server.CreateObject("ADODB.Recordset") 
        objRds.Open "select * from [Orders]  " & _
            "where Id = " & vOrderId, objCon

        dim vShippingFee
        dim vSubTotal
        dim vOrderTotal
		dim vdeliverytype
		Dim PaymentSurcharge, ServiceCharge,TaxAmount,TipAmount
		If objRds("DeliveryType") = "d" Then 
	        vdeliverytype="delivery"
	    Else
	        vdeliverytype="collection"
	    End If 
         if  objRds("deliverydelay") & "" <> "" then
            vaveragedel = cint(objRds("deliverydelay"))
        end if
        if  objRds("collectiondelay") & "" <> "" then
                vaveragecol = cint(objRds("collectiondelay"))
        end if
        vShippingFee = objRds("ShippingFee")
        vSubTotal = objRds("SubTotal")
        vOrderTotal = objRds("OrderTotal")
        PaymentSurcharge = objRds("PaymentSurcharge")
        If PaymentSurcharge & "" = "" Then
            PaymentSurcharge = "0"
        End If
        ServiceCharge = objRds("ServiceCharge")
        If ServiceCharge & "" = "" Then
            ServiceCharge = "0"
        End If
        TaxAmount = objRds("Tax_Amount")
        If TaxAmount & "" = "" Then
            TaxAmount = "0"
        End If
        TipAmount = objRds("Tip_Amount")
        If TipAmount & "" = "" Then
            TipAmount = "0"
        End If
             Dim TipRate : TipRate = objRds("Tip_Rate")
        if TipRate  & "" = "" then
            TipRate = "0"
        end if
        if TipRate & "" <> "custom" then
            TipRate =  TipRate & "%"
        end if
        dim cancelledby : cancelledby =  objRds("cancelledby")
        dim cancelledreason : cancelledreason =  objRds("cancelledreason")
		vvouchercodediscount = objRds("vouchercodediscount")
		vvouchercode=objRds("vouchercode")
         vnotes=objRds("notes")   
    Dim PaymentType
    PaymentType = objRds("notes") 
        
    dim messageCancel 
        if Request.QueryString("message") & "" = "" then
                messageCancel  = "Order Cancelled by " & cancelledby
            if cancelledreason & "" <> "" then
                messageCancel = messageCancel & " - " & cancelledreason
            end if
        else
            messageCancel = Request.QueryString("message")
        end if
            
          
    %>

    <div class="row">
        <div class="span12">            
            <div align="center"> 
                    <% if messageCancel & "" <> "" then %>
                <h2 class="hero-unit"><%=messageCancel %></h2>
                    <% end if %>
			<p>Order <%=vOrderId%> from <%= name %> </p>
            </div>
        </div>
    </div>

	<div style="width: 300px;margin-left:auto;margin-right:auto;margin-bottom:30px;">
        <div class="">
           <div class="">
               <div align="center">  <span class="shop-name"></span>  </div>
            </div>
        </div>
    </div>	
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
	<div style="width: 300px; clear:both;margin-left:auto;margin-right:auto;">
			<div style="   display: block;width: 100%;padding: 0;margin-bottom: 3px;font-size: 21px; line-height: inherit;color: #333;border: 0; border-bottom: 1px solid #e5e5e5;">Customer Details</div>
            <%= objRds("FirstName") %>&nbsp;<%= objRds("LastName") %><br />
            <%= objRds("Address") %>,&nbsp;<%= objRds("PostalCode") %><br />
            <%= objRds("Phone") %><br />
            <%= objRds("Email") %>
            <% If objRds("DeliveryLat") & "" <> "" Then %>
                <br />Lat/Long: <%= objRds("DeliveryLat") & "," & objRds("DeliveryLng")%>
                <br />GPS: <%=Latitude_DMS(objRds("DeliveryLat")) & " ," & Longitude_DMS(objRds("DeliveryLng")) %>
            <% End If %>
               <br>
            <br>
    </div>
    <div style="width: 300px;margin-left:auto;margin-right:auto;">
    
            <div style="   display: block;width: 100%;padding: 0;margin-bottom: 3px;font-size: 21px; line-height: inherit;color: #333;border: 0; border-bottom: 1px solid #e5e5e5;">Order Details</div>
			
				Order Number:&nbsp;<%=Request.QueryString("id_o")%>
<br>
			
Order Time:&nbsp;<%response.write(formatDateTimeC(objRds("orderdate")))%>

<%
    Dim BringgScheduledTime
     %>

<br />
                Order Type:&nbsp;<% If objRds("DeliveryType") = "d" Then %>Delivery<% Else %>Collection<% End If %>
               <br>
			   Requested for: &nbsp;<%if objRds("asaporder") = "n" then%>  <%if objRds("DeliveryType") = "c" then%>
				   <%=formatDateTimeC(DateAdd("n",vaveragecol,objRds("orderdate")))%>
				   <%else%>
				   ASAP
				   <%end if%><%else BringgScheduledTime =  DateAdd("n", - (vaveragedel -vaveragecol) ,objRds("DeliveryTime")) %>  <%= formatDateTimeC(objRds("DeliveryTime")) %><%end if%><br>
			
<%if objRds("asaporder") = "n" then
    if objRds("DeliveryType") = "d" then
        mintoadd=vaveragedel  '+ 5 ' Add + 5 to match with front end
    else
        mintoadd=vaveragecol  '+ 5 ' Add + 5 to match with front end
    end if

    BringgScheduledTime = DateAdd("n",vaveragecol,objRds("orderdate"))
    
%>
Accepted to:&nbsp;<%=formatDateTimeC(DateAdd("n",mintoadd,objRds("orderdate")))%>
<br>
<%end if%>

<div style="border-bottom: 1px solid #e5e5e5;width: 100%;">
Payment Status:&nbsp;<%if  objRds("PaymentType")="Paypal-Paid" or objRds("PaymentType")="NoChex-Paid" or objRds("PaymentType")="Worldpay-Paid" or Ucase(objRds("Payment_status") & "")="PAID"  then  %>ORDER PAID
<%else%>ORDER UNPAID<%end if%>
</div>
<br>
<br>
    <%
	notes=objRds("notes")
            objRds.Close
            set objRds =  nothing
            'objCon.Close
            'objCon.Open sConnString
            Set objRds = Server.CreateObject("ADODB.Recordset") 
            objRds.Open "select oi.*," & _
                    "mi.Name, mip.Name as PropertyName ,  mi.PrintingName " & _
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
            Response.End
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
                            (x <%= objRds("Qta") %>)
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
						   ' Set objCon_toppingids = Server.CreateObject("ADODB.Connection")
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
                    </tr>
					
					<%if vvouchercode<>"" then%>
					<tr>
                        <td style="padding-top: 5px; text-align: right; border-top: 1px dotted black;">Discount code:&nbsp;<br /><%=vvouchercode%> (-<%=vvouchercodediscount%>%)&nbsp; </td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right; border-top: 1px dotted black;"> -<%=CURRENCYSYMBOL%><%= FormatNumber((( vSubTotal * 100 )/(100- Cdbl(Replace(Replace(Replace(vvouchercodediscount,"-",""),"%","")," ",""))) - vSubTotal ),2) %> </td>
                    </tr>
					<%end if%>
        
                        <tr>
                        <td style="padding-top: 5px; text-align: right; border-top: 1px dotted black;">SubTotal:&nbsp;</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right; border-top: 1px dotted black;"><%=CURRENCYSYMBOL%><%= FormatNumber(vSubTotal, 2)  %></td>
                    </tr>       
                    <% if Cdbl(vShippingFee) > 0 Then %>
                    <tr>
                        <td style="padding-top: 5px; text-align: right;">Delivery Fee:&nbsp;</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right;"><%=CURRENCYSYMBOL%><%= FormatNumber(vShippingFee, 2)  %></td>
                    </tr>  
                    <% end if %>
                    <%if  Cdbl(PaymentSurcharge) > 0 then  %>
					<tr>
                        <td style="padding-top: 5px; text-align: right;">Credit card surcharge:&nbsp;</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right;"> <%=CURRENCYSYMBOL%><%= FormatNumber(PaymentSurcharge, 2)  %>  </td>
                    </tr>
					<%end if%>     
                      <%if  Cdbl(ServiceCharge) > 0 then  %>
					<tr>
                        <td style="padding-top: 5px; text-align: right;">Service charge:&nbsp;</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right;"> <%=CURRENCYSYMBOL%><%= FormatNumber(ServiceCharge, 2)  %>  </td>
                    </tr>
					<%end if%>     
                    <%if  Cdbl(TaxAmount) > 0 then  %>
					<tr>
                        <td style="padding-top: 5px; text-align: right;">Tax(<%=Tax_Percent %>%):&nbsp;</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right;"> <%=CURRENCYSYMBOL%><%= FormatNumber(TaxAmount, 2)  %>  </td>
                    </tr>
					<%end if%> 
                    <%if  Cdbl(TipAmount) > 0 then  %>
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
                <%= (replace(notes,chr(13),"<br />")) %>
                     <br><br>           
                </div>
            <% End If %>
         
                      
	</div>
	  <% 
                objCon.close()
            set objCon = nothing
       'set   objRds = nothing
       'set objCon = nothing %>  
    <% end if %>
    <%if Request.QueryString("message")="Order Acknowledged" then%>
		<div align="center">Your order is confirmed, Thank you for your custom.</div>
		<%end if%>   
		<%if Request.QueryString("message")="Order Out For Delivery" then%>
		<div align="center">Your order is out or delivery, Thank you for your custom.</div>
		<%end if
            
            %>   
	</div>
 
</td>
</tr>
</table>
</div>
</body>
</html>
