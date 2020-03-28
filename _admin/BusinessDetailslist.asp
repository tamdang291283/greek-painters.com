<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="BusinessDetailsinfo.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="userfn12.asp"-->
<% Session.Timeout = 20 %>
<% Call ew_Header(False, EW_CHARSET) %>
<%

' Define page object
Dim BusinessDetails_list
Set BusinessDetails_list = New cBusinessDetails_list
Set Page = BusinessDetails_list

' Page init processing
BusinessDetails_list.Page_Init()

' Page main processing
BusinessDetails_list.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
BusinessDetails_list.Page_Render()
%>
<!--#include file="header.asp"-->
<% If BusinessDetails.Export = "" Then %>
<script type="text/javascript">
// Page object
var BusinessDetails_list = new ew_Page("BusinessDetails_list");
BusinessDetails_list.PageID = "list"; // Page ID
var EW_PAGE_ID = BusinessDetails_list.PageID; // For backward compatibility
// Form object
var fBusinessDetailslist = new ew_Form("fBusinessDetailslist");
fBusinessDetailslist.FormKeyCountName = '<%= BusinessDetails_list.FormKeyCountName %>';
// Form_CustomValidate event
fBusinessDetailslist.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fBusinessDetailslist.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fBusinessDetailslist.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
var fBusinessDetailslistsrch = new ew_Form("fBusinessDetailslistsrch");
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
<% If BusinessDetails.Export = "" Then %>
<div class="ewToolbar">
<% If BusinessDetails.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If BusinessDetails_list.TotalRecs > 0 And BusinessDetails_list.ExportOptions.Visible Then %>
<% BusinessDetails_list.ExportOptions.Render "body", "", "", "", "", "" %>
<% End If %>
<% If BusinessDetails_list.SearchOptions.Visible Then %>
<% BusinessDetails_list.SearchOptions.Render "body", "", "", "", "", "" %>
<% End If %>
<% If BusinessDetails.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% End If %>
<% If (BusinessDetails.Export = "") Or (EW_EXPORT_MASTER_RECORD And BusinessDetails.Export = "print") Then %>
<% End If %>
<%

' Load recordset
'Set BusinessDetails_list.Recordset = BusinessDetails_list.LoadRecordset()

	BusinessDetails_list.TotalRecs = BusinessDetails_list.Recordset.RecordCount
	BusinessDetails_list.StartRec = 1
	If BusinessDetails_list.DisplayRecs <= 0 Then ' Display all records
		BusinessDetails_list.DisplayRecs = BusinessDetails_list.TotalRecs
	End If
	If Not (BusinessDetails.ExportAll And BusinessDetails.Export <> "") Then
		BusinessDetails_list.SetUpStartRec() ' Set up start record position
	End If

	' Set no record found message
	If BusinessDetails.CurrentAction = "" And BusinessDetails_list.TotalRecs = 0 Then
		If BusinessDetails_list.SearchWhere = "0=101" Then
			BusinessDetails_list.WarningMessage = Language.Phrase("EnterSearchCriteria")
		Else
			BusinessDetails_list.WarningMessage = Language.Phrase("NoRecord")
		End If
	End If
BusinessDetails_list.RenderOtherOptions()
%>
<% If BusinessDetails.Export = "" And BusinessDetails.CurrentAction = "" Then %>
<form name="fBusinessDetailslistsrch" id="fBusinessDetailslistsrch" class="form-inline ewForm" action="<%= ew_CurrentPage %>">
<% SearchPanelClass = ew_IIf(BusinessDetails_list.SearchWhere <> "", " in", " in") %>
<div id="fBusinessDetailslistsrch_SearchPanel" class="ewSearchPanel collapse<%= SearchPanelClass %>">
<input type="hidden" name="cmd" value="search">
<input type="hidden" name="t" value="BusinessDetails">
	<div class="ewBasicSearch">
<div id="xsr_1" class="ewRow">
	<div class="ewQuickSearch input-group">
	<input type="text" name="<%= EW_TABLE_BASIC_SEARCH %>" id="<%= EW_TABLE_BASIC_SEARCH %>" class="form-control" value="<%= ew_HtmlEncode(BusinessDetails.BasicSearch.getKeyword()) %>" placeholder="<%= ew_HtmlEncode(Language.Phrase("Search")) %>">
	<input type="hidden" name="<%= EW_TABLE_BASIC_SEARCH_TYPE %>" id="<%= EW_TABLE_BASIC_SEARCH_TYPE %>" value="<%= ew_HtmlEncode(BusinessDetails.BasicSearch.getSearchType()) %>">
	<div class="input-group-btn">
		<button type="button" data-toggle="dropdown" class="btn btn-default"><span id="searchtype"><%= BusinessDetails.BasicSearch.getSearchTypeNameShort() %></span><span class="caret"></span></button>
		<ul class="dropdown-menu pull-right" role="menu">
			<li<% If BusinessDetails.BasicSearch.getSearchType() = "" Then Response.Write " class=""active""" %>><a href="javascript:void(0);" onclick="ew_SetSearchType(this)"><%= Language.Phrase("QuickSearchAuto") %></a></li>
			<li<% If BusinessDetails.BasicSearch.getSearchType() = "=" Then Response.Write " class=""active""" %>><a href="javascript:void(0);" onclick="ew_SetSearchType(this,'=')"><%= Language.Phrase("QuickSearchExact") %></a></li>
			<li<% If BusinessDetails.BasicSearch.getSearchType() = "AND" Then Response.Write " class=""active""" %>><a href="javascript:void(0);" onclick="ew_SetSearchType(this,'AND')"><%= Language.Phrase("QuickSearchAll") %></a></li>
			<li<% If BusinessDetails.BasicSearch.getSearchType() = "OR" Then Response.Write " class=""active""" %>><a href="javascript:void(0);" onclick="ew_SetSearchType(this,'OR')"><%= Language.Phrase("QuickSearchAny") %></a></li>
		</ul>
	<button class="btn btn-primary ewButton" name="btnsubmit" id="btnsubmit" type="submit"><%= Language.Phrase("QuickSearchBtn") %></button>
	</div>
	</div>
</div>
	</div>
</div>
</form>
<% End If %>
<% BusinessDetails_list.ShowPageHeader() %>
<% BusinessDetails_list.ShowMessage %>
<% If BusinessDetails_list.TotalRecs > 0 Or BusinessDetails.CurrentAction <> "" Then %>
<div class="ewGrid">
<% If BusinessDetails.Export = "" Then %>
<div class="ewGridUpperPanel">
<% If BusinessDetails.CurrentAction <> "gridadd" And BusinessDetails.CurrentAction <> "gridedit" Then %>
<form name="ewPagerForm" class="form-inline ewForm ewPagerForm" action="<%= ew_CurrentPage %>">
<% If Not IsObject(BusinessDetails_list.Pager) Then Set BusinessDetails_list.Pager = ew_NewPrevNextPager(BusinessDetails_list.StartRec, BusinessDetails_list.DisplayRecs, BusinessDetails_list.TotalRecs) %>
<% If BusinessDetails_list.Pager.RecordCount > 0 Then %>
<div class="ewPager">
<span><%= Language.Phrase("Page") %>&nbsp;</span>
<div class="ewPrevNext"><div class="input-group">
<div class="input-group-btn">
<!--first page button-->
	<% If BusinessDetails_list.Pager.FirstButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerFirst") %>" href="<%= BusinessDetails_list.PageUrl %>start=<%= BusinessDetails_list.Pager.FirstButton.Start %>"><span class="icon-first ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerFirst") %>"><span class="icon-first ewIcon"></span></a>
	<% End If %>
<!--previous page button-->
	<% If BusinessDetails_list.Pager.PrevButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerPrevious") %>" href="<%= BusinessDetails_list.PageUrl %>start=<%= BusinessDetails_list.Pager.PrevButton.Start %>"><span class="icon-prev ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerPrevious") %>"><span class="icon-prev ewIcon"></span></a>
	<% End If %>
</div>
<!--current page number-->
	<input class="form-control input-sm" type="text" name="<%= EW_TABLE_PAGE_NO %>" value="<%= BusinessDetails_list.Pager.CurrentPage %>">
<div class="input-group-btn">
<!--next page button-->
	<% If BusinessDetails_list.Pager.NextButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerNext") %>" href="<%= BusinessDetails_list.PageUrl %>start=<%= BusinessDetails_list.Pager.NextButton.Start %>"><span class="icon-next ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerNext") %>"><span class="icon-next ewIcon"></span></a>
	<% End If %>
<!--last page button-->
	<% If BusinessDetails_list.Pager.LastButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerLast") %>" href="<%= BusinessDetails_list.PageUrl %>start=<%= BusinessDetails_list.Pager.LastButton.Start %>"><span class="icon-last ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerLast") %>"><span class="icon-last ewIcon"></span></a>
	<% End If %>
</div>
</div>
</div>
<span>&nbsp;<%= Language.Phrase("of") %>&nbsp;<%= BusinessDetails_list.Pager.PageCount %></span>
</div>
<div class="ewPager ewRec">
	<span><%= Language.Phrase("Record") %>&nbsp;<%= BusinessDetails_list.Pager.FromIndex %>&nbsp;<%= Language.Phrase("To") %>&nbsp;<%= BusinessDetails_list.Pager.ToIndex %>&nbsp;<%= Language.Phrase("Of") %>&nbsp;<%= BusinessDetails_list.Pager.RecordCount %></span>
</div>
<% End If %>
<% If BusinessDetails_list.TotalRecs > 0 Then %>
<div class="ewPager">
<input type="hidden" name="t" value="BusinessDetails">
<select name="<%= EW_TABLE_REC_PER_PAGE %>" class="form-control input-sm" onchange="this.form.submit();">
<option value="20"<% If BusinessDetails_list.DisplayRecs = 20 Then %> selected="selected"<% End If %>>20</option>
<option value="50"<% If BusinessDetails_list.DisplayRecs = 50 Then %> selected="selected"<% End If %>>50</option>
<option value="100"<% If BusinessDetails_list.DisplayRecs = 100 Then %> selected="selected"<% End If %>>100</option>
<option value="500"<% If BusinessDetails_list.DisplayRecs = 500 Then %> selected="selected"<% End If %>>500</option>
<option value="1000"<% If BusinessDetails_list.DisplayRecs = 1000 Then %> selected="selected"<% End If %>>1000</option>
<option value="ALL"<% If BusinessDetails.RecordsPerPage = -1 Then %> selected="selected"<% End If %>><%= Language.Phrase("AllRecords") %></option>
</select>
</div>
<% End If %>
</form>
<% End If %>
<div class="ewListOtherOptions">
<%
	BusinessDetails_list.AddEditOptions.Render "body", "", "", "", "", ""
	BusinessDetails_list.DetailOptions.Render "body", "", "", "", "", ""
	BusinessDetails_list.ActionOptions.Render "body", "", "", "", "", ""
%>
</div>
<div class="clearfix"></div>
</div>
<% End If %>
<form name="fBusinessDetailslist" id="fBusinessDetailslist" class="form-inline ewForm ewListForm" action="<%= ew_CurrentPage %>" method="post">
<% If BusinessDetails_list.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= BusinessDetails_list.Token %>">
<% End If %>
<input type="hidden" name="t" value="BusinessDetails">
<div id="gmp_BusinessDetails" class="<% If ew_IsResponsiveLayout() Then Response.Write "table-responsive " %>ewGridMiddlePanel">
<% If BusinessDetails_list.TotalRecs > 0 Then %>
<table id="tbl_BusinessDetailslist" class="table ewTable">
<%= BusinessDetails.TableCustomInnerHtml %>
<thead><!-- Table header -->
	<tr class="ewTableHeader">
<%

' Header row
BusinessDetails.RowType = EW_ROWTYPE_HEADER
Call BusinessDetails_list.RenderListOptions()

