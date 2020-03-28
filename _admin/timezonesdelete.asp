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
Dim timezones_delete
Set timezones_delete = New ctimezones_delete
Set Page = timezones_delete

' Page init processing
timezones_delete.Page_Init()

' Page main processing
timezones_delete.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
timezones_delete.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var timezones_delete = new ew_Page("timezones_delete");
timezones_delete.PageID = "delete"; // Page ID
var EW_PAGE_ID = timezones_delete.PageID; // For backward compatibility
// Form object
var ftimezonesdelete = new ew_Form("ftimezonesdelete");
// Form_CustomValidate event
ftimezonesdelete.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
ftimezonesdelete.ValidateRequired = true; // Use JavaScript validation
<% Else %>
ftimezonesdelete.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<%

' Load records for display
Set timezones_delete.Recordset = timezones_delete.LoadRecordset()
timezones_delete.TotalRecs = timezones_delete.Recordset.RecordCount ' Get record count
If timezones_delete.TotalRecs <= 0 Then ' No record found, exit
	timezones_delete.Recordset.Close
	Set timezones_delete.Recordset = Nothing
	Call timezones_delete.Page_Terminate("timezoneslist.asp") ' Return to list
End If
%>
<div class="ewToolbar">
<% If timezones.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If timezones.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% timezones_delete.ShowPageHeader() %>
<% timezones_delete.ShowMessage %>
<form name="ftimezonesdelete" id="ftimezonesdelete" class="form-inline ewForm ewDeleteForm" action="<%= ew_CurrentPage() %>" method="post">
<% If timezones_delete.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= timezones_delete.Token %>">
<% End If %>
<input type="hidden" name="t" value="timezones">
<input type="hidden" name="a_delete" id="a_delete" value="D">
<% For i = 0 to UBound(timezones_delete.RecKeys) %>
<input type="hidden" name="key_m" id="key_m" value="<%= ew_HtmlEncode(ew_GetKeyValue(timezones_delete.RecKeys(i))) %>">
<% Next %>
<div class="ewGrid">
<div class="<% If ew_IsResponsiveLayout() Then Response.Write "table-responsive " %>ewGridMiddlePanel">
<table class="table ewTable">
<%= timezones.TableCustomInnerHtml %>
	<thead>
	<tr class="ewTableHeader">
<% If timezones.ID.Visible Then ' ID %>
		<th><span id="elh_timezones_ID" class="timezones_ID"><%= timezones.ID.FldCaption %></span></th>
<% End If %>
<% If timezones.Timezone.Visible Then ' Timezone %>
		<th><span id="elh_timezones_Timezone" class="timezones_Timezone"><%= timezones.Timezone.FldCaption %></span></th>
<% End If %>
<% If timezones.offset.Visible Then ' offset %>
		<th><span id="elh_timezones_offset" class="timezones_offset"><%= timezones.offset.FldCaption %></span></th>
<% End If %>
<% If timezones.offsetdst.Visible Then ' offsetdst %>
		<th><span id="elh_timezones_offsetdst" class="timezones_offsetdst"><%= timezones.offsetdst.FldCaption %></span></th>
<% End If %>
	</tr>
	</thead>
	<tbody>
<%
timezones_delete.RecCnt = 0
timezones_delete.RowCnt = 0
Do While (Not timezones_delete.Recordset.Eof)
	timezones_delete.RecCnt = timezones_delete.RecCnt + 1
	timezones_delete.RowCnt = timezones_delete.RowCnt + 1

	' Set row properties
	Call timezones.ResetAttrs()
	timezones.RowType = EW_ROWTYPE_VIEW ' view

	' Get the field contents
	Call timezones_delete.LoadRowValues(timezones_delete.Recordset)

	' Render row
	Call timezones_delete.RenderRow()
%>
	<tr<%= timezones.RowAttributes %>>
<% If timezones.ID.Visible Then ' ID %>
		<td<%= timezones.ID.CellAttributes %>>
<span id="el<%= timezones_delete.RowCnt %>_timezones_ID" class="form-group timezones_ID">
<span<%= timezones.ID.ViewAttributes %>>
<%= timezones.ID.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If timezones.Timezone.Visible Then ' Timezone %>
		<td<%= timezones.Timezone.CellAttributes %>>
<span id="el<%= timezones_delete.RowCnt %>_timezones_Timezone" class="form-group timezones_Timezone">
<span<%= timezones.Timezone.ViewAttributes %>>
<%= timezones.Timezone.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If timezones.offset.Visible Then ' offset %>
		<td<%= timezones.offset.CellAttributes %>>
<span id="el<%= timezones_delete.RowCnt %>_timezones_offset" class="form-group timezones_offset">
<span<%= timezones.offset.ViewAttributes %>>
<%= timezones.offset.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If timezones.offsetdst.Visible Then ' offsetdst %>
		<td<%= timezones.offsetdst.CellAttributes %>>
<span id="el<%= timezones_delete.RowCnt %>_timezones_offsetdst" class="form-group timezones_offsetdst">
<span<%= timezones.offsetdst.ViewAttributes %>>
<%= timezones.offsetdst.ListViewValue %>
</span>
</span>
</td>
<% End If %>
	</tr>
<%
	timezones_delete.Recordset.MoveNext
Loop
timezones_delete.Recordset.Close
Set timezones_delete.Recordset = Nothing
%>
	</tbody>
