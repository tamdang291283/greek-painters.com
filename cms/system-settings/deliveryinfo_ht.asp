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
    Dim SQL : SQL = "UPDATE businessdetails SET [DeliveryMinAmount] = ?, " '1
        SQL = SQL & "[DeliveryMaxDistance] = ?,"  '2
        SQL = SQL & "[DeliveryFreeDistance] = ?," '3
        SQL = SQL & "[AverageDeliveryTime] = ?," '4
        SQL = SQL & "[AverageCollectionTime] = ?," '5
        SQL = SQL & "[DeliveryFee] = ?," '6
        SQL = SQL & "[disable_delivery] = ?," '7
        SQL = SQL & "[disable_collection] = ?, " '
        SQL = SQL & "[DeliveryChargeOverrideByOrderValue] = ?,"  '9
        SQL = SQL & "[individualpostcodeschecking] = ?," '10
        SQL = SQL & "[individualpostcodes] = ?, " '11
        SQL = SQL & " [orderonlywhenopen] = ?," '12
        SQL = SQL & "[disablelaterdelivery] = ?, " '13
        SQL = SQL & "[ordertodayonly] = ?," '14
        SQL = SQL & "[mileskm] = ?," ' 15
        SQL = SQL & " [distancecalmethod] = ?," '16
        SQL = SQL & " [DeliveryMile]=? ," '17
        SQL = SQL & "[Mon_Delivery] = ?," '18 
        SQL = SQL & "[Tue_Delivery] = ?," '19
        SQL = SQL & " [Wed_Delivery] = ?," '20 
        SQL = SQL & "[Thu_Delivery] = ?," '21
        SQL = SQL & "[Fri_Delivery] = ?," '22
        SQL = SQL & " [Sat_Delivery] = ?," '23
        SQL = SQL & "[Sun_Delivery] = ? ," '24
        SQL = SQL & "[Mon_Collection] = ?," '25
        SQL = SQL & "[Tue_Collection] = ?," '26
        SQL = SQL & "[Wed_Collection] = ?," '27
        SQL = SQL & "[Thu_Collection] = ?," '28
        SQL = SQL & "[Fri_Collection] = ?," '29
        SQL = SQL & "[Sat_Collection] = ?," '30
        SQL = SQL & "[Sun_Collection] = ?," '31
        SQL = SQL & "[DeliveryCostUpTo]=?," '32
        SQL = SQL & "[DeliveryUptoMile]=?," '33 
        SQL = SQL & "[s_DeliveryZonesPath]=? " '34
        SQL = SQL & "  WHERE ID = " & MM_IIF(Request.Form("MM_recordId"), Request.Form("MM_recordId"), null) 

    MM_editCmd.CommandText = SQL
    MM_editCmd.Prepared = true
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 202, 1, 255, MM_IIF(Request.Form("DeliveryMinAmount"),Request.Form("DeliveryMinAmount"),null) ) ' adVarWChar
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 202, 1, 255, Request.Form("DeliveryMaxDistance")) ' adVarWChar
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param3", 202, 1, 255, Request.Form("DeliveryFreeDistance")) ' adVarWChar
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param4", 202, 1, 255, Request.Form("AverageDeliveryTime")) ' adVarWChar
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param5", 202, 1, 255, Request.Form("AverageCollectionTime")) ' adVarWChar
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param6", 6, 1, 255, MM_IIF(Request.Form("DeliveryFee"),Request.Form("DeliveryFee"),0)) ' adVarWChar
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param7", 202, 1, 255, Request.Form("disable_delivery"))
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param8", 202, 1, 255, Request.Form("disable_collection"))
    if Request.Form("DeliveryChargeOverrideByOrderValue") & "" <> "" Then
	    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param8", 202, 1, 255, Request.Form("DeliveryChargeOverrideByOrderValue"))
    Else
        MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param8", 202, 1, 255, null)
    End If
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param4", 3, 1, -1, MM_IIF(Request.Form("individualpostcodeschecking"),Request.Form("individualpostcodeschecking"),0)) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param10", 202, 1, 255, Request.Form("individualpostcodes")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param12", 3, 1, -1, MM_IIF(Request.Form("orderonlywhenopen"),Request.Form("orderonlywhenopen"),0)) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param13", 3, 1, -1, MM_IIF(Request.Form("disablelaterdelivery"),Request.Form("disablelaterdelivery"),0)) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param14", 3, 1, -1, MM_IIF(Request.Form("ordertodayonly"),Request.Form("ordertodayonly"),0)) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param15", 202, 1, -1, Request.Form("mileskm")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param16", 202, 1, -1,     Request.Form("distancecalmethod")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param17", 6, 1, 255,   MM_IIF( Request.Form("DeliveryMile") ,Request.Form("DeliveryMile") ,0) ) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param18", 6, 1, 255, MM_IIF(Request.Form("Mon_Delivery"),Request.Form("Mon_Delivery") ,0) ) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param19", 6, 1, 255,MM_IIF( Request.Form("Tue_Delivery"), Request.Form("Tue_Delivery") ,0)  ) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param20", 6, 1, 255, MM_IIF(Request.Form("Wed_Delivery"),Request.Form("Wed_Delivery"),0) ) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param21", 6, 1, 255, MM_IIF(Request.Form("Thu_Delivery"),Request.Form("Thu_Delivery"),0) ) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param22", 6, 1, 255, MM_IIF(Request.Form("Fri_Delivery"),Request.Form("Fri_Delivery"),0) ) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param23", 6, 1, 255, MM_IIF(Request.Form("Sat_Delivery"),Request.Form("Sat_Delivery"),0) ) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param24", 6, 1, 255, MM_IIF(Request.Form("Sun_Delivery"),Request.Form("Sun_Delivery"),0) ) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param25", 6, 1, 255, MM_IIF(Request.Form("Mon_Collection") ,Request.Form("Mon_Collection"),0)) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param26", 6, 1, 255, MM_IIF(Request.Form("Tue_Collection"),Request.Form("Tue_Collection"),0) ) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param27", 6, 1, 255, MM_IIF(Request.Form("Wed_Collection"),Request.Form("Wed_Collection") ,0) ) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param28", 6, 1, 255, MM_IIF(Request.Form("Thu_Collection"),Request.Form("Thu_Collection"),0) ) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param29", 6, 1, 255, MM_IIF(Request.Form("Fri_Collection"),Request.Form("Fri_Collection"),0) ) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param30", 6, 1, 255, MM_IIF(Request.Form("Sat_Collection"),Request.Form("Sat_Collection"),0) ) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param31", 6, 1, 255, MM_IIF(Request.Form("Sun_Collection"),Request.Form("Sun_Collection"),0) ) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param32", 6, 1, 255, MM_IIF(Request.Form("DeliveryCostUpTo"),Request.Form("DeliveryCostUpTo"),0) ) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param33", 6, 1, 255, MM_IIF(Request.Form("DeliveryUptoMile"),Request.Form("DeliveryUptoMile"),0) ) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param34", 201, 1, 4000, MM_IIF(Request.Form("hidDeliveryZone"),Request.Form("hidDeliveryZone"),"") ) ' nText
       
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
      '   MM_editCmd.close()
     set MM_editCmd = nothing
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
	


	<script type="text/javascript"
  src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAvyfg017v5c_Wi2hQykmsv8VpS6tNaQoM&libraries=drawing">
