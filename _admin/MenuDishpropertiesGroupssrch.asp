<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="MenuDishpropertiesGroupsinfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim MenuDishpropertiesGroups_search
Set MenuDishpropertiesGroups_search = New cMenuDishpropertiesGroups_search
Set Page = MenuDishpropertiesGroups_search

' Page init processing
MenuDishpropertiesGroups_search.Page_Init()

' Page main processing
MenuDishpropertiesGroups_search.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
MenuDishpropertiesGroups_search.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var MenuDishpropertiesGroups_search = new ew_Page("MenuDishpropertiesGroups_search");
MenuDishpropertiesGroups_search.PageID = "search"; // Page ID
var EW_PAGE_ID = MenuDishpropertiesGroups_search.PageID; // For backward compatibility
// Form object
var fMenuDishpropertiesGroupssearch = new ew_Form("fMenuDishpropertiesGroupssearch");
// Form_CustomValidate event
fMenuDishpropertiesGroupssearch.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fMenuDishpropertiesGroupssearch.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fMenuDishpropertiesGroupssearch.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
// Validate function for search
fMenuDishpropertiesGroupssearch.Validate = function(fobj) {
	if (!this.ValidateRequired)
		return true; // Ignore validation
	fobj = fobj || this.Form;
	this.PostAutoSuggest();
	var infix = "";
	elm = this.GetElements("x" + infix + "_ID");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(MenuDishpropertiesGroups.ID.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_IdBusinessDetail");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(MenuDishpropertiesGroups.IdBusinessDetail.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_dishpropertyrequired");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(MenuDishpropertiesGroups.dishpropertyrequired.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_i_displaySort");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(MenuDishpropertiesGroups.i_displaySort.FldErrMsg) %>");
	// Set up row object
	ew_ElementsToRow(fobj);
	// Fire Form_CustomValidate event
	if (!this.Form_CustomValidate(fobj))
		return false;
	return true;
}
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<% If Not MenuDishpropertiesGroups_search.IsModal Then %>
<div class="ewToolbar">
<% If MenuDishpropertiesGroups.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If MenuDishpropertiesGroups.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% End If %>
<% MenuDishpropertiesGroups_search.ShowPageHeader() %>
<% MenuDishpropertiesGroups_search.ShowMessage %>
<form name="fMenuDishpropertiesGroupssearch" id="fMenuDishpropertiesGroupssearch" class="form-horizontal ewForm ewSearchForm" action="<%= ew_CurrentPage %>" method="post">
<% If MenuDishpropertiesGroups_search.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= MenuDishpropertiesGroups_search.Token %>">
<% End If %>
<input type="hidden" name="t" value="MenuDishpropertiesGroups">
<input type="hidden" name="a_search" id="a_search" value="S">
<% If MenuDishpropertiesGroups_search.IsModal Then %>
<input type="hidden" name="modal" value="1">
<% End If %>
<div>
<% If MenuDishpropertiesGroups.ID.Visible Then ' ID %>
	<div id="r_ID" class="form-group">
		<label for="x_ID" class="<%= MenuDishpropertiesGroups_search.SearchLabelClass %>"><span id="elh_MenuDishpropertiesGroups_ID"><%= MenuDishpropertiesGroups.ID.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_ID" id="z_ID" value="="></p>
		</label>
		<div class="<%= MenuDishpropertiesGroups_search.SearchRightColumnClass %>"><div<%= MenuDishpropertiesGroups.ID.CellAttributes %>>
			<span id="el_MenuDishpropertiesGroups_ID">
<input type="text" data-field="x_ID" name="x_ID" id="x_ID" placeholder="<%= MenuDishpropertiesGroups.ID.PlaceHolder %>" value="<%= MenuDishpropertiesGroups.ID.EditValue %>"<%= MenuDishpropertiesGroups.ID.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If MenuDishpropertiesGroups.dishpropertygroup.Visible Then ' dishpropertygroup %>
	<div id="r_dishpropertygroup" class="form-group">
		<label for="x_dishpropertygroup" class="<%= MenuDishpropertiesGroups_search.SearchLabelClass %>"><span id="elh_MenuDishpropertiesGroups_dishpropertygroup"><%= MenuDishpropertiesGroups.dishpropertygroup.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_dishpropertygroup" id="z_dishpropertygroup" value="LIKE"></p>
		</label>
		<div class="<%= MenuDishpropertiesGroups_search.SearchRightColumnClass %>"><div<%= MenuDishpropertiesGroups.dishpropertygroup.CellAttributes %>>
			<span id="el_MenuDishpropertiesGroups_dishpropertygroup">
