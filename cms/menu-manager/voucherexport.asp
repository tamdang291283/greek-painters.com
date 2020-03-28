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
     Response.Addheader "Content-Disposition", "attachment; filename=voucher.xls"
   Response.ContentType = "application/vnd.ms-excel" 
   


				  objCon.Open sConnStringcms
                       objRds.Open "select vouchercode,vouchercodediscount,vouchertype,convert(varchar(10), startdate, 105)  as  startdate,convert(varchar(10), enddate, 105)  as enddate,MinimumAmount from vouchercodes where IdBusinessDetail=" & Session("MM_id")  , objCon

%>

              <table border="0" cellspacing="0" cellpadding="2">
                              <tr> 
                                <td><strong>Code</strong></td>
                                <td><strong>Discount(%)</strong></td>
                                <td><strong>Type</strong></td>
								<td><strong>Start Date</strong></td>
								<td><strong>End Date</strong></td>
								<td><strong>Minimum Amount</strong></td>
					
						
						<%

 Do While NOT objRds.Eof
 
 %>
 <tr>
 <td><%=objRds("vouchercode")%></td>
 <td><%=objRds("vouchercodediscount")%></td>
  <td><%=objRds("vouchertype")%></td>
   <td><%=objRds("startdate")%></td>
    <td><%=objRds("enddate")%></td>
	 <td><%=objRds("MinimumAmount")%></td>
 </tr>
 
 <%
 
   
                        objRds.MoveNext    
                        Loop
     objRds.close()
     set objRds =nothing
     objCon.close()
     set objCon = nothing
%>
 </td>
          </tr>
        </table>