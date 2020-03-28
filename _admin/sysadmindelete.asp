<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="sysadmininfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim sysadmin_delete
Set sysadmin_delete = New csysadmin_delete
Set Page = sysadmin_delete

' Page init processing
sysadmin_delete.Page_Init()

' Page main processing
sysadmin_delete.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
sysadmin_delete.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var sysadmin_delete = new ew_Page("sysadmin_delete");
sysadmin_delete.PageID = "delete"; // Page ID
var EW_PAGE_ID = sysadmin_delete.PageID; // For backward compatibility
// Form object
var fsysadmindelete = new ew_Form("fsysadmindelete");
// Form_CustomValidate event
fsysadmindelete.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fsysadmindelete.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fsysadmindelete.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<%

' Load records for display
Set sysadmin_delete.Recordset = sysadmin_delete.LoadRecordset()
sysadmin_delete.TotalRecs = sysadmin_delete.Recordset.RecordCount ' Get record count
If sysadmin_delete.TotalRecs <= 0 Then ' No record found, exit
	sysadmin_delete.Recordset.Close
	Set sysadmin_delete.Recordset = Nothing
	Call sysadmin_delete.Page_Terminate("sysadminlist.asp") ' Return to list
End If
%>
<div class="ewToolbar">
<% If sysadmin.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If sysadmin.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% sysadmin_delete.ShowPageHeader() %>
<% sysadmin_delete.ShowMessage %>
<form name="fsysadmindelete" id="fsysadmindelete" class="form-inline ewForm ewDeleteForm" action="<%= ew_CurrentPage() %>" method="post">
<% If sysadmin_delete.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= sysadmin_delete.Token %>">
<% End If %>
<input type="hidden" name="t" value="sysadmin">
<input type="hidden" name="a_delete" id="a_delete" value="D">
<% For i = 0 to UBound(sysadmin_delete.RecKeys) %>
<input type="hidden" name="key_m" id="key_m" value="<%= ew_HtmlEncode(ew_GetKeyValue(sysadmin_delete.RecKeys(i))) %>">
<% Next %>
<div class="ewGrid">
<div class="<% If ew_IsResponsiveLayout() Then Response.Write "table-responsive " %>ewGridMiddlePanel">
<table class="table ewTable">
<%= sysadmin.TableCustomInnerHtml %>
	<thead>
	<tr class="ewTableHeader">
<% If sysadmin.ID.Visible Then ' ID %>
		<th><span id="elh_sysadmin_ID" class="sysadmin_ID"><%= sysadmin.ID.FldCaption %></span></th>
<% End If %>
<% If sysadmin.username.Visible Then ' username %>
		<th><span id="elh_sysadmin_username" class="sysadmin_username"><%= sysadmin.username.FldCaption %></span></th>
<% End If %>
<% If sysadmin.pswd.Visible Then ' pswd %>
		<th><span id="elh_sysadmin_pswd" class="sysadmin_pswd"><%= sysadmin.pswd.FldCaption %></span></th>
<% End If %>
<% If sysadmin.userrolelabel.Visible Then ' userrolelabel %>
		<th><span id="elh_sysadmin_userrolelabel" class="sysadmin_userrolelabel"><%= sysadmin.userrolelabel.FldCaption %></span></th>
<% End If %>
<% If sysadmin.userrole.Visible Then ' userrole %>
		<th><span id="elh_sysadmin_userrole" class="sysadmin_userrole"><%= sysadmin.userrole.FldCaption %></span></th>
<% End If %>
	</tr>
	</thead>
	<tbody>
<%
sysadmin_delete.RecCnt = 0
sysadmin_delete.RowCnt = 0
Do While (Not sysadmin_delete.Recordset.Eof)
	sysadmin_delete.RecCnt = sysadmin_delete.RecCnt + 1
	sysadmin_delete.RowCnt = sysadmin_delete.RowCnt + 1

	' Set row properties
	Call sysadmin.ResetAttrs()
	sysadmin.RowType = EW_ROWTYPE_VIEW ' view

	' Get the field contents
	Call sysadmin_delete.LoadRowValues(sysadmin_delete.Recordset)

	' Render row
	Call sysadmin_delete.RenderRow()
%>
	<tr<%= sysadmin.RowAttributes %>>
<% If sysadmin.ID.Visible Then ' ID %>
		<td<%= sysadmin.ID.CellAttributes %>>
