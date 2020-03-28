<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../../Config.asp" -->
<!-- #include file="../restaurantsettings.asp" -->
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
  Set objCon = Server.CreateObject("ADODB.Connection")
  Set objRds = Server.CreateObject("ADODB.Recordset") 
Dim EmailSendCount
    EmailSendCount = 0
Dim FromDate : FromDate = Request.Form("startDate")
     Dim toDate : toDate = Request.Form("endDate")
    if FromDate & "" <> "" then
        sss=split(FromDate,"/")
        enddate_day=sss(0)
        enddate_month=sss(1)
        enddate_year=sss(2)
        FromDate=  enddate_month & "/" & enddate_day & "/" & enddate_year & " 00:00:01"
      
    end if
    if toDate  & ""<> "" then
        
          sss=split(toDate,"/")
        enddate_day=sss(0)
        enddate_month=sss(1)
        enddate_year=sss(2)
        toDate=  enddate_month & "/" & enddate_day & "/" & enddate_year & " 23:59:59"
    end if

dim  sd,ed
if request.Form("startDate")="" then
 sd= DateAdd("d",-365, date())
else
 sd=request.Form("startDate")
end if
if request.Form("endDate")="" then
 ed=date()
else
 ed=request.Form("endDate")
end if


 If Request.Form("action") & "" <> "" AND FromDate & "" <> "" and toDate & "" <> ""  AND Request.Form("marketingcontent") & "" <> "" Then

     
     Dim objConSMS, objRdsSMS
    If Lcase(Request.Form("action")) = "sms" Then
    
        objCon.Open sConnStringcms
        objRds.Open " Select distinct phone  from [Orders]    where orderdate >= '" & FromDate &  "' and orderdate <= '" & toDate&"'   and IDbusinessdetail = " & session("restaurantid") &" and phone <> '' " , objCon
    
        While NOT objRds.EOF
            Dim ActualPhoneNumber
            ActualPhoneNumber = objRds("phone")
            If Left(ActualPhoneNumber,Len(DefaultSMSCountryCode)) = DefaultSMSCountryCode And Len(ActualPhoneNumber) > 1 Then
                ActualPhoneNumber = Right(ActualPhoneNumber,Len(ActualPhoneNumber) - Len(DefaultSMSCountryCode))
            End If
            If Left(ActualPhoneNumber,1) = "0" And Len(ActualPhoneNumber) > 1 Then
                ActualPhoneNumber = Right(ActualPhoneNumber,Len(ActualPhoneNumber) - 1)
            End If
            'Response.Write("ActualPhoneNumber " & ActualPhoneNumber & " SMSSupplierDomain " & SMSSupplierDomain & " orderdate " & objRds("orderdate") & "<br/>")
             SendEmailV2 "Message from " & BUSINESSNAME, Request.Form("marketingcontent"), ActualPhoneNumber & SMSSupplierDomain
           
	        EmailSendCount = EmailSendCount + 1
	        objRds.MoveNext()
	    Wend
            objRds.close()
        set objRds = nothing
            objCon.close()
        set objCon = nothing
    ElseIf Lcase(Request.Form("action")) = "email" Then
           
        objCon.Open sConnStringcms
      
        objRds.Open " Select distinct email  from [Orders]     where orderdate >= '" & FromDate &  "' and orderdate <= '" & toDate&"'   and IDbusinessdetail = " & session("restaurantid") &" and email <> '' " , objCon
        While NOT objRds.EOF
            
            SendEmailV2 "Message from " & BUSINESSNAME, Request.Form("marketingcontent"),  objRds("email")
           
            EmailSendCount = EmailSendCount + 1
	        objRds.MoveNext()
	    Wend
            objRds.close()
        set objRds = nothing
            objCon.close()
        set objCon = nothing
    End If
    
End if
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>SMS Email Marketing</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">

	<!--link rel="stylesheet/less" href="less/bootstrap.less" type="text/css" /-->
	<!--link rel="stylesheet/less" href="less/responsive.less" type="text/css" /-->
	<!--script src="js/less-1.3.3.min.js"></script-->
	<!--append ‘#!watch’ to the browser URL, then refresh the page. -->
	
	<link href="../css/bootstrap.min.css" rel="stylesheet">
	<link href="../css/style.css" rel="stylesheet">
    <link href="../css/bootstrap-datepicker.min.css" rel="stylesheet">
  <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
  <![endif]-->

  <!-- Fav and touch icons -->
   <% If FAVICONURL & "" <> "" Then %> <link rel='shortcut icon' href='<%=FAVICONURL %>' type='image/x-icon'/ > <% end If %>
  
	<script type="text/javascript" src="../js/jquery.min.js"></script>
	<script type="text/javascript" src="../js/bootstrap.min.js"></script>
    <script src="../js/bootstrap-datepicker.min.js"></script>
	<script type="text/javascript" src="../js/scripts.js"></script>
	
    
</head>

<body>
<div class="container">
	<!-- #Include file="../inc-header.inc"-->
<div class="row clearfix">
		<div class="col-md-12 column">
		
		<ol class="breadcrumb">
 
 <li><a href="#">Reports</a></li>
 <li>SMS/Email Marketing</li>
  
</ol>
<% If EmailSendCount > 0 Then %>
<span style="color:red;"> <%=EmailSendCount %> SMS/Emails were sent successfully. </span> <br />
<% end if %>
            <style>
                .search-text {float:left;padding:5px 7px 0px 7px}
                .date-search { float:left;width:200px;}
            </style>
<label for="document name">Send Emails/SMS</label>
		<p>Contact your customers via email or sms.</p>
		<form action="SMSEMailMarketing.asp" method="post" role="form">
            <textarea class="form-control" name="marketingcontent" id="marketingcontent" rows="5" required></textarea>
		<br>
         <div class="col-md-12"> 
             <span class="search-text">Contact everyone who bought from </span>
            <input type="text" class="form-control datepicker date-search" id="startDate" name="startDate" placeholder="Start date" value="<%=sd%>" size="10" required>
             <span class="search-text">to</span><input  type="text" class="form-control datepicker date-search" id="endDate" name="endDate" placeholder="End date" value="<%=ed%>" size="10" required>
                
         </div>
           
           
		<input type="hidden" id="hidAction" name="action" value="announcement">
		<br />
            <br />
		<button type="submit" style="background-color: #f0ad4e;border-color: #eea236;" onclick="SubmitForm('SMS',this.form);" class="btn btn-default">Send SMS</button>
            <button type="submit" style="background-color: #f0ad4e;border-color: #eea236;" onclick="SubmitForm('Email',this.form);" class="btn btn-default" >Send Emails</button>
		</form>
		</div></div>

    <script>
        function SubmitForm(action,frm){
            $("#hidAction").val(action);
           // frm.submit();
        }

    </script>

<!-- Modal -->




<!-- /.modal -->
    <script>

$(document).ready(function(){

$(function () {
  $('[data-toggle="tooltip"]').tooltip()
})

$('.datepicker').datepicker({
format: 'dd/mm/yyyy',
    autoclose: true
});


   
      
});

</script>



</body>
</html>
