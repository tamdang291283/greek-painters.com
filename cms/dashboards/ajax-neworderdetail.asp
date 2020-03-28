<%@LANGUAGE="VBSCRIPT"%>
<%Server.ScriptTimeout=86400%>
<!-- #include file="../../Config.asp" -->
<!-- #include file="../restaurantsettings.asp" -->
<!-- #include file="../timezone.asp" -->
<%

    If Session("MM_id") & "" <> "" Then
    Dim objCon, objRds
Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 
    Dim PrintingURL
    If  ( UCase(SEND_ORDERS_TO_PRINTER) = "EPSON" AND EPSONJSPRINTERURL <> "" ) OR UCase(SEND_ORDERS_TO_PRINTER) = "STAR" Then
        PrintingURL = "../../thanks.asp"
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
                       objRds.Open "SELECT * FROM view_paid_orders where  IdBusinessDetail=" & Session("MM_id") & " and (DateDiff(day,[orderdate],'" & JXIsoDate(DateAdd("h",houroffset,now)) & "')<=1 or (acknowledged=0 and cancelled=0 and outfordelivery=0))  ORDER BY id desc" , objCon
                        total=0
                        ordercnt=0
                        ordercancelled=0
                        pending=0
                        orderrejected=0
                        completetotal=0

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
						total=total+replace(objRds("ordertotal"),"£","")
						end if
						
						if objRds("acknowledged")=1 and objRds("outfordelivery")=0 then
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
                    set objRds = nothing
                       ' objCon.Close
				  'objCon.Open sConnStringcms
                        Set objRds = Server.CreateObject("ADODB.Recordset") 
                        objRds.Open "SELECT * FROM ORDERS  where  IdBusinessDetail=" & Session("MM_id") & " and (DateDiff(day,[orderdate],'" & JXIsoDate(DateAdd("h",houroffset,now)) & "')<=1 or (acknowledged=0 and cancelled=0 and outfordelivery=0)) ORDER BY id desc" , objCon

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
							 <%= objRds("id")  %>
							 <br>
							 <%if lcase( objRds("paymenttype")&"")="stripe-paid" or  objRds("paymenttype")="Paypal-Paid" or  objRds("PaymentType")="NoChex-Paid"  or  objRds("PaymentType")="Worldpay-Paid" or Ucase(objRds("Payment_status") & "")="PAID"  then%>
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


		
<%if objRds("cancelled")=1 or objRds("acknowledged")=1  then%><%else%><button class="btn btn-primary btn-danger cancel" data-toggle="modal" data-target="#myModal" data-id=" <%= objRds("id") %>" data-email=" <%= objRds("email") %>" >Cancel</button>

<a href="../exe.asp?action=acknowledge&amp;id=<%=objRds("id")%>&amp;email=<%=objRds("email")%>&amp;page=loggedin" class="btn btn-success"">Acknowledge</a><%end if%>

<%if objRds("acknowledged")=1 then%>

<%if objRds("outfordelivery")=0 then 
        if printingtype = "text" and UCase(SEND_ORDERS_TO_PRINTER) = "EPSON"  then
            %>
                 <a href="javascript::" onclick="UpdatePrintStatus(<%=objRds("id")%>,<%=Session("MM_id")%>,'online',this);" class="btn btn-default"">Print</a>                            
            <%
        else
        %>
            <a href="javascript::" data-toggle="modal" data-id="<%=objRds("id") %>" data-target="#printModal" class="btn btn-default aPrintButton">Print</a>
        <% end if %>
<%if objRds("deliverytype")="c" then%>

<a href="../exe.asp?action=collected&amp;id=<%=objRds("id")%>&amp;email=<%=objRds("email")%>&amp;page=loggedin" class="btn btn-success">Collected</a>
<%else%>
<a href="../exe.asp?action=outfordelivery&amp;id=<%=objRds("id")%>&amp;email=<%=objRds("email")%>&amp;page=loggedin" class="btn btn-success">Out for delivery</a>
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
<%
    Else 
        Response.Write("-1")
    End If
%>