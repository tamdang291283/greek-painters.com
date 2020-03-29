<!-- #include file="../../Config.asp" -->
<%session("restaurantid")=request.querystring("id")%>
<!-- #include file="../../timezone.asp" -->

<%
 
 Function FormatEngDatewithTime(dteDate)
    If IsDate(dteDate) = True Then
        Dim dteDay, dteMonth, dteYear
        dteDay = Day(dteDate)
        dteMonth = Month(dteDate)
        dteYear   = right(Year(dteDate),2)
		dteHour  = Hour(dteDate)
		dteMinute   = Minute(dteDate)
		if len(dteMinute)=1 then
		dteMinute = "0" & dteMinute
		end if
        FormatEngDatewithTime = dteHour & ":" & dteMinute & " " & Right(Cstr(dteDay + 100),2) & "-" & Right(Cstr(dteMonth + 100),2)  & "-" & dteYear 
        Else
        FormatEngDatewithTime = Null
    End If
End Function



Function postFormData(url, data)
    Dim xhr : Set xhr = Server.CreateObject("MSXML2.ServerXMLHTTP.3.0")
    xhr.open "POST", url, false
    xhr.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
    xhr.send Data
    If (xhr.Status = 200) then
       postFormData = xhr.ResponseText
	   response.write "200" & postFormData
    Else
        Err.Raise 1001, "postFormData", "Post to " & url & " failed with " & xhr.Status
		response.write "not 200" & xhr.Status
    End If
End Function




    Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 	
	   objCon.Open sConnString
       objRds.Open "SELECT *  FROM view_paid_orders  WHERE  printed=0 " , objCon
Do While NOT objRds.Eof
    Set objRdsconfig = Server.CreateObject("ADODB.Recordset") 
        objRdsconfig.Open "SELECT *  FROM BusinessDetails  WHERE Id = " & objRds("IdBusinessDetail"), objCon
x="api_key=" & objRdsconfig("IBT_API_KEY") & "&api_password=" & objRdsconfig("IBP_API_PASSWORD") 
x=x & "&receipt_footer=" & Server.URLEncode("Thank you")

