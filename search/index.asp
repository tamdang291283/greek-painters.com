
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Search</title>
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
	<script type="text/javascript" src="js/html5-dataset.js"></script>
	<script type="text/javascript" src="js/scripts.js"></script>
	

</head>

<body>
<%if request.querystring("postcode")<>"" then
session("postcodetopass")=request.querystring("postcode")
response.redirect "searchresults.asp?address=" & request.querystring("postcode") & "&searchterm=&searchtype=postcode"
else
session("postcodetopass")=""
end if%>

detecting location...
<p id="demo"></p>
<script>
var x = document.getElementById("demo");


    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(showPosition, showError);
    } else { 
        x.innerHTML = "Geolocation is not supported by this browser.";
    }


function showPosition(position) {

	window.location = "index2.asp?long=" + position.coords.longitude + "&lat=" + position.coords.latitude;
}

function showError(error) {
    switch(error.code) {
        case error.PERMISSION_DENIED:
        
			window.location = "index2.asp?long=0&lat=0&geo=denied";
            break;
        case error.POSITION_UNAVAILABLE:
            window.location = "index2.asp?long=0&lat=0&geo=denied";
            break;
        case error.TIMEOUT:
           window.location = "index2.asp?long=0&lat=0&geo=denied";
            break;
        case error.UNKNOWN_ERROR:
           window.location = "index2.asp?long=0&lat=0&geo=denied";
            break;
    }
}
</script>


	




</body>
</html>
