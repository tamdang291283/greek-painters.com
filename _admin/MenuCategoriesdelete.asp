<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="MenuCategoriesinfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim MenuCategories_delete
Set MenuCategories_delete = New cMenuCategories_delete
Set Page = MenuCategories_delete

' Page init processing
MenuCategories_delete.Page_Init()

' Page main processing
MenuCategories_delete.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
MenuCategories_delete.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var MenuCategories_delete = new ew_Page("MenuCategories_delete");
MenuCategories_delete.PageID = "delete"; // Page ID
var EW_PAGE_ID = MenuCategories_delete.PageID; // For backward compatibility
// Form object
var fMenuCategoriesdelete = new ew_Form("fMenuCategoriesdelete");
// Form_CustomValidate event
fMenuCategoriesdelete.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fMenuCategoriesdelete.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fMenuCategoriesdelete.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<%

' Load records for display
Set MenuCategories_delete.Recordset = MenuCategories_delete.LoadRecordset()
MenuCategories_delete.TotalRecs = MenuCategories_delete.Recordset.RecordCount ' Get record count
If MenuCategories_delete.TotalRecs <= 0 Then ' No record found, exit
	MenuCategories_delete.Recordset.Close
	Set MenuCategories_delete.Recordset = Nothing
	Call MenuCategories_delete.Page_Terminate("MenuCategorieslist.asp") ' Return to list
End If
%>
<div class="ewToolbar">
<% If MenuCategories.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If MenuCategories.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% MenuCategories_delete.ShowPageHeader() %>
<% MenuCategories_delete.ShowMessage %>
<form name="fMenuCategoriesdelete" id="fMenuCategoriesdelete" class="form-inline ewForm ewDeleteForm" action="<%= ew_CurrentPage() %>" method="post">
<% If MenuCategories_delete.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= MenuCategories_delete.Token %>">
<% End If %>
<input type="hidden" name="t" value="MenuCategories">
<input type="hidden" name="a_delete" id="a_delete" value="D">
<% For i = 0 to UBound(MenuCategories_delete.RecKeys) %>
<input type="hidden" name="key_m" id="key_m" value="<%= ew_HtmlEncode(ew_GetKeyValue(MenuCategories_delete.RecKeys(i))) %>">
<% Next %>
<div class="ewGrid">
<div class="<% If ew_IsResponsiveLayout() Then Response.Write "table-responsive " %>ewGridMiddlePanel">
<table class="table ewTable">
<%= MenuCategories.TableCustomInnerHtml %>
	<thead>
	<tr class="ewTableHeader">
<% If MenuCategories.ID.Visible Then ' ID %>
		<th><span id="elh_MenuCategories_ID" class="MenuCategories_ID"><%= MenuCategories.ID.FldCaption %></span></th>
<% End If %>
<% If MenuCategories.Name.Visible Then ' Name %>
		<th><span id="elh_MenuCategories_Name" class="MenuCategories_Name"><%= MenuCategories.Name.FldCaption %></span></th>
<% End If %>
<% If MenuCategories.Description.Visible Then ' Description %>
		<th><span id="elh_MenuCategories_Description" class="MenuCategories_Description"><%= MenuCategories.Description.FldCaption %></span></th>
<% End If %>
<% If MenuCategories.displayorder.Visible Then ' displayorder %>
		<th><span id="elh_MenuCategories_displayorder" class="MenuCategories_displayorder"><%= MenuCategories.displayorder.FldCaption %></span></th>
<% End If %>
<% If MenuCategories.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
		<th><span id="elh_MenuCategories_IdBusinessDetail" class="MenuCategories_IdBusinessDetail"><%= MenuCategories.IdBusinessDetail.FldCaption %></span></th>
<% End If %>
	</tr>
	</thead>
	<tbody>
<%
MenuCategories_delete.RecCnt = 0
MenuCategories_delete.RowCnt = 0
Do While (Not MenuCategories_delete.Recordset.Eof)
	MenuCategories_delete.RecCnt = MenuCategories_delete.RecCnt + 1
	MenuCategories_delete.RowCnt = MenuCategories_delete.RowCnt + 1

	' Set row properties
	Call MenuCategories.ResetAttrs()
	MenuCategories.RowType = EW_ROWTYPE_VIEW ' view

	' Get the field contents
	Call MenuCategories_delete.LoadRowValues(MenuCategories_delete.Recordset)

	' Render row
	Call MenuCategories_delete.RenderRow()
%>
	<tr<%= MenuCategories.RowAttributes %>>
<% If MenuCategories.ID.Visible Then ' ID %>
		<td<%= MenuCategories.ID.CellAttributes %>>
