<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="OpeningTimesinfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim OpeningTimes_view
Set OpeningTimes_view = New cOpeningTimes_view
Set Page = OpeningTimes_view

' Page init processing
OpeningTimes_view.Page_Init()

' Page main processing
OpeningTimes_view.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
OpeningTimes_view.Page_Render()
%>
<!--#include file="header.asp"-->
<% If OpeningTimes.Export = "" Then %>
<script type="text/javascript">
// Page object
var OpeningTimes_view = new ew_Page("OpeningTimes_view");
OpeningTimes_view.PageID = "view"; // Page ID
var EW_PAGE_ID = OpeningTimes_view.PageID; // For backward compatibility
// Form object
var fOpeningTimesview = new ew_Form("fOpeningTimesview");
// Form_CustomValidate event
fOpeningTimesview.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fOpeningTimesview.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fOpeningTimesview.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<% End If %>
<% If OpeningTimes.Export = "" Then %>
<div class="ewToolbar">
<% If OpeningTimes.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<%
	OpeningTimes_view.ExportOptions.Render "body", "", "", "", "", ""
	OpeningTimes_view.ActionOptions.Render "body", "", "", "", "", ""
	OpeningTimes_view.DetailOptions.Render "body", "", "", "", "", ""
%>
<% If OpeningTimes.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% End If %>
<% OpeningTimes_view.ShowPageHeader() %>
<% OpeningTimes_view.ShowMessage %>
<% If OpeningTimes.Export = "" Then %>
<form name="ewPagerForm" class="form-inline ewForm ewPagerForm" action="<%= ew_CurrentPage %>">
<% If Not IsObject(OpeningTimes_view.Pager) Then Set OpeningTimes_view.Pager = ew_NewPrevNextPager(OpeningTimes_view.StartRec, OpeningTimes_view.DisplayRecs, OpeningTimes_view.TotalRecs) %>
<% If OpeningTimes_view.Pager.RecordCount > 0 Then %>
<div class="ewPager">
<span><%= Language.Phrase("Page") %>&nbsp;</span>
<div class="ewPrevNext"><div class="input-group">
<div class="input-group-btn">
<!--first page button-->
	<% If OpeningTimes_view.Pager.FirstButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerFirst") %>" href="<%= OpeningTimes_view.PageUrl %>start=<%= OpeningTimes_view.Pager.FirstButton.Start %>"><span class="icon-first ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerFirst") %>"><span class="icon-first ewIcon"></span></a>
	<% End If %>
<!--previous page button-->
	<% If OpeningTimes_view.Pager.PrevButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerPrevious") %>" href="<%= OpeningTimes_view.PageUrl %>start=<%= OpeningTimes_view.Pager.PrevButton.Start %>"><span class="icon-prev ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerPrevious") %>"><span class="icon-prev ewIcon"></span></a>
	<% End If %>
</div>
<!--current page number-->
	<input class="form-control input-sm" type="text" name="<%= EW_TABLE_PAGE_NO %>" value="<%= OpeningTimes_view.Pager.CurrentPage %>">
<div class="input-group-btn">
<!--next page button-->
	<% If OpeningTimes_view.Pager.NextButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerNext") %>" href="<%= OpeningTimes_view.PageUrl %>start=<%= OpeningTimes_view.Pager.NextButton.Start %>"><span class="icon-next ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerNext") %>"><span class="icon-next ewIcon"></span></a>
	<% End If %>
<!--last page button-->
	<% If OpeningTimes_view.Pager.LastButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerLast") %>" href="<%= OpeningTimes_view.PageUrl %>start=<%= OpeningTimes_view.Pager.LastButton.Start %>"><span class="icon-last ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerLast") %>"><span class="icon-last ewIcon"></span></a>
	<% End If %>
