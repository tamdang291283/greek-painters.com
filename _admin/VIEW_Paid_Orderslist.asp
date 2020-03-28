<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="VIEW_Paid_Ordersinfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim VIEW_Paid_Orders_list
Set VIEW_Paid_Orders_list = New cVIEW_Paid_Orders_list
Set Page = VIEW_Paid_Orders_list

' Page init processing
VIEW_Paid_Orders_list.Page_Init()

' Page main processing
VIEW_Paid_Orders_list.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
VIEW_Paid_Orders_list.Page_Render()
%>
<!--#include file="header.asp"-->
<% If VIEW_Paid_Orders.Export = "" Then %>
<script type="text/javascript">
// Page object
var VIEW_Paid_Orders_list = new ew_Page("VIEW_Paid_Orders_list");
VIEW_Paid_Orders_list.PageID = "list"; // Page ID
var EW_PAGE_ID = VIEW_Paid_Orders_list.PageID; // For backward compatibility
// Form object
var fVIEW_Paid_Orderslist = new ew_Form("fVIEW_Paid_Orderslist");
fVIEW_Paid_Orderslist.FormKeyCountName = '<%= VIEW_Paid_Orders_list.FormKeyCountName %>';
// Form_CustomValidate event
fVIEW_Paid_Orderslist.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fVIEW_Paid_Orderslist.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fVIEW_Paid_Orderslist.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
var fVIEW_Paid_Orderslistsrch = new ew_Form("fVIEW_Paid_Orderslistsrch");
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
<% If VIEW_Paid_Orders.Export = "" Then %>
<div class="ewToolbar">
<% If VIEW_Paid_Orders.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If VIEW_Paid_Orders_list.TotalRecs > 0 And VIEW_Paid_Orders_list.ExportOptions.Visible Then %>
<% VIEW_Paid_Orders_list.ExportOptions.Render "body", "", "", "", "", "" %>
<% End If %>
<% If VIEW_Paid_Orders_list.SearchOptions.Visible Then %>
<% VIEW_Paid_Orders_list.SearchOptions.Render "body", "", "", "", "", "" %>
<% End If %>
<% If VIEW_Paid_Orders.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% End If %>
<% If (VIEW_Paid_Orders.Export = "") Or (EW_EXPORT_MASTER_RECORD And VIEW_Paid_Orders.Export = "print") Then %>
<% End If %>
<%

' Load recordset
'Set VIEW_Paid_Orders_list.Recordset = VIEW_Paid_Orders_list.LoadRecordset()

	VIEW_Paid_Orders_list.TotalRecs = VIEW_Paid_Orders_list.Recordset.RecordCount
	VIEW_Paid_Orders_list.StartRec = 1
	If VIEW_Paid_Orders_list.DisplayRecs <= 0 Then ' Display all records
		VIEW_Paid_Orders_list.DisplayRecs = VIEW_Paid_Orders_list.TotalRecs
	End If
	If Not (VIEW_Paid_Orders.ExportAll And VIEW_Paid_Orders.Export <> "") Then
		VIEW_Paid_Orders_list.SetUpStartRec() ' Set up start record position
	End If

	' Set no record found message
	If VIEW_Paid_Orders.CurrentAction = "" And VIEW_Paid_Orders_list.TotalRecs = 0 Then
		If VIEW_Paid_Orders_list.SearchWhere = "0=101" Then
			VIEW_Paid_Orders_list.WarningMessage = Language.Phrase("EnterSearchCriteria")
		Else
			VIEW_Paid_Orders_list.WarningMessage = Language.Phrase("NoRecord")
		End If
	End If
VIEW_Paid_Orders_list.RenderOtherOptions()
%>
<% If VIEW_Paid_Orders.Export = "" And VIEW_Paid_Orders.CurrentAction = "" Then %>
<form name="fVIEW_Paid_Orderslistsrch" id="fVIEW_Paid_Orderslistsrch" class="form-inline ewForm" action="<%= ew_CurrentPage %>">
<% SearchPanelClass = ew_IIf(VIEW_Paid_Orders_list.SearchWhere <> "", " in", " in") %>
<div id="fVIEW_Paid_Orderslistsrch_SearchPanel" class="ewSearchPanel collapse<%= SearchPanelClass %>">
<input type="hidden" name="cmd" value="search">
<input type="hidden" name="t" value="VIEW_Paid_Orders">
	<div class="ewBasicSearch">
<div id="xsr_1" class="ewRow">
	<div class="ewQuickSearch input-group">
	<input type="text" name="<%= EW_TABLE_BASIC_SEARCH %>" id="<%= EW_TABLE_BASIC_SEARCH %>" class="form-control" value="<%= ew_HtmlEncode(VIEW_Paid_Orders.BasicSearch.getKeyword()) %>" placeholder="<%= ew_HtmlEncode(Language.Phrase("Search")) %>">
	<input type="hidden" name="<%= EW_TABLE_BASIC_SEARCH_TYPE %>" id="<%= EW_TABLE_BASIC_SEARCH_TYPE %>" value="<%= ew_HtmlEncode(VIEW_Paid_Orders.BasicSearch.getSearchType()) %>">
	<div class="input-group-btn">
		<button type="button" data-toggle="dropdown" class="btn btn-default"><span id="searchtype"><%= VIEW_Paid_Orders.BasicSearch.getSearchTypeNameShort() %></span><span class="caret"></span></button>
		<ul class="dropdown-menu pull-right" role="menu">
			<li<% If VIEW_Paid_Orders.BasicSearch.getSearchType() = "" Then Response.Write " class=""active""" %>><a href="javascript:void(0);" onclick="ew_SetSearchType(this)"><%= Language.Phrase("QuickSearchAuto") %></a></li>
			<li<% If VIEW_Paid_Orders.BasicSearch.getSearchType() = "=" Then Response.Write " class=""active""" %>><a href="javascript:void(0);" onclick="ew_SetSearchType(this,'=')"><%= Language.Phrase("QuickSearchExact") %></a></li>
			<li<% If VIEW_Paid_Orders.BasicSearch.getSearchType() = "AND" Then Response.Write " class=""active""" %>><a href="javascript:void(0);" onclick="ew_SetSearchType(this,'AND')"><%= Language.Phrase("QuickSearchAll") %></a></li>
			<li<% If VIEW_Paid_Orders.BasicSearch.getSearchType() = "OR" Then Response.Write " class=""active""" %>><a href="javascript:void(0);" onclick="ew_SetSearchType(this,'OR')"><%= Language.Phrase("QuickSearchAny") %></a></li>
		</ul>
	<button class="btn btn-primary ewButton" name="btnsubmit" id="btnsubmit" type="submit"><%= Language.Phrase("QuickSearchBtn") %></button>
	</div>
	</div>
</div>
	</div>
</div>
</form>
<% End If %>
<% VIEW_Paid_Orders_list.ShowPageHeader() %>
<% VIEW_Paid_Orders_list.ShowMessage %>
<% If VIEW_Paid_Orders_list.TotalRecs > 0 Or VIEW_Paid_Orders.CurrentAction <> "" Then %>
<div class="ewGrid">
<% If VIEW_Paid_Orders.Export = "" Then %>
<div class="ewGridUpperPanel">
<% If VIEW_Paid_Orders.CurrentAction <> "gridadd" And VIEW_Paid_Orders.CurrentAction <> "gridedit" Then %>
<form name="ewPagerForm" class="form-inline ewForm ewPagerForm" action="<%= ew_CurrentPage %>">
<% If Not IsObject(VIEW_Paid_Orders_list.Pager) Then Set VIEW_Paid_Orders_list.Pager = ew_NewPrevNextPager(VIEW_Paid_Orders_list.StartRec, VIEW_Paid_Orders_list.DisplayRecs, VIEW_Paid_Orders_list.TotalRecs) %>
<% If VIEW_Paid_Orders_list.Pager.RecordCount > 0 Then %>
<div class="ewPager">
<span><%= Language.Phrase("Page") %>&nbsp;</span>
<div class="ewPrevNext"><div class="input-group">
<div class="input-group-btn">
<!--first page button-->
	<% If VIEW_Paid_Orders_list.Pager.FirstButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerFirst") %>" href="<%= VIEW_Paid_Orders_list.PageUrl %>start=<%= VIEW_Paid_Orders_list.Pager.FirstButton.Start %>"><span class="icon-first ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerFirst") %>"><span class="icon-first ewIcon"></span></a>
	<% End If %>
<!--previous page button-->
	<% If VIEW_Paid_Orders_list.Pager.PrevButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerPrevious") %>" href="<%= VIEW_Paid_Orders_list.PageUrl %>start=<%= VIEW_Paid_Orders_list.Pager.PrevButton.Start %>"><span class="icon-prev ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerPrevious") %>"><span class="icon-prev ewIcon"></span></a>
	<% End If %>
</div>
<!--current page number-->
	<input class="form-control input-sm" type="text" name="<%= EW_TABLE_PAGE_NO %>" value="<%= VIEW_Paid_Orders_list.Pager.CurrentPage %>">
<div class="input-group-btn">
<!--next page button-->
	<% If VIEW_Paid_Orders_list.Pager.NextButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerNext") %>" href="<%= VIEW_Paid_Orders_list.PageUrl %>start=<%= VIEW_Paid_Orders_list.Pager.NextButton.Start %>"><span class="icon-next ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerNext") %>"><span class="icon-next ewIcon"></span></a>
	<% End If %>
<!--last page button-->
	<% If VIEW_Paid_Orders_list.Pager.LastButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerLast") %>" href="<%= VIEW_Paid_Orders_list.PageUrl %>start=<%= VIEW_Paid_Orders_list.Pager.LastButton.Start %>"><span class="icon-last ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerLast") %>"><span class="icon-last ewIcon"></span></a>
	<% End If %>
</div>
</div>
</div>
<span>&nbsp;<%= Language.Phrase("of") %>&nbsp;<%= VIEW_Paid_Orders_list.Pager.PageCount %></span>
</div>
<div class="ewPager ewRec">
	<span><%= Language.Phrase("Record") %>&nbsp;<%= VIEW_Paid_Orders_list.Pager.FromIndex %>&nbsp;<%= Language.Phrase("To") %>&nbsp;<%= VIEW_Paid_Orders_list.Pager.ToIndex %>&nbsp;<%= Language.Phrase("Of") %>&nbsp;<%= VIEW_Paid_Orders_list.Pager.RecordCount %></span>
</div>
<% End If %>
<% If VIEW_Paid_Orders_list.TotalRecs > 0 Then %>
<div class="ewPager">
<input type="hidden" name="t" value="VIEW_Paid_Orders">
<select name="<%= EW_TABLE_REC_PER_PAGE %>" class="form-control input-sm" onchange="this.form.submit();">
<option value="20"<% If VIEW_Paid_Orders_list.DisplayRecs = 20 Then %> selected="selected"<% End If %>>20</option>
<option value="50"<% If VIEW_Paid_Orders_list.DisplayRecs = 50 Then %> selected="selected"<% End If %>>50</option>
<option value="100"<% If VIEW_Paid_Orders_list.DisplayRecs = 100 Then %> selected="selected"<% End If %>>100</option>
<option value="500"<% If VIEW_Paid_Orders_list.DisplayRecs = 500 Then %> selected="selected"<% End If %>>500</option>
<option value="1000"<% If VIEW_Paid_Orders_list.DisplayRecs = 1000 Then %> selected="selected"<% End If %>>1000</option>
<option value="ALL"<% If VIEW_Paid_Orders.RecordsPerPage = -1 Then %> selected="selected"<% End If %>><%= Language.Phrase("AllRecords") %></option>
</select>
</div>
<% End If %>
</form>
<% End If %>
<div class="ewListOtherOptions">
<%
	VIEW_Paid_Orders_list.AddEditOptions.Render "body", "", "", "", "", ""
	VIEW_Paid_Orders_list.DetailOptions.Render "body", "", "", "", "", ""
	VIEW_Paid_Orders_list.ActionOptions.Render "body", "", "", "", "", ""
%>
</div>
<div class="clearfix"></div>
</div>
<% End If %>
<form name="fVIEW_Paid_Orderslist" id="fVIEW_Paid_Orderslist" class="form-inline ewForm ewListForm" action="<%= ew_CurrentPage %>" method="post">
<% If VIEW_Paid_Orders_list.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= VIEW_Paid_Orders_list.Token %>">
<% End If %>
<input type="hidden" name="t" value="VIEW_Paid_Orders">
<div id="gmp_VIEW_Paid_Orders" class="<% If ew_IsResponsiveLayout() Then Response.Write "table-responsive " %>ewGridMiddlePanel">
<% If VIEW_Paid_Orders_list.TotalRecs > 0 Then %>
<table id="tbl_VIEW_Paid_Orderslist" class="table ewTable">
<%= VIEW_Paid_Orders.TableCustomInnerHtml %>
<thead><!-- Table header -->
	<tr class="ewTableHeader">
<%

' Header row
VIEW_Paid_Orders.RowType = EW_ROWTYPE_HEADER
Call VIEW_Paid_Orders_list.RenderListOptions()

