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
Dim timezones_update
Set timezones_update = New ctimezones_update
Set Page = timezones_update

' Page init processing
timezones_update.Page_Init()

' Page main processing
timezones_update.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
timezones_update.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var timezones_update = new ew_Page("timezones_update");
timezones_update.PageID = "update"; // Page ID
var EW_PAGE_ID = timezones_update.PageID; // For backward compatibility
// Form object
var ftimezonesupdate = new ew_Form("ftimezonesupdate");
// Validate form
ftimezonesupdate.Validate = function() {
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
			// Set up row object
			ew_ElementsToRow(fobj);
			// Fire Form_CustomValidate event
			if (!this.Form_CustomValidate(fobj))
				return false;
	}
	return true;
}
// Form_CustomValidate event
ftimezonesupdate.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
ftimezonesupdate.ValidateRequired = true; // Use JavaScript validation
<% Else %>
ftimezonesupdate.ValidateRequired = false; // No JavaScript validation
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
<% timezones_update.ShowPageHeader() %>
<% timezones_update.ShowMessage %>
<form name="ftimezonesupdate" id="ftimezonesupdate" class="form-horizontal ewForm ewUpdateForm" action="<%= ew_CurrentPage %>" method="post">
<% If timezones_update.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= timezones_update.Token %>">
<% End If %>
<input type="hidden" name="t" value="timezones">
<input type="hidden" name="a_update" id="a_update" value="U">
<% For i = 0 to UBound(timezones_update.RecKeys) %>
<input type="hidden" name="key_m" id="key_m" value="<%= ew_HtmlEncode(ew_GetKeyValue(timezones_update.RecKeys(i))) %>">
<% Next %>
<div id="tbl_timezonesupdate">
	<div class="form-group">
		<label class="col-sm-2"><input type="checkbox" name="u" id="u" onclick="ew_SelectAll(this);"> <%= Language.Phrase("UpdateSelectAll") %></label>
	</div>
<% If timezones.Timezone.Visible Then ' Timezone %>
	<div id="r_Timezone" class="form-group">
		<label for="x_Timezone" class="col-sm-2 control-label">
<input type="checkbox" name="u_Timezone" id="u_Timezone" value="1"<% If timezones.Timezone.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= timezones.Timezone.FldCaption %></label>
		<div class="col-sm-10"><div<%= timezones.Timezone.CellAttributes %>>
<span id="el_timezones_Timezone">
<input type="text" data-field="x_Timezone" name="x_Timezone" id="x_Timezone" size="30" maxlength="255" placeholder="<%= timezones.Timezone.PlaceHolder %>" value="<%= timezones.Timezone.EditValue %>"<%= timezones.Timezone.EditAttributes %>>
</span>
<%= timezones.Timezone.CustomMsg %></div></div>
	</div>
<% End If %>
<% If timezones.offset.Visible Then ' offset %>
	<div id="r_offset" class="form-group">
		<label for="x_offset" class="col-sm-2 control-label">
<input type="checkbox" name="u_offset" id="u_offset" value="1"<% If timezones.offset.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= timezones.offset.FldCaption %></label>
		<div class="col-sm-10"><div<%= timezones.offset.CellAttributes %>>
<span id="el_timezones_offset">
<input type="text" data-field="x_offset" name="x_offset" id="x_offset" size="30" maxlength="255" placeholder="<%= timezones.offset.PlaceHolder %>" value="<%= timezones.offset.EditValue %>"<%= timezones.offset.EditAttributes %>>
</span>
<%= timezones.offset.CustomMsg %></div></div>
	</div>
<% End If %>
<% If timezones.offsetdst.Visible Then ' offsetdst %>
	<div id="r_offsetdst" class="form-group">
		<label for="x_offsetdst" class="col-sm-2 control-label">
<input type="checkbox" name="u_offsetdst" id="u_offsetdst" value="1"<% If timezones.offsetdst.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= timezones.offsetdst.FldCaption %></label>
		<div class="col-sm-10"><div<%= timezones.offsetdst.CellAttributes %>>
