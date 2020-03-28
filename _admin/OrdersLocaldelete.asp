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
Dim OrdersLocal_delete
Set OrdersLocal_delete = New cOrdersLocal_delete
Set Page = OrdersLocal_delete

' Page init processing
OrdersLocal_delete.Page_Init()

' Page main processing
OrdersLocal_delete.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
OrdersLocal_delete.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var OrdersLocal_delete = new ew_Page("OrdersLocal_delete");
OrdersLocal_delete.PageID = "delete"; // Page ID
var EW_PAGE_ID = OrdersLocal_delete.PageID; // For backward compatibility
// Form object
var fOrdersLocaldelete = new ew_Form("fOrdersLocaldelete");
// Form_CustomValidate event
fOrdersLocaldelete.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fOrdersLocaldelete.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fOrdersLocaldelete.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<%

' Load records for display
Set OrdersLocal_delete.Recordset = OrdersLocal_delete.LoadRecordset()
OrdersLocal_delete.TotalRecs = OrdersLocal_delete.Recordset.RecordCount ' Get record count
If OrdersLocal_delete.TotalRecs <= 0 Then ' No record found, exit
	OrdersLocal_delete.Recordset.Close
	Set OrdersLocal_delete.Recordset = Nothing
	Call OrdersLocal_delete.Page_Terminate("OrdersLocallist.asp") ' Return to list
End If
%>
<div class="ewToolbar">
<% If OrdersLocal.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If OrdersLocal.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% OrdersLocal_delete.ShowPageHeader() %>
<% OrdersLocal_delete.ShowMessage %>
<form name="fOrdersLocaldelete" id="fOrdersLocaldelete" class="form-inline ewForm ewDeleteForm" action="<%= ew_CurrentPage() %>" method="post">
<% If OrdersLocal_delete.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= OrdersLocal_delete.Token %>">
<% End If %>
<input type="hidden" name="t" value="OrdersLocal">
<input type="hidden" name="a_delete" id="a_delete" value="D">
<% For i = 0 to UBound(OrdersLocal_delete.RecKeys) %>
<input type="hidden" name="key_m" id="key_m" value="<%= ew_HtmlEncode(ew_GetKeyValue(OrdersLocal_delete.RecKeys(i))) %>">
<% Next %>
<div class="ewGrid">
<div class="<% If ew_IsResponsiveLayout() Then Response.Write "table-responsive " %>ewGridMiddlePanel">
<table class="table ewTable">
<%= OrdersLocal.TableCustomInnerHtml %>
	<thead>
	<tr class="ewTableHeader">
<% If OrdersLocal.ID.Visible Then ' ID %>
		<th><span id="elh_OrdersLocal_ID" class="OrdersLocal_ID"><%= OrdersLocal.ID.FldCaption %></span></th>
<% End If %>
<% If OrdersLocal.CreationDate.Visible Then ' CreationDate %>
		<th><span id="elh_OrdersLocal_CreationDate" class="OrdersLocal_CreationDate"><%= OrdersLocal.CreationDate.FldCaption %></span></th>
<% End If %>
<% If OrdersLocal.OrderDate.Visible Then ' OrderDate %>
		<th><span id="elh_OrdersLocal_OrderDate" class="OrdersLocal_OrderDate"><%= OrdersLocal.OrderDate.FldCaption %></span></th>
<% End If %>
<% If OrdersLocal.DeliveryType.Visible Then ' DeliveryType %>
		<th><span id="elh_OrdersLocal_DeliveryType" class="OrdersLocal_DeliveryType"><%= OrdersLocal.DeliveryType.FldCaption %></span></th>
<% End If %>
<% If OrdersLocal.DeliveryTime.Visible Then ' DeliveryTime %>
		<th><span id="elh_OrdersLocal_DeliveryTime" class="OrdersLocal_DeliveryTime"><%= OrdersLocal.DeliveryTime.FldCaption %></span></th>
<% End If %>
<% If OrdersLocal.PaymentType.Visible Then ' PaymentType %>
		<th><span id="elh_OrdersLocal_PaymentType" class="OrdersLocal_PaymentType"><%= OrdersLocal.PaymentType.FldCaption %></span></th>
