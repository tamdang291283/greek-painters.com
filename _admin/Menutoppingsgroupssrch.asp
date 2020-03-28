<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="Menutoppingsgroupsinfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim Menutoppingsgroups_search
Set Menutoppingsgroups_search = New cMenutoppingsgroups_search
Set Page = Menutoppingsgroups_search

' Page init processing
Menutoppingsgroups_search.Page_Init()

' Page main processing
Menutoppingsgroups_search.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
Menutoppingsgroups_search.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var Menutoppingsgroups_search = new ew_Page("Menutoppingsgroups_search");
Menutoppingsgroups_search.PageID = "search"; // Page ID
var EW_PAGE_ID = Menutoppingsgroups_search.PageID; // For backward compatibility
// Form object
var fMenutoppingsgroupssearch = new ew_Form("fMenutoppingsgroupssearch");
// Form_CustomValidate event
fMenutoppingsgroupssearch.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fMenutoppingsgroupssearch.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fMenutoppingsgroupssearch.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
// Validate function for search
fMenutoppingsgroupssearch.Validate = function(fobj) {
	if (!this.ValidateRequired)
		return true; // Ignore validation
	fobj = fobj || this.Form;
	this.PostAutoSuggest();
	var infix = "";
	elm = this.GetElements("x" + infix + "_ID");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(Menutoppingsgroups.ID.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_IdBusinessDetail");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(Menutoppingsgroups.IdBusinessDetail.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_i_displaySort");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(Menutoppingsgroups.i_displaySort.FldErrMsg) %>");
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
<% If Not Menutoppingsgroups_search.IsModal Then %>
<div class="ewToolbar">
<% If Menutoppingsgroups.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If Menutoppingsgroups.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% End If %>
<% Menutoppingsgroups_search.ShowPageHeader() %>
<% Menutoppingsgroups_search.ShowMessage %>
<form name="fMenutoppingsgroupssearch" id="fMenutoppingsgroupssearch" class="form-horizontal ewForm ewSearchForm" action="<%= ew_CurrentPage %>" method="post">
<% If Menutoppingsgroups_search.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= Menutoppingsgroups_search.Token %>">
<% End If %>
<input type="hidden" name="t" value="Menutoppingsgroups">
<input type="hidden" name="a_search" id="a_search" value="S">
<% If Menutoppingsgroups_search.IsModal Then %>
<input type="hidden" name="modal" value="1">
<% End If %>
<div>
<% If Menutoppingsgroups.ID.Visible Then ' ID %>
	<div id="r_ID" class="form-group">
		<label for="x_ID" class="<%= Menutoppingsgroups_search.SearchLabelClass %>"><span id="elh_Menutoppingsgroups_ID"><%= Menutoppingsgroups.ID.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_ID" id="z_ID" value="="></p>
		</label>
		<div class="<%= Menutoppingsgroups_search.SearchRightColumnClass %>"><div<%= Menutoppingsgroups.ID.CellAttributes %>>
			<span id="el_Menutoppingsgroups_ID">
<input type="text" data-field="x_ID" name="x_ID" id="x_ID" placeholder="<%= Menutoppingsgroups.ID.PlaceHolder %>" value="<%= Menutoppingsgroups.ID.EditValue %>"<%= Menutoppingsgroups.ID.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Menutoppingsgroups.toppingsgroup.Visible Then ' toppingsgroup %>
	<div id="r_toppingsgroup" class="form-group">
		<label for="x_toppingsgroup" class="<%= Menutoppingsgroups_search.SearchLabelClass %>"><span id="elh_Menutoppingsgroups_toppingsgroup"><%= Menutoppingsgroups.toppingsgroup.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_toppingsgroup" id="z_toppingsgroup" value="LIKE"></p>
		</label>
		<div class="<%= Menutoppingsgroups_search.SearchRightColumnClass %>"><div<%= Menutoppingsgroups.toppingsgroup.CellAttributes %>>
			<span id="el_Menutoppingsgroups_toppingsgroup">
<input type="text" data-field="x_toppingsgroup" name="x_toppingsgroup" id="x_toppingsgroup" size="30" maxlength="255" placeholder="<%= Menutoppingsgroups.toppingsgroup.PlaceHolder %>" value="<%= Menutoppingsgroups.toppingsgroup.EditValue %>"<%= Menutoppingsgroups.toppingsgroup.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Menutoppingsgroups.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
	<div id="r_IdBusinessDetail" class="form-group">
		<label for="x_IdBusinessDetail" class="<%= Menutoppingsgroups_search.SearchLabelClass %>"><span id="elh_Menutoppingsgroups_IdBusinessDetail"><%= Menutoppingsgroups.IdBusinessDetail.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_IdBusinessDetail" id="z_IdBusinessDetail" value="="></p>
		</label>
		<div class="<%= Menutoppingsgroups_search.SearchRightColumnClass %>"><div<%= Menutoppingsgroups.IdBusinessDetail.CellAttributes %>>
			<span id="el_Menutoppingsgroups_IdBusinessDetail">
<input type="text" data-field="x_IdBusinessDetail" name="x_IdBusinessDetail" id="x_IdBusinessDetail" size="30" placeholder="<%= Menutoppingsgroups.IdBusinessDetail.PlaceHolder %>" value="<%= Menutoppingsgroups.IdBusinessDetail.EditValue %>"<%= Menutoppingsgroups.IdBusinessDetail.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Menutoppingsgroups.printingname.Visible Then ' printingname %>
	<div id="r_printingname" class="form-group">
		<label for="x_printingname" class="<%= Menutoppingsgroups_search.SearchLabelClass %>"><span id="elh_Menutoppingsgroups_printingname"><%= Menutoppingsgroups.printingname.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_printingname" id="z_printingname" value="LIKE"></p>
		</label>
		<div class="<%= Menutoppingsgroups_search.SearchRightColumnClass %>"><div<%= Menutoppingsgroups.printingname.CellAttributes %>>
			<span id="el_Menutoppingsgroups_printingname">
<input type="text" data-field="x_printingname" name="x_printingname" id="x_printingname" size="30" maxlength="255" placeholder="<%= Menutoppingsgroups.printingname.PlaceHolder %>" value="<%= Menutoppingsgroups.printingname.EditValue %>"<%= Menutoppingsgroups.printingname.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Menutoppingsgroups.i_displaySort.Visible Then ' i_displaySort %>
	<div id="r_i_displaySort" class="form-group">
		<label for="x_i_displaySort" class="<%= Menutoppingsgroups_search.SearchLabelClass %>"><span id="elh_Menutoppingsgroups_i_displaySort"><%= Menutoppingsgroups.i_displaySort.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_i_displaySort" id="z_i_displaySort" value="="></p>
		</label>
		<div class="<%= Menutoppingsgroups_search.SearchRightColumnClass %>"><div<%= Menutoppingsgroups.i_displaySort.CellAttributes %>>
			<span id="el_Menutoppingsgroups_i_displaySort">
<input type="text" data-field="x_i_displaySort" name="x_i_displaySort" id="x_i_displaySort" size="30" placeholder="<%= Menutoppingsgroups.i_displaySort.PlaceHolder %>" value="<%= Menutoppingsgroups.i_displaySort.EditValue %>"<%= Menutoppingsgroups.i_displaySort.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
</div>
<% If Not Menutoppingsgroups_search.IsModal Then %>
<div class="form-group">
	<div class="col-sm-offset-3 col-sm-9">
<button class="btn btn-primary ewButton" name="btnAction" id="btnAction" type="submit"><%= Language.Phrase("Search") %></button>
<button class="btn btn-default ewButton" name="btnReset" id="btnReset" type="button" onclick="ew_ClearForm(this.form);"><%= Language.Phrase("Reset") %></button>
	</div>
</div>
<% End If %>
</form>
<script type="text/javascript">
fMenutoppingsgroupssearch.Init();
</script>
<%
Menutoppingsgroups_search.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set Menutoppingsgroups_search = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cMenutoppingsgroups_search

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
		TableName = "Menutoppingsgroups"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "Menutoppingsgroups_search"
	End Property

	' Page Name
	Public Property Get PageName()
		PageName = ew_CurrentPage()
	End Property

	' Page Url
	Public Property Get PageUrl()
		PageUrl = ew_CurrentPage() & "?"
		If Menutoppingsgroups.UseTokenInUrl Then PageUrl = PageUrl & "t=" & Menutoppingsgroups.TableVar & "&" ' add page token
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
		If Menutoppingsgroups.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (Menutoppingsgroups.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (Menutoppingsgroups.TableVar = Request.QueryString("t"))
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
		If IsEmpty(Menutoppingsgroups) Then Set Menutoppingsgroups = New cMenutoppingsgroups
		Set Table = Menutoppingsgroups

		' Initialize urls
		' Initialize form object

		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "search"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "Menutoppingsgroups"

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

		Menutoppingsgroups.CurrentAction = ew_IIf(Request.QueryString("a").Count > 0, Request.QueryString("a") & "", ObjForm.GetValue("a_list") & "") ' Set up current action
		Menutoppingsgroups.ID.Visible = Not Menutoppingsgroups.IsAdd() And Not Menutoppingsgroups.IsCopy() And Not Menutoppingsgroups.IsGridAdd()

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
			results = Menutoppingsgroups.GetAutoFill(Request.Form("name"), Request.Form("q"))
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
		If Not Menutoppingsgroups Is Nothing Then
			If Menutoppingsgroups.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = Menutoppingsgroups.TableVar
				If Menutoppingsgroups.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf Menutoppingsgroups.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf Menutoppingsgroups.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf Menutoppingsgroups.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set Menutoppingsgroups = Nothing
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
			Menutoppingsgroups.CurrentAction = ObjForm.GetValue("a_search")
			Select Case Menutoppingsgroups.CurrentAction
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
						sSrchStr = Menutoppingsgroups.UrlParm(sSrchStr)
						sSrchStr = "Menutoppingsgroupslist.asp" & "?" & sSrchStr
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
		Menutoppingsgroups.RowType = EW_ROWTYPE_SEARCH
		Call RenderRow()
	End Sub

	' -----------------------------------------------------------------
	' Build advanced search
	'
	Function BuildAdvancedSearch()
		Dim sSrchUrl
		sSrchUrl = ""
		Call BuildSearchUrl(sSrchUrl, Menutoppingsgroups.ID, False) ' ID
		Call BuildSearchUrl(sSrchUrl, Menutoppingsgroups.toppingsgroup, False) ' toppingsgroup
		Call BuildSearchUrl(sSrchUrl, Menutoppingsgroups.IdBusinessDetail, False) ' IdBusinessDetail
		Call BuildSearchUrl(sSrchUrl, Menutoppingsgroups.printingname, False) ' printingname
		Call BuildSearchUrl(sSrchUrl, Menutoppingsgroups.i_displaySort, False) ' i_displaySort
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
		Menutoppingsgroups.ID.AdvancedSearch.SearchValue = ObjForm.GetValue("x_ID")
		Menutoppingsgroups.ID.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_ID")
		Menutoppingsgroups.toppingsgroup.AdvancedSearch.SearchValue = ObjForm.GetValue("x_toppingsgroup")
		Menutoppingsgroups.toppingsgroup.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_toppingsgroup")
		Menutoppingsgroups.IdBusinessDetail.AdvancedSearch.SearchValue = ObjForm.GetValue("x_IdBusinessDetail")
		Menutoppingsgroups.IdBusinessDetail.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_IdBusinessDetail")
		Menutoppingsgroups.printingname.AdvancedSearch.SearchValue = ObjForm.GetValue("x_printingname")
		Menutoppingsgroups.printingname.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_printingname")
		Menutoppingsgroups.i_displaySort.AdvancedSearch.SearchValue = ObjForm.GetValue("x_i_displaySort")
		Menutoppingsgroups.i_displaySort.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_i_displaySort")
	End Function

	' -----------------------------------------------------------------
	' Render row values based on field settings
	'
	Sub RenderRow()

		' Initialize urls
		' Call Row Rendering event

		Call Menutoppingsgroups.Row_Rendering()

		' ---------------------------------------
		'  Common render codes for all row types
		' ---------------------------------------
		' ID
		' toppingsgroup
		' IdBusinessDetail
		' printingname
		' i_displaySort
		' -----------
		'  View  Row
		' -----------

		If Menutoppingsgroups.RowType = EW_ROWTYPE_VIEW Then ' View row

			' ID
			Menutoppingsgroups.ID.ViewValue = Menutoppingsgroups.ID.CurrentValue
			Menutoppingsgroups.ID.ViewCustomAttributes = ""

			' toppingsgroup
			Menutoppingsgroups.toppingsgroup.ViewValue = Menutoppingsgroups.toppingsgroup.CurrentValue
			Menutoppingsgroups.toppingsgroup.ViewCustomAttributes = ""

			' IdBusinessDetail
			Menutoppingsgroups.IdBusinessDetail.ViewValue = Menutoppingsgroups.IdBusinessDetail.CurrentValue
			Menutoppingsgroups.IdBusinessDetail.ViewCustomAttributes = ""

			' printingname
			Menutoppingsgroups.printingname.ViewValue = Menutoppingsgroups.printingname.CurrentValue
			Menutoppingsgroups.printingname.ViewCustomAttributes = ""

			' i_displaySort
			Menutoppingsgroups.i_displaySort.ViewValue = Menutoppingsgroups.i_displaySort.CurrentValue
			Menutoppingsgroups.i_displaySort.ViewCustomAttributes = ""

			' View refer script
			' ID

			Menutoppingsgroups.ID.LinkCustomAttributes = ""
			Menutoppingsgroups.ID.HrefValue = ""
			Menutoppingsgroups.ID.TooltipValue = ""

			' toppingsgroup
			Menutoppingsgroups.toppingsgroup.LinkCustomAttributes = ""
			Menutoppingsgroups.toppingsgroup.HrefValue = ""
			Menutoppingsgroups.toppingsgroup.TooltipValue = ""

			' IdBusinessDetail
			Menutoppingsgroups.IdBusinessDetail.LinkCustomAttributes = ""
			Menutoppingsgroups.IdBusinessDetail.HrefValue = ""
			Menutoppingsgroups.IdBusinessDetail.TooltipValue = ""

			' printingname
			Menutoppingsgroups.printingname.LinkCustomAttributes = ""
			Menutoppingsgroups.printingname.HrefValue = ""
			Menutoppingsgroups.printingname.TooltipValue = ""

			' i_displaySort
			Menutoppingsgroups.i_displaySort.LinkCustomAttributes = ""
			Menutoppingsgroups.i_displaySort.HrefValue = ""
			Menutoppingsgroups.i_displaySort.TooltipValue = ""

		' ------------
		'  Search Row
		' ------------

		ElseIf Menutoppingsgroups.RowType = EW_ROWTYPE_SEARCH Then ' Search row

			' ID
			Menutoppingsgroups.ID.EditAttrs.UpdateAttribute "class", "form-control"
			Menutoppingsgroups.ID.EditCustomAttributes = ""
			Menutoppingsgroups.ID.EditValue = ew_HtmlEncode(Menutoppingsgroups.ID.AdvancedSearch.SearchValue)
			Menutoppingsgroups.ID.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Menutoppingsgroups.ID.FldCaption))

			' toppingsgroup
			Menutoppingsgroups.toppingsgroup.EditAttrs.UpdateAttribute "class", "form-control"
			Menutoppingsgroups.toppingsgroup.EditCustomAttributes = ""
			Menutoppingsgroups.toppingsgroup.EditValue = ew_HtmlEncode(Menutoppingsgroups.toppingsgroup.AdvancedSearch.SearchValue)
			Menutoppingsgroups.toppingsgroup.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Menutoppingsgroups.toppingsgroup.FldCaption))

			' IdBusinessDetail
			Menutoppingsgroups.IdBusinessDetail.EditAttrs.UpdateAttribute "class", "form-control"
			Menutoppingsgroups.IdBusinessDetail.EditCustomAttributes = ""
			Menutoppingsgroups.IdBusinessDetail.EditValue = ew_HtmlEncode(Menutoppingsgroups.IdBusinessDetail.AdvancedSearch.SearchValue)
			Menutoppingsgroups.IdBusinessDetail.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Menutoppingsgroups.IdBusinessDetail.FldCaption))

			' printingname
			Menutoppingsgroups.printingname.EditAttrs.UpdateAttribute "class", "form-control"
			Menutoppingsgroups.printingname.EditCustomAttributes = ""
			Menutoppingsgroups.printingname.EditValue = ew_HtmlEncode(Menutoppingsgroups.printingname.AdvancedSearch.SearchValue)
			Menutoppingsgroups.printingname.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Menutoppingsgroups.printingname.FldCaption))

			' i_displaySort
			Menutoppingsgroups.i_displaySort.EditAttrs.UpdateAttribute "class", "form-control"
			Menutoppingsgroups.i_displaySort.EditCustomAttributes = ""
			Menutoppingsgroups.i_displaySort.EditValue = ew_HtmlEncode(Menutoppingsgroups.i_displaySort.AdvancedSearch.SearchValue)
			Menutoppingsgroups.i_displaySort.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Menutoppingsgroups.i_displaySort.FldCaption))
		End If
		If Menutoppingsgroups.RowType = EW_ROWTYPE_ADD Or Menutoppingsgroups.RowType = EW_ROWTYPE_EDIT Or Menutoppingsgroups.RowType = EW_ROWTYPE_SEARCH Then ' Add / Edit / Search row
			Call Menutoppingsgroups.SetupFieldTitles()
		End If

		' Call Row Rendered event
		If Menutoppingsgroups.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call Menutoppingsgroups.Row_Rendered()
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
		If Not ew_CheckInteger(Menutoppingsgroups.ID.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, Menutoppingsgroups.ID.FldErrMsg)
		End If
		If Not ew_CheckInteger(Menutoppingsgroups.IdBusinessDetail.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, Menutoppingsgroups.IdBusinessDetail.FldErrMsg)
		End If
		If Not ew_CheckInteger(Menutoppingsgroups.i_displaySort.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, Menutoppingsgroups.i_displaySort.FldErrMsg)
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
		Call Menutoppingsgroups.ID.AdvancedSearch.Load()
		Call Menutoppingsgroups.toppingsgroup.AdvancedSearch.Load()
		Call Menutoppingsgroups.IdBusinessDetail.AdvancedSearch.Load()
		Call Menutoppingsgroups.printingname.AdvancedSearch.Load()
		Call Menutoppingsgroups.i_displaySort.AdvancedSearch.Load()
End Function

	' Set up Breadcrumb
	Sub SetupBreadcrumb()
		Dim PageId, url
		Set Breadcrumb = New cBreadcrumb
		url = Mid(ew_CurrentUrl, InStrRev(ew_CurrentUrl, "/")+1)
		Call Breadcrumb.Add("list", Menutoppingsgroups.TableVar, "Menutoppingsgroupslist.asp", "", Menutoppingsgroups.TableVar, True)
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
