<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="Category_Openning_Timeinfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim Category_Openning_Time_view
Set Category_Openning_Time_view = New cCategory_Openning_Time_view
Set Page = Category_Openning_Time_view

' Page init processing
Category_Openning_Time_view.Page_Init()

' Page main processing
Category_Openning_Time_view.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
Category_Openning_Time_view.Page_Render()
%>
<!--#include file="header.asp"-->
<% If Category_Openning_Time.Export = "" Then %>
<script type="text/javascript">
// Page object
var Category_Openning_Time_view = new ew_Page("Category_Openning_Time_view");
Category_Openning_Time_view.PageID = "view"; // Page ID
var EW_PAGE_ID = Category_Openning_Time_view.PageID; // For backward compatibility
// Form object
var fCategory_Openning_Timeview = new ew_Form("fCategory_Openning_Timeview");
// Form_CustomValidate event
fCategory_Openning_Timeview.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fCategory_Openning_Timeview.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fCategory_Openning_Timeview.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<% End If %>
<% If Category_Openning_Time.Export = "" Then %>
<div class="ewToolbar">
<% If Category_Openning_Time.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<%
	Category_Openning_Time_view.ExportOptions.Render "body", "", "", "", "", ""
	Category_Openning_Time_view.ActionOptions.Render "body", "", "", "", "", ""
	Category_Openning_Time_view.DetailOptions.Render "body", "", "", "", "", ""
%>
<% If Category_Openning_Time.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% End If %>
<% Category_Openning_Time_view.ShowPageHeader() %>
<% Category_Openning_Time_view.ShowMessage %>
<% If Category_Openning_Time.Export = "" Then %>
<form name="ewPagerForm" class="form-inline ewForm ewPagerForm" action="<%= ew_CurrentPage %>">
<% If Not IsObject(Category_Openning_Time_view.Pager) Then Set Category_Openning_Time_view.Pager = ew_NewPrevNextPager(Category_Openning_Time_view.StartRec, Category_Openning_Time_view.DisplayRecs, Category_Openning_Time_view.TotalRecs) %>
<% If Category_Openning_Time_view.Pager.RecordCount > 0 Then %>
<div class="ewPager">
<span><%= Language.Phrase("Page") %>&nbsp;</span>
<div class="ewPrevNext"><div class="input-group">
<div class="input-group-btn">
<!--first page button-->
	<% If Category_Openning_Time_view.Pager.FirstButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerFirst") %>" href="<%= Category_Openning_Time_view.PageUrl %>start=<%= Category_Openning_Time_view.Pager.FirstButton.Start %>"><span class="icon-first ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerFirst") %>"><span class="icon-first ewIcon"></span></a>
	<% End If %>
<!--previous page button-->
	<% If Category_Openning_Time_view.Pager.PrevButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerPrevious") %>" href="<%= Category_Openning_Time_view.PageUrl %>start=<%= Category_Openning_Time_view.Pager.PrevButton.Start %>"><span class="icon-prev ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerPrevious") %>"><span class="icon-prev ewIcon"></span></a>
	<% End If %>
</div>
<!--current page number-->
	<input class="form-control input-sm" type="text" name="<%= EW_TABLE_PAGE_NO %>" value="<%= Category_Openning_Time_view.Pager.CurrentPage %>">
<div class="input-group-btn">
<!--next page button-->
	<% If Category_Openning_Time_view.Pager.NextButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerNext") %>" href="<%= Category_Openning_Time_view.PageUrl %>start=<%= Category_Openning_Time_view.Pager.NextButton.Start %>"><span class="icon-next ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerNext") %>"><span class="icon-next ewIcon"></span></a>
	<% End If %>
<!--last page button-->
	<% If Category_Openning_Time_view.Pager.LastButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerLast") %>" href="<%= Category_Openning_Time_view.PageUrl %>start=<%= Category_Openning_Time_view.Pager.LastButton.Start %>"><span class="icon-last ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerLast") %>"><span class="icon-last ewIcon"></span></a>
	<% End If %>
