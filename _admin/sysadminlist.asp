<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="sysadmininfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim sysadmin_list
Set sysadmin_list = New csysadmin_list
Set Page = sysadmin_list

' Page init processing
sysadmin_list.Page_Init()

' Page main processing
sysadmin_list.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
sysadmin_list.Page_Render()
%>
<!--#include file="header.asp"-->
<% If sysadmin.Export = "" Then %>
<script type="text/javascript">
// Page object
var sysadmin_list = new ew_Page("sysadmin_list");
sysadmin_list.PageID = "list"; // Page ID
var EW_PAGE_ID = sysadmin_list.PageID; // For backward compatibility
// Form object
var fsysadminlist = new ew_Form("fsysadminlist");
fsysadminlist.FormKeyCountName = '<%= sysadmin_list.FormKeyCountName %>';
// Validate form
fsysadminlist.Validate = function() {
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
		var checkrow = (gridinsert) ? !this.EmptyRow(infix) : true;
		if (checkrow) {
			addcnt++;
			// Set up row object
			ew_ElementsToRow(fobj);
			// Fire Form_CustomValidate event
			if (!this.Form_CustomValidate(fobj))
				return false;
		} // End Grid Add checking
	}
	if (gridinsert && addcnt == 0) { // No row added
		alert(ewLanguage.Phrase("NoAddRecord"));
		return false;
	}
	return true;
}
// Check empty row
fsysadminlist.EmptyRow = function(infix) {
	var fobj = this.Form;
	if (ew_ValueChanged(fobj, infix, "username", false)) return false;
	if (ew_ValueChanged(fobj, infix, "pswd", false)) return false;
	if (ew_ValueChanged(fobj, infix, "userrolelabel", false)) return false;
	if (ew_ValueChanged(fobj, infix, "userrole", false)) return false;
	return true;
}
// Form_CustomValidate event
fsysadminlist.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fsysadminlist.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fsysadminlist.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
var fsysadminlistsrch = new ew_Form("fsysadminlistsrch");
</script>
<style type="text/css">
.ewTablePreviewRow { /* main table preview row color */
	background-color: #FFFFFF; /* preview row color */
}
.ewTablePreviewRow .ewGrid {
	display: table;
}
.ewTablePreviewRow .ewGrid .ewTable {
	width: auto;
}
</style>
<div id="ewPreview" class="hide"><ul class="nav nav-tabs"></ul><div class="tab-content"><div class="tab-pane fade"></div></div></div>
<script type="text/javascript" src="js/ewpreview.min.js"></script>
<script type="text/javascript">
var EW_PREVIEW_PLACEMENT = EW_CSS_FLIP ? "left" : "right";
var EW_PREVIEW_SINGLE_ROW = false;
var EW_PREVIEW_OVERLAY = false;
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<% End If %>
<% If sysadmin.Export = "" Then %>
<div class="ewToolbar">
<% If sysadmin.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If sysadmin_list.TotalRecs > 0 And sysadmin_list.ExportOptions.Visible Then %>
<% sysadmin_list.ExportOptions.Render "body", "", "", "", "", "" %>
<% End If %>
<% If sysadmin_list.SearchOptions.Visible Then %>
<% sysadmin_list.SearchOptions.Render "body", "", "", "", "", "" %>
<% End If %>
<% If sysadmin.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% End If %>
<% If (sysadmin.Export = "") Or (EW_EXPORT_MASTER_RECORD And sysadmin.Export = "print") Then %>
<% End If %>
<%
If sysadmin.CurrentAction = "gridadd" Then
	sysadmin.CurrentFilter = "0=1"
End If

' Load recordset
'Set sysadmin_list.Recordset = sysadmin_list.LoadRecordset()

If sysadmin.CurrentAction = "gridadd" Then
	sysadmin_list.StartRec = 1
	sysadmin_list.DisplayRecs = sysadmin.GridAddRowCount
	sysadmin_list.TotalRecs = sysadmin_list.DisplayRecs
	sysadmin_list.StopRec = sysadmin_list.DisplayRecs
Else
	sysadmin_list.TotalRecs = sysadmin_list.Recordset.RecordCount
	sysadmin_list.StartRec = 1
	If sysadmin_list.DisplayRecs <= 0 Then ' Display all records
		sysadmin_list.DisplayRecs = sysadmin_list.TotalRecs
	End If
	If Not (sysadmin.ExportAll And sysadmin.Export <> "") Then
		sysadmin_list.SetUpStartRec() ' Set up start record position
	End If

	' Set no record found message
	If sysadmin.CurrentAction = "" And sysadmin_list.TotalRecs = 0 Then
		If sysadmin_list.SearchWhere = "0=101" Then
			sysadmin_list.WarningMessage = Language.Phrase("EnterSearchCriteria")
		Else
			sysadmin_list.WarningMessage = Language.Phrase("NoRecord")
		End If
	End If
End If
sysadmin_list.RenderOtherOptions()
%>
<% If sysadmin.Export = "" And sysadmin.CurrentAction = "" Then %>
<form name="fsysadminlistsrch" id="fsysadminlistsrch" class="form-inline ewForm" action="<%= ew_CurrentPage %>">
<% SearchPanelClass = ew_IIf(sysadmin_list.SearchWhere <> "", " in", " in") %>
<div id="fsysadminlistsrch_SearchPanel" class="ewSearchPanel collapse<%= SearchPanelClass %>">
<input type="hidden" name="cmd" value="search">
<input type="hidden" name="t" value="sysadmin">
	<div class="ewBasicSearch">
<div id="xsr_1" class="ewRow">
	<div class="ewQuickSearch input-group">
	<input type="text" name="<%= EW_TABLE_BASIC_SEARCH %>" id="<%= EW_TABLE_BASIC_SEARCH %>" class="form-control" value="<%= ew_HtmlEncode(sysadmin.BasicSearch.getKeyword()) %>" placeholder="<%= ew_HtmlEncode(Language.Phrase("Search")) %>">
	<input type="hidden" name="<%= EW_TABLE_BASIC_SEARCH_TYPE %>" id="<%= EW_TABLE_BASIC_SEARCH_TYPE %>" value="<%= ew_HtmlEncode(sysadmin.BasicSearch.getSearchType()) %>">
	<div class="input-group-btn">
		<button type="button" data-toggle="dropdown" class="btn btn-default"><span id="searchtype"><%= sysadmin.BasicSearch.getSearchTypeNameShort() %></span><span class="caret"></span></button>
		<ul class="dropdown-menu pull-right" role="menu">
			<li<% If sysadmin.BasicSearch.getSearchType() = "" Then Response.Write " class=""active""" %>><a href="javascript:void(0);" onclick="ew_SetSearchType(this)"><%= Language.Phrase("QuickSearchAuto") %></a></li>
			<li<% If sysadmin.BasicSearch.getSearchType() = "=" Then Response.Write " class=""active""" %>><a href="javascript:void(0);" onclick="ew_SetSearchType(this,'=')"><%= Language.Phrase("QuickSearchExact") %></a></li>
			<li<% If sysadmin.BasicSearch.getSearchType() = "AND" Then Response.Write " class=""active""" %>><a href="javascript:void(0);" onclick="ew_SetSearchType(this,'AND')"><%= Language.Phrase("QuickSearchAll") %></a></li>
			<li<% If sysadmin.BasicSearch.getSearchType() = "OR" Then Response.Write " class=""active""" %>><a href="javascript:void(0);" onclick="ew_SetSearchType(this,'OR')"><%= Language.Phrase("QuickSearchAny") %></a></li>
		</ul>
	<button class="btn btn-primary ewButton" name="btnsubmit" id="btnsubmit" type="submit"><%= Language.Phrase("QuickSearchBtn") %></button>
	</div>
	</div>
</div>
	</div>
</div>
</form>
<% End If %>
<% sysadmin_list.ShowPageHeader() %>
<% sysadmin_list.ShowMessage %>
<% If sysadmin_list.TotalRecs > 0 Or sysadmin.CurrentAction <> "" Then %>
<div class="ewGrid">
<% If sysadmin.Export = "" Then %>
<div class="ewGridUpperPanel">
<% If sysadmin.CurrentAction <> "gridadd" And sysadmin.CurrentAction <> "gridedit" Then %>
<form name="ewPagerForm" class="form-inline ewForm ewPagerForm" action="<%= ew_CurrentPage %>">
<% If Not IsObject(sysadmin_list.Pager) Then Set sysadmin_list.Pager = ew_NewPrevNextPager(sysadmin_list.StartRec, sysadmin_list.DisplayRecs, sysadmin_list.TotalRecs) %>
<% If sysadmin_list.Pager.RecordCount > 0 Then %>
<div class="ewPager">
<span><%= Language.Phrase("Page") %>&nbsp;</span>
<div class="ewPrevNext"><div class="input-group">
<div class="input-group-btn">
<!--first page button-->
	<% If sysadmin_list.Pager.FirstButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerFirst") %>" href="<%= sysadmin_list.PageUrl %>start=<%= sysadmin_list.Pager.FirstButton.Start %>"><span class="icon-first ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerFirst") %>"><span class="icon-first ewIcon"></span></a>
	<% End If %>
<!--previous page button-->
	<% If sysadmin_list.Pager.PrevButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerPrevious") %>" href="<%= sysadmin_list.PageUrl %>start=<%= sysadmin_list.Pager.PrevButton.Start %>"><span class="icon-prev ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerPrevious") %>"><span class="icon-prev ewIcon"></span></a>
	<% End If %>
</div>
<!--current page number-->
	<input class="form-control input-sm" type="text" name="<%= EW_TABLE_PAGE_NO %>" value="<%= sysadmin_list.Pager.CurrentPage %>">
<div class="input-group-btn">
<!--next page button-->
	<% If sysadmin_list.Pager.NextButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerNext") %>" href="<%= sysadmin_list.PageUrl %>start=<%= sysadmin_list.Pager.NextButton.Start %>"><span class="icon-next ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerNext") %>"><span class="icon-next ewIcon"></span></a>
	<% End If %>
<!--last page button-->
	<% If sysadmin_list.Pager.LastButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerLast") %>" href="<%= sysadmin_list.PageUrl %>start=<%= sysadmin_list.Pager.LastButton.Start %>"><span class="icon-last ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerLast") %>"><span class="icon-last ewIcon"></span></a>
	<% End If %>
</div>
</div>
</div>
<span>&nbsp;<%= Language.Phrase("of") %>&nbsp;<%= sysadmin_list.Pager.PageCount %></span>
</div>
<div class="ewPager ewRec">
	<span><%= Language.Phrase("Record") %>&nbsp;<%= sysadmin_list.Pager.FromIndex %>&nbsp;<%= Language.Phrase("To") %>&nbsp;<%= sysadmin_list.Pager.ToIndex %>&nbsp;<%= Language.Phrase("Of") %>&nbsp;<%= sysadmin_list.Pager.RecordCount %></span>
</div>
<% End If %>
<% If sysadmin_list.TotalRecs > 0 Then %>
<div class="ewPager">
<input type="hidden" name="t" value="sysadmin">
<select name="<%= EW_TABLE_REC_PER_PAGE %>" class="form-control input-sm" onchange="this.form.submit();">
<option value="20"<% If sysadmin_list.DisplayRecs = 20 Then %> selected="selected"<% End If %>>20</option>
<option value="50"<% If sysadmin_list.DisplayRecs = 50 Then %> selected="selected"<% End If %>>50</option>
<option value="100"<% If sysadmin_list.DisplayRecs = 100 Then %> selected="selected"<% End If %>>100</option>
<option value="500"<% If sysadmin_list.DisplayRecs = 500 Then %> selected="selected"<% End If %>>500</option>
<option value="1000"<% If sysadmin_list.DisplayRecs = 1000 Then %> selected="selected"<% End If %>>1000</option>
<option value="ALL"<% If sysadmin.RecordsPerPage = -1 Then %> selected="selected"<% End If %>><%= Language.Phrase("AllRecords") %></option>
</select>
</div>
<% End If %>
</form>
<% End If %>
<div class="ewListOtherOptions">
<%
	sysadmin_list.AddEditOptions.Render "body", "", "", "", "", ""
	sysadmin_list.DetailOptions.Render "body", "", "", "", "", ""
	sysadmin_list.ActionOptions.Render "body", "", "", "", "", ""
%>
</div>
<div class="clearfix"></div>
</div>
<% End If %>
<form name="fsysadminlist" id="fsysadminlist" class="form-inline ewForm ewListForm" action="<%= ew_CurrentPage %>" method="post">
<% If sysadmin_list.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= sysadmin_list.Token %>">
<% End If %>
<input type="hidden" name="t" value="sysadmin">
<div id="gmp_sysadmin" class="<% If ew_IsResponsiveLayout() Then Response.Write "table-responsive " %>ewGridMiddlePanel">
<% If sysadmin_list.TotalRecs > 0 Or sysadmin.CurrentAction = "add" Or sysadmin.CurrentAction = "copy" Then %>
<table id="tbl_sysadminlist" class="table ewTable">
<%= sysadmin.TableCustomInnerHtml %>
<thead><!-- Table header -->
	<tr class="ewTableHeader">
<%

' Header row
sysadmin.RowType = EW_ROWTYPE_HEADER
Call sysadmin_list.RenderListOptions()

' Render list options (header, left)
sysadmin_list.ListOptions.Render "header", "left", "", "", "", ""
%>
<% If sysadmin.ID.Visible Then ' ID %>
	<% If sysadmin.SortUrl(sysadmin.ID) = "" Then %>
		<th data-name="ID"><div id="elh_sysadmin_ID" class="sysadmin_ID"><div class="ewTableHeaderCaption"><%= sysadmin.ID.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="ID"><div class="ewPointer" onclick="ew_Sort(event,'<%= sysadmin.SortUrl(sysadmin.ID) %>',1);"><div id="elh_sysadmin_ID" class="sysadmin_ID">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= sysadmin.ID.FldCaption %></span><span class="ewTableHeaderSort"><% If sysadmin.ID.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf sysadmin.ID.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If sysadmin.username.Visible Then ' username %>
	<% If sysadmin.SortUrl(sysadmin.username) = "" Then %>
		<th data-name="username"><div id="elh_sysadmin_username" class="sysadmin_username"><div class="ewTableHeaderCaption"><%= sysadmin.username.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="username"><div class="ewPointer" onclick="ew_Sort(event,'<%= sysadmin.SortUrl(sysadmin.username) %>',1);"><div id="elh_sysadmin_username" class="sysadmin_username">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= sysadmin.username.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If sysadmin.username.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf sysadmin.username.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If sysadmin.pswd.Visible Then ' pswd %>
	<% If sysadmin.SortUrl(sysadmin.pswd) = "" Then %>
		<th data-name="pswd"><div id="elh_sysadmin_pswd" class="sysadmin_pswd"><div class="ewTableHeaderCaption"><%= sysadmin.pswd.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="pswd"><div class="ewPointer" onclick="ew_Sort(event,'<%= sysadmin.SortUrl(sysadmin.pswd) %>',1);"><div id="elh_sysadmin_pswd" class="sysadmin_pswd">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= sysadmin.pswd.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If sysadmin.pswd.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf sysadmin.pswd.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If sysadmin.userrolelabel.Visible Then ' userrolelabel %>
	<% If sysadmin.SortUrl(sysadmin.userrolelabel) = "" Then %>
		<th data-name="userrolelabel"><div id="elh_sysadmin_userrolelabel" class="sysadmin_userrolelabel"><div class="ewTableHeaderCaption"><%= sysadmin.userrolelabel.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="userrolelabel"><div class="ewPointer" onclick="ew_Sort(event,'<%= sysadmin.SortUrl(sysadmin.userrolelabel) %>',1);"><div id="elh_sysadmin_userrolelabel" class="sysadmin_userrolelabel">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= sysadmin.userrolelabel.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If sysadmin.userrolelabel.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf sysadmin.userrolelabel.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If sysadmin.userrole.Visible Then ' userrole %>
	<% If sysadmin.SortUrl(sysadmin.userrole) = "" Then %>
		<th data-name="userrole"><div id="elh_sysadmin_userrole" class="sysadmin_userrole"><div class="ewTableHeaderCaption"><%= sysadmin.userrole.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="userrole"><div class="ewPointer" onclick="ew_Sort(event,'<%= sysadmin.SortUrl(sysadmin.userrole) %>',1);"><div id="elh_sysadmin_userrole" class="sysadmin_userrole">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= sysadmin.userrole.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If sysadmin.userrole.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf sysadmin.userrole.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<%

' Render list options (header, right)
sysadmin_list.ListOptions.Render "header", "right", "", "", "", ""
%>
	</tr>
</thead>
<tbody><!-- Table body -->
<%
	If sysadmin.CurrentAction = "add" Or sysadmin.CurrentAction = "copy" Then
		sysadmin_list.RowIndex = 0
		sysadmin_list.KeyCount = sysadmin_list.RowIndex
		If sysadmin.CurrentAction = "copy" Then
			If Not sysadmin_list.LoadRow() Then
				sysadmin.CurrentAction = "add"
			End If
		End If
		If sysadmin.CurrentAction = "add" Then
			Call sysadmin_list.LoadDefaultValues()
		End If
		If sysadmin.EventCancelled Then ' Insert failed
			Call sysadmin_list.RestoreFormValues() ' Restore form values
		End If

		' Set row properties
		Call sysadmin.ResetAttrs()
		sysadmin.RowAttrs.AddAttributes Array(Array("data-rowindex", 0), Array("id", "r0_sysadmin"), Array("data-rowtype", EW_ROWTYPE_ADD))
		sysadmin.RowType = EW_ROWTYPE_ADD

		' Render row
		Call sysadmin_list.RenderRow()

		' Render list options
		Call sysadmin_list.RenderListOptions()
		sysadmin_list.StartRowCnt = 0
%>
	<tr<%= sysadmin.RowAttributes %>>
<%

' Render list options (body, left)
sysadmin_list.ListOptions.Render "body", "left", sysadmin_list.RowCnt, "", "", ""
%>
	<% If sysadmin.ID.Visible Then ' ID %>
		<td data-name="ID">
<input type="hidden" data-field="x_ID" name="o<%= sysadmin_list.RowIndex %>_ID" id="o<%= sysadmin_list.RowIndex %>_ID" value="<%= Server.HTMLEncode(sysadmin.ID.OldValue&"") %>">
</td>
	<% End If %>
	<% If sysadmin.username.Visible Then ' username %>
		<td data-name="username">
<span id="el<%= sysadmin_list.RowCnt %>_sysadmin_username" class="form-group sysadmin_username">
<input type="text" data-field="x_username" name="x<%= sysadmin_list.RowIndex %>_username" id="x<%= sysadmin_list.RowIndex %>_username" size="30" maxlength="255" placeholder="<%= sysadmin.username.PlaceHolder %>" value="<%= sysadmin.username.EditValue %>"<%= sysadmin.username.EditAttributes %>>
</span>
<input type="hidden" data-field="x_username" name="o<%= sysadmin_list.RowIndex %>_username" id="o<%= sysadmin_list.RowIndex %>_username" value="<%= Server.HTMLEncode(sysadmin.username.OldValue&"") %>">
</td>
	<% End If %>
	<% If sysadmin.pswd.Visible Then ' pswd %>
		<td data-name="pswd">
<span id="el<%= sysadmin_list.RowCnt %>_sysadmin_pswd" class="form-group sysadmin_pswd">
<input type="text" data-field="x_pswd" name="x<%= sysadmin_list.RowIndex %>_pswd" id="x<%= sysadmin_list.RowIndex %>_pswd" size="30" maxlength="255" placeholder="<%= sysadmin.pswd.PlaceHolder %>" value="<%= sysadmin.pswd.EditValue %>"<%= sysadmin.pswd.EditAttributes %>>
</span>
<input type="hidden" data-field="x_pswd" name="o<%= sysadmin_list.RowIndex %>_pswd" id="o<%= sysadmin_list.RowIndex %>_pswd" value="<%= Server.HTMLEncode(sysadmin.pswd.OldValue&"") %>">
</td>
	<% End If %>
	<% If sysadmin.userrolelabel.Visible Then ' userrolelabel %>
		<td data-name="userrolelabel">
<span id="el<%= sysadmin_list.RowCnt %>_sysadmin_userrolelabel" class="form-group sysadmin_userrolelabel">
<input type="text" data-field="x_userrolelabel" name="x<%= sysadmin_list.RowIndex %>_userrolelabel" id="x<%= sysadmin_list.RowIndex %>_userrolelabel" size="30" maxlength="255" placeholder="<%= sysadmin.userrolelabel.PlaceHolder %>" value="<%= sysadmin.userrolelabel.EditValue %>"<%= sysadmin.userrolelabel.EditAttributes %>>
</span>
<input type="hidden" data-field="x_userrolelabel" name="o<%= sysadmin_list.RowIndex %>_userrolelabel" id="o<%= sysadmin_list.RowIndex %>_userrolelabel" value="<%= Server.HTMLEncode(sysadmin.userrolelabel.OldValue&"") %>">
</td>
	<% End If %>
	<% If sysadmin.userrole.Visible Then ' userrole %>
		<td data-name="userrole">
