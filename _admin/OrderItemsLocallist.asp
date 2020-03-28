<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="OrderItemsLocalinfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim OrderItemsLocal_list
Set OrderItemsLocal_list = New cOrderItemsLocal_list
Set Page = OrderItemsLocal_list

' Page init processing
OrderItemsLocal_list.Page_Init()

' Page main processing
OrderItemsLocal_list.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
OrderItemsLocal_list.Page_Render()
%>
<!--#include file="header.asp"-->
<% If OrderItemsLocal.Export = "" Then %>
<script type="text/javascript">
// Page object
var OrderItemsLocal_list = new ew_Page("OrderItemsLocal_list");
OrderItemsLocal_list.PageID = "list"; // Page ID
var EW_PAGE_ID = OrderItemsLocal_list.PageID; // For backward compatibility
// Form object
var fOrderItemsLocallist = new ew_Form("fOrderItemsLocallist");
fOrderItemsLocallist.FormKeyCountName = '<%= OrderItemsLocal_list.FormKeyCountName %>';
// Form_CustomValidate event
fOrderItemsLocallist.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fOrderItemsLocallist.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fOrderItemsLocallist.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
var fOrderItemsLocallistsrch = new ew_Form("fOrderItemsLocallistsrch");
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
<% If OrderItemsLocal.Export = "" Then %>
<div class="ewToolbar">
<% If OrderItemsLocal.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If OrderItemsLocal_list.TotalRecs > 0 And OrderItemsLocal_list.ExportOptions.Visible Then %>
<% OrderItemsLocal_list.ExportOptions.Render "body", "", "", "", "", "" %>
<% End If %>
<% If OrderItemsLocal_list.SearchOptions.Visible Then %>
<% OrderItemsLocal_list.SearchOptions.Render "body", "", "", "", "", "" %>
<% End If %>
<% If OrderItemsLocal.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% End If %>
<% If (OrderItemsLocal.Export = "") Or (EW_EXPORT_MASTER_RECORD And OrderItemsLocal.Export = "print") Then %>
<% End If %>
<%

' Load recordset
'Set OrderItemsLocal_list.Recordset = OrderItemsLocal_list.LoadRecordset()

	OrderItemsLocal_list.TotalRecs = OrderItemsLocal_list.Recordset.RecordCount
	OrderItemsLocal_list.StartRec = 1
	If OrderItemsLocal_list.DisplayRecs <= 0 Then ' Display all records
		OrderItemsLocal_list.DisplayRecs = OrderItemsLocal_list.TotalRecs
	End If
	If Not (OrderItemsLocal.ExportAll And OrderItemsLocal.Export <> "") Then
		OrderItemsLocal_list.SetUpStartRec() ' Set up start record position
	End If

	' Set no record found message
	If OrderItemsLocal.CurrentAction = "" And OrderItemsLocal_list.TotalRecs = 0 Then
		If OrderItemsLocal_list.SearchWhere = "0=101" Then
			OrderItemsLocal_list.WarningMessage = Language.Phrase("EnterSearchCriteria")
		Else
			OrderItemsLocal_list.WarningMessage = Language.Phrase("NoRecord")
		End If
	End If
OrderItemsLocal_list.RenderOtherOptions()
%>
<% If OrderItemsLocal.Export = "" And OrderItemsLocal.CurrentAction = "" Then %>
<form name="fOrderItemsLocallistsrch" id="fOrderItemsLocallistsrch" class="form-inline ewForm" action="<%= ew_CurrentPage %>">
<% SearchPanelClass = ew_IIf(OrderItemsLocal_list.SearchWhere <> "", " in", " in") %>
<div id="fOrderItemsLocallistsrch_SearchPanel" class="ewSearchPanel collapse<%= SearchPanelClass %>">
<input type="hidden" name="cmd" value="search">
<input type="hidden" name="t" value="OrderItemsLocal">
	<div class="ewBasicSearch">
<div id="xsr_1" class="ewRow">
	<div class="ewQuickSearch input-group">
	<input type="text" name="<%= EW_TABLE_BASIC_SEARCH %>" id="<%= EW_TABLE_BASIC_SEARCH %>" class="form-control" value="<%= ew_HtmlEncode(OrderItemsLocal.BasicSearch.getKeyword()) %>" placeholder="<%= ew_HtmlEncode(Language.Phrase("Search")) %>">
	<input type="hidden" name="<%= EW_TABLE_BASIC_SEARCH_TYPE %>" id="<%= EW_TABLE_BASIC_SEARCH_TYPE %>" value="<%= ew_HtmlEncode(OrderItemsLocal.BasicSearch.getSearchType()) %>">
	<div class="input-group-btn">
		<button type="button" data-toggle="dropdown" class="btn btn-default"><span id="searchtype"><%= OrderItemsLocal.BasicSearch.getSearchTypeNameShort() %></span><span class="caret"></span></button>
		<ul class="dropdown-menu pull-right" role="menu">
			<li<% If OrderItemsLocal.BasicSearch.getSearchType() = "" Then Response.Write " class=""active""" %>><a href="javascript:void(0);" onclick="ew_SetSearchType(this)"><%= Language.Phrase("QuickSearchAuto") %></a></li>
			<li<% If OrderItemsLocal.BasicSearch.getSearchType() = "=" Then Response.Write " class=""active""" %>><a href="javascript:void(0);" onclick="ew_SetSearchType(this,'=')"><%= Language.Phrase("QuickSearchExact") %></a></li>
			<li<% If OrderItemsLocal.BasicSearch.getSearchType() = "AND" Then Response.Write " class=""active""" %>><a href="javascript:void(0);" onclick="ew_SetSearchType(this,'AND')"><%= Language.Phrase("QuickSearchAll") %></a></li>
			<li<% If OrderItemsLocal.BasicSearch.getSearchType() = "OR" Then Response.Write " class=""active""" %>><a href="javascript:void(0);" onclick="ew_SetSearchType(this,'OR')"><%= Language.Phrase("QuickSearchAny") %></a></li>
		</ul>
	<button class="btn btn-primary ewButton" name="btnsubmit" id="btnsubmit" type="submit"><%= Language.Phrase("QuickSearchBtn") %></button>
	</div>
	</div>
</div>
	</div>
</div>
</form>
<% End If %>
<% OrderItemsLocal_list.ShowPageHeader() %>
<% OrderItemsLocal_list.ShowMessage %>
<% If OrderItemsLocal_list.TotalRecs > 0 Or OrderItemsLocal.CurrentAction <> "" Then %>
<div class="ewGrid">
<% If OrderItemsLocal.Export = "" Then %>
<div class="ewGridUpperPanel">
<% If OrderItemsLocal.CurrentAction <> "gridadd" And OrderItemsLocal.CurrentAction <> "gridedit" Then %>
<form name="ewPagerForm" class="form-inline ewForm ewPagerForm" action="<%= ew_CurrentPage %>">
<% If Not IsObject(OrderItemsLocal_list.Pager) Then Set OrderItemsLocal_list.Pager = ew_NewPrevNextPager(OrderItemsLocal_list.StartRec, OrderItemsLocal_list.DisplayRecs, OrderItemsLocal_list.TotalRecs) %>
<% If OrderItemsLocal_list.Pager.RecordCount > 0 Then %>
<div class="ewPager">
<span><%= Language.Phrase("Page") %>&nbsp;</span>
<div class="ewPrevNext"><div class="input-group">
<div class="input-group-btn">
<!--first page button-->
	<% If OrderItemsLocal_list.Pager.FirstButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerFirst") %>" href="<%= OrderItemsLocal_list.PageUrl %>start=<%= OrderItemsLocal_list.Pager.FirstButton.Start %>"><span class="icon-first ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerFirst") %>"><span class="icon-first ewIcon"></span></a>
	<% End If %>
