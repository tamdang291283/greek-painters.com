<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../../Config.asp" -->
<!-- #include file="../restaurantsettings.asp" -->
<!-- #include file="../timezone.asp" -->
<%Server.ScriptTimeout=86400%>

<%
Dim MM_editAction
MM_editAction = CStr(Request.ServerVariables("SCRIPT_NAME"))
If (Request.QueryString <> "") Then
  MM_editAction = MM_editAction & "?" & Server.HTMLEncode(Request.QueryString)
End If

' boolean to abort record edit
Dim MM_abortEdit
MM_abortEdit = false
%>
<%
' IIf implementation
Function MM_IIf(condition, ifTrue, ifFalse)
  If condition = "" Then
    MM_IIf = ifFalse
  Else
    MM_IIf = ifTrue
  End If
End Function
%>
<%
If (CStr(Request("MM_insert")) = "form1") Then
  If (Not MM_abortEdit) Then
    ' execute the update
    Dim MM_editCmd

    Set MM_editCmd = Server.CreateObject ("ADODB.Command")
    MM_editCmd.ActiveConnection = sConnStringcms
    MM_editCmd.CommandText = " UPDATE businessdetails SET pswd = ? where id  = " & Request.Form("MM_recordId")
    MM_editCmd.Prepared = true
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 202, 1, 255, Request.Form("newpassword")) ' adVarWChar
    MM_editCmd.Execute
    MM_editCmd.ActiveConnection.Close

    ' append the query string to the redirect URL
       Dim MM_editRedirectUrl
        MM_editRedirectUrl = "../../cms/dashboards/loggedin.asp"
        If (Request.QueryString <> "") Then
          If (InStr(1, MM_editRedirectUrl, "?", vbTextCompare) = 0) Then
            MM_editRedirectUrl = MM_editRedirectUrl & "?" & Request.QueryString
          Else
            MM_editRedirectUrl = MM_editRedirectUrl & "&" & Request.QueryString
          End If
        End If
    set MM_editCmd = nothing
    Response.Redirect(MM_editRedirectUrl)
  End If
End If

    Set Recordset1_cmd = Server.CreateObject ("ADODB.Command")
    Recordset1_cmd.ActiveConnection = sConnStringcms
sql = "SELECT  id,pswd,email FROM businessdetails where id=" & Session("MM_id")

    Recordset1_cmd.CommandText = sql
    Recordset1_cmd.Prepared = true
    Recordset1 = Server.CreateObject("ADODB.Recordset")
Set Recordset1 = Recordset1_cmd.Execute
    Dim Password, ResID ,email 
    if not Recordset1.EOF then
        Password = Recordset1("pswd")
        ResID = Recordset1("id")
        email = Recordset1("email")
    end if
    Recordset1.close()
    set Recordset1 = nothing
    Recordset1_cmd.ActiveConnection.Close
    set Recordset1_cmd = nothing

%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Management Area</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">
	<link href="../css/bootstrap.min.css" rel="stylesheet">
	<link href="../css/style.css" rel="stylesheet">
  <!-- Fav and touch icons -->
   <% If FAVICONURL & "" <> "" Then %> <link rel='shortcut icon' href='<%=FAVICONURL %>' type='image/x-icon'/ > <% end If %>
	<script type="text/javascript" src="../js/jquery.min.js"></script>
	<script type="text/javascript" src="../js/bootstrap.min.js"></script>
	<script type="text/javascript" src="../js/scripts.js"></script>
    <script type="text/javascript" src="../js/validator.js"></script>
</head>

<body>
<div class="container">
	 <!-- #Include file="../inc-header.inc"-->

<div class="row clearfix">
		<div class="col-md-12 column">
	
			<H1>User Profile</H1>
			<form method="post" autocomplete="off" action="<%=MM_editAction%>" name="form1" role="form" data-toggle="validator">
     
    <div class="form-group">
        <label for="inputPass">User Name</label>
        <input type="email" class="form-control" readonly id="username" value="<%=email %>">
        <div class="help-block with-errors"></div>
  </div>
                       
   <div class="form-group">
    <label for="inputPass">Old Password</label> 
    <input type="hidden" id="hidpassword" value="<%=Password %>" />
    <input type="password" class="form-control" id="inputPassword" value=""  onkeyup="if($(this).val()==$('#hidpassword').val()) $('#lbpassmatch').show(); else $('#lbpassmatch').hide()  " data-match="#hidpassword" data-match-error="Password did not match. Please try again.">
    <div class="help-block with-errors"></div>
    <div class="help-block" style="display:none;color:#393;" id="lbpassmatch">Password matched</div>
  </div>
   <div class="form-group">
        <label for="inputPass">New Password</label>
        <input type="password" class="form-control"  id="newpassword" name="newpassword" required>
        <div class="help-block with-errors"></div>
  </div>
   <div class="form-group">
        <label for="inputPass">Confirm New Password</label>
    <input type="password" class="form-control" id="confirmnewpass" data-match="#newpassword" data-match-error="Passwords did not match. Please try again."   required>
    <div class="help-block with-errors"></div>
  </div>

  
  <input type="hidden" name="MM_insert" value="form1">
<input type="hidden" name="MM_recordId" value="<%= ResID %>">
  <button type="submit" class="btn btn-default">Submit</button>
</form>
		</div>
	</div>
</div>

<!-- Modal -->

</body>
</html>
