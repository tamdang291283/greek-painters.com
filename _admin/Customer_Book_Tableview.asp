<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="Customer_Book_Tableinfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim Customer_Book_Table_view
Set Customer_Book_Table_view = New cCustomer_Book_Table_view
Set Page = Customer_Book_Table_view

' Page init processing
Customer_Book_Table_view.Page_Init()

' Page main processing
Customer_Book_Table_view.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
Customer_Book_Table_view.Page_Render()
%>
<!--#include file="header.asp"-->
<% If Customer_Book_Table.Export = "" Then %>
<script type="text/javascript">
// Page object
var Customer_Book_Table_view = new ew_Page("Customer_Book_Table_view");
Customer_Book_Table_view.PageID = "view"; // Page ID
var EW_PAGE_ID = Customer_Book_Table_view.PageID; // For backward compatibility
// Form object
var fCustomer_Book_Tableview = new ew_Form("fCustomer_Book_Tableview");
// Form_CustomValidate event
fCustomer_Book_Tableview.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fCustomer_Book_Tableview.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fCustomer_Book_Tableview.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<% End If %>
<% If Customer_Book_Table.Export = "" Then %>
<div class="ewToolbar">
<% If Customer_Book_Table.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<%
	Customer_Book_Table_view.ExportOptions.Render "body", "", "", "", "", ""
	Customer_Book_Table_view.ActionOptions.Render "body", "", "", "", "", ""
	Customer_Book_Table_view.DetailOptions.Render "body", "", "", "", "", ""
%>
<% If Customer_Book_Table.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% End If %>
<% Customer_Book_Table_view.ShowPageHeader() %>
<% Customer_Book_Table_view.ShowMessage %>
<% If Customer_Book_Table.Export = "" Then %>
<form name="ewPagerForm" class="form-inline ewForm ewPagerForm" action="<%= ew_CurrentPage %>">
<% If Not IsObject(Customer_Book_Table_view.Pager) Then Set Customer_Book_Table_view.Pager = ew_NewPrevNextPager(Customer_Book_Table_view.StartRec, Customer_Book_Table_view.DisplayRecs, Customer_Book_Table_view.TotalRecs) %>
<% If Customer_Book_Table_view.Pager.RecordCount > 0 Then %>
<div class="ewPager">
<span><%= Language.Phrase("Page") %>&nbsp;</span>
<div class="ewPrevNext"><div class="input-group">
<div class="input-group-btn">
<!--first page button-->
	<% If Customer_Book_Table_view.Pager.FirstButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerFirst") %>" href="<%= Customer_Book_Table_view.PageUrl %>start=<%= Customer_Book_Table_view.Pager.FirstButton.Start %>"><span class="icon-first ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerFirst") %>"><span class="icon-first ewIcon"></span></a>
	<% End If %>
<!--previous page button-->
	<% If Customer_Book_Table_view.Pager.PrevButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerPrevious") %>" href="<%= Customer_Book_Table_view.PageUrl %>start=<%= Customer_Book_Table_view.Pager.PrevButton.Start %>"><span class="icon-prev ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerPrevious") %>"><span class="icon-prev ewIcon"></span></a>
	<% End If %>
</div>
<!--current page number-->
	<input class="form-control input-sm" type="text" name="<%= EW_TABLE_PAGE_NO %>" value="<%= Customer_Book_Table_view.Pager.CurrentPage %>">
<div class="input-group-btn">
<!--next page button-->
	<% If Customer_Book_Table_view.Pager.NextButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerNext") %>" href="<%= Customer_Book_Table_view.PageUrl %>start=<%= Customer_Book_Table_view.Pager.NextButton.Start %>"><span class="icon-next ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerNext") %>"><span class="icon-next ewIcon"></span></a>
	<% End If %>
<!--last page button-->
	<% If Customer_Book_Table_view.Pager.LastButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerLast") %>" href="<%= Customer_Book_Table_view.PageUrl %>start=<%= Customer_Book_Table_view.Pager.LastButton.Start %>"><span class="icon-last ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerLast") %>"><span class="icon-last ewIcon"></span></a>
	<% End If %>