<!--previous page button-->
	<% If OrderItemsLocal_list.Pager.PrevButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerPrevious") %>" href="<%= OrderItemsLocal_list.PageUrl %>start=<%= OrderItemsLocal_list.Pager.PrevButton.Start %>"><span class="icon-prev ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerPrevious") %>"><span class="icon-prev ewIcon"></span></a>
	<% End If %>
</div>
<!--current page number-->
	<input class="form-control input-sm" type="text" name="<%= EW_TABLE_PAGE_NO %>" value="<%= OrderItemsLocal_list.Pager.CurrentPage %>">
<div class="input-group-btn">
<!--next page button-->
	<% If OrderItemsLocal_list.Pager.NextButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerNext") %>" href="<%= OrderItemsLocal_list.PageUrl %>start=<%= OrderItemsLocal_list.Pager.NextButton.Start %>"><span class="icon-next ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerNext") %>"><span class="icon-next ewIcon"></span></a>
	<% End If %>
<!--last page button-->
	<% If OrderItemsLocal_list.Pager.LastButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerLast") %>" href="<%= OrderItemsLocal_list.PageUrl %>start=<%= OrderItemsLocal_list.Pager.LastButton.Start %>"><span class="icon-last ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerLast") %>"><span class="icon-last ewIcon"></span></a>
	<% End If %>
</div>
</div>
</div>
<span>&nbsp;<%= Language.Phrase("of") %>&nbsp;<%= OrderItemsLocal_list.Pager.PageCount %></span>
</div>
<div class="ewPager ewRec">
	<span><%= Language.Phrase("Record") %>&nbsp;<%= OrderItemsLocal_list.Pager.FromIndex %>&nbsp;<%= Language.Phrase("To") %>&nbsp;<%= OrderItemsLocal_list.Pager.ToIndex %>&nbsp;<%= Language.Phrase("Of") %>&nbsp;<%= OrderItemsLocal_list.Pager.RecordCount %></span>
</div>
<% End If %>
<% If OrderItemsLocal_list.TotalRecs > 0 Then %>
<div class="ewPager">
<input type="hidden" name="t" value="OrderItemsLocal">
<select name="<%= EW_TABLE_REC_PER_PAGE %>" class="form-control input-sm" onchange="this.form.submit();">
<option value="20"<% If OrderItemsLocal_list.DisplayRecs = 20 Then %> selected="selected"<% End If %>>20</option>
<option value="50"<% If OrderItemsLocal_list.DisplayRecs = 50 Then %> selected="selected"<% End If %>>50</option>
<option value="100"<% If OrderItemsLocal_list.DisplayRecs = 100 Then %> selected="selected"<% End If %>>100</option>
<option value="500"<% If OrderItemsLocal_list.DisplayRecs = 500 Then %> selected="selected"<% End If %>>500</option>
<option value="1000"<% If OrderItemsLocal_list.DisplayRecs = 1000 Then %> selected="selected"<% End If %>>1000</option>
<option value="ALL"<% If OrderItemsLocal.RecordsPerPage = -1 Then %> selected="selected"<% End If %>><%= Language.Phrase("AllRecords") %></option>
</select>
</div>
<% End If %>
</form>
<% End If %>
<div class="ewListOtherOptions">
<%
	OrderItemsLocal_list.AddEditOptions.Render "body", "", "", "", "", ""
	OrderItemsLocal_list.DetailOptions.Render "body", "", "", "", "", ""
	OrderItemsLocal_list.ActionOptions.Render "body", "", "", "", "", ""
%>
</div>
<div class="clearfix"></div>
</div>
<% End If %>
<form name="fOrderItemsLocallist" id="fOrderItemsLocallist" class="form-inline ewForm ewListForm" action="<%= ew_CurrentPage %>" method="post">
<% If OrderItemsLocal_list.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= OrderItemsLocal_list.Token %>">
<% End If %>
<input type="hidden" name="t" value="OrderItemsLocal">
<div id="gmp_OrderItemsLocal" class="<% If ew_IsResponsiveLayout() Then Response.Write "table-responsive " %>ewGridMiddlePanel">
<% If OrderItemsLocal_list.TotalRecs > 0 Then %>
<table id="tbl_OrderItemsLocallist" class="table ewTable">
<%= OrderItemsLocal.TableCustomInnerHtml %>
<thead><!-- Table header -->
	<tr class="ewTableHeader">
<%

' Header row
OrderItemsLocal.RowType = EW_ROWTYPE_HEADER
Call OrderItemsLocal_list.RenderListOptions()

