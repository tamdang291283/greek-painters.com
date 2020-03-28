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
Dim MenuDishproperties_list
Set MenuDishproperties_list = New cMenuDishproperties_list
Set Page = MenuDishproperties_list

' Page init processing
MenuDishproperties_list.Page_Init()

' Page main processing
MenuDishproperties_list.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
MenuDishproperties_list.Page_Render()
%>
<!--#include file="header.asp"-->
<% If MenuDishproperties.Export = "" Then %>
<script type="text/javascript">
// Page object
var MenuDishproperties_list = new ew_Page("MenuDishproperties_list");
MenuDishproperties_list.PageID = "list"; // Page ID
var EW_PAGE_ID = MenuDishproperties_list.PageID; // For backward compatibility
// Form object
var fMenuDishpropertieslist = new ew_Form("fMenuDishpropertieslist");
fMenuDishpropertieslist.FormKeyCountName = '<%= MenuDishproperties_list.FormKeyCountName %>';
// Form_CustomValidate event
fMenuDishpropertieslist.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fMenuDishpropertieslist.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fMenuDishpropertieslist.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
var fMenuDishpropertieslistsrch = new ew_Form("fMenuDishpropertieslistsrch");
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
<% If MenuDishproperties.Export = "" Then %>
<div class="ewToolbar">
<% If MenuDishproperties.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If MenuDishproperties_list.TotalRecs > 0 And MenuDishproperties_list.ExportOptions.Visible Then %>
<% MenuDishproperties_list.ExportOptions.Render "body", "", "", "", "", "" %>
<% End If %>
<% If MenuDishproperties_list.SearchOptions.Visible Then %>
<% MenuDishproperties_list.SearchOptions.Render "body", "", "", "", "", "" %>
<% End If %>
<% If MenuDishproperties.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% End If %>
<% If (MenuDishproperties.Export = "") Or (EW_EXPORT_MASTER_RECORD And MenuDishproperties.Export = "print") Then %>
<% End If %>
<%

' Load recordset
'Set MenuDishproperties_list.Recordset = MenuDishproperties_list.LoadRecordset()

	MenuDishproperties_list.TotalRecs = MenuDishproperties_list.Recordset.RecordCount
	MenuDishproperties_list.StartRec = 1
	If MenuDishproperties_list.DisplayRecs <= 0 Then ' Display all records
		MenuDishproperties_list.DisplayRecs = MenuDishproperties_list.TotalRecs
	End If
	If Not (MenuDishproperties.ExportAll And MenuDishproperties.Export <> "") Then
		MenuDishproperties_list.SetUpStartRec() ' Set up start record position
	End If

	' Set no record found message
	If MenuDishproperties.CurrentAction = "" And MenuDishproperties_list.TotalRecs = 0 Then
		If MenuDishproperties_list.SearchWhere = "0=101" Then
			MenuDishproperties_list.WarningMessage = Language.Phrase("EnterSearchCriteria")
		Else
			MenuDishproperties_list.WarningMessage = Language.Phrase("NoRecord")
		End If
	End If
MenuDishproperties_list.RenderOtherOptions()
%>
<% If MenuDishproperties.Export = "" And MenuDishproperties.CurrentAction = "" Then %>
<form name="fMenuDishpropertieslistsrch" id="fMenuDishpropertieslistsrch" class="form-inline ewForm" action="<%= ew_CurrentPage %>">
<% SearchPanelClass = ew_IIf(MenuDishproperties_list.SearchWhere <> "", " in", " in") %>
<div id="fMenuDishpropertieslistsrch_SearchPanel" class="ewSearchPanel collapse<%= SearchPanelClass %>">
<input type="hidden" name="cmd" value="search">
<input type="hidden" name="t" value="MenuDishproperties">
	<div class="ewBasicSearch">
<div id="xsr_1" class="ewRow">
	<div class="ewQuickSearch input-group">
	<input type="text" name="<%= EW_TABLE_BASIC_SEARCH %>" id="<%= EW_TABLE_BASIC_SEARCH %>" class="form-control" value="<%= ew_HtmlEncode(MenuDishproperties.BasicSearch.getKeyword()) %>" placeholder="<%= ew_HtmlEncode(Language.Phrase("Search")) %>">
	<input type="hidden" name="<%= EW_TABLE_BASIC_SEARCH_TYPE %>" id="<%= EW_TABLE_BASIC_SEARCH_TYPE %>" value="<%= ew_HtmlEncode(MenuDishproperties.BasicSearch.getSearchType()) %>">
	<div class="input-group-btn">
		<button type="button" data-toggle="dropdown" class="btn btn-default"><span id="searchtype"><%= MenuDishproperties.BasicSearch.getSearchTypeNameShort() %></span><span class="caret"></span></button>
		<ul class="dropdown-menu pull-right" role="menu">
			<li<% If MenuDishproperties.BasicSearch.getSearchType() = "" Then Response.Write " class=""active""" %>><a href="javascript:void(0);" onclick="ew_SetSearchType(this)"><%= Language.Phrase("QuickSearchAuto") %></a></li>
			<li<% If MenuDishproperties.BasicSearch.getSearchType() = "=" Then Response.Write " class=""active""" %>><a href="javascript:void(0);" onclick="ew_SetSearchType(this,'=')"><%= Language.Phrase("QuickSearchExact") %></a></li>
			<li<% If MenuDishproperties.BasicSearch.getSearchType() = "AND" Then Response.Write " class=""active""" %>><a href="javascript:void(0);" onclick="ew_SetSearchType(this,'AND')"><%= Language.Phrase("QuickSearchAll") %></a></li>
			<li<% If MenuDishproperties.BasicSearch.getSearchType() = "OR" Then Response.Write " class=""active""" %>><a href="javascript:void(0);" onclick="ew_SetSearchType(this,'OR')"><%= Language.Phrase("QuickSearchAny") %></a></li>
		</ul>
	<button class="btn btn-primary ewButton" name="btnsubmit" id="btnsubmit" type="submit"><%= Language.Phrase("QuickSearchBtn") %></button>
	</div>
	</div>
</div>
	</div>
</div>
</form>
<% End If %>
<% MenuDishproperties_list.ShowPageHeader() %>
<% MenuDishproperties_list.ShowMessage %>
<% If MenuDishproperties_list.TotalRecs > 0 Or MenuDishproperties.CurrentAction <> "" Then %>
<div class="ewGrid">
<% If MenuDishproperties.Export = "" Then %>
<div class="ewGridUpperPanel">
<% If MenuDishproperties.CurrentAction <> "gridadd" And MenuDishproperties.CurrentAction <> "gridedit" Then %>
<form name="ewPagerForm" class="form-inline ewForm ewPagerForm" action="<%= ew_CurrentPage %>">
<% If Not IsObject(MenuDishproperties_list.Pager) Then Set MenuDishproperties_list.Pager = ew_NewPrevNextPager(MenuDishproperties_list.StartRec, MenuDishproperties_list.DisplayRecs, MenuDishproperties_list.TotalRecs) %>
<% If MenuDishproperties_list.Pager.RecordCount > 0 Then %>
<div class="ewPager">
<span><%= Language.Phrase("Page") %>&nbsp;</span>
<div class="ewPrevNext"><div class="input-group">
<div class="input-group-btn">
<!--first page button-->
	<% If MenuDishproperties_list.Pager.FirstButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerFirst") %>" href="<%= MenuDishproperties_list.PageUrl %>start=<%= MenuDishproperties_list.Pager.FirstButton.Start %>"><span class="icon-first ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerFirst") %>"><span class="icon-first ewIcon"></span></a>
	<% End If %>