</script>

    <script   type="text/javascript" src="<%=SITE_URL %>Scripts/jquery.lazy.min.js"></script>
    <script type="text/javascript" src="<%=SITE_URL %>scripts/fancybox/jquery.fancybox.pack.js?v=2.1.5"></script>	
    
    <link rel="stylesheet" type="text/css" href="<%=SITE_URL %>scripts/fancybox/jquery.fancybox.css?v=2.1.5">
<div class="row clearfix">
		<div class="col-md-12 column">
		<ol class="breadcrumb">
 
 <li><a href="#">System Settings</a></li>
 <li>Edit Delivery/Collection Info</li>
  
</ol>
            <div class="panel panel-default">
                <div class="panel-heading">Delivery Zones setup</div>
                <div class="panel-body">
                    <div class="form-group">
                        <!--<label for="document name">Delivery Zones setup</label>-->
                        <p id="DeliveryZoneInfo" style="color:red;"></p>
                        <a id="fancyBoxMap" style="display: block; padding-top: 5px;" class="fancybox text-centered" data-popup="#divFancyMap" href="#divFancyMap">Setup Zone</a>
                        <input type="hidden" id="hidZonesVal" name="hidZonesVal" value="" />
                       
                    </div>
                    <div id="divFancyMap" style="width: 100%; height: 90%; display: none; position: absolute;">

                        <div style="width: 100%; text-align: center;">
                            <button class="btn btn-default" onclick="drawRec();">Add zone</button>
                            <button class="btn btn-default" id="btnDeleteZone" onclick="deleteCurrentZone();" disabled>Delete selected zone</button>
                            <button class="btn btn-default" onclick="SaveZones();">Save</button>
                            <p style="display:block;color:green;margin-top:7px;height:11px;" id="pDrawingZoneMessage"></p>
                        </div>
                        <div id="divGoogleMap" style="width: 100%; height: 100%; position: absolute;"></div>


                    </div>


                </div>
            </div>
			
			  <div class="panel panel-default">
  <div class="panel-heading">Delivery Charges</div>
  <div class="panel-body">
			
			<form method="post" action="<%=MM_editAction%>" name="form1" role="form">
  <div class="form-group">
    <label for="document name">Delivery Minimum Amount</label>
	<p>Enter the minimum order value for deliveries, any order less than this value won't be available for delivery.</p>
    <input type="text" pattern="[0-9]+([\.][0-9]{0,2})?"  title="Delivery Minimum Amount must be a number with up to 2 decimal places"  class="form-control" id="DeliveryMinAmount" name="DeliveryMinAmount" value="<%=(Recordset1.Fields.Item("DeliveryMinAmount").Value)%>" required >
  </div>
  
    
  <div class="form-group">
    <label for="document name">Delivery Free Distance</label>
	<p>Enter the distance under which deliveries are free.</p>
    <input type="text" pattern="[0-9]+([\.][0-9]{0,2})?"  title="Delivery Free Distance must be a number with up to 2 decimal places"  class="form-control" id="DeliveryFreeDistance" name="DeliveryFreeDistance" value="<%=(Recordset1.Fields.Item("DeliveryFreeDistance").Value)%>" required>
  </div>
  
     <div class="form-group">
	
    <label for="document name">Cost up to a certain distance</label>
	<p></p>
    Cost: &nbsp;<input type="text" style="width:50px;display:inline;" pattern="[0-9]+([\.][0-9]{0,2})?" placeholder="Amount"  title="Delivery Fee must be a number with up to 2 decimal places" class="form-control" id="DeliveryCostUpTo" name="DeliveryCostUpTo" value="<%=(Recordset1.Fields.Item("DeliveryCostUpTo").Value)%>" required>&nbsp;
    up to &nbsp;<input type="text" style="width:50px;display:inline;" pattern="[0-9]+([\.][0-9]{0,2})?" placeholder="Mile"  title="Delivery Distance Fee must be a number with up to 2 decimal places" class="form-control" id="DeliveryUptoMile" name="DeliveryUptoMile" value="<%=(Recordset1.Fields.Item("DeliveryUptoMile").Value)%>" required>&nbsp;miles/km

  </div>

    <div class="form-group">
	
    <label for="document name">Cost per additional distance</label>
	<p>Enter the delivery price.</p>
    <input type="text" style="width:50px;display:inline;" pattern="[0-9]+([\.][0-9]{0,2})?" placeholder="Amount"  title="Delivery Fee must be a number with up to 2 decimal places" class="form-control" id="DeliveryFee" name="DeliveryFee" value="<%=(Recordset1.Fields.Item("DeliveryFee").Value)%>" required>&nbsp;Per&nbsp;
    <input type="text" style="width:60px;display:inline;" pattern="[0-9]+([\.][0-9]{0,2})?" placeholder="Mile"  title="Delivery Distance Fee must be a number with up to 2 decimal places" class="form-control" id="DeliveryMile" name="DeliveryMile" value="<%=(Recordset1.Fields.Item("DeliveryMile").Value)%>" required>

  </div>
  
    <div class="form-group">
    <label for="document name">Delivery Max Distance</label>
	<p>Enter the max delivery distance for orders.</p>
    <input type="text"  pattern="[0-9]+([\.][0-9]{0,2})?"  title="Delivery Max Distance must be a number with up to 2 decimal places" class="form-control" id="DeliveryMaxDistance" name="DeliveryMaxDistance" value="<%=(Recordset1.Fields.Item("DeliveryMaxDistance").Value)%>" required>
  </div>
  
       
    <div class="form-group">
    <label for="document name">Delivery Charge Override By Order Value    </label>
	<p>Enter the order value for which delivery charges become free/zero. Leave blank for no override.</p>

    <input type="text" pattern="[0-9]+([\.][0-9]{0,2})?"  title="This field must be a number with up to 2 decimal places" class="form-control" id="DeliveryChargeOverrideByOrderValue" name="DeliveryChargeOverrideByOrderValue" value="<%=(Recordset1.Fields.Item("DeliveryChargeOverrideByOrderValue").Value)%>">

	
  </div>
  
     
 
  

  