' Render list options (header, left)
VIEW_Paid_Orders_list.ListOptions.Render "header", "left", "", "", "", ""
%>
<% If VIEW_Paid_Orders.ID.Visible Then ' ID %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.ID) = "" Then %>
		<th data-name="ID"><div id="elh_VIEW_Paid_Orders_ID" class="VIEW_Paid_Orders_ID"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.ID.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="ID"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.ID) %>',1);"><div id="elh_VIEW_Paid_Orders_ID" class="VIEW_Paid_Orders_ID">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.ID.FldCaption %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.ID.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.ID.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.CreationDate.Visible Then ' CreationDate %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.CreationDate) = "" Then %>
		<th data-name="CreationDate"><div id="elh_VIEW_Paid_Orders_CreationDate" class="VIEW_Paid_Orders_CreationDate"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.CreationDate.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="CreationDate"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.CreationDate) %>',1);"><div id="elh_VIEW_Paid_Orders_CreationDate" class="VIEW_Paid_Orders_CreationDate">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.CreationDate.FldCaption %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.CreationDate.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.CreationDate.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.OrderDate.Visible Then ' OrderDate %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.OrderDate) = "" Then %>
		<th data-name="OrderDate"><div id="elh_VIEW_Paid_Orders_OrderDate" class="VIEW_Paid_Orders_OrderDate"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.OrderDate.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="OrderDate"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.OrderDate) %>',1);"><div id="elh_VIEW_Paid_Orders_OrderDate" class="VIEW_Paid_Orders_OrderDate">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.OrderDate.FldCaption %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.OrderDate.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.OrderDate.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.DeliveryType.Visible Then ' DeliveryType %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.DeliveryType) = "" Then %>
		<th data-name="DeliveryType"><div id="elh_VIEW_Paid_Orders_DeliveryType" class="VIEW_Paid_Orders_DeliveryType"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.DeliveryType.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="DeliveryType"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.DeliveryType) %>',1);"><div id="elh_VIEW_Paid_Orders_DeliveryType" class="VIEW_Paid_Orders_DeliveryType">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.DeliveryType.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.DeliveryType.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.DeliveryType.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.DeliveryTime.Visible Then ' DeliveryTime %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.DeliveryTime) = "" Then %>
		<th data-name="DeliveryTime"><div id="elh_VIEW_Paid_Orders_DeliveryTime" class="VIEW_Paid_Orders_DeliveryTime"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.DeliveryTime.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="DeliveryTime"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.DeliveryTime) %>',1);"><div id="elh_VIEW_Paid_Orders_DeliveryTime" class="VIEW_Paid_Orders_DeliveryTime">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.DeliveryTime.FldCaption %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.DeliveryTime.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.DeliveryTime.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.PaymentType.Visible Then ' PaymentType %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.PaymentType) = "" Then %>
		<th data-name="PaymentType"><div id="elh_VIEW_Paid_Orders_PaymentType" class="VIEW_Paid_Orders_PaymentType"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.PaymentType.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="PaymentType"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.PaymentType) %>',1);"><div id="elh_VIEW_Paid_Orders_PaymentType" class="VIEW_Paid_Orders_PaymentType">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.PaymentType.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.PaymentType.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.PaymentType.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.SubTotal.Visible Then ' SubTotal %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.SubTotal) = "" Then %>
		<th data-name="SubTotal"><div id="elh_VIEW_Paid_Orders_SubTotal" class="VIEW_Paid_Orders_SubTotal"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.SubTotal.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="SubTotal"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.SubTotal) %>',1);"><div id="elh_VIEW_Paid_Orders_SubTotal" class="VIEW_Paid_Orders_SubTotal">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.SubTotal.FldCaption %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.SubTotal.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.SubTotal.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.ShippingFee.Visible Then ' ShippingFee %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.ShippingFee) = "" Then %>
		<th data-name="ShippingFee"><div id="elh_VIEW_Paid_Orders_ShippingFee" class="VIEW_Paid_Orders_ShippingFee"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.ShippingFee.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="ShippingFee"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.ShippingFee) %>',1);"><div id="elh_VIEW_Paid_Orders_ShippingFee" class="VIEW_Paid_Orders_ShippingFee">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.ShippingFee.FldCaption %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.ShippingFee.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.ShippingFee.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.OrderTotal.Visible Then ' OrderTotal %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.OrderTotal) = "" Then %>
		<th data-name="OrderTotal"><div id="elh_VIEW_Paid_Orders_OrderTotal" class="VIEW_Paid_Orders_OrderTotal"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.OrderTotal.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="OrderTotal"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.OrderTotal) %>',1);"><div id="elh_VIEW_Paid_Orders_OrderTotal" class="VIEW_Paid_Orders_OrderTotal">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.OrderTotal.FldCaption %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.OrderTotal.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.OrderTotal.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.IdBusinessDetail) = "" Then %>
		<th data-name="IdBusinessDetail"><div id="elh_VIEW_Paid_Orders_IdBusinessDetail" class="VIEW_Paid_Orders_IdBusinessDetail"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.IdBusinessDetail.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="IdBusinessDetail"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.IdBusinessDetail) %>',1);"><div id="elh_VIEW_Paid_Orders_IdBusinessDetail" class="VIEW_Paid_Orders_IdBusinessDetail">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.IdBusinessDetail.FldCaption %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.IdBusinessDetail.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.IdBusinessDetail.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.SessionId.Visible Then ' SessionId %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.SessionId) = "" Then %>
		<th data-name="SessionId"><div id="elh_VIEW_Paid_Orders_SessionId" class="VIEW_Paid_Orders_SessionId"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.SessionId.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="SessionId"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.SessionId) %>',1);"><div id="elh_VIEW_Paid_Orders_SessionId" class="VIEW_Paid_Orders_SessionId">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.SessionId.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.SessionId.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.SessionId.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.FirstName.Visible Then ' FirstName %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.FirstName) = "" Then %>
		<th data-name="FirstName"><div id="elh_VIEW_Paid_Orders_FirstName" class="VIEW_Paid_Orders_FirstName"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.FirstName.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="FirstName"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.FirstName) %>',1);"><div id="elh_VIEW_Paid_Orders_FirstName" class="VIEW_Paid_Orders_FirstName">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.FirstName.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.FirstName.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.FirstName.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.LastName.Visible Then ' LastName %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.LastName) = "" Then %>
		<th data-name="LastName"><div id="elh_VIEW_Paid_Orders_LastName" class="VIEW_Paid_Orders_LastName"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.LastName.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="LastName"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.LastName) %>',1);"><div id="elh_VIEW_Paid_Orders_LastName" class="VIEW_Paid_Orders_LastName">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.LastName.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.LastName.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.LastName.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.zEmail.Visible Then ' Email %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.zEmail) = "" Then %>
		<th data-name="zEmail"><div id="elh_VIEW_Paid_Orders_zEmail" class="VIEW_Paid_Orders_zEmail"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.zEmail.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="zEmail"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.zEmail) %>',1);"><div id="elh_VIEW_Paid_Orders_zEmail" class="VIEW_Paid_Orders_zEmail">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.zEmail.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.zEmail.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.zEmail.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.Phone.Visible Then ' Phone %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.Phone) = "" Then %>
		<th data-name="Phone"><div id="elh_VIEW_Paid_Orders_Phone" class="VIEW_Paid_Orders_Phone"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.Phone.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Phone"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.Phone) %>',1);"><div id="elh_VIEW_Paid_Orders_Phone" class="VIEW_Paid_Orders_Phone">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.Phone.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.Phone.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.Phone.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.Address.Visible Then ' Address %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.Address) = "" Then %>
		<th data-name="Address"><div id="elh_VIEW_Paid_Orders_Address" class="VIEW_Paid_Orders_Address"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.Address.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Address"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.Address) %>',1);"><div id="elh_VIEW_Paid_Orders_Address" class="VIEW_Paid_Orders_Address">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.Address.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.Address.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.Address.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.PostalCode.Visible Then ' PostalCode %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.PostalCode) = "" Then %>
		<th data-name="PostalCode"><div id="elh_VIEW_Paid_Orders_PostalCode" class="VIEW_Paid_Orders_PostalCode"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.PostalCode.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="PostalCode"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.PostalCode) %>',1);"><div id="elh_VIEW_Paid_Orders_PostalCode" class="VIEW_Paid_Orders_PostalCode">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.PostalCode.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.PostalCode.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.PostalCode.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.ttest.Visible Then ' ttest %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.ttest) = "" Then %>
		<th data-name="ttest"><div id="elh_VIEW_Paid_Orders_ttest" class="VIEW_Paid_Orders_ttest"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.ttest.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="ttest"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.ttest) %>',1);"><div id="elh_VIEW_Paid_Orders_ttest" class="VIEW_Paid_Orders_ttest">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.ttest.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.ttest.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.ttest.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.cancelleddate.Visible Then ' cancelleddate %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.cancelleddate) = "" Then %>
		<th data-name="cancelleddate"><div id="elh_VIEW_Paid_Orders_cancelleddate" class="VIEW_Paid_Orders_cancelleddate"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.cancelleddate.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="cancelleddate"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.cancelleddate) %>',1);"><div id="elh_VIEW_Paid_Orders_cancelleddate" class="VIEW_Paid_Orders_cancelleddate">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.cancelleddate.FldCaption %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.cancelleddate.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.cancelleddate.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.cancelledby.Visible Then ' cancelledby %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.cancelledby) = "" Then %>
		<th data-name="cancelledby"><div id="elh_VIEW_Paid_Orders_cancelledby" class="VIEW_Paid_Orders_cancelledby"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.cancelledby.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="cancelledby"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.cancelledby) %>',1);"><div id="elh_VIEW_Paid_Orders_cancelledby" class="VIEW_Paid_Orders_cancelledby">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.cancelledby.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.cancelledby.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.cancelledby.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.cancelledreason.Visible Then ' cancelledreason %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.cancelledreason) = "" Then %>
		<th data-name="cancelledreason"><div id="elh_VIEW_Paid_Orders_cancelledreason" class="VIEW_Paid_Orders_cancelledreason"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.cancelledreason.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="cancelledreason"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.cancelledreason) %>',1);"><div id="elh_VIEW_Paid_Orders_cancelledreason" class="VIEW_Paid_Orders_cancelledreason">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.cancelledreason.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.cancelledreason.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.cancelledreason.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.acknowledgeddate.Visible Then ' acknowledgeddate %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.acknowledgeddate) = "" Then %>
		<th data-name="acknowledgeddate"><div id="elh_VIEW_Paid_Orders_acknowledgeddate" class="VIEW_Paid_Orders_acknowledgeddate"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.acknowledgeddate.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="acknowledgeddate"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.acknowledgeddate) %>',1);"><div id="elh_VIEW_Paid_Orders_acknowledgeddate" class="VIEW_Paid_Orders_acknowledgeddate">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.acknowledgeddate.FldCaption %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.acknowledgeddate.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.acknowledgeddate.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.delivereddate.Visible Then ' delivereddate %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.delivereddate) = "" Then %>
		<th data-name="delivereddate"><div id="elh_VIEW_Paid_Orders_delivereddate" class="VIEW_Paid_Orders_delivereddate"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.delivereddate.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="delivereddate"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.delivereddate) %>',1);"><div id="elh_VIEW_Paid_Orders_delivereddate" class="VIEW_Paid_Orders_delivereddate">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.delivereddate.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.delivereddate.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.delivereddate.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.cancelled.Visible Then ' cancelled %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.cancelled) = "" Then %>
		<th data-name="cancelled"><div id="elh_VIEW_Paid_Orders_cancelled" class="VIEW_Paid_Orders_cancelled"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.cancelled.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="cancelled"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.cancelled) %>',1);"><div id="elh_VIEW_Paid_Orders_cancelled" class="VIEW_Paid_Orders_cancelled">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.cancelled.FldCaption %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.cancelled.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.cancelled.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.acknowledged.Visible Then ' acknowledged %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.acknowledged) = "" Then %>
		<th data-name="acknowledged"><div id="elh_VIEW_Paid_Orders_acknowledged" class="VIEW_Paid_Orders_acknowledged"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.acknowledged.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="acknowledged"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.acknowledged) %>',1);"><div id="elh_VIEW_Paid_Orders_acknowledged" class="VIEW_Paid_Orders_acknowledged">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.acknowledged.FldCaption %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.acknowledged.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.acknowledged.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.outfordelivery.Visible Then ' outfordelivery %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.outfordelivery) = "" Then %>
		<th data-name="outfordelivery"><div id="elh_VIEW_Paid_Orders_outfordelivery" class="VIEW_Paid_Orders_outfordelivery"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.outfordelivery.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="outfordelivery"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.outfordelivery) %>',1);"><div id="elh_VIEW_Paid_Orders_outfordelivery" class="VIEW_Paid_Orders_outfordelivery">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.outfordelivery.FldCaption %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.outfordelivery.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.outfordelivery.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.vouchercodediscount.Visible Then ' vouchercodediscount %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.vouchercodediscount) = "" Then %>
		<th data-name="vouchercodediscount"><div id="elh_VIEW_Paid_Orders_vouchercodediscount" class="VIEW_Paid_Orders_vouchercodediscount"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.vouchercodediscount.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="vouchercodediscount"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.vouchercodediscount) %>',1);"><div id="elh_VIEW_Paid_Orders_vouchercodediscount" class="VIEW_Paid_Orders_vouchercodediscount">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.vouchercodediscount.FldCaption %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.vouchercodediscount.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.vouchercodediscount.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.vouchercode.Visible Then ' vouchercode %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.vouchercode) = "" Then %>
		<th data-name="vouchercode"><div id="elh_VIEW_Paid_Orders_vouchercode" class="VIEW_Paid_Orders_vouchercode"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.vouchercode.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="vouchercode"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.vouchercode) %>',1);"><div id="elh_VIEW_Paid_Orders_vouchercode" class="VIEW_Paid_Orders_vouchercode">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.vouchercode.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.vouchercode.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.vouchercode.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.printed.Visible Then ' printed %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.printed) = "" Then %>
		<th data-name="printed"><div id="elh_VIEW_Paid_Orders_printed" class="VIEW_Paid_Orders_printed"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.printed.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="printed"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.printed) %>',1);"><div id="elh_VIEW_Paid_Orders_printed" class="VIEW_Paid_Orders_printed">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.printed.FldCaption %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.printed.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.printed.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.deliverydistance.Visible Then ' deliverydistance %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.deliverydistance) = "" Then %>
		<th data-name="deliverydistance"><div id="elh_VIEW_Paid_Orders_deliverydistance" class="VIEW_Paid_Orders_deliverydistance"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.deliverydistance.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="deliverydistance"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.deliverydistance) %>',1);"><div id="elh_VIEW_Paid_Orders_deliverydistance" class="VIEW_Paid_Orders_deliverydistance">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.deliverydistance.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.deliverydistance.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.deliverydistance.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.asaporder.Visible Then ' asaporder %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.asaporder) = "" Then %>
		<th data-name="asaporder"><div id="elh_VIEW_Paid_Orders_asaporder" class="VIEW_Paid_Orders_asaporder"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.asaporder.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="asaporder"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.asaporder) %>',1);"><div id="elh_VIEW_Paid_Orders_asaporder" class="VIEW_Paid_Orders_asaporder">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.asaporder.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.asaporder.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.asaporder.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.DeliveryLat.Visible Then ' DeliveryLat %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.DeliveryLat) = "" Then %>
		<th data-name="DeliveryLat"><div id="elh_VIEW_Paid_Orders_DeliveryLat" class="VIEW_Paid_Orders_DeliveryLat"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.DeliveryLat.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="DeliveryLat"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.DeliveryLat) %>',1);"><div id="elh_VIEW_Paid_Orders_DeliveryLat" class="VIEW_Paid_Orders_DeliveryLat">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.DeliveryLat.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.DeliveryLat.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.DeliveryLat.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.DeliveryLng.Visible Then ' DeliveryLng %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.DeliveryLng) = "" Then %>
		<th data-name="DeliveryLng"><div id="elh_VIEW_Paid_Orders_DeliveryLng" class="VIEW_Paid_Orders_DeliveryLng"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.DeliveryLng.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="DeliveryLng"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.DeliveryLng) %>',1);"><div id="elh_VIEW_Paid_Orders_DeliveryLng" class="VIEW_Paid_Orders_DeliveryLng">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.DeliveryLng.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.DeliveryLng.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.DeliveryLng.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.ServiceCharge.Visible Then ' ServiceCharge %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.ServiceCharge) = "" Then %>
		<th data-name="ServiceCharge"><div id="elh_VIEW_Paid_Orders_ServiceCharge" class="VIEW_Paid_Orders_ServiceCharge"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.ServiceCharge.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="ServiceCharge"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.ServiceCharge) %>',1);"><div id="elh_VIEW_Paid_Orders_ServiceCharge" class="VIEW_Paid_Orders_ServiceCharge">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.ServiceCharge.FldCaption %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.ServiceCharge.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.ServiceCharge.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.PaymentSurcharge.Visible Then ' PaymentSurcharge %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.PaymentSurcharge) = "" Then %>
		<th data-name="PaymentSurcharge"><div id="elh_VIEW_Paid_Orders_PaymentSurcharge" class="VIEW_Paid_Orders_PaymentSurcharge"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.PaymentSurcharge.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="PaymentSurcharge"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.PaymentSurcharge) %>',1);"><div id="elh_VIEW_Paid_Orders_PaymentSurcharge" class="VIEW_Paid_Orders_PaymentSurcharge">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.PaymentSurcharge.FldCaption %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.PaymentSurcharge.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.PaymentSurcharge.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.FromIP.Visible Then ' FromIP %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.FromIP) = "" Then %>
		<th data-name="FromIP"><div id="elh_VIEW_Paid_Orders_FromIP" class="VIEW_Paid_Orders_FromIP"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.FromIP.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="FromIP"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.FromIP) %>',1);"><div id="elh_VIEW_Paid_Orders_FromIP" class="VIEW_Paid_Orders_FromIP">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.FromIP.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.FromIP.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.FromIP.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.Tax_Rate.Visible Then ' Tax_Rate %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.Tax_Rate) = "" Then %>
		<th data-name="Tax_Rate"><div id="elh_VIEW_Paid_Orders_Tax_Rate" class="VIEW_Paid_Orders_Tax_Rate"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.Tax_Rate.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Tax_Rate"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.Tax_Rate) %>',1);"><div id="elh_VIEW_Paid_Orders_Tax_Rate" class="VIEW_Paid_Orders_Tax_Rate">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.Tax_Rate.FldCaption %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.Tax_Rate.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.Tax_Rate.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.Tax_Amount.Visible Then ' Tax_Amount %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.Tax_Amount) = "" Then %>
		<th data-name="Tax_Amount"><div id="elh_VIEW_Paid_Orders_Tax_Amount" class="VIEW_Paid_Orders_Tax_Amount"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.Tax_Amount.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Tax_Amount"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.Tax_Amount) %>',1);"><div id="elh_VIEW_Paid_Orders_Tax_Amount" class="VIEW_Paid_Orders_Tax_Amount">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.Tax_Amount.FldCaption %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.Tax_Amount.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.Tax_Amount.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.Tip_Rate.Visible Then ' Tip_Rate %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.Tip_Rate) = "" Then %>
		<th data-name="Tip_Rate"><div id="elh_VIEW_Paid_Orders_Tip_Rate" class="VIEW_Paid_Orders_Tip_Rate"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.Tip_Rate.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Tip_Rate"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.Tip_Rate) %>',1);"><div id="elh_VIEW_Paid_Orders_Tip_Rate" class="VIEW_Paid_Orders_Tip_Rate">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.Tip_Rate.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.Tip_Rate.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.Tip_Rate.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.Tip_Amount.Visible Then ' Tip_Amount %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.Tip_Amount) = "" Then %>
		<th data-name="Tip_Amount"><div id="elh_VIEW_Paid_Orders_Tip_Amount" class="VIEW_Paid_Orders_Tip_Amount"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.Tip_Amount.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Tip_Amount"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.Tip_Amount) %>',1);"><div id="elh_VIEW_Paid_Orders_Tip_Amount" class="VIEW_Paid_Orders_Tip_Amount">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.Tip_Amount.FldCaption %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.Tip_Amount.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.Tip_Amount.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.Card_Debit.Visible Then ' Card_Debit %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.Card_Debit) = "" Then %>
		<th data-name="Card_Debit"><div id="elh_VIEW_Paid_Orders_Card_Debit" class="VIEW_Paid_Orders_Card_Debit"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.Card_Debit.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Card_Debit"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.Card_Debit) %>',1);"><div id="elh_VIEW_Paid_Orders_Card_Debit" class="VIEW_Paid_Orders_Card_Debit">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.Card_Debit.FldCaption %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.Card_Debit.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.Card_Debit.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.Card_Credit.Visible Then ' Card_Credit %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.Card_Credit) = "" Then %>
		<th data-name="Card_Credit"><div id="elh_VIEW_Paid_Orders_Card_Credit" class="VIEW_Paid_Orders_Card_Credit"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.Card_Credit.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Card_Credit"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.Card_Credit) %>',1);"><div id="elh_VIEW_Paid_Orders_Card_Credit" class="VIEW_Paid_Orders_Card_Credit">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.Card_Credit.FldCaption %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.Card_Credit.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.Card_Credit.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.SentEmail.Visible Then ' SentEmail %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.SentEmail) = "" Then %>
		<th data-name="SentEmail"><div id="elh_VIEW_Paid_Orders_SentEmail" class="VIEW_Paid_Orders_SentEmail"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.SentEmail.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="SentEmail"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.SentEmail) %>',1);"><div id="elh_VIEW_Paid_Orders_SentEmail" class="VIEW_Paid_Orders_SentEmail">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.SentEmail.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.SentEmail.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.SentEmail.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.deliverydelay.Visible Then ' deliverydelay %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.deliverydelay) = "" Then %>
		<th data-name="deliverydelay"><div id="elh_VIEW_Paid_Orders_deliverydelay" class="VIEW_Paid_Orders_deliverydelay"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.deliverydelay.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="deliverydelay"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.deliverydelay) %>',1);"><div id="elh_VIEW_Paid_Orders_deliverydelay" class="VIEW_Paid_Orders_deliverydelay">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.deliverydelay.FldCaption %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.deliverydelay.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.deliverydelay.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.collectiondelay.Visible Then ' collectiondelay %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.collectiondelay) = "" Then %>
		<th data-name="collectiondelay"><div id="elh_VIEW_Paid_Orders_collectiondelay" class="VIEW_Paid_Orders_collectiondelay"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.collectiondelay.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="collectiondelay"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.collectiondelay) %>',1);"><div id="elh_VIEW_Paid_Orders_collectiondelay" class="VIEW_Paid_Orders_collectiondelay">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.collectiondelay.FldCaption %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.collectiondelay.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.collectiondelay.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.lng_report.Visible Then ' lng_report %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.lng_report) = "" Then %>
		<th data-name="lng_report"><div id="elh_VIEW_Paid_Orders_lng_report" class="VIEW_Paid_Orders_lng_report"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.lng_report.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="lng_report"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.lng_report) %>',1);"><div id="elh_VIEW_Paid_Orders_lng_report" class="VIEW_Paid_Orders_lng_report">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.lng_report.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.lng_report.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.lng_report.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.lat_report.Visible Then ' lat_report %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.lat_report) = "" Then %>
		<th data-name="lat_report"><div id="elh_VIEW_Paid_Orders_lat_report" class="VIEW_Paid_Orders_lat_report"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.lat_report.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="lat_report"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.lat_report) %>',1);"><div id="elh_VIEW_Paid_Orders_lat_report" class="VIEW_Paid_Orders_lat_report">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.lat_report.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.lat_report.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.lat_report.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If VIEW_Paid_Orders.Payment_status.Visible Then ' Payment_status %>
	<% If VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.Payment_status) = "" Then %>
		<th data-name="Payment_status"><div id="elh_VIEW_Paid_Orders_Payment_status" class="VIEW_Paid_Orders_Payment_status"><div class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.Payment_status.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Payment_status"><div class="ewPointer" onclick="ew_Sort(event,'<%= VIEW_Paid_Orders.SortUrl(VIEW_Paid_Orders.Payment_status) %>',1);"><div id="elh_VIEW_Paid_Orders_Payment_status" class="VIEW_Paid_Orders_Payment_status">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= VIEW_Paid_Orders.Payment_status.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If VIEW_Paid_Orders.Payment_status.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf VIEW_Paid_Orders.Payment_status.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<%

