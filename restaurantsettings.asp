<%

    
   ' Response.Write(formatDateTimeC(Now()))
sub WriteLogBlockIP(logFilePath, logContent)
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

Set objConconfig = Server.CreateObject("ADODB.Connection")
Set objRdsconfig = Server.CreateObject("ADODB.Recordset") 
if session("restaurantid")="" then
 
response.redirect(SITE_URL & "error.asp")
end if
objConconfig.Open sConnString
objRdsconfig.Open "SELECT *  FROM BusinessDetails   WHERE Id = " & session("restaurantid"), objConconfig
  
Do While NOT objRdsconfig.Eof
'Check blocked list

If objRdsconfig("BlockIPEmailList") & "" <> ""  Then
   
  'dim vIP : vIP = Request.ServerVariables("REMOTE_ADDR")
   ' vIP = "86.28.235.14"
   If Instr(";" &LCase(objRdsconfig("BlockIPEmailList")) & ";",";" & Request.ServerVariables("REMOTE_ADDR") & ";") > 0 OR Instr(";" &LCase(objRdsconfig("BlockIPEmailList")) & ";",";" & Lcase( URLDecode(Request.Cookies("Email"))  ) & ";") > 0  Then
       call WriteLogBlockIP(Server.MapPath("BlockIP.txt"),"PageName =  " & Request.ServerVariables("HTTP_URL")   & " NlockIP " & LCase(objRdsconfig("BlockIPEmailList"))    & " ClinetIP =   " & Request.ServerVariables("REMOTE_ADDR") & " Email " & Lcase( URLDecode(Request.Cookies("Email"))))
        objRdsconfig.Close()    
        objConconfig.Close()
        Set objRdsconfig = nothing
        Set objConconfig = nothing
        Response.end()
    End If
End If
InRestaurantEpsonPrinterIdList = objRdsconfig("InRestaurantEpsonPrinterIdList")
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
ISSTRIPE = objRdsconfig("Stripe")
  STRIPEAPIKEY = objRdsconfig("Stripe_Key_Secret")
  STRIPEKEY = objRdsconfig("Stripe_Api_Key")
WORDLPAYMERCHANTID=objRdsconfig("worldpaymerchantid")
PAYPAL=objRdsconfig("paypal")
disabledelivery=objRdsconfig("disable_delivery")
disablecollection=objRdsconfig("disable_collection")
ordertodayonly=objRdsconfig("ordertodayonly")
mileskm=objRdsconfig("mileskm")
installationID = objRdsconfig("worldpayinstallationid")
RePrintReceiptWays = objRdsconfig("RePrintReceiptWays")
printingtype = objRdsconfig("printingtype") & "" 
if printingtype = "" then
    printingtype="graphic"
end if
PrinterIDList = objRdsconfig("PrinterIDList")
if objRdsconfig("worldpaylive")=1 then
testing = "N"
else 
testing = "Y"
end if

SMSEnable = objRdsconfig("SMSEnable")
SMSOnDelivery = objRdsconfig("SMSOnDelivery") 
SMSSupplierDomain = objRdsconfig("SMSSupplierDomain") 
SMSOnOrder = objRdsconfig("SMSOnOrder") 
SMSOnOrderAfterMin = objRdsconfig("SMSOnOrderAfterMin") 
SMSOnOrderContent = objRdsconfig("SMSOnOrderContent") 
DefaultSMSCountryCode = objRdsconfig("DefaultSMSCountryCode") 
URL_Facebook = objRdsconfig("URL_Facebook") 
URL_Twitter  = objRdsconfig("URL_Twitter") 
URL_Google  = objRdsconfig("URL_Google") 
URL_Intagram  = objRdsconfig("URL_Intagram") 
URL_YouTube   = objRdsconfig("URL_YouTube")
URL_Tripadvisor    = objRdsconfig("URL_Tripadvisor")
URL_Special_Offer   = objRdsconfig("URL_Special_Offer")
URL_Linkin = objRdsconfig("URL_Linkin")

If not isnull( objRdsconfig("minimumamountforcardpayment")) And  objRdsconfig("minimumamountforcardpayment") & "" <> "" Then
    MinimumAmountForCardPayment = objRdsconfig("minimumamountforcardpayment")
Else
    MinimumAmountForCardPayment = 0
End If
 if Not IsNull(objRdsconfig("AverageDeliveryTime")) Then sAverageDeliveryTime = Cdbl(objRdsconfig("AverageDeliveryTime"))
    if Not IsNull(objRdsconfig("AverageCollectionTime")) Then sAverageCollectionTime = Cdbl(objRdsconfig("AverageCollectionTime"))
  
If Not IsNull(objRdsconfig("FavIconUrl")) Then
    FAVICONURL = objRdsconfig("FavIconUrl")
Else
    FAVICONURL = ""
End If
If Not IsNull(objRdsconfig("AddToHomeScreenURL")) Then
    ADDTOHOMESCREENURL = objRdsconfig("AddToHomeScreenURL")
Else
    ADDTOHOMESCREENURL = ""
End If