</div></div>
  <div class="panel panel-default">
  <div class="panel-heading">Delivery Times</div>
  <div class="panel-body">
  
  <%
      dim AverageDeliveryTime
      AverageDeliveryTime =  Recordset1.Fields.Item("AverageDeliveryTime").Value
      if AverageDeliveryTime & "" = "" then
        AverageDeliveryTime =0
      end if
      dim Mon_Delivery : Mon_Delivery = Recordset1.Fields.Item("Mon_Delivery").Value & ""
      dim Tue_Delivery : Tue_Delivery  = Recordset1.Fields.Item("Tue_Delivery").Value & "" 
      dim Wed_Delivery : Wed_Delivery  = Recordset1.Fields.Item("Wed_Delivery").Value & ""
      dim Thu_Delivery : Thu_Delivery  = Recordset1.Fields.Item("Thu_Delivery").Value & ""
      dim Fri_Delivery : Fri_Delivery  = Recordset1.Fields.Item("Fri_Delivery").Value & ""
      dim Sat_Delivery : Sat_Delivery  = Recordset1.Fields.Item("Sat_Delivery").Value & ""
      dim Sun_Delivery : Sun_Delivery  = Recordset1.Fields.Item("Sun_Delivery").Value & ""
      if Mon_Delivery = "" then Mon_Delivery = AverageDeliveryTime
      if Tue_Delivery = "" then Tue_Delivery = AverageDeliveryTime
      if Wed_Delivery = "" then Wed_Delivery = AverageDeliveryTime
      if Thu_Delivery = "" then Thu_Delivery = AverageDeliveryTime
      if Fri_Delivery = "" then Fri_Delivery = AverageDeliveryTime
      if Sat_Delivery = "" then Sat_Delivery = AverageDeliveryTime
      if Sun_Delivery = "" then Sun_Delivery = AverageDeliveryTime

   
       
    
  %>
 <div class="row clearfix">
   <div class="col-md-6 column">
  <div class="form-group">
        
    <label for="document name">Average Delivery Time</label>
	<p>Enter the average time deliveries take.</p>
      <input type="hidden" name="AverageDeliveryTime" value="<%=(AverageDeliveryTime) %>" />
   <!-- <input type="text" pattern="\d+"  title="Average Delivery Time must be number"  class="form-control" id="AverageDeliveryTime" name="AverageDeliveryTime" value="<%=(Recordset1.Fields.Item("AverageDeliveryTime").Value)%>" required>-->

                <div class="row clearfix">
                    <div class="col-md-2 column">
                           <div class="form-check">
                             <label class="form-check-label">Monday</label>
                          </div>
           	        </div>
                     <div class="col-md-10 column">                            
                            <input style="width:60px" pattern="\d+" required  title="Average Delivery Time must be number" type="text" class="form-control" value="<%=Mon_Delivery %>"  name="Mon_Delivery">
                     </div>
           	    </div>                
                <div class="row clearfix">
                    <div class="col-md-2 column">
                           <div class="form-check">
                             <label class="form-check-label">Tuesday</label>
                          </div>
           	        </div>
                     <div class="col-md-10 column">
                       
                            <input style="width:60px" pattern="\d+"  title="Average Delivery Time must be number" required type="text" class="form-control" value="<%=Tue_Delivery %>" name="Tue_Delivery">                        
                  
                     </div>
           	    </div>
                 <div class="row clearfix">
                    <div class="col-md-2 column">
                           <div class="form-check">
                             <label class="form-check-label">Wednesday</label>
                          </div>
           	        </div>
                     <div class="col-md-10 column">
                       
                            <input style="width:60px" pattern="\d+"  title="Average Delivery Time must be number" required type="text" class="form-control" value="<%=Wed_Delivery %>" name="Wed_Delivery">                        
                     
                     </div>
           	    </div>
                 <div class="row clearfix">
                    <div class="col-md-2 column">
                           <div class="form-check">
                             <label class="form-check-label">Thursday</label>
                          </div>
           	        </div>
                     <div class="col-md-10 column">
                      
                            <input style="width:60px" pattern="\d+"  title="Average Delivery Time must be number" required type="text" class="form-control" value="<%=Thu_Delivery %>" name="Thu_Delivery">                        
                 
                     </div>
           	    </div>
                  <div class="row clearfix">
                    <div class="col-md-2 column">
                           <div class="form-check">
                             <label class="form-check-label">Friday</label>
                          </div>
           	        </div>
                     <div class="col-md-10 column">
                       
                            <input style="width:60px" pattern="\d+"  title="Average Delivery Time must be number" required type="text" class="form-control" value="<%=Fri_Delivery %>" name="Fri_Delivery">                        
                 
                     </div>
           	    </div>
                 <div class="row clearfix">
                    <div class="col-md-2 column">
                           <div class="form-check">
                             <label class="form-check-label">Saturday</label>
                          </div>
           	        </div>
                     <div class="col-md-10 column">
                     
                            <input style="width:60px" pattern="\d+"  title="Average Delivery Time must be number" required type="text" class="form-control" value="<%=Sat_Delivery %>" name="Sat_Delivery">                        
                  
                     </div>
           	    </div>
                 <div class="row clearfix">
                    <div class="col-md-2 column">
                           <div class="form-check">
                             <label class="form-check-label">Sunday</label>
                          </div>
           	        </div>
                     <div class="col-md-10 column">
                  
                            <input style="width:60px" pattern="\d+"  title="Average Delivery Time must be number" required type="text" class="form-control" value="<%=Sun_Delivery %>" name="Sun_Delivery">                        
          
                     </div>
           	    </div>
              </div>             
   </div>
      <div class="col-md-6 column">

      <%
           dim AverageCollectionTime
               AverageCollectionTime =  Recordset1.Fields.Item("AverageCollectionTime").Value
                if AverageCollectionTime & "" = "" then
                    AverageCollectionTime = 0
                end if
      dim Mon_Collection : Mon_Collection = Recordset1.Fields.Item("Mon_Collection").Value & ""
      dim Tue_Collection : Tue_Collection  = Recordset1.Fields.Item("Tue_Collection").Value & "" 
      dim Wed_Collection : Wed_Collection  = Recordset1.Fields.Item("Wed_Collection").Value & ""
      dim Thu_Collection : Thu_Collection  = Recordset1.Fields.Item("Thu_Collection").Value & ""
      dim Fri_Collection : Fri_Collection  = Recordset1.Fields.Item("Fri_Collection").Value & ""
      dim Sat_Collection : Sat_Collection  = Recordset1.Fields.Item("Sat_Collection").Value & ""
      dim Sun_Collection : Sun_Collection  = Recordset1.Fields.Item("Sun_Collection").Value & ""
      if Mon_Collection = "" then Mon_Collection = AverageCollectionTime
      if Tue_Collection = "" then Tue_Collection = AverageCollectionTime
      if Wed_Collection = "" then Wed_Collection = AverageCollectionTime
      if Thu_Collection = "" then Thu_Collection = AverageCollectionTime
      if Fri_Collection = "" then Fri_Collection = AverageCollectionTime
      if Sat_Collection = "" then Sat_Collection = AverageCollectionTime
      if Sun_Collection = "" then Sun_Collection = AverageCollectionTime

           %>
    <div class="form-group">
    <label for="document name">Average Collection Time</label>
	<p>Enter the average time it takes to prepare a collection ready for pickup.</p>
      <input type="hidden" name="AverageCollectionTime" value="<%=AverageCollectionTime %>" />
    <!--<input type="text" pattern="\d+"  title="Average Collection Time must be number" class="form-control" id="toppingsgroup" name="AverageCollectionTime" value="<%=(Recordset1.Fields.Item("AverageCollectionTime").Value)%>" required>-->
            <div class="row clearfix">
                    <div class="col-md-2 column">
                           <div class="form-check">
                             <label class="form-check-label">Monday</label>
                          </div>
           	        </div>
                     <div class="col-md-10 column">
                        
                            <input style="width:60px" pattern="\d+"  title="Average Collection Time must be number" required type="text" class="form-control" value="<%=Mon_Collection %>"  name="Mon_Collection">
                          
               
                     </div>
           	    </div>
                
                <div class="row clearfix">
                    <div class="col-md-2 column">
                           <div class="form-check">
                             <label class="form-check-label">Tuesday</label>
                          </div>
           	        </div>
                     <div class="col-md-10 column">
                   
                            <input style="width:60px" pattern="\d+"  title="Average Collection Time must be number" required type="text" class="form-control" value="<%=Tue_Collection %>" name="Tue_Collection">                        
               
                     </div>
           	    </div>
                 <div class="row clearfix">
                    <div class="col-md-2 column">
                           <div class="form-check">
                             <label class="form-check-label">Wednesday</label>
                          </div>
           	        </div>
                     <div class="col-md-10 column">
                    
                            <input style="width:60px" pattern="\d+"  title="Average Collection Time must be number" required type="text" class="form-control" value="<%=Wed_Collection %>" name="Wed_Collection">                        
              
                     </div>
           	    </div>
                 <div class="row clearfix">
                    <div class="col-md-2 column">
                           <div class="form-check">
                             <label class="form-check-label">Thursday</label>
                          </div>
           	        </div>
                     <div class="col-md-10 column">
                      
                            <input style="width:60px" pattern="\d+"  title="Average Collection Time must be number" required type="text" class="form-control" value="<%=Thu_Collection %>" name="Thu_Collection">                        
           
                     </div>
           	    </div>
                  <div class="row clearfix">
                    <div class="col-md-2 column">
                           <div class="form-check">
                             <label class="form-check-label">Friday</label>
                          </div>
           	        </div>
                     <div class="col-md-10 column">
                            
                            <input style="width:60px" pattern="\d+"  title="Average Collection Time must be number" required type="text" class="form-control" value="<%=Fri_Collection %>" name="Fri_Collection">                        
                            
                     </div>
           	    </div>
                 <div class="row clearfix">
                    <div class="col-md-2 column">
                           <div class="form-check">
                             <label class="form-check-label">Saturday</label>
                          </div>
           	        </div>
                     <div class="col-md-10 column">
                            
                            <input style="width:60px" pattern="\d+"  title="Average Collection Time must be number" required type="text" class="form-control" value="<%=Sat_Collection %>" name="Sat_Collection">                        
                            
                     </div>
           	    </div>
                 <div class="row clearfix">
                    <div class="col-md-2 column">
                           <div class="form-check">
                             <label class="form-check-label">Sunday</label>
                          </div>
           	        </div>
                     <div class="col-md-10 column">
                            
                            <input style="width:60px" pattern="\d+"  title="Average Collection Time must be number" required type="text" class="form-control" value="<%=Sun_Collection %>" name="Sun_Collection">                        
                            
                     </div>
           	    </div>
  </div>
    
