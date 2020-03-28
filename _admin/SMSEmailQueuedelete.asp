<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="SMSEmailQueueinfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim SMSEmailQueue_delete
Set SMSEmailQueue_delete = New cSMSEmailQueue_delete
Set Page = SMSEmailQueue_delete

' Page init processing
SMSEmailQueue_delete.Page_Init()

' Page main processing
SMSEmailQueue_delete.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
SMSEmailQueue_delete.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var SMSEmailQueue_delete = new ew_Page("SMSEmailQueue_delete");
SMSEmailQueue_delete.PageID = "delete"; // Page ID
var EW_PAGE_ID = SMSEmailQueue_delete.PageID; // For backward compatibility
// Form object
var fSMSEmailQueuedelete = new ew_Form("fSMSEmailQueuedelete");
// Form_CustomValidate event
fSMSEmailQueuedelete.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fSMSEmailQueuedelete.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fSMSEmailQueuedelete.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<%

' Load records for display
Set SMSEmailQueue_delete.Recordset = SMSEmailQueue_delete.LoadRecordset()
SMSEmailQueue_delete.TotalRecs = SMSEmailQueue_delete.Recordset.RecordCount ' Get record count
If SMSEmailQueue_delete.TotalRecs <= 0 Then ' No record found, exit
	SMSEmailQueue_delete.Recordset.Close
	Set SMSEmailQueue_delete.Recordset = Nothing
	Call SMSEmailQueue_delete.Page_Terminate("SMSEmailQueuelist.asp") ' Return to list
End If
%>
<div class="ewToolbar">
<% If SMSEmailQueue.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If SMSEmailQueue.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% SMSEmailQueue_delete.ShowPageHeader() %>
<% SMSEmailQueue_delete.ShowMessage %>
<form name="fSMSEmailQueuedelete" id="fSMSEmailQueuedelete" class="form-inline ewForm ewDeleteForm" action="<%= ew_CurrentPage() %>" method="post">
<% If SMSEmailQueue_delete.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= SMSEmailQueue_delete.Token %>">
<% End If %>
<input type="hidden" name="t" value="SMSEmailQueue">
<input type="hidden" name="a_delete" id="a_delete" value="D">
<% For i = 0 to UBound(SMSEmailQueue_delete.RecKeys) %>
<input type="hidden" name="key_m" id="key_m" value="<%= ew_HtmlEncode(ew_GetKeyValue(SMSEmailQueue_delete.RecKeys(i))) %>">
<% Next %>
<div class="ewGrid">
<div class="<% If ew_IsResponsiveLayout() Then Response.Write "table-responsive " %>ewGridMiddlePanel">
<table class="table ewTable">
<%= SMSEmailQueue.TableCustomInnerHtml %>
	<thead>
	<tr class="ewTableHeader">
<% If SMSEmailQueue.ID.Visible Then ' ID %>
		<th><span id="elh_SMSEmailQueue_ID" class="SMSEmailQueue_ID"><%= SMSEmailQueue.ID.FldCaption %></span></th>
<% End If %>
<% If SMSEmailQueue.ToEmailAddress.Visible Then ' ToEmailAddress %>
		<th><span id="elh_SMSEmailQueue_ToEmailAddress" class="SMSEmailQueue_ToEmailAddress"><%= SMSEmailQueue.ToEmailAddress.FldCaption %></span></th>
<% End If %>
<% If SMSEmailQueue.PhoneNumber.Visible Then ' PhoneNumber %>
		<th><span id="elh_SMSEmailQueue_PhoneNumber" class="SMSEmailQueue_PhoneNumber"><%= SMSEmailQueue.PhoneNumber.FldCaption %></span></th>
<% End If %>
<% If SMSEmailQueue.Content.Visible Then ' Content %>
		<th><span id="elh_SMSEmailQueue_Content" class="SMSEmailQueue_Content"><%= SMSEmailQueue.Content.FldCaption %></span></th>
<% End If %>
<% If SMSEmailQueue.SendTime.Visible Then ' SendTime %>
		<th><span id="elh_SMSEmailQueue_SendTime" class="SMSEmailQueue_SendTime"><%= SMSEmailQueue.SendTime.FldCaption %></span></th>
<% End If %>
<% If SMSEmailQueue.IsSent.Visible Then ' IsSent %>
		<th><span id="elh_SMSEmailQueue_IsSent" class="SMSEmailQueue_IsSent"><%= SMSEmailQueue.IsSent.FldCaption %></span></th>