' Render list options (header, left)
BusinessDetails_list.ListOptions.Render "header", "left", "", "", "", ""
%>
<% If BusinessDetails.ID.Visible Then ' ID %>
	<% If BusinessDetails.SortUrl(BusinessDetails.ID) = "" Then %>
		<th data-name="ID"><div id="elh_BusinessDetails_ID" class="BusinessDetails_ID"><div class="ewTableHeaderCaption"><%= BusinessDetails.ID.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="ID"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.ID) %>',1);"><div id="elh_BusinessDetails_ID" class="BusinessDetails_ID">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.ID.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.ID.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.ID.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.Name.Visible Then ' Name %>
	<% If BusinessDetails.SortUrl(BusinessDetails.Name) = "" Then %>
		<th data-name="Name"><div id="elh_BusinessDetails_Name" class="BusinessDetails_Name"><div class="ewTableHeaderCaption"><%= BusinessDetails.Name.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Name"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.Name) %>',1);"><div id="elh_BusinessDetails_Name" class="BusinessDetails_Name">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.Name.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.Name.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.Name.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.Address.Visible Then ' Address %>
	<% If BusinessDetails.SortUrl(BusinessDetails.Address) = "" Then %>
		<th data-name="Address"><div id="elh_BusinessDetails_Address" class="BusinessDetails_Address"><div class="ewTableHeaderCaption"><%= BusinessDetails.Address.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Address"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.Address) %>',1);"><div id="elh_BusinessDetails_Address" class="BusinessDetails_Address">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.Address.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.Address.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.Address.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.PostalCode.Visible Then ' PostalCode %>
	<% If BusinessDetails.SortUrl(BusinessDetails.PostalCode) = "" Then %>
		<th data-name="PostalCode"><div id="elh_BusinessDetails_PostalCode" class="BusinessDetails_PostalCode"><div class="ewTableHeaderCaption"><%= BusinessDetails.PostalCode.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="PostalCode"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.PostalCode) %>',1);"><div id="elh_BusinessDetails_PostalCode" class="BusinessDetails_PostalCode">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.PostalCode.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.PostalCode.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.PostalCode.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.FoodType.Visible Then ' FoodType %>
	<% If BusinessDetails.SortUrl(BusinessDetails.FoodType) = "" Then %>
		<th data-name="FoodType"><div id="elh_BusinessDetails_FoodType" class="BusinessDetails_FoodType"><div class="ewTableHeaderCaption"><%= BusinessDetails.FoodType.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="FoodType"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.FoodType) %>',1);"><div id="elh_BusinessDetails_FoodType" class="BusinessDetails_FoodType">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.FoodType.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.FoodType.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.FoodType.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.DeliveryMinAmount.Visible Then ' DeliveryMinAmount %>
	<% If BusinessDetails.SortUrl(BusinessDetails.DeliveryMinAmount) = "" Then %>
		<th data-name="DeliveryMinAmount"><div id="elh_BusinessDetails_DeliveryMinAmount" class="BusinessDetails_DeliveryMinAmount"><div class="ewTableHeaderCaption"><%= BusinessDetails.DeliveryMinAmount.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="DeliveryMinAmount"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.DeliveryMinAmount) %>',1);"><div id="elh_BusinessDetails_DeliveryMinAmount" class="BusinessDetails_DeliveryMinAmount">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.DeliveryMinAmount.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.DeliveryMinAmount.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.DeliveryMinAmount.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.DeliveryMaxDistance.Visible Then ' DeliveryMaxDistance %>
	<% If BusinessDetails.SortUrl(BusinessDetails.DeliveryMaxDistance) = "" Then %>
		<th data-name="DeliveryMaxDistance"><div id="elh_BusinessDetails_DeliveryMaxDistance" class="BusinessDetails_DeliveryMaxDistance"><div class="ewTableHeaderCaption"><%= BusinessDetails.DeliveryMaxDistance.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="DeliveryMaxDistance"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.DeliveryMaxDistance) %>',1);"><div id="elh_BusinessDetails_DeliveryMaxDistance" class="BusinessDetails_DeliveryMaxDistance">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.DeliveryMaxDistance.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.DeliveryMaxDistance.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.DeliveryMaxDistance.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.DeliveryFreeDistance.Visible Then ' DeliveryFreeDistance %>
	<% If BusinessDetails.SortUrl(BusinessDetails.DeliveryFreeDistance) = "" Then %>
		<th data-name="DeliveryFreeDistance"><div id="elh_BusinessDetails_DeliveryFreeDistance" class="BusinessDetails_DeliveryFreeDistance"><div class="ewTableHeaderCaption"><%= BusinessDetails.DeliveryFreeDistance.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="DeliveryFreeDistance"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.DeliveryFreeDistance) %>',1);"><div id="elh_BusinessDetails_DeliveryFreeDistance" class="BusinessDetails_DeliveryFreeDistance">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.DeliveryFreeDistance.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.DeliveryFreeDistance.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.DeliveryFreeDistance.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.AverageDeliveryTime.Visible Then ' AverageDeliveryTime %>
	<% If BusinessDetails.SortUrl(BusinessDetails.AverageDeliveryTime) = "" Then %>
		<th data-name="AverageDeliveryTime"><div id="elh_BusinessDetails_AverageDeliveryTime" class="BusinessDetails_AverageDeliveryTime"><div class="ewTableHeaderCaption"><%= BusinessDetails.AverageDeliveryTime.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="AverageDeliveryTime"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.AverageDeliveryTime) %>',1);"><div id="elh_BusinessDetails_AverageDeliveryTime" class="BusinessDetails_AverageDeliveryTime">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.AverageDeliveryTime.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.AverageDeliveryTime.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.AverageDeliveryTime.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.AverageCollectionTime.Visible Then ' AverageCollectionTime %>
	<% If BusinessDetails.SortUrl(BusinessDetails.AverageCollectionTime) = "" Then %>
		<th data-name="AverageCollectionTime"><div id="elh_BusinessDetails_AverageCollectionTime" class="BusinessDetails_AverageCollectionTime"><div class="ewTableHeaderCaption"><%= BusinessDetails.AverageCollectionTime.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="AverageCollectionTime"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.AverageCollectionTime) %>',1);"><div id="elh_BusinessDetails_AverageCollectionTime" class="BusinessDetails_AverageCollectionTime">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.AverageCollectionTime.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.AverageCollectionTime.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.AverageCollectionTime.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.DeliveryFee.Visible Then ' DeliveryFee %>
	<% If BusinessDetails.SortUrl(BusinessDetails.DeliveryFee) = "" Then %>
		<th data-name="DeliveryFee"><div id="elh_BusinessDetails_DeliveryFee" class="BusinessDetails_DeliveryFee"><div class="ewTableHeaderCaption"><%= BusinessDetails.DeliveryFee.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="DeliveryFee"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.DeliveryFee) %>',1);"><div id="elh_BusinessDetails_DeliveryFee" class="BusinessDetails_DeliveryFee">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.DeliveryFee.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.DeliveryFee.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.DeliveryFee.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.ImgUrl.Visible Then ' ImgUrl %>
	<% If BusinessDetails.SortUrl(BusinessDetails.ImgUrl) = "" Then %>
		<th data-name="ImgUrl"><div id="elh_BusinessDetails_ImgUrl" class="BusinessDetails_ImgUrl"><div class="ewTableHeaderCaption"><%= BusinessDetails.ImgUrl.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="ImgUrl"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.ImgUrl) %>',1);"><div id="elh_BusinessDetails_ImgUrl" class="BusinessDetails_ImgUrl">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.ImgUrl.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.ImgUrl.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.ImgUrl.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.Telephone.Visible Then ' Telephone %>
	<% If BusinessDetails.SortUrl(BusinessDetails.Telephone) = "" Then %>
		<th data-name="Telephone"><div id="elh_BusinessDetails_Telephone" class="BusinessDetails_Telephone"><div class="ewTableHeaderCaption"><%= BusinessDetails.Telephone.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Telephone"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.Telephone) %>',1);"><div id="elh_BusinessDetails_Telephone" class="BusinessDetails_Telephone">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.Telephone.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.Telephone.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.Telephone.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.zEmail.Visible Then ' Email %>
	<% If BusinessDetails.SortUrl(BusinessDetails.zEmail) = "" Then %>
		<th data-name="zEmail"><div id="elh_BusinessDetails_zEmail" class="BusinessDetails_zEmail"><div class="ewTableHeaderCaption"><%= BusinessDetails.zEmail.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="zEmail"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.zEmail) %>',1);"><div id="elh_BusinessDetails_zEmail" class="BusinessDetails_zEmail">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.zEmail.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.zEmail.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.zEmail.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.pswd.Visible Then ' pswd %>
	<% If BusinessDetails.SortUrl(BusinessDetails.pswd) = "" Then %>
		<th data-name="pswd"><div id="elh_BusinessDetails_pswd" class="BusinessDetails_pswd"><div class="ewTableHeaderCaption"><%= BusinessDetails.pswd.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="pswd"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.pswd) %>',1);"><div id="elh_BusinessDetails_pswd" class="BusinessDetails_pswd">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.pswd.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.pswd.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.pswd.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.businessclosed.Visible Then ' businessclosed %>
	<% If BusinessDetails.SortUrl(BusinessDetails.businessclosed) = "" Then %>
		<th data-name="businessclosed"><div id="elh_BusinessDetails_businessclosed" class="BusinessDetails_businessclosed"><div class="ewTableHeaderCaption"><%= BusinessDetails.businessclosed.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="businessclosed"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.businessclosed) %>',1);"><div id="elh_BusinessDetails_businessclosed" class="BusinessDetails_businessclosed">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.businessclosed.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.businessclosed.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.businessclosed.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.SMTP_AUTENTICATE.Visible Then ' SMTP_AUTENTICATE %>
	<% If BusinessDetails.SortUrl(BusinessDetails.SMTP_AUTENTICATE) = "" Then %>
		<th data-name="SMTP_AUTENTICATE"><div id="elh_BusinessDetails_SMTP_AUTENTICATE" class="BusinessDetails_SMTP_AUTENTICATE"><div class="ewTableHeaderCaption"><%= BusinessDetails.SMTP_AUTENTICATE.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="SMTP_AUTENTICATE"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.SMTP_AUTENTICATE) %>',1);"><div id="elh_BusinessDetails_SMTP_AUTENTICATE" class="BusinessDetails_SMTP_AUTENTICATE">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.SMTP_AUTENTICATE.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.SMTP_AUTENTICATE.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.SMTP_AUTENTICATE.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.MAIL_FROM.Visible Then ' MAIL_FROM %>
	<% If BusinessDetails.SortUrl(BusinessDetails.MAIL_FROM) = "" Then %>
		<th data-name="MAIL_FROM"><div id="elh_BusinessDetails_MAIL_FROM" class="BusinessDetails_MAIL_FROM"><div class="ewTableHeaderCaption"><%= BusinessDetails.MAIL_FROM.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="MAIL_FROM"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.MAIL_FROM) %>',1);"><div id="elh_BusinessDetails_MAIL_FROM" class="BusinessDetails_MAIL_FROM">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.MAIL_FROM.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.MAIL_FROM.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.MAIL_FROM.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.PAYPAL_URL.Visible Then ' PAYPAL_URL %>
	<% If BusinessDetails.SortUrl(BusinessDetails.PAYPAL_URL) = "" Then %>
		<th data-name="PAYPAL_URL"><div id="elh_BusinessDetails_PAYPAL_URL" class="BusinessDetails_PAYPAL_URL"><div class="ewTableHeaderCaption"><%= BusinessDetails.PAYPAL_URL.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="PAYPAL_URL"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.PAYPAL_URL) %>',1);"><div id="elh_BusinessDetails_PAYPAL_URL" class="BusinessDetails_PAYPAL_URL">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.PAYPAL_URL.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.PAYPAL_URL.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.PAYPAL_URL.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.PAYPAL_PDT.Visible Then ' PAYPAL_PDT %>
	<% If BusinessDetails.SortUrl(BusinessDetails.PAYPAL_PDT) = "" Then %>
		<th data-name="PAYPAL_PDT"><div id="elh_BusinessDetails_PAYPAL_PDT" class="BusinessDetails_PAYPAL_PDT"><div class="ewTableHeaderCaption"><%= BusinessDetails.PAYPAL_PDT.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="PAYPAL_PDT"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.PAYPAL_PDT) %>',1);"><div id="elh_BusinessDetails_PAYPAL_PDT" class="BusinessDetails_PAYPAL_PDT">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.PAYPAL_PDT.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.PAYPAL_PDT.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.PAYPAL_PDT.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.SMTP_PASSWORD.Visible Then ' SMTP_PASSWORD %>
	<% If BusinessDetails.SortUrl(BusinessDetails.SMTP_PASSWORD) = "" Then %>
		<th data-name="SMTP_PASSWORD"><div id="elh_BusinessDetails_SMTP_PASSWORD" class="BusinessDetails_SMTP_PASSWORD"><div class="ewTableHeaderCaption"><%= BusinessDetails.SMTP_PASSWORD.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="SMTP_PASSWORD"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.SMTP_PASSWORD) %>',1);"><div id="elh_BusinessDetails_SMTP_PASSWORD" class="BusinessDetails_SMTP_PASSWORD">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.SMTP_PASSWORD.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.SMTP_PASSWORD.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.SMTP_PASSWORD.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.GMAP_API_KEY.Visible Then ' GMAP_API_KEY %>
	<% If BusinessDetails.SortUrl(BusinessDetails.GMAP_API_KEY) = "" Then %>
		<th data-name="GMAP_API_KEY"><div id="elh_BusinessDetails_GMAP_API_KEY" class="BusinessDetails_GMAP_API_KEY"><div class="ewTableHeaderCaption"><%= BusinessDetails.GMAP_API_KEY.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="GMAP_API_KEY"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.GMAP_API_KEY) %>',1);"><div id="elh_BusinessDetails_GMAP_API_KEY" class="BusinessDetails_GMAP_API_KEY">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.GMAP_API_KEY.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.GMAP_API_KEY.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.GMAP_API_KEY.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.SMTP_USERNAME.Visible Then ' SMTP_USERNAME %>
	<% If BusinessDetails.SortUrl(BusinessDetails.SMTP_USERNAME) = "" Then %>
		<th data-name="SMTP_USERNAME"><div id="elh_BusinessDetails_SMTP_USERNAME" class="BusinessDetails_SMTP_USERNAME"><div class="ewTableHeaderCaption"><%= BusinessDetails.SMTP_USERNAME.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="SMTP_USERNAME"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.SMTP_USERNAME) %>',1);"><div id="elh_BusinessDetails_SMTP_USERNAME" class="BusinessDetails_SMTP_USERNAME">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.SMTP_USERNAME.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.SMTP_USERNAME.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.SMTP_USERNAME.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.SMTP_USESSL.Visible Then ' SMTP_USESSL %>
	<% If BusinessDetails.SortUrl(BusinessDetails.SMTP_USESSL) = "" Then %>
		<th data-name="SMTP_USESSL"><div id="elh_BusinessDetails_SMTP_USESSL" class="BusinessDetails_SMTP_USESSL"><div class="ewTableHeaderCaption"><%= BusinessDetails.SMTP_USESSL.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="SMTP_USESSL"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.SMTP_USESSL) %>',1);"><div id="elh_BusinessDetails_SMTP_USESSL" class="BusinessDetails_SMTP_USESSL">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.SMTP_USESSL.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.SMTP_USESSL.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.SMTP_USESSL.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.MAIL_SUBJECT.Visible Then ' MAIL_SUBJECT %>
	<% If BusinessDetails.SortUrl(BusinessDetails.MAIL_SUBJECT) = "" Then %>
		<th data-name="MAIL_SUBJECT"><div id="elh_BusinessDetails_MAIL_SUBJECT" class="BusinessDetails_MAIL_SUBJECT"><div class="ewTableHeaderCaption"><%= BusinessDetails.MAIL_SUBJECT.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="MAIL_SUBJECT"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.MAIL_SUBJECT) %>',1);"><div id="elh_BusinessDetails_MAIL_SUBJECT" class="BusinessDetails_MAIL_SUBJECT">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.MAIL_SUBJECT.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.MAIL_SUBJECT.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.MAIL_SUBJECT.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.CURRENCYSYMBOL.Visible Then ' CURRENCYSYMBOL %>
	<% If BusinessDetails.SortUrl(BusinessDetails.CURRENCYSYMBOL) = "" Then %>
		<th data-name="CURRENCYSYMBOL"><div id="elh_BusinessDetails_CURRENCYSYMBOL" class="BusinessDetails_CURRENCYSYMBOL"><div class="ewTableHeaderCaption"><%= BusinessDetails.CURRENCYSYMBOL.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="CURRENCYSYMBOL"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.CURRENCYSYMBOL) %>',1);"><div id="elh_BusinessDetails_CURRENCYSYMBOL" class="BusinessDetails_CURRENCYSYMBOL">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.CURRENCYSYMBOL.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.CURRENCYSYMBOL.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.CURRENCYSYMBOL.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.SMTP_SERVER.Visible Then ' SMTP_SERVER %>
	<% If BusinessDetails.SortUrl(BusinessDetails.SMTP_SERVER) = "" Then %>
		<th data-name="SMTP_SERVER"><div id="elh_BusinessDetails_SMTP_SERVER" class="BusinessDetails_SMTP_SERVER"><div class="ewTableHeaderCaption"><%= BusinessDetails.SMTP_SERVER.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="SMTP_SERVER"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.SMTP_SERVER) %>',1);"><div id="elh_BusinessDetails_SMTP_SERVER" class="BusinessDetails_SMTP_SERVER">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.SMTP_SERVER.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.SMTP_SERVER.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.SMTP_SERVER.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.CREDITCARDSURCHARGE.Visible Then ' CREDITCARDSURCHARGE %>
	<% If BusinessDetails.SortUrl(BusinessDetails.CREDITCARDSURCHARGE) = "" Then %>
		<th data-name="CREDITCARDSURCHARGE"><div id="elh_BusinessDetails_CREDITCARDSURCHARGE" class="BusinessDetails_CREDITCARDSURCHARGE"><div class="ewTableHeaderCaption"><%= BusinessDetails.CREDITCARDSURCHARGE.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="CREDITCARDSURCHARGE"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.CREDITCARDSURCHARGE) %>',1);"><div id="elh_BusinessDetails_CREDITCARDSURCHARGE" class="BusinessDetails_CREDITCARDSURCHARGE">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.CREDITCARDSURCHARGE.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.CREDITCARDSURCHARGE.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.CREDITCARDSURCHARGE.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.SMTP_PORT.Visible Then ' SMTP_PORT %>
	<% If BusinessDetails.SortUrl(BusinessDetails.SMTP_PORT) = "" Then %>
		<th data-name="SMTP_PORT"><div id="elh_BusinessDetails_SMTP_PORT" class="BusinessDetails_SMTP_PORT"><div class="ewTableHeaderCaption"><%= BusinessDetails.SMTP_PORT.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="SMTP_PORT"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.SMTP_PORT) %>',1);"><div id="elh_BusinessDetails_SMTP_PORT" class="BusinessDetails_SMTP_PORT">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.SMTP_PORT.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.SMTP_PORT.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.SMTP_PORT.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.STICK_MENU.Visible Then ' STICK_MENU %>
	<% If BusinessDetails.SortUrl(BusinessDetails.STICK_MENU) = "" Then %>
		<th data-name="STICK_MENU"><div id="elh_BusinessDetails_STICK_MENU" class="BusinessDetails_STICK_MENU"><div class="ewTableHeaderCaption"><%= BusinessDetails.STICK_MENU.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="STICK_MENU"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.STICK_MENU) %>',1);"><div id="elh_BusinessDetails_STICK_MENU" class="BusinessDetails_STICK_MENU">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.STICK_MENU.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.STICK_MENU.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.STICK_MENU.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.MAIL_CUSTOMER_SUBJECT.Visible Then ' MAIL_CUSTOMER_SUBJECT %>
	<% If BusinessDetails.SortUrl(BusinessDetails.MAIL_CUSTOMER_SUBJECT) = "" Then %>
		<th data-name="MAIL_CUSTOMER_SUBJECT"><div id="elh_BusinessDetails_MAIL_CUSTOMER_SUBJECT" class="BusinessDetails_MAIL_CUSTOMER_SUBJECT"><div class="ewTableHeaderCaption"><%= BusinessDetails.MAIL_CUSTOMER_SUBJECT.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="MAIL_CUSTOMER_SUBJECT"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.MAIL_CUSTOMER_SUBJECT) %>',1);"><div id="elh_BusinessDetails_MAIL_CUSTOMER_SUBJECT" class="BusinessDetails_MAIL_CUSTOMER_SUBJECT">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.MAIL_CUSTOMER_SUBJECT.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.MAIL_CUSTOMER_SUBJECT.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.MAIL_CUSTOMER_SUBJECT.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.Visible Then ' CONFIRMATION_EMAIL_ADDRESS %>
	<% If BusinessDetails.SortUrl(BusinessDetails.CONFIRMATION_EMAIL_ADDRESS) = "" Then %>
		<th data-name="CONFIRMATION_EMAIL_ADDRESS"><div id="elh_BusinessDetails_CONFIRMATION_EMAIL_ADDRESS" class="BusinessDetails_CONFIRMATION_EMAIL_ADDRESS"><div class="ewTableHeaderCaption"><%= BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="CONFIRMATION_EMAIL_ADDRESS"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.CONFIRMATION_EMAIL_ADDRESS) %>',1);"><div id="elh_BusinessDetails_CONFIRMATION_EMAIL_ADDRESS" class="BusinessDetails_CONFIRMATION_EMAIL_ADDRESS">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.SEND_ORDERS_TO_PRINTER.Visible Then ' SEND_ORDERS_TO_PRINTER %>
	<% If BusinessDetails.SortUrl(BusinessDetails.SEND_ORDERS_TO_PRINTER) = "" Then %>
		<th data-name="SEND_ORDERS_TO_PRINTER"><div id="elh_BusinessDetails_SEND_ORDERS_TO_PRINTER" class="BusinessDetails_SEND_ORDERS_TO_PRINTER"><div class="ewTableHeaderCaption"><%= BusinessDetails.SEND_ORDERS_TO_PRINTER.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="SEND_ORDERS_TO_PRINTER"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.SEND_ORDERS_TO_PRINTER) %>',1);"><div id="elh_BusinessDetails_SEND_ORDERS_TO_PRINTER" class="BusinessDetails_SEND_ORDERS_TO_PRINTER">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.SEND_ORDERS_TO_PRINTER.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.SEND_ORDERS_TO_PRINTER.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.SEND_ORDERS_TO_PRINTER.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.timezone.Visible Then ' timezone %>
	<% If BusinessDetails.SortUrl(BusinessDetails.timezone) = "" Then %>
		<th data-name="timezone"><div id="elh_BusinessDetails_timezone" class="BusinessDetails_timezone"><div class="ewTableHeaderCaption"><%= BusinessDetails.timezone.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="timezone"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.timezone) %>',1);"><div id="elh_BusinessDetails_timezone" class="BusinessDetails_timezone">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.timezone.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.timezone.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.timezone.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.PAYPAL_ADDR.Visible Then ' PAYPAL_ADDR %>
	<% If BusinessDetails.SortUrl(BusinessDetails.PAYPAL_ADDR) = "" Then %>
		<th data-name="PAYPAL_ADDR"><div id="elh_BusinessDetails_PAYPAL_ADDR" class="BusinessDetails_PAYPAL_ADDR"><div class="ewTableHeaderCaption"><%= BusinessDetails.PAYPAL_ADDR.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="PAYPAL_ADDR"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.PAYPAL_ADDR) %>',1);"><div id="elh_BusinessDetails_PAYPAL_ADDR" class="BusinessDetails_PAYPAL_ADDR">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.PAYPAL_ADDR.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.PAYPAL_ADDR.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.PAYPAL_ADDR.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.nochex.Visible Then ' nochex %>
	<% If BusinessDetails.SortUrl(BusinessDetails.nochex) = "" Then %>
		<th data-name="nochex"><div id="elh_BusinessDetails_nochex" class="BusinessDetails_nochex"><div class="ewTableHeaderCaption"><%= BusinessDetails.nochex.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="nochex"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.nochex) %>',1);"><div id="elh_BusinessDetails_nochex" class="BusinessDetails_nochex">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.nochex.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.nochex.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.nochex.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.nochexmerchantid.Visible Then ' nochexmerchantid %>
	<% If BusinessDetails.SortUrl(BusinessDetails.nochexmerchantid) = "" Then %>
		<th data-name="nochexmerchantid"><div id="elh_BusinessDetails_nochexmerchantid" class="BusinessDetails_nochexmerchantid"><div class="ewTableHeaderCaption"><%= BusinessDetails.nochexmerchantid.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="nochexmerchantid"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.nochexmerchantid) %>',1);"><div id="elh_BusinessDetails_nochexmerchantid" class="BusinessDetails_nochexmerchantid">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.nochexmerchantid.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.nochexmerchantid.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.nochexmerchantid.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.paypal.Visible Then ' paypal %>
	<% If BusinessDetails.SortUrl(BusinessDetails.paypal) = "" Then %>
		<th data-name="paypal"><div id="elh_BusinessDetails_paypal" class="BusinessDetails_paypal"><div class="ewTableHeaderCaption"><%= BusinessDetails.paypal.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="paypal"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.paypal) %>',1);"><div id="elh_BusinessDetails_paypal" class="BusinessDetails_paypal">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.paypal.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.paypal.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.paypal.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.IBT_API_KEY.Visible Then ' IBT_API_KEY %>
	<% If BusinessDetails.SortUrl(BusinessDetails.IBT_API_KEY) = "" Then %>
		<th data-name="IBT_API_KEY"><div id="elh_BusinessDetails_IBT_API_KEY" class="BusinessDetails_IBT_API_KEY"><div class="ewTableHeaderCaption"><%= BusinessDetails.IBT_API_KEY.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="IBT_API_KEY"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.IBT_API_KEY) %>',1);"><div id="elh_BusinessDetails_IBT_API_KEY" class="BusinessDetails_IBT_API_KEY">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.IBT_API_KEY.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.IBT_API_KEY.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.IBT_API_KEY.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.IBP_API_PASSWORD.Visible Then ' IBP_API_PASSWORD %>
	<% If BusinessDetails.SortUrl(BusinessDetails.IBP_API_PASSWORD) = "" Then %>
		<th data-name="IBP_API_PASSWORD"><div id="elh_BusinessDetails_IBP_API_PASSWORD" class="BusinessDetails_IBP_API_PASSWORD"><div class="ewTableHeaderCaption"><%= BusinessDetails.IBP_API_PASSWORD.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="IBP_API_PASSWORD"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.IBP_API_PASSWORD) %>',1);"><div id="elh_BusinessDetails_IBP_API_PASSWORD" class="BusinessDetails_IBP_API_PASSWORD">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.IBP_API_PASSWORD.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.IBP_API_PASSWORD.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.IBP_API_PASSWORD.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.disable_delivery.Visible Then ' disable_delivery %>
	<% If BusinessDetails.SortUrl(BusinessDetails.disable_delivery) = "" Then %>
		<th data-name="disable_delivery"><div id="elh_BusinessDetails_disable_delivery" class="BusinessDetails_disable_delivery"><div class="ewTableHeaderCaption"><%= BusinessDetails.disable_delivery.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="disable_delivery"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.disable_delivery) %>',1);"><div id="elh_BusinessDetails_disable_delivery" class="BusinessDetails_disable_delivery">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.disable_delivery.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.disable_delivery.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.disable_delivery.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.disable_collection.Visible Then ' disable_collection %>
	<% If BusinessDetails.SortUrl(BusinessDetails.disable_collection) = "" Then %>
		<th data-name="disable_collection"><div id="elh_BusinessDetails_disable_collection" class="BusinessDetails_disable_collection"><div class="ewTableHeaderCaption"><%= BusinessDetails.disable_collection.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="disable_collection"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.disable_collection) %>',1);"><div id="elh_BusinessDetails_disable_collection" class="BusinessDetails_disable_collection">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.disable_collection.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.disable_collection.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.disable_collection.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.worldpay.Visible Then ' worldpay %>
	<% If BusinessDetails.SortUrl(BusinessDetails.worldpay) = "" Then %>
		<th data-name="worldpay"><div id="elh_BusinessDetails_worldpay" class="BusinessDetails_worldpay"><div class="ewTableHeaderCaption"><%= BusinessDetails.worldpay.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="worldpay"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.worldpay) %>',1);"><div id="elh_BusinessDetails_worldpay" class="BusinessDetails_worldpay">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.worldpay.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.worldpay.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.worldpay.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.worldpaymerchantid.Visible Then ' worldpaymerchantid %>
	<% If BusinessDetails.SortUrl(BusinessDetails.worldpaymerchantid) = "" Then %>
		<th data-name="worldpaymerchantid"><div id="elh_BusinessDetails_worldpaymerchantid" class="BusinessDetails_worldpaymerchantid"><div class="ewTableHeaderCaption"><%= BusinessDetails.worldpaymerchantid.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="worldpaymerchantid"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.worldpaymerchantid) %>',1);"><div id="elh_BusinessDetails_worldpaymerchantid" class="BusinessDetails_worldpaymerchantid">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.worldpaymerchantid.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.worldpaymerchantid.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.worldpaymerchantid.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.DeliveryChargeOverrideByOrderValue.Visible Then ' DeliveryChargeOverrideByOrderValue %>
	<% If BusinessDetails.SortUrl(BusinessDetails.DeliveryChargeOverrideByOrderValue) = "" Then %>
		<th data-name="DeliveryChargeOverrideByOrderValue"><div id="elh_BusinessDetails_DeliveryChargeOverrideByOrderValue" class="BusinessDetails_DeliveryChargeOverrideByOrderValue"><div class="ewTableHeaderCaption"><%= BusinessDetails.DeliveryChargeOverrideByOrderValue.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="DeliveryChargeOverrideByOrderValue"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.DeliveryChargeOverrideByOrderValue) %>',1);"><div id="elh_BusinessDetails_DeliveryChargeOverrideByOrderValue" class="BusinessDetails_DeliveryChargeOverrideByOrderValue">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.DeliveryChargeOverrideByOrderValue.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.DeliveryChargeOverrideByOrderValue.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.DeliveryChargeOverrideByOrderValue.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.individualpostcodeschecking.Visible Then ' individualpostcodeschecking %>
	<% If BusinessDetails.SortUrl(BusinessDetails.individualpostcodeschecking) = "" Then %>
		<th data-name="individualpostcodeschecking"><div id="elh_BusinessDetails_individualpostcodeschecking" class="BusinessDetails_individualpostcodeschecking"><div class="ewTableHeaderCaption"><%= BusinessDetails.individualpostcodeschecking.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="individualpostcodeschecking"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.individualpostcodeschecking) %>',1);"><div id="elh_BusinessDetails_individualpostcodeschecking" class="BusinessDetails_individualpostcodeschecking">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.individualpostcodeschecking.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.individualpostcodeschecking.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.individualpostcodeschecking.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.longitude.Visible Then ' longitude %>
	<% If BusinessDetails.SortUrl(BusinessDetails.longitude) = "" Then %>
		<th data-name="longitude"><div id="elh_BusinessDetails_longitude" class="BusinessDetails_longitude"><div class="ewTableHeaderCaption"><%= BusinessDetails.longitude.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="longitude"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.longitude) %>',1);"><div id="elh_BusinessDetails_longitude" class="BusinessDetails_longitude">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.longitude.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.longitude.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.longitude.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.latitude.Visible Then ' latitude %>
	<% If BusinessDetails.SortUrl(BusinessDetails.latitude) = "" Then %>
		<th data-name="latitude"><div id="elh_BusinessDetails_latitude" class="BusinessDetails_latitude"><div class="ewTableHeaderCaption"><%= BusinessDetails.latitude.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="latitude"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.latitude) %>',1);"><div id="elh_BusinessDetails_latitude" class="BusinessDetails_latitude">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.latitude.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.latitude.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.latitude.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.googleecommercetracking.Visible Then ' googleecommercetracking %>
	<% If BusinessDetails.SortUrl(BusinessDetails.googleecommercetracking) = "" Then %>
		<th data-name="googleecommercetracking"><div id="elh_BusinessDetails_googleecommercetracking" class="BusinessDetails_googleecommercetracking"><div class="ewTableHeaderCaption"><%= BusinessDetails.googleecommercetracking.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="googleecommercetracking"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.googleecommercetracking) %>',1);"><div id="elh_BusinessDetails_googleecommercetracking" class="BusinessDetails_googleecommercetracking">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.googleecommercetracking.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.googleecommercetracking.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.googleecommercetracking.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.googleecommercetrackingcode.Visible Then ' googleecommercetrackingcode %>
	<% If BusinessDetails.SortUrl(BusinessDetails.googleecommercetrackingcode) = "" Then %>
		<th data-name="googleecommercetrackingcode"><div id="elh_BusinessDetails_googleecommercetrackingcode" class="BusinessDetails_googleecommercetrackingcode"><div class="ewTableHeaderCaption"><%= BusinessDetails.googleecommercetrackingcode.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="googleecommercetrackingcode"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.googleecommercetrackingcode) %>',1);"><div id="elh_BusinessDetails_googleecommercetrackingcode" class="BusinessDetails_googleecommercetrackingcode">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.googleecommercetrackingcode.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.googleecommercetrackingcode.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.googleecommercetrackingcode.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.bringg.Visible Then ' bringg %>
	<% If BusinessDetails.SortUrl(BusinessDetails.bringg) = "" Then %>
		<th data-name="bringg"><div id="elh_BusinessDetails_bringg" class="BusinessDetails_bringg"><div class="ewTableHeaderCaption"><%= BusinessDetails.bringg.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="bringg"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.bringg) %>',1);"><div id="elh_BusinessDetails_bringg" class="BusinessDetails_bringg">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.bringg.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.bringg.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.bringg.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.bringgurl.Visible Then ' bringgurl %>
	<% If BusinessDetails.SortUrl(BusinessDetails.bringgurl) = "" Then %>
		<th data-name="bringgurl"><div id="elh_BusinessDetails_bringgurl" class="BusinessDetails_bringgurl"><div class="ewTableHeaderCaption"><%= BusinessDetails.bringgurl.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="bringgurl"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.bringgurl) %>',1);"><div id="elh_BusinessDetails_bringgurl" class="BusinessDetails_bringgurl">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.bringgurl.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.bringgurl.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.bringgurl.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.bringgcompanyid.Visible Then ' bringgcompanyid %>
	<% If BusinessDetails.SortUrl(BusinessDetails.bringgcompanyid) = "" Then %>
		<th data-name="bringgcompanyid"><div id="elh_BusinessDetails_bringgcompanyid" class="BusinessDetails_bringgcompanyid"><div class="ewTableHeaderCaption"><%= BusinessDetails.bringgcompanyid.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="bringgcompanyid"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.bringgcompanyid) %>',1);"><div id="elh_BusinessDetails_bringgcompanyid" class="BusinessDetails_bringgcompanyid">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.bringgcompanyid.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.bringgcompanyid.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.bringgcompanyid.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.orderonlywhenopen.Visible Then ' orderonlywhenopen %>
	<% If BusinessDetails.SortUrl(BusinessDetails.orderonlywhenopen) = "" Then %>
		<th data-name="orderonlywhenopen"><div id="elh_BusinessDetails_orderonlywhenopen" class="BusinessDetails_orderonlywhenopen"><div class="ewTableHeaderCaption"><%= BusinessDetails.orderonlywhenopen.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="orderonlywhenopen"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.orderonlywhenopen) %>',1);"><div id="elh_BusinessDetails_orderonlywhenopen" class="BusinessDetails_orderonlywhenopen">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.orderonlywhenopen.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.orderonlywhenopen.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.orderonlywhenopen.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.disablelaterdelivery.Visible Then ' disablelaterdelivery %>
	<% If BusinessDetails.SortUrl(BusinessDetails.disablelaterdelivery) = "" Then %>
		<th data-name="disablelaterdelivery"><div id="elh_BusinessDetails_disablelaterdelivery" class="BusinessDetails_disablelaterdelivery"><div class="ewTableHeaderCaption"><%= BusinessDetails.disablelaterdelivery.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="disablelaterdelivery"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.disablelaterdelivery) %>',1);"><div id="elh_BusinessDetails_disablelaterdelivery" class="BusinessDetails_disablelaterdelivery">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.disablelaterdelivery.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.disablelaterdelivery.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.disablelaterdelivery.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.ordertodayonly.Visible Then ' ordertodayonly %>
	<% If BusinessDetails.SortUrl(BusinessDetails.ordertodayonly) = "" Then %>
		<th data-name="ordertodayonly"><div id="elh_BusinessDetails_ordertodayonly" class="BusinessDetails_ordertodayonly"><div class="ewTableHeaderCaption"><%= BusinessDetails.ordertodayonly.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="ordertodayonly"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.ordertodayonly) %>',1);"><div id="elh_BusinessDetails_ordertodayonly" class="BusinessDetails_ordertodayonly">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.ordertodayonly.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.ordertodayonly.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.ordertodayonly.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.mileskm.Visible Then ' mileskm %>
	<% If BusinessDetails.SortUrl(BusinessDetails.mileskm) = "" Then %>
		<th data-name="mileskm"><div id="elh_BusinessDetails_mileskm" class="BusinessDetails_mileskm"><div class="ewTableHeaderCaption"><%= BusinessDetails.mileskm.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="mileskm"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.mileskm) %>',1);"><div id="elh_BusinessDetails_mileskm" class="BusinessDetails_mileskm">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.mileskm.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.mileskm.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.mileskm.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.worldpaylive.Visible Then ' worldpaylive %>
	<% If BusinessDetails.SortUrl(BusinessDetails.worldpaylive) = "" Then %>
		<th data-name="worldpaylive"><div id="elh_BusinessDetails_worldpaylive" class="BusinessDetails_worldpaylive"><div class="ewTableHeaderCaption"><%= BusinessDetails.worldpaylive.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="worldpaylive"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.worldpaylive) %>',1);"><div id="elh_BusinessDetails_worldpaylive" class="BusinessDetails_worldpaylive">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.worldpaylive.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.worldpaylive.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.worldpaylive.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.worldpayinstallationid.Visible Then ' worldpayinstallationid %>
	<% If BusinessDetails.SortUrl(BusinessDetails.worldpayinstallationid) = "" Then %>
		<th data-name="worldpayinstallationid"><div id="elh_BusinessDetails_worldpayinstallationid" class="BusinessDetails_worldpayinstallationid"><div class="ewTableHeaderCaption"><%= BusinessDetails.worldpayinstallationid.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="worldpayinstallationid"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.worldpayinstallationid) %>',1);"><div id="elh_BusinessDetails_worldpayinstallationid" class="BusinessDetails_worldpayinstallationid">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.worldpayinstallationid.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.worldpayinstallationid.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.worldpayinstallationid.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.DistanceCalMethod.Visible Then ' DistanceCalMethod %>
	<% If BusinessDetails.SortUrl(BusinessDetails.DistanceCalMethod) = "" Then %>
		<th data-name="DistanceCalMethod"><div id="elh_BusinessDetails_DistanceCalMethod" class="BusinessDetails_DistanceCalMethod"><div class="ewTableHeaderCaption"><%= BusinessDetails.DistanceCalMethod.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="DistanceCalMethod"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.DistanceCalMethod) %>',1);"><div id="elh_BusinessDetails_DistanceCalMethod" class="BusinessDetails_DistanceCalMethod">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.DistanceCalMethod.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.DistanceCalMethod.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.DistanceCalMethod.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.PrinterIDList.Visible Then ' PrinterIDList %>
	<% If BusinessDetails.SortUrl(BusinessDetails.PrinterIDList) = "" Then %>
		<th data-name="PrinterIDList"><div id="elh_BusinessDetails_PrinterIDList" class="BusinessDetails_PrinterIDList"><div class="ewTableHeaderCaption"><%= BusinessDetails.PrinterIDList.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="PrinterIDList"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.PrinterIDList) %>',1);"><div id="elh_BusinessDetails_PrinterIDList" class="BusinessDetails_PrinterIDList">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.PrinterIDList.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.PrinterIDList.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.PrinterIDList.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.EpsonJSPrinterURL.Visible Then ' EpsonJSPrinterURL %>
	<% If BusinessDetails.SortUrl(BusinessDetails.EpsonJSPrinterURL) = "" Then %>
		<th data-name="EpsonJSPrinterURL"><div id="elh_BusinessDetails_EpsonJSPrinterURL" class="BusinessDetails_EpsonJSPrinterURL"><div class="ewTableHeaderCaption"><%= BusinessDetails.EpsonJSPrinterURL.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="EpsonJSPrinterURL"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.EpsonJSPrinterURL) %>',1);"><div id="elh_BusinessDetails_EpsonJSPrinterURL" class="BusinessDetails_EpsonJSPrinterURL">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.EpsonJSPrinterURL.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.EpsonJSPrinterURL.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.EpsonJSPrinterURL.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.SMSEnable.Visible Then ' SMSEnable %>
	<% If BusinessDetails.SortUrl(BusinessDetails.SMSEnable) = "" Then %>
		<th data-name="SMSEnable"><div id="elh_BusinessDetails_SMSEnable" class="BusinessDetails_SMSEnable"><div class="ewTableHeaderCaption"><%= BusinessDetails.SMSEnable.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="SMSEnable"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.SMSEnable) %>',1);"><div id="elh_BusinessDetails_SMSEnable" class="BusinessDetails_SMSEnable">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.SMSEnable.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.SMSEnable.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.SMSEnable.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.SMSOnDelivery.Visible Then ' SMSOnDelivery %>
	<% If BusinessDetails.SortUrl(BusinessDetails.SMSOnDelivery) = "" Then %>
		<th data-name="SMSOnDelivery"><div id="elh_BusinessDetails_SMSOnDelivery" class="BusinessDetails_SMSOnDelivery"><div class="ewTableHeaderCaption"><%= BusinessDetails.SMSOnDelivery.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="SMSOnDelivery"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.SMSOnDelivery) %>',1);"><div id="elh_BusinessDetails_SMSOnDelivery" class="BusinessDetails_SMSOnDelivery">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.SMSOnDelivery.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.SMSOnDelivery.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.SMSOnDelivery.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.SMSSupplierDomain.Visible Then ' SMSSupplierDomain %>
	<% If BusinessDetails.SortUrl(BusinessDetails.SMSSupplierDomain) = "" Then %>
		<th data-name="SMSSupplierDomain"><div id="elh_BusinessDetails_SMSSupplierDomain" class="BusinessDetails_SMSSupplierDomain"><div class="ewTableHeaderCaption"><%= BusinessDetails.SMSSupplierDomain.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="SMSSupplierDomain"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.SMSSupplierDomain) %>',1);"><div id="elh_BusinessDetails_SMSSupplierDomain" class="BusinessDetails_SMSSupplierDomain">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.SMSSupplierDomain.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.SMSSupplierDomain.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.SMSSupplierDomain.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.SMSOnOrder.Visible Then ' SMSOnOrder %>
	<% If BusinessDetails.SortUrl(BusinessDetails.SMSOnOrder) = "" Then %>
		<th data-name="SMSOnOrder"><div id="elh_BusinessDetails_SMSOnOrder" class="BusinessDetails_SMSOnOrder"><div class="ewTableHeaderCaption"><%= BusinessDetails.SMSOnOrder.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="SMSOnOrder"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.SMSOnOrder) %>',1);"><div id="elh_BusinessDetails_SMSOnOrder" class="BusinessDetails_SMSOnOrder">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.SMSOnOrder.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.SMSOnOrder.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.SMSOnOrder.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.SMSOnOrderAfterMin.Visible Then ' SMSOnOrderAfterMin %>
	<% If BusinessDetails.SortUrl(BusinessDetails.SMSOnOrderAfterMin) = "" Then %>
		<th data-name="SMSOnOrderAfterMin"><div id="elh_BusinessDetails_SMSOnOrderAfterMin" class="BusinessDetails_SMSOnOrderAfterMin"><div class="ewTableHeaderCaption"><%= BusinessDetails.SMSOnOrderAfterMin.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="SMSOnOrderAfterMin"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.SMSOnOrderAfterMin) %>',1);"><div id="elh_BusinessDetails_SMSOnOrderAfterMin" class="BusinessDetails_SMSOnOrderAfterMin">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.SMSOnOrderAfterMin.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.SMSOnOrderAfterMin.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.SMSOnOrderAfterMin.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.SMSOnOrderContent.Visible Then ' SMSOnOrderContent %>
	<% If BusinessDetails.SortUrl(BusinessDetails.SMSOnOrderContent) = "" Then %>
		<th data-name="SMSOnOrderContent"><div id="elh_BusinessDetails_SMSOnOrderContent" class="BusinessDetails_SMSOnOrderContent"><div class="ewTableHeaderCaption"><%= BusinessDetails.SMSOnOrderContent.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="SMSOnOrderContent"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.SMSOnOrderContent) %>',1);"><div id="elh_BusinessDetails_SMSOnOrderContent" class="BusinessDetails_SMSOnOrderContent">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.SMSOnOrderContent.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.SMSOnOrderContent.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.SMSOnOrderContent.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.DefaultSMSCountryCode.Visible Then ' DefaultSMSCountryCode %>
	<% If BusinessDetails.SortUrl(BusinessDetails.DefaultSMSCountryCode) = "" Then %>
		<th data-name="DefaultSMSCountryCode"><div id="elh_BusinessDetails_DefaultSMSCountryCode" class="BusinessDetails_DefaultSMSCountryCode"><div class="ewTableHeaderCaption"><%= BusinessDetails.DefaultSMSCountryCode.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="DefaultSMSCountryCode"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.DefaultSMSCountryCode) %>',1);"><div id="elh_BusinessDetails_DefaultSMSCountryCode" class="BusinessDetails_DefaultSMSCountryCode">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.DefaultSMSCountryCode.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.DefaultSMSCountryCode.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.DefaultSMSCountryCode.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.MinimumAmountForCardPayment.Visible Then ' MinimumAmountForCardPayment %>
	<% If BusinessDetails.SortUrl(BusinessDetails.MinimumAmountForCardPayment) = "" Then %>
		<th data-name="MinimumAmountForCardPayment"><div id="elh_BusinessDetails_MinimumAmountForCardPayment" class="BusinessDetails_MinimumAmountForCardPayment"><div class="ewTableHeaderCaption"><%= BusinessDetails.MinimumAmountForCardPayment.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="MinimumAmountForCardPayment"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.MinimumAmountForCardPayment) %>',1);"><div id="elh_BusinessDetails_MinimumAmountForCardPayment" class="BusinessDetails_MinimumAmountForCardPayment">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.MinimumAmountForCardPayment.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.MinimumAmountForCardPayment.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.MinimumAmountForCardPayment.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.FavIconUrl.Visible Then ' FavIconUrl %>
	<% If BusinessDetails.SortUrl(BusinessDetails.FavIconUrl) = "" Then %>
		<th data-name="FavIconUrl"><div id="elh_BusinessDetails_FavIconUrl" class="BusinessDetails_FavIconUrl"><div class="ewTableHeaderCaption"><%= BusinessDetails.FavIconUrl.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="FavIconUrl"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.FavIconUrl) %>',1);"><div id="elh_BusinessDetails_FavIconUrl" class="BusinessDetails_FavIconUrl">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.FavIconUrl.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.FavIconUrl.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.FavIconUrl.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.AddToHomeScreenURL.Visible Then ' AddToHomeScreenURL %>
	<% If BusinessDetails.SortUrl(BusinessDetails.AddToHomeScreenURL) = "" Then %>
		<th data-name="AddToHomeScreenURL"><div id="elh_BusinessDetails_AddToHomeScreenURL" class="BusinessDetails_AddToHomeScreenURL"><div class="ewTableHeaderCaption"><%= BusinessDetails.AddToHomeScreenURL.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="AddToHomeScreenURL"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.AddToHomeScreenURL) %>',1);"><div id="elh_BusinessDetails_AddToHomeScreenURL" class="BusinessDetails_AddToHomeScreenURL">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.AddToHomeScreenURL.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.AddToHomeScreenURL.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.AddToHomeScreenURL.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.SMSOnAcknowledgement.Visible Then ' SMSOnAcknowledgement %>
	<% If BusinessDetails.SortUrl(BusinessDetails.SMSOnAcknowledgement) = "" Then %>
		<th data-name="SMSOnAcknowledgement"><div id="elh_BusinessDetails_SMSOnAcknowledgement" class="BusinessDetails_SMSOnAcknowledgement"><div class="ewTableHeaderCaption"><%= BusinessDetails.SMSOnAcknowledgement.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="SMSOnAcknowledgement"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.SMSOnAcknowledgement) %>',1);"><div id="elh_BusinessDetails_SMSOnAcknowledgement" class="BusinessDetails_SMSOnAcknowledgement">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.SMSOnAcknowledgement.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.SMSOnAcknowledgement.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.SMSOnAcknowledgement.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.LocalPrinterURL.Visible Then ' LocalPrinterURL %>
	<% If BusinessDetails.SortUrl(BusinessDetails.LocalPrinterURL) = "" Then %>
		<th data-name="LocalPrinterURL"><div id="elh_BusinessDetails_LocalPrinterURL" class="BusinessDetails_LocalPrinterURL"><div class="ewTableHeaderCaption"><%= BusinessDetails.LocalPrinterURL.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="LocalPrinterURL"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.LocalPrinterURL) %>',1);"><div id="elh_BusinessDetails_LocalPrinterURL" class="BusinessDetails_LocalPrinterURL">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.LocalPrinterURL.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.LocalPrinterURL.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.LocalPrinterURL.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.ShowRestaurantDetailOnReceipt.Visible Then ' ShowRestaurantDetailOnReceipt %>
	<% If BusinessDetails.SortUrl(BusinessDetails.ShowRestaurantDetailOnReceipt) = "" Then %>
		<th data-name="ShowRestaurantDetailOnReceipt"><div id="elh_BusinessDetails_ShowRestaurantDetailOnReceipt" class="BusinessDetails_ShowRestaurantDetailOnReceipt"><div class="ewTableHeaderCaption"><%= BusinessDetails.ShowRestaurantDetailOnReceipt.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="ShowRestaurantDetailOnReceipt"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.ShowRestaurantDetailOnReceipt) %>',1);"><div id="elh_BusinessDetails_ShowRestaurantDetailOnReceipt" class="BusinessDetails_ShowRestaurantDetailOnReceipt">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.ShowRestaurantDetailOnReceipt.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.ShowRestaurantDetailOnReceipt.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.ShowRestaurantDetailOnReceipt.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.PrinterFontSizeRatio.Visible Then ' PrinterFontSizeRatio %>
	<% If BusinessDetails.SortUrl(BusinessDetails.PrinterFontSizeRatio) = "" Then %>
		<th data-name="PrinterFontSizeRatio"><div id="elh_BusinessDetails_PrinterFontSizeRatio" class="BusinessDetails_PrinterFontSizeRatio"><div class="ewTableHeaderCaption"><%= BusinessDetails.PrinterFontSizeRatio.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="PrinterFontSizeRatio"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.PrinterFontSizeRatio) %>',1);"><div id="elh_BusinessDetails_PrinterFontSizeRatio" class="BusinessDetails_PrinterFontSizeRatio">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.PrinterFontSizeRatio.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.PrinterFontSizeRatio.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.PrinterFontSizeRatio.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.ServiceChargePercentage.Visible Then ' ServiceChargePercentage %>
	<% If BusinessDetails.SortUrl(BusinessDetails.ServiceChargePercentage) = "" Then %>
		<th data-name="ServiceChargePercentage"><div id="elh_BusinessDetails_ServiceChargePercentage" class="BusinessDetails_ServiceChargePercentage"><div class="ewTableHeaderCaption"><%= BusinessDetails.ServiceChargePercentage.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="ServiceChargePercentage"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.ServiceChargePercentage) %>',1);"><div id="elh_BusinessDetails_ServiceChargePercentage" class="BusinessDetails_ServiceChargePercentage">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.ServiceChargePercentage.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.ServiceChargePercentage.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.ServiceChargePercentage.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.InRestaurantServiceChargeOnly.Visible Then ' InRestaurantServiceChargeOnly %>
	<% If BusinessDetails.SortUrl(BusinessDetails.InRestaurantServiceChargeOnly) = "" Then %>
		<th data-name="InRestaurantServiceChargeOnly"><div id="elh_BusinessDetails_InRestaurantServiceChargeOnly" class="BusinessDetails_InRestaurantServiceChargeOnly"><div class="ewTableHeaderCaption"><%= BusinessDetails.InRestaurantServiceChargeOnly.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="InRestaurantServiceChargeOnly"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.InRestaurantServiceChargeOnly) %>',1);"><div id="elh_BusinessDetails_InRestaurantServiceChargeOnly" class="BusinessDetails_InRestaurantServiceChargeOnly">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.InRestaurantServiceChargeOnly.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.InRestaurantServiceChargeOnly.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.InRestaurantServiceChargeOnly.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.IsDualReceiptPrinting.Visible Then ' IsDualReceiptPrinting %>
	<% If BusinessDetails.SortUrl(BusinessDetails.IsDualReceiptPrinting) = "" Then %>
		<th data-name="IsDualReceiptPrinting"><div id="elh_BusinessDetails_IsDualReceiptPrinting" class="BusinessDetails_IsDualReceiptPrinting"><div class="ewTableHeaderCaption"><%= BusinessDetails.IsDualReceiptPrinting.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="IsDualReceiptPrinting"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.IsDualReceiptPrinting) %>',1);"><div id="elh_BusinessDetails_IsDualReceiptPrinting" class="BusinessDetails_IsDualReceiptPrinting">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.IsDualReceiptPrinting.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.IsDualReceiptPrinting.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.IsDualReceiptPrinting.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.PrintingFontSize.Visible Then ' PrintingFontSize %>
	<% If BusinessDetails.SortUrl(BusinessDetails.PrintingFontSize) = "" Then %>
		<th data-name="PrintingFontSize"><div id="elh_BusinessDetails_PrintingFontSize" class="BusinessDetails_PrintingFontSize"><div class="ewTableHeaderCaption"><%= BusinessDetails.PrintingFontSize.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="PrintingFontSize"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.PrintingFontSize) %>',1);"><div id="elh_BusinessDetails_PrintingFontSize" class="BusinessDetails_PrintingFontSize">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.PrintingFontSize.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.PrintingFontSize.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.PrintingFontSize.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.InRestaurantEpsonPrinterIDList.Visible Then ' InRestaurantEpsonPrinterIDList %>
	<% If BusinessDetails.SortUrl(BusinessDetails.InRestaurantEpsonPrinterIDList) = "" Then %>
		<th data-name="InRestaurantEpsonPrinterIDList"><div id="elh_BusinessDetails_InRestaurantEpsonPrinterIDList" class="BusinessDetails_InRestaurantEpsonPrinterIDList"><div class="ewTableHeaderCaption"><%= BusinessDetails.InRestaurantEpsonPrinterIDList.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="InRestaurantEpsonPrinterIDList"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.InRestaurantEpsonPrinterIDList) %>',1);"><div id="elh_BusinessDetails_InRestaurantEpsonPrinterIDList" class="BusinessDetails_InRestaurantEpsonPrinterIDList">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.InRestaurantEpsonPrinterIDList.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.InRestaurantEpsonPrinterIDList.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.InRestaurantEpsonPrinterIDList.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.BlockIPEmailList.Visible Then ' BlockIPEmailList %>
	<% If BusinessDetails.SortUrl(BusinessDetails.BlockIPEmailList) = "" Then %>
		<th data-name="BlockIPEmailList"><div id="elh_BusinessDetails_BlockIPEmailList" class="BusinessDetails_BlockIPEmailList"><div class="ewTableHeaderCaption"><%= BusinessDetails.BlockIPEmailList.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="BlockIPEmailList"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.BlockIPEmailList) %>',1);"><div id="elh_BusinessDetails_BlockIPEmailList" class="BusinessDetails_BlockIPEmailList">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.BlockIPEmailList.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.BlockIPEmailList.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.BlockIPEmailList.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.RePrintReceiptWays.Visible Then ' RePrintReceiptWays %>
	<% If BusinessDetails.SortUrl(BusinessDetails.RePrintReceiptWays) = "" Then %>
		<th data-name="RePrintReceiptWays"><div id="elh_BusinessDetails_RePrintReceiptWays" class="BusinessDetails_RePrintReceiptWays"><div class="ewTableHeaderCaption"><%= BusinessDetails.RePrintReceiptWays.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="RePrintReceiptWays"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.RePrintReceiptWays) %>',1);"><div id="elh_BusinessDetails_RePrintReceiptWays" class="BusinessDetails_RePrintReceiptWays">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.RePrintReceiptWays.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.RePrintReceiptWays.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.RePrintReceiptWays.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.printingtype.Visible Then ' printingtype %>
	<% If BusinessDetails.SortUrl(BusinessDetails.printingtype) = "" Then %>
		<th data-name="printingtype"><div id="elh_BusinessDetails_printingtype" class="BusinessDetails_printingtype"><div class="ewTableHeaderCaption"><%= BusinessDetails.printingtype.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="printingtype"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.printingtype) %>',1);"><div id="elh_BusinessDetails_printingtype" class="BusinessDetails_printingtype">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.printingtype.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.printingtype.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.printingtype.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.Stripe_Key_Secret.Visible Then ' Stripe_Key_Secret %>
	<% If BusinessDetails.SortUrl(BusinessDetails.Stripe_Key_Secret) = "" Then %>
		<th data-name="Stripe_Key_Secret"><div id="elh_BusinessDetails_Stripe_Key_Secret" class="BusinessDetails_Stripe_Key_Secret"><div class="ewTableHeaderCaption"><%= BusinessDetails.Stripe_Key_Secret.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Stripe_Key_Secret"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.Stripe_Key_Secret) %>',1);"><div id="elh_BusinessDetails_Stripe_Key_Secret" class="BusinessDetails_Stripe_Key_Secret">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.Stripe_Key_Secret.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.Stripe_Key_Secret.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.Stripe_Key_Secret.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.Stripe.Visible Then ' Stripe %>
	<% If BusinessDetails.SortUrl(BusinessDetails.Stripe) = "" Then %>
		<th data-name="Stripe"><div id="elh_BusinessDetails_Stripe" class="BusinessDetails_Stripe"><div class="ewTableHeaderCaption"><%= BusinessDetails.Stripe.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Stripe"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.Stripe) %>',1);"><div id="elh_BusinessDetails_Stripe" class="BusinessDetails_Stripe">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.Stripe.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.Stripe.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.Stripe.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.Stripe_Api_Key.Visible Then ' Stripe_Api_Key %>
	<% If BusinessDetails.SortUrl(BusinessDetails.Stripe_Api_Key) = "" Then %>
		<th data-name="Stripe_Api_Key"><div id="elh_BusinessDetails_Stripe_Api_Key" class="BusinessDetails_Stripe_Api_Key"><div class="ewTableHeaderCaption"><%= BusinessDetails.Stripe_Api_Key.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Stripe_Api_Key"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.Stripe_Api_Key) %>',1);"><div id="elh_BusinessDetails_Stripe_Api_Key" class="BusinessDetails_Stripe_Api_Key">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.Stripe_Api_Key.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.Stripe_Api_Key.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.Stripe_Api_Key.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.EnableBooking.Visible Then ' EnableBooking %>
	<% If BusinessDetails.SortUrl(BusinessDetails.EnableBooking) = "" Then %>
		<th data-name="EnableBooking"><div id="elh_BusinessDetails_EnableBooking" class="BusinessDetails_EnableBooking"><div class="ewTableHeaderCaption"><%= BusinessDetails.EnableBooking.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="EnableBooking"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.EnableBooking) %>',1);"><div id="elh_BusinessDetails_EnableBooking" class="BusinessDetails_EnableBooking">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.EnableBooking.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.EnableBooking.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.EnableBooking.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.URL_Facebook.Visible Then ' URL_Facebook %>
	<% If BusinessDetails.SortUrl(BusinessDetails.URL_Facebook) = "" Then %>
		<th data-name="URL_Facebook"><div id="elh_BusinessDetails_URL_Facebook" class="BusinessDetails_URL_Facebook"><div class="ewTableHeaderCaption"><%= BusinessDetails.URL_Facebook.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="URL_Facebook"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.URL_Facebook) %>',1);"><div id="elh_BusinessDetails_URL_Facebook" class="BusinessDetails_URL_Facebook">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.URL_Facebook.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.URL_Facebook.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.URL_Facebook.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.URL_Twitter.Visible Then ' URL_Twitter %>
	<% If BusinessDetails.SortUrl(BusinessDetails.URL_Twitter) = "" Then %>
		<th data-name="URL_Twitter"><div id="elh_BusinessDetails_URL_Twitter" class="BusinessDetails_URL_Twitter"><div class="ewTableHeaderCaption"><%= BusinessDetails.URL_Twitter.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="URL_Twitter"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.URL_Twitter) %>',1);"><div id="elh_BusinessDetails_URL_Twitter" class="BusinessDetails_URL_Twitter">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.URL_Twitter.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.URL_Twitter.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.URL_Twitter.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.URL_Google.Visible Then ' URL_Google %>
	<% If BusinessDetails.SortUrl(BusinessDetails.URL_Google) = "" Then %>
		<th data-name="URL_Google"><div id="elh_BusinessDetails_URL_Google" class="BusinessDetails_URL_Google"><div class="ewTableHeaderCaption"><%= BusinessDetails.URL_Google.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="URL_Google"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.URL_Google) %>',1);"><div id="elh_BusinessDetails_URL_Google" class="BusinessDetails_URL_Google">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.URL_Google.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.URL_Google.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.URL_Google.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.URL_Intagram.Visible Then ' URL_Intagram %>
	<% If BusinessDetails.SortUrl(BusinessDetails.URL_Intagram) = "" Then %>
		<th data-name="URL_Intagram"><div id="elh_BusinessDetails_URL_Intagram" class="BusinessDetails_URL_Intagram"><div class="ewTableHeaderCaption"><%= BusinessDetails.URL_Intagram.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="URL_Intagram"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.URL_Intagram) %>',1);"><div id="elh_BusinessDetails_URL_Intagram" class="BusinessDetails_URL_Intagram">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.URL_Intagram.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.URL_Intagram.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.URL_Intagram.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.URL_YouTube.Visible Then ' URL_YouTube %>
	<% If BusinessDetails.SortUrl(BusinessDetails.URL_YouTube) = "" Then %>
		<th data-name="URL_YouTube"><div id="elh_BusinessDetails_URL_YouTube" class="BusinessDetails_URL_YouTube"><div class="ewTableHeaderCaption"><%= BusinessDetails.URL_YouTube.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="URL_YouTube"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.URL_YouTube) %>',1);"><div id="elh_BusinessDetails_URL_YouTube" class="BusinessDetails_URL_YouTube">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.URL_YouTube.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.URL_YouTube.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.URL_YouTube.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.URL_Tripadvisor.Visible Then ' URL_Tripadvisor %>
	<% If BusinessDetails.SortUrl(BusinessDetails.URL_Tripadvisor) = "" Then %>
		<th data-name="URL_Tripadvisor"><div id="elh_BusinessDetails_URL_Tripadvisor" class="BusinessDetails_URL_Tripadvisor"><div class="ewTableHeaderCaption"><%= BusinessDetails.URL_Tripadvisor.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="URL_Tripadvisor"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.URL_Tripadvisor) %>',1);"><div id="elh_BusinessDetails_URL_Tripadvisor" class="BusinessDetails_URL_Tripadvisor">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.URL_Tripadvisor.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.URL_Tripadvisor.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.URL_Tripadvisor.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.URL_Special_Offer.Visible Then ' URL_Special_Offer %>
	<% If BusinessDetails.SortUrl(BusinessDetails.URL_Special_Offer) = "" Then %>
		<th data-name="URL_Special_Offer"><div id="elh_BusinessDetails_URL_Special_Offer" class="BusinessDetails_URL_Special_Offer"><div class="ewTableHeaderCaption"><%= BusinessDetails.URL_Special_Offer.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="URL_Special_Offer"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.URL_Special_Offer) %>',1);"><div id="elh_BusinessDetails_URL_Special_Offer" class="BusinessDetails_URL_Special_Offer">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.URL_Special_Offer.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.URL_Special_Offer.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.URL_Special_Offer.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.URL_Linkin.Visible Then ' URL_Linkin %>
	<% If BusinessDetails.SortUrl(BusinessDetails.URL_Linkin) = "" Then %>
		<th data-name="URL_Linkin"><div id="elh_BusinessDetails_URL_Linkin" class="BusinessDetails_URL_Linkin"><div class="ewTableHeaderCaption"><%= BusinessDetails.URL_Linkin.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="URL_Linkin"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.URL_Linkin) %>',1);"><div id="elh_BusinessDetails_URL_Linkin" class="BusinessDetails_URL_Linkin">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.URL_Linkin.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.URL_Linkin.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.URL_Linkin.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.Currency_PAYPAL.Visible Then ' Currency_PAYPAL %>
	<% If BusinessDetails.SortUrl(BusinessDetails.Currency_PAYPAL) = "" Then %>
		<th data-name="Currency_PAYPAL"><div id="elh_BusinessDetails_Currency_PAYPAL" class="BusinessDetails_Currency_PAYPAL"><div class="ewTableHeaderCaption"><%= BusinessDetails.Currency_PAYPAL.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Currency_PAYPAL"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.Currency_PAYPAL) %>',1);"><div id="elh_BusinessDetails_Currency_PAYPAL" class="BusinessDetails_Currency_PAYPAL">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.Currency_PAYPAL.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.Currency_PAYPAL.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.Currency_PAYPAL.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.Currency_STRIPE.Visible Then ' Currency_STRIPE %>
	<% If BusinessDetails.SortUrl(BusinessDetails.Currency_STRIPE) = "" Then %>
		<th data-name="Currency_STRIPE"><div id="elh_BusinessDetails_Currency_STRIPE" class="BusinessDetails_Currency_STRIPE"><div class="ewTableHeaderCaption"><%= BusinessDetails.Currency_STRIPE.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Currency_STRIPE"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.Currency_STRIPE) %>',1);"><div id="elh_BusinessDetails_Currency_STRIPE" class="BusinessDetails_Currency_STRIPE">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.Currency_STRIPE.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.Currency_STRIPE.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.Currency_STRIPE.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.Currency_WOLRDPAY.Visible Then ' Currency_WOLRDPAY %>
	<% If BusinessDetails.SortUrl(BusinessDetails.Currency_WOLRDPAY) = "" Then %>
		<th data-name="Currency_WOLRDPAY"><div id="elh_BusinessDetails_Currency_WOLRDPAY" class="BusinessDetails_Currency_WOLRDPAY"><div class="ewTableHeaderCaption"><%= BusinessDetails.Currency_WOLRDPAY.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Currency_WOLRDPAY"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.Currency_WOLRDPAY) %>',1);"><div id="elh_BusinessDetails_Currency_WOLRDPAY" class="BusinessDetails_Currency_WOLRDPAY">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.Currency_WOLRDPAY.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.Currency_WOLRDPAY.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.Currency_WOLRDPAY.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.Tip_percent.Visible Then ' Tip_percent %>
	<% If BusinessDetails.SortUrl(BusinessDetails.Tip_percent) = "" Then %>
		<th data-name="Tip_percent"><div id="elh_BusinessDetails_Tip_percent" class="BusinessDetails_Tip_percent"><div class="ewTableHeaderCaption"><%= BusinessDetails.Tip_percent.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Tip_percent"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.Tip_percent) %>',1);"><div id="elh_BusinessDetails_Tip_percent" class="BusinessDetails_Tip_percent">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.Tip_percent.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.Tip_percent.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.Tip_percent.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.Tax_Percent.Visible Then ' Tax_Percent %>
	<% If BusinessDetails.SortUrl(BusinessDetails.Tax_Percent) = "" Then %>
		<th data-name="Tax_Percent"><div id="elh_BusinessDetails_Tax_Percent" class="BusinessDetails_Tax_Percent"><div class="ewTableHeaderCaption"><%= BusinessDetails.Tax_Percent.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Tax_Percent"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.Tax_Percent) %>',1);"><div id="elh_BusinessDetails_Tax_Percent" class="BusinessDetails_Tax_Percent">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.Tax_Percent.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.Tax_Percent.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.Tax_Percent.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.InRestaurantTaxChargeOnly.Visible Then ' InRestaurantTaxChargeOnly %>
	<% If BusinessDetails.SortUrl(BusinessDetails.InRestaurantTaxChargeOnly) = "" Then %>
		<th data-name="InRestaurantTaxChargeOnly"><div id="elh_BusinessDetails_InRestaurantTaxChargeOnly" class="BusinessDetails_InRestaurantTaxChargeOnly"><div class="ewTableHeaderCaption"><%= BusinessDetails.InRestaurantTaxChargeOnly.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="InRestaurantTaxChargeOnly"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.InRestaurantTaxChargeOnly) %>',1);"><div id="elh_BusinessDetails_InRestaurantTaxChargeOnly" class="BusinessDetails_InRestaurantTaxChargeOnly">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.InRestaurantTaxChargeOnly.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.InRestaurantTaxChargeOnly.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.InRestaurantTaxChargeOnly.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.InRestaurantTipChargeOnly.Visible Then ' InRestaurantTipChargeOnly %>
	<% If BusinessDetails.SortUrl(BusinessDetails.InRestaurantTipChargeOnly) = "" Then %>
		<th data-name="InRestaurantTipChargeOnly"><div id="elh_BusinessDetails_InRestaurantTipChargeOnly" class="BusinessDetails_InRestaurantTipChargeOnly"><div class="ewTableHeaderCaption"><%= BusinessDetails.InRestaurantTipChargeOnly.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="InRestaurantTipChargeOnly"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.InRestaurantTipChargeOnly) %>',1);"><div id="elh_BusinessDetails_InRestaurantTipChargeOnly" class="BusinessDetails_InRestaurantTipChargeOnly">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.InRestaurantTipChargeOnly.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.InRestaurantTipChargeOnly.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.InRestaurantTipChargeOnly.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.isCheckCapcha.Visible Then ' isCheckCapcha %>
	<% If BusinessDetails.SortUrl(BusinessDetails.isCheckCapcha) = "" Then %>
		<th data-name="isCheckCapcha"><div id="elh_BusinessDetails_isCheckCapcha" class="BusinessDetails_isCheckCapcha"><div class="ewTableHeaderCaption"><%= BusinessDetails.isCheckCapcha.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="isCheckCapcha"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.isCheckCapcha) %>',1);"><div id="elh_BusinessDetails_isCheckCapcha" class="BusinessDetails_isCheckCapcha">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.isCheckCapcha.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.isCheckCapcha.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.isCheckCapcha.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.Close_StartDate.Visible Then ' Close_StartDate %>
	<% If BusinessDetails.SortUrl(BusinessDetails.Close_StartDate) = "" Then %>
		<th data-name="Close_StartDate"><div id="elh_BusinessDetails_Close_StartDate" class="BusinessDetails_Close_StartDate"><div class="ewTableHeaderCaption"><%= BusinessDetails.Close_StartDate.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Close_StartDate"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.Close_StartDate) %>',1);"><div id="elh_BusinessDetails_Close_StartDate" class="BusinessDetails_Close_StartDate">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.Close_StartDate.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.Close_StartDate.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.Close_StartDate.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.Close_EndDate.Visible Then ' Close_EndDate %>
	<% If BusinessDetails.SortUrl(BusinessDetails.Close_EndDate) = "" Then %>
		<th data-name="Close_EndDate"><div id="elh_BusinessDetails_Close_EndDate" class="BusinessDetails_Close_EndDate"><div class="ewTableHeaderCaption"><%= BusinessDetails.Close_EndDate.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Close_EndDate"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.Close_EndDate) %>',1);"><div id="elh_BusinessDetails_Close_EndDate" class="BusinessDetails_Close_EndDate">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.Close_EndDate.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.Close_EndDate.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.Close_EndDate.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.Stripe_Country.Visible Then ' Stripe_Country %>
	<% If BusinessDetails.SortUrl(BusinessDetails.Stripe_Country) = "" Then %>
		<th data-name="Stripe_Country"><div id="elh_BusinessDetails_Stripe_Country" class="BusinessDetails_Stripe_Country"><div class="ewTableHeaderCaption"><%= BusinessDetails.Stripe_Country.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Stripe_Country"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.Stripe_Country) %>',1);"><div id="elh_BusinessDetails_Stripe_Country" class="BusinessDetails_Stripe_Country">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.Stripe_Country.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.Stripe_Country.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.Stripe_Country.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.enable_StripePaymentButton.Visible Then ' enable_StripePaymentButton %>
	<% If BusinessDetails.SortUrl(BusinessDetails.enable_StripePaymentButton) = "" Then %>
		<th data-name="enable_StripePaymentButton"><div id="elh_BusinessDetails_enable_StripePaymentButton" class="BusinessDetails_enable_StripePaymentButton"><div class="ewTableHeaderCaption"><%= BusinessDetails.enable_StripePaymentButton.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="enable_StripePaymentButton"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.enable_StripePaymentButton) %>',1);"><div id="elh_BusinessDetails_enable_StripePaymentButton" class="BusinessDetails_enable_StripePaymentButton">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.enable_StripePaymentButton.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.enable_StripePaymentButton.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.enable_StripePaymentButton.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.enable_CashPayment.Visible Then ' enable_CashPayment %>
	<% If BusinessDetails.SortUrl(BusinessDetails.enable_CashPayment) = "" Then %>
		<th data-name="enable_CashPayment"><div id="elh_BusinessDetails_enable_CashPayment" class="BusinessDetails_enable_CashPayment"><div class="ewTableHeaderCaption"><%= BusinessDetails.enable_CashPayment.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="enable_CashPayment"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.enable_CashPayment) %>',1);"><div id="elh_BusinessDetails_enable_CashPayment" class="BusinessDetails_enable_CashPayment">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.enable_CashPayment.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.enable_CashPayment.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.enable_CashPayment.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.DeliveryMile.Visible Then ' DeliveryMile %>
	<% If BusinessDetails.SortUrl(BusinessDetails.DeliveryMile) = "" Then %>
		<th data-name="DeliveryMile"><div id="elh_BusinessDetails_DeliveryMile" class="BusinessDetails_DeliveryMile"><div class="ewTableHeaderCaption"><%= BusinessDetails.DeliveryMile.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="DeliveryMile"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.DeliveryMile) %>',1);"><div id="elh_BusinessDetails_DeliveryMile" class="BusinessDetails_DeliveryMile">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.DeliveryMile.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.DeliveryMile.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.DeliveryMile.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.Mon_Delivery.Visible Then ' Mon_Delivery %>
	<% If BusinessDetails.SortUrl(BusinessDetails.Mon_Delivery) = "" Then %>
		<th data-name="Mon_Delivery"><div id="elh_BusinessDetails_Mon_Delivery" class="BusinessDetails_Mon_Delivery"><div class="ewTableHeaderCaption"><%= BusinessDetails.Mon_Delivery.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Mon_Delivery"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.Mon_Delivery) %>',1);"><div id="elh_BusinessDetails_Mon_Delivery" class="BusinessDetails_Mon_Delivery">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.Mon_Delivery.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.Mon_Delivery.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.Mon_Delivery.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.Mon_Collection.Visible Then ' Mon_Collection %>
	<% If BusinessDetails.SortUrl(BusinessDetails.Mon_Collection) = "" Then %>
		<th data-name="Mon_Collection"><div id="elh_BusinessDetails_Mon_Collection" class="BusinessDetails_Mon_Collection"><div class="ewTableHeaderCaption"><%= BusinessDetails.Mon_Collection.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Mon_Collection"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.Mon_Collection) %>',1);"><div id="elh_BusinessDetails_Mon_Collection" class="BusinessDetails_Mon_Collection">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.Mon_Collection.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.Mon_Collection.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.Mon_Collection.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.Tue_Delivery.Visible Then ' Tue_Delivery %>
	<% If BusinessDetails.SortUrl(BusinessDetails.Tue_Delivery) = "" Then %>
		<th data-name="Tue_Delivery"><div id="elh_BusinessDetails_Tue_Delivery" class="BusinessDetails_Tue_Delivery"><div class="ewTableHeaderCaption"><%= BusinessDetails.Tue_Delivery.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Tue_Delivery"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.Tue_Delivery) %>',1);"><div id="elh_BusinessDetails_Tue_Delivery" class="BusinessDetails_Tue_Delivery">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.Tue_Delivery.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.Tue_Delivery.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.Tue_Delivery.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.Tue_Collection.Visible Then ' Tue_Collection %>
	<% If BusinessDetails.SortUrl(BusinessDetails.Tue_Collection) = "" Then %>
		<th data-name="Tue_Collection"><div id="elh_BusinessDetails_Tue_Collection" class="BusinessDetails_Tue_Collection"><div class="ewTableHeaderCaption"><%= BusinessDetails.Tue_Collection.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Tue_Collection"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.Tue_Collection) %>',1);"><div id="elh_BusinessDetails_Tue_Collection" class="BusinessDetails_Tue_Collection">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.Tue_Collection.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.Tue_Collection.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.Tue_Collection.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.Wed_Delivery.Visible Then ' Wed_Delivery %>
	<% If BusinessDetails.SortUrl(BusinessDetails.Wed_Delivery) = "" Then %>
		<th data-name="Wed_Delivery"><div id="elh_BusinessDetails_Wed_Delivery" class="BusinessDetails_Wed_Delivery"><div class="ewTableHeaderCaption"><%= BusinessDetails.Wed_Delivery.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Wed_Delivery"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.Wed_Delivery) %>',1);"><div id="elh_BusinessDetails_Wed_Delivery" class="BusinessDetails_Wed_Delivery">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.Wed_Delivery.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.Wed_Delivery.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.Wed_Delivery.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.Wed_Collection.Visible Then ' Wed_Collection %>
	<% If BusinessDetails.SortUrl(BusinessDetails.Wed_Collection) = "" Then %>
		<th data-name="Wed_Collection"><div id="elh_BusinessDetails_Wed_Collection" class="BusinessDetails_Wed_Collection"><div class="ewTableHeaderCaption"><%= BusinessDetails.Wed_Collection.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Wed_Collection"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.Wed_Collection) %>',1);"><div id="elh_BusinessDetails_Wed_Collection" class="BusinessDetails_Wed_Collection">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.Wed_Collection.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.Wed_Collection.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.Wed_Collection.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.Thu_Delivery.Visible Then ' Thu_Delivery %>
	<% If BusinessDetails.SortUrl(BusinessDetails.Thu_Delivery) = "" Then %>
		<th data-name="Thu_Delivery"><div id="elh_BusinessDetails_Thu_Delivery" class="BusinessDetails_Thu_Delivery"><div class="ewTableHeaderCaption"><%= BusinessDetails.Thu_Delivery.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Thu_Delivery"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.Thu_Delivery) %>',1);"><div id="elh_BusinessDetails_Thu_Delivery" class="BusinessDetails_Thu_Delivery">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.Thu_Delivery.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.Thu_Delivery.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.Thu_Delivery.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.Thu_Collection.Visible Then ' Thu_Collection %>
	<% If BusinessDetails.SortUrl(BusinessDetails.Thu_Collection) = "" Then %>
		<th data-name="Thu_Collection"><div id="elh_BusinessDetails_Thu_Collection" class="BusinessDetails_Thu_Collection"><div class="ewTableHeaderCaption"><%= BusinessDetails.Thu_Collection.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Thu_Collection"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.Thu_Collection) %>',1);"><div id="elh_BusinessDetails_Thu_Collection" class="BusinessDetails_Thu_Collection">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.Thu_Collection.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.Thu_Collection.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.Thu_Collection.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.Fri_Delivery.Visible Then ' Fri_Delivery %>
	<% If BusinessDetails.SortUrl(BusinessDetails.Fri_Delivery) = "" Then %>
		<th data-name="Fri_Delivery"><div id="elh_BusinessDetails_Fri_Delivery" class="BusinessDetails_Fri_Delivery"><div class="ewTableHeaderCaption"><%= BusinessDetails.Fri_Delivery.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Fri_Delivery"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.Fri_Delivery) %>',1);"><div id="elh_BusinessDetails_Fri_Delivery" class="BusinessDetails_Fri_Delivery">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.Fri_Delivery.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.Fri_Delivery.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.Fri_Delivery.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.Fri_Collection.Visible Then ' Fri_Collection %>
	<% If BusinessDetails.SortUrl(BusinessDetails.Fri_Collection) = "" Then %>
		<th data-name="Fri_Collection"><div id="elh_BusinessDetails_Fri_Collection" class="BusinessDetails_Fri_Collection"><div class="ewTableHeaderCaption"><%= BusinessDetails.Fri_Collection.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Fri_Collection"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.Fri_Collection) %>',1);"><div id="elh_BusinessDetails_Fri_Collection" class="BusinessDetails_Fri_Collection">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.Fri_Collection.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.Fri_Collection.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.Fri_Collection.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.Sat_Delivery.Visible Then ' Sat_Delivery %>
	<% If BusinessDetails.SortUrl(BusinessDetails.Sat_Delivery) = "" Then %>
		<th data-name="Sat_Delivery"><div id="elh_BusinessDetails_Sat_Delivery" class="BusinessDetails_Sat_Delivery"><div class="ewTableHeaderCaption"><%= BusinessDetails.Sat_Delivery.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Sat_Delivery"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.Sat_Delivery) %>',1);"><div id="elh_BusinessDetails_Sat_Delivery" class="BusinessDetails_Sat_Delivery">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.Sat_Delivery.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.Sat_Delivery.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.Sat_Delivery.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.Sat_Collection.Visible Then ' Sat_Collection %>
	<% If BusinessDetails.SortUrl(BusinessDetails.Sat_Collection) = "" Then %>
		<th data-name="Sat_Collection"><div id="elh_BusinessDetails_Sat_Collection" class="BusinessDetails_Sat_Collection"><div class="ewTableHeaderCaption"><%= BusinessDetails.Sat_Collection.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Sat_Collection"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.Sat_Collection) %>',1);"><div id="elh_BusinessDetails_Sat_Collection" class="BusinessDetails_Sat_Collection">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.Sat_Collection.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.Sat_Collection.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.Sat_Collection.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.Sun_Delivery.Visible Then ' Sun_Delivery %>
	<% If BusinessDetails.SortUrl(BusinessDetails.Sun_Delivery) = "" Then %>
		<th data-name="Sun_Delivery"><div id="elh_BusinessDetails_Sun_Delivery" class="BusinessDetails_Sun_Delivery"><div class="ewTableHeaderCaption"><%= BusinessDetails.Sun_Delivery.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Sun_Delivery"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.Sun_Delivery) %>',1);"><div id="elh_BusinessDetails_Sun_Delivery" class="BusinessDetails_Sun_Delivery">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.Sun_Delivery.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.Sun_Delivery.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.Sun_Delivery.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.Sun_Collection.Visible Then ' Sun_Collection %>
	<% If BusinessDetails.SortUrl(BusinessDetails.Sun_Collection) = "" Then %>
		<th data-name="Sun_Collection"><div id="elh_BusinessDetails_Sun_Collection" class="BusinessDetails_Sun_Collection"><div class="ewTableHeaderCaption"><%= BusinessDetails.Sun_Collection.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Sun_Collection"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.Sun_Collection) %>',1);"><div id="elh_BusinessDetails_Sun_Collection" class="BusinessDetails_Sun_Collection">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.Sun_Collection.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.Sun_Collection.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.Sun_Collection.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.EnableUrlRewrite.Visible Then ' EnableUrlRewrite %>
	<% If BusinessDetails.SortUrl(BusinessDetails.EnableUrlRewrite) = "" Then %>
		<th data-name="EnableUrlRewrite"><div id="elh_BusinessDetails_EnableUrlRewrite" class="BusinessDetails_EnableUrlRewrite"><div class="ewTableHeaderCaption"><%= BusinessDetails.EnableUrlRewrite.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="EnableUrlRewrite"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.EnableUrlRewrite) %>',1);"><div id="elh_BusinessDetails_EnableUrlRewrite" class="BusinessDetails_EnableUrlRewrite">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.EnableUrlRewrite.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.EnableUrlRewrite.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.EnableUrlRewrite.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.DeliveryCostUpTo.Visible Then ' DeliveryCostUpTo %>
	<% If BusinessDetails.SortUrl(BusinessDetails.DeliveryCostUpTo) = "" Then %>
		<th data-name="DeliveryCostUpTo"><div id="elh_BusinessDetails_DeliveryCostUpTo" class="BusinessDetails_DeliveryCostUpTo"><div class="ewTableHeaderCaption"><%= BusinessDetails.DeliveryCostUpTo.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="DeliveryCostUpTo"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.DeliveryCostUpTo) %>',1);"><div id="elh_BusinessDetails_DeliveryCostUpTo" class="BusinessDetails_DeliveryCostUpTo">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.DeliveryCostUpTo.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.DeliveryCostUpTo.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.DeliveryCostUpTo.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.DeliveryUptoMile.Visible Then ' DeliveryUptoMile %>
	<% If BusinessDetails.SortUrl(BusinessDetails.DeliveryUptoMile) = "" Then %>
		<th data-name="DeliveryUptoMile"><div id="elh_BusinessDetails_DeliveryUptoMile" class="BusinessDetails_DeliveryUptoMile"><div class="ewTableHeaderCaption"><%= BusinessDetails.DeliveryUptoMile.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="DeliveryUptoMile"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.DeliveryUptoMile) %>',1);"><div id="elh_BusinessDetails_DeliveryUptoMile" class="BusinessDetails_DeliveryUptoMile">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.DeliveryUptoMile.FldCaption %></span><span class="ewTableHeaderSort"><% If BusinessDetails.DeliveryUptoMile.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.DeliveryUptoMile.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.Show_Ordernumner_printer.Visible Then ' Show_Ordernumner_printer %>
	<% If BusinessDetails.SortUrl(BusinessDetails.Show_Ordernumner_printer) = "" Then %>
		<th data-name="Show_Ordernumner_printer"><div id="elh_BusinessDetails_Show_Ordernumner_printer" class="BusinessDetails_Show_Ordernumner_printer"><div class="ewTableHeaderCaption"><%= BusinessDetails.Show_Ordernumner_printer.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Show_Ordernumner_printer"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.Show_Ordernumner_printer) %>',1);"><div id="elh_BusinessDetails_Show_Ordernumner_printer" class="BusinessDetails_Show_Ordernumner_printer">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.Show_Ordernumner_printer.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.Show_Ordernumner_printer.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.Show_Ordernumner_printer.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.Show_Ordernumner_Receipt.Visible Then ' Show_Ordernumner_Receipt %>
	<% If BusinessDetails.SortUrl(BusinessDetails.Show_Ordernumner_Receipt) = "" Then %>
		<th data-name="Show_Ordernumner_Receipt"><div id="elh_BusinessDetails_Show_Ordernumner_Receipt" class="BusinessDetails_Show_Ordernumner_Receipt"><div class="ewTableHeaderCaption"><%= BusinessDetails.Show_Ordernumner_Receipt.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Show_Ordernumner_Receipt"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.Show_Ordernumner_Receipt) %>',1);"><div id="elh_BusinessDetails_Show_Ordernumner_Receipt" class="BusinessDetails_Show_Ordernumner_Receipt">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.Show_Ordernumner_Receipt.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.Show_Ordernumner_Receipt.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.Show_Ordernumner_Receipt.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<% If BusinessDetails.Show_Ordernumner_Dashboard.Visible Then ' Show_Ordernumner_Dashboard %>
	<% If BusinessDetails.SortUrl(BusinessDetails.Show_Ordernumner_Dashboard) = "" Then %>
		<th data-name="Show_Ordernumner_Dashboard"><div id="elh_BusinessDetails_Show_Ordernumner_Dashboard" class="BusinessDetails_Show_Ordernumner_Dashboard"><div class="ewTableHeaderCaption"><%= BusinessDetails.Show_Ordernumner_Dashboard.FldCaption %></div></div></th>
	<% Else %>
		<th data-name="Show_Ordernumner_Dashboard"><div class="ewPointer" onclick="ew_Sort(event,'<%= BusinessDetails.SortUrl(BusinessDetails.Show_Ordernumner_Dashboard) %>',1);"><div id="elh_BusinessDetails_Show_Ordernumner_Dashboard" class="BusinessDetails_Show_Ordernumner_Dashboard">
			<div class="ewTableHeaderBtn"><span class="ewTableHeaderCaption"><%= BusinessDetails.Show_Ordernumner_Dashboard.FldCaption %><%= Language.Phrase("SrchLegend") %></span><span class="ewTableHeaderSort"><% If BusinessDetails.Show_Ordernumner_Dashboard.Sort = "ASC" Then %><span class="caret ewSortUp"></span><% ElseIf BusinessDetails.Show_Ordernumner_Dashboard.Sort = "DESC" Then %><span class="caret"></span><% End If %></span></div>
        </div></div></th>
	<% End If %>
