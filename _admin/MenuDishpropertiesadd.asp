<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="MenuDishpropertiesinfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim MenuDishproperties_add
Set MenuDishproperties_add = New cMenuDishproperties_add
Set Page = MenuDishproperties_add

' Page init processing
MenuDishproperties_add.Page_Init()

' Page main processing
MenuDishproperties_add.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
MenuDishproperties_add.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var MenuDishproperties_add = new ew_Page("MenuDishproperties_add");
MenuDishproperties_add.PageID = "add"; // Page ID
var EW_PAGE_ID = MenuDishproperties_add.PageID; // For backward compatibility
// Form object
var fMenuDishpropertiesadd = new ew_Form("fMenuDishpropertiesadd");
// Validate form
fMenuDishpropertiesadd.Validate = function() {
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
			elm = this.GetElements("x" + infix + "_dishpropertyprice");
			if (elm && !ew_CheckNumber(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(MenuDishproperties.dishpropertyprice.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_IdBusinessDetail");
			if (elm && !ew_CheckInteger(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(MenuDishproperties.IdBusinessDetail.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_dishpropertygroupid");
			if (elm && !ew_CheckInteger(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(MenuDishproperties.dishpropertygroupid.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_i_displaySort");
			if (elm && !ew_CheckInteger(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(MenuDishproperties.i_displaySort.FldErrMsg) %>");
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
fMenuDishpropertiesadd.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fMenuDishpropertiesadd.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fMenuDishpropertiesadd.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<div class="ewToolbar">
<% If MenuDishproperties.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If MenuDishproperties.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% MenuDishproperties_add.ShowPageHeader() %>
<% MenuDishproperties_add.ShowMessage %>
<form name="fMenuDishpropertiesadd" id="fMenuDishpropertiesadd" class="form-horizontal ewForm ewAddForm" action="<%= ew_CurrentPage() %>" method="post">
<% If MenuDishproperties_add.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= MenuDishproperties_add.Token %>">
<% End If %>
<input type="hidden" name="t" value="MenuDishproperties">
<input type="hidden" name="a_add" id="a_add" value="A">
<div>
<% If MenuDishproperties.dishproperty.Visible Then ' dishproperty %>
	<div id="r_dishproperty" class="form-group">
		<label id="elh_MenuDishproperties_dishproperty" for="x_dishproperty" class="col-sm-2 control-label ewLabel"><%= MenuDishproperties.dishproperty.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuDishproperties.dishproperty.CellAttributes %>>
<span id="el_MenuDishproperties_dishproperty">
<input type="text" data-field="x_dishproperty" name="x_dishproperty" id="x_dishproperty" size="30" maxlength="255" placeholder="<%= MenuDishproperties.dishproperty.PlaceHolder %>" value="<%= MenuDishproperties.dishproperty.EditValue %>"<%= MenuDishproperties.dishproperty.EditAttributes %>>
</span>
<%= MenuDishproperties.dishproperty.CustomMsg %></div></div>
	</div>
<% End If %>
<% If MenuDishproperties.dishpropertyprice.Visible Then ' dishpropertyprice %>
	<div id="r_dishpropertyprice" class="form-group">
		<label id="elh_MenuDishproperties_dishpropertyprice" for="x_dishpropertyprice" class="col-sm-2 control-label ewLabel"><%= MenuDishproperties.dishpropertyprice.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuDishproperties.dishpropertyprice.CellAttributes %>>
<span id="el_MenuDishproperties_dishpropertyprice">
<input type="text" data-field="x_dishpropertyprice" name="x_dishpropertyprice" id="x_dishpropertyprice" size="30" placeholder="<%= MenuDishproperties.dishpropertyprice.PlaceHolder %>" value="<%= MenuDishproperties.dishpropertyprice.EditValue %>"<%= MenuDishproperties.dishpropertyprice.EditAttributes %>>
</span>
<%= MenuDishproperties.dishpropertyprice.CustomMsg %></div></div>
	</div>
<% End If %>
<% If MenuDishproperties.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
	<div id="r_IdBusinessDetail" class="form-group">
		<label id="elh_MenuDishproperties_IdBusinessDetail" for="x_IdBusinessDetail" class="col-sm-2 control-label ewLabel"><%= MenuDishproperties.IdBusinessDetail.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuDishproperties.IdBusinessDetail.CellAttributes %>>
<span id="el_MenuDishproperties_IdBusinessDetail">
<input type="text" data-field="x_IdBusinessDetail" name="x_IdBusinessDetail" id="x_IdBusinessDetail" size="30" placeholder="<%= MenuDishproperties.IdBusinessDetail.PlaceHolder %>" value="<%= MenuDishproperties.IdBusinessDetail.EditValue %>"<%= MenuDishproperties.IdBusinessDetail.EditAttributes %>>
</span>
<%= MenuDishproperties.IdBusinessDetail.CustomMsg %></div></div>
	</div>
<% End If %>
<% If MenuDishproperties.dishpropertygroupid.Visible Then ' dishpropertygroupid %>
	<div id="r_dishpropertygroupid" class="form-group">
		<label id="elh_MenuDishproperties_dishpropertygroupid" for="x_dishpropertygroupid" class="col-sm-2 control-label ewLabel"><%= MenuDishproperties.dishpropertygroupid.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuDishproperties.dishpropertygroupid.CellAttributes %>>
<span id="el_MenuDishproperties_dishpropertygroupid">
<input type="text" data-field="x_dishpropertygroupid" name="x_dishpropertygroupid" id="x_dishpropertygroupid" size="30" placeholder="<%= MenuDishproperties.dishpropertygroupid.PlaceHolder %>" value="<%= MenuDishproperties.dishpropertygroupid.EditValue %>"<%= MenuDishproperties.dishpropertygroupid.EditAttributes %>>
</span>
<%= MenuDishproperties.dishpropertygroupid.CustomMsg %></div></div>
	</div>
<% End If %>
<% If MenuDishproperties.printingname.Visible Then ' printingname %>
	<div id="r_printingname" class="form-group">
		<label id="elh_MenuDishproperties_printingname" for="x_printingname" class="col-sm-2 control-label ewLabel"><%= MenuDishproperties.printingname.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuDishproperties.printingname.CellAttributes %>>
<span id="el_MenuDishproperties_printingname">
<input type="text" data-field="x_printingname" name="x_printingname" id="x_printingname" size="30" maxlength="255" placeholder="<%= MenuDishproperties.printingname.PlaceHolder %>" value="<%= MenuDishproperties.printingname.EditValue %>"<%= MenuDishproperties.printingname.EditAttributes %>>
</span>
<%= MenuDishproperties.printingname.CustomMsg %></div></div>
	</div>
<% End If %>
<% If MenuDishproperties.i_displaySort.Visible Then ' i_displaySort %>
	<div id="r_i_displaySort" class="form-group">
		<label id="elh_MenuDishproperties_i_displaySort" for="x_i_displaySort" class="col-sm-2 control-label ewLabel"><%= MenuDishproperties.i_displaySort.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuDishproperties.i_displaySort.CellAttributes %>>
<span id="el_MenuDishproperties_i_displaySort">
<input type="text" data-field="x_i_displaySort" name="x_i_displaySort" id="x_i_displaySort" size="30" placeholder="<%= MenuDishproperties.i_displaySort.PlaceHolder %>" value="<%= MenuDishproperties.i_displaySort.EditValue %>"<%= MenuDishproperties.i_displaySort.EditAttributes %>>
</span>
<%= MenuDishproperties.i_displaySort.CustomMsg %></div></div>
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
fMenuDishpropertiesadd.Init();
</script>
<%
MenuDishproperties_add.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set MenuDishproperties_add = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cMenuDishproperties_add

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
		TableName = "MenuDishproperties"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "MenuDishproperties_add"
	End Property

	' Page Name
	Public Property Get PageName()
		PageName = ew_CurrentPage()
	End Property

	' Page Url
	Public Property Get PageUrl()
		PageUrl = ew_CurrentPage() & "?"
		If MenuDishproperties.UseTokenInUrl Then PageUrl = PageUrl & "t=" & MenuDishproperties.TableVar & "&" ' add page token
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
		If MenuDishproperties.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (MenuDishproperties.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (MenuDishproperties.TableVar = Request.QueryString("t"))
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
		If IsEmpty(MenuDishproperties) Then Set MenuDishproperties = New cMenuDishproperties
		Set Table = MenuDishproperties

		' Initialize urls
		' Initialize form object

		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "add"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "MenuDishproperties"

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

		MenuDishproperties.CurrentAction = ew_IIf(Request.QueryString("a").Count > 0, Request.QueryString("a") & "", ObjForm.GetValue("a_list") & "") ' Set up current action

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
			results = MenuDishproperties.GetAutoFill(Request.Form("name"), Request.Form("q"))
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
		If Not MenuDishproperties Is Nothing Then
			If MenuDishproperties.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = MenuDishproperties.TableVar
				If MenuDishproperties.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf MenuDishproperties.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf MenuDishproperties.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf MenuDishproperties.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set MenuDishproperties = Nothing
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
			MenuDishproperties.CurrentAction = ObjForm.GetValue("a_add") ' Get form action
			CopyRecord = LoadOldRecord() ' Load old recordset
			Call LoadFormValues() ' Load form values

		' Not post back
		Else

			' Load key values from QueryString
			CopyRecord = True
			If Request.QueryString("ID").Count > 0 Then
				MenuDishproperties.ID.QueryStringValue = Request.QueryString("ID")
				Call MenuDishproperties.SetKey("ID", MenuDishproperties.ID.CurrentValue) ' Set up key
			Else
				Call MenuDishproperties.SetKey("ID", "") ' Clear key
				CopyRecord = False
			End If
			If CopyRecord Then
				MenuDishproperties.CurrentAction = "C" ' Copy Record
			Else
				MenuDishproperties.CurrentAction = "I" ' Display Blank Record
				Call LoadDefaultValues() ' Load default values
			End If
		End If

		' Set up Breadcrumb
		SetupBreadcrumb()

		' Validate form if post back
		If ObjForm.GetValue("a_add")&"" <> "" Then
			If Not ValidateForm() Then
				MenuDishproperties.CurrentAction = "I" ' Form error, reset action
				MenuDishproperties.EventCancelled = True ' Event cancelled
				Call RestoreFormValues() ' Restore form values
				FailureMessage = gsFormError
			End If
		End If

		' Perform action based on action code
		Select Case MenuDishproperties.CurrentAction
			Case "I" ' Blank record, no action required
			Case "C" ' Copy an existing record
				If Not LoadRow() Then ' Load record based on key
					If FailureMessage = "" Then FailureMessage = Language.Phrase("NoRecord") ' No record found
					Call Page_Terminate("MenuDishpropertieslist.asp") ' No matching record, return to list
				End If
			Case "A" ' Add new record
				MenuDishproperties.SendEmail = True ' Send email on add success
				If AddRow(OldRecordset) Then ' Add successful
					If SuccessMessage = "" Then SuccessMessage = Language.Phrase("AddSuccess") ' Set up success message
					Dim sReturnUrl
					sReturnUrl = MenuDishproperties.ReturnUrl
					If ew_GetPageName(sReturnUrl) = "MenuDishpropertiesview.asp" Then sReturnUrl = MenuDishproperties.ViewUrl("") ' View paging, return to view page with keyurl directly
					Call Page_Terminate(sReturnUrl) ' Clean up and return
				Else
					MenuDishproperties.EventCancelled = True ' Event cancelled
					Call RestoreFormValues() ' Add failed, restore form values
				End If
		End Select

		' Render row based on row type
		MenuDishproperties.RowType = EW_ROWTYPE_ADD ' Render add type

		' Render row
		Call MenuDishproperties.ResetAttrs()
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
		MenuDishproperties.dishproperty.CurrentValue = Null
		MenuDishproperties.dishproperty.OldValue = MenuDishproperties.dishproperty.CurrentValue
		MenuDishproperties.dishpropertyprice.CurrentValue = Null
		MenuDishproperties.dishpropertyprice.OldValue = MenuDishproperties.dishpropertyprice.CurrentValue
		MenuDishproperties.IdBusinessDetail.CurrentValue = Null
		MenuDishproperties.IdBusinessDetail.OldValue = MenuDishproperties.IdBusinessDetail.CurrentValue
		MenuDishproperties.dishpropertygroupid.CurrentValue = Null
		MenuDishproperties.dishpropertygroupid.OldValue = MenuDishproperties.dishpropertygroupid.CurrentValue
		MenuDishproperties.printingname.CurrentValue = Null
		MenuDishproperties.printingname.OldValue = MenuDishproperties.printingname.CurrentValue
		MenuDishproperties.i_displaySort.CurrentValue = Null
		MenuDishproperties.i_displaySort.OldValue = MenuDishproperties.i_displaySort.CurrentValue
	End Function

	' -----------------------------------------------------------------
	' Load form values
	'
	Function LoadFormValues()

		' Load values from form
		If Not MenuDishproperties.dishproperty.FldIsDetailKey Then MenuDishproperties.dishproperty.FormValue = ObjForm.GetValue("x_dishproperty")
		If Not MenuDishproperties.dishpropertyprice.FldIsDetailKey Then MenuDishproperties.dishpropertyprice.FormValue = ObjForm.GetValue("x_dishpropertyprice")
		If Not MenuDishproperties.IdBusinessDetail.FldIsDetailKey Then MenuDishproperties.IdBusinessDetail.FormValue = ObjForm.GetValue("x_IdBusinessDetail")
		If Not MenuDishproperties.dishpropertygroupid.FldIsDetailKey Then MenuDishproperties.dishpropertygroupid.FormValue = ObjForm.GetValue("x_dishpropertygroupid")
		If Not MenuDishproperties.printingname.FldIsDetailKey Then MenuDishproperties.printingname.FormValue = ObjForm.GetValue("x_printingname")
		If Not MenuDishproperties.i_displaySort.FldIsDetailKey Then MenuDishproperties.i_displaySort.FormValue = ObjForm.GetValue("x_i_displaySort")
	End Function

	' -----------------------------------------------------------------
	' Restore form values
	'
	Function RestoreFormValues()
		Call LoadOldRecord()
		MenuDishproperties.dishproperty.CurrentValue = MenuDishproperties.dishproperty.FormValue
		MenuDishproperties.dishpropertyprice.CurrentValue = MenuDishproperties.dishpropertyprice.FormValue
		MenuDishproperties.IdBusinessDetail.CurrentValue = MenuDishproperties.IdBusinessDetail.FormValue
		MenuDishproperties.dishpropertygroupid.CurrentValue = MenuDishproperties.dishpropertygroupid.FormValue
		MenuDishproperties.printingname.CurrentValue = MenuDishproperties.printingname.FormValue
		MenuDishproperties.i_displaySort.CurrentValue = MenuDishproperties.i_displaySort.FormValue
	End Function

	' -----------------------------------------------------------------
	' Load row based on key values
	'
	Function LoadRow()
		Dim RsRow, sSql, sFilter
		sFilter = MenuDishproperties.KeyFilter

		' Call Row Selecting event
		Call MenuDishproperties.Row_Selecting(sFilter)

		' Load sql based on filter
		MenuDishproperties.CurrentFilter = sFilter
		sSql = MenuDishproperties.SQL
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
		Call MenuDishproperties.Row_Selected(RsRow)
		MenuDishproperties.ID.DbValue = RsRow("ID")
		MenuDishproperties.dishproperty.DbValue = RsRow("dishproperty")
		MenuDishproperties.dishpropertyprice.DbValue = RsRow("dishpropertyprice")
		MenuDishproperties.IdBusinessDetail.DbValue = RsRow("IdBusinessDetail")
		MenuDishproperties.dishpropertygroupid.DbValue = RsRow("dishpropertygroupid")
		MenuDishproperties.printingname.DbValue = RsRow("printingname")
		MenuDishproperties.i_displaySort.DbValue = RsRow("i_displaySort")
	End Sub

	' Load DbValue from recordset
	Sub LoadDbValues(Rs)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		If Rs.Eof Then Exit Sub
		MenuDishproperties.ID.m_DbValue = Rs("ID")
		MenuDishproperties.dishproperty.m_DbValue = Rs("dishproperty")
		MenuDishproperties.dishpropertyprice.m_DbValue = Rs("dishpropertyprice")
		MenuDishproperties.IdBusinessDetail.m_DbValue = Rs("IdBusinessDetail")
		MenuDishproperties.dishpropertygroupid.m_DbValue = Rs("dishpropertygroupid")
		MenuDishproperties.printingname.m_DbValue = Rs("printingname")
		MenuDishproperties.i_displaySort.m_DbValue = Rs("i_displaySort")
	End Sub

	' Load old record
	Function LoadOldRecord()

		' Load key values from Session
		Dim bValidKey
		bValidKey = True
		If MenuDishproperties.GetKey("ID")&"" <> "" Then
			MenuDishproperties.ID.CurrentValue = MenuDishproperties.GetKey("ID") ' ID
		Else
			bValidKey = False
		End If

		' Load old recordset
		If bValidKey Then
			MenuDishproperties.CurrentFilter = MenuDishproperties.KeyFilter
			Dim sSql
			sSql = MenuDishproperties.SQL
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

		If MenuDishproperties.dishpropertyprice.FormValue = MenuDishproperties.dishpropertyprice.CurrentValue And IsNumeric(MenuDishproperties.dishpropertyprice.CurrentValue) Then
			MenuDishproperties.dishpropertyprice.CurrentValue = ew_StrToFloat(MenuDishproperties.dishpropertyprice.CurrentValue)
		End If

		' Call Row Rendering event
		Call MenuDishproperties.Row_Rendering()

		' ---------------------------------------
		'  Common render codes for all row types
		' ---------------------------------------
		' ID
		' dishproperty
		' dishpropertyprice
		' IdBusinessDetail
		' dishpropertygroupid
		' printingname
		' i_displaySort
		' -----------
		'  View  Row
		' -----------

		If MenuDishproperties.RowType = EW_ROWTYPE_VIEW Then ' View row

			' ID
			MenuDishproperties.ID.ViewValue = MenuDishproperties.ID.CurrentValue
			MenuDishproperties.ID.ViewCustomAttributes = ""

			' dishproperty
			MenuDishproperties.dishproperty.ViewValue = MenuDishproperties.dishproperty.CurrentValue
			MenuDishproperties.dishproperty.ViewCustomAttributes = ""

			' dishpropertyprice
			MenuDishproperties.dishpropertyprice.ViewValue = MenuDishproperties.dishpropertyprice.CurrentValue
			MenuDishproperties.dishpropertyprice.ViewCustomAttributes = ""

			' IdBusinessDetail
			MenuDishproperties.IdBusinessDetail.ViewValue = MenuDishproperties.IdBusinessDetail.CurrentValue
			MenuDishproperties.IdBusinessDetail.ViewCustomAttributes = ""

			' dishpropertygroupid
			MenuDishproperties.dishpropertygroupid.ViewValue = MenuDishproperties.dishpropertygroupid.CurrentValue
			MenuDishproperties.dishpropertygroupid.ViewCustomAttributes = ""

			' printingname
			MenuDishproperties.printingname.ViewValue = MenuDishproperties.printingname.CurrentValue
			MenuDishproperties.printingname.ViewCustomAttributes = ""

			' i_displaySort
			MenuDishproperties.i_displaySort.ViewValue = MenuDishproperties.i_displaySort.CurrentValue
			MenuDishproperties.i_displaySort.ViewCustomAttributes = ""

			' View refer script
			' dishproperty

			MenuDishproperties.dishproperty.LinkCustomAttributes = ""
			MenuDishproperties.dishproperty.HrefValue = ""
			MenuDishproperties.dishproperty.TooltipValue = ""

			' dishpropertyprice
			MenuDishproperties.dishpropertyprice.LinkCustomAttributes = ""
			MenuDishproperties.dishpropertyprice.HrefValue = ""
			MenuDishproperties.dishpropertyprice.TooltipValue = ""

			' IdBusinessDetail
			MenuDishproperties.IdBusinessDetail.LinkCustomAttributes = ""
			MenuDishproperties.IdBusinessDetail.HrefValue = ""
			MenuDishproperties.IdBusinessDetail.TooltipValue = ""

			' dishpropertygroupid
			MenuDishproperties.dishpropertygroupid.LinkCustomAttributes = ""
			MenuDishproperties.dishpropertygroupid.HrefValue = ""
			MenuDishproperties.dishpropertygroupid.TooltipValue = ""

			' printingname
			MenuDishproperties.printingname.LinkCustomAttributes = ""
			MenuDishproperties.printingname.HrefValue = ""
			MenuDishproperties.printingname.TooltipValue = ""

			' i_displaySort
			MenuDishproperties.i_displaySort.LinkCustomAttributes = ""
			MenuDishproperties.i_displaySort.HrefValue = ""
			MenuDishproperties.i_displaySort.TooltipValue = ""

		' ---------
		'  Add Row
		' ---------

		ElseIf MenuDishproperties.RowType = EW_ROWTYPE_ADD Then ' Add row

			' dishproperty
			MenuDishproperties.dishproperty.EditAttrs.UpdateAttribute "class", "form-control"
			MenuDishproperties.dishproperty.EditCustomAttributes = ""
			MenuDishproperties.dishproperty.EditValue = ew_HtmlEncode(MenuDishproperties.dishproperty.CurrentValue)
			MenuDishproperties.dishproperty.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuDishproperties.dishproperty.FldCaption))

			' dishpropertyprice
			MenuDishproperties.dishpropertyprice.EditAttrs.UpdateAttribute "class", "form-control"
			MenuDishproperties.dishpropertyprice.EditCustomAttributes = ""
			MenuDishproperties.dishpropertyprice.EditValue = ew_HtmlEncode(MenuDishproperties.dishpropertyprice.CurrentValue)
			MenuDishproperties.dishpropertyprice.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuDishproperties.dishpropertyprice.FldCaption))
			If MenuDishproperties.dishpropertyprice.EditValue&"" <> "" And IsNumeric(MenuDishproperties.dishpropertyprice.EditValue) Then MenuDishproperties.dishpropertyprice.EditValue = ew_FormatNumber2(MenuDishproperties.dishpropertyprice.EditValue, -2)

			' IdBusinessDetail
			MenuDishproperties.IdBusinessDetail.EditAttrs.UpdateAttribute "class", "form-control"
			MenuDishproperties.IdBusinessDetail.EditCustomAttributes = ""
			MenuDishproperties.IdBusinessDetail.EditValue = ew_HtmlEncode(MenuDishproperties.IdBusinessDetail.CurrentValue)
			MenuDishproperties.IdBusinessDetail.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuDishproperties.IdBusinessDetail.FldCaption))

			' dishpropertygroupid
			MenuDishproperties.dishpropertygroupid.EditAttrs.UpdateAttribute "class", "form-control"
			MenuDishproperties.dishpropertygroupid.EditCustomAttributes = ""
			MenuDishproperties.dishpropertygroupid.EditValue = ew_HtmlEncode(MenuDishproperties.dishpropertygroupid.CurrentValue)
			MenuDishproperties.dishpropertygroupid.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuDishproperties.dishpropertygroupid.FldCaption))

			' printingname
			MenuDishproperties.printingname.EditAttrs.UpdateAttribute "class", "form-control"
			MenuDishproperties.printingname.EditCustomAttributes = ""
			MenuDishproperties.printingname.EditValue = ew_HtmlEncode(MenuDishproperties.printingname.CurrentValue)
			MenuDishproperties.printingname.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuDishproperties.printingname.FldCaption))

			' i_displaySort
			MenuDishproperties.i_displaySort.EditAttrs.UpdateAttribute "class", "form-control"
			MenuDishproperties.i_displaySort.EditCustomAttributes = ""
			MenuDishproperties.i_displaySort.EditValue = ew_HtmlEncode(MenuDishproperties.i_displaySort.CurrentValue)
			MenuDishproperties.i_displaySort.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MenuDishproperties.i_displaySort.FldCaption))

			' Edit refer script
			' dishproperty

			MenuDishproperties.dishproperty.HrefValue = ""

			' dishpropertyprice
			MenuDishproperties.dishpropertyprice.HrefValue = ""

			' IdBusinessDetail
			MenuDishproperties.IdBusinessDetail.HrefValue = ""

			' dishpropertygroupid
			MenuDishproperties.dishpropertygroupid.HrefValue = ""

			' printingname
			MenuDishproperties.printingname.HrefValue = ""

			' i_displaySort
			MenuDishproperties.i_displaySort.HrefValue = ""
		End If
		If MenuDishproperties.RowType = EW_ROWTYPE_ADD Or MenuDishproperties.RowType = EW_ROWTYPE_EDIT Or MenuDishproperties.RowType = EW_ROWTYPE_SEARCH Then ' Add / Edit / Search row
			Call MenuDishproperties.SetupFieldTitles()
		End If

		' Call Row Rendered event
		If MenuDishproperties.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call MenuDishproperties.Row_Rendered()
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
		If Not ew_CheckNumber(MenuDishproperties.dishpropertyprice.FormValue) Then
			Call ew_AddMessage(gsFormError, MenuDishproperties.dishpropertyprice.FldErrMsg)
		End If
		If Not ew_CheckInteger(MenuDishproperties.IdBusinessDetail.FormValue) Then
			Call ew_AddMessage(gsFormError, MenuDishproperties.IdBusinessDetail.FldErrMsg)
		End If
		If Not ew_CheckInteger(MenuDishproperties.dishpropertygroupid.FormValue) Then
			Call ew_AddMessage(gsFormError, MenuDishproperties.dishpropertygroupid.FldErrMsg)
		End If
		If Not ew_CheckInteger(MenuDishproperties.i_displaySort.FormValue) Then
			Call ew_AddMessage(gsFormError, MenuDishproperties.i_displaySort.FldErrMsg)
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
		MenuDishproperties.CurrentFilter = sFilter
		sSql = MenuDishproperties.SQL
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

		' Field dishproperty
		Call MenuDishproperties.dishproperty.SetDbValue(Rs, MenuDishproperties.dishproperty.CurrentValue, Null, False)

		' Field dishpropertyprice
		Call MenuDishproperties.dishpropertyprice.SetDbValue(Rs, MenuDishproperties.dishpropertyprice.CurrentValue, Null, False)

		' Field IdBusinessDetail
		Call MenuDishproperties.IdBusinessDetail.SetDbValue(Rs, MenuDishproperties.IdBusinessDetail.CurrentValue, Null, False)

		' Field dishpropertygroupid
		Call MenuDishproperties.dishpropertygroupid.SetDbValue(Rs, MenuDishproperties.dishpropertygroupid.CurrentValue, Null, False)

		' Field printingname
		Call MenuDishproperties.printingname.SetDbValue(Rs, MenuDishproperties.printingname.CurrentValue, Null, False)

		' Field i_displaySort
		Call MenuDishproperties.i_displaySort.SetDbValue(Rs, MenuDishproperties.i_displaySort.CurrentValue, Null, False)

		' Check recordset update error
		If Err.Number <> 0 Then
			FailureMessage = Err.Description
			Rs.Close
			Set Rs = Nothing
			AddRow = False
			Exit Function
		End If

		' Call Row Inserting event
		bInsertRow = MenuDishproperties.Row_Inserting(RsOld, Rs)
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
			ElseIf MenuDishproperties.CancelMessage <> "" Then
				FailureMessage = MenuDishproperties.CancelMessage
				MenuDishproperties.CancelMessage = ""
			Else
				FailureMessage = Language.Phrase("InsertCancelled")
			End If
			AddRow = False
		End If
		Rs.Close
		Set Rs = Nothing
		If AddRow Then
			MenuDishproperties.ID.DbValue = RsNew("ID")
		End If
		If AddRow Then

			' Call Row Inserted event
			Call MenuDishproperties.Row_Inserted(RsOld, RsNew)
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
		Call Breadcrumb.Add("list", MenuDishproperties.TableVar, "MenuDishpropertieslist.asp", "", MenuDishproperties.TableVar, True)
		PageId = ew_IIf(MenuDishproperties.CurrentAction = "C", "Copy", "Add")
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
