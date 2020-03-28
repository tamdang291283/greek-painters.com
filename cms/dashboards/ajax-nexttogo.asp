<%@LANGUAGE="VBSCRIPT"%>
<%Server.ScriptTimeout=86400%>
<!-- #include file="../../Config.asp" -->
<!-- #include file="../../timezone.asp" -->
<!-- #include file="../restaurantsettings.asp" -->
<%
    dim sUrlSearchPostCode 
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
          <div id="divSummary" class="row clearfix">
		<div class="col-md-12 column">
			<div class="row clearfix">		
						
						<% 
                            
                    'objRds.Close
                'objCon.Close
				  objCon.Open sConnStringcms

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

                         
                            function formatDateTimeCMS(byval strdate)
                            dim result 
	                   
		                        strdate = cdate(strdate)
			                    result = Month(strdate) & "/" & day(strdate) & "/" & Year(strdate) & " " & addZeroWithNumber(Hour(strdate)) & ":" & addZeroWithNumber(Minute(strdate)) & ":" &  addZeroWithNumber(Second(strdate))
                            formatDateTimeCMS = result 
                        end function
                              
                        Dim sQuery , DateCondition
                               
                                 DateCondition = formatDateTimeCMS(cdate(DateAdd("h",houroffset,now)))
                                  dim yyyy1,mm1,dd1,hh1,nn1,ss1
                                yyyy1 = DatePart("yyyy", DateCondition)
                                mm1= DatePart("m", DateCondition)
                                dd1 = DatePart("d", DateCondition)
                                hh1 = DatePart("h", DateCondition)
                                nn1 = DatePart("n", DateCondition)
                                ss1 = DatePart("s", DateCondition)

                            dim RS_OrderEarly :  set  RS_OrderEarly = Server.CreateObject("ADODB.Recordset")
                                             
                             sQuery = " SELECT "  &config_prefix_sql_function&  "FNC_DeliveryTime(asaporder,deliverytype,deliverydelay,orderdate,collectiondelay,deliverytime) as deliverytime1 ,* FROM view_paid_orders where IdBusinessDetail= "  & Session("MM_id")
                             sQuery =sQuery &  " and cancelled=0 "   
                            
                             sQuery = sQuery & " and DateDiff(day,[orderdate],'" & JXIsoDate(DateAdd("h",houroffset,now)) & "')<=1  "
                             sQuery = sQuery & " AND  "  &config_prefix_sql_function&  "FNC_DeliveryTime(asaporder,deliverytype,deliverydelay,orderdate,collectiondelay,deliverytime)  < '" &  DateCondition & "' ORDER BY deliverytime1 desc   " 
                            
                             RS_OrderEarly.Open sQuery , objCon
                              
                            
              
                            sQuery = " SELECT "  &config_prefix_sql_function&  "FNC_DeliveryTime(asaporder,deliverytype,deliverydelay,orderdate,collectiondelay,deliverytime) as deliverytime1 ,* FROM ORDERS where  IdBusinessDetail= "  & Session("MM_id")
                            sQuery = sQuery & " and cancelled=0  AND   "  &config_prefix_sql_function&  "FNC_DeliveryTime(asaporder,deliverytype,deliverydelay,orderdate,collectiondelay,deliverytime)  >= '" & DateCondition & "' ORDER BY deliverytime1 desc  " 
                           
                                     

                       objRds.Open sQuery , objCon

                        total=0
                        ordercnt=0
                        ordercancelled=0
                        pending=0
                        orderrejected=0
                        completetotal=0


                        if NOT objRds.Eof then
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
						
					    '	if objRds("acknowledged")=1 and objRds("outfordelivery")=0 then
						    pending=pending+1
						    'end if
                                objRds.MoveNext    
                            Loop
                            objRds.movefirst()
                        end if
                            if not RS_OrderEarly.eof and 1 <> 1 then
                                while not RS_OrderEarly.EOF 
                                     pending=pending+1
                                    RS_OrderEarly.movenext()
                                wend
                                RS_OrderEarly.movefirst()
                            end if
                            %>
                    
						
						
				
				<div   class="col-md-4 column">
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
							<div id="results" style="display:none;"><%=completetotal%></div><div id="refreshspace">&nbsp;</div><div align="center" id="refresh" onclick="ReloadOrderList();" style="display:none;"><a href="#" class="btn btn-danger btn-xs">NEW ORDER - CLICK TO REFRESH</a></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
        <div id="order-refesh">
        <h1>Outstanding orders</h1>
        <!--<button  class="btn btn-primary btn-" >Earlier orders from today</button>      --> 
        <br />
        <h4>Items next to go out only</h4>
         
        <div  class="row clearfix">
        <div class="col-md-12 column"> 
           <div>
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
				
				    <% 
                            cnt=1                   
                       
      Do While NOT objRds.Eof
		

                            %>
                           <tr>
						    <td>
							     <%= objRds("id") %>
						    <br>

						    <%if lcase(objRds("paymenttype")&"")="stripe-paid"  or  objRds("paymenttype")="Paypal-Paid"  or objRds("PaymentType")="NoChex-Paid" or objRds("PaymentType")="Worldpay-Paid" or Ucase(objRds("Payment_status") & "")="PAID"  then%>
						        <span class="label label-success">PAID/CARD</span>
						    <%else%>
						        <span class="label label-danger">UNPAID/CASH</span>
						    <%end if%>
						    </td>
                               <%
                                     mintoadd = 0 
                                     deliveryTime = objRds("DeliveryTime") 
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
                                 <%  sUrlSearchPostCode = "https://www.google.co.uk/maps?q="&  objRds("Address") & "," & objRds("PostalCode")
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
			    <button class="btn btn-primary btn-" data-toggle="modal" data-target="#myModalorder" data-remote="order.asp?id_o=<%=objRds("id")%>&id_r=<%=Session("MM_id")%>">View Order</button>

    <!-- Modal -->
    <div class="modal fade" id="myModalorder" tabindex="-1" role="dialog" aria-labelledby="myModalLabelorder" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
      
          <div class="modal-body">
         </div>
      
        </div>
      </div>
    </div>		

    <% if (printingtype = "text" and UCase(SEND_ORDERS_TO_PRINTER) = "EPSON") then %>
         <a href="javascript::" onclick="UpdatePrintStatus(<%=objRds("id")%>,<%=Session("MM_id")%>,'online',this);" class="btn btn-default"">Print</a>                            
    <% elseIf UCase(SEND_ORDERS_TO_PRINTER) <> "EPSON" OR InStr(PrintingURL,"thanks.asp") < 1  Then %>
        <a href="javascript::" onclick="openWin('<%=PrintingURL %>?id_o=<%=objRds("id")%>&id_r=<%=Session("MM_id")%>&isPrint=Y')" class="btn btn-default"">Print</a>
    <% else %>
        <a href="javascript::" data-toggle="modal" data-id="<%= objRds("id") %>" data-target="#printModal"   class="btn btn-default aPrintButton">Print</a>
    <% end if %>
	
    <%if objRds("cancelled")=1 or objRds("acknowledged")=1  then%><%else%><button class="btn btn-primary btn-danger cancel" data-toggle="modal" data-target="#myModal" data-id=" <%= objRds("id") %>" data-email=" <%= objRds("email") %>" >Cancel</button>	<a href="../exe.asp?action=acknowledge&amp;id=<%=objRds("id")%>&amp;email=<%=objRds("email")%>&amp;page=outstanding-without-acknowledgement" class="btn btn-success"">Acknowledge</a><%end if%>
    <%if objRds("acknowledged")=1 then%>

    <%if objRds("outfordelivery")=0  then%>
  
    <%if objRds("deliverytype")="c" then%>

    <a href="../exe.asp?action=collected&amp;id=<%=objRds("id")%>&amp;email=<%=objRds("email")%>&amp;page=outstanding-without-acknowledgement" class="btn btn-success"">Collected</a>
    <%else%>
    <a href="../exe.asp?action=outfordelivery&amp;id=<%=objRds("id")%>&amp;email=<%=objRds("email")%>&amp;page=outstanding-without-acknowledgement" class="btn btn-success"">Out for delivery</a>
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
      
                            %>
				    </tbody>
			    </table>
			
		    </div>
	      </div>
        </div>

        <br />
        <!--<a name="payment_type" value="nochex" class="btn btn-primary col-md-12" style="width: 180px; padding: 8px">Items next to go out only</a>	-->	
         <div class="row clearfix" style="height: 1px;background-color: indianred;"></div>
        <br />
        
        
        <h4>Earlier orders from today</h4>
      
        <div id="divOrderList" class="row clearfix">
		    <div class="col-md-12 column">
            <div>
		
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
				
				    <% 
                            cnt=1                   
       dim mintoadd 
       dim deliveryTime 
      Do While NOT RS_OrderEarly.Eof
					

                            %>
                           <tr>
						    <td>
							     <%= RS_OrderEarly("id") %>
						    <br>

						    <%if RS_OrderEarly("paymenttype")="Stripe-Paid"  or  RS_OrderEarly("paymenttype")="Paypal-Paid"  or RS_OrderEarly("PaymentType")="NoChex-Paid" or RS_OrderEarly("PaymentType")="Worldpay-Paid" or Ucase(RS_OrderEarly("Payment_status") & "")="PAID"  then%>
						        <span class="label label-success">PAID/CARD</span>
						    <%else%>
						        <span class="label label-danger">UNPAID/CASH</span>
						    <%end if%>
						    </td>
                               <%
                                   mintoadd = 0 
                                   deliveryTime = RS_OrderEarly("DeliveryTime") 
                                    if  RS_OrderEarly("deliverydelay") & "" <> "" then
                                            vaveragedel = cint(RS_OrderEarly("deliverydelay"))
                                    end if
                                    if  RS_OrderEarly("collectiondelay") & "" <> "" then
                                            vaveragecol = cint(RS_OrderEarly("collectiondelay"))
                                    end if
                                    if RS_OrderEarly("asaporder") = "n" then
                                        if RS_OrderEarly("DeliveryType") = "d" then
                                            mintoadd=vaveragedel ' + 5 ' Add + 5 to match with front end
                                        else
                                            mintoadd=vaveragecol ' + 5 ' Add + 5 to match with front end
                                        end if
                                        deliveryTime = DateAdd("n",mintoadd,RS_OrderEarly("orderdate"))
                                    end if

                                    %>
                                <%  sUrlSearchPostCode = "https://www.google.co.uk/maps?q="&  RS_OrderEarly("Address") & "," & RS_OrderEarly("PostalCode")
                               if RS_OrderEarly("DeliveryLat") & "" <> "" then
                                sUrlSearchPostCode = "https://www.google.co.uk/maps/search/?api=1&query=" & RS_OrderEarly("DeliveryLat") & "," & RS_OrderEarly("DeliveryLng") 
                               end if
                               
                                %>
						    <td><span class="pull-right"><a href="<%=sUrlSearchPostCode %>" target="_blank"><%= RS_OrderEarly("PostalCode") %></a></span>
							     <b><%if RS_OrderEarly("DeliveryType")="d" then%><span style="color:#d9534f;">Delivery</span><%else%><span style="color:#5cb85c;">Collection</span><%end if%>: </b><%= deliveryTime %><br>
							    <small> Ordered on: <%= RS_OrderEarly("OrderDate") %>&nbsp;&nbsp;&nbsp;Order Value: <%=CURRENCYSYMBOL%><%=FormatNumber(RS_OrderEarly("OrderTotal"),2) %></small>
						    </td>
						    <td>
						    <%if RS_OrderEarly("cancelled")=1 then%>
						    <b>CANCELLED:</b><br>
						     <%= RS_OrderEarly("cancelleddate") %>
						    <%end if%>
					
						    <%if RS_OrderEarly("acknowledged")=1 and  RS_OrderEarly("outfordelivery")=0 then%>
						    <b>ACKNOWLEDGED:</b><br>
						     <%= RS_OrderEarly("acknowledgeddate") %>
						    <%end if%>
						
						    <%if RS_OrderEarly("acknowledged")=1 and  RS_OrderEarly("outfordelivery")=1 then%>
						    <%if RS_OrderEarly("DeliveryType")="c" then%>
						    <b>COLLECTED:</b><br>
						     <%= RS_OrderEarly("delivereddate") %>
						    <%else%>
						    <b>OUT FOR DELIVERY:</b><br>
						     <%= RS_OrderEarly("delivereddate") %>
						     <%end if%>
						    <%end if%>
						    </td>
						    <td>
						    <span class="pull-right">
			    <button class="btn btn-primary btn-" data-toggle="modal" data-target="#myModalorder" data-remote="order.asp?id_o=<%=RS_OrderEarly("id")%>&id_r=<%=Session("MM_id")%>">View Order</button>

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
    </script>
    <% If UCase(SEND_ORDERS_TO_PRINTER) <> "EPSON" OR InStr(PrintingURL,"thanks.asp") < 1 Then %>
        <a href="javascript::" onclick="openWin('<%=PrintingURL %>?id_o=<%=RS_OrderEarly("id")%>&id_r=<%=Session("MM_id")%>&isPrint=Y')" class="btn btn-default"">Print</a>
    <% else %>
        <a href="javascript::" data-toggle="modal" data-id="<%= RS_OrderEarly("id") %>" data-target="#printModal"   class="btn btn-default aPrintButton">Print</a>
    <% end if %>
	
    <%if RS_OrderEarly("cancelled")=1 or RS_OrderEarly("acknowledged")=1  then%><%else%><button class="btn btn-primary btn-danger cancel" data-toggle="modal" data-target="#myModal" data-id=" <%= RS_OrderEarly("id") %>" data-email=" <%= RS_OrderEarly("email") %>" >Cancel</button>	<a href="../exe.asp?action=acknowledge&amp;id=<%=RS_OrderEarly("id")%>&amp;email=<%=RS_OrderEarly("email")%>&amp;page=outstanding-without-acknowledgement" class="btn btn-success"">Acknowledge</a><%end if%>
    <%if RS_OrderEarly("acknowledged")=1 then%>

    <%if RS_OrderEarly("outfordelivery")=0 and 1 <> 1  then%>
    <% If UCase(SEND_ORDERS_TO_PRINTER) <> "EPSON" OR InStr(PrintingURL,"thanks.asp") < 1 Then %>
    <a href="javascript::" onclick="openWin('<%=PrintingURL %>?id_o=<%=RS_OrderEarly("id")%>&id_r=<%=Session("MM_id")%>&isPrint=Y')" class="btn btn-default"">Print</a>
    <% else %>
    <a href="javascript::" data-toggle="modal" data-id="<%= RS_OrderEarly("id") %>" data-target="#printModal"   class="btn btn-default aPrintButton">Print</a>
    <% end if %>
    <%if RS_OrderEarly("deliverytype")="c" then%>

    <a href="../exe.asp?action=collected&amp;id=<%=RS_OrderEarly("id")%>&amp;email=<%=RS_OrderEarly("email")%>&amp;page=outstanding-without-acknowledgement" class="btn btn-success"">Collected</a>
    <%else%>
    <a href="../exe.asp?action=outfordelivery&amp;id=<%=RS_OrderEarly("id")%>&amp;email=<%=RS_OrderEarly("email")%>&amp;page=outstanding-without-acknowledgement" class="btn btn-success"">Out for delivery</a>
    <%end if%>
    <%end if%>
     <%else%>

    <%end if%>
						    </td>
						
					    </tr>
                            <%
   
        RS_OrderEarly.MoveNext    
    Loop
                    
        RS_OrderEarly.Close
        set RS_OrderEarly = nothing
          objCon.Close
        set objCon = nothing
       ' objCon.Close
                            %>
				    </tbody>
			    </table>
			
		    </div>
	
    </div>
	
	    </div>
        </div>

<%
    Else 
        Response.Write("-1")
    End If
%>