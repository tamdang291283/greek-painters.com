<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="OrdersLocalinfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim OrdersLocal_list
Set OrdersLocal_list = New cOrdersLocal_list
Set Page = OrdersLocal_list

' Page init processing
OrdersLocal_list.Page_Init()

' Page main processing
OrdersLocal_list.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
OrdersLocal_list.Page_Render()
%>
<!--#include file="header.asp"-->
<% If OrdersLocal.Export = "" Then %>
<script type="text/javascript">
// Page object
var OrdersLocal_list = new ew_Page("OrdersLocal_list");
OrdersLocal_list.PageID = "list"; // Page ID
var EW_PAGE_ID = OrdersLocal_list.PageID; // For backward compatibility
// Form object
var fOrdersLocallist = new ew_Form("fOrdersLocallist");
fOrdersLocallist.FormKeyCountName = '<%= OrdersLocal_list.FormKeyCountName %>';
// Form_CustomValidate event
fOrdersLocallist.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fOrdersLocallist.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fOrdersLocallist.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
var fOrdersLocallistsrch = new ew_Form("fOrdersLocallistsrch");
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
<% If OrdersLocal.Export = "" Then %>
<div class="ewToolbar">
<% If OrdersLocal.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If OrdersLocal_list.TotalRecs > 0 And OrdersLocal_list.ExportOptions.Visible Then %>
<% OrdersLocal_list.ExportOptions.Render "body", "", "", "", "", "" %>
<% End If %>
<% If OrdersLocal_list.SearchOptions.Visible Then %>
<% OrdersLocal_list.SearchOptions.Render "body", "", "", "", "", "" %>
<% End If %>
<% If OrdersLocal.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% End If %>
<% If (OrdersLocal.Export = "") Or (EW_EXPORT_MASTER_RECORD And OrdersLocal.Export = "print") Then %>
<% End If %>
<%

' Load recordset
'Set OrdersLocal_list.Recordset = OrdersLocal_list.LoadRecordset()

	OrdersLocal_list.TotalRecs = OrdersLocal_list.Recordset.RecordCount
	OrdersLocal_list.StartRec = 1
	If OrdersLocal_list.DisplayRecs <= 0 Then ' Display all records
		OrdersLocal_list.DisplayRecs = OrdersLocal_list.TotalRecs
	End If
	If Not (OrdersLocal.ExportAll And OrdersLocal.Export <> "") Then
		OrdersLocal_list.SetUpStartRec() ' Set up start record position
	End If

	' Set no record found message
	If OrdersLocal.CurrentAction = "" And OrdersLocal_list.TotalRecs = 0 Then
		If OrdersLocal_list.SearchWhere = "0=101" Then
			OrdersLocal_list.WarningMessage = Language.Phrase("EnterSearchCriteria")
		Else
			OrdersLocal_list.WarningMessage = Language.Phrase("NoRecord")
		End If
	End If
OrdersLocal_list.RenderOtherOptions()
%>
<% If OrdersLocal.Export = "" And OrdersLocal.CurrentAction = "" Then %>
<form name="fOrdersLocallistsrch" id="fOrdersLocallistsrch" class="form-inline ewForm" action="<%= ew_CurrentPage %>">
<% SearchPanelClass = ew_IIf(OrdersLocal_list.SearchWhere <> "", " in", " in") %>
<div id="fOrdersLocallistsrch_SearchPanel" class="ewSearchPanel collapse<%= SearchPanelClass %>">
<input type="hidden" name="cmd" value="search">
<input type="hidden" name="t" value="OrdersLocal">
	<div class="ewBasicSearch">
<div id="xsr_1" class="ewRow">
	<div class="ewQuickSearch input-group">
	<input type="text" name="<%= EW_TABLE_BASIC_SEARCH %>" id="<%= EW_TABLE_BASIC_SEARCH %>" class="form-control" value="<%= ew_HtmlEncode(OrdersLocal.BasicSearch.getKeyword()) %>" placeholder="<%= ew_HtmlEncode(Language.Phrase("Search")) %>">
	<input type="hidden" name="<%= EW_TABLE_BASIC_SEARCH_TYPE %>" id="<%= EW_TABLE_BASIC_SEARCH_TYPE %>" value="<%= ew_HtmlEncode(OrdersLocal.BasicSearch.getSearchType()) %>">
	<div class="input-group-btn">
		<button type="button" data-toggle="dropdown" class="btn btn-default"><span id="searchtype"><%= OrdersLocal.BasicSearch.getSearchTypeNameShort() %></span><span class="caret"></span></button>
		<ul class="dropdown-menu pull-right" role="menu">
			<li<% If OrdersLocal.BasicSearch.getSearchType() = "" Then Response.Write " class=""active""" %>><a href="javascript:void(0);" onclick="ew_SetSearchType(this)"><%= Language.Phrase("QuickSearchAuto") %></a></li>
			<li<% If OrdersLocal.BasicSearch.getSearchType() = "=" Then Response.Write " class=""active""" %>><a href="javascript:void(0);" onclick="ew_SetSearchType(this,'=')"><%= Language.Phrase("QuickSearchExact") %></a></li>
			<li<% If OrdersLocal.BasicSearch.getSearchType() = "AND" Then Response.Write " class=""active""" %>><a href="javascript:void(0);" onclick="ew_SetSearchType(this,'AND')"><%= Language.Phrase("QuickSearchAll") %></a></li>
			<li<% If OrdersLocal.BasicSearch.getSearchType() = "OR" Then Response.Write " class=""active""" %>><a href="javascript:void(0);" onclick="ew_SetSearchType(this,'OR')"><%= Language.Phrase("QuickSearchAny") %></a></li>
		</ul>
	<button class="btn btn-primary ewButton" name="btnsubmit" id="btnsubmit" type="submit"><%= Language.Phrase("QuickSearchBtn") %></button>
	</div>
	</div>
</div>
	</div>
</div>
</form>
<% End If %>
<% OrdersLocal_list.ShowPageHeader() %>
<% OrdersLocal_list.ShowMessage %>
<% If OrdersLocal_list.TotalRecs > 0 Or OrdersLocal.CurrentAction <> "" Then %>
<div class="ewGrid">
<% If OrdersLocal.Export = "" Then %>
<div class="ewGridUpperPanel">
<% If OrdersLocal.CurrentAction <> "gridadd" And OrdersLocal.CurrentAction <> "gridedit" Then %>
<form name="ewPagerForm" class="form-inline ewForm ewPagerForm" action="<%= ew_CurrentPage %>">
<% If Not IsObject(OrdersLocal_list.Pager) Then Set OrdersLocal_list.Pager = ew_NewPrevNextPager(OrdersLocal_list.StartRec, OrdersLocal_list.DisplayRecs, OrdersLocal_list.TotalRecs) %>
<% If OrdersLocal_list.Pager.RecordCount > 0 Then %>
<div class="ewPager">
<span><%= Language.Phrase("Page") %>&nbsp;</span>
<div class="ewPrevNext"><div class="input-group">
<div class="input-group-btn">
<!--first page button-->
	<% If OrdersLocal_list.Pager.FirstButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerFirst") %>" href="<%= OrdersLocal_list.PageUrl %>start=<%= OrdersLocal_list.Pager.FirstButton.Start %>"><span class="icon-first ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerFirst") %>"><span class="icon-first ewIcon"></span></a>
	<% End If %>
<!--previous page button-->
	<% If OrdersLocal_list.Pager.PrevButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerPrevious") %>" href="<%= OrdersLocal_list.PageUrl %>start=<%= OrdersLocal_list.Pager.PrevButton.Start %>"><span class="icon-prev ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerPrevious") %>"><span class="icon-prev ewIcon"></span></a>
	<% End If %>
</div>
<!--current page number-->
	<input class="form-control input-sm" type="text" name="<%= EW_TABLE_PAGE_NO %>" value="<%= OrdersLocal_list.Pager.CurrentPage %>">
<div class="input-group-btn">
<!--next page button-->
	<% If OrdersLocal_list.Pager.NextButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerNext") %>" href="<%= OrdersLocal_list.PageUrl %>start=<%= OrdersLocal_list.Pager.NextButton.Start %>"><span class="icon-next ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerNext") %>"><span class="icon-next ewIcon"></span></a>
	<% End If %>
<!--last page button-->
	<% If OrdersLocal_list.Pager.LastButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerLast") %>" href="<%= OrdersLocal_list.PageUrl %>start=<%= OrdersLocal_list.Pager.LastButton.Start %>"><span class="icon-last ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerLast") %>"><span class="icon-last ewIcon"></span></a>
	<% End If %>
</div>
</div>
</div>
<span>&nbsp;<%= Language.Phrase("of") %>&nbsp;<%= OrdersLocal_list.Pager.PageCount %></span>
</div>
<div class="ewPager ewRec">
	<span><%= Language.Phrase("Record") %>&nbsp;<%= OrdersLocal_list.Pager.FromIndex %>&nbsp;<%= Language.Phrase("To") %>&nbsp;<%= OrdersLocal_list.Pager.ToIndex %>&nbsp;<%= Language.Phrase("Of") %>&nbsp;<%= OrdersLocal_list.Pager.RecordCount %></span>
</div>
<% End If %>
<% If OrdersLocal_list.TotalRecs > 0 Then %>
<div class="ewPager">
<input type="hidden" name="t" value="OrdersLocal">
<select name="<%= EW_TABLE_REC_PER_PAGE %>" class="form-control input-sm" onchange="this.form.submit();">
<option value="20"<% If OrdersLocal_list.DisplayRecs = 20 Then %> selected="selected"<% End If %>>20</option>
<option value="50"<% If OrdersLocal_list.DisplayRecs = 50 Then %> selected="selected"<% End If %>>50</option>
<option value="100"<% If OrdersLocal_list.DisplayRecs = 100 Then %> selected="selected"<% End If %>>100</option>
<option value="500"<% If OrdersLocal_list.DisplayRecs = 500 Then %> selected="selected"<% End If %>>500</option>
<option value="1000"<% If OrdersLocal_list.DisplayRecs = 1000 Then %> selected="selected"<% End If %>>1000</option>
<option value="ALL"<% If OrdersLocal.RecordsPerPage = -1 Then %> selected="selected"<% End If %>><%= Language.Phrase("AllRecords") %></option>
</select>
</div>
<% End If %>
</form>
<% End If %>
<div class="ewListOtherOptions">
<%
	OrdersLocal_list.AddEditOptions.Render "body", "", "", "", "", ""
	OrdersLocal_list.DetailOptions.Render "body", "", "", "", "", ""
	OrdersLocal_list.ActionOptions.Render "body", "", "", "", "", ""
%>
</div>
<div class="clearfix"></div>
</div>
<% End If %>
<form name="fOrdersLocallist" id="fOrdersLocallist" class="form-inline ewForm ewListForm" action="<%= ew_CurrentPage %>" method="post">
<% If OrdersLocal_list.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= OrdersLocal_list.Token %>">
<% End If %>
<input type="hidden" name="t" value="OrdersLocal">
<div id="gmp_OrdersLocal" class="<% If ew_IsResponsiveLayout() Then Response.Write "table-responsive " %>ewGridMiddlePanel">
<% If OrdersLocal_list.TotalRecs > 0 Then %>
<table id="tbl_OrdersLocallist" class="table ewTable">
<%= OrdersLocal.TableCustomInnerHtml %>
<thead><!-- Table header -->
	<tr class="ewTableHeader">
<%

' Header row
OrdersLocal.RowType = EW_ROWTYPE_HEADER
Call OrdersLocal_list.RenderListOptions()

