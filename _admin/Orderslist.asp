<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="Ordersinfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim Orders_list
Set Orders_list = New cOrders_list
Set Page = Orders_list

' Page init processing
Orders_list.Page_Init()

' Page main processing
Orders_list.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
Orders_list.Page_Render()
%>
<!--#include file="header.asp"-->
<% If Orders.Export = "" Then %>
<script type="text/javascript">
// Page object
var Orders_list = new ew_Page("Orders_list");
Orders_list.PageID = "list"; // Page ID
var EW_PAGE_ID = Orders_list.PageID; // For backward compatibility
// Form object
var fOrderslist = new ew_Form("fOrderslist");
fOrderslist.FormKeyCountName = '<%= Orders_list.FormKeyCountName %>';
// Form_CustomValidate event
fOrderslist.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fOrderslist.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fOrderslist.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
var fOrderslistsrch = new ew_Form("fOrderslistsrch");
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
<% If Orders.Export = "" Then %>
<div class="ewToolbar">
<% If Orders.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If Orders_list.TotalRecs > 0 And Orders_list.ExportOptions.Visible Then %>
<% Orders_list.ExportOptions.Render "body", "", "", "", "", "" %>
<% End If %>
<% If Orders_list.SearchOptions.Visible Then %>
<% Orders_list.SearchOptions.Render "body", "", "", "", "", "" %>
<% End If %>
<% If Orders.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% End If %>
<% If (Orders.Export = "") Or (EW_EXPORT_MASTER_RECORD And Orders.Export = "print") Then %>
<% End If %>
<%

' Load recordset
'Set Orders_list.Recordset = Orders_list.LoadRecordset()

	Orders_list.TotalRecs = Orders_list.Recordset.RecordCount
	Orders_list.StartRec = 1
	If Orders_list.DisplayRecs <= 0 Then ' Display all records
		Orders_list.DisplayRecs = Orders_list.TotalRecs
	End If
	If Not (Orders.ExportAll And Orders.Export <> "") Then
		Orders_list.SetUpStartRec() ' Set up start record position
	End If

	' Set no record found message
	If Orders.CurrentAction = "" And Orders_list.TotalRecs = 0 Then
		If Orders_list.SearchWhere = "0=101" Then
			Orders_list.WarningMessage = Language.Phrase("EnterSearchCriteria")
		Else
			Orders_list.WarningMessage = Language.Phrase("NoRecord")
		End If
	End If
Orders_list.RenderOtherOptions()
%>
<% If Orders.Export = "" And Orders.CurrentAction = "" Then %>
<form name="fOrderslistsrch" id="fOrderslistsrch" class="form-inline ewForm" action="<%= ew_CurrentPage %>">
<% SearchPanelClass = ew_IIf(Orders_list.SearchWhere <> "", " in", " in") %>
<div id="fOrderslistsrch_SearchPanel" class="ewSearchPanel collapse<%= SearchPanelClass %>">
<input type="hidden" name="cmd" value="search">
<input type="hidden" name="t" value="Orders">
	<div class="ewBasicSearch">
<div id="xsr_1" class="ewRow">
	<div class="ewQuickSearch input-group">
	<input type="text" name="<%= EW_TABLE_BASIC_SEARCH %>" id="<%= EW_TABLE_BASIC_SEARCH %>" class="form-control" value="<%= ew_HtmlEncode(Orders.BasicSearch.getKeyword()) %>" placeholder="<%= ew_HtmlEncode(Language.Phrase("Search")) %>">
	<input type="hidden" name="<%= EW_TABLE_BASIC_SEARCH_TYPE %>" id="<%= EW_TABLE_BASIC_SEARCH_TYPE %>" value="<%= ew_HtmlEncode(Orders.BasicSearch.getSearchType()) %>">
	<div class="input-group-btn">
		<button type="button" data-toggle="dropdown" class="btn btn-default"><span id="searchtype"><%= Orders.BasicSearch.getSearchTypeNameShort() %></span><span class="caret"></span></button>
		<ul class="dropdown-menu pull-right" role="menu">
			<li<% If Orders.BasicSearch.getSearchType() = "" Then Response.Write " class=""active""" %>><a href="javascript:void(0);" onclick="ew_SetSearchType(this)"><%= Language.Phrase("QuickSearchAuto") %></a></li>
			<li<% If Orders.BasicSearch.getSearchType() = "=" Then Response.Write " class=""active""" %>><a href="javascript:void(0);" onclick="ew_SetSearchType(this,'=')"><%= Language.Phrase("QuickSearchExact") %></a></li>
			<li<% If Orders.BasicSearch.getSearchType() = "AND" Then Response.Write " class=""active""" %>><a href="javascript:void(0);" onclick="ew_SetSearchType(this,'AND')"><%= Language.Phrase("QuickSearchAll") %></a></li>
			<li<% If Orders.BasicSearch.getSearchType() = "OR" Then Response.Write " class=""active""" %>><a href="javascript:void(0);" onclick="ew_SetSearchType(this,'OR')"><%= Language.Phrase("QuickSearchAny") %></a></li>
		</ul>
	<button class="btn btn-primary ewButton" name="btnsubmit" id="btnsubmit" type="submit"><%= Language.Phrase("QuickSearchBtn") %></button>
	</div>
	</div>
</div>
	</div>
</div>
</form>
<% End If %>
<% Orders_list.ShowPageHeader() %>
<% Orders_list.ShowMessage %>
<% If Orders_list.TotalRecs > 0 Or Orders.CurrentAction <> "" Then %>
<div class="ewGrid">
<% If Orders.Export = "" Then %>
<div class="ewGridUpperPanel">
<% If Orders.CurrentAction <> "gridadd" And Orders.CurrentAction <> "gridedit" Then %>
<form name="ewPagerForm" class="form-inline ewForm ewPagerForm" action="<%= ew_CurrentPage %>">
<% If Not IsObject(Orders_list.Pager) Then Set Orders_list.Pager = ew_NewPrevNextPager(Orders_list.StartRec, Orders_list.DisplayRecs, Orders_list.TotalRecs) %>
<% If Orders_list.Pager.RecordCount > 0 Then %>
<div class="ewPager">
<span><%= Language.Phrase("Page") %>&nbsp;</span>
<div class="ewPrevNext"><div class="input-group">
<div class="input-group-btn">
<!--first page button-->
	<% If Orders_list.Pager.FirstButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerFirst") %>" href="<%= Orders_list.PageUrl %>start=<%= Orders_list.Pager.FirstButton.Start %>"><span class="icon-first ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerFirst") %>"><span class="icon-first ewIcon"></span></a>
	<% End If %>
<!--previous page button-->
	<% If Orders_list.Pager.PrevButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerPrevious") %>" href="<%= Orders_list.PageUrl %>start=<%= Orders_list.Pager.PrevButton.Start %>"><span class="icon-prev ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerPrevious") %>"><span class="icon-prev ewIcon"></span></a>
	<% End If %>
</div>
<!--current page number-->
	<input class="form-control input-sm" type="text" name="<%= EW_TABLE_PAGE_NO %>" value="<%= Orders_list.Pager.CurrentPage %>">
<div class="input-group-btn">
<!--next page button-->
	<% If Orders_list.Pager.NextButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerNext") %>" href="<%= Orders_list.PageUrl %>start=<%= Orders_list.Pager.NextButton.Start %>"><span class="icon-next ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerNext") %>"><span class="icon-next ewIcon"></span></a>
	<% End If %>
<!--last page button-->
	<% If Orders_list.Pager.LastButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerLast") %>" href="<%= Orders_list.PageUrl %>start=<%= Orders_list.Pager.LastButton.Start %>"><span class="icon-last ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerLast") %>"><span class="icon-last ewIcon"></span></a>
	<% End If %>
</div>
</div>
</div>
<span>&nbsp;<%= Language.Phrase("of") %>&nbsp;<%= Orders_list.Pager.PageCount %></span>
</div>
<div class="ewPager ewRec">
	<span><%= Language.Phrase("Record") %>&nbsp;<%= Orders_list.Pager.FromIndex %>&nbsp;<%= Language.Phrase("To") %>&nbsp;<%= Orders_list.Pager.ToIndex %>&nbsp;<%= Language.Phrase("Of") %>&nbsp;<%= Orders_list.Pager.RecordCount %></span>
</div>
<% End If %>
<% If Orders_list.TotalRecs > 0 Then %>
<div class="ewPager">
<input type="hidden" name="t" value="Orders">
<select name="<%= EW_TABLE_REC_PER_PAGE %>" class="form-control input-sm" onchange="this.form.submit();">
<option value="20"<% If Orders_list.DisplayRecs = 20 Then %> selected="selected"<% End If %>>20</option>
<option value="50"<% If Orders_list.DisplayRecs = 50 Then %> selected="selected"<% End If %>>50</option>
<option value="100"<% If Orders_list.DisplayRecs = 100 Then %> selected="selected"<% End If %>>100</option>
<option value="500"<% If Orders_list.DisplayRecs = 500 Then %> selected="selected"<% End If %>>500</option>
<option value="1000"<% If Orders_list.DisplayRecs = 1000 Then %> selected="selected"<% End If %>>1000</option>
<option value="ALL"<% If Orders.RecordsPerPage = -1 Then %> selected="selected"<% End If %>><%= Language.Phrase("AllRecords") %></option>
</select>
</div>
<% End If %>
</form>
<% End If %>
<div class="ewListOtherOptions">
<%
	Orders_list.AddEditOptions.Render "body", "", "", "", "", ""
	Orders_list.DetailOptions.Render "body", "", "", "", "", ""
	Orders_list.ActionOptions.Render "body", "", "", "", "", ""
%>
</div>
<div class="clearfix"></div>
</div>
<% End If %>
<form name="fOrderslist" id="fOrderslist" class="form-inline ewForm ewListForm" action="<%= ew_CurrentPage %>" method="post">
<% If Orders_list.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= Orders_list.Token %>">
<% End If %>
<input type="hidden" name="t" value="Orders">
<div id="gmp_Orders" class="<% If ew_IsResponsiveLayout() Then Response.Write "table-responsive " %>ewGridMiddlePanel">
<% If Orders_list.TotalRecs > 0 Then %>
<table id="tbl_Orderslist" class="table ewTable">
<%= Orders.TableCustomInnerHtml %>
<thead><!-- Table header -->
	<tr class="ewTableHeader">
<%

' Header row
Orders.RowType = EW_ROWTYPE_HEADER
Call Orders_list.RenderListOptions()

