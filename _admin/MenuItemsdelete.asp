<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="MenuItemsinfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim MenuItems_delete
Set MenuItems_delete = New cMenuItems_delete
Set Page = MenuItems_delete

' Page init processing
MenuItems_delete.Page_Init()

' Page main processing
MenuItems_delete.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
MenuItems_delete.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var MenuItems_delete = new ew_Page("MenuItems_delete");
MenuItems_delete.PageID = "delete"; // Page ID
var EW_PAGE_ID = MenuItems_delete.PageID; // For backward compatibility
// Form object
var fMenuItemsdelete = new ew_Form("fMenuItemsdelete");
// Form_CustomValidate event
fMenuItemsdelete.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fMenuItemsdelete.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fMenuItemsdelete.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<%

' Load records for display
Set MenuItems_delete.Recordset = MenuItems_delete.LoadRecordset()
MenuItems_delete.TotalRecs = MenuItems_delete.Recordset.RecordCount ' Get record count
If MenuItems_delete.TotalRecs <= 0 Then ' No record found, exit
	MenuItems_delete.Recordset.Close
	Set MenuItems_delete.Recordset = Nothing
	Call MenuItems_delete.Page_Terminate("MenuItemslist.asp") ' Return to list
End If
%>
<div class="ewToolbar">
<% If MenuItems.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If MenuItems.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% MenuItems_delete.ShowPageHeader() %>
<% MenuItems_delete.ShowMessage %>
<form name="fMenuItemsdelete" id="fMenuItemsdelete" class="form-inline ewForm ewDeleteForm" action="<%= ew_CurrentPage() %>" method="post">
<% If MenuItems_delete.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= MenuItems_delete.Token %>">
<% End If %>
<input type="hidden" name="t" value="MenuItems">
<input type="hidden" name="a_delete" id="a_delete" value="D">
<% For i = 0 to UBound(MenuItems_delete.RecKeys) %>
<input type="hidden" name="key_m" id="key_m" value="<%= ew_HtmlEncode(ew_GetKeyValue(MenuItems_delete.RecKeys(i))) %>">
<% Next %>
<div class="ewGrid">
<div class="<% If ew_IsResponsiveLayout() Then Response.Write "table-responsive " %>ewGridMiddlePanel">
<table class="table ewTable">
<%= MenuItems.TableCustomInnerHtml %>
	<thead>
	<tr class="ewTableHeader">
<% If MenuItems.Id.Visible Then ' Id %>
		<th><span id="elh_MenuItems_Id" class="MenuItems_Id"><%= MenuItems.Id.FldCaption %></span></th>
<% End If %>
<% If MenuItems.Code.Visible Then ' Code %>
		<th><span id="elh_MenuItems_Code" class="MenuItems_Code"><%= MenuItems.Code.FldCaption %></span></th>
<% End If %>
<% If MenuItems.Name.Visible Then ' Name %>
		<th><span id="elh_MenuItems_Name" class="MenuItems_Name"><%= MenuItems.Name.FldCaption %></span></th>
<% End If %>
<% If MenuItems.Vegetarian.Visible Then ' Vegetarian %>
		<th><span id="elh_MenuItems_Vegetarian" class="MenuItems_Vegetarian"><%= MenuItems.Vegetarian.FldCaption %></span></th>
<% End If %>
<% If MenuItems.Spicyness.Visible Then ' Spicyness %>
		<th><span id="elh_MenuItems_Spicyness" class="MenuItems_Spicyness"><%= MenuItems.Spicyness.FldCaption %></span></th>
<% End If %>
<% If MenuItems.Price.Visible Then ' Price %>
		<th><span id="elh_MenuItems_Price" class="MenuItems_Price"><%= MenuItems.Price.FldCaption %></span></th>
<% End If %>
<% If MenuItems.IdMenuCategory.Visible Then ' IdMenuCategory %>
		<th><span id="elh_MenuItems_IdMenuCategory" class="MenuItems_IdMenuCategory"><%= MenuItems.IdMenuCategory.FldCaption %></span></th>
<% End If %>
<% If MenuItems.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
		<th><span id="elh_MenuItems_IdBusinessDetail" class="MenuItems_IdBusinessDetail"><%= MenuItems.IdBusinessDetail.FldCaption %></span></th>