' Render list options (header, right)
VIEW_Paid_Orders_list.ListOptions.Render "header", "right", "", "", "", ""
%>
	</tr>
</thead>
<tbody><!-- Table body -->
<%
If (VIEW_Paid_Orders.ExportAll And VIEW_Paid_Orders.Export <> "") Then
	VIEW_Paid_Orders_list.StopRec = VIEW_Paid_Orders_list.TotalRecs
Else

	' Set the last record to display
	If VIEW_Paid_Orders_list.TotalRecs > VIEW_Paid_Orders_list.StartRec + VIEW_Paid_Orders_list.DisplayRecs - 1 Then
		VIEW_Paid_Orders_list.StopRec = VIEW_Paid_Orders_list.StartRec + VIEW_Paid_Orders_list.DisplayRecs - 1
	Else
		VIEW_Paid_Orders_list.StopRec = VIEW_Paid_Orders_list.TotalRecs
	End If
End If

' Move to first record
VIEW_Paid_Orders_list.RecCnt = VIEW_Paid_Orders_list.StartRec - 1
If Not VIEW_Paid_Orders_list.Recordset.Eof Then
	VIEW_Paid_Orders_list.Recordset.MoveFirst
	If VIEW_Paid_Orders_list.StartRec > 1 Then VIEW_Paid_Orders_list.Recordset.Move VIEW_Paid_Orders_list.StartRec - 1
ElseIf Not VIEW_Paid_Orders.AllowAddDeleteRow And VIEW_Paid_Orders_list.StopRec = 0 Then
	VIEW_Paid_Orders_list.StopRec = VIEW_Paid_Orders.GridAddRowCount
End If

' Initialize Aggregate
VIEW_Paid_Orders.RowType = EW_ROWTYPE_AGGREGATEINIT
Call VIEW_Paid_Orders.ResetAttrs()
Call VIEW_Paid_Orders_list.RenderRow()
VIEW_Paid_Orders_list.RowCnt = 0

' Output date rows
Do While CLng(VIEW_Paid_Orders_list.RecCnt) < CLng(VIEW_Paid_Orders_list.StopRec)
	VIEW_Paid_Orders_list.RecCnt = VIEW_Paid_Orders_list.RecCnt + 1
	If CLng(VIEW_Paid_Orders_list.RecCnt) >= CLng(VIEW_Paid_Orders_list.StartRec) Then
		VIEW_Paid_Orders_list.RowCnt = VIEW_Paid_Orders_list.RowCnt + 1

	' Set up key count
	VIEW_Paid_Orders_list.KeyCount = VIEW_Paid_Orders_list.RowIndex
	Call VIEW_Paid_Orders.ResetAttrs()
	VIEW_Paid_Orders.CssClass = ""
	If VIEW_Paid_Orders.CurrentAction = "gridadd" Then
	Else
		Call VIEW_Paid_Orders_list.LoadRowValues(VIEW_Paid_Orders_list.Recordset) ' Load row values
	End If
	VIEW_Paid_Orders.RowType = EW_ROWTYPE_VIEW ' Render view

	' Set up row id / data-rowindex
	VIEW_Paid_Orders.RowAttrs.AddAttributes Array(Array("data-rowindex", VIEW_Paid_Orders_list.RowCnt), Array("id", "r" & VIEW_Paid_Orders_list.RowCnt & "_VIEW_Paid_Orders"), Array("data-rowtype", VIEW_Paid_Orders.RowType))

	' Render row
	Call VIEW_Paid_Orders_list.RenderRow()

	' Render list options
	Call VIEW_Paid_Orders_list.RenderListOptions()
%>
	<tr<%= VIEW_Paid_Orders.RowAttributes %>>
<%

' Render list options (body, left)
VIEW_Paid_Orders_list.ListOptions.Render "body", "left", VIEW_Paid_Orders_list.RowCnt, "", "", ""
%>
	<% If VIEW_Paid_Orders.ID.Visible Then ' ID %>
		<td data-name="ID"<%= VIEW_Paid_Orders.ID.CellAttributes %>>
<span<%= VIEW_Paid_Orders.ID.ViewAttributes %>>
<%= VIEW_Paid_Orders.ID.ListViewValue %>
</span>
<a id="<%= VIEW_Paid_Orders_list.PageObjName & "_row_" & VIEW_Paid_Orders_list.RowCnt %>"></a></td>
	<% End If %>
	<% If VIEW_Paid_Orders.CreationDate.Visible Then ' CreationDate %>
		<td data-name="CreationDate"<%= VIEW_Paid_Orders.CreationDate.CellAttributes %>>
<span<%= VIEW_Paid_Orders.CreationDate.ViewAttributes %>>
<%= VIEW_Paid_Orders.CreationDate.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.OrderDate.Visible Then ' OrderDate %>
		<td data-name="OrderDate"<%= VIEW_Paid_Orders.OrderDate.CellAttributes %>>
<span<%= VIEW_Paid_Orders.OrderDate.ViewAttributes %>>
<%= VIEW_Paid_Orders.OrderDate.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.DeliveryType.Visible Then ' DeliveryType %>
		<td data-name="DeliveryType"<%= VIEW_Paid_Orders.DeliveryType.CellAttributes %>>
<span<%= VIEW_Paid_Orders.DeliveryType.ViewAttributes %>>
<%= VIEW_Paid_Orders.DeliveryType.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.DeliveryTime.Visible Then ' DeliveryTime %>
		<td data-name="DeliveryTime"<%= VIEW_Paid_Orders.DeliveryTime.CellAttributes %>>
<span<%= VIEW_Paid_Orders.DeliveryTime.ViewAttributes %>>
<%= VIEW_Paid_Orders.DeliveryTime.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.PaymentType.Visible Then ' PaymentType %>
		<td data-name="PaymentType"<%= VIEW_Paid_Orders.PaymentType.CellAttributes %>>
<span<%= VIEW_Paid_Orders.PaymentType.ViewAttributes %>>
<%= VIEW_Paid_Orders.PaymentType.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.SubTotal.Visible Then ' SubTotal %>
		<td data-name="SubTotal"<%= VIEW_Paid_Orders.SubTotal.CellAttributes %>>
<span<%= VIEW_Paid_Orders.SubTotal.ViewAttributes %>>
<%= VIEW_Paid_Orders.SubTotal.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.ShippingFee.Visible Then ' ShippingFee %>
		<td data-name="ShippingFee"<%= VIEW_Paid_Orders.ShippingFee.CellAttributes %>>
<span<%= VIEW_Paid_Orders.ShippingFee.ViewAttributes %>>
<%= VIEW_Paid_Orders.ShippingFee.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.OrderTotal.Visible Then ' OrderTotal %>
		<td data-name="OrderTotal"<%= VIEW_Paid_Orders.OrderTotal.CellAttributes %>>
<span<%= VIEW_Paid_Orders.OrderTotal.ViewAttributes %>>
<%= VIEW_Paid_Orders.OrderTotal.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
		<td data-name="IdBusinessDetail"<%= VIEW_Paid_Orders.IdBusinessDetail.CellAttributes %>>
<span<%= VIEW_Paid_Orders.IdBusinessDetail.ViewAttributes %>>
<%= VIEW_Paid_Orders.IdBusinessDetail.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.SessionId.Visible Then ' SessionId %>
		<td data-name="SessionId"<%= VIEW_Paid_Orders.SessionId.CellAttributes %>>
<span<%= VIEW_Paid_Orders.SessionId.ViewAttributes %>>
<%= VIEW_Paid_Orders.SessionId.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.FirstName.Visible Then ' FirstName %>
		<td data-name="FirstName"<%= VIEW_Paid_Orders.FirstName.CellAttributes %>>
<span<%= VIEW_Paid_Orders.FirstName.ViewAttributes %>>
<%= VIEW_Paid_Orders.FirstName.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.LastName.Visible Then ' LastName %>
		<td data-name="LastName"<%= VIEW_Paid_Orders.LastName.CellAttributes %>>
<span<%= VIEW_Paid_Orders.LastName.ViewAttributes %>>
<%= VIEW_Paid_Orders.LastName.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.zEmail.Visible Then ' Email %>
		<td data-name="zEmail"<%= VIEW_Paid_Orders.zEmail.CellAttributes %>>
<span<%= VIEW_Paid_Orders.zEmail.ViewAttributes %>>
<%= VIEW_Paid_Orders.zEmail.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.Phone.Visible Then ' Phone %>
		<td data-name="Phone"<%= VIEW_Paid_Orders.Phone.CellAttributes %>>
<span<%= VIEW_Paid_Orders.Phone.ViewAttributes %>>
<%= VIEW_Paid_Orders.Phone.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.Address.Visible Then ' Address %>
		<td data-name="Address"<%= VIEW_Paid_Orders.Address.CellAttributes %>>
<span<%= VIEW_Paid_Orders.Address.ViewAttributes %>>
<%= VIEW_Paid_Orders.Address.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.PostalCode.Visible Then ' PostalCode %>
		<td data-name="PostalCode"<%= VIEW_Paid_Orders.PostalCode.CellAttributes %>>
<span<%= VIEW_Paid_Orders.PostalCode.ViewAttributes %>>
<%= VIEW_Paid_Orders.PostalCode.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.ttest.Visible Then ' ttest %>
		<td data-name="ttest"<%= VIEW_Paid_Orders.ttest.CellAttributes %>>
<span<%= VIEW_Paid_Orders.ttest.ViewAttributes %>>
<%= VIEW_Paid_Orders.ttest.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.cancelleddate.Visible Then ' cancelleddate %>
		<td data-name="cancelleddate"<%= VIEW_Paid_Orders.cancelleddate.CellAttributes %>>
<span<%= VIEW_Paid_Orders.cancelleddate.ViewAttributes %>>
<%= VIEW_Paid_Orders.cancelleddate.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.cancelledby.Visible Then ' cancelledby %>
		<td data-name="cancelledby"<%= VIEW_Paid_Orders.cancelledby.CellAttributes %>>
<span<%= VIEW_Paid_Orders.cancelledby.ViewAttributes %>>
<%= VIEW_Paid_Orders.cancelledby.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.cancelledreason.Visible Then ' cancelledreason %>
		<td data-name="cancelledreason"<%= VIEW_Paid_Orders.cancelledreason.CellAttributes %>>
<span<%= VIEW_Paid_Orders.cancelledreason.ViewAttributes %>>
<%= VIEW_Paid_Orders.cancelledreason.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.acknowledgeddate.Visible Then ' acknowledgeddate %>
		<td data-name="acknowledgeddate"<%= VIEW_Paid_Orders.acknowledgeddate.CellAttributes %>>
