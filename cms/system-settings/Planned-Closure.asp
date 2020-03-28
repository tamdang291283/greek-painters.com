<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../../Config.asp" -->
<!-- #include file="../timezone.asp" -->
<!-- #include file="../restaurantsettings.asp" -->
<%Server.ScriptTimeout=86400%>
<%
 
    if request.form("action")="announcement" then
            dim startdatefrm,enddatefrm
                startdatefrm = request.form("startdate") & ""
                enddatefrm = request.form("enddate") & ""
            if startdatefrm & "" = "" and enddatefrm & "" <> "" then
                startdatefrm = enddatefrm
            elseif  startdatefrm & "" <> "" and enddatefrm & "" = "" then
                enddatefrm = startdatefrm
            end if
         
            Set MM_editCmd = Server.CreateObject ("ADODB.Command")
            MM_editCmd.ActiveConnection = sConnStringcms
            MM_editCmd.CommandText = "UPDATE businessdetails SET Close_StartDate = ?,Close_EndDate = ?  WHERE ID = " & request.form("id")
            MM_editCmd.Prepared = true   
            MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 202, 1, 255, startdatefrm)
            MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 202, 1, 255, enddatefrm)
            MM_editCmd.Execute
            MM_editCmd.ActiveConnection.Close
            set MM_editCmd = nothing
            response.redirect "Planned-Closure.asp"
      ' response.redirect "../../cms/dashboards/loggedin.asp"
    end if
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

 ''Response.Write(Now())
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
    <style>
        table table-bordered > td {
            border:1px solid black
        }
    </style>
</head>

<body>
    <% Dim openstatus :  openstatus = "<span class=""label label-warning"" style=""background-color:green;"">Open</span>" 
      Dim isClosed:   isClosed =  false
      Dim sStyle : sStyle = ""

      Dim DayDefault : DayDefault = Day(DateAdd("h",houroffset,Now())) & "/" & Month(DateAdd("h",houroffset,Now())) & "/" & Year(DateAdd("h",houroffset,Now())) 
       if cdate(Close_StartDate & " 00:00:01") <= DateAdd("h",houroffset,Now()) and  DateAdd("h",houroffset,Now()) <=  cdate(Close_EndDate & " 23:59:59") then
            openstatus = "<span class=""label label-danger"" style=""background-color:red;"">Closed</span>"
            isClosed = true   
           ' sStyle = "display:none;" 
            'Close_StartDate = ""
            'Close_EndDate = ""
       ' else
       '     Close_StartDate = "" 
       '     Close_EndDate = ""
       end if
       if DateAdd("h",houroffset,Now()) <=  cdate(Close_EndDate & " 23:59:59") then
            sStyle = "display:none;" 
        end if
    %>
<div class="container">
	<!-- #Include file="../inc-header.inc"-->
    <form  action="Planned-Closure.asp"  method="post" id="frmForm" role="form">
