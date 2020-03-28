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
Dim Orders_delete
Set Orders_delete = New cOrders_delete
Set Page = Orders_delete

' Page init processing
Orders_delete.Page_Init()

' Page main processing
Orders_delete.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
Orders_delete.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var Orders_delete = new ew_Page("Orders_delete");
Orders_delete.PageID = "delete"; // Page ID
var EW_PAGE_ID = Orders_delete.PageID; // For backward compatibility
// Form object
var fOrdersdelete = new ew_Form("fOrdersdelete");
// Form_CustomValidate event
fOrdersdelete.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fOrdersdelete.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fOrdersdelete.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<%

' Load records for display
Set Orders_delete.Recordset = Orders_delete.LoadRecordset()
Orders_delete.TotalRecs = Orders_delete.Recordset.RecordCount ' Get record count
If Orders_delete.TotalRecs <= 0 Then ' No record found, exit
	Orders_delete.Recordset.Close
	Set Orders_delete.Recordset = Nothing
	Call Orders_delete.Page_Terminate("Orderslist.asp") ' Return to list
End If
%>
<div class="ewToolbar">
<% If Orders.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If Orders.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% Orders_delete.ShowPageHeader() %>
<% Orders_delete.ShowMessage %>
<form name="fOrdersdelete" id="fOrdersdelete" class="form-inline ewForm ewDeleteForm" action="<%= ew_CurrentPage() %>" method="post">
<% If Orders_delete.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= Orders_delete.Token %>">
<% End If %>
<input type="hidden" name="t" value="Orders">
<input type="hidden" name="a_delete" id="a_delete" value="D">
<% For i = 0 to UBound(Orders_delete.RecKeys) %>
<input type="hidden" name="key_m" id="key_m" value="<%= ew_HtmlEncode(ew_GetKeyValue(Orders_delete.RecKeys(i))) %>">
<% Next %>
<div class="ewGrid">
<div class="<% If ew_IsResponsiveLayout() Then Response.Write "table-responsive " %>ewGridMiddlePanel">
<table class="table ewTable">
<%= Orders.TableCustomInnerHtml %>
	<thead>
	<tr class="ewTableHeader">
<% If Orders.ID.Visible Then ' ID %>
		<th><span id="elh_Orders_ID" class="Orders_ID"><%= Orders.ID.FldCaption %></span></th>
<% End If %>
<% If Orders.CreationDate.Visible Then ' CreationDate %>
		<th><span id="elh_Orders_CreationDate" class="Orders_CreationDate"><%= Orders.CreationDate.FldCaption %></span></th>
<% End If %>
<% If Orders.OrderDate.Visible Then ' OrderDate %>
		<th><span id="elh_Orders_OrderDate" class="Orders_OrderDate"><%= Orders.OrderDate.FldCaption %></span></th>
<% End If %>
<% If Orders.DeliveryType.Visible Then ' DeliveryType %>
		<th><span id="elh_Orders_DeliveryType" class="Orders_DeliveryType"><%= Orders.DeliveryType.FldCaption %></span></th>
<% End If %>
<% If Orders.DeliveryTime.Visible Then ' DeliveryTime %>
		<th><span id="elh_Orders_DeliveryTime" class="Orders_DeliveryTime"><%= Orders.DeliveryTime.FldCaption %></span></th>
<% End If %>
<% If Orders.PaymentType.Visible Then ' PaymentType %>
		<th><span id="elh_Orders_PaymentType" class="Orders_PaymentType"><%= Orders.PaymentType.FldCaption %></span></th>
<% End If %>
<% If Orders.SubTotal.Visible Then ' SubTotal %>
		<th><span id="elh_Orders_SubTotal" class="Orders_SubTotal"><%= Orders.SubTotal.FldCaption %></span></th>
<% End If %>
<% If Orders.ShippingFee.Visible Then ' ShippingFee %>
		<th><span id="elh_Orders_ShippingFee" class="Orders_ShippingFee"><%= Orders.ShippingFee.FldCaption %></span></th>
<% End If %>
<% If Orders.OrderTotal.Visible Then ' OrderTotal %>
		<th><span id="elh_Orders_OrderTotal" class="Orders_OrderTotal"><%= Orders.OrderTotal.FldCaption %></span></th>
<% End If %>
<% If Orders.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
		<th><span id="elh_Orders_IdBusinessDetail" class="Orders_IdBusinessDetail"><%= Orders.IdBusinessDetail.FldCaption %></span></th>
