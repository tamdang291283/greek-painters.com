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


<%
Dim MM_editAction
MM_editAction = CStr(Request.ServerVariables("SCRIPT_NAME"))
If (Request.QueryString <> "") Then
  MM_editAction = MM_editAction & "?" & Server.HTMLEncode(Request.QueryString)
End If

' boolean to abort record edit
Dim MM_abortEdit
MM_abortEdit = false
%>
<%
' IIf implementation
Function MM_IIf(condition, ifTrue, ifFalse)
  If condition = "" Then
    MM_IIf = ifFalse
  Else
    MM_IIf = ifTrue
  End If
End Function
%>
<%
If (CStr(Request("MM_update")) = "form1") Then
  If (Not MM_abortEdit) Then
    ' execute the update
    Dim MM_editCmd

    Set MM_editCmd = Server.CreateObject ("ADODB.Command")
    MM_editCmd.ActiveConnection = sConnStringcms

MM_editCmd.CommandText = "UPDATE MenuItemProperties SET[name] = ?,[price] = ?,[allowtoppings] = ?,[printingname]=?,s_ContainAllergen=?,s_MayContainAllergen=?,s_SuitableFor=? WHERE ID = ?" 
    MM_editCmd.Prepared = true

	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 202, 1, 255, Request.Form("name")) ' adVarWChar
	
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 6, 1, 255,MM_IIF(Request.Form("price"), Request.Form("price"), 0)) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param3", 3, 1, -1, MM_IIF(Request.Form("allowtoppings"),Request.Form("allowtoppings"),0)) ' adVarWChar
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param4", 202, 1, 255, MM_IIF(Request.Form("printingname"), Request.Form("printingname"), "")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param6", 202, 1, 255, MM_IIF(Request.Form("s_ContainAllergen"),Request.Form("s_ContainAllergen"),"") ) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param7", 202, 1, 255, MM_IIF(Request.Form("s_MayContainAllergen"),Request.Form("s_MayContainAllergen"),"") ) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param8", 202, 1, 255, MM_IIF(Request.Form("s_SuitableFor"),Request.Form("s_SuitableFor"),"")) ' adVarWChar
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param5", 5, 1, -1, MM_IIF(Request.Form("MM_recordId"), Request.Form("MM_recordId"), null)) ' adDouble
    

    MM_editCmd.Execute
    MM_editCmd.ActiveConnection.Close

    ' append the query string to the redirect URL
    Dim MM_editRedirectUrl
    MM_editRedirectUrl = "menu.asp"
    If (Request.QueryString <> "") Then
      If (InStr(1, MM_editRedirectUrl, "?", vbTextCompare) = 0) Then
        MM_editRedirectUrl = MM_editRedirectUrl & "?" & Request.QueryString
      Else
        MM_editRedirectUrl = MM_editRedirectUrl & "&" & Request.QueryString
      End If
    End If
    Response.Redirect(MM_editRedirectUrl)
  End If
End If
%>
<%
Dim Recordset1
Dim Recordset1_cmd
Dim Recordset1_numRows
Set Recordset1_cmd = Server.CreateObject ("ADODB.Command")
Recordset1_cmd.ActiveConnection = sConnStringcms
    sql = "SELECT Id,Name,Price,IdMenuItem,allowtoppings,dishpropertiesgroupid,printingname,i_displaysort "
    sql = sql & " ,s_ContainAllergen,s_MayContainAllergen,s_SuitableFor "
    sql = sql & " FROM MenuItemProperties with(nolock) where id=" & request.querystring("id")

Recordset1_cmd.CommandText = sql
Recordset1_cmd.Prepared = true
Set Recordset1 = Recordset1_cmd.Execute
Recordset1_numRows = 0
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
<div class="container">
	 <!-- #Include file="../inc-header.inc"-->
	




<div class="row clearfix">
		<div class="col-md-12 column">
		
			<%
				        objCon.Open sConnStringcms
                         Set objRds = Server.CreateObject("ADODB.Recordset") 
                        objRds.Open "SELECT * FROM menuitems where id=" & request.querystring("catid"), objCon
                         Dim s_ContainAllergen : s_ContainAllergen  = replace(Recordset1.Fields.Item("s_ContainAllergen").Value & ""," ","")
                        Dim s_MayContainAllergen : s_MayContainAllergen  =replace( Recordset1.Fields.Item("s_MayContainAllergen").Value & ""," ","")
                        Dim s_SuitableFor : s_SuitableFor  = Replace(Recordset1.Fields.Item("s_SuitableFor").Value & ""," ","")
                        if s_ContainAllergen <> "" then
                            s_ContainAllergen = "," & s_ContainAllergen 
                        end if
                        if s_MayContainAllergen <> "" then
                            s_MayContainAllergen = "," & s_MayContainAllergen 
                        end if
                        if s_SuitableFor <> "" then
                            s_SuitableFor = "," & s_SuitableFor 
                        end if

                        Dim RS_Allergen : set RS_Allergen = Server.CreateObject("ADODB.Recordset") 
                        Dim RS_Allergen_Suitable : set RS_Allergen_Suitable = Server.CreateObject("ADODB.Recordset")   
                        sql=" select ID,Name,Type from Allergen with(nolock) where Type = 'allergen'" 
                        RS_Allergen.Open sql, objCon
                        sql = "select ID,Name,Type from Allergen with(nolock) where Type = 'SuitableFor'"
                        RS_Allergen_Suitable.Open sql, objCon
                         function writechecked(byval value1, byval value2)
                            dim result : result = ""
                          '  Response.Write("value1 " & value1 & " value2 " & value2 & "<br/>")
                            if instr("," & value1 & ",","," & value2 & ",") > 0 then
                                result="checked"
                            end if
                            writechecked = result
                         end function