' Render list options (header, left)
Orders_list.ListOptions.Render "header", "left", "", "", "", ""
%>
<% If Orders.ID.Visible Then ' ID %>
	<% If Orders.SortUrl(Orders.ID) = "" Then %>
		<th data-name="ID"><div id="elh_Orders_ID" class="Orders_ID"><div class="ewTableHeaderCaption"><%= Orders.ID.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="ID"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.ID) %>',1);"><div id="elh_Orders_ID" class="Orders_ID">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.ID.FldCaption %></span><span class="ewTableHeaderSort"><% If Orders.ID.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.ID.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.CreationDate.Visible Then ' CreationDate %>
	<% If Orders.SortUrl(Orders.CreationDate) = "" Then %>
		<th data-name="CreationDate"><div id="elh_Orders_CreationDate" class="Orders_CreationDate"><div class="ewTableHeaderCaption"><%= Orders.CreationDate.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="CreationDate"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.CreationDate) %>',1);"><div id="elh_Orders_CreationDate" class="Orders_CreationDate">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.CreationDate.FldCaption %></span><span class="ewTableHeaderSort"><% If Orders.CreationDate.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.CreationDate.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.OrderDate.Visible Then ' OrderDate %>
	<% If Orders.SortUrl(Orders.OrderDate) = "" Then %>
		<th data-name="OrderDate"><div id="elh_Orders_OrderDate" class="Orders_OrderDate"><div class="ewTableHeaderCaption"><%= Orders.OrderDate.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="OrderDate"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.OrderDate) %>',1);"><div id="elh_Orders_OrderDate" class="Orders_OrderDate">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.OrderDate.FldCaption %></span><span class="ewTableHeaderSort"><% If Orders.OrderDate.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.OrderDate.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.DeliveryType.Visible Then ' DeliveryType %>
	<% If Orders.SortUrl(Orders.DeliveryType) = "" Then %>
		<th data-name="DeliveryType"><div id="elh_Orders_DeliveryType" class="Orders_DeliveryType"><div class="ewTableHeaderCaption"><%= Orders.DeliveryType.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="DeliveryType"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.DeliveryType) %>',1);"><div id="elh_Orders_DeliveryType" class="Orders_DeliveryType">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.DeliveryType.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If Orders.DeliveryType.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.DeliveryType.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.DeliveryTime.Visible Then ' DeliveryTime %>
	<% If Orders.SortUrl(Orders.DeliveryTime) = "" Then %>
		<th data-name="DeliveryTime"><div id="elh_Orders_DeliveryTime" class="Orders_DeliveryTime"><div class="ewTableHeaderCaption"><%= Orders.DeliveryTime.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="DeliveryTime"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.DeliveryTime) %>',1);"><div id="elh_Orders_DeliveryTime" class="Orders_DeliveryTime">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.DeliveryTime.FldCaption %></span><span class="ewTableHeaderSort"><% If Orders.DeliveryTime.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.DeliveryTime.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.PaymentType.Visible Then ' PaymentType %>
	<% If Orders.SortUrl(Orders.PaymentType) = "" Then %>
		<th data-name="PaymentType"><div id="elh_Orders_PaymentType" class="Orders_PaymentType"><div class="ewTableHeaderCaption"><%= Orders.PaymentType.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="PaymentType"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.PaymentType) %>',1);"><div id="elh_Orders_PaymentType" class="Orders_PaymentType">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.PaymentType.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If Orders.PaymentType.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.PaymentType.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.SubTotal.Visible Then ' SubTotal %>
	<% If Orders.SortUrl(Orders.SubTotal) = "" Then %>
		<th data-name="SubTotal"><div id="elh_Orders_SubTotal" class="Orders_SubTotal"><div class="ewTableHeaderCaption"><%= Orders.SubTotal.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="SubTotal"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.SubTotal) %>',1);"><div id="elh_Orders_SubTotal" class="Orders_SubTotal">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.SubTotal.FldCaption %></span><span class="ewTableHeaderSort"><% If Orders.SubTotal.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.SubTotal.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.ShippingFee.Visible Then ' ShippingFee %>
	<% If Orders.SortUrl(Orders.ShippingFee) = "" Then %>
		<th data-name="ShippingFee"><div id="elh_Orders_ShippingFee" class="Orders_ShippingFee"><div class="ewTableHeaderCaption"><%= Orders.ShippingFee.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="ShippingFee"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.ShippingFee) %>',1);"><div id="elh_Orders_ShippingFee" class="Orders_ShippingFee">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.ShippingFee.FldCaption %></span><span class="ewTableHeaderSort"><% If Orders.ShippingFee.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.ShippingFee.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.OrderTotal.Visible Then ' OrderTotal %>
	<% If Orders.SortUrl(Orders.OrderTotal) = "" Then %>
		<th data-name="OrderTotal"><div id="elh_Orders_OrderTotal" class="Orders_OrderTotal"><div class="ewTableHeaderCaption"><%= Orders.OrderTotal.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="OrderTotal"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.OrderTotal) %>',1);"><div id="elh_Orders_OrderTotal" class="Orders_OrderTotal">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.OrderTotal.FldCaption %></span><span class="ewTableHeaderSort"><% If Orders.OrderTotal.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.OrderTotal.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
	<% If Orders.SortUrl(Orders.IdBusinessDetail) = "" Then %>
		<th data-name="IdBusinessDetail"><div id="elh_Orders_IdBusinessDetail" class="Orders_IdBusinessDetail"><div class="ewTableHeaderCaption"><%= Orders.IdBusinessDetail.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="IdBusinessDetail"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.IdBusinessDetail) %>',1);"><div id="elh_Orders_IdBusinessDetail" class="Orders_IdBusinessDetail">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.IdBusinessDetail.FldCaption %></span><span class="ewTableHeaderSort"><% If Orders.IdBusinessDetail.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.IdBusinessDetail.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.SessionId.Visible Then ' SessionId %>
	<% If Orders.SortUrl(Orders.SessionId) = "" Then %>
		<th data-name="SessionId"><div id="elh_Orders_SessionId" class="Orders_SessionId"><div class="ewTableHeaderCaption"><%= Orders.SessionId.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="SessionId"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.SessionId) %>',1);"><div id="elh_Orders_SessionId" class="Orders_SessionId">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.SessionId.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If Orders.SessionId.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.SessionId.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.FirstName.Visible Then ' FirstName %>
	<% If Orders.SortUrl(Orders.FirstName) = "" Then %>
		<th data-name="FirstName"><div id="elh_Orders_FirstName" class="Orders_FirstName"><div class="ewTableHeaderCaption"><%= Orders.FirstName.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="FirstName"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.FirstName) %>',1);"><div id="elh_Orders_FirstName" class="Orders_FirstName">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.FirstName.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If Orders.FirstName.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.FirstName.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.LastName.Visible Then ' LastName %>
	<% If Orders.SortUrl(Orders.LastName) = "" Then %>
		<th data-name="LastName"><div id="elh_Orders_LastName" class="Orders_LastName"><div class="ewTableHeaderCaption"><%= Orders.LastName.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="LastName"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.LastName) %>',1);"><div id="elh_Orders_LastName" class="Orders_LastName">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.LastName.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If Orders.LastName.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.LastName.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.zEmail.Visible Then ' Email %>
	<% If Orders.SortUrl(Orders.zEmail) = "" Then %>
		<th data-name="zEmail"><div id="elh_Orders_zEmail" class="Orders_zEmail"><div class="ewTableHeaderCaption"><%= Orders.zEmail.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="zEmail"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.zEmail) %>',1);"><div id="elh_Orders_zEmail" class="Orders_zEmail">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.zEmail.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If Orders.zEmail.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.zEmail.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.Phone.Visible Then ' Phone %>
	<% If Orders.SortUrl(Orders.Phone) = "" Then %>
		<th data-name="Phone"><div id="elh_Orders_Phone" class="Orders_Phone"><div class="ewTableHeaderCaption"><%= Orders.Phone.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Phone"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.Phone) %>',1);"><div id="elh_Orders_Phone" class="Orders_Phone">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.Phone.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If Orders.Phone.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.Phone.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.Address.Visible Then ' Address %>
	<% If Orders.SortUrl(Orders.Address) = "" Then %>
		<th data-name="Address"><div id="elh_Orders_Address" class="Orders_Address"><div class="ewTableHeaderCaption"><%= Orders.Address.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Address"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.Address) %>',1);"><div id="elh_Orders_Address" class="Orders_Address">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.Address.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If Orders.Address.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.Address.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.PostalCode.Visible Then ' PostalCode %>
	<% If Orders.SortUrl(Orders.PostalCode) = "" Then %>
		<th data-name="PostalCode"><div id="elh_Orders_PostalCode" class="Orders_PostalCode"><div class="ewTableHeaderCaption"><%= Orders.PostalCode.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="PostalCode"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.PostalCode) %>',1);"><div id="elh_Orders_PostalCode" class="Orders_PostalCode">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.PostalCode.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If Orders.PostalCode.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.PostalCode.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.ttest.Visible Then ' ttest %>
	<% If Orders.SortUrl(Orders.ttest) = "" Then %>
		<th data-name="ttest"><div id="elh_Orders_ttest" class="Orders_ttest"><div class="ewTableHeaderCaption"><%= Orders.ttest.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="ttest"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.ttest) %>',1);"><div id="elh_Orders_ttest" class="Orders_ttest">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.ttest.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If Orders.ttest.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.ttest.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.cancelleddate.Visible Then ' cancelleddate %>
	<% If Orders.SortUrl(Orders.cancelleddate) = "" Then %>
		<th data-name="cancelleddate"><div id="elh_Orders_cancelleddate" class="Orders_cancelleddate"><div class="ewTableHeaderCaption"><%= Orders.cancelleddate.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="cancelleddate"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.cancelleddate) %>',1);"><div id="elh_Orders_cancelleddate" class="Orders_cancelleddate">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.cancelleddate.FldCaption %></span><span class="ewTableHeaderSort"><% If Orders.cancelleddate.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.cancelleddate.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.cancelledby.Visible Then ' cancelledby %>
	<% If Orders.SortUrl(Orders.cancelledby) = "" Then %>
		<th data-name="cancelledby"><div id="elh_Orders_cancelledby" class="Orders_cancelledby"><div class="ewTableHeaderCaption"><%= Orders.cancelledby.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="cancelledby"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.cancelledby) %>',1);"><div id="elh_Orders_cancelledby" class="Orders_cancelledby">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.cancelledby.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If Orders.cancelledby.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.cancelledby.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.cancelledreason.Visible Then ' cancelledreason %>
	<% If Orders.SortUrl(Orders.cancelledreason) = "" Then %>
		<th data-name="cancelledreason"><div id="elh_Orders_cancelledreason" class="Orders_cancelledreason"><div class="ewTableHeaderCaption"><%= Orders.cancelledreason.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="cancelledreason"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.cancelledreason) %>',1);"><div id="elh_Orders_cancelledreason" class="Orders_cancelledreason">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.cancelledreason.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If Orders.cancelledreason.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.cancelledreason.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.acknowledgeddate.Visible Then ' acknowledgeddate %>
	<% If Orders.SortUrl(Orders.acknowledgeddate) = "" Then %>
		<th data-name="acknowledgeddate"><div id="elh_Orders_acknowledgeddate" class="Orders_acknowledgeddate"><div class="ewTableHeaderCaption"><%= Orders.acknowledgeddate.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="acknowledgeddate"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.acknowledgeddate) %>',1);"><div id="elh_Orders_acknowledgeddate" class="Orders_acknowledgeddate">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.acknowledgeddate.FldCaption %></span><span class="ewTableHeaderSort"><% If Orders.acknowledgeddate.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.acknowledgeddate.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.delivereddate.Visible Then ' delivereddate %>
	<% If Orders.SortUrl(Orders.delivereddate) = "" Then %>
		<th data-name="delivereddate"><div id="elh_Orders_delivereddate" class="Orders_delivereddate"><div class="ewTableHeaderCaption"><%= Orders.delivereddate.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="delivereddate"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.delivereddate) %>',1);"><div id="elh_Orders_delivereddate" class="Orders_delivereddate">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.delivereddate.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If Orders.delivereddate.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.delivereddate.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.cancelled.Visible Then ' cancelled %>
	<% If Orders.SortUrl(Orders.cancelled) = "" Then %>
		<th data-name="cancelled"><div id="elh_Orders_cancelled" class="Orders_cancelled"><div class="ewTableHeaderCaption"><%= Orders.cancelled.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="cancelled"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.cancelled) %>',1);"><div id="elh_Orders_cancelled" class="Orders_cancelled">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.cancelled.FldCaption %></span><span class="ewTableHeaderSort"><% If Orders.cancelled.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.cancelled.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.acknowledged.Visible Then ' acknowledged %>
	<% If Orders.SortUrl(Orders.acknowledged) = "" Then %>
		<th data-name="acknowledged"><div id="elh_Orders_acknowledged" class="Orders_acknowledged"><div class="ewTableHeaderCaption"><%= Orders.acknowledged.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="acknowledged"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.acknowledged) %>',1);"><div id="elh_Orders_acknowledged" class="Orders_acknowledged">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.acknowledged.FldCaption %></span><span class="ewTableHeaderSort"><% If Orders.acknowledged.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.acknowledged.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.outfordelivery.Visible Then ' outfordelivery %>
	<% If Orders.SortUrl(Orders.outfordelivery) = "" Then %>
		<th data-name="outfordelivery"><div id="elh_Orders_outfordelivery" class="Orders_outfordelivery"><div class="ewTableHeaderCaption"><%= Orders.outfordelivery.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="outfordelivery"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.outfordelivery) %>',1);"><div id="elh_Orders_outfordelivery" class="Orders_outfordelivery">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.outfordelivery.FldCaption %></span><span class="ewTableHeaderSort"><% If Orders.outfordelivery.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.outfordelivery.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.vouchercodediscount.Visible Then ' vouchercodediscount %>
	<% If Orders.SortUrl(Orders.vouchercodediscount) = "" Then %>
		<th data-name="vouchercodediscount"><div id="elh_Orders_vouchercodediscount" class="Orders_vouchercodediscount"><div class="ewTableHeaderCaption"><%= Orders.vouchercodediscount.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="vouchercodediscount"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.vouchercodediscount) %>',1);"><div id="elh_Orders_vouchercodediscount" class="Orders_vouchercodediscount">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.vouchercodediscount.FldCaption %></span><span class="ewTableHeaderSort"><% If Orders.vouchercodediscount.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.vouchercodediscount.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.vouchercode.Visible Then ' vouchercode %>
	<% If Orders.SortUrl(Orders.vouchercode) = "" Then %>
		<th data-name="vouchercode"><div id="elh_Orders_vouchercode" class="Orders_vouchercode"><div class="ewTableHeaderCaption"><%= Orders.vouchercode.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="vouchercode"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.vouchercode) %>',1);"><div id="elh_Orders_vouchercode" class="Orders_vouchercode">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.vouchercode.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If Orders.vouchercode.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.vouchercode.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.printed.Visible Then ' printed %>
	<% If Orders.SortUrl(Orders.printed) = "" Then %>
		<th data-name="printed"><div id="elh_Orders_printed" class="Orders_printed"><div class="ewTableHeaderCaption"><%= Orders.printed.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="printed"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.printed) %>',1);"><div id="elh_Orders_printed" class="Orders_printed">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.printed.FldCaption %></span><span class="ewTableHeaderSort"><% If Orders.printed.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.printed.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.deliverydistance.Visible Then ' deliverydistance %>
	<% If Orders.SortUrl(Orders.deliverydistance) = "" Then %>
		<th data-name="deliverydistance"><div id="elh_Orders_deliverydistance" class="Orders_deliverydistance"><div class="ewTableHeaderCaption"><%= Orders.deliverydistance.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="deliverydistance"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.deliverydistance) %>',1);"><div id="elh_Orders_deliverydistance" class="Orders_deliverydistance">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.deliverydistance.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If Orders.deliverydistance.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.deliverydistance.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.asaporder.Visible Then ' asaporder %>
	<% If Orders.SortUrl(Orders.asaporder) = "" Then %>
		<th data-name="asaporder"><div id="elh_Orders_asaporder" class="Orders_asaporder"><div class="ewTableHeaderCaption"><%= Orders.asaporder.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="asaporder"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.asaporder) %>',1);"><div id="elh_Orders_asaporder" class="Orders_asaporder">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.asaporder.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If Orders.asaporder.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.asaporder.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.DeliveryLat.Visible Then ' DeliveryLat %>
	<% If Orders.SortUrl(Orders.DeliveryLat) = "" Then %>
		<th data-name="DeliveryLat"><div id="elh_Orders_DeliveryLat" class="Orders_DeliveryLat"><div class="ewTableHeaderCaption"><%= Orders.DeliveryLat.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="DeliveryLat"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.DeliveryLat) %>',1);"><div id="elh_Orders_DeliveryLat" class="Orders_DeliveryLat">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.DeliveryLat.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If Orders.DeliveryLat.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.DeliveryLat.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.DeliveryLng.Visible Then ' DeliveryLng %>
	<% If Orders.SortUrl(Orders.DeliveryLng) = "" Then %>
		<th data-name="DeliveryLng"><div id="elh_Orders_DeliveryLng" class="Orders_DeliveryLng"><div class="ewTableHeaderCaption"><%= Orders.DeliveryLng.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="DeliveryLng"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.DeliveryLng) %>',1);"><div id="elh_Orders_DeliveryLng" class="Orders_DeliveryLng">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.DeliveryLng.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If Orders.DeliveryLng.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.DeliveryLng.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.ServiceCharge.Visible Then ' ServiceCharge %>
	<% If Orders.SortUrl(Orders.ServiceCharge) = "" Then %>
		<th data-name="ServiceCharge"><div id="elh_Orders_ServiceCharge" class="Orders_ServiceCharge"><div class="ewTableHeaderCaption"><%= Orders.ServiceCharge.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="ServiceCharge"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.ServiceCharge) %>',1);"><div id="elh_Orders_ServiceCharge" class="Orders_ServiceCharge">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.ServiceCharge.FldCaption %></span><span class="ewTableHeaderSort"><% If Orders.ServiceCharge.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.ServiceCharge.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.PaymentSurcharge.Visible Then ' PaymentSurcharge %>
	<% If Orders.SortUrl(Orders.PaymentSurcharge) = "" Then %>
		<th data-name="PaymentSurcharge"><div id="elh_Orders_PaymentSurcharge" class="Orders_PaymentSurcharge"><div class="ewTableHeaderCaption"><%= Orders.PaymentSurcharge.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="PaymentSurcharge"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.PaymentSurcharge) %>',1);"><div id="elh_Orders_PaymentSurcharge" class="Orders_PaymentSurcharge">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.PaymentSurcharge.FldCaption %></span><span class="ewTableHeaderSort"><% If Orders.PaymentSurcharge.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.PaymentSurcharge.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.FromIP.Visible Then ' FromIP %>
	<% If Orders.SortUrl(Orders.FromIP) = "" Then %>
		<th data-name="FromIP"><div id="elh_Orders_FromIP" class="Orders_FromIP"><div class="ewTableHeaderCaption"><%= Orders.FromIP.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="FromIP"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.FromIP) %>',1);"><div id="elh_Orders_FromIP" class="Orders_FromIP">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.FromIP.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If Orders.FromIP.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.FromIP.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.SentEmail.Visible Then ' SentEmail %>
	<% If Orders.SortUrl(Orders.SentEmail) = "" Then %>
		<th data-name="SentEmail"><div id="elh_Orders_SentEmail" class="Orders_SentEmail"><div class="ewTableHeaderCaption"><%= Orders.SentEmail.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="SentEmail"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.SentEmail) %>',1);"><div id="elh_Orders_SentEmail" class="Orders_SentEmail">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.SentEmail.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If Orders.SentEmail.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.SentEmail.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.Tax_Rate.Visible Then ' Tax_Rate %>
	<% If Orders.SortUrl(Orders.Tax_Rate) = "" Then %>
		<th data-name="Tax_Rate"><div id="elh_Orders_Tax_Rate" class="Orders_Tax_Rate"><div class="ewTableHeaderCaption"><%= Orders.Tax_Rate.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Tax_Rate"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.Tax_Rate) %>',1);"><div id="elh_Orders_Tax_Rate" class="Orders_Tax_Rate">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.Tax_Rate.FldCaption %></span><span class="ewTableHeaderSort"><% If Orders.Tax_Rate.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.Tax_Rate.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.Tax_Amount.Visible Then ' Tax_Amount %>
	<% If Orders.SortUrl(Orders.Tax_Amount) = "" Then %>
		<th data-name="Tax_Amount"><div id="elh_Orders_Tax_Amount" class="Orders_Tax_Amount"><div class="ewTableHeaderCaption"><%= Orders.Tax_Amount.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Tax_Amount"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.Tax_Amount) %>',1);"><div id="elh_Orders_Tax_Amount" class="Orders_Tax_Amount">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.Tax_Amount.FldCaption %></span><span class="ewTableHeaderSort"><% If Orders.Tax_Amount.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.Tax_Amount.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.Tip_Rate.Visible Then ' Tip_Rate %>
	<% If Orders.SortUrl(Orders.Tip_Rate) = "" Then %>
		<th data-name="Tip_Rate"><div id="elh_Orders_Tip_Rate" class="Orders_Tip_Rate"><div class="ewTableHeaderCaption"><%= Orders.Tip_Rate.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Tip_Rate"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.Tip_Rate) %>',1);"><div id="elh_Orders_Tip_Rate" class="Orders_Tip_Rate">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.Tip_Rate.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If Orders.Tip_Rate.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.Tip_Rate.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.Tip_Amount.Visible Then ' Tip_Amount %>
	<% If Orders.SortUrl(Orders.Tip_Amount) = "" Then %>
		<th data-name="Tip_Amount"><div id="elh_Orders_Tip_Amount" class="Orders_Tip_Amount"><div class="ewTableHeaderCaption"><%= Orders.Tip_Amount.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Tip_Amount"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.Tip_Amount) %>',1);"><div id="elh_Orders_Tip_Amount" class="Orders_Tip_Amount">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.Tip_Amount.FldCaption %></span><span class="ewTableHeaderSort"><% If Orders.Tip_Amount.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.Tip_Amount.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.Card_Debit.Visible Then ' Card_Debit %>
	<% If Orders.SortUrl(Orders.Card_Debit) = "" Then %>
		<th data-name="Card_Debit"><div id="elh_Orders_Card_Debit" class="Orders_Card_Debit"><div class="ewTableHeaderCaption"><%= Orders.Card_Debit.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Card_Debit"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.Card_Debit) %>',1);"><div id="elh_Orders_Card_Debit" class="Orders_Card_Debit">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.Card_Debit.FldCaption %></span><span class="ewTableHeaderSort"><% If Orders.Card_Debit.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.Card_Debit.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.Card_Credit.Visible Then ' Card_Credit %>
	<% If Orders.SortUrl(Orders.Card_Credit) = "" Then %>
		<th data-name="Card_Credit"><div id="elh_Orders_Card_Credit" class="Orders_Card_Credit"><div class="ewTableHeaderCaption"><%= Orders.Card_Credit.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Card_Credit"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.Card_Credit) %>',1);"><div id="elh_Orders_Card_Credit" class="Orders_Card_Credit">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.Card_Credit.FldCaption %></span><span class="ewTableHeaderSort"><% If Orders.Card_Credit.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.Card_Credit.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.deliverydelay.Visible Then ' deliverydelay %>
	<% If Orders.SortUrl(Orders.deliverydelay) = "" Then %>
		<th data-name="deliverydelay"><div id="elh_Orders_deliverydelay" class="Orders_deliverydelay"><div class="ewTableHeaderCaption"><%= Orders.deliverydelay.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="deliverydelay"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.deliverydelay) %>',1);"><div id="elh_Orders_deliverydelay" class="Orders_deliverydelay">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.deliverydelay.FldCaption %></span><span class="ewTableHeaderSort"><% If Orders.deliverydelay.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.deliverydelay.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.collectiondelay.Visible Then ' collectiondelay %>
	<% If Orders.SortUrl(Orders.collectiondelay) = "" Then %>
		<th data-name="collectiondelay"><div id="elh_Orders_collectiondelay" class="Orders_collectiondelay"><div class="ewTableHeaderCaption"><%= Orders.collectiondelay.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="collectiondelay"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.collectiondelay) %>',1);"><div id="elh_Orders_collectiondelay" class="Orders_collectiondelay">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.collectiondelay.FldCaption %></span><span class="ewTableHeaderSort"><% If Orders.collectiondelay.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.collectiondelay.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.lng_report.Visible Then ' lng_report %>
	<% If Orders.SortUrl(Orders.lng_report) = "" Then %>
		<th data-name="lng_report"><div id="elh_Orders_lng_report" class="Orders_lng_report"><div class="ewTableHeaderCaption"><%= Orders.lng_report.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="lng_report"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.lng_report) %>',1);"><div id="elh_Orders_lng_report" class="Orders_lng_report">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.lng_report.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If Orders.lng_report.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.lng_report.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.lat_report.Visible Then ' lat_report %>
	<% If Orders.SortUrl(Orders.lat_report) = "" Then %>
		<th data-name="lat_report"><div id="elh_Orders_lat_report" class="Orders_lat_report"><div class="ewTableHeaderCaption"><%= Orders.lat_report.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="lat_report"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.lat_report) %>',1);"><div id="elh_Orders_lat_report" class="Orders_lat_report">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.lat_report.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If Orders.lat_report.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.lat_report.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If Orders.Payment_status.Visible Then ' Payment_status %>
	<% If Orders.SortUrl(Orders.Payment_status) = "" Then %>
		<th data-name="Payment_status"><div id="elh_Orders_Payment_status" class="Orders_Payment_status"><div class="ewTableHeaderCaption"><%= Orders.Payment_status.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Payment_status"><div class="ewPointer" onclick="ew_Sort(event,'<%= Orders.SortUrl(Orders.Payment_status) %>',1);"><div id="elh_Orders_Payment_status" class="Orders_Payment_status">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= Orders.Payment_status.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If Orders.Payment_status.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf Orders.Payment_status.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<%

