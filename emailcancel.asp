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
    Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 

    Dim vRestaurantId
    dim vOrderId
     Dim sAverageDeliveryTime
    Dim sAverageCollectionTime
    Dim CreditSurcharge
    
    
    vRestaurantId = Request.QueryString("id_r")
    vOrderId = Request.QueryString("id_o")

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

%>
<!-- #include file="restaurantsettings.asp" --> 
<% If UCase(Request.QueryString("notifyemail") & "") <> "Y" Then %>
 <div class="row">
        <div class="span12">
           <div align="center"> 
			<p>Order <%=Request.QueryString("id_o")%> from <%= objRds("Name") %> </p></div>
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
        objCon.Close       
        
         objCon.Open sConnString
        objRds.Open "select * from [Orders]  " & _
            "where Id = " & vOrderId, objCon

        dim vShippingFee
        dim vSubTotal
        dim vOrderTotal
		dim vdeliverytype
		Dim PaymentSurcharge, ServiceCharge
		If objRds("DeliveryType") = "d" Then 
	vdeliverytype="delivery"
	Else
	vdeliverytype="collection"
	End If 

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
		vvouchercodediscount = objRds("vouchercodediscount")
		vvouchercode=objRds("vouchercode")
         vnotes=objRds("notes")   
    Dim VoucherDiscountType : VoucherDiscountType = objRds("DiscountType")
    Dim PaymentType
    PaymentType = objRds("notes") 
        
          
    %>
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
			
Order Time:&nbsp;<%response.write(FormatDateTime(objRds("orderdate"),2))%>&nbsp;<%response.write(FormatDateTime(objRds("orderdate"),4) )%>

<%
    Dim BringgScheduledTime
     %>

<br />
                Order Type:&nbsp;<% If objRds("DeliveryType") = "d" Then %>Delivery<% Else %>Collection<% End If %>
               <br>
			   Requested for: &nbsp;<%if objRds("asaporder") = "n" then%>  <%if objRds("DeliveryType") = "c" then%>
				   <%=DateAdd("n",vaveragecol,objRds("orderdate"))%>
				   <%else%>
				   ASAP
				   <%end if%><%else BringgScheduledTime =  DateAdd("n", - (vaveragedel -vaveragecol) ,objRds("DeliveryTime")) %>  <%= FormatDateTime(objRds("DeliveryTime"), 2) %>&nbsp;<%= FormatDateTime(objRds("DeliveryTime"), 4) %><%end if%><br>
			
<%if objRds("asaporder") = "n" then
if objRds("DeliveryType") = "d" then
mintoadd=vaveragedel  '+ 5 ' Add + 5 to match with front end
else
mintoadd=vaveragecol  '+ 5 ' Add + 5 to match with front end
end if

    BringgScheduledTime = DateAdd("n",vaveragecol,objRds("orderdate"))
    
%>
Accepted to:&nbsp;<%=DateAdd("n",mintoadd,objRds("orderdate"))%>
<br>
<%end if%>
          
<%
 ' BringgScheduledTime = DateAdd( "h", houroffsetreal,BringgScheduledTime)


'bringg = "{ ""company_id"": " & bringgcompanyid & ",""title"": """ & vOrderId & """,  ""external_id"": ""ABC15D"",""customer"": {""name"": """ & objRds("FirstName") & " " & objRds("LastName")  & """, ""address"": """ & objRds("Address") & """, ""phone"": """ & objRds("Phone") & """}, ""way_points"": [{""customer"": {""name"": """ & bringgcompanyname & """, ""address"": """ & bringgcompanyaddress & """, ""phone"": """ & bringgcompanytelephone & """}, ""company_id"": " & bringgcompanyid & "},{ ""customer"": {""name"": """ & objRds("FirstName") & " " & objRds("LastName")  & """, ""address"": """ & objRds("Address") & """, ""phone"": """ & objRds("Phone") & """, ""scheduled_at"": """ & Year(BringgScheduledTime)  & "-" & Month(BringgScheduledTime)   & "-" & Day(BringgScheduledTime)   & "T" & Hour(BringgScheduledTime)   & ":" & Minute(BringgScheduledTime)   & ":00.000Z""},""note"":""" & vnotes & """, ""company_id"": " & bringgcompanyid & "}]}"

