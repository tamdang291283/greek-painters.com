<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="OrderItemsinfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim OrderItems_delete
Set OrderItems_delete = New cOrderItems_delete
Set Page = OrderItems_delete

' Page init processing
OrderItems_delete.Page_Init()

' Page main processing
OrderItems_delete.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
OrderItems_delete.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var OrderItems_delete = new ew_Page("OrderItems_delete");
OrderItems_delete.PageID = "delete"; // Page ID
var EW_PAGE_ID = OrderItems_delete.PageID; // For backward compatibility
// Form object
var fOrderItemsdelete = new ew_Form("fOrderItemsdelete");
// Form_CustomValidate event
fOrderItemsdelete.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fOrderItemsdelete.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fOrderItemsdelete.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<%

' Load records for display
Set OrderItems_delete.Recordset = OrderItems_delete.LoadRecordset()
OrderItems_delete.TotalRecs = OrderItems_delete.Recordset.RecordCount ' Get record count
If OrderItems_delete.TotalRecs <= 0 Then ' No record found, exit
	OrderItems_delete.Recordset.Close
	Set OrderItems_delete.Recordset = Nothing
	Call OrderItems_delete.Page_Terminate("OrderItemslist.asp") ' Return to list
End If
%>
<div class="ewToolbar">
<% If OrderItems.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If OrderItems.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% OrderItems_delete.ShowPageHeader() %>
<% OrderItems_delete.ShowMessage %>
<form name="fOrderItemsdelete" id="fOrderItemsdelete" class="form-inline ewForm ewDeleteForm" action="<%= ew_CurrentPage() %>" method="post">
<% If OrderItems_delete.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= OrderItems_delete.Token %>">
<% End If %>
<input type="hidden" name="t" value="OrderItems">
<input type="hidden" name="a_delete" id="a_delete" value="D">
<% For i = 0 to UBound(OrderItems_delete.RecKeys) %>
<input type="hidden" name="key_m" id="key_m" value="<%= ew_HtmlEncode(ew_GetKeyValue(OrderItems_delete.RecKeys(i))) %>">
<% Next %>
<div class="ewGrid">
<div class="<% If ew_IsResponsiveLayout() Then Response.Write "table-responsive " %>ewGridMiddlePanel">
<table class="table ewTable">
<%= OrderItems.TableCustomInnerHtml %>
	<thead>
	<tr class="ewTableHeader">
<% If OrderItems.ID.Visible Then ' ID %>
		<th><span id="elh_OrderItems_ID" class="OrderItems_ID"><%= OrderItems.ID.FldCaption %></span></th>
<% End If %>
<% If OrderItems.OrderId.Visible Then ' OrderId %>
		<th><span id="elh_OrderItems_OrderId" class="OrderItems_OrderId"><%= OrderItems.OrderId.FldCaption %></span></th>
<% End If %>
<% If OrderItems.MenuItemId.Visible Then ' MenuItemId %>
		<th><span id="elh_OrderItems_MenuItemId" class="OrderItems_MenuItemId"><%= OrderItems.MenuItemId.FldCaption %></span></th>
<% End If %>
<% If OrderItems.MenuItemPropertyId.Visible Then ' MenuItemPropertyId %>
		<th><span id="elh_OrderItems_MenuItemPropertyId" class="OrderItems_MenuItemPropertyId"><%= OrderItems.MenuItemPropertyId.FldCaption %></span></th>
<% End If %>
<% If OrderItems.Qta.Visible Then ' Qta %>
		<th><span id="elh_OrderItems_Qta" class="OrderItems_Qta"><%= OrderItems.Qta.FldCaption %></span></th>
<% End If %>
<% If OrderItems.Price.Visible Then ' Price %>
		<th><span id="elh_OrderItems_Price" class="OrderItems_Price"><%= OrderItems.Price.FldCaption %></span></th>
