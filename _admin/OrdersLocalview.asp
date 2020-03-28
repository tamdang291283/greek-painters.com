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
Dim OrdersLocal_view
Set OrdersLocal_view = New cOrdersLocal_view
Set Page = OrdersLocal_view

' Page init processing
OrdersLocal_view.Page_Init()

' Page main processing
OrdersLocal_view.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
OrdersLocal_view.Page_Render()
%>
<!--#include file="header.asp"-->
<% If OrdersLocal.Export = "" Then %>
<script type="text/javascript">
// Page object
var OrdersLocal_view = new ew_Page("OrdersLocal_view");
OrdersLocal_view.PageID = "view"; // Page ID
var EW_PAGE_ID = OrdersLocal_view.PageID; // For backward compatibility
// Form object
var fOrdersLocalview = new ew_Form("fOrdersLocalview");
// Form_CustomValidate event
fOrdersLocalview.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fOrdersLocalview.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fOrdersLocalview.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
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
<%
	OrdersLocal_view.ExportOptions.Render "body", "", "", "", "", ""
	OrdersLocal_view.ActionOptions.Render "body", "", "", "", "", ""
	OrdersLocal_view.DetailOptions.Render "body", "", "", "", "", ""
%>
<% If OrdersLocal.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% End If %>
<% OrdersLocal_view.ShowPageHeader() %>
<% OrdersLocal_view.ShowMessage %>
<% If OrdersLocal.Export = "" Then %>
<form name="ewPagerForm" class="form-inline ewForm ewPagerForm" action="<%= ew_CurrentPage %>">
<% If Not IsObject(OrdersLocal_view.Pager) Then Set OrdersLocal_view.Pager = ew_NewPrevNextPager(OrdersLocal_view.StartRec, OrdersLocal_view.DisplayRecs, OrdersLocal_view.TotalRecs) %>
<% If OrdersLocal_view.Pager.RecordCount > 0 Then %>
<div class="ewPager">
<span><%= Language.Phrase("Page") %>&nbsp;</span>
<div class="ewPrevNext"><div class="input-group">
<div class="input-group-btn">
<!--first page button-->
	<% If OrdersLocal_view.Pager.FirstButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerFirst") %>" href="<%= OrdersLocal_view.PageUrl %>start=<%= OrdersLocal_view.Pager.FirstButton.Start %>"><span class="icon-first ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerFirst") %>"><span class="icon-first ewIcon"></span></a>
	<% End If %>
<!--previous page button-->
	<% If OrdersLocal_view.Pager.PrevButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerPrevious") %>" href="<%= OrdersLocal_view.PageUrl %>start=<%= OrdersLocal_view.Pager.PrevButton.Start %>"><span class="icon-prev ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerPrevious") %>"><span class="icon-prev ewIcon"></span></a>
	<% End If %>
</div>
<!--current page number-->
	<input class="form-control input-sm" type="text" name="<%= EW_TABLE_PAGE_NO %>" value="<%= OrdersLocal_view.Pager.CurrentPage %>">
<div class="input-group-btn">
<!--next page button-->
	<% If OrdersLocal_view.Pager.NextButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerNext") %>" href="<%= OrdersLocal_view.PageUrl %>start=<%= OrdersLocal_view.Pager.NextButton.Start %>"><span class="icon-next ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerNext") %>"><span class="icon-next ewIcon"></span></a>
	<% End If %>
<!--last page button-->
	<% If OrdersLocal_view.Pager.LastButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerLast") %>" href="<%= OrdersLocal_view.PageUrl %>start=<%= OrdersLocal_view.Pager.LastButton.Start %>"><span class="icon-last ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerLast") %>"><span class="icon-last ewIcon"></span></a>
	<% End If %>