</div>
</div>
   
  
        </div>
  </div>
  
  





<div class="panel panel-default">
  <div class="panel-heading">Delivery Units</div>
  <div class="panel-body">
  
  <div class="form-group">
<label for="document name">Select the unit for calculating delivery distance</label>


<input type="radio" name="mileskm" value="miles" <%if Recordset1.Fields.Item("mileskm").Value="miles" or  Recordset1.Fields.Item("mileskm").Value & ""="" then%>checked<%end if%>> Miles &nbsp;&nbsp; <input type="radio" name="mileskm" value="km" <%if Recordset1.Fields.Item("mileskm").Value="km" then%>checked<%end if%>> KM 

</div>

  </div>
    </div>
<div class="panel panel-default">
  <div class="panel-heading">Delivery distance checking method</div>
  <div class="panel-body">
  
  <div class="form-group">
<label for="document name">Select the method for calculating delivery distance</label>


<input type="radio" name="distancecalmethod" value="crow-fly" <%if Recordset1.Fields.Item("distancecalmethod").Value="crow-fly" or Recordset1.Fields.Item("distancecalmethod").Value & "" = ""  then%>checked<%end if%>> Crow-fly &nbsp;&nbsp; <input type="radio" name="distancecalmethod" value="googleapi" <%if Recordset1.Fields.Item("distancecalmethod").Value="googleapi" then%>checked<%end if%>> Google API 

