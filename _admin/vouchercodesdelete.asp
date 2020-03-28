<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="vouchercodesinfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim vouchercodes_delete
Set vouchercodes_delete = New cvouchercodes_delete
Set Page = vouchercodes_delete

' Page init processing
vouchercodes_delete.Page_Init()

' Page main processing
vouchercodes_delete.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
vouchercodes_delete.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var vouchercodes_delete = new ew_Page("vouchercodes_delete");
vouchercodes_delete.PageID = "delete"; // Page ID
var EW_PAGE_ID = vouchercodes_delete.PageID; // For backward compatibility
// Form object
var fvouchercodesdelete = new ew_Form("fvouchercodesdelete");
// Form_CustomValidate event
fvouchercodesdelete.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fvouchercodesdelete.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fvouchercodesdelete.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<%

' Load records for display
Set vouchercodes_delete.Recordset = vouchercodes_delete.LoadRecordset()
vouchercodes_delete.TotalRecs = vouchercodes_delete.Recordset.RecordCount ' Get record count
If vouchercodes_delete.TotalRecs <= 0 Then ' No record found, exit
	vouchercodes_delete.Recordset.Close
	Set vouchercodes_delete.Recordset = Nothing
	Call vouchercodes_delete.Page_Terminate("vouchercodeslist.asp") ' Return to list
End If
%>
<div class="ewToolbar">
<% If vouchercodes.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If vouchercodes.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% vouchercodes_delete.ShowPageHeader() %>
<% vouchercodes_delete.ShowMessage %>
<form name="fvouchercodesdelete" id="fvouchercodesdelete" class="form-inline ewForm ewDeleteForm" action="<%= ew_CurrentPage() %>" method="post">
<% If vouchercodes_delete.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= vouchercodes_delete.Token %>">
<% End If %>
<input type="hidden" name="t" value="vouchercodes">
<input type="hidden" name="a_delete" id="a_delete" value="D">
<% For i = 0 to UBound(vouchercodes_delete.RecKeys) %>
<input type="hidden" name="key_m" id="key_m" value="<%= ew_HtmlEncode(ew_GetKeyValue(vouchercodes_delete.RecKeys(i))) %>">
<% Next %>
<div class="ewGrid">
<div class="<% If ew_IsResponsiveLayout() Then Response.Write "table-responsive " %>ewGridMiddlePanel">
<table class="table ewTable">
<%= vouchercodes.TableCustomInnerHtml %>
	<thead>
	<tr class="ewTableHeader">
<% If vouchercodes.ID.Visible Then ' ID %>
		<th><span id="elh_vouchercodes_ID" class="vouchercodes_ID"><%= vouchercodes.ID.FldCaption %></span></th>
<% End If %>
<% If vouchercodes.vouchercode.Visible Then ' vouchercode %>
		<th><span id="elh_vouchercodes_vouchercode" class="vouchercodes_vouchercode"><%= vouchercodes.vouchercode.FldCaption %></span></th>
<% End If %>
<% If vouchercodes.vouchercodediscount.Visible Then ' vouchercodediscount %>
		<th><span id="elh_vouchercodes_vouchercodediscount" class="vouchercodes_vouchercodediscount"><%= vouchercodes.vouchercodediscount.FldCaption %></span></th>
<% End If %>
<% If vouchercodes.vouchertype.Visible Then ' vouchertype %>
		<th><span id="elh_vouchercodes_vouchertype" class="vouchercodes_vouchertype"><%= vouchercodes.vouchertype.FldCaption %></span></th>
<% End If %>
<% If vouchercodes.startdate.Visible Then ' startdate %>
		<th><span id="elh_vouchercodes_startdate" class="vouchercodes_startdate"><%= vouchercodes.startdate.FldCaption %></span></th>
<% End If %>
<% If vouchercodes.enddate.Visible Then ' enddate %>
		<th><span id="elh_vouchercodes_enddate" class="vouchercodes_enddate"><%= vouchercodes.enddate.FldCaption %></span></th>
<% End If %>
<% If vouchercodes.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
		<th><span id="elh_vouchercodes_IdBusinessDetail" class="vouchercodes_IdBusinessDetail"><%= vouchercodes.IdBusinessDetail.FldCaption %></span></th>
