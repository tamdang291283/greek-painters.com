<%session("restaurantid")=""%>
<!-- #include file="../Config.asp" -->

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Choose Restaurant</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">

	<!--link rel="stylesheet/less" href="less/bootstrap.less" type="text/css" /-->
	<!--link rel="stylesheet/less" href="less/responsive.less" type="text/css" /-->
	<!--script src="Scripts/less-1.3.3.min.js"></script-->
	<!--append ‘#!watch’ to the browser URL, then refresh the page. -->
	
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">
	<link href="css/datepicker.css" rel="stylesheet">
	

  <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
    <script src="Scripts/html5shiv.js"></script>
  <![endif]-->

  <!-- Fav and touch icons -->
 <link rel='shortcut icon' href='images-icons/favicon.ico' type='image/x-icon'/ >
  

	
	


</head>

<body>



<div class="container">
        <div class="row">
            <div class="span12" style="color: Red; text-align: center">
                <h1>
                    Order Online</h1>
            </div>
        </div>

        Test worldpay
        Order ID: <input type="text" name="txtOrderID" /> <br />
        Amount: <input type="text" name="txtAmount" /> <br />
        Status: <input type="text" name="txtStatus" /> <br />
       <input type="button" name="txtWorldpay" onclick="testworldpay();" value="World Pay" /> <br /><br />

    
        Test Nochex
        Order ID: <input type="text" name="txtOrderIDnochex" /> <br />
        
       <input type="button" name="txtWorldpay" onclick="testnochex();" value="Nochex" /> <br />
            
    
    
    </div>


		<script type="text/javascript" src="<%=SITE_URL %>Scripts/jquery.min.js"></script>
	<script type="text/javascript" src="<%=SITE_URL %>Scripts/bootstrap.min.js"></script>
	<script type="text/javascript" src="<%=SITE_URL %>Scripts/scripts.js"></script>
	
    <script src="<%=SITE_URL %>Scripts/jquery.validate.min.js" type="text/javascript"></script>

    <script src="<%=SITE_URL %>Scripts/bootstrap-datepicker.js" type="text/javascript"></script>
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=<%= GMAP_API_KEY %>&sensor=false"></script>
    <script type="text/javascript"> 
        function testnochex()
        {
            var txtOrderID;
            txtOrderID = $("[name=txtOrderIDnochex]").val();
            $.ajax({
                url: "<%=SITE_URL%>Payments/nochex/nochex.asp?iItemNumber=" + txtOrderID,
                method: "GET", //First change type to method here
                success: function (response) {
                    console.log(response);
                },
                error: function () {
                    alert("error");
                }

            });
        }
        function testworldpay()
        {
            var txtOrderID, txtAmount, txtStatus;
            txtOrderID = $("[name=txtOrderID]").val();
            txtAmount = $("[name=txtAmount]").val();
            txtStatus = $("[name=txtStatus]").val();
            $.ajax({
                url: "<%=SITE_URL%>Payments/Worldpay/worldpay.asp",
                method: "POST", //First change type to method here

                data: {
                    cartId: txtOrderID,
                    authAmount: txtAmount,
                    transStatus: txtStatus,
                },
                success: function (response) {
                    console.log(response);
                },
                error: function () {
                    alert("error");
                }

            });
        }
    </script>
	
</body>
</html>
