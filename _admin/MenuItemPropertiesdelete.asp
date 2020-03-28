<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="MenuItemPropertiesinfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim MenuItemProperties_delete
Set MenuItemProperties_delete = New cMenuItemProperties_delete
Set Page = MenuItemProperties_delete

' Page init processing
MenuItemProperties_delete.Page_Init()

' Page main processing
MenuItemProperties_delete.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
MenuItemProperties_delete.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var MenuItemProperties_delete = new ew_Page("MenuItemProperties_delete");
MenuItemProperties_delete.PageID = "delete"; // Page ID
var EW_PAGE_ID = MenuItemProperties_delete.PageID; // For backward compatibility
// Form object
var fMenuItemPropertiesdelete = new ew_Form("fMenuItemPropertiesdelete");
// Form_CustomValidate event
fMenuItemPropertiesdelete.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fMenuItemPropertiesdelete.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fMenuItemPropertiesdelete.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<%

' Load records for display
Set MenuItemProperties_delete.Recordset = MenuItemProperties_delete.LoadRecordset()
MenuItemProperties_delete.TotalRecs = MenuItemProperties_delete.Recordset.RecordCount ' Get record count
If MenuItemProperties_delete.TotalRecs <= 0 Then ' No record found, exit
	MenuItemProperties_delete.Recordset.Close
	Set MenuItemProperties_delete.Recordset = Nothing
	Call MenuItemProperties_delete.Page_Terminate("MenuItemPropertieslist.asp") ' Return to list
End If
%>
<div class="ewToolbar">
<% If MenuItemProperties.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If MenuItemProperties.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% MenuItemProperties_delete.ShowPageHeader() %>
<% MenuItemProperties_delete.ShowMessage %>
<form name="fMenuItemPropertiesdelete" id="fMenuItemPropertiesdelete" class="form-inline ewForm ewDeleteForm" action="<%= ew_CurrentPage() %>" method="post">
<% If MenuItemProperties_delete.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= MenuItemProperties_delete.Token %>">
<% End If %>
<input type="hidden" name="t" value="MenuItemProperties">
<input type="hidden" name="a_delete" id="a_delete" value="D">
<% For i = 0 to UBound(MenuItemProperties_delete.RecKeys) %>
<input type="hidden" name="key_m" id="key_m" value="<%= ew_HtmlEncode(ew_GetKeyValue(MenuItemProperties_delete.RecKeys(i))) %>">
<% Next %>
<div class="ewGrid">
<div class="<% If ew_IsResponsiveLayout() Then Response.Write "table-responsive " %>ewGridMiddlePanel">
<table class="table ewTable">
<%= MenuItemProperties.TableCustomInnerHtml %>
	<thead>
	<tr class="ewTableHeader">
<% If MenuItemProperties.Id.Visible Then ' Id %>
		<th><span id="elh_MenuItemProperties_Id" class="MenuItemProperties_Id"><%= MenuItemProperties.Id.FldCaption %></span></th>
<% End If %>
<% If MenuItemProperties.Name.Visible Then ' Name %>
		<th><span id="elh_MenuItemProperties_Name" class="MenuItemProperties_Name"><%= MenuItemProperties.Name.FldCaption %></span></th>
<% End If %>
<% If MenuItemProperties.Price.Visible Then ' Price %>
		<th><span id="elh_MenuItemProperties_Price" class="MenuItemProperties_Price"><%= MenuItemProperties.Price.FldCaption %></span></th>
<% End If %>
<% If MenuItemProperties.IdMenuItem.Visible Then ' IdMenuItem %>
		<th><span id="elh_MenuItemProperties_IdMenuItem" class="MenuItemProperties_IdMenuItem"><%= MenuItemProperties.IdMenuItem.FldCaption %></span></th>
<% End If %>
<% If MenuItemProperties.allowtoppings.Visible Then ' allowtoppings %>
		<th><span id="elh_MenuItemProperties_allowtoppings" class="MenuItemProperties_allowtoppings"><%= MenuItemProperties.allowtoppings.FldCaption %></span></th>
