<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../../Config.asp" -->
<!-- #include file="../timezone.asp" -->
<!-- #include file="../restaurantsettings.asp" -->

<%Server.ScriptTimeout=86400%>
<%
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
<link href="../css/bootstrap-datepicker.min.css" rel="stylesheet">
  <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
  <![endif]-->

  <!-- Fav and touch icons -->
   <% If FAVICONURL & "" <> "" Then %> <link rel='shortcut icon' href='<%=FAVICONURL %>' type='image/x-icon'/ > <% end If %>
  
	<script type="text/javascript" src="../js/jquery.min.js"></script>
	<script type="text/javascript" src="../js/bootstrap.min.js"></script>
	<script src="../js/bootstrap-datepicker.min.js"></script>
	<script type="text/javascript" src="../js/scripts.js"></script>
      <link href="../css/x0popup.default.css?v=1.1" rel="stylesheet">    
    <link href="../css/x0popup.css?v=1" rel="stylesheet">
	<script type="text/javascript" src="../js/x0popup.js?v=1.1"></script>
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
	 <!-- #Include file="../inc-header.inc"-->
	 
	 
<%if request.querystring("startDate")="" then
 sd=date()
else
 sd=request.querystring("startDate")
end if
if request.querystring("endDate")="" then
 ed=date()
else
 ed=request.querystring("endDate")
end if
%>
	<script>
        function ExportOrder()
        {
            location.href = "orderexport.asp?start=" + $("#startDate").val() + "&end=" + $("#endDate").val() + "&freetext=" + $("#freetext").val();
        }
	</script>
<form class="form-inline mt20" id="searchform" action="history.asp">
<div class="row clearfix">
<div class="col-md-2"><input type="text" class="form-control datepicker" id="startDate" name="startDate" placeholder="Start date" value="<%=sd%>" size="10">
</div>
<div class="col-md-2"><input type="text" class="form-control datepicker" id="endDate" name="endDate" placeholder="End date" value="<%=ed%>" size="10">
</div>
<div class="col-md-4"> <input type="text" class="form-control" id="freetext" name="freetext" placeholder="Free text" value="<%=request.querystring("freetext")%>" size="30" data-toggle="tooltip" data-placement="left" title="This field searches for full/partial content in fields: order no, customer name, customer address, customer postcode">
</div>
<div class="col-md-2">    <button type="submit" class="btn btn-default btn-block">Lookup</button></div>
<div class="col-md-2"> <button type="button" class="btn btn-default btn-block" onclick="ExportOrder()"  style=" cursor:pointer;">Download</button></div>
</div>
	
        </form>
<br>

<div class="row clearfix">


		<div class="col-md-12 column">
		
		
		
			<table class="table table-hover table-condensed table-striped">
				<thead>
					<tr>
           
					<th>
							Order Date.
						</th>
						<th>
							Order No.
						</th>
						<th>
							<div align="center">Total</div>
						</th>
						<th><div align="center">Delivery</div></th>
						<th><div align="center">Collection</div></th>
						<th><div align="center">Card</div></th>
						<th><div align="center">Cash</div></th>
						<th><div align="center">Cancelled</div></th>
                        <th><div align="center">
                              <select name="slSelect" id="slSelect" onchange="DeleteMultiOrder(this)">
                                <option value="">Select Action</option>
                                <option value="delete">Delete Selected</option>
                                <option value="print">Print Selected</option>                                
                            </select>

                            <!--<input type="button" onclick="DeleteMultiOrder()" value="Delete Order Selected" />-->

                            </div></th> 
					</tr>
				</thead>
				<tbody>
				
				

				<% 
				
				totalorder=0
				totalorderdelivery=0
				totalordercollection=0
				totalordercash=0
				totalordercard=0
				totalordercancelled=0
				
				totalordercancelleddelivery=0
				totalordercancelledcollection=0 
				totalordercancelledcash=0
				totalordercancelledcard=0
				
				' objRds.Close
                 '       objCon.Close
				  objCon.Open sConnStringcms



sql="SELECT * FROM view_paid_orders where (paymenttype='Stripe-Paid' or paymenttype='Paypal-Paid' or paymenttype='NoChex-Paid' or paymenttype='Worldpay-Paid' or paymenttype='Cash on Delivery' or payment_status = 'Paid' or cancelled=1) and IdBusinessDetail=" & Session("MM_id") 