</div>
</div>
</div>
<span>&nbsp;<%= Language.Phrase("of") %>&nbsp;<%= OpeningTimes_view.Pager.PageCount %></span>
</div>
<% End If %>
<div class="clearfix"></div>
</form>
<% End If %>
<form name="fOpeningTimesview" id="fOpeningTimesview" class="form-inline ewForm ewViewForm" action="<%= ew_CurrentPage %>" method="post">
<% If OpeningTimes_view.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= OpeningTimes_view.Token %>">
<% End If %>
<input type="hidden" name="t" value="OpeningTimes">
<table class="table table-bordered table-striped ewViewTable">
<% If OpeningTimes.ID.Visible Then ' ID %>
	<tr id="r_ID">
		<td><span id="elh_OpeningTimes_ID"><%= OpeningTimes.ID.FldCaption %></span></td>
		<td<%= OpeningTimes.ID.CellAttributes %>>
<span id="el_OpeningTimes_ID" class="form-group">
<span<%= OpeningTimes.ID.ViewAttributes %>>
<%= OpeningTimes.ID.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OpeningTimes.DayOfWeek.Visible Then ' DayOfWeek %>
	<tr id="r_DayOfWeek">
		<td><span id="elh_OpeningTimes_DayOfWeek"><%= OpeningTimes.DayOfWeek.FldCaption %></span></td>
		<td<%= OpeningTimes.DayOfWeek.CellAttributes %>>
<span id="el_OpeningTimes_DayOfWeek" class="form-group">
<span<%= OpeningTimes.DayOfWeek.ViewAttributes %>>
<%= OpeningTimes.DayOfWeek.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OpeningTimes.Hour_From.Visible Then ' Hour_From %>
	<tr id="r_Hour_From">
		<td><span id="elh_OpeningTimes_Hour_From"><%= OpeningTimes.Hour_From.FldCaption %></span></td>
		<td<%= OpeningTimes.Hour_From.CellAttributes %>>
<span id="el_OpeningTimes_Hour_From" class="form-group">
<span<%= OpeningTimes.Hour_From.ViewAttributes %>>
<%= OpeningTimes.Hour_From.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OpeningTimes.Hour_To.Visible Then ' Hour_To %>
	<tr id="r_Hour_To">
		<td><span id="elh_OpeningTimes_Hour_To"><%= OpeningTimes.Hour_To.FldCaption %></span></td>
		<td<%= OpeningTimes.Hour_To.CellAttributes %>>
<span id="el_OpeningTimes_Hour_To" class="form-group">
<span<%= OpeningTimes.Hour_To.ViewAttributes %>>
<%= OpeningTimes.Hour_To.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OpeningTimes.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
	<tr id="r_IdBusinessDetail">
		<td><span id="elh_OpeningTimes_IdBusinessDetail"><%= OpeningTimes.IdBusinessDetail.FldCaption %></span></td>
		<td<%= OpeningTimes.IdBusinessDetail.CellAttributes %>>
<span id="el_OpeningTimes_IdBusinessDetail" class="form-group">
<span<%= OpeningTimes.IdBusinessDetail.ViewAttributes %>>
<%= OpeningTimes.IdBusinessDetail.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OpeningTimes.delivery.Visible Then ' delivery %>
	<tr id="r_delivery">
		<td><span id="elh_OpeningTimes_delivery"><%= OpeningTimes.delivery.FldCaption %></span></td>
		<td<%= OpeningTimes.delivery.CellAttributes %>>
<span id="el_OpeningTimes_delivery" class="form-group">
<span<%= OpeningTimes.delivery.ViewAttributes %>>
<%= OpeningTimes.delivery.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OpeningTimes.collection.Visible Then ' collection %>
	<tr id="r_collection">
		<td><span id="elh_OpeningTimes_collection"><%= OpeningTimes.collection.FldCaption %></span></td>
		<td<%= OpeningTimes.collection.CellAttributes %>>
<span id="el_OpeningTimes_collection" class="form-group">
<span<%= OpeningTimes.collection.ViewAttributes %>>
<%= OpeningTimes.collection.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OpeningTimes.MinAcceptOrderBeforeClose.Visible Then ' MinAcceptOrderBeforeClose %>
	<tr id="r_MinAcceptOrderBeforeClose">
		<td><span id="elh_OpeningTimes_MinAcceptOrderBeforeClose"><%= OpeningTimes.MinAcceptOrderBeforeClose.FldCaption %></span></td>
		<td<%= OpeningTimes.MinAcceptOrderBeforeClose.CellAttributes %>>
