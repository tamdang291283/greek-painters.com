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
   'Response.Buffer = FALSE
   Response.Buffer = TRUE
   Response.Addheader "Content-Disposition", "attachment; filename=download.xls"
   Response.ContentType = "application/vnd.ms-excel" 
      objCon.Open sConnStringcms
    dim sql : sql =""
      sql = sql & "SELECT * FROM  view_paid_orders where IdBusinessDetail=" & Session("MM_id")
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
        sql=sql & " AND  [OrderDate] >='" & startdate_sql & " 00:00:01" & "'"
        
    end if
    dim enddate_day,enddate_month,enddate_year,enddate_sql
    if ed & "" <> "" then
        sss=split(ed,"/")
        enddate_day=sss(0)
        enddate_month=sss(1)
        enddate_year=sss(2)
        
        enddate_sql=  enddate_month  & "/" & enddate_day & "/" &  enddate_year        
        sql=sql & " AND  [OrderDate]<='" & enddate_sql & " 23:59:59" & "'"
    end if

    if request.querystring("freetext")<>"" then
        sql=sql & " AND  ([id] LIKE '%" & request.querystring("freetext") & "%' or [id] LIKE '%" & request.querystring("freetext") & "%' or ([firstname] + ' ' + [lastname]) LIKE '%" & request.querystring("freetext") & "%' or [postalcode] LIKE '%" & request.querystring("freetext") & "%' or [address] LIKE '%" & request.querystring("freetext") & "%')"
    end if
    sql = sql & " ORDER BY OrderDate desc"

    'Response.Write(sql)
      objRds.Open sql  , objCon

%>

    <table border="0" cellspacing="0" cellpadding="2">
                              <tr> 
                                <td><strong>Order Date.</strong></td>
                                <td><strong>Order No.</strong></td>
                                <td><strong>Total</strong></td>
								<td><strong>Delivery</strong></td>
                                <td><strong>Collection</strong></td>
								<td><strong>Card</strong></td>
								<td><strong>Cash</strong></td>
                                 <td><strong>Cancelled</strong></td>
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
    CURRENCYSYMBOL                        = replace(CURRENCYSYMBOL,CURRENCYSYMBOL,"&#163;") 
if not objRds.EOF then
 Do While NOT objRds.Eof
 
 %>
 <tr>
     <td><%="=""" & formatDateTimeC(objRds("OrderDate")) & """" %></td>
     <td><%=objRds("id")%></td>
    <td><%=CURRENCYSYMBOL %><%=FormatNumber(objRds("OrderTotal"),2) %></td>    
    <td><% if objRds("deliverytype")="d" then %>Yes<%end if %></td>
     <td><%if objRds("deliverytype") = "c" then%>Yes<% end if %></td>
    <td><%if objRds("paymenttype")<>"Cash on Delivery" then%>
		    <%=Replace( objRds("paymenttype"),"-Paid","") %>
		<%end if%>
    </td>
    <td><%if objRds("paymenttype")="Cash on Delivery" then%>Cash<%end if%></td>
    <td><%if objRds("cancelled")=1 then%>Yes<%else %>No<%end if %></td>
   
 </tr>
 
 <%
 
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

                        objRds.MoveNext    
                        Loop
     %>
        <tr>
					   <td><strong>TOTAL</strong></td>
						<td></td>
					    <td><%=CURRENCYSYMBOL%><%=FormatNumber(totalorder,2) %><br />
							(avg: <%=FormatNumber(totalorder/orders,2)%>)</td>
						<td><%=CURRENCYSYMBOL%><%=FormatNumber(totalorderdelivery,2) %><br />
							<%=FormatNumber(totalorderdelivery/(totalorder/100),2)%>%</td>
						<td><%=CURRENCYSYMBOL%><%=FormatNumber(totalordercollection,2) %><br />
							<%=FormatNumber(totalordercollection/(totalorder/100),2)%>%
						</td>
						<td>
						<%=CURRENCYSYMBOL%><%=FormatNumber(totalordercard,2) %><br />
							<%=FormatNumber(totalordercard/(totalorder/100),2)%>%</td>
					<td><%=CURRENCYSYMBOL%><%=FormatNumber(totalordercash,2) %><br />
							<%=FormatNumber(totalordercash/(totalorder/100),2)%>%
						</td>
						<td><%=CURRENCYSYMBOL%><%=FormatNumber(totalordercancelled,2) %><br />
							<%=FormatNumber(totalordercancelled/(totalorder/100),2)%>%
						</td>
					</tr>
					
					
					<tr>
					   <td><strong>CANCELLED</strong></td>
						<td></td>
				        <td><%=CURRENCYSYMBOL%><%=FormatNumber(totalordercancelled,2) %></td>
						<td><%=CURRENCYSYMBOL%><%=FormatNumber(totalordercancelleddelivery,2) %></td>
						<td><%=CURRENCYSYMBOL%><%=FormatNumber(totalordercancelledcollection,2) %></td>
						<td><%=CURRENCYSYMBOL%><%=FormatNumber(totalordercancelledcard,2) %></td>
					    <td><%=CURRENCYSYMBOL%><%=FormatNumber(totalordercancelledcash,2) %></td>
						<td><%=CURRENCYSYMBOL%><%=FormatNumber(totalordercancelled,2) %>
						</td>
					</tr>
					
					
					
					
					
					
					
					
					<tr>
					    <td><strong>NET TOTAL</strong></td>
						<td></td>
					    <td><%=CURRENCYSYMBOL%><%=FormatNumber(totalorder-totalordercancelled,2) %></td>
						<td><%=CURRENCYSYMBOL%><%=FormatNumber(totalorderdelivery-totalordercancelleddelivery,2) %></td>
						<td><%=CURRENCYSYMBOL%><%=FormatNumber(totalordercollection-totalordercancelledcollection,2) %></td>
						<td><%=CURRENCYSYMBOL%><%=FormatNumber(totalordercard-totalordercancelledcard,2) %></td>
					    <td><%=CURRENCYSYMBOL%><%=FormatNumber(totalordercash-totalordercancelledcash,2) %></td>
						<td><%=CURRENCYSYMBOL%><%=FormatNumber(totalordercancelled-totalordercancelled,2) %></td>
					</tr>

        <%
end if
     objRds.close()
     set objRds = nothing
     objCon.close()
     set objCon = nothing
%>

        </table>