bringg = "{ ""company_id"": " & bringgcompanyid & ",""title"": """ & vOrderId & """,  ""external_id"": ""ABC15D"",""customer"": {""name"": """ & objRds("FirstName") & " " & objRds("LastName")  & """, ""address"": """ & objRds("Address") & """, ""phone"": """ & objRds("Phone") & """}, ""way_points"": [{""customer"": {""name"": """ & bringgcompanyname & """, ""address"": """ & bringgcompanyaddress & """, ""phone"": """ & bringgcompanytelephone & """, ""scheduled_at"":   """ & Year(BringgScheduledTime)  & "-" & Month(BringgScheduledTime)   & "-" & Day(BringgScheduledTime)   & "T" & Hour(BringgScheduledTime)   & ":" & Minute(BringgScheduledTime)   & ":00.000Z""}, ""company_id"": " & bringgcompanyid & "},{ ""customer"": {""name"": """ & objRds("FirstName") & " " & objRds("LastName")  & """, ""address"": """ & objRds("Address") & "," & objRds("PostalCode")& """, ""phone"": """ & objRds("Phone") & """, ""scheduled_at"": """ & Year(BringgScheduledTime)  & "-" & Month(BringgScheduledTime)   & "-" & Day(BringgScheduledTime)   & "T" & Hour(BringgScheduledTime)   & ":" & Minute(BringgScheduledTime)   & ":00.000Z""},""note"":""" & vnotes & """, ""company_id"": " & bringgcompanyid & "}]}"
'bringg = "{ ""company_id"": " & bringgcompanyid & ",""title"": """ & vOrderId & """,  ""external_id"": ""ABC15D"",""customer"": {""name"": """ & objRds("FirstName") & " " & objRds("LastName")  & """, ""address"": """ & objRds("Address") & """, ""phone"": """ & objRds("Phone") & """}, ""way_points"": [{""customer"": {""name"": """ & bringgcompanyname & """, ""address"": """ & bringgcompanyaddress & """, ""phone"": """ & bringgcompanytelephone & """, ""scheduled_at"":   """ & Year(BringgScheduledTime)  & "-" & Month(BringgScheduledTime)   & "-" & Day(BringgScheduledTime)   & "T" & Hour(BringgScheduledTime)   & ":" & Minute(BringgScheduledTime)   & ":00.000Z""}, ""company_id"": " & bringgcompanyid & "},{ ""customer"": {""name"": """ & objRds("FirstName") & " " & objRds("LastName")  & """, ""address"": """ & objRds("Address") & "," & objRds("PostalCode") & """, ""phone"": """ & objRds("Phone") & """, ""scheduled_at"":  """ & Year(BringgScheduledTime)  & "-" & Month(BringgScheduledTime)   & "-" & Day(BringgScheduledTime)   & "T" & Hour(BringgScheduledTime)   & ":" & Minute(BringgScheduledTime)   & ":00.000Z""} ,""note"":""" & vnotes & """  , ""company_id"": "&bringgcompanyid&"}]}" 
 '   bringg = "{ ""company_id"": " & bringgcompanyid & ",""title"": """ & vOrderId & """,  ""external_id"": ""ABC15D"",""customer"": {""name"": """ & objRds("FirstName") & " " & objRds("LastName")  & """, ""address"": """ & objRds("Address")  & "," & objRds("Postalcode") & """, ""phone"": """ & objRds("Phone") & """}, ""way_points"": [{""customer"": {""name"": """ & bringgcompanyname & """, ""address"": """ & bringgcompanyaddress & """, ""phone"": """ & bringgcompanytelephone & """}, ""scheduled_at"":   """ & Year(BringgScheduledTime)  & "-" & Month(BringgScheduledTime)   & "-" & Day(BringgScheduledTime)   & "T" & Hour(BringgScheduledTime)   & ":" & Minute(BringgScheduledTime)   & ":00.000Z"", ""company_id"": " & bringgcompanyid & "},{ ""customer"": {""name"": """ & objRds("FirstName") & " " & objRds("LastName")  & """, ""phone"": """ & objRds("Phone") & """ }, ""address"": """ & objRds("Address") & "," & objRds("PostalCode") & """, ""scheduled_at"":  """ & Year(BringgScheduledTime)  & "-" & Month(BringgScheduledTime)   & "-" & Day(BringgScheduledTime)   & "T" & Hour(BringgScheduledTime)   & ":" & Minute(BringgScheduledTime)   & ":00.000Z"",""note"":""" & vnotes & """}]}" ', ""company_id"": "&bringgcompanyid&"






%>


<div style="border-bottom: 1px solid #e5e5e5;width: 100%;">
Payment Status:&nbsp;<%if  objRds("PaymentType")="Paypal-Paid" or objRds("PaymentType")="NoChex-Paid" or objRds("PaymentType")="Worldpay-Paid" or Ucase(objRds("Payment_status") & "")="PAID"  then  %>ORDER PAID
<%else%>ORDER UNPAID<%end if%>
</div>
<br>
<br>



    <%
	notes=objRds("notes")
        objRds.Close
        objCon.Close
     %>
        
			
        <%
                
            objCon.Open sConnString
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
                            (x <%= objRds("Qta") %>)
                        <% End If %> <%= objRds("Name") %>&nbsp;<%= objRds("PropertyName") %> 
						
						<%
						'display toppings in basket area
						If objRds("dishpropertiesids") <> "" Then
						 
						dishpropertiessplit=split(objRds("dishpropertiesids"),",")
					for i=0 to ubound(dishpropertiessplit)
					
					dishpropertiessplit2=split(dishpropertiessplit(i),"|")
					
					'Set objCon_dishpropertiesprice = Server.CreateObject("ADODB.Connection")
					Set objRds_dishpropertiesprice = Server.CreateObject("ADODB.Recordset") 
					'objCon_dishpropertiesprice.Open sConnString
	                objRds_dishpropertiesprice.Open "SELECT MenuDishproperties.ID, MenuDishproperties.dishproperty, MenuDishproperties.dishpropertyprice, MenuDishpropertiesGroups.dishpropertypricetype, MenuDishpropertiesGroups.dishpropertygroup FROM MenuDishproperties INNER JOIN MenuDishpropertiesGroups ON MenuDishproperties.dishpropertygroupid = MenuDishpropertiesGroups.ID where (((MenuDishproperties.ID)=" & dishpropertiessplit2(1)  & "))", objCon
if not objRds_dishpropertiesprice.EOF then
					response.write "<BR> <small>" & objRds_dishpropertiesprice("dishpropertygroup") & ":" & objRds_dishpropertiesprice("dishproperty") & "</small>"
end if
					
					
					
					next
					end if%>
						
						<%
						toppingtext=""
						If objRds("toppingids") <> "" Then 
						        'Set objCon_toppingids = Server.CreateObject("ADODB.Connection")
								Set objRds_toppingids = Server.CreateObject("ADODB.Recordset") 
          
								'objCon_toppingids.Open sConnString
                             Dim SQLTopping 
                                Dim toppinggroup : toppinggroup  =""
                                    SQLTopping = "SELECT m.topping,isnull(mp.toppingsgroup,'') as toppingsgroup FROM MenuToppings m "
                                    SQLTopping =SQLTopping & "  left join Menutoppingsgroups mp on  m.toppinggroupid = mp.ID"
                                    SQLTopping =SQLTopping & "    where m.id in ("& objRds("toppingids") &")"

                objRds_toppingids.Open SQLTopping , objCon
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
                        <td style="padding-top: 5px; text-align: right; border-top: 1px dotted black;">Discount code:&nbsp;<br /><%=vvouchercode%><%if VoucherDiscountType & "" <> "Amount" then %> (-<%=vvouchercodediscount%>%)<%end if %>&nbsp; </td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right; border-top: 1px dotted black;"> -<%=CURRENCYSYMBOL%><%if VoucherDiscountType & "" <> "Amount" then %><%= FormatNumber((( vSubTotal * 100 )/(100- Cdbl(Replace(Replace(Replace(vvouchercodediscount,"-",""),"%","")," ",""))) - vSubTotal ),2) %><%else %><%=FormatNumber(Cdbl(Replace(Replace(Replace(vvouchercodediscount,"-",""),"%","")," ","")),2) %><%end if %> </td>
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
      <% set   objRds = nothing
       set objCon = nothing %>                      
	</div>
	
	</div></div>

</td>
</tr>
</table>
</body>
</html>