<input type="text" data-field="x_dishpropertygroup" name="x_dishpropertygroup" id="x_dishpropertygroup" size="30" maxlength="255" placeholder="<%= MenuDishpropertiesGroups.dishpropertygroup.PlaceHolder %>" value="<%= MenuDishpropertiesGroups.dishpropertygroup.EditValue %>"<%= MenuDishpropertiesGroups.dishpropertygroup.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If MenuDishpropertiesGroups.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
	<div id="r_IdBusinessDetail" class="form-group">
		<label for="x_IdBusinessDetail" class="<%= MenuDishpropertiesGroups_search.SearchLabelClass %>"><span id="elh_MenuDishpropertiesGroups_IdBusinessDetail"><%= MenuDishpropertiesGroups.IdBusinessDetail.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_IdBusinessDetail" id="z_IdBusinessDetail" value="="></p>
		</label>
		<div class="<%= MenuDishpropertiesGroups_search.SearchRightColumnClass %>"><div<%= MenuDishpropertiesGroups.IdBusinessDetail.CellAttributes %>>
			<span id="el_MenuDishpropertiesGroups_IdBusinessDetail">
<input type="text" data-field="x_IdBusinessDetail" name="x_IdBusinessDetail" id="x_IdBusinessDetail" size="30" placeholder="<%= MenuDishpropertiesGroups.IdBusinessDetail.PlaceHolder %>" value="<%= MenuDishpropertiesGroups.IdBusinessDetail.EditValue %>"<%= MenuDishpropertiesGroups.IdBusinessDetail.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If MenuDishpropertiesGroups.dishpropertypricetype.Visible Then ' dishpropertypricetype %>
	<div id="r_dishpropertypricetype" class="form-group">
		<label for="x_dishpropertypricetype" class="<%= MenuDishpropertiesGroups_search.SearchLabelClass %>"><span id="elh_MenuDishpropertiesGroups_dishpropertypricetype"><%= MenuDishpropertiesGroups.dishpropertypricetype.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_dishpropertypricetype" id="z_dishpropertypricetype" value="LIKE"></p>
		</label>
		<div class="<%= MenuDishpropertiesGroups_search.SearchRightColumnClass %>"><div<%= MenuDishpropertiesGroups.dishpropertypricetype.CellAttributes %>>
			<span id="el_MenuDishpropertiesGroups_dishpropertypricetype">
<input type="text" data-field="x_dishpropertypricetype" name="x_dishpropertypricetype" id="x_dishpropertypricetype" size="30" maxlength="255" placeholder="<%= MenuDishpropertiesGroups.dishpropertypricetype.PlaceHolder %>" value="<%= MenuDishpropertiesGroups.dishpropertypricetype.EditValue %>"<%= MenuDishpropertiesGroups.dishpropertypricetype.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If MenuDishpropertiesGroups.dishpropertyrequired.Visible Then ' dishpropertyrequired %>
	<div id="r_dishpropertyrequired" class="form-group">
		<label for="x_dishpropertyrequired" class="<%= MenuDishpropertiesGroups_search.SearchLabelClass %>"><span id="elh_MenuDishpropertiesGroups_dishpropertyrequired"><%= MenuDishpropertiesGroups.dishpropertyrequired.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_dishpropertyrequired" id="z_dishpropertyrequired" value="="></p>
		</label>
		<div class="<%= MenuDishpropertiesGroups_search.SearchRightColumnClass %>"><div<%= MenuDishpropertiesGroups.dishpropertyrequired.CellAttributes %>>
			<span id="el_MenuDishpropertiesGroups_dishpropertyrequired">