%>
			<ol class="breadcrumb">
<li><a href="menu.asp">Main Menu</a></li>
  <li><a href="menu-categories.asp?catid=<%=objRds("id")%>"><%= objRds("name") %></a></li>
  <li>Edit Sub Item</li>
</ol>
		
			<h1>Edit Sub Item</h1>
			<form method="post" action="<%=MM_editAction%>" name="form1" role="form">
  
   <div class="form-group">
    <label for="name">Name</label>
	<p>Enter the name of this item.</p>
    <input type="text" class="form-control" id="Name" name="Name" value="<%= replace(Recordset1.Fields.Item("Name").Value,"""","&quot;") %>" required>
  </div>
   <div class="form-group">
    <label for="name">Printing Name</label>
	<p>Enter the printing name of this item. This will only show on the printed receipts and will actually replace the dish-name. eg. where the dish name may be &quot;Duck&quot; and the sub-item name is &quot;Half&quot;, the Printing Name for the sub0tem should be &quot;half duck&quot; as it will replace the dish name in the PN receipt.</p>
    <input type="text" class="form-control" id="printingname" name="printingname" value="<%= replace(Recordset1.Fields.Item("printingname").Value & "","""","&quot;") %>">
  </div>
   <div class="form-group">
    <label for="name">Price</label>
		<p>Enter the price for a single item.</p>
    <input type="text" class="form-control" id="Price" name="Price" value="<%= Recordset1.Fields.Item("Price").Value %>" required>
  </div>
  <div class="form-group">   
       <div class="row">
            <div class="col-md-4 column">
                 <div class="panel panel-default">
                  <div class="panel-heading">Contain Allergen</div>
                  <div class="panel-body">
                        <div class="form-group">
                            <% if not RS_Allergen.EOF then %>
                            <% while not RS_Allergen.EOF    
                                    %>
                                        <span style="float:left;padding-left:5px;"><input type="checkbox" <%=writechecked(s_ContainAllergen,RS_Allergen("ID")) %> name="s_ContainAllergen" value="<%=RS_Allergen("ID") %>"/><label style="padding-left:5px;"><%=RS_Allergen("Name") %></label></span>
                                    <%                            
                                    RS_Allergen.movenext
                                wend
                                RS_Allergen.movefirst
                                 %>
                            <% end if %>
                        </div>
                      </div>
                 </div>

        
            </div>
            <div class="col-md-4 column">                 
                 <div class="panel panel-default">
                  <div class="panel-heading">May Contain Allergen</div>
                  <div class="panel-body">
                        <div class="form-group">
                            <% if not RS_Allergen.EOF then %>
                            <% while not RS_Allergen.EOF    
                                    %>
                                        <span style="float:left;padding-left:5px;"><input type="checkbox" name="s_MayContainAllergen" <%=writechecked(s_MayContainAllergen,RS_Allergen("ID")) %>  value="<%=RS_Allergen("ID") %>"/><label style="padding-left:5px;"><%=RS_Allergen("Name") %></label></span>
                                    <%                            
                                    RS_Allergen.movenext
                                wend
                               
                                 %>
                            <% end if 
                                    RS_Allergen.close()
                                set RS_Allergen = nothing
                                %>
                        </div>
                      </div>
                 </div>
            </div>
            <div class="col-md-4 column">
                 
                 <div class="panel panel-default">
                  <div class="panel-heading">Suitable for Allergen</div>
                  <div class="panel-body">
                        <div class="form-group">
                           <% if not RS_Allergen_Suitable.EOF then %>
                            <% while not RS_Allergen_Suitable.EOF    
                                    %>
                                        <span style="padding-left:5px;"><input type="checkbox" name="s_SuitableFor"  <%=writechecked(s_SuitableFor,RS_Allergen_Suitable("ID")) %> value="<%=RS_Allergen_Suitable("ID") %>"/><label style="padding-left:5px;"><%=RS_Allergen_Suitable("Name") %></label></span>
                                    <%                            
                                    RS_Allergen_Suitable.movenext
                                wend
                                    
                                 %>
                            <% end if
                                    RS_Allergen_Suitable.close()
                                set RS_Allergen_Suitable = nothing
                                 %>
                        </div>
                      </div>
                 </div>
                
            </div>
       </div> 
  </div>
  <div class="form-group">

	
	 <label for="allowtoppings">Toppings </label>
	
	<p>Does this product come with optional toppings, if so select the topping group appropriate to this item.</p>
	<select name="allowtoppings" id="allowtoppings" class="form-control">
  <option value="0">-- don't allow toppings --</option>


	
	<%                     objRds.Close
                       set objRds = nothing
                        Set objRds = Server.CreateObject("ADODB.Recordset") 
                        objRds.Open "SELECT * FROM Menutoppingsgroups where  IdBusinessDetail=" & Session("MM_id") , objCon

                        Do While NOT objRds.Eof%>
						
					  <option value="<%= objRds("id") %>" <%if Recordset1.Fields.Item("allowtoppings").Value=objRds("id") then%>selected<%end if%>><%= objRds("toppingsgroup") %></option>
	 <%
                            objRds.MoveNext    
                        Loop
                            objRds.close()
                        set objRds = nothing
                       
                        %>
						</select>
	
    
  </div>
  
  <input type="hidden" name="MM_update" value="form1">

  <input type="hidden" name="MM_recordId" value="<%= Recordset1.Fields.Item("ID").Value %>">
  <button type="submit" class="btn btn-default">Submit</button>
</form>
		</div>
	</div>

      
</div>



<!-- Modal -->





</body>
</html>
