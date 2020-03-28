<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="Customer_Book_Tableinfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim Customer_Book_Table_delete
Set Customer_Book_Table_delete = New cCustomer_Book_Table_delete
Set Page = Customer_Book_Table_delete

' Page init processing
Customer_Book_Table_delete.Page_Init()

' Page main processing
Customer_Book_Table_delete.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
Customer_Book_Table_delete.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var Customer_Book_Table_delete = new ew_Page("Customer_Book_Table_delete");
Customer_Book_Table_delete.PageID = "delete"; // Page ID
var EW_PAGE_ID = Customer_Book_Table_delete.PageID; // For backward compatibility
// Form object
var fCustomer_Book_Tabledelete = new ew_Form("fCustomer_Book_Tabledelete");
// Form_CustomValidate event
fCustomer_Book_Tabledelete.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fCustomer_Book_Tabledelete.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fCustomer_Book_Tabledelete.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<%

' Load records for display
Set Customer_Book_Table_delete.Recordset = Customer_Book_Table_delete.LoadRecordset()
Customer_Book_Table_delete.TotalRecs = Customer_Book_Table_delete.Recordset.RecordCount ' Get record count
If Customer_Book_Table_delete.TotalRecs <= 0 Then ' No record found, exit
	Customer_Book_Table_delete.Recordset.Close
	Set Customer_Book_Table_delete.Recordset = Nothing
	Call Customer_Book_Table_delete.Page_Terminate("Customer_Book_Tablelist.asp") ' Return to list
End If
%>
<div class="ewToolbar">
<% If Customer_Book_Table.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If Customer_Book_Table.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% Customer_Book_Table_delete.ShowPageHeader() %>
<% Customer_Book_Table_delete.ShowMessage %>
<form name="fCustomer_Book_Tabledelete" id="fCustomer_Book_Tabledelete" class="form-inline ewForm ewDeleteForm" action="<%= ew_CurrentPage() %>" method="post">
<% If Customer_Book_Table_delete.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= Customer_Book_Table_delete.Token %>">
<% End If %>
<input type="hidden" name="t" value="Customer_Book_Table">
<input type="hidden" name="a_delete" id="a_delete" value="D">
<% For i = 0 to UBound(Customer_Book_Table_delete.RecKeys) %>
<input type="hidden" name="key_m" id="key_m" value="<%= ew_HtmlEncode(ew_GetKeyValue(Customer_Book_Table_delete.RecKeys(i))) %>">
<% Next %>
<div class="ewGrid">
<div class="<% If ew_IsResponsiveLayout() Then Response.Write "table-responsive " %>ewGridMiddlePanel">
<table class="table ewTable">
<%= Customer_Book_Table.TableCustomInnerHtml %>
	<thead>
	<tr class="ewTableHeader">
<% If Customer_Book_Table.ID.Visible Then ' ID %>
		<th><span id="elh_Customer_Book_Table_ID" class="Customer_Book_Table_ID"><%= Customer_Book_Table.ID.FldCaption %></span></th>
<% End If %>
<% If Customer_Book_Table.Name.Visible Then ' Name %>
		<th><span id="elh_Customer_Book_Table_Name" class="Customer_Book_Table_Name"><%= Customer_Book_Table.Name.FldCaption %></span></th>
<% End If %>
<% If Customer_Book_Table.Phone.Visible Then ' Phone %>
		<th><span id="elh_Customer_Book_Table_Phone" class="Customer_Book_Table_Phone"><%= Customer_Book_Table.Phone.FldCaption %></span></th>
<% End If %>
<% If Customer_Book_Table.bookdate.Visible Then ' bookdate %>
		<th><span id="elh_Customer_Book_Table_bookdate" class="Customer_Book_Table_bookdate"><%= Customer_Book_Table.bookdate.FldCaption %></span></th>
<% End If %>
<% If Customer_Book_Table.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
		<th><span id="elh_Customer_Book_Table_IdBusinessDetail" class="Customer_Book_Table_IdBusinessDetail"><%= Customer_Book_Table.IdBusinessDetail.FldCaption %></span></th>
