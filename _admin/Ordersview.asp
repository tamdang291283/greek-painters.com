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
Dim Orders_view
Set Orders_view = New cOrders_view
Set Page = Orders_view

' Page init processing
Orders_view.Page_Init()

' Page main processing
Orders_view.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
Orders_view.Page_Render()
%>
<!--#include file="header.asp"-->
<% If Orders.Export = "" Then %>
<script type="text/javascript">
// Page object
var Orders_view = new ew_Page("Orders_view");
Orders_view.PageID = "view"; // Page ID
var EW_PAGE_ID = Orders_view.PageID; // For backward compatibility
// Form object
var fOrdersview = new ew_Form("fOrdersview");
// Form_CustomValidate event
fOrdersview.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fOrdersview.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fOrdersview.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
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
<%
	Orders_view.ExportOptions.Render "body", "", "", "", "", ""
	Orders_view.ActionOptions.Render "body", "", "", "", "", ""
	Orders_view.DetailOptions.Render "body", "", "", "", "", ""
%>
<% If Orders.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% End If %>
<% Orders_view.ShowPageHeader() %>
<% Orders_view.ShowMessage %>
<% If Orders.Export = "" Then %>
<form name="ewPagerForm" class="form-inline ewForm ewPagerForm" action="<%= ew_CurrentPage %>">
<% If Not IsObject(Orders_view.Pager) Then Set Orders_view.Pager = ew_NewPrevNextPager(Orders_view.StartRec, Orders_view.DisplayRecs, Orders_view.TotalRecs) %>
<% If Orders_view.Pager.RecordCount > 0 Then %>
<div class="ewPager">
<span><%= Language.Phrase("Page") %>&nbsp;</span>
<div class="ewPrevNext"><div class="input-group">
<div class="input-group-btn">
<!--first page button-->
	<% If Orders_view.Pager.FirstButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerFirst") %>" href="<%= Orders_view.PageUrl %>start=<%= Orders_view.Pager.FirstButton.Start %>"><span class="icon-first ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerFirst") %>"><span class="icon-first ewIcon"></span></a>
	<% End If %>
<!--previous page button-->
	<% If Orders_view.Pager.PrevButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerPrevious") %>" href="<%= Orders_view.PageUrl %>start=<%= Orders_view.Pager.PrevButton.Start %>"><span class="icon-prev ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerPrevious") %>"><span class="icon-prev ewIcon"></span></a>
	<% End If %>
</div>
<!--current page number-->
	<input class="form-control input-sm" type="text" name="<%= EW_TABLE_PAGE_NO %>" value="<%= Orders_view.Pager.CurrentPage %>">
<div class="input-group-btn">
<!--next page button-->
	<% If Orders_view.Pager.NextButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerNext") %>" href="<%= Orders_view.PageUrl %>start=<%= Orders_view.Pager.NextButton.Start %>"><span class="icon-next ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerNext") %>"><span class="icon-next ewIcon"></span></a>
	<% End If %>
<!--last page button-->
	<% If Orders_view.Pager.LastButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerLast") %>" href="<%= Orders_view.PageUrl %>start=<%= Orders_view.Pager.LastButton.Start %>"><span class="icon-last ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerLast") %>"><span class="icon-last ewIcon"></span></a>
	<% End If %>
</div>
</div>
</div>
<span>&nbsp;<%= Language.Phrase("of") %>&nbsp;<%= Orders_view.Pager.PageCount %></span>
</div>
<% End If %>
<div class="clearfix"></div>
</form>
<% End If %>
<form name="fOrdersview" id="fOrdersview" class="form-inline ewForm ewViewForm" action="<%= ew_CurrentPage %>" method="post">
<% If Orders_view.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= Orders_view.Token %>">
<% End If %>
<input type="hidden" name="t" value="Orders">
<table class="table table-bordered table-striped ewViewTable">
<% If Orders.ID.Visible Then ' ID %>
	<tr id="r_ID">
		<td><span id="elh_Orders_ID"><%= Orders.ID.FldCaption %></span></td>
		<td<%= Orders.ID.CellAttributes %>>
<span id="el_Orders_ID" class="form-group">
<span<%= Orders.ID.ViewAttributes %>>
<%= Orders.ID.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.CreationDate.Visible Then ' CreationDate %>
	<tr id="r_CreationDate">
		<td><span id="elh_Orders_CreationDate"><%= Orders.CreationDate.FldCaption %></span></td>
		<td<%= Orders.CreationDate.CellAttributes %>>