</div>
</div>
</div>
<span>&nbsp;<%= Language.Phrase("of") %>&nbsp;<%= OrdersLocal_view.Pager.PageCount %></span>
</div>
<% End If %>
<div class="clearfix"></div>
</form>
<% End If %>
<form name="fOrdersLocalview" id="fOrdersLocalview" class="form-inline ewForm ewViewForm" action="<%= ew_CurrentPage %>" method="post">
<% If OrdersLocal_view.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= OrdersLocal_view.Token %>">
<% End If %>
<input type="hidden" name="t" value="OrdersLocal">
<table class="table table-bordered table-striped ewViewTable">
<% If OrdersLocal.ID.Visible Then ' ID %>
	<tr id="r_ID">
		<td><span id="elh_OrdersLocal_ID"><%= OrdersLocal.ID.FldCaption %></span></td>
		<td<%= OrdersLocal.ID.CellAttributes %>>
<span id="el_OrdersLocal_ID" class="form-group">
<span<%= OrdersLocal.ID.ViewAttributes %>>
<%= OrdersLocal.ID.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrdersLocal.CreationDate.Visible Then ' CreationDate %>
	<tr id="r_CreationDate">
		<td><span id="elh_OrdersLocal_CreationDate"><%= OrdersLocal.CreationDate.FldCaption %></span></td>
		<td<%= OrdersLocal.CreationDate.CellAttributes %>>
<span id="el_OrdersLocal_CreationDate" class="form-group">
<span<%= OrdersLocal.CreationDate.ViewAttributes %>>
<%= OrdersLocal.CreationDate.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrdersLocal.OrderDate.Visible Then ' OrderDate %>
	<tr id="r_OrderDate">
		<td><span id="elh_OrdersLocal_OrderDate"><%= OrdersLocal.OrderDate.FldCaption %></span></td>
		<td<%= OrdersLocal.OrderDate.CellAttributes %>>
<span id="el_OrdersLocal_OrderDate" class="form-group">
<span<%= OrdersLocal.OrderDate.ViewAttributes %>>
<%= OrdersLocal.OrderDate.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrdersLocal.DeliveryType.Visible Then ' DeliveryType %>
	<tr id="r_DeliveryType">
		<td><span id="elh_OrdersLocal_DeliveryType"><%= OrdersLocal.DeliveryType.FldCaption %></span></td>
		<td<%= OrdersLocal.DeliveryType.CellAttributes %>>
<span id="el_OrdersLocal_DeliveryType" class="form-group">
<span<%= OrdersLocal.DeliveryType.ViewAttributes %>>
<%= OrdersLocal.DeliveryType.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrdersLocal.DeliveryTime.Visible Then ' DeliveryTime %>
	<tr id="r_DeliveryTime">
		<td><span id="elh_OrdersLocal_DeliveryTime"><%= OrdersLocal.DeliveryTime.FldCaption %></span></td>
		<td<%= OrdersLocal.DeliveryTime.CellAttributes %>>
<span id="el_OrdersLocal_DeliveryTime" class="form-group">
<span<%= OrdersLocal.DeliveryTime.ViewAttributes %>>
<%= OrdersLocal.DeliveryTime.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrdersLocal.PaymentType.Visible Then ' PaymentType %>
	<tr id="r_PaymentType">
		<td><span id="elh_OrdersLocal_PaymentType"><%= OrdersLocal.PaymentType.FldCaption %></span></td>
		<td<%= OrdersLocal.PaymentType.CellAttributes %>>
<span id="el_OrdersLocal_PaymentType" class="form-group">
<span<%= OrdersLocal.PaymentType.ViewAttributes %>>
<%= OrdersLocal.PaymentType.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrdersLocal.SubTotal.Visible Then ' SubTotal %>
	<tr id="r_SubTotal">
		<td><span id="elh_OrdersLocal_SubTotal"><%= OrdersLocal.SubTotal.FldCaption %></span></td>
		<td<%= OrdersLocal.SubTotal.CellAttributes %>>