<% End If %>
<% If Orders.SessionId.Visible Then ' SessionId %>
		<th><span id="elh_Orders_SessionId" class="Orders_SessionId"><%= Orders.SessionId.FldCaption %></span></th>
<% End If %>
<% If Orders.FirstName.Visible Then ' FirstName %>
		<th><span id="elh_Orders_FirstName" class="Orders_FirstName"><%= Orders.FirstName.FldCaption %></span></th>
<% End If %>
<% If Orders.LastName.Visible Then ' LastName %>
		<th><span id="elh_Orders_LastName" class="Orders_LastName"><%= Orders.LastName.FldCaption %></span></th>
<% End If %>
<% If Orders.zEmail.Visible Then ' Email %>
		<th><span id="elh_Orders_zEmail" class="Orders_zEmail"><%= Orders.zEmail.FldCaption %></span></th>
<% End If %>
<% If Orders.Phone.Visible Then ' Phone %>
		<th><span id="elh_Orders_Phone" class="Orders_Phone"><%= Orders.Phone.FldCaption %></span></th>
<% End If %>
<% If Orders.Address.Visible Then ' Address %>
		<th><span id="elh_Orders_Address" class="Orders_Address"><%= Orders.Address.FldCaption %></span></th>
<% End If %>
<% If Orders.PostalCode.Visible Then ' PostalCode %>
		<th><span id="elh_Orders_PostalCode" class="Orders_PostalCode"><%= Orders.PostalCode.FldCaption %></span></th>
<% End If %>
<% If Orders.ttest.Visible Then ' ttest %>
		<th><span id="elh_Orders_ttest" class="Orders_ttest"><%= Orders.ttest.FldCaption %></span></th>
<% End If %>
<% If Orders.cancelleddate.Visible Then ' cancelleddate %>
		<th><span id="elh_Orders_cancelleddate" class="Orders_cancelleddate"><%= Orders.cancelleddate.FldCaption %></span></th>
<% End If %>
<% If Orders.cancelledby.Visible Then ' cancelledby %>
		<th><span id="elh_Orders_cancelledby" class="Orders_cancelledby"><%= Orders.cancelledby.FldCaption %></span></th>
<% End If %>
<% If Orders.cancelledreason.Visible Then ' cancelledreason %>
		<th><span id="elh_Orders_cancelledreason" class="Orders_cancelledreason"><%= Orders.cancelledreason.FldCaption %></span></th>
<% End If %>
<% If Orders.acknowledgeddate.Visible Then ' acknowledgeddate %>
		<th><span id="elh_Orders_acknowledgeddate" class="Orders_acknowledgeddate"><%= Orders.acknowledgeddate.FldCaption %></span></th>
<% End If %>
<% If Orders.delivereddate.Visible Then ' delivereddate %>
		<th><span id="elh_Orders_delivereddate" class="Orders_delivereddate"><%= Orders.delivereddate.FldCaption %></span></th>
<% End If %>
<% If Orders.cancelled.Visible Then ' cancelled %>
		<th><span id="elh_Orders_cancelled" class="Orders_cancelled"><%= Orders.cancelled.FldCaption %></span></th>
<% End If %>
<% If Orders.acknowledged.Visible Then ' acknowledged %>
		<th><span id="elh_Orders_acknowledged" class="Orders_acknowledged"><%= Orders.acknowledged.FldCaption %></span></th>
<% End If %>
<% If Orders.outfordelivery.Visible Then ' outfordelivery %>
		<th><span id="elh_Orders_outfordelivery" class="Orders_outfordelivery"><%= Orders.outfordelivery.FldCaption %></span></th>
<% End If %>
<% If Orders.vouchercodediscount.Visible Then ' vouchercodediscount %>
		<th><span id="elh_Orders_vouchercodediscount" class="Orders_vouchercodediscount"><%= Orders.vouchercodediscount.FldCaption %></span></th>
<% End If %>
<% If Orders.vouchercode.Visible Then ' vouchercode %>
		<th><span id="elh_Orders_vouchercode" class="Orders_vouchercode"><%= Orders.vouchercode.FldCaption %></span></th>
<% End If %>
<% If Orders.printed.Visible Then ' printed %>
		<th><span id="elh_Orders_printed" class="Orders_printed"><%= Orders.printed.FldCaption %></span></th>
