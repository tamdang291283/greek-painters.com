<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="OpeningTimesinfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim OpeningTimes_search
Set OpeningTimes_search = New cOpeningTimes_search
Set Page = OpeningTimes_search

' Page init processing
OpeningTimes_search.Page_Init()

' Page main processing
OpeningTimes_search.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
OpeningTimes_search.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var OpeningTimes_search = new ew_Page("OpeningTimes_search");
OpeningTimes_search.PageID = "search"; // Page ID
var EW_PAGE_ID = OpeningTimes_search.PageID; // For backward compatibility
// Form object
var fOpeningTimessearch = new ew_Form("fOpeningTimessearch");
// Form_CustomValidate event
fOpeningTimessearch.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fOpeningTimessearch.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fOpeningTimessearch.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
// Validate function for search
fOpeningTimessearch.Validate = function(fobj) {
	if (!this.ValidateRequired)
		return true; // Ignore validation
	fobj = fobj || this.Form;
	this.PostAutoSuggest();
	var infix = "";
	elm = this.GetElements("x" + infix + "_ID");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(OpeningTimes.ID.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_DayOfWeek");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(OpeningTimes.DayOfWeek.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_IdBusinessDetail");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(OpeningTimes.IdBusinessDetail.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_MinAcceptOrderBeforeClose");
	if (elm && !ew_CheckNumber(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(OpeningTimes.MinAcceptOrderBeforeClose.FldErrMsg) %>");
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
<% If Not OpeningTimes_search.IsModal Then %>
<div class="ewToolbar">
<% If OpeningTimes.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If OpeningTimes.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% End If %>
<% OpeningTimes_search.ShowPageHeader() %>
<% OpeningTimes_search.ShowMessage %>
<form name="fOpeningTimessearch" id="fOpeningTimessearch" class="form-horizontal ewForm ewSearchForm" action="<%= ew_CurrentPage %>" method="post">
<% If OpeningTimes_search.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= OpeningTimes_search.Token %>">
<% End If %>
<input type="hidden" name="t" value="OpeningTimes">
<input type="hidden" name="a_search" id="a_search" value="S">
<% If OpeningTimes_search.IsModal Then %>
<input type="hidden" name="modal" value="1">
<% End If %>
<div>
<% If OpeningTimes.ID.Visible Then ' ID %>
	<div id="r_ID" class="form-group">
		<label for="x_ID" class="<%= OpeningTimes_search.SearchLabelClass %>"><span id="elh_OpeningTimes_ID"><%= OpeningTimes.ID.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_ID" id="z_ID" value="="></p>
		</label>
		<div class="<%= OpeningTimes_search.SearchRightColumnClass %>"><div<%= OpeningTimes.ID.CellAttributes %>>
			<span id="el_OpeningTimes_ID">
<input type="text" data-field="x_ID" name="x_ID" id="x_ID" placeholder="<%= OpeningTimes.ID.PlaceHolder %>" value="<%= OpeningTimes.ID.EditValue %>"<%= OpeningTimes.ID.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OpeningTimes.DayOfWeek.Visible Then ' DayOfWeek %>
	<div id="r_DayOfWeek" class="form-group">
		<label for="x_DayOfWeek" class="<%= OpeningTimes_search.SearchLabelClass %>"><span id="elh_OpeningTimes_DayOfWeek"><%= OpeningTimes.DayOfWeek.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_DayOfWeek" id="z_DayOfWeek" value="="></p>
		</label>
		<div class="<%= OpeningTimes_search.SearchRightColumnClass %>"><div<%= OpeningTimes.DayOfWeek.CellAttributes %>>
			<span id="el_OpeningTimes_DayOfWeek">
<input type="text" data-field="x_DayOfWeek" name="x_DayOfWeek" id="x_DayOfWeek" size="30" placeholder="<%= OpeningTimes.DayOfWeek.PlaceHolder %>" value="<%= OpeningTimes.DayOfWeek.EditValue %>"<%= OpeningTimes.DayOfWeek.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OpeningTimes.Hour_From.Visible Then ' Hour_From %>
	<div id="r_Hour_From" class="form-group">
		<label for="x_Hour_From" class="<%= OpeningTimes_search.SearchLabelClass %>"><span id="elh_OpeningTimes_Hour_From"><%= OpeningTimes.Hour_From.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_Hour_From" id="z_Hour_From" value="="></p>
		</label>
		<div class="<%= OpeningTimes_search.SearchRightColumnClass %>"><div<%= OpeningTimes.Hour_From.CellAttributes %>>
			<span id="el_OpeningTimes_Hour_From">
<input type="text" data-field="x_Hour_From" name="x_Hour_From" id="x_Hour_From" size="30" placeholder="<%= OpeningTimes.Hour_From.PlaceHolder %>" value="<%= OpeningTimes.Hour_From.EditValue %>"<%= OpeningTimes.Hour_From.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OpeningTimes.Hour_To.Visible Then ' Hour_To %>
	<div id="r_Hour_To" class="form-group">
		<label for="x_Hour_To" class="<%= OpeningTimes_search.SearchLabelClass %>"><span id="elh_OpeningTimes_Hour_To"><%= OpeningTimes.Hour_To.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_Hour_To" id="z_Hour_To" value="="></p>
		</label>
		<div class="<%= OpeningTimes_search.SearchRightColumnClass %>"><div<%= OpeningTimes.Hour_To.CellAttributes %>>
			<span id="el_OpeningTimes_Hour_To">
<input type="text" data-field="x_Hour_To" name="x_Hour_To" id="x_Hour_To" size="30" placeholder="<%= OpeningTimes.Hour_To.PlaceHolder %>" value="<%= OpeningTimes.Hour_To.EditValue %>"<%= OpeningTimes.Hour_To.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OpeningTimes.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
	<div id="r_IdBusinessDetail" class="form-group">
		<label for="x_IdBusinessDetail" class="<%= OpeningTimes_search.SearchLabelClass %>"><span id="elh_OpeningTimes_IdBusinessDetail"><%= OpeningTimes.IdBusinessDetail.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_IdBusinessDetail" id="z_IdBusinessDetail" value="="></p>
		</label>
		<div class="<%= OpeningTimes_search.SearchRightColumnClass %>"><div<%= OpeningTimes.IdBusinessDetail.CellAttributes %>>
			<span id="el_OpeningTimes_IdBusinessDetail">
<input type="text" data-field="x_IdBusinessDetail" name="x_IdBusinessDetail" id="x_IdBusinessDetail" size="30" placeholder="<%= OpeningTimes.IdBusinessDetail.PlaceHolder %>" value="<%= OpeningTimes.IdBusinessDetail.EditValue %>"<%= OpeningTimes.IdBusinessDetail.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OpeningTimes.delivery.Visible Then ' delivery %>
	<div id="r_delivery" class="form-group">
		<label for="x_delivery" class="<%= OpeningTimes_search.SearchLabelClass %>"><span id="elh_OpeningTimes_delivery"><%= OpeningTimes.delivery.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_delivery" id="z_delivery" value="LIKE"></p>
		</label>
		<div class="<%= OpeningTimes_search.SearchRightColumnClass %>"><div<%= OpeningTimes.delivery.CellAttributes %>>
			<span id="el_OpeningTimes_delivery">
<input type="text" data-field="x_delivery" name="x_delivery" id="x_delivery" size="30" maxlength="255" placeholder="<%= OpeningTimes.delivery.PlaceHolder %>" value="<%= OpeningTimes.delivery.EditValue %>"<%= OpeningTimes.delivery.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OpeningTimes.collection.Visible Then ' collection %>
	<div id="r_collection" class="form-group">
		<label for="x_collection" class="<%= OpeningTimes_search.SearchLabelClass %>"><span id="elh_OpeningTimes_collection"><%= OpeningTimes.collection.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_collection" id="z_collection" value="LIKE"></p>
		</label>
		<div class="<%= OpeningTimes_search.SearchRightColumnClass %>"><div<%= OpeningTimes.collection.CellAttributes %>>
			<span id="el_OpeningTimes_collection">
<input type="text" data-field="x_collection" name="x_collection" id="x_collection" size="30" maxlength="255" placeholder="<%= OpeningTimes.collection.PlaceHolder %>" value="<%= OpeningTimes.collection.EditValue %>"<%= OpeningTimes.collection.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OpeningTimes.MinAcceptOrderBeforeClose.Visible Then ' MinAcceptOrderBeforeClose %>
	<div id="r_MinAcceptOrderBeforeClose" class="form-group">
		<label for="x_MinAcceptOrderBeforeClose" class="<%= OpeningTimes_search.SearchLabelClass %>"><span id="elh_OpeningTimes_MinAcceptOrderBeforeClose"><%= OpeningTimes.MinAcceptOrderBeforeClose.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_MinAcceptOrderBeforeClose" id="z_MinAcceptOrderBeforeClose" value="="></p>
		</label>
		<div class="<%= OpeningTimes_search.SearchRightColumnClass %>"><div<%= OpeningTimes.MinAcceptOrderBeforeClose.CellAttributes %>>
			<span id="el_OpeningTimes_MinAcceptOrderBeforeClose">
<input type="text" data-field="x_MinAcceptOrderBeforeClose" name="x_MinAcceptOrderBeforeClose" id="x_MinAcceptOrderBeforeClose" size="30" placeholder="<%= OpeningTimes.MinAcceptOrderBeforeClose.PlaceHolder %>" value="<%= OpeningTimes.MinAcceptOrderBeforeClose.EditValue %>"<%= OpeningTimes.MinAcceptOrderBeforeClose.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
</div>
<% If Not OpeningTimes_search.IsModal Then %>
<div class="form-group">
	<div class="col-sm-offset-3 col-sm-9">
<button class="btn btn-primary ewButton" name="btnAction" id="btnAction" type="submit"><%= Language.Phrase("Search") %></button>
<button class="btn btn-default ewButton" name="btnReset" id="btnReset" type="button" onclick="ew_ClearForm(this.form);"><%= Language.Phrase("Reset") %></button>
	</div>
</div>
<% End If %>
</form>
<script type="text/javascript">
fOpeningTimessearch.Init();
</script>
<%
OpeningTimes_search.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set OpeningTimes_search = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cOpeningTimes_search

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
		TableName = "OpeningTimes"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "OpeningTimes_search"
	End Property

	' Page Name
	Public Property Get PageName()
		PageName = ew_CurrentPage()
	End Property

	' Page Url
	Public Property Get PageUrl()
		PageUrl = ew_CurrentPage() & "?"
		If OpeningTimes.UseTokenInUrl Then PageUrl = PageUrl & "t=" & OpeningTimes.TableVar & "&" ' add page token
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
		If OpeningTimes.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (OpeningTimes.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (OpeningTimes.TableVar = Request.QueryString("t"))
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
		If IsEmpty(OpeningTimes) Then Set OpeningTimes = New cOpeningTimes
		Set Table = OpeningTimes

		' Initialize urls
		' Initialize form object

		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "search"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "OpeningTimes"

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

		OpeningTimes.CurrentAction = ew_IIf(Request.QueryString("a").Count > 0, Request.QueryString("a") & "", ObjForm.GetValue("a_list") & "") ' Set up current action
		OpeningTimes.ID.Visible = Not OpeningTimes.IsAdd() And Not OpeningTimes.IsCopy() And Not OpeningTimes.IsGridAdd()

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
			results = OpeningTimes.GetAutoFill(Request.Form("name"), Request.Form("q"))
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
		If Not OpeningTimes Is Nothing Then
			If OpeningTimes.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = OpeningTimes.TableVar
				If OpeningTimes.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf OpeningTimes.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf OpeningTimes.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf OpeningTimes.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set OpeningTimes = Nothing
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
			OpeningTimes.CurrentAction = ObjForm.GetValue("a_search")
			Select Case OpeningTimes.CurrentAction
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
						sSrchStr = OpeningTimes.UrlParm(sSrchStr)
						sSrchStr = "OpeningTimeslist.asp" & "?" & sSrchStr
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
		OpeningTimes.RowType = EW_ROWTYPE_SEARCH
		Call RenderRow()
	End Sub

	' -----------------------------------------------------------------
	' Build advanced search
	'
	Function BuildAdvancedSearch()
		Dim sSrchUrl
		sSrchUrl = ""
		Call BuildSearchUrl(sSrchUrl, OpeningTimes.ID, False) ' ID
		Call BuildSearchUrl(sSrchUrl, OpeningTimes.DayOfWeek, False) ' DayOfWeek
		Call BuildSearchUrl(sSrchUrl, OpeningTimes.Hour_From, False) ' Hour_From
		Call BuildSearchUrl(sSrchUrl, OpeningTimes.Hour_To, False) ' Hour_To
		Call BuildSearchUrl(sSrchUrl, OpeningTimes.IdBusinessDetail, False) ' IdBusinessDetail
		Call BuildSearchUrl(sSrchUrl, OpeningTimes.delivery, False) ' delivery
		Call BuildSearchUrl(sSrchUrl, OpeningTimes.collection, False) ' collection
		Call BuildSearchUrl(sSrchUrl, OpeningTimes.MinAcceptOrderBeforeClose, False) ' MinAcceptOrderBeforeClose
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
		OpeningTimes.ID.AdvancedSearch.SearchValue = ObjForm.GetValue("x_ID")
		OpeningTimes.ID.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_ID")
		OpeningTimes.DayOfWeek.AdvancedSearch.SearchValue = ObjForm.GetValue("x_DayOfWeek")
		OpeningTimes.DayOfWeek.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_DayOfWeek")
		OpeningTimes.Hour_From.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Hour_From")
		OpeningTimes.Hour_From.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Hour_From")
		OpeningTimes.Hour_To.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Hour_To")
		OpeningTimes.Hour_To.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Hour_To")
		OpeningTimes.IdBusinessDetail.AdvancedSearch.SearchValue = ObjForm.GetValue("x_IdBusinessDetail")
		OpeningTimes.IdBusinessDetail.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_IdBusinessDetail")
		OpeningTimes.delivery.AdvancedSearch.SearchValue = ObjForm.GetValue("x_delivery")
		OpeningTimes.delivery.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_delivery")
		OpeningTimes.collection.AdvancedSearch.SearchValue = ObjForm.GetValue("x_collection")
		OpeningTimes.collection.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_collection")
		OpeningTimes.MinAcceptOrderBeforeClose.AdvancedSearch.SearchValue = ObjForm.GetValue("x_MinAcceptOrderBeforeClose")
		OpeningTimes.MinAcceptOrderBeforeClose.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_MinAcceptOrderBeforeClose")
	End Function

	' -----------------------------------------------------------------
	' Render row values based on field settings
	'
	Sub RenderRow()

		' Initialize urls
		' Convert decimal values if posted back

		If OpeningTimes.MinAcceptOrderBeforeClose.CurrentValue & "" <> "" Then OpeningTimes.MinAcceptOrderBeforeClose.CurrentValue = ew_Conv(OpeningTimes.MinAcceptOrderBeforeClose.CurrentValue, OpeningTimes.MinAcceptOrderBeforeClose.FldType)
		If OpeningTimes.MinAcceptOrderBeforeClose.FormValue = OpeningTimes.MinAcceptOrderBeforeClose.CurrentValue And IsNumeric(OpeningTimes.MinAcceptOrderBeforeClose.CurrentValue) Then
			OpeningTimes.MinAcceptOrderBeforeClose.CurrentValue = ew_StrToFloat(OpeningTimes.MinAcceptOrderBeforeClose.CurrentValue)
		End If

		' Call Row Rendering event
		Call OpeningTimes.Row_Rendering()

		' ---------------------------------------
		'  Common render codes for all row types
		' ---------------------------------------
		' ID
		' DayOfWeek
		' Hour_From
		' Hour_To
		' IdBusinessDetail
		' delivery
		' collection
		' MinAcceptOrderBeforeClose
		' -----------
		'  View  Row
		' -----------

		If OpeningTimes.RowType = EW_ROWTYPE_VIEW Then ' View row

			' ID
			OpeningTimes.ID.ViewValue = OpeningTimes.ID.CurrentValue
			OpeningTimes.ID.ViewCustomAttributes = ""

			' DayOfWeek
			OpeningTimes.DayOfWeek.ViewValue = OpeningTimes.DayOfWeek.CurrentValue
			OpeningTimes.DayOfWeek.ViewCustomAttributes = ""

			' Hour_From
			OpeningTimes.Hour_From.ViewValue = OpeningTimes.Hour_From.CurrentValue
			OpeningTimes.Hour_From.ViewCustomAttributes = ""

			' Hour_To
			OpeningTimes.Hour_To.ViewValue = OpeningTimes.Hour_To.CurrentValue
			OpeningTimes.Hour_To.ViewCustomAttributes = ""

			' IdBusinessDetail
			OpeningTimes.IdBusinessDetail.ViewValue = OpeningTimes.IdBusinessDetail.CurrentValue
			OpeningTimes.IdBusinessDetail.ViewCustomAttributes = ""

			' delivery
			OpeningTimes.delivery.ViewValue = OpeningTimes.delivery.CurrentValue
			OpeningTimes.delivery.ViewCustomAttributes = ""

			' collection
			OpeningTimes.collection.ViewValue = OpeningTimes.collection.CurrentValue
			OpeningTimes.collection.ViewCustomAttributes = ""

			' MinAcceptOrderBeforeClose
			OpeningTimes.MinAcceptOrderBeforeClose.ViewValue = OpeningTimes.MinAcceptOrderBeforeClose.CurrentValue
			OpeningTimes.MinAcceptOrderBeforeClose.ViewCustomAttributes = ""

			' View refer script
			' ID

			OpeningTimes.ID.LinkCustomAttributes = ""
			OpeningTimes.ID.HrefValue = ""
			OpeningTimes.ID.TooltipValue = ""

			' DayOfWeek
			OpeningTimes.DayOfWeek.LinkCustomAttributes = ""
			OpeningTimes.DayOfWeek.HrefValue = ""
			OpeningTimes.DayOfWeek.TooltipValue = ""

			' Hour_From
			OpeningTimes.Hour_From.LinkCustomAttributes = ""
			OpeningTimes.Hour_From.HrefValue = ""
			OpeningTimes.Hour_From.TooltipValue = ""

			' Hour_To
			OpeningTimes.Hour_To.LinkCustomAttributes = ""
			OpeningTimes.Hour_To.HrefValue = ""
			OpeningTimes.Hour_To.TooltipValue = ""

			' IdBusinessDetail
			OpeningTimes.IdBusinessDetail.LinkCustomAttributes = ""
			OpeningTimes.IdBusinessDetail.HrefValue = ""
			OpeningTimes.IdBusinessDetail.TooltipValue = ""

			' delivery
			OpeningTimes.delivery.LinkCustomAttributes = ""
			OpeningTimes.delivery.HrefValue = ""
			OpeningTimes.delivery.TooltipValue = ""

			' collection
			OpeningTimes.collection.LinkCustomAttributes = ""
			OpeningTimes.collection.HrefValue = ""
			OpeningTimes.collection.TooltipValue = ""

			' MinAcceptOrderBeforeClose
			OpeningTimes.MinAcceptOrderBeforeClose.LinkCustomAttributes = ""
			OpeningTimes.MinAcceptOrderBeforeClose.HrefValue = ""
			OpeningTimes.MinAcceptOrderBeforeClose.TooltipValue = ""

		' ------------
		'  Search Row
		' ------------

		ElseIf OpeningTimes.RowType = EW_ROWTYPE_SEARCH Then ' Search row

			' ID
			OpeningTimes.ID.EditAttrs.UpdateAttribute "class", "form-control"
			OpeningTimes.ID.EditCustomAttributes = ""
			OpeningTimes.ID.EditValue = ew_HtmlEncode(OpeningTimes.ID.AdvancedSearch.SearchValue)
			OpeningTimes.ID.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OpeningTimes.ID.FldCaption))

			' DayOfWeek
			OpeningTimes.DayOfWeek.EditAttrs.UpdateAttribute "class", "form-control"
			OpeningTimes.DayOfWeek.EditCustomAttributes = ""
			OpeningTimes.DayOfWeek.EditValue = ew_HtmlEncode(OpeningTimes.DayOfWeek.AdvancedSearch.SearchValue)
			OpeningTimes.DayOfWeek.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OpeningTimes.DayOfWeek.FldCaption))

			' Hour_From
			OpeningTimes.Hour_From.EditAttrs.UpdateAttribute "class", "form-control"
			OpeningTimes.Hour_From.EditCustomAttributes = ""
			OpeningTimes.Hour_From.EditValue = ew_FormatDateTime(OpeningTimes.Hour_From.AdvancedSearch.SearchValue, 99)
			OpeningTimes.Hour_From.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OpeningTimes.Hour_From.FldCaption))

			' Hour_To
			OpeningTimes.Hour_To.EditAttrs.UpdateAttribute "class", "form-control"
			OpeningTimes.Hour_To.EditCustomAttributes = ""
			OpeningTimes.Hour_To.EditValue = ew_FormatDateTime(OpeningTimes.Hour_To.AdvancedSearch.SearchValue, 99)
			OpeningTimes.Hour_To.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OpeningTimes.Hour_To.FldCaption))

			' IdBusinessDetail
			OpeningTimes.IdBusinessDetail.EditAttrs.UpdateAttribute "class", "form-control"
			OpeningTimes.IdBusinessDetail.EditCustomAttributes = ""
			OpeningTimes.IdBusinessDetail.EditValue = ew_HtmlEncode(OpeningTimes.IdBusinessDetail.AdvancedSearch.SearchValue)
			OpeningTimes.IdBusinessDetail.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OpeningTimes.IdBusinessDetail.FldCaption))

			' delivery
			OpeningTimes.delivery.EditAttrs.UpdateAttribute "class", "form-control"
			OpeningTimes.delivery.EditCustomAttributes = ""
			OpeningTimes.delivery.EditValue = ew_HtmlEncode(OpeningTimes.delivery.AdvancedSearch.SearchValue)
			OpeningTimes.delivery.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OpeningTimes.delivery.FldCaption))

			' collection
			OpeningTimes.collection.EditAttrs.UpdateAttribute "class", "form-control"
			OpeningTimes.collection.EditCustomAttributes = ""
			OpeningTimes.collection.EditValue = ew_HtmlEncode(OpeningTimes.collection.AdvancedSearch.SearchValue)
			OpeningTimes.collection.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OpeningTimes.collection.FldCaption))

			' MinAcceptOrderBeforeClose
			OpeningTimes.MinAcceptOrderBeforeClose.EditAttrs.UpdateAttribute "class", "form-control"
			OpeningTimes.MinAcceptOrderBeforeClose.EditCustomAttributes = ""
			OpeningTimes.MinAcceptOrderBeforeClose.EditValue = ew_HtmlEncode(OpeningTimes.MinAcceptOrderBeforeClose.AdvancedSearch.SearchValue)
			OpeningTimes.MinAcceptOrderBeforeClose.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OpeningTimes.MinAcceptOrderBeforeClose.FldCaption))
		End If
		If OpeningTimes.RowType = EW_ROWTYPE_ADD Or OpeningTimes.RowType = EW_ROWTYPE_EDIT Or OpeningTimes.RowType = EW_ROWTYPE_SEARCH Then ' Add / Edit / Search row
			Call OpeningTimes.SetupFieldTitles()
		End If

		' Call Row Rendered event
		If OpeningTimes.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call OpeningTimes.Row_Rendered()
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
		If Not ew_CheckInteger(OpeningTimes.ID.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, OpeningTimes.ID.FldErrMsg)
		End If
		If Not ew_CheckInteger(OpeningTimes.DayOfWeek.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, OpeningTimes.DayOfWeek.FldErrMsg)
		End If
		If Not ew_CheckInteger(OpeningTimes.IdBusinessDetail.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, OpeningTimes.IdBusinessDetail.FldErrMsg)
		End If
		If Not ew_CheckNumber(OpeningTimes.MinAcceptOrderBeforeClose.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, OpeningTimes.MinAcceptOrderBeforeClose.FldErrMsg)
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
		Call OpeningTimes.ID.AdvancedSearch.Load()
		Call OpeningTimes.DayOfWeek.AdvancedSearch.Load()
		Call OpeningTimes.Hour_From.AdvancedSearch.Load()
		Call OpeningTimes.Hour_To.AdvancedSearch.Load()
		Call OpeningTimes.IdBusinessDetail.AdvancedSearch.Load()
		Call OpeningTimes.delivery.AdvancedSearch.Load()
		Call OpeningTimes.collection.AdvancedSearch.Load()
		Call OpeningTimes.MinAcceptOrderBeforeClose.AdvancedSearch.Load()
End Function

	' Set up Breadcrumb
	Sub SetupBreadcrumb()
		Dim PageId, url
		Set Breadcrumb = New cBreadcrumb
		url = Mid(ew_CurrentUrl, InStrRev(ew_CurrentUrl, "/")+1)
		Call Breadcrumb.Add("list", OpeningTimes.TableVar, "OpeningTimeslist.asp", "", OpeningTimes.TableVar, True)
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
