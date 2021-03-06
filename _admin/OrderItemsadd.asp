﻿<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="OrderItemsinfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim OrderItems_add
Set OrderItems_add = New cOrderItems_add
Set Page = OrderItems_add

' Page init processing
OrderItems_add.Page_Init()

' Page main processing
OrderItems_add.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
OrderItems_add.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var OrderItems_add = new ew_Page("OrderItems_add");
OrderItems_add.PageID = "add"; // Page ID
var EW_PAGE_ID = OrderItems_add.PageID; // For backward compatibility
// Form object
var fOrderItemsadd = new ew_Form("fOrderItemsadd");
// Validate form
fOrderItemsadd.Validate = function() {
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
			elm = this.GetElements("x" + infix + "_OrderId");
			if (elm && !ew_CheckInteger(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(OrderItems.OrderId.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_MenuItemId");
			if (elm && !ew_CheckInteger(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(OrderItems.MenuItemId.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_MenuItemPropertyId");
			if (elm && !ew_CheckInteger(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(OrderItems.MenuItemPropertyId.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_Qta");
			if (elm && !ew_CheckInteger(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(OrderItems.Qta.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_Price");
			if (elm && !ew_CheckNumber(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(OrderItems.Price.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_Total");
			if (elm && !ew_CheckNumber(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(OrderItems.Total.FldErrMsg) %>");
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
fOrderItemsadd.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fOrderItemsadd.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fOrderItemsadd.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<div class="ewToolbar">
<% If OrderItems.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If OrderItems.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% OrderItems_add.ShowPageHeader() %>
<% OrderItems_add.ShowMessage %>
<form name="fOrderItemsadd" id="fOrderItemsadd" class="form-horizontal ewForm ewAddForm" action="<%= ew_CurrentPage() %>" method="post">
<% If OrderItems_add.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= OrderItems_add.Token %>">
<% End If %>
<input type="hidden" name="t" value="OrderItems">
<input type="hidden" name="a_add" id="a_add" value="A">
<div>
<% If OrderItems.OrderId.Visible Then ' OrderId %>
	<div id="r_OrderId" class="form-group">
		<label id="elh_OrderItems_OrderId" for="x_OrderId" class="col-sm-2 control-label ewLabel"><%= OrderItems.OrderId.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrderItems.OrderId.CellAttributes %>>
<span id="el_OrderItems_OrderId">
<input type="text" data-field="x_OrderId" name="x_OrderId" id="x_OrderId" size="30" placeholder="<%= OrderItems.OrderId.PlaceHolder %>" value="<%= OrderItems.OrderId.EditValue %>"<%= OrderItems.OrderId.EditAttributes %>>
</span>
<%= OrderItems.OrderId.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrderItems.MenuItemId.Visible Then ' MenuItemId %>
	<div id="r_MenuItemId" class="form-group">
		<label id="elh_OrderItems_MenuItemId" for="x_MenuItemId" class="col-sm-2 control-label ewLabel"><%= OrderItems.MenuItemId.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrderItems.MenuItemId.CellAttributes %>>
<span id="el_OrderItems_MenuItemId">
<input type="text" data-field="x_MenuItemId" name="x_MenuItemId" id="x_MenuItemId" size="30" placeholder="<%= OrderItems.MenuItemId.PlaceHolder %>" value="<%= OrderItems.MenuItemId.EditValue %>"<%= OrderItems.MenuItemId.EditAttributes %>>
</span>
<%= OrderItems.MenuItemId.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrderItems.MenuItemPropertyId.Visible Then ' MenuItemPropertyId %>
	<div id="r_MenuItemPropertyId" class="form-group">
		<label id="elh_OrderItems_MenuItemPropertyId" for="x_MenuItemPropertyId" class="col-sm-2 control-label ewLabel"><%= OrderItems.MenuItemPropertyId.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrderItems.MenuItemPropertyId.CellAttributes %>>
<span id="el_OrderItems_MenuItemPropertyId">
<input type="text" data-field="x_MenuItemPropertyId" name="x_MenuItemPropertyId" id="x_MenuItemPropertyId" size="30" placeholder="<%= OrderItems.MenuItemPropertyId.PlaceHolder %>" value="<%= OrderItems.MenuItemPropertyId.EditValue %>"<%= OrderItems.MenuItemPropertyId.EditAttributes %>>
</span>
<%= OrderItems.MenuItemPropertyId.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrderItems.Qta.Visible Then ' Qta %>
	<div id="r_Qta" class="form-group">
		<label id="elh_OrderItems_Qta" for="x_Qta" class="col-sm-2 control-label ewLabel"><%= OrderItems.Qta.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrderItems.Qta.CellAttributes %>>
<span id="el_OrderItems_Qta">
<input type="text" data-field="x_Qta" name="x_Qta" id="x_Qta" size="30" placeholder="<%= OrderItems.Qta.PlaceHolder %>" value="<%= OrderItems.Qta.EditValue %>"<%= OrderItems.Qta.EditAttributes %>>
</span>
<%= OrderItems.Qta.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrderItems.Price.Visible Then ' Price %>
	<div id="r_Price" class="form-group">
		<label id="elh_OrderItems_Price" for="x_Price" class="col-sm-2 control-label ewLabel"><%= OrderItems.Price.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrderItems.Price.CellAttributes %>>
<span id="el_OrderItems_Price">
<input type="text" data-field="x_Price" name="x_Price" id="x_Price" size="30" placeholder="<%= OrderItems.Price.PlaceHolder %>" value="<%= OrderItems.Price.EditValue %>"<%= OrderItems.Price.EditAttributes %>>
</span>
<%= OrderItems.Price.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrderItems.Total.Visible Then ' Total %>
	<div id="r_Total" class="form-group">
		<label id="elh_OrderItems_Total" for="x_Total" class="col-sm-2 control-label ewLabel"><%= OrderItems.Total.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrderItems.Total.CellAttributes %>>
<span id="el_OrderItems_Total">
<input type="text" data-field="x_Total" name="x_Total" id="x_Total" size="30" placeholder="<%= OrderItems.Total.PlaceHolder %>" value="<%= OrderItems.Total.EditValue %>"<%= OrderItems.Total.EditAttributes %>>
</span>
<%= OrderItems.Total.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrderItems.toppingids.Visible Then ' toppingids %>
	<div id="r_toppingids" class="form-group">
		<label id="elh_OrderItems_toppingids" for="x_toppingids" class="col-sm-2 control-label ewLabel"><%= OrderItems.toppingids.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrderItems.toppingids.CellAttributes %>>
<span id="el_OrderItems_toppingids">
<input type="text" data-field="x_toppingids" name="x_toppingids" id="x_toppingids" size="30" maxlength="255" placeholder="<%= OrderItems.toppingids.PlaceHolder %>" value="<%= OrderItems.toppingids.EditValue %>"<%= OrderItems.toppingids.EditAttributes %>>
</span>
<%= OrderItems.toppingids.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrderItems.dishpropertiesids.Visible Then ' dishpropertiesids %>
	<div id="r_dishpropertiesids" class="form-group">
		<label id="elh_OrderItems_dishpropertiesids" for="x_dishpropertiesids" class="col-sm-2 control-label ewLabel"><%= OrderItems.dishpropertiesids.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrderItems.dishpropertiesids.CellAttributes %>>
<span id="el_OrderItems_dishpropertiesids">
<input type="text" data-field="x_dishpropertiesids" name="x_dishpropertiesids" id="x_dishpropertiesids" size="30" maxlength="255" placeholder="<%= OrderItems.dishpropertiesids.PlaceHolder %>" value="<%= OrderItems.dishpropertiesids.EditValue %>"<%= OrderItems.dishpropertiesids.EditAttributes %>>
</span>
<%= OrderItems.dishpropertiesids.CustomMsg %></div></div>
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
fOrderItemsadd.Init();
</script>
<%
OrderItems_add.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set OrderItems_add = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cOrderItems_add

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
		TableName = "OrderItems"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "OrderItems_add"
	End Property

	' Page Name
	Public Property Get PageName()
		PageName = ew_CurrentPage()
	End Property

	' Page Url
	Public Property Get PageUrl()
		PageUrl = ew_CurrentPage() & "?"
		If OrderItems.UseTokenInUrl Then PageUrl = PageUrl & "t=" & OrderItems.TableVar & "&" ' add page token
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
		If OrderItems.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (OrderItems.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (OrderItems.TableVar = Request.QueryString("t"))
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
		If IsEmpty(OrderItems) Then Set OrderItems = New cOrderItems
		Set Table = OrderItems

		' Initialize urls
		' Initialize form object

		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "add"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "OrderItems"

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

		OrderItems.CurrentAction = ew_IIf(Request.QueryString("a").Count > 0, Request.QueryString("a") & "", ObjForm.GetValue("a_list") & "") ' Set up current action

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
			results = OrderItems.GetAutoFill(Request.Form("name"), Request.Form("q"))
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
		If Not OrderItems Is Nothing Then
			If OrderItems.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = OrderItems.TableVar
				If OrderItems.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf OrderItems.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf OrderItems.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf OrderItems.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set OrderItems = Nothing
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
			OrderItems.CurrentAction = ObjForm.GetValue("a_add") ' Get form action
			CopyRecord = LoadOldRecord() ' Load old recordset
			Call LoadFormValues() ' Load form values

		' Not post back
		Else

			' Load key values from QueryString
			CopyRecord = True
			If Request.QueryString("ID").Count > 0 Then
				OrderItems.ID.QueryStringValue = Request.QueryString("ID")
				Call OrderItems.SetKey("ID", OrderItems.ID.CurrentValue) ' Set up key
			Else
				Call OrderItems.SetKey("ID", "") ' Clear key
				CopyRecord = False
			End If
			If CopyRecord Then
				OrderItems.CurrentAction = "C" ' Copy Record
			Else
				OrderItems.CurrentAction = "I" ' Display Blank Record
				Call LoadDefaultValues() ' Load default values
			End If
		End If

		' Set up Breadcrumb
		SetupBreadcrumb()

		' Validate form if post back
		If ObjForm.GetValue("a_add")&"" <> "" Then
			If Not ValidateForm() Then
				OrderItems.CurrentAction = "I" ' Form error, reset action
				OrderItems.EventCancelled = True ' Event cancelled
				Call RestoreFormValues() ' Restore form values
				FailureMessage = gsFormError
			End If
		End If

		' Perform action based on action code
		Select Case OrderItems.CurrentAction
			Case "I" ' Blank record, no action required
			Case "C" ' Copy an existing record
				If Not LoadRow() Then ' Load record based on key
					If FailureMessage = "" Then FailureMessage = Language.Phrase("NoRecord") ' No record found
					Call Page_Terminate("OrderItemslist.asp") ' No matching record, return to list
				End If
			Case "A" ' Add new record
				OrderItems.SendEmail = True ' Send email on add success
				If AddRow(OldRecordset) Then ' Add successful
					If SuccessMessage = "" Then SuccessMessage = Language.Phrase("AddSuccess") ' Set up success message
					Dim sReturnUrl
					sReturnUrl = OrderItems.ReturnUrl
					If ew_GetPageName(sReturnUrl) = "OrderItemsview.asp" Then sReturnUrl = OrderItems.ViewUrl("") ' View paging, return to view page with keyurl directly
					Call Page_Terminate(sReturnUrl) ' Clean up and return
				Else
					OrderItems.EventCancelled = True ' Event cancelled
					Call RestoreFormValues() ' Add failed, restore form values
				End If
		End Select

		' Render row based on row type
		OrderItems.RowType = EW_ROWTYPE_ADD ' Render add type

		' Render row
		Call OrderItems.ResetAttrs()
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
		OrderItems.OrderId.CurrentValue = Null
		OrderItems.OrderId.OldValue = OrderItems.OrderId.CurrentValue
		OrderItems.MenuItemId.CurrentValue = Null
		OrderItems.MenuItemId.OldValue = OrderItems.MenuItemId.CurrentValue
		OrderItems.MenuItemPropertyId.CurrentValue = Null
		OrderItems.MenuItemPropertyId.OldValue = OrderItems.MenuItemPropertyId.CurrentValue
		OrderItems.Qta.CurrentValue = Null
		OrderItems.Qta.OldValue = OrderItems.Qta.CurrentValue
		OrderItems.Price.CurrentValue = Null
		OrderItems.Price.OldValue = OrderItems.Price.CurrentValue
		OrderItems.Total.CurrentValue = Null
		OrderItems.Total.OldValue = OrderItems.Total.CurrentValue
		OrderItems.toppingids.CurrentValue = Null
		OrderItems.toppingids.OldValue = OrderItems.toppingids.CurrentValue
		OrderItems.dishpropertiesids.CurrentValue = Null
		OrderItems.dishpropertiesids.OldValue = OrderItems.dishpropertiesids.CurrentValue
	End Function

	' -----------------------------------------------------------------
	' Load form values
	'
	Function LoadFormValues()

		' Load values from form
		If Not OrderItems.OrderId.FldIsDetailKey Then OrderItems.OrderId.FormValue = ObjForm.GetValue("x_OrderId")
		If Not OrderItems.MenuItemId.FldIsDetailKey Then OrderItems.MenuItemId.FormValue = ObjForm.GetValue("x_MenuItemId")
		If Not OrderItems.MenuItemPropertyId.FldIsDetailKey Then OrderItems.MenuItemPropertyId.FormValue = ObjForm.GetValue("x_MenuItemPropertyId")
		If Not OrderItems.Qta.FldIsDetailKey Then OrderItems.Qta.FormValue = ObjForm.GetValue("x_Qta")
		If Not OrderItems.Price.FldIsDetailKey Then OrderItems.Price.FormValue = ObjForm.GetValue("x_Price")
		If Not OrderItems.Total.FldIsDetailKey Then OrderItems.Total.FormValue = ObjForm.GetValue("x_Total")
		If Not OrderItems.toppingids.FldIsDetailKey Then OrderItems.toppingids.FormValue = ObjForm.GetValue("x_toppingids")
		If Not OrderItems.dishpropertiesids.FldIsDetailKey Then OrderItems.dishpropertiesids.FormValue = ObjForm.GetValue("x_dishpropertiesids")
	End Function

	' -----------------------------------------------------------------
	' Restore form values
	'
	Function RestoreFormValues()
		Call LoadOldRecord()
		OrderItems.OrderId.CurrentValue = OrderItems.OrderId.FormValue
		OrderItems.MenuItemId.CurrentValue = OrderItems.MenuItemId.FormValue
		OrderItems.MenuItemPropertyId.CurrentValue = OrderItems.MenuItemPropertyId.FormValue
		OrderItems.Qta.CurrentValue = OrderItems.Qta.FormValue
		OrderItems.Price.CurrentValue = OrderItems.Price.FormValue
		OrderItems.Total.CurrentValue = OrderItems.Total.FormValue
		OrderItems.toppingids.CurrentValue = OrderItems.toppingids.FormValue
		OrderItems.dishpropertiesids.CurrentValue = OrderItems.dishpropertiesids.FormValue
	End Function

	' -----------------------------------------------------------------
	' Load row based on key values
	'
	Function LoadRow()
		Dim RsRow, sSql, sFilter
		sFilter = OrderItems.KeyFilter

		' Call Row Selecting event
		Call OrderItems.Row_Selecting(sFilter)

		' Load sql based on filter
		OrderItems.CurrentFilter = sFilter
		sSql = OrderItems.SQL
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
		Call OrderItems.Row_Selected(RsRow)
		OrderItems.ID.DbValue = RsRow("ID")
		OrderItems.OrderId.DbValue = RsRow("OrderId")
		OrderItems.MenuItemId.DbValue = RsRow("MenuItemId")
		OrderItems.MenuItemPropertyId.DbValue = RsRow("MenuItemPropertyId")
		OrderItems.Qta.DbValue = RsRow("Qta")
		OrderItems.Price.DbValue = ew_Conv(RsRow("Price"), 131)
		OrderItems.Total.DbValue = ew_Conv(RsRow("Total"), 131)
		OrderItems.toppingids.DbValue = RsRow("toppingids")
		OrderItems.dishpropertiesids.DbValue = RsRow("dishpropertiesids")
	End Sub

	' Load DbValue from recordset
	Sub LoadDbValues(Rs)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		If Rs.Eof Then Exit Sub
		OrderItems.ID.m_DbValue = Rs("ID")
		OrderItems.OrderId.m_DbValue = Rs("OrderId")
		OrderItems.MenuItemId.m_DbValue = Rs("MenuItemId")
		OrderItems.MenuItemPropertyId.m_DbValue = Rs("MenuItemPropertyId")
		OrderItems.Qta.m_DbValue = Rs("Qta")
		OrderItems.Price.m_DbValue = ew_Conv(Rs("Price"), 131)
		OrderItems.Total.m_DbValue = ew_Conv(Rs("Total"), 131)
		OrderItems.toppingids.m_DbValue = Rs("toppingids")
		OrderItems.dishpropertiesids.m_DbValue = Rs("dishpropertiesids")
	End Sub

	' Load old record
	Function LoadOldRecord()

		' Load key values from Session
		Dim bValidKey
		bValidKey = True
		If OrderItems.GetKey("ID")&"" <> "" Then
			OrderItems.ID.CurrentValue = OrderItems.GetKey("ID") ' ID
		Else
			bValidKey = False
		End If

		' Load old recordset
		If bValidKey Then
			OrderItems.CurrentFilter = OrderItems.KeyFilter
			Dim sSql
			sSql = OrderItems.SQL
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

		If OrderItems.Price.CurrentValue & "" <> "" Then OrderItems.Price.CurrentValue = ew_Conv(OrderItems.Price.CurrentValue, OrderItems.Price.FldType)
		If OrderItems.Price.FormValue = OrderItems.Price.CurrentValue And IsNumeric(OrderItems.Price.CurrentValue) Then
			OrderItems.Price.CurrentValue = ew_StrToFloat(OrderItems.Price.CurrentValue)
		End If

		' Convert decimal values if posted back
		If OrderItems.Total.CurrentValue & "" <> "" Then OrderItems.Total.CurrentValue = ew_Conv(OrderItems.Total.CurrentValue, OrderItems.Total.FldType)
		If OrderItems.Total.FormValue = OrderItems.Total.CurrentValue And IsNumeric(OrderItems.Total.CurrentValue) Then
			OrderItems.Total.CurrentValue = ew_StrToFloat(OrderItems.Total.CurrentValue)
		End If

		' Call Row Rendering event
		Call OrderItems.Row_Rendering()

		' ---------------------------------------
		'  Common render codes for all row types
		' ---------------------------------------
		' ID
		' OrderId
		' MenuItemId
		' MenuItemPropertyId
		' Qta
		' Price
		' Total
		' toppingids
		' dishpropertiesids
		' -----------
		'  View  Row
		' -----------

		If OrderItems.RowType = EW_ROWTYPE_VIEW Then ' View row

			' ID
			OrderItems.ID.ViewValue = OrderItems.ID.CurrentValue
			OrderItems.ID.ViewCustomAttributes = ""

			' OrderId
			OrderItems.OrderId.ViewValue = OrderItems.OrderId.CurrentValue
			OrderItems.OrderId.ViewCustomAttributes = ""

			' MenuItemId
			OrderItems.MenuItemId.ViewValue = OrderItems.MenuItemId.CurrentValue
			OrderItems.MenuItemId.ViewCustomAttributes = ""

			' MenuItemPropertyId
			OrderItems.MenuItemPropertyId.ViewValue = OrderItems.MenuItemPropertyId.CurrentValue
			OrderItems.MenuItemPropertyId.ViewCustomAttributes = ""

			' Qta
			OrderItems.Qta.ViewValue = OrderItems.Qta.CurrentValue
			OrderItems.Qta.ViewCustomAttributes = ""

			' Price
			OrderItems.Price.ViewValue = OrderItems.Price.CurrentValue
			OrderItems.Price.ViewCustomAttributes = ""

			' Total
			OrderItems.Total.ViewValue = OrderItems.Total.CurrentValue
			OrderItems.Total.ViewCustomAttributes = ""

			' toppingids
			OrderItems.toppingids.ViewValue = OrderItems.toppingids.CurrentValue
			OrderItems.toppingids.ViewCustomAttributes = ""

			' dishpropertiesids
			OrderItems.dishpropertiesids.ViewValue = OrderItems.dishpropertiesids.CurrentValue
			OrderItems.dishpropertiesids.ViewCustomAttributes = ""

			' View refer script
			' OrderId

			OrderItems.OrderId.LinkCustomAttributes = ""
			OrderItems.OrderId.HrefValue = ""
			OrderItems.OrderId.TooltipValue = ""

			' MenuItemId
			OrderItems.MenuItemId.LinkCustomAttributes = ""
			OrderItems.MenuItemId.HrefValue = ""
			OrderItems.MenuItemId.TooltipValue = ""

			' MenuItemPropertyId
			OrderItems.MenuItemPropertyId.LinkCustomAttributes = ""
			OrderItems.MenuItemPropertyId.HrefValue = ""
			OrderItems.MenuItemPropertyId.TooltipValue = ""

			' Qta
			OrderItems.Qta.LinkCustomAttributes = ""
			OrderItems.Qta.HrefValue = ""
			OrderItems.Qta.TooltipValue = ""

			' Price
			OrderItems.Price.LinkCustomAttributes = ""
			OrderItems.Price.HrefValue = ""
			OrderItems.Price.TooltipValue = ""

			' Total
			OrderItems.Total.LinkCustomAttributes = ""
			OrderItems.Total.HrefValue = ""
			OrderItems.Total.TooltipValue = ""

			' toppingids
			OrderItems.toppingids.LinkCustomAttributes = ""
			OrderItems.toppingids.HrefValue = ""
			OrderItems.toppingids.TooltipValue = ""

			' dishpropertiesids
			OrderItems.dishpropertiesids.LinkCustomAttributes = ""
			OrderItems.dishpropertiesids.HrefValue = ""
			OrderItems.dishpropertiesids.TooltipValue = ""

		' ---------
		'  Add Row
		' ---------

		ElseIf OrderItems.RowType = EW_ROWTYPE_ADD Then ' Add row

			' OrderId
			OrderItems.OrderId.EditAttrs.UpdateAttribute "class", "form-control"
			OrderItems.OrderId.EditCustomAttributes = ""
			OrderItems.OrderId.EditValue = ew_HtmlEncode(OrderItems.OrderId.CurrentValue)
			OrderItems.OrderId.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrderItems.OrderId.FldCaption))

			' MenuItemId
			OrderItems.MenuItemId.EditAttrs.UpdateAttribute "class", "form-control"
			OrderItems.MenuItemId.EditCustomAttributes = ""
			OrderItems.MenuItemId.EditValue = ew_HtmlEncode(OrderItems.MenuItemId.CurrentValue)
			OrderItems.MenuItemId.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrderItems.MenuItemId.FldCaption))

			' MenuItemPropertyId
			OrderItems.MenuItemPropertyId.EditAttrs.UpdateAttribute "class", "form-control"
			OrderItems.MenuItemPropertyId.EditCustomAttributes = ""
			OrderItems.MenuItemPropertyId.EditValue = ew_HtmlEncode(OrderItems.MenuItemPropertyId.CurrentValue)
			OrderItems.MenuItemPropertyId.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrderItems.MenuItemPropertyId.FldCaption))

			' Qta
			OrderItems.Qta.EditAttrs.UpdateAttribute "class", "form-control"
			OrderItems.Qta.EditCustomAttributes = ""
			OrderItems.Qta.EditValue = ew_HtmlEncode(OrderItems.Qta.CurrentValue)
			OrderItems.Qta.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrderItems.Qta.FldCaption))

			' Price
			OrderItems.Price.EditAttrs.UpdateAttribute "class", "form-control"
			OrderItems.Price.EditCustomAttributes = ""
			OrderItems.Price.EditValue = ew_HtmlEncode(OrderItems.Price.CurrentValue)
			OrderItems.Price.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrderItems.Price.FldCaption))
			If OrderItems.Price.EditValue&"" <> "" And IsNumeric(OrderItems.Price.EditValue) Then OrderItems.Price.EditValue = ew_FormatNumber2(OrderItems.Price.EditValue, -2)

			' Total
			OrderItems.Total.EditAttrs.UpdateAttribute "class", "form-control"
			OrderItems.Total.EditCustomAttributes = ""
			OrderItems.Total.EditValue = ew_HtmlEncode(OrderItems.Total.CurrentValue)
			OrderItems.Total.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrderItems.Total.FldCaption))
			If OrderItems.Total.EditValue&"" <> "" And IsNumeric(OrderItems.Total.EditValue) Then OrderItems.Total.EditValue = ew_FormatNumber2(OrderItems.Total.EditValue, -2)

			' toppingids
			OrderItems.toppingids.EditAttrs.UpdateAttribute "class", "form-control"
			OrderItems.toppingids.EditCustomAttributes = ""
			OrderItems.toppingids.EditValue = ew_HtmlEncode(OrderItems.toppingids.CurrentValue)
			OrderItems.toppingids.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrderItems.toppingids.FldCaption))

			' dishpropertiesids
			OrderItems.dishpropertiesids.EditAttrs.UpdateAttribute "class", "form-control"
			OrderItems.dishpropertiesids.EditCustomAttributes = ""
			OrderItems.dishpropertiesids.EditValue = ew_HtmlEncode(OrderItems.dishpropertiesids.CurrentValue)
			OrderItems.dishpropertiesids.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrderItems.dishpropertiesids.FldCaption))

			' Edit refer script
			' OrderId

			OrderItems.OrderId.HrefValue = ""

			' MenuItemId
			OrderItems.MenuItemId.HrefValue = ""

			' MenuItemPropertyId
			OrderItems.MenuItemPropertyId.HrefValue = ""

			' Qta
			OrderItems.Qta.HrefValue = ""

			' Price
			OrderItems.Price.HrefValue = ""

			' Total
			OrderItems.Total.HrefValue = ""

			' toppingids
			OrderItems.toppingids.HrefValue = ""

			' dishpropertiesids
			OrderItems.dishpropertiesids.HrefValue = ""
		End If
		If OrderItems.RowType = EW_ROWTYPE_ADD Or OrderItems.RowType = EW_ROWTYPE_EDIT Or OrderItems.RowType = EW_ROWTYPE_SEARCH Then ' Add / Edit / Search row
			Call OrderItems.SetupFieldTitles()
		End If

		' Call Row Rendered event
		If OrderItems.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call OrderItems.Row_Rendered()
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
		If Not ew_CheckInteger(OrderItems.OrderId.FormValue) Then
			Call ew_AddMessage(gsFormError, OrderItems.OrderId.FldErrMsg)
		End If
		If Not ew_CheckInteger(OrderItems.MenuItemId.FormValue) Then
			Call ew_AddMessage(gsFormError, OrderItems.MenuItemId.FldErrMsg)
		End If
		If Not ew_CheckInteger(OrderItems.MenuItemPropertyId.FormValue) Then
			Call ew_AddMessage(gsFormError, OrderItems.MenuItemPropertyId.FldErrMsg)
		End If
		If Not ew_CheckInteger(OrderItems.Qta.FormValue) Then
			Call ew_AddMessage(gsFormError, OrderItems.Qta.FldErrMsg)
		End If
		If Not ew_CheckNumber(OrderItems.Price.FormValue) Then
			Call ew_AddMessage(gsFormError, OrderItems.Price.FldErrMsg)
		End If
		If Not ew_CheckNumber(OrderItems.Total.FormValue) Then
			Call ew_AddMessage(gsFormError, OrderItems.Total.FldErrMsg)
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
		OrderItems.CurrentFilter = sFilter
		sSql = OrderItems.SQL
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

		' Field OrderId
		Call OrderItems.OrderId.SetDbValue(Rs, OrderItems.OrderId.CurrentValue, Null, False)

		' Field MenuItemId
		Call OrderItems.MenuItemId.SetDbValue(Rs, OrderItems.MenuItemId.CurrentValue, Null, False)

		' Field MenuItemPropertyId
		Call OrderItems.MenuItemPropertyId.SetDbValue(Rs, OrderItems.MenuItemPropertyId.CurrentValue, Null, False)

		' Field Qta
		Call OrderItems.Qta.SetDbValue(Rs, OrderItems.Qta.CurrentValue, Null, False)

		' Field Price
		Call OrderItems.Price.SetDbValue(Rs, OrderItems.Price.CurrentValue, Null, False)

		' Field Total
		Call OrderItems.Total.SetDbValue(Rs, OrderItems.Total.CurrentValue, Null, False)

		' Field toppingids
		Call OrderItems.toppingids.SetDbValue(Rs, OrderItems.toppingids.CurrentValue, Null, False)

		' Field dishpropertiesids
		Call OrderItems.dishpropertiesids.SetDbValue(Rs, OrderItems.dishpropertiesids.CurrentValue, Null, False)

		' Check recordset update error
		If Err.Number <> 0 Then
			FailureMessage = Err.Description
			Rs.Close
			Set Rs = Nothing
			AddRow = False
			Exit Function
		End If

		' Call Row Inserting event
		bInsertRow = OrderItems.Row_Inserting(RsOld, Rs)
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
			ElseIf OrderItems.CancelMessage <> "" Then
				FailureMessage = OrderItems.CancelMessage
				OrderItems.CancelMessage = ""
			Else
				FailureMessage = Language.Phrase("InsertCancelled")
			End If
			AddRow = False
		End If
		Rs.Close
		Set Rs = Nothing
		If AddRow Then
			OrderItems.ID.DbValue = RsNew("ID")
		End If
		If AddRow Then

			' Call Row Inserted event
			Call OrderItems.Row_Inserted(RsOld, RsNew)
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
		Call Breadcrumb.Add("list", OrderItems.TableVar, "OrderItemslist.asp", "", OrderItems.TableVar, True)
		PageId = ew_IIf(OrderItems.CurrentAction = "C", "Copy", "Add")
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
