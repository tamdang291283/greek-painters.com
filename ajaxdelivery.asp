<!-- #include file="Config.asp" -->
<!-- #include file="timezone.asp" -->
<!-- #include file="restaurantsettings.asp" -->
<!--#include file="payments/worldpay/worldpayconfig.asp"-->
<!--#include file="md5.asp"-->

<%



Set objCon = Server.CreateObject("ADODB.Connection")
Set objRds = Server.CreateObject("ADODB.Recordset") 




objCon.Open sConnString
objRds.Open "SELECT * FROM [Orders] WHERE SessionId ='" &  Session.SessionID & "'", objCon, 1, 3 

    if not objRds.EOF then
        objRds("deliverytype") = request.querystring("d")
        objRds.Update 
    end if
     
objRds.Close
set objRds = nothing
objCon.Close 
set objCon = nothing   
%>