<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="Category_Openning_Timeinfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim Category_Openning_Time_delete
Set Category_Openning_Time_delete = New cCategory_Openning_Time_delete
Set Page = Category_Openning_Time_delete

' Page init processing
Category_Openning_Time_delete.Page_Init()

' Page main processing
Category_Openning_Time_delete.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
Category_Openning_Time_delete.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var Category_Openning_Time_delete = new ew_Page("Category_Openning_Time_delete");
Category_Openning_Time_delete.PageID = "delete"; // Page ID
var EW_PAGE_ID = Category_Openning_Time_delete.PageID; // For backward compatibility
// Form object
var fCategory_Openning_Timedelete = new ew_Form("fCategory_Openning_Timedelete");
// Form_CustomValidate event
fCategory_Openning_Timedelete.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fCategory_Openning_Timedelete.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fCategory_Openning_Timedelete.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<%

' Load records for display
Set Category_Openning_Time_delete.Recordset = Category_Openning_Time_delete.LoadRecordset()
Category_Openning_Time_delete.TotalRecs = Category_Openning_Time_delete.Recordset.RecordCount ' Get record count
If Category_Openning_Time_delete.TotalRecs <= 0 Then ' No record found, exit
	Category_Openning_Time_delete.Recordset.Close
	Set Category_Openning_Time_delete.Recordset = Nothing
	Call Category_Openning_Time_delete.Page_Terminate("Category_Openning_Timelist.asp") ' Return to list
End If
%>
<div class="ewToolbar">
<% If Category_Openning_Time.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If Category_Openning_Time.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% Category_Openning_Time_delete.ShowPageHeader() %>
<% Category_Openning_Time_delete.ShowMessage %>
<form name="fCategory_Openning_Timedelete" id="fCategory_Openning_Timedelete" class="form-inline ewForm ewDeleteForm" action="<%= ew_CurrentPage() %>" method="post">
<% If Category_Openning_Time_delete.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= Category_Openning_Time_delete.Token %>">
<% End If %>
<input type="hidden" name="t" value="Category_Openning_Time">
<input type="hidden" name="a_delete" id="a_delete" value="D">
<% For i = 0 to UBound(Category_Openning_Time_delete.RecKeys) %>
<input type="hidden" name="key_m" id="key_m" value="<%= ew_HtmlEncode(ew_GetKeyValue(Category_Openning_Time_delete.RecKeys(i))) %>">
<% Next %>
<div class="ewGrid">
<div class="<% If ew_IsResponsiveLayout() Then Response.Write "table-responsive " %>ewGridMiddlePanel">
<table class="table ewTable">
<%= Category_Openning_Time.TableCustomInnerHtml %>
	<thead>
	<tr class="ewTableHeader">
<% If Category_Openning_Time.ID.Visible Then ' ID %>
		<th><span id="elh_Category_Openning_Time_ID" class="Category_Openning_Time_ID"><%= Category_Openning_Time.ID.FldCaption %></span></th>
<% End If %>
<% If Category_Openning_Time.CategoryID.Visible Then ' CategoryID %>
		<th><span id="elh_Category_Openning_Time_CategoryID" class="Category_Openning_Time_CategoryID"><%= Category_Openning_Time.CategoryID.FldCaption %></span></th>
<% End If %>
<% If Category_Openning_Time.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
		<th><span id="elh_Category_Openning_Time_IdBusinessDetail" class="Category_Openning_Time_IdBusinessDetail"><%= Category_Openning_Time.IdBusinessDetail.FldCaption %></span></th>
<% End If %>
<% If Category_Openning_Time.Hour_From.Visible Then ' Hour_From %>
		<th><span id="elh_Category_Openning_Time_Hour_From" class="Category_Openning_Time_Hour_From"><%= Category_Openning_Time.Hour_From.FldCaption %></span></th>