<span id="el_OrdersLocal_SubTotal" class="form-group">
<span<%= OrdersLocal.SubTotal.ViewAttributes %>>
<%= OrdersLocal.SubTotal.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrdersLocal.ShippingFee.Visible Then ' ShippingFee %>
	<tr id="r_ShippingFee">
		<td><span id="elh_OrdersLocal_ShippingFee"><%= OrdersLocal.ShippingFee.FldCaption %></span></td>
		<td<%= OrdersLocal.ShippingFee.CellAttributes %>>
<span id="el_OrdersLocal_ShippingFee" class="form-group">
<span<%= OrdersLocal.ShippingFee.ViewAttributes %>>
<%= OrdersLocal.ShippingFee.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrdersLocal.OrderTotal.Visible Then ' OrderTotal %>
	<tr id="r_OrderTotal">
		<td><span id="elh_OrdersLocal_OrderTotal"><%= OrdersLocal.OrderTotal.FldCaption %></span></td>
		<td<%= OrdersLocal.OrderTotal.CellAttributes %>>
<span id="el_OrdersLocal_OrderTotal" class="form-group">
<span<%= OrdersLocal.OrderTotal.ViewAttributes %>>
<%= OrdersLocal.OrderTotal.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrdersLocal.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
	<tr id="r_IdBusinessDetail">
		<td><span id="elh_OrdersLocal_IdBusinessDetail"><%= OrdersLocal.IdBusinessDetail.FldCaption %></span></td>
		<td<%= OrdersLocal.IdBusinessDetail.CellAttributes %>>
<span id="el_OrdersLocal_IdBusinessDetail" class="form-group">
<span<%= OrdersLocal.IdBusinessDetail.ViewAttributes %>>
<%= OrdersLocal.IdBusinessDetail.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrdersLocal.SessionId.Visible Then ' SessionId %>
	<tr id="r_SessionId">
		<td><span id="elh_OrdersLocal_SessionId"><%= OrdersLocal.SessionId.FldCaption %></span></td>
		<td<%= OrdersLocal.SessionId.CellAttributes %>>
<span id="el_OrdersLocal_SessionId" class="form-group">
<span<%= OrdersLocal.SessionId.ViewAttributes %>>
<%= OrdersLocal.SessionId.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrdersLocal.FirstName.Visible Then ' FirstName %>
	<tr id="r_FirstName">
		<td><span id="elh_OrdersLocal_FirstName"><%= OrdersLocal.FirstName.FldCaption %></span></td>
		<td<%= OrdersLocal.FirstName.CellAttributes %>>
<span id="el_OrdersLocal_FirstName" class="form-group">
<span<%= OrdersLocal.FirstName.ViewAttributes %>>
<%= OrdersLocal.FirstName.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrdersLocal.LastName.Visible Then ' LastName %>
	<tr id="r_LastName">
		<td><span id="elh_OrdersLocal_LastName"><%= OrdersLocal.LastName.FldCaption %></span></td>
		<td<%= OrdersLocal.LastName.CellAttributes %>>
<span id="el_OrdersLocal_LastName" class="form-group">
<span<%= OrdersLocal.LastName.ViewAttributes %>>
<%= OrdersLocal.LastName.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrdersLocal.zEmail.Visible Then ' Email %>
	<tr id="r_zEmail">
		<td><span id="elh_OrdersLocal_zEmail"><%= OrdersLocal.zEmail.FldCaption %></span></td>
		<td<%= OrdersLocal.zEmail.CellAttributes %>>
<span id="el_OrdersLocal_zEmail" class="form-group">
<span<%= OrdersLocal.zEmail.ViewAttributes %>>
<%= OrdersLocal.zEmail.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrdersLocal.Phone.Visible Then ' Phone %>
	<tr id="r_Phone">
		<td><span id="elh_OrdersLocal_Phone"><%= OrdersLocal.Phone.FldCaption %></span></td>
		<td<%= OrdersLocal.Phone.CellAttributes %>>
