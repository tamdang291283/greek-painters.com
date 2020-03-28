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
		
		<ol class="breadcrumb">
 
  <li><a href="menu.asp">Main Menu</a></li>
 
  
</ol>
		
		<a href="menu-sort.asp"  class="btn btn-warning pull-right">SORT</a>&nbsp;<a href="menu-add.asp"  class="btn btn-primary pull-right">ADD</a>
		<h1>Menu Categories</h1>
		<p>Click add to create a new top level menu, to change the order of the items click "sort".</p>
		      <script src="../js/jquery-1.12.4.js"></script>
              <script src="../js/jquery-ui-12-1.js"></script>
            <script src="../js/jquery-touch-punch.js"></script>
		    <script type="text/javascript">
		        $(function () {
		          //  $("#parentsortable").sortable();
		            //$('[name=bodysub]').sortable();
		            //  $("#parentsortable").disableSelection();

		            $('[name=bodysub]').sortable({
		                items: "tr:not(.unsortable)",
		                handle: ".glyphicon-move",
                        cursor:"move",
		                forcePlaceholderSize: false,
		                update: function (event, ui) {
		              
		                    var sortedIDs = $(ui.item[0].closest("tbody")).sortable("toArray");
		                    var idparent = $(ui.item[0].closest("tbody")).attr("id");

		                    var table ="mip";
		                    if(idparent.indexOf("cat_")>-1)
		                        table = "mi";
		                    idparent =  idparent.replace("cat_","");
		                    idparent =  idparent.replace("mi_","");
		                    $("#overlay").show();
		                    $.post("menu-sort-updatedb.asp", { "recordsarray[]": sortedIDs, "table": table ,"resid":"<%=Session("MM_id")%>","pid":idparent}, function (theResponse) {
		                        // $("#contentRight").html(theResponse);
		                        $("#overlay").hide();
		                    });


		                    console.log($(ui.item[0].closest("tbody")).attr("id") + " " +  sortedIDs.toString());
		                   // alert("sorted");
		                }
		            });

		    

		          

		        });
		    </script>
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
                </tbody>
                </table>
				<table class="table table-hover table-condensed table-striped">
                <tbody>
				<%  
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
					<table class="table table-hover table-condensed table-striped">
                        <tbody name="bodysub" id="cat_<%=objRds("id") %>">
                   <tr class="unsortable"><th>Image</th><th>Name</th><th><a href="menu-categories-add.asp?catid=<%=objRds("id")%>"  class="btn btn-primary pull-right">ADD PRODUCT</a></th></tr>
                        
<%  

Set objRds3 = Server.CreateObject("ADODB.Recordset") 
  '  Response.Write("SELECT * FROM menuitems where IdMenuCategory=" & objRds("id") & " and IdBusinessDetail=" & Session("MM_id") & " order by i_displaysort,id")
objRds3.Open "SELECT * FROM menuitems where IdMenuCategory=" & objRds("id") & " and IdBusinessDetail=" & Session("MM_id") & " order by i_displaysort,id" , objCon


Do While NOT objRds3.Eof
    dim csstrStyle :  csstrStyle =""
    dim cssStyle :  cssStyle =""
    if objRds3("hidedish") = -1 then
        csstrStyle ="color:#468847;"
    end if
%>
<tr style="<%=csstrStyle%>" id="<%=objRds3("id") %>">
<td>
<%if objRds3("photo")<>"" then%>
<a  href="menu-categories-uploadimage.asp?catid=<%=objRds("id")%>&id=<%=objRds3("id")%>&f=<%= objRds3("photo") %>"><img src="../../images/<%=Session("MM_id")%>/<%= objRds3("photo") %>" width="40"></a>
<%else%>
<a href="menu-categories-uploadimage.asp?catid=<%=objRds("id")%>&id=<%=objRds3("id")%>&f=<%= objRds3("photo") %>"><img src="../../images/noimage.png"></a>
<%end if%>
<span class="glyphicon glyphicon-move" aria-hidden="true"></span>
</td>
<td><p><%= objRds3("name") %> <a class="btn btn-primary btn-xs"  href="menu-sub-add.asp?catid=<%=objRds3("id")%>">
ADD
</a>
<%if objRds3("hidedish")=1 then%><span class="label label-warning">Hidden</span><%end if%>

<%  

Set objRds30 = Server.CreateObject("ADODB.Recordset") 
    objRds30.Open "SELECT * FROM menuitemproperties where IdMenuItem=" & objRds3("id") & " order by i_displaysort,id ", objCon
%>
    <table class="table table-hover table-condensed table-striped">
    <tbody  name="bodysub"  id="mi_<%=objRds3("id") %>">
<%
Do While NOT objRds30.Eof
%>

<tr id="<%=objRds30("id") %>"><td>
<span class="glyphicon glyphicon-move" aria-hidden="true"></span>
<em><%=objRds30("name")%></em></td>
    <td class="sub-pull-right"><a class="btn btn-primary btn-xs"  href="menu-sub-edit.asp?catid=<%=objRds3("id")%>&id=<%=objRds30("id")%>">
EDIT
</a>	 	
<a class="btn btn-danger btn-xs confirm"  href="menu-sub-del.asp?catid=<%=objRds3("id")%>&id=<%=objRds30("id")%>">
DELETE
</a></td></tr>
<%
objRds30.MoveNext    
Loop
objRds30.Close
%>
  </tbody>
</table>
</p>
</td>						<td>
<span class="pull-right">
<%
'Set objRds2 = Server.CreateObject("ADODB.Recordset") 
'objRds2.Open "SELECT * FROM menuitemproperties where idmenuitem=" & objRds3("id") , objCon
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
'objRds2.Close
'set objRds2 = nothing
%>
</td>
</tr>
<%
objRds3.MoveNext    
Loop
objRds3.Close
set objRds3 = nothing
%>

</tbody>
</table>
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					</td></tr>
					
                        <%
                            objRds.MoveNext    
                        Loop
                    
                        objRds.Close
                        set objRds = nothing
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
