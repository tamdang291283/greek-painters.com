<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../Config.asp" -->
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
Dim PrintingURL
If ( UCase(SEND_ORDERS_TO_PRINTER) = "EPSON" AND EPSONJSPRINTERURL <> "" ) OR UCase(SEND_ORDERS_TO_PRINTER) = "STAR" Then
    PrintingURL = "../thanks.asp"
Else
    PrintingURL = "print.asp"
End If
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
   <% If FAVICONURL & "" <> "" Then %> <link rel='shortcut icon' href='<%=FAVICONURL %>' type='image/x-icon'/ > <% end If %>
  
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" src="js/jquery-ui-1.7/minified/effects.core.min.js"></script>

    <script type="text/javascript" src="js/jquery-ui-1.7/minified/effects.pulsate.min.js"></script>
    
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/scripts.js"></script>
	
	<script type="text/javascript">	    // <![CDATA[
	   
	    var intervalID;
	    var intervalPulsatePending;
$(document).ready(function() {
    $.ajaxSetup({ cache: false, async: false }); // This part addresses an IE bug.  without it, IE will only load the first number and will never refresh
    intervalID = setInterval(function () {
$('#results').load('ajax-neworder.asp');
if ($( "#results" ).text()>$( "#completetotal" ).text()) {
$( "#refreshspace" ).hide();
$( "#refresh" ).show();
$("#divPendingCount").css("background-color", "yellow");
$("#divPendingCount").effect("pulsate",{times: 100}); 
var audio = document.getElementsByTagName("audio")[0];
audio.play();

}
else if ($("#results").text() < 0) {
    // Session lost, confirm to reload
    clearInterval(intervalID);
    var r = confirm("You have been logged out. Press OK to login again. Press cancel to stay on the page.");
    if (r == true) {
        location.reload();
    } 
}
}, 10000); // the "3000" here refers to the time to refresh the div.  it is in milliseconds. 

});
// ]]></script>
</head>

<body>
<div class="container">
	 <!-- #Include file="inc-header.inc"-->
	


<div  id="divSummary" class="row clearfix">
		<div class="col-md-12 column">
			<div class="row clearfix">
				<div class="col-md-4 column">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">
								SOLD TODAY
							</h3>
						</div>
						<div class="panel-body">
						
						<% objRds.Close
                        objCon.Close
				  objCon.Open sConnStringcms
                       objRds.Open "SELECT * FROM ORDERS where (paymenttype='Paypal-Paid' or paymenttype='NoChex-Paid' or paymenttype='Worldpay-Paid' or paymenttype='Cash on Delivery') and IdBusinessDetail=" & Session("MM_id") & " and (DateDiff('d',[orderdate],'" & JXIsoDate(DateAdd("h",houroffset,now)) & "')<=1 or (acknowledged=0 and cancelled=0 and outfordelivery=0))  ORDER BY id desc" , objCon
total=0
ordercnt=0
ordercancelled=0
pending=0
orderrejected=0
completetotal=0



                        Do While NOT objRds.Eof
					
						completetotal=completetotal+1
						if objRds("cancelledby")="Customer" then
						ordercancelled=ordercancelled+1
						end if
						
						if objRds("cancelledby")="Restaurant" then
						orderrejected=orderrejected+1
						end if
		
						if objRds("acknowledged")=-1 then
						ordercnt=ordercnt+1
						total=total+replace(objRds("ordertotal"),"�","")
						end if
						
						if objRds("acknowledged")=-1 and objRds("outfordelivery")=0 then
						pending=pending+1
						end if
                            objRds.MoveNext    
                        Loop%>
                    
						
							<div align="center"><h1><%=CURRENCYSYMBOL%><%=FormatNumber(total,2)%></h1></div>
						</div>
						<div class="panel-footer">
							&nbsp;
						</div>
					</div>
				</div>
				<div class="col-md-4 column">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">
								ORDERS TODAY
							</h3>
						</div>
						<div class="panel-body">
							<div align="center"><h1><%=ordercnt%></h1></div>
						</div>
						<div class="panel-footer">
							Cancelled: <%=ordercancelled%>&nbsp;&nbsp;&nbsp;&nbsp;Rejected: <%=orderrejected%>
						</div>
					</div>
				</div>
				<div class="col-md-4 column">
					<div id="divPendingCount" class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">
								PENDING <a href="javascript:;" onclick="var audio = document.getElementsByTagName('audio')[0];audio.play();"><span class="glyphicon glyphicon-volume-up" aria-hidden="true"></span></a>
							</h3>
						</div>
						<div class="panel-body">
					<div align="center"><h1><span id="pending"><%=pending%></span></h1></div>
						</div>
						<div class="panel-footer">
						<div id="completetotal" style="display:none;"><%=completetotal%></div>
							<div id="results" style="display:none;"><%=completetotal%></div><div id="refreshspace">&nbsp;</div><div align="center" id="refresh" style="display:none;"><a href="javascript:ReloadOrderList();" class="btn btn-danger btn-xs">NEW ORDER - CLICK TO REFRESH</a></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

