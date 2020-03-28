<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../../Config.asp" -->
<!-- #include file="../timezone.asp" -->
<!-- #include file="../restaurantsettings.asp" -->

<%Server.ScriptTimeout=86400%>
<%
    function WriteCheck(byval strvalue)

    dim result 
        if strvalue = 1 then
            result = "checked"
        end if
    WriteCheck = result
end function
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
	<script type="text/javascript" src="../js/bootstrap.min.js?v=1"></script>
	<script src="../js/bootstrap-datepicker.min.js"></script>
	<script type="text/javascript" src="../js/scripts.js"></script>
	
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
<%

    if request.Form("startDate") & "" <> "" then
        sd=request.Form("startDate")
    elseif request.QueryString("startDate") & "" <> "" then
        sd=request.QueryString("startDate")   
    else
         sd=date()
    end if


    if request.Form("endDate") & "" <> "" then
        ed=request.Form("endDate")
    elseif request.QueryString("endDate") & "" <> "" then
        ed=request.QueryString("endDate")
    else
        ed=date()
    end if
    dim freetext : freetext = ""
 if  request.Form("freetext") & "" <> ""  then
        freetext = request.Form("freetext")
 elseif Request.QueryString("freetext") & "" <> "" then
         freetext = request.QueryString("freetext")               
 end if
%>
	<script>
        function ExportOrder()
        {
            location.href = "orderexport_taxtip.asp?start=" + $("#startDate").val() + "&end=" + $("#endDate").val() + "&freetext=" + $("#freetext").val();
        }

	</script>
<form class="form-inline mt20" id="searchform" method="post" action="history_taxtip_Edit.asp">
<div class="row clearfix">
<div class="col-md-2"><input type="text" class="form-control datepicker" id="startDate" name="startDate" placeholder="Start date" value="<%=sd%>" size="10">
</div>
<div class="col-md-2"><input type="text" class="form-control datepicker" id="endDate" name="endDate" placeholder="End date" value="<%=ed%>" size="10">
</div>
<div class="col-md-4"> <input type="text" class="form-control" id="freetext" name="freetext" placeholder="Free text" value="<%=freetext%>" size="30" data-toggle="tooltip" data-placement="left" title="This field searches for full/partial content in fields: order no, customer name, customer address, customer postcode">
</div>
<div class="col-md-2">    <button type="submit" class="btn btn-default btn-block">Lookup</button></div>
<div class="col-md-2"> <button type="button" class="btn btn-default btn-block" onclick="ExportOrder()"  style=" cursor:pointer;">Download</button></div>
</div>

</form>
 
<br>

<div class="row clearfix">
		<div class="col-md-12 column">
			<table  class="table table-hover table-condensed table-striped">
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
                        <th><div align="center">Tax</div></th>
						<th><div align="center">Tip</div></th>
						<th><div align="center">Delivery</div></th>
						<th><div align="center">Collection</div></th>
                        
						<th><div align="center">Card<br/>Debit | Credit</div></th>
						<th><div align="center">Cash</div></th>
						<th><div align="center">Cancelled</div></th>
                        <th><div align="center">Update</div></th>
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
				totalordercanceltax  = 0
                totalordercanceltip  = 0
                totalTax = 0
                totaltip = 0 
				' objRds.Close
                 '       objCon.Close
				  objCon.Open sConnStringcms



sql="SELECT * FROM ORDERS where (paymenttype='Stripe-Paid' or paymenttype = 'card' or paymenttype='Paypal-Paid' or paymenttype='NoChex-Paid' or paymenttype='Worldpay-Paid' or paymenttype='Cash on Delivery' or cancelled=1) and IdBusinessDetail=" & Session("MM_id") 

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


                '    Response.Write("freetext " & freetext & "<br/>")
if freetext & "" <>"" then

sql=sql & " AND  ([id] LIKE '%" & freetext& "%' or [id] LIKE '%" & freetext & "%' or ([firstname] + ' ' + [lastname]) LIKE '%" & freetext& "%' or [postalcode] LIKE '%" & freetext& "%' or [address] LIKE '%" & freetext & "%')"

end if