</div>
    
</div>
</div>

<div class="panel panel-default">
  <div class="panel-heading">Order Only When Open</div>
  <div class="panel-body">
  
  <div class="form-group">
<label for="document name">Disable Ordering outside opening hours</label>


<input type="radio" name="orderonlywhenopen" value="1" <%if Recordset1.Fields.Item("orderonlywhenopen").Value=1 or Recordset1.Fields.Item("orderonlywhenopen").Value& "" = "" then%>checked<%end if%>> Yes &nbsp;&nbsp; <input type="radio" name="orderonlywhenopen" value="0" <%if Recordset1.Fields.Item("orderonlywhenopen").Value=0 then%>checked<%end if%>> No 

</div>

  
    
</div>
</div>


<div class="panel panel-default">
  <div class="panel-heading">Delivery by Individual Postcode</div>
  <div class="panel-body">
  
  <div class="form-group">
<label for="document name">Enable Delivery by Individual Postcode</label>
<p>Turn on/off the delivery option.</p>

<input type="radio" name="individualpostcodeschecking" value="1" <%if Recordset1.Fields.Item("individualpostcodeschecking").Value=1 or Recordset1.Fields.Item("individualpostcodeschecking").Value&"" = ""  then%>checked<%end if%>> Yes &nbsp;&nbsp; <input type="radio" name="individualpostcodeschecking" value="0" <%if Recordset1.Fields.Item("individualpostcodeschecking").Value=0 then%>checked<%end if%>> No 

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


