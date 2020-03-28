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
Dim OrderItemsLocal_view
Set OrderItemsLocal_view = New cOrderItemsLocal_view
Set Page = OrderItemsLocal_view

' Page init processing
OrderItemsLocal_view.Page_Init()

' Page main processing
OrderItemsLocal_view.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
OrderItemsLocal_view.Page_Render()
%>
<!--#include file="header.asp"-->
<% If OrderItemsLocal.Export = "" Then %>
<script type="text/javascript">
// Page object
var OrderItemsLocal_view = new ew_Page("OrderItemsLocal_view");
OrderItemsLocal_view.PageID = "view"; // Page ID
var EW_PAGE_ID = OrderItemsLocal_view.PageID; // For backward compatibility
// Form object
var fOrderItemsLocalview = new ew_Form("fOrderItemsLocalview");
// Form_CustomValidate event
fOrderItemsLocalview.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fOrderItemsLocalview.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fOrderItemsLocalview.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<% End If %>
<% If OrderItemsLocal.Export = "" Then %>
<div class="ewToolbar">
<% If OrderItemsLocal.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<%
	OrderItemsLocal_view.ExportOptions.Render "body", "", "", "", "", ""
	OrderItemsLocal_view.ActionOptions.Render "body", "", "", "", "", ""
	OrderItemsLocal_view.DetailOptions.Render "body", "", "", "", "", ""
%>
<% If OrderItemsLocal.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% End If %>
<% OrderItemsLocal_view.ShowPageHeader() %>
<% OrderItemsLocal_view.ShowMessage %>
<% If OrderItemsLocal.Export = "" Then %>
<form name="ewPagerForm" class="form-inline ewForm ewPagerForm" action="<%= ew_CurrentPage %>">
<% If Not IsObject(OrderItemsLocal_view.Pager) Then Set OrderItemsLocal_view.Pager = ew_NewPrevNextPager(OrderItemsLocal_view.StartRec, OrderItemsLocal_view.DisplayRecs, OrderItemsLocal_view.TotalRecs) %>
<% If OrderItemsLocal_view.Pager.RecordCount > 0 Then %>
<div class="ewPager">
<span><%= Language.Phrase("Page") %>&nbsp;</span>
<div class="ewPrevNext"><div class="input-group">
<div class="input-group-btn">
<!--first page button-->
	<% If OrderItemsLocal_view.Pager.FirstButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerFirst") %>" href="<%= OrderItemsLocal_view.PageUrl %>start=<%= OrderItemsLocal_view.Pager.FirstButton.Start %>"><span class="icon-first ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerFirst") %>"><span class="icon-first ewIcon"></span></a>
	<% End If %>
<!--previous page button-->
	<% If OrderItemsLocal_view.Pager.PrevButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerPrevious") %>" href="<%= OrderItemsLocal_view.PageUrl %>start=<%= OrderItemsLocal_view.Pager.PrevButton.Start %>"><span class="icon-prev ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerPrevious") %>"><span class="icon-prev ewIcon"></span></a>
	<% End If %>
</div>
<!--current page number-->
	<input class="form-control input-sm" type="text" name="<%= EW_TABLE_PAGE_NO %>" value="<%= OrderItemsLocal_view.Pager.CurrentPage %>">
<div class="input-group-btn">
<!--next page button-->
	<% If OrderItemsLocal_view.Pager.NextButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerNext") %>" href="<%= OrderItemsLocal_view.PageUrl %>start=<%= OrderItemsLocal_view.Pager.NextButton.Start %>"><span class="icon-next ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerNext") %>"><span class="icon-next ewIcon"></span></a>
	<% End If %>
<!--last page button-->
	<% If OrderItemsLocal_view.Pager.LastButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerLast") %>" href="<%= OrderItemsLocal_view.PageUrl %>start=<%= OrderItemsLocal_view.Pager.LastButton.Start %>"><span class="icon-last ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerLast") %>"><span class="icon-last ewIcon"></span></a>
	<% End If %>
