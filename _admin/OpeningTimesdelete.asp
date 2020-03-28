<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="OpeningTimesinfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim OpeningTimes_delete
Set OpeningTimes_delete = New cOpeningTimes_delete
Set Page = OpeningTimes_delete

' Page init processing
OpeningTimes_delete.Page_Init()

' Page main processing
OpeningTimes_delete.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
OpeningTimes_delete.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var OpeningTimes_delete = new ew_Page("OpeningTimes_delete");
OpeningTimes_delete.PageID = "delete"; // Page ID
var EW_PAGE_ID = OpeningTimes_delete.PageID; // For backward compatibility
// Form object
var fOpeningTimesdelete = new ew_Form("fOpeningTimesdelete");
// Form_CustomValidate event
fOpeningTimesdelete.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fOpeningTimesdelete.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fOpeningTimesdelete.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<%

' Load records for display
Set OpeningTimes_delete.Recordset = OpeningTimes_delete.LoadRecordset()
OpeningTimes_delete.TotalRecs = OpeningTimes_delete.Recordset.RecordCount ' Get record count
If OpeningTimes_delete.TotalRecs <= 0 Then ' No record found, exit
	OpeningTimes_delete.Recordset.Close
	Set OpeningTimes_delete.Recordset = Nothing
	Call OpeningTimes_delete.Page_Terminate("OpeningTimeslist.asp") ' Return to list
End If
%>
<div class="ewToolbar">
<% If OpeningTimes.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If OpeningTimes.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% OpeningTimes_delete.ShowPageHeader() %>
<% OpeningTimes_delete.ShowMessage %>
<form name="fOpeningTimesdelete" id="fOpeningTimesdelete" class="form-inline ewForm ewDeleteForm" action="<%= ew_CurrentPage() %>" method="post">
<% If OpeningTimes_delete.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= OpeningTimes_delete.Token %>">
<% End If %>
<input type="hidden" name="t" value="OpeningTimes">
<input type="hidden" name="a_delete" id="a_delete" value="D">
<% For i = 0 to UBound(OpeningTimes_delete.RecKeys) %>
<input type="hidden" name="key_m" id="key_m" value="<%= ew_HtmlEncode(ew_GetKeyValue(OpeningTimes_delete.RecKeys(i))) %>">
<% Next %>
<div class="ewGrid">
<div class="<% If ew_IsResponsiveLayout() Then Response.Write "table-responsive " %>ewGridMiddlePanel">
<table class="table ewTable">
<%= OpeningTimes.TableCustomInnerHtml %>
	<thead>
	<tr class="ewTableHeader">
<% If OpeningTimes.ID.Visible Then ' ID %>
		<th><span id="elh_OpeningTimes_ID" class="OpeningTimes_ID"><%= OpeningTimes.ID.FldCaption %></span></th>
<% End If %>
<% If OpeningTimes.DayOfWeek.Visible Then ' DayOfWeek %>
		<th><span id="elh_OpeningTimes_DayOfWeek" class="OpeningTimes_DayOfWeek"><%= OpeningTimes.DayOfWeek.FldCaption %></span></th>
<% End If %>
<% If OpeningTimes.Hour_From.Visible Then ' Hour_From %>
		<th><span id="elh_OpeningTimes_Hour_From" class="OpeningTimes_Hour_From"><%= OpeningTimes.Hour_From.FldCaption %></span></th>
<% End If %>
<% If OpeningTimes.Hour_To.Visible Then ' Hour_To %>
		<th><span id="elh_OpeningTimes_Hour_To" class="OpeningTimes_Hour_To"><%= OpeningTimes.Hour_To.FldCaption %></span></th>
<% End If %>
<% If OpeningTimes.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
		<th><span id="elh_OpeningTimes_IdBusinessDetail" class="OpeningTimes_IdBusinessDetail"><%= OpeningTimes.IdBusinessDetail.FldCaption %></span></th>