<span id="el_Orders_CreationDate" class="form-group">
<span<%= Orders.CreationDate.ViewAttributes %>>
<%= Orders.CreationDate.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.OrderDate.Visible Then ' OrderDate %>
	<tr id="r_OrderDate">
		<td><span id="elh_Orders_OrderDate"><%= Orders.OrderDate.FldCaption %></span></td>
		<td<%= Orders.OrderDate.CellAttributes %>>
<span id="el_Orders_OrderDate" class="form-group">
<span<%= Orders.OrderDate.ViewAttributes %>>
<%= Orders.OrderDate.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.DeliveryType.Visible Then ' DeliveryType %>
	<tr id="r_DeliveryType">
		<td><span id="elh_Orders_DeliveryType"><%= Orders.DeliveryType.FldCaption %></span></td>
		<td<%= Orders.DeliveryType.CellAttributes %>>
<span id="el_Orders_DeliveryType" class="form-group">
<span<%= Orders.DeliveryType.ViewAttributes %>>
<%= Orders.DeliveryType.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.DeliveryTime.Visible Then ' DeliveryTime %>
	<tr id="r_DeliveryTime">
		<td><span id="elh_Orders_DeliveryTime"><%= Orders.DeliveryTime.FldCaption %></span></td>
		<td<%= Orders.DeliveryTime.CellAttributes %>>
<span id="el_Orders_DeliveryTime" class="form-group">
<span<%= Orders.DeliveryTime.ViewAttributes %>>
<%= Orders.DeliveryTime.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.PaymentType.Visible Then ' PaymentType %>
	<tr id="r_PaymentType">
		<td><span id="elh_Orders_PaymentType"><%= Orders.PaymentType.FldCaption %></span></td>
		<td<%= Orders.PaymentType.CellAttributes %>>
<span id="el_Orders_PaymentType" class="form-group">
<span<%= Orders.PaymentType.ViewAttributes %>>
<%= Orders.PaymentType.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.SubTotal.Visible Then ' SubTotal %>
	<tr id="r_SubTotal">
		<td><span id="elh_Orders_SubTotal"><%= Orders.SubTotal.FldCaption %></span></td>
		<td<%= Orders.SubTotal.CellAttributes %>>
<span id="el_Orders_SubTotal" class="form-group">
<span<%= Orders.SubTotal.ViewAttributes %>>
<%= Orders.SubTotal.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.ShippingFee.Visible Then ' ShippingFee %>
	<tr id="r_ShippingFee">
		<td><span id="elh_Orders_ShippingFee"><%= Orders.ShippingFee.FldCaption %></span></td>
		<td<%= Orders.ShippingFee.CellAttributes %>>
<span id="el_Orders_ShippingFee" class="form-group">
<span<%= Orders.ShippingFee.ViewAttributes %>>
<%= Orders.ShippingFee.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.OrderTotal.Visible Then ' OrderTotal %>
	<tr id="r_OrderTotal">
		<td><span id="elh_Orders_OrderTotal"><%= Orders.OrderTotal.FldCaption %></span></td>
		<td<%= Orders.OrderTotal.CellAttributes %>>
<span id="el_Orders_OrderTotal" class="form-group">
<span<%= Orders.OrderTotal.ViewAttributes %>>
<%= Orders.OrderTotal.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
	<tr id="r_IdBusinessDetail">
		<td><span id="elh_Orders_IdBusinessDetail"><%= Orders.IdBusinessDetail.FldCaption %></span></td>
		<td<%= Orders.IdBusinessDetail.CellAttributes %>>
<span id="el_Orders_IdBusinessDetail" class="form-group">
<span<%= Orders.IdBusinessDetail.ViewAttributes %>>
<%= Orders.IdBusinessDetail.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.SessionId.Visible Then ' SessionId %>
	<tr id="r_SessionId">
		<td><span id="elh_Orders_SessionId"><%= Orders.SessionId.FldCaption %></span></td>
		<td<%= Orders.SessionId.CellAttributes %>>
<span id="el_Orders_SessionId" class="form-group">
<span<%= Orders.SessionId.ViewAttributes %>>
<%= Orders.SessionId.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.FirstName.Visible Then ' FirstName %>
	<tr id="r_FirstName">
		<td><span id="elh_Orders_FirstName"><%= Orders.FirstName.FldCaption %></span></td>
		<td<%= Orders.FirstName.CellAttributes %>>
<span id="el_Orders_FirstName" class="form-group">
<span<%= Orders.FirstName.ViewAttributes %>>
<%= Orders.FirstName.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.LastName.Visible Then ' LastName %>
	<tr id="r_LastName">
		<td><span id="elh_Orders_LastName"><%= Orders.LastName.FldCaption %></span></td>
		<td<%= Orders.LastName.CellAttributes %>>
