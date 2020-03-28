<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../../Config.asp" -->
<!-- #include file="../timezone.asp" -->
<!-- #include file="../restaurantsettings.asp" -->

<%Server.ScriptTimeout=86400%>
<%
    dim datetoday : datetoday = cdate( DateAdd("h",houroffset,now))  
        datetoday = formatdatecustom(datetoday,"mm/dd/yyyy")
        'Response.Write("datetoday " & formatdatecustom(datetoday,"mm/dd/yyyy") )
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
Dim PrintingURL
If  ( UCase(SEND_ORDERS_TO_PRINTER) = "EPSON" AND EPSONJSPRINTERURL <> ""  ) OR UCase(SEND_ORDERS_TO_PRINTER) = "STAR" Then
    PrintingURL = "../../thanks.asp"
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
	
	<link href="../css/bootstrap.min.css" rel="stylesheet">
	<link href="../css/style.css?v=1" rel="stylesheet">

  <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
  <![endif]-->

  <!-- Fav and touch icons -->
   <% If FAVICONURL & "" <> "" Then %> <link rel='shortcut icon' href='<%=FAVICONURL %>' type='image/x-icon'/ > <% end If %>
  
	<script type="text/javascript" src="../js/jquery.min.js"></script>    
    <script type="text/javascript" src="../js/jquery-ui-1.7/minified/effects.core.min.js"></script>
    <script type="text/javascript" src="../js/jquery-ui-1.7/minified/effects.pulsate.min.js"></script>
	<script type="text/javascript" src="../js/bootstrap.min.js"></script>
	<script type="text/javascript" src="../js/scripts.js"></script>
	
	<script type="text/javascript">	    // <![CDATA[
	    var intervalID;
$(document).ready(function() {
$.ajaxSetup({ cache: false }); // This part addresses an IE bug.  without it, IE will only load the first number and will never refresh
intervalID = setInterval(function () {

$('#results').load('ajax-totalorder.asp?key=' +Math.random());
        
if ($.trim($("#results").text()) != $.trim($("#completetotal").text()) && parseInt($.trim($("#results").text())) > 0) {

    $( "#refreshspace" ).hide();
    $( "#refresh" ).show();

    var audio = document.getElementsByTagName("audio")[0];
    audio.play();

    $("#divPendingCount").css("background-color", "yellow");
    $("#divPendingCount").effect("pulsate", { times: 100 });

}
else if ($("#results").text()!="" && parseInt( $("#results").text()) < 0) {
    // Session lost, confirm to reload
    clearInterval(intervalID);
    var r = confirm("You have been logged out. Press OK to login again. Press cancel to stay on the page.");
    if (r == true) {
        location.reload();
    }
} else if ($.trim($("#results").text()) != $.trim($("#completetotal").text()))
{
    clearInterval(intervalID);
    location.reload();
}
}, 10000); // the "3000" here refers to the time to refresh the div.  it is in milliseconds. 

});
// ]]></script>
</head>

<body>
<div class="container">
	 <!-- #Include file="../inc-header.inc"-->
	


<div id="divSummary"  class="row clearfix">
		<div class="col-md-12 column">
			<div class="row clearfix">
				<div class="col-md-4 column">
					<div id="divPendingCount" class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">
								TOTAL ORDERS <a href="javascript:;" onclick="var audio = document.getElementsByTagName('audio')[0];audio.play();"><span class="glyphicon glyphicon-volume-up" aria-hidden="true"></span></a>
							</h3>
						</div>
						<div class="panel-body">
						
						<% '
				  objCon.Open sConnStringcms
                      
                            Dim SQL 
                                SQL = "SELECT * FROM view_paid_orders where IdBusinessDetail=" & Session("MM_id")
                                
                                SQL = SQL & " and cast(orderdate as date) = '" &datetoday&"' "
                                SQL = SQL & " ORDER BY id desc"
                                       ' Response.Write(SQL & "<br/>")
                                       ' Response.End
                       objRds.Open SQL, objCon