<div id="divOrderList"  class="row clearfix">
		<div class="col-md-12 column">
			<table class="table table-hover table-condensed table-striped">
				<thead>
					<tr>
						<th>
							Order No.
						</th>
						<th>
							Order Details
						</th>
						<th></th>
						
						<th>
							<span class="pull-right">Order Status</span>
						</th>
					</tr>
				</thead>
				<tbody>
				
				<%  objRds.Close
                        objCon.Close
				  objCon.Open sConnStringcms
                        objRds.Open "SELECT * FROM ORDERS where (paymenttype='Paypal-Paid' or paymenttype='NoChex-Paid' or paymenttype='Worldpay-Paid' or paymenttype='Cash on Delivery') and IdBusinessDetail=" & Session("MM_id") & " and (DateDiff('d',[orderdate],'" & JXIsoDate(DateAdd("h",houroffset,now)) & "')<=1 or (acknowledged=0 and cancelled=0 and outfordelivery=0)) ORDER BY id desc" , objCon

                        Do While NOT objRds.Eof
                        %>
                       <tr>
						<td>
							 <%= objRds("id") %>
							 <br>
							 <%if objRds("paymenttype")="Paypal-Paid" or  objRds("PaymentType")="NoChex-Paid"  or  objRds("PaymentType")="Worldpay-Paid" then%>
						<span class="label label-success">PAID/CARD</span>
						<%else%>
						<span class="label label-danger">UNPAID/CASH</span>
						<%end if%>
						</td>
						<td><span class="pull-right"><a href="https://www.google.co.uk/maps?q=<%= objRds("Address") %>,<%= objRds("PostalCode") %> " target="_blank"><%= objRds("PostalCode") %></a></span>
							 <b><%if objRds("DeliveryType")="d" then%><span style="color:#d9534f;">Delivery</span><%else%><span style="color:#5cb85c;">Collection</span><%end if%>: </b><%= objRds("DeliveryTime") %><br>
							<small> Ordered on: <%= objRds("OrderDate") %>&nbsp;&nbsp;&nbsp;Order Value: <%=CURRENCYSYMBOL%><%=FormatNumber(objRds("OrderTotal"),2) %></small>
						</td>
						<td>
						<%if objRds("cancelled")=-1 then%>
						<b>CANCELLED:</b><br>
						 <%= objRds("cancelleddate") %>
						<%end if%>
					
						<%if objRds("acknowledged")=-1 and  objRds("outfordelivery")=0 then%>
						<b>ACKNOWLEDGED:</b><br>
						 <%= objRds("acknowledgeddate") %>
						<%end if%>
						
						<%if objRds("acknowledged")=-1 and  objRds("outfordelivery")=-1 then%>
						<%if objRds("DeliveryType")="c" then%>
						<b>COLLECTED:</b><br>
						 <%= objRds("delivereddate") %>
						<%else%>
						<b>OUT FOR DELIVERY:</b><br>
						 <%= objRds("delivereddate") %>
						 <%end if%>
						<%end if%>
						</td>
						<td>
						
						
						<span class="pull-right">
						
			

					
			<button class="btn btn-primary btn-" data-toggle="modal" data-target="#myModalorder" data-remote="order.asp?id_o=<%=objRds("id")%>&id_r=<%=Session("MM_id")%>">
