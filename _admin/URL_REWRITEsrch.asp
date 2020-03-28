<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="URL_REWRITEinfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim URL_REWRITE_search
Set URL_REWRITE_search = New cURL_REWRITE_search
Set Page = URL_REWRITE_search

' Page init processing
URL_REWRITE_search.Page_Init()

' Page main processing
URL_REWRITE_search.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
URL_REWRITE_search.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var URL_REWRITE_search = new ew_Page("URL_REWRITE_search");
URL_REWRITE_search.PageID = "search"; // Page ID
var EW_PAGE_ID = URL_REWRITE_search.PageID; // For backward compatibility
// Form object
var fURL_REWRITEsearch = new ew_Form("fURL_REWRITEsearch");
// Form_CustomValidate event
fURL_REWRITEsearch.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fURL_REWRITEsearch.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fURL_REWRITEsearch.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
// Validate function for search
fURL_REWRITEsearch.Validate = function(fobj) {
	if (!this.ValidateRequired)
		return true; // Ignore validation
	fobj = fobj || this.Form;
	this.PostAutoSuggest();
	var infix = "";
	elm = this.GetElements("x" + infix + "_ID");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(URL_REWRITE.ID.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_RestaurantID");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(URL_REWRITE.RestaurantID.FldErrMsg) %>");
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
<% If Not URL_REWRITE_search.IsModal Then %>
<div class="ewToolbar">
<% If URL_REWRITE.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If URL_REWRITE.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% End If %>
<% URL_REWRITE_search.ShowPageHeader() %>
<% URL_REWRITE_search.ShowMessage %>
<form name="fURL_REWRITEsearch" id="fURL_REWRITEsearch" class="form-horizontal ewForm ewSearchForm" action="<%= ew_CurrentPage %>" method="post">
<% If URL_REWRITE_search.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= URL_REWRITE_search.Token %>">
<% End If %>
<input type="hidden" name="t" value="URL_REWRITE">
<input type="hidden" name="a_search" id="a_search" value="S">
<% If URL_REWRITE_search.IsModal Then %>
<input type="hidden" name="modal" value="1">
<% End If %>
<div>
<% If URL_REWRITE.ID.Visible Then ' ID %>
	<div id="r_ID" class="form-group">
		<label for="x_ID" class="<%= URL_REWRITE_search.SearchLabelClass %>"><span id="elh_URL_REWRITE_ID"><%= URL_REWRITE.ID.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_ID" id="z_ID" value="="></p>
		</label>
		<div class="<%= URL_REWRITE_search.SearchRightColumnClass %>"><div<%= URL_REWRITE.ID.CellAttributes %>>
			<span id="el_URL_REWRITE_ID">
<input type="text" data-field="x_ID" name="x_ID" id="x_ID" placeholder="<%= URL_REWRITE.ID.PlaceHolder %>" value="<%= URL_REWRITE.ID.EditValue %>"<%= URL_REWRITE.ID.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If URL_REWRITE.FromLink.Visible Then ' FromLink %>
	<div id="r_FromLink" class="form-group">
		<label for="x_FromLink" class="<%= URL_REWRITE_search.SearchLabelClass %>"><span id="elh_URL_REWRITE_FromLink"><%= URL_REWRITE.FromLink.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_FromLink" id="z_FromLink" value="LIKE"></p>
		</label>
		<div class="<%= URL_REWRITE_search.SearchRightColumnClass %>"><div<%= URL_REWRITE.FromLink.CellAttributes %>>
			<span id="el_URL_REWRITE_FromLink">
<input type="text" data-field="x_FromLink" name="x_FromLink" id="x_FromLink" size="30" maxlength="255" placeholder="<%= URL_REWRITE.FromLink.PlaceHolder %>" value="<%= URL_REWRITE.FromLink.EditValue %>"<%= URL_REWRITE.FromLink.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If URL_REWRITE.Tolink.Visible Then ' Tolink %>
	<div id="r_Tolink" class="form-group">
		<label for="x_Tolink" class="<%= URL_REWRITE_search.SearchLabelClass %>"><span id="elh_URL_REWRITE_Tolink"><%= URL_REWRITE.Tolink.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_Tolink" id="z_Tolink" value="LIKE"></p>
		</label>
		<div class="<%= URL_REWRITE_search.SearchRightColumnClass %>"><div<%= URL_REWRITE.Tolink.CellAttributes %>>
			<span id="el_URL_REWRITE_Tolink">
<input type="text" data-field="x_Tolink" name="x_Tolink" id="x_Tolink" size="30" maxlength="255" placeholder="<%= URL_REWRITE.Tolink.PlaceHolder %>" value="<%= URL_REWRITE.Tolink.EditValue %>"<%= URL_REWRITE.Tolink.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If URL_REWRITE.RestaurantID.Visible Then ' RestaurantID %>
	<div id="r_RestaurantID" class="form-group">
		<label for="x_RestaurantID" class="<%= URL_REWRITE_search.SearchLabelClass %>"><span id="elh_URL_REWRITE_RestaurantID"><%= URL_REWRITE.RestaurantID.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_RestaurantID" id="z_RestaurantID" value="="></p>
		</label>
		<div class="<%= URL_REWRITE_search.SearchRightColumnClass %>"><div<%= URL_REWRITE.RestaurantID.CellAttributes %>>
			<span id="el_URL_REWRITE_RestaurantID">
<input type="text" data-field="x_RestaurantID" name="x_RestaurantID" id="x_RestaurantID" size="30" placeholder="<%= URL_REWRITE.RestaurantID.PlaceHolder %>" value="<%= URL_REWRITE.RestaurantID.EditValue %>"<%= URL_REWRITE.RestaurantID.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If URL_REWRITE.Status.Visible Then ' Status %>
	<div id="r_Status" class="form-group">
		<label for="x_Status" class="<%= URL_REWRITE_search.SearchLabelClass %>"><span id="elh_URL_REWRITE_Status"><%= URL_REWRITE.Status.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_Status" id="z_Status" value="LIKE"></p>
		</label>
		<div class="<%= URL_REWRITE_search.SearchRightColumnClass %>"><div<%= URL_REWRITE.Status.CellAttributes %>>
			<span id="el_URL_REWRITE_Status">
<input type="text" data-field="x_Status" name="x_Status" id="x_Status" size="30" maxlength="255" placeholder="<%= URL_REWRITE.Status.PlaceHolder %>" value="<%= URL_REWRITE.Status.EditValue %>"<%= URL_REWRITE.Status.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If URL_REWRITE.businessname.Visible Then ' businessname %>
	<div id="r_businessname" class="form-group">
		<label for="x_businessname" class="<%= URL_REWRITE_search.SearchLabelClass %>"><span id="elh_URL_REWRITE_businessname"><%= URL_REWRITE.businessname.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_businessname" id="z_businessname" value="LIKE"></p>
		</label>
		<div class="<%= URL_REWRITE_search.SearchRightColumnClass %>"><div<%= URL_REWRITE.businessname.CellAttributes %>>
			<span id="el_URL_REWRITE_businessname">
<input type="text" data-field="x_businessname" name="x_businessname" id="x_businessname" size="30" maxlength="255" placeholder="<%= URL_REWRITE.businessname.PlaceHolder %>" value="<%= URL_REWRITE.businessname.EditValue %>"<%= URL_REWRITE.businessname.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If URL_REWRITE.postcode.Visible Then ' postcode %>
	<div id="r_postcode" class="form-group">
		<label for="x_postcode" class="<%= URL_REWRITE_search.SearchLabelClass %>"><span id="elh_URL_REWRITE_postcode"><%= URL_REWRITE.postcode.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_postcode" id="z_postcode" value="LIKE"></p>
		</label>
		<div class="<%= URL_REWRITE_search.SearchRightColumnClass %>"><div<%= URL_REWRITE.postcode.CellAttributes %>>
			<span id="el_URL_REWRITE_postcode">
<input type="text" data-field="x_postcode" name="x_postcode" id="x_postcode" size="30" maxlength="255" placeholder="<%= URL_REWRITE.postcode.PlaceHolder %>" value="<%= URL_REWRITE.postcode.EditValue %>"<%= URL_REWRITE.postcode.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If URL_REWRITE.phonenumber.Visible Then ' phonenumber %>
	<div id="r_phonenumber" class="form-group">
		<label for="x_phonenumber" class="<%= URL_REWRITE_search.SearchLabelClass %>"><span id="elh_URL_REWRITE_phonenumber"><%= URL_REWRITE.phonenumber.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_phonenumber" id="z_phonenumber" value="LIKE"></p>
		</label>
		<div class="<%= URL_REWRITE_search.SearchRightColumnClass %>"><div<%= URL_REWRITE.phonenumber.CellAttributes %>>
			<span id="el_URL_REWRITE_phonenumber">
<input type="text" data-field="x_phonenumber" name="x_phonenumber" id="x_phonenumber" size="30" maxlength="255" placeholder="<%= URL_REWRITE.phonenumber.PlaceHolder %>" value="<%= URL_REWRITE.phonenumber.EditValue %>"<%= URL_REWRITE.phonenumber.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
</div>
<% If Not URL_REWRITE_search.IsModal Then %>
<div class="form-group">
	<div class="col-sm-offset-3 col-sm-9">
<button class="btn btn-primary ewButton" name="btnAction" id="btnAction" type="submit"><%= Language.Phrase("Search") %></button>
<button class="btn btn-default ewButton" name="btnReset" id="btnReset" type="button" onclick="ew_ClearForm(this.form);"><%= Language.Phrase("Reset") %></button>
	</div>
</div>
<% End If %>
</form>
<script type="text/javascript">
fURL_REWRITEsearch.Init();
</script>
<%
URL_REWRITE_search.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set URL_REWRITE_search = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cURL_REWRITE_search

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
		TableName = "URL_REWRITE"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "URL_REWRITE_search"
	End Property

	' Page Name
	Public Property Get PageName()
		PageName = ew_CurrentPage()
	End Property

	' Page Url
	Public Property Get PageUrl()
		PageUrl = ew_CurrentPage() & "?"
		If URL_REWRITE.UseTokenInUrl Then PageUrl = PageUrl & "t=" & URL_REWRITE.TableVar & "&" ' add page token
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
		If URL_REWRITE.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (URL_REWRITE.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (URL_REWRITE.TableVar = Request.QueryString("t"))
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
		If IsEmpty(URL_REWRITE) Then Set URL_REWRITE = New cURL_REWRITE
		Set Table = URL_REWRITE

		' Initialize urls
		' Initialize form object

		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "search"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "URL_REWRITE"

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

		URL_REWRITE.CurrentAction = ew_IIf(Request.QueryString("a").Count > 0, Request.QueryString("a") & "", ObjForm.GetValue("a_list") & "") ' Set up current action
		URL_REWRITE.ID.Visible = Not URL_REWRITE.IsAdd() And Not URL_REWRITE.IsCopy() And Not URL_REWRITE.IsGridAdd()

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
			results = URL_REWRITE.GetAutoFill(Request.Form("name"), Request.Form("q"))
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
		If Not URL_REWRITE Is Nothing Then
			If URL_REWRITE.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = URL_REWRITE.TableVar
				If URL_REWRITE.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf URL_REWRITE.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf URL_REWRITE.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf URL_REWRITE.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set URL_REWRITE = Nothing
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
			URL_REWRITE.CurrentAction = ObjForm.GetValue("a_search")
			Select Case URL_REWRITE.CurrentAction
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
						sSrchStr = URL_REWRITE.UrlParm(sSrchStr)
						sSrchStr = "URL_REWRITElist.asp" & "?" & sSrchStr
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
		URL_REWRITE.RowType = EW_ROWTYPE_SEARCH
		Call RenderRow()
	End Sub

	' -----------------------------------------------------------------
	' Build advanced search
	'
	Function BuildAdvancedSearch()
		Dim sSrchUrl
		sSrchUrl = ""
		Call BuildSearchUrl(sSrchUrl, URL_REWRITE.ID, False) ' ID
		Call BuildSearchUrl(sSrchUrl, URL_REWRITE.FromLink, False) ' FromLink
		Call BuildSearchUrl(sSrchUrl, URL_REWRITE.Tolink, False) ' Tolink
		Call BuildSearchUrl(sSrchUrl, URL_REWRITE.RestaurantID, False) ' RestaurantID
		Call BuildSearchUrl(sSrchUrl, URL_REWRITE.Status, False) ' Status
		Call BuildSearchUrl(sSrchUrl, URL_REWRITE.businessname, False) ' businessname
		Call BuildSearchUrl(sSrchUrl, URL_REWRITE.postcode, False) ' postcode
		Call BuildSearchUrl(sSrchUrl, URL_REWRITE.phonenumber, False) ' phonenumber
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
		URL_REWRITE.ID.AdvancedSearch.SearchValue = ObjForm.GetValue("x_ID")
		URL_REWRITE.ID.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_ID")
		URL_REWRITE.FromLink.AdvancedSearch.SearchValue = ObjForm.GetValue("x_FromLink")
		URL_REWRITE.FromLink.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_FromLink")
		URL_REWRITE.Tolink.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Tolink")
		URL_REWRITE.Tolink.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Tolink")
		URL_REWRITE.RestaurantID.AdvancedSearch.SearchValue = ObjForm.GetValue("x_RestaurantID")
		URL_REWRITE.RestaurantID.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_RestaurantID")
		URL_REWRITE.Status.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Status")
		URL_REWRITE.Status.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Status")
		URL_REWRITE.businessname.AdvancedSearch.SearchValue = ObjForm.GetValue("x_businessname")
		URL_REWRITE.businessname.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_businessname")
		URL_REWRITE.postcode.AdvancedSearch.SearchValue = ObjForm.GetValue("x_postcode")
		URL_REWRITE.postcode.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_postcode")
		URL_REWRITE.phonenumber.AdvancedSearch.SearchValue = ObjForm.GetValue("x_phonenumber")
		URL_REWRITE.phonenumber.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_phonenumber")
	End Function

	' -----------------------------------------------------------------
	' Render row values based on field settings
	'
	Sub RenderRow()

		' Initialize urls
		' Call Row Rendering event

		Call URL_REWRITE.Row_Rendering()

		' ---------------------------------------
		'  Common render codes for all row types
		' ---------------------------------------
		' ID
		' FromLink
		' Tolink
		' RestaurantID
		' Status
		' businessname
		' postcode
		' phonenumber
		' -----------
		'  View  Row
		' -----------

		If URL_REWRITE.RowType = EW_ROWTYPE_VIEW Then ' View row

			' ID
			URL_REWRITE.ID.ViewValue = URL_REWRITE.ID.CurrentValue
			URL_REWRITE.ID.ViewCustomAttributes = ""

			' FromLink
			URL_REWRITE.FromLink.ViewValue = URL_REWRITE.FromLink.CurrentValue
			URL_REWRITE.FromLink.ViewCustomAttributes = ""

			' Tolink
			URL_REWRITE.Tolink.ViewValue = URL_REWRITE.Tolink.CurrentValue
			URL_REWRITE.Tolink.ViewCustomAttributes = ""

			' RestaurantID
			URL_REWRITE.RestaurantID.ViewValue = URL_REWRITE.RestaurantID.CurrentValue
			URL_REWRITE.RestaurantID.ViewCustomAttributes = ""

			' Status
			URL_REWRITE.Status.ViewValue = URL_REWRITE.Status.CurrentValue
			URL_REWRITE.Status.ViewCustomAttributes = ""

			' businessname
			URL_REWRITE.businessname.ViewValue = URL_REWRITE.businessname.CurrentValue
			URL_REWRITE.businessname.ViewCustomAttributes = ""

			' postcode
			URL_REWRITE.postcode.ViewValue = URL_REWRITE.postcode.CurrentValue
			URL_REWRITE.postcode.ViewCustomAttributes = ""

			' phonenumber
			URL_REWRITE.phonenumber.ViewValue = URL_REWRITE.phonenumber.CurrentValue
			URL_REWRITE.phonenumber.ViewCustomAttributes = ""

			' View refer script
			' ID

			URL_REWRITE.ID.LinkCustomAttributes = ""
			URL_REWRITE.ID.HrefValue = ""
			URL_REWRITE.ID.TooltipValue = ""

			' FromLink
			URL_REWRITE.FromLink.LinkCustomAttributes = ""
			URL_REWRITE.FromLink.HrefValue = ""
			URL_REWRITE.FromLink.TooltipValue = ""

			' Tolink
			URL_REWRITE.Tolink.LinkCustomAttributes = ""
			URL_REWRITE.Tolink.HrefValue = ""
			URL_REWRITE.Tolink.TooltipValue = ""

			' RestaurantID
			URL_REWRITE.RestaurantID.LinkCustomAttributes = ""
			URL_REWRITE.RestaurantID.HrefValue = ""
			URL_REWRITE.RestaurantID.TooltipValue = ""

			' Status
			URL_REWRITE.Status.LinkCustomAttributes = ""
			URL_REWRITE.Status.HrefValue = ""
			URL_REWRITE.Status.TooltipValue = ""

			' businessname
			URL_REWRITE.businessname.LinkCustomAttributes = ""
			URL_REWRITE.businessname.HrefValue = ""
			URL_REWRITE.businessname.TooltipValue = ""

			' postcode
			URL_REWRITE.postcode.LinkCustomAttributes = ""
			URL_REWRITE.postcode.HrefValue = ""
			URL_REWRITE.postcode.TooltipValue = ""

			' phonenumber
			URL_REWRITE.phonenumber.LinkCustomAttributes = ""
			URL_REWRITE.phonenumber.HrefValue = ""
			URL_REWRITE.phonenumber.TooltipValue = ""

		' ------------
		'  Search Row
		' ------------

		ElseIf URL_REWRITE.RowType = EW_ROWTYPE_SEARCH Then ' Search row

			' ID
			URL_REWRITE.ID.EditAttrs.UpdateAttribute "class", "form-control"
			URL_REWRITE.ID.EditCustomAttributes = ""
			URL_REWRITE.ID.EditValue = ew_HtmlEncode(URL_REWRITE.ID.AdvancedSearch.SearchValue)
			URL_REWRITE.ID.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(URL_REWRITE.ID.FldCaption))

			' FromLink
			URL_REWRITE.FromLink.EditAttrs.UpdateAttribute "class", "form-control"
			URL_REWRITE.FromLink.EditCustomAttributes = ""
			URL_REWRITE.FromLink.EditValue = ew_HtmlEncode(URL_REWRITE.FromLink.AdvancedSearch.SearchValue)
			URL_REWRITE.FromLink.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(URL_REWRITE.FromLink.FldCaption))

			' Tolink
			URL_REWRITE.Tolink.EditAttrs.UpdateAttribute "class", "form-control"
			URL_REWRITE.Tolink.EditCustomAttributes = ""
			URL_REWRITE.Tolink.EditValue = ew_HtmlEncode(URL_REWRITE.Tolink.AdvancedSearch.SearchValue)
			URL_REWRITE.Tolink.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(URL_REWRITE.Tolink.FldCaption))

			' RestaurantID
			URL_REWRITE.RestaurantID.EditAttrs.UpdateAttribute "class", "form-control"
			URL_REWRITE.RestaurantID.EditCustomAttributes = ""
			URL_REWRITE.RestaurantID.EditValue = ew_HtmlEncode(URL_REWRITE.RestaurantID.AdvancedSearch.SearchValue)
			URL_REWRITE.RestaurantID.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(URL_REWRITE.RestaurantID.FldCaption))

			' Status
			URL_REWRITE.Status.EditAttrs.UpdateAttribute "class", "form-control"
			URL_REWRITE.Status.EditCustomAttributes = ""
			URL_REWRITE.Status.EditValue = ew_HtmlEncode(URL_REWRITE.Status.AdvancedSearch.SearchValue)
			URL_REWRITE.Status.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(URL_REWRITE.Status.FldCaption))

			' businessname
			URL_REWRITE.businessname.EditAttrs.UpdateAttribute "class", "form-control"
			URL_REWRITE.businessname.EditCustomAttributes = ""
			URL_REWRITE.businessname.EditValue = ew_HtmlEncode(URL_REWRITE.businessname.AdvancedSearch.SearchValue)
			URL_REWRITE.businessname.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(URL_REWRITE.businessname.FldCaption))

			' postcode
			URL_REWRITE.postcode.EditAttrs.UpdateAttribute "class", "form-control"
			URL_REWRITE.postcode.EditCustomAttributes = ""
			URL_REWRITE.postcode.EditValue = ew_HtmlEncode(URL_REWRITE.postcode.AdvancedSearch.SearchValue)
			URL_REWRITE.postcode.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(URL_REWRITE.postcode.FldCaption))

			' phonenumber
			URL_REWRITE.phonenumber.EditAttrs.UpdateAttribute "class", "form-control"
			URL_REWRITE.phonenumber.EditCustomAttributes = ""
			URL_REWRITE.phonenumber.EditValue = ew_HtmlEncode(URL_REWRITE.phonenumber.AdvancedSearch.SearchValue)
			URL_REWRITE.phonenumber.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(URL_REWRITE.phonenumber.FldCaption))
		End If
		If URL_REWRITE.RowType = EW_ROWTYPE_ADD Or URL_REWRITE.RowType = EW_ROWTYPE_EDIT Or URL_REWRITE.RowType = EW_ROWTYPE_SEARCH Then ' Add / Edit / Search row
			Call URL_REWRITE.SetupFieldTitles()
		End If

		' Call Row Rendered event
		If URL_REWRITE.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call URL_REWRITE.Row_Rendered()
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
		If Not ew_CheckInteger(URL_REWRITE.ID.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, URL_REWRITE.ID.FldErrMsg)
		End If
		If Not ew_CheckInteger(URL_REWRITE.RestaurantID.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, URL_REWRITE.RestaurantID.FldErrMsg)
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
		Call URL_REWRITE.ID.AdvancedSearch.Load()
		Call URL_REWRITE.FromLink.AdvancedSearch.Load()
		Call URL_REWRITE.Tolink.AdvancedSearch.Load()
		Call URL_REWRITE.RestaurantID.AdvancedSearch.Load()
		Call URL_REWRITE.Status.AdvancedSearch.Load()
		Call URL_REWRITE.businessname.AdvancedSearch.Load()
		Call URL_REWRITE.postcode.AdvancedSearch.Load()
		Call URL_REWRITE.phonenumber.AdvancedSearch.Load()
End Function

	' Set up Breadcrumb
	Sub SetupBreadcrumb()
		Dim PageId, url
		Set Breadcrumb = New cBreadcrumb
		url = Mid(ew_CurrentUrl, InStrRev(ew_CurrentUrl, "/")+1)
		Call Breadcrumb.Add("list", URL_REWRITE.TableVar, "URL_REWRITElist.asp", "", URL_REWRITE.TableVar, True)
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