' Render list options (header, left)
OrderItemsLocal_list.ListOptions.Render "header", "left", "", "", "", ""
%>
<% If OrderItemsLocal.ID.Visible Then ' ID %>
	<% If OrderItemsLocal.SortUrl(OrderItemsLocal.ID) = "" Then %>
		<th data-name="ID"><div id="elh_OrderItemsLocal_ID" class="OrderItemsLocal_ID"><div class="ewTableHeaderCaption"><%= OrderItemsLocal.ID.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="ID"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrderItemsLocal.SortUrl(OrderItemsLocal.ID) %>',1);"><div id="elh_OrderItemsLocal_ID" class="OrderItemsLocal_ID">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrderItemsLocal.ID.FldCaption %></span><span class="ewTableHeaderSort"><% If OrderItemsLocal.ID.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrderItemsLocal.ID.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrderItemsLocal.OrderId.Visible Then ' OrderId %>
	<% If OrderItemsLocal.SortUrl(OrderItemsLocal.OrderId) = "" Then %>
		<th data-name="OrderId"><div id="elh_OrderItemsLocal_OrderId" class="OrderItemsLocal_OrderId"><div class="ewTableHeaderCaption"><%= OrderItemsLocal.OrderId.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="OrderId"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrderItemsLocal.SortUrl(OrderItemsLocal.OrderId) %>',1);"><div id="elh_OrderItemsLocal_OrderId" class="OrderItemsLocal_OrderId">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrderItemsLocal.OrderId.FldCaption %></span><span class="ewTableHeaderSort"><% If OrderItemsLocal.OrderId.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrderItemsLocal.OrderId.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrderItemsLocal.MenuItemId.Visible Then ' MenuItemId %>
	<% If OrderItemsLocal.SortUrl(OrderItemsLocal.MenuItemId) = "" Then %>
		<th data-name="MenuItemId"><div id="elh_OrderItemsLocal_MenuItemId" class="OrderItemsLocal_MenuItemId"><div class="ewTableHeaderCaption"><%= OrderItemsLocal.MenuItemId.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="MenuItemId"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrderItemsLocal.SortUrl(OrderItemsLocal.MenuItemId) %>',1);"><div id="elh_OrderItemsLocal_MenuItemId" class="OrderItemsLocal_MenuItemId">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrderItemsLocal.MenuItemId.FldCaption %></span><span class="ewTableHeaderSort"><% If OrderItemsLocal.MenuItemId.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrderItemsLocal.MenuItemId.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrderItemsLocal.MenuItemPropertyId.Visible Then ' MenuItemPropertyId %>
	<% If OrderItemsLocal.SortUrl(OrderItemsLocal.MenuItemPropertyId) = "" Then %>
		<th data-name="MenuItemPropertyId"><div id="elh_OrderItemsLocal_MenuItemPropertyId" class="OrderItemsLocal_MenuItemPropertyId"><div class="ewTableHeaderCaption"><%= OrderItemsLocal.MenuItemPropertyId.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="MenuItemPropertyId"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrderItemsLocal.SortUrl(OrderItemsLocal.MenuItemPropertyId) %>',1);"><div id="elh_OrderItemsLocal_MenuItemPropertyId" class="OrderItemsLocal_MenuItemPropertyId">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrderItemsLocal.MenuItemPropertyId.FldCaption %></span><span class="ewTableHeaderSort"><% If OrderItemsLocal.MenuItemPropertyId.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrderItemsLocal.MenuItemPropertyId.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrderItemsLocal.Qta.Visible Then ' Qta %>
	<% If OrderItemsLocal.SortUrl(OrderItemsLocal.Qta) = "" Then %>
		<th data-name="Qta"><div id="elh_OrderItemsLocal_Qta" class="OrderItemsLocal_Qta"><div class="ewTableHeaderCaption"><%= OrderItemsLocal.Qta.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Qta"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrderItemsLocal.SortUrl(OrderItemsLocal.Qta) %>',1);"><div id="elh_OrderItemsLocal_Qta" class="OrderItemsLocal_Qta">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrderItemsLocal.Qta.FldCaption %></span><span class="ewTableHeaderSort"><% If OrderItemsLocal.Qta.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrderItemsLocal.Qta.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrderItemsLocal.Price.Visible Then ' Price %>
	<% If OrderItemsLocal.SortUrl(OrderItemsLocal.Price) = "" Then %>
		<th data-name="Price"><div id="elh_OrderItemsLocal_Price" class="OrderItemsLocal_Price"><div class="ewTableHeaderCaption"><%= OrderItemsLocal.Price.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Price"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrderItemsLocal.SortUrl(OrderItemsLocal.Price) %>',1);"><div id="elh_OrderItemsLocal_Price" class="OrderItemsLocal_Price">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrderItemsLocal.Price.FldCaption %></span><span class="ewTableHeaderSort"><% If OrderItemsLocal.Price.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrderItemsLocal.Price.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrderItemsLocal.Total.Visible Then ' Total %>
	<% If OrderItemsLocal.SortUrl(OrderItemsLocal.Total) = "" Then %>
		<th data-name="Total"><div id="elh_OrderItemsLocal_Total" class="OrderItemsLocal_Total"><div class="ewTableHeaderCaption"><%= OrderItemsLocal.Total.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Total"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrderItemsLocal.SortUrl(OrderItemsLocal.Total) %>',1);"><div id="elh_OrderItemsLocal_Total" class="OrderItemsLocal_Total">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrderItemsLocal.Total.FldCaption %></span><span class="ewTableHeaderSort"><% If OrderItemsLocal.Total.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrderItemsLocal.Total.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrderItemsLocal.toppingids.Visible Then ' toppingids %>
	<% If OrderItemsLocal.SortUrl(OrderItemsLocal.toppingids) = "" Then %>
		<th data-name="toppingids"><div id="elh_OrderItemsLocal_toppingids" class="OrderItemsLocal_toppingids"><div class="ewTableHeaderCaption"><%= OrderItemsLocal.toppingids.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="toppingids"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrderItemsLocal.SortUrl(OrderItemsLocal.toppingids) %>',1);"><div id="elh_OrderItemsLocal_toppingids" class="OrderItemsLocal_toppingids">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrderItemsLocal.toppingids.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If OrderItemsLocal.toppingids.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrderItemsLocal.toppingids.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrderItemsLocal.dishpropertiesids.Visible Then ' dishpropertiesids %>
	<% If OrderItemsLocal.SortUrl(OrderItemsLocal.dishpropertiesids) = "" Then %>
		<th data-name="dishpropertiesids"><div id="elh_OrderItemsLocal_dishpropertiesids" class="OrderItemsLocal_dishpropertiesids"><div class="ewTableHeaderCaption"><%= OrderItemsLocal.dishpropertiesids.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="dishpropertiesids"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrderItemsLocal.SortUrl(OrderItemsLocal.dishpropertiesids) %>',1);"><div id="elh_OrderItemsLocal_dishpropertiesids" class="OrderItemsLocal_dishpropertiesids">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrderItemsLocal.dishpropertiesids.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If OrderItemsLocal.dishpropertiesids.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrderItemsLocal.dishpropertiesids.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<%

' Render list options (header, right)
OrderItemsLocal_list.ListOptions.Render "header", "right", "", "", "", ""
%>
	</tr>
</thead>
<tbody><!-- Table body -->
<%
If (OrderItemsLocal.ExportAll And OrderItemsLocal.Export <> "") Then
	OrderItemsLocal_list.StopRec = OrderItemsLocal_list.TotalRecs
Else

	' Set the last record to display
	If OrderItemsLocal_list.TotalRecs > OrderItemsLocal_list.StartRec + OrderItemsLocal_list.DisplayRecs - 1 Then
		OrderItemsLocal_list.StopRec = OrderItemsLocal_list.StartRec + OrderItemsLocal_list.DisplayRecs - 1
	Else
		OrderItemsLocal_list.StopRec = OrderItemsLocal_list.TotalRecs
	End If
End If

' Move to first record
OrderItemsLocal_list.RecCnt = OrderItemsLocal_list.StartRec - 1
If Not OrderItemsLocal_list.Recordset.Eof Then
	OrderItemsLocal_list.Recordset.MoveFirst
	If OrderItemsLocal_list.StartRec > 1 Then OrderItemsLocal_list.Recordset.Move OrderItemsLocal_list.StartRec - 1
ElseIf Not OrderItemsLocal.AllowAddDeleteRow And OrderItemsLocal_list.StopRec = 0 Then
	OrderItemsLocal_list.StopRec = OrderItemsLocal.GridAddRowCount
End If

' Initialize Aggregate
OrderItemsLocal.RowType = EW_ROWTYPE_AGGREGATEINIT
Call OrderItemsLocal.ResetAttrs()
Call OrderItemsLocal_list.RenderRow()
OrderItemsLocal_list.RowCnt = 0

' Output date rows
Do While CLng(OrderItemsLocal_list.RecCnt) < CLng(OrderItemsLocal_list.StopRec)
	OrderItemsLocal_list.RecCnt = OrderItemsLocal_list.RecCnt + 1
	If CLng(OrderItemsLocal_list.RecCnt) >= CLng(OrderItemsLocal_list.StartRec) Then
		OrderItemsLocal_list.RowCnt = OrderItemsLocal_list.RowCnt + 1

	' Set up key count
	OrderItemsLocal_list.KeyCount = OrderItemsLocal_list.RowIndex
	Call OrderItemsLocal.ResetAttrs()
	OrderItemsLocal.CssClass = ""
	If OrderItemsLocal.CurrentAction = "gridadd" Then
	Else
		Call OrderItemsLocal_list.LoadRowValues(OrderItemsLocal_list.Recordset) ' Load row values
	End If
	OrderItemsLocal.RowType = EW_ROWTYPE_VIEW ' Render view

	' Set up row id / data-rowindex
	OrderItemsLocal.RowAttrs.AddAttributes Array(Array("data-rowindex", OrderItemsLocal_list.RowCnt), Array("id", "r" & OrderItemsLocal_list.RowCnt & "_OrderItemsLocal"), Array("data-rowtype", OrderItemsLocal.RowType))

	' Render row
	Call OrderItemsLocal_list.RenderRow()

	' Render list options
	Call OrderItemsLocal_list.RenderListOptions()
%>
	<tr<%= OrderItemsLocal.RowAttributes %>>
<%

' Render list options (body, left)
OrderItemsLocal_list.ListOptions.Render "body", "left", OrderItemsLocal_list.RowCnt, "", "", ""
%>
	<% If OrderItemsLocal.ID.Visible Then ' ID %>
		<td data-name="ID"<%= OrderItemsLocal.ID.CellAttributes %>>
<span<%= OrderItemsLocal.ID.ViewAttributes %>>
<%= OrderItemsLocal.ID.ListViewValue %>
</span>
<a id="<%= OrderItemsLocal_list.PageObjName & "_row_" & OrderItemsLocal_list.RowCnt %>"></a></td>
	<% End If %>
	<% If OrderItemsLocal.OrderId.Visible Then ' OrderId %>
		<td data-name="OrderId"<%= OrderItemsLocal.OrderId.CellAttributes %>>