<span<%= VIEW_Paid_Orders.acknowledgeddate.ViewAttributes %>>
<%= VIEW_Paid_Orders.acknowledgeddate.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.delivereddate.Visible Then ' delivereddate %>
		<td data-name="delivereddate"<%= VIEW_Paid_Orders.delivereddate.CellAttributes %>>
<span<%= VIEW_Paid_Orders.delivereddate.ViewAttributes %>>
<%= VIEW_Paid_Orders.delivereddate.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.cancelled.Visible Then ' cancelled %>
		<td data-name="cancelled"<%= VIEW_Paid_Orders.cancelled.CellAttributes %>>
<span<%= VIEW_Paid_Orders.cancelled.ViewAttributes %>>
<%= VIEW_Paid_Orders.cancelled.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.acknowledged.Visible Then ' acknowledged %>
		<td data-name="acknowledged"<%= VIEW_Paid_Orders.acknowledged.CellAttributes %>>
<span<%= VIEW_Paid_Orders.acknowledged.ViewAttributes %>>
<%= VIEW_Paid_Orders.acknowledged.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.outfordelivery.Visible Then ' outfordelivery %>
		<td data-name="outfordelivery"<%= VIEW_Paid_Orders.outfordelivery.CellAttributes %>>
<span<%= VIEW_Paid_Orders.outfordelivery.ViewAttributes %>>
<%= VIEW_Paid_Orders.outfordelivery.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.vouchercodediscount.Visible Then ' vouchercodediscount %>
		<td data-name="vouchercodediscount"<%= VIEW_Paid_Orders.vouchercodediscount.CellAttributes %>>
<span<%= VIEW_Paid_Orders.vouchercodediscount.ViewAttributes %>>
<%= VIEW_Paid_Orders.vouchercodediscount.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.vouchercode.Visible Then ' vouchercode %>
		<td data-name="vouchercode"<%= VIEW_Paid_Orders.vouchercode.CellAttributes %>>
<span<%= VIEW_Paid_Orders.vouchercode.ViewAttributes %>>
<%= VIEW_Paid_Orders.vouchercode.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.printed.Visible Then ' printed %>
		<td data-name="printed"<%= VIEW_Paid_Orders.printed.CellAttributes %>>
<span<%= VIEW_Paid_Orders.printed.ViewAttributes %>>
<%= VIEW_Paid_Orders.printed.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.deliverydistance.Visible Then ' deliverydistance %>
		<td data-name="deliverydistance"<%= VIEW_Paid_Orders.deliverydistance.CellAttributes %>>
<span<%= VIEW_Paid_Orders.deliverydistance.ViewAttributes %>>
<%= VIEW_Paid_Orders.deliverydistance.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.asaporder.Visible Then ' asaporder %>
		<td data-name="asaporder"<%= VIEW_Paid_Orders.asaporder.CellAttributes %>>
<span<%= VIEW_Paid_Orders.asaporder.ViewAttributes %>>
<%= VIEW_Paid_Orders.asaporder.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.DeliveryLat.Visible Then ' DeliveryLat %>
		<td data-name="DeliveryLat"<%= VIEW_Paid_Orders.DeliveryLat.CellAttributes %>>
<span<%= VIEW_Paid_Orders.DeliveryLat.ViewAttributes %>>
<%= VIEW_Paid_Orders.DeliveryLat.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.DeliveryLng.Visible Then ' DeliveryLng %>
		<td data-name="DeliveryLng"<%= VIEW_Paid_Orders.DeliveryLng.CellAttributes %>>
<span<%= VIEW_Paid_Orders.DeliveryLng.ViewAttributes %>>
<%= VIEW_Paid_Orders.DeliveryLng.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.ServiceCharge.Visible Then ' ServiceCharge %>
		<td data-name="ServiceCharge"<%= VIEW_Paid_Orders.ServiceCharge.CellAttributes %>>
<span<%= VIEW_Paid_Orders.ServiceCharge.ViewAttributes %>>
<%= VIEW_Paid_Orders.ServiceCharge.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.PaymentSurcharge.Visible Then ' PaymentSurcharge %>
		<td data-name="PaymentSurcharge"<%= VIEW_Paid_Orders.PaymentSurcharge.CellAttributes %>>
<span<%= VIEW_Paid_Orders.PaymentSurcharge.ViewAttributes %>>
<%= VIEW_Paid_Orders.PaymentSurcharge.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.FromIP.Visible Then ' FromIP %>
		<td data-name="FromIP"<%= VIEW_Paid_Orders.FromIP.CellAttributes %>>
<span<%= VIEW_Paid_Orders.FromIP.ViewAttributes %>>
<%= VIEW_Paid_Orders.FromIP.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.Tax_Rate.Visible Then ' Tax_Rate %>
		<td data-name="Tax_Rate"<%= VIEW_Paid_Orders.Tax_Rate.CellAttributes %>>
<span<%= VIEW_Paid_Orders.Tax_Rate.ViewAttributes %>>
<%= VIEW_Paid_Orders.Tax_Rate.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.Tax_Amount.Visible Then ' Tax_Amount %>
		<td data-name="Tax_Amount"<%= VIEW_Paid_Orders.Tax_Amount.CellAttributes %>>
<span<%= VIEW_Paid_Orders.Tax_Amount.ViewAttributes %>>
<%= VIEW_Paid_Orders.Tax_Amount.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.Tip_Rate.Visible Then ' Tip_Rate %>
		<td data-name="Tip_Rate"<%= VIEW_Paid_Orders.Tip_Rate.CellAttributes %>>
<span<%= VIEW_Paid_Orders.Tip_Rate.ViewAttributes %>>
<%= VIEW_Paid_Orders.Tip_Rate.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.Tip_Amount.Visible Then ' Tip_Amount %>
		<td data-name="Tip_Amount"<%= VIEW_Paid_Orders.Tip_Amount.CellAttributes %>>
<span<%= VIEW_Paid_Orders.Tip_Amount.ViewAttributes %>>
<%= VIEW_Paid_Orders.Tip_Amount.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.Card_Debit.Visible Then ' Card_Debit %>
		<td data-name="Card_Debit"<%= VIEW_Paid_Orders.Card_Debit.CellAttributes %>>
<span<%= VIEW_Paid_Orders.Card_Debit.ViewAttributes %>>
<%= VIEW_Paid_Orders.Card_Debit.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.Card_Credit.Visible Then ' Card_Credit %>
		<td data-name="Card_Credit"<%= VIEW_Paid_Orders.Card_Credit.CellAttributes %>>
<span<%= VIEW_Paid_Orders.Card_Credit.ViewAttributes %>>
<%= VIEW_Paid_Orders.Card_Credit.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.SentEmail.Visible Then ' SentEmail %>
		<td data-name="SentEmail"<%= VIEW_Paid_Orders.SentEmail.CellAttributes %>>
<span<%= VIEW_Paid_Orders.SentEmail.ViewAttributes %>>
<%= VIEW_Paid_Orders.SentEmail.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.deliverydelay.Visible Then ' deliverydelay %>
		<td data-name="deliverydelay"<%= VIEW_Paid_Orders.deliverydelay.CellAttributes %>>
<span<%= VIEW_Paid_Orders.deliverydelay.ViewAttributes %>>
<%= VIEW_Paid_Orders.deliverydelay.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.collectiondelay.Visible Then ' collectiondelay %>
		<td data-name="collectiondelay"<%= VIEW_Paid_Orders.collectiondelay.CellAttributes %>>
<span<%= VIEW_Paid_Orders.collectiondelay.ViewAttributes %>>
<%= VIEW_Paid_Orders.collectiondelay.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.lng_report.Visible Then ' lng_report %>
		<td data-name="lng_report"<%= VIEW_Paid_Orders.lng_report.CellAttributes %>>
<span<%= VIEW_Paid_Orders.lng_report.ViewAttributes %>>
<%= VIEW_Paid_Orders.lng_report.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.lat_report.Visible Then ' lat_report %>
		<td data-name="lat_report"<%= VIEW_Paid_Orders.lat_report.CellAttributes %>>
<span<%= VIEW_Paid_Orders.lat_report.ViewAttributes %>>
<%= VIEW_Paid_Orders.lat_report.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If VIEW_Paid_Orders.Payment_status.Visible Then ' Payment_status %>
		<td data-name="Payment_status"<%= VIEW_Paid_Orders.Payment_status.CellAttributes %>>
<span<%= VIEW_Paid_Orders.Payment_status.ViewAttributes %>>
<%= VIEW_Paid_Orders.Payment_status.ListViewValue %>
</span>
</td>
	<% End If %>
<%

' Render list options (body, right)
VIEW_Paid_Orders_list.ListOptions.Render "body", "right", VIEW_Paid_Orders_list.RowCnt, "", "", ""
%>
	</tr>
<%
	End If
	If VIEW_Paid_Orders.CurrentAction <> "gridadd" Then
		VIEW_Paid_Orders_list.Recordset.MoveNext()
	End If
Loop
%>
</tbody>
</table>
<% End If %>
<% If VIEW_Paid_Orders.CurrentAction = "" Then %>
<input type="hidden" name="a_list" id="a_list" value="">
<% End If %>
</div>
</form>
<%

' Close recordset and connection
VIEW_Paid_Orders_list.Recordset.Close
Set VIEW_Paid_Orders_list.Recordset = Nothing
%>
<% If VIEW_Paid_Orders.Export = "" Then %>
<div class="ewGridLowerPanel">
<% If VIEW_Paid_Orders.CurrentAction <> "gridadd" And VIEW_Paid_Orders.CurrentAction <> "gridedit" Then %>
<form name="ewPagerForm" class="ewForm form-inline ewPagerForm" action="<%= ew_CurrentPage %>">
<% If Not IsObject(VIEW_Paid_Orders_list.Pager) Then Set VIEW_Paid_Orders_list.Pager = ew_NewPrevNextPager(VIEW_Paid_Orders_list.StartRec, VIEW_Paid_Orders_list.DisplayRecs, VIEW_Paid_Orders_list.TotalRecs) %>
<% If VIEW_Paid_Orders_list.Pager.RecordCount > 0 Then %>
<div class="ewPager">
<span><%= Language.Phrase("Page") %>&nbsp;</span>
<div class="ewPrevNext"><div class="input-group">
<div class="input-group-btn">
<!--first page button-->
	<% If VIEW_Paid_Orders_list.Pager.FirstButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerFirst") %>" href="<%= VIEW_Paid_Orders_list.PageUrl %>start=<%= VIEW_Paid_Orders_list.Pager.FirstButton.Start %>"><span class="icon-first ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerFirst") %>"><span class="icon-first ewIcon"></span></a>
	<% End If %>
<!--previous page button-->
	<% If VIEW_Paid_Orders_list.Pager.PrevButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerPrevious") %>" href="<%= VIEW_Paid_Orders_list.PageUrl %>start=<%= VIEW_Paid_Orders_list.Pager.PrevButton.Start %>"><span class="icon-prev ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerPrevious") %>"><span class="icon-prev ewIcon"></span></a>
	<% End If %>
</div>
<!--current page number-->
	<input class="form-control input-sm" type="text" name="<%= EW_TABLE_PAGE_NO %>" value="<%= VIEW_Paid_Orders_list.Pager.CurrentPage %>">
<div class="input-group-btn">
<!--next page button-->
	<% If VIEW_Paid_Orders_list.Pager.NextButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerNext") %>" href="<%= VIEW_Paid_Orders_list.PageUrl %>start=<%= VIEW_Paid_Orders_list.Pager.NextButton.Start %>"><span class="icon-next ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerNext") %>"><span class="icon-next ewIcon"></span></a>
	<% End If %>
<!--last page button-->
	<% If VIEW_Paid_Orders_list.Pager.LastButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerLast") %>" href="<%= VIEW_Paid_Orders_list.PageUrl %>start=<%= VIEW_Paid_Orders_list.Pager.LastButton.Start %>"><span class="icon-last ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerLast") %>"><span class="icon-last ewIcon"></span></a>
	<% End If %>
</div>
</div>
</div>
<span>&nbsp;<%= Language.Phrase("of") %>&nbsp;<%= VIEW_Paid_Orders_list.Pager.PageCount %></span>
</div>
<div class="ewPager ewRec">
	<span><%= Language.Phrase("Record") %>&nbsp;<%= VIEW_Paid_Orders_list.Pager.FromIndex %>&nbsp;<%= Language.Phrase("To") %>&nbsp;<%= VIEW_Paid_Orders_list.Pager.ToIndex %>&nbsp;<%= Language.Phrase("Of") %>&nbsp;<%= VIEW_Paid_Orders_list.Pager.RecordCount %></span>
</div>
<% End If %>
<% If VIEW_Paid_Orders_list.TotalRecs > 0 Then %>
<div class="ewPager">
<input type="hidden" name="t" value="VIEW_Paid_Orders">
<select name="<%= EW_TABLE_REC_PER_PAGE %>" class="form-control input-sm" onchange="this.form.submit();">
<option value="20"<% If VIEW_Paid_Orders_list.DisplayRecs = 20 Then %> selected="selected"<% End If %>>20</option>
<option value="50"<% If VIEW_Paid_Orders_list.DisplayRecs = 50 Then %> selected="selected"<% End If %>>50</option>
<option value="100"<% If VIEW_Paid_Orders_list.DisplayRecs = 100 Then %> selected="selected"<% End If %>>100</option>
<option value="500"<% If VIEW_Paid_Orders_list.DisplayRecs = 500 Then %> selected="selected"<% End If %>>500</option>
<option value="1000"<% If VIEW_Paid_Orders_list.DisplayRecs = 1000 Then %> selected="selected"<% End If %>>1000</option>
<option value="ALL"<% If VIEW_Paid_Orders.RecordsPerPage = -1 Then %> selected="selected"<% End If %>><%= Language.Phrase("AllRecords") %></option>
</select>
</div>
<% End If %>
</form>
<% End If %>
<div class="ewListOtherOptions">
<%
	VIEW_Paid_Orders_list.AddEditOptions.Render "body", "bottom", "", "", "", ""
	VIEW_Paid_Orders_list.DetailOptions.Render "body", "bottom", "", "", "", ""
	VIEW_Paid_Orders_list.ActionOptions.Render "body", "bottom", "", "", "", ""
%>
</div>
<div class="clearfix"></div>
</div>
<% End If %>
</div>
<% End If %>
<% If VIEW_Paid_Orders_list.TotalRecs = 0 And VIEW_Paid_Orders.CurrentAction = "" Then ' Show other options %>
<div class="ewListOtherOptions">
<%
	VIEW_Paid_Orders_list.AddEditOptions.Render "body", "", "", "", "", ""
	VIEW_Paid_Orders_list.DetailOptions.Render "body", "", "", "", "", ""
	VIEW_Paid_Orders_list.ActionOptions.Render "body", "", "", "", "", ""
