
<%
    If Instr(UCase(Request.Form("item_number")),"IR-") > 0 Then
       Server.Transfer("../../local/paypal/paypal-ipn-new.asp")
    End If 
    WriteLog server.MapPath("Paypal-IPN.txt"),"Request Data:" & Request.Form
     if Request.QueryString("r") & "" <> "" then
        session("restaurantid") = Request.QueryString("r")
    End if
     %>

<!-- #include file="../../Config.asp" -->
<!-- #include file="../../timezone.asp" -->

<!-- #include file="../../restaurantsettings.asp" -->


<%
    sub WriteLog(logFilePath, logContent)
         if setWriteLog = false then
                exit sub
          end if 
        On Error Resume Next
            Dim logobjFSO, logFile
            set logobjFSO = CreateObject("Scripting.FileSystemObject")
            set logFile = logobjFSO.OpenTextFile(logFilePath,8,true) ' 8 is for appending
            logFile.WriteLine(now() & ": " & logContent)
            set logFile = nothing
            set logobjFSO = nothing
        On Error GoTo 0
    End sub

    
Dim Item_name, Item_number, Payment_status, Payment_amount
Dim Txn_id, Receiver_email, Payer_email
Dim objHttp, str
' read post from PayPal system and add 'cmd'
str = Request.Form & "&cmd=_notify-validate"
 '   str = "mc_gross=20.40&protection_eligibility=Eligible&address_status=confirmed&payer_id=EM65VADNWXYV2&tax=0.00&address_street=Add+1%0D%0AAdd+2&payment_date=07%3A37%3A58+Jun+21%2C+2016+PDT&payment_status=Pending&charset=windows-1252&address_zip=95134&first_name=test&address_country_code=US&address_name=test+buyer&notify_version=3.8&custom=&payer_status=verified&business=danghai88-facilitator%40gmail.com&address_country=United+States&address_city=San+jose&quantity=1&verify_sign=AZenMl5LsTknAP1wvQY.IJnuNDytAd9iUCEaGuV7F0tgiHZC54pcBDA-&payer_email=danghai88-buyer%40gmail.com&txn_id=22W39306M2992905A&payment_type=instant&last_name=buyer&address_state=CA&receiver_email=danghai88-facilitator%40gmail.com&receiver_id=KA9RM8QASHLTQ&pending_reason=multi_currency&txn_type=web_accept&item_name=Order+Nr.+1271&mc_currency=GBP&item_number=1271&residence_country=US&test_ipn=1&handling_amount=0.00&transaction_subject=&payment_gross=&shipping=0.00&ipn_track_id=ca5474797f53" & "&cmd=_notify-validate"
' post back to PayPal system to validate

'set objHttp = Server.CreateObject("Msxml2.ServerXMLHTTP.3.0")

    ' assign posted variables to local variables
Item_name = Request.Form("item_name")
Item_number = Request.Form("item_number")
if Item_number& "" = "" then
    Item_number = Request.Form("item_number1")
end if

if Item_number & "" = "" then
    WriteLog server.MapPath("Paypal-IPN.txt"),"Start Paypal-ipn-new.asp  OrderID = empty "  
    Response.End
end if


'Set objhttp = Server.CreateObject ("MSXML2.XMLHTTP.6.0")
set objHttp = Server.CreateObject("MSXML2.ServerXMLHTTP")


'objHttp.open "POST", "https://www.paypal.com/cgi-bin/webscr", false

objHttp.open "POST", PAYPAL_URL, false
'objHttp.setOption 2, 13056
'objHttp.setOption 3,"certificate store name/friendlyname of certificate"
objHttp.setRequestHeader "Content-type", "application/x-www-form-urlencoded"
objHttp.Send str  
WriteLog server.MapPath("Paypal-IPN.txt")," OrderID = " & iItemNumber & " PAYPAL_URL = " & PAYPAL_URL & " Form " & str
WriteLog server.MapPath("Paypal-IPN.txt")," OrderID = " & iItemNumber & " responseText = " & objHttp.responseText & " objHttp.status " & objHttp.status

Payment_status = Request.Form("payment_status")
Payment_amount = Request.Form("mc_gross")
Payment_currency = Request.Form("mc_currency")
Txn_id = Request.Form("txn_id")
Receiver_email = Request.Form("receiver_email")
Payer_email = Request.Form("payer_email")
 ' Payment_status="Completed"
'SendEmailV2 "Paypal IPN ERROR11", "Paypal IPN has error.Response status: "& objHttp.status &" Validate result: " & objHttp.responseText & ". Request data from Paypal: " & str , CONFIRMATION_EMAIL_ADDRESS
' Check notification validation
if (objHttp.status <> 200 ) then
    SendEmailV2 "Paypal IPN ERROR", "Paypal IPN has error.Validate Result satus: " & objHttp.status & " Validate result: " & objHttp.responseText & ". Request data from Paypal: " & str , CONFIRMATION_EMAIL_ADDRESS
