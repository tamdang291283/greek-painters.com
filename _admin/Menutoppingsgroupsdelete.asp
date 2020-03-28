<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="Menutoppingsgroupsinfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim Menutoppingsgroups_delete
Set Menutoppingsgroups_delete = New cMenutoppingsgroups_delete
Set Page = Menutoppingsgroups_delete

' Page init processing
Menutoppingsgroups_delete.Page_Init()

' Page main processing
Menutoppingsgroups_delete.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
Menutoppingsgroups_delete.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var Menutoppingsgroups_delete = new ew_Page("Menutoppingsgroups_delete");
Menutoppingsgroups_delete.PageID = "delete"; // Page ID
var EW_PAGE_ID = Menutoppingsgroups_delete.PageID; // For backward compatibility
// Form object
var fMenutoppingsgroupsdelete = new ew_Form("fMenutoppingsgroupsdelete");
// Form_CustomValidate event
fMenutoppingsgroupsdelete.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fMenutoppingsgroupsdelete.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fMenutoppingsgroupsdelete.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<%

' Load records for display
Set Menutoppingsgroups_delete.Recordset = Menutoppingsgroups_delete.LoadRecordset()
Menutoppingsgroups_delete.TotalRecs = Menutoppingsgroups_delete.Recordset.RecordCount ' Get record count
If Menutoppingsgroups_delete.TotalRecs <= 0 Then ' No record found, exit
	Menutoppingsgroups_delete.Recordset.Close
	Set Menutoppingsgroups_delete.Recordset = Nothing
	Call Menutoppingsgroups_delete.Page_Terminate("Menutoppingsgroupslist.asp") ' Return to list
End If
%>
<div class="ewToolbar">
<% If Menutoppingsgroups.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If Menutoppingsgroups.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% Menutoppingsgroups_delete.ShowPageHeader() %>
<% Menutoppingsgroups_delete.ShowMessage %>
<form name="fMenutoppingsgroupsdelete" id="fMenutoppingsgroupsdelete" class="form-inline ewForm ewDeleteForm" action="<%= ew_CurrentPage() %>" method="post">
<% If Menutoppingsgroups_delete.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= Menutoppingsgroups_delete.Token %>">
<% End If %>
<input type="hidden" name="t" value="Menutoppingsgroups">
<input type="hidden" name="a_delete" id="a_delete" value="D">
<% For i = 0 to UBound(Menutoppingsgroups_delete.RecKeys) %>
<input type="hidden" name="key_m" id="key_m" value="<%= ew_HtmlEncode(ew_GetKeyValue(Menutoppingsgroups_delete.RecKeys(i))) %>">
<% Next %>
<div class="ewGrid">
<div class="<% If ew_IsResponsiveLayout() Then Response.Write "table-responsive " %>ewGridMiddlePanel">
<table class="table ewTable">
<%= Menutoppingsgroups.TableCustomInnerHtml %>
	<thead>
	<tr class="ewTableHeader">
<% If Menutoppingsgroups.ID.Visible Then ' ID %>
		<th><span id="elh_Menutoppingsgroups_ID" class="Menutoppingsgroups_ID"><%= Menutoppingsgroups.ID.FldCaption %></span></th>
<% End If %>
<% If Menutoppingsgroups.toppingsgroup.Visible Then ' toppingsgroup %>
		<th><span id="elh_Menutoppingsgroups_toppingsgroup" class="Menutoppingsgroups_toppingsgroup"><%= Menutoppingsgroups.toppingsgroup.FldCaption %></span></th>
<% End If %>
<% If Menutoppingsgroups.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
		<th><span id="elh_Menutoppingsgroups_IdBusinessDetail" class="Menutoppingsgroups_IdBusinessDetail"><%= Menutoppingsgroups.IdBusinessDetail.FldCaption %></span></th>
<% End If %>
<% If Menutoppingsgroups.printingname.Visible Then ' printingname %>
		<th><span id="elh_Menutoppingsgroups_printingname" class="Menutoppingsgroups_printingname"><%= Menutoppingsgroups.printingname.FldCaption %></span></th>
