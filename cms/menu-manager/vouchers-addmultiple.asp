<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../../Config.asp" -->
<!-- #include file="../restaurantsettings.asp" -->
<!-- #include file="../timezone.asp" -->
<%Server.ScriptTimeout=86400%>
<%
Sub StrRandomize(strSeed)
  Dim i, nSeed

  nSeed = CLng(0)
  For i = 1 To Len(strSeed)
    nSeed = nSeed Xor ((256 * ((i - 1) Mod 4) * AscB(Mid(strSeed, i, 1))))
  Next

  'Randomiser
  Randomize nSeed
End Sub


Function GeneratePassword(nLength)
  Dim i, bMadeConsonant, c, nRnd

'You may adjust the below constants to include local,
'eg. scandinavian characters. This way your passwords
'will not be limited to latin characters.
  Const strDoubleConsonants = "bdfglmnpst"
  Const strConsonants = "bcdfghklmnpqrstv"
  Const strVocal = "aeiou"

  GeneratePassword = ""
  bMadeConsonant = False

  For i = 0 To nLength
    'Get a random number number between 0 and 1
    nRnd = Rnd
    'Simple or double consonant, or a new vocal?
    'Does not start with a double consonant
    '15% or less chance for the next letter being a double consonant
    If GeneratePassword <> "" AND _
        (bMadeConsonant <> True) AND (nRnd < 0.15) Then
      'double consonant
      c = Mid(strDoubleConsonants, Len(strDoubleConsonants) * Rnd + 1, 1)
      c = c & c
      i = i + 1
      bMadeConsonant = True
    Else
      '80% or less chance for the next letter being a consonant,
      'depending on wether the last letter was a consonant or not.
      If (bMadeConsonant <> True) And (nRnd < 0.95) Then
        'Simple consonant
        c = Mid(strConsonants, Len(strConsonants) * Rnd + 1, 1)
        bMadeConsonant = True
        '5% or more chance for the next letter being a vocal. 100% if last
        'letter was a consonant - theoreticaly speacing...
      Else
        'If last one was a consonant, make vocal
        c = Mid(strVocal, Len(strVocal) * Rnd + 1, 1)
        bMadeConsonant = False
      End If
    End If

    'Add letter
    GeneratePassword = GeneratePassword & c
  Next

  'Is the password long enough, or perhaps too long?
  If Len(GeneratePassword > nLength) Then
     GeneratePassword = Left(GeneratePassword, nLength)
  End If
End Function


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
    	objCon.Open sConnStringcms
If (CStr(Request("MM_insert")) = "form1") Then
  If (Not MM_abortEdit) Then
    ' execute the update
    Dim MM_editCmd
	
	for i=1 to Request.Form("number")
	

Do
	StrRandomize CStr(Now) & CStr(Rnd)
	code= GeneratePassword(8)

    Set objRds = Server.CreateObject("ADODB.Recordset") 
	objRds.Open "SELECT * FROM vouchercodes where vouchercode='" & code & "'" , objCon
	if objRds.eof then
		x=1
		else
		x=0
	end if
	objRds.Close
    set objRds = nothing
  
Loop While x=0


    Set MM_editCmd = Server.CreateObject ("ADODB.Command")
    MM_editCmd.ActiveConnection = sConnStringcms
    MM_editCmd.CommandText = "INSERT INTO vouchercodes (vouchercode, vouchercodediscount, vouchertype, startdate, enddate, IdBusinessDetail,minimumamount) VALUES (?,?,?,convert(varchar(10), ?, 105),convert(varchar(10), ?, 105),?,?)" 
    MM_editCmd.Prepared = true
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 202, 1, 255, code) ' adVarWChar
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 202, 1, 255, MM_IIF(Request.Form("vouchercodediscount"), Request.Form("vouchercodediscount"), null))
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param3", 202, 1, 255, Request.Form("vouchertype")) ' adVarWChar
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param4", 202, 1, 255, MM_IIF(Request.Form("startdate"),Request.Form("startdate"),"")) ' adVarWChar
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param5", 202, 1, 255, MM_IIF(Request.Form("enddate"),Request.Form("enddate"),"") ) ' adVarWChar
	
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param6", 202, 1, 255, Session("MM_id")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param7", 202, 1, 255,  MM_IIF(Request.Form("minimumamount"),Request.Form("minimumamount"),0) ) ' adVarWChar
    MM_editCmd.Execute
    MM_editCmd.ActiveConnection.Close
	
	next

    ' append the query string to the redirect URL
    Dim MM_editRedirectUrl
    MM_editRedirectUrl = "vouchers.asp"
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
      objCon.close()
    set objCon = nothing
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
	<script type="text/javascript" src="../js/bootstrap-datepicker.js"></script>
	<script type="text/javascript" src="../js/scripts.js"></script>
	
	<script type="text/javascript">
      jQuery(function () {
          $('.datepicker').datepicker({
		  format: 'dd/mm/yyyy',
		  autoclose: true
		  })
      });
  </script>
	
