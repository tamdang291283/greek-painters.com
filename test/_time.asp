<!-- #include file="../Config.asp" -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>

ASP says the time is <%=now%>









<br/><br/>
<script language=jscript runat=server>
 function currentUTC(){
 var d, s;
 d = new Date();
 s = "Server current UTC time is: ";
 s += d.toUTCString();
 return(s);
 }
 </script>

<%
	response.write currentUTC()
%>


<script language=jscript runat=server>

  var x = new Date()
  Application("ServerGMTOffset") = new Date().getTimezoneOffset() // GMT offset in minutes of the server (sign inversed to bring into line with reality)
</script>


<%y = datepart("yyyy", date())
' REM EUROPEAN UNION CALCULATION:
DST_EU_SPRING = (31 - ((5*y -5*y mod 4)/4 + 4) mod 7)
DST_EU_FALL = (31 - ((5*y -5*y mod 4)/4 + 1) mod 7)
response.write("<BR><br>EU_SPRING: Sunday, " & DST_EU_SPRING & " March " & y)
response.write("<BR><br>EU_FALL: Sunday, " & DST_EU_FALL & " October " & y)
date1=CDate(DST_EU_SPRING & "/3/" & y & " 01:00:00")
date2=CDate(DST_EU_FALL & "/10/" & y & " 02:00:00" )
Response.Write("<br/> Now() " & Now() & " date1 " & date1 & " date2 " & date2 & "<br/>")
if Now() >= date1 and  Now() <= date2  then 'if (DateDiff("d",date1,now)>1) and (DateDiff("d",now,date2)>1) then
response.write "<BR><br>It is currently DST"
offset=Application("ServerGMTOffset")+60
else
offset=Application("ServerGMTOffset")
end if
%>
<br>
<br>

<%
response.write "Offset in minutes=" & offset


%>

<br>
<br>
Fixed time is <%=DateAdd("h",offset/60,now)%>







</body>
</html>
