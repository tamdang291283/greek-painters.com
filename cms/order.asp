<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../Config.asp" -->
<!-- #include file="timezone.asp" -->
<!-- #include file="restaurantsettings.asp" -->
<% 
    Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 

    Dim vRestaurantId
    dim vOrderId
     Dim sAverageDeliveryTime
    Dim sAverageCollectionTime
    
    vRestaurantId = Request.QueryString("id_r")
    vOrderId = Request.QueryString("id_o")

    objCon.Open sConnStringcms
    objRds.Open "SELECT * FROM BusinessDetails WHERE Id = " & vRestaurantId, objCon      
    vaveragedel = objRds("AverageDeliveryTime")
	vaveragecol = objRds("AverageCollectionTime")
    if Not IsNull(objRds("AverageDeliveryTime")) Then sAverageDeliveryTime = Cdbl(objRds("AverageDeliveryTime"))
    if Not IsNull(objRds("AverageCollectionTime")) Then sAverageCollectionTime = Cdbl(objRds("AverageCollectionTime"))   
%>

<div class="container">
    <div class="row">
		<div class="col-md-4 col-md-offset-4"><br>
		<br>
		
    		<div class="panel panel-default">
			  	<div class="panel-heading"><button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			    	<h3 class="panel-title"><p>Order <%=Request.QueryString("id_o")%> from <%= objRds("Name") %> </p></h3>
			 	</div>
			  	<div class="panel-body">
			    	 
        
    <%   
	name=objRds("Name")
	address= objRds("Address") 
	telephone=objRds("telephone") 
	email=  objRds("email")       
        objRds.Close
        objCon.Close       
        
         objCon.Open sConnStringcms
        objRds.Open "select * from [Orders]  " & _
            "where Id = " & vOrderId, objCon

        dim vShippingFee
        dim vSubTotal
        dim vOrderTotal
         Dim servicecharge, paymentsurcharge
        vShippingFee = objRds("ShippingFee")
        vSubTotal = objRds("SubTotal")
        vOrderTotal = objRds("OrderTotal")
		vvouchercodediscount = objRds("vouchercodediscount")
		vvouchercode=objRds("vouchercode")
        servicecharge  = objRds("servicecharge")
        If servicecharge & "" = "" Then
            servicecharge = 0
        End If
        paymentsurcharge  = objRds("paymentsurcharge")    
         If paymentsurcharge & "" = "" Then
            paymentsurcharge = 0
        End If

        If objRds("OrderDate") & "" = "" Then

             objRds.Close
            objCon.Close     
            
            'Response.Clear()
            Response.Write("The Order was not completed.")
            Response.End()
        End if
    %>
	
	
	   <div style="width: 300px;margin-left:auto;margin-right:auto;">
        <div class="">
           <div class="shop-info">
                <span class="shop-name"><strong><%=name %></strong></span><br />
                <span class="shop-address"><strong><%=address%></strong></span><br />
                <span class="shop-name">Tel. <%=telephone %></span><br />                       
                <span class="shop-address">Email: <%=email %></span><br /><br>
				
            </div>
        </div>
    </div>
	
	

 <div style="width: 300px;margin-left:auto;margin-right:auto;">
    <fieldset>
            <legend>Customer Details</legend>
			
	<%= objRds("FirstName") %>&nbsp;<%= objRds("LastName") %><br />
            <%= objRds("Address") %>,&nbsp;<%= objRds("PostalCode") %><br />
            <%= objRds("Phone") %><br />
            <%= objRds("Email") %><br /><br>
			
    </fieldset>		                
	</div>
            
    

    
     
        
    <div style="width: 300px;margin-left:auto;margin-right:auto;">
    <fieldset>
	
            <legend>Order Details</legend>
			Order Number: <%=Request.QueryString("id_o")%>


<br>
			
			 Order Time: <%response.write(FormatDateTime(objRds("orderdate"),2))%>&nbsp;<%response.write(FormatDateTime(objRds("orderdate"),4) )%>
<br />
           Order Type: <% If objRds("DeliveryType") = "d" Then %>Delivery<% Else %>Collection<% End If %><br>
		   
           Requested for:     &nbsp;<%if objRds("asaporder") = "n" then%>  <%if objRds("DeliveryType") = "c" then%>
				   <%=DateAdd("n",vaveragecol,objRds("orderdate"))%>
				   <%else%>
				   ASAP
				   <%end if%><%else%><%= FormatDateTime(objRds("DeliveryTime"), 2) %>&nbsp;<%= FormatDateTime(objRds("DeliveryTime"), 4) %><%end if%><br>
				

