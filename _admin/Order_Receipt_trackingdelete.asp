<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="Order_Receipt_trackinginfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim Order_Receipt_tracking_delete
Set Order_Receipt_tracking_delete = New cOrder_Receipt_tracking_delete
Set Page = Order_Receipt_tracking_delete

' Page init processing
Order_Receipt_tracking_delete.Page_Init()

' Page main processing
Order_Receipt_tracking_delete.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
Order_Receipt_tracking_delete.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var Order_Receipt_tracking_delete = new ew_Page("Order_Receipt_tracking_delete");
Order_Receipt_tracking_delete.PageID = "delete"; // Page ID
var EW_PAGE_ID = Order_Receipt_tracking_delete.PageID; // For backward compatibility
// Form object
var fOrder_Receipt_trackingdelete = new ew_Form("fOrder_Receipt_trackingdelete");
// Form_CustomValidate event
fOrder_Receipt_trackingdelete.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fOrder_Receipt_trackingdelete.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fOrder_Receipt_trackingdelete.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<%

' Load records for display
Set Order_Receipt_tracking_delete.Recordset = Order_Receipt_tracking_delete.LoadRecordset()
Order_Receipt_tracking_delete.TotalRecs = Order_Receipt_tracking_delete.Recordset.RecordCount ' Get record count
If Order_Receipt_tracking_delete.TotalRecs <= 0 Then ' No record found, exit
	Order_Receipt_tracking_delete.Recordset.Close
	Set Order_Receipt_tracking_delete.Recordset = Nothing
	Call Order_Receipt_tracking_delete.Page_Terminate("Order_Receipt_trackinglist.asp") ' Return to list
End If
%>
<div class="ewToolbar">
<% If Order_Receipt_tracking.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If Order_Receipt_tracking.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% Order_Receipt_tracking_delete.ShowPageHeader() %>
<% Order_Receipt_tracking_delete.ShowMessage %>
<form name="fOrder_Receipt_trackingdelete" id="fOrder_Receipt_trackingdelete" class="form-inline ewForm ewDeleteForm" action="<%= ew_CurrentPage() %>" method="post">
<% If Order_Receipt_tracking_delete.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= Order_Receipt_tracking_delete.Token %>">
<% End If %>
<input type="hidden" name="t" value="Order_Receipt_tracking">
<input type="hidden" name="a_delete" id="a_delete" value="D">
<% For i = 0 to UBound(Order_Receipt_tracking_delete.RecKeys) %>
<input type="hidden" name="key_m" id="key_m" value="<%= ew_HtmlEncode(ew_GetKeyValue(Order_Receipt_tracking_delete.RecKeys(i))) %>">
<% Next %>
<div class="ewGrid">
<div class="<% If ew_IsResponsiveLayout() Then Response.Write "table-responsive " %>ewGridMiddlePanel">
<table class="table ewTable">
<%= Order_Receipt_tracking.TableCustomInnerHtml %>
	<thead>
	<tr class="ewTableHeader">
<% If Order_Receipt_tracking.l_id.Visible Then ' l_id %>
		<th><span id="elh_Order_Receipt_tracking_l_id" class="Order_Receipt_tracking_l_id"><%= Order_Receipt_tracking.l_id.FldCaption %></span></th>
<% End If %>
<% If Order_Receipt_tracking.OrderID.Visible Then ' OrderID %>
		<th><span id="elh_Order_Receipt_tracking_OrderID" class="Order_Receipt_tracking_OrderID"><%= Order_Receipt_tracking.OrderID.FldCaption %></span></th>
<% End If %>
<% If Order_Receipt_tracking.s_printtype.Visible Then ' s_printtype %>
		<th><span id="elh_Order_Receipt_tracking_s_printtype" class="Order_Receipt_tracking_s_printtype"><%= Order_Receipt_tracking.s_printtype.FldCaption %></span></th>