' check if start date end date so enddate + 1 day
'if sd & "" <> "" and ed & "" <> ""  and sd  = ed then
'    ed = DateAdd("d",1,CDate(ed))
'end if
' end 

if sd<>"" then

sss=split(sd,"/")
startdate_day=sss(0)
startdate_month=sss(1)
startdate_year=sss(2)
'startdate_sql=  startdate_month & "/" & startdate_day & "/" & startdate_year
startdate_sql=  startdate_month  & "/" & startdate_day & "/" & startdate_year  
'startdate_sql=DateAdd("d",-1,startdate_sql) 
sql=sql & " AND  [OrderDate] >='" & startdate_sql & " 00:00:01" & "'"

end if

if ed<>"" then

sss=split(ed,"/")
enddate_day=sss(0)
enddate_month=sss(1)
enddate_year=sss(2)
'enddate_sql=  enddate_month & "/" & enddate_day & "/" & enddate_year
 enddate_sql=  enddate_month  & "/" & enddate_day & "/" &  enddate_year
'enddate_sql=DateAdd("d",1,enddate_sql) 
sql=sql & " AND  [OrderDate]<='" & enddate_sql & " 23:59:59" & "'"

end if


if request.querystring("freetext")<>"" then

sql=sql & " AND  ([id] LIKE '%" & request.querystring("freetext") & "%' or [id] LIKE '%" & request.querystring("freetext") & "%' or ([firstname] + ' ' + [lastname]) LIKE '%" & request.querystring("freetext") & "%' or [postalcode] LIKE '%" & request.querystring("freetext") & "%' or [address] LIKE '%" & request.querystring("freetext") & "%')"

end if

sql = sql & " ORDER BY OrderDate desc"

  
	 'response.write sql 
objRds.Open sql   , objCon,1


if request.querystring("page")<>"" then
	page=request.querystring("page")
	else
	page=1
end if
pagesize=30
totalrecords=objRds.RecordCount
startrecord=(page*pagesize)-pagesize+1
endrecord=startrecord+pagesize-1
 cnt=1
ordersonpage=0
orders=0
                        Do While NOT objRds.Eof
						if objRds("deliverytype")="d" then
						     totalorderdelivery=totalorderdelivery+objRds("OrderTotal")
						if objRds("cancelled")=1 then
						totalordercancelleddelivery=totalordercancelleddelivery+objRds("OrderTotal")
						end if
						end if
						if objRds("deliverytype")="c" then
						totalordercollection=totalordercollection+objRds("OrderTotal")
						if objRds("cancelled")=1 then
						totalordercancelledcollection=totalordercancelledcollection+objRds("OrderTotal")
						end if
						end if
						if objRds("paymenttype")<>"Cash on Delivery" then
						totalordercard=totalordercard+objRds("OrderTotal")
						if objRds("cancelled")=1 then
						totalordercancelledcard=totalordercancelledcard+objRds("OrderTotal")
						end if
						end if
						if objRds("paymenttype")="Cash on Delivery" then
						totalordercash=totalordercash+objRds("OrderTotal")
						if objRds("cancelled")=1 then
						totalordercancelledcash=totalordercancelledcash+objRds("OrderTotal")
						end if
						end if
						if objRds("cancelled")=1 then
						totalordercancelled=totalordercancelled+objRds("OrderTotal")
						end if
						totalorder=totalorder+objRds("OrderTotal")
						orders=orders+1
						if cnt>=startrecord and cnt<=endrecord then
						
						
						ordersonpage=ordersonpage+1
                        %>
                       <tr>
                    
					   <td> <%=formatDateTimeC(objRds("OrderDate"))%></td>
						<td>
						<a href="javascript:;"  data-toggle="modal" data-target="#myModalorder" data-remote="order.asp?id_o=<%=objRds("id")%>&id_r=<%=Session("MM_id")%>">