</div>
</div>
</div>
<span>&nbsp;<%= Language.Phrase("of") %>&nbsp;<%= Category_Openning_Time_view.Pager.PageCount %></span>
</div>
<% End If %>
<div class="clearfix"></div>
</form>
<% End If %>
<form name="fCategory_Openning_Timeview" id="fCategory_Openning_Timeview" class="form-inline ewForm ewViewForm" action="<%= ew_CurrentPage %>" method="post">
<% If Category_Openning_Time_view.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= Category_Openning_Time_view.Token %>">
<% End If %>
<input type="hidden" name="t" value="Category_Openning_Time">
<table class="table table-bordered table-striped ewViewTable">
<% If Category_Openning_Time.ID.Visible Then ' ID %>
	<tr id="r_ID">
		<td><span id="elh_Category_Openning_Time_ID"><%= Category_Openning_Time.ID.FldCaption %></span></td>
		<td<%= Category_Openning_Time.ID.CellAttributes %>>
<span id="el_Category_Openning_Time_ID" class="form-group">
<span<%= Category_Openning_Time.ID.ViewAttributes %>>
<%= Category_Openning_Time.ID.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Category_Openning_Time.CategoryID.Visible Then ' CategoryID %>
	<tr id="r_CategoryID">
		<td><span id="elh_Category_Openning_Time_CategoryID"><%= Category_Openning_Time.CategoryID.FldCaption %></span></td>
		<td<%= Category_Openning_Time.CategoryID.CellAttributes %>>
<span id="el_Category_Openning_Time_CategoryID" class="form-group">
<span<%= Category_Openning_Time.CategoryID.ViewAttributes %>>
<%= Category_Openning_Time.CategoryID.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Category_Openning_Time.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
	<tr id="r_IdBusinessDetail">
		<td><span id="elh_Category_Openning_Time_IdBusinessDetail"><%= Category_Openning_Time.IdBusinessDetail.FldCaption %></span></td>
		<td<%= Category_Openning_Time.IdBusinessDetail.CellAttributes %>>
<span id="el_Category_Openning_Time_IdBusinessDetail" class="form-group">
<span<%= Category_Openning_Time.IdBusinessDetail.ViewAttributes %>>
<%= Category_Openning_Time.IdBusinessDetail.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Category_Openning_Time.Hour_From.Visible Then ' Hour_From %>
	<tr id="r_Hour_From">
		<td><span id="elh_Category_Openning_Time_Hour_From"><%= Category_Openning_Time.Hour_From.FldCaption %></span></td>
		<td<%= Category_Openning_Time.Hour_From.CellAttributes %>>
<span id="el_Category_Openning_Time_Hour_From" class="form-group">
<span<%= Category_Openning_Time.Hour_From.ViewAttributes %>>
<%= Category_Openning_Time.Hour_From.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Category_Openning_Time.Hour_To.Visible Then ' Hour_To %>
	<tr id="r_Hour_To">
		<td><span id="elh_Category_Openning_Time_Hour_To"><%= Category_Openning_Time.Hour_To.FldCaption %></span></td>
		<td<%= Category_Openning_Time.Hour_To.CellAttributes %>>
<span id="el_Category_Openning_Time_Hour_To" class="form-group">
<span<%= Category_Openning_Time.Hour_To.ViewAttributes %>>
<%= Category_Openning_Time.Hour_To.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Category_Openning_Time.DayValue.Visible Then ' DayValue %>
	<tr id="r_DayValue">
		<td><span id="elh_Category_Openning_Time_DayValue"><%= Category_Openning_Time.DayValue.FldCaption %></span></td>
		<td<%= Category_Openning_Time.DayValue.CellAttributes %>>
<span id="el_Category_Openning_Time_DayValue" class="form-group">
<span<%= Category_Openning_Time.DayValue.ViewAttributes %>>
<%= Category_Openning_Time.DayValue.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Category_Openning_Time.Dayname.Visible Then ' Dayname %>
	<tr id="r_Dayname">
		<td><span id="elh_Category_Openning_Time_Dayname"><%= Category_Openning_Time.Dayname.FldCaption %></span></td>
		<td<%= Category_Openning_Time.Dayname.CellAttributes %>>
