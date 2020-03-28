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
Dim SMSEmailQueue_update
Set SMSEmailQueue_update = New cSMSEmailQueue_update
Set Page = SMSEmailQueue_update

' Page init processing
SMSEmailQueue_update.Page_Init()

' Page main processing
SMSEmailQueue_update.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
SMSEmailQueue_update.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var SMSEmailQueue_update = new ew_Page("SMSEmailQueue_update");
SMSEmailQueue_update.PageID = "update"; // Page ID
var EW_PAGE_ID = SMSEmailQueue_update.PageID; // For backward compatibility
// Form object
var fSMSEmailQueueupdate = new ew_Form("fSMSEmailQueueupdate");
// Validate form
fSMSEmailQueueupdate.Validate = function() {
	if (!this.ValidateRequired)
		return true; // Ignore validation
	var $ = jQuery, fobj = this.GetForm(), $fobj = $(fobj);
	this.PostAutoSuggest();
	if ($fobj.find("#a_confirm").val() == "F")
		return true;
	if (!ew_UpdateSelected(fobj)) {
		alert(ewLanguage.Phrase("NoFieldSelected"));
		return false;
	}
	var elm, felm, uelm, addcnt = 0;
	var $k = $fobj.find("#" + this.FormKeyCountName); // Get key_count
	var rowcnt = ($k[0]) ? parseInt($k.val(), 10) : 1;
	var startcnt = (rowcnt == 0) ? 0 : 1; // Check rowcnt == 0 => Inline-Add
	var gridinsert = $fobj.find("#a_list").val() == "gridinsert";
	for (var i = startcnt; i <= rowcnt; i++) {
		var infix = ($k[0]) ? String(i) : "";
		$fobj.data("rowindex", infix);
			elm = this.GetElements("x" + infix + "_SendTime");
			uelm = this.GetElements("u" + infix + "_SendTime");
			if (uelm && uelm.checked && elm && !ew_CheckDate(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(SMSEmailQueue.SendTime.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_IsSent");
			uelm = this.GetElements("u" + infix + "_IsSent");
			if (uelm && uelm.checked) {
				if (elm && !ew_IsHidden(elm) && !ew_HasValue(elm))
					return this.OnError(elm, "<%= ew_JsEncode2(Replace(SMSEmailQueue.IsSent.ReqErrMsg, "%s", SMSEmailQueue.IsSent.FldCaption)) %>");
			}
			elm = this.GetElements("x" + infix + "_IsSent");
			uelm = this.GetElements("u" + infix + "_IsSent");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(SMSEmailQueue.IsSent.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_PlanSendDate");
			uelm = this.GetElements("u" + infix + "_PlanSendDate");
			if (uelm && uelm.checked && elm && !ew_CheckDate(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(SMSEmailQueue.PlanSendDate.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_BusinessDetailID");
			uelm = this.GetElements("u" + infix + "_BusinessDetailID");
			if (uelm && uelm.checked && elm && !ew_CheckNumber(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(SMSEmailQueue.BusinessDetailID.FldErrMsg) %>");
			// Set up row object
			ew_ElementsToRow(fobj);
			// Fire Form_CustomValidate event
			if (!this.Form_CustomValidate(fobj))
				return false;
	}
	return true;
}
// Form_CustomValidate event
fSMSEmailQueueupdate.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fSMSEmailQueueupdate.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fSMSEmailQueueupdate.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<div class="ewToolbar">
<% If SMSEmailQueue.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If SMSEmailQueue.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% SMSEmailQueue_update.ShowPageHeader() %>
<% SMSEmailQueue_update.ShowMessage %>
<form name="fSMSEmailQueueupdate" id="fSMSEmailQueueupdate" class="form-horizontal ewForm ewUpdateForm" action="<%= ew_CurrentPage %>" method="post">
<% If SMSEmailQueue_update.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= SMSEmailQueue_update.Token %>">
<% End If %>
<input type="hidden" name="t" value="SMSEmailQueue">
<input type="hidden" name="a_update" id="a_update" value="U">
<% For i = 0 to UBound(SMSEmailQueue_update.RecKeys) %>
<input type="hidden" name="key_m" id="key_m" value="<%= ew_HtmlEncode(ew_GetKeyValue(SMSEmailQueue_update.RecKeys(i))) %>">
<% Next %>
<div id="tbl_SMSEmailQueueupdate">
	<div class="form-group">
		<label class="col-sm-2"><input type="checkbox" name="u" id="u" onclick="ew_SelectAll(this);"> <%= Language.Phrase("UpdateSelectAll") %></label>
	</div>
<% If SMSEmailQueue.ToEmailAddress.Visible Then ' ToEmailAddress %>
	<div id="r_ToEmailAddress" class="form-group">
		<label for="x_ToEmailAddress" class="col-sm-2 control-label">
<input type="checkbox" name="u_ToEmailAddress" id="u_ToEmailAddress" value="1"<% If SMSEmailQueue.ToEmailAddress.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= SMSEmailQueue.ToEmailAddress.FldCaption %></label>
		<div class="col-sm-10"><div<%= SMSEmailQueue.ToEmailAddress.CellAttributes %>>
<span id="el_SMSEmailQueue_ToEmailAddress">
<input type="text" data-field="x_ToEmailAddress" name="x_ToEmailAddress" id="x_ToEmailAddress" size="30" maxlength="50" placeholder="<%= SMSEmailQueue.ToEmailAddress.PlaceHolder %>" value="<%= SMSEmailQueue.ToEmailAddress.EditValue %>"<%= SMSEmailQueue.ToEmailAddress.EditAttributes %>>
</span>
<%= SMSEmailQueue.ToEmailAddress.CustomMsg %></div></div>
	</div>
<% End If %>
<% If SMSEmailQueue.PhoneNumber.Visible Then ' PhoneNumber %>
	<div id="r_PhoneNumber" class="form-group">
		<label for="x_PhoneNumber" class="col-sm-2 control-label">
<input type="checkbox" name="u_PhoneNumber" id="u_PhoneNumber" value="1"<% If SMSEmailQueue.PhoneNumber.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= SMSEmailQueue.PhoneNumber.FldCaption %></label>
		<div class="col-sm-10"><div<%= SMSEmailQueue.PhoneNumber.CellAttributes %>>
<span id="el_SMSEmailQueue_PhoneNumber">
<input type="text" data-field="x_PhoneNumber" name="x_PhoneNumber" id="x_PhoneNumber" size="30" maxlength="20" placeholder="<%= SMSEmailQueue.PhoneNumber.PlaceHolder %>" value="<%= SMSEmailQueue.PhoneNumber.EditValue %>"<%= SMSEmailQueue.PhoneNumber.EditAttributes %>>
</span>
<%= SMSEmailQueue.PhoneNumber.CustomMsg %></div></div>
	</div>
<% End If %>
<% If SMSEmailQueue.Content.Visible Then ' Content %>
	<div id="r_Content" class="form-group">
		<label for="x_Content" class="col-sm-2 control-label">
<input type="checkbox" name="u_Content" id="u_Content" value="1"<% If SMSEmailQueue.Content.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= SMSEmailQueue.Content.FldCaption %></label>
		<div class="col-sm-10"><div<%= SMSEmailQueue.Content.CellAttributes %>>
<span id="el_SMSEmailQueue_Content">
<input type="text" data-field="x_Content" name="x_Content" id="x_Content" size="30" maxlength="255" placeholder="<%= SMSEmailQueue.Content.PlaceHolder %>" value="<%= SMSEmailQueue.Content.EditValue %>"<%= SMSEmailQueue.Content.EditAttributes %>>
</span>
<%= SMSEmailQueue.Content.CustomMsg %></div></div>
	</div>
<% End If %>
<% If SMSEmailQueue.SendTime.Visible Then ' SendTime %>
	<div id="r_SendTime" class="form-group">
		<label for="x_SendTime" class="col-sm-2 control-label">
<input type="checkbox" name="u_SendTime" id="u_SendTime" value="1"<% If SMSEmailQueue.SendTime.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= SMSEmailQueue.SendTime.FldCaption %></label>
		<div class="col-sm-10"><div<%= SMSEmailQueue.SendTime.CellAttributes %>>
<span id="el_SMSEmailQueue_SendTime">
<input type="text" data-field="x_SendTime" name="x_SendTime" id="x_SendTime" placeholder="<%= SMSEmailQueue.SendTime.PlaceHolder %>" value="<%= SMSEmailQueue.SendTime.EditValue %>"<%= SMSEmailQueue.SendTime.EditAttributes %>>
</span>
<%= SMSEmailQueue.SendTime.CustomMsg %></div></div>
	</div>
<% End If %>
<% If SMSEmailQueue.IsSent.Visible Then ' IsSent %>
	<div id="r_IsSent" class="form-group">
		<label for="x_IsSent" class="col-sm-2 control-label">
<input type="checkbox" name="u_IsSent" id="u_IsSent" value="1"<% If SMSEmailQueue.IsSent.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= SMSEmailQueue.IsSent.FldCaption %></label>
		<div class="col-sm-10"><div<%= SMSEmailQueue.IsSent.CellAttributes %>>
<span id="el_SMSEmailQueue_IsSent">
<input type="text" data-field="x_IsSent" name="x_IsSent" id="x_IsSent" size="30" placeholder="<%= SMSEmailQueue.IsSent.PlaceHolder %>" value="<%= SMSEmailQueue.IsSent.EditValue %>"<%= SMSEmailQueue.IsSent.EditAttributes %>>
</span>
<%= SMSEmailQueue.IsSent.CustomMsg %></div></div>
	</div>
<% End If %>
<% If SMSEmailQueue.PlanSendDate.Visible Then ' PlanSendDate %>
	<div id="r_PlanSendDate" class="form-group">
		<label for="x_PlanSendDate" class="col-sm-2 control-label">
<input type="checkbox" name="u_PlanSendDate" id="u_PlanSendDate" value="1"<% If SMSEmailQueue.PlanSendDate.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= SMSEmailQueue.PlanSendDate.FldCaption %></label>
		<div class="col-sm-10"><div<%= SMSEmailQueue.PlanSendDate.CellAttributes %>>
<span id="el_SMSEmailQueue_PlanSendDate">
<input type="text" data-field="x_PlanSendDate" name="x_PlanSendDate" id="x_PlanSendDate" placeholder="<%= SMSEmailQueue.PlanSendDate.PlaceHolder %>" value="<%= SMSEmailQueue.PlanSendDate.EditValue %>"<%= SMSEmailQueue.PlanSendDate.EditAttributes %>>
</span>
<%= SMSEmailQueue.PlanSendDate.CustomMsg %></div></div>
	</div>
<% End If %>
<% If SMSEmailQueue.SendType.Visible Then ' SendType %>
	<div id="r_SendType" class="form-group">
		<label for="x_SendType" class="col-sm-2 control-label">
<input type="checkbox" name="u_SendType" id="u_SendType" value="1"<% If SMSEmailQueue.SendType.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= SMSEmailQueue.SendType.FldCaption %></label>
		<div class="col-sm-10"><div<%= SMSEmailQueue.SendType.CellAttributes %>>
<span id="el_SMSEmailQueue_SendType">
<input type="text" data-field="x_SendType" name="x_SendType" id="x_SendType" size="30" maxlength="10" placeholder="<%= SMSEmailQueue.SendType.PlaceHolder %>" value="<%= SMSEmailQueue.SendType.EditValue %>"<%= SMSEmailQueue.SendType.EditAttributes %>>
</span>
<%= SMSEmailQueue.SendType.CustomMsg %></div></div>
	</div>
<% End If %>
<% If SMSEmailQueue.BusinessDetailID.Visible Then ' BusinessDetailID %>
	<div id="r_BusinessDetailID" class="form-group">
		<label for="x_BusinessDetailID" class="col-sm-2 control-label">
<input type="checkbox" name="u_BusinessDetailID" id="u_BusinessDetailID" value="1"<% If SMSEmailQueue.BusinessDetailID.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= SMSEmailQueue.BusinessDetailID.FldCaption %></label>
		<div class="col-sm-10"><div<%= SMSEmailQueue.BusinessDetailID.CellAttributes %>>
<span id="el_SMSEmailQueue_BusinessDetailID">
<input type="text" data-field="x_BusinessDetailID" name="x_BusinessDetailID" id="x_BusinessDetailID" size="30" placeholder="<%= SMSEmailQueue.BusinessDetailID.PlaceHolder %>" value="<%= SMSEmailQueue.BusinessDetailID.EditValue %>"<%= SMSEmailQueue.BusinessDetailID.EditAttributes %>>
</span>
<%= SMSEmailQueue.BusinessDetailID.CustomMsg %></div></div>
	</div>
<% End If %>
	<div class="form-group">
		<div class="col-sm-offset-2 col-sm-10">
<button class="btn btn-primary ewButton" name="btnAction" id="btnAction" type="submit"><%= Language.Phrase("UpdateBtn") %></button>
		</div>
	</div>
</div>
</form>
<script type="text/javascript">
fSMSEmailQueueupdate.Init();
</script>
<%
SMSEmailQueue_update.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set SMSEmailQueue_update = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cSMSEmailQueue_update

	' Page ID
	Public Property Get PageID()
		PageID = "update"
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
		PageObjName = "SMSEmailQueue_update"
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
		EW_PAGE_ID = "update"

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

	Dim RecKeys
	Dim Disabled
	Dim Recordset
	Dim UpdateCount

	' -----------------------------------------------------------------
	' Page main processing
	'
	Sub Page_Main()
		Dim sKeyName
		Dim sKey
		Dim nKeySelected
		Dim bUpdateSelected
		UpdateCount = 0

		' Set up Breadcrumb
		SetupBreadcrumb()
		RecKeys = SMSEmailQueue.GetRecordKeys() ' Load record keys
		If ObjForm.GetValue("a_update")&"" <> "" Then

			' Get action
			SMSEmailQueue.CurrentAction = ObjForm.GetValue("a_update")
			Call LoadFormValues() ' Get form values

			' Validate form
			If Not ValidateForm() Then
				SMSEmailQueue.CurrentAction = "I" ' Form error, reset action
				FailureMessage = gsFormError
			End If
		Else
			Call LoadMultiUpdateValues() ' Load initial values to form
		End If
		If Not IsArray(RecKeys) Then
			Call Page_Terminate("SMSEmailQueuelist.asp") ' No records selected, return to list
		End If
		Select Case SMSEmailQueue.CurrentAction
			Case "U" ' Update
				If UpdateRows() Then ' Update Records based on key
					If SuccessMessage = "" Then SuccessMessage = Language.Phrase("UpdateSuccess") ' Set update success message
					Call Page_Terminate(SMSEmailQueue.ReturnUrl) ' Return to caller
				Else
					Call RestoreFormValues() ' Restore form values
				End If
		End Select

		' Render row
		SMSEmailQueue.RowType = EW_ROWTYPE_EDIT ' Render edit

		' Render row
		Call SMSEmailQueue.ResetAttrs()
		Call RenderRow()
	End Sub

	' -----------------------------------------------------------------
	' Load initial values to form if field values are identical in all selected records
	'
	Sub LoadMultiUpdateValues()
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		Dim Rs, i, OldValue, NewValue
		SMSEmailQueue.CurrentFilter = SMSEmailQueue.GetKeyFilter()

		' Load recordset
		Set Rs = LoadRecordset()
		i = 1
		Do While Not Rs.Eof
			If i = 1 Then
				SMSEmailQueue.ToEmailAddress.DbValue = ew_Conv(Rs("ToEmailAddress"), Rs("ToEmailAddress").Type)
				SMSEmailQueue.PhoneNumber.DbValue = ew_Conv(Rs("PhoneNumber"), Rs("PhoneNumber").Type)
				SMSEmailQueue.Content.DbValue = ew_Conv(Rs("Content"), Rs("Content").Type)
				SMSEmailQueue.SendTime.DbValue = ew_Conv(Rs("SendTime"), Rs("SendTime").Type)
				SMSEmailQueue.IsSent.DbValue = ew_Conv(Rs("IsSent"), Rs("IsSent").Type)
				SMSEmailQueue.PlanSendDate.DbValue = ew_Conv(Rs("PlanSendDate"), Rs("PlanSendDate").Type)
				SMSEmailQueue.SendType.DbValue = ew_Conv(Rs("SendType"), Rs("SendType").Type)
				SMSEmailQueue.BusinessDetailID.DbValue = ew_Conv(Rs("BusinessDetailID"), Rs("BusinessDetailID").Type)
			Else
				OldValue = SMSEmailQueue.ToEmailAddress.DbValue
				NewValue = ew_Conv(Rs("ToEmailAddress"), Rs("ToEmailAddress").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					SMSEmailQueue.ToEmailAddress.CurrentValue = Null
				End If
				OldValue = SMSEmailQueue.PhoneNumber.DbValue
				NewValue = ew_Conv(Rs("PhoneNumber"), Rs("PhoneNumber").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					SMSEmailQueue.PhoneNumber.CurrentValue = Null
				End If
				OldValue = SMSEmailQueue.Content.DbValue
				NewValue = ew_Conv(Rs("Content"), Rs("Content").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					SMSEmailQueue.Content.CurrentValue = Null
				End If
				OldValue = SMSEmailQueue.SendTime.DbValue
				NewValue = ew_Conv(Rs("SendTime"), Rs("SendTime").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					SMSEmailQueue.SendTime.CurrentValue = Null
				End If
				OldValue = SMSEmailQueue.IsSent.DbValue
				NewValue = ew_Conv(Rs("IsSent"), Rs("IsSent").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					SMSEmailQueue.IsSent.CurrentValue = Null
				End If
				OldValue = SMSEmailQueue.PlanSendDate.DbValue
				NewValue = ew_Conv(Rs("PlanSendDate"), Rs("PlanSendDate").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					SMSEmailQueue.PlanSendDate.CurrentValue = Null
				End If
				OldValue = SMSEmailQueue.SendType.DbValue
				NewValue = ew_Conv(Rs("SendType"), Rs("SendType").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					SMSEmailQueue.SendType.CurrentValue = Null
				End If
				OldValue = SMSEmailQueue.BusinessDetailID.DbValue
				NewValue = ew_Conv(Rs("BusinessDetailID"), Rs("BusinessDetailID").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					SMSEmailQueue.BusinessDetailID.CurrentValue = Null
				End If
			End If
			i = i + 1
			Rs.MoveNext
		Loop
		Rs.Close
		Set Rs = Nothing
	End Sub

	' -----------------------------------------------------------------
	'  Set up key value
	'
	Function SetupKeyValues(key)
		Dim sKeyFld
		Dim sWrkFilter, sFilter
		sKeyFld = key
		If Not IsNumeric(sKeyFld) Then
			SetupKeyValues = False
			Exit Function
		End If
		SMSEmailQueue.ID.CurrentValue = sKeyFld ' Set up key value
		SetupKeyValues = True
	End Function

	' -----------------------------------------------------------------
	' Update all selected rows
	'
	Function UpdateRows()
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		Dim sKey, sThisKey
		Dim Rs, RsOld, RsNew, sSql, i
		Conn.BeginTrans

		' Get old recordset
		SMSEmailQueue.CurrentFilter = SMSEmailQueue.GetKeyFilter()
		sSql = SMSEmailQueue.SQL
		Set Rs = Server.CreateObject("ADODB.Recordset")
		Rs.CursorLocation = EW_CURSORLOCATION
		Rs.Open sSql, Conn, 1, EW_RECORDSET_LOCKTYPE
		Set RsOld = ew_CloneRs(Rs)

		' Update all rows
		sKey = ""
		For i = 0 to UBound(RecKeys)
			If SetupKeyValues(RecKeys(i)) Then
				sThisKey = RecKeys(i)
				SMSEmailQueue.SendEmail = False ' Do not send email on update success
				UpdateCount = UpdateCount + 1 ' Update record count for records being updated
				UpdateRows = EditRow() ' Update this row
			Else
				UpdateRows = False
			End If
			If Not UpdateRows Then Exit For ' Update failed
			If sKey <> "" Then sKey = sKey & ", "
			sKey = sKey & sThisKey
		Next
		If UpdateRows Then
			Conn.CommitTrans ' Commit transaction

			' Get new recordset
			Set Rs = Conn.Execute(sSql)
			Set RsNew = ew_CloneRs(Rs)
		Else
			Conn.RollbackTrans ' Rollback transaction
		End If
		Set Rs = Nothing
		Set RsOld = Nothing
		Set RsNew = Nothing
	End Function

	' -----------------------------------------------------------------
	' Function Get upload files
	'
	Function GetUploadFiles()

		' Get upload data
	End Function

	' -----------------------------------------------------------------
	' Load form values
	'
	Function LoadFormValues()

		' Load values from form
		If Not SMSEmailQueue.ToEmailAddress.FldIsDetailKey Then SMSEmailQueue.ToEmailAddress.FormValue = ObjForm.GetValue("x_ToEmailAddress")
		SMSEmailQueue.ToEmailAddress.MultiUpdate = ObjForm.GetValue("u_ToEmailAddress")
		If Not SMSEmailQueue.PhoneNumber.FldIsDetailKey Then SMSEmailQueue.PhoneNumber.FormValue = ObjForm.GetValue("x_PhoneNumber")
		SMSEmailQueue.PhoneNumber.MultiUpdate = ObjForm.GetValue("u_PhoneNumber")
		If Not SMSEmailQueue.Content.FldIsDetailKey Then SMSEmailQueue.Content.FormValue = ObjForm.GetValue("x_Content")
		SMSEmailQueue.Content.MultiUpdate = ObjForm.GetValue("u_Content")
		If Not SMSEmailQueue.SendTime.FldIsDetailKey Then SMSEmailQueue.SendTime.FormValue = ObjForm.GetValue("x_SendTime")
		If Not SMSEmailQueue.SendTime.FldIsDetailKey Then SMSEmailQueue.SendTime.CurrentValue = ew_UnFormatDateTime(SMSEmailQueue.SendTime.CurrentValue, 9)
		SMSEmailQueue.SendTime.MultiUpdate = ObjForm.GetValue("u_SendTime")
		If Not SMSEmailQueue.IsSent.FldIsDetailKey Then SMSEmailQueue.IsSent.FormValue = ObjForm.GetValue("x_IsSent")
		SMSEmailQueue.IsSent.MultiUpdate = ObjForm.GetValue("u_IsSent")
		If Not SMSEmailQueue.PlanSendDate.FldIsDetailKey Then SMSEmailQueue.PlanSendDate.FormValue = ObjForm.GetValue("x_PlanSendDate")
		If Not SMSEmailQueue.PlanSendDate.FldIsDetailKey Then SMSEmailQueue.PlanSendDate.CurrentValue = ew_UnFormatDateTime(SMSEmailQueue.PlanSendDate.CurrentValue, 9)
		SMSEmailQueue.PlanSendDate.MultiUpdate = ObjForm.GetValue("u_PlanSendDate")
		If Not SMSEmailQueue.SendType.FldIsDetailKey Then SMSEmailQueue.SendType.FormValue = ObjForm.GetValue("x_SendType")
		SMSEmailQueue.SendType.MultiUpdate = ObjForm.GetValue("u_SendType")
		If Not SMSEmailQueue.BusinessDetailID.FldIsDetailKey Then SMSEmailQueue.BusinessDetailID.FormValue = ObjForm.GetValue("x_BusinessDetailID")
		SMSEmailQueue.BusinessDetailID.MultiUpdate = ObjForm.GetValue("u_BusinessDetailID")
		If Not SMSEmailQueue.ID.FldIsDetailKey Then SMSEmailQueue.ID.FormValue = ObjForm.GetValue("x_ID")
	End Function

	' -----------------------------------------------------------------
	' Restore form values
	'
	Function RestoreFormValues()
		SMSEmailQueue.ToEmailAddress.CurrentValue = SMSEmailQueue.ToEmailAddress.FormValue
		SMSEmailQueue.PhoneNumber.CurrentValue = SMSEmailQueue.PhoneNumber.FormValue
		SMSEmailQueue.Content.CurrentValue = SMSEmailQueue.Content.FormValue
		SMSEmailQueue.SendTime.CurrentValue = SMSEmailQueue.SendTime.FormValue
		SMSEmailQueue.SendTime.CurrentValue = ew_UnFormatDateTime(SMSEmailQueue.SendTime.CurrentValue, 9)
		SMSEmailQueue.IsSent.CurrentValue = SMSEmailQueue.IsSent.FormValue
		SMSEmailQueue.PlanSendDate.CurrentValue = SMSEmailQueue.PlanSendDate.FormValue
		SMSEmailQueue.PlanSendDate.CurrentValue = ew_UnFormatDateTime(SMSEmailQueue.PlanSendDate.CurrentValue, 9)
		SMSEmailQueue.SendType.CurrentValue = SMSEmailQueue.SendType.FormValue
		SMSEmailQueue.BusinessDetailID.CurrentValue = SMSEmailQueue.BusinessDetailID.FormValue
		SMSEmailQueue.ID.CurrentValue = SMSEmailQueue.ID.FormValue
	End Function

	' -----------------------------------------------------------------
	' Load recordset
	'
	Function LoadRecordset()

		' Load list page sql
		Dim sSql
		sSql = SMSEmailQueue.SelectSQL
		Call ew_SetDebugMsg("LoadRecordset: " & sSql) ' Show SQL for debugging

		' Load recordset
		Dim RsRecordset
		Set RsRecordset = ew_LoadRecordset(sSql)

		' Call Recordset Selected event
		Call SMSEmailQueue.Recordset_Selected(RsRecordset)
		Set LoadRecordset = RsRecordset
	End Function

	' -----------------------------------------------------------------
	' Load row based on key values
	'
	Function LoadRow()
		Dim RsRow, sSql, sFilter
		sFilter = SMSEmailQueue.KeyFilter

		' Call Row Selecting event
		Call SMSEmailQueue.Row_Selecting(sFilter)

		' Load sql based on filter
		SMSEmailQueue.CurrentFilter = sFilter
		sSql = SMSEmailQueue.SQL
		Call ew_SetDebugMsg("LoadRow: " & sSql) ' Show SQL for debugging
		Set RsRow = ew_LoadRow(sSql)
		If RsRow.Eof Then
			LoadRow = False
		Else
			LoadRow = True
			RsRow.MoveFirst
			Call LoadRowValues(RsRow) ' Load row values
		End If
		RsRow.Close
		Set RsRow = Nothing
	End Function

	' -----------------------------------------------------------------
	' Load row values from recordset
	'
	Sub LoadRowValues(RsRow)
		Dim sDetailFilter
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		If RsRow.Eof Then Exit Sub

		' Call Row Selected event
		Call SMSEmailQueue.Row_Selected(RsRow)
		SMSEmailQueue.ID.DbValue = RsRow("ID")
		SMSEmailQueue.ToEmailAddress.DbValue = RsRow("ToEmailAddress")
		SMSEmailQueue.PhoneNumber.DbValue = RsRow("PhoneNumber")
		SMSEmailQueue.Content.DbValue = RsRow("Content")
		SMSEmailQueue.SendTime.DbValue = RsRow("SendTime")
		SMSEmailQueue.IsSent.DbValue = RsRow("IsSent")
		SMSEmailQueue.PlanSendDate.DbValue = RsRow("PlanSendDate")
		SMSEmailQueue.SendType.DbValue = RsRow("SendType")
		SMSEmailQueue.BusinessDetailID.DbValue = ew_Conv(RsRow("BusinessDetailID"), 131)
	End Sub

	' Load DbValue from recordset
	Sub LoadDbValues(Rs)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		If Rs.Eof Then Exit Sub
		SMSEmailQueue.ID.m_DbValue = Rs("ID")
		SMSEmailQueue.ToEmailAddress.m_DbValue = Rs("ToEmailAddress")
		SMSEmailQueue.PhoneNumber.m_DbValue = Rs("PhoneNumber")
		SMSEmailQueue.Content.m_DbValue = Rs("Content")
		SMSEmailQueue.SendTime.m_DbValue = Rs("SendTime")
		SMSEmailQueue.IsSent.m_DbValue = Rs("IsSent")
		SMSEmailQueue.PlanSendDate.m_DbValue = Rs("PlanSendDate")
		SMSEmailQueue.SendType.m_DbValue = Rs("SendType")
		SMSEmailQueue.BusinessDetailID.m_DbValue = ew_Conv(Rs("BusinessDetailID"), 131)
	End Sub

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

		' ----------
		'  Edit Row
		' ----------

		ElseIf SMSEmailQueue.RowType = EW_ROWTYPE_EDIT Then ' Edit row

			' ToEmailAddress
			SMSEmailQueue.ToEmailAddress.EditAttrs.UpdateAttribute "class", "form-control"
			SMSEmailQueue.ToEmailAddress.EditCustomAttributes = ""
			SMSEmailQueue.ToEmailAddress.EditValue = ew_HtmlEncode(SMSEmailQueue.ToEmailAddress.CurrentValue)
			SMSEmailQueue.ToEmailAddress.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(SMSEmailQueue.ToEmailAddress.FldCaption))

			' PhoneNumber
			SMSEmailQueue.PhoneNumber.EditAttrs.UpdateAttribute "class", "form-control"
			SMSEmailQueue.PhoneNumber.EditCustomAttributes = ""
			SMSEmailQueue.PhoneNumber.EditValue = ew_HtmlEncode(SMSEmailQueue.PhoneNumber.CurrentValue)
			SMSEmailQueue.PhoneNumber.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(SMSEmailQueue.PhoneNumber.FldCaption))

			' Content
			SMSEmailQueue.Content.EditAttrs.UpdateAttribute "class", "form-control"
			SMSEmailQueue.Content.EditCustomAttributes = ""
			SMSEmailQueue.Content.EditValue = ew_HtmlEncode(SMSEmailQueue.Content.CurrentValue)
			SMSEmailQueue.Content.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(SMSEmailQueue.Content.FldCaption))

			' SendTime
			SMSEmailQueue.SendTime.EditAttrs.UpdateAttribute "class", "form-control"
			SMSEmailQueue.SendTime.EditCustomAttributes = ""
			SMSEmailQueue.SendTime.EditValue = ew_FormatDateTime(SMSEmailQueue.SendTime.CurrentValue, 9)
			SMSEmailQueue.SendTime.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(SMSEmailQueue.SendTime.FldCaption))

			' IsSent
			SMSEmailQueue.IsSent.EditAttrs.UpdateAttribute "class", "form-control"
			SMSEmailQueue.IsSent.EditCustomAttributes = ""
			SMSEmailQueue.IsSent.EditValue = ew_HtmlEncode(SMSEmailQueue.IsSent.CurrentValue)
			SMSEmailQueue.IsSent.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(SMSEmailQueue.IsSent.FldCaption))

			' PlanSendDate
			SMSEmailQueue.PlanSendDate.EditAttrs.UpdateAttribute "class", "form-control"
			SMSEmailQueue.PlanSendDate.EditCustomAttributes = ""
			SMSEmailQueue.PlanSendDate.EditValue = ew_FormatDateTime(SMSEmailQueue.PlanSendDate.CurrentValue, 9)
			SMSEmailQueue.PlanSendDate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(SMSEmailQueue.PlanSendDate.FldCaption))

			' SendType
			SMSEmailQueue.SendType.EditAttrs.UpdateAttribute "class", "form-control"
			SMSEmailQueue.SendType.EditCustomAttributes = ""
			SMSEmailQueue.SendType.EditValue = ew_HtmlEncode(SMSEmailQueue.SendType.CurrentValue)
			SMSEmailQueue.SendType.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(SMSEmailQueue.SendType.FldCaption))

			' BusinessDetailID
			SMSEmailQueue.BusinessDetailID.EditAttrs.UpdateAttribute "class", "form-control"
			SMSEmailQueue.BusinessDetailID.EditCustomAttributes = ""
			SMSEmailQueue.BusinessDetailID.EditValue = ew_HtmlEncode(SMSEmailQueue.BusinessDetailID.CurrentValue)
			SMSEmailQueue.BusinessDetailID.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(SMSEmailQueue.BusinessDetailID.FldCaption))
			If SMSEmailQueue.BusinessDetailID.EditValue&"" <> "" And IsNumeric(SMSEmailQueue.BusinessDetailID.EditValue) Then SMSEmailQueue.BusinessDetailID.EditValue = ew_FormatNumber2(SMSEmailQueue.BusinessDetailID.EditValue, -2)

			' Edit refer script
			' ToEmailAddress

			SMSEmailQueue.ToEmailAddress.HrefValue = ""

			' PhoneNumber
			SMSEmailQueue.PhoneNumber.HrefValue = ""

			' Content
			SMSEmailQueue.Content.HrefValue = ""

			' SendTime
			SMSEmailQueue.SendTime.HrefValue = ""

			' IsSent
			SMSEmailQueue.IsSent.HrefValue = ""

			' PlanSendDate
			SMSEmailQueue.PlanSendDate.HrefValue = ""

			' SendType
			SMSEmailQueue.SendType.HrefValue = ""

			' BusinessDetailID
			SMSEmailQueue.BusinessDetailID.HrefValue = ""
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
	' Validate form
	'
	Function ValidateForm()

		' Initialize
		gsFormError = ""
		Dim lUpdateCnt
		lUpdateCnt = 0
		If SMSEmailQueue.ToEmailAddress.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If SMSEmailQueue.PhoneNumber.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If SMSEmailQueue.Content.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If SMSEmailQueue.SendTime.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If SMSEmailQueue.IsSent.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If SMSEmailQueue.PlanSendDate.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If SMSEmailQueue.SendType.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If SMSEmailQueue.BusinessDetailID.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If lUpdateCnt = 0 Then
			gsFormError = Language.Phrase("NoFieldSelected")
			ValidateForm = False
			Exit Function
		End If

		' Check if validation required
		If Not EW_SERVER_VALIDATE Then
			ValidateForm = (gsFormError = "")
			Exit Function
		End If
		If SMSEmailQueue.SendTime.MultiUpdate <> "" Then
			If Not ew_CheckDate(SMSEmailQueue.SendTime.FormValue) Then
				Call ew_AddMessage(gsFormError, SMSEmailQueue.SendTime.FldErrMsg)
			End If
		End If
		If SMSEmailQueue.IsSent.MultiUpdate <> "" And Not SMSEmailQueue.IsSent.FldIsDetailKey And Not IsNull(SMSEmailQueue.IsSent.FormValue) And SMSEmailQueue.IsSent.FormValue&"" = "" Then
			Call ew_AddMessage(gsFormError, Replace(SMSEmailQueue.IsSent.ReqErrMsg, "%s", SMSEmailQueue.IsSent.FldCaption))
		End If
		If SMSEmailQueue.IsSent.MultiUpdate <> "" Then
			If Not ew_CheckInteger(SMSEmailQueue.IsSent.FormValue) Then
				Call ew_AddMessage(gsFormError, SMSEmailQueue.IsSent.FldErrMsg)
			End If
		End If
		If SMSEmailQueue.PlanSendDate.MultiUpdate <> "" Then
			If Not ew_CheckDate(SMSEmailQueue.PlanSendDate.FormValue) Then
				Call ew_AddMessage(gsFormError, SMSEmailQueue.PlanSendDate.FldErrMsg)
			End If
		End If
		If SMSEmailQueue.BusinessDetailID.MultiUpdate <> "" Then
			If Not ew_CheckNumber(SMSEmailQueue.BusinessDetailID.FormValue) Then
				Call ew_AddMessage(gsFormError, SMSEmailQueue.BusinessDetailID.FldErrMsg)
			End If
		End If

		' Return validate result
		ValidateForm = (gsFormError = "")

		' Call Form Custom Validate event
		Dim sFormCustomError
		sFormCustomError = ""
		ValidateForm = ValidateForm And Form_CustomValidate(sFormCustomError)
		If sFormCustomError <> "" Then
			Call ew_AddMessage(gsFormError, sFormCustomError)
		End If
	End Function

	' -----------------------------------------------------------------
	' Update record based on key values
	'
	Function EditRow()
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		Dim Rs, sSql, sFilter
		Dim RsChk, sSqlChk, sFilterChk
		Dim bUpdateRow
		Dim RsOld, RsNew
		Dim sIdxErrMsg

		' Clear any previous errors
		Err.Clear
		sFilter = SMSEmailQueue.KeyFilter
		SMSEmailQueue.CurrentFilter  = sFilter
		sSql = SMSEmailQueue.SQL
		Set Rs = Server.CreateObject("ADODB.Recordset")
		Rs.CursorLocation = EW_CURSORLOCATION
		Rs.Open sSql, Conn, 1, EW_RECORDSET_LOCKTYPE
		If Err.Number <> 0 Then
			Message = Err.Description
			Rs.Close
			Set Rs = Nothing
			EditRow = False
			Exit Function
		End If

		' Clone old recordset object
		Set RsOld = ew_CloneRs(Rs)
		Call LoadDbValues(RsOld)
		If Rs.Eof Then
			EditRow = False ' Update Failed
		Else

			' Field ToEmailAddress
			Call SMSEmailQueue.ToEmailAddress.SetDbValue(Rs, SMSEmailQueue.ToEmailAddress.CurrentValue, Null, SMSEmailQueue.ToEmailAddress.ReadOnly Or SMSEmailQueue.ToEmailAddress.MultiUpdate&"" <> "1")

			' Field PhoneNumber
			Call SMSEmailQueue.PhoneNumber.SetDbValue(Rs, SMSEmailQueue.PhoneNumber.CurrentValue, Null, SMSEmailQueue.PhoneNumber.ReadOnly Or SMSEmailQueue.PhoneNumber.MultiUpdate&"" <> "1")

			' Field Content
			Call SMSEmailQueue.Content.SetDbValue(Rs, SMSEmailQueue.Content.CurrentValue, Null, SMSEmailQueue.Content.ReadOnly Or SMSEmailQueue.Content.MultiUpdate&"" <> "1")

			' Field SendTime
			Call SMSEmailQueue.SendTime.SetDbValue(Rs, ew_UnFormatDateTime(SMSEmailQueue.SendTime.CurrentValue, 9), Null, SMSEmailQueue.SendTime.ReadOnly Or SMSEmailQueue.SendTime.MultiUpdate&"" <> "1")

			' Field IsSent
			Call SMSEmailQueue.IsSent.SetDbValue(Rs, SMSEmailQueue.IsSent.CurrentValue, 0, SMSEmailQueue.IsSent.ReadOnly Or SMSEmailQueue.IsSent.MultiUpdate&"" <> "1")

			' Field PlanSendDate
			Call SMSEmailQueue.PlanSendDate.SetDbValue(Rs, ew_UnFormatDateTime(SMSEmailQueue.PlanSendDate.CurrentValue, 9), Null, SMSEmailQueue.PlanSendDate.ReadOnly Or SMSEmailQueue.PlanSendDate.MultiUpdate&"" <> "1")

			' Field SendType
			Call SMSEmailQueue.SendType.SetDbValue(Rs, SMSEmailQueue.SendType.CurrentValue, Null, SMSEmailQueue.SendType.ReadOnly Or SMSEmailQueue.SendType.MultiUpdate&"" <> "1")

			' Field BusinessDetailID
			Call SMSEmailQueue.BusinessDetailID.SetDbValue(Rs, SMSEmailQueue.BusinessDetailID.CurrentValue, Null, SMSEmailQueue.BusinessDetailID.ReadOnly Or SMSEmailQueue.BusinessDetailID.MultiUpdate&"" <> "1")

			' Check recordset update error
			If Err.Number <> 0 Then
				FailureMessage = Err.Description
				Rs.Close
				Set Rs = Nothing
				EditRow = False
				Exit Function
			End If

			' Call Row Updating event
			bUpdateRow = SMSEmailQueue.Row_Updating(RsOld, Rs)
			If bUpdateRow Then

				' Clone new recordset object
				Set RsNew = ew_CloneRs(Rs)
				EditRow = True
				If EditRow Then
					Rs.Update
				End If
				If Err.Number <> 0 Or Not EditRow Then
					If Err.Description <> "" Then FailureMessage = Err.Description
					EditRow = False
				Else
					EditRow = True
				End If
				If EditRow Then
				End If
			Else
				Rs.CancelUpdate

				' Set up error message
				If SuccessMessage <> "" Or FailureMessage <> "" Then

					' Use the message, do nothing
				ElseIf SMSEmailQueue.CancelMessage <> "" Then
					FailureMessage = SMSEmailQueue.CancelMessage
					SMSEmailQueue.CancelMessage = ""
				Else
					FailureMessage = Language.Phrase("UpdateCancelled")
				End If
				EditRow = False
			End If
		End If

		' Call Row Updated event
		If EditRow Then
			Call SMSEmailQueue.Row_Updated(RsOld, RsNew)
		End If
		Rs.Close
		Set Rs = Nothing
		If IsObject(RsOld) Then
			RsOld.Close
			Set RsOld = Nothing
		End If
		If IsObject(RsNew) Then
			RsNew.Close
			Set RsNew = Nothing
		End If
	End Function

	' Set up Breadcrumb
	Sub SetupBreadcrumb()
		Dim PageId, url
		Set Breadcrumb = New cBreadcrumb
		url = Mid(ew_CurrentUrl, InStrRev(ew_CurrentUrl, "/")+1)
		Call Breadcrumb.Add("list", SMSEmailQueue.TableVar, "SMSEmailQueuelist.asp", "", SMSEmailQueue.TableVar, True)
		PageId = "update"
		Call Breadcrumb.Add("update", PageId, url, "", "", False)
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