<%if objRds("asaporder") = "n" then
if objRds("DeliveryType") = "d" then
mintoadd=vaveragedel ' + 5 ' Add + 5 to match with front end
else
mintoadd=vaveragecol ' + 5 ' Add + 5 to match with front end
end if
%>
Accepted to:&nbsp;<%=DateAdd("n",mintoadd,objRds("orderdate"))%>
<br>
<%end if%>
          
			
			<div style="border-bottom: 1px solid #e5e5e5;width: 100%;">
		Payment Status:&nbsp;<%if  objRds("PaymentType")="Paypal-Paid" or  objRds("PaymentType")="NoChex-Paid" or  objRds("PaymentType")="Worldpay-Paid" then  %>ORDER PAID<%else%>ORDER UNPAID<%end if%></div><br>
<br>


<%
	 notes=objRds("Notes")
	 
	 
        objRds.Close
        objCon.Close
     %>
        <%
                
            objCon.Open sConnStringcms
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
                    Do While NOT objRds.Eof  %>
                            <tr>
                                <td><%= objRds("Name") %>&nbsp;<%= objRds("PropertyName") %> <%If objRds("Qta") > 1 Then %> 
                            (x <%= objRds("Qta") %>)
                        <% End If %>
						
						<%
						'display toppings in basket area
						If objRds("dishpropertiesids") <> "" Then
						 
						dishpropertiessplit=split(objRds("dishpropertiesids"),",")
					for i=0 to ubound(dishpropertiessplit)
					
					dishpropertiessplit2=split(dishpropertiessplit(i),"|")
					
					Set objCon_dishpropertiesprice = Server.CreateObject("ADODB.Connection")
					Set objRds_dishpropertiesprice = Server.CreateObject("ADODB.Recordset") 
					objCon_dishpropertiesprice.Open sConnStringcms
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
          
								objCon_toppingids.Open sConnStringcms
                objRds_toppingids.Open "SELECT * FROM MenuToppings where id in (" & objRds("toppingids") & ")", objCon
				Do While NOT objRds_toppingids.Eof 
						toppingtext = toppingtext & objRds_toppingids("topping") & ", "
						objRds_toppingids.MoveNext
						loop
						if toppingtext<>"" then
							toppingtext=left(toppingtext,len(toppingtext)-2)
						response.write "<small><br>Toppings: " & toppingtext & "</small>"
						end if
						 End If %>
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
                        <td style="padding-top: 5px; text-align: right; border-top: 1px dotted black;">Discount code<br /><%=vvouchercode%> (-<%=vvouchercodediscount%>%) </td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right; border-top: 1px dotted black;">-<%=CURRENCYSYMBOL%><%= FormatNumber((( vSubTotal * 100 )/(100- Cdbl(Replace(Replace(Replace(vvouchercodediscount,"-",""),"%","")," ",""))) - vSubTotal ),2)%></td>
                    </tr>
					<%end if%>
					
        
                        <tr>
                        <td style="padding-top: 5px; text-align: right; border-top: 1px dotted black;">SubTotal&nbsp;</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right; border-top: 1px dotted black;"><%=CURRENCYSYMBOL%><%= FormatNumber(vSubTotal, 2)  %></td>
                    </tr>       
                      <%if   Cdbl(vShippingFee ) > 0  then  %>   
                    <tr>
                        <td style="padding-top: 5px; text-align: right;">Delivery Fee&nbsp;</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right;"><%=CURRENCYSYMBOL%><%= FormatNumber(vShippingFee, 2)  %></td>
                    </tr>    
                    <% end if %> 
                      <%if Cdbl(PaymentSurcharge ) > 0 then  %>
					<tr>
                        <td style="padding-top: 5px; text-align: right;">Credit card surcharge&nbsp;</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right;"> <%=CURRENCYSYMBOL%><%= FormatNumber(PaymentSurcharge, 2)  %>  </td>
                    </tr>
					<%end if%>     
                      <%if   Cdbl(ServiceCharge ) > 0  then  %>
					<tr>
                        <td style="padding-top: 5px; text-align: right;">Service charge&nbsp;</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right;"> <%=CURRENCYSYMBOL%><%= FormatNumber(ServiceCharge, 2)  %>  </td>
                    </tr>
					<%end if%>            
                    <tr>
                        <td style="padding-top: 5px;text-align: right;"><b>Total&nbsp;</b></td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right;"><b><%=CURRENCYSYMBOL%><%= FormatNumber(vOrderTotal, 2)  %></b></td>
                    </tr>    
                </table>
          
            <% End If %>  
        </fieldset>		                
	</div>
	<%
	 If notes <> "" Then %><br>
	 
      <div style="width: 300px;margin-left:auto;margin-right:auto;">
            <fieldset><legend>Special instructions:</legend>
               <%= (replace(notes,chr(13),"<br />")) %>
			   
			  
            </fieldset>            
        </div>
    <% End If %>
			    </div>
			</div>
		</div>
	</div>
</div>
