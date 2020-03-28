<% 
    If session("restaurantid")="" AND request.QueryString("id_r") & "" <> "" then
        session("restaurantid") = request.QueryString("id_r") 
    End if
     %>
<!-- #include file="Config.asp" -->
<!-- #include file="timezone.asp" -->
<!-- #include file="restaurantsettings.asp" -->
<%

Dim iTxnId
Dim iItemNumber, iPaymentStatus, iPaymentAmount, iRestaurantId
Dim iPayerEmail, iRestaurantEmail


iTxnId = Request.QueryString("tx")
if iTxnId & "" <> "" then 
    iItemNumber = Request.QueryString("item_number")
Else 
    iTxnId = Request.Form("txn_id")
    iItemNumber = Request.Form("item_number")
end if
response.write iItemNumber  & "<BR>"
dim iQuery
iQuery = "cmd=_notify-synch&tx=" & iTxnId & "&at=" & PAYPAL_PDT
Response.Write("AAAA"& PAYPAL_PDT & "<br />")
response.write PAYPAL_URL & "<BR>"
response.write iQuery & "<BR>"
Dim objHttp
set objHttp = Server.CreateObject("Microsoft.XMLHTTP")
objHttp.open "POST", PAYPAL_URL, false
objHttp.setRequestHeader "Content-type", "application/x-www-form-urlencoded"
objHttp.Send iQuery
if (objHttp.status <> 200 ) then
   Response.write "HTTP ERROR " & objHttp.status
elseif Mid(objHttp.responseText, 1, 7)  = "SUCCESS" then
    
    Dim sParts, iParts, aParts
    iQuery = Mid(objHttp.responseText, 9)

    sParts = Split(iQuery, " ")
    iParts = UBound(sParts) - 1
    ReDim sResults(iParts, 1)
    
    For i = 0 To iParts
        aParts = Split(sParts(i), "=")
        sKey = aParts(0)
        sValue = aParts(1)
        sResults(i, 0) = sKey
        sResults(i, 1) = sValue
        Response.write sKey
        Select Case sKey
            Case "payment_status"
                iPaymentStatus = sValue
            Case "mc_gross"
                iPaymentAmount = cdbl(sValue)
        End Select
    Next

    Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 
    
     objCon.Open sConnString
     objRds.Open "select * from [Orders]  " & _
            "where Id = " & iItemNumber, objCon

    iPayerEmail = objRds("Email")
    iRestaurantId = objRds("IdBusinessDetail")

    check1 = iPaymentStatus = "Completed" Or True
    check2 = Not objRds.Eof
    check3 = cdbl(iPaymentAmount) = cdbl(objRds("OrderTotal")) Or True
    
    objRds.Close
    objCon.Close

    objCon.Open sConnString
    objRds.Open "select * from [BusinessDetails]  " & _
            "where Id = " & iRestaurantId, objCon

    iRestaurantEmail = objRds("Email")
    
    objRds.Close
    objCon.Close

    response.write SITE_URL & "Email.asp?id_o=" & iItemNumber & "&id_r=" & iRestaurantId

 if check1 and check2 and check3  then

    'Session.Abandon
	    objCon.Open sConnString
    objRds.Open "SELECT * FROM [Orders] WHERE Id = " & iItemNumber, objCon, 1, 3 
    If objRds("PaymentType") <> "Paypal-Paid" Then
        objRds("PaymentType") = "Paypal-Paid"
        objRds.Update 
    
      

       SendEmail MAIL_SUBJECT, SITE_URL & "Email.asp?id_o=" & iItemNumber & "&id_r=" & iRestaurantId  , iRestaurantEmail
       SendEmail MAIL_CUSTOMER_SUBJECT, SITE_URL & "Email.asp?id_o=" & iItemNumber & "&id_r=" & iRestaurantId  , iPayerEmail
    End If
      objRds.Close
        objCon.Close 
   Response.Redirect "Thanks.asp?id_o=" & iItemNumber & "&id_r=" & iRestaurantId  
   
 else
    Response.write "DATI PAGAMENTO NON CORRETTI"
 end if

else
  Response.write "PAYPAL INVALID " & objHttp.responseText
end if


set objHttp = nothing

%>