<% End If %>
<% If Customer_Book_Table.numberpeople.Visible Then ' numberpeople %>
		<th><span id="elh_Customer_Book_Table_numberpeople" class="Customer_Book_Table_numberpeople"><%= Customer_Book_Table.numberpeople.FldCaption %></span></th>
<% End If %>
<% If Customer_Book_Table.createddate.Visible Then ' createddate %>
		<th><span id="elh_Customer_Book_Table_createddate" class="Customer_Book_Table_createddate"><%= Customer_Book_Table.createddate.FldCaption %></span></th>
<% End If %>
<% If Customer_Book_Table.zEmail.Visible Then ' Email %>
		<th><span id="elh_Customer_Book_Table_zEmail" class="Customer_Book_Table_zEmail"><%= Customer_Book_Table.zEmail.FldCaption %></span></th>
<% End If %>
	</tr>
	</thead>
	<tbody>
<%
Customer_Book_Table_delete.RecCnt = 0
Customer_Book_Table_delete.RowCnt = 0
Do While (Not Customer_Book_Table_delete.Recordset.Eof)
	Customer_Book_Table_delete.RecCnt = Customer_Book_Table_delete.RecCnt + 1
	Customer_Book_Table_delete.RowCnt = Customer_Book_Table_delete.RowCnt + 1

	' Set row properties
	Call Customer_Book_Table.ResetAttrs()
	Customer_Book_Table.RowType = EW_ROWTYPE_VIEW ' view

	' Get the field contents
	Call Customer_Book_Table_delete.LoadRowValues(Customer_Book_Table_delete.Recordset)

	' Render row
	Call Customer_Book_Table_delete.RenderRow()
%>
	<tr<%= Customer_Book_Table.RowAttributes %>>
<% If Customer_Book_Table.ID.Visible Then ' ID %>
		<td<%= Customer_Book_Table.ID.CellAttributes %>>
<span id="el<%= Customer_Book_Table_delete.RowCnt %>_Customer_Book_Table_ID" class="form-group Customer_Book_Table_ID">
<span<%= Customer_Book_Table.ID.ViewAttributes %>>
<%= Customer_Book_Table.ID.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Customer_Book_Table.Name.Visible Then ' Name %>
		<td<%= Customer_Book_Table.Name.CellAttributes %>>
<span id="el<%= Customer_Book_Table_delete.RowCnt %>_Customer_Book_Table_Name" class="form-group Customer_Book_Table_Name">
<span<%= Customer_Book_Table.Name.ViewAttributes %>>
<%= Customer_Book_Table.Name.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Customer_Book_Table.Phone.Visible Then ' Phone %>
		<td<%= Customer_Book_Table.Phone.CellAttributes %>>
<span id="el<%= Customer_Book_Table_delete.RowCnt %>_Customer_Book_Table_Phone" class="form-group Customer_Book_Table_Phone">
<span<%= Customer_Book_Table.Phone.ViewAttributes %>>
<%= Customer_Book_Table.Phone.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Customer_Book_Table.bookdate.Visible Then ' bookdate %>
		<td<%= Customer_Book_Table.bookdate.CellAttributes %>>
<span id="el<%= Customer_Book_Table_delete.RowCnt %>_Customer_Book_Table_bookdate" class="form-group Customer_Book_Table_bookdate">
<span<%= Customer_Book_Table.bookdate.ViewAttributes %>>
<%= Customer_Book_Table.bookdate.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Customer_Book_Table.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
		<td<%= Customer_Book_Table.IdBusinessDetail.CellAttributes %>>
<span id="el<%= Customer_Book_Table_delete.RowCnt %>_Customer_Book_Table_IdBusinessDetail" class="form-group Customer_Book_Table_IdBusinessDetail">
<span<%= Customer_Book_Table.IdBusinessDetail.ViewAttributes %>>
<%= Customer_Book_Table.IdBusinessDetail.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Customer_Book_Table.numberpeople.Visible Then ' numberpeople %>
		<td<%= Customer_Book_Table.numberpeople.CellAttributes %>>
