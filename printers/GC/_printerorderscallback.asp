<!-- #include file="../../Config.asp" -->
<% 
  

if  Request.querystring("ak")="Accepted" then

    Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 
	
	 
objCon.Open sConnString
objRds.Open "SELECT * FROM [Orders] WHERE Id = " & Request.querystring("o"), objCon, 1, 3 
	 objRds("printed") = 1
	objRds.Update 
    
     
objRds.Close
   set objRds = nothing 
objCon.Close    
set objCon = nothing
end if
%>