<span id="el_OpeningTimes_MinAcceptOrderBeforeClose" class="form-group">
<span<%= OpeningTimes.MinAcceptOrderBeforeClose.ViewAttributes %>>
<%= OpeningTimes.MinAcceptOrderBeforeClose.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
</table>
<% If OpeningTimes.Export = "" Then %>
<% If Not IsObject(OpeningTimes_view.Pager) Then Set OpeningTimes_view.Pager = ew_NewPrevNextPager(OpeningTimes_view.StartRec, OpeningTimes_view.DisplayRecs, OpeningTimes_view.TotalRecs) %>
<% If OpeningTimes_view.Pager.RecordCount > 0 Then %>
<div class="ewPager">
<span><%= Language.Phrase("Page") %>&nbsp;</span>
<div class="ewPrevNext"><div class="input-group">
<div class="input-group-btn">
<!--first page button-->
	<% If OpeningTimes_view.Pager.FirstButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerFirst") %>" href="<%= OpeningTimes_view.PageUrl %>start=<%= OpeningTimes_view.Pager.FirstButton.Start %>"><span class="icon-first ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerFirst") %>"><span class="icon-first ewIcon"></span></a>
	<% End If %>
<!--previous page button-->
	<% If OpeningTimes_view.Pager.PrevButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerPrevious") %>" href="<%= OpeningTimes_view.PageUrl %>start=<%= OpeningTimes_view.Pager.PrevButton.Start %>"><span class="icon-prev ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerPrevious") %>"><span class="icon-prev ewIcon"></span></a>
	<% End If %>
</div>
<!--current page number-->
	<input class="form-control input-sm" type="text" name="<%= EW_TABLE_PAGE_NO %>" value="<%= OpeningTimes_view.Pager.CurrentPage %>">
<div class="input-group-btn">
<!--next page button-->
	<% If OpeningTimes_view.Pager.NextButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerNext") %>" href="<%= OpeningTimes_view.PageUrl %>start=<%= OpeningTimes_view.Pager.NextButton.Start %>"><span class="icon-next ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerNext") %>"><span class="icon-next ewIcon"></span></a>
	<% End If %>
<!--last page button-->
	<% If OpeningTimes_view.Pager.LastButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerLast") %>" href="<%= OpeningTimes_view.PageUrl %>start=<%= OpeningTimes_view.Pager.LastButton.Start %>"><span class="icon-last ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerLast") %>"><span class="icon-last ewIcon"></span></a>
	<% End If %>