<span id="el_OrdersLocal_Phone" class="form-group">
<span<%= OrdersLocal.Phone.ViewAttributes %>>
<%= OrdersLocal.Phone.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrdersLocal.Address.Visible Then ' Address %>
	<tr id="r_Address">
		<td><span id="elh_OrdersLocal_Address"><%= OrdersLocal.Address.FldCaption %></span></td>
		<td<%= OrdersLocal.Address.CellAttributes %>>
<span id="el_OrdersLocal_Address" class="form-group">
<span<%= OrdersLocal.Address.ViewAttributes %>>
<%= OrdersLocal.Address.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrdersLocal.PostalCode.Visible Then ' PostalCode %>
	<tr id="r_PostalCode">
		<td><span id="elh_OrdersLocal_PostalCode"><%= OrdersLocal.PostalCode.FldCaption %></span></td>
		<td<%= OrdersLocal.PostalCode.CellAttributes %>>
<span id="el_OrdersLocal_PostalCode" class="form-group">
<span<%= OrdersLocal.PostalCode.ViewAttributes %>>
<%= OrdersLocal.PostalCode.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrdersLocal.Notes.Visible Then ' Notes %>
	<tr id="r_Notes">
		<td><span id="elh_OrdersLocal_Notes"><%= OrdersLocal.Notes.FldCaption %></span></td>
		<td<%= OrdersLocal.Notes.CellAttributes %>>
<span id="el_OrdersLocal_Notes" class="form-group">
<span<%= OrdersLocal.Notes.ViewAttributes %>>
<%= OrdersLocal.Notes.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrdersLocal.ttest.Visible Then ' ttest %>
	<tr id="r_ttest">
		<td><span id="elh_OrdersLocal_ttest"><%= OrdersLocal.ttest.FldCaption %></span></td>
		<td<%= OrdersLocal.ttest.CellAttributes %>>
<span id="el_OrdersLocal_ttest" class="form-group">
<span<%= OrdersLocal.ttest.ViewAttributes %>>
<%= OrdersLocal.ttest.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrdersLocal.cancelleddate.Visible Then ' cancelleddate %>
	<tr id="r_cancelleddate">
		<td><span id="elh_OrdersLocal_cancelleddate"><%= OrdersLocal.cancelleddate.FldCaption %></span></td>
		<td<%= OrdersLocal.cancelleddate.CellAttributes %>>
<span id="el_OrdersLocal_cancelleddate" class="form-group">
<span<%= OrdersLocal.cancelleddate.ViewAttributes %>>
<%= OrdersLocal.cancelleddate.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrdersLocal.cancelledby.Visible Then ' cancelledby %>
	<tr id="r_cancelledby">
		<td><span id="elh_OrdersLocal_cancelledby"><%= OrdersLocal.cancelledby.FldCaption %></span></td>
		<td<%= OrdersLocal.cancelledby.CellAttributes %>>
<span id="el_OrdersLocal_cancelledby" class="form-group">
<span<%= OrdersLocal.cancelledby.ViewAttributes %>>
<%= OrdersLocal.cancelledby.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrdersLocal.cancelledreason.Visible Then ' cancelledreason %>
	<tr id="r_cancelledreason">
		<td><span id="elh_OrdersLocal_cancelledreason"><%= OrdersLocal.cancelledreason.FldCaption %></span></td>
		<td<%= OrdersLocal.cancelledreason.CellAttributes %>>
<span id="el_OrdersLocal_cancelledreason" class="form-group">
<span<%= OrdersLocal.cancelledreason.ViewAttributes %>>
<%= OrdersLocal.cancelledreason.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrdersLocal.acknowledgeddate.Visible Then ' acknowledgeddate %>
	<tr id="r_acknowledgeddate">
		<td><span id="elh_OrdersLocal_acknowledgeddate"><%= OrdersLocal.acknowledgeddate.FldCaption %></span></td>
		<td<%= OrdersLocal.acknowledgeddate.CellAttributes %>>