</table>
</div>
</div>
<div class="btn-group ewButtonGroup">
<button class="btn btn-primary ewButton" name="btnAction" id="btnAction" type="submit"><%= Language.Phrase("DeleteBtn") %></button>
</div>
</form>
<script type="text/javascript">
ftimezonesdelete.Init();
</script>
<%
timezones_delete.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set timezones_delete = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class ctimezones_delete

	' Page ID
	Public Property Get PageID()
		PageID = "delete"
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
		PageObjName = "timezones_delete"
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
		EW_PAGE_ID = "delete"

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
	Dim StartRec
	Dim TotalRecs
	Dim RecCnt
	Dim RecKeys
	Dim Recordset
	Dim StartRowCnt
	Dim RowCnt

	' Page main processing
	Sub Page_Main()
		Dim sFilter
		StartRowCnt = 1

		' Set up Breadcrumb
		SetupBreadcrumb()

		' Load Key Parameters
		RecKeys = timezones.GetRecordKeys() ' Load record keys
		sFilter = timezones.GetKeyFilter()
		If sFilter = "" Then
			Call Page_Terminate("timezoneslist.asp") ' Prevent SQL injection, return to list
		End If

		' Set up filter (Sql Where Clause) and get Return Sql
		' Sql constructor in timezones class, timezonesinfo.asp

		timezones.CurrentFilter = sFilter

		' Get action
		If Request.Form("a_delete").Count > 0 Then
			timezones.CurrentAction = Request.Form("a_delete")
		Else
			timezones.CurrentAction = "D"	' Delete record directly
		End If
		Select Case timezones.CurrentAction
			Case "D" ' Delete
				timezones.SendEmail = True ' Send email on delete success
				If DeleteRows() Then ' Delete rows
					If SuccessMessage = "" Then SuccessMessage = Language.Phrase("DeleteSuccess") ' Set up success message
					Call Page_Terminate(timezones.ReturnUrl) ' Return to caller
				End If
		End Select
	End Sub

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
		End If

		' Call Row Rendered event
		If timezones.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call timezones.Row_Rendered()
		End If
	End Sub

	'
	' Delete records based on current filter
	'
	Function DeleteRows()
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		Dim sKey, sThisKey, sKeyFld, arKeyFlds
		Dim sSql, RsDelete
		Dim RsOld, RsDetail
		Dim OldFiles, i
		DeleteRows = True
		sSql = timezones.SQL
		Conn.BeginTrans
		Set RsDelete = Server.CreateObject("ADODB.Recordset")
		RsDelete.CursorLocation = EW_CURSORLOCATION
		RsDelete.Open sSql, Conn, 1, EW_RECORDSET_LOCKTYPE
		If Err.Number <> 0 Then
			FailureMessage = Err.Description
			RsDelete.Close
			Set RsDelete = Nothing
			DeleteRows = False
			Exit Function
		ElseIf RsDelete.Eof Then
			FailureMessage = Language.Phrase("NoRecord") ' No record found
			RsDelete.Close
			Set RsDelete = Nothing
			DeleteRows = False
			Exit Function
		End If

		' Clone old recordset object
		Set RsOld = ew_CloneRs(RsDelete)

		' Call row deleting event
		If DeleteRows Then
			RsDelete.MoveFirst
			Do While Not RsDelete.Eof
				DeleteRows = timezones.Row_Deleting(RsDelete)
				If Not DeleteRows Then Exit Do
				RsDelete.MoveNext
			Loop
			RsDelete.MoveFirst
		End If
		If DeleteRows Then
			sKey = ""
			RsDelete.MoveFirst
			Do While Not RsDelete.Eof
				sThisKey = ""
				If sThisKey <> "" Then sThisKey = sThisKey & EW_COMPOSITE_KEY_SEPARATOR
				sThisKey = sThisKey & RsDelete("ID")
				If DeleteRows Then
					RsDelete.Delete
				End If
				If Err.Number <> 0 Or Not DeleteRows Then
					If Err.Description <> "" Then FailureMessage = Err.Description ' Set up error message
					DeleteRows = False
					Exit Do
				End If
				If sKey <> "" Then sKey = sKey & ", "
				sKey = sKey & sThisKey
				RsDelete.MoveNext
			Loop
		Else

			' Set up error message
			If SuccessMessage <> "" Or FailureMessage <> "" Then

				' Use the message, do nothing
			ElseIf timezones.CancelMessage <> "" Then
				FailureMessage = timezones.CancelMessage
				timezones.CancelMessage = ""
			Else
				FailureMessage = Language.Phrase("DeleteCancelled")
			End If
		End If
		If DeleteRows Then
			Conn.CommitTrans ' Commit the changes
			If Err.Number <> 0 Then
				FailureMessage = Err.Description
				DeleteRows = False ' Delete failed
			End If
		Else
			Conn.RollbackTrans ' Rollback changes
		End If
		RsDelete.Close
		Set RsDelete = Nothing

		' Call row deleting event
		If DeleteRows Then
			RsOld.MoveFirst
			Do While Not RsOld.Eof
				Call timezones.Row_Deleted(RsOld)
				RsOld.MoveNext
			Loop
		End If
		RsOld.Close
		Set RsOld = Nothing
	End Function

	' Set up Breadcrumb
	Sub SetupBreadcrumb()
		Dim PageId, url
		Set Breadcrumb = New cBreadcrumb
		url = Mid(ew_CurrentUrl, InStrRev(ew_CurrentUrl, "/")+1)
		Call Breadcrumb.Add("list", timezones.TableVar, "timezoneslist.asp", "", timezones.TableVar, True)
		PageId = "delete"
		Call Breadcrumb.Add("delete", PageId, url, "", "", False)
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
End Class
%>
