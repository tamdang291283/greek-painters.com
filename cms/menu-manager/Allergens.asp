<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../../Config.asp" -->
<!-- #include file="../restaurantsettings.asp" -->
<!-- #include file="../timezone.asp" -->
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
	<script type="text/javascript" src="../js/scripts.js"></script>
</head>

<body>

      <style>
#overlay {
  position: fixed;
  display: none;
  width: 100%;
  height: 100%;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0,0,0,0.5);
  z-index: 2;
  cursor: pointer;
}

#text{
  position: absolute;
  top: 50%;
  left: 50%;
  font-size: 50px;
  color: white;
  transform: translate(-50%,-50%);
  -ms-transform: translate(-50%,-50%);
}
</style>

<div id="overlay">
  <div id="text">Loading</div>
</div>

<div class="container">
	 <!-- #Include file="../inc-header.inc"-->

<div class="row clearfix">
		<div class="col-md-12 column">
	    <h1>Edit Allergen</h1>
		<a href="Allergens-add.asp"  class="btn btn-primary pull-right">ADD</a>
		
		<p>Click add to create a new allergen</p>
			<table class="table table-hover table-condensed table-striped">
				<thead>
					<tr>
						<th>
							Allergen
						</th>
                        <th>
							Type
						</th>
                        <th>
							Icon
						</th>
						<th>
						</th>
					</tr>
				</thead>
				<tbody>
				
				<%    
                        objCon.Open sConnStringcms
                       Set objRds = Server.CreateObject("ADODB.Recordset") 
                        objRds.Open "SELECT id,Name,Type,Icon FROM Allergen with(nolock) order by ID " , objCon

                        Do While NOT objRds.Eof
                        %>
                       <tr id="<%=objRds("id") %>">
						<td><p><%= objRds("Name") %></p></td>
                        <td><p><%= objRds("Type") %></p></td>
                           <td>
                               <% if objRds("Icon") <> "" then  %>
                                <img  width="25" src="<%=SITE_URL %>Images/allergen/png/<%=objRds("Icon") %>" alt="<%=objRds("Name") %>" title="<%=objRds("Name") %>">
                               <% end if %>
                           </td>
                           <td>
						
						
						<span class="pull-right">
			<a class="btn btn-primary btn"  href="Allergens-edit.asp?id=<%=objRds("id")%>">EDIT</a>
            <a href="Allergens-Delete.asp?id=<%=objRds("id")%>" class="btn btn-danger confirm">DELETE</a>
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

      
</div>



<!-- Modal -->





</body>
</html>