</div>
</div>
</div>
<span>&nbsp;<%= Language.Phrase("of") %>&nbsp;<%= OrderItemsLocal_view.Pager.PageCount %></span>
</div>
<% End If %>
<div class="clearfix"></div>
</form>
<% End If %>
<form name="fOrderItemsLocalview" id="fOrderItemsLocalview" class="form-inline ewForm ewViewForm" action="<%= ew_CurrentPage %>" method="post">
<% If OrderItemsLocal_view.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= OrderItemsLocal_view.Token %>">
<% End If %>
<input type="hidden" name="t" value="OrderItemsLocal">
<table class="table table-bordered table-striped ewViewTable">
<% If OrderItemsLocal.ID.Visible Then ' ID %>
	<tr id="r_ID">
		<td><span id="elh_OrderItemsLocal_ID"><%= OrderItemsLocal.ID.FldCaption %></span></td>
		<td<%= OrderItemsLocal.ID.CellAttributes %>>
<span id="el_OrderItemsLocal_ID" class="form-group">
<span<%= OrderItemsLocal.ID.ViewAttributes %>>
<%= OrderItemsLocal.ID.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrderItemsLocal.OrderId.Visible Then ' OrderId %>
	<tr id="r_OrderId">
		<td><span id="elh_OrderItemsLocal_OrderId"><%= OrderItemsLocal.OrderId.FldCaption %></span></td>
		<td<%= OrderItemsLocal.OrderId.CellAttributes %>>
<span id="el_OrderItemsLocal_OrderId" class="form-group">
<span<%= OrderItemsLocal.OrderId.ViewAttributes %>>
<%= OrderItemsLocal.OrderId.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrderItemsLocal.MenuItemId.Visible Then ' MenuItemId %>
	<tr id="r_MenuItemId">
		<td><span id="elh_OrderItemsLocal_MenuItemId"><%= OrderItemsLocal.MenuItemId.FldCaption %></span></td>
		<td<%= OrderItemsLocal.MenuItemId.CellAttributes %>>
<span id="el_OrderItemsLocal_MenuItemId" class="form-group">
<span<%= OrderItemsLocal.MenuItemId.ViewAttributes %>>
<%= OrderItemsLocal.MenuItemId.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrderItemsLocal.MenuItemPropertyId.Visible Then ' MenuItemPropertyId %>
	<tr id="r_MenuItemPropertyId">
		<td><span id="elh_OrderItemsLocal_MenuItemPropertyId"><%= OrderItemsLocal.MenuItemPropertyId.FldCaption %></span></td>
		<td<%= OrderItemsLocal.MenuItemPropertyId.CellAttributes %>>
<span id="el_OrderItemsLocal_MenuItemPropertyId" class="form-group">
<span<%= OrderItemsLocal.MenuItemPropertyId.ViewAttributes %>>
<%= OrderItemsLocal.MenuItemPropertyId.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrderItemsLocal.Qta.Visible Then ' Qta %>
	<tr id="r_Qta">
		<td><span id="elh_OrderItemsLocal_Qta"><%= OrderItemsLocal.Qta.FldCaption %></span></td>
		<td<%= OrderItemsLocal.Qta.CellAttributes %>>
<span id="el_OrderItemsLocal_Qta" class="form-group">
<span<%= OrderItemsLocal.Qta.ViewAttributes %>>
<%= OrderItemsLocal.Qta.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrderItemsLocal.Price.Visible Then ' Price %>
	<tr id="r_Price">
		<td><span id="elh_OrderItemsLocal_Price"><%= OrderItemsLocal.Price.FldCaption %></span></td>
		<td<%= OrderItemsLocal.Price.CellAttributes %>>
<span id="el_OrderItemsLocal_Price" class="form-group">
<span<%= OrderItemsLocal.Price.ViewAttributes %>>
<%= OrderItemsLocal.Price.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrderItemsLocal.Total.Visible Then ' Total %>
	<tr id="r_Total">
		<td><span id="elh_OrderItemsLocal_Total"><%= OrderItemsLocal.Total.FldCaption %></span></td>
		<td<%= OrderItemsLocal.Total.CellAttributes %>>
<span id="el_OrderItemsLocal_Total" class="form-group">
<span<%= OrderItemsLocal.Total.ViewAttributes %>>
<%= OrderItemsLocal.Total.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrderItemsLocal.toppingids.Visible Then ' toppingids %>
	<tr id="r_toppingids">
		<td><span id="elh_OrderItemsLocal_toppingids"><%= OrderItemsLocal.toppingids.FldCaption %></span></td>
		<td<%= OrderItemsLocal.toppingids.CellAttributes %>>
