<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="View_Paid_OrdersLocalinfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim View_Paid_OrdersLocal_list
Set View_Paid_OrdersLocal_list = New cView_Paid_OrdersLocal_list
Set Page = View_Paid_OrdersLocal_list

' Page init processing
View_Paid_OrdersLocal_list.Page_Init()

' Page main processing
View_Paid_OrdersLocal_list.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
View_Paid_OrdersLocal_list.Page_Render()
%>
<!--#include file="header.asp"-->
<% If View_Paid_OrdersLocal.Export = "" Then %>
<script type="text/javascript">
// Page object
var View_Paid_OrdersLocal_list = new ew_Page("View_Paid_OrdersLocal_list");
View_Paid_OrdersLocal_list.PageID = "list"; // Page ID
var EW_PAGE_ID = View_Paid_OrdersLocal_list.PageID; // For backward compatibility
// Form object
var fView_Paid_OrdersLocallist = new ew_Form("fView_Paid_OrdersLocallist");
fView_Paid_OrdersLocallist.FormKeyCountName = '<%= View_Paid_OrdersLocal_list.FormKeyCountName %>';
// Form_CustomValidate event
fView_Paid_OrdersLocallist.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fView_Paid_OrdersLocallist.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fView_Paid_OrdersLocallist.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
var fView_Paid_OrdersLocallistsrch = new ew_Form("fView_Paid_OrdersLocallistsrch");
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
<% If View_Paid_OrdersLocal.Export = "" Then %>
<div class="ewToolbar">
<% If View_Paid_OrdersLocal.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If View_Paid_OrdersLocal_list.TotalRecs > 0 And View_Paid_OrdersLocal_list.ExportOptions.Visible Then %>
<% View_Paid_OrdersLocal_list.ExportOptions.Render "body", "", "", "", "", "" %>
<% End If %>
<% If View_Paid_OrdersLocal_list.SearchOptions.Visible Then %>
<% View_Paid_OrdersLocal_list.SearchOptions.Render "body", "", "", "", "", "" %>
<% End If %>
<% If View_Paid_OrdersLocal.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% End If %>
<% If (View_Paid_OrdersLocal.Export = "") Or (EW_EXPORT_MASTER_RECORD And View_Paid_OrdersLocal.Export = "print") Then %>
<% End If %>
<%

' Load recordset
'Set View_Paid_OrdersLocal_list.Recordset = View_Paid_OrdersLocal_list.LoadRecordset()

	View_Paid_OrdersLocal_list.TotalRecs = View_Paid_OrdersLocal_list.Recordset.RecordCount
	View_Paid_OrdersLocal_list.StartRec = 1
	If View_Paid_OrdersLocal_list.DisplayRecs <= 0 Then ' Display all records
		View_Paid_OrdersLocal_list.DisplayRecs = View_Paid_OrdersLocal_list.TotalRecs
	End If
	If Not (View_Paid_OrdersLocal.ExportAll And View_Paid_OrdersLocal.Export <> "") Then
		View_Paid_OrdersLocal_list.SetUpStartRec() ' Set up start record position
	End If

	' Set no record found message
	If View_Paid_OrdersLocal.CurrentAction = "" And View_Paid_OrdersLocal_list.TotalRecs = 0 Then
		If View_Paid_OrdersLocal_list.SearchWhere = "0=101" Then
			View_Paid_OrdersLocal_list.WarningMessage = Language.Phrase("EnterSearchCriteria")
		Else
			View_Paid_OrdersLocal_list.WarningMessage = Language.Phrase("NoRecord")
		End If
	End If
View_Paid_OrdersLocal_list.RenderOtherOptions()
%>
<% If View_Paid_OrdersLocal.Export = "" And View_Paid_OrdersLocal.CurrentAction = "" Then %>
<form name="fView_Paid_OrdersLocallistsrch" id="fView_Paid_OrdersLocallistsrch" class="form-inline ewForm" action="<%= ew_CurrentPage %>">
<% SearchPanelClass = ew_IIf(View_Paid_OrdersLocal_list.SearchWhere <> "", " in", " in") %>
<div id="fView_Paid_OrdersLocallistsrch_SearchPanel" class="ewSearchPanel collapse<%= SearchPanelClass %>">
<input type="hidden" name="cmd" value="search">
<input type="hidden" name="t" value="View_Paid_OrdersLocal">
	<div class="ewBasicSearch">
<div id="xsr_1" class="ewRow">
	<div class="ewQuickSearch input-group">
	<input type="text" name="<%= EW_TABLE_BASIC_SEARCH %>" id="<%= EW_TABLE_BASIC_SEARCH %>" class="form-control" value="<%= ew_HtmlEncode(View_Paid_OrdersLocal.BasicSearch.getKeyword()) %>" placeholder="<%= ew_HtmlEncode(Language.Phrase("Search")) %>">
	<input type="hidden" name="<%= EW_TABLE_BASIC_SEARCH_TYPE %>" id="<%= EW_TABLE_BASIC_SEARCH_TYPE %>" value="<%= ew_HtmlEncode(View_Paid_OrdersLocal.BasicSearch.getSearchType()) %>">
	<div class="input-group-btn">
		<button type="button" data-toggle="dropdown" class="btn btn-default"><span id="searchtype"><%= View_Paid_OrdersLocal.BasicSearch.getSearchTypeNameShort() %></span><span class="caret"></span></button>
		<ul class="dropdown-menu pull-right" role="menu">
			<li<% If View_Paid_OrdersLocal.BasicSearch.getSearchType() = "" Then Response.Write " class=""active""" %>><a href="javascript:void(0);" onclick="ew_SetSearchType(this)"><%= Language.Phrase("QuickSearchAuto") %></a></li>
			<li<% If View_Paid_OrdersLocal.BasicSearch.getSearchType() = "=" Then Response.Write " class=""active""" %>><a href="javascript:void(0);" onclick="ew_SetSearchType(this,'=')"><%= Language.Phrase("QuickSearchExact") %></a></li>
			<li<% If View_Paid_OrdersLocal.BasicSearch.getSearchType() = "AND" Then Response.Write " class=""active""" %>><a href="javascript:void(0);" onclick="ew_SetSearchType(this,'AND')"><%= Language.Phrase("QuickSearchAll") %></a></li>
			<li<% If View_Paid_OrdersLocal.BasicSearch.getSearchType() = "OR" Then Response.Write " class=""active""" %>><a href="javascript:void(0);" onclick="ew_SetSearchType(this,'OR')"><%= Language.Phrase("QuickSearchAny") %></a></li>
		</ul>
	<button class="btn btn-primary ewButton" name="btnsubmit" id="btnsubmit" type="submit"><%= Language.Phrase("QuickSearchBtn") %></button>
	</div>
	</div>
</div>
	</div>
</div>
</form>
<% End If %>
<% View_Paid_OrdersLocal_list.ShowPageHeader() %>
<% View_Paid_OrdersLocal_list.ShowMessage %>
<% If View_Paid_OrdersLocal_list.TotalRecs > 0 Or View_Paid_OrdersLocal.CurrentAction <> "" Then %>
<div class="ewGrid">
<% If View_Paid_OrdersLocal.Export = "" Then %>
<div class="ewGridUpperPanel">
<% If View_Paid_OrdersLocal.CurrentAction <> "gridadd" And View_Paid_OrdersLocal.CurrentAction <> "gridedit" Then %>
<form name="ewPagerForm" class="form-inline ewForm ewPagerForm" action="<%= ew_CurrentPage %>">
<% If Not IsObject(View_Paid_OrdersLocal_list.Pager) Then Set View_Paid_OrdersLocal_list.Pager = ew_NewPrevNextPager(View_Paid_OrdersLocal_list.StartRec, View_Paid_OrdersLocal_list.DisplayRecs, View_Paid_OrdersLocal_list.TotalRecs) %>
<% If View_Paid_OrdersLocal_list.Pager.RecordCount > 0 Then %>
<div class="ewPager">
<span><%= Language.Phrase("Page") %>&nbsp;</span>
<div class="ewPrevNext"><div class="input-group">
<div class="input-group-btn">
<!--first page button-->
	<% If View_Paid_OrdersLocal_list.Pager.FirstButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerFirst") %>" href="<%= View_Paid_OrdersLocal_list.PageUrl %>start=<%= View_Paid_OrdersLocal_list.Pager.FirstButton.Start %>"><span class="icon-first ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerFirst") %>"><span class="icon-first ewIcon"></span></a>
	<% End If %>
<!--previous page button-->
	<% If View_Paid_OrdersLocal_list.Pager.PrevButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerPrevious") %>" href="<%= View_Paid_OrdersLocal_list.PageUrl %>start=<%= View_Paid_OrdersLocal_list.Pager.PrevButton.Start %>"><span class="icon-prev ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerPrevious") %>"><span class="icon-prev ewIcon"></span></a>
	<% End If %>
</div>
<!--current page number-->
	<input class="form-control input-sm" type="text" name="<%= EW_TABLE_PAGE_NO %>" value="<%= View_Paid_OrdersLocal_list.Pager.CurrentPage %>">
<div class="input-group-btn">
<!--next page button-->
	<% If View_Paid_OrdersLocal_list.Pager.NextButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerNext") %>" href="<%= View_Paid_OrdersLocal_list.PageUrl %>start=<%= View_Paid_OrdersLocal_list.Pager.NextButton.Start %>"><span class="icon-next ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerNext") %>"><span class="icon-next ewIcon"></span></a>
	<% End If %>
<!--last page button-->
	<% If View_Paid_OrdersLocal_list.Pager.LastButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerLast") %>" href="<%= View_Paid_OrdersLocal_list.PageUrl %>start=<%= View_Paid_OrdersLocal_list.Pager.LastButton.Start %>"><span class="icon-last ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerLast") %>"><span class="icon-last ewIcon"></span></a>
	<% End If %>
</div>
</div>
</div>
<span>&nbsp;<%= Language.Phrase("of") %>&nbsp;<%= View_Paid_OrdersLocal_list.Pager.PageCount %></span>
</div>
<div class="ewPager ewRec">
	<span><%= Language.Phrase("Record") %>&nbsp;<%= View_Paid_OrdersLocal_list.Pager.FromIndex %>&nbsp;<%= Language.Phrase("To") %>&nbsp;<%= View_Paid_OrdersLocal_list.Pager.ToIndex %>&nbsp;<%= Language.Phrase("Of") %>&nbsp;<%= View_Paid_OrdersLocal_list.Pager.RecordCount %></span>
</div>
<% End If %>
<% If View_Paid_OrdersLocal_list.TotalRecs > 0 Then %>
<div class="ewPager">
<input type="hidden" name="t" value="View_Paid_OrdersLocal">
<select name="<%= EW_TABLE_REC_PER_PAGE %>" class="form-control input-sm" onchange="this.form.submit();">
<option value="20"<% If View_Paid_OrdersLocal_list.DisplayRecs = 20 Then %> selected="selected"<% End If %>>20</option>
<option value="50"<% If View_Paid_OrdersLocal_list.DisplayRecs = 50 Then %> selected="selected"<% End If %>>50</option>
<option value="100"<% If View_Paid_OrdersLocal_list.DisplayRecs = 100 Then %> selected="selected"<% End If %>>100</option>
<option value="500"<% If View_Paid_OrdersLocal_list.DisplayRecs = 500 Then %> selected="selected"<% End If %>>500</option>
<option value="1000"<% If View_Paid_OrdersLocal_list.DisplayRecs = 1000 Then %> selected="selected"<% End If %>>1000</option>
<option value="ALL"<% If View_Paid_OrdersLocal.RecordsPerPage = -1 Then %> selected="selected"<% End If %>><%= Language.Phrase("AllRecords") %></option>
</select>
</div>
<% End If %>
</form>
<% End If %>
<div class="ewListOtherOptions">
<%
	View_Paid_OrdersLocal_list.AddEditOptions.Render "body", "", "", "", "", ""
	View_Paid_OrdersLocal_list.DetailOptions.Render "body", "", "", "", "", ""
	View_Paid_OrdersLocal_list.ActionOptions.Render "body", "", "", "", "", ""
%>
</div>
<div class="clearfix"></div>
</div>
<% End If %>
<form name="fView_Paid_OrdersLocallist" id="fView_Paid_OrdersLocallist" class="form-inline ewForm ewListForm" action="<%= ew_CurrentPage %>" method="post">
<% If View_Paid_OrdersLocal_list.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= View_Paid_OrdersLocal_list.Token %>">
<% End If %>
<input type="hidden" name="t" value="View_Paid_OrdersLocal">
<div id="gmp_View_Paid_OrdersLocal" class="<% If ew_IsResponsiveLayout() Then Response.Write "table-responsive " %>ewGridMiddlePanel">
<% If View_Paid_OrdersLocal_list.TotalRecs > 0 Then %>
<table id="tbl_View_Paid_OrdersLocallist" class="table ewTable">
<%= View_Paid_OrdersLocal.TableCustomInnerHtml %>
<thead><!-- Table header -->
	<tr class="ewTableHeader">
<%

' Header row
View_Paid_OrdersLocal.RowType = EW_ROWTYPE_HEADER
Call View_Paid_OrdersLocal_list.RenderListOptions()

