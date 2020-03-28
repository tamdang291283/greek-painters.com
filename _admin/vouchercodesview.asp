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
Dim vouchercodes_view
Set vouchercodes_view = New cvouchercodes_view
Set Page = vouchercodes_view

' Page init processing
vouchercodes_view.Page_Init()

' Page main processing
vouchercodes_view.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
vouchercodes_view.Page_Render()
%>
<!--#include file="header.asp"-->
<% If vouchercodes.Export = "" Then %>
<script type="text/javascript">
// Page object
var vouchercodes_view = new ew_Page("vouchercodes_view");
vouchercodes_view.PageID = "view"; // Page ID
var EW_PAGE_ID = vouchercodes_view.PageID; // For backward compatibility
// Form object
var fvouchercodesview = new ew_Form("fvouchercodesview");
// Form_CustomValidate event
fvouchercodesview.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fvouchercodesview.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fvouchercodesview.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<% End If %>
<% If vouchercodes.Export = "" Then %>
<div class="ewToolbar">
<% If vouchercodes.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<%
	vouchercodes_view.ExportOptions.Render "body", "", "", "", "", ""
	vouchercodes_view.ActionOptions.Render "body", "", "", "", "", ""
	vouchercodes_view.DetailOptions.Render "body", "", "", "", "", ""
%>
<% If vouchercodes.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% End If %>
<% vouchercodes_view.ShowPageHeader() %>
<% vouchercodes_view.ShowMessage %>
<% If vouchercodes.Export = "" Then %>
<form name="ewPagerForm" class="form-inline ewForm ewPagerForm" action="<%= ew_CurrentPage %>">
<% If Not IsObject(vouchercodes_view.Pager) Then Set vouchercodes_view.Pager = ew_NewPrevNextPager(vouchercodes_view.StartRec, vouchercodes_view.DisplayRecs, vouchercodes_view.TotalRecs) %>
<% If vouchercodes_view.Pager.RecordCount > 0 Then %>
<div class="ewPager">
<span><%= Language.Phrase("Page") %>&nbsp;</span>
<div class="ewPrevNext"><div class="input-group">
<div class="input-group-btn">
<!--first page button-->
	<% If vouchercodes_view.Pager.FirstButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerFirst") %>" href="<%= vouchercodes_view.PageUrl %>start=<%= vouchercodes_view.Pager.FirstButton.Start %>"><span class="icon-first ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerFirst") %>"><span class="icon-first ewIcon"></span></a>
	<% End If %>
<!--previous page button-->
	<% If vouchercodes_view.Pager.PrevButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerPrevious") %>" href="<%= vouchercodes_view.PageUrl %>start=<%= vouchercodes_view.Pager.PrevButton.Start %>"><span class="icon-prev ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerPrevious") %>"><span class="icon-prev ewIcon"></span></a>
	<% End If %>
</div>
<!--current page number-->
	<input class="form-control input-sm" type="text" name="<%= EW_TABLE_PAGE_NO %>" value="<%= vouchercodes_view.Pager.CurrentPage %>">
<div class="input-group-btn">
<!--next page button-->
	<% If vouchercodes_view.Pager.NextButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerNext") %>" href="<%= vouchercodes_view.PageUrl %>start=<%= vouchercodes_view.Pager.NextButton.Start %>"><span class="icon-next ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerNext") %>"><span class="icon-next ewIcon"></span></a>
	<% End If %>
<!--last page button-->
	<% If vouchercodes_view.Pager.LastButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerLast") %>" href="<%= vouchercodes_view.PageUrl %>start=<%= vouchercodes_view.Pager.LastButton.Start %>"><span class="icon-last ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerLast") %>"><span class="icon-last ewIcon"></span></a>
	<% End If %>
</div>
</div>
</div>
<span>&nbsp;<%= Language.Phrase("of") %>&nbsp;<%= vouchercodes_view.Pager.PageCount %></span>
</div>
<% End If %>
<div class="clearfix"></div>
</form>
<% End If %>
<form name="fvouchercodesview" id="fvouchercodesview" class="form-inline ewForm ewViewForm" action="<%= ew_CurrentPage %>" method="post">
<% If vouchercodes_view.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= vouchercodes_view.Token %>">
<% End If %>
<input type="hidden" name="t" value="vouchercodes">
<table class="table table-bordered table-striped ewViewTable">
<% If vouchercodes.ID.Visible Then ' ID %>
	<tr id="r_ID">
		<td><span id="elh_vouchercodes_ID"><%= vouchercodes.ID.FldCaption %></span></td>
		<td<%= vouchercodes.ID.CellAttributes %>>