</div>
</div>
</div>
<span>&nbsp;<%= Language.Phrase("of") %>&nbsp;<%= Customer_Book_Table_view.Pager.PageCount %></span>
</div>
<% End If %>
<div class="clearfix"></div>
</form>
<% End If %>
<form name="fCustomer_Book_Tableview" id="fCustomer_Book_Tableview" class="form-inline ewForm ewViewForm" action="<%= ew_CurrentPage %>" method="post">
<% If Customer_Book_Table_view.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= Customer_Book_Table_view.Token %>">
<% End If %>
<input type="hidden" name="t" value="Customer_Book_Table">
<table class="table table-bordered table-striped ewViewTable">
<% If Customer_Book_Table.ID.Visible Then ' ID %>
	<tr id="r_ID">
		<td><span id="elh_Customer_Book_Table_ID"><%= Customer_Book_Table.ID.FldCaption %></span></td>
		<td<%= Customer_Book_Table.ID.CellAttributes %>>
<span id="el_Customer_Book_Table_ID" class="form-group">
<span<%= Customer_Book_Table.ID.ViewAttributes %>>
<%= Customer_Book_Table.ID.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Customer_Book_Table.Name.Visible Then ' Name %>
	<tr id="r_Name">
		<td><span id="elh_Customer_Book_Table_Name"><%= Customer_Book_Table.Name.FldCaption %></span></td>
		<td<%= Customer_Book_Table.Name.CellAttributes %>>
<span id="el_Customer_Book_Table_Name" class="form-group">
<span<%= Customer_Book_Table.Name.ViewAttributes %>>
<%= Customer_Book_Table.Name.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Customer_Book_Table.Phone.Visible Then ' Phone %>
	<tr id="r_Phone">
		<td><span id="elh_Customer_Book_Table_Phone"><%= Customer_Book_Table.Phone.FldCaption %></span></td>
		<td<%= Customer_Book_Table.Phone.CellAttributes %>>
<span id="el_Customer_Book_Table_Phone" class="form-group">
<span<%= Customer_Book_Table.Phone.ViewAttributes %>>
<%= Customer_Book_Table.Phone.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Customer_Book_Table.bookdate.Visible Then ' bookdate %>
	<tr id="r_bookdate">
		<td><span id="elh_Customer_Book_Table_bookdate"><%= Customer_Book_Table.bookdate.FldCaption %></span></td>
		<td<%= Customer_Book_Table.bookdate.CellAttributes %>>
<span id="el_Customer_Book_Table_bookdate" class="form-group">
<span<%= Customer_Book_Table.bookdate.ViewAttributes %>>
<%= Customer_Book_Table.bookdate.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Customer_Book_Table.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
	<tr id="r_IdBusinessDetail">
		<td><span id="elh_Customer_Book_Table_IdBusinessDetail"><%= Customer_Book_Table.IdBusinessDetail.FldCaption %></span></td>
		<td<%= Customer_Book_Table.IdBusinessDetail.CellAttributes %>>
<span id="el_Customer_Book_Table_IdBusinessDetail" class="form-group">
<span<%= Customer_Book_Table.IdBusinessDetail.ViewAttributes %>>
<%= Customer_Book_Table.IdBusinessDetail.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Customer_Book_Table.comment.Visible Then ' comment %>
	<tr id="r_comment">
		<td><span id="elh_Customer_Book_Table_comment"><%= Customer_Book_Table.comment.FldCaption %></span></td>
		<td<%= Customer_Book_Table.comment.CellAttributes %>>
<span id="el_Customer_Book_Table_comment" class="form-group">
<span<%= Customer_Book_Table.comment.ViewAttributes %>>
<%= Customer_Book_Table.comment.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Customer_Book_Table.s_contentemail.Visible Then ' s_contentemail %>
	<tr id="r_s_contentemail">
		<td><span id="elh_Customer_Book_Table_s_contentemail"><%= Customer_Book_Table.s_contentemail.FldCaption %></span></td>
		<td<%= Customer_Book_Table.s_contentemail.CellAttributes %>>
<span id="el_Customer_Book_Table_s_contentemail" class="form-group">
<span<%= Customer_Book_Table.s_contentemail.ViewAttributes %>>
<%= Customer_Book_Table.s_contentemail.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Customer_Book_Table.numberpeople.Visible Then ' numberpeople %>
	<tr id="r_numberpeople">
		<td><span id="elh_Customer_Book_Table_numberpeople"><%= Customer_Book_Table.numberpeople.FldCaption %></span></td>
		<td<%= Customer_Book_Table.numberpeople.CellAttributes %>>
