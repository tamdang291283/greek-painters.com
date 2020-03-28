<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="Category_Openning_Timeinfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim Category_Openning_Time_search
Set Category_Openning_Time_search = New cCategory_Openning_Time_search
Set Page = Category_Openning_Time_search

' Page init processing
Category_Openning_Time_search.Page_Init()

' Page main processing
Category_Openning_Time_search.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
Category_Openning_Time_search.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var Category_Openning_Time_search = new ew_Page("Category_Openning_Time_search");
Category_Openning_Time_search.PageID = "search"; // Page ID
var EW_PAGE_ID = Category_Openning_Time_search.PageID; // For backward compatibility
// Form object
var fCategory_Openning_Timesearch = new ew_Form("fCategory_Openning_Timesearch");
// Form_CustomValidate event
fCategory_Openning_Timesearch.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fCategory_Openning_Timesearch.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fCategory_Openning_Timesearch.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
// Validate function for search
fCategory_Openning_Timesearch.Validate = function(fobj) {
	if (!this.ValidateRequired)
		return true; // Ignore validation
	fobj = fobj || this.Form;
	this.PostAutoSuggest();
	var infix = "";
	elm = this.GetElements("x" + infix + "_ID");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(Category_Openning_Time.ID.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_CategoryID");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(Category_Openning_Time.CategoryID.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_IdBusinessDetail");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(Category_Openning_Time.IdBusinessDetail.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_DayValue");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(Category_Openning_Time.DayValue.FldErrMsg) %>");
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
<% If Not Category_Openning_Time_search.IsModal Then %>
<div class="ewToolbar">
<% If Category_Openning_Time.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If Category_Openning_Time.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% End If %>
<% Category_Openning_Time_search.ShowPageHeader() %>
<% Category_Openning_Time_search.ShowMessage %>
<form name="fCategory_Openning_Timesearch" id="fCategory_Openning_Timesearch" class="form-horizontal ewForm ewSearchForm" action="<%= ew_CurrentPage %>" method="post">
<% If Category_Openning_Time_search.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= Category_Openning_Time_search.Token %>">
<% End If %>
<input type="hidden" name="t" value="Category_Openning_Time">
<input type="hidden" name="a_search" id="a_search" value="S">
<% If Category_Openning_Time_search.IsModal Then %>
<input type="hidden" name="modal" value="1">
<% End If %>
<div>
<% If Category_Openning_Time.ID.Visible Then ' ID %>
	<div id="r_ID" class="form-group">
		<label for="x_ID" class="<%= Category_Openning_Time_search.SearchLabelClass %>"><span id="elh_Category_Openning_Time_ID"><%= Category_Openning_Time.ID.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_ID" id="z_ID" value="="></p>
		</label>
		<div class="<%= Category_Openning_Time_search.SearchRightColumnClass %>"><div<%= Category_Openning_Time.ID.CellAttributes %>>
			<span id="el_Category_Openning_Time_ID">
<input type="text" data-field="x_ID" name="x_ID" id="x_ID" placeholder="<%= Category_Openning_Time.ID.PlaceHolder %>" value="<%= Category_Openning_Time.ID.EditValue %>"<%= Category_Openning_Time.ID.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Category_Openning_Time.CategoryID.Visible Then ' CategoryID %>
	<div id="r_CategoryID" class="form-group">
		<label for="x_CategoryID" class="<%= Category_Openning_Time_search.SearchLabelClass %>"><span id="elh_Category_Openning_Time_CategoryID"><%= Category_Openning_Time.CategoryID.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_CategoryID" id="z_CategoryID" value="="></p>
		</label>
		<div class="<%= Category_Openning_Time_search.SearchRightColumnClass %>"><div<%= Category_Openning_Time.CategoryID.CellAttributes %>>
			<span id="el_Category_Openning_Time_CategoryID">
<input type="text" data-field="x_CategoryID" name="x_CategoryID" id="x_CategoryID" size="30" placeholder="<%= Category_Openning_Time.CategoryID.PlaceHolder %>" value="<%= Category_Openning_Time.CategoryID.EditValue %>"<%= Category_Openning_Time.CategoryID.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Category_Openning_Time.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
	<div id="r_IdBusinessDetail" class="form-group">
		<label for="x_IdBusinessDetail" class="<%= Category_Openning_Time_search.SearchLabelClass %>"><span id="elh_Category_Openning_Time_IdBusinessDetail"><%= Category_Openning_Time.IdBusinessDetail.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_IdBusinessDetail" id="z_IdBusinessDetail" value="="></p>
		</label>
		<div class="<%= Category_Openning_Time_search.SearchRightColumnClass %>"><div<%= Category_Openning_Time.IdBusinessDetail.CellAttributes %>>
			<span id="el_Category_Openning_Time_IdBusinessDetail">
<input type="text" data-field="x_IdBusinessDetail" name="x_IdBusinessDetail" id="x_IdBusinessDetail" size="30" placeholder="<%= Category_Openning_Time.IdBusinessDetail.PlaceHolder %>" value="<%= Category_Openning_Time.IdBusinessDetail.EditValue %>"<%= Category_Openning_Time.IdBusinessDetail.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Category_Openning_Time.Hour_From.Visible Then ' Hour_From %>
	<div id="r_Hour_From" class="form-group">
		<label for="x_Hour_From" class="<%= Category_Openning_Time_search.SearchLabelClass %>"><span id="elh_Category_Openning_Time_Hour_From"><%= Category_Openning_Time.Hour_From.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_Hour_From" id="z_Hour_From" value="="></p>
		</label>
		<div class="<%= Category_Openning_Time_search.SearchRightColumnClass %>"><div<%= Category_Openning_Time.Hour_From.CellAttributes %>>
			<span id="el_Category_Openning_Time_Hour_From">
<input type="text" data-field="x_Hour_From" name="x_Hour_From" id="x_Hour_From" size="30" placeholder="<%= Category_Openning_Time.Hour_From.PlaceHolder %>" value="<%= Category_Openning_Time.Hour_From.EditValue %>"<%= Category_Openning_Time.Hour_From.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Category_Openning_Time.Hour_To.Visible Then ' Hour_To %>
	<div id="r_Hour_To" class="form-group">
		<label for="x_Hour_To" class="<%= Category_Openning_Time_search.SearchLabelClass %>"><span id="elh_Category_Openning_Time_Hour_To"><%= Category_Openning_Time.Hour_To.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_Hour_To" id="z_Hour_To" value="="></p>
		</label>
		<div class="<%= Category_Openning_Time_search.SearchRightColumnClass %>"><div<%= Category_Openning_Time.Hour_To.CellAttributes %>>
			<span id="el_Category_Openning_Time_Hour_To">
<input type="text" data-field="x_Hour_To" name="x_Hour_To" id="x_Hour_To" size="30" placeholder="<%= Category_Openning_Time.Hour_To.PlaceHolder %>" value="<%= Category_Openning_Time.Hour_To.EditValue %>"<%= Category_Openning_Time.Hour_To.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Category_Openning_Time.DayValue.Visible Then ' DayValue %>
	<div id="r_DayValue" class="form-group">
		<label for="x_DayValue" class="<%= Category_Openning_Time_search.SearchLabelClass %>"><span id="elh_Category_Openning_Time_DayValue"><%= Category_Openning_Time.DayValue.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_DayValue" id="z_DayValue" value="="></p>
		</label>
		<div class="<%= Category_Openning_Time_search.SearchRightColumnClass %>"><div<%= Category_Openning_Time.DayValue.CellAttributes %>>
			<span id="el_Category_Openning_Time_DayValue">
<input type="text" data-field="x_DayValue" name="x_DayValue" id="x_DayValue" size="30" placeholder="<%= Category_Openning_Time.DayValue.PlaceHolder %>" value="<%= Category_Openning_Time.DayValue.EditValue %>"<%= Category_Openning_Time.DayValue.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Category_Openning_Time.Dayname.Visible Then ' Dayname %>
	<div id="r_Dayname" class="form-group">
		<label for="x_Dayname" class="<%= Category_Openning_Time_search.SearchLabelClass %>"><span id="elh_Category_Openning_Time_Dayname"><%= Category_Openning_Time.Dayname.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_Dayname" id="z_Dayname" value="LIKE"></p>
		</label>
		<div class="<%= Category_Openning_Time_search.SearchRightColumnClass %>"><div<%= Category_Openning_Time.Dayname.CellAttributes %>>
			<span id="el_Category_Openning_Time_Dayname">
<input type="text" data-field="x_Dayname" name="x_Dayname" id="x_Dayname" size="30" maxlength="255" placeholder="<%= Category_Openning_Time.Dayname.PlaceHolder %>" value="<%= Category_Openning_Time.Dayname.EditValue %>"<%= Category_Openning_Time.Dayname.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Category_Openning_Time.status.Visible Then ' status %>
	<div id="r_status" class="form-group">
		<label for="x_status" class="<%= Category_Openning_Time_search.SearchLabelClass %>"><span id="elh_Category_Openning_Time_status"><%= Category_Openning_Time.status.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_status" id="z_status" value="LIKE"></p>
		</label>
		<div class="<%= Category_Openning_Time_search.SearchRightColumnClass %>"><div<%= Category_Openning_Time.status.CellAttributes %>>
			<span id="el_Category_Openning_Time_status">
<input type="text" data-field="x_status" name="x_status" id="x_status" size="30" maxlength="255" placeholder="<%= Category_Openning_Time.status.PlaceHolder %>" value="<%= Category_Openning_Time.status.EditValue %>"<%= Category_Openning_Time.status.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
</div>
<% If Not Category_Openning_Time_search.IsModal Then %>
<div class="form-group">
	<div class="col-sm-offset-3 col-sm-9">
<button class="btn btn-primary ewButton" name="btnAction" id="btnAction" type="submit"><%= Language.Phrase("Search") %></button>
<button class="btn btn-default ewButton" name="btnReset" id="btnReset" type="button" onclick="ew_ClearForm(this.form);"><%= Language.Phrase("Reset") %></button>
	</div>
</div>
<% End If %>
</form>
<script type="text/javascript">
fCategory_Openning_Timesearch.Init();
</script>
<%
Category_Openning_Time_search.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set Category_Openning_Time_search = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cCategory_Openning_Time_search

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
		TableName = "Category_Openning_Time"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "Category_Openning_Time_search"
	End Property

	' Page Name
	Public Property Get PageName()
		PageName = ew_CurrentPage()
	End Property

	' Page Url
	Public Property Get PageUrl()
		PageUrl = ew_CurrentPage() & "?"
		If Category_Openning_Time.UseTokenInUrl Then PageUrl = PageUrl & "t=" & Category_Openning_Time.TableVar & "&" ' add page token
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
		If Category_Openning_Time.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (Category_Openning_Time.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (Category_Openning_Time.TableVar = Request.QueryString("t"))
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
		If IsEmpty(Category_Openning_Time) Then Set Category_Openning_Time = New cCategory_Openning_Time
		Set Table = Category_Openning_Time

		' Initialize urls
		' Initialize form object

		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "search"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "Category_Openning_Time"

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

		Category_Openning_Time.CurrentAction = ew_IIf(Request.QueryString("a").Count > 0, Request.QueryString("a") & "", ObjForm.GetValue("a_list") & "") ' Set up current action
		Category_Openning_Time.ID.Visible = Not Category_Openning_Time.IsAdd() And Not Category_Openning_Time.IsCopy() And Not Category_Openning_Time.IsGridAdd()

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
			results = Category_Openning_Time.GetAutoFill(Request.Form("name"), Request.Form("q"))
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
		If Not Category_Openning_Time Is Nothing Then
			If Category_Openning_Time.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = Category_Openning_Time.TableVar
				If Category_Openning_Time.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf Category_Openning_Time.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf Category_Openning_Time.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf Category_Openning_Time.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set Category_Openning_Time = Nothing
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
			Category_Openning_Time.CurrentAction = ObjForm.GetValue("a_search")
			Select Case Category_Openning_Time.CurrentAction
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
						sSrchStr = Category_Openning_Time.UrlParm(sSrchStr)
						sSrchStr = "Category_Openning_Timelist.asp" & "?" & sSrchStr
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
		Category_Openning_Time.RowType = EW_ROWTYPE_SEARCH
		Call RenderRow()
	End Sub

	' -----------------------------------------------------------------
	' Build advanced search
	'
	Function BuildAdvancedSearch()
		Dim sSrchUrl
		sSrchUrl = ""
		Call BuildSearchUrl(sSrchUrl, Category_Openning_Time.ID, False) ' ID
		Call BuildSearchUrl(sSrchUrl, Category_Openning_Time.CategoryID, False) ' CategoryID
		Call BuildSearchUrl(sSrchUrl, Category_Openning_Time.IdBusinessDetail, False) ' IdBusinessDetail
		Call BuildSearchUrl(sSrchUrl, Category_Openning_Time.Hour_From, False) ' Hour_From
		Call BuildSearchUrl(sSrchUrl, Category_Openning_Time.Hour_To, False) ' Hour_To
		Call BuildSearchUrl(sSrchUrl, Category_Openning_Time.DayValue, False) ' DayValue
		Call BuildSearchUrl(sSrchUrl, Category_Openning_Time.Dayname, False) ' Dayname
		Call BuildSearchUrl(sSrchUrl, Category_Openning_Time.status, False) ' status
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
		Category_Openning_Time.ID.AdvancedSearch.SearchValue = ObjForm.GetValue("x_ID")
		Category_Openning_Time.ID.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_ID")
		Category_Openning_Time.CategoryID.AdvancedSearch.SearchValue = ObjForm.GetValue("x_CategoryID")
		Category_Openning_Time.CategoryID.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_CategoryID")
		Category_Openning_Time.IdBusinessDetail.AdvancedSearch.SearchValue = ObjForm.GetValue("x_IdBusinessDetail")
		Category_Openning_Time.IdBusinessDetail.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_IdBusinessDetail")
		Category_Openning_Time.Hour_From.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Hour_From")
		Category_Openning_Time.Hour_From.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Hour_From")
		Category_Openning_Time.Hour_To.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Hour_To")
		Category_Openning_Time.Hour_To.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Hour_To")
		Category_Openning_Time.DayValue.AdvancedSearch.SearchValue = ObjForm.GetValue("x_DayValue")
		Category_Openning_Time.DayValue.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_DayValue")
		Category_Openning_Time.Dayname.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Dayname")
		Category_Openning_Time.Dayname.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Dayname")
		Category_Openning_Time.status.AdvancedSearch.SearchValue = ObjForm.GetValue("x_status")
		Category_Openning_Time.status.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_status")
	End Function

	' -----------------------------------------------------------------
	' Render row values based on field settings
	'
	Sub RenderRow()

		' Initialize urls
		' Call Row Rendering event

		Call Category_Openning_Time.Row_Rendering()

		' ---------------------------------------
		'  Common render codes for all row types
		' ---------------------------------------
		' ID
		' CategoryID
		' IdBusinessDetail
		' Hour_From
		' Hour_To
		' DayValue
		' Dayname
		' status
		' -----------
		'  View  Row
		' -----------

		If Category_Openning_Time.RowType = EW_ROWTYPE_VIEW Then ' View row

			' ID
			Category_Openning_Time.ID.ViewValue = Category_Openning_Time.ID.CurrentValue
			Category_Openning_Time.ID.ViewCustomAttributes = ""

			' CategoryID
			Category_Openning_Time.CategoryID.ViewValue = Category_Openning_Time.CategoryID.CurrentValue
			Category_Openning_Time.CategoryID.ViewCustomAttributes = ""

			' IdBusinessDetail
			Category_Openning_Time.IdBusinessDetail.ViewValue = Category_Openning_Time.IdBusinessDetail.CurrentValue
			Category_Openning_Time.IdBusinessDetail.ViewCustomAttributes = ""

			' Hour_From
			Category_Openning_Time.Hour_From.ViewValue = Category_Openning_Time.Hour_From.CurrentValue
			Category_Openning_Time.Hour_From.ViewCustomAttributes = ""

			' Hour_To
			Category_Openning_Time.Hour_To.ViewValue = Category_Openning_Time.Hour_To.CurrentValue
			Category_Openning_Time.Hour_To.ViewCustomAttributes = ""

			' DayValue
			Category_Openning_Time.DayValue.ViewValue = Category_Openning_Time.DayValue.CurrentValue
			Category_Openning_Time.DayValue.ViewCustomAttributes = ""

			' Dayname
			Category_Openning_Time.Dayname.ViewValue = Category_Openning_Time.Dayname.CurrentValue
			Category_Openning_Time.Dayname.ViewCustomAttributes = ""

			' status
			Category_Openning_Time.status.ViewValue = Category_Openning_Time.status.CurrentValue
			Category_Openning_Time.status.ViewCustomAttributes = ""

			' View refer script
			' ID

			Category_Openning_Time.ID.LinkCustomAttributes = ""
			Category_Openning_Time.ID.HrefValue = ""
			Category_Openning_Time.ID.TooltipValue = ""

			' CategoryID
			Category_Openning_Time.CategoryID.LinkCustomAttributes = ""
			Category_Openning_Time.CategoryID.HrefValue = ""
			Category_Openning_Time.CategoryID.TooltipValue = ""

			' IdBusinessDetail
			Category_Openning_Time.IdBusinessDetail.LinkCustomAttributes = ""
			Category_Openning_Time.IdBusinessDetail.HrefValue = ""
			Category_Openning_Time.IdBusinessDetail.TooltipValue = ""

			' Hour_From
			Category_Openning_Time.Hour_From.LinkCustomAttributes = ""
			Category_Openning_Time.Hour_From.HrefValue = ""
			Category_Openning_Time.Hour_From.TooltipValue = ""

			' Hour_To
			Category_Openning_Time.Hour_To.LinkCustomAttributes = ""
			Category_Openning_Time.Hour_To.HrefValue = ""
			Category_Openning_Time.Hour_To.TooltipValue = ""

			' DayValue
			Category_Openning_Time.DayValue.LinkCustomAttributes = ""
			Category_Openning_Time.DayValue.HrefValue = ""
			Category_Openning_Time.DayValue.TooltipValue = ""

			' Dayname
			Category_Openning_Time.Dayname.LinkCustomAttributes = ""
			Category_Openning_Time.Dayname.HrefValue = ""
			Category_Openning_Time.Dayname.TooltipValue = ""

			' status
			Category_Openning_Time.status.LinkCustomAttributes = ""
			Category_Openning_Time.status.HrefValue = ""
			Category_Openning_Time.status.TooltipValue = ""

		' ------------
		'  Search Row
		' ------------

		ElseIf Category_Openning_Time.RowType = EW_ROWTYPE_SEARCH Then ' Search row

			' ID
			Category_Openning_Time.ID.EditAttrs.UpdateAttribute "class", "form-control"
			Category_Openning_Time.ID.EditCustomAttributes = ""
			Category_Openning_Time.ID.EditValue = ew_HtmlEncode(Category_Openning_Time.ID.AdvancedSearch.SearchValue)
			Category_Openning_Time.ID.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Category_Openning_Time.ID.FldCaption))

			' CategoryID
			Category_Openning_Time.CategoryID.EditAttrs.UpdateAttribute "class", "form-control"
			Category_Openning_Time.CategoryID.EditCustomAttributes = ""
			Category_Openning_Time.CategoryID.EditValue = ew_HtmlEncode(Category_Openning_Time.CategoryID.AdvancedSearch.SearchValue)
			Category_Openning_Time.CategoryID.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Category_Openning_Time.CategoryID.FldCaption))

			' IdBusinessDetail
			Category_Openning_Time.IdBusinessDetail.EditAttrs.UpdateAttribute "class", "form-control"
			Category_Openning_Time.IdBusinessDetail.EditCustomAttributes = ""
			Category_Openning_Time.IdBusinessDetail.EditValue = ew_HtmlEncode(Category_Openning_Time.IdBusinessDetail.AdvancedSearch.SearchValue)
			Category_Openning_Time.IdBusinessDetail.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Category_Openning_Time.IdBusinessDetail.FldCaption))

			' Hour_From
			Category_Openning_Time.Hour_From.EditAttrs.UpdateAttribute "class", "form-control"
			Category_Openning_Time.Hour_From.EditCustomAttributes = ""
			Category_Openning_Time.Hour_From.EditValue = ew_FormatDateTime(Category_Openning_Time.Hour_From.AdvancedSearch.SearchValue, 99)
			Category_Openning_Time.Hour_From.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Category_Openning_Time.Hour_From.FldCaption))

			' Hour_To
			Category_Openning_Time.Hour_To.EditAttrs.UpdateAttribute "class", "form-control"
			Category_Openning_Time.Hour_To.EditCustomAttributes = ""
			Category_Openning_Time.Hour_To.EditValue = ew_FormatDateTime(Category_Openning_Time.Hour_To.AdvancedSearch.SearchValue, 99)
			Category_Openning_Time.Hour_To.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Category_Openning_Time.Hour_To.FldCaption))

			' DayValue
			Category_Openning_Time.DayValue.EditAttrs.UpdateAttribute "class", "form-control"
			Category_Openning_Time.DayValue.EditCustomAttributes = ""
			Category_Openning_Time.DayValue.EditValue = ew_HtmlEncode(Category_Openning_Time.DayValue.AdvancedSearch.SearchValue)
			Category_Openning_Time.DayValue.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Category_Openning_Time.DayValue.FldCaption))

			' Dayname
			Category_Openning_Time.Dayname.EditAttrs.UpdateAttribute "class", "form-control"
			Category_Openning_Time.Dayname.EditCustomAttributes = ""
			Category_Openning_Time.Dayname.EditValue = ew_HtmlEncode(Category_Openning_Time.Dayname.AdvancedSearch.SearchValue)
			Category_Openning_Time.Dayname.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Category_Openning_Time.Dayname.FldCaption))

			' status
			Category_Openning_Time.status.EditAttrs.UpdateAttribute "class", "form-control"
			Category_Openning_Time.status.EditCustomAttributes = ""
			Category_Openning_Time.status.EditValue = ew_HtmlEncode(Category_Openning_Time.status.AdvancedSearch.SearchValue)
			Category_Openning_Time.status.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Category_Openning_Time.status.FldCaption))
		End If
		If Category_Openning_Time.RowType = EW_ROWTYPE_ADD Or Category_Openning_Time.RowType = EW_ROWTYPE_EDIT Or Category_Openning_Time.RowType = EW_ROWTYPE_SEARCH Then ' Add / Edit / Search row
			Call Category_Openning_Time.SetupFieldTitles()
		End If

		' Call Row Rendered event
		If Category_Openning_Time.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call Category_Openning_Time.Row_Rendered()
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
		If Not ew_CheckInteger(Category_Openning_Time.ID.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, Category_Openning_Time.ID.FldErrMsg)
		End If
		If Not ew_CheckInteger(Category_Openning_Time.CategoryID.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, Category_Openning_Time.CategoryID.FldErrMsg)
		End If
		If Not ew_CheckInteger(Category_Openning_Time.IdBusinessDetail.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, Category_Openning_Time.IdBusinessDetail.FldErrMsg)
		End If
		If Not ew_CheckInteger(Category_Openning_Time.DayValue.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, Category_Openning_Time.DayValue.FldErrMsg)
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
		Call Category_Openning_Time.ID.AdvancedSearch.Load()
		Call Category_Openning_Time.CategoryID.AdvancedSearch.Load()
		Call Category_Openning_Time.IdBusinessDetail.AdvancedSearch.Load()
		Call Category_Openning_Time.Hour_From.AdvancedSearch.Load()
		Call Category_Openning_Time.Hour_To.AdvancedSearch.Load()
		Call Category_Openning_Time.DayValue.AdvancedSearch.Load()
		Call Category_Openning_Time.Dayname.AdvancedSearch.Load()
		Call Category_Openning_Time.status.AdvancedSearch.Load()
End Function

	' Set up Breadcrumb
	Sub SetupBreadcrumb()
		Dim PageId, url
		Set Breadcrumb = New cBreadcrumb
		url = Mid(ew_CurrentUrl, InStrRev(ew_CurrentUrl, "/")+1)
		Call Breadcrumb.Add("list", Category_Openning_Time.TableVar, "Category_Openning_Timelist.asp", "", Category_Openning_Time.TableVar, True)
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