<% End If %>
<% If Orders.deliverydistance.Visible Then ' deliverydistance %>
		<th><span id="elh_Orders_deliverydistance" class="Orders_deliverydistance"><%= Orders.deliverydistance.FldCaption %></span></th>
<% End If %>
<% If Orders.asaporder.Visible Then ' asaporder %>
		<th><span id="elh_Orders_asaporder" class="Orders_asaporder"><%= Orders.asaporder.FldCaption %></span></th>
<% End If %>
<% If Orders.DeliveryLat.Visible Then ' DeliveryLat %>
		<th><span id="elh_Orders_DeliveryLat" class="Orders_DeliveryLat"><%= Orders.DeliveryLat.FldCaption %></span></th>
<% End If %>
<% If Orders.DeliveryLng.Visible Then ' DeliveryLng %>
		<th><span id="elh_Orders_DeliveryLng" class="Orders_DeliveryLng"><%= Orders.DeliveryLng.FldCaption %></span></th>
<% End If %>
<% If Orders.ServiceCharge.Visible Then ' ServiceCharge %>
		<th><span id="elh_Orders_ServiceCharge" class="Orders_ServiceCharge"><%= Orders.ServiceCharge.FldCaption %></span></th>
<% End If %>
<% If Orders.PaymentSurcharge.Visible Then ' PaymentSurcharge %>
		<th><span id="elh_Orders_PaymentSurcharge" class="Orders_PaymentSurcharge"><%= Orders.PaymentSurcharge.FldCaption %></span></th>
<% End If %>
<% If Orders.FromIP.Visible Then ' FromIP %>
		<th><span id="elh_Orders_FromIP" class="Orders_FromIP"><%= Orders.FromIP.FldCaption %></span></th>
<% End If %>
<% If Orders.SentEmail.Visible Then ' SentEmail %>
		<th><span id="elh_Orders_SentEmail" class="Orders_SentEmail"><%= Orders.SentEmail.FldCaption %></span></th>
<% End If %>
<% If Orders.Tax_Rate.Visible Then ' Tax_Rate %>
		<th><span id="elh_Orders_Tax_Rate" class="Orders_Tax_Rate"><%= Orders.Tax_Rate.FldCaption %></span></th>
<% End If %>
<% If Orders.Tax_Amount.Visible Then ' Tax_Amount %>
		<th><span id="elh_Orders_Tax_Amount" class="Orders_Tax_Amount"><%= Orders.Tax_Amount.FldCaption %></span></th>
<% End If %>
<% If Orders.Tip_Rate.Visible Then ' Tip_Rate %>
		<th><span id="elh_Orders_Tip_Rate" class="Orders_Tip_Rate"><%= Orders.Tip_Rate.FldCaption %></span></th>
<% End If %>
<% If Orders.Tip_Amount.Visible Then ' Tip_Amount %>
		<th><span id="elh_Orders_Tip_Amount" class="Orders_Tip_Amount"><%= Orders.Tip_Amount.FldCaption %></span></th>
<% End If %>
<% If Orders.Card_Debit.Visible Then ' Card_Debit %>
		<th><span id="elh_Orders_Card_Debit" class="Orders_Card_Debit"><%= Orders.Card_Debit.FldCaption %></span></th>
<% End If %>
<% If Orders.Card_Credit.Visible Then ' Card_Credit %>
		<th><span id="elh_Orders_Card_Credit" class="Orders_Card_Credit"><%= Orders.Card_Credit.FldCaption %></span></th>
<% End If %>
<% If Orders.deliverydelay.Visible Then ' deliverydelay %>
		<th><span id="elh_Orders_deliverydelay" class="Orders_deliverydelay"><%= Orders.deliverydelay.FldCaption %></span></th>
<% End If %>
<% If Orders.collectiondelay.Visible Then ' collectiondelay %>
		<th><span id="elh_Orders_collectiondelay" class="Orders_collectiondelay"><%= Orders.collectiondelay.FldCaption %></span></th>
<% End If %>
<% If Orders.lng_report.Visible Then ' lng_report %>
		<th><span id="elh_Orders_lng_report" class="Orders_lng_report"><%= Orders.lng_report.FldCaption %></span></th>
<% End If %>
<% If Orders.lat_report.Visible Then ' lat_report %>
		<th><span id="elh_Orders_lat_report" class="Orders_lat_report"><%= Orders.lat_report.FldCaption %></span></th>