<% End If %>
<% If MenuItemProperties.dishpropertiesgroupid.Visible Then ' dishpropertiesgroupid %>
		<th><span id="elh_MenuItemProperties_dishpropertiesgroupid" class="MenuItemProperties_dishpropertiesgroupid"><%= MenuItemProperties.dishpropertiesgroupid.FldCaption %></span></th>
<% End If %>
<% If MenuItemProperties.printingname.Visible Then ' printingname %>
		<th><span id="elh_MenuItemProperties_printingname" class="MenuItemProperties_printingname"><%= MenuItemProperties.printingname.FldCaption %></span></th>
<% End If %>
<% If MenuItemProperties.i_displaysort.Visible Then ' i_displaysort %>
		<th><span id="elh_MenuItemProperties_i_displaysort" class="MenuItemProperties_i_displaysort"><%= MenuItemProperties.i_displaysort.FldCaption %></span></th>
<% End If %>
	</tr>
	</thead>
	<tbody>
<%
MenuItemProperties_delete.RecCnt = 0
MenuItemProperties_delete.RowCnt = 0
Do While (Not MenuItemProperties_delete.Recordset.Eof)
	MenuItemProperties_delete.RecCnt = MenuItemProperties_delete.RecCnt + 1
	MenuItemProperties_delete.RowCnt = MenuItemProperties_delete.RowCnt + 1

	' Set row properties
	Call MenuItemProperties.ResetAttrs()
	MenuItemProperties.RowType = EW_ROWTYPE_VIEW ' view

	' Get the field contents
	Call MenuItemProperties_delete.LoadRowValues(MenuItemProperties_delete.Recordset)

	' Render row
	Call MenuItemProperties_delete.RenderRow()
%>
	<tr<%= MenuItemProperties.RowAttributes %>>
<% If MenuItemProperties.Id.Visible Then ' Id %>
		<td<%= MenuItemProperties.Id.CellAttributes %>>
<span id="el<%= MenuItemProperties_delete.RowCnt %>_MenuItemProperties_Id" class="form-group MenuItemProperties_Id">
<span<%= MenuItemProperties.Id.ViewAttributes %>>
<%= MenuItemProperties.Id.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If MenuItemProperties.Name.Visible Then ' Name %>
		<td<%= MenuItemProperties.Name.CellAttributes %>>
<span id="el<%= MenuItemProperties_delete.RowCnt %>_MenuItemProperties_Name" class="form-group MenuItemProperties_Name">
<span<%= MenuItemProperties.Name.ViewAttributes %>>
<%= MenuItemProperties.Name.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If MenuItemProperties.Price.Visible Then ' Price %>
		<td<%= MenuItemProperties.Price.CellAttributes %>>
<span id="el<%= MenuItemProperties_delete.RowCnt %>_MenuItemProperties_Price" class="form-group MenuItemProperties_Price">
<span<%= MenuItemProperties.Price.ViewAttributes %>>
<%= MenuItemProperties.Price.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If MenuItemProperties.IdMenuItem.Visible Then ' IdMenuItem %>
		<td<%= MenuItemProperties.IdMenuItem.CellAttributes %>>
<span id="el<%= MenuItemProperties_delete.RowCnt %>_MenuItemProperties_IdMenuItem" class="form-group MenuItemProperties_IdMenuItem">
<span<%= MenuItemProperties.IdMenuItem.ViewAttributes %>>
<%= MenuItemProperties.IdMenuItem.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If MenuItemProperties.allowtoppings.Visible Then ' allowtoppings %>
		<td<%= MenuItemProperties.allowtoppings.CellAttributes %>>
<span id="el<%= MenuItemProperties_delete.RowCnt %>_MenuItemProperties_allowtoppings" class="form-group MenuItemProperties_allowtoppings">
<span<%= MenuItemProperties.allowtoppings.ViewAttributes %>>
<%= MenuItemProperties.allowtoppings.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If MenuItemProperties.dishpropertiesgroupid.Visible Then ' dishpropertiesgroupid %>
		<td<%= MenuItemProperties.dishpropertiesgroupid.CellAttributes %>>