<span id="el_Orders_LastName" class="form-group">
<span<%= Orders.LastName.ViewAttributes %>>
<%= Orders.LastName.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.zEmail.Visible Then ' Email %>
	<tr id="r_zEmail">
		<td><span id="elh_Orders_zEmail"><%= Orders.zEmail.FldCaption %></span></td>
		<td<%= Orders.zEmail.CellAttributes %>>
<span id="el_Orders_zEmail" class="form-group">
<span<%= Orders.zEmail.ViewAttributes %>>
<%= Orders.zEmail.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.Phone.Visible Then ' Phone %>
	<tr id="r_Phone">
		<td><span id="elh_Orders_Phone"><%= Orders.Phone.FldCaption %></span></td>
		<td<%= Orders.Phone.CellAttributes %>>
<span id="el_Orders_Phone" class="form-group">
<span<%= Orders.Phone.ViewAttributes %>>
<%= Orders.Phone.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.Address.Visible Then ' Address %>
	<tr id="r_Address">
		<td><span id="elh_Orders_Address"><%= Orders.Address.FldCaption %></span></td>
		<td<%= Orders.Address.CellAttributes %>>
<span id="el_Orders_Address" class="form-group">
<span<%= Orders.Address.ViewAttributes %>>
<%= Orders.Address.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.PostalCode.Visible Then ' PostalCode %>
	<tr id="r_PostalCode">
		<td><span id="elh_Orders_PostalCode"><%= Orders.PostalCode.FldCaption %></span></td>
		<td<%= Orders.PostalCode.CellAttributes %>>
<span id="el_Orders_PostalCode" class="form-group">
<span<%= Orders.PostalCode.ViewAttributes %>>
<%= Orders.PostalCode.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.Notes.Visible Then ' Notes %>
	<tr id="r_Notes">
		<td><span id="elh_Orders_Notes"><%= Orders.Notes.FldCaption %></span></td>
		<td<%= Orders.Notes.CellAttributes %>>
<span id="el_Orders_Notes" class="form-group">
<span<%= Orders.Notes.ViewAttributes %>>
<%= Orders.Notes.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.ttest.Visible Then ' ttest %>
	<tr id="r_ttest">
		<td><span id="elh_Orders_ttest"><%= Orders.ttest.FldCaption %></span></td>
		<td<%= Orders.ttest.CellAttributes %>>
<span id="el_Orders_ttest" class="form-group">
<span<%= Orders.ttest.ViewAttributes %>>
<%= Orders.ttest.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.cancelleddate.Visible Then ' cancelleddate %>
	<tr id="r_cancelleddate">
		<td><span id="elh_Orders_cancelleddate"><%= Orders.cancelleddate.FldCaption %></span></td>
		<td<%= Orders.cancelleddate.CellAttributes %>>
<span id="el_Orders_cancelleddate" class="form-group">
<span<%= Orders.cancelleddate.ViewAttributes %>>
<%= Orders.cancelleddate.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.cancelledby.Visible Then ' cancelledby %>
	<tr id="r_cancelledby">
		<td><span id="elh_Orders_cancelledby"><%= Orders.cancelledby.FldCaption %></span></td>
		<td<%= Orders.cancelledby.CellAttributes %>>
<span id="el_Orders_cancelledby" class="form-group">
<span<%= Orders.cancelledby.ViewAttributes %>>
<%= Orders.cancelledby.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.cancelledreason.Visible Then ' cancelledreason %>
	<tr id="r_cancelledreason">
		<td><span id="elh_Orders_cancelledreason"><%= Orders.cancelledreason.FldCaption %></span></td>
		<td<%= Orders.cancelledreason.CellAttributes %>>
<span id="el_Orders_cancelledreason" class="form-group">
<span<%= Orders.cancelledreason.ViewAttributes %>>
<%= Orders.cancelledreason.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.acknowledgeddate.Visible Then ' acknowledgeddate %>
	<tr id="r_acknowledgeddate">
		<td><span id="elh_Orders_acknowledgeddate"><%= Orders.acknowledgeddate.FldCaption %></span></td>
		<td<%= Orders.acknowledgeddate.CellAttributes %>>
<span id="el_Orders_acknowledgeddate" class="form-group">
<span<%= Orders.acknowledgeddate.ViewAttributes %>>
<%= Orders.acknowledgeddate.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.delivereddate.Visible Then ' delivereddate %>
	<tr id="r_delivereddate">
		<td><span id="elh_Orders_delivereddate"><%= Orders.delivereddate.FldCaption %></span></td>
		<td<%= Orders.delivereddate.CellAttributes %>>