<span id="el_OrderItemsLocal_toppingids" class="form-group">
<span<%= OrderItemsLocal.toppingids.ViewAttributes %>>
<%= OrderItemsLocal.toppingids.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrderItemsLocal.dishpropertiesids.Visible Then ' dishpropertiesids %>
	<tr id="r_dishpropertiesids">
		<td><span id="elh_OrderItemsLocal_dishpropertiesids"><%= OrderItemsLocal.dishpropertiesids.FldCaption %></span></td>
		<td<%= OrderItemsLocal.dishpropertiesids.CellAttributes %>>
<span id="el_OrderItemsLocal_dishpropertiesids" class="form-group">
<span<%= OrderItemsLocal.dishpropertiesids.ViewAttributes %>>
<%= OrderItemsLocal.dishpropertiesids.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
</table>
<% If OrderItemsLocal.Export = "" Then %>
<% If Not IsObject(OrderItemsLocal_view.Pager) Then Set OrderItemsLocal_view.Pager = ew_NewPrevNextPager(OrderItemsLocal_view.StartRec, OrderItemsLocal_view.DisplayRecs, OrderItemsLocal_view.TotalRecs) %>
<% If OrderItemsLocal_view.Pager.RecordCount > 0 Then %>
<div class="ewPager">
<span><%= Language.Phrase("Page") %>&nbsp;</span>
<div class="ewPrevNext"><div class="input-group">
<div class="input-group-btn">
<!--first page button-->
	<% If OrderItemsLocal_view.Pager.FirstButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerFirst") %>" href="<%= OrderItemsLocal_view.PageUrl %>start=<%= OrderItemsLocal_view.Pager.FirstButton.Start %>"><span class="icon-first ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerFirst") %>"><span class="icon-first ewIcon"></span></a>
	<% End If %>
<!--previous page button-->
	<% If OrderItemsLocal_view.Pager.PrevButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerPrevious") %>" href="<%= OrderItemsLocal_view.PageUrl %>start=<%= OrderItemsLocal_view.Pager.PrevButton.Start %>"><span class="icon-prev ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerPrevious") %>"><span class="icon-prev ewIcon"></span></a>
	<% End If %>
</div>
<!--current page number-->
	<input class="form-control input-sm" type="text" name="<%= EW_TABLE_PAGE_NO %>" value="<%= OrderItemsLocal_view.Pager.CurrentPage %>">
<div class="input-group-btn">
<!--next page button-->
	<% If OrderItemsLocal_view.Pager.NextButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerNext") %>" href="<%= OrderItemsLocal_view.PageUrl %>start=<%= OrderItemsLocal_view.Pager.NextButton.Start %>"><span class="icon-next ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerNext") %>"><span class="icon-next ewIcon"></span></a>
	<% End If %>
<!--last page button-->
	<% If OrderItemsLocal_view.Pager.LastButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerLast") %>" href="<%= OrderItemsLocal_view.PageUrl %>start=<%= OrderItemsLocal_view.Pager.LastButton.Start %>"><span class="icon-last ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerLast") %>"><span class="icon-last ewIcon"></span></a>
	<% End If %>
