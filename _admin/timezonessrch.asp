<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="timezonesinfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim timezones_search
Set timezones_search = New ctimezones_search
Set Page = timezones_search

' Page init processing
timezones_search.Page_Init()

' Page main processing
timezones_search.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
timezones_search.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var timezones_search = new ew_Page("timezones_search");
timezones_search.PageID = "search"; // Page ID
var EW_PAGE_ID = timezones_search.PageID; // For backward compatibility
// Form object
var ftimezonessearch = new ew_Form("ftimezonessearch");
// Form_CustomValidate event
ftimezonessearch.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
ftimezonessearch.ValidateRequired = true; // Use JavaScript validation
<% Else %>
ftimezonessearch.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
// Validate function for search
ftimezonessearch.Validate = function(fobj) {
	if (!this.ValidateRequired)
		return true; // Ignore validation
	fobj = fobj || this.Form;
	this.PostAutoSuggest();
	var infix = "";
	elm = this.GetElements("x" + infix + "_ID");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(timezones.ID.FldErrMsg) %>");
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
<% If Not timezones_search.IsModal Then %>
<div class="ewToolbar">
<% If timezones.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If timezones.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% End If %>
<% timezones_search.ShowPageHeader() %>
<% timezones_search.ShowMessage %>
<form name="ftimezonessearch" id="ftimezonessearch" class="form-horizontal ewForm ewSearchForm" action="<%= ew_CurrentPage %>" method="post">
<% If timezones_search.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= timezones_search.Token %>">
<% End If %>
<input type="hidden" name="t" value="timezones">
<input type="hidden" name="a_search" id="a_search" value="S">
<% If timezones_search.IsModal Then %>
<input type="hidden" name="modal" value="1">
<% End If %>
<div>
<% If timezones.ID.Visible Then ' ID %>
	<div id="r_ID" class="form-group">
		<label for="x_ID" class="<%= timezones_search.SearchLabelClass %>"><span id="elh_timezones_ID"><%= timezones.ID.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_ID" id="z_ID" value="="></p>
		</label>
		<div class="<%= timezones_search.SearchRightColumnClass %>"><div<%= timezones.ID.CellAttributes %>>
			<span id="el_timezones_ID">
<input type="text" data-field="x_ID" name="x_ID" id="x_ID" placeholder="<%= timezones.ID.PlaceHolder %>" value="<%= timezones.ID.EditValue %>"<%= timezones.ID.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If timezones.Timezone.Visible Then ' Timezone %>
	<div id="r_Timezone" class="form-group">
		<label for="x_Timezone" class="<%= timezones_search.SearchLabelClass %>"><span id="elh_timezones_Timezone"><%= timezones.Timezone.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_Timezone" id="z_Timezone" value="LIKE"></p>
		</label>
		<div class="<%= timezones_search.SearchRightColumnClass %>"><div<%= timezones.Timezone.CellAttributes %>>
			<span id="el_timezones_Timezone">
<input type="text" data-field="x_Timezone" name="x_Timezone" id="x_Timezone" size="30" maxlength="255" placeholder="<%= timezones.Timezone.PlaceHolder %>" value="<%= timezones.Timezone.EditValue %>"<%= timezones.Timezone.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If timezones.offset.Visible Then ' offset %>
	<div id="r_offset" class="form-group">
		<label for="x_offset" class="<%= timezones_search.SearchLabelClass %>"><span id="elh_timezones_offset"><%= timezones.offset.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_offset" id="z_offset" value="LIKE"></p>
		</label>
		<div class="<%= timezones_search.SearchRightColumnClass %>"><div<%= timezones.offset.CellAttributes %>>
			<span id="el_timezones_offset">
<input type="text" data-field="x_offset" name="x_offset" id="x_offset" size="30" maxlength="255" placeholder="<%= timezones.offset.PlaceHolder %>" value="<%= timezones.offset.EditValue %>"<%= timezones.offset.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If timezones.offsetdst.Visible Then ' offsetdst %>
	<div id="r_offsetdst" class="form-group">
		<label for="x_offsetdst" class="<%= timezones_search.SearchLabelClass %>"><span id="elh_timezones_offsetdst"><%= timezones.offsetdst.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_offsetdst" id="z_offsetdst" value="LIKE"></p>
		</label>
		<div class="<%= timezones_search.SearchRightColumnClass %>"><div<%= timezones.offsetdst.CellAttributes %>>
			<span id="el_timezones_offsetdst">
<input type="text" data-field="x_offsetdst" name="x_offsetdst" id="x_offsetdst" size="30" maxlength="255" placeholder="<%= timezones.offsetdst.PlaceHolder %>" value="<%= timezones.offsetdst.EditValue %>"<%= timezones.offsetdst.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
</div>
<% If Not timezones_search.IsModal Then %>
<div class="form-group">
	<div class="col-sm-offset-3 col-sm-9">
<button class="btn btn-primary ewButton" name="btnAction" id="btnAction" type="submit"><%= Language.Phrase("Search") %></button>
<button class="btn btn-default ewButton" name="btnReset" id="btnReset" type="button" onclick="ew_ClearForm(this.form);"><%= Language.Phrase("Reset") %></button>
	</div>
</div>
<% End If %>
</form>
<script type="text/javascript">
ftimezonessearch.Init();
</script>
<%
timezones_search.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set timezones_search = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class ctimezones_search

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
		TableName = "timezones"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "timezones_search"
	End Property

	' Page Name
	Public Property Get PageName()
		PageName = ew_CurrentPage()
	End Property

	' Page Url
	Public Property Get PageUrl()
		PageUrl = ew_CurrentPage() & "?"
		If timezones.UseTokenInUrl Then PageUrl = PageUrl & "t=" & timezones.TableVar & "&" ' add page token
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
		If timezones.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (timezones.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (timezones.TableVar = Request.QueryString("t"))
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
		If IsEmpty(timezones) Then Set timezones = New ctimezones
		Set Table = timezones

		' Initialize urls
		' Initialize form object

		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "search"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "timezones"

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

		timezones.CurrentAction = ew_IIf(Request.QueryString("a").Count > 0, Request.QueryString("a") & "", ObjForm.GetValue("a_list") & "") ' Set up current action
		timezones.ID.Visible = Not timezones.IsAdd() And Not timezones.IsCopy() And Not timezones.IsGridAdd()

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
			results = timezones.GetAutoFill(Request.Form("name"), Request.Form("q"))
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
		If Not timezones Is Nothing Then
			If timezones.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = timezones.TableVar
				If timezones.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf timezones.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf timezones.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf timezones.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set timezones = Nothing
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
			timezones.CurrentAction = ObjForm.GetValue("a_search")
			Select Case timezones.CurrentAction
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
						sSrchStr = timezones.UrlParm(sSrchStr)
						sSrchStr = "timezoneslist.asp" & "?" & sSrchStr
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
		timezones.RowType = EW_ROWTYPE_SEARCH
		Call RenderRow()
	End Sub

	' -----------------------------------------------------------------
	' Build advanced search
	'
	Function BuildAdvancedSearch()
		Dim sSrchUrl
		sSrchUrl = ""
		Call BuildSearchUrl(sSrchUrl, timezones.ID, False) ' ID
		Call BuildSearchUrl(sSrchUrl, timezones.Timezone, False) ' Timezone
		Call BuildSearchUrl(sSrchUrl, timezones.offset, False) ' offset
		Call BuildSearchUrl(sSrchUrl, timezones.offsetdst, False) ' offsetdst
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
		timezones.ID.AdvancedSearch.SearchValue = ObjForm.GetValue("x_ID")
		timezones.ID.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_ID")
		timezones.Timezone.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Timezone")
		timezones.Timezone.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Timezone")
		timezones.offset.AdvancedSearch.SearchValue = ObjForm.GetValue("x_offset")
		timezones.offset.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_offset")
		timezones.offsetdst.AdvancedSearch.SearchValue = ObjForm.GetValue("x_offsetdst")
		timezones.offsetdst.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_offsetdst")
	End Function

	' -----------------------------------------------------------------
	' Render row values based on field settings
	'
	Sub RenderRow()

		' Initialize urls
		' Call Row Rendering event

		Call timezones.Row_Rendering()

		' ---------------------------------------
		'  Common render codes for all row types
		' ---------------------------------------
		' ID
		' Timezone
		' offset
		' offsetdst
		' -----------
		'  View  Row
		' -----------

		If timezones.RowType = EW_ROWTYPE_VIEW Then ' View row

			' ID
			timezones.ID.ViewValue = timezones.ID.CurrentValue
			timezones.ID.ViewCustomAttributes = ""

			' Timezone
			timezones.Timezone.ViewValue = timezones.Timezone.CurrentValue
			timezones.Timezone.ViewCustomAttributes = ""

			' offset
			timezones.offset.ViewValue = timezones.offset.CurrentValue
			timezones.offset.ViewCustomAttributes = ""

			' offsetdst
			timezones.offsetdst.ViewValue = timezones.offsetdst.CurrentValue
			timezones.offsetdst.ViewCustomAttributes = ""

			' View refer script
			' ID

			timezones.ID.LinkCustomAttributes = ""
			timezones.ID.HrefValue = ""
			timezones.ID.TooltipValue = ""

			' Timezone
			timezones.Timezone.LinkCustomAttributes = ""
			timezones.Timezone.HrefValue = ""
			timezones.Timezone.TooltipValue = ""

			' offset
			timezones.offset.LinkCustomAttributes = ""
			timezones.offset.HrefValue = ""
			timezones.offset.TooltipValue = ""

			' offsetdst
			timezones.offsetdst.LinkCustomAttributes = ""
			timezones.offsetdst.HrefValue = ""
			timezones.offsetdst.TooltipValue = ""

		' ------------
		'  Search Row
		' ------------

		ElseIf timezones.RowType = EW_ROWTYPE_SEARCH Then ' Search row

			' ID
			timezones.ID.EditAttrs.UpdateAttribute "class", "form-control"
			timezones.ID.EditCustomAttributes = ""
			timezones.ID.EditValue = ew_HtmlEncode(timezones.ID.AdvancedSearch.SearchValue)
			timezones.ID.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(timezones.ID.FldCaption))

			' Timezone
			timezones.Timezone.EditAttrs.UpdateAttribute "class", "form-control"
			timezones.Timezone.EditCustomAttributes = ""
			timezones.Timezone.EditValue = ew_HtmlEncode(timezones.Timezone.AdvancedSearch.SearchValue)
			timezones.Timezone.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(timezones.Timezone.FldCaption))

			' offset
			timezones.offset.EditAttrs.UpdateAttribute "class", "form-control"
			timezones.offset.EditCustomAttributes = ""
			timezones.offset.EditValue = ew_HtmlEncode(timezones.offset.AdvancedSearch.SearchValue)
			timezones.offset.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(timezones.offset.FldCaption))

			' offsetdst
			timezones.offsetdst.EditAttrs.UpdateAttribute "class", "form-control"
			timezones.offsetdst.EditCustomAttributes = ""
			timezones.offsetdst.EditValue = ew_HtmlEncode(timezones.offsetdst.AdvancedSearch.SearchValue)
			timezones.offsetdst.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(timezones.offsetdst.FldCaption))
		End If
		If timezones.RowType = EW_ROWTYPE_ADD Or timezones.RowType = EW_ROWTYPE_EDIT Or timezones.RowType = EW_ROWTYPE_SEARCH Then ' Add / Edit / Search row
			Call timezones.SetupFieldTitles()
		End If

		' Call Row Rendered event
		If timezones.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call timezones.Row_Rendered()
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
		If Not ew_CheckInteger(timezones.ID.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, timezones.ID.FldErrMsg)
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
		Call timezones.ID.AdvancedSearch.Load()
		Call timezones.Timezone.AdvancedSearch.Load()
		Call timezones.offset.AdvancedSearch.Load()
		Call timezones.offsetdst.AdvancedSearch.Load()
End Function

	' Set up Breadcrumb
	Sub SetupBreadcrumb()
		Dim PageId, url
		Set Breadcrumb = New cBreadcrumb
		url = Mid(ew_CurrentUrl, InStrRev(ew_CurrentUrl, "/")+1)
		Call Breadcrumb.Add("list", timezones.TableVar, "timezoneslist.asp", "", timezones.TableVar, True)
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