<% End If %>		
<%

' Render list options (header, right)
BusinessDetails_list.ListOptions.Render "header", "right", "", "", "", ""
%>
	</tr>
</thead>
<tbody><!-- Table body -->
<%
If (BusinessDetails.ExportAll And BusinessDetails.Export <> "") Then
	BusinessDetails_list.StopRec = BusinessDetails_list.TotalRecs
Else

	' Set the last record to display
	If BusinessDetails_list.TotalRecs > BusinessDetails_list.StartRec + BusinessDetails_list.DisplayRecs - 1 Then
		BusinessDetails_list.StopRec = BusinessDetails_list.StartRec + BusinessDetails_list.DisplayRecs - 1
	Else
		BusinessDetails_list.StopRec = BusinessDetails_list.TotalRecs
	End If
End If

' Move to first record
BusinessDetails_list.RecCnt = BusinessDetails_list.StartRec - 1
If Not BusinessDetails_list.Recordset.Eof Then
	BusinessDetails_list.Recordset.MoveFirst
	If BusinessDetails_list.StartRec > 1 Then BusinessDetails_list.Recordset.Move BusinessDetails_list.StartRec - 1
ElseIf Not BusinessDetails.AllowAddDeleteRow And BusinessDetails_list.StopRec = 0 Then
	BusinessDetails_list.StopRec = BusinessDetails.GridAddRowCount
End If

' Initialize Aggregate
BusinessDetails.RowType = EW_ROWTYPE_AGGREGATEINIT
Call BusinessDetails.ResetAttrs()
Call BusinessDetails_list.RenderRow()
BusinessDetails_list.RowCnt = 0

' Output date rows
Do While CLng(BusinessDetails_list.RecCnt) < CLng(BusinessDetails_list.StopRec)
	BusinessDetails_list.RecCnt = BusinessDetails_list.RecCnt + 1
	If CLng(BusinessDetails_list.RecCnt) >= CLng(BusinessDetails_list.StartRec) Then
		BusinessDetails_list.RowCnt = BusinessDetails_list.RowCnt + 1

	' Set up key count
	BusinessDetails_list.KeyCount = BusinessDetails_list.RowIndex
	Call BusinessDetails.ResetAttrs()
	BusinessDetails.CssClass = ""
	If BusinessDetails.CurrentAction = "gridadd" Then
	Else
		Call BusinessDetails_list.LoadRowValues(BusinessDetails_list.Recordset) ' Load row values
	End If
	BusinessDetails.RowType = EW_ROWTYPE_VIEW ' Render view

	' Set up row id / data-rowindex
	BusinessDetails.RowAttrs.AddAttributes Array(Array("data-rowindex", BusinessDetails_list.RowCnt), Array("id", "r" & BusinessDetails_list.RowCnt & "_BusinessDetails"), Array("data-rowtype", BusinessDetails.RowType))

	' Render row
	Call BusinessDetails_list.RenderRow()

	' Render list options
	Call BusinessDetails_list.RenderListOptions()
%>
	<tr<%= BusinessDetails.RowAttributes %>>
<%

' Render list options (body, left)
BusinessDetails_list.ListOptions.Render "body", "left", BusinessDetails_list.RowCnt, "", "", ""
%>
	<% If BusinessDetails.ID.Visible Then ' ID %>
		<td data-name="ID"<%= BusinessDetails.ID.CellAttributes %>>
<span<%= BusinessDetails.ID.ViewAttributes %>>
<%= BusinessDetails.ID.ListViewValue %>
</span>
<a id="<%= BusinessDetails_list.PageObjName & "_row_" & BusinessDetails_list.RowCnt %>"></a></td>
	<% End If %>
	<% If BusinessDetails.Name.Visible Then ' Name %>
		<td data-name="Name"<%= BusinessDetails.Name.CellAttributes %>>
<span<%= BusinessDetails.Name.ViewAttributes %>>
<%= BusinessDetails.Name.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.Address.Visible Then ' Address %>
		<td data-name="Address"<%= BusinessDetails.Address.CellAttributes %>>
<span<%= BusinessDetails.Address.ViewAttributes %>>
<%= BusinessDetails.Address.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.PostalCode.Visible Then ' PostalCode %>
		<td data-name="PostalCode"<%= BusinessDetails.PostalCode.CellAttributes %>>
<span<%= BusinessDetails.PostalCode.ViewAttributes %>>
<%= BusinessDetails.PostalCode.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.FoodType.Visible Then ' FoodType %>
		<td data-name="FoodType"<%= BusinessDetails.FoodType.CellAttributes %>>
<span<%= BusinessDetails.FoodType.ViewAttributes %>>
<%= BusinessDetails.FoodType.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.DeliveryMinAmount.Visible Then ' DeliveryMinAmount %>
		<td data-name="DeliveryMinAmount"<%= BusinessDetails.DeliveryMinAmount.CellAttributes %>>
<span<%= BusinessDetails.DeliveryMinAmount.ViewAttributes %>>
<%= BusinessDetails.DeliveryMinAmount.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.DeliveryMaxDistance.Visible Then ' DeliveryMaxDistance %>
		<td data-name="DeliveryMaxDistance"<%= BusinessDetails.DeliveryMaxDistance.CellAttributes %>>
<span<%= BusinessDetails.DeliveryMaxDistance.ViewAttributes %>>
<%= BusinessDetails.DeliveryMaxDistance.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.DeliveryFreeDistance.Visible Then ' DeliveryFreeDistance %>
		<td data-name="DeliveryFreeDistance"<%= BusinessDetails.DeliveryFreeDistance.CellAttributes %>>
<span<%= BusinessDetails.DeliveryFreeDistance.ViewAttributes %>>
<%= BusinessDetails.DeliveryFreeDistance.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.AverageDeliveryTime.Visible Then ' AverageDeliveryTime %>
		<td data-name="AverageDeliveryTime"<%= BusinessDetails.AverageDeliveryTime.CellAttributes %>>
<span<%= BusinessDetails.AverageDeliveryTime.ViewAttributes %>>
<%= BusinessDetails.AverageDeliveryTime.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.AverageCollectionTime.Visible Then ' AverageCollectionTime %>
		<td data-name="AverageCollectionTime"<%= BusinessDetails.AverageCollectionTime.CellAttributes %>>
<span<%= BusinessDetails.AverageCollectionTime.ViewAttributes %>>
<%= BusinessDetails.AverageCollectionTime.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.DeliveryFee.Visible Then ' DeliveryFee %>
		<td data-name="DeliveryFee"<%= BusinessDetails.DeliveryFee.CellAttributes %>>
<span<%= BusinessDetails.DeliveryFee.ViewAttributes %>>
<%= BusinessDetails.DeliveryFee.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.ImgUrl.Visible Then ' ImgUrl %>
		<td data-name="ImgUrl"<%= BusinessDetails.ImgUrl.CellAttributes %>>
<span<%= BusinessDetails.ImgUrl.ViewAttributes %>>
<%= BusinessDetails.ImgUrl.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.Telephone.Visible Then ' Telephone %>
		<td data-name="Telephone"<%= BusinessDetails.Telephone.CellAttributes %>>
<span<%= BusinessDetails.Telephone.ViewAttributes %>>
<%= BusinessDetails.Telephone.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.zEmail.Visible Then ' Email %>
		<td data-name="zEmail"<%= BusinessDetails.zEmail.CellAttributes %>>
<span<%= BusinessDetails.zEmail.ViewAttributes %>>
<%= BusinessDetails.zEmail.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.pswd.Visible Then ' pswd %>
		<td data-name="pswd"<%= BusinessDetails.pswd.CellAttributes %>>
<span<%= BusinessDetails.pswd.ViewAttributes %>>
<%= BusinessDetails.pswd.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.businessclosed.Visible Then ' businessclosed %>
		<td data-name="businessclosed"<%= BusinessDetails.businessclosed.CellAttributes %>>
<span<%= BusinessDetails.businessclosed.ViewAttributes %>>
<%= BusinessDetails.businessclosed.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.SMTP_AUTENTICATE.Visible Then ' SMTP_AUTENTICATE %>
		<td data-name="SMTP_AUTENTICATE"<%= BusinessDetails.SMTP_AUTENTICATE.CellAttributes %>>
<span<%= BusinessDetails.SMTP_AUTENTICATE.ViewAttributes %>>
<%= BusinessDetails.SMTP_AUTENTICATE.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.MAIL_FROM.Visible Then ' MAIL_FROM %>
		<td data-name="MAIL_FROM"<%= BusinessDetails.MAIL_FROM.CellAttributes %>>
<span<%= BusinessDetails.MAIL_FROM.ViewAttributes %>>
<%= BusinessDetails.MAIL_FROM.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.PAYPAL_URL.Visible Then ' PAYPAL_URL %>
		<td data-name="PAYPAL_URL"<%= BusinessDetails.PAYPAL_URL.CellAttributes %>>
<span<%= BusinessDetails.PAYPAL_URL.ViewAttributes %>>
<%= BusinessDetails.PAYPAL_URL.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.PAYPAL_PDT.Visible Then ' PAYPAL_PDT %>
		<td data-name="PAYPAL_PDT"<%= BusinessDetails.PAYPAL_PDT.CellAttributes %>>
<span<%= BusinessDetails.PAYPAL_PDT.ViewAttributes %>>
<%= BusinessDetails.PAYPAL_PDT.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.SMTP_PASSWORD.Visible Then ' SMTP_PASSWORD %>
		<td data-name="SMTP_PASSWORD"<%= BusinessDetails.SMTP_PASSWORD.CellAttributes %>>
<span<%= BusinessDetails.SMTP_PASSWORD.ViewAttributes %>>
<%= BusinessDetails.SMTP_PASSWORD.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.GMAP_API_KEY.Visible Then ' GMAP_API_KEY %>
		<td data-name="GMAP_API_KEY"<%= BusinessDetails.GMAP_API_KEY.CellAttributes %>>
<span<%= BusinessDetails.GMAP_API_KEY.ViewAttributes %>>
<%= BusinessDetails.GMAP_API_KEY.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.SMTP_USERNAME.Visible Then ' SMTP_USERNAME %>
		<td data-name="SMTP_USERNAME"<%= BusinessDetails.SMTP_USERNAME.CellAttributes %>>
