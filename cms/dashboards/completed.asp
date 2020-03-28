<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../../Config.asp" -->
<!-- #include file="../timezone.asp" -->
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

  <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
  <![endif]-->

  <!-- Fav and touch icons -->
   <link rel='shortcut icon' href='../../images-icons/favicon.ico' type='image/x-icon'/ >
  
	<script type="text/javascript" src="../js/jquery.min.js"></script>
	<script type="text/javascript" src="../js/bootstrap.min.js"></script>
	<script type="text/javascript" src="../js/scripts.js"></script>
	
	<script type="text/javascript">// <![CDATA[
$(document).ready(function() {
$.ajaxSetup({ cache: false }); // This part addresses an IE bug.  without it, IE will only load the first number and will never refresh
setInterval(function() {
$('#results').load('ajax-neworder2.asp');
if ($( "#results" ).text()>$( "#completetotal" ).text()) {
$( "#refreshspace" ).hide();
$( "#refresh" ).show();

var audio = document.getElementsByTagName("audio")[0];
audio.play();

}
}, 10000); // the "3000" here refers to the time to refresh the div.  it is in milliseconds. 

});
// ]]></script>
</head>

<body>
<div class="container">
	 <!-- #Include file="../inc-header.inc"-->
	


<div class="row clearfix">
		<div class="col-md-12 column">
			<div class="row clearfix">
				
						
						<% 'objRds.Close
                        'objCon.Close
				  objCon.Open sConnStringcms
                       objRds.Open "SELECT * FROM view_paid_orders where  IdBusinessDetail=" & Session("MM_id") & " and not(cancelled=1 or outfordelivery=1)  ORDER BY DeliveryTime  desc" , objCon
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
		
						if objRds("acknowledged")=1 then
						ordercnt=ordercnt+1
						total=total+replace(objRds("ordertotal"),"�","")
						end if
						
						if objRds("acknowledged")=1 and objRds("outfordelivery")=0 then
						pending=pending+1
						end if
                            objRds.MoveNext    
                        Loop
                            objRds.close()
                            set objRds = nothing
                            %>
                    
						
						
				
				
			</div>
		</div>
	</div>

<div class="row clearfix">
		<div class="col-md-12 column">
		<h1>Completed orders</h1>
		
		<%
		' objRds.Close
                       ' objCon.Close
				'  objCon.Open sConnStringcms
				  Set objRds = Server.CreateObject("ADODB.Recordset") 
				  objRds.CursorType = 1
objRds.CursorLocation = 2
objRds.LockType = 1
                        objRds.Open "SELECT * FROM view_paid_orders where  IdBusinessDetail=" & Session("MM_id") & " and (cancelled=1 or outfordelivery=1)  ORDER BY DeliveryTime  desc" , objCon

%>
		<%if request.querystring("page")<>"" then
	page=request.querystring("page")
	else
	page=1
end if
pagesize=30
totalrecords=objRds.RecordCount
startrecord=(page*pagesize)-pagesize+1
endrecord=startrecord+pagesize-1
%>

<div class="pagingbox" id="toppage">
	


	<div class="pagingboxcenter">Showing <%=startrecord%>-<%=endrecord%> of <%=totalrecords%> orders</div>
	<div class="pagingboxnumbers">





<nav>
  <ul class="pagination">
  <%if abs(page)>1 then%>
    <li>
      <a href="completed.asp?s=<%=request.querystring("s")%>&sort=<%=request.querystring("sort")%>&page=<%=request.querystring("page")-1%>" aria-label="Previous">
        <span aria-hidden="true">&laquo;</span>
      </a>
    </li>
	<%end if%>
	
	<%for g=1 to round(abs((totalrecords/pagesize))+0.5)%><li class="<%if abs(page)=abs(g) then%>active<%end if%>">
