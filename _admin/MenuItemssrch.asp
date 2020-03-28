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
Dim MenuItems_search
Set MenuItems_search = New cMenuItems_search
Set Page = MenuItems_search

' Page init processing
MenuItems_search.Page_Init()

' Page main processing
MenuItems_search.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
MenuItems_search.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var MenuItems_search = new ew_Page("MenuItems_search");
MenuItems_search.PageID = "search"; // Page ID
var EW_PAGE_ID = MenuItems_search.PageID; // For backward compatibility
// Form object
var fMenuItemssearch = new ew_Form("fMenuItemssearch");
// Form_CustomValidate event
fMenuItemssearch.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fMenuItemssearch.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fMenuItemssearch.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
// Validate function for search
fMenuItemssearch.Validate = function(fobj) {
	if (!this.ValidateRequired)
		return true; // Ignore validation
	fobj = fobj || this.Form;
	this.PostAutoSuggest();
	var infix = "";
	elm = this.GetElements("x" + infix + "_Id");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(MenuItems.Id.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_Code");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(MenuItems.Code.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_Vegetarian");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(MenuItems.Vegetarian.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_Spicyness");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(MenuItems.Spicyness.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_Price");
	if (elm && !ew_CheckNumber(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(MenuItems.Price.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_IdMenuCategory");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(MenuItems.IdMenuCategory.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_IdBusinessDetail");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(MenuItems.IdBusinessDetail.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_allowtoppings");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(MenuItems.allowtoppings.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_hidedish");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(MenuItems.hidedish.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_i_displaySort");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(MenuItems.i_displaySort.FldErrMsg) %>");
	// Set up row object
	ew_ElementsToRow(fobj);
	// Fire Form_CustomValidate event
	if (!this.Form_CustomValidate(fobj))
		return false;
	return true;
}
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<% If Not MenuItems_search.IsModal Then %>
<div class="ewToolbar">
<% If MenuItems.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If MenuItems.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% End If %>
<% MenuItems_search.ShowPageHeader() %>
<% MenuItems_search.ShowMessage %>
<form name="fMenuItemssearch" id="fMenuItemssearch" class="form-horizontal ewForm ewSearchForm" action="<%= ew_CurrentPage %>" method="post">
<% If MenuItems_search.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= MenuItems_search.Token %>">
<% End If %>
<input type="hidden" name="t" value="MenuItems">
<input type="hidden" name="a_search" id="a_search" value="S">
<% If MenuItems_search.IsModal Then %>
<input type="hidden" name="modal" value="1">
<% End If %>
<div>
<% If MenuItems.Id.Visible Then ' Id %>
	<div id="r_Id" class="form-group">
		<label for="x_Id" class="<%= MenuItems_search.SearchLabelClass %>"><span id="elh_MenuItems_Id"><%= MenuItems.Id.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_Id" id="z_Id" value="="></p>
		</label>
		<div class="<%= MenuItems_search.SearchRightColumnClass %>"><div<%= MenuItems.Id.CellAttributes %>>
			<span id="el_MenuItems_Id">
<input type="text" data-field="x_Id" name="x_Id" id="x_Id" placeholder="<%= MenuItems.Id.PlaceHolder %>" value="<%= MenuItems.Id.EditValue %>"<%= MenuItems.Id.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If MenuItems.Code.Visible Then ' Code %>
	<div id="r_Code" class="form-group">
		<label for="x_Code" class="<%= MenuItems_search.SearchLabelClass %>"><span id="elh_MenuItems_Code"><%= MenuItems.Code.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_Code" id="z_Code" value="="></p>
		</label>
		<div class="<%= MenuItems_search.SearchRightColumnClass %>"><div<%= MenuItems.Code.CellAttributes %>>
			<span id="el_MenuItems_Code">
<input type="text" data-field="x_Code" name="x_Code" id="x_Code" size="30" placeholder="<%= MenuItems.Code.PlaceHolder %>" value="<%= MenuItems.Code.EditValue %>"<%= MenuItems.Code.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If MenuItems.Name.Visible Then ' Name %>
	<div id="r_Name" class="form-group">
		<label for="x_Name" class="<%= MenuItems_search.SearchLabelClass %>"><span id="elh_MenuItems_Name"><%= MenuItems.Name.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_Name" id="z_Name" value="LIKE"></p>
		</label>
		<div class="<%= MenuItems_search.SearchRightColumnClass %>"><div<%= MenuItems.Name.CellAttributes %>>
			<span id="el_MenuItems_Name">
<input type="text" data-field="x_Name" name="x_Name" id="x_Name" size="30" maxlength="255" placeholder="<%= MenuItems.Name.PlaceHolder %>" value="<%= MenuItems.Name.EditValue %>"<%= MenuItems.Name.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If MenuItems.Description.Visible Then ' Description %>
	<div id="r_Description" class="form-group">
		<label for="x_Description" class="<%= MenuItems_search.SearchLabelClass %>"><span id="elh_MenuItems_Description"><%= MenuItems.Description.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_Description" id="z_Description" value="LIKE"></p>
		</label>
		<div class="<%= MenuItems_search.SearchRightColumnClass %>"><div<%= MenuItems.Description.CellAttributes %>>
			<span id="el_MenuItems_Description">
<input type="text" data-field="x_Description" name="x_Description" id="x_Description" size="35" placeholder="<%= MenuItems.Description.PlaceHolder %>" value="<%= MenuItems.Description.EditValue %>"<%= MenuItems.Description.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If MenuItems.Vegetarian.Visible Then ' Vegetarian %>
	<div id="r_Vegetarian" class="form-group">
		<label for="x_Vegetarian" class="<%= MenuItems_search.SearchLabelClass %>"><span id="elh_MenuItems_Vegetarian"><%= MenuItems.Vegetarian.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_Vegetarian" id="z_Vegetarian" value="="></p>
		</label>
		<div class="<%= MenuItems_search.SearchRightColumnClass %>"><div<%= MenuItems.Vegetarian.CellAttributes %>>
			<span id="el_MenuItems_Vegetarian">
<input type="text" data-field="x_Vegetarian" name="x_Vegetarian" id="x_Vegetarian" size="30" placeholder="<%= MenuItems.Vegetarian.PlaceHolder %>" value="<%= MenuItems.Vegetarian.EditValue %>"<%= MenuItems.Vegetarian.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If MenuItems.Spicyness.Visible Then ' Spicyness %>
	<div id="r_Spicyness" class="form-group">
		<label for="x_Spicyness" class="<%= MenuItems_search.SearchLabelClass %>"><span id="elh_MenuItems_Spicyness"><%= MenuItems.Spicyness.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_Spicyness" id="z_Spicyness" value="="></p>
		</label>
		<div class="<%= MenuItems_search.SearchRightColumnClass %>"><div<%= MenuItems.Spicyness.CellAttributes %>>
			<span id="el_MenuItems_Spicyness">
<input type="text" data-field="x_Spicyness" name="x_Spicyness" id="x_Spicyness" size="30" placeholder="<%= MenuItems.Spicyness.PlaceHolder %>" value="<%= MenuItems.Spicyness.EditValue %>"<%= MenuItems.Spicyness.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If MenuItems.Price.Visible Then ' Price %>
	<div id="r_Price" class="form-group">
		<label for="x_Price" class="<%= MenuItems_search.SearchLabelClass %>"><span id="elh_MenuItems_Price"><%= MenuItems.Price.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_Price" id="z_Price" value="="></p>
		</label>
		<div class="<%= MenuItems_search.SearchRightColumnClass %>"><div<%= MenuItems.Price.CellAttributes %>>
			<span id="el_MenuItems_Price">
<input type="text" data-field="x_Price" name="x_Price" id="x_Price" size="30" placeholder="<%= MenuItems.Price.PlaceHolder %>" value="<%= MenuItems.Price.EditValue %>"<%= MenuItems.Price.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If MenuItems.IdMenuCategory.Visible Then ' IdMenuCategory %>
	<div id="r_IdMenuCategory" class="form-group">
		<label for="x_IdMenuCategory" class="<%= MenuItems_search.SearchLabelClass %>"><span id="elh_MenuItems_IdMenuCategory"><%= MenuItems.IdMenuCategory.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_IdMenuCategory" id="z_IdMenuCategory" value="="></p>
		</label>
		<div class="<%= MenuItems_search.SearchRightColumnClass %>"><div<%= MenuItems.IdMenuCategory.CellAttributes %>>
			<span id="el_MenuItems_IdMenuCategory">
<input type="text" data-field="x_IdMenuCategory" name="x_IdMenuCategory" id="x_IdMenuCategory" size="30" placeholder="<%= MenuItems.IdMenuCategory.PlaceHolder %>" value="<%= MenuItems.IdMenuCategory.EditValue %>"<%= MenuItems.IdMenuCategory.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If MenuItems.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
	<div id="r_IdBusinessDetail" class="form-group">
		<label for="x_IdBusinessDetail" class="<%= MenuItems_search.SearchLabelClass %>"><span id="elh_MenuItems_IdBusinessDetail"><%= MenuItems.IdBusinessDetail.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_IdBusinessDetail" id="z_IdBusinessDetail" value="="></p>
		</label>
		<div class="<%= MenuItems_search.SearchRightColumnClass %>"><div<%= MenuItems.IdBusinessDetail.CellAttributes %>>
			<span id="el_MenuItems_IdBusinessDetail">
<input type="text" data-field="x_IdBusinessDetail" name="x_IdBusinessDetail" id="x_IdBusinessDetail" size="30" placeholder="<%= MenuItems.IdBusinessDetail.PlaceHolder %>" value="<%= MenuItems.IdBusinessDetail.EditValue %>"<%= MenuItems.IdBusinessDetail.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If MenuItems.Photo.Visible Then ' Photo %>
	<div id="r_Photo" class="form-group">
		<label for="x_Photo" class="<%= MenuItems_search.SearchLabelClass %>"><span id="elh_MenuItems_Photo"><%= MenuItems.Photo.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_Photo" id="z_Photo" value="LIKE"></p>
		</label>
		<div class="<%= MenuItems_search.SearchRightColumnClass %>"><div<%= MenuItems.Photo.CellAttributes %>>
			<span id="el_MenuItems_Photo">
<input type="text" data-field="x_Photo" name="x_Photo" id="x_Photo" size="30" maxlength="255" placeholder="<%= MenuItems.Photo.PlaceHolder %>" value="<%= MenuItems.Photo.EditValue %>"<%= MenuItems.Photo.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If MenuItems.allowtoppings.Visible Then ' allowtoppings %>
	<div id="r_allowtoppings" class="form-group">
		<label for="x_allowtoppings" class="<%= MenuItems_search.SearchLabelClass %>"><span id="elh_MenuItems_allowtoppings"><%= MenuItems.allowtoppings.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_allowtoppings" id="z_allowtoppings" value="="></p>
		</label>
		<div class="<%= MenuItems_search.SearchRightColumnClass %>"><div<%= MenuItems.allowtoppings.CellAttributes %>>
			<span id="el_MenuItems_allowtoppings">
<input type="text" data-field="x_allowtoppings" name="x_allowtoppings" id="x_allowtoppings" size="30" placeholder="<%= MenuItems.allowtoppings.PlaceHolder %>" value="<%= MenuItems.allowtoppings.EditValue %>"<%= MenuItems.allowtoppings.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If MenuItems.dishpropertygroupid.Visible Then ' dishpropertygroupid %>
	<div id="r_dishpropertygroupid" class="form-group">
		<label for="x_dishpropertygroupid" class="<%= MenuItems_search.SearchLabelClass %>"><span id="elh_MenuItems_dishpropertygroupid"><%= MenuItems.dishpropertygroupid.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_dishpropertygroupid" id="z_dishpropertygroupid" value="LIKE"></p>
		</label>
		<div class="<%= MenuItems_search.SearchRightColumnClass %>"><div<%= MenuItems.dishpropertygroupid.CellAttributes %>>
			<span id="el_MenuItems_dishpropertygroupid">
<input type="text" data-field="x_dishpropertygroupid" name="x_dishpropertygroupid" id="x_dishpropertygroupid" size="30" maxlength="255" placeholder="<%= MenuItems.dishpropertygroupid.PlaceHolder %>" value="<%= MenuItems.dishpropertygroupid.EditValue %>"<%= MenuItems.dishpropertygroupid.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If MenuItems.hidedish.Visible Then ' hidedish %>
	<div id="r_hidedish" class="form-group">
		<label for="x_hidedish" class="<%= MenuItems_search.SearchLabelClass %>"><span id="elh_MenuItems_hidedish"><%= MenuItems.hidedish.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_hidedish" id="z_hidedish" value="="></p>
		</label>
		<div class="<%= MenuItems_search.SearchRightColumnClass %>"><div<%= MenuItems.hidedish.CellAttributes %>>
			<span id="el_MenuItems_hidedish">
<input type="text" data-field="x_hidedish" name="x_hidedish" id="x_hidedish" size="30" placeholder="<%= MenuItems.hidedish.PlaceHolder %>" value="<%= MenuItems.hidedish.EditValue %>"<%= MenuItems.hidedish.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If MenuItems.PrintingName.Visible Then ' PrintingName %>
	<div id="r_PrintingName" class="form-group">
		<label for="x_PrintingName" class="<%= MenuItems_search.SearchLabelClass %>"><span id="elh_MenuItems_PrintingName"><%= MenuItems.PrintingName.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_PrintingName" id="z_PrintingName" value="LIKE"></p>
		</label>
		<div class="<%= MenuItems_search.SearchRightColumnClass %>"><div<%= MenuItems.PrintingName.CellAttributes %>>
			<span id="el_MenuItems_PrintingName">
<input type="text" data-field="x_PrintingName" name="x_PrintingName" id="x_PrintingName" size="30" maxlength="128" placeholder="<%= MenuItems.PrintingName.PlaceHolder %>" value="<%= MenuItems.PrintingName.EditValue %>"<%= MenuItems.PrintingName.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If MenuItems.i_displaySort.Visible Then ' i_displaySort %>
	<div id="r_i_displaySort" class="form-group">
		<label for="x_i_displaySort" class="<%= MenuItems_search.SearchLabelClass %>"><span id="elh_MenuItems_i_displaySort"><%= MenuItems.i_displaySort.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_i_displaySort" id="z_i_displaySort" value="="></p>
		</label>
		<div class="<%= MenuItems_search.SearchRightColumnClass %>"><div<%= MenuItems.i_displaySort.CellAttributes %>>
			<span id="el_MenuItems_i_displaySort">
<input type="text" data-field="x_i_displaySort" name="x_i_displaySort" id="x_i_displaySort" size="30" placeholder="<%= MenuItems.i_displaySort.PlaceHolder %>" value="<%= MenuItems.i_displaySort.EditValue %>"<%= MenuItems.i_displaySort.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
</div>
<% If Not MenuItems_search.IsModal Then %>
<div class="form-group">
	<div class="col-sm-offset-3 col-sm-9">
<button class="btn btn-primary ewButton" name="btnAction" id="btnAction" type="submit"><%= Language.Phrase("Search") %></button>
<button class="btn btn-default ewButton" name="btnReset" id="btnReset" type="button" onclick="ew_ClearForm(this.form);"><%= Language.Phrase("Reset") %></button>
	</div>
</div>
<% End If %>
</form>
<script type="text/javascript">
fMenuItemssearch.Init();
</script>
<%
MenuItems_search.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set MenuItems_search = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cMenuItems_search

	' Page ID
	Public Property Get PageID()
		PageID = "search"
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
		PageObjName = "MenuItems_search"
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
		EW_PAGE_ID = "search"

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
		MenuItems.Id.Visible = Not MenuItems.IsAdd() And Not MenuItems.IsCopy() And Not MenuItems.IsGridAdd()

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

	Dim IsModal
	Dim SearchLabelClass
	Dim SearchRightColumnClass

	' -----------------------------------------------------------------
	' Page main processing
	'
	Sub Page_Main()

		' Set up Breadcrumb
		SetupBreadcrumb()
		SearchLabelClass = "col-sm-3 control-label ewLabel"
		SearchRightColumnClass = "col-sm-9"

		' Check modal
		IsModal = (Request.QueryString("modal")&"" = "1" Or Request.Form("modal")&"" = "1")
		If IsModal Then
			gbSkipHeaderFooter = True
		End If
		If IsPageRequest Then ' Validate request

			' Get action
			MenuItems.CurrentAction = ObjForm.GetValue("a_search")
			Select Case MenuItems.CurrentAction
				Case "S" ' Get Search Criteria

					' Build search string for advanced search, remove blank field
					Dim sSrchStr
					Call LoadSearchValues() ' Get search values
					If ValidateSearch() Then
						sSrchStr = BuildAdvancedSearch()
					Else
						sSrchStr = ""
						FailureMessage = gsSearchError
					End If
					If sSrchStr <> "" Then
						sSrchStr = MenuItems.UrlParm(sSrchStr)
						sSrchStr = "MenuItemslist.asp" & "?" & sSrchStr
						If IsModal Then
							Dim row
							ReDim row(0,0)
							row(0,0) = Array("url", sSrchStr)
							Response.Write ew_ArrayToJson(row, 0)
							Call Page_Terminate("")
							Response.End
						Else
							Call Page_Terminate(sSrchStr) ' Go to list page
						End If
					End If
			End Select
		End If

		' Restore search settings from Session
		If gsSearchError = "" Then
			Call LoadAdvancedSearch()
		End If

		' Render row for search
		MenuItems.RowType = EW_ROWTYPE_SEARCH
		Call RenderRow()
	End Sub

	' -----------------------------------------------------------------
	' Build advanced search
	'
	Function BuildAdvancedSearch()
		Dim sSrchUrl
		sSrchUrl = ""
		Call BuildSearchUrl(sSrchUrl, MenuItems.Id, False) ' Id
		Call BuildSearchUrl(sSrchUrl, MenuItems.Code, False) ' Code
		Call BuildSearchUrl(sSrchUrl, MenuItems.Name, False) ' Name
		Call BuildSearchUrl(sSrchUrl, MenuItems.Description, False) ' Description
		Call BuildSearchUrl(sSrchUrl, MenuItems.Vegetarian, False) ' Vegetarian
		Call BuildSearchUrl(sSrchUrl, MenuItems.Spicyness, False) ' Spicyness
		Call BuildSearchUrl(sSrchUrl, MenuItems.Price, False) ' Price
		Call BuildSearchUrl(sSrchUrl, MenuItems.IdMenuCategory, False) ' IdMenuCategory
		Call BuildSearchUrl(sSrchUrl, MenuItems.IdBusinessDetail, False) ' IdBusinessDetail
		Call BuildSearchUrl(sSrchUrl, MenuItems.Photo, False) ' Photo
		Call BuildSearchUrl(sSrchUrl, MenuItems.allowtoppings, False) ' allowtoppings
		Call BuildSearchUrl(sSrchUrl, MenuItems.dishpropertygroupid, False) ' dishpropertygroupid
		Call BuildSearchUrl(sSrchUrl, MenuItems.hidedish, False) ' hidedish
		Call BuildSearchUrl(sSrchUrl, MenuItems.PrintingName, False) ' PrintingName
		Call BuildSearchUrl(sSrchUrl, MenuItems.i_displaySort, False) ' i_displaySort
		If sSrchUrl <> "" Then sSrchUrl = sSrchUrl & "&"
		sSrchUrl = sSrchUrl & "cmd=search"
		BuildAdvancedSearch = sSrchUrl
	End Function

	' -----------------------------------------------------------------
	' Function to build search URL
	'
	Sub BuildSearchUrl(Url, Fld, OprOnly)
		Dim FldVal, FldOpr, FldCond, FldVal2, FldOpr2
		Dim FldParm
		Dim IsValidValue, sWrk
		sWrk = ""
		FldParm = Mid(Fld.FldVar, 3)
		FldVal = ObjForm.GetValue("x_" & FldParm)
		FldOpr = ObjForm.GetValue("z_" & FldParm)
		FldCond = ObjForm.GetValue("v_" & FldParm)
		FldVal2 = ObjForm.GetValue("y_" & FldParm)
		FldOpr2 = ObjForm.GetValue("w_" & FldParm)
		FldOpr = UCase(Trim(FldOpr))
		Dim lFldDataType
		If Fld.FldIsVirtual Then
			lFldDataType = EW_DATATYPE_STRING
		Else
			lFldDataType = Fld.FldDataType
		End If
		If FldOpr = "BETWEEN" Then
			IsValidValue = (lFldDataType <> EW_DATATYPE_NUMBER) Or _
				(lFldDataType = EW_DATATYPE_NUMBER And SearchValueIsNumeric(Fld, FldVal) And SearchValueIsNumeric(Fld, FldVal2))
			If FldVal <> "" And FldVal2 <> "" And IsValidValue Then
				sWrk = "x_" & FldParm & "=" & ew_Encode(FldVal) & _
					"&y_" & FldParm & "=" & ew_Encode(FldVal2) & _
					"&z_" & FldParm & "=" & ew_Encode(FldOpr)
			End If
		Else
			IsValidValue = (lFldDataType <> EW_DATATYPE_NUMBER) Or _
				(lFldDataType = EW_DATATYPE_NUMBER And SearchValueIsNumeric(Fld, FldVal))
			If FldVal <> "" And IsValidValue And ew_IsValidOpr(FldOpr, lFldDataType) Then
				sWrk = "x_" & FldParm & "=" & ew_Encode(FldVal) & _
					"&z_" & FldParm & "=" & ew_Encode(FldOpr)
			ElseIf FldOpr = "IS NULL" Or FldOpr = "IS NOT NULL" Or (FldOpr <> "" And OprOnly And ew_IsValidOpr(FldOpr, lFldDataType)) Then
				sWrk = "z_" & FldParm & "=" & ew_Encode(FldOpr)
			End If
			IsValidValue = (lFldDataType <> EW_DATATYPE_NUMBER) Or _
				(lFldDataType = EW_DATATYPE_NUMBER And SearchValueIsNumeric(Fld, FldVal2))
			If FldVal2 <> "" And IsValidValue And ew_IsValidOpr(FldOpr2, lFldDataType) Then
				If sWrk <> "" Then sWrk = sWrk & "&v_" & FldParm & "=" & FldCond & "&"
				sWrk = sWrk & "y_" & FldParm & "=" & ew_Encode(FldVal2) & _
					"&w_" & FldParm & "=" & ew_Encode(FldOpr2)
			ElseIf FldOpr2 = "IS NULL" Or FldOpr2 = "IS NOT NULL" Or (FldOpr2 <> "" And OprOnly And ew_IsValidOpr(FldOpr2, lFldDataType)) Then
				If sWrk <> "" Then sWrk = sWrk & "&v_" & FldParm & "=" & FldCond & "&"
				sWrk = sWrk & "w_" & FldParm & "=" & ew_Encode(FldOpr2)
			End If
		End If
		If sWrk <> "" Then
			If Url <> "" Then Url = Url & "&"
			Url = Url & sWrk
		End If
	End Sub

	Function SearchValueIsNumeric(Fld, Value)
		Dim wrkValue
		wrkValue = Value
		If ew_IsFloatFormat(Fld.FldType) Then wrkValue = ew_StrToFloat(wrkValue)
		SearchValueIsNumeric = IsNumeric(Value)
	End Function

	' -----------------------------------------------------------------
	'  Load search values for validation
	'
	Function LoadSearchValues()

		' Load search values
		MenuItems.Id.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Id")
		MenuItems.Id.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Id")
		MenuItems.Code.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Code")
		MenuItems.Code.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Code")
		MenuItems.Name.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Name")
		MenuItems.Name.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Name")
		MenuItems.Description.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Description")
		MenuItems.Description.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Description")
		MenuItems.Vegetarian.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Vegetarian")
		MenuItems.Vegetarian.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Vegetarian")
		MenuItems.Spicyness.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Spicyness")
		MenuItems.Spicyness.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Spicyness")
		MenuItems.Price.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Price")
		MenuItems.Price.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Price")
		MenuItems.IdMenuCategory.AdvancedSearch.SearchValue = ObjForm.GetValue("x_IdMenuCategory")
		MenuItems.IdMenuCategory.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_IdMenuCategory")
		MenuItems.IdBusinessDetail.AdvancedSearch.SearchValue = ObjForm.GetValue("x_IdBusinessDetail")
		MenuItems.IdBusinessDetail.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_IdBusinessDetail")
		MenuItems.Photo.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Photo")
		MenuItems.Photo.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Photo")
		MenuItems.allowtoppings.AdvancedSearch.SearchValue = ObjForm.GetValue("x_allowtoppings")
		MenuItems.allowtoppings.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_allowtoppings")
		MenuItems.dishpropertygroupid.AdvancedSearch.SearchValue = ObjForm.GetValue("x_dishpropertygroupid")
		MenuItems.dishpropertygroupid.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_dishpropertygroupid")
		MenuItems.hidedish.AdvancedSearch.SearchValue = ObjForm.GetValue("x_hidedish")
		MenuItems.hidedish.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_hidedish")
		MenuItems.PrintingName.AdvancedSearch.SearchValue = ObjForm.GetValue("x_PrintingName")
		MenuItems.PrintingName.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_PrintingName")
		MenuItems.i_displaySort.AdvancedSearch.SearchValue = ObjForm.GetValue("x_i_displaySort")
		MenuItems.i_displaySort.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_i_displaySort")
	End Function

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
			' Id

			MenuItems.Id.LinkCustomAttributes = ""
			MenuItems.Id.HrefValue = ""
			MenuItems.Id.TooltipValue = ""

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

		' ------------
		'  Search Row
		' ------------

		ElseIf MenuItems.RowType = EW_ROWTYPE_SEARCH Then ' Search row

			' Id
			MenuItems.Id.EditAttrs.UpdateAttribute "class", "form-control"
			MenuItems.Id.EditCustomAttributes = ""
			MenuItems.Id.EditValue = ew_HtmlEncode(MenuItems.Id.AdvancedSearch.SearchValue)
			MenuItems.Id.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuItems.Id.FldCaption))

			' Code
			MenuItems.Code.EditAttrs.UpdateAttribute "class", "form-control"
			MenuItems.Code.EditCustomAttributes = ""
			MenuItems.Code.EditValue = ew_HtmlEncode(MenuItems.Code.AdvancedSearch.SearchValue)
			MenuItems.Code.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuItems.Code.FldCaption))

			' Name
			MenuItems.Name.EditAttrs.UpdateAttribute "class", "form-control"
			MenuItems.Name.EditCustomAttributes = ""
			MenuItems.Name.EditValue = ew_HtmlEncode(MenuItems.Name.AdvancedSearch.SearchValue)
			MenuItems.Name.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuItems.Name.FldCaption))

			' Description
			MenuItems.Description.EditAttrs.UpdateAttribute "class", "form-control"
			MenuItems.Description.EditCustomAttributes = ""
			MenuItems.Description.EditValue = ew_HtmlEncode(MenuItems.Description.AdvancedSearch.SearchValue)
			MenuItems.Description.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuItems.Description.FldCaption))

			' Vegetarian
			MenuItems.Vegetarian.EditAttrs.UpdateAttribute "class", "form-control"
			MenuItems.Vegetarian.EditCustomAttributes = ""
			MenuItems.Vegetarian.EditValue = ew_HtmlEncode(MenuItems.Vegetarian.AdvancedSearch.SearchValue)
			MenuItems.Vegetarian.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuItems.Vegetarian.FldCaption))

			' Spicyness
			MenuItems.Spicyness.EditAttrs.UpdateAttribute "class", "form-control"
			MenuItems.Spicyness.EditCustomAttributes = ""
			MenuItems.Spicyness.EditValue = ew_HtmlEncode(MenuItems.Spicyness.AdvancedSearch.SearchValue)
			MenuItems.Spicyness.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuItems.Spicyness.FldCaption))

			' Price
			MenuItems.Price.EditAttrs.UpdateAttribute "class", "form-control"
			MenuItems.Price.EditCustomAttributes = ""
			MenuItems.Price.EditValue = ew_HtmlEncode(MenuItems.Price.AdvancedSearch.SearchValue)
			MenuItems.Price.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuItems.Price.FldCaption))

			' IdMenuCategory
			MenuItems.IdMenuCategory.EditAttrs.UpdateAttribute "class", "form-control"
			MenuItems.IdMenuCategory.EditCustomAttributes = ""
			MenuItems.IdMenuCategory.EditValue = ew_HtmlEncode(MenuItems.IdMenuCategory.AdvancedSearch.SearchValue)
			MenuItems.IdMenuCategory.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuItems.IdMenuCategory.FldCaption))

			' IdBusinessDetail
			MenuItems.IdBusinessDetail.EditAttrs.UpdateAttribute "class", "form-control"
			MenuItems.IdBusinessDetail.EditCustomAttributes = ""
			MenuItems.IdBusinessDetail.EditValue = ew_HtmlEncode(MenuItems.IdBusinessDetail.AdvancedSearch.SearchValue)
			MenuItems.IdBusinessDetail.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuItems.IdBusinessDetail.FldCaption))

			' Photo
			MenuItems.Photo.EditAttrs.UpdateAttribute "class", "form-control"
			MenuItems.Photo.EditCustomAttributes = ""
			MenuItems.Photo.EditValue = ew_HtmlEncode(MenuItems.Photo.AdvancedSearch.SearchValue)
			MenuItems.Photo.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuItems.Photo.FldCaption))

			' allowtoppings
			MenuItems.allowtoppings.EditAttrs.UpdateAttribute "class", "form-control"
			MenuItems.allowtoppings.EditCustomAttributes = ""
			MenuItems.allowtoppings.EditValue = ew_HtmlEncode(MenuItems.allowtoppings.AdvancedSearch.SearchValue)
			MenuItems.allowtoppings.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuItems.allowtoppings.FldCaption))

			' dishpropertygroupid
			MenuItems.dishpropertygroupid.EditAttrs.UpdateAttribute "class", "form-control"
			MenuItems.dishpropertygroupid.EditCustomAttributes = ""
			MenuItems.dishpropertygroupid.EditValue = ew_HtmlEncode(MenuItems.dishpropertygroupid.AdvancedSearch.SearchValue)
			MenuItems.dishpropertygroupid.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuItems.dishpropertygroupid.FldCaption))

			' hidedish
			MenuItems.hidedish.EditAttrs.UpdateAttribute "class", "form-control"
			MenuItems.hidedish.EditCustomAttributes = ""
			MenuItems.hidedish.EditValue = ew_HtmlEncode(MenuItems.hidedish.AdvancedSearch.SearchValue)
			MenuItems.hidedish.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuItems.hidedish.FldCaption))

			' PrintingName
			MenuItems.PrintingName.EditAttrs.UpdateAttribute "class", "form-control"
			MenuItems.PrintingName.EditCustomAttributes = ""
			MenuItems.PrintingName.EditValue = ew_HtmlEncode(MenuItems.PrintingName.AdvancedSearch.SearchValue)
			MenuItems.PrintingName.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuItems.PrintingName.FldCaption))

			' i_displaySort
			MenuItems.i_displaySort.EditAttrs.UpdateAttribute "class", "form-control"
			MenuItems.i_displaySort.EditCustomAttributes = ""
			MenuItems.i_displaySort.EditValue = ew_HtmlEncode(MenuItems.i_displaySort.AdvancedSearch.SearchValue)
			MenuItems.i_displaySort.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuItems.i_displaySort.FldCaption))
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
	' Validate search
	'
	Function ValidateSearch()

		' Initialize
		gsSearchError = ""

		' Check if validation required
		If Not EW_SERVER_VALIDATE Then
			ValidateSearch = True
			Exit Function
		End If
		If Not ew_CheckInteger(MenuItems.Id.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, MenuItems.Id.FldErrMsg)
		End If
		If Not ew_CheckInteger(MenuItems.Code.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, MenuItems.Code.FldErrMsg)
		End If
		If Not ew_CheckInteger(MenuItems.Vegetarian.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, MenuItems.Vegetarian.FldErrMsg)
		End If
		If Not ew_CheckInteger(MenuItems.Spicyness.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, MenuItems.Spicyness.FldErrMsg)
		End If
		If Not ew_CheckNumber(MenuItems.Price.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, MenuItems.Price.FldErrMsg)
		End If
		If Not ew_CheckInteger(MenuItems.IdMenuCategory.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, MenuItems.IdMenuCategory.FldErrMsg)
		End If
		If Not ew_CheckInteger(MenuItems.IdBusinessDetail.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, MenuItems.IdBusinessDetail.FldErrMsg)
		End If
		If Not ew_CheckInteger(MenuItems.allowtoppings.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, MenuItems.allowtoppings.FldErrMsg)
		End If
		If Not ew_CheckInteger(MenuItems.hidedish.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, MenuItems.hidedish.FldErrMsg)
		End If
		If Not ew_CheckInteger(MenuItems.i_displaySort.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, MenuItems.i_displaySort.FldErrMsg)
		End If

		' Return validate result
		ValidateSearch = (gsSearchError = "")

		' Call Form Custom Validate event
		Dim sFormCustomError
		sFormCustomError = ""
		ValidateSearch = ValidateSearch And Form_CustomValidate(sFormCustomError)
		If sFormCustomError <> "" Then
			Call ew_AddMessage(gsSearchError, sFormCustomError)
		End If
	End Function

	' -----------------------------------------------------------------
	' Load advanced search
	'
	Function LoadAdvancedSearch()
		Call MenuItems.Id.AdvancedSearch.Load()
		Call MenuItems.Code.AdvancedSearch.Load()
		Call MenuItems.Name.AdvancedSearch.Load()
		Call MenuItems.Description.AdvancedSearch.Load()
		Call MenuItems.Vegetarian.AdvancedSearch.Load()
		Call MenuItems.Spicyness.AdvancedSearch.Load()
		Call MenuItems.Price.AdvancedSearch.Load()
		Call MenuItems.IdMenuCategory.AdvancedSearch.Load()
		Call MenuItems.IdBusinessDetail.AdvancedSearch.Load()
		Call MenuItems.Photo.AdvancedSearch.Load()
		Call MenuItems.allowtoppings.AdvancedSearch.Load()
		Call MenuItems.dishpropertygroupid.AdvancedSearch.Load()
		Call MenuItems.hidedish.AdvancedSearch.Load()
		Call MenuItems.PrintingName.AdvancedSearch.Load()
		Call MenuItems.i_displaySort.AdvancedSearch.Load()
End Function

	' Set up Breadcrumb
	Sub SetupBreadcrumb()
		Dim PageId, url
		Set Breadcrumb = New cBreadcrumb
		url = Mid(ew_CurrentUrl, InStrRev(ew_CurrentUrl, "/")+1)
		Call Breadcrumb.Add("list", MenuItems.TableVar, "MenuItemslist.asp", "", MenuItems.TableVar, True)
		PageId = "search"
		Call Breadcrumb.Add("search", PageId, url, "", "", False)
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