<span id="el<%= Customer_Book_Table_delete.RowCnt %>_Customer_Book_Table_numberpeople" class="form-group Customer_Book_Table_numberpeople">
<span<%= Customer_Book_Table.numberpeople.ViewAttributes %>>
<%= Customer_Book_Table.numberpeople.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Customer_Book_Table.createddate.Visible Then ' createddate %>
		<td<%= Customer_Book_Table.createddate.CellAttributes %>>
<span id="el<%= Customer_Book_Table_delete.RowCnt %>_Customer_Book_Table_createddate" class="form-group Customer_Book_Table_createddate">
<span<%= Customer_Book_Table.createddate.ViewAttributes %>>
<%= Customer_Book_Table.createddate.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Customer_Book_Table.zEmail.Visible Then ' Email %>
		<td<%= Customer_Book_Table.zEmail.CellAttributes %>>
<span id="el<%= Customer_Book_Table_delete.RowCnt %>_Customer_Book_Table_zEmail" class="form-group Customer_Book_Table_zEmail">
<span<%= Customer_Book_Table.zEmail.ViewAttributes %>>
<%= Customer_Book_Table.zEmail.ListViewValue %>
</span>
</span>
</td>
<% End If %>
	</tr>
<%
	Customer_Book_Table_delete.Recordset.MoveNext