<span id="el<%= MenuCategories_delete.RowCnt %>_MenuCategories_ID" class="form-group MenuCategories_ID">
<span<%= MenuCategories.ID.ViewAttributes %>>
<%= MenuCategories.ID.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If MenuCategories.Name.Visible Then ' Name %>
		<td<%= MenuCategories.Name.CellAttributes %>>
<span id="el<%= MenuCategories_delete.RowCnt %>_MenuCategories_Name" class="form-group MenuCategories_Name">
<span<%= MenuCategories.Name.ViewAttributes %>>
<%= MenuCategories.Name.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If MenuCategories.Description.Visible Then ' Description %>
		<td<%= MenuCategories.Description.CellAttributes %>>
<span id="el<%= MenuCategories_delete.RowCnt %>_MenuCategories_Description" class="form-group MenuCategories_Description">
<span<%= MenuCategories.Description.ViewAttributes %>>
<%= MenuCategories.Description.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If MenuCategories.displayorder.Visible Then ' displayorder %>
		<td<%= MenuCategories.displayorder.CellAttributes %>>
<span id="el<%= MenuCategories_delete.RowCnt %>_MenuCategories_displayorder" class="form-group MenuCategories_displayorder">
<span<%= MenuCategories.displayorder.ViewAttributes %>>
<%= MenuCategories.displayorder.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If MenuCategories.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
		<td<%= MenuCategories.IdBusinessDetail.CellAttributes %>>
<span id="el<%= MenuCategories_delete.RowCnt %>_MenuCategories_IdBusinessDetail" class="form-group MenuCategories_IdBusinessDetail">
<span<%= MenuCategories.IdBusinessDetail.ViewAttributes %>>
<%= MenuCategories.IdBusinessDetail.ListViewValue %>
</span>
</span>
</td>
<% End If %>
	</tr>
<%
	MenuCategories_delete.Recordset.MoveNext
