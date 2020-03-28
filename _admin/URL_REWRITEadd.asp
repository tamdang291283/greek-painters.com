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
Dim URL_REWRITE_add
Set URL_REWRITE_add = New cURL_REWRITE_add
Set Page = URL_REWRITE_add

' Page init processing
URL_REWRITE_add.Page_Init()

' Page main processing
URL_REWRITE_add.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
URL_REWRITE_add.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var URL_REWRITE_add = new ew_Page("URL_REWRITE_add");
URL_REWRITE_add.PageID = "add"; // Page ID
var EW_PAGE_ID = URL_REWRITE_add.PageID; // For backward compatibility
// Form object
var fURL_REWRITEadd = new ew_Form("fURL_REWRITEadd");
// Validate form
fURL_REWRITEadd.Validate = function() {
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
			elm = this.GetElements("x" + infix + "_RestaurantID");
			if (elm && !ew_CheckInteger(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(URL_REWRITE.RestaurantID.FldErrMsg) %>");
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
fURL_REWRITEadd.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fURL_REWRITEadd.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fURL_REWRITEadd.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<div class="ewToolbar">
<% If URL_REWRITE.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If URL_REWRITE.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% URL_REWRITE_add.ShowPageHeader() %>
<% URL_REWRITE_add.ShowMessage %>
<form name="fURL_REWRITEadd" id="fURL_REWRITEadd" class="form-horizontal ewForm ewAddForm" action="<%= ew_CurrentPage() %>" method="post">
<% If URL_REWRITE_add.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= URL_REWRITE_add.Token %>">
<% End If %>
<input type="hidden" name="t" value="URL_REWRITE">
<input type="hidden" name="a_add" id="a_add" value="A">
<div>
<% If URL_REWRITE.FromLink.Visible Then ' FromLink %>
	<div id="r_FromLink" class="form-group">
		<label id="elh_URL_REWRITE_FromLink" for="x_FromLink" class="col-sm-2 control-label ewLabel"><%= URL_REWRITE.FromLink.FldCaption %></label>
		<div class="col-sm-10"><div<%= URL_REWRITE.FromLink.CellAttributes %>>
<span id="el_URL_REWRITE_FromLink">
<input type="text" data-field="x_FromLink" name="x_FromLink" id="x_FromLink" size="30" maxlength="255" placeholder="<%= URL_REWRITE.FromLink.PlaceHolder %>" value="<%= URL_REWRITE.FromLink.EditValue %>"<%= URL_REWRITE.FromLink.EditAttributes %>>
</span>
<%= URL_REWRITE.FromLink.CustomMsg %></div></div>
	</div>
<% End If %>
<% If URL_REWRITE.Tolink.Visible Then ' Tolink %>
	<div id="r_Tolink" class="form-group">
		<label id="elh_URL_REWRITE_Tolink" for="x_Tolink" class="col-sm-2 control-label ewLabel"><%= URL_REWRITE.Tolink.FldCaption %></label>
		<div class="col-sm-10"><div<%= URL_REWRITE.Tolink.CellAttributes %>>
<span id="el_URL_REWRITE_Tolink">
<input type="text" data-field="x_Tolink" name="x_Tolink" id="x_Tolink" size="30" maxlength="255" placeholder="<%= URL_REWRITE.Tolink.PlaceHolder %>" value="<%= URL_REWRITE.Tolink.EditValue %>"<%= URL_REWRITE.Tolink.EditAttributes %>>
</span>
<%= URL_REWRITE.Tolink.CustomMsg %></div></div>
	</div>
<% End If %>
<% If URL_REWRITE.RestaurantID.Visible Then ' RestaurantID %>
	<div id="r_RestaurantID" class="form-group">
		<label id="elh_URL_REWRITE_RestaurantID" for="x_RestaurantID" class="col-sm-2 control-label ewLabel"><%= URL_REWRITE.RestaurantID.FldCaption %></label>
		<div class="col-sm-10"><div<%= URL_REWRITE.RestaurantID.CellAttributes %>>
<span id="el_URL_REWRITE_RestaurantID">
<input type="text" data-field="x_RestaurantID" name="x_RestaurantID" id="x_RestaurantID" size="30" placeholder="<%= URL_REWRITE.RestaurantID.PlaceHolder %>" value="<%= URL_REWRITE.RestaurantID.EditValue %>"<%= URL_REWRITE.RestaurantID.EditAttributes %>>
</span>
<%= URL_REWRITE.RestaurantID.CustomMsg %></div></div>
	</div>
<% End If %>
<% If URL_REWRITE.Status.Visible Then ' Status %>
	<div id="r_Status" class="form-group">
		<label id="elh_URL_REWRITE_Status" for="x_Status" class="col-sm-2 control-label ewLabel"><%= URL_REWRITE.Status.FldCaption %></label>
		<div class="col-sm-10"><div<%= URL_REWRITE.Status.CellAttributes %>>
<span id="el_URL_REWRITE_Status">
<input type="text" data-field="x_Status" name="x_Status" id="x_Status" size="30" maxlength="255" placeholder="<%= URL_REWRITE.Status.PlaceHolder %>" value="<%= URL_REWRITE.Status.EditValue %>"<%= URL_REWRITE.Status.EditAttributes %>>
</span>
<%= URL_REWRITE.Status.CustomMsg %></div></div>
	</div>
<% End If %>
<% If URL_REWRITE.businessname.Visible Then ' businessname %>
	<div id="r_businessname" class="form-group">
		<label id="elh_URL_REWRITE_businessname" for="x_businessname" class="col-sm-2 control-label ewLabel"><%= URL_REWRITE.businessname.FldCaption %></label>
		<div class="col-sm-10"><div<%= URL_REWRITE.businessname.CellAttributes %>>
<span id="el_URL_REWRITE_businessname">
<input type="text" data-field="x_businessname" name="x_businessname" id="x_businessname" size="30" maxlength="255" placeholder="<%= URL_REWRITE.businessname.PlaceHolder %>" value="<%= URL_REWRITE.businessname.EditValue %>"<%= URL_REWRITE.businessname.EditAttributes %>>
</span>
<%= URL_REWRITE.businessname.CustomMsg %></div></div>
	</div>
<% End If %>
<% If URL_REWRITE.postcode.Visible Then ' postcode %>
	<div id="r_postcode" class="form-group">
		<label id="elh_URL_REWRITE_postcode" for="x_postcode" class="col-sm-2 control-label ewLabel"><%= URL_REWRITE.postcode.FldCaption %></label>
		<div class="col-sm-10"><div<%= URL_REWRITE.postcode.CellAttributes %>>
<span id="el_URL_REWRITE_postcode">
<input type="text" data-field="x_postcode" name="x_postcode" id="x_postcode" size="30" maxlength="255" placeholder="<%= URL_REWRITE.postcode.PlaceHolder %>" value="<%= URL_REWRITE.postcode.EditValue %>"<%= URL_REWRITE.postcode.EditAttributes %>>
</span>
<%= URL_REWRITE.postcode.CustomMsg %></div></div>
	</div>
<% End If %>
<% If URL_REWRITE.phonenumber.Visible Then ' phonenumber %>
	<div id="r_phonenumber" class="form-group">
		<label id="elh_URL_REWRITE_phonenumber" for="x_phonenumber" class="col-sm-2 control-label ewLabel"><%= URL_REWRITE.phonenumber.FldCaption %></label>
		<div class="col-sm-10"><div<%= URL_REWRITE.phonenumber.CellAttributes %>>
<span id="el_URL_REWRITE_phonenumber">
<input type="text" data-field="x_phonenumber" name="x_phonenumber" id="x_phonenumber" size="30" maxlength="255" placeholder="<%= URL_REWRITE.phonenumber.PlaceHolder %>" value="<%= URL_REWRITE.phonenumber.EditValue %>"<%= URL_REWRITE.phonenumber.EditAttributes %>>
</span>
<%= URL_REWRITE.phonenumber.CustomMsg %></div></div>
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
fURL_REWRITEadd.Init();
</script>
<%
URL_REWRITE_add.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set URL_REWRITE_add = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cURL_REWRITE_add

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
		TableName = "URL_REWRITE"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "URL_REWRITE_add"
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
		EW_PAGE_ID = "add"

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
			URL_REWRITE.CurrentAction = ObjForm.GetValue("a_add") ' Get form action
			CopyRecord = LoadOldRecord() ' Load old recordset
			Call LoadFormValues() ' Load form values

		' Not post back
		Else

			' Load key values from QueryString
			CopyRecord = True
			If Request.QueryString("ID").Count > 0 Then
				URL_REWRITE.ID.QueryStringValue = Request.QueryString("ID")
				Call URL_REWRITE.SetKey("ID", URL_REWRITE.ID.CurrentValue) ' Set up key
			Else
				Call URL_REWRITE.SetKey("ID", "") ' Clear key
				CopyRecord = False
			End If
			If CopyRecord Then
				URL_REWRITE.CurrentAction = "C" ' Copy Record
			Else
				URL_REWRITE.CurrentAction = "I" ' Display Blank Record
				Call LoadDefaultValues() ' Load default values
			End If
		End If

		' Set up Breadcrumb
		SetupBreadcrumb()

		' Validate form if post back
		If ObjForm.GetValue("a_add")&"" <> "" Then
			If Not ValidateForm() Then
				URL_REWRITE.CurrentAction = "I" ' Form error, reset action
				URL_REWRITE.EventCancelled = True ' Event cancelled
				Call RestoreFormValues() ' Restore form values
				FailureMessage = gsFormError
			End If
		End If

		' Perform action based on action code
		Select Case URL_REWRITE.CurrentAction
			Case "I" ' Blank record, no action required
			Case "C" ' Copy an existing record
				If Not LoadRow() Then ' Load record based on key
					If FailureMessage = "" Then FailureMessage = Language.Phrase("NoRecord") ' No record found
					Call Page_Terminate("URL_REWRITElist.asp") ' No matching record, return to list
				End If
			Case "A" ' Add new record
				URL_REWRITE.SendEmail = True ' Send email on add success
				If AddRow(OldRecordset) Then ' Add successful
					If SuccessMessage = "" Then SuccessMessage = Language.Phrase("AddSuccess") ' Set up success message
					Dim sReturnUrl
					sReturnUrl = URL_REWRITE.ReturnUrl
					If ew_GetPageName(sReturnUrl) = "URL_REWRITEview.asp" Then sReturnUrl = URL_REWRITE.ViewUrl("") ' View paging, return to view page with keyurl directly
					Call Page_Terminate(sReturnUrl) ' Clean up and return
				Else
					URL_REWRITE.EventCancelled = True ' Event cancelled
					Call RestoreFormValues() ' Add failed, restore form values
				End If
		End Select

		' Render row based on row type
		URL_REWRITE.RowType = EW_ROWTYPE_ADD ' Render add type

		' Render row
		Call URL_REWRITE.ResetAttrs()
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
		URL_REWRITE.FromLink.CurrentValue = Null
		URL_REWRITE.FromLink.OldValue = URL_REWRITE.FromLink.CurrentValue
		URL_REWRITE.Tolink.CurrentValue = Null
		URL_REWRITE.Tolink.OldValue = URL_REWRITE.Tolink.CurrentValue
		URL_REWRITE.RestaurantID.CurrentValue = Null
		URL_REWRITE.RestaurantID.OldValue = URL_REWRITE.RestaurantID.CurrentValue
		URL_REWRITE.Status.CurrentValue = Null
		URL_REWRITE.Status.OldValue = URL_REWRITE.Status.CurrentValue
		URL_REWRITE.businessname.CurrentValue = Null
		URL_REWRITE.businessname.OldValue = URL_REWRITE.businessname.CurrentValue
		URL_REWRITE.postcode.CurrentValue = Null
		URL_REWRITE.postcode.OldValue = URL_REWRITE.postcode.CurrentValue
		URL_REWRITE.phonenumber.CurrentValue = Null
		URL_REWRITE.phonenumber.OldValue = URL_REWRITE.phonenumber.CurrentValue
	End Function

	' -----------------------------------------------------------------
	' Load form values
	'
	Function LoadFormValues()

		' Load values from form
		If Not URL_REWRITE.FromLink.FldIsDetailKey Then URL_REWRITE.FromLink.FormValue = ObjForm.GetValue("x_FromLink")
		If Not URL_REWRITE.Tolink.FldIsDetailKey Then URL_REWRITE.Tolink.FormValue = ObjForm.GetValue("x_Tolink")
		If Not URL_REWRITE.RestaurantID.FldIsDetailKey Then URL_REWRITE.RestaurantID.FormValue = ObjForm.GetValue("x_RestaurantID")
		If Not URL_REWRITE.Status.FldIsDetailKey Then URL_REWRITE.Status.FormValue = ObjForm.GetValue("x_Status")
		If Not URL_REWRITE.businessname.FldIsDetailKey Then URL_REWRITE.businessname.FormValue = ObjForm.GetValue("x_businessname")
		If Not URL_REWRITE.postcode.FldIsDetailKey Then URL_REWRITE.postcode.FormValue = ObjForm.GetValue("x_postcode")
		If Not URL_REWRITE.phonenumber.FldIsDetailKey Then URL_REWRITE.phonenumber.FormValue = ObjForm.GetValue("x_phonenumber")
	End Function

	' -----------------------------------------------------------------
	' Restore form values
	'
	Function RestoreFormValues()
		Call LoadOldRecord()
		URL_REWRITE.FromLink.CurrentValue = URL_REWRITE.FromLink.FormValue
		URL_REWRITE.Tolink.CurrentValue = URL_REWRITE.Tolink.FormValue
		URL_REWRITE.RestaurantID.CurrentValue = URL_REWRITE.RestaurantID.FormValue
		URL_REWRITE.Status.CurrentValue = URL_REWRITE.Status.FormValue
		URL_REWRITE.businessname.CurrentValue = URL_REWRITE.businessname.FormValue
		URL_REWRITE.postcode.CurrentValue = URL_REWRITE.postcode.FormValue
		URL_REWRITE.phonenumber.CurrentValue = URL_REWRITE.phonenumber.FormValue
	End Function

	' -----------------------------------------------------------------
	' Load row based on key values
	'
	Function LoadRow()
		Dim RsRow, sSql, sFilter
		sFilter = URL_REWRITE.KeyFilter

		' Call Row Selecting event
		Call URL_REWRITE.Row_Selecting(sFilter)

		' Load sql based on filter
		URL_REWRITE.CurrentFilter = sFilter
		sSql = URL_REWRITE.SQL
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
		Call URL_REWRITE.Row_Selected(RsRow)
		URL_REWRITE.ID.DbValue = RsRow("ID")
		URL_REWRITE.FromLink.DbValue = RsRow("FromLink")
		URL_REWRITE.Tolink.DbValue = RsRow("Tolink")
		URL_REWRITE.RestaurantID.DbValue = RsRow("RestaurantID")
		URL_REWRITE.Status.DbValue = RsRow("Status")
		URL_REWRITE.businessname.DbValue = RsRow("businessname")
		URL_REWRITE.postcode.DbValue = RsRow("postcode")
		URL_REWRITE.phonenumber.DbValue = RsRow("phonenumber")
	End Sub

	' Load DbValue from recordset
	Sub LoadDbValues(Rs)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		If Rs.Eof Then Exit Sub
		URL_REWRITE.ID.m_DbValue = Rs("ID")
		URL_REWRITE.FromLink.m_DbValue = Rs("FromLink")
		URL_REWRITE.Tolink.m_DbValue = Rs("Tolink")
		URL_REWRITE.RestaurantID.m_DbValue = Rs("RestaurantID")
		URL_REWRITE.Status.m_DbValue = Rs("Status")
		URL_REWRITE.businessname.m_DbValue = Rs("businessname")
		URL_REWRITE.postcode.m_DbValue = Rs("postcode")
		URL_REWRITE.phonenumber.m_DbValue = Rs("phonenumber")
	End Sub

	' Load old record
	Function LoadOldRecord()

		' Load key values from Session
		Dim bValidKey
		bValidKey = True
		If URL_REWRITE.GetKey("ID")&"" <> "" Then
			URL_REWRITE.ID.CurrentValue = URL_REWRITE.GetKey("ID") ' ID
		Else
			bValidKey = False
		End If

		' Load old recordset
		If bValidKey Then
			URL_REWRITE.CurrentFilter = URL_REWRITE.KeyFilter
			Dim sSql
			sSql = URL_REWRITE.SQL
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

		' ---------
		'  Add Row
		' ---------

		ElseIf URL_REWRITE.RowType = EW_ROWTYPE_ADD Then ' Add row

			' FromLink
			URL_REWRITE.FromLink.EditAttrs.UpdateAttribute "class", "form-control"
			URL_REWRITE.FromLink.EditCustomAttributes = ""
			URL_REWRITE.FromLink.EditValue = ew_HtmlEncode(URL_REWRITE.FromLink.CurrentValue)
			URL_REWRITE.FromLink.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(URL_REWRITE.FromLink.FldCaption))

			' Tolink
			URL_REWRITE.Tolink.EditAttrs.UpdateAttribute "class", "form-control"
			URL_REWRITE.Tolink.EditCustomAttributes = ""
			URL_REWRITE.Tolink.EditValue = ew_HtmlEncode(URL_REWRITE.Tolink.CurrentValue)
			URL_REWRITE.Tolink.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(URL_REWRITE.Tolink.FldCaption))

			' RestaurantID
			URL_REWRITE.RestaurantID.EditAttrs.UpdateAttribute "class", "form-control"
			URL_REWRITE.RestaurantID.EditCustomAttributes = ""
			URL_REWRITE.RestaurantID.EditValue = ew_HtmlEncode(URL_REWRITE.RestaurantID.CurrentValue)
			URL_REWRITE.RestaurantID.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(URL_REWRITE.RestaurantID.FldCaption))

			' Status
			URL_REWRITE.Status.EditAttrs.UpdateAttribute "class", "form-control"
			URL_REWRITE.Status.EditCustomAttributes = ""
			URL_REWRITE.Status.EditValue = ew_HtmlEncode(URL_REWRITE.Status.CurrentValue)
			URL_REWRITE.Status.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(URL_REWRITE.Status.FldCaption))

			' businessname
			URL_REWRITE.businessname.EditAttrs.UpdateAttribute "class", "form-control"
			URL_REWRITE.businessname.EditCustomAttributes = ""
			URL_REWRITE.businessname.EditValue = ew_HtmlEncode(URL_REWRITE.businessname.CurrentValue)
			URL_REWRITE.businessname.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(URL_REWRITE.businessname.FldCaption))

			' postcode
			URL_REWRITE.postcode.EditAttrs.UpdateAttribute "class", "form-control"
			URL_REWRITE.postcode.EditCustomAttributes = ""
			URL_REWRITE.postcode.EditValue = ew_HtmlEncode(URL_REWRITE.postcode.CurrentValue)
			URL_REWRITE.postcode.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(URL_REWRITE.postcode.FldCaption))

			' phonenumber
			URL_REWRITE.phonenumber.EditAttrs.UpdateAttribute "class", "form-control"
			URL_REWRITE.phonenumber.EditCustomAttributes = ""
			URL_REWRITE.phonenumber.EditValue = ew_HtmlEncode(URL_REWRITE.phonenumber.CurrentValue)
			URL_REWRITE.phonenumber.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(URL_REWRITE.phonenumber.FldCaption))

			' Edit refer script
			' FromLink

			URL_REWRITE.FromLink.HrefValue = ""

			' Tolink
			URL_REWRITE.Tolink.HrefValue = ""

			' RestaurantID
			URL_REWRITE.RestaurantID.HrefValue = ""

			' Status
			URL_REWRITE.Status.HrefValue = ""

			' businessname
			URL_REWRITE.businessname.HrefValue = ""

			' postcode
			URL_REWRITE.postcode.HrefValue = ""

			' phonenumber
			URL_REWRITE.phonenumber.HrefValue = ""
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
		If Not ew_CheckInteger(URL_REWRITE.RestaurantID.FormValue) Then
			Call ew_AddMessage(gsFormError, URL_REWRITE.RestaurantID.FldErrMsg)
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
		URL_REWRITE.CurrentFilter = sFilter
		sSql = URL_REWRITE.SQL
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

		' Field FromLink
		Call URL_REWRITE.FromLink.SetDbValue(Rs, URL_REWRITE.FromLink.CurrentValue, Null, False)

		' Field Tolink
		Call URL_REWRITE.Tolink.SetDbValue(Rs, URL_REWRITE.Tolink.CurrentValue, Null, False)

		' Field RestaurantID
		Call URL_REWRITE.RestaurantID.SetDbValue(Rs, URL_REWRITE.RestaurantID.CurrentValue, Null, False)

		' Field Status
		Call URL_REWRITE.Status.SetDbValue(Rs, URL_REWRITE.Status.CurrentValue, Null, False)

		' Field businessname
		Call URL_REWRITE.businessname.SetDbValue(Rs, URL_REWRITE.businessname.CurrentValue, Null, False)

		' Field postcode
		Call URL_REWRITE.postcode.SetDbValue(Rs, URL_REWRITE.postcode.CurrentValue, Null, False)

		' Field phonenumber
		Call URL_REWRITE.phonenumber.SetDbValue(Rs, URL_REWRITE.phonenumber.CurrentValue, Null, False)

		' Check recordset update error
		If Err.Number <> 0 Then
			FailureMessage = Err.Description
			Rs.Close
			Set Rs = Nothing
			AddRow = False
			Exit Function
		End If

		' Call Row Inserting event
		bInsertRow = URL_REWRITE.Row_Inserting(RsOld, Rs)
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
			ElseIf URL_REWRITE.CancelMessage <> "" Then
				FailureMessage = URL_REWRITE.CancelMessage
				URL_REWRITE.CancelMessage = ""
			Else
				FailureMessage = Language.Phrase("InsertCancelled")
			End If
			AddRow = False
		End If
		Rs.Close
		Set Rs = Nothing
		If AddRow Then
			URL_REWRITE.ID.DbValue = RsNew("ID")
		End If
		If AddRow Then

			' Call Row Inserted event
			Call URL_REWRITE.Row_Inserted(RsOld, RsNew)
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
		Call Breadcrumb.Add("list", URL_REWRITE.TableVar, "URL_REWRITElist.asp", "", URL_REWRITE.TableVar, True)
		PageId = ew_IIf(URL_REWRITE.CurrentAction = "C", "Copy", "Add")
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