<span id="el_OrdersLocal_acknowledgeddate" class="form-group">
<span<%= OrdersLocal.acknowledgeddate.ViewAttributes %>>
<%= OrdersLocal.acknowledgeddate.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrdersLocal.delivereddate.Visible Then ' delivereddate %>
	<tr id="r_delivereddate">
		<td><span id="elh_OrdersLocal_delivereddate"><%= OrdersLocal.delivereddate.FldCaption %></span></td>
		<td<%= OrdersLocal.delivereddate.CellAttributes %>>
<span id="el_OrdersLocal_delivereddate" class="form-group">
<span<%= OrdersLocal.delivereddate.ViewAttributes %>>
<%= OrdersLocal.delivereddate.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrdersLocal.cancelled.Visible Then ' cancelled %>
	<tr id="r_cancelled">
		<td><span id="elh_OrdersLocal_cancelled"><%= OrdersLocal.cancelled.FldCaption %></span></td>
		<td<%= OrdersLocal.cancelled.CellAttributes %>>
<span id="el_OrdersLocal_cancelled" class="form-group">
<span<%= OrdersLocal.cancelled.ViewAttributes %>>
<%= OrdersLocal.cancelled.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrdersLocal.acknowledged.Visible Then ' acknowledged %>
	<tr id="r_acknowledged">
		<td><span id="elh_OrdersLocal_acknowledged"><%= OrdersLocal.acknowledged.FldCaption %></span></td>
		<td<%= OrdersLocal.acknowledged.CellAttributes %>>
<span id="el_OrdersLocal_acknowledged" class="form-group">
<span<%= OrdersLocal.acknowledged.ViewAttributes %>>
<%= OrdersLocal.acknowledged.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrdersLocal.outfordelivery.Visible Then ' outfordelivery %>
	<tr id="r_outfordelivery">
		<td><span id="elh_OrdersLocal_outfordelivery"><%= OrdersLocal.outfordelivery.FldCaption %></span></td>
		<td<%= OrdersLocal.outfordelivery.CellAttributes %>>
<span id="el_OrdersLocal_outfordelivery" class="form-group">
<span<%= OrdersLocal.outfordelivery.ViewAttributes %>>
<%= OrdersLocal.outfordelivery.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrdersLocal.vouchercodediscount.Visible Then ' vouchercodediscount %>
	<tr id="r_vouchercodediscount">
		<td><span id="elh_OrdersLocal_vouchercodediscount"><%= OrdersLocal.vouchercodediscount.FldCaption %></span></td>
		<td<%= OrdersLocal.vouchercodediscount.CellAttributes %>>
<span id="el_OrdersLocal_vouchercodediscount" class="form-group">
<span<%= OrdersLocal.vouchercodediscount.ViewAttributes %>>
<%= OrdersLocal.vouchercodediscount.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrdersLocal.vouchercode.Visible Then ' vouchercode %>
	<tr id="r_vouchercode">
		<td><span id="elh_OrdersLocal_vouchercode"><%= OrdersLocal.vouchercode.FldCaption %></span></td>
		<td<%= OrdersLocal.vouchercode.CellAttributes %>>
<span id="el_OrdersLocal_vouchercode" class="form-group">
<span<%= OrdersLocal.vouchercode.ViewAttributes %>>
<%= OrdersLocal.vouchercode.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrdersLocal.printed.Visible Then ' printed %>
	<tr id="r_printed">
		<td><span id="elh_OrdersLocal_printed"><%= OrdersLocal.printed.FldCaption %></span></td>
		<td<%= OrdersLocal.printed.CellAttributes %>>
<span id="el_OrdersLocal_printed" class="form-group">
<span<%= OrdersLocal.printed.ViewAttributes %>>
<%= OrdersLocal.printed.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrdersLocal.deliverydistance.Visible Then ' deliverydistance %>
	<tr id="r_deliverydistance">
		<td><span id="elh_OrdersLocal_deliverydistance"><%= OrdersLocal.deliverydistance.FldCaption %></span></td>
		<td<%= OrdersLocal.deliverydistance.CellAttributes %>>