<% End If %>
<% If Order_Receipt_tracking.s_filename.Visible Then ' s_filename %>
		<th><span id="elh_Order_Receipt_tracking_s_filename" class="Order_Receipt_tracking_s_filename"><%= Order_Receipt_tracking.s_filename.FldCaption %></span></th>
<% End If %>
<% If Order_Receipt_tracking.t_createdDate.Visible Then ' t_createdDate %>
		<th><span id="elh_Order_Receipt_tracking_t_createdDate" class="Order_Receipt_tracking_t_createdDate"><%= Order_Receipt_tracking.t_createdDate.FldCaption %></span></th>
<% End If %>
<% If Order_Receipt_tracking.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
		<th><span id="elh_Order_Receipt_tracking_IdBusinessDetail" class="Order_Receipt_tracking_IdBusinessDetail"><%= Order_Receipt_tracking.IdBusinessDetail.FldCaption %></span></th>
<% End If %>
<% If Order_Receipt_tracking.s_printstatus.Visible Then ' s_printstatus %>
		<th><span id="elh_Order_Receipt_tracking_s_printstatus" class="Order_Receipt_tracking_s_printstatus"><%= Order_Receipt_tracking.s_printstatus.FldCaption %></span></th>
<% End If %>
	</tr>
	</thead>
	<tbody>
<%
Order_Receipt_tracking_delete.RecCnt = 0
Order_Receipt_tracking_delete.RowCnt = 0
Do While (Not Order_Receipt_tracking_delete.Recordset.Eof)
	Order_Receipt_tracking_delete.RecCnt = Order_Receipt_tracking_delete.RecCnt + 1
	Order_Receipt_tracking_delete.RowCnt = Order_Receipt_tracking_delete.RowCnt + 1

	' Set row properties
	Call Order_Receipt_tracking.ResetAttrs()
	Order_Receipt_tracking.RowType = EW_ROWTYPE_VIEW ' view

	' Get the field contents
	Call Order_Receipt_tracking_delete.LoadRowValues(Order_Receipt_tracking_delete.Recordset)

	' Render row
	Call Order_Receipt_tracking_delete.RenderRow()
%>
	<tr<%= Order_Receipt_tracking.RowAttributes %>>
<% If Order_Receipt_tracking.l_id.Visible Then ' l_id %>
		<td<%= Order_Receipt_tracking.l_id.CellAttributes %>>
<span id="el<%= Order_Receipt_tracking_delete.RowCnt %>_Order_Receipt_tracking_l_id" class="form-group Order_Receipt_tracking_l_id">
<span<%= Order_Receipt_tracking.l_id.ViewAttributes %>>
<%= Order_Receipt_tracking.l_id.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Order_Receipt_tracking.OrderID.Visible Then ' OrderID %>
		<td<%= Order_Receipt_tracking.OrderID.CellAttributes %>>
<span id="el<%= Order_Receipt_tracking_delete.RowCnt %>_Order_Receipt_tracking_OrderID" class="form-group Order_Receipt_tracking_OrderID">
<span<%= Order_Receipt_tracking.OrderID.ViewAttributes %>>
<%= Order_Receipt_tracking.OrderID.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Order_Receipt_tracking.s_printtype.Visible Then ' s_printtype %>
		<td<%= Order_Receipt_tracking.s_printtype.CellAttributes %>>
<span id="el<%= Order_Receipt_tracking_delete.RowCnt %>_Order_Receipt_tracking_s_printtype" class="form-group Order_Receipt_tracking_s_printtype">
<span<%= Order_Receipt_tracking.s_printtype.ViewAttributes %>>
<%= Order_Receipt_tracking.s_printtype.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Order_Receipt_tracking.s_filename.Visible Then ' s_filename %>
		<td<%= Order_Receipt_tracking.s_filename.CellAttributes %>>
<span id="el<%= Order_Receipt_tracking_delete.RowCnt %>_Order_Receipt_tracking_s_filename" class="form-group Order_Receipt_tracking_s_filename">
<span<%= Order_Receipt_tracking.s_filename.ViewAttributes %>>
<%= Order_Receipt_tracking.s_filename.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Order_Receipt_tracking.t_createdDate.Visible Then ' t_createdDate %>
		<td<%= Order_Receipt_tracking.t_createdDate.CellAttributes %>>