<% End If %>
<% If MenuItems.Photo.Visible Then ' Photo %>
		<th><span id="elh_MenuItems_Photo" class="MenuItems_Photo"><%= MenuItems.Photo.FldCaption %></span></th>
<% End If %>
<% If MenuItems.allowtoppings.Visible Then ' allowtoppings %>
		<th><span id="elh_MenuItems_allowtoppings" class="MenuItems_allowtoppings"><%= MenuItems.allowtoppings.FldCaption %></span></th>
<% End If %>
<% If MenuItems.dishpropertygroupid.Visible Then ' dishpropertygroupid %>
		<th><span id="elh_MenuItems_dishpropertygroupid" class="MenuItems_dishpropertygroupid"><%= MenuItems.dishpropertygroupid.FldCaption %></span></th>
<% End If %>
<% If MenuItems.hidedish.Visible Then ' hidedish %>
		<th><span id="elh_MenuItems_hidedish" class="MenuItems_hidedish"><%= MenuItems.hidedish.FldCaption %></span></th>
<% End If %>
<% If MenuItems.PrintingName.Visible Then ' PrintingName %>
		<th><span id="elh_MenuItems_PrintingName" class="MenuItems_PrintingName"><%= MenuItems.PrintingName.FldCaption %></span></th>
<% End If %>
<% If MenuItems.i_displaySort.Visible Then ' i_displaySort %>
		<th><span id="elh_MenuItems_i_displaySort" class="MenuItems_i_displaySort"><%= MenuItems.i_displaySort.FldCaption %></span></th>
<% End If %>
	</tr>
	</thead>
	<tbody>
<%
MenuItems_delete.RecCnt = 0
MenuItems_delete.RowCnt = 0
Do While (Not MenuItems_delete.Recordset.Eof)
	MenuItems_delete.RecCnt = MenuItems_delete.RecCnt + 1
	MenuItems_delete.RowCnt = MenuItems_delete.RowCnt + 1

	' Set row properties
	Call MenuItems.ResetAttrs()
	MenuItems.RowType = EW_ROWTYPE_VIEW ' view

	' Get the field contents
	Call MenuItems_delete.LoadRowValues(MenuItems_delete.Recordset)

	' Render row
	Call MenuItems_delete.RenderRow()
%>
	<tr<%= MenuItems.RowAttributes %>>
<% If MenuItems.Id.Visible Then ' Id %>
		<td<%= MenuItems.Id.CellAttributes %>>
<span id="el<%= MenuItems_delete.RowCnt %>_MenuItems_Id" class="form-group MenuItems_Id">
<span<%= MenuItems.Id.ViewAttributes %>>
<%= MenuItems.Id.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If MenuItems.Code.Visible Then ' Code %>
		<td<%= MenuItems.Code.CellAttributes %>>
<span id="el<%= MenuItems_delete.RowCnt %>_MenuItems_Code" class="form-group MenuItems_Code">
<span<%= MenuItems.Code.ViewAttributes %>>
<%= MenuItems.Code.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If MenuItems.Name.Visible Then ' Name %>
		<td<%= MenuItems.Name.CellAttributes %>>
<span id="el<%= MenuItems_delete.RowCnt %>_MenuItems_Name" class="form-group MenuItems_Name">
<span<%= MenuItems.Name.ViewAttributes %>>
<%= MenuItems.Name.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If MenuItems.Vegetarian.Visible Then ' Vegetarian %>
		<td<%= MenuItems.Vegetarian.CellAttributes %>>
<span id="el<%= MenuItems_delete.RowCnt %>_MenuItems_Vegetarian" class="form-group MenuItems_Vegetarian">
<span<%= MenuItems.Vegetarian.ViewAttributes %>>
<%= MenuItems.Vegetarian.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If MenuItems.Spicyness.Visible Then ' Spicyness %>
		<td<%= MenuItems.Spicyness.CellAttributes %>>
<span id="el<%= MenuItems_delete.RowCnt %>_MenuItems_Spicyness" class="form-group MenuItems_Spicyness">
<span<%= MenuItems.Spicyness.ViewAttributes %>>
<%= MenuItems.Spicyness.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If MenuItems.Price.Visible Then ' Price %>
		<td<%= MenuItems.Price.CellAttributes %>>