<span id="el_Orders_delivereddate" class="form-group">
<span<%= Orders.delivereddate.ViewAttributes %>>
<%= Orders.delivereddate.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.cancelled.Visible Then ' cancelled %>
	<tr id="r_cancelled">
		<td><span id="elh_Orders_cancelled"><%= Orders.cancelled.FldCaption %></span></td>
		<td<%= Orders.cancelled.CellAttributes %>>
<span id="el_Orders_cancelled" class="form-group">
<span<%= Orders.cancelled.ViewAttributes %>>
<%= Orders.cancelled.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.acknowledged.Visible Then ' acknowledged %>
	<tr id="r_acknowledged">
		<td><span id="elh_Orders_acknowledged"><%= Orders.acknowledged.FldCaption %></span></td>
		<td<%= Orders.acknowledged.CellAttributes %>>
<span id="el_Orders_acknowledged" class="form-group">
<span<%= Orders.acknowledged.ViewAttributes %>>
<%= Orders.acknowledged.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.outfordelivery.Visible Then ' outfordelivery %>
	<tr id="r_outfordelivery">
		<td><span id="elh_Orders_outfordelivery"><%= Orders.outfordelivery.FldCaption %></span></td>
		<td<%= Orders.outfordelivery.CellAttributes %>>
<span id="el_Orders_outfordelivery" class="form-group">
<span<%= Orders.outfordelivery.ViewAttributes %>>
<%= Orders.outfordelivery.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.vouchercodediscount.Visible Then ' vouchercodediscount %>
	<tr id="r_vouchercodediscount">
		<td><span id="elh_Orders_vouchercodediscount"><%= Orders.vouchercodediscount.FldCaption %></span></td>
		<td<%= Orders.vouchercodediscount.CellAttributes %>>
<span id="el_Orders_vouchercodediscount" class="form-group">
<span<%= Orders.vouchercodediscount.ViewAttributes %>>
<%= Orders.vouchercodediscount.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.vouchercode.Visible Then ' vouchercode %>
	<tr id="r_vouchercode">
		<td><span id="elh_Orders_vouchercode"><%= Orders.vouchercode.FldCaption %></span></td>
		<td<%= Orders.vouchercode.CellAttributes %>>
<span id="el_Orders_vouchercode" class="form-group">
<span<%= Orders.vouchercode.ViewAttributes %>>
<%= Orders.vouchercode.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.printed.Visible Then ' printed %>
	<tr id="r_printed">
		<td><span id="elh_Orders_printed"><%= Orders.printed.FldCaption %></span></td>
		<td<%= Orders.printed.CellAttributes %>>
<span id="el_Orders_printed" class="form-group">
<span<%= Orders.printed.ViewAttributes %>>
<%= Orders.printed.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.deliverydistance.Visible Then ' deliverydistance %>
	<tr id="r_deliverydistance">
		<td><span id="elh_Orders_deliverydistance"><%= Orders.deliverydistance.FldCaption %></span></td>
		<td<%= Orders.deliverydistance.CellAttributes %>>
<span id="el_Orders_deliverydistance" class="form-group">
<span<%= Orders.deliverydistance.ViewAttributes %>>
<%= Orders.deliverydistance.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.asaporder.Visible Then ' asaporder %>
	<tr id="r_asaporder">
		<td><span id="elh_Orders_asaporder"><%= Orders.asaporder.FldCaption %></span></td>
		<td<%= Orders.asaporder.CellAttributes %>>
<span id="el_Orders_asaporder" class="form-group">
<span<%= Orders.asaporder.ViewAttributes %>>
<%= Orders.asaporder.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.DeliveryLat.Visible Then ' DeliveryLat %>
	<tr id="r_DeliveryLat">
		<td><span id="elh_Orders_DeliveryLat"><%= Orders.DeliveryLat.FldCaption %></span></td>
		<td<%= Orders.DeliveryLat.CellAttributes %>>
<span id="el_Orders_DeliveryLat" class="form-group">
<span<%= Orders.DeliveryLat.ViewAttributes %>>
<%= Orders.DeliveryLat.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.DeliveryLng.Visible Then ' DeliveryLng %>
	<tr id="r_DeliveryLng">
		<td><span id="elh_Orders_DeliveryLng"><%= Orders.DeliveryLng.FldCaption %></span></td>
		<td<%= Orders.DeliveryLng.CellAttributes %>>