<!--previous page button-->
	<% If MenuDishproperties_list.Pager.PrevButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerPrevious") %>" href="<%= MenuDishproperties_list.PageUrl %>start=<%= MenuDishproperties_list.Pager.PrevButton.Start %>"><span class="icon-prev ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerPrevious") %>"><span class="icon-prev ewIcon"></span></a>
	<% End If %>
</div>
<!--current page number-->
	<input class="form-control input-sm" type="text" name="<%= EW_TABLE_PAGE_NO %>" value="<%= MenuDishproperties_list.Pager.CurrentPage %>">
<div class="input-group-btn">
<!--next page button-->
	<% If MenuDishproperties_list.Pager.NextButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerNext") %>" href="<%= MenuDishproperties_list.PageUrl %>start=<%= MenuDishproperties_list.Pager.NextButton.Start %>"><span class="icon-next ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerNext") %>"><span class="icon-next ewIcon"></span></a>
	<% End If %>
<!--last page button-->
	<% If MenuDishproperties_list.Pager.LastButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerLast") %>" href="<%= MenuDishproperties_list.PageUrl %>start=<%= MenuDishproperties_list.Pager.LastButton.Start %>"><span class="icon-last ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerLast") %>"><span class="icon-last ewIcon"></span></a>
	<% End If %>
</div>
</div>
</div>
<span>&nbsp;<%= Language.Phrase("of") %>&nbsp;<%= MenuDishproperties_list.Pager.PageCount %></span>
</div>
<div class="ewPager ewRec">
	<span><%= Language.Phrase("Record") %>&nbsp;<%= MenuDishproperties_list.Pager.FromIndex %>&nbsp;<%= Language.Phrase("To") %>&nbsp;<%= MenuDishproperties_list.Pager.ToIndex %>&nbsp;<%= Language.Phrase("Of") %>&nbsp;<%= MenuDishproperties_list.Pager.RecordCount %></span>
</div>
<% End If %>
<% If MenuDishproperties_list.TotalRecs > 0 Then %>
<div class="ewPager">
<input type="hidden" name="t" value="MenuDishproperties">
<select name="<%= EW_TABLE_REC_PER_PAGE %>" class="form-control input-sm" onchange="this.form.submit();">
<option value="20"<% If MenuDishproperties_list.DisplayRecs = 20 Then %> selected="selected"<% End If %>>20</option>
<option value="50"<% If MenuDishproperties_list.DisplayRecs = 50 Then %> selected="selected"<% End If %>>50</option>
<option value="100"<% If MenuDishproperties_list.DisplayRecs = 100 Then %> selected="selected"<% End If %>>100</option>
<option value="500"<% If MenuDishproperties_list.DisplayRecs = 500 Then %> selected="selected"<% End If %>>500</option>
<option value="1000"<% If MenuDishproperties_list.DisplayRecs = 1000 Then %> selected="selected"<% End If %>>1000</option>
<option value="ALL"<% If MenuDishproperties.RecordsPerPage = -1 Then %> selected="selected"<% End If %>><%= Language.Phrase("AllRecords") %></option>
</select>
</div>
<% End If %>
</form>
<% End If %>
<div class="ewListOtherOptions">
<%
	MenuDishproperties_list.AddEditOptions.Render "body", "", "", "", "", ""
	MenuDishproperties_list.DetailOptions.Render "body", "", "", "", "", ""
	MenuDishproperties_list.ActionOptions.Render "body", "", "", "", "", ""
%>
</div>
<div class="clearfix"></div>
</div>
<% End If %>
<form name="fMenuDishpropertieslist" id="fMenuDishpropertieslist" class="form-inline ewForm ewListForm" action="<%= ew_CurrentPage %>" method="post">
<% If MenuDishproperties_list.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= MenuDishproperties_list.Token %>">
<% End If %>
<input type="hidden" name="t" value="MenuDishproperties">
<div id="gmp_MenuDishproperties" class="<% If ew_IsResponsiveLayout() Then Response.Write "table-responsive " %>ewGridMiddlePanel">
<% If MenuDishproperties_list.TotalRecs > 0 Then %>
<table id="tbl_MenuDishpropertieslist" class="table ewTable">
<%= MenuDishproperties.TableCustomInnerHtml %>
<thead><!-- Table header -->
	<tr class="ewTableHeader">
<%

' Header row
MenuDishproperties.RowType = EW_ROWTYPE_HEADER
Call MenuDishproperties_list.RenderListOptions()

