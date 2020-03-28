
<% 
    Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 

    Dim vRestaurantId
    dim vOrderId
     Dim sAverageDeliveryTime
    Dim sAverageCollectionTime
    
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


%>
<!-- #include file="restaurantsettings.asp" --> 
 <div class="row">
        <div class="span12">
           <div align="center"> <h2 class="hero-unit">Thanks for your Order!</h2>
			<p>Order <%=Request.QueryString("id_o")%> from <%= objRds("Name") %> </p></div>
        </div>
    </div>

 
    
        
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
		
		If objRds("DeliveryType") = "d" Then 
	vdeliverytype="delivery"
	Else
	vdeliverytype="collection"
	End If 

        vShippingFee = objRds("ShippingFee")
        vSubTotal = objRds("SubTotal")
        vOrderTotal = objRds("OrderTotal")
		vvouchercodediscount = objRds("vouchercodediscount")
		vvouchercode=objRds("vouchercode")
         vnotes=objRds("notes")   
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
	
	
<%



bringg = "{ ""company_id"": 9454,""title"": """ & vOrderId & """,  ""external_id"": ""ABC15D"",""customer"": {""name"": """ & objRds("FirstName") & " " & objRds("LastName")  & """, ""address"": """ & objRds("Address") & """, ""phone"": """ & objRds("Phone") & """}, ""way_points"": [{""customer"": {""name"": """ & bringgcompanyname & """, ""address"": """ & bringgcompanyaddress & """, ""phone"": """ & bringgcompanytelephone & """}, ""company_id"": 9454},{ ""customer"": {""name"": """ & objRds("FirstName") & " " & objRds("LastName")  & """, ""address"": """ & objRds("Address") & """, ""phone"": """ & objRds("Phone") & """, ""scheduled_at"": ""2018-10-17T22:47:58.000Z""},""note"":""" & vnotes & """, ""company_id"": 9454}]}"






%>

    <div style="width: 300px; clear:both;margin-left:auto;margin-right:auto;">
       
          
			<div style="   display: block;width: 100%;padding: 0;margin-bottom: 3px;font-size: 21px; line-height: inherit;color: #333;border: 0; border-bottom: 1px solid #e5e5e5;">Customer Details</div>
			
			
            <%= objRds("FirstName") %>&nbsp;<%= objRds("LastName") %><br />
            <%= objRds("Address") %>,&nbsp;<%= objRds("PostalCode") %><br />
            <%= objRds("Phone") %><br />
            <%= objRds("Email") %>
            
               <br>
			   
            <br>
			    
   
    </div>
            
    

    


    <div style="width: 300px;margin-left:auto;margin-right:auto;">
    
            <div style="   display: block;width: 100%;padding: 0;margin-bottom: 3px;font-size: 21px; line-height: inherit;color: #333;border: 0; border-bottom: 1px solid #e5e5e5;">Order Details</div>
			
				Order Number:&nbsp;<%=Request.QueryString("id_o")%>


<br>
			
Order Time:&nbsp;<%response.write(FormatDateTime(objRds("orderdate"),2))%>&nbsp;<%response.write(FormatDateTime(objRds("orderdate"),4) )%>



<br />
                Order Type:&nbsp;<% If objRds("DeliveryType") = "d" Then %>Delivery<% Else %>Collection<% End If %>
               <br>
			   Requested for: &nbsp;<%if objRds("asaporder") = "n" then%>  <%if objRds("DeliveryType") = "c" then%>
				   <%=DateAdd("n",vaveragecol,objRds("orderdate"))%>
				   <%else%>
				   ASAP
				   <%end if%><%else%><%= FormatDateTime(objRds("DeliveryTime"), 2) %>&nbsp;<%= FormatDateTime(objRds("DeliveryTime"), 4) %><%end if%><br>
			
<%if objRds("asaporder") = "n" then
if objRds("DeliveryType") = "d" then
mintoadd=vaveragedel
else
mintoadd=vaveragecol
end if
%>
Accepted to:&nbsp;<%=DateAdd("n",mintoadd,objRds("orderdate"))%>
<br>
<%end if%>
          


<div style="border-bottom: 1px solid #e5e5e5;width: 100%;">
Payment Status:&nbsp;<%if  objRds("PaymentType")="Paypal-Paid" or objRds("PaymentType")="NoChex-Paid" or objRds("PaymentType")="Worldpay-Paid" then  %>ORDER PAID
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
                    "mi.Name, mip.Name as PropertyName " & _
                    "from ( OrderItems oi " & _
                    "inner join MenuItems mi on oi.MenuItemId = mi.Id ) " & _
                    "left join MenuItemProperties mip on oi.MenuItemPropertyId = mip.Id " & _
                    "where oi.OrderId = " & vOrderId, objCon


        if objRds.Eof then %>
    
            No Items In Your Order.

        <% 
            objRds.Close
            objCon.Close

        else %>

               
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
					
					Set objCon_dishpropertiesprice = Server.CreateObject("ADODB.Connection")
					Set objRds_dishpropertiesprice = Server.CreateObject("ADODB.Recordset") 
					objCon_dishpropertiesprice.Open sConnString
	                objRds_dishpropertiesprice.Open "SELECT MenuDishproperties.ID, MenuDishproperties.dishproperty, MenuDishproperties.dishpropertyprice, MenuDishpropertiesGroups.dishpropertypricetype, MenuDishpropertiesGroups.dishpropertygroup FROM MenuDishproperties INNER JOIN MenuDishpropertiesGroups ON MenuDishproperties.dishpropertygroupid = MenuDishpropertiesGroups.ID where (((MenuDishproperties.ID)=" & dishpropertiessplit2(1)  & "))", objCon
if not objRds_dishpropertiesprice.EOF then
					response.write "<BR> <small>" & objRds_dishpropertiesprice("dishpropertygroup") & ":" & objRds_dishpropertiesprice("dishproperty") & "</small>"
end if
					
					
					
					next
					end if%>
						
						<%
						toppingtext=""
						If objRds("toppingids") <> "" Then 
						Set objCon_toppingids = Server.CreateObject("ADODB.Connection")
								Set objRds_toppingids = Server.CreateObject("ADODB.Recordset") 
          
								objCon_toppingids.Open sConnString
                objRds_toppingids.Open "SELECT * FROM MenuToppings where id in (" & objRds("toppingids") & ")", objCon
				Do While NOT objRds_toppingids.Eof 
						toppingtext = toppingtext & objRds_toppingids("topping") & ", "
						objRds_toppingids.MoveNext
						loop
						if toppingtext<>"" then
							toppingtext=left(toppingtext,len(toppingtext)-2)
						response.write "<small><br>Toppings: " & toppingtext & "</small>"
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
                        <td style="padding-top: 5px; text-align: right; border-top: 1px dotted black;">Discount code:&nbsp;</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right; border-top: 1px dotted black;"> <%=vvouchercode%> - <%=vvouchercodediscount%>%</td>
                    </tr>
					<%end if%>
        
                        <tr>
                        <td style="padding-top: 5px; text-align: right; border-top: 1px dotted black;">SubTotal:&nbsp;</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right; border-top: 1px dotted black;"><%=CURRENCYSYMBOL%><%= FormatNumber(vSubTotal, 2)  %></td>
                    </tr>       
                        
                    <tr>
                        <td style="padding-top: 5px; text-align: right;">Delivery Fee:&nbsp;</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right;"><%=CURRENCYSYMBOL%><%= FormatNumber(vShippingFee, 2)  %></td>
                    </tr>       
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
	
	