<span id="el<%= MenuItemProperties_delete.RowCnt %>_MenuItemProperties_dishpropertiesgroupid" class="form-group MenuItemProperties_dishpropertiesgroupid">
<span<%= MenuItemProperties.dishpropertiesgroupid.ViewAttributes %>>
<%= MenuItemProperties.dishpropertiesgroupid.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If MenuItemProperties.printingname.Visible Then ' printingname %>
		<td<%= MenuItemProperties.printingname.CellAttributes %>>
<span id="el<%= MenuItemProperties_delete.RowCnt %>_MenuItemProperties_printingname" class="form-group MenuItemProperties_printingname">
<span<%= MenuItemProperties.printingname.ViewAttributes %>>
<%= MenuItemProperties.printingname.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If MenuItemProperties.i_displaysort.Visible Then ' i_displaysort %>
		<td<%= MenuItemProperties.i_displaysort.CellAttributes %>>
<span id="el<%= MenuItemProperties_delete.RowCnt %>_MenuItemProperties_i_displaysort" class="form-group MenuItemProperties_i_displaysort">
<span<%= MenuItemProperties.i_displaysort.ViewAttributes %>>
<%= MenuItemProperties.i_displaysort.ListViewValue %>
</span>
</span>
</td>
<% End If %>
	</tr>
<%
	MenuItemProperties_delete.Recordset.MoveNext