' Render list options (header, left)
MenuDishproperties_list.ListOptions.Render "header", "left", "", "", "", ""
%>
<% If MenuDishproperties.ID.Visible Then ' ID %>
	<% If MenuDishproperties.SortUrl(MenuDishproperties.ID) = "" Then %>
		<th data-name="ID"><div id="elh_MenuDishproperties_ID" class="MenuDishproperties_ID"><div class="ewTableHeaderCaption"><%= MenuDishproperties.ID.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="ID"><div class="ewPointer" onclick="ew_Sort(event,'<%= MenuDishproperties.SortUrl(MenuDishproperties.ID) %>',1);"><div id="elh_MenuDishproperties_ID" class="MenuDishproperties_ID">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= MenuDishproperties.ID.FldCaption %></span><span class="ewTableHeaderSort"><% If MenuDishproperties.ID.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf MenuDishproperties.ID.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If MenuDishproperties.dishproperty.Visible Then ' dishproperty %>
	<% If MenuDishproperties.SortUrl(MenuDishproperties.dishproperty) = "" Then %>
		<th data-name="dishproperty"><div id="elh_MenuDishproperties_dishproperty" class="MenuDishproperties_dishproperty"><div class="ewTableHeaderCaption"><%= MenuDishproperties.dishproperty.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="dishproperty"><div class="ewPointer" onclick="ew_Sort(event,'<%= MenuDishproperties.SortUrl(MenuDishproperties.dishproperty) %>',1);"><div id="elh_MenuDishproperties_dishproperty" class="MenuDishproperties_dishproperty">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= MenuDishproperties.dishproperty.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If MenuDishproperties.dishproperty.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf MenuDishproperties.dishproperty.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If MenuDishproperties.dishpropertyprice.Visible Then ' dishpropertyprice %>
	<% If MenuDishproperties.SortUrl(MenuDishproperties.dishpropertyprice) = "" Then %>
		<th data-name="dishpropertyprice"><div id="elh_MenuDishproperties_dishpropertyprice" class="MenuDishproperties_dishpropertyprice"><div class="ewTableHeaderCaption"><%= MenuDishproperties.dishpropertyprice.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="dishpropertyprice"><div class="ewPointer" onclick="ew_Sort(event,'<%= MenuDishproperties.SortUrl(MenuDishproperties.dishpropertyprice) %>',1);"><div id="elh_MenuDishproperties_dishpropertyprice" class="MenuDishproperties_dishpropertyprice">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= MenuDishproperties.dishpropertyprice.FldCaption %></span><span class="ewTableHeaderSort"><% If MenuDishproperties.dishpropertyprice.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf MenuDishproperties.dishpropertyprice.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If MenuDishproperties.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
	<% If MenuDishproperties.SortUrl(MenuDishproperties.IdBusinessDetail) = "" Then %>
		<th data-name="IdBusinessDetail"><div id="elh_MenuDishproperties_IdBusinessDetail" class="MenuDishproperties_IdBusinessDetail"><div class="ewTableHeaderCaption"><%= MenuDishproperties.IdBusinessDetail.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="IdBusinessDetail"><div class="ewPointer" onclick="ew_Sort(event,'<%= MenuDishproperties.SortUrl(MenuDishproperties.IdBusinessDetail) %>',1);"><div id="elh_MenuDishproperties_IdBusinessDetail" class="MenuDishproperties_IdBusinessDetail">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= MenuDishproperties.IdBusinessDetail.FldCaption %></span><span class="ewTableHeaderSort"><% If MenuDishproperties.IdBusinessDetail.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf MenuDishproperties.IdBusinessDetail.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If MenuDishproperties.dishpropertygroupid.Visible Then ' dishpropertygroupid %>
	<% If MenuDishproperties.SortUrl(MenuDishproperties.dishpropertygroupid) = "" Then %>
		<th data-name="dishpropertygroupid"><div id="elh_MenuDishproperties_dishpropertygroupid" class="MenuDishproperties_dishpropertygroupid"><div class="ewTableHeaderCaption"><%= MenuDishproperties.dishpropertygroupid.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="dishpropertygroupid"><div class="ewPointer" onclick="ew_Sort(event,'<%= MenuDishproperties.SortUrl(MenuDishproperties.dishpropertygroupid) %>',1);"><div id="elh_MenuDishproperties_dishpropertygroupid" class="MenuDishproperties_dishpropertygroupid">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= MenuDishproperties.dishpropertygroupid.FldCaption %></span><span class="ewTableHeaderSort"><% If MenuDishproperties.dishpropertygroupid.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf MenuDishproperties.dishpropertygroupid.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If MenuDishproperties.printingname.Visible Then ' printingname %>
	<% If MenuDishproperties.SortUrl(MenuDishproperties.printingname) = "" Then %>
		<th data-name="printingname"><div id="elh_MenuDishproperties_printingname" class="MenuDishproperties_printingname"><div class="ewTableHeaderCaption"><%= MenuDishproperties.printingname.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="printingname"><div class="ewPointer" onclick="ew_Sort(event,'<%= MenuDishproperties.SortUrl(MenuDishproperties.printingname) %>',1);"><div id="elh_MenuDishproperties_printingname" class="MenuDishproperties_printingname">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= MenuDishproperties.printingname.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If MenuDishproperties.printingname.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf MenuDishproperties.printingname.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If MenuDishproperties.i_displaySort.Visible Then ' i_displaySort %>
	<% If MenuDishproperties.SortUrl(MenuDishproperties.i_displaySort) = "" Then %>
		<th data-name="i_displaySort"><div id="elh_MenuDishproperties_i_displaySort" class="MenuDishproperties_i_displaySort"><div class="ewTableHeaderCaption"><%= MenuDishproperties.i_displaySort.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="i_displaySort"><div class="ewPointer" onclick="ew_Sort(event,'<%= MenuDishproperties.SortUrl(MenuDishproperties.i_displaySort) %>',1);"><div id="elh_MenuDishproperties_i_displaySort" class="MenuDishproperties_i_displaySort">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= MenuDishproperties.i_displaySort.FldCaption %></span><span class="ewTableHeaderSort"><% If MenuDishproperties.i_displaySort.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf MenuDishproperties.i_displaySort.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<%

' Render list options (header, right)
MenuDishproperties_list.ListOptions.Render "header", "right", "", "", "", ""
%>
	</tr>
</thead>
<tbody><!-- Table body -->
<%
If (MenuDishproperties.ExportAll And MenuDishproperties.Export <> "") Then
	MenuDishproperties_list.StopRec = MenuDishproperties_list.TotalRecs
Else

	' Set the last record to display
	If MenuDishproperties_list.TotalRecs > MenuDishproperties_list.StartRec + MenuDishproperties_list.DisplayRecs - 1 Then
		MenuDishproperties_list.StopRec = MenuDishproperties_list.StartRec + MenuDishproperties_list.DisplayRecs - 1
	Else
		MenuDishproperties_list.StopRec = MenuDishproperties_list.TotalRecs
	End If
End If

' Move to first record
MenuDishproperties_list.RecCnt = MenuDishproperties_list.StartRec - 1
If Not MenuDishproperties_list.Recordset.Eof Then
	MenuDishproperties_list.Recordset.MoveFirst
	If MenuDishproperties_list.StartRec > 1 Then MenuDishproperties_list.Recordset.Move MenuDishproperties_list.StartRec - 1
ElseIf Not MenuDishproperties.AllowAddDeleteRow And MenuDishproperties_list.StopRec = 0 Then
	MenuDishproperties_list.StopRec = MenuDishproperties.GridAddRowCount
End If

' Initialize Aggregate
MenuDishproperties.RowType = EW_ROWTYPE_AGGREGATEINIT
Call MenuDishproperties.ResetAttrs()
Call MenuDishproperties_list.RenderRow()
MenuDishproperties_list.RowCnt = 0

' Output date rows
Do While CLng(MenuDishproperties_list.RecCnt) < CLng(MenuDishproperties_list.StopRec)
	MenuDishproperties_list.RecCnt = MenuDishproperties_list.RecCnt + 1
	If CLng(MenuDishproperties_list.RecCnt) >= CLng(MenuDishproperties_list.StartRec) Then
		MenuDishproperties_list.RowCnt = MenuDishproperties_list.RowCnt + 1

	' Set up key count
	MenuDishproperties_list.KeyCount = MenuDishproperties_list.RowIndex
	Call MenuDishproperties.ResetAttrs()
	MenuDishproperties.CssClass = ""
	If MenuDishproperties.CurrentAction = "gridadd" Then
	Else
		Call MenuDishproperties_list.LoadRowValues(MenuDishproperties_list.Recordset) ' Load row values
	End If
	MenuDishproperties.RowType = EW_ROWTYPE_VIEW ' Render view

	' Set up row id / data-rowindex
	MenuDishproperties.RowAttrs.AddAttributes Array(Array("data-rowindex", MenuDishproperties_list.RowCnt), Array("id", "r" & MenuDishproperties_list.RowCnt & "_MenuDishproperties"), Array("data-rowtype", MenuDishproperties.RowType))

	' Render row
	Call MenuDishproperties_list.RenderRow()

	' Render list options
	Call MenuDishproperties_list.RenderListOptions()