' Render list options (header, left)
View_Paid_OrdersLocal_list.ListOptions.Render "header", "left", "", "", "", ""
%>
<% If View_Paid_OrdersLocal.ID.Visible Then ' ID %>
	<% If View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.ID) = "" Then %>
		<th data-name="ID"><div id="elh_View_Paid_OrdersLocal_ID" class="View_Paid_OrdersLocal_ID"><div class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.ID.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="ID"><div class="ewPointer" onclick="ew_Sort(event,'<%= View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.ID) %>',1);"><div id="elh_View_Paid_OrdersLocal_ID" class="View_Paid_OrdersLocal_ID">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.ID.FldCaption %></span><span class="ewTableHeaderSort"><% If View_Paid_OrdersLocal.ID.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf View_Paid_OrdersLocal.ID.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If View_Paid_OrdersLocal.CreationDate.Visible Then ' CreationDate %>
	<% If View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.CreationDate) = "" Then %>
		<th data-name="CreationDate"><div id="elh_View_Paid_OrdersLocal_CreationDate" class="View_Paid_OrdersLocal_CreationDate"><div class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.CreationDate.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="CreationDate"><div class="ewPointer" onclick="ew_Sort(event,'<%= View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.CreationDate) %>',1);"><div id="elh_View_Paid_OrdersLocal_CreationDate" class="View_Paid_OrdersLocal_CreationDate">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.CreationDate.FldCaption %></span><span class="ewTableHeaderSort"><% If View_Paid_OrdersLocal.CreationDate.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf View_Paid_OrdersLocal.CreationDate.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If View_Paid_OrdersLocal.OrderDate.Visible Then ' OrderDate %>
	<% If View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.OrderDate) = "" Then %>
		<th data-name="OrderDate"><div id="elh_View_Paid_OrdersLocal_OrderDate" class="View_Paid_OrdersLocal_OrderDate"><div class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.OrderDate.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="OrderDate"><div class="ewPointer" onclick="ew_Sort(event,'<%= View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.OrderDate) %>',1);"><div id="elh_View_Paid_OrdersLocal_OrderDate" class="View_Paid_OrdersLocal_OrderDate">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.OrderDate.FldCaption %></span><span class="ewTableHeaderSort"><% If View_Paid_OrdersLocal.OrderDate.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf View_Paid_OrdersLocal.OrderDate.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If View_Paid_OrdersLocal.DeliveryType.Visible Then ' DeliveryType %>
	<% If View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.DeliveryType) = "" Then %>
		<th data-name="DeliveryType"><div id="elh_View_Paid_OrdersLocal_DeliveryType" class="View_Paid_OrdersLocal_DeliveryType"><div class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.DeliveryType.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="DeliveryType"><div class="ewPointer" onclick="ew_Sort(event,'<%= View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.DeliveryType) %>',1);"><div id="elh_View_Paid_OrdersLocal_DeliveryType" class="View_Paid_OrdersLocal_DeliveryType">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.DeliveryType.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If View_Paid_OrdersLocal.DeliveryType.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf View_Paid_OrdersLocal.DeliveryType.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If View_Paid_OrdersLocal.DeliveryTime.Visible Then ' DeliveryTime %>
	<% If View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.DeliveryTime) = "" Then %>
		<th data-name="DeliveryTime"><div id="elh_View_Paid_OrdersLocal_DeliveryTime" class="View_Paid_OrdersLocal_DeliveryTime"><div class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.DeliveryTime.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="DeliveryTime"><div class="ewPointer" onclick="ew_Sort(event,'<%= View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.DeliveryTime) %>',1);"><div id="elh_View_Paid_OrdersLocal_DeliveryTime" class="View_Paid_OrdersLocal_DeliveryTime">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.DeliveryTime.FldCaption %></span><span class="ewTableHeaderSort"><% If View_Paid_OrdersLocal.DeliveryTime.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf View_Paid_OrdersLocal.DeliveryTime.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If View_Paid_OrdersLocal.PaymentType.Visible Then ' PaymentType %>
	<% If View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.PaymentType) = "" Then %>
		<th data-name="PaymentType"><div id="elh_View_Paid_OrdersLocal_PaymentType" class="View_Paid_OrdersLocal_PaymentType"><div class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.PaymentType.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="PaymentType"><div class="ewPointer" onclick="ew_Sort(event,'<%= View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.PaymentType) %>',1);"><div id="elh_View_Paid_OrdersLocal_PaymentType" class="View_Paid_OrdersLocal_PaymentType">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.PaymentType.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If View_Paid_OrdersLocal.PaymentType.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf View_Paid_OrdersLocal.PaymentType.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If View_Paid_OrdersLocal.SubTotal.Visible Then ' SubTotal %>
	<% If View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.SubTotal) = "" Then %>
		<th data-name="SubTotal"><div id="elh_View_Paid_OrdersLocal_SubTotal" class="View_Paid_OrdersLocal_SubTotal"><div class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.SubTotal.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="SubTotal"><div class="ewPointer" onclick="ew_Sort(event,'<%= View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.SubTotal) %>',1);"><div id="elh_View_Paid_OrdersLocal_SubTotal" class="View_Paid_OrdersLocal_SubTotal">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.SubTotal.FldCaption %></span><span class="ewTableHeaderSort"><% If View_Paid_OrdersLocal.SubTotal.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf View_Paid_OrdersLocal.SubTotal.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If View_Paid_OrdersLocal.ShippingFee.Visible Then ' ShippingFee %>
	<% If View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.ShippingFee) = "" Then %>
		<th data-name="ShippingFee"><div id="elh_View_Paid_OrdersLocal_ShippingFee" class="View_Paid_OrdersLocal_ShippingFee"><div class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.ShippingFee.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="ShippingFee"><div class="ewPointer" onclick="ew_Sort(event,'<%= View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.ShippingFee) %>',1);"><div id="elh_View_Paid_OrdersLocal_ShippingFee" class="View_Paid_OrdersLocal_ShippingFee">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.ShippingFee.FldCaption %></span><span class="ewTableHeaderSort"><% If View_Paid_OrdersLocal.ShippingFee.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf View_Paid_OrdersLocal.ShippingFee.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If View_Paid_OrdersLocal.OrderTotal.Visible Then ' OrderTotal %>
	<% If View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.OrderTotal) = "" Then %>
		<th data-name="OrderTotal"><div id="elh_View_Paid_OrdersLocal_OrderTotal" class="View_Paid_OrdersLocal_OrderTotal"><div class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.OrderTotal.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="OrderTotal"><div class="ewPointer" onclick="ew_Sort(event,'<%= View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.OrderTotal) %>',1);"><div id="elh_View_Paid_OrdersLocal_OrderTotal" class="View_Paid_OrdersLocal_OrderTotal">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.OrderTotal.FldCaption %></span><span class="ewTableHeaderSort"><% If View_Paid_OrdersLocal.OrderTotal.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf View_Paid_OrdersLocal.OrderTotal.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If View_Paid_OrdersLocal.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
	<% If View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.IdBusinessDetail) = "" Then %>
		<th data-name="IdBusinessDetail"><div id="elh_View_Paid_OrdersLocal_IdBusinessDetail" class="View_Paid_OrdersLocal_IdBusinessDetail"><div class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.IdBusinessDetail.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="IdBusinessDetail"><div class="ewPointer" onclick="ew_Sort(event,'<%= View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.IdBusinessDetail) %>',1);"><div id="elh_View_Paid_OrdersLocal_IdBusinessDetail" class="View_Paid_OrdersLocal_IdBusinessDetail">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.IdBusinessDetail.FldCaption %></span><span class="ewTableHeaderSort"><% If View_Paid_OrdersLocal.IdBusinessDetail.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf View_Paid_OrdersLocal.IdBusinessDetail.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If View_Paid_OrdersLocal.SessionId.Visible Then ' SessionId %>
	<% If View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.SessionId) = "" Then %>
		<th data-name="SessionId"><div id="elh_View_Paid_OrdersLocal_SessionId" class="View_Paid_OrdersLocal_SessionId"><div class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.SessionId.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="SessionId"><div class="ewPointer" onclick="ew_Sort(event,'<%= View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.SessionId) %>',1);"><div id="elh_View_Paid_OrdersLocal_SessionId" class="View_Paid_OrdersLocal_SessionId">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.SessionId.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If View_Paid_OrdersLocal.SessionId.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf View_Paid_OrdersLocal.SessionId.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If View_Paid_OrdersLocal.FirstName.Visible Then ' FirstName %>
	<% If View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.FirstName) = "" Then %>
		<th data-name="FirstName"><div id="elh_View_Paid_OrdersLocal_FirstName" class="View_Paid_OrdersLocal_FirstName"><div class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.FirstName.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="FirstName"><div class="ewPointer" onclick="ew_Sort(event,'<%= View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.FirstName) %>',1);"><div id="elh_View_Paid_OrdersLocal_FirstName" class="View_Paid_OrdersLocal_FirstName">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.FirstName.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If View_Paid_OrdersLocal.FirstName.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf View_Paid_OrdersLocal.FirstName.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If View_Paid_OrdersLocal.LastName.Visible Then ' LastName %>
	<% If View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.LastName) = "" Then %>
		<th data-name="LastName"><div id="elh_View_Paid_OrdersLocal_LastName" class="View_Paid_OrdersLocal_LastName"><div class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.LastName.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="LastName"><div class="ewPointer" onclick="ew_Sort(event,'<%= View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.LastName) %>',1);"><div id="elh_View_Paid_OrdersLocal_LastName" class="View_Paid_OrdersLocal_LastName">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.LastName.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If View_Paid_OrdersLocal.LastName.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf View_Paid_OrdersLocal.LastName.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If View_Paid_OrdersLocal.zEmail.Visible Then ' Email %>
	<% If View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.zEmail) = "" Then %>
		<th data-name="zEmail"><div id="elh_View_Paid_OrdersLocal_zEmail" class="View_Paid_OrdersLocal_zEmail"><div class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.zEmail.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="zEmail"><div class="ewPointer" onclick="ew_Sort(event,'<%= View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.zEmail) %>',1);"><div id="elh_View_Paid_OrdersLocal_zEmail" class="View_Paid_OrdersLocal_zEmail">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.zEmail.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If View_Paid_OrdersLocal.zEmail.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf View_Paid_OrdersLocal.zEmail.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If View_Paid_OrdersLocal.Phone.Visible Then ' Phone %>
	<% If View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.Phone) = "" Then %>
		<th data-name="Phone"><div id="elh_View_Paid_OrdersLocal_Phone" class="View_Paid_OrdersLocal_Phone"><div class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.Phone.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Phone"><div class="ewPointer" onclick="ew_Sort(event,'<%= View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.Phone) %>',1);"><div id="elh_View_Paid_OrdersLocal_Phone" class="View_Paid_OrdersLocal_Phone">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.Phone.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If View_Paid_OrdersLocal.Phone.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf View_Paid_OrdersLocal.Phone.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If View_Paid_OrdersLocal.Address.Visible Then ' Address %>
	<% If View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.Address) = "" Then %>
		<th data-name="Address"><div id="elh_View_Paid_OrdersLocal_Address" class="View_Paid_OrdersLocal_Address"><div class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.Address.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Address"><div class="ewPointer" onclick="ew_Sort(event,'<%= View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.Address) %>',1);"><div id="elh_View_Paid_OrdersLocal_Address" class="View_Paid_OrdersLocal_Address">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.Address.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If View_Paid_OrdersLocal.Address.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf View_Paid_OrdersLocal.Address.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If View_Paid_OrdersLocal.PostalCode.Visible Then ' PostalCode %>
	<% If View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.PostalCode) = "" Then %>
		<th data-name="PostalCode"><div id="elh_View_Paid_OrdersLocal_PostalCode" class="View_Paid_OrdersLocal_PostalCode"><div class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.PostalCode.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="PostalCode"><div class="ewPointer" onclick="ew_Sort(event,'<%= View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.PostalCode) %>',1);"><div id="elh_View_Paid_OrdersLocal_PostalCode" class="View_Paid_OrdersLocal_PostalCode">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.PostalCode.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If View_Paid_OrdersLocal.PostalCode.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf View_Paid_OrdersLocal.PostalCode.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If View_Paid_OrdersLocal.Notes.Visible Then ' Notes %>
	<% If View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.Notes) = "" Then %>
		<th data-name="Notes"><div id="elh_View_Paid_OrdersLocal_Notes" class="View_Paid_OrdersLocal_Notes"><div class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.Notes.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Notes"><div class="ewPointer" onclick="ew_Sort(event,'<%= View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.Notes) %>',1);"><div id="elh_View_Paid_OrdersLocal_Notes" class="View_Paid_OrdersLocal_Notes">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.Notes.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If View_Paid_OrdersLocal.Notes.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf View_Paid_OrdersLocal.Notes.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If View_Paid_OrdersLocal.ttest.Visible Then ' ttest %>
	<% If View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.ttest) = "" Then %>
		<th data-name="ttest"><div id="elh_View_Paid_OrdersLocal_ttest" class="View_Paid_OrdersLocal_ttest"><div class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.ttest.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="ttest"><div class="ewPointer" onclick="ew_Sort(event,'<%= View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.ttest) %>',1);"><div id="elh_View_Paid_OrdersLocal_ttest" class="View_Paid_OrdersLocal_ttest">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.ttest.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If View_Paid_OrdersLocal.ttest.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf View_Paid_OrdersLocal.ttest.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If View_Paid_OrdersLocal.cancelleddate.Visible Then ' cancelleddate %>
	<% If View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.cancelleddate) = "" Then %>
		<th data-name="cancelleddate"><div id="elh_View_Paid_OrdersLocal_cancelleddate" class="View_Paid_OrdersLocal_cancelleddate"><div class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.cancelleddate.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="cancelleddate"><div class="ewPointer" onclick="ew_Sort(event,'<%= View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.cancelleddate) %>',1);"><div id="elh_View_Paid_OrdersLocal_cancelleddate" class="View_Paid_OrdersLocal_cancelleddate">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.cancelleddate.FldCaption %></span><span class="ewTableHeaderSort"><% If View_Paid_OrdersLocal.cancelleddate.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf View_Paid_OrdersLocal.cancelleddate.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If View_Paid_OrdersLocal.cancelledby.Visible Then ' cancelledby %>
	<% If View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.cancelledby) = "" Then %>
		<th data-name="cancelledby"><div id="elh_View_Paid_OrdersLocal_cancelledby" class="View_Paid_OrdersLocal_cancelledby"><div class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.cancelledby.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="cancelledby"><div class="ewPointer" onclick="ew_Sort(event,'<%= View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.cancelledby) %>',1);"><div id="elh_View_Paid_OrdersLocal_cancelledby" class="View_Paid_OrdersLocal_cancelledby">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.cancelledby.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If View_Paid_OrdersLocal.cancelledby.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf View_Paid_OrdersLocal.cancelledby.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If View_Paid_OrdersLocal.cancelledreason.Visible Then ' cancelledreason %>
	<% If View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.cancelledreason) = "" Then %>
		<th data-name="cancelledreason"><div id="elh_View_Paid_OrdersLocal_cancelledreason" class="View_Paid_OrdersLocal_cancelledreason"><div class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.cancelledreason.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="cancelledreason"><div class="ewPointer" onclick="ew_Sort(event,'<%= View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.cancelledreason) %>',1);"><div id="elh_View_Paid_OrdersLocal_cancelledreason" class="View_Paid_OrdersLocal_cancelledreason">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.cancelledreason.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If View_Paid_OrdersLocal.cancelledreason.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf View_Paid_OrdersLocal.cancelledreason.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If View_Paid_OrdersLocal.acknowledgeddate.Visible Then ' acknowledgeddate %>
	<% If View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.acknowledgeddate) = "" Then %>
		<th data-name="acknowledgeddate"><div id="elh_View_Paid_OrdersLocal_acknowledgeddate" class="View_Paid_OrdersLocal_acknowledgeddate"><div class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.acknowledgeddate.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="acknowledgeddate"><div class="ewPointer" onclick="ew_Sort(event,'<%= View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.acknowledgeddate) %>',1);"><div id="elh_View_Paid_OrdersLocal_acknowledgeddate" class="View_Paid_OrdersLocal_acknowledgeddate">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.acknowledgeddate.FldCaption %></span><span class="ewTableHeaderSort"><% If View_Paid_OrdersLocal.acknowledgeddate.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf View_Paid_OrdersLocal.acknowledgeddate.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If View_Paid_OrdersLocal.delivereddate.Visible Then ' delivereddate %>
	<% If View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.delivereddate) = "" Then %>
		<th data-name="delivereddate"><div id="elh_View_Paid_OrdersLocal_delivereddate" class="View_Paid_OrdersLocal_delivereddate"><div class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.delivereddate.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="delivereddate"><div class="ewPointer" onclick="ew_Sort(event,'<%= View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.delivereddate) %>',1);"><div id="elh_View_Paid_OrdersLocal_delivereddate" class="View_Paid_OrdersLocal_delivereddate">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.delivereddate.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If View_Paid_OrdersLocal.delivereddate.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf View_Paid_OrdersLocal.delivereddate.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If View_Paid_OrdersLocal.cancelled.Visible Then ' cancelled %>
	<% If View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.cancelled) = "" Then %>
		<th data-name="cancelled"><div id="elh_View_Paid_OrdersLocal_cancelled" class="View_Paid_OrdersLocal_cancelled"><div class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.cancelled.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="cancelled"><div class="ewPointer" onclick="ew_Sort(event,'<%= View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.cancelled) %>',1);"><div id="elh_View_Paid_OrdersLocal_cancelled" class="View_Paid_OrdersLocal_cancelled">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.cancelled.FldCaption %></span><span class="ewTableHeaderSort"><% If View_Paid_OrdersLocal.cancelled.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf View_Paid_OrdersLocal.cancelled.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If View_Paid_OrdersLocal.acknowledged.Visible Then ' acknowledged %>
	<% If View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.acknowledged) = "" Then %>
		<th data-name="acknowledged"><div id="elh_View_Paid_OrdersLocal_acknowledged" class="View_Paid_OrdersLocal_acknowledged"><div class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.acknowledged.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="acknowledged"><div class="ewPointer" onclick="ew_Sort(event,'<%= View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.acknowledged) %>',1);"><div id="elh_View_Paid_OrdersLocal_acknowledged" class="View_Paid_OrdersLocal_acknowledged">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.acknowledged.FldCaption %></span><span class="ewTableHeaderSort"><% If View_Paid_OrdersLocal.acknowledged.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf View_Paid_OrdersLocal.acknowledged.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If View_Paid_OrdersLocal.outfordelivery.Visible Then ' outfordelivery %>
	<% If View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.outfordelivery) = "" Then %>
		<th data-name="outfordelivery"><div id="elh_View_Paid_OrdersLocal_outfordelivery" class="View_Paid_OrdersLocal_outfordelivery"><div class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.outfordelivery.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="outfordelivery"><div class="ewPointer" onclick="ew_Sort(event,'<%= View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.outfordelivery) %>',1);"><div id="elh_View_Paid_OrdersLocal_outfordelivery" class="View_Paid_OrdersLocal_outfordelivery">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.outfordelivery.FldCaption %></span><span class="ewTableHeaderSort"><% If View_Paid_OrdersLocal.outfordelivery.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf View_Paid_OrdersLocal.outfordelivery.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If View_Paid_OrdersLocal.vouchercodediscount.Visible Then ' vouchercodediscount %>
	<% If View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.vouchercodediscount) = "" Then %>
		<th data-name="vouchercodediscount"><div id="elh_View_Paid_OrdersLocal_vouchercodediscount" class="View_Paid_OrdersLocal_vouchercodediscount"><div class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.vouchercodediscount.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="vouchercodediscount"><div class="ewPointer" onclick="ew_Sort(event,'<%= View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.vouchercodediscount) %>',1);"><div id="elh_View_Paid_OrdersLocal_vouchercodediscount" class="View_Paid_OrdersLocal_vouchercodediscount">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.vouchercodediscount.FldCaption %></span><span class="ewTableHeaderSort"><% If View_Paid_OrdersLocal.vouchercodediscount.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf View_Paid_OrdersLocal.vouchercodediscount.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If View_Paid_OrdersLocal.vouchercode.Visible Then ' vouchercode %>
	<% If View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.vouchercode) = "" Then %>
		<th data-name="vouchercode"><div id="elh_View_Paid_OrdersLocal_vouchercode" class="View_Paid_OrdersLocal_vouchercode"><div class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.vouchercode.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="vouchercode"><div class="ewPointer" onclick="ew_Sort(event,'<%= View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.vouchercode) %>',1);"><div id="elh_View_Paid_OrdersLocal_vouchercode" class="View_Paid_OrdersLocal_vouchercode">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.vouchercode.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If View_Paid_OrdersLocal.vouchercode.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf View_Paid_OrdersLocal.vouchercode.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If View_Paid_OrdersLocal.printed.Visible Then ' printed %>
	<% If View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.printed) = "" Then %>
		<th data-name="printed"><div id="elh_View_Paid_OrdersLocal_printed" class="View_Paid_OrdersLocal_printed"><div class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.printed.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="printed"><div class="ewPointer" onclick="ew_Sort(event,'<%= View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.printed) %>',1);"><div id="elh_View_Paid_OrdersLocal_printed" class="View_Paid_OrdersLocal_printed">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.printed.FldCaption %></span><span class="ewTableHeaderSort"><% If View_Paid_OrdersLocal.printed.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf View_Paid_OrdersLocal.printed.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If View_Paid_OrdersLocal.deliverydistance.Visible Then ' deliverydistance %>
	<% If View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.deliverydistance) = "" Then %>
		<th data-name="deliverydistance"><div id="elh_View_Paid_OrdersLocal_deliverydistance" class="View_Paid_OrdersLocal_deliverydistance"><div class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.deliverydistance.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="deliverydistance"><div class="ewPointer" onclick="ew_Sort(event,'<%= View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.deliverydistance) %>',1);"><div id="elh_View_Paid_OrdersLocal_deliverydistance" class="View_Paid_OrdersLocal_deliverydistance">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.deliverydistance.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If View_Paid_OrdersLocal.deliverydistance.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf View_Paid_OrdersLocal.deliverydistance.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If View_Paid_OrdersLocal.asaporder.Visible Then ' asaporder %>
	<% If View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.asaporder) = "" Then %>
		<th data-name="asaporder"><div id="elh_View_Paid_OrdersLocal_asaporder" class="View_Paid_OrdersLocal_asaporder"><div class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.asaporder.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="asaporder"><div class="ewPointer" onclick="ew_Sort(event,'<%= View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.asaporder) %>',1);"><div id="elh_View_Paid_OrdersLocal_asaporder" class="View_Paid_OrdersLocal_asaporder">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.asaporder.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If View_Paid_OrdersLocal.asaporder.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf View_Paid_OrdersLocal.asaporder.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If View_Paid_OrdersLocal.DeliveryLat.Visible Then ' DeliveryLat %>
	<% If View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.DeliveryLat) = "" Then %>
		<th data-name="DeliveryLat"><div id="elh_View_Paid_OrdersLocal_DeliveryLat" class="View_Paid_OrdersLocal_DeliveryLat"><div class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.DeliveryLat.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="DeliveryLat"><div class="ewPointer" onclick="ew_Sort(event,'<%= View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.DeliveryLat) %>',1);"><div id="elh_View_Paid_OrdersLocal_DeliveryLat" class="View_Paid_OrdersLocal_DeliveryLat">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.DeliveryLat.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If View_Paid_OrdersLocal.DeliveryLat.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf View_Paid_OrdersLocal.DeliveryLat.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If View_Paid_OrdersLocal.DeliveryLng.Visible Then ' DeliveryLng %>
	<% If View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.DeliveryLng) = "" Then %>
		<th data-name="DeliveryLng"><div id="elh_View_Paid_OrdersLocal_DeliveryLng" class="View_Paid_OrdersLocal_DeliveryLng"><div class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.DeliveryLng.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="DeliveryLng"><div class="ewPointer" onclick="ew_Sort(event,'<%= View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.DeliveryLng) %>',1);"><div id="elh_View_Paid_OrdersLocal_DeliveryLng" class="View_Paid_OrdersLocal_DeliveryLng">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.DeliveryLng.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If View_Paid_OrdersLocal.DeliveryLng.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf View_Paid_OrdersLocal.DeliveryLng.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If View_Paid_OrdersLocal.ServiceCharge.Visible Then ' ServiceCharge %>
	<% If View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.ServiceCharge) = "" Then %>
		<th data-name="ServiceCharge"><div id="elh_View_Paid_OrdersLocal_ServiceCharge" class="View_Paid_OrdersLocal_ServiceCharge"><div class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.ServiceCharge.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="ServiceCharge"><div class="ewPointer" onclick="ew_Sort(event,'<%= View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.ServiceCharge) %>',1);"><div id="elh_View_Paid_OrdersLocal_ServiceCharge" class="View_Paid_OrdersLocal_ServiceCharge">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.ServiceCharge.FldCaption %></span><span class="ewTableHeaderSort"><% If View_Paid_OrdersLocal.ServiceCharge.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf View_Paid_OrdersLocal.ServiceCharge.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If View_Paid_OrdersLocal.PaymentSurcharge.Visible Then ' PaymentSurcharge %>
	<% If View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.PaymentSurcharge) = "" Then %>
		<th data-name="PaymentSurcharge"><div id="elh_View_Paid_OrdersLocal_PaymentSurcharge" class="View_Paid_OrdersLocal_PaymentSurcharge"><div class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.PaymentSurcharge.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="PaymentSurcharge"><div class="ewPointer" onclick="ew_Sort(event,'<%= View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.PaymentSurcharge) %>',1);"><div id="elh_View_Paid_OrdersLocal_PaymentSurcharge" class="View_Paid_OrdersLocal_PaymentSurcharge">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.PaymentSurcharge.FldCaption %></span><span class="ewTableHeaderSort"><% If View_Paid_OrdersLocal.PaymentSurcharge.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf View_Paid_OrdersLocal.PaymentSurcharge.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If View_Paid_OrdersLocal.Tax_Rate.Visible Then ' Tax_Rate %>
	<% If View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.Tax_Rate) = "" Then %>
		<th data-name="Tax_Rate"><div id="elh_View_Paid_OrdersLocal_Tax_Rate" class="View_Paid_OrdersLocal_Tax_Rate"><div class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.Tax_Rate.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Tax_Rate"><div class="ewPointer" onclick="ew_Sort(event,'<%= View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.Tax_Rate) %>',1);"><div id="elh_View_Paid_OrdersLocal_Tax_Rate" class="View_Paid_OrdersLocal_Tax_Rate">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.Tax_Rate.FldCaption %></span><span class="ewTableHeaderSort"><% If View_Paid_OrdersLocal.Tax_Rate.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf View_Paid_OrdersLocal.Tax_Rate.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If View_Paid_OrdersLocal.Tax_Amount.Visible Then ' Tax_Amount %>
	<% If View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.Tax_Amount) = "" Then %>
		<th data-name="Tax_Amount"><div id="elh_View_Paid_OrdersLocal_Tax_Amount" class="View_Paid_OrdersLocal_Tax_Amount"><div class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.Tax_Amount.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Tax_Amount"><div class="ewPointer" onclick="ew_Sort(event,'<%= View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.Tax_Amount) %>',1);"><div id="elh_View_Paid_OrdersLocal_Tax_Amount" class="View_Paid_OrdersLocal_Tax_Amount">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.Tax_Amount.FldCaption %></span><span class="ewTableHeaderSort"><% If View_Paid_OrdersLocal.Tax_Amount.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf View_Paid_OrdersLocal.Tax_Amount.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If View_Paid_OrdersLocal.Tip_Rate.Visible Then ' Tip_Rate %>
	<% If View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.Tip_Rate) = "" Then %>
		<th data-name="Tip_Rate"><div id="elh_View_Paid_OrdersLocal_Tip_Rate" class="View_Paid_OrdersLocal_Tip_Rate"><div class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.Tip_Rate.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Tip_Rate"><div class="ewPointer" onclick="ew_Sort(event,'<%= View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.Tip_Rate) %>',1);"><div id="elh_View_Paid_OrdersLocal_Tip_Rate" class="View_Paid_OrdersLocal_Tip_Rate">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.Tip_Rate.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If View_Paid_OrdersLocal.Tip_Rate.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf View_Paid_OrdersLocal.Tip_Rate.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If View_Paid_OrdersLocal.Tip_Amount.Visible Then ' Tip_Amount %>
	<% If View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.Tip_Amount) = "" Then %>
		<th data-name="Tip_Amount"><div id="elh_View_Paid_OrdersLocal_Tip_Amount" class="View_Paid_OrdersLocal_Tip_Amount"><div class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.Tip_Amount.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Tip_Amount"><div class="ewPointer" onclick="ew_Sort(event,'<%= View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.Tip_Amount) %>',1);"><div id="elh_View_Paid_OrdersLocal_Tip_Amount" class="View_Paid_OrdersLocal_Tip_Amount">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.Tip_Amount.FldCaption %></span><span class="ewTableHeaderSort"><% If View_Paid_OrdersLocal.Tip_Amount.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf View_Paid_OrdersLocal.Tip_Amount.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If View_Paid_OrdersLocal.Payment_Status.Visible Then ' Payment_Status %>
	<% If View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.Payment_Status) = "" Then %>
		<th data-name="Payment_Status"><div id="elh_View_Paid_OrdersLocal_Payment_Status" class="View_Paid_OrdersLocal_Payment_Status"><div class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.Payment_Status.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Payment_Status"><div class="ewPointer" onclick="ew_Sort(event,'<%= View_Paid_OrdersLocal.SortUrl(View_Paid_OrdersLocal.Payment_Status) %>',1);"><div id="elh_View_Paid_OrdersLocal_Payment_Status" class="View_Paid_OrdersLocal_Payment_Status">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= View_Paid_OrdersLocal.Payment_Status.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If View_Paid_OrdersLocal.Payment_Status.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf View_Paid_OrdersLocal.Payment_Status.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<%