<% End If %>
<% If OrderItems.Total.Visible Then ' Total %>
		<th><span id="elh_OrderItems_Total" class="OrderItems_Total"><%= OrderItems.Total.FldCaption %></span></th>
<% End If %>
<% If OrderItems.toppingids.Visible Then ' toppingids %>
		<th><span id="elh_OrderItems_toppingids" class="OrderItems_toppingids"><%= OrderItems.toppingids.FldCaption %></span></th>
<% End If %>
<% If OrderItems.dishpropertiesids.Visible Then ' dishpropertiesids %>
		<th><span id="elh_OrderItems_dishpropertiesids" class="OrderItems_dishpropertiesids"><%= OrderItems.dishpropertiesids.FldCaption %></span></th>
<% End If %>
	</tr>
	</thead>
	<tbody>
<%
OrderItems_delete.RecCnt = 0
OrderItems_delete.RowCnt = 0
Do While (Not OrderItems_delete.Recordset.Eof)
	OrderItems_delete.RecCnt = OrderItems_delete.RecCnt + 1
	OrderItems_delete.RowCnt = OrderItems_delete.RowCnt + 1

	' Set row properties
	Call OrderItems.ResetAttrs()
	OrderItems.RowType = EW_ROWTYPE_VIEW ' view

	' Get the field contents
	Call OrderItems_delete.LoadRowValues(OrderItems_delete.Recordset)

	' Render row
	Call OrderItems_delete.RenderRow()
%>
	<tr<%= OrderItems.RowAttributes %>>
<% If OrderItems.ID.Visible Then ' ID %>
		<td<%= OrderItems.ID.CellAttributes %>>
<span id="el<%= OrderItems_delete.RowCnt %>_OrderItems_ID" class="form-group OrderItems_ID">
<span<%= OrderItems.ID.ViewAttributes %>>
<%= OrderItems.ID.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrderItems.OrderId.Visible Then ' OrderId %>
		<td<%= OrderItems.OrderId.CellAttributes %>>
<span id="el<%= OrderItems_delete.RowCnt %>_OrderItems_OrderId" class="form-group OrderItems_OrderId">
<span<%= OrderItems.OrderId.ViewAttributes %>>
<%= OrderItems.OrderId.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrderItems.MenuItemId.Visible Then ' MenuItemId %>
		<td<%= OrderItems.MenuItemId.CellAttributes %>>
<span id="el<%= OrderItems_delete.RowCnt %>_OrderItems_MenuItemId" class="form-group OrderItems_MenuItemId">
<span<%= OrderItems.MenuItemId.ViewAttributes %>>
<%= OrderItems.MenuItemId.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrderItems.MenuItemPropertyId.Visible Then ' MenuItemPropertyId %>
		<td<%= OrderItems.MenuItemPropertyId.CellAttributes %>>
<span id="el<%= OrderItems_delete.RowCnt %>_OrderItems_MenuItemPropertyId" class="form-group OrderItems_MenuItemPropertyId">
<span<%= OrderItems.MenuItemPropertyId.ViewAttributes %>>
<%= OrderItems.MenuItemPropertyId.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrderItems.Qta.Visible Then ' Qta %>
		<td<%= OrderItems.Qta.CellAttributes %>>
<span id="el<%= OrderItems_delete.RowCnt %>_OrderItems_Qta" class="form-group OrderItems_Qta">
<span<%= OrderItems.Qta.ViewAttributes %>>
<%= OrderItems.Qta.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrderItems.Price.Visible Then ' Price %>
		<td<%= OrderItems.Price.CellAttributes %>>
<span id="el<%= OrderItems_delete.RowCnt %>_OrderItems_Price" class="form-group OrderItems_Price">
<span<%= OrderItems.Price.ViewAttributes %>>
<%= OrderItems.Price.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrderItems.Total.Visible Then ' Total %>
		<td<%= OrderItems.Total.CellAttributes %>>