<span id="el<%= Order_Receipt_tracking_delete.RowCnt %>_Order_Receipt_tracking_t_createdDate" class="form-group Order_Receipt_tracking_t_createdDate">
<span<%= Order_Receipt_tracking.t_createdDate.ViewAttributes %>>
<%= Order_Receipt_tracking.t_createdDate.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Order_Receipt_tracking.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
		<td<%= Order_Receipt_tracking.IdBusinessDetail.CellAttributes %>>
<span id="el<%= Order_Receipt_tracking_delete.RowCnt %>_Order_Receipt_tracking_IdBusinessDetail" class="form-group Order_Receipt_tracking_IdBusinessDetail">
<span<%= Order_Receipt_tracking.IdBusinessDetail.ViewAttributes %>>
<%= Order_Receipt_tracking.IdBusinessDetail.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Order_Receipt_tracking.s_printstatus.Visible Then ' s_printstatus %>
		<td<%= Order_Receipt_tracking.s_printstatus.CellAttributes %>>
<span id="el<%= Order_Receipt_tracking_delete.RowCnt %>_Order_Receipt_tracking_s_printstatus" class="form-group Order_Receipt_tracking_s_printstatus">
<span<%= Order_Receipt_tracking.s_printstatus.ViewAttributes %>>
<%= Order_Receipt_tracking.s_printstatus.ListViewValue %>
</span>
</span>
</td>
<% End If %>
	</tr>
<%
	Order_Receipt_tracking_delete.Recordset.MoveNext