<span<%= OrderItemsLocal.OrderId.ViewAttributes %>>
<%= OrderItemsLocal.OrderId.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrderItemsLocal.MenuItemId.Visible Then ' MenuItemId %>
		<td data-name="MenuItemId"<%= OrderItemsLocal.MenuItemId.CellAttributes %>>
<span<%= OrderItemsLocal.MenuItemId.ViewAttributes %>>
<%= OrderItemsLocal.MenuItemId.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrderItemsLocal.MenuItemPropertyId.Visible Then ' MenuItemPropertyId %>
		<td data-name="MenuItemPropertyId"<%= OrderItemsLocal.MenuItemPropertyId.CellAttributes %>>
<span<%= OrderItemsLocal.MenuItemPropertyId.ViewAttributes %>>
<%= OrderItemsLocal.MenuItemPropertyId.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrderItemsLocal.Qta.Visible Then ' Qta %>
		<td data-name="Qta"<%= OrderItemsLocal.Qta.CellAttributes %>>
<span<%= OrderItemsLocal.Qta.ViewAttributes %>>
<%= OrderItemsLocal.Qta.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrderItemsLocal.Price.Visible Then ' Price %>
		<td data-name="Price"<%= OrderItemsLocal.Price.CellAttributes %>>
<span<%= OrderItemsLocal.Price.ViewAttributes %>>
<%= OrderItemsLocal.Price.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrderItemsLocal.Total.Visible Then ' Total %>
		<td data-name="Total"<%= OrderItemsLocal.Total.CellAttributes %>>
<span<%= OrderItemsLocal.Total.ViewAttributes %>>
<%= OrderItemsLocal.Total.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrderItemsLocal.toppingids.Visible Then ' toppingids %>
		<td data-name="toppingids"<%= OrderItemsLocal.toppingids.CellAttributes %>>
<span<%= OrderItemsLocal.toppingids.ViewAttributes %>>
<%= OrderItemsLocal.toppingids.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrderItemsLocal.dishpropertiesids.Visible Then ' dishpropertiesids %>
		<td data-name="dishpropertiesids"<%= OrderItemsLocal.dishpropertiesids.CellAttributes %>>
<span<%= OrderItemsLocal.dishpropertiesids.ViewAttributes %>>
<%= OrderItemsLocal.dishpropertiesids.ListViewValue %>
</span>
</td>
	<% End If %>
<%

' Render list options (body, right)
OrderItemsLocal_list.ListOptions.Render "body", "right", OrderItemsLocal_list.RowCnt, "", "", ""
%>
	</tr>
<%
	End If
	If OrderItemsLocal.CurrentAction <> "gridadd" Then
		OrderItemsLocal_list.Recordset.MoveNext()
	End If
Loop
%>
</tbody>
</table>
<% End If %>
<% If OrderItemsLocal.CurrentAction = "" Then %>
<input type="hidden" name="a_list" id="a_list" value="">
<% End If %>
</div>
</form>
<%

' Close recordset and connection
OrderItemsLocal_list.Recordset.Close
Set OrderItemsLocal_list.Recordset = Nothing
%>
<% If OrderItemsLocal.Export = "" Then %>
<div class="ewGridLowerPanel">
<% If OrderItemsLocal.CurrentAction <> "gridadd" And OrderItemsLocal.CurrentAction <> "gridedit" Then %>
<form name="ewPagerForm" class="ewForm form-inline ewPagerForm" action="<%= ew_CurrentPage %>">
<% If Not IsObject(OrderItemsLocal_list.Pager) Then Set OrderItemsLocal_list.Pager = ew_NewPrevNextPager(OrderItemsLocal_list.StartRec, OrderItemsLocal_list.DisplayRecs, OrderItemsLocal_list.TotalRecs) %>
<% If OrderItemsLocal_list.Pager.RecordCount > 0 Then %>
<div class="ewPager">
<span><%= Language.Phrase("Page") %>&nbsp;</span>
<div class="ewPrevNext"><div class="input-group">
<div class="input-group-btn">
<!--first page button-->
	<% If OrderItemsLocal_list.Pager.FirstButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerFirst") %>" href="<%= OrderItemsLocal_list.PageUrl %>start=<%= OrderItemsLocal_list.Pager.FirstButton.Start %>"><span class="icon-first ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerFirst") %>"><span class="icon-first ewIcon"></span></a>
	<% End If %>
<!--previous page button-->
	<% If OrderItemsLocal_list.Pager.PrevButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerPrevious") %>" href="<%= OrderItemsLocal_list.PageUrl %>start=<%= OrderItemsLocal_list.Pager.PrevButton.Start %>"><span class="icon-prev ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerPrevious") %>"><span class="icon-prev ewIcon"></span></a>
	<% End If %>
</div>
<!--current page number-->
	<input class="form-control input-sm" type="text" name="<%= EW_TABLE_PAGE_NO %>" value="<%= OrderItemsLocal_list.Pager.CurrentPage %>">
<div class="input-group-btn">
<!--next page button-->
	<% If OrderItemsLocal_list.Pager.NextButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerNext") %>" href="<%= OrderItemsLocal_list.PageUrl %>start=<%= OrderItemsLocal_list.Pager.NextButton.Start %>"><span class="icon-next ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerNext") %>"><span class="icon-next ewIcon"></span></a>
	<% End If %>
<!--last page button-->
	<% If OrderItemsLocal_list.Pager.LastButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerLast") %>" href="<%= OrderItemsLocal_list.PageUrl %>start=<%= OrderItemsLocal_list.Pager.LastButton.Start %>"><span class="icon-last ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerLast") %>"><span class="icon-last ewIcon"></span></a>
	<% End If %>
</div>
</div>
</div>
<span>&nbsp;<%= Language.Phrase("of") %>&nbsp;<%= OrderItemsLocal_list.Pager.PageCount %></span>
</div>
<div class="ewPager ewRec">
	<span><%= Language.Phrase("Record") %>&nbsp;<%= OrderItemsLocal_list.Pager.FromIndex %>&nbsp;<%= Language.Phrase("To") %>&nbsp;<%= OrderItemsLocal_list.Pager.ToIndex %>&nbsp;<%= Language.Phrase("Of") %>&nbsp;<%= OrderItemsLocal_list.Pager.RecordCount %></span>
</div>
<% End If %>
<% If OrderItemsLocal_list.TotalRecs > 0 Then %>
<div class="ewPager">
<input type="hidden" name="t" value="OrderItemsLocal">
<select name="<%= EW_TABLE_REC_PER_PAGE %>" class="form-control input-sm" onchange="this.form.submit();">
<option value="20"<% If OrderItemsLocal_list.DisplayRecs = 20 Then %> selected="selected"<% End If %>>20</option>
<option value="50"<% If OrderItemsLocal_list.DisplayRecs = 50 Then %> selected="selected"<% End If %>>50</option>
<option value="100"<% If OrderItemsLocal_list.DisplayRecs = 100 Then %> selected="selected"<% End If %>>100</option>
<option value="500"<% If OrderItemsLocal_list.DisplayRecs = 500 Then %> selected="selected"<% End If %>>500</option>
<option value="1000"<% If OrderItemsLocal_list.DisplayRecs = 1000 Then %> selected="selected"<% End If %>>1000</option>
<option value="ALL"<% If OrderItemsLocal.RecordsPerPage = -1 Then %> selected="selected"<% End If %>><%= Language.Phrase("AllRecords") %></option>
</select>
</div>
<% End If %>
</form>
<% End If %>
<div class="ewListOtherOptions">
<%
	OrderItemsLocal_list.AddEditOptions.Render "body", "bottom", "", "", "", ""
	OrderItemsLocal_list.DetailOptions.Render "body", "bottom", "", "", "", ""
	OrderItemsLocal_list.ActionOptions.Render "body", "bottom", "", "", "", ""