' Render list options (header, right)
Orders_list.ListOptions.Render "header", "right", "", "", "", ""
%>
	</tr>
</thead>
<tbody><!-- Table body -->
<%
If (Orders.ExportAll And Orders.Export <> "") Then
	Orders_list.StopRec = Orders_list.TotalRecs
Else

	' Set the last record to display
	If Orders_list.TotalRecs > Orders_list.StartRec + Orders_list.DisplayRecs - 1 Then
		Orders_list.StopRec = Orders_list.StartRec + Orders_list.DisplayRecs - 1
	Else
		Orders_list.StopRec = Orders_list.TotalRecs
	End If
End If

' Move to first record
Orders_list.RecCnt = Orders_list.StartRec - 1
If Not Orders_list.Recordset.Eof Then
	Orders_list.Recordset.MoveFirst
	If Orders_list.StartRec > 1 Then Orders_list.Recordset.Move Orders_list.StartRec - 1
ElseIf Not Orders.AllowAddDeleteRow And Orders_list.StopRec = 0 Then
	Orders_list.StopRec = Orders.GridAddRowCount
End If

' Initialize Aggregate
Orders.RowType = EW_ROWTYPE_AGGREGATEINIT
Call Orders.ResetAttrs()
Call Orders_list.RenderRow()
Orders_list.RowCnt = 0

' Output date rows
Do While CLng(Orders_list.RecCnt) < CLng(Orders_list.StopRec)
	Orders_list.RecCnt = Orders_list.RecCnt + 1
	If CLng(Orders_list.RecCnt) >= CLng(Orders_list.StartRec) Then
		Orders_list.RowCnt = Orders_list.RowCnt + 1

	' Set up key count
	Orders_list.KeyCount = Orders_list.RowIndex
	Call Orders.ResetAttrs()
	Orders.CssClass = ""
	If Orders.CurrentAction = "gridadd" Then
	Else
		Call Orders_list.LoadRowValues(Orders_list.Recordset) ' Load row values
	End If
	Orders.RowType = EW_ROWTYPE_VIEW ' Render view

	' Set up row id / data-rowindex
	Orders.RowAttrs.AddAttributes Array(Array("data-rowindex", Orders_list.RowCnt), Array("id", "r" & Orders_list.RowCnt & "_Orders"), Array("data-rowtype", Orders.RowType))

	' Render row
	Call Orders_list.RenderRow()

	' Render list options
	Call Orders_list.RenderListOptions()
%>
	<tr<%= Orders.RowAttributes %>>
<%

' Render list options (body, left)
Orders_list.ListOptions.Render "body", "left", Orders_list.RowCnt, "", "", ""
%>
	<% If Orders.ID.Visible Then ' ID %>
		<td data-name="ID"<%= Orders.ID.CellAttributes %>>
<span<%= Orders.ID.ViewAttributes %>>
<%= Orders.ID.ListViewValue %>
</span>
<a id="<%= Orders_list.PageObjName & "_row_" & Orders_list.RowCnt %>"></a></td>
	<% End If %>
	<% If Orders.CreationDate.Visible Then ' CreationDate %>
		<td data-name="CreationDate"<%= Orders.CreationDate.CellAttributes %>>
<span<%= Orders.CreationDate.ViewAttributes %>>
<%= Orders.CreationDate.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.OrderDate.Visible Then ' OrderDate %>
		<td data-name="OrderDate"<%= Orders.OrderDate.CellAttributes %>>
<span<%= Orders.OrderDate.ViewAttributes %>>
<%= Orders.OrderDate.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.DeliveryType.Visible Then ' DeliveryType %>
		<td data-name="DeliveryType"<%= Orders.DeliveryType.CellAttributes %>>
<span<%= Orders.DeliveryType.ViewAttributes %>>
<%= Orders.DeliveryType.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.DeliveryTime.Visible Then ' DeliveryTime %>
		<td data-name="DeliveryTime"<%= Orders.DeliveryTime.CellAttributes %>>
<span<%= Orders.DeliveryTime.ViewAttributes %>>
<%= Orders.DeliveryTime.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.PaymentType.Visible Then ' PaymentType %>
		<td data-name="PaymentType"<%= Orders.PaymentType.CellAttributes %>>
<span<%= Orders.PaymentType.ViewAttributes %>>
<%= Orders.PaymentType.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.SubTotal.Visible Then ' SubTotal %>
		<td data-name="SubTotal"<%= Orders.SubTotal.CellAttributes %>>
<span<%= Orders.SubTotal.ViewAttributes %>>
<%= Orders.SubTotal.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.ShippingFee.Visible Then ' ShippingFee %>
		<td data-name="ShippingFee"<%= Orders.ShippingFee.CellAttributes %>>
