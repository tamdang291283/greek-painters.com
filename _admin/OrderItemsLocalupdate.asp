<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="OrderItemsLocalinfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim OrderItemsLocal_update
Set OrderItemsLocal_update = New cOrderItemsLocal_update
Set Page = OrderItemsLocal_update

' Page init processing
OrderItemsLocal_update.Page_Init()

' Page main processing
OrderItemsLocal_update.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
OrderItemsLocal_update.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var OrderItemsLocal_update = new ew_Page("OrderItemsLocal_update");
OrderItemsLocal_update.PageID = "update"; // Page ID
var EW_PAGE_ID = OrderItemsLocal_update.PageID; // For backward compatibility
// Form object
var fOrderItemsLocalupdate = new ew_Form("fOrderItemsLocalupdate");
// Validate form
fOrderItemsLocalupdate.Validate = function() {
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
			elm = this.GetElements("x" + infix + "_OrderId");
			uelm = this.GetElements("u" + infix + "_OrderId");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(OrderItemsLocal.OrderId.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_MenuItemId");
			uelm = this.GetElements("u" + infix + "_MenuItemId");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(OrderItemsLocal.MenuItemId.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_MenuItemPropertyId");
			uelm = this.GetElements("u" + infix + "_MenuItemPropertyId");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(OrderItemsLocal.MenuItemPropertyId.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_Qta");
			uelm = this.GetElements("u" + infix + "_Qta");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(OrderItemsLocal.Qta.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_Price");
			uelm = this.GetElements("u" + infix + "_Price");
			if (uelm && uelm.checked && elm && !ew_CheckNumber(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(OrderItemsLocal.Price.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_Total");
			uelm = this.GetElements("u" + infix + "_Total");
			if (uelm && uelm.checked && elm && !ew_CheckNumber(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(OrderItemsLocal.Total.FldErrMsg) %>");
			// Set up row object
			ew_ElementsToRow(fobj);
			// Fire Form_CustomValidate event
			if (!this.Form_CustomValidate(fobj))
				return false;
	}
	return true;
}
// Form_CustomValidate event
fOrderItemsLocalupdate.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fOrderItemsLocalupdate.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fOrderItemsLocalupdate.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<div class="ewToolbar">
<% If OrderItemsLocal.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If OrderItemsLocal.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% OrderItemsLocal_update.ShowPageHeader() %>
<% OrderItemsLocal_update.ShowMessage %>
<form name="fOrderItemsLocalupdate" id="fOrderItemsLocalupdate" class="form-horizontal ewForm ewUpdateForm" action="<%= ew_CurrentPage %>" method="post">
<% If OrderItemsLocal_update.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= OrderItemsLocal_update.Token %>">
<% End If %>
<input type="hidden" name="t" value="OrderItemsLocal">
<input type="hidden" name="a_update" id="a_update" value="U">
<% For i = 0 to UBound(OrderItemsLocal_update.RecKeys) %>
<input type="hidden" name="key_m" id="key_m" value="<%= ew_HtmlEncode(ew_GetKeyValue(OrderItemsLocal_update.RecKeys(i))) %>">
<% Next %>
<div id="tbl_OrderItemsLocalupdate">
	<div class="form-group">
		<label class="col-sm-2"><input type="checkbox" name="u" id="u" onclick="ew_SelectAll(this);"> <%= Language.Phrase("UpdateSelectAll") %></label>
	</div>
<% If OrderItemsLocal.OrderId.Visible Then ' OrderId %>
	<div id="r_OrderId" class="form-group">
		<label for="x_OrderId" class="col-sm-2 control-label">
<input type="checkbox" name="u_OrderId" id="u_OrderId" value="1"<% If OrderItemsLocal.OrderId.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrderItemsLocal.OrderId.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrderItemsLocal.OrderId.CellAttributes %>>
<span id="el_OrderItemsLocal_OrderId">
<input type="text" data-field="x_OrderId" name="x_OrderId" id="x_OrderId" size="30" placeholder="<%= OrderItemsLocal.OrderId.PlaceHolder %>" value="<%= OrderItemsLocal.OrderId.EditValue %>"<%= OrderItemsLocal.OrderId.EditAttributes %>>
</span>
<%= OrderItemsLocal.OrderId.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrderItemsLocal.MenuItemId.Visible Then ' MenuItemId %>
	<div id="r_MenuItemId" class="form-group">
		<label for="x_MenuItemId" class="col-sm-2 control-label">
<input type="checkbox" name="u_MenuItemId" id="u_MenuItemId" value="1"<% If OrderItemsLocal.MenuItemId.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrderItemsLocal.MenuItemId.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrderItemsLocal.MenuItemId.CellAttributes %>>
<span id="el_OrderItemsLocal_MenuItemId">
<input type="text" data-field="x_MenuItemId" name="x_MenuItemId" id="x_MenuItemId" size="30" placeholder="<%= OrderItemsLocal.MenuItemId.PlaceHolder %>" value="<%= OrderItemsLocal.MenuItemId.EditValue %>"<%= OrderItemsLocal.MenuItemId.EditAttributes %>>
</span>
<%= OrderItemsLocal.MenuItemId.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrderItemsLocal.MenuItemPropertyId.Visible Then ' MenuItemPropertyId %>
	<div id="r_MenuItemPropertyId" class="form-group">
		<label for="x_MenuItemPropertyId" class="col-sm-2 control-label">
<input type="checkbox" name="u_MenuItemPropertyId" id="u_MenuItemPropertyId" value="1"<% If OrderItemsLocal.MenuItemPropertyId.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrderItemsLocal.MenuItemPropertyId.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrderItemsLocal.MenuItemPropertyId.CellAttributes %>>
<span id="el_OrderItemsLocal_MenuItemPropertyId">
<input type="text" data-field="x_MenuItemPropertyId" name="x_MenuItemPropertyId" id="x_MenuItemPropertyId" size="30" placeholder="<%= OrderItemsLocal.MenuItemPropertyId.PlaceHolder %>" value="<%= OrderItemsLocal.MenuItemPropertyId.EditValue %>"<%= OrderItemsLocal.MenuItemPropertyId.EditAttributes %>>
</span>
<%= OrderItemsLocal.MenuItemPropertyId.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrderItemsLocal.Qta.Visible Then ' Qta %>
	<div id="r_Qta" class="form-group">
		<label for="x_Qta" class="col-sm-2 control-label">
<input type="checkbox" name="u_Qta" id="u_Qta" value="1"<% If OrderItemsLocal.Qta.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrderItemsLocal.Qta.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrderItemsLocal.Qta.CellAttributes %>>
<span id="el_OrderItemsLocal_Qta">
<input type="text" data-field="x_Qta" name="x_Qta" id="x_Qta" size="30" placeholder="<%= OrderItemsLocal.Qta.PlaceHolder %>" value="<%= OrderItemsLocal.Qta.EditValue %>"<%= OrderItemsLocal.Qta.EditAttributes %>>
</span>
<%= OrderItemsLocal.Qta.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrderItemsLocal.Price.Visible Then ' Price %>
	<div id="r_Price" class="form-group">
		<label for="x_Price" class="col-sm-2 control-label">
<input type="checkbox" name="u_Price" id="u_Price" value="1"<% If OrderItemsLocal.Price.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrderItemsLocal.Price.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrderItemsLocal.Price.CellAttributes %>>
<span id="el_OrderItemsLocal_Price">
<input type="text" data-field="x_Price" name="x_Price" id="x_Price" size="30" placeholder="<%= OrderItemsLocal.Price.PlaceHolder %>" value="<%= OrderItemsLocal.Price.EditValue %>"<%= OrderItemsLocal.Price.EditAttributes %>>
</span>
<%= OrderItemsLocal.Price.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrderItemsLocal.Total.Visible Then ' Total %>
	<div id="r_Total" class="form-group">
		<label for="x_Total" class="col-sm-2 control-label">
<input type="checkbox" name="u_Total" id="u_Total" value="1"<% If OrderItemsLocal.Total.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrderItemsLocal.Total.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrderItemsLocal.Total.CellAttributes %>>
<span id="el_OrderItemsLocal_Total">
<input type="text" data-field="x_Total" name="x_Total" id="x_Total" size="30" placeholder="<%= OrderItemsLocal.Total.PlaceHolder %>" value="<%= OrderItemsLocal.Total.EditValue %>"<%= OrderItemsLocal.Total.EditAttributes %>>
</span>
<%= OrderItemsLocal.Total.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrderItemsLocal.toppingids.Visible Then ' toppingids %>
	<div id="r_toppingids" class="form-group">
		<label for="x_toppingids" class="col-sm-2 control-label">
<input type="checkbox" name="u_toppingids" id="u_toppingids" value="1"<% If OrderItemsLocal.toppingids.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrderItemsLocal.toppingids.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrderItemsLocal.toppingids.CellAttributes %>>
<span id="el_OrderItemsLocal_toppingids">
<input type="text" data-field="x_toppingids" name="x_toppingids" id="x_toppingids" size="30" maxlength="255" placeholder="<%= OrderItemsLocal.toppingids.PlaceHolder %>" value="<%= OrderItemsLocal.toppingids.EditValue %>"<%= OrderItemsLocal.toppingids.EditAttributes %>>
</span>
<%= OrderItemsLocal.toppingids.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrderItemsLocal.dishpropertiesids.Visible Then ' dishpropertiesids %>
	<div id="r_dishpropertiesids" class="form-group">
		<label for="x_dishpropertiesids" class="col-sm-2 control-label">
<input type="checkbox" name="u_dishpropertiesids" id="u_dishpropertiesids" value="1"<% If OrderItemsLocal.dishpropertiesids.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrderItemsLocal.dishpropertiesids.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrderItemsLocal.dishpropertiesids.CellAttributes %>>
<span id="el_OrderItemsLocal_dishpropertiesids">
<input type="text" data-field="x_dishpropertiesids" name="x_dishpropertiesids" id="x_dishpropertiesids" size="30" maxlength="255" placeholder="<%= OrderItemsLocal.dishpropertiesids.PlaceHolder %>" value="<%= OrderItemsLocal.dishpropertiesids.EditValue %>"<%= OrderItemsLocal.dishpropertiesids.EditAttributes %>>
</span>
<%= OrderItemsLocal.dishpropertiesids.CustomMsg %></div></div>
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
fOrderItemsLocalupdate.Init();
</script>
<%
OrderItemsLocal_update.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set OrderItemsLocal_update = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cOrderItemsLocal_update

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
		TableName = "OrderItemsLocal"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "OrderItemsLocal_update"
	End Property

	' Page Name
	Public Property Get PageName()
		PageName = ew_CurrentPage()
	End Property

	' Page Url
	Public Property Get PageUrl()
		PageUrl = ew_CurrentPage() & "?"
		If OrderItemsLocal.UseTokenInUrl Then PageUrl = PageUrl & "t=" & OrderItemsLocal.TableVar & "&" ' add page token
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
		If OrderItemsLocal.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (OrderItemsLocal.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (OrderItemsLocal.TableVar = Request.QueryString("t"))
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
		If IsEmpty(OrderItemsLocal) Then Set OrderItemsLocal = New cOrderItemsLocal
		Set Table = OrderItemsLocal

		' Initialize urls
		' Initialize form object

		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "update"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "OrderItemsLocal"

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

		OrderItemsLocal.CurrentAction = ew_IIf(Request.QueryString("a").Count > 0, Request.QueryString("a") & "", ObjForm.GetValue("a_list") & "") ' Set up current action

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
			results = OrderItemsLocal.GetAutoFill(Request.Form("name"), Request.Form("q"))
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
		If Not OrderItemsLocal Is Nothing Then
			If OrderItemsLocal.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = OrderItemsLocal.TableVar
				If OrderItemsLocal.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf OrderItemsLocal.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf OrderItemsLocal.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf OrderItemsLocal.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set OrderItemsLocal = Nothing
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
		RecKeys = OrderItemsLocal.GetRecordKeys() ' Load record keys
		If ObjForm.GetValue("a_update")&"" <> "" Then

			' Get action
			OrderItemsLocal.CurrentAction = ObjForm.GetValue("a_update")
			Call LoadFormValues() ' Get form values

			' Validate form
			If Not ValidateForm() Then
				OrderItemsLocal.CurrentAction = "I" ' Form error, reset action
				FailureMessage = gsFormError
			End If
		Else
			Call LoadMultiUpdateValues() ' Load initial values to form
		End If
		If Not IsArray(RecKeys) Then
			Call Page_Terminate("OrderItemsLocallist.asp") ' No records selected, return to list
		End If
		Select Case OrderItemsLocal.CurrentAction
			Case "U" ' Update
				If UpdateRows() Then ' Update Records based on key
					If SuccessMessage = "" Then SuccessMessage = Language.Phrase("UpdateSuccess") ' Set update success message
					Call Page_Terminate(OrderItemsLocal.ReturnUrl) ' Return to caller
				Else
					Call RestoreFormValues() ' Restore form values
				End If
		End Select

		' Render row
		OrderItemsLocal.RowType = EW_ROWTYPE_EDIT ' Render edit

		' Render row
		Call OrderItemsLocal.ResetAttrs()
		Call RenderRow()
	End Sub

	' -----------------------------------------------------------------
	' Load initial values to form if field values are identical in all selected records
	'
	Sub LoadMultiUpdateValues()
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		Dim Rs, i, OldValue, NewValue
		OrderItemsLocal.CurrentFilter = OrderItemsLocal.GetKeyFilter()

		' Load recordset
		Set Rs = LoadRecordset()
		i = 1
		Do While Not Rs.Eof
			If i = 1 Then
				OrderItemsLocal.OrderId.DbValue = ew_Conv(Rs("OrderId"), Rs("OrderId").Type)
				OrderItemsLocal.MenuItemId.DbValue = ew_Conv(Rs("MenuItemId"), Rs("MenuItemId").Type)
				OrderItemsLocal.MenuItemPropertyId.DbValue = ew_Conv(Rs("MenuItemPropertyId"), Rs("MenuItemPropertyId").Type)
				OrderItemsLocal.Qta.DbValue = ew_Conv(Rs("Qta"), Rs("Qta").Type)
				OrderItemsLocal.Price.DbValue = ew_Conv(Rs("Price"), Rs("Price").Type)
				OrderItemsLocal.Total.DbValue = ew_Conv(Rs("Total"), Rs("Total").Type)
				OrderItemsLocal.toppingids.DbValue = ew_Conv(Rs("toppingids"), Rs("toppingids").Type)
				OrderItemsLocal.dishpropertiesids.DbValue = ew_Conv(Rs("dishpropertiesids"), Rs("dishpropertiesids").Type)
			Else
				OldValue = OrderItemsLocal.OrderId.DbValue
				NewValue = ew_Conv(Rs("OrderId"), Rs("OrderId").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrderItemsLocal.OrderId.CurrentValue = Null
				End If
				OldValue = OrderItemsLocal.MenuItemId.DbValue
				NewValue = ew_Conv(Rs("MenuItemId"), Rs("MenuItemId").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrderItemsLocal.MenuItemId.CurrentValue = Null
				End If
				OldValue = OrderItemsLocal.MenuItemPropertyId.DbValue
				NewValue = ew_Conv(Rs("MenuItemPropertyId"), Rs("MenuItemPropertyId").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrderItemsLocal.MenuItemPropertyId.CurrentValue = Null
				End If
				OldValue = OrderItemsLocal.Qta.DbValue
				NewValue = ew_Conv(Rs("Qta"), Rs("Qta").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrderItemsLocal.Qta.CurrentValue = Null
				End If
				OldValue = OrderItemsLocal.Price.DbValue
				NewValue = ew_Conv(Rs("Price"), Rs("Price").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrderItemsLocal.Price.CurrentValue = Null
				End If
				OldValue = OrderItemsLocal.Total.DbValue
				NewValue = ew_Conv(Rs("Total"), Rs("Total").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrderItemsLocal.Total.CurrentValue = Null
				End If
				OldValue = OrderItemsLocal.toppingids.DbValue
				NewValue = ew_Conv(Rs("toppingids"), Rs("toppingids").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrderItemsLocal.toppingids.CurrentValue = Null
				End If
				OldValue = OrderItemsLocal.dishpropertiesids.DbValue
				NewValue = ew_Conv(Rs("dishpropertiesids"), Rs("dishpropertiesids").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrderItemsLocal.dishpropertiesids.CurrentValue = Null
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
		OrderItemsLocal.ID.CurrentValue = sKeyFld ' Set up key value
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
		OrderItemsLocal.CurrentFilter = OrderItemsLocal.GetKeyFilter()
		sSql = OrderItemsLocal.SQL
		Set Rs = Server.CreateObject("ADODB.Recordset")
		Rs.CursorLocation = EW_CURSORLOCATION
		Rs.Open sSql, Conn, 1, EW_RECORDSET_LOCKTYPE
		Set RsOld = ew_CloneRs(Rs)

		' Update all rows
		sKey = ""
		For i = 0 to UBound(RecKeys)
			If SetupKeyValues(RecKeys(i)) Then
				sThisKey = RecKeys(i)
				OrderItemsLocal.SendEmail = False ' Do not send email on update success
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
		If Not OrderItemsLocal.OrderId.FldIsDetailKey Then OrderItemsLocal.OrderId.FormValue = ObjForm.GetValue("x_OrderId")
		OrderItemsLocal.OrderId.MultiUpdate = ObjForm.GetValue("u_OrderId")
		If Not OrderItemsLocal.MenuItemId.FldIsDetailKey Then OrderItemsLocal.MenuItemId.FormValue = ObjForm.GetValue("x_MenuItemId")
		OrderItemsLocal.MenuItemId.MultiUpdate = ObjForm.GetValue("u_MenuItemId")
		If Not OrderItemsLocal.MenuItemPropertyId.FldIsDetailKey Then OrderItemsLocal.MenuItemPropertyId.FormValue = ObjForm.GetValue("x_MenuItemPropertyId")
		OrderItemsLocal.MenuItemPropertyId.MultiUpdate = ObjForm.GetValue("u_MenuItemPropertyId")
		If Not OrderItemsLocal.Qta.FldIsDetailKey Then OrderItemsLocal.Qta.FormValue = ObjForm.GetValue("x_Qta")
		OrderItemsLocal.Qta.MultiUpdate = ObjForm.GetValue("u_Qta")
		If Not OrderItemsLocal.Price.FldIsDetailKey Then OrderItemsLocal.Price.FormValue = ObjForm.GetValue("x_Price")
		OrderItemsLocal.Price.MultiUpdate = ObjForm.GetValue("u_Price")
		If Not OrderItemsLocal.Total.FldIsDetailKey Then OrderItemsLocal.Total.FormValue = ObjForm.GetValue("x_Total")
		OrderItemsLocal.Total.MultiUpdate = ObjForm.GetValue("u_Total")
		If Not OrderItemsLocal.toppingids.FldIsDetailKey Then OrderItemsLocal.toppingids.FormValue = ObjForm.GetValue("x_toppingids")
		OrderItemsLocal.toppingids.MultiUpdate = ObjForm.GetValue("u_toppingids")
		If Not OrderItemsLocal.dishpropertiesids.FldIsDetailKey Then OrderItemsLocal.dishpropertiesids.FormValue = ObjForm.GetValue("x_dishpropertiesids")
		OrderItemsLocal.dishpropertiesids.MultiUpdate = ObjForm.GetValue("u_dishpropertiesids")
		If Not OrderItemsLocal.ID.FldIsDetailKey Then OrderItemsLocal.ID.FormValue = ObjForm.GetValue("x_ID")
	End Function

	' -----------------------------------------------------------------
	' Restore form values
	'
	Function RestoreFormValues()
		OrderItemsLocal.OrderId.CurrentValue = OrderItemsLocal.OrderId.FormValue
		OrderItemsLocal.MenuItemId.CurrentValue = OrderItemsLocal.MenuItemId.FormValue
		OrderItemsLocal.MenuItemPropertyId.CurrentValue = OrderItemsLocal.MenuItemPropertyId.FormValue
		OrderItemsLocal.Qta.CurrentValue = OrderItemsLocal.Qta.FormValue
		OrderItemsLocal.Price.CurrentValue = OrderItemsLocal.Price.FormValue
		OrderItemsLocal.Total.CurrentValue = OrderItemsLocal.Total.FormValue
		OrderItemsLocal.toppingids.CurrentValue = OrderItemsLocal.toppingids.FormValue
		OrderItemsLocal.dishpropertiesids.CurrentValue = OrderItemsLocal.dishpropertiesids.FormValue
		OrderItemsLocal.ID.CurrentValue = OrderItemsLocal.ID.FormValue
	End Function

	' -----------------------------------------------------------------
	' Load recordset
	'
	Function LoadRecordset()

		' Load list page sql
		Dim sSql
		sSql = OrderItemsLocal.SelectSQL
		Call ew_SetDebugMsg("LoadRecordset: " & sSql) ' Show SQL for debugging

		' Load recordset
		Dim RsRecordset
		Set RsRecordset = ew_LoadRecordset(sSql)

		' Call Recordset Selected event
		Call OrderItemsLocal.Recordset_Selected(RsRecordset)
		Set LoadRecordset = RsRecordset
	End Function

	' -----------------------------------------------------------------
	' Load row based on key values
	'
	Function LoadRow()
		Dim RsRow, sSql, sFilter
		sFilter = OrderItemsLocal.KeyFilter

		' Call Row Selecting event
		Call OrderItemsLocal.Row_Selecting(sFilter)

		' Load sql based on filter
		OrderItemsLocal.CurrentFilter = sFilter
		sSql = OrderItemsLocal.SQL
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
		Call OrderItemsLocal.Row_Selected(RsRow)
		OrderItemsLocal.ID.DbValue = RsRow("ID")
		OrderItemsLocal.OrderId.DbValue = RsRow("OrderId")
		OrderItemsLocal.MenuItemId.DbValue = RsRow("MenuItemId")
		OrderItemsLocal.MenuItemPropertyId.DbValue = RsRow("MenuItemPropertyId")
		OrderItemsLocal.Qta.DbValue = RsRow("Qta")
		OrderItemsLocal.Price.DbValue = RsRow("Price")
		OrderItemsLocal.Total.DbValue = RsRow("Total")
		OrderItemsLocal.toppingids.DbValue = RsRow("toppingids")
		OrderItemsLocal.dishpropertiesids.DbValue = RsRow("dishpropertiesids")
	End Sub

	' Load DbValue from recordset
	Sub LoadDbValues(Rs)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		If Rs.Eof Then Exit Sub
		OrderItemsLocal.ID.m_DbValue = Rs("ID")
		OrderItemsLocal.OrderId.m_DbValue = Rs("OrderId")
		OrderItemsLocal.MenuItemId.m_DbValue = Rs("MenuItemId")
		OrderItemsLocal.MenuItemPropertyId.m_DbValue = Rs("MenuItemPropertyId")
		OrderItemsLocal.Qta.m_DbValue = Rs("Qta")
		OrderItemsLocal.Price.m_DbValue = Rs("Price")
		OrderItemsLocal.Total.m_DbValue = Rs("Total")
		OrderItemsLocal.toppingids.m_DbValue = Rs("toppingids")
		OrderItemsLocal.dishpropertiesids.m_DbValue = Rs("dishpropertiesids")
	End Sub

	' -----------------------------------------------------------------
	' Render row values based on field settings
	'
	Sub RenderRow()

		' Initialize urls
		' Convert decimal values if posted back

		If OrderItemsLocal.Price.FormValue = OrderItemsLocal.Price.CurrentValue And IsNumeric(OrderItemsLocal.Price.CurrentValue) Then
			OrderItemsLocal.Price.CurrentValue = ew_StrToFloat(OrderItemsLocal.Price.CurrentValue)
		End If

		' Convert decimal values if posted back
		If OrderItemsLocal.Total.FormValue = OrderItemsLocal.Total.CurrentValue And IsNumeric(OrderItemsLocal.Total.CurrentValue) Then
			OrderItemsLocal.Total.CurrentValue = ew_StrToFloat(OrderItemsLocal.Total.CurrentValue)
		End If

		' Call Row Rendering event
		Call OrderItemsLocal.Row_Rendering()

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

		If OrderItemsLocal.RowType = EW_ROWTYPE_VIEW Then ' View row

			' ID
			OrderItemsLocal.ID.ViewValue = OrderItemsLocal.ID.CurrentValue
			OrderItemsLocal.ID.ViewCustomAttributes = ""

			' OrderId
			OrderItemsLocal.OrderId.ViewValue = OrderItemsLocal.OrderId.CurrentValue
			OrderItemsLocal.OrderId.ViewCustomAttributes = ""

			' MenuItemId
			OrderItemsLocal.MenuItemId.ViewValue = OrderItemsLocal.MenuItemId.CurrentValue
			OrderItemsLocal.MenuItemId.ViewCustomAttributes = ""

			' MenuItemPropertyId
			OrderItemsLocal.MenuItemPropertyId.ViewValue = OrderItemsLocal.MenuItemPropertyId.CurrentValue
			OrderItemsLocal.MenuItemPropertyId.ViewCustomAttributes = ""

			' Qta
			OrderItemsLocal.Qta.ViewValue = OrderItemsLocal.Qta.CurrentValue
			OrderItemsLocal.Qta.ViewCustomAttributes = ""

			' Price
			OrderItemsLocal.Price.ViewValue = OrderItemsLocal.Price.CurrentValue
			OrderItemsLocal.Price.ViewCustomAttributes = ""

			' Total
			OrderItemsLocal.Total.ViewValue = OrderItemsLocal.Total.CurrentValue
			OrderItemsLocal.Total.ViewCustomAttributes = ""

			' toppingids
			OrderItemsLocal.toppingids.ViewValue = OrderItemsLocal.toppingids.CurrentValue
			OrderItemsLocal.toppingids.ViewCustomAttributes = ""

			' dishpropertiesids
			OrderItemsLocal.dishpropertiesids.ViewValue = OrderItemsLocal.dishpropertiesids.CurrentValue
			OrderItemsLocal.dishpropertiesids.ViewCustomAttributes = ""

			' View refer script
			' OrderId

			OrderItemsLocal.OrderId.LinkCustomAttributes = ""
			OrderItemsLocal.OrderId.HrefValue = ""
			OrderItemsLocal.OrderId.TooltipValue = ""

			' MenuItemId
			OrderItemsLocal.MenuItemId.LinkCustomAttributes = ""
			OrderItemsLocal.MenuItemId.HrefValue = ""
			OrderItemsLocal.MenuItemId.TooltipValue = ""

			' MenuItemPropertyId
			OrderItemsLocal.MenuItemPropertyId.LinkCustomAttributes = ""
			OrderItemsLocal.MenuItemPropertyId.HrefValue = ""
			OrderItemsLocal.MenuItemPropertyId.TooltipValue = ""

			' Qta
			OrderItemsLocal.Qta.LinkCustomAttributes = ""
			OrderItemsLocal.Qta.HrefValue = ""
			OrderItemsLocal.Qta.TooltipValue = ""

			' Price
			OrderItemsLocal.Price.LinkCustomAttributes = ""
			OrderItemsLocal.Price.HrefValue = ""
			OrderItemsLocal.Price.TooltipValue = ""

			' Total
			OrderItemsLocal.Total.LinkCustomAttributes = ""
			OrderItemsLocal.Total.HrefValue = ""
			OrderItemsLocal.Total.TooltipValue = ""

			' toppingids
			OrderItemsLocal.toppingids.LinkCustomAttributes = ""
			OrderItemsLocal.toppingids.HrefValue = ""
			OrderItemsLocal.toppingids.TooltipValue = ""

			' dishpropertiesids
			OrderItemsLocal.dishpropertiesids.LinkCustomAttributes = ""
			OrderItemsLocal.dishpropertiesids.HrefValue = ""
			OrderItemsLocal.dishpropertiesids.TooltipValue = ""

		' ----------
		'  Edit Row
		' ----------

		ElseIf OrderItemsLocal.RowType = EW_ROWTYPE_EDIT Then ' Edit row

			' OrderId
			OrderItemsLocal.OrderId.EditAttrs.UpdateAttribute "class", "form-control"
			OrderItemsLocal.OrderId.EditCustomAttributes = ""
			OrderItemsLocal.OrderId.EditValue = ew_HtmlEncode(OrderItemsLocal.OrderId.CurrentValue)
			OrderItemsLocal.OrderId.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrderItemsLocal.OrderId.FldCaption))

			' MenuItemId
			OrderItemsLocal.MenuItemId.EditAttrs.UpdateAttribute "class", "form-control"
			OrderItemsLocal.MenuItemId.EditCustomAttributes = ""
			OrderItemsLocal.MenuItemId.EditValue = ew_HtmlEncode(OrderItemsLocal.MenuItemId.CurrentValue)
			OrderItemsLocal.MenuItemId.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrderItemsLocal.MenuItemId.FldCaption))

			' MenuItemPropertyId
			OrderItemsLocal.MenuItemPropertyId.EditAttrs.UpdateAttribute "class", "form-control"
			OrderItemsLocal.MenuItemPropertyId.EditCustomAttributes = ""
			OrderItemsLocal.MenuItemPropertyId.EditValue = ew_HtmlEncode(OrderItemsLocal.MenuItemPropertyId.CurrentValue)
			OrderItemsLocal.MenuItemPropertyId.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrderItemsLocal.MenuItemPropertyId.FldCaption))

			' Qta
			OrderItemsLocal.Qta.EditAttrs.UpdateAttribute "class", "form-control"
			OrderItemsLocal.Qta.EditCustomAttributes = ""
			OrderItemsLocal.Qta.EditValue = ew_HtmlEncode(OrderItemsLocal.Qta.CurrentValue)
			OrderItemsLocal.Qta.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrderItemsLocal.Qta.FldCaption))

			' Price
			OrderItemsLocal.Price.EditAttrs.UpdateAttribute "class", "form-control"
			OrderItemsLocal.Price.EditCustomAttributes = ""
			OrderItemsLocal.Price.EditValue = ew_HtmlEncode(OrderItemsLocal.Price.CurrentValue)
			OrderItemsLocal.Price.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrderItemsLocal.Price.FldCaption))
			If OrderItemsLocal.Price.EditValue&"" <> "" And IsNumeric(OrderItemsLocal.Price.EditValue) Then OrderItemsLocal.Price.EditValue = ew_FormatNumber2(OrderItemsLocal.Price.EditValue, -2)

			' Total
			OrderItemsLocal.Total.EditAttrs.UpdateAttribute "class", "form-control"
			OrderItemsLocal.Total.EditCustomAttributes = ""
			OrderItemsLocal.Total.EditValue = ew_HtmlEncode(OrderItemsLocal.Total.CurrentValue)
			OrderItemsLocal.Total.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrderItemsLocal.Total.FldCaption))
			If OrderItemsLocal.Total.EditValue&"" <> "" And IsNumeric(OrderItemsLocal.Total.EditValue) Then OrderItemsLocal.Total.EditValue = ew_FormatNumber2(OrderItemsLocal.Total.EditValue, -2)

			' toppingids
			OrderItemsLocal.toppingids.EditAttrs.UpdateAttribute "class", "form-control"
			OrderItemsLocal.toppingids.EditCustomAttributes = ""
			OrderItemsLocal.toppingids.EditValue = ew_HtmlEncode(OrderItemsLocal.toppingids.CurrentValue)
			OrderItemsLocal.toppingids.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrderItemsLocal.toppingids.FldCaption))

			' dishpropertiesids
			OrderItemsLocal.dishpropertiesids.EditAttrs.UpdateAttribute "class", "form-control"
			OrderItemsLocal.dishpropertiesids.EditCustomAttributes = ""
			OrderItemsLocal.dishpropertiesids.EditValue = ew_HtmlEncode(OrderItemsLocal.dishpropertiesids.CurrentValue)
			OrderItemsLocal.dishpropertiesids.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrderItemsLocal.dishpropertiesids.FldCaption))

			' Edit refer script
			' OrderId

			OrderItemsLocal.OrderId.HrefValue = ""

			' MenuItemId
			OrderItemsLocal.MenuItemId.HrefValue = ""

			' MenuItemPropertyId
			OrderItemsLocal.MenuItemPropertyId.HrefValue = ""

			' Qta
			OrderItemsLocal.Qta.HrefValue = ""

			' Price
			OrderItemsLocal.Price.HrefValue = ""

			' Total
			OrderItemsLocal.Total.HrefValue = ""

			' toppingids
			OrderItemsLocal.toppingids.HrefValue = ""

			' dishpropertiesids
			OrderItemsLocal.dishpropertiesids.HrefValue = ""
		End If
		If OrderItemsLocal.RowType = EW_ROWTYPE_ADD Or OrderItemsLocal.RowType = EW_ROWTYPE_EDIT Or OrderItemsLocal.RowType = EW_ROWTYPE_SEARCH Then ' Add / Edit / Search row
			Call OrderItemsLocal.SetupFieldTitles()
		End If

		' Call Row Rendered event
		If OrderItemsLocal.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call OrderItemsLocal.Row_Rendered()
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
		If OrderItemsLocal.OrderId.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrderItemsLocal.MenuItemId.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrderItemsLocal.MenuItemPropertyId.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrderItemsLocal.Qta.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrderItemsLocal.Price.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrderItemsLocal.Total.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrderItemsLocal.toppingids.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrderItemsLocal.dishpropertiesids.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
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
		If OrderItemsLocal.OrderId.MultiUpdate <> "" Then
			If Not ew_CheckInteger(OrderItemsLocal.OrderId.FormValue) Then
				Call ew_AddMessage(gsFormError, OrderItemsLocal.OrderId.FldErrMsg)
			End If
		End If
		If OrderItemsLocal.MenuItemId.MultiUpdate <> "" Then
			If Not ew_CheckInteger(OrderItemsLocal.MenuItemId.FormValue) Then
				Call ew_AddMessage(gsFormError, OrderItemsLocal.MenuItemId.FldErrMsg)
			End If
		End If
		If OrderItemsLocal.MenuItemPropertyId.MultiUpdate <> "" Then
			If Not ew_CheckInteger(OrderItemsLocal.MenuItemPropertyId.FormValue) Then
				Call ew_AddMessage(gsFormError, OrderItemsLocal.MenuItemPropertyId.FldErrMsg)
			End If
		End If
		If OrderItemsLocal.Qta.MultiUpdate <> "" Then
			If Not ew_CheckInteger(OrderItemsLocal.Qta.FormValue) Then
				Call ew_AddMessage(gsFormError, OrderItemsLocal.Qta.FldErrMsg)
			End If
		End If
		If OrderItemsLocal.Price.MultiUpdate <> "" Then
			If Not ew_CheckNumber(OrderItemsLocal.Price.FormValue) Then
				Call ew_AddMessage(gsFormError, OrderItemsLocal.Price.FldErrMsg)
			End If
		End If
		If OrderItemsLocal.Total.MultiUpdate <> "" Then
			If Not ew_CheckNumber(OrderItemsLocal.Total.FormValue) Then
				Call ew_AddMessage(gsFormError, OrderItemsLocal.Total.FldErrMsg)
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
		sFilter = OrderItemsLocal.KeyFilter
		OrderItemsLocal.CurrentFilter  = sFilter
		sSql = OrderItemsLocal.SQL
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

			' Field OrderId
			Call OrderItemsLocal.OrderId.SetDbValue(Rs, OrderItemsLocal.OrderId.CurrentValue, Null, OrderItemsLocal.OrderId.ReadOnly Or OrderItemsLocal.OrderId.MultiUpdate&"" <> "1")

			' Field MenuItemId
			Call OrderItemsLocal.MenuItemId.SetDbValue(Rs, OrderItemsLocal.MenuItemId.CurrentValue, Null, OrderItemsLocal.MenuItemId.ReadOnly Or OrderItemsLocal.MenuItemId.MultiUpdate&"" <> "1")

			' Field MenuItemPropertyId
			Call OrderItemsLocal.MenuItemPropertyId.SetDbValue(Rs, OrderItemsLocal.MenuItemPropertyId.CurrentValue, Null, OrderItemsLocal.MenuItemPropertyId.ReadOnly Or OrderItemsLocal.MenuItemPropertyId.MultiUpdate&"" <> "1")

			' Field Qta
			Call OrderItemsLocal.Qta.SetDbValue(Rs, OrderItemsLocal.Qta.CurrentValue, Null, OrderItemsLocal.Qta.ReadOnly Or OrderItemsLocal.Qta.MultiUpdate&"" <> "1")

			' Field Price
			Call OrderItemsLocal.Price.SetDbValue(Rs, OrderItemsLocal.Price.CurrentValue, Null, OrderItemsLocal.Price.ReadOnly Or OrderItemsLocal.Price.MultiUpdate&"" <> "1")

			' Field Total
			Call OrderItemsLocal.Total.SetDbValue(Rs, OrderItemsLocal.Total.CurrentValue, Null, OrderItemsLocal.Total.ReadOnly Or OrderItemsLocal.Total.MultiUpdate&"" <> "1")

			' Field toppingids
			Call OrderItemsLocal.toppingids.SetDbValue(Rs, OrderItemsLocal.toppingids.CurrentValue, Null, OrderItemsLocal.toppingids.ReadOnly Or OrderItemsLocal.toppingids.MultiUpdate&"" <> "1")

			' Field dishpropertiesids
			Call OrderItemsLocal.dishpropertiesids.SetDbValue(Rs, OrderItemsLocal.dishpropertiesids.CurrentValue, Null, OrderItemsLocal.dishpropertiesids.ReadOnly Or OrderItemsLocal.dishpropertiesids.MultiUpdate&"" <> "1")

			' Check recordset update error
			If Err.Number <> 0 Then
				FailureMessage = Err.Description
				Rs.Close
				Set Rs = Nothing
				EditRow = False
				Exit Function
			End If

			' Call Row Updating event
			bUpdateRow = OrderItemsLocal.Row_Updating(RsOld, Rs)
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
				ElseIf OrderItemsLocal.CancelMessage <> "" Then
					FailureMessage = OrderItemsLocal.CancelMessage
					OrderItemsLocal.CancelMessage = ""
				Else
					FailureMessage = Language.Phrase("UpdateCancelled")
				End If
				EditRow = False
			End If
		End If

		' Call Row Updated event
		If EditRow Then
			Call OrderItemsLocal.Row_Updated(RsOld, RsNew)
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
		Call Breadcrumb.Add("list", OrderItemsLocal.TableVar, "OrderItemsLocallist.asp", "", OrderItemsLocal.TableVar, True)
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
