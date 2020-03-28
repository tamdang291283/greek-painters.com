<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="URL_REWRITEinfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim URL_REWRITE_delete
Set URL_REWRITE_delete = New cURL_REWRITE_delete
Set Page = URL_REWRITE_delete

' Page init processing
URL_REWRITE_delete.Page_Init()

' Page main processing
URL_REWRITE_delete.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
URL_REWRITE_delete.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var URL_REWRITE_delete = new ew_Page("URL_REWRITE_delete");
URL_REWRITE_delete.PageID = "delete"; // Page ID
var EW_PAGE_ID = URL_REWRITE_delete.PageID; // For backward compatibility
// Form object
var fURL_REWRITEdelete = new ew_Form("fURL_REWRITEdelete");
// Form_CustomValidate event
fURL_REWRITEdelete.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fURL_REWRITEdelete.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fURL_REWRITEdelete.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<%

' Load records for display
Set URL_REWRITE_delete.Recordset = URL_REWRITE_delete.LoadRecordset()
URL_REWRITE_delete.TotalRecs = URL_REWRITE_delete.Recordset.RecordCount ' Get record count
If URL_REWRITE_delete.TotalRecs <= 0 Then ' No record found, exit
	URL_REWRITE_delete.Recordset.Close
	Set URL_REWRITE_delete.Recordset = Nothing
	Call URL_REWRITE_delete.Page_Terminate("URL_REWRITElist.asp") ' Return to list
End If
%>
<div class="ewToolbar">
<% If URL_REWRITE.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If URL_REWRITE.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% URL_REWRITE_delete.ShowPageHeader() %>
<% URL_REWRITE_delete.ShowMessage %>
<form name="fURL_REWRITEdelete" id="fURL_REWRITEdelete" class="form-inline ewForm ewDeleteForm" action="<%= ew_CurrentPage() %>" method="post">
<% If URL_REWRITE_delete.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= URL_REWRITE_delete.Token %>">
<% End If %>
<input type="hidden" name="t" value="URL_REWRITE">
<input type="hidden" name="a_delete" id="a_delete" value="D">
<% For i = 0 to UBound(URL_REWRITE_delete.RecKeys) %>
<input type="hidden" name="key_m" id="key_m" value="<%= ew_HtmlEncode(ew_GetKeyValue(URL_REWRITE_delete.RecKeys(i))) %>">
<% Next %>
<div class="ewGrid">
<div class="<% If ew_IsResponsiveLayout() Then Response.Write "table-responsive " %>ewGridMiddlePanel">
<table class="table ewTable">
<%= URL_REWRITE.TableCustomInnerHtml %>
	<thead>
	<tr class="ewTableHeader">
<% If URL_REWRITE.ID.Visible Then ' ID %>
		<th><span id="elh_URL_REWRITE_ID" class="URL_REWRITE_ID"><%= URL_REWRITE.ID.FldCaption %></span></th>
<% End If %>
<% If URL_REWRITE.FromLink.Visible Then ' FromLink %>
		<th><span id="elh_URL_REWRITE_FromLink" class="URL_REWRITE_FromLink"><%= URL_REWRITE.FromLink.FldCaption %></span></th>
<% End If %>
<% If URL_REWRITE.Tolink.Visible Then ' Tolink %>
		<th><span id="elh_URL_REWRITE_Tolink" class="URL_REWRITE_Tolink"><%= URL_REWRITE.Tolink.FldCaption %></span></th>
<% End If %>
<% If URL_REWRITE.RestaurantID.Visible Then ' RestaurantID %>
		<th><span id="elh_URL_REWRITE_RestaurantID" class="URL_REWRITE_RestaurantID"><%= URL_REWRITE.RestaurantID.FldCaption %></span></th>
<% End If %>
<% If URL_REWRITE.Status.Visible Then ' Status %>
		<th><span id="elh_URL_REWRITE_Status" class="URL_REWRITE_Status"><%= URL_REWRITE.Status.FldCaption %></span></th>
<% End If %>
<% If URL_REWRITE.businessname.Visible Then ' businessname %>
		<th><span id="elh_URL_REWRITE_businessname" class="URL_REWRITE_businessname"><%= URL_REWRITE.businessname.FldCaption %></span></th>
<% End If %>
<% If URL_REWRITE.postcode.Visible Then ' postcode %>
		<th><span id="elh_URL_REWRITE_postcode" class="URL_REWRITE_postcode"><%= URL_REWRITE.postcode.FldCaption %></span></th>
<% End If %>
<% If URL_REWRITE.phonenumber.Visible Then ' phonenumber %>
		<th><span id="elh_URL_REWRITE_phonenumber" class="URL_REWRITE_phonenumber"><%= URL_REWRITE.phonenumber.FldCaption %></span></th>