<span id="el_vouchercodes_ID" class="form-group">
<span<%= vouchercodes.ID.ViewAttributes %>>
<%= vouchercodes.ID.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If vouchercodes.vouchercode.Visible Then ' vouchercode %>
	<tr id="r_vouchercode">
		<td><span id="elh_vouchercodes_vouchercode"><%= vouchercodes.vouchercode.FldCaption %></span></td>
		<td<%= vouchercodes.vouchercode.CellAttributes %>>
<span id="el_vouchercodes_vouchercode" class="form-group">
<span<%= vouchercodes.vouchercode.ViewAttributes %>>
<%= vouchercodes.vouchercode.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If vouchercodes.vouchercodediscount.Visible Then ' vouchercodediscount %>
	<tr id="r_vouchercodediscount">
		<td><span id="elh_vouchercodes_vouchercodediscount"><%= vouchercodes.vouchercodediscount.FldCaption %></span></td>
		<td<%= vouchercodes.vouchercodediscount.CellAttributes %>>
<span id="el_vouchercodes_vouchercodediscount" class="form-group">
<span<%= vouchercodes.vouchercodediscount.ViewAttributes %>>
<%= vouchercodes.vouchercodediscount.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If vouchercodes.vouchertype.Visible Then ' vouchertype %>
	<tr id="r_vouchertype">
		<td><span id="elh_vouchercodes_vouchertype"><%= vouchercodes.vouchertype.FldCaption %></span></td>
		<td<%= vouchercodes.vouchertype.CellAttributes %>>
<span id="el_vouchercodes_vouchertype" class="form-group">
<span<%= vouchercodes.vouchertype.ViewAttributes %>>
<%= vouchercodes.vouchertype.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If vouchercodes.startdate.Visible Then ' startdate %>
	<tr id="r_startdate">
		<td><span id="elh_vouchercodes_startdate"><%= vouchercodes.startdate.FldCaption %></span></td>
		<td<%= vouchercodes.startdate.CellAttributes %>>
<span id="el_vouchercodes_startdate" class="form-group">
<span<%= vouchercodes.startdate.ViewAttributes %>>
<%= vouchercodes.startdate.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If vouchercodes.enddate.Visible Then ' enddate %>
	<tr id="r_enddate">
		<td><span id="elh_vouchercodes_enddate"><%= vouchercodes.enddate.FldCaption %></span></td>
		<td<%= vouchercodes.enddate.CellAttributes %>>
<span id="el_vouchercodes_enddate" class="form-group">
<span<%= vouchercodes.enddate.ViewAttributes %>>
<%= vouchercodes.enddate.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If vouchercodes.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
	<tr id="r_IdBusinessDetail">
		<td><span id="elh_vouchercodes_IdBusinessDetail"><%= vouchercodes.IdBusinessDetail.FldCaption %></span></td>
		<td<%= vouchercodes.IdBusinessDetail.CellAttributes %>>
<span id="el_vouchercodes_IdBusinessDetail" class="form-group">
<span<%= vouchercodes.IdBusinessDetail.ViewAttributes %>>
<%= vouchercodes.IdBusinessDetail.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If vouchercodes.MinimumAmount.Visible Then ' MinimumAmount %>
	<tr id="r_MinimumAmount">
		<td><span id="elh_vouchercodes_MinimumAmount"><%= vouchercodes.MinimumAmount.FldCaption %></span></td>
		<td<%= vouchercodes.MinimumAmount.CellAttributes %>>
<span id="el_vouchercodes_MinimumAmount" class="form-group">
<span<%= vouchercodes.MinimumAmount.ViewAttributes %>>
<%= vouchercodes.MinimumAmount.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If vouchercodes.MenuItemID.Visible Then ' MenuItemID %>
	<tr id="r_MenuItemID">
		<td><span id="elh_vouchercodes_MenuItemID"><%= vouchercodes.MenuItemID.FldCaption %></span></td>
		<td<%= vouchercodes.MenuItemID.CellAttributes %>>