</div>
</div>
</div>
<span>&nbsp;<%= Language.Phrase("of") %>&nbsp;<%= OpeningTimes_view.Pager.PageCount %></span>
</div>
<% End If %>
<div class="clearfix"></div>
<% End If %>
</form>
<% If OpeningTimes.Export <> "" Then %>
<script type="text/javascript">
ew_ApplyTemplate("body", "", "OpeningTimesview", "<%= OpeningTimes.CustomExport %>");
</script>
<% End If %>
<script type="text/javascript">
fOpeningTimesview.Init();
</script>
<%
OpeningTimes_view.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<% If OpeningTimes.Export = "" Then %>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<% End If %>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set OpeningTimes_view = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cOpeningTimes_view

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
		TableName = "OpeningTimes"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "OpeningTimes_view"
	End Property

	' Page Name
	Public Property Get PageName()
		PageName = ew_CurrentPage()
	End Property

	' Page Url
	Public Property Get PageUrl()
		PageUrl = ew_CurrentPage() & "?"
		If OpeningTimes.UseTokenInUrl Then PageUrl = PageUrl & "t=" & OpeningTimes.TableVar & "&" ' add page token
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
		If OpeningTimes.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (OpeningTimes.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (OpeningTimes.TableVar = Request.QueryString("t"))
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
		If IsEmpty(OpeningTimes) Then Set OpeningTimes = New cOpeningTimes
		Set Table = OpeningTimes
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
		EW_TABLE_NAME = "OpeningTimes"

		' Open connection to the database
		If IsEmpty(Conn) Then Call ew_Connect()

		' Export options
		Set ExportOptions = New cListOptions
		ExportOptions.TableVar = OpeningTimes.TableVar
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
			results = OpeningTimes.GetAutoFill(Request.Form("name"), Request.Form("q"))
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
		If Not OpeningTimes Is Nothing Then
			If OpeningTimes.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = OpeningTimes.TableVar
				If OpeningTimes.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf OpeningTimes.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf OpeningTimes.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf OpeningTimes.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set OpeningTimes = Nothing
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
		If OpeningTimes.Export = "" Then
			SetupBreadcrumb()
		End If
		If IsPageRequest Then ' Validate request
			If Request.QueryString("ID").Count > 0 Then
				OpeningTimes.ID.QueryStringValue = Request.QueryString("ID")
			ElseIf Request.Form("ID").Count > 0 Then
				OpeningTimes.ID.FormValue = Request.Form("ID")
			Else
				bLoadCurrentRecord = True
			End If

			' Get action
			OpeningTimes.CurrentAction = "I" ' Display form
			Select Case OpeningTimes.CurrentAction
				Case "I" ' Get a record to display
					StartRec = 1 ' Initialize start position
					Set Recordset = LoadRecordset() ' Load records
					TotalRecs = Recordset.RecordCount ' Get record count
					If TotalRecs <= 0 Then ' No record found
						If SuccessMessage = "" And FailureMessage = "" Then
							FailureMessage = Language.Phrase("NoRecord") ' Set no record message
						End If
						sReturnUrl = "OpeningTimeslist.asp"
					ElseIf bLoadCurrentRecord Then ' Load current record position
						SetUpStartRec() ' Set up start record position

						' Point to current record
						If CLng(StartRec) <= CLng(TotalRecs) Then
							bMatchRecord = True
							Recordset.Move StartRec-1
						End If
					Else ' Match key values
						Do While Not Recordset.Eof
							If CStr(OpeningTimes.ID.CurrentValue&"") = CStr(Recordset("ID")&"") Then
								OpeningTimes.StartRecordNumber = StartRec ' Save record position
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
						sReturnUrl = "OpeningTimeslist.asp" ' No matching record, return to list
					Else
						Call LoadRowValues(Recordset) ' Load row values
					End If
			End Select
		Else
			sReturnUrl = "OpeningTimeslist.asp" ' Not page request, return to list
		End If
		If sReturnUrl <> "" Then Call Page_Terminate(sReturnUrl)

		' Render row
		OpeningTimes.RowType = EW_ROWTYPE_VIEW
		Call OpeningTimes.ResetAttrs()
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
				OpeningTimes.StartRecordNumber = StartRec
			ElseIf Request.QueryString(EW_TABLE_PAGE_NO).Count > 0 Then
				PageNo = Request.QueryString(EW_TABLE_PAGE_NO)
				If IsNumeric(PageNo) Then
					StartRec = (PageNo-1)*DisplayRecs+1
					If StartRec <= 0 Then
						StartRec = 1
					ElseIf StartRec >= ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1 Then
						StartRec = ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1
					End If
					OpeningTimes.StartRecordNumber = StartRec
				End If
			End If
		End If
		StartRec = OpeningTimes.StartRecordNumber

		' Check if correct start record counter
		If Not IsNumeric(StartRec) Or StartRec = "" Then ' Avoid invalid start record counter
			StartRec = 1 ' Reset start record counter
			OpeningTimes.StartRecordNumber = StartRec
		ElseIf CLng(StartRec) > CLng(TotalRecs) Then ' Avoid starting record > total records
			StartRec = ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1 ' Point to last page first record
			OpeningTimes.StartRecordNumber = StartRec
		ElseIf (StartRec-1) Mod DisplayRecs <> 0 Then
			StartRec = ((StartRec-1)\DisplayRecs)*DisplayRecs+1 ' Point to page boundary
			OpeningTimes.StartRecordNumber = StartRec
		End If
	End Sub

	' -----------------------------------------------------------------
	' Load recordset
	'
	Function LoadRecordset()

		' Load list page sql
		Dim sSql
		sSql = OpeningTimes.SelectSQL
		Call ew_SetDebugMsg("LoadRecordset: " & sSql) ' Show SQL for debugging

		' Load recordset
		Dim RsRecordset
		Set RsRecordset = ew_LoadRecordset(sSql)

		' Call Recordset Selected event
		Call OpeningTimes.Recordset_Selected(RsRecordset)
		Set LoadRecordset = RsRecordset
	End Function

	' -----------------------------------------------------------------
	' Load row based on key values
	'
	Function LoadRow()
		Dim RsRow, sSql, sFilter
		sFilter = OpeningTimes.KeyFilter

		' Call Row Selecting event
		Call OpeningTimes.Row_Selecting(sFilter)

		' Load sql based on filter
		OpeningTimes.CurrentFilter = sFilter
		sSql = OpeningTimes.SQL
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
		Call OpeningTimes.Row_Selected(RsRow)
		OpeningTimes.ID.DbValue = RsRow("ID")
		OpeningTimes.DayOfWeek.DbValue = RsRow("DayOfWeek")
		OpeningTimes.Hour_From.DbValue = RsRow("Hour_From")
		OpeningTimes.Hour_To.DbValue = RsRow("Hour_To")
		OpeningTimes.IdBusinessDetail.DbValue = RsRow("IdBusinessDetail")
		OpeningTimes.delivery.DbValue = RsRow("delivery")
		OpeningTimes.collection.DbValue = RsRow("collection")
		OpeningTimes.MinAcceptOrderBeforeClose.DbValue = ew_Conv(RsRow("MinAcceptOrderBeforeClose"), 131)
	End Sub

	' Load DbValue from recordset
	Sub LoadDbValues(Rs)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		If Rs.Eof Then Exit Sub
		OpeningTimes.ID.m_DbValue = Rs("ID")
		OpeningTimes.DayOfWeek.m_DbValue = Rs("DayOfWeek")
		OpeningTimes.Hour_From.m_DbValue = Rs("Hour_From")
		OpeningTimes.Hour_To.m_DbValue = Rs("Hour_To")
		OpeningTimes.IdBusinessDetail.m_DbValue = Rs("IdBusinessDetail")
		OpeningTimes.delivery.m_DbValue = Rs("delivery")
		OpeningTimes.collection.m_DbValue = Rs("collection")
		OpeningTimes.MinAcceptOrderBeforeClose.m_DbValue = ew_Conv(Rs("MinAcceptOrderBeforeClose"), 131)
	End Sub

	' -----------------------------------------------------------------
	' Render row values based on field settings
	'
	Sub RenderRow()

		' Initialize urls
		AddUrl = OpeningTimes.AddUrl("")
		EditUrl = OpeningTimes.EditUrl("")
		CopyUrl = OpeningTimes.CopyUrl("")
		DeleteUrl = OpeningTimes.DeleteUrl
		ListUrl = OpeningTimes.ListUrl
		SetupOtherOptions()

		' Convert decimal values if posted back
		If OpeningTimes.MinAcceptOrderBeforeClose.CurrentValue & "" <> "" Then OpeningTimes.MinAcceptOrderBeforeClose.CurrentValue = ew_Conv(OpeningTimes.MinAcceptOrderBeforeClose.CurrentValue, OpeningTimes.MinAcceptOrderBeforeClose.FldType)
		If OpeningTimes.MinAcceptOrderBeforeClose.FormValue = OpeningTimes.MinAcceptOrderBeforeClose.CurrentValue And IsNumeric(OpeningTimes.MinAcceptOrderBeforeClose.CurrentValue) Then
			OpeningTimes.MinAcceptOrderBeforeClose.CurrentValue = ew_StrToFloat(OpeningTimes.MinAcceptOrderBeforeClose.CurrentValue)
		End If

		' Call Row Rendering event
		Call OpeningTimes.Row_Rendering()

		' ---------------------------------------
		'  Common render codes for all row types
		' ---------------------------------------
		' ID
		' DayOfWeek
		' Hour_From
		' Hour_To
		' IdBusinessDetail
		' delivery
		' collection
		' MinAcceptOrderBeforeClose
		' -----------
		'  View  Row
		' -----------

		If OpeningTimes.RowType = EW_ROWTYPE_VIEW Then ' View row

			' ID
			OpeningTimes.ID.ViewValue = OpeningTimes.ID.CurrentValue
			OpeningTimes.ID.ViewCustomAttributes = ""

			' DayOfWeek
			OpeningTimes.DayOfWeek.ViewValue = OpeningTimes.DayOfWeek.CurrentValue
			OpeningTimes.DayOfWeek.ViewCustomAttributes = ""

			' Hour_From
			OpeningTimes.Hour_From.ViewValue = OpeningTimes.Hour_From.CurrentValue
			OpeningTimes.Hour_From.ViewCustomAttributes = ""

			' Hour_To
			OpeningTimes.Hour_To.ViewValue = OpeningTimes.Hour_To.CurrentValue
			OpeningTimes.Hour_To.ViewCustomAttributes = ""

			' IdBusinessDetail
			OpeningTimes.IdBusinessDetail.ViewValue = OpeningTimes.IdBusinessDetail.CurrentValue
			OpeningTimes.IdBusinessDetail.ViewCustomAttributes = ""

			' delivery
			OpeningTimes.delivery.ViewValue = OpeningTimes.delivery.CurrentValue
			OpeningTimes.delivery.ViewCustomAttributes = ""

			' collection
			OpeningTimes.collection.ViewValue = OpeningTimes.collection.CurrentValue
			OpeningTimes.collection.ViewCustomAttributes = ""

			' MinAcceptOrderBeforeClose
			OpeningTimes.MinAcceptOrderBeforeClose.ViewValue = OpeningTimes.MinAcceptOrderBeforeClose.CurrentValue
			OpeningTimes.MinAcceptOrderBeforeClose.ViewCustomAttributes = ""

			' View refer script
			' ID

			OpeningTimes.ID.LinkCustomAttributes = ""
			OpeningTimes.ID.HrefValue = ""
			OpeningTimes.ID.TooltipValue = ""

			' DayOfWeek
			OpeningTimes.DayOfWeek.LinkCustomAttributes = ""
			OpeningTimes.DayOfWeek.HrefValue = ""
			OpeningTimes.DayOfWeek.TooltipValue = ""

			' Hour_From
			OpeningTimes.Hour_From.LinkCustomAttributes = ""
			OpeningTimes.Hour_From.HrefValue = ""
			OpeningTimes.Hour_From.TooltipValue = ""

			' Hour_To
			OpeningTimes.Hour_To.LinkCustomAttributes = ""
			OpeningTimes.Hour_To.HrefValue = ""
			OpeningTimes.Hour_To.TooltipValue = ""

			' IdBusinessDetail
			OpeningTimes.IdBusinessDetail.LinkCustomAttributes = ""
			OpeningTimes.IdBusinessDetail.HrefValue = ""
			OpeningTimes.IdBusinessDetail.TooltipValue = ""

			' delivery
			OpeningTimes.delivery.LinkCustomAttributes = ""
			OpeningTimes.delivery.HrefValue = ""
			OpeningTimes.delivery.TooltipValue = ""

			' collection
			OpeningTimes.collection.LinkCustomAttributes = ""
			OpeningTimes.collection.HrefValue = ""
			OpeningTimes.collection.TooltipValue = ""

			' MinAcceptOrderBeforeClose
			OpeningTimes.MinAcceptOrderBeforeClose.LinkCustomAttributes = ""
			OpeningTimes.MinAcceptOrderBeforeClose.HrefValue = ""
			OpeningTimes.MinAcceptOrderBeforeClose.TooltipValue = ""
		End If

		' Call Row Rendered event
		If OpeningTimes.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call OpeningTimes.Row_Rendered()
		End If
	End Sub

	' Set up Breadcrumb
	Sub SetupBreadcrumb()
		Dim PageId, url
		Set Breadcrumb = New cBreadcrumb
		url = Mid(ew_CurrentUrl, InStrRev(ew_CurrentUrl, "/")+1)
		Call Breadcrumb.Add("list", OpeningTimes.TableVar, "OpeningTimeslist.asp", "", OpeningTimes.TableVar, True)
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
