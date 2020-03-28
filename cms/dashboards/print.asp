<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../../Config.asp" -->
<!-- #include file="../timezone.asp" -->
<% 
    Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 

    Dim vRestaurantId
    dim vOrderId
     Dim sAverageDeliveryTime
    Dim sAverageCollectionTime
    Dim ShowRestaurantDetailOnReceipt
    
    vRestaurantId = Request.QueryString("id_r")
    vOrderId = Request.QueryString("id_o")

    objCon.Open sConnStringcms
    objRds.Open "SELECT * FROM BusinessDetails  WHERE Id = " & vRestaurantId, objCon    
    vaveragedel = objRds("AverageDeliveryTime")
	vaveragecol = objRds("AverageCollectionTime")
    if Not IsNull(objRds("AverageDeliveryTime")) Then sAverageDeliveryTime = Cdbl(objRds("AverageDeliveryTime"))
    if Not IsNull(objRds("AverageCollectionTime")) Then sAverageCollectionTime = Cdbl(objRds("AverageCollectionTime"))  
    
    If Not IsNull(objRds("ShowRestaurantDetailOnReceipt")) Then
        ShowRestaurantDetailOnReceipt = Lcase(objRds("ShowRestaurantDetailOnReceipt"))
    Else
        ShowRestaurantDetailOnReceipt = "1"
    End If 
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<meta charset="utf-8">
	<title>Order</title>
</head>


<body>


 <div class="row">
        <div class="span12">
           <div align="center">
			<p>Order <%=Request.QueryString("id_o")%> from <%= objRds("Name") %> </p></div>
        </div>
    </div>

 
    
        
    <%   
	name=objRds("Name")
	address= objRds("Address") 
	telephone=objRds("telephone") 
	email=  objRds("email")       
        objRds.Close
        set objRds = nothing
       Set objRds = Server.CreateObject("ADODB.Recordset") 
        objRds.Open "select * from [Orders]    " & _
            "where Id = " & vOrderId, objCon

        dim vShippingFee
        dim vSubTotal
        dim vOrderTotal

        vShippingFee = objRds("ShippingFee")
        vSubTotal = objRds("SubTotal")
        vOrderTotal = objRds("OrderTotal")

        Dim PaymentSurcharge, ServiceCharge,Tip_Amount,Tax_Amount,VoucherDiscountType
         PaymentSurcharge = objRds("PaymentSurcharge")
        Tip_Amount = objRds("Tip_Amount")
        Tax_Amount =  objRds("Tax_Amount")
        Dim TipRate : TipRate = objRds("Tip_Rate")
        if TipRate  & "" = "" then
            TipRate = "0"
        end if
        if TipRate & "" <> "custom" then
            TipRate =  TipRate & "%"
        end if
        If PaymentSurcharge & "" = "" Then
            PaymentSurcharge = "0"
        End If
        ServiceCharge = objRds("ServiceCharge")
        If ServiceCharge & "" = "" Then
            ServiceCharge = "0"
        End If
         If Tip_Amount & "" = "" Then
            Tip_Amount = "0"
        End If
         If Tax_Amount & "" = "" Then
            Tax_Amount = "0"
        End If
       vvouchercodediscount = objRds("vouchercodediscount")
		vvouchercode=objRds("vouchercode")  
        VoucherDiscountType =   objRds("DiscountType") 
    %>
	<div style="width: 300px;margin-left:auto;margin-right:auto;margin-bottom:30px;">
        <div class="">
           <div class="">
               <div align="center">  <span class="shop-name" style="border-bottom: 1px solid #e5e5e5;width: 100%;"><%if objRds("PaymentType")="Stripe-Paid" or  objRds("PaymentType")="Paypal-Paid" or objRds("PaymentType")="NoChex-Paid" or objRds("PaymentType")="Worldpay-Paid" or Ucase(objRds("Payment_status") & "")="PAID"  then  %><b>ORDER PAID</b><%else%><b>ORDER UNPAID</b><%end if%></span>  </div>
            </div>
        </div>
    </div>
		<% If ShowRestaurantDetailOnReceipt & "" = "1" Then %>
	   <div style="width: 300px;margin-left:auto;margin-right:auto;">
        <div class="">
           <div class="shop-info">
                <span class="shop-name"><%=name %></span><br />
                <span class="shop-address"><%=address%></span><br />
                <span class="shop-name">Tel. <%=telephone %></span><br />                       
                <span class="shop-address">Email: <%=email %></span><br /><br /><br />
            </div>
        </div>
    </div>
	<% End If %>
	


    <div style="width: 300px; clear:both;margin-left:auto;margin-right:auto;">