' Render list options (header, right)
View_Paid_OrdersLocal_list.ListOptions.Render "header", "right", "", "", "", ""
%>
	</tr>
</thead>
<tbody><!-- Table body -->
<%
If (View_Paid_OrdersLocal.ExportAll And View_Paid_OrdersLocal.Export <> "") Then
	View_Paid_OrdersLocal_list.StopRec = View_Paid_OrdersLocal_list.TotalRecs
Else

	' Set the last record to display
	If View_Paid_OrdersLocal_list.TotalRecs > View_Paid_OrdersLocal_list.StartRec + View_Paid_OrdersLocal_list.DisplayRecs - 1 Then
		View_Paid_OrdersLocal_list.StopRec = View_Paid_OrdersLocal_list.StartRec + View_Paid_OrdersLocal_list.DisplayRecs - 1
	Else
		View_Paid_OrdersLocal_list.StopRec = View_Paid_OrdersLocal_list.TotalRecs
	End If
End If

' Move to first record
View_Paid_OrdersLocal_list.RecCnt = View_Paid_OrdersLocal_list.StartRec - 1
If Not View_Paid_OrdersLocal_list.Recordset.Eof Then
	View_Paid_OrdersLocal_list.Recordset.MoveFirst
	If View_Paid_OrdersLocal_list.StartRec > 1 Then View_Paid_OrdersLocal_list.Recordset.Move View_Paid_OrdersLocal_list.StartRec - 1
ElseIf Not View_Paid_OrdersLocal.AllowAddDeleteRow And View_Paid_OrdersLocal_list.StopRec = 0 Then
	View_Paid_OrdersLocal_list.StopRec = View_Paid_OrdersLocal.GridAddRowCount
End If

' Initialize Aggregate
View_Paid_OrdersLocal.RowType = EW_ROWTYPE_AGGREGATEINIT
Call View_Paid_OrdersLocal.ResetAttrs()
Call View_Paid_OrdersLocal_list.RenderRow()
View_Paid_OrdersLocal_list.RowCnt = 0

' Output date rows
Do While CLng(View_Paid_OrdersLocal_list.RecCnt) < CLng(View_Paid_OrdersLocal_list.StopRec)
	View_Paid_OrdersLocal_list.RecCnt = View_Paid_OrdersLocal_list.RecCnt + 1
	If CLng(View_Paid_OrdersLocal_list.RecCnt) >= CLng(View_Paid_OrdersLocal_list.StartRec) Then
		View_Paid_OrdersLocal_list.RowCnt = View_Paid_OrdersLocal_list.RowCnt + 1

	' Set up key count
	View_Paid_OrdersLocal_list.KeyCount = View_Paid_OrdersLocal_list.RowIndex
	Call View_Paid_OrdersLocal.ResetAttrs()
	View_Paid_OrdersLocal.CssClass = ""
	If View_Paid_OrdersLocal.CurrentAction = "gridadd" Then
	Else
		Call View_Paid_OrdersLocal_list.LoadRowValues(View_Paid_OrdersLocal_list.Recordset) ' Load row values
	End If
	View_Paid_OrdersLocal.RowType = EW_ROWTYPE_VIEW ' Render view

	' Set up row id / data-rowindex
	View_Paid_OrdersLocal.RowAttrs.AddAttributes Array(Array("data-rowindex", View_Paid_OrdersLocal_list.RowCnt), Array("id", "r" & View_Paid_OrdersLocal_list.RowCnt & "_View_Paid_OrdersLocal"), Array("data-rowtype", View_Paid_OrdersLocal.RowType))

	' Render row
	Call View_Paid_OrdersLocal_list.RenderRow()

	' Render list options
	Call View_Paid_OrdersLocal_list.RenderListOptions()
%>
	<tr<%= View_Paid_OrdersLocal.RowAttributes %>>
<%

' Render list options (body, left)
View_Paid_OrdersLocal_list.ListOptions.Render "body", "left", View_Paid_OrdersLocal_list.RowCnt, "", "", ""
%>
	<% If View_Paid_OrdersLocal.ID.Visible Then ' ID %>
		<td data-name="ID"<%= View_Paid_OrdersLocal.ID.CellAttributes %>>
<span<%= View_Paid_OrdersLocal.ID.ViewAttributes %>>
<%= View_Paid_OrdersLocal.ID.ListViewValue %>
</span>
<a id="<%= View_Paid_OrdersLocal_list.PageObjName & "_row_" & View_Paid_OrdersLocal_list.RowCnt %>"></a></td>
	<% End If %>
	<% If View_Paid_OrdersLocal.CreationDate.Visible Then ' CreationDate %>
		<td data-name="CreationDate"<%= View_Paid_OrdersLocal.CreationDate.CellAttributes %>>
<span<%= View_Paid_OrdersLocal.CreationDate.ViewAttributes %>>
<%= View_Paid_OrdersLocal.CreationDate.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If View_Paid_OrdersLocal.OrderDate.Visible Then ' OrderDate %>
		<td data-name="OrderDate"<%= View_Paid_OrdersLocal.OrderDate.CellAttributes %>>
<span<%= View_Paid_OrdersLocal.OrderDate.ViewAttributes %>>
<%= View_Paid_OrdersLocal.OrderDate.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If View_Paid_OrdersLocal.DeliveryType.Visible Then ' DeliveryType %>
		<td data-name="DeliveryType"<%= View_Paid_OrdersLocal.DeliveryType.CellAttributes %>>
<span<%= View_Paid_OrdersLocal.DeliveryType.ViewAttributes %>>
<%= View_Paid_OrdersLocal.DeliveryType.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If View_Paid_OrdersLocal.DeliveryTime.Visible Then ' DeliveryTime %>
		<td data-name="DeliveryTime"<%= View_Paid_OrdersLocal.DeliveryTime.CellAttributes %>>
<span<%= View_Paid_OrdersLocal.DeliveryTime.ViewAttributes %>>
<%= View_Paid_OrdersLocal.DeliveryTime.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If View_Paid_OrdersLocal.PaymentType.Visible Then ' PaymentType %>
		<td data-name="PaymentType"<%= View_Paid_OrdersLocal.PaymentType.CellAttributes %>>
<span<%= View_Paid_OrdersLocal.PaymentType.ViewAttributes %>>
<%= View_Paid_OrdersLocal.PaymentType.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If View_Paid_OrdersLocal.SubTotal.Visible Then ' SubTotal %>
		<td data-name="SubTotal"<%= View_Paid_OrdersLocal.SubTotal.CellAttributes %>>
<span<%= View_Paid_OrdersLocal.SubTotal.ViewAttributes %>>
<%= View_Paid_OrdersLocal.SubTotal.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If View_Paid_OrdersLocal.ShippingFee.Visible Then ' ShippingFee %>
		<td data-name="ShippingFee"<%= View_Paid_OrdersLocal.ShippingFee.CellAttributes %>>