<% End If %>
<% If SMSEmailQueue.PlanSendDate.Visible Then ' PlanSendDate %>
		<th><span id="elh_SMSEmailQueue_PlanSendDate" class="SMSEmailQueue_PlanSendDate"><%= SMSEmailQueue.PlanSendDate.FldCaption %></span></th>
<% End If %>
<% If SMSEmailQueue.SendType.Visible Then ' SendType %>
		<th><span id="elh_SMSEmailQueue_SendType" class="SMSEmailQueue_SendType"><%= SMSEmailQueue.SendType.FldCaption %></span></th>
<% End If %>
<% If SMSEmailQueue.BusinessDetailID.Visible Then ' BusinessDetailID %>
		<th><span id="elh_SMSEmailQueue_BusinessDetailID" class="SMSEmailQueue_BusinessDetailID"><%= SMSEmailQueue.BusinessDetailID.FldCaption %></span></th>
<% End If %>
	</tr>
	</thead>
	<tbody>
<%
SMSEmailQueue_delete.RecCnt = 0
SMSEmailQueue_delete.RowCnt = 0
Do While (Not SMSEmailQueue_delete.Recordset.Eof)
	SMSEmailQueue_delete.RecCnt = SMSEmailQueue_delete.RecCnt + 1
	SMSEmailQueue_delete.RowCnt = SMSEmailQueue_delete.RowCnt + 1

	' Set row properties
	Call SMSEmailQueue.ResetAttrs()
	SMSEmailQueue.RowType = EW_ROWTYPE_VIEW ' view

	' Get the field contents
	Call SMSEmailQueue_delete.LoadRowValues(SMSEmailQueue_delete.Recordset)

	' Render row
	Call SMSEmailQueue_delete.RenderRow()
%>
	<tr<%= SMSEmailQueue.RowAttributes %>>
<% If SMSEmailQueue.ID.Visible Then ' ID %>
		<td<%= SMSEmailQueue.ID.CellAttributes %>>
<span id="el<%= SMSEmailQueue_delete.RowCnt %>_SMSEmailQueue_ID" class="form-group SMSEmailQueue_ID">
<span<%= SMSEmailQueue.ID.ViewAttributes %>>
<%= SMSEmailQueue.ID.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If SMSEmailQueue.ToEmailAddress.Visible Then ' ToEmailAddress %>
		<td<%= SMSEmailQueue.ToEmailAddress.CellAttributes %>>
<span id="el<%= SMSEmailQueue_delete.RowCnt %>_SMSEmailQueue_ToEmailAddress" class="form-group SMSEmailQueue_ToEmailAddress">
<span<%= SMSEmailQueue.ToEmailAddress.ViewAttributes %>>
<%= SMSEmailQueue.ToEmailAddress.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If SMSEmailQueue.PhoneNumber.Visible Then ' PhoneNumber %>
		<td<%= SMSEmailQueue.PhoneNumber.CellAttributes %>>
<span id="el<%= SMSEmailQueue_delete.RowCnt %>_SMSEmailQueue_PhoneNumber" class="form-group SMSEmailQueue_PhoneNumber">
<span<%= SMSEmailQueue.PhoneNumber.ViewAttributes %>>
<%= SMSEmailQueue.PhoneNumber.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If SMSEmailQueue.Content.Visible Then ' Content %>
		<td<%= SMSEmailQueue.Content.CellAttributes %>>
<span id="el<%= SMSEmailQueue_delete.RowCnt %>_SMSEmailQueue_Content" class="form-group SMSEmailQueue_Content">
<span<%= SMSEmailQueue.Content.ViewAttributes %>>
<%= SMSEmailQueue.Content.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If SMSEmailQueue.SendTime.Visible Then ' SendTime %>
		<td<%= SMSEmailQueue.SendTime.CellAttributes %>>
<span id="el<%= SMSEmailQueue_delete.RowCnt %>_SMSEmailQueue_SendTime" class="form-group SMSEmailQueue_SendTime">
<span<%= SMSEmailQueue.SendTime.ViewAttributes %>>
<%= SMSEmailQueue.SendTime.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If SMSEmailQueue.IsSent.Visible Then ' IsSent %>
		<td<%= SMSEmailQueue.IsSent.CellAttributes %>>