<% End If %>
<% If OrdersLocal.SubTotal.Visible Then ' SubTotal %>
		<th><span id="elh_OrdersLocal_SubTotal" class="OrdersLocal_SubTotal"><%= OrdersLocal.SubTotal.FldCaption %></span></th>
<% End If %>
<% If OrdersLocal.ShippingFee.Visible Then ' ShippingFee %>
		<th><span id="elh_OrdersLocal_ShippingFee" class="OrdersLocal_ShippingFee"><%= OrdersLocal.ShippingFee.FldCaption %></span></th>
<% End If %>
<% If OrdersLocal.OrderTotal.Visible Then ' OrderTotal %>
		<th><span id="elh_OrdersLocal_OrderTotal" class="OrdersLocal_OrderTotal"><%= OrdersLocal.OrderTotal.FldCaption %></span></th>
<% End If %>
<% If OrdersLocal.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
		<th><span id="elh_OrdersLocal_IdBusinessDetail" class="OrdersLocal_IdBusinessDetail"><%= OrdersLocal.IdBusinessDetail.FldCaption %></span></th>
<% End If %>
<% If OrdersLocal.SessionId.Visible Then ' SessionId %>
		<th><span id="elh_OrdersLocal_SessionId" class="OrdersLocal_SessionId"><%= OrdersLocal.SessionId.FldCaption %></span></th>
<% End If %>
<% If OrdersLocal.FirstName.Visible Then ' FirstName %>
		<th><span id="elh_OrdersLocal_FirstName" class="OrdersLocal_FirstName"><%= OrdersLocal.FirstName.FldCaption %></span></th>
<% End If %>
<% If OrdersLocal.LastName.Visible Then ' LastName %>
		<th><span id="elh_OrdersLocal_LastName" class="OrdersLocal_LastName"><%= OrdersLocal.LastName.FldCaption %></span></th>
<% End If %>
<% If OrdersLocal.zEmail.Visible Then ' Email %>
		<th><span id="elh_OrdersLocal_zEmail" class="OrdersLocal_zEmail"><%= OrdersLocal.zEmail.FldCaption %></span></th>
<% End If %>
<% If OrdersLocal.Phone.Visible Then ' Phone %>
		<th><span id="elh_OrdersLocal_Phone" class="OrdersLocal_Phone"><%= OrdersLocal.Phone.FldCaption %></span></th>
<% End If %>
<% If OrdersLocal.Address.Visible Then ' Address %>
		<th><span id="elh_OrdersLocal_Address" class="OrdersLocal_Address"><%= OrdersLocal.Address.FldCaption %></span></th>
<% End If %>
<% If OrdersLocal.PostalCode.Visible Then ' PostalCode %>
		<th><span id="elh_OrdersLocal_PostalCode" class="OrdersLocal_PostalCode"><%= OrdersLocal.PostalCode.FldCaption %></span></th>
<% End If %>
<% If OrdersLocal.Notes.Visible Then ' Notes %>
		<th><span id="elh_OrdersLocal_Notes" class="OrdersLocal_Notes"><%= OrdersLocal.Notes.FldCaption %></span></th>
<% End If %>
<% If OrdersLocal.ttest.Visible Then ' ttest %>
		<th><span id="elh_OrdersLocal_ttest" class="OrdersLocal_ttest"><%= OrdersLocal.ttest.FldCaption %></span></th>
<% End If %>
<% If OrdersLocal.cancelleddate.Visible Then ' cancelleddate %>
		<th><span id="elh_OrdersLocal_cancelleddate" class="OrdersLocal_cancelleddate"><%= OrdersLocal.cancelleddate.FldCaption %></span></th>
<% End If %>
<% If OrdersLocal.cancelledby.Visible Then ' cancelledby %>
		<th><span id="elh_OrdersLocal_cancelledby" class="OrdersLocal_cancelledby"><%= OrdersLocal.cancelledby.FldCaption %></span></th>
<% End If %>
<% If OrdersLocal.cancelledreason.Visible Then ' cancelledreason %>
		<th><span id="elh_OrdersLocal_cancelledreason" class="OrdersLocal_cancelledreason"><%= OrdersLocal.cancelledreason.FldCaption %></span></th>
<% End If %>
<% If OrdersLocal.acknowledgeddate.Visible Then ' acknowledgeddate %>
		<th><span id="elh_OrdersLocal_acknowledgeddate" class="OrdersLocal_acknowledgeddate"><%= OrdersLocal.acknowledgeddate.FldCaption %></span></th>
