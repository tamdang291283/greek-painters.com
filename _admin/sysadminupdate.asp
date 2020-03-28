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
Dim sysadmin_update
Set sysadmin_update = New csysadmin_update
Set Page = sysadmin_update

' Page init processing
sysadmin_update.Page_Init()

' Page main processing
sysadmin_update.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
sysadmin_update.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var sysadmin_update = new ew_Page("sysadmin_update");
sysadmin_update.PageID = "update"; // Page ID
var EW_PAGE_ID = sysadmin_update.PageID; // For backward compatibility
// Form object
var fsysadminupdate = new ew_Form("fsysadminupdate");
// Validate form
fsysadminupdate.Validate = function() {
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
			// Set up row object
			ew_ElementsToRow(fobj);
			// Fire Form_CustomValidate event
			if (!this.Form_CustomValidate(fobj))
				return false;
	}
	return true;
}
// Form_CustomValidate event
fsysadminupdate.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fsysadminupdate.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fsysadminupdate.ValidateRequired = false; // No JavaScript validation
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
<% sysadmin_update.ShowPageHeader() %>
<% sysadmin_update.ShowMessage %>
<form name="fsysadminupdate" id="fsysadminupdate" class="form-horizontal ewForm ewUpdateForm" action="<%= ew_CurrentPage %>" method="post">
<% If sysadmin_update.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= sysadmin_update.Token %>">
<% End If %>
<input type="hidden" name="t" value="sysadmin">
<input type="hidden" name="a_update" id="a_update" value="U">
<% If sysadmin.CurrentAction = "F" Then ' Confirm page %>
<input type="hidden" name="a_confirm" id="a_confirm" value="F">
<% End If %>
<% For i = 0 to UBound(sysadmin_update.RecKeys) %>
<input type="hidden" name="key_m" id="key_m" value="<%= ew_HtmlEncode(ew_GetKeyValue(sysadmin_update.RecKeys(i))) %>">
<% Next %>
<div id="tbl_sysadminupdate">
	<div class="form-group">
		<label class="col-sm-2"><input type="checkbox" name="u" id="u" onclick="ew_SelectAll(this);"> <%= Language.Phrase("UpdateSelectAll") %></label>
	</div>
<% If sysadmin.username.Visible Then ' username %>
	<div id="r_username" class="form-group">
		<label for="x_username" class="col-sm-2 control-label">
<% If sysadmin.CurrentAction <> "F" Then %>
<input type="checkbox" name="u_username" id="u_username" value="1"<% If sysadmin.username.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
<% Else %>
<input type="checkbox" disabled="disabled"<% If sysadmin.username.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
<input type="hidden" name="u_username" id="u_username" value="<%= sysadmin.username.MultiUpdate %>">
<% End If %>
 <%= sysadmin.username.FldCaption %></label>
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
		<label for="x_pswd" class="col-sm-2 control-label">
<% If sysadmin.CurrentAction <> "F" Then %>
<input type="checkbox" name="u_pswd" id="u_pswd" value="1"<% If sysadmin.pswd.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
<% Else %>
<input type="checkbox" disabled="disabled"<% If sysadmin.pswd.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
<input type="hidden" name="u_pswd" id="u_pswd" value="<%= sysadmin.pswd.MultiUpdate %>">
<% End If %>
 <%= sysadmin.pswd.FldCaption %></label>
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
		<label for="x_userrolelabel" class="col-sm-2 control-label">
<% If sysadmin.CurrentAction <> "F" Then %>
<input type="checkbox" name="u_userrolelabel" id="u_userrolelabel" value="1"<% If sysadmin.userrolelabel.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
<% Else %>
<input type="checkbox" disabled="disabled"<% If sysadmin.userrolelabel.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
<input type="hidden" name="u_userrolelabel" id="u_userrolelabel" value="<%= sysadmin.userrolelabel.MultiUpdate %>">
<% End If %>
 <%= sysadmin.userrolelabel.FldCaption %></label>
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
		<label for="x_userrole" class="col-sm-2 control-label">
<% If sysadmin.CurrentAction <> "F" Then %>
<input type="checkbox" name="u_userrole" id="u_userrole" value="1"<% If sysadmin.userrole.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
<% Else %>
<input type="checkbox" disabled="disabled"<% If sysadmin.userrole.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
<input type="hidden" name="u_userrole" id="u_userrole" value="<%= sysadmin.userrole.MultiUpdate %>">
<% End If %>
 <%= sysadmin.userrole.FldCaption %></label>
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
	<div class="form-group">
		<div class="col-sm-offset-2 col-sm-10">