<% End If %>
<% If Orders.Payment_status.Visible Then ' Payment_status %>
		<th><span id="elh_Orders_Payment_status" class="Orders_Payment_status"><%= Orders.Payment_status.FldCaption %></span></th>
<% End If %>
	</tr>
	</thead>
	<tbody>
<%
Orders_delete.RecCnt = 0
Orders_delete.RowCnt = 0
Do While (Not Orders_delete.Recordset.Eof)
	Orders_delete.RecCnt = Orders_delete.RecCnt + 1
	Orders_delete.RowCnt = Orders_delete.RowCnt + 1

	' Set row properties
	Call Orders.ResetAttrs()
	Orders.RowType = EW_ROWTYPE_VIEW ' view

	' Get the field contents
	Call Orders_delete.LoadRowValues(Orders_delete.Recordset)

	' Render row
	Call Orders_delete.RenderRow()
%>
	<tr<%= Orders.RowAttributes %>>
<% If Orders.ID.Visible Then ' ID %>
		<td<%= Orders.ID.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_ID" class="form-group Orders_ID">
<span<%= Orders.ID.ViewAttributes %>>
<%= Orders.ID.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.CreationDate.Visible Then ' CreationDate %>
		<td<%= Orders.CreationDate.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_CreationDate" class="form-group Orders_CreationDate">
<span<%= Orders.CreationDate.ViewAttributes %>>
<%= Orders.CreationDate.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.OrderDate.Visible Then ' OrderDate %>
		<td<%= Orders.OrderDate.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_OrderDate" class="form-group Orders_OrderDate">
<span<%= Orders.OrderDate.ViewAttributes %>>
<%= Orders.OrderDate.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.DeliveryType.Visible Then ' DeliveryType %>
		<td<%= Orders.DeliveryType.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_DeliveryType" class="form-group Orders_DeliveryType">
<span<%= Orders.DeliveryType.ViewAttributes %>>
<%= Orders.DeliveryType.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.DeliveryTime.Visible Then ' DeliveryTime %>
		<td<%= Orders.DeliveryTime.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_DeliveryTime" class="form-group Orders_DeliveryTime">
<span<%= Orders.DeliveryTime.ViewAttributes %>>
<%= Orders.DeliveryTime.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.PaymentType.Visible Then ' PaymentType %>
		<td<%= Orders.PaymentType.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_PaymentType" class="form-group Orders_PaymentType">
<span<%= Orders.PaymentType.ViewAttributes %>>
<%= Orders.PaymentType.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.SubTotal.Visible Then ' SubTotal %>
		<td<%= Orders.SubTotal.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_SubTotal" class="form-group Orders_SubTotal">
<span<%= Orders.SubTotal.ViewAttributes %>>
<%= Orders.SubTotal.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.ShippingFee.Visible Then ' ShippingFee %>
		<td<%= Orders.ShippingFee.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_ShippingFee" class="form-group Orders_ShippingFee">
<span<%= Orders.ShippingFee.ViewAttributes %>>
<%= Orders.ShippingFee.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.OrderTotal.Visible Then ' OrderTotal %>
		<td<%= Orders.OrderTotal.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_OrderTotal" class="form-group Orders_OrderTotal">
<span<%= Orders.OrderTotal.ViewAttributes %>>
<%= Orders.OrderTotal.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
		<td<%= Orders.IdBusinessDetail.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_IdBusinessDetail" class="form-group Orders_IdBusinessDetail">
<span<%= Orders.IdBusinessDetail.ViewAttributes %>>
<%= Orders.IdBusinessDetail.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.SessionId.Visible Then ' SessionId %>
		<td<%= Orders.SessionId.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_SessionId" class="form-group Orders_SessionId">
<span<%= Orders.SessionId.ViewAttributes %>>
<%= Orders.SessionId.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.FirstName.Visible Then ' FirstName %>
		<td<%= Orders.FirstName.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_FirstName" class="form-group Orders_FirstName">
<span<%= Orders.FirstName.ViewAttributes %>>
<%= Orders.FirstName.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.LastName.Visible Then ' LastName %>
		<td<%= Orders.LastName.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_LastName" class="form-group Orders_LastName">
<span<%= Orders.LastName.ViewAttributes %>>
<%= Orders.LastName.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.zEmail.Visible Then ' Email %>
		<td<%= Orders.zEmail.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_zEmail" class="form-group Orders_zEmail">
