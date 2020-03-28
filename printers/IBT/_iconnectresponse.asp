<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../../Config.asp" -->



<%
      
Set objCon = Server.CreateObject("ADODB.Connection")
Set objRds = Server.CreateObject("ADODB.Recordset") 
objCon.Open sConnString
    dim Order_id : Order_id = request.form("order_id")
   ' Order_id = 3753
objRds.Open "SELECT * FROM orders where id=" & Order_id, objCon
'response.write "SELECT * FROM orders where id=" & Order_id
restaurantid=objRds("IdBusinessDetail")
dtime=objRds("DeliveryTime")
objRds.Close
set objRds = nothing
%>

<%




timezoneoffset=0
if restaurantid<>"" then
Set timezone_cmd = Server.CreateObject ("ADODB.Command")
timezone_cmd.ActiveConnection = sConnString
sql = "SELECT BusinessDetails.ID,  timezones.offset, timezones.offsetdst FROM BusinessDetails INNER JOIN timezones ON BusinessDetails.timezone = timezones.ID WHERE (((BusinessDetails.ID)=" & restaurantid & "));"
'response.write sql
timezone_cmd.CommandText = sql
timezone_cmd.Prepared = true
Set timezone = timezone_cmd.Execute

if not timezone.EOF then

timezoney = datepart("yyyy", date())
' REM EUROPEAN UNION CALCULATION:
DST_EU_SPRING = (31 - (5*timezoney/4 + 4) mod 7)
DST_EU_FALL = (31 - (5*timezoney/4 + 1) mod 7)
date1=CDate(DST_EU_SPRING & "/3/" & timezoney)
date2=CDate(DST_EU_FALL & "/10/" & timezoney)
if (DateDiff("d",date1,now)>1) and (DateDiff("d",now,date2)>1) then
timezoneoffset=timezone.Fields.Item("offsetdst").Value
else
timezoneoffset=timezone.Fields.Item("offset").Value
end if


timezoneoffsettime=split(timezoneoffset,":")
timezoneoffseth=timezoneoffsettime(0)
timezoneoffseth=right(timezoneoffseth,len(timezoneoffseth)-1)
if instr(timezoneoffset,"-") then
houroffset=houroffset-cint(timezoneoffseth)
else
houroffset=houroffset+cint(timezoneoffseth)
end if
end if
end if





Set objRdsconfig = Server.CreateObject("ADODB.Recordset") 


objRdsconfig.Open "SELECT *  FROM BusinessDetails  WHERE Id = " & restaurantid, objCon

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
objRdsconfig.MoveNext    
Loop
objRdsconfig.Close
set objRdsconfig = nothing




if request.form("status")=1 then
    ddateresponse=request.form("delivery_time") 
    ddateresponse=replace(ddateresponse," ",":")
    ddateresponse=replace(ddateresponse,"%3a",":")
    ddateresponse=replace(ddateresponse,"-",":")
    xd=split(ddateresponse,":")
    xd2=xd(2) & "/" & xd(3) & "/20" & xd(4) & " " & xd(0) & ":" & xd(1) & ":00"
    'response.write dtime & "<BR>"
    'response.write xd2

    if xd2 <> dtime then
    'Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 
    'objCon.Open sConnString
    objRds.Open "UPDATE orders SET DeliveryTime='" & xd2  & "' WHERE id=" & Order_id, objCon
            objRds.close()
        set objRds =  nothing
    'objCon.Close
    end if

    'Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 
    'objCon.Open sConnString
    objRds.Open "UPDATE orders SET acknowledged=1, acknowledgeddate='" & (DateAdd("h",houroffset,now)) & "',printed=1 WHERE id=" & Order_id, objCon
      objRds.close()
    set objRds =  nothing
    'objCon.Close
    'objCon.Open sConnString
    Set objRds = Server.CreateObject("ADODB.Recordset") 
    objRds.Open "SELECT * FROM ORDERS where id=" & Order_id & " ORDER BY id desc" , objCon
    SendEmail "Order Acknowledged", SITE_URL & "EmailOrderUpdate.asp?id_o=" & Order_id & "&id_r=" & restaurantid & "&message=Order Acknowledged"  ,objRds("email")
      objRds.close()
    set objRds =  nothing
 
end if

if request.form("status")=2 then
     Set objRds = Server.CreateObject("ADODB.Recordset") 
    objRds.Open "UPDATE orders SET cancelled=1, cancelleddate='" & (DateAdd("h",houroffset,now)) & "', cancelledby='Restaurant',cancelledreason='Cancelled at printer',printed=1 WHERE id=" & Order_id, objCon
         objRds.close()
     set objRds =  nothing 
    'objCon.Close
    'objCon.Open sConnString
    Set objRds = Server.CreateObject("ADODB.Recordset")
    objRds.Open "SELECT * FROM ORDERS where id=" & Order_id & " ORDER BY id desc" , objCon
    SendEmail "Order Cancelled", SITE_URL & "EmailOrderUpdate.asp?id_o=" & Order_id & "&id_r=" & restaurantid & "&message=Order Cancelled by Restaurant", objRds("email")



    if lcase( objRds("PaymentType"))="stripe-paid" or objRds("PaymentType")="Paypal-Paid" or objRds("PaymentType")="NoChex-Paid" or objRds("PaymentType")="Worldpay-Paid" or Ucase(objRds("Payment_status") & "")="PAID"  then
        SendEmail "Order Cancelled - Refund Customer", SITE_URL & "EmailOrderUpdate.asp?id_o=" &Order_id & "&id_r=" & restaurantid & "&message=Order Cancelled refund customer",objRds("email")
    end if
    objRds.close()
    set objRds = nothing
 
end if

    objCon.close()
    set objCon = nothing
%>