' Render list options (header, left)
OrdersLocal_list.ListOptions.Render "header", "left", "", "", "", ""
%>
<% If OrdersLocal.ID.Visible Then ' ID %>
	<% If OrdersLocal.SortUrl(OrdersLocal.ID) = "" Then %>
		<th data-name="ID"><div id="elh_OrdersLocal_ID" class="OrdersLocal_ID"><div class="ewTableHeaderCaption"><%= OrdersLocal.ID.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="ID"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrdersLocal.SortUrl(OrdersLocal.ID) %>',1);"><div id="elh_OrdersLocal_ID" class="OrdersLocal_ID">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrdersLocal.ID.FldCaption %></span><span class="ewTableHeaderSort"><% If OrdersLocal.ID.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrdersLocal.ID.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrdersLocal.CreationDate.Visible Then ' CreationDate %>
	<% If OrdersLocal.SortUrl(OrdersLocal.CreationDate) = "" Then %>
		<th data-name="CreationDate"><div id="elh_OrdersLocal_CreationDate" class="OrdersLocal_CreationDate"><div class="ewTableHeaderCaption"><%= OrdersLocal.CreationDate.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="CreationDate"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrdersLocal.SortUrl(OrdersLocal.CreationDate) %>',1);"><div id="elh_OrdersLocal_CreationDate" class="OrdersLocal_CreationDate">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrdersLocal.CreationDate.FldCaption %></span><span class="ewTableHeaderSort"><% If OrdersLocal.CreationDate.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrdersLocal.CreationDate.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrdersLocal.OrderDate.Visible Then ' OrderDate %>
	<% If OrdersLocal.SortUrl(OrdersLocal.OrderDate) = "" Then %>
		<th data-name="OrderDate"><div id="elh_OrdersLocal_OrderDate" class="OrdersLocal_OrderDate"><div class="ewTableHeaderCaption"><%= OrdersLocal.OrderDate.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="OrderDate"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrdersLocal.SortUrl(OrdersLocal.OrderDate) %>',1);"><div id="elh_OrdersLocal_OrderDate" class="OrdersLocal_OrderDate">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrdersLocal.OrderDate.FldCaption %></span><span class="ewTableHeaderSort"><% If OrdersLocal.OrderDate.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrdersLocal.OrderDate.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrdersLocal.DeliveryType.Visible Then ' DeliveryType %>
	<% If OrdersLocal.SortUrl(OrdersLocal.DeliveryType) = "" Then %>
		<th data-name="DeliveryType"><div id="elh_OrdersLocal_DeliveryType" class="OrdersLocal_DeliveryType"><div class="ewTableHeaderCaption"><%= OrdersLocal.DeliveryType.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="DeliveryType"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrdersLocal.SortUrl(OrdersLocal.DeliveryType) %>',1);"><div id="elh_OrdersLocal_DeliveryType" class="OrdersLocal_DeliveryType">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrdersLocal.DeliveryType.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If OrdersLocal.DeliveryType.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrdersLocal.DeliveryType.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrdersLocal.DeliveryTime.Visible Then ' DeliveryTime %>
	<% If OrdersLocal.SortUrl(OrdersLocal.DeliveryTime) = "" Then %>
		<th data-name="DeliveryTime"><div id="elh_OrdersLocal_DeliveryTime" class="OrdersLocal_DeliveryTime"><div class="ewTableHeaderCaption"><%= OrdersLocal.DeliveryTime.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="DeliveryTime"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrdersLocal.SortUrl(OrdersLocal.DeliveryTime) %>',1);"><div id="elh_OrdersLocal_DeliveryTime" class="OrdersLocal_DeliveryTime">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrdersLocal.DeliveryTime.FldCaption %></span><span class="ewTableHeaderSort"><% If OrdersLocal.DeliveryTime.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrdersLocal.DeliveryTime.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrdersLocal.PaymentType.Visible Then ' PaymentType %>
	<% If OrdersLocal.SortUrl(OrdersLocal.PaymentType) = "" Then %>
		<th data-name="PaymentType"><div id="elh_OrdersLocal_PaymentType" class="OrdersLocal_PaymentType"><div class="ewTableHeaderCaption"><%= OrdersLocal.PaymentType.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="PaymentType"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrdersLocal.SortUrl(OrdersLocal.PaymentType) %>',1);"><div id="elh_OrdersLocal_PaymentType" class="OrdersLocal_PaymentType">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrdersLocal.PaymentType.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If OrdersLocal.PaymentType.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrdersLocal.PaymentType.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrdersLocal.SubTotal.Visible Then ' SubTotal %>
	<% If OrdersLocal.SortUrl(OrdersLocal.SubTotal) = "" Then %>
		<th data-name="SubTotal"><div id="elh_OrdersLocal_SubTotal" class="OrdersLocal_SubTotal"><div class="ewTableHeaderCaption"><%= OrdersLocal.SubTotal.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="SubTotal"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrdersLocal.SortUrl(OrdersLocal.SubTotal) %>',1);"><div id="elh_OrdersLocal_SubTotal" class="OrdersLocal_SubTotal">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrdersLocal.SubTotal.FldCaption %></span><span class="ewTableHeaderSort"><% If OrdersLocal.SubTotal.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrdersLocal.SubTotal.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrdersLocal.ShippingFee.Visible Then ' ShippingFee %>
	<% If OrdersLocal.SortUrl(OrdersLocal.ShippingFee) = "" Then %>
		<th data-name="ShippingFee"><div id="elh_OrdersLocal_ShippingFee" class="OrdersLocal_ShippingFee"><div class="ewTableHeaderCaption"><%= OrdersLocal.ShippingFee.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="ShippingFee"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrdersLocal.SortUrl(OrdersLocal.ShippingFee) %>',1);"><div id="elh_OrdersLocal_ShippingFee" class="OrdersLocal_ShippingFee">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrdersLocal.ShippingFee.FldCaption %></span><span class="ewTableHeaderSort"><% If OrdersLocal.ShippingFee.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrdersLocal.ShippingFee.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrdersLocal.OrderTotal.Visible Then ' OrderTotal %>
	<% If OrdersLocal.SortUrl(OrdersLocal.OrderTotal) = "" Then %>
		<th data-name="OrderTotal"><div id="elh_OrdersLocal_OrderTotal" class="OrdersLocal_OrderTotal"><div class="ewTableHeaderCaption"><%= OrdersLocal.OrderTotal.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="OrderTotal"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrdersLocal.SortUrl(OrdersLocal.OrderTotal) %>',1);"><div id="elh_OrdersLocal_OrderTotal" class="OrdersLocal_OrderTotal">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrdersLocal.OrderTotal.FldCaption %></span><span class="ewTableHeaderSort"><% If OrdersLocal.OrderTotal.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrdersLocal.OrderTotal.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrdersLocal.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
	<% If OrdersLocal.SortUrl(OrdersLocal.IdBusinessDetail) = "" Then %>
		<th data-name="IdBusinessDetail"><div id="elh_OrdersLocal_IdBusinessDetail" class="OrdersLocal_IdBusinessDetail"><div class="ewTableHeaderCaption"><%= OrdersLocal.IdBusinessDetail.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="IdBusinessDetail"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrdersLocal.SortUrl(OrdersLocal.IdBusinessDetail) %>',1);"><div id="elh_OrdersLocal_IdBusinessDetail" class="OrdersLocal_IdBusinessDetail">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrdersLocal.IdBusinessDetail.FldCaption %></span><span class="ewTableHeaderSort"><% If OrdersLocal.IdBusinessDetail.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrdersLocal.IdBusinessDetail.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrdersLocal.SessionId.Visible Then ' SessionId %>
	<% If OrdersLocal.SortUrl(OrdersLocal.SessionId) = "" Then %>
		<th data-name="SessionId"><div id="elh_OrdersLocal_SessionId" class="OrdersLocal_SessionId"><div class="ewTableHeaderCaption"><%= OrdersLocal.SessionId.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="SessionId"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrdersLocal.SortUrl(OrdersLocal.SessionId) %>',1);"><div id="elh_OrdersLocal_SessionId" class="OrdersLocal_SessionId">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrdersLocal.SessionId.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If OrdersLocal.SessionId.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrdersLocal.SessionId.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrdersLocal.FirstName.Visible Then ' FirstName %>
	<% If OrdersLocal.SortUrl(OrdersLocal.FirstName) = "" Then %>
		<th data-name="FirstName"><div id="elh_OrdersLocal_FirstName" class="OrdersLocal_FirstName"><div class="ewTableHeaderCaption"><%= OrdersLocal.FirstName.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="FirstName"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrdersLocal.SortUrl(OrdersLocal.FirstName) %>',1);"><div id="elh_OrdersLocal_FirstName" class="OrdersLocal_FirstName">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrdersLocal.FirstName.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If OrdersLocal.FirstName.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrdersLocal.FirstName.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrdersLocal.LastName.Visible Then ' LastName %>
	<% If OrdersLocal.SortUrl(OrdersLocal.LastName) = "" Then %>
		<th data-name="LastName"><div id="elh_OrdersLocal_LastName" class="OrdersLocal_LastName"><div class="ewTableHeaderCaption"><%= OrdersLocal.LastName.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="LastName"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrdersLocal.SortUrl(OrdersLocal.LastName) %>',1);"><div id="elh_OrdersLocal_LastName" class="OrdersLocal_LastName">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrdersLocal.LastName.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If OrdersLocal.LastName.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrdersLocal.LastName.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrdersLocal.zEmail.Visible Then ' Email %>
	<% If OrdersLocal.SortUrl(OrdersLocal.zEmail) = "" Then %>
		<th data-name="zEmail"><div id="elh_OrdersLocal_zEmail" class="OrdersLocal_zEmail"><div class="ewTableHeaderCaption"><%= OrdersLocal.zEmail.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="zEmail"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrdersLocal.SortUrl(OrdersLocal.zEmail) %>',1);"><div id="elh_OrdersLocal_zEmail" class="OrdersLocal_zEmail">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrdersLocal.zEmail.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If OrdersLocal.zEmail.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrdersLocal.zEmail.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrdersLocal.Phone.Visible Then ' Phone %>
	<% If OrdersLocal.SortUrl(OrdersLocal.Phone) = "" Then %>
		<th data-name="Phone"><div id="elh_OrdersLocal_Phone" class="OrdersLocal_Phone"><div class="ewTableHeaderCaption"><%= OrdersLocal.Phone.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Phone"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrdersLocal.SortUrl(OrdersLocal.Phone) %>',1);"><div id="elh_OrdersLocal_Phone" class="OrdersLocal_Phone">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrdersLocal.Phone.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If OrdersLocal.Phone.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrdersLocal.Phone.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrdersLocal.Address.Visible Then ' Address %>
	<% If OrdersLocal.SortUrl(OrdersLocal.Address) = "" Then %>
		<th data-name="Address"><div id="elh_OrdersLocal_Address" class="OrdersLocal_Address"><div class="ewTableHeaderCaption"><%= OrdersLocal.Address.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Address"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrdersLocal.SortUrl(OrdersLocal.Address) %>',1);"><div id="elh_OrdersLocal_Address" class="OrdersLocal_Address">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrdersLocal.Address.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If OrdersLocal.Address.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrdersLocal.Address.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrdersLocal.PostalCode.Visible Then ' PostalCode %>
	<% If OrdersLocal.SortUrl(OrdersLocal.PostalCode) = "" Then %>
		<th data-name="PostalCode"><div id="elh_OrdersLocal_PostalCode" class="OrdersLocal_PostalCode"><div class="ewTableHeaderCaption"><%= OrdersLocal.PostalCode.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="PostalCode"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrdersLocal.SortUrl(OrdersLocal.PostalCode) %>',1);"><div id="elh_OrdersLocal_PostalCode" class="OrdersLocal_PostalCode">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrdersLocal.PostalCode.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If OrdersLocal.PostalCode.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrdersLocal.PostalCode.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrdersLocal.Notes.Visible Then ' Notes %>
	<% If OrdersLocal.SortUrl(OrdersLocal.Notes) = "" Then %>
		<th data-name="Notes"><div id="elh_OrdersLocal_Notes" class="OrdersLocal_Notes"><div class="ewTableHeaderCaption"><%= OrdersLocal.Notes.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Notes"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrdersLocal.SortUrl(OrdersLocal.Notes) %>',1);"><div id="elh_OrdersLocal_Notes" class="OrdersLocal_Notes">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrdersLocal.Notes.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If OrdersLocal.Notes.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrdersLocal.Notes.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrdersLocal.ttest.Visible Then ' ttest %>
	<% If OrdersLocal.SortUrl(OrdersLocal.ttest) = "" Then %>
		<th data-name="ttest"><div id="elh_OrdersLocal_ttest" class="OrdersLocal_ttest"><div class="ewTableHeaderCaption"><%= OrdersLocal.ttest.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="ttest"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrdersLocal.SortUrl(OrdersLocal.ttest) %>',1);"><div id="elh_OrdersLocal_ttest" class="OrdersLocal_ttest">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrdersLocal.ttest.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If OrdersLocal.ttest.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrdersLocal.ttest.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrdersLocal.cancelleddate.Visible Then ' cancelleddate %>
	<% If OrdersLocal.SortUrl(OrdersLocal.cancelleddate) = "" Then %>
		<th data-name="cancelleddate"><div id="elh_OrdersLocal_cancelleddate" class="OrdersLocal_cancelleddate"><div class="ewTableHeaderCaption"><%= OrdersLocal.cancelleddate.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="cancelleddate"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrdersLocal.SortUrl(OrdersLocal.cancelleddate) %>',1);"><div id="elh_OrdersLocal_cancelleddate" class="OrdersLocal_cancelleddate">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrdersLocal.cancelleddate.FldCaption %></span><span class="ewTableHeaderSort"><% If OrdersLocal.cancelleddate.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrdersLocal.cancelleddate.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrdersLocal.cancelledby.Visible Then ' cancelledby %>
	<% If OrdersLocal.SortUrl(OrdersLocal.cancelledby) = "" Then %>
		<th data-name="cancelledby"><div id="elh_OrdersLocal_cancelledby" class="OrdersLocal_cancelledby"><div class="ewTableHeaderCaption"><%= OrdersLocal.cancelledby.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="cancelledby"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrdersLocal.SortUrl(OrdersLocal.cancelledby) %>',1);"><div id="elh_OrdersLocal_cancelledby" class="OrdersLocal_cancelledby">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrdersLocal.cancelledby.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If OrdersLocal.cancelledby.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrdersLocal.cancelledby.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrdersLocal.cancelledreason.Visible Then ' cancelledreason %>
	<% If OrdersLocal.SortUrl(OrdersLocal.cancelledreason) = "" Then %>
		<th data-name="cancelledreason"><div id="elh_OrdersLocal_cancelledreason" class="OrdersLocal_cancelledreason"><div class="ewTableHeaderCaption"><%= OrdersLocal.cancelledreason.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="cancelledreason"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrdersLocal.SortUrl(OrdersLocal.cancelledreason) %>',1);"><div id="elh_OrdersLocal_cancelledreason" class="OrdersLocal_cancelledreason">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrdersLocal.cancelledreason.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If OrdersLocal.cancelledreason.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrdersLocal.cancelledreason.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrdersLocal.acknowledgeddate.Visible Then ' acknowledgeddate %>
	<% If OrdersLocal.SortUrl(OrdersLocal.acknowledgeddate) = "" Then %>
		<th data-name="acknowledgeddate"><div id="elh_OrdersLocal_acknowledgeddate" class="OrdersLocal_acknowledgeddate"><div class="ewTableHeaderCaption"><%= OrdersLocal.acknowledgeddate.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="acknowledgeddate"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrdersLocal.SortUrl(OrdersLocal.acknowledgeddate) %>',1);"><div id="elh_OrdersLocal_acknowledgeddate" class="OrdersLocal_acknowledgeddate">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrdersLocal.acknowledgeddate.FldCaption %></span><span class="ewTableHeaderSort"><% If OrdersLocal.acknowledgeddate.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrdersLocal.acknowledgeddate.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrdersLocal.delivereddate.Visible Then ' delivereddate %>
	<% If OrdersLocal.SortUrl(OrdersLocal.delivereddate) = "" Then %>
		<th data-name="delivereddate"><div id="elh_OrdersLocal_delivereddate" class="OrdersLocal_delivereddate"><div class="ewTableHeaderCaption"><%= OrdersLocal.delivereddate.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="delivereddate"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrdersLocal.SortUrl(OrdersLocal.delivereddate) %>',1);"><div id="elh_OrdersLocal_delivereddate" class="OrdersLocal_delivereddate">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrdersLocal.delivereddate.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If OrdersLocal.delivereddate.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrdersLocal.delivereddate.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrdersLocal.cancelled.Visible Then ' cancelled %>
	<% If OrdersLocal.SortUrl(OrdersLocal.cancelled) = "" Then %>
		<th data-name="cancelled"><div id="elh_OrdersLocal_cancelled" class="OrdersLocal_cancelled"><div class="ewTableHeaderCaption"><%= OrdersLocal.cancelled.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="cancelled"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrdersLocal.SortUrl(OrdersLocal.cancelled) %>',1);"><div id="elh_OrdersLocal_cancelled" class="OrdersLocal_cancelled">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrdersLocal.cancelled.FldCaption %></span><span class="ewTableHeaderSort"><% If OrdersLocal.cancelled.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrdersLocal.cancelled.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrdersLocal.acknowledged.Visible Then ' acknowledged %>
	<% If OrdersLocal.SortUrl(OrdersLocal.acknowledged) = "" Then %>
		<th data-name="acknowledged"><div id="elh_OrdersLocal_acknowledged" class="OrdersLocal_acknowledged"><div class="ewTableHeaderCaption"><%= OrdersLocal.acknowledged.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="acknowledged"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrdersLocal.SortUrl(OrdersLocal.acknowledged) %>',1);"><div id="elh_OrdersLocal_acknowledged" class="OrdersLocal_acknowledged">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrdersLocal.acknowledged.FldCaption %></span><span class="ewTableHeaderSort"><% If OrdersLocal.acknowledged.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrdersLocal.acknowledged.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrdersLocal.outfordelivery.Visible Then ' outfordelivery %>
	<% If OrdersLocal.SortUrl(OrdersLocal.outfordelivery) = "" Then %>
		<th data-name="outfordelivery"><div id="elh_OrdersLocal_outfordelivery" class="OrdersLocal_outfordelivery"><div class="ewTableHeaderCaption"><%= OrdersLocal.outfordelivery.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="outfordelivery"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrdersLocal.SortUrl(OrdersLocal.outfordelivery) %>',1);"><div id="elh_OrdersLocal_outfordelivery" class="OrdersLocal_outfordelivery">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrdersLocal.outfordelivery.FldCaption %></span><span class="ewTableHeaderSort"><% If OrdersLocal.outfordelivery.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrdersLocal.outfordelivery.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrdersLocal.vouchercodediscount.Visible Then ' vouchercodediscount %>
	<% If OrdersLocal.SortUrl(OrdersLocal.vouchercodediscount) = "" Then %>
		<th data-name="vouchercodediscount"><div id="elh_OrdersLocal_vouchercodediscount" class="OrdersLocal_vouchercodediscount"><div class="ewTableHeaderCaption"><%= OrdersLocal.vouchercodediscount.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="vouchercodediscount"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrdersLocal.SortUrl(OrdersLocal.vouchercodediscount) %>',1);"><div id="elh_OrdersLocal_vouchercodediscount" class="OrdersLocal_vouchercodediscount">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrdersLocal.vouchercodediscount.FldCaption %></span><span class="ewTableHeaderSort"><% If OrdersLocal.vouchercodediscount.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrdersLocal.vouchercodediscount.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrdersLocal.vouchercode.Visible Then ' vouchercode %>
	<% If OrdersLocal.SortUrl(OrdersLocal.vouchercode) = "" Then %>
		<th data-name="vouchercode"><div id="elh_OrdersLocal_vouchercode" class="OrdersLocal_vouchercode"><div class="ewTableHeaderCaption"><%= OrdersLocal.vouchercode.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="vouchercode"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrdersLocal.SortUrl(OrdersLocal.vouchercode) %>',1);"><div id="elh_OrdersLocal_vouchercode" class="OrdersLocal_vouchercode">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrdersLocal.vouchercode.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If OrdersLocal.vouchercode.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrdersLocal.vouchercode.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrdersLocal.printed.Visible Then ' printed %>
	<% If OrdersLocal.SortUrl(OrdersLocal.printed) = "" Then %>
		<th data-name="printed"><div id="elh_OrdersLocal_printed" class="OrdersLocal_printed"><div class="ewTableHeaderCaption"><%= OrdersLocal.printed.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="printed"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrdersLocal.SortUrl(OrdersLocal.printed) %>',1);"><div id="elh_OrdersLocal_printed" class="OrdersLocal_printed">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrdersLocal.printed.FldCaption %></span><span class="ewTableHeaderSort"><% If OrdersLocal.printed.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrdersLocal.printed.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrdersLocal.deliverydistance.Visible Then ' deliverydistance %>
	<% If OrdersLocal.SortUrl(OrdersLocal.deliverydistance) = "" Then %>
		<th data-name="deliverydistance"><div id="elh_OrdersLocal_deliverydistance" class="OrdersLocal_deliverydistance"><div class="ewTableHeaderCaption"><%= OrdersLocal.deliverydistance.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="deliverydistance"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrdersLocal.SortUrl(OrdersLocal.deliverydistance) %>',1);"><div id="elh_OrdersLocal_deliverydistance" class="OrdersLocal_deliverydistance">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrdersLocal.deliverydistance.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If OrdersLocal.deliverydistance.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrdersLocal.deliverydistance.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrdersLocal.asaporder.Visible Then ' asaporder %>
	<% If OrdersLocal.SortUrl(OrdersLocal.asaporder) = "" Then %>
		<th data-name="asaporder"><div id="elh_OrdersLocal_asaporder" class="OrdersLocal_asaporder"><div class="ewTableHeaderCaption"><%= OrdersLocal.asaporder.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="asaporder"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrdersLocal.SortUrl(OrdersLocal.asaporder) %>',1);"><div id="elh_OrdersLocal_asaporder" class="OrdersLocal_asaporder">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrdersLocal.asaporder.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If OrdersLocal.asaporder.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrdersLocal.asaporder.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrdersLocal.DeliveryLat.Visible Then ' DeliveryLat %>
	<% If OrdersLocal.SortUrl(OrdersLocal.DeliveryLat) = "" Then %>
		<th data-name="DeliveryLat"><div id="elh_OrdersLocal_DeliveryLat" class="OrdersLocal_DeliveryLat"><div class="ewTableHeaderCaption"><%= OrdersLocal.DeliveryLat.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="DeliveryLat"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrdersLocal.SortUrl(OrdersLocal.DeliveryLat) %>',1);"><div id="elh_OrdersLocal_DeliveryLat" class="OrdersLocal_DeliveryLat">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrdersLocal.DeliveryLat.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If OrdersLocal.DeliveryLat.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrdersLocal.DeliveryLat.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrdersLocal.DeliveryLng.Visible Then ' DeliveryLng %>
	<% If OrdersLocal.SortUrl(OrdersLocal.DeliveryLng) = "" Then %>
		<th data-name="DeliveryLng"><div id="elh_OrdersLocal_DeliveryLng" class="OrdersLocal_DeliveryLng"><div class="ewTableHeaderCaption"><%= OrdersLocal.DeliveryLng.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="DeliveryLng"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrdersLocal.SortUrl(OrdersLocal.DeliveryLng) %>',1);"><div id="elh_OrdersLocal_DeliveryLng" class="OrdersLocal_DeliveryLng">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrdersLocal.DeliveryLng.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If OrdersLocal.DeliveryLng.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrdersLocal.DeliveryLng.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrdersLocal.ServiceCharge.Visible Then ' ServiceCharge %>
	<% If OrdersLocal.SortUrl(OrdersLocal.ServiceCharge) = "" Then %>
		<th data-name="ServiceCharge"><div id="elh_OrdersLocal_ServiceCharge" class="OrdersLocal_ServiceCharge"><div class="ewTableHeaderCaption"><%= OrdersLocal.ServiceCharge.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="ServiceCharge"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrdersLocal.SortUrl(OrdersLocal.ServiceCharge) %>',1);"><div id="elh_OrdersLocal_ServiceCharge" class="OrdersLocal_ServiceCharge">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrdersLocal.ServiceCharge.FldCaption %></span><span class="ewTableHeaderSort"><% If OrdersLocal.ServiceCharge.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrdersLocal.ServiceCharge.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrdersLocal.PaymentSurcharge.Visible Then ' PaymentSurcharge %>
	<% If OrdersLocal.SortUrl(OrdersLocal.PaymentSurcharge) = "" Then %>
		<th data-name="PaymentSurcharge"><div id="elh_OrdersLocal_PaymentSurcharge" class="OrdersLocal_PaymentSurcharge"><div class="ewTableHeaderCaption"><%= OrdersLocal.PaymentSurcharge.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="PaymentSurcharge"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrdersLocal.SortUrl(OrdersLocal.PaymentSurcharge) %>',1);"><div id="elh_OrdersLocal_PaymentSurcharge" class="OrdersLocal_PaymentSurcharge">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrdersLocal.PaymentSurcharge.FldCaption %></span><span class="ewTableHeaderSort"><% If OrdersLocal.PaymentSurcharge.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrdersLocal.PaymentSurcharge.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrdersLocal.Tax_Rate.Visible Then ' Tax_Rate %>
	<% If OrdersLocal.SortUrl(OrdersLocal.Tax_Rate) = "" Then %>
		<th data-name="Tax_Rate"><div id="elh_OrdersLocal_Tax_Rate" class="OrdersLocal_Tax_Rate"><div class="ewTableHeaderCaption"><%= OrdersLocal.Tax_Rate.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Tax_Rate"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrdersLocal.SortUrl(OrdersLocal.Tax_Rate) %>',1);"><div id="elh_OrdersLocal_Tax_Rate" class="OrdersLocal_Tax_Rate">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrdersLocal.Tax_Rate.FldCaption %></span><span class="ewTableHeaderSort"><% If OrdersLocal.Tax_Rate.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrdersLocal.Tax_Rate.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrdersLocal.Tax_Amount.Visible Then ' Tax_Amount %>
	<% If OrdersLocal.SortUrl(OrdersLocal.Tax_Amount) = "" Then %>
		<th data-name="Tax_Amount"><div id="elh_OrdersLocal_Tax_Amount" class="OrdersLocal_Tax_Amount"><div class="ewTableHeaderCaption"><%= OrdersLocal.Tax_Amount.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Tax_Amount"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrdersLocal.SortUrl(OrdersLocal.Tax_Amount) %>',1);"><div id="elh_OrdersLocal_Tax_Amount" class="OrdersLocal_Tax_Amount">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrdersLocal.Tax_Amount.FldCaption %></span><span class="ewTableHeaderSort"><% If OrdersLocal.Tax_Amount.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrdersLocal.Tax_Amount.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrdersLocal.Tip_Rate.Visible Then ' Tip_Rate %>
	<% If OrdersLocal.SortUrl(OrdersLocal.Tip_Rate) = "" Then %>
		<th data-name="Tip_Rate"><div id="elh_OrdersLocal_Tip_Rate" class="OrdersLocal_Tip_Rate"><div class="ewTableHeaderCaption"><%= OrdersLocal.Tip_Rate.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Tip_Rate"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrdersLocal.SortUrl(OrdersLocal.Tip_Rate) %>',1);"><div id="elh_OrdersLocal_Tip_Rate" class="OrdersLocal_Tip_Rate">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrdersLocal.Tip_Rate.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If OrdersLocal.Tip_Rate.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrdersLocal.Tip_Rate.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrdersLocal.Tip_Amount.Visible Then ' Tip_Amount %>
	<% If OrdersLocal.SortUrl(OrdersLocal.Tip_Amount) = "" Then %>
		<th data-name="Tip_Amount"><div id="elh_OrdersLocal_Tip_Amount" class="OrdersLocal_Tip_Amount"><div class="ewTableHeaderCaption"><%= OrdersLocal.Tip_Amount.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Tip_Amount"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrdersLocal.SortUrl(OrdersLocal.Tip_Amount) %>',1);"><div id="elh_OrdersLocal_Tip_Amount" class="OrdersLocal_Tip_Amount">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrdersLocal.Tip_Amount.FldCaption %></span><span class="ewTableHeaderSort"><% If OrdersLocal.Tip_Amount.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrdersLocal.Tip_Amount.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If OrdersLocal.Payment_status.Visible Then ' Payment_status %>
	<% If OrdersLocal.SortUrl(OrdersLocal.Payment_status) = "" Then %>
		<th data-name="Payment_status"><div id="elh_OrdersLocal_Payment_status" class="OrdersLocal_Payment_status"><div class="ewTableHeaderCaption"><%= OrdersLocal.Payment_status.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Payment_status"><div class="ewPointer" onclick="ew_Sort(event,'<%= OrdersLocal.SortUrl(OrdersLocal.Payment_status) %>',1);"><div id="elh_OrdersLocal_Payment_status" class="OrdersLocal_Payment_status">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= OrdersLocal.Payment_status.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If OrdersLocal.Payment_status.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf OrdersLocal.Payment_status.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<%