<% End If %>
<% If OpeningTimes.delivery.Visible Then ' delivery %>
		<th><span id="elh_OpeningTimes_delivery" class="OpeningTimes_delivery"><%= OpeningTimes.delivery.FldCaption %></span></th>
<% End If %>
<% If OpeningTimes.collection.Visible Then ' collection %>
		<th><span id="elh_OpeningTimes_collection" class="OpeningTimes_collection"><%= OpeningTimes.collection.FldCaption %></span></th>
<% End If %>
<% If OpeningTimes.MinAcceptOrderBeforeClose.Visible Then ' MinAcceptOrderBeforeClose %>
		<th><span id="elh_OpeningTimes_MinAcceptOrderBeforeClose" class="OpeningTimes_MinAcceptOrderBeforeClose"><%= OpeningTimes.MinAcceptOrderBeforeClose.FldCaption %></span></th>
<% End If %>
	</tr>
	</thead>
	<tbody>
<%
OpeningTimes_delete.RecCnt = 0
OpeningTimes_delete.RowCnt = 0
Do While (Not OpeningTimes_delete.Recordset.Eof)
	OpeningTimes_delete.RecCnt = OpeningTimes_delete.RecCnt + 1
	OpeningTimes_delete.RowCnt = OpeningTimes_delete.RowCnt + 1

	' Set row properties
	Call OpeningTimes.ResetAttrs()
	OpeningTimes.RowType = EW_ROWTYPE_VIEW ' view

	' Get the field contents
	Call OpeningTimes_delete.LoadRowValues(OpeningTimes_delete.Recordset)

	' Render row
	Call OpeningTimes_delete.RenderRow()
%>
	<tr<%= OpeningTimes.RowAttributes %>>
<% If OpeningTimes.ID.Visible Then ' ID %>
		<td<%= OpeningTimes.ID.CellAttributes %>>
<span id="el<%= OpeningTimes_delete.RowCnt %>_OpeningTimes_ID" class="form-group OpeningTimes_ID">
<span<%= OpeningTimes.ID.ViewAttributes %>>
<%= OpeningTimes.ID.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OpeningTimes.DayOfWeek.Visible Then ' DayOfWeek %>
		<td<%= OpeningTimes.DayOfWeek.CellAttributes %>>
<span id="el<%= OpeningTimes_delete.RowCnt %>_OpeningTimes_DayOfWeek" class="form-group OpeningTimes_DayOfWeek">
<span<%= OpeningTimes.DayOfWeek.ViewAttributes %>>
<%= OpeningTimes.DayOfWeek.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OpeningTimes.Hour_From.Visible Then ' Hour_From %>
		<td<%= OpeningTimes.Hour_From.CellAttributes %>>
<span id="el<%= OpeningTimes_delete.RowCnt %>_OpeningTimes_Hour_From" class="form-group OpeningTimes_Hour_From">
<span<%= OpeningTimes.Hour_From.ViewAttributes %>>
<%= OpeningTimes.Hour_From.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OpeningTimes.Hour_To.Visible Then ' Hour_To %>
		<td<%= OpeningTimes.Hour_To.CellAttributes %>>
<span id="el<%= OpeningTimes_delete.RowCnt %>_OpeningTimes_Hour_To" class="form-group OpeningTimes_Hour_To">
<span<%= OpeningTimes.Hour_To.ViewAttributes %>>
<%= OpeningTimes.Hour_To.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OpeningTimes.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
		<td<%= OpeningTimes.IdBusinessDetail.CellAttributes %>>
<span id="el<%= OpeningTimes_delete.RowCnt %>_OpeningTimes_IdBusinessDetail" class="form-group OpeningTimes_IdBusinessDetail">
<span<%= OpeningTimes.IdBusinessDetail.ViewAttributes %>>
<%= OpeningTimes.IdBusinessDetail.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OpeningTimes.delivery.Visible Then ' delivery %>
		<td<%= OpeningTimes.delivery.CellAttributes %>>
