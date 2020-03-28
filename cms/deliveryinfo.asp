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
    MM_editCmd.CommandText = "UPDATE businessdetails SET [DeliveryMinAmount] = ?,[DeliveryMaxDistance] = ?,[DeliveryFreeDistance] = ?,[AverageDeliveryTime] = ?,[AverageCollectionTime] = ?,[DeliveryFee] = ?,[disable_delivery] = ?,[disable_collection] = ?, [DeliveryChargeOverrideByOrderValue] = ?, [individualpostcodeschecking] = ?, [individualpostcodes] = ?, [orderonlywhenopen] = ?,[disablelaterdelivery] = ?, [ordertodayonly] = ?, [mileskm] = ?, [distancecalmethod] = ? WHERE ID = ?" 
    MM_editCmd.Prepared = true
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 202, 1, 255, Request.Form("DeliveryMinAmount")) ' adVarWChar
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 202, 1, 255, Request.Form("DeliveryMaxDistance")) ' adVarWChar
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param3", 202, 1, 255, Request.Form("DeliveryFreeDistance")) ' adVarWChar
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param4", 202, 1, 255, Request.Form("AverageDeliveryTime")) ' adVarWChar
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param5", 202, 1, 255, Request.Form("AverageCollectionTime")) ' adVarWChar
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param6", 202, 1, 255, Request.Form("DeliveryFee")) ' adVarWChar
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param7", 202, 1, 255, Request.Form("disable_delivery"))
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param8", 202, 1, 255, Request.Form("disable_collection"))
    if Request.Form("DeliveryChargeOverrideByOrderValue") & "" <> "" Then
	    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param8", 202, 1, 255, Request.Form("DeliveryChargeOverrideByOrderValue"))
    Else
        MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param8", 202, 1, 255, null)
    End If
		MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param4", 202, 1, -1, Request.Form("individualpostcodeschecking")) ' adVarWChar
		MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param10", 202, 1, 25500, Request.Form("individualpostcodes")) ' adVarWChar
		MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param12", 202, 1, -1, Request.Form("orderonlywhenopen")) ' adVarWChar
		MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param13", 202, 1, -1, Request.Form("disablelaterdelivery")) ' adVarWChar
		MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param14", 202, 1, -1, Request.Form("ordertodayonly")) ' adVarWChar
		MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param15", 202, 1, -1, Request.Form("mileskm")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param16", 202, 1, -1, Request.Form("distancecalmethod")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param17", 5, 1, -1, MM_IIF(Request.Form("MM_recordId"), Request.Form("MM_recordId"), null)) ' adDouble
    MM_editCmd.Execute

    
    MM_editCmd.ActiveConnection.Close
    set MM_editCmd = nothing

         Set MM_editCmd = Server.CreateObject ("ADODB.Command")
    MM_editCmd.ActiveConnection = sConnStringcms
    MM_editCmd.CommandText = "UPDATE businessdetails SET [DeliveryMinAmount] = ?,[DeliveryMaxDistance] = ?,[DeliveryFreeDistance] = ?,[AverageDeliveryTime] = ?,[AverageCollectionTime] = ?,[DeliveryFee] = ?,[disable_delivery] = ?,[disable_collection] = ?, [DeliveryChargeOverrideByOrderValue] = ?, [individualpostcodeschecking] = ?, [individualpostcodes] = ?, [orderonlywhenopen] = ?,[disablelaterdelivery] = ?, [ordertodayonly] = ?, [mileskm] = ?, [distancecalmethod] = ? WHERE ID = ?" 
    MM_editCmd.Prepared = true
        MM_editCmd.CommandText = "update openingtimes set [minacceptorderbeforeclose] = ? where [minacceptorderbeforeclose] > ? and [IDBusinessdetail] = ?  "                       
                MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 202, 1, 255, Request.Form("AverageDeliveryTime")) ' adVarWChar
	    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 202, 1, 255, Request.Form("AverageDeliveryTime")) ' adVarWChar
	    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param3", 202, 1, 255, Request.Form("MM_recordId")) ' adVarWChar
        MM_editCmd.Execute

    MM_editCmd.ActiveConnection.Close

    ' append the query string to the redirect URL
    Dim MM_editRedirectUrl
    MM_editRedirectUrl = "loggedin.asp"
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
 
 <li><a href="#">System Settings</a></li>
 <li>Edit Delivery/Collection Info</li>
  
