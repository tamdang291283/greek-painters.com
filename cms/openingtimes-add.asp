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


<%
Dim avgDeliveryTime, avgCollectionTime
   avgDeliveryTime = "0"
avgCollectionTime = "0"
   objCon.Open sConnStringcms
    objRds.Open "SELECT * FROM BusinessDetails WHERE Id = " & Session("MM_id") , objCon       
    If not objRds.EOF Then
        avgDeliveryTime = objRds("AverageDeliveryTime")
        avgCollectionTime = objRds("AverageCollectionTime")
    End If
    objRds.Close()
    objCon.Close()
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
    MM_editCmd.CommandText = "INSERT INTO openingtimes (dayofweek, Hour_From, Hour_to, delivery,collection, IdBusinessDetail,minacceptorderbeforeclose) VALUES (?,?,?,?,?,?,?)" 
    MM_editCmd.Prepared = true
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 202, 1, 255, Request.Form("dayofweek")) ' adVarWChar
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 202, 1, 255, Request.Form("Hour_From")) ' adVarWChar
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param3", 202, 1, 255, Request.Form("Hour_To")) ' adVarWChar
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param4", 202, 1, 255, Request.Form("delivery")) ' adVarWChar
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param5", 202, 1, 255, Request.Form("collection")) ' adVarWChar
    
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param6", 202, 1, 255, Session("MM_id")) ' adVarWChar
    If  Request.Form("minacceptorderbeforeclose") & "" <> "" Then
        MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param7", 3, 1, 255, Request.Form("minacceptorderbeforeclose")) ' integer
    Else
        MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param7", 3, 1, 255, "0") ' integer
    End If
    MM_editCmd.Execute
    MM_editCmd.ActiveConnection.Close

    ' append the query string to the redirect URL
    Dim MM_editRedirectUrl
    MM_editRedirectUrl = "openingtimes.asp"
    If (Request.QueryString <> "") Then
      If (InStr(1, MM_editRedirectUrl, "?", vbTextCompare) = 0) Then
        MM_editRedirectUrl = MM_editRedirectUrl & "?" & Request.QueryString
      Else
        MM_editRedirectUrl = MM_editRedirectUrl & "&" & Request.QueryString
      End If
    End If
    Response.Redirect(MM_editRedirectUrl)
  End If
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
	<link href="css/bootstrap-clockpicker.min.css" rel="stylesheet">

  <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
  <![endif]-->

  <!-- Fav and touch icons -->
   <% If FAVICONURL & "" <> "" Then %> <link rel='shortcut icon' href='<%=FAVICONURL %>' type='image/x-icon'/ > <% end If %>
  
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/scripts.js"></script>
	<script type="text/javascript" src="js/bootstrap-clockpicker.js"></script>
	
</head>

<body>
<div class="container">
	 <!-- #Include file="inc-header.inc"-->
	




<div class="row clearfix">
		<div class="col-md-12 column">
		<ol class="breadcrumb">
 
  <li><a href="openingtimes.asp">Opening Times</a></li>
 <li>Add Time Slot</li>
  
</ol>
			<h1>Add Time Slot</h1>
			<form method="post" action="<%=MM_editAction%>" name="form1" role="form">
  <div class="form-group">
    <label for="document name">Day of week</label>
	<p>Select a day of the week.</p>
   <select class="form-control" name="dayofweek" id="dayofweek">
   
  <option value="1">Monday</option>
  <option value="2">Tuesday</option>
  <option value="3">Wednesday</option>
  <option value="4">Thursday</option>
  <option value="5">Friday</option>
  <option value="6">Saturday</option>
  <option value="7">Sunday</option>
  
</select>
  </div>

     <div class="form-group">
    <label for="Hour_From">Open Time</label>
  <p>Choose the opening time for this slot.</p>
	<div class="input-group clockpicker">
    <input type="text" class="form-control" value="00:00" required id="Hour_From" name="Hour_From">
    <span class="input-group-addon">
        <span class="glyphicon glyphicon-time"></span>
    </span>
</div>

	
  </div>
  
  
  
 <div class="form-group">
    <label for="Hour_To">Closing Time</label>
   <p>Choose the closing time for this slot.</p>
	<div class="input-group clockpicker">
    <input type="text" class="form-control" value="00:00" required id="Hour_To" name="Hour_To">
    <span class="input-group-addon">
        <span class="glyphicon glyphicon-time"></span>
    </span>
</div>
  </div>
  <script type="text/javascript">
$('.clockpicker').clockpicker();
</script>
    <div class="form-group">
    <label for="delivery">Delivery Available</label>
	<p>Is delivery available during this timeslot.</p>
    <input type="radio" name="delivery" value="y" checked> Yes &nbsp;&nbsp; <input type="radio" name="delivery" value="n" > No 
  </div>
  
   <div class="form-group">
    <label for="delivery">Collection Available</label>
	<p>Is collection available during this timeslot.</p>
    <input type="radio" name="collection" value="y" checked> Yes &nbsp;&nbsp; <input type="radio" name="collection" value="n" > No 
  </div>


 <div class="form-group">
    <label for="delivery">Accept order before closing</label>
	<p>Set how many min.before closing time a customer can make an order.   Eg.  Monday  5pm - 7PM . Set this value to 10, then Customer can place order until 6:50 PM. </p>
    <input type="text" name="minacceptorderbeforeclose" id="minacceptorderbeforeclose" value="" />
  </div>
  </div>
  
  <input type="hidden" name="MM_insert" value="form1">

  <button type="submit" class="btn btn-default">Submit</button>
</form>
		</div>
	</div>

      
</div>



<!-- Modal -->





</body>
    <script>


        $("#minacceptorderbeforeclose").change(function(){
        if(<%=avgDeliveryTime %> < parseInt( $("#minacceptorderbeforeclose").val())){
            $("[name=minacceptorderbeforeclose]").val("<%=avgDeliveryTime %>");
             $("[name=minacceptorderbeforeclose]").focus();
            alert("The time to accept order before closing must be smaller than the average delivery time.");
            }
        
        });
    </script>
</html>