Loop
MenuCategories_delete.Recordset.Close
Set MenuCategories_delete.Recordset = Nothing
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
fMenuCategoriesdelete.Init();
</script>
<%
MenuCategories_delete.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set MenuCategories_delete = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cMenuCategories_delete

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
		TableName = "MenuCategories"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "MenuCategories_delete"
	End Property

	' Page Name
	Public Property Get PageName()
		PageName = ew_CurrentPage()
	End Property

	' Page Url
	Public Property Get PageUrl()
		PageUrl = ew_CurrentPage() & "?"
		If MenuCategories.UseTokenInUrl Then PageUrl = PageUrl & "t=" & MenuCategories.TableVar & "&" ' add page token
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
		If MenuCategories.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (MenuCategories.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (MenuCategories.TableVar = Request.QueryString("t"))
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
		If IsEmpty(MenuCategories) Then Set MenuCategories = New cMenuCategories
		Set Table = MenuCategories

		' Initialize urls
		' Initialize form object

		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "delete"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "MenuCategories"

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
			results = MenuCategories.GetAutoFill(Request.Form("name"), Request.Form("q"))
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
		If Not MenuCategories Is Nothing Then
			If MenuCategories.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = MenuCategories.TableVar
				If MenuCategories.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf MenuCategories.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf MenuCategories.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf MenuCategories.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set MenuCategories = Nothing
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
		RecKeys = MenuCategories.GetRecordKeys() ' Load record keys
		sFilter = MenuCategories.GetKeyFilter()
		If sFilter = "" Then
			Call Page_Terminate("MenuCategorieslist.asp") ' Prevent SQL injection, return to list
		End If

		' Set up filter (Sql Where Clause) and get Return Sql
		' Sql constructor in MenuCategories class, MenuCategoriesinfo.asp

		MenuCategories.CurrentFilter = sFilter

		' Get action
		If Request.Form("a_delete").Count > 0 Then
			MenuCategories.CurrentAction = Request.Form("a_delete")
		Else
			MenuCategories.CurrentAction = "D"	' Delete record directly
		End If
		Select Case MenuCategories.CurrentAction
			Case "D" ' Delete
				MenuCategories.SendEmail = True ' Send email on delete success
				If DeleteRows() Then ' Delete rows
					If SuccessMessage = "" Then SuccessMessage = Language.Phrase("DeleteSuccess") ' Set up success message
					Call Page_Terminate(MenuCategories.ReturnUrl) ' Return to caller
				End If
		End Select
	End Sub

	' -----------------------------------------------------------------
	' Load recordset
	'
	Function LoadRecordset()

		' Load list page sql
		Dim sSql
		sSql = MenuCategories.SelectSQL
		Call ew_SetDebugMsg("LoadRecordset: " & sSql) ' Show SQL for debugging

		' Load recordset
		Dim RsRecordset
		Set RsRecordset = ew_LoadRecordset(sSql)

		' Call Recordset Selected event
		Call MenuCategories.Recordset_Selected(RsRecordset)
		Set LoadRecordset = RsRecordset
	End Function

	' -----------------------------------------------------------------
	' Load row based on key values
	'
	Function LoadRow()
		Dim RsRow, sSql, sFilter
		sFilter = MenuCategories.KeyFilter

		' Call Row Selecting event
		Call MenuCategories.Row_Selecting(sFilter)

		' Load sql based on filter
		MenuCategories.CurrentFilter = sFilter
		sSql = MenuCategories.SQL
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
		Call MenuCategories.Row_Selected(RsRow)
		MenuCategories.ID.DbValue = RsRow("ID")
		MenuCategories.Name.DbValue = RsRow("Name")
		MenuCategories.Description.DbValue = RsRow("Description")
		MenuCategories.displayorder.DbValue = RsRow("displayorder")
		MenuCategories.IdBusinessDetail.DbValue = RsRow("IdBusinessDetail")
	End Sub

	' Load DbValue from recordset
	Sub LoadDbValues(Rs)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		If Rs.Eof Then Exit Sub
		MenuCategories.ID.m_DbValue = Rs("ID")
		MenuCategories.Name.m_DbValue = Rs("Name")
		MenuCategories.Description.m_DbValue = Rs("Description")
		MenuCategories.displayorder.m_DbValue = Rs("displayorder")
		MenuCategories.IdBusinessDetail.m_DbValue = Rs("IdBusinessDetail")
	End Sub

	' -----------------------------------------------------------------
	' Render row values based on field settings
	'
	Sub RenderRow()

		' Initialize urls
		' Call Row Rendering event

		Call MenuCategories.Row_Rendering()

		' ---------------------------------------
		'  Common render codes for all row types
		' ---------------------------------------
		' ID
		' Name
		' Description
		' displayorder
		' IdBusinessDetail
		' -----------
		'  View  Row
		' -----------

		If MenuCategories.RowType = EW_ROWTYPE_VIEW Then ' View row

			' ID
			MenuCategories.ID.ViewValue = MenuCategories.ID.CurrentValue
			MenuCategories.ID.ViewCustomAttributes = ""

			' Name
			MenuCategories.Name.ViewValue = MenuCategories.Name.CurrentValue
			MenuCategories.Name.ViewCustomAttributes = ""

			' Description
			MenuCategories.Description.ViewValue = MenuCategories.Description.CurrentValue
			MenuCategories.Description.ViewCustomAttributes = ""

			' displayorder
			MenuCategories.displayorder.ViewValue = MenuCategories.displayorder.CurrentValue
			MenuCategories.displayorder.ViewCustomAttributes = ""

			' IdBusinessDetail
			MenuCategories.IdBusinessDetail.ViewValue = MenuCategories.IdBusinessDetail.CurrentValue
			MenuCategories.IdBusinessDetail.ViewCustomAttributes = ""

			' View refer script
			' ID

			MenuCategories.ID.LinkCustomAttributes = ""
			MenuCategories.ID.HrefValue = ""
			MenuCategories.ID.TooltipValue = ""

			' Name
			MenuCategories.Name.LinkCustomAttributes = ""
			MenuCategories.Name.HrefValue = ""
			MenuCategories.Name.TooltipValue = ""

			' Description
			MenuCategories.Description.LinkCustomAttributes = ""
			MenuCategories.Description.HrefValue = ""
			MenuCategories.Description.TooltipValue = ""

			' displayorder
			MenuCategories.displayorder.LinkCustomAttributes = ""
			MenuCategories.displayorder.HrefValue = ""
			MenuCategories.displayorder.TooltipValue = ""

			' IdBusinessDetail
			MenuCategories.IdBusinessDetail.LinkCustomAttributes = ""
			MenuCategories.IdBusinessDetail.HrefValue = ""
			MenuCategories.IdBusinessDetail.TooltipValue = ""
		End If

		' Call Row Rendered event
		If MenuCategories.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call MenuCategories.Row_Rendered()
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
		sSql = MenuCategories.SQL
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
				DeleteRows = MenuCategories.Row_Deleting(RsDelete)
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
			ElseIf MenuCategories.CancelMessage <> "" Then
				FailureMessage = MenuCategories.CancelMessage
				MenuCategories.CancelMessage = ""
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
				Call MenuCategories.Row_Deleted(RsOld)
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
		Call Breadcrumb.Add("list", MenuCategories.TableVar, "MenuCategorieslist.asp", "", MenuCategories.TableVar, True)
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