<% End If %>
<% If Category_Openning_Time.Hour_To.Visible Then ' Hour_To %>
		<th><span id="elh_Category_Openning_Time_Hour_To" class="Category_Openning_Time_Hour_To"><%= Category_Openning_Time.Hour_To.FldCaption %></span></th>
<% End If %>
<% If Category_Openning_Time.DayValue.Visible Then ' DayValue %>
		<th><span id="elh_Category_Openning_Time_DayValue" class="Category_Openning_Time_DayValue"><%= Category_Openning_Time.DayValue.FldCaption %></span></th>
<% End If %>
<% If Category_Openning_Time.Dayname.Visible Then ' Dayname %>
		<th><span id="elh_Category_Openning_Time_Dayname" class="Category_Openning_Time_Dayname"><%= Category_Openning_Time.Dayname.FldCaption %></span></th>
<% End If %>
<% If Category_Openning_Time.status.Visible Then ' status %>
		<th><span id="elh_Category_Openning_Time_status" class="Category_Openning_Time_status"><%= Category_Openning_Time.status.FldCaption %></span></th>
<% End If %>
	</tr>
	</thead>
	<tbody>
<%
Category_Openning_Time_delete.RecCnt = 0
Category_Openning_Time_delete.RowCnt = 0
Do While (Not Category_Openning_Time_delete.Recordset.Eof)
	Category_Openning_Time_delete.RecCnt = Category_Openning_Time_delete.RecCnt + 1
	Category_Openning_Time_delete.RowCnt = Category_Openning_Time_delete.RowCnt + 1

	' Set row properties
	Call Category_Openning_Time.ResetAttrs()
	Category_Openning_Time.RowType = EW_ROWTYPE_VIEW ' view

	' Get the field contents
	Call Category_Openning_Time_delete.LoadRowValues(Category_Openning_Time_delete.Recordset)

	' Render row
	Call Category_Openning_Time_delete.RenderRow()
%>
	<tr<%= Category_Openning_Time.RowAttributes %>>
<% If Category_Openning_Time.ID.Visible Then ' ID %>
		<td<%= Category_Openning_Time.ID.CellAttributes %>>
<span id="el<%= Category_Openning_Time_delete.RowCnt %>_Category_Openning_Time_ID" class="form-group Category_Openning_Time_ID">
<span<%= Category_Openning_Time.ID.ViewAttributes %>>
<%= Category_Openning_Time.ID.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Category_Openning_Time.CategoryID.Visible Then ' CategoryID %>
		<td<%= Category_Openning_Time.CategoryID.CellAttributes %>>
<span id="el<%= Category_Openning_Time_delete.RowCnt %>_Category_Openning_Time_CategoryID" class="form-group Category_Openning_Time_CategoryID">
<span<%= Category_Openning_Time.CategoryID.ViewAttributes %>>
<%= Category_Openning_Time.CategoryID.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Category_Openning_Time.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
		<td<%= Category_Openning_Time.IdBusinessDetail.CellAttributes %>>
<span id="el<%= Category_Openning_Time_delete.RowCnt %>_Category_Openning_Time_IdBusinessDetail" class="form-group Category_Openning_Time_IdBusinessDetail">
<span<%= Category_Openning_Time.IdBusinessDetail.ViewAttributes %>>
<%= Category_Openning_Time.IdBusinessDetail.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Category_Openning_Time.Hour_From.Visible Then ' Hour_From %>
		<td<%= Category_Openning_Time.Hour_From.CellAttributes %>>
<span id="el<%= Category_Openning_Time_delete.RowCnt %>_Category_Openning_Time_Hour_From" class="form-group Category_Openning_Time_Hour_From">
<span<%= Category_Openning_Time.Hour_From.ViewAttributes %>>
<%= Category_Openning_Time.Hour_From.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Category_Openning_Time.Hour_To.Visible Then ' Hour_To %>
		<td<%= Category_Openning_Time.Hour_To.CellAttributes %>>
