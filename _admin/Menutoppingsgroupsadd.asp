<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="Menutoppingsgroupsinfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim Menutoppingsgroups_add
Set Menutoppingsgroups_add = New cMenutoppingsgroups_add
Set Page = Menutoppingsgroups_add

' Page init processing
Menutoppingsgroups_add.Page_Init()

' Page main processing
Menutoppingsgroups_add.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
Menutoppingsgroups_add.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var Menutoppingsgroups_add = new ew_Page("Menutoppingsgroups_add");
Menutoppingsgroups_add.PageID = "add"; // Page ID
var EW_PAGE_ID = Menutoppingsgroups_add.PageID; // For backward compatibility
// Form object
var fMenutoppingsgroupsadd = new ew_Form("fMenutoppingsgroupsadd");
// Validate form
fMenutoppingsgroupsadd.Validate = function() {
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
			elm = this.GetElements("x" + infix + "_IdBusinessDetail");
			if (elm && !ew_CheckInteger(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(Menutoppingsgroups.IdBusinessDetail.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_i_displaySort");
			if (elm && !ew_CheckInteger(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(Menutoppingsgroups.i_displaySort.FldErrMsg) %>");
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
fMenutoppingsgroupsadd.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fMenutoppingsgroupsadd.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fMenutoppingsgroupsadd.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<div class="ewToolbar">
<% If Menutoppingsgroups.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If Menutoppingsgroups.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% Menutoppingsgroups_add.ShowPageHeader() %>
<% Menutoppingsgroups_add.ShowMessage %>
<form name="fMenutoppingsgroupsadd" id="fMenutoppingsgroupsadd" class="form-horizontal ewForm ewAddForm" action="<%= ew_CurrentPage() %>" method="post">
<% If Menutoppingsgroups_add.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= Menutoppingsgroups_add.Token %>">
<% End If %>
<input type="hidden" name="t" value="Menutoppingsgroups">
<input type="hidden" name="a_add" id="a_add" value="A">
<div>
<% If Menutoppingsgroups.toppingsgroup.Visible Then ' toppingsgroup %>
	<div id="r_toppingsgroup" class="form-group">
		<label id="elh_Menutoppingsgroups_toppingsgroup" for="x_toppingsgroup" class="col-sm-2 control-label ewLabel"><%= Menutoppingsgroups.toppingsgroup.FldCaption %></label>
		<div class="col-sm-10"><div<%= Menutoppingsgroups.toppingsgroup.CellAttributes %>>
<span id="el_Menutoppingsgroups_toppingsgroup">
<input type="text" data-field="x_toppingsgroup" name="x_toppingsgroup" id="x_toppingsgroup" size="30" maxlength="255" placeholder="<%= Menutoppingsgroups.toppingsgroup.PlaceHolder %>" value="<%= Menutoppingsgroups.toppingsgroup.EditValue %>"<%= Menutoppingsgroups.toppingsgroup.EditAttributes %>>
</span>
<%= Menutoppingsgroups.toppingsgroup.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Menutoppingsgroups.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
	<div id="r_IdBusinessDetail" class="form-group">
		<label id="elh_Menutoppingsgroups_IdBusinessDetail" for="x_IdBusinessDetail" class="col-sm-2 control-label ewLabel"><%= Menutoppingsgroups.IdBusinessDetail.FldCaption %></label>
		<div class="col-sm-10"><div<%= Menutoppingsgroups.IdBusinessDetail.CellAttributes %>>
<span id="el_Menutoppingsgroups_IdBusinessDetail">
<input type="text" data-field="x_IdBusinessDetail" name="x_IdBusinessDetail" id="x_IdBusinessDetail" size="30" placeholder="<%= Menutoppingsgroups.IdBusinessDetail.PlaceHolder %>" value="<%= Menutoppingsgroups.IdBusinessDetail.EditValue %>"<%= Menutoppingsgroups.IdBusinessDetail.EditAttributes %>>
</span>
<%= Menutoppingsgroups.IdBusinessDetail.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Menutoppingsgroups.printingname.Visible Then ' printingname %>
	<div id="r_printingname" class="form-group">
		<label id="elh_Menutoppingsgroups_printingname" for="x_printingname" class="col-sm-2 control-label ewLabel"><%= Menutoppingsgroups.printingname.FldCaption %></label>
		<div class="col-sm-10"><div<%= Menutoppingsgroups.printingname.CellAttributes %>>
<span id="el_Menutoppingsgroups_printingname">
<input type="text" data-field="x_printingname" name="x_printingname" id="x_printingname" size="30" maxlength="255" placeholder="<%= Menutoppingsgroups.printingname.PlaceHolder %>" value="<%= Menutoppingsgroups.printingname.EditValue %>"<%= Menutoppingsgroups.printingname.EditAttributes %>>
</span>
<%= Menutoppingsgroups.printingname.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Menutoppingsgroups.i_displaySort.Visible Then ' i_displaySort %>
	<div id="r_i_displaySort" class="form-group">
		<label id="elh_Menutoppingsgroups_i_displaySort" for="x_i_displaySort" class="col-sm-2 control-label ewLabel"><%= Menutoppingsgroups.i_displaySort.FldCaption %></label>
		<div class="col-sm-10"><div<%= Menutoppingsgroups.i_displaySort.CellAttributes %>>
<span id="el_Menutoppingsgroups_i_displaySort">
<input type="text" data-field="x_i_displaySort" name="x_i_displaySort" id="x_i_displaySort" size="30" placeholder="<%= Menutoppingsgroups.i_displaySort.PlaceHolder %>" value="<%= Menutoppingsgroups.i_displaySort.EditValue %>"<%= Menutoppingsgroups.i_displaySort.EditAttributes %>>
</span>
<%= Menutoppingsgroups.i_displaySort.CustomMsg %></div></div>
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
fMenutoppingsgroupsadd.Init();
</script>
<%
Menutoppingsgroups_add.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set Menutoppingsgroups_add = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cMenutoppingsgroups_add

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
		TableName = "Menutoppingsgroups"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "Menutoppingsgroups_add"
	End Property

	' Page Name
	Public Property Get PageName()
		PageName = ew_CurrentPage()
	End Property

	' Page Url
	Public Property Get PageUrl()
		PageUrl = ew_CurrentPage() & "?"
		If Menutoppingsgroups.UseTokenInUrl Then PageUrl = PageUrl & "t=" & Menutoppingsgroups.TableVar & "&" ' add page token
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
		If Menutoppingsgroups.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (Menutoppingsgroups.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (Menutoppingsgroups.TableVar = Request.QueryString("t"))
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
		If IsEmpty(Menutoppingsgroups) Then Set Menutoppingsgroups = New cMenutoppingsgroups
		Set Table = Menutoppingsgroups

		' Initialize urls
		' Initialize form object

		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "add"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "Menutoppingsgroups"

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

		Menutoppingsgroups.CurrentAction = ew_IIf(Request.QueryString("a").Count > 0, Request.QueryString("a") & "", ObjForm.GetValue("a_list") & "") ' Set up current action

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
			results = Menutoppingsgroups.GetAutoFill(Request.Form("name"), Request.Form("q"))
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
		If Not Menutoppingsgroups Is Nothing Then
			If Menutoppingsgroups.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = Menutoppingsgroups.TableVar
				If Menutoppingsgroups.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf Menutoppingsgroups.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf Menutoppingsgroups.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf Menutoppingsgroups.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set Menutoppingsgroups = Nothing
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
			Menutoppingsgroups.CurrentAction = ObjForm.GetValue("a_add") ' Get form action
			CopyRecord = LoadOldRecord() ' Load old recordset
			Call LoadFormValues() ' Load form values

		' Not post back
		Else

			' Load key values from QueryString
			CopyRecord = True
			If Request.QueryString("ID").Count > 0 Then
				Menutoppingsgroups.ID.QueryStringValue = Request.QueryString("ID")
				Call Menutoppingsgroups.SetKey("ID", Menutoppingsgroups.ID.CurrentValue) ' Set up key
			Else
				Call Menutoppingsgroups.SetKey("ID", "") ' Clear key
				CopyRecord = False
			End If
			If CopyRecord Then
				Menutoppingsgroups.CurrentAction = "C" ' Copy Record
			Else
				Menutoppingsgroups.CurrentAction = "I" ' Display Blank Record
				Call LoadDefaultValues() ' Load default values
			End If
		End If

		' Set up Breadcrumb
		SetupBreadcrumb()

		' Validate form if post back
		If ObjForm.GetValue("a_add")&"" <> "" Then
			If Not ValidateForm() Then
				Menutoppingsgroups.CurrentAction = "I" ' Form error, reset action
				Menutoppingsgroups.EventCancelled = True ' Event cancelled
				Call RestoreFormValues() ' Restore form values
				FailureMessage = gsFormError
			End If
		End If

		' Perform action based on action code
		Select Case Menutoppingsgroups.CurrentAction
			Case "I" ' Blank record, no action required
			Case "C" ' Copy an existing record
				If Not LoadRow() Then ' Load record based on key
					If FailureMessage = "" Then FailureMessage = Language.Phrase("NoRecord") ' No record found
					Call Page_Terminate("Menutoppingsgroupslist.asp") ' No matching record, return to list
				End If
			Case "A" ' Add new record
				Menutoppingsgroups.SendEmail = True ' Send email on add success
				If AddRow(OldRecordset) Then ' Add successful
					If SuccessMessage = "" Then SuccessMessage = Language.Phrase("AddSuccess") ' Set up success message
					Dim sReturnUrl
					sReturnUrl = Menutoppingsgroups.ReturnUrl
					If ew_GetPageName(sReturnUrl) = "Menutoppingsgroupsview.asp" Then sReturnUrl = Menutoppingsgroups.ViewUrl("") ' View paging, return to view page with keyurl directly
					Call Page_Terminate(sReturnUrl) ' Clean up and return
				Else
					Menutoppingsgroups.EventCancelled = True ' Event cancelled
					Call RestoreFormValues() ' Add failed, restore form values
				End If
		End Select

		' Render row based on row type
		Menutoppingsgroups.RowType = EW_ROWTYPE_ADD ' Render add type

		' Render row
		Call Menutoppingsgroups.ResetAttrs()
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
		Menutoppingsgroups.toppingsgroup.CurrentValue = Null
		Menutoppingsgroups.toppingsgroup.OldValue = Menutoppingsgroups.toppingsgroup.CurrentValue
		Menutoppingsgroups.IdBusinessDetail.CurrentValue = Null
		Menutoppingsgroups.IdBusinessDetail.OldValue = Menutoppingsgroups.IdBusinessDetail.CurrentValue
		Menutoppingsgroups.printingname.CurrentValue = Null
		Menutoppingsgroups.printingname.OldValue = Menutoppingsgroups.printingname.CurrentValue
		Menutoppingsgroups.i_displaySort.CurrentValue = Null
		Menutoppingsgroups.i_displaySort.OldValue = Menutoppingsgroups.i_displaySort.CurrentValue
	End Function

	' -----------------------------------------------------------------
	' Load form values
	'
	Function LoadFormValues()

		' Load values from form
		If Not Menutoppingsgroups.toppingsgroup.FldIsDetailKey Then Menutoppingsgroups.toppingsgroup.FormValue = ObjForm.GetValue("x_toppingsgroup")
		If Not Menutoppingsgroups.IdBusinessDetail.FldIsDetailKey Then Menutoppingsgroups.IdBusinessDetail.FormValue = ObjForm.GetValue("x_IdBusinessDetail")
		If Not Menutoppingsgroups.printingname.FldIsDetailKey Then Menutoppingsgroups.printingname.FormValue = ObjForm.GetValue("x_printingname")
		If Not Menutoppingsgroups.i_displaySort.FldIsDetailKey Then Menutoppingsgroups.i_displaySort.FormValue = ObjForm.GetValue("x_i_displaySort")
	End Function

	' -----------------------------------------------------------------
	' Restore form values
	'
	Function RestoreFormValues()
		Call LoadOldRecord()
		Menutoppingsgroups.toppingsgroup.CurrentValue = Menutoppingsgroups.toppingsgroup.FormValue
		Menutoppingsgroups.IdBusinessDetail.CurrentValue = Menutoppingsgroups.IdBusinessDetail.FormValue
		Menutoppingsgroups.printingname.CurrentValue = Menutoppingsgroups.printingname.FormValue
		Menutoppingsgroups.i_displaySort.CurrentValue = Menutoppingsgroups.i_displaySort.FormValue
	End Function

	' -----------------------------------------------------------------
	' Load row based on key values
	'
	Function LoadRow()
		Dim RsRow, sSql, sFilter
		sFilter = Menutoppingsgroups.KeyFilter

		' Call Row Selecting event
		Call Menutoppingsgroups.Row_Selecting(sFilter)

		' Load sql based on filter
		Menutoppingsgroups.CurrentFilter = sFilter
		sSql = Menutoppingsgroups.SQL
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
		Call Menutoppingsgroups.Row_Selected(RsRow)
		Menutoppingsgroups.ID.DbValue = RsRow("ID")
		Menutoppingsgroups.toppingsgroup.DbValue = RsRow("toppingsgroup")
		Menutoppingsgroups.IdBusinessDetail.DbValue = RsRow("IdBusinessDetail")
		Menutoppingsgroups.printingname.DbValue = RsRow("printingname")
		Menutoppingsgroups.i_displaySort.DbValue = RsRow("i_displaySort")
	End Sub

	' Load DbValue from recordset
	Sub LoadDbValues(Rs)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		If Rs.Eof Then Exit Sub
		Menutoppingsgroups.ID.m_DbValue = Rs("ID")
		Menutoppingsgroups.toppingsgroup.m_DbValue = Rs("toppingsgroup")
		Menutoppingsgroups.IdBusinessDetail.m_DbValue = Rs("IdBusinessDetail")
		Menutoppingsgroups.printingname.m_DbValue = Rs("printingname")
		Menutoppingsgroups.i_displaySort.m_DbValue = Rs("i_displaySort")
	End Sub

	' Load old record
	Function LoadOldRecord()

		' Load key values from Session
		Dim bValidKey
		bValidKey = True
		If Menutoppingsgroups.GetKey("ID")&"" <> "" Then
			Menutoppingsgroups.ID.CurrentValue = Menutoppingsgroups.GetKey("ID") ' ID
		Else
			bValidKey = False
		End If

		' Load old recordset
		If bValidKey Then
			Menutoppingsgroups.CurrentFilter = Menutoppingsgroups.KeyFilter
			Dim sSql
			sSql = Menutoppingsgroups.SQL
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
		' Call Row Rendering event

		Call Menutoppingsgroups.Row_Rendering()

		' ---------------------------------------
		'  Common render codes for all row types
		' ---------------------------------------
		' ID
		' toppingsgroup
		' IdBusinessDetail
		' printingname
		' i_displaySort
		' -----------
		'  View  Row
		' -----------

		If Menutoppingsgroups.RowType = EW_ROWTYPE_VIEW Then ' View row

			' ID
			Menutoppingsgroups.ID.ViewValue = Menutoppingsgroups.ID.CurrentValue
			Menutoppingsgroups.ID.ViewCustomAttributes = ""

			' toppingsgroup
			Menutoppingsgroups.toppingsgroup.ViewValue = Menutoppingsgroups.toppingsgroup.CurrentValue
			Menutoppingsgroups.toppingsgroup.ViewCustomAttributes = ""

			' IdBusinessDetail
			Menutoppingsgroups.IdBusinessDetail.ViewValue = Menutoppingsgroups.IdBusinessDetail.CurrentValue
			Menutoppingsgroups.IdBusinessDetail.ViewCustomAttributes = ""

			' printingname
			Menutoppingsgroups.printingname.ViewValue = Menutoppingsgroups.printingname.CurrentValue
			Menutoppingsgroups.printingname.ViewCustomAttributes = ""

			' i_displaySort
			Menutoppingsgroups.i_displaySort.ViewValue = Menutoppingsgroups.i_displaySort.CurrentValue
			Menutoppingsgroups.i_displaySort.ViewCustomAttributes = ""

			' View refer script
			' toppingsgroup

			Menutoppingsgroups.toppingsgroup.LinkCustomAttributes = ""
			Menutoppingsgroups.toppingsgroup.HrefValue = ""
			Menutoppingsgroups.toppingsgroup.TooltipValue = ""

			' IdBusinessDetail
			Menutoppingsgroups.IdBusinessDetail.LinkCustomAttributes = ""
			Menutoppingsgroups.IdBusinessDetail.HrefValue = ""
			Menutoppingsgroups.IdBusinessDetail.TooltipValue = ""

			' printingname
			Menutoppingsgroups.printingname.LinkCustomAttributes = ""
			Menutoppingsgroups.printingname.HrefValue = ""
			Menutoppingsgroups.printingname.TooltipValue = ""

			' i_displaySort
			Menutoppingsgroups.i_displaySort.LinkCustomAttributes = ""
			Menutoppingsgroups.i_displaySort.HrefValue = ""
			Menutoppingsgroups.i_displaySort.TooltipValue = ""

		' ---------
		'  Add Row
		' ---------

		ElseIf Menutoppingsgroups.RowType = EW_ROWTYPE_ADD Then ' Add row

			' toppingsgroup
			Menutoppingsgroups.toppingsgroup.EditAttrs.UpdateAttribute "class", "form-control"
			Menutoppingsgroups.toppingsgroup.EditCustomAttributes = ""
			Menutoppingsgroups.toppingsgroup.EditValue = ew_HtmlEncode(Menutoppingsgroups.toppingsgroup.CurrentValue)
			Menutoppingsgroups.toppingsgroup.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Menutoppingsgroups.toppingsgroup.FldCaption))

			' IdBusinessDetail
			Menutoppingsgroups.IdBusinessDetail.EditAttrs.UpdateAttribute "class", "form-control"
			Menutoppingsgroups.IdBusinessDetail.EditCustomAttributes = ""
			Menutoppingsgroups.IdBusinessDetail.EditValue = ew_HtmlEncode(Menutoppingsgroups.IdBusinessDetail.CurrentValue)
			Menutoppingsgroups.IdBusinessDetail.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Menutoppingsgroups.IdBusinessDetail.FldCaption))

			' printingname
			Menutoppingsgroups.printingname.EditAttrs.UpdateAttribute "class", "form-control"
			Menutoppingsgroups.printingname.EditCustomAttributes = ""
			Menutoppingsgroups.printingname.EditValue = ew_HtmlEncode(Menutoppingsgroups.printingname.CurrentValue)
			Menutoppingsgroups.printingname.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Menutoppingsgroups.printingname.FldCaption))

			' i_displaySort
			Menutoppingsgroups.i_displaySort.EditAttrs.UpdateAttribute "class", "form-control"
			Menutoppingsgroups.i_displaySort.EditCustomAttributes = ""
			Menutoppingsgroups.i_displaySort.EditValue = ew_HtmlEncode(Menutoppingsgroups.i_displaySort.CurrentValue)
			Menutoppingsgroups.i_displaySort.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Menutoppingsgroups.i_displaySort.FldCaption))

			' Edit refer script
			' toppingsgroup

			Menutoppingsgroups.toppingsgroup.HrefValue = ""

			' IdBusinessDetail
			Menutoppingsgroups.IdBusinessDetail.HrefValue = ""

			' printingname
			Menutoppingsgroups.printingname.HrefValue = ""

			' i_displaySort
			Menutoppingsgroups.i_displaySort.HrefValue = ""
		End If
		If Menutoppingsgroups.RowType = EW_ROWTYPE_ADD Or Menutoppingsgroups.RowType = EW_ROWTYPE_EDIT Or Menutoppingsgroups.RowType = EW_ROWTYPE_SEARCH Then ' Add / Edit / Search row
			Call Menutoppingsgroups.SetupFieldTitles()
		End If

		' Call Row Rendered event
		If Menutoppingsgroups.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call Menutoppingsgroups.Row_Rendered()
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
		If Not ew_CheckInteger(Menutoppingsgroups.IdBusinessDetail.FormValue) Then
			Call ew_AddMessage(gsFormError, Menutoppingsgroups.IdBusinessDetail.FldErrMsg)
		End If
		If Not ew_CheckInteger(Menutoppingsgroups.i_displaySort.FormValue) Then
			Call ew_AddMessage(gsFormError, Menutoppingsgroups.i_displaySort.FldErrMsg)
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
		Menutoppingsgroups.CurrentFilter = sFilter
		sSql = Menutoppingsgroups.SQL
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

		' Field toppingsgroup
		Call Menutoppingsgroups.toppingsgroup.SetDbValue(Rs, Menutoppingsgroups.toppingsgroup.CurrentValue, Null, False)

		' Field IdBusinessDetail
		Call Menutoppingsgroups.IdBusinessDetail.SetDbValue(Rs, Menutoppingsgroups.IdBusinessDetail.CurrentValue, Null, False)

		' Field printingname
		Call Menutoppingsgroups.printingname.SetDbValue(Rs, Menutoppingsgroups.printingname.CurrentValue, Null, False)

		' Field i_displaySort
		Call Menutoppingsgroups.i_displaySort.SetDbValue(Rs, Menutoppingsgroups.i_displaySort.CurrentValue, Null, False)

		' Check recordset update error
		If Err.Number <> 0 Then
			FailureMessage = Err.Description
			Rs.Close
			Set Rs = Nothing
			AddRow = False
			Exit Function
		End If

		' Call Row Inserting event
		bInsertRow = Menutoppingsgroups.Row_Inserting(RsOld, Rs)
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
			ElseIf Menutoppingsgroups.CancelMessage <> "" Then
				FailureMessage = Menutoppingsgroups.CancelMessage
				Menutoppingsgroups.CancelMessage = ""
			Else
				FailureMessage = Language.Phrase("InsertCancelled")
			End If
			AddRow = False
		End If
		Rs.Close
		Set Rs = Nothing
		If AddRow Then
			Menutoppingsgroups.ID.DbValue = RsNew("ID")
		End If
		If AddRow Then

			' Call Row Inserted event
			Call Menutoppingsgroups.Row_Inserted(RsOld, RsNew)
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
		Call Breadcrumb.Add("list", Menutoppingsgroups.TableVar, "Menutoppingsgroupslist.asp", "", Menutoppingsgroups.TableVar, True)
		PageId = ew_IIf(Menutoppingsgroups.CurrentAction = "C", "Copy", "Add")
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