</head>
<%' objCon.close()
   ' set objCon = nothing %>
<body>
<div class="container">
	 <!-- #Include file="../inc-header.inc"-->
	




<div class="row clearfix">
		<div class="col-md-12 column">
		<ol class="breadcrumb">
 
  <li><a href="vouchers.asp">Voucher Codes</a></li>
 <li>Add Voucher</li>
  
</ol>
			<h1>Add Voucher</h1>
			<form method="post" action="<%=MM_editAction%>" name="form1" role="form">
<div class="form-group">
    <label for="enddate">Number of vouchers to create</label>
	<p>How many vouchers would you like to generate.</p>
    <input type="text" pattern="\d+"  title="Number of vouchers to create must be number" class="form-control" id="number" name="number" value="" required>
  </div>
  
   <div class="form-group">
    <label for="vouchercodediscount">Discount (%)</label>
	<p>Enter the percentage discount offered when using this voucher.</p>
    <input type="text" pattern="\d+"  title="Discount (%) must be number"  class="form-control" id="vouchercodediscount" name="vouchercodediscount" value="" required>
  </div>
  
  

  
  <div class="form-group">
    <label for="vouchertype">Type</label>
		<p>Choose if this voucher has to be used by a specific date or is a one off voucher which when used will become unavailable.</p>
	
   
	<input type="radio" name="vouchertype" value="date" checked onclick="constrainsValidate();"> Date &nbsp;&nbsp; <input type="radio" name="vouchertype" value="once" onclick="constrainsValidate();"> One off 
  </div>
  
  
   <div class="form-group">
    <label for="startdate">Start Date</label>
	<p>Select the date this voucher is valid from.</p>
    <input type="text" class="form-control datepicker" id="startdate" name="startdate" value="" data-date-weekStart="1" data-date-format="dd/mm/yyyy" required>
  </div>
  
  
   <div class="form-group">
    <label for="enddate">End Date</label>
	<p>Select the date this voucher is valid until.</p>
    <input type="text" class="form-control datepicker" id="enddate" name="enddate" value="" data-date-weekStart="1" data-date-format="dd/mm/yyyy" required>
  </div>
   
   <div class="form-group">
    <label for="minimumamount">Minimum Amount</label>
		<p>Enter the minimum amount of orders that can apply the voucher code.</p>
    <input type="text" pattern="\d+"  title="Minimum Amount must be number" class="form-control" id="minimumamount" name="minimumamount" value="" required>
  </div>
  
 
  </div>
  
  <input type="hidden" name="MM_insert" value="form1">

  <button type="submit" class="btn btn-default">Submit</button>
</form>
		</div>
	</div>

      
</div>



<!-- Modal -->


 <script>
        function constrainsValidate()
        {
            if($("[name=vouchertype]:checked").val()=="once")
            {
                $("#startdate").removeAttr("required");
                $("#enddate").removeAttr("required");
                $("#minimumamount").removeAttr("required");
            }else
            {
                $("#startdate").attr("required","");
                $("#enddate").attr("required","");
                $("#minimumamount").attr("required","");
            }
        }
        constrainsValidate();
    </script>


</body>
</html>
