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
    MM_editCmd.CommandText = "UPDATE businessdetails SET [Name] = ?,[Address] = ?,[Telephone] = ?,[PostalCode] = ?,[FoodType] = ?,[ImgUrl] = ?,[backtohometext]=?, [closedtext]=?, [email]=? , [menupagetext]=?,[longitude]=?,[latitude]=?,[faviconurl]=?,[addtohomescreenurl]=?,[EnableBooking]=?,URL_Facebook=?,URL_Twitter=?,URL_Google=?,URL_Intagram=?,URL_YouTube=?,URL_Tripadvisor=?,URL_Special_Offer=?,URL_Linkin=?,s_BannerURL=?,s_IconApple=?,s_UrlApple=?,s_IconGoogle=?,s_UrlGoogle=?,enablereorder=?  WHERE ID = ?" 
MM_editCmd.Prepared = true




MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 202, 1, 255, Request.Form("Name"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 202, 1, 255, Request.Form("Address"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param3", 202, 1, 255, Request.Form("Telephone"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param4", 202, 1, 255, Request.Form("PostalCode"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param5", 202, 1, 255, Request.Form("FoodType"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param6", 202, 1, 255, Request.Form("ImgUrl"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param7", 202, 1, 10000, Request.Form("backtohometext"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param8", 202, 1, 10000, Request.Form("closedtext"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param9", 202, 1, 255, Request.Form("email"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param10", 202, 1, 10000, Request.Form("menupagetext"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param11", 202, 1, 255, Request.Form("longitude"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param12", 202, 1, 255, Request.Form("latitude"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param13", 202, 1, 255, Request.Form("FavIconUrl"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param14", 202, 1, 255, Request.Form("AddToHomeScreenURL"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param15", 202, 1, 255, Request.Form("enablebooking"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param16", 202, 1, 255, Request.Form("URL_Facebook"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param17", 202, 1, 255, Request.Form("URL_Twitter"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param18", 202, 1, 255, Request.Form("URL_Google"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param19", 202, 1, 255, Request.Form("URL_Intagram"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param20", 202, 1, 255, Request.Form("URL_YouTube"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param21", 202, 1, 255, Request.Form("URL_Tripadvisor"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param22", 202, 1, 255, Request.Form("URL_Special_Offer"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param23", 202, 1, 255, Request.Form("URL_Linkin"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param24", 202, 1, 255, Request.Form("s_BannerURL"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param25", 202, 1, 255, Request.Form("s_IconApple"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param26", 202, 1, 255, Request.Form("s_UrlApple"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param27", 202, 1, 255, Request.Form("s_IconGoogle"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param28", 202, 1, 255, Request.Form("s_UrlGoogle"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param29", 202, 1, 255, Request.Form("enablereorder"))
    
    

    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param16", 5, 1, -1, MM_IIF(Request.Form("MM_recordId"), Request.Form("MM_recordId"), null)) ' adDouble
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
  '  MM_editCmd.close()
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
	<!--append ‘#!watch’ to the browser URL, then refresh the page. -->
	
	<link href="../css/bootstrap.min.css" rel="stylesheet">
	<link href="../css/style.css?v=1" rel="stylesheet">

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
 
 <li><a href="#">System Settings</a></li>
 <li>Restaurant Info</li>
  
</ol>
			
			<form method="post" action="<%=MM_editAction%>" name="form1" role="form">
  

			  <div class="panel panel-default">
  <div class="panel-heading">Contact Details</div>
  <div class="panel-body">
			
<div class="form-group">
<label for="document name">NAME</label>
<input type="text" class="form-control" id="Name" name="Name" value="<%=(Recordset1.Fields.Item("Name").Value)%>" required>
</div>

<div class="form-group">
<label for="document name">EMAIL</label>
<p>This is the email address which will be visible to customer on your order page.</p>
<input type="text"  pattern="\S+@\S+\.\S+"  title="Email must contain @." class="form-control" id="email" name="email" value="<%=(Recordset1.Fields.Item("email").Value)%>" required>
</div>

<div class="form-group">
<label for="document name">TELEPHONE</label>
<input type="text" class="form-control" id="Telephone" name="Telephone" value="<%=(Recordset1.Fields.Item("Telephone").Value)%>" required>
</div>

  
<div class="form-group">
<label for="document name">ADDRESS</label>
<input type="text" class="form-control" id="Address" name="Address" value="<%=(Recordset1.Fields.Item("Address").Value)%>" required>
</div>



<div class="form-group">
<label for="document name">POSTCODE</label>
<input type="text" class="form-control" id="PostalCode" name="PostalCode" value="<%=(Recordset1.Fields.Item("PostalCode").Value)%>" required>
</div>

<div class="form-group">
<label for="document name">LATITUDE</label>
    <input type="text" class="form-control" id="latitude" name="latitude" value="<%=(Recordset1.Fields.Item("latitude").Value)%>" required>
</div>

<div class="form-group">
<label for="document name">LONGITUDE</label>
    <input type="text" class="form-control" id="longitude" name="longitude" value="<%=(Recordset1.Fields.Item("longitude").Value)%>" required>
</div>

</div></div>

  <div class="panel panel-default">
  <div class="panel-heading">Restaurant Type</div>
  <div class="panel-body">

<div class="form-group">
<label for="document name">FOOD TYPE</label>
<input type="text" class="form-control" id="FoodType" name="FoodType" value="<%=(Recordset1.Fields.Item("FoodType").Value)%>" required>
</div>

</div></div>

  <div class="panel panel-default">
  <div class="panel-heading">Branding</div>
  <div class="panel-body">
  
<div class="form-group">
<label for="document name">LOGO URL</label>
<p>Enter the URL where your logo is stored, file should be square 120pixels x 120pixels.</p>
<input type="text" class="form-control" id="ImgUrl" name="ImgUrl" value="<%=(Recordset1.Fields.Item("ImgUrl").Value)%>" required>
</div>

<div class="form-group">
<label for="document name">Fav Icon URL</label>
<p>Enter the URL where your Fav Icon is stored, file should be square 16pixels x 16pixels.</p>
<input type="text" class="form-control" id="FavIconUrl" name="FavIconUrl" value="<%=(Recordset1.Fields.Item("FavIconUrl").Value)%>" >
</div>
  
<div class="form-group">
<label for="document name">Add to home screen icon URL</label>
<p>Enter the URL where your Add to home screen icon is stored, file should be square 152pixels x 152pixels.</p>
<input type="text" class="form-control" id="AddToHomeScreenURL" name="AddToHomeScreenURL" value="<%=(Recordset1.Fields.Item("AddToHomeScreenURL").Value)%>" >
</div>

<div class="form-group">
<label for="document name">HTML FOR THANKS PAGE</label>
<p>Enter any custom HTML for the order confirmation page.</p>
<textarea class="form-control" name="backtohometext" id="backtohometext" rows="5"><%=(Recordset1.Fields.Item("backtohometext").Value)%></textarea>

</div>

<div class="form-group">
<label for="document name">HTML FOR CLOSED PAGE</label>
<p>Enter any custom HTML for the restaurant closed page.</p>
<textarea class="form-control" name="closedtext" id="closedtext" rows="5"><%=(Recordset1.Fields.Item("closedtext").Value)%></textarea>

</div>
 <div class="form-group">
    <label for="document name">Banner Image URL</label>
    <input type="text" class="form-control" id="s_BannerURL" name="s_BannerURL" value="<%=(Recordset1.Fields.Item("s_BannerURL").Value)%>" >
</div>

<div class="form-group">
    <label for="document name">SMART BANNER (for mobile app)</label>   
</div>
   <div class="form-group" style="margin-left:20px;">
    <p>Icon Apple.</p>
    <input type="text" class="form-control" id="s_IconApple" name="s_IconApple" value="<%=(Recordset1.Fields.Item("s_IconApple").Value)%>" >
</div>
<div class="form-group" style="margin-left:20px;">    
    <p>URL Apple.</p>
    <input type="text" class="form-control" id="s_UrlApple" name="s_UrlApple" value="<%=(Recordset1.Fields.Item("s_UrlApple").Value)%>" >
</div>

 <div class="form-group" style="margin-left:20px;">
      <p>Icon Google.</p>
    <input type="text" class="form-control" id="s_IconGoogle" name="s_IconGoogle" value="<%=(Recordset1.Fields.Item("s_IconGoogle").Value)%>" >
</div>
<div class="form-group" style="margin-left:20px;">
   <p>URL Google.</p>
    <input type="text" class="form-control" id="s_UrlGoogle" name="s_UrlGoogle" value="<%=(Recordset1.Fields.Item("s_UrlGoogle").Value)%>" >
</div>
  </div></div>

<div class="panel panel-default">
  <div class="panel-heading">Menu Page</div>
  <div class="panel-body"> 

<div class="form-group">
<label for="document name">TEXT FOR RIGHT HAND SIDE OF MENU PAGE</label>
<p>This text will appear below the payment symboms to the right of the menu page.</p>
<textarea class="form-control" name="menupagetext" id="menupagetext" rows="5"><%=(Recordset1.Fields.Item("menupagetext").Value)%></textarea>

</div>
<% 
    dim EnableBooking : EnableBooking  = Recordset1.Fields.Item("EnableBooking").Value & ""
        if EnableBooking = "" then
             EnableBooking= "No"   
        end if

     %>
 <div class="form-group">
<label for="document name">Enable Booking</label>
<p>Enable Table Booking.</p> 
<input type="radio" name="enablebooking" value="Yes" <%if EnableBooking ="Yes" then%>checked<%end if%>> Yes &nbsp;&nbsp; <input type="radio" name="enablebooking" value="No" <%if EnableBooking="No" then%>checked<%end if%>> No 


</div>

<% 
    dim enablereorder : enablereorder  = Recordset1.Fields.Item("enablereorder").Value & ""
        if enablereorder = "" then
             enablereorder= "No"   
        end if

     %>
     <div class="form-group">
            <label for="document name">Enable Re-Order</label>
            <p>Enable Re-Order.</p> 
            <input type="radio" name="enablereorder" value="Yes" <%if enablereorder ="Yes" then%>checked<%end if%>> Yes &nbsp;&nbsp; <input type="radio" name="enablereorder" value="No" <%if enablereorder="No" then%>checked<%end if%>> No 
    </div>

</div>

</div>
<div  class="panel panel-default">
      <div class="panel-heading">Social Media Links</div>
             <div class="panel-body">
              <div class="form-group">
                <label for="document name">Facebook URL</label>
                <input type="text" class="form-control" id="URL_Facebook" name="URL_Facebook" value="<%=(Recordset1.Fields.Item("URL_Facebook").Value)%>" >
            </div>
               <div class="form-group">
                <label for="document name">Twitter URL</label>
                <input type="text" class="form-control" id="URL_Twitter" name="URL_Twitter" value="<%=(Recordset1.Fields.Item("URL_Twitter").Value)%>" >
            </div>
              <div class="form-group">
                <label for="document name">Google URL</label>
                <input type="text" class="form-control" id="URL_Google" name="URL_Google" value="<%=(Recordset1.Fields.Item("URL_Google").Value)%>" >
            </div>
               <div class="form-group">
                <label for="document name">Instagram URL</label>
                <input type="text" class="form-control" id="URL_Intagram" name="URL_Intagram" value="<%=(Recordset1.Fields.Item("URL_Intagram").Value)%>" >
            </div>
               <div class="form-group">
                <label for="document name">Youtube URL</label>
                <input type="text" class="form-control" id="URL_YouTube" name="URL_YouTube" value="<%=(Recordset1.Fields.Item("URL_YouTube").Value)%>" >
            </div>
              <div class="form-group">
                <label for="document name">Tripadvisor URL</label>
                <input type="text" class="form-control" id="URL_Tripadvisor" name="URL_Tripadvisor" value="<%=(Recordset1.Fields.Item("URL_Tripadvisor").Value)%>" >
            </div>
               <div class="form-group">
                <label for="document name">Linked In URL</label>
                <input type="text" class="form-control" id="URL_Linkin" name="URL_Linkin" value="<%=(Recordset1.Fields.Item("URL_Linkin").Value)%>" >
            </div>
          </div>
</div>

 <div class="panel panel-default">
      <div class="panel-heading">Special Offers Links</div>
        <div class="panel-body">
             <div class="form-group">
                <label for="document name">Special Offer URL</label>
                <input type="text" class="form-control" id="URL_Special_Offer" name="URL_Special_Offer" value="<%=(Recordset1.Fields.Item("URL_Special_Offer").Value)%>" >
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
        'Recordset1_cmd.close()
    Recordset1_cmd.ActiveConnection.Close
    set Recordset1_cmd = nothing
     %>



</body>
</html>
