<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="sysadmininfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim sysadmin_search
Set sysadmin_search = New csysadmin_search
Set Page = sysadmin_search

' Page init processing
sysadmin_search.Page_Init()

' Page main processing
sysadmin_search.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
sysadmin_search.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var sysadmin_search = new ew_Page("sysadmin_search");
sysadmin_search.PageID = "search"; // Page ID
var EW_PAGE_ID = sysadmin_search.PageID; // For backward compatibility
// Form object
var fsysadminsearch = new ew_Form("fsysadminsearch");
// Form_CustomValidate event
fsysadminsearch.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fsysadminsearch.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fsysadminsearch.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
// Validate function for search
fsysadminsearch.Validate = function(fobj) {
	if (!this.ValidateRequired)
		return true; // Ignore validation
	fobj = fobj || this.Form;
	this.PostAutoSuggest();
	var infix = "";
	elm = this.GetElements("x" + infix + "_ID");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(sysadmin.ID.FldErrMsg) %>");
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
<% If Not sysadmin_search.IsModal Then %>
<div class="ewToolbar">
<% If sysadmin.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If sysadmin.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% End If %>
<% sysadmin_search.ShowPageHeader() %>
<% sysadmin_search.ShowMessage %>
<form name="fsysadminsearch" id="fsysadminsearch" class="form-horizontal ewForm ewSearchForm" action="<%= ew_CurrentPage %>" method="post">
<% If sysadmin_search.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= sysadmin_search.Token %>">
<% End If %>
<input type="hidden" name="t" value="sysadmin">
<input type="hidden" name="a_search" id="a_search" value="S">
<% If sysadmin_search.IsModal Then %>
<input type="hidden" name="modal" value="1">
<% End If %>
<div>
<% If sysadmin.ID.Visible Then ' ID %>
	<div id="r_ID" class="form-group">
		<label for="x_ID" class="<%= sysadmin_search.SearchLabelClass %>"><span id="elh_sysadmin_ID"><%= sysadmin.ID.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_ID" id="z_ID" value="="></p>
		</label>
		<div class="<%= sysadmin_search.SearchRightColumnClass %>"><div<%= sysadmin.ID.CellAttributes %>>
			<span id="el_sysadmin_ID">
<input type="text" data-field="x_ID" name="x_ID" id="x_ID" placeholder="<%= sysadmin.ID.PlaceHolder %>" value="<%= sysadmin.ID.EditValue %>"<%= sysadmin.ID.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If sysadmin.username.Visible Then ' username %>
	<div id="r_username" class="form-group">
		<label for="x_username" class="<%= sysadmin_search.SearchLabelClass %>"><span id="elh_sysadmin_username"><%= sysadmin.username.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_username" id="z_username" value="LIKE"></p>
		</label>
		<div class="<%= sysadmin_search.SearchRightColumnClass %>"><div<%= sysadmin.username.CellAttributes %>>
			<span id="el_sysadmin_username">
<input type="text" data-field="x_username" name="x_username" id="x_username" size="30" maxlength="255" placeholder="<%= sysadmin.username.PlaceHolder %>" value="<%= sysadmin.username.EditValue %>"<%= sysadmin.username.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If sysadmin.pswd.Visible Then ' pswd %>
	<div id="r_pswd" class="form-group">
		<label for="x_pswd" class="<%= sysadmin_search.SearchLabelClass %>"><span id="elh_sysadmin_pswd"><%= sysadmin.pswd.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_pswd" id="z_pswd" value="LIKE"></p>
		</label>
		<div class="<%= sysadmin_search.SearchRightColumnClass %>"><div<%= sysadmin.pswd.CellAttributes %>>
			<span id="el_sysadmin_pswd">
<input type="text" data-field="x_pswd" name="x_pswd" id="x_pswd" size="30" maxlength="255" placeholder="<%= sysadmin.pswd.PlaceHolder %>" value="<%= sysadmin.pswd.EditValue %>"<%= sysadmin.pswd.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If sysadmin.userrolelabel.Visible Then ' userrolelabel %>
	<div id="r_userrolelabel" class="form-group">
		<label for="x_userrolelabel" class="<%= sysadmin_search.SearchLabelClass %>"><span id="elh_sysadmin_userrolelabel"><%= sysadmin.userrolelabel.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_userrolelabel" id="z_userrolelabel" value="LIKE"></p>
		</label>
		<div class="<%= sysadmin_search.SearchRightColumnClass %>"><div<%= sysadmin.userrolelabel.CellAttributes %>>
			<span id="el_sysadmin_userrolelabel">
<input type="text" data-field="x_userrolelabel" name="x_userrolelabel" id="x_userrolelabel" size="30" maxlength="255" placeholder="<%= sysadmin.userrolelabel.PlaceHolder %>" value="<%= sysadmin.userrolelabel.EditValue %>"<%= sysadmin.userrolelabel.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If sysadmin.userrole.Visible Then ' userrole %>
	<div id="r_userrole" class="form-group">
		<label for="x_userrole" class="<%= sysadmin_search.SearchLabelClass %>"><span id="elh_sysadmin_userrole"><%= sysadmin.userrole.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_userrole" id="z_userrole" value="LIKE"></p>
		</label>
		<div class="<%= sysadmin_search.SearchRightColumnClass %>"><div<%= sysadmin.userrole.CellAttributes %>>
			<span id="el_sysadmin_userrole">
<input type="text" data-field="x_userrole" name="x_userrole" id="x_userrole" size="30" maxlength="255" placeholder="<%= sysadmin.userrole.PlaceHolder %>" value="<%= sysadmin.userrole.EditValue %>"<%= sysadmin.userrole.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
</div>
<% If Not sysadmin_search.IsModal Then %>
<div class="form-group">
	<div class="col-sm-offset-3 col-sm-9">
<button class="btn btn-primary ewButton" name="btnAction" id="btnAction" type="submit"><%= Language.Phrase("Search") %></button>
<button class="btn btn-default ewButton" name="btnReset" id="btnReset" type="button" onclick="ew_ClearForm(this.form);"><%= Language.Phrase("Reset") %></button>
	</div>
</div>
<% End If %>
</form>
<script type="text/javascript">
fsysadminsearch.Init();
</script>
<%
sysadmin_search.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set sysadmin_search = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class csysadmin_search

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
		TableName = "sysadmin"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "sysadmin_search"
	End Property

	' Page Name
	Public Property Get PageName()
		PageName = ew_CurrentPage()
	End Property

	' Page Url
	Public Property Get PageUrl()
		PageUrl = ew_CurrentPage() & "?"
		If sysadmin.UseTokenInUrl Then PageUrl = PageUrl & "t=" & sysadmin.TableVar & "&" ' add page token
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
		If sysadmin.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (sysadmin.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (sysadmin.TableVar = Request.QueryString("t"))
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
		If IsEmpty(sysadmin) Then Set sysadmin = New csysadmin
		Set Table = sysadmin

		' Initialize urls
		' Initialize form object

		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "search"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "sysadmin"

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

		sysadmin.CurrentAction = ew_IIf(Request.QueryString("a").Count > 0, Request.QueryString("a") & "", ObjForm.GetValue("a_list") & "") ' Set up current action
		sysadmin.ID.Visible = Not sysadmin.IsAdd() And Not sysadmin.IsCopy() And Not sysadmin.IsGridAdd()

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
			results = sysadmin.GetAutoFill(Request.Form("name"), Request.Form("q"))
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
		If Not sysadmin Is Nothing Then
			If sysadmin.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = sysadmin.TableVar
				If sysadmin.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf sysadmin.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf sysadmin.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf sysadmin.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set sysadmin = Nothing
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
			sysadmin.CurrentAction = ObjForm.GetValue("a_search")
			Select Case sysadmin.CurrentAction
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
						sSrchStr = sysadmin.UrlParm(sSrchStr)
						sSrchStr = "sysadminlist.asp" & "?" & sSrchStr
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
		sysadmin.RowType = EW_ROWTYPE_SEARCH
		Call RenderRow()
	End Sub

	' -----------------------------------------------------------------
	' Build advanced search
	'
	Function BuildAdvancedSearch()
		Dim sSrchUrl
		sSrchUrl = ""
		Call BuildSearchUrl(sSrchUrl, sysadmin.ID, False) ' ID
		Call BuildSearchUrl(sSrchUrl, sysadmin.username, False) ' username
		Call BuildSearchUrl(sSrchUrl, sysadmin.pswd, False) ' pswd
		Call BuildSearchUrl(sSrchUrl, sysadmin.userrolelabel, False) ' userrolelabel
		Call BuildSearchUrl(sSrchUrl, sysadmin.userrole, False) ' userrole
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
		sysadmin.ID.AdvancedSearch.SearchValue = ObjForm.GetValue("x_ID")
		sysadmin.ID.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_ID")
		sysadmin.username.AdvancedSearch.SearchValue = ObjForm.GetValue("x_username")
		sysadmin.username.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_username")
		sysadmin.pswd.AdvancedSearch.SearchValue = ObjForm.GetValue("x_pswd")
		sysadmin.pswd.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_pswd")
		sysadmin.userrolelabel.AdvancedSearch.SearchValue = ObjForm.GetValue("x_userrolelabel")
		sysadmin.userrolelabel.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_userrolelabel")
		sysadmin.userrole.AdvancedSearch.SearchValue = ObjForm.GetValue("x_userrole")
		sysadmin.userrole.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_userrole")
	End Function

	' -----------------------------------------------------------------
	' Render row values based on field settings
	'
	Sub RenderRow()

		' Initialize urls
		' Call Row Rendering event

		Call sysadmin.Row_Rendering()

		' ---------------------------------------
		'  Common render codes for all row types
		' ---------------------------------------
		' ID
		' username
		' pswd
		' userrolelabel
		' userrole
		' -----------
		'  View  Row
		' -----------

		If sysadmin.RowType = EW_ROWTYPE_VIEW Then ' View row

			' ID
			sysadmin.ID.ViewValue = sysadmin.ID.CurrentValue
			sysadmin.ID.ViewCustomAttributes = ""

			' username
			sysadmin.username.ViewValue = sysadmin.username.CurrentValue
			sysadmin.username.ViewCustomAttributes = ""

			' pswd
			sysadmin.pswd.ViewValue = sysadmin.pswd.CurrentValue
			sysadmin.pswd.ViewCustomAttributes = ""

			' userrolelabel
			sysadmin.userrolelabel.ViewValue = sysadmin.userrolelabel.CurrentValue
			sysadmin.userrolelabel.ViewCustomAttributes = ""

			' userrole
			sysadmin.userrole.ViewValue = sysadmin.userrole.CurrentValue
			sysadmin.userrole.ViewCustomAttributes = ""

			' View refer script
			' ID

			sysadmin.ID.LinkCustomAttributes = ""
			sysadmin.ID.HrefValue = ""
			sysadmin.ID.TooltipValue = ""

			' username
			sysadmin.username.LinkCustomAttributes = ""
			sysadmin.username.HrefValue = ""
			sysadmin.username.TooltipValue = ""

			' pswd
			sysadmin.pswd.LinkCustomAttributes = ""
			sysadmin.pswd.HrefValue = ""
			sysadmin.pswd.TooltipValue = ""

			' userrolelabel
			sysadmin.userrolelabel.LinkCustomAttributes = ""
			sysadmin.userrolelabel.HrefValue = ""
			sysadmin.userrolelabel.TooltipValue = ""

			' userrole
			sysadmin.userrole.LinkCustomAttributes = ""
			sysadmin.userrole.HrefValue = ""
			sysadmin.userrole.TooltipValue = ""

		' ------------
		'  Search Row
		' ------------

		ElseIf sysadmin.RowType = EW_ROWTYPE_SEARCH Then ' Search row

			' ID
			sysadmin.ID.EditAttrs.UpdateAttribute "class", "form-control"
			sysadmin.ID.EditCustomAttributes = ""
			sysadmin.ID.EditValue = ew_HtmlEncode(sysadmin.ID.AdvancedSearch.SearchValue)
			sysadmin.ID.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(sysadmin.ID.FldCaption))

			' username
			sysadmin.username.EditAttrs.UpdateAttribute "class", "form-control"
			sysadmin.username.EditCustomAttributes = ""
			sysadmin.username.EditValue = ew_HtmlEncode(sysadmin.username.AdvancedSearch.SearchValue)
			sysadmin.username.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(sysadmin.username.FldCaption))

			' pswd
			sysadmin.pswd.EditAttrs.UpdateAttribute "class", "form-control"
			sysadmin.pswd.EditCustomAttributes = ""
			sysadmin.pswd.EditValue = ew_HtmlEncode(sysadmin.pswd.AdvancedSearch.SearchValue)
			sysadmin.pswd.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(sysadmin.pswd.FldCaption))

			' userrolelabel
			sysadmin.userrolelabel.EditAttrs.UpdateAttribute "class", "form-control"
			sysadmin.userrolelabel.EditCustomAttributes = ""
			sysadmin.userrolelabel.EditValue = ew_HtmlEncode(sysadmin.userrolelabel.AdvancedSearch.SearchValue)
			sysadmin.userrolelabel.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(sysadmin.userrolelabel.FldCaption))

			' userrole
			sysadmin.userrole.EditAttrs.UpdateAttribute "class", "form-control"
			sysadmin.userrole.EditCustomAttributes = ""
			sysadmin.userrole.EditValue = ew_HtmlEncode(sysadmin.userrole.AdvancedSearch.SearchValue)
			sysadmin.userrole.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(sysadmin.userrole.FldCaption))
		End If
		If sysadmin.RowType = EW_ROWTYPE_ADD Or sysadmin.RowType = EW_ROWTYPE_EDIT Or sysadmin.RowType = EW_ROWTYPE_SEARCH Then ' Add / Edit / Search row
			Call sysadmin.SetupFieldTitles()
		End If

		' Call Row Rendered event
		If sysadmin.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call sysadmin.Row_Rendered()
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
		If Not ew_CheckInteger(sysadmin.ID.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, sysadmin.ID.FldErrMsg)
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
		Call sysadmin.ID.AdvancedSearch.Load()
		Call sysadmin.username.AdvancedSearch.Load()
		Call sysadmin.pswd.AdvancedSearch.Load()
		Call sysadmin.userrolelabel.AdvancedSearch.Load()
		Call sysadmin.userrole.AdvancedSearch.Load()
End Function

	' Set up Breadcrumb
	Sub SetupBreadcrumb()
		Dim PageId, url
		Set Breadcrumb = New cBreadcrumb
		url = Mid(ew_CurrentUrl, InStrRev(ew_CurrentUrl, "/")+1)
		Call Breadcrumb.Add("list", sysadmin.TableVar, "sysadminlist.asp", "", sysadmin.TableVar, True)
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
