<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../Config.asp" -->
<%session("restaurantid")=Session("MM_id")%>
<!-- #include file="timezone.asp" -->
<!-- #include file="restaurantsettings.asp" -->
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers=""
MM_authFailedURL="index.asp?e=2"
MM_grantAccess=false
If Session("MM_Username") <> "" Then
  If (true Or CStr(Session("MM_UserAuthorization"))="") Or _
         (InStr(1,MM_authorizedUsers,Session("MM_UserAuthorization"))>=1) Then
    MM_grantAccess = true
  End If
End If
If Not MM_grantAccess Then
  MM_qsChar = "?"
  If (InStr(1,MM_authFailedURL,"?") >= 1) Then MM_qsChar = "&"
  MM_referrer = Request.ServerVariables("URL")
  if (Len(Request.QueryString()) > 0) Then MM_referrer = MM_referrer & "?" & Request.QueryString()
  MM_authFailedURL = MM_authFailedURL & MM_qsChar & "accessdenied=" & Server.URLEncode(MM_referrer)
  Response.Redirect(MM_authFailedURL)
End If

Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 
  Dim ActualPhoneNumber
%>

<%
' update announcement restaurant
if request.form("action")="announcement" then
  objCon.Open sConnStringcms
                        objRds.Open "UPDATE businessdetails SET announcement='" & request.form("announcement") & "' WHERE id=" & request.form("id"), objCon
					response.redirect "loggedin.asp"
end if

' update css
if request.form("action")="css" then
  objCon.Open sConnStringcms
                        objRds.Open "UPDATE businessdetails SET css='" & request.form("css") & "' WHERE id=" & request.form("id"), objCon
						response.redirect "loggedin.asp"
end if

' open/close restaurant
if request.querystring("action")="close" then
  objCon.Open sConnStringcms
                        objRds.Open "UPDATE businessdetails SET businessclosed=0 WHERE id=" & Session("MM_id"), objCon
						response.redirect "loggedin.asp"
end if
if request.querystring("action")="open" then
  objCon.Open sConnStringcms
                        objRds.Open "UPDATE businessdetails SET businessclosed=-1 WHERE id=" & Session("MM_id"), objCon
						response.redirect "loggedin.asp"
					
end if

'cancel order
if request.querystring("action")="cancel" then
   
  objCon.Open sConnStringcms
                        objRds.Open "UPDATE orders SET cancelled=-1, cancelleddate='" & (DateAdd("h",houroffset,now)) & "', cancelledby='" & request.querystring("cancelledby") & "',cancelledreason='" & replace(request.querystring("cancelledreason"),"'","''") & "' WHERE id=" & Request.QueryString("id"), objCon


objCon.Close
objCon.Open sConnStringcms
objRds.Open "SELECT * FROM ORDERS where id=" & Request.QueryString("id") & " ORDER BY id desc" , objCon

SendEmail "Order Cancelled", SITE_URL & "EmailOrderUpdate.asp?id_o=" & request.querystring("id") & "&id_r=" & Session("MM_id") & "&message=Order Cancelled by " & Request.QueryString("cancelledby") & " - " & Request.QueryString("cancelledreason"), objRds("email")

if objRds("PaymentType")="Paypal-Paid" or objRds("PaymentType")="NoChex-Paid" or objRds("PaymentType")="Worldpay-Paid" then
SendEmail "Order Cancelled - Refund Customer", SITE_URL & "EmailOrderUpdate.asp?id_o=" & request.querystring("id") & "&id_r=" & Session("MM_id") & "&message=Order Cancelled refund customer", Session("MM_email") 
end if



		response.redirect request.querystring("page") & ".asp"


end if



'acknowledge order
if request.querystring("action")="acknowledge" then
  objCon.Open sConnStringcms
                        objRds.Open "UPDATE orders SET acknowledged=-1, acknowledgeddate='" & (DateAdd("h",houroffset,now)) & "' WHERE id=" & Request.QueryString("id"), objCon

    
