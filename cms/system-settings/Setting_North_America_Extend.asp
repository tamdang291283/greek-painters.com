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
If (CStr(Request("MM_update")) = "form1") Then
  If (Not MM_abortEdit) Then
    ' execute the update
    Dim MM_editCmd

    Set MM_editCmd = Server.CreateObject ("ADODB.Command")
    MM_editCmd.ActiveConnection = sConnStringcms
    
MM_editCmd.CommandText = "UPDATE businessdetails SET Tip_percent=?,InRestaurantTaxChargeOnly=?,Tax_Percent=?,InRestaurantTipChargeOnly=?  WHERE ID = " & MM_IIF(Request.Form("MM_recordId"), Request.Form("MM_recordId"), null)   '
MM_editCmd.Prepared = true

    
    If Request.Form("Tip_percent") = "" Then
        MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 5, 1, 255, 0)  'aDouble
    Else
        MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 5, 1, 255, Request.Form("Tip_percent")) 
    End If 

     If Request.Form("InRestaurantTaxChargeOnly") = "" Then
        MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 11, 1, 255, "false")  'bit
    Else
        MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 11, 1, 255, Request.Form("InRestaurantTaxChargeOnly")) 
    End If  

     If Request.Form("Tax_Percent") = "" Then
        MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param3", 5, 1, 255, 0)  'aDouble
    Else
        MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param3", 5, 1, 255, Request.Form("Tax_Percent")) 
    End If 

     If Request.Form("InRestaurantTipChargeOnly") = "" Then
        MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param4", 11, 1, 255, "false")  'bit
    Else
        MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param4", 11, 1, 255, Request.Form("InRestaurantTipChargeOnly")) 
    End If  
   
    
    
    'MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param53", 5, 1, -1, MM_IIF(Request.Form("MM_recordId"), Request.Form("MM_recordId"), null)) ' adDouble

    'REsponse.Write("AA" & Request.Form("SMSEnable")) 
    'Response.End()
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
   ' MM_editCmd.close()
    set MM_editCmd = nothing
    Response.Redirect(MM_editRedirectUrl)
  End If
End If
%>
<%
Dim Recordset1
Dim Recordset1_cmd
Dim Recordset1_numRows
Set Recordset1_cmd = Server.CreateObject ("ADODB.Command")
Recordset1_cmd.ActiveConnection = sConnStringcms
sql = "SELECT * FROM businessdetails where id=" & Session("MM_id")



Recordset1_cmd.CommandText = sql
Recordset1_cmd.Prepared = true
Set Recordset1 = Recordset1_cmd.Execute
Recordset1_numRows = 0
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
	<!--append â€˜#!watchâ€™ to the browser URL, then refresh the page. -->
	
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
		
			<form method="post" action="<%=MM_editAction%>" name="form1" role="form">
  
 
<div class="tab-content">
  
<div class="tab-pane" style="display:block" id="PaymentSetting">
    <div class="panel panel-default">
  <div class="panel-heading">Tax Charge</div>
  <div class="panel-body">
<div class="form-group">
<p>Set a tax charge of  [<input type="text" style="width:35px;" pattern="[0-9]+([\.][0-9]{0,2})?"  title="Tax Charge must be a number with up to 2 decimal places"  name="Tax_Percent" <%if Recordset1.Fields.Item("Tax_Percent").Value & "" <> "" then%>value="<%=Recordset1.Fields.Item("Tax_Percent").Value %>"<% else %>value="0"<%end if%> />]% for all orders.</p>
<input type="checkbox" name="InRestaurantTaxChargeOnly" value="1" <%if  LCase(Recordset1.Fields.Item("InRestaurantTaxChargeOnly").Value & "") =  "1" then  %> checked <% end if %> /> Tick this box is Tax Charges apply to In-Store ordering ONLY.
</div>

 </div>
</div>

     <div class="panel panel-default">
  <div class="panel-heading">Tip Charge</div>
  <div class="panel-body">
<div class="form-group">
<p>Set a tip charge of  [<input type="text" style="width:35px;" pattern="[0-9]+([\.][0-9]{0,2})?"  title="Tip Charge must be a number with up to 2 decimal places"  name="Tip_Percent" <%if Recordset1.Fields.Item("Tip_Percent").Value & "" <> "" then%>value="<%=Recordset1.Fields.Item("Tip_Percent").Value %>"<% else %>value="0"<%end if%> />]% for all orders.</p>
<input type="checkbox" name="InRestaurantTipChargeOnly" value="1" <%if  LCase(Recordset1.Fields.Item("InRestaurantTipChargeOnly").Value & "") =  "1" then  %> checked <% end if %> /> Tick this box is Tax Charges apply to In-Store ordering ONLY.
</div>

 </div>
</div>
    </div>





    
    </div>
  
  <input type="hidden" name="MM_update" value="form1">
  <input type="hidden" name="MM_recordId" value="<%= Recordset1.Fields.Item("ID").Value %>">
  <button type="submit" class="btn btn-default">Submit</button>
</form>



		</div>
	</div>

      
</div>



<!-- Modal -->

<% 
    Recordset1.close()
    set Recordset1 = nothing
   ' Recordset1_cmd.close()
    'set Recordset1_cmd = nothing
        Recordset1_cmd.ActiveConnection.Close
    set Recordset1_cmd = nothing
     %>
<script>
$(function () {
  $('[data-toggle="popover"]').popover({html:true})
})


</script>


</body>
</html>