<span id="el_OrdersLocal_deliverydistance" class="form-group">
<span<%= OrdersLocal.deliverydistance.ViewAttributes %>>
<%= OrdersLocal.deliverydistance.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrdersLocal.asaporder.Visible Then ' asaporder %>
	<tr id="r_asaporder">
		<td><span id="elh_OrdersLocal_asaporder"><%= OrdersLocal.asaporder.FldCaption %></span></td>
		<td<%= OrdersLocal.asaporder.CellAttributes %>>
<span id="el_OrdersLocal_asaporder" class="form-group">
<span<%= OrdersLocal.asaporder.ViewAttributes %>>
<%= OrdersLocal.asaporder.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrdersLocal.DeliveryLat.Visible Then ' DeliveryLat %>
	<tr id="r_DeliveryLat">
		<td><span id="elh_OrdersLocal_DeliveryLat"><%= OrdersLocal.DeliveryLat.FldCaption %></span></td>
		<td<%= OrdersLocal.DeliveryLat.CellAttributes %>>
<span id="el_OrdersLocal_DeliveryLat" class="form-group">
<span<%= OrdersLocal.DeliveryLat.ViewAttributes %>>
<%= OrdersLocal.DeliveryLat.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrdersLocal.DeliveryLng.Visible Then ' DeliveryLng %>
	<tr id="r_DeliveryLng">
		<td><span id="elh_OrdersLocal_DeliveryLng"><%= OrdersLocal.DeliveryLng.FldCaption %></span></td>
		<td<%= OrdersLocal.DeliveryLng.CellAttributes %>>
<span id="el_OrdersLocal_DeliveryLng" class="form-group">
<span<%= OrdersLocal.DeliveryLng.ViewAttributes %>>
<%= OrdersLocal.DeliveryLng.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrdersLocal.ServiceCharge.Visible Then ' ServiceCharge %>
	<tr id="r_ServiceCharge">
		<td><span id="elh_OrdersLocal_ServiceCharge"><%= OrdersLocal.ServiceCharge.FldCaption %></span></td>
		<td<%= OrdersLocal.ServiceCharge.CellAttributes %>>
<span id="el_OrdersLocal_ServiceCharge" class="form-group">
<span<%= OrdersLocal.ServiceCharge.ViewAttributes %>>
<%= OrdersLocal.ServiceCharge.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrdersLocal.PaymentSurcharge.Visible Then ' PaymentSurcharge %>
	<tr id="r_PaymentSurcharge">
		<td><span id="elh_OrdersLocal_PaymentSurcharge"><%= OrdersLocal.PaymentSurcharge.FldCaption %></span></td>
		<td<%= OrdersLocal.PaymentSurcharge.CellAttributes %>>
<span id="el_OrdersLocal_PaymentSurcharge" class="form-group">
<span<%= OrdersLocal.PaymentSurcharge.ViewAttributes %>>
<%= OrdersLocal.PaymentSurcharge.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrdersLocal.Tax_Rate.Visible Then ' Tax_Rate %>
	<tr id="r_Tax_Rate">
		<td><span id="elh_OrdersLocal_Tax_Rate"><%= OrdersLocal.Tax_Rate.FldCaption %></span></td>
		<td<%= OrdersLocal.Tax_Rate.CellAttributes %>>
<span id="el_OrdersLocal_Tax_Rate" class="form-group">
<span<%= OrdersLocal.Tax_Rate.ViewAttributes %>>
<%= OrdersLocal.Tax_Rate.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrdersLocal.Tax_Amount.Visible Then ' Tax_Amount %>
	<tr id="r_Tax_Amount">
		<td><span id="elh_OrdersLocal_Tax_Amount"><%= OrdersLocal.Tax_Amount.FldCaption %></span></td>
		<td<%= OrdersLocal.Tax_Amount.CellAttributes %>>