<span<%= Orders.zEmail.ViewAttributes %>>
<%= Orders.zEmail.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.Phone.Visible Then ' Phone %>
		<td<%= Orders.Phone.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_Phone" class="form-group Orders_Phone">
<span<%= Orders.Phone.ViewAttributes %>>
<%= Orders.Phone.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.Address.Visible Then ' Address %>
		<td<%= Orders.Address.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_Address" class="form-group Orders_Address">
<span<%= Orders.Address.ViewAttributes %>>
<%= Orders.Address.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.PostalCode.Visible Then ' PostalCode %>
		<td<%= Orders.PostalCode.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_PostalCode" class="form-group Orders_PostalCode">
<span<%= Orders.PostalCode.ViewAttributes %>>
<%= Orders.PostalCode.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.ttest.Visible Then ' ttest %>
		<td<%= Orders.ttest.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_ttest" class="form-group Orders_ttest">
<span<%= Orders.ttest.ViewAttributes %>>
<%= Orders.ttest.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.cancelleddate.Visible Then ' cancelleddate %>
		<td<%= Orders.cancelleddate.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_cancelleddate" class="form-group Orders_cancelleddate">
<span<%= Orders.cancelleddate.ViewAttributes %>>
<%= Orders.cancelleddate.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.cancelledby.Visible Then ' cancelledby %>
		<td<%= Orders.cancelledby.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_cancelledby" class="form-group Orders_cancelledby">
<span<%= Orders.cancelledby.ViewAttributes %>>
<%= Orders.cancelledby.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.cancelledreason.Visible Then ' cancelledreason %>
		<td<%= Orders.cancelledreason.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_cancelledreason" class="form-group Orders_cancelledreason">
<span<%= Orders.cancelledreason.ViewAttributes %>>
<%= Orders.cancelledreason.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.acknowledgeddate.Visible Then ' acknowledgeddate %>
		<td<%= Orders.acknowledgeddate.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_acknowledgeddate" class="form-group Orders_acknowledgeddate">
<span<%= Orders.acknowledgeddate.ViewAttributes %>>
<%= Orders.acknowledgeddate.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.delivereddate.Visible Then ' delivereddate %>
		<td<%= Orders.delivereddate.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_delivereddate" class="form-group Orders_delivereddate">
<span<%= Orders.delivereddate.ViewAttributes %>>
<%= Orders.delivereddate.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.cancelled.Visible Then ' cancelled %>
		<td<%= Orders.cancelled.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_cancelled" class="form-group Orders_cancelled">
<span<%= Orders.cancelled.ViewAttributes %>>
<%= Orders.cancelled.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.acknowledged.Visible Then ' acknowledged %>
		<td<%= Orders.acknowledged.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_acknowledged" class="form-group Orders_acknowledged">
<span<%= Orders.acknowledged.ViewAttributes %>>
<%= Orders.acknowledged.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.outfordelivery.Visible Then ' outfordelivery %>
		<td<%= Orders.outfordelivery.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_outfordelivery" class="form-group Orders_outfordelivery">
<span<%= Orders.outfordelivery.ViewAttributes %>>
<%= Orders.outfordelivery.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.vouchercodediscount.Visible Then ' vouchercodediscount %>
		<td<%= Orders.vouchercodediscount.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_vouchercodediscount" class="form-group Orders_vouchercodediscount">
<span<%= Orders.vouchercodediscount.ViewAttributes %>>
<%= Orders.vouchercodediscount.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.vouchercode.Visible Then ' vouchercode %>
		<td<%= Orders.vouchercode.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_vouchercode" class="form-group Orders_vouchercode">
<span<%= Orders.vouchercode.ViewAttributes %>>
<%= Orders.vouchercode.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.printed.Visible Then ' printed %>
		<td<%= Orders.printed.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_printed" class="form-group Orders_printed">
<span<%= Orders.printed.ViewAttributes %>>
<%= Orders.printed.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.deliverydistance.Visible Then ' deliverydistance %>
		<td<%= Orders.deliverydistance.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_deliverydistance" class="form-group Orders_deliverydistance">
<span<%= Orders.deliverydistance.ViewAttributes %>>
<%= Orders.deliverydistance.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.asaporder.Visible Then ' asaporder %>
		<td<%= Orders.asaporder.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_asaporder" class="form-group Orders_asaporder">
