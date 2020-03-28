<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="timezonesinfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim timezones_edit
Set timezones_edit = New ctimezones_edit
Set Page = timezones_edit

' Page init processing
timezones_edit.Page_Init()

' Page main processing
timezones_edit.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
timezones_edit.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var timezones_edit = new ew_Page("timezones_edit");
timezones_edit.PageID = "edit"; // Page ID
var EW_PAGE_ID = timezones_edit.PageID; // For backward compatibility
// Form object
var ftimezonesedit = new ew_Form("ftimezonesedit");
// Validate form
ftimezonesedit.Validate = function() {
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
ftimezonesedit.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
ftimezonesedit.ValidateRequired = true; // Use JavaScript validation
<% Else %>
ftimezonesedit.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<div class="ewToolbar">
<% If timezones.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If timezones.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% timezones_edit.ShowPageHeader() %>
<% timezones_edit.ShowMessage %>
<form name="ftimezonesedit" id="ftimezonesedit" class="form-horizontal ewForm ewEditForm" action="<%= ew_CurrentPage %>" method="post">
<% If timezones_edit.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= timezones_edit.Token %>">
<% End If %>
<input type="hidden" name="a_table" id="a_table" value="timezones">
<input type="hidden" name="a_edit" id="a_edit" value="U">
<div>
<% If timezones.ID.Visible Then ' ID %>
	<div id="r_ID" class="form-group">
		<label id="elh_timezones_ID" class="col-sm-2 control-label ewLabel"><%= timezones.ID.FldCaption %></label>
		<div class="col-sm-10"><div<%= timezones.ID.CellAttributes %>>
<span id="el_timezones_ID">
<span<%= timezones.ID.ViewAttributes %>>
<p class="form-control-static"><%= timezones.ID.EditValue %></p>
</span>
</span>
<input type="hidden" data-field="x_ID" name="x_ID" id="x_ID" value="<%= Server.HTMLEncode(timezones.ID.CurrentValue&"") %>">
<%= timezones.ID.CustomMsg %></div></div>
	</div>
<% End If %>
<% If timezones.Timezone.Visible Then ' Timezone %>
	<div id="r_Timezone" class="form-group">
		<label id="elh_timezones_Timezone" for="x_Timezone" class="col-sm-2 control-label ewLabel"><%= timezones.Timezone.FldCaption %></label>
		<div class="col-sm-10"><div<%= timezones.Timezone.CellAttributes %>>
<span id="el_timezones_Timezone">
<input type="text" data-field="x_Timezone" name="x_Timezone" id="x_Timezone" size="30" maxlength="255" placeholder="<%= timezones.Timezone.PlaceHolder %>" value="<%= timezones.Timezone.EditValue %>"<%= timezones.Timezone.EditAttributes %>>
</span>
<%= timezones.Timezone.CustomMsg %></div></div>
	</div>
<% End If %>
<% If timezones.offset.Visible Then ' offset %>
	<div id="r_offset" class="form-group">
		<label id="elh_timezones_offset" for="x_offset" class="col-sm-2 control-label ewLabel"><%= timezones.offset.FldCaption %></label>
		<div class="col-sm-10"><div<%= timezones.offset.CellAttributes %>>
<span id="el_timezones_offset">
<input type="text" data-field="x_offset" name="x_offset" id="x_offset" size="30" maxlength="255" placeholder="<%= timezones.offset.PlaceHolder %>" value="<%= timezones.offset.EditValue %>"<%= timezones.offset.EditAttributes %>>
</span>
<%= timezones.offset.CustomMsg %></div></div>
	</div>
<% End If %>
<% If timezones.offsetdst.Visible Then ' offsetdst %>
	<div id="r_offsetdst" class="form-group">
		<label id="elh_timezones_offsetdst" for="x_offsetdst" class="col-sm-2 control-label ewLabel"><%= timezones.offsetdst.FldCaption %></label>
		<div class="col-sm-10"><div<%= timezones.offsetdst.CellAttributes %>>
<span id="el_timezones_offsetdst">
<input type="text" data-field="x_offsetdst" name="x_offsetdst" id="x_offsetdst" size="30" maxlength="255" placeholder="<%= timezones.offsetdst.PlaceHolder %>" value="<%= timezones.offsetdst.EditValue %>"<%= timezones.offsetdst.EditAttributes %>>
</span>
<%= timezones.offsetdst.CustomMsg %></div></div>
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
ftimezonesedit.Init();
</script>
<%
timezones_edit.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set timezones_edit = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class ctimezones_edit

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
		TableName = "timezones"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "timezones_edit"
	End Property

	' Page Name
	Public Property Get PageName()
		PageName = ew_CurrentPage()
	End Property

	' Page Url
	Public Property Get PageUrl()
		PageUrl = ew_CurrentPage() & "?"
		If timezones.UseTokenInUrl Then PageUrl = PageUrl & "t=" & timezones.TableVar & "&" ' add page token
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
		If timezones.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (timezones.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (timezones.TableVar = Request.QueryString("t"))
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
		If IsEmpty(timezones) Then Set timezones = New ctimezones
		Set Table = timezones

		' Initialize urls
		' Initialize form object

		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "edit"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "timezones"

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

		timezones.CurrentAction = ew_IIf(Request.QueryString("a").Count > 0, Request.QueryString("a") & "", ObjForm.GetValue("a_list") & "") ' Set up current action
		timezones.ID.Visible = Not timezones.IsAdd() And Not timezones.IsCopy() And Not timezones.IsGridAdd()

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
			results = timezones.GetAutoFill(Request.Form("name"), Request.Form("q"))
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
		If Not timezones Is Nothing Then
			If timezones.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = timezones.TableVar
				If timezones.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf timezones.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf timezones.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf timezones.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set timezones = Nothing
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
			timezones.ID.QueryStringValue = Request.QueryString("ID")
		End If

		' Set up Breadcrumb
		SetupBreadcrumb()

		' Process form if post back
		If ObjForm.GetValue("a_edit")&"" <> "" Then
			timezones.CurrentAction = ObjForm.GetValue("a_edit") ' Get action code
			Call LoadFormValues() ' Get form values
		Else
			timezones.CurrentAction = "I" ' Default action is display
		End If

		' Check if valid key
		If timezones.ID.CurrentValue = "" Then Call Page_Terminate("timezoneslist.asp") ' Invalid key, return to list

		' Validate form if post back
		If ObjForm.GetValue("a_edit")&"" <> "" Then
			If Not ValidateForm() Then
				timezones.CurrentAction = "" ' Form error, reset action
				FailureMessage = gsFormError
				timezones.EventCancelled = True ' Event cancelled
				Call LoadRow() ' Restore row
				Call RestoreFormValues() ' Restore form values if validate failed
			End If
		End If
		Select Case timezones.CurrentAction
			Case "I" ' Get a record to display
				If Not LoadRow() Then ' Load Record based on key
					If FailureMessage = "" Then FailureMessage = Language.Phrase("NoRecord") ' No record found
					Call Page_Terminate("timezoneslist.asp") ' No matching record, return to list
				End If
			Case "U" ' Update
				timezones.SendEmail = True ' Send email on update success
				If EditRow() Then ' Update Record based on key
					If SuccessMessage = "" Then SuccessMessage = Language.Phrase("UpdateSuccess") ' Update success
					sReturnUrl = timezones.ReturnUrl
					Call Page_Terminate(sReturnUrl) ' Return to caller
				Else
					timezones.EventCancelled = True ' Event cancelled
					Call LoadRow() ' Restore row
					Call RestoreFormValues() ' Restore form values if update failed
				End If
		End Select

		' Render the record
		timezones.RowType = EW_ROWTYPE_EDIT ' Render as edit

		' Render row
		Call timezones.ResetAttrs()
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
				timezones.StartRecordNumber = StartRec
			ElseIf Request.QueryString(EW_TABLE_PAGE_NO).Count > 0 Then
				PageNo = Request.QueryString(EW_TABLE_PAGE_NO)
				If IsNumeric(PageNo) Then
					StartRec = (PageNo-1)*DisplayRecs+1
					If StartRec <= 0 Then
						StartRec = 1
					ElseIf StartRec >= ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1 Then
						StartRec = ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1
					End If
					timezones.StartRecordNumber = StartRec
				End If
			End If
		End If
		StartRec = timezones.StartRecordNumber

		' Check if correct start record counter
		If Not IsNumeric(StartRec) Or StartRec = "" Then ' Avoid invalid start record counter
			StartRec = 1 ' Reset start record counter
			timezones.StartRecordNumber = StartRec
		ElseIf CLng(StartRec) > CLng(TotalRecs) Then ' Avoid starting record > total records
			StartRec = ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1 ' Point to last page first record
			timezones.StartRecordNumber = StartRec
		ElseIf (StartRec-1) Mod DisplayRecs <> 0 Then
			StartRec = ((StartRec-1)\DisplayRecs)*DisplayRecs+1 ' Point to page boundary
			timezones.StartRecordNumber = StartRec
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
		If Not timezones.ID.FldIsDetailKey Then timezones.ID.FormValue = ObjForm.GetValue("x_ID")
		If Not timezones.Timezone.FldIsDetailKey Then timezones.Timezone.FormValue = ObjForm.GetValue("x_Timezone")
		If Not timezones.offset.FldIsDetailKey Then timezones.offset.FormValue = ObjForm.GetValue("x_offset")
		If Not timezones.offsetdst.FldIsDetailKey Then timezones.offsetdst.FormValue = ObjForm.GetValue("x_offsetdst")
	End Function

	' -----------------------------------------------------------------
	' Restore form values
	'
	Function RestoreFormValues()
		Call LoadRow()
		timezones.ID.CurrentValue = timezones.ID.FormValue
		timezones.Timezone.CurrentValue = timezones.Timezone.FormValue
		timezones.offset.CurrentValue = timezones.offset.FormValue
		timezones.offsetdst.CurrentValue = timezones.offsetdst.FormValue
	End Function

	' -----------------------------------------------------------------
	' Load row based on key values
	'
	Function LoadRow()
		Dim RsRow, sSql, sFilter
		sFilter = timezones.KeyFilter

		' Call Row Selecting event
		Call timezones.Row_Selecting(sFilter)

		' Load sql based on filter
		timezones.CurrentFilter = sFilter
		sSql = timezones.SQL
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
		Call timezones.Row_Selected(RsRow)
		timezones.ID.DbValue = RsRow("ID")
		timezones.Timezone.DbValue = RsRow("Timezone")
		timezones.offset.DbValue = RsRow("offset")
		timezones.offsetdst.DbValue = RsRow("offsetdst")
	End Sub

	' Load DbValue from recordset
	Sub LoadDbValues(Rs)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		If Rs.Eof Then Exit Sub
		timezones.ID.m_DbValue = Rs("ID")
		timezones.Timezone.m_DbValue = Rs("Timezone")
		timezones.offset.m_DbValue = Rs("offset")
		timezones.offsetdst.m_DbValue = Rs("offsetdst")
	End Sub

	' -----------------------------------------------------------------
	' Render row values based on field settings
	'
	Sub RenderRow()

		' Initialize urls
		' Call Row Rendering event

		Call timezones.Row_Rendering()

		' ---------------------------------------
		'  Common render codes for all row types
		' ---------------------------------------
		' ID
		' Timezone
		' offset
		' offsetdst
		' -----------
		'  View  Row
		' -----------

		If timezones.RowType = EW_ROWTYPE_VIEW Then ' View row

			' ID
			timezones.ID.ViewValue = timezones.ID.CurrentValue
			timezones.ID.ViewCustomAttributes = ""

			' Timezone
			timezones.Timezone.ViewValue = timezones.Timezone.CurrentValue
			timezones.Timezone.ViewCustomAttributes = ""

			' offset
			timezones.offset.ViewValue = timezones.offset.CurrentValue
			timezones.offset.ViewCustomAttributes = ""

			' offsetdst
			timezones.offsetdst.ViewValue = timezones.offsetdst.CurrentValue
			timezones.offsetdst.ViewCustomAttributes = ""

			' View refer script
			' ID

			timezones.ID.LinkCustomAttributes = ""
			timezones.ID.HrefValue = ""
			timezones.ID.TooltipValue = ""

			' Timezone
			timezones.Timezone.LinkCustomAttributes = ""
			timezones.Timezone.HrefValue = ""
			timezones.Timezone.TooltipValue = ""

			' offset
			timezones.offset.LinkCustomAttributes = ""
			timezones.offset.HrefValue = ""
			timezones.offset.TooltipValue = ""

			' offsetdst
			timezones.offsetdst.LinkCustomAttributes = ""
			timezones.offsetdst.HrefValue = ""
			timezones.offsetdst.TooltipValue = ""

		' ----------
		'  Edit Row
		' ----------

		ElseIf timezones.RowType = EW_ROWTYPE_EDIT Then ' Edit row

			' ID
			timezones.ID.EditAttrs.UpdateAttribute "class", "form-control"
			timezones.ID.EditCustomAttributes = ""
			timezones.ID.EditValue = timezones.ID.CurrentValue
			timezones.ID.ViewCustomAttributes = ""

			' Timezone
			timezones.Timezone.EditAttrs.UpdateAttribute "class", "form-control"
			timezones.Timezone.EditCustomAttributes = ""
			timezones.Timezone.EditValue = ew_HtmlEncode(timezones.Timezone.CurrentValue)
			timezones.Timezone.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(timezones.Timezone.FldCaption))

			' offset
			timezones.offset.EditAttrs.UpdateAttribute "class", "form-control"
			timezones.offset.EditCustomAttributes = ""
			timezones.offset.EditValue = ew_HtmlEncode(timezones.offset.CurrentValue)
			timezones.offset.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(timezones.offset.FldCaption))

			' offsetdst
			timezones.offsetdst.EditAttrs.UpdateAttribute "class", "form-control"
			timezones.offsetdst.EditCustomAttributes = ""
			timezones.offsetdst.EditValue = ew_HtmlEncode(timezones.offsetdst.CurrentValue)
			timezones.offsetdst.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(timezones.offsetdst.FldCaption))

			' Edit refer script
			' ID

			timezones.ID.HrefValue = ""

			' Timezone
			timezones.Timezone.HrefValue = ""

			' offset
			timezones.offset.HrefValue = ""

			' offsetdst
			timezones.offsetdst.HrefValue = ""
		End If
		If timezones.RowType = EW_ROWTYPE_ADD Or timezones.RowType = EW_ROWTYPE_EDIT Or timezones.RowType = EW_ROWTYPE_SEARCH Then ' Add / Edit / Search row
			Call timezones.SetupFieldTitles()
		End If

		' Call Row Rendered event
		If timezones.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call timezones.Row_Rendered()
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
		sFilter = timezones.KeyFilter
		timezones.CurrentFilter  = sFilter
		sSql = timezones.SQL
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

			' Field Timezone
			Call timezones.Timezone.SetDbValue(Rs, timezones.Timezone.CurrentValue, Null, timezones.Timezone.ReadOnly)

			' Field offset
			Call timezones.offset.SetDbValue(Rs, timezones.offset.CurrentValue, Null, timezones.offset.ReadOnly)

			' Field offsetdst
			Call timezones.offsetdst.SetDbValue(Rs, timezones.offsetdst.CurrentValue, Null, timezones.offsetdst.ReadOnly)

			' Check recordset update error
			If Err.Number <> 0 Then
				FailureMessage = Err.Description
				Rs.Close
				Set Rs = Nothing
				EditRow = False
				Exit Function
			End If

			' Call Row Updating event
			bUpdateRow = timezones.Row_Updating(RsOld, Rs)
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
				ElseIf timezones.CancelMessage <> "" Then
					FailureMessage = timezones.CancelMessage
					timezones.CancelMessage = ""
				Else
					FailureMessage = Language.Phrase("UpdateCancelled")
				End If
				EditRow = False
			End If
		End If

		' Call Row Updated event
		If EditRow Then
			Call timezones.Row_Updated(RsOld, RsNew)
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
		Call Breadcrumb.Add("list", timezones.TableVar, "timezoneslist.asp", "", timezones.TableVar, True)
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
