<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../Config.asp" -->
<!-- #include file="timezone.asp" -->


<%splitarray=split(request("recordsarray[]"),",")

for i=0 to ubound(splitarray)

Set objCon2 = Server.CreateObject("ADODB.Connection")
Set objRds2 = Server.CreateObject("ADODB.Recordset")
objCon2.Open sConnStringcms
objRds2.Open "select * from menucategories where id=" & splitarray(i), objCon2, 1, 3    
objRds2("displayorder") = i+1
objRds2.update
objRds2.Close	
objCon2.Close
					
   

'response.write splitarray(i)
next



%>Saved!