<% End If %>
<% If OrdersLocal.delivereddate.Visible Then ' delivereddate %>
		<th><span id="elh_OrdersLocal_delivereddate" class="OrdersLocal_delivereddate"><%= OrdersLocal.delivereddate.FldCaption %></span></th>
<% End If %>
<% If OrdersLocal.cancelled.Visible Then ' cancelled %>
		<th><span id="elh_OrdersLocal_cancelled" class="OrdersLocal_cancelled"><%= OrdersLocal.cancelled.FldCaption %></span></th>
<% End If %>
<% If OrdersLocal.acknowledged.Visible Then ' acknowledged %>
		<th><span id="elh_OrdersLocal_acknowledged" class="OrdersLocal_acknowledged"><%= OrdersLocal.acknowledged.FldCaption %></span></th>
<% End If %>
<% If OrdersLocal.outfordelivery.Visible Then ' outfordelivery %>
		<th><span id="elh_OrdersLocal_outfordelivery" class="OrdersLocal_outfordelivery"><%= OrdersLocal.outfordelivery.FldCaption %></span></th>
<% End If %>
<% If OrdersLocal.vouchercodediscount.Visible Then ' vouchercodediscount %>
		<th><span id="elh_OrdersLocal_vouchercodediscount" class="OrdersLocal_vouchercodediscount"><%= OrdersLocal.vouchercodediscount.FldCaption %></span></th>
<% End If %>
<% If OrdersLocal.vouchercode.Visible Then ' vouchercode %>
		<th><span id="elh_OrdersLocal_vouchercode" class="OrdersLocal_vouchercode"><%= OrdersLocal.vouchercode.FldCaption %></span></th>
<% End If %>
<% If OrdersLocal.printed.Visible Then ' printed %>
		<th><span id="elh_OrdersLocal_printed" class="OrdersLocal_printed"><%= OrdersLocal.printed.FldCaption %></span></th>
<% End If %>
<% If OrdersLocal.deliverydistance.Visible Then ' deliverydistance %>
		<th><span id="elh_OrdersLocal_deliverydistance" class="OrdersLocal_deliverydistance"><%= OrdersLocal.deliverydistance.FldCaption %></span></th>
<% End If %>
<% If OrdersLocal.asaporder.Visible Then ' asaporder %>
		<th><span id="elh_OrdersLocal_asaporder" class="OrdersLocal_asaporder"><%= OrdersLocal.asaporder.FldCaption %></span></th>
<% End If %>
<% If OrdersLocal.DeliveryLat.Visible Then ' DeliveryLat %>
		<th><span id="elh_OrdersLocal_DeliveryLat" class="OrdersLocal_DeliveryLat"><%= OrdersLocal.DeliveryLat.FldCaption %></span></th>
<% End If %>
<% If OrdersLocal.DeliveryLng.Visible Then ' DeliveryLng %>
		<th><span id="elh_OrdersLocal_DeliveryLng" class="OrdersLocal_DeliveryLng"><%= OrdersLocal.DeliveryLng.FldCaption %></span></th>
<% End If %>
<% If OrdersLocal.ServiceCharge.Visible Then ' ServiceCharge %>
		<th><span id="elh_OrdersLocal_ServiceCharge" class="OrdersLocal_ServiceCharge"><%= OrdersLocal.ServiceCharge.FldCaption %></span></th>
<% End If %>
<% If OrdersLocal.PaymentSurcharge.Visible Then ' PaymentSurcharge %>
		<th><span id="elh_OrdersLocal_PaymentSurcharge" class="OrdersLocal_PaymentSurcharge"><%= OrdersLocal.PaymentSurcharge.FldCaption %></span></th>
<% End If %>
<% If OrdersLocal.Tax_Rate.Visible Then ' Tax_Rate %>
		<th><span id="elh_OrdersLocal_Tax_Rate" class="OrdersLocal_Tax_Rate"><%= OrdersLocal.Tax_Rate.FldCaption %></span></th>
<% End If %>
<% If OrdersLocal.Tax_Amount.Visible Then ' Tax_Amount %>
		<th><span id="elh_OrdersLocal_Tax_Amount" class="OrdersLocal_Tax_Amount"><%= OrdersLocal.Tax_Amount.FldCaption %></span></th>
