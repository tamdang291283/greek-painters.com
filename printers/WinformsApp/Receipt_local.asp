<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../../Config.asp" -->
<%
    session("restaurantid")=Request.QueryString("id_r")
     %>
<!-- #include file="../../timezone.asp" -->
<!-- #include file="../../restaurantsettings.asp" -->
<%       
    Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 
    Dim vRestaurantId
    dim vOrderId
     Dim sAverageDeliveryTime
    Dim sAverageCollectionTime
    Dim LocalEpsonJSPrinterURL
        vRestaurantId = Request.QueryString("id_r")
        vOrderId = Request.QueryString("id_o")
    objCon.Open sConnString
    objRds.Open "SELECT * FROM BusinessDetails WHERE Id = " & vRestaurantId, objCon    
    vaveragedel = objRds("AverageDeliveryTime")
	vaveragecol = objRds("AverageCollectionTime")
    if Not IsNull(objRds("AverageDeliveryTime")) Then sAverageDeliveryTime = Cdbl(objRds("AverageDeliveryTime"))
    if Not IsNull(objRds("AverageCollectionTime")) Then sAverageCollectionTime = Cdbl(objRds("AverageCollectionTime"))   
     LocalEpsonJSPrinterURL =  objRds("LocalPrinterURL") 
        
	name=objRds("Name")
	address= objRds("Address") 
	telephone=objRds("telephone") 
	email=  objRds("email")       
        objRds.Close
        objCon.Close       
      


         objCon.Open sConnString
        objRds.Open "select * from [Orderslocal]  " & _
            "where Id = " & vOrderId, objCon
        If objRds.EOF Then
            Response.Write("Invalid order!")
            Response.end()
        End If 

        dim vShippingFee
        dim vSubTotal
        dim vOrderTotal
        Dim ServiceCharge , vvouchercode, vvouchercodediscount,PaymentSurcharge,VoucherDiscountType
        PaymentSurcharge = objRds("PaymentSurcharge")
         If PaymentSurcharge & "" = "" Then
            PaymentSurcharge = "0"
        End If
           dim Tax_Amount,Tip_Amount
        Tax_Amount = objRds("Tax_Amount")
        Tip_Amount = objRds("Tip_Amount")
         If Tax_Amount & "" = "" Then
            Tax_Amount = "0"
        End If
         If Tip_Amount & "" = "" Then
            Tip_Amount = "0"
        End If
         Dim TipRate : TipRate = objRds("Tip_Rate")
        if TipRate  & "" = "" then
            TipRate = "0"
        end if
        if TipRate & "" <> "custom" then
            TipRate =  TipRate & "%"
        end if
        vShippingFee = objRds("ShippingFee")
        vSubTotal = objRds("SubTotal")
        vOrderTotal = objRds("OrderTotal")
        
        ServiceCharge = objRds("ServiceCharge")
        If ServiceCharge & "" = "" Then
            ServiceCharge = "0"
        End If
         vvouchercode = ""
        vvouchercodediscount = ""
        vvouchercodediscount = objRds("vouchercodediscount")
		vvouchercode=objRds("vouchercode")
        VoucherDiscountType = objRds("DiscountType")
%>
   
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<meta charset="utf-8">
	<title>Order</title>
</head>

<style>
    <% if PrinterFontSizeRatio & "" <> "" Then %>
    .title-size {font-size:<%=36*PrinterFontSizeRatio%>px;}
    .heading-size {font-size:<%=34*PrinterFontSizeRatio%>px;}
    .item-size {font-size:<%=31*PrinterFontSizeRatio%>px;}
    .big-printing-size {font-size:<%=51*PrinterFontSizeRatio%>px;}
    .tb-item-size {font-size:<%=31*PrinterFontSizeRatio%>px;table-layout:fixed;}
     .tb-item-size  td {
        padding: 3px 0;
    }
    <% else %>
     .title-size {font-size:36px;}
    .heading-size {font-size:34px;}
    .item-size {font-size:31px;}
    .tb-item-size {font-size:31px;table-layout:fixed;}
    .big-printing-size {font-size:51px;}
    .tb-item-size  td {
        padding: 3px 0;
    }
    <% end if %>
       * {    
         font-family: Arial;
        }