</ol>
			
			
			  <div class="panel panel-default">
  <div class="panel-heading">Delivery Charges</div>
  <div class="panel-body">
			
			<form method="post" action="<%=MM_editAction%>" name="form1" role="form">
  <div class="form-group">
    <label for="document name">Delivery Minimum Amount</label>
	<p>Enter the minimum order value for deliveries, any order less than this value won't be available for delivery.</p>
    <input type="text" class="form-control" id="DeliveryMinAmount" name="DeliveryMinAmount" value="<%=(Recordset1.Fields.Item("DeliveryMinAmount").Value)%>" required>
  </div>
  
    
  <div class="form-group">
    <label for="document name">Delivery Free Distance</label>
	<p>Enter the distance under which deliveries are free.</p>
    <input type="text" class="form-control" id="DeliveryFreeDistance" name="DeliveryFreeDistance" value="<%=(Recordset1.Fields.Item("DeliveryFreeDistance").Value)%>" required>
  </div>
  
    <div class="form-group">
	
    <label for="document name">Delivery Fee</label>
	<p>Enter the delivery price.</p>
    <input type="text" class="form-control" id="DeliveryFee" name="DeliveryFee" value="<%=(Recordset1.Fields.Item("DeliveryFee").Value)%>" required>
  </div>
  
    <div class="form-group">
    <label for="document name">Delivery Max Distance</label>
	<p>Enter the max delivery distance for orders.</p>
    <input type="text" class="form-control" id="DeliveryMaxDistance" name="DeliveryMaxDistance" value="<%=(Recordset1.Fields.Item("DeliveryMaxDistance").Value)%>" required>
  </div>
  
  
    <div class="form-group">
    <label for="document name">Delivery Charge Override By Order Value    </label>
	<p>Enter the order value for which delivery charges become free/zero. Leave blank for no override.</p>
    <input type="text" class="form-control" id="DeliveryChargeOverrideByOrderValue" name="DeliveryChargeOverrideByOrderValue" value="<%=(Recordset1.Fields.Item("DeliveryChargeOverrideByOrderValue").Value)%>">

	
  </div>
  
     
  
  
  

  
</div></div>
  <div class="panel panel-default">
  <div class="panel-heading">Delivery Times</div>
  <div class="panel-body">
  
  
  <div class="form-group">
    <label for="document name">Average Delivery Time</label>
	<p>Enter the average time deliveries take.</p>
    <input type="text" class="form-control" id="AverageDeliveryTime" name="AverageDeliveryTime" value="<%=(Recordset1.Fields.Item("AverageDeliveryTime").Value)%>" required>
  </div>
  
  
  <div class="form-group">
    <label for="document name">Average Collection Time</label>
	<p>Enter the average time it takes to prepare a collection ready for pickup.</p>
    <input type="text" class="form-control" id="toppingsgroup" name="AverageCollectionTime" value="<%=(Recordset1.Fields.Item("AverageCollectionTime").Value)%>" required>
  </div>
</div></div>



<div class="panel panel-default">
  <div class="panel-heading">Delivery Units</div>
  <div class="panel-body">
  
  <div class="form-group">
<label for="document name">Select the unit for calculating delivery distance</label>


<input type="radio" name="mileskm" value="miles" <%if Recordset1.Fields.Item("mileskm").Value="miles" then%>checked<%end if%>> Miles &nbsp;&nbsp; <input type="radio" name="mileskm" value="km" <%if Recordset1.Fields.Item("mileskm").Value="km" then%>checked<%end if%>> KM 

</div>

  </div>
    </div>
<div class="panel panel-default">
  <div class="panel-heading">Delivery distance checking method</div>
  <div class="panel-body">
  
  <div class="form-group">
<label for="document name">Select the method for calculating delivery distance</label>