<% End If %>
<% If OrdersLocal.Tip_Rate.Visible Then ' Tip_Rate %>
		<th><span id="elh_OrdersLocal_Tip_Rate" class="OrdersLocal_Tip_Rate"><%= OrdersLocal.Tip_Rate.FldCaption %></span></th>
<% End If %>
<% If OrdersLocal.Tip_Amount.Visible Then ' Tip_Amount %>
		<th><span id="elh_OrdersLocal_Tip_Amount" class="OrdersLocal_Tip_Amount"><%= OrdersLocal.Tip_Amount.FldCaption %></span></th>
<% End If %>
<% If OrdersLocal.Payment_status.Visible Then ' Payment_status %>
		<th><span id="elh_OrdersLocal_Payment_status" class="OrdersLocal_Payment_status"><%= OrdersLocal.Payment_status.FldCaption %></span></th>
<% End If %>
	</tr>
	</thead>
	<tbody>
<%
OrdersLocal_delete.RecCnt = 0
OrdersLocal_delete.RowCnt = 0
Do While (Not OrdersLocal_delete.Recordset.Eof)
	OrdersLocal_delete.RecCnt = OrdersLocal_delete.RecCnt + 1
	OrdersLocal_delete.RowCnt = OrdersLocal_delete.RowCnt + 1

	' Set row properties
	Call OrdersLocal.ResetAttrs()
	OrdersLocal.RowType = EW_ROWTYPE_VIEW ' view

	' Get the field contents
	Call OrdersLocal_delete.LoadRowValues(OrdersLocal_delete.Recordset)

	' Render row
	Call OrdersLocal_delete.RenderRow()
%>
	<tr<%= OrdersLocal.RowAttributes %>>
<% If OrdersLocal.ID.Visible Then ' ID %>
		<td<%= OrdersLocal.ID.CellAttributes %>>
<span id="el<%= OrdersLocal_delete.RowCnt %>_OrdersLocal_ID" class="form-group OrdersLocal_ID">
<span<%= OrdersLocal.ID.ViewAttributes %>>
<%= OrdersLocal.ID.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrdersLocal.CreationDate.Visible Then ' CreationDate %>
		<td<%= OrdersLocal.CreationDate.CellAttributes %>>
<span id="el<%= OrdersLocal_delete.RowCnt %>_OrdersLocal_CreationDate" class="form-group OrdersLocal_CreationDate">
<span<%= OrdersLocal.CreationDate.ViewAttributes %>>
<%= OrdersLocal.CreationDate.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrdersLocal.OrderDate.Visible Then ' OrderDate %>
		<td<%= OrdersLocal.OrderDate.CellAttributes %>>
<span id="el<%= OrdersLocal_delete.RowCnt %>_OrdersLocal_OrderDate" class="form-group OrdersLocal_OrderDate">
<span<%= OrdersLocal.OrderDate.ViewAttributes %>>
<%= OrdersLocal.OrderDate.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrdersLocal.DeliveryType.Visible Then ' DeliveryType %>
		<td<%= OrdersLocal.DeliveryType.CellAttributes %>>
<span id="el<%= OrdersLocal_delete.RowCnt %>_OrdersLocal_DeliveryType" class="form-group OrdersLocal_DeliveryType">
<span<%= OrdersLocal.DeliveryType.ViewAttributes %>>
<%= OrdersLocal.DeliveryType.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrdersLocal.DeliveryTime.Visible Then ' DeliveryTime %>
		<td<%= OrdersLocal.DeliveryTime.CellAttributes %>>
<span id="el<%= OrdersLocal_delete.RowCnt %>_OrdersLocal_DeliveryTime" class="form-group OrdersLocal_DeliveryTime">
<span<%= OrdersLocal.DeliveryTime.ViewAttributes %>>
<%= OrdersLocal.DeliveryTime.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrdersLocal.PaymentType.Visible Then ' PaymentType %>
		<td<%= OrdersLocal.PaymentType.CellAttributes %>>
<span id="el<%= OrdersLocal_delete.RowCnt %>_OrdersLocal_PaymentType" class="form-group OrdersLocal_PaymentType">
<span<%= OrdersLocal.PaymentType.ViewAttributes %>>
<%= OrdersLocal.PaymentType.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrdersLocal.SubTotal.Visible Then ' SubTotal %>
		<td<%= OrdersLocal.SubTotal.CellAttributes %>>