%>
</div>
<div class="clearfix"></div>
<% End If %>
<% If VIEW_Paid_Orders.Export <> "" Then %>
<script type="text/javascript">
ew_ApplyTemplate("body", "", "VIEW_Paid_Orderslist", "<%= VIEW_Paid_Orders.CustomExport %>");
</script>
<% End If %>
<% If VIEW_Paid_Orders.Export = "" Then %>
<script type="text/javascript">
fVIEW_Paid_Orderslistsrch.Init();
fVIEW_Paid_Orderslist.Init();
</script>
<% End If %>
<%
VIEW_Paid_Orders_list.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<% If VIEW_Paid_Orders.Export = "" Then %>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<% End If %>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set VIEW_Paid_Orders_list = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cVIEW_Paid_Orders_list

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
		TableName = "VIEW_Paid_Orders"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "VIEW_Paid_Orders_list"
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
		If VIEW_Paid_Orders.UseTokenInUrl Then PageUrl = PageUrl & "t=" & VIEW_Paid_Orders.TableVar & "&" ' add page token
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
		If VIEW_Paid_Orders.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (VIEW_Paid_Orders.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (VIEW_Paid_Orders.TableVar = Request.QueryString("t"))
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
		FormName = "fVIEW_Paid_Orderslist"
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
		If IsEmpty(VIEW_Paid_Orders) Then Set VIEW_Paid_Orders = New cVIEW_Paid_Orders
		Set Table = VIEW_Paid_Orders
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
		AddUrl = "VIEW_Paid_Ordersadd.asp"
		InlineAddUrl = PageUrl & "a=add"
		GridAddUrl = PageUrl & "a=gridadd"
		GridEditUrl = PageUrl & "a=gridedit"
		MultiDeleteUrl = "VIEW_Paid_Ordersdelete.asp"
		MultiUpdateUrl = "VIEW_Paid_Ordersupdate.asp"

		' Initialize form object
		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "list"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "VIEW_Paid_Orders"

		' Open connection to the database
		If IsEmpty(Conn) Then Call ew_Connect()

		' List options
		Set ListOptions = New cListOptions
		ListOptions.TableVar = VIEW_Paid_Orders.TableVar

		' Export options
		Set ExportOptions = New cListOptions
		ExportOptions.TableVar = VIEW_Paid_Orders.TableVar
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
			VIEW_Paid_Orders.Export = Request.QueryString("export")
			custom = Request.QueryString("custom") & ""
		ElseIf ew_IsHttpPost() Then
			If Request.Form("export").Count > 0 Then
				VIEW_Paid_Orders.Export = Request.Form("export")
				custom = Request.Form("custom") & ""
			ElseIf Request.Form("exporttype").Count > 0 Then
				VIEW_Paid_Orders.Export = Request.Form("exporttype")
				custom = Request.Form("custom") & ""
			End If
		Else
			VIEW_Paid_Orders.ExportReturnUrl = ew_CurrentUrl()
		End If
		gsExportFile = VIEW_Paid_Orders.TableVar ' Get export file, used in header
		Dim Charset ' Charset used in header
		If EW_CHARSET <> "" Then
			Charset = ";charset=" & EW_CHARSET
		Else
			Charset = ""
		End If

		' Get custom export parameters
		If VIEW_Paid_Orders.Export <> "" And custom <> "" Then
			VIEW_Paid_Orders.CustomExport = VIEW_Paid_Orders.Export
			VIEW_Paid_Orders.Export = "print"
		End If
		gsCustomExport = VIEW_Paid_Orders.CustomExport
		gsExport = VIEW_Paid_Orders.Export ' Get export parameter, used in header

		' Custom export (post back from ew_ApplyTemplate), export and terminate page
		If Request.Form("customexport").Count > 0 Then
			VIEW_Paid_Orders.CustomExport = Request.Form("customexport")
			VIEW_Paid_Orders.Export = VIEW_Paid_Orders.CustomExport
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
		If VIEW_Paid_Orders.Export = "excel" Then
			Response.ContentType = "application/vnd.ms-excel" & Charset
			Response.AddHeader "Content-Disposition", "attachment; filename=" & gsExportFile & ".xls"
		End If
		If VIEW_Paid_Orders.Export = "word" Then
			Response.ContentType = "application/vnd.ms-word" & Charset
			Response.AddHeader "Content-Disposition", "attachment; filename=" & gsExportFile & ".doc"
		End If
		If VIEW_Paid_Orders.Export = "csv" Then
			Response.BinaryWrite ChrB(239) & ChrB(187) & ChrB(191)
			Response.ContentType = "application/csv" & Charset
			Response.AddHeader "Content-Disposition", "attachment; filename=" & gsExportFile & ".csv"
		End If

		' Get grid add count
		Dim gridaddcnt
		gridaddcnt = Request.QueryString(EW_TABLE_GRID_ADD_ROW_COUNT)
		If IsNumeric(gridaddcnt) Then
			If gridaddcnt > 0 Then
				VIEW_Paid_Orders.GridAddRowCount = gridaddcnt
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
			results = VIEW_Paid_Orders.GetAutoFill(Request.Form("name"), Request.Form("q"))
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
		If UBound(VIEW_Paid_Orders.CustomActions.CustomArray) >= 0 Then
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
		If Not VIEW_Paid_Orders Is Nothing Then
			If VIEW_Paid_Orders.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = VIEW_Paid_Orders.TableVar
				If VIEW_Paid_Orders.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf VIEW_Paid_Orders.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf VIEW_Paid_Orders.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf VIEW_Paid_Orders.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set VIEW_Paid_Orders = Nothing
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
			If VIEW_Paid_Orders.Export = "" Then
				SetupBreadcrumb()
			End If

			' Hide list options
			If VIEW_Paid_Orders.Export <> "" Then
				Call ListOptions.HideAllOptions(Array("sequence"))
				ListOptions.UseDropDownButton = False ' Disable drop down button
				ListOptions.UseButtonGroup = False ' Disable button group
			ElseIf VIEW_Paid_Orders.CurrentAction = "gridadd" Or VIEW_Paid_Orders.CurrentAction = "gridedit" Then
				Call ListOptions.HideAllOptions(Array())
				ListOptions.UseDropDownButton = False ' Disable drop down button
				ListOptions.UseButtonGroup = False ' Disable button group
			End If

			' Hide export options
			If VIEW_Paid_Orders.Export <> "" Or VIEW_Paid_Orders.CurrentAction <> "" Then
				ExportOptions.HideAllOptions(Array())
			End If

			' Hide other options
			If VIEW_Paid_Orders.Export <> "" Then
				AddEditOptions.HideAllOptions(Array())
				DetailOptions.HideAllOptions(Array())
				ActionOptions.HideAllOptions(Array())
			End If

			' Get default search criteria
			Call ew_AddFilter(DefaultSearchWhere, BasicSearchWhere(True))

			' Get basic search values
			Call LoadBasicSearchValues()

			' Restore search parms from Session if not searching / reset / export
			If (VIEW_Paid_Orders.Export <> "" Or Command <> "search" And Command <> "reset" And Command <> "resetall") And CheckSearchParms() Then
				Call RestoreSearchParms()
			End If

			' Call Recordset SearchValidated event
			Call VIEW_Paid_Orders.Recordset_SearchValidated()

			' Set Up Sorting Order
			SetUpSortOrder()

			' Get basic search criteria
			If gsSearchError = "" Then
				sSrchBasic = BasicSearchWhere(False)
			End If
		End If ' End Validate Request

		' Restore display records
		If VIEW_Paid_Orders.RecordsPerPage <> "" Then
			DisplayRecs = VIEW_Paid_Orders.RecordsPerPage ' Restore from Session
		Else
			DisplayRecs = 20 ' Load default
		End If

		' Load Sorting Order
		LoadSortOrder()

		' Load search default if no existing search criteria
		If Not CheckSearchParms() Then

			' Load basic search from default
			VIEW_Paid_Orders.BasicSearch.Keyword = VIEW_Paid_Orders.BasicSearch.KeywordDefault
			VIEW_Paid_Orders.BasicSearch.SearchType = VIEW_Paid_Orders.BasicSearch.SearchTypeDefault
			VIEW_Paid_Orders.BasicSearch.setSearchType(VIEW_Paid_Orders.BasicSearch.SearchTypeDefault)
			If VIEW_Paid_Orders.BasicSearch.Keyword <> "" Then
				sSrchBasic = BasicSearchWhere(False)
			End If
		End If

		' Build search criteria
		Call ew_AddFilter(SearchWhere, sSrchAdvanced)
		Call ew_AddFilter(SearchWhere, sSrchBasic)

		' Call Recordset Searching event
		Call VIEW_Paid_Orders.Recordset_Searching(SearchWhere)

		' Save search criteria
		If Command = "search" And Not RestoreSearch Then
			VIEW_Paid_Orders.SearchWhere = SearchWhere ' Save to Session
			StartRec = 1 ' Reset start record counter
			VIEW_Paid_Orders.StartRecordNumber = StartRec
		Else
			SearchWhere = VIEW_Paid_Orders.SearchWhere
		End If
		sFilter = ""
		Call ew_AddFilter(sFilter, DbDetailFilter)
		Call ew_AddFilter(sFilter, SearchWhere)

		' Set up filter in Session
		VIEW_Paid_Orders.SessionWhere = sFilter
		VIEW_Paid_Orders.CurrentFilter = ""

		' Export Data only
		If VIEW_Paid_Orders.CustomExport = "" And ew_InArray(VIEW_Paid_Orders.Export, Array("html","word","excel","xml","csv","email","pdf")) Then
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
			VIEW_Paid_Orders.RecordsPerPage = DisplayRecs ' Save to Session

			' Reset start position
			StartRec = 1
			VIEW_Paid_Orders.StartRecordNumber = StartRec
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
				sFilter = VIEW_Paid_Orders.KeyFilter
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
			Call BuildBasicSearchSQL(sWhere, VIEW_Paid_Orders.DeliveryType, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, VIEW_Paid_Orders.PaymentType, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, VIEW_Paid_Orders.SessionId, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, VIEW_Paid_Orders.FirstName, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, VIEW_Paid_Orders.LastName, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, VIEW_Paid_Orders.zEmail, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, VIEW_Paid_Orders.Phone, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, VIEW_Paid_Orders.Address, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, VIEW_Paid_Orders.PostalCode, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, VIEW_Paid_Orders.Notes, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, VIEW_Paid_Orders.ttest, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, VIEW_Paid_Orders.cancelledby, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, VIEW_Paid_Orders.cancelledreason, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, VIEW_Paid_Orders.delivereddate, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, VIEW_Paid_Orders.vouchercode, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, VIEW_Paid_Orders.deliverydistance, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, VIEW_Paid_Orders.asaporder, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, VIEW_Paid_Orders.DeliveryLat, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, VIEW_Paid_Orders.DeliveryLng, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, VIEW_Paid_Orders.FromIP, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, VIEW_Paid_Orders.Tip_Rate, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, VIEW_Paid_Orders.SentEmail, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, VIEW_Paid_Orders.lng_report, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, VIEW_Paid_Orders.lat_report, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, VIEW_Paid_Orders.Payment_status, arKeywords, typ)
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
		sSearchKeyword = ew_IIf(Default, VIEW_Paid_Orders.BasicSearch.KeywordDefault, VIEW_Paid_Orders.BasicSearch.Keyword)
		sSearchType = ew_IIf(Default, VIEW_Paid_Orders.BasicSearch.SearchTypeDefault, VIEW_Paid_Orders.BasicSearch.SearchType)
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
			VIEW_Paid_Orders.BasicSearch.setKeyword(sSearchKeyword)
			VIEW_Paid_Orders.BasicSearch.setSearchType(sSearchType)
		End If
		BasicSearchWhere = sSearchStr
	End Function

	' Check if search parm exists
	Function CheckSearchParms()

		' Check basic search
		If VIEW_Paid_Orders.BasicSearch.IssetSession() Then
			CheckSearchParms = True
			Exit Function
		End If
		CheckSearchParms = False
	End Function

	' Clear all search parameters
	Sub ResetSearchParms()

		' Clear search where
		SearchWhere = ""
		VIEW_Paid_Orders.SearchWhere = SearchWhere

		' Clear basic search parameters
		Call ResetBasicSearchParms()
	End Sub

	' Load advanced search default values
	Function LoadAdvancedSearchDefault()
		LoadAdvancedSearchDefault = False
	End Function

	' Clear all basic search parameters
	Sub ResetBasicSearchParms()
		VIEW_Paid_Orders.BasicSearch.UnsetSession()
	End Sub

	' -----------------------------------------------------------------
	' Restore all search parameters
	'
	Sub RestoreSearchParms()

		' Restore search flag
		RestoreSearch = True

		' Restore basic search values
		Call VIEW_Paid_Orders.BasicSearch.Load()
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
			VIEW_Paid_Orders.CurrentOrder = Request.QueryString("order")
			VIEW_Paid_Orders.CurrentOrderType = Request.QueryString("ordertype")

			' Field ID
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.ID)

			' Field CreationDate
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.CreationDate)

			' Field OrderDate
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.OrderDate)

			' Field DeliveryType
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.DeliveryType)

			' Field DeliveryTime
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.DeliveryTime)

			' Field PaymentType
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.PaymentType)

			' Field SubTotal
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.SubTotal)

			' Field ShippingFee
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.ShippingFee)

			' Field OrderTotal
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.OrderTotal)

			' Field IdBusinessDetail
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.IdBusinessDetail)

			' Field SessionId
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.SessionId)

			' Field FirstName
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.FirstName)

			' Field LastName
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.LastName)

			' Field Email
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.zEmail)

			' Field Phone
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.Phone)

			' Field Address
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.Address)

			' Field PostalCode
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.PostalCode)

			' Field ttest
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.ttest)

			' Field cancelleddate
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.cancelleddate)

			' Field cancelledby
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.cancelledby)

			' Field cancelledreason
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.cancelledreason)

			' Field acknowledgeddate
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.acknowledgeddate)

			' Field delivereddate
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.delivereddate)

			' Field cancelled
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.cancelled)

			' Field acknowledged
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.acknowledged)

			' Field outfordelivery
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.outfordelivery)

			' Field vouchercodediscount
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.vouchercodediscount)

			' Field vouchercode
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.vouchercode)

			' Field printed
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.printed)

			' Field deliverydistance
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.deliverydistance)

			' Field asaporder
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.asaporder)

			' Field DeliveryLat
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.DeliveryLat)

			' Field DeliveryLng
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.DeliveryLng)

			' Field ServiceCharge
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.ServiceCharge)

			' Field PaymentSurcharge
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.PaymentSurcharge)

			' Field FromIP
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.FromIP)

			' Field Tax_Rate
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.Tax_Rate)

			' Field Tax_Amount
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.Tax_Amount)

			' Field Tip_Rate
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.Tip_Rate)

			' Field Tip_Amount
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.Tip_Amount)

			' Field Card_Debit
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.Card_Debit)

			' Field Card_Credit
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.Card_Credit)

			' Field SentEmail
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.SentEmail)

			' Field deliverydelay
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.deliverydelay)

			' Field collectiondelay
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.collectiondelay)

			' Field lng_report
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.lng_report)

			' Field lat_report
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.lat_report)

			' Field Payment_status
			Call VIEW_Paid_Orders.UpdateSort(VIEW_Paid_Orders.Payment_status)
			VIEW_Paid_Orders.StartRecordNumber = 1 ' Reset start position
		End If
	End Sub

	' -----------------------------------------------------------------
	' Load Sort Order parameters
	'
	Sub LoadSortOrder()
		Dim sOrderBy
		sOrderBy = VIEW_Paid_Orders.SessionOrderBy ' Get order by from Session
		If sOrderBy = "" Then
			If VIEW_Paid_Orders.SqlOrderBy <> "" Then
				sOrderBy = VIEW_Paid_Orders.SqlOrderBy
				VIEW_Paid_Orders.SessionOrderBy = sOrderBy
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
				VIEW_Paid_Orders.SessionOrderBy = sOrderBy
				VIEW_Paid_Orders.ID.Sort = ""
				VIEW_Paid_Orders.CreationDate.Sort = ""
				VIEW_Paid_Orders.OrderDate.Sort = ""
				VIEW_Paid_Orders.DeliveryType.Sort = ""
				VIEW_Paid_Orders.DeliveryTime.Sort = ""
				VIEW_Paid_Orders.PaymentType.Sort = ""
				VIEW_Paid_Orders.SubTotal.Sort = ""
				VIEW_Paid_Orders.ShippingFee.Sort = ""
				VIEW_Paid_Orders.OrderTotal.Sort = ""
				VIEW_Paid_Orders.IdBusinessDetail.Sort = ""
				VIEW_Paid_Orders.SessionId.Sort = ""
				VIEW_Paid_Orders.FirstName.Sort = ""
				VIEW_Paid_Orders.LastName.Sort = ""
				VIEW_Paid_Orders.zEmail.Sort = ""
				VIEW_Paid_Orders.Phone.Sort = ""
				VIEW_Paid_Orders.Address.Sort = ""
				VIEW_Paid_Orders.PostalCode.Sort = ""
				VIEW_Paid_Orders.ttest.Sort = ""
				VIEW_Paid_Orders.cancelleddate.Sort = ""
				VIEW_Paid_Orders.cancelledby.Sort = ""
				VIEW_Paid_Orders.cancelledreason.Sort = ""
				VIEW_Paid_Orders.acknowledgeddate.Sort = ""
				VIEW_Paid_Orders.delivereddate.Sort = ""
				VIEW_Paid_Orders.cancelled.Sort = ""
				VIEW_Paid_Orders.acknowledged.Sort = ""
				VIEW_Paid_Orders.outfordelivery.Sort = ""
				VIEW_Paid_Orders.vouchercodediscount.Sort = ""
				VIEW_Paid_Orders.vouchercode.Sort = ""
				VIEW_Paid_Orders.printed.Sort = ""
				VIEW_Paid_Orders.deliverydistance.Sort = ""
				VIEW_Paid_Orders.asaporder.Sort = ""
				VIEW_Paid_Orders.DeliveryLat.Sort = ""
				VIEW_Paid_Orders.DeliveryLng.Sort = ""
				VIEW_Paid_Orders.ServiceCharge.Sort = ""
				VIEW_Paid_Orders.PaymentSurcharge.Sort = ""
				VIEW_Paid_Orders.FromIP.Sort = ""
				VIEW_Paid_Orders.Tax_Rate.Sort = ""
				VIEW_Paid_Orders.Tax_Amount.Sort = ""
				VIEW_Paid_Orders.Tip_Rate.Sort = ""
				VIEW_Paid_Orders.Tip_Amount.Sort = ""
				VIEW_Paid_Orders.Card_Debit.Sort = ""
				VIEW_Paid_Orders.Card_Credit.Sort = ""
				VIEW_Paid_Orders.SentEmail.Sort = ""
				VIEW_Paid_Orders.deliverydelay.Sort = ""
				VIEW_Paid_Orders.collectiondelay.Sort = ""
				VIEW_Paid_Orders.lng_report.Sort = ""
				VIEW_Paid_Orders.lat_report.Sort = ""
				VIEW_Paid_Orders.Payment_status.Sort = ""
			End If

			' Reset start position
			StartRec = 1
			VIEW_Paid_Orders.StartRecordNumber = StartRec
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
			For i = 0 to UBound(VIEW_Paid_Orders.CustomActions.CustomArray)
				Action = VIEW_Paid_Orders.CustomActions.CustomArray(i)(0)
				Name = VIEW_Paid_Orders.CustomActions.CustomArray(i)(1)

				' Add custom action
				Call opt.Add("custom_" & Action)
				Set item = opt.GetItem("custom_" & Action)
				item.Body = "<a class=""ewAction ewCustomAction"" href="""" onclick=""ew_SubmitSelected(document.fVIEW_Paid_Orderslist, '" & ew_CurrentUrl & "', null, '" & Action & "');return false;"">" & Name & "</a>"
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
		sFilter = VIEW_Paid_Orders.GetKeyFilter
		UserAction = Request.Form("useraction") & ""
		Processed = False
		If sFilter <> "" And UserAction <> "" Then
			VIEW_Paid_Orders.CurrentFilter = sFilter
			sSql = VIEW_Paid_Orders.SQL
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
				ElseIf VIEW_Paid_Orders.CancelMessage <> "" Then
					FailureMessage = VIEW_Paid_Orders.CancelMessage
					VIEW_Paid_Orders.CancelMessage = ""
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
		SearchOptions.TableVar = VIEW_Paid_Orders.TableVar
		ExportOptions.Tag = "div"
		SearchOptions.TagClassName = "ewSearchOption"

		' Search button
		SearchOptions.Add("searchtoggle")
		Set item = SearchOptions.GetItem("searchtoggle")
		SearchToggleClass = ew_IIf(SearchWhere <> "", " active", " active")
		item.Body = "<button type=""button"" class=""btn btn-default ewSearchToggle" & SearchToggleClass & """ title=""" & Language.Phrase("SearchPanel") & """ data-caption=""" & Language.Phrase("SearchPanel") & """ data-toggle=""button"" data-form=""fVIEW_Paid_Orderslistsrch"">" & Language.Phrase("SearchBtn") & "</button>"
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
		If VIEW_Paid_Orders.Export <> "" Or VIEW_Paid_Orders.CurrentAction <> "" Then
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
				VIEW_Paid_Orders.StartRecordNumber = StartRec
			ElseIf Request.QueryString(EW_TABLE_PAGE_NO).Count > 0 Then
				PageNo = Request.QueryString(EW_TABLE_PAGE_NO)
				If IsNumeric(PageNo) Then
					StartRec = (PageNo-1)*DisplayRecs+1
					If StartRec <= 0 Then
						StartRec = 1
					ElseIf StartRec >= ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1 Then
						StartRec = ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1
					End If
					VIEW_Paid_Orders.StartRecordNumber = StartRec
				End If
			End If
		End If
		StartRec = VIEW_Paid_Orders.StartRecordNumber

		' Check if correct start record counter
		If Not IsNumeric(StartRec) Or StartRec = "" Then ' Avoid invalid start record counter
			StartRec = 1 ' Reset start record counter
			VIEW_Paid_Orders.StartRecordNumber = StartRec
		ElseIf CLng(StartRec) > CLng(TotalRecs) Then ' Avoid starting record > total records
			StartRec = ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1 ' Point to last page first record
			VIEW_Paid_Orders.StartRecordNumber = StartRec
		ElseIf (StartRec-1) Mod DisplayRecs <> 0 Then
			StartRec = ((StartRec-1)\DisplayRecs)*DisplayRecs+1 ' Point to page boundary
			VIEW_Paid_Orders.StartRecordNumber = StartRec
		End If
	End Sub

	' -----------------------------------------------------------------
	'  Load basic search values
	'
	Function LoadBasicSearchValues()
		VIEW_Paid_Orders.BasicSearch.Keyword = Request.QueryString(EW_TABLE_BASIC_SEARCH)&""
		If VIEW_Paid_Orders.BasicSearch.Keyword <> "" Then Command = "search"
		VIEW_Paid_Orders.BasicSearch.SearchType = Request.QueryString(EW_TABLE_BASIC_SEARCH_TYPE)&""
	End Function

	' -----------------------------------------------------------------
	' Load recordset
	'
	Function LoadRecordset()

		' Load list page sql
		Dim sSql
		sSql = VIEW_Paid_Orders.SelectSQL
		Call ew_SetDebugMsg("LoadRecordset: " & sSql) ' Show SQL for debugging

		' Load recordset
		Dim RsRecordset
		Set RsRecordset = ew_LoadRecordset(sSql)

		' Call Recordset Selected event
		Call VIEW_Paid_Orders.Recordset_Selected(RsRecordset)
		Set LoadRecordset = RsRecordset
	End Function

	' -----------------------------------------------------------------
	' Load row based on key values
	'
	Function LoadRow()
		Dim RsRow, sSql, sFilter
		sFilter = VIEW_Paid_Orders.KeyFilter

		' Call Row Selecting event
		Call VIEW_Paid_Orders.Row_Selecting(sFilter)

		' Load sql based on filter
		VIEW_Paid_Orders.CurrentFilter = sFilter
		sSql = VIEW_Paid_Orders.SQL
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
		Call VIEW_Paid_Orders.Row_Selected(RsRow)
		VIEW_Paid_Orders.ID.DbValue = RsRow("ID")
		VIEW_Paid_Orders.CreationDate.DbValue = RsRow("CreationDate")
		VIEW_Paid_Orders.OrderDate.DbValue = RsRow("OrderDate")
		VIEW_Paid_Orders.DeliveryType.DbValue = RsRow("DeliveryType")
		VIEW_Paid_Orders.DeliveryTime.DbValue = RsRow("DeliveryTime")
		VIEW_Paid_Orders.PaymentType.DbValue = RsRow("PaymentType")
		VIEW_Paid_Orders.SubTotal.DbValue = RsRow("SubTotal")
		VIEW_Paid_Orders.ShippingFee.DbValue = RsRow("ShippingFee")
		VIEW_Paid_Orders.OrderTotal.DbValue = RsRow("OrderTotal")
		VIEW_Paid_Orders.IdBusinessDetail.DbValue = RsRow("IdBusinessDetail")
		VIEW_Paid_Orders.SessionId.DbValue = RsRow("SessionId")
		VIEW_Paid_Orders.FirstName.DbValue = RsRow("FirstName")
		VIEW_Paid_Orders.LastName.DbValue = RsRow("LastName")
		VIEW_Paid_Orders.zEmail.DbValue = RsRow("Email")
		VIEW_Paid_Orders.Phone.DbValue = RsRow("Phone")
		VIEW_Paid_Orders.Address.DbValue = RsRow("Address")
		VIEW_Paid_Orders.PostalCode.DbValue = RsRow("PostalCode")
		VIEW_Paid_Orders.Notes.DbValue = RsRow("Notes")
		VIEW_Paid_Orders.ttest.DbValue = RsRow("ttest")
		VIEW_Paid_Orders.cancelleddate.DbValue = RsRow("cancelleddate")
		VIEW_Paid_Orders.cancelledby.DbValue = RsRow("cancelledby")
		VIEW_Paid_Orders.cancelledreason.DbValue = RsRow("cancelledreason")
		VIEW_Paid_Orders.acknowledgeddate.DbValue = RsRow("acknowledgeddate")
		VIEW_Paid_Orders.delivereddate.DbValue = RsRow("delivereddate")
		VIEW_Paid_Orders.cancelled.DbValue = RsRow("cancelled")
		VIEW_Paid_Orders.acknowledged.DbValue = RsRow("acknowledged")
		VIEW_Paid_Orders.outfordelivery.DbValue = RsRow("outfordelivery")
		VIEW_Paid_Orders.vouchercodediscount.DbValue = RsRow("vouchercodediscount")
		VIEW_Paid_Orders.vouchercode.DbValue = RsRow("vouchercode")
		VIEW_Paid_Orders.printed.DbValue = RsRow("printed")
		VIEW_Paid_Orders.deliverydistance.DbValue = RsRow("deliverydistance")
		VIEW_Paid_Orders.asaporder.DbValue = RsRow("asaporder")
		VIEW_Paid_Orders.DeliveryLat.DbValue = RsRow("DeliveryLat")
		VIEW_Paid_Orders.DeliveryLng.DbValue = RsRow("DeliveryLng")
		VIEW_Paid_Orders.ServiceCharge.DbValue = RsRow("ServiceCharge")
		VIEW_Paid_Orders.PaymentSurcharge.DbValue = RsRow("PaymentSurcharge")
		VIEW_Paid_Orders.FromIP.DbValue = RsRow("FromIP")
		VIEW_Paid_Orders.Tax_Rate.DbValue = RsRow("Tax_Rate")
		VIEW_Paid_Orders.Tax_Amount.DbValue = RsRow("Tax_Amount")
		VIEW_Paid_Orders.Tip_Rate.DbValue = RsRow("Tip_Rate")
		VIEW_Paid_Orders.Tip_Amount.DbValue = RsRow("Tip_Amount")
		VIEW_Paid_Orders.Card_Debit.DbValue = RsRow("Card_Debit")
		VIEW_Paid_Orders.Card_Credit.DbValue = RsRow("Card_Credit")
		VIEW_Paid_Orders.SentEmail.DbValue = RsRow("SentEmail")
		VIEW_Paid_Orders.deliverydelay.DbValue = RsRow("deliverydelay")
		VIEW_Paid_Orders.collectiondelay.DbValue = RsRow("collectiondelay")
		VIEW_Paid_Orders.lng_report.DbValue = RsRow("lng_report")
		VIEW_Paid_Orders.lat_report.DbValue = RsRow("lat_report")
		VIEW_Paid_Orders.Payment_status.DbValue = RsRow("Payment_status")
	End Sub

	' Load DbValue from recordset
	Sub LoadDbValues(Rs)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		If Rs.Eof Then Exit Sub
		VIEW_Paid_Orders.ID.m_DbValue = Rs("ID")
		VIEW_Paid_Orders.CreationDate.m_DbValue = Rs("CreationDate")
		VIEW_Paid_Orders.OrderDate.m_DbValue = Rs("OrderDate")
		VIEW_Paid_Orders.DeliveryType.m_DbValue = Rs("DeliveryType")
		VIEW_Paid_Orders.DeliveryTime.m_DbValue = Rs("DeliveryTime")
		VIEW_Paid_Orders.PaymentType.m_DbValue = Rs("PaymentType")
		VIEW_Paid_Orders.SubTotal.m_DbValue = Rs("SubTotal")
		VIEW_Paid_Orders.ShippingFee.m_DbValue = Rs("ShippingFee")
		VIEW_Paid_Orders.OrderTotal.m_DbValue = Rs("OrderTotal")
		VIEW_Paid_Orders.IdBusinessDetail.m_DbValue = Rs("IdBusinessDetail")
		VIEW_Paid_Orders.SessionId.m_DbValue = Rs("SessionId")
		VIEW_Paid_Orders.FirstName.m_DbValue = Rs("FirstName")
		VIEW_Paid_Orders.LastName.m_DbValue = Rs("LastName")
		VIEW_Paid_Orders.zEmail.m_DbValue = Rs("Email")
		VIEW_Paid_Orders.Phone.m_DbValue = Rs("Phone")
		VIEW_Paid_Orders.Address.m_DbValue = Rs("Address")
		VIEW_Paid_Orders.PostalCode.m_DbValue = Rs("PostalCode")
		VIEW_Paid_Orders.Notes.m_DbValue = Rs("Notes")
		VIEW_Paid_Orders.ttest.m_DbValue = Rs("ttest")
		VIEW_Paid_Orders.cancelleddate.m_DbValue = Rs("cancelleddate")
		VIEW_Paid_Orders.cancelledby.m_DbValue = Rs("cancelledby")
		VIEW_Paid_Orders.cancelledreason.m_DbValue = Rs("cancelledreason")
		VIEW_Paid_Orders.acknowledgeddate.m_DbValue = Rs("acknowledgeddate")
		VIEW_Paid_Orders.delivereddate.m_DbValue = Rs("delivereddate")
		VIEW_Paid_Orders.cancelled.m_DbValue = Rs("cancelled")
		VIEW_Paid_Orders.acknowledged.m_DbValue = Rs("acknowledged")
		VIEW_Paid_Orders.outfordelivery.m_DbValue = Rs("outfordelivery")
		VIEW_Paid_Orders.vouchercodediscount.m_DbValue = Rs("vouchercodediscount")
		VIEW_Paid_Orders.vouchercode.m_DbValue = Rs("vouchercode")
		VIEW_Paid_Orders.printed.m_DbValue = Rs("printed")
		VIEW_Paid_Orders.deliverydistance.m_DbValue = Rs("deliverydistance")
		VIEW_Paid_Orders.asaporder.m_DbValue = Rs("asaporder")
		VIEW_Paid_Orders.DeliveryLat.m_DbValue = Rs("DeliveryLat")
		VIEW_Paid_Orders.DeliveryLng.m_DbValue = Rs("DeliveryLng")
		VIEW_Paid_Orders.ServiceCharge.m_DbValue = Rs("ServiceCharge")
		VIEW_Paid_Orders.PaymentSurcharge.m_DbValue = Rs("PaymentSurcharge")
		VIEW_Paid_Orders.FromIP.m_DbValue = Rs("FromIP")
		VIEW_Paid_Orders.Tax_Rate.m_DbValue = Rs("Tax_Rate")
		VIEW_Paid_Orders.Tax_Amount.m_DbValue = Rs("Tax_Amount")
		VIEW_Paid_Orders.Tip_Rate.m_DbValue = Rs("Tip_Rate")
		VIEW_Paid_Orders.Tip_Amount.m_DbValue = Rs("Tip_Amount")
		VIEW_Paid_Orders.Card_Debit.m_DbValue = Rs("Card_Debit")
		VIEW_Paid_Orders.Card_Credit.m_DbValue = Rs("Card_Credit")
		VIEW_Paid_Orders.SentEmail.m_DbValue = Rs("SentEmail")
		VIEW_Paid_Orders.deliverydelay.m_DbValue = Rs("deliverydelay")
		VIEW_Paid_Orders.collectiondelay.m_DbValue = Rs("collectiondelay")
		VIEW_Paid_Orders.lng_report.m_DbValue = Rs("lng_report")
		VIEW_Paid_Orders.lat_report.m_DbValue = Rs("lat_report")
		VIEW_Paid_Orders.Payment_status.m_DbValue = Rs("Payment_status")
	End Sub

	' Load old record
	Function LoadOldRecord()

		' Load key values from Session
		Dim bValidKey
		bValidKey = True

		' Load old recordset
		If bValidKey Then
			VIEW_Paid_Orders.CurrentFilter = VIEW_Paid_Orders.KeyFilter
			Dim sSql
			sSql = VIEW_Paid_Orders.SQL
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
		ViewUrl = VIEW_Paid_Orders.ViewUrl("")
		EditUrl = VIEW_Paid_Orders.EditUrl("")
		InlineEditUrl = VIEW_Paid_Orders.InlineEditUrl
		CopyUrl = VIEW_Paid_Orders.CopyUrl("")
		InlineCopyUrl = VIEW_Paid_Orders.InlineCopyUrl
		DeleteUrl = VIEW_Paid_Orders.DeleteUrl

		' Convert decimal values if posted back
		If VIEW_Paid_Orders.SubTotal.FormValue = VIEW_Paid_Orders.SubTotal.CurrentValue And IsNumeric(VIEW_Paid_Orders.SubTotal.CurrentValue) Then
			VIEW_Paid_Orders.SubTotal.CurrentValue = ew_StrToFloat(VIEW_Paid_Orders.SubTotal.CurrentValue)
		End If

		' Convert decimal values if posted back
		If VIEW_Paid_Orders.ShippingFee.FormValue = VIEW_Paid_Orders.ShippingFee.CurrentValue And IsNumeric(VIEW_Paid_Orders.ShippingFee.CurrentValue) Then
			VIEW_Paid_Orders.ShippingFee.CurrentValue = ew_StrToFloat(VIEW_Paid_Orders.ShippingFee.CurrentValue)
		End If

		' Convert decimal values if posted back
		If VIEW_Paid_Orders.OrderTotal.FormValue = VIEW_Paid_Orders.OrderTotal.CurrentValue And IsNumeric(VIEW_Paid_Orders.OrderTotal.CurrentValue) Then
			VIEW_Paid_Orders.OrderTotal.CurrentValue = ew_StrToFloat(VIEW_Paid_Orders.OrderTotal.CurrentValue)
		End If

		' Convert decimal values if posted back
		If VIEW_Paid_Orders.ServiceCharge.FormValue = VIEW_Paid_Orders.ServiceCharge.CurrentValue And IsNumeric(VIEW_Paid_Orders.ServiceCharge.CurrentValue) Then
			VIEW_Paid_Orders.ServiceCharge.CurrentValue = ew_StrToFloat(VIEW_Paid_Orders.ServiceCharge.CurrentValue)
		End If

		' Convert decimal values if posted back
		If VIEW_Paid_Orders.PaymentSurcharge.FormValue = VIEW_Paid_Orders.PaymentSurcharge.CurrentValue And IsNumeric(VIEW_Paid_Orders.PaymentSurcharge.CurrentValue) Then
			VIEW_Paid_Orders.PaymentSurcharge.CurrentValue = ew_StrToFloat(VIEW_Paid_Orders.PaymentSurcharge.CurrentValue)
		End If

		' Convert decimal values if posted back
		If VIEW_Paid_Orders.Tax_Amount.FormValue = VIEW_Paid_Orders.Tax_Amount.CurrentValue And IsNumeric(VIEW_Paid_Orders.Tax_Amount.CurrentValue) Then
			VIEW_Paid_Orders.Tax_Amount.CurrentValue = ew_StrToFloat(VIEW_Paid_Orders.Tax_Amount.CurrentValue)
		End If

		' Convert decimal values if posted back
		If VIEW_Paid_Orders.Tip_Amount.FormValue = VIEW_Paid_Orders.Tip_Amount.CurrentValue And IsNumeric(VIEW_Paid_Orders.Tip_Amount.CurrentValue) Then
			VIEW_Paid_Orders.Tip_Amount.CurrentValue = ew_StrToFloat(VIEW_Paid_Orders.Tip_Amount.CurrentValue)
		End If

		' Call Row Rendering event
		Call VIEW_Paid_Orders.Row_Rendering()

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
		' FromIP
		' Tax_Rate
		' Tax_Amount
		' Tip_Rate
		' Tip_Amount
		' Card_Debit
		' Card_Credit
		' SentEmail
		' deliverydelay
		' collectiondelay
		' lng_report
		' lat_report
		' Payment_status
		' -----------
		'  View  Row
		' -----------

		If VIEW_Paid_Orders.RowType = EW_ROWTYPE_VIEW Then ' View row

			' ID
			VIEW_Paid_Orders.ID.ViewValue = VIEW_Paid_Orders.ID.CurrentValue
			VIEW_Paid_Orders.ID.ViewCustomAttributes = ""

			' CreationDate
			VIEW_Paid_Orders.CreationDate.ViewValue = VIEW_Paid_Orders.CreationDate.CurrentValue
			VIEW_Paid_Orders.CreationDate.ViewCustomAttributes = ""

			' OrderDate
			VIEW_Paid_Orders.OrderDate.ViewValue = VIEW_Paid_Orders.OrderDate.CurrentValue
			VIEW_Paid_Orders.OrderDate.ViewCustomAttributes = ""

			' DeliveryType
			VIEW_Paid_Orders.DeliveryType.ViewValue = VIEW_Paid_Orders.DeliveryType.CurrentValue
			VIEW_Paid_Orders.DeliveryType.ViewCustomAttributes = ""

			' DeliveryTime
			VIEW_Paid_Orders.DeliveryTime.ViewValue = VIEW_Paid_Orders.DeliveryTime.CurrentValue
			VIEW_Paid_Orders.DeliveryTime.ViewCustomAttributes = ""

			' PaymentType
			VIEW_Paid_Orders.PaymentType.ViewValue = VIEW_Paid_Orders.PaymentType.CurrentValue
			VIEW_Paid_Orders.PaymentType.ViewCustomAttributes = ""

			' SubTotal
			VIEW_Paid_Orders.SubTotal.ViewValue = VIEW_Paid_Orders.SubTotal.CurrentValue
			VIEW_Paid_Orders.SubTotal.ViewCustomAttributes = ""

			' ShippingFee
			VIEW_Paid_Orders.ShippingFee.ViewValue = VIEW_Paid_Orders.ShippingFee.CurrentValue
			VIEW_Paid_Orders.ShippingFee.ViewCustomAttributes = ""

			' OrderTotal
			VIEW_Paid_Orders.OrderTotal.ViewValue = VIEW_Paid_Orders.OrderTotal.CurrentValue
			VIEW_Paid_Orders.OrderTotal.ViewCustomAttributes = ""

			' IdBusinessDetail
			VIEW_Paid_Orders.IdBusinessDetail.ViewValue = VIEW_Paid_Orders.IdBusinessDetail.CurrentValue
			VIEW_Paid_Orders.IdBusinessDetail.ViewCustomAttributes = ""

			' SessionId
			VIEW_Paid_Orders.SessionId.ViewValue = VIEW_Paid_Orders.SessionId.CurrentValue
			VIEW_Paid_Orders.SessionId.ViewCustomAttributes = ""

			' FirstName
			VIEW_Paid_Orders.FirstName.ViewValue = VIEW_Paid_Orders.FirstName.CurrentValue
			VIEW_Paid_Orders.FirstName.ViewCustomAttributes = ""

			' LastName
			VIEW_Paid_Orders.LastName.ViewValue = VIEW_Paid_Orders.LastName.CurrentValue
			VIEW_Paid_Orders.LastName.ViewCustomAttributes = ""

			' Email
			VIEW_Paid_Orders.zEmail.ViewValue = VIEW_Paid_Orders.zEmail.CurrentValue
			VIEW_Paid_Orders.zEmail.ViewCustomAttributes = ""

			' Phone
			VIEW_Paid_Orders.Phone.ViewValue = VIEW_Paid_Orders.Phone.CurrentValue
			VIEW_Paid_Orders.Phone.ViewCustomAttributes = ""

			' Address
			VIEW_Paid_Orders.Address.ViewValue = VIEW_Paid_Orders.Address.CurrentValue
			VIEW_Paid_Orders.Address.ViewCustomAttributes = ""

			' PostalCode
			VIEW_Paid_Orders.PostalCode.ViewValue = VIEW_Paid_Orders.PostalCode.CurrentValue
			VIEW_Paid_Orders.PostalCode.ViewCustomAttributes = ""

			' ttest
			VIEW_Paid_Orders.ttest.ViewValue = VIEW_Paid_Orders.ttest.CurrentValue
			VIEW_Paid_Orders.ttest.ViewCustomAttributes = ""

			' cancelleddate
			VIEW_Paid_Orders.cancelleddate.ViewValue = VIEW_Paid_Orders.cancelleddate.CurrentValue
			VIEW_Paid_Orders.cancelleddate.ViewCustomAttributes = ""

			' cancelledby
			VIEW_Paid_Orders.cancelledby.ViewValue = VIEW_Paid_Orders.cancelledby.CurrentValue
			VIEW_Paid_Orders.cancelledby.ViewCustomAttributes = ""

			' cancelledreason
			VIEW_Paid_Orders.cancelledreason.ViewValue = VIEW_Paid_Orders.cancelledreason.CurrentValue
			VIEW_Paid_Orders.cancelledreason.ViewCustomAttributes = ""

			' acknowledgeddate
			VIEW_Paid_Orders.acknowledgeddate.ViewValue = VIEW_Paid_Orders.acknowledgeddate.CurrentValue
			VIEW_Paid_Orders.acknowledgeddate.ViewCustomAttributes = ""

			' delivereddate
			VIEW_Paid_Orders.delivereddate.ViewValue = VIEW_Paid_Orders.delivereddate.CurrentValue
			VIEW_Paid_Orders.delivereddate.ViewCustomAttributes = ""

			' cancelled
			VIEW_Paid_Orders.cancelled.ViewValue = VIEW_Paid_Orders.cancelled.CurrentValue
			VIEW_Paid_Orders.cancelled.ViewCustomAttributes = ""

			' acknowledged
			VIEW_Paid_Orders.acknowledged.ViewValue = VIEW_Paid_Orders.acknowledged.CurrentValue
			VIEW_Paid_Orders.acknowledged.ViewCustomAttributes = ""

			' outfordelivery
			VIEW_Paid_Orders.outfordelivery.ViewValue = VIEW_Paid_Orders.outfordelivery.CurrentValue
			VIEW_Paid_Orders.outfordelivery.ViewCustomAttributes = ""

			' vouchercodediscount
			VIEW_Paid_Orders.vouchercodediscount.ViewValue = VIEW_Paid_Orders.vouchercodediscount.CurrentValue
			VIEW_Paid_Orders.vouchercodediscount.ViewCustomAttributes = ""

			' vouchercode
			VIEW_Paid_Orders.vouchercode.ViewValue = VIEW_Paid_Orders.vouchercode.CurrentValue
			VIEW_Paid_Orders.vouchercode.ViewCustomAttributes = ""

			' printed
			VIEW_Paid_Orders.printed.ViewValue = VIEW_Paid_Orders.printed.CurrentValue
			VIEW_Paid_Orders.printed.ViewCustomAttributes = ""

			' deliverydistance
			VIEW_Paid_Orders.deliverydistance.ViewValue = VIEW_Paid_Orders.deliverydistance.CurrentValue
			VIEW_Paid_Orders.deliverydistance.ViewCustomAttributes = ""

			' asaporder
			VIEW_Paid_Orders.asaporder.ViewValue = VIEW_Paid_Orders.asaporder.CurrentValue
			VIEW_Paid_Orders.asaporder.ViewCustomAttributes = ""

			' DeliveryLat
			VIEW_Paid_Orders.DeliveryLat.ViewValue = VIEW_Paid_Orders.DeliveryLat.CurrentValue
			VIEW_Paid_Orders.DeliveryLat.ViewCustomAttributes = ""

			' DeliveryLng
			VIEW_Paid_Orders.DeliveryLng.ViewValue = VIEW_Paid_Orders.DeliveryLng.CurrentValue
			VIEW_Paid_Orders.DeliveryLng.ViewCustomAttributes = ""

			' ServiceCharge
			VIEW_Paid_Orders.ServiceCharge.ViewValue = VIEW_Paid_Orders.ServiceCharge.CurrentValue
			VIEW_Paid_Orders.ServiceCharge.ViewCustomAttributes = ""

			' PaymentSurcharge
			VIEW_Paid_Orders.PaymentSurcharge.ViewValue = VIEW_Paid_Orders.PaymentSurcharge.CurrentValue
			VIEW_Paid_Orders.PaymentSurcharge.ViewCustomAttributes = ""

			' FromIP
			VIEW_Paid_Orders.FromIP.ViewValue = VIEW_Paid_Orders.FromIP.CurrentValue
			VIEW_Paid_Orders.FromIP.ViewCustomAttributes = ""

			' Tax_Rate
			VIEW_Paid_Orders.Tax_Rate.ViewValue = VIEW_Paid_Orders.Tax_Rate.CurrentValue
			VIEW_Paid_Orders.Tax_Rate.ViewCustomAttributes = ""

			' Tax_Amount
			VIEW_Paid_Orders.Tax_Amount.ViewValue = VIEW_Paid_Orders.Tax_Amount.CurrentValue
			VIEW_Paid_Orders.Tax_Amount.ViewCustomAttributes = ""

			' Tip_Rate
			VIEW_Paid_Orders.Tip_Rate.ViewValue = VIEW_Paid_Orders.Tip_Rate.CurrentValue
			VIEW_Paid_Orders.Tip_Rate.ViewCustomAttributes = ""

			' Tip_Amount
			VIEW_Paid_Orders.Tip_Amount.ViewValue = VIEW_Paid_Orders.Tip_Amount.CurrentValue
			VIEW_Paid_Orders.Tip_Amount.ViewCustomAttributes = ""

			' Card_Debit
			VIEW_Paid_Orders.Card_Debit.ViewValue = VIEW_Paid_Orders.Card_Debit.CurrentValue
			VIEW_Paid_Orders.Card_Debit.ViewCustomAttributes = ""

			' Card_Credit
			VIEW_Paid_Orders.Card_Credit.ViewValue = VIEW_Paid_Orders.Card_Credit.CurrentValue
			VIEW_Paid_Orders.Card_Credit.ViewCustomAttributes = ""

			' SentEmail
			VIEW_Paid_Orders.SentEmail.ViewValue = VIEW_Paid_Orders.SentEmail.CurrentValue
			VIEW_Paid_Orders.SentEmail.ViewCustomAttributes = ""

			' deliverydelay
			VIEW_Paid_Orders.deliverydelay.ViewValue = VIEW_Paid_Orders.deliverydelay.CurrentValue
			VIEW_Paid_Orders.deliverydelay.ViewCustomAttributes = ""

			' collectiondelay
			VIEW_Paid_Orders.collectiondelay.ViewValue = VIEW_Paid_Orders.collectiondelay.CurrentValue
			VIEW_Paid_Orders.collectiondelay.ViewCustomAttributes = ""

			' lng_report
			VIEW_Paid_Orders.lng_report.ViewValue = VIEW_Paid_Orders.lng_report.CurrentValue
			VIEW_Paid_Orders.lng_report.ViewCustomAttributes = ""

			' lat_report
			VIEW_Paid_Orders.lat_report.ViewValue = VIEW_Paid_Orders.lat_report.CurrentValue
			VIEW_Paid_Orders.lat_report.ViewCustomAttributes = ""

			' Payment_status
			VIEW_Paid_Orders.Payment_status.ViewValue = VIEW_Paid_Orders.Payment_status.CurrentValue
			VIEW_Paid_Orders.Payment_status.ViewCustomAttributes = ""

			' View refer script
			' ID

			VIEW_Paid_Orders.ID.LinkCustomAttributes = ""
			VIEW_Paid_Orders.ID.HrefValue = ""
			VIEW_Paid_Orders.ID.TooltipValue = ""

			' CreationDate
			VIEW_Paid_Orders.CreationDate.LinkCustomAttributes = ""
			VIEW_Paid_Orders.CreationDate.HrefValue = ""
			VIEW_Paid_Orders.CreationDate.TooltipValue = ""

			' OrderDate
			VIEW_Paid_Orders.OrderDate.LinkCustomAttributes = ""
			VIEW_Paid_Orders.OrderDate.HrefValue = ""
			VIEW_Paid_Orders.OrderDate.TooltipValue = ""

			' DeliveryType
			VIEW_Paid_Orders.DeliveryType.LinkCustomAttributes = ""
			VIEW_Paid_Orders.DeliveryType.HrefValue = ""
			VIEW_Paid_Orders.DeliveryType.TooltipValue = ""

			' DeliveryTime
			VIEW_Paid_Orders.DeliveryTime.LinkCustomAttributes = ""
			VIEW_Paid_Orders.DeliveryTime.HrefValue = ""
			VIEW_Paid_Orders.DeliveryTime.TooltipValue = ""

			' PaymentType
			VIEW_Paid_Orders.PaymentType.LinkCustomAttributes = ""
			VIEW_Paid_Orders.PaymentType.HrefValue = ""
			VIEW_Paid_Orders.PaymentType.TooltipValue = ""

			' SubTotal
			VIEW_Paid_Orders.SubTotal.LinkCustomAttributes = ""
			VIEW_Paid_Orders.SubTotal.HrefValue = ""
			VIEW_Paid_Orders.SubTotal.TooltipValue = ""

			' ShippingFee
			VIEW_Paid_Orders.ShippingFee.LinkCustomAttributes = ""
			VIEW_Paid_Orders.ShippingFee.HrefValue = ""
			VIEW_Paid_Orders.ShippingFee.TooltipValue = ""

			' OrderTotal
			VIEW_Paid_Orders.OrderTotal.LinkCustomAttributes = ""
			VIEW_Paid_Orders.OrderTotal.HrefValue = ""
			VIEW_Paid_Orders.OrderTotal.TooltipValue = ""

			' IdBusinessDetail
			VIEW_Paid_Orders.IdBusinessDetail.LinkCustomAttributes = ""
			VIEW_Paid_Orders.IdBusinessDetail.HrefValue = ""
			VIEW_Paid_Orders.IdBusinessDetail.TooltipValue = ""

			' SessionId
			VIEW_Paid_Orders.SessionId.LinkCustomAttributes = ""
			VIEW_Paid_Orders.SessionId.HrefValue = ""
			VIEW_Paid_Orders.SessionId.TooltipValue = ""

			' FirstName
			VIEW_Paid_Orders.FirstName.LinkCustomAttributes = ""
			VIEW_Paid_Orders.FirstName.HrefValue = ""
			VIEW_Paid_Orders.FirstName.TooltipValue = ""

			' LastName
			VIEW_Paid_Orders.LastName.LinkCustomAttributes = ""
			VIEW_Paid_Orders.LastName.HrefValue = ""
			VIEW_Paid_Orders.LastName.TooltipValue = ""

			' Email
			VIEW_Paid_Orders.zEmail.LinkCustomAttributes = ""
			VIEW_Paid_Orders.zEmail.HrefValue = ""
			VIEW_Paid_Orders.zEmail.TooltipValue = ""

			' Phone
			VIEW_Paid_Orders.Phone.LinkCustomAttributes = ""
			VIEW_Paid_Orders.Phone.HrefValue = ""
			VIEW_Paid_Orders.Phone.TooltipValue = ""

			' Address
			VIEW_Paid_Orders.Address.LinkCustomAttributes = ""
			VIEW_Paid_Orders.Address.HrefValue = ""
			VIEW_Paid_Orders.Address.TooltipValue = ""

			' PostalCode
			VIEW_Paid_Orders.PostalCode.LinkCustomAttributes = ""
			VIEW_Paid_Orders.PostalCode.HrefValue = ""
			VIEW_Paid_Orders.PostalCode.TooltipValue = ""

			' ttest
			VIEW_Paid_Orders.ttest.LinkCustomAttributes = ""
			VIEW_Paid_Orders.ttest.HrefValue = ""
			VIEW_Paid_Orders.ttest.TooltipValue = ""

			' cancelleddate
			VIEW_Paid_Orders.cancelleddate.LinkCustomAttributes = ""
			VIEW_Paid_Orders.cancelleddate.HrefValue = ""
			VIEW_Paid_Orders.cancelleddate.TooltipValue = ""

			' cancelledby
			VIEW_Paid_Orders.cancelledby.LinkCustomAttributes = ""
			VIEW_Paid_Orders.cancelledby.HrefValue = ""
			VIEW_Paid_Orders.cancelledby.TooltipValue = ""

			' cancelledreason
			VIEW_Paid_Orders.cancelledreason.LinkCustomAttributes = ""
			VIEW_Paid_Orders.cancelledreason.HrefValue = ""
			VIEW_Paid_Orders.cancelledreason.TooltipValue = ""

			' acknowledgeddate
			VIEW_Paid_Orders.acknowledgeddate.LinkCustomAttributes = ""
			VIEW_Paid_Orders.acknowledgeddate.HrefValue = ""
			VIEW_Paid_Orders.acknowledgeddate.TooltipValue = ""

			' delivereddate
			VIEW_Paid_Orders.delivereddate.LinkCustomAttributes = ""
			VIEW_Paid_Orders.delivereddate.HrefValue = ""
			VIEW_Paid_Orders.delivereddate.TooltipValue = ""

			' cancelled
			VIEW_Paid_Orders.cancelled.LinkCustomAttributes = ""
			VIEW_Paid_Orders.cancelled.HrefValue = ""
			VIEW_Paid_Orders.cancelled.TooltipValue = ""

			' acknowledged
			VIEW_Paid_Orders.acknowledged.LinkCustomAttributes = ""
			VIEW_Paid_Orders.acknowledged.HrefValue = ""
			VIEW_Paid_Orders.acknowledged.TooltipValue = ""

			' outfordelivery
			VIEW_Paid_Orders.outfordelivery.LinkCustomAttributes = ""
			VIEW_Paid_Orders.outfordelivery.HrefValue = ""
			VIEW_Paid_Orders.outfordelivery.TooltipValue = ""

			' vouchercodediscount
			VIEW_Paid_Orders.vouchercodediscount.LinkCustomAttributes = ""
			VIEW_Paid_Orders.vouchercodediscount.HrefValue = ""
			VIEW_Paid_Orders.vouchercodediscount.TooltipValue = ""

			' vouchercode
			VIEW_Paid_Orders.vouchercode.LinkCustomAttributes = ""
			VIEW_Paid_Orders.vouchercode.HrefValue = ""
			VIEW_Paid_Orders.vouchercode.TooltipValue = ""

			' printed
			VIEW_Paid_Orders.printed.LinkCustomAttributes = ""
			VIEW_Paid_Orders.printed.HrefValue = ""
			VIEW_Paid_Orders.printed.TooltipValue = ""

			' deliverydistance
			VIEW_Paid_Orders.deliverydistance.LinkCustomAttributes = ""
			VIEW_Paid_Orders.deliverydistance.HrefValue = ""
			VIEW_Paid_Orders.deliverydistance.TooltipValue = ""

			' asaporder
			VIEW_Paid_Orders.asaporder.LinkCustomAttributes = ""
			VIEW_Paid_Orders.asaporder.HrefValue = ""
			VIEW_Paid_Orders.asaporder.TooltipValue = ""

			' DeliveryLat
			VIEW_Paid_Orders.DeliveryLat.LinkCustomAttributes = ""
			VIEW_Paid_Orders.DeliveryLat.HrefValue = ""
			VIEW_Paid_Orders.DeliveryLat.TooltipValue = ""

			' DeliveryLng
			VIEW_Paid_Orders.DeliveryLng.LinkCustomAttributes = ""
			VIEW_Paid_Orders.DeliveryLng.HrefValue = ""
			VIEW_Paid_Orders.DeliveryLng.TooltipValue = ""

			' ServiceCharge
			VIEW_Paid_Orders.ServiceCharge.LinkCustomAttributes = ""
			VIEW_Paid_Orders.ServiceCharge.HrefValue = ""
			VIEW_Paid_Orders.ServiceCharge.TooltipValue = ""

			' PaymentSurcharge
			VIEW_Paid_Orders.PaymentSurcharge.LinkCustomAttributes = ""
			VIEW_Paid_Orders.PaymentSurcharge.HrefValue = ""
			VIEW_Paid_Orders.PaymentSurcharge.TooltipValue = ""

			' FromIP
			VIEW_Paid_Orders.FromIP.LinkCustomAttributes = ""
			VIEW_Paid_Orders.FromIP.HrefValue = ""
			VIEW_Paid_Orders.FromIP.TooltipValue = ""

			' Tax_Rate
			VIEW_Paid_Orders.Tax_Rate.LinkCustomAttributes = ""
			VIEW_Paid_Orders.Tax_Rate.HrefValue = ""
			VIEW_Paid_Orders.Tax_Rate.TooltipValue = ""

			' Tax_Amount
			VIEW_Paid_Orders.Tax_Amount.LinkCustomAttributes = ""
			VIEW_Paid_Orders.Tax_Amount.HrefValue = ""
			VIEW_Paid_Orders.Tax_Amount.TooltipValue = ""

			' Tip_Rate
			VIEW_Paid_Orders.Tip_Rate.LinkCustomAttributes = ""
			VIEW_Paid_Orders.Tip_Rate.HrefValue = ""
			VIEW_Paid_Orders.Tip_Rate.TooltipValue = ""

			' Tip_Amount
			VIEW_Paid_Orders.Tip_Amount.LinkCustomAttributes = ""
			VIEW_Paid_Orders.Tip_Amount.HrefValue = ""
			VIEW_Paid_Orders.Tip_Amount.TooltipValue = ""

			' Card_Debit
			VIEW_Paid_Orders.Card_Debit.LinkCustomAttributes = ""
			VIEW_Paid_Orders.Card_Debit.HrefValue = ""
			VIEW_Paid_Orders.Card_Debit.TooltipValue = ""

			' Card_Credit
			VIEW_Paid_Orders.Card_Credit.LinkCustomAttributes = ""
			VIEW_Paid_Orders.Card_Credit.HrefValue = ""
			VIEW_Paid_Orders.Card_Credit.TooltipValue = ""

			' SentEmail
			VIEW_Paid_Orders.SentEmail.LinkCustomAttributes = ""
			VIEW_Paid_Orders.SentEmail.HrefValue = ""
			VIEW_Paid_Orders.SentEmail.TooltipValue = ""

			' deliverydelay
			VIEW_Paid_Orders.deliverydelay.LinkCustomAttributes = ""
			VIEW_Paid_Orders.deliverydelay.HrefValue = ""
			VIEW_Paid_Orders.deliverydelay.TooltipValue = ""

			' collectiondelay
			VIEW_Paid_Orders.collectiondelay.LinkCustomAttributes = ""
			VIEW_Paid_Orders.collectiondelay.HrefValue = ""
			VIEW_Paid_Orders.collectiondelay.TooltipValue = ""

			' lng_report
			VIEW_Paid_Orders.lng_report.LinkCustomAttributes = ""
			VIEW_Paid_Orders.lng_report.HrefValue = ""
			VIEW_Paid_Orders.lng_report.TooltipValue = ""

			' lat_report
			VIEW_Paid_Orders.lat_report.LinkCustomAttributes = ""
			VIEW_Paid_Orders.lat_report.HrefValue = ""
			VIEW_Paid_Orders.lat_report.TooltipValue = ""

			' Payment_status
			VIEW_Paid_Orders.Payment_status.LinkCustomAttributes = ""
			VIEW_Paid_Orders.Payment_status.HrefValue = ""
			VIEW_Paid_Orders.Payment_status.TooltipValue = ""
		End If

		' Call Row Rendered event
		If VIEW_Paid_Orders.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call VIEW_Paid_Orders.Row_Rendered()
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
			item.Body = "<a href=""javascript:void(0);"" class=""ewExportLink ewPdf"" title=""" & ew_HtmlEncode(Language.Phrase("ExportToPDFText")) & """ data-caption=""" & ew_HtmlEncode(Language.Phrase("ExportToPDFText")) & """ onclick=""ew_Export(document.fVIEW_Paid_Orderslist,'" & ExportPdfUrl & "','pdf',true);"">" & Language.Phrase("ExportToPDF") & "</a>"
		Else
			item.Body = "<a href=""" & ExportPdfUrl & """ class=""ewExportLink ewPdf"" title=""" & ew_HtmlEncode(Language.Phrase("ExportToPDFText")) & """ data-caption=""" & ew_HtmlEncode(Language.Phrase("ExportToPDFText")) & """>" & Language.Phrase("ExportToPDF") & "</a>"
		End If
		item.Visible = False

		' Export to Email
		ExportOptions.Add("email")
		Set item = ExportOptions.GetItem("email")
		url = ew_IIf(ExportEmailCustom, ",url:'" & PageUrl & "export=email&amp;custom=1'", "")
		item.Body = "<button id=""emf_VIEW_Paid_Orders"" class=""ewExportLink ewEmail"" title=""" & Language.Phrase("ExportToEmailText") & """ data-caption=""" & Language.Phrase("ExportToEmailText") & """ onclick=""ew_EmailDialogShow({lnk:'emf_VIEW_Paid_Orders',hdr:ewLanguage.Phrase('ExportToEmailText'),f:document.fVIEW_Paid_Orderslist,sel:false" & url & "});"">" & Language.Phrase("ExportToEmail") & "</button>"
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
		If VIEW_Paid_Orders.ExportAll Then
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
		If VIEW_Paid_Orders.Export = "xml" Then
			Set XmlDoc = New cXMLDocument
		Else
			Set VIEW_Paid_Orders.ExportDoc = New cExportDocument
			Set Doc = VIEW_Paid_Orders.ExportDoc
			Set Doc.Table = VIEW_Paid_Orders
			Call Doc.ChangeStyle("h")

			' Call Page Exporting server event
			Doc.ExportCustom = (Not Page_Exporting())
		End If
		Dim rsdetail, detailcnt
		Dim ParentTable
		ParentTable = ""
		If VIEW_Paid_Orders.Export = "xml" Then
			Call VIEW_Paid_Orders.ExportXmlDocument(XmlDoc, (ParentTable <> ""), rs, StartRec, StopRec, "")
		Else
			Dim sHeader
			sHeader = PageHeader
			Call Page_DataRendering(sHeader)
			Doc.Text = Doc.Text & sHeader
			Call VIEW_Paid_Orders.ExportDocument(Doc, rs, StartRec, StopRec, "")
			Dim sFooter
			sFooter = PageFooter
			Call Page_DataRendered(sFooter)
			Doc.Text = Doc.Text & sFooter
		End If

		' Close recordset and connection
		Rs.Close
		Set Rs = Nothing

		' Export header and footer
		If VIEW_Paid_Orders.Export <> "xml" Then
			Call Doc.ExportHeaderAndFooter()

			' Call Page Exported server event
			Call Page_Exported()
		End If
		If VIEW_Paid_Orders.Export = "xml" Then
			XmlDoc.Output
			Set XmlDoc = Nothing
		Else
			If VIEW_Paid_Orders.Export = "email" Then
				Response.Write ExportEmail(Doc.Text)
			ElseIf VIEW_Paid_Orders.Export = "pdf" Then
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
		Call Breadcrumb.Add("list", VIEW_Paid_Orders.TableVar, url, "", VIEW_Paid_Orders.TableVar, True)
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