<input type="radio" name="disable_delivery" value="Yes" <%if Recordset1.Fields.Item("disable_delivery").Value="Yes" then%>checked<%end if%>> Yes &nbsp;&nbsp; <input type="radio" name="disable_delivery" value="No" <%if Recordset1.Fields.Item("disable_delivery").Value="No" or Recordset1.Fields.Item("disable_delivery").Value&""="" then%>checked<%end if%>> No 


</div>

  
    <div class="form-group">
<label for="document name">Disable Collection</label>
<p>Turn on/off the collection option.</p>
<input type="radio" name="disable_collection" value="Yes" <%if Recordset1.Fields.Item("disable_collection").Value="Yes" then%>checked<%end if%>> Yes &nbsp;&nbsp; <input type="radio" name="disable_collection" value="No" <%if Recordset1.Fields.Item("disable_collection").Value="No" or Recordset1.Fields.Item("disable_collection").Value & "" = ""  then%>checked<%end if%>> No 


</div>
</div>
</div>

	<div class="panel panel-default">
  <div class="panel-heading">Later Delivery</div>
  <div class="panel-body">
  
  <div class="form-group">
<label for="document name">Disable Later Delivery Option</label>
<p>Turn on/off the deliver later option.</p>


<input type="radio" name="disablelaterdelivery" value="1" <%if Recordset1.Fields.Item("disablelaterdelivery").Value=1 then%>checked<%end if%>> Yes &nbsp;&nbsp; <input type="radio" name="disablelaterdelivery" value="0" <%if Recordset1.Fields.Item("disablelaterdelivery").Value=0 or Recordset1.Fields.Item("disablelaterdelivery").Value & "" = ""  then%>checked<%end if%>> No 