<span id="el<%= OrdersLocal_delete.RowCnt %>_OrdersLocal_SubTotal" class="form-group OrdersLocal_SubTotal">
<span<%= OrdersLocal.SubTotal.ViewAttributes %>>
<%= OrdersLocal.SubTotal.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrdersLocal.ShippingFee.Visible Then ' ShippingFee %>
		<td<%= OrdersLocal.ShippingFee.CellAttributes %>>
<span id="el<%= OrdersLocal_delete.RowCnt %>_OrdersLocal_ShippingFee" class="form-group OrdersLocal_ShippingFee">
<span<%= OrdersLocal.ShippingFee.ViewAttributes %>>
<%= OrdersLocal.ShippingFee.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrdersLocal.OrderTotal.Visible Then ' OrderTotal %>
		<td<%= OrdersLocal.OrderTotal.CellAttributes %>>
<span id="el<%= OrdersLocal_delete.RowCnt %>_OrdersLocal_OrderTotal" class="form-group OrdersLocal_OrderTotal">
<span<%= OrdersLocal.OrderTotal.ViewAttributes %>>
<%= OrdersLocal.OrderTotal.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrdersLocal.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
		<td<%= OrdersLocal.IdBusinessDetail.CellAttributes %>>
<span id="el<%= OrdersLocal_delete.RowCnt %>_OrdersLocal_IdBusinessDetail" class="form-group OrdersLocal_IdBusinessDetail">
<span<%= OrdersLocal.IdBusinessDetail.ViewAttributes %>>
<%= OrdersLocal.IdBusinessDetail.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrdersLocal.SessionId.Visible Then ' SessionId %>
		<td<%= OrdersLocal.SessionId.CellAttributes %>>
<span id="el<%= OrdersLocal_delete.RowCnt %>_OrdersLocal_SessionId" class="form-group OrdersLocal_SessionId">
<span<%= OrdersLocal.SessionId.ViewAttributes %>>
<%= OrdersLocal.SessionId.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrdersLocal.FirstName.Visible Then ' FirstName %>
		<td<%= OrdersLocal.FirstName.CellAttributes %>>
<span id="el<%= OrdersLocal_delete.RowCnt %>_OrdersLocal_FirstName" class="form-group OrdersLocal_FirstName">
<span<%= OrdersLocal.FirstName.ViewAttributes %>>
<%= OrdersLocal.FirstName.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrdersLocal.LastName.Visible Then ' LastName %>
		<td<%= OrdersLocal.LastName.CellAttributes %>>
<span id="el<%= OrdersLocal_delete.RowCnt %>_OrdersLocal_LastName" class="form-group OrdersLocal_LastName">
<span<%= OrdersLocal.LastName.ViewAttributes %>>
<%= OrdersLocal.LastName.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrdersLocal.zEmail.Visible Then ' Email %>
		<td<%= OrdersLocal.zEmail.CellAttributes %>>
<span id="el<%= OrdersLocal_delete.RowCnt %>_OrdersLocal_zEmail" class="form-group OrdersLocal_zEmail">
<span<%= OrdersLocal.zEmail.ViewAttributes %>>
<%= OrdersLocal.zEmail.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrdersLocal.Phone.Visible Then ' Phone %>
		<td<%= OrdersLocal.Phone.CellAttributes %>>
<span id="el<%= OrdersLocal_delete.RowCnt %>_OrdersLocal_Phone" class="form-group OrdersLocal_Phone">
<span<%= OrdersLocal.Phone.ViewAttributes %>>
<%= OrdersLocal.Phone.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrdersLocal.Address.Visible Then ' Address %>
		<td<%= OrdersLocal.Address.CellAttributes %>>
<span id="el<%= OrdersLocal_delete.RowCnt %>_OrdersLocal_Address" class="form-group OrdersLocal_Address">
<span<%= OrdersLocal.Address.ViewAttributes %>>
<%= OrdersLocal.Address.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrdersLocal.PostalCode.Visible Then ' PostalCode %>
		<td<%= OrdersLocal.PostalCode.CellAttributes %>>
