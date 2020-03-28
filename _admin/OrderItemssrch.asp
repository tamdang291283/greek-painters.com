<%@ CodePage="65001" %>
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
Dim OrderItems_search
Set OrderItems_search = New cOrderItems_search
Set Page = OrderItems_search

' Page init processing
OrderItems_search.Page_Init()

' Page main processing
OrderItems_search.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
OrderItems_search.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var OrderItems_search = new ew_Page("OrderItems_search");
OrderItems_search.PageID = "search"; // Page ID
var EW_PAGE_ID = OrderItems_search.PageID; // For backward compatibility
// Form object
var fOrderItemssearch = new ew_Form("fOrderItemssearch");
// Form_CustomValidate event
fOrderItemssearch.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fOrderItemssearch.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fOrderItemssearch.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
// Validate function for search
fOrderItemssearch.Validate = function(fobj) {
	if (!this.ValidateRequired)
		return true; // Ignore validation
	fobj = fobj || this.Form;
	this.PostAutoSuggest();
	var infix = "";
	elm = this.GetElements("x" + infix + "_ID");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(OrderItems.ID.FldErrMsg) %>");
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
	return true;
}
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<% If Not OrderItems_search.IsModal Then %>
<div class="ewToolbar">
<% If OrderItems.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If OrderItems.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% End If %>
<% OrderItems_search.ShowPageHeader() %>
<% OrderItems_search.ShowMessage %>
<form name="fOrderItemssearch" id="fOrderItemssearch" class="form-horizontal ewForm ewSearchForm" action="<%= ew_CurrentPage %>" method="post">
<% If OrderItems_search.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= OrderItems_search.Token %>">
<% End If %>
<input type="hidden" name="t" value="OrderItems">
<input type="hidden" name="a_search" id="a_search" value="S">
<% If OrderItems_search.IsModal Then %>
<input type="hidden" name="modal" value="1">
<% End If %>
<div>
<% If OrderItems.ID.Visible Then ' ID %>
	<div id="r_ID" class="form-group">
		<label for="x_ID" class="<%= OrderItems_search.SearchLabelClass %>"><span id="elh_OrderItems_ID"><%= OrderItems.ID.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_ID" id="z_ID" value="="></p>
		</label>
		<div class="<%= OrderItems_search.SearchRightColumnClass %>"><div<%= OrderItems.ID.CellAttributes %>>
			<span id="el_OrderItems_ID">
<input type="text" data-field="x_ID" name="x_ID" id="x_ID" placeholder="<%= OrderItems.ID.PlaceHolder %>" value="<%= OrderItems.ID.EditValue %>"<%= OrderItems.ID.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrderItems.OrderId.Visible Then ' OrderId %>
	<div id="r_OrderId" class="form-group">
		<label for="x_OrderId" class="<%= OrderItems_search.SearchLabelClass %>"><span id="elh_OrderItems_OrderId"><%= OrderItems.OrderId.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_OrderId" id="z_OrderId" value="="></p>
		</label>
		<div class="<%= OrderItems_search.SearchRightColumnClass %>"><div<%= OrderItems.OrderId.CellAttributes %>>
			<span id="el_OrderItems_OrderId">
<input type="text" data-field="x_OrderId" name="x_OrderId" id="x_OrderId" size="30" placeholder="<%= OrderItems.OrderId.PlaceHolder %>" value="<%= OrderItems.OrderId.EditValue %>"<%= OrderItems.OrderId.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrderItems.MenuItemId.Visible Then ' MenuItemId %>
	<div id="r_MenuItemId" class="form-group">
		<label for="x_MenuItemId" class="<%= OrderItems_search.SearchLabelClass %>"><span id="elh_OrderItems_MenuItemId"><%= OrderItems.MenuItemId.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_MenuItemId" id="z_MenuItemId" value="="></p>
		</label>
		<div class="<%= OrderItems_search.SearchRightColumnClass %>"><div<%= OrderItems.MenuItemId.CellAttributes %>>
			<span id="el_OrderItems_MenuItemId">
<input type="text" data-field="x_MenuItemId" name="x_MenuItemId" id="x_MenuItemId" size="30" placeholder="<%= OrderItems.MenuItemId.PlaceHolder %>" value="<%= OrderItems.MenuItemId.EditValue %>"<%= OrderItems.MenuItemId.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrderItems.MenuItemPropertyId.Visible Then ' MenuItemPropertyId %>
	<div id="r_MenuItemPropertyId" class="form-group">
		<label for="x_MenuItemPropertyId" class="<%= OrderItems_search.SearchLabelClass %>"><span id="elh_OrderItems_MenuItemPropertyId"><%= OrderItems.MenuItemPropertyId.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_MenuItemPropertyId" id="z_MenuItemPropertyId" value="="></p>
		</label>
		<div class="<%= OrderItems_search.SearchRightColumnClass %>"><div<%= OrderItems.MenuItemPropertyId.CellAttributes %>>
			<span id="el_OrderItems_MenuItemPropertyId">