%>
	<tr<%= MenuDishproperties.RowAttributes %>>
<%

' Render list options (body, left)
MenuDishproperties_list.ListOptions.Render "body", "left", MenuDishproperties_list.RowCnt, "", "", ""
%>
	<% If MenuDishproperties.ID.Visible Then ' ID %>
		<td data-name="ID"<%= MenuDishproperties.ID.CellAttributes %>>
<span<%= MenuDishproperties.ID.ViewAttributes %>>
<%= MenuDishproperties.ID.ListViewValue %>
</span>
<a id="<%= MenuDishproperties_list.PageObjName & "_row_" & MenuDishproperties_list.RowCnt %>"></a></td>
	<% End If %>
	<% If MenuDishproperties.dishproperty.Visible Then ' dishproperty %>
		<td data-name="dishproperty"<%= MenuDishproperties.dishproperty.CellAttributes %>>
<span<%= MenuDishproperties.dishproperty.ViewAttributes %>>
<%= MenuDishproperties.dishproperty.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If MenuDishproperties.dishpropertyprice.Visible Then ' dishpropertyprice %>
		<td data-name="dishpropertyprice"<%= MenuDishproperties.dishpropertyprice.CellAttributes %>>
<span<%= MenuDishproperties.dishpropertyprice.ViewAttributes %>>
<%= MenuDishproperties.dishpropertyprice.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If MenuDishproperties.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
		<td data-name="IdBusinessDetail"<%= MenuDishproperties.IdBusinessDetail.CellAttributes %>>
<span<%= MenuDishproperties.IdBusinessDetail.ViewAttributes %>>
<%= MenuDishproperties.IdBusinessDetail.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If MenuDishproperties.dishpropertygroupid.Visible Then ' dishpropertygroupid %>
		<td data-name="dishpropertygroupid"<%= MenuDishproperties.dishpropertygroupid.CellAttributes %>>
<span<%= MenuDishproperties.dishpropertygroupid.ViewAttributes %>>
<%= MenuDishproperties.dishpropertygroupid.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If MenuDishproperties.printingname.Visible Then ' printingname %>
		<td data-name="printingname"<%= MenuDishproperties.printingname.CellAttributes %>>
<span<%= MenuDishproperties.printingname.ViewAttributes %>>
<%= MenuDishproperties.printingname.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If MenuDishproperties.i_displaySort.Visible Then ' i_displaySort %>
		<td data-name="i_displaySort"<%= MenuDishproperties.i_displaySort.CellAttributes %>>
<span<%= MenuDishproperties.i_displaySort.ViewAttributes %>>
<%= MenuDishproperties.i_displaySort.ListViewValue %>
</span>
</td>
	<% End If %>
<%

' Render list options (body, right)
MenuDishproperties_list.ListOptions.Render "body", "right", MenuDishproperties_list.RowCnt, "", "", ""
%>
	</tr>
<%
	End If
	If MenuDishproperties.CurrentAction <> "gridadd" Then
		MenuDishproperties_list.Recordset.MoveNext()
	End If
Loop
%>
</tbody>
</table>
<% End If %>
<% If MenuDishproperties.CurrentAction = "" Then %>
<input type="hidden" name="a_list" id="a_list" value="">
<% End If %>
</div>
</form>
<%

' Close recordset and connection
MenuDishproperties_list.Recordset.Close
Set MenuDishproperties_list.Recordset = Nothing
%>
<% If MenuDishproperties.Export = "" Then %>
<div class="ewGridLowerPanel">
<% If MenuDishproperties.CurrentAction <> "gridadd" And MenuDishproperties.CurrentAction <> "gridedit" Then %>
<form name="ewPagerForm" class="ewForm form-inline ewPagerForm" action="<%= ew_CurrentPage %>">
<% If Not IsObject(MenuDishproperties_list.Pager) Then Set MenuDishproperties_list.Pager = ew_NewPrevNextPager(MenuDishproperties_list.StartRec, MenuDishproperties_list.DisplayRecs, MenuDishproperties_list.TotalRecs) %>
<% If MenuDishproperties_list.Pager.RecordCount > 0 Then %>
<div class="ewPager">
<span><%= Language.Phrase("Page") %>&nbsp;</span>
<div class="ewPrevNext"><div class="input-group">
<div class="input-group-btn">
<!--first page button-->
	<% If MenuDishproperties_list.Pager.FirstButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerFirst") %>" href="<%= MenuDishproperties_list.PageUrl %>start=<%= MenuDishproperties_list.Pager.FirstButton.Start %>"><span class="icon-first ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerFirst") %>"><span class="icon-first ewIcon"></span></a>
	<% End If %>
<!--previous page button-->
	<% If MenuDishproperties_list.Pager.PrevButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerPrevious") %>" href="<%= MenuDishproperties_list.PageUrl %>start=<%= MenuDishproperties_list.Pager.PrevButton.Start %>"><span class="icon-prev ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerPrevious") %>"><span class="icon-prev ewIcon"></span></a>
	<% End If %>
</div>
<!--current page number-->
	<input class="form-control input-sm" type="text" name="<%= EW_TABLE_PAGE_NO %>" value="<%= MenuDishproperties_list.Pager.CurrentPage %>">
<div class="input-group-btn">
<!--next page button-->
	<% If MenuDishproperties_list.Pager.NextButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerNext") %>" href="<%= MenuDishproperties_list.PageUrl %>start=<%= MenuDishproperties_list.Pager.NextButton.Start %>"><span class="icon-next ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerNext") %>"><span class="icon-next ewIcon"></span></a>
	<% End If %>
<!--last page button-->
	<% If MenuDishproperties_list.Pager.LastButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerLast") %>" href="<%= MenuDishproperties_list.PageUrl %>start=<%= MenuDishproperties_list.Pager.LastButton.Start %>"><span class="icon-last ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerLast") %>"><span class="icon-last ewIcon"></span></a>
	<% End If %>
</div>
</div>
</div>
<span>&nbsp;<%= Language.Phrase("of") %>&nbsp;<%= MenuDishproperties_list.Pager.PageCount %></span>
</div>
<div class="ewPager ewRec">
	<span><%= Language.Phrase("Record") %>&nbsp;<%= MenuDishproperties_list.Pager.FromIndex %>&nbsp;<%= Language.Phrase("To") %>&nbsp;<%= MenuDishproperties_list.Pager.ToIndex %>&nbsp;<%= Language.Phrase("Of") %>&nbsp;<%= MenuDishproperties_list.Pager.RecordCount %></span>