objCon.Close
objCon.Open sConnStringcms
objRds.Open "SELECT * FROM ORDERS where id=" & Request.QueryString("id") & " ORDER BY id desc" , objCon
   
if request.querystring("sendemail")<>"no" then
SendEmail "Your order is confirmed", SITE_URL & "EmailOrderUpdate.asp?id_o=" & request.querystring("id") & "&id_r=" & Session("MM_id") & "&message=Order Acknowledged"  , objRds("email")
end if
If  Lcase(SMSEnable) = "true" AND  Lcase(SMSOnAcknowledgement) = "true" AND objRds("phone") & "" <> "" Then
     ' objRds("phone"), "Your order is out or delivery", Now(),Session("MM_id")
    
    ActualPhoneNumber = ""

   
        ActualPhoneNumber = objRds("phone")
       If Left(ActualPhoneNumber,Len(DefaultSMSCountryCode)) = DefaultSMSCountryCode And Len(ActualPhoneNumber) > 1 Then
            ActualPhoneNumber = Right(ActualPhoneNumber,Len(ActualPhoneNumber) - Len(DefaultSMSCountryCode))
        End If
        If Left(ActualPhoneNumber,1) = "0" And Len(ActualPhoneNumber) > 1 Then
            ActualPhoneNumber = Right(ActualPhoneNumber,Len(ActualPhoneNumber) - 1)
        End If
    
     SendEmailV2 "Your order is confirmed", "Your order is confirmed", objRds("phone")&SMSSupplierDomain
End If
response.redirect request.querystring("page") & ".asp"
end if


'order out for delivery
if request.querystring("action")="outfordelivery" then
  objCon.Open sConnStringcms
objRds.Open "UPDATE orders SET outfordelivery=-1, delivereddate='" & (DateAdd("h",houroffset,now)) & "' WHERE id=" & Request.QueryString("id"), objCon


objCon.Close
objCon.Open sConnStringcms
objRds.Open "SELECT * FROM ORDERS where id=" & Request.QueryString("id") & " ORDER BY id desc" , objCon
SendEmail "Your order is out or delivery", SITE_URL & "EmailOrderUpdate.asp?id_o=" & request.querystring("id") & "&id_r=" & Session("MM_id") & "&message=Order Out For Delivery"  , objRds("email")
If  Lcase(SMSEnable) = "true" AND  Lcase(SMSOnDelivery) = "true" AND objRds("phone") & "" <> "" Then
     ' objRds("phone"), "Your order is out or delivery", Now(),Session("MM_id")
    
    ActualPhoneNumber = ""

   
        ActualPhoneNumber = objRds("phone")
       If Left(ActualPhoneNumber,Len(DefaultSMSCountryCode)) = DefaultSMSCountryCode And Len(ActualPhoneNumber) > 1 Then
            ActualPhoneNumber = Right(ActualPhoneNumber,Len(ActualPhoneNumber) - Len(DefaultSMSCountryCode))
        End If
        If Left(ActualPhoneNumber,1) = "0" And Len(ActualPhoneNumber) > 1 Then
            ActualPhoneNumber = Right(ActualPhoneNumber,Len(ActualPhoneNumber) - 1)
        End If
    
     SendEmailV2 "Your order is out or delivery", "Your order is out or delivery", objRds("phone")&SMSSupplierDomain
End If
response.redirect request.querystring("page") & ".asp"
end if


'collected
if request.querystring("action")="collected" then
  objCon.Open sConnStringcms
objRds.Open "UPDATE orders SET outfordelivery=-1, delivereddate='" & (DateAdd("h",houroffset,now)) & "' WHERE id=" & Request.QueryString("id"), objCon


objCon.Close
objCon.Open sConnStringcms
objRds.Open "SELECT * FROM ORDERS where id=" & Request.QueryString("id") & " ORDER BY id desc" , objCon
'SendEmail "Order Out For Delivery", SITE_URL & "EmailOrderUpdate.asp?id_o=" & request.querystring("id") & "&id_r=" & Session("MM_id") & "&message=Order Out For Delivery"  , objRds("email")

response.redirect request.querystring("page") & ".asp"
end if
%>