elseif (objHttp.responseText = "VERIFIED") then
    ' check that Payment_status=Completed
     dim sentEmail : sentEmail  = ""
    if Payment_status="Completed" then
   
   
   
     Set objCon = Server.CreateObject("ADODB.Connection")
        Set objRds = Server.CreateObject("ADODB.Recordset") 
     'Set objConconfig = Server.CreateObject("ADODB.Connection")
        Set objRdsconfig = Server.CreateObject("ADODB.Recordset") 
    Dim iRestaurantId, iRestaurantEmail
        objCon.Open sConnString
        objRds.Open "SELECT * FROM [Orders] WHERE Id = " & Item_number, objCon, 1, 3 
        If  objRds("PaymentType") = "Paypal-Paid" or objRds("Payment_Status") & "" = "Paid" Then
            objRds.Close
            objCon.Close 
            set objHttp = nothing
            Set objRds = nothing
            set objCon= nothing
            Response.End()
        End if
	    iRestaurantId = objRds("IdBusinessDetail")
       ' iRestaurantEmail = objRds("Email")
        Payer_email = objRds("Email")
        sentEmail = objRds("SentEmail") 
    dim OrderTotal : OrderTotal =  cdbl(objRds("OrderTotal") ) 
    if objRds("PaymentType") & "" <> "Paypal-Paid" and objRds("Payment_Status") & "" <> "Paid" then
        OrderTotal = cdbl(objRds("OrderTotal") ) + Cdbl(objRds("PaymentSurcharge")) 
    end if
    If OrderTotal  = cdbl(Payment_amount) Then
	        'objConconfig.Open sConnString
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
            if objRds("PaymentType") & "" <> "Paypal-Paid" and objRds("Payment_Status") & "" <> "Paid" then
	            objRds("OrderTotal") = Cdbl(objRds("PaymentSurcharge")) + CDbl(objRds("OrderTotal"))
            end if
            objRds("Payment_Status") = "Paid"
            objRds("OrderDate") = DateAdd("h",houroffset,now)
            objRds("SentEmail")    = "yes"
            objRds.Update 
            WriteLog server.MapPath("Paypal-IPN.txt"),"Paypal-ipn-new.asp OrderID = "  & Item_number & " send mail  =  " & sentEmail
	        if sentEmail & "" <> "yes" then
	            SendEmail MAIL_SUBJECT, SITE_URL & "Email.asp?id_o=" & Item_number & "&id_r=" & iRestaurantId  , CONFIRMATION_EMAIL_ADDRESS
                SendEmail MAIL_CUSTOMER_SUBJECT, SITE_URL & "Email.asp?id_o=" & Item_number & "&id_r=" & iRestaurantId  , Payer_email
                WriteLog server.MapPath("Paypal-IPN.txt"),"Paypal-ipn-new.asp OrderID = "  & Item_number & " CONFIRMATION_EMAIL_ADDRESS  =  " & CONFIRMATION_EMAIL_ADDRESS & " Payer_email " & Payer_email
            end if
            
            WriteLog server.MapPath("Paypal-IPN.txt"),"Paypal-ipn-new.asp OrderID = "  & Item_number & " iRestaurantId " & iRestaurantId
      Else
         SendEmailV2 "Paypal IPN Notification", "Paypal payment for order " & Item_number & " with payment amount does not match. Paypal notifiation amount : " & Payment_amount & ". Total Order amount:" & objRds("OrderTotal") & ". Detail notification from Paypal: " & Request.Form , CONFIRMATION_EMAIL_ADDRESS
      End If
       ' objRds.Close
        'objCon.Close 
             objRds.close()
         set objRds = nothing
             objCon.close()
        set objCon = nothing
   Else
         SendEmailV2 "Paypal IPN Notification", "Paypal payment for order " & Item_number & " is not processed. Payment status is: " & Payment_status  & ". Detail notification from Paypal: " & Request.Form , CONFIRMATION_EMAIL_ADDRESS
      
    end if
    
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
    if Item_number & "" <> "" then
        dim objCon1
        Set objCon1 = Server.CreateObject("ADODB.Connection")
            objCon1.Open sConnString
        dim objRds1 : set objRds1 = Server.CreateObject("ADODB.Recordset")
        objRds1.Open "SELECT * FROM [Orders] WHERE Id = " & Item_number, objCon1, 1, 3 
        if not objRds1.EOF then
             WriteLog server.MapPath("Paypal-IPN.txt")," Paypal-ipn-new.asp End OrderID = "  & Item_number & " PaymentType " & objRds1("PaymentType")
        end if
        objRds1.Close
        set objRds1 = nothing
        objCon1.Close 
        set objCon1 = nothing
    end if
    WriteLog server.MapPath("Paypal-IPN.txt")," Paypal-ipn-new.asp End OrderID = "  & Item_number & " iRestaurantId " & iRestaurantId
%>