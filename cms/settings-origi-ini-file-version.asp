<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../Config.asp" -->
<!-- #include file="restaurantsettings.asp" -->
<!-- #include file="timezone.asp" -->
<%Server.ScriptTimeout=86400%>
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers=""
MM_authFailedURL="index.asp?e=2"
MM_grantAccess=false
If Session("MM_Username") <> "" Then
  If (true Or CStr(Session("MM_UserAuthorization"))="") Or _
         (InStr(1,MM_authorizedUsers,Session("MM_UserAuthorization"))>=1) Then
    MM_grantAccess = true
  End If
End If
If Not MM_grantAccess Then
  MM_qsChar = "?"
  If (InStr(1,MM_authFailedURL,"?") >= 1) Then MM_qsChar = "&"
  MM_referrer = Request.ServerVariables("URL")
  if (Len(Request.QueryString()) > 0) Then MM_referrer = MM_referrer & "?" & Request.QueryString()
  MM_authFailedURL = MM_authFailedURL & MM_qsChar & "accessdenied=" & Server.URLEncode(MM_referrer)
  Response.Redirect(MM_authFailedURL)
End If

Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Management Area</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">

	<!--link rel="stylesheet/less" href="less/bootstrap.less" type="text/css" /-->
	<!--link rel="stylesheet/less" href="less/responsive.less" type="text/css" /-->
	<!--script src="js/less-1.3.3.min.js"></script-->
	<!--append ‘#!watch’ to the browser URL, then refresh the page. -->
	
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">

  <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
  <![endif]-->

  <!-- Fav and touch icons -->
   <% If FAVICONURL & "" <> "" Then %> <link rel='shortcut icon' href='<%=FAVICONURL %>' type='image/x-icon'/ > <% end If %>
  
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/scripts.js"></script>
	
	<script type="text/javascript">// <![CDATA[
$(document).ready(function() {
$.ajaxSetup({ cache: false }); // This part addresses an IE bug.  without it, IE will only load the first number and will never refresh
setInterval(function() {
$('#results').load('ajax-neworder.asp');
if ($( "#results" ).text()>$( "#completetotal" ).text()) {
$( "#refreshspace" ).hide();
$( "#refresh" ).show();

var audio = document.getElementsByTagName("audio")[0];
audio.play();

}
}, 10000); // the "3000" here refers to the time to refresh the div.  it is in milliseconds. 

});
// ]]></script>
</head>

<body>
<div class="container">
	<!-- #Include file="inc-header.inc"-->
	



<div class="row clearfix">
		<div class="col-md-12 column">
		
		
		
		
		<h2>Edit Settings</h2>
		<form method="post" action="exe-settings.asp" name="form1" role="form">
		<%Const Filename = "../settings.ini"    ' file to read
Const ForReading = 1, ForWriting = 2, ForAppending = 3
Const TristateUseDefault = -2, TristateTrue = -1, TristateFalse = 0

' Create a filesystem object
Dim FSO
set FSO = server.createObject("Scripting.FileSystemObject")

' Map the logical path to the physical system path
Dim Filepath
Filepath = Server.MapPath(Filename)

if FSO.FileExists(Filepath) Then

    ' Get a handle to the file
    Dim file    
    set file = FSO.GetFile(Filepath)

    ' Get some info about the file
    Dim FileSize
    FileSize = file.Size

 

    ' Open the file
    Dim TextStream
    Set TextStream = file.OpenAsTextStream(ForReading, TristateUseDefault)

    ' Read the file line by line
    Do While Not TextStream.AtEndOfStream
        Dim Line
        Line = TextStream.readline
   if instr(line,"=") then 
   sstring=0
   if instr(line,"=""") then
   sstring=1
   end if
   splitarray=split(line,"=")
   
	%>
	 <div class="form-group">
    <label for="name"><%=splitarray(0)%></label>
    <input type="text" class="form-control" id="<%=splitarray(0)%>|<%=sstring%>" name="<%=splitarray(0)%>|<%=sstring%>" value="<%=replace(splitarray(1),"""","")%>" required>
  </div>
  <%end if
	
        ' Do something with "Line"
        Line = Line & vbCRLF
    
       
    Loop


    Response.Write "</pre><hr>"

    Set TextStream = nothing
    
Else



End If

Set FSO = nothing%>
		
		
		
		
		
		<button type="submit" class="btn btn-default">Update</button>
		</form>
		</div></div>



<!-- Modal -->




<!-- /.modal -->




</body>
</html>
