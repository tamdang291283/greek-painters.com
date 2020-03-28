<%

If Session("MM_id") = ""  Then
   Response.Redirect("../../cms/index.asp")
end if 
Set objConconfig = Server.CreateObject("ADODB.Connection")
Set objRdsconfig = Server.CreateObject("ADODB.Recordset") 

objConconfig.Open sConnStringcms
objRdsconfig.Open "SELECT *  FROM BusinessDetails  WHERE Id = " & Session("MM_id"), objConconfig

Do While NOT objRdsconfig.Eof

SMTP_AUTENTICATE=objRdsconfig("SMTP_AUTENTICATE")
MAIL_FROM=objRdsconfig("MAIL_FROM")
PAYPAL_URL=objRdsconfig("PAYPAL_URL")
PAYPAL_PDT=objRdsconfig("PAYPAL_PDT")
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
EPSONJSPRINTERURL = objRdsconfig("EPSONJSPRINTERURL")
EPSONPRINTERIDLIST = objRdsconfig("PrinterIDList")
    INRESTAURANTEPSONPRINTERIDLIST = objRdsconfig("InRestaurantEpsonPrinterIdList")
EPSONPRINTERIDLIST = Replace(EPSONPRINTERIDLIST & ";" & INRESTAURANTEPSONPRINTERIDLIST,";;",";") ' This use to list out all printer for CMS print button
INRESTAURANTEPSONPRINTERIDLIST = EPSONPRINTERIDLIST ' This use to list out all printer for CMS print button
SMSEnable = objRdsconfig("SMSEnable")
SMSOnDelivery = objRdsconfig("SMSOnDelivery") 
SMSOnAcknowledgement = objRdsconfig("SMSOnAcknowledgement") 
SMSSupplierDomain = objRdsconfig("SMSSupplierDomain") 
SMSOnOrder = objRdsconfig("SMSOnOrder") 
SMSOnOrderAfterMin = objRdsconfig("SMSOnOrderAfterMin") 
SMSOnOrderContent = objRdsconfig("SMSOnOrderContent") 
DefaultSMSCountryCode = objRdsconfig("DefaultSMSCountryCode") 

    Show_Ordernumner_printer   = objRdsconfig("Show_Ordernumner_printer") & ""
if Show_Ordernumner_printer = "" then Show_Ordernumner_printer = "yes"
Show_Ordernumner_Receipt = objRdsconfig("Show_Ordernumner_Receipt") & ""
    if Show_Ordernumner_Receipt = "" then Show_Ordernumner_Receipt = "yes"
Show_Ordernumner_Dashboard = objRdsconfig("Show_Ordernumner_Dashboard") & ""
    if Show_Ordernumner_Dashboard = "" then Show_Ordernumner_Dashboard = "yes"

    announcement = objRdsconfig("announcement") 
    inmenuannouncement =  objRdsconfig("inmenuannouncement") 
    announcement_Filter = objRdsconfig("announcement_Filter") 
    Close_StartDate = objRdsconfig("Close_StartDate") 

    Close_EndDate = objRdsconfig("Close_EndDate") 
    id = objRdsconfig("id") 
    css = objRdsconfig("css") 
BUSINESSNAME = objRdsconfig("Name")
printingtype = objRdsconfig("printingtype") & "" 
if printingtype = "" then
    printingtype="graphic"
end if
enable_CashPayment =  objRdsconfig("enable_CashPayment") & ""
ISSTRIPE = objRdsconfig("Stripe")
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



objRdsconfig.MoveNext    
Loop
objRdsconfig.Close
set objRdsconfig = nothing
objConconfig.Close 
set objConconfig = nothing

	 %>