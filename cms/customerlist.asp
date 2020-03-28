<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../Config.asp" -->
<!-- #include file="timezone.asp" -->
<!-- #include file="restaurantsettings.asp" -->

<%Server.ScriptTimeout=86400%>
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers=""
MM_authFailedURL="index.asp?e=2"
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
	
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">
<link href="css/bootstrap-datepicker.min.css" rel="stylesheet">
  <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
  <![endif]-->

  <!-- Fav and touch icons -->
   <% If FAVICONURL & "" <> "" Then %> <link rel='shortcut icon' href='<%=FAVICONURL %>' type='image/x-icon'/ > <% end If %>
  
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	<script src="js/bootstrap-datepicker.min.js"></script>
	<script type="text/javascript" src="js/scripts.js"></script>
	
	
</head>

<body>
<div class="container">
	 <!-- #Include file="inc-header.inc"-->
    <div class="row">
        <div class="col-md-6">
            
             <h3><a href="customerdownload.asp" target="_blank">Download Customer List</a></h3>
        </div>
    </div>
    
<div class="row clearfix">


		<div class="col-md-12 column">

				<% 
				 objRds.Close
                        objCon.Close
				  objCon.Open sConnStringcms

	 'response.write sql 
sql = "SELECT DISTINCT Orders.Email, Orders.FirstName, Orders.LastName, Orders.Phone, Orders.Address, Orders.PostalCode, Orders.IdBusinessDetail FROM Orders WHERE Orders.Email<>'' AND Orders.IdBusinessDetail="& Session("MM_id") & " order by Orders.FirstName"
                        
objRds.Open  SQL , objCon,1


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
customersonpage=0
customers=0

                    %>
            	<table class="table table-hover table-condensed table-striped">
				<thead>
					<tr>
					    <th><div align="left">Email</div></th>
						<th><div align="left">First Name</div></th>
						<th><div align="left">Last Name</div></th>
						<th><div align="left">Phone Number</div></th>
						<th><div align="left">Address</div></th>
						<th><div align="left">Postal Code</div></th>
						<!--<th><div align="left">Bussiness Card Detail</div></th>-->
						
					</tr>
				</thead>
				<tbody>
            <%
                        Do While NOT objRds.Eof
						
						
						customers=customers+1
						if cnt>=startrecord and cnt<=endrecord then
						    customersonpage=customersonpage+1                 

                        %>
                        <tr>
                            <td><div align="left"><%=objRds("Email") %> </div></td>
                            <td><div align="left"><%=objRds("FirstName") %></div></td>
                            <td><div align="left"><%=objRds("LastName") %></div></td>
                            <td><div align="left"><%=objRds("Phone") %></div></td>
                            <td><div align="left"><%=objRds("Address") %></div></td>
                            <td><div align="left"><%=objRds("PostalCode") %></div></td>
                            <!--<td><div align="left"><%=objRds("IdBusinessDetail") %></div></td>-->
                        </tr>
                       
                        <%end if
						cnt=cnt+1
                            objRds.MoveNext    
                        Loop
                    
                        objRds.Close
                        objCon.Close
                        %>
				</tbody>
			</table>
			
		</div>
	</div>

   
<div class="pagingboxnumbers">
<nav>
  <ul class="pagination">

<%

if abs(page)>10 then%>
<li><a href="customerlist.asp?freetext=<%=request.querystring("freetext")%>&startDate=<%=sd%>&endDate=<%=ed%>&page=<%=1%>" class="">1</a>.....</li>
<%end if%>


<%
for g=1 to round(abs((totalrecords/pagesize))+0.5)%>
<%if abs(page)>abs(g)-10 and abs(page)<abs(g)+10 then%>
<li class="<%if abs(page)=abs(g) then%>active<%else%><%end if%>"><a href="customerlist.asp?freetext=<%=request.querystring("freetext")%>&startDate=<%=sd%>&endDate=<%=ed%>&page=<%=g%>" ><%=g%></a></li><%end if%><%next%><%
if abs(page)<round(abs((totalrecords/pagesize))+0.5)-10 then%>
<li>...<a href="customerlist.asp?freetext=<%=request.querystring("freetext")%>&startDate=<%=sd%>&endDate=<%=ed%>&page=<%=round(abs((totalrecords/pagesize))+0.5)%>" class=""><%=round(abs((totalrecords/pagesize))+0.5)%></a></li>
<%end if%>
  </ul>
</nav>

<br>
<br>

		
</div>
      

</div>








</body>
</html>
