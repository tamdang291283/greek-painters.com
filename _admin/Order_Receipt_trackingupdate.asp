﻿<%@ CodePage="65001" %>
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
Dim Order_Receipt_tracking_update
Set Order_Receipt_tracking_update = New cOrder_Receipt_tracking_update
Set Page = Order_Receipt_tracking_update

' Page init processing
Order_Receipt_tracking_update.Page_Init()

' Page main processing
Order_Receipt_tracking_update.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
Order_Receipt_tracking_update.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var Order_Receipt_tracking_update = new ew_Page("Order_Receipt_tracking_update");
Order_Receipt_tracking_update.PageID = "update"; // Page ID
var EW_PAGE_ID = Order_Receipt_tracking_update.PageID; // For backward compatibility
// Form object
var fOrder_Receipt_trackingupdate = new ew_Form("fOrder_Receipt_trackingupdate");
// Validate form
fOrder_Receipt_trackingupdate.Validate = function() {
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
			elm = this.GetElements("x" + infix + "_OrderID");
			uelm = this.GetElements("u" + infix + "_OrderID");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(Order_Receipt_tracking.OrderID.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_t_createdDate");
			uelm = this.GetElements("u" + infix + "_t_createdDate");
			if (uelm && uelm.checked && elm && !ew_CheckDate(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(Order_Receipt_tracking.t_createdDate.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_IdBusinessDetail");
			uelm = this.GetElements("u" + infix + "_IdBusinessDetail");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(Order_Receipt_tracking.IdBusinessDetail.FldErrMsg) %>");
			// Set up row object
			ew_ElementsToRow(fobj);
			// Fire Form_CustomValidate event
			if (!this.Form_CustomValidate(fobj))
				return false;
	}
	return true;
}
// Form_CustomValidate event
fOrder_Receipt_trackingupdate.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fOrder_Receipt_trackingupdate.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fOrder_Receipt_trackingupdate.ValidateRequired = false; // No JavaScript validation
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
<% Order_Receipt_tracking_update.ShowPageHeader() %>
<% Order_Receipt_tracking_update.ShowMessage %>
<form name="fOrder_Receipt_trackingupdate" id="fOrder_Receipt_trackingupdate" class="form-horizontal ewForm ewUpdateForm" action="<%= ew_CurrentPage %>" method="post">
<% If Order_Receipt_tracking_update.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= Order_Receipt_tracking_update.Token %>">
<% End If %>
<input type="hidden" name="t" value="Order_Receipt_tracking">
<input type="hidden" name="a_update" id="a_update" value="U">
<% For i = 0 to UBound(Order_Receipt_tracking_update.RecKeys) %>
<input type="hidden" name="key_m" id="key_m" value="<%= ew_HtmlEncode(ew_GetKeyValue(Order_Receipt_tracking_update.RecKeys(i))) %>">
<% Next %>
<div id="tbl_Order_Receipt_trackingupdate">
	<div class="form-group">
		<label class="col-sm-2"><input type="checkbox" name="u" id="u" onclick="ew_SelectAll(this);"> <%= Language.Phrase("UpdateSelectAll") %></label>
	</div>
<% If Order_Receipt_tracking.OrderID.Visible Then ' OrderID %>
	<div id="r_OrderID" class="form-group">
		<label for="x_OrderID" class="col-sm-2 control-label">
<input type="checkbox" name="u_OrderID" id="u_OrderID" value="1"<% If Order_Receipt_tracking.OrderID.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= Order_Receipt_tracking.OrderID.FldCaption %></label>
		<div class="col-sm-10"><div<%= Order_Receipt_tracking.OrderID.CellAttributes %>>
<span id="el_Order_Receipt_tracking_OrderID">
<input type="text" data-field="x_OrderID" name="x_OrderID" id="x_OrderID" size="30" placeholder="<%= Order_Receipt_tracking.OrderID.PlaceHolder %>" value="<%= Order_Receipt_tracking.OrderID.EditValue %>"<%= Order_Receipt_tracking.OrderID.EditAttributes %>>
</span>
<%= Order_Receipt_tracking.OrderID.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Order_Receipt_tracking.s_printtype.Visible Then ' s_printtype %>
	<div id="r_s_printtype" class="form-group">
		<label for="x_s_printtype" class="col-sm-2 control-label">
<input type="checkbox" name="u_s_printtype" id="u_s_printtype" value="1"<% If Order_Receipt_tracking.s_printtype.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= Order_Receipt_tracking.s_printtype.FldCaption %></label>
		<div class="col-sm-10"><div<%= Order_Receipt_tracking.s_printtype.CellAttributes %>>
<span id="el_Order_Receipt_tracking_s_printtype">
<input type="text" data-field="x_s_printtype" name="x_s_printtype" id="x_s_printtype" size="30" maxlength="255" placeholder="<%= Order_Receipt_tracking.s_printtype.PlaceHolder %>" value="<%= Order_Receipt_tracking.s_printtype.EditValue %>"<%= Order_Receipt_tracking.s_printtype.EditAttributes %>>
</span>
<%= Order_Receipt_tracking.s_printtype.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Order_Receipt_tracking.s_filename.Visible Then ' s_filename %>
	<div id="r_s_filename" class="form-group">
		<label for="x_s_filename" class="col-sm-2 control-label">
<input type="checkbox" name="u_s_filename" id="u_s_filename" value="1"<% If Order_Receipt_tracking.s_filename.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= Order_Receipt_tracking.s_filename.FldCaption %></label>
		<div class="col-sm-10"><div<%= Order_Receipt_tracking.s_filename.CellAttributes %>>
<span id="el_Order_Receipt_tracking_s_filename">
<input type="text" data-field="x_s_filename" name="x_s_filename" id="x_s_filename" size="30" maxlength="255" placeholder="<%= Order_Receipt_tracking.s_filename.PlaceHolder %>" value="<%= Order_Receipt_tracking.s_filename.EditValue %>"<%= Order_Receipt_tracking.s_filename.EditAttributes %>>
</span>
<%= Order_Receipt_tracking.s_filename.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Order_Receipt_tracking.t_createdDate.Visible Then ' t_createdDate %>
	<div id="r_t_createdDate" class="form-group">
		<label for="x_t_createdDate" class="col-sm-2 control-label">
<input type="checkbox" name="u_t_createdDate" id="u_t_createdDate" value="1"<% If Order_Receipt_tracking.t_createdDate.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= Order_Receipt_tracking.t_createdDate.FldCaption %></label>
		<div class="col-sm-10"><div<%= Order_Receipt_tracking.t_createdDate.CellAttributes %>>
<span id="el_Order_Receipt_tracking_t_createdDate">
<input type="text" data-field="x_t_createdDate" name="x_t_createdDate" id="x_t_createdDate" placeholder="<%= Order_Receipt_tracking.t_createdDate.PlaceHolder %>" value="<%= Order_Receipt_tracking.t_createdDate.EditValue %>"<%= Order_Receipt_tracking.t_createdDate.EditAttributes %>>
</span>
<%= Order_Receipt_tracking.t_createdDate.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Order_Receipt_tracking.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
	<div id="r_IdBusinessDetail" class="form-group">
		<label for="x_IdBusinessDetail" class="col-sm-2 control-label">
<input type="checkbox" name="u_IdBusinessDetail" id="u_IdBusinessDetail" value="1"<% If Order_Receipt_tracking.IdBusinessDetail.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= Order_Receipt_tracking.IdBusinessDetail.FldCaption %></label>
		<div class="col-sm-10"><div<%= Order_Receipt_tracking.IdBusinessDetail.CellAttributes %>>
<span id="el_Order_Receipt_tracking_IdBusinessDetail">
<input type="text" data-field="x_IdBusinessDetail" name="x_IdBusinessDetail" id="x_IdBusinessDetail" size="30" placeholder="<%= Order_Receipt_tracking.IdBusinessDetail.PlaceHolder %>" value="<%= Order_Receipt_tracking.IdBusinessDetail.EditValue %>"<%= Order_Receipt_tracking.IdBusinessDetail.EditAttributes %>>
</span>
<%= Order_Receipt_tracking.IdBusinessDetail.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Order_Receipt_tracking.s_printstatus.Visible Then ' s_printstatus %>
	<div id="r_s_printstatus" class="form-group">
		<label for="x_s_printstatus" class="col-sm-2 control-label">
<input type="checkbox" name="u_s_printstatus" id="u_s_printstatus" value="1"<% If Order_Receipt_tracking.s_printstatus.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= Order_Receipt_tracking.s_printstatus.FldCaption %></label>
		<div class="col-sm-10"><div<%= Order_Receipt_tracking.s_printstatus.CellAttributes %>>
<span id="el_Order_Receipt_tracking_s_printstatus">
<input type="text" data-field="x_s_printstatus" name="x_s_printstatus" id="x_s_printstatus" size="30" maxlength="255" placeholder="<%= Order_Receipt_tracking.s_printstatus.PlaceHolder %>" value="<%= Order_Receipt_tracking.s_printstatus.EditValue %>"<%= Order_Receipt_tracking.s_printstatus.EditAttributes %>>
</span>
<%= Order_Receipt_tracking.s_printstatus.CustomMsg %></div></div>
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
fOrder_Receipt_trackingupdate.Init();
</script>
<%
Order_Receipt_tracking_update.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set Order_Receipt_tracking_update = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cOrder_Receipt_tracking_update

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
		TableName = "Order_Receipt_tracking"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "Order_Receipt_tracking_update"
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
		EW_PAGE_ID = "update"

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
		RecKeys = Order_Receipt_tracking.GetRecordKeys() ' Load record keys
		If ObjForm.GetValue("a_update")&"" <> "" Then

			' Get action
			Order_Receipt_tracking.CurrentAction = ObjForm.GetValue("a_update")
			Call LoadFormValues() ' Get form values

			' Validate form
			If Not ValidateForm() Then
				Order_Receipt_tracking.CurrentAction = "I" ' Form error, reset action
				FailureMessage = gsFormError
			End If
		Else
			Call LoadMultiUpdateValues() ' Load initial values to form
		End If
		If Not IsArray(RecKeys) Then
			Call Page_Terminate("Order_Receipt_trackinglist.asp") ' No records selected, return to list
		End If
		Select Case Order_Receipt_tracking.CurrentAction
			Case "U" ' Update
				If UpdateRows() Then ' Update Records based on key
					If SuccessMessage = "" Then SuccessMessage = Language.Phrase("UpdateSuccess") ' Set update success message
					Call Page_Terminate(Order_Receipt_tracking.ReturnUrl) ' Return to caller
				Else
					Call RestoreFormValues() ' Restore form values
				End If
		End Select

		' Render row
		Order_Receipt_tracking.RowType = EW_ROWTYPE_EDIT ' Render edit

		' Render row
		Call Order_Receipt_tracking.ResetAttrs()
		Call RenderRow()
	End Sub

	' -----------------------------------------------------------------
	' Load initial values to form if field values are identical in all selected records
	'
	Sub LoadMultiUpdateValues()
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		Dim Rs, i, OldValue, NewValue
		Order_Receipt_tracking.CurrentFilter = Order_Receipt_tracking.GetKeyFilter()

		' Load recordset
		Set Rs = LoadRecordset()
		i = 1
		Do While Not Rs.Eof
			If i = 1 Then
				Order_Receipt_tracking.OrderID.DbValue = ew_Conv(Rs("OrderID"), Rs("OrderID").Type)
				Order_Receipt_tracking.s_printtype.DbValue = ew_Conv(Rs("s_printtype"), Rs("s_printtype").Type)
				Order_Receipt_tracking.s_filename.DbValue = ew_Conv(Rs("s_filename"), Rs("s_filename").Type)
				Order_Receipt_tracking.t_createdDate.DbValue = ew_Conv(Rs("t_createdDate"), Rs("t_createdDate").Type)
				Order_Receipt_tracking.IdBusinessDetail.DbValue = ew_Conv(Rs("IdBusinessDetail"), Rs("IdBusinessDetail").Type)
				Order_Receipt_tracking.s_printstatus.DbValue = ew_Conv(Rs("s_printstatus"), Rs("s_printstatus").Type)
			Else
				OldValue = Order_Receipt_tracking.OrderID.DbValue
				NewValue = ew_Conv(Rs("OrderID"), Rs("OrderID").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					Order_Receipt_tracking.OrderID.CurrentValue = Null
				End If
				OldValue = Order_Receipt_tracking.s_printtype.DbValue
				NewValue = ew_Conv(Rs("s_printtype"), Rs("s_printtype").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					Order_Receipt_tracking.s_printtype.CurrentValue = Null
				End If
				OldValue = Order_Receipt_tracking.s_filename.DbValue
				NewValue = ew_Conv(Rs("s_filename"), Rs("s_filename").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					Order_Receipt_tracking.s_filename.CurrentValue = Null
				End If
				OldValue = Order_Receipt_tracking.t_createdDate.DbValue
				NewValue = ew_Conv(Rs("t_createdDate"), Rs("t_createdDate").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					Order_Receipt_tracking.t_createdDate.CurrentValue = Null
				End If
				OldValue = Order_Receipt_tracking.IdBusinessDetail.DbValue
				NewValue = ew_Conv(Rs("IdBusinessDetail"), Rs("IdBusinessDetail").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					Order_Receipt_tracking.IdBusinessDetail.CurrentValue = Null
				End If
				OldValue = Order_Receipt_tracking.s_printstatus.DbValue
				NewValue = ew_Conv(Rs("s_printstatus"), Rs("s_printstatus").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					Order_Receipt_tracking.s_printstatus.CurrentValue = Null
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
		Order_Receipt_tracking.l_id.CurrentValue = sKeyFld ' Set up key value
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
		Order_Receipt_tracking.CurrentFilter = Order_Receipt_tracking.GetKeyFilter()
		sSql = Order_Receipt_tracking.SQL
		Set Rs = Server.CreateObject("ADODB.Recordset")
		Rs.CursorLocation = EW_CURSORLOCATION
		Rs.Open sSql, Conn, 1, EW_RECORDSET_LOCKTYPE
		Set RsOld = ew_CloneRs(Rs)

		' Update all rows
		sKey = ""
		For i = 0 to UBound(RecKeys)
			If SetupKeyValues(RecKeys(i)) Then
				sThisKey = RecKeys(i)
				Order_Receipt_tracking.SendEmail = False ' Do not send email on update success
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
		If Not Order_Receipt_tracking.OrderID.FldIsDetailKey Then Order_Receipt_tracking.OrderID.FormValue = ObjForm.GetValue("x_OrderID")
		Order_Receipt_tracking.OrderID.MultiUpdate = ObjForm.GetValue("u_OrderID")
		If Not Order_Receipt_tracking.s_printtype.FldIsDetailKey Then Order_Receipt_tracking.s_printtype.FormValue = ObjForm.GetValue("x_s_printtype")
		Order_Receipt_tracking.s_printtype.MultiUpdate = ObjForm.GetValue("u_s_printtype")
		If Not Order_Receipt_tracking.s_filename.FldIsDetailKey Then Order_Receipt_tracking.s_filename.FormValue = ObjForm.GetValue("x_s_filename")
		Order_Receipt_tracking.s_filename.MultiUpdate = ObjForm.GetValue("u_s_filename")
		If Not Order_Receipt_tracking.t_createdDate.FldIsDetailKey Then Order_Receipt_tracking.t_createdDate.FormValue = ObjForm.GetValue("x_t_createdDate")
		If Not Order_Receipt_tracking.t_createdDate.FldIsDetailKey Then Order_Receipt_tracking.t_createdDate.CurrentValue = ew_UnFormatDateTime(Order_Receipt_tracking.t_createdDate.CurrentValue, 9)
		Order_Receipt_tracking.t_createdDate.MultiUpdate = ObjForm.GetValue("u_t_createdDate")
		If Not Order_Receipt_tracking.IdBusinessDetail.FldIsDetailKey Then Order_Receipt_tracking.IdBusinessDetail.FormValue = ObjForm.GetValue("x_IdBusinessDetail")
		Order_Receipt_tracking.IdBusinessDetail.MultiUpdate = ObjForm.GetValue("u_IdBusinessDetail")
		If Not Order_Receipt_tracking.s_printstatus.FldIsDetailKey Then Order_Receipt_tracking.s_printstatus.FormValue = ObjForm.GetValue("x_s_printstatus")
		Order_Receipt_tracking.s_printstatus.MultiUpdate = ObjForm.GetValue("u_s_printstatus")
		If Not Order_Receipt_tracking.l_id.FldIsDetailKey Then Order_Receipt_tracking.l_id.FormValue = ObjForm.GetValue("x_l_id")
	End Function

	' -----------------------------------------------------------------
	' Restore form values
	'
	Function RestoreFormValues()
		Order_Receipt_tracking.OrderID.CurrentValue = Order_Receipt_tracking.OrderID.FormValue
		Order_Receipt_tracking.s_printtype.CurrentValue = Order_Receipt_tracking.s_printtype.FormValue
		Order_Receipt_tracking.s_filename.CurrentValue = Order_Receipt_tracking.s_filename.FormValue
		Order_Receipt_tracking.t_createdDate.CurrentValue = Order_Receipt_tracking.t_createdDate.FormValue
		Order_Receipt_tracking.t_createdDate.CurrentValue = ew_UnFormatDateTime(Order_Receipt_tracking.t_createdDate.CurrentValue, 9)
		Order_Receipt_tracking.IdBusinessDetail.CurrentValue = Order_Receipt_tracking.IdBusinessDetail.FormValue
		Order_Receipt_tracking.s_printstatus.CurrentValue = Order_Receipt_tracking.s_printstatus.FormValue
		Order_Receipt_tracking.l_id.CurrentValue = Order_Receipt_tracking.l_id.FormValue
	End Function

	' -----------------------------------------------------------------
	' Load recordset
	'
	Function LoadRecordset()

		' Load list page sql
		Dim sSql
		sSql = Order_Receipt_tracking.SelectSQL
		Call ew_SetDebugMsg("LoadRecordset: " & sSql) ' Show SQL for debugging

		' Load recordset
		Dim RsRecordset
		Set RsRecordset = ew_LoadRecordset(sSql)

		' Call Recordset Selected event
		Call Order_Receipt_tracking.Recordset_Selected(RsRecordset)
		Set LoadRecordset = RsRecordset
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
			Order_Receipt_tracking.t_createdDate.ViewValue = ew_FormatDateTime(Order_Receipt_tracking.t_createdDate.ViewValue, 9)
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

		' ----------
		'  Edit Row
		' ----------

		ElseIf Order_Receipt_tracking.RowType = EW_ROWTYPE_EDIT Then ' Edit row

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
			Order_Receipt_tracking.t_createdDate.EditValue = ew_FormatDateTime(Order_Receipt_tracking.t_createdDate.CurrentValue, 9)
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
		Dim lUpdateCnt
		lUpdateCnt = 0
		If Order_Receipt_tracking.OrderID.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If Order_Receipt_tracking.s_printtype.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If Order_Receipt_tracking.s_filename.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If Order_Receipt_tracking.t_createdDate.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If Order_Receipt_tracking.IdBusinessDetail.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If Order_Receipt_tracking.s_printstatus.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
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
		If Order_Receipt_tracking.OrderID.MultiUpdate <> "" Then
			If Not ew_CheckInteger(Order_Receipt_tracking.OrderID.FormValue) Then
				Call ew_AddMessage(gsFormError, Order_Receipt_tracking.OrderID.FldErrMsg)
			End If
		End If
		If Order_Receipt_tracking.t_createdDate.MultiUpdate <> "" Then
			If Not ew_CheckDate(Order_Receipt_tracking.t_createdDate.FormValue) Then
				Call ew_AddMessage(gsFormError, Order_Receipt_tracking.t_createdDate.FldErrMsg)
			End If
		End If
		If Order_Receipt_tracking.IdBusinessDetail.MultiUpdate <> "" Then
			If Not ew_CheckInteger(Order_Receipt_tracking.IdBusinessDetail.FormValue) Then
				Call ew_AddMessage(gsFormError, Order_Receipt_tracking.IdBusinessDetail.FldErrMsg)
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
		sFilter = Order_Receipt_tracking.KeyFilter
		Order_Receipt_tracking.CurrentFilter  = sFilter
		sSql = Order_Receipt_tracking.SQL
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

			' Field OrderID
			Call Order_Receipt_tracking.OrderID.SetDbValue(Rs, Order_Receipt_tracking.OrderID.CurrentValue, Null, Order_Receipt_tracking.OrderID.ReadOnly Or Order_Receipt_tracking.OrderID.MultiUpdate&"" <> "1")

			' Field s_printtype
			Call Order_Receipt_tracking.s_printtype.SetDbValue(Rs, Order_Receipt_tracking.s_printtype.CurrentValue, Null, Order_Receipt_tracking.s_printtype.ReadOnly Or Order_Receipt_tracking.s_printtype.MultiUpdate&"" <> "1")

			' Field s_filename
			Call Order_Receipt_tracking.s_filename.SetDbValue(Rs, Order_Receipt_tracking.s_filename.CurrentValue, Null, Order_Receipt_tracking.s_filename.ReadOnly Or Order_Receipt_tracking.s_filename.MultiUpdate&"" <> "1")

			' Field t_createdDate
			Call Order_Receipt_tracking.t_createdDate.SetDbValue(Rs, ew_UnFormatDateTime(Order_Receipt_tracking.t_createdDate.CurrentValue, 9), Null, Order_Receipt_tracking.t_createdDate.ReadOnly Or Order_Receipt_tracking.t_createdDate.MultiUpdate&"" <> "1")

			' Field IdBusinessDetail
			Call Order_Receipt_tracking.IdBusinessDetail.SetDbValue(Rs, Order_Receipt_tracking.IdBusinessDetail.CurrentValue, Null, Order_Receipt_tracking.IdBusinessDetail.ReadOnly Or Order_Receipt_tracking.IdBusinessDetail.MultiUpdate&"" <> "1")

			' Field s_printstatus
			Call Order_Receipt_tracking.s_printstatus.SetDbValue(Rs, Order_Receipt_tracking.s_printstatus.CurrentValue, Null, Order_Receipt_tracking.s_printstatus.ReadOnly Or Order_Receipt_tracking.s_printstatus.MultiUpdate&"" <> "1")

			' Check recordset update error
			If Err.Number <> 0 Then
				FailureMessage = Err.Description
				Rs.Close
				Set Rs = Nothing
				EditRow = False
				Exit Function
			End If

			' Call Row Updating event
			bUpdateRow = Order_Receipt_tracking.Row_Updating(RsOld, Rs)
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
				ElseIf Order_Receipt_tracking.CancelMessage <> "" Then
					FailureMessage = Order_Receipt_tracking.CancelMessage
					Order_Receipt_tracking.CancelMessage = ""
				Else
					FailureMessage = Language.Phrase("UpdateCancelled")
				End If
				EditRow = False
			End If
		End If

		' Call Row Updated event
		If EditRow Then
			Call Order_Receipt_tracking.Row_Updated(RsOld, RsNew)
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
		Call Breadcrumb.Add("list", Order_Receipt_tracking.TableVar, "Order_Receipt_trackinglist.asp", "", Order_Receipt_tracking.TableVar, True)
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