<a href="completed.asp?s=<%=request.querystring("s")%>&sort=<%=request.querystring("sort")%>&page=<%=g%>" ><%=g%></a></li>
<%next%>
    <%if abs(page)<round(abs((totalrecords/pagesize))+0.5) then%>
    <li>
      <a href="completed.asp?s=<%=request.querystring("s")%>&sort=<%=request.querystring("sort")%>&page=<%=request.querystring("page")+1%>" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
      </a>
    </li>
	<%end if%>
  </ul>
</nav>


		
</div>
	
	</div>
		
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
				
				<% cnt=1
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
                                set rs_BusinessDetails = nothing
                            end if
                        ' End
                        Do While NOT objRds.Eof
							if cnt>=startrecord and cnt<=endrecord then
                        %>
                       <tr>
						<td>
							 <%= objRds("id") %>
							 <br>
							 <%if objRds("paymenttype")="Stripe-Paid"  or objRds("paymenttype")="Paypal-Paid"  or objRds("PaymentType")="NoChex-Paid" or objRds("PaymentType")="Worldpay-Paid" or Ucase(objRds("Payment_status") & "")="PAID"  then%>
						<span class="label label-success">PAID/CARD</span>
						<%else%>
						<span class="label label-danger">UNPAID/CASH</span>
						<%end if%>
						</td>
                           <%
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
                             <% dim sUrlSearchPostCode : sUrlSearchPostCode = "https://www.google.co.uk/maps?q="&  objRds("Address") & "," & objRds("PostalCode")
                               if objRds("DeliveryLat") & "" <> "" then
                                sUrlSearchPostCode = "https://www.google.co.uk/maps/search/?api=1&query=" & objRds("DeliveryLat") & "," & objRds("DeliveryLng") 
                               end if
                               
                                %>
						<td><span class="pull-right"><a href="<%=sUrlSearchPostCode %>" target="_blank"><%= objRds("PostalCode") %></a></span>
							 <b><%if objRds("DeliveryType")="d" then%><span style="color:#d9534f;">Delivery</span><%else%><span style="color:#5cb85c;">Collection</span><%end if%>: </b><%= deliveryTime %><br>
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
  function openWin(url)
  {

    var myWindow=window.open(url,'','fullscreen=yes');
 


    
  }
</script>
	
						<%if objRds("cancelled")=1 or objRds("acknowledged")=1  then%><%else%><button class="btn btn-primary btn-danger cancel" data-toggle="modal" data-target="#myModal" data-id=" <%= objRds("id") %>" data-email=" <%= objRds("email") %>" >Cancel</button>	<a href="../exe.asp?action=acknowledge&id=<%=objRds("id")%>&email=<%=objRds("email")%>&page=completed" class="btn btn-success"">Acknowledge</a><%end if%>

<%if objRds("acknowledged")=1 then%>

<%if objRds("outfordelivery")=0 then%>
<a href="javascript::" onclick="openWin('print.asp?id_o=<%=objRds("id")%>&id_r=<%=Session("MM_id")%>')" class="btn btn-default"">Print</a>
<%if objRds("deliverytype")="c" then%>

<a href="../exe.asp?action=collected&id=<%=objRds("id")%>&email=<%=objRds("email")%>&page=completed" class="btn btn-success"">Collected</a>
<%else%>
<a href="../exe.asp?action=outfordelivery&id=<%=objRds("id")%>&email=<%=objRds("email")%>&page=completed" class="btn btn-success"">Out for delivery</a>
<%end if%>
<%end if%>
 <%else%>

<%end if%>
						</td>
						
					</tr>
                        <%
						end if
cnt=cnt+1
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
				<input type="hidden" name="page" id="page" value="completed">
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

   $(".cancel").click(function(){ // Click to only happen on announce links

     $("#id").val($(this).data('id'));
     $("#email").val($(this).data('email'));
   });
});

</script>
<audio>
	<source src="../../cms/audio/beep.mp3"></source>
	<source src="../../cms/audio/beep.ogg"></source>
	Your browser isn't invited for super fun audio time.
</audio>
</body>
</html>