<span id="el_vouchercodes_MenuItemID" class="form-group">
<span<%= vouchercodes.MenuItemID.ViewAttributes %>>
<%= vouchercodes.MenuItemID.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If vouchercodes.VoucherMainType.Visible Then ' VoucherMainType %>
	<tr id="r_VoucherMainType">
		<td><span id="elh_vouchercodes_VoucherMainType"><%= vouchercodes.VoucherMainType.FldCaption %></span></td>
		<td<%= vouchercodes.VoucherMainType.CellAttributes %>>
<span id="el_vouchercodes_VoucherMainType" class="form-group">
<span<%= vouchercodes.VoucherMainType.ViewAttributes %>>
<%= vouchercodes.VoucherMainType.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
</table>
<% If vouchercodes.Export = "" Then %>
<% If Not IsObject(vouchercodes_view.Pager) Then Set vouchercodes_view.Pager = ew_NewPrevNextPager(vouchercodes_view.StartRec, vouchercodes_view.DisplayRecs, vouchercodes_view.TotalRecs) %>
<% If vouchercodes_view.Pager.RecordCount > 0 Then %>
<div class="ewPager">
<span><%= Language.Phrase("Page") %>&nbsp;</span>
<div class="ewPrevNext"><div class="input-group">
<div class="input-group-btn">
<!--first page button-->
	<% If vouchercodes_view.Pager.FirstButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerFirst") %>" href="<%= vouchercodes_view.PageUrl %>start=<%= vouchercodes_view.Pager.FirstButton.Start %>"><span class="icon-first ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerFirst") %>"><span class="icon-first ewIcon"></span></a>
	<% End If %>
<!--previous page button-->
	<% If vouchercodes_view.Pager.PrevButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerPrevious") %>" href="<%= vouchercodes_view.PageUrl %>start=<%= vouchercodes_view.Pager.PrevButton.Start %>"><span class="icon-prev ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerPrevious") %>"><span class="icon-prev ewIcon"></span></a>
	<% End If %>
</div>
<!--current page number-->
	<input class="form-control input-sm" type="text" name="<%= EW_TABLE_PAGE_NO %>" value="<%= vouchercodes_view.Pager.CurrentPage %>">
<div class="input-group-btn">
<!--next page button-->
	<% If vouchercodes_view.Pager.NextButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerNext") %>" href="<%= vouchercodes_view.PageUrl %>start=<%= vouchercodes_view.Pager.NextButton.Start %>"><span class="icon-next ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerNext") %>"><span class="icon-next ewIcon"></span></a>
	<% End If %>
<!--last page button-->
	<% If vouchercodes_view.Pager.LastButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerLast") %>" href="<%= vouchercodes_view.PageUrl %>start=<%= vouchercodes_view.Pager.LastButton.Start %>"><span class="icon-last ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerLast") %>"><span class="icon-last ewIcon"></span></a>
	<% End If %>