<span id="el<%= OpeningTimes_delete.RowCnt %>_OpeningTimes_delivery" class="form-group OpeningTimes_delivery">
<span<%= OpeningTimes.delivery.ViewAttributes %>>
<%= OpeningTimes.delivery.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OpeningTimes.collection.Visible Then ' collection %>
		<td<%= OpeningTimes.collection.CellAttributes %>>
<span id="el<%= OpeningTimes_delete.RowCnt %>_OpeningTimes_collection" class="form-group OpeningTimes_collection">
<span<%= OpeningTimes.collection.ViewAttributes %>>
<%= OpeningTimes.collection.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OpeningTimes.MinAcceptOrderBeforeClose.Visible Then ' MinAcceptOrderBeforeClose %>
		<td<%= OpeningTimes.MinAcceptOrderBeforeClose.CellAttributes %>>
<span id="el<%= OpeningTimes_delete.RowCnt %>_OpeningTimes_MinAcceptOrderBeforeClose" class="form-group OpeningTimes_MinAcceptOrderBeforeClose">
<span<%= OpeningTimes.MinAcceptOrderBeforeClose.ViewAttributes %>>
<%= OpeningTimes.MinAcceptOrderBeforeClose.ListViewValue %>
</span>
</span>
</td>
<% End If %>
	</tr>
<%
	OpeningTimes_delete.Recordset.MoveNext