<span id="el_OrdersLocal_Tax_Amount" class="form-group">
<span<%= OrdersLocal.Tax_Amount.ViewAttributes %>>
<%= OrdersLocal.Tax_Amount.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrdersLocal.Tip_Rate.Visible Then ' Tip_Rate %>
	<tr id="r_Tip_Rate">
		<td><span id="elh_OrdersLocal_Tip_Rate"><%= OrdersLocal.Tip_Rate.FldCaption %></span></td>
		<td<%= OrdersLocal.Tip_Rate.CellAttributes %>>
<span id="el_OrdersLocal_Tip_Rate" class="form-group">
<span<%= OrdersLocal.Tip_Rate.ViewAttributes %>>
<%= OrdersLocal.Tip_Rate.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrdersLocal.Tip_Amount.Visible Then ' Tip_Amount %>
	<tr id="r_Tip_Amount">
		<td><span id="elh_OrdersLocal_Tip_Amount"><%= OrdersLocal.Tip_Amount.FldCaption %></span></td>
		<td<%= OrdersLocal.Tip_Amount.CellAttributes %>>
<span id="el_OrdersLocal_Tip_Amount" class="form-group">
<span<%= OrdersLocal.Tip_Amount.ViewAttributes %>>
<%= OrdersLocal.Tip_Amount.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If OrdersLocal.Payment_status.Visible Then ' Payment_status %>
	<tr id="r_Payment_status">
		<td><span id="elh_OrdersLocal_Payment_status"><%= OrdersLocal.Payment_status.FldCaption %></span></td>
		<td<%= OrdersLocal.Payment_status.CellAttributes %>>
<span id="el_OrdersLocal_Payment_status" class="form-group">
<span<%= OrdersLocal.Payment_status.ViewAttributes %>>
<%= OrdersLocal.Payment_status.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
</table>
<% If OrdersLocal.Export = "" Then %>
<% If Not IsObject(OrdersLocal_view.Pager) Then Set OrdersLocal_view.Pager = ew_NewPrevNextPager(OrdersLocal_view.StartRec, OrdersLocal_view.DisplayRecs, OrdersLocal_view.TotalRecs) %>
<% If OrdersLocal_view.Pager.RecordCount > 0 Then %>
<div class="ewPager">
<span><%= Language.Phrase("Page") %>&nbsp;</span>
<div class="ewPrevNext"><div class="input-group">
<div class="input-group-btn">
<!--first page button-->
	<% If OrdersLocal_view.Pager.FirstButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerFirst") %>" href="<%= OrdersLocal_view.PageUrl %>start=<%= OrdersLocal_view.Pager.FirstButton.Start %>"><span class="icon-first ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerFirst") %>"><span class="icon-first ewIcon"></span></a>
	<% End If %>
<!--previous page button-->
	<% If OrdersLocal_view.Pager.PrevButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerPrevious") %>" href="<%= OrdersLocal_view.PageUrl %>start=<%= OrdersLocal_view.Pager.PrevButton.Start %>"><span class="icon-prev ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerPrevious") %>"><span class="icon-prev ewIcon"></span></a>
	<% End If %>
</div>
<!--current page number-->
	<input class="form-control input-sm" type="text" name="<%= EW_TABLE_PAGE_NO %>" value="<%= OrdersLocal_view.Pager.CurrentPage %>">
<div class="input-group-btn">
<!--next page button-->
	<% If OrdersLocal_view.Pager.NextButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerNext") %>" href="<%= OrdersLocal_view.PageUrl %>start=<%= OrdersLocal_view.Pager.NextButton.Start %>"><span class="icon-next ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerNext") %>"><span class="icon-next ewIcon"></span></a>
	<% End If %>
<!--last page button-->
	<% If OrdersLocal_view.Pager.LastButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerLast") %>" href="<%= OrdersLocal_view.PageUrl %>start=<%= OrdersLocal_view.Pager.LastButton.Start %>"><span class="icon-last ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerLast") %>"><span class="icon-last ewIcon"></span></a>
	<% End If %>