<% End If %>
<% If Menutoppingsgroups.i_displaySort.Visible Then ' i_displaySort %>
		<th><span id="elh_Menutoppingsgroups_i_displaySort" class="Menutoppingsgroups_i_displaySort"><%= Menutoppingsgroups.i_displaySort.FldCaption %></span></th>
<% End If %>
	</tr>
	</thead>
	<tbody>
<%
Menutoppingsgroups_delete.RecCnt = 0
Menutoppingsgroups_delete.RowCnt = 0
Do While (Not Menutoppingsgroups_delete.Recordset.Eof)
	Menutoppingsgroups_delete.RecCnt = Menutoppingsgroups_delete.RecCnt + 1
	Menutoppingsgroups_delete.RowCnt = Menutoppingsgroups_delete.RowCnt + 1

	' Set row properties
	Call Menutoppingsgroups.ResetAttrs()
	Menutoppingsgroups.RowType = EW_ROWTYPE_VIEW ' view

	' Get the field contents
	Call Menutoppingsgroups_delete.LoadRowValues(Menutoppingsgroups_delete.Recordset)

	' Render row
	Call Menutoppingsgroups_delete.RenderRow()
%>
	<tr<%= Menutoppingsgroups.RowAttributes %>>
<% If Menutoppingsgroups.ID.Visible Then ' ID %>
		<td<%= Menutoppingsgroups.ID.CellAttributes %>>
<span id="el<%= Menutoppingsgroups_delete.RowCnt %>_Menutoppingsgroups_ID" class="form-group Menutoppingsgroups_ID">
<span<%= Menutoppingsgroups.ID.ViewAttributes %>>
<%= Menutoppingsgroups.ID.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Menutoppingsgroups.toppingsgroup.Visible Then ' toppingsgroup %>
		<td<%= Menutoppingsgroups.toppingsgroup.CellAttributes %>>
<span id="el<%= Menutoppingsgroups_delete.RowCnt %>_Menutoppingsgroups_toppingsgroup" class="form-group Menutoppingsgroups_toppingsgroup">
<span<%= Menutoppingsgroups.toppingsgroup.ViewAttributes %>>
<%= Menutoppingsgroups.toppingsgroup.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Menutoppingsgroups.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
		<td<%= Menutoppingsgroups.IdBusinessDetail.CellAttributes %>>
<span id="el<%= Menutoppingsgroups_delete.RowCnt %>_Menutoppingsgroups_IdBusinessDetail" class="form-group Menutoppingsgroups_IdBusinessDetail">
<span<%= Menutoppingsgroups.IdBusinessDetail.ViewAttributes %>>
<%= Menutoppingsgroups.IdBusinessDetail.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Menutoppingsgroups.printingname.Visible Then ' printingname %>
		<td<%= Menutoppingsgroups.printingname.CellAttributes %>>
<span id="el<%= Menutoppingsgroups_delete.RowCnt %>_Menutoppingsgroups_printingname" class="form-group Menutoppingsgroups_printingname">
<span<%= Menutoppingsgroups.printingname.ViewAttributes %>>
<%= Menutoppingsgroups.printingname.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Menutoppingsgroups.i_displaySort.Visible Then ' i_displaySort %>
		<td<%= Menutoppingsgroups.i_displaySort.CellAttributes %>>
<span id="el<%= Menutoppingsgroups_delete.RowCnt %>_Menutoppingsgroups_i_displaySort" class="form-group Menutoppingsgroups_i_displaySort">
<span<%= Menutoppingsgroups.i_displaySort.ViewAttributes %>>
<%= Menutoppingsgroups.i_displaySort.ListViewValue %>
</span>
</span>
</td>
<% End If %>
	</tr>
<%
	Menutoppingsgroups_delete.Recordset.MoveNext