<span id="el<%= MenuItems_delete.RowCnt %>_MenuItems_Price" class="form-group MenuItems_Price">
<span<%= MenuItems.Price.ViewAttributes %>>
<%= MenuItems.Price.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If MenuItems.IdMenuCategory.Visible Then ' IdMenuCategory %>
		<td<%= MenuItems.IdMenuCategory.CellAttributes %>>
<span id="el<%= MenuItems_delete.RowCnt %>_MenuItems_IdMenuCategory" class="form-group MenuItems_IdMenuCategory">
<span<%= MenuItems.IdMenuCategory.ViewAttributes %>>
<%= MenuItems.IdMenuCategory.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If MenuItems.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
		<td<%= MenuItems.IdBusinessDetail.CellAttributes %>>
<span id="el<%= MenuItems_delete.RowCnt %>_MenuItems_IdBusinessDetail" class="form-group MenuItems_IdBusinessDetail">
<span<%= MenuItems.IdBusinessDetail.ViewAttributes %>>
<%= MenuItems.IdBusinessDetail.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If MenuItems.Photo.Visible Then ' Photo %>
		<td<%= MenuItems.Photo.CellAttributes %>>
<span id="el<%= MenuItems_delete.RowCnt %>_MenuItems_Photo" class="form-group MenuItems_Photo">
<span<%= MenuItems.Photo.ViewAttributes %>>
<%= MenuItems.Photo.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If MenuItems.allowtoppings.Visible Then ' allowtoppings %>
		<td<%= MenuItems.allowtoppings.CellAttributes %>>
<span id="el<%= MenuItems_delete.RowCnt %>_MenuItems_allowtoppings" class="form-group MenuItems_allowtoppings">
<span<%= MenuItems.allowtoppings.ViewAttributes %>>
<%= MenuItems.allowtoppings.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If MenuItems.dishpropertygroupid.Visible Then ' dishpropertygroupid %>
		<td<%= MenuItems.dishpropertygroupid.CellAttributes %>>
<span id="el<%= MenuItems_delete.RowCnt %>_MenuItems_dishpropertygroupid" class="form-group MenuItems_dishpropertygroupid">
<span<%= MenuItems.dishpropertygroupid.ViewAttributes %>>
<%= MenuItems.dishpropertygroupid.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If MenuItems.hidedish.Visible Then ' hidedish %>
		<td<%= MenuItems.hidedish.CellAttributes %>>
<span id="el<%= MenuItems_delete.RowCnt %>_MenuItems_hidedish" class="form-group MenuItems_hidedish">
<span<%= MenuItems.hidedish.ViewAttributes %>>
<% If ew_ConvertToBool(MenuItems.hidedish.CurrentValue) Then %>
<input type="checkbox" value="<%= MenuItems.hidedish.ListViewValue %>" checked="checked" disabled="disabled">
<% Else %>
<input type="checkbox" value="<%= MenuItems.hidedish.ListViewValue %>" disabled="disabled">
<% End If %>
</span>
</span>
</td>
<% End If %>
<% If MenuItems.PrintingName.Visible Then ' PrintingName %>
		<td<%= MenuItems.PrintingName.CellAttributes %>>
<span id="el<%= MenuItems_delete.RowCnt %>_MenuItems_PrintingName" class="form-group MenuItems_PrintingName">
<span<%= MenuItems.PrintingName.ViewAttributes %>>
<%= MenuItems.PrintingName.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If MenuItems.i_displaySort.Visible Then ' i_displaySort %>
		<td<%= MenuItems.i_displaySort.CellAttributes %>>
<span id="el<%= MenuItems_delete.RowCnt %>_MenuItems_i_displaySort" class="form-group MenuItems_i_displaySort">
<span<%= MenuItems.i_displaySort.ViewAttributes %>>
<%= MenuItems.i_displaySort.ListViewValue %>
</span>
</span>
</td>
<% End If %>
	</tr>
<%
	MenuItems_delete.Recordset.MoveNext