<span id="el_timezones_offsetdst">
<input type="text" data-field="x_offsetdst" name="x_offsetdst" id="x_offsetdst" size="30" maxlength="255" placeholder="<%= timezones.offsetdst.PlaceHolder %>" value="<%= timezones.offsetdst.EditValue %>"<%= timezones.offsetdst.EditAttributes %>>
</span>
<%= timezones.offsetdst.CustomMsg %></div></div>
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
ftimezonesupdate.Init();
</script>
<%
timezones_update.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set timezones_update = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class ctimezones_update

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
		TableName = "timezones"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "timezones_update"
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
		EW_PAGE_ID = "update"

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
		RecKeys = timezones.GetRecordKeys() ' Load record keys
		If ObjForm.GetValue("a_update")&"" <> "" Then

			' Get action
			timezones.CurrentAction = ObjForm.GetValue("a_update")
			Call LoadFormValues() ' Get form values

			' Validate form
			If Not ValidateForm() Then
				timezones.CurrentAction = "I" ' Form error, reset action
				FailureMessage = gsFormError
			End If
		Else
			Call LoadMultiUpdateValues() ' Load initial values to form
		End If
		If Not IsArray(RecKeys) Then
			Call Page_Terminate("timezoneslist.asp") ' No records selected, return to list
		End If
		Select Case timezones.CurrentAction
			Case "U" ' Update
				If UpdateRows() Then ' Update Records based on key
					If SuccessMessage = "" Then SuccessMessage = Language.Phrase("UpdateSuccess") ' Set update success message
					Call Page_Terminate(timezones.ReturnUrl) ' Return to caller
				Else
					Call RestoreFormValues() ' Restore form values
				End If
		End Select

		' Render row
		timezones.RowType = EW_ROWTYPE_EDIT ' Render edit

		' Render row
		Call timezones.ResetAttrs()
		Call RenderRow()
	End Sub

	' -----------------------------------------------------------------
	' Load initial values to form if field values are identical in all selected records
	'
	Sub LoadMultiUpdateValues()
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		Dim Rs, i, OldValue, NewValue
		timezones.CurrentFilter = timezones.GetKeyFilter()

		' Load recordset
		Set Rs = LoadRecordset()
		i = 1
		Do While Not Rs.Eof
			If i = 1 Then
				timezones.Timezone.DbValue = ew_Conv(Rs("Timezone"), Rs("Timezone").Type)
				timezones.offset.DbValue = ew_Conv(Rs("offset"), Rs("offset").Type)
				timezones.offsetdst.DbValue = ew_Conv(Rs("offsetdst"), Rs("offsetdst").Type)
			Else
				OldValue = timezones.Timezone.DbValue
				NewValue = ew_Conv(Rs("Timezone"), Rs("Timezone").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					timezones.Timezone.CurrentValue = Null
				End If
				OldValue = timezones.offset.DbValue
				NewValue = ew_Conv(Rs("offset"), Rs("offset").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					timezones.offset.CurrentValue = Null
				End If
				OldValue = timezones.offsetdst.DbValue
				NewValue = ew_Conv(Rs("offsetdst"), Rs("offsetdst").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					timezones.offsetdst.CurrentValue = Null
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
		timezones.ID.CurrentValue = sKeyFld ' Set up key value
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
		timezones.CurrentFilter = timezones.GetKeyFilter()
		sSql = timezones.SQL
		Set Rs = Server.CreateObject("ADODB.Recordset")
		Rs.CursorLocation = EW_CURSORLOCATION
		Rs.Open sSql, Conn, 1, EW_RECORDSET_LOCKTYPE
		Set RsOld = ew_CloneRs(Rs)

		' Update all rows
		sKey = ""
		For i = 0 to UBound(RecKeys)
			If SetupKeyValues(RecKeys(i)) Then
				sThisKey = RecKeys(i)
				timezones.SendEmail = False ' Do not send email on update success
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
		If Not timezones.Timezone.FldIsDetailKey Then timezones.Timezone.FormValue = ObjForm.GetValue("x_Timezone")
		timezones.Timezone.MultiUpdate = ObjForm.GetValue("u_Timezone")
		If Not timezones.offset.FldIsDetailKey Then timezones.offset.FormValue = ObjForm.GetValue("x_offset")
		timezones.offset.MultiUpdate = ObjForm.GetValue("u_offset")
		If Not timezones.offsetdst.FldIsDetailKey Then timezones.offsetdst.FormValue = ObjForm.GetValue("x_offsetdst")
		timezones.offsetdst.MultiUpdate = ObjForm.GetValue("u_offsetdst")
		If Not timezones.ID.FldIsDetailKey Then timezones.ID.FormValue = ObjForm.GetValue("x_ID")
	End Function

	' -----------------------------------------------------------------
	' Restore form values
	'
	Function RestoreFormValues()
		timezones.Timezone.CurrentValue = timezones.Timezone.FormValue
		timezones.offset.CurrentValue = timezones.offset.FormValue
		timezones.offsetdst.CurrentValue = timezones.offsetdst.FormValue
		timezones.ID.CurrentValue = timezones.ID.FormValue
	End Function

	' -----------------------------------------------------------------
	' Load recordset
	'
	Function LoadRecordset()

		' Load list page sql
		Dim sSql
		sSql = timezones.SelectSQL
		Call ew_SetDebugMsg("LoadRecordset: " & sSql) ' Show SQL for debugging

		' Load recordset
		Dim RsRecordset
		Set RsRecordset = ew_LoadRecordset(sSql)

		' Call Recordset Selected event
		Call timezones.Recordset_Selected(RsRecordset)
		Set LoadRecordset = RsRecordset
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
		Dim lUpdateCnt
		lUpdateCnt = 0
		If timezones.Timezone.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If timezones.offset.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If timezones.offsetdst.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
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
			Call timezones.Timezone.SetDbValue(Rs, timezones.Timezone.CurrentValue, Null, timezones.Timezone.ReadOnly Or timezones.Timezone.MultiUpdate&"" <> "1")

			' Field offset
			Call timezones.offset.SetDbValue(Rs, timezones.offset.CurrentValue, Null, timezones.offset.ReadOnly Or timezones.offset.MultiUpdate&"" <> "1")

			' Field offsetdst
			Call timezones.offsetdst.SetDbValue(Rs, timezones.offsetdst.CurrentValue, Null, timezones.offsetdst.ReadOnly Or timezones.offsetdst.MultiUpdate&"" <> "1")

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
