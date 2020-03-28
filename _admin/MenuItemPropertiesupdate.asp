<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="MenuItemPropertiesinfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim MenuItemProperties_update
Set MenuItemProperties_update = New cMenuItemProperties_update
Set Page = MenuItemProperties_update

' Page init processing
MenuItemProperties_update.Page_Init()

' Page main processing
MenuItemProperties_update.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
MenuItemProperties_update.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var MenuItemProperties_update = new ew_Page("MenuItemProperties_update");
MenuItemProperties_update.PageID = "update"; // Page ID
var EW_PAGE_ID = MenuItemProperties_update.PageID; // For backward compatibility
// Form object
var fMenuItemPropertiesupdate = new ew_Form("fMenuItemPropertiesupdate");
// Validate form
fMenuItemPropertiesupdate.Validate = function() {
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
			elm = this.GetElements("x" + infix + "_Price");
			uelm = this.GetElements("u" + infix + "_Price");
			if (uelm && uelm.checked && elm && !ew_CheckNumber(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(MenuItemProperties.Price.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_IdMenuItem");
			uelm = this.GetElements("u" + infix + "_IdMenuItem");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(MenuItemProperties.IdMenuItem.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_allowtoppings");
			uelm = this.GetElements("u" + infix + "_allowtoppings");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(MenuItemProperties.allowtoppings.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_i_displaysort");
			uelm = this.GetElements("u" + infix + "_i_displaysort");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(MenuItemProperties.i_displaysort.FldErrMsg) %>");
			// Set up row object
			ew_ElementsToRow(fobj);
			// Fire Form_CustomValidate event
			if (!this.Form_CustomValidate(fobj))
				return false;
	}
	return true;
}
// Form_CustomValidate event
fMenuItemPropertiesupdate.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fMenuItemPropertiesupdate.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fMenuItemPropertiesupdate.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<div class="ewToolbar">
<% If MenuItemProperties.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If MenuItemProperties.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% MenuItemProperties_update.ShowPageHeader() %>
<% MenuItemProperties_update.ShowMessage %>
<form name="fMenuItemPropertiesupdate" id="fMenuItemPropertiesupdate" class="form-horizontal ewForm ewUpdateForm" action="<%= ew_CurrentPage %>" method="post">
<% If MenuItemProperties_update.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= MenuItemProperties_update.Token %>">
<% End If %>
<input type="hidden" name="t" value="MenuItemProperties">
<input type="hidden" name="a_update" id="a_update" value="U">
<% For i = 0 to UBound(MenuItemProperties_update.RecKeys) %>
<input type="hidden" name="key_m" id="key_m" value="<%= ew_HtmlEncode(ew_GetKeyValue(MenuItemProperties_update.RecKeys(i))) %>">
<% Next %>
<div id="tbl_MenuItemPropertiesupdate">
	<div class="form-group">
		<label class="col-sm-2"><input type="checkbox" name="u" id="u" onclick="ew_SelectAll(this);"> <%= Language.Phrase("UpdateSelectAll") %></label>
	</div>
<% If MenuItemProperties.Name.Visible Then ' Name %>
	<div id="r_Name" class="form-group">
		<label for="x_Name" class="col-sm-2 control-label">
<input type="checkbox" name="u_Name" id="u_Name" value="1"<% If MenuItemProperties.Name.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= MenuItemProperties.Name.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuItemProperties.Name.CellAttributes %>>
<span id="el_MenuItemProperties_Name">
<input type="text" data-field="x_Name" name="x_Name" id="x_Name" size="30" maxlength="256" placeholder="<%= MenuItemProperties.Name.PlaceHolder %>" value="<%= MenuItemProperties.Name.EditValue %>"<%= MenuItemProperties.Name.EditAttributes %>>
</span>
<%= MenuItemProperties.Name.CustomMsg %></div></div>
	</div>
<% End If %>
<% If MenuItemProperties.Price.Visible Then ' Price %>
	<div id="r_Price" class="form-group">
		<label for="x_Price" class="col-sm-2 control-label">
<input type="checkbox" name="u_Price" id="u_Price" value="1"<% If MenuItemProperties.Price.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= MenuItemProperties.Price.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuItemProperties.Price.CellAttributes %>>
<span id="el_MenuItemProperties_Price">
<input type="text" data-field="x_Price" name="x_Price" id="x_Price" size="30" placeholder="<%= MenuItemProperties.Price.PlaceHolder %>" value="<%= MenuItemProperties.Price.EditValue %>"<%= MenuItemProperties.Price.EditAttributes %>>
</span>
<%= MenuItemProperties.Price.CustomMsg %></div></div>
	</div>
<% End If %>
<% If MenuItemProperties.IdMenuItem.Visible Then ' IdMenuItem %>
	<div id="r_IdMenuItem" class="form-group">
		<label for="x_IdMenuItem" class="col-sm-2 control-label">
<input type="checkbox" name="u_IdMenuItem" id="u_IdMenuItem" value="1"<% If MenuItemProperties.IdMenuItem.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= MenuItemProperties.IdMenuItem.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuItemProperties.IdMenuItem.CellAttributes %>>
<span id="el_MenuItemProperties_IdMenuItem">
<input type="text" data-field="x_IdMenuItem" name="x_IdMenuItem" id="x_IdMenuItem" size="30" placeholder="<%= MenuItemProperties.IdMenuItem.PlaceHolder %>" value="<%= MenuItemProperties.IdMenuItem.EditValue %>"<%= MenuItemProperties.IdMenuItem.EditAttributes %>>
</span>
<%= MenuItemProperties.IdMenuItem.CustomMsg %></div></div>
	</div>
<% End If %>
<% If MenuItemProperties.allowtoppings.Visible Then ' allowtoppings %>
	<div id="r_allowtoppings" class="form-group">
		<label for="x_allowtoppings" class="col-sm-2 control-label">
<input type="checkbox" name="u_allowtoppings" id="u_allowtoppings" value="1"<% If MenuItemProperties.allowtoppings.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= MenuItemProperties.allowtoppings.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuItemProperties.allowtoppings.CellAttributes %>>
<span id="el_MenuItemProperties_allowtoppings">
<input type="text" data-field="x_allowtoppings" name="x_allowtoppings" id="x_allowtoppings" size="30" placeholder="<%= MenuItemProperties.allowtoppings.PlaceHolder %>" value="<%= MenuItemProperties.allowtoppings.EditValue %>"<%= MenuItemProperties.allowtoppings.EditAttributes %>>
</span>
<%= MenuItemProperties.allowtoppings.CustomMsg %></div></div>
	</div>
<% End If %>
<% If MenuItemProperties.dishpropertiesgroupid.Visible Then ' dishpropertiesgroupid %>
	<div id="r_dishpropertiesgroupid" class="form-group">
		<label for="x_dishpropertiesgroupid" class="col-sm-2 control-label">
<input type="checkbox" name="u_dishpropertiesgroupid" id="u_dishpropertiesgroupid" value="1"<% If MenuItemProperties.dishpropertiesgroupid.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= MenuItemProperties.dishpropertiesgroupid.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuItemProperties.dishpropertiesgroupid.CellAttributes %>>
<span id="el_MenuItemProperties_dishpropertiesgroupid">
<input type="text" data-field="x_dishpropertiesgroupid" name="x_dishpropertiesgroupid" id="x_dishpropertiesgroupid" size="30" maxlength="255" placeholder="<%= MenuItemProperties.dishpropertiesgroupid.PlaceHolder %>" value="<%= MenuItemProperties.dishpropertiesgroupid.EditValue %>"<%= MenuItemProperties.dishpropertiesgroupid.EditAttributes %>>
</span>
<%= MenuItemProperties.dishpropertiesgroupid.CustomMsg %></div></div>
	</div>
<% End If %>
<% If MenuItemProperties.printingname.Visible Then ' printingname %>
	<div id="r_printingname" class="form-group">
		<label for="x_printingname" class="col-sm-2 control-label">
<input type="checkbox" name="u_printingname" id="u_printingname" value="1"<% If MenuItemProperties.printingname.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= MenuItemProperties.printingname.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuItemProperties.printingname.CellAttributes %>>
<span id="el_MenuItemProperties_printingname">
<input type="text" data-field="x_printingname" name="x_printingname" id="x_printingname" size="30" maxlength="255" placeholder="<%= MenuItemProperties.printingname.PlaceHolder %>" value="<%= MenuItemProperties.printingname.EditValue %>"<%= MenuItemProperties.printingname.EditAttributes %>>
</span>
<%= MenuItemProperties.printingname.CustomMsg %></div></div>
	</div>
<% End If %>
<% If MenuItemProperties.i_displaysort.Visible Then ' i_displaysort %>
	<div id="r_i_displaysort" class="form-group">
		<label for="x_i_displaysort" class="col-sm-2 control-label">
<input type="checkbox" name="u_i_displaysort" id="u_i_displaysort" value="1"<% If MenuItemProperties.i_displaysort.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= MenuItemProperties.i_displaysort.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuItemProperties.i_displaysort.CellAttributes %>>
<span id="el_MenuItemProperties_i_displaysort">
<input type="text" data-field="x_i_displaysort" name="x_i_displaysort" id="x_i_displaysort" size="30" placeholder="<%= MenuItemProperties.i_displaysort.PlaceHolder %>" value="<%= MenuItemProperties.i_displaysort.EditValue %>"<%= MenuItemProperties.i_displaysort.EditAttributes %>>
</span>
<%= MenuItemProperties.i_displaysort.CustomMsg %></div></div>
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
fMenuItemPropertiesupdate.Init();
</script>
<%
MenuItemProperties_update.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set MenuItemProperties_update = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cMenuItemProperties_update

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
		TableName = "MenuItemProperties"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "MenuItemProperties_update"
	End Property

	' Page Name
	Public Property Get PageName()
		PageName = ew_CurrentPage()
	End Property

	' Page Url
	Public Property Get PageUrl()
		PageUrl = ew_CurrentPage() & "?"
		If MenuItemProperties.UseTokenInUrl Then PageUrl = PageUrl & "t=" & MenuItemProperties.TableVar & "&" ' add page token
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
		If MenuItemProperties.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (MenuItemProperties.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (MenuItemProperties.TableVar = Request.QueryString("t"))
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
		If IsEmpty(MenuItemProperties) Then Set MenuItemProperties = New cMenuItemProperties
		Set Table = MenuItemProperties

		' Initialize urls
		' Initialize form object

		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "update"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "MenuItemProperties"

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

		MenuItemProperties.CurrentAction = ew_IIf(Request.QueryString("a").Count > 0, Request.QueryString("a") & "", ObjForm.GetValue("a_list") & "") ' Set up current action

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
			results = MenuItemProperties.GetAutoFill(Request.Form("name"), Request.Form("q"))
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
		If Not MenuItemProperties Is Nothing Then
			If MenuItemProperties.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = MenuItemProperties.TableVar
				If MenuItemProperties.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf MenuItemProperties.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf MenuItemProperties.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf MenuItemProperties.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set MenuItemProperties = Nothing
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
		RecKeys = MenuItemProperties.GetRecordKeys() ' Load record keys
		If ObjForm.GetValue("a_update")&"" <> "" Then

			' Get action
			MenuItemProperties.CurrentAction = ObjForm.GetValue("a_update")
			Call LoadFormValues() ' Get form values

			' Validate form
			If Not ValidateForm() Then
				MenuItemProperties.CurrentAction = "I" ' Form error, reset action
				FailureMessage = gsFormError
			End If
		Else
			Call LoadMultiUpdateValues() ' Load initial values to form
		End If
		If Not IsArray(RecKeys) Then
			Call Page_Terminate("MenuItemPropertieslist.asp") ' No records selected, return to list
		End If
		Select Case MenuItemProperties.CurrentAction
			Case "U" ' Update
				If UpdateRows() Then ' Update Records based on key
					If SuccessMessage = "" Then SuccessMessage = Language.Phrase("UpdateSuccess") ' Set update success message
					Call Page_Terminate(MenuItemProperties.ReturnUrl) ' Return to caller
				Else
					Call RestoreFormValues() ' Restore form values
				End If
		End Select

		' Render row
		MenuItemProperties.RowType = EW_ROWTYPE_EDIT ' Render edit

		' Render row
		Call MenuItemProperties.ResetAttrs()
		Call RenderRow()
	End Sub

	' -----------------------------------------------------------------
	' Load initial values to form if field values are identical in all selected records
	'
	Sub LoadMultiUpdateValues()
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		Dim Rs, i, OldValue, NewValue
		MenuItemProperties.CurrentFilter = MenuItemProperties.GetKeyFilter()

		' Load recordset
		Set Rs = LoadRecordset()
		i = 1
		Do While Not Rs.Eof
			If i = 1 Then
				MenuItemProperties.Name.DbValue = ew_Conv(Rs("Name"), Rs("Name").Type)
				MenuItemProperties.Price.DbValue = ew_Conv(Rs("Price"), Rs("Price").Type)
				MenuItemProperties.IdMenuItem.DbValue = ew_Conv(Rs("IdMenuItem"), Rs("IdMenuItem").Type)
				MenuItemProperties.allowtoppings.DbValue = ew_Conv(Rs("allowtoppings"), Rs("allowtoppings").Type)
				MenuItemProperties.dishpropertiesgroupid.DbValue = ew_Conv(Rs("dishpropertiesgroupid"), Rs("dishpropertiesgroupid").Type)
				MenuItemProperties.printingname.DbValue = ew_Conv(Rs("printingname"), Rs("printingname").Type)
				MenuItemProperties.i_displaysort.DbValue = ew_Conv(Rs("i_displaysort"), Rs("i_displaysort").Type)
			Else
				OldValue = MenuItemProperties.Name.DbValue
				NewValue = ew_Conv(Rs("Name"), Rs("Name").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					MenuItemProperties.Name.CurrentValue = Null
				End If
				OldValue = MenuItemProperties.Price.DbValue
				NewValue = ew_Conv(Rs("Price"), Rs("Price").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					MenuItemProperties.Price.CurrentValue = Null
				End If
				OldValue = MenuItemProperties.IdMenuItem.DbValue
				NewValue = ew_Conv(Rs("IdMenuItem"), Rs("IdMenuItem").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					MenuItemProperties.IdMenuItem.CurrentValue = Null
				End If
				OldValue = MenuItemProperties.allowtoppings.DbValue
				NewValue = ew_Conv(Rs("allowtoppings"), Rs("allowtoppings").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					MenuItemProperties.allowtoppings.CurrentValue = Null
				End If
				OldValue = MenuItemProperties.dishpropertiesgroupid.DbValue
				NewValue = ew_Conv(Rs("dishpropertiesgroupid"), Rs("dishpropertiesgroupid").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					MenuItemProperties.dishpropertiesgroupid.CurrentValue = Null
				End If
				OldValue = MenuItemProperties.printingname.DbValue
				NewValue = ew_Conv(Rs("printingname"), Rs("printingname").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					MenuItemProperties.printingname.CurrentValue = Null
				End If
				OldValue = MenuItemProperties.i_displaysort.DbValue
				NewValue = ew_Conv(Rs("i_displaysort"), Rs("i_displaysort").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					MenuItemProperties.i_displaysort.CurrentValue = Null
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
		MenuItemProperties.Id.CurrentValue = sKeyFld ' Set up key value
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
		MenuItemProperties.CurrentFilter = MenuItemProperties.GetKeyFilter()
		sSql = MenuItemProperties.SQL
		Set Rs = Server.CreateObject("ADODB.Recordset")
		Rs.CursorLocation = EW_CURSORLOCATION
		Rs.Open sSql, Conn, 1, EW_RECORDSET_LOCKTYPE
		Set RsOld = ew_CloneRs(Rs)

		' Update all rows
		sKey = ""
		For i = 0 to UBound(RecKeys)
			If SetupKeyValues(RecKeys(i)) Then
				sThisKey = RecKeys(i)
				MenuItemProperties.SendEmail = False ' Do not send email on update success
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
		If Not MenuItemProperties.Name.FldIsDetailKey Then MenuItemProperties.Name.FormValue = ObjForm.GetValue("x_Name")
		MenuItemProperties.Name.MultiUpdate = ObjForm.GetValue("u_Name")
		If Not MenuItemProperties.Price.FldIsDetailKey Then MenuItemProperties.Price.FormValue = ObjForm.GetValue("x_Price")
		MenuItemProperties.Price.MultiUpdate = ObjForm.GetValue("u_Price")
		If Not MenuItemProperties.IdMenuItem.FldIsDetailKey Then MenuItemProperties.IdMenuItem.FormValue = ObjForm.GetValue("x_IdMenuItem")
		MenuItemProperties.IdMenuItem.MultiUpdate = ObjForm.GetValue("u_IdMenuItem")
		If Not MenuItemProperties.allowtoppings.FldIsDetailKey Then MenuItemProperties.allowtoppings.FormValue = ObjForm.GetValue("x_allowtoppings")
		MenuItemProperties.allowtoppings.MultiUpdate = ObjForm.GetValue("u_allowtoppings")
		If Not MenuItemProperties.dishpropertiesgroupid.FldIsDetailKey Then MenuItemProperties.dishpropertiesgroupid.FormValue = ObjForm.GetValue("x_dishpropertiesgroupid")
		MenuItemProperties.dishpropertiesgroupid.MultiUpdate = ObjForm.GetValue("u_dishpropertiesgroupid")
		If Not MenuItemProperties.printingname.FldIsDetailKey Then MenuItemProperties.printingname.FormValue = ObjForm.GetValue("x_printingname")
		MenuItemProperties.printingname.MultiUpdate = ObjForm.GetValue("u_printingname")
		If Not MenuItemProperties.i_displaysort.FldIsDetailKey Then MenuItemProperties.i_displaysort.FormValue = ObjForm.GetValue("x_i_displaysort")
		MenuItemProperties.i_displaysort.MultiUpdate = ObjForm.GetValue("u_i_displaysort")
		If Not MenuItemProperties.Id.FldIsDetailKey Then MenuItemProperties.Id.FormValue = ObjForm.GetValue("x_Id")
	End Function

	' -----------------------------------------------------------------
	' Restore form values
	'
	Function RestoreFormValues()
		MenuItemProperties.Name.CurrentValue = MenuItemProperties.Name.FormValue
		MenuItemProperties.Price.CurrentValue = MenuItemProperties.Price.FormValue
		MenuItemProperties.IdMenuItem.CurrentValue = MenuItemProperties.IdMenuItem.FormValue
		MenuItemProperties.allowtoppings.CurrentValue = MenuItemProperties.allowtoppings.FormValue
		MenuItemProperties.dishpropertiesgroupid.CurrentValue = MenuItemProperties.dishpropertiesgroupid.FormValue
		MenuItemProperties.printingname.CurrentValue = MenuItemProperties.printingname.FormValue
		MenuItemProperties.i_displaysort.CurrentValue = MenuItemProperties.i_displaysort.FormValue
		MenuItemProperties.Id.CurrentValue = MenuItemProperties.Id.FormValue
	End Function

	' -----------------------------------------------------------------
	' Load recordset
	'
	Function LoadRecordset()

		' Load list page sql
		Dim sSql
		sSql = MenuItemProperties.SelectSQL
		Call ew_SetDebugMsg("LoadRecordset: " & sSql) ' Show SQL for debugging

		' Load recordset
		Dim RsRecordset
		Set RsRecordset = ew_LoadRecordset(sSql)

		' Call Recordset Selected event
		Call MenuItemProperties.Recordset_Selected(RsRecordset)
		Set LoadRecordset = RsRecordset
	End Function

	' -----------------------------------------------------------------
	' Load row based on key values
	'
	Function LoadRow()
		Dim RsRow, sSql, sFilter
		sFilter = MenuItemProperties.KeyFilter

		' Call Row Selecting event
		Call MenuItemProperties.Row_Selecting(sFilter)

		' Load sql based on filter
		MenuItemProperties.CurrentFilter = sFilter
		sSql = MenuItemProperties.SQL
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
		Call MenuItemProperties.Row_Selected(RsRow)
		MenuItemProperties.Id.DbValue = RsRow("Id")
		MenuItemProperties.Name.DbValue = RsRow("Name")
		MenuItemProperties.Price.DbValue = ew_Conv(RsRow("Price"), 131)
		MenuItemProperties.IdMenuItem.DbValue = RsRow("IdMenuItem")
		MenuItemProperties.allowtoppings.DbValue = RsRow("allowtoppings")
		MenuItemProperties.dishpropertiesgroupid.DbValue = RsRow("dishpropertiesgroupid")
		MenuItemProperties.printingname.DbValue = RsRow("printingname")
		MenuItemProperties.i_displaysort.DbValue = RsRow("i_displaysort")
	End Sub

	' Load DbValue from recordset
	Sub LoadDbValues(Rs)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		If Rs.Eof Then Exit Sub
		MenuItemProperties.Id.m_DbValue = Rs("Id")
		MenuItemProperties.Name.m_DbValue = Rs("Name")
		MenuItemProperties.Price.m_DbValue = ew_Conv(Rs("Price"), 131)
		MenuItemProperties.IdMenuItem.m_DbValue = Rs("IdMenuItem")
		MenuItemProperties.allowtoppings.m_DbValue = Rs("allowtoppings")
		MenuItemProperties.dishpropertiesgroupid.m_DbValue = Rs("dishpropertiesgroupid")
		MenuItemProperties.printingname.m_DbValue = Rs("printingname")
		MenuItemProperties.i_displaysort.m_DbValue = Rs("i_displaysort")
	End Sub

	' -----------------------------------------------------------------
	' Render row values based on field settings
	'
	Sub RenderRow()

		' Initialize urls
		' Convert decimal values if posted back

		If MenuItemProperties.Price.CurrentValue & "" <> "" Then MenuItemProperties.Price.CurrentValue = ew_Conv(MenuItemProperties.Price.CurrentValue, MenuItemProperties.Price.FldType)
		If MenuItemProperties.Price.FormValue = MenuItemProperties.Price.CurrentValue And IsNumeric(MenuItemProperties.Price.CurrentValue) Then
			MenuItemProperties.Price.CurrentValue = ew_StrToFloat(MenuItemProperties.Price.CurrentValue)
		End If

		' Call Row Rendering event
		Call MenuItemProperties.Row_Rendering()

		' ---------------------------------------
		'  Common render codes for all row types
		' ---------------------------------------
		' Id
		' Name
		' Price
		' IdMenuItem
		' allowtoppings
		' dishpropertiesgroupid
		' printingname
		' i_displaysort
		' -----------
		'  View  Row
		' -----------

		If MenuItemProperties.RowType = EW_ROWTYPE_VIEW Then ' View row

			' Id
			MenuItemProperties.Id.ViewValue = MenuItemProperties.Id.CurrentValue
			MenuItemProperties.Id.ViewCustomAttributes = ""

			' Name
			MenuItemProperties.Name.ViewValue = MenuItemProperties.Name.CurrentValue
			MenuItemProperties.Name.ViewCustomAttributes = ""

			' Price
			MenuItemProperties.Price.ViewValue = MenuItemProperties.Price.CurrentValue
			MenuItemProperties.Price.ViewCustomAttributes = ""

			' IdMenuItem
			MenuItemProperties.IdMenuItem.ViewValue = MenuItemProperties.IdMenuItem.CurrentValue
			MenuItemProperties.IdMenuItem.ViewCustomAttributes = ""

			' allowtoppings
			MenuItemProperties.allowtoppings.ViewValue = MenuItemProperties.allowtoppings.CurrentValue
			MenuItemProperties.allowtoppings.ViewCustomAttributes = ""

			' dishpropertiesgroupid
			MenuItemProperties.dishpropertiesgroupid.ViewValue = MenuItemProperties.dishpropertiesgroupid.CurrentValue
			MenuItemProperties.dishpropertiesgroupid.ViewCustomAttributes = ""

			' printingname
			MenuItemProperties.printingname.ViewValue = MenuItemProperties.printingname.CurrentValue
			MenuItemProperties.printingname.ViewCustomAttributes = ""

			' i_displaysort
			MenuItemProperties.i_displaysort.ViewValue = MenuItemProperties.i_displaysort.CurrentValue
			MenuItemProperties.i_displaysort.ViewCustomAttributes = ""

			' View refer script
			' Name

			MenuItemProperties.Name.LinkCustomAttributes = ""
			MenuItemProperties.Name.HrefValue = ""
			MenuItemProperties.Name.TooltipValue = ""

			' Price
			MenuItemProperties.Price.LinkCustomAttributes = ""
			MenuItemProperties.Price.HrefValue = ""
			MenuItemProperties.Price.TooltipValue = ""

			' IdMenuItem
			MenuItemProperties.IdMenuItem.LinkCustomAttributes = ""
			MenuItemProperties.IdMenuItem.HrefValue = ""
			MenuItemProperties.IdMenuItem.TooltipValue = ""

			' allowtoppings
			MenuItemProperties.allowtoppings.LinkCustomAttributes = ""
			MenuItemProperties.allowtoppings.HrefValue = ""
			MenuItemProperties.allowtoppings.TooltipValue = ""

			' dishpropertiesgroupid
			MenuItemProperties.dishpropertiesgroupid.LinkCustomAttributes = ""
			MenuItemProperties.dishpropertiesgroupid.HrefValue = ""
			MenuItemProperties.dishpropertiesgroupid.TooltipValue = ""

			' printingname
			MenuItemProperties.printingname.LinkCustomAttributes = ""
			MenuItemProperties.printingname.HrefValue = ""
			MenuItemProperties.printingname.TooltipValue = ""

			' i_displaysort
			MenuItemProperties.i_displaysort.LinkCustomAttributes = ""
			MenuItemProperties.i_displaysort.HrefValue = ""
			MenuItemProperties.i_displaysort.TooltipValue = ""

		' ----------
		'  Edit Row
		' ----------

		ElseIf MenuItemProperties.RowType = EW_ROWTYPE_EDIT Then ' Edit row

			' Name
			MenuItemProperties.Name.EditAttrs.UpdateAttribute "class", "form-control"
			MenuItemProperties.Name.EditCustomAttributes = ""
			MenuItemProperties.Name.EditValue = ew_HtmlEncode(MenuItemProperties.Name.CurrentValue)
			MenuItemProperties.Name.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuItemProperties.Name.FldCaption))

			' Price
			MenuItemProperties.Price.EditAttrs.UpdateAttribute "class", "form-control"
			MenuItemProperties.Price.EditCustomAttributes = ""
			MenuItemProperties.Price.EditValue = ew_HtmlEncode(MenuItemProperties.Price.CurrentValue)
			MenuItemProperties.Price.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuItemProperties.Price.FldCaption))
			If MenuItemProperties.Price.EditValue&"" <> "" And IsNumeric(MenuItemProperties.Price.EditValue) Then MenuItemProperties.Price.EditValue = ew_FormatNumber2(MenuItemProperties.Price.EditValue, -2)

			' IdMenuItem
			MenuItemProperties.IdMenuItem.EditAttrs.UpdateAttribute "class", "form-control"
			MenuItemProperties.IdMenuItem.EditCustomAttributes = ""
			MenuItemProperties.IdMenuItem.EditValue = ew_HtmlEncode(MenuItemProperties.IdMenuItem.CurrentValue)
			MenuItemProperties.IdMenuItem.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuItemProperties.IdMenuItem.FldCaption))

			' allowtoppings
			MenuItemProperties.allowtoppings.EditAttrs.UpdateAttribute "class", "form-control"
			MenuItemProperties.allowtoppings.EditCustomAttributes = ""
			MenuItemProperties.allowtoppings.EditValue = ew_HtmlEncode(MenuItemProperties.allowtoppings.CurrentValue)
			MenuItemProperties.allowtoppings.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuItemProperties.allowtoppings.FldCaption))

			' dishpropertiesgroupid
			MenuItemProperties.dishpropertiesgroupid.EditAttrs.UpdateAttribute "class", "form-control"
			MenuItemProperties.dishpropertiesgroupid.EditCustomAttributes = ""
			MenuItemProperties.dishpropertiesgroupid.EditValue = ew_HtmlEncode(MenuItemProperties.dishpropertiesgroupid.CurrentValue)
			MenuItemProperties.dishpropertiesgroupid.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuItemProperties.dishpropertiesgroupid.FldCaption))

			' printingname
			MenuItemProperties.printingname.EditAttrs.UpdateAttribute "class", "form-control"
			MenuItemProperties.printingname.EditCustomAttributes = ""
			MenuItemProperties.printingname.EditValue = ew_HtmlEncode(MenuItemProperties.printingname.CurrentValue)
			MenuItemProperties.printingname.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuItemProperties.printingname.FldCaption))

			' i_displaysort
			MenuItemProperties.i_displaysort.EditAttrs.UpdateAttribute "class", "form-control"
			MenuItemProperties.i_displaysort.EditCustomAttributes = ""
			MenuItemProperties.i_displaysort.EditValue = ew_HtmlEncode(MenuItemProperties.i_displaysort.CurrentValue)
			MenuItemProperties.i_displaysort.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuItemProperties.i_displaysort.FldCaption))

			' Edit refer script
			' Name

			MenuItemProperties.Name.HrefValue = ""

			' Price
			MenuItemProperties.Price.HrefValue = ""

			' IdMenuItem
			MenuItemProperties.IdMenuItem.HrefValue = ""

			' allowtoppings
			MenuItemProperties.allowtoppings.HrefValue = ""

			' dishpropertiesgroupid
			MenuItemProperties.dishpropertiesgroupid.HrefValue = ""

			' printingname
			MenuItemProperties.printingname.HrefValue = ""

			' i_displaysort
			MenuItemProperties.i_displaysort.HrefValue = ""
		End If
		If MenuItemProperties.RowType = EW_ROWTYPE_ADD Or MenuItemProperties.RowType = EW_ROWTYPE_EDIT Or MenuItemProperties.RowType = EW_ROWTYPE_SEARCH Then ' Add / Edit / Search row
			Call MenuItemProperties.SetupFieldTitles()
		End If

		' Call Row Rendered event
		If MenuItemProperties.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call MenuItemProperties.Row_Rendered()
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
		If MenuItemProperties.Name.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If MenuItemProperties.Price.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If MenuItemProperties.IdMenuItem.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If MenuItemProperties.allowtoppings.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If MenuItemProperties.dishpropertiesgroupid.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If MenuItemProperties.printingname.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If MenuItemProperties.i_displaysort.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
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
		If MenuItemProperties.Price.MultiUpdate <> "" Then
			If Not ew_CheckNumber(MenuItemProperties.Price.FormValue) Then
				Call ew_AddMessage(gsFormError, MenuItemProperties.Price.FldErrMsg)
			End If
		End If
		If MenuItemProperties.IdMenuItem.MultiUpdate <> "" Then
			If Not ew_CheckInteger(MenuItemProperties.IdMenuItem.FormValue) Then
				Call ew_AddMessage(gsFormError, MenuItemProperties.IdMenuItem.FldErrMsg)
			End If
		End If
		If MenuItemProperties.allowtoppings.MultiUpdate <> "" Then
			If Not ew_CheckInteger(MenuItemProperties.allowtoppings.FormValue) Then
				Call ew_AddMessage(gsFormError, MenuItemProperties.allowtoppings.FldErrMsg)
			End If
		End If
		If MenuItemProperties.i_displaysort.MultiUpdate <> "" Then
			If Not ew_CheckInteger(MenuItemProperties.i_displaysort.FormValue) Then
				Call ew_AddMessage(gsFormError, MenuItemProperties.i_displaysort.FldErrMsg)
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
		sFilter = MenuItemProperties.KeyFilter
		MenuItemProperties.CurrentFilter  = sFilter
		sSql = MenuItemProperties.SQL
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

			' Field Name
			Call MenuItemProperties.Name.SetDbValue(Rs, MenuItemProperties.Name.CurrentValue, Null, MenuItemProperties.Name.ReadOnly Or MenuItemProperties.Name.MultiUpdate&"" <> "1")

			' Field Price
			Call MenuItemProperties.Price.SetDbValue(Rs, MenuItemProperties.Price.CurrentValue, Null, MenuItemProperties.Price.ReadOnly Or MenuItemProperties.Price.MultiUpdate&"" <> "1")

			' Field IdMenuItem
			Call MenuItemProperties.IdMenuItem.SetDbValue(Rs, MenuItemProperties.IdMenuItem.CurrentValue, Null, MenuItemProperties.IdMenuItem.ReadOnly Or MenuItemProperties.IdMenuItem.MultiUpdate&"" <> "1")

			' Field allowtoppings
			Call MenuItemProperties.allowtoppings.SetDbValue(Rs, MenuItemProperties.allowtoppings.CurrentValue, Null, MenuItemProperties.allowtoppings.ReadOnly Or MenuItemProperties.allowtoppings.MultiUpdate&"" <> "1")

			' Field dishpropertiesgroupid
			Call MenuItemProperties.dishpropertiesgroupid.SetDbValue(Rs, MenuItemProperties.dishpropertiesgroupid.CurrentValue, Null, MenuItemProperties.dishpropertiesgroupid.ReadOnly Or MenuItemProperties.dishpropertiesgroupid.MultiUpdate&"" <> "1")

			' Field printingname
			Call MenuItemProperties.printingname.SetDbValue(Rs, MenuItemProperties.printingname.CurrentValue, Null, MenuItemProperties.printingname.ReadOnly Or MenuItemProperties.printingname.MultiUpdate&"" <> "1")

			' Field i_displaysort
			Call MenuItemProperties.i_displaysort.SetDbValue(Rs, MenuItemProperties.i_displaysort.CurrentValue, Null, MenuItemProperties.i_displaysort.ReadOnly Or MenuItemProperties.i_displaysort.MultiUpdate&"" <> "1")

			' Check recordset update error
			If Err.Number <> 0 Then
				FailureMessage = Err.Description
				Rs.Close
				Set Rs = Nothing
				EditRow = False
				Exit Function
			End If

			' Call Row Updating event
			bUpdateRow = MenuItemProperties.Row_Updating(RsOld, Rs)
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
				ElseIf MenuItemProperties.CancelMessage <> "" Then
					FailureMessage = MenuItemProperties.CancelMessage
					MenuItemProperties.CancelMessage = ""
				Else
					FailureMessage = Language.Phrase("UpdateCancelled")
				End If
				EditRow = False
			End If
		End If

		' Call Row Updated event
		If EditRow Then
			Call MenuItemProperties.Row_Updated(RsOld, RsNew)
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
		Call Breadcrumb.Add("list", MenuItemProperties.TableVar, "MenuItemPropertieslist.asp", "", MenuItemProperties.TableVar, True)
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
