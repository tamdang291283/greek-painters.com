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
			<form method="post" action="done.asp" name="form1" role="form">
			
			<div class="form-group">
			
    <label for="enddate">Choose Restaurant</label>
	<select name="IdBusinessDetail" class="form-control" id="IdBusinessDetail">
	<%Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 
	objCon.Open sConnStringcms
	objRds.Open "SELECT * FROM businessdetails order by name" , objCon
	do while not objRds.eof
	%>
	<option value="<%=objRds("ID")%>" SELECTED><%=objRds("name")%></option>
	<%
	
	objRds.MoveNext()	
 loop


objRds.Close
objCon.Close%>
	
	
</select>

  </div>
			
<div class="form-group">
    <label for="enddate">Number of vouchers to create</label>
    <input type="text" class="form-control" id="number" name="number" value="">
  </div>
  
   <div class="form-group">
    <label for="vouchercodediscount">Discount (%)</label>
    <input type="text" class="form-control" id="vouchercodediscount" name="vouchercodediscount" value="" required>
  </div>
  
  

  
  <div class="form-group">
    <label for="vouchertype">Type</label>
	
	
   
	<input type="radio" name="vouchertype" value="date" checked> Date &nbsp;&nbsp; <input type="radio" name="vouchertype" value="once" > One off 
  </div>
  
  
   <div class="form-group">
    <label for="startdate">Start Date</label>
    <input type="text" class="form-control datepicker" id="startdate" name="startdate" value="" data-date-weekStart="1" data-date-format="dd/mm/yyyy">
  </div>
  
  
   <div class="form-group">
    <label for="enddate">End Date</label>
    <input type="text" class="form-control datepicker" id="enddate" name="enddate" value="" data-date-weekStart="1" data-date-format="dd/mm/yyyy">
  </div>
   
  
  <div class="form-group">
    <label for="minimumamount">Minimum Amount</label>
		<p>Enter the minimum amount of orders that can apply the voucher code.</p>
    <input type="text" class="form-control" id="minimumamount" name="minimumamount" value="">
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
</html>