' Render list options (header, right)
OrdersLocal_list.ListOptions.Render "header", "right", "", "", "", ""
%>
	</tr>
</thead>
<tbody><!-- Table body -->
<%
If (OrdersLocal.ExportAll And OrdersLocal.Export <> "") Then
	OrdersLocal_list.StopRec = OrdersLocal_list.TotalRecs
Else

	' Set the last record to display
	If OrdersLocal_list.TotalRecs > OrdersLocal_list.StartRec + OrdersLocal_list.DisplayRecs - 1 Then
		OrdersLocal_list.StopRec = OrdersLocal_list.StartRec + OrdersLocal_list.DisplayRecs - 1
	Else
		OrdersLocal_list.StopRec = OrdersLocal_list.TotalRecs
	End If
End If

' Move to first record
OrdersLocal_list.RecCnt = OrdersLocal_list.StartRec - 1
If Not OrdersLocal_list.Recordset.Eof Then
	OrdersLocal_list.Recordset.MoveFirst
	If OrdersLocal_list.StartRec > 1 Then OrdersLocal_list.Recordset.Move OrdersLocal_list.StartRec - 1
ElseIf Not OrdersLocal.AllowAddDeleteRow And OrdersLocal_list.StopRec = 0 Then
	OrdersLocal_list.StopRec = OrdersLocal.GridAddRowCount
End If

' Initialize Aggregate
OrdersLocal.RowType = EW_ROWTYPE_AGGREGATEINIT
Call OrdersLocal.ResetAttrs()
Call OrdersLocal_list.RenderRow()
OrdersLocal_list.RowCnt = 0

' Output date rows
Do While CLng(OrdersLocal_list.RecCnt) < CLng(OrdersLocal_list.StopRec)
	OrdersLocal_list.RecCnt = OrdersLocal_list.RecCnt + 1
	If CLng(OrdersLocal_list.RecCnt) >= CLng(OrdersLocal_list.StartRec) Then
		OrdersLocal_list.RowCnt = OrdersLocal_list.RowCnt + 1

	' Set up key count
	OrdersLocal_list.KeyCount = OrdersLocal_list.RowIndex
	Call OrdersLocal.ResetAttrs()
	OrdersLocal.CssClass = ""
	If OrdersLocal.CurrentAction = "gridadd" Then
	Else
		Call OrdersLocal_list.LoadRowValues(OrdersLocal_list.Recordset) ' Load row values
	End If
	OrdersLocal.RowType = EW_ROWTYPE_VIEW ' Render view

	' Set up row id / data-rowindex
	OrdersLocal.RowAttrs.AddAttributes Array(Array("data-rowindex", OrdersLocal_list.RowCnt), Array("id", "r" & OrdersLocal_list.RowCnt & "_OrdersLocal"), Array("data-rowtype", OrdersLocal.RowType))

	' Render row
	Call OrdersLocal_list.RenderRow()

	' Render list options
	Call OrdersLocal_list.RenderListOptions()
%>
	<tr<%= OrdersLocal.RowAttributes %>>
<%