<div class="table-responsive-lg">
  <table class="table table-bordered">
    <tbody>
      <tr>
  
        <td  style="width:10%;font-weight:bold;">Online Status</td>
        <td>You 're currently <%=openstatus %></td>
      </tr>
       
      <tr name="trActionType" style="<%=sStyle%>">     
        <td  style="width:10%;font-weight:bold;">Action Type</td>
        <td>  
              <div class="row">
                    <div class="col-md-3" style="padding-top:3px;">
                                <button type="button" class="btn btn-default btn-block" onclick="CloseToday();">Close for today</button>                
                    </div><!-- /col -->
                   <div class="col-md-1" style="padding-top:3px;">&nbsp;</div><!-- /col -->
                   <div class="col-md-3"  style="padding-top:3px;">
                            <button type="button" class="btn btn-default btn-block" onclick="Edit();">Close for Multi-Day</button>
                   </div><!-- /col -->
  </div><!-- /row -->
                

        </td>
      </tr>
    </tbody>
      </table>
    <table class="table table-bordered"  name="multi-day" style="display:none;">
        <tbody>
      <tr name="multi-day" style="display:none;"> 
        <td  style="width:10%;font-weight:bold;">Start Date</td>
        <td> <input type="text" class="form-control datepicker" autocomplete="off" style="width:200px" id="startdate" name="startdate" value="<%=Close_StartDate %>"  data-date-weekStart="1" data-date-format="dd/mm/yyyy" ></td>
      </tr>
         <tr  name="multi-day"  style="display:none;"> 
        <td  style="width:10%;font-weight:bold;">End Date</td>
        <td> <input type="text" class="form-control datepicker" autocomplete="off" style="width:200px" id="enddate" name="enddate" value="<%=Close_EndDate %>"  data-date-weekStart="1" data-date-format="dd/mm/yyyy" ></td>
      </tr>
          <tr  name="multi-day"  style="display:none;"> 
        <td></td>
        <td>  <button type="button" class="btn btn-primary" onclick="SubmitCloseMutiDay();">Update</button></td>
      </tr>
      </tbody>
      </table>
    <table class="table table-bordered">
        <tbody>
        <%  if  Close_StartDate & "" <> "" and Close_EndDate & "" <> "" and  DateAdd("h",houroffset,Now()) <=  cdate(Close_EndDate & " 23:59:59")then  %>
      <tr> 
        <td  style="width:10%;font-weight:bold;">Scheduled close time</td>
        <td>   
            <% if Close_StartDate  =  Close_EndDate then%>
            Today
            <div class="row">
                  <div class="col-md-2" style="padding-top:3px;">
                <button type="button" class="btn btn-primary btn-block" onclick="ReOpen();" style="background-color:#5cb85c;">ReOpen</button> 
                      </div>
             </div>
            <%else %>
            From <%=Close_StartDate %> to <%=Close_EndDate %>
              <div class="row">
                    <div class="col-md-2" style="padding-top:3px;">
            <button type="button" class="btn btn-primary btn-block" onclick="ReOpen();" style="background-color:#5cb85c;">ReOpen</button> 
                        </div>
                        <div class="col-md-1" style="padding-top:3px;">&nbsp;</div><!-- /col -->
                    <div class="col-md-2" style="padding-top:3px;">
            <button type="button" id="btnEdit" class="btn btn-primary btn-block" onclick="Edit();" style="background-color:red;">Edit</button>
                        </div>
                  </div>
            <% end if %>
           
        </td>
      </tr>
        <%else %>
        <tr> 
            <td style="width:10%;font-weight:bold;">Scheduled close time</td>
            <td>None</td>
        </tr>
        <%end if %>
    </tbody>
  </table>
</div>
        <input type="hidden" name="action" value="announcement">
		<input type="hidden" name="id" value="<%=id%>">
    </form>
</div>
<!-- Modal -->
<script type="text/javascript">
    var DayDefault = '<%=DayDefault%>';
    function CloseToday()
    {
        if (confirm("Are you sure?"))
        {
            $("#startdate").val(DayDefault);
            $("#enddate").val(DayDefault);
            console.log($("#startdate").val() + " " + $("#enddate").val());
    
            $("#frmForm").submit();
        }
        
    }
    function CloseMutiDay()
    {
        $("#startdate").val('');
        $("#enddate").val('');

    }
    function ReOpen()
    {
        $("#startdate").val('');
        $("#enddate").val('');
        $("#startdate").removeAttr("required");
        $("#enddate").removeAttr("required");
        $("#frmForm").submit();
    }
    function CloseMutiDay() {
        $("#startdate").val('');
        $("#enddate").val('');
        $("#startdate").attr("required", "");
        $("#enddate").attr("required", "");
    }
    function SubmitCloseMutiDay() {
        if (confirm("Are you sure?\n\rDo you want to close your restaurant from " + $("#startdate").val() + " to " + $("#enddate").val() + "?"))
            $("#frmForm").submit();
    }
    function Edit()
    {
        $("[name=multi-day]").show();

    }
 
</script>



<!-- /.modal -->


</body>
</html>