<span id="el<%= OrderItems_delete.RowCnt %>_OrderItems_Total" class="form-group OrderItems_Total">
<span<%= OrderItems.Total.ViewAttributes %>>
<%= OrderItems.Total.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrderItems.toppingids.Visible Then ' toppingids %>
		<td<%= OrderItems.toppingids.CellAttributes %>>
<span id="el<%= OrderItems_delete.RowCnt %>_OrderItems_toppingids" class="form-group OrderItems_toppingids">
<span<%= OrderItems.toppingids.ViewAttributes %>>
<%= OrderItems.toppingids.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrderItems.dishpropertiesids.Visible Then ' dishpropertiesids %>
		<td<%= OrderItems.dishpropertiesids.CellAttributes %>>
<span id="el<%= OrderItems_delete.RowCnt %>_OrderItems_dishpropertiesids" class="form-group OrderItems_dishpropertiesids">
<span<%= OrderItems.dishpropertiesids.ViewAttributes %>>
<%= OrderItems.dishpropertiesids.ListViewValue %>
</span>
</span>
</td>
<% End If %>
	</tr>
<%
	OrderItems_delete.Recordset.MoveNext
Loop
OrderItems_delete.Recordset.Close
Set OrderItems_delete.Recordset = Nothing
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
fOrderItemsdelete.Init();
</script>
<%
OrderItems_delete.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set OrderItems_delete = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cOrderItems_delete

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
		TableName = "OrderItems"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "OrderItems_delete"
	End Property

	' Page Name
	Public Property Get PageName()
		PageName = ew_CurrentPage()
	End Property

	' Page Url
	Public Property Get PageUrl()
		PageUrl = ew_CurrentPage() & "?"
		If OrderItems.UseTokenInUrl Then PageUrl = PageUrl & "t=" & OrderItems.TableVar & "&" ' add page token
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
		If OrderItems.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (OrderItems.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (OrderItems.TableVar = Request.QueryString("t"))
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
		If IsEmpty(OrderItems) Then Set OrderItems = New cOrderItems
		Set Table = OrderItems

		' Initialize urls
		' Initialize form object

		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "delete"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "OrderItems"

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
			results = OrderItems.GetAutoFill(Request.Form("name"), Request.Form("q"))
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
		If Not OrderItems Is Nothing Then
			If OrderItems.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = OrderItems.TableVar
				If OrderItems.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf OrderItems.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf OrderItems.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf OrderItems.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set OrderItems = Nothing
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
		RecKeys = OrderItems.GetRecordKeys() ' Load record keys
		sFilter = OrderItems.GetKeyFilter()
		If sFilter = "" Then
			Call Page_Terminate("OrderItemslist.asp") ' Prevent SQL injection, return to list
		End If

		' Set up filter (Sql Where Clause) and get Return Sql
		' Sql constructor in OrderItems class, OrderItemsinfo.asp

		OrderItems.CurrentFilter = sFilter

		' Get action
		If Request.Form("a_delete").Count > 0 Then
			OrderItems.CurrentAction = Request.Form("a_delete")
		Else
			OrderItems.CurrentAction = "D"	' Delete record directly
		End If
		Select Case OrderItems.CurrentAction
			Case "D" ' Delete
				OrderItems.SendEmail = True ' Send email on delete success
				If DeleteRows() Then ' Delete rows
					If SuccessMessage = "" Then SuccessMessage = Language.Phrase("DeleteSuccess") ' Set up success message
					Call Page_Terminate(OrderItems.ReturnUrl) ' Return to caller
				End If
		End Select
	End Sub

	' -----------------------------------------------------------------
	' Load recordset
	'
	Function LoadRecordset()

		' Load list page sql
		Dim sSql
		sSql = OrderItems.SelectSQL
		Call ew_SetDebugMsg("LoadRecordset: " & sSql) ' Show SQL for debugging

		' Load recordset
		Dim RsRecordset
		Set RsRecordset = ew_LoadRecordset(sSql)

		' Call Recordset Selected event
		Call OrderItems.Recordset_Selected(RsRecordset)
		Set LoadRecordset = RsRecordset
	End Function

	' -----------------------------------------------------------------
	' Load row based on key values
	'
	Function LoadRow()
		Dim RsRow, sSql, sFilter
		sFilter = OrderItems.KeyFilter

		' Call Row Selecting event
		Call OrderItems.Row_Selecting(sFilter)

		' Load sql based on filter
		OrderItems.CurrentFilter = sFilter
		sSql = OrderItems.SQL
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
		Call OrderItems.Row_Selected(RsRow)
		OrderItems.ID.DbValue = RsRow("ID")
		OrderItems.OrderId.DbValue = RsRow("OrderId")
		OrderItems.MenuItemId.DbValue = RsRow("MenuItemId")
		OrderItems.MenuItemPropertyId.DbValue = RsRow("MenuItemPropertyId")
		OrderItems.Qta.DbValue = RsRow("Qta")
		OrderItems.Price.DbValue = ew_Conv(RsRow("Price"), 131)
		OrderItems.Total.DbValue = ew_Conv(RsRow("Total"), 131)
		OrderItems.toppingids.DbValue = RsRow("toppingids")
		OrderItems.dishpropertiesids.DbValue = RsRow("dishpropertiesids")
	End Sub

	' Load DbValue from recordset
	Sub LoadDbValues(Rs)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		If Rs.Eof Then Exit Sub
		OrderItems.ID.m_DbValue = Rs("ID")
		OrderItems.OrderId.m_DbValue = Rs("OrderId")
		OrderItems.MenuItemId.m_DbValue = Rs("MenuItemId")
		OrderItems.MenuItemPropertyId.m_DbValue = Rs("MenuItemPropertyId")
		OrderItems.Qta.m_DbValue = Rs("Qta")
		OrderItems.Price.m_DbValue = ew_Conv(Rs("Price"), 131)
		OrderItems.Total.m_DbValue = ew_Conv(Rs("Total"), 131)
		OrderItems.toppingids.m_DbValue = Rs("toppingids")
		OrderItems.dishpropertiesids.m_DbValue = Rs("dishpropertiesids")
	End Sub

	' -----------------------------------------------------------------
	' Render row values based on field settings
	'
	Sub RenderRow()

		' Initialize urls
		' Convert decimal values if posted back

		If OrderItems.Price.CurrentValue & "" <> "" Then OrderItems.Price.CurrentValue = ew_Conv(OrderItems.Price.CurrentValue, OrderItems.Price.FldType)
		If OrderItems.Price.FormValue = OrderItems.Price.CurrentValue And IsNumeric(OrderItems.Price.CurrentValue) Then
			OrderItems.Price.CurrentValue = ew_StrToFloat(OrderItems.Price.CurrentValue)
		End If

		' Convert decimal values if posted back
		If OrderItems.Total.CurrentValue & "" <> "" Then OrderItems.Total.CurrentValue = ew_Conv(OrderItems.Total.CurrentValue, OrderItems.Total.FldType)
		If OrderItems.Total.FormValue = OrderItems.Total.CurrentValue And IsNumeric(OrderItems.Total.CurrentValue) Then
			OrderItems.Total.CurrentValue = ew_StrToFloat(OrderItems.Total.CurrentValue)
		End If

		' Call Row Rendering event
		Call OrderItems.Row_Rendering()

		' ---------------------------------------
		'  Common render codes for all row types
		' ---------------------------------------
		' ID
		' OrderId
		' MenuItemId
		' MenuItemPropertyId
		' Qta
		' Price
		' Total
		' toppingids
		' dishpropertiesids
		' -----------
		'  View  Row
		' -----------

		If OrderItems.RowType = EW_ROWTYPE_VIEW Then ' View row

			' ID
			OrderItems.ID.ViewValue = OrderItems.ID.CurrentValue
			OrderItems.ID.ViewCustomAttributes = ""

			' OrderId
			OrderItems.OrderId.ViewValue = OrderItems.OrderId.CurrentValue
			OrderItems.OrderId.ViewCustomAttributes = ""

			' MenuItemId
			OrderItems.MenuItemId.ViewValue = OrderItems.MenuItemId.CurrentValue
			OrderItems.MenuItemId.ViewCustomAttributes = ""

			' MenuItemPropertyId
			OrderItems.MenuItemPropertyId.ViewValue = OrderItems.MenuItemPropertyId.CurrentValue
			OrderItems.MenuItemPropertyId.ViewCustomAttributes = ""

			' Qta
			OrderItems.Qta.ViewValue = OrderItems.Qta.CurrentValue
			OrderItems.Qta.ViewCustomAttributes = ""

			' Price
			OrderItems.Price.ViewValue = OrderItems.Price.CurrentValue
			OrderItems.Price.ViewCustomAttributes = ""

			' Total
			OrderItems.Total.ViewValue = OrderItems.Total.CurrentValue
			OrderItems.Total.ViewCustomAttributes = ""

			' toppingids
			OrderItems.toppingids.ViewValue = OrderItems.toppingids.CurrentValue
			OrderItems.toppingids.ViewCustomAttributes = ""

			' dishpropertiesids
			OrderItems.dishpropertiesids.ViewValue = OrderItems.dishpropertiesids.CurrentValue
			OrderItems.dishpropertiesids.ViewCustomAttributes = ""

			' View refer script
			' ID

			OrderItems.ID.LinkCustomAttributes = ""
			OrderItems.ID.HrefValue = ""
			OrderItems.ID.TooltipValue = ""

			' OrderId
			OrderItems.OrderId.LinkCustomAttributes = ""
			OrderItems.OrderId.HrefValue = ""
			OrderItems.OrderId.TooltipValue = ""

			' MenuItemId
			OrderItems.MenuItemId.LinkCustomAttributes = ""
			OrderItems.MenuItemId.HrefValue = ""
			OrderItems.MenuItemId.TooltipValue = ""

			' MenuItemPropertyId
			OrderItems.MenuItemPropertyId.LinkCustomAttributes = ""
			OrderItems.MenuItemPropertyId.HrefValue = ""
			OrderItems.MenuItemPropertyId.TooltipValue = ""

			' Qta
			OrderItems.Qta.LinkCustomAttributes = ""
			OrderItems.Qta.HrefValue = ""
			OrderItems.Qta.TooltipValue = ""

			' Price
			OrderItems.Price.LinkCustomAttributes = ""
			OrderItems.Price.HrefValue = ""
			OrderItems.Price.TooltipValue = ""

			' Total
			OrderItems.Total.LinkCustomAttributes = ""
			OrderItems.Total.HrefValue = ""
			OrderItems.Total.TooltipValue = ""

			' toppingids
			OrderItems.toppingids.LinkCustomAttributes = ""
			OrderItems.toppingids.HrefValue = ""
			OrderItems.toppingids.TooltipValue = ""

			' dishpropertiesids
			OrderItems.dishpropertiesids.LinkCustomAttributes = ""
			OrderItems.dishpropertiesids.HrefValue = ""
			OrderItems.dishpropertiesids.TooltipValue = ""
		End If

		' Call Row Rendered event
		If OrderItems.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call OrderItems.Row_Rendered()
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
		sSql = OrderItems.SQL
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
				DeleteRows = OrderItems.Row_Deleting(RsDelete)
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
			ElseIf OrderItems.CancelMessage <> "" Then
				FailureMessage = OrderItems.CancelMessage
				OrderItems.CancelMessage = ""
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
				Call OrderItems.Row_Deleted(RsOld)
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
		Call Breadcrumb.Add("list", OrderItems.TableVar, "OrderItemslist.asp", "", OrderItems.TableVar, True)
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