<span id="el<%= sysadmin_delete.RowCnt %>_sysadmin_ID" class="form-group sysadmin_ID">
<span<%= sysadmin.ID.ViewAttributes %>>
<%= sysadmin.ID.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If sysadmin.username.Visible Then ' username %>
		<td<%= sysadmin.username.CellAttributes %>>
<span id="el<%= sysadmin_delete.RowCnt %>_sysadmin_username" class="form-group sysadmin_username">
<span<%= sysadmin.username.ViewAttributes %>>
<%= sysadmin.username.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If sysadmin.pswd.Visible Then ' pswd %>
		<td<%= sysadmin.pswd.CellAttributes %>>
<span id="el<%= sysadmin_delete.RowCnt %>_sysadmin_pswd" class="form-group sysadmin_pswd">
<span<%= sysadmin.pswd.ViewAttributes %>>
<%= sysadmin.pswd.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If sysadmin.userrolelabel.Visible Then ' userrolelabel %>
		<td<%= sysadmin.userrolelabel.CellAttributes %>>
<span id="el<%= sysadmin_delete.RowCnt %>_sysadmin_userrolelabel" class="form-group sysadmin_userrolelabel">
<span<%= sysadmin.userrolelabel.ViewAttributes %>>
<%= sysadmin.userrolelabel.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If sysadmin.userrole.Visible Then ' userrole %>
		<td<%= sysadmin.userrole.CellAttributes %>>
<span id="el<%= sysadmin_delete.RowCnt %>_sysadmin_userrole" class="form-group sysadmin_userrole">
<span<%= sysadmin.userrole.ViewAttributes %>>
<%= sysadmin.userrole.ListViewValue %>
</span>
</span>
</td>
<% End If %>
	</tr>
<%
	sysadmin_delete.Recordset.MoveNext