<span<%= Orders.asaporder.ViewAttributes %>>
<%= Orders.asaporder.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.DeliveryLat.Visible Then ' DeliveryLat %>
		<td<%= Orders.DeliveryLat.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_DeliveryLat" class="form-group Orders_DeliveryLat">
<span<%= Orders.DeliveryLat.ViewAttributes %>>
<%= Orders.DeliveryLat.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.DeliveryLng.Visible Then ' DeliveryLng %>
		<td<%= Orders.DeliveryLng.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_DeliveryLng" class="form-group Orders_DeliveryLng">
<span<%= Orders.DeliveryLng.ViewAttributes %>>
<%= Orders.DeliveryLng.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.ServiceCharge.Visible Then ' ServiceCharge %>
		<td<%= Orders.ServiceCharge.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_ServiceCharge" class="form-group Orders_ServiceCharge">
<span<%= Orders.ServiceCharge.ViewAttributes %>>
<%= Orders.ServiceCharge.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.PaymentSurcharge.Visible Then ' PaymentSurcharge %>
		<td<%= Orders.PaymentSurcharge.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_PaymentSurcharge" class="form-group Orders_PaymentSurcharge">
<span<%= Orders.PaymentSurcharge.ViewAttributes %>>
<%= Orders.PaymentSurcharge.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.FromIP.Visible Then ' FromIP %>
		<td<%= Orders.FromIP.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_FromIP" class="form-group Orders_FromIP">
<span<%= Orders.FromIP.ViewAttributes %>>
<%= Orders.FromIP.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.SentEmail.Visible Then ' SentEmail %>
		<td<%= Orders.SentEmail.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_SentEmail" class="form-group Orders_SentEmail">
<span<%= Orders.SentEmail.ViewAttributes %>>
<%= Orders.SentEmail.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.Tax_Rate.Visible Then ' Tax_Rate %>
		<td<%= Orders.Tax_Rate.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_Tax_Rate" class="form-group Orders_Tax_Rate">
<span<%= Orders.Tax_Rate.ViewAttributes %>>
<%= Orders.Tax_Rate.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.Tax_Amount.Visible Then ' Tax_Amount %>
		<td<%= Orders.Tax_Amount.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_Tax_Amount" class="form-group Orders_Tax_Amount">
<span<%= Orders.Tax_Amount.ViewAttributes %>>
<%= Orders.Tax_Amount.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.Tip_Rate.Visible Then ' Tip_Rate %>
		<td<%= Orders.Tip_Rate.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_Tip_Rate" class="form-group Orders_Tip_Rate">
<span<%= Orders.Tip_Rate.ViewAttributes %>>
<%= Orders.Tip_Rate.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.Tip_Amount.Visible Then ' Tip_Amount %>
		<td<%= Orders.Tip_Amount.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_Tip_Amount" class="form-group Orders_Tip_Amount">
<span<%= Orders.Tip_Amount.ViewAttributes %>>
<%= Orders.Tip_Amount.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.Card_Debit.Visible Then ' Card_Debit %>
		<td<%= Orders.Card_Debit.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_Card_Debit" class="form-group Orders_Card_Debit">
<span<%= Orders.Card_Debit.ViewAttributes %>>
<%= Orders.Card_Debit.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.Card_Credit.Visible Then ' Card_Credit %>
		<td<%= Orders.Card_Credit.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_Card_Credit" class="form-group Orders_Card_Credit">
<span<%= Orders.Card_Credit.ViewAttributes %>>
<%= Orders.Card_Credit.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.deliverydelay.Visible Then ' deliverydelay %>
		<td<%= Orders.deliverydelay.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_deliverydelay" class="form-group Orders_deliverydelay">
<span<%= Orders.deliverydelay.ViewAttributes %>>
<%= Orders.deliverydelay.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.collectiondelay.Visible Then ' collectiondelay %>
		<td<%= Orders.collectiondelay.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_collectiondelay" class="form-group Orders_collectiondelay">
<span<%= Orders.collectiondelay.ViewAttributes %>>
<%= Orders.collectiondelay.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.lng_report.Visible Then ' lng_report %>
		<td<%= Orders.lng_report.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_lng_report" class="form-group Orders_lng_report">
<span<%= Orders.lng_report.ViewAttributes %>>
<%= Orders.lng_report.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.lat_report.Visible Then ' lat_report %>
		<td<%= Orders.lat_report.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_lat_report" class="form-group Orders_lat_report">
