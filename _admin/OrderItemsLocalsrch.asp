﻿<%@ CodePage="65001" %>
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
Dim OrderItemsLocal_search
Set OrderItemsLocal_search = New cOrderItemsLocal_search
Set Page = OrderItemsLocal_search

' Page init processing
OrderItemsLocal_search.Page_Init()

' Page main processing
OrderItemsLocal_search.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
OrderItemsLocal_search.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var OrderItemsLocal_search = new ew_Page("OrderItemsLocal_search");
OrderItemsLocal_search.PageID = "search"; // Page ID
var EW_PAGE_ID = OrderItemsLocal_search.PageID; // For backward compatibility
// Form object
var fOrderItemsLocalsearch = new ew_Form("fOrderItemsLocalsearch");
// Form_CustomValidate event
fOrderItemsLocalsearch.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fOrderItemsLocalsearch.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fOrderItemsLocalsearch.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
// Validate function for search
fOrderItemsLocalsearch.Validate = function(fobj) {
	if (!this.ValidateRequired)
		return true; // Ignore validation
	fobj = fobj || this.Form;
	this.PostAutoSuggest();
	var infix = "";
	elm = this.GetElements("x" + infix + "_ID");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(OrderItemsLocal.ID.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_OrderId");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(OrderItemsLocal.OrderId.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_MenuItemId");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(OrderItemsLocal.MenuItemId.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_MenuItemPropertyId");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(OrderItemsLocal.MenuItemPropertyId.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_Qta");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(OrderItemsLocal.Qta.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_Price");
	if (elm && !ew_CheckNumber(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(OrderItemsLocal.Price.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_Total");
	if (elm && !ew_CheckNumber(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(OrderItemsLocal.Total.FldErrMsg) %>");
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
<% If Not OrderItemsLocal_search.IsModal Then %>
<div class="ewToolbar">
<% If OrderItemsLocal.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If OrderItemsLocal.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% End If %>
<% OrderItemsLocal_search.ShowPageHeader() %>
<% OrderItemsLocal_search.ShowMessage %>
<form name="fOrderItemsLocalsearch" id="fOrderItemsLocalsearch" class="form-horizontal ewForm ewSearchForm" action="<%= ew_CurrentPage %>" method="post">
<% If OrderItemsLocal_search.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= OrderItemsLocal_search.Token %>">
<% End If %>
<input type="hidden" name="t" value="OrderItemsLocal">
<input type="hidden" name="a_search" id="a_search" value="S">
<% If OrderItemsLocal_search.IsModal Then %>
<input type="hidden" name="modal" value="1">
<% End If %>
<div>
<% If OrderItemsLocal.ID.Visible Then ' ID %>
	<div id="r_ID" class="form-group">
		<label for="x_ID" class="<%= OrderItemsLocal_search.SearchLabelClass %>"><span id="elh_OrderItemsLocal_ID"><%= OrderItemsLocal.ID.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_ID" id="z_ID" value="="></p>
		</label>
		<div class="<%= OrderItemsLocal_search.SearchRightColumnClass %>"><div<%= OrderItemsLocal.ID.CellAttributes %>>
			<span id="el_OrderItemsLocal_ID">
<input type="text" data-field="x_ID" name="x_ID" id="x_ID" placeholder="<%= OrderItemsLocal.ID.PlaceHolder %>" value="<%= OrderItemsLocal.ID.EditValue %>"<%= OrderItemsLocal.ID.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrderItemsLocal.OrderId.Visible Then ' OrderId %>
	<div id="r_OrderId" class="form-group">
		<label for="x_OrderId" class="<%= OrderItemsLocal_search.SearchLabelClass %>"><span id="elh_OrderItemsLocal_OrderId"><%= OrderItemsLocal.OrderId.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_OrderId" id="z_OrderId" value="="></p>
		</label>
		<div class="<%= OrderItemsLocal_search.SearchRightColumnClass %>"><div<%= OrderItemsLocal.OrderId.CellAttributes %>>
			<span id="el_OrderItemsLocal_OrderId">
<input type="text" data-field="x_OrderId" name="x_OrderId" id="x_OrderId" size="30" placeholder="<%= OrderItemsLocal.OrderId.PlaceHolder %>" value="<%= OrderItemsLocal.OrderId.EditValue %>"<%= OrderItemsLocal.OrderId.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrderItemsLocal.MenuItemId.Visible Then ' MenuItemId %>
	<div id="r_MenuItemId" class="form-group">
		<label for="x_MenuItemId" class="<%= OrderItemsLocal_search.SearchLabelClass %>"><span id="elh_OrderItemsLocal_MenuItemId"><%= OrderItemsLocal.MenuItemId.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_MenuItemId" id="z_MenuItemId" value="="></p>
		</label>
		<div class="<%= OrderItemsLocal_search.SearchRightColumnClass %>"><div<%= OrderItemsLocal.MenuItemId.CellAttributes %>>
			<span id="el_OrderItemsLocal_MenuItemId">
<input type="text" data-field="x_MenuItemId" name="x_MenuItemId" id="x_MenuItemId" size="30" placeholder="<%= OrderItemsLocal.MenuItemId.PlaceHolder %>" value="<%= OrderItemsLocal.MenuItemId.EditValue %>"<%= OrderItemsLocal.MenuItemId.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrderItemsLocal.MenuItemPropertyId.Visible Then ' MenuItemPropertyId %>
	<div id="r_MenuItemPropertyId" class="form-group">
		<label for="x_MenuItemPropertyId" class="<%= OrderItemsLocal_search.SearchLabelClass %>"><span id="elh_OrderItemsLocal_MenuItemPropertyId"><%= OrderItemsLocal.MenuItemPropertyId.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_MenuItemPropertyId" id="z_MenuItemPropertyId" value="="></p>
		</label>
		<div class="<%= OrderItemsLocal_search.SearchRightColumnClass %>"><div<%= OrderItemsLocal.MenuItemPropertyId.CellAttributes %>>
			<span id="el_OrderItemsLocal_MenuItemPropertyId">
<input type="text" data-field="x_MenuItemPropertyId" name="x_MenuItemPropertyId" id="x_MenuItemPropertyId" size="30" placeholder="<%= OrderItemsLocal.MenuItemPropertyId.PlaceHolder %>" value="<%= OrderItemsLocal.MenuItemPropertyId.EditValue %>"<%= OrderItemsLocal.MenuItemPropertyId.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrderItemsLocal.Qta.Visible Then ' Qta %>
	<div id="r_Qta" class="form-group">
		<label for="x_Qta" class="<%= OrderItemsLocal_search.SearchLabelClass %>"><span id="elh_OrderItemsLocal_Qta"><%= OrderItemsLocal.Qta.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_Qta" id="z_Qta" value="="></p>
		</label>
		<div class="<%= OrderItemsLocal_search.SearchRightColumnClass %>"><div<%= OrderItemsLocal.Qta.CellAttributes %>>
			<span id="el_OrderItemsLocal_Qta">
<input type="text" data-field="x_Qta" name="x_Qta" id="x_Qta" size="30" placeholder="<%= OrderItemsLocal.Qta.PlaceHolder %>" value="<%= OrderItemsLocal.Qta.EditValue %>"<%= OrderItemsLocal.Qta.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrderItemsLocal.Price.Visible Then ' Price %>
	<div id="r_Price" class="form-group">
		<label for="x_Price" class="<%= OrderItemsLocal_search.SearchLabelClass %>"><span id="elh_OrderItemsLocal_Price"><%= OrderItemsLocal.Price.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_Price" id="z_Price" value="="></p>
		</label>
		<div class="<%= OrderItemsLocal_search.SearchRightColumnClass %>"><div<%= OrderItemsLocal.Price.CellAttributes %>>
			<span id="el_OrderItemsLocal_Price">
<input type="text" data-field="x_Price" name="x_Price" id="x_Price" size="30" placeholder="<%= OrderItemsLocal.Price.PlaceHolder %>" value="<%= OrderItemsLocal.Price.EditValue %>"<%= OrderItemsLocal.Price.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrderItemsLocal.Total.Visible Then ' Total %>
	<div id="r_Total" class="form-group">
		<label for="x_Total" class="<%= OrderItemsLocal_search.SearchLabelClass %>"><span id="elh_OrderItemsLocal_Total"><%= OrderItemsLocal.Total.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_Total" id="z_Total" value="="></p>
		</label>
		<div class="<%= OrderItemsLocal_search.SearchRightColumnClass %>"><div<%= OrderItemsLocal.Total.CellAttributes %>>
			<span id="el_OrderItemsLocal_Total">
<input type="text" data-field="x_Total" name="x_Total" id="x_Total" size="30" placeholder="<%= OrderItemsLocal.Total.PlaceHolder %>" value="<%= OrderItemsLocal.Total.EditValue %>"<%= OrderItemsLocal.Total.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrderItemsLocal.toppingids.Visible Then ' toppingids %>
	<div id="r_toppingids" class="form-group">
		<label for="x_toppingids" class="<%= OrderItemsLocal_search.SearchLabelClass %>"><span id="elh_OrderItemsLocal_toppingids"><%= OrderItemsLocal.toppingids.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_toppingids" id="z_toppingids" value="LIKE"></p>
		</label>
		<div class="<%= OrderItemsLocal_search.SearchRightColumnClass %>"><div<%= OrderItemsLocal.toppingids.CellAttributes %>>
			<span id="el_OrderItemsLocal_toppingids">
<input type="text" data-field="x_toppingids" name="x_toppingids" id="x_toppingids" size="30" maxlength="255" placeholder="<%= OrderItemsLocal.toppingids.PlaceHolder %>" value="<%= OrderItemsLocal.toppingids.EditValue %>"<%= OrderItemsLocal.toppingids.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrderItemsLocal.dishpropertiesids.Visible Then ' dishpropertiesids %>
	<div id="r_dishpropertiesids" class="form-group">
		<label for="x_dishpropertiesids" class="<%= OrderItemsLocal_search.SearchLabelClass %>"><span id="elh_OrderItemsLocal_dishpropertiesids"><%= OrderItemsLocal.dishpropertiesids.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_dishpropertiesids" id="z_dishpropertiesids" value="LIKE"></p>
		</label>
		<div class="<%= OrderItemsLocal_search.SearchRightColumnClass %>"><div<%= OrderItemsLocal.dishpropertiesids.CellAttributes %>>
			<span id="el_OrderItemsLocal_dishpropertiesids">
<input type="text" data-field="x_dishpropertiesids" name="x_dishpropertiesids" id="x_dishpropertiesids" size="30" maxlength="255" placeholder="<%= OrderItemsLocal.dishpropertiesids.PlaceHolder %>" value="<%= OrderItemsLocal.dishpropertiesids.EditValue %>"<%= OrderItemsLocal.dishpropertiesids.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
</div>
<% If Not OrderItemsLocal_search.IsModal Then %>
<div class="form-group">
	<div class="col-sm-offset-3 col-sm-9">
<button class="btn btn-primary ewButton" name="btnAction" id="btnAction" type="submit"><%= Language.Phrase("Search") %></button>
<button class="btn btn-default ewButton" name="btnReset" id="btnReset" type="button" onclick="ew_ClearForm(this.form);"><%= Language.Phrase("Reset") %></button>
	</div>
</div>
<% End If %>
</form>
<script type="text/javascript">
fOrderItemsLocalsearch.Init();
</script>
<%
OrderItemsLocal_search.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set OrderItemsLocal_search = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cOrderItemsLocal_search

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
		TableName = "OrderItemsLocal"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "OrderItemsLocal_search"
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
		EW_PAGE_ID = "search"

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
		OrderItemsLocal.ID.Visible = Not OrderItemsLocal.IsAdd() And Not OrderItemsLocal.IsCopy() And Not OrderItemsLocal.IsGridAdd()

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
			OrderItemsLocal.CurrentAction = ObjForm.GetValue("a_search")
			Select Case OrderItemsLocal.CurrentAction
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
						sSrchStr = OrderItemsLocal.UrlParm(sSrchStr)
						sSrchStr = "OrderItemsLocallist.asp" & "?" & sSrchStr
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
		OrderItemsLocal.RowType = EW_ROWTYPE_SEARCH
		Call RenderRow()
	End Sub

	' -----------------------------------------------------------------
	' Build advanced search
	'
	Function BuildAdvancedSearch()
		Dim sSrchUrl
		sSrchUrl = ""
		Call BuildSearchUrl(sSrchUrl, OrderItemsLocal.ID, False) ' ID
		Call BuildSearchUrl(sSrchUrl, OrderItemsLocal.OrderId, False) ' OrderId
		Call BuildSearchUrl(sSrchUrl, OrderItemsLocal.MenuItemId, False) ' MenuItemId
		Call BuildSearchUrl(sSrchUrl, OrderItemsLocal.MenuItemPropertyId, False) ' MenuItemPropertyId
		Call BuildSearchUrl(sSrchUrl, OrderItemsLocal.Qta, False) ' Qta
		Call BuildSearchUrl(sSrchUrl, OrderItemsLocal.Price, False) ' Price
		Call BuildSearchUrl(sSrchUrl, OrderItemsLocal.Total, False) ' Total
		Call BuildSearchUrl(sSrchUrl, OrderItemsLocal.toppingids, False) ' toppingids
		Call BuildSearchUrl(sSrchUrl, OrderItemsLocal.dishpropertiesids, False) ' dishpropertiesids
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
		OrderItemsLocal.ID.AdvancedSearch.SearchValue = ObjForm.GetValue("x_ID")
		OrderItemsLocal.ID.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_ID")
		OrderItemsLocal.OrderId.AdvancedSearch.SearchValue = ObjForm.GetValue("x_OrderId")
		OrderItemsLocal.OrderId.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_OrderId")
		OrderItemsLocal.MenuItemId.AdvancedSearch.SearchValue = ObjForm.GetValue("x_MenuItemId")
		OrderItemsLocal.MenuItemId.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_MenuItemId")
		OrderItemsLocal.MenuItemPropertyId.AdvancedSearch.SearchValue = ObjForm.GetValue("x_MenuItemPropertyId")
		OrderItemsLocal.MenuItemPropertyId.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_MenuItemPropertyId")
		OrderItemsLocal.Qta.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Qta")
		OrderItemsLocal.Qta.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Qta")
		OrderItemsLocal.Price.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Price")
		OrderItemsLocal.Price.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Price")
		OrderItemsLocal.Total.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Total")
		OrderItemsLocal.Total.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Total")
		OrderItemsLocal.toppingids.AdvancedSearch.SearchValue = ObjForm.GetValue("x_toppingids")
		OrderItemsLocal.toppingids.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_toppingids")
		OrderItemsLocal.dishpropertiesids.AdvancedSearch.SearchValue = ObjForm.GetValue("x_dishpropertiesids")
		OrderItemsLocal.dishpropertiesids.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_dishpropertiesids")
	End Function

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
			' ID

			OrderItemsLocal.ID.LinkCustomAttributes = ""
			OrderItemsLocal.ID.HrefValue = ""
			OrderItemsLocal.ID.TooltipValue = ""

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

		' ------------
		'  Search Row
		' ------------

		ElseIf OrderItemsLocal.RowType = EW_ROWTYPE_SEARCH Then ' Search row

			' ID
			OrderItemsLocal.ID.EditAttrs.UpdateAttribute "class", "form-control"
			OrderItemsLocal.ID.EditCustomAttributes = ""
			OrderItemsLocal.ID.EditValue = ew_HtmlEncode(OrderItemsLocal.ID.AdvancedSearch.SearchValue)
			OrderItemsLocal.ID.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrderItemsLocal.ID.FldCaption))

			' OrderId
			OrderItemsLocal.OrderId.EditAttrs.UpdateAttribute "class", "form-control"
			OrderItemsLocal.OrderId.EditCustomAttributes = ""
			OrderItemsLocal.OrderId.EditValue = ew_HtmlEncode(OrderItemsLocal.OrderId.AdvancedSearch.SearchValue)
			OrderItemsLocal.OrderId.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrderItemsLocal.OrderId.FldCaption))

			' MenuItemId
			OrderItemsLocal.MenuItemId.EditAttrs.UpdateAttribute "class", "form-control"
			OrderItemsLocal.MenuItemId.EditCustomAttributes = ""
			OrderItemsLocal.MenuItemId.EditValue = ew_HtmlEncode(OrderItemsLocal.MenuItemId.AdvancedSearch.SearchValue)
			OrderItemsLocal.MenuItemId.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrderItemsLocal.MenuItemId.FldCaption))

			' MenuItemPropertyId
			OrderItemsLocal.MenuItemPropertyId.EditAttrs.UpdateAttribute "class", "form-control"
			OrderItemsLocal.MenuItemPropertyId.EditCustomAttributes = ""
			OrderItemsLocal.MenuItemPropertyId.EditValue = ew_HtmlEncode(OrderItemsLocal.MenuItemPropertyId.AdvancedSearch.SearchValue)
			OrderItemsLocal.MenuItemPropertyId.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrderItemsLocal.MenuItemPropertyId.FldCaption))

			' Qta
			OrderItemsLocal.Qta.EditAttrs.UpdateAttribute "class", "form-control"
			OrderItemsLocal.Qta.EditCustomAttributes = ""
			OrderItemsLocal.Qta.EditValue = ew_HtmlEncode(OrderItemsLocal.Qta.AdvancedSearch.SearchValue)
			OrderItemsLocal.Qta.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrderItemsLocal.Qta.FldCaption))

			' Price
			OrderItemsLocal.Price.EditAttrs.UpdateAttribute "class", "form-control"
			OrderItemsLocal.Price.EditCustomAttributes = ""
			OrderItemsLocal.Price.EditValue = ew_HtmlEncode(OrderItemsLocal.Price.AdvancedSearch.SearchValue)
			OrderItemsLocal.Price.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrderItemsLocal.Price.FldCaption))

			' Total
			OrderItemsLocal.Total.EditAttrs.UpdateAttribute "class", "form-control"
			OrderItemsLocal.Total.EditCustomAttributes = ""
			OrderItemsLocal.Total.EditValue = ew_HtmlEncode(OrderItemsLocal.Total.AdvancedSearch.SearchValue)
			OrderItemsLocal.Total.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrderItemsLocal.Total.FldCaption))

			' toppingids
			OrderItemsLocal.toppingids.EditAttrs.UpdateAttribute "class", "form-control"
			OrderItemsLocal.toppingids.EditCustomAttributes = ""
			OrderItemsLocal.toppingids.EditValue = ew_HtmlEncode(OrderItemsLocal.toppingids.AdvancedSearch.SearchValue)
			OrderItemsLocal.toppingids.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrderItemsLocal.toppingids.FldCaption))

			' dishpropertiesids
			OrderItemsLocal.dishpropertiesids.EditAttrs.UpdateAttribute "class", "form-control"
			OrderItemsLocal.dishpropertiesids.EditCustomAttributes = ""
			OrderItemsLocal.dishpropertiesids.EditValue = ew_HtmlEncode(OrderItemsLocal.dishpropertiesids.AdvancedSearch.SearchValue)
			OrderItemsLocal.dishpropertiesids.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrderItemsLocal.dishpropertiesids.FldCaption))
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
		If Not ew_CheckInteger(OrderItemsLocal.ID.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, OrderItemsLocal.ID.FldErrMsg)
		End If
		If Not ew_CheckInteger(OrderItemsLocal.OrderId.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, OrderItemsLocal.OrderId.FldErrMsg)
		End If
		If Not ew_CheckInteger(OrderItemsLocal.MenuItemId.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, OrderItemsLocal.MenuItemId.FldErrMsg)
		End If
		If Not ew_CheckInteger(OrderItemsLocal.MenuItemPropertyId.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, OrderItemsLocal.MenuItemPropertyId.FldErrMsg)
		End If
		If Not ew_CheckInteger(OrderItemsLocal.Qta.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, OrderItemsLocal.Qta.FldErrMsg)
		End If
		If Not ew_CheckNumber(OrderItemsLocal.Price.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, OrderItemsLocal.Price.FldErrMsg)
		End If
		If Not ew_CheckNumber(OrderItemsLocal.Total.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, OrderItemsLocal.Total.FldErrMsg)
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
		Call OrderItemsLocal.ID.AdvancedSearch.Load()
		Call OrderItemsLocal.OrderId.AdvancedSearch.Load()
		Call OrderItemsLocal.MenuItemId.AdvancedSearch.Load()
		Call OrderItemsLocal.MenuItemPropertyId.AdvancedSearch.Load()
		Call OrderItemsLocal.Qta.AdvancedSearch.Load()
		Call OrderItemsLocal.Price.AdvancedSearch.Load()
		Call OrderItemsLocal.Total.AdvancedSearch.Load()
		Call OrderItemsLocal.toppingids.AdvancedSearch.Load()
		Call OrderItemsLocal.dishpropertiesids.AdvancedSearch.Load()
End Function

	' Set up Breadcrumb
	Sub SetupBreadcrumb()
		Dim PageId, url
		Set Breadcrumb = New cBreadcrumb
		url = Mid(ew_CurrentUrl, InStrRev(ew_CurrentUrl, "/")+1)
		Call Breadcrumb.Add("list", OrderItemsLocal.TableVar, "OrderItemsLocallist.asp", "", OrderItemsLocal.TableVar, True)
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
