<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="SMSEmailQueueinfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim SMSEmailQueue_search
Set SMSEmailQueue_search = New cSMSEmailQueue_search
Set Page = SMSEmailQueue_search

' Page init processing
SMSEmailQueue_search.Page_Init()

' Page main processing
SMSEmailQueue_search.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
SMSEmailQueue_search.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var SMSEmailQueue_search = new ew_Page("SMSEmailQueue_search");
SMSEmailQueue_search.PageID = "search"; // Page ID
var EW_PAGE_ID = SMSEmailQueue_search.PageID; // For backward compatibility
// Form object
var fSMSEmailQueuesearch = new ew_Form("fSMSEmailQueuesearch");
// Form_CustomValidate event
fSMSEmailQueuesearch.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fSMSEmailQueuesearch.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fSMSEmailQueuesearch.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
// Validate function for search
fSMSEmailQueuesearch.Validate = function(fobj) {
	if (!this.ValidateRequired)
		return true; // Ignore validation
	fobj = fobj || this.Form;
	this.PostAutoSuggest();
	var infix = "";
	elm = this.GetElements("x" + infix + "_ID");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(SMSEmailQueue.ID.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_SendTime");
	if (elm && !ew_CheckDate(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(SMSEmailQueue.SendTime.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_IsSent");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(SMSEmailQueue.IsSent.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_PlanSendDate");
	if (elm && !ew_CheckDate(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(SMSEmailQueue.PlanSendDate.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_BusinessDetailID");
	if (elm && !ew_CheckNumber(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(SMSEmailQueue.BusinessDetailID.FldErrMsg) %>");
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
<% If Not SMSEmailQueue_search.IsModal Then %>
<div class="ewToolbar">
<% If SMSEmailQueue.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If SMSEmailQueue.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% End If %>
<% SMSEmailQueue_search.ShowPageHeader() %>
<% SMSEmailQueue_search.ShowMessage %>
<form name="fSMSEmailQueuesearch" id="fSMSEmailQueuesearch" class="form-horizontal ewForm ewSearchForm" action="<%= ew_CurrentPage %>" method="post">
<% If SMSEmailQueue_search.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= SMSEmailQueue_search.Token %>">
<% End If %>
<input type="hidden" name="t" value="SMSEmailQueue">
<input type="hidden" name="a_search" id="a_search" value="S">
<% If SMSEmailQueue_search.IsModal Then %>
<input type="hidden" name="modal" value="1">
<% End If %>
<div>
<% If SMSEmailQueue.ID.Visible Then ' ID %>
	<div id="r_ID" class="form-group">
		<label for="x_ID" class="<%= SMSEmailQueue_search.SearchLabelClass %>"><span id="elh_SMSEmailQueue_ID"><%= SMSEmailQueue.ID.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_ID" id="z_ID" value="="></p>
		</label>
		<div class="<%= SMSEmailQueue_search.SearchRightColumnClass %>"><div<%= SMSEmailQueue.ID.CellAttributes %>>
			<span id="el_SMSEmailQueue_ID">
<input type="text" data-field="x_ID" name="x_ID" id="x_ID" placeholder="<%= SMSEmailQueue.ID.PlaceHolder %>" value="<%= SMSEmailQueue.ID.EditValue %>"<%= SMSEmailQueue.ID.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If SMSEmailQueue.ToEmailAddress.Visible Then ' ToEmailAddress %>
	<div id="r_ToEmailAddress" class="form-group">
		<label for="x_ToEmailAddress" class="<%= SMSEmailQueue_search.SearchLabelClass %>"><span id="elh_SMSEmailQueue_ToEmailAddress"><%= SMSEmailQueue.ToEmailAddress.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_ToEmailAddress" id="z_ToEmailAddress" value="LIKE"></p>
		</label>
		<div class="<%= SMSEmailQueue_search.SearchRightColumnClass %>"><div<%= SMSEmailQueue.ToEmailAddress.CellAttributes %>>
			<span id="el_SMSEmailQueue_ToEmailAddress">
<input type="text" data-field="x_ToEmailAddress" name="x_ToEmailAddress" id="x_ToEmailAddress" size="30" maxlength="50" placeholder="<%= SMSEmailQueue.ToEmailAddress.PlaceHolder %>" value="<%= SMSEmailQueue.ToEmailAddress.EditValue %>"<%= SMSEmailQueue.ToEmailAddress.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If SMSEmailQueue.PhoneNumber.Visible Then ' PhoneNumber %>
	<div id="r_PhoneNumber" class="form-group">
		<label for="x_PhoneNumber" class="<%= SMSEmailQueue_search.SearchLabelClass %>"><span id="elh_SMSEmailQueue_PhoneNumber"><%= SMSEmailQueue.PhoneNumber.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_PhoneNumber" id="z_PhoneNumber" value="LIKE"></p>
		</label>
		<div class="<%= SMSEmailQueue_search.SearchRightColumnClass %>"><div<%= SMSEmailQueue.PhoneNumber.CellAttributes %>>
			<span id="el_SMSEmailQueue_PhoneNumber">
<input type="text" data-field="x_PhoneNumber" name="x_PhoneNumber" id="x_PhoneNumber" size="30" maxlength="20" placeholder="<%= SMSEmailQueue.PhoneNumber.PlaceHolder %>" value="<%= SMSEmailQueue.PhoneNumber.EditValue %>"<%= SMSEmailQueue.PhoneNumber.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If SMSEmailQueue.Content.Visible Then ' Content %>
	<div id="r_Content" class="form-group">
		<label for="x_Content" class="<%= SMSEmailQueue_search.SearchLabelClass %>"><span id="elh_SMSEmailQueue_Content"><%= SMSEmailQueue.Content.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_Content" id="z_Content" value="LIKE"></p>
		</label>
		<div class="<%= SMSEmailQueue_search.SearchRightColumnClass %>"><div<%= SMSEmailQueue.Content.CellAttributes %>>
			<span id="el_SMSEmailQueue_Content">
<input type="text" data-field="x_Content" name="x_Content" id="x_Content" size="30" maxlength="255" placeholder="<%= SMSEmailQueue.Content.PlaceHolder %>" value="<%= SMSEmailQueue.Content.EditValue %>"<%= SMSEmailQueue.Content.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If SMSEmailQueue.SendTime.Visible Then ' SendTime %>
	<div id="r_SendTime" class="form-group">
		<label for="x_SendTime" class="<%= SMSEmailQueue_search.SearchLabelClass %>"><span id="elh_SMSEmailQueue_SendTime"><%= SMSEmailQueue.SendTime.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_SendTime" id="z_SendTime" value="="></p>
		</label>
		<div class="<%= SMSEmailQueue_search.SearchRightColumnClass %>"><div<%= SMSEmailQueue.SendTime.CellAttributes %>>
			<span id="el_SMSEmailQueue_SendTime">
<input type="text" data-field="x_SendTime" name="x_SendTime" id="x_SendTime" placeholder="<%= SMSEmailQueue.SendTime.PlaceHolder %>" value="<%= SMSEmailQueue.SendTime.EditValue %>"<%= SMSEmailQueue.SendTime.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If SMSEmailQueue.IsSent.Visible Then ' IsSent %>
	<div id="r_IsSent" class="form-group">
		<label for="x_IsSent" class="<%= SMSEmailQueue_search.SearchLabelClass %>"><span id="elh_SMSEmailQueue_IsSent"><%= SMSEmailQueue.IsSent.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_IsSent" id="z_IsSent" value="="></p>
		</label>
		<div class="<%= SMSEmailQueue_search.SearchRightColumnClass %>"><div<%= SMSEmailQueue.IsSent.CellAttributes %>>
			<span id="el_SMSEmailQueue_IsSent">
<input type="text" data-field="x_IsSent" name="x_IsSent" id="x_IsSent" size="30" placeholder="<%= SMSEmailQueue.IsSent.PlaceHolder %>" value="<%= SMSEmailQueue.IsSent.EditValue %>"<%= SMSEmailQueue.IsSent.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If SMSEmailQueue.PlanSendDate.Visible Then ' PlanSendDate %>
	<div id="r_PlanSendDate" class="form-group">
		<label for="x_PlanSendDate" class="<%= SMSEmailQueue_search.SearchLabelClass %>"><span id="elh_SMSEmailQueue_PlanSendDate"><%= SMSEmailQueue.PlanSendDate.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_PlanSendDate" id="z_PlanSendDate" value="="></p>
		</label>
		<div class="<%= SMSEmailQueue_search.SearchRightColumnClass %>"><div<%= SMSEmailQueue.PlanSendDate.CellAttributes %>>
			<span id="el_SMSEmailQueue_PlanSendDate">
<input type="text" data-field="x_PlanSendDate" name="x_PlanSendDate" id="x_PlanSendDate" placeholder="<%= SMSEmailQueue.PlanSendDate.PlaceHolder %>" value="<%= SMSEmailQueue.PlanSendDate.EditValue %>"<%= SMSEmailQueue.PlanSendDate.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If SMSEmailQueue.SendType.Visible Then ' SendType %>
	<div id="r_SendType" class="form-group">
		<label for="x_SendType" class="<%= SMSEmailQueue_search.SearchLabelClass %>"><span id="elh_SMSEmailQueue_SendType"><%= SMSEmailQueue.SendType.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_SendType" id="z_SendType" value="LIKE"></p>
		</label>
		<div class="<%= SMSEmailQueue_search.SearchRightColumnClass %>"><div<%= SMSEmailQueue.SendType.CellAttributes %>>
			<span id="el_SMSEmailQueue_SendType">
<input type="text" data-field="x_SendType" name="x_SendType" id="x_SendType" size="30" maxlength="10" placeholder="<%= SMSEmailQueue.SendType.PlaceHolder %>" value="<%= SMSEmailQueue.SendType.EditValue %>"<%= SMSEmailQueue.SendType.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If SMSEmailQueue.BusinessDetailID.Visible Then ' BusinessDetailID %>
	<div id="r_BusinessDetailID" class="form-group">
		<label for="x_BusinessDetailID" class="<%= SMSEmailQueue_search.SearchLabelClass %>"><span id="elh_SMSEmailQueue_BusinessDetailID"><%= SMSEmailQueue.BusinessDetailID.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_BusinessDetailID" id="z_BusinessDetailID" value="="></p>
		</label>
		<div class="<%= SMSEmailQueue_search.SearchRightColumnClass %>"><div<%= SMSEmailQueue.BusinessDetailID.CellAttributes %>>
			<span id="el_SMSEmailQueue_BusinessDetailID">
<input type="text" data-field="x_BusinessDetailID" name="x_BusinessDetailID" id="x_BusinessDetailID" size="30" placeholder="<%= SMSEmailQueue.BusinessDetailID.PlaceHolder %>" value="<%= SMSEmailQueue.BusinessDetailID.EditValue %>"<%= SMSEmailQueue.BusinessDetailID.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
</div>
<% If Not SMSEmailQueue_search.IsModal Then %>
<div class="form-group">
	<div class="col-sm-offset-3 col-sm-9">
<button class="btn btn-primary ewButton" name="btnAction" id="btnAction" type="submit"><%= Language.Phrase("Search") %></button>
<button class="btn btn-default ewButton" name="btnReset" id="btnReset" type="button" onclick="ew_ClearForm(this.form);"><%= Language.Phrase("Reset") %></button>
	</div>
</div>
<% End If %>
</form>
<script type="text/javascript">
fSMSEmailQueuesearch.Init();
</script>
<%
SMSEmailQueue_search.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set SMSEmailQueue_search = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cSMSEmailQueue_search

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
		TableName = "SMSEmailQueue"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "SMSEmailQueue_search"
	End Property

	' Page Name
	Public Property Get PageName()
		PageName = ew_CurrentPage()
	End Property

	' Page Url
	Public Property Get PageUrl()
		PageUrl = ew_CurrentPage() & "?"
		If SMSEmailQueue.UseTokenInUrl Then PageUrl = PageUrl & "t=" & SMSEmailQueue.TableVar & "&" ' add page token
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
		If SMSEmailQueue.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (SMSEmailQueue.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (SMSEmailQueue.TableVar = Request.QueryString("t"))
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
		If IsEmpty(SMSEmailQueue) Then Set SMSEmailQueue = New cSMSEmailQueue
		Set Table = SMSEmailQueue

		' Initialize urls
		' Initialize form object

		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "search"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "SMSEmailQueue"

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

		SMSEmailQueue.CurrentAction = ew_IIf(Request.QueryString("a").Count > 0, Request.QueryString("a") & "", ObjForm.GetValue("a_list") & "") ' Set up current action
		SMSEmailQueue.ID.Visible = Not SMSEmailQueue.IsAdd() And Not SMSEmailQueue.IsCopy() And Not SMSEmailQueue.IsGridAdd()

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
			results = SMSEmailQueue.GetAutoFill(Request.Form("name"), Request.Form("q"))
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
		If Not SMSEmailQueue Is Nothing Then
			If SMSEmailQueue.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = SMSEmailQueue.TableVar
				If SMSEmailQueue.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf SMSEmailQueue.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf SMSEmailQueue.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf SMSEmailQueue.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set SMSEmailQueue = Nothing
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
			SMSEmailQueue.CurrentAction = ObjForm.GetValue("a_search")
			Select Case SMSEmailQueue.CurrentAction
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
						sSrchStr = SMSEmailQueue.UrlParm(sSrchStr)
						sSrchStr = "SMSEmailQueuelist.asp" & "?" & sSrchStr
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
		SMSEmailQueue.RowType = EW_ROWTYPE_SEARCH
		Call RenderRow()
	End Sub

	' -----------------------------------------------------------------
	' Build advanced search
	'
	Function BuildAdvancedSearch()
		Dim sSrchUrl
		sSrchUrl = ""
		Call BuildSearchUrl(sSrchUrl, SMSEmailQueue.ID, False) ' ID
		Call BuildSearchUrl(sSrchUrl, SMSEmailQueue.ToEmailAddress, False) ' ToEmailAddress
		Call BuildSearchUrl(sSrchUrl, SMSEmailQueue.PhoneNumber, False) ' PhoneNumber
		Call BuildSearchUrl(sSrchUrl, SMSEmailQueue.Content, False) ' Content
		Call BuildSearchUrl(sSrchUrl, SMSEmailQueue.SendTime, False) ' SendTime
		Call BuildSearchUrl(sSrchUrl, SMSEmailQueue.IsSent, False) ' IsSent
		Call BuildSearchUrl(sSrchUrl, SMSEmailQueue.PlanSendDate, False) ' PlanSendDate
		Call BuildSearchUrl(sSrchUrl, SMSEmailQueue.SendType, False) ' SendType
		Call BuildSearchUrl(sSrchUrl, SMSEmailQueue.BusinessDetailID, False) ' BusinessDetailID
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
		SMSEmailQueue.ID.AdvancedSearch.SearchValue = ObjForm.GetValue("x_ID")
		SMSEmailQueue.ID.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_ID")
		SMSEmailQueue.ToEmailAddress.AdvancedSearch.SearchValue = ObjForm.GetValue("x_ToEmailAddress")
		SMSEmailQueue.ToEmailAddress.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_ToEmailAddress")
		SMSEmailQueue.PhoneNumber.AdvancedSearch.SearchValue = ObjForm.GetValue("x_PhoneNumber")
		SMSEmailQueue.PhoneNumber.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_PhoneNumber")
		SMSEmailQueue.Content.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Content")
		SMSEmailQueue.Content.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Content")
		SMSEmailQueue.SendTime.AdvancedSearch.SearchValue = ObjForm.GetValue("x_SendTime")
		SMSEmailQueue.SendTime.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_SendTime")
		SMSEmailQueue.IsSent.AdvancedSearch.SearchValue = ObjForm.GetValue("x_IsSent")
		SMSEmailQueue.IsSent.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_IsSent")
		SMSEmailQueue.PlanSendDate.AdvancedSearch.SearchValue = ObjForm.GetValue("x_PlanSendDate")
		SMSEmailQueue.PlanSendDate.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_PlanSendDate")
		SMSEmailQueue.SendType.AdvancedSearch.SearchValue = ObjForm.GetValue("x_SendType")
		SMSEmailQueue.SendType.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_SendType")
		SMSEmailQueue.BusinessDetailID.AdvancedSearch.SearchValue = ObjForm.GetValue("x_BusinessDetailID")
		SMSEmailQueue.BusinessDetailID.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_BusinessDetailID")
	End Function

	' -----------------------------------------------------------------
	' Render row values based on field settings
	'
	Sub RenderRow()

		' Initialize urls
		' Convert decimal values if posted back

		If SMSEmailQueue.BusinessDetailID.CurrentValue & "" <> "" Then SMSEmailQueue.BusinessDetailID.CurrentValue = ew_Conv(SMSEmailQueue.BusinessDetailID.CurrentValue, SMSEmailQueue.BusinessDetailID.FldType)
		If SMSEmailQueue.BusinessDetailID.FormValue = SMSEmailQueue.BusinessDetailID.CurrentValue And IsNumeric(SMSEmailQueue.BusinessDetailID.CurrentValue) Then
			SMSEmailQueue.BusinessDetailID.CurrentValue = ew_StrToFloat(SMSEmailQueue.BusinessDetailID.CurrentValue)
		End If

		' Call Row Rendering event
		Call SMSEmailQueue.Row_Rendering()

		' ---------------------------------------
		'  Common render codes for all row types
		' ---------------------------------------
		' ID
		' ToEmailAddress
		' PhoneNumber
		' Content
		' SendTime
		' IsSent
		' PlanSendDate
		' SendType
		' BusinessDetailID
		' -----------
		'  View  Row
		' -----------

		If SMSEmailQueue.RowType = EW_ROWTYPE_VIEW Then ' View row

			' ID
			SMSEmailQueue.ID.ViewValue = SMSEmailQueue.ID.CurrentValue
			SMSEmailQueue.ID.ViewCustomAttributes = ""

			' ToEmailAddress
			SMSEmailQueue.ToEmailAddress.ViewValue = SMSEmailQueue.ToEmailAddress.CurrentValue
			SMSEmailQueue.ToEmailAddress.ViewCustomAttributes = ""

			' PhoneNumber
			SMSEmailQueue.PhoneNumber.ViewValue = SMSEmailQueue.PhoneNumber.CurrentValue
			SMSEmailQueue.PhoneNumber.ViewCustomAttributes = ""

			' Content
			SMSEmailQueue.Content.ViewValue = SMSEmailQueue.Content.CurrentValue
			SMSEmailQueue.Content.ViewCustomAttributes = ""

			' SendTime
			SMSEmailQueue.SendTime.ViewValue = SMSEmailQueue.SendTime.CurrentValue
			SMSEmailQueue.SendTime.ViewValue = ew_FormatDateTime(SMSEmailQueue.SendTime.ViewValue, 9)
			SMSEmailQueue.SendTime.ViewCustomAttributes = ""

			' IsSent
			SMSEmailQueue.IsSent.ViewValue = SMSEmailQueue.IsSent.CurrentValue
			SMSEmailQueue.IsSent.ViewCustomAttributes = ""

			' PlanSendDate
			SMSEmailQueue.PlanSendDate.ViewValue = SMSEmailQueue.PlanSendDate.CurrentValue
			SMSEmailQueue.PlanSendDate.ViewValue = ew_FormatDateTime(SMSEmailQueue.PlanSendDate.ViewValue, 9)
			SMSEmailQueue.PlanSendDate.ViewCustomAttributes = ""

			' SendType
			SMSEmailQueue.SendType.ViewValue = SMSEmailQueue.SendType.CurrentValue
			SMSEmailQueue.SendType.ViewCustomAttributes = ""

			' BusinessDetailID
			SMSEmailQueue.BusinessDetailID.ViewValue = SMSEmailQueue.BusinessDetailID.CurrentValue
			SMSEmailQueue.BusinessDetailID.ViewCustomAttributes = ""

			' View refer script
			' ID

			SMSEmailQueue.ID.LinkCustomAttributes = ""
			SMSEmailQueue.ID.HrefValue = ""
			SMSEmailQueue.ID.TooltipValue = ""

			' ToEmailAddress
			SMSEmailQueue.ToEmailAddress.LinkCustomAttributes = ""
			SMSEmailQueue.ToEmailAddress.HrefValue = ""
			SMSEmailQueue.ToEmailAddress.TooltipValue = ""

			' PhoneNumber
			SMSEmailQueue.PhoneNumber.LinkCustomAttributes = ""
			SMSEmailQueue.PhoneNumber.HrefValue = ""
			SMSEmailQueue.PhoneNumber.TooltipValue = ""

			' Content
			SMSEmailQueue.Content.LinkCustomAttributes = ""
			SMSEmailQueue.Content.HrefValue = ""
			SMSEmailQueue.Content.TooltipValue = ""

			' SendTime
			SMSEmailQueue.SendTime.LinkCustomAttributes = ""
			SMSEmailQueue.SendTime.HrefValue = ""
			SMSEmailQueue.SendTime.TooltipValue = ""

			' IsSent
			SMSEmailQueue.IsSent.LinkCustomAttributes = ""
			SMSEmailQueue.IsSent.HrefValue = ""
			SMSEmailQueue.IsSent.TooltipValue = ""

			' PlanSendDate
			SMSEmailQueue.PlanSendDate.LinkCustomAttributes = ""
			SMSEmailQueue.PlanSendDate.HrefValue = ""
			SMSEmailQueue.PlanSendDate.TooltipValue = ""

			' SendType
			SMSEmailQueue.SendType.LinkCustomAttributes = ""
			SMSEmailQueue.SendType.HrefValue = ""
			SMSEmailQueue.SendType.TooltipValue = ""

			' BusinessDetailID
			SMSEmailQueue.BusinessDetailID.LinkCustomAttributes = ""
			SMSEmailQueue.BusinessDetailID.HrefValue = ""
			SMSEmailQueue.BusinessDetailID.TooltipValue = ""

		' ------------
		'  Search Row
		' ------------

		ElseIf SMSEmailQueue.RowType = EW_ROWTYPE_SEARCH Then ' Search row

			' ID
			SMSEmailQueue.ID.EditAttrs.UpdateAttribute "class", "form-control"
			SMSEmailQueue.ID.EditCustomAttributes = ""
			SMSEmailQueue.ID.EditValue = ew_HtmlEncode(SMSEmailQueue.ID.AdvancedSearch.SearchValue)
			SMSEmailQueue.ID.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(SMSEmailQueue.ID.FldCaption))

			' ToEmailAddress
			SMSEmailQueue.ToEmailAddress.EditAttrs.UpdateAttribute "class", "form-control"
			SMSEmailQueue.ToEmailAddress.EditCustomAttributes = ""
			SMSEmailQueue.ToEmailAddress.EditValue = ew_HtmlEncode(SMSEmailQueue.ToEmailAddress.AdvancedSearch.SearchValue)
			SMSEmailQueue.ToEmailAddress.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(SMSEmailQueue.ToEmailAddress.FldCaption))

			' PhoneNumber
			SMSEmailQueue.PhoneNumber.EditAttrs.UpdateAttribute "class", "form-control"
			SMSEmailQueue.PhoneNumber.EditCustomAttributes = ""
			SMSEmailQueue.PhoneNumber.EditValue = ew_HtmlEncode(SMSEmailQueue.PhoneNumber.AdvancedSearch.SearchValue)
			SMSEmailQueue.PhoneNumber.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(SMSEmailQueue.PhoneNumber.FldCaption))

			' Content
			SMSEmailQueue.Content.EditAttrs.UpdateAttribute "class", "form-control"
			SMSEmailQueue.Content.EditCustomAttributes = ""
			SMSEmailQueue.Content.EditValue = ew_HtmlEncode(SMSEmailQueue.Content.AdvancedSearch.SearchValue)
			SMSEmailQueue.Content.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(SMSEmailQueue.Content.FldCaption))

			' SendTime
			SMSEmailQueue.SendTime.EditAttrs.UpdateAttribute "class", "form-control"
			SMSEmailQueue.SendTime.EditCustomAttributes = ""
			SMSEmailQueue.SendTime.EditValue = ew_FormatDateTime(ew_UnFormatDateTime(SMSEmailQueue.SendTime.AdvancedSearch.SearchValue, 9), 9)
			SMSEmailQueue.SendTime.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(SMSEmailQueue.SendTime.FldCaption))

			' IsSent
			SMSEmailQueue.IsSent.EditAttrs.UpdateAttribute "class", "form-control"
			SMSEmailQueue.IsSent.EditCustomAttributes = ""
			SMSEmailQueue.IsSent.EditValue = ew_HtmlEncode(SMSEmailQueue.IsSent.AdvancedSearch.SearchValue)
			SMSEmailQueue.IsSent.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(SMSEmailQueue.IsSent.FldCaption))

			' PlanSendDate
			SMSEmailQueue.PlanSendDate.EditAttrs.UpdateAttribute "class", "form-control"
			SMSEmailQueue.PlanSendDate.EditCustomAttributes = ""
			SMSEmailQueue.PlanSendDate.EditValue = ew_FormatDateTime(ew_UnFormatDateTime(SMSEmailQueue.PlanSendDate.AdvancedSearch.SearchValue, 9), 9)
			SMSEmailQueue.PlanSendDate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(SMSEmailQueue.PlanSendDate.FldCaption))

			' SendType
			SMSEmailQueue.SendType.EditAttrs.UpdateAttribute "class", "form-control"
			SMSEmailQueue.SendType.EditCustomAttributes = ""
			SMSEmailQueue.SendType.EditValue = ew_HtmlEncode(SMSEmailQueue.SendType.AdvancedSearch.SearchValue)
			SMSEmailQueue.SendType.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(SMSEmailQueue.SendType.FldCaption))

			' BusinessDetailID
			SMSEmailQueue.BusinessDetailID.EditAttrs.UpdateAttribute "class", "form-control"
			SMSEmailQueue.BusinessDetailID.EditCustomAttributes = ""
			SMSEmailQueue.BusinessDetailID.EditValue = ew_HtmlEncode(SMSEmailQueue.BusinessDetailID.AdvancedSearch.SearchValue)
			SMSEmailQueue.BusinessDetailID.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(SMSEmailQueue.BusinessDetailID.FldCaption))
		End If
		If SMSEmailQueue.RowType = EW_ROWTYPE_ADD Or SMSEmailQueue.RowType = EW_ROWTYPE_EDIT Or SMSEmailQueue.RowType = EW_ROWTYPE_SEARCH Then ' Add / Edit / Search row
			Call SMSEmailQueue.SetupFieldTitles()
		End If

		' Call Row Rendered event
		If SMSEmailQueue.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call SMSEmailQueue.Row_Rendered()
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
		If Not ew_CheckInteger(SMSEmailQueue.ID.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, SMSEmailQueue.ID.FldErrMsg)
		End If
		If Not ew_CheckDate(SMSEmailQueue.SendTime.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, SMSEmailQueue.SendTime.FldErrMsg)
		End If
		If Not ew_CheckInteger(SMSEmailQueue.IsSent.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, SMSEmailQueue.IsSent.FldErrMsg)
		End If
		If Not ew_CheckDate(SMSEmailQueue.PlanSendDate.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, SMSEmailQueue.PlanSendDate.FldErrMsg)
		End If
		If Not ew_CheckNumber(SMSEmailQueue.BusinessDetailID.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, SMSEmailQueue.BusinessDetailID.FldErrMsg)
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
		Call SMSEmailQueue.ID.AdvancedSearch.Load()
		Call SMSEmailQueue.ToEmailAddress.AdvancedSearch.Load()
		Call SMSEmailQueue.PhoneNumber.AdvancedSearch.Load()
		Call SMSEmailQueue.Content.AdvancedSearch.Load()
		Call SMSEmailQueue.SendTime.AdvancedSearch.Load()
		Call SMSEmailQueue.IsSent.AdvancedSearch.Load()
		Call SMSEmailQueue.PlanSendDate.AdvancedSearch.Load()
		Call SMSEmailQueue.SendType.AdvancedSearch.Load()
		Call SMSEmailQueue.BusinessDetailID.AdvancedSearch.Load()
End Function

	' Set up Breadcrumb
	Sub SetupBreadcrumb()
		Dim PageId, url
		Set Breadcrumb = New cBreadcrumb
		url = Mid(ew_CurrentUrl, InStrRev(ew_CurrentUrl, "/")+1)
		Call Breadcrumb.Add("list", SMSEmailQueue.TableVar, "SMSEmailQueuelist.asp", "", SMSEmailQueue.TableVar, True)
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
