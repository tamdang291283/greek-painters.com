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

   'Change HTML header to specify Excel's MIME content type.
   Response.Buffer = FALSE
   Response.Buffer = TRUE
   Response.Addheader "Content-Disposition", "attachment; filename=download.xls"
   Response.ContentType = "application/vnd.ms-excel" 
      objCon.Open sConnStringcms
    dim sql : sql =""
      sql = sql & "SELECT * FROM ORDERS where (paymenttype='Stripe-Paid' or paymenttype = 'card'  or paymenttype='Paypal-Paid' or paymenttype='NoChex-Paid' or paymenttype='Worldpay-Paid' or paymenttype='Cash on Delivery' or cancelled=1) and IdBusinessDetail=" & Session("MM_id")
    dim sd,ed
    sd =  Request.QueryString("start")
    ed  = Request.QueryString("end")
    dim sss,startdate_day,startdate_month,startdate_year
    if sd & "" <> "" then
        sss=split(sd,"/")
        startdate_day=sss(0)
        startdate_month=sss(1)
        startdate_year=sss(2)
        startdate_sql=  startdate_month  & "/" & startdate_day & "/" & startdate_year  
        sql=sql & " AND  [OrderDate] >=#" & startdate_sql & " 00:00:01" & "#"
        
    end if
    dim enddate_day,enddate_month,enddate_year,enddate_sql
    if ed & "" <> "" then
        sss=split(ed,"/")
        enddate_day=sss(0)
        enddate_month=sss(1)
        enddate_year=sss(2)
        
        enddate_sql=  enddate_month  & "/" & enddate_day & "/" &  enddate_year        
        sql=sql & " AND  [OrderDate]<=#" & enddate_sql & " 23:59:59" & "#"
    end if

    if request.querystring("freetext")<>"" then
        sql=sql & " AND  ([id] LIKE '%" & request.querystring("freetext") & "%' or [id] LIKE '%" & request.querystring("freetext") & "%' or ([firstname] + ' ' + [lastname]) LIKE '%" & request.querystring("freetext") & "%' or [postalcode] LIKE '%" & request.querystring("freetext") & "%' or [address] LIKE '%" & request.querystring("freetext") & "%')"
    end if
    sql = sql & " ORDER BY OrderDate desc"


      objRds.Open sql  , objCon

%>

    <table border="0" cellspacing="0" cellpadding="2">
                              <tr> 
                                <th><div><strong>Order Date.</strong></div></th>
                                <th><div><strong>Order No.</strong></div></th>

                               <th style="text-align:right"><div align="center">Total<br/>Subtotal + tax + tip</div></th>
                                <th style="text-align:right"><div align="center">SubTotal<br/>Order Value + Delivery Fee</div></th>
                                <th  style="text-align:right"><div align="center">Tax</div></th>
						        <th  style="text-align:right"><div align="center">Tip</div></th>
						        <th><div align="center">Delivery</div></th>
						        <th><div align="center">Collection</div></th>                        
						        <th><div align="center">Card<br/>Debit | Credit</div></th>
						        <th><div align="center">Cash</div></th>
						        <th><div align="center">Cancelled</div></th>
					            </tr>
						
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
    'CURRENCYSYMBOL = replace(CURRENCYSYMBOL,CURRENCYSYMBOL,"&#163;") 
    CURRENCYSYMBOL                        = Server.HTMLEncode(CURRENCYSYMBOL)

