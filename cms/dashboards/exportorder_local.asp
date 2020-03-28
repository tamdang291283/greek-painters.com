<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../../Config.asp" -->
<!-- #include file="../timezone.asp" -->
<!-- #include file="../restaurantsettings.asp" -->

<%Server.ScriptTimeout=86400%>

<%
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
   Response.Buffer = TRUE
  Response.Addheader "Content-Disposition", "attachment; filename=download.xls"
  Response.ContentType = "application/vnd.ms-excel" 
    objCon.Open sConnStringcms
    dim sql : sql =""
         sql = sql & "SELECT * FROM ORDERSlocal  where (paymenttype='Stripe-Paid' or paymenttype='Paypal-Paid' or paymenttype='NoChex-Paid' or paymenttype='Worldpay-Paid' or paymenttype='Cash on Delivery' or cancelled=1) and  IdBusinessDetail=" & Session("MM_id")
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
        sql=sql & " AND  ([id] LIKE '%" & request.querystring("freetext") & "%' or [id] LIKE '%" & request.querystring("freetext") & "%' )"
    end if
    sql = sql & " ORDER BY OrderDate desc"

        CURRENCYSYMBOL                        = Server.HTMLEncode(CURRENCYSYMBOL)
      objRds.Open sql  , objCon
     %>
  <table border="0" cellspacing="0" cellpadding="2">
                              <tr> 
                                <td><strong>Order Date.</strong></td>
                                <td><strong>Order No.</strong></td>
                                <td><strong>Total</strong></td>							
								<td><strong>Card</strong></td>
								<td><strong>Cash</strong></td>
                                <td><strong>Cancelled</strong></td>
					            </tr>
      <%
                    Do While NOT objRds.Eof
					
					
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
						'if cnt>=startrecord and cnt<=endrecord then
						%>
                             <tr>
                                 <td><%=formatDateTimeC(objRds("OrderDate")) %></td>
                                 <td><%=objRds("id")%></td>
                                <td><%=CURRENCYSYMBOL %><%=FormatNumber(objRds("OrderTotal"),2) %></td>    
                              
                                <td><%if objRds("paymenttype")<>"Cash on Delivery" then%>
		                                <%=Replace( objRds("paymenttype"),"-Paid","") %>
		                            <%end if%>
                                </td>
                                <td><%if objRds("paymenttype")="Cash on Delivery" then%>Cash<%end if%></td>
                                <td><%if objRds("cancelled")=1 then%>Yes<%else %>No<%end if %></td>
   
                             </tr>
                        <%
						
						    ordersonpage=ordersonpage+1
                       ' end if
                        	cnt=cnt+1
                            objRds.MoveNext    
                        Loop
                           dim avgorder : avgorder = 0
                            if  orders > 0 then
                                avgorder = totalorder/orders
                            end if

                             dim avgordercard : avgordercard = 0
                            if  totalorder > 0 then
                               avgordercard = totalordercard/(totalorder/100)
                            end if
                             dim avgordercash : avgordercash = 0
                            if  totalorder > 0 then
                               avgordercash = totalordercash/(totalorder/100)
                            end if
                             dim avgordercancel : avgordercancel = 0
                             if  totalorder > 0 then
                               avgordercancel = totalordercancelled/(totalorder/100)
                            end if
                            %>
                                  <tr>
					   <td style="vertical-align:top;"><strong>TOTAL</strong></td>
						<td></td>
					    <td><%=CURRENCYSYMBOL%><%=FormatNumber(totalorder,2) %><br />
							(avg: <%=FormatNumber(avgorder,2)%>)</td>
						<td>
						<%=CURRENCYSYMBOL%><%=FormatNumber(totalordercard,2) %><br />
							<%=FormatNumber(avgordercard,2)%>%</td>
					<td><%=CURRENCYSYMBOL%><%=FormatNumber(totalordercash,2) %><br />
							<%=FormatNumber(avgordercash,2)%>%
						</td>
						<td><%=CURRENCYSYMBOL%><%=FormatNumber(totalordercancelled,2) %><br />
							<%=FormatNumber(avgordercancel,2)%>%
						</td>
					</tr>
					
					
					

                            <%
                        objRds.Close
                        set objRds = nothing
                        objCon.Close
                        set objCon = nothing

           %>
      </table>