<%=objRds("id")%>
</a>	
						</td>
							<td><div align="center"><%=CURRENCYSYMBOL%><%=FormatNumber(objRds("OrderTotal"),2) %></div></td>
						<td>
						<%if objRds("deliverytype")="d" then
						%>
						<div align="center"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span></div>
						<%end if%>
						</td>
						<td><%if objRds("deliverytype")="c" then
						%>
						<div align="center"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span></div>
						<%end if%></td>

						<td><%if objRds("paymenttype")<>"Cash on Delivery" then
						%>
						<div align="center"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span></div>
						<%end if%></td>
					<td><%if objRds("paymenttype")="Cash on Delivery" then
					%>
						<div align="center"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span></div>
						<%end if%></td>
						<td><%if objRds("cancelled")=1 then
					%>
						<div align="center"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span></div>
						<%end if%></td>
                        <td><div align="center"><input type="checkbox" name="ckorderdelete" value="<%=objRds("id") %>" /></div></td> 
					</tr>
                        <%end if
						cnt=cnt+1
                            objRds.MoveNext    
                        Loop
                    
                        objRds.Close
                        set objRds = nothing
                        objCon.Close
                            set objCon = nothing
                        %>
				
					<%if ordersonpage>0 then%>

					<tr>
					   <td> <div class="lead"><strong>TOTAL</strong></div></td>
						<td>
						</td>
							<td><div align="center" class="lead"><%=CURRENCYSYMBOL%><%=FormatNumber(totalorder,2) %><br>
							<small>(avg: <%=FormatNumber(totalorder/orders,2)%>)</small></div>
						</td>
						<td><div align="center" class="lead"><%=CURRENCYSYMBOL%><%=FormatNumber(totalorderdelivery,2) %><br>
							<small>(<%=FormatNumber(totalorderdelivery/(totalorder/100),2)%>%)</small></div>
						</td>
						<td><div align="center" class="lead"><%=CURRENCYSYMBOL%><%=FormatNumber(totalordercollection,2) %><br>
							<small>(<%=FormatNumber(totalordercollection/(totalorder/100),2)%>%)</small></div>
						
							
						</td>
						<td>
						<div align="center" class="lead"><%=CURRENCYSYMBOL%><%=FormatNumber(totalordercard,2) %><br>
							<small>(<%=FormatNumber(totalordercard/(totalorder/100),2)%>%)</small></div>
							
						</td>
					<td>
						
							<div align="center" class="lead"><%=CURRENCYSYMBOL%><%=FormatNumber(totalordercash,2) %><br>
							<small>(<%=FormatNumber(totalordercash/(totalorder/100),2)%>%)</small></div>
						</td>
						<td>
						
							<div align="center" class="lead"><%=CURRENCYSYMBOL%><%=FormatNumber(totalordercancelled,2) %><br>
							<small>(<%=FormatNumber(totalordercancelled/(totalorder/100),2)%>%)</small></div>
						</td>
					</tr>
					
					
					<tr>
					   <td> <div class="lead"><strong>CANCELLED</strong></div></td>
						<td>
						
							
						</td>
							<td><div align="center" class="lead"><%=CURRENCYSYMBOL%><%=FormatNumber(totalordercancelled,2) %></div>
						</td>
						<td><div align="center" class="lead"><%=CURRENCYSYMBOL%><%=FormatNumber(totalordercancelleddelivery,2) %></div>
						</td>
						<td><div align="center" class="lead"><%=CURRENCYSYMBOL%><%=FormatNumber(totalordercancelledcollection,2) %></div>
						</td>
						<td>
						<div align="center" class="lead"><%=CURRENCYSYMBOL%><%=FormatNumber(totalordercancelledcard,2) %></div>
						</td>
					<td>
						<div align="center" class="lead"><%=CURRENCYSYMBOL%><%=FormatNumber(totalordercancelledcash,2) %></div>
						</td>
						<td>
							<div align="center" class="lead"><%=CURRENCYSYMBOL%><%=FormatNumber(totalordercancelled,2) %></div>
						</td>
					</tr>
					<tr>
					   <td> <div class="lead"><strong>NET TOTAL</strong></div></td>
						<td>
						
							
						</td>
							<td><div align="center" class="lead"><%=CURRENCYSYMBOL%><%=FormatNumber(totalorder-totalordercancelled,2) %></div>
							
						
							
						</td>
						<td><div align="center" class="lead"><%=CURRENCYSYMBOL%><%=FormatNumber(totalorderdelivery-totalordercancelleddelivery,2) %></div>
						
							
						</td>
						<td><div align="center" class="lead"><%=CURRENCYSYMBOL%><%=FormatNumber(totalordercollection-totalordercancelledcollection,2) %></div>
						
							
						</td>
						<td>
						<div align="center" class="lead"><%=CURRENCYSYMBOL%><%=FormatNumber(totalordercard-totalordercancelledcard,2) %></div>
							
						</td>
					<td>
						
							<div align="center" class="lead"><%=CURRENCYSYMBOL%><%=FormatNumber(totalordercash-totalordercancelledcash,2) %></div>
						</td>
						<td>
						
							<div align="center" class="lead"><%=CURRENCYSYMBOL%><%=FormatNumber(totalordercancelled-totalordercancelled,2) %></div>
						</td>
					</tr>
					<%end if%>
					
					
					
				</tbody>
			</table>
			
		</div>
	</div>