</div>
</div>
</div>
<span>&nbsp;<%= Language.Phrase("of") %>&nbsp;<%= OrderItemsLocal_view.Pager.PageCount %></span>
</div>
<% End If %>
<div class="clearfix"></div>
<% End If %>
</form>
<% If OrderItemsLocal.Export <> "" Then %>
<script type="text/javascript">
ew_ApplyTemplate("body", "", "OrderItemsLocalview", "<%= OrderItemsLocal.CustomExport %>");
</script>
<% End If %>
<script type="text/javascript">
fOrderItemsLocalview.Init();
</script>
<%
OrderItemsLocal_view.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<% If OrderItemsLocal.Export = "" Then %>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<% End If %>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set OrderItemsLocal_view = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cOrderItemsLocal_view

	' Page ID
	Public Property Get PageID()
		PageID = "view"
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
		PageObjName = "OrderItemsLocal_view"
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

	' Common urls
	Dim AddUrl
	Dim EditUrl
	Dim CopyUrl
	Dim DeleteUrl
	Dim ViewUrl
	Dim ListUrl

	' Export urls
	Dim ExportPrintUrl
	Dim ExportHtmlUrl
	Dim ExportExcelUrl
	Dim ExportWordUrl
	Dim ExportXmlUrl
	Dim ExportCsvUrl
	Dim ExportPdfUrl

	' Custom export
	Dim ExportExcelCustom
	Dim ExportWordCustom
	Dim ExportPdfCustom
	Dim ExportEmailCustom

	' Inline urls
	Dim InlineAddUrl
	Dim InlineCopyUrl
	Dim InlineEditUrl
	Dim GridAddUrl
	Dim GridEditUrl
	Dim MultiDeleteUrl
	Dim MultiUpdateUrl

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
		ExportExcelCustom = False
		ExportWordCustom = False
		ExportPdfCustom = True ' Always use ew_ApplyTemplate
		ExportEmailCustom = True ' Always use ew_ApplyTemplate

		' Initialize urls
		Dim KeyUrl
		KeyUrl = ""
		If Request.QueryString("ID").Count > 0 Then
			ew_AddKey RecKey, "ID", Request.QueryString("ID")
			KeyUrl = KeyUrl & "&amp;ID=" & ew_Encode(Request.QueryString("ID"))
		End If
		ExportPrintUrl = PageUrl & "export=print" & KeyUrl
		ExportHtmlUrl = PageUrl & "export=html" & KeyUrl
		ExportExcelUrl = PageUrl & "export=excel" & KeyUrl
		ExportWordUrl = PageUrl & "export=word" & KeyUrl
		ExportXmlUrl = PageUrl & "export=xml" & KeyUrl
		ExportCsvUrl = PageUrl & "export=csv" & KeyUrl
		ExportPdfUrl = PageUrl & "export=pdf" & KeyUrl

		' Initialize form object
		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "view"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "OrderItemsLocal"

		' Open connection to the database
		If IsEmpty(Conn) Then Call ew_Connect()

		' Export options
		Set ExportOptions = New cListOptions
		ExportOptions.TableVar = OrderItemsLocal.TableVar
		ExportOptions.Tag = "div"
		ExportOptions.TagClassName = "ewExportOption"

		' Other options
		Set ActionOptions = New cListOptions
		ActionOptions.Tag = "div"
		ActionOptions.TagClassName = "ewActionOption"
		Set DetailOptions = New cListOptions
		DetailOptions.Tag = "div"
		DetailOptions.TagClassName = "ewDetailOption"
	End Sub

	' -----------------------------------------------------------------
	'  Subroutine Page_Init
	'  - called before page main
	'  - check Security
	'  - set up response header
	'  - call page load events
	'
	Sub Page_Init()

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

	Dim DbMasterFilter, DbDetailFilter
	Dim DisplayRecs ' Number of display records
	Dim StartRec, StopRec, TotalRecs, RecRange
	Dim RecCnt
	Dim RecKey
	Dim ExportOptions ' Export options
	Dim DetailOptions ' Other options (detail)
	Dim ActionOptions ' Other options (action)
	Dim Recordset

	' -----------------------------------------------------------------
	' Page main processing
	'
	Sub Page_Main()

		' Paging variables
		DisplayRecs = 1
		RecRange = 10

		' Load current record
		Dim bLoadCurrentRecord
		bLoadCurrentRecord = False
		Dim sReturnUrl
		sReturnUrl = ""
		Dim bMatchRecord
		bMatchRecord = False

		' Set up Breadcrumb
		If OrderItemsLocal.Export = "" Then
			SetupBreadcrumb()
		End If
		If IsPageRequest Then ' Validate request
			If Request.QueryString("ID").Count > 0 Then
				OrderItemsLocal.ID.QueryStringValue = Request.QueryString("ID")
			ElseIf Request.Form("ID").Count > 0 Then
				OrderItemsLocal.ID.FormValue = Request.Form("ID")
			Else
				bLoadCurrentRecord = True
			End If

			' Get action
			OrderItemsLocal.CurrentAction = "I" ' Display form
			Select Case OrderItemsLocal.CurrentAction
				Case "I" ' Get a record to display
					StartRec = 1 ' Initialize start position
					Set Recordset = LoadRecordset() ' Load records
					TotalRecs = Recordset.RecordCount ' Get record count
					If TotalRecs <= 0 Then ' No record found
						If SuccessMessage = "" And FailureMessage = "" Then
							FailureMessage = Language.Phrase("NoRecord") ' Set no record message
						End If
						sReturnUrl = "OrderItemsLocallist.asp"
					ElseIf bLoadCurrentRecord Then ' Load current record position
						SetUpStartRec() ' Set up start record position

						' Point to current record
						If CLng(StartRec) <= CLng(TotalRecs) Then
							bMatchRecord = True
							Recordset.Move StartRec-1
						End If
					Else ' Match key values
						Do While Not Recordset.Eof
							If CStr(OrderItemsLocal.ID.CurrentValue&"") = CStr(Recordset("ID")&"") Then
								OrderItemsLocal.StartRecordNumber = StartRec ' Save record position
								bMatchRecord = True
								Exit Do
							Else
								StartRec = StartRec + 1
								Recordset.MoveNext
							End If
						Loop
					End If
					If Not bMatchRecord Then
						If SuccessMessage = "" And FailureMessage = "" Then
							FailureMessage = Language.Phrase("NoRecord") ' Set no record message
						End If
						sReturnUrl = "OrderItemsLocallist.asp" ' No matching record, return to list
					Else
						Call LoadRowValues(Recordset) ' Load row values
					End If
			End Select
		Else
			sReturnUrl = "OrderItemsLocallist.asp" ' Not page request, return to list
		End If
		If sReturnUrl <> "" Then Call Page_Terminate(sReturnUrl)

		' Render row
		OrderItemsLocal.RowType = EW_ROWTYPE_VIEW
		Call OrderItemsLocal.ResetAttrs()
		Call RenderRow()
	End Sub

	' Set up other options
	Sub SetupOtherOptions()
		Dim opt, item
		Set opt = ActionOptions

		' Add
		Call opt.Add("add")
		Set item = opt.GetItem("add")
		item.Body = "<a class=""ewAction ewAdd"" title=""" & ew_HtmlTitle(Language.Phrase("ViewPageAddLink")) & """ data-caption=""" & ew_HtmlTitle(Language.Phrase("ViewPageAddLink")) & """ href=""" & ew_HtmlEncode(AddUrl) & """>" & Language.Phrase("ViewPageAddLink") & "</a>"
		item.Visible = (AddUrl <> "")

		' Edit
		Call opt.Add("edit")
		Set item = opt.GetItem("edit")
		item.Body = "<a class=""ewAction ewEdit"" title=""" & ew_HtmlTitle(Language.Phrase("ViewPageEditLink")) & """ data-caption=""" & ew_HtmlTitle(Language.Phrase("ViewPageEditLink")) & """ href=""" & ew_HtmlEncode(EditUrl) & """>" & Language.Phrase("ViewPageEditLink") & "</a>"
		item.Visible = (EditUrl <> "")

		' Copy
		Call opt.Add("copy")
		Set item = opt.GetItem("copy")
		item.Body = "<a class=""ewAction ewCopy"" title=""" & ew_HtmlTitle(Language.Phrase("ViewPageCopyLink")) & """ data-caption=""" & ew_HtmlTitle(Language.Phrase("ViewPageCopyLink")) & """ href=""" & ew_HtmlEncode(CopyUrl) & """>" & Language.Phrase("ViewPageCopyLink") & "</a>"
		item.Visible = (CopyUrl <> "")

		' Delete
		Call opt.Add("delete")
		Set item = opt.GetItem("delete")
		item.Body = "<a onclick=""return ew_Confirm(ewLanguage.Phrase('DeleteConfirmMsg'));"" class=""ewAction ewDelete"" title=""" & ew_HtmlTitle(Language.Phrase("ViewPageDeleteLink")) & """ data-caption=""" & ew_HtmlTitle(Language.Phrase("ViewPageDeleteLink")) & """ href=""" & ew_HtmlEncode(DeleteUrl) & """>" & Language.Phrase("ViewPageDeleteLink") & "</a>"
		item.Visible = (DeleteUrl <> "")

		' Set up options default
		Set opt = ActionOptions
		opt.DropDownButtonPhrase = Language.Phrase("ButtonActions")
		opt.UseImageAndText = True
		opt.UseDropDownButton = False
		opt.UseButtonGroup = True
		Call opt.Add(opt.GroupOptionName)
		Set item = opt.GetItem(opt.GroupOptionName)
		item.Body = ""
		item.Visible = False
	End Sub
	Dim Pager

	' -----------------------------------------------------------------
	' Set up Starting Record parameters based on Pager Navigation
	'
	Sub SetUpStartRec()
		Dim PageNo

		' Exit if DisplayRecs = 0
		If DisplayRecs = 0 Then Exit Sub
		If IsPageRequest Then ' Validate request

			' Check for a START parameter
			If Request.QueryString(EW_TABLE_START_REC).Count > 0 Then
				StartRec = Request.QueryString(EW_TABLE_START_REC)
				OrderItemsLocal.StartRecordNumber = StartRec
			ElseIf Request.QueryString(EW_TABLE_PAGE_NO).Count > 0 Then
				PageNo = Request.QueryString(EW_TABLE_PAGE_NO)
				If IsNumeric(PageNo) Then
					StartRec = (PageNo-1)*DisplayRecs+1
					If StartRec <= 0 Then
						StartRec = 1
					ElseIf StartRec >= ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1 Then
						StartRec = ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1
					End If
					OrderItemsLocal.StartRecordNumber = StartRec
				End If
			End If
		End If
		StartRec = OrderItemsLocal.StartRecordNumber

		' Check if correct start record counter
		If Not IsNumeric(StartRec) Or StartRec = "" Then ' Avoid invalid start record counter
			StartRec = 1 ' Reset start record counter
			OrderItemsLocal.StartRecordNumber = StartRec
		ElseIf CLng(StartRec) > CLng(TotalRecs) Then ' Avoid starting record > total records
			StartRec = ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1 ' Point to last page first record
			OrderItemsLocal.StartRecordNumber = StartRec
		ElseIf (StartRec-1) Mod DisplayRecs <> 0 Then
			StartRec = ((StartRec-1)\DisplayRecs)*DisplayRecs+1 ' Point to page boundary
			OrderItemsLocal.StartRecordNumber = StartRec
		End If
	End Sub

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
		AddUrl = OrderItemsLocal.AddUrl("")
		EditUrl = OrderItemsLocal.EditUrl("")
		CopyUrl = OrderItemsLocal.CopyUrl("")
		DeleteUrl = OrderItemsLocal.DeleteUrl
		ListUrl = OrderItemsLocal.ListUrl
		SetupOtherOptions()

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
		End If

		' Call Row Rendered event
		If OrderItemsLocal.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call OrderItemsLocal.Row_Rendered()
		End If
	End Sub

	' Set up Breadcrumb
	Sub SetupBreadcrumb()
		Dim PageId, url
		Set Breadcrumb = New cBreadcrumb
		url = Mid(ew_CurrentUrl, InStrRev(ew_CurrentUrl, "/")+1)
		Call Breadcrumb.Add("list", OrderItemsLocal.TableVar, "OrderItemsLocallist.asp", "", OrderItemsLocal.TableVar, True)
		PageId = "view"
		Call Breadcrumb.Add("view", PageId, url, "", "", False)
	End Sub

	Sub ExportPdf(html)
		Response.Write html
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

	' Page Exporting event
	' ExportDoc = export document object
	Function Page_Exporting()

		'ExportDoc.Text = "my header" ' Export header
		'Page_Exporting = False ' Return False to skip default export and use Row_Export event

		Page_Exporting = True ' Return True to use default export and skip Row_Export event
	End Function

	' Row Export event
	' Table.ExportDoc = export document object
	Sub Row_Export(rs)

		'Dim Doc
		'Set Doc = Table.ExportDoc
		'Doc.Text = Doc.Text & "my content" ' Build HTML with field value: rs("MyField") or MyField.ViewValue

	End Sub

	' Page Exported event
	' ExportDoc = export document object
	Sub Page_Exported()

		'ExportDoc.Text = ExportDoc.Text & "my footer" ' Export footer
		'Response.Write ExportDoc.Text

	End Sub
End Class
%>