<span id="el_Orders_DeliveryLng" class="form-group">
<span<%= Orders.DeliveryLng.ViewAttributes %>>
<%= Orders.DeliveryLng.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.ServiceCharge.Visible Then ' ServiceCharge %>
	<tr id="r_ServiceCharge">
		<td><span id="elh_Orders_ServiceCharge"><%= Orders.ServiceCharge.FldCaption %></span></td>
		<td<%= Orders.ServiceCharge.CellAttributes %>>
<span id="el_Orders_ServiceCharge" class="form-group">
<span<%= Orders.ServiceCharge.ViewAttributes %>>
<%= Orders.ServiceCharge.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.PaymentSurcharge.Visible Then ' PaymentSurcharge %>
	<tr id="r_PaymentSurcharge">
		<td><span id="elh_Orders_PaymentSurcharge"><%= Orders.PaymentSurcharge.FldCaption %></span></td>
		<td<%= Orders.PaymentSurcharge.CellAttributes %>>
<span id="el_Orders_PaymentSurcharge" class="form-group">
<span<%= Orders.PaymentSurcharge.ViewAttributes %>>
<%= Orders.PaymentSurcharge.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.FromIP.Visible Then ' FromIP %>
	<tr id="r_FromIP">
		<td><span id="elh_Orders_FromIP"><%= Orders.FromIP.FldCaption %></span></td>
		<td<%= Orders.FromIP.CellAttributes %>>
<span id="el_Orders_FromIP" class="form-group">
<span<%= Orders.FromIP.ViewAttributes %>>
<%= Orders.FromIP.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.SentEmail.Visible Then ' SentEmail %>
	<tr id="r_SentEmail">
		<td><span id="elh_Orders_SentEmail"><%= Orders.SentEmail.FldCaption %></span></td>
		<td<%= Orders.SentEmail.CellAttributes %>>
<span id="el_Orders_SentEmail" class="form-group">
<span<%= Orders.SentEmail.ViewAttributes %>>
<%= Orders.SentEmail.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.Tax_Rate.Visible Then ' Tax_Rate %>
	<tr id="r_Tax_Rate">
		<td><span id="elh_Orders_Tax_Rate"><%= Orders.Tax_Rate.FldCaption %></span></td>
		<td<%= Orders.Tax_Rate.CellAttributes %>>
<span id="el_Orders_Tax_Rate" class="form-group">
<span<%= Orders.Tax_Rate.ViewAttributes %>>
<%= Orders.Tax_Rate.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.Tax_Amount.Visible Then ' Tax_Amount %>
	<tr id="r_Tax_Amount">
		<td><span id="elh_Orders_Tax_Amount"><%= Orders.Tax_Amount.FldCaption %></span></td>
		<td<%= Orders.Tax_Amount.CellAttributes %>>
<span id="el_Orders_Tax_Amount" class="form-group">
<span<%= Orders.Tax_Amount.ViewAttributes %>>
<%= Orders.Tax_Amount.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.Tip_Rate.Visible Then ' Tip_Rate %>
	<tr id="r_Tip_Rate">
		<td><span id="elh_Orders_Tip_Rate"><%= Orders.Tip_Rate.FldCaption %></span></td>
		<td<%= Orders.Tip_Rate.CellAttributes %>>
<span id="el_Orders_Tip_Rate" class="form-group">
<span<%= Orders.Tip_Rate.ViewAttributes %>>
<%= Orders.Tip_Rate.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.Tip_Amount.Visible Then ' Tip_Amount %>
	<tr id="r_Tip_Amount">
		<td><span id="elh_Orders_Tip_Amount"><%= Orders.Tip_Amount.FldCaption %></span></td>
		<td<%= Orders.Tip_Amount.CellAttributes %>>
<span id="el_Orders_Tip_Amount" class="form-group">
<span<%= Orders.Tip_Amount.ViewAttributes %>>
<%= Orders.Tip_Amount.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.Card_Debit.Visible Then ' Card_Debit %>
	<tr id="r_Card_Debit">
		<td><span id="elh_Orders_Card_Debit"><%= Orders.Card_Debit.FldCaption %></span></td>
		<td<%= Orders.Card_Debit.CellAttributes %>>
<span id="el_Orders_Card_Debit" class="form-group">
<span<%= Orders.Card_Debit.ViewAttributes %>>
<%= Orders.Card_Debit.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.Card_Credit.Visible Then ' Card_Credit %>
	<tr id="r_Card_Credit">
		<td><span id="elh_Orders_Card_Credit"><%= Orders.Card_Credit.FldCaption %></span></td>
		<td<%= Orders.Card_Credit.CellAttributes %>>