sql = sql & " ORDER BY OrderDate desc"

  
'	 response.write sql 
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
                            dim TotalCard,TotalCancelCard
                            dim TotalCredit,TotalCancelCredit
                            Dim TotalDebit, TotalCancelDebit
                             dim OrderTotal, SubTotal ,SumSubTotal,SumSubTotalCancel
                        Do While NOT objRds.Eof
                            SubTotal = objRds("SubTotal") +  objRds("ShippingFee")    
                            SumSubTotal = SumSubTotal + SubTotal
                            OrderTotal = SubTotal +  objRds("Tax_Amount") + objRds("Tip_Amount")
						if objRds("deliverytype")="d" then
						         totalorderdelivery=totalorderdelivery+OrderTotal
						    if objRds("cancelled")= 1 then
						    totalordercancelleddelivery=totalordercancelleddelivery+OrderTotal
						    end if
						end if
						if objRds("deliverytype")="c" then
						    totalordercollection=totalordercollection+OrderTotal
						    if objRds("cancelled")= 1 then
						    totalordercancelledcollection=totalordercancelledcollection+OrderTotal
						    end if
						end if
						if objRds("paymenttype")<>"Cash on Delivery" then
						    totalordercard=totalordercard+OrderTotal
						    if objRds("cancelled")= 1 then
						    totalordercancelledcard=totalordercancelledcard+OrderTotal
						    end if
						end if
						if objRds("paymenttype")="Cash on Delivery" and objRds("Card_Debit") = 0 and objRds("Card_Credit") = 0 then
						    totalordercash=totalordercash+OrderTotal
						    if objRds("cancelled")= 1 then
						    totalordercancelledcash=totalordercancelledcash+OrderTotal
						    end if
						end if
						if objRds("cancelled")= 1 then
						    totalordercancelled=totalordercancelled+OrderTotal
						end if

						totalorder=totalorder+OrderTotal
                        totaltax = totaltax + objRds("Tax_Amount")
                        totaltip  = totaltip + objRds("Tip_Amount")
                        if objRds("cancelled")= 1 then
                                totalordercanceltax  =totalordercanceltax +  objRds("Tax_Amount")
                                totalordercanceltip = totalordercanceltip + objRds("Tip_Amount")
                        end if
                        if objRds("Card_Debit") = 1 or objRds("Card_Credit") = 1 then
                            TotalCard = TotalCard + OrderTotal
                            if objRds("cancelled")=1 then
                                TotalCancelCard  = TotalCancelCard + OrderTotal
                            end if    
                        end if
                        if objRds("Card_Debit") = 1  then
                            TotalDebit = TotalDebit + OrderTotal
                            if objRds("cancelled")=1 then
                                TotalCancelDebit  = TotalCancelDebit + OrderTotal
                            end if  
                        end if
                        if objRds("Card_Credit")  = 1 then
                            TotalCredit =  TotalCredit +  OrderTotal
                            if objRds("cancelled")=1 then
                                TotalCancelCredit  = TotalCancelCredit + OrderTotal
                            end if  
                        end if
						orders=orders+1
						if cnt>=startrecord and cnt<=endrecord then
						
						
						ordersonpage=ordersonpage+1
                        %>
                       <tr>
            
					   <td> <%=formatDateTimeC(objRds("OrderDate"))%></td>
						<td>
						<a href="javascript:;"  data-toggle="modal" data-target="#myModalorder" data-remote="../dashboards/order.asp?id_o=<%=objRds("id")%>&id_r=<%=Session("MM_id")%>">
                        <%=objRds("id")%>
                        </a>
						</td>
						<td><div align="center"><%=CURRENCYSYMBOL%><%=FormatNumber(OrderTotal,2) %></div></td>
                        <td><div align="center"><%=CURRENCYSYMBOL%><%=FormatNumber(objRds("Tax_Amount"),2) %></div></td>
                        <td><div align="center"><input type="text" style="width:50px;" name="Tip_Amount<%=objRds("id") %>" oldvalue ="<%=objRds("Tip_Amount") %>" value="<%=objRds("Tip_Amount") %>" /> </div></td>
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

						<td>
						<div align="center"><input type="radio" <%=WriteCheck(objRds("Card_Debit")) %> name="Card_<%=objRds("id") %>" value="D" />Debit | <input value="C" type="radio" <%=WriteCheck(objRds("Card_Credit")) %> name="Card_<%=objRds("id") %>" />Credit</div>
						</td>
					<td><%if objRds("paymenttype")="Cash on Delivery" and objRds("Card_Debit") = 0 and objRds("Card_Credit") = 0 then
					%>
						<div align="center"><input type="radio" checked="checked" name="Cash_<%=objRds("id") %>" value="Cash" /></div>
                        <%else %>
                        <div align="center"><input type="radio"  name="Card_<%=objRds("id") %>" value="Cash" /></div>
						<%end if%></td>
						<td><%if objRds("cancelled")= 1 then
					%>
						<div align="center"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span></div>
						<%end if%></td>
                           <td><input type="button" value="Update" onclick="UpdateOrder(<%=objRds("id")%>)"/></td>
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
                        <td><div align="center" class="lead"><%=CURRENCYSYMBOL%><%=FormatNumber(totaltax,2) %><br>
							<small>(avg: <%=FormatNumber(totaltax/orders,2)%>)</small></div>
						</td>
                        <td><div align="center" class="lead"><%=CURRENCYSYMBOL%><%=FormatNumber(totaltip,2) %><br>
							<small>(avg: <%=FormatNumber(totaltip/orders,2)%>)</small></div>
						</td>
						<td><div align="center" class="lead"><%=CURRENCYSYMBOL%><%=FormatNumber(totalorderdelivery,2) %><br>
							<small>(<%=FormatNumber(totalorderdelivery/(totalorder/100),2)%>%)</small></div>
						
							
						</td>
						<td><div align="center" class="lead"><%=CURRENCYSYMBOL%><%=FormatNumber(totalordercollection,2) %><br>
							<small>(<%=FormatNumber(totalordercollection/(totalorder/100),2)%>%)</small></div>
						
							
						</td>
						<td>
						 <div align="center" class="lead">
                             <table style="width:100%">
                                    <tr style="border-bottom:1px solid black;"><td colspan="2"><div align="center"><%=CURRENCYSYMBOL %><%=FormatNumber(TotalCard,2) %></div></td></tr>
                                    <tr><td style="width:50%;border-right:1px solid black;">
                                            
                                            <div align="center"><%=CURRENCYSYMBOL %><%=FormatNumber(TotalDebit,2) %></div>
                                            
                                        </td>
                                   <td>
                                        <div align="center"><%=CURRENCYSYMBOL %><%=FormatNumber(TotalCredit,2) %></div>
                                   </td>

                                    </tr>
                                </table>                            
                          	</div>				
							
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
                        <td><div align="center" class="lead"><%=CURRENCYSYMBOL%><%=FormatNumber(totalordercanceltax,2) %></div></td>
                         <td><div align="center" class="lead"><%=CURRENCYSYMBOL%><%=FormatNumber(totalordercanceltip,2) %></div></td>
						<td><div align="center" class="lead"><%=CURRENCYSYMBOL%><%=FormatNumber(totalordercancelleddelivery,2) %></div>
						</td>
						<td><div align="center" class="lead"><%=CURRENCYSYMBOL%><%=FormatNumber(totalordercancelledcollection,2) %></div>
						</td>
						<td>
						<div align="center" class="lead">
                             <table style="width:100%">
                                    <tr style="border-bottom:1px solid black;"><td colspan="2"><div align="center"><%=CURRENCYSYMBOL %><%=FormatNumber(TotalCancelCard,2) %></div></td></tr>
                                    <tr><td style="width:50%;border-right:1px solid black;">
                                            
                                            <div align="center"><%=CURRENCYSYMBOL %><%=FormatNumber(TotalCancelDebit,2) %></div>
                                            
                                        </td>
                                   <td>
                                        <div align="center"><%=CURRENCYSYMBOL %><%=FormatNumber(TotalCancelCredit,2) %></div>
                                   </td>

                                    </tr>
                                </table>      
						</div>
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
							<td><div align="center" class="lead"><%=CURRENCYSYMBOL%><%=FormatNumber(totalorder-totalordercancelled,2) %></div></td>
                        <td><div align="center" class="lead"><%=CURRENCYSYMBOL%><%=FormatNumber(totaltax-totalordercanceltax,2) %></div></td>
                        <td><div align="center" class="lead"><%=CURRENCYSYMBOL%><%=FormatNumber(totaltip-totalordercanceltip,2) %></div></td>
						<td><div align="center" class="lead"><%=CURRENCYSYMBOL%><%=FormatNumber(totalorderdelivery-totalordercancelleddelivery,2) %></div>
						
							
						</td>
						<td><div align="center" class="lead"><%=CURRENCYSYMBOL%><%=FormatNumber(totalordercollection-totalordercancelledcollection,2) %></div>
						
							
						</td>
						<td>
						    <div align="center" class="lead">
                             <table style="width:100%">
                                    <tr style="border-bottom:1px solid black;"><td colspan="2"><div align="center"><%=CURRENCYSYMBOL %><%=FormatNumber(TotalCard -  TotalCancelCard,2) %></div></td></tr>
                                    <tr><td style="width:50%;border-right:1px solid black;">
                                            
                                            <div align="center"><%=CURRENCYSYMBOL %><%=FormatNumber(TotalDebit - TotalCancelDebit,2) %></div>
                                            
                                        </td>
                                   <td>
                                        <div align="center"><%=CURRENCYSYMBOL %><%=FormatNumber(TotalCredit -  TotalCancelCredit,2) %></div>
                                   </td>

                                    </tr>
                                </table>      
						</div>
							
							
						</td>
					<td>
						
							<div align="center" class="lead"><%=CURRENCYSYMBOL%><%=FormatNumber(totalordercash-totalordercancelledcash,2) %></div>
						</td>
						<td>
						
							<div align="center" class="lead"><%=CURRENCYSYMBOL%><%=FormatNumber(totalordercancelled-totalordercancelled,2) %></div>
						</td>
                        <td></td>
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
<li><a href="history_taxtip_Edit.asp?freetext=<%=freetext%>&startDate=<%=sd%>&endDate=<%=ed%>&page=<%=1%>" class="">1</a>.....</li>
<%end if%>