Loop
Menutoppingsgroups_delete.Recordset.Close
Set Menutoppingsgroups_delete.Recordset = Nothing
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
fMenutoppingsgroupsdelete.Init();
</script>
<%
Menutoppingsgroups_delete.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set Menutoppingsgroups_delete = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cMenutoppingsgroups_delete

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
		TableName = "Menutoppingsgroups"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "Menutoppingsgroups_delete"
	End Property

	' Page Name
	Public Property Get PageName()
		PageName = ew_CurrentPage()
	End Property

	' Page Url
	Public Property Get PageUrl()
		PageUrl = ew_CurrentPage() & "?"
		If Menutoppingsgroups.UseTokenInUrl Then PageUrl = PageUrl & "t=" & Menutoppingsgroups.TableVar & "&" ' add page token
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
		If Menutoppingsgroups.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (Menutoppingsgroups.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (Menutoppingsgroups.TableVar = Request.QueryString("t"))
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
		If IsEmpty(Menutoppingsgroups) Then Set Menutoppingsgroups = New cMenutoppingsgroups
		Set Table = Menutoppingsgroups

		' Initialize urls
		' Initialize form object

		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "delete"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "Menutoppingsgroups"

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
			results = Menutoppingsgroups.GetAutoFill(Request.Form("name"), Request.Form("q"))
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
		If Not Menutoppingsgroups Is Nothing Then
			If Menutoppingsgroups.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = Menutoppingsgroups.TableVar
				If Menutoppingsgroups.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf Menutoppingsgroups.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf Menutoppingsgroups.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf Menutoppingsgroups.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set Menutoppingsgroups = Nothing
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
		RecKeys = Menutoppingsgroups.GetRecordKeys() ' Load record keys
		sFilter = Menutoppingsgroups.GetKeyFilter()
		If sFilter = "" Then
			Call Page_Terminate("Menutoppingsgroupslist.asp") ' Prevent SQL injection, return to list
		End If

		' Set up filter (Sql Where Clause) and get Return Sql
		' Sql constructor in Menutoppingsgroups class, Menutoppingsgroupsinfo.asp

		Menutoppingsgroups.CurrentFilter = sFilter

		' Get action
		If Request.Form("a_delete").Count > 0 Then
			Menutoppingsgroups.CurrentAction = Request.Form("a_delete")
		Else
			Menutoppingsgroups.CurrentAction = "D"	' Delete record directly
		End If
		Select Case Menutoppingsgroups.CurrentAction
			Case "D" ' Delete
				Menutoppingsgroups.SendEmail = True ' Send email on delete success
				If DeleteRows() Then ' Delete rows
					If SuccessMessage = "" Then SuccessMessage = Language.Phrase("DeleteSuccess") ' Set up success message
					Call Page_Terminate(Menutoppingsgroups.ReturnUrl) ' Return to caller
				End If
		End Select
	End Sub

	' -----------------------------------------------------------------
	' Load recordset
	'
	Function LoadRecordset()

		' Load list page sql
		Dim sSql
		sSql = Menutoppingsgroups.SelectSQL
		Call ew_SetDebugMsg("LoadRecordset: " & sSql) ' Show SQL for debugging

		' Load recordset
		Dim RsRecordset
		Set RsRecordset = ew_LoadRecordset(sSql)

		' Call Recordset Selected event
		Call Menutoppingsgroups.Recordset_Selected(RsRecordset)
		Set LoadRecordset = RsRecordset
	End Function

	' -----------------------------------------------------------------
	' Load row based on key values
	'
	Function LoadRow()
		Dim RsRow, sSql, sFilter
		sFilter = Menutoppingsgroups.KeyFilter

		' Call Row Selecting event
		Call Menutoppingsgroups.Row_Selecting(sFilter)

		' Load sql based on filter
		Menutoppingsgroups.CurrentFilter = sFilter
		sSql = Menutoppingsgroups.SQL
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
		Call Menutoppingsgroups.Row_Selected(RsRow)
		Menutoppingsgroups.ID.DbValue = RsRow("ID")
		Menutoppingsgroups.toppingsgroup.DbValue = RsRow("toppingsgroup")
		Menutoppingsgroups.IdBusinessDetail.DbValue = RsRow("IdBusinessDetail")
		Menutoppingsgroups.printingname.DbValue = RsRow("printingname")
		Menutoppingsgroups.i_displaySort.DbValue = RsRow("i_displaySort")
	End Sub

	' Load DbValue from recordset
	Sub LoadDbValues(Rs)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		If Rs.Eof Then Exit Sub
		Menutoppingsgroups.ID.m_DbValue = Rs("ID")
		Menutoppingsgroups.toppingsgroup.m_DbValue = Rs("toppingsgroup")
		Menutoppingsgroups.IdBusinessDetail.m_DbValue = Rs("IdBusinessDetail")
		Menutoppingsgroups.printingname.m_DbValue = Rs("printingname")
		Menutoppingsgroups.i_displaySort.m_DbValue = Rs("i_displaySort")
	End Sub

	' -----------------------------------------------------------------
	' Render row values based on field settings
	'
	Sub RenderRow()

		' Initialize urls
		' Call Row Rendering event

		Call Menutoppingsgroups.Row_Rendering()

		' ---------------------------------------
		'  Common render codes for all row types
		' ---------------------------------------
		' ID
		' toppingsgroup
		' IdBusinessDetail
		' printingname
		' i_displaySort
		' -----------
		'  View  Row
		' -----------

		If Menutoppingsgroups.RowType = EW_ROWTYPE_VIEW Then ' View row

			' ID
			Menutoppingsgroups.ID.ViewValue = Menutoppingsgroups.ID.CurrentValue
			Menutoppingsgroups.ID.ViewCustomAttributes = ""

			' toppingsgroup
			Menutoppingsgroups.toppingsgroup.ViewValue = Menutoppingsgroups.toppingsgroup.CurrentValue
			Menutoppingsgroups.toppingsgroup.ViewCustomAttributes = ""

			' IdBusinessDetail
			Menutoppingsgroups.IdBusinessDetail.ViewValue = Menutoppingsgroups.IdBusinessDetail.CurrentValue
			Menutoppingsgroups.IdBusinessDetail.ViewCustomAttributes = ""

			' printingname
			Menutoppingsgroups.printingname.ViewValue = Menutoppingsgroups.printingname.CurrentValue
			Menutoppingsgroups.printingname.ViewCustomAttributes = ""

			' i_displaySort
			Menutoppingsgroups.i_displaySort.ViewValue = Menutoppingsgroups.i_displaySort.CurrentValue
			Menutoppingsgroups.i_displaySort.ViewCustomAttributes = ""

			' View refer script
			' ID

			Menutoppingsgroups.ID.LinkCustomAttributes = ""
			Menutoppingsgroups.ID.HrefValue = ""
			Menutoppingsgroups.ID.TooltipValue = ""

			' toppingsgroup
			Menutoppingsgroups.toppingsgroup.LinkCustomAttributes = ""
			Menutoppingsgroups.toppingsgroup.HrefValue = ""
			Menutoppingsgroups.toppingsgroup.TooltipValue = ""

			' IdBusinessDetail
			Menutoppingsgroups.IdBusinessDetail.LinkCustomAttributes = ""
			Menutoppingsgroups.IdBusinessDetail.HrefValue = ""
			Menutoppingsgroups.IdBusinessDetail.TooltipValue = ""

			' printingname
			Menutoppingsgroups.printingname.LinkCustomAttributes = ""
			Menutoppingsgroups.printingname.HrefValue = ""
			Menutoppingsgroups.printingname.TooltipValue = ""

			' i_displaySort
			Menutoppingsgroups.i_displaySort.LinkCustomAttributes = ""
			Menutoppingsgroups.i_displaySort.HrefValue = ""
			Menutoppingsgroups.i_displaySort.TooltipValue = ""
		End If

		' Call Row Rendered event
		If Menutoppingsgroups.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call Menutoppingsgroups.Row_Rendered()
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
		sSql = Menutoppingsgroups.SQL
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
				DeleteRows = Menutoppingsgroups.Row_Deleting(RsDelete)
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
			ElseIf Menutoppingsgroups.CancelMessage <> "" Then
				FailureMessage = Menutoppingsgroups.CancelMessage
				Menutoppingsgroups.CancelMessage = ""
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
				Call Menutoppingsgroups.Row_Deleted(RsOld)
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
		Call Breadcrumb.Add("list", Menutoppingsgroups.TableVar, "Menutoppingsgroupslist.asp", "", Menutoppingsgroups.TableVar, True)
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