' Render list options (body, left)
OrdersLocal_list.ListOptions.Render "body", "left", OrdersLocal_list.RowCnt, "", "", ""
%>
	<% If OrdersLocal.ID.Visible Then ' ID %>
		<td data-name="ID"<%= OrdersLocal.ID.CellAttributes %>>
<span<%= OrdersLocal.ID.ViewAttributes %>>
<%= OrdersLocal.ID.ListViewValue %>
</span>
<a id="<%= OrdersLocal_list.PageObjName & "_row_" & OrdersLocal_list.RowCnt %>"></a></td>
	<% End If %>
	<% If OrdersLocal.CreationDate.Visible Then ' CreationDate %>
		<td data-name="CreationDate"<%= OrdersLocal.CreationDate.CellAttributes %>>
<span<%= OrdersLocal.CreationDate.ViewAttributes %>>
<%= OrdersLocal.CreationDate.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrdersLocal.OrderDate.Visible Then ' OrderDate %>
		<td data-name="OrderDate"<%= OrdersLocal.OrderDate.CellAttributes %>>
<span<%= OrdersLocal.OrderDate.ViewAttributes %>>
<%= OrdersLocal.OrderDate.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrdersLocal.DeliveryType.Visible Then ' DeliveryType %>
		<td data-name="DeliveryType"<%= OrdersLocal.DeliveryType.CellAttributes %>>
<span<%= OrdersLocal.DeliveryType.ViewAttributes %>>
<%= OrdersLocal.DeliveryType.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrdersLocal.DeliveryTime.Visible Then ' DeliveryTime %>
		<td data-name="DeliveryTime"<%= OrdersLocal.DeliveryTime.CellAttributes %>>
<span<%= OrdersLocal.DeliveryTime.ViewAttributes %>>
<%= OrdersLocal.DeliveryTime.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrdersLocal.PaymentType.Visible Then ' PaymentType %>
		<td data-name="PaymentType"<%= OrdersLocal.PaymentType.CellAttributes %>>
<span<%= OrdersLocal.PaymentType.ViewAttributes %>>
<%= OrdersLocal.PaymentType.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrdersLocal.SubTotal.Visible Then ' SubTotal %>
		<td data-name="SubTotal"<%= OrdersLocal.SubTotal.CellAttributes %>>
<span<%= OrdersLocal.SubTotal.ViewAttributes %>>
<%= OrdersLocal.SubTotal.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrdersLocal.ShippingFee.Visible Then ' ShippingFee %>
		<td data-name="ShippingFee"<%= OrdersLocal.ShippingFee.CellAttributes %>>
<span<%= OrdersLocal.ShippingFee.ViewAttributes %>>
<%= OrdersLocal.ShippingFee.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrdersLocal.OrderTotal.Visible Then ' OrderTotal %>
		<td data-name="OrderTotal"<%= OrdersLocal.OrderTotal.CellAttributes %>>
<span<%= OrdersLocal.OrderTotal.ViewAttributes %>>
<%= OrdersLocal.OrderTotal.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrdersLocal.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
		<td data-name="IdBusinessDetail"<%= OrdersLocal.IdBusinessDetail.CellAttributes %>>
<span<%= OrdersLocal.IdBusinessDetail.ViewAttributes %>>
<%= OrdersLocal.IdBusinessDetail.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrdersLocal.SessionId.Visible Then ' SessionId %>
		<td data-name="SessionId"<%= OrdersLocal.SessionId.CellAttributes %>>
<span<%= OrdersLocal.SessionId.ViewAttributes %>>
<%= OrdersLocal.SessionId.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrdersLocal.FirstName.Visible Then ' FirstName %>
		<td data-name="FirstName"<%= OrdersLocal.FirstName.CellAttributes %>>
<span<%= OrdersLocal.FirstName.ViewAttributes %>>
<%= OrdersLocal.FirstName.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrdersLocal.LastName.Visible Then ' LastName %>
		<td data-name="LastName"<%= OrdersLocal.LastName.CellAttributes %>>
<span<%= OrdersLocal.LastName.ViewAttributes %>>
<%= OrdersLocal.LastName.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrdersLocal.zEmail.Visible Then ' Email %>
		<td data-name="zEmail"<%= OrdersLocal.zEmail.CellAttributes %>>
<span<%= OrdersLocal.zEmail.ViewAttributes %>>
<%= OrdersLocal.zEmail.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrdersLocal.Phone.Visible Then ' Phone %>
		<td data-name="Phone"<%= OrdersLocal.Phone.CellAttributes %>>
<span<%= OrdersLocal.Phone.ViewAttributes %>>
<%= OrdersLocal.Phone.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrdersLocal.Address.Visible Then ' Address %>
		<td data-name="Address"<%= OrdersLocal.Address.CellAttributes %>>
<span<%= OrdersLocal.Address.ViewAttributes %>>
<%= OrdersLocal.Address.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrdersLocal.PostalCode.Visible Then ' PostalCode %>
		<td data-name="PostalCode"<%= OrdersLocal.PostalCode.CellAttributes %>>
<span<%= OrdersLocal.PostalCode.ViewAttributes %>>
<%= OrdersLocal.PostalCode.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrdersLocal.Notes.Visible Then ' Notes %>
		<td data-name="Notes"<%= OrdersLocal.Notes.CellAttributes %>>
<span<%= OrdersLocal.Notes.ViewAttributes %>>
<%= OrdersLocal.Notes.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrdersLocal.ttest.Visible Then ' ttest %>
		<td data-name="ttest"<%= OrdersLocal.ttest.CellAttributes %>>
<span<%= OrdersLocal.ttest.ViewAttributes %>>
<%= OrdersLocal.ttest.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrdersLocal.cancelleddate.Visible Then ' cancelleddate %>
		<td data-name="cancelleddate"<%= OrdersLocal.cancelleddate.CellAttributes %>>
<span<%= OrdersLocal.cancelleddate.ViewAttributes %>>
<%= OrdersLocal.cancelleddate.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrdersLocal.cancelledby.Visible Then ' cancelledby %>
		<td data-name="cancelledby"<%= OrdersLocal.cancelledby.CellAttributes %>>
<span<%= OrdersLocal.cancelledby.ViewAttributes %>>
<%= OrdersLocal.cancelledby.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrdersLocal.cancelledreason.Visible Then ' cancelledreason %>
		<td data-name="cancelledreason"<%= OrdersLocal.cancelledreason.CellAttributes %>>
<span<%= OrdersLocal.cancelledreason.ViewAttributes %>>
<%= OrdersLocal.cancelledreason.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrdersLocal.acknowledgeddate.Visible Then ' acknowledgeddate %>
		<td data-name="acknowledgeddate"<%= OrdersLocal.acknowledgeddate.CellAttributes %>>
<span<%= OrdersLocal.acknowledgeddate.ViewAttributes %>>
<%= OrdersLocal.acknowledgeddate.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrdersLocal.delivereddate.Visible Then ' delivereddate %>
		<td data-name="delivereddate"<%= OrdersLocal.delivereddate.CellAttributes %>>
<span<%= OrdersLocal.delivereddate.ViewAttributes %>>
<%= OrdersLocal.delivereddate.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrdersLocal.cancelled.Visible Then ' cancelled %>
		<td data-name="cancelled"<%= OrdersLocal.cancelled.CellAttributes %>>
<span<%= OrdersLocal.cancelled.ViewAttributes %>>
<%= OrdersLocal.cancelled.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrdersLocal.acknowledged.Visible Then ' acknowledged %>
		<td data-name="acknowledged"<%= OrdersLocal.acknowledged.CellAttributes %>>
<span<%= OrdersLocal.acknowledged.ViewAttributes %>>
<%= OrdersLocal.acknowledged.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrdersLocal.outfordelivery.Visible Then ' outfordelivery %>
		<td data-name="outfordelivery"<%= OrdersLocal.outfordelivery.CellAttributes %>>
<span<%= OrdersLocal.outfordelivery.ViewAttributes %>>
<%= OrdersLocal.outfordelivery.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrdersLocal.vouchercodediscount.Visible Then ' vouchercodediscount %>
		<td data-name="vouchercodediscount"<%= OrdersLocal.vouchercodediscount.CellAttributes %>>
<span<%= OrdersLocal.vouchercodediscount.ViewAttributes %>>
<%= OrdersLocal.vouchercodediscount.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrdersLocal.vouchercode.Visible Then ' vouchercode %>
		<td data-name="vouchercode"<%= OrdersLocal.vouchercode.CellAttributes %>>
<span<%= OrdersLocal.vouchercode.ViewAttributes %>>
<%= OrdersLocal.vouchercode.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrdersLocal.printed.Visible Then ' printed %>
		<td data-name="printed"<%= OrdersLocal.printed.CellAttributes %>>
<span<%= OrdersLocal.printed.ViewAttributes %>>
<%= OrdersLocal.printed.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrdersLocal.deliverydistance.Visible Then ' deliverydistance %>
		<td data-name="deliverydistance"<%= OrdersLocal.deliverydistance.CellAttributes %>>
<span<%= OrdersLocal.deliverydistance.ViewAttributes %>>
<%= OrdersLocal.deliverydistance.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrdersLocal.asaporder.Visible Then ' asaporder %>
		<td data-name="asaporder"<%= OrdersLocal.asaporder.CellAttributes %>>
<span<%= OrdersLocal.asaporder.ViewAttributes %>>
<%= OrdersLocal.asaporder.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrdersLocal.DeliveryLat.Visible Then ' DeliveryLat %>
		<td data-name="DeliveryLat"<%= OrdersLocal.DeliveryLat.CellAttributes %>>
<span<%= OrdersLocal.DeliveryLat.ViewAttributes %>>
<%= OrdersLocal.DeliveryLat.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrdersLocal.DeliveryLng.Visible Then ' DeliveryLng %>
		<td data-name="DeliveryLng"<%= OrdersLocal.DeliveryLng.CellAttributes %>>
<span<%= OrdersLocal.DeliveryLng.ViewAttributes %>>
<%= OrdersLocal.DeliveryLng.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrdersLocal.ServiceCharge.Visible Then ' ServiceCharge %>
		<td data-name="ServiceCharge"<%= OrdersLocal.ServiceCharge.CellAttributes %>>
<span<%= OrdersLocal.ServiceCharge.ViewAttributes %>>
<%= OrdersLocal.ServiceCharge.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrdersLocal.PaymentSurcharge.Visible Then ' PaymentSurcharge %>
		<td data-name="PaymentSurcharge"<%= OrdersLocal.PaymentSurcharge.CellAttributes %>>
<span<%= OrdersLocal.PaymentSurcharge.ViewAttributes %>>
<%= OrdersLocal.PaymentSurcharge.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrdersLocal.Tax_Rate.Visible Then ' Tax_Rate %>
		<td data-name="Tax_Rate"<%= OrdersLocal.Tax_Rate.CellAttributes %>>
<span<%= OrdersLocal.Tax_Rate.ViewAttributes %>>
<%= OrdersLocal.Tax_Rate.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrdersLocal.Tax_Amount.Visible Then ' Tax_Amount %>
		<td data-name="Tax_Amount"<%= OrdersLocal.Tax_Amount.CellAttributes %>>
<span<%= OrdersLocal.Tax_Amount.ViewAttributes %>>
<%= OrdersLocal.Tax_Amount.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrdersLocal.Tip_Rate.Visible Then ' Tip_Rate %>
		<td data-name="Tip_Rate"<%= OrdersLocal.Tip_Rate.CellAttributes %>>
<span<%= OrdersLocal.Tip_Rate.ViewAttributes %>>
<%= OrdersLocal.Tip_Rate.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrdersLocal.Tip_Amount.Visible Then ' Tip_Amount %>
		<td data-name="Tip_Amount"<%= OrdersLocal.Tip_Amount.CellAttributes %>>
<span<%= OrdersLocal.Tip_Amount.ViewAttributes %>>
<%= OrdersLocal.Tip_Amount.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If OrdersLocal.Payment_status.Visible Then ' Payment_status %>
		<td data-name="Payment_status"<%= OrdersLocal.Payment_status.CellAttributes %>>
<span<%= OrdersLocal.Payment_status.ViewAttributes %>>
<%= OrdersLocal.Payment_status.ListViewValue %>
</span>
</td>
	<% End If %>
<%

' Render list options (body, right)
OrdersLocal_list.ListOptions.Render "body", "right", OrdersLocal_list.RowCnt, "", "", ""
%>
	</tr>
<%
	End If
	If OrdersLocal.CurrentAction <> "gridadd" Then
		OrdersLocal_list.Recordset.MoveNext()
	End If
Loop
%>
</tbody>
</table>
<% End If %>
<% If OrdersLocal.CurrentAction = "" Then %>
<input type="hidden" name="a_list" id="a_list" value="">
<% End If %>
</div>
</form>
<%

' Close recordset and connection
OrdersLocal_list.Recordset.Close
Set OrdersLocal_list.Recordset = Nothing
%>
<% If OrdersLocal.Export = "" Then %>
<div class="ewGridLowerPanel">
<% If OrdersLocal.CurrentAction <> "gridadd" And OrdersLocal.CurrentAction <> "gridedit" Then %>
<form name="ewPagerForm" class="ewForm form-inline ewPagerForm" action="<%= ew_CurrentPage %>">
<% If Not IsObject(OrdersLocal_list.Pager) Then Set OrdersLocal_list.Pager = ew_NewPrevNextPager(OrdersLocal_list.StartRec, OrdersLocal_list.DisplayRecs, OrdersLocal_list.TotalRecs) %>
<% If OrdersLocal_list.Pager.RecordCount > 0 Then %>
<div class="ewPager">
<span><%= Language.Phrase("Page") %>&nbsp;</span>
<div class="ewPrevNext"><div class="input-group">
<div class="input-group-btn">
<!--first page button-->
	<% If OrdersLocal_list.Pager.FirstButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerFirst") %>" href="<%= OrdersLocal_list.PageUrl %>start=<%= OrdersLocal_list.Pager.FirstButton.Start %>"><span class="icon-first ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerFirst") %>"><span class="icon-first ewIcon"></span></a>
	<% End If %>
<!--previous page button-->
	<% If OrdersLocal_list.Pager.PrevButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerPrevious") %>" href="<%= OrdersLocal_list.PageUrl %>start=<%= OrdersLocal_list.Pager.PrevButton.Start %>"><span class="icon-prev ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerPrevious") %>"><span class="icon-prev ewIcon"></span></a>
	<% End If %>
</div>
<!--current page number-->
	<input class="form-control input-sm" type="text" name="<%= EW_TABLE_PAGE_NO %>" value="<%= OrdersLocal_list.Pager.CurrentPage %>">
