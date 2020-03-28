<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../Config.asp" -->
<!-- #include file="restaurantsettings.asp" -->
<!-- #include file="timezone.asp" -->

<!-- #include file="restaurantsettings.asp" -->

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
Dim EmailSendCount
    EmailSendCount = 0
 If Request.Form("action") & "" <> "" AND Request.Form("DaysNum") & "" <> "" AND Request.Form("marketingcontent") & "" <> "" Then

  
     Dim objConSMS, objRdsSMS
    If Lcase(Request.Form("action")) = "sms" Then
    
        objCon.Open sConnStringcms
        objRds.Open " Select distinct phone  from [Orders] where  orderdate Between Date() and Date()- " & Request.Form("DaysNum") & "  and IDbusinessdetail = " & session("restaurantid") &" and phone <> '' " , objCon
    
        While NOT objRds.EOF
            Dim ActualPhoneNumber
            ActualPhoneNumber = objRds("phone")
            If Left(ActualPhoneNumber,Len(DefaultSMSCountryCode)) = DefaultSMSCountryCode And Len(ActualPhoneNumber) > 1 Then
                ActualPhoneNumber = Right(ActualPhoneNumber,Len(ActualPhoneNumber) - Len(DefaultSMSCountryCode))
            End If
            If Left(ActualPhoneNumber,1) = "0" And Len(ActualPhoneNumber) > 1 Then
                ActualPhoneNumber = Right(ActualPhoneNumber,Len(ActualPhoneNumber) - 1)
            End If
             SendEmailV2 "Message from " & BUSINESSNAME, Request.Form("marketingcontent"), ActualPhoneNumber & SMSSupplierDomain
            ':: old solution to use queue 
            'Set objConSMS = Server.CreateObject("ADODB.Connection")
            'Set objRdsSMS = Server.CreateObject("ADODB.Recordset") 
           'objConSMS.Open sConnStringcms
           ' objRdsSMS.Open "SELECT * FROM [SMSEmailQueue] WHERE 1 = 0", objConSMS, 1, 3 
           ' objRdsSMS.AddNew 
           '  objRdsSMS("PhoneNumber") = objRds("phone")
           '  objRdsSMS("Content") = Request.Form("marketingcontent")
           ' objRdsSMS("PlanSendDate") = Now()
           ' objRdsSMS("BusinessDetailID") = session("restaurantid")
           ' objRdsSMS("SendType") = "SMS"
    
           ' objRdsSMS.Update 
	        'objRdsSMS.Close
           ' objConSMS.Close
           ' Set objRdsSMS = nothing
           ' Set objConSMS = nothing
	        EmailSendCount = EmailSendCount + 1
	        objRds.MoveNext()
	    Wend
        objRds.close()
        objCon.close()

    ElseIf Lcase(Request.Form("action")) = "email" Then
           
        objCon.Open sConnStringcms
        objRds.Open " Select distinct email  from [Orders] where  orderdate Between Date() and Date()- " & Request.Form("DaysNum") & "  and IDbusinessdetail = " & session("restaurantid") &" and email <> '' " , objCon
        While NOT objRds.EOF

            SendEmailV2 "Message from " & BUSINESSNAME, Request.Form("marketingcontent"),  objRds("email")
            ':: old solution to use queue     
            'Set objConSMS = Server.CreateObject("ADODB.Connection")
            'Set objRdsSMS = Server.CreateObject("ADODB.Recordset") 
           'objConSMS.Open sConnStringcms
           ' objRdsSMS.Open "SELECT * FROM [SMSEmailQueue] WHERE 1 = 0", objConSMS, 1, 3 
           ' objRdsSMS.AddNew 
           '  objRdsSMS("ToEmailAddress") = objRds("email")
           '  objRdsSMS("Content") = Request.Form("marketingcontent")
           ' objRdsSMS("PlanSendDate") = Now()
           ' objRdsSMS("BusinessDetailID") = session("restaurantid")
           ' objRdsSMS("SendType") = "EMAIL"
    
            'objRdsSMS.Update 
	        'objRdsSMS.Close
            'objConSMS.Close
            'Set objRdsSMS = nothing
            'Set objConSMS = nothing
            EmailSendCount = EmailSendCount + 1
	        objRds.MoveNext()
	    Wend
        objRds.close()
        objCon.close()
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
 
 <li><a href="#">Reports</a></li>
 <li>SMS/Email Marketing</li>
  
</ol>
<% If EmailSendCount > 0 Then %>
<span style="color:red;"> <%=EmailSendCount %> SMS/Emails were sent successfully. </span> <br />
<% end if %>
<label for="document name">Announcement</label>
		<p>If you would like a message to appear to customs when they enter your site add it below.</p>
		<form action="smsemailmarketing.asp" method="post">
            <textarea class="form-control" name="marketingcontent" id="marketingcontent" rows="5"></textarea>
		<br>
            Contact everyone who bought in the last <input type="text" name="DaysNum" value="365" id="DaysNum" style="width:30px;" /> days
		<input type="hidden" id="hidAction" name="action" value="announcement">
		<br />
            <br />
		<button type="button" style="background-color: #f0ad4e;border-color: #eea236;" onclick="SubmitForm('SMS',this.form);" class="btn btn-default">Send SMS</button>
            <button type="button" style="background-color: #f0ad4e;border-color: #eea236;" onclick="SubmitForm('Email',this.form);" class="btn btn-default">Send Emails</button>
		</form>
		</div></div>

    <script>
        function SubmitForm(action,frm){
            $("#hidAction").val(action);
            frm.submit();
        }

    </script>

<!-- Modal -->




<!-- /.modal -->




</body>
</html>
