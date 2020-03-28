<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../../Config.asp" -->
<!-- #include file="../timezone.asp" -->
<% if Request.QueryString("id_r") & "" <> "" then %>
<!-- #include file="../restaurantsettings.asp" -->
<% end if %>
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
    if vRestaurantId & "" = "" then
       dim objRds1 :   Set objRds1 = Server.CreateObject("ADODB.Recordset") 
        objRds1.Open "SELECT IdBusinessDetail FROM orders  WHERE Id = " & vOrderId, objCon  
        if not objRds1.EOF then
            vRestaurantId  =objRds1("IdBusinessDetail")
        end if
        objRds1.close()
        set objRds1 = nothing
    end if
    if vRestaurantId & "" <> "" then
        objRds.Open "SELECT * FROM BusinessDetails  WHERE Id = " & vRestaurantId, objCon      
        vaveragedel = objRds("AverageDeliveryTime")
	    vaveragecol = objRds("AverageCollectionTime")
        if Not IsNull(objRds("AverageDeliveryTime")) Then sAverageDeliveryTime = Cdbl(objRds("AverageDeliveryTime"))
        if Not IsNull(objRds("AverageCollectionTime")) Then sAverageCollectionTime = Cdbl(objRds("AverageCollectionTime"))   
    end if
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
        set objRds = nothing
      '  objCon.Close       
        
      '   objCon.Open sConnStringcms
        Set objRds = Server.CreateObject("ADODB.Recordset") 
        objRds.Open "select * from [Orders]   " & _
            "where Id = " & vOrderId, objCon

        dim vShippingFee
        dim vSubTotal
        dim vOrderTotal
         Dim servicecharge, paymentsurcharge,Tip_Amount,Tax_Amount
        Tip_Amount = objRds("Tip_Amount")
        Tax_Amount = objRds("Tax_Amount")
        vShippingFee = objRds("ShippingFee")
        vSubTotal = objRds("SubTotal")
        vOrderTotal = objRds("OrderTotal")
		vvouchercodediscount = objRds("vouchercodediscount")
		vvouchercode=objRds("vouchercode")
        servicecharge  = objRds("servicecharge")

        If Tip_Amount & "" = "" Then
            Tip_Amount = 0
        End If
         If Tax_Amount & "" = "" Then
            Tax_Amount = 0
        End If
  
        Dim TipRate : TipRate = objRds("Tip_Rate")
        if TipRate  & "" = "" then
            TipRate = "0"
        end if
        if TipRate & "" <> "custom" then
            TipRate =  TipRate & "%"
        end if

        Dim TaxRate : TaxRate = objRds("Tax_Rate")
        if TaxRate  & "" = "" then
            TaxRate = "0"
        end if
     
         If servicecharge & "" = "" Then
            servicecharge = 0
        End If
        paymentsurcharge  = objRds("paymentsurcharge")    
         If paymentsurcharge & "" = "" Then
            paymentsurcharge = 0
        End If

        dim numberOfOrder : numberOfOrder  = 0
        if Show_Ordernumner_Dashboard = "yes" and vRestaurantId & "" <> ""  then
            Set objRds20 = Server.CreateObject("ADODB.Recordset")      
                 objRds20.Open "select count(ID) as numberoforder from orders  where Email = '" & replace(objRds("email"),"'","''") & "' and IdBusinessDetail=" & vRestaurantId, objCon 
        
            if not objRds20.EOF then
                numberOfOrder = objRds20("numberoforder")
            end if   
            objRds20.close()
        set objRds20 = nothing
        end if
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
			<% if objRds("orderdate") & "" <> "" then %>
			 Order Time: <% Response.Write(formatDateTimeC(objRds("orderdate"))) %>
            <br />
            <%else %>
            Order Time: N/A
            <% end if %>
           Order Type: <% If objRds("DeliveryType") = "d" Then %>Delivery<% Elseif objRds("DeliveryType") = "c" then %>Collection<%else %>N/A<% End If %><br>
		   
           Requested for:     &nbsp;
                   <%if objRds("asaporder") = "n" then%> 
                           <%if objRds("DeliveryType") = "c" then%>
				           <%= formatDateTimeC(DateAdd("n",vaveragecol,objRds("orderdate")))%>
				           <%else%>
				           ASAP
				           <%end if%>
                <%elseif objRds("asaporder") = "l" then%>                            
                   <%= formatDateTimeC(objRds("DeliveryTime")) %>
                <%else %>   
                    N/A 
                <%end if%><br>
				

<%
    if  objRds("deliverydelay") & "" <> "" then
        vaveragedel = cint(objRds("deliverydelay"))
    end if
    if  objRds("collectiondelay") & "" <> "" then
            vaveragecol = cint(objRds("collectiondelay"))
    end if

    if objRds("asaporder") = "n" then
if objRds("DeliveryType") = "d" then
mintoadd=vaveragedel ' + 5 ' Add + 5 to match with front end
else
mintoadd=vaveragecol ' + 5 ' Add + 5 to match with front end
end if
%>
<% if objRds("orderdate") & "" <> "" then %>
Accepted to:&nbsp;<%=formatDateTimeC(DateAdd("n",mintoadd,objRds("orderdate")))%>
<% else %>
Accepted to:&nbsp;N/A
<%End if %>
<br>
<%end if%>
          
			<%
               dim PaymentStatus : PaymentStatus = "ORDER UNPAID"
                if lcase( objRds("PaymentType"))="stripe-paid" or objRds("PaymentType")="Paypal-Paid" or  objRds("PaymentType")="NoChex-Paid" or  objRds("PaymentType")="Worldpay-Paid" or Ucase(objRds("Payment_status") & "")="PAID"  then
                    PaymentStatus = "ORDER PAID"
                end if
                 %>
			<div style="border-bottom: 1px solid #e5e5e5;width: 100%;">
		Payment Status:&nbsp;<%=PaymentStatus %></div><br>