</style>
<body style="width:512px;">
 <div class="row">
        <div class="span12">
           <div align="center">
			<p class="title-size">In-Restaurant - Order <%=Request.QueryString("id_o")%> </p></div>
        </div>
    </div>
    
	<div style="width: 492px;margin-left:auto;margin-right:auto;margin-bottom:30px;">
        <div class="">
           <div class="">
               <div align="center"> <img src="<%=SITE_URL %>images/in-restaurant.png" style="vertical-align: middle;"> 
                   
                  
                   <span class="shop-name heading-size" style="border-bottom: 1px solid #e5e5e5;width: 100%;"><%if objRds("PaymentType")="Stripe-Paid" or  objRds("PaymentType")="Paypal-Paid" or objRds("PaymentType")="NoChex-Paid" or objRds("PaymentType")="Worldpay-Paid" or Ucase(objRds("Payment_status") & "")="PAID"  then  %><b>ORDER PAID</b><%else%><b>ORDER UNPAID</b><%end if%></span>  </div>
            </div>
        </div>
    </div>
	
	   <div style="width: 492px;margin-left:auto;margin-right:auto;" class="item-size">
        <div class="">
           <div class="shop-info">
                <span class="shop-name"><%=name %></span><br />
                <span class="shop-address"><%=address%></span><br />
                <span class="shop-name">Tel. <%=telephone %></span><br />                       
                <span class="shop-address">Email: <%=email %></span><br />           
            </div>
        </div>
    </div>
	
    <div style="width: 492px; clear:both;margin-left:auto;margin-right:auto" class="item-size">
        <br />
    <div class="heading-size" style="   display: block;width: 100%;padding: 0;margin-bottom: 3px; line-height: inherit;color: #333;border: 0; border-bottom: 1px solid #e5e5e5; font-weight:bolder;">
              Customer
            </div>
			<% If request.QueryString("table") & "" <> "" Then 
                    Response.Write(request.QueryString("table"))
               Else %>
                <%= objRds("FirstName") %>&nbsp;<%= objRds("LastName") %>
                <br />
           <% End if %>
    </div>
    <br />
    <br />        
    <div style="width: 492px;margin-left:auto;margin-right:auto;" class="item-size">
  <div class="heading-size" style="   display: block;width: 100%;padding: 0;margin-bottom: 3px; line-height: inherit;color: #333;border: 0; border-bottom: 1px solid #e5e5e5;font-weight:bolder;">Order Details</div>