if not objRds.EOF then
 Do While NOT objRds.Eof
                        
    dim TotalCard,TotalCancelCard
    dim TotalCredit,TotalCancelCredit
    Dim TotalDebit, TotalCancelDebit
    dim OrderTotal, SubTotal ,SumSubTotal,SumSubTotalCancel
    SubTotal = objRds("SubTotal") +  objRds("ShippingFee")    
    SumSubTotal = SumSubTotal + SubTotal
    OrderTotal = SubTotal +  objRds("Tax_Amount") + objRds("Tip_Amount")

 %>
 <tr>
     <td><%=formatDateTimeC(objRds("OrderDate")) %></td>
     <td  style="text-align:center"><%=objRds("id")%></td>
    <td  style="text-align:center"><%=CURRENCYSYMBOL %><%=FormatNumber(OrderTotal,2) %></td>   
     <td  style="text-align:center"><%=CURRENCYSYMBOL %><%=FormatNumber(SubTotal,2) %></td>   
    <td  style="text-align:center"><%=CURRENCYSYMBOL %><%=FormatNumber(objRds("Tax_Amount"),2) %></td>  
     <td  style="text-align:center"><%=CURRENCYSYMBOL %><%=FormatNumber(objRds("Tip_Amount"),2) %></td>    
    <td style="text-align:center"><% if objRds("deliverytype")="d" then %>Yes<%end if %></td>
    <td style="text-align:center"><%if objRds("deliverytype") = "c" then%>Yes<% end if %></td>
    <td>
         <% if objRds("Card_Debit") = 1 or objRds("Card_Credit") = 1 then  %>
            <table style="width:100%">
                <tr style="border-bottom:1px solid black;border-top:1px solid black;text-align:center"><td colspan="2">Yes</td></tr>
                <tr><td style="width:50%;border-right:1px solid black;border-top:1px solid black;">
                        <% if objRds("Card_Debit") = 1 then %>Yes<%else %>No<% end if %>
                    </td>
                <td style="border-top:1px solid black;">
                    <% if objRds("Card_Credit")  = 1 then %>Yes<%else %>No<% end if %>
                </td>

                </tr>
            </table>
        <% end if %>
    </td>
    <td style="text-align:center"><%if objRds("paymenttype")="Cash on Delivery" and objRds("Card_Debit") = 0 and objRds("Card_Credit") = 0   then%>Cash<%end if%></td>
    <td style="text-align:center"><%if objRds("cancelled")= 1 then%>Yes<%else %>No<%end if %></td>
   
 </tr>
 
 <%
  
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
        if objRds("cancelled")= 1 then
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

                        objRds.MoveNext    
                        Loop
     %>
       <tr>
					   <td> <div class="lead"><strong>TOTAL</strong></div></td>
						<td>
						
							
						</td>
							<td style="text-align:center"><div class="lead"><%=CURRENCYSYMBOL%><%=FormatNumber(totalorder,2) %><br>
							<small>(avg: <%=FormatNumber(totalorder/orders,2)%>)</small></div>
						</td>
                        <td style="text-align:center"><div><%=CURRENCYSYMBOL%><%=FormatNumber(SumSubTotal,2) %><br />
                            <small>(avg: <%=FormatNumber(SumSubTotal/orders,2)%>)</small></div>
                            

                        </td>
            
                        <td style="text-align:center"><div  class="lead"><%=CURRENCYSYMBOL%><%=FormatNumber(totaltax,2) %><br>
							<small>(avg: <%=FormatNumber(totaltax/orders,2)%>)</small></div>
						</td>
                        <td style="text-align:center"><div  class="lead"><%=CURRENCYSYMBOL%><%=FormatNumber(totaltip,2) %><br>
							<small>(avg: <%=FormatNumber(totaltip/orders,2)%>)</small></div>
						</td>
						<td style="text-align:center"><div  class="lead"><%=CURRENCYSYMBOL%><%=FormatNumber(totalorderdelivery,2) %><br>
							<small>(<%=FormatNumber(totalorderdelivery/(totalorder/100),2)%>%)</small></div>
						
							
						</td>
						<td style="text-align:center"><div class="lead"><%=CURRENCYSYMBOL%><%=FormatNumber(totalordercollection,2) %><br>
							<small>(<%=FormatNumber(totalordercollection/(totalorder/100),2)%>%)</small></div>
						
							
						</td>
						<td>
						 <div align="center" class="lead">
                             <table style="width:100%">
                                    <tr style="border-bottom:1px solid black;"><td colspan="2"><div align="center"><%=CURRENCYSYMBOL %><%=FormatNumber(TotalCard,2) %></div></td></tr>
                                    <tr><td style="width:50%;border-right:1px solid black;border-top:1px solid black;">
                                            
                                            <div align="center"><%=CURRENCYSYMBOL %><%=FormatNumber(TotalDebit,2) %></div>
                                            
                                        </td>
                                   <td style="border-top:1px solid black;">
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
                                    <tr>
                                        <td style="width:50%;border-right:1px solid black;border-top:1px solid black;">
                                            
                                            <div align="center"><%=CURRENCYSYMBOL %><%=FormatNumber(TotalCancelDebit,2) %></div>
                                            
                                        </td>
                                   <td style="1px solid black;border-top:1px solid black;">
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
                                    <tr><td style="width:50%;border-right:1px solid black;border-top:1px solid black;">
                                            
                                            <div align="center"><%=CURRENCYSYMBOL %><%=FormatNumber(TotalDebit - TotalCancelDebit,2) %></div>
                                            
                                        </td>
                                   <td style="1px solid black;border-top:1px solid black;">
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

        <%
end if
     objRds.close()
     set objRds = nothing
     objCon.close()
     set objCon = nothing
%>

        </table>