<span<%= Orders.lat_report.ViewAttributes %>>
<%= Orders.lat_report.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If Orders.Payment_status.Visible Then ' Payment_status %>
		<td<%= Orders.Payment_status.CellAttributes %>>
<span id="el<%= Orders_delete.RowCnt %>_Orders_Payment_status" class="form-group Orders_Payment_status">
<span<%= Orders.Payment_status.ViewAttributes %>>
<%= Orders.Payment_status.ListViewValue %>
</span>
</span>
</td>
<% End If %>
	</tr>
<%
	Orders_delete.Recordset.MoveNext
Loop
Orders_delete.Recordset.Close
Set Orders_delete.Recordset = Nothing
%>
	</tbody>
</table>
</div>
</div>
<div class="btn-group ewButtonGroup">
<button class="btn btn-primary ewButton" name="btnAction" id="btnAction" type="submit"><%= Language.Phrase("DeleteBtn") %></button>
</div>
</form>
<script type="text/javascript">
fOrdersdelete.Init();
</script>
<%
Orders_delete.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set Orders_delete = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cOrders_delete

	' Page ID
	Public Property Get PageID()
		PageID = "delete"
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
		PageObjName = "Orders_delete"
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

		' Initialize urls
		' Initialize form object

		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "delete"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "Orders"

		' Open connection to the database
		If IsEmpty(Conn) Then Call ew_Connect()
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
	Dim StartRec
	Dim TotalRecs
	Dim RecCnt
	Dim RecKeys
	Dim Recordset
	Dim StartRowCnt
	Dim RowCnt

	' Page main processing
	Sub Page_Main()
		Dim sFilter
		StartRowCnt = 1

		' Set up Breadcrumb
		SetupBreadcrumb()

		' Load Key Parameters
		RecKeys = Orders.GetRecordKeys() ' Load record keys
		sFilter = Orders.GetKeyFilter()
		If sFilter = "" Then
			Call Page_Terminate("Orderslist.asp") ' Prevent SQL injection, return to list
		End If

		' Set up filter (Sql Where Clause) and get Return Sql
		' Sql constructor in Orders class, Ordersinfo.asp

		Orders.CurrentFilter = sFilter

		' Get action
		If Request.Form("a_delete").Count > 0 Then
			Orders.CurrentAction = Request.Form("a_delete")
		Else
			Orders.CurrentAction = "D"	' Delete record directly
		End If
		Select Case Orders.CurrentAction
			Case "D" ' Delete
				Orders.SendEmail = True ' Send email on delete success
				If DeleteRows() Then ' Delete rows
					If SuccessMessage = "" Then SuccessMessage = Language.Phrase("DeleteSuccess") ' Set up success message
					Call Page_Terminate(Orders.ReturnUrl) ' Return to caller
				End If
		End Select
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
		sSql = Orders.SQL
		Conn.BeginTrans
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
				DeleteRows = Orders.Row_Deleting(RsDelete)
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
			ElseIf Orders.CancelMessage <> "" Then
				FailureMessage = Orders.CancelMessage
				Orders.CancelMessage = ""
			Else
				FailureMessage = Language.Phrase("DeleteCancelled")
			End If
		End If
		If DeleteRows Then
			Conn.CommitTrans ' Commit the changes
			If Err.Number <> 0 Then
				FailureMessage = Err.Description
				DeleteRows = False ' Delete failed
			End If
		Else
			Conn.RollbackTrans ' Rollback changes
		End If
		RsDelete.Close
		Set RsDelete = Nothing

		' Call row deleting event
		If DeleteRows Then
			RsOld.MoveFirst
			Do While Not RsOld.Eof
				Call Orders.Row_Deleted(RsOld)
				RsOld.MoveNext
			Loop
		End If
		RsOld.Close
		Set RsOld = Nothing
	End Function

	' Set up Breadcrumb
	Sub SetupBreadcrumb()
		Dim PageId, url
		Set Breadcrumb = New cBreadcrumb
		url = Mid(ew_CurrentUrl, InStrRev(ew_CurrentUrl, "/")+1)
		Call Breadcrumb.Add("list", Orders.TableVar, "Orderslist.asp", "", Orders.TableVar, True)
		PageId = "delete"
		Call Breadcrumb.Add("delete", PageId, url, "", "", False)
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
End Class
%>