<span id="el<%= SMSEmailQueue_delete.RowCnt %>_SMSEmailQueue_IsSent" class="form-group SMSEmailQueue_IsSent">
<span<%= SMSEmailQueue.IsSent.ViewAttributes %>>
<%= SMSEmailQueue.IsSent.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If SMSEmailQueue.PlanSendDate.Visible Then ' PlanSendDate %>
		<td<%= SMSEmailQueue.PlanSendDate.CellAttributes %>>
<span id="el<%= SMSEmailQueue_delete.RowCnt %>_SMSEmailQueue_PlanSendDate" class="form-group SMSEmailQueue_PlanSendDate">
<span<%= SMSEmailQueue.PlanSendDate.ViewAttributes %>>
<%= SMSEmailQueue.PlanSendDate.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If SMSEmailQueue.SendType.Visible Then ' SendType %>
		<td<%= SMSEmailQueue.SendType.CellAttributes %>>
<span id="el<%= SMSEmailQueue_delete.RowCnt %>_SMSEmailQueue_SendType" class="form-group SMSEmailQueue_SendType">
<span<%= SMSEmailQueue.SendType.ViewAttributes %>>
<%= SMSEmailQueue.SendType.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If SMSEmailQueue.BusinessDetailID.Visible Then ' BusinessDetailID %>
		<td<%= SMSEmailQueue.BusinessDetailID.CellAttributes %>>
<span id="el<%= SMSEmailQueue_delete.RowCnt %>_SMSEmailQueue_BusinessDetailID" class="form-group SMSEmailQueue_BusinessDetailID">
<span<%= SMSEmailQueue.BusinessDetailID.ViewAttributes %>>
<%= SMSEmailQueue.BusinessDetailID.ListViewValue %>
</span>
</span>
</td>
<% End If %>
	</tr>
<%
	SMSEmailQueue_delete.Recordset.MoveNext