<div class="input-group-btn">
<!--next page button-->
	<% If OrdersLocal_list.Pager.NextButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerNext") %>" href="<%= OrdersLocal_list.PageUrl %>start=<%= OrdersLocal_list.Pager.NextButton.Start %>"><span class="icon-next ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerNext") %>"><span class="icon-next ewIcon"></span></a>
	<% End If %>
<!--last page button-->
	<% If OrdersLocal_list.Pager.LastButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerLast") %>" href="<%= OrdersLocal_list.PageUrl %>start=<%= OrdersLocal_list.Pager.LastButton.Start %>"><span class="icon-last ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerLast") %>"><span class="icon-last ewIcon"></span></a>
	<% End If %>
</div>
</div>
</div>
<span>&nbsp;<%= Language.Phrase("of") %>&nbsp;<%= OrdersLocal_list.Pager.PageCount %></span>
</div>
<div class="ewPager ewRec">
	<span><%= Language.Phrase("Record") %>&nbsp;<%= OrdersLocal_list.Pager.FromIndex %>&nbsp;<%= Language.Phrase("To") %>&nbsp;<%= OrdersLocal_list.Pager.ToIndex %>&nbsp;<%= Language.Phrase("Of") %>&nbsp;<%= OrdersLocal_list.Pager.RecordCount %></span>
</div>
<% End If %>
<% If OrdersLocal_list.TotalRecs > 0 Then %>
<div class="ewPager">
<input type="hidden" name="t" value="OrdersLocal">
<select name="<%= EW_TABLE_REC_PER_PAGE %>" class="form-control input-sm" onchange="this.form.submit();">
<option value="20"<% If OrdersLocal_list.DisplayRecs = 20 Then %> selected="selected"<% End If %>>20</option>
<option value="50"<% If OrdersLocal_list.DisplayRecs = 50 Then %> selected="selected"<% End If %>>50</option>
<option value="100"<% If OrdersLocal_list.DisplayRecs = 100 Then %> selected="selected"<% End If %>>100</option>
<option value="500"<% If OrdersLocal_list.DisplayRecs = 500 Then %> selected="selected"<% End If %>>500</option>
<option value="1000"<% If OrdersLocal_list.DisplayRecs = 1000 Then %> selected="selected"<% End If %>>1000</option>
<option value="ALL"<% If OrdersLocal.RecordsPerPage = -1 Then %> selected="selected"<% End If %>><%= Language.Phrase("AllRecords") %></option>
</select>
</div>
<% End If %>
</form>
<% End If %>
<div class="ewListOtherOptions">
<%
	OrdersLocal_list.AddEditOptions.Render "body", "bottom", "", "", "", ""
	OrdersLocal_list.DetailOptions.Render "body", "bottom", "", "", "", ""
	OrdersLocal_list.ActionOptions.Render "body", "bottom", "", "", "", ""
%>
</div>
<div class="clearfix"></div>
</div>
<% End If %>
</div>
<% End If %>
<% If OrdersLocal_list.TotalRecs = 0 And OrdersLocal.CurrentAction = "" Then ' Show other options %>
<div class="ewListOtherOptions">
<%
	OrdersLocal_list.AddEditOptions.Render "body", "", "", "", "", ""
	OrdersLocal_list.DetailOptions.Render "body", "", "", "", "", ""
	OrdersLocal_list.ActionOptions.Render "body", "", "", "", "", ""