x=x & "&notify_url=" & Server.URLEncode(SITE_URL & "/printers/IBT/_iconnectresponse.asp")
x=x & "&printer_id=" & Server.URLEncode("6102")
x=x & "&currency=" & Server.URLEncode("GBP")
x=x & "&receipt_header=" & Server.URLEncode("Order")
'********** set-up live order id **********
x=x & "&order_id=" & objRds("id")
x=x & "&card_fee=" & Server.URLEncode("0")
response.write objRds("id")
SMTP_AUTENTICATE=objRdsconfig("SMTP_AUTENTICATE")
MAIL_FROM=objRdsconfig("MAIL_FROM")
PAYPAL_URL=objRdsconfig("PAYPAL_URL")
PAYPAL_PDT=objRdsconfig("PAYPAL_PDT")
PAYPAL_ADDR=objRdsconfig("PAYPAL_ADDR")
SMTP_PASSWORD=objRdsconfig("SMTP_PASSWORD")
GMAP_API_KEY=objRdsconfig("GMAP_API_KEY")
SMTP_USERNAME=objRdsconfig("SMTP_USERNAME")
SMTP_USESSL=objRdsconfig("SMTP_USESSL")
MAIL_SUBJECT=objRdsconfig("MAIL_SUBJECT")
CURRENCYSYMBOL=objRdsconfig("CURRENCYSYMBOL")
SMTP_SERVER=objRdsconfig("SMTP_SERVER")
CREDITCARDSURCHARGE=objRdsconfig("CREDITCARDSURCHARGE")
SMTP_PORT=objRdsconfig("SMTP_PORT")
STICK_MENU=objRdsconfig("STICK_MENU")
MAIL_CUSTOMER_SUBJECT=objRdsconfig("MAIL_CUSTOMER_SUBJECT")
CONFIRMATION_EMAIL_ADDRESS=objRdsconfig("CONFIRMATION_EMAIL_ADDRESS")
SEND_ORDERS_TO_PRINTER=objRdsconfig("SEND_ORDERS_TO_PRINTER")
NOCHEX=objRdsconfig("nochex")
NOCHEXMERCHANTID=objRdsconfig("nochexmerchantid")
WORLDPAY=objRdsconfig("worldpay")
WORDLPAYMERCHANTID=objRdsconfig("worldpaymerchantid")
PAYPAL=objRdsconfig("paypal")
 vaveragedel = objRdsconfig("AverageDeliveryTime")
 vaveragecol = objRdsconfig("AverageCollectionTime")
        objRdsconfig.Close
    set objRdsconfig = nothing

	 
	  if SEND_ORDERS_TO_PRINTER="IBT" then
	     if objRds("DeliveryType")="c" then
	        x=x & "&order_type=" & Server.URLEncode("2")
	     else
	        x=x & "&order_type=" & Server.URLEncode("1")
	     end if
	 
	 Set objRds2 = Server.CreateObject("ADODB.Recordset") 	 
        objRds2.Open "select oi.*,mi.Name, mip.Name as PropertyName from ( OrderItems oi  inner join MenuItems mi on oi.MenuItemId = mi.Id )  left join MenuItemProperties mip on oi.MenuItemPropertyId = mip.Id where oi.OrderId = " & objRds("id"), objCon
	 c=0
	 Do While NOT objRds2.Eof
	 y=""
	 c=c+1

	 
	 x=x & "&cat_" & c & "=Item" 
	  x=x & "&item_" & c & "=" & Server.URLEncode(objRds2("Name"))
	                If objRds2("dishpropertiesids") <> "" Then						 
						    dishpropertiessplit=split(objRds2("dishpropertiesids"),",")
					    for i=0 to ubound(dishpropertiessplit)
					        dishpropertiessplit2=split(dishpropertiessplit(i),"|")
					        Set objRds_dishpropertiesprice = Server.CreateObject("ADODB.Recordset") 
	                        objRds_dishpropertiesprice.Open "SELECT MenuDishproperties.ID, MenuDishproperties.dishproperty, MenuDishproperties.dishpropertyprice, MenuDishpropertiesGroups.dishpropertypricetype, MenuDishpropertiesGroups.dishpropertygroup FROM MenuDishproperties INNER JOIN MenuDishpropertiesGroups ON MenuDishproperties.dishpropertygroupid = MenuDishpropertiesGroups.ID where (((MenuDishproperties.ID)=" & dishpropertiessplit2(1)  & "))", objCon
                            if not objRds_dishpropertiesprice.EOF then
                                y = y & (objRds_dishpropertiesprice("dishpropertygroup") & "-" & objRds_dishpropertiesprice("dishproperty"))				    
                            end if
					    next
					end if
					
					toppingtext=""
					If objRds2("toppingids") <> "" Then 
								Set objRds_toppingids = Server.CreateObject("ADODB.Recordset") 
                        objRds_toppingids.Open "SELECT * FROM MenuToppings where id in (" & objRds2("toppingids") & ")", objCon
				        Do While NOT objRds_toppingids.Eof 
						        toppingtext = toppingtext & objRds_toppingids("topping") & ", "
						        objRds_toppingids.MoveNext
						loop
                            objRds_toppingids.close()
                        set objRds_toppingids =  nothing
						    if toppingtext<>"" then
							    toppingtext=left(toppingtext,len(toppingtext)-2)
						        y = y & Server.URLEncode(toppingtext)
						    end if
			        End If  
						 
				     x=x & "&qnt_" & c & "=" & Server.URLEncode(objRds2("Qta"))
		             x=x & "&price_" & c & "=" & Server.URLEncode(objRds2("Total"))
					 x=x & "&desc_" & c & "=" & y
					
	 objRds2.MoveNext    
	 Loop
	    objRds2.close()
    set objRds2 = nothing
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
            x=x & "&delivery_time=" & formatDateTimeC(DateAdd("n",mintoadd,objRds("orderdate")))
       else
            x=x & "&delivery_time=" & formatDateTimeC(objRds("DeliveryTime"))
       end if
	  if objRds("vouchercode") & "" <> "" Then
            if objRds("vouchercode") & "" <> "Amount" then
	            x=x & "&discount_amount=" & Server.URLEncode("-" & FormatNumber((( objRds("SubTotal") * 100 )/(100- Cdbl(Replace(Replace(Replace(objRds("vouchercodediscount"),"-",""),"%","")," ",""))) -  objRds("SubTotal") ),2) )
            else
                x=x & "&discount_amount=" & Server.URLEncode("-" & FormatNumber(Cdbl(Replace(Replace(Replace(objRds("vouchercodediscount"),"-",""),"%","")," ","")),2) )
            end if
      End If
	  x=x & "&deliverycost=" & Server.URLEncode(objRds("ShippingFee"))
    x=x & "&payment_surcharge=" & Server.URLEncode(objRds("paymentsurcharge"))
     x=x & "&service_charge=" & Server.URLEncode(objRds("servicecharge"))
    x=x & "&tax_amount=" & Server.URLEncode(objRds("Tax_Amount"))
    x=x & "&tip_amount=" & Server.URLEncode(objRds("Tip_Amount"))
	   x=x & "&total_amount=" & Server.URLEncode(objRds("OrderTotal"))
	 x=x & "&cust_instruction=" & Server.URLEncode(objRds("Notes"))
	
	 
	 x=x & "&cust_name=" & Server.URLEncode(objRds("firstname") & " " & objRds("lastname"))
	 x=x & "&cust_address=" & Server.URLEncode(objRds("address") & " " & objRds("postalcode"))
	
	 x=x & "&cust_phone=" & Server.URLEncode(objRds("phone"))
	 
	  x=x & "&isVarified=4"

	 if objRds("paymenttype")="NoChex-Paid" or lcase(objRds("paymenttype"))="stripe-paid" or objRds("paymenttype")="Paypal-Paid" or objRds("paymenttype")="Worldpay-Paid" or Ucase(objRds("Payment_status") & "")="PAID"  then
	     x=x & "&payment_status=" & Server.URLEncode("6")
         x=x & "&payment_method=" & Server.URLEncode("creditcard")
	 else
	     x=x & "&payment_status=" & Server.URLEncode("7")
         x=x & "&payment_method=" & Server.URLEncode("cash")
	 end if

    postFormData "http://iconnect.ibacstel.com/submitorder.php",x
    response.write x & "<BR><BR>"
end if
     objRds.MoveNext    
	 Loop
    objRds.close()
    set objRds =  nothing
    objCon.close()
    set objCon =  nothing
%>