Loop
OpeningTimes_delete.Recordset.Close
Set OpeningTimes_delete.Recordset = Nothing
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
fOpeningTimesdelete.Init();
</script>
<%
OpeningTimes_delete.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set OpeningTimes_delete = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cOpeningTimes_delete

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
		TableName = "OpeningTimes"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "OpeningTimes_delete"
	End Property

	' Page Name
	Public Property Get PageName()
		PageName = ew_CurrentPage()
	End Property

	' Page Url
	Public Property Get PageUrl()
		PageUrl = ew_CurrentPage() & "?"
		If OpeningTimes.UseTokenInUrl Then PageUrl = PageUrl & "t=" & OpeningTimes.TableVar & "&" ' add page token
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
		If OpeningTimes.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (OpeningTimes.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (OpeningTimes.TableVar = Request.QueryString("t"))
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
		If IsEmpty(OpeningTimes) Then Set OpeningTimes = New cOpeningTimes
		Set Table = OpeningTimes

		' Initialize urls
		' Initialize form object

		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "delete"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "OpeningTimes"

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
			results = OpeningTimes.GetAutoFill(Request.Form("name"), Request.Form("q"))
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
		If Not OpeningTimes Is Nothing Then
			If OpeningTimes.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = OpeningTimes.TableVar
				If OpeningTimes.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf OpeningTimes.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf OpeningTimes.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf OpeningTimes.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set OpeningTimes = Nothing
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
		RecKeys = OpeningTimes.GetRecordKeys() ' Load record keys
		sFilter = OpeningTimes.GetKeyFilter()
		If sFilter = "" Then
			Call Page_Terminate("OpeningTimeslist.asp") ' Prevent SQL injection, return to list
		End If

		' Set up filter (Sql Where Clause) and get Return Sql
		' Sql constructor in OpeningTimes class, OpeningTimesinfo.asp

		OpeningTimes.CurrentFilter = sFilter

		' Get action
		If Request.Form("a_delete").Count > 0 Then
			OpeningTimes.CurrentAction = Request.Form("a_delete")
		Else
			OpeningTimes.CurrentAction = "D"	' Delete record directly
		End If
		Select Case OpeningTimes.CurrentAction
			Case "D" ' Delete
				OpeningTimes.SendEmail = True ' Send email on delete success
				If DeleteRows() Then ' Delete rows
					If SuccessMessage = "" Then SuccessMessage = Language.Phrase("DeleteSuccess") ' Set up success message
					Call Page_Terminate(OpeningTimes.ReturnUrl) ' Return to caller
				End If
		End Select
	End Sub

	' -----------------------------------------------------------------
	' Load recordset
	'
	Function LoadRecordset()

		' Load list page sql
		Dim sSql
		sSql = OpeningTimes.SelectSQL
		Call ew_SetDebugMsg("LoadRecordset: " & sSql) ' Show SQL for debugging

		' Load recordset
		Dim RsRecordset
		Set RsRecordset = ew_LoadRecordset(sSql)

		' Call Recordset Selected event
		Call OpeningTimes.Recordset_Selected(RsRecordset)
		Set LoadRecordset = RsRecordset
	End Function

	' -----------------------------------------------------------------
	' Load row based on key values
	'
	Function LoadRow()
		Dim RsRow, sSql, sFilter
		sFilter = OpeningTimes.KeyFilter

		' Call Row Selecting event
		Call OpeningTimes.Row_Selecting(sFilter)

		' Load sql based on filter
		OpeningTimes.CurrentFilter = sFilter
		sSql = OpeningTimes.SQL
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
		Call OpeningTimes.Row_Selected(RsRow)
		OpeningTimes.ID.DbValue = RsRow("ID")
		OpeningTimes.DayOfWeek.DbValue = RsRow("DayOfWeek")
		OpeningTimes.Hour_From.DbValue = RsRow("Hour_From")
		OpeningTimes.Hour_To.DbValue = RsRow("Hour_To")
		OpeningTimes.IdBusinessDetail.DbValue = RsRow("IdBusinessDetail")
		OpeningTimes.delivery.DbValue = RsRow("delivery")
		OpeningTimes.collection.DbValue = RsRow("collection")
		OpeningTimes.MinAcceptOrderBeforeClose.DbValue = ew_Conv(RsRow("MinAcceptOrderBeforeClose"), 131)
	End Sub

	' Load DbValue from recordset
	Sub LoadDbValues(Rs)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		If Rs.Eof Then Exit Sub
		OpeningTimes.ID.m_DbValue = Rs("ID")
		OpeningTimes.DayOfWeek.m_DbValue = Rs("DayOfWeek")
		OpeningTimes.Hour_From.m_DbValue = Rs("Hour_From")
		OpeningTimes.Hour_To.m_DbValue = Rs("Hour_To")
		OpeningTimes.IdBusinessDetail.m_DbValue = Rs("IdBusinessDetail")
		OpeningTimes.delivery.m_DbValue = Rs("delivery")
		OpeningTimes.collection.m_DbValue = Rs("collection")
		OpeningTimes.MinAcceptOrderBeforeClose.m_DbValue = ew_Conv(Rs("MinAcceptOrderBeforeClose"), 131)
	End Sub

	' -----------------------------------------------------------------
	' Render row values based on field settings
	'
	Sub RenderRow()

		' Initialize urls
		' Convert decimal values if posted back

		If OpeningTimes.MinAcceptOrderBeforeClose.CurrentValue & "" <> "" Then OpeningTimes.MinAcceptOrderBeforeClose.CurrentValue = ew_Conv(OpeningTimes.MinAcceptOrderBeforeClose.CurrentValue, OpeningTimes.MinAcceptOrderBeforeClose.FldType)
		If OpeningTimes.MinAcceptOrderBeforeClose.FormValue = OpeningTimes.MinAcceptOrderBeforeClose.CurrentValue And IsNumeric(OpeningTimes.MinAcceptOrderBeforeClose.CurrentValue) Then
			OpeningTimes.MinAcceptOrderBeforeClose.CurrentValue = ew_StrToFloat(OpeningTimes.MinAcceptOrderBeforeClose.CurrentValue)
		End If

		' Call Row Rendering event
		Call OpeningTimes.Row_Rendering()

		' ---------------------------------------
		'  Common render codes for all row types
		' ---------------------------------------
		' ID
		' DayOfWeek
		' Hour_From
		' Hour_To
		' IdBusinessDetail
		' delivery
		' collection
		' MinAcceptOrderBeforeClose
		' -----------
		'  View  Row
		' -----------

		If OpeningTimes.RowType = EW_ROWTYPE_VIEW Then ' View row

			' ID
			OpeningTimes.ID.ViewValue = OpeningTimes.ID.CurrentValue
			OpeningTimes.ID.ViewCustomAttributes = ""

			' DayOfWeek
			OpeningTimes.DayOfWeek.ViewValue = OpeningTimes.DayOfWeek.CurrentValue
			OpeningTimes.DayOfWeek.ViewCustomAttributes = ""

			' Hour_From
			OpeningTimes.Hour_From.ViewValue = OpeningTimes.Hour_From.CurrentValue
			OpeningTimes.Hour_From.ViewCustomAttributes = ""

			' Hour_To
			OpeningTimes.Hour_To.ViewValue = OpeningTimes.Hour_To.CurrentValue
			OpeningTimes.Hour_To.ViewCustomAttributes = ""

			' IdBusinessDetail
			OpeningTimes.IdBusinessDetail.ViewValue = OpeningTimes.IdBusinessDetail.CurrentValue
			OpeningTimes.IdBusinessDetail.ViewCustomAttributes = ""

			' delivery
			OpeningTimes.delivery.ViewValue = OpeningTimes.delivery.CurrentValue
			OpeningTimes.delivery.ViewCustomAttributes = ""

			' collection
			OpeningTimes.collection.ViewValue = OpeningTimes.collection.CurrentValue
			OpeningTimes.collection.ViewCustomAttributes = ""

			' MinAcceptOrderBeforeClose
			OpeningTimes.MinAcceptOrderBeforeClose.ViewValue = OpeningTimes.MinAcceptOrderBeforeClose.CurrentValue
			OpeningTimes.MinAcceptOrderBeforeClose.ViewCustomAttributes = ""

			' View refer script
			' ID

			OpeningTimes.ID.LinkCustomAttributes = ""
			OpeningTimes.ID.HrefValue = ""
			OpeningTimes.ID.TooltipValue = ""

			' DayOfWeek
			OpeningTimes.DayOfWeek.LinkCustomAttributes = ""
			OpeningTimes.DayOfWeek.HrefValue = ""
			OpeningTimes.DayOfWeek.TooltipValue = ""

			' Hour_From
			OpeningTimes.Hour_From.LinkCustomAttributes = ""
			OpeningTimes.Hour_From.HrefValue = ""
			OpeningTimes.Hour_From.TooltipValue = ""

			' Hour_To
			OpeningTimes.Hour_To.LinkCustomAttributes = ""
			OpeningTimes.Hour_To.HrefValue = ""
			OpeningTimes.Hour_To.TooltipValue = ""

			' IdBusinessDetail
			OpeningTimes.IdBusinessDetail.LinkCustomAttributes = ""
			OpeningTimes.IdBusinessDetail.HrefValue = ""
			OpeningTimes.IdBusinessDetail.TooltipValue = ""

			' delivery
			OpeningTimes.delivery.LinkCustomAttributes = ""
			OpeningTimes.delivery.HrefValue = ""
			OpeningTimes.delivery.TooltipValue = ""

			' collection
			OpeningTimes.collection.LinkCustomAttributes = ""
			OpeningTimes.collection.HrefValue = ""
			OpeningTimes.collection.TooltipValue = ""

			' MinAcceptOrderBeforeClose
			OpeningTimes.MinAcceptOrderBeforeClose.LinkCustomAttributes = ""
			OpeningTimes.MinAcceptOrderBeforeClose.HrefValue = ""
			OpeningTimes.MinAcceptOrderBeforeClose.TooltipValue = ""
		End If

		' Call Row Rendered event
		If OpeningTimes.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call OpeningTimes.Row_Rendered()
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
		sSql = OpeningTimes.SQL
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
				DeleteRows = OpeningTimes.Row_Deleting(RsDelete)
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
			ElseIf OpeningTimes.CancelMessage <> "" Then
				FailureMessage = OpeningTimes.CancelMessage
				OpeningTimes.CancelMessage = ""
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
				Call OpeningTimes.Row_Deleted(RsOld)
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
		Call Breadcrumb.Add("list", OpeningTimes.TableVar, "OpeningTimeslist.asp", "", OpeningTimes.TableVar, True)
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