</div>
<% End If %>
<% If MenuDishproperties_list.TotalRecs > 0 Then %>
<div class="ewPager">
<input type="hidden" name="t" value="MenuDishproperties">
<select name="<%= EW_TABLE_REC_PER_PAGE %>" class="form-control input-sm" onchange="this.form.submit();">
<option value="20"<% If MenuDishproperties_list.DisplayRecs = 20 Then %> selected="selected"<% End If %>>20</option>
<option value="50"<% If MenuDishproperties_list.DisplayRecs = 50 Then %> selected="selected"<% End If %>>50</option>
<option value="100"<% If MenuDishproperties_list.DisplayRecs = 100 Then %> selected="selected"<% End If %>>100</option>
<option value="500"<% If MenuDishproperties_list.DisplayRecs = 500 Then %> selected="selected"<% End If %>>500</option>
<option value="1000"<% If MenuDishproperties_list.DisplayRecs = 1000 Then %> selected="selected"<% End If %>>1000</option>
<option value="ALL"<% If MenuDishproperties.RecordsPerPage = -1 Then %> selected="selected"<% End If %>><%= Language.Phrase("AllRecords") %></option>
</select>
</div>
<% End If %>
</form>
<% End If %>
<div class="ewListOtherOptions">
<%
	MenuDishproperties_list.AddEditOptions.Render "body", "bottom", "", "", "", ""
	MenuDishproperties_list.DetailOptions.Render "body", "bottom", "", "", "", ""
	MenuDishproperties_list.ActionOptions.Render "body", "bottom", "", "", "", ""
%>
</div>
<div class="clearfix"></div>
</div>
<% End If %>
</div>
<% End If %>
<% If MenuDishproperties_list.TotalRecs = 0 And MenuDishproperties.CurrentAction = "" Then ' Show other options %>
<div class="ewListOtherOptions">
<%
	MenuDishproperties_list.AddEditOptions.Render "body", "", "", "", "", ""
	MenuDishproperties_list.DetailOptions.Render "body", "", "", "", "", ""
	MenuDishproperties_list.ActionOptions.Render "body", "", "", "", "", ""