<span id="el_Customer_Book_Table_numberpeople" class="form-group">
<span<%= Customer_Book_Table.numberpeople.ViewAttributes %>>
<%= Customer_Book_Table.numberpeople.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Customer_Book_Table.createddate.Visible Then ' createddate %>
	<tr id="r_createddate">
		<td><span id="elh_Customer_Book_Table_createddate"><%= Customer_Book_Table.createddate.FldCaption %></span></td>
		<td<%= Customer_Book_Table.createddate.CellAttributes %>>
<span id="el_Customer_Book_Table_createddate" class="form-group">
<span<%= Customer_Book_Table.createddate.ViewAttributes %>>
<%= Customer_Book_Table.createddate.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Customer_Book_Table.zEmail.Visible Then ' Email %>
	<tr id="r_zEmail">
		<td><span id="elh_Customer_Book_Table_zEmail"><%= Customer_Book_Table.zEmail.FldCaption %></span></td>
		<td<%= Customer_Book_Table.zEmail.CellAttributes %>>
<span id="el_Customer_Book_Table_zEmail" class="form-group">
<span<%= Customer_Book_Table.zEmail.ViewAttributes %>>
<%= Customer_Book_Table.zEmail.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
</table>
<% If Customer_Book_Table.Export = "" Then %>
<% If Not IsObject(Customer_Book_Table_view.Pager) Then Set Customer_Book_Table_view.Pager = ew_NewPrevNextPager(Customer_Book_Table_view.StartRec, Customer_Book_Table_view.DisplayRecs, Customer_Book_Table_view.TotalRecs) %>
<% If Customer_Book_Table_view.Pager.RecordCount > 0 Then %>
<div class="ewPager">
<span><%= Language.Phrase("Page") %>&nbsp;</span>
<div class="ewPrevNext"><div class="input-group">
<div class="input-group-btn">
<!--first page button-->
	<% If Customer_Book_Table_view.Pager.FirstButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerFirst") %>" href="<%= Customer_Book_Table_view.PageUrl %>start=<%= Customer_Book_Table_view.Pager.FirstButton.Start %>"><span class="icon-first ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerFirst") %>"><span class="icon-first ewIcon"></span></a>
	<% End If %>
<!--previous page button-->
	<% If Customer_Book_Table_view.Pager.PrevButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerPrevious") %>" href="<%= Customer_Book_Table_view.PageUrl %>start=<%= Customer_Book_Table_view.Pager.PrevButton.Start %>"><span class="icon-prev ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerPrevious") %>"><span class="icon-prev ewIcon"></span></a>
	<% End If %>
</div>
<!--current page number-->
	<input class="form-control input-sm" type="text" name="<%= EW_TABLE_PAGE_NO %>" value="<%= Customer_Book_Table_view.Pager.CurrentPage %>">
<div class="input-group-btn">
<!--next page button-->
	<% If Customer_Book_Table_view.Pager.NextButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerNext") %>" href="<%= Customer_Book_Table_view.PageUrl %>start=<%= Customer_Book_Table_view.Pager.NextButton.Start %>"><span class="icon-next ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerNext") %>"><span class="icon-next ewIcon"></span></a>
	<% End If %>
<!--last page button-->
	<% If Customer_Book_Table_view.Pager.LastButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerLast") %>" href="<%= Customer_Book_Table_view.PageUrl %>start=<%= Customer_Book_Table_view.Pager.LastButton.Start %>"><span class="icon-last ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerLast") %>"><span class="icon-last ewIcon"></span></a>
	<% End If %>