View Order
</button>

<!-- Modal -->
<div class="modal fade" id="myModalorder" tabindex="-1" role="dialog" aria-labelledby="myModalLabelorder" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      
      <div class="modal-body">
     </div>
      
    </div>
  </div>
</div>	

<script type="text/javascript">
  function openWin(purl)
  {
      var url = purl;
      window.open(url, "s", "width= 640, height= 480, left=0, top=0, resizable=yes, toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=yes, resizable=no, copyhistory=no").blur();
      window.focus();
    
  }
</script>
		
						<%if objRds("cancelled")=-1 or objRds("acknowledged")=-1  then%><%else%><button class="btn btn-primary btn-danger cancel" data-toggle="modal" data-target="#myModal" data-id=" <%= objRds("id") %>" data-email=" <%= objRds("email") %>" >Cancel</button>

<a href="exe.asp?action=acknowledge&id=<%=objRds("id")%>&email=<%=objRds("email")%>&page=loggedin" class="btn btn-success"">Acknowledge</a><%end if%>

<%if objRds("acknowledged")=-1 then%>

<%if objRds("outfordelivery")=0 then%>
<% If UCase(SEND_ORDERS_TO_PRINTER) <> "EPSON" OR InStr(PrintingURL,"thanks.asp") < 1 Then %>
<a href="javascript::"  onclick="openWin('<%=PrintingURL %>?isPrint=Y&id_o=<%=objRds("id")%>&id_r=<%=Session("MM_id")%>')" class="btn btn-default"">Print</a>
<% else %>
<a href="javascript::" data-toggle="modal" data-id="<%= objRds("id") %>" data-target="#printModal"  class="btn btn-default aPrintButton">Print</a>
<% end if %>
<%if objRds("deliverytype")="c" then%>

<a href="exe.asp?action=collected&id=<%=objRds("id")%>&email=<%=objRds("email")%>&page=loggedin" class="btn btn-success"">Collected</a>
<%else%>
<a href="exe.asp?action=outfordelivery&id=<%=objRds("id")%>&email=<%=objRds("email")%>&page=loggedin" class="btn btn-success"">Out for delivery</a>
<%end if%>
<%end if%>
 <%else%>

<%end if%>
						</td>
						
					</tr>
                        <%
                            objRds.MoveNext    
                        Loop
                    
                        objRds.Close
                        objCon.Close
                        %>
				
					
					
					
					
					
				</tbody>
			</table>
			
		</div>
	</div>

      
</div>



<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
<form role="form" action="exe.asp" method="get">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                 <h4 class="modal-title">Cancel Order</h4>

            </div>
            <div class="modal-body"><div class="te">
			
			
  <div class="form-group">
    <label for="exampleInputEmail1">Cancelled by:</label>
  <label class="radio-inline">
  <input type="radio" id="cancelledby" name="cancelledby" value="Restaurant" checked> Restaurant
</label>
<label class="radio-inline">
  <input type="radio" id="cancelledby" name="cancelledby" value="Customer"> Customer
</label>

  </div>
  			
  <div class="form-group">
    <label for="exampleInputEmail1">Cancelled reason:</label>
   <textarea class="form-control" name="cancelledreason" id="cancelledreason" rows="3"></textarea>
  </div>
			</div></div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="submit" class="btn btn-primary">Save changes</button>
				<input type="hidden" name="action" value="cancel">
				<input type="hidden" name="id" id="id" value="">
				<input type="hidden" name="email" id="email" value="">
				<input type="hidden" name="page" id="page" value="loggedin">
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
	</form>
