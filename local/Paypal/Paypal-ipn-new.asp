
<%
    WriteLog server.MapPath("Paypal-IPN.txt"),"Request Data:" & Request.Form
     %>
<!-- #include file="../../Config.asp" -->
<!-- #include file="../../timezone.asp" -->
<%
  
    if Request.QueryString("r") & "" <> "" then
        session("restaurantid") = Request.QueryString("r")
    End if
     %>
<!-- #include file="../../restaurantsettings.asp" -->


<%
        Function WriteLog(logFilePath, logContent)
        Dim logobjFSO, logFile
        set logobjFSO = CreateObject("Scripting.FileSystemObject")
        set logFile = logobjFSO.OpenTextFile(logFilePath,8,true) ' 8 is for appending
        logFile.WriteLine(now() & ": " & logContent)
        set logFile = nothing
        set logobjFSO = nothing
    End Function

    
Dim Item_name, Item_number, Payment_status, Payment_amount
Dim Txn_id, Receiver_email, Payer_email
Dim objHttp, str
' read post from PayPal system and add 'cmd'
str = Request.Form & "&cmd=_notify-validate"
 '   str = "mc_gross=20.40&protection_eligibility=Eligible&address_status=confirmed&payer_id=EM65VADNWXYV2&tax=0.00&address_street=Add+1%0D%0AAdd+2&payment_date=07%3A37%3A58+Jun+21%2C+2016+PDT&payment_status=Pending&charset=windows-1252&address_zip=95134&first_name=test&address_country_code=US&address_name=test+buyer&notify_version=3.8&custom=&payer_status=verified&business=danghai88-facilitator%40gmail.com&address_country=United+States&address_city=San+jose&quantity=1&verify_sign=AZenMl5LsTknAP1wvQY.IJnuNDytAd9iUCEaGuV7F0tgiHZC54pcBDA-&payer_email=danghai88-buyer%40gmail.com&txn_id=22W39306M2992905A&payment_type=instant&last_name=buyer&address_state=CA&receiver_email=danghai88-facilitator%40gmail.com&receiver_id=KA9RM8QASHLTQ&pending_reason=multi_currency&txn_type=web_accept&item_name=Order+Nr.+1271&mc_currency=GBP&item_number=1271&residence_country=US&test_ipn=1&handling_amount=0.00&transaction_subject=&payment_gross=&shipping=0.00&ipn_track_id=ca5474797f53" & "&cmd=_notify-validate"
' post back to PayPal system to validate

'set objHttp = Server.CreateObject("Msxml2.ServerXMLHTTP.3.0")

Set objhttp = Server.CreateObject ("MSXML2.XMLHTTP.6.0")


'objHttp.open "POST", "https://www.paypal.com/cgi-bin/webscr", false

objHttp.open "POST", PAYPAL_URL, false
'objHttp.setOption 2, 13056
'objHttp.setOption 3,"certificate store name/friendlyname of certificate"
objHttp.setRequestHeader "Content-type", "application/x-www-form-urlencoded"
objHttp.Send str  
' assign posted variables to local variables
Item_name = Request.Form("item_name")
Item_number = Request.Form("item_number")
Payment_status = Request.Form("payment_status")
Payment_amount = Request.Form("mc_gross")
Payment_currency = Request.Form("mc_currency")
Txn_id = Request.Form("txn_id")
Receiver_email = Request.Form("receiver_email")
Payer_email = Request.Form("payer_email")
Item_number = Replace(Ucase(Item_number),"IR-","")
 ' Payment_status="Completed"
'SendEmailV2 "Paypal IPN ERROR11", "Paypal IPN has error.Response status: "& objHttp.status &" Validate result: " & objHttp.responseText & ". Request data from Paypal: " & str , CONFIRMATION_EMAIL_ADDRESS
' Check notification validation
if (objHttp.status <> 200 ) then
    SendEmailV2 "Paypal IPN ERROR", "Paypal IPN has error.Validate Result satus: " & objHttp.status & " Validate result: " & objHttp.responseText & ". Request data from Paypal: " & str , CONFIRMATION_EMAIL_ADDRESS
elseif (objHttp.responseText = "VERIFIED") then
    ' check that Payment_status=Completed

    if Payment_status="Completed" then
   
   
   
     Set objCon = Server.CreateObject("ADODB.Connection")
        Set objRds = Server.CreateObject("ADODB.Recordset") 
     'Set objConconfig = Server.CreateObject("ADODB.Connection")
        Set objRdsconfig = Server.CreateObject("ADODB.Recordset") 
    Dim iRestaurantId, iRestaurantEmail
        objCon.Open sConnString
        objRds.Open "SELECT * FROM [Orderslocal] WHERE Id = " & Item_number, objCon, 1, 3 
        If  objRds("PaymentType") = "Paypal-Paid" or objRds("Payment_Status") & "" = "Paid"  Then
            objRds.Close
            objCon.Close 
            set objHttp = nothing
            Set objRds = nothing
            set objCon= nothing
            Response.End()
        End if
	    iRestaurantId = objRds("IdBusinessDetail")
        iRestaurantEmail = objRds("Email")
    If cdbl(objRds("OrderTotal") ) = cdbl(Payment_amount) Then
	       ' objConconfig.Open sConnString
            objRdsconfig.Open "SELECT * FROM [BusinessDetails] WHERE Id = " & iRestaurantId, objCon, 1, 3 
	
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
        disabledelivery=objRdsconfig("disable_delivery")
        disablecollection=objRdsconfig("disable_collection")
        ordertodayonly=objRdsconfig("ordertodayonly")
        mileskm=objRdsconfig("mileskm")
        installationID = objRdsconfig("worldpayinstallationid")
            objRdsconfig.close()
        set objRdsconfig = nothing
	
            
            objRds("Payment_Status") = "Paid"
            objRds.Update 
	
	        'SendEmail MAIL_SUBJECT, SITE_URL & "Email.asp?id_o=" & Item_number & "&id_r=" & iRestaurantId  , iRestaurantEmail
            'SendEmail MAIL_CUSTOMER_SUBJECT, SITE_URL & "Email.asp?id_o=" & Item_number & "&id_r=" & iRestaurantId  , Payer_email
      Else
         SendEmailV2 "Paypal IPN Notification", "Paypal payment for order " & Item_number & " with payment amount does not match. Paypal notifiation amount : " & Payment_amount & ". Total Order amount:" & objRds("OrderTotal") & ". Detail notification from Paypal: " & Request.Form , CONFIRMATION_EMAIL_ADDRESS
      End If
       
        
   Else
         SendEmailV2 "Paypal IPN Notification", "Paypal payment for order " & Item_number & " is not processed. Payment status is: " & Payment_status  & ". Detail notification from Paypal: " & Request.Form , CONFIRMATION_EMAIL_ADDRESS
      
    end if
            objRds.Close
         set objRds = nothing
        objCon.Close 
        set objCon = nothing
    ' check that Txn_id has not been previously processed
    ' check that Receiver_email is your Primary PayPal email
    ' check that Payment_amount/Payment_currency are correct
    ' process payment
elseif (objHttp.responseText = "INVALID") then
     SendEmailV2 "Paypal IPN ERROR", "Paypal IPN has error. Validate result: " & objHttp.responseText & ". Request data from Paypal: " & str , CONFIRMATION_EMAIL_ADDRESS
else
' error
    SendEmailV2 "Paypal IPN ERROR", "Paypal IPN has error. Validate result: " & objHttp.responseText & ". Request data from Paypal: " & str , CONFIRMATION_EMAIL_ADDRESS
end if
set objHttp = nothing
%>