<% End If %>
	</tr>
	</thead>
	<tbody>
<%
URL_REWRITE_delete.RecCnt = 0
URL_REWRITE_delete.RowCnt = 0
Do While (Not URL_REWRITE_delete.Recordset.Eof)
	URL_REWRITE_delete.RecCnt = URL_REWRITE_delete.RecCnt + 1
	URL_REWRITE_delete.RowCnt = URL_REWRITE_delete.RowCnt + 1

	' Set row properties
	Call URL_REWRITE.ResetAttrs()
	URL_REWRITE.RowType = EW_ROWTYPE_VIEW ' view

	' Get the field contents
	Call URL_REWRITE_delete.LoadRowValues(URL_REWRITE_delete.Recordset)

	' Render row
	Call URL_REWRITE_delete.RenderRow()
%>
	<tr<%= URL_REWRITE.RowAttributes %>>
<% If URL_REWRITE.ID.Visible Then ' ID %>
		<td<%= URL_REWRITE.ID.CellAttributes %>>
<span id="el<%= URL_REWRITE_delete.RowCnt %>_URL_REWRITE_ID" class="form-group URL_REWRITE_ID">
<span<%= URL_REWRITE.ID.ViewAttributes %>>
<%= URL_REWRITE.ID.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If URL_REWRITE.FromLink.Visible Then ' FromLink %>
		<td<%= URL_REWRITE.FromLink.CellAttributes %>>
<span id="el<%= URL_REWRITE_delete.RowCnt %>_URL_REWRITE_FromLink" class="form-group URL_REWRITE_FromLink">
<span<%= URL_REWRITE.FromLink.ViewAttributes %>>
<%= URL_REWRITE.FromLink.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If URL_REWRITE.Tolink.Visible Then ' Tolink %>
		<td<%= URL_REWRITE.Tolink.CellAttributes %>>
<span id="el<%= URL_REWRITE_delete.RowCnt %>_URL_REWRITE_Tolink" class="form-group URL_REWRITE_Tolink">
<span<%= URL_REWRITE.Tolink.ViewAttributes %>>
<%= URL_REWRITE.Tolink.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If URL_REWRITE.RestaurantID.Visible Then ' RestaurantID %>
		<td<%= URL_REWRITE.RestaurantID.CellAttributes %>>
<span id="el<%= URL_REWRITE_delete.RowCnt %>_URL_REWRITE_RestaurantID" class="form-group URL_REWRITE_RestaurantID">
<span<%= URL_REWRITE.RestaurantID.ViewAttributes %>>
<%= URL_REWRITE.RestaurantID.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If URL_REWRITE.Status.Visible Then ' Status %>
		<td<%= URL_REWRITE.Status.CellAttributes %>>
<span id="el<%= URL_REWRITE_delete.RowCnt %>_URL_REWRITE_Status" class="form-group URL_REWRITE_Status">
<span<%= URL_REWRITE.Status.ViewAttributes %>>
<%= URL_REWRITE.Status.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If URL_REWRITE.businessname.Visible Then ' businessname %>
		<td<%= URL_REWRITE.businessname.CellAttributes %>>
<span id="el<%= URL_REWRITE_delete.RowCnt %>_URL_REWRITE_businessname" class="form-group URL_REWRITE_businessname">
<span<%= URL_REWRITE.businessname.ViewAttributes %>>
<%= URL_REWRITE.businessname.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If URL_REWRITE.postcode.Visible Then ' postcode %>
		<td<%= URL_REWRITE.postcode.CellAttributes %>>
<span id="el<%= URL_REWRITE_delete.RowCnt %>_URL_REWRITE_postcode" class="form-group URL_REWRITE_postcode">
<span<%= URL_REWRITE.postcode.ViewAttributes %>>
<%= URL_REWRITE.postcode.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If URL_REWRITE.phonenumber.Visible Then ' phonenumber %>
		<td<%= URL_REWRITE.phonenumber.CellAttributes %>>
<span id="el<%= URL_REWRITE_delete.RowCnt %>_URL_REWRITE_phonenumber" class="form-group URL_REWRITE_phonenumber">
<span<%= URL_REWRITE.phonenumber.ViewAttributes %>>
<%= URL_REWRITE.phonenumber.ListViewValue %>
</span>
</span>
</td>
<% End If %>
	</tr>
<%
	URL_REWRITE_delete.Recordset.MoveNext