%>
</div>
<div class="clearfix"></div>
<% End If %>
<% If OrdersLocal.Export <> "" Then %>
<script type="text/javascript">
ew_ApplyTemplate("body", "", "OrdersLocallist", "<%= OrdersLocal.CustomExport %>");
</script>
<% End If %>
<% If OrdersLocal.Export = "" Then %>
<script type="text/javascript">
fOrdersLocallistsrch.Init();
fOrdersLocallist.Init();
</script>
<% End If %>
<%
OrdersLocal_list.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<% If OrdersLocal.Export = "" Then %>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<% End If %>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set OrdersLocal_list = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cOrdersLocal_list

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
		TableName = "OrdersLocal"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "OrdersLocal_list"
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
		If OrdersLocal.UseTokenInUrl Then PageUrl = PageUrl & "t=" & OrdersLocal.TableVar & "&" ' add page token
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
		If OrdersLocal.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (OrdersLocal.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (OrdersLocal.TableVar = Request.QueryString("t"))
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
		FormName = "fOrdersLocallist"
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
		If IsEmpty(OrdersLocal) Then Set OrdersLocal = New cOrdersLocal
		Set Table = OrdersLocal
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
		AddUrl = "OrdersLocaladd.asp"
		InlineAddUrl = PageUrl & "a=add"
		GridAddUrl = PageUrl & "a=gridadd"
		GridEditUrl = PageUrl & "a=gridedit"
		MultiDeleteUrl = "OrdersLocaldelete.asp"
		MultiUpdateUrl = "OrdersLocalupdate.asp"

		' Initialize form object
		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "list"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "OrdersLocal"

		' Open connection to the database
		If IsEmpty(Conn) Then Call ew_Connect()

		' List options
		Set ListOptions = New cListOptions
		ListOptions.TableVar = OrdersLocal.TableVar

		' Export options
		Set ExportOptions = New cListOptions
		ExportOptions.TableVar = OrdersLocal.TableVar
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
			OrdersLocal.Export = Request.QueryString("export")
			custom = Request.QueryString("custom") & ""
		ElseIf ew_IsHttpPost() Then
			If Request.Form("export").Count > 0 Then
				OrdersLocal.Export = Request.Form("export")
				custom = Request.Form("custom") & ""
			ElseIf Request.Form("exporttype").Count > 0 Then
				OrdersLocal.Export = Request.Form("exporttype")
				custom = Request.Form("custom") & ""
			End If
		Else
			OrdersLocal.ExportReturnUrl = ew_CurrentUrl()
		End If
		gsExportFile = OrdersLocal.TableVar ' Get export file, used in header
		Dim Charset ' Charset used in header
		If EW_CHARSET <> "" Then
			Charset = ";charset=" & EW_CHARSET
		Else
			Charset = ""
		End If

		' Get custom export parameters
		If OrdersLocal.Export <> "" And custom <> "" Then
			OrdersLocal.CustomExport = OrdersLocal.Export
			OrdersLocal.Export = "print"
		End If
		gsCustomExport = OrdersLocal.CustomExport
		gsExport = OrdersLocal.Export ' Get export parameter, used in header

		' Custom export (post back from ew_ApplyTemplate), export and terminate page
		If Request.Form("customexport").Count > 0 Then
			OrdersLocal.CustomExport = Request.Form("customexport")
			OrdersLocal.Export = OrdersLocal.CustomExport
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
		If OrdersLocal.Export = "excel" Then
			Response.ContentType = "application/vnd.ms-excel" & Charset
			Response.AddHeader "Content-Disposition", "attachment; filename=" & gsExportFile & ".xls"
		End If
		If OrdersLocal.Export = "word" Then
			Response.ContentType = "application/vnd.ms-word" & Charset
			Response.AddHeader "Content-Disposition", "attachment; filename=" & gsExportFile & ".doc"
		End If
		If OrdersLocal.Export = "csv" Then
			Response.BinaryWrite ChrB(239) & ChrB(187) & ChrB(191)
			Response.ContentType = "application/csv" & Charset
			Response.AddHeader "Content-Disposition", "attachment; filename=" & gsExportFile & ".csv"
		End If

		' Get grid add count
		Dim gridaddcnt
		gridaddcnt = Request.QueryString(EW_TABLE_GRID_ADD_ROW_COUNT)
		If IsNumeric(gridaddcnt) Then
			If gridaddcnt > 0 Then
				OrdersLocal.GridAddRowCount = gridaddcnt
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
			results = OrdersLocal.GetAutoFill(Request.Form("name"), Request.Form("q"))
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
		If UBound(OrdersLocal.CustomActions.CustomArray) >= 0 Then
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
		If Not OrdersLocal Is Nothing Then
			If OrdersLocal.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = OrdersLocal.TableVar
				If OrdersLocal.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf OrdersLocal.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf OrdersLocal.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf OrdersLocal.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set OrdersLocal = Nothing
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
			If OrdersLocal.Export = "" Then
				SetupBreadcrumb()
			End If

			' Hide list options
			If OrdersLocal.Export <> "" Then
				Call ListOptions.HideAllOptions(Array("sequence"))
				ListOptions.UseDropDownButton = False ' Disable drop down button
				ListOptions.UseButtonGroup = False ' Disable button group
			ElseIf OrdersLocal.CurrentAction = "gridadd" Or OrdersLocal.CurrentAction = "gridedit" Then
				Call ListOptions.HideAllOptions(Array())
				ListOptions.UseDropDownButton = False ' Disable drop down button
				ListOptions.UseButtonGroup = False ' Disable button group
			End If

			' Hide export options
			If OrdersLocal.Export <> "" Or OrdersLocal.CurrentAction <> "" Then
				ExportOptions.HideAllOptions(Array())
			End If

			' Hide other options
			If OrdersLocal.Export <> "" Then
				AddEditOptions.HideAllOptions(Array())
				DetailOptions.HideAllOptions(Array())
				ActionOptions.HideAllOptions(Array())
			End If

			' Get default search criteria
			Call ew_AddFilter(DefaultSearchWhere, BasicSearchWhere(True))

			' Get basic search values
			Call LoadBasicSearchValues()

			' Restore search parms from Session if not searching / reset / export
			If (OrdersLocal.Export <> "" Or Command <> "search" And Command <> "reset" And Command <> "resetall") And CheckSearchParms() Then
				Call RestoreSearchParms()
			End If

			' Call Recordset SearchValidated event
			Call OrdersLocal.Recordset_SearchValidated()

			' Set Up Sorting Order
			SetUpSortOrder()

			' Get basic search criteria
			If gsSearchError = "" Then
				sSrchBasic = BasicSearchWhere(False)
			End If
		End If ' End Validate Request

		' Restore display records
		If OrdersLocal.RecordsPerPage <> "" Then
			DisplayRecs = OrdersLocal.RecordsPerPage ' Restore from Session
		Else
			DisplayRecs = 20 ' Load default
		End If

		' Load Sorting Order
		LoadSortOrder()

		' Load search default if no existing search criteria
		If Not CheckSearchParms() Then

			' Load basic search from default
			OrdersLocal.BasicSearch.Keyword = OrdersLocal.BasicSearch.KeywordDefault
			OrdersLocal.BasicSearch.SearchType = OrdersLocal.BasicSearch.SearchTypeDefault
			OrdersLocal.BasicSearch.setSearchType(OrdersLocal.BasicSearch.SearchTypeDefault)
			If OrdersLocal.BasicSearch.Keyword <> "" Then
				sSrchBasic = BasicSearchWhere(False)
			End If
		End If

		' Build search criteria
		Call ew_AddFilter(SearchWhere, sSrchAdvanced)
		Call ew_AddFilter(SearchWhere, sSrchBasic)

		' Call Recordset Searching event
		Call OrdersLocal.Recordset_Searching(SearchWhere)

		' Save search criteria
		If Command = "search" And Not RestoreSearch Then
			OrdersLocal.SearchWhere = SearchWhere ' Save to Session
			StartRec = 1 ' Reset start record counter
			OrdersLocal.StartRecordNumber = StartRec
		Else
			SearchWhere = OrdersLocal.SearchWhere
		End If
		sFilter = ""
		Call ew_AddFilter(sFilter, DbDetailFilter)
		Call ew_AddFilter(sFilter, SearchWhere)

		' Set up filter in Session
		OrdersLocal.SessionWhere = sFilter
		OrdersLocal.CurrentFilter = ""

		' Export Data only
		If OrdersLocal.CustomExport = "" And ew_InArray(OrdersLocal.Export, Array("html","word","excel","xml","csv","email","pdf")) Then
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
			OrdersLocal.RecordsPerPage = DisplayRecs ' Save to Session

			' Reset start position
			StartRec = 1
			OrdersLocal.StartRecordNumber = StartRec
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
				sFilter = OrdersLocal.KeyFilter
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
			OrdersLocal.ID.FormValue = arrKeyFlds(0)
			If Not IsNumeric(OrdersLocal.ID.FormValue) Then
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
			Call BuildBasicSearchSQL(sWhere, OrdersLocal.DeliveryType, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, OrdersLocal.PaymentType, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, OrdersLocal.SessionId, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, OrdersLocal.FirstName, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, OrdersLocal.LastName, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, OrdersLocal.zEmail, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, OrdersLocal.Phone, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, OrdersLocal.Address, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, OrdersLocal.PostalCode, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, OrdersLocal.Notes, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, OrdersLocal.ttest, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, OrdersLocal.cancelledby, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, OrdersLocal.cancelledreason, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, OrdersLocal.delivereddate, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, OrdersLocal.vouchercode, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, OrdersLocal.deliverydistance, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, OrdersLocal.asaporder, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, OrdersLocal.DeliveryLat, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, OrdersLocal.DeliveryLng, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, OrdersLocal.Tip_Rate, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, OrdersLocal.Payment_status, arKeywords, typ)
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
		sSearchKeyword = ew_IIf(Default, OrdersLocal.BasicSearch.KeywordDefault, OrdersLocal.BasicSearch.Keyword)
		sSearchType = ew_IIf(Default, OrdersLocal.BasicSearch.SearchTypeDefault, OrdersLocal.BasicSearch.SearchType)
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
			OrdersLocal.BasicSearch.setKeyword(sSearchKeyword)
			OrdersLocal.BasicSearch.setSearchType(sSearchType)
		End If
		BasicSearchWhere = sSearchStr
	End Function

	' Check if search parm exists
	Function CheckSearchParms()

		' Check basic search
		If OrdersLocal.BasicSearch.IssetSession() Then
			CheckSearchParms = True
			Exit Function
		End If
		CheckSearchParms = False
	End Function

	' Clear all search parameters
	Sub ResetSearchParms()

		' Clear search where
		SearchWhere = ""
		OrdersLocal.SearchWhere = SearchWhere

		' Clear basic search parameters
		Call ResetBasicSearchParms()
	End Sub

	' Load advanced search default values
	Function LoadAdvancedSearchDefault()
		LoadAdvancedSearchDefault = False
	End Function

	' Clear all basic search parameters
	Sub ResetBasicSearchParms()
		OrdersLocal.BasicSearch.UnsetSession()
	End Sub

	' -----------------------------------------------------------------
	' Restore all search parameters
	'
	Sub RestoreSearchParms()

		' Restore search flag
		RestoreSearch = True

		' Restore basic search values
		Call OrdersLocal.BasicSearch.Load()
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
			OrdersLocal.CurrentOrder = Request.QueryString("order")
			OrdersLocal.CurrentOrderType = Request.QueryString("ordertype")

			' Field ID
			Call OrdersLocal.UpdateSort(OrdersLocal.ID)

			' Field CreationDate
			Call OrdersLocal.UpdateSort(OrdersLocal.CreationDate)

			' Field OrderDate
			Call OrdersLocal.UpdateSort(OrdersLocal.OrderDate)

			' Field DeliveryType
			Call OrdersLocal.UpdateSort(OrdersLocal.DeliveryType)

			' Field DeliveryTime
			Call OrdersLocal.UpdateSort(OrdersLocal.DeliveryTime)

			' Field PaymentType
			Call OrdersLocal.UpdateSort(OrdersLocal.PaymentType)

			' Field SubTotal
			Call OrdersLocal.UpdateSort(OrdersLocal.SubTotal)

			' Field ShippingFee
			Call OrdersLocal.UpdateSort(OrdersLocal.ShippingFee)

			' Field OrderTotal
			Call OrdersLocal.UpdateSort(OrdersLocal.OrderTotal)

			' Field IdBusinessDetail
			Call OrdersLocal.UpdateSort(OrdersLocal.IdBusinessDetail)

			' Field SessionId
			Call OrdersLocal.UpdateSort(OrdersLocal.SessionId)

			' Field FirstName
			Call OrdersLocal.UpdateSort(OrdersLocal.FirstName)

			' Field LastName
			Call OrdersLocal.UpdateSort(OrdersLocal.LastName)

			' Field Email
			Call OrdersLocal.UpdateSort(OrdersLocal.zEmail)

			' Field Phone
			Call OrdersLocal.UpdateSort(OrdersLocal.Phone)

			' Field Address
			Call OrdersLocal.UpdateSort(OrdersLocal.Address)

			' Field PostalCode
			Call OrdersLocal.UpdateSort(OrdersLocal.PostalCode)

			' Field Notes
			Call OrdersLocal.UpdateSort(OrdersLocal.Notes)

			' Field ttest
			Call OrdersLocal.UpdateSort(OrdersLocal.ttest)

			' Field cancelleddate
			Call OrdersLocal.UpdateSort(OrdersLocal.cancelleddate)

			' Field cancelledby
			Call OrdersLocal.UpdateSort(OrdersLocal.cancelledby)

			' Field cancelledreason
			Call OrdersLocal.UpdateSort(OrdersLocal.cancelledreason)

			' Field acknowledgeddate
			Call OrdersLocal.UpdateSort(OrdersLocal.acknowledgeddate)

			' Field delivereddate
			Call OrdersLocal.UpdateSort(OrdersLocal.delivereddate)

			' Field cancelled
			Call OrdersLocal.UpdateSort(OrdersLocal.cancelled)

			' Field acknowledged
			Call OrdersLocal.UpdateSort(OrdersLocal.acknowledged)

			' Field outfordelivery
			Call OrdersLocal.UpdateSort(OrdersLocal.outfordelivery)

			' Field vouchercodediscount
			Call OrdersLocal.UpdateSort(OrdersLocal.vouchercodediscount)

			' Field vouchercode
			Call OrdersLocal.UpdateSort(OrdersLocal.vouchercode)

			' Field printed
			Call OrdersLocal.UpdateSort(OrdersLocal.printed)

			' Field deliverydistance
			Call OrdersLocal.UpdateSort(OrdersLocal.deliverydistance)

			' Field asaporder
			Call OrdersLocal.UpdateSort(OrdersLocal.asaporder)

			' Field DeliveryLat
			Call OrdersLocal.UpdateSort(OrdersLocal.DeliveryLat)

			' Field DeliveryLng
			Call OrdersLocal.UpdateSort(OrdersLocal.DeliveryLng)

			' Field ServiceCharge
			Call OrdersLocal.UpdateSort(OrdersLocal.ServiceCharge)

			' Field PaymentSurcharge
			Call OrdersLocal.UpdateSort(OrdersLocal.PaymentSurcharge)

			' Field Tax_Rate
			Call OrdersLocal.UpdateSort(OrdersLocal.Tax_Rate)

			' Field Tax_Amount
			Call OrdersLocal.UpdateSort(OrdersLocal.Tax_Amount)

			' Field Tip_Rate
			Call OrdersLocal.UpdateSort(OrdersLocal.Tip_Rate)

			' Field Tip_Amount
			Call OrdersLocal.UpdateSort(OrdersLocal.Tip_Amount)

			' Field Payment_status
			Call OrdersLocal.UpdateSort(OrdersLocal.Payment_status)
			OrdersLocal.StartRecordNumber = 1 ' Reset start position
		End If
	End Sub

	' -----------------------------------------------------------------
	' Load Sort Order parameters
	'
	Sub LoadSortOrder()
		Dim sOrderBy
		sOrderBy = OrdersLocal.SessionOrderBy ' Get order by from Session
		If sOrderBy = "" Then
			If OrdersLocal.SqlOrderBy <> "" Then
				sOrderBy = OrdersLocal.SqlOrderBy
				OrdersLocal.SessionOrderBy = sOrderBy
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
				OrdersLocal.SessionOrderBy = sOrderBy
				OrdersLocal.ID.Sort = ""
				OrdersLocal.CreationDate.Sort = ""
				OrdersLocal.OrderDate.Sort = ""
				OrdersLocal.DeliveryType.Sort = ""
				OrdersLocal.DeliveryTime.Sort = ""
				OrdersLocal.PaymentType.Sort = ""
				OrdersLocal.SubTotal.Sort = ""
				OrdersLocal.ShippingFee.Sort = ""
				OrdersLocal.OrderTotal.Sort = ""
				OrdersLocal.IdBusinessDetail.Sort = ""
				OrdersLocal.SessionId.Sort = ""
				OrdersLocal.FirstName.Sort = ""
				OrdersLocal.LastName.Sort = ""
				OrdersLocal.zEmail.Sort = ""
				OrdersLocal.Phone.Sort = ""
				OrdersLocal.Address.Sort = ""
				OrdersLocal.PostalCode.Sort = ""
				OrdersLocal.Notes.Sort = ""
				OrdersLocal.ttest.Sort = ""
				OrdersLocal.cancelleddate.Sort = ""
				OrdersLocal.cancelledby.Sort = ""
				OrdersLocal.cancelledreason.Sort = ""
				OrdersLocal.acknowledgeddate.Sort = ""
				OrdersLocal.delivereddate.Sort = ""
				OrdersLocal.cancelled.Sort = ""
				OrdersLocal.acknowledged.Sort = ""
				OrdersLocal.outfordelivery.Sort = ""
				OrdersLocal.vouchercodediscount.Sort = ""
				OrdersLocal.vouchercode.Sort = ""
				OrdersLocal.printed.Sort = ""
				OrdersLocal.deliverydistance.Sort = ""
				OrdersLocal.asaporder.Sort = ""
				OrdersLocal.DeliveryLat.Sort = ""
				OrdersLocal.DeliveryLng.Sort = ""
				OrdersLocal.ServiceCharge.Sort = ""
				OrdersLocal.PaymentSurcharge.Sort = ""
				OrdersLocal.Tax_Rate.Sort = ""
				OrdersLocal.Tax_Amount.Sort = ""
				OrdersLocal.Tip_Rate.Sort = ""
				OrdersLocal.Tip_Amount.Sort = ""
				OrdersLocal.Payment_status.Sort = ""
			End If

			' Reset start position
			StartRec = 1
			OrdersLocal.StartRecordNumber = StartRec
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
		ListOptions.GetItem("checkbox").Body = "<input type=""checkbox"" name=""key_m"" value=""" & ew_HtmlEncode(OrdersLocal.ID.CurrentValue) & """ onclick='ew_ClickMultiCheckbox(event, this);'>"
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
		item.Body = "<a class=""ewAction ewMultiDelete"" title=""" & ew_HtmlTitle(Language.Phrase("DeleteSelectedLink")) & """ data-caption=""" & ew_HtmlTitle(Language.Phrase("DeleteSelectedLink")) & """ href="""" onclick=""ew_SubmitSelected(document.fOrdersLocallist, '" & MultiDeleteUrl & "', ewLanguage.Phrase('DeleteMultiConfirmMsg'));return false;"">" & Language.Phrase("DeleteSelectedLink") & "</a>"
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
			For i = 0 to UBound(OrdersLocal.CustomActions.CustomArray)
				Action = OrdersLocal.CustomActions.CustomArray(i)(0)
				Name = OrdersLocal.CustomActions.CustomArray(i)(1)

				' Add custom action
				Call opt.Add("custom_" & Action)
				Set item = opt.GetItem("custom_" & Action)
				item.Body = "<a class=""ewAction ewCustomAction"" href="""" onclick=""ew_SubmitSelected(document.fOrdersLocallist, '" & ew_CurrentUrl & "', null, '" & Action & "');return false;"">" & Name & "</a>"
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
		sFilter = OrdersLocal.GetKeyFilter
		UserAction = Request.Form("useraction") & ""
		Processed = False
		If sFilter <> "" And UserAction <> "" Then
			OrdersLocal.CurrentFilter = sFilter
			sSql = OrdersLocal.SQL
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
				ElseIf OrdersLocal.CancelMessage <> "" Then
					FailureMessage = OrdersLocal.CancelMessage
					OrdersLocal.CancelMessage = ""
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
		SearchOptions.TableVar = OrdersLocal.TableVar
		ExportOptions.Tag = "div"
		SearchOptions.TagClassName = "ewSearchOption"

		' Search button
		SearchOptions.Add("searchtoggle")
		Set item = SearchOptions.GetItem("searchtoggle")
		SearchToggleClass = ew_IIf(SearchWhere <> "", " active", " active")
		item.Body = "<button type=""button"" class=""btn btn-default ewSearchToggle" & SearchToggleClass & """ title=""" & Language.Phrase("SearchPanel") & """ data-caption=""" & Language.Phrase("SearchPanel") & """ data-toggle=""button"" data-form=""fOrdersLocallistsrch"">" & Language.Phrase("SearchBtn") & "</button>"
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
		If OrdersLocal.Export <> "" Or OrdersLocal.CurrentAction <> "" Then
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
				OrdersLocal.StartRecordNumber = StartRec
			ElseIf Request.QueryString(EW_TABLE_PAGE_NO).Count > 0 Then
				PageNo = Request.QueryString(EW_TABLE_PAGE_NO)
				If IsNumeric(PageNo) Then
					StartRec = (PageNo-1)*DisplayRecs+1
					If StartRec <= 0 Then
						StartRec = 1
					ElseIf StartRec >= ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1 Then
						StartRec = ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1
					End If
					OrdersLocal.StartRecordNumber = StartRec
				End If
			End If
		End If
		StartRec = OrdersLocal.StartRecordNumber

		' Check if correct start record counter
		If Not IsNumeric(StartRec) Or StartRec = "" Then ' Avoid invalid start record counter
			StartRec = 1 ' Reset start record counter
			OrdersLocal.StartRecordNumber = StartRec
		ElseIf CLng(StartRec) > CLng(TotalRecs) Then ' Avoid starting record > total records
			StartRec = ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1 ' Point to last page first record
			OrdersLocal.StartRecordNumber = StartRec
		ElseIf (StartRec-1) Mod DisplayRecs <> 0 Then
			StartRec = ((StartRec-1)\DisplayRecs)*DisplayRecs+1 ' Point to page boundary
			OrdersLocal.StartRecordNumber = StartRec
		End If
	End Sub

	' -----------------------------------------------------------------
	'  Load basic search values
	'
	Function LoadBasicSearchValues()
		OrdersLocal.BasicSearch.Keyword = Request.QueryString(EW_TABLE_BASIC_SEARCH)&""
		If OrdersLocal.BasicSearch.Keyword <> "" Then Command = "search"
		OrdersLocal.BasicSearch.SearchType = Request.QueryString(EW_TABLE_BASIC_SEARCH_TYPE)&""
	End Function

	' -----------------------------------------------------------------
	' Load recordset
	'
	Function LoadRecordset()

		' Load list page sql
		Dim sSql
		sSql = OrdersLocal.SelectSQL
		Call ew_SetDebugMsg("LoadRecordset: " & sSql) ' Show SQL for debugging

		' Load recordset
		Dim RsRecordset
		Set RsRecordset = ew_LoadRecordset(sSql)

		' Call Recordset Selected event
		Call OrdersLocal.Recordset_Selected(RsRecordset)
		Set LoadRecordset = RsRecordset
	End Function

	' -----------------------------------------------------------------
	' Load row based on key values
	'
	Function LoadRow()
		Dim RsRow, sSql, sFilter
		sFilter = OrdersLocal.KeyFilter

		' Call Row Selecting event
		Call OrdersLocal.Row_Selecting(sFilter)

		' Load sql based on filter
		OrdersLocal.CurrentFilter = sFilter
		sSql = OrdersLocal.SQL
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
		Call OrdersLocal.Row_Selected(RsRow)
		OrdersLocal.ID.DbValue = RsRow("ID")
		OrdersLocal.CreationDate.DbValue = RsRow("CreationDate")
		OrdersLocal.OrderDate.DbValue = RsRow("OrderDate")
		OrdersLocal.DeliveryType.DbValue = RsRow("DeliveryType")
		OrdersLocal.DeliveryTime.DbValue = RsRow("DeliveryTime")
		OrdersLocal.PaymentType.DbValue = RsRow("PaymentType")
		OrdersLocal.SubTotal.DbValue = RsRow("SubTotal")
		OrdersLocal.ShippingFee.DbValue = RsRow("ShippingFee")
		OrdersLocal.OrderTotal.DbValue = RsRow("OrderTotal")
		OrdersLocal.IdBusinessDetail.DbValue = RsRow("IdBusinessDetail")
		OrdersLocal.SessionId.DbValue = RsRow("SessionId")
		OrdersLocal.FirstName.DbValue = RsRow("FirstName")
		OrdersLocal.LastName.DbValue = RsRow("LastName")
		OrdersLocal.zEmail.DbValue = RsRow("Email")
		OrdersLocal.Phone.DbValue = RsRow("Phone")
		OrdersLocal.Address.DbValue = RsRow("Address")
		OrdersLocal.PostalCode.DbValue = RsRow("PostalCode")
		OrdersLocal.Notes.DbValue = RsRow("Notes")
		OrdersLocal.ttest.DbValue = RsRow("ttest")
		OrdersLocal.cancelleddate.DbValue = RsRow("cancelleddate")
		OrdersLocal.cancelledby.DbValue = RsRow("cancelledby")
		OrdersLocal.cancelledreason.DbValue = RsRow("cancelledreason")
		OrdersLocal.acknowledgeddate.DbValue = RsRow("acknowledgeddate")
		OrdersLocal.delivereddate.DbValue = RsRow("delivereddate")
		OrdersLocal.cancelled.DbValue = RsRow("cancelled")
		OrdersLocal.acknowledged.DbValue = RsRow("acknowledged")
		OrdersLocal.outfordelivery.DbValue = RsRow("outfordelivery")
		OrdersLocal.vouchercodediscount.DbValue = RsRow("vouchercodediscount")
		OrdersLocal.vouchercode.DbValue = RsRow("vouchercode")
		OrdersLocal.printed.DbValue = RsRow("printed")
		OrdersLocal.deliverydistance.DbValue = RsRow("deliverydistance")
		OrdersLocal.asaporder.DbValue = RsRow("asaporder")
		OrdersLocal.DeliveryLat.DbValue = RsRow("DeliveryLat")
		OrdersLocal.DeliveryLng.DbValue = RsRow("DeliveryLng")
		OrdersLocal.ServiceCharge.DbValue = RsRow("ServiceCharge")
		OrdersLocal.PaymentSurcharge.DbValue = RsRow("PaymentSurcharge")
		OrdersLocal.Tax_Rate.DbValue = RsRow("Tax_Rate")
		OrdersLocal.Tax_Amount.DbValue = RsRow("Tax_Amount")
		OrdersLocal.Tip_Rate.DbValue = RsRow("Tip_Rate")
		OrdersLocal.Tip_Amount.DbValue = RsRow("Tip_Amount")
		OrdersLocal.Payment_status.DbValue = RsRow("Payment_status")
	End Sub

	' Load DbValue from recordset
	Sub LoadDbValues(Rs)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		If Rs.Eof Then Exit Sub
		OrdersLocal.ID.m_DbValue = Rs("ID")
		OrdersLocal.CreationDate.m_DbValue = Rs("CreationDate")
		OrdersLocal.OrderDate.m_DbValue = Rs("OrderDate")
		OrdersLocal.DeliveryType.m_DbValue = Rs("DeliveryType")
		OrdersLocal.DeliveryTime.m_DbValue = Rs("DeliveryTime")
		OrdersLocal.PaymentType.m_DbValue = Rs("PaymentType")
		OrdersLocal.SubTotal.m_DbValue = Rs("SubTotal")
		OrdersLocal.ShippingFee.m_DbValue = Rs("ShippingFee")
		OrdersLocal.OrderTotal.m_DbValue = Rs("OrderTotal")
		OrdersLocal.IdBusinessDetail.m_DbValue = Rs("IdBusinessDetail")
		OrdersLocal.SessionId.m_DbValue = Rs("SessionId")
		OrdersLocal.FirstName.m_DbValue = Rs("FirstName")
		OrdersLocal.LastName.m_DbValue = Rs("LastName")
		OrdersLocal.zEmail.m_DbValue = Rs("Email")
		OrdersLocal.Phone.m_DbValue = Rs("Phone")
		OrdersLocal.Address.m_DbValue = Rs("Address")
		OrdersLocal.PostalCode.m_DbValue = Rs("PostalCode")
		OrdersLocal.Notes.m_DbValue = Rs("Notes")
		OrdersLocal.ttest.m_DbValue = Rs("ttest")
		OrdersLocal.cancelleddate.m_DbValue = Rs("cancelleddate")
		OrdersLocal.cancelledby.m_DbValue = Rs("cancelledby")
		OrdersLocal.cancelledreason.m_DbValue = Rs("cancelledreason")
		OrdersLocal.acknowledgeddate.m_DbValue = Rs("acknowledgeddate")
		OrdersLocal.delivereddate.m_DbValue = Rs("delivereddate")
		OrdersLocal.cancelled.m_DbValue = Rs("cancelled")
		OrdersLocal.acknowledged.m_DbValue = Rs("acknowledged")
		OrdersLocal.outfordelivery.m_DbValue = Rs("outfordelivery")
		OrdersLocal.vouchercodediscount.m_DbValue = Rs("vouchercodediscount")
		OrdersLocal.vouchercode.m_DbValue = Rs("vouchercode")
		OrdersLocal.printed.m_DbValue = Rs("printed")
		OrdersLocal.deliverydistance.m_DbValue = Rs("deliverydistance")
		OrdersLocal.asaporder.m_DbValue = Rs("asaporder")
		OrdersLocal.DeliveryLat.m_DbValue = Rs("DeliveryLat")
		OrdersLocal.DeliveryLng.m_DbValue = Rs("DeliveryLng")
		OrdersLocal.ServiceCharge.m_DbValue = Rs("ServiceCharge")
		OrdersLocal.PaymentSurcharge.m_DbValue = Rs("PaymentSurcharge")
		OrdersLocal.Tax_Rate.m_DbValue = Rs("Tax_Rate")
		OrdersLocal.Tax_Amount.m_DbValue = Rs("Tax_Amount")
		OrdersLocal.Tip_Rate.m_DbValue = Rs("Tip_Rate")
		OrdersLocal.Tip_Amount.m_DbValue = Rs("Tip_Amount")
		OrdersLocal.Payment_status.m_DbValue = Rs("Payment_status")
	End Sub

	' Load old record
	Function LoadOldRecord()

		' Load key values from Session
		Dim bValidKey
		bValidKey = True
		If OrdersLocal.GetKey("ID")&"" <> "" Then
			OrdersLocal.ID.CurrentValue = OrdersLocal.GetKey("ID") ' ID
		Else
			bValidKey = False
		End If

		' Load old recordset
		If bValidKey Then
			OrdersLocal.CurrentFilter = OrdersLocal.KeyFilter
			Dim sSql
			sSql = OrdersLocal.SQL
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
		ViewUrl = OrdersLocal.ViewUrl("")
		EditUrl = OrdersLocal.EditUrl("")
		InlineEditUrl = OrdersLocal.InlineEditUrl
		CopyUrl = OrdersLocal.CopyUrl("")
		InlineCopyUrl = OrdersLocal.InlineCopyUrl
		DeleteUrl = OrdersLocal.DeleteUrl

		' Convert decimal values if posted back
		If OrdersLocal.SubTotal.FormValue = OrdersLocal.SubTotal.CurrentValue And IsNumeric(OrdersLocal.SubTotal.CurrentValue) Then
			OrdersLocal.SubTotal.CurrentValue = ew_StrToFloat(OrdersLocal.SubTotal.CurrentValue)
		End If

		' Convert decimal values if posted back
		If OrdersLocal.ShippingFee.FormValue = OrdersLocal.ShippingFee.CurrentValue And IsNumeric(OrdersLocal.ShippingFee.CurrentValue) Then
			OrdersLocal.ShippingFee.CurrentValue = ew_StrToFloat(OrdersLocal.ShippingFee.CurrentValue)
		End If

		' Convert decimal values if posted back
		If OrdersLocal.OrderTotal.FormValue = OrdersLocal.OrderTotal.CurrentValue And IsNumeric(OrdersLocal.OrderTotal.CurrentValue) Then
			OrdersLocal.OrderTotal.CurrentValue = ew_StrToFloat(OrdersLocal.OrderTotal.CurrentValue)
		End If

		' Convert decimal values if posted back
		If OrdersLocal.ServiceCharge.FormValue = OrdersLocal.ServiceCharge.CurrentValue And IsNumeric(OrdersLocal.ServiceCharge.CurrentValue) Then
			OrdersLocal.ServiceCharge.CurrentValue = ew_StrToFloat(OrdersLocal.ServiceCharge.CurrentValue)
		End If

		' Convert decimal values if posted back
		If OrdersLocal.PaymentSurcharge.FormValue = OrdersLocal.PaymentSurcharge.CurrentValue And IsNumeric(OrdersLocal.PaymentSurcharge.CurrentValue) Then
			OrdersLocal.PaymentSurcharge.CurrentValue = ew_StrToFloat(OrdersLocal.PaymentSurcharge.CurrentValue)
		End If

		' Convert decimal values if posted back
		If OrdersLocal.Tax_Amount.FormValue = OrdersLocal.Tax_Amount.CurrentValue And IsNumeric(OrdersLocal.Tax_Amount.CurrentValue) Then
			OrdersLocal.Tax_Amount.CurrentValue = ew_StrToFloat(OrdersLocal.Tax_Amount.CurrentValue)
		End If

		' Convert decimal values if posted back
		If OrdersLocal.Tip_Amount.FormValue = OrdersLocal.Tip_Amount.CurrentValue And IsNumeric(OrdersLocal.Tip_Amount.CurrentValue) Then
			OrdersLocal.Tip_Amount.CurrentValue = ew_StrToFloat(OrdersLocal.Tip_Amount.CurrentValue)
		End If

		' Call Row Rendering event
		Call OrdersLocal.Row_Rendering()

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
		' Payment_status
		' -----------
		'  View  Row
		' -----------

		If OrdersLocal.RowType = EW_ROWTYPE_VIEW Then ' View row

			' ID
			OrdersLocal.ID.ViewValue = OrdersLocal.ID.CurrentValue
			OrdersLocal.ID.ViewCustomAttributes = ""

			' CreationDate
			OrdersLocal.CreationDate.ViewValue = OrdersLocal.CreationDate.CurrentValue
			OrdersLocal.CreationDate.ViewCustomAttributes = ""

			' OrderDate
			OrdersLocal.OrderDate.ViewValue = OrdersLocal.OrderDate.CurrentValue
			OrdersLocal.OrderDate.ViewCustomAttributes = ""

			' DeliveryType
			OrdersLocal.DeliveryType.ViewValue = OrdersLocal.DeliveryType.CurrentValue
			OrdersLocal.DeliveryType.ViewCustomAttributes = ""

			' DeliveryTime
			OrdersLocal.DeliveryTime.ViewValue = OrdersLocal.DeliveryTime.CurrentValue
			OrdersLocal.DeliveryTime.ViewCustomAttributes = ""

			' PaymentType
			OrdersLocal.PaymentType.ViewValue = OrdersLocal.PaymentType.CurrentValue
			OrdersLocal.PaymentType.ViewCustomAttributes = ""

			' SubTotal
			OrdersLocal.SubTotal.ViewValue = OrdersLocal.SubTotal.CurrentValue
			OrdersLocal.SubTotal.ViewCustomAttributes = ""

			' ShippingFee
			OrdersLocal.ShippingFee.ViewValue = OrdersLocal.ShippingFee.CurrentValue
			OrdersLocal.ShippingFee.ViewCustomAttributes = ""

			' OrderTotal
			OrdersLocal.OrderTotal.ViewValue = OrdersLocal.OrderTotal.CurrentValue
			OrdersLocal.OrderTotal.ViewCustomAttributes = ""

			' IdBusinessDetail
			OrdersLocal.IdBusinessDetail.ViewValue = OrdersLocal.IdBusinessDetail.CurrentValue
			OrdersLocal.IdBusinessDetail.ViewCustomAttributes = ""

			' SessionId
			OrdersLocal.SessionId.ViewValue = OrdersLocal.SessionId.CurrentValue
			OrdersLocal.SessionId.ViewCustomAttributes = ""

			' FirstName
			OrdersLocal.FirstName.ViewValue = OrdersLocal.FirstName.CurrentValue
			OrdersLocal.FirstName.ViewCustomAttributes = ""

			' LastName
			OrdersLocal.LastName.ViewValue = OrdersLocal.LastName.CurrentValue
			OrdersLocal.LastName.ViewCustomAttributes = ""

			' Email
			OrdersLocal.zEmail.ViewValue = OrdersLocal.zEmail.CurrentValue
			OrdersLocal.zEmail.ViewCustomAttributes = ""

			' Phone
			OrdersLocal.Phone.ViewValue = OrdersLocal.Phone.CurrentValue
			OrdersLocal.Phone.ViewCustomAttributes = ""

			' Address
			OrdersLocal.Address.ViewValue = OrdersLocal.Address.CurrentValue
			OrdersLocal.Address.ViewCustomAttributes = ""

			' PostalCode
			OrdersLocal.PostalCode.ViewValue = OrdersLocal.PostalCode.CurrentValue
			OrdersLocal.PostalCode.ViewCustomAttributes = ""

			' Notes
			OrdersLocal.Notes.ViewValue = OrdersLocal.Notes.CurrentValue
			OrdersLocal.Notes.ViewCustomAttributes = ""

			' ttest
			OrdersLocal.ttest.ViewValue = OrdersLocal.ttest.CurrentValue
			OrdersLocal.ttest.ViewCustomAttributes = ""

			' cancelleddate
			OrdersLocal.cancelleddate.ViewValue = OrdersLocal.cancelleddate.CurrentValue
			OrdersLocal.cancelleddate.ViewCustomAttributes = ""

			' cancelledby
			OrdersLocal.cancelledby.ViewValue = OrdersLocal.cancelledby.CurrentValue
			OrdersLocal.cancelledby.ViewCustomAttributes = ""

			' cancelledreason
			OrdersLocal.cancelledreason.ViewValue = OrdersLocal.cancelledreason.CurrentValue
			OrdersLocal.cancelledreason.ViewCustomAttributes = ""

			' acknowledgeddate
			OrdersLocal.acknowledgeddate.ViewValue = OrdersLocal.acknowledgeddate.CurrentValue
			OrdersLocal.acknowledgeddate.ViewCustomAttributes = ""

			' delivereddate
			OrdersLocal.delivereddate.ViewValue = OrdersLocal.delivereddate.CurrentValue
			OrdersLocal.delivereddate.ViewCustomAttributes = ""

			' cancelled
			OrdersLocal.cancelled.ViewValue = OrdersLocal.cancelled.CurrentValue
			OrdersLocal.cancelled.ViewCustomAttributes = ""

			' acknowledged
			OrdersLocal.acknowledged.ViewValue = OrdersLocal.acknowledged.CurrentValue
			OrdersLocal.acknowledged.ViewCustomAttributes = ""

			' outfordelivery
			OrdersLocal.outfordelivery.ViewValue = OrdersLocal.outfordelivery.CurrentValue
			OrdersLocal.outfordelivery.ViewCustomAttributes = ""

			' vouchercodediscount
			OrdersLocal.vouchercodediscount.ViewValue = OrdersLocal.vouchercodediscount.CurrentValue
			OrdersLocal.vouchercodediscount.ViewCustomAttributes = ""

			' vouchercode
			OrdersLocal.vouchercode.ViewValue = OrdersLocal.vouchercode.CurrentValue
			OrdersLocal.vouchercode.ViewCustomAttributes = ""

			' printed
			OrdersLocal.printed.ViewValue = OrdersLocal.printed.CurrentValue
			OrdersLocal.printed.ViewCustomAttributes = ""

			' deliverydistance
			OrdersLocal.deliverydistance.ViewValue = OrdersLocal.deliverydistance.CurrentValue
			OrdersLocal.deliverydistance.ViewCustomAttributes = ""

			' asaporder
			OrdersLocal.asaporder.ViewValue = OrdersLocal.asaporder.CurrentValue
			OrdersLocal.asaporder.ViewCustomAttributes = ""

			' DeliveryLat
			OrdersLocal.DeliveryLat.ViewValue = OrdersLocal.DeliveryLat.CurrentValue
			OrdersLocal.DeliveryLat.ViewCustomAttributes = ""

			' DeliveryLng
			OrdersLocal.DeliveryLng.ViewValue = OrdersLocal.DeliveryLng.CurrentValue
			OrdersLocal.DeliveryLng.ViewCustomAttributes = ""

			' ServiceCharge
			OrdersLocal.ServiceCharge.ViewValue = OrdersLocal.ServiceCharge.CurrentValue
			OrdersLocal.ServiceCharge.ViewCustomAttributes = ""

			' PaymentSurcharge
			OrdersLocal.PaymentSurcharge.ViewValue = OrdersLocal.PaymentSurcharge.CurrentValue
			OrdersLocal.PaymentSurcharge.ViewCustomAttributes = ""

			' Tax_Rate
			OrdersLocal.Tax_Rate.ViewValue = OrdersLocal.Tax_Rate.CurrentValue
			OrdersLocal.Tax_Rate.ViewCustomAttributes = ""

			' Tax_Amount
			OrdersLocal.Tax_Amount.ViewValue = OrdersLocal.Tax_Amount.CurrentValue
			OrdersLocal.Tax_Amount.ViewCustomAttributes = ""

			' Tip_Rate
			OrdersLocal.Tip_Rate.ViewValue = OrdersLocal.Tip_Rate.CurrentValue
			OrdersLocal.Tip_Rate.ViewCustomAttributes = ""

			' Tip_Amount
			OrdersLocal.Tip_Amount.ViewValue = OrdersLocal.Tip_Amount.CurrentValue
			OrdersLocal.Tip_Amount.ViewCustomAttributes = ""

			' Payment_status
			OrdersLocal.Payment_status.ViewValue = OrdersLocal.Payment_status.CurrentValue
			OrdersLocal.Payment_status.ViewCustomAttributes = ""

			' View refer script
			' ID

			OrdersLocal.ID.LinkCustomAttributes = ""
			OrdersLocal.ID.HrefValue = ""
			OrdersLocal.ID.TooltipValue = ""

			' CreationDate
			OrdersLocal.CreationDate.LinkCustomAttributes = ""
			OrdersLocal.CreationDate.HrefValue = ""
			OrdersLocal.CreationDate.TooltipValue = ""

			' OrderDate
			OrdersLocal.OrderDate.LinkCustomAttributes = ""
			OrdersLocal.OrderDate.HrefValue = ""
			OrdersLocal.OrderDate.TooltipValue = ""

			' DeliveryType
			OrdersLocal.DeliveryType.LinkCustomAttributes = ""
			OrdersLocal.DeliveryType.HrefValue = ""
			OrdersLocal.DeliveryType.TooltipValue = ""

			' DeliveryTime
			OrdersLocal.DeliveryTime.LinkCustomAttributes = ""
			OrdersLocal.DeliveryTime.HrefValue = ""
			OrdersLocal.DeliveryTime.TooltipValue = ""

			' PaymentType
			OrdersLocal.PaymentType.LinkCustomAttributes = ""
			OrdersLocal.PaymentType.HrefValue = ""
			OrdersLocal.PaymentType.TooltipValue = ""

			' SubTotal
			OrdersLocal.SubTotal.LinkCustomAttributes = ""
			OrdersLocal.SubTotal.HrefValue = ""
			OrdersLocal.SubTotal.TooltipValue = ""

			' ShippingFee
			OrdersLocal.ShippingFee.LinkCustomAttributes = ""
			OrdersLocal.ShippingFee.HrefValue = ""
			OrdersLocal.ShippingFee.TooltipValue = ""

			' OrderTotal
			OrdersLocal.OrderTotal.LinkCustomAttributes = ""
			OrdersLocal.OrderTotal.HrefValue = ""
			OrdersLocal.OrderTotal.TooltipValue = ""

			' IdBusinessDetail
			OrdersLocal.IdBusinessDetail.LinkCustomAttributes = ""
			OrdersLocal.IdBusinessDetail.HrefValue = ""
			OrdersLocal.IdBusinessDetail.TooltipValue = ""

			' SessionId
			OrdersLocal.SessionId.LinkCustomAttributes = ""
			OrdersLocal.SessionId.HrefValue = ""
			OrdersLocal.SessionId.TooltipValue = ""

			' FirstName
			OrdersLocal.FirstName.LinkCustomAttributes = ""
			OrdersLocal.FirstName.HrefValue = ""
			OrdersLocal.FirstName.TooltipValue = ""

			' LastName
			OrdersLocal.LastName.LinkCustomAttributes = ""
			OrdersLocal.LastName.HrefValue = ""
			OrdersLocal.LastName.TooltipValue = ""

			' Email
			OrdersLocal.zEmail.LinkCustomAttributes = ""
			OrdersLocal.zEmail.HrefValue = ""
			OrdersLocal.zEmail.TooltipValue = ""

			' Phone
			OrdersLocal.Phone.LinkCustomAttributes = ""
			OrdersLocal.Phone.HrefValue = ""
			OrdersLocal.Phone.TooltipValue = ""

			' Address
			OrdersLocal.Address.LinkCustomAttributes = ""
			OrdersLocal.Address.HrefValue = ""
			OrdersLocal.Address.TooltipValue = ""

			' PostalCode
			OrdersLocal.PostalCode.LinkCustomAttributes = ""
			OrdersLocal.PostalCode.HrefValue = ""
			OrdersLocal.PostalCode.TooltipValue = ""

			' Notes
			OrdersLocal.Notes.LinkCustomAttributes = ""
			OrdersLocal.Notes.HrefValue = ""
			OrdersLocal.Notes.TooltipValue = ""

			' ttest
			OrdersLocal.ttest.LinkCustomAttributes = ""
			OrdersLocal.ttest.HrefValue = ""
			OrdersLocal.ttest.TooltipValue = ""

			' cancelleddate
			OrdersLocal.cancelleddate.LinkCustomAttributes = ""
			OrdersLocal.cancelleddate.HrefValue = ""
			OrdersLocal.cancelleddate.TooltipValue = ""

			' cancelledby
			OrdersLocal.cancelledby.LinkCustomAttributes = ""
			OrdersLocal.cancelledby.HrefValue = ""
			OrdersLocal.cancelledby.TooltipValue = ""

			' cancelledreason
			OrdersLocal.cancelledreason.LinkCustomAttributes = ""
			OrdersLocal.cancelledreason.HrefValue = ""
			OrdersLocal.cancelledreason.TooltipValue = ""

			' acknowledgeddate
			OrdersLocal.acknowledgeddate.LinkCustomAttributes = ""
			OrdersLocal.acknowledgeddate.HrefValue = ""
			OrdersLocal.acknowledgeddate.TooltipValue = ""

			' delivereddate
			OrdersLocal.delivereddate.LinkCustomAttributes = ""
			OrdersLocal.delivereddate.HrefValue = ""
			OrdersLocal.delivereddate.TooltipValue = ""

			' cancelled
			OrdersLocal.cancelled.LinkCustomAttributes = ""
			OrdersLocal.cancelled.HrefValue = ""
			OrdersLocal.cancelled.TooltipValue = ""

			' acknowledged
			OrdersLocal.acknowledged.LinkCustomAttributes = ""
			OrdersLocal.acknowledged.HrefValue = ""
			OrdersLocal.acknowledged.TooltipValue = ""

			' outfordelivery
			OrdersLocal.outfordelivery.LinkCustomAttributes = ""
			OrdersLocal.outfordelivery.HrefValue = ""
			OrdersLocal.outfordelivery.TooltipValue = ""

			' vouchercodediscount
			OrdersLocal.vouchercodediscount.LinkCustomAttributes = ""
			OrdersLocal.vouchercodediscount.HrefValue = ""
			OrdersLocal.vouchercodediscount.TooltipValue = ""

			' vouchercode
			OrdersLocal.vouchercode.LinkCustomAttributes = ""
			OrdersLocal.vouchercode.HrefValue = ""
			OrdersLocal.vouchercode.TooltipValue = ""

			' printed
			OrdersLocal.printed.LinkCustomAttributes = ""
			OrdersLocal.printed.HrefValue = ""
			OrdersLocal.printed.TooltipValue = ""

			' deliverydistance
			OrdersLocal.deliverydistance.LinkCustomAttributes = ""
			OrdersLocal.deliverydistance.HrefValue = ""
			OrdersLocal.deliverydistance.TooltipValue = ""

			' asaporder
			OrdersLocal.asaporder.LinkCustomAttributes = ""
			OrdersLocal.asaporder.HrefValue = ""
			OrdersLocal.asaporder.TooltipValue = ""

			' DeliveryLat
			OrdersLocal.DeliveryLat.LinkCustomAttributes = ""
			OrdersLocal.DeliveryLat.HrefValue = ""
			OrdersLocal.DeliveryLat.TooltipValue = ""

			' DeliveryLng
			OrdersLocal.DeliveryLng.LinkCustomAttributes = ""
			OrdersLocal.DeliveryLng.HrefValue = ""
			OrdersLocal.DeliveryLng.TooltipValue = ""

			' ServiceCharge
			OrdersLocal.ServiceCharge.LinkCustomAttributes = ""
			OrdersLocal.ServiceCharge.HrefValue = ""
			OrdersLocal.ServiceCharge.TooltipValue = ""

			' PaymentSurcharge
			OrdersLocal.PaymentSurcharge.LinkCustomAttributes = ""
			OrdersLocal.PaymentSurcharge.HrefValue = ""
			OrdersLocal.PaymentSurcharge.TooltipValue = ""

			' Tax_Rate
			OrdersLocal.Tax_Rate.LinkCustomAttributes = ""
			OrdersLocal.Tax_Rate.HrefValue = ""
			OrdersLocal.Tax_Rate.TooltipValue = ""

			' Tax_Amount
			OrdersLocal.Tax_Amount.LinkCustomAttributes = ""
			OrdersLocal.Tax_Amount.HrefValue = ""
			OrdersLocal.Tax_Amount.TooltipValue = ""

			' Tip_Rate
			OrdersLocal.Tip_Rate.LinkCustomAttributes = ""
			OrdersLocal.Tip_Rate.HrefValue = ""
			OrdersLocal.Tip_Rate.TooltipValue = ""

			' Tip_Amount
			OrdersLocal.Tip_Amount.LinkCustomAttributes = ""
			OrdersLocal.Tip_Amount.HrefValue = ""
			OrdersLocal.Tip_Amount.TooltipValue = ""

			' Payment_status
			OrdersLocal.Payment_status.LinkCustomAttributes = ""
			OrdersLocal.Payment_status.HrefValue = ""
			OrdersLocal.Payment_status.TooltipValue = ""
		End If

		' Call Row Rendered event
		If OrdersLocal.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call OrdersLocal.Row_Rendered()
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
			item.Body = "<a href=""javascript:void(0);"" class=""ewExportLink ewPdf"" title=""" & ew_HtmlEncode(Language.Phrase("ExportToPDFText")) & """ data-caption=""" & ew_HtmlEncode(Language.Phrase("ExportToPDFText")) & """ onclick=""ew_Export(document.fOrdersLocallist,'" & ExportPdfUrl & "','pdf',true);"">" & Language.Phrase("ExportToPDF") & "</a>"
		Else
			item.Body = "<a href=""" & ExportPdfUrl & """ class=""ewExportLink ewPdf"" title=""" & ew_HtmlEncode(Language.Phrase("ExportToPDFText")) & """ data-caption=""" & ew_HtmlEncode(Language.Phrase("ExportToPDFText")) & """>" & Language.Phrase("ExportToPDF") & "</a>"
		End If
		item.Visible = False

		' Export to Email
		ExportOptions.Add("email")
		Set item = ExportOptions.GetItem("email")
		url = ew_IIf(ExportEmailCustom, ",url:'" & PageUrl & "export=email&amp;custom=1'", "")
		item.Body = "<button id=""emf_OrdersLocal"" class=""ewExportLink ewEmail"" title=""" & Language.Phrase("ExportToEmailText") & """ data-caption=""" & Language.Phrase("ExportToEmailText") & """ onclick=""ew_EmailDialogShow({lnk:'emf_OrdersLocal',hdr:ewLanguage.Phrase('ExportToEmailText'),f:document.fOrdersLocallist,sel:false" & url & "});"">" & Language.Phrase("ExportToEmail") & "</button>"
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
		If OrdersLocal.ExportAll Then
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
		If OrdersLocal.Export = "xml" Then
			Set XmlDoc = New cXMLDocument
		Else
			Set OrdersLocal.ExportDoc = New cExportDocument
			Set Doc = OrdersLocal.ExportDoc
			Set Doc.Table = OrdersLocal
			Call Doc.ChangeStyle("h")

			' Call Page Exporting server event
			Doc.ExportCustom = (Not Page_Exporting())
		End If
		Dim rsdetail, detailcnt
		Dim ParentTable
		ParentTable = ""
		If OrdersLocal.Export = "xml" Then
			Call OrdersLocal.ExportXmlDocument(XmlDoc, (ParentTable <> ""), rs, StartRec, StopRec, "")
		Else
			Dim sHeader
			sHeader = PageHeader
			Call Page_DataRendering(sHeader)
			Doc.Text = Doc.Text & sHeader
			Call OrdersLocal.ExportDocument(Doc, rs, StartRec, StopRec, "")
			Dim sFooter
			sFooter = PageFooter
			Call Page_DataRendered(sFooter)
			Doc.Text = Doc.Text & sFooter
		End If

		' Close recordset and connection
		Rs.Close
		Set Rs = Nothing

		' Export header and footer
		If OrdersLocal.Export <> "xml" Then
			Call Doc.ExportHeaderAndFooter()

			' Call Page Exported server event
			Call Page_Exported()
		End If
		If OrdersLocal.Export = "xml" Then
			XmlDoc.Output
			Set XmlDoc = Nothing
		Else
			If OrdersLocal.Export = "email" Then
				Response.Write ExportEmail(Doc.Text)
			ElseIf OrdersLocal.Export = "pdf" Then
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
		Call Breadcrumb.Add("list", OrdersLocal.TableVar, url, "", OrdersLocal.TableVar, True)
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