Loop
Order_Receipt_tracking_delete.Recordset.Close
Set Order_Receipt_tracking_delete.Recordset = Nothing
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
fOrder_Receipt_trackingdelete.Init();
</script>
<%
Order_Receipt_tracking_delete.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set Order_Receipt_tracking_delete = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cOrder_Receipt_tracking_delete

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
		TableName = "Order_Receipt_tracking"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "Order_Receipt_tracking_delete"
	End Property

	' Page Name
	Public Property Get PageName()
		PageName = ew_CurrentPage()
	End Property

	' Page Url
	Public Property Get PageUrl()
		PageUrl = ew_CurrentPage() & "?"
		If Order_Receipt_tracking.UseTokenInUrl Then PageUrl = PageUrl & "t=" & Order_Receipt_tracking.TableVar & "&" ' add page token
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
		If Order_Receipt_tracking.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (Order_Receipt_tracking.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (Order_Receipt_tracking.TableVar = Request.QueryString("t"))
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
		If IsEmpty(Order_Receipt_tracking) Then Set Order_Receipt_tracking = New cOrder_Receipt_tracking
		Set Table = Order_Receipt_tracking

		' Initialize urls
		' Initialize form object

		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "delete"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "Order_Receipt_tracking"

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
			results = Order_Receipt_tracking.GetAutoFill(Request.Form("name"), Request.Form("q"))
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
		If Not Order_Receipt_tracking Is Nothing Then
			If Order_Receipt_tracking.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = Order_Receipt_tracking.TableVar
				If Order_Receipt_tracking.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf Order_Receipt_tracking.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf Order_Receipt_tracking.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf Order_Receipt_tracking.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set Order_Receipt_tracking = Nothing
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
		RecKeys = Order_Receipt_tracking.GetRecordKeys() ' Load record keys
		sFilter = Order_Receipt_tracking.GetKeyFilter()
		If sFilter = "" Then
			Call Page_Terminate("Order_Receipt_trackinglist.asp") ' Prevent SQL injection, return to list
		End If

		' Set up filter (Sql Where Clause) and get Return Sql
		' Sql constructor in Order_Receipt_tracking class, Order_Receipt_trackinginfo.asp

		Order_Receipt_tracking.CurrentFilter = sFilter

		' Get action
		If Request.Form("a_delete").Count > 0 Then
			Order_Receipt_tracking.CurrentAction = Request.Form("a_delete")
		Else
			Order_Receipt_tracking.CurrentAction = "D"	' Delete record directly
		End If
		Select Case Order_Receipt_tracking.CurrentAction
			Case "D" ' Delete
				Order_Receipt_tracking.SendEmail = True ' Send email on delete success
				If DeleteRows() Then ' Delete rows
					If SuccessMessage = "" Then SuccessMessage = Language.Phrase("DeleteSuccess") ' Set up success message
					Call Page_Terminate(Order_Receipt_tracking.ReturnUrl) ' Return to caller
				End If
		End Select
	End Sub

	' -----------------------------------------------------------------
	' Load recordset
	'
	Function LoadRecordset()

		' Load list page sql
		Dim sSql
		sSql = Order_Receipt_tracking.SelectSQL
		Call ew_SetDebugMsg("LoadRecordset: " & sSql) ' Show SQL for debugging

		' Load recordset
		Dim RsRecordset
		Set RsRecordset = ew_LoadRecordset(sSql)

		' Call Recordset Selected event
		Call Order_Receipt_tracking.Recordset_Selected(RsRecordset)
		Set LoadRecordset = RsRecordset
	End Function

	' -----------------------------------------------------------------
	' Load row based on key values
	'
	Function LoadRow()
		Dim RsRow, sSql, sFilter
		sFilter = Order_Receipt_tracking.KeyFilter

		' Call Row Selecting event
		Call Order_Receipt_tracking.Row_Selecting(sFilter)

		' Load sql based on filter
		Order_Receipt_tracking.CurrentFilter = sFilter
		sSql = Order_Receipt_tracking.SQL
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
		Call Order_Receipt_tracking.Row_Selected(RsRow)
		Order_Receipt_tracking.l_id.DbValue = RsRow("l_id")
		Order_Receipt_tracking.OrderID.DbValue = RsRow("OrderID")
		Order_Receipt_tracking.s_printtype.DbValue = RsRow("s_printtype")
		Order_Receipt_tracking.s_filename.DbValue = RsRow("s_filename")
		Order_Receipt_tracking.t_createdDate.DbValue = RsRow("t_createdDate")
		Order_Receipt_tracking.IdBusinessDetail.DbValue = RsRow("IdBusinessDetail")
		Order_Receipt_tracking.s_printstatus.DbValue = RsRow("s_printstatus")
	End Sub

	' Load DbValue from recordset
	Sub LoadDbValues(Rs)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		If Rs.Eof Then Exit Sub
		Order_Receipt_tracking.l_id.m_DbValue = Rs("l_id")
		Order_Receipt_tracking.OrderID.m_DbValue = Rs("OrderID")
		Order_Receipt_tracking.s_printtype.m_DbValue = Rs("s_printtype")
		Order_Receipt_tracking.s_filename.m_DbValue = Rs("s_filename")
		Order_Receipt_tracking.t_createdDate.m_DbValue = Rs("t_createdDate")
		Order_Receipt_tracking.IdBusinessDetail.m_DbValue = Rs("IdBusinessDetail")
		Order_Receipt_tracking.s_printstatus.m_DbValue = Rs("s_printstatus")
	End Sub

	' -----------------------------------------------------------------
	' Render row values based on field settings
	'
	Sub RenderRow()

		' Initialize urls
		' Call Row Rendering event

		Call Order_Receipt_tracking.Row_Rendering()

		' ---------------------------------------
		'  Common render codes for all row types
		' ---------------------------------------
		' l_id
		' OrderID
		' s_printtype
		' s_filename
		' t_createdDate
		' IdBusinessDetail
		' s_printstatus
		' -----------
		'  View  Row
		' -----------

		If Order_Receipt_tracking.RowType = EW_ROWTYPE_VIEW Then ' View row

			' l_id
			Order_Receipt_tracking.l_id.ViewValue = Order_Receipt_tracking.l_id.CurrentValue
			Order_Receipt_tracking.l_id.ViewCustomAttributes = ""

			' OrderID
			Order_Receipt_tracking.OrderID.ViewValue = Order_Receipt_tracking.OrderID.CurrentValue
			Order_Receipt_tracking.OrderID.ViewCustomAttributes = ""

			' s_printtype
			Order_Receipt_tracking.s_printtype.ViewValue = Order_Receipt_tracking.s_printtype.CurrentValue
			Order_Receipt_tracking.s_printtype.ViewCustomAttributes = ""

			' s_filename
			Order_Receipt_tracking.s_filename.ViewValue = Order_Receipt_tracking.s_filename.CurrentValue
			Order_Receipt_tracking.s_filename.ViewCustomAttributes = ""

			' t_createdDate
			Order_Receipt_tracking.t_createdDate.ViewValue = Order_Receipt_tracking.t_createdDate.CurrentValue
			Order_Receipt_tracking.t_createdDate.ViewCustomAttributes = ""

			' IdBusinessDetail
			Order_Receipt_tracking.IdBusinessDetail.ViewValue = Order_Receipt_tracking.IdBusinessDetail.CurrentValue
			Order_Receipt_tracking.IdBusinessDetail.ViewCustomAttributes = ""

			' s_printstatus
			Order_Receipt_tracking.s_printstatus.ViewValue = Order_Receipt_tracking.s_printstatus.CurrentValue
			Order_Receipt_tracking.s_printstatus.ViewCustomAttributes = ""

			' View refer script
			' l_id

			Order_Receipt_tracking.l_id.LinkCustomAttributes = ""
			Order_Receipt_tracking.l_id.HrefValue = ""
			Order_Receipt_tracking.l_id.TooltipValue = ""

			' OrderID
			Order_Receipt_tracking.OrderID.LinkCustomAttributes = ""
			Order_Receipt_tracking.OrderID.HrefValue = ""
			Order_Receipt_tracking.OrderID.TooltipValue = ""

			' s_printtype
			Order_Receipt_tracking.s_printtype.LinkCustomAttributes = ""
			Order_Receipt_tracking.s_printtype.HrefValue = ""
			Order_Receipt_tracking.s_printtype.TooltipValue = ""

			' s_filename
			Order_Receipt_tracking.s_filename.LinkCustomAttributes = ""
			Order_Receipt_tracking.s_filename.HrefValue = ""
			Order_Receipt_tracking.s_filename.TooltipValue = ""

			' t_createdDate
			Order_Receipt_tracking.t_createdDate.LinkCustomAttributes = ""
			Order_Receipt_tracking.t_createdDate.HrefValue = ""
			Order_Receipt_tracking.t_createdDate.TooltipValue = ""

			' IdBusinessDetail
			Order_Receipt_tracking.IdBusinessDetail.LinkCustomAttributes = ""
			Order_Receipt_tracking.IdBusinessDetail.HrefValue = ""
			Order_Receipt_tracking.IdBusinessDetail.TooltipValue = ""

			' s_printstatus
			Order_Receipt_tracking.s_printstatus.LinkCustomAttributes = ""
			Order_Receipt_tracking.s_printstatus.HrefValue = ""
			Order_Receipt_tracking.s_printstatus.TooltipValue = ""
		End If

		' Call Row Rendered event
		If Order_Receipt_tracking.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call Order_Receipt_tracking.Row_Rendered()
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
		sSql = Order_Receipt_tracking.SQL
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
				DeleteRows = Order_Receipt_tracking.Row_Deleting(RsDelete)
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
				sThisKey = sThisKey & RsDelete("l_id")
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
			ElseIf Order_Receipt_tracking.CancelMessage <> "" Then
				FailureMessage = Order_Receipt_tracking.CancelMessage
				Order_Receipt_tracking.CancelMessage = ""
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
				Call Order_Receipt_tracking.Row_Deleted(RsOld)
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
		Call Breadcrumb.Add("list", Order_Receipt_tracking.TableVar, "Order_Receipt_trackinglist.asp", "", Order_Receipt_tracking.TableVar, True)
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