</div>
</div>
</div>
<span>&nbsp;<%= Language.Phrase("of") %>&nbsp;<%= Customer_Book_Table_view.Pager.PageCount %></span>
</div>
<% End If %>
<div class="clearfix"></div>
<% End If %>
</form>
<% If Customer_Book_Table.Export <> "" Then %>
<script type="text/javascript">
ew_ApplyTemplate("body", "", "Customer_Book_Tableview", "<%= Customer_Book_Table.CustomExport %>");
</script>
<% End If %>
<script type="text/javascript">
fCustomer_Book_Tableview.Init();
</script>
<%
Customer_Book_Table_view.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<% If Customer_Book_Table.Export = "" Then %>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<% End If %>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set Customer_Book_Table_view = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cCustomer_Book_Table_view

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
		TableName = "Customer_Book_Table"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "Customer_Book_Table_view"
	End Property

	' Page Name
	Public Property Get PageName()
		PageName = ew_CurrentPage()
	End Property

	' Page Url
	Public Property Get PageUrl()
		PageUrl = ew_CurrentPage() & "?"
		If Customer_Book_Table.UseTokenInUrl Then PageUrl = PageUrl & "t=" & Customer_Book_Table.TableVar & "&" ' add page token
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
		If Customer_Book_Table.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (Customer_Book_Table.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (Customer_Book_Table.TableVar = Request.QueryString("t"))
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
		If IsEmpty(Customer_Book_Table) Then Set Customer_Book_Table = New cCustomer_Book_Table
		Set Table = Customer_Book_Table
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
		EW_TABLE_NAME = "Customer_Book_Table"

		' Open connection to the database
		If IsEmpty(Conn) Then Call ew_Connect()

		' Export options
		Set ExportOptions = New cListOptions
		ExportOptions.TableVar = Customer_Book_Table.TableVar
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
			results = Customer_Book_Table.GetAutoFill(Request.Form("name"), Request.Form("q"))
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
		If Not Customer_Book_Table Is Nothing Then
			If Customer_Book_Table.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = Customer_Book_Table.TableVar
				If Customer_Book_Table.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf Customer_Book_Table.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf Customer_Book_Table.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf Customer_Book_Table.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set Customer_Book_Table = Nothing
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
		If Customer_Book_Table.Export = "" Then
			SetupBreadcrumb()
		End If
		If IsPageRequest Then ' Validate request
			If Request.QueryString("ID").Count > 0 Then
				Customer_Book_Table.ID.QueryStringValue = Request.QueryString("ID")
			ElseIf Request.Form("ID").Count > 0 Then
				Customer_Book_Table.ID.FormValue = Request.Form("ID")
			Else
				bLoadCurrentRecord = True
			End If

			' Get action
			Customer_Book_Table.CurrentAction = "I" ' Display form
			Select Case Customer_Book_Table.CurrentAction
				Case "I" ' Get a record to display
					StartRec = 1 ' Initialize start position
					Set Recordset = LoadRecordset() ' Load records
					TotalRecs = Recordset.RecordCount ' Get record count
					If TotalRecs <= 0 Then ' No record found
						If SuccessMessage = "" And FailureMessage = "" Then
							FailureMessage = Language.Phrase("NoRecord") ' Set no record message
						End If
						sReturnUrl = "Customer_Book_Tablelist.asp"
					ElseIf bLoadCurrentRecord Then ' Load current record position
						SetUpStartRec() ' Set up start record position

						' Point to current record
						If CLng(StartRec) <= CLng(TotalRecs) Then
							bMatchRecord = True
							Recordset.Move StartRec-1
						End If
					Else ' Match key values
						Do While Not Recordset.Eof
							If CStr(Customer_Book_Table.ID.CurrentValue&"") = CStr(Recordset("ID")&"") Then
								Customer_Book_Table.StartRecordNumber = StartRec ' Save record position
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
						sReturnUrl = "Customer_Book_Tablelist.asp" ' No matching record, return to list
					Else
						Call LoadRowValues(Recordset) ' Load row values
					End If
			End Select
		Else
			sReturnUrl = "Customer_Book_Tablelist.asp" ' Not page request, return to list
		End If
		If sReturnUrl <> "" Then Call Page_Terminate(sReturnUrl)

		' Render row
		Customer_Book_Table.RowType = EW_ROWTYPE_VIEW
		Call Customer_Book_Table.ResetAttrs()
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
				Customer_Book_Table.StartRecordNumber = StartRec
			ElseIf Request.QueryString(EW_TABLE_PAGE_NO).Count > 0 Then
				PageNo = Request.QueryString(EW_TABLE_PAGE_NO)
				If IsNumeric(PageNo) Then
					StartRec = (PageNo-1)*DisplayRecs+1
					If StartRec <= 0 Then
						StartRec = 1
					ElseIf StartRec >= ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1 Then
						StartRec = ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1
					End If
					Customer_Book_Table.StartRecordNumber = StartRec
				End If
			End If
		End If
		StartRec = Customer_Book_Table.StartRecordNumber

		' Check if correct start record counter
		If Not IsNumeric(StartRec) Or StartRec = "" Then ' Avoid invalid start record counter
			StartRec = 1 ' Reset start record counter
			Customer_Book_Table.StartRecordNumber = StartRec
		ElseIf CLng(StartRec) > CLng(TotalRecs) Then ' Avoid starting record > total records
			StartRec = ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1 ' Point to last page first record
			Customer_Book_Table.StartRecordNumber = StartRec
		ElseIf (StartRec-1) Mod DisplayRecs <> 0 Then
			StartRec = ((StartRec-1)\DisplayRecs)*DisplayRecs+1 ' Point to page boundary
			Customer_Book_Table.StartRecordNumber = StartRec
		End If
	End Sub

	' -----------------------------------------------------------------
	' Load recordset
	'
	Function LoadRecordset()

		' Load list page sql
		Dim sSql
		sSql = Customer_Book_Table.SelectSQL
		Call ew_SetDebugMsg("LoadRecordset: " & sSql) ' Show SQL for debugging

		' Load recordset
		Dim RsRecordset
		Set RsRecordset = ew_LoadRecordset(sSql)

		' Call Recordset Selected event
		Call Customer_Book_Table.Recordset_Selected(RsRecordset)
		Set LoadRecordset = RsRecordset
	End Function

	' -----------------------------------------------------------------
	' Load row based on key values
	'
	Function LoadRow()
		Dim RsRow, sSql, sFilter
		sFilter = Customer_Book_Table.KeyFilter

		' Call Row Selecting event
		Call Customer_Book_Table.Row_Selecting(sFilter)

		' Load sql based on filter
		Customer_Book_Table.CurrentFilter = sFilter
		sSql = Customer_Book_Table.SQL
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
		Call Customer_Book_Table.Row_Selected(RsRow)
		Customer_Book_Table.ID.DbValue = RsRow("ID")
		Customer_Book_Table.Name.DbValue = RsRow("Name")
		Customer_Book_Table.Phone.DbValue = RsRow("Phone")
		Customer_Book_Table.bookdate.DbValue = RsRow("bookdate")
		Customer_Book_Table.IdBusinessDetail.DbValue = RsRow("IdBusinessDetail")
		Customer_Book_Table.comment.DbValue = RsRow("comment")
		Customer_Book_Table.s_contentemail.DbValue = RsRow("s_contentemail")
		Customer_Book_Table.numberpeople.DbValue = RsRow("numberpeople")
		Customer_Book_Table.createddate.DbValue = RsRow("createddate")
		Customer_Book_Table.zEmail.DbValue = RsRow("Email")
	End Sub

	' Load DbValue from recordset
	Sub LoadDbValues(Rs)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		If Rs.Eof Then Exit Sub
		Customer_Book_Table.ID.m_DbValue = Rs("ID")
		Customer_Book_Table.Name.m_DbValue = Rs("Name")
		Customer_Book_Table.Phone.m_DbValue = Rs("Phone")
		Customer_Book_Table.bookdate.m_DbValue = Rs("bookdate")
		Customer_Book_Table.IdBusinessDetail.m_DbValue = Rs("IdBusinessDetail")
		Customer_Book_Table.comment.m_DbValue = Rs("comment")
		Customer_Book_Table.s_contentemail.m_DbValue = Rs("s_contentemail")
		Customer_Book_Table.numberpeople.m_DbValue = Rs("numberpeople")
		Customer_Book_Table.createddate.m_DbValue = Rs("createddate")
		Customer_Book_Table.zEmail.m_DbValue = Rs("Email")
	End Sub

	' -----------------------------------------------------------------
	' Render row values based on field settings
	'
	Sub RenderRow()

		' Initialize urls
		AddUrl = Customer_Book_Table.AddUrl("")
		EditUrl = Customer_Book_Table.EditUrl("")
		CopyUrl = Customer_Book_Table.CopyUrl("")
		DeleteUrl = Customer_Book_Table.DeleteUrl
		ListUrl = Customer_Book_Table.ListUrl
		SetupOtherOptions()

		' Call Row Rendering event
		Call Customer_Book_Table.Row_Rendering()

		' ---------------------------------------
		'  Common render codes for all row types
		' ---------------------------------------
		' ID
		' Name
		' Phone
		' bookdate
		' IdBusinessDetail
		' comment
		' s_contentemail
		' numberpeople
		' createddate
		' Email
		' -----------
		'  View  Row
		' -----------

		If Customer_Book_Table.RowType = EW_ROWTYPE_VIEW Then ' View row

			' ID
			Customer_Book_Table.ID.ViewValue = Customer_Book_Table.ID.CurrentValue
			Customer_Book_Table.ID.ViewCustomAttributes = ""

			' Name
			Customer_Book_Table.Name.ViewValue = Customer_Book_Table.Name.CurrentValue
			Customer_Book_Table.Name.ViewCustomAttributes = ""

			' Phone
			Customer_Book_Table.Phone.ViewValue = Customer_Book_Table.Phone.CurrentValue
			Customer_Book_Table.Phone.ViewCustomAttributes = ""

			' bookdate
			Customer_Book_Table.bookdate.ViewValue = Customer_Book_Table.bookdate.CurrentValue
			Customer_Book_Table.bookdate.ViewCustomAttributes = ""

			' IdBusinessDetail
			Customer_Book_Table.IdBusinessDetail.ViewValue = Customer_Book_Table.IdBusinessDetail.CurrentValue
			Customer_Book_Table.IdBusinessDetail.ViewCustomAttributes = ""

			' comment
			Customer_Book_Table.comment.ViewValue = Customer_Book_Table.comment.CurrentValue
			Customer_Book_Table.comment.ViewCustomAttributes = ""

			' s_contentemail
			Customer_Book_Table.s_contentemail.ViewValue = Customer_Book_Table.s_contentemail.CurrentValue
			Customer_Book_Table.s_contentemail.ViewCustomAttributes = ""

			' numberpeople
			Customer_Book_Table.numberpeople.ViewValue = Customer_Book_Table.numberpeople.CurrentValue
			Customer_Book_Table.numberpeople.ViewCustomAttributes = ""

			' createddate
			Customer_Book_Table.createddate.ViewValue = Customer_Book_Table.createddate.CurrentValue
			Customer_Book_Table.createddate.ViewCustomAttributes = ""

			' Email
			Customer_Book_Table.zEmail.ViewValue = Customer_Book_Table.zEmail.CurrentValue
			Customer_Book_Table.zEmail.ViewCustomAttributes = ""

			' View refer script
			' ID

			Customer_Book_Table.ID.LinkCustomAttributes = ""
			Customer_Book_Table.ID.HrefValue = ""
			Customer_Book_Table.ID.TooltipValue = ""

			' Name
			Customer_Book_Table.Name.LinkCustomAttributes = ""
			Customer_Book_Table.Name.HrefValue = ""
			Customer_Book_Table.Name.TooltipValue = ""

			' Phone
			Customer_Book_Table.Phone.LinkCustomAttributes = ""
			Customer_Book_Table.Phone.HrefValue = ""
			Customer_Book_Table.Phone.TooltipValue = ""

			' bookdate
			Customer_Book_Table.bookdate.LinkCustomAttributes = ""
			Customer_Book_Table.bookdate.HrefValue = ""
			Customer_Book_Table.bookdate.TooltipValue = ""

			' IdBusinessDetail
			Customer_Book_Table.IdBusinessDetail.LinkCustomAttributes = ""
			Customer_Book_Table.IdBusinessDetail.HrefValue = ""
			Customer_Book_Table.IdBusinessDetail.TooltipValue = ""

			' comment
			Customer_Book_Table.comment.LinkCustomAttributes = ""
			Customer_Book_Table.comment.HrefValue = ""
			Customer_Book_Table.comment.TooltipValue = ""

			' s_contentemail
			Customer_Book_Table.s_contentemail.LinkCustomAttributes = ""
			Customer_Book_Table.s_contentemail.HrefValue = ""
			Customer_Book_Table.s_contentemail.TooltipValue = ""

			' numberpeople
			Customer_Book_Table.numberpeople.LinkCustomAttributes = ""
			Customer_Book_Table.numberpeople.HrefValue = ""
			Customer_Book_Table.numberpeople.TooltipValue = ""

			' createddate
			Customer_Book_Table.createddate.LinkCustomAttributes = ""
			Customer_Book_Table.createddate.HrefValue = ""
			Customer_Book_Table.createddate.TooltipValue = ""

			' Email
			Customer_Book_Table.zEmail.LinkCustomAttributes = ""
			Customer_Book_Table.zEmail.HrefValue = ""
			Customer_Book_Table.zEmail.TooltipValue = ""
		End If

		' Call Row Rendered event
		If Customer_Book_Table.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call Customer_Book_Table.Row_Rendered()
		End If
	End Sub

	' Set up Breadcrumb
	Sub SetupBreadcrumb()
		Dim PageId, url
		Set Breadcrumb = New cBreadcrumb
		url = Mid(ew_CurrentUrl, InStrRev(ew_CurrentUrl, "/")+1)
		Call Breadcrumb.Add("list", Customer_Book_Table.TableVar, "Customer_Book_Tablelist.asp", "", Customer_Book_Table.TableVar, True)
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