<%
for g=1 to round(abs((totalrecords/pagesize))+0.5)%>
<%if abs(page)>abs(g)-10 and abs(page)<abs(g)+10 then%>
<li class="<%if abs(page)=abs(g) then%>active<%else%><%end if%>"><a href="history_taxtip_Edit.asp?freetext=<%=freetext%>&startDate=<%=sd%>&endDate=<%=ed%>&page=<%=g%>" ><%=g%></a></li><%end if%><%next%><%
if abs(page)<round(abs((totalrecords/pagesize))+0.5)-10 then%>
<li>...<a href="history_taxtip_Edit.asp?freetext=<%=freetext%>&startDate=<%=sd%>&endDate=<%=ed%>&page=<%=round(abs((totalrecords/pagesize))+0.5)%>" class=""><%=round(abs((totalrecords/pagesize))+0.5)%></a></li>
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


<script type="text/javascript">
    function IsInvalidTip(str)
    {
        var patt = new RegExp(/^(\d*\.)?\d+$/);
        var res = patt.test(str);
        return res;
    }
    function UpdateOrder(OrderID)
    {
        var card = "";
        var oldtipvalue = $("[name=Tip_Amount"+OrderID+"]").attr("oldvalue");
        var edittip  = "n";
        if(oldtipvalue != $("[name=Tip_Amount"+OrderID+"]").val())
            edittip = "y";
        if($("[name=Card"+OrderID+"]").lengh > 0)
            card =  $("[name=Card"+OrderID+"]").val();
        if(!IsInvalidTip( $("[name=Tip_Amount"+OrderID+"]").val()))
        {
            alert("The tip must be a positive number.");
            return false;
        }
    $.ajax({
        url: "UpdateOrder_tip.asp?edittip=" + edittip + "&oid=" + OrderID + "&tip=" + $("[name=Tip_Amount"+OrderID+"]").val() + "&Card=" + $("[name=Card_"+OrderID+"]:checked").val() + "&r" + Math.random()

      })
    .done(function (data) {
        if (data == "OK"){
            alert("Updated succesfully!");
            location.reload();
        }
            
        else
            alert("Updated fail!");
        
    });

  }

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

</body>
</html>