<span<%= View_Paid_OrdersLocal.ShippingFee.ViewAttributes %>>
<%= View_Paid_OrdersLocal.ShippingFee.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If View_Paid_OrdersLocal.OrderTotal.Visible Then ' OrderTotal %>
		<td data-name="OrderTotal"<%= View_Paid_OrdersLocal.OrderTotal.CellAttributes %>>
<span<%= View_Paid_OrdersLocal.OrderTotal.ViewAttributes %>>
<%= View_Paid_OrdersLocal.OrderTotal.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If View_Paid_OrdersLocal.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
		<td data-name="IdBusinessDetail"<%= View_Paid_OrdersLocal.IdBusinessDetail.CellAttributes %>>
<span<%= View_Paid_OrdersLocal.IdBusinessDetail.ViewAttributes %>>
<%= View_Paid_OrdersLocal.IdBusinessDetail.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If View_Paid_OrdersLocal.SessionId.Visible Then ' SessionId %>
		<td data-name="SessionId"<%= View_Paid_OrdersLocal.SessionId.CellAttributes %>>
<span<%= View_Paid_OrdersLocal.SessionId.ViewAttributes %>>
<%= View_Paid_OrdersLocal.SessionId.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If View_Paid_OrdersLocal.FirstName.Visible Then ' FirstName %>
		<td data-name="FirstName"<%= View_Paid_OrdersLocal.FirstName.CellAttributes %>>
<span<%= View_Paid_OrdersLocal.FirstName.ViewAttributes %>>
<%= View_Paid_OrdersLocal.FirstName.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If View_Paid_OrdersLocal.LastName.Visible Then ' LastName %>
		<td data-name="LastName"<%= View_Paid_OrdersLocal.LastName.CellAttributes %>>
<span<%= View_Paid_OrdersLocal.LastName.ViewAttributes %>>
<%= View_Paid_OrdersLocal.LastName.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If View_Paid_OrdersLocal.zEmail.Visible Then ' Email %>
		<td data-name="zEmail"<%= View_Paid_OrdersLocal.zEmail.CellAttributes %>>
<span<%= View_Paid_OrdersLocal.zEmail.ViewAttributes %>>
<%= View_Paid_OrdersLocal.zEmail.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If View_Paid_OrdersLocal.Phone.Visible Then ' Phone %>
		<td data-name="Phone"<%= View_Paid_OrdersLocal.Phone.CellAttributes %>>
<span<%= View_Paid_OrdersLocal.Phone.ViewAttributes %>>
<%= View_Paid_OrdersLocal.Phone.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If View_Paid_OrdersLocal.Address.Visible Then ' Address %>
		<td data-name="Address"<%= View_Paid_OrdersLocal.Address.CellAttributes %>>
<span<%= View_Paid_OrdersLocal.Address.ViewAttributes %>>
<%= View_Paid_OrdersLocal.Address.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If View_Paid_OrdersLocal.PostalCode.Visible Then ' PostalCode %>
		<td data-name="PostalCode"<%= View_Paid_OrdersLocal.PostalCode.CellAttributes %>>
<span<%= View_Paid_OrdersLocal.PostalCode.ViewAttributes %>>
<%= View_Paid_OrdersLocal.PostalCode.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If View_Paid_OrdersLocal.Notes.Visible Then ' Notes %>
		<td data-name="Notes"<%= View_Paid_OrdersLocal.Notes.CellAttributes %>>
<span<%= View_Paid_OrdersLocal.Notes.ViewAttributes %>>
<%= View_Paid_OrdersLocal.Notes.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If View_Paid_OrdersLocal.ttest.Visible Then ' ttest %>
		<td data-name="ttest"<%= View_Paid_OrdersLocal.ttest.CellAttributes %>>
<span<%= View_Paid_OrdersLocal.ttest.ViewAttributes %>>
<%= View_Paid_OrdersLocal.ttest.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If View_Paid_OrdersLocal.cancelleddate.Visible Then ' cancelleddate %>
		<td data-name="cancelleddate"<%= View_Paid_OrdersLocal.cancelleddate.CellAttributes %>>
<span<%= View_Paid_OrdersLocal.cancelleddate.ViewAttributes %>>
<%= View_Paid_OrdersLocal.cancelleddate.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If View_Paid_OrdersLocal.cancelledby.Visible Then ' cancelledby %>
		<td data-name="cancelledby"<%= View_Paid_OrdersLocal.cancelledby.CellAttributes %>>
<span<%= View_Paid_OrdersLocal.cancelledby.ViewAttributes %>>
<%= View_Paid_OrdersLocal.cancelledby.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If View_Paid_OrdersLocal.cancelledreason.Visible Then ' cancelledreason %>
		<td data-name="cancelledreason"<%= View_Paid_OrdersLocal.cancelledreason.CellAttributes %>>
<span<%= View_Paid_OrdersLocal.cancelledreason.ViewAttributes %>>
<%= View_Paid_OrdersLocal.cancelledreason.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If View_Paid_OrdersLocal.acknowledgeddate.Visible Then ' acknowledgeddate %>
		<td data-name="acknowledgeddate"<%= View_Paid_OrdersLocal.acknowledgeddate.CellAttributes %>>
<span<%= View_Paid_OrdersLocal.acknowledgeddate.ViewAttributes %>>
<%= View_Paid_OrdersLocal.acknowledgeddate.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If View_Paid_OrdersLocal.delivereddate.Visible Then ' delivereddate %>
		<td data-name="delivereddate"<%= View_Paid_OrdersLocal.delivereddate.CellAttributes %>>
<span<%= View_Paid_OrdersLocal.delivereddate.ViewAttributes %>>
<%= View_Paid_OrdersLocal.delivereddate.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If View_Paid_OrdersLocal.cancelled.Visible Then ' cancelled %>
		<td data-name="cancelled"<%= View_Paid_OrdersLocal.cancelled.CellAttributes %>>
<span<%= View_Paid_OrdersLocal.cancelled.ViewAttributes %>>
<%= View_Paid_OrdersLocal.cancelled.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If View_Paid_OrdersLocal.acknowledged.Visible Then ' acknowledged %>
		<td data-name="acknowledged"<%= View_Paid_OrdersLocal.acknowledged.CellAttributes %>>
<span<%= View_Paid_OrdersLocal.acknowledged.ViewAttributes %>>
<%= View_Paid_OrdersLocal.acknowledged.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If View_Paid_OrdersLocal.outfordelivery.Visible Then ' outfordelivery %>
		<td data-name="outfordelivery"<%= View_Paid_OrdersLocal.outfordelivery.CellAttributes %>>
<span<%= View_Paid_OrdersLocal.outfordelivery.ViewAttributes %>>
<%= View_Paid_OrdersLocal.outfordelivery.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If View_Paid_OrdersLocal.vouchercodediscount.Visible Then ' vouchercodediscount %>
		<td data-name="vouchercodediscount"<%= View_Paid_OrdersLocal.vouchercodediscount.CellAttributes %>>
<span<%= View_Paid_OrdersLocal.vouchercodediscount.ViewAttributes %>>
<%= View_Paid_OrdersLocal.vouchercodediscount.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If View_Paid_OrdersLocal.vouchercode.Visible Then ' vouchercode %>
		<td data-name="vouchercode"<%= View_Paid_OrdersLocal.vouchercode.CellAttributes %>>
<span<%= View_Paid_OrdersLocal.vouchercode.ViewAttributes %>>
<%= View_Paid_OrdersLocal.vouchercode.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If View_Paid_OrdersLocal.printed.Visible Then ' printed %>
		<td data-name="printed"<%= View_Paid_OrdersLocal.printed.CellAttributes %>>
<span<%= View_Paid_OrdersLocal.printed.ViewAttributes %>>
<%= View_Paid_OrdersLocal.printed.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If View_Paid_OrdersLocal.deliverydistance.Visible Then ' deliverydistance %>
		<td data-name="deliverydistance"<%= View_Paid_OrdersLocal.deliverydistance.CellAttributes %>>
<span<%= View_Paid_OrdersLocal.deliverydistance.ViewAttributes %>>
<%= View_Paid_OrdersLocal.deliverydistance.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If View_Paid_OrdersLocal.asaporder.Visible Then ' asaporder %>
		<td data-name="asaporder"<%= View_Paid_OrdersLocal.asaporder.CellAttributes %>>
<span<%= View_Paid_OrdersLocal.asaporder.ViewAttributes %>>
<%= View_Paid_OrdersLocal.asaporder.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If View_Paid_OrdersLocal.DeliveryLat.Visible Then ' DeliveryLat %>
		<td data-name="DeliveryLat"<%= View_Paid_OrdersLocal.DeliveryLat.CellAttributes %>>
<span<%= View_Paid_OrdersLocal.DeliveryLat.ViewAttributes %>>
<%= View_Paid_OrdersLocal.DeliveryLat.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If View_Paid_OrdersLocal.DeliveryLng.Visible Then ' DeliveryLng %>
		<td data-name="DeliveryLng"<%= View_Paid_OrdersLocal.DeliveryLng.CellAttributes %>>
<span<%= View_Paid_OrdersLocal.DeliveryLng.ViewAttributes %>>
<%= View_Paid_OrdersLocal.DeliveryLng.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If View_Paid_OrdersLocal.ServiceCharge.Visible Then ' ServiceCharge %>
		<td data-name="ServiceCharge"<%= View_Paid_OrdersLocal.ServiceCharge.CellAttributes %>>
<span<%= View_Paid_OrdersLocal.ServiceCharge.ViewAttributes %>>
<%= View_Paid_OrdersLocal.ServiceCharge.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If View_Paid_OrdersLocal.PaymentSurcharge.Visible Then ' PaymentSurcharge %>
		<td data-name="PaymentSurcharge"<%= View_Paid_OrdersLocal.PaymentSurcharge.CellAttributes %>>
<span<%= View_Paid_OrdersLocal.PaymentSurcharge.ViewAttributes %>>
<%= View_Paid_OrdersLocal.PaymentSurcharge.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If View_Paid_OrdersLocal.Tax_Rate.Visible Then ' Tax_Rate %>
		<td data-name="Tax_Rate"<%= View_Paid_OrdersLocal.Tax_Rate.CellAttributes %>>
<span<%= View_Paid_OrdersLocal.Tax_Rate.ViewAttributes %>>
<%= View_Paid_OrdersLocal.Tax_Rate.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If View_Paid_OrdersLocal.Tax_Amount.Visible Then ' Tax_Amount %>
		<td data-name="Tax_Amount"<%= View_Paid_OrdersLocal.Tax_Amount.CellAttributes %>>
<span<%= View_Paid_OrdersLocal.Tax_Amount.ViewAttributes %>>
<%= View_Paid_OrdersLocal.Tax_Amount.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If View_Paid_OrdersLocal.Tip_Rate.Visible Then ' Tip_Rate %>
		<td data-name="Tip_Rate"<%= View_Paid_OrdersLocal.Tip_Rate.CellAttributes %>>
<span<%= View_Paid_OrdersLocal.Tip_Rate.ViewAttributes %>>
<%= View_Paid_OrdersLocal.Tip_Rate.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If View_Paid_OrdersLocal.Tip_Amount.Visible Then ' Tip_Amount %>
		<td data-name="Tip_Amount"<%= View_Paid_OrdersLocal.Tip_Amount.CellAttributes %>>
<span<%= View_Paid_OrdersLocal.Tip_Amount.ViewAttributes %>>
<%= View_Paid_OrdersLocal.Tip_Amount.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If View_Paid_OrdersLocal.Payment_Status.Visible Then ' Payment_Status %>
		<td data-name="Payment_Status"<%= View_Paid_OrdersLocal.Payment_Status.CellAttributes %>>
<span<%= View_Paid_OrdersLocal.Payment_Status.ViewAttributes %>>
<%= View_Paid_OrdersLocal.Payment_Status.ListViewValue %>
</span>
</td>
	<% End If %>
<%

' Render list options (body, right)
View_Paid_OrdersLocal_list.ListOptions.Render "body", "right", View_Paid_OrdersLocal_list.RowCnt, "", "", ""
%>
	</tr>
<%
	End If
	If View_Paid_OrdersLocal.CurrentAction <> "gridadd" Then
		View_Paid_OrdersLocal_list.Recordset.MoveNext()
	End If
Loop
%>
</tbody>
</table>
<% End If %>
<% If View_Paid_OrdersLocal.CurrentAction = "" Then %>
<input type="hidden" name="a_list" id="a_list" value="">
<% End If %>
</div>
</form>
<%

' Close recordset and connection
View_Paid_OrdersLocal_list.Recordset.Close
Set View_Paid_OrdersLocal_list.Recordset = Nothing
%>
<% If View_Paid_OrdersLocal.Export = "" Then %>
<div class="ewGridLowerPanel">
<% If View_Paid_OrdersLocal.CurrentAction <> "gridadd" And View_Paid_OrdersLocal.CurrentAction <> "gridedit" Then %>
<form name="ewPagerForm" class="ewForm form-inline ewPagerForm" action="<%= ew_CurrentPage %>">
<% If Not IsObject(View_Paid_OrdersLocal_list.Pager) Then Set View_Paid_OrdersLocal_list.Pager = ew_NewPrevNextPager(View_Paid_OrdersLocal_list.StartRec, View_Paid_OrdersLocal_list.DisplayRecs, View_Paid_OrdersLocal_list.TotalRecs) %>
<% If View_Paid_OrdersLocal_list.Pager.RecordCount > 0 Then %>
<div class="ewPager">
<span><%= Language.Phrase("Page") %>&nbsp;</span>
<div class="ewPrevNext"><div class="input-group">
<div class="input-group-btn">
<!--first page button-->
	<% If View_Paid_OrdersLocal_list.Pager.FirstButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerFirst") %>" href="<%= View_Paid_OrdersLocal_list.PageUrl %>start=<%= View_Paid_OrdersLocal_list.Pager.FirstButton.Start %>"><span class="icon-first ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerFirst") %>"><span class="icon-first ewIcon"></span></a>
	<% End If %>
<!--previous page button-->
	<% If View_Paid_OrdersLocal_list.Pager.PrevButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerPrevious") %>" href="<%= View_Paid_OrdersLocal_list.PageUrl %>start=<%= View_Paid_OrdersLocal_list.Pager.PrevButton.Start %>"><span class="icon-prev ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerPrevious") %>"><span class="icon-prev ewIcon"></span></a>
	<% End If %>
</div>
<!--current page number-->
	<input class="form-control input-sm" type="text" name="<%= EW_TABLE_PAGE_NO %>" value="<%= View_Paid_OrdersLocal_list.Pager.CurrentPage %>">
<div class="input-group-btn">
<!--next page button-->
	<% If View_Paid_OrdersLocal_list.Pager.NextButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerNext") %>" href="<%= View_Paid_OrdersLocal_list.PageUrl %>start=<%= View_Paid_OrdersLocal_list.Pager.NextButton.Start %>"><span class="icon-next ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerNext") %>"><span class="icon-next ewIcon"></span></a>
	<% End If %>
<!--last page button-->
	<% If View_Paid_OrdersLocal_list.Pager.LastButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerLast") %>" href="<%= View_Paid_OrdersLocal_list.PageUrl %>start=<%= View_Paid_OrdersLocal_list.Pager.LastButton.Start %>"><span class="icon-last ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerLast") %>"><span class="icon-last ewIcon"></span></a>
	<% End If %>
</div>
</div>
</div>
<span>&nbsp;<%= Language.Phrase("of") %>&nbsp;<%= View_Paid_OrdersLocal_list.Pager.PageCount %></span>
</div>
<div class="ewPager ewRec">
	<span><%= Language.Phrase("Record") %>&nbsp;<%= View_Paid_OrdersLocal_list.Pager.FromIndex %>&nbsp;<%= Language.Phrase("To") %>&nbsp;<%= View_Paid_OrdersLocal_list.Pager.ToIndex %>&nbsp;<%= Language.Phrase("Of") %>&nbsp;<%= View_Paid_OrdersLocal_list.Pager.RecordCount %></span>