<br>


<%
	 notes=objRds("Notes")
	 
	 
        objRds.Close
        set objRds = nothing
        'objCon.Close
     %>
        <%
                
           ' objCon.Open sConnStringcms
            Set objRds = Server.CreateObject("ADODB.Recordset") 
            objRds.Open "select oi.*," & _
                    "mi.Name, mip.Name as PropertyName " & _
                    "from ( OrderItems oi  " & _
                    "inner join MenuItems mi  on oi.MenuItemId = mi.Id ) " & _
                    "left join MenuItemProperties mip  on oi.MenuItemPropertyId = mip.Id " & _
                    "where oi.OrderId = " & vOrderId, objCon


        if objRds.Eof then %>
    
            No Items In Your Order.

        <% 
            objRds.Close
            set objRds = nothing
            objCon.Close
            set objCon = nothing

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
					
					
					Set objRds_dishpropertiesprice = Server.CreateObject("ADODB.Recordset") 
					
	                objRds_dishpropertiesprice.Open "SELECT MenuDishproperties.ID, MenuDishproperties.dishproperty, MenuDishproperties.dishpropertyprice, MenuDishpropertiesGroups.dishpropertypricetype, MenuDishpropertiesGroups.dishpropertygroup FROM MenuDishproperties  INNER JOIN MenuDishpropertiesGroups  ON MenuDishproperties.dishpropertygroupid = MenuDishpropertiesGroups.ID where (((MenuDishproperties.ID)=" & dishpropertiessplit2(1)  & "))", objCon
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
                            set objRds_toppingids  =  nothing
						if toppingtext<>"" then
                            if toppinggroup & "" = "" then
                                toppinggroup = "Toppings"
                            end if 
							toppingtext=left(toppingtext,len(toppingtext)-2)
						response.write "<small><br>"&toppinggroup&": " & toppingtext & "</small>"
						end if
						 End If %>
						</td>
                                <td style="padding-right: 20px; text-align: right;" valign="top"><%=CURRENCYSYMBOL%><%= FormatNumber(objRds("Total"), 2) %></td>                                    
                            </tr>
                    <%  
                        objRds.MoveNext        
                    Loop 
    
                    objRds.Close
                    set objRds = nothing
                    objCon.Close
                    set objCon = nothing
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
                      <% if vShippingFee & "" <> "" then
                          if   Cdbl(vShippingFee ) > 0  then  %>   
                    <tr>
                        <td style="padding-top: 5px; text-align: right;">Delivery Fee&nbsp;</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right;"><%=CURRENCYSYMBOL%><%= FormatNumber(vShippingFee, 2)  %></td>
                    </tr>    
                    <% end if %> 
                     <% end if %> 
                    <% if PaymentStatus = "ORDER PAID" then %>
                          <% if PaymentSurcharge & "" <> "" then
                              if Cdbl(PaymentSurcharge ) > 0 then  %>
					    <tr>
                            <td style="padding-top: 5px; text-align: right;">Credit card surcharge&nbsp;</td>
                            <td style="padding-top: 5px; padding-right: 20px; text-align: right;"> <%=CURRENCYSYMBOL%><%= FormatNumber(PaymentSurcharge, 2)  %>  </td>
                        </tr>
					        <%end if%>    
                        <%end if%>     
                         
                       
                    <%End IF %>  
                     <% if ServiceCharge & "" <> "" then 
                              if   Cdbl(ServiceCharge ) > 0  then  %>
					    <tr>
                            <td style="padding-top: 5px; text-align: right;">Service charge&nbsp;</td>
                            <td style="padding-top: 5px; padding-right: 20px; text-align: right;"> <%=CURRENCYSYMBOL%><%= FormatNumber(ServiceCharge, 2)  %>  </td>
                        </tr>
					        <%end if%>       
                        <%end if%>  
                     <% if cdbl( Tax_Amount) > 0 then  %>
                         <tr>
                            <td style="padding-top: 5px; text-align: right;">Tax(<%=TaxRate %>%)&nbsp;</td>
                            <td style="padding-top: 5px; padding-right: 20px; text-align: right;"> <%=CURRENCYSYMBOL%><%= FormatNumber(Tax_Amount, 2)  %>  </td>
                        </tr>   
                        <% end if %>
                         <% if cdbl( Tip_Amount) > 0 then  %>
                         <tr>
                            <td style="padding-top: 5px; text-align: right;">Tip(<%=TipRate %>)&nbsp;</td>
                            <td style="padding-top: 5px; padding-right: 20px; text-align: right;"> <%=CURRENCYSYMBOL%><%= FormatNumber(Tip_Amount, 2)  %>  </td>
                        </tr>   
                        <% end if %>
                    <tr>
                        <td style="padding-top: 5px;text-align: right;"><b>Total&nbsp;</b></td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right;">
                            
                            <% if vOrderTotal & "" <> "" then %>
                            <b><%=CURRENCYSYMBOL%><%= FormatNumber(vOrderTotal, 2)  %></b>
                            <%else %>
                                 <b><%=CURRENCYSYMBOL%><%= FormatNumber(vSubTotal, 2)  %></b>
                            <% end if %>
                            </td>
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
                      <br />
                      <% if numberOfOrder > 0 then %>
    <div style="width: 300px;margin-left:auto;margin-right:auto;">
            <div style="display: block;width: 100%;padding: 0;margin-bottom: 3px; line-height: inherit;color: #333;border: 0; font-size:13px;">Number of Orders: <%= numberOfOrder %>  </div>
                                     
        </div>
                      <% end if %>
			    </div>
			</div>
		</div>
	</div>
</div>