Order Number: <%=Request.QueryString("id_o")%>
<br>         Order Time: <%response.write(formatDateTimeC(objRds("orderdate")))%><br />
			 Payment Status:&nbsp;<%if objRds("PaymentType")="Stripe-Paid" or  objRds("PaymentType")="Paypal-Paid" or  objRds("PaymentType")="NoChex-Paid" or  objRds("PaymentType")="Worldpay-Paid" or Ucase(objRds("Payment_status") & "")="PAID"  then  %>ORDER PAID<%else%>ORDER UNPAID<%end if%><br><br>

  <%notes=objRds("Notes")
   
      if notes & "" = "" And Request.Cookies("Specialinput") & "" <> "" Then
        notes = Request.Cookies("Specialinput")
      End if
        objRds.Close
        objCon.Close
     %>
        <%
                
            objCon.Open sConnString
            objRds.Open "select oi.*," & _
                    "mi.Name, mip.Name as PropertyName,mip.printingname as Propertyprintingname, mi.PrintingName " & _
                    "from ( OrderItemsLocal oi " & _
                    "inner join MenuItems mi on oi.MenuItemId = mi.Id ) " & _
                    "left join MenuItemProperties mip on oi.MenuItemPropertyId = mip.Id " & _
                    "where oi.OrderId = " & vOrderId, objCon
        if objRds.Eof then %>    
            No Items In Your Order.
        <% 
            objRds.Close
            objCon.Close
        else
              Dim namePrintingMode
                  namePrintingMode = Request.QueryString("mod")
             %>               
                <table style="width: 100%;" class="item-size">  
                 <%
                    Do While NOT objRds.Eof  %>
                            <tr>
                                <% if  namePrintingMode & "" = "printingname" then  %>
                                    <td style="width:15%; vertical-align: text-top;"> <span class="big-printing-size">  <%= objRds("Qta") %>   </span> x &nbsp;</td>
                                <% else %>
                                    <td style="width:15%; vertical-align: text-top;text-top;">   <%= objRds("Qta") %>  x  &nbsp;</td>
                                <% end if %>
                                
                                    <% If namePrintingMode & "" = "" then  %>
                                <td style="vertical-align: text-top;width:60%;">  <%= objRds("Name") %> <% If objRds("PrintingName") & "" <> "" Then %> <br /><span class="big-printing-size"><%=objRds("PrintingName") %></span><% End If %>
                                      <% if objRds("PropertyName") & "" <> "" then %>
                                        <br/><%= objRds("PropertyName") %> 
                                        <% end if %>
						         <% elseIf namePrintingMode & "" = "dishname" then  %>    
                                 <td style="vertical-align: text-top;" >  <%= objRds("Name") %> 
                                     <% if objRds("PropertyName") & "" <> "" then %>
                                         <br /><%= objRds("PropertyName") %> 
                                        <% end if %>
                                <% elseif  namePrintingMode & "" = "printingname" then  %>
                                  <td style="vertical-align: text-top;text-top;width:60%;"> <!-- <span class="big-printing-size"><%=objRds("PrintingName") %></span>-->
                                       <% if objRds("Propertyprintingname") & "" <> "" then  %>
                                        <span class="big-printing-size"> <%= objRds("Propertyprintingname") %> </span>
                                      <% elseif objRds("PropertyName")  & "" <> "" then %>
                                        <span class="big-printing-size"> <%= objRds("PropertyName") %> </span>
                                      <%else %>
                                        <span class="big-printing-size"><%=objRds("PrintingName") %></span>
                                     <%end if %>
                                <% end if %>  
                                
						<%
						'display toppings in basket area
						If objRds("dishpropertiesids") <> "" Then						 
						    dishpropertiessplit=split(objRds("dishpropertiesids"),",")
					        for i=0 to ubound(dishpropertiessplit)					
					                dishpropertiessplit2=split(dishpropertiessplit(i),"|")				
					                
					                Set objRds_dishpropertiesprice = Server.CreateObject("ADODB.Recordset") 
					                
	                                objRds_dishpropertiesprice.Open "SELECT MenuDishproperties.ID, MenuDishproperties.dishproperty, MenuDishproperties.printingname as dishpropertyPrintingname, MenuDishproperties.dishpropertyprice, MenuDishpropertiesGroups.dishpropertypricetype, MenuDishpropertiesGroups.dishpropertygroup, MenuDishpropertiesGroups.printingname as dishpropertygroupPrintingname FROM MenuDishproperties INNER JOIN MenuDishpropertiesGroups ON MenuDishproperties.dishpropertygroupid = MenuDishpropertiesGroups.ID where (((MenuDishproperties.ID)=" & dishpropertiessplit2(1)  & "))", objCon
                                    if not objRds_dishpropertiesprice.EOF then
					                         dim dishpropertygroup : dishpropertygroup = objRds_dishpropertiesprice("dishpropertygroup") & "" 
                                             dim dishproperty : dishproperty = objRds_dishpropertiesprice("dishproperty") & "" 
                                                 if  namePrintingMode & "" = "printingname" then
                                                        if objRds_dishpropertiesprice("dishpropertygroupPrintingname") & "" <> "" then
                                                                 dishpropertygroup = objRds_dishpropertiesprice("dishpropertygroupPrintingname") & "" 
                                                        end if
                             
                                                        if objRds_dishpropertiesprice("dishpropertyPrintingname") & "" <> "" then
                                                                 dishproperty = objRds_dishpropertiesprice("dishpropertyPrintingname") & "" 
                                                        end if
                                                end if
					                         'response.write "<BR> <small>" & dishpropertygroup & ":" & dishproperty & "</small>"
                                            if  namePrintingMode & "" = "printingname" then
					                            response.write "<BR> <small><span class=""big-printing-size"">" & dishpropertygroup & ":" & dishproperty & "</span></small>"
                                            else
                                                response.write "<BR> <small>" & dishpropertygroup & ":" & dishproperty & "</small>"
                                            end if
                                    end if
					        next
					    end if%>
						<%
						toppingtext=""
                        dim toppingGroup : toppingGroup = "" 
						If objRds("toppingids") <> "" Then 
						        
								Set objRds_toppingids = Server.CreateObject("ADODB.Recordset") 
          			                
                                Set objRds_toppingids_group = Server.CreateObject("ADODB.Recordset")     
                            
                                dim SQLtopping : SQLtopping = "" 
                                    SQLtopping = "select top 1 ID, toppingsgroup,printingname  from Menutoppingsgroups  where id in (select toppinggroupid from menutoppings where id  in (" & objRds("toppingids")& ")  ) "
                                objRds_toppingids_group.Open SQLtopping, objCon
                                if not objRds_toppingids_group.EOF then
                                    toppingGroup = objRds_toppingids_group("toppingsgroup")
                                    if  namePrintingMode & "" = "printingname" and objRds_toppingids_group("printingname") & "" <> ""  then
                                        toppingGroup =   objRds_toppingids_group("printingname") 
                                    end if
                                end if
						         objRds_toppingids_group.close()
                                set objRds_toppingids_group = nothing
                                if toppingGroup & "" = "" then
                                    toppingGroup = "Toppings"
                                end if

                    objRds_toppingids.Open "SELECT * FROM MenuToppings where id in (" & objRds("toppingids") & ")", objCon
				        Do While NOT objRds_toppingids.Eof 
                            dim topping : topping =  objRds_toppingids("topping")
                                 if  namePrintingMode & "" = "printingname" and objRds_toppingids("printingname") & "" <> ""  then
                                     topping =  objRds_toppingids("printingname")
                                 end if

						    toppingtext = toppingtext & topping & ", "
						    objRds_toppingids.MoveNext
						loop
                            objRds_toppingids.close()
                            set objRds_toppingids = nothing
						if toppingtext<>"" then
							toppingtext=left(toppingtext,len(toppingtext)-2)
						'response.write "<small><br>Toppings: " & toppingtext & "</small>"
                            if  namePrintingMode & "" = "printingname" then
                                response.write "<small><br><span class=""big-printing-size"">"& toppingGroup  &": " & toppingtext & "</span></small>"
                            else
						        response.write "<small><br>"& toppingGroup  &": " & toppingtext & "</small>"
                            end if
						end if
						 End If %>
						</td>
                                <td style="padding-right: 20px; text-align: right;width:25%;" valign="top"><%=CURRENCYSYMBOL%><%= FormatNumber(objRds("Total"), 2) %></td>                                    
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
                            <%if vvouchercode<>"" then%>
					<tr>
                        <td colspan="2" style="padding-top: 5px; text-align: right; border-top: 1px dotted black;">Discount code:&nbsp;<br /> <%=vvouchercode%><% if VoucherDiscountType & "" <> "Amount" then %> (-<%=vvouchercodediscount%>%)<%end if %>&nbsp; </td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right; border-top: 1px dotted black;">-<%=CURRENCYSYMBOL%><% if VoucherDiscountType & "" <> "Amount" then %><%= FormatNumber((( vSubTotal * 100 )/(100- Cdbl(Replace(Replace(Replace(vvouchercodediscount,"-",""),"%","")," ",""))) - vSubTotal ),2) %><%else %><%=FormatNumber(Cdbl(Replace(Replace(Replace(vvouchercodediscount,"-",""),"%","")," ","")),2) %><%end if %> </td>
                    </tr>
					<%end if%>   
                        <tr>
                        <td colspan="2" style="padding-top: 5px; text-align: right; border-top: 1px dotted black;">SubTotal:</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right; border-top: 1px dotted black;"><%=CURRENCYSYMBOL%><%= FormatNumber(vSubTotal, 2)  %></td>
                    </tr>    
                     <%if  Cdbl(PaymentSurcharge) > 0 then  %>
					<tr>
                         <td colspan="2" style="padding-top: 5px; text-align: right;">Credit card surcharge:</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right;"><%=CURRENCYSYMBOL%><%= FormatNumber(PaymentSurcharge, 2)  %></td>
                      
                    </tr>
					<%end if%>     
                     <% If CDbl(ServiceCharge) > 0 Then   %>   
                    <tr>
                        <td colspan="2" style="padding-top: 5px; text-align: right;">Service charge:</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right;"><%=CURRENCYSYMBOL%><%= FormatNumber(ServiceCharge, 2)  %></td>
                    </tr>    
                   <% end If  %> 
                    <%if CDbl(Tax_Amount) > 0  then  %>
					<tr>
                        <td colspan="2" style="padding-top: 5px; text-align: right;">Tax(<%=Tax_percent %>%):</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right;"> <%=CURRENCYSYMBOL%><%= FormatNumber(Tax_Amount, 2)  %>  </td>
                    </tr>
					<%end if%>  
                     <%if CDbl(Tip_Amount) > 0  then  %>
					<tr>
                        <td colspan="2" style="padding-top: 5px; text-align: right;">Tip:(<%=TipRate %>)</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right;"> <%=CURRENCYSYMBOL%><%= FormatNumber(Tip_Amount, 2)  %>  </td>
                    </tr>
					<%end if%>   
                    <tr>
                        <td colspan="2" style="padding-top: 5px;text-align: right;"><b>Total:</b></td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right;"><b><%=CURRENCYSYMBOL%><%= FormatNumber(vOrderTotal, 2)  %></b></td>
                    </tr>    
                       
                </table>
          
            <% End If %>  
       	
		
		  <% If notes <> "" Then %>
      <div style="width: 512px;margin-left:auto;margin-right:auto;" class="item-size">
            <div class="heading-size" style="   display: block;width: 100%;padding: 0;margin-bottom: 3px; line-height: inherit;color: #333;border: 0; border-bottom: 1px solid #e5e5e5;font-weight:bolder;">Special instructions:</div>
               <%= (replace(notes,chr(10),"<br />")) %>                        
        </div>
    <% End If %>                
	</div>
	
	</body>

    <% 
 
         objCon.Close
         Set objCon = nothing

         %>

</html>