</div>



    
<!-- Modal -->
<div class="modal fade"  id="printModal" tabindex="-1" role="dialog" aria-labelledby="printModalLabel" aria-hidden="true">

    <div style="width:300px;" class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                 <h4 class="modal-title">Print Order</h4>

            </div>
            <div class="modal-body"><div class="te">
			
			
  <div class="form-group">
      <% if EPSONPRINTERIDLIST & "" <> "" Then %>
    <label for="exampleInputEmail1">Select Printer:</label>
      <% Dim arrEpsonPrinterIDList
          arrEpsonPrinterIDList = Split(EPSONPRINTERIDLIST,";")
         
          Dim x, listAdded
          listAdded = ";"
        For x = 0 To Ubound(arrEpsonPrinterIDList)
          If InStr(listAdded, ";"&arrEpsonPrinterIDList(x)  & ";") < 1 AND arrEpsonPrinterIDList(x) & "" <> "" Then
            Response.Write("<br /><label class=""radio-inline""><input type=""checkbox""  name=""EpsonPrinterID"" value=""" & arrEpsonPrinterIDList(x) & """ checked>" & arrEpsonPrinterIDList(x) & "</label>")
          End If
          listAdded = listAdded & arrEpsonPrinterIDList(x)  & ";"
        Next
           %>
 
      <% end if %>
  </div>
  			
  
			</div></div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" onclick="onPrint();" class="btn btn-primary">Print</button>	
                <input type="hidden" name="printorderid" id="printorderid" value="">		
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
	<script>
        function onPrint(){
          var printerIDs = [];
            $.each($("input[name='EpsonPrinterID']:checked"), function(){            
                printerIDs.push($(this).val());
            });
           var printURL =  '<%=PrintingURL %>?isPrint=Y&id_o=' + $("#printorderid").val() + '&id_r=<%=Session("MM_id")%>&idlist='+ printerIDs.join(";");
       openWin(printURL);
      //  openNewBackgroundTab(printURL);
        $('#printModal').modal('toggle');
        }

        $(document).on("click", ".aPrintButton", function () {
     var OId = $(this).data('id');
     $("#printorderid").val( OId );
    
});
	</script>
</div>




<div class="modal fade" id="myModalack" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
<form role="form" action="exe.asp" method="get">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                 <h4 class="modal-title">Acknowledge Order</h4>

            </div>
            <div class="modal-body"><div class="te">
			
			
  <div class="form-group">
    <label for="exampleInputEmail1">Send Email:</label>
  <label class="radio-inline">
  <input type="radio" id="cancelledby" name="sendemail" value="yes" checked> Yes
</label>
<label class="radio-inline">
  <input type="radio" id="cancelledby" name="sendemail" value="no"> No
</label>

  </div>
  			
  
			</div></div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="submit" class="btn btn-primary">Save changes</button>
				<input type="hidden" name="action" value="acknowledge">
				<input type="hidden" name="id" id="ackid" value="">
				<input type="hidden" name="email" id="email" value="">
				<input type="hidden" name="page" id="page" value="loggedin">
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
	</form>
</div>

<div id="tempAjaxResult" style="display:none"></div>
<!-- /.modal -->


<script>

$(document).ready(function(){

   $(".cancel").click(function(){ // Click to only happen on announce links

     $("#id").val($(this).data('id'));
 $("#email").val($(this).data('email'));
   });
   
   $(document.body).on('hidden.bs.modal', function () {
    $('#myModalorder').removeData('bs.modal')
});

//Edit SL: more universal
$(document).on('hidden.bs.modal', function (e) {
    $(e.target).removeData('bs.modal');
});
   
      
});

function ReloadOrderList(){
    $.ajax({
  url: "ajax-neworderdetail.asp"
  
})
  .done(function( data ) {
   $("#tempAjaxResult").html(data);
    $("#divSummary").html( $("#tempdivSummary").html());
    $("#divOrderList").html( $("#tempdivOrderList").html());
    
  });
    }
</script>
<audio>
	<source src="audio/beep.mp3"></source>
	<source src="audio/beep.ogg"></source>
	Your browser isn't invited for super fun audio time.
</audio>
</body>
</html>