<span id="el<%= OrdersLocal_delete.RowCnt %>_OrdersLocal_PostalCode" class="form-group OrdersLocal_PostalCode">
<span<%= OrdersLocal.PostalCode.ViewAttributes %>>
<%= OrdersLocal.PostalCode.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrdersLocal.Notes.Visible Then ' Notes %>
		<td<%= OrdersLocal.Notes.CellAttributes %>>
<span id="el<%= OrdersLocal_delete.RowCnt %>_OrdersLocal_Notes" class="form-group OrdersLocal_Notes">
<span<%= OrdersLocal.Notes.ViewAttributes %>>
<%= OrdersLocal.Notes.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrdersLocal.ttest.Visible Then ' ttest %>
		<td<%= OrdersLocal.ttest.CellAttributes %>>
<span id="el<%= OrdersLocal_delete.RowCnt %>_OrdersLocal_ttest" class="form-group OrdersLocal_ttest">
<span<%= OrdersLocal.ttest.ViewAttributes %>>
<%= OrdersLocal.ttest.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrdersLocal.cancelleddate.Visible Then ' cancelleddate %>
		<td<%= OrdersLocal.cancelleddate.CellAttributes %>>
<span id="el<%= OrdersLocal_delete.RowCnt %>_OrdersLocal_cancelleddate" class="form-group OrdersLocal_cancelleddate">
<span<%= OrdersLocal.cancelleddate.ViewAttributes %>>
<%= OrdersLocal.cancelleddate.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrdersLocal.cancelledby.Visible Then ' cancelledby %>
		<td<%= OrdersLocal.cancelledby.CellAttributes %>>
<span id="el<%= OrdersLocal_delete.RowCnt %>_OrdersLocal_cancelledby" class="form-group OrdersLocal_cancelledby">
<span<%= OrdersLocal.cancelledby.ViewAttributes %>>
<%= OrdersLocal.cancelledby.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrdersLocal.cancelledreason.Visible Then ' cancelledreason %>
		<td<%= OrdersLocal.cancelledreason.CellAttributes %>>
<span id="el<%= OrdersLocal_delete.RowCnt %>_OrdersLocal_cancelledreason" class="form-group OrdersLocal_cancelledreason">
<span<%= OrdersLocal.cancelledreason.ViewAttributes %>>
<%= OrdersLocal.cancelledreason.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrdersLocal.acknowledgeddate.Visible Then ' acknowledgeddate %>
		<td<%= OrdersLocal.acknowledgeddate.CellAttributes %>>
<span id="el<%= OrdersLocal_delete.RowCnt %>_OrdersLocal_acknowledgeddate" class="form-group OrdersLocal_acknowledgeddate">
<span<%= OrdersLocal.acknowledgeddate.ViewAttributes %>>
<%= OrdersLocal.acknowledgeddate.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrdersLocal.delivereddate.Visible Then ' delivereddate %>
		<td<%= OrdersLocal.delivereddate.CellAttributes %>>
<span id="el<%= OrdersLocal_delete.RowCnt %>_OrdersLocal_delivereddate" class="form-group OrdersLocal_delivereddate">
<span<%= OrdersLocal.delivereddate.ViewAttributes %>>
<%= OrdersLocal.delivereddate.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrdersLocal.cancelled.Visible Then ' cancelled %>
		<td<%= OrdersLocal.cancelled.CellAttributes %>>
<span id="el<%= OrdersLocal_delete.RowCnt %>_OrdersLocal_cancelled" class="form-group OrdersLocal_cancelled">
<span<%= OrdersLocal.cancelled.ViewAttributes %>>
<%= OrdersLocal.cancelled.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrdersLocal.acknowledged.Visible Then ' acknowledged %>
		<td<%= OrdersLocal.acknowledged.CellAttributes %>>
<span id="el<%= OrdersLocal_delete.RowCnt %>_OrdersLocal_acknowledged" class="form-group OrdersLocal_acknowledged">
<span<%= OrdersLocal.acknowledged.ViewAttributes %>>
<%= OrdersLocal.acknowledged.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrdersLocal.outfordelivery.Visible Then ' outfordelivery %>
		<td<%= OrdersLocal.outfordelivery.CellAttributes %>>