Loop
sysadmin_delete.Recordset.Close
Set sysadmin_delete.Recordset = Nothing
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
fsysadmindelete.Init();
</script>
<%
sysadmin_delete.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set sysadmin_delete = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class csysadmin_delete

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
		TableName = "sysadmin"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "sysadmin_delete"
	End Property

	' Page Name
	Public Property Get PageName()
		PageName = ew_CurrentPage()
	End Property

	' Page Url
	Public Property Get PageUrl()
		PageUrl = ew_CurrentPage() & "?"
		If sysadmin.UseTokenInUrl Then PageUrl = PageUrl & "t=" & sysadmin.TableVar & "&" ' add page token
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
		If sysadmin.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (sysadmin.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (sysadmin.TableVar = Request.QueryString("t"))
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
		If IsEmpty(sysadmin) Then Set sysadmin = New csysadmin
		Set Table = sysadmin

		' Initialize urls
		' Initialize form object

		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "delete"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "sysadmin"

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
			results = sysadmin.GetAutoFill(Request.Form("name"), Request.Form("q"))
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
		If Not sysadmin Is Nothing Then
			If sysadmin.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = sysadmin.TableVar
				If sysadmin.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf sysadmin.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf sysadmin.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf sysadmin.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set sysadmin = Nothing
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
		RecKeys = sysadmin.GetRecordKeys() ' Load record keys
		sFilter = sysadmin.GetKeyFilter()
		If sFilter = "" Then
			Call Page_Terminate("sysadminlist.asp") ' Prevent SQL injection, return to list
		End If

		' Set up filter (Sql Where Clause) and get Return Sql
		' Sql constructor in sysadmin class, sysadmininfo.asp

		sysadmin.CurrentFilter = sFilter

		' Get action
		If Request.Form("a_delete").Count > 0 Then
			sysadmin.CurrentAction = Request.Form("a_delete")
		Else
			sysadmin.CurrentAction = "D"	' Delete record directly
		End If
		Select Case sysadmin.CurrentAction
			Case "D" ' Delete
				sysadmin.SendEmail = True ' Send email on delete success
				If DeleteRows() Then ' Delete rows
					If SuccessMessage = "" Then SuccessMessage = Language.Phrase("DeleteSuccess") ' Set up success message
					Call Page_Terminate(sysadmin.ReturnUrl) ' Return to caller
				End If
		End Select
	End Sub

	' -----------------------------------------------------------------
	' Load recordset
	'
	Function LoadRecordset()

		' Load list page sql
		Dim sSql
		sSql = sysadmin.SelectSQL
		Call ew_SetDebugMsg("LoadRecordset: " & sSql) ' Show SQL for debugging

		' Load recordset
		Dim RsRecordset
		Set RsRecordset = ew_LoadRecordset(sSql)

		' Call Recordset Selected event
		Call sysadmin.Recordset_Selected(RsRecordset)
		Set LoadRecordset = RsRecordset
	End Function

	' -----------------------------------------------------------------
	' Load row based on key values
	'
	Function LoadRow()
		Dim RsRow, sSql, sFilter
		sFilter = sysadmin.KeyFilter

		' Call Row Selecting event
		Call sysadmin.Row_Selecting(sFilter)

		' Load sql based on filter
		sysadmin.CurrentFilter = sFilter
		sSql = sysadmin.SQL
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
		Call sysadmin.Row_Selected(RsRow)
		sysadmin.ID.DbValue = RsRow("ID")
		sysadmin.username.DbValue = RsRow("username")
		sysadmin.pswd.DbValue = RsRow("pswd")
		sysadmin.userrolelabel.DbValue = RsRow("userrolelabel")
		sysadmin.userrole.DbValue = RsRow("userrole")
	End Sub

	' Load DbValue from recordset
	Sub LoadDbValues(Rs)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		If Rs.Eof Then Exit Sub
		sysadmin.ID.m_DbValue = Rs("ID")
		sysadmin.username.m_DbValue = Rs("username")
		sysadmin.pswd.m_DbValue = Rs("pswd")
		sysadmin.userrolelabel.m_DbValue = Rs("userrolelabel")
		sysadmin.userrole.m_DbValue = Rs("userrole")
	End Sub

	' -----------------------------------------------------------------
	' Render row values based on field settings
	'
	Sub RenderRow()

		' Initialize urls
		' Call Row Rendering event

		Call sysadmin.Row_Rendering()

		' ---------------------------------------
		'  Common render codes for all row types
		' ---------------------------------------
		' ID
		' username
		' pswd
		' userrolelabel
		' userrole
		' -----------
		'  View  Row
		' -----------

		If sysadmin.RowType = EW_ROWTYPE_VIEW Then ' View row

			' ID
			sysadmin.ID.ViewValue = sysadmin.ID.CurrentValue
			sysadmin.ID.ViewCustomAttributes = ""

			' username
			sysadmin.username.ViewValue = sysadmin.username.CurrentValue
			sysadmin.username.ViewCustomAttributes = ""

			' pswd
			sysadmin.pswd.ViewValue = sysadmin.pswd.CurrentValue
			sysadmin.pswd.ViewCustomAttributes = ""

			' userrolelabel
			sysadmin.userrolelabel.ViewValue = sysadmin.userrolelabel.CurrentValue
			sysadmin.userrolelabel.ViewCustomAttributes = ""

			' userrole
			sysadmin.userrole.ViewValue = sysadmin.userrole.CurrentValue
			sysadmin.userrole.ViewCustomAttributes = ""

			' View refer script
			' ID

			sysadmin.ID.LinkCustomAttributes = ""
			sysadmin.ID.HrefValue = ""
			sysadmin.ID.TooltipValue = ""

			' username
			sysadmin.username.LinkCustomAttributes = ""
			sysadmin.username.HrefValue = ""
			sysadmin.username.TooltipValue = ""

			' pswd
			sysadmin.pswd.LinkCustomAttributes = ""
			sysadmin.pswd.HrefValue = ""
			sysadmin.pswd.TooltipValue = ""

			' userrolelabel
			sysadmin.userrolelabel.LinkCustomAttributes = ""
			sysadmin.userrolelabel.HrefValue = ""
			sysadmin.userrolelabel.TooltipValue = ""

			' userrole
			sysadmin.userrole.LinkCustomAttributes = ""
			sysadmin.userrole.HrefValue = ""
			sysadmin.userrole.TooltipValue = ""
		End If

		' Call Row Rendered event
		If sysadmin.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call sysadmin.Row_Rendered()
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
		sSql = sysadmin.SQL
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
				DeleteRows = sysadmin.Row_Deleting(RsDelete)
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
			ElseIf sysadmin.CancelMessage <> "" Then
				FailureMessage = sysadmin.CancelMessage
				sysadmin.CancelMessage = ""
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
				Call sysadmin.Row_Deleted(RsOld)
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
		Call Breadcrumb.Add("list", sysadmin.TableVar, "sysadminlist.asp", "", sysadmin.TableVar, True)
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