Loop
URL_REWRITE_delete.Recordset.Close
Set URL_REWRITE_delete.Recordset = Nothing
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
fURL_REWRITEdelete.Init();
</script>
<%
URL_REWRITE_delete.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set URL_REWRITE_delete = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cURL_REWRITE_delete

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
		TableName = "URL_REWRITE"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "URL_REWRITE_delete"
	End Property

	' Page Name
	Public Property Get PageName()
		PageName = ew_CurrentPage()
	End Property

	' Page Url
	Public Property Get PageUrl()
		PageUrl = ew_CurrentPage() & "?"
		If URL_REWRITE.UseTokenInUrl Then PageUrl = PageUrl & "t=" & URL_REWRITE.TableVar & "&" ' add page token
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
		If URL_REWRITE.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (URL_REWRITE.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (URL_REWRITE.TableVar = Request.QueryString("t"))
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
		If IsEmpty(URL_REWRITE) Then Set URL_REWRITE = New cURL_REWRITE
		Set Table = URL_REWRITE

		' Initialize urls
		' Initialize form object

		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "delete"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "URL_REWRITE"

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
			results = URL_REWRITE.GetAutoFill(Request.Form("name"), Request.Form("q"))
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
		If Not URL_REWRITE Is Nothing Then
			If URL_REWRITE.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = URL_REWRITE.TableVar
				If URL_REWRITE.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf URL_REWRITE.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf URL_REWRITE.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf URL_REWRITE.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set URL_REWRITE = Nothing
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
		RecKeys = URL_REWRITE.GetRecordKeys() ' Load record keys
		sFilter = URL_REWRITE.GetKeyFilter()
		If sFilter = "" Then
			Call Page_Terminate("URL_REWRITElist.asp") ' Prevent SQL injection, return to list
		End If

		' Set up filter (Sql Where Clause) and get Return Sql
		' Sql constructor in URL_REWRITE class, URL_REWRITEinfo.asp

		URL_REWRITE.CurrentFilter = sFilter

		' Get action
		If Request.Form("a_delete").Count > 0 Then
			URL_REWRITE.CurrentAction = Request.Form("a_delete")
		Else
			URL_REWRITE.CurrentAction = "D"	' Delete record directly
		End If
		Select Case URL_REWRITE.CurrentAction
			Case "D" ' Delete
				URL_REWRITE.SendEmail = True ' Send email on delete success
				If DeleteRows() Then ' Delete rows
					If SuccessMessage = "" Then SuccessMessage = Language.Phrase("DeleteSuccess") ' Set up success message
					Call Page_Terminate(URL_REWRITE.ReturnUrl) ' Return to caller
				End If
		End Select
	End Sub

	' -----------------------------------------------------------------
	' Load recordset
	'
	Function LoadRecordset()

		' Load list page sql
		Dim sSql
		sSql = URL_REWRITE.SelectSQL
		Call ew_SetDebugMsg("LoadRecordset: " & sSql) ' Show SQL for debugging

		' Load recordset
		Dim RsRecordset
		Set RsRecordset = ew_LoadRecordset(sSql)

		' Call Recordset Selected event
		Call URL_REWRITE.Recordset_Selected(RsRecordset)
		Set LoadRecordset = RsRecordset
	End Function

	' -----------------------------------------------------------------
	' Load row based on key values
	'
	Function LoadRow()
		Dim RsRow, sSql, sFilter
		sFilter = URL_REWRITE.KeyFilter

		' Call Row Selecting event
		Call URL_REWRITE.Row_Selecting(sFilter)

		' Load sql based on filter
		URL_REWRITE.CurrentFilter = sFilter
		sSql = URL_REWRITE.SQL
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
		Call URL_REWRITE.Row_Selected(RsRow)
		URL_REWRITE.ID.DbValue = RsRow("ID")
		URL_REWRITE.FromLink.DbValue = RsRow("FromLink")
		URL_REWRITE.Tolink.DbValue = RsRow("Tolink")
		URL_REWRITE.RestaurantID.DbValue = RsRow("RestaurantID")
		URL_REWRITE.Status.DbValue = RsRow("Status")
		URL_REWRITE.businessname.DbValue = RsRow("businessname")
		URL_REWRITE.postcode.DbValue = RsRow("postcode")
		URL_REWRITE.phonenumber.DbValue = RsRow("phonenumber")
	End Sub

	' Load DbValue from recordset
	Sub LoadDbValues(Rs)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		If Rs.Eof Then Exit Sub
		URL_REWRITE.ID.m_DbValue = Rs("ID")
		URL_REWRITE.FromLink.m_DbValue = Rs("FromLink")
		URL_REWRITE.Tolink.m_DbValue = Rs("Tolink")
		URL_REWRITE.RestaurantID.m_DbValue = Rs("RestaurantID")
		URL_REWRITE.Status.m_DbValue = Rs("Status")
		URL_REWRITE.businessname.m_DbValue = Rs("businessname")
		URL_REWRITE.postcode.m_DbValue = Rs("postcode")
		URL_REWRITE.phonenumber.m_DbValue = Rs("phonenumber")
	End Sub

	' -----------------------------------------------------------------
	' Render row values based on field settings
	'
	Sub RenderRow()

		' Initialize urls
		' Call Row Rendering event

		Call URL_REWRITE.Row_Rendering()

		' ---------------------------------------
		'  Common render codes for all row types
		' ---------------------------------------
		' ID
		' FromLink
		' Tolink
		' RestaurantID
		' Status
		' businessname
		' postcode
		' phonenumber
		' -----------
		'  View  Row
		' -----------

		If URL_REWRITE.RowType = EW_ROWTYPE_VIEW Then ' View row

			' ID
			URL_REWRITE.ID.ViewValue = URL_REWRITE.ID.CurrentValue
			URL_REWRITE.ID.ViewCustomAttributes = ""

			' FromLink
			URL_REWRITE.FromLink.ViewValue = URL_REWRITE.FromLink.CurrentValue
			URL_REWRITE.FromLink.ViewCustomAttributes = ""

			' Tolink
			URL_REWRITE.Tolink.ViewValue = URL_REWRITE.Tolink.CurrentValue
			URL_REWRITE.Tolink.ViewCustomAttributes = ""

			' RestaurantID
			URL_REWRITE.RestaurantID.ViewValue = URL_REWRITE.RestaurantID.CurrentValue
			URL_REWRITE.RestaurantID.ViewCustomAttributes = ""

			' Status
			URL_REWRITE.Status.ViewValue = URL_REWRITE.Status.CurrentValue
			URL_REWRITE.Status.ViewCustomAttributes = ""

			' businessname
			URL_REWRITE.businessname.ViewValue = URL_REWRITE.businessname.CurrentValue
			URL_REWRITE.businessname.ViewCustomAttributes = ""

			' postcode
			URL_REWRITE.postcode.ViewValue = URL_REWRITE.postcode.CurrentValue
			URL_REWRITE.postcode.ViewCustomAttributes = ""

			' phonenumber
			URL_REWRITE.phonenumber.ViewValue = URL_REWRITE.phonenumber.CurrentValue
			URL_REWRITE.phonenumber.ViewCustomAttributes = ""

			' View refer script
			' ID

			URL_REWRITE.ID.LinkCustomAttributes = ""
			URL_REWRITE.ID.HrefValue = ""
			URL_REWRITE.ID.TooltipValue = ""

			' FromLink
			URL_REWRITE.FromLink.LinkCustomAttributes = ""
			URL_REWRITE.FromLink.HrefValue = ""
			URL_REWRITE.FromLink.TooltipValue = ""

			' Tolink
			URL_REWRITE.Tolink.LinkCustomAttributes = ""
			URL_REWRITE.Tolink.HrefValue = ""
			URL_REWRITE.Tolink.TooltipValue = ""

			' RestaurantID
			URL_REWRITE.RestaurantID.LinkCustomAttributes = ""
			URL_REWRITE.RestaurantID.HrefValue = ""
			URL_REWRITE.RestaurantID.TooltipValue = ""

			' Status
			URL_REWRITE.Status.LinkCustomAttributes = ""
			URL_REWRITE.Status.HrefValue = ""
			URL_REWRITE.Status.TooltipValue = ""

			' businessname
			URL_REWRITE.businessname.LinkCustomAttributes = ""
			URL_REWRITE.businessname.HrefValue = ""
			URL_REWRITE.businessname.TooltipValue = ""

			' postcode
			URL_REWRITE.postcode.LinkCustomAttributes = ""
			URL_REWRITE.postcode.HrefValue = ""
			URL_REWRITE.postcode.TooltipValue = ""

			' phonenumber
			URL_REWRITE.phonenumber.LinkCustomAttributes = ""
			URL_REWRITE.phonenumber.HrefValue = ""
			URL_REWRITE.phonenumber.TooltipValue = ""
		End If

		' Call Row Rendered event
		If URL_REWRITE.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call URL_REWRITE.Row_Rendered()
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
		sSql = URL_REWRITE.SQL
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
				DeleteRows = URL_REWRITE.Row_Deleting(RsDelete)
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
			ElseIf URL_REWRITE.CancelMessage <> "" Then
				FailureMessage = URL_REWRITE.CancelMessage
				URL_REWRITE.CancelMessage = ""
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
				Call URL_REWRITE.Row_Deleted(RsOld)
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
		Call Breadcrumb.Add("list", URL_REWRITE.TableVar, "URL_REWRITElist.asp", "", URL_REWRITE.TableVar, True)
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