</div>

  <div class="form-group">
<label for="document name">Only allow later order for today only.</label>
<p>Not later delivery option above must be set to "No".</p>


<input type="radio" name="ordertodayonly" value="1" <%if Recordset1.Fields.Item("ordertodayonly").Value=1 then%>checked<%end if%>> Yes &nbsp;&nbsp; <input type="radio" name="ordertodayonly" value="0" <%if Recordset1.Fields.Item("ordertodayonly").Value=0 or Recordset1.Fields.Item("ordertodayonly").Value & ""=""  then%>checked<%end if%>> No 


</div>
    
</div>
</div>
   
  




 
  </div>
   <input type="hidden" name="hidDeliveryZone" id='hidDeliveryZone' value='<%=(Recordset1.Fields.Item("s_DeliveryZonesPath").Value)%>'>
  <input type="hidden" name="MM_update" value="form1">
  <input type="hidden" name="MM_recordId" value="<%= Recordset1.Fields.Item("ID").Value %>">
  <button type="submit" class="btn btn-default">Submit</button>
</form>
		</div>
	</div>

      
</div>



<!-- Modal -->


   
    <script>
    var GoogleMap;
    var drawingManager;
    var deliveryZones = [];
    var selectedZone;
    
     
         $(".fancybox")
    .fancybox({
        type: 'inline',
        //'scrolling': 'no',
        autoSize: false,
        height: "97%",
        width: "96%",
        closeBtn: true,
        fitToView: false,
        margin: [0, 0, 0, 0],
        afterShow: function () {
         
        },
        beforeShow: function () {
            if (GoogleMap == null) {
                initializeGoogleMap();
                InitZones();
            }
             
            
        }
        , beforeClose: function () {
           
        }
    });

    function initializeGoogleMap() {
     var myLatLng = {lat: <%=Recordset1.Fields.Item("latitude").Value %>, lng: <%=Recordset1.Fields.Item("longitude").Value %>};
    var mapOptions = {
        center: new google.maps.LatLng(<%=Recordset1.Fields.Item("latitude").Value %>, <%=Recordset1.Fields.Item("longitude").Value %>),
        zoom: 15
    };
    GoogleMap = new google.maps.Map(document.getElementById('divGoogleMap'),
    mapOptions);

      var marker = new google.maps.Marker({
        position: myLatLng,
        map: GoogleMap,
        title: 'Here!'
      });
      drawingManager = new google.maps.drawing.DrawingManager();
      initZoneDrawingManager();
    }
    function onCompletePolygon(polygon){
      deliveryZones.push(polygon);
      drawingManager.setDrawingMode(null);
      $('#pDrawingZoneMessage').html('');      
        google.maps.event.addListener(polygon, 'click', function (e) {
            if (e.vertex !== undefined) {
                var path = polygon.getPaths().getAt(e.path);
                    path.removeAt(e.vertex);
                    if (path.length < 3) {
                        polygon.setMap(null);
                    } 
            }
            selectZone(polygon);
        });
        
    }
    function InitZones(){
        if( $('#hidDeliveryZone').val() == '') return;
        var AllZones = JSON.parse($('#hidDeliveryZone').val());
        for(var i = 0; i < AllZones.Zones.length; i++){
             
          deliveryZones.push(new google.maps.Polygon({
            path: AllZones.Zones[i],
            strokeWeight : 0.5,				 
			fillOpacity : 0.6,
            fillColor:'#d3f3c8',
            editable: false,
            draggable: false
          })         );
        
        }
        for(var i = 0; i < deliveryZones.length; i++){
            deliveryZones[i].addListener( 'click', function (e) {
                selectZone(this);
             });
            deliveryZones[i].setMap(GoogleMap);
       }
    }
    function selectZone(zone){
        selectedZone = zone;
        zone.set('fillColor', '#ffe800'); 
        for( var i = 0; i < deliveryZones.length; i++){ 
           if ( deliveryZones[i] !=  selectedZone) {
            deliveryZones[i].set('fillColor', '#d3f3c8'); 
           }
        }
        $('#btnDeleteZone').removeAttr('disabled');
    }
    
    function deleteCurrentZone(){
        if(deliveryZones != null){
        for( var i = 0; i < deliveryZones.length; i++){ 
           if ( deliveryZones[i] === selectedZone) {
             deliveryZones.splice(i, 1); 
           }
        }
        $('#btnDeleteZone').attr('disabled','disabled');
        selectedZone.setMap(null);
        }
    }

   function initZoneDrawingManager(){
        //Setting options for the Drawing Tool. In our case, enabling Polygon shape.
       
		drawingManager.setOptions({
			drawingMode : null,
			drawingControl : false,
			drawingControlOptions : {
				position : google.maps.ControlPosition.TOP_CENTER,
				drawingModes : [ google.maps.drawing.OverlayType.POLYGON ]
			},
			polygonOptions : {				 
				strokeWeight : 0.5,				 
				fillOpacity : 0.6,
                fillColor:'#d3f3c8',
                editable: false,
                draggable: false
			}	
		});
		// Loading the drawing Tool in the Map.
	  drawingManager.setMap(GoogleMap);
      google.maps.event.addListener(drawingManager, 'polygoncomplete',onCompletePolygon);
    }
     function selectColor(color) {
             
            // Retrieves the current options from the drawing manager and replaces the
            // stroke or fill color as appropriate.
             
            var polygonOptions = drawingManager.get('polygonOptions');
            polygonOptions.fillColor = color;             
            drawingManager.set('polygonOptions', polygonOptions);
        }

    function drawRec() {
 
         drawingManager.setDrawingMode(google.maps.drawing.OverlayType.POLYGON);
        $('#pDrawingZoneMessage').html('Click on the map to start drawing a zone.');
    }
     function ShowingZoneNumber(){
        if( $('#hidDeliveryZone').val() == '') return;
        var temp = JSON.parse($('#hidDeliveryZone').val());
        $('#DeliveryZoneInfo').html(temp.Zones.length +' zone(s) is defined. View the map to see.');
    }
    function SaveZones() {
        var DeliveryZones = new Object(); 
        DeliveryZones.Zones = Array();
         for( var i = 0; i < deliveryZones.length; i++){ 
           DeliveryZones.Zones.push(deliveryZones[i].getPath().getArray());
        }
         if(DeliveryZones.Zones.length > 0)
            $('#hidDeliveryZone').val(JSON.stringify(DeliveryZones));
        else
            $('#hidDeliveryZone').val('');
        $('#DeliveryZoneInfo').html(deliveryZones.length +' zone(s) is defined. Submit to save.');
        $.fancybox.close();
    }
    ShowingZoneNumber();
    </script>
       <%     Recordset1.close()
        set Recordset1 = nothing   
         Recordset1_cmd.ActiveConnection.Close
    set Recordset1_cmd = nothing
       %>
</body>
</html>