</div>
<% End If %>
<% If View_Paid_OrdersLocal_list.TotalRecs > 0 Then %>
<div class="ewPager">
<input type="hidden" name="t" value="View_Paid_OrdersLocal">
<select name="<%= EW_TABLE_REC_PER_PAGE %>" class="form-control input-sm" onchange="this.form.submit();">
<option value="20"<% If View_Paid_OrdersLocal_list.DisplayRecs = 20 Then %> selected="selected"<% End If %>>20</option>
<option value="50"<% If View_Paid_OrdersLocal_list.DisplayRecs = 50 Then %> selected="selected"<% End If %>>50</option>
<option value="100"<% If View_Paid_OrdersLocal_list.DisplayRecs = 100 Then %> selected="selected"<% End If %>>100</option>
<option value="500"<% If View_Paid_OrdersLocal_list.DisplayRecs = 500 Then %> selected="selected"<% End If %>>500</option>
<option value="1000"<% If View_Paid_OrdersLocal_list.DisplayRecs = 1000 Then %> selected="selected"<% End If %>>1000</option>
<option value="ALL"<% If View_Paid_OrdersLocal.RecordsPerPage = -1 Then %> selected="selected"<% End If %>><%= Language.Phrase("AllRecords") %></option>
</select>
</div>
<% End If %>
</form>
<% End If %>
<div class="ewListOtherOptions">
<%
	View_Paid_OrdersLocal_list.AddEditOptions.Render "body", "bottom", "", "", "", ""
	View_Paid_OrdersLocal_list.DetailOptions.Render "body", "bottom", "", "", "", ""
	View_Paid_OrdersLocal_list.ActionOptions.Render "body", "bottom", "", "", "", ""
%>
</div>
<div class="clearfix"></div>
</div>
<% End If %>
</div>
<% End If %>
<% If View_Paid_OrdersLocal_list.TotalRecs = 0 And View_Paid_OrdersLocal.CurrentAction = "" Then ' Show other options %>
<div class="ewListOtherOptions">
<%
	View_Paid_OrdersLocal_list.AddEditOptions.Render "body", "", "", "", "", ""
	View_Paid_OrdersLocal_list.DetailOptions.Render "body", "", "", "", "", ""
	View_Paid_OrdersLocal_list.ActionOptions.Render "body", "", "", "", "", ""
