<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="MenuToppingsinfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim MenuToppings_search
Set MenuToppings_search = New cMenuToppings_search
Set Page = MenuToppings_search

' Page init processing
MenuToppings_search.Page_Init()

' Page main processing
MenuToppings_search.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
MenuToppings_search.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var MenuToppings_search = new ew_Page("MenuToppings_search");
MenuToppings_search.PageID = "search"; // Page ID
var EW_PAGE_ID = MenuToppings_search.PageID; // For backward compatibility
// Form object
var fMenuToppingssearch = new ew_Form("fMenuToppingssearch");
// Form_CustomValidate event
fMenuToppingssearch.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fMenuToppingssearch.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fMenuToppingssearch.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
// Validate function for search
fMenuToppingssearch.Validate = function(fobj) {
	if (!this.ValidateRequired)
		return true; // Ignore validation
	fobj = fobj || this.Form;
	this.PostAutoSuggest();
	var infix = "";
	elm = this.GetElements("x" + infix + "_ID");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(MenuToppings.ID.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_toppingprice");
	if (elm && !ew_CheckNumber(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(MenuToppings.toppingprice.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_IdBusinessDetail");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(MenuToppings.IdBusinessDetail.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_toppinggroupid");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(MenuToppings.toppinggroupid.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_i_displaySort");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(MenuToppings.i_displaySort.FldErrMsg) %>");
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
<% If Not MenuToppings_search.IsModal Then %>
<div class="ewToolbar">
<% If MenuToppings.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If MenuToppings.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% End If %>
<% MenuToppings_search.ShowPageHeader() %>
<% MenuToppings_search.ShowMessage %>
<form name="fMenuToppingssearch" id="fMenuToppingssearch" class="form-horizontal ewForm ewSearchForm" action="<%= ew_CurrentPage %>" method="post">
<% If MenuToppings_search.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= MenuToppings_search.Token %>">
<% End If %>
<input type="hidden" name="t" value="MenuToppings">
<input type="hidden" name="a_search" id="a_search" value="S">
<% If MenuToppings_search.IsModal Then %>
<input type="hidden" name="modal" value="1">
<% End If %>
<div>
<% If MenuToppings.ID.Visible Then ' ID %>
	<div id="r_ID" class="form-group">
		<label for="x_ID" class="<%= MenuToppings_search.SearchLabelClass %>"><span id="elh_MenuToppings_ID"><%= MenuToppings.ID.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_ID" id="z_ID" value="="></p>
		</label>
		<div class="<%= MenuToppings_search.SearchRightColumnClass %>"><div<%= MenuToppings.ID.CellAttributes %>>
			<span id="el_MenuToppings_ID">
<input type="text" data-field="x_ID" name="x_ID" id="x_ID" placeholder="<%= MenuToppings.ID.PlaceHolder %>" value="<%= MenuToppings.ID.EditValue %>"<%= MenuToppings.ID.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If MenuToppings.topping.Visible Then ' topping %>
	<div id="r_topping" class="form-group">
		<label for="x_topping" class="<%= MenuToppings_search.SearchLabelClass %>"><span id="elh_MenuToppings_topping"><%= MenuToppings.topping.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_topping" id="z_topping" value="LIKE"></p>
		</label>
		<div class="<%= MenuToppings_search.SearchRightColumnClass %>"><div<%= MenuToppings.topping.CellAttributes %>>
			<span id="el_MenuToppings_topping">
<input type="text" data-field="x_topping" name="x_topping" id="x_topping" size="30" maxlength="255" placeholder="<%= MenuToppings.topping.PlaceHolder %>" value="<%= MenuToppings.topping.EditValue %>"<%= MenuToppings.topping.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If MenuToppings.toppingprice.Visible Then ' toppingprice %>
	<div id="r_toppingprice" class="form-group">
		<label for="x_toppingprice" class="<%= MenuToppings_search.SearchLabelClass %>"><span id="elh_MenuToppings_toppingprice"><%= MenuToppings.toppingprice.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_toppingprice" id="z_toppingprice" value="="></p>
		</label>
		<div class="<%= MenuToppings_search.SearchRightColumnClass %>"><div<%= MenuToppings.toppingprice.CellAttributes %>>
			<span id="el_MenuToppings_toppingprice">
<input type="text" data-field="x_toppingprice" name="x_toppingprice" id="x_toppingprice" size="30" placeholder="<%= MenuToppings.toppingprice.PlaceHolder %>" value="<%= MenuToppings.toppingprice.EditValue %>"<%= MenuToppings.toppingprice.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If MenuToppings.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
	<div id="r_IdBusinessDetail" class="form-group">
		<label for="x_IdBusinessDetail" class="<%= MenuToppings_search.SearchLabelClass %>"><span id="elh_MenuToppings_IdBusinessDetail"><%= MenuToppings.IdBusinessDetail.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_IdBusinessDetail" id="z_IdBusinessDetail" value="="></p>
		</label>
		<div class="<%= MenuToppings_search.SearchRightColumnClass %>"><div<%= MenuToppings.IdBusinessDetail.CellAttributes %>>
			<span id="el_MenuToppings_IdBusinessDetail">
<input type="text" data-field="x_IdBusinessDetail" name="x_IdBusinessDetail" id="x_IdBusinessDetail" size="30" placeholder="<%= MenuToppings.IdBusinessDetail.PlaceHolder %>" value="<%= MenuToppings.IdBusinessDetail.EditValue %>"<%= MenuToppings.IdBusinessDetail.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If MenuToppings.toppinggroupid.Visible Then ' toppinggroupid %>
	<div id="r_toppinggroupid" class="form-group">
		<label for="x_toppinggroupid" class="<%= MenuToppings_search.SearchLabelClass %>"><span id="elh_MenuToppings_toppinggroupid"><%= MenuToppings.toppinggroupid.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_toppinggroupid" id="z_toppinggroupid" value="="></p>
		</label>
		<div class="<%= MenuToppings_search.SearchRightColumnClass %>"><div<%= MenuToppings.toppinggroupid.CellAttributes %>>
			<span id="el_MenuToppings_toppinggroupid">
<input type="text" data-field="x_toppinggroupid" name="x_toppinggroupid" id="x_toppinggroupid" size="30" placeholder="<%= MenuToppings.toppinggroupid.PlaceHolder %>" value="<%= MenuToppings.toppinggroupid.EditValue %>"<%= MenuToppings.toppinggroupid.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If MenuToppings.printingname.Visible Then ' printingname %>
	<div id="r_printingname" class="form-group">
		<label for="x_printingname" class="<%= MenuToppings_search.SearchLabelClass %>"><span id="elh_MenuToppings_printingname"><%= MenuToppings.printingname.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_printingname" id="z_printingname" value="LIKE"></p>
		</label>
		<div class="<%= MenuToppings_search.SearchRightColumnClass %>"><div<%= MenuToppings.printingname.CellAttributes %>>
			<span id="el_MenuToppings_printingname">
<input type="text" data-field="x_printingname" name="x_printingname" id="x_printingname" size="30" maxlength="255" placeholder="<%= MenuToppings.printingname.PlaceHolder %>" value="<%= MenuToppings.printingname.EditValue %>"<%= MenuToppings.printingname.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If MenuToppings.i_displaySort.Visible Then ' i_displaySort %>
	<div id="r_i_displaySort" class="form-group">
		<label for="x_i_displaySort" class="<%= MenuToppings_search.SearchLabelClass %>"><span id="elh_MenuToppings_i_displaySort"><%= MenuToppings.i_displaySort.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_i_displaySort" id="z_i_displaySort" value="="></p>
		</label>
		<div class="<%= MenuToppings_search.SearchRightColumnClass %>"><div<%= MenuToppings.i_displaySort.CellAttributes %>>
			<span id="el_MenuToppings_i_displaySort">
<input type="text" data-field="x_i_displaySort" name="x_i_displaySort" id="x_i_displaySort" size="30" placeholder="<%= MenuToppings.i_displaySort.PlaceHolder %>" value="<%= MenuToppings.i_displaySort.EditValue %>"<%= MenuToppings.i_displaySort.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
</div>
<% If Not MenuToppings_search.IsModal Then %>
<div class="form-group">
	<div class="col-sm-offset-3 col-sm-9">
<button class="btn btn-primary ewButton" name="btnAction" id="btnAction" type="submit"><%= Language.Phrase("Search") %></button>
<button class="btn btn-default ewButton" name="btnReset" id="btnReset" type="button" onclick="ew_ClearForm(this.form);"><%= Language.Phrase("Reset") %></button>
	</div>
</div>
<% End If %>
</form>
<script type="text/javascript">
fMenuToppingssearch.Init();
</script>
<%
MenuToppings_search.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set MenuToppings_search = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cMenuToppings_search

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
		TableName = "MenuToppings"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "MenuToppings_search"
	End Property

	' Page Name
	Public Property Get PageName()
		PageName = ew_CurrentPage()
	End Property

	' Page Url
	Public Property Get PageUrl()
		PageUrl = ew_CurrentPage() & "?"
		If MenuToppings.UseTokenInUrl Then PageUrl = PageUrl & "t=" & MenuToppings.TableVar & "&" ' add page token
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
		If MenuToppings.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (MenuToppings.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (MenuToppings.TableVar = Request.QueryString("t"))
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
		If IsEmpty(MenuToppings) Then Set MenuToppings = New cMenuToppings
		Set Table = MenuToppings

		' Initialize urls
		' Initialize form object

		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "search"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "MenuToppings"

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

		MenuToppings.CurrentAction = ew_IIf(Request.QueryString("a").Count > 0, Request.QueryString("a") & "", ObjForm.GetValue("a_list") & "") ' Set up current action
		MenuToppings.ID.Visible = Not MenuToppings.IsAdd() And Not MenuToppings.IsCopy() And Not MenuToppings.IsGridAdd()

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
			results = MenuToppings.GetAutoFill(Request.Form("name"), Request.Form("q"))
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
		If Not MenuToppings Is Nothing Then
			If MenuToppings.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = MenuToppings.TableVar
				If MenuToppings.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf MenuToppings.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf MenuToppings.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf MenuToppings.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set MenuToppings = Nothing
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
			MenuToppings.CurrentAction = ObjForm.GetValue("a_search")
			Select Case MenuToppings.CurrentAction
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
						sSrchStr = MenuToppings.UrlParm(sSrchStr)
						sSrchStr = "MenuToppingslist.asp" & "?" & sSrchStr
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
		MenuToppings.RowType = EW_ROWTYPE_SEARCH
		Call RenderRow()
	End Sub

	' -----------------------------------------------------------------
	' Build advanced search
	'
	Function BuildAdvancedSearch()
		Dim sSrchUrl
		sSrchUrl = ""
		Call BuildSearchUrl(sSrchUrl, MenuToppings.ID, False) ' ID
		Call BuildSearchUrl(sSrchUrl, MenuToppings.topping, False) ' topping
		Call BuildSearchUrl(sSrchUrl, MenuToppings.toppingprice, False) ' toppingprice
		Call BuildSearchUrl(sSrchUrl, MenuToppings.IdBusinessDetail, False) ' IdBusinessDetail
		Call BuildSearchUrl(sSrchUrl, MenuToppings.toppinggroupid, False) ' toppinggroupid
		Call BuildSearchUrl(sSrchUrl, MenuToppings.printingname, False) ' printingname
		Call BuildSearchUrl(sSrchUrl, MenuToppings.i_displaySort, False) ' i_displaySort
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
		MenuToppings.ID.AdvancedSearch.SearchValue = ObjForm.GetValue("x_ID")
		MenuToppings.ID.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_ID")
		MenuToppings.topping.AdvancedSearch.SearchValue = ObjForm.GetValue("x_topping")
		MenuToppings.topping.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_topping")
		MenuToppings.toppingprice.AdvancedSearch.SearchValue = ObjForm.GetValue("x_toppingprice")
		MenuToppings.toppingprice.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_toppingprice")
		MenuToppings.IdBusinessDetail.AdvancedSearch.SearchValue = ObjForm.GetValue("x_IdBusinessDetail")
		MenuToppings.IdBusinessDetail.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_IdBusinessDetail")
		MenuToppings.toppinggroupid.AdvancedSearch.SearchValue = ObjForm.GetValue("x_toppinggroupid")
		MenuToppings.toppinggroupid.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_toppinggroupid")
		MenuToppings.printingname.AdvancedSearch.SearchValue = ObjForm.GetValue("x_printingname")
		MenuToppings.printingname.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_printingname")
		MenuToppings.i_displaySort.AdvancedSearch.SearchValue = ObjForm.GetValue("x_i_displaySort")
		MenuToppings.i_displaySort.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_i_displaySort")
	End Function

	' -----------------------------------------------------------------
	' Render row values based on field settings
	'
	Sub RenderRow()

		' Initialize urls
		' Convert decimal values if posted back

		If MenuToppings.toppingprice.FormValue = MenuToppings.toppingprice.CurrentValue And IsNumeric(MenuToppings.toppingprice.CurrentValue) Then
			MenuToppings.toppingprice.CurrentValue = ew_StrToFloat(MenuToppings.toppingprice.CurrentValue)
		End If

		' Call Row Rendering event
		Call MenuToppings.Row_Rendering()

		' ---------------------------------------
		'  Common render codes for all row types
		' ---------------------------------------
		' ID
		' topping
		' toppingprice
		' IdBusinessDetail
		' toppinggroupid
		' printingname
		' i_displaySort
		' -----------
		'  View  Row
		' -----------

		If MenuToppings.RowType = EW_ROWTYPE_VIEW Then ' View row

			' ID
			MenuToppings.ID.ViewValue = MenuToppings.ID.CurrentValue
			MenuToppings.ID.ViewCustomAttributes = ""

			' topping
			MenuToppings.topping.ViewValue = MenuToppings.topping.CurrentValue
			MenuToppings.topping.ViewCustomAttributes = ""

			' toppingprice
			MenuToppings.toppingprice.ViewValue = MenuToppings.toppingprice.CurrentValue
			MenuToppings.toppingprice.ViewCustomAttributes = ""

			' IdBusinessDetail
			MenuToppings.IdBusinessDetail.ViewValue = MenuToppings.IdBusinessDetail.CurrentValue
			MenuToppings.IdBusinessDetail.ViewCustomAttributes = ""

			' toppinggroupid
			MenuToppings.toppinggroupid.ViewValue = MenuToppings.toppinggroupid.CurrentValue
			MenuToppings.toppinggroupid.ViewCustomAttributes = ""

			' printingname
			MenuToppings.printingname.ViewValue = MenuToppings.printingname.CurrentValue
			MenuToppings.printingname.ViewCustomAttributes = ""

			' i_displaySort
			MenuToppings.i_displaySort.ViewValue = MenuToppings.i_displaySort.CurrentValue
			MenuToppings.i_displaySort.ViewCustomAttributes = ""

			' View refer script
			' ID

			MenuToppings.ID.LinkCustomAttributes = ""
			MenuToppings.ID.HrefValue = ""
			MenuToppings.ID.TooltipValue = ""

			' topping
			MenuToppings.topping.LinkCustomAttributes = ""
			MenuToppings.topping.HrefValue = ""
			MenuToppings.topping.TooltipValue = ""

			' toppingprice
			MenuToppings.toppingprice.LinkCustomAttributes = ""
			MenuToppings.toppingprice.HrefValue = ""
			MenuToppings.toppingprice.TooltipValue = ""

			' IdBusinessDetail
			MenuToppings.IdBusinessDetail.LinkCustomAttributes = ""
			MenuToppings.IdBusinessDetail.HrefValue = ""
			MenuToppings.IdBusinessDetail.TooltipValue = ""

			' toppinggroupid
			MenuToppings.toppinggroupid.LinkCustomAttributes = ""
			MenuToppings.toppinggroupid.HrefValue = ""
			MenuToppings.toppinggroupid.TooltipValue = ""

			' printingname
			MenuToppings.printingname.LinkCustomAttributes = ""
			MenuToppings.printingname.HrefValue = ""
			MenuToppings.printingname.TooltipValue = ""

			' i_displaySort
			MenuToppings.i_displaySort.LinkCustomAttributes = ""
			MenuToppings.i_displaySort.HrefValue = ""
			MenuToppings.i_displaySort.TooltipValue = ""

		' ------------
		'  Search Row
		' ------------

		ElseIf MenuToppings.RowType = EW_ROWTYPE_SEARCH Then ' Search row

			' ID
			MenuToppings.ID.EditAttrs.UpdateAttribute "class", "form-control"
			MenuToppings.ID.EditCustomAttributes = ""
			MenuToppings.ID.EditValue = ew_HtmlEncode(MenuToppings.ID.AdvancedSearch.SearchValue)
			MenuToppings.ID.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuToppings.ID.FldCaption))

			' topping
			MenuToppings.topping.EditAttrs.UpdateAttribute "class", "form-control"
			MenuToppings.topping.EditCustomAttributes = ""
			MenuToppings.topping.EditValue = ew_HtmlEncode(MenuToppings.topping.AdvancedSearch.SearchValue)
			MenuToppings.topping.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuToppings.topping.FldCaption))

			' toppingprice
			MenuToppings.toppingprice.EditAttrs.UpdateAttribute "class", "form-control"
			MenuToppings.toppingprice.EditCustomAttributes = ""
			MenuToppings.toppingprice.EditValue = ew_HtmlEncode(MenuToppings.toppingprice.AdvancedSearch.SearchValue)
			MenuToppings.toppingprice.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuToppings.toppingprice.FldCaption))

			' IdBusinessDetail
			MenuToppings.IdBusinessDetail.EditAttrs.UpdateAttribute "class", "form-control"
			MenuToppings.IdBusinessDetail.EditCustomAttributes = ""
			MenuToppings.IdBusinessDetail.EditValue = ew_HtmlEncode(MenuToppings.IdBusinessDetail.AdvancedSearch.SearchValue)
			MenuToppings.IdBusinessDetail.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuToppings.IdBusinessDetail.FldCaption))

			' toppinggroupid
			MenuToppings.toppinggroupid.EditAttrs.UpdateAttribute "class", "form-control"
			MenuToppings.toppinggroupid.EditCustomAttributes = ""
			MenuToppings.toppinggroupid.EditValue = ew_HtmlEncode(MenuToppings.toppinggroupid.AdvancedSearch.SearchValue)
			MenuToppings.toppinggroupid.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuToppings.toppinggroupid.FldCaption))

			' printingname
			MenuToppings.printingname.EditAttrs.UpdateAttribute "class", "form-control"
			MenuToppings.printingname.EditCustomAttributes = ""
			MenuToppings.printingname.EditValue = ew_HtmlEncode(MenuToppings.printingname.AdvancedSearch.SearchValue)
			MenuToppings.printingname.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuToppings.printingname.FldCaption))

			' i_displaySort
			MenuToppings.i_displaySort.EditAttrs.UpdateAttribute "class", "form-control"
			MenuToppings.i_displaySort.EditCustomAttributes = ""
			MenuToppings.i_displaySort.EditValue = ew_HtmlEncode(MenuToppings.i_displaySort.AdvancedSearch.SearchValue)
			MenuToppings.i_displaySort.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuToppings.i_displaySort.FldCaption))
		End If
		If MenuToppings.RowType = EW_ROWTYPE_ADD Or MenuToppings.RowType = EW_ROWTYPE_EDIT Or MenuToppings.RowType = EW_ROWTYPE_SEARCH Then ' Add / Edit / Search row
			Call MenuToppings.SetupFieldTitles()
		End If

		' Call Row Rendered event
		If MenuToppings.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call MenuToppings.Row_Rendered()
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
		If Not ew_CheckInteger(MenuToppings.ID.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, MenuToppings.ID.FldErrMsg)
		End If
		If Not ew_CheckNumber(MenuToppings.toppingprice.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, MenuToppings.toppingprice.FldErrMsg)
		End If
		If Not ew_CheckInteger(MenuToppings.IdBusinessDetail.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, MenuToppings.IdBusinessDetail.FldErrMsg)
		End If
		If Not ew_CheckInteger(MenuToppings.toppinggroupid.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, MenuToppings.toppinggroupid.FldErrMsg)
		End If
		If Not ew_CheckInteger(MenuToppings.i_displaySort.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, MenuToppings.i_displaySort.FldErrMsg)
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
		Call MenuToppings.ID.AdvancedSearch.Load()
		Call MenuToppings.topping.AdvancedSearch.Load()
		Call MenuToppings.toppingprice.AdvancedSearch.Load()
		Call MenuToppings.IdBusinessDetail.AdvancedSearch.Load()
		Call MenuToppings.toppinggroupid.AdvancedSearch.Load()
		Call MenuToppings.printingname.AdvancedSearch.Load()
		Call MenuToppings.i_displaySort.AdvancedSearch.Load()
End Function

	' Set up Breadcrumb
	Sub SetupBreadcrumb()
		Dim PageId, url
		Set Breadcrumb = New cBreadcrumb
		url = Mid(ew_CurrentUrl, InStrRev(ew_CurrentUrl, "/")+1)
		Call Breadcrumb.Add("list", MenuToppings.TableVar, "MenuToppingslist.asp", "", MenuToppings.TableVar, True)
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