<input type="text" data-field="x_MenuItemPropertyId" name="x_MenuItemPropertyId" id="x_MenuItemPropertyId" size="30" placeholder="<%= OrderItems.MenuItemPropertyId.PlaceHolder %>" value="<%= OrderItems.MenuItemPropertyId.EditValue %>"<%= OrderItems.MenuItemPropertyId.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrderItems.Qta.Visible Then ' Qta %>
	<div id="r_Qta" class="form-group">
		<label for="x_Qta" class="<%= OrderItems_search.SearchLabelClass %>"><span id="elh_OrderItems_Qta"><%= OrderItems.Qta.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_Qta" id="z_Qta" value="="></p>
		</label>
		<div class="<%= OrderItems_search.SearchRightColumnClass %>"><div<%= OrderItems.Qta.CellAttributes %>>
			<span id="el_OrderItems_Qta">
<input type="text" data-field="x_Qta" name="x_Qta" id="x_Qta" size="30" placeholder="<%= OrderItems.Qta.PlaceHolder %>" value="<%= OrderItems.Qta.EditValue %>"<%= OrderItems.Qta.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrderItems.Price.Visible Then ' Price %>
	<div id="r_Price" class="form-group">
		<label for="x_Price" class="<%= OrderItems_search.SearchLabelClass %>"><span id="elh_OrderItems_Price"><%= OrderItems.Price.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_Price" id="z_Price" value="="></p>
		</label>
		<div class="<%= OrderItems_search.SearchRightColumnClass %>"><div<%= OrderItems.Price.CellAttributes %>>
			<span id="el_OrderItems_Price">
<input type="text" data-field="x_Price" name="x_Price" id="x_Price" size="30" placeholder="<%= OrderItems.Price.PlaceHolder %>" value="<%= OrderItems.Price.EditValue %>"<%= OrderItems.Price.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrderItems.Total.Visible Then ' Total %>
	<div id="r_Total" class="form-group">
		<label for="x_Total" class="<%= OrderItems_search.SearchLabelClass %>"><span id="elh_OrderItems_Total"><%= OrderItems.Total.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_Total" id="z_Total" value="="></p>
		</label>
		<div class="<%= OrderItems_search.SearchRightColumnClass %>"><div<%= OrderItems.Total.CellAttributes %>>
			<span id="el_OrderItems_Total">
<input type="text" data-field="x_Total" name="x_Total" id="x_Total" size="30" placeholder="<%= OrderItems.Total.PlaceHolder %>" value="<%= OrderItems.Total.EditValue %>"<%= OrderItems.Total.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrderItems.toppingids.Visible Then ' toppingids %>
	<div id="r_toppingids" class="form-group">
		<label for="x_toppingids" class="<%= OrderItems_search.SearchLabelClass %>"><span id="elh_OrderItems_toppingids"><%= OrderItems.toppingids.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_toppingids" id="z_toppingids" value="LIKE"></p>
		</label>
		<div class="<%= OrderItems_search.SearchRightColumnClass %>"><div<%= OrderItems.toppingids.CellAttributes %>>
			<span id="el_OrderItems_toppingids">
<input type="text" data-field="x_toppingids" name="x_toppingids" id="x_toppingids" size="30" maxlength="255" placeholder="<%= OrderItems.toppingids.PlaceHolder %>" value="<%= OrderItems.toppingids.EditValue %>"<%= OrderItems.toppingids.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrderItems.dishpropertiesids.Visible Then ' dishpropertiesids %>
	<div id="r_dishpropertiesids" class="form-group">
		<label for="x_dishpropertiesids" class="<%= OrderItems_search.SearchLabelClass %>"><span id="elh_OrderItems_dishpropertiesids"><%= OrderItems.dishpropertiesids.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_dishpropertiesids" id="z_dishpropertiesids" value="LIKE"></p>
		</label>
		<div class="<%= OrderItems_search.SearchRightColumnClass %>"><div<%= OrderItems.dishpropertiesids.CellAttributes %>>
			<span id="el_OrderItems_dishpropertiesids">
<input type="text" data-field="x_dishpropertiesids" name="x_dishpropertiesids" id="x_dishpropertiesids" size="30" maxlength="255" placeholder="<%= OrderItems.dishpropertiesids.PlaceHolder %>" value="<%= OrderItems.dishpropertiesids.EditValue %>"<%= OrderItems.dishpropertiesids.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
</div>
<% If Not OrderItems_search.IsModal Then %>
<div class="form-group">
	<div class="col-sm-offset-3 col-sm-9">
