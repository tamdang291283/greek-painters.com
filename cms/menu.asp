<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../Config.asp" -->
<!-- #include file="restaurantsettings.asp" -->
<!-- #include file="timezone.asp" -->
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

  <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
  <![endif]-->

  <!-- Fav and touch icons -->
   <% If FAVICONURL & "" <> "" Then %> <link rel='shortcut icon' href='<%=FAVICONURL %>' type='image/x-icon'/ > <% end If %>
  
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/scripts.js"></script>
	
	
</head>

<body>
<div class="container">
	 <!-- #Include file="inc-header.inc"-->
	




<div class="row clearfix">
		<div class="col-md-12 column">
		
		<ol class="breadcrumb">
 
  <li><a href="menu.asp">Main Menu</a></li>
 
  
</ol>
		
		<a href="menu-sort.asp"  class="btn btn-warning pull-right">SORT</a>&nbsp;<a href="menu-add.asp"  class="btn btn-primary pull-right">ADD</a>
		<h1>Menu Categories</h1>
		<p>Click add to create a new top level menu, to change the order of the items click "sort".</p>
		
		
			<table class="table table-hover table-condensed table-striped">
				<thead>
					<tr>
						<th>
							Name
						</th>
						
						
						<th>
							
						</th>
					</tr>
				</thead>
				<tbody>
				
				<%  objRds.Close
                        objCon.Close
				  objCon.Open sConnStringcms
                        objRds.Open "SELECT * FROM menucategories where IdBusinessDetail=" &  Session("MM_id") & " order by displayorder" , objCon

                        Do While NOT objRds.Eof
                        %>
                       <tr id="MenuCat<%=objRds("ID") %>">
						<td>
							 <h2 ><%= objRds("name") %></h2>
							 
						</td>
						
						
						<td>
						
						
						<span class="pull-right">
						
			

			
<a class="btn btn-primary btn"  href="menu-edit.asp?id=<%=objRds("id")%>">
EDIT
</a>		
			<a class="btn btn-danger btn confirm"  href="menu-del.asp?id=<%=objRds("id")%>">
DELETE
</a>




			
			
						</td>
						
					</tr>
					
					<tr><td colspan=2>
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					<table class="table table-hover table-condensed table-striped"><thead><tr><th>Image</th><th>Name</th><th><a href="menu-categories-add.asp?catid=<%=objRds("id")%>"  class="btn btn-primary pull-right">ADD PRODUCT</a></th></tr></thead><tbody>
<%  
Set objCon3 = Server.CreateObject("ADODB.Connection")
Set objRds3 = Server.CreateObject("ADODB.Recordset") 
objCon3.Open sConnStringcms
objRds3.Open "SELECT * FROM menuitems where IdMenuCategory=" & objRds("id") & " and IdBusinessDetail=" & Session("MM_id") , objCon3
Do While NOT objRds3.Eof
%>
<tr>
<td>
<%if objRds3("photo")<>"" then%>
<a href="menu-categories-uploadimage.asp?catid=<%=objRds("id")%>&id=<%=objRds3("id")%>&f=<%= objRds3("photo") %>"><img src="../images/<%=Session("MM_id")%>/<%= objRds3("photo") %>" width="40"></a>
<%else%>
<a href="menu-categories-uploadimage.asp?catid=<%=objRds("id")%>&id=<%=objRds3("id")%>&f=<%= objRds3("photo") %>"><img src="../images/noimage.png"></a>
<%end if%>

</td>
<td><p><%= objRds3("name") %> <a class="btn btn-primary btn-xs"  href="menu-sub-add.asp?catid=<%=objRds3("id")%>">
ADD
</a>
<%if objRds3("hidedish")=-1 then%><span class="label label-danger">Hidden</span><%end if%>

<%  
Set objCon30 = Server.CreateObject("ADODB.Connection")
Set objRds30 = Server.CreateObject("ADODB.Recordset") 
objCon30.Open sConnStringcms
objRds30.Open "SELECT * FROM menuitemproperties where IdMenuItem=" & objRds3("id"), objCon30
%><table class="table table-hover table-condensed table-striped">
<%
Do While NOT objRds30.Eof
%>

<tr><td>

<em><%=objRds30("name")%></em></td><td><a class="btn btn-primary btn-xs"  href="menu-sub-edit.asp?catid=<%=objRds3("id")%>&id=<%=objRds30("id")%>">
EDIT
</a>	 	
<a class="btn btn-danger btn-xs confirm"  href="menu-sub-del.asp?catid=<%=objRds3("id")%>&id=<%=objRds30("id")%>">
DELETE
</a></td></tr>
<%
objRds30.MoveNext    
Loop
objRds30.Close
objCon30.Close%>
</table>



</p>
</td>						<td>
<span class="pull-right">
<%

Set objCon2 = Server.CreateObject("ADODB.Connection")
Set objRds2 = Server.CreateObject("ADODB.Recordset") 

objCon2.Open sConnStringcms
objRds2.Open "SELECT * FROM menuitemproperties where idmenuitem=" & objRds3("id") , objCon
%>
	<a class="btn btn-success btn"  href="menu-categories-sub.asp?id=<%=objRds3("id")%>">
VIEW
</a> 
<a class="btn btn-primary btn"  href="menu-categories-edit.asp?id=<%=objRds3("id")%>&catid=<%=objRds("id")%>">
EDIT
</a>		
<a class="btn btn-danger btn confirm"  href="menu-categories-del.asp?id=<%=objRds3("id")%>&catid=<%=objRds("id")%>">
DELETE
</a>
<%
objRds2.Close
objCon2.Close
%>
</td>
</tr>
<%
objRds3.MoveNext    
Loop
objRds3.Close
objCon3.Close%>

</tbody>
</table>
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					</td></tr>
					
                        <%
                            objRds.MoveNext    
                        Loop
                    
                        objRds.Close
                        objCon.Close
                        %>
				
					
					
					
					
					
				</tbody>
			</table>
			
		</div>
	</div>

      
</div>
<% If Request.QueryString("catid") & "" <> "" Then %>
    <script>
     $('html, body').animate({
        scrollTop: $("#MenuCat<%=Request.QueryString("catid") %>").offset().top - 50
    }, 1000);
    </script>
<%ElseIf Request.QueryString("id") & "" <> "" Then %>
    <script>
     $('html, body').animate({
        scrollTop: $("#MenuCat<%=Request.QueryString("id") %>").offset().top - 50
    }, 1000);
    </script>
<% End If %>
<!-- Modal -->





</body>
</html>