<span id="el<%= Category_Openning_Time_delete.RowCnt %>_Category_Openning_Time_Hour_To" class="form-group Category_Openning_Time_Hour_To">
<span<%= Category_Openning_Time.Hour_To.ViewAttributes %>>
<%= Category_Openning_Time.Hour_To.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Category_Openning_Time.DayValue.Visible Then ' DayValue %>
		<td<%= Category_Openning_Time.DayValue.CellAttributes %>>
<span id="el<%= Category_Openning_Time_delete.RowCnt %>_Category_Openning_Time_DayValue" class="form-group Category_Openning_Time_DayValue">
<span<%= Category_Openning_Time.DayValue.ViewAttributes %>>
<%= Category_Openning_Time.DayValue.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Category_Openning_Time.Dayname.Visible Then ' Dayname %>
		<td<%= Category_Openning_Time.Dayname.CellAttributes %>>
<span id="el<%= Category_Openning_Time_delete.RowCnt %>_Category_Openning_Time_Dayname" class="form-group Category_Openning_Time_Dayname">
<span<%= Category_Openning_Time.Dayname.ViewAttributes %>>
<%= Category_Openning_Time.Dayname.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Category_Openning_Time.status.Visible Then ' status %>
		<td<%= Category_Openning_Time.status.CellAttributes %>>
<span id="el<%= Category_Openning_Time_delete.RowCnt %>_Category_Openning_Time_status" class="form-group Category_Openning_Time_status">
<span<%= Category_Openning_Time.status.ViewAttributes %>>
<%= Category_Openning_Time.status.ListViewValue %>
</span>
</span>
</td>
<% End If %>
	</tr>
<%
	Category_Openning_Time_delete.Recordset.MoveNext