Loop
MenuItemProperties_delete.Recordset.Close
Set MenuItemProperties_delete.Recordset = Nothing
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
fMenuItemPropertiesdelete.Init();
</script>
<%
MenuItemProperties_delete.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set MenuItemProperties_delete = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cMenuItemProperties_delete

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
		TableName = "MenuItemProperties"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "MenuItemProperties_delete"
	End Property

	' Page Name
	Public Property Get PageName()
		PageName = ew_CurrentPage()
	End Property

	' Page Url
	Public Property Get PageUrl()
		PageUrl = ew_CurrentPage() & "?"
		If MenuItemProperties.UseTokenInUrl Then PageUrl = PageUrl & "t=" & MenuItemProperties.TableVar & "&" ' add page token
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
		If MenuItemProperties.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (MenuItemProperties.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (MenuItemProperties.TableVar = Request.QueryString("t"))
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
		If IsEmpty(MenuItemProperties) Then Set MenuItemProperties = New cMenuItemProperties
		Set Table = MenuItemProperties

		' Initialize urls
		' Initialize form object

		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "delete"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "MenuItemProperties"

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
			results = MenuItemProperties.GetAutoFill(Request.Form("name"), Request.Form("q"))
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
		If Not MenuItemProperties Is Nothing Then
			If MenuItemProperties.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = MenuItemProperties.TableVar
				If MenuItemProperties.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf MenuItemProperties.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf MenuItemProperties.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf MenuItemProperties.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set MenuItemProperties = Nothing
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
		RecKeys = MenuItemProperties.GetRecordKeys() ' Load record keys
		sFilter = MenuItemProperties.GetKeyFilter()
		If sFilter = "" Then
			Call Page_Terminate("MenuItemPropertieslist.asp") ' Prevent SQL injection, return to list
		End If

		' Set up filter (Sql Where Clause) and get Return Sql
		' Sql constructor in MenuItemProperties class, MenuItemPropertiesinfo.asp

		MenuItemProperties.CurrentFilter = sFilter

		' Get action
		If Request.Form("a_delete").Count > 0 Then
			MenuItemProperties.CurrentAction = Request.Form("a_delete")
		Else
			MenuItemProperties.CurrentAction = "D"	' Delete record directly
		End If
		Select Case MenuItemProperties.CurrentAction
			Case "D" ' Delete
				MenuItemProperties.SendEmail = True ' Send email on delete success
				If DeleteRows() Then ' Delete rows
					If SuccessMessage = "" Then SuccessMessage = Language.Phrase("DeleteSuccess") ' Set up success message
					Call Page_Terminate(MenuItemProperties.ReturnUrl) ' Return to caller
				End If
		End Select
	End Sub

	' -----------------------------------------------------------------
	' Load recordset
	'
	Function LoadRecordset()

		' Load list page sql
		Dim sSql
		sSql = MenuItemProperties.SelectSQL
		Call ew_SetDebugMsg("LoadRecordset: " & sSql) ' Show SQL for debugging

		' Load recordset
		Dim RsRecordset
		Set RsRecordset = ew_LoadRecordset(sSql)

		' Call Recordset Selected event
		Call MenuItemProperties.Recordset_Selected(RsRecordset)
		Set LoadRecordset = RsRecordset
	End Function

	' -----------------------------------------------------------------
	' Load row based on key values
	'
	Function LoadRow()
		Dim RsRow, sSql, sFilter
		sFilter = MenuItemProperties.KeyFilter

		' Call Row Selecting event
		Call MenuItemProperties.Row_Selecting(sFilter)

		' Load sql based on filter
		MenuItemProperties.CurrentFilter = sFilter
		sSql = MenuItemProperties.SQL
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
		Call MenuItemProperties.Row_Selected(RsRow)
		MenuItemProperties.Id.DbValue = RsRow("Id")
		MenuItemProperties.Name.DbValue = RsRow("Name")
		MenuItemProperties.Price.DbValue = ew_Conv(RsRow("Price"), 131)
		MenuItemProperties.IdMenuItem.DbValue = RsRow("IdMenuItem")
		MenuItemProperties.allowtoppings.DbValue = RsRow("allowtoppings")
		MenuItemProperties.dishpropertiesgroupid.DbValue = RsRow("dishpropertiesgroupid")
		MenuItemProperties.printingname.DbValue = RsRow("printingname")
		MenuItemProperties.i_displaysort.DbValue = RsRow("i_displaysort")
	End Sub

	' Load DbValue from recordset
	Sub LoadDbValues(Rs)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		If Rs.Eof Then Exit Sub
		MenuItemProperties.Id.m_DbValue = Rs("Id")
		MenuItemProperties.Name.m_DbValue = Rs("Name")
		MenuItemProperties.Price.m_DbValue = ew_Conv(Rs("Price"), 131)
		MenuItemProperties.IdMenuItem.m_DbValue = Rs("IdMenuItem")
		MenuItemProperties.allowtoppings.m_DbValue = Rs("allowtoppings")
		MenuItemProperties.dishpropertiesgroupid.m_DbValue = Rs("dishpropertiesgroupid")
		MenuItemProperties.printingname.m_DbValue = Rs("printingname")
		MenuItemProperties.i_displaysort.m_DbValue = Rs("i_displaysort")
	End Sub

	' -----------------------------------------------------------------
	' Render row values based on field settings
	'
	Sub RenderRow()

		' Initialize urls
		' Convert decimal values if posted back

		If MenuItemProperties.Price.CurrentValue & "" <> "" Then MenuItemProperties.Price.CurrentValue = ew_Conv(MenuItemProperties.Price.CurrentValue, MenuItemProperties.Price.FldType)
		If MenuItemProperties.Price.FormValue = MenuItemProperties.Price.CurrentValue And IsNumeric(MenuItemProperties.Price.CurrentValue) Then
			MenuItemProperties.Price.CurrentValue = ew_StrToFloat(MenuItemProperties.Price.CurrentValue)
		End If

		' Call Row Rendering event
		Call MenuItemProperties.Row_Rendering()

		' ---------------------------------------
		'  Common render codes for all row types
		' ---------------------------------------
		' Id
		' Name
		' Price
		' IdMenuItem
		' allowtoppings
		' dishpropertiesgroupid
		' printingname
		' i_displaysort
		' -----------
		'  View  Row
		' -----------

		If MenuItemProperties.RowType = EW_ROWTYPE_VIEW Then ' View row

			' Id
			MenuItemProperties.Id.ViewValue = MenuItemProperties.Id.CurrentValue
			MenuItemProperties.Id.ViewCustomAttributes = ""

			' Name
			MenuItemProperties.Name.ViewValue = MenuItemProperties.Name.CurrentValue
			MenuItemProperties.Name.ViewCustomAttributes = ""

			' Price
			MenuItemProperties.Price.ViewValue = MenuItemProperties.Price.CurrentValue
			MenuItemProperties.Price.ViewCustomAttributes = ""

			' IdMenuItem
			MenuItemProperties.IdMenuItem.ViewValue = MenuItemProperties.IdMenuItem.CurrentValue
			MenuItemProperties.IdMenuItem.ViewCustomAttributes = ""

			' allowtoppings
			MenuItemProperties.allowtoppings.ViewValue = MenuItemProperties.allowtoppings.CurrentValue
			MenuItemProperties.allowtoppings.ViewCustomAttributes = ""

			' dishpropertiesgroupid
			MenuItemProperties.dishpropertiesgroupid.ViewValue = MenuItemProperties.dishpropertiesgroupid.CurrentValue
			MenuItemProperties.dishpropertiesgroupid.ViewCustomAttributes = ""

			' printingname
			MenuItemProperties.printingname.ViewValue = MenuItemProperties.printingname.CurrentValue
			MenuItemProperties.printingname.ViewCustomAttributes = ""

			' i_displaysort
			MenuItemProperties.i_displaysort.ViewValue = MenuItemProperties.i_displaysort.CurrentValue
			MenuItemProperties.i_displaysort.ViewCustomAttributes = ""

			' View refer script
			' Id

			MenuItemProperties.Id.LinkCustomAttributes = ""
			MenuItemProperties.Id.HrefValue = ""
			MenuItemProperties.Id.TooltipValue = ""

			' Name
			MenuItemProperties.Name.LinkCustomAttributes = ""
			MenuItemProperties.Name.HrefValue = ""
			MenuItemProperties.Name.TooltipValue = ""

			' Price
			MenuItemProperties.Price.LinkCustomAttributes = ""
			MenuItemProperties.Price.HrefValue = ""
			MenuItemProperties.Price.TooltipValue = ""

			' IdMenuItem
			MenuItemProperties.IdMenuItem.LinkCustomAttributes = ""
			MenuItemProperties.IdMenuItem.HrefValue = ""
			MenuItemProperties.IdMenuItem.TooltipValue = ""

			' allowtoppings
			MenuItemProperties.allowtoppings.LinkCustomAttributes = ""
			MenuItemProperties.allowtoppings.HrefValue = ""
			MenuItemProperties.allowtoppings.TooltipValue = ""

			' dishpropertiesgroupid
			MenuItemProperties.dishpropertiesgroupid.LinkCustomAttributes = ""
			MenuItemProperties.dishpropertiesgroupid.HrefValue = ""
			MenuItemProperties.dishpropertiesgroupid.TooltipValue = ""

			' printingname
			MenuItemProperties.printingname.LinkCustomAttributes = ""
			MenuItemProperties.printingname.HrefValue = ""
			MenuItemProperties.printingname.TooltipValue = ""

			' i_displaysort
			MenuItemProperties.i_displaysort.LinkCustomAttributes = ""
			MenuItemProperties.i_displaysort.HrefValue = ""
			MenuItemProperties.i_displaysort.TooltipValue = ""
		End If

		' Call Row Rendered event
		If MenuItemProperties.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call MenuItemProperties.Row_Rendered()
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
		sSql = MenuItemProperties.SQL
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
				DeleteRows = MenuItemProperties.Row_Deleting(RsDelete)
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
			ElseIf MenuItemProperties.CancelMessage <> "" Then
				FailureMessage = MenuItemProperties.CancelMessage
				MenuItemProperties.CancelMessage = ""
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
				Call MenuItemProperties.Row_Deleted(RsOld)
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
		Call Breadcrumb.Add("list", MenuItemProperties.TableVar, "MenuItemPropertieslist.asp", "", MenuItemProperties.TableVar, True)
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