%>
</div>
<div class="clearfix"></div>
<% End If %>
<% If MenuDishproperties.Export <> "" Then %>
<script type="text/javascript">
ew_ApplyTemplate("body", "", "MenuDishpropertieslist", "<%= MenuDishproperties.CustomExport %>");
</script>
<% End If %>
<% If MenuDishproperties.Export = "" Then %>
<script type="text/javascript">
fMenuDishpropertieslistsrch.Init();
fMenuDishpropertieslist.Init();
</script>
<% End If %>
<%
MenuDishproperties_list.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<% If MenuDishproperties.Export = "" Then %>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<% End If %>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set MenuDishproperties_list = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cMenuDishproperties_list

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
		TableName = "MenuDishproperties"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "MenuDishproperties_list"
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
		If MenuDishproperties.UseTokenInUrl Then PageUrl = PageUrl & "t=" & MenuDishproperties.TableVar & "&" ' add page token
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

		' Grid form hidden field names
		FormName = "fMenuDishpropertieslist"
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
		If IsEmpty(MenuDishproperties) Then Set MenuDishproperties = New cMenuDishproperties
		Set Table = MenuDishproperties
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
		AddUrl = "MenuDishpropertiesadd.asp"
		InlineAddUrl = PageUrl & "a=add"
		GridAddUrl = PageUrl & "a=gridadd"
		GridEditUrl = PageUrl & "a=gridedit"
		MultiDeleteUrl = "MenuDishpropertiesdelete.asp"
		MultiUpdateUrl = "MenuDishpropertiesupdate.asp"

		' Initialize form object
		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "list"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "MenuDishproperties"

		' Open connection to the database
		If IsEmpty(Conn) Then Call ew_Connect()

		' List options
		Set ListOptions = New cListOptions
		ListOptions.TableVar = MenuDishproperties.TableVar

		' Export options
		Set ExportOptions = New cListOptions
		ExportOptions.TableVar = MenuDishproperties.TableVar
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

		' Get export parameters
		Dim custom
		custom = ""
		If Request.QueryString("export").Count > 0 Then
			MenuDishproperties.Export = Request.QueryString("export")
			custom = Request.QueryString("custom") & ""
		ElseIf ew_IsHttpPost() Then
			If Request.Form("export").Count > 0 Then
				MenuDishproperties.Export = Request.Form("export")
				custom = Request.Form("custom") & ""
			ElseIf Request.Form("exporttype").Count > 0 Then
				MenuDishproperties.Export = Request.Form("exporttype")
				custom = Request.Form("custom") & ""
			End If
		Else
			MenuDishproperties.ExportReturnUrl = ew_CurrentUrl()
		End If
		gsExportFile = MenuDishproperties.TableVar ' Get export file, used in header
		Dim Charset ' Charset used in header
		If EW_CHARSET <> "" Then
			Charset = ";charset=" & EW_CHARSET
		Else
			Charset = ""
		End If

		' Get custom export parameters
		If MenuDishproperties.Export <> "" And custom <> "" Then
			MenuDishproperties.CustomExport = MenuDishproperties.Export
			MenuDishproperties.Export = "print"
		End If
		gsCustomExport = MenuDishproperties.CustomExport
		gsExport = MenuDishproperties.Export ' Get export parameter, used in header

		' Custom export (post back from ew_ApplyTemplate), export and terminate page
		If Request.Form("customexport").Count > 0 Then
			MenuDishproperties.CustomExport = Request.Form("customexport")
			MenuDishproperties.Export = MenuDishproperties.CustomExport
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
		If MenuDishproperties.Export = "excel" Then
			Response.ContentType = "application/vnd.ms-excel" & Charset
			Response.AddHeader "Content-Disposition", "attachment; filename=" & gsExportFile & ".xls"
		End If
		If MenuDishproperties.Export = "word" Then
			Response.ContentType = "application/vnd.ms-word" & Charset
			Response.AddHeader "Content-Disposition", "attachment; filename=" & gsExportFile & ".doc"
		End If
		If MenuDishproperties.Export = "csv" Then
			Response.BinaryWrite ChrB(239) & ChrB(187) & ChrB(191)
			Response.ContentType = "application/csv" & Charset
			Response.AddHeader "Content-Disposition", "attachment; filename=" & gsExportFile & ".csv"
		End If

		' Get grid add count
		Dim gridaddcnt
		gridaddcnt = Request.QueryString(EW_TABLE_GRID_ADD_ROW_COUNT)
		If IsNumeric(gridaddcnt) Then
			If gridaddcnt > 0 Then
				MenuDishproperties.GridAddRowCount = gridaddcnt
			End If
		End If

		' Set up list options
		SetupListOptions()

		' Setup export options
		SetupExportOptions()

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

		' Setup other options
		SetupOtherOptions()

		' Set "checkbox" visible
		If UBound(MenuDishproperties.CustomActions.CustomArray) >= 0 Then
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
			If MenuDishproperties.Export = "" Then
				SetupBreadcrumb()
			End If

			' Hide list options
			If MenuDishproperties.Export <> "" Then
				Call ListOptions.HideAllOptions(Array("sequence"))
				ListOptions.UseDropDownButton = False ' Disable drop down button
				ListOptions.UseButtonGroup = False ' Disable button group
			ElseIf MenuDishproperties.CurrentAction = "gridadd" Or MenuDishproperties.CurrentAction = "gridedit" Then
				Call ListOptions.HideAllOptions(Array())
				ListOptions.UseDropDownButton = False ' Disable drop down button
				ListOptions.UseButtonGroup = False ' Disable button group
			End If

			' Hide export options
			If MenuDishproperties.Export <> "" Or MenuDishproperties.CurrentAction <> "" Then
				ExportOptions.HideAllOptions(Array())
			End If

			' Hide other options
			If MenuDishproperties.Export <> "" Then
				AddEditOptions.HideAllOptions(Array())
				DetailOptions.HideAllOptions(Array())
				ActionOptions.HideAllOptions(Array())
			End If

			' Get default search criteria
			Call ew_AddFilter(DefaultSearchWhere, BasicSearchWhere(True))

			' Get basic search values
			Call LoadBasicSearchValues()

			' Restore search parms from Session if not searching / reset / export
			If (MenuDishproperties.Export <> "" Or Command <> "search" And Command <> "reset" And Command <> "resetall") And CheckSearchParms() Then
				Call RestoreSearchParms()
			End If

			' Call Recordset SearchValidated event
			Call MenuDishproperties.Recordset_SearchValidated()

			' Set Up Sorting Order
			SetUpSortOrder()

			' Get basic search criteria
			If gsSearchError = "" Then
				sSrchBasic = BasicSearchWhere(False)
			End If
		End If ' End Validate Request

		' Restore display records
		If MenuDishproperties.RecordsPerPage <> "" Then
			DisplayRecs = MenuDishproperties.RecordsPerPage ' Restore from Session
		Else
			DisplayRecs = 20 ' Load default
		End If

		' Load Sorting Order
		LoadSortOrder()

		' Load search default if no existing search criteria
		If Not CheckSearchParms() Then

			' Load basic search from default
			MenuDishproperties.BasicSearch.Keyword = MenuDishproperties.BasicSearch.KeywordDefault
			MenuDishproperties.BasicSearch.SearchType = MenuDishproperties.BasicSearch.SearchTypeDefault
			MenuDishproperties.BasicSearch.setSearchType(MenuDishproperties.BasicSearch.SearchTypeDefault)
			If MenuDishproperties.BasicSearch.Keyword <> "" Then
				sSrchBasic = BasicSearchWhere(False)
			End If
		End If

		' Build search criteria
		Call ew_AddFilter(SearchWhere, sSrchAdvanced)
		Call ew_AddFilter(SearchWhere, sSrchBasic)

		' Call Recordset Searching event
		Call MenuDishproperties.Recordset_Searching(SearchWhere)

		' Save search criteria
		If Command = "search" And Not RestoreSearch Then
			MenuDishproperties.SearchWhere = SearchWhere ' Save to Session
			StartRec = 1 ' Reset start record counter
			MenuDishproperties.StartRecordNumber = StartRec
		Else
			SearchWhere = MenuDishproperties.SearchWhere
		End If
		sFilter = ""
		Call ew_AddFilter(sFilter, DbDetailFilter)
		Call ew_AddFilter(sFilter, SearchWhere)

		' Set up filter in Session
		MenuDishproperties.SessionWhere = sFilter
		MenuDishproperties.CurrentFilter = ""

		' Export Data only
		If MenuDishproperties.CustomExport = "" And ew_InArray(MenuDishproperties.Export, Array("html","word","excel","xml","csv","email","pdf")) Then
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
			MenuDishproperties.RecordsPerPage = DisplayRecs ' Save to Session

			' Reset start position
			StartRec = 1
			MenuDishproperties.StartRecordNumber = StartRec
		End If
	End Sub

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
				sFilter = MenuDishproperties.KeyFilter
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
			MenuDishproperties.ID.FormValue = arrKeyFlds(0)
			If Not IsNumeric(MenuDishproperties.ID.FormValue) Then
				SetupKeyValues = False
				Exit Function
			End If
		End If
		SetupKeyValues = True
	End Function

	' -----------------------------------------------------------------
	' Return Basic Search sql
	'
	Function BasicSearchSQL(arKeywords, typ)
		Dim sWhere
		sWhere = ""
			Call BuildBasicSearchSQL(sWhere, MenuDishproperties.dishproperty, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, MenuDishproperties.printingname, arKeywords, typ)
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
		sSearchKeyword = ew_IIf(Default, MenuDishproperties.BasicSearch.KeywordDefault, MenuDishproperties.BasicSearch.Keyword)
		sSearchType = ew_IIf(Default, MenuDishproperties.BasicSearch.SearchTypeDefault, MenuDishproperties.BasicSearch.SearchType)
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
			MenuDishproperties.BasicSearch.setKeyword(sSearchKeyword)
			MenuDishproperties.BasicSearch.setSearchType(sSearchType)
		End If
		BasicSearchWhere = sSearchStr
	End Function

	' Check if search parm exists
	Function CheckSearchParms()

		' Check basic search
		If MenuDishproperties.BasicSearch.IssetSession() Then
			CheckSearchParms = True
			Exit Function
		End If
		CheckSearchParms = False
	End Function

	' Clear all search parameters
	Sub ResetSearchParms()

		' Clear search where
		SearchWhere = ""
		MenuDishproperties.SearchWhere = SearchWhere

		' Clear basic search parameters
		Call ResetBasicSearchParms()
	End Sub

	' Load advanced search default values
	Function LoadAdvancedSearchDefault()
		LoadAdvancedSearchDefault = False
	End Function

	' Clear all basic search parameters
	Sub ResetBasicSearchParms()
		MenuDishproperties.BasicSearch.UnsetSession()
	End Sub

	' -----------------------------------------------------------------
	' Restore all search parameters
	'
	Sub RestoreSearchParms()

		' Restore search flag
		RestoreSearch = True

		' Restore basic search values
		Call MenuDishproperties.BasicSearch.Load()
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
			MenuDishproperties.CurrentOrder = Request.QueryString("order")
			MenuDishproperties.CurrentOrderType = Request.QueryString("ordertype")

			' Field ID
			Call MenuDishproperties.UpdateSort(MenuDishproperties.ID)

			' Field dishproperty
			Call MenuDishproperties.UpdateSort(MenuDishproperties.dishproperty)

			' Field dishpropertyprice
			Call MenuDishproperties.UpdateSort(MenuDishproperties.dishpropertyprice)

			' Field IdBusinessDetail
			Call MenuDishproperties.UpdateSort(MenuDishproperties.IdBusinessDetail)

			' Field dishpropertygroupid
			Call MenuDishproperties.UpdateSort(MenuDishproperties.dishpropertygroupid)

			' Field printingname
			Call MenuDishproperties.UpdateSort(MenuDishproperties.printingname)

			' Field i_displaySort
			Call MenuDishproperties.UpdateSort(MenuDishproperties.i_displaySort)
			MenuDishproperties.StartRecordNumber = 1 ' Reset start position
		End If
	End Sub

	' -----------------------------------------------------------------
	' Load Sort Order parameters
	'
	Sub LoadSortOrder()
		Dim sOrderBy
		sOrderBy = MenuDishproperties.SessionOrderBy ' Get order by from Session
		If sOrderBy = "" Then
			If MenuDishproperties.SqlOrderBy <> "" Then
				sOrderBy = MenuDishproperties.SqlOrderBy
				MenuDishproperties.SessionOrderBy = sOrderBy
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
				MenuDishproperties.SessionOrderBy = sOrderBy
				MenuDishproperties.ID.Sort = ""
				MenuDishproperties.dishproperty.Sort = ""
				MenuDishproperties.dishpropertyprice.Sort = ""
				MenuDishproperties.IdBusinessDetail.Sort = ""
				MenuDishproperties.dishpropertygroupid.Sort = ""
				MenuDishproperties.printingname.Sort = ""
				MenuDishproperties.i_displaySort.Sort = ""
			End If

			' Reset start position
			StartRec = 1
			MenuDishproperties.StartRecordNumber = StartRec
		End If
	End Sub

	' Set up list options
	Sub SetupListOptions()
		Dim item

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
		item.Visible = True
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
		If True Then
			ListOptions.GetItem("view").Body = "<a class=""ewRowLink ewView"" title=""" & ew_HtmlTitle(Language.Phrase("ViewLink")) & """ data-caption=""" & ew_HtmlTitle(Language.Phrase("ViewLink")) & """ href=""" & ew_HtmlEncode(ViewUrl) & """>" & Language.Phrase("ViewLink") & "</a>"
		Else
			ListOptions.GetItem("view").Body = ""
		End If
		Set item = ListOptions.GetItem("edit")
		If True Then
			item.Body = "<a class=""ewRowLink ewEdit"" title=""" & ew_HtmlTitle(Language.Phrase("EditLink")) & """ data-caption=""" & ew_HtmlTitle(Language.Phrase("EditLink")) & """ href=""" & ew_HtmlEncode(EditUrl) & """>" & Language.Phrase("EditLink") & "</a>"
		Else
			item.Body = ""
		End If
		Set item = ListOptions.GetItem("copy")
		If True Then
			item.Body = "<a class=""ewRowLink ewCopy"" title=""" & ew_HtmlTitle(Language.Phrase("CopyLink")) & """ data-caption=""" & ew_HtmlTitle(Language.Phrase("CopyLink")) & """ href=""" & ew_HtmlEncode(CopyUrl) & """>" & Language.Phrase("CopyLink") & "</a>"
		Else
			item.Body = ""
		End If
		ListOptions.GetItem("checkbox").Body = "<input type=""checkbox"" name=""key_m"" value=""" & ew_HtmlEncode(MenuDishproperties.ID.CurrentValue) & """ onclick='ew_ClickMultiCheckbox(event, this);'>"
		Call RenderListOptionsExt()
		Call ListOptions_Rendered()
	End Sub

	' Set up other options
	Sub SetupOtherOptions()
		Dim opt, item, DetailTableLink, ar, i
		Set opt = AddEditOptions

		' Add
		Call opt.Add("add")
		Set item = opt.GetItem("add")
		item.Body = "<a class=""ewAddEdit ewAdd"" title=""" & ew_HtmlTitle(Language.Phrase("AddLink")) & """ data-caption=""" & ew_HtmlTitle(Language.Phrase("AddLink")) & """ href=""" & ew_HtmlEncode(AddUrl) & """>" & Language.Phrase("AddLink") & "</a>"
		item.Visible = (AddUrl <> "")
		Set opt = ActionOptions

		' Add multi delete
		Call opt.Add("multidelete")
		Set item = opt.GetItem("multidelete")
		item.Body = "<a class=""ewAction ewMultiDelete"" title=""" & ew_HtmlTitle(Language.Phrase("DeleteSelectedLink")) & """ data-caption=""" & ew_HtmlTitle(Language.Phrase("DeleteSelectedLink")) & """ href="""" onclick=""ew_SubmitSelected(document.fMenuDishpropertieslist, '" & MultiDeleteUrl & "', ewLanguage.Phrase('DeleteMultiConfirmMsg'));return false;"">" & Language.Phrase("DeleteSelectedLink") & "</a>"
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
			Set opt = ActionOptions
			For i = 0 to UBound(MenuDishproperties.CustomActions.CustomArray)
				Action = MenuDishproperties.CustomActions.CustomArray(i)(0)
				Name = MenuDishproperties.CustomActions.CustomArray(i)(1)

				' Add custom action
				Call opt.Add("custom_" & Action)
				Set item = opt.GetItem("custom_" & Action)
				item.Body = "<a class=""ewAction ewCustomAction"" href="""" onclick=""ew_SubmitSelected(document.fMenuDishpropertieslist, '" & ew_CurrentUrl & "', null, '" & Action & "');return false;"">" & Name & "</a>"
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
	End Sub

	' Process custom action
	Sub ProcessCustomAction()
		Dim sFilter, sSql, UserAction, Processed
		sFilter = MenuDishproperties.GetKeyFilter
		UserAction = Request.Form("useraction") & ""
		Processed = False
		If sFilter <> "" And UserAction <> "" Then
			MenuDishproperties.CurrentFilter = sFilter
			sSql = MenuDishproperties.SQL
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
				ElseIf MenuDishproperties.CancelMessage <> "" Then
					FailureMessage = MenuDishproperties.CancelMessage
					MenuDishproperties.CancelMessage = ""
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
		SearchOptions.TableVar = MenuDishproperties.TableVar
		ExportOptions.Tag = "div"
		SearchOptions.TagClassName = "ewSearchOption"

		' Search button
		SearchOptions.Add("searchtoggle")
		Set item = SearchOptions.GetItem("searchtoggle")
		SearchToggleClass = ew_IIf(SearchWhere <> "", " active", " active")
		item.Body = "<button type=""button"" class=""btn btn-default ewSearchToggle" & SearchToggleClass & """ title=""" & Language.Phrase("SearchPanel") & """ data-caption=""" & Language.Phrase("SearchPanel") & """ data-toggle=""button"" data-form=""fMenuDishpropertieslistsrch"">" & Language.Phrase("SearchBtn") & "</button>"
		item.Visible = True

		' Show all button
		SearchOptions.Add("showall")
		Set item = SearchOptions.GetItem("showall")
		item.Body = "<a class=""btn btn-default ewShowAll"" title=""" & Language.Phrase("ShowAll") & """ data-caption=""" & Language.Phrase("ShowAll") & """ href=""" & PageUrl & "cmd=reset"">" & Language.Phrase("ShowAllBtn") & "</a>"
		item.Visible = (SearchWhere <> DefaultSearchWhere And SearchWhere <> "0=101")

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
		If MenuDishproperties.Export <> "" Or MenuDishproperties.CurrentAction <> "" Then
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
				MenuDishproperties.StartRecordNumber = StartRec
			ElseIf Request.QueryString(EW_TABLE_PAGE_NO).Count > 0 Then
				PageNo = Request.QueryString(EW_TABLE_PAGE_NO)
				If IsNumeric(PageNo) Then
					StartRec = (PageNo-1)*DisplayRecs+1
					If StartRec <= 0 Then
						StartRec = 1
					ElseIf StartRec >= ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1 Then
						StartRec = ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1
					End If
					MenuDishproperties.StartRecordNumber = StartRec
				End If
			End If
		End If
		StartRec = MenuDishproperties.StartRecordNumber

		' Check if correct start record counter
		If Not IsNumeric(StartRec) Or StartRec = "" Then ' Avoid invalid start record counter
			StartRec = 1 ' Reset start record counter
			MenuDishproperties.StartRecordNumber = StartRec
		ElseIf CLng(StartRec) > CLng(TotalRecs) Then ' Avoid starting record > total records
			StartRec = ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1 ' Point to last page first record
			MenuDishproperties.StartRecordNumber = StartRec
		ElseIf (StartRec-1) Mod DisplayRecs <> 0 Then
			StartRec = ((StartRec-1)\DisplayRecs)*DisplayRecs+1 ' Point to page boundary
			MenuDishproperties.StartRecordNumber = StartRec
		End If
	End Sub

	' -----------------------------------------------------------------
	'  Load basic search values
	'
	Function LoadBasicSearchValues()
		MenuDishproperties.BasicSearch.Keyword = Request.QueryString(EW_TABLE_BASIC_SEARCH)&""
		If MenuDishproperties.BasicSearch.Keyword <> "" Then Command = "search"
		MenuDishproperties.BasicSearch.SearchType = Request.QueryString(EW_TABLE_BASIC_SEARCH_TYPE)&""
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
		ViewUrl = MenuDishproperties.ViewUrl("")
		EditUrl = MenuDishproperties.EditUrl("")
		InlineEditUrl = MenuDishproperties.InlineEditUrl
		CopyUrl = MenuDishproperties.CopyUrl("")
		InlineCopyUrl = MenuDishproperties.InlineCopyUrl
		DeleteUrl = MenuDishproperties.DeleteUrl

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
			' ID

			MenuDishproperties.ID.LinkCustomAttributes = ""
			MenuDishproperties.ID.HrefValue = ""
			MenuDishproperties.ID.TooltipValue = ""

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
		End If

		' Call Row Rendered event
		If MenuDishproperties.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call MenuDishproperties.Row_Rendered()
		End If
	End Sub

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
			item.Body = "<a href=""javascript:void(0);"" class=""ewExportLink ewPdf"" title=""" & ew_HtmlEncode(Language.Phrase("ExportToPDFText")) & """ data-caption=""" & ew_HtmlEncode(Language.Phrase("ExportToPDFText")) & """ onclick=""ew_Export(document.fMenuDishpropertieslist,'" & ExportPdfUrl & "','pdf',true);"">" & Language.Phrase("ExportToPDF") & "</a>"
		Else
			item.Body = "<a href=""" & ExportPdfUrl & """ class=""ewExportLink ewPdf"" title=""" & ew_HtmlEncode(Language.Phrase("ExportToPDFText")) & """ data-caption=""" & ew_HtmlEncode(Language.Phrase("ExportToPDFText")) & """>" & Language.Phrase("ExportToPDF") & "</a>"
		End If
		item.Visible = False

		' Export to Email
		ExportOptions.Add("email")
		Set item = ExportOptions.GetItem("email")
		url = ew_IIf(ExportEmailCustom, ",url:'" & PageUrl & "export=email&amp;custom=1'", "")
		item.Body = "<button id=""emf_MenuDishproperties"" class=""ewExportLink ewEmail"" title=""" & Language.Phrase("ExportToEmailText") & """ data-caption=""" & Language.Phrase("ExportToEmailText") & """ onclick=""ew_EmailDialogShow({lnk:'emf_MenuDishproperties',hdr:ewLanguage.Phrase('ExportToEmailText'),f:document.fMenuDishpropertieslist,sel:false" & url & "});"">" & Language.Phrase("ExportToEmail") & "</button>"
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
		If MenuDishproperties.ExportAll Then
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
		If MenuDishproperties.Export = "xml" Then
			Set XmlDoc = New cXMLDocument
		Else
			Set MenuDishproperties.ExportDoc = New cExportDocument
			Set Doc = MenuDishproperties.ExportDoc
			Set Doc.Table = MenuDishproperties
			Call Doc.ChangeStyle("h")

			' Call Page Exporting server event
			Doc.ExportCustom = (Not Page_Exporting())
		End If
		Dim rsdetail, detailcnt
		Dim ParentTable
		ParentTable = ""
		If MenuDishproperties.Export = "xml" Then
			Call MenuDishproperties.ExportXmlDocument(XmlDoc, (ParentTable <> ""), rs, StartRec, StopRec, "")
		Else
			Dim sHeader
			sHeader = PageHeader
			Call Page_DataRendering(sHeader)
			Doc.Text = Doc.Text & sHeader
			Call MenuDishproperties.ExportDocument(Doc, rs, StartRec, StopRec, "")
			Dim sFooter
			sFooter = PageFooter
			Call Page_DataRendered(sFooter)
			Doc.Text = Doc.Text & sFooter
		End If

		' Close recordset and connection
		Rs.Close
		Set Rs = Nothing

		' Export header and footer
		If MenuDishproperties.Export <> "xml" Then
			Call Doc.ExportHeaderAndFooter()

			' Call Page Exported server event
			Call Page_Exported()
		End If
		If MenuDishproperties.Export = "xml" Then
			XmlDoc.Output
			Set XmlDoc = Nothing
		Else
			If MenuDishproperties.Export = "email" Then
				Response.Write ExportEmail(Doc.Text)
			ElseIf MenuDishproperties.Export = "pdf" Then
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
		Call Breadcrumb.Add("list", MenuDishproperties.TableVar, url, "", MenuDishproperties.TableVar, True)
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