<div class="pagingboxnumbers">
<nav>
  <ul class="pagination">

<%

if abs(page)>10 then%>
<li><a href="history.asp?freetext=<%=request.querystring("freetext")%>&startDate=<%=sd%>&endDate=<%=ed%>&page=<%=1%>" class="">1</a>.....</li>
<%end if%>


<%
for g=1 to round(abs((totalrecords/pagesize))+0.5)%>
<%if abs(page)>abs(g)-10 and abs(page)<abs(g)+10 then%>
<li class="<%if abs(page)=abs(g) then%>active<%else%><%end if%>"><a href="history.asp?freetext=<%=request.querystring("freetext")%>&startDate=<%=sd%>&endDate=<%=ed%>&page=<%=g%>" ><%=g%></a></li><%end if%><%next%><%
if abs(page)<round(abs((totalrecords/pagesize))+0.5)-10 then%>
<li>...<a href="history.asp?freetext=<%=request.querystring("freetext")%>&startDate=<%=sd%>&endDate=<%=ed%>&page=<%=round(abs((totalrecords/pagesize))+0.5)%>" class=""><%=round(abs((totalrecords/pagesize))+0.5)%></a></li>
<%end if%>
  </ul>
</nav>

<br>
<br>

		
</div>
      
</div>


<div class="modal fade" id="myModalorder" tabindex="-1" role="dialog" aria-labelledby="myModalLabelorder" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      
      <div class="modal-body">
     </div>
      
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
				<input type="hidden" name="page" id="page" value="history">
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
	</form>
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
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
	</form>
</div>


<!-- /.modal -->


<script>

$(document).ready(function(){

$(function () {
  $('[data-toggle="tooltip"]').tooltip()
})

$('.datepicker').datepicker({
format: 'dd/mm/yyyy',
    autoclose: true
});



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

</script>
<script type="text/javascript">
    function DeleteMultiOrder(obj) {
        // x0p('Confirmation', 'Are you sure?', 'warning');


        if ($(obj).val() == "")
            return false;
        var mode = $(obj).val();
        var listoforderid = "";
        $("[name=ckorderdelete]").each(function () {
            if ($(this).is(":checked")) {
                if (listoforderid != "")
                    listoforderid += "," + $(this).val();
                else
                    listoforderid = $(this).val();
            }
        });
        if (listoforderid == "") {
            // alert("No orders selected");
            x0p('Notification', 'No records selected', 'info');

            $(obj).val("");
            return false;
        }
        // if (confirm("If you continue, your current selected orders will be deleted and the change is irreverseble.  Proceed?"))
        // $("#mi-modal").modal('show');

        var textwarning = "", action = "";
        var buttontype = "";
        if ($(obj).val() == "print") {
            textwarning = "Do you want to continue?";
            action = "Print?";
            buttontype = "warning";
        }
        else if ($(obj).val() == "delete") {
            textwarning = "Warning!  This change cannot be reversed.";
            action = "Delete?";
            buttontype = "delete";
        }
        x0p(action, textwarning, buttontype, function (button, text) {

            if (button != "cancel") {
                $.ajax({
                    url: "deleteOrder.asp?action=" + mode + "&OrderID=" + listoforderid + "&r" + Math.random()
                })
            .done(function (data) {
                if (data == "OK") {
                    x0p('Message', 'The operation was succesful', 'info', function () { location.reload(); });

                }
                else {

                    x0p('Message', 'The operation was unsuccesful', 'info', function () { $("#slSelect").val(""); });

                }
            });
            } else {
                $("#slSelect").val("");
            }

        });

    }


</script>
</body>
</html>
