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
	
	
</head>

<body>
<div class="container">
	 <!-- #Include file="inc-header.inc"-->
	




<div class="row clearfix">
		<div class="col-md-12 column">
		<ol class="breadcrumb">
 
  <li><a href="vouchers.asp">Voucher Codes</a></li>
 
  
</ol>
	<a href="vouchers-addmultiple.asp"  class="btn btn-primary pull-right">ADD MULTIPLE</a>	<a href="vouchers-add.asp"  class="btn btn-primary pull-right">ADD</a><h1>Vouchers</h1>
	<p>Click "add" to create a new voucher, to create a batch of vouchers click "add multiple"</p>
			<table class="table table-hover table-condensed table-striped">
				<thead>
					<tr>
						<th>
							Name
						</th>
						
						
						<th>
							
						</th>
					</tr>
				</thead>
				<tbody>
				
				<%  objRds.Close
                        objCon.Close
				  objCon.Open sConnStringcms
                        objRds.Open "SELECT * FROM vouchercodes where  IdBusinessDetail=" & Session("MM_id") , objCon

                        Do While NOT objRds.Eof
                        %>
                       <tr>
						<td>
							 <p><%= objRds("vouchercode") %></p>
							 
						</td>
						
						
						<td>
						
						
						<span class="pull-right">
						
			

			<a class="btn btn-primary btn"  href="vouchers-edit.asp?catid=<%=objRds("id")%>">
EDIT
</a>			
			<a class="btn btn-danger btn confirm"  href="vouchers-del.asp?catid=<%=objRds("id")%>">
DELETE
</a>




			
			
						</td>
						
					</tr>
                        <%
                            objRds.MoveNext    
                        Loop
                    
                        objRds.Close
                        objCon.Close
                        %>
				
					
					
					
					
					
				</tbody>
			</table>
			
		</div>
	</div>

      
</div>



<!-- Modal -->





</body>
</html>