</div>
</div>
</div>
<span>&nbsp;<%= Language.Phrase("of") %>&nbsp;<%= vouchercodes_view.Pager.PageCount %></span>
</div>
<% End If %>
<div class="clearfix"></div>
<% End If %>
</form>
<% If vouchercodes.Export <> "" Then %>
<script type="text/javascript">
ew_ApplyTemplate("body", "", "vouchercodesview", "<%= vouchercodes.CustomExport %>");
</script>
<% End If %>
<script type="text/javascript">
fvouchercodesview.Init();
</script>
<%
vouchercodes_view.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<% If vouchercodes.Export = "" Then %>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<% End If %>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set vouchercodes_view = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cvouchercodes_view

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
		TableName = "vouchercodes"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "vouchercodes_view"
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
		EW_TABLE_NAME = "vouchercodes"

		' Open connection to the database
		If IsEmpty(Conn) Then Call ew_Connect()

		' Export options
		Set ExportOptions = New cListOptions
		ExportOptions.TableVar = vouchercodes.TableVar
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
		If vouchercodes.Export = "" Then
			SetupBreadcrumb()
		End If
		If IsPageRequest Then ' Validate request
			If Request.QueryString("ID").Count > 0 Then
				vouchercodes.ID.QueryStringValue = Request.QueryString("ID")
			ElseIf Request.Form("ID").Count > 0 Then
				vouchercodes.ID.FormValue = Request.Form("ID")
			Else
				bLoadCurrentRecord = True
			End If

			' Get action
			vouchercodes.CurrentAction = "I" ' Display form
			Select Case vouchercodes.CurrentAction
				Case "I" ' Get a record to display
					StartRec = 1 ' Initialize start position
					Set Recordset = LoadRecordset() ' Load records
					TotalRecs = Recordset.RecordCount ' Get record count
					If TotalRecs <= 0 Then ' No record found
						If SuccessMessage = "" And FailureMessage = "" Then
							FailureMessage = Language.Phrase("NoRecord") ' Set no record message
						End If
						sReturnUrl = "vouchercodeslist.asp"
					ElseIf bLoadCurrentRecord Then ' Load current record position
						SetUpStartRec() ' Set up start record position

						' Point to current record
						If CLng(StartRec) <= CLng(TotalRecs) Then
							bMatchRecord = True
							Recordset.Move StartRec-1
						End If
					Else ' Match key values
						Do While Not Recordset.Eof
							If CStr(vouchercodes.ID.CurrentValue&"") = CStr(Recordset("ID")&"") Then
								vouchercodes.StartRecordNumber = StartRec ' Save record position
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
						sReturnUrl = "vouchercodeslist.asp" ' No matching record, return to list
					Else
						Call LoadRowValues(Recordset) ' Load row values
					End If
			End Select
		Else
			sReturnUrl = "vouchercodeslist.asp" ' Not page request, return to list
		End If
		If sReturnUrl <> "" Then Call Page_Terminate(sReturnUrl)

		' Render row
		vouchercodes.RowType = EW_ROWTYPE_VIEW
		Call vouchercodes.ResetAttrs()
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
				vouchercodes.StartRecordNumber = StartRec
			ElseIf Request.QueryString(EW_TABLE_PAGE_NO).Count > 0 Then
				PageNo = Request.QueryString(EW_TABLE_PAGE_NO)
				If IsNumeric(PageNo) Then
					StartRec = (PageNo-1)*DisplayRecs+1
					If StartRec <= 0 Then
						StartRec = 1
					ElseIf StartRec >= ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1 Then
						StartRec = ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1
					End If
					vouchercodes.StartRecordNumber = StartRec
				End If
			End If
		End If
		StartRec = vouchercodes.StartRecordNumber

		' Check if correct start record counter
		If Not IsNumeric(StartRec) Or StartRec = "" Then ' Avoid invalid start record counter
			StartRec = 1 ' Reset start record counter
			vouchercodes.StartRecordNumber = StartRec
		ElseIf CLng(StartRec) > CLng(TotalRecs) Then ' Avoid starting record > total records
			StartRec = ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1 ' Point to last page first record
			vouchercodes.StartRecordNumber = StartRec
		ElseIf (StartRec-1) Mod DisplayRecs <> 0 Then
			StartRec = ((StartRec-1)\DisplayRecs)*DisplayRecs+1 ' Point to page boundary
			vouchercodes.StartRecordNumber = StartRec
		End If
	End Sub

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
		AddUrl = vouchercodes.AddUrl("")
		EditUrl = vouchercodes.EditUrl("")
		CopyUrl = vouchercodes.CopyUrl("")
		DeleteUrl = vouchercodes.DeleteUrl
		ListUrl = vouchercodes.ListUrl
		SetupOtherOptions()

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
		End If

		' Call Row Rendered event
		If vouchercodes.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call vouchercodes.Row_Rendered()
		End If
	End Sub

	' Set up Breadcrumb
	Sub SetupBreadcrumb()
		Dim PageId, url
		Set Breadcrumb = New cBreadcrumb
		url = Mid(ew_CurrentUrl, InStrRev(ew_CurrentUrl, "/")+1)
		Call Breadcrumb.Add("list", vouchercodes.TableVar, "vouchercodeslist.asp", "", vouchercodes.TableVar, True)
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