<span<%= Orders.ShippingFee.ViewAttributes %>>
<%= Orders.ShippingFee.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.OrderTotal.Visible Then ' OrderTotal %>
		<td data-name="OrderTotal"<%= Orders.OrderTotal.CellAttributes %>>
<span<%= Orders.OrderTotal.ViewAttributes %>>
<%= Orders.OrderTotal.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
		<td data-name="IdBusinessDetail"<%= Orders.IdBusinessDetail.CellAttributes %>>
<span<%= Orders.IdBusinessDetail.ViewAttributes %>>
<%= Orders.IdBusinessDetail.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.SessionId.Visible Then ' SessionId %>
		<td data-name="SessionId"<%= Orders.SessionId.CellAttributes %>>
<span<%= Orders.SessionId.ViewAttributes %>>
<%= Orders.SessionId.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.FirstName.Visible Then ' FirstName %>
		<td data-name="FirstName"<%= Orders.FirstName.CellAttributes %>>
<span<%= Orders.FirstName.ViewAttributes %>>
<%= Orders.FirstName.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.LastName.Visible Then ' LastName %>
		<td data-name="LastName"<%= Orders.LastName.CellAttributes %>>
<span<%= Orders.LastName.ViewAttributes %>>
<%= Orders.LastName.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.zEmail.Visible Then ' Email %>
		<td data-name="zEmail"<%= Orders.zEmail.CellAttributes %>>
<span<%= Orders.zEmail.ViewAttributes %>>
<%= Orders.zEmail.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.Phone.Visible Then ' Phone %>
		<td data-name="Phone"<%= Orders.Phone.CellAttributes %>>
<span<%= Orders.Phone.ViewAttributes %>>
<%= Orders.Phone.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.Address.Visible Then ' Address %>
		<td data-name="Address"<%= Orders.Address.CellAttributes %>>
<span<%= Orders.Address.ViewAttributes %>>
<%= Orders.Address.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.PostalCode.Visible Then ' PostalCode %>
		<td data-name="PostalCode"<%= Orders.PostalCode.CellAttributes %>>
<span<%= Orders.PostalCode.ViewAttributes %>>
<%= Orders.PostalCode.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.ttest.Visible Then ' ttest %>
		<td data-name="ttest"<%= Orders.ttest.CellAttributes %>>
<span<%= Orders.ttest.ViewAttributes %>>
<%= Orders.ttest.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.cancelleddate.Visible Then ' cancelleddate %>
		<td data-name="cancelleddate"<%= Orders.cancelleddate.CellAttributes %>>
<span<%= Orders.cancelleddate.ViewAttributes %>>
<%= Orders.cancelleddate.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.cancelledby.Visible Then ' cancelledby %>
		<td data-name="cancelledby"<%= Orders.cancelledby.CellAttributes %>>
<span<%= Orders.cancelledby.ViewAttributes %>>
<%= Orders.cancelledby.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.cancelledreason.Visible Then ' cancelledreason %>
		<td data-name="cancelledreason"<%= Orders.cancelledreason.CellAttributes %>>
<span<%= Orders.cancelledreason.ViewAttributes %>>
<%= Orders.cancelledreason.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.acknowledgeddate.Visible Then ' acknowledgeddate %>
		<td data-name="acknowledgeddate"<%= Orders.acknowledgeddate.CellAttributes %>>
<span<%= Orders.acknowledgeddate.ViewAttributes %>>
<%= Orders.acknowledgeddate.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.delivereddate.Visible Then ' delivereddate %>
		<td data-name="delivereddate"<%= Orders.delivereddate.CellAttributes %>>
<span<%= Orders.delivereddate.ViewAttributes %>>
<%= Orders.delivereddate.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.cancelled.Visible Then ' cancelled %>
		<td data-name="cancelled"<%= Orders.cancelled.CellAttributes %>>
<span<%= Orders.cancelled.ViewAttributes %>>
<%= Orders.cancelled.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.acknowledged.Visible Then ' acknowledged %>
		<td data-name="acknowledged"<%= Orders.acknowledged.CellAttributes %>>
<span<%= Orders.acknowledged.ViewAttributes %>>
<%= Orders.acknowledged.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.outfordelivery.Visible Then ' outfordelivery %>
		<td data-name="outfordelivery"<%= Orders.outfordelivery.CellAttributes %>>
<span<%= Orders.outfordelivery.ViewAttributes %>>
<%= Orders.outfordelivery.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.vouchercodediscount.Visible Then ' vouchercodediscount %>
		<td data-name="vouchercodediscount"<%= Orders.vouchercodediscount.CellAttributes %>>
<span<%= Orders.vouchercodediscount.ViewAttributes %>>
<%= Orders.vouchercodediscount.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.vouchercode.Visible Then ' vouchercode %>
		<td data-name="vouchercode"<%= Orders.vouchercode.CellAttributes %>>
<span<%= Orders.vouchercode.ViewAttributes %>>
<%= Orders.vouchercode.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.printed.Visible Then ' printed %>
		<td data-name="printed"<%= Orders.printed.CellAttributes %>>
<span<%= Orders.printed.ViewAttributes %>>
<%= Orders.printed.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.deliverydistance.Visible Then ' deliverydistance %>
		<td data-name="deliverydistance"<%= Orders.deliverydistance.CellAttributes %>>
<span<%= Orders.deliverydistance.ViewAttributes %>>
<%= Orders.deliverydistance.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.asaporder.Visible Then ' asaporder %>
		<td data-name="asaporder"<%= Orders.asaporder.CellAttributes %>>
<span<%= Orders.asaporder.ViewAttributes %>>
<%= Orders.asaporder.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.DeliveryLat.Visible Then ' DeliveryLat %>
		<td data-name="DeliveryLat"<%= Orders.DeliveryLat.CellAttributes %>>
<span<%= Orders.DeliveryLat.ViewAttributes %>>
<%= Orders.DeliveryLat.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.DeliveryLng.Visible Then ' DeliveryLng %>
		<td data-name="DeliveryLng"<%= Orders.DeliveryLng.CellAttributes %>>
<span<%= Orders.DeliveryLng.ViewAttributes %>>
<%= Orders.DeliveryLng.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.ServiceCharge.Visible Then ' ServiceCharge %>
		<td data-name="ServiceCharge"<%= Orders.ServiceCharge.CellAttributes %>>
<span<%= Orders.ServiceCharge.ViewAttributes %>>
<%= Orders.ServiceCharge.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.PaymentSurcharge.Visible Then ' PaymentSurcharge %>
		<td data-name="PaymentSurcharge"<%= Orders.PaymentSurcharge.CellAttributes %>>
<span<%= Orders.PaymentSurcharge.ViewAttributes %>>
<%= Orders.PaymentSurcharge.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.FromIP.Visible Then ' FromIP %>
		<td data-name="FromIP"<%= Orders.FromIP.CellAttributes %>>
<span<%= Orders.FromIP.ViewAttributes %>>
<%= Orders.FromIP.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.SentEmail.Visible Then ' SentEmail %>
		<td data-name="SentEmail"<%= Orders.SentEmail.CellAttributes %>>
<span<%= Orders.SentEmail.ViewAttributes %>>
<%= Orders.SentEmail.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.Tax_Rate.Visible Then ' Tax_Rate %>
		<td data-name="Tax_Rate"<%= Orders.Tax_Rate.CellAttributes %>>
<span<%= Orders.Tax_Rate.ViewAttributes %>>
<%= Orders.Tax_Rate.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.Tax_Amount.Visible Then ' Tax_Amount %>
		<td data-name="Tax_Amount"<%= Orders.Tax_Amount.CellAttributes %>>
<span<%= Orders.Tax_Amount.ViewAttributes %>>
<%= Orders.Tax_Amount.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.Tip_Rate.Visible Then ' Tip_Rate %>
		<td data-name="Tip_Rate"<%= Orders.Tip_Rate.CellAttributes %>>
<span<%= Orders.Tip_Rate.ViewAttributes %>>
<%= Orders.Tip_Rate.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.Tip_Amount.Visible Then ' Tip_Amount %>
		<td data-name="Tip_Amount"<%= Orders.Tip_Amount.CellAttributes %>>
<span<%= Orders.Tip_Amount.ViewAttributes %>>
<%= Orders.Tip_Amount.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.Card_Debit.Visible Then ' Card_Debit %>
		<td data-name="Card_Debit"<%= Orders.Card_Debit.CellAttributes %>>
<span<%= Orders.Card_Debit.ViewAttributes %>>
<%= Orders.Card_Debit.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.Card_Credit.Visible Then ' Card_Credit %>
		<td data-name="Card_Credit"<%= Orders.Card_Credit.CellAttributes %>>
<span<%= Orders.Card_Credit.ViewAttributes %>>
<%= Orders.Card_Credit.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.deliverydelay.Visible Then ' deliverydelay %>
		<td data-name="deliverydelay"<%= Orders.deliverydelay.CellAttributes %>>
<span<%= Orders.deliverydelay.ViewAttributes %>>
<%= Orders.deliverydelay.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.collectiondelay.Visible Then ' collectiondelay %>
		<td data-name="collectiondelay"<%= Orders.collectiondelay.CellAttributes %>>
<span<%= Orders.collectiondelay.ViewAttributes %>>
<%= Orders.collectiondelay.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.lng_report.Visible Then ' lng_report %>
		<td data-name="lng_report"<%= Orders.lng_report.CellAttributes %>>
<span<%= Orders.lng_report.ViewAttributes %>>
<%= Orders.lng_report.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.lat_report.Visible Then ' lat_report %>
		<td data-name="lat_report"<%= Orders.lat_report.CellAttributes %>>
<span<%= Orders.lat_report.ViewAttributes %>>
<%= Orders.lat_report.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If Orders.Payment_status.Visible Then ' Payment_status %>
		<td data-name="Payment_status"<%= Orders.Payment_status.CellAttributes %>>
<span<%= Orders.Payment_status.ViewAttributes %>>
<%= Orders.Payment_status.ListViewValue %>
</span>
</td>
	<% End If %>
<%

' Render list options (body, right)
Orders_list.ListOptions.Render "body", "right", Orders_list.RowCnt, "", "", ""
%>
	</tr>
<%
	End If
	If Orders.CurrentAction <> "gridadd" Then
		Orders_list.Recordset.MoveNext()
	End If
Loop
%>
</tbody>
</table>
<% End If %>
<% If Orders.CurrentAction = "" Then %>
<input type="hidden" name="a_list" id="a_list" value="">
<% End If %>
</div>
</form>
<%

' Close recordset and connection
Orders_list.Recordset.Close
Set Orders_list.Recordset = Nothing
%>
<% If Orders.Export = "" Then %>
<div class="ewGridLowerPanel">
<% If Orders.CurrentAction <> "gridadd" And Orders.CurrentAction <> "gridedit" Then %>
<form name="ewPagerForm" class="ewForm form-inline ewPagerForm" action="<%= ew_CurrentPage %>">
<% If Not IsObject(Orders_list.Pager) Then Set Orders_list.Pager = ew_NewPrevNextPager(Orders_list.StartRec, Orders_list.DisplayRecs, Orders_list.TotalRecs) %>
<% If Orders_list.Pager.RecordCount > 0 Then %>
<div class="ewPager">
<span><%= Language.Phrase("Page") %>&nbsp;</span>
<div class="ewPrevNext"><div class="input-group">
<div class="input-group-btn">
<!--first page button-->
	<% If Orders_list.Pager.FirstButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerFirst") %>" href="<%= Orders_list.PageUrl %>start=<%= Orders_list.Pager.FirstButton.Start %>"><span class="icon-first ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerFirst") %>"><span class="icon-first ewIcon"></span></a>
	<% End If %>
<!--previous page button-->
	<% If Orders_list.Pager.PrevButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerPrevious") %>" href="<%= Orders_list.PageUrl %>start=<%= Orders_list.Pager.PrevButton.Start %>"><span class="icon-prev ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerPrevious") %>"><span class="icon-prev ewIcon"></span></a>
	<% End If %>
</div>
<!--current page number-->
	<input class="form-control input-sm" type="text" name="<%= EW_TABLE_PAGE_NO %>" value="<%= Orders_list.Pager.CurrentPage %>">
<div class="input-group-btn">
<!--next page button-->
	<% If Orders_list.Pager.NextButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerNext") %>" href="<%= Orders_list.PageUrl %>start=<%= Orders_list.Pager.NextButton.Start %>"><span class="icon-next ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerNext") %>"><span class="icon-next ewIcon"></span></a>
	<% End If %>
<!--last page button-->
	<% If Orders_list.Pager.LastButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerLast") %>" href="<%= Orders_list.PageUrl %>start=<%= Orders_list.Pager.LastButton.Start %>"><span class="icon-last ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerLast") %>"><span class="icon-last ewIcon"></span></a>
	<% End If %>
</div>
</div>
</div>
<span>&nbsp;<%= Language.Phrase("of") %>&nbsp;<%= Orders_list.Pager.PageCount %></span>
</div>
<div class="ewPager ewRec">
	<span><%= Language.Phrase("Record") %>&nbsp;<%= Orders_list.Pager.FromIndex %>&nbsp;<%= Language.Phrase("To") %>&nbsp;<%= Orders_list.Pager.ToIndex %>&nbsp;<%= Language.Phrase("Of") %>&nbsp;<%= Orders_list.Pager.RecordCount %></span>
