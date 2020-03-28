<?xml version="1.0" encoding="utf-8"?>
<!-- #include file="Config.asp" -->
<%     Set objCon2 = Server.CreateObject("ADODB.Connection")

  Set objRds2 = Server.CreateObject("ADODB.Recordset") 
	
	 
objCon2.Open sConnString
objRds2.Open "SELECT * FROM [Orders] WHERE Id = 720", objCon2, 1, 3 
 objRds2("printed") = -1

objRds2.Update 
    
     
objRds2.Close
objCon2.Close 

%>