Loop
Customer_Book_Table_delete.Recordset.Close
Set Customer_Book_Table_delete.Recordset = Nothing
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
fCustomer_Book_Tabledelete.Init();
</script>
<%
Customer_Book_Table_delete.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set Customer_Book_Table_delete = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cCustomer_Book_Table_delete

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
		TableName = "Customer_Book_Table"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "Customer_Book_Table_delete"
	End Property

	' Page Name
	Public Property Get PageName()
		PageName = ew_CurrentPage()
	End Property

	' Page Url
	Public Property Get PageUrl()
		PageUrl = ew_CurrentPage() & "?"
		If Customer_Book_Table.UseTokenInUrl Then PageUrl = PageUrl & "t=" & Customer_Book_Table.TableVar & "&" ' add page token
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
		If Customer_Book_Table.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (Customer_Book_Table.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (Customer_Book_Table.TableVar = Request.QueryString("t"))
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
		If IsEmpty(Customer_Book_Table) Then Set Customer_Book_Table = New cCustomer_Book_Table
		Set Table = Customer_Book_Table

		' Initialize urls
		' Initialize form object

		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "delete"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "Customer_Book_Table"

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
			results = Customer_Book_Table.GetAutoFill(Request.Form("name"), Request.Form("q"))
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
		If Not Customer_Book_Table Is Nothing Then
			If Customer_Book_Table.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = Customer_Book_Table.TableVar
				If Customer_Book_Table.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf Customer_Book_Table.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf Customer_Book_Table.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf Customer_Book_Table.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set Customer_Book_Table = Nothing
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
		RecKeys = Customer_Book_Table.GetRecordKeys() ' Load record keys
		sFilter = Customer_Book_Table.GetKeyFilter()
		If sFilter = "" Then
			Call Page_Terminate("Customer_Book_Tablelist.asp") ' Prevent SQL injection, return to list
		End If

		' Set up filter (Sql Where Clause) and get Return Sql
		' Sql constructor in Customer_Book_Table class, Customer_Book_Tableinfo.asp

		Customer_Book_Table.CurrentFilter = sFilter

		' Get action
		If Request.Form("a_delete").Count > 0 Then
			Customer_Book_Table.CurrentAction = Request.Form("a_delete")
		Else
			Customer_Book_Table.CurrentAction = "D"	' Delete record directly
		End If
		Select Case Customer_Book_Table.CurrentAction
			Case "D" ' Delete
				Customer_Book_Table.SendEmail = True ' Send email on delete success
				If DeleteRows() Then ' Delete rows
					If SuccessMessage = "" Then SuccessMessage = Language.Phrase("DeleteSuccess") ' Set up success message
					Call Page_Terminate(Customer_Book_Table.ReturnUrl) ' Return to caller
				End If
		End Select
	End Sub

	' -----------------------------------------------------------------
	' Load recordset
	'
	Function LoadRecordset()

		' Load list page sql
		Dim sSql
		sSql = Customer_Book_Table.SelectSQL
		Call ew_SetDebugMsg("LoadRecordset: " & sSql) ' Show SQL for debugging

		' Load recordset
		Dim RsRecordset
		Set RsRecordset = ew_LoadRecordset(sSql)

		' Call Recordset Selected event
		Call Customer_Book_Table.Recordset_Selected(RsRecordset)
		Set LoadRecordset = RsRecordset
	End Function

	' -----------------------------------------------------------------
	' Load row based on key values
	'
	Function LoadRow()
		Dim RsRow, sSql, sFilter
		sFilter = Customer_Book_Table.KeyFilter

		' Call Row Selecting event
		Call Customer_Book_Table.Row_Selecting(sFilter)

		' Load sql based on filter
		Customer_Book_Table.CurrentFilter = sFilter
		sSql = Customer_Book_Table.SQL
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
		Call Customer_Book_Table.Row_Selected(RsRow)
		Customer_Book_Table.ID.DbValue = RsRow("ID")
		Customer_Book_Table.Name.DbValue = RsRow("Name")
		Customer_Book_Table.Phone.DbValue = RsRow("Phone")
		Customer_Book_Table.bookdate.DbValue = RsRow("bookdate")
		Customer_Book_Table.IdBusinessDetail.DbValue = RsRow("IdBusinessDetail")
		Customer_Book_Table.comment.DbValue = RsRow("comment")
		Customer_Book_Table.s_contentemail.DbValue = RsRow("s_contentemail")
		Customer_Book_Table.numberpeople.DbValue = RsRow("numberpeople")
		Customer_Book_Table.createddate.DbValue = RsRow("createddate")
		Customer_Book_Table.zEmail.DbValue = RsRow("Email")
	End Sub

	' Load DbValue from recordset
	Sub LoadDbValues(Rs)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		If Rs.Eof Then Exit Sub
		Customer_Book_Table.ID.m_DbValue = Rs("ID")
		Customer_Book_Table.Name.m_DbValue = Rs("Name")
		Customer_Book_Table.Phone.m_DbValue = Rs("Phone")
		Customer_Book_Table.bookdate.m_DbValue = Rs("bookdate")
		Customer_Book_Table.IdBusinessDetail.m_DbValue = Rs("IdBusinessDetail")
		Customer_Book_Table.comment.m_DbValue = Rs("comment")
		Customer_Book_Table.s_contentemail.m_DbValue = Rs("s_contentemail")
		Customer_Book_Table.numberpeople.m_DbValue = Rs("numberpeople")
		Customer_Book_Table.createddate.m_DbValue = Rs("createddate")
		Customer_Book_Table.zEmail.m_DbValue = Rs("Email")
	End Sub

	' -----------------------------------------------------------------
	' Render row values based on field settings
	'
	Sub RenderRow()

		' Initialize urls
		' Call Row Rendering event

		Call Customer_Book_Table.Row_Rendering()

		' ---------------------------------------
		'  Common render codes for all row types
		' ---------------------------------------
		' ID
		' Name
		' Phone
		' bookdate
		' IdBusinessDetail
		' comment
		' s_contentemail
		' numberpeople
		' createddate
		' Email
		' -----------
		'  View  Row
		' -----------

		If Customer_Book_Table.RowType = EW_ROWTYPE_VIEW Then ' View row

			' ID
			Customer_Book_Table.ID.ViewValue = Customer_Book_Table.ID.CurrentValue
			Customer_Book_Table.ID.ViewCustomAttributes = ""

			' Name
			Customer_Book_Table.Name.ViewValue = Customer_Book_Table.Name.CurrentValue
			Customer_Book_Table.Name.ViewCustomAttributes = ""

			' Phone
			Customer_Book_Table.Phone.ViewValue = Customer_Book_Table.Phone.CurrentValue
			Customer_Book_Table.Phone.ViewCustomAttributes = ""

			' bookdate
			Customer_Book_Table.bookdate.ViewValue = Customer_Book_Table.bookdate.CurrentValue
			Customer_Book_Table.bookdate.ViewCustomAttributes = ""

			' IdBusinessDetail
			Customer_Book_Table.IdBusinessDetail.ViewValue = Customer_Book_Table.IdBusinessDetail.CurrentValue
			Customer_Book_Table.IdBusinessDetail.ViewCustomAttributes = ""

			' numberpeople
			Customer_Book_Table.numberpeople.ViewValue = Customer_Book_Table.numberpeople.CurrentValue
			Customer_Book_Table.numberpeople.ViewCustomAttributes = ""

			' createddate
			Customer_Book_Table.createddate.ViewValue = Customer_Book_Table.createddate.CurrentValue
			Customer_Book_Table.createddate.ViewCustomAttributes = ""

			' Email
			Customer_Book_Table.zEmail.ViewValue = Customer_Book_Table.zEmail.CurrentValue
			Customer_Book_Table.zEmail.ViewCustomAttributes = ""

			' View refer script
			' ID

			Customer_Book_Table.ID.LinkCustomAttributes = ""
			Customer_Book_Table.ID.HrefValue = ""
			Customer_Book_Table.ID.TooltipValue = ""

			' Name
			Customer_Book_Table.Name.LinkCustomAttributes = ""
			Customer_Book_Table.Name.HrefValue = ""
			Customer_Book_Table.Name.TooltipValue = ""

			' Phone
			Customer_Book_Table.Phone.LinkCustomAttributes = ""
			Customer_Book_Table.Phone.HrefValue = ""
			Customer_Book_Table.Phone.TooltipValue = ""

			' bookdate
			Customer_Book_Table.bookdate.LinkCustomAttributes = ""
			Customer_Book_Table.bookdate.HrefValue = ""
			Customer_Book_Table.bookdate.TooltipValue = ""

			' IdBusinessDetail
			Customer_Book_Table.IdBusinessDetail.LinkCustomAttributes = ""
			Customer_Book_Table.IdBusinessDetail.HrefValue = ""
			Customer_Book_Table.IdBusinessDetail.TooltipValue = ""

			' numberpeople
			Customer_Book_Table.numberpeople.LinkCustomAttributes = ""
			Customer_Book_Table.numberpeople.HrefValue = ""
			Customer_Book_Table.numberpeople.TooltipValue = ""

			' createddate
			Customer_Book_Table.createddate.LinkCustomAttributes = ""
			Customer_Book_Table.createddate.HrefValue = ""
			Customer_Book_Table.createddate.TooltipValue = ""

			' Email
			Customer_Book_Table.zEmail.LinkCustomAttributes = ""
			Customer_Book_Table.zEmail.HrefValue = ""
			Customer_Book_Table.zEmail.TooltipValue = ""
		End If

		' Call Row Rendered event
		If Customer_Book_Table.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call Customer_Book_Table.Row_Rendered()
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
		sSql = Customer_Book_Table.SQL
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
				DeleteRows = Customer_Book_Table.Row_Deleting(RsDelete)
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
			ElseIf Customer_Book_Table.CancelMessage <> "" Then
				FailureMessage = Customer_Book_Table.CancelMessage
				Customer_Book_Table.CancelMessage = ""
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
				Call Customer_Book_Table.Row_Deleted(RsOld)
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
		Call Breadcrumb.Add("list", Customer_Book_Table.TableVar, "Customer_Book_Tablelist.asp", "", Customer_Book_Table.TableVar, True)
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