total=0
totalinccancelled=0
ordercnt=0
ordercancelled=0
pending=0
orderrejected=0
completetotal=0



                        Do While NOT objRds.Eof
					totalinccancelled=totalinccancelled+replace(objRds("ordertotal"),"�","")
						completetotal=completetotal+1
						if objRds("cancelled")=1 then
						ordercancelled=ordercancelled+1
						end if
						
						if objRds("cancelledby")="Restaurant" then
						orderrejected=orderrejected+1
						end if
		
						if objRds("cancelled")<>1 then
						ordercnt=ordercnt+1
						total=total+replace(objRds("ordertotal"),"�","")
						end if
						
						
						
						if objRds("acknowledged")=1 and objRds("outfordelivery")=0 then
						pending=pending+1
						end if
                            objRds.MoveNext    
                        Loop%>
                    
						
							<div align="center"><h1><%=CURRENCYSYMBOL%><%=FormatNumber(totalinccancelled,2)%></h1></div>
						</div>
						<div class="panel-footer">
						<div id="completetotal" style="display:none;"><%=completetotal%></div>
							<div id="results" style="display:none;"><%=completetotal%></div><div id="refreshspace"><div align="center">Total:<%=completetotal%> (including cancelled orders)</div> </div><div align="center" onclick="ReloadOrderList();" id="refresh" style="display:none;"><a href="#" class="btn btn-danger btn-xs">NEW ORDER - CLICK TO REFRESH</a></div>
						</div>
					</div>
				</div>
				<div class="col-md-4 column">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">
								ACCEPTED ORDERS
							</h3>
						</div>
						<div class="panel-body">
							<div align="center"><h1><%=CURRENCYSYMBOL%><%=FormatNumber(total,2)%></h1></div>
						</div>
						<div class="panel-footer">
							<div align="center">Accepted:<%=completetotal-ordercancelled%> (excluding cancelled orders)</div>
						</div>
					</div>
				</div>
				<div class="col-md-4 column">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">
								CANCELLED/REJECTED
							</h3>
						</div>
						<div class="panel-body">
					<div align="center"><h1><span id="pending"><%=CURRENCYSYMBOL%><%=FormatNumber(totalinccancelled-total,2)%></span></h1></div>
						</div>
						<div class="panel-footer">
							Cancelled: <%=ordercancelled%> (by the restaurant: <%=orderrejected%>)
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