</div>
<% End If %>
<% If Orders_list.TotalRecs > 0 Then %>
<div class="ewPager">
<input type="hidden" name="t" value="Orders">
<select name="<%= EW_TABLE_REC_PER_PAGE %>" class="form-control input-sm" onchange="this.form.submit();">
<option value="20"<% If Orders_list.DisplayRecs = 20 Then %> selected="selected"<% End If %>>20</option>
<option value="50"<% If Orders_list.DisplayRecs = 50 Then %> selected="selected"<% End If %>>50</option>
<option value="100"<% If Orders_list.DisplayRecs = 100 Then %> selected="selected"<% End If %>>100</option>
<option value="500"<% If Orders_list.DisplayRecs = 500 Then %> selected="selected"<% End If %>>500</option>
<option value="1000"<% If Orders_list.DisplayRecs = 1000 Then %> selected="selected"<% End If %>>1000</option>
<option value="ALL"<% If Orders.RecordsPerPage = -1 Then %> selected="selected"<% End If %>><%= Language.Phrase("AllRecords") %></option>
</select>
</div>
<% End If %>
</form>
<% End If %>
<div class="ewListOtherOptions">
<%
	Orders_list.AddEditOptions.Render "body", "bottom", "", "", "", ""
	Orders_list.DetailOptions.Render "body", "bottom", "", "", "", ""
	Orders_list.ActionOptions.Render "body", "bottom", "", "", "", ""
%>
</div>
<div class="clearfix"></div>
</div>
<% End If %>
</div>
<% End If %>
<% If Orders_list.TotalRecs = 0 And Orders.CurrentAction = "" Then ' Show other options %>
<div class="ewListOtherOptions">
<%
	Orders_list.AddEditOptions.Render "body", "", "", "", "", ""
	Orders_list.DetailOptions.Render "body", "", "", "", "", ""
	Orders_list.ActionOptions.Render "body", "", "", "", "", ""
