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
Dim Customer_Book_Table_search
Set Customer_Book_Table_search = New cCustomer_Book_Table_search
Set Page = Customer_Book_Table_search

' Page init processing
Customer_Book_Table_search.Page_Init()

' Page main processing
Customer_Book_Table_search.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
Customer_Book_Table_search.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var Customer_Book_Table_search = new ew_Page("Customer_Book_Table_search");
Customer_Book_Table_search.PageID = "search"; // Page ID
var EW_PAGE_ID = Customer_Book_Table_search.PageID; // For backward compatibility
// Form object
var fCustomer_Book_Tablesearch = new ew_Form("fCustomer_Book_Tablesearch");
// Form_CustomValidate event
fCustomer_Book_Tablesearch.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fCustomer_Book_Tablesearch.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fCustomer_Book_Tablesearch.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
// Validate function for search
fCustomer_Book_Tablesearch.Validate = function(fobj) {
	if (!this.ValidateRequired)
		return true; // Ignore validation
	fobj = fobj || this.Form;
	this.PostAutoSuggest();
	var infix = "";
	elm = this.GetElements("x" + infix + "_ID");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(Customer_Book_Table.ID.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_bookdate");
	if (elm && !ew_CheckDate(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(Customer_Book_Table.bookdate.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_IdBusinessDetail");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(Customer_Book_Table.IdBusinessDetail.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_numberpeople");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(Customer_Book_Table.numberpeople.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_createddate");
	if (elm && !ew_CheckDate(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(Customer_Book_Table.createddate.FldErrMsg) %>");
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
<% If Not Customer_Book_Table_search.IsModal Then %>
<div class="ewToolbar">
<% If Customer_Book_Table.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If Customer_Book_Table.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% End If %>
<% Customer_Book_Table_search.ShowPageHeader() %>
<% Customer_Book_Table_search.ShowMessage %>
<form name="fCustomer_Book_Tablesearch" id="fCustomer_Book_Tablesearch" class="form-horizontal ewForm ewSearchForm" action="<%= ew_CurrentPage %>" method="post">
<% If Customer_Book_Table_search.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= Customer_Book_Table_search.Token %>">
<% End If %>
<input type="hidden" name="t" value="Customer_Book_Table">
<input type="hidden" name="a_search" id="a_search" value="S">
<% If Customer_Book_Table_search.IsModal Then %>
<input type="hidden" name="modal" value="1">
<% End If %>
<div>
<% If Customer_Book_Table.ID.Visible Then ' ID %>
	<div id="r_ID" class="form-group">
		<label for="x_ID" class="<%= Customer_Book_Table_search.SearchLabelClass %>"><span id="elh_Customer_Book_Table_ID"><%= Customer_Book_Table.ID.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_ID" id="z_ID" value="="></p>
		</label>
		<div class="<%= Customer_Book_Table_search.SearchRightColumnClass %>"><div<%= Customer_Book_Table.ID.CellAttributes %>>
			<span id="el_Customer_Book_Table_ID">
<input type="text" data-field="x_ID" name="x_ID" id="x_ID" placeholder="<%= Customer_Book_Table.ID.PlaceHolder %>" value="<%= Customer_Book_Table.ID.EditValue %>"<%= Customer_Book_Table.ID.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Customer_Book_Table.Name.Visible Then ' Name %>
	<div id="r_Name" class="form-group">
		<label for="x_Name" class="<%= Customer_Book_Table_search.SearchLabelClass %>"><span id="elh_Customer_Book_Table_Name"><%= Customer_Book_Table.Name.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_Name" id="z_Name" value="LIKE"></p>
		</label>
		<div class="<%= Customer_Book_Table_search.SearchRightColumnClass %>"><div<%= Customer_Book_Table.Name.CellAttributes %>>
			<span id="el_Customer_Book_Table_Name">
<input type="text" data-field="x_Name" name="x_Name" id="x_Name" size="30" maxlength="255" placeholder="<%= Customer_Book_Table.Name.PlaceHolder %>" value="<%= Customer_Book_Table.Name.EditValue %>"<%= Customer_Book_Table.Name.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Customer_Book_Table.Phone.Visible Then ' Phone %>
	<div id="r_Phone" class="form-group">
		<label for="x_Phone" class="<%= Customer_Book_Table_search.SearchLabelClass %>"><span id="elh_Customer_Book_Table_Phone"><%= Customer_Book_Table.Phone.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_Phone" id="z_Phone" value="LIKE"></p>
		</label>
		<div class="<%= Customer_Book_Table_search.SearchRightColumnClass %>"><div<%= Customer_Book_Table.Phone.CellAttributes %>>
			<span id="el_Customer_Book_Table_Phone">
<input type="text" data-field="x_Phone" name="x_Phone" id="x_Phone" size="30" maxlength="255" placeholder="<%= Customer_Book_Table.Phone.PlaceHolder %>" value="<%= Customer_Book_Table.Phone.EditValue %>"<%= Customer_Book_Table.Phone.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Customer_Book_Table.bookdate.Visible Then ' bookdate %>
	<div id="r_bookdate" class="form-group">
		<label for="x_bookdate" class="<%= Customer_Book_Table_search.SearchLabelClass %>"><span id="elh_Customer_Book_Table_bookdate"><%= Customer_Book_Table.bookdate.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_bookdate" id="z_bookdate" value="="></p>
		</label>
		<div class="<%= Customer_Book_Table_search.SearchRightColumnClass %>"><div<%= Customer_Book_Table.bookdate.CellAttributes %>>
			<span id="el_Customer_Book_Table_bookdate">
<input type="text" data-field="x_bookdate" name="x_bookdate" id="x_bookdate" placeholder="<%= Customer_Book_Table.bookdate.PlaceHolder %>" value="<%= Customer_Book_Table.bookdate.EditValue %>"<%= Customer_Book_Table.bookdate.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Customer_Book_Table.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
	<div id="r_IdBusinessDetail" class="form-group">
		<label for="x_IdBusinessDetail" class="<%= Customer_Book_Table_search.SearchLabelClass %>"><span id="elh_Customer_Book_Table_IdBusinessDetail"><%= Customer_Book_Table.IdBusinessDetail.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_IdBusinessDetail" id="z_IdBusinessDetail" value="="></p>
		</label>
		<div class="<%= Customer_Book_Table_search.SearchRightColumnClass %>"><div<%= Customer_Book_Table.IdBusinessDetail.CellAttributes %>>
			<span id="el_Customer_Book_Table_IdBusinessDetail">
<input type="text" data-field="x_IdBusinessDetail" name="x_IdBusinessDetail" id="x_IdBusinessDetail" size="30" placeholder="<%= Customer_Book_Table.IdBusinessDetail.PlaceHolder %>" value="<%= Customer_Book_Table.IdBusinessDetail.EditValue %>"<%= Customer_Book_Table.IdBusinessDetail.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Customer_Book_Table.comment.Visible Then ' comment %>
	<div id="r_comment" class="form-group">
		<label for="x_comment" class="<%= Customer_Book_Table_search.SearchLabelClass %>"><span id="elh_Customer_Book_Table_comment"><%= Customer_Book_Table.comment.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_comment" id="z_comment" value="LIKE"></p>
		</label>
		<div class="<%= Customer_Book_Table_search.SearchRightColumnClass %>"><div<%= Customer_Book_Table.comment.CellAttributes %>>
			<span id="el_Customer_Book_Table_comment">
<input type="text" data-field="x_comment" name="x_comment" id="x_comment" size="35" placeholder="<%= Customer_Book_Table.comment.PlaceHolder %>" value="<%= Customer_Book_Table.comment.EditValue %>"<%= Customer_Book_Table.comment.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Customer_Book_Table.s_contentemail.Visible Then ' s_contentemail %>
	<div id="r_s_contentemail" class="form-group">
		<label for="x_s_contentemail" class="<%= Customer_Book_Table_search.SearchLabelClass %>"><span id="elh_Customer_Book_Table_s_contentemail"><%= Customer_Book_Table.s_contentemail.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_s_contentemail" id="z_s_contentemail" value="LIKE"></p>
		</label>
		<div class="<%= Customer_Book_Table_search.SearchRightColumnClass %>"><div<%= Customer_Book_Table.s_contentemail.CellAttributes %>>
			<span id="el_Customer_Book_Table_s_contentemail">
<input type="text" data-field="x_s_contentemail" name="x_s_contentemail" id="x_s_contentemail" size="35" placeholder="<%= Customer_Book_Table.s_contentemail.PlaceHolder %>" value="<%= Customer_Book_Table.s_contentemail.EditValue %>"<%= Customer_Book_Table.s_contentemail.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Customer_Book_Table.numberpeople.Visible Then ' numberpeople %>
	<div id="r_numberpeople" class="form-group">
		<label for="x_numberpeople" class="<%= Customer_Book_Table_search.SearchLabelClass %>"><span id="elh_Customer_Book_Table_numberpeople"><%= Customer_Book_Table.numberpeople.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_numberpeople" id="z_numberpeople" value="="></p>
		</label>
		<div class="<%= Customer_Book_Table_search.SearchRightColumnClass %>"><div<%= Customer_Book_Table.numberpeople.CellAttributes %>>
			<span id="el_Customer_Book_Table_numberpeople">
<input type="text" data-field="x_numberpeople" name="x_numberpeople" id="x_numberpeople" size="30" placeholder="<%= Customer_Book_Table.numberpeople.PlaceHolder %>" value="<%= Customer_Book_Table.numberpeople.EditValue %>"<%= Customer_Book_Table.numberpeople.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Customer_Book_Table.createddate.Visible Then ' createddate %>
	<div id="r_createddate" class="form-group">
		<label for="x_createddate" class="<%= Customer_Book_Table_search.SearchLabelClass %>"><span id="elh_Customer_Book_Table_createddate"><%= Customer_Book_Table.createddate.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_createddate" id="z_createddate" value="="></p>
		</label>
		<div class="<%= Customer_Book_Table_search.SearchRightColumnClass %>"><div<%= Customer_Book_Table.createddate.CellAttributes %>>
			<span id="el_Customer_Book_Table_createddate">
<input type="text" data-field="x_createddate" name="x_createddate" id="x_createddate" placeholder="<%= Customer_Book_Table.createddate.PlaceHolder %>" value="<%= Customer_Book_Table.createddate.EditValue %>"<%= Customer_Book_Table.createddate.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Customer_Book_Table.zEmail.Visible Then ' Email %>
	<div id="r_zEmail" class="form-group">
		<label for="x_zEmail" class="<%= Customer_Book_Table_search.SearchLabelClass %>"><span id="elh_Customer_Book_Table_zEmail"><%= Customer_Book_Table.zEmail.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_zEmail" id="z_zEmail" value="LIKE"></p>
		</label>
		<div class="<%= Customer_Book_Table_search.SearchRightColumnClass %>"><div<%= Customer_Book_Table.zEmail.CellAttributes %>>
			<span id="el_Customer_Book_Table_zEmail">
<input type="text" data-field="x_zEmail" name="x_zEmail" id="x_zEmail" size="30" maxlength="255" placeholder="<%= Customer_Book_Table.zEmail.PlaceHolder %>" value="<%= Customer_Book_Table.zEmail.EditValue %>"<%= Customer_Book_Table.zEmail.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
</div>
<% If Not Customer_Book_Table_search.IsModal Then %>
<div class="form-group">
	<div class="col-sm-offset-3 col-sm-9">
<button class="btn btn-primary ewButton" name="btnAction" id="btnAction" type="submit"><%= Language.Phrase("Search") %></button>
<button class="btn btn-default ewButton" name="btnReset" id="btnReset" type="button" onclick="ew_ClearForm(this.form);"><%= Language.Phrase("Reset") %></button>
	</div>
</div>
<% End If %>
</form>
<script type="text/javascript">
fCustomer_Book_Tablesearch.Init();
</script>
<%
Customer_Book_Table_search.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set Customer_Book_Table_search = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cCustomer_Book_Table_search

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
		TableName = "Customer_Book_Table"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "Customer_Book_Table_search"
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

		' Initialize urls
		' Initialize form object

		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "search"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "Customer_Book_Table"

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

		Customer_Book_Table.CurrentAction = ew_IIf(Request.QueryString("a").Count > 0, Request.QueryString("a") & "", ObjForm.GetValue("a_list") & "") ' Set up current action
		Customer_Book_Table.ID.Visible = Not Customer_Book_Table.IsAdd() And Not Customer_Book_Table.IsCopy() And Not Customer_Book_Table.IsGridAdd()

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
			Customer_Book_Table.CurrentAction = ObjForm.GetValue("a_search")
			Select Case Customer_Book_Table.CurrentAction
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
						sSrchStr = Customer_Book_Table.UrlParm(sSrchStr)
						sSrchStr = "Customer_Book_Tablelist.asp" & "?" & sSrchStr
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
		Customer_Book_Table.RowType = EW_ROWTYPE_SEARCH
		Call RenderRow()
	End Sub

	' -----------------------------------------------------------------
	' Build advanced search
	'
	Function BuildAdvancedSearch()
		Dim sSrchUrl
		sSrchUrl = ""
		Call BuildSearchUrl(sSrchUrl, Customer_Book_Table.ID, False) ' ID
		Call BuildSearchUrl(sSrchUrl, Customer_Book_Table.Name, False) ' Name
		Call BuildSearchUrl(sSrchUrl, Customer_Book_Table.Phone, False) ' Phone
		Call BuildSearchUrl(sSrchUrl, Customer_Book_Table.bookdate, False) ' bookdate
		Call BuildSearchUrl(sSrchUrl, Customer_Book_Table.IdBusinessDetail, False) ' IdBusinessDetail
		Call BuildSearchUrl(sSrchUrl, Customer_Book_Table.comment, False) ' comment
		Call BuildSearchUrl(sSrchUrl, Customer_Book_Table.s_contentemail, False) ' s_contentemail
		Call BuildSearchUrl(sSrchUrl, Customer_Book_Table.numberpeople, False) ' numberpeople
		Call BuildSearchUrl(sSrchUrl, Customer_Book_Table.createddate, False) ' createddate
		Call BuildSearchUrl(sSrchUrl, Customer_Book_Table.zEmail, False) ' Email
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
		Customer_Book_Table.ID.AdvancedSearch.SearchValue = ObjForm.GetValue("x_ID")
		Customer_Book_Table.ID.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_ID")
		Customer_Book_Table.Name.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Name")
		Customer_Book_Table.Name.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Name")
		Customer_Book_Table.Phone.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Phone")
		Customer_Book_Table.Phone.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Phone")
		Customer_Book_Table.bookdate.AdvancedSearch.SearchValue = ObjForm.GetValue("x_bookdate")
		Customer_Book_Table.bookdate.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_bookdate")
		Customer_Book_Table.IdBusinessDetail.AdvancedSearch.SearchValue = ObjForm.GetValue("x_IdBusinessDetail")
		Customer_Book_Table.IdBusinessDetail.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_IdBusinessDetail")
		Customer_Book_Table.comment.AdvancedSearch.SearchValue = ObjForm.GetValue("x_comment")
		Customer_Book_Table.comment.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_comment")
		Customer_Book_Table.s_contentemail.AdvancedSearch.SearchValue = ObjForm.GetValue("x_s_contentemail")
		Customer_Book_Table.s_contentemail.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_s_contentemail")
		Customer_Book_Table.numberpeople.AdvancedSearch.SearchValue = ObjForm.GetValue("x_numberpeople")
		Customer_Book_Table.numberpeople.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_numberpeople")
		Customer_Book_Table.createddate.AdvancedSearch.SearchValue = ObjForm.GetValue("x_createddate")
		Customer_Book_Table.createddate.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_createddate")
		Customer_Book_Table.zEmail.AdvancedSearch.SearchValue = ObjForm.GetValue("x_zEmail")
		Customer_Book_Table.zEmail.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_zEmail")
	End Function

	' -----------------------------------------------------------------
	' Render row values based on field settings
	'
	Sub RenderRow()

		' Initialize urls
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
			Customer_Book_Table.bookdate.ViewValue = ew_FormatDateTime(Customer_Book_Table.bookdate.ViewValue, 9)
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
			Customer_Book_Table.createddate.ViewValue = ew_FormatDateTime(Customer_Book_Table.createddate.ViewValue, 9)
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

		' ------------
		'  Search Row
		' ------------

		ElseIf Customer_Book_Table.RowType = EW_ROWTYPE_SEARCH Then ' Search row

			' ID
			Customer_Book_Table.ID.EditAttrs.UpdateAttribute "class", "form-control"
			Customer_Book_Table.ID.EditCustomAttributes = ""
			Customer_Book_Table.ID.EditValue = ew_HtmlEncode(Customer_Book_Table.ID.AdvancedSearch.SearchValue)
			Customer_Book_Table.ID.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Customer_Book_Table.ID.FldCaption))

			' Name
			Customer_Book_Table.Name.EditAttrs.UpdateAttribute "class", "form-control"
			Customer_Book_Table.Name.EditCustomAttributes = ""
			Customer_Book_Table.Name.EditValue = ew_HtmlEncode(Customer_Book_Table.Name.AdvancedSearch.SearchValue)
			Customer_Book_Table.Name.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Customer_Book_Table.Name.FldCaption))

			' Phone
			Customer_Book_Table.Phone.EditAttrs.UpdateAttribute "class", "form-control"
			Customer_Book_Table.Phone.EditCustomAttributes = ""
			Customer_Book_Table.Phone.EditValue = ew_HtmlEncode(Customer_Book_Table.Phone.AdvancedSearch.SearchValue)
			Customer_Book_Table.Phone.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Customer_Book_Table.Phone.FldCaption))

			' bookdate
			Customer_Book_Table.bookdate.EditAttrs.UpdateAttribute "class", "form-control"
			Customer_Book_Table.bookdate.EditCustomAttributes = ""
			Customer_Book_Table.bookdate.EditValue = ew_FormatDateTime(ew_UnFormatDateTime(Customer_Book_Table.bookdate.AdvancedSearch.SearchValue, 9), 9)
			Customer_Book_Table.bookdate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Customer_Book_Table.bookdate.FldCaption))

			' IdBusinessDetail
			Customer_Book_Table.IdBusinessDetail.EditAttrs.UpdateAttribute "class", "form-control"
			Customer_Book_Table.IdBusinessDetail.EditCustomAttributes = ""
			Customer_Book_Table.IdBusinessDetail.EditValue = ew_HtmlEncode(Customer_Book_Table.IdBusinessDetail.AdvancedSearch.SearchValue)
			Customer_Book_Table.IdBusinessDetail.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Customer_Book_Table.IdBusinessDetail.FldCaption))

			' comment
			Customer_Book_Table.comment.EditAttrs.UpdateAttribute "class", "form-control"
			Customer_Book_Table.comment.EditCustomAttributes = ""
			Customer_Book_Table.comment.EditValue = ew_HtmlEncode(Customer_Book_Table.comment.AdvancedSearch.SearchValue)
			Customer_Book_Table.comment.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Customer_Book_Table.comment.FldCaption))

			' s_contentemail
			Customer_Book_Table.s_contentemail.EditAttrs.UpdateAttribute "class", "form-control"
			Customer_Book_Table.s_contentemail.EditCustomAttributes = ""
			Customer_Book_Table.s_contentemail.EditValue = ew_HtmlEncode(Customer_Book_Table.s_contentemail.AdvancedSearch.SearchValue)
			Customer_Book_Table.s_contentemail.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Customer_Book_Table.s_contentemail.FldCaption))

			' numberpeople
			Customer_Book_Table.numberpeople.EditAttrs.UpdateAttribute "class", "form-control"
			Customer_Book_Table.numberpeople.EditCustomAttributes = ""
			Customer_Book_Table.numberpeople.EditValue = ew_HtmlEncode(Customer_Book_Table.numberpeople.AdvancedSearch.SearchValue)
			Customer_Book_Table.numberpeople.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Customer_Book_Table.numberpeople.FldCaption))

			' createddate
			Customer_Book_Table.createddate.EditAttrs.UpdateAttribute "class", "form-control"
			Customer_Book_Table.createddate.EditCustomAttributes = ""
			Customer_Book_Table.createddate.EditValue = ew_FormatDateTime(ew_UnFormatDateTime(Customer_Book_Table.createddate.AdvancedSearch.SearchValue, 9), 9)
			Customer_Book_Table.createddate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Customer_Book_Table.createddate.FldCaption))

			' Email
			Customer_Book_Table.zEmail.EditAttrs.UpdateAttribute "class", "form-control"
			Customer_Book_Table.zEmail.EditCustomAttributes = ""
			Customer_Book_Table.zEmail.EditValue = ew_HtmlEncode(Customer_Book_Table.zEmail.AdvancedSearch.SearchValue)
			Customer_Book_Table.zEmail.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Customer_Book_Table.zEmail.FldCaption))
		End If
		If Customer_Book_Table.RowType = EW_ROWTYPE_ADD Or Customer_Book_Table.RowType = EW_ROWTYPE_EDIT Or Customer_Book_Table.RowType = EW_ROWTYPE_SEARCH Then ' Add / Edit / Search row
			Call Customer_Book_Table.SetupFieldTitles()
		End If

		' Call Row Rendered event
		If Customer_Book_Table.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call Customer_Book_Table.Row_Rendered()
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
		If Not ew_CheckInteger(Customer_Book_Table.ID.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, Customer_Book_Table.ID.FldErrMsg)
		End If
		If Not ew_CheckDate(Customer_Book_Table.bookdate.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, Customer_Book_Table.bookdate.FldErrMsg)
		End If
		If Not ew_CheckInteger(Customer_Book_Table.IdBusinessDetail.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, Customer_Book_Table.IdBusinessDetail.FldErrMsg)
		End If
		If Not ew_CheckInteger(Customer_Book_Table.numberpeople.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, Customer_Book_Table.numberpeople.FldErrMsg)
		End If
		If Not ew_CheckDate(Customer_Book_Table.createddate.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, Customer_Book_Table.createddate.FldErrMsg)
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
		Call Customer_Book_Table.ID.AdvancedSearch.Load()
		Call Customer_Book_Table.Name.AdvancedSearch.Load()
		Call Customer_Book_Table.Phone.AdvancedSearch.Load()
		Call Customer_Book_Table.bookdate.AdvancedSearch.Load()
		Call Customer_Book_Table.IdBusinessDetail.AdvancedSearch.Load()
		Call Customer_Book_Table.comment.AdvancedSearch.Load()
		Call Customer_Book_Table.s_contentemail.AdvancedSearch.Load()
		Call Customer_Book_Table.numberpeople.AdvancedSearch.Load()
		Call Customer_Book_Table.createddate.AdvancedSearch.Load()
		Call Customer_Book_Table.zEmail.AdvancedSearch.Load()
End Function

	' Set up Breadcrumb
	Sub SetupBreadcrumb()
		Dim PageId, url
		Set Breadcrumb = New cBreadcrumb
		url = Mid(ew_CurrentUrl, InStrRev(ew_CurrentUrl, "/")+1)
		Call Breadcrumb.Add("list", Customer_Book_Table.TableVar, "Customer_Book_Tablelist.asp", "", Customer_Book_Table.TableVar, True)
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