<span id="el<%= OrdersLocal_delete.RowCnt %>_OrdersLocal_outfordelivery" class="form-group OrdersLocal_outfordelivery">
<span<%= OrdersLocal.outfordelivery.ViewAttributes %>>
<%= OrdersLocal.outfordelivery.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrdersLocal.vouchercodediscount.Visible Then ' vouchercodediscount %>
		<td<%= OrdersLocal.vouchercodediscount.CellAttributes %>>
<span id="el<%= OrdersLocal_delete.RowCnt %>_OrdersLocal_vouchercodediscount" class="form-group OrdersLocal_vouchercodediscount">
<span<%= OrdersLocal.vouchercodediscount.ViewAttributes %>>
<%= OrdersLocal.vouchercodediscount.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrdersLocal.vouchercode.Visible Then ' vouchercode %>
		<td<%= OrdersLocal.vouchercode.CellAttributes %>>
<span id="el<%= OrdersLocal_delete.RowCnt %>_OrdersLocal_vouchercode" class="form-group OrdersLocal_vouchercode">
<span<%= OrdersLocal.vouchercode.ViewAttributes %>>
<%= OrdersLocal.vouchercode.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrdersLocal.printed.Visible Then ' printed %>
		<td<%= OrdersLocal.printed.CellAttributes %>>
<span id="el<%= OrdersLocal_delete.RowCnt %>_OrdersLocal_printed" class="form-group OrdersLocal_printed">
<span<%= OrdersLocal.printed.ViewAttributes %>>
<%= OrdersLocal.printed.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrdersLocal.deliverydistance.Visible Then ' deliverydistance %>
		<td<%= OrdersLocal.deliverydistance.CellAttributes %>>
<span id="el<%= OrdersLocal_delete.RowCnt %>_OrdersLocal_deliverydistance" class="form-group OrdersLocal_deliverydistance">
<span<%= OrdersLocal.deliverydistance.ViewAttributes %>>
<%= OrdersLocal.deliverydistance.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrdersLocal.asaporder.Visible Then ' asaporder %>
		<td<%= OrdersLocal.asaporder.CellAttributes %>>
<span id="el<%= OrdersLocal_delete.RowCnt %>_OrdersLocal_asaporder" class="form-group OrdersLocal_asaporder">
<span<%= OrdersLocal.asaporder.ViewAttributes %>>
<%= OrdersLocal.asaporder.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrdersLocal.DeliveryLat.Visible Then ' DeliveryLat %>
		<td<%= OrdersLocal.DeliveryLat.CellAttributes %>>
<span id="el<%= OrdersLocal_delete.RowCnt %>_OrdersLocal_DeliveryLat" class="form-group OrdersLocal_DeliveryLat">
<span<%= OrdersLocal.DeliveryLat.ViewAttributes %>>
<%= OrdersLocal.DeliveryLat.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrdersLocal.DeliveryLng.Visible Then ' DeliveryLng %>
		<td<%= OrdersLocal.DeliveryLng.CellAttributes %>>
<span id="el<%= OrdersLocal_delete.RowCnt %>_OrdersLocal_DeliveryLng" class="form-group OrdersLocal_DeliveryLng">
<span<%= OrdersLocal.DeliveryLng.ViewAttributes %>>
<%= OrdersLocal.DeliveryLng.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrdersLocal.ServiceCharge.Visible Then ' ServiceCharge %>
		<td<%= OrdersLocal.ServiceCharge.CellAttributes %>>
<span id="el<%= OrdersLocal_delete.RowCnt %>_OrdersLocal_ServiceCharge" class="form-group OrdersLocal_ServiceCharge">
<span<%= OrdersLocal.ServiceCharge.ViewAttributes %>>
<%= OrdersLocal.ServiceCharge.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrdersLocal.PaymentSurcharge.Visible Then ' PaymentSurcharge %>
		<td<%= OrdersLocal.PaymentSurcharge.CellAttributes %>>
<span id="el<%= OrdersLocal_delete.RowCnt %>_OrdersLocal_PaymentSurcharge" class="form-group OrdersLocal_PaymentSurcharge">
<span<%= OrdersLocal.PaymentSurcharge.ViewAttributes %>>
<%= OrdersLocal.PaymentSurcharge.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrdersLocal.Tax_Rate.Visible Then ' Tax_Rate %>
		<td<%= OrdersLocal.Tax_Rate.CellAttributes %>>