Loop
SMSEmailQueue_delete.Recordset.Close
Set SMSEmailQueue_delete.Recordset = Nothing
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
fSMSEmailQueuedelete.Init();
</script>
<%
SMSEmailQueue_delete.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set SMSEmailQueue_delete = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cSMSEmailQueue_delete

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
		TableName = "SMSEmailQueue"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "SMSEmailQueue_delete"
	End Property

	' Page Name
	Public Property Get PageName()
		PageName = ew_CurrentPage()
	End Property

	' Page Url
	Public Property Get PageUrl()
		PageUrl = ew_CurrentPage() & "?"
		If SMSEmailQueue.UseTokenInUrl Then PageUrl = PageUrl & "t=" & SMSEmailQueue.TableVar & "&" ' add page token
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
		If SMSEmailQueue.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (SMSEmailQueue.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (SMSEmailQueue.TableVar = Request.QueryString("t"))
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
		If IsEmpty(SMSEmailQueue) Then Set SMSEmailQueue = New cSMSEmailQueue
		Set Table = SMSEmailQueue

		' Initialize urls
		' Initialize form object

		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "delete"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "SMSEmailQueue"

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
			results = SMSEmailQueue.GetAutoFill(Request.Form("name"), Request.Form("q"))
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
		If Not SMSEmailQueue Is Nothing Then
			If SMSEmailQueue.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = SMSEmailQueue.TableVar
				If SMSEmailQueue.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf SMSEmailQueue.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf SMSEmailQueue.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf SMSEmailQueue.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set SMSEmailQueue = Nothing
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
		RecKeys = SMSEmailQueue.GetRecordKeys() ' Load record keys
		sFilter = SMSEmailQueue.GetKeyFilter()
		If sFilter = "" Then
			Call Page_Terminate("SMSEmailQueuelist.asp") ' Prevent SQL injection, return to list
		End If

		' Set up filter (Sql Where Clause) and get Return Sql
		' Sql constructor in SMSEmailQueue class, SMSEmailQueueinfo.asp

		SMSEmailQueue.CurrentFilter = sFilter

		' Get action
		If Request.Form("a_delete").Count > 0 Then
			SMSEmailQueue.CurrentAction = Request.Form("a_delete")
		Else
			SMSEmailQueue.CurrentAction = "D"	' Delete record directly
		End If
		Select Case SMSEmailQueue.CurrentAction
			Case "D" ' Delete
				SMSEmailQueue.SendEmail = True ' Send email on delete success
				If DeleteRows() Then ' Delete rows
					If SuccessMessage = "" Then SuccessMessage = Language.Phrase("DeleteSuccess") ' Set up success message
					Call Page_Terminate(SMSEmailQueue.ReturnUrl) ' Return to caller
				End If
		End Select
	End Sub

	' -----------------------------------------------------------------
	' Load recordset
	'
	Function LoadRecordset()

		' Load list page sql
		Dim sSql
		sSql = SMSEmailQueue.SelectSQL
		Call ew_SetDebugMsg("LoadRecordset: " & sSql) ' Show SQL for debugging

		' Load recordset
		Dim RsRecordset
		Set RsRecordset = ew_LoadRecordset(sSql)

		' Call Recordset Selected event
		Call SMSEmailQueue.Recordset_Selected(RsRecordset)
		Set LoadRecordset = RsRecordset
	End Function

	' -----------------------------------------------------------------
	' Load row based on key values
	'
	Function LoadRow()
		Dim RsRow, sSql, sFilter
		sFilter = SMSEmailQueue.KeyFilter

		' Call Row Selecting event
		Call SMSEmailQueue.Row_Selecting(sFilter)

		' Load sql based on filter
		SMSEmailQueue.CurrentFilter = sFilter
		sSql = SMSEmailQueue.SQL
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
		Call SMSEmailQueue.Row_Selected(RsRow)
		SMSEmailQueue.ID.DbValue = RsRow("ID")
		SMSEmailQueue.ToEmailAddress.DbValue = RsRow("ToEmailAddress")
		SMSEmailQueue.PhoneNumber.DbValue = RsRow("PhoneNumber")
		SMSEmailQueue.Content.DbValue = RsRow("Content")
		SMSEmailQueue.SendTime.DbValue = RsRow("SendTime")
		SMSEmailQueue.IsSent.DbValue = RsRow("IsSent")
		SMSEmailQueue.PlanSendDate.DbValue = RsRow("PlanSendDate")
		SMSEmailQueue.SendType.DbValue = RsRow("SendType")
		SMSEmailQueue.BusinessDetailID.DbValue = ew_Conv(RsRow("BusinessDetailID"), 131)
	End Sub

	' Load DbValue from recordset
	Sub LoadDbValues(Rs)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		If Rs.Eof Then Exit Sub
		SMSEmailQueue.ID.m_DbValue = Rs("ID")
		SMSEmailQueue.ToEmailAddress.m_DbValue = Rs("ToEmailAddress")
		SMSEmailQueue.PhoneNumber.m_DbValue = Rs("PhoneNumber")
		SMSEmailQueue.Content.m_DbValue = Rs("Content")
		SMSEmailQueue.SendTime.m_DbValue = Rs("SendTime")
		SMSEmailQueue.IsSent.m_DbValue = Rs("IsSent")
		SMSEmailQueue.PlanSendDate.m_DbValue = Rs("PlanSendDate")
		SMSEmailQueue.SendType.m_DbValue = Rs("SendType")
		SMSEmailQueue.BusinessDetailID.m_DbValue = ew_Conv(Rs("BusinessDetailID"), 131)
	End Sub

	' -----------------------------------------------------------------
	' Render row values based on field settings
	'
	Sub RenderRow()

		' Initialize urls
		' Convert decimal values if posted back

		If SMSEmailQueue.BusinessDetailID.CurrentValue & "" <> "" Then SMSEmailQueue.BusinessDetailID.CurrentValue = ew_Conv(SMSEmailQueue.BusinessDetailID.CurrentValue, SMSEmailQueue.BusinessDetailID.FldType)
		If SMSEmailQueue.BusinessDetailID.FormValue = SMSEmailQueue.BusinessDetailID.CurrentValue And IsNumeric(SMSEmailQueue.BusinessDetailID.CurrentValue) Then
			SMSEmailQueue.BusinessDetailID.CurrentValue = ew_StrToFloat(SMSEmailQueue.BusinessDetailID.CurrentValue)
		End If

		' Call Row Rendering event
		Call SMSEmailQueue.Row_Rendering()

		' ---------------------------------------
		'  Common render codes for all row types
		' ---------------------------------------
		' ID
		' ToEmailAddress
		' PhoneNumber
		' Content
		' SendTime
		' IsSent
		' PlanSendDate
		' SendType
		' BusinessDetailID
		' -----------
		'  View  Row
		' -----------

		If SMSEmailQueue.RowType = EW_ROWTYPE_VIEW Then ' View row

			' ID
			SMSEmailQueue.ID.ViewValue = SMSEmailQueue.ID.CurrentValue
			SMSEmailQueue.ID.ViewCustomAttributes = ""

			' ToEmailAddress
			SMSEmailQueue.ToEmailAddress.ViewValue = SMSEmailQueue.ToEmailAddress.CurrentValue
			SMSEmailQueue.ToEmailAddress.ViewCustomAttributes = ""

			' PhoneNumber
			SMSEmailQueue.PhoneNumber.ViewValue = SMSEmailQueue.PhoneNumber.CurrentValue
			SMSEmailQueue.PhoneNumber.ViewCustomAttributes = ""

			' Content
			SMSEmailQueue.Content.ViewValue = SMSEmailQueue.Content.CurrentValue
			SMSEmailQueue.Content.ViewCustomAttributes = ""

			' SendTime
			SMSEmailQueue.SendTime.ViewValue = SMSEmailQueue.SendTime.CurrentValue
			SMSEmailQueue.SendTime.ViewCustomAttributes = ""

			' IsSent
			SMSEmailQueue.IsSent.ViewValue = SMSEmailQueue.IsSent.CurrentValue
			SMSEmailQueue.IsSent.ViewCustomAttributes = ""

			' PlanSendDate
			SMSEmailQueue.PlanSendDate.ViewValue = SMSEmailQueue.PlanSendDate.CurrentValue
			SMSEmailQueue.PlanSendDate.ViewCustomAttributes = ""

			' SendType
			SMSEmailQueue.SendType.ViewValue = SMSEmailQueue.SendType.CurrentValue
			SMSEmailQueue.SendType.ViewCustomAttributes = ""

			' BusinessDetailID
			SMSEmailQueue.BusinessDetailID.ViewValue = SMSEmailQueue.BusinessDetailID.CurrentValue
			SMSEmailQueue.BusinessDetailID.ViewCustomAttributes = ""

			' View refer script
			' ID

			SMSEmailQueue.ID.LinkCustomAttributes = ""
			SMSEmailQueue.ID.HrefValue = ""
			SMSEmailQueue.ID.TooltipValue = ""

			' ToEmailAddress
			SMSEmailQueue.ToEmailAddress.LinkCustomAttributes = ""
			SMSEmailQueue.ToEmailAddress.HrefValue = ""
			SMSEmailQueue.ToEmailAddress.TooltipValue = ""

			' PhoneNumber
			SMSEmailQueue.PhoneNumber.LinkCustomAttributes = ""
			SMSEmailQueue.PhoneNumber.HrefValue = ""
			SMSEmailQueue.PhoneNumber.TooltipValue = ""

			' Content
			SMSEmailQueue.Content.LinkCustomAttributes = ""
			SMSEmailQueue.Content.HrefValue = ""
			SMSEmailQueue.Content.TooltipValue = ""

			' SendTime
			SMSEmailQueue.SendTime.LinkCustomAttributes = ""
			SMSEmailQueue.SendTime.HrefValue = ""
			SMSEmailQueue.SendTime.TooltipValue = ""

			' IsSent
			SMSEmailQueue.IsSent.LinkCustomAttributes = ""
			SMSEmailQueue.IsSent.HrefValue = ""
			SMSEmailQueue.IsSent.TooltipValue = ""

			' PlanSendDate
			SMSEmailQueue.PlanSendDate.LinkCustomAttributes = ""
			SMSEmailQueue.PlanSendDate.HrefValue = ""
			SMSEmailQueue.PlanSendDate.TooltipValue = ""

			' SendType
			SMSEmailQueue.SendType.LinkCustomAttributes = ""
			SMSEmailQueue.SendType.HrefValue = ""
			SMSEmailQueue.SendType.TooltipValue = ""

			' BusinessDetailID
			SMSEmailQueue.BusinessDetailID.LinkCustomAttributes = ""
			SMSEmailQueue.BusinessDetailID.HrefValue = ""
			SMSEmailQueue.BusinessDetailID.TooltipValue = ""
		End If

		' Call Row Rendered event
		If SMSEmailQueue.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call SMSEmailQueue.Row_Rendered()
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
		sSql = SMSEmailQueue.SQL
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
				DeleteRows = SMSEmailQueue.Row_Deleting(RsDelete)
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
			ElseIf SMSEmailQueue.CancelMessage <> "" Then
				FailureMessage = SMSEmailQueue.CancelMessage
				SMSEmailQueue.CancelMessage = ""
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
				Call SMSEmailQueue.Row_Deleted(RsOld)
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
		Call Breadcrumb.Add("list", SMSEmailQueue.TableVar, "SMSEmailQueuelist.asp", "", SMSEmailQueue.TableVar, True)
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
