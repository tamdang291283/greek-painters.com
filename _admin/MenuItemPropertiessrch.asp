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
Dim MenuItemProperties_search
Set MenuItemProperties_search = New cMenuItemProperties_search
Set Page = MenuItemProperties_search

' Page init processing
MenuItemProperties_search.Page_Init()

' Page main processing
MenuItemProperties_search.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
MenuItemProperties_search.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var MenuItemProperties_search = new ew_Page("MenuItemProperties_search");
MenuItemProperties_search.PageID = "search"; // Page ID
var EW_PAGE_ID = MenuItemProperties_search.PageID; // For backward compatibility
// Form object
var fMenuItemPropertiessearch = new ew_Form("fMenuItemPropertiessearch");
// Form_CustomValidate event
fMenuItemPropertiessearch.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fMenuItemPropertiessearch.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fMenuItemPropertiessearch.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
// Validate function for search
fMenuItemPropertiessearch.Validate = function(fobj) {
	if (!this.ValidateRequired)
		return true; // Ignore validation
	fobj = fobj || this.Form;
	this.PostAutoSuggest();
	var infix = "";
	elm = this.GetElements("x" + infix + "_Id");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(MenuItemProperties.Id.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_Price");
	if (elm && !ew_CheckNumber(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(MenuItemProperties.Price.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_IdMenuItem");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(MenuItemProperties.IdMenuItem.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_allowtoppings");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(MenuItemProperties.allowtoppings.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_i_displaysort");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(MenuItemProperties.i_displaysort.FldErrMsg) %>");
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
<% If Not MenuItemProperties_search.IsModal Then %>
<div class="ewToolbar">
<% If MenuItemProperties.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If MenuItemProperties.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% End If %>
<% MenuItemProperties_search.ShowPageHeader() %>
<% MenuItemProperties_search.ShowMessage %>
<form name="fMenuItemPropertiessearch" id="fMenuItemPropertiessearch" class="form-horizontal ewForm ewSearchForm" action="<%= ew_CurrentPage %>" method="post">
<% If MenuItemProperties_search.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= MenuItemProperties_search.Token %>">
<% End If %>
<input type="hidden" name="t" value="MenuItemProperties">
<input type="hidden" name="a_search" id="a_search" value="S">
<% If MenuItemProperties_search.IsModal Then %>
<input type="hidden" name="modal" value="1">
<% End If %>
<div>
<% If MenuItemProperties.Id.Visible Then ' Id %>
	<div id="r_Id" class="form-group">
		<label for="x_Id" class="<%= MenuItemProperties_search.SearchLabelClass %>"><span id="elh_MenuItemProperties_Id"><%= MenuItemProperties.Id.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_Id" id="z_Id" value="="></p>
		</label>
		<div class="<%= MenuItemProperties_search.SearchRightColumnClass %>"><div<%= MenuItemProperties.Id.CellAttributes %>>
			<span id="el_MenuItemProperties_Id">
<input type="text" data-field="x_Id" name="x_Id" id="x_Id" placeholder="<%= MenuItemProperties.Id.PlaceHolder %>" value="<%= MenuItemProperties.Id.EditValue %>"<%= MenuItemProperties.Id.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If MenuItemProperties.Name.Visible Then ' Name %>
	<div id="r_Name" class="form-group">
		<label for="x_Name" class="<%= MenuItemProperties_search.SearchLabelClass %>"><span id="elh_MenuItemProperties_Name"><%= MenuItemProperties.Name.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_Name" id="z_Name" value="LIKE"></p>
		</label>
		<div class="<%= MenuItemProperties_search.SearchRightColumnClass %>"><div<%= MenuItemProperties.Name.CellAttributes %>>
			<span id="el_MenuItemProperties_Name">
<input type="text" data-field="x_Name" name="x_Name" id="x_Name" size="30" maxlength="256" placeholder="<%= MenuItemProperties.Name.PlaceHolder %>" value="<%= MenuItemProperties.Name.EditValue %>"<%= MenuItemProperties.Name.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If MenuItemProperties.Price.Visible Then ' Price %>
	<div id="r_Price" class="form-group">
		<label for="x_Price" class="<%= MenuItemProperties_search.SearchLabelClass %>"><span id="elh_MenuItemProperties_Price"><%= MenuItemProperties.Price.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_Price" id="z_Price" value="="></p>
		</label>
		<div class="<%= MenuItemProperties_search.SearchRightColumnClass %>"><div<%= MenuItemProperties.Price.CellAttributes %>>
			<span id="el_MenuItemProperties_Price">
<input type="text" data-field="x_Price" name="x_Price" id="x_Price" size="30" placeholder="<%= MenuItemProperties.Price.PlaceHolder %>" value="<%= MenuItemProperties.Price.EditValue %>"<%= MenuItemProperties.Price.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If MenuItemProperties.IdMenuItem.Visible Then ' IdMenuItem %>
	<div id="r_IdMenuItem" class="form-group">
		<label for="x_IdMenuItem" class="<%= MenuItemProperties_search.SearchLabelClass %>"><span id="elh_MenuItemProperties_IdMenuItem"><%= MenuItemProperties.IdMenuItem.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_IdMenuItem" id="z_IdMenuItem" value="="></p>
		</label>
		<div class="<%= MenuItemProperties_search.SearchRightColumnClass %>"><div<%= MenuItemProperties.IdMenuItem.CellAttributes %>>
			<span id="el_MenuItemProperties_IdMenuItem">
<input type="text" data-field="x_IdMenuItem" name="x_IdMenuItem" id="x_IdMenuItem" size="30" placeholder="<%= MenuItemProperties.IdMenuItem.PlaceHolder %>" value="<%= MenuItemProperties.IdMenuItem.EditValue %>"<%= MenuItemProperties.IdMenuItem.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If MenuItemProperties.allowtoppings.Visible Then ' allowtoppings %>
	<div id="r_allowtoppings" class="form-group">
		<label for="x_allowtoppings" class="<%= MenuItemProperties_search.SearchLabelClass %>"><span id="elh_MenuItemProperties_allowtoppings"><%= MenuItemProperties.allowtoppings.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_allowtoppings" id="z_allowtoppings" value="="></p>
		</label>
		<div class="<%= MenuItemProperties_search.SearchRightColumnClass %>"><div<%= MenuItemProperties.allowtoppings.CellAttributes %>>
			<span id="el_MenuItemProperties_allowtoppings">
<input type="text" data-field="x_allowtoppings" name="x_allowtoppings" id="x_allowtoppings" size="30" placeholder="<%= MenuItemProperties.allowtoppings.PlaceHolder %>" value="<%= MenuItemProperties.allowtoppings.EditValue %>"<%= MenuItemProperties.allowtoppings.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If MenuItemProperties.dishpropertiesgroupid.Visible Then ' dishpropertiesgroupid %>
	<div id="r_dishpropertiesgroupid" class="form-group">
		<label for="x_dishpropertiesgroupid" class="<%= MenuItemProperties_search.SearchLabelClass %>"><span id="elh_MenuItemProperties_dishpropertiesgroupid"><%= MenuItemProperties.dishpropertiesgroupid.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_dishpropertiesgroupid" id="z_dishpropertiesgroupid" value="LIKE"></p>
		</label>
		<div class="<%= MenuItemProperties_search.SearchRightColumnClass %>"><div<%= MenuItemProperties.dishpropertiesgroupid.CellAttributes %>>
			<span id="el_MenuItemProperties_dishpropertiesgroupid">
<input type="text" data-field="x_dishpropertiesgroupid" name="x_dishpropertiesgroupid" id="x_dishpropertiesgroupid" size="30" maxlength="255" placeholder="<%= MenuItemProperties.dishpropertiesgroupid.PlaceHolder %>" value="<%= MenuItemProperties.dishpropertiesgroupid.EditValue %>"<%= MenuItemProperties.dishpropertiesgroupid.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If MenuItemProperties.printingname.Visible Then ' printingname %>
	<div id="r_printingname" class="form-group">
		<label for="x_printingname" class="<%= MenuItemProperties_search.SearchLabelClass %>"><span id="elh_MenuItemProperties_printingname"><%= MenuItemProperties.printingname.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_printingname" id="z_printingname" value="LIKE"></p>
		</label>
		<div class="<%= MenuItemProperties_search.SearchRightColumnClass %>"><div<%= MenuItemProperties.printingname.CellAttributes %>>
			<span id="el_MenuItemProperties_printingname">
<input type="text" data-field="x_printingname" name="x_printingname" id="x_printingname" size="30" maxlength="255" placeholder="<%= MenuItemProperties.printingname.PlaceHolder %>" value="<%= MenuItemProperties.printingname.EditValue %>"<%= MenuItemProperties.printingname.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If MenuItemProperties.i_displaysort.Visible Then ' i_displaysort %>
	<div id="r_i_displaysort" class="form-group">
		<label for="x_i_displaysort" class="<%= MenuItemProperties_search.SearchLabelClass %>"><span id="elh_MenuItemProperties_i_displaysort"><%= MenuItemProperties.i_displaysort.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_i_displaysort" id="z_i_displaysort" value="="></p>
		</label>
		<div class="<%= MenuItemProperties_search.SearchRightColumnClass %>"><div<%= MenuItemProperties.i_displaysort.CellAttributes %>>
			<span id="el_MenuItemProperties_i_displaysort">
<input type="text" data-field="x_i_displaysort" name="x_i_displaysort" id="x_i_displaysort" size="30" placeholder="<%= MenuItemProperties.i_displaysort.PlaceHolder %>" value="<%= MenuItemProperties.i_displaysort.EditValue %>"<%= MenuItemProperties.i_displaysort.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
</div>
<% If Not MenuItemProperties_search.IsModal Then %>
<div class="form-group">
	<div class="col-sm-offset-3 col-sm-9">
<button class="btn btn-primary ewButton" name="btnAction" id="btnAction" type="submit"><%= Language.Phrase("Search") %></button>
<button class="btn btn-default ewButton" name="btnReset" id="btnReset" type="button" onclick="ew_ClearForm(this.form);"><%= Language.Phrase("Reset") %></button>
	</div>
</div>
<% End If %>
</form>
<script type="text/javascript">
fMenuItemPropertiessearch.Init();
</script>
<%
MenuItemProperties_search.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set MenuItemProperties_search = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cMenuItemProperties_search

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
		TableName = "MenuItemProperties"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "MenuItemProperties_search"
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
		EW_PAGE_ID = "search"

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

		' Create form object
		'If ew_IsHttpPost() Then

			Set ObjForm = New cFormObj

		'Else
		'	Set ObjForm = ew_GetUploadObj()
		'End If

		MenuItemProperties.CurrentAction = ew_IIf(Request.QueryString("a").Count > 0, Request.QueryString("a") & "", ObjForm.GetValue("a_list") & "") ' Set up current action
		MenuItemProperties.Id.Visible = Not MenuItemProperties.IsAdd() And Not MenuItemProperties.IsCopy() And Not MenuItemProperties.IsGridAdd()

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
			MenuItemProperties.CurrentAction = ObjForm.GetValue("a_search")
			Select Case MenuItemProperties.CurrentAction
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
						sSrchStr = MenuItemProperties.UrlParm(sSrchStr)
						sSrchStr = "MenuItemPropertieslist.asp" & "?" & sSrchStr
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
		MenuItemProperties.RowType = EW_ROWTYPE_SEARCH
		Call RenderRow()
	End Sub

	' -----------------------------------------------------------------
	' Build advanced search
	'
	Function BuildAdvancedSearch()
		Dim sSrchUrl
		sSrchUrl = ""
		Call BuildSearchUrl(sSrchUrl, MenuItemProperties.Id, False) ' Id
		Call BuildSearchUrl(sSrchUrl, MenuItemProperties.Name, False) ' Name
		Call BuildSearchUrl(sSrchUrl, MenuItemProperties.Price, False) ' Price
		Call BuildSearchUrl(sSrchUrl, MenuItemProperties.IdMenuItem, False) ' IdMenuItem
		Call BuildSearchUrl(sSrchUrl, MenuItemProperties.allowtoppings, False) ' allowtoppings
		Call BuildSearchUrl(sSrchUrl, MenuItemProperties.dishpropertiesgroupid, False) ' dishpropertiesgroupid
		Call BuildSearchUrl(sSrchUrl, MenuItemProperties.printingname, False) ' printingname
		Call BuildSearchUrl(sSrchUrl, MenuItemProperties.i_displaysort, False) ' i_displaysort
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
		MenuItemProperties.Id.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Id")
		MenuItemProperties.Id.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Id")
		MenuItemProperties.Name.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Name")
		MenuItemProperties.Name.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Name")
		MenuItemProperties.Price.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Price")
		MenuItemProperties.Price.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Price")
		MenuItemProperties.IdMenuItem.AdvancedSearch.SearchValue = ObjForm.GetValue("x_IdMenuItem")
		MenuItemProperties.IdMenuItem.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_IdMenuItem")
		MenuItemProperties.allowtoppings.AdvancedSearch.SearchValue = ObjForm.GetValue("x_allowtoppings")
		MenuItemProperties.allowtoppings.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_allowtoppings")
		MenuItemProperties.dishpropertiesgroupid.AdvancedSearch.SearchValue = ObjForm.GetValue("x_dishpropertiesgroupid")
		MenuItemProperties.dishpropertiesgroupid.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_dishpropertiesgroupid")
		MenuItemProperties.printingname.AdvancedSearch.SearchValue = ObjForm.GetValue("x_printingname")
		MenuItemProperties.printingname.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_printingname")
		MenuItemProperties.i_displaysort.AdvancedSearch.SearchValue = ObjForm.GetValue("x_i_displaysort")
		MenuItemProperties.i_displaysort.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_i_displaysort")
	End Function

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

		' ------------
		'  Search Row
		' ------------

		ElseIf MenuItemProperties.RowType = EW_ROWTYPE_SEARCH Then ' Search row

			' Id
			MenuItemProperties.Id.EditAttrs.UpdateAttribute "class", "form-control"
			MenuItemProperties.Id.EditCustomAttributes = ""
			MenuItemProperties.Id.EditValue = ew_HtmlEncode(MenuItemProperties.Id.AdvancedSearch.SearchValue)
			MenuItemProperties.Id.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuItemProperties.Id.FldCaption))

			' Name
			MenuItemProperties.Name.EditAttrs.UpdateAttribute "class", "form-control"
			MenuItemProperties.Name.EditCustomAttributes = ""
			MenuItemProperties.Name.EditValue = ew_HtmlEncode(MenuItemProperties.Name.AdvancedSearch.SearchValue)
			MenuItemProperties.Name.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuItemProperties.Name.FldCaption))

			' Price
			MenuItemProperties.Price.EditAttrs.UpdateAttribute "class", "form-control"
			MenuItemProperties.Price.EditCustomAttributes = ""
			MenuItemProperties.Price.EditValue = ew_HtmlEncode(MenuItemProperties.Price.AdvancedSearch.SearchValue)
			MenuItemProperties.Price.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuItemProperties.Price.FldCaption))

			' IdMenuItem
			MenuItemProperties.IdMenuItem.EditAttrs.UpdateAttribute "class", "form-control"
			MenuItemProperties.IdMenuItem.EditCustomAttributes = ""
			MenuItemProperties.IdMenuItem.EditValue = ew_HtmlEncode(MenuItemProperties.IdMenuItem.AdvancedSearch.SearchValue)
			MenuItemProperties.IdMenuItem.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuItemProperties.IdMenuItem.FldCaption))

			' allowtoppings
			MenuItemProperties.allowtoppings.EditAttrs.UpdateAttribute "class", "form-control"
			MenuItemProperties.allowtoppings.EditCustomAttributes = ""
			MenuItemProperties.allowtoppings.EditValue = ew_HtmlEncode(MenuItemProperties.allowtoppings.AdvancedSearch.SearchValue)
			MenuItemProperties.allowtoppings.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuItemProperties.allowtoppings.FldCaption))

			' dishpropertiesgroupid
			MenuItemProperties.dishpropertiesgroupid.EditAttrs.UpdateAttribute "class", "form-control"
			MenuItemProperties.dishpropertiesgroupid.EditCustomAttributes = ""
			MenuItemProperties.dishpropertiesgroupid.EditValue = ew_HtmlEncode(MenuItemProperties.dishpropertiesgroupid.AdvancedSearch.SearchValue)
			MenuItemProperties.dishpropertiesgroupid.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuItemProperties.dishpropertiesgroupid.FldCaption))

			' printingname
			MenuItemProperties.printingname.EditAttrs.UpdateAttribute "class", "form-control"
			MenuItemProperties.printingname.EditCustomAttributes = ""
			MenuItemProperties.printingname.EditValue = ew_HtmlEncode(MenuItemProperties.printingname.AdvancedSearch.SearchValue)
			MenuItemProperties.printingname.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuItemProperties.printingname.FldCaption))

			' i_displaysort
			MenuItemProperties.i_displaysort.EditAttrs.UpdateAttribute "class", "form-control"
			MenuItemProperties.i_displaysort.EditCustomAttributes = ""
			MenuItemProperties.i_displaysort.EditValue = ew_HtmlEncode(MenuItemProperties.i_displaysort.AdvancedSearch.SearchValue)
			MenuItemProperties.i_displaysort.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuItemProperties.i_displaysort.FldCaption))
		End If
		If MenuItemProperties.RowType = EW_ROWTYPE_ADD Or MenuItemProperties.RowType = EW_ROWTYPE_EDIT Or MenuItemProperties.RowType = EW_ROWTYPE_SEARCH Then ' Add / Edit / Search row
			Call MenuItemProperties.SetupFieldTitles()
		End If

		' Call Row Rendered event
		If MenuItemProperties.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call MenuItemProperties.Row_Rendered()
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
		If Not ew_CheckInteger(MenuItemProperties.Id.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, MenuItemProperties.Id.FldErrMsg)
		End If
		If Not ew_CheckNumber(MenuItemProperties.Price.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, MenuItemProperties.Price.FldErrMsg)
		End If
		If Not ew_CheckInteger(MenuItemProperties.IdMenuItem.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, MenuItemProperties.IdMenuItem.FldErrMsg)
		End If
		If Not ew_CheckInteger(MenuItemProperties.allowtoppings.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, MenuItemProperties.allowtoppings.FldErrMsg)
		End If
		If Not ew_CheckInteger(MenuItemProperties.i_displaysort.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, MenuItemProperties.i_displaysort.FldErrMsg)
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
		Call MenuItemProperties.Id.AdvancedSearch.Load()
		Call MenuItemProperties.Name.AdvancedSearch.Load()
		Call MenuItemProperties.Price.AdvancedSearch.Load()
		Call MenuItemProperties.IdMenuItem.AdvancedSearch.Load()
		Call MenuItemProperties.allowtoppings.AdvancedSearch.Load()
		Call MenuItemProperties.dishpropertiesgroupid.AdvancedSearch.Load()
		Call MenuItemProperties.printingname.AdvancedSearch.Load()
		Call MenuItemProperties.i_displaysort.AdvancedSearch.Load()
End Function

	' Set up Breadcrumb
	Sub SetupBreadcrumb()
		Dim PageId, url
		Set Breadcrumb = New cBreadcrumb
		url = Mid(ew_CurrentUrl, InStrRev(ew_CurrentUrl, "/")+1)
		Call Breadcrumb.Add("list", MenuItemProperties.TableVar, "MenuItemPropertieslist.asp", "", MenuItemProperties.TableVar, True)
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
