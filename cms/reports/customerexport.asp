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
                     sql = "SELECT DISTINCT Orders.Email, Orders.FirstName, Orders.LastName, Orders.Phone, Orders.Address, Orders.PostalCode, Orders.IdBusinessDetail, count(orders.ID) as numberorder FROM Orders  " 
                    sql=sql&"  WHERE Orders.Email<>'' AND Orders.IdBusinessDetail="& Session("MM_id") 
                    sql=sql & " group by Orders.Email, Orders.FirstName, Orders.LastName, Orders.Phone, Orders.Address, Orders.PostalCode, Orders.IdBusinessDetail " 
                    sql=sql & " order by Orders.FirstName"

                       objRds.Open sql  , objCon

%>

              <table border="0" cellspacing="0" cellpadding="2">
                              <tr> 
                                <td><strong>Email</strong></td>
                                <td><strong>FirstName</strong></td>
                                <td><strong>LastName</strong></td>
								<td><strong>Phone</strong></td>
								<td><strong>Address</strong></td>
								<td><strong>PostalCode</strong></td>
					            <td><strong>Orders</strong></td>
						
						<%

 Do While NOT objRds.Eof
 
 %>
 <tr>
 <td><%=objRds("email")%></td>
 <td><%=objRds("firstname")%></td>
  <td><%=objRds("LastName")%></td>
   <td><%=objRds("Phone")%></td>
    <td><%=objRds("Address")%></td>
	 <td><%=objRds("PostalCode")%></td>
     <td><%=objRds("numberorder")%></td>
 </tr>
 
 <%
 
   
                        objRds.MoveNext    
                        Loop
                        objRds.close()
                    set objRds = nothing
                    objCon.close()
                set objCon = nothing
%>
 </td>
          </tr>
        </table>