Loop
MenuItems_delete.Recordset.Close
Set MenuItems_delete.Recordset = Nothing
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
fMenuItemsdelete.Init();
</script>
<%
MenuItems_delete.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set MenuItems_delete = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cMenuItems_delete

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
		TableName = "MenuItems"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "MenuItems_delete"
	End Property

	' Page Name
	Public Property Get PageName()
		PageName = ew_CurrentPage()
	End Property

	' Page Url
	Public Property Get PageUrl()
		PageUrl = ew_CurrentPage() & "?"
		If MenuItems.UseTokenInUrl Then PageUrl = PageUrl & "t=" & MenuItems.TableVar & "&" ' add page token
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
		If MenuItems.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (MenuItems.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (MenuItems.TableVar = Request.QueryString("t"))
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
		If IsEmpty(MenuItems) Then Set MenuItems = New cMenuItems
		Set Table = MenuItems

		' Initialize urls
		' Initialize form object

		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "delete"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "MenuItems"

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
			results = MenuItems.GetAutoFill(Request.Form("name"), Request.Form("q"))
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
		If Not MenuItems Is Nothing Then
			If MenuItems.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = MenuItems.TableVar
				If MenuItems.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf MenuItems.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf MenuItems.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf MenuItems.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set MenuItems = Nothing
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
		RecKeys = MenuItems.GetRecordKeys() ' Load record keys
		sFilter = MenuItems.GetKeyFilter()
		If sFilter = "" Then
			Call Page_Terminate("MenuItemslist.asp") ' Prevent SQL injection, return to list
		End If

		' Set up filter (Sql Where Clause) and get Return Sql
		' Sql constructor in MenuItems class, MenuItemsinfo.asp

		MenuItems.CurrentFilter = sFilter

		' Get action
		If Request.Form("a_delete").Count > 0 Then
			MenuItems.CurrentAction = Request.Form("a_delete")
		Else
			MenuItems.CurrentAction = "D"	' Delete record directly
		End If
		Select Case MenuItems.CurrentAction
			Case "D" ' Delete
				MenuItems.SendEmail = True ' Send email on delete success
				If DeleteRows() Then ' Delete rows
					If SuccessMessage = "" Then SuccessMessage = Language.Phrase("DeleteSuccess") ' Set up success message
					Call Page_Terminate(MenuItems.ReturnUrl) ' Return to caller
				End If
		End Select
	End Sub

	' -----------------------------------------------------------------
	' Load recordset
	'
	Function LoadRecordset()

		' Load list page sql
		Dim sSql
		sSql = MenuItems.SelectSQL
		Call ew_SetDebugMsg("LoadRecordset: " & sSql) ' Show SQL for debugging

		' Load recordset
		Dim RsRecordset
		Set RsRecordset = ew_LoadRecordset(sSql)

		' Call Recordset Selected event
		Call MenuItems.Recordset_Selected(RsRecordset)
		Set LoadRecordset = RsRecordset
	End Function

	' -----------------------------------------------------------------
	' Load row based on key values
	'
	Function LoadRow()
		Dim RsRow, sSql, sFilter
		sFilter = MenuItems.KeyFilter

		' Call Row Selecting event
		Call MenuItems.Row_Selecting(sFilter)

		' Load sql based on filter
		MenuItems.CurrentFilter = sFilter
		sSql = MenuItems.SQL
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
		Call MenuItems.Row_Selected(RsRow)
		MenuItems.Id.DbValue = RsRow("Id")
		MenuItems.Code.DbValue = RsRow("Code")
		MenuItems.Name.DbValue = RsRow("Name")
		MenuItems.Description.DbValue = RsRow("Description")
		MenuItems.Vegetarian.DbValue = RsRow("Vegetarian")
		MenuItems.Spicyness.DbValue = RsRow("Spicyness")
		MenuItems.Price.DbValue = ew_Conv(RsRow("Price"), 131)
		MenuItems.IdMenuCategory.DbValue = RsRow("IdMenuCategory")
		MenuItems.IdBusinessDetail.DbValue = RsRow("IdBusinessDetail")
		MenuItems.Photo.DbValue = RsRow("Photo")
		MenuItems.allowtoppings.DbValue = RsRow("allowtoppings")
		MenuItems.dishpropertygroupid.DbValue = RsRow("dishpropertygroupid")
		MenuItems.hidedish.DbValue = ew_IIf(RsRow("hidedish"), "1", "0")
		MenuItems.PrintingName.DbValue = RsRow("PrintingName")
		MenuItems.i_displaySort.DbValue = RsRow("i_displaySort")
	End Sub

	' Load DbValue from recordset
	Sub LoadDbValues(Rs)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		If Rs.Eof Then Exit Sub
		MenuItems.Id.m_DbValue = Rs("Id")
		MenuItems.Code.m_DbValue = Rs("Code")
		MenuItems.Name.m_DbValue = Rs("Name")
		MenuItems.Description.m_DbValue = Rs("Description")
		MenuItems.Vegetarian.m_DbValue = Rs("Vegetarian")
		MenuItems.Spicyness.m_DbValue = Rs("Spicyness")
		MenuItems.Price.m_DbValue = ew_Conv(Rs("Price"), 131)
		MenuItems.IdMenuCategory.m_DbValue = Rs("IdMenuCategory")
		MenuItems.IdBusinessDetail.m_DbValue = Rs("IdBusinessDetail")
		MenuItems.Photo.m_DbValue = Rs("Photo")
		MenuItems.allowtoppings.m_DbValue = Rs("allowtoppings")
		MenuItems.dishpropertygroupid.m_DbValue = Rs("dishpropertygroupid")
		MenuItems.hidedish.m_DbValue = ew_IIf(Rs("hidedish"), "1", "0")
		MenuItems.PrintingName.m_DbValue = Rs("PrintingName")
		MenuItems.i_displaySort.m_DbValue = Rs("i_displaySort")
	End Sub

	' -----------------------------------------------------------------
	' Render row values based on field settings
	'
	Sub RenderRow()

		' Initialize urls
		' Convert decimal values if posted back

		If MenuItems.Price.CurrentValue & "" <> "" Then MenuItems.Price.CurrentValue = ew_Conv(MenuItems.Price.CurrentValue, MenuItems.Price.FldType)
		If MenuItems.Price.FormValue = MenuItems.Price.CurrentValue And IsNumeric(MenuItems.Price.CurrentValue) Then
			MenuItems.Price.CurrentValue = ew_StrToFloat(MenuItems.Price.CurrentValue)
		End If

		' Call Row Rendering event
		Call MenuItems.Row_Rendering()

		' ---------------------------------------
		'  Common render codes for all row types
		' ---------------------------------------
		' Id
		' Code
		' Name
		' Description
		' Vegetarian
		' Spicyness
		' Price
		' IdMenuCategory
		' IdBusinessDetail
		' Photo
		' allowtoppings
		' dishpropertygroupid
		' hidedish
		' PrintingName
		' i_displaySort
		' -----------
		'  View  Row
		' -----------

		If MenuItems.RowType = EW_ROWTYPE_VIEW Then ' View row

			' Id
			MenuItems.Id.ViewValue = MenuItems.Id.CurrentValue
			MenuItems.Id.ViewCustomAttributes = ""

			' Code
			MenuItems.Code.ViewValue = MenuItems.Code.CurrentValue
			MenuItems.Code.ViewCustomAttributes = ""

			' Name
			MenuItems.Name.ViewValue = MenuItems.Name.CurrentValue
			MenuItems.Name.ViewCustomAttributes = ""

			' Vegetarian
			MenuItems.Vegetarian.ViewValue = MenuItems.Vegetarian.CurrentValue
			MenuItems.Vegetarian.ViewCustomAttributes = ""

			' Spicyness
			MenuItems.Spicyness.ViewValue = MenuItems.Spicyness.CurrentValue
			MenuItems.Spicyness.ViewCustomAttributes = ""

			' Price
			MenuItems.Price.ViewValue = MenuItems.Price.CurrentValue
			MenuItems.Price.ViewCustomAttributes = ""

			' IdMenuCategory
			MenuItems.IdMenuCategory.ViewValue = MenuItems.IdMenuCategory.CurrentValue
			MenuItems.IdMenuCategory.ViewCustomAttributes = ""

			' IdBusinessDetail
			MenuItems.IdBusinessDetail.ViewValue = MenuItems.IdBusinessDetail.CurrentValue
			MenuItems.IdBusinessDetail.ViewCustomAttributes = ""

			' Photo
			MenuItems.Photo.ViewValue = MenuItems.Photo.CurrentValue
			MenuItems.Photo.ViewCustomAttributes = ""

			' allowtoppings
			MenuItems.allowtoppings.ViewValue = MenuItems.allowtoppings.CurrentValue
			MenuItems.allowtoppings.ViewCustomAttributes = ""

			' dishpropertygroupid
			MenuItems.dishpropertygroupid.ViewValue = MenuItems.dishpropertygroupid.CurrentValue
			MenuItems.dishpropertygroupid.ViewCustomAttributes = ""

			' hidedish
			If ew_ConvertToBool(MenuItems.hidedish.CurrentValue) Then
				MenuItems.hidedish.ViewValue = ew_IIf(MenuItems.hidedish.FldTagCaption(1) <> "", MenuItems.hidedish.FldTagCaption(1), "Yes")
			Else
				MenuItems.hidedish.ViewValue = ew_IIf(MenuItems.hidedish.FldTagCaption(2) <> "", MenuItems.hidedish.FldTagCaption(2), "No")
			End If
			MenuItems.hidedish.ViewCustomAttributes = ""

			' PrintingName
			MenuItems.PrintingName.ViewValue = MenuItems.PrintingName.CurrentValue
			MenuItems.PrintingName.ViewCustomAttributes = ""

			' i_displaySort
			MenuItems.i_displaySort.ViewValue = MenuItems.i_displaySort.CurrentValue
			MenuItems.i_displaySort.ViewCustomAttributes = ""

			' View refer script
			' Id

			MenuItems.Id.LinkCustomAttributes = ""
			MenuItems.Id.HrefValue = ""
			MenuItems.Id.TooltipValue = ""

			' Code
			MenuItems.Code.LinkCustomAttributes = ""
			MenuItems.Code.HrefValue = ""
			MenuItems.Code.TooltipValue = ""

			' Name
			MenuItems.Name.LinkCustomAttributes = ""
			MenuItems.Name.HrefValue = ""
			MenuItems.Name.TooltipValue = ""

			' Vegetarian
			MenuItems.Vegetarian.LinkCustomAttributes = ""
			MenuItems.Vegetarian.HrefValue = ""
			MenuItems.Vegetarian.TooltipValue = ""

			' Spicyness
			MenuItems.Spicyness.LinkCustomAttributes = ""
			MenuItems.Spicyness.HrefValue = ""
			MenuItems.Spicyness.TooltipValue = ""

			' Price
			MenuItems.Price.LinkCustomAttributes = ""
			MenuItems.Price.HrefValue = ""
			MenuItems.Price.TooltipValue = ""

			' IdMenuCategory
			MenuItems.IdMenuCategory.LinkCustomAttributes = ""
			MenuItems.IdMenuCategory.HrefValue = ""
			MenuItems.IdMenuCategory.TooltipValue = ""

			' IdBusinessDetail
			MenuItems.IdBusinessDetail.LinkCustomAttributes = ""
			MenuItems.IdBusinessDetail.HrefValue = ""
			MenuItems.IdBusinessDetail.TooltipValue = ""

			' Photo
			MenuItems.Photo.LinkCustomAttributes = ""
			MenuItems.Photo.HrefValue = ""
			MenuItems.Photo.TooltipValue = ""

			' allowtoppings
			MenuItems.allowtoppings.LinkCustomAttributes = ""
			MenuItems.allowtoppings.HrefValue = ""
			MenuItems.allowtoppings.TooltipValue = ""

			' dishpropertygroupid
			MenuItems.dishpropertygroupid.LinkCustomAttributes = ""
			MenuItems.dishpropertygroupid.HrefValue = ""
			MenuItems.dishpropertygroupid.TooltipValue = ""

			' hidedish
			MenuItems.hidedish.LinkCustomAttributes = ""
			MenuItems.hidedish.HrefValue = ""
			MenuItems.hidedish.TooltipValue = ""

			' PrintingName
			MenuItems.PrintingName.LinkCustomAttributes = ""
			MenuItems.PrintingName.HrefValue = ""
			MenuItems.PrintingName.TooltipValue = ""

			' i_displaySort
			MenuItems.i_displaySort.LinkCustomAttributes = ""
			MenuItems.i_displaySort.HrefValue = ""
			MenuItems.i_displaySort.TooltipValue = ""
		End If

		' Call Row Rendered event
		If MenuItems.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call MenuItems.Row_Rendered()
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
		sSql = MenuItems.SQL
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
				DeleteRows = MenuItems.Row_Deleting(RsDelete)
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
				sThisKey = sThisKey & RsDelete("Id")
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
			ElseIf MenuItems.CancelMessage <> "" Then
				FailureMessage = MenuItems.CancelMessage
				MenuItems.CancelMessage = ""
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
				Call MenuItems.Row_Deleted(RsOld)
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
		Call Breadcrumb.Add("list", MenuItems.TableVar, "MenuItemslist.asp", "", MenuItems.TableVar, True)
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
