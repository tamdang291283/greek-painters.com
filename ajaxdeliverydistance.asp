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

If objRds.EOF Then
    
    objRds.Close
    objCon.Close   
    Set objRds = nothing
    Set objRds = nothing
    Response.end()
End If
objRds("deliverydistance") = request.querystring("d")


objRds.Update 
    
     
objRds.Close
set objRds = nothing
objCon.Close   
set objCon = nothing 
%>