<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../Config.asp" -->

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
If (CStr(Request("MM_insert")) = "form1") Then
  If (Not MM_abortEdit) Then
    ' execute the update
    Dim MM_editCmd
	
	codesgenerated=""
	
	for i=1 to Request.Form("number")
	

Do
	StrRandomize CStr(Now) & CStr(Rnd)
	code= GeneratePassword(8)
	objCon.Open sConnStringcms
	objRds.Open "SELECT * FROM vouchercodes where vouchercode='" & code & "'" , objCon
	if objRds.eof then
		x=1
		else
		x=0
	end if
	objRds.Close
objCon.Close
Loop While x=0

	codesgenerated=codesgenerated & code & ","

    Set MM_editCmd = Server.CreateObject ("ADODB.Command")
    MM_editCmd.ActiveConnection = sConnStringcms
    MM_editCmd.CommandText = "INSERT INTO vouchercodes (vouchercode, vouchercodediscount, vouchertype, startdate, enddate, IdBusinessDetail,minimumamount) VALUES (?,?,?,?,?,?,?)" 
    MM_editCmd.Prepared = true
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 202, 1, 255, code) ' adVarWChar
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 202, 1, 255, MM_IIF(Request.Form("vouchercodediscount"), Request.Form("vouchercodediscount"), null))

	
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param3", 202, 1, 255, Request.Form("vouchertype")) ' adVarWChar
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param4", 202, 1, 255, Request.Form("startdate")) ' adVarWChar
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param5", 202, 1, 255, Request.Form("enddate")) ' adVarWChar
	
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param6", 202, 1, 255, Request.Form("IdBusinessDetail")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param7", 202, 1, 255, Request.Form("minimumamount")) ' adVarWChar
    MM_editCmd.Execute
    MM_editCmd.ActiveConnection.Close
	
	next

    ' append the query string to the redirect URL
    
  End If
End If
codesgenerated=left(codesgenerated,len(codesgenerated)-1)
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
  <link rel="apple-touch-icon-precomposed" sizes="144x144" href="img/apple-touch-icon-144-precomposed.png">
  <link rel="apple-touch-icon-precomposed" sizes="114x114" href="img/apple-touch-icon-114-precomposed.png">
  <link rel="apple-touch-icon-precomposed" sizes="72x72" href="img/apple-touch-icon-72-precomposed.png">
  <link rel="apple-touch-icon-precomposed" href="img/apple-touch-icon-57-precomposed.png">
  <link rel="shortcut icon" href="img/favicon.png">
  
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/bootstrap-datepicker.js"></script>
	<script type="text/javascript" src="js/scripts.js"></script>
	
	<script type="text/javascript">
      jQuery(function () {
          $('.datepicker').datepicker({
		  format: 'dd/mm/yyyy',
		  autoclose: true
		  })
      });
  </script>
	
</head>

<body>
<div class="container">


<div class="row clearfix">
		<div class="col-md-12 column">
		
			<h1>Generate Vouchers</h1>
			<p>Done - codes below</p>
			<textarea cols="60" rows="10" class="form-control" name="codes"><%=codesgenerated%></textarea>
		</div>
	</div>

      
</div>



<!-- Modal -->





</body>
</html>