<% If sysadmin.CurrentAction <> "F" Then ' Confirm page %>
<button class="btn btn-primary ewButton" name="btnAction" id="btnAction" type="submit" onclick="this.form.a_update.value='F';"><%= Language.Phrase("UpdateBtn") %></button>
<% Else %>
<button class="btn btn-primary ewButton" name="btnAction" id="btnAction" type="submit"><%= Language.Phrase("ConfirmBtn") %></button>
<button class="btn btn-default ewButton" name="btnCancel" id="btnCancel" type="submit" onclick="this.form.a_update.value='X';"><%= Language.Phrase("CancelBtn") %></button>
<% End If %>
		</div>
	</div>
</div>
</form>
<script type="text/javascript">
fsysadminupdate.Init();
</script>
<%
sysadmin_update.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set sysadmin_update = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class csysadmin_update

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
		TableName = "sysadmin"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "sysadmin_update"
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
		EW_PAGE_ID = "update"

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
		RecKeys = sysadmin.GetRecordKeys() ' Load record keys
		If ObjForm.GetValue("a_update")&"" <> "" Then

			' Get action
			sysadmin.CurrentAction = ObjForm.GetValue("a_update")
			Call LoadFormValues() ' Get form values

			' Validate form
			If Not ValidateForm() Then
				sysadmin.CurrentAction = "I" ' Form error, reset action
				FailureMessage = gsFormError
			End If
		Else
			Call LoadMultiUpdateValues() ' Load initial values to form
		End If
		If Not IsArray(RecKeys) Then
			Call Page_Terminate("sysadminlist.asp") ' No records selected, return to list
		End If
		Select Case sysadmin.CurrentAction
			Case "U" ' Update
				If UpdateRows() Then ' Update Records based on key
					If SuccessMessage = "" Then SuccessMessage = Language.Phrase("UpdateSuccess") ' Set update success message
					Call Page_Terminate(sysadmin.ReturnUrl) ' Return to caller
				Else
					Call RestoreFormValues() ' Restore form values
				End If
		End Select

		' Render row
		If sysadmin.CurrentAction = "F" Then ' Confirm page
			sysadmin.RowType = EW_ROWTYPE_VIEW ' Render view
			Disabled = " disabled=""disabled"""
		Else
			sysadmin.RowType = EW_ROWTYPE_EDIT ' Render edit
			Disabled = ""
		End If

		' Render row
		Call sysadmin.ResetAttrs()
		Call RenderRow()
	End Sub

	' -----------------------------------------------------------------
	' Load initial values to form if field values are identical in all selected records
	'
	Sub LoadMultiUpdateValues()
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		Dim Rs, i, OldValue, NewValue
		sysadmin.CurrentFilter = sysadmin.GetKeyFilter()

		' Load recordset
		Set Rs = LoadRecordset()
		i = 1
		Do While Not Rs.Eof
			If i = 1 Then
				sysadmin.username.DbValue = ew_Conv(Rs("username"), Rs("username").Type)
				sysadmin.pswd.DbValue = ew_Conv(Rs("pswd"), Rs("pswd").Type)
				sysadmin.userrolelabel.DbValue = ew_Conv(Rs("userrolelabel"), Rs("userrolelabel").Type)
				sysadmin.userrole.DbValue = ew_Conv(Rs("userrole"), Rs("userrole").Type)
			Else
				OldValue = sysadmin.username.DbValue
				NewValue = ew_Conv(Rs("username"), Rs("username").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					sysadmin.username.CurrentValue = Null
				End If
				OldValue = sysadmin.pswd.DbValue
				NewValue = ew_Conv(Rs("pswd"), Rs("pswd").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					sysadmin.pswd.CurrentValue = Null
				End If
				OldValue = sysadmin.userrolelabel.DbValue
				NewValue = ew_Conv(Rs("userrolelabel"), Rs("userrolelabel").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					sysadmin.userrolelabel.CurrentValue = Null
				End If
				OldValue = sysadmin.userrole.DbValue
				NewValue = ew_Conv(Rs("userrole"), Rs("userrole").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					sysadmin.userrole.CurrentValue = Null
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
		sysadmin.ID.CurrentValue = sKeyFld ' Set up key value
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
		sysadmin.CurrentFilter = sysadmin.GetKeyFilter()
		sSql = sysadmin.SQL
		Set Rs = Server.CreateObject("ADODB.Recordset")
		Rs.CursorLocation = EW_CURSORLOCATION
		Rs.Open sSql, Conn, 1, EW_RECORDSET_LOCKTYPE
		Set RsOld = ew_CloneRs(Rs)

		' Update all rows
		sKey = ""
		For i = 0 to UBound(RecKeys)
			If SetupKeyValues(RecKeys(i)) Then
				sThisKey = RecKeys(i)
				sysadmin.SendEmail = False ' Do not send email on update success
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
		If Not sysadmin.username.FldIsDetailKey Then sysadmin.username.FormValue = ObjForm.GetValue("x_username")
		sysadmin.username.MultiUpdate = ObjForm.GetValue("u_username")
		If Not sysadmin.pswd.FldIsDetailKey Then sysadmin.pswd.FormValue = ObjForm.GetValue("x_pswd")
		sysadmin.pswd.MultiUpdate = ObjForm.GetValue("u_pswd")
		If Not sysadmin.userrolelabel.FldIsDetailKey Then sysadmin.userrolelabel.FormValue = ObjForm.GetValue("x_userrolelabel")
		sysadmin.userrolelabel.MultiUpdate = ObjForm.GetValue("u_userrolelabel")
		If Not sysadmin.userrole.FldIsDetailKey Then sysadmin.userrole.FormValue = ObjForm.GetValue("x_userrole")
		sysadmin.userrole.MultiUpdate = ObjForm.GetValue("u_userrole")
		If Not sysadmin.ID.FldIsDetailKey Then sysadmin.ID.FormValue = ObjForm.GetValue("x_ID")
	End Function

	' -----------------------------------------------------------------
	' Restore form values
	'
	Function RestoreFormValues()
		sysadmin.username.CurrentValue = sysadmin.username.FormValue
		sysadmin.pswd.CurrentValue = sysadmin.pswd.FormValue
		sysadmin.userrolelabel.CurrentValue = sysadmin.userrolelabel.FormValue
		sysadmin.userrole.CurrentValue = sysadmin.userrole.FormValue
		sysadmin.ID.CurrentValue = sysadmin.ID.FormValue
	End Function

	' -----------------------------------------------------------------
	' Load recordset
	'
	Function LoadRecordset()

		' Load list page sql
		Dim sSql
		sSql = sysadmin.SelectSQL
		Call ew_SetDebugMsg("LoadRecordset: " & sSql) ' Show SQL for debugging

		' Load recordset
		Dim RsRecordset
		Set RsRecordset = ew_LoadRecordset(sSql)

		' Call Recordset Selected event
		Call sysadmin.Recordset_Selected(RsRecordset)
		Set LoadRecordset = RsRecordset
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
		Dim lUpdateCnt
		lUpdateCnt = 0
		If sysadmin.username.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If sysadmin.pswd.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If sysadmin.userrolelabel.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If sysadmin.userrole.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
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
			Call sysadmin.username.SetDbValue(Rs, sysadmin.username.CurrentValue, Null, sysadmin.username.ReadOnly Or sysadmin.username.MultiUpdate&"" <> "1")

			' Field pswd
			Call sysadmin.pswd.SetDbValue(Rs, sysadmin.pswd.CurrentValue, Null, sysadmin.pswd.ReadOnly Or sysadmin.pswd.MultiUpdate&"" <> "1")

			' Field userrolelabel
			Call sysadmin.userrolelabel.SetDbValue(Rs, sysadmin.userrolelabel.CurrentValue, Null, sysadmin.userrolelabel.ReadOnly Or sysadmin.userrolelabel.MultiUpdate&"" <> "1")

			' Field userrole
			Call sysadmin.userrole.SetDbValue(Rs, sysadmin.userrole.CurrentValue, Null, sysadmin.userrole.ReadOnly Or sysadmin.userrole.MultiUpdate&"" <> "1")

			' Check recordset update error
			If Err.Number <> 0 Then
				FailureMessage = Err.Description
				Rs.Close
				Set Rs = Nothing
				EditRow = False
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

	' Set up Breadcrumb
	Sub SetupBreadcrumb()
		Dim PageId, url
		Set Breadcrumb = New cBreadcrumb
		url = Mid(ew_CurrentUrl, InStrRev(ew_CurrentUrl, "/")+1)
		Call Breadcrumb.Add("list", sysadmin.TableVar, "sysadminlist.asp", "", sysadmin.TableVar, True)
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