%>
</div>
<div class="clearfix"></div>
</div>
<% End If %>
</div>
<% End If %>
<% If OrderItemsLocal_list.TotalRecs = 0 And OrderItemsLocal.CurrentAction = "" Then ' Show other options %>
<div class="ewListOtherOptions">
<%
	OrderItemsLocal_list.AddEditOptions.Render "body", "", "", "", "", ""
	OrderItemsLocal_list.DetailOptions.Render "body", "", "", "", "", ""
	OrderItemsLocal_list.ActionOptions.Render "body", "", "", "", "", ""
%>
</div>
<div class="clearfix"></div>
<% End If %>
<% If OrderItemsLocal.Export <> "" Then %>
<script type="text/javascript">
ew_ApplyTemplate("body", "", "OrderItemsLocallist", "<%= OrderItemsLocal.CustomExport %>");
</script>
<% End If %>
<% If OrderItemsLocal.Export = "" Then %>
<script type="text/javascript">
fOrderItemsLocallistsrch.Init();
fOrderItemsLocallist.Init();
</script>
<% End If %>
<%
OrderItemsLocal_list.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<% If OrderItemsLocal.Export = "" Then %>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<% End If %>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set OrderItemsLocal_list = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cOrderItemsLocal_list

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
		TableName = "OrderItemsLocal"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "OrderItemsLocal_list"
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
		If OrderItemsLocal.UseTokenInUrl Then PageUrl = PageUrl & "t=" & OrderItemsLocal.TableVar & "&" ' add page token
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
		If OrderItemsLocal.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (OrderItemsLocal.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (OrderItemsLocal.TableVar = Request.QueryString("t"))
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
		FormName = "fOrderItemsLocallist"
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
		If IsEmpty(OrderItemsLocal) Then Set OrderItemsLocal = New cOrderItemsLocal
		Set Table = OrderItemsLocal
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
		AddUrl = "OrderItemsLocaladd.asp"
		InlineAddUrl = PageUrl & "a=add"
		GridAddUrl = PageUrl & "a=gridadd"
		GridEditUrl = PageUrl & "a=gridedit"
		MultiDeleteUrl = "OrderItemsLocaldelete.asp"
		MultiUpdateUrl = "OrderItemsLocalupdate.asp"

		' Initialize form object
		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "list"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "OrderItemsLocal"

		' Open connection to the database
		If IsEmpty(Conn) Then Call ew_Connect()

		' List options
		Set ListOptions = New cListOptions
		ListOptions.TableVar = OrderItemsLocal.TableVar

		' Export options
		Set ExportOptions = New cListOptions
		ExportOptions.TableVar = OrderItemsLocal.TableVar
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
			OrderItemsLocal.Export = Request.QueryString("export")
			custom = Request.QueryString("custom") & ""
		ElseIf ew_IsHttpPost() Then
			If Request.Form("export").Count > 0 Then
				OrderItemsLocal.Export = Request.Form("export")
				custom = Request.Form("custom") & ""
			ElseIf Request.Form("exporttype").Count > 0 Then
				OrderItemsLocal.Export = Request.Form("exporttype")
				custom = Request.Form("custom") & ""
			End If
		Else
			OrderItemsLocal.ExportReturnUrl = ew_CurrentUrl()
		End If
		gsExportFile = OrderItemsLocal.TableVar ' Get export file, used in header
		Dim Charset ' Charset used in header
		If EW_CHARSET <> "" Then
			Charset = ";charset=" & EW_CHARSET
		Else
			Charset = ""
		End If

		' Get custom export parameters
		If OrderItemsLocal.Export <> "" And custom <> "" Then
			OrderItemsLocal.CustomExport = OrderItemsLocal.Export
			OrderItemsLocal.Export = "print"
		End If
		gsCustomExport = OrderItemsLocal.CustomExport
		gsExport = OrderItemsLocal.Export ' Get export parameter, used in header

		' Custom export (post back from ew_ApplyTemplate), export and terminate page
		If Request.Form("customexport").Count > 0 Then
			OrderItemsLocal.CustomExport = Request.Form("customexport")
			OrderItemsLocal.Export = OrderItemsLocal.CustomExport
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
		If OrderItemsLocal.Export = "excel" Then
			Response.ContentType = "application/vnd.ms-excel" & Charset
			Response.AddHeader "Content-Disposition", "attachment; filename=" & gsExportFile & ".xls"
		End If
		If OrderItemsLocal.Export = "word" Then
			Response.ContentType = "application/vnd.ms-word" & Charset
			Response.AddHeader "Content-Disposition", "attachment; filename=" & gsExportFile & ".doc"
		End If
		If OrderItemsLocal.Export = "csv" Then
			Response.BinaryWrite ChrB(239) & ChrB(187) & ChrB(191)
			Response.ContentType = "application/csv" & Charset
			Response.AddHeader "Content-Disposition", "attachment; filename=" & gsExportFile & ".csv"
		End If

		' Get grid add count
		Dim gridaddcnt
		gridaddcnt = Request.QueryString(EW_TABLE_GRID_ADD_ROW_COUNT)
		If IsNumeric(gridaddcnt) Then
			If gridaddcnt > 0 Then
				OrderItemsLocal.GridAddRowCount = gridaddcnt
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
			results = OrderItemsLocal.GetAutoFill(Request.Form("name"), Request.Form("q"))
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
		If UBound(OrderItemsLocal.CustomActions.CustomArray) >= 0 Then
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
		If Not OrderItemsLocal Is Nothing Then
			If OrderItemsLocal.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = OrderItemsLocal.TableVar
				If OrderItemsLocal.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf OrderItemsLocal.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf OrderItemsLocal.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf OrderItemsLocal.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set OrderItemsLocal = Nothing
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
			If OrderItemsLocal.Export = "" Then
				SetupBreadcrumb()
			End If

			' Hide list options
			If OrderItemsLocal.Export <> "" Then
				Call ListOptions.HideAllOptions(Array("sequence"))
				ListOptions.UseDropDownButton = False ' Disable drop down button
				ListOptions.UseButtonGroup = False ' Disable button group
			ElseIf OrderItemsLocal.CurrentAction = "gridadd" Or OrderItemsLocal.CurrentAction = "gridedit" Then
				Call ListOptions.HideAllOptions(Array())
				ListOptions.UseDropDownButton = False ' Disable drop down button
				ListOptions.UseButtonGroup = False ' Disable button group
			End If

			' Hide export options
			If OrderItemsLocal.Export <> "" Or OrderItemsLocal.CurrentAction <> "" Then
				ExportOptions.HideAllOptions(Array())
			End If

			' Hide other options
			If OrderItemsLocal.Export <> "" Then
				AddEditOptions.HideAllOptions(Array())
				DetailOptions.HideAllOptions(Array())
				ActionOptions.HideAllOptions(Array())
			End If

			' Get default search criteria
			Call ew_AddFilter(DefaultSearchWhere, BasicSearchWhere(True))

			' Get basic search values
			Call LoadBasicSearchValues()

			' Restore search parms from Session if not searching / reset / export
			If (OrderItemsLocal.Export <> "" Or Command <> "search" And Command <> "reset" And Command <> "resetall") And CheckSearchParms() Then
				Call RestoreSearchParms()
			End If

			' Call Recordset SearchValidated event
			Call OrderItemsLocal.Recordset_SearchValidated()

			' Set Up Sorting Order
			SetUpSortOrder()

			' Get basic search criteria
			If gsSearchError = "" Then
				sSrchBasic = BasicSearchWhere(False)
			End If
		End If ' End Validate Request

		' Restore display records
		If OrderItemsLocal.RecordsPerPage <> "" Then
			DisplayRecs = OrderItemsLocal.RecordsPerPage ' Restore from Session
		Else
			DisplayRecs = 20 ' Load default
		End If

		' Load Sorting Order
		LoadSortOrder()

		' Load search default if no existing search criteria
		If Not CheckSearchParms() Then

			' Load basic search from default
			OrderItemsLocal.BasicSearch.Keyword = OrderItemsLocal.BasicSearch.KeywordDefault
			OrderItemsLocal.BasicSearch.SearchType = OrderItemsLocal.BasicSearch.SearchTypeDefault
			OrderItemsLocal.BasicSearch.setSearchType(OrderItemsLocal.BasicSearch.SearchTypeDefault)
			If OrderItemsLocal.BasicSearch.Keyword <> "" Then
				sSrchBasic = BasicSearchWhere(False)
			End If
		End If

		' Build search criteria
		Call ew_AddFilter(SearchWhere, sSrchAdvanced)
		Call ew_AddFilter(SearchWhere, sSrchBasic)

		' Call Recordset Searching event
		Call OrderItemsLocal.Recordset_Searching(SearchWhere)

		' Save search criteria
		If Command = "search" And Not RestoreSearch Then
			OrderItemsLocal.SearchWhere = SearchWhere ' Save to Session
			StartRec = 1 ' Reset start record counter
			OrderItemsLocal.StartRecordNumber = StartRec
		Else
			SearchWhere = OrderItemsLocal.SearchWhere
		End If
		sFilter = ""
		Call ew_AddFilter(sFilter, DbDetailFilter)
		Call ew_AddFilter(sFilter, SearchWhere)

		' Set up filter in Session
		OrderItemsLocal.SessionWhere = sFilter
		OrderItemsLocal.CurrentFilter = ""

		' Export Data only
		If OrderItemsLocal.CustomExport = "" And ew_InArray(OrderItemsLocal.Export, Array("html","word","excel","xml","csv","email","pdf")) Then
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
			OrderItemsLocal.RecordsPerPage = DisplayRecs ' Save to Session

			' Reset start position
			StartRec = 1
			OrderItemsLocal.StartRecordNumber = StartRec
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
				sFilter = OrderItemsLocal.KeyFilter
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
			OrderItemsLocal.ID.FormValue = arrKeyFlds(0)
			If Not IsNumeric(OrderItemsLocal.ID.FormValue) Then
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
			Call BuildBasicSearchSQL(sWhere, OrderItemsLocal.toppingids, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, OrderItemsLocal.dishpropertiesids, arKeywords, typ)
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
		sSearchKeyword = ew_IIf(Default, OrderItemsLocal.BasicSearch.KeywordDefault, OrderItemsLocal.BasicSearch.Keyword)
		sSearchType = ew_IIf(Default, OrderItemsLocal.BasicSearch.SearchTypeDefault, OrderItemsLocal.BasicSearch.SearchType)
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
			OrderItemsLocal.BasicSearch.setKeyword(sSearchKeyword)
			OrderItemsLocal.BasicSearch.setSearchType(sSearchType)
		End If
		BasicSearchWhere = sSearchStr
	End Function

	' Check if search parm exists
	Function CheckSearchParms()

		' Check basic search
		If OrderItemsLocal.BasicSearch.IssetSession() Then
			CheckSearchParms = True
			Exit Function
		End If
		CheckSearchParms = False
	End Function

	' Clear all search parameters
	Sub ResetSearchParms()

		' Clear search where
		SearchWhere = ""
		OrderItemsLocal.SearchWhere = SearchWhere

		' Clear basic search parameters
		Call ResetBasicSearchParms()
	End Sub

	' Load advanced search default values
	Function LoadAdvancedSearchDefault()
		LoadAdvancedSearchDefault = False
	End Function

	' Clear all basic search parameters
	Sub ResetBasicSearchParms()
		OrderItemsLocal.BasicSearch.UnsetSession()
	End Sub

	' -----------------------------------------------------------------
	' Restore all search parameters
	'
	Sub RestoreSearchParms()

		' Restore search flag
		RestoreSearch = True

		' Restore basic search values
		Call OrderItemsLocal.BasicSearch.Load()
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
			OrderItemsLocal.CurrentOrder = Request.QueryString("order")
			OrderItemsLocal.CurrentOrderType = Request.QueryString("ordertype")

			' Field ID
			Call OrderItemsLocal.UpdateSort(OrderItemsLocal.ID)

			' Field OrderId
			Call OrderItemsLocal.UpdateSort(OrderItemsLocal.OrderId)

			' Field MenuItemId
			Call OrderItemsLocal.UpdateSort(OrderItemsLocal.MenuItemId)

			' Field MenuItemPropertyId
			Call OrderItemsLocal.UpdateSort(OrderItemsLocal.MenuItemPropertyId)

			' Field Qta
			Call OrderItemsLocal.UpdateSort(OrderItemsLocal.Qta)

			' Field Price
			Call OrderItemsLocal.UpdateSort(OrderItemsLocal.Price)

			' Field Total
			Call OrderItemsLocal.UpdateSort(OrderItemsLocal.Total)

			' Field toppingids
			Call OrderItemsLocal.UpdateSort(OrderItemsLocal.toppingids)

			' Field dishpropertiesids
			Call OrderItemsLocal.UpdateSort(OrderItemsLocal.dishpropertiesids)
			OrderItemsLocal.StartRecordNumber = 1 ' Reset start position
		End If
	End Sub

	' -----------------------------------------------------------------
	' Load Sort Order parameters
	'
	Sub LoadSortOrder()
		Dim sOrderBy
		sOrderBy = OrderItemsLocal.SessionOrderBy ' Get order by from Session
		If sOrderBy = "" Then
			If OrderItemsLocal.SqlOrderBy <> "" Then
				sOrderBy = OrderItemsLocal.SqlOrderBy
				OrderItemsLocal.SessionOrderBy = sOrderBy
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
				OrderItemsLocal.SessionOrderBy = sOrderBy
				OrderItemsLocal.ID.Sort = ""
				OrderItemsLocal.OrderId.Sort = ""
				OrderItemsLocal.MenuItemId.Sort = ""
				OrderItemsLocal.MenuItemPropertyId.Sort = ""
				OrderItemsLocal.Qta.Sort = ""
				OrderItemsLocal.Price.Sort = ""
				OrderItemsLocal.Total.Sort = ""
				OrderItemsLocal.toppingids.Sort = ""
				OrderItemsLocal.dishpropertiesids.Sort = ""
			End If

			' Reset start position
			StartRec = 1
			OrderItemsLocal.StartRecordNumber = StartRec
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
		ListOptions.GetItem("checkbox").Body = "<input type=""checkbox"" name=""key_m"" value=""" & ew_HtmlEncode(OrderItemsLocal.ID.CurrentValue) & """ onclick='ew_ClickMultiCheckbox(event, this);'>"
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
		item.Body = "<a class=""ewAction ewMultiDelete"" title=""" & ew_HtmlTitle(Language.Phrase("DeleteSelectedLink")) & """ data-caption=""" & ew_HtmlTitle(Language.Phrase("DeleteSelectedLink")) & """ href="""" onclick=""ew_SubmitSelected(document.fOrderItemsLocallist, '" & MultiDeleteUrl & "', ewLanguage.Phrase('DeleteMultiConfirmMsg'));return false;"">" & Language.Phrase("DeleteSelectedLink") & "</a>"
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
			For i = 0 to UBound(OrderItemsLocal.CustomActions.CustomArray)
				Action = OrderItemsLocal.CustomActions.CustomArray(i)(0)
				Name = OrderItemsLocal.CustomActions.CustomArray(i)(1)

				' Add custom action
				Call opt.Add("custom_" & Action)
				Set item = opt.GetItem("custom_" & Action)
				item.Body = "<a class=""ewAction ewCustomAction"" href="""" onclick=""ew_SubmitSelected(document.fOrderItemsLocallist, '" & ew_CurrentUrl & "', null, '" & Action & "');return false;"">" & Name & "</a>"
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
		sFilter = OrderItemsLocal.GetKeyFilter
		UserAction = Request.Form("useraction") & ""
		Processed = False
		If sFilter <> "" And UserAction <> "" Then
			OrderItemsLocal.CurrentFilter = sFilter
			sSql = OrderItemsLocal.SQL
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
				ElseIf OrderItemsLocal.CancelMessage <> "" Then
					FailureMessage = OrderItemsLocal.CancelMessage
					OrderItemsLocal.CancelMessage = ""
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
		SearchOptions.TableVar = OrderItemsLocal.TableVar
		ExportOptions.Tag = "div"
		SearchOptions.TagClassName = "ewSearchOption"

		' Search button
		SearchOptions.Add("searchtoggle")
		Set item = SearchOptions.GetItem("searchtoggle")
		SearchToggleClass = ew_IIf(SearchWhere <> "", " active", " active")
		item.Body = "<button type=""button"" class=""btn btn-default ewSearchToggle" & SearchToggleClass & """ title=""" & Language.Phrase("SearchPanel") & """ data-caption=""" & Language.Phrase("SearchPanel") & """ data-toggle=""button"" data-form=""fOrderItemsLocallistsrch"">" & Language.Phrase("SearchBtn") & "</button>"
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
		If OrderItemsLocal.Export <> "" Or OrderItemsLocal.CurrentAction <> "" Then
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
				OrderItemsLocal.StartRecordNumber = StartRec
			ElseIf Request.QueryString(EW_TABLE_PAGE_NO).Count > 0 Then
				PageNo = Request.QueryString(EW_TABLE_PAGE_NO)
				If IsNumeric(PageNo) Then
					StartRec = (PageNo-1)*DisplayRecs+1
					If StartRec <= 0 Then
						StartRec = 1
					ElseIf StartRec >= ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1 Then
						StartRec = ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1
					End If
					OrderItemsLocal.StartRecordNumber = StartRec
				End If
			End If
		End If
		StartRec = OrderItemsLocal.StartRecordNumber

		' Check if correct start record counter
		If Not IsNumeric(StartRec) Or StartRec = "" Then ' Avoid invalid start record counter
			StartRec = 1 ' Reset start record counter
			OrderItemsLocal.StartRecordNumber = StartRec
		ElseIf CLng(StartRec) > CLng(TotalRecs) Then ' Avoid starting record > total records
			StartRec = ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1 ' Point to last page first record
			OrderItemsLocal.StartRecordNumber = StartRec
		ElseIf (StartRec-1) Mod DisplayRecs <> 0 Then
			StartRec = ((StartRec-1)\DisplayRecs)*DisplayRecs+1 ' Point to page boundary
			OrderItemsLocal.StartRecordNumber = StartRec
		End If
	End Sub

	' -----------------------------------------------------------------
	'  Load basic search values
	'
	Function LoadBasicSearchValues()
		OrderItemsLocal.BasicSearch.Keyword = Request.QueryString(EW_TABLE_BASIC_SEARCH)&""
		If OrderItemsLocal.BasicSearch.Keyword <> "" Then Command = "search"
		OrderItemsLocal.BasicSearch.SearchType = Request.QueryString(EW_TABLE_BASIC_SEARCH_TYPE)&""
	End Function

	' -----------------------------------------------------------------
	' Load recordset
	'
	Function LoadRecordset()

		' Load list page sql
		Dim sSql
		sSql = OrderItemsLocal.SelectSQL
		Call ew_SetDebugMsg("LoadRecordset: " & sSql) ' Show SQL for debugging

		' Load recordset
		Dim RsRecordset
		Set RsRecordset = ew_LoadRecordset(sSql)

		' Call Recordset Selected event
		Call OrderItemsLocal.Recordset_Selected(RsRecordset)
		Set LoadRecordset = RsRecordset
	End Function

	' -----------------------------------------------------------------
	' Load row based on key values
	'
	Function LoadRow()
		Dim RsRow, sSql, sFilter
		sFilter = OrderItemsLocal.KeyFilter

		' Call Row Selecting event
		Call OrderItemsLocal.Row_Selecting(sFilter)

		' Load sql based on filter
		OrderItemsLocal.CurrentFilter = sFilter
		sSql = OrderItemsLocal.SQL
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
		Call OrderItemsLocal.Row_Selected(RsRow)
		OrderItemsLocal.ID.DbValue = RsRow("ID")
		OrderItemsLocal.OrderId.DbValue = RsRow("OrderId")
		OrderItemsLocal.MenuItemId.DbValue = RsRow("MenuItemId")
		OrderItemsLocal.MenuItemPropertyId.DbValue = RsRow("MenuItemPropertyId")
		OrderItemsLocal.Qta.DbValue = RsRow("Qta")
		OrderItemsLocal.Price.DbValue = RsRow("Price")
		OrderItemsLocal.Total.DbValue = RsRow("Total")
		OrderItemsLocal.toppingids.DbValue = RsRow("toppingids")
		OrderItemsLocal.dishpropertiesids.DbValue = RsRow("dishpropertiesids")
	End Sub

	' Load DbValue from recordset
	Sub LoadDbValues(Rs)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		If Rs.Eof Then Exit Sub
		OrderItemsLocal.ID.m_DbValue = Rs("ID")
		OrderItemsLocal.OrderId.m_DbValue = Rs("OrderId")
		OrderItemsLocal.MenuItemId.m_DbValue = Rs("MenuItemId")
		OrderItemsLocal.MenuItemPropertyId.m_DbValue = Rs("MenuItemPropertyId")
		OrderItemsLocal.Qta.m_DbValue = Rs("Qta")
		OrderItemsLocal.Price.m_DbValue = Rs("Price")
		OrderItemsLocal.Total.m_DbValue = Rs("Total")
		OrderItemsLocal.toppingids.m_DbValue = Rs("toppingids")
		OrderItemsLocal.dishpropertiesids.m_DbValue = Rs("dishpropertiesids")
	End Sub

	' Load old record
	Function LoadOldRecord()

		' Load key values from Session
		Dim bValidKey
		bValidKey = True
		If OrderItemsLocal.GetKey("ID")&"" <> "" Then
			OrderItemsLocal.ID.CurrentValue = OrderItemsLocal.GetKey("ID") ' ID
		Else
			bValidKey = False
		End If

		' Load old recordset
		If bValidKey Then
			OrderItemsLocal.CurrentFilter = OrderItemsLocal.KeyFilter
			Dim sSql
			sSql = OrderItemsLocal.SQL
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
		ViewUrl = OrderItemsLocal.ViewUrl("")
		EditUrl = OrderItemsLocal.EditUrl("")
		InlineEditUrl = OrderItemsLocal.InlineEditUrl
		CopyUrl = OrderItemsLocal.CopyUrl("")
		InlineCopyUrl = OrderItemsLocal.InlineCopyUrl
		DeleteUrl = OrderItemsLocal.DeleteUrl

		' Convert decimal values if posted back
		If OrderItemsLocal.Price.FormValue = OrderItemsLocal.Price.CurrentValue And IsNumeric(OrderItemsLocal.Price.CurrentValue) Then
			OrderItemsLocal.Price.CurrentValue = ew_StrToFloat(OrderItemsLocal.Price.CurrentValue)
		End If

		' Convert decimal values if posted back
		If OrderItemsLocal.Total.FormValue = OrderItemsLocal.Total.CurrentValue And IsNumeric(OrderItemsLocal.Total.CurrentValue) Then
			OrderItemsLocal.Total.CurrentValue = ew_StrToFloat(OrderItemsLocal.Total.CurrentValue)
		End If

		' Call Row Rendering event
		Call OrderItemsLocal.Row_Rendering()

		' ---------------------------------------
		'  Common render codes for all row types
		' ---------------------------------------
		' ID
		' OrderId
		' MenuItemId
		' MenuItemPropertyId
		' Qta
		' Price
		' Total
		' toppingids
		' dishpropertiesids
		' -----------
		'  View  Row
		' -----------

		If OrderItemsLocal.RowType = EW_ROWTYPE_VIEW Then ' View row

			' ID
			OrderItemsLocal.ID.ViewValue = OrderItemsLocal.ID.CurrentValue
			OrderItemsLocal.ID.ViewCustomAttributes = ""

			' OrderId
			OrderItemsLocal.OrderId.ViewValue = OrderItemsLocal.OrderId.CurrentValue
			OrderItemsLocal.OrderId.ViewCustomAttributes = ""

			' MenuItemId
			OrderItemsLocal.MenuItemId.ViewValue = OrderItemsLocal.MenuItemId.CurrentValue
			OrderItemsLocal.MenuItemId.ViewCustomAttributes = ""

			' MenuItemPropertyId
			OrderItemsLocal.MenuItemPropertyId.ViewValue = OrderItemsLocal.MenuItemPropertyId.CurrentValue
			OrderItemsLocal.MenuItemPropertyId.ViewCustomAttributes = ""

			' Qta
			OrderItemsLocal.Qta.ViewValue = OrderItemsLocal.Qta.CurrentValue
			OrderItemsLocal.Qta.ViewCustomAttributes = ""

			' Price
			OrderItemsLocal.Price.ViewValue = OrderItemsLocal.Price.CurrentValue
			OrderItemsLocal.Price.ViewCustomAttributes = ""

			' Total
			OrderItemsLocal.Total.ViewValue = OrderItemsLocal.Total.CurrentValue
			OrderItemsLocal.Total.ViewCustomAttributes = ""

			' toppingids
			OrderItemsLocal.toppingids.ViewValue = OrderItemsLocal.toppingids.CurrentValue
			OrderItemsLocal.toppingids.ViewCustomAttributes = ""

			' dishpropertiesids
			OrderItemsLocal.dishpropertiesids.ViewValue = OrderItemsLocal.dishpropertiesids.CurrentValue
			OrderItemsLocal.dishpropertiesids.ViewCustomAttributes = ""

			' View refer script
			' ID

			OrderItemsLocal.ID.LinkCustomAttributes = ""
			OrderItemsLocal.ID.HrefValue = ""
			OrderItemsLocal.ID.TooltipValue = ""

			' OrderId
			OrderItemsLocal.OrderId.LinkCustomAttributes = ""
			OrderItemsLocal.OrderId.HrefValue = ""
			OrderItemsLocal.OrderId.TooltipValue = ""

			' MenuItemId
			OrderItemsLocal.MenuItemId.LinkCustomAttributes = ""
			OrderItemsLocal.MenuItemId.HrefValue = ""
			OrderItemsLocal.MenuItemId.TooltipValue = ""

			' MenuItemPropertyId
			OrderItemsLocal.MenuItemPropertyId.LinkCustomAttributes = ""
			OrderItemsLocal.MenuItemPropertyId.HrefValue = ""
			OrderItemsLocal.MenuItemPropertyId.TooltipValue = ""

			' Qta
			OrderItemsLocal.Qta.LinkCustomAttributes = ""
			OrderItemsLocal.Qta.HrefValue = ""
			OrderItemsLocal.Qta.TooltipValue = ""

			' Price
			OrderItemsLocal.Price.LinkCustomAttributes = ""
			OrderItemsLocal.Price.HrefValue = ""
			OrderItemsLocal.Price.TooltipValue = ""

			' Total
			OrderItemsLocal.Total.LinkCustomAttributes = ""
			OrderItemsLocal.Total.HrefValue = ""
			OrderItemsLocal.Total.TooltipValue = ""

			' toppingids
			OrderItemsLocal.toppingids.LinkCustomAttributes = ""
			OrderItemsLocal.toppingids.HrefValue = ""
			OrderItemsLocal.toppingids.TooltipValue = ""

			' dishpropertiesids
			OrderItemsLocal.dishpropertiesids.LinkCustomAttributes = ""
			OrderItemsLocal.dishpropertiesids.HrefValue = ""
			OrderItemsLocal.dishpropertiesids.TooltipValue = ""
		End If

		' Call Row Rendered event
		If OrderItemsLocal.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call OrderItemsLocal.Row_Rendered()
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
			item.Body = "<a href=""javascript:void(0);"" class=""ewExportLink ewPdf"" title=""" & ew_HtmlEncode(Language.Phrase("ExportToPDFText")) & """ data-caption=""" & ew_HtmlEncode(Language.Phrase("ExportToPDFText")) & """ onclick=""ew_Export(document.fOrderItemsLocallist,'" & ExportPdfUrl & "','pdf',true);"">" & Language.Phrase("ExportToPDF") & "</a>"
		Else
			item.Body = "<a href=""" & ExportPdfUrl & """ class=""ewExportLink ewPdf"" title=""" & ew_HtmlEncode(Language.Phrase("ExportToPDFText")) & """ data-caption=""" & ew_HtmlEncode(Language.Phrase("ExportToPDFText")) & """>" & Language.Phrase("ExportToPDF") & "</a>"
		End If
		item.Visible = False

		' Export to Email
		ExportOptions.Add("email")
		Set item = ExportOptions.GetItem("email")
		url = ew_IIf(ExportEmailCustom, ",url:'" & PageUrl & "export=email&amp;custom=1'", "")
		item.Body = "<button id=""emf_OrderItemsLocal"" class=""ewExportLink ewEmail"" title=""" & Language.Phrase("ExportToEmailText") & """ data-caption=""" & Language.Phrase("ExportToEmailText") & """ onclick=""ew_EmailDialogShow({lnk:'emf_OrderItemsLocal',hdr:ewLanguage.Phrase('ExportToEmailText'),f:document.fOrderItemsLocallist,sel:false" & url & "});"">" & Language.Phrase("ExportToEmail") & "</button>"
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
		If OrderItemsLocal.ExportAll Then
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
		If OrderItemsLocal.Export = "xml" Then
			Set XmlDoc = New cXMLDocument
		Else
			Set OrderItemsLocal.ExportDoc = New cExportDocument
			Set Doc = OrderItemsLocal.ExportDoc
			Set Doc.Table = OrderItemsLocal
			Call Doc.ChangeStyle("h")

			' Call Page Exporting server event
			Doc.ExportCustom = (Not Page_Exporting())
		End If
		Dim rsdetail, detailcnt
		Dim ParentTable
		ParentTable = ""
		If OrderItemsLocal.Export = "xml" Then
			Call OrderItemsLocal.ExportXmlDocument(XmlDoc, (ParentTable <> ""), rs, StartRec, StopRec, "")
		Else
			Dim sHeader
			sHeader = PageHeader
			Call Page_DataRendering(sHeader)
			Doc.Text = Doc.Text & sHeader
			Call OrderItemsLocal.ExportDocument(Doc, rs, StartRec, StopRec, "")
			Dim sFooter
			sFooter = PageFooter
			Call Page_DataRendered(sFooter)
			Doc.Text = Doc.Text & sFooter
		End If

		' Close recordset and connection
		Rs.Close
		Set Rs = Nothing

		' Export header and footer
		If OrderItemsLocal.Export <> "xml" Then
			Call Doc.ExportHeaderAndFooter()

			' Call Page Exported server event
			Call Page_Exported()
		End If
		If OrderItemsLocal.Export = "xml" Then
			XmlDoc.Output
			Set XmlDoc = Nothing
		Else
			If OrderItemsLocal.Export = "email" Then
				Response.Write ExportEmail(Doc.Text)
			ElseIf OrderItemsLocal.Export = "pdf" Then
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
		Call Breadcrumb.Add("list", OrderItemsLocal.TableVar, url, "", OrderItemsLocal.TableVar, True)
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
