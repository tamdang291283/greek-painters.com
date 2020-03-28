<!-- #include file="Config.asp" -->
<!-- #include file="timezone.asp" -->
<!-- #include file="restaurantsettings.asp" -->
<!--#include file="worldpayconfig.asp"-->
<!--#include file="md5.asp"-->
<%if session("restaurantid")="" then
response.redirect("error.asp")
end if%>
<% 

if Request.Form("cookies")="yes" then

Response.Cookies("FirstName").Expires=dateadd("D",90,Date())
Response.Cookies("LastName").Expires=dateadd("D",90,Date())
Response.Cookies("Email").Expires=dateadd("D",90,Date())
Response.Cookies("Phone").Expires=dateadd("D",90,Date())
Response.Cookies("Address").Expires=dateadd("D",90,Date())
Response.Cookies("Address2").Expires=dateadd("D",90,Date())
Response.Cookies("Postcode").Expires=dateadd("D",90,Date())

Response.Cookies("FirstName")=Request.Form("FirstName")
Response.Cookies("LastName")=Request.Form("LastName")
Response.Cookies("Email")=Request.Form("Email")
Response.Cookies("Phone")=Request.Form("Phone")
Response.Cookies("Address")=Request.Form("Address")
Response.Cookies("Address2")=Request.Form("Address2")
Response.Cookies("Postcode")=Request.Form("Postcode")



end if

Set objCon = Server.CreateObject("ADODB.Connection")
Set objRds = Server.CreateObject("ADODB.Recordset") 

        
objCon.Open sConnString
objRds.Open "SELECT * FROM [Orders] WHERE Id = " & Request.Form("order_id"), objCon, 1, 3 

'If objRds("PaymentType") <> "" Then
    
'    objRds.Close
'    objCon.Close    

'    Response.Redirect SITE_URL & "Index.asp?x=1"

'End If


objRds("OrderDate") = DateAdd("h",houroffsetreal,now)
objRds("FirstName") = Request.Form("FirstName")
objRds("LastName") = Request.Form("LastName")
objRds("Email") = Request.Form("Email")
objRds("Phone") = Request.Form("Phone")
objRds("Address") = Request.Form("Address") & ", " & Request.Form("Address2")
objRds("PostalCode") = Request.Form("Postcode")
objRds("Notes") = Request.Form("Special")
if Request.Form("payment_type") = "paypal" then
    objRds("PaymentType") = "Paypal"
else
if Request.Form("payment_type") = "nochex" then
    objRds("PaymentType") = "nochex"
else
if Request.Form("payment_type") = "worldpay" then
    objRds("PaymentType") = "worldpay"
else
    objRds("PaymentType") = "Cash on Delivery"
end if
end if
end if

Dim iItemNumber, iRestaurantId, iRestaurantEmail, iEmail

iItemNumber = objRds("ID")
iRestaurantId = objRds("IdBusinessDetail")
iEmail = Request.Form("Email")

objRds.Update 
    
     
objRds.Close
objCon.Close    

%>

<%  if Request.Form("payment_type") = "paypal" or Request.Form("payment_type") = "nochex"  or Request.Form("payment_type") = "worldpay" then

Set objCon = Server.CreateObject("ADODB.Connection")
Set objRds = Server.CreateObject("ADODB.Recordset") 
objCon.Open sConnString
objRds.Open "SELECT * FROM BusinessDetails WHERE Id = " & iRestaurantId, objCon
PAYPAL_ADDR=objRds("PAYPAL_ADDR")
objRds.Close
objCon.Close  
 %>

<%if Request.Form("payment_type") = "paypal" then%>
     
<form action="<%= PAYPAL_URL %>" method="post">
    <input type="hidden" name="cmd" value="_xclick" />
    <input type="hidden" name="business" value="<%=PAYPAL_ADDR%>"/>
    <input type="hidden" name="item_name" value="Order Nr. <%= Request.Form("order_id")%>"/>
    <input type="hidden" name="item_number" value="<%= Request.Form("order_id")%>"/>    
    <input type="hidden" name="amount" value="<%= FormatNumber(cdbl(Request.Form("amount")) + Cdbl(CREDITCARDSURCHARGE), 2) %>"/>
    <!--<input type="hidden" name="amount" value="10" />-->
    <input type="hidden" name="currency_code" value="GBP"/>
    <input type="hidden" name="bn" value="PP-BuyNowBF"/>
	<input type="hidden" name="rm" value="2"/>
    <input type="hidden" name="return" value="<%= SITE_URL %>Paypal.asp"/>
    <input type="hidden" name="shipping" value="0"/>