Loop
Category_Openning_Time_delete.Recordset.Close
Set Category_Openning_Time_delete.Recordset = Nothing
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
fCategory_Openning_Timedelete.Init();
</script>
<%
Category_Openning_Time_delete.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set Category_Openning_Time_delete = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cCategory_Openning_Time_delete

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
		TableName = "Category_Openning_Time"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "Category_Openning_Time_delete"
	End Property

	' Page Name
	Public Property Get PageName()
		PageName = ew_CurrentPage()
	End Property

	' Page Url
	Public Property Get PageUrl()
		PageUrl = ew_CurrentPage() & "?"
		If Category_Openning_Time.UseTokenInUrl Then PageUrl = PageUrl & "t=" & Category_Openning_Time.TableVar & "&" ' add page token
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
		If Category_Openning_Time.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (Category_Openning_Time.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (Category_Openning_Time.TableVar = Request.QueryString("t"))
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
		If IsEmpty(Category_Openning_Time) Then Set Category_Openning_Time = New cCategory_Openning_Time
		Set Table = Category_Openning_Time

		' Initialize urls
		' Initialize form object

		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "delete"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "Category_Openning_Time"

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
			results = Category_Openning_Time.GetAutoFill(Request.Form("name"), Request.Form("q"))
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
		If Not Category_Openning_Time Is Nothing Then
			If Category_Openning_Time.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = Category_Openning_Time.TableVar
				If Category_Openning_Time.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf Category_Openning_Time.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf Category_Openning_Time.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf Category_Openning_Time.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set Category_Openning_Time = Nothing
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
		RecKeys = Category_Openning_Time.GetRecordKeys() ' Load record keys
		sFilter = Category_Openning_Time.GetKeyFilter()
		If sFilter = "" Then
			Call Page_Terminate("Category_Openning_Timelist.asp") ' Prevent SQL injection, return to list
		End If

		' Set up filter (Sql Where Clause) and get Return Sql
		' Sql constructor in Category_Openning_Time class, Category_Openning_Timeinfo.asp

		Category_Openning_Time.CurrentFilter = sFilter

		' Get action
		If Request.Form("a_delete").Count > 0 Then
			Category_Openning_Time.CurrentAction = Request.Form("a_delete")
		Else
			Category_Openning_Time.CurrentAction = "D"	' Delete record directly
		End If
		Select Case Category_Openning_Time.CurrentAction
			Case "D" ' Delete
				Category_Openning_Time.SendEmail = True ' Send email on delete success
				If DeleteRows() Then ' Delete rows
					If SuccessMessage = "" Then SuccessMessage = Language.Phrase("DeleteSuccess") ' Set up success message
					Call Page_Terminate(Category_Openning_Time.ReturnUrl) ' Return to caller
				End If
		End Select
	End Sub

	' -----------------------------------------------------------------
	' Load recordset
	'
	Function LoadRecordset()

		' Load list page sql
		Dim sSql
		sSql = Category_Openning_Time.SelectSQL
		Call ew_SetDebugMsg("LoadRecordset: " & sSql) ' Show SQL for debugging

		' Load recordset
		Dim RsRecordset
		Set RsRecordset = ew_LoadRecordset(sSql)

		' Call Recordset Selected event
		Call Category_Openning_Time.Recordset_Selected(RsRecordset)
		Set LoadRecordset = RsRecordset
	End Function

	' -----------------------------------------------------------------
	' Load row based on key values
	'
	Function LoadRow()
		Dim RsRow, sSql, sFilter
		sFilter = Category_Openning_Time.KeyFilter

		' Call Row Selecting event
		Call Category_Openning_Time.Row_Selecting(sFilter)

		' Load sql based on filter
		Category_Openning_Time.CurrentFilter = sFilter
		sSql = Category_Openning_Time.SQL
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
		Call Category_Openning_Time.Row_Selected(RsRow)
		Category_Openning_Time.ID.DbValue = RsRow("ID")
		Category_Openning_Time.CategoryID.DbValue = RsRow("CategoryID")
		Category_Openning_Time.IdBusinessDetail.DbValue = RsRow("IdBusinessDetail")
		Category_Openning_Time.Hour_From.DbValue = RsRow("Hour_From")
		Category_Openning_Time.Hour_To.DbValue = RsRow("Hour_To")
		Category_Openning_Time.DayValue.DbValue = RsRow("DayValue")
		Category_Openning_Time.Dayname.DbValue = RsRow("Dayname")
		Category_Openning_Time.status.DbValue = RsRow("status")
	End Sub

	' Load DbValue from recordset
	Sub LoadDbValues(Rs)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		If Rs.Eof Then Exit Sub
		Category_Openning_Time.ID.m_DbValue = Rs("ID")
		Category_Openning_Time.CategoryID.m_DbValue = Rs("CategoryID")
		Category_Openning_Time.IdBusinessDetail.m_DbValue = Rs("IdBusinessDetail")
		Category_Openning_Time.Hour_From.m_DbValue = Rs("Hour_From")
		Category_Openning_Time.Hour_To.m_DbValue = Rs("Hour_To")
		Category_Openning_Time.DayValue.m_DbValue = Rs("DayValue")
		Category_Openning_Time.Dayname.m_DbValue = Rs("Dayname")
		Category_Openning_Time.status.m_DbValue = Rs("status")
	End Sub

	' -----------------------------------------------------------------
	' Render row values based on field settings
	'
	Sub RenderRow()

		' Initialize urls
		' Call Row Rendering event

		Call Category_Openning_Time.Row_Rendering()

		' ---------------------------------------
		'  Common render codes for all row types
		' ---------------------------------------
		' ID
		' CategoryID
		' IdBusinessDetail
		' Hour_From
		' Hour_To
		' DayValue
		' Dayname
		' status
		' -----------
		'  View  Row
		' -----------

		If Category_Openning_Time.RowType = EW_ROWTYPE_VIEW Then ' View row

			' ID
			Category_Openning_Time.ID.ViewValue = Category_Openning_Time.ID.CurrentValue
			Category_Openning_Time.ID.ViewCustomAttributes = ""

			' CategoryID
			Category_Openning_Time.CategoryID.ViewValue = Category_Openning_Time.CategoryID.CurrentValue
			Category_Openning_Time.CategoryID.ViewCustomAttributes = ""

			' IdBusinessDetail
			Category_Openning_Time.IdBusinessDetail.ViewValue = Category_Openning_Time.IdBusinessDetail.CurrentValue
			Category_Openning_Time.IdBusinessDetail.ViewCustomAttributes = ""

			' Hour_From
			Category_Openning_Time.Hour_From.ViewValue = Category_Openning_Time.Hour_From.CurrentValue
			Category_Openning_Time.Hour_From.ViewCustomAttributes = ""

			' Hour_To
			Category_Openning_Time.Hour_To.ViewValue = Category_Openning_Time.Hour_To.CurrentValue
			Category_Openning_Time.Hour_To.ViewCustomAttributes = ""

			' DayValue
			Category_Openning_Time.DayValue.ViewValue = Category_Openning_Time.DayValue.CurrentValue
			Category_Openning_Time.DayValue.ViewCustomAttributes = ""

			' Dayname
			Category_Openning_Time.Dayname.ViewValue = Category_Openning_Time.Dayname.CurrentValue
			Category_Openning_Time.Dayname.ViewCustomAttributes = ""

			' status
			Category_Openning_Time.status.ViewValue = Category_Openning_Time.status.CurrentValue
			Category_Openning_Time.status.ViewCustomAttributes = ""

			' View refer script
			' ID

			Category_Openning_Time.ID.LinkCustomAttributes = ""
			Category_Openning_Time.ID.HrefValue = ""
			Category_Openning_Time.ID.TooltipValue = ""

			' CategoryID
			Category_Openning_Time.CategoryID.LinkCustomAttributes = ""
			Category_Openning_Time.CategoryID.HrefValue = ""
			Category_Openning_Time.CategoryID.TooltipValue = ""

			' IdBusinessDetail
			Category_Openning_Time.IdBusinessDetail.LinkCustomAttributes = ""
			Category_Openning_Time.IdBusinessDetail.HrefValue = ""
			Category_Openning_Time.IdBusinessDetail.TooltipValue = ""

			' Hour_From
			Category_Openning_Time.Hour_From.LinkCustomAttributes = ""
			Category_Openning_Time.Hour_From.HrefValue = ""
			Category_Openning_Time.Hour_From.TooltipValue = ""

			' Hour_To
			Category_Openning_Time.Hour_To.LinkCustomAttributes = ""
			Category_Openning_Time.Hour_To.HrefValue = ""
			Category_Openning_Time.Hour_To.TooltipValue = ""

			' DayValue
			Category_Openning_Time.DayValue.LinkCustomAttributes = ""
			Category_Openning_Time.DayValue.HrefValue = ""
			Category_Openning_Time.DayValue.TooltipValue = ""

			' Dayname
			Category_Openning_Time.Dayname.LinkCustomAttributes = ""
			Category_Openning_Time.Dayname.HrefValue = ""
			Category_Openning_Time.Dayname.TooltipValue = ""

			' status
			Category_Openning_Time.status.LinkCustomAttributes = ""
			Category_Openning_Time.status.HrefValue = ""
			Category_Openning_Time.status.TooltipValue = ""
		End If

		' Call Row Rendered event
		If Category_Openning_Time.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call Category_Openning_Time.Row_Rendered()
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
		sSql = Category_Openning_Time.SQL
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
				DeleteRows = Category_Openning_Time.Row_Deleting(RsDelete)
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
			ElseIf Category_Openning_Time.CancelMessage <> "" Then
				FailureMessage = Category_Openning_Time.CancelMessage
				Category_Openning_Time.CancelMessage = ""
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
				Call Category_Openning_Time.Row_Deleted(RsOld)
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
		Call Breadcrumb.Add("list", Category_Openning_Time.TableVar, "Category_Openning_Timelist.asp", "", Category_Openning_Time.TableVar, True)
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
