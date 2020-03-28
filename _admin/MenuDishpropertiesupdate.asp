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
Dim MenuDishproperties_update
Set MenuDishproperties_update = New cMenuDishproperties_update
Set Page = MenuDishproperties_update

' Page init processing
MenuDishproperties_update.Page_Init()

' Page main processing
MenuDishproperties_update.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
MenuDishproperties_update.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var MenuDishproperties_update = new ew_Page("MenuDishproperties_update");
MenuDishproperties_update.PageID = "update"; // Page ID
var EW_PAGE_ID = MenuDishproperties_update.PageID; // For backward compatibility
// Form object
var fMenuDishpropertiesupdate = new ew_Form("fMenuDishpropertiesupdate");
// Validate form
fMenuDishpropertiesupdate.Validate = function() {
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
			elm = this.GetElements("x" + infix + "_dishpropertyprice");
			uelm = this.GetElements("u" + infix + "_dishpropertyprice");
			if (uelm && uelm.checked && elm && !ew_CheckNumber(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(MenuDishproperties.dishpropertyprice.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_IdBusinessDetail");
			uelm = this.GetElements("u" + infix + "_IdBusinessDetail");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(MenuDishproperties.IdBusinessDetail.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_dishpropertygroupid");
			uelm = this.GetElements("u" + infix + "_dishpropertygroupid");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(MenuDishproperties.dishpropertygroupid.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_i_displaySort");
			uelm = this.GetElements("u" + infix + "_i_displaySort");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(MenuDishproperties.i_displaySort.FldErrMsg) %>");
			// Set up row object
			ew_ElementsToRow(fobj);
			// Fire Form_CustomValidate event
			if (!this.Form_CustomValidate(fobj))
				return false;
	}
	return true;
}
// Form_CustomValidate event
fMenuDishpropertiesupdate.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fMenuDishpropertiesupdate.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fMenuDishpropertiesupdate.ValidateRequired = false; // No JavaScript validation
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
<% MenuDishproperties_update.ShowPageHeader() %>
<% MenuDishproperties_update.ShowMessage %>
<form name="fMenuDishpropertiesupdate" id="fMenuDishpropertiesupdate" class="form-horizontal ewForm ewUpdateForm" action="<%= ew_CurrentPage %>" method="post">
<% If MenuDishproperties_update.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= MenuDishproperties_update.Token %>">
<% End If %>
<input type="hidden" name="t" value="MenuDishproperties">
<input type="hidden" name="a_update" id="a_update" value="U">
<% For i = 0 to UBound(MenuDishproperties_update.RecKeys) %>
<input type="hidden" name="key_m" id="key_m" value="<%= ew_HtmlEncode(ew_GetKeyValue(MenuDishproperties_update.RecKeys(i))) %>">
<% Next %>
<div id="tbl_MenuDishpropertiesupdate">
	<div class="form-group">
		<label class="col-sm-2"><input type="checkbox" name="u" id="u" onclick="ew_SelectAll(this);"> <%= Language.Phrase("UpdateSelectAll") %></label>
	</div>
<% If MenuDishproperties.dishproperty.Visible Then ' dishproperty %>
	<div id="r_dishproperty" class="form-group">
		<label for="x_dishproperty" class="col-sm-2 control-label">
<input type="checkbox" name="u_dishproperty" id="u_dishproperty" value="1"<% If MenuDishproperties.dishproperty.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= MenuDishproperties.dishproperty.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuDishproperties.dishproperty.CellAttributes %>>
<span id="el_MenuDishproperties_dishproperty">
<input type="text" data-field="x_dishproperty" name="x_dishproperty" id="x_dishproperty" size="30" maxlength="255" placeholder="<%= MenuDishproperties.dishproperty.PlaceHolder %>" value="<%= MenuDishproperties.dishproperty.EditValue %>"<%= MenuDishproperties.dishproperty.EditAttributes %>>
</span>
<%= MenuDishproperties.dishproperty.CustomMsg %></div></div>
	</div>
<% End If %>
<% If MenuDishproperties.dishpropertyprice.Visible Then ' dishpropertyprice %>
	<div id="r_dishpropertyprice" class="form-group">
		<label for="x_dishpropertyprice" class="col-sm-2 control-label">
<input type="checkbox" name="u_dishpropertyprice" id="u_dishpropertyprice" value="1"<% If MenuDishproperties.dishpropertyprice.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= MenuDishproperties.dishpropertyprice.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuDishproperties.dishpropertyprice.CellAttributes %>>
<span id="el_MenuDishproperties_dishpropertyprice">
<input type="text" data-field="x_dishpropertyprice" name="x_dishpropertyprice" id="x_dishpropertyprice" size="30" placeholder="<%= MenuDishproperties.dishpropertyprice.PlaceHolder %>" value="<%= MenuDishproperties.dishpropertyprice.EditValue %>"<%= MenuDishproperties.dishpropertyprice.EditAttributes %>>
</span>
<%= MenuDishproperties.dishpropertyprice.CustomMsg %></div></div>
	</div>
<% End If %>
<% If MenuDishproperties.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
	<div id="r_IdBusinessDetail" class="form-group">
		<label for="x_IdBusinessDetail" class="col-sm-2 control-label">
<input type="checkbox" name="u_IdBusinessDetail" id="u_IdBusinessDetail" value="1"<% If MenuDishproperties.IdBusinessDetail.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= MenuDishproperties.IdBusinessDetail.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuDishproperties.IdBusinessDetail.CellAttributes %>>
<span id="el_MenuDishproperties_IdBusinessDetail">
<input type="text" data-field="x_IdBusinessDetail" name="x_IdBusinessDetail" id="x_IdBusinessDetail" size="30" placeholder="<%= MenuDishproperties.IdBusinessDetail.PlaceHolder %>" value="<%= MenuDishproperties.IdBusinessDetail.EditValue %>"<%= MenuDishproperties.IdBusinessDetail.EditAttributes %>>
</span>
<%= MenuDishproperties.IdBusinessDetail.CustomMsg %></div></div>
	</div>
<% End If %>
<% If MenuDishproperties.dishpropertygroupid.Visible Then ' dishpropertygroupid %>
	<div id="r_dishpropertygroupid" class="form-group">
		<label for="x_dishpropertygroupid" class="col-sm-2 control-label">
<input type="checkbox" name="u_dishpropertygroupid" id="u_dishpropertygroupid" value="1"<% If MenuDishproperties.dishpropertygroupid.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= MenuDishproperties.dishpropertygroupid.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuDishproperties.dishpropertygroupid.CellAttributes %>>
<span id="el_MenuDishproperties_dishpropertygroupid">
<input type="text" data-field="x_dishpropertygroupid" name="x_dishpropertygroupid" id="x_dishpropertygroupid" size="30" placeholder="<%= MenuDishproperties.dishpropertygroupid.PlaceHolder %>" value="<%= MenuDishproperties.dishpropertygroupid.EditValue %>"<%= MenuDishproperties.dishpropertygroupid.EditAttributes %>>
</span>
<%= MenuDishproperties.dishpropertygroupid.CustomMsg %></div></div>
	</div>
<% End If %>
<% If MenuDishproperties.printingname.Visible Then ' printingname %>
	<div id="r_printingname" class="form-group">
		<label for="x_printingname" class="col-sm-2 control-label">
<input type="checkbox" name="u_printingname" id="u_printingname" value="1"<% If MenuDishproperties.printingname.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= MenuDishproperties.printingname.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuDishproperties.printingname.CellAttributes %>>
<span id="el_MenuDishproperties_printingname">
<input type="text" data-field="x_printingname" name="x_printingname" id="x_printingname" size="30" maxlength="255" placeholder="<%= MenuDishproperties.printingname.PlaceHolder %>" value="<%= MenuDishproperties.printingname.EditValue %>"<%= MenuDishproperties.printingname.EditAttributes %>>
</span>
<%= MenuDishproperties.printingname.CustomMsg %></div></div>
	</div>
<% End If %>
<% If MenuDishproperties.i_displaySort.Visible Then ' i_displaySort %>
	<div id="r_i_displaySort" class="form-group">
		<label for="x_i_displaySort" class="col-sm-2 control-label">
<input type="checkbox" name="u_i_displaySort" id="u_i_displaySort" value="1"<% If MenuDishproperties.i_displaySort.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= MenuDishproperties.i_displaySort.FldCaption %></label>
		<div class="col-sm-10"><div<%= MenuDishproperties.i_displaySort.CellAttributes %>>
<span id="el_MenuDishproperties_i_displaySort">
<input type="text" data-field="x_i_displaySort" name="x_i_displaySort" id="x_i_displaySort" size="30" placeholder="<%= MenuDishproperties.i_displaySort.PlaceHolder %>" value="<%= MenuDishproperties.i_displaySort.EditValue %>"<%= MenuDishproperties.i_displaySort.EditAttributes %>>
</span>
<%= MenuDishproperties.i_displaySort.CustomMsg %></div></div>
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
fMenuDishpropertiesupdate.Init();
</script>
<%
MenuDishproperties_update.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set MenuDishproperties_update = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cMenuDishproperties_update

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
		TableName = "MenuDishproperties"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "MenuDishproperties_update"
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
		EW_PAGE_ID = "update"

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
		RecKeys = MenuDishproperties.GetRecordKeys() ' Load record keys
		If ObjForm.GetValue("a_update")&"" <> "" Then

			' Get action
			MenuDishproperties.CurrentAction = ObjForm.GetValue("a_update")
			Call LoadFormValues() ' Get form values

			' Validate form
			If Not ValidateForm() Then
				MenuDishproperties.CurrentAction = "I" ' Form error, reset action
				FailureMessage = gsFormError
			End If
		Else
			Call LoadMultiUpdateValues() ' Load initial values to form
		End If
		If Not IsArray(RecKeys) Then
			Call Page_Terminate("MenuDishpropertieslist.asp") ' No records selected, return to list
		End If
		Select Case MenuDishproperties.CurrentAction
			Case "U" ' Update
				If UpdateRows() Then ' Update Records based on key
					If SuccessMessage = "" Then SuccessMessage = Language.Phrase("UpdateSuccess") ' Set update success message
					Call Page_Terminate(MenuDishproperties.ReturnUrl) ' Return to caller
				Else
					Call RestoreFormValues() ' Restore form values
				End If
		End Select

		' Render row
		MenuDishproperties.RowType = EW_ROWTYPE_EDIT ' Render edit

		' Render row
		Call MenuDishproperties.ResetAttrs()
		Call RenderRow()
	End Sub

	' -----------------------------------------------------------------
	' Load initial values to form if field values are identical in all selected records
	'
	Sub LoadMultiUpdateValues()
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		Dim Rs, i, OldValue, NewValue
		MenuDishproperties.CurrentFilter = MenuDishproperties.GetKeyFilter()

		' Load recordset
		Set Rs = LoadRecordset()
		i = 1
		Do While Not Rs.Eof
			If i = 1 Then
				MenuDishproperties.dishproperty.DbValue = ew_Conv(Rs("dishproperty"), Rs("dishproperty").Type)
				MenuDishproperties.dishpropertyprice.DbValue = ew_Conv(Rs("dishpropertyprice"), Rs("dishpropertyprice").Type)
				MenuDishproperties.IdBusinessDetail.DbValue = ew_Conv(Rs("IdBusinessDetail"), Rs("IdBusinessDetail").Type)
				MenuDishproperties.dishpropertygroupid.DbValue = ew_Conv(Rs("dishpropertygroupid"), Rs("dishpropertygroupid").Type)
				MenuDishproperties.printingname.DbValue = ew_Conv(Rs("printingname"), Rs("printingname").Type)
				MenuDishproperties.i_displaySort.DbValue = ew_Conv(Rs("i_displaySort"), Rs("i_displaySort").Type)
			Else
				OldValue = MenuDishproperties.dishproperty.DbValue
				NewValue = ew_Conv(Rs("dishproperty"), Rs("dishproperty").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					MenuDishproperties.dishproperty.CurrentValue = Null
				End If
				OldValue = MenuDishproperties.dishpropertyprice.DbValue
				NewValue = ew_Conv(Rs("dishpropertyprice"), Rs("dishpropertyprice").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					MenuDishproperties.dishpropertyprice.CurrentValue = Null
				End If
				OldValue = MenuDishproperties.IdBusinessDetail.DbValue
				NewValue = ew_Conv(Rs("IdBusinessDetail"), Rs("IdBusinessDetail").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					MenuDishproperties.IdBusinessDetail.CurrentValue = Null
				End If
				OldValue = MenuDishproperties.dishpropertygroupid.DbValue
				NewValue = ew_Conv(Rs("dishpropertygroupid"), Rs("dishpropertygroupid").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					MenuDishproperties.dishpropertygroupid.CurrentValue = Null
				End If
				OldValue = MenuDishproperties.printingname.DbValue
				NewValue = ew_Conv(Rs("printingname"), Rs("printingname").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					MenuDishproperties.printingname.CurrentValue = Null
				End If
				OldValue = MenuDishproperties.i_displaySort.DbValue
				NewValue = ew_Conv(Rs("i_displaySort"), Rs("i_displaySort").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					MenuDishproperties.i_displaySort.CurrentValue = Null
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
		MenuDishproperties.ID.CurrentValue = sKeyFld ' Set up key value
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
		MenuDishproperties.CurrentFilter = MenuDishproperties.GetKeyFilter()
		sSql = MenuDishproperties.SQL
		Set Rs = Server.CreateObject("ADODB.Recordset")
		Rs.CursorLocation = EW_CURSORLOCATION
		Rs.Open sSql, Conn, 1, EW_RECORDSET_LOCKTYPE
		Set RsOld = ew_CloneRs(Rs)

		' Update all rows
		sKey = ""
		For i = 0 to UBound(RecKeys)
			If SetupKeyValues(RecKeys(i)) Then
				sThisKey = RecKeys(i)
				MenuDishproperties.SendEmail = False ' Do not send email on update success
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
		If Not MenuDishproperties.dishproperty.FldIsDetailKey Then MenuDishproperties.dishproperty.FormValue = ObjForm.GetValue("x_dishproperty")
		MenuDishproperties.dishproperty.MultiUpdate = ObjForm.GetValue("u_dishproperty")
		If Not MenuDishproperties.dishpropertyprice.FldIsDetailKey Then MenuDishproperties.dishpropertyprice.FormValue = ObjForm.GetValue("x_dishpropertyprice")
		MenuDishproperties.dishpropertyprice.MultiUpdate = ObjForm.GetValue("u_dishpropertyprice")
		If Not MenuDishproperties.IdBusinessDetail.FldIsDetailKey Then MenuDishproperties.IdBusinessDetail.FormValue = ObjForm.GetValue("x_IdBusinessDetail")
		MenuDishproperties.IdBusinessDetail.MultiUpdate = ObjForm.GetValue("u_IdBusinessDetail")
		If Not MenuDishproperties.dishpropertygroupid.FldIsDetailKey Then MenuDishproperties.dishpropertygroupid.FormValue = ObjForm.GetValue("x_dishpropertygroupid")
		MenuDishproperties.dishpropertygroupid.MultiUpdate = ObjForm.GetValue("u_dishpropertygroupid")
		If Not MenuDishproperties.printingname.FldIsDetailKey Then MenuDishproperties.printingname.FormValue = ObjForm.GetValue("x_printingname")
		MenuDishproperties.printingname.MultiUpdate = ObjForm.GetValue("u_printingname")
		If Not MenuDishproperties.i_displaySort.FldIsDetailKey Then MenuDishproperties.i_displaySort.FormValue = ObjForm.GetValue("x_i_displaySort")
		MenuDishproperties.i_displaySort.MultiUpdate = ObjForm.GetValue("u_i_displaySort")
		If Not MenuDishproperties.ID.FldIsDetailKey Then MenuDishproperties.ID.FormValue = ObjForm.GetValue("x_ID")
	End Function

	' -----------------------------------------------------------------
	' Restore form values
	'
	Function RestoreFormValues()
		MenuDishproperties.dishproperty.CurrentValue = MenuDishproperties.dishproperty.FormValue
		MenuDishproperties.dishpropertyprice.CurrentValue = MenuDishproperties.dishpropertyprice.FormValue
		MenuDishproperties.IdBusinessDetail.CurrentValue = MenuDishproperties.IdBusinessDetail.FormValue
		MenuDishproperties.dishpropertygroupid.CurrentValue = MenuDishproperties.dishpropertygroupid.FormValue
		MenuDishproperties.printingname.CurrentValue = MenuDishproperties.printingname.FormValue
		MenuDishproperties.i_displaySort.CurrentValue = MenuDishproperties.i_displaySort.FormValue
		MenuDishproperties.ID.CurrentValue = MenuDishproperties.ID.FormValue
	End Function

	' -----------------------------------------------------------------
	' Load recordset
	'
	Function LoadRecordset()

		' Load list page sql
		Dim sSql
		sSql = MenuDishproperties.SelectSQL
		Call ew_SetDebugMsg("LoadRecordset: " & sSql) ' Show SQL for debugging

		' Load recordset
		Dim RsRecordset
		Set RsRecordset = ew_LoadRecordset(sSql)

		' Call Recordset Selected event
		Call MenuDishproperties.Recordset_Selected(RsRecordset)
		Set LoadRecordset = RsRecordset
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

		' ----------
		'  Edit Row
		' ----------

		ElseIf MenuDishproperties.RowType = EW_ROWTYPE_EDIT Then ' Edit row

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
		Dim lUpdateCnt
		lUpdateCnt = 0
		If MenuDishproperties.dishproperty.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If MenuDishproperties.dishpropertyprice.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If MenuDishproperties.IdBusinessDetail.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If MenuDishproperties.dishpropertygroupid.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If MenuDishproperties.printingname.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If MenuDishproperties.i_displaySort.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
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
		If MenuDishproperties.dishpropertyprice.MultiUpdate <> "" Then
			If Not ew_CheckNumber(MenuDishproperties.dishpropertyprice.FormValue) Then
				Call ew_AddMessage(gsFormError, MenuDishproperties.dishpropertyprice.FldErrMsg)
			End If
		End If
		If MenuDishproperties.IdBusinessDetail.MultiUpdate <> "" Then
			If Not ew_CheckInteger(MenuDishproperties.IdBusinessDetail.FormValue) Then
				Call ew_AddMessage(gsFormError, MenuDishproperties.IdBusinessDetail.FldErrMsg)
			End If
		End If
		If MenuDishproperties.dishpropertygroupid.MultiUpdate <> "" Then
			If Not ew_CheckInteger(MenuDishproperties.dishpropertygroupid.FormValue) Then
				Call ew_AddMessage(gsFormError, MenuDishproperties.dishpropertygroupid.FldErrMsg)
			End If
		End If
		If MenuDishproperties.i_displaySort.MultiUpdate <> "" Then
			If Not ew_CheckInteger(MenuDishproperties.i_displaySort.FormValue) Then
				Call ew_AddMessage(gsFormError, MenuDishproperties.i_displaySort.FldErrMsg)
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
		sFilter = MenuDishproperties.KeyFilter
		MenuDishproperties.CurrentFilter  = sFilter
		sSql = MenuDishproperties.SQL
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

			' Field dishproperty
			Call MenuDishproperties.dishproperty.SetDbValue(Rs, MenuDishproperties.dishproperty.CurrentValue, Null, MenuDishproperties.dishproperty.ReadOnly Or MenuDishproperties.dishproperty.MultiUpdate&"" <> "1")

			' Field dishpropertyprice
			Call MenuDishproperties.dishpropertyprice.SetDbValue(Rs, MenuDishproperties.dishpropertyprice.CurrentValue, Null, MenuDishproperties.dishpropertyprice.ReadOnly Or MenuDishproperties.dishpropertyprice.MultiUpdate&"" <> "1")

			' Field IdBusinessDetail
			Call MenuDishproperties.IdBusinessDetail.SetDbValue(Rs, MenuDishproperties.IdBusinessDetail.CurrentValue, Null, MenuDishproperties.IdBusinessDetail.ReadOnly Or MenuDishproperties.IdBusinessDetail.MultiUpdate&"" <> "1")

			' Field dishpropertygroupid
			Call MenuDishproperties.dishpropertygroupid.SetDbValue(Rs, MenuDishproperties.dishpropertygroupid.CurrentValue, Null, MenuDishproperties.dishpropertygroupid.ReadOnly Or MenuDishproperties.dishpropertygroupid.MultiUpdate&"" <> "1")

			' Field printingname
			Call MenuDishproperties.printingname.SetDbValue(Rs, MenuDishproperties.printingname.CurrentValue, Null, MenuDishproperties.printingname.ReadOnly Or MenuDishproperties.printingname.MultiUpdate&"" <> "1")

			' Field i_displaySort
			Call MenuDishproperties.i_displaySort.SetDbValue(Rs, MenuDishproperties.i_displaySort.CurrentValue, Null, MenuDishproperties.i_displaySort.ReadOnly Or MenuDishproperties.i_displaySort.MultiUpdate&"" <> "1")

			' Check recordset update error
			If Err.Number <> 0 Then
				FailureMessage = Err.Description
				Rs.Close
				Set Rs = Nothing
				EditRow = False
				Exit Function
			End If

			' Call Row Updating event
			bUpdateRow = MenuDishproperties.Row_Updating(RsOld, Rs)
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
				ElseIf MenuDishproperties.CancelMessage <> "" Then
					FailureMessage = MenuDishproperties.CancelMessage
					MenuDishproperties.CancelMessage = ""
				Else
					FailureMessage = Language.Phrase("UpdateCancelled")
				End If
				EditRow = False
			End If
		End If

		' Call Row Updated event
		If EditRow Then
			Call MenuDishproperties.Row_Updated(RsOld, RsNew)
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
		Call Breadcrumb.Add("list", MenuDishproperties.TableVar, "MenuDishpropertieslist.asp", "", MenuDishproperties.TableVar, True)
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
