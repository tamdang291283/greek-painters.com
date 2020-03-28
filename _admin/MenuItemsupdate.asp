<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="MenuItemsinfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim MenuItems_update
Set MenuItems_update = New cMenuItems_update
Set Page = MenuItems_update

' Page init processing
MenuItems_update.Page_Init()

' Page main processing
MenuItems_update.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
MenuItems_update.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var MenuItems_update = new ew_Page("MenuItems_update");
MenuItems_update.PageID = "update"; // Page ID
var EW_PAGE_ID = MenuItems_update.PageID; // For backward compatibility
// Form object
var fMenuItemsupdate = new ew_Form("fMenuItemsupdate");
// Validate form
fMenuItemsupdate.Validate = function() {
	if (!this.ValidateRequired)
		return true; // Ignore validation
	var $ = jQuery, fobj = this.GetForm(), $fobj = $(fobj);
	this.PostAutoSuggest();
	if ($fobj.find("#a_confirm").val() == "F")
		return true;
	if (!ew_UpdateSelected(fobj)) {
		alert(ewLanguage.Phrase("NoFieldSelected"));
		return false;
	}
	var elm, felm, uelm, addcnt = 0;
	var $k = $fobj.find("#" + this.FormKeyCountName); // Get key_count
	var rowcnt = ($k[0]) ? parseInt($k.val(), 10) : 1;
	var startcnt = (rowcnt == 0) ? 0 : 1; // Check rowcnt == 0 => Inline-Add
	var gridinsert = $fobj.find("#a_list").val() == "gridinsert";
	for (var i = startcnt; i <= rowcnt; i++) {
		var infix = ($k[0]) ? String(i) : "";
		$fobj.data("rowindex", infix);
			elm = this.GetElements("x" + infix + "_Code");
			uelm = this.GetElements("u" + infix + "_Code");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(MenuItems.Code.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_Vegetarian");
			uelm = this.GetElements("u" + infix + "_Vegetarian");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(MenuItems.Vegetarian.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_Spicyness");
			uelm = this.GetElements("u" + infix + "_Spicyness");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(MenuItems.Spicyness.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_Price");
			uelm = this.GetElements("u" + infix + "_Price");
			if (uelm && uelm.checked && elm && !ew_CheckNumber(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(MenuItems.Price.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_IdMenuCategory");
			uelm = this.GetElements("u" + infix + "_IdMenuCategory");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(MenuItems.IdMenuCategory.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_IdBusinessDetail");
			uelm = this.GetElements("u" + infix + "_IdBusinessDetail");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(MenuItems.IdBusinessDetail.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_allowtoppings");
			uelm = this.GetElements("u" + infix + "_allowtoppings");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(MenuItems.allowtoppings.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_hidedish");
			uelm = this.GetElements("u" + infix + "_hidedish");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(MenuItems.hidedish.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_i_displaySort");
			uelm = this.GetElements("u" + infix + "_i_displaySort");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(MenuItems.i_displaySort.FldErrMsg) %>");
			// Set up row object
			ew_ElementsToRow(fobj);
			// Fire Form_CustomValidate event
			if (!this.Form_CustomValidate(fobj))
				return false;
	}
	return true;
}
// Form_CustomValidate event
fMenuItemsupdate.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fMenuItemsupdate.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fMenuItemsupdate.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<div class="ewToolbar">
<% If MenuItems.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If MenuItems.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% MenuItems_update.ShowPageHeader() %>
<% MenuItems_update.ShowMessage %>
<form name="fMenuItemsupdate" id="fMenuItemsupdate" class="form-horizontal ewForm ewUpdateForm" action="<%= ew_CurrentPage %>" method="post">
<% If MenuItems_update.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= MenuItems_update.Token %>">
<% End If %>
<input type="hidden" name="t" value="MenuItems">
<input type="hidden" name="a_update" id="a_update" value="U">
<% For i = 0 to UBound(MenuItems_update.RecKeys) %>
<input type="hidden" name="key_m" id="key_m" value="<%= ew_HtmlEncode(ew_GetKeyValue(MenuItems_update.RecKeys(i))) %>">
<% Next %>
<div id="tbl_MenuItemsupdate">
	<div class="form-group">
		<label class="col-sm-2"><input type="checkbox" name="u" id="u" onclick="ew_SelectAll(this);"> <%= Language.Phrase("UpdateSelectAll") %></label>
	</div>
<% If MenuItems.Code.Visible Then ' Code %>
	<div id="r_Code" class="form-group">
		<label for="x_Code" class="col-sm-2 control-label">
<input type="checkbox" name="u_Code" id="u_Code" value="1"<% If MenuItems.Code.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= MenuItems.Code.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuItems.Code.CellAttributes %>>
<span id="el_MenuItems_Code">
<input type="text" data-field="x_Code" name="x_Code" id="x_Code" size="30" placeholder="<%= MenuItems.Code.PlaceHolder %>" value="<%= MenuItems.Code.EditValue %>"<%= MenuItems.Code.EditAttributes %>>
</span>
<%= MenuItems.Code.CustomMsg %></div></div>
	</div>
<% End If %>
<% If MenuItems.Name.Visible Then ' Name %>
	<div id="r_Name" class="form-group">
		<label for="x_Name" class="col-sm-2 control-label">
<input type="checkbox" name="u_Name" id="u_Name" value="1"<% If MenuItems.Name.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= MenuItems.Name.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuItems.Name.CellAttributes %>>
<span id="el_MenuItems_Name">
<input type="text" data-field="x_Name" name="x_Name" id="x_Name" size="30" maxlength="255" placeholder="<%= MenuItems.Name.PlaceHolder %>" value="<%= MenuItems.Name.EditValue %>"<%= MenuItems.Name.EditAttributes %>>
</span>
<%= MenuItems.Name.CustomMsg %></div></div>
	</div>
<% End If %>
<% If MenuItems.Description.Visible Then ' Description %>
	<div id="r_Description" class="form-group">
		<label for="x_Description" class="col-sm-2 control-label">
<input type="checkbox" name="u_Description" id="u_Description" value="1"<% If MenuItems.Description.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= MenuItems.Description.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuItems.Description.CellAttributes %>>
<span id="el_MenuItems_Description">
<textarea data-field="x_Description" name="x_Description" id="x_Description" cols="35" rows="4" placeholder="<%= MenuItems.Description.PlaceHolder %>"<%= MenuItems.Description.EditAttributes %>><%= MenuItems.Description.EditValue %></textarea>
</span>
<%= MenuItems.Description.CustomMsg %></div></div>
	</div>
<% End If %>
<% If MenuItems.Vegetarian.Visible Then ' Vegetarian %>
	<div id="r_Vegetarian" class="form-group">
		<label for="x_Vegetarian" class="col-sm-2 control-label">
<input type="checkbox" name="u_Vegetarian" id="u_Vegetarian" value="1"<% If MenuItems.Vegetarian.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= MenuItems.Vegetarian.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuItems.Vegetarian.CellAttributes %>>
<span id="el_MenuItems_Vegetarian">
<input type="text" data-field="x_Vegetarian" name="x_Vegetarian" id="x_Vegetarian" size="30" placeholder="<%= MenuItems.Vegetarian.PlaceHolder %>" value="<%= MenuItems.Vegetarian.EditValue %>"<%= MenuItems.Vegetarian.EditAttributes %>>
</span>
<%= MenuItems.Vegetarian.CustomMsg %></div></div>
	</div>
<% End If %>
<% If MenuItems.Spicyness.Visible Then ' Spicyness %>
	<div id="r_Spicyness" class="form-group">
		<label for="x_Spicyness" class="col-sm-2 control-label">
<input type="checkbox" name="u_Spicyness" id="u_Spicyness" value="1"<% If MenuItems.Spicyness.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= MenuItems.Spicyness.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuItems.Spicyness.CellAttributes %>>
<span id="el_MenuItems_Spicyness">
<input type="text" data-field="x_Spicyness" name="x_Spicyness" id="x_Spicyness" size="30" placeholder="<%= MenuItems.Spicyness.PlaceHolder %>" value="<%= MenuItems.Spicyness.EditValue %>"<%= MenuItems.Spicyness.EditAttributes %>>
</span>
<%= MenuItems.Spicyness.CustomMsg %></div></div>
	</div>
<% End If %>
<% If MenuItems.Price.Visible Then ' Price %>
	<div id="r_Price" class="form-group">
		<label for="x_Price" class="col-sm-2 control-label">
<input type="checkbox" name="u_Price" id="u_Price" value="1"<% If MenuItems.Price.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= MenuItems.Price.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuItems.Price.CellAttributes %>>
<span id="el_MenuItems_Price">
<input type="text" data-field="x_Price" name="x_Price" id="x_Price" size="30" placeholder="<%= MenuItems.Price.PlaceHolder %>" value="<%= MenuItems.Price.EditValue %>"<%= MenuItems.Price.EditAttributes %>>
</span>
<%= MenuItems.Price.CustomMsg %></div></div>
	</div>
<% End If %>
<% If MenuItems.IdMenuCategory.Visible Then ' IdMenuCategory %>
	<div id="r_IdMenuCategory" class="form-group">
		<label for="x_IdMenuCategory" class="col-sm-2 control-label">
<input type="checkbox" name="u_IdMenuCategory" id="u_IdMenuCategory" value="1"<% If MenuItems.IdMenuCategory.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= MenuItems.IdMenuCategory.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuItems.IdMenuCategory.CellAttributes %>>
<span id="el_MenuItems_IdMenuCategory">
<input type="text" data-field="x_IdMenuCategory" name="x_IdMenuCategory" id="x_IdMenuCategory" size="30" placeholder="<%= MenuItems.IdMenuCategory.PlaceHolder %>" value="<%= MenuItems.IdMenuCategory.EditValue %>"<%= MenuItems.IdMenuCategory.EditAttributes %>>
</span>
<%= MenuItems.IdMenuCategory.CustomMsg %></div></div>
	</div>
<% End If %>
<% If MenuItems.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
	<div id="r_IdBusinessDetail" class="form-group">
		<label for="x_IdBusinessDetail" class="col-sm-2 control-label">
<input type="checkbox" name="u_IdBusinessDetail" id="u_IdBusinessDetail" value="1"<% If MenuItems.IdBusinessDetail.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= MenuItems.IdBusinessDetail.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuItems.IdBusinessDetail.CellAttributes %>>
<span id="el_MenuItems_IdBusinessDetail">
<input type="text" data-field="x_IdBusinessDetail" name="x_IdBusinessDetail" id="x_IdBusinessDetail" size="30" placeholder="<%= MenuItems.IdBusinessDetail.PlaceHolder %>" value="<%= MenuItems.IdBusinessDetail.EditValue %>"<%= MenuItems.IdBusinessDetail.EditAttributes %>>
</span>
<%= MenuItems.IdBusinessDetail.CustomMsg %></div></div>
	</div>
<% End If %>
<% If MenuItems.Photo.Visible Then ' Photo %>
	<div id="r_Photo" class="form-group">
		<label for="x_Photo" class="col-sm-2 control-label">
<input type="checkbox" name="u_Photo" id="u_Photo" value="1"<% If MenuItems.Photo.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= MenuItems.Photo.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuItems.Photo.CellAttributes %>>
<span id="el_MenuItems_Photo">
<input type="text" data-field="x_Photo" name="x_Photo" id="x_Photo" size="30" maxlength="255" placeholder="<%= MenuItems.Photo.PlaceHolder %>" value="<%= MenuItems.Photo.EditValue %>"<%= MenuItems.Photo.EditAttributes %>>
</span>
<%= MenuItems.Photo.CustomMsg %></div></div>
	</div>
<% End If %>
<% If MenuItems.allowtoppings.Visible Then ' allowtoppings %>
	<div id="r_allowtoppings" class="form-group">
		<label for="x_allowtoppings" class="col-sm-2 control-label">
<input type="checkbox" name="u_allowtoppings" id="u_allowtoppings" value="1"<% If MenuItems.allowtoppings.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= MenuItems.allowtoppings.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuItems.allowtoppings.CellAttributes %>>
<span id="el_MenuItems_allowtoppings">
<input type="text" data-field="x_allowtoppings" name="x_allowtoppings" id="x_allowtoppings" size="30" placeholder="<%= MenuItems.allowtoppings.PlaceHolder %>" value="<%= MenuItems.allowtoppings.EditValue %>"<%= MenuItems.allowtoppings.EditAttributes %>>
</span>
<%= MenuItems.allowtoppings.CustomMsg %></div></div>
	</div>
<% End If %>
<% If MenuItems.dishpropertygroupid.Visible Then ' dishpropertygroupid %>
	<div id="r_dishpropertygroupid" class="form-group">
		<label for="x_dishpropertygroupid" class="col-sm-2 control-label">
<input type="checkbox" name="u_dishpropertygroupid" id="u_dishpropertygroupid" value="1"<% If MenuItems.dishpropertygroupid.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= MenuItems.dishpropertygroupid.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuItems.dishpropertygroupid.CellAttributes %>>
<span id="el_MenuItems_dishpropertygroupid">
<input type="text" data-field="x_dishpropertygroupid" name="x_dishpropertygroupid" id="x_dishpropertygroupid" size="30" maxlength="255" placeholder="<%= MenuItems.dishpropertygroupid.PlaceHolder %>" value="<%= MenuItems.dishpropertygroupid.EditValue %>"<%= MenuItems.dishpropertygroupid.EditAttributes %>>
</span>
<%= MenuItems.dishpropertygroupid.CustomMsg %></div></div>
	</div>
<% End If %>
<% If MenuItems.hidedish.Visible Then ' hidedish %>
	<div id="r_hidedish" class="form-group">
		<label for="x_hidedish" class="col-sm-2 control-label">
<input type="checkbox" name="u_hidedish" id="u_hidedish" value="1"<% If MenuItems.hidedish.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= MenuItems.hidedish.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuItems.hidedish.CellAttributes %>>
<span id="el_MenuItems_hidedish">
<input type="text" data-field="x_hidedish" name="x_hidedish" id="x_hidedish" size="30" placeholder="<%= MenuItems.hidedish.PlaceHolder %>" value="<%= MenuItems.hidedish.EditValue %>"<%= MenuItems.hidedish.EditAttributes %>>
</span>
<%= MenuItems.hidedish.CustomMsg %></div></div>
	</div>
<% End If %>
<% If MenuItems.PrintingName.Visible Then ' PrintingName %>
	<div id="r_PrintingName" class="form-group">
		<label for="x_PrintingName" class="col-sm-2 control-label">
<input type="checkbox" name="u_PrintingName" id="u_PrintingName" value="1"<% If MenuItems.PrintingName.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= MenuItems.PrintingName.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuItems.PrintingName.CellAttributes %>>
<span id="el_MenuItems_PrintingName">
<input type="text" data-field="x_PrintingName" name="x_PrintingName" id="x_PrintingName" size="30" maxlength="128" placeholder="<%= MenuItems.PrintingName.PlaceHolder %>" value="<%= MenuItems.PrintingName.EditValue %>"<%= MenuItems.PrintingName.EditAttributes %>>
</span>
<%= MenuItems.PrintingName.CustomMsg %></div></div>
	</div>
<% End If %>
<% If MenuItems.i_displaySort.Visible Then ' i_displaySort %>
	<div id="r_i_displaySort" class="form-group">
		<label for="x_i_displaySort" class="col-sm-2 control-label">
<input type="checkbox" name="u_i_displaySort" id="u_i_displaySort" value="1"<% If MenuItems.i_displaySort.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= MenuItems.i_displaySort.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuItems.i_displaySort.CellAttributes %>>
<span id="el_MenuItems_i_displaySort">
<input type="text" data-field="x_i_displaySort" name="x_i_displaySort" id="x_i_displaySort" size="30" placeholder="<%= MenuItems.i_displaySort.PlaceHolder %>" value="<%= MenuItems.i_displaySort.EditValue %>"<%= MenuItems.i_displaySort.EditAttributes %>>
</span>
<%= MenuItems.i_displaySort.CustomMsg %></div></div>
	</div>
<% End If %>
	<div class="form-group">
		<div class="col-sm-offset-2 col-sm-10">
<button class="btn btn-primary ewButton" name="btnAction" id="btnAction" type="submit"><%= Language.Phrase("UpdateBtn") %></button>
		</div>
	</div>
</div>
</form>
<script type="text/javascript">
fMenuItemsupdate.Init();
</script>
<%
MenuItems_update.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set MenuItems_update = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cMenuItems_update

	' Page ID
	Public Property Get PageID()
		PageID = "update"
	End Property

	' Project ID
	Public Property Get ProjectID()
		ProjectID = "{E9837C6B-C139-4DEF-A37B-491BE9913D3B}"
	End Property

	' Table Name
	Public Property Get TableName()
		TableName = "MenuItems"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "MenuItems_update"
	End Property

	' Page Name
	Public Property Get PageName()
		PageName = ew_CurrentPage()
	End Property

	' Page Url
	Public Property Get PageUrl()
		PageUrl = ew_CurrentPage() & "?"
		If MenuItems.UseTokenInUrl Then PageUrl = PageUrl & "t=" & MenuItems.TableVar & "&" ' add page token
	End Property

	' Message
	Public Property Get Message()
		Message = Session(EW_SESSION_MESSAGE)
	End Property

	Public Property Let Message(v)
		Dim msg
		msg = Session(EW_SESSION_MESSAGE)
		Call ew_AddMessage(msg, v)
		Session(EW_SESSION_MESSAGE) = msg
	End Property

	Public Property Get FailureMessage()
		FailureMessage = Session(EW_SESSION_FAILURE_MESSAGE)
	End Property

	Public Property Let FailureMessage(v)
		Dim msg
		msg = Session(EW_SESSION_FAILURE_MESSAGE)
		Call ew_AddMessage(msg, v)
		Session(EW_SESSION_FAILURE_MESSAGE) = msg
	End Property

	Public Property Get SuccessMessage()
		SuccessMessage = Session(EW_SESSION_SUCCESS_MESSAGE)
	End Property

	Public Property Let SuccessMessage(v)
		Dim msg
		msg = Session(EW_SESSION_SUCCESS_MESSAGE)
		Call ew_AddMessage(msg, v)
		Session(EW_SESSION_SUCCESS_MESSAGE) = msg
	End Property

	Public Property Get WarningMessage()
		WarningMessage = Session(EW_SESSION_WARNING_MESSAGE)
	End Property

	Public Property Let WarningMessage(v)
		Dim msg
		msg = Session(EW_SESSION_WARNING_MESSAGE)
		Call ew_AddMessage(msg, v)
		Session(EW_SESSION_WARNING_MESSAGE) = msg
	End Property

	' Show Message
	Public Sub ShowMessage()
		Dim hidden, html, sMessage
		hidden = False
		html = ""

		' Message
		sMessage = Message
		Call Message_Showing(sMessage, "")
		If sMessage <> "" Then ' Message in Session, display
			If Not hidden Then sMessage = "<button type=""button"" class=""close"" data-dismiss=""alert"">&times;</button>" & sMessage
			html = html & "<div class=""alert alert-info ewInfo"">" & sMessage & "</div>"
			Session(EW_SESSION_MESSAGE) = "" ' Clear message in Session
		End If

		' Warning message
		Dim sWarningMessage
		sWarningMessage = WarningMessage
		Call Message_Showing(sWarningMessage, "warning")
		If sWarningMessage <> "" Then ' Message in Session, display
			If Not hidden Then sWarningMessage = "<button type=""button"" class=""close"" data-dismiss=""alert"">&times;</button>" & sWarningMessage
			html = html & "<div class=""alert alert-warning ewWarning"">" & sWarningMessage & "</div>"
			Session(EW_SESSION_WARNING_MESSAGE) = "" ' Clear message in Session
		End If

		' Success message
		Dim sSuccessMessage
		sSuccessMessage = SuccessMessage
		Call Message_Showing(sSuccessMessage, "success")
		If sSuccessMessage <> "" Then ' Message in Session, display
			If Not hidden Then sSuccessMessage = "<button type=""button"" class=""close"" data-dismiss=""alert"">&times;</button>" & sSuccessMessage
			html = html & "<div class=""alert alert-success ewSuccess"">" & sSuccessMessage & "</div>"
			Session(EW_SESSION_SUCCESS_MESSAGE) = "" ' Clear message in Session
		End If

		' Failure message
		Dim sErrorMessage
		sErrorMessage = FailureMessage
		Call Message_Showing(sErrorMessage, "failure")
		If sErrorMessage <> "" Then ' Message in Session, display
			If Not hidden Then sErrorMessage = "<button type=""button"" class=""close"" data-dismiss=""alert"">&times;</button>" & sErrorMessage
			html = html & "<div class=""alert alert-danger ewError"">" & sErrorMessage & "</div>"
			Session(EW_SESSION_FAILURE_MESSAGE) = "" ' Clear message in Session
		End If
		Response.Write "<div class=""ewMessageDialog""" & ew_IIf(hidden, " style=""display: none;""", "") & ">" & html & "</div>"
	End Sub
	Dim PageHeader
	Dim PageFooter

	' Show Page Header
	Public Sub ShowPageHeader()
		Dim sHeader
		sHeader = PageHeader
		Call Page_DataRendering(sHeader)
		If sHeader <> "" Then ' Header exists, display
			Response.Write "<p>" & sHeader & "</p>"
		End If
	End Sub

	' Show Page Footer
	Public Sub ShowPageFooter()
		Dim sFooter
		sFooter = PageFooter
		Call Page_DataRendered(sFooter)
		If sFooter <> "" Then ' Footer exists, display
			Response.Write "<p>" & sFooter & "</p>"
		End If
	End Sub

	' -----------------------
	'  Validate Page request
	'
	Public Function IsPageRequest()
		If MenuItems.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (MenuItems.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (MenuItems.TableVar = Request.QueryString("t"))
			End If
		Else
			IsPageRequest = True
		End If
	End Function
	Dim Token
	Dim CheckToken

	' Valid Post
	Function ValidPost()
		If Not CheckToken Or Not ew_IsHttpPost() Then
			ValidPost = True
			Exit Function
		End If
		If Request.Form(EW_TOKEN_NAME).Count = 0 Then
			ValidPost = False
			Exit Function
		End If
		ValidPost = ew_CheckToken(Request.Form(EW_TOKEN_NAME))
	End Function

	' Create Token
	Sub CreateToken()
		If CheckToken And Token = "" Then
			Token = ew_CreateToken()
			gsToken = Token ' Save to global variable
		End If
	End Sub

	' -----------------------------------------------------------------
	'  Class initialize
	'  - init objects
	'  - open ADO connection
	'
	Private Sub Class_Initialize()
		If IsEmpty(StartTimer) Then StartTimer = Timer ' Init start time

		' Check Token
		Token = ""
		CheckToken = EW_CHECK_TOKEN

		' Initialize language object
		If IsEmpty(Language) Then
			Set Language = New cLanguage
			Call Language.LoadPhrases()
		End If

		' Initialize table object
		If IsEmpty(MenuItems) Then Set MenuItems = New cMenuItems
		Set Table = MenuItems

		' Initialize urls
		' Initialize form object

		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "update"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "MenuItems"

		' Open connection to the database
		If IsEmpty(Conn) Then Call ew_Connect()
	End Sub

	' -----------------------------------------------------------------
	'  Subroutine Page_Init
	'  - called before page main
	'  - check Security
	'  - set up response header
	'  - call page load events
	'
	Sub Page_Init()

		' Create form object
		'If ew_IsHttpPost() Then

			Set ObjForm = New cFormObj

		'Else
		'	Set ObjForm = ew_GetUploadObj()
		'End If

		MenuItems.CurrentAction = ew_IIf(Request.QueryString("a").Count > 0, Request.QueryString("a") & "", ObjForm.GetValue("a_list") & "") ' Set up current action

		' Global page loading event (in userfn*.asp)
		Page_Loading()

		' Page load event, used in current page
		Page_Load()

		' Check token
		If Not ValidPost() Then
			Response.Write Language.Phrase("InvalidPostRequest")
			Call Page_Terminate("")
			Response.End
		End If

		' Process auto fill
		Dim results
		If Request.Form("ajax") = "autofill" Then
			results = MenuItems.GetAutoFill(Request.Form("name"), Request.Form("q"))
			If results <> "" Then

				' Clean output buffer
				If Response.Buffer Then Response.Clear
				Response.Write results
				Call Page_Terminate("")
				Response.End
			End If
		End If

		' Create Token
		CreateToken()
	End Sub

	' -----------------------------------------------------------------
	'  Class terminate
	'  - clean up page object
	'
	Private Sub Class_Terminate()
		Call Page_Terminate("")
	End Sub

	' -----------------------------------------------------------------
	'  Subroutine Page_Terminate
	'  - called when exit page
	'  - clean up ADO connection and objects
	'  - if url specified, redirect to url
	'
	Sub Page_Terminate(url)
		If Request.Form("customexport")&"" = "" Then

			' Page unload event, used in current page
			Call Page_Unload()

			' Global page unloaded event (in userfn*.asp)
			Call Page_Unloaded()
		End If

		' Export
		If Not MenuItems Is Nothing Then
			If MenuItems.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = MenuItems.TableVar
				If MenuItems.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf MenuItems.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf MenuItems.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf MenuItems.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set MenuItems = Nothing
		Set ObjForm = Nothing

		' Go to url if specified
		If gsExport & "" = "" Then
			If sReDirectUrl <> "" Then
				If Response.Buffer Then Response.Clear
				Response.Redirect sReDirectUrl
			End If
		End If
	End Sub

	'
	'  Subroutine Page_Terminate (End)
	' ----------------------------------------

	Dim RecKeys
	Dim Disabled
	Dim Recordset
	Dim UpdateCount

	' -----------------------------------------------------------------
	' Page main processing
	'
	Sub Page_Main()
		Dim sKeyName
		Dim sKey
		Dim nKeySelected
		Dim bUpdateSelected
		UpdateCount = 0

		' Set up Breadcrumb
		SetupBreadcrumb()
		RecKeys = MenuItems.GetRecordKeys() ' Load record keys
		If ObjForm.GetValue("a_update")&"" <> "" Then

			' Get action
			MenuItems.CurrentAction = ObjForm.GetValue("a_update")
			Call LoadFormValues() ' Get form values

			' Validate form
			If Not ValidateForm() Then
				MenuItems.CurrentAction = "I" ' Form error, reset action
				FailureMessage = gsFormError
			End If
		Else
			Call LoadMultiUpdateValues() ' Load initial values to form
		End If
		If Not IsArray(RecKeys) Then
			Call Page_Terminate("MenuItemslist.asp") ' No records selected, return to list
		End If
		Select Case MenuItems.CurrentAction
			Case "U" ' Update
				If UpdateRows() Then ' Update Records based on key
					If SuccessMessage = "" Then SuccessMessage = Language.Phrase("UpdateSuccess") ' Set update success message
					Call Page_Terminate(MenuItems.ReturnUrl) ' Return to caller
				Else
					Call RestoreFormValues() ' Restore form values
				End If
		End Select

		' Render row
		MenuItems.RowType = EW_ROWTYPE_EDIT ' Render edit

		' Render row
		Call MenuItems.ResetAttrs()
		Call RenderRow()
	End Sub

	' -----------------------------------------------------------------
	' Load initial values to form if field values are identical in all selected records
	'
	Sub LoadMultiUpdateValues()
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		Dim Rs, i, OldValue, NewValue
		MenuItems.CurrentFilter = MenuItems.GetKeyFilter()

		' Load recordset
		Set Rs = LoadRecordset()
		i = 1
		Do While Not Rs.Eof
			If i = 1 Then
				MenuItems.Code.DbValue = ew_Conv(Rs("Code"), Rs("Code").Type)
				MenuItems.Name.DbValue = ew_Conv(Rs("Name"), Rs("Name").Type)
				MenuItems.Description.DbValue = ew_Conv(Rs("Description"), Rs("Description").Type)
				MenuItems.Vegetarian.DbValue = ew_Conv(Rs("Vegetarian"), Rs("Vegetarian").Type)
				MenuItems.Spicyness.DbValue = ew_Conv(Rs("Spicyness"), Rs("Spicyness").Type)
				MenuItems.Price.DbValue = ew_Conv(Rs("Price"), Rs("Price").Type)
				MenuItems.IdMenuCategory.DbValue = ew_Conv(Rs("IdMenuCategory"), Rs("IdMenuCategory").Type)
				MenuItems.IdBusinessDetail.DbValue = ew_Conv(Rs("IdBusinessDetail"), Rs("IdBusinessDetail").Type)
				MenuItems.Photo.DbValue = ew_Conv(Rs("Photo"), Rs("Photo").Type)
				MenuItems.allowtoppings.DbValue = ew_Conv(Rs("allowtoppings"), Rs("allowtoppings").Type)
				MenuItems.dishpropertygroupid.DbValue = ew_Conv(Rs("dishpropertygroupid"), Rs("dishpropertygroupid").Type)
				MenuItems.hidedish.DbValue = ew_Conv(Rs("hidedish"), Rs("hidedish").Type)
				MenuItems.PrintingName.DbValue = ew_Conv(Rs("PrintingName"), Rs("PrintingName").Type)
				MenuItems.i_displaySort.DbValue = ew_Conv(Rs("i_displaySort"), Rs("i_displaySort").Type)
			Else
				OldValue = MenuItems.Code.DbValue
				NewValue = ew_Conv(Rs("Code"), Rs("Code").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					MenuItems.Code.CurrentValue = Null
				End If
				OldValue = MenuItems.Name.DbValue
				NewValue = ew_Conv(Rs("Name"), Rs("Name").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					MenuItems.Name.CurrentValue = Null
				End If
				OldValue = MenuItems.Description.DbValue
				NewValue = ew_Conv(Rs("Description"), Rs("Description").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					MenuItems.Description.CurrentValue = Null
				End If
				OldValue = MenuItems.Vegetarian.DbValue
				NewValue = ew_Conv(Rs("Vegetarian"), Rs("Vegetarian").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					MenuItems.Vegetarian.CurrentValue = Null
				End If
				OldValue = MenuItems.Spicyness.DbValue
				NewValue = ew_Conv(Rs("Spicyness"), Rs("Spicyness").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					MenuItems.Spicyness.CurrentValue = Null
				End If
				OldValue = MenuItems.Price.DbValue
				NewValue = ew_Conv(Rs("Price"), Rs("Price").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					MenuItems.Price.CurrentValue = Null
				End If
				OldValue = MenuItems.IdMenuCategory.DbValue
				NewValue = ew_Conv(Rs("IdMenuCategory"), Rs("IdMenuCategory").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					MenuItems.IdMenuCategory.CurrentValue = Null
				End If
				OldValue = MenuItems.IdBusinessDetail.DbValue
				NewValue = ew_Conv(Rs("IdBusinessDetail"), Rs("IdBusinessDetail").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					MenuItems.IdBusinessDetail.CurrentValue = Null
				End If
				OldValue = MenuItems.Photo.DbValue
				NewValue = ew_Conv(Rs("Photo"), Rs("Photo").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					MenuItems.Photo.CurrentValue = Null
				End If
				OldValue = MenuItems.allowtoppings.DbValue
				NewValue = ew_Conv(Rs("allowtoppings"), Rs("allowtoppings").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					MenuItems.allowtoppings.CurrentValue = Null
				End If
				OldValue = MenuItems.dishpropertygroupid.DbValue
				NewValue = ew_Conv(Rs("dishpropertygroupid"), Rs("dishpropertygroupid").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					MenuItems.dishpropertygroupid.CurrentValue = Null
				End If
				OldValue = MenuItems.hidedish.DbValue
				NewValue = ew_Conv(Rs("hidedish"), Rs("hidedish").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					MenuItems.hidedish.CurrentValue = Null
				End If
				OldValue = MenuItems.PrintingName.DbValue
				NewValue = ew_Conv(Rs("PrintingName"), Rs("PrintingName").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					MenuItems.PrintingName.CurrentValue = Null
				End If
				OldValue = MenuItems.i_displaySort.DbValue
				NewValue = ew_Conv(Rs("i_displaySort"), Rs("i_displaySort").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					MenuItems.i_displaySort.CurrentValue = Null
				End If
			End If
			i = i + 1
			Rs.MoveNext
		Loop
		Rs.Close
		Set Rs = Nothing
	End Sub

	' -----------------------------------------------------------------
	'  Set up key value
	'
	Function SetupKeyValues(key)
		Dim sKeyFld
		Dim sWrkFilter, sFilter
		sKeyFld = key
		If Not IsNumeric(sKeyFld) Then
			SetupKeyValues = False
			Exit Function
		End If
		MenuItems.Id.CurrentValue = sKeyFld ' Set up key value
		SetupKeyValues = True
	End Function

	' -----------------------------------------------------------------
	' Update all selected rows
	'
	Function UpdateRows()
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		Dim sKey, sThisKey
		Dim Rs, RsOld, RsNew, sSql, i
		Conn.BeginTrans

		' Get old recordset
		MenuItems.CurrentFilter = MenuItems.GetKeyFilter()
		sSql = MenuItems.SQL
		Set Rs = Server.CreateObject("ADODB.Recordset")
		Rs.CursorLocation = EW_CURSORLOCATION
		Rs.Open sSql, Conn, 1, EW_RECORDSET_LOCKTYPE
		Set RsOld = ew_CloneRs(Rs)

		' Update all rows
		sKey = ""
		For i = 0 to UBound(RecKeys)
			If SetupKeyValues(RecKeys(i)) Then
				sThisKey = RecKeys(i)
				MenuItems.SendEmail = False ' Do not send email on update success
				UpdateCount = UpdateCount + 1 ' Update record count for records being updated
				UpdateRows = EditRow() ' Update this row
			Else
				UpdateRows = False
			End If
			If Not UpdateRows Then Exit For ' Update failed
			If sKey <> "" Then sKey = sKey & ", "
			sKey = sKey & sThisKey
		Next
		If UpdateRows Then
			Conn.CommitTrans ' Commit transaction

			' Get new recordset
			Set Rs = Conn.Execute(sSql)
			Set RsNew = ew_CloneRs(Rs)
		Else
			Conn.RollbackTrans ' Rollback transaction
		End If
		Set Rs = Nothing
		Set RsOld = Nothing
		Set RsNew = Nothing
	End Function

	' -----------------------------------------------------------------
	' Function Get upload files
	'
	Function GetUploadFiles()

		' Get upload data
	End Function

	' -----------------------------------------------------------------
	' Load form values
	'
	Function LoadFormValues()

		' Load values from form
		If Not MenuItems.Code.FldIsDetailKey Then MenuItems.Code.FormValue = ObjForm.GetValue("x_Code")
		MenuItems.Code.MultiUpdate = ObjForm.GetValue("u_Code")
		If Not MenuItems.Name.FldIsDetailKey Then MenuItems.Name.FormValue = ObjForm.GetValue("x_Name")
		MenuItems.Name.MultiUpdate = ObjForm.GetValue("u_Name")
		If Not MenuItems.Description.FldIsDetailKey Then MenuItems.Description.FormValue = ObjForm.GetValue("x_Description")
		MenuItems.Description.MultiUpdate = ObjForm.GetValue("u_Description")
		If Not MenuItems.Vegetarian.FldIsDetailKey Then MenuItems.Vegetarian.FormValue = ObjForm.GetValue("x_Vegetarian")
		MenuItems.Vegetarian.MultiUpdate = ObjForm.GetValue("u_Vegetarian")
		If Not MenuItems.Spicyness.FldIsDetailKey Then MenuItems.Spicyness.FormValue = ObjForm.GetValue("x_Spicyness")
		MenuItems.Spicyness.MultiUpdate = ObjForm.GetValue("u_Spicyness")
		If Not MenuItems.Price.FldIsDetailKey Then MenuItems.Price.FormValue = ObjForm.GetValue("x_Price")
		MenuItems.Price.MultiUpdate = ObjForm.GetValue("u_Price")
		If Not MenuItems.IdMenuCategory.FldIsDetailKey Then MenuItems.IdMenuCategory.FormValue = ObjForm.GetValue("x_IdMenuCategory")
		MenuItems.IdMenuCategory.MultiUpdate = ObjForm.GetValue("u_IdMenuCategory")
		If Not MenuItems.IdBusinessDetail.FldIsDetailKey Then MenuItems.IdBusinessDetail.FormValue = ObjForm.GetValue("x_IdBusinessDetail")
		MenuItems.IdBusinessDetail.MultiUpdate = ObjForm.GetValue("u_IdBusinessDetail")
		If Not MenuItems.Photo.FldIsDetailKey Then MenuItems.Photo.FormValue = ObjForm.GetValue("x_Photo")
		MenuItems.Photo.MultiUpdate = ObjForm.GetValue("u_Photo")
		If Not MenuItems.allowtoppings.FldIsDetailKey Then MenuItems.allowtoppings.FormValue = ObjForm.GetValue("x_allowtoppings")
		MenuItems.allowtoppings.MultiUpdate = ObjForm.GetValue("u_allowtoppings")
		If Not MenuItems.dishpropertygroupid.FldIsDetailKey Then MenuItems.dishpropertygroupid.FormValue = ObjForm.GetValue("x_dishpropertygroupid")
		MenuItems.dishpropertygroupid.MultiUpdate = ObjForm.GetValue("u_dishpropertygroupid")
		If Not MenuItems.hidedish.FldIsDetailKey Then MenuItems.hidedish.FormValue = ObjForm.GetValue("x_hidedish")
		MenuItems.hidedish.MultiUpdate = ObjForm.GetValue("u_hidedish")
		If Not MenuItems.PrintingName.FldIsDetailKey Then MenuItems.PrintingName.FormValue = ObjForm.GetValue("x_PrintingName")
		MenuItems.PrintingName.MultiUpdate = ObjForm.GetValue("u_PrintingName")
		If Not MenuItems.i_displaySort.FldIsDetailKey Then MenuItems.i_displaySort.FormValue = ObjForm.GetValue("x_i_displaySort")
		MenuItems.i_displaySort.MultiUpdate = ObjForm.GetValue("u_i_displaySort")
		If Not MenuItems.Id.FldIsDetailKey Then MenuItems.Id.FormValue = ObjForm.GetValue("x_Id")
	End Function

	' -----------------------------------------------------------------
	' Restore form values
	'
	Function RestoreFormValues()
		MenuItems.Code.CurrentValue = MenuItems.Code.FormValue
		MenuItems.Name.CurrentValue = MenuItems.Name.FormValue
		MenuItems.Description.CurrentValue = MenuItems.Description.FormValue
		MenuItems.Vegetarian.CurrentValue = MenuItems.Vegetarian.FormValue
		MenuItems.Spicyness.CurrentValue = MenuItems.Spicyness.FormValue
		MenuItems.Price.CurrentValue = MenuItems.Price.FormValue
		MenuItems.IdMenuCategory.CurrentValue = MenuItems.IdMenuCategory.FormValue
		MenuItems.IdBusinessDetail.CurrentValue = MenuItems.IdBusinessDetail.FormValue
		MenuItems.Photo.CurrentValue = MenuItems.Photo.FormValue
		MenuItems.allowtoppings.CurrentValue = MenuItems.allowtoppings.FormValue
		MenuItems.dishpropertygroupid.CurrentValue = MenuItems.dishpropertygroupid.FormValue
		MenuItems.hidedish.CurrentValue = MenuItems.hidedish.FormValue
		MenuItems.PrintingName.CurrentValue = MenuItems.PrintingName.FormValue
		MenuItems.i_displaySort.CurrentValue = MenuItems.i_displaySort.FormValue
		MenuItems.Id.CurrentValue = MenuItems.Id.FormValue
	End Function

	' -----------------------------------------------------------------
	' Load recordset
	'
	Function LoadRecordset()

		' Load list page sql
		Dim sSql
		sSql = MenuItems.SelectSQL
		Call ew_SetDebugMsg("LoadRecordset: " & sSql) ' Show SQL for debugging

		' Load recordset
		Dim RsRecordset
		Set RsRecordset = ew_LoadRecordset(sSql)

		' Call Recordset Selected event
		Call MenuItems.Recordset_Selected(RsRecordset)
		Set LoadRecordset = RsRecordset
	End Function

	' -----------------------------------------------------------------
	' Load row based on key values
	'
	Function LoadRow()
		Dim RsRow, sSql, sFilter
		sFilter = MenuItems.KeyFilter

		' Call Row Selecting event
		Call MenuItems.Row_Selecting(sFilter)

		' Load sql based on filter
		MenuItems.CurrentFilter = sFilter
		sSql = MenuItems.SQL
		Call ew_SetDebugMsg("LoadRow: " & sSql) ' Show SQL for debugging
		Set RsRow = ew_LoadRow(sSql)
		If RsRow.Eof Then
			LoadRow = False
		Else
			LoadRow = True
			RsRow.MoveFirst
			Call LoadRowValues(RsRow) ' Load row values
		End If
		RsRow.Close
		Set RsRow = Nothing
	End Function

	' -----------------------------------------------------------------
	' Load row values from recordset
	'
	Sub LoadRowValues(RsRow)
		Dim sDetailFilter
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		If RsRow.Eof Then Exit Sub

		' Call Row Selected event
		Call MenuItems.Row_Selected(RsRow)
		MenuItems.Id.DbValue = RsRow("Id")
		MenuItems.Code.DbValue = RsRow("Code")
		MenuItems.Name.DbValue = RsRow("Name")
		MenuItems.Description.DbValue = RsRow("Description")
		MenuItems.Vegetarian.DbValue = RsRow("Vegetarian")
		MenuItems.Spicyness.DbValue = RsRow("Spicyness")
		MenuItems.Price.DbValue = ew_Conv(RsRow("Price"), 131)
		MenuItems.IdMenuCategory.DbValue = RsRow("IdMenuCategory")
		MenuItems.IdBusinessDetail.DbValue = RsRow("IdBusinessDetail")
		MenuItems.Photo.DbValue = RsRow("Photo")
		MenuItems.allowtoppings.DbValue = RsRow("allowtoppings")
		MenuItems.dishpropertygroupid.DbValue = RsRow("dishpropertygroupid")
		MenuItems.hidedish.DbValue = RsRow("hidedish")
		MenuItems.PrintingName.DbValue = RsRow("PrintingName")
		MenuItems.i_displaySort.DbValue = RsRow("i_displaySort")
	End Sub

	' Load DbValue from recordset
	Sub LoadDbValues(Rs)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		If Rs.Eof Then Exit Sub
		MenuItems.Id.m_DbValue = Rs("Id")
		MenuItems.Code.m_DbValue = Rs("Code")
		MenuItems.Name.m_DbValue = Rs("Name")
		MenuItems.Description.m_DbValue = Rs("Description")
		MenuItems.Vegetarian.m_DbValue = Rs("Vegetarian")
		MenuItems.Spicyness.m_DbValue = Rs("Spicyness")
		MenuItems.Price.m_DbValue = ew_Conv(Rs("Price"), 131)
		MenuItems.IdMenuCategory.m_DbValue = Rs("IdMenuCategory")
		MenuItems.IdBusinessDetail.m_DbValue = Rs("IdBusinessDetail")
		MenuItems.Photo.m_DbValue = Rs("Photo")
		MenuItems.allowtoppings.m_DbValue = Rs("allowtoppings")
		MenuItems.dishpropertygroupid.m_DbValue = Rs("dishpropertygroupid")
		MenuItems.hidedish.m_DbValue = Rs("hidedish")
		MenuItems.PrintingName.m_DbValue = Rs("PrintingName")
		MenuItems.i_displaySort.m_DbValue = Rs("i_displaySort")
	End Sub

	' -----------------------------------------------------------------
	' Render row values based on field settings
	'
	Sub RenderRow()

		' Initialize urls
		' Convert decimal values if posted back

		If MenuItems.Price.CurrentValue & "" <> "" Then MenuItems.Price.CurrentValue = ew_Conv(MenuItems.Price.CurrentValue, MenuItems.Price.FldType)
		If MenuItems.Price.FormValue = MenuItems.Price.CurrentValue And IsNumeric(MenuItems.Price.CurrentValue) Then
			MenuItems.Price.CurrentValue = ew_StrToFloat(MenuItems.Price.CurrentValue)
		End If

		' Call Row Rendering event
		Call MenuItems.Row_Rendering()

		' ---------------------------------------
		'  Common render codes for all row types
		' ---------------------------------------
		' Id
		' Code
		' Name
		' Description
		' Vegetarian
		' Spicyness
		' Price
		' IdMenuCategory
		' IdBusinessDetail
		' Photo
		' allowtoppings
		' dishpropertygroupid
		' hidedish
		' PrintingName
		' i_displaySort
		' -----------
		'  View  Row
		' -----------

		If MenuItems.RowType = EW_ROWTYPE_VIEW Then ' View row

			' Id
			MenuItems.Id.ViewValue = MenuItems.Id.CurrentValue
			MenuItems.Id.ViewCustomAttributes = ""

			' Code
			MenuItems.Code.ViewValue = MenuItems.Code.CurrentValue
			MenuItems.Code.ViewCustomAttributes = ""

			' Name
			MenuItems.Name.ViewValue = MenuItems.Name.CurrentValue
			MenuItems.Name.ViewCustomAttributes = ""

			' Description
			MenuItems.Description.ViewValue = MenuItems.Description.CurrentValue
			MenuItems.Description.ViewCustomAttributes = ""

			' Vegetarian
			MenuItems.Vegetarian.ViewValue = MenuItems.Vegetarian.CurrentValue
			MenuItems.Vegetarian.ViewCustomAttributes = ""

			' Spicyness
			MenuItems.Spicyness.ViewValue = MenuItems.Spicyness.CurrentValue
			MenuItems.Spicyness.ViewCustomAttributes = ""

			' Price
			MenuItems.Price.ViewValue = MenuItems.Price.CurrentValue
			MenuItems.Price.ViewCustomAttributes = ""

			' IdMenuCategory
			MenuItems.IdMenuCategory.ViewValue = MenuItems.IdMenuCategory.CurrentValue
			MenuItems.IdMenuCategory.ViewCustomAttributes = ""

			' IdBusinessDetail
			MenuItems.IdBusinessDetail.ViewValue = MenuItems.IdBusinessDetail.CurrentValue
			MenuItems.IdBusinessDetail.ViewCustomAttributes = ""

			' Photo
			MenuItems.Photo.ViewValue = MenuItems.Photo.CurrentValue
			MenuItems.Photo.ViewCustomAttributes = ""

			' allowtoppings
			MenuItems.allowtoppings.ViewValue = MenuItems.allowtoppings.CurrentValue
			MenuItems.allowtoppings.ViewCustomAttributes = ""

			' dishpropertygroupid
			MenuItems.dishpropertygroupid.ViewValue = MenuItems.dishpropertygroupid.CurrentValue
			MenuItems.dishpropertygroupid.ViewCustomAttributes = ""

			' hidedish
			MenuItems.hidedish.ViewValue = MenuItems.hidedish.CurrentValue
			MenuItems.hidedish.ViewCustomAttributes = ""

			' PrintingName
			MenuItems.PrintingName.ViewValue = MenuItems.PrintingName.CurrentValue
			MenuItems.PrintingName.ViewCustomAttributes = ""

			' i_displaySort
			MenuItems.i_displaySort.ViewValue = MenuItems.i_displaySort.CurrentValue
			MenuItems.i_displaySort.ViewCustomAttributes = ""

			' View refer script
			' Code

			MenuItems.Code.LinkCustomAttributes = ""
			MenuItems.Code.HrefValue = ""
			MenuItems.Code.TooltipValue = ""

			' Name
			MenuItems.Name.LinkCustomAttributes = ""
			MenuItems.Name.HrefValue = ""
			MenuItems.Name.TooltipValue = ""

			' Description
			MenuItems.Description.LinkCustomAttributes = ""
			MenuItems.Description.HrefValue = ""
			MenuItems.Description.TooltipValue = ""

			' Vegetarian
			MenuItems.Vegetarian.LinkCustomAttributes = ""
			MenuItems.Vegetarian.HrefValue = ""
			MenuItems.Vegetarian.TooltipValue = ""

			' Spicyness
			MenuItems.Spicyness.LinkCustomAttributes = ""
			MenuItems.Spicyness.HrefValue = ""
			MenuItems.Spicyness.TooltipValue = ""

			' Price
			MenuItems.Price.LinkCustomAttributes = ""
			MenuItems.Price.HrefValue = ""
			MenuItems.Price.TooltipValue = ""

			' IdMenuCategory
			MenuItems.IdMenuCategory.LinkCustomAttributes = ""
			MenuItems.IdMenuCategory.HrefValue = ""
			MenuItems.IdMenuCategory.TooltipValue = ""

			' IdBusinessDetail
			MenuItems.IdBusinessDetail.LinkCustomAttributes = ""
			MenuItems.IdBusinessDetail.HrefValue = ""
			MenuItems.IdBusinessDetail.TooltipValue = ""

			' Photo
			MenuItems.Photo.LinkCustomAttributes = ""
			MenuItems.Photo.HrefValue = ""
			MenuItems.Photo.TooltipValue = ""

			' allowtoppings
			MenuItems.allowtoppings.LinkCustomAttributes = ""
			MenuItems.allowtoppings.HrefValue = ""
			MenuItems.allowtoppings.TooltipValue = ""

			' dishpropertygroupid
			MenuItems.dishpropertygroupid.LinkCustomAttributes = ""
			MenuItems.dishpropertygroupid.HrefValue = ""
			MenuItems.dishpropertygroupid.TooltipValue = ""

			' hidedish
			MenuItems.hidedish.LinkCustomAttributes = ""
			MenuItems.hidedish.HrefValue = ""
			MenuItems.hidedish.TooltipValue = ""

			' PrintingName
			MenuItems.PrintingName.LinkCustomAttributes = ""
			MenuItems.PrintingName.HrefValue = ""
			MenuItems.PrintingName.TooltipValue = ""

			' i_displaySort
			MenuItems.i_displaySort.LinkCustomAttributes = ""
			MenuItems.i_displaySort.HrefValue = ""
			MenuItems.i_displaySort.TooltipValue = ""

		' ----------
		'  Edit Row
		' ----------

		ElseIf MenuItems.RowType = EW_ROWTYPE_EDIT Then ' Edit row

			' Code
			MenuItems.Code.EditAttrs.UpdateAttribute "class", "form-control"
			MenuItems.Code.EditCustomAttributes = ""
			MenuItems.Code.EditValue = ew_HtmlEncode(MenuItems.Code.CurrentValue)
			MenuItems.Code.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuItems.Code.FldCaption))

			' Name
			MenuItems.Name.EditAttrs.UpdateAttribute "class", "form-control"
			MenuItems.Name.EditCustomAttributes = ""
			MenuItems.Name.EditValue = ew_HtmlEncode(MenuItems.Name.CurrentValue)
			MenuItems.Name.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuItems.Name.FldCaption))

			' Description
			MenuItems.Description.EditAttrs.UpdateAttribute "class", "form-control"
			MenuItems.Description.EditCustomAttributes = ""
			MenuItems.Description.EditValue = ew_HtmlEncode(MenuItems.Description.CurrentValue)
			MenuItems.Description.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuItems.Description.FldCaption))

			' Vegetarian
			MenuItems.Vegetarian.EditAttrs.UpdateAttribute "class", "form-control"
			MenuItems.Vegetarian.EditCustomAttributes = ""
			MenuItems.Vegetarian.EditValue = ew_HtmlEncode(MenuItems.Vegetarian.CurrentValue)
			MenuItems.Vegetarian.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuItems.Vegetarian.FldCaption))

			' Spicyness
			MenuItems.Spicyness.EditAttrs.UpdateAttribute "class", "form-control"
			MenuItems.Spicyness.EditCustomAttributes = ""
			MenuItems.Spicyness.EditValue = ew_HtmlEncode(MenuItems.Spicyness.CurrentValue)
			MenuItems.Spicyness.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuItems.Spicyness.FldCaption))

			' Price
			MenuItems.Price.EditAttrs.UpdateAttribute "class", "form-control"
			MenuItems.Price.EditCustomAttributes = ""
			MenuItems.Price.EditValue = ew_HtmlEncode(MenuItems.Price.CurrentValue)
			MenuItems.Price.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuItems.Price.FldCaption))
			If MenuItems.Price.EditValue&"" <> "" And IsNumeric(MenuItems.Price.EditValue) Then MenuItems.Price.EditValue = ew_FormatNumber2(MenuItems.Price.EditValue, -2)

			' IdMenuCategory
			MenuItems.IdMenuCategory.EditAttrs.UpdateAttribute "class", "form-control"
			MenuItems.IdMenuCategory.EditCustomAttributes = ""
			MenuItems.IdMenuCategory.EditValue = ew_HtmlEncode(MenuItems.IdMenuCategory.CurrentValue)
			MenuItems.IdMenuCategory.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuItems.IdMenuCategory.FldCaption))

			' IdBusinessDetail
			MenuItems.IdBusinessDetail.EditAttrs.UpdateAttribute "class", "form-control"
			MenuItems.IdBusinessDetail.EditCustomAttributes = ""
			MenuItems.IdBusinessDetail.EditValue = ew_HtmlEncode(MenuItems.IdBusinessDetail.CurrentValue)
			MenuItems.IdBusinessDetail.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuItems.IdBusinessDetail.FldCaption))

			' Photo
			MenuItems.Photo.EditAttrs.UpdateAttribute "class", "form-control"
			MenuItems.Photo.EditCustomAttributes = ""
			MenuItems.Photo.EditValue = ew_HtmlEncode(MenuItems.Photo.CurrentValue)
			MenuItems.Photo.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuItems.Photo.FldCaption))

			' allowtoppings
			MenuItems.allowtoppings.EditAttrs.UpdateAttribute "class", "form-control"
			MenuItems.allowtoppings.EditCustomAttributes = ""
			MenuItems.allowtoppings.EditValue = ew_HtmlEncode(MenuItems.allowtoppings.CurrentValue)
			MenuItems.allowtoppings.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuItems.allowtoppings.FldCaption))

			' dishpropertygroupid
			MenuItems.dishpropertygroupid.EditAttrs.UpdateAttribute "class", "form-control"
			MenuItems.dishpropertygroupid.EditCustomAttributes = ""
			MenuItems.dishpropertygroupid.EditValue = ew_HtmlEncode(MenuItems.dishpropertygroupid.CurrentValue)
			MenuItems.dishpropertygroupid.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuItems.dishpropertygroupid.FldCaption))

			' hidedish
			MenuItems.hidedish.EditAttrs.UpdateAttribute "class", "form-control"
			MenuItems.hidedish.EditCustomAttributes = ""
			MenuItems.hidedish.EditValue = ew_HtmlEncode(MenuItems.hidedish.CurrentValue)
			MenuItems.hidedish.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuItems.hidedish.FldCaption))

			' PrintingName
			MenuItems.PrintingName.EditAttrs.UpdateAttribute "class", "form-control"
			MenuItems.PrintingName.EditCustomAttributes = ""
			MenuItems.PrintingName.EditValue = ew_HtmlEncode(MenuItems.PrintingName.CurrentValue)
			MenuItems.PrintingName.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuItems.PrintingName.FldCaption))

			' i_displaySort
			MenuItems.i_displaySort.EditAttrs.UpdateAttribute "class", "form-control"
			MenuItems.i_displaySort.EditCustomAttributes = ""
			MenuItems.i_displaySort.EditValue = ew_HtmlEncode(MenuItems.i_displaySort.CurrentValue)
			MenuItems.i_displaySort.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuItems.i_displaySort.FldCaption))

			' Edit refer script
			' Code

			MenuItems.Code.HrefValue = ""

			' Name
			MenuItems.Name.HrefValue = ""

			' Description
			MenuItems.Description.HrefValue = ""

			' Vegetarian
			MenuItems.Vegetarian.HrefValue = ""

			' Spicyness
			MenuItems.Spicyness.HrefValue = ""

			' Price
			MenuItems.Price.HrefValue = ""

			' IdMenuCategory
			MenuItems.IdMenuCategory.HrefValue = ""

			' IdBusinessDetail
			MenuItems.IdBusinessDetail.HrefValue = ""

			' Photo
			MenuItems.Photo.HrefValue = ""

			' allowtoppings
			MenuItems.allowtoppings.HrefValue = ""

			' dishpropertygroupid
			MenuItems.dishpropertygroupid.HrefValue = ""

			' hidedish
			MenuItems.hidedish.HrefValue = ""

			' PrintingName
			MenuItems.PrintingName.HrefValue = ""

			' i_displaySort
			MenuItems.i_displaySort.HrefValue = ""
		End If
		If MenuItems.RowType = EW_ROWTYPE_ADD Or MenuItems.RowType = EW_ROWTYPE_EDIT Or MenuItems.RowType = EW_ROWTYPE_SEARCH Then ' Add / Edit / Search row
			Call MenuItems.SetupFieldTitles()
		End If

		' Call Row Rendered event
		If MenuItems.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call MenuItems.Row_Rendered()
		End If
	End Sub

	' -----------------------------------------------------------------
	' Validate form
	'
	Function ValidateForm()

		' Initialize
		gsFormError = ""
		Dim lUpdateCnt
		lUpdateCnt = 0
		If MenuItems.Code.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If MenuItems.Name.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If MenuItems.Description.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If MenuItems.Vegetarian.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If MenuItems.Spicyness.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If MenuItems.Price.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If MenuItems.IdMenuCategory.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If MenuItems.IdBusinessDetail.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If MenuItems.Photo.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If MenuItems.allowtoppings.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If MenuItems.dishpropertygroupid.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If MenuItems.hidedish.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If MenuItems.PrintingName.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If MenuItems.i_displaySort.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If lUpdateCnt = 0 Then
			gsFormError = Language.Phrase("NoFieldSelected")
			ValidateForm = False
			Exit Function
		End If

		' Check if validation required
		If Not EW_SERVER_VALIDATE Then
			ValidateForm = (gsFormError = "")
			Exit Function
		End If
		If MenuItems.Code.MultiUpdate <> "" Then
			If Not ew_CheckInteger(MenuItems.Code.FormValue) Then
				Call ew_AddMessage(gsFormError, MenuItems.Code.FldErrMsg)
			End If
		End If
		If MenuItems.Vegetarian.MultiUpdate <> "" Then
			If Not ew_CheckInteger(MenuItems.Vegetarian.FormValue) Then
				Call ew_AddMessage(gsFormError, MenuItems.Vegetarian.FldErrMsg)
			End If
		End If
		If MenuItems.Spicyness.MultiUpdate <> "" Then
			If Not ew_CheckInteger(MenuItems.Spicyness.FormValue) Then
				Call ew_AddMessage(gsFormError, MenuItems.Spicyness.FldErrMsg)
			End If
		End If
		If MenuItems.Price.MultiUpdate <> "" Then
			If Not ew_CheckNumber(MenuItems.Price.FormValue) Then
				Call ew_AddMessage(gsFormError, MenuItems.Price.FldErrMsg)
			End If
		End If
		If MenuItems.IdMenuCategory.MultiUpdate <> "" Then
			If Not ew_CheckInteger(MenuItems.IdMenuCategory.FormValue) Then
				Call ew_AddMessage(gsFormError, MenuItems.IdMenuCategory.FldErrMsg)
			End If
		End If
		If MenuItems.IdBusinessDetail.MultiUpdate <> "" Then
			If Not ew_CheckInteger(MenuItems.IdBusinessDetail.FormValue) Then
				Call ew_AddMessage(gsFormError, MenuItems.IdBusinessDetail.FldErrMsg)
			End If
		End If
		If MenuItems.allowtoppings.MultiUpdate <> "" Then
			If Not ew_CheckInteger(MenuItems.allowtoppings.FormValue) Then
				Call ew_AddMessage(gsFormError, MenuItems.allowtoppings.FldErrMsg)
			End If
		End If
		If MenuItems.hidedish.MultiUpdate <> "" Then
			If Not ew_CheckInteger(MenuItems.hidedish.FormValue) Then
				Call ew_AddMessage(gsFormError, MenuItems.hidedish.FldErrMsg)
			End If
		End If
		If MenuItems.i_displaySort.MultiUpdate <> "" Then
			If Not ew_CheckInteger(MenuItems.i_displaySort.FormValue) Then
				Call ew_AddMessage(gsFormError, MenuItems.i_displaySort.FldErrMsg)
			End If
		End If

		' Return validate result
		ValidateForm = (gsFormError = "")

		' Call Form Custom Validate event
		Dim sFormCustomError
		sFormCustomError = ""
		ValidateForm = ValidateForm And Form_CustomValidate(sFormCustomError)
		If sFormCustomError <> "" Then
			Call ew_AddMessage(gsFormError, sFormCustomError)
		End If
	End Function

	' -----------------------------------------------------------------
	' Update record based on key values
	'
	Function EditRow()
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		Dim Rs, sSql, sFilter
		Dim RsChk, sSqlChk, sFilterChk
		Dim bUpdateRow
		Dim RsOld, RsNew
		Dim sIdxErrMsg

		' Clear any previous errors
		Err.Clear
		sFilter = MenuItems.KeyFilter
		MenuItems.CurrentFilter  = sFilter
		sSql = MenuItems.SQL
		Set Rs = Server.CreateObject("ADODB.Recordset")
		Rs.CursorLocation = EW_CURSORLOCATION
		Rs.Open sSql, Conn, 1, EW_RECORDSET_LOCKTYPE
		If Err.Number <> 0 Then
			Message = Err.Description
			Rs.Close
			Set Rs = Nothing
			EditRow = False
			Exit Function
		End If

		' Clone old recordset object
		Set RsOld = ew_CloneRs(Rs)
		Call LoadDbValues(RsOld)
		If Rs.Eof Then
			EditRow = False ' Update Failed
		Else

			' Field Code
			Call MenuItems.Code.SetDbValue(Rs, MenuItems.Code.CurrentValue, Null, MenuItems.Code.ReadOnly Or MenuItems.Code.MultiUpdate&"" <> "1")

			' Field Name
			Call MenuItems.Name.SetDbValue(Rs, MenuItems.Name.CurrentValue, Null, MenuItems.Name.ReadOnly Or MenuItems.Name.MultiUpdate&"" <> "1")

			' Field Description
			Call MenuItems.Description.SetDbValue(Rs, MenuItems.Description.CurrentValue, Null, MenuItems.Description.ReadOnly Or MenuItems.Description.MultiUpdate&"" <> "1")

			' Field Vegetarian
			Call MenuItems.Vegetarian.SetDbValue(Rs, MenuItems.Vegetarian.CurrentValue, Null, MenuItems.Vegetarian.ReadOnly Or MenuItems.Vegetarian.MultiUpdate&"" <> "1")

			' Field Spicyness
			Call MenuItems.Spicyness.SetDbValue(Rs, MenuItems.Spicyness.CurrentValue, Null, MenuItems.Spicyness.ReadOnly Or MenuItems.Spicyness.MultiUpdate&"" <> "1")

			' Field Price
			Call MenuItems.Price.SetDbValue(Rs, MenuItems.Price.CurrentValue, Null, MenuItems.Price.ReadOnly Or MenuItems.Price.MultiUpdate&"" <> "1")

			' Field IdMenuCategory
			Call MenuItems.IdMenuCategory.SetDbValue(Rs, MenuItems.IdMenuCategory.CurrentValue, Null, MenuItems.IdMenuCategory.ReadOnly Or MenuItems.IdMenuCategory.MultiUpdate&"" <> "1")

			' Field IdBusinessDetail
			Call MenuItems.IdBusinessDetail.SetDbValue(Rs, MenuItems.IdBusinessDetail.CurrentValue, Null, MenuItems.IdBusinessDetail.ReadOnly Or MenuItems.IdBusinessDetail.MultiUpdate&"" <> "1")

			' Field Photo
			Call MenuItems.Photo.SetDbValue(Rs, MenuItems.Photo.CurrentValue, Null, MenuItems.Photo.ReadOnly Or MenuItems.Photo.MultiUpdate&"" <> "1")

			' Field allowtoppings
			Call MenuItems.allowtoppings.SetDbValue(Rs, MenuItems.allowtoppings.CurrentValue, Null, MenuItems.allowtoppings.ReadOnly Or MenuItems.allowtoppings.MultiUpdate&"" <> "1")

			' Field dishpropertygroupid
			Call MenuItems.dishpropertygroupid.SetDbValue(Rs, MenuItems.dishpropertygroupid.CurrentValue, Null, MenuItems.dishpropertygroupid.ReadOnly Or MenuItems.dishpropertygroupid.MultiUpdate&"" <> "1")

			' Field hidedish
			Call MenuItems.hidedish.SetDbValue(Rs, MenuItems.hidedish.CurrentValue, Null, MenuItems.hidedish.ReadOnly Or MenuItems.hidedish.MultiUpdate&"" <> "1")

			' Field PrintingName
			Call MenuItems.PrintingName.SetDbValue(Rs, MenuItems.PrintingName.CurrentValue, Null, MenuItems.PrintingName.ReadOnly Or MenuItems.PrintingName.MultiUpdate&"" <> "1")

			' Field i_displaySort
			Call MenuItems.i_displaySort.SetDbValue(Rs, MenuItems.i_displaySort.CurrentValue, Null, MenuItems.i_displaySort.ReadOnly Or MenuItems.i_displaySort.MultiUpdate&"" <> "1")

			' Check recordset update error
			If Err.Number <> 0 Then
				FailureMessage = Err.Description
				Rs.Close
				Set Rs = Nothing
				EditRow = False
				Exit Function
			End If

			' Call Row Updating event
			bUpdateRow = MenuItems.Row_Updating(RsOld, Rs)
			If bUpdateRow Then

				' Clone new recordset object
				Set RsNew = ew_CloneRs(Rs)
				EditRow = True
				If EditRow Then
					Rs.Update
				End If
				If Err.Number <> 0 Or Not EditRow Then
					If Err.Description <> "" Then FailureMessage = Err.Description
					EditRow = False
				Else
					EditRow = True
				End If
				If EditRow Then
				End If
			Else
				Rs.CancelUpdate

				' Set up error message
				If SuccessMessage <> "" Or FailureMessage <> "" Then

					' Use the message, do nothing
				ElseIf MenuItems.CancelMessage <> "" Then
					FailureMessage = MenuItems.CancelMessage
					MenuItems.CancelMessage = ""
				Else
					FailureMessage = Language.Phrase("UpdateCancelled")
				End If
				EditRow = False
			End If
		End If

		' Call Row Updated event
		If EditRow Then
			Call MenuItems.Row_Updated(RsOld, RsNew)
		End If
		Rs.Close
		Set Rs = Nothing
		If IsObject(RsOld) Then
			RsOld.Close
			Set RsOld = Nothing
		End If
		If IsObject(RsNew) Then
			RsNew.Close
			Set RsNew = Nothing
		End If
	End Function

	' Set up Breadcrumb
	Sub SetupBreadcrumb()
		Dim PageId, url
		Set Breadcrumb = New cBreadcrumb
		url = Mid(ew_CurrentUrl, InStrRev(ew_CurrentUrl, "/")+1)
		Call Breadcrumb.Add("list", MenuItems.TableVar, "MenuItemslist.asp", "", MenuItems.TableVar, True)
		PageId = "update"
		Call Breadcrumb.Add("update", PageId, url, "", "", False)
	End Sub

	' Page Load event
	Sub Page_Load()

		'Response.Write "Page Load"
	End Sub

	' Page Unload event
	Sub Page_Unload()

		'Response.Write "Page Unload"
	End Sub

	' Page Redirecting event
	Sub Page_Redirecting(url)

		'url = newurl
	End Sub

	' Message Showing event
	' typ = ""|"success"|"failure"|"warning"
	Sub Message_Showing(msg, typ)

		' Example:
		'If typ = "success" Then
		'	msg = "your success message"
		'ElseIf typ = "failure" Then
		'	msg = "your failure message"
		'ElseIf typ = "warning" Then
		'	msg = "your warning message"
		'Else
		'	msg = "your message"
		'End If

	End Sub

	' Page Render event
	Sub Page_Render()

		'Response.Write "Page Render"
	End Sub

	' Page Data Rendering event
	Sub Page_DataRendering(header)

		' Example:
		'header = "your header"

	End Sub

	' Page Data Rendered event
	Sub Page_DataRendered(footer)

		' Example:
		'footer = "your footer"

	End Sub

	' Form Custom Validate event
	Function Form_CustomValidate(CustomError)

		'Return error message in CustomError
		Form_CustomValidate = True
	End Function
End Class
%>
