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
Dim sysadmin_edit
Set sysadmin_edit = New csysadmin_edit
Set Page = sysadmin_edit

' Page init processing
sysadmin_edit.Page_Init()

' Page main processing
sysadmin_edit.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
sysadmin_edit.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var sysadmin_edit = new ew_Page("sysadmin_edit");
sysadmin_edit.PageID = "edit"; // Page ID
var EW_PAGE_ID = sysadmin_edit.PageID; // For backward compatibility
// Form object
var fsysadminedit = new ew_Form("fsysadminedit");
// Validate form
fsysadminedit.Validate = function() {
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
fsysadminedit.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fsysadminedit.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fsysadminedit.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<div class="ewToolbar">
<% If sysadmin.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If sysadmin.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% sysadmin_edit.ShowPageHeader() %>
<% sysadmin_edit.ShowMessage %>
<form name="fsysadminedit" id="fsysadminedit" class="form-horizontal ewForm ewEditForm" action="<%= ew_CurrentPage %>" method="post">
<% If sysadmin_edit.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= sysadmin_edit.Token %>">
<% End If %>
<input type="hidden" name="a_table" id="a_table" value="sysadmin">
<input type="hidden" name="a_edit" id="a_edit" value="U">
<input type="hidden" name="k_hash" id="k_hash" value="<%= sysadmin_edit.HashValue %>">
<% If sysadmin.CurrentAction = "F" Then ' Confirm page %>
<input type="hidden" name="a_confirm" id="a_confirm" value="F">
<% End If %>
<div>
<% If sysadmin.ID.Visible Then ' ID %>
	<div id="r_ID" class="form-group">
		<label id="elh_sysadmin_ID" class="col-sm-2 control-label ewLabel"><%= sysadmin.ID.FldCaption %></label>
		<div class="col-sm-10"><div<%= sysadmin.ID.CellAttributes %>>
<% If sysadmin.CurrentAction <> "F" Then %>
<span id="el_sysadmin_ID">
<span<%= sysadmin.ID.ViewAttributes %>>
<p class="form-control-static"><%= sysadmin.ID.EditValue %></p>
</span>
</span>
<input type="hidden" data-field="x_ID" name="x_ID" id="x_ID" value="<%= Server.HTMLEncode(sysadmin.ID.CurrentValue&"") %>">
<% Else %>
<span id="el_sysadmin_ID">
<span<%= sysadmin.ID.ViewAttributes %>>
<p class="form-control-static"><%= sysadmin.ID.ViewValue %></p>
</span>
</span>
<input type="hidden" data-field="x_ID" name="x_ID" id="x_ID" value="<%= Server.HTMLEncode(sysadmin.ID.FormValue&"") %>">
<% End If %>
<%= sysadmin.ID.CustomMsg %></div></div>
	</div>
<% End If %>
<% If sysadmin.username.Visible Then ' username %>
	<div id="r_username" class="form-group">
		<label id="elh_sysadmin_username" for="x_username" class="col-sm-2 control-label ewLabel"><%= sysadmin.username.FldCaption %></label>
		<div class="col-sm-10"><div<%= sysadmin.username.CellAttributes %>>
<% If sysadmin.CurrentAction <> "F" Then %>
<span id="el_sysadmin_username">
<input type="text" data-field="x_username" name="x_username" id="x_username" size="30" maxlength="255" placeholder="<%= sysadmin.username.PlaceHolder %>" value="<%= sysadmin.username.EditValue %>"<%= sysadmin.username.EditAttributes %>>
</span>
<% Else %>
<span id="el_sysadmin_username">
<span<%= sysadmin.username.ViewAttributes %>>
<p class="form-control-static"><%= sysadmin.username.ViewValue %></p>
</span>
</span>
<input type="hidden" data-field="x_username" name="x_username" id="x_username" value="<%= Server.HTMLEncode(sysadmin.username.FormValue&"") %>">
<% End If %>
<%= sysadmin.username.CustomMsg %></div></div>
	</div>
<% End If %>
<% If sysadmin.pswd.Visible Then ' pswd %>
	<div id="r_pswd" class="form-group">
		<label id="elh_sysadmin_pswd" for="x_pswd" class="col-sm-2 control-label ewLabel"><%= sysadmin.pswd.FldCaption %></label>
		<div class="col-sm-10"><div<%= sysadmin.pswd.CellAttributes %>>
<% If sysadmin.CurrentAction <> "F" Then %>
<span id="el_sysadmin_pswd">
<input type="text" data-field="x_pswd" name="x_pswd" id="x_pswd" size="30" maxlength="255" placeholder="<%= sysadmin.pswd.PlaceHolder %>" value="<%= sysadmin.pswd.EditValue %>"<%= sysadmin.pswd.EditAttributes %>>
</span>
<% Else %>
<span id="el_sysadmin_pswd">
<span<%= sysadmin.pswd.ViewAttributes %>>
<p class="form-control-static"><%= sysadmin.pswd.ViewValue %></p>
</span>
</span>
<input type="hidden" data-field="x_pswd" name="x_pswd" id="x_pswd" value="<%= Server.HTMLEncode(sysadmin.pswd.FormValue&"") %>">
<% End If %>
<%= sysadmin.pswd.CustomMsg %></div></div>
	</div>
<% End If %>
<% If sysadmin.userrolelabel.Visible Then ' userrolelabel %>
	<div id="r_userrolelabel" class="form-group">
		<label id="elh_sysadmin_userrolelabel" for="x_userrolelabel" class="col-sm-2 control-label ewLabel"><%= sysadmin.userrolelabel.FldCaption %></label>
		<div class="col-sm-10"><div<%= sysadmin.userrolelabel.CellAttributes %>>
<% If sysadmin.CurrentAction <> "F" Then %>
<span id="el_sysadmin_userrolelabel">
<input type="text" data-field="x_userrolelabel" name="x_userrolelabel" id="x_userrolelabel" size="30" maxlength="255" placeholder="<%= sysadmin.userrolelabel.PlaceHolder %>" value="<%= sysadmin.userrolelabel.EditValue %>"<%= sysadmin.userrolelabel.EditAttributes %>>
</span>
<% Else %>
<span id="el_sysadmin_userrolelabel">
<span<%= sysadmin.userrolelabel.ViewAttributes %>>
<p class="form-control-static"><%= sysadmin.userrolelabel.ViewValue %></p>
</span>
</span>
<input type="hidden" data-field="x_userrolelabel" name="x_userrolelabel" id="x_userrolelabel" value="<%= Server.HTMLEncode(sysadmin.userrolelabel.FormValue&"") %>">
<% End If %>
<%= sysadmin.userrolelabel.CustomMsg %></div></div>
	</div>
<% End If %>
<% If sysadmin.userrole.Visible Then ' userrole %>
	<div id="r_userrole" class="form-group">
		<label id="elh_sysadmin_userrole" for="x_userrole" class="col-sm-2 control-label ewLabel"><%= sysadmin.userrole.FldCaption %></label>
		<div class="col-sm-10"><div<%= sysadmin.userrole.CellAttributes %>>
<% If sysadmin.CurrentAction <> "F" Then %>
<span id="el_sysadmin_userrole">
<input type="text" data-field="x_userrole" name="x_userrole" id="x_userrole" size="30" maxlength="255" placeholder="<%= sysadmin.userrole.PlaceHolder %>" value="<%= sysadmin.userrole.EditValue %>"<%= sysadmin.userrole.EditAttributes %>>
</span>
<% Else %>
<span id="el_sysadmin_userrole">
<span<%= sysadmin.userrole.ViewAttributes %>>
<p class="form-control-static"><%= sysadmin.userrole.ViewValue %></p>
</span>
</span>
<input type="hidden" data-field="x_userrole" name="x_userrole" id="x_userrole" value="<%= Server.HTMLEncode(sysadmin.userrole.FormValue&"") %>">
<% End If %>
<%= sysadmin.userrole.CustomMsg %></div></div>
	</div>
<% End If %>
</div>
<div class="form-group">
	<div class="col-sm-offset-2 col-sm-10">
<% If sysadmin.UpdateConflict = "U" Then ' Record already updated by other user %>
<button class="btn btn-primary ewButton" name="btnAction" id="btnAction" type="submit" onclick="this.form.a_edit.value='overwrite';"><%= Language.Phrase("OverwriteBtn") %></button>
<button class="btn btn-default ewButton" name="btnReload" id="btnReload" type="submit" onclick="this.form.a_edit.value='I';"><%= Language.Phrase("ReloadBtn") %></button>
<% Else %>
<% If sysadmin.CurrentAction <> "F" Then ' Confirm page %>
<button class="btn btn-primary ewButton" name="btnAction" id="btnAction" type="submit" onclick="this.form.a_edit.value='F';"><%= Language.Phrase("SaveBtn") %></button>
<% Else %>
<button class="btn btn-primary ewButton" name="btnAction" id="btnAction" type="submit"><%= Language.Phrase("ConfirmBtn") %></button>
<button class="btn btn-default ewButton" name="btnCancel" id="btnCancel" type="submit" onclick="this.form.a_edit.value='X';"><%= Language.Phrase("CancelBtn") %></button>
<% End If %>
<% End If %>
	</div>
</div>
</form>
<script type="text/javascript">
fsysadminedit.Init();
</script>
<%
sysadmin_edit.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set sysadmin_edit = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class csysadmin_edit

	' Page ID
	Public Property Get PageID()
		PageID = "edit"
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
		PageObjName = "sysadmin_edit"
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
		EW_PAGE_ID = "edit"

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

	Dim DbMasterFilter, DbDetailFilter

	Public HashValue ' Hash Value
	Dim DisplayRecs
	Dim StartRec, StopRec, TotalRecs, RecRange
	Dim RecCnt
	Dim Recordset

	' -----------------------------------------------------------------
	' Page main processing
	'
	Sub Page_Main()
		Dim sReturnUrl
		sReturnUrl = ""

		' Load key from QueryString
		If Request.QueryString("ID").Count > 0 Then
			sysadmin.ID.QueryStringValue = Request.QueryString("ID")
		End If

		' Set up Breadcrumb
		SetupBreadcrumb()

		' Process form if post back
		If ObjForm.GetValue("a_edit")&"" <> "" Then
			sysadmin.CurrentAction = ObjForm.GetValue("a_edit") ' Get action code
			Call LoadFormValues() ' Get form values

			' Overwrite record, reload hash value
			If sysadmin.CurrentAction = "overwrite" Then
				Call LoadRowHash()
			sysadmin.CurrentAction = "F"
			End If
		Else
			sysadmin.CurrentAction = "I" ' Default action is display
		End If

		' Check if valid key
		If sysadmin.ID.CurrentValue = "" Then Call Page_Terminate("sysadminlist.asp") ' Invalid key, return to list

		' Validate form if post back
		If ObjForm.GetValue("a_edit")&"" <> "" Then
			If Not ValidateForm() Then
				sysadmin.CurrentAction = "" ' Form error, reset action
				FailureMessage = gsFormError
				sysadmin.EventCancelled = True ' Event cancelled
				Call LoadRow() ' Restore row
				Call RestoreFormValues() ' Restore form values if validate failed
			End If
		End If
		Select Case sysadmin.CurrentAction
			Case "I" ' Get a record to display
				If Not LoadRow() Then ' Load Record based on key
					If FailureMessage = "" Then FailureMessage = Language.Phrase("NoRecord") ' No record found
					Call Page_Terminate("sysadminlist.asp") ' No matching record, return to list
				End If
			Case "U" ' Update
				sysadmin.SendEmail = True ' Send email on update success
				If EditRow() Then ' Update Record based on key
					If SuccessMessage = "" Then SuccessMessage = Language.Phrase("UpdateSuccess") ' Update success
					sReturnUrl = sysadmin.ReturnUrl
					Call Page_Terminate(sReturnUrl) ' Return to caller
				Else
					sysadmin.EventCancelled = True ' Event cancelled
					Call LoadRow() ' Restore row
					Call RestoreFormValues() ' Restore form values if update failed
				End If
		End Select

		' Render the record
		If sysadmin.CurrentAction = "F" Then ' Confirm page
			sysadmin.RowType = EW_ROWTYPE_VIEW ' Render as view
		Else
			sysadmin.RowType = EW_ROWTYPE_EDIT ' Render as edit
		End If

		' Render row
		Call sysadmin.ResetAttrs()
		Call RenderRow()
	End Sub
	Dim Pager

	' -----------------------------------------------------------------
	' Set up Starting Record parameters based on Pager Navigation
	'
	Sub SetUpStartRec()
		Dim PageNo

		' Exit if DisplayRecs = 0
		If DisplayRecs = 0 Then Exit Sub
		If IsPageRequest Then ' Validate request

			' Check for a START parameter
			If Request.QueryString(EW_TABLE_START_REC).Count > 0 Then
				StartRec = Request.QueryString(EW_TABLE_START_REC)
				sysadmin.StartRecordNumber = StartRec
			ElseIf Request.QueryString(EW_TABLE_PAGE_NO).Count > 0 Then
				PageNo = Request.QueryString(EW_TABLE_PAGE_NO)
				If IsNumeric(PageNo) Then
					StartRec = (PageNo-1)*DisplayRecs+1
					If StartRec <= 0 Then
						StartRec = 1
					ElseIf StartRec >= ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1 Then
						StartRec = ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1
					End If
					sysadmin.StartRecordNumber = StartRec
				End If
			End If
		End If
		StartRec = sysadmin.StartRecordNumber

		' Check if correct start record counter
		If Not IsNumeric(StartRec) Or StartRec = "" Then ' Avoid invalid start record counter
			StartRec = 1 ' Reset start record counter
			sysadmin.StartRecordNumber = StartRec
		ElseIf CLng(StartRec) > CLng(TotalRecs) Then ' Avoid starting record > total records
			StartRec = ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1 ' Point to last page first record
			sysadmin.StartRecordNumber = StartRec
		ElseIf (StartRec-1) Mod DisplayRecs <> 0 Then
			StartRec = ((StartRec-1)\DisplayRecs)*DisplayRecs+1 ' Point to page boundary
			sysadmin.StartRecordNumber = StartRec
		End If
	End Sub

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
		If Not sysadmin.ID.FldIsDetailKey Then sysadmin.ID.FormValue = ObjForm.GetValue("x_ID")
		If Not sysadmin.username.FldIsDetailKey Then sysadmin.username.FormValue = ObjForm.GetValue("x_username")
		If Not sysadmin.pswd.FldIsDetailKey Then sysadmin.pswd.FormValue = ObjForm.GetValue("x_pswd")
		If Not sysadmin.userrolelabel.FldIsDetailKey Then sysadmin.userrolelabel.FormValue = ObjForm.GetValue("x_userrolelabel")
		If Not sysadmin.userrole.FldIsDetailKey Then sysadmin.userrole.FormValue = ObjForm.GetValue("x_userrole")
		If sysadmin.CurrentAction <> "overwrite" Then
			ObjForm.Index = -1
			HashValue = ObjForm.GetValue("k_hash")
		End If
	End Function

	' -----------------------------------------------------------------
	' Restore form values
	'
	Function RestoreFormValues()
		Call LoadRow()
		sysadmin.ID.CurrentValue = sysadmin.ID.FormValue
		sysadmin.username.CurrentValue = sysadmin.username.FormValue
		sysadmin.pswd.CurrentValue = sysadmin.pswd.FormValue
		sysadmin.userrolelabel.CurrentValue = sysadmin.userrolelabel.FormValue
		sysadmin.userrole.CurrentValue = sysadmin.userrole.FormValue
		If sysadmin.CurrentAction <> "overwrite" Then
			ObjForm.Index = -1
			HashValue = ObjForm.GetValue("k_hash")
		End If
	End Function

	' -----------------------------------------------------------------
	' Load row based on key values
	'
	Function LoadRow()
		Dim RsRow, sSql, sFilter
		sFilter = sysadmin.KeyFilter

		' Call Row Selecting event
		Call sysadmin.Row_Selecting(sFilter)

		' Load sql based on filter
		sysadmin.CurrentFilter = sFilter
		sSql = sysadmin.SQL
		Call ew_SetDebugMsg("LoadRow: " & sSql) ' Show SQL for debugging
		Set RsRow = ew_LoadRow(sSql)
		If RsRow.Eof Then
			LoadRow = False
		Else
			LoadRow = True
			RsRow.MoveFirst
			Call LoadRowValues(RsRow) ' Load row values
			If Not sysadmin.EventCancelled Then HashValue = GetRowHash(RsRow) ' Get hash value for record
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
		Call sysadmin.Row_Selected(RsRow)
		sysadmin.ID.DbValue = RsRow("ID")
		sysadmin.username.DbValue = RsRow("username")
		sysadmin.pswd.DbValue = RsRow("pswd")
		sysadmin.userrolelabel.DbValue = RsRow("userrolelabel")
		sysadmin.userrole.DbValue = RsRow("userrole")
	End Sub

	' Load DbValue from recordset
	Sub LoadDbValues(Rs)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		If Rs.Eof Then Exit Sub
		sysadmin.ID.m_DbValue = Rs("ID")
		sysadmin.username.m_DbValue = Rs("username")
		sysadmin.pswd.m_DbValue = Rs("pswd")
		sysadmin.userrolelabel.m_DbValue = Rs("userrolelabel")
		sysadmin.userrole.m_DbValue = Rs("userrole")
	End Sub

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

		' ----------
		'  Edit Row
		' ----------

		ElseIf sysadmin.RowType = EW_ROWTYPE_EDIT Then ' Edit row

			' ID
			sysadmin.ID.EditAttrs.UpdateAttribute "class", "form-control"
			sysadmin.ID.EditCustomAttributes = ""
			sysadmin.ID.EditValue = sysadmin.ID.CurrentValue
			sysadmin.ID.ViewCustomAttributes = ""

			' username
			sysadmin.username.EditAttrs.UpdateAttribute "class", "form-control"
			sysadmin.username.EditCustomAttributes = ""
			sysadmin.username.EditValue = ew_HtmlEncode(sysadmin.username.CurrentValue)
			sysadmin.username.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(sysadmin.username.FldCaption))

			' pswd
			sysadmin.pswd.EditAttrs.UpdateAttribute "class", "form-control"
			sysadmin.pswd.EditCustomAttributes = ""
			sysadmin.pswd.EditValue = ew_HtmlEncode(sysadmin.pswd.CurrentValue)
			sysadmin.pswd.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(sysadmin.pswd.FldCaption))

			' userrolelabel
			sysadmin.userrolelabel.EditAttrs.UpdateAttribute "class", "form-control"
			sysadmin.userrolelabel.EditCustomAttributes = ""
			sysadmin.userrolelabel.EditValue = ew_HtmlEncode(sysadmin.userrolelabel.CurrentValue)
			sysadmin.userrolelabel.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(sysadmin.userrolelabel.FldCaption))

			' userrole
			sysadmin.userrole.EditAttrs.UpdateAttribute "class", "form-control"
			sysadmin.userrole.EditCustomAttributes = ""
			sysadmin.userrole.EditValue = ew_HtmlEncode(sysadmin.userrole.CurrentValue)
			sysadmin.userrole.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(sysadmin.userrole.FldCaption))

			' Edit refer script
			' ID

			sysadmin.ID.HrefValue = ""

			' username
			sysadmin.username.HrefValue = ""

			' pswd
			sysadmin.pswd.HrefValue = ""

			' userrolelabel
			sysadmin.userrolelabel.HrefValue = ""

			' userrole
			sysadmin.userrole.HrefValue = ""
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
		sFilter = sysadmin.KeyFilter
		sysadmin.CurrentFilter  = sFilter
		sSql = sysadmin.SQL
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

			' Field username
			Call sysadmin.username.SetDbValue(Rs, sysadmin.username.CurrentValue, Null, sysadmin.username.ReadOnly)

			' Field pswd
			Call sysadmin.pswd.SetDbValue(Rs, sysadmin.pswd.CurrentValue, Null, sysadmin.pswd.ReadOnly)

			' Field userrolelabel
			Call sysadmin.userrolelabel.SetDbValue(Rs, sysadmin.userrolelabel.CurrentValue, Null, sysadmin.userrolelabel.ReadOnly)

			' Field userrole
			Call sysadmin.userrole.SetDbValue(Rs, sysadmin.userrole.CurrentValue, Null, sysadmin.userrole.ReadOnly)

			' Check recordset update error
			If Err.Number <> 0 Then
				FailureMessage = Err.Description
				Rs.Close
				Set Rs = Nothing
				EditRow = False
				Exit Function
			End If

			' Check hash value
			Dim bRowHasConflict
			bRowHasConflict = (GetRowHash(RsOld) <> HashValue)

			' Call Row Update Conflict event
			If bRowHasConflict Then bRowHasConflict = sysadmin.Row_UpdateConflict(RsOld, Rs)
			If bRowHasConflict Then
				FailureMessage = Language.Phrase("RecordChangedByOtherUser")
				sysadmin.UpdateConflict = "U"
				Rs.CancelUpdate
				Rs.Close
				Set Rs = Nothing
				EditRow = False ' Update Failed
				Exit Function
			End If

			' Call Row Updating event
			bUpdateRow = sysadmin.Row_Updating(RsOld, Rs)
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
				ElseIf sysadmin.CancelMessage <> "" Then
					FailureMessage = sysadmin.CancelMessage
					sysadmin.CancelMessage = ""
				Else
					FailureMessage = Language.Phrase("UpdateCancelled")
				End If
				EditRow = False
			End If
		End If

		' Call Row Updated event
		If EditRow Then
			Call sysadmin.Row_Updated(RsOld, RsNew)
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

	' Load row hash
	Function LoadRowHash()
		Dim RsRow, sSql, sFilter
		sFilter = sysadmin.KeyFilter

		' Load sql based on filter
		sysadmin.CurrentFilter = sFilter
		sSql = sysadmin.SQL
		Set RsRow = Server.CreateObject("ADODB.Recordset")
		RsRow.Open sSql, Conn
		If RsRow.Eof Then
			HashValue = ""
		Else
			RsRow.MoveFirst
			HashValue = GetRowHash(RsRow) ' Get hash value for record
		End If
		RsRow.Close
		Set RsRow = Nothing
	End Function

	' Get Row Hash
	Function GetRowHash(rs)
		Dim sHash, value, typ
		sHash = ""
		value = rs("username") ' username
		typ = rs("username").Type
		sHash = sHash & ew_GetFldHash(value, typ)
		value = rs("pswd") ' pswd
		typ = rs("pswd").Type
		sHash = sHash & ew_GetFldHash(value, typ)
		value = rs("userrolelabel") ' userrolelabel
		typ = rs("userrolelabel").Type
		sHash = sHash & ew_GetFldHash(value, typ)
		value = rs("userrole") ' userrole
		typ = rs("userrole").Type
		sHash = sHash & ew_GetFldHash(value, typ)
		GetRowHash = MD5(sHash)
	End Function

	' Set up Breadcrumb
	Sub SetupBreadcrumb()
		Dim PageId, url
		Set Breadcrumb = New cBreadcrumb
		url = Mid(ew_CurrentUrl, InStrRev(ew_CurrentUrl, "/")+1)
		Call Breadcrumb.Add("list", sysadmin.TableVar, "sysadminlist.asp", "", sysadmin.TableVar, True)
		PageId = "edit"
		Call Breadcrumb.Add("edit", PageId, url, "", "", False)
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
