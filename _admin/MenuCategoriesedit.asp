﻿<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="MenuCategoriesinfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim MenuCategories_edit
Set MenuCategories_edit = New cMenuCategories_edit
Set Page = MenuCategories_edit

' Page init processing
MenuCategories_edit.Page_Init()

' Page main processing
MenuCategories_edit.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
MenuCategories_edit.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var MenuCategories_edit = new ew_Page("MenuCategories_edit");
MenuCategories_edit.PageID = "edit"; // Page ID
var EW_PAGE_ID = MenuCategories_edit.PageID; // For backward compatibility
// Form object
var fMenuCategoriesedit = new ew_Form("fMenuCategoriesedit");
// Validate form
fMenuCategoriesedit.Validate = function() {
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
			elm = this.GetElements("x" + infix + "_displayorder");
			if (elm && !ew_CheckInteger(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(MenuCategories.displayorder.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_IdBusinessDetail");
			if (elm && !ew_CheckInteger(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(MenuCategories.IdBusinessDetail.FldErrMsg) %>");
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
fMenuCategoriesedit.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fMenuCategoriesedit.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fMenuCategoriesedit.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<div class="ewToolbar">
<% If MenuCategories.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If MenuCategories.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% MenuCategories_edit.ShowPageHeader() %>
<% MenuCategories_edit.ShowMessage %>
<form name="fMenuCategoriesedit" id="fMenuCategoriesedit" class="form-horizontal ewForm ewEditForm" action="<%= ew_CurrentPage %>" method="post">
<% If MenuCategories_edit.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= MenuCategories_edit.Token %>">
<% End If %>
<input type="hidden" name="a_table" id="a_table" value="MenuCategories">
<input type="hidden" name="a_edit" id="a_edit" value="U">
<div>
<% If MenuCategories.ID.Visible Then ' ID %>
	<div id="r_ID" class="form-group">
		<label id="elh_MenuCategories_ID" class="col-sm-2 control-label ewLabel"><%= MenuCategories.ID.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuCategories.ID.CellAttributes %>>
<span id="el_MenuCategories_ID">
<span<%= MenuCategories.ID.ViewAttributes %>>
<p class="form-control-static"><%= MenuCategories.ID.EditValue %></p>
</span>
</span>
<input type="hidden" data-field="x_ID" name="x_ID" id="x_ID" value="<%= Server.HTMLEncode(MenuCategories.ID.CurrentValue&"") %>">
<%= MenuCategories.ID.CustomMsg %></div></div>
	</div>
<% End If %>
<% If MenuCategories.Name.Visible Then ' Name %>
	<div id="r_Name" class="form-group">
		<label id="elh_MenuCategories_Name" for="x_Name" class="col-sm-2 control-label ewLabel"><%= MenuCategories.Name.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuCategories.Name.CellAttributes %>>
<span id="el_MenuCategories_Name">
<input type="text" data-field="x_Name" name="x_Name" id="x_Name" size="30" maxlength="255" placeholder="<%= MenuCategories.Name.PlaceHolder %>" value="<%= MenuCategories.Name.EditValue %>"<%= MenuCategories.Name.EditAttributes %>>
</span>
<%= MenuCategories.Name.CustomMsg %></div></div>
	</div>
<% End If %>
<% If MenuCategories.Description.Visible Then ' Description %>
	<div id="r_Description" class="form-group">
		<label id="elh_MenuCategories_Description" for="x_Description" class="col-sm-2 control-label ewLabel"><%= MenuCategories.Description.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuCategories.Description.CellAttributes %>>
<span id="el_MenuCategories_Description">
<input type="text" data-field="x_Description" name="x_Description" id="x_Description" size="30" maxlength="255" placeholder="<%= MenuCategories.Description.PlaceHolder %>" value="<%= MenuCategories.Description.EditValue %>"<%= MenuCategories.Description.EditAttributes %>>
</span>
<%= MenuCategories.Description.CustomMsg %></div></div>
	</div>
<% End If %>
<% If MenuCategories.displayorder.Visible Then ' displayorder %>
	<div id="r_displayorder" class="form-group">
		<label id="elh_MenuCategories_displayorder" for="x_displayorder" class="col-sm-2 control-label ewLabel"><%= MenuCategories.displayorder.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuCategories.displayorder.CellAttributes %>>
<span id="el_MenuCategories_displayorder">
<input type="text" data-field="x_displayorder" name="x_displayorder" id="x_displayorder" size="30" placeholder="<%= MenuCategories.displayorder.PlaceHolder %>" value="<%= MenuCategories.displayorder.EditValue %>"<%= MenuCategories.displayorder.EditAttributes %>>
</span>
<%= MenuCategories.displayorder.CustomMsg %></div></div>
	</div>
<% End If %>
<% If MenuCategories.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
	<div id="r_IdBusinessDetail" class="form-group">
		<label id="elh_MenuCategories_IdBusinessDetail" for="x_IdBusinessDetail" class="col-sm-2 control-label ewLabel"><%= MenuCategories.IdBusinessDetail.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuCategories.IdBusinessDetail.CellAttributes %>>
<span id="el_MenuCategories_IdBusinessDetail">
<input type="text" data-field="x_IdBusinessDetail" name="x_IdBusinessDetail" id="x_IdBusinessDetail" size="30" placeholder="<%= MenuCategories.IdBusinessDetail.PlaceHolder %>" value="<%= MenuCategories.IdBusinessDetail.EditValue %>"<%= MenuCategories.IdBusinessDetail.EditAttributes %>>
</span>
<%= MenuCategories.IdBusinessDetail.CustomMsg %></div></div>
	</div>
<% End If %>
</div>
<div class="form-group">
	<div class="col-sm-offset-2 col-sm-10">
<button class="btn btn-primary ewButton" name="btnAction" id="btnAction" type="submit"><%= Language.Phrase("SaveBtn") %></button>
	</div>
</div>
</form>
<script type="text/javascript">
fMenuCategoriesedit.Init();
</script>
<%
MenuCategories_edit.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set MenuCategories_edit = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cMenuCategories_edit

	' Page ID
	Public Property Get PageID()
		PageID = "edit"
	End Property

	' Project ID
	Public Property Get ProjectID()
		ProjectID = "{E9837C6B-C139-4DEF-A37B-491BE9913D3B}"
	End Property

	' Table Name
	Public Property Get TableName()
		TableName = "MenuCategories"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "MenuCategories_edit"
	End Property

	' Page Name
	Public Property Get PageName()
		PageName = ew_CurrentPage()
	End Property

	' Page Url
	Public Property Get PageUrl()
		PageUrl = ew_CurrentPage() & "?"
		If MenuCategories.UseTokenInUrl Then PageUrl = PageUrl & "t=" & MenuCategories.TableVar & "&" ' add page token
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
		If MenuCategories.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (MenuCategories.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (MenuCategories.TableVar = Request.QueryString("t"))
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
		If IsEmpty(MenuCategories) Then Set MenuCategories = New cMenuCategories
		Set Table = MenuCategories

		' Initialize urls
		' Initialize form object

		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "edit"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "MenuCategories"

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

		MenuCategories.CurrentAction = ew_IIf(Request.QueryString("a").Count > 0, Request.QueryString("a") & "", ObjForm.GetValue("a_list") & "") ' Set up current action
		MenuCategories.ID.Visible = Not MenuCategories.IsAdd() And Not MenuCategories.IsCopy() And Not MenuCategories.IsGridAdd()

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
			results = MenuCategories.GetAutoFill(Request.Form("name"), Request.Form("q"))
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
		If Not MenuCategories Is Nothing Then
			If MenuCategories.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = MenuCategories.TableVar
				If MenuCategories.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf MenuCategories.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf MenuCategories.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf MenuCategories.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set MenuCategories = Nothing
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
	Dim DisplayRecs
	Dim StartRec, StopRec, TotalRecs, RecRange
	Dim RecCnt
	Dim Recordset

	' -----------------------------------------------------------------
	' Page main processing
	'
	Sub Page_Main()
		Dim sReturnUrl
		sReturnUrl = ""

		' Load key from QueryString
		If Request.QueryString("ID").Count > 0 Then
			MenuCategories.ID.QueryStringValue = Request.QueryString("ID")
		End If

		' Set up Breadcrumb
		SetupBreadcrumb()

		' Process form if post back
		If ObjForm.GetValue("a_edit")&"" <> "" Then
			MenuCategories.CurrentAction = ObjForm.GetValue("a_edit") ' Get action code
			Call LoadFormValues() ' Get form values
		Else
			MenuCategories.CurrentAction = "I" ' Default action is display
		End If

		' Check if valid key
		If MenuCategories.ID.CurrentValue = "" Then Call Page_Terminate("MenuCategorieslist.asp") ' Invalid key, return to list

		' Validate form if post back
		If ObjForm.GetValue("a_edit")&"" <> "" Then
			If Not ValidateForm() Then
				MenuCategories.CurrentAction = "" ' Form error, reset action
				FailureMessage = gsFormError
				MenuCategories.EventCancelled = True ' Event cancelled
				Call LoadRow() ' Restore row
				Call RestoreFormValues() ' Restore form values if validate failed
			End If
		End If
		Select Case MenuCategories.CurrentAction
			Case "I" ' Get a record to display
				If Not LoadRow() Then ' Load Record based on key
					If FailureMessage = "" Then FailureMessage = Language.Phrase("NoRecord") ' No record found
					Call Page_Terminate("MenuCategorieslist.asp") ' No matching record, return to list
				End If
			Case "U" ' Update
				MenuCategories.SendEmail = True ' Send email on update success
				If EditRow() Then ' Update Record based on key
					If SuccessMessage = "" Then SuccessMessage = Language.Phrase("UpdateSuccess") ' Update success
					sReturnUrl = MenuCategories.ReturnUrl
					Call Page_Terminate(sReturnUrl) ' Return to caller
				Else
					MenuCategories.EventCancelled = True ' Event cancelled
					Call LoadRow() ' Restore row
					Call RestoreFormValues() ' Restore form values if update failed
				End If
		End Select

		' Render the record
		MenuCategories.RowType = EW_ROWTYPE_EDIT ' Render as edit

		' Render row
		Call MenuCategories.ResetAttrs()
		Call RenderRow()
	End Sub
	Dim Pager

	' -----------------------------------------------------------------
	' Set up Starting Record parameters based on Pager Navigation
	'
	Sub SetUpStartRec()
		Dim PageNo

		' Exit if DisplayRecs = 0
		If DisplayRecs = 0 Then Exit Sub
		If IsPageRequest Then ' Validate request

			' Check for a START parameter
			If Request.QueryString(EW_TABLE_START_REC).Count > 0 Then
				StartRec = Request.QueryString(EW_TABLE_START_REC)
				MenuCategories.StartRecordNumber = StartRec
			ElseIf Request.QueryString(EW_TABLE_PAGE_NO).Count > 0 Then
				PageNo = Request.QueryString(EW_TABLE_PAGE_NO)
				If IsNumeric(PageNo) Then
					StartRec = (PageNo-1)*DisplayRecs+1
					If StartRec <= 0 Then
						StartRec = 1
					ElseIf StartRec >= ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1 Then
						StartRec = ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1
					End If
					MenuCategories.StartRecordNumber = StartRec
				End If
			End If
		End If
		StartRec = MenuCategories.StartRecordNumber

		' Check if correct start record counter
		If Not IsNumeric(StartRec) Or StartRec = "" Then ' Avoid invalid start record counter
			StartRec = 1 ' Reset start record counter
			MenuCategories.StartRecordNumber = StartRec
		ElseIf CLng(StartRec) > CLng(TotalRecs) Then ' Avoid starting record > total records
			StartRec = ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1 ' Point to last page first record
			MenuCategories.StartRecordNumber = StartRec
		ElseIf (StartRec-1) Mod DisplayRecs <> 0 Then
			StartRec = ((StartRec-1)\DisplayRecs)*DisplayRecs+1 ' Point to page boundary
			MenuCategories.StartRecordNumber = StartRec
		End If
	End Sub

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
		If Not MenuCategories.ID.FldIsDetailKey Then MenuCategories.ID.FormValue = ObjForm.GetValue("x_ID")
		If Not MenuCategories.Name.FldIsDetailKey Then MenuCategories.Name.FormValue = ObjForm.GetValue("x_Name")
		If Not MenuCategories.Description.FldIsDetailKey Then MenuCategories.Description.FormValue = ObjForm.GetValue("x_Description")
		If Not MenuCategories.displayorder.FldIsDetailKey Then MenuCategories.displayorder.FormValue = ObjForm.GetValue("x_displayorder")
		If Not MenuCategories.IdBusinessDetail.FldIsDetailKey Then MenuCategories.IdBusinessDetail.FormValue = ObjForm.GetValue("x_IdBusinessDetail")
	End Function

	' -----------------------------------------------------------------
	' Restore form values
	'
	Function RestoreFormValues()
		Call LoadRow()
		MenuCategories.ID.CurrentValue = MenuCategories.ID.FormValue
		MenuCategories.Name.CurrentValue = MenuCategories.Name.FormValue
		MenuCategories.Description.CurrentValue = MenuCategories.Description.FormValue
		MenuCategories.displayorder.CurrentValue = MenuCategories.displayorder.FormValue
		MenuCategories.IdBusinessDetail.CurrentValue = MenuCategories.IdBusinessDetail.FormValue
	End Function

	' -----------------------------------------------------------------
	' Load row based on key values
	'
	Function LoadRow()
		Dim RsRow, sSql, sFilter
		sFilter = MenuCategories.KeyFilter

		' Call Row Selecting event
		Call MenuCategories.Row_Selecting(sFilter)

		' Load sql based on filter
		MenuCategories.CurrentFilter = sFilter
		sSql = MenuCategories.SQL
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
		Call MenuCategories.Row_Selected(RsRow)
		MenuCategories.ID.DbValue = RsRow("ID")
		MenuCategories.Name.DbValue = RsRow("Name")
		MenuCategories.Description.DbValue = RsRow("Description")
		MenuCategories.displayorder.DbValue = RsRow("displayorder")
		MenuCategories.IdBusinessDetail.DbValue = RsRow("IdBusinessDetail")
	End Sub

	' Load DbValue from recordset
	Sub LoadDbValues(Rs)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		If Rs.Eof Then Exit Sub
		MenuCategories.ID.m_DbValue = Rs("ID")
		MenuCategories.Name.m_DbValue = Rs("Name")
		MenuCategories.Description.m_DbValue = Rs("Description")
		MenuCategories.displayorder.m_DbValue = Rs("displayorder")
		MenuCategories.IdBusinessDetail.m_DbValue = Rs("IdBusinessDetail")
	End Sub

	' -----------------------------------------------------------------
	' Render row values based on field settings
	'
	Sub RenderRow()

		' Initialize urls
		' Call Row Rendering event

		Call MenuCategories.Row_Rendering()

		' ---------------------------------------
		'  Common render codes for all row types
		' ---------------------------------------
		' ID
		' Name
		' Description
		' displayorder
		' IdBusinessDetail
		' -----------
		'  View  Row
		' -----------

		If MenuCategories.RowType = EW_ROWTYPE_VIEW Then ' View row

			' ID
			MenuCategories.ID.ViewValue = MenuCategories.ID.CurrentValue
			MenuCategories.ID.ViewCustomAttributes = ""

			' Name
			MenuCategories.Name.ViewValue = MenuCategories.Name.CurrentValue
			MenuCategories.Name.ViewCustomAttributes = ""

			' Description
			MenuCategories.Description.ViewValue = MenuCategories.Description.CurrentValue
			MenuCategories.Description.ViewCustomAttributes = ""

			' displayorder
			MenuCategories.displayorder.ViewValue = MenuCategories.displayorder.CurrentValue
			MenuCategories.displayorder.ViewCustomAttributes = ""

			' IdBusinessDetail
			MenuCategories.IdBusinessDetail.ViewValue = MenuCategories.IdBusinessDetail.CurrentValue
			MenuCategories.IdBusinessDetail.ViewCustomAttributes = ""

			' View refer script
			' ID

			MenuCategories.ID.LinkCustomAttributes = ""
			MenuCategories.ID.HrefValue = ""
			MenuCategories.ID.TooltipValue = ""

			' Name
			MenuCategories.Name.LinkCustomAttributes = ""
			MenuCategories.Name.HrefValue = ""
			MenuCategories.Name.TooltipValue = ""

			' Description
			MenuCategories.Description.LinkCustomAttributes = ""
			MenuCategories.Description.HrefValue = ""
			MenuCategories.Description.TooltipValue = ""

			' displayorder
			MenuCategories.displayorder.LinkCustomAttributes = ""
			MenuCategories.displayorder.HrefValue = ""
			MenuCategories.displayorder.TooltipValue = ""

			' IdBusinessDetail
			MenuCategories.IdBusinessDetail.LinkCustomAttributes = ""
			MenuCategories.IdBusinessDetail.HrefValue = ""
			MenuCategories.IdBusinessDetail.TooltipValue = ""

		' ----------
		'  Edit Row
		' ----------

		ElseIf MenuCategories.RowType = EW_ROWTYPE_EDIT Then ' Edit row

			' ID
			MenuCategories.ID.EditAttrs.UpdateAttribute "class", "form-control"
			MenuCategories.ID.EditCustomAttributes = ""
			MenuCategories.ID.EditValue = MenuCategories.ID.CurrentValue
			MenuCategories.ID.ViewCustomAttributes = ""

			' Name
			MenuCategories.Name.EditAttrs.UpdateAttribute "class", "form-control"
			MenuCategories.Name.EditCustomAttributes = ""
			MenuCategories.Name.EditValue = ew_HtmlEncode(MenuCategories.Name.CurrentValue)
			MenuCategories.Name.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuCategories.Name.FldCaption))

			' Description
			MenuCategories.Description.EditAttrs.UpdateAttribute "class", "form-control"
			MenuCategories.Description.EditCustomAttributes = ""
			MenuCategories.Description.EditValue = ew_HtmlEncode(MenuCategories.Description.CurrentValue)
			MenuCategories.Description.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuCategories.Description.FldCaption))

			' displayorder
			MenuCategories.displayorder.EditAttrs.UpdateAttribute "class", "form-control"
			MenuCategories.displayorder.EditCustomAttributes = ""
			MenuCategories.displayorder.EditValue = ew_HtmlEncode(MenuCategories.displayorder.CurrentValue)
			MenuCategories.displayorder.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuCategories.displayorder.FldCaption))

			' IdBusinessDetail
			MenuCategories.IdBusinessDetail.EditAttrs.UpdateAttribute "class", "form-control"
			MenuCategories.IdBusinessDetail.EditCustomAttributes = ""
			MenuCategories.IdBusinessDetail.EditValue = ew_HtmlEncode(MenuCategories.IdBusinessDetail.CurrentValue)
			MenuCategories.IdBusinessDetail.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuCategories.IdBusinessDetail.FldCaption))

			' Edit refer script
			' ID

			MenuCategories.ID.HrefValue = ""

			' Name
			MenuCategories.Name.HrefValue = ""

			' Description
			MenuCategories.Description.HrefValue = ""

			' displayorder
			MenuCategories.displayorder.HrefValue = ""

			' IdBusinessDetail
			MenuCategories.IdBusinessDetail.HrefValue = ""
		End If
		If MenuCategories.RowType = EW_ROWTYPE_ADD Or MenuCategories.RowType = EW_ROWTYPE_EDIT Or MenuCategories.RowType = EW_ROWTYPE_SEARCH Then ' Add / Edit / Search row
			Call MenuCategories.SetupFieldTitles()
		End If

		' Call Row Rendered event
		If MenuCategories.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call MenuCategories.Row_Rendered()
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
		If Not ew_CheckInteger(MenuCategories.displayorder.FormValue) Then
			Call ew_AddMessage(gsFormError, MenuCategories.displayorder.FldErrMsg)
		End If
		If Not ew_CheckInteger(MenuCategories.IdBusinessDetail.FormValue) Then
			Call ew_AddMessage(gsFormError, MenuCategories.IdBusinessDetail.FldErrMsg)
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
		sFilter = MenuCategories.KeyFilter
		MenuCategories.CurrentFilter  = sFilter
		sSql = MenuCategories.SQL
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
			Call MenuCategories.Name.SetDbValue(Rs, MenuCategories.Name.CurrentValue, Null, MenuCategories.Name.ReadOnly)

			' Field Description
			Call MenuCategories.Description.SetDbValue(Rs, MenuCategories.Description.CurrentValue, Null, MenuCategories.Description.ReadOnly)

			' Field displayorder
			Call MenuCategories.displayorder.SetDbValue(Rs, MenuCategories.displayorder.CurrentValue, Null, MenuCategories.displayorder.ReadOnly)

			' Field IdBusinessDetail
			Call MenuCategories.IdBusinessDetail.SetDbValue(Rs, MenuCategories.IdBusinessDetail.CurrentValue, Null, MenuCategories.IdBusinessDetail.ReadOnly)

			' Check recordset update error
			If Err.Number <> 0 Then
				FailureMessage = Err.Description
				Rs.Close
				Set Rs = Nothing
				EditRow = False
				Exit Function
			End If

			' Call Row Updating event
			bUpdateRow = MenuCategories.Row_Updating(RsOld, Rs)
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
				ElseIf MenuCategories.CancelMessage <> "" Then
					FailureMessage = MenuCategories.CancelMessage
					MenuCategories.CancelMessage = ""
				Else
					FailureMessage = Language.Phrase("UpdateCancelled")
				End If
				EditRow = False
			End If
		End If

		' Call Row Updated event
		If EditRow Then
			Call MenuCategories.Row_Updated(RsOld, RsNew)
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
		Call Breadcrumb.Add("list", MenuCategories.TableVar, "MenuCategorieslist.asp", "", MenuCategories.TableVar, True)
		PageId = "edit"
		Call Breadcrumb.Add("edit", PageId, url, "", "", False)
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
