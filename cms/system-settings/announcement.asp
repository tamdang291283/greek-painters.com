<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../../Config.asp" -->
<!-- #include file="../timezone.asp" -->
<!-- #include file="../restaurantsettings.asp" -->
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
    <link href="../css/datepicker.css" rel="stylesheet">


  <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
  <![endif]-->

  <!-- Fav and touch icons -->
   <% If FAVICONURL & "" <> "" Then %> <link rel='shortcut icon' href='<%=FAVICONURL %>' type='image/x-icon'/ > <% end If %>
  
	<script type="text/javascript" src="../js/jquery.min.js"></script>
	<script type="text/javascript" src="../js/bootstrap.min.js"></script>
    <script type="text/javascript" src="../../Scripts/bootstrap-datepicker.js?v=2.0""></script>
	<script type="text/javascript" src="../js/scripts.js"></script>
	
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
	    // ]]>

	</script>
    <script type="text/javascript">
      jQuery(function () {
      
          var nowTemp1 = new Date();
          var now1 = new Date(nowTemp1.getFullYear(), nowTemp1.getMonth(), nowTemp1.getDate(), 0, 0, 0, 0);
          var datePopup = $('#startdate').datepicker({
              onRender: function (date) {
                  return date.valueOf() < now1.valueOf() ? 'disabled' : '';
              }
          }).on('changeDate', function (ev) {
              datePopup.hide();

          }).data('datepicker');

          var datePopup1 = $('#enddate').datepicker({
              onRender: function (date) {
                  return date.valueOf() < now1.valueOf() ? 'disabled' : '';
              }
          }).on('changeDate', function (ev) {
              datePopup1.hide();

          }).data('datepicker');

      });
  </script>
</head>

<body>
<div class="container">
	<!-- #Include file="../inc-header.inc"-->
	



<div class="row clearfix">
		<div class="col-md-12 column">
		
		<ol class="breadcrumb">
 
 <li><a href="#">System Settings</a></li>
 <li>Announcement</li>
  
</ol>
        <label for="document name">Announcement</label>
		<p>Popup message to appear when the order page loads.</p>
		<form action="../exe.asp" method="post">
            <textarea class="form-control" name="announcement" id="announcement" rows="5"><%=announcement%></textarea>
		<br/>
            <label for="document name">In-menu Announcement</label>
            <p>Message to show above the menu.</p>
            <textarea class="form-control" name="in-menu-announcement" id="in-menu-announcemen" rows="5"><%=inmenuannouncement%></textarea>
        <br />
           <!-- <label for="document name">Restaurant will close</label>            
            <p>Start Date</p>
            <input type="text" class="form-control datepicker" autocomplete="off" style="width:200px" id="startdate" name="startdate" value="<%=Close_StartDate %>"  data-date-weekStart="1" data-date-format="dd/mm/yyyy" >
            <br />
             <p>End Date</p>
            <input type="text" class="form-control datepicker" autocomplete="off" style="width:200px" id="enddate" name="enddate" value="<%=Close_EndDate %>"  data-date-weekStart="1" data-date-format="dd/mm/yyyy" >
        <br />-->
        <input type="hidden" name="startdate" value="<%=Close_StartDate %>">
        <input type="hidden" name="enddate" value="<%=Close_EndDate %>">
		<input type="hidden" name="action" value="announcement">
		<input type="hidden" name="id" value="<%=id%>">
		<button type="submit" class="btn btn-default">Update</button>
		</form>
		</div></div>



<!-- Modal -->




<!-- /.modal -->


</div>

</body>
</html>
