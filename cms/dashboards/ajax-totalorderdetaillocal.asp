<%@LANGUAGE="VBSCRIPT"%>
<%Server.ScriptTimeout=86400%>
<!-- #include file="../../Config.asp" -->
<!-- #include file="../timezone.asp" -->
<!-- #include file="../restaurantsettings.asp" -->
<%

    If Session("MM_id") & "" <> "" Then
    Dim objCon, objRds
Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 
If ( UCase(SEND_ORDERS_TO_PRINTER) = "EPSON" AND EPSONJSPRINTERURL <> "" ) OR UCase(SEND_ORDERS_TO_PRINTER) = "STAR" Then
    PrintingURL = "../../local/thanks.asp"
Else
    PrintingURL = "print_local.asp"
End If
        %>
    

<div id="tempdivSummary"  class="row clearfix">
		<div class="col-md-12 column">
			<div class="row clearfix">
				<div class="col-md-4 column">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">
								TOTAL ORDERS
							</h3>
						</div>
						<div class="panel-body">
						
						<% 
                             function formatDateTimeCMS(byval strdate)
                            dim result 
	                   
		                        strdate = cdate(strdate)
			                    result = Month(strdate) & "/" & day(strdate) & "/" & Year(strdate) & " " & addZeroWithNumber(Hour(strdate)) & ":" & addZeroWithNumber(Minute(strdate)) & ":" &  addZeroWithNumber(Second(strdate))
                            formatDateTimeCMS = result 
                        end function

				  objCon.Open sConnStringcms
                              dim   DateCondition
                             DateCondition = formatDateTimeCMS( cdate(DateAdd("h",houroffset,now)))
                             dim yyyy1,mm1,dd1,hh1,nn1,ss1
                                yyyy1 = DatePart("yyyy", DateCondition)
                                mm1= DatePart("m", DateCondition)
                                dd1 = DatePart("d", DateCondition)
                                hh1 =0 'DatePart("h", DateCondition)
                                nn1 =0' DatePart("n", DateCondition)
                                ss1 =1' DatePart("s", DateCondition)
  
                       objRds.Open "SELECT * FROM view_paid_orderslocal where   IdBusinessDetail=" & Session("MM_id") & "  and  CreationDate >= '" & DateCondition & "'  and isnull(subtotal,0)   > 0 and isnull(firstname,'')   <> '' ORDER BY id desc"  , objCon
total=0
totalinccancelled=0
ordercnt=0
ordercancelled=0
pending=0
orderrejected=0
completetotal=0



                        Do While NOT objRds.Eof
					totalinccancelled=totalinccancelled+replace(objRds("subtotal"),"£","")
						completetotal=completetotal+1
                        if 1 = 2 then
						if objRds("cancelled")=1 then
						ordercancelled=ordercancelled+1
						end if
						
						if objRds("cancelledby")="Restaurant" then
						orderrejected=orderrejected+1
						end if
		
						if objRds("cancelled")<>1 then
						ordercnt=ordercnt+1
						total=total+replace(objRds("ordertotal"),"£","")
						end if
						
						
						
						if objRds("acknowledged")=1 and objRds("outfordelivery")=0 then
						pending=pending+1
						end if
                        end if '1=2
                            objRds.MoveNext    
                        Loop
                            objRds.close()
                            set objRds = nothing
                            %>
                    
						
							<div align="center"><h1><%=CURRENCYSYMBOL%><%=FormatNumber(totalinccancelled,2)%></h1></div>
						</div>
						<div class="panel-footer">
						<div id="completetotal" style="display:none;"><%=completetotal%></div>
							<div id="results" style="display:none;"><%=completetotal%></div><div id="refreshspace"><div align="center">Total:<%=completetotal%> (including cancelled orders)</div> </div><div align="center" id="refresh" style="display:none;"><a href="today_local.asp" class="btn btn-danger btn-xs">NEW ORDER - CLICK TO REFRESH</a></div>
						</div>
					</div>
				</div>
                <% if 1=2 then %>
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
                <% end if '1=2 %>
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
				
				<%  'objRds.Close
                    '    objCon.Close
				'  objCon.Open sConnStringcms
                        Set objRds = Server.CreateObject("ADODB.Recordset") 
                        objRds.Open "SELECT * FROM ORDERSlocal  where  IdBusinessDetail=" & Session("MM_id") & " and    DateDiff(day,[CreationDate],'" & JXIsoDate(DateAdd("h",houroffset,now)) & "')=0 and isnull(subtotal,0)  > 0 and isnull(firstname,'')   <> ''  ORDER BY id desc" , objCon

                        Do While NOT objRds.Eof
                        %>
                       <tr>
					  
						<td>
                            
							 <%= objRds("id") %>
                             <br /> 
                            <span style="color:#5cb85c;">Customer: <%=objRds("FirstName")  %></span>
                             <% if 1 = 2 then %>
							 <br>
							 <%if lcase(objRds("paymenttype"))="stripe-paid" or  objRds("paymenttype")="Paypal-Paid" or  objRds("PaymentType")="NoChex-Paid"  or  objRds("PaymentType")="Worldpay-Paid" or Ucase(objRds("Payment_status") & "")="PAID"   then%>
						<span class="label label-success">PAID/CARD</span>
						<%else%>
						<span class="label label-danger">UNPAID/CASH</span>
						<%end if%>
                            <%  end if ' 1 = 2%>
						</td>
                            <% dim sUrlSearchPostCode : sUrlSearchPostCode = "https://www.google.co.uk/maps?q="&  objRds("Address") & "," & objRds("PostalCode")
                               if objRds("DeliveryLat") & "" <> "" then
                                sUrlSearchPostCode = "https://www.google.co.uk/maps/search/?api=1&query=" & objRds("DeliveryLat") & "," & objRds("DeliveryLng") 
                               end if
                               
                                %>
						<td><span class="pull-right"><a href="<%=sUrlSearchPostCode %>" target="_blank"><%= objRds("PostalCode") %></a></span>
							 <b><%if objRds("DeliveryType")="d" then%><span style="color:#d9534f;">Delivery</span><%else%><span style="color:#5cb85c;">Collection</span><%end if%>: </b><%= formatDateTimeC(objRds("DeliveryTime")) %><br>
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
						
			

					
			<button class="btn btn-primary btn-" data-toggle="modal" data-target="#myModalorder" data-remote="orderlocal.asp?id_o=<%=objRds("id")%>&id_r=<%=Session("MM_id")%>">
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



    <% if (printingtype = "text" and UCase(SEND_ORDERS_TO_PRINTER) = "EPSON")  then %>
         <a href="javascript::" onclick="UpdatePrintStatus(<%=objRds("id")%>,<%=Session("MM_id")%>,'instore',this);" class="btn btn-default"">Print</a>
    <% elseIf UCase(SEND_ORDERS_TO_PRINTER) <> "EPSON" OR InStr(PrintingURL,"thanks.asp") < 1 or (printingtype = "text" and UCase(SEND_ORDERS_TO_PRINTER) = "EPSON")  Then %>
	    <a href="javascript::" onclick="openWin('<%=PrintingURL %>?isPrint=Y&id_o=<%=objRds("id")%>&id_r=<%=Session("MM_id")%>&f=2')" class="btn btn-default"">Print</a>
    <% else %>
        <a href="javascript::" data-toggle="modal" data-id="<%= objRds("id") %>" data-target="#printModal"   class="btn btn-default aPrintButton">Print</a>
    <% end if %>
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