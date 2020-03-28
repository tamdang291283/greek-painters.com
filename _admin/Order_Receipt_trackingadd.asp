<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="Order_Receipt_trackinginfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim Order_Receipt_tracking_add
Set Order_Receipt_tracking_add = New cOrder_Receipt_tracking_add
Set Page = Order_Receipt_tracking_add

' Page init processing
Order_Receipt_tracking_add.Page_Init()

' Page main processing
Order_Receipt_tracking_add.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
Order_Receipt_tracking_add.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var Order_Receipt_tracking_add = new ew_Page("Order_Receipt_tracking_add");
Order_Receipt_tracking_add.PageID = "add"; // Page ID
var EW_PAGE_ID = Order_Receipt_tracking_add.PageID; // For backward compatibility
// Form object
var fOrder_Receipt_trackingadd = new ew_Form("fOrder_Receipt_trackingadd");
// Validate form
fOrder_Receipt_trackingadd.Validate = function() {
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
			elm = this.GetElements("x" + infix + "_OrderID");
			if (elm && !ew_CheckInteger(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(Order_Receipt_tracking.OrderID.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_IdBusinessDetail");
			if (elm && !ew_CheckInteger(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(Order_Receipt_tracking.IdBusinessDetail.FldErrMsg) %>");
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
fOrder_Receipt_trackingadd.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fOrder_Receipt_trackingadd.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fOrder_Receipt_trackingadd.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<div class="ewToolbar">
<% If Order_Receipt_tracking.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If Order_Receipt_tracking.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% Order_Receipt_tracking_add.ShowPageHeader() %>
<% Order_Receipt_tracking_add.ShowMessage %>
<form name="fOrder_Receipt_trackingadd" id="fOrder_Receipt_trackingadd" class="form-horizontal ewForm ewAddForm" action="<%= ew_CurrentPage() %>" method="post">
<% If Order_Receipt_tracking_add.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= Order_Receipt_tracking_add.Token %>">
<% End If %>
<input type="hidden" name="t" value="Order_Receipt_tracking">
<input type="hidden" name="a_add" id="a_add" value="A">
<div>
<% If Order_Receipt_tracking.OrderID.Visible Then ' OrderID %>
	<div id="r_OrderID" class="form-group">
		<label id="elh_Order_Receipt_tracking_OrderID" for="x_OrderID" class="col-sm-2 control-label ewLabel"><%= Order_Receipt_tracking.OrderID.FldCaption %></label>
		<div class="col-sm-10"><div<%= Order_Receipt_tracking.OrderID.CellAttributes %>>
<span id="el_Order_Receipt_tracking_OrderID">
<input type="text" data-field="x_OrderID" name="x_OrderID" id="x_OrderID" size="30" placeholder="<%= Order_Receipt_tracking.OrderID.PlaceHolder %>" value="<%= Order_Receipt_tracking.OrderID.EditValue %>"<%= Order_Receipt_tracking.OrderID.EditAttributes %>>
</span>
<%= Order_Receipt_tracking.OrderID.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Order_Receipt_tracking.s_printtype.Visible Then ' s_printtype %>
	<div id="r_s_printtype" class="form-group">
		<label id="elh_Order_Receipt_tracking_s_printtype" for="x_s_printtype" class="col-sm-2 control-label ewLabel"><%= Order_Receipt_tracking.s_printtype.FldCaption %></label>
		<div class="col-sm-10"><div<%= Order_Receipt_tracking.s_printtype.CellAttributes %>>
<span id="el_Order_Receipt_tracking_s_printtype">
<input type="text" data-field="x_s_printtype" name="x_s_printtype" id="x_s_printtype" size="30" maxlength="255" placeholder="<%= Order_Receipt_tracking.s_printtype.PlaceHolder %>" value="<%= Order_Receipt_tracking.s_printtype.EditValue %>"<%= Order_Receipt_tracking.s_printtype.EditAttributes %>>
</span>
<%= Order_Receipt_tracking.s_printtype.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Order_Receipt_tracking.s_filename.Visible Then ' s_filename %>
	<div id="r_s_filename" class="form-group">
		<label id="elh_Order_Receipt_tracking_s_filename" for="x_s_filename" class="col-sm-2 control-label ewLabel"><%= Order_Receipt_tracking.s_filename.FldCaption %></label>
		<div class="col-sm-10"><div<%= Order_Receipt_tracking.s_filename.CellAttributes %>>
<span id="el_Order_Receipt_tracking_s_filename">
<input type="text" data-field="x_s_filename" name="x_s_filename" id="x_s_filename" size="30" maxlength="255" placeholder="<%= Order_Receipt_tracking.s_filename.PlaceHolder %>" value="<%= Order_Receipt_tracking.s_filename.EditValue %>"<%= Order_Receipt_tracking.s_filename.EditAttributes %>>
</span>
<%= Order_Receipt_tracking.s_filename.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Order_Receipt_tracking.t_createdDate.Visible Then ' t_createdDate %>
	<div id="r_t_createdDate" class="form-group">
		<label id="elh_Order_Receipt_tracking_t_createdDate" for="x_t_createdDate" class="col-sm-2 control-label ewLabel"><%= Order_Receipt_tracking.t_createdDate.FldCaption %></label>
		<div class="col-sm-10"><div<%= Order_Receipt_tracking.t_createdDate.CellAttributes %>>
<span id="el_Order_Receipt_tracking_t_createdDate">
<input type="text" data-field="x_t_createdDate" name="x_t_createdDate" id="x_t_createdDate" placeholder="<%= Order_Receipt_tracking.t_createdDate.PlaceHolder %>" value="<%= Order_Receipt_tracking.t_createdDate.EditValue %>"<%= Order_Receipt_tracking.t_createdDate.EditAttributes %>>
</span>
<%= Order_Receipt_tracking.t_createdDate.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Order_Receipt_tracking.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
	<div id="r_IdBusinessDetail" class="form-group">
		<label id="elh_Order_Receipt_tracking_IdBusinessDetail" for="x_IdBusinessDetail" class="col-sm-2 control-label ewLabel"><%= Order_Receipt_tracking.IdBusinessDetail.FldCaption %></label>
		<div class="col-sm-10"><div<%= Order_Receipt_tracking.IdBusinessDetail.CellAttributes %>>
<span id="el_Order_Receipt_tracking_IdBusinessDetail">
<input type="text" data-field="x_IdBusinessDetail" name="x_IdBusinessDetail" id="x_IdBusinessDetail" size="30" placeholder="<%= Order_Receipt_tracking.IdBusinessDetail.PlaceHolder %>" value="<%= Order_Receipt_tracking.IdBusinessDetail.EditValue %>"<%= Order_Receipt_tracking.IdBusinessDetail.EditAttributes %>>
</span>
<%= Order_Receipt_tracking.IdBusinessDetail.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Order_Receipt_tracking.s_printstatus.Visible Then ' s_printstatus %>
	<div id="r_s_printstatus" class="form-group">
		<label id="elh_Order_Receipt_tracking_s_printstatus" for="x_s_printstatus" class="col-sm-2 control-label ewLabel"><%= Order_Receipt_tracking.s_printstatus.FldCaption %></label>
		<div class="col-sm-10"><div<%= Order_Receipt_tracking.s_printstatus.CellAttributes %>>
<span id="el_Order_Receipt_tracking_s_printstatus">
<input type="text" data-field="x_s_printstatus" name="x_s_printstatus" id="x_s_printstatus" size="30" maxlength="255" placeholder="<%= Order_Receipt_tracking.s_printstatus.PlaceHolder %>" value="<%= Order_Receipt_tracking.s_printstatus.EditValue %>"<%= Order_Receipt_tracking.s_printstatus.EditAttributes %>>
</span>
<%= Order_Receipt_tracking.s_printstatus.CustomMsg %></div></div>
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
fOrder_Receipt_trackingadd.Init();
</script>
<%
Order_Receipt_tracking_add.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set Order_Receipt_tracking_add = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cOrder_Receipt_tracking_add

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
		TableName = "Order_Receipt_tracking"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "Order_Receipt_tracking_add"
	End Property

	' Page Name
	Public Property Get PageName()
		PageName = ew_CurrentPage()
	End Property

	' Page Url
	Public Property Get PageUrl()
		PageUrl = ew_CurrentPage() & "?"
		If Order_Receipt_tracking.UseTokenInUrl Then PageUrl = PageUrl & "t=" & Order_Receipt_tracking.TableVar & "&" ' add page token
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
		If Order_Receipt_tracking.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (Order_Receipt_tracking.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (Order_Receipt_tracking.TableVar = Request.QueryString("t"))
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
		If IsEmpty(Order_Receipt_tracking) Then Set Order_Receipt_tracking = New cOrder_Receipt_tracking
		Set Table = Order_Receipt_tracking

		' Initialize urls
		' Initialize form object

		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "add"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "Order_Receipt_tracking"

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

		Order_Receipt_tracking.CurrentAction = ew_IIf(Request.QueryString("a").Count > 0, Request.QueryString("a") & "", ObjForm.GetValue("a_list") & "") ' Set up current action

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
			results = Order_Receipt_tracking.GetAutoFill(Request.Form("name"), Request.Form("q"))
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
		If Not Order_Receipt_tracking Is Nothing Then
			If Order_Receipt_tracking.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = Order_Receipt_tracking.TableVar
				If Order_Receipt_tracking.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf Order_Receipt_tracking.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf Order_Receipt_tracking.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf Order_Receipt_tracking.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set Order_Receipt_tracking = Nothing
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
			Order_Receipt_tracking.CurrentAction = ObjForm.GetValue("a_add") ' Get form action
			CopyRecord = LoadOldRecord() ' Load old recordset
			Call LoadFormValues() ' Load form values

		' Not post back
		Else

			' Load key values from QueryString
			CopyRecord = True
			If Request.QueryString("l_id").Count > 0 Then
				Order_Receipt_tracking.l_id.QueryStringValue = Request.QueryString("l_id")
				Call Order_Receipt_tracking.SetKey("l_id", Order_Receipt_tracking.l_id.CurrentValue) ' Set up key
			Else
				Call Order_Receipt_tracking.SetKey("l_id", "") ' Clear key
				CopyRecord = False
			End If
			If CopyRecord Then
				Order_Receipt_tracking.CurrentAction = "C" ' Copy Record
			Else
				Order_Receipt_tracking.CurrentAction = "I" ' Display Blank Record
				Call LoadDefaultValues() ' Load default values
			End If
		End If

		' Set up Breadcrumb
		SetupBreadcrumb()

		' Validate form if post back
		If ObjForm.GetValue("a_add")&"" <> "" Then
			If Not ValidateForm() Then
				Order_Receipt_tracking.CurrentAction = "I" ' Form error, reset action
				Order_Receipt_tracking.EventCancelled = True ' Event cancelled
				Call RestoreFormValues() ' Restore form values
				FailureMessage = gsFormError
			End If
		End If

		' Perform action based on action code
		Select Case Order_Receipt_tracking.CurrentAction
			Case "I" ' Blank record, no action required
			Case "C" ' Copy an existing record
				If Not LoadRow() Then ' Load record based on key
					If FailureMessage = "" Then FailureMessage = Language.Phrase("NoRecord") ' No record found
					Call Page_Terminate("Order_Receipt_trackinglist.asp") ' No matching record, return to list
				End If
			Case "A" ' Add new record
				Order_Receipt_tracking.SendEmail = True ' Send email on add success
				If AddRow(OldRecordset) Then ' Add successful
					If SuccessMessage = "" Then SuccessMessage = Language.Phrase("AddSuccess") ' Set up success message
					Dim sReturnUrl
					sReturnUrl = Order_Receipt_tracking.ReturnUrl
					If ew_GetPageName(sReturnUrl) = "Order_Receipt_trackingview.asp" Then sReturnUrl = Order_Receipt_tracking.ViewUrl("") ' View paging, return to view page with keyurl directly
					Call Page_Terminate(sReturnUrl) ' Clean up and return
				Else
					Order_Receipt_tracking.EventCancelled = True ' Event cancelled
					Call RestoreFormValues() ' Add failed, restore form values
				End If
		End Select

		' Render row based on row type
		Order_Receipt_tracking.RowType = EW_ROWTYPE_ADD ' Render add type

		' Render row
		Call Order_Receipt_tracking.ResetAttrs()
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
		Order_Receipt_tracking.OrderID.CurrentValue = Null
		Order_Receipt_tracking.OrderID.OldValue = Order_Receipt_tracking.OrderID.CurrentValue
		Order_Receipt_tracking.s_printtype.CurrentValue = Null
		Order_Receipt_tracking.s_printtype.OldValue = Order_Receipt_tracking.s_printtype.CurrentValue
		Order_Receipt_tracking.s_filename.CurrentValue = Null
		Order_Receipt_tracking.s_filename.OldValue = Order_Receipt_tracking.s_filename.CurrentValue
		Order_Receipt_tracking.t_createdDate.CurrentValue = Null
		Order_Receipt_tracking.t_createdDate.OldValue = Order_Receipt_tracking.t_createdDate.CurrentValue
		Order_Receipt_tracking.IdBusinessDetail.CurrentValue = Null
		Order_Receipt_tracking.IdBusinessDetail.OldValue = Order_Receipt_tracking.IdBusinessDetail.CurrentValue
		Order_Receipt_tracking.s_printstatus.CurrentValue = Null
		Order_Receipt_tracking.s_printstatus.OldValue = Order_Receipt_tracking.s_printstatus.CurrentValue
	End Function

	' -----------------------------------------------------------------
	' Load form values
	'
	Function LoadFormValues()

		' Load values from form
		If Not Order_Receipt_tracking.OrderID.FldIsDetailKey Then Order_Receipt_tracking.OrderID.FormValue = ObjForm.GetValue("x_OrderID")
		If Not Order_Receipt_tracking.s_printtype.FldIsDetailKey Then Order_Receipt_tracking.s_printtype.FormValue = ObjForm.GetValue("x_s_printtype")
		If Not Order_Receipt_tracking.s_filename.FldIsDetailKey Then Order_Receipt_tracking.s_filename.FormValue = ObjForm.GetValue("x_s_filename")
		If Not Order_Receipt_tracking.t_createdDate.FldIsDetailKey Then Order_Receipt_tracking.t_createdDate.FormValue = ObjForm.GetValue("x_t_createdDate")
		If Not Order_Receipt_tracking.t_createdDate.FldIsDetailKey Then Order_Receipt_tracking.t_createdDate.CurrentValue = ew_UnFormatDateTime(Order_Receipt_tracking.t_createdDate.CurrentValue, 9)
		If Not Order_Receipt_tracking.IdBusinessDetail.FldIsDetailKey Then Order_Receipt_tracking.IdBusinessDetail.FormValue = ObjForm.GetValue("x_IdBusinessDetail")
		If Not Order_Receipt_tracking.s_printstatus.FldIsDetailKey Then Order_Receipt_tracking.s_printstatus.FormValue = ObjForm.GetValue("x_s_printstatus")
	End Function

	' -----------------------------------------------------------------
	' Restore form values
	'
	Function RestoreFormValues()
		Call LoadOldRecord()
		Order_Receipt_tracking.OrderID.CurrentValue = Order_Receipt_tracking.OrderID.FormValue
		Order_Receipt_tracking.s_printtype.CurrentValue = Order_Receipt_tracking.s_printtype.FormValue
		Order_Receipt_tracking.s_filename.CurrentValue = Order_Receipt_tracking.s_filename.FormValue
		Order_Receipt_tracking.t_createdDate.CurrentValue = Order_Receipt_tracking.t_createdDate.FormValue
		Order_Receipt_tracking.t_createdDate.CurrentValue = ew_UnFormatDateTime(Order_Receipt_tracking.t_createdDate.CurrentValue, 9)
		Order_Receipt_tracking.IdBusinessDetail.CurrentValue = Order_Receipt_tracking.IdBusinessDetail.FormValue
		Order_Receipt_tracking.s_printstatus.CurrentValue = Order_Receipt_tracking.s_printstatus.FormValue
	End Function

	' -----------------------------------------------------------------
	' Load row based on key values
	'
	Function LoadRow()
		Dim RsRow, sSql, sFilter
		sFilter = Order_Receipt_tracking.KeyFilter

		' Call Row Selecting event
		Call Order_Receipt_tracking.Row_Selecting(sFilter)

		' Load sql based on filter
		Order_Receipt_tracking.CurrentFilter = sFilter
		sSql = Order_Receipt_tracking.SQL
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
		Call Order_Receipt_tracking.Row_Selected(RsRow)
		Order_Receipt_tracking.l_id.DbValue = RsRow("l_id")
		Order_Receipt_tracking.OrderID.DbValue = RsRow("OrderID")
		Order_Receipt_tracking.s_printtype.DbValue = RsRow("s_printtype")
		Order_Receipt_tracking.s_filename.DbValue = RsRow("s_filename")
		Order_Receipt_tracking.t_createdDate.DbValue = RsRow("t_createdDate")
		Order_Receipt_tracking.IdBusinessDetail.DbValue = RsRow("IdBusinessDetail")
		Order_Receipt_tracking.s_printstatus.DbValue = RsRow("s_printstatus")
	End Sub

	' Load DbValue from recordset
	Sub LoadDbValues(Rs)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		If Rs.Eof Then Exit Sub
		Order_Receipt_tracking.l_id.m_DbValue = Rs("l_id")
		Order_Receipt_tracking.OrderID.m_DbValue = Rs("OrderID")
		Order_Receipt_tracking.s_printtype.m_DbValue = Rs("s_printtype")
		Order_Receipt_tracking.s_filename.m_DbValue = Rs("s_filename")
		Order_Receipt_tracking.t_createdDate.m_DbValue = Rs("t_createdDate")
		Order_Receipt_tracking.IdBusinessDetail.m_DbValue = Rs("IdBusinessDetail")
		Order_Receipt_tracking.s_printstatus.m_DbValue = Rs("s_printstatus")
	End Sub

	' Load old record
	Function LoadOldRecord()

		' Load key values from Session
		Dim bValidKey
		bValidKey = True
		If Order_Receipt_tracking.GetKey("l_id")&"" <> "" Then
			Order_Receipt_tracking.l_id.CurrentValue = Order_Receipt_tracking.GetKey("l_id") ' l_id
		Else
			bValidKey = False
		End If

		' Load old recordset
		If bValidKey Then
			Order_Receipt_tracking.CurrentFilter = Order_Receipt_tracking.KeyFilter
			Dim sSql
			sSql = Order_Receipt_tracking.SQL
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

		Call Order_Receipt_tracking.Row_Rendering()

		' ---------------------------------------
		'  Common render codes for all row types
		' ---------------------------------------
		' l_id
		' OrderID
		' s_printtype
		' s_filename
		' t_createdDate
		' IdBusinessDetail
		' s_printstatus
		' -----------
		'  View  Row
		' -----------

		If Order_Receipt_tracking.RowType = EW_ROWTYPE_VIEW Then ' View row

			' l_id
			Order_Receipt_tracking.l_id.ViewValue = Order_Receipt_tracking.l_id.CurrentValue
			Order_Receipt_tracking.l_id.ViewCustomAttributes = ""

			' OrderID
			Order_Receipt_tracking.OrderID.ViewValue = Order_Receipt_tracking.OrderID.CurrentValue
			Order_Receipt_tracking.OrderID.ViewCustomAttributes = ""

			' s_printtype
			Order_Receipt_tracking.s_printtype.ViewValue = Order_Receipt_tracking.s_printtype.CurrentValue
			Order_Receipt_tracking.s_printtype.ViewCustomAttributes = ""

			' s_filename
			Order_Receipt_tracking.s_filename.ViewValue = Order_Receipt_tracking.s_filename.CurrentValue
			Order_Receipt_tracking.s_filename.ViewCustomAttributes = ""

			' t_createdDate
			Order_Receipt_tracking.t_createdDate.ViewValue = Order_Receipt_tracking.t_createdDate.CurrentValue
			Order_Receipt_tracking.t_createdDate.ViewCustomAttributes = ""

			' IdBusinessDetail
			Order_Receipt_tracking.IdBusinessDetail.ViewValue = Order_Receipt_tracking.IdBusinessDetail.CurrentValue
			Order_Receipt_tracking.IdBusinessDetail.ViewCustomAttributes = ""

			' s_printstatus
			Order_Receipt_tracking.s_printstatus.ViewValue = Order_Receipt_tracking.s_printstatus.CurrentValue
			Order_Receipt_tracking.s_printstatus.ViewCustomAttributes = ""

			' View refer script
			' OrderID

			Order_Receipt_tracking.OrderID.LinkCustomAttributes = ""
			Order_Receipt_tracking.OrderID.HrefValue = ""
			Order_Receipt_tracking.OrderID.TooltipValue = ""

			' s_printtype
			Order_Receipt_tracking.s_printtype.LinkCustomAttributes = ""
			Order_Receipt_tracking.s_printtype.HrefValue = ""
			Order_Receipt_tracking.s_printtype.TooltipValue = ""

			' s_filename
			Order_Receipt_tracking.s_filename.LinkCustomAttributes = ""
			Order_Receipt_tracking.s_filename.HrefValue = ""
			Order_Receipt_tracking.s_filename.TooltipValue = ""

			' t_createdDate
			Order_Receipt_tracking.t_createdDate.LinkCustomAttributes = ""
			Order_Receipt_tracking.t_createdDate.HrefValue = ""
			Order_Receipt_tracking.t_createdDate.TooltipValue = ""

			' IdBusinessDetail
			Order_Receipt_tracking.IdBusinessDetail.LinkCustomAttributes = ""
			Order_Receipt_tracking.IdBusinessDetail.HrefValue = ""
			Order_Receipt_tracking.IdBusinessDetail.TooltipValue = ""

			' s_printstatus
			Order_Receipt_tracking.s_printstatus.LinkCustomAttributes = ""
			Order_Receipt_tracking.s_printstatus.HrefValue = ""
			Order_Receipt_tracking.s_printstatus.TooltipValue = ""

		' ---------
		'  Add Row
		' ---------

		ElseIf Order_Receipt_tracking.RowType = EW_ROWTYPE_ADD Then ' Add row

			' OrderID
			Order_Receipt_tracking.OrderID.EditAttrs.UpdateAttribute "class", "form-control"
			Order_Receipt_tracking.OrderID.EditCustomAttributes = ""
			Order_Receipt_tracking.OrderID.EditValue = ew_HtmlEncode(Order_Receipt_tracking.OrderID.CurrentValue)
			Order_Receipt_tracking.OrderID.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Order_Receipt_tracking.OrderID.FldCaption))

			' s_printtype
			Order_Receipt_tracking.s_printtype.EditAttrs.UpdateAttribute "class", "form-control"
			Order_Receipt_tracking.s_printtype.EditCustomAttributes = ""
			Order_Receipt_tracking.s_printtype.EditValue = ew_HtmlEncode(Order_Receipt_tracking.s_printtype.CurrentValue)
			Order_Receipt_tracking.s_printtype.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Order_Receipt_tracking.s_printtype.FldCaption))

			' s_filename
			Order_Receipt_tracking.s_filename.EditAttrs.UpdateAttribute "class", "form-control"
			Order_Receipt_tracking.s_filename.EditCustomAttributes = ""
			Order_Receipt_tracking.s_filename.EditValue = ew_HtmlEncode(Order_Receipt_tracking.s_filename.CurrentValue)
			Order_Receipt_tracking.s_filename.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Order_Receipt_tracking.s_filename.FldCaption))

			' t_createdDate
			Order_Receipt_tracking.t_createdDate.EditAttrs.UpdateAttribute "class", "form-control"
			Order_Receipt_tracking.t_createdDate.EditCustomAttributes = ""
			Order_Receipt_tracking.t_createdDate.EditValue = ew_HtmlEncode(Order_Receipt_tracking.t_createdDate.CurrentValue)
			Order_Receipt_tracking.t_createdDate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Order_Receipt_tracking.t_createdDate.FldCaption))

			' IdBusinessDetail
			Order_Receipt_tracking.IdBusinessDetail.EditAttrs.UpdateAttribute "class", "form-control"
			Order_Receipt_tracking.IdBusinessDetail.EditCustomAttributes = ""
			Order_Receipt_tracking.IdBusinessDetail.EditValue = ew_HtmlEncode(Order_Receipt_tracking.IdBusinessDetail.CurrentValue)
			Order_Receipt_tracking.IdBusinessDetail.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Order_Receipt_tracking.IdBusinessDetail.FldCaption))

			' s_printstatus
			Order_Receipt_tracking.s_printstatus.EditAttrs.UpdateAttribute "class", "form-control"
			Order_Receipt_tracking.s_printstatus.EditCustomAttributes = ""
			Order_Receipt_tracking.s_printstatus.EditValue = ew_HtmlEncode(Order_Receipt_tracking.s_printstatus.CurrentValue)
			Order_Receipt_tracking.s_printstatus.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Order_Receipt_tracking.s_printstatus.FldCaption))

			' Edit refer script
			' OrderID

			Order_Receipt_tracking.OrderID.HrefValue = ""

			' s_printtype
			Order_Receipt_tracking.s_printtype.HrefValue = ""

			' s_filename
			Order_Receipt_tracking.s_filename.HrefValue = ""

			' t_createdDate
			Order_Receipt_tracking.t_createdDate.HrefValue = ""

			' IdBusinessDetail
			Order_Receipt_tracking.IdBusinessDetail.HrefValue = ""

			' s_printstatus
			Order_Receipt_tracking.s_printstatus.HrefValue = ""
		End If
		If Order_Receipt_tracking.RowType = EW_ROWTYPE_ADD Or Order_Receipt_tracking.RowType = EW_ROWTYPE_EDIT Or Order_Receipt_tracking.RowType = EW_ROWTYPE_SEARCH Then ' Add / Edit / Search row
			Call Order_Receipt_tracking.SetupFieldTitles()
		End If

		' Call Row Rendered event
		If Order_Receipt_tracking.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call Order_Receipt_tracking.Row_Rendered()
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
		If Not ew_CheckInteger(Order_Receipt_tracking.OrderID.FormValue) Then
			Call ew_AddMessage(gsFormError, Order_Receipt_tracking.OrderID.FldErrMsg)
		End If
		If Not ew_CheckInteger(Order_Receipt_tracking.IdBusinessDetail.FormValue) Then
			Call ew_AddMessage(gsFormError, Order_Receipt_tracking.IdBusinessDetail.FldErrMsg)
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
		Order_Receipt_tracking.CurrentFilter = sFilter
		sSql = Order_Receipt_tracking.SQL
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

		' Field OrderID
		Call Order_Receipt_tracking.OrderID.SetDbValue(Rs, Order_Receipt_tracking.OrderID.CurrentValue, Null, False)

		' Field s_printtype
		Call Order_Receipt_tracking.s_printtype.SetDbValue(Rs, Order_Receipt_tracking.s_printtype.CurrentValue, Null, False)

		' Field s_filename
		Call Order_Receipt_tracking.s_filename.SetDbValue(Rs, Order_Receipt_tracking.s_filename.CurrentValue, Null, False)

		' Field t_createdDate
		Call Order_Receipt_tracking.t_createdDate.SetDbValue(Rs, Order_Receipt_tracking.t_createdDate.CurrentValue, Null, False)

		' Field IdBusinessDetail
		Call Order_Receipt_tracking.IdBusinessDetail.SetDbValue(Rs, Order_Receipt_tracking.IdBusinessDetail.CurrentValue, Null, False)

		' Field s_printstatus
		Call Order_Receipt_tracking.s_printstatus.SetDbValue(Rs, Order_Receipt_tracking.s_printstatus.CurrentValue, Null, False)

		' Check recordset update error
		If Err.Number <> 0 Then
			FailureMessage = Err.Description
			Rs.Close
			Set Rs = Nothing
			AddRow = False
			Exit Function
		End If

		' Call Row Inserting event
		bInsertRow = Order_Receipt_tracking.Row_Inserting(RsOld, Rs)
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
			ElseIf Order_Receipt_tracking.CancelMessage <> "" Then
				FailureMessage = Order_Receipt_tracking.CancelMessage
				Order_Receipt_tracking.CancelMessage = ""
			Else
				FailureMessage = Language.Phrase("InsertCancelled")
			End If
			AddRow = False
		End If
		Rs.Close
		Set Rs = Nothing
		If AddRow Then
			Order_Receipt_tracking.l_id.DbValue = RsNew("l_id")
		End If
		If AddRow Then

			' Call Row Inserted event
			Call Order_Receipt_tracking.Row_Inserted(RsOld, RsNew)
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
		Call Breadcrumb.Add("list", Order_Receipt_tracking.TableVar, "Order_Receipt_trackinglist.asp", "", Order_Receipt_tracking.TableVar, True)
		PageId = ew_IIf(Order_Receipt_tracking.CurrentAction = "C", "Copy", "Add")
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
