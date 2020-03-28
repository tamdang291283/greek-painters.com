<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="Order_Receipt_trackinginfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim Order_Receipt_tracking_search
Set Order_Receipt_tracking_search = New cOrder_Receipt_tracking_search
Set Page = Order_Receipt_tracking_search

' Page init processing
Order_Receipt_tracking_search.Page_Init()

' Page main processing
Order_Receipt_tracking_search.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
Order_Receipt_tracking_search.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var Order_Receipt_tracking_search = new ew_Page("Order_Receipt_tracking_search");
Order_Receipt_tracking_search.PageID = "search"; // Page ID
var EW_PAGE_ID = Order_Receipt_tracking_search.PageID; // For backward compatibility
// Form object
var fOrder_Receipt_trackingsearch = new ew_Form("fOrder_Receipt_trackingsearch");
// Form_CustomValidate event
fOrder_Receipt_trackingsearch.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fOrder_Receipt_trackingsearch.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fOrder_Receipt_trackingsearch.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
// Validate function for search
fOrder_Receipt_trackingsearch.Validate = function(fobj) {
	if (!this.ValidateRequired)
		return true; // Ignore validation
	fobj = fobj || this.Form;
	this.PostAutoSuggest();
	var infix = "";
	elm = this.GetElements("x" + infix + "_l_id");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(Order_Receipt_tracking.l_id.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_OrderID");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(Order_Receipt_tracking.OrderID.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_t_createdDate");
	if (elm && !ew_CheckDate(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(Order_Receipt_tracking.t_createdDate.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_IdBusinessDetail");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(Order_Receipt_tracking.IdBusinessDetail.FldErrMsg) %>");
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
<% If Not Order_Receipt_tracking_search.IsModal Then %>
<div class="ewToolbar">
<% If Order_Receipt_tracking.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If Order_Receipt_tracking.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% End If %>
<% Order_Receipt_tracking_search.ShowPageHeader() %>
<% Order_Receipt_tracking_search.ShowMessage %>
<form name="fOrder_Receipt_trackingsearch" id="fOrder_Receipt_trackingsearch" class="form-horizontal ewForm ewSearchForm" action="<%= ew_CurrentPage %>" method="post">
<% If Order_Receipt_tracking_search.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= Order_Receipt_tracking_search.Token %>">
<% End If %>
<input type="hidden" name="t" value="Order_Receipt_tracking">
<input type="hidden" name="a_search" id="a_search" value="S">
<% If Order_Receipt_tracking_search.IsModal Then %>
<input type="hidden" name="modal" value="1">
<% End If %>
<div>
<% If Order_Receipt_tracking.l_id.Visible Then ' l_id %>
	<div id="r_l_id" class="form-group">
		<label for="x_l_id" class="<%= Order_Receipt_tracking_search.SearchLabelClass %>"><span id="elh_Order_Receipt_tracking_l_id"><%= Order_Receipt_tracking.l_id.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_l_id" id="z_l_id" value="="></p>
		</label>
		<div class="<%= Order_Receipt_tracking_search.SearchRightColumnClass %>"><div<%= Order_Receipt_tracking.l_id.CellAttributes %>>
			<span id="el_Order_Receipt_tracking_l_id">
<input type="text" data-field="x_l_id" name="x_l_id" id="x_l_id" placeholder="<%= Order_Receipt_tracking.l_id.PlaceHolder %>" value="<%= Order_Receipt_tracking.l_id.EditValue %>"<%= Order_Receipt_tracking.l_id.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Order_Receipt_tracking.OrderID.Visible Then ' OrderID %>
	<div id="r_OrderID" class="form-group">
		<label for="x_OrderID" class="<%= Order_Receipt_tracking_search.SearchLabelClass %>"><span id="elh_Order_Receipt_tracking_OrderID"><%= Order_Receipt_tracking.OrderID.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_OrderID" id="z_OrderID" value="="></p>
		</label>
		<div class="<%= Order_Receipt_tracking_search.SearchRightColumnClass %>"><div<%= Order_Receipt_tracking.OrderID.CellAttributes %>>
			<span id="el_Order_Receipt_tracking_OrderID">
<input type="text" data-field="x_OrderID" name="x_OrderID" id="x_OrderID" size="30" placeholder="<%= Order_Receipt_tracking.OrderID.PlaceHolder %>" value="<%= Order_Receipt_tracking.OrderID.EditValue %>"<%= Order_Receipt_tracking.OrderID.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Order_Receipt_tracking.s_printtype.Visible Then ' s_printtype %>
	<div id="r_s_printtype" class="form-group">
		<label for="x_s_printtype" class="<%= Order_Receipt_tracking_search.SearchLabelClass %>"><span id="elh_Order_Receipt_tracking_s_printtype"><%= Order_Receipt_tracking.s_printtype.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_s_printtype" id="z_s_printtype" value="LIKE"></p>
		</label>
		<div class="<%= Order_Receipt_tracking_search.SearchRightColumnClass %>"><div<%= Order_Receipt_tracking.s_printtype.CellAttributes %>>
			<span id="el_Order_Receipt_tracking_s_printtype">
<input type="text" data-field="x_s_printtype" name="x_s_printtype" id="x_s_printtype" size="30" maxlength="255" placeholder="<%= Order_Receipt_tracking.s_printtype.PlaceHolder %>" value="<%= Order_Receipt_tracking.s_printtype.EditValue %>"<%= Order_Receipt_tracking.s_printtype.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Order_Receipt_tracking.s_filename.Visible Then ' s_filename %>
	<div id="r_s_filename" class="form-group">
		<label for="x_s_filename" class="<%= Order_Receipt_tracking_search.SearchLabelClass %>"><span id="elh_Order_Receipt_tracking_s_filename"><%= Order_Receipt_tracking.s_filename.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_s_filename" id="z_s_filename" value="LIKE"></p>
		</label>
		<div class="<%= Order_Receipt_tracking_search.SearchRightColumnClass %>"><div<%= Order_Receipt_tracking.s_filename.CellAttributes %>>
			<span id="el_Order_Receipt_tracking_s_filename">
<input type="text" data-field="x_s_filename" name="x_s_filename" id="x_s_filename" size="30" maxlength="255" placeholder="<%= Order_Receipt_tracking.s_filename.PlaceHolder %>" value="<%= Order_Receipt_tracking.s_filename.EditValue %>"<%= Order_Receipt_tracking.s_filename.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Order_Receipt_tracking.t_createdDate.Visible Then ' t_createdDate %>
	<div id="r_t_createdDate" class="form-group">
		<label for="x_t_createdDate" class="<%= Order_Receipt_tracking_search.SearchLabelClass %>"><span id="elh_Order_Receipt_tracking_t_createdDate"><%= Order_Receipt_tracking.t_createdDate.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_t_createdDate" id="z_t_createdDate" value="="></p>
		</label>
		<div class="<%= Order_Receipt_tracking_search.SearchRightColumnClass %>"><div<%= Order_Receipt_tracking.t_createdDate.CellAttributes %>>
			<span id="el_Order_Receipt_tracking_t_createdDate">
<input type="text" data-field="x_t_createdDate" name="x_t_createdDate" id="x_t_createdDate" placeholder="<%= Order_Receipt_tracking.t_createdDate.PlaceHolder %>" value="<%= Order_Receipt_tracking.t_createdDate.EditValue %>"<%= Order_Receipt_tracking.t_createdDate.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Order_Receipt_tracking.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
	<div id="r_IdBusinessDetail" class="form-group">
		<label for="x_IdBusinessDetail" class="<%= Order_Receipt_tracking_search.SearchLabelClass %>"><span id="elh_Order_Receipt_tracking_IdBusinessDetail"><%= Order_Receipt_tracking.IdBusinessDetail.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_IdBusinessDetail" id="z_IdBusinessDetail" value="="></p>
		</label>
		<div class="<%= Order_Receipt_tracking_search.SearchRightColumnClass %>"><div<%= Order_Receipt_tracking.IdBusinessDetail.CellAttributes %>>
			<span id="el_Order_Receipt_tracking_IdBusinessDetail">
<input type="text" data-field="x_IdBusinessDetail" name="x_IdBusinessDetail" id="x_IdBusinessDetail" size="30" placeholder="<%= Order_Receipt_tracking.IdBusinessDetail.PlaceHolder %>" value="<%= Order_Receipt_tracking.IdBusinessDetail.EditValue %>"<%= Order_Receipt_tracking.IdBusinessDetail.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Order_Receipt_tracking.s_printstatus.Visible Then ' s_printstatus %>
	<div id="r_s_printstatus" class="form-group">
		<label for="x_s_printstatus" class="<%= Order_Receipt_tracking_search.SearchLabelClass %>"><span id="elh_Order_Receipt_tracking_s_printstatus"><%= Order_Receipt_tracking.s_printstatus.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_s_printstatus" id="z_s_printstatus" value="LIKE"></p>
		</label>
		<div class="<%= Order_Receipt_tracking_search.SearchRightColumnClass %>"><div<%= Order_Receipt_tracking.s_printstatus.CellAttributes %>>
			<span id="el_Order_Receipt_tracking_s_printstatus">
<input type="text" data-field="x_s_printstatus" name="x_s_printstatus" id="x_s_printstatus" size="30" maxlength="255" placeholder="<%= Order_Receipt_tracking.s_printstatus.PlaceHolder %>" value="<%= Order_Receipt_tracking.s_printstatus.EditValue %>"<%= Order_Receipt_tracking.s_printstatus.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
</div>
<% If Not Order_Receipt_tracking_search.IsModal Then %>
<div class="form-group">
	<div class="col-sm-offset-3 col-sm-9">
<button class="btn btn-primary ewButton" name="btnAction" id="btnAction" type="submit"><%= Language.Phrase("Search") %></button>
<button class="btn btn-default ewButton" name="btnReset" id="btnReset" type="button" onclick="ew_ClearForm(this.form);"><%= Language.Phrase("Reset") %></button>
	</div>
</div>
<% End If %>
</form>
<script type="text/javascript">
fOrder_Receipt_trackingsearch.Init();
</script>
<%
Order_Receipt_tracking_search.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set Order_Receipt_tracking_search = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cOrder_Receipt_tracking_search

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
		TableName = "Order_Receipt_tracking"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "Order_Receipt_tracking_search"
	End Property

	' Page Name
	Public Property Get PageName()
		PageName = ew_CurrentPage()
	End Property

	' Page Url
	Public Property Get PageUrl()
		PageUrl = ew_CurrentPage() & "?"
		If Order_Receipt_tracking.UseTokenInUrl Then PageUrl = PageUrl & "t=" & Order_Receipt_tracking.TableVar & "&" ' add page token
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
		If Order_Receipt_tracking.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (Order_Receipt_tracking.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (Order_Receipt_tracking.TableVar = Request.QueryString("t"))
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
		If IsEmpty(Order_Receipt_tracking) Then Set Order_Receipt_tracking = New cOrder_Receipt_tracking
		Set Table = Order_Receipt_tracking

		' Initialize urls
		' Initialize form object

		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "search"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "Order_Receipt_tracking"

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

		Order_Receipt_tracking.CurrentAction = ew_IIf(Request.QueryString("a").Count > 0, Request.QueryString("a") & "", ObjForm.GetValue("a_list") & "") ' Set up current action
		Order_Receipt_tracking.l_id.Visible = Not Order_Receipt_tracking.IsAdd() And Not Order_Receipt_tracking.IsCopy() And Not Order_Receipt_tracking.IsGridAdd()

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
			results = Order_Receipt_tracking.GetAutoFill(Request.Form("name"), Request.Form("q"))
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
		If Not Order_Receipt_tracking Is Nothing Then
			If Order_Receipt_tracking.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = Order_Receipt_tracking.TableVar
				If Order_Receipt_tracking.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf Order_Receipt_tracking.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf Order_Receipt_tracking.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf Order_Receipt_tracking.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set Order_Receipt_tracking = Nothing
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
			Order_Receipt_tracking.CurrentAction = ObjForm.GetValue("a_search")
			Select Case Order_Receipt_tracking.CurrentAction
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
						sSrchStr = Order_Receipt_tracking.UrlParm(sSrchStr)
						sSrchStr = "Order_Receipt_trackinglist.asp" & "?" & sSrchStr
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
		Order_Receipt_tracking.RowType = EW_ROWTYPE_SEARCH
		Call RenderRow()
	End Sub

	' -----------------------------------------------------------------
	' Build advanced search
	'
	Function BuildAdvancedSearch()
		Dim sSrchUrl
		sSrchUrl = ""
		Call BuildSearchUrl(sSrchUrl, Order_Receipt_tracking.l_id, False) ' l_id
		Call BuildSearchUrl(sSrchUrl, Order_Receipt_tracking.OrderID, False) ' OrderID
		Call BuildSearchUrl(sSrchUrl, Order_Receipt_tracking.s_printtype, False) ' s_printtype
		Call BuildSearchUrl(sSrchUrl, Order_Receipt_tracking.s_filename, False) ' s_filename
		Call BuildSearchUrl(sSrchUrl, Order_Receipt_tracking.t_createdDate, False) ' t_createdDate
		Call BuildSearchUrl(sSrchUrl, Order_Receipt_tracking.IdBusinessDetail, False) ' IdBusinessDetail
		Call BuildSearchUrl(sSrchUrl, Order_Receipt_tracking.s_printstatus, False) ' s_printstatus
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
		Order_Receipt_tracking.l_id.AdvancedSearch.SearchValue = ObjForm.GetValue("x_l_id")
		Order_Receipt_tracking.l_id.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_l_id")
		Order_Receipt_tracking.OrderID.AdvancedSearch.SearchValue = ObjForm.GetValue("x_OrderID")
		Order_Receipt_tracking.OrderID.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_OrderID")
		Order_Receipt_tracking.s_printtype.AdvancedSearch.SearchValue = ObjForm.GetValue("x_s_printtype")
		Order_Receipt_tracking.s_printtype.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_s_printtype")
		Order_Receipt_tracking.s_filename.AdvancedSearch.SearchValue = ObjForm.GetValue("x_s_filename")
		Order_Receipt_tracking.s_filename.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_s_filename")
		Order_Receipt_tracking.t_createdDate.AdvancedSearch.SearchValue = ObjForm.GetValue("x_t_createdDate")
		Order_Receipt_tracking.t_createdDate.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_t_createdDate")
		Order_Receipt_tracking.IdBusinessDetail.AdvancedSearch.SearchValue = ObjForm.GetValue("x_IdBusinessDetail")
		Order_Receipt_tracking.IdBusinessDetail.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_IdBusinessDetail")
		Order_Receipt_tracking.s_printstatus.AdvancedSearch.SearchValue = ObjForm.GetValue("x_s_printstatus")
		Order_Receipt_tracking.s_printstatus.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_s_printstatus")
	End Function

	' -----------------------------------------------------------------
	' Render row values based on field settings
	'
	Sub RenderRow()

		' Initialize urls
		' Call Row Rendering event

		Call Order_Receipt_tracking.Row_Rendering()

		' ---------------------------------------
		'  Common render codes for all row types
		' ---------------------------------------
		' l_id
		' OrderID
		' s_printtype
		' s_filename
		' t_createdDate
		' IdBusinessDetail
		' s_printstatus
		' -----------
		'  View  Row
		' -----------

		If Order_Receipt_tracking.RowType = EW_ROWTYPE_VIEW Then ' View row

			' l_id
			Order_Receipt_tracking.l_id.ViewValue = Order_Receipt_tracking.l_id.CurrentValue
			Order_Receipt_tracking.l_id.ViewCustomAttributes = ""

			' OrderID
			Order_Receipt_tracking.OrderID.ViewValue = Order_Receipt_tracking.OrderID.CurrentValue
			Order_Receipt_tracking.OrderID.ViewCustomAttributes = ""

			' s_printtype
			Order_Receipt_tracking.s_printtype.ViewValue = Order_Receipt_tracking.s_printtype.CurrentValue
			Order_Receipt_tracking.s_printtype.ViewCustomAttributes = ""

			' s_filename
			Order_Receipt_tracking.s_filename.ViewValue = Order_Receipt_tracking.s_filename.CurrentValue
			Order_Receipt_tracking.s_filename.ViewCustomAttributes = ""

			' t_createdDate
			Order_Receipt_tracking.t_createdDate.ViewValue = Order_Receipt_tracking.t_createdDate.CurrentValue
			Order_Receipt_tracking.t_createdDate.ViewValue = ew_FormatDateTime(Order_Receipt_tracking.t_createdDate.ViewValue, 9)
			Order_Receipt_tracking.t_createdDate.ViewCustomAttributes = ""

			' IdBusinessDetail
			Order_Receipt_tracking.IdBusinessDetail.ViewValue = Order_Receipt_tracking.IdBusinessDetail.CurrentValue
			Order_Receipt_tracking.IdBusinessDetail.ViewCustomAttributes = ""

			' s_printstatus
			Order_Receipt_tracking.s_printstatus.ViewValue = Order_Receipt_tracking.s_printstatus.CurrentValue
			Order_Receipt_tracking.s_printstatus.ViewCustomAttributes = ""

			' View refer script
			' l_id

			Order_Receipt_tracking.l_id.LinkCustomAttributes = ""
			Order_Receipt_tracking.l_id.HrefValue = ""
			Order_Receipt_tracking.l_id.TooltipValue = ""

			' OrderID
			Order_Receipt_tracking.OrderID.LinkCustomAttributes = ""
			Order_Receipt_tracking.OrderID.HrefValue = ""
			Order_Receipt_tracking.OrderID.TooltipValue = ""

			' s_printtype
			Order_Receipt_tracking.s_printtype.LinkCustomAttributes = ""
			Order_Receipt_tracking.s_printtype.HrefValue = ""
			Order_Receipt_tracking.s_printtype.TooltipValue = ""

			' s_filename
			Order_Receipt_tracking.s_filename.LinkCustomAttributes = ""
			Order_Receipt_tracking.s_filename.HrefValue = ""
			Order_Receipt_tracking.s_filename.TooltipValue = ""

			' t_createdDate
			Order_Receipt_tracking.t_createdDate.LinkCustomAttributes = ""
			Order_Receipt_tracking.t_createdDate.HrefValue = ""
			Order_Receipt_tracking.t_createdDate.TooltipValue = ""

			' IdBusinessDetail
			Order_Receipt_tracking.IdBusinessDetail.LinkCustomAttributes = ""
			Order_Receipt_tracking.IdBusinessDetail.HrefValue = ""
			Order_Receipt_tracking.IdBusinessDetail.TooltipValue = ""

			' s_printstatus
			Order_Receipt_tracking.s_printstatus.LinkCustomAttributes = ""
			Order_Receipt_tracking.s_printstatus.HrefValue = ""
			Order_Receipt_tracking.s_printstatus.TooltipValue = ""

		' ------------
		'  Search Row
		' ------------

		ElseIf Order_Receipt_tracking.RowType = EW_ROWTYPE_SEARCH Then ' Search row

			' l_id
			Order_Receipt_tracking.l_id.EditAttrs.UpdateAttribute "class", "form-control"
			Order_Receipt_tracking.l_id.EditCustomAttributes = ""
			Order_Receipt_tracking.l_id.EditValue = ew_HtmlEncode(Order_Receipt_tracking.l_id.AdvancedSearch.SearchValue)
			Order_Receipt_tracking.l_id.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Order_Receipt_tracking.l_id.FldCaption))

			' OrderID
			Order_Receipt_tracking.OrderID.EditAttrs.UpdateAttribute "class", "form-control"
			Order_Receipt_tracking.OrderID.EditCustomAttributes = ""
			Order_Receipt_tracking.OrderID.EditValue = ew_HtmlEncode(Order_Receipt_tracking.OrderID.AdvancedSearch.SearchValue)
			Order_Receipt_tracking.OrderID.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Order_Receipt_tracking.OrderID.FldCaption))

			' s_printtype
			Order_Receipt_tracking.s_printtype.EditAttrs.UpdateAttribute "class", "form-control"
			Order_Receipt_tracking.s_printtype.EditCustomAttributes = ""
			Order_Receipt_tracking.s_printtype.EditValue = ew_HtmlEncode(Order_Receipt_tracking.s_printtype.AdvancedSearch.SearchValue)
			Order_Receipt_tracking.s_printtype.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Order_Receipt_tracking.s_printtype.FldCaption))

			' s_filename
			Order_Receipt_tracking.s_filename.EditAttrs.UpdateAttribute "class", "form-control"
			Order_Receipt_tracking.s_filename.EditCustomAttributes = ""
			Order_Receipt_tracking.s_filename.EditValue = ew_HtmlEncode(Order_Receipt_tracking.s_filename.AdvancedSearch.SearchValue)
			Order_Receipt_tracking.s_filename.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Order_Receipt_tracking.s_filename.FldCaption))

			' t_createdDate
			Order_Receipt_tracking.t_createdDate.EditAttrs.UpdateAttribute "class", "form-control"
			Order_Receipt_tracking.t_createdDate.EditCustomAttributes = ""
			Order_Receipt_tracking.t_createdDate.EditValue = ew_FormatDateTime(ew_UnFormatDateTime(Order_Receipt_tracking.t_createdDate.AdvancedSearch.SearchValue, 9), 9)
			Order_Receipt_tracking.t_createdDate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Order_Receipt_tracking.t_createdDate.FldCaption))

			' IdBusinessDetail
			Order_Receipt_tracking.IdBusinessDetail.EditAttrs.UpdateAttribute "class", "form-control"
			Order_Receipt_tracking.IdBusinessDetail.EditCustomAttributes = ""
			Order_Receipt_tracking.IdBusinessDetail.EditValue = ew_HtmlEncode(Order_Receipt_tracking.IdBusinessDetail.AdvancedSearch.SearchValue)
			Order_Receipt_tracking.IdBusinessDetail.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Order_Receipt_tracking.IdBusinessDetail.FldCaption))

			' s_printstatus
			Order_Receipt_tracking.s_printstatus.EditAttrs.UpdateAttribute "class", "form-control"
			Order_Receipt_tracking.s_printstatus.EditCustomAttributes = ""
			Order_Receipt_tracking.s_printstatus.EditValue = ew_HtmlEncode(Order_Receipt_tracking.s_printstatus.AdvancedSearch.SearchValue)
			Order_Receipt_tracking.s_printstatus.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Order_Receipt_tracking.s_printstatus.FldCaption))
		End If
		If Order_Receipt_tracking.RowType = EW_ROWTYPE_ADD Or Order_Receipt_tracking.RowType = EW_ROWTYPE_EDIT Or Order_Receipt_tracking.RowType = EW_ROWTYPE_SEARCH Then ' Add / Edit / Search row
			Call Order_Receipt_tracking.SetupFieldTitles()
		End If

		' Call Row Rendered event
		If Order_Receipt_tracking.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call Order_Receipt_tracking.Row_Rendered()
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
		If Not ew_CheckInteger(Order_Receipt_tracking.l_id.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, Order_Receipt_tracking.l_id.FldErrMsg)
		End If
		If Not ew_CheckInteger(Order_Receipt_tracking.OrderID.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, Order_Receipt_tracking.OrderID.FldErrMsg)
		End If
		If Not ew_CheckDate(Order_Receipt_tracking.t_createdDate.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, Order_Receipt_tracking.t_createdDate.FldErrMsg)
		End If
		If Not ew_CheckInteger(Order_Receipt_tracking.IdBusinessDetail.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, Order_Receipt_tracking.IdBusinessDetail.FldErrMsg)
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
		Call Order_Receipt_tracking.l_id.AdvancedSearch.Load()
		Call Order_Receipt_tracking.OrderID.AdvancedSearch.Load()
		Call Order_Receipt_tracking.s_printtype.AdvancedSearch.Load()
		Call Order_Receipt_tracking.s_filename.AdvancedSearch.Load()
		Call Order_Receipt_tracking.t_createdDate.AdvancedSearch.Load()
		Call Order_Receipt_tracking.IdBusinessDetail.AdvancedSearch.Load()
		Call Order_Receipt_tracking.s_printstatus.AdvancedSearch.Load()
End Function

	' Set up Breadcrumb
	Sub SetupBreadcrumb()
		Dim PageId, url
		Set Breadcrumb = New cBreadcrumb
		url = Mid(ew_CurrentUrl, InStrRev(ew_CurrentUrl, "/")+1)
		Call Breadcrumb.Add("list", Order_Receipt_tracking.TableVar, "Order_Receipt_trackinglist.asp", "", Order_Receipt_tracking.TableVar, True)
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
