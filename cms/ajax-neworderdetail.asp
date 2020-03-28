<%@LANGUAGE="VBSCRIPT"%>
<%Server.ScriptTimeout=86400%>
<!-- #include file="../Config.asp" -->
<!-- #include file="restaurantsettings.asp" -->
<!-- #include file="timezone.asp" -->
<%

    If Session("MM_id") & "" <> "" Then
    Dim objCon, objRds
Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 
    Dim PrintingURL
    If  ( UCase(SEND_ORDERS_TO_PRINTER) = "EPSON" AND EPSONJSPRINTERURL <> "" ) OR UCase(SEND_ORDERS_TO_PRINTER) = "STAR" Then
        PrintingURL = "../thanks.asp"
    Else
        PrintingURL = "print.asp"
    End If
        %>
<div id="tempdivSummary" class="row clearfix">
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
						
						<% 
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
						total=total+replace(objRds("ordertotal"),"£","")
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
							<div id="results" style="display:none;"><%=completetotal%></div><div id="refreshspace">&nbsp;</div><div align="center" id="refresh" style="display:none;"><a href="loggedin.asp" class="btn btn-danger btn-xs">NEW ORDER - CLICK TO REFRESH</a></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

<div id="tempdivOrderList" class="row clearfix">
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
							 <%= objRds("id")  %>
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
  function openWin(url)
  {

    var myWindow=window.open(url,'','fullscreen=yes');
 


    
  }
</script>
		
						<%if objRds("cancelled")=-1 or objRds("acknowledged")=-1  then%><%else%><button class="btn btn-primary btn-danger cancel" data-toggle="modal" data-target="#myModal" data-id=" <%= objRds("id") %>" data-email=" <%= objRds("email") %>" >Cancel</button>

<a href="exe.asp?action=acknowledge&id=<%=objRds("id")%>&email=<%=objRds("email")%>&page=loggedin" class="btn btn-success"">Acknowledge</a><%end if%>

<%if objRds("acknowledged")=-1 then%>

<%if objRds("outfordelivery")=0 then%>
<a href="javascript::" onclick="openWin('<%=PrintingURL %>?id_o=<%=objRds("id")%>&id_r=<%=Session("MM_id")%>&isPrint=Y')" class="btn btn-default"">Print</a>
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
<%
    Else 
        Response.Write("-1")
    End If
%>