<span id="el<%= sysadmin_list.RowCnt %>_sysadmin_userrole" class="form-group sysadmin_userrole">
<input type="text" data-field="x_userrole" name="x<%= sysadmin_list.RowIndex %>_userrole" id="x<%= sysadmin_list.RowIndex %>_userrole" size="30" maxlength="255" placeholder="<%= sysadmin.userrole.PlaceHolder %>" value="<%= sysadmin.userrole.EditValue %>"<%= sysadmin.userrole.EditAttributes %>>
</span>
<input type="hidden" data-field="x_userrole" name="o<%= sysadmin_list.RowIndex %>_userrole" id="o<%= sysadmin_list.RowIndex %>_userrole" value="<%= Server.HTMLEncode(sysadmin.userrole.OldValue&"") %>">
</td>
	<% End If %>
<%

' Render list options (body, right)
sysadmin_list.ListOptions.Render "body", "right", sysadmin_list.RowCnt, "", "", ""
%>
<script type="text/javascript">
fsysadminlist.UpdateOpts(<%= sysadmin_list.RowIndex %>);
</script>
	</tr>
<%
End If
%>
<%
If (sysadmin.ExportAll And sysadmin.Export <> "") Then
	sysadmin_list.StopRec = sysadmin_list.TotalRecs
Else

	' Set the last record to display
	If sysadmin_list.TotalRecs > sysadmin_list.StartRec + sysadmin_list.DisplayRecs - 1 Then
		sysadmin_list.StopRec = sysadmin_list.StartRec + sysadmin_list.DisplayRecs - 1
	Else
		sysadmin_list.StopRec = sysadmin_list.TotalRecs
	End If
End If

' Restore number of post back records
If IsObject(ObjForm) And Not (ObjForm Is Nothing) Then
	ObjForm.Index = -1
	If ObjForm.HasValue(sysadmin_list.FormKeyCountName) And (sysadmin.CurrentAction = "gridadd" Or sysadmin.CurrentAction = "gridedit" Or sysadmin.CurrentAction = "F") Then
		sysadmin_list.KeyCount = CLng(ObjForm.GetValue(sysadmin_list.FormKeyCountName))
		sysadmin_list.StopRec = sysadmin_list.StartRec + sysadmin_list.KeyCount - 1
	End If
End If

' Move to first record
sysadmin_list.RecCnt = sysadmin_list.StartRec - 1
If Not sysadmin_list.Recordset.Eof Then
	sysadmin_list.Recordset.MoveFirst
	If sysadmin_list.StartRec > 1 Then sysadmin_list.Recordset.Move sysadmin_list.StartRec - 1
ElseIf Not sysadmin.AllowAddDeleteRow And sysadmin_list.StopRec = 0 Then
	sysadmin_list.StopRec = sysadmin.GridAddRowCount
End If

' Initialize Aggregate
sysadmin.RowType = EW_ROWTYPE_AGGREGATEINIT
Call sysadmin.ResetAttrs()
Call sysadmin_list.RenderRow()
sysadmin_list.RowCnt = 0
sysadmin_list.EditRowCnt = 0
If sysadmin.CurrentAction = "edit" Then sysadmin_list.RowIndex = 1
If sysadmin.CurrentAction = "gridadd" Then sysadmin_list.RowIndex = 0
If sysadmin.CurrentAction = "gridedit" Then sysadmin_list.RowIndex = 0

' Output date rows
Do While CLng(sysadmin_list.RecCnt) < CLng(sysadmin_list.StopRec)
	sysadmin_list.RecCnt = sysadmin_list.RecCnt + 1
	If CLng(sysadmin_list.RecCnt) >= CLng(sysadmin_list.StartRec) Then
		sysadmin_list.RowCnt = sysadmin_list.RowCnt + 1
		If sysadmin.CurrentAction = "gridadd" Or sysadmin.CurrentAction = "gridedit" Or sysadmin.CurrentAction = "F" Then
			sysadmin_list.RowIndex = sysadmin_list.RowIndex + 1
			ObjForm.Index = sysadmin_list.RowIndex
			If ObjForm.HasValue(sysadmin_list.FormActionName) Then
				sysadmin_list.RowAction = ObjForm.GetValue(sysadmin_list.FormActionName) & ""
			ElseIf sysadmin.CurrentAction = "gridadd" Then
				sysadmin_list.RowAction = "insert"
			Else
				sysadmin_list.RowAction = ""
			End If
		End If

	' Set up key count
	sysadmin_list.KeyCount = sysadmin_list.RowIndex
	Call sysadmin.ResetAttrs()
	sysadmin.CssClass = ""
	If sysadmin.CurrentAction = "gridadd" Then
		Call sysadmin_list.LoadDefaultValues() ' Load default values
	Else
		Call sysadmin_list.LoadRowValues(sysadmin_list.Recordset) ' Load row values
	End If
	sysadmin.RowType = EW_ROWTYPE_VIEW ' Render view
	If sysadmin.CurrentAction = "gridadd" Then ' Grid add
		sysadmin.RowType = EW_ROWTYPE_ADD ' Render add
	End If
	If sysadmin.CurrentAction = "gridadd" And sysadmin.EventCancelled Then ' Insert failed
		If Not ObjForm.HasValue("k_blankrow") Then
			Call sysadmin_list.RestoreCurrentRowFormValues(sysadmin_list.RowIndex) ' Restore form values
		End If
	End If
	If sysadmin.CurrentAction = "edit" Then
		If sysadmin_list.CheckInlineEditKey() And sysadmin_list.EditRowCnt = 0 Then ' Inline edit
			sysadmin.RowType = EW_ROWTYPE_EDIT ' Render edit
			If Not sysadmin.EventCancelled Then sysadmin_list.HashValue = sysadmin_list.GetRowHash(sysadmin_list.Recordset) ' Get hash value for record
		End If
	End If
	If sysadmin.CurrentAction = "gridedit" Then ' Grid edit
		If sysadmin.EventCancelled Then ' Update failed
			Call sysadmin_list.RestoreCurrentRowFormValues(sysadmin_list.RowIndex) ' Restore form values
		End If
		If sysadmin_list.RowAction = "insert" Then
			sysadmin.RowType = EW_ROWTYPE_ADD ' Render add
		Else
			sysadmin.RowType = EW_ROWTYPE_EDIT ' Render edit
		End If
			If Not sysadmin.EventCancelled Then sysadmin_list.HashValue = sysadmin_list.GetRowHash(sysadmin_list.Recordset) ' Get hash value for record
	End If
	If sysadmin.CurrentAction = "edit" And sysadmin.RowType = EW_ROWTYPE_EDIT And sysadmin.EventCancelled Then ' Update failed
		ObjForm.Index = 1 ' Set up index correctly
		Call sysadmin_list.RestoreFormValues() ' Restore form values
	End If
	If sysadmin.RowType = EW_ROWTYPE_EDIT Then ' Edit row
		sysadmin_list.EditRowCnt = sysadmin_list.EditRowCnt + 1
	End If

	' Set up row id / data-rowindex
	sysadmin.RowAttrs.AddAttributes Array(Array("data-rowindex", sysadmin_list.RowCnt), Array("id", "r" & sysadmin_list.RowCnt & "_sysadmin"), Array("data-rowtype", sysadmin.RowType))

	' Render row
	Call sysadmin_list.RenderRow()

	' Render list options
	Call sysadmin_list.RenderListOptions()

	' Skip delete row / empty row for confirm page
	If sysadmin_list.RowAction <> "delete" And sysadmin_list.RowAction <> "insertdelete" And Not (sysadmin_list.RowAction = "insert" And sysadmin.CurrentAction = "F" And sysadmin_list.EmptyRow()) Then
%>
	<tr<%= sysadmin.RowAttributes %>>
<%

' Render list options (body, left)
sysadmin_list.ListOptions.Render "body", "left", sysadmin_list.RowCnt, "", "", ""
%>
	<% If sysadmin.ID.Visible Then ' ID %>
		<td data-name="ID"<%= sysadmin.ID.CellAttributes %>>
<% If sysadmin.RowType = EW_ROWTYPE_ADD Then ' Add Record %>
<input type="hidden" data-field="x_ID" name="o<%= sysadmin_list.RowIndex %>_ID" id="o<%= sysadmin_list.RowIndex %>_ID" value="<%= Server.HTMLEncode(sysadmin.ID.OldValue&"") %>">
<% End If %>
<% If sysadmin.RowType = EW_ROWTYPE_EDIT Then ' Edit Record %>
<span id="el<%= sysadmin_list.RowCnt %>_sysadmin_ID" class="form-group sysadmin_ID">
<span<%= sysadmin.ID.ViewAttributes %>>
<p class="form-control-static"><%= sysadmin.ID.EditValue %></p>
</span>
</span>
<input type="hidden" data-field="x_ID" name="x<%= sysadmin_list.RowIndex %>_ID" id="x<%= sysadmin_list.RowIndex %>_ID" value="<%= Server.HTMLEncode(sysadmin.ID.CurrentValue&"") %>">
<% End If %>
<% If sysadmin.RowType = EW_ROWTYPE_VIEW Then ' View Record %>
<span<%= sysadmin.ID.ViewAttributes %>>
<%= sysadmin.ID.ListViewValue %>
</span>
<% End If %>
<a id="<%= sysadmin_list.PageObjName & "_row_" & sysadmin_list.RowCnt %>"></a></td>
	<% End If %>
	<% If sysadmin.username.Visible Then ' username %>
		<td data-name="username"<%= sysadmin.username.CellAttributes %>>
<% If sysadmin.RowType = EW_ROWTYPE_ADD Then ' Add Record %>
<span id="el<%= sysadmin_list.RowCnt %>_sysadmin_username" class="form-group sysadmin_username">
<input type="text" data-field="x_username" name="x<%= sysadmin_list.RowIndex %>_username" id="x<%= sysadmin_list.RowIndex %>_username" size="30" maxlength="255" placeholder="<%= sysadmin.username.PlaceHolder %>" value="<%= sysadmin.username.EditValue %>"<%= sysadmin.username.EditAttributes %>>
</span>
<input type="hidden" data-field="x_username" name="o<%= sysadmin_list.RowIndex %>_username" id="o<%= sysadmin_list.RowIndex %>_username" value="<%= Server.HTMLEncode(sysadmin.username.OldValue&"") %>">
<% End If %>
<% If sysadmin.RowType = EW_ROWTYPE_EDIT Then ' Edit Record %>
<span id="el<%= sysadmin_list.RowCnt %>_sysadmin_username" class="form-group sysadmin_username">
<input type="text" data-field="x_username" name="x<%= sysadmin_list.RowIndex %>_username" id="x<%= sysadmin_list.RowIndex %>_username" size="30" maxlength="255" placeholder="<%= sysadmin.username.PlaceHolder %>" value="<%= sysadmin.username.EditValue %>"<%= sysadmin.username.EditAttributes %>>
</span>
<% End If %>
<% If sysadmin.RowType = EW_ROWTYPE_VIEW Then ' View Record %>
<span<%= sysadmin.username.ViewAttributes %>>
<%= sysadmin.username.ListViewValue %>
</span>
<% End If %>
</td>
	<% End If %>
	<% If sysadmin.pswd.Visible Then ' pswd %>
		<td data-name="pswd"<%= sysadmin.pswd.CellAttributes %>>
<% If sysadmin.RowType = EW_ROWTYPE_ADD Then ' Add Record %>
<span id="el<%= sysadmin_list.RowCnt %>_sysadmin_pswd" class="form-group sysadmin_pswd">
<input type="text" data-field="x_pswd" name="x<%= sysadmin_list.RowIndex %>_pswd" id="x<%= sysadmin_list.RowIndex %>_pswd" size="30" maxlength="255" placeholder="<%= sysadmin.pswd.PlaceHolder %>" value="<%= sysadmin.pswd.EditValue %>"<%= sysadmin.pswd.EditAttributes %>>
</span>
<input type="hidden" data-field="x_pswd" name="o<%= sysadmin_list.RowIndex %>_pswd" id="o<%= sysadmin_list.RowIndex %>_pswd" value="<%= Server.HTMLEncode(sysadmin.pswd.OldValue&"") %>">
<% End If %>
<% If sysadmin.RowType = EW_ROWTYPE_EDIT Then ' Edit Record %>
<span id="el<%= sysadmin_list.RowCnt %>_sysadmin_pswd" class="form-group sysadmin_pswd">
<input type="text" data-field="x_pswd" name="x<%= sysadmin_list.RowIndex %>_pswd" id="x<%= sysadmin_list.RowIndex %>_pswd" size="30" maxlength="255" placeholder="<%= sysadmin.pswd.PlaceHolder %>" value="<%= sysadmin.pswd.EditValue %>"<%= sysadmin.pswd.EditAttributes %>>
</span>
<% End If %>
<% If sysadmin.RowType = EW_ROWTYPE_VIEW Then ' View Record %>
<span<%= sysadmin.pswd.ViewAttributes %>>
<%= sysadmin.pswd.ListViewValue %>
</span>
<% End If %>
</td>
	<% End If %>
	<% If sysadmin.userrolelabel.Visible Then ' userrolelabel %>
		<td data-name="userrolelabel"<%= sysadmin.userrolelabel.CellAttributes %>>
<% If sysadmin.RowType = EW_ROWTYPE_ADD Then ' Add Record %>
<span id="el<%= sysadmin_list.RowCnt %>_sysadmin_userrolelabel" class="form-group sysadmin_userrolelabel">
<input type="text" data-field="x_userrolelabel" name="x<%= sysadmin_list.RowIndex %>_userrolelabel" id="x<%= sysadmin_list.RowIndex %>_userrolelabel" size="30" maxlength="255" placeholder="<%= sysadmin.userrolelabel.PlaceHolder %>" value="<%= sysadmin.userrolelabel.EditValue %>"<%= sysadmin.userrolelabel.EditAttributes %>>
</span>
<input type="hidden" data-field="x_userrolelabel" name="o<%= sysadmin_list.RowIndex %>_userrolelabel" id="o<%= sysadmin_list.RowIndex %>_userrolelabel" value="<%= Server.HTMLEncode(sysadmin.userrolelabel.OldValue&"") %>">
<% End If %>
<% If sysadmin.RowType = EW_ROWTYPE_EDIT Then ' Edit Record %>
<span id="el<%= sysadmin_list.RowCnt %>_sysadmin_userrolelabel" class="form-group sysadmin_userrolelabel">
<input type="text" data-field="x_userrolelabel" name="x<%= sysadmin_list.RowIndex %>_userrolelabel" id="x<%= sysadmin_list.RowIndex %>_userrolelabel" size="30" maxlength="255" placeholder="<%= sysadmin.userrolelabel.PlaceHolder %>" value="<%= sysadmin.userrolelabel.EditValue %>"<%= sysadmin.userrolelabel.EditAttributes %>>
</span>
<% End If %>
<% If sysadmin.RowType = EW_ROWTYPE_VIEW Then ' View Record %>
<span<%= sysadmin.userrolelabel.ViewAttributes %>>
<%= sysadmin.userrolelabel.ListViewValue %>
</span>
<% End If %>
</td>
	<% End If %>
	<% If sysadmin.userrole.Visible Then ' userrole %>
		<td data-name="userrole"<%= sysadmin.userrole.CellAttributes %>>
<% If sysadmin.RowType = EW_ROWTYPE_ADD Then ' Add Record %>
<span id="el<%= sysadmin_list.RowCnt %>_sysadmin_userrole" class="form-group sysadmin_userrole">
<input type="text" data-field="x_userrole" name="x<%= sysadmin_list.RowIndex %>_userrole" id="x<%= sysadmin_list.RowIndex %>_userrole" size="30" maxlength="255" placeholder="<%= sysadmin.userrole.PlaceHolder %>" value="<%= sysadmin.userrole.EditValue %>"<%= sysadmin.userrole.EditAttributes %>>
</span>
<input type="hidden" data-field="x_userrole" name="o<%= sysadmin_list.RowIndex %>_userrole" id="o<%= sysadmin_list.RowIndex %>_userrole" value="<%= Server.HTMLEncode(sysadmin.userrole.OldValue&"") %>">
<% End If %>
<% If sysadmin.RowType = EW_ROWTYPE_EDIT Then ' Edit Record %>
<span id="el<%= sysadmin_list.RowCnt %>_sysadmin_userrole" class="form-group sysadmin_userrole">
<input type="text" data-field="x_userrole" name="x<%= sysadmin_list.RowIndex %>_userrole" id="x<%= sysadmin_list.RowIndex %>_userrole" size="30" maxlength="255" placeholder="<%= sysadmin.userrole.PlaceHolder %>" value="<%= sysadmin.userrole.EditValue %>"<%= sysadmin.userrole.EditAttributes %>>
</span>
<% End If %>
<% If sysadmin.RowType = EW_ROWTYPE_VIEW Then ' View Record %>
<span<%= sysadmin.userrole.ViewAttributes %>>
<%= sysadmin.userrole.ListViewValue %>
</span>
<% End If %>
</td>
	<% End If %>
<%

' Render list options (body, right)
sysadmin_list.ListOptions.Render "body", "right", sysadmin_list.RowCnt, "", "", ""
%>
	</tr>
<% If sysadmin.RowType = EW_ROWTYPE_ADD Or sysadmin.RowType = EW_ROWTYPE_EDIT Then %>
<script type="text/javascript">
fsysadminlist.UpdateOpts(<%= sysadmin_list.RowIndex %>);
</script>
<% End If %>
<%
	End If
	End If ' End delete row checking
	If sysadmin.CurrentAction <> "gridadd" Then
		If Not sysadmin_list.Recordset.Eof Then sysadmin_list.Recordset.MoveNext()
	End If
Loop
%>
<%
	If sysadmin.CurrentAction = "gridadd" Or sysadmin.CurrentAction = "gridedit" Then
		sysadmin_list.RowIndex = "$rowindex$"
		sysadmin_list.LoadDefaultValues()

		' Set row properties
		Call sysadmin.ResetAttrs()
		sysadmin.RowAttrs.AddAttributes Array(Array("data-rowindex", sysadmin_list.RowIndex), Array("id", "r0_sysadmin"), Array("data-rowtype", EW_ROWTYPE_ADD))
		sysadmin.RowAttrs.UpdateAttribute "class", "ewTemplate"
		sysadmin.RowType = EW_ROWTYPE_ADD

		' Render row
		Call sysadmin_list.RenderRow()

		' Render list options
		Call sysadmin_list.RenderListOptions()
		sysadmin_list.StartRowCnt = 0
%>
	<tr<%= sysadmin.RowAttributes %>>
<%

' Render list options (body, left)
sysadmin_list.ListOptions.Render "body", "left", sysadmin_list.RowIndex, "", "", ""
%>
	<% If sysadmin.ID.Visible Then ' ID %>
		<td data-name="ID">
<input type="hidden" data-field="x_ID" name="o<%= sysadmin_list.RowIndex %>_ID" id="o<%= sysadmin_list.RowIndex %>_ID" value="<%= Server.HTMLEncode(sysadmin.ID.OldValue&"") %>">
</td>
	<% End If %>
	<% If sysadmin.username.Visible Then ' username %>
		<td data-name="username">
<span id="el$rowindex$_sysadmin_username" class="form-group sysadmin_username">
<input type="text" data-field="x_username" name="x<%= sysadmin_list.RowIndex %>_username" id="x<%= sysadmin_list.RowIndex %>_username" size="30" maxlength="255" placeholder="<%= sysadmin.username.PlaceHolder %>" value="<%= sysadmin.username.EditValue %>"<%= sysadmin.username.EditAttributes %>>
</span>
<input type="hidden" data-field="x_username" name="o<%= sysadmin_list.RowIndex %>_username" id="o<%= sysadmin_list.RowIndex %>_username" value="<%= Server.HTMLEncode(sysadmin.username.OldValue&"") %>">
</td>
	<% End If %>
	<% If sysadmin.pswd.Visible Then ' pswd %>
		<td data-name="pswd">