%>
</div>
<div class="clearfix"></div>
<% End If %>
<% If Orders.Export <> "" Then %>
<script type="text/javascript">
ew_ApplyTemplate("body", "", "Orderslist", "<%= Orders.CustomExport %>");
</script>
<% End If %>
<% If Orders.Export = "" Then %>
<script type="text/javascript">
fOrderslistsrch.Init();
fOrderslist.Init();
</script>
<% End If %>
<%
Orders_list.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<% If Orders.Export = "" Then %>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<% End If %>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set Orders_list = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cOrders_list

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
		TableName = "Orders"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "Orders_list"
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
		If Orders.UseTokenInUrl Then PageUrl = PageUrl & "t=" & Orders.TableVar & "&" ' add page token
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
		If Orders.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (Orders.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (Orders.TableVar = Request.QueryString("t"))
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
		FormName = "fOrderslist"
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
		If IsEmpty(Orders) Then Set Orders = New cOrders
		Set Table = Orders
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
		AddUrl = "Ordersadd.asp"
		InlineAddUrl = PageUrl & "a=add"
		GridAddUrl = PageUrl & "a=gridadd"
		GridEditUrl = PageUrl & "a=gridedit"
		MultiDeleteUrl = "Ordersdelete.asp"
		MultiUpdateUrl = "Ordersupdate.asp"

		' Initialize form object
		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "list"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "Orders"

		' Open connection to the database
		If IsEmpty(Conn) Then Call ew_Connect()

		' List options
		Set ListOptions = New cListOptions
		ListOptions.TableVar = Orders.TableVar

		' Export options
		Set ExportOptions = New cListOptions
		ExportOptions.TableVar = Orders.TableVar
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
			Orders.Export = Request.QueryString("export")
			custom = Request.QueryString("custom") & ""
		ElseIf ew_IsHttpPost() Then
			If Request.Form("export").Count > 0 Then
				Orders.Export = Request.Form("export")
				custom = Request.Form("custom") & ""
			ElseIf Request.Form("exporttype").Count > 0 Then
				Orders.Export = Request.Form("exporttype")
				custom = Request.Form("custom") & ""
			End If
		Else
			Orders.ExportReturnUrl = ew_CurrentUrl()
		End If
		gsExportFile = Orders.TableVar ' Get export file, used in header
		Dim Charset ' Charset used in header
		If EW_CHARSET <> "" Then
			Charset = ";charset=" & EW_CHARSET
		Else
			Charset = ""
		End If

		' Get custom export parameters
		If Orders.Export <> "" And custom <> "" Then
			Orders.CustomExport = Orders.Export
			Orders.Export = "print"
		End If
		gsCustomExport = Orders.CustomExport
		gsExport = Orders.Export ' Get export parameter, used in header

		' Custom export (post back from ew_ApplyTemplate), export and terminate page
		If Request.Form("customexport").Count > 0 Then
			Orders.CustomExport = Request.Form("customexport")
			Orders.Export = Orders.CustomExport
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
		If Orders.Export = "excel" Then
			Response.ContentType = "application/vnd.ms-excel" & Charset
			Response.AddHeader "Content-Disposition", "attachment; filename=" & gsExportFile & ".xls"
		End If
		If Orders.Export = "word" Then
			Response.ContentType = "application/vnd.ms-word" & Charset
			Response.AddHeader "Content-Disposition", "attachment; filename=" & gsExportFile & ".doc"
		End If
		If Orders.Export = "csv" Then
			Response.BinaryWrite ChrB(239) & ChrB(187) & ChrB(191)
			Response.ContentType = "application/csv" & Charset
			Response.AddHeader "Content-Disposition", "attachment; filename=" & gsExportFile & ".csv"
		End If

		' Get grid add count
		Dim gridaddcnt
		gridaddcnt = Request.QueryString(EW_TABLE_GRID_ADD_ROW_COUNT)
		If IsNumeric(gridaddcnt) Then
			If gridaddcnt > 0 Then
				Orders.GridAddRowCount = gridaddcnt
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
			results = Orders.GetAutoFill(Request.Form("name"), Request.Form("q"))
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
		If UBound(Orders.CustomActions.CustomArray) >= 0 Then
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
		If Not Orders Is Nothing Then
			If Orders.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = Orders.TableVar
				If Orders.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf Orders.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf Orders.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf Orders.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set Orders = Nothing
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
			If Orders.Export = "" Then
				SetupBreadcrumb()
			End If

			' Hide list options
			If Orders.Export <> "" Then
				Call ListOptions.HideAllOptions(Array("sequence"))
				ListOptions.UseDropDownButton = False ' Disable drop down button
				ListOptions.UseButtonGroup = False ' Disable button group
			ElseIf Orders.CurrentAction = "gridadd" Or Orders.CurrentAction = "gridedit" Then
				Call ListOptions.HideAllOptions(Array())
				ListOptions.UseDropDownButton = False ' Disable drop down button
				ListOptions.UseButtonGroup = False ' Disable button group
			End If

			' Hide export options
			If Orders.Export <> "" Or Orders.CurrentAction <> "" Then
				ExportOptions.HideAllOptions(Array())
			End If

			' Hide other options
			If Orders.Export <> "" Then
				AddEditOptions.HideAllOptions(Array())
				DetailOptions.HideAllOptions(Array())
				ActionOptions.HideAllOptions(Array())
			End If

			' Get default search criteria
			Call ew_AddFilter(DefaultSearchWhere, BasicSearchWhere(True))

			' Get basic search values
			Call LoadBasicSearchValues()

			' Restore search parms from Session if not searching / reset / export
			If (Orders.Export <> "" Or Command <> "search" And Command <> "reset" And Command <> "resetall") And CheckSearchParms() Then
				Call RestoreSearchParms()
			End If

			' Call Recordset SearchValidated event
			Call Orders.Recordset_SearchValidated()

			' Set Up Sorting Order
			SetUpSortOrder()

			' Get basic search criteria
			If gsSearchError = "" Then
				sSrchBasic = BasicSearchWhere(False)
			End If
		End If ' End Validate Request

		' Restore display records
		If Orders.RecordsPerPage <> "" Then
			DisplayRecs = Orders.RecordsPerPage ' Restore from Session
		Else
			DisplayRecs = 20 ' Load default
		End If

		' Load Sorting Order
		LoadSortOrder()

		' Load search default if no existing search criteria
		If Not CheckSearchParms() Then

			' Load basic search from default
			Orders.BasicSearch.Keyword = Orders.BasicSearch.KeywordDefault
			Orders.BasicSearch.SearchType = Orders.BasicSearch.SearchTypeDefault
			Orders.BasicSearch.setSearchType(Orders.BasicSearch.SearchTypeDefault)
			If Orders.BasicSearch.Keyword <> "" Then
				sSrchBasic = BasicSearchWhere(False)
			End If
		End If

		' Build search criteria
		Call ew_AddFilter(SearchWhere, sSrchAdvanced)
		Call ew_AddFilter(SearchWhere, sSrchBasic)

		' Call Recordset Searching event
		Call Orders.Recordset_Searching(SearchWhere)

		' Save search criteria
		If Command = "search" And Not RestoreSearch Then
			Orders.SearchWhere = SearchWhere ' Save to Session
			StartRec = 1 ' Reset start record counter
			Orders.StartRecordNumber = StartRec
		Else
			SearchWhere = Orders.SearchWhere
		End If
		sFilter = ""
		Call ew_AddFilter(sFilter, DbDetailFilter)
		Call ew_AddFilter(sFilter, SearchWhere)

		' Set up filter in Session
		Orders.SessionWhere = sFilter
		Orders.CurrentFilter = ""

		' Export Data only
		If Orders.CustomExport = "" And ew_InArray(Orders.Export, Array("html","word","excel","xml","csv","email","pdf")) Then
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
			Orders.RecordsPerPage = DisplayRecs ' Save to Session

			' Reset start position
			StartRec = 1
			Orders.StartRecordNumber = StartRec
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
				sFilter = Orders.KeyFilter
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
			Orders.ID.FormValue = arrKeyFlds(0)
			If Not IsNumeric(Orders.ID.FormValue) Then
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
			Call BuildBasicSearchSQL(sWhere, Orders.DeliveryType, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, Orders.PaymentType, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, Orders.SessionId, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, Orders.FirstName, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, Orders.LastName, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, Orders.zEmail, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, Orders.Phone, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, Orders.Address, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, Orders.PostalCode, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, Orders.Notes, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, Orders.ttest, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, Orders.cancelledby, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, Orders.cancelledreason, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, Orders.delivereddate, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, Orders.vouchercode, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, Orders.deliverydistance, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, Orders.asaporder, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, Orders.DeliveryLat, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, Orders.DeliveryLng, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, Orders.FromIP, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, Orders.SentEmail, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, Orders.Tip_Rate, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, Orders.lng_report, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, Orders.lat_report, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, Orders.Payment_status, arKeywords, typ)
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
		sSearchKeyword = ew_IIf(Default, Orders.BasicSearch.KeywordDefault, Orders.BasicSearch.Keyword)
		sSearchType = ew_IIf(Default, Orders.BasicSearch.SearchTypeDefault, Orders.BasicSearch.SearchType)
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
			Orders.BasicSearch.setKeyword(sSearchKeyword)
			Orders.BasicSearch.setSearchType(sSearchType)
		End If
		BasicSearchWhere = sSearchStr
	End Function

	' Check if search parm exists
	Function CheckSearchParms()

		' Check basic search
		If Orders.BasicSearch.IssetSession() Then
			CheckSearchParms = True
			Exit Function
		End If
		CheckSearchParms = False
	End Function

	' Clear all search parameters
	Sub ResetSearchParms()

		' Clear search where
		SearchWhere = ""
		Orders.SearchWhere = SearchWhere

		' Clear basic search parameters
		Call ResetBasicSearchParms()
	End Sub

	' Load advanced search default values
	Function LoadAdvancedSearchDefault()
		LoadAdvancedSearchDefault = False
	End Function

	' Clear all basic search parameters
	Sub ResetBasicSearchParms()
		Orders.BasicSearch.UnsetSession()
	End Sub

	' -----------------------------------------------------------------
	' Restore all search parameters
	'
	Sub RestoreSearchParms()

		' Restore search flag
		RestoreSearch = True

		' Restore basic search values
		Call Orders.BasicSearch.Load()
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
			Orders.CurrentOrder = Request.QueryString("order")
			Orders.CurrentOrderType = Request.QueryString("ordertype")

			' Field ID
			Call Orders.UpdateSort(Orders.ID)

			' Field CreationDate
			Call Orders.UpdateSort(Orders.CreationDate)

			' Field OrderDate
			Call Orders.UpdateSort(Orders.OrderDate)

			' Field DeliveryType
			Call Orders.UpdateSort(Orders.DeliveryType)

			' Field DeliveryTime
			Call Orders.UpdateSort(Orders.DeliveryTime)

			' Field PaymentType
			Call Orders.UpdateSort(Orders.PaymentType)

			' Field SubTotal
			Call Orders.UpdateSort(Orders.SubTotal)

			' Field ShippingFee
			Call Orders.UpdateSort(Orders.ShippingFee)

			' Field OrderTotal
			Call Orders.UpdateSort(Orders.OrderTotal)

			' Field IdBusinessDetail
			Call Orders.UpdateSort(Orders.IdBusinessDetail)

			' Field SessionId
			Call Orders.UpdateSort(Orders.SessionId)

			' Field FirstName
			Call Orders.UpdateSort(Orders.FirstName)

			' Field LastName
			Call Orders.UpdateSort(Orders.LastName)

			' Field Email
			Call Orders.UpdateSort(Orders.zEmail)

			' Field Phone
			Call Orders.UpdateSort(Orders.Phone)

			' Field Address
			Call Orders.UpdateSort(Orders.Address)

			' Field PostalCode
			Call Orders.UpdateSort(Orders.PostalCode)

			' Field ttest
			Call Orders.UpdateSort(Orders.ttest)

			' Field cancelleddate
			Call Orders.UpdateSort(Orders.cancelleddate)

			' Field cancelledby
			Call Orders.UpdateSort(Orders.cancelledby)

			' Field cancelledreason
			Call Orders.UpdateSort(Orders.cancelledreason)

			' Field acknowledgeddate
			Call Orders.UpdateSort(Orders.acknowledgeddate)

			' Field delivereddate
			Call Orders.UpdateSort(Orders.delivereddate)

			' Field cancelled
			Call Orders.UpdateSort(Orders.cancelled)

			' Field acknowledged
			Call Orders.UpdateSort(Orders.acknowledged)

			' Field outfordelivery
			Call Orders.UpdateSort(Orders.outfordelivery)

			' Field vouchercodediscount
			Call Orders.UpdateSort(Orders.vouchercodediscount)

			' Field vouchercode
			Call Orders.UpdateSort(Orders.vouchercode)

			' Field printed
			Call Orders.UpdateSort(Orders.printed)

			' Field deliverydistance
			Call Orders.UpdateSort(Orders.deliverydistance)

			' Field asaporder
			Call Orders.UpdateSort(Orders.asaporder)

			' Field DeliveryLat
			Call Orders.UpdateSort(Orders.DeliveryLat)

			' Field DeliveryLng
			Call Orders.UpdateSort(Orders.DeliveryLng)

			' Field ServiceCharge
			Call Orders.UpdateSort(Orders.ServiceCharge)

			' Field PaymentSurcharge
			Call Orders.UpdateSort(Orders.PaymentSurcharge)

			' Field FromIP
			Call Orders.UpdateSort(Orders.FromIP)

			' Field SentEmail
			Call Orders.UpdateSort(Orders.SentEmail)

			' Field Tax_Rate
			Call Orders.UpdateSort(Orders.Tax_Rate)

			' Field Tax_Amount
			Call Orders.UpdateSort(Orders.Tax_Amount)

			' Field Tip_Rate
			Call Orders.UpdateSort(Orders.Tip_Rate)

			' Field Tip_Amount
			Call Orders.UpdateSort(Orders.Tip_Amount)

			' Field Card_Debit
			Call Orders.UpdateSort(Orders.Card_Debit)

			' Field Card_Credit
			Call Orders.UpdateSort(Orders.Card_Credit)

			' Field deliverydelay
			Call Orders.UpdateSort(Orders.deliverydelay)

			' Field collectiondelay
			Call Orders.UpdateSort(Orders.collectiondelay)

			' Field lng_report
			Call Orders.UpdateSort(Orders.lng_report)

			' Field lat_report
			Call Orders.UpdateSort(Orders.lat_report)

			' Field Payment_status
			Call Orders.UpdateSort(Orders.Payment_status)
			Orders.StartRecordNumber = 1 ' Reset start position
		End If
	End Sub

	' -----------------------------------------------------------------
	' Load Sort Order parameters
	'
	Sub LoadSortOrder()
		Dim sOrderBy
		sOrderBy = Orders.SessionOrderBy ' Get order by from Session
		If sOrderBy = "" Then
			If Orders.SqlOrderBy <> "" Then
				sOrderBy = Orders.SqlOrderBy
				Orders.SessionOrderBy = sOrderBy
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
				Orders.SessionOrderBy = sOrderBy
				Orders.ID.Sort = ""
				Orders.CreationDate.Sort = ""
				Orders.OrderDate.Sort = ""
				Orders.DeliveryType.Sort = ""
				Orders.DeliveryTime.Sort = ""
				Orders.PaymentType.Sort = ""
				Orders.SubTotal.Sort = ""
				Orders.ShippingFee.Sort = ""
				Orders.OrderTotal.Sort = ""
				Orders.IdBusinessDetail.Sort = ""
				Orders.SessionId.Sort = ""
				Orders.FirstName.Sort = ""
				Orders.LastName.Sort = ""
				Orders.zEmail.Sort = ""
				Orders.Phone.Sort = ""
				Orders.Address.Sort = ""
				Orders.PostalCode.Sort = ""
				Orders.ttest.Sort = ""
				Orders.cancelleddate.Sort = ""
				Orders.cancelledby.Sort = ""
				Orders.cancelledreason.Sort = ""
				Orders.acknowledgeddate.Sort = ""
				Orders.delivereddate.Sort = ""
				Orders.cancelled.Sort = ""
				Orders.acknowledged.Sort = ""
				Orders.outfordelivery.Sort = ""
				Orders.vouchercodediscount.Sort = ""
				Orders.vouchercode.Sort = ""
				Orders.printed.Sort = ""
				Orders.deliverydistance.Sort = ""
				Orders.asaporder.Sort = ""
				Orders.DeliveryLat.Sort = ""
				Orders.DeliveryLng.Sort = ""
				Orders.ServiceCharge.Sort = ""
				Orders.PaymentSurcharge.Sort = ""
				Orders.FromIP.Sort = ""
				Orders.SentEmail.Sort = ""
				Orders.Tax_Rate.Sort = ""
				Orders.Tax_Amount.Sort = ""
				Orders.Tip_Rate.Sort = ""
				Orders.Tip_Amount.Sort = ""
				Orders.Card_Debit.Sort = ""
				Orders.Card_Credit.Sort = ""
				Orders.deliverydelay.Sort = ""
				Orders.collectiondelay.Sort = ""
				Orders.lng_report.Sort = ""
				Orders.lat_report.Sort = ""
				Orders.Payment_status.Sort = ""
			End If

			' Reset start position
			StartRec = 1
			Orders.StartRecordNumber = StartRec
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
		ListOptions.GetItem("checkbox").Body = "<input type=""checkbox"" name=""key_m"" value=""" & ew_HtmlEncode(Orders.ID.CurrentValue) & """ onclick='ew_ClickMultiCheckbox(event, this);'>"
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
		item.Body = "<a class=""ewAction ewMultiDelete"" title=""" & ew_HtmlTitle(Language.Phrase("DeleteSelectedLink")) & """ data-caption=""" & ew_HtmlTitle(Language.Phrase("DeleteSelectedLink")) & """ href="""" onclick=""ew_SubmitSelected(document.fOrderslist, '" & MultiDeleteUrl & "', ewLanguage.Phrase('DeleteMultiConfirmMsg'));return false;"">" & Language.Phrase("DeleteSelectedLink") & "</a>"
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
			For i = 0 to UBound(Orders.CustomActions.CustomArray)
				Action = Orders.CustomActions.CustomArray(i)(0)
				Name = Orders.CustomActions.CustomArray(i)(1)

				' Add custom action
				Call opt.Add("custom_" & Action)
				Set item = opt.GetItem("custom_" & Action)
				item.Body = "<a class=""ewAction ewCustomAction"" href="""" onclick=""ew_SubmitSelected(document.fOrderslist, '" & ew_CurrentUrl & "', null, '" & Action & "');return false;"">" & Name & "</a>"
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
		sFilter = Orders.GetKeyFilter
		UserAction = Request.Form("useraction") & ""
		Processed = False
		If sFilter <> "" And UserAction <> "" Then
			Orders.CurrentFilter = sFilter
			sSql = Orders.SQL
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
				ElseIf Orders.CancelMessage <> "" Then
					FailureMessage = Orders.CancelMessage
					Orders.CancelMessage = ""
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
		SearchOptions.TableVar = Orders.TableVar
		ExportOptions.Tag = "div"
		SearchOptions.TagClassName = "ewSearchOption"

		' Search button
		SearchOptions.Add("searchtoggle")
		Set item = SearchOptions.GetItem("searchtoggle")
		SearchToggleClass = ew_IIf(SearchWhere <> "", " active", " active")
		item.Body = "<button type=""button"" class=""btn btn-default ewSearchToggle" & SearchToggleClass & """ title=""" & Language.Phrase("SearchPanel") & """ data-caption=""" & Language.Phrase("SearchPanel") & """ data-toggle=""button"" data-form=""fOrderslistsrch"">" & Language.Phrase("SearchBtn") & "</button>"
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
		If Orders.Export <> "" Or Orders.CurrentAction <> "" Then
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
				Orders.StartRecordNumber = StartRec
			ElseIf Request.QueryString(EW_TABLE_PAGE_NO).Count > 0 Then
				PageNo = Request.QueryString(EW_TABLE_PAGE_NO)
				If IsNumeric(PageNo) Then
					StartRec = (PageNo-1)*DisplayRecs+1
					If StartRec <= 0 Then
						StartRec = 1
					ElseIf StartRec >= ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1 Then
						StartRec = ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1
					End If
					Orders.StartRecordNumber = StartRec
				End If
			End If
		End If
		StartRec = Orders.StartRecordNumber

		' Check if correct start record counter
		If Not IsNumeric(StartRec) Or StartRec = "" Then ' Avoid invalid start record counter
			StartRec = 1 ' Reset start record counter
			Orders.StartRecordNumber = StartRec
		ElseIf CLng(StartRec) > CLng(TotalRecs) Then ' Avoid starting record > total records
			StartRec = ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1 ' Point to last page first record
			Orders.StartRecordNumber = StartRec
		ElseIf (StartRec-1) Mod DisplayRecs <> 0 Then
			StartRec = ((StartRec-1)\DisplayRecs)*DisplayRecs+1 ' Point to page boundary
			Orders.StartRecordNumber = StartRec
		End If
	End Sub

	' -----------------------------------------------------------------
	'  Load basic search values
	'
	Function LoadBasicSearchValues()
		Orders.BasicSearch.Keyword = Request.QueryString(EW_TABLE_BASIC_SEARCH)&""
		If Orders.BasicSearch.Keyword <> "" Then Command = "search"
		Orders.BasicSearch.SearchType = Request.QueryString(EW_TABLE_BASIC_SEARCH_TYPE)&""
	End Function

	' -----------------------------------------------------------------
	' Load recordset
	'
	Function LoadRecordset()

		' Load list page sql
		Dim sSql
		sSql = Orders.SelectSQL
		Call ew_SetDebugMsg("LoadRecordset: " & sSql) ' Show SQL for debugging

		' Load recordset
		Dim RsRecordset
		Set RsRecordset = ew_LoadRecordset(sSql)

		' Call Recordset Selected event
		Call Orders.Recordset_Selected(RsRecordset)
		Set LoadRecordset = RsRecordset
	End Function

	' -----------------------------------------------------------------
	' Load row based on key values
	'
	Function LoadRow()
		Dim RsRow, sSql, sFilter
		sFilter = Orders.KeyFilter

		' Call Row Selecting event
		Call Orders.Row_Selecting(sFilter)

		' Load sql based on filter
		Orders.CurrentFilter = sFilter
		sSql = Orders.SQL
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
		Call Orders.Row_Selected(RsRow)
		Orders.ID.DbValue = RsRow("ID")
		Orders.CreationDate.DbValue = RsRow("CreationDate")
		Orders.OrderDate.DbValue = RsRow("OrderDate")
		Orders.DeliveryType.DbValue = RsRow("DeliveryType")
		Orders.DeliveryTime.DbValue = RsRow("DeliveryTime")
		Orders.PaymentType.DbValue = RsRow("PaymentType")
		Orders.SubTotal.DbValue = RsRow("SubTotal")
		Orders.ShippingFee.DbValue = RsRow("ShippingFee")
		Orders.OrderTotal.DbValue = RsRow("OrderTotal")
		Orders.IdBusinessDetail.DbValue = RsRow("IdBusinessDetail")
		Orders.SessionId.DbValue = RsRow("SessionId")
		Orders.FirstName.DbValue = RsRow("FirstName")
		Orders.LastName.DbValue = RsRow("LastName")
		Orders.zEmail.DbValue = RsRow("Email")
		Orders.Phone.DbValue = RsRow("Phone")
		Orders.Address.DbValue = RsRow("Address")
		Orders.PostalCode.DbValue = RsRow("PostalCode")
		Orders.Notes.DbValue = RsRow("Notes")
		Orders.ttest.DbValue = RsRow("ttest")
		Orders.cancelleddate.DbValue = RsRow("cancelleddate")
		Orders.cancelledby.DbValue = RsRow("cancelledby")
		Orders.cancelledreason.DbValue = RsRow("cancelledreason")
		Orders.acknowledgeddate.DbValue = RsRow("acknowledgeddate")
		Orders.delivereddate.DbValue = RsRow("delivereddate")
		Orders.cancelled.DbValue = RsRow("cancelled")
		Orders.acknowledged.DbValue = RsRow("acknowledged")
		Orders.outfordelivery.DbValue = RsRow("outfordelivery")
		Orders.vouchercodediscount.DbValue = RsRow("vouchercodediscount")
		Orders.vouchercode.DbValue = RsRow("vouchercode")
		Orders.printed.DbValue = RsRow("printed")
		Orders.deliverydistance.DbValue = RsRow("deliverydistance")
		Orders.asaporder.DbValue = RsRow("asaporder")
		Orders.DeliveryLat.DbValue = RsRow("DeliveryLat")
		Orders.DeliveryLng.DbValue = RsRow("DeliveryLng")
		Orders.ServiceCharge.DbValue = RsRow("ServiceCharge")
		Orders.PaymentSurcharge.DbValue = RsRow("PaymentSurcharge")
		Orders.FromIP.DbValue = RsRow("FromIP")
		Orders.SentEmail.DbValue = RsRow("SentEmail")
		Orders.Tax_Rate.DbValue = RsRow("Tax_Rate")
		Orders.Tax_Amount.DbValue = RsRow("Tax_Amount")
		Orders.Tip_Rate.DbValue = RsRow("Tip_Rate")
		Orders.Tip_Amount.DbValue = RsRow("Tip_Amount")
		Orders.Card_Debit.DbValue = RsRow("Card_Debit")
		Orders.Card_Credit.DbValue = RsRow("Card_Credit")
		Orders.deliverydelay.DbValue = RsRow("deliverydelay")
		Orders.collectiondelay.DbValue = RsRow("collectiondelay")
		Orders.lng_report.DbValue = RsRow("lng_report")
		Orders.lat_report.DbValue = RsRow("lat_report")
		Orders.Payment_status.DbValue = RsRow("Payment_status")
	End Sub

	' Load DbValue from recordset
	Sub LoadDbValues(Rs)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		If Rs.Eof Then Exit Sub
		Orders.ID.m_DbValue = Rs("ID")
		Orders.CreationDate.m_DbValue = Rs("CreationDate")
		Orders.OrderDate.m_DbValue = Rs("OrderDate")
		Orders.DeliveryType.m_DbValue = Rs("DeliveryType")
		Orders.DeliveryTime.m_DbValue = Rs("DeliveryTime")
		Orders.PaymentType.m_DbValue = Rs("PaymentType")
		Orders.SubTotal.m_DbValue = Rs("SubTotal")
		Orders.ShippingFee.m_DbValue = Rs("ShippingFee")
		Orders.OrderTotal.m_DbValue = Rs("OrderTotal")
		Orders.IdBusinessDetail.m_DbValue = Rs("IdBusinessDetail")
		Orders.SessionId.m_DbValue = Rs("SessionId")
		Orders.FirstName.m_DbValue = Rs("FirstName")
		Orders.LastName.m_DbValue = Rs("LastName")
		Orders.zEmail.m_DbValue = Rs("Email")
		Orders.Phone.m_DbValue = Rs("Phone")
		Orders.Address.m_DbValue = Rs("Address")
		Orders.PostalCode.m_DbValue = Rs("PostalCode")
		Orders.Notes.m_DbValue = Rs("Notes")
		Orders.ttest.m_DbValue = Rs("ttest")
		Orders.cancelleddate.m_DbValue = Rs("cancelleddate")
		Orders.cancelledby.m_DbValue = Rs("cancelledby")
		Orders.cancelledreason.m_DbValue = Rs("cancelledreason")
		Orders.acknowledgeddate.m_DbValue = Rs("acknowledgeddate")
		Orders.delivereddate.m_DbValue = Rs("delivereddate")
		Orders.cancelled.m_DbValue = Rs("cancelled")
		Orders.acknowledged.m_DbValue = Rs("acknowledged")
		Orders.outfordelivery.m_DbValue = Rs("outfordelivery")
		Orders.vouchercodediscount.m_DbValue = Rs("vouchercodediscount")
		Orders.vouchercode.m_DbValue = Rs("vouchercode")
		Orders.printed.m_DbValue = Rs("printed")
		Orders.deliverydistance.m_DbValue = Rs("deliverydistance")
		Orders.asaporder.m_DbValue = Rs("asaporder")
		Orders.DeliveryLat.m_DbValue = Rs("DeliveryLat")
		Orders.DeliveryLng.m_DbValue = Rs("DeliveryLng")
		Orders.ServiceCharge.m_DbValue = Rs("ServiceCharge")
		Orders.PaymentSurcharge.m_DbValue = Rs("PaymentSurcharge")
		Orders.FromIP.m_DbValue = Rs("FromIP")
		Orders.SentEmail.m_DbValue = Rs("SentEmail")
		Orders.Tax_Rate.m_DbValue = Rs("Tax_Rate")
		Orders.Tax_Amount.m_DbValue = Rs("Tax_Amount")
		Orders.Tip_Rate.m_DbValue = Rs("Tip_Rate")
		Orders.Tip_Amount.m_DbValue = Rs("Tip_Amount")
		Orders.Card_Debit.m_DbValue = Rs("Card_Debit")
		Orders.Card_Credit.m_DbValue = Rs("Card_Credit")
		Orders.deliverydelay.m_DbValue = Rs("deliverydelay")
		Orders.collectiondelay.m_DbValue = Rs("collectiondelay")
		Orders.lng_report.m_DbValue = Rs("lng_report")
		Orders.lat_report.m_DbValue = Rs("lat_report")
		Orders.Payment_status.m_DbValue = Rs("Payment_status")
	End Sub

	' Load old record
	Function LoadOldRecord()

		' Load key values from Session
		Dim bValidKey
		bValidKey = True
		If Orders.GetKey("ID")&"" <> "" Then
			Orders.ID.CurrentValue = Orders.GetKey("ID") ' ID
		Else
			bValidKey = False
		End If

		' Load old recordset
		If bValidKey Then
			Orders.CurrentFilter = Orders.KeyFilter
			Dim sSql
			sSql = Orders.SQL
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
		ViewUrl = Orders.ViewUrl("")
		EditUrl = Orders.EditUrl("")
		InlineEditUrl = Orders.InlineEditUrl
		CopyUrl = Orders.CopyUrl("")
		InlineCopyUrl = Orders.InlineCopyUrl
		DeleteUrl = Orders.DeleteUrl

		' Convert decimal values if posted back
		If Orders.SubTotal.FormValue = Orders.SubTotal.CurrentValue And IsNumeric(Orders.SubTotal.CurrentValue) Then
			Orders.SubTotal.CurrentValue = ew_StrToFloat(Orders.SubTotal.CurrentValue)
		End If

		' Convert decimal values if posted back
		If Orders.ShippingFee.FormValue = Orders.ShippingFee.CurrentValue And IsNumeric(Orders.ShippingFee.CurrentValue) Then
			Orders.ShippingFee.CurrentValue = ew_StrToFloat(Orders.ShippingFee.CurrentValue)
		End If

		' Convert decimal values if posted back
		If Orders.OrderTotal.FormValue = Orders.OrderTotal.CurrentValue And IsNumeric(Orders.OrderTotal.CurrentValue) Then
			Orders.OrderTotal.CurrentValue = ew_StrToFloat(Orders.OrderTotal.CurrentValue)
		End If

		' Convert decimal values if posted back
		If Orders.ServiceCharge.FormValue = Orders.ServiceCharge.CurrentValue And IsNumeric(Orders.ServiceCharge.CurrentValue) Then
			Orders.ServiceCharge.CurrentValue = ew_StrToFloat(Orders.ServiceCharge.CurrentValue)
		End If

		' Convert decimal values if posted back
		If Orders.PaymentSurcharge.FormValue = Orders.PaymentSurcharge.CurrentValue And IsNumeric(Orders.PaymentSurcharge.CurrentValue) Then
			Orders.PaymentSurcharge.CurrentValue = ew_StrToFloat(Orders.PaymentSurcharge.CurrentValue)
		End If

		' Convert decimal values if posted back
		If Orders.Tax_Amount.FormValue = Orders.Tax_Amount.CurrentValue And IsNumeric(Orders.Tax_Amount.CurrentValue) Then
			Orders.Tax_Amount.CurrentValue = ew_StrToFloat(Orders.Tax_Amount.CurrentValue)
		End If

		' Convert decimal values if posted back
		If Orders.Tip_Amount.FormValue = Orders.Tip_Amount.CurrentValue And IsNumeric(Orders.Tip_Amount.CurrentValue) Then
			Orders.Tip_Amount.CurrentValue = ew_StrToFloat(Orders.Tip_Amount.CurrentValue)
		End If

		' Call Row Rendering event
		Call Orders.Row_Rendering()

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
		' SentEmail
		' Tax_Rate
		' Tax_Amount
		' Tip_Rate
		' Tip_Amount
		' Card_Debit
		' Card_Credit
		' deliverydelay
		' collectiondelay
		' lng_report
		' lat_report
		' Payment_status
		' -----------
		'  View  Row
		' -----------

		If Orders.RowType = EW_ROWTYPE_VIEW Then ' View row

			' ID
			Orders.ID.ViewValue = Orders.ID.CurrentValue
			Orders.ID.ViewCustomAttributes = ""

			' CreationDate
			Orders.CreationDate.ViewValue = Orders.CreationDate.CurrentValue
			Orders.CreationDate.ViewCustomAttributes = ""

			' OrderDate
			Orders.OrderDate.ViewValue = Orders.OrderDate.CurrentValue
			Orders.OrderDate.ViewCustomAttributes = ""

			' DeliveryType
			Orders.DeliveryType.ViewValue = Orders.DeliveryType.CurrentValue
			Orders.DeliveryType.ViewCustomAttributes = ""

			' DeliveryTime
			Orders.DeliveryTime.ViewValue = Orders.DeliveryTime.CurrentValue
			Orders.DeliveryTime.ViewCustomAttributes = ""

			' PaymentType
			Orders.PaymentType.ViewValue = Orders.PaymentType.CurrentValue
			Orders.PaymentType.ViewCustomAttributes = ""

			' SubTotal
			Orders.SubTotal.ViewValue = Orders.SubTotal.CurrentValue
			Orders.SubTotal.ViewCustomAttributes = ""

			' ShippingFee
			Orders.ShippingFee.ViewValue = Orders.ShippingFee.CurrentValue
			Orders.ShippingFee.ViewCustomAttributes = ""

			' OrderTotal
			Orders.OrderTotal.ViewValue = Orders.OrderTotal.CurrentValue
			Orders.OrderTotal.ViewCustomAttributes = ""

			' IdBusinessDetail
			Orders.IdBusinessDetail.ViewValue = Orders.IdBusinessDetail.CurrentValue
			Orders.IdBusinessDetail.ViewCustomAttributes = ""

			' SessionId
			Orders.SessionId.ViewValue = Orders.SessionId.CurrentValue
			Orders.SessionId.ViewCustomAttributes = ""

			' FirstName
			Orders.FirstName.ViewValue = Orders.FirstName.CurrentValue
			Orders.FirstName.ViewCustomAttributes = ""

			' LastName
			Orders.LastName.ViewValue = Orders.LastName.CurrentValue
			Orders.LastName.ViewCustomAttributes = ""

			' Email
			Orders.zEmail.ViewValue = Orders.zEmail.CurrentValue
			Orders.zEmail.ViewCustomAttributes = ""

			' Phone
			Orders.Phone.ViewValue = Orders.Phone.CurrentValue
			Orders.Phone.ViewCustomAttributes = ""

			' Address
			Orders.Address.ViewValue = Orders.Address.CurrentValue
			Orders.Address.ViewCustomAttributes = ""

			' PostalCode
			Orders.PostalCode.ViewValue = Orders.PostalCode.CurrentValue
			Orders.PostalCode.ViewCustomAttributes = ""

			' ttest
			Orders.ttest.ViewValue = Orders.ttest.CurrentValue
			Orders.ttest.ViewCustomAttributes = ""

			' cancelleddate
			Orders.cancelleddate.ViewValue = Orders.cancelleddate.CurrentValue
			Orders.cancelleddate.ViewCustomAttributes = ""

			' cancelledby
			Orders.cancelledby.ViewValue = Orders.cancelledby.CurrentValue
			Orders.cancelledby.ViewCustomAttributes = ""

			' cancelledreason
			Orders.cancelledreason.ViewValue = Orders.cancelledreason.CurrentValue
			Orders.cancelledreason.ViewCustomAttributes = ""

			' acknowledgeddate
			Orders.acknowledgeddate.ViewValue = Orders.acknowledgeddate.CurrentValue
			Orders.acknowledgeddate.ViewCustomAttributes = ""

			' delivereddate
			Orders.delivereddate.ViewValue = Orders.delivereddate.CurrentValue
			Orders.delivereddate.ViewCustomAttributes = ""

			' cancelled
			Orders.cancelled.ViewValue = Orders.cancelled.CurrentValue
			Orders.cancelled.ViewCustomAttributes = ""

			' acknowledged
			Orders.acknowledged.ViewValue = Orders.acknowledged.CurrentValue
			Orders.acknowledged.ViewCustomAttributes = ""

			' outfordelivery
			Orders.outfordelivery.ViewValue = Orders.outfordelivery.CurrentValue
			Orders.outfordelivery.ViewCustomAttributes = ""

			' vouchercodediscount
			Orders.vouchercodediscount.ViewValue = Orders.vouchercodediscount.CurrentValue
			Orders.vouchercodediscount.ViewCustomAttributes = ""

			' vouchercode
			Orders.vouchercode.ViewValue = Orders.vouchercode.CurrentValue
			Orders.vouchercode.ViewCustomAttributes = ""

			' printed
			Orders.printed.ViewValue = Orders.printed.CurrentValue
			Orders.printed.ViewCustomAttributes = ""

			' deliverydistance
			Orders.deliverydistance.ViewValue = Orders.deliverydistance.CurrentValue
			Orders.deliverydistance.ViewCustomAttributes = ""

			' asaporder
			Orders.asaporder.ViewValue = Orders.asaporder.CurrentValue
			Orders.asaporder.ViewCustomAttributes = ""

			' DeliveryLat
			Orders.DeliveryLat.ViewValue = Orders.DeliveryLat.CurrentValue
			Orders.DeliveryLat.ViewCustomAttributes = ""

			' DeliveryLng
			Orders.DeliveryLng.ViewValue = Orders.DeliveryLng.CurrentValue
			Orders.DeliveryLng.ViewCustomAttributes = ""

			' ServiceCharge
			Orders.ServiceCharge.ViewValue = Orders.ServiceCharge.CurrentValue
			Orders.ServiceCharge.ViewCustomAttributes = ""

			' PaymentSurcharge
			Orders.PaymentSurcharge.ViewValue = Orders.PaymentSurcharge.CurrentValue
			Orders.PaymentSurcharge.ViewCustomAttributes = ""

			' FromIP
			Orders.FromIP.ViewValue = Orders.FromIP.CurrentValue
			Orders.FromIP.ViewCustomAttributes = ""

			' SentEmail
			Orders.SentEmail.ViewValue = Orders.SentEmail.CurrentValue
			Orders.SentEmail.ViewCustomAttributes = ""

			' Tax_Rate
			Orders.Tax_Rate.ViewValue = Orders.Tax_Rate.CurrentValue
			Orders.Tax_Rate.ViewCustomAttributes = ""

			' Tax_Amount
			Orders.Tax_Amount.ViewValue = Orders.Tax_Amount.CurrentValue
			Orders.Tax_Amount.ViewCustomAttributes = ""

			' Tip_Rate
			Orders.Tip_Rate.ViewValue = Orders.Tip_Rate.CurrentValue
			Orders.Tip_Rate.ViewCustomAttributes = ""

			' Tip_Amount
			Orders.Tip_Amount.ViewValue = Orders.Tip_Amount.CurrentValue
			Orders.Tip_Amount.ViewCustomAttributes = ""

			' Card_Debit
			Orders.Card_Debit.ViewValue = Orders.Card_Debit.CurrentValue
			Orders.Card_Debit.ViewCustomAttributes = ""

			' Card_Credit
			Orders.Card_Credit.ViewValue = Orders.Card_Credit.CurrentValue
			Orders.Card_Credit.ViewCustomAttributes = ""

			' deliverydelay
			Orders.deliverydelay.ViewValue = Orders.deliverydelay.CurrentValue
			Orders.deliverydelay.ViewCustomAttributes = ""

			' collectiondelay
			Orders.collectiondelay.ViewValue = Orders.collectiondelay.CurrentValue
			Orders.collectiondelay.ViewCustomAttributes = ""

			' lng_report
			Orders.lng_report.ViewValue = Orders.lng_report.CurrentValue
			Orders.lng_report.ViewCustomAttributes = ""

			' lat_report
			Orders.lat_report.ViewValue = Orders.lat_report.CurrentValue
			Orders.lat_report.ViewCustomAttributes = ""

			' Payment_status
			Orders.Payment_status.ViewValue = Orders.Payment_status.CurrentValue
			Orders.Payment_status.ViewCustomAttributes = ""

			' View refer script
			' ID

			Orders.ID.LinkCustomAttributes = ""
			Orders.ID.HrefValue = ""
			Orders.ID.TooltipValue = ""

			' CreationDate
			Orders.CreationDate.LinkCustomAttributes = ""
			Orders.CreationDate.HrefValue = ""
			Orders.CreationDate.TooltipValue = ""

			' OrderDate
			Orders.OrderDate.LinkCustomAttributes = ""
			Orders.OrderDate.HrefValue = ""
			Orders.OrderDate.TooltipValue = ""

			' DeliveryType
			Orders.DeliveryType.LinkCustomAttributes = ""
			Orders.DeliveryType.HrefValue = ""
			Orders.DeliveryType.TooltipValue = ""

			' DeliveryTime
			Orders.DeliveryTime.LinkCustomAttributes = ""
			Orders.DeliveryTime.HrefValue = ""
			Orders.DeliveryTime.TooltipValue = ""

			' PaymentType
			Orders.PaymentType.LinkCustomAttributes = ""
			Orders.PaymentType.HrefValue = ""
			Orders.PaymentType.TooltipValue = ""

			' SubTotal
			Orders.SubTotal.LinkCustomAttributes = ""
			Orders.SubTotal.HrefValue = ""
			Orders.SubTotal.TooltipValue = ""

			' ShippingFee
			Orders.ShippingFee.LinkCustomAttributes = ""
			Orders.ShippingFee.HrefValue = ""
			Orders.ShippingFee.TooltipValue = ""

			' OrderTotal
			Orders.OrderTotal.LinkCustomAttributes = ""
			Orders.OrderTotal.HrefValue = ""
			Orders.OrderTotal.TooltipValue = ""

			' IdBusinessDetail
			Orders.IdBusinessDetail.LinkCustomAttributes = ""
			Orders.IdBusinessDetail.HrefValue = ""
			Orders.IdBusinessDetail.TooltipValue = ""

			' SessionId
			Orders.SessionId.LinkCustomAttributes = ""
			Orders.SessionId.HrefValue = ""
			Orders.SessionId.TooltipValue = ""

			' FirstName
			Orders.FirstName.LinkCustomAttributes = ""
			Orders.FirstName.HrefValue = ""
			Orders.FirstName.TooltipValue = ""

			' LastName
			Orders.LastName.LinkCustomAttributes = ""
			Orders.LastName.HrefValue = ""
			Orders.LastName.TooltipValue = ""

			' Email
			Orders.zEmail.LinkCustomAttributes = ""
			Orders.zEmail.HrefValue = ""
			Orders.zEmail.TooltipValue = ""

			' Phone
			Orders.Phone.LinkCustomAttributes = ""
			Orders.Phone.HrefValue = ""
			Orders.Phone.TooltipValue = ""

			' Address
			Orders.Address.LinkCustomAttributes = ""
			Orders.Address.HrefValue = ""
			Orders.Address.TooltipValue = ""

			' PostalCode
			Orders.PostalCode.LinkCustomAttributes = ""
			Orders.PostalCode.HrefValue = ""
			Orders.PostalCode.TooltipValue = ""

			' ttest
			Orders.ttest.LinkCustomAttributes = ""
			Orders.ttest.HrefValue = ""
			Orders.ttest.TooltipValue = ""

			' cancelleddate
			Orders.cancelleddate.LinkCustomAttributes = ""
			Orders.cancelleddate.HrefValue = ""
			Orders.cancelleddate.TooltipValue = ""

			' cancelledby
			Orders.cancelledby.LinkCustomAttributes = ""
			Orders.cancelledby.HrefValue = ""
			Orders.cancelledby.TooltipValue = ""

			' cancelledreason
			Orders.cancelledreason.LinkCustomAttributes = ""
			Orders.cancelledreason.HrefValue = ""
			Orders.cancelledreason.TooltipValue = ""

			' acknowledgeddate
			Orders.acknowledgeddate.LinkCustomAttributes = ""
			Orders.acknowledgeddate.HrefValue = ""
			Orders.acknowledgeddate.TooltipValue = ""

			' delivereddate
			Orders.delivereddate.LinkCustomAttributes = ""
			Orders.delivereddate.HrefValue = ""
			Orders.delivereddate.TooltipValue = ""

			' cancelled
			Orders.cancelled.LinkCustomAttributes = ""
			Orders.cancelled.HrefValue = ""
			Orders.cancelled.TooltipValue = ""

			' acknowledged
			Orders.acknowledged.LinkCustomAttributes = ""
			Orders.acknowledged.HrefValue = ""
			Orders.acknowledged.TooltipValue = ""

			' outfordelivery
			Orders.outfordelivery.LinkCustomAttributes = ""
			Orders.outfordelivery.HrefValue = ""
			Orders.outfordelivery.TooltipValue = ""

			' vouchercodediscount
			Orders.vouchercodediscount.LinkCustomAttributes = ""
			Orders.vouchercodediscount.HrefValue = ""
			Orders.vouchercodediscount.TooltipValue = ""

			' vouchercode
			Orders.vouchercode.LinkCustomAttributes = ""
			Orders.vouchercode.HrefValue = ""
			Orders.vouchercode.TooltipValue = ""

			' printed
			Orders.printed.LinkCustomAttributes = ""
			Orders.printed.HrefValue = ""
			Orders.printed.TooltipValue = ""

			' deliverydistance
			Orders.deliverydistance.LinkCustomAttributes = ""
			Orders.deliverydistance.HrefValue = ""
			Orders.deliverydistance.TooltipValue = ""

			' asaporder
			Orders.asaporder.LinkCustomAttributes = ""
			Orders.asaporder.HrefValue = ""
			Orders.asaporder.TooltipValue = ""

			' DeliveryLat
			Orders.DeliveryLat.LinkCustomAttributes = ""
			Orders.DeliveryLat.HrefValue = ""
			Orders.DeliveryLat.TooltipValue = ""

			' DeliveryLng
			Orders.DeliveryLng.LinkCustomAttributes = ""
			Orders.DeliveryLng.HrefValue = ""
			Orders.DeliveryLng.TooltipValue = ""

			' ServiceCharge
			Orders.ServiceCharge.LinkCustomAttributes = ""
			Orders.ServiceCharge.HrefValue = ""
			Orders.ServiceCharge.TooltipValue = ""

			' PaymentSurcharge
			Orders.PaymentSurcharge.LinkCustomAttributes = ""
			Orders.PaymentSurcharge.HrefValue = ""
			Orders.PaymentSurcharge.TooltipValue = ""

			' FromIP
			Orders.FromIP.LinkCustomAttributes = ""
			Orders.FromIP.HrefValue = ""
			Orders.FromIP.TooltipValue = ""

			' SentEmail
			Orders.SentEmail.LinkCustomAttributes = ""
			Orders.SentEmail.HrefValue = ""
			Orders.SentEmail.TooltipValue = ""

			' Tax_Rate
			Orders.Tax_Rate.LinkCustomAttributes = ""
			Orders.Tax_Rate.HrefValue = ""
			Orders.Tax_Rate.TooltipValue = ""

			' Tax_Amount
			Orders.Tax_Amount.LinkCustomAttributes = ""
			Orders.Tax_Amount.HrefValue = ""
			Orders.Tax_Amount.TooltipValue = ""

			' Tip_Rate
			Orders.Tip_Rate.LinkCustomAttributes = ""
			Orders.Tip_Rate.HrefValue = ""
			Orders.Tip_Rate.TooltipValue = ""

			' Tip_Amount
			Orders.Tip_Amount.LinkCustomAttributes = ""
			Orders.Tip_Amount.HrefValue = ""
			Orders.Tip_Amount.TooltipValue = ""

			' Card_Debit
			Orders.Card_Debit.LinkCustomAttributes = ""
			Orders.Card_Debit.HrefValue = ""
			Orders.Card_Debit.TooltipValue = ""

			' Card_Credit
			Orders.Card_Credit.LinkCustomAttributes = ""
			Orders.Card_Credit.HrefValue = ""
			Orders.Card_Credit.TooltipValue = ""

			' deliverydelay
			Orders.deliverydelay.LinkCustomAttributes = ""
			Orders.deliverydelay.HrefValue = ""
			Orders.deliverydelay.TooltipValue = ""

			' collectiondelay
			Orders.collectiondelay.LinkCustomAttributes = ""
			Orders.collectiondelay.HrefValue = ""
			Orders.collectiondelay.TooltipValue = ""

			' lng_report
			Orders.lng_report.LinkCustomAttributes = ""
			Orders.lng_report.HrefValue = ""
			Orders.lng_report.TooltipValue = ""

			' lat_report
			Orders.lat_report.LinkCustomAttributes = ""
			Orders.lat_report.HrefValue = ""
			Orders.lat_report.TooltipValue = ""

			' Payment_status
			Orders.Payment_status.LinkCustomAttributes = ""
			Orders.Payment_status.HrefValue = ""
			Orders.Payment_status.TooltipValue = ""
		End If

		' Call Row Rendered event
		If Orders.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call Orders.Row_Rendered()
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
			item.Body = "<a href=""javascript:void(0);"" class=""ewExportLink ewPdf"" title=""" & ew_HtmlEncode(Language.Phrase("ExportToPDFText")) & """ data-caption=""" & ew_HtmlEncode(Language.Phrase("ExportToPDFText")) & """ onclick=""ew_Export(document.fOrderslist,'" & ExportPdfUrl & "','pdf',true);"">" & Language.Phrase("ExportToPDF") & "</a>"
		Else
			item.Body = "<a href=""" & ExportPdfUrl & """ class=""ewExportLink ewPdf"" title=""" & ew_HtmlEncode(Language.Phrase("ExportToPDFText")) & """ data-caption=""" & ew_HtmlEncode(Language.Phrase("ExportToPDFText")) & """>" & Language.Phrase("ExportToPDF") & "</a>"
		End If
		item.Visible = False

		' Export to Email
		ExportOptions.Add("email")
		Set item = ExportOptions.GetItem("email")
		url = ew_IIf(ExportEmailCustom, ",url:'" & PageUrl & "export=email&amp;custom=1'", "")
		item.Body = "<button id=""emf_Orders"" class=""ewExportLink ewEmail"" title=""" & Language.Phrase("ExportToEmailText") & """ data-caption=""" & Language.Phrase("ExportToEmailText") & """ onclick=""ew_EmailDialogShow({lnk:'emf_Orders',hdr:ewLanguage.Phrase('ExportToEmailText'),f:document.fOrderslist,sel:false" & url & "});"">" & Language.Phrase("ExportToEmail") & "</button>"
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
		If Orders.ExportAll Then
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
		If Orders.Export = "xml" Then
			Set XmlDoc = New cXMLDocument
		Else
			Set Orders.ExportDoc = New cExportDocument
			Set Doc = Orders.ExportDoc
			Set Doc.Table = Orders
			Call Doc.ChangeStyle("h")

			' Call Page Exporting server event
			Doc.ExportCustom = (Not Page_Exporting())
		End If
		Dim rsdetail, detailcnt
		Dim ParentTable
		ParentTable = ""
		If Orders.Export = "xml" Then
			Call Orders.ExportXmlDocument(XmlDoc, (ParentTable <> ""), rs, StartRec, StopRec, "")
		Else
			Dim sHeader
			sHeader = PageHeader
			Call Page_DataRendering(sHeader)
			Doc.Text = Doc.Text & sHeader
			Call Orders.ExportDocument(Doc, rs, StartRec, StopRec, "")
			Dim sFooter
			sFooter = PageFooter
			Call Page_DataRendered(sFooter)
			Doc.Text = Doc.Text & sFooter
		End If

		' Close recordset and connection
		Rs.Close
		Set Rs = Nothing

		' Export header and footer
		If Orders.Export <> "xml" Then
			Call Doc.ExportHeaderAndFooter()

			' Call Page Exported server event
			Call Page_Exported()
		End If
		If Orders.Export = "xml" Then
			XmlDoc.Output
			Set XmlDoc = Nothing
		Else
			If Orders.Export = "email" Then
				Response.Write ExportEmail(Doc.Text)
			ElseIf Orders.Export = "pdf" Then
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
		Call Breadcrumb.Add("list", Orders.TableVar, url, "", Orders.TableVar, True)
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