%>
</div>
<div class="clearfix"></div>
<% End If %>
<% If View_Paid_OrdersLocal.Export <> "" Then %>
<script type="text/javascript">
ew_ApplyTemplate("body", "", "View_Paid_OrdersLocallist", "<%= View_Paid_OrdersLocal.CustomExport %>");
</script>
<% End If %>
<% If View_Paid_OrdersLocal.Export = "" Then %>
<script type="text/javascript">
fView_Paid_OrdersLocallistsrch.Init();
fView_Paid_OrdersLocallist.Init();
</script>
<% End If %>
<%
View_Paid_OrdersLocal_list.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<% If View_Paid_OrdersLocal.Export = "" Then %>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<% End If %>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set View_Paid_OrdersLocal_list = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cView_Paid_OrdersLocal_list

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
		TableName = "View_Paid_OrdersLocal"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "View_Paid_OrdersLocal_list"
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
		If View_Paid_OrdersLocal.UseTokenInUrl Then PageUrl = PageUrl & "t=" & View_Paid_OrdersLocal.TableVar & "&" ' add page token
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
		If View_Paid_OrdersLocal.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (View_Paid_OrdersLocal.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (View_Paid_OrdersLocal.TableVar = Request.QueryString("t"))
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
		FormName = "fView_Paid_OrdersLocallist"
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
		If IsEmpty(View_Paid_OrdersLocal) Then Set View_Paid_OrdersLocal = New cView_Paid_OrdersLocal
		Set Table = View_Paid_OrdersLocal
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
		AddUrl = "View_Paid_OrdersLocaladd.asp"
		InlineAddUrl = PageUrl & "a=add"
		GridAddUrl = PageUrl & "a=gridadd"
		GridEditUrl = PageUrl & "a=gridedit"
		MultiDeleteUrl = "View_Paid_OrdersLocaldelete.asp"
		MultiUpdateUrl = "View_Paid_OrdersLocalupdate.asp"

		' Initialize form object
		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "list"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "View_Paid_OrdersLocal"

		' Open connection to the database
		If IsEmpty(Conn) Then Call ew_Connect()

		' List options
		Set ListOptions = New cListOptions
		ListOptions.TableVar = View_Paid_OrdersLocal.TableVar

		' Export options
		Set ExportOptions = New cListOptions
		ExportOptions.TableVar = View_Paid_OrdersLocal.TableVar
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
			View_Paid_OrdersLocal.Export = Request.QueryString("export")
			custom = Request.QueryString("custom") & ""
		ElseIf ew_IsHttpPost() Then
			If Request.Form("export").Count > 0 Then
				View_Paid_OrdersLocal.Export = Request.Form("export")
				custom = Request.Form("custom") & ""
			ElseIf Request.Form("exporttype").Count > 0 Then
				View_Paid_OrdersLocal.Export = Request.Form("exporttype")
				custom = Request.Form("custom") & ""
			End If
		Else
			View_Paid_OrdersLocal.ExportReturnUrl = ew_CurrentUrl()
		End If
		gsExportFile = View_Paid_OrdersLocal.TableVar ' Get export file, used in header
		Dim Charset ' Charset used in header
		If EW_CHARSET <> "" Then
			Charset = ";charset=" & EW_CHARSET
		Else
			Charset = ""
		End If

		' Get custom export parameters
		If View_Paid_OrdersLocal.Export <> "" And custom <> "" Then
			View_Paid_OrdersLocal.CustomExport = View_Paid_OrdersLocal.Export
			View_Paid_OrdersLocal.Export = "print"
		End If
		gsCustomExport = View_Paid_OrdersLocal.CustomExport
		gsExport = View_Paid_OrdersLocal.Export ' Get export parameter, used in header

		' Custom export (post back from ew_ApplyTemplate), export and terminate page
		If Request.Form("customexport").Count > 0 Then
			View_Paid_OrdersLocal.CustomExport = Request.Form("customexport")
			View_Paid_OrdersLocal.Export = View_Paid_OrdersLocal.CustomExport
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
		If View_Paid_OrdersLocal.Export = "excel" Then
			Response.ContentType = "application/vnd.ms-excel" & Charset
			Response.AddHeader "Content-Disposition", "attachment; filename=" & gsExportFile & ".xls"
		End If
		If View_Paid_OrdersLocal.Export = "word" Then
			Response.ContentType = "application/vnd.ms-word" & Charset
			Response.AddHeader "Content-Disposition", "attachment; filename=" & gsExportFile & ".doc"
		End If
		If View_Paid_OrdersLocal.Export = "csv" Then
			Response.BinaryWrite ChrB(239) & ChrB(187) & ChrB(191)
			Response.ContentType = "application/csv" & Charset
			Response.AddHeader "Content-Disposition", "attachment; filename=" & gsExportFile & ".csv"
		End If

		' Get grid add count
		Dim gridaddcnt
		gridaddcnt = Request.QueryString(EW_TABLE_GRID_ADD_ROW_COUNT)
		If IsNumeric(gridaddcnt) Then
			If gridaddcnt > 0 Then
				View_Paid_OrdersLocal.GridAddRowCount = gridaddcnt
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
			results = View_Paid_OrdersLocal.GetAutoFill(Request.Form("name"), Request.Form("q"))
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
		If UBound(View_Paid_OrdersLocal.CustomActions.CustomArray) >= 0 Then
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
		If Not View_Paid_OrdersLocal Is Nothing Then
			If View_Paid_OrdersLocal.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = View_Paid_OrdersLocal.TableVar
				If View_Paid_OrdersLocal.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf View_Paid_OrdersLocal.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf View_Paid_OrdersLocal.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf View_Paid_OrdersLocal.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set View_Paid_OrdersLocal = Nothing
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
			If View_Paid_OrdersLocal.Export = "" Then
				SetupBreadcrumb()
			End If

			' Hide list options
			If View_Paid_OrdersLocal.Export <> "" Then
				Call ListOptions.HideAllOptions(Array("sequence"))
				ListOptions.UseDropDownButton = False ' Disable drop down button
				ListOptions.UseButtonGroup = False ' Disable button group
			ElseIf View_Paid_OrdersLocal.CurrentAction = "gridadd" Or View_Paid_OrdersLocal.CurrentAction = "gridedit" Then
				Call ListOptions.HideAllOptions(Array())
				ListOptions.UseDropDownButton = False ' Disable drop down button
				ListOptions.UseButtonGroup = False ' Disable button group
			End If

			' Hide export options
			If View_Paid_OrdersLocal.Export <> "" Or View_Paid_OrdersLocal.CurrentAction <> "" Then
				ExportOptions.HideAllOptions(Array())
			End If

			' Hide other options
			If View_Paid_OrdersLocal.Export <> "" Then
				AddEditOptions.HideAllOptions(Array())
				DetailOptions.HideAllOptions(Array())
				ActionOptions.HideAllOptions(Array())
			End If

			' Get default search criteria
			Call ew_AddFilter(DefaultSearchWhere, BasicSearchWhere(True))

			' Get basic search values
			Call LoadBasicSearchValues()

			' Restore search parms from Session if not searching / reset / export
			If (View_Paid_OrdersLocal.Export <> "" Or Command <> "search" And Command <> "reset" And Command <> "resetall") And CheckSearchParms() Then
				Call RestoreSearchParms()
			End If

			' Call Recordset SearchValidated event
			Call View_Paid_OrdersLocal.Recordset_SearchValidated()

			' Set Up Sorting Order
			SetUpSortOrder()

			' Get basic search criteria
			If gsSearchError = "" Then
				sSrchBasic = BasicSearchWhere(False)
			End If
		End If ' End Validate Request

		' Restore display records
		If View_Paid_OrdersLocal.RecordsPerPage <> "" Then
			DisplayRecs = View_Paid_OrdersLocal.RecordsPerPage ' Restore from Session
		Else
			DisplayRecs = 20 ' Load default
		End If

		' Load Sorting Order
		LoadSortOrder()

		' Load search default if no existing search criteria
		If Not CheckSearchParms() Then

			' Load basic search from default
			View_Paid_OrdersLocal.BasicSearch.Keyword = View_Paid_OrdersLocal.BasicSearch.KeywordDefault
			View_Paid_OrdersLocal.BasicSearch.SearchType = View_Paid_OrdersLocal.BasicSearch.SearchTypeDefault
			View_Paid_OrdersLocal.BasicSearch.setSearchType(View_Paid_OrdersLocal.BasicSearch.SearchTypeDefault)
			If View_Paid_OrdersLocal.BasicSearch.Keyword <> "" Then
				sSrchBasic = BasicSearchWhere(False)
			End If
		End If

		' Build search criteria
		Call ew_AddFilter(SearchWhere, sSrchAdvanced)
		Call ew_AddFilter(SearchWhere, sSrchBasic)

		' Call Recordset Searching event
		Call View_Paid_OrdersLocal.Recordset_Searching(SearchWhere)

		' Save search criteria
		If Command = "search" And Not RestoreSearch Then
			View_Paid_OrdersLocal.SearchWhere = SearchWhere ' Save to Session
			StartRec = 1 ' Reset start record counter
			View_Paid_OrdersLocal.StartRecordNumber = StartRec
		Else
			SearchWhere = View_Paid_OrdersLocal.SearchWhere
		End If
		sFilter = ""
		Call ew_AddFilter(sFilter, DbDetailFilter)
		Call ew_AddFilter(sFilter, SearchWhere)

		' Set up filter in Session
		View_Paid_OrdersLocal.SessionWhere = sFilter
		View_Paid_OrdersLocal.CurrentFilter = ""

		' Export Data only
		If View_Paid_OrdersLocal.CustomExport = "" And ew_InArray(View_Paid_OrdersLocal.Export, Array("html","word","excel","xml","csv","email","pdf")) Then
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
			View_Paid_OrdersLocal.RecordsPerPage = DisplayRecs ' Save to Session

			' Reset start position
			StartRec = 1
			View_Paid_OrdersLocal.StartRecordNumber = StartRec
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
				sFilter = View_Paid_OrdersLocal.KeyFilter
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
		If UBound(arrKeyFlds) >= -1 Then
		End If
		SetupKeyValues = True
	End Function

	' -----------------------------------------------------------------
	' Return Basic Search sql
	'
	Function BasicSearchSQL(arKeywords, typ)
		Dim sWhere
		sWhere = ""
			Call BuildBasicSearchSQL(sWhere, View_Paid_OrdersLocal.DeliveryType, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, View_Paid_OrdersLocal.PaymentType, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, View_Paid_OrdersLocal.SessionId, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, View_Paid_OrdersLocal.FirstName, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, View_Paid_OrdersLocal.LastName, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, View_Paid_OrdersLocal.zEmail, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, View_Paid_OrdersLocal.Phone, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, View_Paid_OrdersLocal.Address, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, View_Paid_OrdersLocal.PostalCode, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, View_Paid_OrdersLocal.Notes, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, View_Paid_OrdersLocal.ttest, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, View_Paid_OrdersLocal.cancelledby, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, View_Paid_OrdersLocal.cancelledreason, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, View_Paid_OrdersLocal.delivereddate, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, View_Paid_OrdersLocal.vouchercode, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, View_Paid_OrdersLocal.deliverydistance, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, View_Paid_OrdersLocal.asaporder, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, View_Paid_OrdersLocal.DeliveryLat, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, View_Paid_OrdersLocal.DeliveryLng, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, View_Paid_OrdersLocal.Tip_Rate, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, View_Paid_OrdersLocal.Payment_Status, arKeywords, typ)
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
		sSearchKeyword = ew_IIf(Default, View_Paid_OrdersLocal.BasicSearch.KeywordDefault, View_Paid_OrdersLocal.BasicSearch.Keyword)
		sSearchType = ew_IIf(Default, View_Paid_OrdersLocal.BasicSearch.SearchTypeDefault, View_Paid_OrdersLocal.BasicSearch.SearchType)
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
			View_Paid_OrdersLocal.BasicSearch.setKeyword(sSearchKeyword)
			View_Paid_OrdersLocal.BasicSearch.setSearchType(sSearchType)
		End If
		BasicSearchWhere = sSearchStr
	End Function

	' Check if search parm exists
	Function CheckSearchParms()

		' Check basic search
		If View_Paid_OrdersLocal.BasicSearch.IssetSession() Then
			CheckSearchParms = True
			Exit Function
		End If
		CheckSearchParms = False
	End Function

	' Clear all search parameters
	Sub ResetSearchParms()

		' Clear search where
		SearchWhere = ""
		View_Paid_OrdersLocal.SearchWhere = SearchWhere

		' Clear basic search parameters
		Call ResetBasicSearchParms()
	End Sub

	' Load advanced search default values
	Function LoadAdvancedSearchDefault()
		LoadAdvancedSearchDefault = False
	End Function

	' Clear all basic search parameters
	Sub ResetBasicSearchParms()
		View_Paid_OrdersLocal.BasicSearch.UnsetSession()
	End Sub

	' -----------------------------------------------------------------
	' Restore all search parameters
	'
	Sub RestoreSearchParms()

		' Restore search flag
		RestoreSearch = True

		' Restore basic search values
		Call View_Paid_OrdersLocal.BasicSearch.Load()
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
			View_Paid_OrdersLocal.CurrentOrder = Request.QueryString("order")
			View_Paid_OrdersLocal.CurrentOrderType = Request.QueryString("ordertype")

			' Field ID
			Call View_Paid_OrdersLocal.UpdateSort(View_Paid_OrdersLocal.ID)

			' Field CreationDate
			Call View_Paid_OrdersLocal.UpdateSort(View_Paid_OrdersLocal.CreationDate)

			' Field OrderDate
			Call View_Paid_OrdersLocal.UpdateSort(View_Paid_OrdersLocal.OrderDate)

			' Field DeliveryType
			Call View_Paid_OrdersLocal.UpdateSort(View_Paid_OrdersLocal.DeliveryType)

			' Field DeliveryTime
			Call View_Paid_OrdersLocal.UpdateSort(View_Paid_OrdersLocal.DeliveryTime)

			' Field PaymentType
			Call View_Paid_OrdersLocal.UpdateSort(View_Paid_OrdersLocal.PaymentType)

			' Field SubTotal
			Call View_Paid_OrdersLocal.UpdateSort(View_Paid_OrdersLocal.SubTotal)

			' Field ShippingFee
			Call View_Paid_OrdersLocal.UpdateSort(View_Paid_OrdersLocal.ShippingFee)

			' Field OrderTotal
			Call View_Paid_OrdersLocal.UpdateSort(View_Paid_OrdersLocal.OrderTotal)

			' Field IdBusinessDetail
			Call View_Paid_OrdersLocal.UpdateSort(View_Paid_OrdersLocal.IdBusinessDetail)

			' Field SessionId
			Call View_Paid_OrdersLocal.UpdateSort(View_Paid_OrdersLocal.SessionId)

			' Field FirstName
			Call View_Paid_OrdersLocal.UpdateSort(View_Paid_OrdersLocal.FirstName)

			' Field LastName
			Call View_Paid_OrdersLocal.UpdateSort(View_Paid_OrdersLocal.LastName)

			' Field Email
			Call View_Paid_OrdersLocal.UpdateSort(View_Paid_OrdersLocal.zEmail)

			' Field Phone
			Call View_Paid_OrdersLocal.UpdateSort(View_Paid_OrdersLocal.Phone)

			' Field Address
			Call View_Paid_OrdersLocal.UpdateSort(View_Paid_OrdersLocal.Address)

			' Field PostalCode
			Call View_Paid_OrdersLocal.UpdateSort(View_Paid_OrdersLocal.PostalCode)

			' Field Notes
			Call View_Paid_OrdersLocal.UpdateSort(View_Paid_OrdersLocal.Notes)

			' Field ttest
			Call View_Paid_OrdersLocal.UpdateSort(View_Paid_OrdersLocal.ttest)

			' Field cancelleddate
			Call View_Paid_OrdersLocal.UpdateSort(View_Paid_OrdersLocal.cancelleddate)

			' Field cancelledby
			Call View_Paid_OrdersLocal.UpdateSort(View_Paid_OrdersLocal.cancelledby)

			' Field cancelledreason
			Call View_Paid_OrdersLocal.UpdateSort(View_Paid_OrdersLocal.cancelledreason)

			' Field acknowledgeddate
			Call View_Paid_OrdersLocal.UpdateSort(View_Paid_OrdersLocal.acknowledgeddate)

			' Field delivereddate
			Call View_Paid_OrdersLocal.UpdateSort(View_Paid_OrdersLocal.delivereddate)

			' Field cancelled
			Call View_Paid_OrdersLocal.UpdateSort(View_Paid_OrdersLocal.cancelled)

			' Field acknowledged
			Call View_Paid_OrdersLocal.UpdateSort(View_Paid_OrdersLocal.acknowledged)

			' Field outfordelivery
			Call View_Paid_OrdersLocal.UpdateSort(View_Paid_OrdersLocal.outfordelivery)

			' Field vouchercodediscount
			Call View_Paid_OrdersLocal.UpdateSort(View_Paid_OrdersLocal.vouchercodediscount)

			' Field vouchercode
			Call View_Paid_OrdersLocal.UpdateSort(View_Paid_OrdersLocal.vouchercode)

			' Field printed
			Call View_Paid_OrdersLocal.UpdateSort(View_Paid_OrdersLocal.printed)

			' Field deliverydistance
			Call View_Paid_OrdersLocal.UpdateSort(View_Paid_OrdersLocal.deliverydistance)

			' Field asaporder
			Call View_Paid_OrdersLocal.UpdateSort(View_Paid_OrdersLocal.asaporder)

			' Field DeliveryLat
			Call View_Paid_OrdersLocal.UpdateSort(View_Paid_OrdersLocal.DeliveryLat)

			' Field DeliveryLng
			Call View_Paid_OrdersLocal.UpdateSort(View_Paid_OrdersLocal.DeliveryLng)

			' Field ServiceCharge
			Call View_Paid_OrdersLocal.UpdateSort(View_Paid_OrdersLocal.ServiceCharge)

			' Field PaymentSurcharge
			Call View_Paid_OrdersLocal.UpdateSort(View_Paid_OrdersLocal.PaymentSurcharge)

			' Field Tax_Rate
			Call View_Paid_OrdersLocal.UpdateSort(View_Paid_OrdersLocal.Tax_Rate)

			' Field Tax_Amount
			Call View_Paid_OrdersLocal.UpdateSort(View_Paid_OrdersLocal.Tax_Amount)

			' Field Tip_Rate
			Call View_Paid_OrdersLocal.UpdateSort(View_Paid_OrdersLocal.Tip_Rate)

			' Field Tip_Amount
			Call View_Paid_OrdersLocal.UpdateSort(View_Paid_OrdersLocal.Tip_Amount)

			' Field Payment_Status
			Call View_Paid_OrdersLocal.UpdateSort(View_Paid_OrdersLocal.Payment_Status)
			View_Paid_OrdersLocal.StartRecordNumber = 1 ' Reset start position
		End If
	End Sub

	' -----------------------------------------------------------------
	' Load Sort Order parameters
	'
	Sub LoadSortOrder()
		Dim sOrderBy
		sOrderBy = View_Paid_OrdersLocal.SessionOrderBy ' Get order by from Session
		If sOrderBy = "" Then
			If View_Paid_OrdersLocal.SqlOrderBy <> "" Then
				sOrderBy = View_Paid_OrdersLocal.SqlOrderBy
				View_Paid_OrdersLocal.SessionOrderBy = sOrderBy
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
				View_Paid_OrdersLocal.SessionOrderBy = sOrderBy
				View_Paid_OrdersLocal.ID.Sort = ""
				View_Paid_OrdersLocal.CreationDate.Sort = ""
				View_Paid_OrdersLocal.OrderDate.Sort = ""
				View_Paid_OrdersLocal.DeliveryType.Sort = ""
				View_Paid_OrdersLocal.DeliveryTime.Sort = ""
				View_Paid_OrdersLocal.PaymentType.Sort = ""
				View_Paid_OrdersLocal.SubTotal.Sort = ""
				View_Paid_OrdersLocal.ShippingFee.Sort = ""
				View_Paid_OrdersLocal.OrderTotal.Sort = ""
				View_Paid_OrdersLocal.IdBusinessDetail.Sort = ""
				View_Paid_OrdersLocal.SessionId.Sort = ""
				View_Paid_OrdersLocal.FirstName.Sort = ""
				View_Paid_OrdersLocal.LastName.Sort = ""
				View_Paid_OrdersLocal.zEmail.Sort = ""
				View_Paid_OrdersLocal.Phone.Sort = ""
				View_Paid_OrdersLocal.Address.Sort = ""
				View_Paid_OrdersLocal.PostalCode.Sort = ""
				View_Paid_OrdersLocal.Notes.Sort = ""
				View_Paid_OrdersLocal.ttest.Sort = ""
				View_Paid_OrdersLocal.cancelleddate.Sort = ""
				View_Paid_OrdersLocal.cancelledby.Sort = ""
				View_Paid_OrdersLocal.cancelledreason.Sort = ""
				View_Paid_OrdersLocal.acknowledgeddate.Sort = ""
				View_Paid_OrdersLocal.delivereddate.Sort = ""
				View_Paid_OrdersLocal.cancelled.Sort = ""
				View_Paid_OrdersLocal.acknowledged.Sort = ""
				View_Paid_OrdersLocal.outfordelivery.Sort = ""
				View_Paid_OrdersLocal.vouchercodediscount.Sort = ""
				View_Paid_OrdersLocal.vouchercode.Sort = ""
				View_Paid_OrdersLocal.printed.Sort = ""
				View_Paid_OrdersLocal.deliverydistance.Sort = ""
				View_Paid_OrdersLocal.asaporder.Sort = ""
				View_Paid_OrdersLocal.DeliveryLat.Sort = ""
				View_Paid_OrdersLocal.DeliveryLng.Sort = ""
				View_Paid_OrdersLocal.ServiceCharge.Sort = ""
				View_Paid_OrdersLocal.PaymentSurcharge.Sort = ""
				View_Paid_OrdersLocal.Tax_Rate.Sort = ""
				View_Paid_OrdersLocal.Tax_Amount.Sort = ""
				View_Paid_OrdersLocal.Tip_Rate.Sort = ""
				View_Paid_OrdersLocal.Tip_Amount.Sort = ""
				View_Paid_OrdersLocal.Payment_Status.Sort = ""
			End If

			' Reset start position
			StartRec = 1
			View_Paid_OrdersLocal.StartRecordNumber = StartRec
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

		' Checkbox
		ListOptions.Add("checkbox")
		Set item = ListOptions.GetItem("checkbox")
		item.Visible = False
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
		Call RenderListOptionsExt()
		Call ListOptions_Rendered()
	End Sub

	' Set up other options
	Sub SetupOtherOptions()
		Dim opt, item, DetailTableLink, ar, i
		Set opt = ActionOptions

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
			For i = 0 to UBound(View_Paid_OrdersLocal.CustomActions.CustomArray)
				Action = View_Paid_OrdersLocal.CustomActions.CustomArray(i)(0)
				Name = View_Paid_OrdersLocal.CustomActions.CustomArray(i)(1)

				' Add custom action
				Call opt.Add("custom_" & Action)
				Set item = opt.GetItem("custom_" & Action)
				item.Body = "<a class=""ewAction ewCustomAction"" href="""" onclick=""ew_SubmitSelected(document.fView_Paid_OrdersLocallist, '" & ew_CurrentUrl & "', null, '" & Action & "');return false;"">" & Name & "</a>"
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
		sFilter = View_Paid_OrdersLocal.GetKeyFilter
		UserAction = Request.Form("useraction") & ""
		Processed = False
		If sFilter <> "" And UserAction <> "" Then
			View_Paid_OrdersLocal.CurrentFilter = sFilter
			sSql = View_Paid_OrdersLocal.SQL
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
				ElseIf View_Paid_OrdersLocal.CancelMessage <> "" Then
					FailureMessage = View_Paid_OrdersLocal.CancelMessage
					View_Paid_OrdersLocal.CancelMessage = ""
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
		SearchOptions.TableVar = View_Paid_OrdersLocal.TableVar
		ExportOptions.Tag = "div"
		SearchOptions.TagClassName = "ewSearchOption"

		' Search button
		SearchOptions.Add("searchtoggle")
		Set item = SearchOptions.GetItem("searchtoggle")
		SearchToggleClass = ew_IIf(SearchWhere <> "", " active", " active")
		item.Body = "<button type=""button"" class=""btn btn-default ewSearchToggle" & SearchToggleClass & """ title=""" & Language.Phrase("SearchPanel") & """ data-caption=""" & Language.Phrase("SearchPanel") & """ data-toggle=""button"" data-form=""fView_Paid_OrdersLocallistsrch"">" & Language.Phrase("SearchBtn") & "</button>"
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
		If View_Paid_OrdersLocal.Export <> "" Or View_Paid_OrdersLocal.CurrentAction <> "" Then
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
				View_Paid_OrdersLocal.StartRecordNumber = StartRec
			ElseIf Request.QueryString(EW_TABLE_PAGE_NO).Count > 0 Then
				PageNo = Request.QueryString(EW_TABLE_PAGE_NO)
				If IsNumeric(PageNo) Then
					StartRec = (PageNo-1)*DisplayRecs+1
					If StartRec <= 0 Then
						StartRec = 1
					ElseIf StartRec >= ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1 Then
						StartRec = ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1
					End If
					View_Paid_OrdersLocal.StartRecordNumber = StartRec
				End If
			End If
		End If
		StartRec = View_Paid_OrdersLocal.StartRecordNumber

		' Check if correct start record counter
		If Not IsNumeric(StartRec) Or StartRec = "" Then ' Avoid invalid start record counter
			StartRec = 1 ' Reset start record counter
			View_Paid_OrdersLocal.StartRecordNumber = StartRec
		ElseIf CLng(StartRec) > CLng(TotalRecs) Then ' Avoid starting record > total records
			StartRec = ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1 ' Point to last page first record
			View_Paid_OrdersLocal.StartRecordNumber = StartRec
		ElseIf (StartRec-1) Mod DisplayRecs <> 0 Then
			StartRec = ((StartRec-1)\DisplayRecs)*DisplayRecs+1 ' Point to page boundary
			View_Paid_OrdersLocal.StartRecordNumber = StartRec
		End If
	End Sub

	' -----------------------------------------------------------------
	'  Load basic search values
	'
	Function LoadBasicSearchValues()
		View_Paid_OrdersLocal.BasicSearch.Keyword = Request.QueryString(EW_TABLE_BASIC_SEARCH)&""
		If View_Paid_OrdersLocal.BasicSearch.Keyword <> "" Then Command = "search"
		View_Paid_OrdersLocal.BasicSearch.SearchType = Request.QueryString(EW_TABLE_BASIC_SEARCH_TYPE)&""
	End Function

	' -----------------------------------------------------------------
	' Load recordset
	'
	Function LoadRecordset()

		' Load list page sql
		Dim sSql
		sSql = View_Paid_OrdersLocal.SelectSQL
		Call ew_SetDebugMsg("LoadRecordset: " & sSql) ' Show SQL for debugging

		' Load recordset
		Dim RsRecordset
		Set RsRecordset = ew_LoadRecordset(sSql)

		' Call Recordset Selected event
		Call View_Paid_OrdersLocal.Recordset_Selected(RsRecordset)
		Set LoadRecordset = RsRecordset
	End Function

	' -----------------------------------------------------------------
	' Load row based on key values
	'
	Function LoadRow()
		Dim RsRow, sSql, sFilter
		sFilter = View_Paid_OrdersLocal.KeyFilter

		' Call Row Selecting event
		Call View_Paid_OrdersLocal.Row_Selecting(sFilter)

		' Load sql based on filter
		View_Paid_OrdersLocal.CurrentFilter = sFilter
		sSql = View_Paid_OrdersLocal.SQL
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
		Call View_Paid_OrdersLocal.Row_Selected(RsRow)
		View_Paid_OrdersLocal.ID.DbValue = RsRow("ID")
		View_Paid_OrdersLocal.CreationDate.DbValue = RsRow("CreationDate")
		View_Paid_OrdersLocal.OrderDate.DbValue = RsRow("OrderDate")
		View_Paid_OrdersLocal.DeliveryType.DbValue = RsRow("DeliveryType")
		View_Paid_OrdersLocal.DeliveryTime.DbValue = RsRow("DeliveryTime")
		View_Paid_OrdersLocal.PaymentType.DbValue = RsRow("PaymentType")
		View_Paid_OrdersLocal.SubTotal.DbValue = RsRow("SubTotal")
		View_Paid_OrdersLocal.ShippingFee.DbValue = RsRow("ShippingFee")
		View_Paid_OrdersLocal.OrderTotal.DbValue = RsRow("OrderTotal")
		View_Paid_OrdersLocal.IdBusinessDetail.DbValue = RsRow("IdBusinessDetail")
		View_Paid_OrdersLocal.SessionId.DbValue = RsRow("SessionId")
		View_Paid_OrdersLocal.FirstName.DbValue = RsRow("FirstName")
		View_Paid_OrdersLocal.LastName.DbValue = RsRow("LastName")
		View_Paid_OrdersLocal.zEmail.DbValue = RsRow("Email")
		View_Paid_OrdersLocal.Phone.DbValue = RsRow("Phone")
		View_Paid_OrdersLocal.Address.DbValue = RsRow("Address")
		View_Paid_OrdersLocal.PostalCode.DbValue = RsRow("PostalCode")
		View_Paid_OrdersLocal.Notes.DbValue = RsRow("Notes")
		View_Paid_OrdersLocal.ttest.DbValue = RsRow("ttest")
		View_Paid_OrdersLocal.cancelleddate.DbValue = RsRow("cancelleddate")
		View_Paid_OrdersLocal.cancelledby.DbValue = RsRow("cancelledby")
		View_Paid_OrdersLocal.cancelledreason.DbValue = RsRow("cancelledreason")
		View_Paid_OrdersLocal.acknowledgeddate.DbValue = RsRow("acknowledgeddate")
		View_Paid_OrdersLocal.delivereddate.DbValue = RsRow("delivereddate")
		View_Paid_OrdersLocal.cancelled.DbValue = RsRow("cancelled")
		View_Paid_OrdersLocal.acknowledged.DbValue = RsRow("acknowledged")
		View_Paid_OrdersLocal.outfordelivery.DbValue = RsRow("outfordelivery")
		View_Paid_OrdersLocal.vouchercodediscount.DbValue = RsRow("vouchercodediscount")
		View_Paid_OrdersLocal.vouchercode.DbValue = RsRow("vouchercode")
		View_Paid_OrdersLocal.printed.DbValue = RsRow("printed")
		View_Paid_OrdersLocal.deliverydistance.DbValue = RsRow("deliverydistance")
		View_Paid_OrdersLocal.asaporder.DbValue = RsRow("asaporder")
		View_Paid_OrdersLocal.DeliveryLat.DbValue = RsRow("DeliveryLat")
		View_Paid_OrdersLocal.DeliveryLng.DbValue = RsRow("DeliveryLng")
		View_Paid_OrdersLocal.ServiceCharge.DbValue = RsRow("ServiceCharge")
		View_Paid_OrdersLocal.PaymentSurcharge.DbValue = RsRow("PaymentSurcharge")
		View_Paid_OrdersLocal.Tax_Rate.DbValue = RsRow("Tax_Rate")
		View_Paid_OrdersLocal.Tax_Amount.DbValue = RsRow("Tax_Amount")
		View_Paid_OrdersLocal.Tip_Rate.DbValue = RsRow("Tip_Rate")
		View_Paid_OrdersLocal.Tip_Amount.DbValue = RsRow("Tip_Amount")
		View_Paid_OrdersLocal.Payment_Status.DbValue = RsRow("Payment_Status")
	End Sub

	' Load DbValue from recordset
	Sub LoadDbValues(Rs)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		If Rs.Eof Then Exit Sub
		View_Paid_OrdersLocal.ID.m_DbValue = Rs("ID")
		View_Paid_OrdersLocal.CreationDate.m_DbValue = Rs("CreationDate")
		View_Paid_OrdersLocal.OrderDate.m_DbValue = Rs("OrderDate")
		View_Paid_OrdersLocal.DeliveryType.m_DbValue = Rs("DeliveryType")
		View_Paid_OrdersLocal.DeliveryTime.m_DbValue = Rs("DeliveryTime")
		View_Paid_OrdersLocal.PaymentType.m_DbValue = Rs("PaymentType")
		View_Paid_OrdersLocal.SubTotal.m_DbValue = Rs("SubTotal")
		View_Paid_OrdersLocal.ShippingFee.m_DbValue = Rs("ShippingFee")
		View_Paid_OrdersLocal.OrderTotal.m_DbValue = Rs("OrderTotal")
		View_Paid_OrdersLocal.IdBusinessDetail.m_DbValue = Rs("IdBusinessDetail")
		View_Paid_OrdersLocal.SessionId.m_DbValue = Rs("SessionId")
		View_Paid_OrdersLocal.FirstName.m_DbValue = Rs("FirstName")
		View_Paid_OrdersLocal.LastName.m_DbValue = Rs("LastName")
		View_Paid_OrdersLocal.zEmail.m_DbValue = Rs("Email")
		View_Paid_OrdersLocal.Phone.m_DbValue = Rs("Phone")
		View_Paid_OrdersLocal.Address.m_DbValue = Rs("Address")
		View_Paid_OrdersLocal.PostalCode.m_DbValue = Rs("PostalCode")
		View_Paid_OrdersLocal.Notes.m_DbValue = Rs("Notes")
		View_Paid_OrdersLocal.ttest.m_DbValue = Rs("ttest")
		View_Paid_OrdersLocal.cancelleddate.m_DbValue = Rs("cancelleddate")
		View_Paid_OrdersLocal.cancelledby.m_DbValue = Rs("cancelledby")
		View_Paid_OrdersLocal.cancelledreason.m_DbValue = Rs("cancelledreason")
		View_Paid_OrdersLocal.acknowledgeddate.m_DbValue = Rs("acknowledgeddate")
		View_Paid_OrdersLocal.delivereddate.m_DbValue = Rs("delivereddate")
		View_Paid_OrdersLocal.cancelled.m_DbValue = Rs("cancelled")
		View_Paid_OrdersLocal.acknowledged.m_DbValue = Rs("acknowledged")
		View_Paid_OrdersLocal.outfordelivery.m_DbValue = Rs("outfordelivery")
		View_Paid_OrdersLocal.vouchercodediscount.m_DbValue = Rs("vouchercodediscount")
		View_Paid_OrdersLocal.vouchercode.m_DbValue = Rs("vouchercode")
		View_Paid_OrdersLocal.printed.m_DbValue = Rs("printed")
		View_Paid_OrdersLocal.deliverydistance.m_DbValue = Rs("deliverydistance")
		View_Paid_OrdersLocal.asaporder.m_DbValue = Rs("asaporder")
		View_Paid_OrdersLocal.DeliveryLat.m_DbValue = Rs("DeliveryLat")
		View_Paid_OrdersLocal.DeliveryLng.m_DbValue = Rs("DeliveryLng")
		View_Paid_OrdersLocal.ServiceCharge.m_DbValue = Rs("ServiceCharge")
		View_Paid_OrdersLocal.PaymentSurcharge.m_DbValue = Rs("PaymentSurcharge")
		View_Paid_OrdersLocal.Tax_Rate.m_DbValue = Rs("Tax_Rate")
		View_Paid_OrdersLocal.Tax_Amount.m_DbValue = Rs("Tax_Amount")
		View_Paid_OrdersLocal.Tip_Rate.m_DbValue = Rs("Tip_Rate")
		View_Paid_OrdersLocal.Tip_Amount.m_DbValue = Rs("Tip_Amount")
		View_Paid_OrdersLocal.Payment_Status.m_DbValue = Rs("Payment_Status")
	End Sub

	' Load old record
	Function LoadOldRecord()

		' Load key values from Session
		Dim bValidKey
		bValidKey = True

		' Load old recordset
		If bValidKey Then
			View_Paid_OrdersLocal.CurrentFilter = View_Paid_OrdersLocal.KeyFilter
			Dim sSql
			sSql = View_Paid_OrdersLocal.SQL
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
		ViewUrl = View_Paid_OrdersLocal.ViewUrl("")
		EditUrl = View_Paid_OrdersLocal.EditUrl("")
		InlineEditUrl = View_Paid_OrdersLocal.InlineEditUrl
		CopyUrl = View_Paid_OrdersLocal.CopyUrl("")
		InlineCopyUrl = View_Paid_OrdersLocal.InlineCopyUrl
		DeleteUrl = View_Paid_OrdersLocal.DeleteUrl

		' Convert decimal values if posted back
		If View_Paid_OrdersLocal.SubTotal.FormValue = View_Paid_OrdersLocal.SubTotal.CurrentValue And IsNumeric(View_Paid_OrdersLocal.SubTotal.CurrentValue) Then
			View_Paid_OrdersLocal.SubTotal.CurrentValue = ew_StrToFloat(View_Paid_OrdersLocal.SubTotal.CurrentValue)
		End If

		' Convert decimal values if posted back
		If View_Paid_OrdersLocal.ShippingFee.FormValue = View_Paid_OrdersLocal.ShippingFee.CurrentValue And IsNumeric(View_Paid_OrdersLocal.ShippingFee.CurrentValue) Then
			View_Paid_OrdersLocal.ShippingFee.CurrentValue = ew_StrToFloat(View_Paid_OrdersLocal.ShippingFee.CurrentValue)
		End If

		' Convert decimal values if posted back
		If View_Paid_OrdersLocal.OrderTotal.FormValue = View_Paid_OrdersLocal.OrderTotal.CurrentValue And IsNumeric(View_Paid_OrdersLocal.OrderTotal.CurrentValue) Then
			View_Paid_OrdersLocal.OrderTotal.CurrentValue = ew_StrToFloat(View_Paid_OrdersLocal.OrderTotal.CurrentValue)
		End If

		' Convert decimal values if posted back
		If View_Paid_OrdersLocal.ServiceCharge.FormValue = View_Paid_OrdersLocal.ServiceCharge.CurrentValue And IsNumeric(View_Paid_OrdersLocal.ServiceCharge.CurrentValue) Then
			View_Paid_OrdersLocal.ServiceCharge.CurrentValue = ew_StrToFloat(View_Paid_OrdersLocal.ServiceCharge.CurrentValue)
		End If

		' Convert decimal values if posted back
		If View_Paid_OrdersLocal.PaymentSurcharge.FormValue = View_Paid_OrdersLocal.PaymentSurcharge.CurrentValue And IsNumeric(View_Paid_OrdersLocal.PaymentSurcharge.CurrentValue) Then
			View_Paid_OrdersLocal.PaymentSurcharge.CurrentValue = ew_StrToFloat(View_Paid_OrdersLocal.PaymentSurcharge.CurrentValue)
		End If

		' Convert decimal values if posted back
		If View_Paid_OrdersLocal.Tax_Amount.FormValue = View_Paid_OrdersLocal.Tax_Amount.CurrentValue And IsNumeric(View_Paid_OrdersLocal.Tax_Amount.CurrentValue) Then
			View_Paid_OrdersLocal.Tax_Amount.CurrentValue = ew_StrToFloat(View_Paid_OrdersLocal.Tax_Amount.CurrentValue)
		End If

		' Convert decimal values if posted back
		If View_Paid_OrdersLocal.Tip_Amount.FormValue = View_Paid_OrdersLocal.Tip_Amount.CurrentValue And IsNumeric(View_Paid_OrdersLocal.Tip_Amount.CurrentValue) Then
			View_Paid_OrdersLocal.Tip_Amount.CurrentValue = ew_StrToFloat(View_Paid_OrdersLocal.Tip_Amount.CurrentValue)
		End If

		' Call Row Rendering event
		Call View_Paid_OrdersLocal.Row_Rendering()

		' ---------------------------------------
		'  Common render codes for all row types
		' ---------------------------------------
		' ID
		' CreationDate
		' OrderDate
		' DeliveryType
		' DeliveryTime
		' PaymentType
		' SubTotal
		' ShippingFee
		' OrderTotal
		' IdBusinessDetail
		' SessionId
		' FirstName
		' LastName
		' Email
		' Phone
		' Address
		' PostalCode
		' Notes
		' ttest
		' cancelleddate
		' cancelledby
		' cancelledreason
		' acknowledgeddate
		' delivereddate
		' cancelled
		' acknowledged
		' outfordelivery
		' vouchercodediscount
		' vouchercode
		' printed
		' deliverydistance
		' asaporder
		' DeliveryLat
		' DeliveryLng
		' ServiceCharge
		' PaymentSurcharge
		' Tax_Rate
		' Tax_Amount
		' Tip_Rate
		' Tip_Amount
		' Payment_Status
		' -----------
		'  View  Row
		' -----------

		If View_Paid_OrdersLocal.RowType = EW_ROWTYPE_VIEW Then ' View row

			' ID
			View_Paid_OrdersLocal.ID.ViewValue = View_Paid_OrdersLocal.ID.CurrentValue
			View_Paid_OrdersLocal.ID.ViewCustomAttributes = ""

			' CreationDate
			View_Paid_OrdersLocal.CreationDate.ViewValue = View_Paid_OrdersLocal.CreationDate.CurrentValue
			View_Paid_OrdersLocal.CreationDate.ViewCustomAttributes = ""

			' OrderDate
			View_Paid_OrdersLocal.OrderDate.ViewValue = View_Paid_OrdersLocal.OrderDate.CurrentValue
			View_Paid_OrdersLocal.OrderDate.ViewCustomAttributes = ""

			' DeliveryType
			View_Paid_OrdersLocal.DeliveryType.ViewValue = View_Paid_OrdersLocal.DeliveryType.CurrentValue
			View_Paid_OrdersLocal.DeliveryType.ViewCustomAttributes = ""

			' DeliveryTime
			View_Paid_OrdersLocal.DeliveryTime.ViewValue = View_Paid_OrdersLocal.DeliveryTime.CurrentValue
			View_Paid_OrdersLocal.DeliveryTime.ViewCustomAttributes = ""

			' PaymentType
			View_Paid_OrdersLocal.PaymentType.ViewValue = View_Paid_OrdersLocal.PaymentType.CurrentValue
			View_Paid_OrdersLocal.PaymentType.ViewCustomAttributes = ""

			' SubTotal
			View_Paid_OrdersLocal.SubTotal.ViewValue = View_Paid_OrdersLocal.SubTotal.CurrentValue
			View_Paid_OrdersLocal.SubTotal.ViewCustomAttributes = ""

			' ShippingFee
			View_Paid_OrdersLocal.ShippingFee.ViewValue = View_Paid_OrdersLocal.ShippingFee.CurrentValue
			View_Paid_OrdersLocal.ShippingFee.ViewCustomAttributes = ""

			' OrderTotal
			View_Paid_OrdersLocal.OrderTotal.ViewValue = View_Paid_OrdersLocal.OrderTotal.CurrentValue
			View_Paid_OrdersLocal.OrderTotal.ViewCustomAttributes = ""

			' IdBusinessDetail
			View_Paid_OrdersLocal.IdBusinessDetail.ViewValue = View_Paid_OrdersLocal.IdBusinessDetail.CurrentValue
			View_Paid_OrdersLocal.IdBusinessDetail.ViewCustomAttributes = ""

			' SessionId
			View_Paid_OrdersLocal.SessionId.ViewValue = View_Paid_OrdersLocal.SessionId.CurrentValue
			View_Paid_OrdersLocal.SessionId.ViewCustomAttributes = ""

			' FirstName
			View_Paid_OrdersLocal.FirstName.ViewValue = View_Paid_OrdersLocal.FirstName.CurrentValue
			View_Paid_OrdersLocal.FirstName.ViewCustomAttributes = ""

			' LastName
			View_Paid_OrdersLocal.LastName.ViewValue = View_Paid_OrdersLocal.LastName.CurrentValue
			View_Paid_OrdersLocal.LastName.ViewCustomAttributes = ""

			' Email
			View_Paid_OrdersLocal.zEmail.ViewValue = View_Paid_OrdersLocal.zEmail.CurrentValue
			View_Paid_OrdersLocal.zEmail.ViewCustomAttributes = ""

			' Phone
			View_Paid_OrdersLocal.Phone.ViewValue = View_Paid_OrdersLocal.Phone.CurrentValue
			View_Paid_OrdersLocal.Phone.ViewCustomAttributes = ""

			' Address
			View_Paid_OrdersLocal.Address.ViewValue = View_Paid_OrdersLocal.Address.CurrentValue
			View_Paid_OrdersLocal.Address.ViewCustomAttributes = ""

			' PostalCode
			View_Paid_OrdersLocal.PostalCode.ViewValue = View_Paid_OrdersLocal.PostalCode.CurrentValue
			View_Paid_OrdersLocal.PostalCode.ViewCustomAttributes = ""

			' Notes
			View_Paid_OrdersLocal.Notes.ViewValue = View_Paid_OrdersLocal.Notes.CurrentValue
			View_Paid_OrdersLocal.Notes.ViewCustomAttributes = ""

			' ttest
			View_Paid_OrdersLocal.ttest.ViewValue = View_Paid_OrdersLocal.ttest.CurrentValue
			View_Paid_OrdersLocal.ttest.ViewCustomAttributes = ""

			' cancelleddate
			View_Paid_OrdersLocal.cancelleddate.ViewValue = View_Paid_OrdersLocal.cancelleddate.CurrentValue
			View_Paid_OrdersLocal.cancelleddate.ViewCustomAttributes = ""

			' cancelledby
			View_Paid_OrdersLocal.cancelledby.ViewValue = View_Paid_OrdersLocal.cancelledby.CurrentValue
			View_Paid_OrdersLocal.cancelledby.ViewCustomAttributes = ""

			' cancelledreason
			View_Paid_OrdersLocal.cancelledreason.ViewValue = View_Paid_OrdersLocal.cancelledreason.CurrentValue
			View_Paid_OrdersLocal.cancelledreason.ViewCustomAttributes = ""

			' acknowledgeddate
			View_Paid_OrdersLocal.acknowledgeddate.ViewValue = View_Paid_OrdersLocal.acknowledgeddate.CurrentValue
			View_Paid_OrdersLocal.acknowledgeddate.ViewCustomAttributes = ""

			' delivereddate
			View_Paid_OrdersLocal.delivereddate.ViewValue = View_Paid_OrdersLocal.delivereddate.CurrentValue
			View_Paid_OrdersLocal.delivereddate.ViewCustomAttributes = ""

			' cancelled
			View_Paid_OrdersLocal.cancelled.ViewValue = View_Paid_OrdersLocal.cancelled.CurrentValue
			View_Paid_OrdersLocal.cancelled.ViewCustomAttributes = ""

			' acknowledged
			View_Paid_OrdersLocal.acknowledged.ViewValue = View_Paid_OrdersLocal.acknowledged.CurrentValue
			View_Paid_OrdersLocal.acknowledged.ViewCustomAttributes = ""

			' outfordelivery
			View_Paid_OrdersLocal.outfordelivery.ViewValue = View_Paid_OrdersLocal.outfordelivery.CurrentValue
			View_Paid_OrdersLocal.outfordelivery.ViewCustomAttributes = ""

			' vouchercodediscount
			View_Paid_OrdersLocal.vouchercodediscount.ViewValue = View_Paid_OrdersLocal.vouchercodediscount.CurrentValue
			View_Paid_OrdersLocal.vouchercodediscount.ViewCustomAttributes = ""

			' vouchercode
			View_Paid_OrdersLocal.vouchercode.ViewValue = View_Paid_OrdersLocal.vouchercode.CurrentValue
			View_Paid_OrdersLocal.vouchercode.ViewCustomAttributes = ""

			' printed
			View_Paid_OrdersLocal.printed.ViewValue = View_Paid_OrdersLocal.printed.CurrentValue
			View_Paid_OrdersLocal.printed.ViewCustomAttributes = ""

			' deliverydistance
			View_Paid_OrdersLocal.deliverydistance.ViewValue = View_Paid_OrdersLocal.deliverydistance.CurrentValue
			View_Paid_OrdersLocal.deliverydistance.ViewCustomAttributes = ""

			' asaporder
			View_Paid_OrdersLocal.asaporder.ViewValue = View_Paid_OrdersLocal.asaporder.CurrentValue
			View_Paid_OrdersLocal.asaporder.ViewCustomAttributes = ""

			' DeliveryLat
			View_Paid_OrdersLocal.DeliveryLat.ViewValue = View_Paid_OrdersLocal.DeliveryLat.CurrentValue
			View_Paid_OrdersLocal.DeliveryLat.ViewCustomAttributes = ""

			' DeliveryLng
			View_Paid_OrdersLocal.DeliveryLng.ViewValue = View_Paid_OrdersLocal.DeliveryLng.CurrentValue
			View_Paid_OrdersLocal.DeliveryLng.ViewCustomAttributes = ""

			' ServiceCharge
			View_Paid_OrdersLocal.ServiceCharge.ViewValue = View_Paid_OrdersLocal.ServiceCharge.CurrentValue
			View_Paid_OrdersLocal.ServiceCharge.ViewCustomAttributes = ""

			' PaymentSurcharge
			View_Paid_OrdersLocal.PaymentSurcharge.ViewValue = View_Paid_OrdersLocal.PaymentSurcharge.CurrentValue
			View_Paid_OrdersLocal.PaymentSurcharge.ViewCustomAttributes = ""

			' Tax_Rate
			View_Paid_OrdersLocal.Tax_Rate.ViewValue = View_Paid_OrdersLocal.Tax_Rate.CurrentValue
			View_Paid_OrdersLocal.Tax_Rate.ViewCustomAttributes = ""

			' Tax_Amount
			View_Paid_OrdersLocal.Tax_Amount.ViewValue = View_Paid_OrdersLocal.Tax_Amount.CurrentValue
			View_Paid_OrdersLocal.Tax_Amount.ViewCustomAttributes = ""

			' Tip_Rate
			View_Paid_OrdersLocal.Tip_Rate.ViewValue = View_Paid_OrdersLocal.Tip_Rate.CurrentValue
			View_Paid_OrdersLocal.Tip_Rate.ViewCustomAttributes = ""

			' Tip_Amount
			View_Paid_OrdersLocal.Tip_Amount.ViewValue = View_Paid_OrdersLocal.Tip_Amount.CurrentValue
			View_Paid_OrdersLocal.Tip_Amount.ViewCustomAttributes = ""

			' Payment_Status
			View_Paid_OrdersLocal.Payment_Status.ViewValue = View_Paid_OrdersLocal.Payment_Status.CurrentValue
			View_Paid_OrdersLocal.Payment_Status.ViewCustomAttributes = ""

			' View refer script
			' ID

			View_Paid_OrdersLocal.ID.LinkCustomAttributes = ""
			View_Paid_OrdersLocal.ID.HrefValue = ""
			View_Paid_OrdersLocal.ID.TooltipValue = ""

			' CreationDate
			View_Paid_OrdersLocal.CreationDate.LinkCustomAttributes = ""
			View_Paid_OrdersLocal.CreationDate.HrefValue = ""
			View_Paid_OrdersLocal.CreationDate.TooltipValue = ""

			' OrderDate
			View_Paid_OrdersLocal.OrderDate.LinkCustomAttributes = ""
			View_Paid_OrdersLocal.OrderDate.HrefValue = ""
			View_Paid_OrdersLocal.OrderDate.TooltipValue = ""

			' DeliveryType
			View_Paid_OrdersLocal.DeliveryType.LinkCustomAttributes = ""
			View_Paid_OrdersLocal.DeliveryType.HrefValue = ""
			View_Paid_OrdersLocal.DeliveryType.TooltipValue = ""

			' DeliveryTime
			View_Paid_OrdersLocal.DeliveryTime.LinkCustomAttributes = ""
			View_Paid_OrdersLocal.DeliveryTime.HrefValue = ""
			View_Paid_OrdersLocal.DeliveryTime.TooltipValue = ""

			' PaymentType
			View_Paid_OrdersLocal.PaymentType.LinkCustomAttributes = ""
			View_Paid_OrdersLocal.PaymentType.HrefValue = ""
			View_Paid_OrdersLocal.PaymentType.TooltipValue = ""

			' SubTotal
			View_Paid_OrdersLocal.SubTotal.LinkCustomAttributes = ""
			View_Paid_OrdersLocal.SubTotal.HrefValue = ""
			View_Paid_OrdersLocal.SubTotal.TooltipValue = ""

			' ShippingFee
			View_Paid_OrdersLocal.ShippingFee.LinkCustomAttributes = ""
			View_Paid_OrdersLocal.ShippingFee.HrefValue = ""
			View_Paid_OrdersLocal.ShippingFee.TooltipValue = ""

			' OrderTotal
			View_Paid_OrdersLocal.OrderTotal.LinkCustomAttributes = ""
			View_Paid_OrdersLocal.OrderTotal.HrefValue = ""
			View_Paid_OrdersLocal.OrderTotal.TooltipValue = ""

			' IdBusinessDetail
			View_Paid_OrdersLocal.IdBusinessDetail.LinkCustomAttributes = ""
			View_Paid_OrdersLocal.IdBusinessDetail.HrefValue = ""
			View_Paid_OrdersLocal.IdBusinessDetail.TooltipValue = ""

			' SessionId
			View_Paid_OrdersLocal.SessionId.LinkCustomAttributes = ""
			View_Paid_OrdersLocal.SessionId.HrefValue = ""
			View_Paid_OrdersLocal.SessionId.TooltipValue = ""

			' FirstName
			View_Paid_OrdersLocal.FirstName.LinkCustomAttributes = ""
			View_Paid_OrdersLocal.FirstName.HrefValue = ""
			View_Paid_OrdersLocal.FirstName.TooltipValue = ""

			' LastName
			View_Paid_OrdersLocal.LastName.LinkCustomAttributes = ""
			View_Paid_OrdersLocal.LastName.HrefValue = ""
			View_Paid_OrdersLocal.LastName.TooltipValue = ""

			' Email
			View_Paid_OrdersLocal.zEmail.LinkCustomAttributes = ""
			View_Paid_OrdersLocal.zEmail.HrefValue = ""
			View_Paid_OrdersLocal.zEmail.TooltipValue = ""

			' Phone
			View_Paid_OrdersLocal.Phone.LinkCustomAttributes = ""
			View_Paid_OrdersLocal.Phone.HrefValue = ""
			View_Paid_OrdersLocal.Phone.TooltipValue = ""

			' Address
			View_Paid_OrdersLocal.Address.LinkCustomAttributes = ""
			View_Paid_OrdersLocal.Address.HrefValue = ""
			View_Paid_OrdersLocal.Address.TooltipValue = ""

			' PostalCode
			View_Paid_OrdersLocal.PostalCode.LinkCustomAttributes = ""
			View_Paid_OrdersLocal.PostalCode.HrefValue = ""
			View_Paid_OrdersLocal.PostalCode.TooltipValue = ""

			' Notes
			View_Paid_OrdersLocal.Notes.LinkCustomAttributes = ""
			View_Paid_OrdersLocal.Notes.HrefValue = ""
			View_Paid_OrdersLocal.Notes.TooltipValue = ""

			' ttest
			View_Paid_OrdersLocal.ttest.LinkCustomAttributes = ""
			View_Paid_OrdersLocal.ttest.HrefValue = ""
			View_Paid_OrdersLocal.ttest.TooltipValue = ""

			' cancelleddate
			View_Paid_OrdersLocal.cancelleddate.LinkCustomAttributes = ""
			View_Paid_OrdersLocal.cancelleddate.HrefValue = ""
			View_Paid_OrdersLocal.cancelleddate.TooltipValue = ""

			' cancelledby
			View_Paid_OrdersLocal.cancelledby.LinkCustomAttributes = ""
			View_Paid_OrdersLocal.cancelledby.HrefValue = ""
			View_Paid_OrdersLocal.cancelledby.TooltipValue = ""

			' cancelledreason
			View_Paid_OrdersLocal.cancelledreason.LinkCustomAttributes = ""
			View_Paid_OrdersLocal.cancelledreason.HrefValue = ""
			View_Paid_OrdersLocal.cancelledreason.TooltipValue = ""

			' acknowledgeddate
			View_Paid_OrdersLocal.acknowledgeddate.LinkCustomAttributes = ""
			View_Paid_OrdersLocal.acknowledgeddate.HrefValue = ""
			View_Paid_OrdersLocal.acknowledgeddate.TooltipValue = ""

			' delivereddate
			View_Paid_OrdersLocal.delivereddate.LinkCustomAttributes = ""
			View_Paid_OrdersLocal.delivereddate.HrefValue = ""
			View_Paid_OrdersLocal.delivereddate.TooltipValue = ""

			' cancelled
			View_Paid_OrdersLocal.cancelled.LinkCustomAttributes = ""
			View_Paid_OrdersLocal.cancelled.HrefValue = ""
			View_Paid_OrdersLocal.cancelled.TooltipValue = ""

			' acknowledged
			View_Paid_OrdersLocal.acknowledged.LinkCustomAttributes = ""
			View_Paid_OrdersLocal.acknowledged.HrefValue = ""
			View_Paid_OrdersLocal.acknowledged.TooltipValue = ""

			' outfordelivery
			View_Paid_OrdersLocal.outfordelivery.LinkCustomAttributes = ""
			View_Paid_OrdersLocal.outfordelivery.HrefValue = ""
			View_Paid_OrdersLocal.outfordelivery.TooltipValue = ""

			' vouchercodediscount
			View_Paid_OrdersLocal.vouchercodediscount.LinkCustomAttributes = ""
			View_Paid_OrdersLocal.vouchercodediscount.HrefValue = ""
			View_Paid_OrdersLocal.vouchercodediscount.TooltipValue = ""

			' vouchercode
			View_Paid_OrdersLocal.vouchercode.LinkCustomAttributes = ""
			View_Paid_OrdersLocal.vouchercode.HrefValue = ""
			View_Paid_OrdersLocal.vouchercode.TooltipValue = ""

			' printed
			View_Paid_OrdersLocal.printed.LinkCustomAttributes = ""
			View_Paid_OrdersLocal.printed.HrefValue = ""
			View_Paid_OrdersLocal.printed.TooltipValue = ""

			' deliverydistance
			View_Paid_OrdersLocal.deliverydistance.LinkCustomAttributes = ""
			View_Paid_OrdersLocal.deliverydistance.HrefValue = ""
			View_Paid_OrdersLocal.deliverydistance.TooltipValue = ""

			' asaporder
			View_Paid_OrdersLocal.asaporder.LinkCustomAttributes = ""
			View_Paid_OrdersLocal.asaporder.HrefValue = ""
			View_Paid_OrdersLocal.asaporder.TooltipValue = ""

			' DeliveryLat
			View_Paid_OrdersLocal.DeliveryLat.LinkCustomAttributes = ""
			View_Paid_OrdersLocal.DeliveryLat.HrefValue = ""
			View_Paid_OrdersLocal.DeliveryLat.TooltipValue = ""

			' DeliveryLng
			View_Paid_OrdersLocal.DeliveryLng.LinkCustomAttributes = ""
			View_Paid_OrdersLocal.DeliveryLng.HrefValue = ""
			View_Paid_OrdersLocal.DeliveryLng.TooltipValue = ""

			' ServiceCharge
			View_Paid_OrdersLocal.ServiceCharge.LinkCustomAttributes = ""
			View_Paid_OrdersLocal.ServiceCharge.HrefValue = ""
			View_Paid_OrdersLocal.ServiceCharge.TooltipValue = ""

			' PaymentSurcharge
			View_Paid_OrdersLocal.PaymentSurcharge.LinkCustomAttributes = ""
			View_Paid_OrdersLocal.PaymentSurcharge.HrefValue = ""
			View_Paid_OrdersLocal.PaymentSurcharge.TooltipValue = ""

			' Tax_Rate
			View_Paid_OrdersLocal.Tax_Rate.LinkCustomAttributes = ""
			View_Paid_OrdersLocal.Tax_Rate.HrefValue = ""
			View_Paid_OrdersLocal.Tax_Rate.TooltipValue = ""

			' Tax_Amount
			View_Paid_OrdersLocal.Tax_Amount.LinkCustomAttributes = ""
			View_Paid_OrdersLocal.Tax_Amount.HrefValue = ""
			View_Paid_OrdersLocal.Tax_Amount.TooltipValue = ""

			' Tip_Rate
			View_Paid_OrdersLocal.Tip_Rate.LinkCustomAttributes = ""
			View_Paid_OrdersLocal.Tip_Rate.HrefValue = ""
			View_Paid_OrdersLocal.Tip_Rate.TooltipValue = ""

			' Tip_Amount
			View_Paid_OrdersLocal.Tip_Amount.LinkCustomAttributes = ""
			View_Paid_OrdersLocal.Tip_Amount.HrefValue = ""
			View_Paid_OrdersLocal.Tip_Amount.TooltipValue = ""

			' Payment_Status
			View_Paid_OrdersLocal.Payment_Status.LinkCustomAttributes = ""
			View_Paid_OrdersLocal.Payment_Status.HrefValue = ""
			View_Paid_OrdersLocal.Payment_Status.TooltipValue = ""
		End If

		' Call Row Rendered event
		If View_Paid_OrdersLocal.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call View_Paid_OrdersLocal.Row_Rendered()
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
			item.Body = "<a href=""javascript:void(0);"" class=""ewExportLink ewPdf"" title=""" & ew_HtmlEncode(Language.Phrase("ExportToPDFText")) & """ data-caption=""" & ew_HtmlEncode(Language.Phrase("ExportToPDFText")) & """ onclick=""ew_Export(document.fView_Paid_OrdersLocallist,'" & ExportPdfUrl & "','pdf',true);"">" & Language.Phrase("ExportToPDF") & "</a>"
		Else
			item.Body = "<a href=""" & ExportPdfUrl & """ class=""ewExportLink ewPdf"" title=""" & ew_HtmlEncode(Language.Phrase("ExportToPDFText")) & """ data-caption=""" & ew_HtmlEncode(Language.Phrase("ExportToPDFText")) & """>" & Language.Phrase("ExportToPDF") & "</a>"
		End If
		item.Visible = False

		' Export to Email
		ExportOptions.Add("email")
		Set item = ExportOptions.GetItem("email")
		url = ew_IIf(ExportEmailCustom, ",url:'" & PageUrl & "export=email&amp;custom=1'", "")
		item.Body = "<button id=""emf_View_Paid_OrdersLocal"" class=""ewExportLink ewEmail"" title=""" & Language.Phrase("ExportToEmailText") & """ data-caption=""" & Language.Phrase("ExportToEmailText") & """ onclick=""ew_EmailDialogShow({lnk:'emf_View_Paid_OrdersLocal',hdr:ewLanguage.Phrase('ExportToEmailText'),f:document.fView_Paid_OrdersLocallist,sel:false" & url & "});"">" & Language.Phrase("ExportToEmail") & "</button>"
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
		If View_Paid_OrdersLocal.ExportAll Then
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
		If View_Paid_OrdersLocal.Export = "xml" Then
			Set XmlDoc = New cXMLDocument
		Else
			Set View_Paid_OrdersLocal.ExportDoc = New cExportDocument
			Set Doc = View_Paid_OrdersLocal.ExportDoc
			Set Doc.Table = View_Paid_OrdersLocal
			Call Doc.ChangeStyle("h")

			' Call Page Exporting server event
			Doc.ExportCustom = (Not Page_Exporting())
		End If
		Dim rsdetail, detailcnt
		Dim ParentTable
		ParentTable = ""
		If View_Paid_OrdersLocal.Export = "xml" Then
			Call View_Paid_OrdersLocal.ExportXmlDocument(XmlDoc, (ParentTable <> ""), rs, StartRec, StopRec, "")
		Else
			Dim sHeader
			sHeader = PageHeader
			Call Page_DataRendering(sHeader)
			Doc.Text = Doc.Text & sHeader
			Call View_Paid_OrdersLocal.ExportDocument(Doc, rs, StartRec, StopRec, "")
			Dim sFooter
			sFooter = PageFooter
			Call Page_DataRendered(sFooter)
			Doc.Text = Doc.Text & sFooter
		End If

		' Close recordset and connection
		Rs.Close
		Set Rs = Nothing

		' Export header and footer
		If View_Paid_OrdersLocal.Export <> "xml" Then
			Call Doc.ExportHeaderAndFooter()

			' Call Page Exported server event
			Call Page_Exported()
		End If
		If View_Paid_OrdersLocal.Export = "xml" Then
			XmlDoc.Output
			Set XmlDoc = Nothing
		Else
			If View_Paid_OrdersLocal.Export = "email" Then
				Response.Write ExportEmail(Doc.Text)
			ElseIf View_Paid_OrdersLocal.Export = "pdf" Then
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
		Call Breadcrumb.Add("list", View_Paid_OrdersLocal.TableVar, url, "", View_Paid_OrdersLocal.TableVar, True)
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