<span id="el$rowindex$_sysadmin_pswd" class="form-group sysadmin_pswd">
<input type="text" data-field="x_pswd" name="x<%= sysadmin_list.RowIndex %>_pswd" id="x<%= sysadmin_list.RowIndex %>_pswd" size="30" maxlength="255" placeholder="<%= sysadmin.pswd.PlaceHolder %>" value="<%= sysadmin.pswd.EditValue %>"<%= sysadmin.pswd.EditAttributes %>>
</span>
<input type="hidden" data-field="x_pswd" name="o<%= sysadmin_list.RowIndex %>_pswd" id="o<%= sysadmin_list.RowIndex %>_pswd" value="<%= Server.HTMLEncode(sysadmin.pswd.OldValue&"") %>">
</td>
	<% End If %>
	<% If sysadmin.userrolelabel.Visible Then ' userrolelabel %>
		<td data-name="userrolelabel">
<span id="el$rowindex$_sysadmin_userrolelabel" class="form-group sysadmin_userrolelabel">
<input type="text" data-field="x_userrolelabel" name="x<%= sysadmin_list.RowIndex %>_userrolelabel" id="x<%= sysadmin_list.RowIndex %>_userrolelabel" size="30" maxlength="255" placeholder="<%= sysadmin.userrolelabel.PlaceHolder %>" value="<%= sysadmin.userrolelabel.EditValue %>"<%= sysadmin.userrolelabel.EditAttributes %>>
</span>
<input type="hidden" data-field="x_userrolelabel" name="o<%= sysadmin_list.RowIndex %>_userrolelabel" id="o<%= sysadmin_list.RowIndex %>_userrolelabel" value="<%= Server.HTMLEncode(sysadmin.userrolelabel.OldValue&"") %>">
</td>
	<% End If %>
	<% If sysadmin.userrole.Visible Then ' userrole %>
		<td data-name="userrole">
<span id="el$rowindex$_sysadmin_userrole" class="form-group sysadmin_userrole">
<input type="text" data-field="x_userrole" name="x<%= sysadmin_list.RowIndex %>_userrole" id="x<%= sysadmin_list.RowIndex %>_userrole" size="30" maxlength="255" placeholder="<%= sysadmin.userrole.PlaceHolder %>" value="<%= sysadmin.userrole.EditValue %>"<%= sysadmin.userrole.EditAttributes %>>
</span>
<input type="hidden" data-field="x_userrole" name="o<%= sysadmin_list.RowIndex %>_userrole" id="o<%= sysadmin_list.RowIndex %>_userrole" value="<%= Server.HTMLEncode(sysadmin.userrole.OldValue&"") %>">
</td>
	<% End If %>
<%

' Render list options (body, right)
sysadmin_list.ListOptions.Render "body", "right", sysadmin_list.RowCnt, "", "", ""
%>
<script type="text/javascript">
fsysadminlist.UpdateOpts(<%= sysadmin_list.RowIndex %>);
</script>
	</tr>
<%
End If
%>
</tbody>
</table>
<% End If %>
<% If sysadmin.CurrentAction = "add" Or sysadmin.CurrentAction = "copy" Then %>
<input type="hidden" name="<%= sysadmin_list.FormKeyCountName %>" id="<%= sysadmin_list.FormKeyCountName %>" value="<%= sysadmin_list.KeyCount %>">
<% End If %>
<% If sysadmin.CurrentAction = "gridadd" Then %>
<input type="hidden" name="a_list" id="a_list" value="gridinsert">
<input type="hidden" name="<%= sysadmin_list.FormKeyCountName %>" id="<%= sysadmin_list.FormKeyCountName %>" value="<%= sysadmin_list.KeyCount %>">
<%= sysadmin_list.MultiSelectKey %>
<% End If %>
<% If sysadmin.CurrentAction = "edit" Then %>
<input type="hidden" name="<%= sysadmin_list.FormKeyCountName %>" id="<%= sysadmin_list.FormKeyCountName %>" value="<%= sysadmin_list.KeyCount %>">
<% End If %>
<% If sysadmin.CurrentAction = "gridedit" Then %>
<% If sysadmin.UpdateConflict = "U" Then ' Record already updated by other user %>
<input type="hidden" name="a_list" id="a_list" value="gridoverwrite">
<% Else %>
<input type="hidden" name="a_list" id="a_list" value="gridupdate">
<% End If %>
<input type="hidden" name="<%= sysadmin_list.FormKeyCountName %>" id="<%= sysadmin_list.FormKeyCountName %>" value="<%= sysadmin_list.KeyCount %>">
<%= sysadmin_list.MultiSelectKey %>
<% End If %>
<% If sysadmin.CurrentAction = "" Then %>
<input type="hidden" name="a_list" id="a_list" value="">
<% End If %>
</div>
</form>
<%

' Close recordset and connection
sysadmin_list.Recordset.Close
Set sysadmin_list.Recordset = Nothing
%>
<% If sysadmin.Export = "" Then %>
<div class="ewGridLowerPanel">
<% If sysadmin.CurrentAction <> "gridadd" And sysadmin.CurrentAction <> "gridedit" Then %>
<form name="ewPagerForm" class="ewForm form-inline ewPagerForm" action="<%= ew_CurrentPage %>">
<% If Not IsObject(sysadmin_list.Pager) Then Set sysadmin_list.Pager = ew_NewPrevNextPager(sysadmin_list.StartRec, sysadmin_list.DisplayRecs, sysadmin_list.TotalRecs) %>
<% If sysadmin_list.Pager.RecordCount > 0 Then %>
<div class="ewPager">
<span><%= Language.Phrase("Page") %>&nbsp;</span>
<div class="ewPrevNext"><div class="input-group">
<div class="input-group-btn">
<!--first page button-->
	<% If sysadmin_list.Pager.FirstButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerFirst") %>" href="<%= sysadmin_list.PageUrl %>start=<%= sysadmin_list.Pager.FirstButton.Start %>"><span class="icon-first ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerFirst") %>"><span class="icon-first ewIcon"></span></a>
	<% End If %>
<!--previous page button-->
	<% If sysadmin_list.Pager.PrevButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerPrevious") %>" href="<%= sysadmin_list.PageUrl %>start=<%= sysadmin_list.Pager.PrevButton.Start %>"><span class="icon-prev ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerPrevious") %>"><span class="icon-prev ewIcon"></span></a>
	<% End If %>
</div>
<!--current page number-->
	<input class="form-control input-sm" type="text" name="<%= EW_TABLE_PAGE_NO %>" value="<%= sysadmin_list.Pager.CurrentPage %>">
<div class="input-group-btn">
<!--next page button-->
	<% If sysadmin_list.Pager.NextButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerNext") %>" href="<%= sysadmin_list.PageUrl %>start=<%= sysadmin_list.Pager.NextButton.Start %>"><span class="icon-next ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerNext") %>"><span class="icon-next ewIcon"></span></a>
	<% End If %>
<!--last page button-->
	<% If sysadmin_list.Pager.LastButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerLast") %>" href="<%= sysadmin_list.PageUrl %>start=<%= sysadmin_list.Pager.LastButton.Start %>"><span class="icon-last ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerLast") %>"><span class="icon-last ewIcon"></span></a>
	<% End If %>
</div>
</div>
</div>
<span>&nbsp;<%= Language.Phrase("of") %>&nbsp;<%= sysadmin_list.Pager.PageCount %></span>
</div>
<div class="ewPager ewRec">
	<span><%= Language.Phrase("Record") %>&nbsp;<%= sysadmin_list.Pager.FromIndex %>&nbsp;<%= Language.Phrase("To") %>&nbsp;<%= sysadmin_list.Pager.ToIndex %>&nbsp;<%= Language.Phrase("Of") %>&nbsp;<%= sysadmin_list.Pager.RecordCount %></span>
</div>
<% End If %>
<% If sysadmin_list.TotalRecs > 0 Then %>
<div class="ewPager">
<input type="hidden" name="t" value="sysadmin">
<select name="<%= EW_TABLE_REC_PER_PAGE %>" class="form-control input-sm" onchange="this.form.submit();">
<option value="20"<% If sysadmin_list.DisplayRecs = 20 Then %> selected="selected"<% End If %>>20</option>
<option value="50"<% If sysadmin_list.DisplayRecs = 50 Then %> selected="selected"<% End If %>>50</option>
<option value="100"<% If sysadmin_list.DisplayRecs = 100 Then %> selected="selected"<% End If %>>100</option>
<option value="500"<% If sysadmin_list.DisplayRecs = 500 Then %> selected="selected"<% End If %>>500</option>
<option value="1000"<% If sysadmin_list.DisplayRecs = 1000 Then %> selected="selected"<% End If %>>1000</option>
<option value="ALL"<% If sysadmin.RecordsPerPage = -1 Then %> selected="selected"<% End If %>><%= Language.Phrase("AllRecords") %></option>
</select>
</div>
<% End If %>
</form>
<% End If %>
<div class="ewListOtherOptions">
<%
	sysadmin_list.AddEditOptions.Render "body", "bottom", "", "", "", ""
	sysadmin_list.DetailOptions.Render "body", "bottom", "", "", "", ""
	sysadmin_list.ActionOptions.Render "body", "bottom", "", "", "", ""
%>
</div>
<div class="clearfix"></div>
</div>
<% End If %>
</div>
<% End If %>
<% If sysadmin_list.TotalRecs = 0 And sysadmin.CurrentAction = "" Then ' Show other options %>
<div class="ewListOtherOptions">
<%
	sysadmin_list.AddEditOptions.Render "body", "", "", "", "", ""
	sysadmin_list.DetailOptions.Render "body", "", "", "", "", ""
	sysadmin_list.ActionOptions.Render "body", "", "", "", "", ""
