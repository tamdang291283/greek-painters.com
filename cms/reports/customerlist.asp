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

  <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
  <![endif]-->

  <!-- Fav and touch icons -->
   <% If FAVICONURL & "" <> "" Then %> <link rel='shortcut icon' href='<%=FAVICONURL %>' type='image/x-icon'/ > <% end If %>
  
	<script type="text/javascript" src="../js/jquery.min.js"></script>
	<script type="text/javascript" src="../js/bootstrap.min.js"></script>
	<script src="../js/bootstrap-datepicker.min.js"></script>
	<script type="text/javascript" src="../js/scripts.js"></script>
	
	
</head>

<body>
<div class="container">
	 <!-- #Include file="../inc-header.inc"-->
    
    
    <div class="row clearfix">
		<div class="col-md-12 column">
            
		            <!--<a href="customerexport.asp" class="btn btn-primary pull-right">Download</a-->
                   
                    <div class="col-md-12 column">
		<ol class="breadcrumb">
 
  <li><a href="#">Download Customer List</a></li>
 
  
</ol>   
                <a href="customerexport.asp"  class="btn btn-primary pull-right">Download</a><h1>Customer List</h1>
		        <p>This is a list of all customers based on the uniqueness of all the logged data.</p>

				<% 
		
     Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset")                    
				  objCon.Open sConnStringcms

	 'response.write sql 
                    sql = "SELECT DISTINCT Orders.Email, Orders.FirstName, Orders.LastName, Orders.Phone, Orders.Address, Orders.PostalCode, Orders.IdBusinessDetail, count(orders.ID) as numberorder FROM Orders    " 
                    sql=sql&"  WHERE Orders.Email<>'' AND Orders.IdBusinessDetail="& Session("MM_id") 
                    sql=sql & " group by Orders.Email, Orders.FirstName, Orders.LastName, Orders.Phone, Orders.Address, Orders.PostalCode, Orders.IdBusinessDetail " 
                    sql=sql & " order by Orders.FirstName"
               
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
                <div class="table-responsive">
            	<table class="table table-hover table-condensed table-striped">
				<thead>
					<tr>
					    <th>Email</th>
						<th>First Name</th>
						<th>Last Name</th>
						<th>Phone Number</th>
						<th>Address</th>
						<th>Postal Code</th>
                        <th>Orders</th>
						<!--<th><div align="left">Bussiness Card Detail</div></th>-->
						
					</tr>
				</thead>
				<tbody>
            <%
                        Do While NOT objRds.Eof
						    customers=customers+1
						'if cnt>=startrecord and cnt<=endrecord then
						    customersonpage=customersonpage+1                 

                        %>
                        <tr>
                            <td><%=objRds("Email") %> </td>
                            <td><%=objRds("FirstName") %></td>
                            <td><%=objRds("LastName") %></td>
                            <td><%=objRds("Phone") %></td>
                            <td><%=objRds("Address") %></td>
                            <td><%=objRds("PostalCode") %></td>
                            <td><%=objRds("numberorder") %></td>
                        </tr>
                       
                        <%'end if
						cnt=cnt+1
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
	</div>
</div>

</body>
</html>
