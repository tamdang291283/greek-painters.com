<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="Customer_Book_Tableinfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim Customer_Book_Table_add
Set Customer_Book_Table_add = New cCustomer_Book_Table_add
Set Page = Customer_Book_Table_add

' Page init processing
Customer_Book_Table_add.Page_Init()

' Page main processing
Customer_Book_Table_add.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
Customer_Book_Table_add.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var Customer_Book_Table_add = new ew_Page("Customer_Book_Table_add");
Customer_Book_Table_add.PageID = "add"; // Page ID
var EW_PAGE_ID = Customer_Book_Table_add.PageID; // For backward compatibility
// Form object
var fCustomer_Book_Tableadd = new ew_Form("fCustomer_Book_Tableadd");
// Validate form
fCustomer_Book_Tableadd.Validate = function() {
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
				return this.OnError(elm, "<%= ew_JsEncode2(Customer_Book_Table.IdBusinessDetail.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_numberpeople");
			if (elm && !ew_CheckInteger(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(Customer_Book_Table.numberpeople.FldErrMsg) %>");
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
fCustomer_Book_Tableadd.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fCustomer_Book_Tableadd.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fCustomer_Book_Tableadd.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<div class="ewToolbar">
<% If Customer_Book_Table.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If Customer_Book_Table.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% Customer_Book_Table_add.ShowPageHeader() %>
<% Customer_Book_Table_add.ShowMessage %>
<form name="fCustomer_Book_Tableadd" id="fCustomer_Book_Tableadd" class="form-horizontal ewForm ewAddForm" action="<%= ew_CurrentPage() %>" method="post">
<% If Customer_Book_Table_add.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= Customer_Book_Table_add.Token %>">
<% End If %>
<input type="hidden" name="t" value="Customer_Book_Table">
<input type="hidden" name="a_add" id="a_add" value="A">
<div>
<% If Customer_Book_Table.Name.Visible Then ' Name %>
	<div id="r_Name" class="form-group">
		<label id="elh_Customer_Book_Table_Name" for="x_Name" class="col-sm-2 control-label ewLabel"><%= Customer_Book_Table.Name.FldCaption %></label>
		<div class="col-sm-10"><div<%= Customer_Book_Table.Name.CellAttributes %>>
<span id="el_Customer_Book_Table_Name">
<input type="text" data-field="x_Name" name="x_Name" id="x_Name" size="30" maxlength="255" placeholder="<%= Customer_Book_Table.Name.PlaceHolder %>" value="<%= Customer_Book_Table.Name.EditValue %>"<%= Customer_Book_Table.Name.EditAttributes %>>
</span>
<%= Customer_Book_Table.Name.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Customer_Book_Table.Phone.Visible Then ' Phone %>
	<div id="r_Phone" class="form-group">
		<label id="elh_Customer_Book_Table_Phone" for="x_Phone" class="col-sm-2 control-label ewLabel"><%= Customer_Book_Table.Phone.FldCaption %></label>
		<div class="col-sm-10"><div<%= Customer_Book_Table.Phone.CellAttributes %>>
<span id="el_Customer_Book_Table_Phone">
<input type="text" data-field="x_Phone" name="x_Phone" id="x_Phone" size="30" maxlength="255" placeholder="<%= Customer_Book_Table.Phone.PlaceHolder %>" value="<%= Customer_Book_Table.Phone.EditValue %>"<%= Customer_Book_Table.Phone.EditAttributes %>>
</span>
<%= Customer_Book_Table.Phone.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Customer_Book_Table.bookdate.Visible Then ' bookdate %>
	<div id="r_bookdate" class="form-group">
		<label id="elh_Customer_Book_Table_bookdate" for="x_bookdate" class="col-sm-2 control-label ewLabel"><%= Customer_Book_Table.bookdate.FldCaption %></label>
		<div class="col-sm-10"><div<%= Customer_Book_Table.bookdate.CellAttributes %>>
<span id="el_Customer_Book_Table_bookdate">
<input type="text" data-field="x_bookdate" name="x_bookdate" id="x_bookdate" placeholder="<%= Customer_Book_Table.bookdate.PlaceHolder %>" value="<%= Customer_Book_Table.bookdate.EditValue %>"<%= Customer_Book_Table.bookdate.EditAttributes %>>
</span>
<%= Customer_Book_Table.bookdate.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Customer_Book_Table.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
	<div id="r_IdBusinessDetail" class="form-group">
		<label id="elh_Customer_Book_Table_IdBusinessDetail" for="x_IdBusinessDetail" class="col-sm-2 control-label ewLabel"><%= Customer_Book_Table.IdBusinessDetail.FldCaption %></label>
		<div class="col-sm-10"><div<%= Customer_Book_Table.IdBusinessDetail.CellAttributes %>>
<span id="el_Customer_Book_Table_IdBusinessDetail">
<input type="text" data-field="x_IdBusinessDetail" name="x_IdBusinessDetail" id="x_IdBusinessDetail" size="30" placeholder="<%= Customer_Book_Table.IdBusinessDetail.PlaceHolder %>" value="<%= Customer_Book_Table.IdBusinessDetail.EditValue %>"<%= Customer_Book_Table.IdBusinessDetail.EditAttributes %>>
</span>
<%= Customer_Book_Table.IdBusinessDetail.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Customer_Book_Table.comment.Visible Then ' comment %>
	<div id="r_comment" class="form-group">
		<label id="elh_Customer_Book_Table_comment" for="x_comment" class="col-sm-2 control-label ewLabel"><%= Customer_Book_Table.comment.FldCaption %></label>
		<div class="col-sm-10"><div<%= Customer_Book_Table.comment.CellAttributes %>>
<span id="el_Customer_Book_Table_comment">
<textarea data-field="x_comment" name="x_comment" id="x_comment" cols="35" rows="4" placeholder="<%= Customer_Book_Table.comment.PlaceHolder %>"<%= Customer_Book_Table.comment.EditAttributes %>><%= Customer_Book_Table.comment.EditValue %></textarea>
</span>
<%= Customer_Book_Table.comment.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Customer_Book_Table.s_contentemail.Visible Then ' s_contentemail %>
	<div id="r_s_contentemail" class="form-group">
		<label id="elh_Customer_Book_Table_s_contentemail" for="x_s_contentemail" class="col-sm-2 control-label ewLabel"><%= Customer_Book_Table.s_contentemail.FldCaption %></label>
		<div class="col-sm-10"><div<%= Customer_Book_Table.s_contentemail.CellAttributes %>>
<span id="el_Customer_Book_Table_s_contentemail">
<textarea data-field="x_s_contentemail" name="x_s_contentemail" id="x_s_contentemail" cols="35" rows="4" placeholder="<%= Customer_Book_Table.s_contentemail.PlaceHolder %>"<%= Customer_Book_Table.s_contentemail.EditAttributes %>><%= Customer_Book_Table.s_contentemail.EditValue %></textarea>
</span>
<%= Customer_Book_Table.s_contentemail.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Customer_Book_Table.numberpeople.Visible Then ' numberpeople %>
	<div id="r_numberpeople" class="form-group">
		<label id="elh_Customer_Book_Table_numberpeople" for="x_numberpeople" class="col-sm-2 control-label ewLabel"><%= Customer_Book_Table.numberpeople.FldCaption %></label>
		<div class="col-sm-10"><div<%= Customer_Book_Table.numberpeople.CellAttributes %>>
<span id="el_Customer_Book_Table_numberpeople">
<input type="text" data-field="x_numberpeople" name="x_numberpeople" id="x_numberpeople" size="30" placeholder="<%= Customer_Book_Table.numberpeople.PlaceHolder %>" value="<%= Customer_Book_Table.numberpeople.EditValue %>"<%= Customer_Book_Table.numberpeople.EditAttributes %>>
</span>
<%= Customer_Book_Table.numberpeople.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Customer_Book_Table.createddate.Visible Then ' createddate %>
	<div id="r_createddate" class="form-group">
		<label id="elh_Customer_Book_Table_createddate" for="x_createddate" class="col-sm-2 control-label ewLabel"><%= Customer_Book_Table.createddate.FldCaption %></label>
		<div class="col-sm-10"><div<%= Customer_Book_Table.createddate.CellAttributes %>>
<span id="el_Customer_Book_Table_createddate">
<input type="text" data-field="x_createddate" name="x_createddate" id="x_createddate" placeholder="<%= Customer_Book_Table.createddate.PlaceHolder %>" value="<%= Customer_Book_Table.createddate.EditValue %>"<%= Customer_Book_Table.createddate.EditAttributes %>>
</span>
<%= Customer_Book_Table.createddate.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Customer_Book_Table.zEmail.Visible Then ' Email %>
	<div id="r_zEmail" class="form-group">
		<label id="elh_Customer_Book_Table_zEmail" for="x_zEmail" class="col-sm-2 control-label ewLabel"><%= Customer_Book_Table.zEmail.FldCaption %></label>
		<div class="col-sm-10"><div<%= Customer_Book_Table.zEmail.CellAttributes %>>
<span id="el_Customer_Book_Table_zEmail">
<input type="text" data-field="x_zEmail" name="x_zEmail" id="x_zEmail" size="30" maxlength="255" placeholder="<%= Customer_Book_Table.zEmail.PlaceHolder %>" value="<%= Customer_Book_Table.zEmail.EditValue %>"<%= Customer_Book_Table.zEmail.EditAttributes %>>
</span>
<%= Customer_Book_Table.zEmail.CustomMsg %></div></div>
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
fCustomer_Book_Tableadd.Init();
</script>
<%
Customer_Book_Table_add.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set Customer_Book_Table_add = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cCustomer_Book_Table_add

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
		TableName = "Customer_Book_Table"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "Customer_Book_Table_add"
	End Property

	' Page Name
	Public Property Get PageName()
		PageName = ew_CurrentPage()
	End Property

	' Page Url
	Public Property Get PageUrl()
		PageUrl = ew_CurrentPage() & "?"
		If Customer_Book_Table.UseTokenInUrl Then PageUrl = PageUrl & "t=" & Customer_Book_Table.TableVar & "&" ' add page token
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
		If Customer_Book_Table.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (Customer_Book_Table.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (Customer_Book_Table.TableVar = Request.QueryString("t"))
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
		If IsEmpty(Customer_Book_Table) Then Set Customer_Book_Table = New cCustomer_Book_Table
		Set Table = Customer_Book_Table

		' Initialize urls
		' Initialize form object

		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "add"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "Customer_Book_Table"

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

		Customer_Book_Table.CurrentAction = ew_IIf(Request.QueryString("a").Count > 0, Request.QueryString("a") & "", ObjForm.GetValue("a_list") & "") ' Set up current action

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
			results = Customer_Book_Table.GetAutoFill(Request.Form("name"), Request.Form("q"))
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
		If Not Customer_Book_Table Is Nothing Then
			If Customer_Book_Table.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = Customer_Book_Table.TableVar
				If Customer_Book_Table.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf Customer_Book_Table.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf Customer_Book_Table.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf Customer_Book_Table.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set Customer_Book_Table = Nothing
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
			Customer_Book_Table.CurrentAction = ObjForm.GetValue("a_add") ' Get form action
			CopyRecord = LoadOldRecord() ' Load old recordset
			Call LoadFormValues() ' Load form values

		' Not post back
		Else

			' Load key values from QueryString
			CopyRecord = True
			If Request.QueryString("ID").Count > 0 Then
				Customer_Book_Table.ID.QueryStringValue = Request.QueryString("ID")
				Call Customer_Book_Table.SetKey("ID", Customer_Book_Table.ID.CurrentValue) ' Set up key
			Else
				Call Customer_Book_Table.SetKey("ID", "") ' Clear key
				CopyRecord = False
			End If
			If CopyRecord Then
				Customer_Book_Table.CurrentAction = "C" ' Copy Record
			Else
				Customer_Book_Table.CurrentAction = "I" ' Display Blank Record
				Call LoadDefaultValues() ' Load default values
			End If
		End If

		' Set up Breadcrumb
		SetupBreadcrumb()

		' Validate form if post back
		If ObjForm.GetValue("a_add")&"" <> "" Then
			If Not ValidateForm() Then
				Customer_Book_Table.CurrentAction = "I" ' Form error, reset action
				Customer_Book_Table.EventCancelled = True ' Event cancelled
				Call RestoreFormValues() ' Restore form values
				FailureMessage = gsFormError
			End If
		End If

		' Perform action based on action code
		Select Case Customer_Book_Table.CurrentAction
			Case "I" ' Blank record, no action required
			Case "C" ' Copy an existing record
				If Not LoadRow() Then ' Load record based on key
					If FailureMessage = "" Then FailureMessage = Language.Phrase("NoRecord") ' No record found
					Call Page_Terminate("Customer_Book_Tablelist.asp") ' No matching record, return to list
				End If
			Case "A" ' Add new record
				Customer_Book_Table.SendEmail = True ' Send email on add success
				If AddRow(OldRecordset) Then ' Add successful
					If SuccessMessage = "" Then SuccessMessage = Language.Phrase("AddSuccess") ' Set up success message
					Dim sReturnUrl
					sReturnUrl = Customer_Book_Table.ReturnUrl
					If ew_GetPageName(sReturnUrl) = "Customer_Book_Tableview.asp" Then sReturnUrl = Customer_Book_Table.ViewUrl("") ' View paging, return to view page with keyurl directly
					Call Page_Terminate(sReturnUrl) ' Clean up and return
				Else
					Customer_Book_Table.EventCancelled = True ' Event cancelled
					Call RestoreFormValues() ' Add failed, restore form values
				End If
		End Select

		' Render row based on row type
		Customer_Book_Table.RowType = EW_ROWTYPE_ADD ' Render add type

		' Render row
		Call Customer_Book_Table.ResetAttrs()
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
		Customer_Book_Table.Name.CurrentValue = Null
		Customer_Book_Table.Name.OldValue = Customer_Book_Table.Name.CurrentValue
		Customer_Book_Table.Phone.CurrentValue = Null
		Customer_Book_Table.Phone.OldValue = Customer_Book_Table.Phone.CurrentValue
		Customer_Book_Table.bookdate.CurrentValue = Null
		Customer_Book_Table.bookdate.OldValue = Customer_Book_Table.bookdate.CurrentValue
		Customer_Book_Table.IdBusinessDetail.CurrentValue = Null
		Customer_Book_Table.IdBusinessDetail.OldValue = Customer_Book_Table.IdBusinessDetail.CurrentValue
		Customer_Book_Table.comment.CurrentValue = Null
		Customer_Book_Table.comment.OldValue = Customer_Book_Table.comment.CurrentValue
		Customer_Book_Table.s_contentemail.CurrentValue = Null
		Customer_Book_Table.s_contentemail.OldValue = Customer_Book_Table.s_contentemail.CurrentValue
		Customer_Book_Table.numberpeople.CurrentValue = Null
		Customer_Book_Table.numberpeople.OldValue = Customer_Book_Table.numberpeople.CurrentValue
		Customer_Book_Table.createddate.CurrentValue = Null
		Customer_Book_Table.createddate.OldValue = Customer_Book_Table.createddate.CurrentValue
		Customer_Book_Table.zEmail.CurrentValue = Null
		Customer_Book_Table.zEmail.OldValue = Customer_Book_Table.zEmail.CurrentValue
	End Function

	' -----------------------------------------------------------------
	' Load form values
	'
	Function LoadFormValues()

		' Load values from form
		If Not Customer_Book_Table.Name.FldIsDetailKey Then Customer_Book_Table.Name.FormValue = ObjForm.GetValue("x_Name")
		If Not Customer_Book_Table.Phone.FldIsDetailKey Then Customer_Book_Table.Phone.FormValue = ObjForm.GetValue("x_Phone")
		If Not Customer_Book_Table.bookdate.FldIsDetailKey Then Customer_Book_Table.bookdate.FormValue = ObjForm.GetValue("x_bookdate")
		If Not Customer_Book_Table.bookdate.FldIsDetailKey Then Customer_Book_Table.bookdate.CurrentValue = ew_UnFormatDateTime(Customer_Book_Table.bookdate.CurrentValue, 9)
		If Not Customer_Book_Table.IdBusinessDetail.FldIsDetailKey Then Customer_Book_Table.IdBusinessDetail.FormValue = ObjForm.GetValue("x_IdBusinessDetail")
		If Not Customer_Book_Table.comment.FldIsDetailKey Then Customer_Book_Table.comment.FormValue = ObjForm.GetValue("x_comment")
		If Not Customer_Book_Table.s_contentemail.FldIsDetailKey Then Customer_Book_Table.s_contentemail.FormValue = ObjForm.GetValue("x_s_contentemail")
		If Not Customer_Book_Table.numberpeople.FldIsDetailKey Then Customer_Book_Table.numberpeople.FormValue = ObjForm.GetValue("x_numberpeople")
		If Not Customer_Book_Table.createddate.FldIsDetailKey Then Customer_Book_Table.createddate.FormValue = ObjForm.GetValue("x_createddate")
		If Not Customer_Book_Table.createddate.FldIsDetailKey Then Customer_Book_Table.createddate.CurrentValue = ew_UnFormatDateTime(Customer_Book_Table.createddate.CurrentValue, 9)
		If Not Customer_Book_Table.zEmail.FldIsDetailKey Then Customer_Book_Table.zEmail.FormValue = ObjForm.GetValue("x_zEmail")
	End Function

	' -----------------------------------------------------------------
	' Restore form values
	'
	Function RestoreFormValues()
		Call LoadOldRecord()
		Customer_Book_Table.Name.CurrentValue = Customer_Book_Table.Name.FormValue
		Customer_Book_Table.Phone.CurrentValue = Customer_Book_Table.Phone.FormValue
		Customer_Book_Table.bookdate.CurrentValue = Customer_Book_Table.bookdate.FormValue
		Customer_Book_Table.bookdate.CurrentValue = ew_UnFormatDateTime(Customer_Book_Table.bookdate.CurrentValue, 9)
		Customer_Book_Table.IdBusinessDetail.CurrentValue = Customer_Book_Table.IdBusinessDetail.FormValue
		Customer_Book_Table.comment.CurrentValue = Customer_Book_Table.comment.FormValue
		Customer_Book_Table.s_contentemail.CurrentValue = Customer_Book_Table.s_contentemail.FormValue
		Customer_Book_Table.numberpeople.CurrentValue = Customer_Book_Table.numberpeople.FormValue
		Customer_Book_Table.createddate.CurrentValue = Customer_Book_Table.createddate.FormValue
		Customer_Book_Table.createddate.CurrentValue = ew_UnFormatDateTime(Customer_Book_Table.createddate.CurrentValue, 9)
		Customer_Book_Table.zEmail.CurrentValue = Customer_Book_Table.zEmail.FormValue
	End Function

	' -----------------------------------------------------------------
	' Load row based on key values
	'
	Function LoadRow()
		Dim RsRow, sSql, sFilter
		sFilter = Customer_Book_Table.KeyFilter

		' Call Row Selecting event
		Call Customer_Book_Table.Row_Selecting(sFilter)

		' Load sql based on filter
		Customer_Book_Table.CurrentFilter = sFilter
		sSql = Customer_Book_Table.SQL
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
		Call Customer_Book_Table.Row_Selected(RsRow)
		Customer_Book_Table.ID.DbValue = RsRow("ID")
		Customer_Book_Table.Name.DbValue = RsRow("Name")
		Customer_Book_Table.Phone.DbValue = RsRow("Phone")
		Customer_Book_Table.bookdate.DbValue = RsRow("bookdate")
		Customer_Book_Table.IdBusinessDetail.DbValue = RsRow("IdBusinessDetail")
		Customer_Book_Table.comment.DbValue = RsRow("comment")
		Customer_Book_Table.s_contentemail.DbValue = RsRow("s_contentemail")
		Customer_Book_Table.numberpeople.DbValue = RsRow("numberpeople")
		Customer_Book_Table.createddate.DbValue = RsRow("createddate")
		Customer_Book_Table.zEmail.DbValue = RsRow("Email")
	End Sub

	' Load DbValue from recordset
	Sub LoadDbValues(Rs)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		If Rs.Eof Then Exit Sub
		Customer_Book_Table.ID.m_DbValue = Rs("ID")
		Customer_Book_Table.Name.m_DbValue = Rs("Name")
		Customer_Book_Table.Phone.m_DbValue = Rs("Phone")
		Customer_Book_Table.bookdate.m_DbValue = Rs("bookdate")
		Customer_Book_Table.IdBusinessDetail.m_DbValue = Rs("IdBusinessDetail")
		Customer_Book_Table.comment.m_DbValue = Rs("comment")
		Customer_Book_Table.s_contentemail.m_DbValue = Rs("s_contentemail")
		Customer_Book_Table.numberpeople.m_DbValue = Rs("numberpeople")
		Customer_Book_Table.createddate.m_DbValue = Rs("createddate")
		Customer_Book_Table.zEmail.m_DbValue = Rs("Email")
	End Sub

	' Load old record
	Function LoadOldRecord()

		' Load key values from Session
		Dim bValidKey
		bValidKey = True
		If Customer_Book_Table.GetKey("ID")&"" <> "" Then
			Customer_Book_Table.ID.CurrentValue = Customer_Book_Table.GetKey("ID") ' ID
		Else
			bValidKey = False
		End If

		' Load old recordset
		If bValidKey Then
			Customer_Book_Table.CurrentFilter = Customer_Book_Table.KeyFilter
			Dim sSql
			sSql = Customer_Book_Table.SQL
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

		Call Customer_Book_Table.Row_Rendering()

		' ---------------------------------------
		'  Common render codes for all row types
		' ---------------------------------------
		' ID
		' Name
		' Phone
		' bookdate
		' IdBusinessDetail
		' comment
		' s_contentemail
		' numberpeople
		' createddate
		' Email
		' -----------
		'  View  Row
		' -----------

		If Customer_Book_Table.RowType = EW_ROWTYPE_VIEW Then ' View row

			' ID
			Customer_Book_Table.ID.ViewValue = Customer_Book_Table.ID.CurrentValue
			Customer_Book_Table.ID.ViewCustomAttributes = ""

			' Name
			Customer_Book_Table.Name.ViewValue = Customer_Book_Table.Name.CurrentValue
			Customer_Book_Table.Name.ViewCustomAttributes = ""

			' Phone
			Customer_Book_Table.Phone.ViewValue = Customer_Book_Table.Phone.CurrentValue
			Customer_Book_Table.Phone.ViewCustomAttributes = ""

			' bookdate
			Customer_Book_Table.bookdate.ViewValue = Customer_Book_Table.bookdate.CurrentValue
			Customer_Book_Table.bookdate.ViewCustomAttributes = ""

			' IdBusinessDetail
			Customer_Book_Table.IdBusinessDetail.ViewValue = Customer_Book_Table.IdBusinessDetail.CurrentValue
			Customer_Book_Table.IdBusinessDetail.ViewCustomAttributes = ""

			' comment
			Customer_Book_Table.comment.ViewValue = Customer_Book_Table.comment.CurrentValue
			Customer_Book_Table.comment.ViewCustomAttributes = ""

			' s_contentemail
			Customer_Book_Table.s_contentemail.ViewValue = Customer_Book_Table.s_contentemail.CurrentValue
			Customer_Book_Table.s_contentemail.ViewCustomAttributes = ""

			' numberpeople
			Customer_Book_Table.numberpeople.ViewValue = Customer_Book_Table.numberpeople.CurrentValue
			Customer_Book_Table.numberpeople.ViewCustomAttributes = ""

			' createddate
			Customer_Book_Table.createddate.ViewValue = Customer_Book_Table.createddate.CurrentValue
			Customer_Book_Table.createddate.ViewCustomAttributes = ""

			' Email
			Customer_Book_Table.zEmail.ViewValue = Customer_Book_Table.zEmail.CurrentValue
			Customer_Book_Table.zEmail.ViewCustomAttributes = ""

			' View refer script
			' Name

			Customer_Book_Table.Name.LinkCustomAttributes = ""
			Customer_Book_Table.Name.HrefValue = ""
			Customer_Book_Table.Name.TooltipValue = ""

			' Phone
			Customer_Book_Table.Phone.LinkCustomAttributes = ""
			Customer_Book_Table.Phone.HrefValue = ""
			Customer_Book_Table.Phone.TooltipValue = ""

			' bookdate
			Customer_Book_Table.bookdate.LinkCustomAttributes = ""
			Customer_Book_Table.bookdate.HrefValue = ""
			Customer_Book_Table.bookdate.TooltipValue = ""

			' IdBusinessDetail
			Customer_Book_Table.IdBusinessDetail.LinkCustomAttributes = ""
			Customer_Book_Table.IdBusinessDetail.HrefValue = ""
			Customer_Book_Table.IdBusinessDetail.TooltipValue = ""

			' comment
			Customer_Book_Table.comment.LinkCustomAttributes = ""
			Customer_Book_Table.comment.HrefValue = ""
			Customer_Book_Table.comment.TooltipValue = ""

			' s_contentemail
			Customer_Book_Table.s_contentemail.LinkCustomAttributes = ""
			Customer_Book_Table.s_contentemail.HrefValue = ""
			Customer_Book_Table.s_contentemail.TooltipValue = ""

			' numberpeople
			Customer_Book_Table.numberpeople.LinkCustomAttributes = ""
			Customer_Book_Table.numberpeople.HrefValue = ""
			Customer_Book_Table.numberpeople.TooltipValue = ""

			' createddate
			Customer_Book_Table.createddate.LinkCustomAttributes = ""
			Customer_Book_Table.createddate.HrefValue = ""
			Customer_Book_Table.createddate.TooltipValue = ""

			' Email
			Customer_Book_Table.zEmail.LinkCustomAttributes = ""
			Customer_Book_Table.zEmail.HrefValue = ""
			Customer_Book_Table.zEmail.TooltipValue = ""

		' ---------
		'  Add Row
		' ---------

		ElseIf Customer_Book_Table.RowType = EW_ROWTYPE_ADD Then ' Add row

			' Name
			Customer_Book_Table.Name.EditAttrs.UpdateAttribute "class", "form-control"
			Customer_Book_Table.Name.EditCustomAttributes = ""
			Customer_Book_Table.Name.EditValue = ew_HtmlEncode(Customer_Book_Table.Name.CurrentValue)
			Customer_Book_Table.Name.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Customer_Book_Table.Name.FldCaption))

			' Phone
			Customer_Book_Table.Phone.EditAttrs.UpdateAttribute "class", "form-control"
			Customer_Book_Table.Phone.EditCustomAttributes = ""
			Customer_Book_Table.Phone.EditValue = ew_HtmlEncode(Customer_Book_Table.Phone.CurrentValue)
			Customer_Book_Table.Phone.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Customer_Book_Table.Phone.FldCaption))

			' bookdate
			Customer_Book_Table.bookdate.EditAttrs.UpdateAttribute "class", "form-control"
			Customer_Book_Table.bookdate.EditCustomAttributes = ""
			Customer_Book_Table.bookdate.EditValue = ew_HtmlEncode(Customer_Book_Table.bookdate.CurrentValue)
			Customer_Book_Table.bookdate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Customer_Book_Table.bookdate.FldCaption))

			' IdBusinessDetail
			Customer_Book_Table.IdBusinessDetail.EditAttrs.UpdateAttribute "class", "form-control"
			Customer_Book_Table.IdBusinessDetail.EditCustomAttributes = ""
			Customer_Book_Table.IdBusinessDetail.EditValue = ew_HtmlEncode(Customer_Book_Table.IdBusinessDetail.CurrentValue)
			Customer_Book_Table.IdBusinessDetail.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Customer_Book_Table.IdBusinessDetail.FldCaption))

			' comment
			Customer_Book_Table.comment.EditAttrs.UpdateAttribute "class", "form-control"
			Customer_Book_Table.comment.EditCustomAttributes = ""
			Customer_Book_Table.comment.EditValue = ew_HtmlEncode(Customer_Book_Table.comment.CurrentValue)
			Customer_Book_Table.comment.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Customer_Book_Table.comment.FldCaption))

			' s_contentemail
			Customer_Book_Table.s_contentemail.EditAttrs.UpdateAttribute "class", "form-control"
			Customer_Book_Table.s_contentemail.EditCustomAttributes = ""
			Customer_Book_Table.s_contentemail.EditValue = ew_HtmlEncode(Customer_Book_Table.s_contentemail.CurrentValue)
			Customer_Book_Table.s_contentemail.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Customer_Book_Table.s_contentemail.FldCaption))

			' numberpeople
			Customer_Book_Table.numberpeople.EditAttrs.UpdateAttribute "class", "form-control"
			Customer_Book_Table.numberpeople.EditCustomAttributes = ""
			Customer_Book_Table.numberpeople.EditValue = ew_HtmlEncode(Customer_Book_Table.numberpeople.CurrentValue)
			Customer_Book_Table.numberpeople.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Customer_Book_Table.numberpeople.FldCaption))

			' createddate
			Customer_Book_Table.createddate.EditAttrs.UpdateAttribute "class", "form-control"
			Customer_Book_Table.createddate.EditCustomAttributes = ""
			Customer_Book_Table.createddate.EditValue = ew_HtmlEncode(Customer_Book_Table.createddate.CurrentValue)
			Customer_Book_Table.createddate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Customer_Book_Table.createddate.FldCaption))

			' Email
			Customer_Book_Table.zEmail.EditAttrs.UpdateAttribute "class", "form-control"
			Customer_Book_Table.zEmail.EditCustomAttributes = ""
			Customer_Book_Table.zEmail.EditValue = ew_HtmlEncode(Customer_Book_Table.zEmail.CurrentValue)
			Customer_Book_Table.zEmail.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Customer_Book_Table.zEmail.FldCaption))

			' Edit refer script
			' Name

			Customer_Book_Table.Name.HrefValue = ""

			' Phone
			Customer_Book_Table.Phone.HrefValue = ""

			' bookdate
			Customer_Book_Table.bookdate.HrefValue = ""

			' IdBusinessDetail
			Customer_Book_Table.IdBusinessDetail.HrefValue = ""

			' comment
			Customer_Book_Table.comment.HrefValue = ""

			' s_contentemail
			Customer_Book_Table.s_contentemail.HrefValue = ""

			' numberpeople
			Customer_Book_Table.numberpeople.HrefValue = ""

			' createddate
			Customer_Book_Table.createddate.HrefValue = ""

			' Email
			Customer_Book_Table.zEmail.HrefValue = ""
		End If
		If Customer_Book_Table.RowType = EW_ROWTYPE_ADD Or Customer_Book_Table.RowType = EW_ROWTYPE_EDIT Or Customer_Book_Table.RowType = EW_ROWTYPE_SEARCH Then ' Add / Edit / Search row
			Call Customer_Book_Table.SetupFieldTitles()
		End If

		' Call Row Rendered event
		If Customer_Book_Table.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call Customer_Book_Table.Row_Rendered()
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
		If Not ew_CheckInteger(Customer_Book_Table.IdBusinessDetail.FormValue) Then
			Call ew_AddMessage(gsFormError, Customer_Book_Table.IdBusinessDetail.FldErrMsg)
		End If
		If Not ew_CheckInteger(Customer_Book_Table.numberpeople.FormValue) Then
			Call ew_AddMessage(gsFormError, Customer_Book_Table.numberpeople.FldErrMsg)
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
		Customer_Book_Table.CurrentFilter = sFilter
		sSql = Customer_Book_Table.SQL
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

		' Field Name
		Call Customer_Book_Table.Name.SetDbValue(Rs, Customer_Book_Table.Name.CurrentValue, Null, False)

		' Field Phone
		Call Customer_Book_Table.Phone.SetDbValue(Rs, Customer_Book_Table.Phone.CurrentValue, Null, False)

		' Field bookdate
		Call Customer_Book_Table.bookdate.SetDbValue(Rs, Customer_Book_Table.bookdate.CurrentValue, Null, False)

		' Field IdBusinessDetail
		Call Customer_Book_Table.IdBusinessDetail.SetDbValue(Rs, Customer_Book_Table.IdBusinessDetail.CurrentValue, Null, False)

		' Field comment
		Call Customer_Book_Table.comment.SetDbValue(Rs, Customer_Book_Table.comment.CurrentValue, Null, False)

		' Field s_contentemail
		Call Customer_Book_Table.s_contentemail.SetDbValue(Rs, Customer_Book_Table.s_contentemail.CurrentValue, Null, False)

		' Field numberpeople
		Call Customer_Book_Table.numberpeople.SetDbValue(Rs, Customer_Book_Table.numberpeople.CurrentValue, Null, False)

		' Field createddate
		Call Customer_Book_Table.createddate.SetDbValue(Rs, Customer_Book_Table.createddate.CurrentValue, Null, False)

		' Field Email
		Call Customer_Book_Table.zEmail.SetDbValue(Rs, Customer_Book_Table.zEmail.CurrentValue, Null, False)

		' Check recordset update error
		If Err.Number <> 0 Then
			FailureMessage = Err.Description
			Rs.Close
			Set Rs = Nothing
			AddRow = False
			Exit Function
		End If

		' Call Row Inserting event
		bInsertRow = Customer_Book_Table.Row_Inserting(RsOld, Rs)
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
			ElseIf Customer_Book_Table.CancelMessage <> "" Then
				FailureMessage = Customer_Book_Table.CancelMessage
				Customer_Book_Table.CancelMessage = ""
			Else
				FailureMessage = Language.Phrase("InsertCancelled")
			End If
			AddRow = False
		End If
		Rs.Close
		Set Rs = Nothing
		If AddRow Then
			Customer_Book_Table.ID.DbValue = RsNew("ID")
		End If
		If AddRow Then

			' Call Row Inserted event
			Call Customer_Book_Table.Row_Inserted(RsOld, RsNew)
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
		Call Breadcrumb.Add("list", Customer_Book_Table.TableVar, "Customer_Book_Tablelist.asp", "", Customer_Book_Table.TableVar, True)
		PageId = ew_IIf(Customer_Book_Table.CurrentAction = "C", "Copy", "Add")
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