<% End If %>
<% If vouchercodes.MinimumAmount.Visible Then ' MinimumAmount %>
		<th><span id="elh_vouchercodes_MinimumAmount" class="vouchercodes_MinimumAmount"><%= vouchercodes.MinimumAmount.FldCaption %></span></th>
<% End If %>
<% If vouchercodes.MenuItemID.Visible Then ' MenuItemID %>
		<th><span id="elh_vouchercodes_MenuItemID" class="vouchercodes_MenuItemID"><%= vouchercodes.MenuItemID.FldCaption %></span></th>
<% End If %>
<% If vouchercodes.VoucherMainType.Visible Then ' VoucherMainType %>
		<th><span id="elh_vouchercodes_VoucherMainType" class="vouchercodes_VoucherMainType"><%= vouchercodes.VoucherMainType.FldCaption %></span></th>
<% End If %>
	</tr>
	</thead>
	<tbody>
<%
vouchercodes_delete.RecCnt = 0
vouchercodes_delete.RowCnt = 0
Do While (Not vouchercodes_delete.Recordset.Eof)
	vouchercodes_delete.RecCnt = vouchercodes_delete.RecCnt + 1
	vouchercodes_delete.RowCnt = vouchercodes_delete.RowCnt + 1

	' Set row properties
	Call vouchercodes.ResetAttrs()
	vouchercodes.RowType = EW_ROWTYPE_VIEW ' view

	' Get the field contents
	Call vouchercodes_delete.LoadRowValues(vouchercodes_delete.Recordset)

	' Render row
	Call vouchercodes_delete.RenderRow()
%>
	<tr<%= vouchercodes.RowAttributes %>>
<% If vouchercodes.ID.Visible Then ' ID %>
		<td<%= vouchercodes.ID.CellAttributes %>>
<span id="el<%= vouchercodes_delete.RowCnt %>_vouchercodes_ID" class="form-group vouchercodes_ID">
<span<%= vouchercodes.ID.ViewAttributes %>>
<%= vouchercodes.ID.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If vouchercodes.vouchercode.Visible Then ' vouchercode %>
		<td<%= vouchercodes.vouchercode.CellAttributes %>>
<span id="el<%= vouchercodes_delete.RowCnt %>_vouchercodes_vouchercode" class="form-group vouchercodes_vouchercode">
<span<%= vouchercodes.vouchercode.ViewAttributes %>>
<%= vouchercodes.vouchercode.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If vouchercodes.vouchercodediscount.Visible Then ' vouchercodediscount %>
		<td<%= vouchercodes.vouchercodediscount.CellAttributes %>>
<span id="el<%= vouchercodes_delete.RowCnt %>_vouchercodes_vouchercodediscount" class="form-group vouchercodes_vouchercodediscount">
<span<%= vouchercodes.vouchercodediscount.ViewAttributes %>>
<%= vouchercodes.vouchercodediscount.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If vouchercodes.vouchertype.Visible Then ' vouchertype %>
		<td<%= vouchercodes.vouchertype.CellAttributes %>>
<span id="el<%= vouchercodes_delete.RowCnt %>_vouchercodes_vouchertype" class="form-group vouchercodes_vouchertype">
<span<%= vouchercodes.vouchertype.ViewAttributes %>>
<%= vouchercodes.vouchertype.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If vouchercodes.startdate.Visible Then ' startdate %>
		<td<%= vouchercodes.startdate.CellAttributes %>>
<span id="el<%= vouchercodes_delete.RowCnt %>_vouchercodes_startdate" class="form-group vouchercodes_startdate">
<span<%= vouchercodes.startdate.ViewAttributes %>>
<%= vouchercodes.startdate.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If vouchercodes.enddate.Visible Then ' enddate %>
		<td<%= vouchercodes.enddate.CellAttributes %>>
<span id="el<%= vouchercodes_delete.RowCnt %>_vouchercodes_enddate" class="form-group vouchercodes_enddate">
<span<%= vouchercodes.enddate.ViewAttributes %>>
<%= vouchercodes.enddate.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If vouchercodes.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
		<td<%= vouchercodes.IdBusinessDetail.CellAttributes %>>