</div>
</div>
</div>
<span>&nbsp;<%= Language.Phrase("of") %>&nbsp;<%= OrdersLocal_view.Pager.PageCount %></span>
</div>
<% End If %>
<div class="clearfix"></div>
<% End If %>
</form>
<% If OrdersLocal.Export <> "" Then %>
<script type="text/javascript">
ew_ApplyTemplate("body", "", "OrdersLocalview", "<%= OrdersLocal.CustomExport %>");
</script>
<% End If %>
<script type="text/javascript">
fOrdersLocalview.Init();
</script>
<%
OrdersLocal_view.ShowPageFooter()
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
Set OrdersLocal_view = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cOrdersLocal_view

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
		TableName = "OrdersLocal"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "OrdersLocal_view"
	End Property

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
		EW_TABLE_NAME = "OrdersLocal"

		' Open connection to the database
		If IsEmpty(Conn) Then Call ew_Connect()

		' Export options
		Set ExportOptions = New cListOptions
		ExportOptions.TableVar = OrdersLocal.TableVar
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
		If OrdersLocal.Export = "" Then
			SetupBreadcrumb()
		End If
		If IsPageRequest Then ' Validate request
			If Request.QueryString("ID").Count > 0 Then
				OrdersLocal.ID.QueryStringValue = Request.QueryString("ID")
			ElseIf Request.Form("ID").Count > 0 Then
				OrdersLocal.ID.FormValue = Request.Form("ID")
			Else
				bLoadCurrentRecord = True
			End If

			' Get action
			OrdersLocal.CurrentAction = "I" ' Display form
			Select Case OrdersLocal.CurrentAction
				Case "I" ' Get a record to display
					StartRec = 1 ' Initialize start position
					Set Recordset = LoadRecordset() ' Load records
					TotalRecs = Recordset.RecordCount ' Get record count
					If TotalRecs <= 0 Then ' No record found
						If SuccessMessage = "" And FailureMessage = "" Then
							FailureMessage = Language.Phrase("NoRecord") ' Set no record message
						End If
						sReturnUrl = "OrdersLocallist.asp"
					ElseIf bLoadCurrentRecord Then ' Load current record position
						SetUpStartRec() ' Set up start record position

						' Point to current record
						If CLng(StartRec) <= CLng(TotalRecs) Then
							bMatchRecord = True
							Recordset.Move StartRec-1
						End If
					Else ' Match key values
						Do While Not Recordset.Eof
							If CStr(OrdersLocal.ID.CurrentValue&"") = CStr(Recordset("ID")&"") Then
								OrdersLocal.StartRecordNumber = StartRec ' Save record position
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
						sReturnUrl = "OrdersLocallist.asp" ' No matching record, return to list
					Else
						Call LoadRowValues(Recordset) ' Load row values
					End If
			End Select
		Else
			sReturnUrl = "OrdersLocallist.asp" ' Not page request, return to list
		End If
		If sReturnUrl <> "" Then Call Page_Terminate(sReturnUrl)

		' Render row
		OrdersLocal.RowType = EW_ROWTYPE_VIEW
		Call OrdersLocal.ResetAttrs()
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

	' -----------------------------------------------------------------
	' Render row values based on field settings
	'
	Sub RenderRow()

		' Initialize urls
		AddUrl = OrdersLocal.AddUrl("")
		EditUrl = OrdersLocal.EditUrl("")
		CopyUrl = OrdersLocal.CopyUrl("")
		DeleteUrl = OrdersLocal.DeleteUrl
		ListUrl = OrdersLocal.ListUrl
		SetupOtherOptions()

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

	' Set up Breadcrumb
	Sub SetupBreadcrumb()
		Dim PageId, url
		Set Breadcrumb = New cBreadcrumb
		url = Mid(ew_CurrentUrl, InStrRev(ew_CurrentUrl, "/")+1)
		Call Breadcrumb.Add("list", OrdersLocal.TableVar, "OrdersLocallist.asp", "", OrdersLocal.TableVar, True)
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
