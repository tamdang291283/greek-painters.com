<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../../Config.asp" -->
<!-- #include file="../restaurantsettings.asp" -->
<!-- #include file="../timezone.asp" -->
<%Server.ScriptTimeout=86400%>

<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers=""
MM_authFailedURL="../../cms/index.asp?e=2"
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
	
	<link href="../css/bootstrap.min.css" rel="stylesheet">
	<link href="../css/style.css" rel="stylesheet">

  <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
  <![endif]-->

  <!-- Fav and touch icons -->
   <% If FAVICONURL & "" <> "" Then %> <link rel='shortcut icon' href='<%=FAVICONURL %>' type='image/x-icon'/ > <% end If %>
  
	<script type="text/javascript" src="../js/jquery.min.js"></script>
	<script type="text/javascript" src="../js/bootstrap.min.js"></script>
	<script type="text/javascript" src="../js/scripts.js"></script>
	
	
</head>

<body>
<div class="container">
	 <!-- #Include file="../inc-header.inc"-->
	




<div class="row clearfix">
		<div class="col-md-12 column">
		
		
			<ol class="breadcrumb">
<li><a href="menu.asp">Main Menu</a></li>
  <li>Upload image</li>
  
</ol>
		<h1>Upload Image</h1>
			<FORM ACTION = "exe-image.asp" ENCTYPE="multipart/form-data" METHOD="POST">
<br>
<br>

<div align="center"><%
ss = server.mappath("../../images/" & Session("MM_id") & "/" & request.querystring("f"))
set fso = createobject("scripting.filesystemobject")
'response.write ss
if fso.FileExists (ss) then 
%>

<img src="../../images/<%=Session("MM_id")%>/<%=(request.querystring("f"))%>"  ><br>
<a href="exe-deleteimage.asp?catid=<%=request.querystring("catid")%>&id=<%=request.querystring("id")%>&f=<%=request.querystring("f")%>">DELETE THIS IMAGE?</a>
<%
end if
%>

<br>
<br>
<strong>UPLOAD IMAGE</strong><br>
<br>

Select new image: <INPUT type="File" name="File1" size=60>


<br>
<br>

<input name="submit" type="submit" value="UPLOAD">
<br>
<br>

<input type="hidden" name="id" value="<%=request.querystring("id")%>">
<input type="hidden" name="catid" value="<%=request.querystring("catid")%>">
</div>
</form>
			
		</div>
	</div>

      
</div>



<!-- Modal -->





</body>
</html>