</form>

<script language="javascript">    
    document.forms[0].submit();
</script>

<%end if%>

<%if Request.Form("payment_type") = "worldpay" then%>
     

<form  method="post" action="<%=urlLink%>">
<input type="hidden" name="instId" value="<%=installationID%>" />
<input type="hidden" name="amount" value="<%= FormatNumber(cdbl(Request.Form("amount")) + Cdbl(CREDITCARDSURCHARGE), 2) %>" />
<input type="hidden" name="cartId" value="<%= Request.Form("order_id")%>" />
<input type="hidden" name="currency" value="<%=currencyCode%>" />
<input type="hidden" name="testMode" value="<%=testMode%>"  />
<input type="hidden" name="desc" value="Online Payment"/>
<input type="hidden" name="authMode" value="<%=authMode%>"/><%=authModeError%>
<input type="hidden" name="name" value="<%=Request.Form("FirstName")%> <%=Request.Form("LastName")%>" />
<input type="hidden" name="address1" value="<%=Request.Form("Address1")%>" />
<input type="hidden" name="address2" value="<%=Request.Form("Address2")%>" />
<input type="hidden" name="postcode" value="<%=Request.Form("Postcode")%>" />
<input type="hidden" name="email" value="<%=Request.Form("Email")%>" />
<input type="hidden" name="signature" value="<%=md5 (""& MD5secretKey &":" & SignatureFields & "") %>" />


</form>

<script language="javascript">    
    document.forms[0].submit();
</script>




<%end if%>

<%if Request.Form("payment_type") = "nochex" then%>
     
<form method="POST" action="https://secure.nochex.com/">
<input type="hidden" name="merchant_id" value="<%=NOCHEXMERCHANTID%>">
<input type="hidden" name="amount" value="<%= FormatNumber(cdbl(Request.Form("amount")) + Cdbl(CREDITCARDSURCHARGE), 2) %>">
<input type="hidden" name="description" value="Order Payment">
<input type="hidden" name="success_url" value="<%= SITE_URL %>nochex.asp?iItemNumber=<%= Request.Form("order_id")%>">
<input type="hidden" name="order_id" value="<%= Request.Form("order_id")%>">
</form>

<script language="javascript">    
    document.forms[0].submit();
</script>

<%end if%>

<%
	session("vOrderId")=Request.Form("order_id")

 Else 

    objCon.Open sConnString
    objRds.Open "SELECT bd.* " & _
            " FROM BusinessDetails bd " & _
            " WHERE bd.Id = " & iRestaurantId, objCon 

    iRestaurantEmail =  objRds("Email")

    objRds.Close
    objCon.Close

    'Session.Abandon
	session("vOrderId")=Request.Form("order_id")

'response.write "subject=" & MAIL_SUBJECT & "<BR>"
'response.write "url=" & SITE_URL & "Email.asp?id_o=" & iItemNumber & "&id_r=" & iRestaurantId & "<BR>"
'response.write "email=" & iRestaurantEmail & "<BR>"
'response.write "customersubject=" & MAIL_CUSTOMER_SUBJECT & "<BR>"
response.write "email=" & iEmail & "<BR>"

    SendEmail MAIL_SUBJECT, SITE_URL & "Email.asp?id_o=" & iItemNumber & "&id_r=" & iRestaurantId  , CONFIRMATION_EMAIL_ADDRESS
    SendEmail MAIL_CUSTOMER_SUBJECT, SITE_URL & "Email.asp?id_o=" & iItemNumber & "&id_r=" & iRestaurantId  , iEmail

    Response.Redirect "Thanks.asp?id_o=" & iItemNumber & "&id_r=" & iRestaurantId  

End If %>