%>
</div>
<div class="clearfix"></div>
<% End If %>
<% If sysadmin.Export <> "" Then %>
<script type="text/javascript">
ew_ApplyTemplate("body", "", "sysadminlist", "<%= sysadmin.CustomExport %>");
</script>
<% End If %>
<% If sysadmin.Export = "" Then %>
<script type="text/javascript">
fsysadminlistsrch.Init();
fsysadminlist.Init();
</script>
<% End If %>
<%
sysadmin_list.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<% If sysadmin.Export = "" Then %>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<% End If %>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set sysadmin_list = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class csysadmin_list

	' Page ID
	Public Property Get PageID()
		PageID = "list"
	End Property

	' Project ID
	Public Property Get ProjectID()
		ProjectID = "{E9837C6B-C139-4DEF-A37B-491BE9913D3B}"
	End Property

	' Table Name
	Public Property Get TableName()
		TableName = "sysadmin"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "sysadmin_list"
	End Property

	' Grid form hidden field names
	Dim FormName
	Dim FormActionName
	Dim FormKeyName
	Dim FormOldKeyName
	Dim FormBlankRowName
	Dim FormKeyCountName

	' Page Name
	Public Property Get PageName()
		PageName = ew_CurrentPage()
	End Property

	' Page Url
	Public Property Get PageUrl()
		PageUrl = ew_CurrentPage() & "?"
		If sysadmin.UseTokenInUrl Then PageUrl = PageUrl & "t=" & sysadmin.TableVar & "&" ' add page token
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
		If sysadmin.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (sysadmin.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (sysadmin.TableVar = Request.QueryString("t"))
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

		' Grid form hidden field names
		FormName = "fsysadminlist"
		FormActionName = "k_action"
		FormKeyName = "k_key"
		FormOldKeyName = "k_oldkey"
		FormBlankRowName = "k_blankrow"
		FormKeyCountName = "key_count"

		' Check Token
		Token = ""
		CheckToken = EW_CHECK_TOKEN

		' Initialize language object
		If IsEmpty(Language) Then
			Set Language = New cLanguage
			Call Language.LoadPhrases()
		End If

		' Initialize table object
		If IsEmpty(sysadmin) Then Set sysadmin = New csysadmin
		Set Table = sysadmin
		ExportExcelCustom = False
		ExportWordCustom = False
		ExportPdfCustom = True ' Always use ew_ApplyTemplate
		ExportEmailCustom = True ' Always use ew_ApplyTemplate

		' Initialize urls
		ExportPrintUrl = PageUrl & "export=print"
		ExportExcelUrl = PageUrl & "export=excel"
		ExportWordUrl = PageUrl & "export=word"
		ExportHtmlUrl = PageUrl & "export=html"
		ExportXmlUrl = PageUrl & "export=xml"
		ExportCsvUrl = PageUrl & "export=csv"
		ExportPdfUrl = PageUrl & "export=pdf"
		AddUrl = "sysadminadd.asp"
		InlineAddUrl = PageUrl & "a=add"
		GridAddUrl = PageUrl & "a=gridadd"
		GridEditUrl = PageUrl & "a=gridedit"
		MultiDeleteUrl = "sysadmindelete.asp"
		MultiUpdateUrl = "sysadminupdate.asp"

		' Initialize form object
		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "list"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "sysadmin"

		' Open connection to the database
		If IsEmpty(Conn) Then Call ew_Connect()

		' List options
		Set ListOptions = New cListOptions
		ListOptions.TableVar = sysadmin.TableVar

		' Export options
		Set ExportOptions = New cListOptions
		ExportOptions.TableVar = sysadmin.TableVar
		ExportOptions.Tag = "div"
		ExportOptions.TagClassName = "ewExportOption"

		' Other options
		Set AddEditOptions = New cListOptions
		AddEditOptions.Tag = "div"
		AddEditOptions.TagClassName = "ewAddEditOption"
		Set DetailOptions = New cListOptions
		DetailOptions.Tag = "div"
		DetailOptions.TagClassName = "ewDetailOption"
		Set ActionOptions = New cListOptions
		ActionOptions.Tag = "div"
		ActionOptions.TagClassName = "ewActionOption"
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
		' Get export parameters

		Dim custom
		custom = ""
		If Request.QueryString("export").Count > 0 Then
			sysadmin.Export = Request.QueryString("export")
			custom = Request.QueryString("custom") & ""
		ElseIf ew_IsHttpPost() Then
			If Request.Form("export").Count > 0 Then
				sysadmin.Export = Request.Form("export")
				custom = Request.Form("custom") & ""
			ElseIf Request.Form("exporttype").Count > 0 Then
				sysadmin.Export = Request.Form("exporttype")
				custom = Request.Form("custom") & ""
			End If
		Else
			sysadmin.ExportReturnUrl = ew_CurrentUrl()
		End If
		gsExportFile = sysadmin.TableVar ' Get export file, used in header
		Dim Charset ' Charset used in header
		If EW_CHARSET <> "" Then
			Charset = ";charset=" & EW_CHARSET
		Else
			Charset = ""
		End If

		' Get custom export parameters
		If sysadmin.Export <> "" And custom <> "" Then
			sysadmin.CustomExport = sysadmin.Export
			sysadmin.Export = "print"
		End If
		gsCustomExport = sysadmin.CustomExport
		gsExport = sysadmin.Export ' Get export parameter, used in header

		' Custom export (post back from ew_ApplyTemplate), export and terminate page
		If Request.Form("customexport").Count > 0 Then
			sysadmin.CustomExport = Request.Form("customexport")
			sysadmin.Export = sysadmin.CustomExport
			Call Page_Terminate("")
			Response.End
		End If

		' Update Export URLs
		If ExportExcelCustom Then
			ExportExcelUrl = ExportExcelUrl & "&amp;custom=1"
		End If
		If ExportWordCustom Then
			ExportWordUrl = ExportWordUrl & "&amp;custom=1"
		End If
		If ExportPdfCustom Then
			ExportPdfUrl = ExportPdfUrl & "&amp;custom=1"
		End If
		If sysadmin.Export = "excel" Then
			Response.ContentType = "application/vnd.ms-excel" & Charset
			Response.AddHeader "Content-Disposition", "attachment; filename=" & gsExportFile & ".xls"
		End If
		If sysadmin.Export = "word" Then
			Response.ContentType = "application/vnd.ms-word" & Charset
			Response.AddHeader "Content-Disposition", "attachment; filename=" & gsExportFile & ".doc"
		End If
		If sysadmin.Export = "csv" Then
			Response.BinaryWrite ChrB(239) & ChrB(187) & ChrB(191)
			Response.ContentType = "application/csv" & Charset
			Response.AddHeader "Content-Disposition", "attachment; filename=" & gsExportFile & ".csv"
		End If
		sysadmin.CurrentAction = ew_IIf(Request.QueryString("a").Count > 0, Request.QueryString("a") & "", ObjForm.GetValue("a_list") & "") ' Set up current action

		' Get grid add count
		Dim gridaddcnt
		gridaddcnt = Request.QueryString(EW_TABLE_GRID_ADD_ROW_COUNT)
		If IsNumeric(gridaddcnt) Then
			If gridaddcnt > 0 Then
				sysadmin.GridAddRowCount = gridaddcnt
			End If
		End If

		' Set up list options
		SetupListOptions()

		' Setup export options
		SetupExportOptions()
		sysadmin.ID.Visible = Not sysadmin.IsAdd() And Not sysadmin.IsCopy() And Not sysadmin.IsGridAdd()

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
			results = sysadmin.GetAutoFill(Request.Form("name"), Request.Form("q"))
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

		' Setup other options
		SetupOtherOptions()

		' Set "checkbox" visible
		If UBound(sysadmin.CustomActions.CustomArray) >= 0 Then
			ListOptions.GetItem("checkbox").Visible = True
		End If
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
		If Not sysadmin Is Nothing Then
			If sysadmin.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = sysadmin.TableVar
				If sysadmin.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf sysadmin.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf sysadmin.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf sysadmin.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set sysadmin = Nothing
		Set ListOptions = Nothing
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

	Dim ListOptions ' List options
	Dim ExportOptions ' Export options
	Dim SearchOptions ' Search options
	Dim AddEditOptions ' Other options (add edit)
	Dim DetailOptions ' Other options (detail)
	Dim ActionOptions ' Other options (action)
	Dim DisplayRecs ' Number of display records
	Dim StartRec, StopRec, TotalRecs, RecRange
	Dim DefaultSearchWhere ' Default search WHERE clause
	Dim SearchWhere
	Dim RecCnt
	Dim EditRowCnt
	Dim StartRowCnt
	Dim RowCnt, RowIndex
	Dim Attrs
	Dim RecPerRow
	Dim MultiColumnClass
	Dim MultiColumnEditClass
	Dim MultiColumnCnt
	Dim MultiColumnEditCnt
	Dim GridCnt
	Dim ColCnt
	Dim KeyCount
	Dim RowAction
	Dim RowOldKey ' Row old key (for copy)
	Dim DbMasterFilter, DbDetailFilter
	Dim MasterRecordExists
	Dim MultiSelectKey
	Dim Command
	Dim RestoreSearch

	Public HashValue ' Hash Value
	Dim Recordset, OldRecordset

	' -----------------------------------------------------------------
	' Page main processing
	'
	Sub Page_Main()
		DisplayRecs = 20
		RecRange = 10
		RecCnt = 0 ' Record count
		KeyCount = 0 ' Key count
		StartRowCnt = 1

		' Search filters
		Dim sSrchAdvanced, sSrchBasic, sFilter
		sSrchAdvanced = "" ' Advanced search filter
		sSrchBasic = "" ' Basic search filter
		SearchWhere = "" ' Search where clause
		DefaultSearchWhere = ""
		sFilter = ""

		' Restore search
		RestoreSearch = False

		' Get command
		Command = LCase(Request.QueryString("cmd")&"")

		' Master/Detail
		DbMasterFilter = "" ' Master filter
		DbDetailFilter = "" ' Detail filter
		If IsPageRequest Then ' Validate request

			' Process custom action first
			ProcessCustomAction()

			' Set up records per page dynamically
			SetUpDisplayRecs()

			' Handle reset command
			ResetCmd()

			' Set up Breadcrumb
			If sysadmin.Export = "" Then
				SetupBreadcrumb()
			End If

			' Check QueryString parameters
			If Request.QueryString("a").Count > 0 Then
				sysadmin.CurrentAction = Request.QueryString("a")

				' Clear inline mode
				If sysadmin.CurrentAction = "cancel" Then
					ClearInlineMode()
				End If

				' Switch to grid edit mode
				If sysadmin.CurrentAction = "gridedit" Then
					GridEditMode()
				End If

				' Switch to inline edit mode
				If sysadmin.CurrentAction = "edit" Then
					InlineEditMode()
				End If

				' Switch to inline add mode
				If sysadmin.CurrentAction = "add" Or sysadmin.CurrentAction = "copy" Then
					InlineAddMode()
				End If

				' Switch to grid add mode
				If sysadmin.CurrentAction = "gridadd" Then
					GridAddMode()
				End If
			Else
				If ObjForm.GetValue("a_list")&"" <> "" Then
					sysadmin.CurrentAction = ObjForm.GetValue("a_list") ' Get action

					' Grid Update
					Dim bGridUpdate
					If (sysadmin.CurrentAction = "gridupdate" Or sysadmin.CurrentAction = "gridoverwrite") And Session(EW_SESSION_INLINE_MODE) = "gridedit" Then
						If ValidateGridForm() Then
							bGridUpdate = GridUpdate()
						Else
							bGridUpdate = False
							FailureMessage = gsFormError
						End If
						If Not bGridUpdate Then
							sysadmin.EventCancelled = True
							sysadmin.CurrentAction = "gridedit" ' Stay in Grid Edit mode
						End If
					End If

					' Inline Update
					If (sysadmin.CurrentAction = "update" Or sysadmin.CurrentAction = "overwrite") And Session(EW_SESSION_INLINE_MODE) = "edit" Then
						InlineUpdate()
					End If

					' Insert Inline
					If sysadmin.CurrentAction = "insert" And Session(EW_SESSION_INLINE_MODE) = "add" Then
						InlineInsert()
					End If

					' Grid Insert
					Dim bGridInsert
					If sysadmin.CurrentAction = "gridinsert" And Session(EW_SESSION_INLINE_MODE) = "gridadd" Then
						If ValidateGridForm() Then
							bGridInsert = GridInsert()
						Else
							bGridInsert = False
							FailureMessage = gsFormError
						End If
						If Not bGridInsert Then
							sysadmin.EventCancelled = True
							sysadmin.CurrentAction = "gridadd" ' Stay in Grid Add mode
						End If
					End If
				End If
			End If

			' Hide list options
			If sysadmin.Export <> "" Then
				Call ListOptions.HideAllOptions(Array("sequence"))
				ListOptions.UseDropDownButton = False ' Disable drop down button
				ListOptions.UseButtonGroup = False ' Disable button group
			ElseIf sysadmin.CurrentAction = "gridadd" Or sysadmin.CurrentAction = "gridedit" Then
				Call ListOptions.HideAllOptions(Array())
				ListOptions.UseDropDownButton = False ' Disable drop down button
				ListOptions.UseButtonGroup = False ' Disable button group
			End If

			' Hide export options
			If sysadmin.Export <> "" Or sysadmin.CurrentAction <> "" Then
				ExportOptions.HideAllOptions(Array())
			End If

			' Hide other options
			If sysadmin.Export <> "" Then
				AddEditOptions.HideAllOptions(Array())
				DetailOptions.HideAllOptions(Array())
				ActionOptions.HideAllOptions(Array())
			End If

			' Show grid delete link for grid add / grid edit
			If sysadmin.AllowAddDeleteRow Then
				If sysadmin.CurrentAction = "gridadd" Or sysadmin.CurrentAction = "gridedit" Then
					ListOptions.GetItem("griddelete").Visible = True
				End If
			End If

			' Get default search criteria
			Call ew_AddFilter(DefaultSearchWhere, BasicSearchWhere(True))
			Call ew_AddFilter(DefaultSearchWhere, AdvancedSearchWhere(True))

			' Get basic search values
			Call LoadBasicSearchValues()

			' Get and validate search values for advanced search
			Call LoadSearchValues() ' Get search values
			If Not ValidateSearch() Then
				FailureMessage = gsSearchError
			End If

			' Restore search parms from Session if not searching / reset / export
			If (sysadmin.Export <> "" Or Command <> "search" And Command <> "reset" And Command <> "resetall") And CheckSearchParms() Then
				Call RestoreSearchParms()
			End If

			' Call Recordset SearchValidated event
			Call sysadmin.Recordset_SearchValidated()

			' Set Up Sorting Order
			SetUpSortOrder()

			' Get basic search criteria
			If gsSearchError = "" Then
				sSrchBasic = BasicSearchWhere(False)
			End If

			' Get search criteria for advanced search
			If gsSearchError = "" Then
				sSrchAdvanced = AdvancedSearchWhere(False)
			End If
		End If ' End Validate Request

		' Restore display records
		If sysadmin.RecordsPerPage <> "" Then
			DisplayRecs = sysadmin.RecordsPerPage ' Restore from Session
		Else
			DisplayRecs = 20 ' Load default
		End If

		' Load Sorting Order
		LoadSortOrder()

		' Load search default if no existing search criteria
		If Not CheckSearchParms() Then

			' Load basic search from default
			sysadmin.BasicSearch.Keyword = sysadmin.BasicSearch.KeywordDefault
			sysadmin.BasicSearch.SearchType = sysadmin.BasicSearch.SearchTypeDefault
			sysadmin.BasicSearch.setSearchType(sysadmin.BasicSearch.SearchTypeDefault)
			If sysadmin.BasicSearch.Keyword <> "" Then
				sSrchBasic = BasicSearchWhere(False)
			End If

			' Load advanced search from default
			If LoadAdvancedSearchDefault() Then
				sSrchAdvanced = AdvancedSearchWhere(False)
			End If
		End If

		' Build search criteria
		Call ew_AddFilter(SearchWhere, sSrchAdvanced)
		Call ew_AddFilter(SearchWhere, sSrchBasic)

		' Call Recordset Searching event
		Call sysadmin.Recordset_Searching(SearchWhere)

		' Save search criteria
		If Command = "search" And Not RestoreSearch Then
			sysadmin.SearchWhere = SearchWhere ' Save to Session
			StartRec = 1 ' Reset start record counter
			sysadmin.StartRecordNumber = StartRec
		Else
			SearchWhere = sysadmin.SearchWhere
		End If
		sFilter = ""
		Call ew_AddFilter(sFilter, DbDetailFilter)
		Call ew_AddFilter(sFilter, SearchWhere)

		' Set up filter in Session
		sysadmin.SessionWhere = sFilter
		sysadmin.CurrentFilter = ""

		' Export Data only
		If sysadmin.CustomExport = "" And ew_InArray(sysadmin.Export, Array("html","word","excel","xml","csv","email","pdf")) Then
			ExportData()
			Call Page_Terminate("") ' Terminate response
			Response.End
		End If

		' Load record count first
		Set Recordset = LoadRecordset()
		TotalRecs = Recordset.RecordCount

		' Search options
		SetupSearchOptions()
	End Sub

	' -----------------------------------------------------------------
	' Set up number of records displayed per page
	'
	Sub SetUpDisplayRecs()
		Dim sWrk
		sWrk = Request.QueryString(EW_TABLE_REC_PER_PAGE)
		If sWrk <> "" Then
			If IsNumeric(sWrk) Then
				DisplayRecs = CInt(sWrk)
			Else
				If LCase(sWrk) = "all" Then ' Display all records
					DisplayRecs = -1
				Else
					DisplayRecs = 20 ' Non-numeric, load default
				End If
			End If
			sysadmin.RecordsPerPage = DisplayRecs ' Save to Session

			' Reset start position
			StartRec = 1
			sysadmin.StartRecordNumber = StartRec
		End If
	End Sub

	' -----------------------------------------------------------------
	'  Exit out of inline mode
	'
	Sub ClearInlineMode()
		Call sysadmin.SetKey("ID", "") ' Clear inline edit key
		sysadmin.LastAction = sysadmin.CurrentAction ' Save last action
		sysadmin.CurrentAction = "" ' Clear action
		Session(EW_SESSION_INLINE_MODE) = "" ' Clear inline mode
	End Sub

	' -----------------------------------------------------------------
	' Switch to Grid Add Mode
	'
	Sub GridAddMode()
		Session(EW_SESSION_INLINE_MODE) = "gridadd" ' Enabled grid add
	End Sub

	' -----------------------------------------------------------------
	' Switch to Grid Edit Mode
	'
	Sub GridEditMode()
		Session(EW_SESSION_INLINE_MODE) = "gridedit" ' Enabled grid edit
	End Sub

	' -----------------------------------------------------------------
	' Switch to Inline Edit Mode
	'
	Sub InlineEditMode()
		Dim bInlineEdit
		bInlineEdit = True
		If Request.QueryString("ID").Count > 0 Then
			sysadmin.ID.QueryStringValue = Request.QueryString("ID")
		Else
			bInlineEdit = False
		End If
		If bInlineEdit Then
			If LoadRow() Then
				Call sysadmin.SetKey("ID", sysadmin.ID.CurrentValue) ' Set up inline edit key
				Session(EW_SESSION_INLINE_MODE) = "edit" ' Enabled inline edit
			End If
		End If
	End Sub

	' -----------------------------------------------------------------
	' Peform update to inline edit record
	'
	Sub InlineUpdate()
		Dim bInlineUpdate
		ObjForm.Index = 1
		Call LoadFormValues() ' Get form values

		' Validate Form
		If Not ValidateForm() Then
			bInlineUpdate = False ' Form error, reset action
			FailureMessage = gsFormError
		Else

			' Overwrite record, just reload hash value
			If sysadmin.CurrentAction = "overwrite" Then
				Call LoadRowHash()
			End If
			bInlineUpdate = False
			If CheckInlineEditKey() Then ' Check key
				sysadmin.SendEmail = True ' Send email on update success
				bInlineUpdate = EditRow() ' Update record
			Else
				bInlineUpdate = False
			End If
		End If
		If bInlineUpdate Then ' Update success
			If SuccessMessage = "" Then SuccessMessage = Language.Phrase("UpdateSuccess") ' Set success message
			Call ClearInlineMode() ' Clear inline edit mode
		Else
			If FailureMessage = "" Then
				FailureMessage = Language.Phrase("UpdateFailed") ' Set update failed message
			End If
			sysadmin.EventCancelled = True ' Cancel event
			sysadmin.CurrentAction = "edit" ' Stay in edit mode
		End If
	End Sub

	' -----------------------------------------------------------------
	' Check inline edit key
	'
	Function CheckInlineEditKey()
		CheckInlineEditKey = True
		If sysadmin.GetKey("ID")&"" <> sysadmin.ID.CurrentValue & "" Then
			CheckInlineEditKey = False
			Exit Function
		End If
	End Function

	' -----------------------------------------------------------------
	' Switch to Inline Add Mode
	'
	Sub InlineAddMode()
		If sysadmin.CurrentAction = "copy" Then
			If Request.QueryString("ID").Count > 0 Then
				sysadmin.ID.QueryStringValue = Request.QueryString("ID")
				Call sysadmin.SetKey("ID", sysadmin.ID.CurrentValue) ' Set up key
			Else
				sysadmin.CurrentAction = "add"
				Call sysadmin.SetKey("ID", "") ' Clear key
			End If
		End If
		Session(EW_SESSION_INLINE_MODE) = "add" ' Enabled inline add
	End Sub

	' -----------------------------------------------------------------
	' Peform update to inline add/copy record
	'
	Sub InlineInsert()
		Call LoadOldRecord() ' Load old recordset
		ObjForm.Index = 0
		Call LoadFormValues() ' Get form values

		' Validate Form
		If Not ValidateForm() Then
			FailureMessage = gsFormError ' Set validation error message
			sysadmin.EventCancelled = True ' Set event cancelled
			sysadmin.CurrentAction = "add" ' Stay in add mode
			Exit Sub
		End If
		sysadmin.SendEmail = True ' Send email on add success
		If AddRow(OldRecordset) Then ' Add record
			If SuccessMessage = "" Then SuccessMessage = Language.Phrase("AddSuccess") ' Set add success message
			Call ClearInlineMode() ' Clear inline add mode
		Else ' Add failed
			sysadmin.EventCancelled = True ' Set event cancelled
			sysadmin.CurrentAction = "add" ' Stay in add mode
		End If
	End Sub

	' -----------------------------------------------------------------
	' Peform update to grid
	'
	Function GridUpdate()
		Dim rowindex
		Dim bGridUpdate
		Dim sKey, sThisKey
		Dim Rs, RsOld, RsNew, sSql
		rowindex = 1
		bGridUpdate = True

		' Get old recordset
		sysadmin.CurrentFilter  = BuildKeyFilter()
		sSql = sysadmin.SQL
		Set Rs = Server.CreateObject("ADODB.Recordset")
		Rs.CursorLocation = EW_CURSORLOCATION
		Rs.Open sSql, Conn, 1, EW_RECORDSET_LOCKTYPE
		Set RsOld = ew_CloneRs(Rs)

		' Call Grid Updating event
		If Not sysadmin.Grid_Updating(RsOld) Then
			If FailureMessage = "" Then
				FailureMessage = Language.Phrase("GridEditCancelled") ' Set grid edit cancelled message
			End If
			GridUpdate = False
			Exit Function
		End If

		' Begin transaction
		Conn.BeginTrans
		sKey = ""

		' Update row index and get row key
		Dim rowcnt
		ObjForm.Index = -1
		rowcnt = ObjForm.GetValue(FormKeyCountName)
		If rowcnt = "" Or Not IsNumeric(rowcnt) Then
			rowcnt = 0
		End If

		' Update all rows based on key
		Dim rowkey, rowaction
		For rowindex = 1 to rowcnt
			ObjForm.Index = rowindex
			rowkey = ObjForm.GetValue(FormKeyName) & ""
			rowaction = ObjForm.GetValue(FormActionName) & ""

			' Load all values & keys
			If rowaction <> "insertdelete" Then ' Skip insert then deleted rows
				Call LoadFormValues() ' Get form values
				If rowaction = "" Or rowaction = "edit" Or rowaction = "delete" Then
					bGridUpdate = SetupKeyValues(rowkey) ' Set up key values
				Else
					bGridUpdate = True
				End If

				' Skip empty row
				If rowaction = "insert" And EmptyRow() Then

					' No action required
				' Validate form and insert/update/delete record

				ElseIf bGridUpdate Then
					If rowaction = "delete" Then
						sysadmin.CurrentFilter = sysadmin.KeyFilter
						bGridUpdate = DeleteRows() ' Delete this row
					ElseIf Not ValidateForm() Then
						bGridUpdate = False ' Form error, reset action
						FailureMessage = gsFormError
					Else
						If rowaction = "insert" Then
							bGridUpdate = AddRow(Null) ' Insert this row
						Else
							If rowkey <> "" Then

								' Overwrite record, just reload hash value
								If sysadmin.CurrentAction = "gridoverwrite" Then
									Call LoadRowHash()
								End If
								sysadmin.SendEmail = False ' Do not send email on update success
								bGridUpdate = EditRow() ' Update this row
							End If
						End If ' End update
					End If
				End If
				If bGridUpdate Then
					If sKey <> "" Then sKey = sKey & ", "
					sKey = sKey & rowkey
				Else
					Exit For
				End If
			End If
		Next
		If bGridUpdate Then
			Conn.CommitTrans ' Commit transaction

			' Get new recordset
			Set Rs = Conn.Execute(sSql)
			Set RsNew = ew_CloneRs(Rs)

			' Call Grid_Updated event
			Call sysadmin.Grid_Updated(RsOld, RsNew)
			If SuccessMessage = "" Then SuccessMessage = Language.Phrase("UpdateSuccess") ' Set update success message
			Call ClearInlineMode() ' Clear inline edit mode
		Else
			Conn.RollbackTrans ' Rollback transaction
			If FailureMessage = "" Then
				FailureMessage = Language.Phrase("UpdateFailed") ' Set update failed message
			End If
		End If
		Set Rs = Nothing
		Set RsOld = Nothing
		Set RsNew = Nothing
		GridUpdate = bGridUpdate
	End Function

	' -----------------------------------------------------------------
	'  Build filter for all keys
	'
	Function BuildKeyFilter()
		Dim rowindex, sThisKey
		Dim sKey
		Dim sWrkFilter, sFilter
		sWrkFilter = ""

		' Update row index and get row key
		rowindex = 1
		ObjForm.Index = rowindex
		sThisKey = ObjForm.GetValue("k_key") & ""
		Do While (sThisKey <> "")
			If SetupKeyValues(sThisKey) Then
				sFilter = sysadmin.KeyFilter
				If sWrkFilter <> "" Then sWrkFilter = sWrkFilter & " OR "
				sWrkFilter = sWrkFilter & sFilter
			Else
				sWrkFilter = "0=1"
				Exit Do
			End If

			' Update row index and get row key
			rowindex = rowindex + 1 ' Next row
			ObjForm.Index = rowindex
			sThisKey = ObjForm.GetValue("k_key") & ""
		Loop
		BuildKeyFilter = sWrkFilter
	End Function

	' -----------------------------------------------------------------
	' Set up key values
	'
	Function SetupKeyValues(key)
		Dim arrKeyFlds
		arrKeyFlds = Split(key&"", EW_COMPOSITE_KEY_SEPARATOR)
		If UBound(arrKeyFlds) >= 0 Then
			sysadmin.ID.FormValue = arrKeyFlds(0)
			If Not IsNumeric(sysadmin.ID.FormValue) Then
				SetupKeyValues = False
				Exit Function
			End If
		End If
		SetupKeyValues = True
	End Function

	' Grid Insert
	' Peform insert to grid
	Function GridInsert()
		Dim addcnt
		Dim rowindex, rowcnt
		Dim bGridInsert
		Dim sSql, sWrkFilter, sFilter, sKey, sThisKey
		Dim Rs, RsNew
		rowindex = 1
		bGridInsert = False

		' Call Grid_Inserting event
		If Not sysadmin.Grid_Inserting() Then
			If FailureMessage = "" Then
				FailureMessage = Language.Phrase("GridAddCancelled") ' Set grid add cancelled message
			End If
			GridInsert = False
			Exit Function
		End If

		' Begin transaction
		Conn.BeginTrans

		' Init key filter
		sWrkFilter = ""
		addcnt = 0
		sKey = ""

		' Get row count
		ObjForm.Index = -1
		rowcnt = ObjForm.GetValue(FormKeyCountName) & ""
		If rowcnt = "" Or Not IsNumeric(rowcnt) Then rowcnt = 0

		' Insert all rows
		For rowindex = 1 to rowcnt

			' Load current row values
			ObjForm.Index = rowindex
			Dim rowaction
			rowaction = ObjForm.GetValue(FormActionName) & ""
			If rowaction = "" Or rowaction = "insert" Then
				Call LoadFormValues() ' Get form values
				If Not EmptyRow() Then
					addcnt = addcnt + 1
					sysadmin.SendEmail = False ' Do not send email on insert success

					' Validate Form
					If Not ValidateForm() Then
						bGridInsert = False ' Form error, reset action
						FailureMessage = gsFormError
					Else
						bGridInsert = AddRow(Null) ' Insert this row
					End If
					If bGridInsert Then
						If sKey <> "" Then sKey = sKey & EW_COMPOSITE_KEY_SEPARATOR
						sKey = sKey & sysadmin.ID.CurrentValue

						' Add filter for this record
						sFilter = sysadmin.KeyFilter
						If sWrkFilter <> "" Then sWrkFilter = sWrkFilter & " OR "
						sWrkFilter = sWrkFilter & sFilter
					Else
						Exit For
					End If
				End If
			End If
		Next
		If addcnt = 0 Then ' No record inserted
			FailureMessage = Language.Phrase("NoAddRecord")
			bGridInsert = False
		End If
		If bGridInsert Then
			Conn.CommitTrans ' Commit transaction

			' Get new recordset
			sysadmin.CurrentFilter  = sWrkFilter
			sSql = sysadmin.SQL
			Set Rs = Conn.Execute(sSql)
			Set RsNew = ew_CloneRs(Rs)

			' Call Grid_Inserted event
			Call sysadmin.Grid_Inserted(RsNew)
			If SuccessMessage = "" Then SuccessMessage = Language.Phrase("InsertSuccess") ' Set insert success message
			Call ClearInlineMode() ' Clear grid add mode
		Else
			Conn.RollbackTrans ' Rollback transaction
			If FailureMessage = "" Then
				FailureMessage = Language.Phrase("InsertFailed") ' Set insert failed message
			End If
		End If
		Set Rs = Nothing
		Set RsNew = Nothing
		GridInsert = bGridInsert
	End Function

	' Check if empty row
	Function EmptyRow()
		EmptyRow = True
		If Not ObjForm Is Nothing Then
			If EmptyRow And ObjForm.HasValue("x_username") And ObjForm.HasValue("o_username") Then EmptyRow = (sysadmin.username.CurrentValue&"" = sysadmin.username.OldValue&"")
			If EmptyRow And ObjForm.HasValue("x_pswd") And ObjForm.HasValue("o_pswd") Then EmptyRow = (sysadmin.pswd.CurrentValue&"" = sysadmin.pswd.OldValue&"")
			If EmptyRow And ObjForm.HasValue("x_userrolelabel") And ObjForm.HasValue("o_userrolelabel") Then EmptyRow = (sysadmin.userrolelabel.CurrentValue&"" = sysadmin.userrolelabel.OldValue&"")
			If EmptyRow And ObjForm.HasValue("x_userrole") And ObjForm.HasValue("o_userrole") Then EmptyRow = (sysadmin.userrole.CurrentValue&"" = sysadmin.userrole.OldValue&"")
		End If
	End Function

	' Validate grid form
	Function ValidateGridForm()
		Dim rowindex, rowcnt, rowaction

		' Get row count
		ObjForm.Index = -1
		rowcnt = ObjForm.GetValue(FormKeyCountName) & ""
		If rowcnt = "" Or Not IsNumeric(rowcnt) Then
			rowcnt = 0
		End If

		' Validate all records
		ValidateGridForm = True
		For rowindex = 1 to rowcnt

			' Load current row values
			ObjForm.Index = rowindex
			rowaction = ObjForm.GetValue(FormActionName) & ""
			If rowaction <> "delete" And rowaction <> "insertdelete" Then
				LoadFormValues() ' Get form values
				If rowaction = "insert" And EmptyRow() Then

					' Ignore
				ElseIf Not ValidateForm() Then
					ValidateGridForm = False
					Exit For
				End If
			End If
		Next
	End Function

	' Get all form values of the grid
	Function GetGridFormValues()
		Dim rowindex, rowcnt, rowaction
		Dim rows, row

		' Get row count
		ObjForm.Index = -1
		rowcnt = ObjForm.GetValue(FormKeyCountName) & ""
		If rowcnt = "" Or Not IsNumeric(rowcnt) Then
			rowcnt = 0
		End If

		' Loop through all records
		For rowindex = 1 to rowcnt

			' Load current row values
			ObjForm.Index = rowindex
			rowaction = ObjForm.GetValue(FormActionName) & ""
			If rowaction <> "delete" And rowaction <> "insertdelete" Then
				LoadFormValues() ' Get form values
				If rowaction = "insert" And EmptyRow() Then

					' Ignore
				Else
					Dim i, fld
					If IsArray(sysadmin.Fields) Then
						Set row = New cCustomArray
						For i = 0 to UBound(sysadmin.Fields,2)
							Set fld = sysadmin.Fields(1,i)
							row.Add fld.FldName, fld.FormValue
						Next
						If IsArray(rows) Then
							ReDim Preserve rows(UBound(rows)+1)
						Else
							ReDim rows(0)
						End If
						Set rows(UBound(rows)) = row
					End If
				End If
			End If
		Next
		GetGridFormValues = rows ' Return as array of cCustomArray
	End Function

	' Restore form values for current row
	Sub RestoreCurrentRowFormValues(idx)

		' Get row based on current index
		ObjForm.Index = idx
		Call LoadFormValues() ' Load form values
	End Sub

	' Return Advanced Search Where based on QueryString parameters
	Function AdvancedSearchWhere(Default)
		Dim sWhere
		sWhere = ""

		' Field ID
		Call BuildSearchSql(sWhere, sysadmin.ID, Default, False)

		' Field username
		Call BuildSearchSql(sWhere, sysadmin.username, Default, False)

		' Field pswd
		Call BuildSearchSql(sWhere, sysadmin.pswd, Default, False)

		' Field userrolelabel
		Call BuildSearchSql(sWhere, sysadmin.userrolelabel, Default, False)

		' Field userrole
		Call BuildSearchSql(sWhere, sysadmin.userrole, Default, False)
		AdvancedSearchWhere = sWhere

		' Set up search parm
		If Not Default And sWhere <> "" Then
			Command = "search"
		End If
		If Not Default And Command = "search" Then
			Call sysadmin.ID.AdvancedSearch.Save() ' ID
			Call sysadmin.username.AdvancedSearch.Save() ' username
			Call sysadmin.pswd.AdvancedSearch.Save() ' pswd
			Call sysadmin.userrolelabel.AdvancedSearch.Save() ' userrolelabel
			Call sysadmin.userrole.AdvancedSearch.Save() ' userrole
		End If
	End Function

	' Build search sql
	Sub BuildSearchSql(Where, Fld, Default, MultiValue)
		Dim FldParm, FldVal, FldOpr, FldCond, FldVal2, FldOpr2
		FldParm = Mid(Fld.FldVar, 3)
		FldVal = ew_IIf(Default, Fld.AdvancedSearch.SearchValueDefault, Fld.AdvancedSearch.SearchValue)
		FldOpr = ew_IIf(Default, Fld.AdvancedSearch.SearchOperatorDefault, Fld.AdvancedSearch.SearchOperator)
		FldCond = ew_IIf(Default, Fld.AdvancedSearch.SearchConditionDefault, Fld.AdvancedSearch.SearchCondition)
		FldVal2 = ew_IIf(Default, Fld.AdvancedSearch.SearchValue2Default, Fld.AdvancedSearch.SearchValue2)
		FldOpr2 = ew_IIf(Default, Fld.AdvancedSearch.SearchOperator2Default, Fld.AdvancedSearch.SearchOperator2)
		Dim sWrk
		sWrk = ""
		FldOpr = UCase(Trim(FldOpr))
		If (FldOpr = "") Then FldOpr = "="
		FldOpr2 = UCase(Trim(FldOpr2))
		If FldOpr2 = "" Then FldOpr2 = "="
		If EW_SEARCH_MULTI_VALUE_OPTION = 1 Then MultiValue = False
		If FldOpr <> "LIKE" Then MultiValue = False
		If FldOpr2 <> "LIKE" And FldVal2 <> "" Then MultiValue = False
		If MultiValue Then
			Dim sWrk1, sWrk2

			' Field value 1
			If FldVal <> "" Then
				sWrk1 = ew_GetMultiSearchSql(Fld, FldOpr, FldVal)
			Else
				sWrk1 = ""
			End If

			' Field value 2
			If FldVal2 <> "" And FldCond <> "" Then
				sWrk2 = ew_GetMultiSearchSql(Fld, FldOpr2, FldVal2)
			Else
				sWrk2 = ""
			End If

			' Build final SQL
			sWrk = sWrk1
			If sWrk2 <> "" Then
				If sWrk <> "" Then
					sWrk = "(" & sWrk & ") " & FldCond & " (" & sWrk2 & ")"
				Else
					sWrk = sWrk2
				End If
			End If
		Else
			FldVal = ConvertSearchValue(Fld, FldVal)
			FldVal2 = ConvertSearchValue(Fld, FldVal2)
			sWrk = ew_GetSearchSql(Fld, FldVal, FldOpr, FldCond, FldVal2, FldOpr2)
		End If
		Call ew_AddFilter(Where, sWrk)
	End Sub

	' Convert search value
	Function ConvertSearchValue(Fld, FldVal)
		If FldVal = EW_NULL_VALUE Or FldVal = EW_NOT_NULL_VALUE Then
			ConvertSearchValue = FldVal
		Else
			ConvertSearchValue = FldVal
			If Fld.FldDataType = EW_DATATYPE_BOOLEAN Then
				If FldVal <> "" Then ConvertSearchValue = ew_IIf(FldVal&"" = "1", "True", "False")
			ElseIf Fld.FldDataType = EW_DATATYPE_DATE Then
				If FldVal <> "" Then ConvertSearchValue = ew_UnFormatDateTime(FldVal, Fld.FldDateTimeFormat)
			End If
		End If
	End Function

	' -----------------------------------------------------------------
	' Return Basic Search sql
	'
	Function BasicSearchSQL(arKeywords, typ)
		Dim sWhere
		sWhere = ""
			Call BuildBasicSearchSQL(sWhere, sysadmin.username, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, sysadmin.pswd, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, sysadmin.userrolelabel, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, sysadmin.userrole, arKeywords, typ)
		BasicSearchSQL = sWhere
	End Function

	' -----------------------------------------------------------------
	' Build basic search sql
	'
	Sub BuildBasicSearchSql(Where, Fld, arKeywords, typ)
		Dim sDefcond, sCond, arSQL, arCond, cnt, i, j, ar
		Dim Keyword, sWrk, sFldExpression, bQuoted, sSql
		sDefCond = ew_IIf(typ = "OR", "OR", "AND")
		sCond = sDefCond
		arSQL = Array() ' Array for SQL parts
		arCond = Array() ' Array for search conditions
		cnt = UBound(arKeywords)+1
		j = 0 ' Number of SQL parts
		For i = 0 to cnt-1
			Keyword = arKeywords(i)
			Keyword = Trim(Keyword)
			If EW_BASIC_SEARCH_IGNORE_PATTERN <> "" Then
				Keyword = ew_RegExReplace(EW_BASIC_SEARCH_IGNORE_PATTERN, "\", Keyword)
				ar = Split(Keyword, "\")
			Else
				ar = Array(Keyword)
			End If
			For Each Keyword In ar
				If Keyword <> "" Then
					sWrk = ""
					If Keyword = "OR" And typ = "" Then
						If j > 0 Then
							arCond(j-1) = "OR"
						End If
					ElseIf Keyword = EW_NULL_VALUE Then
						sWrk = Fld.FldExpression & " IS NULL"
					ElseIf Keyword = EW_NOT_NULL_VALUE Then
						sWrk = Fld.FldExpression & " IS NOT NULL"
					ElseIf Fld.FldDataType <> EW_DATATYPE_NUMBER Or IsNumeric(Keyword) Then
						sFldExpression = ew_IIf(Fld.FldVirtualExpression <> Fld.FldExpression, Fld.FldVirtualExpression, Fld.FldBasicSearchExpression)
						sWrk = sFldExpression & ew_Like(ew_QuotedValue("%" & Keyword & "%", EW_DATATYPE_STRING))
					End If
					If sWrk <> "" Then
						If j > 0 Then
							ReDim Preserve arSQL(j)
							ReDim Preserve arCond(j)
						Else
							ReDim arSQL(0)
							ReDim arCond(0)
						End If
						arSQL(j) = sWrk
						arCond(j) = sDefCond
						j = j + 1
					End If
				End If
			Next
		Next
		cnt = UBound(arSQL)+1
		bQuoted = False
		sSql = ""
		If cnt > 0 Then
			For i = 0 to cnt-2
				If arCond(i) = "OR" Then
					If Not bQuoted Then sSql = sSql & "("
					bQuoted = True
				End If
				sSql = sSql & arSQL(i)
				If bQuoted And arCond(i) <> "OR" Then
					sSql = sSql & ")"
					bQuoted = False
				End If
				sSql = sSql & " " & arCond(i) & " "
			Next
			sSql = sSql & arSQL(cnt-1)
			If bQuoted Then
				sSql = sSql & ")"
			End If
		End If
		If sSql <> "" Then
			If Where <> "" Then Where = Where & " OR "
			Where =  Where & "(" & sSql & ")"
		End If
	End Sub

	' -----------------------------------------------------------------
	' Return Basic Search Where based on search keyword and type
	'
	Function BasicSearchWhere(Default)
		Dim sSearchStr, sSearchKeyword, sSearchType
		Dim sSearch, arKeyword, sKeyword, ar, Match, Matches, p, str
		sSearchStr = ""
		sSearchKeyword = ew_IIf(Default, sysadmin.BasicSearch.KeywordDefault, sysadmin.BasicSearch.Keyword)
		sSearchType = ew_IIf(Default, sysadmin.BasicSearch.SearchTypeDefault, sysadmin.BasicSearch.SearchType)
		If sSearchKeyword <> "" Then
			sSearch = Trim(sSearchKeyword)
			If sSearchType <> "=" Then

				' Match quoted keywords (i.e.: "...")
				If ew_RegExMatch("""([^""]*)""", sSearch, Matches) Then
					For Each Match in Matches
						p = InStr(sSearch, Match.SubMatches(0))
						str = Mid(sSearch, 1, p-2)
						sSearch = Mid(sSearch, p + Len(Match.SubMatches(0)) + 1)
						If Len(Trim(str)) > 0 Then
							ar = ew_ArrayMerge(ar, Split(Trim(str), " "))
						End If
						ar = ew_ArrayMerge(ar, Array(Match.SubMatches(0))) ' Save quoted keyword
					Next
				End If

				' Match individual keywords
				If Len(Trim(sSearch)) > 0 Then
					ar = ew_ArrayMerge(ar, Split(Trim(sSearch), " "))
				End If
				sSearchStr = BasicSearchSQL(ar, sSearchType)
			Else
				sSearchStr = BasicSearchSQL(Array(sSearch), sSearchType)
			End If
			If Not Default Then Command = "search"
		End If
		If Not Default And Command = "search" Then
			sysadmin.BasicSearch.setKeyword(sSearchKeyword)
			sysadmin.BasicSearch.setSearchType(sSearchType)
		End If
		BasicSearchWhere = sSearchStr
	End Function

	' Check if search parm exists
	Function CheckSearchParms()

		' Check basic search
		If sysadmin.BasicSearch.IssetSession() Then
			CheckSearchParms = True
			Exit Function
		End If
		If sysadmin.ID.AdvancedSearch.IssetSession() Then
			CheckSearchParms = True
			Exit Function
		End If
		If sysadmin.username.AdvancedSearch.IssetSession() Then
			CheckSearchParms = True
			Exit Function
		End If
		If sysadmin.pswd.AdvancedSearch.IssetSession() Then
			CheckSearchParms = True
			Exit Function
		End If
		If sysadmin.userrolelabel.AdvancedSearch.IssetSession() Then
			CheckSearchParms = True
			Exit Function
		End If
		If sysadmin.userrole.AdvancedSearch.IssetSession() Then
			CheckSearchParms = True
			Exit Function
		End If
		CheckSearchParms = False
	End Function

	' Clear all search parameters
	Sub ResetSearchParms()

		' Clear search where
		SearchWhere = ""
		sysadmin.SearchWhere = SearchWhere

		' Clear basic search parameters
		Call ResetBasicSearchParms()

		' Clear advanced search parameters
		Call ResetAdvancedSearchParms()
	End Sub

	' Load advanced search default values
	Function LoadAdvancedSearchDefault()
		LoadAdvancedSearchDefault = False
	End Function

	' Clear all basic search parameters
	Sub ResetBasicSearchParms()
		sysadmin.BasicSearch.UnsetSession()
	End Sub

	' -----------------------------------------------------------------
	' Clear all advanced search parameters
	'
	Sub ResetAdvancedSearchParms()

		' Clear advanced search parameters
		Call sysadmin.ID.AdvancedSearch.UnsetSession()
		Call sysadmin.username.AdvancedSearch.UnsetSession()
		Call sysadmin.pswd.AdvancedSearch.UnsetSession()
		Call sysadmin.userrolelabel.AdvancedSearch.UnsetSession()
		Call sysadmin.userrole.AdvancedSearch.UnsetSession()
	End Sub

	' -----------------------------------------------------------------
	' Restore all search parameters
	'
	Sub RestoreSearchParms()

		' Restore search flag
		RestoreSearch = True

		' Restore basic search values
		Call sysadmin.BasicSearch.Load()

		' Restore advanced search values
		Call sysadmin.ID.AdvancedSearch.Load()
		Call sysadmin.username.AdvancedSearch.Load()
		Call sysadmin.pswd.AdvancedSearch.Load()
		Call sysadmin.userrolelabel.AdvancedSearch.Load()
		Call sysadmin.userrole.AdvancedSearch.Load()
	End Sub

	' -----------------------------------------------------------------
	' Set up Sort parameters based on Sort Links clicked
	'
	Sub SetUpSortOrder()
		Dim sOrderBy
		Dim sSortField, sLastSort, sThisSort
		Dim bCtrl

		' Check for an Order parameter
		If Request.QueryString("order").Count > 0 Then
			sysadmin.CurrentOrder = Request.QueryString("order")
			sysadmin.CurrentOrderType = Request.QueryString("ordertype")

			' Field ID
			Call sysadmin.UpdateSort(sysadmin.ID)

			' Field username
			Call sysadmin.UpdateSort(sysadmin.username)

			' Field pswd
			Call sysadmin.UpdateSort(sysadmin.pswd)

			' Field userrolelabel
			Call sysadmin.UpdateSort(sysadmin.userrolelabel)

			' Field userrole
			Call sysadmin.UpdateSort(sysadmin.userrole)
			sysadmin.StartRecordNumber = 1 ' Reset start position
		End If
	End Sub

	' -----------------------------------------------------------------
	' Load Sort Order parameters
	'
	Sub LoadSortOrder()
		Dim sOrderBy
		sOrderBy = sysadmin.SessionOrderBy ' Get order by from Session
		If sOrderBy = "" Then
			If sysadmin.SqlOrderBy <> "" Then
				sOrderBy = sysadmin.SqlOrderBy
				sysadmin.SessionOrderBy = sOrderBy
			End If
		End If
	End Sub

	' -----------------------------------------------------------------
	' Reset command based on querystring parameter cmd=
	' - RESET: reset search parameters
	' - RESETALL: reset search & master/detail parameters
	' - RESETSORT: reset sort parameters
	'
	Sub ResetCmd()

		' Check if reset command
		If Left(Command,5) = "reset" Then

			' Reset search criteria
			If Command = "reset" Or Command = "resetall" Then
				Call ResetSearchParms()
			End If

			' Reset Sort Criteria
			If Command = "resetsort" Then
				Dim sOrderBy
				sOrderBy = ""
				sysadmin.SessionOrderBy = sOrderBy
				sysadmin.ID.Sort = ""
				sysadmin.username.Sort = ""
				sysadmin.pswd.Sort = ""
				sysadmin.userrolelabel.Sort = ""
				sysadmin.userrole.Sort = ""
			End If

			' Reset start position
			StartRec = 1
			sysadmin.StartRecordNumber = StartRec
		End If
	End Sub

	' Set up list options
	Sub SetupListOptions()
		Dim item

		' Grid delete
		If sysadmin.AllowAddDeleteRow Then
			ListOptions.Add("griddelete")
			Set item = ListOptions.GetItem("griddelete")
			item.CssStyle = "white-space: nowrap;"
			item.OnLeft = True
			item.Visible = False ' Default hidden
		End If

		' Add group option item
		ListOptions.Add(ListOptions.GroupOptionName)
		Set item = ListOptions.GetItem(ListOptions.GroupOptionName)
		item.Body = ""
		item.OnLeft = True
		item.Visible = False

		' View
		ListOptions.Add("view")
		Set item = ListOptions.GetItem("view")
		item.CssStyle = "white-space: nowrap;"
		item.Visible = True
		item.OnLeft = True

		' Edit
		ListOptions.Add("edit")
		Set item = ListOptions.GetItem("edit")
		item.CssStyle = "white-space: nowrap;"
		item.Visible = True
		item.OnLeft = True

		' Copy
		ListOptions.Add("copy")
		Set item = ListOptions.GetItem("copy")
		item.CssStyle = "white-space: nowrap;"
		item.Visible = True
		item.OnLeft = True

		' Checkbox
		ListOptions.Add("checkbox")
		Set item = ListOptions.GetItem("checkbox")
		item.Visible = (True Or True)
		item.OnLeft = True
		item.Header = "<input type=""checkbox"" name=""key"" id=""key"" onclick=""ew_SelectAllKey(this);"">"
		item.MoveTo(0) ' Move to first column
		item.ShowInDropDown = False
		item.ShowInButtonGroup = False

		' Drop down button for ListOptions
		ListOptions.UseImageAndText = True
		ListOptions.UseDropDownButton = False
		ListOptions.DropDownButtonPhrase = Language.Phrase("ButtonListOptions")
		ListOptions.UseButtonGroup = False
		If ListOptions.UseButtonGroup And ew_IsMobile() Then
			ListOptions.UseDropDownButton = True
		End If
		ListOptions.ButtonClass = "btn-sm" ' Class for button group
		Call ListOptions_Load()
		Call SetupListOptionsExt()

		' Set up group item visibility
		ListOptions.GetItem(ListOptions.GroupOptionName).Visible = ListOptions.GroupOptionVisible
	End Sub

	' Render list options
	Sub RenderListOptions()
		Dim item, links
		ListOptions.LoadDefault()

		' Set up row action and key
		If IsNumeric(RowIndex) And sysadmin.CurrentMode <> "view" Then
			Dim ActionName, OldKeyName, KeyName, BlankRowName
			ObjForm.Index = RowIndex
			ActionName = Replace(FormActionName, "k_", "k" & RowIndex & "_")
			OldKeyName = Replace(FormOldKeyName, "k_", "k" & RowIndex & "_")
			KeyName = Replace(FormKeyName, "k_", "k" & RowIndex & "_")
			BlankRowName = Replace(FormBlankRowName, "k_", "k" & RowIndex & "_")
			If RowAction <> "" Then
				MultiSelectKey = MultiSelectKey & "<input type=""hidden"" name=""" & ActionName & """ id=""" & ActionName & """ value=""" & RowAction & """>"
			End If
			If RowAction = "delete" Then
				Dim sKey
				sKey = ObjForm.GetValue(FormKeyName) & ""
				Call SetupKeyValues(sKey)
			End If
			If RowAction = "insert" And sysadmin.CurrentAction = "F" And EmptyRow() Then
				MultiSelectKey = MultiSelectKey & "<input type=""hidden"" name=""" & BlankRowName & """ id=""" & BlankRowName & """ value=""1"">"
			End If
		End If

		' Grid delete
		If sysadmin.AllowAddDeleteRow Then
			If sysadmin.CurrentAction = "gridadd" Or sysadmin.CurrentAction = "gridedit" Then
				ListOptions.UseButtonGroup = True ' Use button group for grid delete button
				ListOptions.UseImageAndText = True ' Use image and text for grid delete button
				Set item = ListOptions.GetItem("griddelete")
				item.Body = "<a class=""ewGridLink ewGridDelete"" title=""" & ew_HtmlTitle(Language.Phrase("DeleteLink")) & """ data-caption=""" & ew_HtmlTitle(Language.Phrase("DeleteLink")) & """ href=""javascript:void(0);"" onclick=""ew_DeleteGridRow(this, " & RowIndex & ");"">" & Language.Phrase("DeleteLink") & "</a>"
			End If
		End If
		If (sysadmin.CurrentAction = "add" Or sysadmin.CurrentAction = "copy") And sysadmin.RowType = EW_ROWTYPE_ADD Then ' Inline Add / Copy
			ListOptions.CustomItem = "copy" ' Show copy column only
			Set item = ListOptions.GetItem("copy")
			item.Body = "<div" & ew_IIf(item.OnLeft, " style=""text-align: right""", "") & ">" & _
				"<a class=""ewGridLink ewInlineInsert"" title=""" & ew_HtmlTitle(Language.Phrase("InsertLink")) & """ data-caption=""" & ew_HtmlTitle(Language.Phrase("InsertLink")) & """ href="""" onclick=""return ewForms(this).Submit();"">" & Language.Phrase("InsertLink") & "</a>&nbsp;" & _
				"<a class=""ewGridLink ewInlineCancel"" title=""" & ew_HtmlTitle(Language.Phrase("CancelLink")) & """ data-caption=""" & ew_HtmlTitle(Language.Phrase("CancelLink")) & """ href=""" & PageUrl & "a=cancel"">" & Language.Phrase("CancelLink") & "</a>" & _
				"<input type=""hidden"" name=""a_list"" id=""a_list"" value=""insert""></div>"
			Exit Sub
		End If
		If sysadmin.CurrentAction = "edit" And sysadmin.RowType = EW_ROWTYPE_EDIT Then ' Inline Edit
			ListOptions.CustomItem = "edit" ' Show edit column only
			Set item = ListOptions.GetItem("edit")
			If sysadmin.UpdateConflict = "U" Then
				item.Body = "<div" & ew_IIf(item.OnLeft, " style=""text-align: right""", "") & ">" & _
					"<a class=""ewGridLink ewInlineReload"" title=""" & ew_HtmlTitle(Language.Phrase("ReloadLink")) & """ data-caption=""" & ew_HtmlTitle(Language.Phrase("ReloadLink")) & """ href=""" & ew_HtmlEncode(ew_GetHashUrl(InlineEditUrl, PageObjName & "_row_" & RowCnt)) & """>" & Language.Phrase("ReloadLink") & "</a>&nbsp;" & _
					"<a class=""ewGridLink ewInlineOverwrite"" title=""" & ew_HtmlTitle(Language.Phrase("OverwriteLink")) & """ data-caption=""" & ew_HtmlTitle(Language.Phrase("OverwriteLink")) & """ href="""" onclick=""return ewForms(this).Submit('" & ew_GetHashUrl(PageName, PageObjName & "_row_" & RowCnt) & "');"">" & Language.Phrase("OverwriteLink") & "</a>&nbsp;" & _
					"<a class=""ewGridLink ewInlineCancel"" title=""" & ew_HtmlTitle(Language.Phrase("ConflictCancelLink")) & """ data-caption=""" & ew_HtmlTitle(Language.Phrase("ConflictCancelLink")) & """ href=""" & PageUrl & "a=cancel"">" & Language.Phrase("ConflictCancelLink") & "</a>" & _
					"<input type=""hidden"" name=""a_list"" id=""a_list"" value=""overwrite""></div>"
			Else
				item.Body = "<div" & ew_IIf(item.OnLeft, " style=""text-align: right""", "") & ">" & _
					"<a class=""ewGridLink ewInlineUpdate"" title=""" & ew_HtmlTitle(Language.Phrase("UpdateLink")) & """ data-caption=""" & ew_HtmlTitle(Language.Phrase("UpdateLink")) & """ href="""" onclick=""return ewForms(this).Submit('" & ew_GetHashUrl(PageName, PageObjName & "_row_" & RowCnt) & "');"">" & Language.Phrase("UpdateLink") & "</a>&nbsp;" & _
					"<a class=""ewGridLink ewInlineCancel"" title=""" & ew_HtmlTitle(Language.Phrase("CancelLink")) & """ data-caption=""" & ew_HtmlTitle(Language.Phrase("CancelLink")) & """ href=""" & PageUrl & "a=cancel"">" & Language.Phrase("CancelLink") & "</a>" & _
					"<input type=""hidden"" name=""a_list"" id=""a_list"" value=""update""></div>"
			End If
			item.Body = item.Body & _
				"<input type=""hidden"" name=""k" & RowIndex & "_hash"" id=""k" & RowIndex & "_hash"" value=""" & HashValue & """>"
			item.Body = item.Body & "<input type=""hidden"" name=""k" & RowIndex & "_key"" id=""k" & RowIndex & "_key"" value=""" & ew_HtmlEncode(sysadmin.ID.CurrentValue) & """>"
			Exit Sub
		End If
		If True Then
			ListOptions.GetItem("view").Body = "<a class=""ewRowLink ewView"" title=""" & ew_HtmlTitle(Language.Phrase("ViewLink")) & """ data-caption=""" & ew_HtmlTitle(Language.Phrase("ViewLink")) & """ href=""" & ew_HtmlEncode(ViewUrl) & """>" & Language.Phrase("ViewLink") & "</a>"
		Else
			ListOptions.GetItem("view").Body = ""
		End If
		Set item = ListOptions.GetItem("edit")
		If True Then
			item.Body = "<a class=""ewRowLink ewEdit"" title=""" & ew_HtmlTitle(Language.Phrase("EditLink")) & """ data-caption=""" & ew_HtmlTitle(Language.Phrase("EditLink")) & """ href=""" & ew_HtmlEncode(EditUrl) & """>" & Language.Phrase("EditLink") & "</a>"
			item.Body = item.Body & "<a class=""ewRowLink ewInlineEdit"" title=""" & ew_HtmlTitle(Language.Phrase("InlineEditLink")) & """ data-caption=""" & ew_HtmlTitle(Language.Phrase("InlineEditLink")) & """ href=""" & ew_HtmlEncode(ew_GetHashUrl(InlineEditUrl, PageObjName & "_row_" & RowCnt)) & """>" & Language.Phrase("InlineEditLink") & "</a>"
		Else
			item.Body = ""
		End If
		Set item = ListOptions.GetItem("copy")
		If True Then
			item.Body = item.Body & "<a class=""ewRowLink ewInlineCopy"" title=""" & ew_HtmlTitle(Language.Phrase("InlineCopyLink")) & """ data-caption=""" & ew_HtmlTitle(Language.Phrase("InlineCopyLink")) & """ href=""" & ew_HtmlEncode(InlineCopyUrl) & """>" & Language.Phrase("InlineCopyLink") & "</a>"
		Else
			item.Body = ""
		End If
		ListOptions.GetItem("checkbox").Body = "<input type=""checkbox"" name=""key_m"" value=""" & ew_HtmlEncode(sysadmin.ID.CurrentValue) & """ onclick='ew_ClickMultiCheckbox(event, this);'>"
		If sysadmin.CurrentAction = "gridedit" And RowIndex <> "" And IsNumeric(RowIndex) Then
			MultiSelectKey = MultiSelectKey & "<input type=""hidden"" name=""" & KeyName & """ id=""" & KeyName & """ value=""" & sysadmin.ID.CurrentValue & """>"
			MultiSelectKey = MultiSelectKey & "<input type=""hidden"" name=""k" & RowIndex & "_hash"" id=""k" & RowIndex & "_hash"" value=""" & HashValue  & """>"
		End If
		Call RenderListOptionsExt()
		Call ListOptions_Rendered()
	End Sub

	' Set up other options
	Sub SetupOtherOptions()
		Dim opt, item, DetailTableLink, ar, i
		Set opt = AddEditOptions

		' Inline Add
		Call opt.Add("inlineadd")
		Set item = opt.GetItem("inlineadd")
		item.Body = "<a class=""ewAddEdit ewInlineAdd"" title=""" & ew_HtmlTitle(Language.Phrase("InlineAddLink")) & """ data-caption=""" & ew_HtmlTitle(Language.Phrase("InlineAddLink")) & """ href=""" & ew_HtmlEncode(InlineAddUrl) & """>" & Language.Phrase("InlineAddLink") & "</a>"
		item.Visible = (InlineAddUrl <> "")
		Call opt.Add("gridadd")
		Set item = opt.GetItem("gridadd")
		item.Body = "<a class=""ewAddEdit ewGridAdd"" title=""" & ew_HtmlTitle(Language.Phrase("GridAddLink")) & """ data-caption=""" & ew_HtmlTitle(Language.Phrase("GridAddLink")) & """ href=""" & ew_HtmlEncode(GridAddUrl) & """>" & Language.Phrase("GridAddLink") & "</a>"
		item.Visible = (GridAddUrl <> "")

		' Add grid edit
		Set opt = AddEditOptions
		Call opt.Add("gridedit")
		Set item = opt.GetItem("gridedit")
		item.Body = "<a class=""ewAddEdit ewGridEdit"" title=""" & ew_HtmlTitle(Language.Phrase("GridEditLink")) & """ data-caption=""" & ew_HtmlTitle(Language.Phrase("GridEditLink")) & """ href=""" & ew_HtmlEncode(GridEditUrl) & """>" & Language.Phrase("GridEditLink") & "</a>"
		item.Visible = (GridEditUrl <> "")
		Set opt = ActionOptions

		' Add multi delete
		Call opt.Add("multidelete")
		Set item = opt.GetItem("multidelete")
		item.Body = "<a class=""ewAction ewMultiDelete"" title=""" & ew_HtmlTitle(Language.Phrase("DeleteSelectedLink")) & """ data-caption=""" & ew_HtmlTitle(Language.Phrase("DeleteSelectedLink")) & """ href="""" onclick=""ew_SubmitSelected(document.fsysadminlist, '" & MultiDeleteUrl & "', ewLanguage.Phrase('DeleteMultiConfirmMsg'));return false;"">" & Language.Phrase("DeleteSelectedLink") & "</a>"
		item.Visible = (True)

		' Add multi update
		Call opt.Add("multiupdate")
		Set item = opt.GetItem("multiupdate")
		item.Body = "<a class=""ewAction ewMultiUpdate"" title=""" & ew_HtmlTitle(Language.Phrase("UpdateSelectedLink")) & """ data-caption=""" & ew_HtmlTitle(Language.Phrase("UpdateSelectedLink")) & """ href="""" onclick=""ew_SubmitSelected(document.fsysadminlist, '" & MultiUpdateUrl & "');return false;"">" & Language.Phrase("UpdateSelectedLink") & "</a>"
		item.Visible = (True)

		' Set up options default
		Set opt = AddEditOptions
		opt.UseImageAndText = True
		opt.DropDownButtonPhrase = Language.Phrase("ButtonAddEdit")
		opt.UseDropDownButton = False
		opt.UseButtonGroup = True
		opt.ButtonClass = "btn-sm" ' Class for button group
		Call opt.Add(opt.GroupOptionName)
		Set item = opt.GetItem(opt.GroupOptionName)
		item.Body = ""
		item.Visible = False
		Set opt = DetailOptions
		opt.DropDownButtonPhrase = Language.Phrase("ButtonDetails")
		opt.UseDropDownButton = False
		opt.UseButtonGroup = True
		opt.ButtonClass = "btn-sm" ' Class for button group
		Call opt.Add(opt.GroupOptionName)
		Set item = opt.GetItem(opt.GroupOptionName)
		item.Body = ""
		item.Visible = False
		Set opt = ActionOptions
		opt.DropDownButtonPhrase = Language.Phrase("ButtonActions")
		opt.UseDropDownButton = False
		opt.UseButtonGroup = True
		opt.ButtonClass = "btn-sm" ' Class for button group
		Call opt.Add(opt.GroupOptionName)
		Set item = opt.GetItem(opt.GroupOptionName)
		item.Body = ""
		item.Visible = False
	End Sub

	' Render other options
	Sub RenderOtherOptions()
		Dim opt, item, i, Action, Name
		If sysadmin.CurrentAction <> "gridadd" And sysadmin.CurrentAction <> "gridedit" Then ' Not grid add/edit mode
			Set opt = ActionOptions
			For i = 0 to UBound(sysadmin.CustomActions.CustomArray)
				Action = sysadmin.CustomActions.CustomArray(i)(0)
				Name = sysadmin.CustomActions.CustomArray(i)(1)

				' Add custom action
				Call opt.Add("custom_" & Action)
				Set item = opt.GetItem("custom_" & Action)
				item.Body = "<a class=""ewAction ewCustomAction"" href="""" onclick=""ew_SubmitSelected(document.fsysadminlist, '" & ew_CurrentUrl & "', null, '" & Action & "');return false;"">" & Name & "</a>"
			Next

			' Hide grid edit, multi-delete and multi-update
			If TotalRecs <= 0 Then
				Set opt = AddEditOptions
				Set item = opt.GetItem("gridedit")
				If (Not item Is Nothing) Then item.Visible = False
				Set opt = ActionOptions
				Set item = opt.GetItem("multidelete")
				If (Not item Is Nothing) Then item.Visible = False
				Set item = opt.GetItem("multiupdate")
				If (Not item Is Nothing) Then item.Visible = False
			End If
		Else ' Grid add/edit mode

			' Hide all options first
			AddEditOptions.HideAllOptions(Array())
			DetailOptions.HideAllOptions(Array())
			ActionOptions.HideAllOptions(Array())
			If sysadmin.CurrentAction = "gridadd" Then
				If sysadmin.AllowAddDeleteRow Then

					' Add add blank row
					Set opt = AddEditOptions
					opt.UseDropDownButton = False
					opt.UseImageAndText = True
					Call opt.Add("addblankrow")
					Set item = opt.GetItem("addblankrow")
					item.Body = "<a class=""ewAddEdit ewAddBlankRow"" title=""" & ew_HtmlTitle(Language.Phrase("AddBlankRow")) & """ data-caption=""" & ew_HtmlTitle(Language.Phrase("AddBlankRow")) & """ href=""javascript:void(0);"" onclick=""ew_AddGridRow(this);"">" & Language.Phrase("AddBlankRow") & "</a>"
					item.Visible = False
				End If
				Set opt = ActionOptions
				opt.UseDropDownButton = False
				opt.UseImageAndText = True

				' Add grid insert
				Call opt.Add("gridinsert")
				Set item = opt.GetItem("gridinsert")
				item.Body = "<a class=""ewAction ewGridInsert"" title=""" & ew_HtmlTitle(Language.Phrase("GridInsertLink")) & """ data-caption=""" & ew_HtmlTitle(Language.Phrase("GridInsertLink")) & """ href="""" onclick=""return ewForms(this).Submit();"">" & Language.Phrase("GridInsertLink") & "</a>"

				' Add grid cancel
				Call opt.Add("gridcancel")
				Set item = opt.GetItem("gridcancel")
				item.Body = "<a class=""ewAction ewGridCancel"" title=""" & ew_HtmlTitle(Language.Phrase("GridCancelLink")) & """ data-caption=""" & ew_HtmlTitle(Language.Phrase("GridCancelLink")) & """ href=""" & PageUrl & "a=cancel"">" & Language.Phrase("GridCancelLink") & "</a>"
			End If
			If sysadmin.CurrentAction = "gridedit" Then
				If sysadmin.AllowAddDeleteRow Then

					' Add add blank row
					Set opt = AddEditOptions
					opt.UseDropDownButton = False
					opt.UseImageAndText = True
					Call opt.Add("addblankrow")
					Set item = opt.GetItem("addblankrow")
					item.Body = "<a class=""ewAddEdit ewAddBlankRow"" title=""" & ew_HtmlTitle(Language.Phrase("AddBlankRow")) & """ data-caption=""" & ew_HtmlTitle(Language.Phrase("AddBlankRow")) & """ href=""javascript:void(0);"" onclick=""ew_AddGridRow(this);"">" & Language.Phrase("AddBlankRow") & "</a>"
					item.Visible = False
				End If
				Set opt = ActionOptions
				opt.UseDropDownButton = False
				opt.UseImageAndText = True
				If sysadmin.UpdateConflict = "U" Then ' Record already updated by other user
					Call opt.Add("reload")
					Set item = opt.GetItem("reload")
					item.Body = "<a class=""ewAction ewGridReload"" title=""" & ew_HtmlTitle(Language.Phrase("ReloadLink")) & """ data-caption=""" & ew_HtmlTitle(Language.Phrase("ReloadLink")) & """ href=""" & ew_HtmlEncode(GridEditUrl)  & """>" & Language.Phrase("ReloadLink") & "</a>"
					Call opt.Add("overwrite")
					Set item = opt.GetItem("overwrite")
					item.Body = "<a class=""ewAction ewGridOverwrite"" title=""" & ew_HtmlTitle(Language.Phrase("OverwriteLink")) & """ data-caption=""" & ew_HtmlTitle(Language.Phrase("OverwriteLink")) & """ href="""" onclick=""return ewForms(this).Submit();"">" & Language.Phrase("OverwriteLink") & "</a>"
					Call opt.Add("cancel")
					Set item = opt.GetItem("cancel")
					item.Body = "<a class=""ewAction ewGridCancel"" title=""" & ew_HtmlTitle(Language.Phrase("ConflictCancelLink")) & """ data-caption=""" & ew_HtmlTitle(Language.Phrase("ConflictCancelLink")) & """ href=""" & PageUrl & "a=cancel"">" & Language.Phrase("ConflictCancelLink") & "</a>"
				Else
					Call opt.Add("gridsave")
					Set item = opt.GetItem("gridsave")
					item.Body = "<a class=""ewAction ewGridSave"" title=""" & ew_HtmlTitle(Language.Phrase("GridSaveLink")) & """ data-caption=""" & ew_HtmlTitle(Language.Phrase("GridSaveLink")) & """ href="""" onclick=""return ewForms(this).Submit();"">" & Language.Phrase("GridSaveLink") & "</a>"
					Call opt.Add("gridcancel")
					Set item = opt.GetItem("gridcancel")
					item.Body = "<a class=""ewAction ewGridCancel"" title=""" & ew_HtmlTitle(Language.Phrase("GridCancelLink")) & """ data-caption=""" & ew_HtmlTitle(Language.Phrase("GridCancelLink")) & """ href=""" & PageUrl & "a=cancel"">" & Language.Phrase("GridCancelLink") & "</a>"
				End If
			End If
		End If
	End Sub

	' Process custom action
	Sub ProcessCustomAction()
		Dim sFilter, sSql, UserAction, Processed
		sFilter = sysadmin.GetKeyFilter
		UserAction = Request.Form("useraction") & ""
		Processed = False
		If sFilter <> "" And UserAction <> "" Then
			sysadmin.CurrentFilter = sFilter
			sSql = sysadmin.SQL
			Conn.BeginTrans

			' Load recordset
			Dim Rs
			Set Rs = ew_LoadRecordset(sSql)
			If Not Rs.Eof Then Rs.MoveFirst

			' Call row custom action event
			Do While Not Rs.Eof
				Processed = Row_CustomAction(UserAction, Rs)
				If Not Processed Then
					Exit Do
				Else
					Rs.MoveNext
				End If
			Loop
			Rs.Close
			Set Rs = Nothing
			If Processed Then
				Conn.CommitTrans ' Commit the changes
				If SuccessMessage = "" Then
					SuccessMessage = Replace(Language.Phrase("CustomActionCompleted"), "%s", UserAction) ' Set up success message
				End If
			Else
				Conn.RollbackTrans ' Rollback transaction

				' Set up error message
				If SuccessMessage <> "" Or FailureMessage <> "" Then

					' Use the message, do nothing
				ElseIf sysadmin.CancelMessage <> "" Then
					FailureMessage = sysadmin.CancelMessage
					sysadmin.CancelMessage = ""
				Else
					FailureMessage = Replace(Language.Phrase("CustomActionCancelled"), "%s", UserAction)
				End If
			End If
		End If
	End Sub

	' Set up search options
	Sub SetupSearchOptions()
		Dim item, SearchToggleClass
		Set SearchOptions = New cListOptions
		SearchOptions.TableVar = sysadmin.TableVar
		ExportOptions.Tag = "div"
		SearchOptions.TagClassName = "ewSearchOption"

		' Search button
		SearchOptions.Add("searchtoggle")
		Set item = SearchOptions.GetItem("searchtoggle")
		SearchToggleClass = ew_IIf(SearchWhere <> "", " active", " active")
		item.Body = "<button type=""button"" class=""btn btn-default ewSearchToggle" & SearchToggleClass & """ title=""" & Language.Phrase("SearchPanel") & """ data-caption=""" & Language.Phrase("SearchPanel") & """ data-toggle=""button"" data-form=""fsysadminlistsrch"">" & Language.Phrase("SearchBtn") & "</button>"
		item.Visible = True

		' Show all button
		SearchOptions.Add("showall")
		Set item = SearchOptions.GetItem("showall")
		item.Body = "<a class=""btn btn-default ewShowAll"" title=""" & Language.Phrase("ShowAll") & """ data-caption=""" & Language.Phrase("ShowAll") & """ href=""" & PageUrl & "cmd=reset"">" & Language.Phrase("ShowAllBtn") & "</a>"
		item.Visible = (SearchWhere <> DefaultSearchWhere And SearchWhere <> "0=101")

		' Advanced search button
		SearchOptions.Add("advancedsearch")
		Set item = SearchOptions.GetItem("advancedsearch")
		If ew_IsMobile() Then
			item.Body = "<a class=""btn btn-default ewAdvancedSearch"" title=""" & Language.Phrase("AdvancedSearch") & """ data-caption=""" & Language.Phrase("AdvancedSearch") & """ href=""sysadminsrch.asp"">" & Language.Phrase("AdvancedSearchBtn") & "</a>"
		Else
			item.Body = "<button type=""button"" class=""btn btn-default ewAdvancedSearch"" title=""" & Language.Phrase("AdvancedSearch") & """ data-caption=""" & Language.Phrase("AdvancedSearch") & """ onclick=""ew_SearchDialogShow({lnk:this,url:'sysadminsrch.asp'});"">" & Language.Phrase("AdvancedSearchBtn") & "</a>"
		End If
		item.Visible = True

		' Search highlight button
		SearchOptions.Add("searchhighlight")
		Set item = SearchOptions.GetItem("searchhighlight")
		item.Body = "<button type=""button"" class=""btn btn-default ewHighlight active"" title=""" & Language.Phrase("Highlight") & """ data-caption=""" & Language.Phrase("Highlight") & """ data-toggle=""button"" data-form=""fsysadminlistsrch"" data-name=""" & sysadmin.HighlightName & """>" & Language.Phrase("HighlightBtn") & "</button>"
		item.Visible = (SearchWhere <> "" And TotalRecs > 0)

		' Button group for search
		SearchOptions.UseDropDownButton = False
		SearchOptions.UseImageAndText = True
		SearchOptions.UseButtonGroup = True
		SearchOptions.DropDownButtonPhrase = Language.Phrase("ButtonSearch")

		' Add group option item
		SearchOptions.Add(SearchOptions.GroupOptionName)
		Set item = SearchOptions.GetItem(SearchOptions.GroupOptionName)
		item.Body = ""
		item.Visible = False

		' Hide search options
		If sysadmin.Export <> "" Or sysadmin.CurrentAction <> "" Then
			SearchOptions.HideAllOptions(Array())
		End If
	End Sub

	Function SetupListOptionsExt()

		' Hide detail items if necessary
		Dim showdtl, i, opt
		showdtl = False
		If ListOptions.UseDropDownButton Then
			For i = 0 To ListOptions.Items.Count - 1
				Set opt = ListOptions.Items(i)
				If opt.Name <> ListOptions.GroupOptionName And opt.Visible And opt.ShowInDropDown And Left(opt.Name,7) <> "detail_" Then
					showdtl = True
					Exit For
				End If
			Next
		End If
		If Not showdtl Then
			For i = 0 To ListOptions.Items.Count - 1
				Set opt = ListOptions.Items(i)
				If Left(opt.Name,7) = "detail_" Then
					opt.Visible = False
				End If
			Next
		End If
	End Function

	Function RenderListOptionsExt()
	End Function
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
				sysadmin.StartRecordNumber = StartRec
			ElseIf Request.QueryString(EW_TABLE_PAGE_NO).Count > 0 Then
				PageNo = Request.QueryString(EW_TABLE_PAGE_NO)
				If IsNumeric(PageNo) Then
					StartRec = (PageNo-1)*DisplayRecs+1
					If StartRec <= 0 Then
						StartRec = 1
					ElseIf StartRec >= ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1 Then
						StartRec = ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1
					End If
					sysadmin.StartRecordNumber = StartRec
				End If
			End If
		End If
		StartRec = sysadmin.StartRecordNumber

		' Check if correct start record counter
		If Not IsNumeric(StartRec) Or StartRec = "" Then ' Avoid invalid start record counter
			StartRec = 1 ' Reset start record counter
			sysadmin.StartRecordNumber = StartRec
		ElseIf CLng(StartRec) > CLng(TotalRecs) Then ' Avoid starting record > total records
			StartRec = ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1 ' Point to last page first record
			sysadmin.StartRecordNumber = StartRec
		ElseIf (StartRec-1) Mod DisplayRecs <> 0 Then
			StartRec = ((StartRec-1)\DisplayRecs)*DisplayRecs+1 ' Point to page boundary
			sysadmin.StartRecordNumber = StartRec
		End If
	End Sub

	' -----------------------------------------------------------------
	' Load default values
	'
	Function LoadDefaultValues()
		sysadmin.ID.CurrentValue = Null
		sysadmin.ID.OldValue = sysadmin.ID.CurrentValue
		sysadmin.username.CurrentValue = Null
		sysadmin.username.OldValue = sysadmin.username.CurrentValue
		sysadmin.pswd.CurrentValue = Null
		sysadmin.pswd.OldValue = sysadmin.pswd.CurrentValue
		sysadmin.userrolelabel.CurrentValue = Null
		sysadmin.userrolelabel.OldValue = sysadmin.userrolelabel.CurrentValue
		sysadmin.userrole.CurrentValue = Null
		sysadmin.userrole.OldValue = sysadmin.userrole.CurrentValue
	End Function

	' -----------------------------------------------------------------
	'  Load basic search values
	'
	Function LoadBasicSearchValues()
		sysadmin.BasicSearch.Keyword = Request.QueryString(EW_TABLE_BASIC_SEARCH)&""
		If sysadmin.BasicSearch.Keyword <> "" Then Command = "search"
		sysadmin.BasicSearch.SearchType = Request.QueryString(EW_TABLE_BASIC_SEARCH_TYPE)&""
	End Function

	' -----------------------------------------------------------------
	'  Load search values for validation
	'
	Function LoadSearchValues()

		' Load search values
		sysadmin.ID.AdvancedSearch.SearchValue = Request.QueryString("x_ID")
		If sysadmin.ID.AdvancedSearch.SearchValue&"" <> "" Then Command = "search"
		sysadmin.ID.AdvancedSearch.SearchOperator = Request.QueryString("z_ID")
		sysadmin.username.AdvancedSearch.SearchValue = Request.QueryString("x_username")
		If sysadmin.username.AdvancedSearch.SearchValue&"" <> "" Then Command = "search"
		sysadmin.username.AdvancedSearch.SearchOperator = Request.QueryString("z_username")
		sysadmin.pswd.AdvancedSearch.SearchValue = Request.QueryString("x_pswd")
		If sysadmin.pswd.AdvancedSearch.SearchValue&"" <> "" Then Command = "search"
		sysadmin.pswd.AdvancedSearch.SearchOperator = Request.QueryString("z_pswd")
		sysadmin.userrolelabel.AdvancedSearch.SearchValue = Request.QueryString("x_userrolelabel")
		If sysadmin.userrolelabel.AdvancedSearch.SearchValue&"" <> "" Then Command = "search"
		sysadmin.userrolelabel.AdvancedSearch.SearchOperator = Request.QueryString("z_userrolelabel")
		sysadmin.userrole.AdvancedSearch.SearchValue = Request.QueryString("x_userrole")
		If sysadmin.userrole.AdvancedSearch.SearchValue&"" <> "" Then Command = "search"
		sysadmin.userrole.AdvancedSearch.SearchOperator = Request.QueryString("z_userrole")
	End Function

	' -----------------------------------------------------------------
	' Load form values
	'
	Function LoadFormValues()

		' Load values from form
		If Not sysadmin.ID.FldIsDetailKey And sysadmin.CurrentAction <> "gridadd" And sysadmin.CurrentAction <> "add" Then sysadmin.ID.FormValue = ObjForm.GetValue("x_ID")
		If Not sysadmin.username.FldIsDetailKey Then sysadmin.username.FormValue = ObjForm.GetValue("x_username")
		sysadmin.username.OldValue = ObjForm.GetValue("o_username")
		If Not sysadmin.pswd.FldIsDetailKey Then sysadmin.pswd.FormValue = ObjForm.GetValue("x_pswd")
		sysadmin.pswd.OldValue = ObjForm.GetValue("o_pswd")
		If Not sysadmin.userrolelabel.FldIsDetailKey Then sysadmin.userrolelabel.FormValue = ObjForm.GetValue("x_userrolelabel")
		sysadmin.userrolelabel.OldValue = ObjForm.GetValue("o_userrolelabel")
		If Not sysadmin.userrole.FldIsDetailKey Then sysadmin.userrole.FormValue = ObjForm.GetValue("x_userrole")
		sysadmin.userrole.OldValue = ObjForm.GetValue("o_userrole")
		If sysadmin.CurrentAction <> "overwrite" Then HashValue = ObjForm.GetValue("k_hash")
	End Function

	' -----------------------------------------------------------------
	' Restore form values
	'
	Function RestoreFormValues()
		If sysadmin.CurrentAction <> "gridadd" And sysadmin.CurrentAction <> "add" Then sysadmin.ID.CurrentValue = sysadmin.ID.FormValue
		sysadmin.username.CurrentValue = sysadmin.username.FormValue
		sysadmin.pswd.CurrentValue = sysadmin.pswd.FormValue
		sysadmin.userrolelabel.CurrentValue = sysadmin.userrolelabel.FormValue
		sysadmin.userrole.CurrentValue = sysadmin.userrole.FormValue
		If sysadmin.CurrentAction <> "overwrite" Then HashValue = ObjForm.GetValue("k_hash")
	End Function

	' -----------------------------------------------------------------
	' Load recordset
	'
	Function LoadRecordset()

		' Load list page sql
		Dim sSql
		sSql = sysadmin.SelectSQL
		Call ew_SetDebugMsg("LoadRecordset: " & sSql) ' Show SQL for debugging

		' Load recordset
		Dim RsRecordset
		Set RsRecordset = ew_LoadRecordset(sSql)

		' Call Recordset Selected event
		Call sysadmin.Recordset_Selected(RsRecordset)
		Set LoadRecordset = RsRecordset
	End Function

	' -----------------------------------------------------------------
	' Load row based on key values
	'
	Function LoadRow()
		Dim RsRow, sSql, sFilter
		sFilter = sysadmin.KeyFilter

		' Call Row Selecting event
		Call sysadmin.Row_Selecting(sFilter)

		' Load sql based on filter
		sysadmin.CurrentFilter = sFilter
		sSql = sysadmin.SQL
		Call ew_SetDebugMsg("LoadRow: " & sSql) ' Show SQL for debugging
		Set RsRow = ew_LoadRow(sSql)
		If RsRow.Eof Then
			LoadRow = False
		Else
			LoadRow = True
			RsRow.MoveFirst
			Call LoadRowValues(RsRow) ' Load row values
			If Not sysadmin.EventCancelled Then HashValue = GetRowHash(RsRow) ' Get hash value for record
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
		Call sysadmin.Row_Selected(RsRow)
		sysadmin.ID.DbValue = RsRow("ID")
		sysadmin.username.DbValue = RsRow("username")
		sysadmin.pswd.DbValue = RsRow("pswd")
		sysadmin.userrolelabel.DbValue = RsRow("userrolelabel")
		sysadmin.userrole.DbValue = RsRow("userrole")
	End Sub

	' Load DbValue from recordset
	Sub LoadDbValues(Rs)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		If Rs.Eof Then Exit Sub
		sysadmin.ID.m_DbValue = Rs("ID")
		sysadmin.username.m_DbValue = Rs("username")
		sysadmin.pswd.m_DbValue = Rs("pswd")
		sysadmin.userrolelabel.m_DbValue = Rs("userrolelabel")
		sysadmin.userrole.m_DbValue = Rs("userrole")
	End Sub

	' Load old record
	Function LoadOldRecord()

		' Load key values from Session
		Dim bValidKey
		bValidKey = True
		If sysadmin.GetKey("ID")&"" <> "" Then
			sysadmin.ID.CurrentValue = sysadmin.GetKey("ID") ' ID
		Else
			bValidKey = False
		End If

		' Load old recordset
		If bValidKey Then
			sysadmin.CurrentFilter = sysadmin.KeyFilter
			Dim sSql
			sSql = sysadmin.SQL
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
		ViewUrl = sysadmin.ViewUrl("")
		EditUrl = sysadmin.EditUrl("")
		InlineEditUrl = sysadmin.InlineEditUrl
		CopyUrl = sysadmin.CopyUrl("")
		InlineCopyUrl = sysadmin.InlineCopyUrl
		DeleteUrl = sysadmin.DeleteUrl

		' Call Row Rendering event
		Call sysadmin.Row_Rendering()

		' ---------------------------------------
		'  Common render codes for all row types
		' ---------------------------------------
		' ID
		' username
		' pswd
		' userrolelabel
		' userrole
		' -----------
		'  View  Row
		' -----------

		If sysadmin.RowType = EW_ROWTYPE_VIEW Then ' View row

			' ID
			sysadmin.ID.ViewValue = sysadmin.ID.CurrentValue
			sysadmin.ID.ViewCustomAttributes = ""

			' username
			sysadmin.username.ViewValue = sysadmin.username.CurrentValue
			sysadmin.username.ViewCustomAttributes = ""

			' pswd
			sysadmin.pswd.ViewValue = sysadmin.pswd.CurrentValue
			sysadmin.pswd.ViewCustomAttributes = ""

			' userrolelabel
			sysadmin.userrolelabel.ViewValue = sysadmin.userrolelabel.CurrentValue
			sysadmin.userrolelabel.ViewCustomAttributes = ""

			' userrole
			sysadmin.userrole.ViewValue = sysadmin.userrole.CurrentValue
			sysadmin.userrole.ViewCustomAttributes = ""

			' View refer script
			' ID

			sysadmin.ID.LinkCustomAttributes = ""
			sysadmin.ID.HrefValue = ""
			sysadmin.ID.TooltipValue = ""

			' username
			sysadmin.username.LinkCustomAttributes = ""
			sysadmin.username.HrefValue = ""
			sysadmin.username.TooltipValue = ""
			If sysadmin.Export = "" Then
				sysadmin.username.ViewValue = ew_Highlight(sysadmin.HighlightName, sysadmin.username.ViewValue, sysadmin.BasicSearch.getKeyword(), sysadmin.BasicSearch.getSearchType(), sysadmin.username.AdvancedSearch.getValue("x"), "")
			End If

			' pswd
			sysadmin.pswd.LinkCustomAttributes = ""
			sysadmin.pswd.HrefValue = ""
			sysadmin.pswd.TooltipValue = ""
			If sysadmin.Export = "" Then
				sysadmin.pswd.ViewValue = ew_Highlight(sysadmin.HighlightName, sysadmin.pswd.ViewValue, sysadmin.BasicSearch.getKeyword(), sysadmin.BasicSearch.getSearchType(), sysadmin.pswd.AdvancedSearch.getValue("x"), "")
			End If

			' userrolelabel
			sysadmin.userrolelabel.LinkCustomAttributes = ""
			sysadmin.userrolelabel.HrefValue = ""
			sysadmin.userrolelabel.TooltipValue = ""
			If sysadmin.Export = "" Then
				sysadmin.userrolelabel.ViewValue = ew_Highlight(sysadmin.HighlightName, sysadmin.userrolelabel.ViewValue, sysadmin.BasicSearch.getKeyword(), sysadmin.BasicSearch.getSearchType(), sysadmin.userrolelabel.AdvancedSearch.getValue("x"), "")
			End If

			' userrole
			sysadmin.userrole.LinkCustomAttributes = ""
			sysadmin.userrole.HrefValue = ""
			sysadmin.userrole.TooltipValue = ""
			If sysadmin.Export = "" Then
				sysadmin.userrole.ViewValue = ew_Highlight(sysadmin.HighlightName, sysadmin.userrole.ViewValue, sysadmin.BasicSearch.getKeyword(), sysadmin.BasicSearch.getSearchType(), sysadmin.userrole.AdvancedSearch.getValue("x"), "")
			End If

		' ---------
		'  Add Row
		' ---------

		ElseIf sysadmin.RowType = EW_ROWTYPE_ADD Then ' Add row

			' ID
			' username

			sysadmin.username.EditAttrs.UpdateAttribute "class", "form-control"
			sysadmin.username.EditCustomAttributes = ""
			sysadmin.username.EditValue = ew_HtmlEncode(sysadmin.username.CurrentValue)
			sysadmin.username.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(sysadmin.username.FldCaption))

			' pswd
			sysadmin.pswd.EditAttrs.UpdateAttribute "class", "form-control"
			sysadmin.pswd.EditCustomAttributes = ""
			sysadmin.pswd.EditValue = ew_HtmlEncode(sysadmin.pswd.CurrentValue)
			sysadmin.pswd.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(sysadmin.pswd.FldCaption))

			' userrolelabel
			sysadmin.userrolelabel.EditAttrs.UpdateAttribute "class", "form-control"
			sysadmin.userrolelabel.EditCustomAttributes = ""
			sysadmin.userrolelabel.EditValue = ew_HtmlEncode(sysadmin.userrolelabel.CurrentValue)
			sysadmin.userrolelabel.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(sysadmin.userrolelabel.FldCaption))

			' userrole
			sysadmin.userrole.EditAttrs.UpdateAttribute "class", "form-control"
			sysadmin.userrole.EditCustomAttributes = ""
			sysadmin.userrole.EditValue = ew_HtmlEncode(sysadmin.userrole.CurrentValue)
			sysadmin.userrole.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(sysadmin.userrole.FldCaption))

			' Edit refer script
			' ID

			sysadmin.ID.HrefValue = ""

			' username
			sysadmin.username.HrefValue = ""

			' pswd
			sysadmin.pswd.HrefValue = ""

			' userrolelabel
			sysadmin.userrolelabel.HrefValue = ""

			' userrole
			sysadmin.userrole.HrefValue = ""

		' ----------
		'  Edit Row
		' ----------

		ElseIf sysadmin.RowType = EW_ROWTYPE_EDIT Then ' Edit row

			' ID
			sysadmin.ID.EditAttrs.UpdateAttribute "class", "form-control"
			sysadmin.ID.EditCustomAttributes = ""
			sysadmin.ID.EditValue = sysadmin.ID.CurrentValue
			sysadmin.ID.ViewCustomAttributes = ""

			' username
			sysadmin.username.EditAttrs.UpdateAttribute "class", "form-control"
			sysadmin.username.EditCustomAttributes = ""
			sysadmin.username.EditValue = ew_HtmlEncode(sysadmin.username.CurrentValue)
			sysadmin.username.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(sysadmin.username.FldCaption))

			' pswd
			sysadmin.pswd.EditAttrs.UpdateAttribute "class", "form-control"
			sysadmin.pswd.EditCustomAttributes = ""
			sysadmin.pswd.EditValue = ew_HtmlEncode(sysadmin.pswd.CurrentValue)
			sysadmin.pswd.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(sysadmin.pswd.FldCaption))

			' userrolelabel
			sysadmin.userrolelabel.EditAttrs.UpdateAttribute "class", "form-control"
			sysadmin.userrolelabel.EditCustomAttributes = ""
			sysadmin.userrolelabel.EditValue = ew_HtmlEncode(sysadmin.userrolelabel.CurrentValue)
			sysadmin.userrolelabel.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(sysadmin.userrolelabel.FldCaption))

			' userrole
			sysadmin.userrole.EditAttrs.UpdateAttribute "class", "form-control"
			sysadmin.userrole.EditCustomAttributes = ""
			sysadmin.userrole.EditValue = ew_HtmlEncode(sysadmin.userrole.CurrentValue)
			sysadmin.userrole.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(sysadmin.userrole.FldCaption))

			' Edit refer script
			' ID

			sysadmin.ID.HrefValue = ""

			' username
			sysadmin.username.HrefValue = ""

			' pswd
			sysadmin.pswd.HrefValue = ""

			' userrolelabel
			sysadmin.userrolelabel.HrefValue = ""

			' userrole
			sysadmin.userrole.HrefValue = ""
		End If
		If sysadmin.RowType = EW_ROWTYPE_ADD Or sysadmin.RowType = EW_ROWTYPE_EDIT Or sysadmin.RowType = EW_ROWTYPE_SEARCH Then ' Add / Edit / Search row
			Call sysadmin.SetupFieldTitles()
		End If

		' Call Row Rendered event
		If sysadmin.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call sysadmin.Row_Rendered()
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

	'
	' Delete records based on current filter
	'
	Function DeleteRows()
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		Dim sKey, sThisKey, sKeyFld, arKeyFlds
		Dim sSql, RsDelete
		Dim RsOld, RsDetail
		Dim OldFiles, i
		DeleteRows = True
		sSql = sysadmin.SQL
		Set RsDelete = Server.CreateObject("ADODB.Recordset")
		RsDelete.CursorLocation = EW_CURSORLOCATION
		RsDelete.Open sSql, Conn, 1, EW_RECORDSET_LOCKTYPE
		If Err.Number <> 0 Then
			FailureMessage = Err.Description
			RsDelete.Close
			Set RsDelete = Nothing
			DeleteRows = False
			Exit Function
		ElseIf RsDelete.Eof Then
			FailureMessage = Language.Phrase("NoRecord") ' No record found
			RsDelete.Close
			Set RsDelete = Nothing
			DeleteRows = False
			Exit Function
		End If

		' Clone old recordset object
		Set RsOld = ew_CloneRs(RsDelete)

		' Call row deleting event
		If DeleteRows Then
			RsDelete.MoveFirst
			Do While Not RsDelete.Eof
				DeleteRows = sysadmin.Row_Deleting(RsDelete)
				If Not DeleteRows Then Exit Do
				RsDelete.MoveNext
			Loop
			RsDelete.MoveFirst
		End If
		If DeleteRows Then
			sKey = ""
			RsDelete.MoveFirst
			Do While Not RsDelete.Eof
				sThisKey = ""
				If sThisKey <> "" Then sThisKey = sThisKey & EW_COMPOSITE_KEY_SEPARATOR
				sThisKey = sThisKey & RsDelete("ID")
				If DeleteRows Then
					RsDelete.Delete
				End If
				If Err.Number <> 0 Or Not DeleteRows Then
					If Err.Description <> "" Then FailureMessage = Err.Description ' Set up error message
					DeleteRows = False
					Exit Do
				End If
				If sKey <> "" Then sKey = sKey & ", "
				sKey = sKey & sThisKey
				RsDelete.MoveNext
			Loop
		Else

			' Set up error message
			If SuccessMessage <> "" Or FailureMessage <> "" Then

				' Use the message, do nothing
			ElseIf sysadmin.CancelMessage <> "" Then
				FailureMessage = sysadmin.CancelMessage
				sysadmin.CancelMessage = ""
			Else
				FailureMessage = Language.Phrase("DeleteCancelled")
			End If
		End If
		If DeleteRows Then
		Else
		End If
		RsDelete.Close
		Set RsDelete = Nothing

		' Call row deleting event
		If DeleteRows Then
			RsOld.MoveFirst
			Do While Not RsOld.Eof
				Call sysadmin.Row_Deleted(RsOld)
				RsOld.MoveNext
			Loop
		End If
		RsOld.Close
		Set RsOld = Nothing
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
		sFilter = sysadmin.KeyFilter
		sysadmin.CurrentFilter  = sFilter
		sSql = sysadmin.SQL
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

			' Field username
			Call sysadmin.username.SetDbValue(Rs, sysadmin.username.CurrentValue, Null, sysadmin.username.ReadOnly)

			' Field pswd
			Call sysadmin.pswd.SetDbValue(Rs, sysadmin.pswd.CurrentValue, Null, sysadmin.pswd.ReadOnly)

			' Field userrolelabel
			Call sysadmin.userrolelabel.SetDbValue(Rs, sysadmin.userrolelabel.CurrentValue, Null, sysadmin.userrolelabel.ReadOnly)

			' Field userrole
			Call sysadmin.userrole.SetDbValue(Rs, sysadmin.userrole.CurrentValue, Null, sysadmin.userrole.ReadOnly)

			' Check recordset update error
			If Err.Number <> 0 Then
				FailureMessage = Err.Description
				Rs.Close
				Set Rs = Nothing
				EditRow = False
				Exit Function
			End If

			' Check hash value
			Dim bRowHasConflict
			bRowHasConflict = (GetRowHash(RsOld) <> HashValue)

			' Call Row Update Conflict event
			If bRowHasConflict Then bRowHasConflict = sysadmin.Row_UpdateConflict(RsOld, Rs)
			If bRowHasConflict Then
				FailureMessage = Language.Phrase("RecordChangedByOtherUser")
				sysadmin.UpdateConflict = "U"
				Rs.CancelUpdate
				Rs.Close
				Set Rs = Nothing
				EditRow = False ' Update Failed
				Exit Function
			End If

			' Call Row Updating event
			bUpdateRow = sysadmin.Row_Updating(RsOld, Rs)
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
				ElseIf sysadmin.CancelMessage <> "" Then
					FailureMessage = sysadmin.CancelMessage
					sysadmin.CancelMessage = ""
				Else
					FailureMessage = Language.Phrase("UpdateCancelled")
				End If
				EditRow = False
			End If
		End If

		' Call Row Updated event
		If EditRow Then
			Call sysadmin.Row_Updated(RsOld, RsNew)
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

	' Load row hash
	Function LoadRowHash()
		Dim RsRow, sSql, sFilter
		sFilter = sysadmin.KeyFilter

		' Load sql based on filter
		sysadmin.CurrentFilter = sFilter
		sSql = sysadmin.SQL
		Set RsRow = Server.CreateObject("ADODB.Recordset")
		RsRow.Open sSql, Conn
		If RsRow.Eof Then
			HashValue = ""
		Else
			RsRow.MoveFirst
			HashValue = GetRowHash(RsRow) ' Get hash value for record
		End If
		RsRow.Close
		Set RsRow = Nothing
	End Function

	' Get Row Hash
	Function GetRowHash(rs)
		Dim sHash, value, typ
		sHash = ""
		value = rs("username") ' username
		typ = rs("username").Type
		sHash = sHash & ew_GetFldHash(value, typ)
		value = rs("pswd") ' pswd
		typ = rs("pswd").Type
		sHash = sHash & ew_GetFldHash(value, typ)
		value = rs("userrolelabel") ' userrolelabel
		typ = rs("userrolelabel").Type
		sHash = sHash & ew_GetFldHash(value, typ)
		value = rs("userrole") ' userrole
		typ = rs("userrole").Type
		sHash = sHash & ew_GetFldHash(value, typ)
		GetRowHash = MD5(sHash)
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
		sysadmin.CurrentFilter = sFilter
		sSql = sysadmin.SQL
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

		' Field username
		Call sysadmin.username.SetDbValue(Rs, sysadmin.username.CurrentValue, Null, False)

		' Field pswd
		Call sysadmin.pswd.SetDbValue(Rs, sysadmin.pswd.CurrentValue, Null, False)

		' Field userrolelabel
		Call sysadmin.userrolelabel.SetDbValue(Rs, sysadmin.userrolelabel.CurrentValue, Null, False)

		' Field userrole
		Call sysadmin.userrole.SetDbValue(Rs, sysadmin.userrole.CurrentValue, Null, False)

		' Check recordset update error
		If Err.Number <> 0 Then
			FailureMessage = Err.Description
			Rs.Close
			Set Rs = Nothing
			AddRow = False
			Exit Function
		End If

		' Call Row Inserting event
		bInsertRow = sysadmin.Row_Inserting(RsOld, Rs)
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
			ElseIf sysadmin.CancelMessage <> "" Then
				FailureMessage = sysadmin.CancelMessage
				sysadmin.CancelMessage = ""
			Else
				FailureMessage = Language.Phrase("InsertCancelled")
			End If
			AddRow = False
		End If
		Rs.Close
		Set Rs = Nothing
		If AddRow Then
			sysadmin.ID.DbValue = RsNew("ID")
		End If
		If AddRow Then

			' Call Row Inserted event
			Call sysadmin.Row_Inserted(RsOld, RsNew)
		End If
		If IsObject(RsNew) Then
			RsNew.Close
			Set RsNew = Nothing
		End If
	End Function

	' -----------------------------------------------------------------
	' Load advanced search
	'
	Function LoadAdvancedSearch()
		Call sysadmin.ID.AdvancedSearch.Load()
		Call sysadmin.username.AdvancedSearch.Load()
		Call sysadmin.pswd.AdvancedSearch.Load()
		Call sysadmin.userrolelabel.AdvancedSearch.Load()
		Call sysadmin.userrole.AdvancedSearch.Load()
End Function

	' Set up export options
	Sub SetupExportOptions()
		Dim item, url

		' Printer friendly
		ExportOptions.Add("print")
		Set item = ExportOptions.GetItem("print")
		item.Body = "<a href=""" & ExportPrintUrl & """ class=""ewExportLink ewPrint"" title=""" & ew_HtmlEncode(Language.Phrase("PrinterFriendlyText")) & """ data-caption=""" & ew_HtmlEncode(Language.Phrase("PrinterFriendlyText")) & """>" & Language.Phrase("PrinterFriendly") & "</a>"
		item.Visible = True

		' Export to Excel
		ExportOptions.Add("excel")
		Set item = ExportOptions.GetItem("excel")
		item.Body = "<a href=""" & ExportExcelUrl & """ class=""ewExportLink ewExcel"" title=""" & ew_HtmlEncode(Language.Phrase("ExportToExcelText")) & """ data-caption=""" & ew_HtmlEncode(Language.Phrase("ExportToExcelText")) & """>" & Language.Phrase("ExportToExcel") & "</a>"
		item.Visible = True

		' Export to Word
		ExportOptions.Add("word")
		Set item = ExportOptions.GetItem("word")
		item.Body = "<a href=""" & ExportWordUrl & """ class=""ewExportLink ewWord"" title=""" & ew_HtmlEncode(Language.Phrase("ExportToWordText")) & """ data-caption=""" & ew_HtmlEncode(Language.Phrase("ExportToWordText")) & """>" & Language.Phrase("ExportToWord") & "</a>"
		item.Visible = True

		' Export to Html
		ExportOptions.Add("html")
		Set item = ExportOptions.GetItem("html")
		item.Body = "<a href=""" & ExportHtmlUrl & """ class=""ewExportLink ewHtml"" title=""" & ew_HtmlEncode(Language.Phrase("ExportToHtmlText")) & """ data-caption=""" & ew_HtmlEncode(Language.Phrase("ExportToHtmlText")) & """>" & Language.Phrase("ExportToHtml") & "</a>"
		item.Visible = True

		' Export to Xml
		ExportOptions.Add("xml")
		Set item = ExportOptions.GetItem("xml")
		item.Body = "<a href=""" & ExportXmlUrl & """ class=""ewExportLink ewXml"" title=""" & ew_HtmlEncode(Language.Phrase("ExportToXmlText")) & """ data-caption=""" & ew_HtmlEncode(Language.Phrase("ExportToXmlText")) & """>" & Language.Phrase("ExportToXml") & "</a>"
		item.Visible = False

		' Export to Csv
		ExportOptions.Add("csv")
		Set item = ExportOptions.GetItem("csv")
		item.Body = "<a href=""" & ExportCsvUrl & """ class=""ewExportLink ewCsv"" title=""" & ew_HtmlEncode(Language.Phrase("ExportToCsvText")) & """ data-caption=""" & ew_HtmlEncode(Language.Phrase("ExportToCsvText")) & """>" & Language.Phrase("ExportToCsv") & "</a>"
		item.Visible = True

		' Export to Pdf
		ExportOptions.Add("pdf")
		Set item = ExportOptions.GetItem("pdf")
		If ExportPdfCustom Then
			item.Body = "<a href=""javascript:void(0);"" class=""ewExportLink ewPdf"" title=""" & ew_HtmlEncode(Language.Phrase("ExportToPDFText")) & """ data-caption=""" & ew_HtmlEncode(Language.Phrase("ExportToPDFText")) & """ onclick=""ew_Export(document.fsysadminlist,'" & ExportPdfUrl & "','pdf',true);"">" & Language.Phrase("ExportToPDF") & "</a>"
		Else
			item.Body = "<a href=""" & ExportPdfUrl & """ class=""ewExportLink ewPdf"" title=""" & ew_HtmlEncode(Language.Phrase("ExportToPDFText")) & """ data-caption=""" & ew_HtmlEncode(Language.Phrase("ExportToPDFText")) & """>" & Language.Phrase("ExportToPDF") & "</a>"
		End If
		item.Visible = False

		' Export to Email
		ExportOptions.Add("email")
		Set item = ExportOptions.GetItem("email")
		url = ew_IIf(ExportEmailCustom, ",url:'" & PageUrl & "export=email&amp;custom=1'", "")
		item.Body = "<button id=""emf_sysadmin"" class=""ewExportLink ewEmail"" title=""" & Language.Phrase("ExportToEmailText") & """ data-caption=""" & Language.Phrase("ExportToEmailText") & """ onclick=""ew_EmailDialogShow({lnk:'emf_sysadmin',hdr:ewLanguage.Phrase('ExportToEmailText'),f:document.fsysadminlist,sel:false" & url & "});"">" & Language.Phrase("ExportToEmail") & "</button>"
		item.Visible = False

		' Drop down button for export
		ExportOptions.UseButtonGroup = True
		ExportOptions.UseImageAndText = True
		ExportOptions.UseDropDownButton = False
		If ExportOptions.UseButtonGroup And ew_IsMobile() Then
			ExportOptions.UseDropDownButton = True
		End If
		ExportOptions.DropDownButtonPhrase = Language.Phrase("ButtonExport")

		' Add group option item
		ExportOptions.Add(ExportOptions.GroupOptionName)
		Set item = ExportOptions.GetItem(ExportOptions.GroupOptionName)
		item.Body = ""
		item.Visible = False
	End Sub

	' -----------------------------------------------------------------
	' Export data in HTML/CSV/Word/Excel/XML/Email format
	'
	Sub ExportData()
		Dim XmlDoc
		Dim Doc, ExportStyle

		' Default export style
		ExportStyle = "h"

		' Load recordset
		Set Rs = LoadRecordset()
		TotalRecs = Rs.RecordCount
		StartRec = 1

		' Export all
		If sysadmin.ExportAll Then
			StopRec = TotalRecs

			' Set script timeout
			If EW_EXPORT_ALL_TIME_LIMIT > 0 Then
				Server.ScriptTimeout = EW_EXPORT_ALL_TIME_LIMIT
			End If

		' Export 1 page only
		Else
			SetUpStartRec() ' Set Up Start Record Position

			' Set the last record to display
			If DisplayRecs <= 0 Then
				StopRec = TotalRecs
			Else
				StopRec = StartRec + DisplayRecs - 1
			End If
		End If
		If sysadmin.Export = "xml" Then
			Set XmlDoc = New cXMLDocument
		Else
			Set sysadmin.ExportDoc = New cExportDocument
			Set Doc = sysadmin.ExportDoc
			Set Doc.Table = sysadmin
			Call Doc.ChangeStyle("h")

			' Call Page Exporting server event
			Doc.ExportCustom = (Not Page_Exporting())
		End If
		Dim rsdetail, detailcnt
		Dim ParentTable
		ParentTable = ""
		If sysadmin.Export = "xml" Then
			Call sysadmin.ExportXmlDocument(XmlDoc, (ParentTable <> ""), rs, StartRec, StopRec, "")
		Else
			Dim sHeader
			sHeader = PageHeader
			Call Page_DataRendering(sHeader)
			Doc.Text = Doc.Text & sHeader
			Call sysadmin.ExportDocument(Doc, rs, StartRec, StopRec, "")
			Dim sFooter
			sFooter = PageFooter
			Call Page_DataRendered(sFooter)
			Doc.Text = Doc.Text & sFooter
		End If

		' Close recordset and connection
		Rs.Close
		Set Rs = Nothing

		' Export header and footer
		If sysadmin.Export <> "xml" Then
			Call Doc.ExportHeaderAndFooter()

			' Call Page Exported server event
			Call Page_Exported()
		End If
		If sysadmin.Export = "xml" Then
			XmlDoc.Output
			Set XmlDoc = Nothing
		Else
			If sysadmin.Export = "email" Then
				Response.Write ExportEmail(Doc.Text)
			ElseIf sysadmin.Export = "pdf" Then
				Call ExportPdf(Doc.Text)
			Else
				Response.Write Doc.Text
			End If
			Set Doc = Nothing
		End If
	End Sub

	' Export to EXCEL
	Sub ExportExcel(html)
		Response.ContentType = "application/vnd.ms-excel" & ew_IIf(EW_CHARSET <> "", ";charset=" & EW_CHARSET, "")
		Response.AddHeader "Content-Disposition", "attachment; filename=" & gsExportFile & ".xls"

		' Replace images in custom template to hyperlinks
		Dim i, matches, submatches, submatches1, src, name
		If ew_RegExMatch("<img([^>]*)>", html, matches) Then
			For i = 0 to matches.Count - 1
				If ew_RegExMatch("\s+src\s*=\s*[\'""]([\s\S]*?)[\'""]", matches(i).SubMatches(0), submatches) Then ' Match src='src'
					src = submatches(0).SubMatches(0)
					If ew_RegExMatch("\s+data-name\s*=\s*[\'""]([\s\S]*?)[\'""]", matches(i).SubMatches(0), submatches1) Then ' Match data-name='name'
						name = submatches1(0).SubMatches(0)
					Else
						name = src
					End If
					html = Replace(html, matches(i), "<a class=""ewExportLink"" href=""" & ew_ConvertFullUrl(src) & """>" & name & "</a>")
				End If
			Next
		End If
		Response.Write html
	End Sub

	' Export to WORD
	Sub ExportWord(html)
		Response.ContentType = "application/vnd.ms-word" & ew_IIf(EW_CHARSET <> "", ";charset=" & EW_CHARSET, "")
		Response.AddHeader "Content-Disposition", "attachment; filename=" & gsExportFile & ".doc"

		' Replace images in custom template to hyperlinks
		Dim i, matches, submatches, submatches1, src, name
		If ew_RegExMatch("<img([^>]*)>", html, matches) Then
			For i = 0 to matches.Count - 1
				If ew_RegExMatch("\s+src\s*=\s*[\'""]([\s\S]*?)[\'""]", matches(i).SubMatches(0), submatches) Then ' Match src='src'
					src = submatches(0).SubMatches(0)
					If ew_RegExMatch("\s+data-name\s*=\s*[\'""]([\s\S]*?)[\'""]", matches(i).SubMatches(0), submatches1) Then ' Match data-name='name'
						name = submatches1(0).SubMatches(0)
					Else
						name = src
					End If
					html = Replace(html, matches(i), "<a class=""ewExportLink"" href=""" & ew_ConvertFullUrl(src) & """>" & name & "</a>")
				End If
			Next
		End If
		Response.Write html
	End Sub

	' Set up Breadcrumb
	Sub SetupBreadcrumb()
		Dim PageId, url
		Set Breadcrumb = New cBreadcrumb
		url = Mid(ew_CurrentUrl, InStrRev(ew_CurrentUrl, "/")+1)
		url = ew_RegExReplace("\?cmd=reset(all){0,1}$", url, "") ' Remove cmd=reset / cmd=resetall
		Call Breadcrumb.Add("list", sysadmin.TableVar, url, "", sysadmin.TableVar, True)
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

	' Form Custom Validate event
	Function Form_CustomValidate(CustomError)

		'Return error message in CustomError
		Form_CustomValidate = True
	End Function

	' ListOptions Load event
	Sub ListOptions_Load()

		'Example: 
		' Dim opt
		' Set opt = ListOptions.Add("new")
		' opt.OnLeft = True ' Link on left
		' opt.MoveTo 0 ' Move to first column

	End Sub

	' ListOptions Rendered event
	Sub ListOptions_Rendered()

		'Example: 
		'ListOptions.GetItem("new").Body = "xxx"

	End Sub

	' Row Custom Action event
	Function Row_CustomAction(action, rs)

		' Return False to abort
		Row_CustomAction = True
	End Function

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