<span id="el<%= vouchercodes_delete.RowCnt %>_vouchercodes_IdBusinessDetail" class="form-group vouchercodes_IdBusinessDetail">
<span<%= vouchercodes.IdBusinessDetail.ViewAttributes %>>
<%= vouchercodes.IdBusinessDetail.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If vouchercodes.MinimumAmount.Visible Then ' MinimumAmount %>
		<td<%= vouchercodes.MinimumAmount.CellAttributes %>>
<span id="el<%= vouchercodes_delete.RowCnt %>_vouchercodes_MinimumAmount" class="form-group vouchercodes_MinimumAmount">
<span<%= vouchercodes.MinimumAmount.ViewAttributes %>>
<%= vouchercodes.MinimumAmount.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If vouchercodes.MenuItemID.Visible Then ' MenuItemID %>
		<td<%= vouchercodes.MenuItemID.CellAttributes %>>
<span id="el<%= vouchercodes_delete.RowCnt %>_vouchercodes_MenuItemID" class="form-group vouchercodes_MenuItemID">
<span<%= vouchercodes.MenuItemID.ViewAttributes %>>
<%= vouchercodes.MenuItemID.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If vouchercodes.VoucherMainType.Visible Then ' VoucherMainType %>
		<td<%= vouchercodes.VoucherMainType.CellAttributes %>>
<span id="el<%= vouchercodes_delete.RowCnt %>_vouchercodes_VoucherMainType" class="form-group vouchercodes_VoucherMainType">
<span<%= vouchercodes.VoucherMainType.ViewAttributes %>>
<%= vouchercodes.VoucherMainType.ListViewValue %>
</span>
</span>
</td>
<% End If %>
	</tr>
<%
	vouchercodes_delete.Recordset.MoveNext