<span id="el_Category_Openning_Time_Dayname" class="form-group">
<span<%= Category_Openning_Time.Dayname.ViewAttributes %>>
<%= Category_Openning_Time.Dayname.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Category_Openning_Time.status.Visible Then ' status %>
	<tr id="r_status">
		<td><span id="elh_Category_Openning_Time_status"><%= Category_Openning_Time.status.FldCaption %></span></td>
		<td<%= Category_Openning_Time.status.CellAttributes %>>
<span id="el_Category_Openning_Time_status" class="form-group">
<span<%= Category_Openning_Time.status.ViewAttributes %>>
<%= Category_Openning_Time.status.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
</table>
<% If Category_Openning_Time.Export = "" Then %>
<% If Not IsObject(Category_Openning_Time_view.Pager) Then Set Category_Openning_Time_view.Pager = ew_NewPrevNextPager(Category_Openning_Time_view.StartRec, Category_Openning_Time_view.DisplayRecs, Category_Openning_Time_view.TotalRecs) %>
<% If Category_Openning_Time_view.Pager.RecordCount > 0 Then %>
<div class="ewPager">
<span><%= Language.Phrase("Page") %>&nbsp;</span>
<div class="ewPrevNext"><div class="input-group">
<div class="input-group-btn">
<!--first page button-->
	<% If Category_Openning_Time_view.Pager.FirstButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerFirst") %>" href="<%= Category_Openning_Time_view.PageUrl %>start=<%= Category_Openning_Time_view.Pager.FirstButton.Start %>"><span class="icon-first ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerFirst") %>"><span class="icon-first ewIcon"></span></a>
	<% End If %>
<!--previous page button-->
	<% If Category_Openning_Time_view.Pager.PrevButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerPrevious") %>" href="<%= Category_Openning_Time_view.PageUrl %>start=<%= Category_Openning_Time_view.Pager.PrevButton.Start %>"><span class="icon-prev ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerPrevious") %>"><span class="icon-prev ewIcon"></span></a>
	<% End If %>
</div>
<!--current page number-->
	<input class="form-control input-sm" type="text" name="<%= EW_TABLE_PAGE_NO %>" value="<%= Category_Openning_Time_view.Pager.CurrentPage %>">
<div class="input-group-btn">
<!--next page button-->
	<% If Category_Openning_Time_view.Pager.NextButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerNext") %>" href="<%= Category_Openning_Time_view.PageUrl %>start=<%= Category_Openning_Time_view.Pager.NextButton.Start %>"><span class="icon-next ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerNext") %>"><span class="icon-next ewIcon"></span></a>
	<% End If %>
<!--last page button-->
	<% If Category_Openning_Time_view.Pager.LastButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerLast") %>" href="<%= Category_Openning_Time_view.PageUrl %>start=<%= Category_Openning_Time_view.Pager.LastButton.Start %>"><span class="icon-last ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerLast") %>"><span class="icon-last ewIcon"></span></a>
	<% End If %>
