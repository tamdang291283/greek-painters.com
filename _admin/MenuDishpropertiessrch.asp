<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="MenuDishpropertiesinfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim MenuDishproperties_search
Set MenuDishproperties_search = New cMenuDishproperties_search
Set Page = MenuDishproperties_search

' Page init processing
MenuDishproperties_search.Page_Init()

' Page main processing
MenuDishproperties_search.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
MenuDishproperties_search.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var MenuDishproperties_search = new ew_Page("MenuDishproperties_search");
MenuDishproperties_search.PageID = "search"; // Page ID
var EW_PAGE_ID = MenuDishproperties_search.PageID; // For backward compatibility
// Form object
var fMenuDishpropertiessearch = new ew_Form("fMenuDishpropertiessearch");
// Form_CustomValidate event
fMenuDishpropertiessearch.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fMenuDishpropertiessearch.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fMenuDishpropertiessearch.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
// Validate function for search
fMenuDishpropertiessearch.Validate = function(fobj) {
	if (!this.ValidateRequired)
		return true; // Ignore validation
	fobj = fobj || this.Form;
	this.PostAutoSuggest();
	var infix = "";
	elm = this.GetElements("x" + infix + "_ID");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(MenuDishproperties.ID.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_dishpropertyprice");
	if (elm && !ew_CheckNumber(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(MenuDishproperties.dishpropertyprice.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_IdBusinessDetail");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(MenuDishproperties.IdBusinessDetail.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_dishpropertygroupid");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(MenuDishproperties.dishpropertygroupid.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_i_displaySort");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(MenuDishproperties.i_displaySort.FldErrMsg) %>");
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
<% If Not MenuDishproperties_search.IsModal Then %>
<div class="ewToolbar">
<% If MenuDishproperties.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If MenuDishproperties.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% End If %>
<% MenuDishproperties_search.ShowPageHeader() %>
<% MenuDishproperties_search.ShowMessage %>
<form name="fMenuDishpropertiessearch" id="fMenuDishpropertiessearch" class="form-horizontal ewForm ewSearchForm" action="<%= ew_CurrentPage %>" method="post">
<% If MenuDishproperties_search.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= MenuDishproperties_search.Token %>">
<% End If %>
<input type="hidden" name="t" value="MenuDishproperties">
<input type="hidden" name="a_search" id="a_search" value="S">
<% If MenuDishproperties_search.IsModal Then %>
<input type="hidden" name="modal" value="1">
<% End If %>
<div>
<% If MenuDishproperties.ID.Visible Then ' ID %>
	<div id="r_ID" class="form-group">
		<label for="x_ID" class="<%= MenuDishproperties_search.SearchLabelClass %>"><span id="elh_MenuDishproperties_ID"><%= MenuDishproperties.ID.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_ID" id="z_ID" value="="></p>
		</label>
		<div class="<%= MenuDishproperties_search.SearchRightColumnClass %>"><div<%= MenuDishproperties.ID.CellAttributes %>>
			<span id="el_MenuDishproperties_ID">
<input type="text" data-field="x_ID" name="x_ID" id="x_ID" placeholder="<%= MenuDishproperties.ID.PlaceHolder %>" value="<%= MenuDishproperties.ID.EditValue %>"<%= MenuDishproperties.ID.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If MenuDishproperties.dishproperty.Visible Then ' dishproperty %>
	<div id="r_dishproperty" class="form-group">
		<label for="x_dishproperty" class="<%= MenuDishproperties_search.SearchLabelClass %>"><span id="elh_MenuDishproperties_dishproperty"><%= MenuDishproperties.dishproperty.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_dishproperty" id="z_dishproperty" value="LIKE"></p>
		</label>
		<div class="<%= MenuDishproperties_search.SearchRightColumnClass %>"><div<%= MenuDishproperties.dishproperty.CellAttributes %>>
			<span id="el_MenuDishproperties_dishproperty">
<input type="text" data-field="x_dishproperty" name="x_dishproperty" id="x_dishproperty" size="30" maxlength="255" placeholder="<%= MenuDishproperties.dishproperty.PlaceHolder %>" value="<%= MenuDishproperties.dishproperty.EditValue %>"<%= MenuDishproperties.dishproperty.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If MenuDishproperties.dishpropertyprice.Visible Then ' dishpropertyprice %>
	<div id="r_dishpropertyprice" class="form-group">
		<label for="x_dishpropertyprice" class="<%= MenuDishproperties_search.SearchLabelClass %>"><span id="elh_MenuDishproperties_dishpropertyprice"><%= MenuDishproperties.dishpropertyprice.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_dishpropertyprice" id="z_dishpropertyprice" value="="></p>
		</label>
		<div class="<%= MenuDishproperties_search.SearchRightColumnClass %>"><div<%= MenuDishproperties.dishpropertyprice.CellAttributes %>>
			<span id="el_MenuDishproperties_dishpropertyprice">
<input type="text" data-field="x_dishpropertyprice" name="x_dishpropertyprice" id="x_dishpropertyprice" size="30" placeholder="<%= MenuDishproperties.dishpropertyprice.PlaceHolder %>" value="<%= MenuDishproperties.dishpropertyprice.EditValue %>"<%= MenuDishproperties.dishpropertyprice.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If MenuDishproperties.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
	<div id="r_IdBusinessDetail" class="form-group">
		<label for="x_IdBusinessDetail" class="<%= MenuDishproperties_search.SearchLabelClass %>"><span id="elh_MenuDishproperties_IdBusinessDetail"><%= MenuDishproperties.IdBusinessDetail.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_IdBusinessDetail" id="z_IdBusinessDetail" value="="></p>
		</label>
		<div class="<%= MenuDishproperties_search.SearchRightColumnClass %>"><div<%= MenuDishproperties.IdBusinessDetail.CellAttributes %>>
			<span id="el_MenuDishproperties_IdBusinessDetail">
<input type="text" data-field="x_IdBusinessDetail" name="x_IdBusinessDetail" id="x_IdBusinessDetail" size="30" placeholder="<%= MenuDishproperties.IdBusinessDetail.PlaceHolder %>" value="<%= MenuDishproperties.IdBusinessDetail.EditValue %>"<%= MenuDishproperties.IdBusinessDetail.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If MenuDishproperties.dishpropertygroupid.Visible Then ' dishpropertygroupid %>
	<div id="r_dishpropertygroupid" class="form-group">
		<label for="x_dishpropertygroupid" class="<%= MenuDishproperties_search.SearchLabelClass %>"><span id="elh_MenuDishproperties_dishpropertygroupid"><%= MenuDishproperties.dishpropertygroupid.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_dishpropertygroupid" id="z_dishpropertygroupid" value="="></p>
		</label>
		<div class="<%= MenuDishproperties_search.SearchRightColumnClass %>"><div<%= MenuDishproperties.dishpropertygroupid.CellAttributes %>>
			<span id="el_MenuDishproperties_dishpropertygroupid">
<input type="text" data-field="x_dishpropertygroupid" name="x_dishpropertygroupid" id="x_dishpropertygroupid" size="30" placeholder="<%= MenuDishproperties.dishpropertygroupid.PlaceHolder %>" value="<%= MenuDishproperties.dishpropertygroupid.EditValue %>"<%= MenuDishproperties.dishpropertygroupid.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If MenuDishproperties.printingname.Visible Then ' printingname %>
	<div id="r_printingname" class="form-group">
		<label for="x_printingname" class="<%= MenuDishproperties_search.SearchLabelClass %>"><span id="elh_MenuDishproperties_printingname"><%= MenuDishproperties.printingname.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_printingname" id="z_printingname" value="LIKE"></p>
		</label>
		<div class="<%= MenuDishproperties_search.SearchRightColumnClass %>"><div<%= MenuDishproperties.printingname.CellAttributes %>>
			<span id="el_MenuDishproperties_printingname">
<input type="text" data-field="x_printingname" name="x_printingname" id="x_printingname" size="30" maxlength="255" placeholder="<%= MenuDishproperties.printingname.PlaceHolder %>" value="<%= MenuDishproperties.printingname.EditValue %>"<%= MenuDishproperties.printingname.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If MenuDishproperties.i_displaySort.Visible Then ' i_displaySort %>
	<div id="r_i_displaySort" class="form-group">
		<label for="x_i_displaySort" class="<%= MenuDishproperties_search.SearchLabelClass %>"><span id="elh_MenuDishproperties_i_displaySort"><%= MenuDishproperties.i_displaySort.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_i_displaySort" id="z_i_displaySort" value="="></p>
		</label>
		<div class="<%= MenuDishproperties_search.SearchRightColumnClass %>"><div<%= MenuDishproperties.i_displaySort.CellAttributes %>>
			<span id="el_MenuDishproperties_i_displaySort">
<input type="text" data-field="x_i_displaySort" name="x_i_displaySort" id="x_i_displaySort" size="30" placeholder="<%= MenuDishproperties.i_displaySort.PlaceHolder %>" value="<%= MenuDishproperties.i_displaySort.EditValue %>"<%= MenuDishproperties.i_displaySort.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
</div>
<% If Not MenuDishproperties_search.IsModal Then %>
<div class="form-group">
	<div class="col-sm-offset-3 col-sm-9">
<button class="btn btn-primary ewButton" name="btnAction" id="btnAction" type="submit"><%= Language.Phrase("Search") %></button>
<button class="btn btn-default ewButton" name="btnReset" id="btnReset" type="button" onclick="ew_ClearForm(this.form);"><%= Language.Phrase("Reset") %></button>
	</div>
</div>
<% End If %>
</form>
<script type="text/javascript">
fMenuDishpropertiessearch.Init();
</script>
<%
MenuDishproperties_search.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set MenuDishproperties_search = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cMenuDishproperties_search

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
		TableName = "MenuDishproperties"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "MenuDishproperties_search"
	End Property

	' Page Name
	Public Property Get PageName()
		PageName = ew_CurrentPage()
	End Property

	' Page Url
	Public Property Get PageUrl()
		PageUrl = ew_CurrentPage() & "?"
		If MenuDishproperties.UseTokenInUrl Then PageUrl = PageUrl & "t=" & MenuDishproperties.TableVar & "&" ' add page token
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
		If MenuDishproperties.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (MenuDishproperties.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (MenuDishproperties.TableVar = Request.QueryString("t"))
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
		If IsEmpty(MenuDishproperties) Then Set MenuDishproperties = New cMenuDishproperties
		Set Table = MenuDishproperties

		' Initialize urls
		' Initialize form object

		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "search"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "MenuDishproperties"

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

		MenuDishproperties.CurrentAction = ew_IIf(Request.QueryString("a").Count > 0, Request.QueryString("a") & "", ObjForm.GetValue("a_list") & "") ' Set up current action
		MenuDishproperties.ID.Visible = Not MenuDishproperties.IsAdd() And Not MenuDishproperties.IsCopy() And Not MenuDishproperties.IsGridAdd()

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
			results = MenuDishproperties.GetAutoFill(Request.Form("name"), Request.Form("q"))
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
		If Not MenuDishproperties Is Nothing Then
			If MenuDishproperties.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = MenuDishproperties.TableVar
				If MenuDishproperties.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf MenuDishproperties.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf MenuDishproperties.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf MenuDishproperties.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set MenuDishproperties = Nothing
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
			MenuDishproperties.CurrentAction = ObjForm.GetValue("a_search")
			Select Case MenuDishproperties.CurrentAction
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
						sSrchStr = MenuDishproperties.UrlParm(sSrchStr)
						sSrchStr = "MenuDishpropertieslist.asp" & "?" & sSrchStr
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
		MenuDishproperties.RowType = EW_ROWTYPE_SEARCH
		Call RenderRow()
	End Sub

	' -----------------------------------------------------------------
	' Build advanced search
	'
	Function BuildAdvancedSearch()
		Dim sSrchUrl
		sSrchUrl = ""
		Call BuildSearchUrl(sSrchUrl, MenuDishproperties.ID, False) ' ID
		Call BuildSearchUrl(sSrchUrl, MenuDishproperties.dishproperty, False) ' dishproperty
		Call BuildSearchUrl(sSrchUrl, MenuDishproperties.dishpropertyprice, False) ' dishpropertyprice
		Call BuildSearchUrl(sSrchUrl, MenuDishproperties.IdBusinessDetail, False) ' IdBusinessDetail
		Call BuildSearchUrl(sSrchUrl, MenuDishproperties.dishpropertygroupid, False) ' dishpropertygroupid
		Call BuildSearchUrl(sSrchUrl, MenuDishproperties.printingname, False) ' printingname
		Call BuildSearchUrl(sSrchUrl, MenuDishproperties.i_displaySort, False) ' i_displaySort
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
		MenuDishproperties.ID.AdvancedSearch.SearchValue = ObjForm.GetValue("x_ID")
		MenuDishproperties.ID.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_ID")
		MenuDishproperties.dishproperty.AdvancedSearch.SearchValue = ObjForm.GetValue("x_dishproperty")
		MenuDishproperties.dishproperty.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_dishproperty")
		MenuDishproperties.dishpropertyprice.AdvancedSearch.SearchValue = ObjForm.GetValue("x_dishpropertyprice")
		MenuDishproperties.dishpropertyprice.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_dishpropertyprice")
		MenuDishproperties.IdBusinessDetail.AdvancedSearch.SearchValue = ObjForm.GetValue("x_IdBusinessDetail")
		MenuDishproperties.IdBusinessDetail.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_IdBusinessDetail")
		MenuDishproperties.dishpropertygroupid.AdvancedSearch.SearchValue = ObjForm.GetValue("x_dishpropertygroupid")
		MenuDishproperties.dishpropertygroupid.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_dishpropertygroupid")
		MenuDishproperties.printingname.AdvancedSearch.SearchValue = ObjForm.GetValue("x_printingname")
		MenuDishproperties.printingname.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_printingname")
		MenuDishproperties.i_displaySort.AdvancedSearch.SearchValue = ObjForm.GetValue("x_i_displaySort")
		MenuDishproperties.i_displaySort.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_i_displaySort")
	End Function

	' -----------------------------------------------------------------
	' Render row values based on field settings
	'
	Sub RenderRow()

		' Initialize urls
		' Convert decimal values if posted back

		If MenuDishproperties.dishpropertyprice.FormValue = MenuDishproperties.dishpropertyprice.CurrentValue And IsNumeric(MenuDishproperties.dishpropertyprice.CurrentValue) Then
			MenuDishproperties.dishpropertyprice.CurrentValue = ew_StrToFloat(MenuDishproperties.dishpropertyprice.CurrentValue)
		End If

		' Call Row Rendering event
		Call MenuDishproperties.Row_Rendering()

		' ---------------------------------------
		'  Common render codes for all row types
		' ---------------------------------------
		' ID
		' dishproperty
		' dishpropertyprice
		' IdBusinessDetail
		' dishpropertygroupid
		' printingname
		' i_displaySort
		' -----------
		'  View  Row
		' -----------

		If MenuDishproperties.RowType = EW_ROWTYPE_VIEW Then ' View row

			' ID
			MenuDishproperties.ID.ViewValue = MenuDishproperties.ID.CurrentValue
			MenuDishproperties.ID.ViewCustomAttributes = ""

			' dishproperty
			MenuDishproperties.dishproperty.ViewValue = MenuDishproperties.dishproperty.CurrentValue
			MenuDishproperties.dishproperty.ViewCustomAttributes = ""

			' dishpropertyprice
			MenuDishproperties.dishpropertyprice.ViewValue = MenuDishproperties.dishpropertyprice.CurrentValue
			MenuDishproperties.dishpropertyprice.ViewCustomAttributes = ""

			' IdBusinessDetail
			MenuDishproperties.IdBusinessDetail.ViewValue = MenuDishproperties.IdBusinessDetail.CurrentValue
			MenuDishproperties.IdBusinessDetail.ViewCustomAttributes = ""

			' dishpropertygroupid
			MenuDishproperties.dishpropertygroupid.ViewValue = MenuDishproperties.dishpropertygroupid.CurrentValue
			MenuDishproperties.dishpropertygroupid.ViewCustomAttributes = ""

			' printingname
			MenuDishproperties.printingname.ViewValue = MenuDishproperties.printingname.CurrentValue
			MenuDishproperties.printingname.ViewCustomAttributes = ""

			' i_displaySort
			MenuDishproperties.i_displaySort.ViewValue = MenuDishproperties.i_displaySort.CurrentValue
			MenuDishproperties.i_displaySort.ViewCustomAttributes = ""

			' View refer script
			' ID

			MenuDishproperties.ID.LinkCustomAttributes = ""
			MenuDishproperties.ID.HrefValue = ""
			MenuDishproperties.ID.TooltipValue = ""

			' dishproperty
			MenuDishproperties.dishproperty.LinkCustomAttributes = ""
			MenuDishproperties.dishproperty.HrefValue = ""
			MenuDishproperties.dishproperty.TooltipValue = ""

			' dishpropertyprice
			MenuDishproperties.dishpropertyprice.LinkCustomAttributes = ""
			MenuDishproperties.dishpropertyprice.HrefValue = ""
			MenuDishproperties.dishpropertyprice.TooltipValue = ""

			' IdBusinessDetail
			MenuDishproperties.IdBusinessDetail.LinkCustomAttributes = ""
			MenuDishproperties.IdBusinessDetail.HrefValue = ""
			MenuDishproperties.IdBusinessDetail.TooltipValue = ""

			' dishpropertygroupid
			MenuDishproperties.dishpropertygroupid.LinkCustomAttributes = ""
			MenuDishproperties.dishpropertygroupid.HrefValue = ""
			MenuDishproperties.dishpropertygroupid.TooltipValue = ""

			' printingname
			MenuDishproperties.printingname.LinkCustomAttributes = ""
			MenuDishproperties.printingname.HrefValue = ""
			MenuDishproperties.printingname.TooltipValue = ""

			' i_displaySort
			MenuDishproperties.i_displaySort.LinkCustomAttributes = ""
			MenuDishproperties.i_displaySort.HrefValue = ""
			MenuDishproperties.i_displaySort.TooltipValue = ""

		' ------------
		'  Search Row
		' ------------

		ElseIf MenuDishproperties.RowType = EW_ROWTYPE_SEARCH Then ' Search row

			' ID
			MenuDishproperties.ID.EditAttrs.UpdateAttribute "class", "form-control"
			MenuDishproperties.ID.EditCustomAttributes = ""
			MenuDishproperties.ID.EditValue = ew_HtmlEncode(MenuDishproperties.ID.AdvancedSearch.SearchValue)
			MenuDishproperties.ID.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuDishproperties.ID.FldCaption))

			' dishproperty
			MenuDishproperties.dishproperty.EditAttrs.UpdateAttribute "class", "form-control"
			MenuDishproperties.dishproperty.EditCustomAttributes = ""
			MenuDishproperties.dishproperty.EditValue = ew_HtmlEncode(MenuDishproperties.dishproperty.AdvancedSearch.SearchValue)
			MenuDishproperties.dishproperty.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuDishproperties.dishproperty.FldCaption))

			' dishpropertyprice
			MenuDishproperties.dishpropertyprice.EditAttrs.UpdateAttribute "class", "form-control"
			MenuDishproperties.dishpropertyprice.EditCustomAttributes = ""
			MenuDishproperties.dishpropertyprice.EditValue = ew_HtmlEncode(MenuDishproperties.dishpropertyprice.AdvancedSearch.SearchValue)
			MenuDishproperties.dishpropertyprice.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuDishproperties.dishpropertyprice.FldCaption))

			' IdBusinessDetail
			MenuDishproperties.IdBusinessDetail.EditAttrs.UpdateAttribute "class", "form-control"
			MenuDishproperties.IdBusinessDetail.EditCustomAttributes = ""
			MenuDishproperties.IdBusinessDetail.EditValue = ew_HtmlEncode(MenuDishproperties.IdBusinessDetail.AdvancedSearch.SearchValue)
			MenuDishproperties.IdBusinessDetail.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuDishproperties.IdBusinessDetail.FldCaption))

			' dishpropertygroupid
			MenuDishproperties.dishpropertygroupid.EditAttrs.UpdateAttribute "class", "form-control"
			MenuDishproperties.dishpropertygroupid.EditCustomAttributes = ""
			MenuDishproperties.dishpropertygroupid.EditValue = ew_HtmlEncode(MenuDishproperties.dishpropertygroupid.AdvancedSearch.SearchValue)
			MenuDishproperties.dishpropertygroupid.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuDishproperties.dishpropertygroupid.FldCaption))

			' printingname
			MenuDishproperties.printingname.EditAttrs.UpdateAttribute "class", "form-control"
			MenuDishproperties.printingname.EditCustomAttributes = ""
			MenuDishproperties.printingname.EditValue = ew_HtmlEncode(MenuDishproperties.printingname.AdvancedSearch.SearchValue)
			MenuDishproperties.printingname.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuDishproperties.printingname.FldCaption))

			' i_displaySort
			MenuDishproperties.i_displaySort.EditAttrs.UpdateAttribute "class", "form-control"
			MenuDishproperties.i_displaySort.EditCustomAttributes = ""
			MenuDishproperties.i_displaySort.EditValue = ew_HtmlEncode(MenuDishproperties.i_displaySort.AdvancedSearch.SearchValue)
			MenuDishproperties.i_displaySort.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuDishproperties.i_displaySort.FldCaption))
		End If
		If MenuDishproperties.RowType = EW_ROWTYPE_ADD Or MenuDishproperties.RowType = EW_ROWTYPE_EDIT Or MenuDishproperties.RowType = EW_ROWTYPE_SEARCH Then ' Add / Edit / Search row
			Call MenuDishproperties.SetupFieldTitles()
		End If

		' Call Row Rendered event
		If MenuDishproperties.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call MenuDishproperties.Row_Rendered()
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
		If Not ew_CheckInteger(MenuDishproperties.ID.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, MenuDishproperties.ID.FldErrMsg)
		End If
		If Not ew_CheckNumber(MenuDishproperties.dishpropertyprice.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, MenuDishproperties.dishpropertyprice.FldErrMsg)
		End If
		If Not ew_CheckInteger(MenuDishproperties.IdBusinessDetail.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, MenuDishproperties.IdBusinessDetail.FldErrMsg)
		End If
		If Not ew_CheckInteger(MenuDishproperties.dishpropertygroupid.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, MenuDishproperties.dishpropertygroupid.FldErrMsg)
		End If
		If Not ew_CheckInteger(MenuDishproperties.i_displaySort.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, MenuDishproperties.i_displaySort.FldErrMsg)
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
		Call MenuDishproperties.ID.AdvancedSearch.Load()
		Call MenuDishproperties.dishproperty.AdvancedSearch.Load()
		Call MenuDishproperties.dishpropertyprice.AdvancedSearch.Load()
		Call MenuDishproperties.IdBusinessDetail.AdvancedSearch.Load()
		Call MenuDishproperties.dishpropertygroupid.AdvancedSearch.Load()
		Call MenuDishproperties.printingname.AdvancedSearch.Load()
		Call MenuDishproperties.i_displaySort.AdvancedSearch.Load()
End Function

	' Set up Breadcrumb
	Sub SetupBreadcrumb()
		Dim PageId, url
		Set Breadcrumb = New cBreadcrumb
		url = Mid(ew_CurrentUrl, InStrRev(ew_CurrentUrl, "/")+1)
		Call Breadcrumb.Add("list", MenuDishproperties.TableVar, "MenuDishpropertieslist.asp", "", MenuDishproperties.TableVar, True)
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