Loop
vouchercodes_delete.Recordset.Close
Set vouchercodes_delete.Recordset = Nothing
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
fvouchercodesdelete.Init();
</script>
<%
vouchercodes_delete.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set vouchercodes_delete = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cvouchercodes_delete

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
		TableName = "vouchercodes"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "vouchercodes_delete"
	End Property

	' Page Name
	Public Property Get PageName()
		PageName = ew_CurrentPage()
	End Property

	' Page Url
	Public Property Get PageUrl()
		PageUrl = ew_CurrentPage() & "?"
		If vouchercodes.UseTokenInUrl Then PageUrl = PageUrl & "t=" & vouchercodes.TableVar & "&" ' add page token
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
		If vouchercodes.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (vouchercodes.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (vouchercodes.TableVar = Request.QueryString("t"))
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
		If IsEmpty(vouchercodes) Then Set vouchercodes = New cvouchercodes
		Set Table = vouchercodes

		' Initialize urls
		' Initialize form object

		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "delete"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "vouchercodes"

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
			results = vouchercodes.GetAutoFill(Request.Form("name"), Request.Form("q"))
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
		If Not vouchercodes Is Nothing Then
			If vouchercodes.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = vouchercodes.TableVar
				If vouchercodes.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf vouchercodes.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf vouchercodes.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf vouchercodes.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set vouchercodes = Nothing
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
		RecKeys = vouchercodes.GetRecordKeys() ' Load record keys
		sFilter = vouchercodes.GetKeyFilter()
		If sFilter = "" Then
			Call Page_Terminate("vouchercodeslist.asp") ' Prevent SQL injection, return to list
		End If

		' Set up filter (Sql Where Clause) and get Return Sql
		' Sql constructor in vouchercodes class, vouchercodesinfo.asp

		vouchercodes.CurrentFilter = sFilter

		' Get action
		If Request.Form("a_delete").Count > 0 Then
			vouchercodes.CurrentAction = Request.Form("a_delete")
		Else
			vouchercodes.CurrentAction = "D"	' Delete record directly
		End If
		Select Case vouchercodes.CurrentAction
			Case "D" ' Delete
				vouchercodes.SendEmail = True ' Send email on delete success
				If DeleteRows() Then ' Delete rows
					If SuccessMessage = "" Then SuccessMessage = Language.Phrase("DeleteSuccess") ' Set up success message
					Call Page_Terminate(vouchercodes.ReturnUrl) ' Return to caller
				End If
		End Select
	End Sub

	' -----------------------------------------------------------------
	' Load recordset
	'
	Function LoadRecordset()

		' Load list page sql
		Dim sSql
		sSql = vouchercodes.SelectSQL
		Call ew_SetDebugMsg("LoadRecordset: " & sSql) ' Show SQL for debugging

		' Load recordset
		Dim RsRecordset
		Set RsRecordset = ew_LoadRecordset(sSql)

		' Call Recordset Selected event
		Call vouchercodes.Recordset_Selected(RsRecordset)
		Set LoadRecordset = RsRecordset
	End Function

	' -----------------------------------------------------------------
	' Load row based on key values
	'
	Function LoadRow()
		Dim RsRow, sSql, sFilter
		sFilter = vouchercodes.KeyFilter

		' Call Row Selecting event
		Call vouchercodes.Row_Selecting(sFilter)

		' Load sql based on filter
		vouchercodes.CurrentFilter = sFilter
		sSql = vouchercodes.SQL
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
		Call vouchercodes.Row_Selected(RsRow)
		vouchercodes.ID.DbValue = RsRow("ID")
		vouchercodes.vouchercode.DbValue = RsRow("vouchercode")
		vouchercodes.vouchercodediscount.DbValue = RsRow("vouchercodediscount")
		vouchercodes.vouchertype.DbValue = RsRow("vouchertype")
		vouchercodes.startdate.DbValue = RsRow("startdate")
		vouchercodes.enddate.DbValue = RsRow("enddate")
		vouchercodes.IdBusinessDetail.DbValue = RsRow("IdBusinessDetail")
		vouchercodes.MinimumAmount.DbValue = RsRow("MinimumAmount")
		vouchercodes.MenuItemID.DbValue = RsRow("MenuItemID")
		vouchercodes.VoucherMainType.DbValue = RsRow("VoucherMainType")
	End Sub

	' Load DbValue from recordset
	Sub LoadDbValues(Rs)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		If Rs.Eof Then Exit Sub
		vouchercodes.ID.m_DbValue = Rs("ID")
		vouchercodes.vouchercode.m_DbValue = Rs("vouchercode")
		vouchercodes.vouchercodediscount.m_DbValue = Rs("vouchercodediscount")
		vouchercodes.vouchertype.m_DbValue = Rs("vouchertype")
		vouchercodes.startdate.m_DbValue = Rs("startdate")
		vouchercodes.enddate.m_DbValue = Rs("enddate")
		vouchercodes.IdBusinessDetail.m_DbValue = Rs("IdBusinessDetail")
		vouchercodes.MinimumAmount.m_DbValue = Rs("MinimumAmount")
		vouchercodes.MenuItemID.m_DbValue = Rs("MenuItemID")
		vouchercodes.VoucherMainType.m_DbValue = Rs("VoucherMainType")
	End Sub

	' -----------------------------------------------------------------
	' Render row values based on field settings
	'
	Sub RenderRow()

		' Initialize urls
		' Convert decimal values if posted back

		If vouchercodes.MinimumAmount.FormValue = vouchercodes.MinimumAmount.CurrentValue And IsNumeric(vouchercodes.MinimumAmount.CurrentValue) Then
			vouchercodes.MinimumAmount.CurrentValue = ew_StrToFloat(vouchercodes.MinimumAmount.CurrentValue)
		End If

		' Call Row Rendering event
		Call vouchercodes.Row_Rendering()

		' ---------------------------------------
		'  Common render codes for all row types
		' ---------------------------------------
		' ID
		' vouchercode
		' vouchercodediscount
		' vouchertype
		' startdate
		' enddate
		' IdBusinessDetail
		' MinimumAmount
		' MenuItemID
		' VoucherMainType
		' -----------
		'  View  Row
		' -----------

		If vouchercodes.RowType = EW_ROWTYPE_VIEW Then ' View row

			' ID
			vouchercodes.ID.ViewValue = vouchercodes.ID.CurrentValue
			vouchercodes.ID.ViewCustomAttributes = ""

			' vouchercode
			vouchercodes.vouchercode.ViewValue = vouchercodes.vouchercode.CurrentValue
			vouchercodes.vouchercode.ViewCustomAttributes = ""

			' vouchercodediscount
			vouchercodes.vouchercodediscount.ViewValue = vouchercodes.vouchercodediscount.CurrentValue
			vouchercodes.vouchercodediscount.ViewCustomAttributes = ""

			' vouchertype
			vouchercodes.vouchertype.ViewValue = vouchercodes.vouchertype.CurrentValue
			vouchercodes.vouchertype.ViewCustomAttributes = ""

			' startdate
			vouchercodes.startdate.ViewValue = vouchercodes.startdate.CurrentValue
			vouchercodes.startdate.ViewCustomAttributes = ""

			' enddate
			vouchercodes.enddate.ViewValue = vouchercodes.enddate.CurrentValue
			vouchercodes.enddate.ViewCustomAttributes = ""

			' IdBusinessDetail
			vouchercodes.IdBusinessDetail.ViewValue = vouchercodes.IdBusinessDetail.CurrentValue
			vouchercodes.IdBusinessDetail.ViewCustomAttributes = ""

			' MinimumAmount
			vouchercodes.MinimumAmount.ViewValue = vouchercodes.MinimumAmount.CurrentValue
			vouchercodes.MinimumAmount.ViewCustomAttributes = ""

			' MenuItemID
			vouchercodes.MenuItemID.ViewValue = vouchercodes.MenuItemID.CurrentValue
			vouchercodes.MenuItemID.ViewCustomAttributes = ""

			' VoucherMainType
			vouchercodes.VoucherMainType.ViewValue = vouchercodes.VoucherMainType.CurrentValue
			vouchercodes.VoucherMainType.ViewCustomAttributes = ""

			' View refer script
			' ID

			vouchercodes.ID.LinkCustomAttributes = ""
			vouchercodes.ID.HrefValue = ""
			vouchercodes.ID.TooltipValue = ""

			' vouchercode
			vouchercodes.vouchercode.LinkCustomAttributes = ""
			vouchercodes.vouchercode.HrefValue = ""
			vouchercodes.vouchercode.TooltipValue = ""

			' vouchercodediscount
			vouchercodes.vouchercodediscount.LinkCustomAttributes = ""
			vouchercodes.vouchercodediscount.HrefValue = ""
			vouchercodes.vouchercodediscount.TooltipValue = ""

			' vouchertype
			vouchercodes.vouchertype.LinkCustomAttributes = ""
			vouchercodes.vouchertype.HrefValue = ""
			vouchercodes.vouchertype.TooltipValue = ""

			' startdate
			vouchercodes.startdate.LinkCustomAttributes = ""
			vouchercodes.startdate.HrefValue = ""
			vouchercodes.startdate.TooltipValue = ""

			' enddate
			vouchercodes.enddate.LinkCustomAttributes = ""
			vouchercodes.enddate.HrefValue = ""
			vouchercodes.enddate.TooltipValue = ""

			' IdBusinessDetail
			vouchercodes.IdBusinessDetail.LinkCustomAttributes = ""
			vouchercodes.IdBusinessDetail.HrefValue = ""
			vouchercodes.IdBusinessDetail.TooltipValue = ""

			' MinimumAmount
			vouchercodes.MinimumAmount.LinkCustomAttributes = ""
			vouchercodes.MinimumAmount.HrefValue = ""
			vouchercodes.MinimumAmount.TooltipValue = ""

			' MenuItemID
			vouchercodes.MenuItemID.LinkCustomAttributes = ""
			vouchercodes.MenuItemID.HrefValue = ""
			vouchercodes.MenuItemID.TooltipValue = ""

			' VoucherMainType
			vouchercodes.VoucherMainType.LinkCustomAttributes = ""
			vouchercodes.VoucherMainType.HrefValue = ""
			vouchercodes.VoucherMainType.TooltipValue = ""
		End If

		' Call Row Rendered event
		If vouchercodes.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call vouchercodes.Row_Rendered()
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
		sSql = vouchercodes.SQL
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
				DeleteRows = vouchercodes.Row_Deleting(RsDelete)
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
			ElseIf vouchercodes.CancelMessage <> "" Then
				FailureMessage = vouchercodes.CancelMessage
				vouchercodes.CancelMessage = ""
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
				Call vouchercodes.Row_Deleted(RsOld)
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
		Call Breadcrumb.Add("list", vouchercodes.TableVar, "vouchercodeslist.asp", "", vouchercodes.TableVar, True)
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