</div>
</div>
</div>
<span>&nbsp;<%= Language.Phrase("of") %>&nbsp;<%= Category_Openning_Time_view.Pager.PageCount %></span>
</div>
<% End If %>
<div class="clearfix"></div>
<% End If %>
</form>
<% If Category_Openning_Time.Export <> "" Then %>
<script type="text/javascript">
ew_ApplyTemplate("body", "", "Category_Openning_Timeview", "<%= Category_Openning_Time.CustomExport %>");
</script>
<% End If %>
<script type="text/javascript">
fCategory_Openning_Timeview.Init();
</script>
<%
Category_Openning_Time_view.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<% If Category_Openning_Time.Export = "" Then %>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<% End If %>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set Category_Openning_Time_view = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cCategory_Openning_Time_view

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
		TableName = "Category_Openning_Time"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "Category_Openning_Time_view"
	End Property

	' Page Name
	Public Property Get PageName()
		PageName = ew_CurrentPage()
	End Property

	' Page Url
	Public Property Get PageUrl()
		PageUrl = ew_CurrentPage() & "?"
		If Category_Openning_Time.UseTokenInUrl Then PageUrl = PageUrl & "t=" & Category_Openning_Time.TableVar & "&" ' add page token
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
		If Category_Openning_Time.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (Category_Openning_Time.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (Category_Openning_Time.TableVar = Request.QueryString("t"))
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
		If IsEmpty(Category_Openning_Time) Then Set Category_Openning_Time = New cCategory_Openning_Time
		Set Table = Category_Openning_Time
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
		EW_TABLE_NAME = "Category_Openning_Time"

		' Open connection to the database
		If IsEmpty(Conn) Then Call ew_Connect()

		' Export options
		Set ExportOptions = New cListOptions
		ExportOptions.TableVar = Category_Openning_Time.TableVar
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
			results = Category_Openning_Time.GetAutoFill(Request.Form("name"), Request.Form("q"))
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
		If Not Category_Openning_Time Is Nothing Then
			If Category_Openning_Time.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = Category_Openning_Time.TableVar
				If Category_Openning_Time.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf Category_Openning_Time.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf Category_Openning_Time.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf Category_Openning_Time.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set Category_Openning_Time = Nothing
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
		If Category_Openning_Time.Export = "" Then
			SetupBreadcrumb()
		End If
		If IsPageRequest Then ' Validate request
			If Request.QueryString("ID").Count > 0 Then
				Category_Openning_Time.ID.QueryStringValue = Request.QueryString("ID")
			ElseIf Request.Form("ID").Count > 0 Then
				Category_Openning_Time.ID.FormValue = Request.Form("ID")
			Else
				bLoadCurrentRecord = True
			End If

			' Get action
			Category_Openning_Time.CurrentAction = "I" ' Display form
			Select Case Category_Openning_Time.CurrentAction
				Case "I" ' Get a record to display
					StartRec = 1 ' Initialize start position
					Set Recordset = LoadRecordset() ' Load records
					TotalRecs = Recordset.RecordCount ' Get record count
					If TotalRecs <= 0 Then ' No record found
						If SuccessMessage = "" And FailureMessage = "" Then
							FailureMessage = Language.Phrase("NoRecord") ' Set no record message
						End If
						sReturnUrl = "Category_Openning_Timelist.asp"
					ElseIf bLoadCurrentRecord Then ' Load current record position
						SetUpStartRec() ' Set up start record position

						' Point to current record
						If CLng(StartRec) <= CLng(TotalRecs) Then
							bMatchRecord = True
							Recordset.Move StartRec-1
						End If
					Else ' Match key values
						Do While Not Recordset.Eof
							If CStr(Category_Openning_Time.ID.CurrentValue&"") = CStr(Recordset("ID")&"") Then
								Category_Openning_Time.StartRecordNumber = StartRec ' Save record position
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
						sReturnUrl = "Category_Openning_Timelist.asp" ' No matching record, return to list
					Else
						Call LoadRowValues(Recordset) ' Load row values
					End If
			End Select
		Else
			sReturnUrl = "Category_Openning_Timelist.asp" ' Not page request, return to list
		End If
		If sReturnUrl <> "" Then Call Page_Terminate(sReturnUrl)

		' Render row
		Category_Openning_Time.RowType = EW_ROWTYPE_VIEW
		Call Category_Openning_Time.ResetAttrs()
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
				Category_Openning_Time.StartRecordNumber = StartRec
			ElseIf Request.QueryString(EW_TABLE_PAGE_NO).Count > 0 Then
				PageNo = Request.QueryString(EW_TABLE_PAGE_NO)
				If IsNumeric(PageNo) Then
					StartRec = (PageNo-1)*DisplayRecs+1
					If StartRec <= 0 Then
						StartRec = 1
					ElseIf StartRec >= ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1 Then
						StartRec = ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1
					End If
					Category_Openning_Time.StartRecordNumber = StartRec
				End If
			End If
		End If
		StartRec = Category_Openning_Time.StartRecordNumber

		' Check if correct start record counter
		If Not IsNumeric(StartRec) Or StartRec = "" Then ' Avoid invalid start record counter
			StartRec = 1 ' Reset start record counter
			Category_Openning_Time.StartRecordNumber = StartRec
		ElseIf CLng(StartRec) > CLng(TotalRecs) Then ' Avoid starting record > total records
			StartRec = ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1 ' Point to last page first record
			Category_Openning_Time.StartRecordNumber = StartRec
		ElseIf (StartRec-1) Mod DisplayRecs <> 0 Then
			StartRec = ((StartRec-1)\DisplayRecs)*DisplayRecs+1 ' Point to page boundary
			Category_Openning_Time.StartRecordNumber = StartRec
		End If
	End Sub

	' -----------------------------------------------------------------
	' Load recordset
	'
	Function LoadRecordset()

		' Load list page sql
		Dim sSql
		sSql = Category_Openning_Time.SelectSQL
		Call ew_SetDebugMsg("LoadRecordset: " & sSql) ' Show SQL for debugging

		' Load recordset
		Dim RsRecordset
		Set RsRecordset = ew_LoadRecordset(sSql)

		' Call Recordset Selected event
		Call Category_Openning_Time.Recordset_Selected(RsRecordset)
		Set LoadRecordset = RsRecordset
	End Function

	' -----------------------------------------------------------------
	' Load row based on key values
	'
	Function LoadRow()
		Dim RsRow, sSql, sFilter
		sFilter = Category_Openning_Time.KeyFilter

		' Call Row Selecting event
		Call Category_Openning_Time.Row_Selecting(sFilter)

		' Load sql based on filter
		Category_Openning_Time.CurrentFilter = sFilter
		sSql = Category_Openning_Time.SQL
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
		Call Category_Openning_Time.Row_Selected(RsRow)
		Category_Openning_Time.ID.DbValue = RsRow("ID")
		Category_Openning_Time.CategoryID.DbValue = RsRow("CategoryID")
		Category_Openning_Time.IdBusinessDetail.DbValue = RsRow("IdBusinessDetail")
		Category_Openning_Time.Hour_From.DbValue = RsRow("Hour_From")
		Category_Openning_Time.Hour_To.DbValue = RsRow("Hour_To")
		Category_Openning_Time.DayValue.DbValue = RsRow("DayValue")
		Category_Openning_Time.Dayname.DbValue = RsRow("Dayname")
		Category_Openning_Time.status.DbValue = RsRow("status")
	End Sub

	' Load DbValue from recordset
	Sub LoadDbValues(Rs)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		If Rs.Eof Then Exit Sub
		Category_Openning_Time.ID.m_DbValue = Rs("ID")
		Category_Openning_Time.CategoryID.m_DbValue = Rs("CategoryID")
		Category_Openning_Time.IdBusinessDetail.m_DbValue = Rs("IdBusinessDetail")
		Category_Openning_Time.Hour_From.m_DbValue = Rs("Hour_From")
		Category_Openning_Time.Hour_To.m_DbValue = Rs("Hour_To")
		Category_Openning_Time.DayValue.m_DbValue = Rs("DayValue")
		Category_Openning_Time.Dayname.m_DbValue = Rs("Dayname")
		Category_Openning_Time.status.m_DbValue = Rs("status")
	End Sub

	' -----------------------------------------------------------------
	' Render row values based on field settings
	'
	Sub RenderRow()

		' Initialize urls
		AddUrl = Category_Openning_Time.AddUrl("")
		EditUrl = Category_Openning_Time.EditUrl("")
		CopyUrl = Category_Openning_Time.CopyUrl("")
		DeleteUrl = Category_Openning_Time.DeleteUrl
		ListUrl = Category_Openning_Time.ListUrl
		SetupOtherOptions()

		' Call Row Rendering event
		Call Category_Openning_Time.Row_Rendering()

		' ---------------------------------------
		'  Common render codes for all row types
		' ---------------------------------------
		' ID
		' CategoryID
		' IdBusinessDetail
		' Hour_From
		' Hour_To
		' DayValue
		' Dayname
		' status
		' -----------
		'  View  Row
		' -----------

		If Category_Openning_Time.RowType = EW_ROWTYPE_VIEW Then ' View row

			' ID
			Category_Openning_Time.ID.ViewValue = Category_Openning_Time.ID.CurrentValue
			Category_Openning_Time.ID.ViewCustomAttributes = ""

			' CategoryID
			Category_Openning_Time.CategoryID.ViewValue = Category_Openning_Time.CategoryID.CurrentValue
			Category_Openning_Time.CategoryID.ViewCustomAttributes = ""

			' IdBusinessDetail
			Category_Openning_Time.IdBusinessDetail.ViewValue = Category_Openning_Time.IdBusinessDetail.CurrentValue
			Category_Openning_Time.IdBusinessDetail.ViewCustomAttributes = ""

			' Hour_From
			Category_Openning_Time.Hour_From.ViewValue = Category_Openning_Time.Hour_From.CurrentValue
			Category_Openning_Time.Hour_From.ViewCustomAttributes = ""

			' Hour_To
			Category_Openning_Time.Hour_To.ViewValue = Category_Openning_Time.Hour_To.CurrentValue
			Category_Openning_Time.Hour_To.ViewCustomAttributes = ""

			' DayValue
			Category_Openning_Time.DayValue.ViewValue = Category_Openning_Time.DayValue.CurrentValue
			Category_Openning_Time.DayValue.ViewCustomAttributes = ""

			' Dayname
			Category_Openning_Time.Dayname.ViewValue = Category_Openning_Time.Dayname.CurrentValue
			Category_Openning_Time.Dayname.ViewCustomAttributes = ""

			' status
			Category_Openning_Time.status.ViewValue = Category_Openning_Time.status.CurrentValue
			Category_Openning_Time.status.ViewCustomAttributes = ""

			' View refer script
			' ID

			Category_Openning_Time.ID.LinkCustomAttributes = ""
			Category_Openning_Time.ID.HrefValue = ""
			Category_Openning_Time.ID.TooltipValue = ""

			' CategoryID
			Category_Openning_Time.CategoryID.LinkCustomAttributes = ""
			Category_Openning_Time.CategoryID.HrefValue = ""
			Category_Openning_Time.CategoryID.TooltipValue = ""

			' IdBusinessDetail
			Category_Openning_Time.IdBusinessDetail.LinkCustomAttributes = ""
			Category_Openning_Time.IdBusinessDetail.HrefValue = ""
			Category_Openning_Time.IdBusinessDetail.TooltipValue = ""

			' Hour_From
			Category_Openning_Time.Hour_From.LinkCustomAttributes = ""
			Category_Openning_Time.Hour_From.HrefValue = ""
			Category_Openning_Time.Hour_From.TooltipValue = ""

			' Hour_To
			Category_Openning_Time.Hour_To.LinkCustomAttributes = ""
			Category_Openning_Time.Hour_To.HrefValue = ""
			Category_Openning_Time.Hour_To.TooltipValue = ""

			' DayValue
			Category_Openning_Time.DayValue.LinkCustomAttributes = ""
			Category_Openning_Time.DayValue.HrefValue = ""
			Category_Openning_Time.DayValue.TooltipValue = ""

			' Dayname
			Category_Openning_Time.Dayname.LinkCustomAttributes = ""
			Category_Openning_Time.Dayname.HrefValue = ""
			Category_Openning_Time.Dayname.TooltipValue = ""

			' status
			Category_Openning_Time.status.LinkCustomAttributes = ""
			Category_Openning_Time.status.HrefValue = ""
			Category_Openning_Time.status.TooltipValue = ""
		End If

		' Call Row Rendered event
		If Category_Openning_Time.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call Category_Openning_Time.Row_Rendered()
		End If
	End Sub

	' Set up Breadcrumb
	Sub SetupBreadcrumb()
		Dim PageId, url
		Set Breadcrumb = New cBreadcrumb
		url = Mid(ew_CurrentUrl, InStrRev(ew_CurrentUrl, "/")+1)
		Call Breadcrumb.Add("list", Category_Openning_Time.TableVar, "Category_Openning_Timelist.asp", "", Category_Openning_Time.TableVar, True)
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