<input type="radio" name="distancecalmethod" value="crow-fly" <%if Recordset1.Fields.Item("distancecalmethod").Value="crow-fly" then%>checked<%end if%>> Crow-fly &nbsp;&nbsp; <input type="radio" name="distancecalmethod" value="googleapi" <%if Recordset1.Fields.Item("distancecalmethod").Value="googleapi" then%>checked<%end if%>> Google API 

</div>
    
</div>
</div>

<div class="panel panel-default">
  <div class="panel-heading">Order Only When Open</div>
  <div class="panel-body">
  
  <div class="form-group">
<label for="document name">Disable Ordering outside opening hours</label>


<input type="radio" name="orderonlywhenopen" value="1" <%if Recordset1.Fields.Item("orderonlywhenopen").Value=-1 then%>checked<%end if%>> Yes &nbsp;&nbsp; <input type="radio" name="orderonlywhenopen" value="0" <%if Recordset1.Fields.Item("orderonlywhenopen").Value=0 then%>checked<%end if%>> No 

</div>

  
    
</div>
</div>


<div class="panel panel-default">
  <div class="panel-heading">Delivery by Individual Postcode</div>
  <div class="panel-body">
  
  <div class="form-group">
<label for="document name">Enable Delivery by Individual Postcode</label>
<p>Turn on/off the delivery option.</p>

<input type="radio" name="individualpostcodeschecking" value="1" <%if Recordset1.Fields.Item("individualpostcodeschecking").Value=-1 then%>checked<%end if%>> Yes &nbsp;&nbsp; <input type="radio" name="individualpostcodeschecking" value="0" <%if Recordset1.Fields.Item("individualpostcodeschecking").Value=0 then%>checked<%end if%>> No 

</div>

  
    <div class="form-group">
    <label for="Description">Individual Postcodes</label>
	<p>Add the postcodes you cover seperated by commas.</p>
	<textarea class="form-control" id="individualpostcodes" name="individualpostcodes" rows="3"><%=(Recordset1.Fields.Item("individualpostcodes").Value)%></textarea>
   
  </div>
</div>
</div>



  <div class="panel panel-default">
  <div class="panel-heading">Delivery Toggle</div>
  <div class="panel-body">
  
  <div class="form-group">
<label for="document name">Disable Delivery</label>
<p>Turn on/off the delivery option.</p>


<input type="radio" name="disable_delivery" value="Yes" <%if Recordset1.Fields.Item("disable_delivery").Value="Yes" then%>checked<%end if%>> Yes &nbsp;&nbsp; <input type="radio" name="disable_delivery" value="No" <%if Recordset1.Fields.Item("disable_delivery").Value="No" then%>checked<%end if%>> No 


</div>

  
    <div class="form-group">
<label for="document name">Disable Collection</label>
<p>Turn on/off the collection option.</p>
<input type="radio" name="disable_collection" value="Yes" <%if Recordset1.Fields.Item("disable_collection").Value="Yes" then%>checked<%end if%>> Yes &nbsp;&nbsp; <input type="radio" name="disable_collection" value="No" <%if Recordset1.Fields.Item("disable_collection").Value="No" then%>checked<%end if%>> No 


</div>
</div>
</div>

	<div class="panel panel-default">
  <div class="panel-heading">Later Delivery</div>
  <div class="panel-body">
  
  <div class="form-group">
<label for="document name">Disable Later Delivery Option</label>
<p>Turn on/off the deliver later option.</p>


<input type="radio" name="disablelaterdelivery" value="1" <%if Recordset1.Fields.Item("disablelaterdelivery").Value=-1 then%>checked<%end if%>> Yes &nbsp;&nbsp; <input type="radio" name="disablelaterdelivery" value="0" <%if Recordset1.Fields.Item("disablelaterdelivery").Value=0 then%>checked<%end if%>> No 


</div>

  <div class="form-group">
<label for="document name">Only allow later order for today only.</label>
<p>Not later delivery option above must be set to "No".</p>


<input type="radio" name="ordertodayonly" value="1" <%if Recordset1.Fields.Item("ordertodayonly").Value=-1 then%>checked<%end if%>> Yes &nbsp;&nbsp; <input type="radio" name="ordertodayonly" value="0" <%if Recordset1.Fields.Item("ordertodayonly").Value=0 then%>checked<%end if%>> No 


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





</body>
</html>
