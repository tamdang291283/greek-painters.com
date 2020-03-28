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
Dim MenuItemProperties_add
Set MenuItemProperties_add = New cMenuItemProperties_add
Set Page = MenuItemProperties_add

' Page init processing
MenuItemProperties_add.Page_Init()

' Page main processing
MenuItemProperties_add.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
MenuItemProperties_add.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var MenuItemProperties_add = new ew_Page("MenuItemProperties_add");
MenuItemProperties_add.PageID = "add"; // Page ID
var EW_PAGE_ID = MenuItemProperties_add.PageID; // For backward compatibility
// Form object
var fMenuItemPropertiesadd = new ew_Form("fMenuItemPropertiesadd");
// Validate form
fMenuItemPropertiesadd.Validate = function() {
	if (!this.ValidateRequired)
		return true; // Ignore validation
	var $ = jQuery, fobj = this.GetForm(), $fobj = $(fobj);
	this.PostAutoSuggest();
	if ($fobj.find("#a_confirm").val() == "F")
		return true;
	var elm, felm, uelm, addcnt = 0;
	var $k = $fobj.find("#" + this.FormKeyCountName); // Get key_count
	var rowcnt = ($k[0]) ? parseInt($k.val(), 10) : 1;
	var startcnt = (rowcnt == 0) ? 0 : 1; // Check rowcnt == 0 => Inline-Add
	var gridinsert = $fobj.find("#a_list").val() == "gridinsert";
	for (var i = startcnt; i <= rowcnt; i++) {
		var infix = ($k[0]) ? String(i) : "";
		$fobj.data("rowindex", infix);
			elm = this.GetElements("x" + infix + "_Price");
			if (elm && !ew_CheckNumber(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(MenuItemProperties.Price.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_IdMenuItem");
			if (elm && !ew_CheckInteger(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(MenuItemProperties.IdMenuItem.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_allowtoppings");
			if (elm && !ew_CheckInteger(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(MenuItemProperties.allowtoppings.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_i_displaysort");
			if (elm && !ew_CheckInteger(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(MenuItemProperties.i_displaysort.FldErrMsg) %>");
			// Set up row object
			ew_ElementsToRow(fobj);
			// Fire Form_CustomValidate event
			if (!this.Form_CustomValidate(fobj))
				return false;
	}
	// Process detail forms
	var dfs = $fobj.find("input[name='detailpage']").get();
	for (var i = 0; i < dfs.length; i++) {
		var df = dfs[i], val = df.value;
		if (val && ewForms[val])
			if (!ewForms[val].Validate())
				return false;
	}
	return true;
}
// Form_CustomValidate event
fMenuItemPropertiesadd.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fMenuItemPropertiesadd.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fMenuItemPropertiesadd.ValidateRequired = false; // No JavaScript validation
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
<% MenuItemProperties_add.ShowPageHeader() %>
<% MenuItemProperties_add.ShowMessage %>
<form name="fMenuItemPropertiesadd" id="fMenuItemPropertiesadd" class="form-horizontal ewForm ewAddForm" action="<%= ew_CurrentPage() %>" method="post">
<% If MenuItemProperties_add.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= MenuItemProperties_add.Token %>">
<% End If %>
<input type="hidden" name="t" value="MenuItemProperties">
<input type="hidden" name="a_add" id="a_add" value="A">
<div>
<% If MenuItemProperties.Name.Visible Then ' Name %>
	<div id="r_Name" class="form-group">
		<label id="elh_MenuItemProperties_Name" for="x_Name" class="col-sm-2 control-label ewLabel"><%= MenuItemProperties.Name.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuItemProperties.Name.CellAttributes %>>
<span id="el_MenuItemProperties_Name">
<input type="text" data-field="x_Name" name="x_Name" id="x_Name" size="30" maxlength="50" placeholder="<%= MenuItemProperties.Name.PlaceHolder %>" value="<%= MenuItemProperties.Name.EditValue %>"<%= MenuItemProperties.Name.EditAttributes %>>
</span>
<%= MenuItemProperties.Name.CustomMsg %></div></div>
	</div>
<% End If %>
<% If MenuItemProperties.Price.Visible Then ' Price %>
	<div id="r_Price" class="form-group">
		<label id="elh_MenuItemProperties_Price" for="x_Price" class="col-sm-2 control-label ewLabel"><%= MenuItemProperties.Price.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuItemProperties.Price.CellAttributes %>>
<span id="el_MenuItemProperties_Price">
<input type="text" data-field="x_Price" name="x_Price" id="x_Price" size="30" placeholder="<%= MenuItemProperties.Price.PlaceHolder %>" value="<%= MenuItemProperties.Price.EditValue %>"<%= MenuItemProperties.Price.EditAttributes %>>
</span>
<%= MenuItemProperties.Price.CustomMsg %></div></div>
	</div>
<% End If %>
<% If MenuItemProperties.IdMenuItem.Visible Then ' IdMenuItem %>
	<div id="r_IdMenuItem" class="form-group">
		<label id="elh_MenuItemProperties_IdMenuItem" for="x_IdMenuItem" class="col-sm-2 control-label ewLabel"><%= MenuItemProperties.IdMenuItem.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuItemProperties.IdMenuItem.CellAttributes %>>
<span id="el_MenuItemProperties_IdMenuItem">
<input type="text" data-field="x_IdMenuItem" name="x_IdMenuItem" id="x_IdMenuItem" size="30" placeholder="<%= MenuItemProperties.IdMenuItem.PlaceHolder %>" value="<%= MenuItemProperties.IdMenuItem.EditValue %>"<%= MenuItemProperties.IdMenuItem.EditAttributes %>>
</span>
<%= MenuItemProperties.IdMenuItem.CustomMsg %></div></div>
	</div>
<% End If %>
<% If MenuItemProperties.allowtoppings.Visible Then ' allowtoppings %>
	<div id="r_allowtoppings" class="form-group">
		<label id="elh_MenuItemProperties_allowtoppings" for="x_allowtoppings" class="col-sm-2 control-label ewLabel"><%= MenuItemProperties.allowtoppings.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuItemProperties.allowtoppings.CellAttributes %>>
<span id="el_MenuItemProperties_allowtoppings">
<input type="text" data-field="x_allowtoppings" name="x_allowtoppings" id="x_allowtoppings" size="30" placeholder="<%= MenuItemProperties.allowtoppings.PlaceHolder %>" value="<%= MenuItemProperties.allowtoppings.EditValue %>"<%= MenuItemProperties.allowtoppings.EditAttributes %>>
</span>
<%= MenuItemProperties.allowtoppings.CustomMsg %></div></div>
	</div>
<% End If %>
<% If MenuItemProperties.dishpropertiesgroupid.Visible Then ' dishpropertiesgroupid %>
	<div id="r_dishpropertiesgroupid" class="form-group">
		<label id="elh_MenuItemProperties_dishpropertiesgroupid" for="x_dishpropertiesgroupid" class="col-sm-2 control-label ewLabel"><%= MenuItemProperties.dishpropertiesgroupid.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuItemProperties.dishpropertiesgroupid.CellAttributes %>>
<span id="el_MenuItemProperties_dishpropertiesgroupid">
<input type="text" data-field="x_dishpropertiesgroupid" name="x_dishpropertiesgroupid" id="x_dishpropertiesgroupid" size="30" maxlength="255" placeholder="<%= MenuItemProperties.dishpropertiesgroupid.PlaceHolder %>" value="<%= MenuItemProperties.dishpropertiesgroupid.EditValue %>"<%= MenuItemProperties.dishpropertiesgroupid.EditAttributes %>>
</span>
<%= MenuItemProperties.dishpropertiesgroupid.CustomMsg %></div></div>
	</div>
<% End If %>
<% If MenuItemProperties.printingname.Visible Then ' printingname %>
	<div id="r_printingname" class="form-group">
		<label id="elh_MenuItemProperties_printingname" for="x_printingname" class="col-sm-2 control-label ewLabel"><%= MenuItemProperties.printingname.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuItemProperties.printingname.CellAttributes %>>
<span id="el_MenuItemProperties_printingname">
<input type="text" data-field="x_printingname" name="x_printingname" id="x_printingname" size="30" maxlength="255" placeholder="<%= MenuItemProperties.printingname.PlaceHolder %>" value="<%= MenuItemProperties.printingname.EditValue %>"<%= MenuItemProperties.printingname.EditAttributes %>>
</span>
<%= MenuItemProperties.printingname.CustomMsg %></div></div>
	</div>
<% End If %>
<% If MenuItemProperties.i_displaysort.Visible Then ' i_displaysort %>
	<div id="r_i_displaysort" class="form-group">
		<label id="elh_MenuItemProperties_i_displaysort" for="x_i_displaysort" class="col-sm-2 control-label ewLabel"><%= MenuItemProperties.i_displaysort.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuItemProperties.i_displaysort.CellAttributes %>>
<span id="el_MenuItemProperties_i_displaysort">
<input type="text" data-field="x_i_displaysort" name="x_i_displaysort" id="x_i_displaysort" size="30" placeholder="<%= MenuItemProperties.i_displaysort.PlaceHolder %>" value="<%= MenuItemProperties.i_displaysort.EditValue %>"<%= MenuItemProperties.i_displaysort.EditAttributes %>>
</span>
<%= MenuItemProperties.i_displaysort.CustomMsg %></div></div>
	</div>
<% End If %>
</div>
<div class="form-group">
	<div class="col-sm-offset-2 col-sm-10">
<button class="btn btn-primary ewButton" name="btnAction" id="btnAction" type="submit"><%= Language.Phrase("AddBtn") %></button>
	</div>
</div>
</form>
<script type="text/javascript">
fMenuItemPropertiesadd.Init();
</script>
<%
MenuItemProperties_add.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set MenuItemProperties_add = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cMenuItemProperties_add

	' Page ID
	Public Property Get PageID()
		PageID = "add"
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
		PageObjName = "MenuItemProperties_add"
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
		EW_PAGE_ID = "add"

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

	Dim DbMasterFilter, DbDetailFilter
	Dim StartRec
	Dim Priv
	Dim OldRecordset
	Dim CopyRecord

	' -----------------------------------------------------------------
	' Page main processing
	'
	Sub Page_Main()

		' Process form if post back
		If ObjForm.GetValue("a_add")&"" <> "" Then
			MenuItemProperties.CurrentAction = ObjForm.GetValue("a_add") ' Get form action
			CopyRecord = LoadOldRecord() ' Load old recordset
			Call LoadFormValues() ' Load form values

		' Not post back
		Else

			' Load key values from QueryString
			CopyRecord = True
			If Request.QueryString("Id").Count > 0 Then
				MenuItemProperties.Id.QueryStringValue = Request.QueryString("Id")
				Call MenuItemProperties.SetKey("Id", MenuItemProperties.Id.CurrentValue) ' Set up key
			Else
				Call MenuItemProperties.SetKey("Id", "") ' Clear key
				CopyRecord = False
			End If
			If CopyRecord Then
				MenuItemProperties.CurrentAction = "C" ' Copy Record
			Else
				MenuItemProperties.CurrentAction = "I" ' Display Blank Record
				Call LoadDefaultValues() ' Load default values
			End If
		End If

		' Set up Breadcrumb
		SetupBreadcrumb()

		' Validate form if post back
		If ObjForm.GetValue("a_add")&"" <> "" Then
			If Not ValidateForm() Then
				MenuItemProperties.CurrentAction = "I" ' Form error, reset action
				MenuItemProperties.EventCancelled = True ' Event cancelled
				Call RestoreFormValues() ' Restore form values
				FailureMessage = gsFormError
			End If
		End If

		' Perform action based on action code
		Select Case MenuItemProperties.CurrentAction
			Case "I" ' Blank record, no action required
			Case "C" ' Copy an existing record
				If Not LoadRow() Then ' Load record based on key
					If FailureMessage = "" Then FailureMessage = Language.Phrase("NoRecord") ' No record found
					Call Page_Terminate("MenuItemPropertieslist.asp") ' No matching record, return to list
				End If
			Case "A" ' Add new record
				MenuItemProperties.SendEmail = True ' Send email on add success
				If AddRow(OldRecordset) Then ' Add successful
					If SuccessMessage = "" Then SuccessMessage = Language.Phrase("AddSuccess") ' Set up success message
					Dim sReturnUrl
					sReturnUrl = MenuItemProperties.ReturnUrl
					If ew_GetPageName(sReturnUrl) = "MenuItemPropertiesview.asp" Then sReturnUrl = MenuItemProperties.ViewUrl("") ' View paging, return to view page with keyurl directly
					Call Page_Terminate(sReturnUrl) ' Clean up and return
				Else
					MenuItemProperties.EventCancelled = True ' Event cancelled
					Call RestoreFormValues() ' Add failed, restore form values
				End If
		End Select

		' Render row based on row type
		MenuItemProperties.RowType = EW_ROWTYPE_ADD ' Render add type

		' Render row
		Call MenuItemProperties.ResetAttrs()
		Call RenderRow()
	End Sub

	' -----------------------------------------------------------------
	' Function Get upload files
	'
	Function GetUploadFiles()

		' Get upload data
	End Function

	' -----------------------------------------------------------------
	' Load default values
	'
	Function LoadDefaultValues()
		MenuItemProperties.Name.CurrentValue = Null
		MenuItemProperties.Name.OldValue = MenuItemProperties.Name.CurrentValue
		MenuItemProperties.Price.CurrentValue = Null
		MenuItemProperties.Price.OldValue = MenuItemProperties.Price.CurrentValue
		MenuItemProperties.IdMenuItem.CurrentValue = Null
		MenuItemProperties.IdMenuItem.OldValue = MenuItemProperties.IdMenuItem.CurrentValue
		MenuItemProperties.allowtoppings.CurrentValue = Null
		MenuItemProperties.allowtoppings.OldValue = MenuItemProperties.allowtoppings.CurrentValue
		MenuItemProperties.dishpropertiesgroupid.CurrentValue = Null
		MenuItemProperties.dishpropertiesgroupid.OldValue = MenuItemProperties.dishpropertiesgroupid.CurrentValue
		MenuItemProperties.printingname.CurrentValue = Null
		MenuItemProperties.printingname.OldValue = MenuItemProperties.printingname.CurrentValue
		MenuItemProperties.i_displaysort.CurrentValue = Null
		MenuItemProperties.i_displaysort.OldValue = MenuItemProperties.i_displaysort.CurrentValue
	End Function

	' -----------------------------------------------------------------
	' Load form values
	'
	Function LoadFormValues()

		' Load values from form
		If Not MenuItemProperties.Name.FldIsDetailKey Then MenuItemProperties.Name.FormValue = ObjForm.GetValue("x_Name")
		If Not MenuItemProperties.Price.FldIsDetailKey Then MenuItemProperties.Price.FormValue = ObjForm.GetValue("x_Price")
		If Not MenuItemProperties.IdMenuItem.FldIsDetailKey Then MenuItemProperties.IdMenuItem.FormValue = ObjForm.GetValue("x_IdMenuItem")
		If Not MenuItemProperties.allowtoppings.FldIsDetailKey Then MenuItemProperties.allowtoppings.FormValue = ObjForm.GetValue("x_allowtoppings")
		If Not MenuItemProperties.dishpropertiesgroupid.FldIsDetailKey Then MenuItemProperties.dishpropertiesgroupid.FormValue = ObjForm.GetValue("x_dishpropertiesgroupid")
		If Not MenuItemProperties.printingname.FldIsDetailKey Then MenuItemProperties.printingname.FormValue = ObjForm.GetValue("x_printingname")
		If Not MenuItemProperties.i_displaysort.FldIsDetailKey Then MenuItemProperties.i_displaysort.FormValue = ObjForm.GetValue("x_i_displaysort")
	End Function

	' -----------------------------------------------------------------
	' Restore form values
	'
	Function RestoreFormValues()
		Call LoadOldRecord()
		MenuItemProperties.Name.CurrentValue = MenuItemProperties.Name.FormValue
		MenuItemProperties.Price.CurrentValue = MenuItemProperties.Price.FormValue
		MenuItemProperties.IdMenuItem.CurrentValue = MenuItemProperties.IdMenuItem.FormValue
		MenuItemProperties.allowtoppings.CurrentValue = MenuItemProperties.allowtoppings.FormValue
		MenuItemProperties.dishpropertiesgroupid.CurrentValue = MenuItemProperties.dishpropertiesgroupid.FormValue
		MenuItemProperties.printingname.CurrentValue = MenuItemProperties.printingname.FormValue
		MenuItemProperties.i_displaysort.CurrentValue = MenuItemProperties.i_displaysort.FormValue
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

	' Load old record
	Function LoadOldRecord()

		' Load key values from Session
		Dim bValidKey
		bValidKey = True
		If MenuItemProperties.GetKey("Id")&"" <> "" Then
			MenuItemProperties.Id.CurrentValue = MenuItemProperties.GetKey("Id") ' Id
		Else
			bValidKey = False
		End If

		' Load old recordset
		If bValidKey Then
			MenuItemProperties.CurrentFilter = MenuItemProperties.KeyFilter
			Dim sSql
			sSql = MenuItemProperties.SQL
			Set OldRecordset = ew_LoadRecordset(sSql)
			Call LoadRowValues(OldRecordset) ' Load row values
		Else
			OldRecordset = Null
		End If
		LoadOldRecord = bValidKey
	End Function

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

		' ---------
		'  Add Row
		' ---------

		ElseIf MenuItemProperties.RowType = EW_ROWTYPE_ADD Then ' Add row

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

		' Check if validation required
		If Not EW_SERVER_VALIDATE Then
			ValidateForm = (gsFormError = "")
			Exit Function
		End If
		If Not ew_CheckNumber(MenuItemProperties.Price.FormValue) Then
			Call ew_AddMessage(gsFormError, MenuItemProperties.Price.FldErrMsg)
		End If
		If Not ew_CheckInteger(MenuItemProperties.IdMenuItem.FormValue) Then
			Call ew_AddMessage(gsFormError, MenuItemProperties.IdMenuItem.FldErrMsg)
		End If
		If Not ew_CheckInteger(MenuItemProperties.allowtoppings.FormValue) Then
			Call ew_AddMessage(gsFormError, MenuItemProperties.allowtoppings.FldErrMsg)
		End If
		If Not ew_CheckInteger(MenuItemProperties.i_displaysort.FormValue) Then
			Call ew_AddMessage(gsFormError, MenuItemProperties.i_displaysort.FldErrMsg)
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
	' Add record
	'
	Function AddRow(RsOld)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		Dim Rs, sSql, sFilter
		Dim RsNew
		Dim bInsertRow
		Dim RsChk
		Dim sIdxErrMsg

		' Clear any previous errors
		Err.Clear
		Dim RsMaster, sMasterUserIdMsg, sMasterFilter, bCheckMasterRecord

		' Load db values from rsold
		If Not IsNull(RsOld) Then
			Call LoadDbValues(RsOld)
		End If

		' Add new record
		sFilter = "(0 = 1)"
		MenuItemProperties.CurrentFilter = sFilter
		sSql = MenuItemProperties.SQL
		Set Rs = Server.CreateObject("ADODB.Recordset")
		Rs.CursorLocation = EW_CURSORLOCATION
		Rs.Open sSql, Conn, 1, EW_RECORDSET_LOCKTYPE
		Rs.AddNew
		If Err.Number <> 0 Then
			Message = Err.Description
			Rs.Close
			Set Rs = Nothing
			AddRow = False
			Exit Function
		End If

		' Field Name
		Call MenuItemProperties.Name.SetDbValue(Rs, MenuItemProperties.Name.CurrentValue, Null, False)

		' Field Price
		Call MenuItemProperties.Price.SetDbValue(Rs, MenuItemProperties.Price.CurrentValue, Null, False)

		' Field IdMenuItem
		Call MenuItemProperties.IdMenuItem.SetDbValue(Rs, MenuItemProperties.IdMenuItem.CurrentValue, Null, False)

		' Field allowtoppings
		Call MenuItemProperties.allowtoppings.SetDbValue(Rs, MenuItemProperties.allowtoppings.CurrentValue, Null, False)

		' Field dishpropertiesgroupid
		Call MenuItemProperties.dishpropertiesgroupid.SetDbValue(Rs, MenuItemProperties.dishpropertiesgroupid.CurrentValue, Null, False)

		' Field printingname
		Call MenuItemProperties.printingname.SetDbValue(Rs, MenuItemProperties.printingname.CurrentValue, Null, False)

		' Field i_displaysort
		Call MenuItemProperties.i_displaysort.SetDbValue(Rs, MenuItemProperties.i_displaysort.CurrentValue, Null, False)

		' Check recordset update error
		If Err.Number <> 0 Then
			FailureMessage = Err.Description
			Rs.Close
			Set Rs = Nothing
			AddRow = False
			Exit Function
		End If

		' Call Row Inserting event
		bInsertRow = MenuItemProperties.Row_Inserting(RsOld, Rs)
		If bInsertRow Then

			' Clone new recordset object
			Set RsNew = ew_CloneRs(Rs)
			Rs.Update
			If Err.Number <> 0 Then
				FailureMessage = Err.Description
				AddRow = False
			Else
				AddRow = True
			End If
			If AddRow Then
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
				FailureMessage = Language.Phrase("InsertCancelled")
			End If
			AddRow = False
		End If
		Rs.Close
		Set Rs = Nothing
		If AddRow Then
			MenuItemProperties.Id.DbValue = RsNew("Id")
		End If
		If AddRow Then

			' Call Row Inserted event
			Call MenuItemProperties.Row_Inserted(RsOld, RsNew)
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
		PageId = ew_IIf(MenuItemProperties.CurrentAction = "C", "Copy", "Add")
		Call Breadcrumb.Add("add", PageId, url, "", "", False)
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