If Not IsNull(objRdsconfig("ShowRestaurantDetailOnReceipt")) Then
    ShowRestaurantDetailOnReceipt = Lcase(objRdsconfig("ShowRestaurantDetailOnReceipt"))
Else
    ShowRestaurantDetailOnReceipt = "1"
End If

If Not IsNull(objRdsconfig("PrinterFontSizeRatio")) Then
    PrinterFontSizeRatio = Lcase(objRdsconfig("PrinterFontSizeRatio"))
Else
    PrinterFontSizeRatio = 1
End If

If Not IsNull(objRdsconfig("ServiceChargePercentage")) Then
    ServiceChargePercentage = Lcase(objRdsconfig("ServiceChargePercentage"))
Else
    ServiceChargePercentage = 0
End If

If Not IsNull(objRdsconfig("InRestaurantServiceChargeOnly")) Then
    InRestaurantServiceChargeOnly = Lcase(objRdsconfig("InRestaurantServiceChargeOnly"))
Else
    InRestaurantServiceChargeOnly = "0"
End If
    
If Not IsNull(objRdsconfig("Tip_percent")) Then
    Tip_percent = Lcase(objRdsconfig("Tip_percent"))
Else
    Tip_percent = 0
End If

If Not IsNull(objRdsconfig("InRestaurantTipChargeOnly")) Then
    InRestaurantTipChargeOnly = Lcase(objRdsconfig("InRestaurantTipChargeOnly"))
Else
    InRestaurantTipChargeOnly = "0"
End If

If Not IsNull(objRdsconfig("Tax_Percent")) Then
    Tax_Percent = Lcase(objRdsconfig("Tax_Percent"))
Else
    Tax_Percent = 0
End If

If Not IsNull(objRdsconfig("InRestaurantTaxChargeOnly")) Then
    InRestaurantTaxChargeOnly = Lcase(objRdsconfig("InRestaurantTaxChargeOnly"))
Else
    InRestaurantTaxChargeOnly = "0"
End If
isCheckCapcha = objRdsconfig("isCheckCapcha")
 
If Not IsNull(objRdsconfig("IsDualReceiptPrinting")) Then
    IsDualReceiptPrinting = Lcase(objRdsconfig("IsDualReceiptPrinting"))
Else
    IsDualReceiptPrinting = "0"
End If

Currency_PAYPAL    = objRdsconfig("Currency_PAYPAL")
Currency_STRIPE   = objRdsconfig("Currency_STRIPE")
Currency_WOLRDPAY = objRdsconfig("Currency_WOLRDPAY")
Stripe_Country = objRdsconfig("Stripe_Country")

enable_StripePaymentButton = objRdsconfig("enable_StripePaymentButton") & "" 
enable_CashPayment =  objRdsconfig("enable_CashPayment") & ""

Show_Ordernumner_printer   = objRdsconfig("Show_Ordernumner_printer") & ""
if Show_Ordernumner_printer = "" then Show_Ordernumner_printer = "yes"
Show_Ordernumner_Receipt = objRdsconfig("Show_Ordernumner_Receipt") & ""
    if Show_Ordernumner_Receipt = "" then Show_Ordernumner_Receipt = "yes"
Show_Ordernumner_Dashboard = objRdsconfig("Show_Ordernumner_Dashboard") & ""
    if Show_Ordernumner_Dashboard = "" then Show_Ordernumner_Dashboard = "yes"

objRdsconfig.MoveNext    
Loop
    objRdsconfig.Close
    objConconfig.Close 
set objRdsconfig = nothing
set objConconfig = nothing


Function URLDecode(ByVal What)
'URL decode Function
'2001 Antonin Foller, PSTRUH Software, http://www.motobit.com
  Dim Pos, pPos

  'replace + To Space
  What = Replace(What, "+", " ")

  on error resume Next
  Dim Stream: Set Stream = CreateObject("ADODB.Stream")
  If err = 0 Then 'URLDecode using ADODB.Stream, If possible
    on error goto 0
    Stream.Type = 2 'String
    Stream.Open

    'replace all %XX To character
    Pos = InStr(1, What, "%")
    pPos = 1
    Do While Pos > 0
      Stream.WriteText Mid(What, pPos, Pos - pPos) + _
        Chr(CLng("&H" & Mid(What, Pos + 1, 2)))
      pPos = Pos + 3
      Pos = InStr(pPos, What, "%")
    Loop
    Stream.WriteText Mid(What, pPos)

    'Read the text stream
    Stream.Position = 0
    URLDecode = Stream.ReadText

    'Free resources
    Stream.Close
  Else 'URL decode using string concentation
    on error goto 0
    'UfUf, this is a little slow method. 
    'Do Not use it For data length over 100k
    Pos = InStr(1, What, "%")
    Do While Pos>0 
      What = Left(What, Pos-1) + _
        Chr(Clng("&H" & Mid(What, Pos+1, 2))) + _
        Mid(What, Pos+3)
      Pos = InStr(Pos+1, What, "%")
    Loop
    URLDecode = What
  End If
End Function

	 %>