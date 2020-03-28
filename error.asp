


<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Error</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">

	<!--link rel="stylesheet/less" href="less/bootstrap.less" type="text/css" /-->
	<!--link rel="stylesheet/less" href="less/responsive.less" type="text/css" /-->
	<!--script src="Scripts/less-1.3.3.min.js"></script-->
	<!--append �#!watch� to the browser URL, then refresh the page. -->
	
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">
	<link href="css/datepicker.css" rel="stylesheet">

  <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
    <script src="Scripts/html5shiv.js"></script>
  <![endif]-->
     
  <!-- Fav and touch icons -->
 <link rel='shortcut icon' href='images-icons/favicon.ico' type='image/x-icon'/ >
  
	<script type="text/javascript" src="Scripts/jquery.min.js"></script>
	<script type="text/javascript" src="Scripts/bootstrap.min.js"></script>
	<script type="text/javascript" src="Scripts/scripts.js"></script>
	
    <script src="Scripts/jquery.validate.min.js" type="text/javascript"></script>

    <script src="Scripts/bootstrap-datepicker.js" type="text/javascript"></script>
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=&sensor=false"></script>


</head>

<body>



<div class="container">
        <div class="row">
            <div class="span12" style="color: Red; text-align: center">
                <h1>
                    Sorry, Your session has expired. Please click OK to restart.
</h1>
<p><a href="index.asp" style="background-color:#E6E6E6; border: 2px solid grey;padding: 10px 20px; text-align: center;text-decoration: none; display: inline-block;">OK</a>
            </div>
        </div>

 </div>

</body>
</html>

<%
Session.Abandon

%>