<span id="el_Orders_Card_Credit" class="form-group">
<span<%= Orders.Card_Credit.ViewAttributes %>>
<%= Orders.Card_Credit.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.deliverydelay.Visible Then ' deliverydelay %>
	<tr id="r_deliverydelay">
		<td><span id="elh_Orders_deliverydelay"><%= Orders.deliverydelay.FldCaption %></span></td>
		<td<%= Orders.deliverydelay.CellAttributes %>>
<span id="el_Orders_deliverydelay" class="form-group">
<span<%= Orders.deliverydelay.ViewAttributes %>>
<%= Orders.deliverydelay.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.collectiondelay.Visible Then ' collectiondelay %>
	<tr id="r_collectiondelay">
		<td><span id="elh_Orders_collectiondelay"><%= Orders.collectiondelay.FldCaption %></span></td>
		<td<%= Orders.collectiondelay.CellAttributes %>>
<span id="el_Orders_collectiondelay" class="form-group">
<span<%= Orders.collectiondelay.ViewAttributes %>>
<%= Orders.collectiondelay.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.lng_report.Visible Then ' lng_report %>
	<tr id="r_lng_report">
		<td><span id="elh_Orders_lng_report"><%= Orders.lng_report.FldCaption %></span></td>
		<td<%= Orders.lng_report.CellAttributes %>>
<span id="el_Orders_lng_report" class="form-group">
<span<%= Orders.lng_report.ViewAttributes %>>
<%= Orders.lng_report.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.lat_report.Visible Then ' lat_report %>
	<tr id="r_lat_report">
		<td><span id="elh_Orders_lat_report"><%= Orders.lat_report.FldCaption %></span></td>
		<td<%= Orders.lat_report.CellAttributes %>>
<span id="el_Orders_lat_report" class="form-group">
<span<%= Orders.lat_report.ViewAttributes %>>
<%= Orders.lat_report.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If Orders.Payment_status.Visible Then ' Payment_status %>
	<tr id="r_Payment_status">
		<td><span id="elh_Orders_Payment_status"><%= Orders.Payment_status.FldCaption %></span></td>
		<td<%= Orders.Payment_status.CellAttributes %>>
<span id="el_Orders_Payment_status" class="form-group">
<span<%= Orders.Payment_status.ViewAttributes %>>
<%= Orders.Payment_status.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
</table>
<% If Orders.Export = "" Then %>
<% If Not IsObject(Orders_view.Pager) Then Set Orders_view.Pager = ew_NewPrevNextPager(Orders_view.StartRec, Orders_view.DisplayRecs, Orders_view.TotalRecs) %>
<% If Orders_view.Pager.RecordCount > 0 Then %>
<div class="ewPager">
<span><%= Language.Phrase("Page") %>&nbsp;</span>
<div class="ewPrevNext"><div class="input-group">
<div class="input-group-btn">
<!--first page button-->
	<% If Orders_view.Pager.FirstButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerFirst") %>" href="<%= Orders_view.PageUrl %>start=<%= Orders_view.Pager.FirstButton.Start %>"><span class="icon-first ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerFirst") %>"><span class="icon-first ewIcon"></span></a>
	<% End If %>
<!--previous page button-->
	<% If Orders_view.Pager.PrevButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerPrevious") %>" href="<%= Orders_view.PageUrl %>start=<%= Orders_view.Pager.PrevButton.Start %>"><span class="icon-prev ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerPrevious") %>"><span class="icon-prev ewIcon"></span></a>
	<% End If %>
</div>
<!--current page number-->
	<input class="form-control input-sm" type="text" name="<%= EW_TABLE_PAGE_NO %>" value="<%= Orders_view.Pager.CurrentPage %>">
<div class="input-group-btn">
<!--next page button-->
	<% If Orders_view.Pager.NextButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerNext") %>" href="<%= Orders_view.PageUrl %>start=<%= Orders_view.Pager.NextButton.Start %>"><span class="icon-next ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerNext") %>"><span class="icon-next ewIcon"></span></a>
	<% End If %>
<!--last page button-->
	<% If Orders_view.Pager.LastButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerLast") %>" href="<%= Orders_view.PageUrl %>start=<%= Orders_view.Pager.LastButton.Start %>"><span class="icon-last ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerLast") %>"><span class="icon-last ewIcon"></span></a>
	<% End If %>
