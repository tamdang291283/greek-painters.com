﻿<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="MenuToppingsinfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim MenuToppings_add
Set MenuToppings_add = New cMenuToppings_add
Set Page = MenuToppings_add

' Page init processing
MenuToppings_add.Page_Init()

' Page main processing
MenuToppings_add.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
MenuToppings_add.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var MenuToppings_add = new ew_Page("MenuToppings_add");
MenuToppings_add.PageID = "add"; // Page ID
var EW_PAGE_ID = MenuToppings_add.PageID; // For backward compatibility
// Form object
var fMenuToppingsadd = new ew_Form("fMenuToppingsadd");
// Validate form
fMenuToppingsadd.Validate = function() {
	if (!this.ValidateRequired)
		return true; // Ignore validation
	var $ = jQuery, fobj = this.GetForm(), $fobj = $(fobj);
	this.PostAutoSuggest();
	if ($fobj.find("#a_confirm").val() == "F")
		return true;
	var elm, felm, uelm, addcnt = 0;
	var $k = $fobj.find("#" + this.FormKeyCountName); // Get key_count
	var rowcnt = ($k[0]) ? parseInt($k.val(), 10) : 1;
	var startcnt = (rowcnt == 0) ? 0 : 1; // Check rowcnt == 0 => Inline-Add
	var gridinsert = $fobj.find("#a_list").val() == "gridinsert";
	for (var i = startcnt; i <= rowcnt; i++) {
		var infix = ($k[0]) ? String(i) : "";
		$fobj.data("rowindex", infix);
			elm = this.GetElements("x" + infix + "_toppingprice");
			if (elm && !ew_CheckNumber(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(MenuToppings.toppingprice.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_IdBusinessDetail");
			if (elm && !ew_CheckInteger(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(MenuToppings.IdBusinessDetail.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_toppinggroupid");
			if (elm && !ew_CheckInteger(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(MenuToppings.toppinggroupid.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_i_displaySort");
			if (elm && !ew_CheckInteger(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(MenuToppings.i_displaySort.FldErrMsg) %>");
			// Set up row object
			ew_ElementsToRow(fobj);
			// Fire Form_CustomValidate event
			if (!this.Form_CustomValidate(fobj))
				return false;
	}
	// Process detail forms
	var dfs = $fobj.find("input[name='detailpage']").get();
	for (var i = 0; i < dfs.length; i++) {
		var df = dfs[i], val = df.value;
		if (val && ewForms[val])
			if (!ewForms[val].Validate())
				return false;
	}
	return true;
}
// Form_CustomValidate event
fMenuToppingsadd.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fMenuToppingsadd.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fMenuToppingsadd.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<div class="ewToolbar">
<% If MenuToppings.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If MenuToppings.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% MenuToppings_add.ShowPageHeader() %>
<% MenuToppings_add.ShowMessage %>
<form name="fMenuToppingsadd" id="fMenuToppingsadd" class="form-horizontal ewForm ewAddForm" action="<%= ew_CurrentPage() %>" method="post">
<% If MenuToppings_add.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= MenuToppings_add.Token %>">
<% End If %>
<input type="hidden" name="t" value="MenuToppings">
<input type="hidden" name="a_add" id="a_add" value="A">
<div>
<% If MenuToppings.topping.Visible Then ' topping %>
	<div id="r_topping" class="form-group">
		<label id="elh_MenuToppings_topping" for="x_topping" class="col-sm-2 control-label ewLabel"><%= MenuToppings.topping.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuToppings.topping.CellAttributes %>>
<span id="el_MenuToppings_topping">
<input type="text" data-field="x_topping" name="x_topping" id="x_topping" size="30" maxlength="255" placeholder="<%= MenuToppings.topping.PlaceHolder %>" value="<%= MenuToppings.topping.EditValue %>"<%= MenuToppings.topping.EditAttributes %>>
</span>
<%= MenuToppings.topping.CustomMsg %></div></div>
	</div>
<% End If %>
<% If MenuToppings.toppingprice.Visible Then ' toppingprice %>
	<div id="r_toppingprice" class="form-group">
		<label id="elh_MenuToppings_toppingprice" for="x_toppingprice" class="col-sm-2 control-label ewLabel"><%= MenuToppings.toppingprice.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuToppings.toppingprice.CellAttributes %>>
<span id="el_MenuToppings_toppingprice">
<input type="text" data-field="x_toppingprice" name="x_toppingprice" id="x_toppingprice" size="30" placeholder="<%= MenuToppings.toppingprice.PlaceHolder %>" value="<%= MenuToppings.toppingprice.EditValue %>"<%= MenuToppings.toppingprice.EditAttributes %>>
</span>
<%= MenuToppings.toppingprice.CustomMsg %></div></div>
	</div>
<% End If %>
<% If MenuToppings.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
	<div id="r_IdBusinessDetail" class="form-group">
		<label id="elh_MenuToppings_IdBusinessDetail" for="x_IdBusinessDetail" class="col-sm-2 control-label ewLabel"><%= MenuToppings.IdBusinessDetail.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuToppings.IdBusinessDetail.CellAttributes %>>
<span id="el_MenuToppings_IdBusinessDetail">
<input type="text" data-field="x_IdBusinessDetail" name="x_IdBusinessDetail" id="x_IdBusinessDetail" size="30" placeholder="<%= MenuToppings.IdBusinessDetail.PlaceHolder %>" value="<%= MenuToppings.IdBusinessDetail.EditValue %>"<%= MenuToppings.IdBusinessDetail.EditAttributes %>>
</span>
<%= MenuToppings.IdBusinessDetail.CustomMsg %></div></div>
	</div>
<% End If %>
<% If MenuToppings.toppinggroupid.Visible Then ' toppinggroupid %>
	<div id="r_toppinggroupid" class="form-group">
		<label id="elh_MenuToppings_toppinggroupid" for="x_toppinggroupid" class="col-sm-2 control-label ewLabel"><%= MenuToppings.toppinggroupid.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuToppings.toppinggroupid.CellAttributes %>>
<span id="el_MenuToppings_toppinggroupid">
<input type="text" data-field="x_toppinggroupid" name="x_toppinggroupid" id="x_toppinggroupid" size="30" placeholder="<%= MenuToppings.toppinggroupid.PlaceHolder %>" value="<%= MenuToppings.toppinggroupid.EditValue %>"<%= MenuToppings.toppinggroupid.EditAttributes %>>
</span>
<%= MenuToppings.toppinggroupid.CustomMsg %></div></div>
	</div>
<% End If %>
<% If MenuToppings.printingname.Visible Then ' printingname %>
	<div id="r_printingname" class="form-group">
		<label id="elh_MenuToppings_printingname" for="x_printingname" class="col-sm-2 control-label ewLabel"><%= MenuToppings.printingname.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuToppings.printingname.CellAttributes %>>
<span id="el_MenuToppings_printingname">
<input type="text" data-field="x_printingname" name="x_printingname" id="x_printingname" size="30" maxlength="255" placeholder="<%= MenuToppings.printingname.PlaceHolder %>" value="<%= MenuToppings.printingname.EditValue %>"<%= MenuToppings.printingname.EditAttributes %>>
</span>
<%= MenuToppings.printingname.CustomMsg %></div></div>
	</div>
<% End If %>
<% If MenuToppings.i_displaySort.Visible Then ' i_displaySort %>
	<div id="r_i_displaySort" class="form-group">
		<label id="elh_MenuToppings_i_displaySort" for="x_i_displaySort" class="col-sm-2 control-label ewLabel"><%= MenuToppings.i_displaySort.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuToppings.i_displaySort.CellAttributes %>>
<span id="el_MenuToppings_i_displaySort">
<input type="text" data-field="x_i_displaySort" name="x_i_displaySort" id="x_i_displaySort" size="30" placeholder="<%= MenuToppings.i_displaySort.PlaceHolder %>" value="<%= MenuToppings.i_displaySort.EditValue %>"<%= MenuToppings.i_displaySort.EditAttributes %>>
</span>
<%= MenuToppings.i_displaySort.CustomMsg %></div></div>
	</div>
<% End If %>
</div>
<div class="form-group">
	<div class="col-sm-offset-2 col-sm-10">
<button class="btn btn-primary ewButton" name="btnAction" id="btnAction" type="submit"><%= Language.Phrase("AddBtn") %></button>
	</div>
</div>
</form>
<script type="text/javascript">
fMenuToppingsadd.Init();
</script>
<%
MenuToppings_add.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set MenuToppings_add = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cMenuToppings_add

	' Page ID
	Public Property Get PageID()
		PageID = "add"
	End Property

	' Project ID
	Public Property Get ProjectID()
		ProjectID = "{E9837C6B-C139-4DEF-A37B-491BE9913D3B}"
	End Property

	' Table Name
	Public Property Get TableName()
		TableName = "MenuToppings"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "MenuToppings_add"
	End Property

	' Page Name
	Public Property Get PageName()
		PageName = ew_CurrentPage()
	End Property

	' Page Url
	Public Property Get PageUrl()
		PageUrl = ew_CurrentPage() & "?"
		If MenuToppings.UseTokenInUrl Then PageUrl = PageUrl & "t=" & MenuToppings.TableVar & "&" ' add page token
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
		If MenuToppings.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (MenuToppings.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (MenuToppings.TableVar = Request.QueryString("t"))
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
		If IsEmpty(MenuToppings) Then Set MenuToppings = New cMenuToppings
		Set Table = MenuToppings

		' Initialize urls
		' Initialize form object

		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "add"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "MenuToppings"

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

		MenuToppings.CurrentAction = ew_IIf(Request.QueryString("a").Count > 0, Request.QueryString("a") & "", ObjForm.GetValue("a_list") & "") ' Set up current action

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
			results = MenuToppings.GetAutoFill(Request.Form("name"), Request.Form("q"))
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
		If Not MenuToppings Is Nothing Then
			If MenuToppings.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = MenuToppings.TableVar
				If MenuToppings.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf MenuToppings.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf MenuToppings.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf MenuToppings.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set MenuToppings = Nothing
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
	Dim StartRec
	Dim Priv
	Dim OldRecordset
	Dim CopyRecord

	' -----------------------------------------------------------------
	' Page main processing
	'
	Sub Page_Main()

		' Process form if post back
		If ObjForm.GetValue("a_add")&"" <> "" Then
			MenuToppings.CurrentAction = ObjForm.GetValue("a_add") ' Get form action
			CopyRecord = LoadOldRecord() ' Load old recordset
			Call LoadFormValues() ' Load form values

		' Not post back
		Else

			' Load key values from QueryString
			CopyRecord = True
			If Request.QueryString("ID").Count > 0 Then
				MenuToppings.ID.QueryStringValue = Request.QueryString("ID")
				Call MenuToppings.SetKey("ID", MenuToppings.ID.CurrentValue) ' Set up key
			Else
				Call MenuToppings.SetKey("ID", "") ' Clear key
				CopyRecord = False
			End If
			If CopyRecord Then
				MenuToppings.CurrentAction = "C" ' Copy Record
			Else
				MenuToppings.CurrentAction = "I" ' Display Blank Record
				Call LoadDefaultValues() ' Load default values
			End If
		End If

		' Set up Breadcrumb
		SetupBreadcrumb()

		' Validate form if post back
		If ObjForm.GetValue("a_add")&"" <> "" Then
			If Not ValidateForm() Then
				MenuToppings.CurrentAction = "I" ' Form error, reset action
				MenuToppings.EventCancelled = True ' Event cancelled
				Call RestoreFormValues() ' Restore form values
				FailureMessage = gsFormError
			End If
		End If

		' Perform action based on action code
		Select Case MenuToppings.CurrentAction
			Case "I" ' Blank record, no action required
			Case "C" ' Copy an existing record
				If Not LoadRow() Then ' Load record based on key
					If FailureMessage = "" Then FailureMessage = Language.Phrase("NoRecord") ' No record found
					Call Page_Terminate("MenuToppingslist.asp") ' No matching record, return to list
				End If
			Case "A" ' Add new record
				MenuToppings.SendEmail = True ' Send email on add success
				If AddRow(OldRecordset) Then ' Add successful
					If SuccessMessage = "" Then SuccessMessage = Language.Phrase("AddSuccess") ' Set up success message
					Dim sReturnUrl
					sReturnUrl = MenuToppings.ReturnUrl
					If ew_GetPageName(sReturnUrl) = "MenuToppingsview.asp" Then sReturnUrl = MenuToppings.ViewUrl("") ' View paging, return to view page with keyurl directly
					Call Page_Terminate(sReturnUrl) ' Clean up and return
				Else
					MenuToppings.EventCancelled = True ' Event cancelled
					Call RestoreFormValues() ' Add failed, restore form values
				End If
		End Select

		' Render row based on row type
		MenuToppings.RowType = EW_ROWTYPE_ADD ' Render add type

		' Render row
		Call MenuToppings.ResetAttrs()
		Call RenderRow()
	End Sub

	' -----------------------------------------------------------------
	' Function Get upload files
	'
	Function GetUploadFiles()

		' Get upload data
	End Function

	' -----------------------------------------------------------------
	' Load default values
	'
	Function LoadDefaultValues()
		MenuToppings.topping.CurrentValue = Null
		MenuToppings.topping.OldValue = MenuToppings.topping.CurrentValue
		MenuToppings.toppingprice.CurrentValue = Null
		MenuToppings.toppingprice.OldValue = MenuToppings.toppingprice.CurrentValue
		MenuToppings.IdBusinessDetail.CurrentValue = Null
		MenuToppings.IdBusinessDetail.OldValue = MenuToppings.IdBusinessDetail.CurrentValue
		MenuToppings.toppinggroupid.CurrentValue = Null
		MenuToppings.toppinggroupid.OldValue = MenuToppings.toppinggroupid.CurrentValue
		MenuToppings.printingname.CurrentValue = Null
		MenuToppings.printingname.OldValue = MenuToppings.printingname.CurrentValue
		MenuToppings.i_displaySort.CurrentValue = Null
		MenuToppings.i_displaySort.OldValue = MenuToppings.i_displaySort.CurrentValue
	End Function

	' -----------------------------------------------------------------
	' Load form values
	'
	Function LoadFormValues()

		' Load values from form
		If Not MenuToppings.topping.FldIsDetailKey Then MenuToppings.topping.FormValue = ObjForm.GetValue("x_topping")
		If Not MenuToppings.toppingprice.FldIsDetailKey Then MenuToppings.toppingprice.FormValue = ObjForm.GetValue("x_toppingprice")
		If Not MenuToppings.IdBusinessDetail.FldIsDetailKey Then MenuToppings.IdBusinessDetail.FormValue = ObjForm.GetValue("x_IdBusinessDetail")
		If Not MenuToppings.toppinggroupid.FldIsDetailKey Then MenuToppings.toppinggroupid.FormValue = ObjForm.GetValue("x_toppinggroupid")
		If Not MenuToppings.printingname.FldIsDetailKey Then MenuToppings.printingname.FormValue = ObjForm.GetValue("x_printingname")
		If Not MenuToppings.i_displaySort.FldIsDetailKey Then MenuToppings.i_displaySort.FormValue = ObjForm.GetValue("x_i_displaySort")
	End Function

	' -----------------------------------------------------------------
	' Restore form values
	'
	Function RestoreFormValues()
		Call LoadOldRecord()
		MenuToppings.topping.CurrentValue = MenuToppings.topping.FormValue
		MenuToppings.toppingprice.CurrentValue = MenuToppings.toppingprice.FormValue
		MenuToppings.IdBusinessDetail.CurrentValue = MenuToppings.IdBusinessDetail.FormValue
		MenuToppings.toppinggroupid.CurrentValue = MenuToppings.toppinggroupid.FormValue
		MenuToppings.printingname.CurrentValue = MenuToppings.printingname.FormValue
		MenuToppings.i_displaySort.CurrentValue = MenuToppings.i_displaySort.FormValue
	End Function

	' -----------------------------------------------------------------
	' Load row based on key values
	'
	Function LoadRow()
		Dim RsRow, sSql, sFilter
		sFilter = MenuToppings.KeyFilter

		' Call Row Selecting event
		Call MenuToppings.Row_Selecting(sFilter)

		' Load sql based on filter
		MenuToppings.CurrentFilter = sFilter
		sSql = MenuToppings.SQL
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
		Call MenuToppings.Row_Selected(RsRow)
		MenuToppings.ID.DbValue = RsRow("ID")
		MenuToppings.topping.DbValue = RsRow("topping")
		MenuToppings.toppingprice.DbValue = RsRow("toppingprice")
		MenuToppings.IdBusinessDetail.DbValue = RsRow("IdBusinessDetail")
		MenuToppings.toppinggroupid.DbValue = RsRow("toppinggroupid")
		MenuToppings.printingname.DbValue = RsRow("printingname")
		MenuToppings.i_displaySort.DbValue = RsRow("i_displaySort")
	End Sub

	' Load DbValue from recordset
	Sub LoadDbValues(Rs)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		If Rs.Eof Then Exit Sub
		MenuToppings.ID.m_DbValue = Rs("ID")
		MenuToppings.topping.m_DbValue = Rs("topping")
		MenuToppings.toppingprice.m_DbValue = Rs("toppingprice")
		MenuToppings.IdBusinessDetail.m_DbValue = Rs("IdBusinessDetail")
		MenuToppings.toppinggroupid.m_DbValue = Rs("toppinggroupid")
		MenuToppings.printingname.m_DbValue = Rs("printingname")
		MenuToppings.i_displaySort.m_DbValue = Rs("i_displaySort")
	End Sub

	' Load old record
	Function LoadOldRecord()

		' Load key values from Session
		Dim bValidKey
		bValidKey = True
		If MenuToppings.GetKey("ID")&"" <> "" Then
			MenuToppings.ID.CurrentValue = MenuToppings.GetKey("ID") ' ID
		Else
			bValidKey = False
		End If

		' Load old recordset
		If bValidKey Then
			MenuToppings.CurrentFilter = MenuToppings.KeyFilter
			Dim sSql
			sSql = MenuToppings.SQL
			Set OldRecordset = ew_LoadRecordset(sSql)
			Call LoadRowValues(OldRecordset) ' Load row values
		Else
			OldRecordset = Null
		End If
		LoadOldRecord = bValidKey
	End Function

	' -----------------------------------------------------------------
	' Render row values based on field settings
	'
	Sub RenderRow()

		' Initialize urls
		' Convert decimal values if posted back

		If MenuToppings.toppingprice.FormValue = MenuToppings.toppingprice.CurrentValue And IsNumeric(MenuToppings.toppingprice.CurrentValue) Then
			MenuToppings.toppingprice.CurrentValue = ew_StrToFloat(MenuToppings.toppingprice.CurrentValue)
		End If

		' Call Row Rendering event
		Call MenuToppings.Row_Rendering()

		' ---------------------------------------
		'  Common render codes for all row types
		' ---------------------------------------
		' ID
		' topping
		' toppingprice
		' IdBusinessDetail
		' toppinggroupid
		' printingname
		' i_displaySort
		' -----------
		'  View  Row
		' -----------

		If MenuToppings.RowType = EW_ROWTYPE_VIEW Then ' View row

			' ID
			MenuToppings.ID.ViewValue = MenuToppings.ID.CurrentValue
			MenuToppings.ID.ViewCustomAttributes = ""

			' topping
			MenuToppings.topping.ViewValue = MenuToppings.topping.CurrentValue
			MenuToppings.topping.ViewCustomAttributes = ""

			' toppingprice
			MenuToppings.toppingprice.ViewValue = MenuToppings.toppingprice.CurrentValue
			MenuToppings.toppingprice.ViewCustomAttributes = ""

			' IdBusinessDetail
			MenuToppings.IdBusinessDetail.ViewValue = MenuToppings.IdBusinessDetail.CurrentValue
			MenuToppings.IdBusinessDetail.ViewCustomAttributes = ""

			' toppinggroupid
			MenuToppings.toppinggroupid.ViewValue = MenuToppings.toppinggroupid.CurrentValue
			MenuToppings.toppinggroupid.ViewCustomAttributes = ""

			' printingname
			MenuToppings.printingname.ViewValue = MenuToppings.printingname.CurrentValue
			MenuToppings.printingname.ViewCustomAttributes = ""

			' i_displaySort
			MenuToppings.i_displaySort.ViewValue = MenuToppings.i_displaySort.CurrentValue
			MenuToppings.i_displaySort.ViewCustomAttributes = ""

			' View refer script
			' topping

			MenuToppings.topping.LinkCustomAttributes = ""
			MenuToppings.topping.HrefValue = ""
			MenuToppings.topping.TooltipValue = ""

			' toppingprice
			MenuToppings.toppingprice.LinkCustomAttributes = ""
			MenuToppings.toppingprice.HrefValue = ""
			MenuToppings.toppingprice.TooltipValue = ""

			' IdBusinessDetail
			MenuToppings.IdBusinessDetail.LinkCustomAttributes = ""
			MenuToppings.IdBusinessDetail.HrefValue = ""
			MenuToppings.IdBusinessDetail.TooltipValue = ""

			' toppinggroupid
			MenuToppings.toppinggroupid.LinkCustomAttributes = ""
			MenuToppings.toppinggroupid.HrefValue = ""
			MenuToppings.toppinggroupid.TooltipValue = ""

			' printingname
			MenuToppings.printingname.LinkCustomAttributes = ""
			MenuToppings.printingname.HrefValue = ""
			MenuToppings.printingname.TooltipValue = ""

			' i_displaySort
			MenuToppings.i_displaySort.LinkCustomAttributes = ""
			MenuToppings.i_displaySort.HrefValue = ""
			MenuToppings.i_displaySort.TooltipValue = ""

		' ---------
		'  Add Row
		' ---------

		ElseIf MenuToppings.RowType = EW_ROWTYPE_ADD Then ' Add row

			' topping
			MenuToppings.topping.EditAttrs.UpdateAttribute "class", "form-control"
			MenuToppings.topping.EditCustomAttributes = ""
			MenuToppings.topping.EditValue = ew_HtmlEncode(MenuToppings.topping.CurrentValue)
			MenuToppings.topping.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuToppings.topping.FldCaption))

			' toppingprice
			MenuToppings.toppingprice.EditAttrs.UpdateAttribute "class", "form-control"
			MenuToppings.toppingprice.EditCustomAttributes = ""
			MenuToppings.toppingprice.EditValue = ew_HtmlEncode(MenuToppings.toppingprice.CurrentValue)
			MenuToppings.toppingprice.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuToppings.toppingprice.FldCaption))
			If MenuToppings.toppingprice.EditValue&"" <> "" And IsNumeric(MenuToppings.toppingprice.EditValue) Then MenuToppings.toppingprice.EditValue = ew_FormatNumber2(MenuToppings.toppingprice.EditValue, -2)

			' IdBusinessDetail
			MenuToppings.IdBusinessDetail.EditAttrs.UpdateAttribute "class", "form-control"
			MenuToppings.IdBusinessDetail.EditCustomAttributes = ""
			MenuToppings.IdBusinessDetail.EditValue = ew_HtmlEncode(MenuToppings.IdBusinessDetail.CurrentValue)
			MenuToppings.IdBusinessDetail.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuToppings.IdBusinessDetail.FldCaption))

			' toppinggroupid
			MenuToppings.toppinggroupid.EditAttrs.UpdateAttribute "class", "form-control"
			MenuToppings.toppinggroupid.EditCustomAttributes = ""
			MenuToppings.toppinggroupid.EditValue = ew_HtmlEncode(MenuToppings.toppinggroupid.CurrentValue)
			MenuToppings.toppinggroupid.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuToppings.toppinggroupid.FldCaption))

			' printingname
			MenuToppings.printingname.EditAttrs.UpdateAttribute "class", "form-control"
			MenuToppings.printingname.EditCustomAttributes = ""
			MenuToppings.printingname.EditValue = ew_HtmlEncode(MenuToppings.printingname.CurrentValue)
			MenuToppings.printingname.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuToppings.printingname.FldCaption))

			' i_displaySort
			MenuToppings.i_displaySort.EditAttrs.UpdateAttribute "class", "form-control"
			MenuToppings.i_displaySort.EditCustomAttributes = ""
			MenuToppings.i_displaySort.EditValue = ew_HtmlEncode(MenuToppings.i_displaySort.CurrentValue)
			MenuToppings.i_displaySort.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuToppings.i_displaySort.FldCaption))

			' Edit refer script
			' topping

			MenuToppings.topping.HrefValue = ""

			' toppingprice
			MenuToppings.toppingprice.HrefValue = ""

			' IdBusinessDetail
			MenuToppings.IdBusinessDetail.HrefValue = ""

			' toppinggroupid
			MenuToppings.toppinggroupid.HrefValue = ""

			' printingname
			MenuToppings.printingname.HrefValue = ""

			' i_displaySort
			MenuToppings.i_displaySort.HrefValue = ""
		End If
		If MenuToppings.RowType = EW_ROWTYPE_ADD Or MenuToppings.RowType = EW_ROWTYPE_EDIT Or MenuToppings.RowType = EW_ROWTYPE_SEARCH Then ' Add / Edit / Search row
			Call MenuToppings.SetupFieldTitles()
		End If

		' Call Row Rendered event
		If MenuToppings.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call MenuToppings.Row_Rendered()
		End If
	End Sub

	' -----------------------------------------------------------------
	' Validate form
	'
	Function ValidateForm()

		' Initialize
		gsFormError = ""

		' Check if validation required
		If Not EW_SERVER_VALIDATE Then
			ValidateForm = (gsFormError = "")
			Exit Function
		End If
		If Not ew_CheckNumber(MenuToppings.toppingprice.FormValue) Then
			Call ew_AddMessage(gsFormError, MenuToppings.toppingprice.FldErrMsg)
		End If
		If Not ew_CheckInteger(MenuToppings.IdBusinessDetail.FormValue) Then
			Call ew_AddMessage(gsFormError, MenuToppings.IdBusinessDetail.FldErrMsg)
		End If
		If Not ew_CheckInteger(MenuToppings.toppinggroupid.FormValue) Then
			Call ew_AddMessage(gsFormError, MenuToppings.toppinggroupid.FldErrMsg)
		End If
		If Not ew_CheckInteger(MenuToppings.i_displaySort.FormValue) Then
			Call ew_AddMessage(gsFormError, MenuToppings.i_displaySort.FldErrMsg)
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
	' Add record
	'
	Function AddRow(RsOld)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		Dim Rs, sSql, sFilter
		Dim RsNew
		Dim bInsertRow
		Dim RsChk
		Dim sIdxErrMsg

		' Clear any previous errors
		Err.Clear
		Dim RsMaster, sMasterUserIdMsg, sMasterFilter, bCheckMasterRecord

		' Load db values from rsold
		If Not IsNull(RsOld) Then
			Call LoadDbValues(RsOld)
		End If

		' Add new record
		sFilter = "(0 = 1)"
		MenuToppings.CurrentFilter = sFilter
		sSql = MenuToppings.SQL
		Set Rs = Server.CreateObject("ADODB.Recordset")
		Rs.CursorLocation = EW_CURSORLOCATION
		Rs.Open sSql, Conn, 1, EW_RECORDSET_LOCKTYPE
		Rs.AddNew
		If Err.Number <> 0 Then
			Message = Err.Description
			Rs.Close
			Set Rs = Nothing
			AddRow = False
			Exit Function
		End If

		' Field topping
		Call MenuToppings.topping.SetDbValue(Rs, MenuToppings.topping.CurrentValue, Null, False)

		' Field toppingprice
		Call MenuToppings.toppingprice.SetDbValue(Rs, MenuToppings.toppingprice.CurrentValue, Null, False)

		' Field IdBusinessDetail
		Call MenuToppings.IdBusinessDetail.SetDbValue(Rs, MenuToppings.IdBusinessDetail.CurrentValue, Null, False)

		' Field toppinggroupid
		Call MenuToppings.toppinggroupid.SetDbValue(Rs, MenuToppings.toppinggroupid.CurrentValue, Null, False)

		' Field printingname
		Call MenuToppings.printingname.SetDbValue(Rs, MenuToppings.printingname.CurrentValue, Null, False)

		' Field i_displaySort
		Call MenuToppings.i_displaySort.SetDbValue(Rs, MenuToppings.i_displaySort.CurrentValue, Null, False)

		' Check recordset update error
		If Err.Number <> 0 Then
			FailureMessage = Err.Description
			Rs.Close
			Set Rs = Nothing
			AddRow = False
			Exit Function
		End If

		' Call Row Inserting event
		bInsertRow = MenuToppings.Row_Inserting(RsOld, Rs)
		If bInsertRow Then

			' Clone new recordset object
			Set RsNew = ew_CloneRs(Rs)
			Rs.Update
			If Err.Number <> 0 Then
				FailureMessage = Err.Description
				AddRow = False
			Else
				AddRow = True
			End If
			If AddRow Then
			End If
		Else
			Rs.CancelUpdate

			' Set up error message
			If SuccessMessage <> "" Or FailureMessage <> "" Then

				' Use the message, do nothing
			ElseIf MenuToppings.CancelMessage <> "" Then
				FailureMessage = MenuToppings.CancelMessage
				MenuToppings.CancelMessage = ""
			Else
				FailureMessage = Language.Phrase("InsertCancelled")
			End If
			AddRow = False
		End If
		Rs.Close
		Set Rs = Nothing
		If AddRow Then
			MenuToppings.ID.DbValue = RsNew("ID")
		End If
		If AddRow Then

			' Call Row Inserted event
			Call MenuToppings.Row_Inserted(RsOld, RsNew)
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
		Call Breadcrumb.Add("list", MenuToppings.TableVar, "MenuToppingslist.asp", "", MenuToppings.TableVar, True)
		PageId = ew_IIf(MenuToppings.CurrentAction = "C", "Copy", "Add")
		Call Breadcrumb.Add("add", PageId, url, "", "", False)
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