<span<%= BusinessDetails.SMTP_USERNAME.ViewAttributes %>>
<%= BusinessDetails.SMTP_USERNAME.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.SMTP_USESSL.Visible Then ' SMTP_USESSL %>
		<td data-name="SMTP_USESSL"<%= BusinessDetails.SMTP_USESSL.CellAttributes %>>
<span<%= BusinessDetails.SMTP_USESSL.ViewAttributes %>>
<%= BusinessDetails.SMTP_USESSL.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.MAIL_SUBJECT.Visible Then ' MAIL_SUBJECT %>
		<td data-name="MAIL_SUBJECT"<%= BusinessDetails.MAIL_SUBJECT.CellAttributes %>>
<span<%= BusinessDetails.MAIL_SUBJECT.ViewAttributes %>>
<%= BusinessDetails.MAIL_SUBJECT.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.CURRENCYSYMBOL.Visible Then ' CURRENCYSYMBOL %>
		<td data-name="CURRENCYSYMBOL"<%= BusinessDetails.CURRENCYSYMBOL.CellAttributes %>>
<span<%= BusinessDetails.CURRENCYSYMBOL.ViewAttributes %>>
<%= BusinessDetails.CURRENCYSYMBOL.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.SMTP_SERVER.Visible Then ' SMTP_SERVER %>
		<td data-name="SMTP_SERVER"<%= BusinessDetails.SMTP_SERVER.CellAttributes %>>
<span<%= BusinessDetails.SMTP_SERVER.ViewAttributes %>>
<%= BusinessDetails.SMTP_SERVER.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.CREDITCARDSURCHARGE.Visible Then ' CREDITCARDSURCHARGE %>
		<td data-name="CREDITCARDSURCHARGE"<%= BusinessDetails.CREDITCARDSURCHARGE.CellAttributes %>>
<span<%= BusinessDetails.CREDITCARDSURCHARGE.ViewAttributes %>>
<%= BusinessDetails.CREDITCARDSURCHARGE.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.SMTP_PORT.Visible Then ' SMTP_PORT %>
		<td data-name="SMTP_PORT"<%= BusinessDetails.SMTP_PORT.CellAttributes %>>
<span<%= BusinessDetails.SMTP_PORT.ViewAttributes %>>
<%= BusinessDetails.SMTP_PORT.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.STICK_MENU.Visible Then ' STICK_MENU %>
		<td data-name="STICK_MENU"<%= BusinessDetails.STICK_MENU.CellAttributes %>>
<span<%= BusinessDetails.STICK_MENU.ViewAttributes %>>
<%= BusinessDetails.STICK_MENU.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.MAIL_CUSTOMER_SUBJECT.Visible Then ' MAIL_CUSTOMER_SUBJECT %>
		<td data-name="MAIL_CUSTOMER_SUBJECT"<%= BusinessDetails.MAIL_CUSTOMER_SUBJECT.CellAttributes %>>
<span<%= BusinessDetails.MAIL_CUSTOMER_SUBJECT.ViewAttributes %>>
<%= BusinessDetails.MAIL_CUSTOMER_SUBJECT.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.Visible Then ' CONFIRMATION_EMAIL_ADDRESS %>
		<td data-name="CONFIRMATION_EMAIL_ADDRESS"<%= BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.CellAttributes %>>
<span<%= BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.ViewAttributes %>>
<%= BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.SEND_ORDERS_TO_PRINTER.Visible Then ' SEND_ORDERS_TO_PRINTER %>
		<td data-name="SEND_ORDERS_TO_PRINTER"<%= BusinessDetails.SEND_ORDERS_TO_PRINTER.CellAttributes %>>
<span<%= BusinessDetails.SEND_ORDERS_TO_PRINTER.ViewAttributes %>>
<%= BusinessDetails.SEND_ORDERS_TO_PRINTER.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.timezone.Visible Then ' timezone %>
		<td data-name="timezone"<%= BusinessDetails.timezone.CellAttributes %>>
<span<%= BusinessDetails.timezone.ViewAttributes %>>
<%= BusinessDetails.timezone.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.PAYPAL_ADDR.Visible Then ' PAYPAL_ADDR %>
		<td data-name="PAYPAL_ADDR"<%= BusinessDetails.PAYPAL_ADDR.CellAttributes %>>
<span<%= BusinessDetails.PAYPAL_ADDR.ViewAttributes %>>
<%= BusinessDetails.PAYPAL_ADDR.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.nochex.Visible Then ' nochex %>
		<td data-name="nochex"<%= BusinessDetails.nochex.CellAttributes %>>
<span<%= BusinessDetails.nochex.ViewAttributes %>>
<%= BusinessDetails.nochex.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.nochexmerchantid.Visible Then ' nochexmerchantid %>
		<td data-name="nochexmerchantid"<%= BusinessDetails.nochexmerchantid.CellAttributes %>>
<span<%= BusinessDetails.nochexmerchantid.ViewAttributes %>>
<%= BusinessDetails.nochexmerchantid.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.paypal.Visible Then ' paypal %>
		<td data-name="paypal"<%= BusinessDetails.paypal.CellAttributes %>>
<span<%= BusinessDetails.paypal.ViewAttributes %>>
<%= BusinessDetails.paypal.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.IBT_API_KEY.Visible Then ' IBT_API_KEY %>
		<td data-name="IBT_API_KEY"<%= BusinessDetails.IBT_API_KEY.CellAttributes %>>
<span<%= BusinessDetails.IBT_API_KEY.ViewAttributes %>>
<%= BusinessDetails.IBT_API_KEY.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.IBP_API_PASSWORD.Visible Then ' IBP_API_PASSWORD %>
		<td data-name="IBP_API_PASSWORD"<%= BusinessDetails.IBP_API_PASSWORD.CellAttributes %>>
<span<%= BusinessDetails.IBP_API_PASSWORD.ViewAttributes %>>
<%= BusinessDetails.IBP_API_PASSWORD.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.disable_delivery.Visible Then ' disable_delivery %>
		<td data-name="disable_delivery"<%= BusinessDetails.disable_delivery.CellAttributes %>>
<span<%= BusinessDetails.disable_delivery.ViewAttributes %>>
<%= BusinessDetails.disable_delivery.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.disable_collection.Visible Then ' disable_collection %>
		<td data-name="disable_collection"<%= BusinessDetails.disable_collection.CellAttributes %>>
<span<%= BusinessDetails.disable_collection.ViewAttributes %>>
<%= BusinessDetails.disable_collection.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.worldpay.Visible Then ' worldpay %>
		<td data-name="worldpay"<%= BusinessDetails.worldpay.CellAttributes %>>
<span<%= BusinessDetails.worldpay.ViewAttributes %>>
<%= BusinessDetails.worldpay.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.worldpaymerchantid.Visible Then ' worldpaymerchantid %>
		<td data-name="worldpaymerchantid"<%= BusinessDetails.worldpaymerchantid.CellAttributes %>>
<span<%= BusinessDetails.worldpaymerchantid.ViewAttributes %>>
<%= BusinessDetails.worldpaymerchantid.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.DeliveryChargeOverrideByOrderValue.Visible Then ' DeliveryChargeOverrideByOrderValue %>
		<td data-name="DeliveryChargeOverrideByOrderValue"<%= BusinessDetails.DeliveryChargeOverrideByOrderValue.CellAttributes %>>
<span<%= BusinessDetails.DeliveryChargeOverrideByOrderValue.ViewAttributes %>>
<%= BusinessDetails.DeliveryChargeOverrideByOrderValue.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.individualpostcodeschecking.Visible Then ' individualpostcodeschecking %>
		<td data-name="individualpostcodeschecking"<%= BusinessDetails.individualpostcodeschecking.CellAttributes %>>
<span<%= BusinessDetails.individualpostcodeschecking.ViewAttributes %>>
<%= BusinessDetails.individualpostcodeschecking.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.longitude.Visible Then ' longitude %>
		<td data-name="longitude"<%= BusinessDetails.longitude.CellAttributes %>>
<span<%= BusinessDetails.longitude.ViewAttributes %>>
<%= BusinessDetails.longitude.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.latitude.Visible Then ' latitude %>
		<td data-name="latitude"<%= BusinessDetails.latitude.CellAttributes %>>
<span<%= BusinessDetails.latitude.ViewAttributes %>>
<%= BusinessDetails.latitude.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.googleecommercetracking.Visible Then ' googleecommercetracking %>
		<td data-name="googleecommercetracking"<%= BusinessDetails.googleecommercetracking.CellAttributes %>>
<span<%= BusinessDetails.googleecommercetracking.ViewAttributes %>>
<%= BusinessDetails.googleecommercetracking.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.googleecommercetrackingcode.Visible Then ' googleecommercetrackingcode %>
		<td data-name="googleecommercetrackingcode"<%= BusinessDetails.googleecommercetrackingcode.CellAttributes %>>
<span<%= BusinessDetails.googleecommercetrackingcode.ViewAttributes %>>
<%= BusinessDetails.googleecommercetrackingcode.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.bringg.Visible Then ' bringg %>
		<td data-name="bringg"<%= BusinessDetails.bringg.CellAttributes %>>
<span<%= BusinessDetails.bringg.ViewAttributes %>>
<%= BusinessDetails.bringg.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.bringgurl.Visible Then ' bringgurl %>
		<td data-name="bringgurl"<%= BusinessDetails.bringgurl.CellAttributes %>>
<span<%= BusinessDetails.bringgurl.ViewAttributes %>>
<%= BusinessDetails.bringgurl.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.bringgcompanyid.Visible Then ' bringgcompanyid %>
		<td data-name="bringgcompanyid"<%= BusinessDetails.bringgcompanyid.CellAttributes %>>
<span<%= BusinessDetails.bringgcompanyid.ViewAttributes %>>
<%= BusinessDetails.bringgcompanyid.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.orderonlywhenopen.Visible Then ' orderonlywhenopen %>
		<td data-name="orderonlywhenopen"<%= BusinessDetails.orderonlywhenopen.CellAttributes %>>
<span<%= BusinessDetails.orderonlywhenopen.ViewAttributes %>>
<%= BusinessDetails.orderonlywhenopen.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.disablelaterdelivery.Visible Then ' disablelaterdelivery %>
		<td data-name="disablelaterdelivery"<%= BusinessDetails.disablelaterdelivery.CellAttributes %>>
<span<%= BusinessDetails.disablelaterdelivery.ViewAttributes %>>
<%= BusinessDetails.disablelaterdelivery.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.ordertodayonly.Visible Then ' ordertodayonly %>
		<td data-name="ordertodayonly"<%= BusinessDetails.ordertodayonly.CellAttributes %>>
<span<%= BusinessDetails.ordertodayonly.ViewAttributes %>>
<%= BusinessDetails.ordertodayonly.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.mileskm.Visible Then ' mileskm %>
		<td data-name="mileskm"<%= BusinessDetails.mileskm.CellAttributes %>>
<span<%= BusinessDetails.mileskm.ViewAttributes %>>
<%= BusinessDetails.mileskm.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.worldpaylive.Visible Then ' worldpaylive %>
		<td data-name="worldpaylive"<%= BusinessDetails.worldpaylive.CellAttributes %>>
<span<%= BusinessDetails.worldpaylive.ViewAttributes %>>
<%= BusinessDetails.worldpaylive.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.worldpayinstallationid.Visible Then ' worldpayinstallationid %>
		<td data-name="worldpayinstallationid"<%= BusinessDetails.worldpayinstallationid.CellAttributes %>>
<span<%= BusinessDetails.worldpayinstallationid.ViewAttributes %>>
<%= BusinessDetails.worldpayinstallationid.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.DistanceCalMethod.Visible Then ' DistanceCalMethod %>
		<td data-name="DistanceCalMethod"<%= BusinessDetails.DistanceCalMethod.CellAttributes %>>
<span<%= BusinessDetails.DistanceCalMethod.ViewAttributes %>>
<%= BusinessDetails.DistanceCalMethod.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.PrinterIDList.Visible Then ' PrinterIDList %>
		<td data-name="PrinterIDList"<%= BusinessDetails.PrinterIDList.CellAttributes %>>
<span<%= BusinessDetails.PrinterIDList.ViewAttributes %>>
<%= BusinessDetails.PrinterIDList.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.EpsonJSPrinterURL.Visible Then ' EpsonJSPrinterURL %>
		<td data-name="EpsonJSPrinterURL"<%= BusinessDetails.EpsonJSPrinterURL.CellAttributes %>>
<span<%= BusinessDetails.EpsonJSPrinterURL.ViewAttributes %>>
<%= BusinessDetails.EpsonJSPrinterURL.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.SMSEnable.Visible Then ' SMSEnable %>
		<td data-name="SMSEnable"<%= BusinessDetails.SMSEnable.CellAttributes %>>
<span<%= BusinessDetails.SMSEnable.ViewAttributes %>>
<%= BusinessDetails.SMSEnable.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.SMSOnDelivery.Visible Then ' SMSOnDelivery %>
		<td data-name="SMSOnDelivery"<%= BusinessDetails.SMSOnDelivery.CellAttributes %>>
<span<%= BusinessDetails.SMSOnDelivery.ViewAttributes %>>
<%= BusinessDetails.SMSOnDelivery.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.SMSSupplierDomain.Visible Then ' SMSSupplierDomain %>
		<td data-name="SMSSupplierDomain"<%= BusinessDetails.SMSSupplierDomain.CellAttributes %>>
<span<%= BusinessDetails.SMSSupplierDomain.ViewAttributes %>>
<%= BusinessDetails.SMSSupplierDomain.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.SMSOnOrder.Visible Then ' SMSOnOrder %>
		<td data-name="SMSOnOrder"<%= BusinessDetails.SMSOnOrder.CellAttributes %>>
<span<%= BusinessDetails.SMSOnOrder.ViewAttributes %>>
<%= BusinessDetails.SMSOnOrder.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.SMSOnOrderAfterMin.Visible Then ' SMSOnOrderAfterMin %>
		<td data-name="SMSOnOrderAfterMin"<%= BusinessDetails.SMSOnOrderAfterMin.CellAttributes %>>
<span<%= BusinessDetails.SMSOnOrderAfterMin.ViewAttributes %>>
<%= BusinessDetails.SMSOnOrderAfterMin.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.SMSOnOrderContent.Visible Then ' SMSOnOrderContent %>
		<td data-name="SMSOnOrderContent"<%= BusinessDetails.SMSOnOrderContent.CellAttributes %>>
<span<%= BusinessDetails.SMSOnOrderContent.ViewAttributes %>>
<%= BusinessDetails.SMSOnOrderContent.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.DefaultSMSCountryCode.Visible Then ' DefaultSMSCountryCode %>
		<td data-name="DefaultSMSCountryCode"<%= BusinessDetails.DefaultSMSCountryCode.CellAttributes %>>
<span<%= BusinessDetails.DefaultSMSCountryCode.ViewAttributes %>>
<%= BusinessDetails.DefaultSMSCountryCode.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.MinimumAmountForCardPayment.Visible Then ' MinimumAmountForCardPayment %>
		<td data-name="MinimumAmountForCardPayment"<%= BusinessDetails.MinimumAmountForCardPayment.CellAttributes %>>
<span<%= BusinessDetails.MinimumAmountForCardPayment.ViewAttributes %>>
<%= BusinessDetails.MinimumAmountForCardPayment.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.FavIconUrl.Visible Then ' FavIconUrl %>
		<td data-name="FavIconUrl"<%= BusinessDetails.FavIconUrl.CellAttributes %>>
<span<%= BusinessDetails.FavIconUrl.ViewAttributes %>>
<%= BusinessDetails.FavIconUrl.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.AddToHomeScreenURL.Visible Then ' AddToHomeScreenURL %>
		<td data-name="AddToHomeScreenURL"<%= BusinessDetails.AddToHomeScreenURL.CellAttributes %>>
<span<%= BusinessDetails.AddToHomeScreenURL.ViewAttributes %>>
<%= BusinessDetails.AddToHomeScreenURL.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.SMSOnAcknowledgement.Visible Then ' SMSOnAcknowledgement %>
		<td data-name="SMSOnAcknowledgement"<%= BusinessDetails.SMSOnAcknowledgement.CellAttributes %>>
<span<%= BusinessDetails.SMSOnAcknowledgement.ViewAttributes %>>
<%= BusinessDetails.SMSOnAcknowledgement.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.LocalPrinterURL.Visible Then ' LocalPrinterURL %>
		<td data-name="LocalPrinterURL"<%= BusinessDetails.LocalPrinterURL.CellAttributes %>>
<span<%= BusinessDetails.LocalPrinterURL.ViewAttributes %>>
<%= BusinessDetails.LocalPrinterURL.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.ShowRestaurantDetailOnReceipt.Visible Then ' ShowRestaurantDetailOnReceipt %>
		<td data-name="ShowRestaurantDetailOnReceipt"<%= BusinessDetails.ShowRestaurantDetailOnReceipt.CellAttributes %>>
<span<%= BusinessDetails.ShowRestaurantDetailOnReceipt.ViewAttributes %>>
<%= BusinessDetails.ShowRestaurantDetailOnReceipt.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.PrinterFontSizeRatio.Visible Then ' PrinterFontSizeRatio %>
		<td data-name="PrinterFontSizeRatio"<%= BusinessDetails.PrinterFontSizeRatio.CellAttributes %>>
<span<%= BusinessDetails.PrinterFontSizeRatio.ViewAttributes %>>
<%= BusinessDetails.PrinterFontSizeRatio.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.ServiceChargePercentage.Visible Then ' ServiceChargePercentage %>
		<td data-name="ServiceChargePercentage"<%= BusinessDetails.ServiceChargePercentage.CellAttributes %>>
<span<%= BusinessDetails.ServiceChargePercentage.ViewAttributes %>>
<%= BusinessDetails.ServiceChargePercentage.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.InRestaurantServiceChargeOnly.Visible Then ' InRestaurantServiceChargeOnly %>
		<td data-name="InRestaurantServiceChargeOnly"<%= BusinessDetails.InRestaurantServiceChargeOnly.CellAttributes %>>
<span<%= BusinessDetails.InRestaurantServiceChargeOnly.ViewAttributes %>>
<%= BusinessDetails.InRestaurantServiceChargeOnly.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.IsDualReceiptPrinting.Visible Then ' IsDualReceiptPrinting %>
		<td data-name="IsDualReceiptPrinting"<%= BusinessDetails.IsDualReceiptPrinting.CellAttributes %>>
<span<%= BusinessDetails.IsDualReceiptPrinting.ViewAttributes %>>
<%= BusinessDetails.IsDualReceiptPrinting.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.PrintingFontSize.Visible Then ' PrintingFontSize %>
		<td data-name="PrintingFontSize"<%= BusinessDetails.PrintingFontSize.CellAttributes %>>
<span<%= BusinessDetails.PrintingFontSize.ViewAttributes %>>
<%= BusinessDetails.PrintingFontSize.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.InRestaurantEpsonPrinterIDList.Visible Then ' InRestaurantEpsonPrinterIDList %>
		<td data-name="InRestaurantEpsonPrinterIDList"<%= BusinessDetails.InRestaurantEpsonPrinterIDList.CellAttributes %>>
<span<%= BusinessDetails.InRestaurantEpsonPrinterIDList.ViewAttributes %>>
<%= BusinessDetails.InRestaurantEpsonPrinterIDList.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.BlockIPEmailList.Visible Then ' BlockIPEmailList %>
		<td data-name="BlockIPEmailList"<%= BusinessDetails.BlockIPEmailList.CellAttributes %>>
<span<%= BusinessDetails.BlockIPEmailList.ViewAttributes %>>
<%= BusinessDetails.BlockIPEmailList.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.RePrintReceiptWays.Visible Then ' RePrintReceiptWays %>
		<td data-name="RePrintReceiptWays"<%= BusinessDetails.RePrintReceiptWays.CellAttributes %>>
<span<%= BusinessDetails.RePrintReceiptWays.ViewAttributes %>>
<%= BusinessDetails.RePrintReceiptWays.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.printingtype.Visible Then ' printingtype %>
		<td data-name="printingtype"<%= BusinessDetails.printingtype.CellAttributes %>>
<span<%= BusinessDetails.printingtype.ViewAttributes %>>
<%= BusinessDetails.printingtype.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.Stripe_Key_Secret.Visible Then ' Stripe_Key_Secret %>
		<td data-name="Stripe_Key_Secret"<%= BusinessDetails.Stripe_Key_Secret.CellAttributes %>>
<span<%= BusinessDetails.Stripe_Key_Secret.ViewAttributes %>>
<%= BusinessDetails.Stripe_Key_Secret.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.Stripe.Visible Then ' Stripe %>
		<td data-name="Stripe"<%= BusinessDetails.Stripe.CellAttributes %>>
<span<%= BusinessDetails.Stripe.ViewAttributes %>>
<%= BusinessDetails.Stripe.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.Stripe_Api_Key.Visible Then ' Stripe_Api_Key %>
		<td data-name="Stripe_Api_Key"<%= BusinessDetails.Stripe_Api_Key.CellAttributes %>>
<span<%= BusinessDetails.Stripe_Api_Key.ViewAttributes %>>
<%= BusinessDetails.Stripe_Api_Key.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.EnableBooking.Visible Then ' EnableBooking %>
		<td data-name="EnableBooking"<%= BusinessDetails.EnableBooking.CellAttributes %>>
<span<%= BusinessDetails.EnableBooking.ViewAttributes %>>
<%= BusinessDetails.EnableBooking.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.URL_Facebook.Visible Then ' URL_Facebook %>
		<td data-name="URL_Facebook"<%= BusinessDetails.URL_Facebook.CellAttributes %>>
<span<%= BusinessDetails.URL_Facebook.ViewAttributes %>>
<%= BusinessDetails.URL_Facebook.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.URL_Twitter.Visible Then ' URL_Twitter %>
		<td data-name="URL_Twitter"<%= BusinessDetails.URL_Twitter.CellAttributes %>>
<span<%= BusinessDetails.URL_Twitter.ViewAttributes %>>
<%= BusinessDetails.URL_Twitter.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.URL_Google.Visible Then ' URL_Google %>
		<td data-name="URL_Google"<%= BusinessDetails.URL_Google.CellAttributes %>>
<span<%= BusinessDetails.URL_Google.ViewAttributes %>>
<%= BusinessDetails.URL_Google.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.URL_Intagram.Visible Then ' URL_Intagram %>
		<td data-name="URL_Intagram"<%= BusinessDetails.URL_Intagram.CellAttributes %>>
<span<%= BusinessDetails.URL_Intagram.ViewAttributes %>>
<%= BusinessDetails.URL_Intagram.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.URL_YouTube.Visible Then ' URL_YouTube %>
		<td data-name="URL_YouTube"<%= BusinessDetails.URL_YouTube.CellAttributes %>>
<span<%= BusinessDetails.URL_YouTube.ViewAttributes %>>
<%= BusinessDetails.URL_YouTube.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.URL_Tripadvisor.Visible Then ' URL_Tripadvisor %>
		<td data-name="URL_Tripadvisor"<%= BusinessDetails.URL_Tripadvisor.CellAttributes %>>
<span<%= BusinessDetails.URL_Tripadvisor.ViewAttributes %>>
<%= BusinessDetails.URL_Tripadvisor.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.URL_Special_Offer.Visible Then ' URL_Special_Offer %>
		<td data-name="URL_Special_Offer"<%= BusinessDetails.URL_Special_Offer.CellAttributes %>>
<span<%= BusinessDetails.URL_Special_Offer.ViewAttributes %>>
<%= BusinessDetails.URL_Special_Offer.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.URL_Linkin.Visible Then ' URL_Linkin %>
		<td data-name="URL_Linkin"<%= BusinessDetails.URL_Linkin.CellAttributes %>>
<span<%= BusinessDetails.URL_Linkin.ViewAttributes %>>
<%= BusinessDetails.URL_Linkin.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.Currency_PAYPAL.Visible Then ' Currency_PAYPAL %>
		<td data-name="Currency_PAYPAL"<%= BusinessDetails.Currency_PAYPAL.CellAttributes %>>
<span<%= BusinessDetails.Currency_PAYPAL.ViewAttributes %>>
<%= BusinessDetails.Currency_PAYPAL.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.Currency_STRIPE.Visible Then ' Currency_STRIPE %>
		<td data-name="Currency_STRIPE"<%= BusinessDetails.Currency_STRIPE.CellAttributes %>>
<span<%= BusinessDetails.Currency_STRIPE.ViewAttributes %>>
<%= BusinessDetails.Currency_STRIPE.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.Currency_WOLRDPAY.Visible Then ' Currency_WOLRDPAY %>
		<td data-name="Currency_WOLRDPAY"<%= BusinessDetails.Currency_WOLRDPAY.CellAttributes %>>
<span<%= BusinessDetails.Currency_WOLRDPAY.ViewAttributes %>>
<%= BusinessDetails.Currency_WOLRDPAY.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.Tip_percent.Visible Then ' Tip_percent %>
		<td data-name="Tip_percent"<%= BusinessDetails.Tip_percent.CellAttributes %>>
<span<%= BusinessDetails.Tip_percent.ViewAttributes %>>
<%= BusinessDetails.Tip_percent.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.Tax_Percent.Visible Then ' Tax_Percent %>
		<td data-name="Tax_Percent"<%= BusinessDetails.Tax_Percent.CellAttributes %>>
<span<%= BusinessDetails.Tax_Percent.ViewAttributes %>>
<%= BusinessDetails.Tax_Percent.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.InRestaurantTaxChargeOnly.Visible Then ' InRestaurantTaxChargeOnly %>
		<td data-name="InRestaurantTaxChargeOnly"<%= BusinessDetails.InRestaurantTaxChargeOnly.CellAttributes %>>
<span<%= BusinessDetails.InRestaurantTaxChargeOnly.ViewAttributes %>>
<%= BusinessDetails.InRestaurantTaxChargeOnly.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.InRestaurantTipChargeOnly.Visible Then ' InRestaurantTipChargeOnly %>
		<td data-name="InRestaurantTipChargeOnly"<%= BusinessDetails.InRestaurantTipChargeOnly.CellAttributes %>>
<span<%= BusinessDetails.InRestaurantTipChargeOnly.ViewAttributes %>>
<%= BusinessDetails.InRestaurantTipChargeOnly.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.isCheckCapcha.Visible Then ' isCheckCapcha %>
		<td data-name="isCheckCapcha"<%= BusinessDetails.isCheckCapcha.CellAttributes %>>
<span<%= BusinessDetails.isCheckCapcha.ViewAttributes %>>
<%= BusinessDetails.isCheckCapcha.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.Close_StartDate.Visible Then ' Close_StartDate %>
		<td data-name="Close_StartDate"<%= BusinessDetails.Close_StartDate.CellAttributes %>>
<span<%= BusinessDetails.Close_StartDate.ViewAttributes %>>
<%= BusinessDetails.Close_StartDate.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.Close_EndDate.Visible Then ' Close_EndDate %>
		<td data-name="Close_EndDate"<%= BusinessDetails.Close_EndDate.CellAttributes %>>
<span<%= BusinessDetails.Close_EndDate.ViewAttributes %>>
<%= BusinessDetails.Close_EndDate.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.Stripe_Country.Visible Then ' Stripe_Country %>
		<td data-name="Stripe_Country"<%= BusinessDetails.Stripe_Country.CellAttributes %>>
<span<%= BusinessDetails.Stripe_Country.ViewAttributes %>>
<%= BusinessDetails.Stripe_Country.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.enable_StripePaymentButton.Visible Then ' enable_StripePaymentButton %>
		<td data-name="enable_StripePaymentButton"<%= BusinessDetails.enable_StripePaymentButton.CellAttributes %>>
<span<%= BusinessDetails.enable_StripePaymentButton.ViewAttributes %>>
<%= BusinessDetails.enable_StripePaymentButton.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.enable_CashPayment.Visible Then ' enable_CashPayment %>
		<td data-name="enable_CashPayment"<%= BusinessDetails.enable_CashPayment.CellAttributes %>>
<span<%= BusinessDetails.enable_CashPayment.ViewAttributes %>>
<%= BusinessDetails.enable_CashPayment.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.DeliveryMile.Visible Then ' DeliveryMile %>
		<td data-name="DeliveryMile"<%= BusinessDetails.DeliveryMile.CellAttributes %>>
<span<%= BusinessDetails.DeliveryMile.ViewAttributes %>>
<%= BusinessDetails.DeliveryMile.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.Mon_Delivery.Visible Then ' Mon_Delivery %>
		<td data-name="Mon_Delivery"<%= BusinessDetails.Mon_Delivery.CellAttributes %>>
<span<%= BusinessDetails.Mon_Delivery.ViewAttributes %>>
<%= BusinessDetails.Mon_Delivery.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.Mon_Collection.Visible Then ' Mon_Collection %>
		<td data-name="Mon_Collection"<%= BusinessDetails.Mon_Collection.CellAttributes %>>
<span<%= BusinessDetails.Mon_Collection.ViewAttributes %>>
<%= BusinessDetails.Mon_Collection.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.Tue_Delivery.Visible Then ' Tue_Delivery %>
		<td data-name="Tue_Delivery"<%= BusinessDetails.Tue_Delivery.CellAttributes %>>
<span<%= BusinessDetails.Tue_Delivery.ViewAttributes %>>
<%= BusinessDetails.Tue_Delivery.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.Tue_Collection.Visible Then ' Tue_Collection %>
		<td data-name="Tue_Collection"<%= BusinessDetails.Tue_Collection.CellAttributes %>>
<span<%= BusinessDetails.Tue_Collection.ViewAttributes %>>
<%= BusinessDetails.Tue_Collection.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.Wed_Delivery.Visible Then ' Wed_Delivery %>
		<td data-name="Wed_Delivery"<%= BusinessDetails.Wed_Delivery.CellAttributes %>>
<span<%= BusinessDetails.Wed_Delivery.ViewAttributes %>>
<%= BusinessDetails.Wed_Delivery.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.Wed_Collection.Visible Then ' Wed_Collection %>
		<td data-name="Wed_Collection"<%= BusinessDetails.Wed_Collection.CellAttributes %>>
<span<%= BusinessDetails.Wed_Collection.ViewAttributes %>>
<%= BusinessDetails.Wed_Collection.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.Thu_Delivery.Visible Then ' Thu_Delivery %>
		<td data-name="Thu_Delivery"<%= BusinessDetails.Thu_Delivery.CellAttributes %>>
<span<%= BusinessDetails.Thu_Delivery.ViewAttributes %>>
<%= BusinessDetails.Thu_Delivery.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.Thu_Collection.Visible Then ' Thu_Collection %>
		<td data-name="Thu_Collection"<%= BusinessDetails.Thu_Collection.CellAttributes %>>
<span<%= BusinessDetails.Thu_Collection.ViewAttributes %>>
<%= BusinessDetails.Thu_Collection.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.Fri_Delivery.Visible Then ' Fri_Delivery %>
		<td data-name="Fri_Delivery"<%= BusinessDetails.Fri_Delivery.CellAttributes %>>
<span<%= BusinessDetails.Fri_Delivery.ViewAttributes %>>
<%= BusinessDetails.Fri_Delivery.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.Fri_Collection.Visible Then ' Fri_Collection %>
		<td data-name="Fri_Collection"<%= BusinessDetails.Fri_Collection.CellAttributes %>>
<span<%= BusinessDetails.Fri_Collection.ViewAttributes %>>
<%= BusinessDetails.Fri_Collection.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.Sat_Delivery.Visible Then ' Sat_Delivery %>
		<td data-name="Sat_Delivery"<%= BusinessDetails.Sat_Delivery.CellAttributes %>>
<span<%= BusinessDetails.Sat_Delivery.ViewAttributes %>>
<%= BusinessDetails.Sat_Delivery.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.Sat_Collection.Visible Then ' Sat_Collection %>
		<td data-name="Sat_Collection"<%= BusinessDetails.Sat_Collection.CellAttributes %>>
<span<%= BusinessDetails.Sat_Collection.ViewAttributes %>>
<%= BusinessDetails.Sat_Collection.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.Sun_Delivery.Visible Then ' Sun_Delivery %>
		<td data-name="Sun_Delivery"<%= BusinessDetails.Sun_Delivery.CellAttributes %>>
<span<%= BusinessDetails.Sun_Delivery.ViewAttributes %>>
<%= BusinessDetails.Sun_Delivery.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.Sun_Collection.Visible Then ' Sun_Collection %>
		<td data-name="Sun_Collection"<%= BusinessDetails.Sun_Collection.CellAttributes %>>
<span<%= BusinessDetails.Sun_Collection.ViewAttributes %>>
<%= BusinessDetails.Sun_Collection.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.EnableUrlRewrite.Visible Then ' EnableUrlRewrite %>
		<td data-name="EnableUrlRewrite"<%= BusinessDetails.EnableUrlRewrite.CellAttributes %>>
<span<%= BusinessDetails.EnableUrlRewrite.ViewAttributes %>>
<%= BusinessDetails.EnableUrlRewrite.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.DeliveryCostUpTo.Visible Then ' DeliveryCostUpTo %>
		<td data-name="DeliveryCostUpTo"<%= BusinessDetails.DeliveryCostUpTo.CellAttributes %>>
<span<%= BusinessDetails.DeliveryCostUpTo.ViewAttributes %>>
<%= BusinessDetails.DeliveryCostUpTo.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.DeliveryUptoMile.Visible Then ' DeliveryUptoMile %>
		<td data-name="DeliveryUptoMile"<%= BusinessDetails.DeliveryUptoMile.CellAttributes %>>
<span<%= BusinessDetails.DeliveryUptoMile.ViewAttributes %>>
<%= BusinessDetails.DeliveryUptoMile.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.Show_Ordernumner_printer.Visible Then ' Show_Ordernumner_printer %>
		<td data-name="Show_Ordernumner_printer"<%= BusinessDetails.Show_Ordernumner_printer.CellAttributes %>>
<span<%= BusinessDetails.Show_Ordernumner_printer.ViewAttributes %>>
<%= BusinessDetails.Show_Ordernumner_printer.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.Show_Ordernumner_Receipt.Visible Then ' Show_Ordernumner_Receipt %>
		<td data-name="Show_Ordernumner_Receipt"<%= BusinessDetails.Show_Ordernumner_Receipt.CellAttributes %>>
<span<%= BusinessDetails.Show_Ordernumner_Receipt.ViewAttributes %>>
<%= BusinessDetails.Show_Ordernumner_Receipt.ListViewValue %>
</span>
</td>
	<% End If %>
	<% If BusinessDetails.Show_Ordernumner_Dashboard.Visible Then ' Show_Ordernumner_Dashboard %>
		<td data-name="Show_Ordernumner_Dashboard"<%= BusinessDetails.Show_Ordernumner_Dashboard.CellAttributes %>>
<span<%= BusinessDetails.Show_Ordernumner_Dashboard.ViewAttributes %>>
<%= BusinessDetails.Show_Ordernumner_Dashboard.ListViewValue %>
</span>
</td>
	<% End If %>
<%

' Render list options (body, right)
BusinessDetails_list.ListOptions.Render "body", "right", BusinessDetails_list.RowCnt, "", "", ""
%>
	</tr>
<%
	End If
	If BusinessDetails.CurrentAction <> "gridadd" Then
		BusinessDetails_list.Recordset.MoveNext()
	End If
Loop
%>
</tbody>
</table>
<% End If %>
<% If BusinessDetails.CurrentAction = "" Then %>
<input type="hidden" name="a_list" id="a_list" value="">
<% End If %>
</div>
</form>
<%

' Close recordset and connection
BusinessDetails_list.Recordset.Close
Set BusinessDetails_list.Recordset = Nothing
%>
<% If BusinessDetails.Export = "" Then %>
<div class="ewGridLowerPanel">
<% If BusinessDetails.CurrentAction <> "gridadd" And BusinessDetails.CurrentAction <> "gridedit" Then %>
<form name="ewPagerForm" class="ewForm form-inline ewPagerForm" action="<%= ew_CurrentPage %>">
<% If Not IsObject(BusinessDetails_list.Pager) Then Set BusinessDetails_list.Pager = ew_NewPrevNextPager(BusinessDetails_list.StartRec, BusinessDetails_list.DisplayRecs, BusinessDetails_list.TotalRecs) %>
<% If BusinessDetails_list.Pager.RecordCount > 0 Then %>
<div class="ewPager">
<span><%= Language.Phrase("Page") %>&nbsp;</span>
<div class="ewPrevNext"><div class="input-group">
<div class="input-group-btn">
<!--first page button-->
	<% If BusinessDetails_list.Pager.FirstButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerFirst") %>" href="<%= BusinessDetails_list.PageUrl %>start=<%= BusinessDetails_list.Pager.FirstButton.Start %>"><span class="icon-first ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerFirst") %>"><span class="icon-first ewIcon"></span></a>
	<% End If %>
