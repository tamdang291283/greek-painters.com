<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="vouchercodesinfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim vouchercodes_update
Set vouchercodes_update = New cvouchercodes_update
Set Page = vouchercodes_update

' Page init processing
vouchercodes_update.Page_Init()

' Page main processing
vouchercodes_update.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
vouchercodes_update.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var vouchercodes_update = new ew_Page("vouchercodes_update");
vouchercodes_update.PageID = "update"; // Page ID
var EW_PAGE_ID = vouchercodes_update.PageID; // For backward compatibility
// Form object
var fvouchercodesupdate = new ew_Form("fvouchercodesupdate");
// Validate form
fvouchercodesupdate.Validate = function() {
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
			elm = this.GetElements("x" + infix + "_vouchercodediscount");
			uelm = this.GetElements("u" + infix + "_vouchercodediscount");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(vouchercodes.vouchercodediscount.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_IdBusinessDetail");
			uelm = this.GetElements("u" + infix + "_IdBusinessDetail");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(vouchercodes.IdBusinessDetail.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_MinimumAmount");
			uelm = this.GetElements("u" + infix + "_MinimumAmount");
			if (uelm && uelm.checked && elm && !ew_CheckNumber(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(vouchercodes.MinimumAmount.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_MenuItemID");
			uelm = this.GetElements("u" + infix + "_MenuItemID");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(vouchercodes.MenuItemID.FldErrMsg) %>");
			// Set up row object
			ew_ElementsToRow(fobj);
			// Fire Form_CustomValidate event
			if (!this.Form_CustomValidate(fobj))
				return false;
	}
	return true;
}
// Form_CustomValidate event
fvouchercodesupdate.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fvouchercodesupdate.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fvouchercodesupdate.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<div class="ewToolbar">
<% If vouchercodes.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If vouchercodes.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% vouchercodes_update.ShowPageHeader() %>
<% vouchercodes_update.ShowMessage %>
<form name="fvouchercodesupdate" id="fvouchercodesupdate" class="form-horizontal ewForm ewUpdateForm" action="<%= ew_CurrentPage %>" method="post">
<% If vouchercodes_update.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= vouchercodes_update.Token %>">
<% End If %>
<input type="hidden" name="t" value="vouchercodes">
<input type="hidden" name="a_update" id="a_update" value="U">
<% For i = 0 to UBound(vouchercodes_update.RecKeys) %>
<input type="hidden" name="key_m" id="key_m" value="<%= ew_HtmlEncode(ew_GetKeyValue(vouchercodes_update.RecKeys(i))) %>">
<% Next %>
<div id="tbl_vouchercodesupdate">
	<div class="form-group">
		<label class="col-sm-2"><input type="checkbox" name="u" id="u" onclick="ew_SelectAll(this);"> <%= Language.Phrase("UpdateSelectAll") %></label>
	</div>
<% If vouchercodes.vouchercode.Visible Then ' vouchercode %>
	<div id="r_vouchercode" class="form-group">
		<label for="x_vouchercode" class="col-sm-2 control-label">
<input type="checkbox" name="u_vouchercode" id="u_vouchercode" value="1"<% If vouchercodes.vouchercode.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= vouchercodes.vouchercode.FldCaption %></label>
		<div class="col-sm-10"><div<%= vouchercodes.vouchercode.CellAttributes %>>
<span id="el_vouchercodes_vouchercode">
<input type="text" data-field="x_vouchercode" name="x_vouchercode" id="x_vouchercode" size="30" maxlength="255" placeholder="<%= vouchercodes.vouchercode.PlaceHolder %>" value="<%= vouchercodes.vouchercode.EditValue %>"<%= vouchercodes.vouchercode.EditAttributes %>>
</span>
<%= vouchercodes.vouchercode.CustomMsg %></div></div>
	</div>
<% End If %>
<% If vouchercodes.vouchercodediscount.Visible Then ' vouchercodediscount %>
	<div id="r_vouchercodediscount" class="form-group">
		<label for="x_vouchercodediscount" class="col-sm-2 control-label">
<input type="checkbox" name="u_vouchercodediscount" id="u_vouchercodediscount" value="1"<% If vouchercodes.vouchercodediscount.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= vouchercodes.vouchercodediscount.FldCaption %></label>
		<div class="col-sm-10"><div<%= vouchercodes.vouchercodediscount.CellAttributes %>>
<span id="el_vouchercodes_vouchercodediscount">
<input type="text" data-field="x_vouchercodediscount" name="x_vouchercodediscount" id="x_vouchercodediscount" size="30" placeholder="<%= vouchercodes.vouchercodediscount.PlaceHolder %>" value="<%= vouchercodes.vouchercodediscount.EditValue %>"<%= vouchercodes.vouchercodediscount.EditAttributes %>>
</span>
<%= vouchercodes.vouchercodediscount.CustomMsg %></div></div>
	</div>
<% End If %>
<% If vouchercodes.vouchertype.Visible Then ' vouchertype %>
	<div id="r_vouchertype" class="form-group">
		<label for="x_vouchertype" class="col-sm-2 control-label">
<input type="checkbox" name="u_vouchertype" id="u_vouchertype" value="1"<% If vouchercodes.vouchertype.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= vouchercodes.vouchertype.FldCaption %></label>
		<div class="col-sm-10"><div<%= vouchercodes.vouchertype.CellAttributes %>>
<span id="el_vouchercodes_vouchertype">
<input type="text" data-field="x_vouchertype" name="x_vouchertype" id="x_vouchertype" size="30" maxlength="255" placeholder="<%= vouchercodes.vouchertype.PlaceHolder %>" value="<%= vouchercodes.vouchertype.EditValue %>"<%= vouchercodes.vouchertype.EditAttributes %>>
</span>
<%= vouchercodes.vouchertype.CustomMsg %></div></div>
	</div>
<% End If %>
<% If vouchercodes.startdate.Visible Then ' startdate %>
	<div id="r_startdate" class="form-group">
		<label for="x_startdate" class="col-sm-2 control-label">
<input type="checkbox" name="u_startdate" id="u_startdate" value="1"<% If vouchercodes.startdate.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= vouchercodes.startdate.FldCaption %></label>
		<div class="col-sm-10"><div<%= vouchercodes.startdate.CellAttributes %>>
<span id="el_vouchercodes_startdate">
<input type="text" data-field="x_startdate" name="x_startdate" id="x_startdate" size="30" maxlength="255" placeholder="<%= vouchercodes.startdate.PlaceHolder %>" value="<%= vouchercodes.startdate.EditValue %>"<%= vouchercodes.startdate.EditAttributes %>>
</span>
<%= vouchercodes.startdate.CustomMsg %></div></div>
	</div>
<% End If %>
<% If vouchercodes.enddate.Visible Then ' enddate %>
	<div id="r_enddate" class="form-group">
		<label for="x_enddate" class="col-sm-2 control-label">
<input type="checkbox" name="u_enddate" id="u_enddate" value="1"<% If vouchercodes.enddate.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= vouchercodes.enddate.FldCaption %></label>
		<div class="col-sm-10"><div<%= vouchercodes.enddate.CellAttributes %>>
<span id="el_vouchercodes_enddate">
<input type="text" data-field="x_enddate" name="x_enddate" id="x_enddate" size="30" maxlength="255" placeholder="<%= vouchercodes.enddate.PlaceHolder %>" value="<%= vouchercodes.enddate.EditValue %>"<%= vouchercodes.enddate.EditAttributes %>>
</span>
<%= vouchercodes.enddate.CustomMsg %></div></div>
	</div>
<% End If %>
<% If vouchercodes.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
	<div id="r_IdBusinessDetail" class="form-group">
		<label for="x_IdBusinessDetail" class="col-sm-2 control-label">
<input type="checkbox" name="u_IdBusinessDetail" id="u_IdBusinessDetail" value="1"<% If vouchercodes.IdBusinessDetail.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= vouchercodes.IdBusinessDetail.FldCaption %></label>
		<div class="col-sm-10"><div<%= vouchercodes.IdBusinessDetail.CellAttributes %>>
<span id="el_vouchercodes_IdBusinessDetail">
<input type="text" data-field="x_IdBusinessDetail" name="x_IdBusinessDetail" id="x_IdBusinessDetail" size="30" placeholder="<%= vouchercodes.IdBusinessDetail.PlaceHolder %>" value="<%= vouchercodes.IdBusinessDetail.EditValue %>"<%= vouchercodes.IdBusinessDetail.EditAttributes %>>
</span>
<%= vouchercodes.IdBusinessDetail.CustomMsg %></div></div>
	</div>
<% End If %>
<% If vouchercodes.MinimumAmount.Visible Then ' MinimumAmount %>
	<div id="r_MinimumAmount" class="form-group">
		<label for="x_MinimumAmount" class="col-sm-2 control-label">
<input type="checkbox" name="u_MinimumAmount" id="u_MinimumAmount" value="1"<% If vouchercodes.MinimumAmount.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= vouchercodes.MinimumAmount.FldCaption %></label>
		<div class="col-sm-10"><div<%= vouchercodes.MinimumAmount.CellAttributes %>>
<span id="el_vouchercodes_MinimumAmount">
<input type="text" data-field="x_MinimumAmount" name="x_MinimumAmount" id="x_MinimumAmount" size="30" placeholder="<%= vouchercodes.MinimumAmount.PlaceHolder %>" value="<%= vouchercodes.MinimumAmount.EditValue %>"<%= vouchercodes.MinimumAmount.EditAttributes %>>
</span>
<%= vouchercodes.MinimumAmount.CustomMsg %></div></div>
	</div>
<% End If %>
<% If vouchercodes.MenuItemID.Visible Then ' MenuItemID %>
	<div id="r_MenuItemID" class="form-group">
		<label for="x_MenuItemID" class="col-sm-2 control-label">
<input type="checkbox" name="u_MenuItemID" id="u_MenuItemID" value="1"<% If vouchercodes.MenuItemID.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= vouchercodes.MenuItemID.FldCaption %></label>
		<div class="col-sm-10"><div<%= vouchercodes.MenuItemID.CellAttributes %>>
<span id="el_vouchercodes_MenuItemID">
<input type="text" data-field="x_MenuItemID" name="x_MenuItemID" id="x_MenuItemID" size="30" placeholder="<%= vouchercodes.MenuItemID.PlaceHolder %>" value="<%= vouchercodes.MenuItemID.EditValue %>"<%= vouchercodes.MenuItemID.EditAttributes %>>
</span>
<%= vouchercodes.MenuItemID.CustomMsg %></div></div>
	</div>
<% End If %>
<% If vouchercodes.VoucherMainType.Visible Then ' VoucherMainType %>
	<div id="r_VoucherMainType" class="form-group">
		<label for="x_VoucherMainType" class="col-sm-2 control-label">
<input type="checkbox" name="u_VoucherMainType" id="u_VoucherMainType" value="1"<% If vouchercodes.VoucherMainType.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= vouchercodes.VoucherMainType.FldCaption %></label>
		<div class="col-sm-10"><div<%= vouchercodes.VoucherMainType.CellAttributes %>>
<span id="el_vouchercodes_VoucherMainType">
<input type="text" data-field="x_VoucherMainType" name="x_VoucherMainType" id="x_VoucherMainType" size="30" maxlength="255" placeholder="<%= vouchercodes.VoucherMainType.PlaceHolder %>" value="<%= vouchercodes.VoucherMainType.EditValue %>"<%= vouchercodes.VoucherMainType.EditAttributes %>>
</span>
<%= vouchercodes.VoucherMainType.CustomMsg %></div></div>
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
fvouchercodesupdate.Init();
</script>
<%
vouchercodes_update.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set vouchercodes_update = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cvouchercodes_update

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
		TableName = "vouchercodes"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "vouchercodes_update"
	End Property

	' Page Name
	Public Property Get PageName()
		PageName = ew_CurrentPage()
	End Property

	' Page Url
	Public Property Get PageUrl()
		PageUrl = ew_CurrentPage() & "?"
		If vouchercodes.UseTokenInUrl Then PageUrl = PageUrl & "t=" & vouchercodes.TableVar & "&" ' add page token
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
		If vouchercodes.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (vouchercodes.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (vouchercodes.TableVar = Request.QueryString("t"))
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
		If IsEmpty(vouchercodes) Then Set vouchercodes = New cvouchercodes
		Set Table = vouchercodes

		' Initialize urls
		' Initialize form object

		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "update"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "vouchercodes"

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

		vouchercodes.CurrentAction = ew_IIf(Request.QueryString("a").Count > 0, Request.QueryString("a") & "", ObjForm.GetValue("a_list") & "") ' Set up current action

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
			results = vouchercodes.GetAutoFill(Request.Form("name"), Request.Form("q"))
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
		If Not vouchercodes Is Nothing Then
			If vouchercodes.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = vouchercodes.TableVar
				If vouchercodes.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf vouchercodes.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf vouchercodes.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf vouchercodes.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set vouchercodes = Nothing
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
		RecKeys = vouchercodes.GetRecordKeys() ' Load record keys
		If ObjForm.GetValue("a_update")&"" <> "" Then

			' Get action
			vouchercodes.CurrentAction = ObjForm.GetValue("a_update")
			Call LoadFormValues() ' Get form values

			' Validate form
			If Not ValidateForm() Then
				vouchercodes.CurrentAction = "I" ' Form error, reset action
				FailureMessage = gsFormError
			End If
		Else
			Call LoadMultiUpdateValues() ' Load initial values to form
		End If
		If Not IsArray(RecKeys) Then
			Call Page_Terminate("vouchercodeslist.asp") ' No records selected, return to list
		End If
		Select Case vouchercodes.CurrentAction
			Case "U" ' Update
				If UpdateRows() Then ' Update Records based on key
					If SuccessMessage = "" Then SuccessMessage = Language.Phrase("UpdateSuccess") ' Set update success message
					Call Page_Terminate(vouchercodes.ReturnUrl) ' Return to caller
				Else
					Call RestoreFormValues() ' Restore form values
				End If
		End Select

		' Render row
		vouchercodes.RowType = EW_ROWTYPE_EDIT ' Render edit

		' Render row
		Call vouchercodes.ResetAttrs()
		Call RenderRow()
	End Sub

	' -----------------------------------------------------------------
	' Load initial values to form if field values are identical in all selected records
	'
	Sub LoadMultiUpdateValues()
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		Dim Rs, i, OldValue, NewValue
		vouchercodes.CurrentFilter = vouchercodes.GetKeyFilter()

		' Load recordset
		Set Rs = LoadRecordset()
		i = 1
		Do While Not Rs.Eof
			If i = 1 Then
				vouchercodes.vouchercode.DbValue = ew_Conv(Rs("vouchercode"), Rs("vouchercode").Type)
				vouchercodes.vouchercodediscount.DbValue = ew_Conv(Rs("vouchercodediscount"), Rs("vouchercodediscount").Type)
				vouchercodes.vouchertype.DbValue = ew_Conv(Rs("vouchertype"), Rs("vouchertype").Type)
				vouchercodes.startdate.DbValue = ew_Conv(Rs("startdate"), Rs("startdate").Type)
				vouchercodes.enddate.DbValue = ew_Conv(Rs("enddate"), Rs("enddate").Type)
				vouchercodes.IdBusinessDetail.DbValue = ew_Conv(Rs("IdBusinessDetail"), Rs("IdBusinessDetail").Type)
				vouchercodes.MinimumAmount.DbValue = ew_Conv(Rs("MinimumAmount"), Rs("MinimumAmount").Type)
				vouchercodes.MenuItemID.DbValue = ew_Conv(Rs("MenuItemID"), Rs("MenuItemID").Type)
				vouchercodes.VoucherMainType.DbValue = ew_Conv(Rs("VoucherMainType"), Rs("VoucherMainType").Type)
			Else
				OldValue = vouchercodes.vouchercode.DbValue
				NewValue = ew_Conv(Rs("vouchercode"), Rs("vouchercode").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					vouchercodes.vouchercode.CurrentValue = Null
				End If
				OldValue = vouchercodes.vouchercodediscount.DbValue
				NewValue = ew_Conv(Rs("vouchercodediscount"), Rs("vouchercodediscount").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					vouchercodes.vouchercodediscount.CurrentValue = Null
				End If
				OldValue = vouchercodes.vouchertype.DbValue
				NewValue = ew_Conv(Rs("vouchertype"), Rs("vouchertype").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					vouchercodes.vouchertype.CurrentValue = Null
				End If
				OldValue = vouchercodes.startdate.DbValue
				NewValue = ew_Conv(Rs("startdate"), Rs("startdate").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					vouchercodes.startdate.CurrentValue = Null
				End If
				OldValue = vouchercodes.enddate.DbValue
				NewValue = ew_Conv(Rs("enddate"), Rs("enddate").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					vouchercodes.enddate.CurrentValue = Null
				End If
				OldValue = vouchercodes.IdBusinessDetail.DbValue
				NewValue = ew_Conv(Rs("IdBusinessDetail"), Rs("IdBusinessDetail").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					vouchercodes.IdBusinessDetail.CurrentValue = Null
				End If
				OldValue = vouchercodes.MinimumAmount.DbValue
				NewValue = ew_Conv(Rs("MinimumAmount"), Rs("MinimumAmount").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					vouchercodes.MinimumAmount.CurrentValue = Null
				End If
				OldValue = vouchercodes.MenuItemID.DbValue
				NewValue = ew_Conv(Rs("MenuItemID"), Rs("MenuItemID").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					vouchercodes.MenuItemID.CurrentValue = Null
				End If
				OldValue = vouchercodes.VoucherMainType.DbValue
				NewValue = ew_Conv(Rs("VoucherMainType"), Rs("VoucherMainType").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					vouchercodes.VoucherMainType.CurrentValue = Null
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
		vouchercodes.ID.CurrentValue = sKeyFld ' Set up key value
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
		vouchercodes.CurrentFilter = vouchercodes.GetKeyFilter()
		sSql = vouchercodes.SQL
		Set Rs = Server.CreateObject("ADODB.Recordset")
		Rs.CursorLocation = EW_CURSORLOCATION
		Rs.Open sSql, Conn, 1, EW_RECORDSET_LOCKTYPE
		Set RsOld = ew_CloneRs(Rs)

		' Update all rows
		sKey = ""
		For i = 0 to UBound(RecKeys)
			If SetupKeyValues(RecKeys(i)) Then
				sThisKey = RecKeys(i)
				vouchercodes.SendEmail = False ' Do not send email on update success
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
		If Not vouchercodes.vouchercode.FldIsDetailKey Then vouchercodes.vouchercode.FormValue = ObjForm.GetValue("x_vouchercode")
		vouchercodes.vouchercode.MultiUpdate = ObjForm.GetValue("u_vouchercode")
		If Not vouchercodes.vouchercodediscount.FldIsDetailKey Then vouchercodes.vouchercodediscount.FormValue = ObjForm.GetValue("x_vouchercodediscount")
		vouchercodes.vouchercodediscount.MultiUpdate = ObjForm.GetValue("u_vouchercodediscount")
		If Not vouchercodes.vouchertype.FldIsDetailKey Then vouchercodes.vouchertype.FormValue = ObjForm.GetValue("x_vouchertype")
		vouchercodes.vouchertype.MultiUpdate = ObjForm.GetValue("u_vouchertype")
		If Not vouchercodes.startdate.FldIsDetailKey Then vouchercodes.startdate.FormValue = ObjForm.GetValue("x_startdate")
		vouchercodes.startdate.MultiUpdate = ObjForm.GetValue("u_startdate")
		If Not vouchercodes.enddate.FldIsDetailKey Then vouchercodes.enddate.FormValue = ObjForm.GetValue("x_enddate")
		vouchercodes.enddate.MultiUpdate = ObjForm.GetValue("u_enddate")
		If Not vouchercodes.IdBusinessDetail.FldIsDetailKey Then vouchercodes.IdBusinessDetail.FormValue = ObjForm.GetValue("x_IdBusinessDetail")
		vouchercodes.IdBusinessDetail.MultiUpdate = ObjForm.GetValue("u_IdBusinessDetail")
		If Not vouchercodes.MinimumAmount.FldIsDetailKey Then vouchercodes.MinimumAmount.FormValue = ObjForm.GetValue("x_MinimumAmount")
		vouchercodes.MinimumAmount.MultiUpdate = ObjForm.GetValue("u_MinimumAmount")
		If Not vouchercodes.MenuItemID.FldIsDetailKey Then vouchercodes.MenuItemID.FormValue = ObjForm.GetValue("x_MenuItemID")
		vouchercodes.MenuItemID.MultiUpdate = ObjForm.GetValue("u_MenuItemID")
		If Not vouchercodes.VoucherMainType.FldIsDetailKey Then vouchercodes.VoucherMainType.FormValue = ObjForm.GetValue("x_VoucherMainType")
		vouchercodes.VoucherMainType.MultiUpdate = ObjForm.GetValue("u_VoucherMainType")
		If Not vouchercodes.ID.FldIsDetailKey Then vouchercodes.ID.FormValue = ObjForm.GetValue("x_ID")
	End Function

	' -----------------------------------------------------------------
	' Restore form values
	'
	Function RestoreFormValues()
		vouchercodes.vouchercode.CurrentValue = vouchercodes.vouchercode.FormValue
		vouchercodes.vouchercodediscount.CurrentValue = vouchercodes.vouchercodediscount.FormValue
		vouchercodes.vouchertype.CurrentValue = vouchercodes.vouchertype.FormValue
		vouchercodes.startdate.CurrentValue = vouchercodes.startdate.FormValue
		vouchercodes.enddate.CurrentValue = vouchercodes.enddate.FormValue
		vouchercodes.IdBusinessDetail.CurrentValue = vouchercodes.IdBusinessDetail.FormValue
		vouchercodes.MinimumAmount.CurrentValue = vouchercodes.MinimumAmount.FormValue
		vouchercodes.MenuItemID.CurrentValue = vouchercodes.MenuItemID.FormValue
		vouchercodes.VoucherMainType.CurrentValue = vouchercodes.VoucherMainType.FormValue
		vouchercodes.ID.CurrentValue = vouchercodes.ID.FormValue
	End Function

	' -----------------------------------------------------------------
	' Load recordset
	'
	Function LoadRecordset()

		' Load list page sql
		Dim sSql
		sSql = vouchercodes.SelectSQL
		Call ew_SetDebugMsg("LoadRecordset: " & sSql) ' Show SQL for debugging

		' Load recordset
		Dim RsRecordset
		Set RsRecordset = ew_LoadRecordset(sSql)

		' Call Recordset Selected event
		Call vouchercodes.Recordset_Selected(RsRecordset)
		Set LoadRecordset = RsRecordset
	End Function

	' -----------------------------------------------------------------
	' Load row based on key values
	'
	Function LoadRow()
		Dim RsRow, sSql, sFilter
		sFilter = vouchercodes.KeyFilter

		' Call Row Selecting event
		Call vouchercodes.Row_Selecting(sFilter)

		' Load sql based on filter
		vouchercodes.CurrentFilter = sFilter
		sSql = vouchercodes.SQL
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
		Call vouchercodes.Row_Selected(RsRow)
		vouchercodes.ID.DbValue = RsRow("ID")
		vouchercodes.vouchercode.DbValue = RsRow("vouchercode")
		vouchercodes.vouchercodediscount.DbValue = RsRow("vouchercodediscount")
		vouchercodes.vouchertype.DbValue = RsRow("vouchertype")
		vouchercodes.startdate.DbValue = RsRow("startdate")
		vouchercodes.enddate.DbValue = RsRow("enddate")
		vouchercodes.IdBusinessDetail.DbValue = RsRow("IdBusinessDetail")
		vouchercodes.MinimumAmount.DbValue = RsRow("MinimumAmount")
		vouchercodes.MenuItemID.DbValue = RsRow("MenuItemID")
		vouchercodes.VoucherMainType.DbValue = RsRow("VoucherMainType")
	End Sub

	' Load DbValue from recordset
	Sub LoadDbValues(Rs)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		If Rs.Eof Then Exit Sub
		vouchercodes.ID.m_DbValue = Rs("ID")
		vouchercodes.vouchercode.m_DbValue = Rs("vouchercode")
		vouchercodes.vouchercodediscount.m_DbValue = Rs("vouchercodediscount")
		vouchercodes.vouchertype.m_DbValue = Rs("vouchertype")
		vouchercodes.startdate.m_DbValue = Rs("startdate")
		vouchercodes.enddate.m_DbValue = Rs("enddate")
		vouchercodes.IdBusinessDetail.m_DbValue = Rs("IdBusinessDetail")
		vouchercodes.MinimumAmount.m_DbValue = Rs("MinimumAmount")
		vouchercodes.MenuItemID.m_DbValue = Rs("MenuItemID")
		vouchercodes.VoucherMainType.m_DbValue = Rs("VoucherMainType")
	End Sub

	' -----------------------------------------------------------------
	' Render row values based on field settings
	'
	Sub RenderRow()

		' Initialize urls
		' Convert decimal values if posted back

		If vouchercodes.MinimumAmount.FormValue = vouchercodes.MinimumAmount.CurrentValue And IsNumeric(vouchercodes.MinimumAmount.CurrentValue) Then
			vouchercodes.MinimumAmount.CurrentValue = ew_StrToFloat(vouchercodes.MinimumAmount.CurrentValue)
		End If

		' Call Row Rendering event
		Call vouchercodes.Row_Rendering()

		' ---------------------------------------
		'  Common render codes for all row types
		' ---------------------------------------
		' ID
		' vouchercode
		' vouchercodediscount
		' vouchertype
		' startdate
		' enddate
		' IdBusinessDetail
		' MinimumAmount
		' MenuItemID
		' VoucherMainType
		' -----------
		'  View  Row
		' -----------

		If vouchercodes.RowType = EW_ROWTYPE_VIEW Then ' View row

			' ID
			vouchercodes.ID.ViewValue = vouchercodes.ID.CurrentValue
			vouchercodes.ID.ViewCustomAttributes = ""

			' vouchercode
			vouchercodes.vouchercode.ViewValue = vouchercodes.vouchercode.CurrentValue
			vouchercodes.vouchercode.ViewCustomAttributes = ""

			' vouchercodediscount
			vouchercodes.vouchercodediscount.ViewValue = vouchercodes.vouchercodediscount.CurrentValue
			vouchercodes.vouchercodediscount.ViewCustomAttributes = ""

			' vouchertype
			vouchercodes.vouchertype.ViewValue = vouchercodes.vouchertype.CurrentValue
			vouchercodes.vouchertype.ViewCustomAttributes = ""

			' startdate
			vouchercodes.startdate.ViewValue = vouchercodes.startdate.CurrentValue
			vouchercodes.startdate.ViewCustomAttributes = ""

			' enddate
			vouchercodes.enddate.ViewValue = vouchercodes.enddate.CurrentValue
			vouchercodes.enddate.ViewCustomAttributes = ""

			' IdBusinessDetail
			vouchercodes.IdBusinessDetail.ViewValue = vouchercodes.IdBusinessDetail.CurrentValue
			vouchercodes.IdBusinessDetail.ViewCustomAttributes = ""

			' MinimumAmount
			vouchercodes.MinimumAmount.ViewValue = vouchercodes.MinimumAmount.CurrentValue
			vouchercodes.MinimumAmount.ViewCustomAttributes = ""

			' MenuItemID
			vouchercodes.MenuItemID.ViewValue = vouchercodes.MenuItemID.CurrentValue
			vouchercodes.MenuItemID.ViewCustomAttributes = ""

			' VoucherMainType
			vouchercodes.VoucherMainType.ViewValue = vouchercodes.VoucherMainType.CurrentValue
			vouchercodes.VoucherMainType.ViewCustomAttributes = ""

			' View refer script
			' vouchercode

			vouchercodes.vouchercode.LinkCustomAttributes = ""
			vouchercodes.vouchercode.HrefValue = ""
			vouchercodes.vouchercode.TooltipValue = ""

			' vouchercodediscount
			vouchercodes.vouchercodediscount.LinkCustomAttributes = ""
			vouchercodes.vouchercodediscount.HrefValue = ""
			vouchercodes.vouchercodediscount.TooltipValue = ""

			' vouchertype
			vouchercodes.vouchertype.LinkCustomAttributes = ""
			vouchercodes.vouchertype.HrefValue = ""
			vouchercodes.vouchertype.TooltipValue = ""

			' startdate
			vouchercodes.startdate.LinkCustomAttributes = ""
			vouchercodes.startdate.HrefValue = ""
			vouchercodes.startdate.TooltipValue = ""

			' enddate
			vouchercodes.enddate.LinkCustomAttributes = ""
			vouchercodes.enddate.HrefValue = ""
			vouchercodes.enddate.TooltipValue = ""

			' IdBusinessDetail
			vouchercodes.IdBusinessDetail.LinkCustomAttributes = ""
			vouchercodes.IdBusinessDetail.HrefValue = ""
			vouchercodes.IdBusinessDetail.TooltipValue = ""

			' MinimumAmount
			vouchercodes.MinimumAmount.LinkCustomAttributes = ""
			vouchercodes.MinimumAmount.HrefValue = ""
			vouchercodes.MinimumAmount.TooltipValue = ""

			' MenuItemID
			vouchercodes.MenuItemID.LinkCustomAttributes = ""
			vouchercodes.MenuItemID.HrefValue = ""
			vouchercodes.MenuItemID.TooltipValue = ""

			' VoucherMainType
			vouchercodes.VoucherMainType.LinkCustomAttributes = ""
			vouchercodes.VoucherMainType.HrefValue = ""
			vouchercodes.VoucherMainType.TooltipValue = ""

		' ----------
		'  Edit Row
		' ----------

		ElseIf vouchercodes.RowType = EW_ROWTYPE_EDIT Then ' Edit row

			' vouchercode
			vouchercodes.vouchercode.EditAttrs.UpdateAttribute "class", "form-control"
			vouchercodes.vouchercode.EditCustomAttributes = ""
			vouchercodes.vouchercode.EditValue = ew_HtmlEncode(vouchercodes.vouchercode.CurrentValue)
			vouchercodes.vouchercode.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(vouchercodes.vouchercode.FldCaption))

			' vouchercodediscount
			vouchercodes.vouchercodediscount.EditAttrs.UpdateAttribute "class", "form-control"
			vouchercodes.vouchercodediscount.EditCustomAttributes = ""
			vouchercodes.vouchercodediscount.EditValue = ew_HtmlEncode(vouchercodes.vouchercodediscount.CurrentValue)
			vouchercodes.vouchercodediscount.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(vouchercodes.vouchercodediscount.FldCaption))

			' vouchertype
			vouchercodes.vouchertype.EditAttrs.UpdateAttribute "class", "form-control"
			vouchercodes.vouchertype.EditCustomAttributes = ""
			vouchercodes.vouchertype.EditValue = ew_HtmlEncode(vouchercodes.vouchertype.CurrentValue)
			vouchercodes.vouchertype.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(vouchercodes.vouchertype.FldCaption))

			' startdate
			vouchercodes.startdate.EditAttrs.UpdateAttribute "class", "form-control"
			vouchercodes.startdate.EditCustomAttributes = ""
			vouchercodes.startdate.EditValue = ew_HtmlEncode(vouchercodes.startdate.CurrentValue)
			vouchercodes.startdate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(vouchercodes.startdate.FldCaption))

			' enddate
			vouchercodes.enddate.EditAttrs.UpdateAttribute "class", "form-control"
			vouchercodes.enddate.EditCustomAttributes = ""
			vouchercodes.enddate.EditValue = ew_HtmlEncode(vouchercodes.enddate.CurrentValue)
			vouchercodes.enddate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(vouchercodes.enddate.FldCaption))

			' IdBusinessDetail
			vouchercodes.IdBusinessDetail.EditAttrs.UpdateAttribute "class", "form-control"
			vouchercodes.IdBusinessDetail.EditCustomAttributes = ""
			vouchercodes.IdBusinessDetail.EditValue = ew_HtmlEncode(vouchercodes.IdBusinessDetail.CurrentValue)
			vouchercodes.IdBusinessDetail.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(vouchercodes.IdBusinessDetail.FldCaption))

			' MinimumAmount
			vouchercodes.MinimumAmount.EditAttrs.UpdateAttribute "class", "form-control"
			vouchercodes.MinimumAmount.EditCustomAttributes = ""
			vouchercodes.MinimumAmount.EditValue = ew_HtmlEncode(vouchercodes.MinimumAmount.CurrentValue)
			vouchercodes.MinimumAmount.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(vouchercodes.MinimumAmount.FldCaption))
			If vouchercodes.MinimumAmount.EditValue&"" <> "" And IsNumeric(vouchercodes.MinimumAmount.EditValue) Then vouchercodes.MinimumAmount.EditValue = ew_FormatNumber2(vouchercodes.MinimumAmount.EditValue, -2)

			' MenuItemID
			vouchercodes.MenuItemID.EditAttrs.UpdateAttribute "class", "form-control"
			vouchercodes.MenuItemID.EditCustomAttributes = ""
			vouchercodes.MenuItemID.EditValue = ew_HtmlEncode(vouchercodes.MenuItemID.CurrentValue)
			vouchercodes.MenuItemID.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(vouchercodes.MenuItemID.FldCaption))

			' VoucherMainType
			vouchercodes.VoucherMainType.EditAttrs.UpdateAttribute "class", "form-control"
			vouchercodes.VoucherMainType.EditCustomAttributes = ""
			vouchercodes.VoucherMainType.EditValue = ew_HtmlEncode(vouchercodes.VoucherMainType.CurrentValue)
			vouchercodes.VoucherMainType.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(vouchercodes.VoucherMainType.FldCaption))

			' Edit refer script
			' vouchercode

			vouchercodes.vouchercode.HrefValue = ""

			' vouchercodediscount
			vouchercodes.vouchercodediscount.HrefValue = ""

			' vouchertype
			vouchercodes.vouchertype.HrefValue = ""

			' startdate
			vouchercodes.startdate.HrefValue = ""

			' enddate
			vouchercodes.enddate.HrefValue = ""

			' IdBusinessDetail
			vouchercodes.IdBusinessDetail.HrefValue = ""

			' MinimumAmount
			vouchercodes.MinimumAmount.HrefValue = ""

			' MenuItemID
			vouchercodes.MenuItemID.HrefValue = ""

			' VoucherMainType
			vouchercodes.VoucherMainType.HrefValue = ""
		End If
		If vouchercodes.RowType = EW_ROWTYPE_ADD Or vouchercodes.RowType = EW_ROWTYPE_EDIT Or vouchercodes.RowType = EW_ROWTYPE_SEARCH Then ' Add / Edit / Search row
			Call vouchercodes.SetupFieldTitles()
		End If

		' Call Row Rendered event
		If vouchercodes.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call vouchercodes.Row_Rendered()
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
		If vouchercodes.vouchercode.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If vouchercodes.vouchercodediscount.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If vouchercodes.vouchertype.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If vouchercodes.startdate.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If vouchercodes.enddate.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If vouchercodes.IdBusinessDetail.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If vouchercodes.MinimumAmount.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If vouchercodes.MenuItemID.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If vouchercodes.VoucherMainType.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
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
		If vouchercodes.vouchercodediscount.MultiUpdate <> "" Then
			If Not ew_CheckInteger(vouchercodes.vouchercodediscount.FormValue) Then
				Call ew_AddMessage(gsFormError, vouchercodes.vouchercodediscount.FldErrMsg)
			End If
		End If
		If vouchercodes.IdBusinessDetail.MultiUpdate <> "" Then
			If Not ew_CheckInteger(vouchercodes.IdBusinessDetail.FormValue) Then
				Call ew_AddMessage(gsFormError, vouchercodes.IdBusinessDetail.FldErrMsg)
			End If
		End If
		If vouchercodes.MinimumAmount.MultiUpdate <> "" Then
			If Not ew_CheckNumber(vouchercodes.MinimumAmount.FormValue) Then
				Call ew_AddMessage(gsFormError, vouchercodes.MinimumAmount.FldErrMsg)
			End If
		End If
		If vouchercodes.MenuItemID.MultiUpdate <> "" Then
			If Not ew_CheckInteger(vouchercodes.MenuItemID.FormValue) Then
				Call ew_AddMessage(gsFormError, vouchercodes.MenuItemID.FldErrMsg)
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
		sFilter = vouchercodes.KeyFilter
		vouchercodes.CurrentFilter  = sFilter
		sSql = vouchercodes.SQL
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

			' Field vouchercode
			Call vouchercodes.vouchercode.SetDbValue(Rs, vouchercodes.vouchercode.CurrentValue, Null, vouchercodes.vouchercode.ReadOnly Or vouchercodes.vouchercode.MultiUpdate&"" <> "1")

			' Field vouchercodediscount
			Call vouchercodes.vouchercodediscount.SetDbValue(Rs, vouchercodes.vouchercodediscount.CurrentValue, Null, vouchercodes.vouchercodediscount.ReadOnly Or vouchercodes.vouchercodediscount.MultiUpdate&"" <> "1")

			' Field vouchertype
			Call vouchercodes.vouchertype.SetDbValue(Rs, vouchercodes.vouchertype.CurrentValue, Null, vouchercodes.vouchertype.ReadOnly Or vouchercodes.vouchertype.MultiUpdate&"" <> "1")

			' Field startdate
			Call vouchercodes.startdate.SetDbValue(Rs, vouchercodes.startdate.CurrentValue, Null, vouchercodes.startdate.ReadOnly Or vouchercodes.startdate.MultiUpdate&"" <> "1")

			' Field enddate
			Call vouchercodes.enddate.SetDbValue(Rs, vouchercodes.enddate.CurrentValue, Null, vouchercodes.enddate.ReadOnly Or vouchercodes.enddate.MultiUpdate&"" <> "1")

			' Field IdBusinessDetail
			Call vouchercodes.IdBusinessDetail.SetDbValue(Rs, vouchercodes.IdBusinessDetail.CurrentValue, Null, vouchercodes.IdBusinessDetail.ReadOnly Or vouchercodes.IdBusinessDetail.MultiUpdate&"" <> "1")

			' Field MinimumAmount
			Call vouchercodes.MinimumAmount.SetDbValue(Rs, vouchercodes.MinimumAmount.CurrentValue, Null, vouchercodes.MinimumAmount.ReadOnly Or vouchercodes.MinimumAmount.MultiUpdate&"" <> "1")

			' Field MenuItemID
			Call vouchercodes.MenuItemID.SetDbValue(Rs, vouchercodes.MenuItemID.CurrentValue, Null, vouchercodes.MenuItemID.ReadOnly Or vouchercodes.MenuItemID.MultiUpdate&"" <> "1")

			' Field VoucherMainType
			Call vouchercodes.VoucherMainType.SetDbValue(Rs, vouchercodes.VoucherMainType.CurrentValue, Null, vouchercodes.VoucherMainType.ReadOnly Or vouchercodes.VoucherMainType.MultiUpdate&"" <> "1")

			' Check recordset update error
			If Err.Number <> 0 Then
				FailureMessage = Err.Description
				Rs.Close
				Set Rs = Nothing
				EditRow = False
				Exit Function
			End If

			' Call Row Updating event
			bUpdateRow = vouchercodes.Row_Updating(RsOld, Rs)
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
				ElseIf vouchercodes.CancelMessage <> "" Then
					FailureMessage = vouchercodes.CancelMessage
					vouchercodes.CancelMessage = ""
				Else
					FailureMessage = Language.Phrase("UpdateCancelled")
				End If
				EditRow = False
			End If
		End If

		' Call Row Updated event
		If EditRow Then
			Call vouchercodes.Row_Updated(RsOld, RsNew)
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
		Call Breadcrumb.Add("list", vouchercodes.TableVar, "vouchercodeslist.asp", "", vouchercodes.TableVar, True)
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