<div id="divOrderList" class="row clearfix">
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
				
				<%      objRds.Close
                    set objRds = nothing
                 Set objRds = Server.CreateObject("ADODB.Recordset") 
                        
                     
                        
                    objRds.Open SQL,objCon
                         ' Get Avarage time for delivery and collection 
                            dim vaveragedel : vaveragedel = 0 
                            dim vaveragecol : vaveragecol = 0
                            if Session("MM_id") & "" <> "" then
                                dim rs_BusinessDetails : set rs_BusinessDetails = Server.CreateObject("ADODB.Recordset")
                                rs_BusinessDetails.Open "SELECT AverageDeliveryTime,AverageCollectionTime FROM BusinessDetails  WHERE Id = " & Session("MM_id") , objCon    
                                if not rs_BusinessDetails.eof then  
                                    vaveragedel = rs_BusinessDetails("AverageDeliveryTime")
	                                vaveragecol = rs_BusinessDetails("AverageCollectionTime")
                                end if
                                rs_BusinessDetails.close()
                           
                            end if
                        ' End
                        Do While NOT objRds.Eof
                             dim mintoadd : mintoadd = 0 
                             dim deliveryTime : deliveryTime = objRds("DeliveryTime") 
                             if  objRds("deliverydelay") & "" <> "" then
                                vaveragedel = cint(objRds("deliverydelay"))
                            end if
                            if  objRds("collectiondelay") & "" <> "" then
                                    vaveragecol = cint(objRds("collectiondelay"))
                            end if
                            if objRds("asaporder") = "n" then
                                if objRds("DeliveryType") = "d" then
                                    mintoadd=vaveragedel ' + 5 ' Add + 5 to match with front end
                                else
                                    mintoadd=vaveragecol ' + 5 ' Add + 5 to match with front end
                                end if
                                deliveryTime = DateAdd("n",mintoadd,objRds("orderdate"))
                            end if
                            deliveryTime = formatDateTimeC(deliveryTime)
                        %>
                       <tr>
					
						<td>
							 <%= objRds("id") %>
							 <br>
							 <%if lcase( objRds("paymenttype") ) ="stripe-paid" or  objRds("paymenttype")="Paypal-Paid" or  objRds("PaymentType")="NoChex-Paid"  or  objRds("PaymentType")="Worldpay-Paid" or Ucase(objRds("Payment_status") & "")="PAID"  then%>
						<span class="label label-success">PAID/CARD</span>
						<%else%>
						<span class="label label-danger">UNPAID/CASH</span>
						<%end if%>
						</td>
                           <% dim sUrlSearchPostCode : sUrlSearchPostCode = "https://www.google.co.uk/maps?q="&  objRds("Address") & "," & objRds("PostalCode")
                               if objRds("DeliveryLat") & "" <> "" then
                                sUrlSearchPostCode = "https://www.google.co.uk/maps/search/?api=1&query=" & objRds("DeliveryLat") & "," & objRds("DeliveryLng") 
                               end if
                               
                                %>
						<td><span class="pull-right"><a href="<%=sUrlSearchPostCode %>" target="_blank"><%= objRds("PostalCode") %></a></span>
							 <b><%if objRds("DeliveryType")="d" then%><span style="color:#d9534f;">Delivery</span><%else%><span style="color:#5cb85c;">Collection</span><%end if%>: </b><%=  deliveryTime %><br>
							<small> Ordered on: <%= formatDateTimeC(objRds("OrderDate")) %>&nbsp;&nbsp;&nbsp;Order Value: <%=CURRENCYSYMBOL%><%=FormatNumber(objRds("OrderTotal"),2) %></small>
						</td>
						<td>
						<%if objRds("cancelled")=1 then%>
						<b>CANCELLED:</b><br>
						 <%= formatDateTimeC(objRds("cancelleddate")) %>
						<%end if%>
					
						<%if objRds("acknowledged")=1 and  objRds("outfordelivery")=0 then%>
						<b>ACKNOWLEDGED:</b><br>
						 <%= formatDateTimeC(objRds("acknowledgeddate")) %>
						<%end if%>
						
						<%if objRds("acknowledged")=1 and  objRds("outfordelivery")=1 then%>
						<%if objRds("DeliveryType")="c" then%>
						<b>COLLECTED:</b><br>
						 <%= formatDateTimeC(objRds("delivereddate")) %>
						<%else%>
						<b>OUT FOR DELIVERY:</b><br>
						 <%= formatDateTimeC(objRds("delivereddate")) %>
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
    function openWin(purl) {
        var url = purl;
        window.open(url, "s", "width= 640, height= 480, left=0, top=0, resizable=yes, toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=yes, resizable=no, copyhistory=no").blur();
        window.focus();
    }
    function UpdatePrintStatus(orderid, restaurantid, store,obj)
    {
        $(obj).hide();
        $.ajax({
            url: "ajx_force_print_text_receipt.asp?oid=" + orderid + "&res=" + store + "&ResID=" + restaurantid + "&r" + Math.random()
         
                })
            .done(function( data ) {
                if(data=="ok")
                    alert("Printing succesful!");
                else
                    alert("Update fail!");
                $(obj).show();
            });
       
    }