<!--previous page button-->
	<% If BusinessDetails_list.Pager.PrevButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerPrevious") %>" href="<%= BusinessDetails_list.PageUrl %>start=<%= BusinessDetails_list.Pager.PrevButton.Start %>"><span class="icon-prev ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerPrevious") %>"><span class="icon-prev ewIcon"></span></a>
	<% End If %>
</div>
<!--current page number-->
	<input class="form-control input-sm" type="text" name="<%= EW_TABLE_PAGE_NO %>" value="<%= BusinessDetails_list.Pager.CurrentPage %>">
<div class="input-group-btn">
<!--next page button-->
	<% If BusinessDetails_list.Pager.NextButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerNext") %>" href="<%= BusinessDetails_list.PageUrl %>start=<%= BusinessDetails_list.Pager.NextButton.Start %>"><span class="icon-next ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerNext") %>"><span class="icon-next ewIcon"></span></a>
	<% End If %>
<!--last page button-->
	<% If BusinessDetails_list.Pager.LastButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerLast") %>" href="<%= BusinessDetails_list.PageUrl %>start=<%= BusinessDetails_list.Pager.LastButton.Start %>"><span class="icon-last ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerLast") %>"><span class="icon-last ewIcon"></span></a>
	<% End If %>
</div>
</div>
</div>
<span>&nbsp;<%= Language.Phrase("of") %>&nbsp;<%= BusinessDetails_list.Pager.PageCount %></span>
</div>
<div class="ewPager ewRec">
	<span><%= Language.Phrase("Record") %>&nbsp;<%= BusinessDetails_list.Pager.FromIndex %>&nbsp;<%= Language.Phrase("To") %>&nbsp;<%= BusinessDetails_list.Pager.ToIndex %>&nbsp;<%= Language.Phrase("Of") %>&nbsp;<%= BusinessDetails_list.Pager.RecordCount %></span>
</div>
<% End If %>
<% If BusinessDetails_list.TotalRecs > 0 Then %>
<div class="ewPager">
<input type="hidden" name="t" value="BusinessDetails">
<select name="<%= EW_TABLE_REC_PER_PAGE %>" class="form-control input-sm" onchange="this.form.submit();">
<option value="20"<% If BusinessDetails_list.DisplayRecs = 20 Then %> selected="selected"<% End If %>>20</option>
<option value="50"<% If BusinessDetails_list.DisplayRecs = 50 Then %> selected="selected"<% End If %>>50</option>
<option value="100"<% If BusinessDetails_list.DisplayRecs = 100 Then %> selected="selected"<% End If %>>100</option>
<option value="500"<% If BusinessDetails_list.DisplayRecs = 500 Then %> selected="selected"<% End If %>>500</option>
<option value="1000"<% If BusinessDetails_list.DisplayRecs = 1000 Then %> selected="selected"<% End If %>>1000</option>
<option value="ALL"<% If BusinessDetails.RecordsPerPage = -1 Then %> selected="selected"<% End If %>><%= Language.Phrase("AllRecords") %></option>
</select>
</div>
<% End If %>
</form>
<% End If %>
<div class="ewListOtherOptions">
<%
	BusinessDetails_list.AddEditOptions.Render "body", "bottom", "", "", "", ""
	BusinessDetails_list.DetailOptions.Render "body", "bottom", "", "", "", ""
	BusinessDetails_list.ActionOptions.Render "body", "bottom", "", "", "", ""
%>
</div>
<div class="clearfix"></div>
</div>
<% End If %>
</div>
<% End If %>
<% If BusinessDetails_list.TotalRecs = 0 And BusinessDetails.CurrentAction = "" Then ' Show other options %>
<div class="ewListOtherOptions">
<%
	BusinessDetails_list.AddEditOptions.Render "body", "", "", "", "", ""
	BusinessDetails_list.DetailOptions.Render "body", "", "", "", "", ""
	BusinessDetails_list.ActionOptions.Render "body", "", "", "", "", ""