<div style="   display: block;width: 100%;padding: 0;margin-bottom: 3px;font-size: 21px; line-height: inherit;color: #333;border: 0; border-bottom: 1px solid #e5e5e5;">
                Customer Details
            </div>
			
            <%= objRds("FirstName") %>&nbsp;<%= objRds("LastName") %><br />
            <%= objRds("Address") %>,&nbsp;<%= objRds("PostalCode") %><br />
            <%= objRds("Phone") %><br />
            <%= objRds("Email") %><br />
            <br />
           
               
                
  
    </div>
            
    

    
   
    
  
        
    <div style="width: 300px;margin-left:auto;margin-right:auto;">
  <div style="   display: block;width: 100%;padding: 0;margin-bottom: 3px;font-size: 21px; line-height: inherit;color: #333;border: 0; border-bottom: 1px solid #e5e5e5;">Order Details</div>

Order Number: <%=Request.QueryString("id_o")%>


<br>
			
			 Order Time: <%Response.Write(formatDateTimeC(objRds("orderdate")))%>
<br />
           Order Type: <% If objRds("DeliveryType") = "d" Then %>Delivery<% Else %>Collection<% End If %>
              
				<br>
				
				   Requested for:     &nbsp;<%if objRds("asaporder") = "n" then%>
				   
				   <%if objRds("DeliveryType") = "c" then%>
				   <%=formatDateTimeC(DateAdd("n",vaveragecol,objRds("orderdate")))%>
				   <%else%>
				   ASAP
				   <%end if%>
				   
				   <%else%><%= formatDateTimeC(objRds("DeliveryTime")) %><%end if%><br>
				
<%
 if  objRds("deliverydelay") & "" <> "" then
    vaveragedel = cint(objRds("deliverydelay"))
end if
if  objRds("collectiondelay") & "" <> "" then
        vaveragecol = cint(objRds("collectiondelay"))
end if
if objRds("asaporder") = "n" then
if objRds("DeliveryType") = "d" then
mintoadd=vaveragedel
else
mintoadd=vaveragecol
end if
%>
Accepted for:&nbsp;<%=formatDateTimeC(DateAdd("n",mintoadd,objRds("orderdate")))%>
<br>
<%end if%>
          

          
			
			<div style="border-bottom: 1px solid #e5e5e5;width: 100%;">
			Payment Status:&nbsp;<%if objRds("PaymentType")="Stripe-Paid" or objRds("PaymentType")="Paypal-Paid" or  objRds("PaymentType")="NoChex-Paid" or  objRds("PaymentType")="Worldpay-Paid" or Ucase(objRds("Payment_status") & "")="PAID"  then  %>ORDER PAID<%else%>ORDER UNPAID<%end if%></div><br>