<span id="el<%= OrdersLocal_delete.RowCnt %>_OrdersLocal_Tax_Rate" class="form-group OrdersLocal_Tax_Rate">
<span<%= OrdersLocal.Tax_Rate.ViewAttributes %>>
<%= OrdersLocal.Tax_Rate.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrdersLocal.Tax_Amount.Visible Then ' Tax_Amount %>
		<td<%= OrdersLocal.Tax_Amount.CellAttributes %>>
<span id="el<%= OrdersLocal_delete.RowCnt %>_OrdersLocal_Tax_Amount" class="form-group OrdersLocal_Tax_Amount">
<span<%= OrdersLocal.Tax_Amount.ViewAttributes %>>
<%= OrdersLocal.Tax_Amount.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrdersLocal.Tip_Rate.Visible Then ' Tip_Rate %>
		<td<%= OrdersLocal.Tip_Rate.CellAttributes %>>
<span id="el<%= OrdersLocal_delete.RowCnt %>_OrdersLocal_Tip_Rate" class="form-group OrdersLocal_Tip_Rate">
<span<%= OrdersLocal.Tip_Rate.ViewAttributes %>>
<%= OrdersLocal.Tip_Rate.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrdersLocal.Tip_Amount.Visible Then ' Tip_Amount %>
		<td<%= OrdersLocal.Tip_Amount.CellAttributes %>>
<span id="el<%= OrdersLocal_delete.RowCnt %>_OrdersLocal_Tip_Amount" class="form-group OrdersLocal_Tip_Amount">
<span<%= OrdersLocal.Tip_Amount.ViewAttributes %>>
<%= OrdersLocal.Tip_Amount.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If OrdersLocal.Payment_status.Visible Then ' Payment_status %>
		<td<%= OrdersLocal.Payment_status.CellAttributes %>>
<span id="el<%= OrdersLocal_delete.RowCnt %>_OrdersLocal_Payment_status" class="form-group OrdersLocal_Payment_status">
<span<%= OrdersLocal.Payment_status.ViewAttributes %>>
<%= OrdersLocal.Payment_status.ListViewValue %>
</span>
</span>
</td>
<% End If %>
	</tr>
<%
	OrdersLocal_delete.Recordset.MoveNext
Loop
OrdersLocal_delete.Recordset.Close
Set OrdersLocal_delete.Recordset = Nothing
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
fOrdersLocaldelete.Init();
</script>
<%
OrdersLocal_delete.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set OrdersLocal_delete = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cOrdersLocal_delete

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
		TableName = "OrdersLocal"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "OrdersLocal_delete"
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

		' Initialize urls
		' Initialize form object

		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "delete"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "OrdersLocal"

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
		RecKeys = OrdersLocal.GetRecordKeys() ' Load record keys
		sFilter = OrdersLocal.GetKeyFilter()
		If sFilter = "" Then
			Call Page_Terminate("OrdersLocallist.asp") ' Prevent SQL injection, return to list
		End If

		' Set up filter (Sql Where Clause) and get Return Sql
		' Sql constructor in OrdersLocal class, OrdersLocalinfo.asp

		OrdersLocal.CurrentFilter = sFilter

		' Get action
		If Request.Form("a_delete").Count > 0 Then
			OrdersLocal.CurrentAction = Request.Form("a_delete")
		Else
			OrdersLocal.CurrentAction = "D"	' Delete record directly
		End If
		Select Case OrdersLocal.CurrentAction
			Case "D" ' Delete
				OrdersLocal.SendEmail = True ' Send email on delete success
				If DeleteRows() Then ' Delete rows
					If SuccessMessage = "" Then SuccessMessage = Language.Phrase("DeleteSuccess") ' Set up success message
					Call Page_Terminate(OrdersLocal.ReturnUrl) ' Return to caller
				End If
		End Select
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
		sSql = OrdersLocal.SQL
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
				DeleteRows = OrdersLocal.Row_Deleting(RsDelete)
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
			ElseIf OrdersLocal.CancelMessage <> "" Then
				FailureMessage = OrdersLocal.CancelMessage
				OrdersLocal.CancelMessage = ""
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
				Call OrdersLocal.Row_Deleted(RsOld)
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
		Call Breadcrumb.Add("list", OrdersLocal.TableVar, "OrdersLocallist.asp", "", OrdersLocal.TableVar, True)
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
