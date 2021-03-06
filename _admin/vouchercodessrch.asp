﻿<%@ CodePage="65001" %>
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
Dim vouchercodes_search
Set vouchercodes_search = New cvouchercodes_search
Set Page = vouchercodes_search

' Page init processing
vouchercodes_search.Page_Init()

' Page main processing
vouchercodes_search.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
vouchercodes_search.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var vouchercodes_search = new ew_Page("vouchercodes_search");
vouchercodes_search.PageID = "search"; // Page ID
var EW_PAGE_ID = vouchercodes_search.PageID; // For backward compatibility
// Form object
var fvouchercodessearch = new ew_Form("fvouchercodessearch");
// Form_CustomValidate event
fvouchercodessearch.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fvouchercodessearch.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fvouchercodessearch.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
// Validate function for search
fvouchercodessearch.Validate = function(fobj) {
	if (!this.ValidateRequired)
		return true; // Ignore validation
	fobj = fobj || this.Form;
	this.PostAutoSuggest();
	var infix = "";
	elm = this.GetElements("x" + infix + "_ID");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(vouchercodes.ID.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_vouchercodediscount");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(vouchercodes.vouchercodediscount.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_IdBusinessDetail");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(vouchercodes.IdBusinessDetail.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_MinimumAmount");
	if (elm && !ew_CheckNumber(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(vouchercodes.MinimumAmount.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_MenuItemID");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(vouchercodes.MenuItemID.FldErrMsg) %>");
	// Set up row object
	ew_ElementsToRow(fobj);
	// Fire Form_CustomValidate event
	if (!this.Form_CustomValidate(fobj))
		return false;
	return true;
}
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<% If Not vouchercodes_search.IsModal Then %>
<div class="ewToolbar">
<% If vouchercodes.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If vouchercodes.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% End If %>
<% vouchercodes_search.ShowPageHeader() %>
<% vouchercodes_search.ShowMessage %>
<form name="fvouchercodessearch" id="fvouchercodessearch" class="form-horizontal ewForm ewSearchForm" action="<%= ew_CurrentPage %>" method="post">
<% If vouchercodes_search.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= vouchercodes_search.Token %>">
<% End If %>
<input type="hidden" name="t" value="vouchercodes">
<input type="hidden" name="a_search" id="a_search" value="S">
<% If vouchercodes_search.IsModal Then %>
<input type="hidden" name="modal" value="1">
<% End If %>
<div>
<% If vouchercodes.ID.Visible Then ' ID %>
	<div id="r_ID" class="form-group">
		<label for="x_ID" class="<%= vouchercodes_search.SearchLabelClass %>"><span id="elh_vouchercodes_ID"><%= vouchercodes.ID.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_ID" id="z_ID" value="="></p>
		</label>
		<div class="<%= vouchercodes_search.SearchRightColumnClass %>"><div<%= vouchercodes.ID.CellAttributes %>>
			<span id="el_vouchercodes_ID">
<input type="text" data-field="x_ID" name="x_ID" id="x_ID" placeholder="<%= vouchercodes.ID.PlaceHolder %>" value="<%= vouchercodes.ID.EditValue %>"<%= vouchercodes.ID.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If vouchercodes.vouchercode.Visible Then ' vouchercode %>
	<div id="r_vouchercode" class="form-group">
		<label for="x_vouchercode" class="<%= vouchercodes_search.SearchLabelClass %>"><span id="elh_vouchercodes_vouchercode"><%= vouchercodes.vouchercode.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_vouchercode" id="z_vouchercode" value="LIKE"></p>
		</label>
		<div class="<%= vouchercodes_search.SearchRightColumnClass %>"><div<%= vouchercodes.vouchercode.CellAttributes %>>
			<span id="el_vouchercodes_vouchercode">
<input type="text" data-field="x_vouchercode" name="x_vouchercode" id="x_vouchercode" size="30" maxlength="255" placeholder="<%= vouchercodes.vouchercode.PlaceHolder %>" value="<%= vouchercodes.vouchercode.EditValue %>"<%= vouchercodes.vouchercode.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If vouchercodes.vouchercodediscount.Visible Then ' vouchercodediscount %>
	<div id="r_vouchercodediscount" class="form-group">
		<label for="x_vouchercodediscount" class="<%= vouchercodes_search.SearchLabelClass %>"><span id="elh_vouchercodes_vouchercodediscount"><%= vouchercodes.vouchercodediscount.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_vouchercodediscount" id="z_vouchercodediscount" value="="></p>
		</label>
		<div class="<%= vouchercodes_search.SearchRightColumnClass %>"><div<%= vouchercodes.vouchercodediscount.CellAttributes %>>
			<span id="el_vouchercodes_vouchercodediscount">
<input type="text" data-field="x_vouchercodediscount" name="x_vouchercodediscount" id="x_vouchercodediscount" size="30" placeholder="<%= vouchercodes.vouchercodediscount.PlaceHolder %>" value="<%= vouchercodes.vouchercodediscount.EditValue %>"<%= vouchercodes.vouchercodediscount.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If vouchercodes.vouchertype.Visible Then ' vouchertype %>
	<div id="r_vouchertype" class="form-group">
		<label for="x_vouchertype" class="<%= vouchercodes_search.SearchLabelClass %>"><span id="elh_vouchercodes_vouchertype"><%= vouchercodes.vouchertype.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_vouchertype" id="z_vouchertype" value="LIKE"></p>
		</label>
		<div class="<%= vouchercodes_search.SearchRightColumnClass %>"><div<%= vouchercodes.vouchertype.CellAttributes %>>
			<span id="el_vouchercodes_vouchertype">
<input type="text" data-field="x_vouchertype" name="x_vouchertype" id="x_vouchertype" size="30" maxlength="255" placeholder="<%= vouchercodes.vouchertype.PlaceHolder %>" value="<%= vouchercodes.vouchertype.EditValue %>"<%= vouchercodes.vouchertype.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If vouchercodes.startdate.Visible Then ' startdate %>
	<div id="r_startdate" class="form-group">
		<label for="x_startdate" class="<%= vouchercodes_search.SearchLabelClass %>"><span id="elh_vouchercodes_startdate"><%= vouchercodes.startdate.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_startdate" id="z_startdate" value="LIKE"></p>
		</label>
		<div class="<%= vouchercodes_search.SearchRightColumnClass %>"><div<%= vouchercodes.startdate.CellAttributes %>>
			<span id="el_vouchercodes_startdate">
<input type="text" data-field="x_startdate" name="x_startdate" id="x_startdate" size="30" maxlength="255" placeholder="<%= vouchercodes.startdate.PlaceHolder %>" value="<%= vouchercodes.startdate.EditValue %>"<%= vouchercodes.startdate.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If vouchercodes.enddate.Visible Then ' enddate %>
	<div id="r_enddate" class="form-group">
		<label for="x_enddate" class="<%= vouchercodes_search.SearchLabelClass %>"><span id="elh_vouchercodes_enddate"><%= vouchercodes.enddate.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_enddate" id="z_enddate" value="LIKE"></p>
		</label>
		<div class="<%= vouchercodes_search.SearchRightColumnClass %>"><div<%= vouchercodes.enddate.CellAttributes %>>
			<span id="el_vouchercodes_enddate">
<input type="text" data-field="x_enddate" name="x_enddate" id="x_enddate" size="30" maxlength="255" placeholder="<%= vouchercodes.enddate.PlaceHolder %>" value="<%= vouchercodes.enddate.EditValue %>"<%= vouchercodes.enddate.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If vouchercodes.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
	<div id="r_IdBusinessDetail" class="form-group">
		<label for="x_IdBusinessDetail" class="<%= vouchercodes_search.SearchLabelClass %>"><span id="elh_vouchercodes_IdBusinessDetail"><%= vouchercodes.IdBusinessDetail.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_IdBusinessDetail" id="z_IdBusinessDetail" value="="></p>
		</label>
		<div class="<%= vouchercodes_search.SearchRightColumnClass %>"><div<%= vouchercodes.IdBusinessDetail.CellAttributes %>>
			<span id="el_vouchercodes_IdBusinessDetail">
<input type="text" data-field="x_IdBusinessDetail" name="x_IdBusinessDetail" id="x_IdBusinessDetail" size="30" placeholder="<%= vouchercodes.IdBusinessDetail.PlaceHolder %>" value="<%= vouchercodes.IdBusinessDetail.EditValue %>"<%= vouchercodes.IdBusinessDetail.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If vouchercodes.MinimumAmount.Visible Then ' MinimumAmount %>
	<div id="r_MinimumAmount" class="form-group">
		<label for="x_MinimumAmount" class="<%= vouchercodes_search.SearchLabelClass %>"><span id="elh_vouchercodes_MinimumAmount"><%= vouchercodes.MinimumAmount.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_MinimumAmount" id="z_MinimumAmount" value="="></p>
		</label>
		<div class="<%= vouchercodes_search.SearchRightColumnClass %>"><div<%= vouchercodes.MinimumAmount.CellAttributes %>>
			<span id="el_vouchercodes_MinimumAmount">
<input type="text" data-field="x_MinimumAmount" name="x_MinimumAmount" id="x_MinimumAmount" size="30" placeholder="<%= vouchercodes.MinimumAmount.PlaceHolder %>" value="<%= vouchercodes.MinimumAmount.EditValue %>"<%= vouchercodes.MinimumAmount.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If vouchercodes.MenuItemID.Visible Then ' MenuItemID %>
	<div id="r_MenuItemID" class="form-group">
		<label for="x_MenuItemID" class="<%= vouchercodes_search.SearchLabelClass %>"><span id="elh_vouchercodes_MenuItemID"><%= vouchercodes.MenuItemID.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_MenuItemID" id="z_MenuItemID" value="="></p>
		</label>
		<div class="<%= vouchercodes_search.SearchRightColumnClass %>"><div<%= vouchercodes.MenuItemID.CellAttributes %>>
			<span id="el_vouchercodes_MenuItemID">
<input type="text" data-field="x_MenuItemID" name="x_MenuItemID" id="x_MenuItemID" size="30" placeholder="<%= vouchercodes.MenuItemID.PlaceHolder %>" value="<%= vouchercodes.MenuItemID.EditValue %>"<%= vouchercodes.MenuItemID.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If vouchercodes.VoucherMainType.Visible Then ' VoucherMainType %>
	<div id="r_VoucherMainType" class="form-group">
		<label for="x_VoucherMainType" class="<%= vouchercodes_search.SearchLabelClass %>"><span id="elh_vouchercodes_VoucherMainType"><%= vouchercodes.VoucherMainType.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_VoucherMainType" id="z_VoucherMainType" value="LIKE"></p>
		</label>
		<div class="<%= vouchercodes_search.SearchRightColumnClass %>"><div<%= vouchercodes.VoucherMainType.CellAttributes %>>
			<span id="el_vouchercodes_VoucherMainType">
<input type="text" data-field="x_VoucherMainType" name="x_VoucherMainType" id="x_VoucherMainType" size="30" maxlength="255" placeholder="<%= vouchercodes.VoucherMainType.PlaceHolder %>" value="<%= vouchercodes.VoucherMainType.EditValue %>"<%= vouchercodes.VoucherMainType.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
</div>
<% If Not vouchercodes_search.IsModal Then %>
<div class="form-group">
	<div class="col-sm-offset-3 col-sm-9">
<button class="btn btn-primary ewButton" name="btnAction" id="btnAction" type="submit"><%= Language.Phrase("Search") %></button>
<button class="btn btn-default ewButton" name="btnReset" id="btnReset" type="button" onclick="ew_ClearForm(this.form);"><%= Language.Phrase("Reset") %></button>
	</div>
</div>
<% End If %>
</form>
<script type="text/javascript">
fvouchercodessearch.Init();
</script>
<%
vouchercodes_search.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set vouchercodes_search = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cvouchercodes_search

	' Page ID
	Public Property Get PageID()
		PageID = "search"
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
		PageObjName = "vouchercodes_search"
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
		EW_PAGE_ID = "search"

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
		vouchercodes.ID.Visible = Not vouchercodes.IsAdd() And Not vouchercodes.IsCopy() And Not vouchercodes.IsGridAdd()

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

	Dim IsModal
	Dim SearchLabelClass
	Dim SearchRightColumnClass

	' -----------------------------------------------------------------
	' Page main processing
	'
	Sub Page_Main()

		' Set up Breadcrumb
		SetupBreadcrumb()
		SearchLabelClass = "col-sm-3 control-label ewLabel"
		SearchRightColumnClass = "col-sm-9"

		' Check modal
		IsModal = (Request.QueryString("modal")&"" = "1" Or Request.Form("modal")&"" = "1")
		If IsModal Then
			gbSkipHeaderFooter = True
		End If
		If IsPageRequest Then ' Validate request

			' Get action
			vouchercodes.CurrentAction = ObjForm.GetValue("a_search")
			Select Case vouchercodes.CurrentAction
				Case "S" ' Get Search Criteria

					' Build search string for advanced search, remove blank field
					Dim sSrchStr
					Call LoadSearchValues() ' Get search values
					If ValidateSearch() Then
						sSrchStr = BuildAdvancedSearch()
					Else
						sSrchStr = ""
						FailureMessage = gsSearchError
					End If
					If sSrchStr <> "" Then
						sSrchStr = vouchercodes.UrlParm(sSrchStr)
						sSrchStr = "vouchercodeslist.asp" & "?" & sSrchStr
						If IsModal Then
							Dim row
							ReDim row(0,0)
							row(0,0) = Array("url", sSrchStr)
							Response.Write ew_ArrayToJson(row, 0)
							Call Page_Terminate("")
							Response.End
						Else
							Call Page_Terminate(sSrchStr) ' Go to list page
						End If
					End If
			End Select
		End If

		' Restore search settings from Session
		If gsSearchError = "" Then
			Call LoadAdvancedSearch()
		End If

		' Render row for search
		vouchercodes.RowType = EW_ROWTYPE_SEARCH
		Call RenderRow()
	End Sub

	' -----------------------------------------------------------------
	' Build advanced search
	'
	Function BuildAdvancedSearch()
		Dim sSrchUrl
		sSrchUrl = ""
		Call BuildSearchUrl(sSrchUrl, vouchercodes.ID, False) ' ID
		Call BuildSearchUrl(sSrchUrl, vouchercodes.vouchercode, False) ' vouchercode
		Call BuildSearchUrl(sSrchUrl, vouchercodes.vouchercodediscount, False) ' vouchercodediscount
		Call BuildSearchUrl(sSrchUrl, vouchercodes.vouchertype, False) ' vouchertype
		Call BuildSearchUrl(sSrchUrl, vouchercodes.startdate, False) ' startdate
		Call BuildSearchUrl(sSrchUrl, vouchercodes.enddate, False) ' enddate
		Call BuildSearchUrl(sSrchUrl, vouchercodes.IdBusinessDetail, False) ' IdBusinessDetail
		Call BuildSearchUrl(sSrchUrl, vouchercodes.MinimumAmount, False) ' MinimumAmount
		Call BuildSearchUrl(sSrchUrl, vouchercodes.MenuItemID, False) ' MenuItemID
		Call BuildSearchUrl(sSrchUrl, vouchercodes.VoucherMainType, False) ' VoucherMainType
		If sSrchUrl <> "" Then sSrchUrl = sSrchUrl & "&"
		sSrchUrl = sSrchUrl & "cmd=search"
		BuildAdvancedSearch = sSrchUrl
	End Function

	' -----------------------------------------------------------------
	' Function to build search URL
	'
	Sub BuildSearchUrl(Url, Fld, OprOnly)
		Dim FldVal, FldOpr, FldCond, FldVal2, FldOpr2
		Dim FldParm
		Dim IsValidValue, sWrk
		sWrk = ""
		FldParm = Mid(Fld.FldVar, 3)
		FldVal = ObjForm.GetValue("x_" & FldParm)
		FldOpr = ObjForm.GetValue("z_" & FldParm)
		FldCond = ObjForm.GetValue("v_" & FldParm)
		FldVal2 = ObjForm.GetValue("y_" & FldParm)
		FldOpr2 = ObjForm.GetValue("w_" & FldParm)
		FldOpr = UCase(Trim(FldOpr))
		Dim lFldDataType
		If Fld.FldIsVirtual Then
			lFldDataType = EW_DATATYPE_STRING
		Else
			lFldDataType = Fld.FldDataType
		End If
		If FldOpr = "BETWEEN" Then
			IsValidValue = (lFldDataType <> EW_DATATYPE_NUMBER) Or _
				(lFldDataType = EW_DATATYPE_NUMBER And SearchValueIsNumeric(Fld, FldVal) And SearchValueIsNumeric(Fld, FldVal2))
			If FldVal <> "" And FldVal2 <> "" And IsValidValue Then
				sWrk = "x_" & FldParm & "=" & ew_Encode(FldVal) & _
					"&y_" & FldParm & "=" & ew_Encode(FldVal2) & _
					"&z_" & FldParm & "=" & ew_Encode(FldOpr)
			End If
		Else
			IsValidValue = (lFldDataType <> EW_DATATYPE_NUMBER) Or _
				(lFldDataType = EW_DATATYPE_NUMBER And SearchValueIsNumeric(Fld, FldVal))
			If FldVal <> "" And IsValidValue And ew_IsValidOpr(FldOpr, lFldDataType) Then
				sWrk = "x_" & FldParm & "=" & ew_Encode(FldVal) & _
					"&z_" & FldParm & "=" & ew_Encode(FldOpr)
			ElseIf FldOpr = "IS NULL" Or FldOpr = "IS NOT NULL" Or (FldOpr <> "" And OprOnly And ew_IsValidOpr(FldOpr, lFldDataType)) Then
				sWrk = "z_" & FldParm & "=" & ew_Encode(FldOpr)
			End If
			IsValidValue = (lFldDataType <> EW_DATATYPE_NUMBER) Or _
				(lFldDataType = EW_DATATYPE_NUMBER And SearchValueIsNumeric(Fld, FldVal2))
			If FldVal2 <> "" And IsValidValue And ew_IsValidOpr(FldOpr2, lFldDataType) Then
				If sWrk <> "" Then sWrk = sWrk & "&v_" & FldParm & "=" & FldCond & "&"
				sWrk = sWrk & "y_" & FldParm & "=" & ew_Encode(FldVal2) & _
					"&w_" & FldParm & "=" & ew_Encode(FldOpr2)
			ElseIf FldOpr2 = "IS NULL" Or FldOpr2 = "IS NOT NULL" Or (FldOpr2 <> "" And OprOnly And ew_IsValidOpr(FldOpr2, lFldDataType)) Then
				If sWrk <> "" Then sWrk = sWrk & "&v_" & FldParm & "=" & FldCond & "&"
				sWrk = sWrk & "w_" & FldParm & "=" & ew_Encode(FldOpr2)
			End If
		End If
		If sWrk <> "" Then
			If Url <> "" Then Url = Url & "&"
			Url = Url & sWrk
		End If
	End Sub

	Function SearchValueIsNumeric(Fld, Value)
		Dim wrkValue
		wrkValue = Value
		If ew_IsFloatFormat(Fld.FldType) Then wrkValue = ew_StrToFloat(wrkValue)
		SearchValueIsNumeric = IsNumeric(Value)
	End Function

	' -----------------------------------------------------------------
	'  Load search values for validation
	'
	Function LoadSearchValues()

		' Load search values
		vouchercodes.ID.AdvancedSearch.SearchValue = ObjForm.GetValue("x_ID")
		vouchercodes.ID.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_ID")
		vouchercodes.vouchercode.AdvancedSearch.SearchValue = ObjForm.GetValue("x_vouchercode")
		vouchercodes.vouchercode.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_vouchercode")
		vouchercodes.vouchercodediscount.AdvancedSearch.SearchValue = ObjForm.GetValue("x_vouchercodediscount")
		vouchercodes.vouchercodediscount.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_vouchercodediscount")
		vouchercodes.vouchertype.AdvancedSearch.SearchValue = ObjForm.GetValue("x_vouchertype")
		vouchercodes.vouchertype.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_vouchertype")
		vouchercodes.startdate.AdvancedSearch.SearchValue = ObjForm.GetValue("x_startdate")
		vouchercodes.startdate.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_startdate")
		vouchercodes.enddate.AdvancedSearch.SearchValue = ObjForm.GetValue("x_enddate")
		vouchercodes.enddate.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_enddate")
		vouchercodes.IdBusinessDetail.AdvancedSearch.SearchValue = ObjForm.GetValue("x_IdBusinessDetail")
		vouchercodes.IdBusinessDetail.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_IdBusinessDetail")
		vouchercodes.MinimumAmount.AdvancedSearch.SearchValue = ObjForm.GetValue("x_MinimumAmount")
		vouchercodes.MinimumAmount.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_MinimumAmount")
		vouchercodes.MenuItemID.AdvancedSearch.SearchValue = ObjForm.GetValue("x_MenuItemID")
		vouchercodes.MenuItemID.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_MenuItemID")
		vouchercodes.VoucherMainType.AdvancedSearch.SearchValue = ObjForm.GetValue("x_VoucherMainType")
		vouchercodes.VoucherMainType.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_VoucherMainType")
	End Function

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
			' ID

			vouchercodes.ID.LinkCustomAttributes = ""
			vouchercodes.ID.HrefValue = ""
			vouchercodes.ID.TooltipValue = ""

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

		' ------------
		'  Search Row
		' ------------

		ElseIf vouchercodes.RowType = EW_ROWTYPE_SEARCH Then ' Search row

			' ID
			vouchercodes.ID.EditAttrs.UpdateAttribute "class", "form-control"
			vouchercodes.ID.EditCustomAttributes = ""
			vouchercodes.ID.EditValue = ew_HtmlEncode(vouchercodes.ID.AdvancedSearch.SearchValue)
			vouchercodes.ID.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(vouchercodes.ID.FldCaption))

			' vouchercode
			vouchercodes.vouchercode.EditAttrs.UpdateAttribute "class", "form-control"
			vouchercodes.vouchercode.EditCustomAttributes = ""
			vouchercodes.vouchercode.EditValue = ew_HtmlEncode(vouchercodes.vouchercode.AdvancedSearch.SearchValue)
			vouchercodes.vouchercode.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(vouchercodes.vouchercode.FldCaption))

			' vouchercodediscount
			vouchercodes.vouchercodediscount.EditAttrs.UpdateAttribute "class", "form-control"
			vouchercodes.vouchercodediscount.EditCustomAttributes = ""
			vouchercodes.vouchercodediscount.EditValue = ew_HtmlEncode(vouchercodes.vouchercodediscount.AdvancedSearch.SearchValue)
			vouchercodes.vouchercodediscount.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(vouchercodes.vouchercodediscount.FldCaption))

			' vouchertype
			vouchercodes.vouchertype.EditAttrs.UpdateAttribute "class", "form-control"
			vouchercodes.vouchertype.EditCustomAttributes = ""
			vouchercodes.vouchertype.EditValue = ew_HtmlEncode(vouchercodes.vouchertype.AdvancedSearch.SearchValue)
			vouchercodes.vouchertype.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(vouchercodes.vouchertype.FldCaption))

			' startdate
			vouchercodes.startdate.EditAttrs.UpdateAttribute "class", "form-control"
			vouchercodes.startdate.EditCustomAttributes = ""
			vouchercodes.startdate.EditValue = ew_HtmlEncode(vouchercodes.startdate.AdvancedSearch.SearchValue)
			vouchercodes.startdate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(vouchercodes.startdate.FldCaption))

			' enddate
			vouchercodes.enddate.EditAttrs.UpdateAttribute "class", "form-control"
			vouchercodes.enddate.EditCustomAttributes = ""
			vouchercodes.enddate.EditValue = ew_HtmlEncode(vouchercodes.enddate.AdvancedSearch.SearchValue)
			vouchercodes.enddate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(vouchercodes.enddate.FldCaption))

			' IdBusinessDetail
			vouchercodes.IdBusinessDetail.EditAttrs.UpdateAttribute "class", "form-control"
			vouchercodes.IdBusinessDetail.EditCustomAttributes = ""
			vouchercodes.IdBusinessDetail.EditValue = ew_HtmlEncode(vouchercodes.IdBusinessDetail.AdvancedSearch.SearchValue)
			vouchercodes.IdBusinessDetail.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(vouchercodes.IdBusinessDetail.FldCaption))

			' MinimumAmount
			vouchercodes.MinimumAmount.EditAttrs.UpdateAttribute "class", "form-control"
			vouchercodes.MinimumAmount.EditCustomAttributes = ""
			vouchercodes.MinimumAmount.EditValue = ew_HtmlEncode(vouchercodes.MinimumAmount.AdvancedSearch.SearchValue)
			vouchercodes.MinimumAmount.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(vouchercodes.MinimumAmount.FldCaption))

			' MenuItemID
			vouchercodes.MenuItemID.EditAttrs.UpdateAttribute "class", "form-control"
			vouchercodes.MenuItemID.EditCustomAttributes = ""
			vouchercodes.MenuItemID.EditValue = ew_HtmlEncode(vouchercodes.MenuItemID.AdvancedSearch.SearchValue)
			vouchercodes.MenuItemID.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(vouchercodes.MenuItemID.FldCaption))

			' VoucherMainType
			vouchercodes.VoucherMainType.EditAttrs.UpdateAttribute "class", "form-control"
			vouchercodes.VoucherMainType.EditCustomAttributes = ""
			vouchercodes.VoucherMainType.EditValue = ew_HtmlEncode(vouchercodes.VoucherMainType.AdvancedSearch.SearchValue)
			vouchercodes.VoucherMainType.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(vouchercodes.VoucherMainType.FldCaption))
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
	' Validate search
	'
	Function ValidateSearch()

		' Initialize
		gsSearchError = ""

		' Check if validation required
		If Not EW_SERVER_VALIDATE Then
			ValidateSearch = True
			Exit Function
		End If
		If Not ew_CheckInteger(vouchercodes.ID.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, vouchercodes.ID.FldErrMsg)
		End If
		If Not ew_CheckInteger(vouchercodes.vouchercodediscount.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, vouchercodes.vouchercodediscount.FldErrMsg)
		End If
		If Not ew_CheckInteger(vouchercodes.IdBusinessDetail.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, vouchercodes.IdBusinessDetail.FldErrMsg)
		End If
		If Not ew_CheckNumber(vouchercodes.MinimumAmount.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, vouchercodes.MinimumAmount.FldErrMsg)
		End If
		If Not ew_CheckInteger(vouchercodes.MenuItemID.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, vouchercodes.MenuItemID.FldErrMsg)
		End If

		' Return validate result
		ValidateSearch = (gsSearchError = "")

		' Call Form Custom Validate event
		Dim sFormCustomError
		sFormCustomError = ""
		ValidateSearch = ValidateSearch And Form_CustomValidate(sFormCustomError)
		If sFormCustomError <> "" Then
			Call ew_AddMessage(gsSearchError, sFormCustomError)
		End If
	End Function

	' -----------------------------------------------------------------
	' Load advanced search
	'
	Function LoadAdvancedSearch()
		Call vouchercodes.ID.AdvancedSearch.Load()
		Call vouchercodes.vouchercode.AdvancedSearch.Load()
		Call vouchercodes.vouchercodediscount.AdvancedSearch.Load()
		Call vouchercodes.vouchertype.AdvancedSearch.Load()
		Call vouchercodes.startdate.AdvancedSearch.Load()
		Call vouchercodes.enddate.AdvancedSearch.Load()
		Call vouchercodes.IdBusinessDetail.AdvancedSearch.Load()
		Call vouchercodes.MinimumAmount.AdvancedSearch.Load()
		Call vouchercodes.MenuItemID.AdvancedSearch.Load()
		Call vouchercodes.VoucherMainType.AdvancedSearch.Load()
End Function

	' Set up Breadcrumb
	Sub SetupBreadcrumb()
		Dim PageId, url
		Set Breadcrumb = New cBreadcrumb
		url = Mid(ew_CurrentUrl, InStrRev(ew_CurrentUrl, "/")+1)
		Call Breadcrumb.Add("list", vouchercodes.TableVar, "vouchercodeslist.asp", "", vouchercodes.TableVar, True)
		PageId = "search"
		Call Breadcrumb.Add("search", PageId, url, "", "", False)
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