<input type="text" data-field="x_dishpropertyrequired" name="x_dishpropertyrequired" id="x_dishpropertyrequired" size="30" placeholder="<%= MenuDishpropertiesGroups.dishpropertyrequired.PlaceHolder %>" value="<%= MenuDishpropertiesGroups.dishpropertyrequired.EditValue %>"<%= MenuDishpropertiesGroups.dishpropertyrequired.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If MenuDishpropertiesGroups.printingname.Visible Then ' printingname %>
	<div id="r_printingname" class="form-group">
		<label for="x_printingname" class="<%= MenuDishpropertiesGroups_search.SearchLabelClass %>"><span id="elh_MenuDishpropertiesGroups_printingname"><%= MenuDishpropertiesGroups.printingname.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_printingname" id="z_printingname" value="LIKE"></p>
		</label>
		<div class="<%= MenuDishpropertiesGroups_search.SearchRightColumnClass %>"><div<%= MenuDishpropertiesGroups.printingname.CellAttributes %>>
			<span id="el_MenuDishpropertiesGroups_printingname">
<input type="text" data-field="x_printingname" name="x_printingname" id="x_printingname" size="30" maxlength="255" placeholder="<%= MenuDishpropertiesGroups.printingname.PlaceHolder %>" value="<%= MenuDishpropertiesGroups.printingname.EditValue %>"<%= MenuDishpropertiesGroups.printingname.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If MenuDishpropertiesGroups.i_displaySort.Visible Then ' i_displaySort %>
	<div id="r_i_displaySort" class="form-group">
		<label for="x_i_displaySort" class="<%= MenuDishpropertiesGroups_search.SearchLabelClass %>"><span id="elh_MenuDishpropertiesGroups_i_displaySort"><%= MenuDishpropertiesGroups.i_displaySort.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_i_displaySort" id="z_i_displaySort" value="="></p>
		</label>
		<div class="<%= MenuDishpropertiesGroups_search.SearchRightColumnClass %>"><div<%= MenuDishpropertiesGroups.i_displaySort.CellAttributes %>>
			<span id="el_MenuDishpropertiesGroups_i_displaySort">
<input type="text" data-field="x_i_displaySort" name="x_i_displaySort" id="x_i_displaySort" size="30" placeholder="<%= MenuDishpropertiesGroups.i_displaySort.PlaceHolder %>" value="<%= MenuDishpropertiesGroups.i_displaySort.EditValue %>"<%= MenuDishpropertiesGroups.i_displaySort.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
</div>
<% If Not MenuDishpropertiesGroups_search.IsModal Then %>
<div class="form-group">
	<div class="col-sm-offset-3 col-sm-9">
<button class="btn btn-primary ewButton" name="btnAction" id="btnAction" type="submit"><%= Language.Phrase("Search") %></button>
<button class="btn btn-default ewButton" name="btnReset" id="btnReset" type="button" onclick="ew_ClearForm(this.form);"><%= Language.Phrase("Reset") %></button>
	</div>
