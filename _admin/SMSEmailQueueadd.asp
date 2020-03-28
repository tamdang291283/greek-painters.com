﻿<%@ CodePage="65001" %>
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
Dim SMSEmailQueue_add
Set SMSEmailQueue_add = New cSMSEmailQueue_add
Set Page = SMSEmailQueue_add

' Page init processing
SMSEmailQueue_add.Page_Init()

' Page main processing
SMSEmailQueue_add.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
SMSEmailQueue_add.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var SMSEmailQueue_add = new ew_Page("SMSEmailQueue_add");
SMSEmailQueue_add.PageID = "add"; // Page ID
var EW_PAGE_ID = SMSEmailQueue_add.PageID; // For backward compatibility
// Form object
var fSMSEmailQueueadd = new ew_Form("fSMSEmailQueueadd");
// Validate form
fSMSEmailQueueadd.Validate = function() {
	if (!this.ValidateRequired)
		return true; // Ignore validation
	var $ = jQuery, fobj = this.GetForm(), $fobj = $(fobj);
	this.PostAutoSuggest();
	if ($fobj.find("#a_confirm").val() == "F")
		return true;
	var elm, felm, uelm, addcnt = 0;
	var $k = $fobj.find("#" + this.FormKeyCountName); // Get key_count
	var rowcnt = ($k[0]) ? parseInt($k.val(), 10) : 1;
	var startcnt = (rowcnt == 0) ? 0 : 1; // Check rowcnt == 0 => Inline-Add
	var gridinsert = $fobj.find("#a_list").val() == "gridinsert";
	for (var i = startcnt; i <= rowcnt; i++) {
		var infix = ($k[0]) ? String(i) : "";
		$fobj.data("rowindex", infix);
			elm = this.GetElements("x" + infix + "_IsSent");
			if (elm && !ew_CheckInteger(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(SMSEmailQueue.IsSent.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_BusinessDetailID");
			if (elm && !ew_CheckNumber(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(SMSEmailQueue.BusinessDetailID.FldErrMsg) %>");
			// Set up row object
			ew_ElementsToRow(fobj);
			// Fire Form_CustomValidate event
			if (!this.Form_CustomValidate(fobj))
				return false;
	}
	// Process detail forms
	var dfs = $fobj.find("input[name='detailpage']").get();
	for (var i = 0; i < dfs.length; i++) {
		var df = dfs[i], val = df.value;
		if (val && ewForms[val])
			if (!ewForms[val].Validate())
				return false;
	}
	return true;
}
// Form_CustomValidate event
fSMSEmailQueueadd.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fSMSEmailQueueadd.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fSMSEmailQueueadd.ValidateRequired = false; // No JavaScript validation
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
<% SMSEmailQueue_add.ShowPageHeader() %>
<% SMSEmailQueue_add.ShowMessage %>
<form name="fSMSEmailQueueadd" id="fSMSEmailQueueadd" class="form-horizontal ewForm ewAddForm" action="<%= ew_CurrentPage() %>" method="post">
<% If SMSEmailQueue_add.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= SMSEmailQueue_add.Token %>">
<% End If %>
<input type="hidden" name="t" value="SMSEmailQueue">
<input type="hidden" name="a_add" id="a_add" value="A">
<div>
<% If SMSEmailQueue.ToEmailAddress.Visible Then ' ToEmailAddress %>
	<div id="r_ToEmailAddress" class="form-group">
		<label id="elh_SMSEmailQueue_ToEmailAddress" for="x_ToEmailAddress" class="col-sm-2 control-label ewLabel"><%= SMSEmailQueue.ToEmailAddress.FldCaption %></label>
		<div class="col-sm-10"><div<%= SMSEmailQueue.ToEmailAddress.CellAttributes %>>
<span id="el_SMSEmailQueue_ToEmailAddress">
<input type="text" data-field="x_ToEmailAddress" name="x_ToEmailAddress" id="x_ToEmailAddress" size="30" maxlength="50" placeholder="<%= SMSEmailQueue.ToEmailAddress.PlaceHolder %>" value="<%= SMSEmailQueue.ToEmailAddress.EditValue %>"<%= SMSEmailQueue.ToEmailAddress.EditAttributes %>>
</span>
<%= SMSEmailQueue.ToEmailAddress.CustomMsg %></div></div>
	</div>
<% End If %>
<% If SMSEmailQueue.PhoneNumber.Visible Then ' PhoneNumber %>
	<div id="r_PhoneNumber" class="form-group">
		<label id="elh_SMSEmailQueue_PhoneNumber" for="x_PhoneNumber" class="col-sm-2 control-label ewLabel"><%= SMSEmailQueue.PhoneNumber.FldCaption %></label>
		<div class="col-sm-10"><div<%= SMSEmailQueue.PhoneNumber.CellAttributes %>>
<span id="el_SMSEmailQueue_PhoneNumber">
<input type="text" data-field="x_PhoneNumber" name="x_PhoneNumber" id="x_PhoneNumber" size="30" maxlength="20" placeholder="<%= SMSEmailQueue.PhoneNumber.PlaceHolder %>" value="<%= SMSEmailQueue.PhoneNumber.EditValue %>"<%= SMSEmailQueue.PhoneNumber.EditAttributes %>>
</span>
<%= SMSEmailQueue.PhoneNumber.CustomMsg %></div></div>
	</div>
<% End If %>
<% If SMSEmailQueue.Content.Visible Then ' Content %>
	<div id="r_Content" class="form-group">
		<label id="elh_SMSEmailQueue_Content" for="x_Content" class="col-sm-2 control-label ewLabel"><%= SMSEmailQueue.Content.FldCaption %></label>
		<div class="col-sm-10"><div<%= SMSEmailQueue.Content.CellAttributes %>>
<span id="el_SMSEmailQueue_Content">
<input type="text" data-field="x_Content" name="x_Content" id="x_Content" size="30" maxlength="255" placeholder="<%= SMSEmailQueue.Content.PlaceHolder %>" value="<%= SMSEmailQueue.Content.EditValue %>"<%= SMSEmailQueue.Content.EditAttributes %>>
</span>
<%= SMSEmailQueue.Content.CustomMsg %></div></div>
	</div>
<% End If %>
<% If SMSEmailQueue.SendTime.Visible Then ' SendTime %>
	<div id="r_SendTime" class="form-group">
		<label id="elh_SMSEmailQueue_SendTime" for="x_SendTime" class="col-sm-2 control-label ewLabel"><%= SMSEmailQueue.SendTime.FldCaption %></label>
		<div class="col-sm-10"><div<%= SMSEmailQueue.SendTime.CellAttributes %>>
<span id="el_SMSEmailQueue_SendTime">
<input type="text" data-field="x_SendTime" name="x_SendTime" id="x_SendTime" placeholder="<%= SMSEmailQueue.SendTime.PlaceHolder %>" value="<%= SMSEmailQueue.SendTime.EditValue %>"<%= SMSEmailQueue.SendTime.EditAttributes %>>
</span>
<%= SMSEmailQueue.SendTime.CustomMsg %></div></div>
	</div>
<% End If %>
<% If SMSEmailQueue.IsSent.Visible Then ' IsSent %>
	<div id="r_IsSent" class="form-group">
		<label id="elh_SMSEmailQueue_IsSent" for="x_IsSent" class="col-sm-2 control-label ewLabel"><%= SMSEmailQueue.IsSent.FldCaption %></label>
		<div class="col-sm-10"><div<%= SMSEmailQueue.IsSent.CellAttributes %>>
<span id="el_SMSEmailQueue_IsSent">
<input type="text" data-field="x_IsSent" name="x_IsSent" id="x_IsSent" size="30" placeholder="<%= SMSEmailQueue.IsSent.PlaceHolder %>" value="<%= SMSEmailQueue.IsSent.EditValue %>"<%= SMSEmailQueue.IsSent.EditAttributes %>>
</span>
<%= SMSEmailQueue.IsSent.CustomMsg %></div></div>
	</div>
<% End If %>
<% If SMSEmailQueue.PlanSendDate.Visible Then ' PlanSendDate %>
	<div id="r_PlanSendDate" class="form-group">
		<label id="elh_SMSEmailQueue_PlanSendDate" for="x_PlanSendDate" class="col-sm-2 control-label ewLabel"><%= SMSEmailQueue.PlanSendDate.FldCaption %></label>
		<div class="col-sm-10"><div<%= SMSEmailQueue.PlanSendDate.CellAttributes %>>
<span id="el_SMSEmailQueue_PlanSendDate">
<input type="text" data-field="x_PlanSendDate" name="x_PlanSendDate" id="x_PlanSendDate" placeholder="<%= SMSEmailQueue.PlanSendDate.PlaceHolder %>" value="<%= SMSEmailQueue.PlanSendDate.EditValue %>"<%= SMSEmailQueue.PlanSendDate.EditAttributes %>>
</span>
<%= SMSEmailQueue.PlanSendDate.CustomMsg %></div></div>
	</div>
<% End If %>
<% If SMSEmailQueue.SendType.Visible Then ' SendType %>
	<div id="r_SendType" class="form-group">
		<label id="elh_SMSEmailQueue_SendType" for="x_SendType" class="col-sm-2 control-label ewLabel"><%= SMSEmailQueue.SendType.FldCaption %></label>
		<div class="col-sm-10"><div<%= SMSEmailQueue.SendType.CellAttributes %>>
<span id="el_SMSEmailQueue_SendType">
<input type="text" data-field="x_SendType" name="x_SendType" id="x_SendType" size="30" maxlength="10" placeholder="<%= SMSEmailQueue.SendType.PlaceHolder %>" value="<%= SMSEmailQueue.SendType.EditValue %>"<%= SMSEmailQueue.SendType.EditAttributes %>>
</span>
<%= SMSEmailQueue.SendType.CustomMsg %></div></div>
	</div>
<% End If %>
<% If SMSEmailQueue.BusinessDetailID.Visible Then ' BusinessDetailID %>
	<div id="r_BusinessDetailID" class="form-group">
		<label id="elh_SMSEmailQueue_BusinessDetailID" for="x_BusinessDetailID" class="col-sm-2 control-label ewLabel"><%= SMSEmailQueue.BusinessDetailID.FldCaption %></label>
		<div class="col-sm-10"><div<%= SMSEmailQueue.BusinessDetailID.CellAttributes %>>
<span id="el_SMSEmailQueue_BusinessDetailID">
<input type="text" data-field="x_BusinessDetailID" name="x_BusinessDetailID" id="x_BusinessDetailID" size="30" placeholder="<%= SMSEmailQueue.BusinessDetailID.PlaceHolder %>" value="<%= SMSEmailQueue.BusinessDetailID.EditValue %>"<%= SMSEmailQueue.BusinessDetailID.EditAttributes %>>
</span>
<%= SMSEmailQueue.BusinessDetailID.CustomMsg %></div></div>
	</div>
<% End If %>
</div>
<div class="form-group">
	<div class="col-sm-offset-2 col-sm-10">
<button class="btn btn-primary ewButton" name="btnAction" id="btnAction" type="submit"><%= Language.Phrase("AddBtn") %></button>
	</div>
</div>
</form>
<script type="text/javascript">
fSMSEmailQueueadd.Init();
</script>
<%
SMSEmailQueue_add.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set SMSEmailQueue_add = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cSMSEmailQueue_add

	' Page ID
	Public Property Get PageID()
		PageID = "add"
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
		PageObjName = "SMSEmailQueue_add"
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
		EW_PAGE_ID = "add"

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

	Dim DbMasterFilter, DbDetailFilter
	Dim StartRec
	Dim Priv
	Dim OldRecordset
	Dim CopyRecord

	' -----------------------------------------------------------------
	' Page main processing
	'
	Sub Page_Main()

		' Process form if post back
		If ObjForm.GetValue("a_add")&"" <> "" Then
			SMSEmailQueue.CurrentAction = ObjForm.GetValue("a_add") ' Get form action
			CopyRecord = LoadOldRecord() ' Load old recordset
			Call LoadFormValues() ' Load form values

		' Not post back
		Else

			' Load key values from QueryString
			CopyRecord = True
			If Request.QueryString("ID").Count > 0 Then
				SMSEmailQueue.ID.QueryStringValue = Request.QueryString("ID")
				Call SMSEmailQueue.SetKey("ID", SMSEmailQueue.ID.CurrentValue) ' Set up key
			Else
				Call SMSEmailQueue.SetKey("ID", "") ' Clear key
				CopyRecord = False
			End If
			If CopyRecord Then
				SMSEmailQueue.CurrentAction = "C" ' Copy Record
			Else
				SMSEmailQueue.CurrentAction = "I" ' Display Blank Record
				Call LoadDefaultValues() ' Load default values
			End If
		End If

		' Set up Breadcrumb
		SetupBreadcrumb()

		' Validate form if post back
		If ObjForm.GetValue("a_add")&"" <> "" Then
			If Not ValidateForm() Then
				SMSEmailQueue.CurrentAction = "I" ' Form error, reset action
				SMSEmailQueue.EventCancelled = True ' Event cancelled
				Call RestoreFormValues() ' Restore form values
				FailureMessage = gsFormError
			End If
		End If

		' Perform action based on action code
		Select Case SMSEmailQueue.CurrentAction
			Case "I" ' Blank record, no action required
			Case "C" ' Copy an existing record
				If Not LoadRow() Then ' Load record based on key
					If FailureMessage = "" Then FailureMessage = Language.Phrase("NoRecord") ' No record found
					Call Page_Terminate("SMSEmailQueuelist.asp") ' No matching record, return to list
				End If
			Case "A" ' Add new record
				SMSEmailQueue.SendEmail = True ' Send email on add success
				If AddRow(OldRecordset) Then ' Add successful
					If SuccessMessage = "" Then SuccessMessage = Language.Phrase("AddSuccess") ' Set up success message
					Dim sReturnUrl
					sReturnUrl = SMSEmailQueue.ReturnUrl
					If ew_GetPageName(sReturnUrl) = "SMSEmailQueueview.asp" Then sReturnUrl = SMSEmailQueue.ViewUrl("") ' View paging, return to view page with keyurl directly
					Call Page_Terminate(sReturnUrl) ' Clean up and return
				Else
					SMSEmailQueue.EventCancelled = True ' Event cancelled
					Call RestoreFormValues() ' Add failed, restore form values
				End If
		End Select

		' Render row based on row type
		SMSEmailQueue.RowType = EW_ROWTYPE_ADD ' Render add type

		' Render row
		Call SMSEmailQueue.ResetAttrs()
		Call RenderRow()
	End Sub

	' -----------------------------------------------------------------
	' Function Get upload files
	'
	Function GetUploadFiles()

		' Get upload data
	End Function

	' -----------------------------------------------------------------
	' Load default values
	'
	Function LoadDefaultValues()
		SMSEmailQueue.ToEmailAddress.CurrentValue = Null
		SMSEmailQueue.ToEmailAddress.OldValue = SMSEmailQueue.ToEmailAddress.CurrentValue
		SMSEmailQueue.PhoneNumber.CurrentValue = Null
		SMSEmailQueue.PhoneNumber.OldValue = SMSEmailQueue.PhoneNumber.CurrentValue
		SMSEmailQueue.Content.CurrentValue = Null
		SMSEmailQueue.Content.OldValue = SMSEmailQueue.Content.CurrentValue
		SMSEmailQueue.SendTime.CurrentValue = Null
		SMSEmailQueue.SendTime.OldValue = SMSEmailQueue.SendTime.CurrentValue
		SMSEmailQueue.IsSent.CurrentValue = Null
		SMSEmailQueue.IsSent.OldValue = SMSEmailQueue.IsSent.CurrentValue
		SMSEmailQueue.PlanSendDate.CurrentValue = Null
		SMSEmailQueue.PlanSendDate.OldValue = SMSEmailQueue.PlanSendDate.CurrentValue
		SMSEmailQueue.SendType.CurrentValue = Null
		SMSEmailQueue.SendType.OldValue = SMSEmailQueue.SendType.CurrentValue
		SMSEmailQueue.BusinessDetailID.CurrentValue = Null
		SMSEmailQueue.BusinessDetailID.OldValue = SMSEmailQueue.BusinessDetailID.CurrentValue
	End Function

	' -----------------------------------------------------------------
	' Load form values
	'
	Function LoadFormValues()

		' Load values from form
		If Not SMSEmailQueue.ToEmailAddress.FldIsDetailKey Then SMSEmailQueue.ToEmailAddress.FormValue = ObjForm.GetValue("x_ToEmailAddress")
		If Not SMSEmailQueue.PhoneNumber.FldIsDetailKey Then SMSEmailQueue.PhoneNumber.FormValue = ObjForm.GetValue("x_PhoneNumber")
		If Not SMSEmailQueue.Content.FldIsDetailKey Then SMSEmailQueue.Content.FormValue = ObjForm.GetValue("x_Content")
		If Not SMSEmailQueue.SendTime.FldIsDetailKey Then SMSEmailQueue.SendTime.FormValue = ObjForm.GetValue("x_SendTime")
		If Not SMSEmailQueue.SendTime.FldIsDetailKey Then SMSEmailQueue.SendTime.CurrentValue = ew_UnFormatDateTime(SMSEmailQueue.SendTime.CurrentValue, 9)
		If Not SMSEmailQueue.IsSent.FldIsDetailKey Then SMSEmailQueue.IsSent.FormValue = ObjForm.GetValue("x_IsSent")
		If Not SMSEmailQueue.PlanSendDate.FldIsDetailKey Then SMSEmailQueue.PlanSendDate.FormValue = ObjForm.GetValue("x_PlanSendDate")
		If Not SMSEmailQueue.PlanSendDate.FldIsDetailKey Then SMSEmailQueue.PlanSendDate.CurrentValue = ew_UnFormatDateTime(SMSEmailQueue.PlanSendDate.CurrentValue, 9)
		If Not SMSEmailQueue.SendType.FldIsDetailKey Then SMSEmailQueue.SendType.FormValue = ObjForm.GetValue("x_SendType")
		If Not SMSEmailQueue.BusinessDetailID.FldIsDetailKey Then SMSEmailQueue.BusinessDetailID.FormValue = ObjForm.GetValue("x_BusinessDetailID")
	End Function

	' -----------------------------------------------------------------
	' Restore form values
	'
	Function RestoreFormValues()
		Call LoadOldRecord()
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

	' Load old record
	Function LoadOldRecord()

		' Load key values from Session
		Dim bValidKey
		bValidKey = True
		If SMSEmailQueue.GetKey("ID")&"" <> "" Then
			SMSEmailQueue.ID.CurrentValue = SMSEmailQueue.GetKey("ID") ' ID
		Else
			bValidKey = False
		End If

		' Load old recordset
		If bValidKey Then
			SMSEmailQueue.CurrentFilter = SMSEmailQueue.KeyFilter
			Dim sSql
			sSql = SMSEmailQueue.SQL
			Set OldRecordset = ew_LoadRecordset(sSql)
			Call LoadRowValues(OldRecordset) ' Load row values
		Else
			OldRecordset = Null
		End If
		LoadOldRecord = bValidKey
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
			SMSEmailQueue.SendTime.ViewCustomAttributes = ""

			' IsSent
			SMSEmailQueue.IsSent.ViewValue = SMSEmailQueue.IsSent.CurrentValue
			SMSEmailQueue.IsSent.ViewCustomAttributes = ""

			' PlanSendDate
			SMSEmailQueue.PlanSendDate.ViewValue = SMSEmailQueue.PlanSendDate.CurrentValue
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

		' ---------
		'  Add Row
		' ---------

		ElseIf SMSEmailQueue.RowType = EW_ROWTYPE_ADD Then ' Add row

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
			SMSEmailQueue.SendTime.EditValue = ew_HtmlEncode(SMSEmailQueue.SendTime.CurrentValue)
			SMSEmailQueue.SendTime.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(SMSEmailQueue.SendTime.FldCaption))

			' IsSent
			SMSEmailQueue.IsSent.EditAttrs.UpdateAttribute "class", "form-control"
			SMSEmailQueue.IsSent.EditCustomAttributes = ""
			SMSEmailQueue.IsSent.EditValue = ew_HtmlEncode(SMSEmailQueue.IsSent.CurrentValue)
			SMSEmailQueue.IsSent.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(SMSEmailQueue.IsSent.FldCaption))

			' PlanSendDate
			SMSEmailQueue.PlanSendDate.EditAttrs.UpdateAttribute "class", "form-control"
			SMSEmailQueue.PlanSendDate.EditCustomAttributes = ""
			SMSEmailQueue.PlanSendDate.EditValue = ew_HtmlEncode(SMSEmailQueue.PlanSendDate.CurrentValue)
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

		' Check if validation required
		If Not EW_SERVER_VALIDATE Then
			ValidateForm = (gsFormError = "")
			Exit Function
		End If
		If Not ew_CheckInteger(SMSEmailQueue.IsSent.FormValue) Then
			Call ew_AddMessage(gsFormError, SMSEmailQueue.IsSent.FldErrMsg)
		End If
		If Not ew_CheckNumber(SMSEmailQueue.BusinessDetailID.FormValue) Then
			Call ew_AddMessage(gsFormError, SMSEmailQueue.BusinessDetailID.FldErrMsg)
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
	' Add record
	'
	Function AddRow(RsOld)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		Dim Rs, sSql, sFilter
		Dim RsNew
		Dim bInsertRow
		Dim RsChk
		Dim sIdxErrMsg

		' Clear any previous errors
		Err.Clear
		Dim RsMaster, sMasterUserIdMsg, sMasterFilter, bCheckMasterRecord

		' Load db values from rsold
		If Not IsNull(RsOld) Then
			Call LoadDbValues(RsOld)
		End If

		' Add new record
		sFilter = "(0 = 1)"
		SMSEmailQueue.CurrentFilter = sFilter
		sSql = SMSEmailQueue.SQL
		Set Rs = Server.CreateObject("ADODB.Recordset")
		Rs.CursorLocation = EW_CURSORLOCATION
		Rs.Open sSql, Conn, 1, EW_RECORDSET_LOCKTYPE
		Rs.AddNew
		If Err.Number <> 0 Then
			Message = Err.Description
			Rs.Close
			Set Rs = Nothing
			AddRow = False
			Exit Function
		End If

		' Field ToEmailAddress
		Call SMSEmailQueue.ToEmailAddress.SetDbValue(Rs, SMSEmailQueue.ToEmailAddress.CurrentValue, Null, False)

		' Field PhoneNumber
		Call SMSEmailQueue.PhoneNumber.SetDbValue(Rs, SMSEmailQueue.PhoneNumber.CurrentValue, Null, False)

		' Field Content
		Call SMSEmailQueue.Content.SetDbValue(Rs, SMSEmailQueue.Content.CurrentValue, Null, False)

		' Field SendTime
		Call SMSEmailQueue.SendTime.SetDbValue(Rs, SMSEmailQueue.SendTime.CurrentValue, Null, False)

		' Field IsSent
		Call SMSEmailQueue.IsSent.SetDbValue(Rs, SMSEmailQueue.IsSent.CurrentValue, Null, False)

		' Field PlanSendDate
		Call SMSEmailQueue.PlanSendDate.SetDbValue(Rs, SMSEmailQueue.PlanSendDate.CurrentValue, Null, False)

		' Field SendType
		Call SMSEmailQueue.SendType.SetDbValue(Rs, SMSEmailQueue.SendType.CurrentValue, Null, False)

		' Field BusinessDetailID
		Call SMSEmailQueue.BusinessDetailID.SetDbValue(Rs, SMSEmailQueue.BusinessDetailID.CurrentValue, Null, False)

		' Check recordset update error
		If Err.Number <> 0 Then
			FailureMessage = Err.Description
			Rs.Close
			Set Rs = Nothing
			AddRow = False
			Exit Function
		End If

		' Call Row Inserting event
		bInsertRow = SMSEmailQueue.Row_Inserting(RsOld, Rs)
		If bInsertRow Then

			' Clone new recordset object
			Set RsNew = ew_CloneRs(Rs)
			Rs.Update
			If Err.Number <> 0 Then
				FailureMessage = Err.Description
				AddRow = False
			Else
				AddRow = True
			End If
			If AddRow Then
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
				FailureMessage = Language.Phrase("InsertCancelled")
			End If
			AddRow = False
		End If
		Rs.Close
		Set Rs = Nothing
		If AddRow Then
			SMSEmailQueue.ID.DbValue = RsNew("ID")
		End If
		If AddRow Then

			' Call Row Inserted event
			Call SMSEmailQueue.Row_Inserted(RsOld, RsNew)
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
		PageId = ew_IIf(SMSEmailQueue.CurrentAction = "C", "Copy", "Add")
		Call Breadcrumb.Add("add", PageId, url, "", "", False)
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