<button class="btn btn-primary ewButton" name="btnAction" id="btnAction" type="submit"><%= Language.Phrase("Search") %></button>
<button class="btn btn-default ewButton" name="btnReset" id="btnReset" type="button" onclick="ew_ClearForm(this.form);"><%= Language.Phrase("Reset") %></button>
	</div>
</div>
<% End If %>
</form>
<script type="text/javascript">
fOrderItemssearch.Init();
</script>
<%
OrderItems_search.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set OrderItems_search = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cOrderItems_search

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
		TableName = "OrderItems"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "OrderItems_search"
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
		EW_PAGE_ID = "search"

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
		OrderItems.ID.Visible = Not OrderItems.IsAdd() And Not OrderItems.IsCopy() And Not OrderItems.IsGridAdd()

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
			OrderItems.CurrentAction = ObjForm.GetValue("a_search")
			Select Case OrderItems.CurrentAction
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
						sSrchStr = OrderItems.UrlParm(sSrchStr)
						sSrchStr = "OrderItemslist.asp" & "?" & sSrchStr
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
		OrderItems.RowType = EW_ROWTYPE_SEARCH
		Call RenderRow()
	End Sub

	' -----------------------------------------------------------------
	' Build advanced search
	'
	Function BuildAdvancedSearch()
		Dim sSrchUrl
		sSrchUrl = ""
		Call BuildSearchUrl(sSrchUrl, OrderItems.ID, False) ' ID
		Call BuildSearchUrl(sSrchUrl, OrderItems.OrderId, False) ' OrderId
		Call BuildSearchUrl(sSrchUrl, OrderItems.MenuItemId, False) ' MenuItemId
		Call BuildSearchUrl(sSrchUrl, OrderItems.MenuItemPropertyId, False) ' MenuItemPropertyId
		Call BuildSearchUrl(sSrchUrl, OrderItems.Qta, False) ' Qta
		Call BuildSearchUrl(sSrchUrl, OrderItems.Price, False) ' Price
		Call BuildSearchUrl(sSrchUrl, OrderItems.Total, False) ' Total
		Call BuildSearchUrl(sSrchUrl, OrderItems.toppingids, False) ' toppingids
		Call BuildSearchUrl(sSrchUrl, OrderItems.dishpropertiesids, False) ' dishpropertiesids
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
		OrderItems.ID.AdvancedSearch.SearchValue = ObjForm.GetValue("x_ID")
		OrderItems.ID.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_ID")
		OrderItems.OrderId.AdvancedSearch.SearchValue = ObjForm.GetValue("x_OrderId")
		OrderItems.OrderId.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_OrderId")
		OrderItems.MenuItemId.AdvancedSearch.SearchValue = ObjForm.GetValue("x_MenuItemId")
		OrderItems.MenuItemId.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_MenuItemId")
		OrderItems.MenuItemPropertyId.AdvancedSearch.SearchValue = ObjForm.GetValue("x_MenuItemPropertyId")
		OrderItems.MenuItemPropertyId.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_MenuItemPropertyId")
		OrderItems.Qta.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Qta")
		OrderItems.Qta.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Qta")
		OrderItems.Price.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Price")
		OrderItems.Price.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Price")
		OrderItems.Total.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Total")
		OrderItems.Total.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Total")
		OrderItems.toppingids.AdvancedSearch.SearchValue = ObjForm.GetValue("x_toppingids")
		OrderItems.toppingids.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_toppingids")
		OrderItems.dishpropertiesids.AdvancedSearch.SearchValue = ObjForm.GetValue("x_dishpropertiesids")
		OrderItems.dishpropertiesids.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_dishpropertiesids")
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
			' ID

			OrderItems.ID.LinkCustomAttributes = ""
			OrderItems.ID.HrefValue = ""
			OrderItems.ID.TooltipValue = ""

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

		' ------------
		'  Search Row
		' ------------

		ElseIf OrderItems.RowType = EW_ROWTYPE_SEARCH Then ' Search row

			' ID
			OrderItems.ID.EditAttrs.UpdateAttribute "class", "form-control"
			OrderItems.ID.EditCustomAttributes = ""
			OrderItems.ID.EditValue = ew_HtmlEncode(OrderItems.ID.AdvancedSearch.SearchValue)
			OrderItems.ID.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrderItems.ID.FldCaption))

			' OrderId
			OrderItems.OrderId.EditAttrs.UpdateAttribute "class", "form-control"
			OrderItems.OrderId.EditCustomAttributes = ""
			OrderItems.OrderId.EditValue = ew_HtmlEncode(OrderItems.OrderId.AdvancedSearch.SearchValue)
			OrderItems.OrderId.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrderItems.OrderId.FldCaption))

			' MenuItemId
			OrderItems.MenuItemId.EditAttrs.UpdateAttribute "class", "form-control"
			OrderItems.MenuItemId.EditCustomAttributes = ""
			OrderItems.MenuItemId.EditValue = ew_HtmlEncode(OrderItems.MenuItemId.AdvancedSearch.SearchValue)
			OrderItems.MenuItemId.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrderItems.MenuItemId.FldCaption))

			' MenuItemPropertyId
			OrderItems.MenuItemPropertyId.EditAttrs.UpdateAttribute "class", "form-control"
			OrderItems.MenuItemPropertyId.EditCustomAttributes = ""
			OrderItems.MenuItemPropertyId.EditValue = ew_HtmlEncode(OrderItems.MenuItemPropertyId.AdvancedSearch.SearchValue)
			OrderItems.MenuItemPropertyId.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrderItems.MenuItemPropertyId.FldCaption))

			' Qta
			OrderItems.Qta.EditAttrs.UpdateAttribute "class", "form-control"
			OrderItems.Qta.EditCustomAttributes = ""
			OrderItems.Qta.EditValue = ew_HtmlEncode(OrderItems.Qta.AdvancedSearch.SearchValue)
			OrderItems.Qta.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrderItems.Qta.FldCaption))

			' Price
			OrderItems.Price.EditAttrs.UpdateAttribute "class", "form-control"
			OrderItems.Price.EditCustomAttributes = ""
			OrderItems.Price.EditValue = ew_HtmlEncode(OrderItems.Price.AdvancedSearch.SearchValue)
			OrderItems.Price.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrderItems.Price.FldCaption))

			' Total
			OrderItems.Total.EditAttrs.UpdateAttribute "class", "form-control"
			OrderItems.Total.EditCustomAttributes = ""
			OrderItems.Total.EditValue = ew_HtmlEncode(OrderItems.Total.AdvancedSearch.SearchValue)
			OrderItems.Total.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrderItems.Total.FldCaption))

			' toppingids
			OrderItems.toppingids.EditAttrs.UpdateAttribute "class", "form-control"
			OrderItems.toppingids.EditCustomAttributes = ""
			OrderItems.toppingids.EditValue = ew_HtmlEncode(OrderItems.toppingids.AdvancedSearch.SearchValue)
			OrderItems.toppingids.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrderItems.toppingids.FldCaption))

			' dishpropertiesids
			OrderItems.dishpropertiesids.EditAttrs.UpdateAttribute "class", "form-control"
			OrderItems.dishpropertiesids.EditCustomAttributes = ""
			OrderItems.dishpropertiesids.EditValue = ew_HtmlEncode(OrderItems.dishpropertiesids.AdvancedSearch.SearchValue)
			OrderItems.dishpropertiesids.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrderItems.dishpropertiesids.FldCaption))
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
		If Not ew_CheckInteger(OrderItems.ID.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, OrderItems.ID.FldErrMsg)
		End If
		If Not ew_CheckInteger(OrderItems.OrderId.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, OrderItems.OrderId.FldErrMsg)
		End If
		If Not ew_CheckInteger(OrderItems.MenuItemId.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, OrderItems.MenuItemId.FldErrMsg)
		End If
		If Not ew_CheckInteger(OrderItems.MenuItemPropertyId.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, OrderItems.MenuItemPropertyId.FldErrMsg)
		End If
		If Not ew_CheckInteger(OrderItems.Qta.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, OrderItems.Qta.FldErrMsg)
		End If
		If Not ew_CheckNumber(OrderItems.Price.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, OrderItems.Price.FldErrMsg)
		End If
		If Not ew_CheckNumber(OrderItems.Total.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, OrderItems.Total.FldErrMsg)
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
		Call OrderItems.ID.AdvancedSearch.Load()
		Call OrderItems.OrderId.AdvancedSearch.Load()
		Call OrderItems.MenuItemId.AdvancedSearch.Load()
		Call OrderItems.MenuItemPropertyId.AdvancedSearch.Load()
		Call OrderItems.Qta.AdvancedSearch.Load()
		Call OrderItems.Price.AdvancedSearch.Load()
		Call OrderItems.Total.AdvancedSearch.Load()
		Call OrderItems.toppingids.AdvancedSearch.Load()
		Call OrderItems.dishpropertiesids.AdvancedSearch.Load()
End Function

	' Set up Breadcrumb
	Sub SetupBreadcrumb()
		Dim PageId, url
		Set Breadcrumb = New cBreadcrumb
		url = Mid(ew_CurrentUrl, InStrRev(ew_CurrentUrl, "/")+1)
		Call Breadcrumb.Add("list", OrderItems.TableVar, "OrderItemslist.asp", "", OrderItems.TableVar, True)
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