%>
</div>
<div class="clearfix"></div>
<% End If %>
<% If BusinessDetails.Export <> "" Then %>
<script type="text/javascript">
ew_ApplyTemplate("body", "", "BusinessDetailslist", "<%= BusinessDetails.CustomExport %>");
</script>
<% End If %>
<% If BusinessDetails.Export = "" Then %>
<script type="text/javascript">
fBusinessDetailslistsrch.Init();
fBusinessDetailslist.Init();
</script>
<% End If %>
<%
BusinessDetails_list.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<% If BusinessDetails.Export = "" Then %>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<% End If %>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set BusinessDetails_list = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cBusinessDetails_list

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
		TableName = "BusinessDetails"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "BusinessDetails_list"
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
		If BusinessDetails.UseTokenInUrl Then PageUrl = PageUrl & "t=" & BusinessDetails.TableVar & "&" ' add page token
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
		If BusinessDetails.UseTokenInUrl Then
			IsPageRequest = False
			If Not (ObjForm Is Nothing) Then
				IsPageRequest = (BusinessDetails.TableVar = ObjForm.GetValue("t"))
			End If
			If Request.QueryString("t").Count > 0 Then
				IsPageRequest = (BusinessDetails.TableVar = Request.QueryString("t"))
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
		FormName = "fBusinessDetailslist"
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
		If IsEmpty(BusinessDetails) Then Set BusinessDetails = New cBusinessDetails
		Set Table = BusinessDetails
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
		AddUrl = "BusinessDetailsadd.asp"
		InlineAddUrl = PageUrl & "a=add"
		GridAddUrl = PageUrl & "a=gridadd"
		GridEditUrl = PageUrl & "a=gridedit"
		MultiDeleteUrl = "BusinessDetailsdelete.asp"
		MultiUpdateUrl = "BusinessDetailsupdate.asp"

		' Initialize form object
		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "list"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "BusinessDetails"

		' Open connection to the database
		If IsEmpty(Conn) Then Call ew_Connect()

		' List options
		Set ListOptions = New cListOptions
		ListOptions.TableVar = BusinessDetails.TableVar

		' Export options
		Set ExportOptions = New cListOptions
		ExportOptions.TableVar = BusinessDetails.TableVar
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
			BusinessDetails.Export = Request.QueryString("export")
			custom = Request.QueryString("custom") & ""
		ElseIf ew_IsHttpPost() Then
			If Request.Form("export").Count > 0 Then
				BusinessDetails.Export = Request.Form("export")
				custom = Request.Form("custom") & ""
			ElseIf Request.Form("exporttype").Count > 0 Then
				BusinessDetails.Export = Request.Form("exporttype")
				custom = Request.Form("custom") & ""
			End If
		Else
			BusinessDetails.ExportReturnUrl = ew_CurrentUrl()
		End If
		gsExportFile = BusinessDetails.TableVar ' Get export file, used in header
		Dim Charset ' Charset used in header
		If EW_CHARSET <> "" Then
			Charset = ";charset=" & EW_CHARSET
		Else
			Charset = ""
		End If

		' Get custom export parameters
		If BusinessDetails.Export <> "" And custom <> "" Then
			BusinessDetails.CustomExport = BusinessDetails.Export
			BusinessDetails.Export = "print"
		End If
		gsCustomExport = BusinessDetails.CustomExport
		gsExport = BusinessDetails.Export ' Get export parameter, used in header

		' Custom export (post back from ew_ApplyTemplate), export and terminate page
		If Request.Form("customexport").Count > 0 Then
			BusinessDetails.CustomExport = Request.Form("customexport")
			BusinessDetails.Export = BusinessDetails.CustomExport
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
		If BusinessDetails.Export = "excel" Then
			Response.ContentType = "application/vnd.ms-excel" & Charset
			Response.AddHeader "Content-Disposition", "attachment; filename=" & gsExportFile & ".xls"
		End If
		If BusinessDetails.Export = "word" Then
			Response.ContentType = "application/vnd.ms-word" & Charset
			Response.AddHeader "Content-Disposition", "attachment; filename=" & gsExportFile & ".doc"
		End If
		If BusinessDetails.Export = "csv" Then
			Response.BinaryWrite ChrB(239) & ChrB(187) & ChrB(191)
			Response.ContentType = "application/csv" & Charset
			Response.AddHeader "Content-Disposition", "attachment; filename=" & gsExportFile & ".csv"
		End If

		' Get grid add count
		Dim gridaddcnt
		gridaddcnt = Request.QueryString(EW_TABLE_GRID_ADD_ROW_COUNT)
		If IsNumeric(gridaddcnt) Then
			If gridaddcnt > 0 Then
				BusinessDetails.GridAddRowCount = gridaddcnt
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
			results = BusinessDetails.GetAutoFill(Request.Form("name"), Request.Form("q"))
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
		If UBound(BusinessDetails.CustomActions.CustomArray) >= 0 Then
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
		If Not BusinessDetails Is Nothing Then
			If BusinessDetails.Export <> "" And Request.Form("data").Count > 0 Then
				Dim sContent
				sContent = Request.Form("data")
				gsExportFile = Request.Form("filename")
				If gsExportFile = "" Then gsExportFile = BusinessDetails.TableVar
				If BusinessDetails.Export = "pdf" Then
					Call ExportPdf(sContent)
				ElseIf BusinessDetails.Export = "email" Then
					Response.Write ExportEmail(sContent)
				ElseIf BusinessDetails.Export = "excel" Then
					Call ExportExcel(sContent)
				ElseIf BusinessDetails.Export = "word" Then
					Call ExportWord(sContent)
				End If
			End If
		End If
		Dim sRedirectUrl
		sReDirectUrl = url
		Call Page_Redirecting(sReDirectUrl)
		If Not (Conn Is Nothing) Then Conn.Close ' Close Connection
		Set Conn = Nothing
		Set BusinessDetails = Nothing
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
			If BusinessDetails.Export = "" Then
				SetupBreadcrumb()
			End If

			' Hide list options
			If BusinessDetails.Export <> "" Then
				Call ListOptions.HideAllOptions(Array("sequence"))
				ListOptions.UseDropDownButton = False ' Disable drop down button
				ListOptions.UseButtonGroup = False ' Disable button group
			ElseIf BusinessDetails.CurrentAction = "gridadd" Or BusinessDetails.CurrentAction = "gridedit" Then
				Call ListOptions.HideAllOptions(Array())
				ListOptions.UseDropDownButton = False ' Disable drop down button
				ListOptions.UseButtonGroup = False ' Disable button group
			End If

			' Hide export options
			If BusinessDetails.Export <> "" Or BusinessDetails.CurrentAction <> "" Then
				ExportOptions.HideAllOptions(Array())
			End If

			' Hide other options
			If BusinessDetails.Export <> "" Then
				AddEditOptions.HideAllOptions(Array())
				DetailOptions.HideAllOptions(Array())
				ActionOptions.HideAllOptions(Array())
			End If

			' Get default search criteria
			Call ew_AddFilter(DefaultSearchWhere, BasicSearchWhere(True))

			' Get basic search values
			Call LoadBasicSearchValues()

			' Restore search parms from Session if not searching / reset / export
			If (BusinessDetails.Export <> "" Or Command <> "search" And Command <> "reset" And Command <> "resetall") And CheckSearchParms() Then
				Call RestoreSearchParms()
			End If

			' Call Recordset SearchValidated event
			Call BusinessDetails.Recordset_SearchValidated()

			' Set Up Sorting Order
			SetUpSortOrder()

			' Get basic search criteria
			If gsSearchError = "" Then
				sSrchBasic = BasicSearchWhere(False)
			End If
		End If ' End Validate Request

		' Restore display records
		If BusinessDetails.RecordsPerPage <> "" Then
			DisplayRecs = BusinessDetails.RecordsPerPage ' Restore from Session
		Else
			DisplayRecs = 20 ' Load default
		End If

		' Load Sorting Order
		LoadSortOrder()

		' Load search default if no existing search criteria
		If Not CheckSearchParms() Then

			' Load basic search from default
			BusinessDetails.BasicSearch.Keyword = BusinessDetails.BasicSearch.KeywordDefault
			BusinessDetails.BasicSearch.SearchType = BusinessDetails.BasicSearch.SearchTypeDefault
			BusinessDetails.BasicSearch.setSearchType(BusinessDetails.BasicSearch.SearchTypeDefault)
			If BusinessDetails.BasicSearch.Keyword <> "" Then
				sSrchBasic = BasicSearchWhere(False)
			End If
		End If

		' Build search criteria
		Call ew_AddFilter(SearchWhere, sSrchAdvanced)
		Call ew_AddFilter(SearchWhere, sSrchBasic)

		' Call Recordset Searching event
		Call BusinessDetails.Recordset_Searching(SearchWhere)

		' Save search criteria
		If Command = "search" And Not RestoreSearch Then
			BusinessDetails.SearchWhere = SearchWhere ' Save to Session
			StartRec = 1 ' Reset start record counter
			BusinessDetails.StartRecordNumber = StartRec
		Else
			SearchWhere = BusinessDetails.SearchWhere
		End If
		sFilter = ""
		Call ew_AddFilter(sFilter, DbDetailFilter)
		Call ew_AddFilter(sFilter, SearchWhere)

		' Set up filter in Session
		BusinessDetails.SessionWhere = sFilter
		BusinessDetails.CurrentFilter = ""

		' Export Data only
		If BusinessDetails.CustomExport = "" And ew_InArray(BusinessDetails.Export, Array("html","word","excel","xml","csv","email","pdf")) Then
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
			BusinessDetails.RecordsPerPage = DisplayRecs ' Save to Session

			' Reset start position
			StartRec = 1
			BusinessDetails.StartRecordNumber = StartRec
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
				sFilter = BusinessDetails.KeyFilter
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
			BusinessDetails.ID.FormValue = arrKeyFlds(0)
			If Not IsNumeric(BusinessDetails.ID.FormValue) Then
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
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.Name, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.Address, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.PostalCode, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.FoodType, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.ImgUrl, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.Telephone, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.zEmail, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.pswd, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.announcement, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.css, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.SMTP_AUTENTICATE, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.MAIL_FROM, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.PAYPAL_URL, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.PAYPAL_PDT, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.SMTP_PASSWORD, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.GMAP_API_KEY, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.SMTP_USERNAME, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.SMTP_USESSL, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.MAIL_SUBJECT, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.CURRENCYSYMBOL, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.SMTP_SERVER, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.CREDITCARDSURCHARGE, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.SMTP_PORT, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.STICK_MENU, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.MAIL_CUSTOMER_SUBJECT, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.CONFIRMATION_EMAIL_ADDRESS, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.SEND_ORDERS_TO_PRINTER, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.PAYPAL_ADDR, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.nochex, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.nochexmerchantid, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.paypal, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.IBT_API_KEY, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.IBP_API_PASSWORD, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.disable_delivery, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.disable_collection, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.worldpay, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.worldpaymerchantid, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.backtohometext, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.closedtext, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.DeliveryChargeOverrideByOrderValue, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.individualpostcodes, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.longitude, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.latitude, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.googleecommercetracking, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.googleecommercetrackingcode, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.bringg, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.bringgurl, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.bringgcompanyid, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.menupagetext, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.mileskm, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.worldpayinstallationid, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.DistanceCalMethod, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.PrinterIDList, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.EpsonJSPrinterURL, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.SMSSupplierDomain, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.SMSOnOrderContent, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.DefaultSMSCountryCode, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.FavIconUrl, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.AddToHomeScreenURL, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.LocalPrinterURL, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.InRestaurantEpsonPrinterIDList, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.BlockIPEmailList, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.inmenuannouncement, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.RePrintReceiptWays, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.printingtype, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.Stripe_Key_Secret, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.Stripe, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.Stripe_Api_Key, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.EnableBooking, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.URL_Facebook, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.URL_Twitter, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.URL_Google, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.URL_Intagram, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.URL_YouTube, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.URL_Tripadvisor, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.URL_Special_Offer, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.URL_Linkin, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.Currency_PAYPAL, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.Currency_STRIPE, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.Currency_WOLRDPAY, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.isCheckCapcha, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.Close_StartDate, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.Close_EndDate, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.Stripe_Country, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.enable_StripePaymentButton, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.enable_CashPayment, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.EnableUrlRewrite, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.Show_Ordernumner_printer, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.Show_Ordernumner_Receipt, arKeywords, typ)
			Call BuildBasicSearchSQL(sWhere, BusinessDetails.Show_Ordernumner_Dashboard, arKeywords, typ)
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
		sSearchKeyword = ew_IIf(Default, BusinessDetails.BasicSearch.KeywordDefault, BusinessDetails.BasicSearch.Keyword)
		sSearchType = ew_IIf(Default, BusinessDetails.BasicSearch.SearchTypeDefault, BusinessDetails.BasicSearch.SearchType)
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
			BusinessDetails.BasicSearch.setKeyword(sSearchKeyword)
			BusinessDetails.BasicSearch.setSearchType(sSearchType)
		End If
		BasicSearchWhere = sSearchStr
	End Function

	' Check if search parm exists
	Function CheckSearchParms()

		' Check basic search
		If BusinessDetails.BasicSearch.IssetSession() Then
			CheckSearchParms = True
			Exit Function
		End If
		CheckSearchParms = False
	End Function

	' Clear all search parameters
	Sub ResetSearchParms()

		' Clear search where
		SearchWhere = ""
		BusinessDetails.SearchWhere = SearchWhere

		' Clear basic search parameters
		Call ResetBasicSearchParms()
	End Sub

	' Load advanced search default values
	Function LoadAdvancedSearchDefault()
		LoadAdvancedSearchDefault = False
	End Function

	' Clear all basic search parameters
	Sub ResetBasicSearchParms()
		BusinessDetails.BasicSearch.UnsetSession()
	End Sub

	' -----------------------------------------------------------------
	' Restore all search parameters
	'
	Sub RestoreSearchParms()

		' Restore search flag
		RestoreSearch = True

		' Restore basic search values
		Call BusinessDetails.BasicSearch.Load()
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
			BusinessDetails.CurrentOrder = Request.QueryString("order")
			BusinessDetails.CurrentOrderType = Request.QueryString("ordertype")

			' Field ID
			Call BusinessDetails.UpdateSort(BusinessDetails.ID)

			' Field Name
			Call BusinessDetails.UpdateSort(BusinessDetails.Name)

			' Field Address
			Call BusinessDetails.UpdateSort(BusinessDetails.Address)

			' Field PostalCode
			Call BusinessDetails.UpdateSort(BusinessDetails.PostalCode)

			' Field FoodType
			Call BusinessDetails.UpdateSort(BusinessDetails.FoodType)

			' Field DeliveryMinAmount
			Call BusinessDetails.UpdateSort(BusinessDetails.DeliveryMinAmount)

			' Field DeliveryMaxDistance
			Call BusinessDetails.UpdateSort(BusinessDetails.DeliveryMaxDistance)

			' Field DeliveryFreeDistance
			Call BusinessDetails.UpdateSort(BusinessDetails.DeliveryFreeDistance)

			' Field AverageDeliveryTime
			Call BusinessDetails.UpdateSort(BusinessDetails.AverageDeliveryTime)

			' Field AverageCollectionTime
			Call BusinessDetails.UpdateSort(BusinessDetails.AverageCollectionTime)

			' Field DeliveryFee
			Call BusinessDetails.UpdateSort(BusinessDetails.DeliveryFee)

			' Field ImgUrl
			Call BusinessDetails.UpdateSort(BusinessDetails.ImgUrl)

			' Field Telephone
			Call BusinessDetails.UpdateSort(BusinessDetails.Telephone)

			' Field Email
			Call BusinessDetails.UpdateSort(BusinessDetails.zEmail)

			' Field pswd
			Call BusinessDetails.UpdateSort(BusinessDetails.pswd)

			' Field businessclosed
			Call BusinessDetails.UpdateSort(BusinessDetails.businessclosed)

			' Field SMTP_AUTENTICATE
			Call BusinessDetails.UpdateSort(BusinessDetails.SMTP_AUTENTICATE)

			' Field MAIL_FROM
			Call BusinessDetails.UpdateSort(BusinessDetails.MAIL_FROM)

			' Field PAYPAL_URL
			Call BusinessDetails.UpdateSort(BusinessDetails.PAYPAL_URL)

			' Field PAYPAL_PDT
			Call BusinessDetails.UpdateSort(BusinessDetails.PAYPAL_PDT)

			' Field SMTP_PASSWORD
			Call BusinessDetails.UpdateSort(BusinessDetails.SMTP_PASSWORD)

			' Field GMAP_API_KEY
			Call BusinessDetails.UpdateSort(BusinessDetails.GMAP_API_KEY)

			' Field SMTP_USERNAME
			Call BusinessDetails.UpdateSort(BusinessDetails.SMTP_USERNAME)

			' Field SMTP_USESSL
			Call BusinessDetails.UpdateSort(BusinessDetails.SMTP_USESSL)

			' Field MAIL_SUBJECT
			Call BusinessDetails.UpdateSort(BusinessDetails.MAIL_SUBJECT)

			' Field CURRENCYSYMBOL
			Call BusinessDetails.UpdateSort(BusinessDetails.CURRENCYSYMBOL)

			' Field SMTP_SERVER
			Call BusinessDetails.UpdateSort(BusinessDetails.SMTP_SERVER)

			' Field CREDITCARDSURCHARGE
			Call BusinessDetails.UpdateSort(BusinessDetails.CREDITCARDSURCHARGE)

			' Field SMTP_PORT
			Call BusinessDetails.UpdateSort(BusinessDetails.SMTP_PORT)

			' Field STICK_MENU
			Call BusinessDetails.UpdateSort(BusinessDetails.STICK_MENU)

			' Field MAIL_CUSTOMER_SUBJECT
			Call BusinessDetails.UpdateSort(BusinessDetails.MAIL_CUSTOMER_SUBJECT)

			' Field CONFIRMATION_EMAIL_ADDRESS
			Call BusinessDetails.UpdateSort(BusinessDetails.CONFIRMATION_EMAIL_ADDRESS)

			' Field SEND_ORDERS_TO_PRINTER
			Call BusinessDetails.UpdateSort(BusinessDetails.SEND_ORDERS_TO_PRINTER)

			' Field timezone
			Call BusinessDetails.UpdateSort(BusinessDetails.timezone)

			' Field PAYPAL_ADDR
			Call BusinessDetails.UpdateSort(BusinessDetails.PAYPAL_ADDR)

			' Field nochex
			Call BusinessDetails.UpdateSort(BusinessDetails.nochex)

			' Field nochexmerchantid
			Call BusinessDetails.UpdateSort(BusinessDetails.nochexmerchantid)

			' Field paypal
			Call BusinessDetails.UpdateSort(BusinessDetails.paypal)

			' Field IBT_API_KEY
			Call BusinessDetails.UpdateSort(BusinessDetails.IBT_API_KEY)

			' Field IBP_API_PASSWORD
			Call BusinessDetails.UpdateSort(BusinessDetails.IBP_API_PASSWORD)

			' Field disable_delivery
			Call BusinessDetails.UpdateSort(BusinessDetails.disable_delivery)

			' Field disable_collection
			Call BusinessDetails.UpdateSort(BusinessDetails.disable_collection)

			' Field worldpay
			Call BusinessDetails.UpdateSort(BusinessDetails.worldpay)

			' Field worldpaymerchantid
			Call BusinessDetails.UpdateSort(BusinessDetails.worldpaymerchantid)

			' Field DeliveryChargeOverrideByOrderValue
			Call BusinessDetails.UpdateSort(BusinessDetails.DeliveryChargeOverrideByOrderValue)

			' Field individualpostcodeschecking
			Call BusinessDetails.UpdateSort(BusinessDetails.individualpostcodeschecking)

			' Field longitude
			Call BusinessDetails.UpdateSort(BusinessDetails.longitude)

			' Field latitude
			Call BusinessDetails.UpdateSort(BusinessDetails.latitude)

			' Field googleecommercetracking
			Call BusinessDetails.UpdateSort(BusinessDetails.googleecommercetracking)

			' Field googleecommercetrackingcode
			Call BusinessDetails.UpdateSort(BusinessDetails.googleecommercetrackingcode)

			' Field bringg
			Call BusinessDetails.UpdateSort(BusinessDetails.bringg)

			' Field bringgurl
			Call BusinessDetails.UpdateSort(BusinessDetails.bringgurl)

			' Field bringgcompanyid
			Call BusinessDetails.UpdateSort(BusinessDetails.bringgcompanyid)

			' Field orderonlywhenopen
			Call BusinessDetails.UpdateSort(BusinessDetails.orderonlywhenopen)

			' Field disablelaterdelivery
			Call BusinessDetails.UpdateSort(BusinessDetails.disablelaterdelivery)

			' Field ordertodayonly
			Call BusinessDetails.UpdateSort(BusinessDetails.ordertodayonly)

			' Field mileskm
			Call BusinessDetails.UpdateSort(BusinessDetails.mileskm)

			' Field worldpaylive
			Call BusinessDetails.UpdateSort(BusinessDetails.worldpaylive)

			' Field worldpayinstallationid
			Call BusinessDetails.UpdateSort(BusinessDetails.worldpayinstallationid)

			' Field DistanceCalMethod
			Call BusinessDetails.UpdateSort(BusinessDetails.DistanceCalMethod)

			' Field PrinterIDList
			Call BusinessDetails.UpdateSort(BusinessDetails.PrinterIDList)

			' Field EpsonJSPrinterURL
			Call BusinessDetails.UpdateSort(BusinessDetails.EpsonJSPrinterURL)

			' Field SMSEnable
			Call BusinessDetails.UpdateSort(BusinessDetails.SMSEnable)

			' Field SMSOnDelivery
			Call BusinessDetails.UpdateSort(BusinessDetails.SMSOnDelivery)

			' Field SMSSupplierDomain
			Call BusinessDetails.UpdateSort(BusinessDetails.SMSSupplierDomain)

			' Field SMSOnOrder
			Call BusinessDetails.UpdateSort(BusinessDetails.SMSOnOrder)

			' Field SMSOnOrderAfterMin
			Call BusinessDetails.UpdateSort(BusinessDetails.SMSOnOrderAfterMin)

			' Field SMSOnOrderContent
			Call BusinessDetails.UpdateSort(BusinessDetails.SMSOnOrderContent)

			' Field DefaultSMSCountryCode
			Call BusinessDetails.UpdateSort(BusinessDetails.DefaultSMSCountryCode)

			' Field MinimumAmountForCardPayment
			Call BusinessDetails.UpdateSort(BusinessDetails.MinimumAmountForCardPayment)

			' Field FavIconUrl
			Call BusinessDetails.UpdateSort(BusinessDetails.FavIconUrl)

			' Field AddToHomeScreenURL
			Call BusinessDetails.UpdateSort(BusinessDetails.AddToHomeScreenURL)

			' Field SMSOnAcknowledgement
			Call BusinessDetails.UpdateSort(BusinessDetails.SMSOnAcknowledgement)

			' Field LocalPrinterURL
			Call BusinessDetails.UpdateSort(BusinessDetails.LocalPrinterURL)

			' Field ShowRestaurantDetailOnReceipt
			Call BusinessDetails.UpdateSort(BusinessDetails.ShowRestaurantDetailOnReceipt)

			' Field PrinterFontSizeRatio
			Call BusinessDetails.UpdateSort(BusinessDetails.PrinterFontSizeRatio)

			' Field ServiceChargePercentage
			Call BusinessDetails.UpdateSort(BusinessDetails.ServiceChargePercentage)

			' Field InRestaurantServiceChargeOnly
			Call BusinessDetails.UpdateSort(BusinessDetails.InRestaurantServiceChargeOnly)

			' Field IsDualReceiptPrinting
			Call BusinessDetails.UpdateSort(BusinessDetails.IsDualReceiptPrinting)

			' Field PrintingFontSize
			Call BusinessDetails.UpdateSort(BusinessDetails.PrintingFontSize)

			' Field InRestaurantEpsonPrinterIDList
			Call BusinessDetails.UpdateSort(BusinessDetails.InRestaurantEpsonPrinterIDList)

			' Field BlockIPEmailList
			Call BusinessDetails.UpdateSort(BusinessDetails.BlockIPEmailList)

			' Field RePrintReceiptWays
			Call BusinessDetails.UpdateSort(BusinessDetails.RePrintReceiptWays)

			' Field printingtype
			Call BusinessDetails.UpdateSort(BusinessDetails.printingtype)

			' Field Stripe_Key_Secret
			Call BusinessDetails.UpdateSort(BusinessDetails.Stripe_Key_Secret)

			' Field Stripe
			Call BusinessDetails.UpdateSort(BusinessDetails.Stripe)

			' Field Stripe_Api_Key
			Call BusinessDetails.UpdateSort(BusinessDetails.Stripe_Api_Key)

			' Field EnableBooking
			Call BusinessDetails.UpdateSort(BusinessDetails.EnableBooking)

			' Field URL_Facebook
			Call BusinessDetails.UpdateSort(BusinessDetails.URL_Facebook)

			' Field URL_Twitter
			Call BusinessDetails.UpdateSort(BusinessDetails.URL_Twitter)

			' Field URL_Google
			Call BusinessDetails.UpdateSort(BusinessDetails.URL_Google)

			' Field URL_Intagram
			Call BusinessDetails.UpdateSort(BusinessDetails.URL_Intagram)

			' Field URL_YouTube
			Call BusinessDetails.UpdateSort(BusinessDetails.URL_YouTube)

			' Field URL_Tripadvisor
			Call BusinessDetails.UpdateSort(BusinessDetails.URL_Tripadvisor)

			' Field URL_Special_Offer
			Call BusinessDetails.UpdateSort(BusinessDetails.URL_Special_Offer)

			' Field URL_Linkin
			Call BusinessDetails.UpdateSort(BusinessDetails.URL_Linkin)

			' Field Currency_PAYPAL
			Call BusinessDetails.UpdateSort(BusinessDetails.Currency_PAYPAL)

			' Field Currency_STRIPE
			Call BusinessDetails.UpdateSort(BusinessDetails.Currency_STRIPE)

			' Field Currency_WOLRDPAY
			Call BusinessDetails.UpdateSort(BusinessDetails.Currency_WOLRDPAY)

			' Field Tip_percent
			Call BusinessDetails.UpdateSort(BusinessDetails.Tip_percent)

			' Field Tax_Percent
			Call BusinessDetails.UpdateSort(BusinessDetails.Tax_Percent)

			' Field InRestaurantTaxChargeOnly
			Call BusinessDetails.UpdateSort(BusinessDetails.InRestaurantTaxChargeOnly)

			' Field InRestaurantTipChargeOnly
			Call BusinessDetails.UpdateSort(BusinessDetails.InRestaurantTipChargeOnly)

			' Field isCheckCapcha
			Call BusinessDetails.UpdateSort(BusinessDetails.isCheckCapcha)

			' Field Close_StartDate
			Call BusinessDetails.UpdateSort(BusinessDetails.Close_StartDate)

			' Field Close_EndDate
			Call BusinessDetails.UpdateSort(BusinessDetails.Close_EndDate)

			' Field Stripe_Country
			Call BusinessDetails.UpdateSort(BusinessDetails.Stripe_Country)

			' Field enable_StripePaymentButton
			Call BusinessDetails.UpdateSort(BusinessDetails.enable_StripePaymentButton)

			' Field enable_CashPayment
			Call BusinessDetails.UpdateSort(BusinessDetails.enable_CashPayment)

			' Field DeliveryMile
			Call BusinessDetails.UpdateSort(BusinessDetails.DeliveryMile)

			' Field Mon_Delivery
			Call BusinessDetails.UpdateSort(BusinessDetails.Mon_Delivery)

			' Field Mon_Collection
			Call BusinessDetails.UpdateSort(BusinessDetails.Mon_Collection)

			' Field Tue_Delivery
			Call BusinessDetails.UpdateSort(BusinessDetails.Tue_Delivery)

			' Field Tue_Collection
			Call BusinessDetails.UpdateSort(BusinessDetails.Tue_Collection)

			' Field Wed_Delivery
			Call BusinessDetails.UpdateSort(BusinessDetails.Wed_Delivery)

			' Field Wed_Collection
			Call BusinessDetails.UpdateSort(BusinessDetails.Wed_Collection)

			' Field Thu_Delivery
			Call BusinessDetails.UpdateSort(BusinessDetails.Thu_Delivery)

			' Field Thu_Collection
			Call BusinessDetails.UpdateSort(BusinessDetails.Thu_Collection)

			' Field Fri_Delivery
			Call BusinessDetails.UpdateSort(BusinessDetails.Fri_Delivery)

			' Field Fri_Collection
			Call BusinessDetails.UpdateSort(BusinessDetails.Fri_Collection)

			' Field Sat_Delivery
			Call BusinessDetails.UpdateSort(BusinessDetails.Sat_Delivery)

			' Field Sat_Collection
			Call BusinessDetails.UpdateSort(BusinessDetails.Sat_Collection)

			' Field Sun_Delivery
			Call BusinessDetails.UpdateSort(BusinessDetails.Sun_Delivery)

			' Field Sun_Collection
			Call BusinessDetails.UpdateSort(BusinessDetails.Sun_Collection)

			' Field EnableUrlRewrite
			Call BusinessDetails.UpdateSort(BusinessDetails.EnableUrlRewrite)

			' Field DeliveryCostUpTo
			Call BusinessDetails.UpdateSort(BusinessDetails.DeliveryCostUpTo)

			' Field DeliveryUptoMile
			Call BusinessDetails.UpdateSort(BusinessDetails.DeliveryUptoMile)

			' Field Show_Ordernumner_printer
			Call BusinessDetails.UpdateSort(BusinessDetails.Show_Ordernumner_printer)

			' Field Show_Ordernumner_Receipt
			Call BusinessDetails.UpdateSort(BusinessDetails.Show_Ordernumner_Receipt)

			' Field Show_Ordernumner_Dashboard
			Call BusinessDetails.UpdateSort(BusinessDetails.Show_Ordernumner_Dashboard)
			BusinessDetails.StartRecordNumber = 1 ' Reset start position
		End If
	End Sub

	' -----------------------------------------------------------------
	' Load Sort Order parameters
	'
	Sub LoadSortOrder()
		Dim sOrderBy
		sOrderBy = BusinessDetails.SessionOrderBy ' Get order by from Session
		If sOrderBy = "" Then
			If BusinessDetails.SqlOrderBy <> "" Then
				sOrderBy = BusinessDetails.SqlOrderBy
				BusinessDetails.SessionOrderBy = sOrderBy
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
				BusinessDetails.SessionOrderBy = sOrderBy
				BusinessDetails.ID.Sort = ""
				BusinessDetails.Name.Sort = ""
				BusinessDetails.Address.Sort = ""
				BusinessDetails.PostalCode.Sort = ""
				BusinessDetails.FoodType.Sort = ""
				BusinessDetails.DeliveryMinAmount.Sort = ""
				BusinessDetails.DeliveryMaxDistance.Sort = ""
				BusinessDetails.DeliveryFreeDistance.Sort = ""
				BusinessDetails.AverageDeliveryTime.Sort = ""
				BusinessDetails.AverageCollectionTime.Sort = ""
				BusinessDetails.DeliveryFee.Sort = ""
				BusinessDetails.ImgUrl.Sort = ""
				BusinessDetails.Telephone.Sort = ""
				BusinessDetails.zEmail.Sort = ""
				BusinessDetails.pswd.Sort = ""
				BusinessDetails.businessclosed.Sort = ""
				BusinessDetails.SMTP_AUTENTICATE.Sort = ""
				BusinessDetails.MAIL_FROM.Sort = ""
				BusinessDetails.PAYPAL_URL.Sort = ""
				BusinessDetails.PAYPAL_PDT.Sort = ""
				BusinessDetails.SMTP_PASSWORD.Sort = ""
				BusinessDetails.GMAP_API_KEY.Sort = ""
				BusinessDetails.SMTP_USERNAME.Sort = ""
				BusinessDetails.SMTP_USESSL.Sort = ""
				BusinessDetails.MAIL_SUBJECT.Sort = ""
				BusinessDetails.CURRENCYSYMBOL.Sort = ""
				BusinessDetails.SMTP_SERVER.Sort = ""
				BusinessDetails.CREDITCARDSURCHARGE.Sort = ""
				BusinessDetails.SMTP_PORT.Sort = ""
				BusinessDetails.STICK_MENU.Sort = ""
				BusinessDetails.MAIL_CUSTOMER_SUBJECT.Sort = ""
				BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.Sort = ""
				BusinessDetails.SEND_ORDERS_TO_PRINTER.Sort = ""
				BusinessDetails.timezone.Sort = ""
				BusinessDetails.PAYPAL_ADDR.Sort = ""
				BusinessDetails.nochex.Sort = ""
				BusinessDetails.nochexmerchantid.Sort = ""
				BusinessDetails.paypal.Sort = ""
				BusinessDetails.IBT_API_KEY.Sort = ""
				BusinessDetails.IBP_API_PASSWORD.Sort = ""
				BusinessDetails.disable_delivery.Sort = ""
				BusinessDetails.disable_collection.Sort = ""
				BusinessDetails.worldpay.Sort = ""
				BusinessDetails.worldpaymerchantid.Sort = ""
				BusinessDetails.DeliveryChargeOverrideByOrderValue.Sort = ""
				BusinessDetails.individualpostcodeschecking.Sort = ""
				BusinessDetails.longitude.Sort = ""
				BusinessDetails.latitude.Sort = ""
				BusinessDetails.googleecommercetracking.Sort = ""
				BusinessDetails.googleecommercetrackingcode.Sort = ""
				BusinessDetails.bringg.Sort = ""
				BusinessDetails.bringgurl.Sort = ""
				BusinessDetails.bringgcompanyid.Sort = ""
				BusinessDetails.orderonlywhenopen.Sort = ""
				BusinessDetails.disablelaterdelivery.Sort = ""
				BusinessDetails.ordertodayonly.Sort = ""
				BusinessDetails.mileskm.Sort = ""
				BusinessDetails.worldpaylive.Sort = ""
				BusinessDetails.worldpayinstallationid.Sort = ""
				BusinessDetails.DistanceCalMethod.Sort = ""
				BusinessDetails.PrinterIDList.Sort = ""
				BusinessDetails.EpsonJSPrinterURL.Sort = ""
				BusinessDetails.SMSEnable.Sort = ""
				BusinessDetails.SMSOnDelivery.Sort = ""
				BusinessDetails.SMSSupplierDomain.Sort = ""
				BusinessDetails.SMSOnOrder.Sort = ""
				BusinessDetails.SMSOnOrderAfterMin.Sort = ""
				BusinessDetails.SMSOnOrderContent.Sort = ""
				BusinessDetails.DefaultSMSCountryCode.Sort = ""
				BusinessDetails.MinimumAmountForCardPayment.Sort = ""
				BusinessDetails.FavIconUrl.Sort = ""
				BusinessDetails.AddToHomeScreenURL.Sort = ""
				BusinessDetails.SMSOnAcknowledgement.Sort = ""
				BusinessDetails.LocalPrinterURL.Sort = ""
				BusinessDetails.ShowRestaurantDetailOnReceipt.Sort = ""
				BusinessDetails.PrinterFontSizeRatio.Sort = ""
				BusinessDetails.ServiceChargePercentage.Sort = ""
				BusinessDetails.InRestaurantServiceChargeOnly.Sort = ""
				BusinessDetails.IsDualReceiptPrinting.Sort = ""
				BusinessDetails.PrintingFontSize.Sort = ""
				BusinessDetails.InRestaurantEpsonPrinterIDList.Sort = ""
				BusinessDetails.BlockIPEmailList.Sort = ""
				BusinessDetails.RePrintReceiptWays.Sort = ""
				BusinessDetails.printingtype.Sort = ""
				BusinessDetails.Stripe_Key_Secret.Sort = ""
				BusinessDetails.Stripe.Sort = ""
				BusinessDetails.Stripe_Api_Key.Sort = ""
				BusinessDetails.EnableBooking.Sort = ""
				BusinessDetails.URL_Facebook.Sort = ""
				BusinessDetails.URL_Twitter.Sort = ""
				BusinessDetails.URL_Google.Sort = ""
				BusinessDetails.URL_Intagram.Sort = ""
				BusinessDetails.URL_YouTube.Sort = ""
				BusinessDetails.URL_Tripadvisor.Sort = ""
				BusinessDetails.URL_Special_Offer.Sort = ""
				BusinessDetails.URL_Linkin.Sort = ""
				BusinessDetails.Currency_PAYPAL.Sort = ""
				BusinessDetails.Currency_STRIPE.Sort = ""
				BusinessDetails.Currency_WOLRDPAY.Sort = ""
				BusinessDetails.Tip_percent.Sort = ""
				BusinessDetails.Tax_Percent.Sort = ""
				BusinessDetails.InRestaurantTaxChargeOnly.Sort = ""
				BusinessDetails.InRestaurantTipChargeOnly.Sort = ""
				BusinessDetails.isCheckCapcha.Sort = ""
				BusinessDetails.Close_StartDate.Sort = ""
				BusinessDetails.Close_EndDate.Sort = ""
				BusinessDetails.Stripe_Country.Sort = ""
				BusinessDetails.enable_StripePaymentButton.Sort = ""
				BusinessDetails.enable_CashPayment.Sort = ""
				BusinessDetails.DeliveryMile.Sort = ""
				BusinessDetails.Mon_Delivery.Sort = ""
				BusinessDetails.Mon_Collection.Sort = ""
				BusinessDetails.Tue_Delivery.Sort = ""
				BusinessDetails.Tue_Collection.Sort = ""
				BusinessDetails.Wed_Delivery.Sort = ""
				BusinessDetails.Wed_Collection.Sort = ""
				BusinessDetails.Thu_Delivery.Sort = ""
				BusinessDetails.Thu_Collection.Sort = ""
				BusinessDetails.Fri_Delivery.Sort = ""
				BusinessDetails.Fri_Collection.Sort = ""
				BusinessDetails.Sat_Delivery.Sort = ""
				BusinessDetails.Sat_Collection.Sort = ""
				BusinessDetails.Sun_Delivery.Sort = ""
				BusinessDetails.Sun_Collection.Sort = ""
				BusinessDetails.EnableUrlRewrite.Sort = ""
				BusinessDetails.DeliveryCostUpTo.Sort = ""
				BusinessDetails.DeliveryUptoMile.Sort = ""
				BusinessDetails.Show_Ordernumner_printer.Sort = ""
				BusinessDetails.Show_Ordernumner_Receipt.Sort = ""
				BusinessDetails.Show_Ordernumner_Dashboard.Sort = ""
			End If

			' Reset start position
			StartRec = 1
			BusinessDetails.StartRecordNumber = StartRec
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
		ListOptions.GetItem("checkbox").Body = "<input type=""checkbox"" name=""key_m"" value=""" & ew_HtmlEncode(BusinessDetails.ID.CurrentValue) & """ onclick='ew_ClickMultiCheckbox(event, this);'>"
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
		item.Body = "<a class=""ewAction ewMultiDelete"" title=""" & ew_HtmlTitle(Language.Phrase("DeleteSelectedLink")) & """ data-caption=""" & ew_HtmlTitle(Language.Phrase("DeleteSelectedLink")) & """ href="""" onclick=""ew_SubmitSelected(document.fBusinessDetailslist, '" & MultiDeleteUrl & "', ewLanguage.Phrase('DeleteMultiConfirmMsg'));return false;"">" & Language.Phrase("DeleteSelectedLink") & "</a>"
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
			For i = 0 to UBound(BusinessDetails.CustomActions.CustomArray)
				Action = BusinessDetails.CustomActions.CustomArray(i)(0)
				Name = BusinessDetails.CustomActions.CustomArray(i)(1)

				' Add custom action
				Call opt.Add("custom_" & Action)
				Set item = opt.GetItem("custom_" & Action)
				item.Body = "<a class=""ewAction ewCustomAction"" href="""" onclick=""ew_SubmitSelected(document.fBusinessDetailslist, '" & ew_CurrentUrl & "', null, '" & Action & "');return false;"">" & Name & "</a>"
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
		sFilter = BusinessDetails.GetKeyFilter
		UserAction = Request.Form("useraction") & ""
		Processed = False
		If sFilter <> "" And UserAction <> "" Then
			BusinessDetails.CurrentFilter = sFilter
			sSql = BusinessDetails.SQL
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
				ElseIf BusinessDetails.CancelMessage <> "" Then
					FailureMessage = BusinessDetails.CancelMessage
					BusinessDetails.CancelMessage = ""
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
		SearchOptions.TableVar = BusinessDetails.TableVar
		ExportOptions.Tag = "div"
		SearchOptions.TagClassName = "ewSearchOption"

		' Search button
		SearchOptions.Add("searchtoggle")
		Set item = SearchOptions.GetItem("searchtoggle")
		SearchToggleClass = ew_IIf(SearchWhere <> "", " active", " active")
		item.Body = "<button type=""button"" class=""btn btn-default ewSearchToggle" & SearchToggleClass & """ title=""" & Language.Phrase("SearchPanel") & """ data-caption=""" & Language.Phrase("SearchPanel") & """ data-toggle=""button"" data-form=""fBusinessDetailslistsrch"">" & Language.Phrase("SearchBtn") & "</button>"
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
		If BusinessDetails.Export <> "" Or BusinessDetails.CurrentAction <> "" Then
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
				BusinessDetails.StartRecordNumber = StartRec
			ElseIf Request.QueryString(EW_TABLE_PAGE_NO).Count > 0 Then
				PageNo = Request.QueryString(EW_TABLE_PAGE_NO)
				If IsNumeric(PageNo) Then
					StartRec = (PageNo-1)*DisplayRecs+1
					If StartRec <= 0 Then
						StartRec = 1
					ElseIf StartRec >= ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1 Then
						StartRec = ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1
					End If
					BusinessDetails.StartRecordNumber = StartRec
				End If
			End If
		End If
		StartRec = BusinessDetails.StartRecordNumber

		' Check if correct start record counter
		If Not IsNumeric(StartRec) Or StartRec = "" Then ' Avoid invalid start record counter
			StartRec = 1 ' Reset start record counter
			BusinessDetails.StartRecordNumber = StartRec
		ElseIf CLng(StartRec) > CLng(TotalRecs) Then ' Avoid starting record > total records
			StartRec = ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1 ' Point to last page first record
			BusinessDetails.StartRecordNumber = StartRec
		ElseIf (StartRec-1) Mod DisplayRecs <> 0 Then
			StartRec = ((StartRec-1)\DisplayRecs)*DisplayRecs+1 ' Point to page boundary
			BusinessDetails.StartRecordNumber = StartRec
		End If
	End Sub

	' -----------------------------------------------------------------
	'  Load basic search values
	'
	Function LoadBasicSearchValues()
		BusinessDetails.BasicSearch.Keyword = Request.QueryString(EW_TABLE_BASIC_SEARCH)&""
		If BusinessDetails.BasicSearch.Keyword <> "" Then Command = "search"
		BusinessDetails.BasicSearch.SearchType = Request.QueryString(EW_TABLE_BASIC_SEARCH_TYPE)&""
	End Function

	' -----------------------------------------------------------------
	' Load recordset
	'
	Function LoadRecordset()

		' Load list page sql
		Dim sSql
		sSql = BusinessDetails.SelectSQL
		Call ew_SetDebugMsg("LoadRecordset: " & sSql) ' Show SQL for debugging

		' Load recordset
		Dim RsRecordset
		Set RsRecordset = ew_LoadRecordset(sSql)

		' Call Recordset Selected event
		Call BusinessDetails.Recordset_Selected(RsRecordset)
		Set LoadRecordset = RsRecordset
	End Function

	' -----------------------------------------------------------------
	' Load row based on key values
	'
	Function LoadRow()
		Dim RsRow, sSql, sFilter
		sFilter = BusinessDetails.KeyFilter

		' Call Row Selecting event
		Call BusinessDetails.Row_Selecting(sFilter)

		' Load sql based on filter
		BusinessDetails.CurrentFilter = sFilter
		sSql = BusinessDetails.SQL
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
		Call BusinessDetails.Row_Selected(RsRow)
		BusinessDetails.ID.DbValue = RsRow("ID")
		BusinessDetails.Name.DbValue = RsRow("Name")
		BusinessDetails.Address.DbValue = RsRow("Address")
		BusinessDetails.PostalCode.DbValue = RsRow("PostalCode")
		BusinessDetails.FoodType.DbValue = RsRow("FoodType")
		BusinessDetails.DeliveryMinAmount.DbValue = RsRow("DeliveryMinAmount")
		BusinessDetails.DeliveryMaxDistance.DbValue = RsRow("DeliveryMaxDistance")
		BusinessDetails.DeliveryFreeDistance.DbValue = RsRow("DeliveryFreeDistance")
		BusinessDetails.AverageDeliveryTime.DbValue = RsRow("AverageDeliveryTime")
		BusinessDetails.AverageCollectionTime.DbValue = RsRow("AverageCollectionTime")
		BusinessDetails.DeliveryFee.DbValue = RsRow("DeliveryFee")
		BusinessDetails.ImgUrl.DbValue = RsRow("ImgUrl")
		BusinessDetails.Telephone.DbValue = RsRow("Telephone")
		BusinessDetails.zEmail.DbValue = RsRow("Email")
		BusinessDetails.pswd.DbValue = RsRow("pswd")
		BusinessDetails.businessclosed.DbValue = RsRow("businessclosed")
		BusinessDetails.announcement.DbValue = RsRow("announcement")
		BusinessDetails.css.DbValue = RsRow("css")
		BusinessDetails.SMTP_AUTENTICATE.DbValue = RsRow("SMTP_AUTENTICATE")
		BusinessDetails.MAIL_FROM.DbValue = RsRow("MAIL_FROM")
		BusinessDetails.PAYPAL_URL.DbValue = RsRow("PAYPAL_URL")
		BusinessDetails.PAYPAL_PDT.DbValue = RsRow("PAYPAL_PDT")
		BusinessDetails.SMTP_PASSWORD.DbValue = RsRow("SMTP_PASSWORD")
		BusinessDetails.GMAP_API_KEY.DbValue = RsRow("GMAP_API_KEY")
		BusinessDetails.SMTP_USERNAME.DbValue = RsRow("SMTP_USERNAME")
		BusinessDetails.SMTP_USESSL.DbValue = RsRow("SMTP_USESSL")
		BusinessDetails.MAIL_SUBJECT.DbValue = RsRow("MAIL_SUBJECT")
		BusinessDetails.CURRENCYSYMBOL.DbValue = RsRow("CURRENCYSYMBOL")
		BusinessDetails.SMTP_SERVER.DbValue = RsRow("SMTP_SERVER")
		BusinessDetails.CREDITCARDSURCHARGE.DbValue = RsRow("CREDITCARDSURCHARGE")
		BusinessDetails.SMTP_PORT.DbValue = RsRow("SMTP_PORT")
		BusinessDetails.STICK_MENU.DbValue = RsRow("STICK_MENU")
		BusinessDetails.MAIL_CUSTOMER_SUBJECT.DbValue = RsRow("MAIL_CUSTOMER_SUBJECT")
		BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.DbValue = RsRow("CONFIRMATION_EMAIL_ADDRESS")
		BusinessDetails.SEND_ORDERS_TO_PRINTER.DbValue = RsRow("SEND_ORDERS_TO_PRINTER")
		BusinessDetails.timezone.DbValue = RsRow("timezone")
		BusinessDetails.PAYPAL_ADDR.DbValue = RsRow("PAYPAL_ADDR")
		BusinessDetails.nochex.DbValue = RsRow("nochex")
		BusinessDetails.nochexmerchantid.DbValue = RsRow("nochexmerchantid")
		BusinessDetails.paypal.DbValue = RsRow("paypal")
		BusinessDetails.IBT_API_KEY.DbValue = RsRow("IBT_API_KEY")
		BusinessDetails.IBP_API_PASSWORD.DbValue = RsRow("IBP_API_PASSWORD")
		BusinessDetails.disable_delivery.DbValue = RsRow("disable_delivery")
		BusinessDetails.disable_collection.DbValue = RsRow("disable_collection")
		BusinessDetails.worldpay.DbValue = RsRow("worldpay")
		BusinessDetails.worldpaymerchantid.DbValue = RsRow("worldpaymerchantid")
		BusinessDetails.backtohometext.DbValue = RsRow("backtohometext")
		BusinessDetails.closedtext.DbValue = RsRow("closedtext")
		BusinessDetails.DeliveryChargeOverrideByOrderValue.DbValue = RsRow("DeliveryChargeOverrideByOrderValue")
		BusinessDetails.individualpostcodes.DbValue = RsRow("individualpostcodes")
		BusinessDetails.individualpostcodeschecking.DbValue = RsRow("individualpostcodeschecking")
		BusinessDetails.longitude.DbValue = RsRow("longitude")
		BusinessDetails.latitude.DbValue = RsRow("latitude")
		BusinessDetails.googleecommercetracking.DbValue = RsRow("googleecommercetracking")
		BusinessDetails.googleecommercetrackingcode.DbValue = RsRow("googleecommercetrackingcode")
		BusinessDetails.bringg.DbValue = RsRow("bringg")
		BusinessDetails.bringgurl.DbValue = RsRow("bringgurl")
		BusinessDetails.bringgcompanyid.DbValue = RsRow("bringgcompanyid")
		BusinessDetails.orderonlywhenopen.DbValue = RsRow("orderonlywhenopen")
		BusinessDetails.disablelaterdelivery.DbValue = RsRow("disablelaterdelivery")
		BusinessDetails.menupagetext.DbValue = RsRow("menupagetext")
		BusinessDetails.ordertodayonly.DbValue = RsRow("ordertodayonly")
		BusinessDetails.mileskm.DbValue = RsRow("mileskm")
		BusinessDetails.worldpaylive.DbValue = RsRow("worldpaylive")
		BusinessDetails.worldpayinstallationid.DbValue = RsRow("worldpayinstallationid")
		BusinessDetails.DistanceCalMethod.DbValue = RsRow("DistanceCalMethod")
		BusinessDetails.PrinterIDList.DbValue = RsRow("PrinterIDList")
		BusinessDetails.EpsonJSPrinterURL.DbValue = RsRow("EpsonJSPrinterURL")
		BusinessDetails.SMSEnable.DbValue = RsRow("SMSEnable")
		BusinessDetails.SMSOnDelivery.DbValue = RsRow("SMSOnDelivery")
		BusinessDetails.SMSSupplierDomain.DbValue = RsRow("SMSSupplierDomain")
		BusinessDetails.SMSOnOrder.DbValue = RsRow("SMSOnOrder")
		BusinessDetails.SMSOnOrderAfterMin.DbValue = RsRow("SMSOnOrderAfterMin")
		BusinessDetails.SMSOnOrderContent.DbValue = RsRow("SMSOnOrderContent")
		BusinessDetails.DefaultSMSCountryCode.DbValue = RsRow("DefaultSMSCountryCode")
		BusinessDetails.MinimumAmountForCardPayment.DbValue = RsRow("MinimumAmountForCardPayment")
		BusinessDetails.FavIconUrl.DbValue = RsRow("FavIconUrl")
		BusinessDetails.AddToHomeScreenURL.DbValue = RsRow("AddToHomeScreenURL")
		BusinessDetails.SMSOnAcknowledgement.DbValue = RsRow("SMSOnAcknowledgement")
		BusinessDetails.LocalPrinterURL.DbValue = RsRow("LocalPrinterURL")
		BusinessDetails.ShowRestaurantDetailOnReceipt.DbValue = RsRow("ShowRestaurantDetailOnReceipt")
		BusinessDetails.PrinterFontSizeRatio.DbValue = RsRow("PrinterFontSizeRatio")
		BusinessDetails.ServiceChargePercentage.DbValue = RsRow("ServiceChargePercentage")
		BusinessDetails.InRestaurantServiceChargeOnly.DbValue = RsRow("InRestaurantServiceChargeOnly")
		BusinessDetails.IsDualReceiptPrinting.DbValue = RsRow("IsDualReceiptPrinting")
		BusinessDetails.PrintingFontSize.DbValue = RsRow("PrintingFontSize")
		BusinessDetails.InRestaurantEpsonPrinterIDList.DbValue = RsRow("InRestaurantEpsonPrinterIDList")
		BusinessDetails.BlockIPEmailList.DbValue = RsRow("BlockIPEmailList")
		BusinessDetails.inmenuannouncement.DbValue = RsRow("inmenuannouncement")
		BusinessDetails.RePrintReceiptWays.DbValue = RsRow("RePrintReceiptWays")
		BusinessDetails.printingtype.DbValue = RsRow("printingtype")
		BusinessDetails.Stripe_Key_Secret.DbValue = RsRow("Stripe_Key_Secret")
		BusinessDetails.Stripe.DbValue = RsRow("Stripe")
		BusinessDetails.Stripe_Api_Key.DbValue = RsRow("Stripe_Api_Key")
		BusinessDetails.EnableBooking.DbValue = RsRow("EnableBooking")
		BusinessDetails.URL_Facebook.DbValue = RsRow("URL_Facebook")
		BusinessDetails.URL_Twitter.DbValue = RsRow("URL_Twitter")
		BusinessDetails.URL_Google.DbValue = RsRow("URL_Google")
		BusinessDetails.URL_Intagram.DbValue = RsRow("URL_Intagram")
		BusinessDetails.URL_YouTube.DbValue = RsRow("URL_YouTube")
		BusinessDetails.URL_Tripadvisor.DbValue = RsRow("URL_Tripadvisor")
		BusinessDetails.URL_Special_Offer.DbValue = RsRow("URL_Special_Offer")
		BusinessDetails.URL_Linkin.DbValue = RsRow("URL_Linkin")
		BusinessDetails.Currency_PAYPAL.DbValue = RsRow("Currency_PAYPAL")
		BusinessDetails.Currency_STRIPE.DbValue = RsRow("Currency_STRIPE")
		BusinessDetails.Currency_WOLRDPAY.DbValue = RsRow("Currency_WOLRDPAY")
		BusinessDetails.Tip_percent.DbValue = RsRow("Tip_percent")
		BusinessDetails.Tax_Percent.DbValue = RsRow("Tax_Percent")
		BusinessDetails.InRestaurantTaxChargeOnly.DbValue = RsRow("InRestaurantTaxChargeOnly")
		BusinessDetails.InRestaurantTipChargeOnly.DbValue = RsRow("InRestaurantTipChargeOnly")
		BusinessDetails.isCheckCapcha.DbValue = RsRow("isCheckCapcha")
		BusinessDetails.Close_StartDate.DbValue = RsRow("Close_StartDate")
		BusinessDetails.Close_EndDate.DbValue = RsRow("Close_EndDate")
		BusinessDetails.Stripe_Country.DbValue = RsRow("Stripe_Country")
		BusinessDetails.enable_StripePaymentButton.DbValue = RsRow("enable_StripePaymentButton")
		BusinessDetails.enable_CashPayment.DbValue = RsRow("enable_CashPayment")
		BusinessDetails.DeliveryMile.DbValue = RsRow("DeliveryMile")
		BusinessDetails.Mon_Delivery.DbValue = RsRow("Mon_Delivery")
		BusinessDetails.Mon_Collection.DbValue = RsRow("Mon_Collection")
		BusinessDetails.Tue_Delivery.DbValue = RsRow("Tue_Delivery")
		BusinessDetails.Tue_Collection.DbValue = RsRow("Tue_Collection")
		BusinessDetails.Wed_Delivery.DbValue = RsRow("Wed_Delivery")
		BusinessDetails.Wed_Collection.DbValue = RsRow("Wed_Collection")
		BusinessDetails.Thu_Delivery.DbValue = RsRow("Thu_Delivery")
		BusinessDetails.Thu_Collection.DbValue = RsRow("Thu_Collection")
		BusinessDetails.Fri_Delivery.DbValue = RsRow("Fri_Delivery")
		BusinessDetails.Fri_Collection.DbValue = RsRow("Fri_Collection")
		BusinessDetails.Sat_Delivery.DbValue = RsRow("Sat_Delivery")
		BusinessDetails.Sat_Collection.DbValue = RsRow("Sat_Collection")
		BusinessDetails.Sun_Delivery.DbValue = RsRow("Sun_Delivery")
		BusinessDetails.Sun_Collection.DbValue = RsRow("Sun_Collection")
		BusinessDetails.EnableUrlRewrite.DbValue = RsRow("EnableUrlRewrite")
		BusinessDetails.DeliveryCostUpTo.DbValue = RsRow("DeliveryCostUpTo")
		BusinessDetails.DeliveryUptoMile.DbValue = RsRow("DeliveryUptoMile")
		BusinessDetails.Show_Ordernumner_printer.DbValue = RsRow("Show_Ordernumner_printer")
		BusinessDetails.Show_Ordernumner_Receipt.DbValue = RsRow("Show_Ordernumner_Receipt")
		BusinessDetails.Show_Ordernumner_Dashboard.DbValue = RsRow("Show_Ordernumner_Dashboard")
	End Sub

	' Load DbValue from recordset
	Sub LoadDbValues(Rs)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		If Rs.Eof Then Exit Sub
		BusinessDetails.ID.m_DbValue = Rs("ID")
		BusinessDetails.Name.m_DbValue = Rs("Name")
		BusinessDetails.Address.m_DbValue = Rs("Address")
		BusinessDetails.PostalCode.m_DbValue = Rs("PostalCode")
		BusinessDetails.FoodType.m_DbValue = Rs("FoodType")
		BusinessDetails.DeliveryMinAmount.m_DbValue = Rs("DeliveryMinAmount")
		BusinessDetails.DeliveryMaxDistance.m_DbValue = Rs("DeliveryMaxDistance")
		BusinessDetails.DeliveryFreeDistance.m_DbValue = Rs("DeliveryFreeDistance")
		BusinessDetails.AverageDeliveryTime.m_DbValue = Rs("AverageDeliveryTime")
		BusinessDetails.AverageCollectionTime.m_DbValue = Rs("AverageCollectionTime")
		BusinessDetails.DeliveryFee.m_DbValue = Rs("DeliveryFee")
		BusinessDetails.ImgUrl.m_DbValue = Rs("ImgUrl")
		BusinessDetails.Telephone.m_DbValue = Rs("Telephone")
		BusinessDetails.zEmail.m_DbValue = Rs("Email")
		BusinessDetails.pswd.m_DbValue = Rs("pswd")
		BusinessDetails.businessclosed.m_DbValue = Rs("businessclosed")
		BusinessDetails.announcement.m_DbValue = Rs("announcement")
		BusinessDetails.css.m_DbValue = Rs("css")
		BusinessDetails.SMTP_AUTENTICATE.m_DbValue = Rs("SMTP_AUTENTICATE")
		BusinessDetails.MAIL_FROM.m_DbValue = Rs("MAIL_FROM")
		BusinessDetails.PAYPAL_URL.m_DbValue = Rs("PAYPAL_URL")
		BusinessDetails.PAYPAL_PDT.m_DbValue = Rs("PAYPAL_PDT")
		BusinessDetails.SMTP_PASSWORD.m_DbValue = Rs("SMTP_PASSWORD")
		BusinessDetails.GMAP_API_KEY.m_DbValue = Rs("GMAP_API_KEY")
		BusinessDetails.SMTP_USERNAME.m_DbValue = Rs("SMTP_USERNAME")
		BusinessDetails.SMTP_USESSL.m_DbValue = Rs("SMTP_USESSL")
		BusinessDetails.MAIL_SUBJECT.m_DbValue = Rs("MAIL_SUBJECT")
		BusinessDetails.CURRENCYSYMBOL.m_DbValue = Rs("CURRENCYSYMBOL")
		BusinessDetails.SMTP_SERVER.m_DbValue = Rs("SMTP_SERVER")
		BusinessDetails.CREDITCARDSURCHARGE.m_DbValue = Rs("CREDITCARDSURCHARGE")
		BusinessDetails.SMTP_PORT.m_DbValue = Rs("SMTP_PORT")
		BusinessDetails.STICK_MENU.m_DbValue = Rs("STICK_MENU")
		BusinessDetails.MAIL_CUSTOMER_SUBJECT.m_DbValue = Rs("MAIL_CUSTOMER_SUBJECT")
		BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.m_DbValue = Rs("CONFIRMATION_EMAIL_ADDRESS")
		BusinessDetails.SEND_ORDERS_TO_PRINTER.m_DbValue = Rs("SEND_ORDERS_TO_PRINTER")
		BusinessDetails.timezone.m_DbValue = Rs("timezone")
		BusinessDetails.PAYPAL_ADDR.m_DbValue = Rs("PAYPAL_ADDR")
		BusinessDetails.nochex.m_DbValue = Rs("nochex")
		BusinessDetails.nochexmerchantid.m_DbValue = Rs("nochexmerchantid")
		BusinessDetails.paypal.m_DbValue = Rs("paypal")
		BusinessDetails.IBT_API_KEY.m_DbValue = Rs("IBT_API_KEY")
		BusinessDetails.IBP_API_PASSWORD.m_DbValue = Rs("IBP_API_PASSWORD")
		BusinessDetails.disable_delivery.m_DbValue = Rs("disable_delivery")
		BusinessDetails.disable_collection.m_DbValue = Rs("disable_collection")
		BusinessDetails.worldpay.m_DbValue = Rs("worldpay")
		BusinessDetails.worldpaymerchantid.m_DbValue = Rs("worldpaymerchantid")
		BusinessDetails.backtohometext.m_DbValue = Rs("backtohometext")
		BusinessDetails.closedtext.m_DbValue = Rs("closedtext")
		BusinessDetails.DeliveryChargeOverrideByOrderValue.m_DbValue = Rs("DeliveryChargeOverrideByOrderValue")
		BusinessDetails.individualpostcodes.m_DbValue = Rs("individualpostcodes")
		BusinessDetails.individualpostcodeschecking.m_DbValue = Rs("individualpostcodeschecking")
		BusinessDetails.longitude.m_DbValue = Rs("longitude")
		BusinessDetails.latitude.m_DbValue = Rs("latitude")
		BusinessDetails.googleecommercetracking.m_DbValue = Rs("googleecommercetracking")
		BusinessDetails.googleecommercetrackingcode.m_DbValue = Rs("googleecommercetrackingcode")
		BusinessDetails.bringg.m_DbValue = Rs("bringg")
		BusinessDetails.bringgurl.m_DbValue = Rs("bringgurl")
		BusinessDetails.bringgcompanyid.m_DbValue = Rs("bringgcompanyid")
		BusinessDetails.orderonlywhenopen.m_DbValue = Rs("orderonlywhenopen")
		BusinessDetails.disablelaterdelivery.m_DbValue = Rs("disablelaterdelivery")
		BusinessDetails.menupagetext.m_DbValue = Rs("menupagetext")
		BusinessDetails.ordertodayonly.m_DbValue = Rs("ordertodayonly")
		BusinessDetails.mileskm.m_DbValue = Rs("mileskm")
		BusinessDetails.worldpaylive.m_DbValue = Rs("worldpaylive")
		BusinessDetails.worldpayinstallationid.m_DbValue = Rs("worldpayinstallationid")
		BusinessDetails.DistanceCalMethod.m_DbValue = Rs("DistanceCalMethod")
		BusinessDetails.PrinterIDList.m_DbValue = Rs("PrinterIDList")
		BusinessDetails.EpsonJSPrinterURL.m_DbValue = Rs("EpsonJSPrinterURL")
		BusinessDetails.SMSEnable.m_DbValue = Rs("SMSEnable")
		BusinessDetails.SMSOnDelivery.m_DbValue = Rs("SMSOnDelivery")
		BusinessDetails.SMSSupplierDomain.m_DbValue = Rs("SMSSupplierDomain")
		BusinessDetails.SMSOnOrder.m_DbValue = Rs("SMSOnOrder")
		BusinessDetails.SMSOnOrderAfterMin.m_DbValue = Rs("SMSOnOrderAfterMin")
		BusinessDetails.SMSOnOrderContent.m_DbValue = Rs("SMSOnOrderContent")
		BusinessDetails.DefaultSMSCountryCode.m_DbValue = Rs("DefaultSMSCountryCode")
		BusinessDetails.MinimumAmountForCardPayment.m_DbValue = Rs("MinimumAmountForCardPayment")
		BusinessDetails.FavIconUrl.m_DbValue = Rs("FavIconUrl")
		BusinessDetails.AddToHomeScreenURL.m_DbValue = Rs("AddToHomeScreenURL")
		BusinessDetails.SMSOnAcknowledgement.m_DbValue = Rs("SMSOnAcknowledgement")
		BusinessDetails.LocalPrinterURL.m_DbValue = Rs("LocalPrinterURL")
		BusinessDetails.ShowRestaurantDetailOnReceipt.m_DbValue = Rs("ShowRestaurantDetailOnReceipt")
		BusinessDetails.PrinterFontSizeRatio.m_DbValue = Rs("PrinterFontSizeRatio")
		BusinessDetails.ServiceChargePercentage.m_DbValue = Rs("ServiceChargePercentage")
		BusinessDetails.InRestaurantServiceChargeOnly.m_DbValue = Rs("InRestaurantServiceChargeOnly")
		BusinessDetails.IsDualReceiptPrinting.m_DbValue = Rs("IsDualReceiptPrinting")
		BusinessDetails.PrintingFontSize.m_DbValue = Rs("PrintingFontSize")
		BusinessDetails.InRestaurantEpsonPrinterIDList.m_DbValue = Rs("InRestaurantEpsonPrinterIDList")
		BusinessDetails.BlockIPEmailList.m_DbValue = Rs("BlockIPEmailList")
		BusinessDetails.inmenuannouncement.m_DbValue = Rs("inmenuannouncement")
		BusinessDetails.RePrintReceiptWays.m_DbValue = Rs("RePrintReceiptWays")
		BusinessDetails.printingtype.m_DbValue = Rs("printingtype")
		BusinessDetails.Stripe_Key_Secret.m_DbValue = Rs("Stripe_Key_Secret")
		BusinessDetails.Stripe.m_DbValue = Rs("Stripe")
		BusinessDetails.Stripe_Api_Key.m_DbValue = Rs("Stripe_Api_Key")
		BusinessDetails.EnableBooking.m_DbValue = Rs("EnableBooking")
		BusinessDetails.URL_Facebook.m_DbValue = Rs("URL_Facebook")
		BusinessDetails.URL_Twitter.m_DbValue = Rs("URL_Twitter")
		BusinessDetails.URL_Google.m_DbValue = Rs("URL_Google")
		BusinessDetails.URL_Intagram.m_DbValue = Rs("URL_Intagram")
		BusinessDetails.URL_YouTube.m_DbValue = Rs("URL_YouTube")
		BusinessDetails.URL_Tripadvisor.m_DbValue = Rs("URL_Tripadvisor")
		BusinessDetails.URL_Special_Offer.m_DbValue = Rs("URL_Special_Offer")
		BusinessDetails.URL_Linkin.m_DbValue = Rs("URL_Linkin")
		BusinessDetails.Currency_PAYPAL.m_DbValue = Rs("Currency_PAYPAL")
		BusinessDetails.Currency_STRIPE.m_DbValue = Rs("Currency_STRIPE")
		BusinessDetails.Currency_WOLRDPAY.m_DbValue = Rs("Currency_WOLRDPAY")
		BusinessDetails.Tip_percent.m_DbValue = Rs("Tip_percent")
		BusinessDetails.Tax_Percent.m_DbValue = Rs("Tax_Percent")
		BusinessDetails.InRestaurantTaxChargeOnly.m_DbValue = Rs("InRestaurantTaxChargeOnly")
		BusinessDetails.InRestaurantTipChargeOnly.m_DbValue = Rs("InRestaurantTipChargeOnly")
		BusinessDetails.isCheckCapcha.m_DbValue = Rs("isCheckCapcha")
		BusinessDetails.Close_StartDate.m_DbValue = Rs("Close_StartDate")
		BusinessDetails.Close_EndDate.m_DbValue = Rs("Close_EndDate")
		BusinessDetails.Stripe_Country.m_DbValue = Rs("Stripe_Country")
		BusinessDetails.enable_StripePaymentButton.m_DbValue = Rs("enable_StripePaymentButton")
		BusinessDetails.enable_CashPayment.m_DbValue = Rs("enable_CashPayment")
		BusinessDetails.DeliveryMile.m_DbValue = Rs("DeliveryMile")
		BusinessDetails.Mon_Delivery.m_DbValue = Rs("Mon_Delivery")
		BusinessDetails.Mon_Collection.m_DbValue = Rs("Mon_Collection")
		BusinessDetails.Tue_Delivery.m_DbValue = Rs("Tue_Delivery")
		BusinessDetails.Tue_Collection.m_DbValue = Rs("Tue_Collection")
		BusinessDetails.Wed_Delivery.m_DbValue = Rs("Wed_Delivery")
		BusinessDetails.Wed_Collection.m_DbValue = Rs("Wed_Collection")
		BusinessDetails.Thu_Delivery.m_DbValue = Rs("Thu_Delivery")
		BusinessDetails.Thu_Collection.m_DbValue = Rs("Thu_Collection")
		BusinessDetails.Fri_Delivery.m_DbValue = Rs("Fri_Delivery")
		BusinessDetails.Fri_Collection.m_DbValue = Rs("Fri_Collection")
		BusinessDetails.Sat_Delivery.m_DbValue = Rs("Sat_Delivery")
		BusinessDetails.Sat_Collection.m_DbValue = Rs("Sat_Collection")
		BusinessDetails.Sun_Delivery.m_DbValue = Rs("Sun_Delivery")
		BusinessDetails.Sun_Collection.m_DbValue = Rs("Sun_Collection")
		BusinessDetails.EnableUrlRewrite.m_DbValue = Rs("EnableUrlRewrite")
		BusinessDetails.DeliveryCostUpTo.m_DbValue = Rs("DeliveryCostUpTo")
		BusinessDetails.DeliveryUptoMile.m_DbValue = Rs("DeliveryUptoMile")
		BusinessDetails.Show_Ordernumner_printer.m_DbValue = Rs("Show_Ordernumner_printer")
		BusinessDetails.Show_Ordernumner_Receipt.m_DbValue = Rs("Show_Ordernumner_Receipt")
		BusinessDetails.Show_Ordernumner_Dashboard.m_DbValue = Rs("Show_Ordernumner_Dashboard")
	End Sub

	' Load old record
	Function LoadOldRecord()

		' Load key values from Session
		Dim bValidKey
		bValidKey = True
		If BusinessDetails.GetKey("ID")&"" <> "" Then
			BusinessDetails.ID.CurrentValue = BusinessDetails.GetKey("ID") ' ID
		Else
			bValidKey = False
		End If

		' Load old recordset
		If bValidKey Then
			BusinessDetails.CurrentFilter = BusinessDetails.KeyFilter
			Dim sSql
			sSql = BusinessDetails.SQL
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
		ViewUrl = BusinessDetails.ViewUrl("")
		EditUrl = BusinessDetails.EditUrl("")
		InlineEditUrl = BusinessDetails.InlineEditUrl
		CopyUrl = BusinessDetails.CopyUrl("")
		InlineCopyUrl = BusinessDetails.InlineCopyUrl
		DeleteUrl = BusinessDetails.DeleteUrl

		' Convert decimal values if posted back
		If BusinessDetails.DeliveryMaxDistance.FormValue = BusinessDetails.DeliveryMaxDistance.CurrentValue And IsNumeric(BusinessDetails.DeliveryMaxDistance.CurrentValue) Then
			BusinessDetails.DeliveryMaxDistance.CurrentValue = ew_StrToFloat(BusinessDetails.DeliveryMaxDistance.CurrentValue)
		End If

		' Convert decimal values if posted back
		If BusinessDetails.DeliveryFreeDistance.FormValue = BusinessDetails.DeliveryFreeDistance.CurrentValue And IsNumeric(BusinessDetails.DeliveryFreeDistance.CurrentValue) Then
			BusinessDetails.DeliveryFreeDistance.CurrentValue = ew_StrToFloat(BusinessDetails.DeliveryFreeDistance.CurrentValue)
		End If

		' Convert decimal values if posted back
		If BusinessDetails.DeliveryFee.FormValue = BusinessDetails.DeliveryFee.CurrentValue And IsNumeric(BusinessDetails.DeliveryFee.CurrentValue) Then
			BusinessDetails.DeliveryFee.CurrentValue = ew_StrToFloat(BusinessDetails.DeliveryFee.CurrentValue)
		End If

		' Convert decimal values if posted back
		If BusinessDetails.MinimumAmountForCardPayment.FormValue = BusinessDetails.MinimumAmountForCardPayment.CurrentValue And IsNumeric(BusinessDetails.MinimumAmountForCardPayment.CurrentValue) Then
			BusinessDetails.MinimumAmountForCardPayment.CurrentValue = ew_StrToFloat(BusinessDetails.MinimumAmountForCardPayment.CurrentValue)
		End If

		' Convert decimal values if posted back
		If BusinessDetails.PrinterFontSizeRatio.FormValue = BusinessDetails.PrinterFontSizeRatio.CurrentValue And IsNumeric(BusinessDetails.PrinterFontSizeRatio.CurrentValue) Then
			BusinessDetails.PrinterFontSizeRatio.CurrentValue = ew_StrToFloat(BusinessDetails.PrinterFontSizeRatio.CurrentValue)
		End If

		' Convert decimal values if posted back
		If BusinessDetails.ServiceChargePercentage.FormValue = BusinessDetails.ServiceChargePercentage.CurrentValue And IsNumeric(BusinessDetails.ServiceChargePercentage.CurrentValue) Then
			BusinessDetails.ServiceChargePercentage.CurrentValue = ew_StrToFloat(BusinessDetails.ServiceChargePercentage.CurrentValue)
		End If

		' Convert decimal values if posted back
		If BusinessDetails.PrintingFontSize.FormValue = BusinessDetails.PrintingFontSize.CurrentValue And IsNumeric(BusinessDetails.PrintingFontSize.CurrentValue) Then
			BusinessDetails.PrintingFontSize.CurrentValue = ew_StrToFloat(BusinessDetails.PrintingFontSize.CurrentValue)
		End If

		' Convert decimal values if posted back
		If BusinessDetails.DeliveryMile.FormValue = BusinessDetails.DeliveryMile.CurrentValue And IsNumeric(BusinessDetails.DeliveryMile.CurrentValue) Then
			BusinessDetails.DeliveryMile.CurrentValue = ew_StrToFloat(BusinessDetails.DeliveryMile.CurrentValue)
		End If

		' Convert decimal values if posted back
		If BusinessDetails.DeliveryCostUpTo.FormValue = BusinessDetails.DeliveryCostUpTo.CurrentValue And IsNumeric(BusinessDetails.DeliveryCostUpTo.CurrentValue) Then
			BusinessDetails.DeliveryCostUpTo.CurrentValue = ew_StrToFloat(BusinessDetails.DeliveryCostUpTo.CurrentValue)
		End If

		' Convert decimal values if posted back
		If BusinessDetails.DeliveryUptoMile.FormValue = BusinessDetails.DeliveryUptoMile.CurrentValue And IsNumeric(BusinessDetails.DeliveryUptoMile.CurrentValue) Then
			BusinessDetails.DeliveryUptoMile.CurrentValue = ew_StrToFloat(BusinessDetails.DeliveryUptoMile.CurrentValue)
		End If

		' Call Row Rendering event
		Call BusinessDetails.Row_Rendering()

		' ---------------------------------------
		'  Common render codes for all row types
		' ---------------------------------------
		' ID
		' Name
		' Address
		' PostalCode
		' FoodType
		' DeliveryMinAmount
		' DeliveryMaxDistance
		' DeliveryFreeDistance
		' AverageDeliveryTime
		' AverageCollectionTime
		' DeliveryFee
		' ImgUrl
		' Telephone
		' Email
		' pswd
		' businessclosed
		' announcement
		' css
		' SMTP_AUTENTICATE
		' MAIL_FROM
		' PAYPAL_URL
		' PAYPAL_PDT
		' SMTP_PASSWORD
		' GMAP_API_KEY
		' SMTP_USERNAME
		' SMTP_USESSL
		' MAIL_SUBJECT
		' CURRENCYSYMBOL
		' SMTP_SERVER
		' CREDITCARDSURCHARGE
		' SMTP_PORT
		' STICK_MENU
		' MAIL_CUSTOMER_SUBJECT
		' CONFIRMATION_EMAIL_ADDRESS
		' SEND_ORDERS_TO_PRINTER
		' timezone
		' PAYPAL_ADDR
		' nochex
		' nochexmerchantid
		' paypal
		' IBT_API_KEY
		' IBP_API_PASSWORD
		' disable_delivery
		' disable_collection
		' worldpay
		' worldpaymerchantid
		' backtohometext
		' closedtext
		' DeliveryChargeOverrideByOrderValue
		' individualpostcodes
		' individualpostcodeschecking
		' longitude
		' latitude
		' googleecommercetracking
		' googleecommercetrackingcode
		' bringg
		' bringgurl
		' bringgcompanyid
		' orderonlywhenopen
		' disablelaterdelivery
		' menupagetext
		' ordertodayonly
		' mileskm
		' worldpaylive
		' worldpayinstallationid
		' DistanceCalMethod
		' PrinterIDList
		' EpsonJSPrinterURL
		' SMSEnable
		' SMSOnDelivery
		' SMSSupplierDomain
		' SMSOnOrder
		' SMSOnOrderAfterMin
		' SMSOnOrderContent
		' DefaultSMSCountryCode
		' MinimumAmountForCardPayment
		' FavIconUrl
		' AddToHomeScreenURL
		' SMSOnAcknowledgement
		' LocalPrinterURL
		' ShowRestaurantDetailOnReceipt
		' PrinterFontSizeRatio
		' ServiceChargePercentage
		' InRestaurantServiceChargeOnly
		' IsDualReceiptPrinting
		' PrintingFontSize
		' InRestaurantEpsonPrinterIDList
		' BlockIPEmailList
		' inmenuannouncement
		' RePrintReceiptWays
		' printingtype
		' Stripe_Key_Secret
		' Stripe
		' Stripe_Api_Key
		' EnableBooking
		' URL_Facebook
		' URL_Twitter
		' URL_Google
		' URL_Intagram
		' URL_YouTube
		' URL_Tripadvisor
		' URL_Special_Offer
		' URL_Linkin
		' Currency_PAYPAL
		' Currency_STRIPE
		' Currency_WOLRDPAY
		' Tip_percent
		' Tax_Percent
		' InRestaurantTaxChargeOnly
		' InRestaurantTipChargeOnly
		' isCheckCapcha
		' Close_StartDate
		' Close_EndDate
		' Stripe_Country
		' enable_StripePaymentButton
		' enable_CashPayment
		' DeliveryMile
		' Mon_Delivery
		' Mon_Collection
		' Tue_Delivery
		' Tue_Collection
		' Wed_Delivery
		' Wed_Collection
		' Thu_Delivery
		' Thu_Collection
		' Fri_Delivery
		' Fri_Collection
		' Sat_Delivery
		' Sat_Collection
		' Sun_Delivery
		' Sun_Collection
		' EnableUrlRewrite
		' DeliveryCostUpTo
		' DeliveryUptoMile
		' Show_Ordernumner_printer
		' Show_Ordernumner_Receipt
		' Show_Ordernumner_Dashboard
		' -----------
		'  View  Row
		' -----------

		If BusinessDetails.RowType = EW_ROWTYPE_VIEW Then ' View row

			' ID
			BusinessDetails.ID.ViewValue = BusinessDetails.ID.CurrentValue
			BusinessDetails.ID.ViewCustomAttributes = ""

			' Name
			BusinessDetails.Name.ViewValue = BusinessDetails.Name.CurrentValue
			BusinessDetails.Name.ViewCustomAttributes = ""

			' Address
			BusinessDetails.Address.ViewValue = BusinessDetails.Address.CurrentValue
			BusinessDetails.Address.ViewCustomAttributes = ""

			' PostalCode
			BusinessDetails.PostalCode.ViewValue = BusinessDetails.PostalCode.CurrentValue
			BusinessDetails.PostalCode.ViewCustomAttributes = ""

			' FoodType
			BusinessDetails.FoodType.ViewValue = BusinessDetails.FoodType.CurrentValue
			BusinessDetails.FoodType.ViewCustomAttributes = ""

			' DeliveryMinAmount
			BusinessDetails.DeliveryMinAmount.ViewValue = BusinessDetails.DeliveryMinAmount.CurrentValue
			BusinessDetails.DeliveryMinAmount.ViewCustomAttributes = ""

			' DeliveryMaxDistance
			BusinessDetails.DeliveryMaxDistance.ViewValue = BusinessDetails.DeliveryMaxDistance.CurrentValue
			BusinessDetails.DeliveryMaxDistance.ViewCustomAttributes = ""

			' DeliveryFreeDistance
			BusinessDetails.DeliveryFreeDistance.ViewValue = BusinessDetails.DeliveryFreeDistance.CurrentValue
			BusinessDetails.DeliveryFreeDistance.ViewCustomAttributes = ""

			' AverageDeliveryTime
			BusinessDetails.AverageDeliveryTime.ViewValue = BusinessDetails.AverageDeliveryTime.CurrentValue
			BusinessDetails.AverageDeliveryTime.ViewCustomAttributes = ""

			' AverageCollectionTime
			BusinessDetails.AverageCollectionTime.ViewValue = BusinessDetails.AverageCollectionTime.CurrentValue
			BusinessDetails.AverageCollectionTime.ViewCustomAttributes = ""

			' DeliveryFee
			BusinessDetails.DeliveryFee.ViewValue = BusinessDetails.DeliveryFee.CurrentValue
			BusinessDetails.DeliveryFee.ViewCustomAttributes = ""

			' ImgUrl
			BusinessDetails.ImgUrl.ViewValue = BusinessDetails.ImgUrl.CurrentValue
			BusinessDetails.ImgUrl.ViewCustomAttributes = ""

			' Telephone
			BusinessDetails.Telephone.ViewValue = BusinessDetails.Telephone.CurrentValue
			BusinessDetails.Telephone.ViewCustomAttributes = ""

			' Email
			BusinessDetails.zEmail.ViewValue = BusinessDetails.zEmail.CurrentValue
			BusinessDetails.zEmail.ViewCustomAttributes = ""

			' pswd
			BusinessDetails.pswd.ViewValue = BusinessDetails.pswd.CurrentValue
			BusinessDetails.pswd.ViewCustomAttributes = ""

			' businessclosed
			BusinessDetails.businessclosed.ViewValue = BusinessDetails.businessclosed.CurrentValue
			BusinessDetails.businessclosed.ViewCustomAttributes = ""

			' SMTP_AUTENTICATE
			BusinessDetails.SMTP_AUTENTICATE.ViewValue = BusinessDetails.SMTP_AUTENTICATE.CurrentValue
			BusinessDetails.SMTP_AUTENTICATE.ViewCustomAttributes = ""

			' MAIL_FROM
			BusinessDetails.MAIL_FROM.ViewValue = BusinessDetails.MAIL_FROM.CurrentValue
			BusinessDetails.MAIL_FROM.ViewCustomAttributes = ""

			' PAYPAL_URL
			BusinessDetails.PAYPAL_URL.ViewValue = BusinessDetails.PAYPAL_URL.CurrentValue
			BusinessDetails.PAYPAL_URL.ViewCustomAttributes = ""

			' PAYPAL_PDT
			BusinessDetails.PAYPAL_PDT.ViewValue = BusinessDetails.PAYPAL_PDT.CurrentValue
			BusinessDetails.PAYPAL_PDT.ViewCustomAttributes = ""

			' SMTP_PASSWORD
			BusinessDetails.SMTP_PASSWORD.ViewValue = BusinessDetails.SMTP_PASSWORD.CurrentValue
			BusinessDetails.SMTP_PASSWORD.ViewCustomAttributes = ""

			' GMAP_API_KEY
			BusinessDetails.GMAP_API_KEY.ViewValue = BusinessDetails.GMAP_API_KEY.CurrentValue
			BusinessDetails.GMAP_API_KEY.ViewCustomAttributes = ""

			' SMTP_USERNAME
			BusinessDetails.SMTP_USERNAME.ViewValue = BusinessDetails.SMTP_USERNAME.CurrentValue
			BusinessDetails.SMTP_USERNAME.ViewCustomAttributes = ""

			' SMTP_USESSL
			BusinessDetails.SMTP_USESSL.ViewValue = BusinessDetails.SMTP_USESSL.CurrentValue
			BusinessDetails.SMTP_USESSL.ViewCustomAttributes = ""

			' MAIL_SUBJECT
			BusinessDetails.MAIL_SUBJECT.ViewValue = BusinessDetails.MAIL_SUBJECT.CurrentValue
			BusinessDetails.MAIL_SUBJECT.ViewCustomAttributes = ""

			' CURRENCYSYMBOL
			BusinessDetails.CURRENCYSYMBOL.ViewValue = BusinessDetails.CURRENCYSYMBOL.CurrentValue
			BusinessDetails.CURRENCYSYMBOL.ViewCustomAttributes = ""

			' SMTP_SERVER
			BusinessDetails.SMTP_SERVER.ViewValue = BusinessDetails.SMTP_SERVER.CurrentValue
			BusinessDetails.SMTP_SERVER.ViewCustomAttributes = ""

			' CREDITCARDSURCHARGE
			BusinessDetails.CREDITCARDSURCHARGE.ViewValue = BusinessDetails.CREDITCARDSURCHARGE.CurrentValue
			BusinessDetails.CREDITCARDSURCHARGE.ViewCustomAttributes = ""

			' SMTP_PORT
			BusinessDetails.SMTP_PORT.ViewValue = BusinessDetails.SMTP_PORT.CurrentValue
			BusinessDetails.SMTP_PORT.ViewCustomAttributes = ""

			' STICK_MENU
			BusinessDetails.STICK_MENU.ViewValue = BusinessDetails.STICK_MENU.CurrentValue
			BusinessDetails.STICK_MENU.ViewCustomAttributes = ""

			' MAIL_CUSTOMER_SUBJECT
			BusinessDetails.MAIL_CUSTOMER_SUBJECT.ViewValue = BusinessDetails.MAIL_CUSTOMER_SUBJECT.CurrentValue
			BusinessDetails.MAIL_CUSTOMER_SUBJECT.ViewCustomAttributes = ""

			' CONFIRMATION_EMAIL_ADDRESS
			BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.ViewValue = BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.CurrentValue
			BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.ViewCustomAttributes = ""

			' SEND_ORDERS_TO_PRINTER
			BusinessDetails.SEND_ORDERS_TO_PRINTER.ViewValue = BusinessDetails.SEND_ORDERS_TO_PRINTER.CurrentValue
			BusinessDetails.SEND_ORDERS_TO_PRINTER.ViewCustomAttributes = ""

			' timezone
			BusinessDetails.timezone.ViewValue = BusinessDetails.timezone.CurrentValue
			BusinessDetails.timezone.ViewCustomAttributes = ""

			' PAYPAL_ADDR
			BusinessDetails.PAYPAL_ADDR.ViewValue = BusinessDetails.PAYPAL_ADDR.CurrentValue
			BusinessDetails.PAYPAL_ADDR.ViewCustomAttributes = ""

			' nochex
			BusinessDetails.nochex.ViewValue = BusinessDetails.nochex.CurrentValue
			BusinessDetails.nochex.ViewCustomAttributes = ""

			' nochexmerchantid
			BusinessDetails.nochexmerchantid.ViewValue = BusinessDetails.nochexmerchantid.CurrentValue
			BusinessDetails.nochexmerchantid.ViewCustomAttributes = ""

			' paypal
			BusinessDetails.paypal.ViewValue = BusinessDetails.paypal.CurrentValue
			BusinessDetails.paypal.ViewCustomAttributes = ""

			' IBT_API_KEY
			BusinessDetails.IBT_API_KEY.ViewValue = BusinessDetails.IBT_API_KEY.CurrentValue
			BusinessDetails.IBT_API_KEY.ViewCustomAttributes = ""

			' IBP_API_PASSWORD
			BusinessDetails.IBP_API_PASSWORD.ViewValue = BusinessDetails.IBP_API_PASSWORD.CurrentValue
			BusinessDetails.IBP_API_PASSWORD.ViewCustomAttributes = ""

			' disable_delivery
			BusinessDetails.disable_delivery.ViewValue = BusinessDetails.disable_delivery.CurrentValue
			BusinessDetails.disable_delivery.ViewCustomAttributes = ""

			' disable_collection
			BusinessDetails.disable_collection.ViewValue = BusinessDetails.disable_collection.CurrentValue
			BusinessDetails.disable_collection.ViewCustomAttributes = ""

			' worldpay
			BusinessDetails.worldpay.ViewValue = BusinessDetails.worldpay.CurrentValue
			BusinessDetails.worldpay.ViewCustomAttributes = ""

			' worldpaymerchantid
			BusinessDetails.worldpaymerchantid.ViewValue = BusinessDetails.worldpaymerchantid.CurrentValue
			BusinessDetails.worldpaymerchantid.ViewCustomAttributes = ""

			' DeliveryChargeOverrideByOrderValue
			BusinessDetails.DeliveryChargeOverrideByOrderValue.ViewValue = BusinessDetails.DeliveryChargeOverrideByOrderValue.CurrentValue
			BusinessDetails.DeliveryChargeOverrideByOrderValue.ViewCustomAttributes = ""

			' individualpostcodeschecking
			BusinessDetails.individualpostcodeschecking.ViewValue = BusinessDetails.individualpostcodeschecking.CurrentValue
			BusinessDetails.individualpostcodeschecking.ViewCustomAttributes = ""

			' longitude
			BusinessDetails.longitude.ViewValue = BusinessDetails.longitude.CurrentValue
			BusinessDetails.longitude.ViewCustomAttributes = ""

			' latitude
			BusinessDetails.latitude.ViewValue = BusinessDetails.latitude.CurrentValue
			BusinessDetails.latitude.ViewCustomAttributes = ""

			' googleecommercetracking
			BusinessDetails.googleecommercetracking.ViewValue = BusinessDetails.googleecommercetracking.CurrentValue
			BusinessDetails.googleecommercetracking.ViewCustomAttributes = ""

			' googleecommercetrackingcode
			BusinessDetails.googleecommercetrackingcode.ViewValue = BusinessDetails.googleecommercetrackingcode.CurrentValue
			BusinessDetails.googleecommercetrackingcode.ViewCustomAttributes = ""

			' bringg
			BusinessDetails.bringg.ViewValue = BusinessDetails.bringg.CurrentValue
			BusinessDetails.bringg.ViewCustomAttributes = ""

			' bringgurl
			BusinessDetails.bringgurl.ViewValue = BusinessDetails.bringgurl.CurrentValue
			BusinessDetails.bringgurl.ViewCustomAttributes = ""

			' bringgcompanyid
			BusinessDetails.bringgcompanyid.ViewValue = BusinessDetails.bringgcompanyid.CurrentValue
			BusinessDetails.bringgcompanyid.ViewCustomAttributes = ""

			' orderonlywhenopen
			BusinessDetails.orderonlywhenopen.ViewValue = BusinessDetails.orderonlywhenopen.CurrentValue
			BusinessDetails.orderonlywhenopen.ViewCustomAttributes = ""

			' disablelaterdelivery
			BusinessDetails.disablelaterdelivery.ViewValue = BusinessDetails.disablelaterdelivery.CurrentValue
			BusinessDetails.disablelaterdelivery.ViewCustomAttributes = ""

			' ordertodayonly
			BusinessDetails.ordertodayonly.ViewValue = BusinessDetails.ordertodayonly.CurrentValue
			BusinessDetails.ordertodayonly.ViewCustomAttributes = ""

			' mileskm
			BusinessDetails.mileskm.ViewValue = BusinessDetails.mileskm.CurrentValue
			BusinessDetails.mileskm.ViewCustomAttributes = ""

			' worldpaylive
			BusinessDetails.worldpaylive.ViewValue = BusinessDetails.worldpaylive.CurrentValue
			BusinessDetails.worldpaylive.ViewCustomAttributes = ""

			' worldpayinstallationid
			BusinessDetails.worldpayinstallationid.ViewValue = BusinessDetails.worldpayinstallationid.CurrentValue
			BusinessDetails.worldpayinstallationid.ViewCustomAttributes = ""

			' DistanceCalMethod
			BusinessDetails.DistanceCalMethod.ViewValue = BusinessDetails.DistanceCalMethod.CurrentValue
			BusinessDetails.DistanceCalMethod.ViewCustomAttributes = ""

			' PrinterIDList
			BusinessDetails.PrinterIDList.ViewValue = BusinessDetails.PrinterIDList.CurrentValue
			BusinessDetails.PrinterIDList.ViewCustomAttributes = ""

			' EpsonJSPrinterURL
			BusinessDetails.EpsonJSPrinterURL.ViewValue = BusinessDetails.EpsonJSPrinterURL.CurrentValue
			BusinessDetails.EpsonJSPrinterURL.ViewCustomAttributes = ""

			' SMSEnable
			BusinessDetails.SMSEnable.ViewValue = BusinessDetails.SMSEnable.CurrentValue
			BusinessDetails.SMSEnable.ViewCustomAttributes = ""

			' SMSOnDelivery
			BusinessDetails.SMSOnDelivery.ViewValue = BusinessDetails.SMSOnDelivery.CurrentValue
			BusinessDetails.SMSOnDelivery.ViewCustomAttributes = ""

			' SMSSupplierDomain
			BusinessDetails.SMSSupplierDomain.ViewValue = BusinessDetails.SMSSupplierDomain.CurrentValue
			BusinessDetails.SMSSupplierDomain.ViewCustomAttributes = ""

			' SMSOnOrder
			BusinessDetails.SMSOnOrder.ViewValue = BusinessDetails.SMSOnOrder.CurrentValue
			BusinessDetails.SMSOnOrder.ViewCustomAttributes = ""

			' SMSOnOrderAfterMin
			BusinessDetails.SMSOnOrderAfterMin.ViewValue = BusinessDetails.SMSOnOrderAfterMin.CurrentValue
			BusinessDetails.SMSOnOrderAfterMin.ViewCustomAttributes = ""

			' SMSOnOrderContent
			BusinessDetails.SMSOnOrderContent.ViewValue = BusinessDetails.SMSOnOrderContent.CurrentValue
			BusinessDetails.SMSOnOrderContent.ViewCustomAttributes = ""

			' DefaultSMSCountryCode
			BusinessDetails.DefaultSMSCountryCode.ViewValue = BusinessDetails.DefaultSMSCountryCode.CurrentValue
			BusinessDetails.DefaultSMSCountryCode.ViewCustomAttributes = ""

			' MinimumAmountForCardPayment
			BusinessDetails.MinimumAmountForCardPayment.ViewValue = BusinessDetails.MinimumAmountForCardPayment.CurrentValue
			BusinessDetails.MinimumAmountForCardPayment.ViewCustomAttributes = ""

			' FavIconUrl
			BusinessDetails.FavIconUrl.ViewValue = BusinessDetails.FavIconUrl.CurrentValue
			BusinessDetails.FavIconUrl.ViewCustomAttributes = ""

			' AddToHomeScreenURL
			BusinessDetails.AddToHomeScreenURL.ViewValue = BusinessDetails.AddToHomeScreenURL.CurrentValue
			BusinessDetails.AddToHomeScreenURL.ViewCustomAttributes = ""

			' SMSOnAcknowledgement
			BusinessDetails.SMSOnAcknowledgement.ViewValue = BusinessDetails.SMSOnAcknowledgement.CurrentValue
			BusinessDetails.SMSOnAcknowledgement.ViewCustomAttributes = ""

			' LocalPrinterURL
			BusinessDetails.LocalPrinterURL.ViewValue = BusinessDetails.LocalPrinterURL.CurrentValue
			BusinessDetails.LocalPrinterURL.ViewCustomAttributes = ""

			' ShowRestaurantDetailOnReceipt
			BusinessDetails.ShowRestaurantDetailOnReceipt.ViewValue = BusinessDetails.ShowRestaurantDetailOnReceipt.CurrentValue
			BusinessDetails.ShowRestaurantDetailOnReceipt.ViewCustomAttributes = ""

			' PrinterFontSizeRatio
			BusinessDetails.PrinterFontSizeRatio.ViewValue = BusinessDetails.PrinterFontSizeRatio.CurrentValue
			BusinessDetails.PrinterFontSizeRatio.ViewCustomAttributes = ""

			' ServiceChargePercentage
			BusinessDetails.ServiceChargePercentage.ViewValue = BusinessDetails.ServiceChargePercentage.CurrentValue
			BusinessDetails.ServiceChargePercentage.ViewCustomAttributes = ""

			' InRestaurantServiceChargeOnly
			BusinessDetails.InRestaurantServiceChargeOnly.ViewValue = BusinessDetails.InRestaurantServiceChargeOnly.CurrentValue
			BusinessDetails.InRestaurantServiceChargeOnly.ViewCustomAttributes = ""

			' IsDualReceiptPrinting
			BusinessDetails.IsDualReceiptPrinting.ViewValue = BusinessDetails.IsDualReceiptPrinting.CurrentValue
			BusinessDetails.IsDualReceiptPrinting.ViewCustomAttributes = ""

			' PrintingFontSize
			BusinessDetails.PrintingFontSize.ViewValue = BusinessDetails.PrintingFontSize.CurrentValue
			BusinessDetails.PrintingFontSize.ViewCustomAttributes = ""

			' InRestaurantEpsonPrinterIDList
			BusinessDetails.InRestaurantEpsonPrinterIDList.ViewValue = BusinessDetails.InRestaurantEpsonPrinterIDList.CurrentValue
			BusinessDetails.InRestaurantEpsonPrinterIDList.ViewCustomAttributes = ""

			' BlockIPEmailList
			BusinessDetails.BlockIPEmailList.ViewValue = BusinessDetails.BlockIPEmailList.CurrentValue
			BusinessDetails.BlockIPEmailList.ViewCustomAttributes = ""

			' RePrintReceiptWays
			BusinessDetails.RePrintReceiptWays.ViewValue = BusinessDetails.RePrintReceiptWays.CurrentValue
			BusinessDetails.RePrintReceiptWays.ViewCustomAttributes = ""

			' printingtype
			BusinessDetails.printingtype.ViewValue = BusinessDetails.printingtype.CurrentValue
			BusinessDetails.printingtype.ViewCustomAttributes = ""

			' Stripe_Key_Secret
			BusinessDetails.Stripe_Key_Secret.ViewValue = BusinessDetails.Stripe_Key_Secret.CurrentValue
			BusinessDetails.Stripe_Key_Secret.ViewCustomAttributes = ""

			' Stripe
			BusinessDetails.Stripe.ViewValue = BusinessDetails.Stripe.CurrentValue
			BusinessDetails.Stripe.ViewCustomAttributes = ""

			' Stripe_Api_Key
			BusinessDetails.Stripe_Api_Key.ViewValue = BusinessDetails.Stripe_Api_Key.CurrentValue
			BusinessDetails.Stripe_Api_Key.ViewCustomAttributes = ""

			' EnableBooking
			BusinessDetails.EnableBooking.ViewValue = BusinessDetails.EnableBooking.CurrentValue
			BusinessDetails.EnableBooking.ViewCustomAttributes = ""

			' URL_Facebook
			BusinessDetails.URL_Facebook.ViewValue = BusinessDetails.URL_Facebook.CurrentValue
			BusinessDetails.URL_Facebook.ViewCustomAttributes = ""

			' URL_Twitter
			BusinessDetails.URL_Twitter.ViewValue = BusinessDetails.URL_Twitter.CurrentValue
			BusinessDetails.URL_Twitter.ViewCustomAttributes = ""

			' URL_Google
			BusinessDetails.URL_Google.ViewValue = BusinessDetails.URL_Google.CurrentValue
			BusinessDetails.URL_Google.ViewCustomAttributes = ""

			' URL_Intagram
			BusinessDetails.URL_Intagram.ViewValue = BusinessDetails.URL_Intagram.CurrentValue
			BusinessDetails.URL_Intagram.ViewCustomAttributes = ""

			' URL_YouTube
			BusinessDetails.URL_YouTube.ViewValue = BusinessDetails.URL_YouTube.CurrentValue
			BusinessDetails.URL_YouTube.ViewCustomAttributes = ""

			' URL_Tripadvisor
			BusinessDetails.URL_Tripadvisor.ViewValue = BusinessDetails.URL_Tripadvisor.CurrentValue
			BusinessDetails.URL_Tripadvisor.ViewCustomAttributes = ""

			' URL_Special_Offer
			BusinessDetails.URL_Special_Offer.ViewValue = BusinessDetails.URL_Special_Offer.CurrentValue
			BusinessDetails.URL_Special_Offer.ViewCustomAttributes = ""

			' URL_Linkin
			BusinessDetails.URL_Linkin.ViewValue = BusinessDetails.URL_Linkin.CurrentValue
			BusinessDetails.URL_Linkin.ViewCustomAttributes = ""

			' Currency_PAYPAL
			BusinessDetails.Currency_PAYPAL.ViewValue = BusinessDetails.Currency_PAYPAL.CurrentValue
			BusinessDetails.Currency_PAYPAL.ViewCustomAttributes = ""

			' Currency_STRIPE
			BusinessDetails.Currency_STRIPE.ViewValue = BusinessDetails.Currency_STRIPE.CurrentValue
			BusinessDetails.Currency_STRIPE.ViewCustomAttributes = ""

			' Currency_WOLRDPAY
			BusinessDetails.Currency_WOLRDPAY.ViewValue = BusinessDetails.Currency_WOLRDPAY.CurrentValue
			BusinessDetails.Currency_WOLRDPAY.ViewCustomAttributes = ""

			' Tip_percent
			BusinessDetails.Tip_percent.ViewValue = BusinessDetails.Tip_percent.CurrentValue
			BusinessDetails.Tip_percent.ViewCustomAttributes = ""

			' Tax_Percent
			BusinessDetails.Tax_Percent.ViewValue = BusinessDetails.Tax_Percent.CurrentValue
			BusinessDetails.Tax_Percent.ViewCustomAttributes = ""

			' InRestaurantTaxChargeOnly
			BusinessDetails.InRestaurantTaxChargeOnly.ViewValue = BusinessDetails.InRestaurantTaxChargeOnly.CurrentValue
			BusinessDetails.InRestaurantTaxChargeOnly.ViewCustomAttributes = ""

			' InRestaurantTipChargeOnly
			BusinessDetails.InRestaurantTipChargeOnly.ViewValue = BusinessDetails.InRestaurantTipChargeOnly.CurrentValue
			BusinessDetails.InRestaurantTipChargeOnly.ViewCustomAttributes = ""

			' isCheckCapcha
			BusinessDetails.isCheckCapcha.ViewValue = BusinessDetails.isCheckCapcha.CurrentValue
			BusinessDetails.isCheckCapcha.ViewCustomAttributes = ""

			' Close_StartDate
			BusinessDetails.Close_StartDate.ViewValue = BusinessDetails.Close_StartDate.CurrentValue
			BusinessDetails.Close_StartDate.ViewCustomAttributes = ""

			' Close_EndDate
			BusinessDetails.Close_EndDate.ViewValue = BusinessDetails.Close_EndDate.CurrentValue
			BusinessDetails.Close_EndDate.ViewCustomAttributes = ""

			' Stripe_Country
			BusinessDetails.Stripe_Country.ViewValue = BusinessDetails.Stripe_Country.CurrentValue
			BusinessDetails.Stripe_Country.ViewCustomAttributes = ""

			' enable_StripePaymentButton
			BusinessDetails.enable_StripePaymentButton.ViewValue = BusinessDetails.enable_StripePaymentButton.CurrentValue
			BusinessDetails.enable_StripePaymentButton.ViewCustomAttributes = ""

			' enable_CashPayment
			BusinessDetails.enable_CashPayment.ViewValue = BusinessDetails.enable_CashPayment.CurrentValue
			BusinessDetails.enable_CashPayment.ViewCustomAttributes = ""

			' DeliveryMile
			BusinessDetails.DeliveryMile.ViewValue = BusinessDetails.DeliveryMile.CurrentValue
			BusinessDetails.DeliveryMile.ViewCustomAttributes = ""

			' Mon_Delivery
			BusinessDetails.Mon_Delivery.ViewValue = BusinessDetails.Mon_Delivery.CurrentValue
			BusinessDetails.Mon_Delivery.ViewCustomAttributes = ""

			' Mon_Collection
			BusinessDetails.Mon_Collection.ViewValue = BusinessDetails.Mon_Collection.CurrentValue
			BusinessDetails.Mon_Collection.ViewCustomAttributes = ""

			' Tue_Delivery
			BusinessDetails.Tue_Delivery.ViewValue = BusinessDetails.Tue_Delivery.CurrentValue
			BusinessDetails.Tue_Delivery.ViewCustomAttributes = ""

			' Tue_Collection
			BusinessDetails.Tue_Collection.ViewValue = BusinessDetails.Tue_Collection.CurrentValue
			BusinessDetails.Tue_Collection.ViewCustomAttributes = ""

			' Wed_Delivery
			BusinessDetails.Wed_Delivery.ViewValue = BusinessDetails.Wed_Delivery.CurrentValue
			BusinessDetails.Wed_Delivery.ViewCustomAttributes = ""

			' Wed_Collection
			BusinessDetails.Wed_Collection.ViewValue = BusinessDetails.Wed_Collection.CurrentValue
			BusinessDetails.Wed_Collection.ViewCustomAttributes = ""

			' Thu_Delivery
			BusinessDetails.Thu_Delivery.ViewValue = BusinessDetails.Thu_Delivery.CurrentValue
			BusinessDetails.Thu_Delivery.ViewCustomAttributes = ""

			' Thu_Collection
			BusinessDetails.Thu_Collection.ViewValue = BusinessDetails.Thu_Collection.CurrentValue
			BusinessDetails.Thu_Collection.ViewCustomAttributes = ""

			' Fri_Delivery
			BusinessDetails.Fri_Delivery.ViewValue = BusinessDetails.Fri_Delivery.CurrentValue
			BusinessDetails.Fri_Delivery.ViewCustomAttributes = ""

			' Fri_Collection
			BusinessDetails.Fri_Collection.ViewValue = BusinessDetails.Fri_Collection.CurrentValue
			BusinessDetails.Fri_Collection.ViewCustomAttributes = ""

			' Sat_Delivery
			BusinessDetails.Sat_Delivery.ViewValue = BusinessDetails.Sat_Delivery.CurrentValue
			BusinessDetails.Sat_Delivery.ViewCustomAttributes = ""

			' Sat_Collection
			BusinessDetails.Sat_Collection.ViewValue = BusinessDetails.Sat_Collection.CurrentValue
			BusinessDetails.Sat_Collection.ViewCustomAttributes = ""

			' Sun_Delivery
			BusinessDetails.Sun_Delivery.ViewValue = BusinessDetails.Sun_Delivery.CurrentValue
			BusinessDetails.Sun_Delivery.ViewCustomAttributes = ""

			' Sun_Collection
			BusinessDetails.Sun_Collection.ViewValue = BusinessDetails.Sun_Collection.CurrentValue
			BusinessDetails.Sun_Collection.ViewCustomAttributes = ""

			' EnableUrlRewrite
			BusinessDetails.EnableUrlRewrite.ViewValue = BusinessDetails.EnableUrlRewrite.CurrentValue
			BusinessDetails.EnableUrlRewrite.ViewCustomAttributes = ""

			' DeliveryCostUpTo
			BusinessDetails.DeliveryCostUpTo.ViewValue = BusinessDetails.DeliveryCostUpTo.CurrentValue
			BusinessDetails.DeliveryCostUpTo.ViewCustomAttributes = ""

			' DeliveryUptoMile
			BusinessDetails.DeliveryUptoMile.ViewValue = BusinessDetails.DeliveryUptoMile.CurrentValue
			BusinessDetails.DeliveryUptoMile.ViewCustomAttributes = ""

			' Show_Ordernumner_printer
			BusinessDetails.Show_Ordernumner_printer.ViewValue = BusinessDetails.Show_Ordernumner_printer.CurrentValue
			BusinessDetails.Show_Ordernumner_printer.ViewCustomAttributes = ""

			' Show_Ordernumner_Receipt
			BusinessDetails.Show_Ordernumner_Receipt.ViewValue = BusinessDetails.Show_Ordernumner_Receipt.CurrentValue
			BusinessDetails.Show_Ordernumner_Receipt.ViewCustomAttributes = ""

			' Show_Ordernumner_Dashboard
			BusinessDetails.Show_Ordernumner_Dashboard.ViewValue = BusinessDetails.Show_Ordernumner_Dashboard.CurrentValue
			BusinessDetails.Show_Ordernumner_Dashboard.ViewCustomAttributes = ""

			' View refer script
			' ID

			BusinessDetails.ID.LinkCustomAttributes = ""
			BusinessDetails.ID.HrefValue = ""
			BusinessDetails.ID.TooltipValue = ""

			' Name
			BusinessDetails.Name.LinkCustomAttributes = ""
			BusinessDetails.Name.HrefValue = ""
			BusinessDetails.Name.TooltipValue = ""

			' Address
			BusinessDetails.Address.LinkCustomAttributes = ""
			BusinessDetails.Address.HrefValue = ""
			BusinessDetails.Address.TooltipValue = ""

			' PostalCode
			BusinessDetails.PostalCode.LinkCustomAttributes = ""
			BusinessDetails.PostalCode.HrefValue = ""
			BusinessDetails.PostalCode.TooltipValue = ""

			' FoodType
			BusinessDetails.FoodType.LinkCustomAttributes = ""
			BusinessDetails.FoodType.HrefValue = ""
			BusinessDetails.FoodType.TooltipValue = ""

			' DeliveryMinAmount
			BusinessDetails.DeliveryMinAmount.LinkCustomAttributes = ""
			BusinessDetails.DeliveryMinAmount.HrefValue = ""
			BusinessDetails.DeliveryMinAmount.TooltipValue = ""

			' DeliveryMaxDistance
			BusinessDetails.DeliveryMaxDistance.LinkCustomAttributes = ""
			BusinessDetails.DeliveryMaxDistance.HrefValue = ""
			BusinessDetails.DeliveryMaxDistance.TooltipValue = ""

			' DeliveryFreeDistance
			BusinessDetails.DeliveryFreeDistance.LinkCustomAttributes = ""
			BusinessDetails.DeliveryFreeDistance.HrefValue = ""
			BusinessDetails.DeliveryFreeDistance.TooltipValue = ""

			' AverageDeliveryTime
			BusinessDetails.AverageDeliveryTime.LinkCustomAttributes = ""
			BusinessDetails.AverageDeliveryTime.HrefValue = ""
			BusinessDetails.AverageDeliveryTime.TooltipValue = ""

			' AverageCollectionTime
			BusinessDetails.AverageCollectionTime.LinkCustomAttributes = ""
			BusinessDetails.AverageCollectionTime.HrefValue = ""
			BusinessDetails.AverageCollectionTime.TooltipValue = ""

			' DeliveryFee
			BusinessDetails.DeliveryFee.LinkCustomAttributes = ""
			BusinessDetails.DeliveryFee.HrefValue = ""
			BusinessDetails.DeliveryFee.TooltipValue = ""

			' ImgUrl
			BusinessDetails.ImgUrl.LinkCustomAttributes = ""
			BusinessDetails.ImgUrl.HrefValue = ""
			BusinessDetails.ImgUrl.TooltipValue = ""

			' Telephone
			BusinessDetails.Telephone.LinkCustomAttributes = ""
			BusinessDetails.Telephone.HrefValue = ""
			BusinessDetails.Telephone.TooltipValue = ""

			' Email
			BusinessDetails.zEmail.LinkCustomAttributes = ""
			BusinessDetails.zEmail.HrefValue = ""
			BusinessDetails.zEmail.TooltipValue = ""

			' pswd
			BusinessDetails.pswd.LinkCustomAttributes = ""
			BusinessDetails.pswd.HrefValue = ""
			BusinessDetails.pswd.TooltipValue = ""

			' businessclosed
			BusinessDetails.businessclosed.LinkCustomAttributes = ""
			BusinessDetails.businessclosed.HrefValue = ""
			BusinessDetails.businessclosed.TooltipValue = ""

			' SMTP_AUTENTICATE
			BusinessDetails.SMTP_AUTENTICATE.LinkCustomAttributes = ""
			BusinessDetails.SMTP_AUTENTICATE.HrefValue = ""
			BusinessDetails.SMTP_AUTENTICATE.TooltipValue = ""

			' MAIL_FROM
			BusinessDetails.MAIL_FROM.LinkCustomAttributes = ""
			BusinessDetails.MAIL_FROM.HrefValue = ""
			BusinessDetails.MAIL_FROM.TooltipValue = ""

			' PAYPAL_URL
			BusinessDetails.PAYPAL_URL.LinkCustomAttributes = ""
			BusinessDetails.PAYPAL_URL.HrefValue = ""
			BusinessDetails.PAYPAL_URL.TooltipValue = ""

			' PAYPAL_PDT
			BusinessDetails.PAYPAL_PDT.LinkCustomAttributes = ""
			BusinessDetails.PAYPAL_PDT.HrefValue = ""
			BusinessDetails.PAYPAL_PDT.TooltipValue = ""

			' SMTP_PASSWORD
			BusinessDetails.SMTP_PASSWORD.LinkCustomAttributes = ""
			BusinessDetails.SMTP_PASSWORD.HrefValue = ""
			BusinessDetails.SMTP_PASSWORD.TooltipValue = ""

			' GMAP_API_KEY
			BusinessDetails.GMAP_API_KEY.LinkCustomAttributes = ""
			BusinessDetails.GMAP_API_KEY.HrefValue = ""
			BusinessDetails.GMAP_API_KEY.TooltipValue = ""

			' SMTP_USERNAME
			BusinessDetails.SMTP_USERNAME.LinkCustomAttributes = ""
			BusinessDetails.SMTP_USERNAME.HrefValue = ""
			BusinessDetails.SMTP_USERNAME.TooltipValue = ""

			' SMTP_USESSL
			BusinessDetails.SMTP_USESSL.LinkCustomAttributes = ""
			BusinessDetails.SMTP_USESSL.HrefValue = ""
			BusinessDetails.SMTP_USESSL.TooltipValue = ""

			' MAIL_SUBJECT
			BusinessDetails.MAIL_SUBJECT.LinkCustomAttributes = ""
			BusinessDetails.MAIL_SUBJECT.HrefValue = ""
			BusinessDetails.MAIL_SUBJECT.TooltipValue = ""

			' CURRENCYSYMBOL
			BusinessDetails.CURRENCYSYMBOL.LinkCustomAttributes = ""
			BusinessDetails.CURRENCYSYMBOL.HrefValue = ""
			BusinessDetails.CURRENCYSYMBOL.TooltipValue = ""

			' SMTP_SERVER
			BusinessDetails.SMTP_SERVER.LinkCustomAttributes = ""
			BusinessDetails.SMTP_SERVER.HrefValue = ""
			BusinessDetails.SMTP_SERVER.TooltipValue = ""

			' CREDITCARDSURCHARGE
			BusinessDetails.CREDITCARDSURCHARGE.LinkCustomAttributes = ""
			BusinessDetails.CREDITCARDSURCHARGE.HrefValue = ""
			BusinessDetails.CREDITCARDSURCHARGE.TooltipValue = ""

			' SMTP_PORT
			BusinessDetails.SMTP_PORT.LinkCustomAttributes = ""
			BusinessDetails.SMTP_PORT.HrefValue = ""
			BusinessDetails.SMTP_PORT.TooltipValue = ""

			' STICK_MENU
			BusinessDetails.STICK_MENU.LinkCustomAttributes = ""
			BusinessDetails.STICK_MENU.HrefValue = ""
			BusinessDetails.STICK_MENU.TooltipValue = ""

			' MAIL_CUSTOMER_SUBJECT
			BusinessDetails.MAIL_CUSTOMER_SUBJECT.LinkCustomAttributes = ""
			BusinessDetails.MAIL_CUSTOMER_SUBJECT.HrefValue = ""
			BusinessDetails.MAIL_CUSTOMER_SUBJECT.TooltipValue = ""

			' CONFIRMATION_EMAIL_ADDRESS
			BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.LinkCustomAttributes = ""
			BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.HrefValue = ""
			BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.TooltipValue = ""

			' SEND_ORDERS_TO_PRINTER
			BusinessDetails.SEND_ORDERS_TO_PRINTER.LinkCustomAttributes = ""
			BusinessDetails.SEND_ORDERS_TO_PRINTER.HrefValue = ""
			BusinessDetails.SEND_ORDERS_TO_PRINTER.TooltipValue = ""

			' timezone
			BusinessDetails.timezone.LinkCustomAttributes = ""
			BusinessDetails.timezone.HrefValue = ""
			BusinessDetails.timezone.TooltipValue = ""

			' PAYPAL_ADDR
			BusinessDetails.PAYPAL_ADDR.LinkCustomAttributes = ""
			BusinessDetails.PAYPAL_ADDR.HrefValue = ""
			BusinessDetails.PAYPAL_ADDR.TooltipValue = ""

			' nochex
			BusinessDetails.nochex.LinkCustomAttributes = ""
			BusinessDetails.nochex.HrefValue = ""
			BusinessDetails.nochex.TooltipValue = ""

			' nochexmerchantid
			BusinessDetails.nochexmerchantid.LinkCustomAttributes = ""
			BusinessDetails.nochexmerchantid.HrefValue = ""
			BusinessDetails.nochexmerchantid.TooltipValue = ""

			' paypal
			BusinessDetails.paypal.LinkCustomAttributes = ""
			BusinessDetails.paypal.HrefValue = ""
			BusinessDetails.paypal.TooltipValue = ""

			' IBT_API_KEY
			BusinessDetails.IBT_API_KEY.LinkCustomAttributes = ""
			BusinessDetails.IBT_API_KEY.HrefValue = ""
			BusinessDetails.IBT_API_KEY.TooltipValue = ""

			' IBP_API_PASSWORD
			BusinessDetails.IBP_API_PASSWORD.LinkCustomAttributes = ""
			BusinessDetails.IBP_API_PASSWORD.HrefValue = ""
			BusinessDetails.IBP_API_PASSWORD.TooltipValue = ""

			' disable_delivery
			BusinessDetails.disable_delivery.LinkCustomAttributes = ""
			BusinessDetails.disable_delivery.HrefValue = ""
			BusinessDetails.disable_delivery.TooltipValue = ""

			' disable_collection
			BusinessDetails.disable_collection.LinkCustomAttributes = ""
			BusinessDetails.disable_collection.HrefValue = ""
			BusinessDetails.disable_collection.TooltipValue = ""

			' worldpay
			BusinessDetails.worldpay.LinkCustomAttributes = ""
			BusinessDetails.worldpay.HrefValue = ""
			BusinessDetails.worldpay.TooltipValue = ""

			' worldpaymerchantid
			BusinessDetails.worldpaymerchantid.LinkCustomAttributes = ""
			BusinessDetails.worldpaymerchantid.HrefValue = ""
			BusinessDetails.worldpaymerchantid.TooltipValue = ""

			' DeliveryChargeOverrideByOrderValue
			BusinessDetails.DeliveryChargeOverrideByOrderValue.LinkCustomAttributes = ""
			BusinessDetails.DeliveryChargeOverrideByOrderValue.HrefValue = ""
			BusinessDetails.DeliveryChargeOverrideByOrderValue.TooltipValue = ""

			' individualpostcodeschecking
			BusinessDetails.individualpostcodeschecking.LinkCustomAttributes = ""
			BusinessDetails.individualpostcodeschecking.HrefValue = ""
			BusinessDetails.individualpostcodeschecking.TooltipValue = ""

			' longitude
			BusinessDetails.longitude.LinkCustomAttributes = ""
			BusinessDetails.longitude.HrefValue = ""
			BusinessDetails.longitude.TooltipValue = ""

			' latitude
			BusinessDetails.latitude.LinkCustomAttributes = ""
			BusinessDetails.latitude.HrefValue = ""
			BusinessDetails.latitude.TooltipValue = ""

			' googleecommercetracking
			BusinessDetails.googleecommercetracking.LinkCustomAttributes = ""
			BusinessDetails.googleecommercetracking.HrefValue = ""
			BusinessDetails.googleecommercetracking.TooltipValue = ""

			' googleecommercetrackingcode
			BusinessDetails.googleecommercetrackingcode.LinkCustomAttributes = ""
			BusinessDetails.googleecommercetrackingcode.HrefValue = ""
			BusinessDetails.googleecommercetrackingcode.TooltipValue = ""

			' bringg
			BusinessDetails.bringg.LinkCustomAttributes = ""
			BusinessDetails.bringg.HrefValue = ""
			BusinessDetails.bringg.TooltipValue = ""

			' bringgurl
			BusinessDetails.bringgurl.LinkCustomAttributes = ""
			BusinessDetails.bringgurl.HrefValue = ""
			BusinessDetails.bringgurl.TooltipValue = ""

			' bringgcompanyid
			BusinessDetails.bringgcompanyid.LinkCustomAttributes = ""
			BusinessDetails.bringgcompanyid.HrefValue = ""
			BusinessDetails.bringgcompanyid.TooltipValue = ""

			' orderonlywhenopen
			BusinessDetails.orderonlywhenopen.LinkCustomAttributes = ""
			BusinessDetails.orderonlywhenopen.HrefValue = ""
			BusinessDetails.orderonlywhenopen.TooltipValue = ""

			' disablelaterdelivery
			BusinessDetails.disablelaterdelivery.LinkCustomAttributes = ""
			BusinessDetails.disablelaterdelivery.HrefValue = ""
			BusinessDetails.disablelaterdelivery.TooltipValue = ""

			' ordertodayonly
			BusinessDetails.ordertodayonly.LinkCustomAttributes = ""
			BusinessDetails.ordertodayonly.HrefValue = ""
			BusinessDetails.ordertodayonly.TooltipValue = ""

			' mileskm
			BusinessDetails.mileskm.LinkCustomAttributes = ""
			BusinessDetails.mileskm.HrefValue = ""
			BusinessDetails.mileskm.TooltipValue = ""

			' worldpaylive
			BusinessDetails.worldpaylive.LinkCustomAttributes = ""
			BusinessDetails.worldpaylive.HrefValue = ""
			BusinessDetails.worldpaylive.TooltipValue = ""

			' worldpayinstallationid
			BusinessDetails.worldpayinstallationid.LinkCustomAttributes = ""
			BusinessDetails.worldpayinstallationid.HrefValue = ""
			BusinessDetails.worldpayinstallationid.TooltipValue = ""

			' DistanceCalMethod
			BusinessDetails.DistanceCalMethod.LinkCustomAttributes = ""
			BusinessDetails.DistanceCalMethod.HrefValue = ""
			BusinessDetails.DistanceCalMethod.TooltipValue = ""

			' PrinterIDList
			BusinessDetails.PrinterIDList.LinkCustomAttributes = ""
			BusinessDetails.PrinterIDList.HrefValue = ""
			BusinessDetails.PrinterIDList.TooltipValue = ""

			' EpsonJSPrinterURL
			BusinessDetails.EpsonJSPrinterURL.LinkCustomAttributes = ""
			BusinessDetails.EpsonJSPrinterURL.HrefValue = ""
			BusinessDetails.EpsonJSPrinterURL.TooltipValue = ""

			' SMSEnable
			BusinessDetails.SMSEnable.LinkCustomAttributes = ""
			BusinessDetails.SMSEnable.HrefValue = ""
			BusinessDetails.SMSEnable.TooltipValue = ""

			' SMSOnDelivery
			BusinessDetails.SMSOnDelivery.LinkCustomAttributes = ""
			BusinessDetails.SMSOnDelivery.HrefValue = ""
			BusinessDetails.SMSOnDelivery.TooltipValue = ""

			' SMSSupplierDomain
			BusinessDetails.SMSSupplierDomain.LinkCustomAttributes = ""
			BusinessDetails.SMSSupplierDomain.HrefValue = ""
			BusinessDetails.SMSSupplierDomain.TooltipValue = ""

			' SMSOnOrder
			BusinessDetails.SMSOnOrder.LinkCustomAttributes = ""
			BusinessDetails.SMSOnOrder.HrefValue = ""
			BusinessDetails.SMSOnOrder.TooltipValue = ""

			' SMSOnOrderAfterMin
			BusinessDetails.SMSOnOrderAfterMin.LinkCustomAttributes = ""
			BusinessDetails.SMSOnOrderAfterMin.HrefValue = ""
			BusinessDetails.SMSOnOrderAfterMin.TooltipValue = ""

			' SMSOnOrderContent
			BusinessDetails.SMSOnOrderContent.LinkCustomAttributes = ""
			BusinessDetails.SMSOnOrderContent.HrefValue = ""
			BusinessDetails.SMSOnOrderContent.TooltipValue = ""

			' DefaultSMSCountryCode
			BusinessDetails.DefaultSMSCountryCode.LinkCustomAttributes = ""
			BusinessDetails.DefaultSMSCountryCode.HrefValue = ""
			BusinessDetails.DefaultSMSCountryCode.TooltipValue = ""

			' MinimumAmountForCardPayment
			BusinessDetails.MinimumAmountForCardPayment.LinkCustomAttributes = ""
			BusinessDetails.MinimumAmountForCardPayment.HrefValue = ""
			BusinessDetails.MinimumAmountForCardPayment.TooltipValue = ""

			' FavIconUrl
			BusinessDetails.FavIconUrl.LinkCustomAttributes = ""
			BusinessDetails.FavIconUrl.HrefValue = ""
			BusinessDetails.FavIconUrl.TooltipValue = ""

			' AddToHomeScreenURL
			BusinessDetails.AddToHomeScreenURL.LinkCustomAttributes = ""
			BusinessDetails.AddToHomeScreenURL.HrefValue = ""
			BusinessDetails.AddToHomeScreenURL.TooltipValue = ""

			' SMSOnAcknowledgement
			BusinessDetails.SMSOnAcknowledgement.LinkCustomAttributes = ""
			BusinessDetails.SMSOnAcknowledgement.HrefValue = ""
			BusinessDetails.SMSOnAcknowledgement.TooltipValue = ""

			' LocalPrinterURL
			BusinessDetails.LocalPrinterURL.LinkCustomAttributes = ""
			BusinessDetails.LocalPrinterURL.HrefValue = ""
			BusinessDetails.LocalPrinterURL.TooltipValue = ""

			' ShowRestaurantDetailOnReceipt
			BusinessDetails.ShowRestaurantDetailOnReceipt.LinkCustomAttributes = ""
			BusinessDetails.ShowRestaurantDetailOnReceipt.HrefValue = ""
			BusinessDetails.ShowRestaurantDetailOnReceipt.TooltipValue = ""

			' PrinterFontSizeRatio
			BusinessDetails.PrinterFontSizeRatio.LinkCustomAttributes = ""
			BusinessDetails.PrinterFontSizeRatio.HrefValue = ""
			BusinessDetails.PrinterFontSizeRatio.TooltipValue = ""

			' ServiceChargePercentage
			BusinessDetails.ServiceChargePercentage.LinkCustomAttributes = ""
			BusinessDetails.ServiceChargePercentage.HrefValue = ""
			BusinessDetails.ServiceChargePercentage.TooltipValue = ""

			' InRestaurantServiceChargeOnly
			BusinessDetails.InRestaurantServiceChargeOnly.LinkCustomAttributes = ""
			BusinessDetails.InRestaurantServiceChargeOnly.HrefValue = ""
			BusinessDetails.InRestaurantServiceChargeOnly.TooltipValue = ""

			' IsDualReceiptPrinting
			BusinessDetails.IsDualReceiptPrinting.LinkCustomAttributes = ""
			BusinessDetails.IsDualReceiptPrinting.HrefValue = ""
			BusinessDetails.IsDualReceiptPrinting.TooltipValue = ""

			' PrintingFontSize
			BusinessDetails.PrintingFontSize.LinkCustomAttributes = ""
			BusinessDetails.PrintingFontSize.HrefValue = ""
			BusinessDetails.PrintingFontSize.TooltipValue = ""

			' InRestaurantEpsonPrinterIDList
			BusinessDetails.InRestaurantEpsonPrinterIDList.LinkCustomAttributes = ""
			BusinessDetails.InRestaurantEpsonPrinterIDList.HrefValue = ""
			BusinessDetails.InRestaurantEpsonPrinterIDList.TooltipValue = ""

			' BlockIPEmailList
			BusinessDetails.BlockIPEmailList.LinkCustomAttributes = ""
			BusinessDetails.BlockIPEmailList.HrefValue = ""
			BusinessDetails.BlockIPEmailList.TooltipValue = ""

			' RePrintReceiptWays
			BusinessDetails.RePrintReceiptWays.LinkCustomAttributes = ""
			BusinessDetails.RePrintReceiptWays.HrefValue = ""
			BusinessDetails.RePrintReceiptWays.TooltipValue = ""

			' printingtype
			BusinessDetails.printingtype.LinkCustomAttributes = ""
			BusinessDetails.printingtype.HrefValue = ""
			BusinessDetails.printingtype.TooltipValue = ""

			' Stripe_Key_Secret
			BusinessDetails.Stripe_Key_Secret.LinkCustomAttributes = ""
			BusinessDetails.Stripe_Key_Secret.HrefValue = ""
			BusinessDetails.Stripe_Key_Secret.TooltipValue = ""

			' Stripe
			BusinessDetails.Stripe.LinkCustomAttributes = ""
			BusinessDetails.Stripe.HrefValue = ""
			BusinessDetails.Stripe.TooltipValue = ""

			' Stripe_Api_Key
			BusinessDetails.Stripe_Api_Key.LinkCustomAttributes = ""
			BusinessDetails.Stripe_Api_Key.HrefValue = ""
			BusinessDetails.Stripe_Api_Key.TooltipValue = ""

			' EnableBooking
			BusinessDetails.EnableBooking.LinkCustomAttributes = ""
			BusinessDetails.EnableBooking.HrefValue = ""
			BusinessDetails.EnableBooking.TooltipValue = ""

			' URL_Facebook
			BusinessDetails.URL_Facebook.LinkCustomAttributes = ""
			BusinessDetails.URL_Facebook.HrefValue = ""
			BusinessDetails.URL_Facebook.TooltipValue = ""

			' URL_Twitter
			BusinessDetails.URL_Twitter.LinkCustomAttributes = ""
			BusinessDetails.URL_Twitter.HrefValue = ""
			BusinessDetails.URL_Twitter.TooltipValue = ""

			' URL_Google
			BusinessDetails.URL_Google.LinkCustomAttributes = ""
			BusinessDetails.URL_Google.HrefValue = ""
			BusinessDetails.URL_Google.TooltipValue = ""

			' URL_Intagram
			BusinessDetails.URL_Intagram.LinkCustomAttributes = ""
			BusinessDetails.URL_Intagram.HrefValue = ""
			BusinessDetails.URL_Intagram.TooltipValue = ""

			' URL_YouTube
			BusinessDetails.URL_YouTube.LinkCustomAttributes = ""
			BusinessDetails.URL_YouTube.HrefValue = ""
			BusinessDetails.URL_YouTube.TooltipValue = ""

			' URL_Tripadvisor
			BusinessDetails.URL_Tripadvisor.LinkCustomAttributes = ""
			BusinessDetails.URL_Tripadvisor.HrefValue = ""
			BusinessDetails.URL_Tripadvisor.TooltipValue = ""

			' URL_Special_Offer
			BusinessDetails.URL_Special_Offer.LinkCustomAttributes = ""
			BusinessDetails.URL_Special_Offer.HrefValue = ""
			BusinessDetails.URL_Special_Offer.TooltipValue = ""

			' URL_Linkin
			BusinessDetails.URL_Linkin.LinkCustomAttributes = ""
			BusinessDetails.URL_Linkin.HrefValue = ""
			BusinessDetails.URL_Linkin.TooltipValue = ""

			' Currency_PAYPAL
			BusinessDetails.Currency_PAYPAL.LinkCustomAttributes = ""
			BusinessDetails.Currency_PAYPAL.HrefValue = ""
			BusinessDetails.Currency_PAYPAL.TooltipValue = ""

			' Currency_STRIPE
			BusinessDetails.Currency_STRIPE.LinkCustomAttributes = ""
			BusinessDetails.Currency_STRIPE.HrefValue = ""
			BusinessDetails.Currency_STRIPE.TooltipValue = ""

			' Currency_WOLRDPAY
			BusinessDetails.Currency_WOLRDPAY.LinkCustomAttributes = ""
			BusinessDetails.Currency_WOLRDPAY.HrefValue = ""
			BusinessDetails.Currency_WOLRDPAY.TooltipValue = ""

			' Tip_percent
			BusinessDetails.Tip_percent.LinkCustomAttributes = ""
			BusinessDetails.Tip_percent.HrefValue = ""
			BusinessDetails.Tip_percent.TooltipValue = ""

			' Tax_Percent
			BusinessDetails.Tax_Percent.LinkCustomAttributes = ""
			BusinessDetails.Tax_Percent.HrefValue = ""
			BusinessDetails.Tax_Percent.TooltipValue = ""

			' InRestaurantTaxChargeOnly
			BusinessDetails.InRestaurantTaxChargeOnly.LinkCustomAttributes = ""
			BusinessDetails.InRestaurantTaxChargeOnly.HrefValue = ""
			BusinessDetails.InRestaurantTaxChargeOnly.TooltipValue = ""

			' InRestaurantTipChargeOnly
			BusinessDetails.InRestaurantTipChargeOnly.LinkCustomAttributes = ""
			BusinessDetails.InRestaurantTipChargeOnly.HrefValue = ""
			BusinessDetails.InRestaurantTipChargeOnly.TooltipValue = ""

			' isCheckCapcha
			BusinessDetails.isCheckCapcha.LinkCustomAttributes = ""
			BusinessDetails.isCheckCapcha.HrefValue = ""
			BusinessDetails.isCheckCapcha.TooltipValue = ""

			' Close_StartDate
			BusinessDetails.Close_StartDate.LinkCustomAttributes = ""
			BusinessDetails.Close_StartDate.HrefValue = ""
			BusinessDetails.Close_StartDate.TooltipValue = ""

			' Close_EndDate
			BusinessDetails.Close_EndDate.LinkCustomAttributes = ""
			BusinessDetails.Close_EndDate.HrefValue = ""
			BusinessDetails.Close_EndDate.TooltipValue = ""

			' Stripe_Country
			BusinessDetails.Stripe_Country.LinkCustomAttributes = ""
			BusinessDetails.Stripe_Country.HrefValue = ""
			BusinessDetails.Stripe_Country.TooltipValue = ""

			' enable_StripePaymentButton
			BusinessDetails.enable_StripePaymentButton.LinkCustomAttributes = ""
			BusinessDetails.enable_StripePaymentButton.HrefValue = ""
			BusinessDetails.enable_StripePaymentButton.TooltipValue = ""

			' enable_CashPayment
			BusinessDetails.enable_CashPayment.LinkCustomAttributes = ""
			BusinessDetails.enable_CashPayment.HrefValue = ""
			BusinessDetails.enable_CashPayment.TooltipValue = ""

			' DeliveryMile
			BusinessDetails.DeliveryMile.LinkCustomAttributes = ""
			BusinessDetails.DeliveryMile.HrefValue = ""
			BusinessDetails.DeliveryMile.TooltipValue = ""

			' Mon_Delivery
			BusinessDetails.Mon_Delivery.LinkCustomAttributes = ""
			BusinessDetails.Mon_Delivery.HrefValue = ""
			BusinessDetails.Mon_Delivery.TooltipValue = ""

			' Mon_Collection
			BusinessDetails.Mon_Collection.LinkCustomAttributes = ""
			BusinessDetails.Mon_Collection.HrefValue = ""
			BusinessDetails.Mon_Collection.TooltipValue = ""

			' Tue_Delivery
			BusinessDetails.Tue_Delivery.LinkCustomAttributes = ""
			BusinessDetails.Tue_Delivery.HrefValue = ""
			BusinessDetails.Tue_Delivery.TooltipValue = ""

			' Tue_Collection
			BusinessDetails.Tue_Collection.LinkCustomAttributes = ""
			BusinessDetails.Tue_Collection.HrefValue = ""
			BusinessDetails.Tue_Collection.TooltipValue = ""

			' Wed_Delivery
			BusinessDetails.Wed_Delivery.LinkCustomAttributes = ""
			BusinessDetails.Wed_Delivery.HrefValue = ""
			BusinessDetails.Wed_Delivery.TooltipValue = ""

			' Wed_Collection
			BusinessDetails.Wed_Collection.LinkCustomAttributes = ""
			BusinessDetails.Wed_Collection.HrefValue = ""
			BusinessDetails.Wed_Collection.TooltipValue = ""

			' Thu_Delivery
			BusinessDetails.Thu_Delivery.LinkCustomAttributes = ""
			BusinessDetails.Thu_Delivery.HrefValue = ""
			BusinessDetails.Thu_Delivery.TooltipValue = ""

			' Thu_Collection
			BusinessDetails.Thu_Collection.LinkCustomAttributes = ""
			BusinessDetails.Thu_Collection.HrefValue = ""
			BusinessDetails.Thu_Collection.TooltipValue = ""

			' Fri_Delivery
			BusinessDetails.Fri_Delivery.LinkCustomAttributes = ""
			BusinessDetails.Fri_Delivery.HrefValue = ""
			BusinessDetails.Fri_Delivery.TooltipValue = ""

			' Fri_Collection
			BusinessDetails.Fri_Collection.LinkCustomAttributes = ""
			BusinessDetails.Fri_Collection.HrefValue = ""
			BusinessDetails.Fri_Collection.TooltipValue = ""

			' Sat_Delivery
			BusinessDetails.Sat_Delivery.LinkCustomAttributes = ""
			BusinessDetails.Sat_Delivery.HrefValue = ""
			BusinessDetails.Sat_Delivery.TooltipValue = ""

			' Sat_Collection
			BusinessDetails.Sat_Collection.LinkCustomAttributes = ""
			BusinessDetails.Sat_Collection.HrefValue = ""
			BusinessDetails.Sat_Collection.TooltipValue = ""

			' Sun_Delivery
			BusinessDetails.Sun_Delivery.LinkCustomAttributes = ""
			BusinessDetails.Sun_Delivery.HrefValue = ""
			BusinessDetails.Sun_Delivery.TooltipValue = ""

			' Sun_Collection
			BusinessDetails.Sun_Collection.LinkCustomAttributes = ""
			BusinessDetails.Sun_Collection.HrefValue = ""
			BusinessDetails.Sun_Collection.TooltipValue = ""

			' EnableUrlRewrite
			BusinessDetails.EnableUrlRewrite.LinkCustomAttributes = ""
			BusinessDetails.EnableUrlRewrite.HrefValue = ""
			BusinessDetails.EnableUrlRewrite.TooltipValue = ""

			' DeliveryCostUpTo
			BusinessDetails.DeliveryCostUpTo.LinkCustomAttributes = ""
			BusinessDetails.DeliveryCostUpTo.HrefValue = ""
			BusinessDetails.DeliveryCostUpTo.TooltipValue = ""

			' DeliveryUptoMile
			BusinessDetails.DeliveryUptoMile.LinkCustomAttributes = ""
			BusinessDetails.DeliveryUptoMile.HrefValue = ""
			BusinessDetails.DeliveryUptoMile.TooltipValue = ""

			' Show_Ordernumner_printer
			BusinessDetails.Show_Ordernumner_printer.LinkCustomAttributes = ""
			BusinessDetails.Show_Ordernumner_printer.HrefValue = ""
			BusinessDetails.Show_Ordernumner_printer.TooltipValue = ""

			' Show_Ordernumner_Receipt
			BusinessDetails.Show_Ordernumner_Receipt.LinkCustomAttributes = ""
			BusinessDetails.Show_Ordernumner_Receipt.HrefValue = ""
			BusinessDetails.Show_Ordernumner_Receipt.TooltipValue = ""

			' Show_Ordernumner_Dashboard
			BusinessDetails.Show_Ordernumner_Dashboard.LinkCustomAttributes = ""
			BusinessDetails.Show_Ordernumner_Dashboard.HrefValue = ""
			BusinessDetails.Show_Ordernumner_Dashboard.TooltipValue = ""
		End If

		' Call Row Rendered event
		If BusinessDetails.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call BusinessDetails.Row_Rendered()
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
			item.Body = "<a href=""javascript:void(0);"" class=""ewExportLink ewPdf"" title=""" & ew_HtmlEncode(Language.Phrase("ExportToPDFText")) & """ data-caption=""" & ew_HtmlEncode(Language.Phrase("ExportToPDFText")) & """ onclick=""ew_Export(document.fBusinessDetailslist,'" & ExportPdfUrl & "','pdf',true);"">" & Language.Phrase("ExportToPDF") & "</a>"
		Else
			item.Body = "<a href=""" & ExportPdfUrl & """ class=""ewExportLink ewPdf"" title=""" & ew_HtmlEncode(Language.Phrase("ExportToPDFText")) & """ data-caption=""" & ew_HtmlEncode(Language.Phrase("ExportToPDFText")) & """>" & Language.Phrase("ExportToPDF") & "</a>"
		End If
		item.Visible = False

		' Export to Email
		ExportOptions.Add("email")
		Set item = ExportOptions.GetItem("email")
		url = ew_IIf(ExportEmailCustom, ",url:'" & PageUrl & "export=email&amp;custom=1'", "")
		item.Body = "<button id=""emf_BusinessDetails"" class=""ewExportLink ewEmail"" title=""" & Language.Phrase("ExportToEmailText") & """ data-caption=""" & Language.Phrase("ExportToEmailText") & """ onclick=""ew_EmailDialogShow({lnk:'emf_BusinessDetails',hdr:ewLanguage.Phrase('ExportToEmailText'),f:document.fBusinessDetailslist,sel:false" & url & "});"">" & Language.Phrase("ExportToEmail") & "</button>"
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
		If BusinessDetails.ExportAll Then
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
		If BusinessDetails.Export = "xml" Then
			Set XmlDoc = New cXMLDocument
		Else
			Set BusinessDetails.ExportDoc = New cExportDocument
			Set Doc = BusinessDetails.ExportDoc
			Set Doc.Table = BusinessDetails
			Call Doc.ChangeStyle("h")

			' Call Page Exporting server event
			Doc.ExportCustom = (Not Page_Exporting())
		End If
		Dim rsdetail, detailcnt
		Dim ParentTable
		ParentTable = ""
		If BusinessDetails.Export = "xml" Then
			Call BusinessDetails.ExportXmlDocument(XmlDoc, (ParentTable <> ""), rs, StartRec, StopRec, "")
		Else
			Dim sHeader
			sHeader = PageHeader
			Call Page_DataRendering(sHeader)
			Doc.Text = Doc.Text & sHeader
			Call BusinessDetails.ExportDocument(Doc, rs, StartRec, StopRec, "")
			Dim sFooter
			sFooter = PageFooter
			Call Page_DataRendered(sFooter)
			Doc.Text = Doc.Text & sFooter
		End If

		' Close recordset and connection
		Rs.Close
		Set Rs = Nothing

		' Export header and footer
		If BusinessDetails.Export <> "xml" Then
			Call Doc.ExportHeaderAndFooter()

			' Call Page Exported server event
			Call Page_Exported()
		End If
		If BusinessDetails.Export = "xml" Then
			XmlDoc.Output
			Set XmlDoc = Nothing
		Else
			If BusinessDetails.Export = "email" Then
				Response.Write ExportEmail(Doc.Text)
			ElseIf BusinessDetails.Export = "pdf" Then
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
		Call Breadcrumb.Add("list", BusinessDetails.TableVar, url, "", BusinessDetails.TableVar, True)
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
