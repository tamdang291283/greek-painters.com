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
Dim Category_Openning_Time_add
Set Category_Openning_Time_add = New cCategory_Openning_Time_add
Set Page = Category_Openning_Time_add

' Page init processing
Category_Openning_Time_add.Page_Init()

' Page main processing
Category_Openning_Time_add.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
Category_Openning_Time_add.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var Category_Openning_Time_add = new ew_Page("Category_Openning_Time_add");
Category_Openning_Time_add.PageID = "add"; // Page ID
var EW_PAGE_ID = Category_Openning_Time_add.PageID; // For backward compatibility
// Form object
var fCategory_Openning_Timeadd = new ew_Form("fCategory_Openning_Timeadd");
// Validate form
fCategory_Openning_Timeadd.Validate = function() {
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
fCategory_Openning_Timeadd.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fCategory_Openning_Timeadd.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fCategory_Openning_Timeadd.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<div class="ewToolbar">
<% If Category_Openning_Time.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If Category_Openning_Time.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% Category_Openning_Time_add.ShowPageHeader() %>
<% Category_Openning_Time_add.ShowMessage %>
<form name="fCategory_Openning_Timeadd" id="fCategory_Openning_Timeadd" class="form-horizontal ewForm ewAddForm" action="<%= ew_CurrentPage() %>" method="post">
<% If Category_Openning_Time_add.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= Category_Openning_Time_add.Token %>">
<% End If %>
<input type="hidden" name="t" value="Category_Openning_Time">
<input type="hidden" name="a_add" id="a_add" value="A">
<div>
<% If Category_Openning_Time.CategoryID.Visible Then ' CategoryID %>
	<div id="r_CategoryID" class="form-group">
		<label id="elh_Category_Openning_Time_CategoryID" for="x_CategoryID" class="col-sm-2 control-label ewLabel"><%= Category_Openning_Time.CategoryID.FldCaption %></label>
		<div class="col-sm-10"><div<%= Category_Openning_Time.CategoryID.CellAttributes %>>
<span id="el_Category_Openning_Time_CategoryID">
<input type="text" data-field="x_CategoryID" name="x_CategoryID" id="x_CategoryID" size="30" placeholder="<%= Category_Openning_Time.CategoryID.PlaceHolder %>" value="<%= Category_Openning_Time.CategoryID.EditValue %>"<%= Category_Openning_Time.CategoryID.EditAttributes %>>
</span>
<%= Category_Openning_Time.CategoryID.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Category_Openning_Time.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
	<div id="r_IdBusinessDetail" class="form-group">
		<label id="elh_Category_Openning_Time_IdBusinessDetail" for="x_IdBusinessDetail" class="col-sm-2 control-label ewLabel"><%= Category_Openning_Time.IdBusinessDetail.FldCaption %></label>
		<div class="col-sm-10"><div<%= Category_Openning_Time.IdBusinessDetail.CellAttributes %>>
<span id="el_Category_Openning_Time_IdBusinessDetail">
<input type="text" data-field="x_IdBusinessDetail" name="x_IdBusinessDetail" id="x_IdBusinessDetail" size="30" placeholder="<%= Category_Openning_Time.IdBusinessDetail.PlaceHolder %>" value="<%= Category_Openning_Time.IdBusinessDetail.EditValue %>"<%= Category_Openning_Time.IdBusinessDetail.EditAttributes %>>
</span>
<%= Category_Openning_Time.IdBusinessDetail.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Category_Openning_Time.Hour_From.Visible Then ' Hour_From %>
	<div id="r_Hour_From" class="form-group">
		<label id="elh_Category_Openning_Time_Hour_From" for="x_Hour_From" class="col-sm-2 control-label ewLabel"><%= Category_Openning_Time.Hour_From.FldCaption %></label>
		<div class="col-sm-10"><div<%= Category_Openning_Time.Hour_From.CellAttributes %>>
<span id="el_Category_Openning_Time_Hour_From">
<input type="text" data-field="x_Hour_From" name="x_Hour_From" id="x_Hour_From" size="30" placeholder="<%= Category_Openning_Time.Hour_From.PlaceHolder %>" value="<%= Category_Openning_Time.Hour_From.EditValue %>"<%= Category_Openning_Time.Hour_From.EditAttributes %>>
</span>
<%= Category_Openning_Time.Hour_From.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Category_Openning_Time.Hour_To.Visible Then ' Hour_To %>
	<div id="r_Hour_To" class="form-group">
		<label id="elh_Category_Openning_Time_Hour_To" for="x_Hour_To" class="col-sm-2 control-label ewLabel"><%= Category_Openning_Time.Hour_To.FldCaption %></label>
		<div class="col-sm-10"><div<%= Category_Openning_Time.Hour_To.CellAttributes %>>
<span id="el_Category_Openning_Time_Hour_To">
<input type="text" data-field="x_Hour_To" name="x_Hour_To" id="x_Hour_To" size="30" placeholder="<%= Category_Openning_Time.Hour_To.PlaceHolder %>" value="<%= Category_Openning_Time.Hour_To.EditValue %>"<%= Category_Openning_Time.Hour_To.EditAttributes %>>
</span>
<%= Category_Openning_Time.Hour_To.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Category_Openning_Time.DayValue.Visible Then ' DayValue %>
	<div id="r_DayValue" class="form-group">
		<label id="elh_Category_Openning_Time_DayValue" for="x_DayValue" class="col-sm-2 control-label ewLabel"><%= Category_Openning_Time.DayValue.FldCaption %></label>
		<div class="col-sm-10"><div<%= Category_Openning_Time.DayValue.CellAttributes %>>
<span id="el_Category_Openning_Time_DayValue">
<input type="text" data-field="x_DayValue" name="x_DayValue" id="x_DayValue" size="30" placeholder="<%= Category_Openning_Time.DayValue.PlaceHolder %>" value="<%= Category_Openning_Time.DayValue.EditValue %>"<%= Category_Openning_Time.DayValue.EditAttributes %>>
</span>
<%= Category_Openning_Time.DayValue.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Category_Openning_Time.Dayname.Visible Then ' Dayname %>
	<div id="r_Dayname" class="form-group">
		<label id="elh_Category_Openning_Time_Dayname" for="x_Dayname" class="col-sm-2 control-label ewLabel"><%= Category_Openning_Time.Dayname.FldCaption %></label>
		<div class="col-sm-10"><div<%= Category_Openning_Time.Dayname.CellAttributes %>>
<span id="el_Category_Openning_Time_Dayname">
<input type="text" data-field="x_Dayname" name="x_Dayname" id="x_Dayname" size="30" maxlength="255" placeholder="<%= Category_Openning_Time.Dayname.PlaceHolder %>" value="<%= Category_Openning_Time.Dayname.EditValue %>"<%= Category_Openning_Time.Dayname.EditAttributes %>>
</span>
<%= Category_Openning_Time.Dayname.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Category_Openning_Time.status.Visible Then ' status %>
	<div id="r_status" class="form-group">
		<label id="elh_Category_Openning_Time_status" for="x_status" class="col-sm-2 control-label ewLabel"><%= Category_Openning_Time.status.FldCaption %></label>
		<div class="col-sm-10"><div<%= Category_Openning_Time.status.CellAttributes %>>
<span id="el_Category_Openning_Time_status">
<input type="text" data-field="x_status" name="x_status" id="x_status" size="30" maxlength="255" placeholder="<%= Category_Openning_Time.status.PlaceHolder %>" value="<%= Category_Openning_Time.status.EditValue %>"<%= Category_Openning_Time.status.EditAttributes %>>
</span>
<%= Category_Openning_Time.status.CustomMsg %></div></div>
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
fCategory_Openning_Timeadd.Init();
</script>
<%
Category_Openning_Time_add.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set Category_Openning_Time_add = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cCategory_Openning_Time_add

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
		TableName = "Category_Openning_Time"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "Category_Openning_Time_add"
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
		EW_PAGE_ID = "add"

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
			Category_Openning_Time.CurrentAction = ObjForm.GetValue("a_add") ' Get form action
			CopyRecord = LoadOldRecord() ' Load old recordset
			Call LoadFormValues() ' Load form values

		' Not post back
		Else

			' Load key values from QueryString
			CopyRecord = True
			If Request.QueryString("ID").Count > 0 Then
				Category_Openning_Time.ID.QueryStringValue = Request.QueryString("ID")
				Call Category_Openning_Time.SetKey("ID", Category_Openning_Time.ID.CurrentValue) ' Set up key
			Else
				Call Category_Openning_Time.SetKey("ID", "") ' Clear key
				CopyRecord = False
			End If
			If CopyRecord Then
				Category_Openning_Time.CurrentAction = "C" ' Copy Record
			Else
				Category_Openning_Time.CurrentAction = "I" ' Display Blank Record
				Call LoadDefaultValues() ' Load default values
			End If
		End If

		' Set up Breadcrumb
		SetupBreadcrumb()

		' Validate form if post back
		If ObjForm.GetValue("a_add")&"" <> "" Then
			If Not ValidateForm() Then
				Category_Openning_Time.CurrentAction = "I" ' Form error, reset action
				Category_Openning_Time.EventCancelled = True ' Event cancelled
				Call RestoreFormValues() ' Restore form values
				FailureMessage = gsFormError
			End If
		End If

		' Perform action based on action code
		Select Case Category_Openning_Time.CurrentAction
			Case "I" ' Blank record, no action required
			Case "C" ' Copy an existing record
				If Not LoadRow() Then ' Load record based on key
					If FailureMessage = "" Then FailureMessage = Language.Phrase("NoRecord") ' No record found
					Call Page_Terminate("Category_Openning_Timelist.asp") ' No matching record, return to list
				End If
			Case "A" ' Add new record
				Category_Openning_Time.SendEmail = True ' Send email on add success
				If AddRow(OldRecordset) Then ' Add successful
					If SuccessMessage = "" Then SuccessMessage = Language.Phrase("AddSuccess") ' Set up success message
					Dim sReturnUrl
					sReturnUrl = Category_Openning_Time.ReturnUrl
					If ew_GetPageName(sReturnUrl) = "Category_Openning_Timeview.asp" Then sReturnUrl = Category_Openning_Time.ViewUrl("") ' View paging, return to view page with keyurl directly
					Call Page_Terminate(sReturnUrl) ' Clean up and return
				Else
					Category_Openning_Time.EventCancelled = True ' Event cancelled
					Call RestoreFormValues() ' Add failed, restore form values
				End If
		End Select

		' Render row based on row type
		Category_Openning_Time.RowType = EW_ROWTYPE_ADD ' Render add type

		' Render row
		Call Category_Openning_Time.ResetAttrs()
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
		Category_Openning_Time.CategoryID.CurrentValue = Null
		Category_Openning_Time.CategoryID.OldValue = Category_Openning_Time.CategoryID.CurrentValue
		Category_Openning_Time.IdBusinessDetail.CurrentValue = Null
		Category_Openning_Time.IdBusinessDetail.OldValue = Category_Openning_Time.IdBusinessDetail.CurrentValue
		Category_Openning_Time.Hour_From.CurrentValue = Null
		Category_Openning_Time.Hour_From.OldValue = Category_Openning_Time.Hour_From.CurrentValue
		Category_Openning_Time.Hour_To.CurrentValue = Null
		Category_Openning_Time.Hour_To.OldValue = Category_Openning_Time.Hour_To.CurrentValue
		Category_Openning_Time.DayValue.CurrentValue = Null
		Category_Openning_Time.DayValue.OldValue = Category_Openning_Time.DayValue.CurrentValue
		Category_Openning_Time.Dayname.CurrentValue = Null
		Category_Openning_Time.Dayname.OldValue = Category_Openning_Time.Dayname.CurrentValue
		Category_Openning_Time.status.CurrentValue = Null
		Category_Openning_Time.status.OldValue = Category_Openning_Time.status.CurrentValue
	End Function

	' -----------------------------------------------------------------
	' Load form values
	'
	Function LoadFormValues()

		' Load values from form
		If Not Category_Openning_Time.CategoryID.FldIsDetailKey Then Category_Openning_Time.CategoryID.FormValue = ObjForm.GetValue("x_CategoryID")
		If Not Category_Openning_Time.IdBusinessDetail.FldIsDetailKey Then Category_Openning_Time.IdBusinessDetail.FormValue = ObjForm.GetValue("x_IdBusinessDetail")
		If Not Category_Openning_Time.Hour_From.FldIsDetailKey Then Category_Openning_Time.Hour_From.FormValue = ObjForm.GetValue("x_Hour_From")
		If Not Category_Openning_Time.Hour_To.FldIsDetailKey Then Category_Openning_Time.Hour_To.FormValue = ObjForm.GetValue("x_Hour_To")
		If Not Category_Openning_Time.DayValue.FldIsDetailKey Then Category_Openning_Time.DayValue.FormValue = ObjForm.GetValue("x_DayValue")
		If Not Category_Openning_Time.Dayname.FldIsDetailKey Then Category_Openning_Time.Dayname.FormValue = ObjForm.GetValue("x_Dayname")
		If Not Category_Openning_Time.status.FldIsDetailKey Then Category_Openning_Time.status.FormValue = ObjForm.GetValue("x_status")
	End Function

	' -----------------------------------------------------------------
	' Restore form values
	'
	Function RestoreFormValues()
		Call LoadOldRecord()
		Category_Openning_Time.CategoryID.CurrentValue = Category_Openning_Time.CategoryID.FormValue
		Category_Openning_Time.IdBusinessDetail.CurrentValue = Category_Openning_Time.IdBusinessDetail.FormValue
		Category_Openning_Time.Hour_From.CurrentValue = Category_Openning_Time.Hour_From.FormValue
		Category_Openning_Time.Hour_To.CurrentValue = Category_Openning_Time.Hour_To.FormValue
		Category_Openning_Time.DayValue.CurrentValue = Category_Openning_Time.DayValue.FormValue
		Category_Openning_Time.Dayname.CurrentValue = Category_Openning_Time.Dayname.FormValue
		Category_Openning_Time.status.CurrentValue = Category_Openning_Time.status.FormValue
	End Function

	' -----------------------------------------------------------------
	' Load row based on key values
	'
	Function LoadRow()
		Dim RsRow, sSql, sFilter
		sFilter = Category_Openning_Time.KeyFilter

		' Call Row Selecting event
		Call Category_Openning_Time.Row_Selecting(sFilter)

		' Load sql based on filter
		Category_Openning_Time.CurrentFilter = sFilter
		sSql = Category_Openning_Time.SQL
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
		Call Category_Openning_Time.Row_Selected(RsRow)
		Category_Openning_Time.ID.DbValue = RsRow("ID")
		Category_Openning_Time.CategoryID.DbValue = RsRow("CategoryID")
		Category_Openning_Time.IdBusinessDetail.DbValue = RsRow("IdBusinessDetail")
		Category_Openning_Time.Hour_From.DbValue = RsRow("Hour_From")
		Category_Openning_Time.Hour_To.DbValue = RsRow("Hour_To")
		Category_Openning_Time.DayValue.DbValue = RsRow("DayValue")
		Category_Openning_Time.Dayname.DbValue = RsRow("Dayname")
		Category_Openning_Time.status.DbValue = RsRow("status")
	End Sub

	' Load DbValue from recordset
	Sub LoadDbValues(Rs)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		If Rs.Eof Then Exit Sub
		Category_Openning_Time.ID.m_DbValue = Rs("ID")
		Category_Openning_Time.CategoryID.m_DbValue = Rs("CategoryID")
		Category_Openning_Time.IdBusinessDetail.m_DbValue = Rs("IdBusinessDetail")
		Category_Openning_Time.Hour_From.m_DbValue = Rs("Hour_From")
		Category_Openning_Time.Hour_To.m_DbValue = Rs("Hour_To")
		Category_Openning_Time.DayValue.m_DbValue = Rs("DayValue")
		Category_Openning_Time.Dayname.m_DbValue = Rs("Dayname")
		Category_Openning_Time.status.m_DbValue = Rs("status")
	End Sub

	' Load old record
	Function LoadOldRecord()

		' Load key values from Session
		Dim bValidKey
		bValidKey = True
		If Category_Openning_Time.GetKey("ID")&"" <> "" Then
			Category_Openning_Time.ID.CurrentValue = Category_Openning_Time.GetKey("ID") ' ID
		Else
			bValidKey = False
		End If

		' Load old recordset
		If bValidKey Then
			Category_Openning_Time.CurrentFilter = Category_Openning_Time.KeyFilter
			Dim sSql
			sSql = Category_Openning_Time.SQL
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

		' ---------
		'  Add Row
		' ---------

		ElseIf Category_Openning_Time.RowType = EW_ROWTYPE_ADD Then ' Add row

			' CategoryID
			Category_Openning_Time.CategoryID.EditAttrs.UpdateAttribute "class", "form-control"
			Category_Openning_Time.CategoryID.EditCustomAttributes = ""
			Category_Openning_Time.CategoryID.EditValue = ew_HtmlEncode(Category_Openning_Time.CategoryID.CurrentValue)
			Category_Openning_Time.CategoryID.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Category_Openning_Time.CategoryID.FldCaption))

			' IdBusinessDetail
			Category_Openning_Time.IdBusinessDetail.EditAttrs.UpdateAttribute "class", "form-control"
			Category_Openning_Time.IdBusinessDetail.EditCustomAttributes = ""
			Category_Openning_Time.IdBusinessDetail.EditValue = ew_HtmlEncode(Category_Openning_Time.IdBusinessDetail.CurrentValue)
			Category_Openning_Time.IdBusinessDetail.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Category_Openning_Time.IdBusinessDetail.FldCaption))

			' Hour_From
			Category_Openning_Time.Hour_From.EditAttrs.UpdateAttribute "class", "form-control"
			Category_Openning_Time.Hour_From.EditCustomAttributes = ""
			Category_Openning_Time.Hour_From.EditValue = ew_FormatDateTime(Category_Openning_Time.Hour_From.CurrentValue, 99)
			Category_Openning_Time.Hour_From.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Category_Openning_Time.Hour_From.FldCaption))

			' Hour_To
			Category_Openning_Time.Hour_To.EditAttrs.UpdateAttribute "class", "form-control"
			Category_Openning_Time.Hour_To.EditCustomAttributes = ""
			Category_Openning_Time.Hour_To.EditValue = ew_FormatDateTime(Category_Openning_Time.Hour_To.CurrentValue, 99)
			Category_Openning_Time.Hour_To.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Category_Openning_Time.Hour_To.FldCaption))

			' DayValue
			Category_Openning_Time.DayValue.EditAttrs.UpdateAttribute "class", "form-control"
			Category_Openning_Time.DayValue.EditCustomAttributes = ""
			Category_Openning_Time.DayValue.EditValue = ew_HtmlEncode(Category_Openning_Time.DayValue.CurrentValue)
			Category_Openning_Time.DayValue.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Category_Openning_Time.DayValue.FldCaption))

			' Dayname
			Category_Openning_Time.Dayname.EditAttrs.UpdateAttribute "class", "form-control"
			Category_Openning_Time.Dayname.EditCustomAttributes = ""
			Category_Openning_Time.Dayname.EditValue = ew_HtmlEncode(Category_Openning_Time.Dayname.CurrentValue)
			Category_Openning_Time.Dayname.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Category_Openning_Time.Dayname.FldCaption))

			' status
			Category_Openning_Time.status.EditAttrs.UpdateAttribute "class", "form-control"
			Category_Openning_Time.status.EditCustomAttributes = ""
			Category_Openning_Time.status.EditValue = ew_HtmlEncode(Category_Openning_Time.status.CurrentValue)
			Category_Openning_Time.status.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Category_Openning_Time.status.FldCaption))

			' Edit refer script
			' CategoryID

			Category_Openning_Time.CategoryID.HrefValue = ""

			' IdBusinessDetail
			Category_Openning_Time.IdBusinessDetail.HrefValue = ""

			' Hour_From
			Category_Openning_Time.Hour_From.HrefValue = ""

			' Hour_To
			Category_Openning_Time.Hour_To.HrefValue = ""

			' DayValue
			Category_Openning_Time.DayValue.HrefValue = ""

			' Dayname
			Category_Openning_Time.Dayname.HrefValue = ""

			' status
			Category_Openning_Time.status.HrefValue = ""
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
		If Not ew_CheckInteger(Category_Openning_Time.CategoryID.FormValue) Then
			Call ew_AddMessage(gsFormError, Category_Openning_Time.CategoryID.FldErrMsg)
		End If
		If Not ew_CheckInteger(Category_Openning_Time.IdBusinessDetail.FormValue) Then
			Call ew_AddMessage(gsFormError, Category_Openning_Time.IdBusinessDetail.FldErrMsg)
		End If
		If Not ew_CheckInteger(Category_Openning_Time.DayValue.FormValue) Then
			Call ew_AddMessage(gsFormError, Category_Openning_Time.DayValue.FldErrMsg)
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
		Category_Openning_Time.CurrentFilter = sFilter
		sSql = Category_Openning_Time.SQL
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

		' Field CategoryID
		Call Category_Openning_Time.CategoryID.SetDbValue(Rs, Category_Openning_Time.CategoryID.CurrentValue, Null, False)

		' Field IdBusinessDetail
		Call Category_Openning_Time.IdBusinessDetail.SetDbValue(Rs, Category_Openning_Time.IdBusinessDetail.CurrentValue, Null, False)

		' Field Hour_From
		Call Category_Openning_Time.Hour_From.SetDbValue(Rs, Category_Openning_Time.Hour_From.CurrentValue, Null, False)

		' Field Hour_To
		Call Category_Openning_Time.Hour_To.SetDbValue(Rs, Category_Openning_Time.Hour_To.CurrentValue, Null, False)

		' Field DayValue
		Call Category_Openning_Time.DayValue.SetDbValue(Rs, Category_Openning_Time.DayValue.CurrentValue, Null, False)

		' Field Dayname
		Call Category_Openning_Time.Dayname.SetDbValue(Rs, Category_Openning_Time.Dayname.CurrentValue, Null, False)

		' Field status
		Call Category_Openning_Time.status.SetDbValue(Rs, Category_Openning_Time.status.CurrentValue, Null, False)

		' Check recordset update error
		If Err.Number <> 0 Then
			FailureMessage = Err.Description
			Rs.Close
			Set Rs = Nothing
			AddRow = False
			Exit Function
		End If

		' Call Row Inserting event
		bInsertRow = Category_Openning_Time.Row_Inserting(RsOld, Rs)
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
			ElseIf Category_Openning_Time.CancelMessage <> "" Then
				FailureMessage = Category_Openning_Time.CancelMessage
				Category_Openning_Time.CancelMessage = ""
			Else
				FailureMessage = Language.Phrase("InsertCancelled")
			End If
			AddRow = False
		End If
		Rs.Close
		Set Rs = Nothing
		If AddRow Then
			Category_Openning_Time.ID.DbValue = RsNew("ID")
		End If
		If AddRow Then

			' Call Row Inserted event
			Call Category_Openning_Time.Row_Inserted(RsOld, RsNew)
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
		Call Breadcrumb.Add("list", Category_Openning_Time.TableVar, "Category_Openning_Timelist.asp", "", Category_Openning_Time.TableVar, True)
		PageId = ew_IIf(Category_Openning_Time.CurrentAction = "C", "Copy", "Add")
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
