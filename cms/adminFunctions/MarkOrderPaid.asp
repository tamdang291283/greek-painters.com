<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../../Config.asp" -->



<%Server.ScriptTimeout=86400%>
<%


Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 
    Dim result : result = ""
    dim OrderID : OrderID = request.QueryString("orderid") & "" 
    if request.Form("orderid") & "" <> "" then
         OrderID =   request.Form("orderid") & "" 
    end if

     if OrderID<> "" then 
        objCon.Open sConnStringcms    
         dim sql,  PaymentType,Payment_status,OrderTotal,PaymentSurcharge               
            
            sql =  " SELECT PaymentType,Payment_status,OrderTotal,PaymentSurcharge "
            sql = sql & " FROM orders  Where paymenttype <> 'Cash on Delivery' and ID =  " & OrderID
     
            objRds.Open  sql , objCon,1 
            if not objRds.EOF then
                PaymentType = objRds("PaymentType")
                Payment_status = objRds("Payment_status")
                OrderTotal = objRds("OrderTotal")
                PaymentSurcharge = objRds("PaymentSurcharge")
                if instr( ucase(PaymentType) ,"-PAID") > 0 or ucase(Payment_status) = "PAID" then
                    result = "Order#" &  OrderID & " is paid already."
                else
                    'objCon.execute("Update orders set OrderTotal=OrderTotal+PaymentSurcharge ,Payment_status='Paid',PaymentType='" &  replace( replace(PaymentType,"-Paid",""),"-paid","")  & "-Paid'  where ID=" & OrderID)
                    objCon.execute("Update orders set OrderTotal=OrderTotal+PaymentSurcharge ,Payment_status='Paid'  where ID=" & OrderID)
                    result = "success"
                end if
            end if
     end if
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Management Area</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">


	
	<link href="../css/bootstrap.min.css" rel="stylesheet">
	<link href="../css/style.css" rel="stylesheet">
<link href="../css/bootstrap-datepicker.min.css" rel="stylesheet">
  <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
  <![endif]-->

  <!-- Fav and touch icons -->
   <% If FAVICONURL & "" <> "" Then %> <link rel='shortcut icon' href='<%=FAVICONURL %>' type='image/x-icon'/ > <% end If %>
  
	<script type="text/javascript" src="<%=SITE_URL %>cms/js/jquery.min.js"></script>
	<script type="text/javascript" src="<%=SITE_URL %>cms/js/bootstrap.min.js"></script>
	<script src="<%=SITE_URL %>cms/js/bootstrap-datepicker.min.js"></script>
	<script type="text/javascript" src="<%=SITE_URL %>cms/js/scripts.js"></script>

	<style>
     @media (max-width: 1250px) {
            body{font-size:14px;}
            .lead {
               font-size:21px;
            }
            
        }

    @media (max-width: 992px) {
         body{font-size:unset;}
        .lead {
           font-size:13px;
        }
    }

	</style>
	
</head>

<body>
<div class="container">
	 

<form class="form-inline mt20" id="searchform" method="post" action="MarkOrderPaid.asp">
     <h1>Mark Order Paid</h1><br />
<div class="row clearfix">
<div class="col-md-2">
    
    <input type="text" class="form-control datepicker" id="orderid" onkeyup="CheckOrder(this);" name="orderid" value="<%=OrderID %>" placeholder="Order ID"  size="20">

</div>


<div class="col-md-2">    <button type="submit" class="btn btn-default btn-block">Paid</button>

   

</div>
    <div class="col-md-2" id="pnvieworder"> 
        <button class="btn btn-default btn-block" id="vieworder" style="display:none;" data-toggle="modal" data-target="#myModalorder" data-remote="">View Order</button>
     </div>
    <div class="col-md-4"> </div>
	</div>
        </form>

		
</div>
    <!-- Modal -->
<div class="modal fade" id="myModalorder" tabindex="-1" role="dialog" aria-labelledby="myModalLabelorder" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      
      <div class="modal-body">
     </div>
      
    </div>
  </div>
</div>	

    <% if OrderID & "" <> "" then %>
            <% if result = "" then %>
                <script>alert("Order#<%=OrderID %> doesn't exist." )</script>
            <%elseif result="success" then  %>
                <script>alert("Order#<%=OrderID %> is paid successfully." )</script>
            <%else  %>
                 <script>alert("<%=result %>")</script>
            <%end if %>
    <%end if %>

    <script type="text/javascript">

        var originalModal = $('#myModalorder').clone();
        var originvieworder  = $('#vieworder').clone();
        var request = null;
        var SITE_URL = "<%=SITE_URL%>";
        if (window.location.href.indexOf("https") > -1)
            SITE_URL = SITE_URL.replace("http://", "https://");
        else
            SITE_URL = SITE_URL.replace("https://", "http://");
        function CheckOrder(obj)
        {

            $('#vieworder').remove();
            $('#myModalorder').remove();

            var myClone = originalModal.clone();
            $('body').append(myClone);

            if (request !== null) {
                request.abort();
            }
            request =  $.ajax({
                url: SITE_URL + "cms/dashboards/lookuporder.asp?oid=" + $(obj).val() + "&r" + Math.random()
            })
           .done(function( data ) {
              
               if(data=="yes"){
                   var myoriginvieworder=originvieworder.clone();
                   $("#pnvieworder").append(myoriginvieworder);
                   $("#vieworder").attr("data-remote",SITE_URL + "cms/dashboards/order.asp?id_o=" + $(obj).val().trim() + "&m=" + Math.random());
                   $('#vieworder').show();
               }
               

           });


           

        }
        $(document).on("keydown", "form", function(event) { 
            return event.key != "Enter";
        });
    </script>
</body>
</html>
