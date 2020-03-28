<!-- #include file="../Config.asp" -->
<!-- #include file="timezone.asp" -->
<%
' *** Validate request to log in to this site.
MM_LoginAction = Request.ServerVariables("URL")
If Request.QueryString <> "" Then MM_LoginAction = MM_LoginAction + "?" + Server.HTMLEncode(Request.QueryString)
MM_valUsername = CStr(Request.Form("username"))
If MM_valUsername <> "" Then
  Dim MM_fldUserAuthorization
  Dim MM_redirectLoginSuccess
  Dim MM_redirectLoginFailed
  Dim MM_loginSQL
  Dim MM_rsUser
  Dim MM_rsUser_cmd
  
  MM_fldUserAuthorization = ""
  MM_redirectLoginSuccess = "../cms/dashboards/loggedin.asp"
  MM_redirectLoginFailed = "index.asp?e=1"

  MM_loginSQL = "SELECT * "
  If MM_fldUserAuthorization <> "" Then MM_loginSQL = MM_loginSQL & "," & MM_fldUserAuthorization
  MM_loginSQL = MM_loginSQL & " FROM BusinessDetails WHERE email = ? AND pswd = ?"
  Set MM_rsUser_cmd = Server.CreateObject ("ADODB.Command")
    Response.Write(sConnStringcms)
  MM_rsUser_cmd.ActiveConnection = sConnStringcms
  MM_rsUser_cmd.CommandText = MM_loginSQL
  MM_rsUser_cmd.Parameters.Append MM_rsUser_cmd.CreateParameter("param1", 200, 1, 255, MM_valUsername) ' adVarChar
  MM_rsUser_cmd.Parameters.Append MM_rsUser_cmd.CreateParameter("param2", 200, 1, 255, Request.Form("pswd")) ' adVarChar
  MM_rsUser_cmd.Prepared = true
  Set MM_rsUser = MM_rsUser_cmd.Execute

  If Not MM_rsUser.EOF Or Not MM_rsUser.BOF Then 
    ' username and password match - this is a valid user
    Session("MM_Username") = MM_valUsername
	Session("MM_Business") = (MM_rsUser.Fields.Item("Name").Value)
	Session("MM_id") = (MM_rsUser.Fields.Item("id").Value)
	session("restaurantid")=(MM_rsUser.Fields.Item("id").Value)
	Session("MM_email") = (MM_rsUser.Fields.Item("Email").Value)
    If (MM_fldUserAuthorization <> "") Then
      Session("MM_UserAuthorization") = CStr(MM_rsUser.Fields.Item(MM_fldUserAuthorization).Value)
    Else
      Session("MM_UserAuthorization") = ""
    End If
    if CStr(Request.QueryString("accessdenied")) <> "" And false Then
      MM_redirectLoginSuccess = Request.QueryString("accessdenied")
    End If
    MM_rsUser.Close
    Response.Redirect(MM_redirectLoginSuccess)
  End If
  MM_rsUser.Close
  Response.Redirect(MM_redirectLoginFailed)
End If
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
   <link rel='shortcut icon' href='../images-icons/favicon.ico' type='image/x-icon'/ >
  
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/scripts.js"></script>
</head>

<body>
<div class="container">
    <div class="row">
		<div class="col-md-4 col-md-offset-4"><br>
		<br>
		
    		<div class="panel panel-default">
			  	<div class="panel-heading">
			    	<h3 class="panel-title">Please sign in</h3>
			 	</div>
			  	<div class="panel-body">
			    	 <form name="form1" method="POST" action="<%=MM_LoginAction%>">
                    <fieldset>
			    	  	<div class="form-group">
			    		    <input class="form-control" placeholder="E-mail" name="username" id="username" type="text">
			    		</div>
			    		<div class="form-group">
			    			<input class="form-control" placeholder="Password" name="pswd" id="pswd" type="password" value="">
			    		</div>
						
						<%if request.querystring("e")=1 then%>
			    	<div class="alert alert-warning alert-dismissable">
  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
  <strong>Error!</strong> Incorrent username or password.
</div><%end if%>

<%if request.querystring("e")=2 then%>
			    	<div class="alert alert-warning alert-dismissable">
  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
  <strong>Error!</strong> A timeout has occured you have been logged out.
</div><%end if%>

			    		<input class="btn btn-lg btn-success btn-block" type="submit" value="Login">
			    	</fieldset>
			      	</form>
			    </div>
			</div>
		</div>
	</div>
</div>
</body>
</html>