<br>
  <%notes=objRds("Notes")
        objRds.Close
      set objRds = nothing
       
                
            'objCon.Open sConnStringcms
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
					
	                objRds_dishpropertiesprice.Open "SELECT MenuDishproperties.ID, MenuDishproperties.dishproperty, MenuDishproperties.dishpropertyprice, MenuDishpropertiesGroups.dishpropertypricetype, MenuDishpropertiesGroups.dishpropertygroup FROM MenuDishproperties  INNER JOIN MenuDishpropertiesGroups   ON MenuDishproperties.dishpropertygroupid = MenuDishpropertiesGroups.ID where (((MenuDishproperties.ID)=" & dishpropertiessplit2(1)  & "))", objCon
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
                            set objRds_toppingids = nothing
						if toppingtext<>"" then
                            if toppinggroup & "" = "" then
                                toppinggroup = "Toppings"
                            end if
							toppingtext=left(toppingtext,len(toppingtext)-2)
						response.write "<small><br>"&toppinggroup&": " & toppingtext & "</small>"
						end if
						 End If %>
						</td>
                                <td style="padding-right: 20px; text-align: right;" valign="top"><%= FormatNumber(objRds("Total"), 2) %></td>                                    
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
                        <td style="padding-top: 5px; text-align: right; border-top: 1px dotted black;">Discount code:&nbsp;<br /><%=vvouchercode%><%if VoucherDiscountType <> "Amount" then %> (-<%=vvouchercodediscount%>%)<%end if %>&nbsp; </td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right; border-top: 1px dotted black;"> -<%=CURRENCYSYMBOL%><%if VoucherDiscountType <> "Amount" then %><%= FormatNumber((( vSubTotal * 100 )/(100- Cdbl(Replace(Replace(Replace(vvouchercodediscount,"-",""),"%","")," ",""))) - vSubTotal ),2) %><%else %><%=FormatNumber(Cdbl(Replace(Replace(Replace(vvouchercodediscount,"-",""),"%","")," ",""))),2) %><%end if %> </td>
                    </tr>
					<%end if%>
                        <tr>
                        <td style="padding-top: 5px; text-align: right; border-top: 1px dotted black;">SubTotal</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right; border-top: 1px dotted black;"><%= FormatNumber(vSubTotal, 2)  %></td>
                    </tr>       
                     <% If Cdbl(vShippingFee) > 0 Then %>   
                    <tr>
                        <td style="padding-top: 5px; text-align: right;">Delivery Fee</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right;"><%= FormatNumber(vShippingFee, 2)  %></td>
                    </tr>    
                    <% end If %>
                      <%if  Cdbl(PaymentSurcharge) > 0 then  %>
                      <tr>
                        <td style="padding-top: 5px;text-align: right;">Credit card surcharge:</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right;"><%= FormatNumber(PaymentSurcharge, 2)  %></td>
                    </tr>    
                    <% End If %>
                     <%if  Cdbl(ServiceCharge) > 0 then  %>
                      <tr>
                        <td style="padding-top: 5px;text-align: right;">Service charge:</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right;"><%= FormatNumber(ServiceCharge, 2)  %></td>
                    </tr>       
                    <% end if %>
                       <%if  Cdbl(Tax_Amount) > 0 then  %>
                      <tr>
                        <td style="padding-top: 5px;text-align: right;">Tax(<%=Tax_Percent %>%):</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right;"><%= FormatNumber(Tax_Amount, 2)  %></td>
                    </tr>       
                    <% end if %>
                       <%if  Cdbl(Tip_Amount) > 0 then  %>
                      <tr>
                        <td style="padding-top: 5px;text-align: right;">Tip:("<%=TipRate %>")</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right;"><%= FormatNumber(Tip_Amount, 2)  %></td>
                    </tr>       
                    <% end if %>
                    <tr>
                        <td style="padding-top: 5px;text-align: right;"><b>Total</b></td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right;"><b><%= FormatNumber(vOrderTotal, 2)  %></b></td>
                    </tr>    
                </table>
          
            <% End If %>  
       	
		
		  <% If notes <> "" Then %>
      <div style="width: 300px;margin-left:auto;margin-right:auto;">
            <div style="   display: block;width: 100%;padding: 0;margin-bottom: 3px;font-size: 21px; line-height: inherit;color: #333;border: 0; border-bottom: 1px solid #e5e5e5;">Special instructions:</div>
               <%= (replace(notes,chr(13),"<br />")) %>
                        
        </div>
    <% End If %>                
	</div>
	<script>window.print();
 setTimeout(window.close, 0);</script>
	</body>
</html>