</script>
<%
    ' Response.Write("SEND_ORDERS_TO_PRINTER " & SEND_ORDERS_TO_PRINTER & "<br/>")
     if (printingtype = "text" and UCase(SEND_ORDERS_TO_PRINTER) = "EPSON")  then %>
         <a href="javascript::" onclick="UpdatePrintStatus(<%=objRds("id")%>,<%=Session("MM_id")%>,'online',this);" class="btn btn-default"">Print</a>
     <%elseIf UCase(SEND_ORDERS_TO_PRINTER) <> "EPSON" OR  InStr(PrintingURL,"thanks.asp") < 1  Then %>
	    <a href="javascript::" onclick="openWin('<%=PrintingURL %>?isPrint=Y&id_o=<%=objRds("id")%>&id_r=<%=Session("MM_id")%>')" class="btn btn-default"">Print</a>
<%   else %>
        <a href="javascript::" data-toggle="modal" data-id="<%= objRds("id") %>" data-target="#printModal"   class="btn btn-default aPrintButton">Print</a>
<% end if %>
		
<%if objRds("cancelled")=1 or objRds("acknowledged")=1  then%><%else%><button class="btn btn-primary btn-danger cancel" data-toggle="modal" data-target="#myModal" data-id=" <%= objRds("id") %>" data-email=" <%= objRds("email") %>" >Cancel</button>

<a href="../exe.asp?action=acknowledge&id=<%=objRds("id")%>&email=<%=objRds("email")%>&page=today" class="btn btn-success"">Acknowledge</a><%end if%>

<%if objRds("acknowledged")=1 then%>

<%if objRds("outfordelivery")=0 then%>

<%if objRds("deliverytype")="c" then%>

<a href="../exe.asp?action=collected&id=<%=objRds("id")%>&email=<%=objRds("email")%>&page=today" class="btn btn-success"">Collected</a>
<%else%>
<a href="../exe.asp?action=outfordelivery&id=<%=objRds("id")%>&email=<%=objRds("email")%>&page=today" class="btn btn-success"">Out for delivery</a>
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
                            set objRds = nothing
                        objCon.Close
                            set objCon = nothing
                        %>
				
					
					
					
					
					
				</tbody>
			</table>
			
		</div>
	</div>

      
</div>



<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
<form role="form" action="../exe.asp" method="get">
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
				<input type="hidden" name="page" id="page" value="today">
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
	</form>
</div>




    
<!-- Modal -->
<div class="modal fade" id="printModal" tabindex="-1" role="dialog" aria-labelledby="printModalLabel" aria-hidden="true">

    <div class="modal-dialog"  style="width:300px;">
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
          If InStr(listAdded, ";"&arrEpsonPrinterIDList(x)  & ";") < 1 Then
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
        $('#printModal').modal('toggle');
        }

        $(document).on("click", ".aPrintButton", function () {
     var OId = $(this).data('id');
     $("#printorderid").val( OId );
    
});
	</script>
</div>




<div class="modal fade" id="myModalack" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
<form role="form" action="../exe.asp" method="get">
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
				<input type="hidden" name="email" id="ackemail" value="">
				<input type="hidden" name="page" id="page" value="today">
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
     function bindCancelID()
    {
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
    }
$(document).ready(function(){

  bindCancelID();
      
});
    
function ReloadOrderList(){
    $.ajax({
  url: "ajax-totalorderdetail.asp"
  
})
  .done(function( data ) {
   $("#tempAjaxResult").html(data);
    $("#divSummary").html( $("#tempdivSummary").html());
    $("#divOrderList").html( $("#tempdivOrderList").html());
      bindCancelID();
  });
    }
</script>
    <script type="text/javascript">
var targetTime = new Date();
// Right now
var now = targetTime.getTime();
// Time in the future when you want to refresh
targetTime.setHours(00,01,0,0); // hour, minute, second, millisecond
// Time until refresh
var time = targetTime.getTime() - now;
//alert(time);
//window.setTimeout(function(){window.location.replace("https://www.yahoo.com");},time);
//window.setTimeout(function(){window.location.reload(true);},time);
</script>
<audio>
	<source src="../../cms/audio/beep.mp3"></source>
	<source src="../../cms/audio/beep.ogg"></source>
	Your browser isn't invited for super fun audio time.
</audio>

</body>
</html>
