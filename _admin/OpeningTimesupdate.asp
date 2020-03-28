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
Dim OpeningTimes_update
Set OpeningTimes_update = New cOpeningTimes_update
Set Page = OpeningTimes_update

' Page init processing
OpeningTimes_update.Page_Init()

' Page main processing
OpeningTimes_update.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
OpeningTimes_update.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var OpeningTimes_update = new ew_Page("OpeningTimes_update");
OpeningTimes_update.PageID = "update"; // Page ID
var EW_PAGE_ID = OpeningTimes_update.PageID; // For backward compatibility
// Form object
var fOpeningTimesupdate = new ew_Form("fOpeningTimesupdate");
// Validate form
fOpeningTimesupdate.Validate = function() {
	if (!this.ValidateRequired)
		return true; // Ignore validation
	var $ = jQuery, fobj = this.GetForm(), $fobj = $(fobj);
	this.PostAutoSuggest();
	if ($fobj.find("#a_confirm").val() == "F")
		return true;
	if (!ew_UpdateSelected(fobj)) {
		alert(ewLanguage.Phrase("NoFieldSelected"));
		return false;
	}
	var elm, felm, uelm, addcnt = 0;
	var $k = $fobj.find("#" + this.FormKeyCountName); // Get key_count
	var rowcnt = ($k[0]) ? parseInt($k.val(), 10) : 1;
	var startcnt = (rowcnt == 0) ? 0 : 1; // Check rowcnt == 0 => Inline-Add
	var gridinsert = $fobj.find("#a_list").val() == "gridinsert";
	for (var i = startcnt; i <= rowcnt; i++) {
		var infix = ($k[0]) ? String(i) : "";
		$fobj.data("rowindex", infix);
			elm = this.GetElements("x" + infix + "_DayOfWeek");
			uelm = this.GetElements("u" + infix + "_DayOfWeek");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(OpeningTimes.DayOfWeek.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_IdBusinessDetail");
			uelm = this.GetElements("u" + infix + "_IdBusinessDetail");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(OpeningTimes.IdBusinessDetail.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_delivery");
			uelm = this.GetElements("u" + infix + "_delivery");
			if (uelm && uelm.checked) {
				if (elm && !ew_IsHidden(elm) && !ew_HasValue(elm))
					return this.OnError(elm, "<%= ew_JsEncode2(Replace(OpeningTimes.delivery.ReqErrMsg, "%s", OpeningTimes.delivery.FldCaption)) %>");
			}
			elm = this.GetElements("x" + infix + "_MinAcceptOrderBeforeClose");
			uelm = this.GetElements("u" + infix + "_MinAcceptOrderBeforeClose");
			if (uelm && uelm.checked && elm && !ew_CheckNumber(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(OpeningTimes.MinAcceptOrderBeforeClose.FldErrMsg) %>");
			// Set up row object
			ew_ElementsToRow(fobj);
			// Fire Form_CustomValidate event
			if (!this.Form_CustomValidate(fobj))
				return false;
	}
	return true;
}
// Form_CustomValidate event
fOpeningTimesupdate.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fOpeningTimesupdate.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fOpeningTimesupdate.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<div class="ewToolbar">
<% If OpeningTimes.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If OpeningTimes.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% OpeningTimes_update.ShowPageHeader() %>
<% OpeningTimes_update.ShowMessage %>
<form name="fOpeningTimesupdate" id="fOpeningTimesupdate" class="form-horizontal ewForm ewUpdateForm" action="<%= ew_CurrentPage %>" method="post">
<% If OpeningTimes_update.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= OpeningTimes_update.Token %>">
<% End If %>
<input type="hidden" name="t" value="OpeningTimes">
<input type="hidden" name="a_update" id="a_update" value="U">
<% For i = 0 to UBound(OpeningTimes_update.RecKeys) %>
<input type="hidden" name="key_m" id="key_m" value="<%= ew_HtmlEncode(ew_GetKeyValue(OpeningTimes_update.RecKeys(i))) %>">
<% Next %>
<div id="tbl_OpeningTimesupdate">
	<div class="form-group">
		<label class="col-sm-2"><input type="checkbox" name="u" id="u" onclick="ew_SelectAll(this);"> <%= Language.Phrase("UpdateSelectAll") %></label>
	</div>
<% If OpeningTimes.DayOfWeek.Visible Then ' DayOfWeek %>
	<div id="r_DayOfWeek" class="form-group">
		<label for="x_DayOfWeek" class="col-sm-2 control-label">
<input type="checkbox" name="u_DayOfWeek" id="u_DayOfWeek" value="1"<% If OpeningTimes.DayOfWeek.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OpeningTimes.DayOfWeek.FldCaption %></label>
		<div class="col-sm-10"><div<%= OpeningTimes.DayOfWeek.CellAttributes %>>
<span id="el_OpeningTimes_DayOfWeek">
<input type="text" data-field="x_DayOfWeek" name="x_DayOfWeek" id="x_DayOfWeek" size="30" placeholder="<%= OpeningTimes.DayOfWeek.PlaceHolder %>" value="<%= OpeningTimes.DayOfWeek.EditValue %>"<%= OpeningTimes.DayOfWeek.EditAttributes %>>
</span>
<%= OpeningTimes.DayOfWeek.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OpeningTimes.Hour_From.Visible Then ' Hour_From %>
	<div id="r_Hour_From" class="form-group">
		<label for="x_Hour_From" class="col-sm-2 control-label">
<input type="checkbox" name="u_Hour_From" id="u_Hour_From" value="1"<% If OpeningTimes.Hour_From.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OpeningTimes.Hour_From.FldCaption %></label>
		<div class="col-sm-10"><div<%= OpeningTimes.Hour_From.CellAttributes %>>
<span id="el_OpeningTimes_Hour_From">
<input type="text" data-field="x_Hour_From" name="x_Hour_From" id="x_Hour_From" size="30" placeholder="<%= OpeningTimes.Hour_From.PlaceHolder %>" value="<%= OpeningTimes.Hour_From.EditValue %>"<%= OpeningTimes.Hour_From.EditAttributes %>>
</span>
<%= OpeningTimes.Hour_From.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OpeningTimes.Hour_To.Visible Then ' Hour_To %>
	<div id="r_Hour_To" class="form-group">
		<label for="x_Hour_To" class="col-sm-2 control-label">
<input type="checkbox" name="u_Hour_To" id="u_Hour_To" value="1"<% If OpeningTimes.Hour_To.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OpeningTimes.Hour_To.FldCaption %></label>
		<div class="col-sm-10"><div<%= OpeningTimes.Hour_To.CellAttributes %>>
<span id="el_OpeningTimes_Hour_To">
<input type="text" data-field="x_Hour_To" name="x_Hour_To" id="x_Hour_To" size="30" placeholder="<%= OpeningTimes.Hour_To.PlaceHolder %>" value="<%= OpeningTimes.Hour_To.EditValue %>"<%= OpeningTimes.Hour_To.EditAttributes %>>
</span>
<%= OpeningTimes.Hour_To.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OpeningTimes.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
	<div id="r_IdBusinessDetail" class="form-group">
		<label for="x_IdBusinessDetail" class="col-sm-2 control-label">
<input type="checkbox" name="u_IdBusinessDetail" id="u_IdBusinessDetail" value="1"<% If OpeningTimes.IdBusinessDetail.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OpeningTimes.IdBusinessDetail.FldCaption %></label>
		<div class="col-sm-10"><div<%= OpeningTimes.IdBusinessDetail.CellAttributes %>>
<span id="el_OpeningTimes_IdBusinessDetail">
<input type="text" data-field="x_IdBusinessDetail" name="x_IdBusinessDetail" id="x_IdBusinessDetail" size="30" placeholder="<%= OpeningTimes.IdBusinessDetail.PlaceHolder %>" value="<%= OpeningTimes.IdBusinessDetail.EditValue %>"<%= OpeningTimes.IdBusinessDetail.EditAttributes %>>
</span>
<%= OpeningTimes.IdBusinessDetail.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OpeningTimes.delivery.Visible Then ' delivery %>
	<div id="r_delivery" class="form-group">
		<label for="x_delivery" class="col-sm-2 control-label">
<input type="checkbox" name="u_delivery" id="u_delivery" value="1"<% If OpeningTimes.delivery.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OpeningTimes.delivery.FldCaption %></label>
		<div class="col-sm-10"><div<%= OpeningTimes.delivery.CellAttributes %>>
<span id="el_OpeningTimes_delivery">
<input type="text" data-field="x_delivery" name="x_delivery" id="x_delivery" size="30" maxlength="255" placeholder="<%= OpeningTimes.delivery.PlaceHolder %>" value="<%= OpeningTimes.delivery.EditValue %>"<%= OpeningTimes.delivery.EditAttributes %>>
</span>
<%= OpeningTimes.delivery.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OpeningTimes.collection.Visible Then ' collection %>
	<div id="r_collection" class="form-group">
		<label for="x_collection" class="col-sm-2 control-label">
<input type="checkbox" name="u_collection" id="u_collection" value="1"<% If OpeningTimes.collection.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OpeningTimes.collection.FldCaption %></label>
		<div class="col-sm-10"><div<%= OpeningTimes.collection.CellAttributes %>>
<span id="el_OpeningTimes_collection">
<input type="text" data-field="x_collection" name="x_collection" id="x_collection" size="30" maxlength="255" placeholder="<%= OpeningTimes.collection.PlaceHolder %>" value="<%= OpeningTimes.collection.EditValue %>"<%= OpeningTimes.collection.EditAttributes %>>
</span>
<%= OpeningTimes.collection.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OpeningTimes.MinAcceptOrderBeforeClose.Visible Then ' MinAcceptOrderBeforeClose %>
	<div id="r_MinAcceptOrderBeforeClose" class="form-group">
		<label for="x_MinAcceptOrderBeforeClose" class="col-sm-2 control-label">
<input type="checkbox" name="u_MinAcceptOrderBeforeClose" id="u_MinAcceptOrderBeforeClose" value="1"<% If OpeningTimes.MinAcceptOrderBeforeClose.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OpeningTimes.MinAcceptOrderBeforeClose.FldCaption %></label>
		<div class="col-sm-10"><div<%= OpeningTimes.MinAcceptOrderBeforeClose.CellAttributes %>>
<span id="el_OpeningTimes_MinAcceptOrderBeforeClose">
<input type="text" data-field="x_MinAcceptOrderBeforeClose" name="x_MinAcceptOrderBeforeClose" id="x_MinAcceptOrderBeforeClose" size="30" placeholder="<%= OpeningTimes.MinAcceptOrderBeforeClose.PlaceHolder %>" value="<%= OpeningTimes.MinAcceptOrderBeforeClose.EditValue %>"<%= OpeningTimes.MinAcceptOrderBeforeClose.EditAttributes %>>
</span>
<%= OpeningTimes.MinAcceptOrderBeforeClose.CustomMsg %></div></div>
	</div>
<% End If %>
	<div class="form-group">
		<div class="col-sm-offset-2 col-sm-10">
<button class="btn btn-primary ewButton" name="btnAction" id="btnAction" type="submit"><%= Language.Phrase("UpdateBtn") %></button>
		</div>
	</div>
</div>
</form>
<script type="text/javascript">
fOpeningTimesupdate.Init();
</script>
<%
OpeningTimes_update.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set OpeningTimes_update = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cOpeningTimes_update

	' Page ID
	Public Property Get PageID()
		PageID = "update"
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
		PageObjName = "OpeningTimes_update"
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

		' Initialize urls
		' Initialize form object

		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "update"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "OpeningTimes"

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

		OpeningTimes.CurrentAction = ew_IIf(Request.QueryString("a").Count > 0, Request.QueryString("a") & "", ObjForm.GetValue("a_list") & "") ' Set up current action

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

	Dim RecKeys
	Dim Disabled
	Dim Recordset
	Dim UpdateCount

	' -----------------------------------------------------------------
	' Page main processing
	'
	Sub Page_Main()
		Dim sKeyName
		Dim sKey
		Dim nKeySelected
		Dim bUpdateSelected
		UpdateCount = 0

		' Set up Breadcrumb
		SetupBreadcrumb()
		RecKeys = OpeningTimes.GetRecordKeys() ' Load record keys
		If ObjForm.GetValue("a_update")&"" <> "" Then

			' Get action
			OpeningTimes.CurrentAction = ObjForm.GetValue("a_update")
			Call LoadFormValues() ' Get form values

			' Validate form
			If Not ValidateForm() Then
				OpeningTimes.CurrentAction = "I" ' Form error, reset action
				FailureMessage = gsFormError
			End If
		Else
			Call LoadMultiUpdateValues() ' Load initial values to form
		End If
		If Not IsArray(RecKeys) Then
			Call Page_Terminate("OpeningTimeslist.asp") ' No records selected, return to list
		End If
		Select Case OpeningTimes.CurrentAction
			Case "U" ' Update
				If UpdateRows() Then ' Update Records based on key
					If SuccessMessage = "" Then SuccessMessage = Language.Phrase("UpdateSuccess") ' Set update success message
					Call Page_Terminate(OpeningTimes.ReturnUrl) ' Return to caller
				Else
					Call RestoreFormValues() ' Restore form values
				End If
		End Select

		' Render row
		OpeningTimes.RowType = EW_ROWTYPE_EDIT ' Render edit

		' Render row
		Call OpeningTimes.ResetAttrs()
		Call RenderRow()
	End Sub

	' -----------------------------------------------------------------
	' Load initial values to form if field values are identical in all selected records
	'
	Sub LoadMultiUpdateValues()
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		Dim Rs, i, OldValue, NewValue
		OpeningTimes.CurrentFilter = OpeningTimes.GetKeyFilter()

		' Load recordset
		Set Rs = LoadRecordset()
		i = 1
		Do While Not Rs.Eof
			If i = 1 Then
				OpeningTimes.DayOfWeek.DbValue = ew_Conv(Rs("DayOfWeek"), Rs("DayOfWeek").Type)
				OpeningTimes.Hour_From.DbValue = ew_Conv(Rs("Hour_From"), Rs("Hour_From").Type)
				OpeningTimes.Hour_To.DbValue = ew_Conv(Rs("Hour_To"), Rs("Hour_To").Type)
				OpeningTimes.IdBusinessDetail.DbValue = ew_Conv(Rs("IdBusinessDetail"), Rs("IdBusinessDetail").Type)
				OpeningTimes.delivery.DbValue = ew_Conv(Rs("delivery"), Rs("delivery").Type)
				OpeningTimes.collection.DbValue = ew_Conv(Rs("collection"), Rs("collection").Type)
				OpeningTimes.MinAcceptOrderBeforeClose.DbValue = ew_Conv(Rs("MinAcceptOrderBeforeClose"), Rs("MinAcceptOrderBeforeClose").Type)
			Else
				OldValue = OpeningTimes.DayOfWeek.DbValue
				NewValue = ew_Conv(Rs("DayOfWeek"), Rs("DayOfWeek").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OpeningTimes.DayOfWeek.CurrentValue = Null
				End If
				OldValue = OpeningTimes.Hour_From.DbValue
				NewValue = ew_Conv(Rs("Hour_From"), Rs("Hour_From").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OpeningTimes.Hour_From.CurrentValue = Null
				End If
				OldValue = OpeningTimes.Hour_To.DbValue
				NewValue = ew_Conv(Rs("Hour_To"), Rs("Hour_To").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OpeningTimes.Hour_To.CurrentValue = Null
				End If
				OldValue = OpeningTimes.IdBusinessDetail.DbValue
				NewValue = ew_Conv(Rs("IdBusinessDetail"), Rs("IdBusinessDetail").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OpeningTimes.IdBusinessDetail.CurrentValue = Null
				End If
				OldValue = OpeningTimes.delivery.DbValue
				NewValue = ew_Conv(Rs("delivery"), Rs("delivery").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OpeningTimes.delivery.CurrentValue = Null
				End If
				OldValue = OpeningTimes.collection.DbValue
				NewValue = ew_Conv(Rs("collection"), Rs("collection").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OpeningTimes.collection.CurrentValue = Null
				End If
				OldValue = OpeningTimes.MinAcceptOrderBeforeClose.DbValue
				NewValue = ew_Conv(Rs("MinAcceptOrderBeforeClose"), Rs("MinAcceptOrderBeforeClose").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OpeningTimes.MinAcceptOrderBeforeClose.CurrentValue = Null
				End If
			End If
			i = i + 1
			Rs.MoveNext
		Loop
		Rs.Close
		Set Rs = Nothing
	End Sub

	' -----------------------------------------------------------------
	'  Set up key value
	'
	Function SetupKeyValues(key)
		Dim sKeyFld
		Dim sWrkFilter, sFilter
		sKeyFld = key
		If Not IsNumeric(sKeyFld) Then
			SetupKeyValues = False
			Exit Function
		End If
		OpeningTimes.ID.CurrentValue = sKeyFld ' Set up key value
		SetupKeyValues = True
	End Function

	' -----------------------------------------------------------------
	' Update all selected rows
	'
	Function UpdateRows()
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		Dim sKey, sThisKey
		Dim Rs, RsOld, RsNew, sSql, i
		Conn.BeginTrans

		' Get old recordset
		OpeningTimes.CurrentFilter = OpeningTimes.GetKeyFilter()
		sSql = OpeningTimes.SQL
		Set Rs = Server.CreateObject("ADODB.Recordset")
		Rs.CursorLocation = EW_CURSORLOCATION
		Rs.Open sSql, Conn, 1, EW_RECORDSET_LOCKTYPE
		Set RsOld = ew_CloneRs(Rs)

		' Update all rows
		sKey = ""
		For i = 0 to UBound(RecKeys)
			If SetupKeyValues(RecKeys(i)) Then
				sThisKey = RecKeys(i)
				OpeningTimes.SendEmail = False ' Do not send email on update success
				UpdateCount = UpdateCount + 1 ' Update record count for records being updated
				UpdateRows = EditRow() ' Update this row
			Else
				UpdateRows = False
			End If
			If Not UpdateRows Then Exit For ' Update failed
			If sKey <> "" Then sKey = sKey & ", "
			sKey = sKey & sThisKey
		Next
		If UpdateRows Then
			Conn.CommitTrans ' Commit transaction

			' Get new recordset
			Set Rs = Conn.Execute(sSql)
			Set RsNew = ew_CloneRs(Rs)
		Else
			Conn.RollbackTrans ' Rollback transaction
		End If
		Set Rs = Nothing
		Set RsOld = Nothing
		Set RsNew = Nothing
	End Function

	' -----------------------------------------------------------------
	' Function Get upload files
	'
	Function GetUploadFiles()

		' Get upload data
	End Function

	' -----------------------------------------------------------------
	' Load form values
	'
	Function LoadFormValues()

		' Load values from form
		If Not OpeningTimes.DayOfWeek.FldIsDetailKey Then OpeningTimes.DayOfWeek.FormValue = ObjForm.GetValue("x_DayOfWeek")
		OpeningTimes.DayOfWeek.MultiUpdate = ObjForm.GetValue("u_DayOfWeek")
		If Not OpeningTimes.Hour_From.FldIsDetailKey Then OpeningTimes.Hour_From.FormValue = ObjForm.GetValue("x_Hour_From")
		OpeningTimes.Hour_From.MultiUpdate = ObjForm.GetValue("u_Hour_From")
		If Not OpeningTimes.Hour_To.FldIsDetailKey Then OpeningTimes.Hour_To.FormValue = ObjForm.GetValue("x_Hour_To")
		OpeningTimes.Hour_To.MultiUpdate = ObjForm.GetValue("u_Hour_To")
		If Not OpeningTimes.IdBusinessDetail.FldIsDetailKey Then OpeningTimes.IdBusinessDetail.FormValue = ObjForm.GetValue("x_IdBusinessDetail")
		OpeningTimes.IdBusinessDetail.MultiUpdate = ObjForm.GetValue("u_IdBusinessDetail")
		If Not OpeningTimes.delivery.FldIsDetailKey Then OpeningTimes.delivery.FormValue = ObjForm.GetValue("x_delivery")
		OpeningTimes.delivery.MultiUpdate = ObjForm.GetValue("u_delivery")
		If Not OpeningTimes.collection.FldIsDetailKey Then OpeningTimes.collection.FormValue = ObjForm.GetValue("x_collection")
		OpeningTimes.collection.MultiUpdate = ObjForm.GetValue("u_collection")
		If Not OpeningTimes.MinAcceptOrderBeforeClose.FldIsDetailKey Then OpeningTimes.MinAcceptOrderBeforeClose.FormValue = ObjForm.GetValue("x_MinAcceptOrderBeforeClose")
		OpeningTimes.MinAcceptOrderBeforeClose.MultiUpdate = ObjForm.GetValue("u_MinAcceptOrderBeforeClose")
		If Not OpeningTimes.ID.FldIsDetailKey Then OpeningTimes.ID.FormValue = ObjForm.GetValue("x_ID")
	End Function

	' -----------------------------------------------------------------
	' Restore form values
	'
	Function RestoreFormValues()
		OpeningTimes.DayOfWeek.CurrentValue = OpeningTimes.DayOfWeek.FormValue
		OpeningTimes.Hour_From.CurrentValue = OpeningTimes.Hour_From.FormValue
		OpeningTimes.Hour_To.CurrentValue = OpeningTimes.Hour_To.FormValue
		OpeningTimes.IdBusinessDetail.CurrentValue = OpeningTimes.IdBusinessDetail.FormValue
		OpeningTimes.delivery.CurrentValue = OpeningTimes.delivery.FormValue
		OpeningTimes.collection.CurrentValue = OpeningTimes.collection.FormValue
		OpeningTimes.MinAcceptOrderBeforeClose.CurrentValue = OpeningTimes.MinAcceptOrderBeforeClose.FormValue
		OpeningTimes.ID.CurrentValue = OpeningTimes.ID.FormValue
	End Function

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

		' ----------
		'  Edit Row
		' ----------

		ElseIf OpeningTimes.RowType = EW_ROWTYPE_EDIT Then ' Edit row

			' DayOfWeek
			OpeningTimes.DayOfWeek.EditAttrs.UpdateAttribute "class", "form-control"
			OpeningTimes.DayOfWeek.EditCustomAttributes = ""
			OpeningTimes.DayOfWeek.EditValue = ew_HtmlEncode(OpeningTimes.DayOfWeek.CurrentValue)
			OpeningTimes.DayOfWeek.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OpeningTimes.DayOfWeek.FldCaption))

			' Hour_From
			OpeningTimes.Hour_From.EditAttrs.UpdateAttribute "class", "form-control"
			OpeningTimes.Hour_From.EditCustomAttributes = ""
			OpeningTimes.Hour_From.EditValue = ew_FormatDateTime(OpeningTimes.Hour_From.CurrentValue, 99)
			OpeningTimes.Hour_From.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OpeningTimes.Hour_From.FldCaption))

			' Hour_To
			OpeningTimes.Hour_To.EditAttrs.UpdateAttribute "class", "form-control"
			OpeningTimes.Hour_To.EditCustomAttributes = ""
			OpeningTimes.Hour_To.EditValue = ew_FormatDateTime(OpeningTimes.Hour_To.CurrentValue, 99)
			OpeningTimes.Hour_To.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OpeningTimes.Hour_To.FldCaption))

			' IdBusinessDetail
			OpeningTimes.IdBusinessDetail.EditAttrs.UpdateAttribute "class", "form-control"
			OpeningTimes.IdBusinessDetail.EditCustomAttributes = ""
			OpeningTimes.IdBusinessDetail.EditValue = ew_HtmlEncode(OpeningTimes.IdBusinessDetail.CurrentValue)
			OpeningTimes.IdBusinessDetail.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OpeningTimes.IdBusinessDetail.FldCaption))

			' delivery
			OpeningTimes.delivery.EditAttrs.UpdateAttribute "class", "form-control"
			OpeningTimes.delivery.EditCustomAttributes = ""
			OpeningTimes.delivery.EditValue = ew_HtmlEncode(OpeningTimes.delivery.CurrentValue)
			OpeningTimes.delivery.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OpeningTimes.delivery.FldCaption))

			' collection
			OpeningTimes.collection.EditAttrs.UpdateAttribute "class", "form-control"
			OpeningTimes.collection.EditCustomAttributes = ""
			OpeningTimes.collection.EditValue = ew_HtmlEncode(OpeningTimes.collection.CurrentValue)
			OpeningTimes.collection.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OpeningTimes.collection.FldCaption))

			' MinAcceptOrderBeforeClose
			OpeningTimes.MinAcceptOrderBeforeClose.EditAttrs.UpdateAttribute "class", "form-control"
			OpeningTimes.MinAcceptOrderBeforeClose.EditCustomAttributes = ""
			OpeningTimes.MinAcceptOrderBeforeClose.EditValue = ew_HtmlEncode(OpeningTimes.MinAcceptOrderBeforeClose.CurrentValue)
			OpeningTimes.MinAcceptOrderBeforeClose.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OpeningTimes.MinAcceptOrderBeforeClose.FldCaption))
			If OpeningTimes.MinAcceptOrderBeforeClose.EditValue&"" <> "" And IsNumeric(OpeningTimes.MinAcceptOrderBeforeClose.EditValue) Then OpeningTimes.MinAcceptOrderBeforeClose.EditValue = ew_FormatNumber2(OpeningTimes.MinAcceptOrderBeforeClose.EditValue, -2)

			' Edit refer script
			' DayOfWeek

			OpeningTimes.DayOfWeek.HrefValue = ""

			' Hour_From
			OpeningTimes.Hour_From.HrefValue = ""

			' Hour_To
			OpeningTimes.Hour_To.HrefValue = ""

			' IdBusinessDetail
			OpeningTimes.IdBusinessDetail.HrefValue = ""

			' delivery
			OpeningTimes.delivery.HrefValue = ""

			' collection
			OpeningTimes.collection.HrefValue = ""

			' MinAcceptOrderBeforeClose
			OpeningTimes.MinAcceptOrderBeforeClose.HrefValue = ""
		End If
		If OpeningTimes.RowType = EW_ROWTYPE_ADD Or OpeningTimes.RowType = EW_ROWTYPE_EDIT Or OpeningTimes.RowType = EW_ROWTYPE_SEARCH Then ' Add / Edit / Search row
			Call OpeningTimes.SetupFieldTitles()
		End If

		' Call Row Rendered event
		If OpeningTimes.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call OpeningTimes.Row_Rendered()
		End If
	End Sub

	' -----------------------------------------------------------------
	' Validate form
	'
	Function ValidateForm()

		' Initialize
		gsFormError = ""
		Dim lUpdateCnt
		lUpdateCnt = 0
		If OpeningTimes.DayOfWeek.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OpeningTimes.Hour_From.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OpeningTimes.Hour_To.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OpeningTimes.IdBusinessDetail.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OpeningTimes.delivery.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OpeningTimes.collection.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OpeningTimes.MinAcceptOrderBeforeClose.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If lUpdateCnt = 0 Then
			gsFormError = Language.Phrase("NoFieldSelected")
			ValidateForm = False
			Exit Function
		End If

		' Check if validation required
		If Not EW_SERVER_VALIDATE Then
			ValidateForm = (gsFormError = "")
			Exit Function
		End If
		If OpeningTimes.DayOfWeek.MultiUpdate <> "" Then
			If Not ew_CheckInteger(OpeningTimes.DayOfWeek.FormValue) Then
				Call ew_AddMessage(gsFormError, OpeningTimes.DayOfWeek.FldErrMsg)
			End If
		End If
		If OpeningTimes.IdBusinessDetail.MultiUpdate <> "" Then
			If Not ew_CheckInteger(OpeningTimes.IdBusinessDetail.FormValue) Then
				Call ew_AddMessage(gsFormError, OpeningTimes.IdBusinessDetail.FldErrMsg)
			End If
		End If
		If OpeningTimes.delivery.MultiUpdate <> "" And Not OpeningTimes.delivery.FldIsDetailKey And Not IsNull(OpeningTimes.delivery.FormValue) And OpeningTimes.delivery.FormValue&"" = "" Then
			Call ew_AddMessage(gsFormError, Replace(OpeningTimes.delivery.ReqErrMsg, "%s", OpeningTimes.delivery.FldCaption))
		End If
		If OpeningTimes.MinAcceptOrderBeforeClose.MultiUpdate <> "" Then
			If Not ew_CheckNumber(OpeningTimes.MinAcceptOrderBeforeClose.FormValue) Then
				Call ew_AddMessage(gsFormError, OpeningTimes.MinAcceptOrderBeforeClose.FldErrMsg)
			End If
		End If

		' Return validate result
		ValidateForm = (gsFormError = "")

		' Call Form Custom Validate event
		Dim sFormCustomError
		sFormCustomError = ""
		ValidateForm = ValidateForm And Form_CustomValidate(sFormCustomError)
		If sFormCustomError <> "" Then
			Call ew_AddMessage(gsFormError, sFormCustomError)
		End If
	End Function

	' -----------------------------------------------------------------
	' Update record based on key values
	'
	Function EditRow()
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		Dim Rs, sSql, sFilter
		Dim RsChk, sSqlChk, sFilterChk
		Dim bUpdateRow
		Dim RsOld, RsNew
		Dim sIdxErrMsg

		' Clear any previous errors
		Err.Clear
		sFilter = OpeningTimes.KeyFilter
		OpeningTimes.CurrentFilter  = sFilter
		sSql = OpeningTimes.SQL
		Set Rs = Server.CreateObject("ADODB.Recordset")
		Rs.CursorLocation = EW_CURSORLOCATION
		Rs.Open sSql, Conn, 1, EW_RECORDSET_LOCKTYPE
		If Err.Number <> 0 Then
			Message = Err.Description
			Rs.Close
			Set Rs = Nothing
			EditRow = False
			Exit Function
		End If

		' Clone old recordset object
		Set RsOld = ew_CloneRs(Rs)
		Call LoadDbValues(RsOld)
		If Rs.Eof Then
			EditRow = False ' Update Failed
		Else

			' Field DayOfWeek
			Call OpeningTimes.DayOfWeek.SetDbValue(Rs, OpeningTimes.DayOfWeek.CurrentValue, Null, OpeningTimes.DayOfWeek.ReadOnly Or OpeningTimes.DayOfWeek.MultiUpdate&"" <> "1")

			' Field Hour_From
			Call OpeningTimes.Hour_From.SetDbValue(Rs, OpeningTimes.Hour_From.CurrentValue, Null, OpeningTimes.Hour_From.ReadOnly Or OpeningTimes.Hour_From.MultiUpdate&"" <> "1")

			' Field Hour_To
			Call OpeningTimes.Hour_To.SetDbValue(Rs, OpeningTimes.Hour_To.CurrentValue, Null, OpeningTimes.Hour_To.ReadOnly Or OpeningTimes.Hour_To.MultiUpdate&"" <> "1")

			' Field IdBusinessDetail
			Call OpeningTimes.IdBusinessDetail.SetDbValue(Rs, OpeningTimes.IdBusinessDetail.CurrentValue, Null, OpeningTimes.IdBusinessDetail.ReadOnly Or OpeningTimes.IdBusinessDetail.MultiUpdate&"" <> "1")

			' Field delivery
			Call OpeningTimes.delivery.SetDbValue(Rs, OpeningTimes.delivery.CurrentValue, "", OpeningTimes.delivery.ReadOnly Or OpeningTimes.delivery.MultiUpdate&"" <> "1")

			' Field collection
			Call OpeningTimes.collection.SetDbValue(Rs, OpeningTimes.collection.CurrentValue, Null, OpeningTimes.collection.ReadOnly Or OpeningTimes.collection.MultiUpdate&"" <> "1")

			' Field MinAcceptOrderBeforeClose
			Call OpeningTimes.MinAcceptOrderBeforeClose.SetDbValue(Rs, OpeningTimes.MinAcceptOrderBeforeClose.CurrentValue, Null, OpeningTimes.MinAcceptOrderBeforeClose.ReadOnly Or OpeningTimes.MinAcceptOrderBeforeClose.MultiUpdate&"" <> "1")

			' Check recordset update error
			If Err.Number <> 0 Then
				FailureMessage = Err.Description
				Rs.Close
				Set Rs = Nothing
				EditRow = False
				Exit Function
			End If

			' Call Row Updating event
			bUpdateRow = OpeningTimes.Row_Updating(RsOld, Rs)
			If bUpdateRow Then

				' Clone new recordset object
				Set RsNew = ew_CloneRs(Rs)
				EditRow = True
				If EditRow Then
					Rs.Update
				End If
				If Err.Number <> 0 Or Not EditRow Then
					If Err.Description <> "" Then FailureMessage = Err.Description
					EditRow = False
				Else
					EditRow = True
				End If
				If EditRow Then
				End If
			Else
				Rs.CancelUpdate

				' Set up error message
				If SuccessMessage <> "" Or FailureMessage <> "" Then

					' Use the message, do nothing
				ElseIf OpeningTimes.CancelMessage <> "" Then
					FailureMessage = OpeningTimes.CancelMessage
					OpeningTimes.CancelMessage = ""
				Else
					FailureMessage = Language.Phrase("UpdateCancelled")
				End If
				EditRow = False
			End If
		End If

		' Call Row Updated event
		If EditRow Then
			Call OpeningTimes.Row_Updated(RsOld, RsNew)
		End If
		Rs.Close
		Set Rs = Nothing
		If IsObject(RsOld) Then
			RsOld.Close
			Set RsOld = Nothing
		End If
		If IsObject(RsNew) Then
			RsNew.Close
			Set RsNew = Nothing
		End If
	End Function

	' Set up Breadcrumb
	Sub SetupBreadcrumb()
		Dim PageId, url
		Set Breadcrumb = New cBreadcrumb
		url = Mid(ew_CurrentUrl, InStrRev(ew_CurrentUrl, "/")+1)
		Call Breadcrumb.Add("list", OpeningTimes.TableVar, "OpeningTimeslist.asp", "", OpeningTimes.TableVar, True)
		PageId = "update"
		Call Breadcrumb.Add("update", PageId, url, "", "", False)
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