</div>
</div>
</div>
<span>&nbsp;<%= Language.Phrase("of") %>&nbsp;<%= Orders_view.Pager.PageCount %></span>
</div>
<% End If %>
<div class="clearfix"></div>
<% End If %>
</form>
<% If Orders.Export <> "" Then %>
<script type="text/javascript">
ew_ApplyTemplate("body", "", "Ordersview", "<%= Orders.CustomExport %>");
</script>
<% End If %>
<script type="text/javascript">
fOrdersview.Init();
</script>
<%
Orders_view.ShowPageFooter()
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
Set Orders_view = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cOrders_view

	' Page ID
	Public Property Get PageID()
		PageID = "view"
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
		PageObjName = "Orders_view"
	End Property

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
		Dim KeyUrl
		KeyUrl = ""
		If Request.QueryString("ID").Count > 0 Then
			ew_AddKey RecKey, "ID", Request.QueryString("ID")
			KeyUrl = KeyUrl & "&amp;ID=" & ew_Encode(Request.QueryString("ID"))
		End If
		ExportPrintUrl = PageUrl & "export=print" & KeyUrl
		ExportHtmlUrl = PageUrl & "export=html" & KeyUrl
		ExportExcelUrl = PageUrl & "export=excel" & KeyUrl
		ExportWordUrl = PageUrl & "export=word" & KeyUrl
		ExportXmlUrl = PageUrl & "export=xml" & KeyUrl
		ExportCsvUrl = PageUrl & "export=csv" & KeyUrl
		ExportPdfUrl = PageUrl & "export=pdf" & KeyUrl

		' Initialize form object
		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "view"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "Orders"

		' Open connection to the database
		If IsEmpty(Conn) Then Call ew_Connect()

		' Export options
		Set ExportOptions = New cListOptions
		ExportOptions.TableVar = Orders.TableVar
		ExportOptions.Tag = "div"
		ExportOptions.TagClassName = "ewExportOption"

		' Other options
		Set ActionOptions = New cListOptions
		ActionOptions.Tag = "div"
		ActionOptions.TagClassName = "ewActionOption"
		Set DetailOptions = New cListOptions
		DetailOptions.Tag = "div"
		DetailOptions.TagClassName = "ewDetailOption"
	End Sub

	' -----------------------------------------------------------------
	'  Subroutine Page_Init
	'  - called before page main
	'  - check Security
	'  - set up response header
	'  - call page load events
	'
	Sub Page_Init()

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
	Dim DisplayRecs ' Number of display records
	Dim StartRec, StopRec, TotalRecs, RecRange
	Dim RecCnt
	Dim RecKey
	Dim ExportOptions ' Export options
	Dim DetailOptions ' Other options (detail)
	Dim ActionOptions ' Other options (action)
	Dim Recordset

	' -----------------------------------------------------------------
	' Page main processing
	'
	Sub Page_Main()

		' Paging variables
		DisplayRecs = 1
		RecRange = 10

		' Load current record
		Dim bLoadCurrentRecord
		bLoadCurrentRecord = False
		Dim sReturnUrl
		sReturnUrl = ""
		Dim bMatchRecord
		bMatchRecord = False

		' Set up Breadcrumb
		If Orders.Export = "" Then
			SetupBreadcrumb()
		End If
		If IsPageRequest Then ' Validate request
			If Request.QueryString("ID").Count > 0 Then
				Orders.ID.QueryStringValue = Request.QueryString("ID")
			ElseIf Request.Form("ID").Count > 0 Then
				Orders.ID.FormValue = Request.Form("ID")
			Else
				bLoadCurrentRecord = True
			End If

			' Get action
			Orders.CurrentAction = "I" ' Display form
			Select Case Orders.CurrentAction
				Case "I" ' Get a record to display
					StartRec = 1 ' Initialize start position
					Set Recordset = LoadRecordset() ' Load records
					TotalRecs = Recordset.RecordCount ' Get record count
					If TotalRecs <= 0 Then ' No record found
						If SuccessMessage = "" And FailureMessage = "" Then
							FailureMessage = Language.Phrase("NoRecord") ' Set no record message
						End If
						sReturnUrl = "Orderslist.asp"
					ElseIf bLoadCurrentRecord Then ' Load current record position
						SetUpStartRec() ' Set up start record position

						' Point to current record
						If CLng(StartRec) <= CLng(TotalRecs) Then
							bMatchRecord = True
							Recordset.Move StartRec-1
						End If
					Else ' Match key values
						Do While Not Recordset.Eof
							If CStr(Orders.ID.CurrentValue&"") = CStr(Recordset("ID")&"") Then
								Orders.StartRecordNumber = StartRec ' Save record position
								bMatchRecord = True
								Exit Do
							Else
								StartRec = StartRec + 1
								Recordset.MoveNext
							End If
						Loop
					End If
					If Not bMatchRecord Then
						If SuccessMessage = "" And FailureMessage = "" Then
							FailureMessage = Language.Phrase("NoRecord") ' Set no record message
						End If
						sReturnUrl = "Orderslist.asp" ' No matching record, return to list
					Else
						Call LoadRowValues(Recordset) ' Load row values
					End If
			End Select
		Else
			sReturnUrl = "Orderslist.asp" ' Not page request, return to list
		End If
		If sReturnUrl <> "" Then Call Page_Terminate(sReturnUrl)

		' Render row
		Orders.RowType = EW_ROWTYPE_VIEW
		Call Orders.ResetAttrs()
		Call RenderRow()
	End Sub

	' Set up other options
	Sub SetupOtherOptions()
		Dim opt, item
		Set opt = ActionOptions

		' Add
		Call opt.Add("add")
		Set item = opt.GetItem("add")
		item.Body = "<a class=""ewAction ewAdd"" title=""" & ew_HtmlTitle(Language.Phrase("ViewPageAddLink")) & """ data-caption=""" & ew_HtmlTitle(Language.Phrase("ViewPageAddLink")) & """ href=""" & ew_HtmlEncode(AddUrl) & """>" & Language.Phrase("ViewPageAddLink") & "</a>"
		item.Visible = (AddUrl <> "")

		' Edit
		Call opt.Add("edit")
		Set item = opt.GetItem("edit")
		item.Body = "<a class=""ewAction ewEdit"" title=""" & ew_HtmlTitle(Language.Phrase("ViewPageEditLink")) & """ data-caption=""" & ew_HtmlTitle(Language.Phrase("ViewPageEditLink")) & """ href=""" & ew_HtmlEncode(EditUrl) & """>" & Language.Phrase("ViewPageEditLink") & "</a>"
		item.Visible = (EditUrl <> "")

		' Copy
		Call opt.Add("copy")
		Set item = opt.GetItem("copy")
		item.Body = "<a class=""ewAction ewCopy"" title=""" & ew_HtmlTitle(Language.Phrase("ViewPageCopyLink")) & """ data-caption=""" & ew_HtmlTitle(Language.Phrase("ViewPageCopyLink")) & """ href=""" & ew_HtmlEncode(CopyUrl) & """>" & Language.Phrase("ViewPageCopyLink") & "</a>"
		item.Visible = (CopyUrl <> "")

		' Delete
		Call opt.Add("delete")
		Set item = opt.GetItem("delete")
		item.Body = "<a onclick=""return ew_Confirm(ewLanguage.Phrase('DeleteConfirmMsg'));"" class=""ewAction ewDelete"" title=""" & ew_HtmlTitle(Language.Phrase("ViewPageDeleteLink")) & """ data-caption=""" & ew_HtmlTitle(Language.Phrase("ViewPageDeleteLink")) & """ href=""" & ew_HtmlEncode(DeleteUrl) & """>" & Language.Phrase("ViewPageDeleteLink") & "</a>"
		item.Visible = (DeleteUrl <> "")

		' Set up options default
		Set opt = ActionOptions
		opt.DropDownButtonPhrase = Language.Phrase("ButtonActions")
		opt.UseImageAndText = True
		opt.UseDropDownButton = False
		opt.UseButtonGroup = True
		Call opt.Add(opt.GroupOptionName)
		Set item = opt.GetItem(opt.GroupOptionName)
		item.Body = ""
		item.Visible = False
	End Sub
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

	' -----------------------------------------------------------------
	' Render row values based on field settings
	'
	Sub RenderRow()

		' Initialize urls
		AddUrl = Orders.AddUrl("")
		EditUrl = Orders.EditUrl("")
		CopyUrl = Orders.CopyUrl("")
		DeleteUrl = Orders.DeleteUrl
		ListUrl = Orders.ListUrl
		SetupOtherOptions()

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

			' Notes
			Orders.Notes.ViewValue = Orders.Notes.CurrentValue
			Orders.Notes.ViewCustomAttributes = ""

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

			' Notes
			Orders.Notes.LinkCustomAttributes = ""
			Orders.Notes.HrefValue = ""
			Orders.Notes.TooltipValue = ""

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

	' Set up Breadcrumb
	Sub SetupBreadcrumb()
		Dim PageId, url
		Set Breadcrumb = New cBreadcrumb
		url = Mid(ew_CurrentUrl, InStrRev(ew_CurrentUrl, "/")+1)
		Call Breadcrumb.Add("list", Orders.TableVar, "Orderslist.asp", "", Orders.TableVar, True)
		PageId = "view"
		Call Breadcrumb.Add("view", PageId, url, "", "", False)
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