</div>
<% End If %>
</form>
<script type="text/javascript">
fMenuDishpropertiesGroupssearch.Init();
</script>
<%
MenuDishpropertiesGroups_search.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set MenuDishpropertiesGroups_search = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cMenuDishpropertiesGroups_search

	' Page ID
	Public Property Get PageID()
		PageID = "search"
	End Property

	' Project ID
	Public Property Get ProjectID()
		ProjectID = "{E9837C6B-C139-4DEF-A37B-491BE9913D3B}"
	End Property

	' Table Name
	Public Property Get TableName()
		TableName = "MenuDishpropertiesGroups"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "MenuDishpropertiesGroups_search"
	End Property

	' Page Name
	Public Property Get PageName()
		PageName = ew_CurrentPage()
	End Property

	' Page Url
	Public Property Get PageUrl()
		PageUrl = ew_CurrentPage() & "?"
		If MenuDishpropertiesGroups.UseTokenInUrl Then PageUrl = PageUrl & "t=" & MenuDishpropertiesGroups.TableVar & "&" ' add page token
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
		If MenuDishpropertiesGroups.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (MenuDishpropertiesGroups.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (MenuDishpropertiesGroups.TableVar = Request.QueryString("t"))
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
		If IsEmpty(MenuDishpropertiesGroups) Then Set MenuDishpropertiesGroups = New cMenuDishpropertiesGroups
		Set Table = MenuDishpropertiesGroups

		' Initialize urls
		' Initialize form object

		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "search"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "MenuDishpropertiesGroups"

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

		' Create form object
		'If ew_IsHttpPost() Then

			Set ObjForm = New cFormObj

		'Else
		'	Set ObjForm = ew_GetUploadObj()
		'End If

		MenuDishpropertiesGroups.CurrentAction = ew_IIf(Request.QueryString("a").Count > 0, Request.QueryString("a") & "", ObjForm.GetValue("a_list") & "") ' Set up current action
		MenuDishpropertiesGroups.ID.Visible = Not MenuDishpropertiesGroups.IsAdd() And Not MenuDishpropertiesGroups.IsCopy() And Not MenuDishpropertiesGroups.IsGridAdd()

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
			results = MenuDishpropertiesGroups.GetAutoFill(Request.Form("name"), Request.Form("q"))
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
		If Not MenuDishpropertiesGroups Is Nothing Then
			If MenuDishpropertiesGroups.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = MenuDishpropertiesGroups.TableVar
				If MenuDishpropertiesGroups.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf MenuDishpropertiesGroups.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf MenuDishpropertiesGroups.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf MenuDishpropertiesGroups.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set MenuDishpropertiesGroups = Nothing
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

	Dim IsModal
	Dim SearchLabelClass
	Dim SearchRightColumnClass

	' -----------------------------------------------------------------
	' Page main processing
	'
	Sub Page_Main()

		' Set up Breadcrumb
		SetupBreadcrumb()
		SearchLabelClass = "col-sm-3 control-label ewLabel"
		SearchRightColumnClass = "col-sm-9"

		' Check modal
		IsModal = (Request.QueryString("modal")&"" = "1" Or Request.Form("modal")&"" = "1")
		If IsModal Then
			gbSkipHeaderFooter = True
		End If
		If IsPageRequest Then ' Validate request

			' Get action
			MenuDishpropertiesGroups.CurrentAction = ObjForm.GetValue("a_search")
			Select Case MenuDishpropertiesGroups.CurrentAction
				Case "S" ' Get Search Criteria

					' Build search string for advanced search, remove blank field
					Dim sSrchStr
					Call LoadSearchValues() ' Get search values
					If ValidateSearch() Then
						sSrchStr = BuildAdvancedSearch()
					Else
						sSrchStr = ""
						FailureMessage = gsSearchError
					End If
					If sSrchStr <> "" Then
						sSrchStr = MenuDishpropertiesGroups.UrlParm(sSrchStr)
						sSrchStr = "MenuDishpropertiesGroupslist.asp" & "?" & sSrchStr
						If IsModal Then
							Dim row
							ReDim row(0,0)
							row(0,0) = Array("url", sSrchStr)
							Response.Write ew_ArrayToJson(row, 0)
							Call Page_Terminate("")
							Response.End
						Else
							Call Page_Terminate(sSrchStr) ' Go to list page
						End If
					End If
			End Select
		End If

		' Restore search settings from Session
		If gsSearchError = "" Then
			Call LoadAdvancedSearch()
		End If

		' Render row for search
		MenuDishpropertiesGroups.RowType = EW_ROWTYPE_SEARCH
		Call RenderRow()
	End Sub

	' -----------------------------------------------------------------
	' Build advanced search
	'
	Function BuildAdvancedSearch()
		Dim sSrchUrl
		sSrchUrl = ""
		Call BuildSearchUrl(sSrchUrl, MenuDishpropertiesGroups.ID, False) ' ID
		Call BuildSearchUrl(sSrchUrl, MenuDishpropertiesGroups.dishpropertygroup, False) ' dishpropertygroup
		Call BuildSearchUrl(sSrchUrl, MenuDishpropertiesGroups.IdBusinessDetail, False) ' IdBusinessDetail
		Call BuildSearchUrl(sSrchUrl, MenuDishpropertiesGroups.dishpropertypricetype, False) ' dishpropertypricetype
		Call BuildSearchUrl(sSrchUrl, MenuDishpropertiesGroups.dishpropertyrequired, False) ' dishpropertyrequired
		Call BuildSearchUrl(sSrchUrl, MenuDishpropertiesGroups.printingname, False) ' printingname
		Call BuildSearchUrl(sSrchUrl, MenuDishpropertiesGroups.i_displaySort, False) ' i_displaySort
		If sSrchUrl <> "" Then sSrchUrl = sSrchUrl & "&"
		sSrchUrl = sSrchUrl & "cmd=search"
		BuildAdvancedSearch = sSrchUrl
	End Function

	' -----------------------------------------------------------------
	' Function to build search URL
	'
	Sub BuildSearchUrl(Url, Fld, OprOnly)
		Dim FldVal, FldOpr, FldCond, FldVal2, FldOpr2
		Dim FldParm
		Dim IsValidValue, sWrk
		sWrk = ""
		FldParm = Mid(Fld.FldVar, 3)
		FldVal = ObjForm.GetValue("x_" & FldParm)
		FldOpr = ObjForm.GetValue("z_" & FldParm)
		FldCond = ObjForm.GetValue("v_" & FldParm)
		FldVal2 = ObjForm.GetValue("y_" & FldParm)
		FldOpr2 = ObjForm.GetValue("w_" & FldParm)
		FldOpr = UCase(Trim(FldOpr))
		Dim lFldDataType
		If Fld.FldIsVirtual Then
			lFldDataType = EW_DATATYPE_STRING
		Else
			lFldDataType = Fld.FldDataType
		End If
		If FldOpr = "BETWEEN" Then
			IsValidValue = (lFldDataType <> EW_DATATYPE_NUMBER) Or _
				(lFldDataType = EW_DATATYPE_NUMBER And SearchValueIsNumeric(Fld, FldVal) And SearchValueIsNumeric(Fld, FldVal2))
			If FldVal <> "" And FldVal2 <> "" And IsValidValue Then
				sWrk = "x_" & FldParm & "=" & ew_Encode(FldVal) & _
					"&y_" & FldParm & "=" & ew_Encode(FldVal2) & _
					"&z_" & FldParm & "=" & ew_Encode(FldOpr)
			End If
		Else
			IsValidValue = (lFldDataType <> EW_DATATYPE_NUMBER) Or _
				(lFldDataType = EW_DATATYPE_NUMBER And SearchValueIsNumeric(Fld, FldVal))
			If FldVal <> "" And IsValidValue And ew_IsValidOpr(FldOpr, lFldDataType) Then
				sWrk = "x_" & FldParm & "=" & ew_Encode(FldVal) & _
					"&z_" & FldParm & "=" & ew_Encode(FldOpr)
			ElseIf FldOpr = "IS NULL" Or FldOpr = "IS NOT NULL" Or (FldOpr <> "" And OprOnly And ew_IsValidOpr(FldOpr, lFldDataType)) Then
				sWrk = "z_" & FldParm & "=" & ew_Encode(FldOpr)
			End If
			IsValidValue = (lFldDataType <> EW_DATATYPE_NUMBER) Or _
				(lFldDataType = EW_DATATYPE_NUMBER And SearchValueIsNumeric(Fld, FldVal2))
			If FldVal2 <> "" And IsValidValue And ew_IsValidOpr(FldOpr2, lFldDataType) Then
				If sWrk <> "" Then sWrk = sWrk & "&v_" & FldParm & "=" & FldCond & "&"
				sWrk = sWrk & "y_" & FldParm & "=" & ew_Encode(FldVal2) & _
					"&w_" & FldParm & "=" & ew_Encode(FldOpr2)
			ElseIf FldOpr2 = "IS NULL" Or FldOpr2 = "IS NOT NULL" Or (FldOpr2 <> "" And OprOnly And ew_IsValidOpr(FldOpr2, lFldDataType)) Then
				If sWrk <> "" Then sWrk = sWrk & "&v_" & FldParm & "=" & FldCond & "&"
				sWrk = sWrk & "w_" & FldParm & "=" & ew_Encode(FldOpr2)
			End If
		End If
		If sWrk <> "" Then
			If Url <> "" Then Url = Url & "&"
			Url = Url & sWrk
		End If
	End Sub

	Function SearchValueIsNumeric(Fld, Value)
		Dim wrkValue
		wrkValue = Value
		If ew_IsFloatFormat(Fld.FldType) Then wrkValue = ew_StrToFloat(wrkValue)
		SearchValueIsNumeric = IsNumeric(Value)
	End Function

	' -----------------------------------------------------------------
	'  Load search values for validation
	'
	Function LoadSearchValues()

		' Load search values
		MenuDishpropertiesGroups.ID.AdvancedSearch.SearchValue = ObjForm.GetValue("x_ID")
		MenuDishpropertiesGroups.ID.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_ID")
		MenuDishpropertiesGroups.dishpropertygroup.AdvancedSearch.SearchValue = ObjForm.GetValue("x_dishpropertygroup")
		MenuDishpropertiesGroups.dishpropertygroup.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_dishpropertygroup")
		MenuDishpropertiesGroups.IdBusinessDetail.AdvancedSearch.SearchValue = ObjForm.GetValue("x_IdBusinessDetail")
		MenuDishpropertiesGroups.IdBusinessDetail.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_IdBusinessDetail")
		MenuDishpropertiesGroups.dishpropertypricetype.AdvancedSearch.SearchValue = ObjForm.GetValue("x_dishpropertypricetype")
		MenuDishpropertiesGroups.dishpropertypricetype.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_dishpropertypricetype")
		MenuDishpropertiesGroups.dishpropertyrequired.AdvancedSearch.SearchValue = ObjForm.GetValue("x_dishpropertyrequired")
		MenuDishpropertiesGroups.dishpropertyrequired.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_dishpropertyrequired")
		MenuDishpropertiesGroups.printingname.AdvancedSearch.SearchValue = ObjForm.GetValue("x_printingname")
		MenuDishpropertiesGroups.printingname.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_printingname")
		MenuDishpropertiesGroups.i_displaySort.AdvancedSearch.SearchValue = ObjForm.GetValue("x_i_displaySort")
		MenuDishpropertiesGroups.i_displaySort.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_i_displaySort")
	End Function

	' -----------------------------------------------------------------
	' Render row values based on field settings
	'
	Sub RenderRow()

		' Initialize urls
		' Call Row Rendering event

		Call MenuDishpropertiesGroups.Row_Rendering()

		' ---------------------------------------
		'  Common render codes for all row types
		' ---------------------------------------
		' ID
		' dishpropertygroup
		' IdBusinessDetail
		' dishpropertypricetype
		' dishpropertyrequired
		' printingname
		' i_displaySort
		' -----------
		'  View  Row
		' -----------

		If MenuDishpropertiesGroups.RowType = EW_ROWTYPE_VIEW Then ' View row

			' ID
			MenuDishpropertiesGroups.ID.ViewValue = MenuDishpropertiesGroups.ID.CurrentValue
			MenuDishpropertiesGroups.ID.ViewCustomAttributes = ""

			' dishpropertygroup
			MenuDishpropertiesGroups.dishpropertygroup.ViewValue = MenuDishpropertiesGroups.dishpropertygroup.CurrentValue
			MenuDishpropertiesGroups.dishpropertygroup.ViewCustomAttributes = ""

			' IdBusinessDetail
			MenuDishpropertiesGroups.IdBusinessDetail.ViewValue = MenuDishpropertiesGroups.IdBusinessDetail.CurrentValue
			MenuDishpropertiesGroups.IdBusinessDetail.ViewCustomAttributes = ""

			' dishpropertypricetype
			MenuDishpropertiesGroups.dishpropertypricetype.ViewValue = MenuDishpropertiesGroups.dishpropertypricetype.CurrentValue
			MenuDishpropertiesGroups.dishpropertypricetype.ViewCustomAttributes = ""

			' dishpropertyrequired
			MenuDishpropertiesGroups.dishpropertyrequired.ViewValue = MenuDishpropertiesGroups.dishpropertyrequired.CurrentValue
			MenuDishpropertiesGroups.dishpropertyrequired.ViewCustomAttributes = ""

			' printingname
			MenuDishpropertiesGroups.printingname.ViewValue = MenuDishpropertiesGroups.printingname.CurrentValue
			MenuDishpropertiesGroups.printingname.ViewCustomAttributes = ""

			' i_displaySort
			MenuDishpropertiesGroups.i_displaySort.ViewValue = MenuDishpropertiesGroups.i_displaySort.CurrentValue
			MenuDishpropertiesGroups.i_displaySort.ViewCustomAttributes = ""

			' View refer script
			' ID

			MenuDishpropertiesGroups.ID.LinkCustomAttributes = ""
			MenuDishpropertiesGroups.ID.HrefValue = ""
			MenuDishpropertiesGroups.ID.TooltipValue = ""

			' dishpropertygroup
			MenuDishpropertiesGroups.dishpropertygroup.LinkCustomAttributes = ""
			MenuDishpropertiesGroups.dishpropertygroup.HrefValue = ""
			MenuDishpropertiesGroups.dishpropertygroup.TooltipValue = ""

			' IdBusinessDetail
			MenuDishpropertiesGroups.IdBusinessDetail.LinkCustomAttributes = ""
			MenuDishpropertiesGroups.IdBusinessDetail.HrefValue = ""
			MenuDishpropertiesGroups.IdBusinessDetail.TooltipValue = ""

			' dishpropertypricetype
			MenuDishpropertiesGroups.dishpropertypricetype.LinkCustomAttributes = ""
			MenuDishpropertiesGroups.dishpropertypricetype.HrefValue = ""
			MenuDishpropertiesGroups.dishpropertypricetype.TooltipValue = ""

			' dishpropertyrequired
			MenuDishpropertiesGroups.dishpropertyrequired.LinkCustomAttributes = ""
			MenuDishpropertiesGroups.dishpropertyrequired.HrefValue = ""
			MenuDishpropertiesGroups.dishpropertyrequired.TooltipValue = ""

			' printingname
			MenuDishpropertiesGroups.printingname.LinkCustomAttributes = ""
			MenuDishpropertiesGroups.printingname.HrefValue = ""
			MenuDishpropertiesGroups.printingname.TooltipValue = ""

			' i_displaySort
			MenuDishpropertiesGroups.i_displaySort.LinkCustomAttributes = ""
			MenuDishpropertiesGroups.i_displaySort.HrefValue = ""
			MenuDishpropertiesGroups.i_displaySort.TooltipValue = ""

		' ------------
		'  Search Row
		' ------------

		ElseIf MenuDishpropertiesGroups.RowType = EW_ROWTYPE_SEARCH Then ' Search row

			' ID
			MenuDishpropertiesGroups.ID.EditAttrs.UpdateAttribute "class", "form-control"
			MenuDishpropertiesGroups.ID.EditCustomAttributes = ""
			MenuDishpropertiesGroups.ID.EditValue = ew_HtmlEncode(MenuDishpropertiesGroups.ID.AdvancedSearch.SearchValue)
			MenuDishpropertiesGroups.ID.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuDishpropertiesGroups.ID.FldCaption))

			' dishpropertygroup
			MenuDishpropertiesGroups.dishpropertygroup.EditAttrs.UpdateAttribute "class", "form-control"
			MenuDishpropertiesGroups.dishpropertygroup.EditCustomAttributes = ""
			MenuDishpropertiesGroups.dishpropertygroup.EditValue = ew_HtmlEncode(MenuDishpropertiesGroups.dishpropertygroup.AdvancedSearch.SearchValue)
			MenuDishpropertiesGroups.dishpropertygroup.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuDishpropertiesGroups.dishpropertygroup.FldCaption))

			' IdBusinessDetail
			MenuDishpropertiesGroups.IdBusinessDetail.EditAttrs.UpdateAttribute "class", "form-control"
			MenuDishpropertiesGroups.IdBusinessDetail.EditCustomAttributes = ""
			MenuDishpropertiesGroups.IdBusinessDetail.EditValue = ew_HtmlEncode(MenuDishpropertiesGroups.IdBusinessDetail.AdvancedSearch.SearchValue)
			MenuDishpropertiesGroups.IdBusinessDetail.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuDishpropertiesGroups.IdBusinessDetail.FldCaption))

			' dishpropertypricetype
			MenuDishpropertiesGroups.dishpropertypricetype.EditAttrs.UpdateAttribute "class", "form-control"
			MenuDishpropertiesGroups.dishpropertypricetype.EditCustomAttributes = ""
			MenuDishpropertiesGroups.dishpropertypricetype.EditValue = ew_HtmlEncode(MenuDishpropertiesGroups.dishpropertypricetype.AdvancedSearch.SearchValue)
			MenuDishpropertiesGroups.dishpropertypricetype.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuDishpropertiesGroups.dishpropertypricetype.FldCaption))

			' dishpropertyrequired
			MenuDishpropertiesGroups.dishpropertyrequired.EditAttrs.UpdateAttribute "class", "form-control"
			MenuDishpropertiesGroups.dishpropertyrequired.EditCustomAttributes = ""
			MenuDishpropertiesGroups.dishpropertyrequired.EditValue = ew_HtmlEncode(MenuDishpropertiesGroups.dishpropertyrequired.AdvancedSearch.SearchValue)
			MenuDishpropertiesGroups.dishpropertyrequired.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuDishpropertiesGroups.dishpropertyrequired.FldCaption))

			' printingname
			MenuDishpropertiesGroups.printingname.EditAttrs.UpdateAttribute "class", "form-control"
			MenuDishpropertiesGroups.printingname.EditCustomAttributes = ""
			MenuDishpropertiesGroups.printingname.EditValue = ew_HtmlEncode(MenuDishpropertiesGroups.printingname.AdvancedSearch.SearchValue)
			MenuDishpropertiesGroups.printingname.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuDishpropertiesGroups.printingname.FldCaption))

			' i_displaySort
			MenuDishpropertiesGroups.i_displaySort.EditAttrs.UpdateAttribute "class", "form-control"
			MenuDishpropertiesGroups.i_displaySort.EditCustomAttributes = ""
			MenuDishpropertiesGroups.i_displaySort.EditValue = ew_HtmlEncode(MenuDishpropertiesGroups.i_displaySort.AdvancedSearch.SearchValue)
			MenuDishpropertiesGroups.i_displaySort.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuDishpropertiesGroups.i_displaySort.FldCaption))
		End If
		If MenuDishpropertiesGroups.RowType = EW_ROWTYPE_ADD Or MenuDishpropertiesGroups.RowType = EW_ROWTYPE_EDIT Or MenuDishpropertiesGroups.RowType = EW_ROWTYPE_SEARCH Then ' Add / Edit / Search row
			Call MenuDishpropertiesGroups.SetupFieldTitles()
		End If

		' Call Row Rendered event
		If MenuDishpropertiesGroups.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call MenuDishpropertiesGroups.Row_Rendered()
		End If
	End Sub

	' -----------------------------------------------------------------
	' Validate search
	'
	Function ValidateSearch()

		' Initialize
		gsSearchError = ""

		' Check if validation required
		If Not EW_SERVER_VALIDATE Then
			ValidateSearch = True
			Exit Function
		End If
		If Not ew_CheckInteger(MenuDishpropertiesGroups.ID.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, MenuDishpropertiesGroups.ID.FldErrMsg)
		End If
		If Not ew_CheckInteger(MenuDishpropertiesGroups.IdBusinessDetail.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, MenuDishpropertiesGroups.IdBusinessDetail.FldErrMsg)
		End If
		If Not ew_CheckInteger(MenuDishpropertiesGroups.dishpropertyrequired.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, MenuDishpropertiesGroups.dishpropertyrequired.FldErrMsg)
		End If
		If Not ew_CheckInteger(MenuDishpropertiesGroups.i_displaySort.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, MenuDishpropertiesGroups.i_displaySort.FldErrMsg)
		End If

		' Return validate result
		ValidateSearch = (gsSearchError = "")

		' Call Form Custom Validate event
		Dim sFormCustomError
		sFormCustomError = ""
		ValidateSearch = ValidateSearch And Form_CustomValidate(sFormCustomError)
		If sFormCustomError <> "" Then
			Call ew_AddMessage(gsSearchError, sFormCustomError)
		End If
	End Function

	' -----------------------------------------------------------------
	' Load advanced search
	'
	Function LoadAdvancedSearch()
		Call MenuDishpropertiesGroups.ID.AdvancedSearch.Load()
		Call MenuDishpropertiesGroups.dishpropertygroup.AdvancedSearch.Load()
		Call MenuDishpropertiesGroups.IdBusinessDetail.AdvancedSearch.Load()
		Call MenuDishpropertiesGroups.dishpropertypricetype.AdvancedSearch.Load()
		Call MenuDishpropertiesGroups.dishpropertyrequired.AdvancedSearch.Load()
		Call MenuDishpropertiesGroups.printingname.AdvancedSearch.Load()
		Call MenuDishpropertiesGroups.i_displaySort.AdvancedSearch.Load()
End Function

	' Set up Breadcrumb
	Sub SetupBreadcrumb()
		Dim PageId, url
		Set Breadcrumb = New cBreadcrumb
		url = Mid(ew_CurrentUrl, InStrRev(ew_CurrentUrl, "/")+1)
		Call Breadcrumb.Add("list", MenuDishpropertiesGroups.TableVar, "MenuDishpropertiesGroupslist.asp", "", MenuDishpropertiesGroups.TableVar, True)
		PageId = "search"
		Call Breadcrumb.Add("search", PageId, url, "", "", False)
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

	' Form Custom Validate event
	Function Form_CustomValidate(CustomError)

		'Return error message in CustomError
		Form_CustomValidate = True
	End Function
End Class
%>
