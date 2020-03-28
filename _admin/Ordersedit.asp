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
Dim Orders_edit
Set Orders_edit = New cOrders_edit
Set Page = Orders_edit

' Page init processing
Orders_edit.Page_Init()

' Page main processing
Orders_edit.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
Orders_edit.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var Orders_edit = new ew_Page("Orders_edit");
Orders_edit.PageID = "edit"; // Page ID
var EW_PAGE_ID = Orders_edit.PageID; // For backward compatibility
// Form object
var fOrdersedit = new ew_Form("fOrdersedit");
// Validate form
fOrdersedit.Validate = function() {
	if (!this.ValidateRequired)
		return true; // Ignore validation
	var $ = jQuery, fobj = this.GetForm(), $fobj = $(fobj);
	this.PostAutoSuggest();
	if ($fobj.find("#a_confirm").val() == "F")
		return true;
	var elm, felm, uelm, addcnt = 0;
	var $k = $fobj.find("#" + this.FormKeyCountName); // Get key_count
	var rowcnt = ($k[0]) ? parseInt($k.val(), 10) : 1;
	var startcnt = (rowcnt == 0) ? 0 : 1; // Check rowcnt == 0 => Inline-Add
	var gridinsert = $fobj.find("#a_list").val() == "gridinsert";
	for (var i = startcnt; i <= rowcnt; i++) {
		var infix = ($k[0]) ? String(i) : "";
		$fobj.data("rowindex", infix);
			elm = this.GetElements("x" + infix + "_SubTotal");
			if (elm && !ew_CheckNumber(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(Orders.SubTotal.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_ShippingFee");
			if (elm && !ew_CheckNumber(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(Orders.ShippingFee.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_OrderTotal");
			if (elm && !ew_CheckNumber(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(Orders.OrderTotal.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_IdBusinessDetail");
			if (elm && !ew_CheckInteger(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(Orders.IdBusinessDetail.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_cancelled");
			if (elm && !ew_CheckInteger(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(Orders.cancelled.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_acknowledged");
			if (elm && !ew_CheckInteger(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(Orders.acknowledged.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_outfordelivery");
			if (elm && !ew_CheckInteger(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(Orders.outfordelivery.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_vouchercodediscount");
			if (elm && !ew_CheckInteger(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(Orders.vouchercodediscount.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_printed");
			if (elm && !ew_CheckInteger(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(Orders.printed.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_ServiceCharge");
			if (elm && !ew_CheckNumber(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(Orders.ServiceCharge.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_PaymentSurcharge");
			if (elm && !ew_CheckNumber(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(Orders.PaymentSurcharge.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_Tax_Rate");
			if (elm && !ew_CheckInteger(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(Orders.Tax_Rate.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_Tax_Amount");
			if (elm && !ew_CheckNumber(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(Orders.Tax_Amount.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_Tip_Amount");
			if (elm && !ew_CheckNumber(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(Orders.Tip_Amount.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_Card_Debit");
			if (elm && !ew_CheckInteger(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(Orders.Card_Debit.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_Card_Credit");
			if (elm && !ew_CheckInteger(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(Orders.Card_Credit.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_deliverydelay");
			if (elm && !ew_CheckInteger(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(Orders.deliverydelay.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_collectiondelay");
			if (elm && !ew_CheckInteger(elm.value))
				return this.OnError(elm, "<%= ew_JsEncode2(Orders.collectiondelay.FldErrMsg) %>");
			// Set up row object
			ew_ElementsToRow(fobj);
			// Fire Form_CustomValidate event
			if (!this.Form_CustomValidate(fobj))
				return false;
	}
	// Process detail forms
	var dfs = $fobj.find("input[name='detailpage']").get();
	for (var i = 0; i < dfs.length; i++) {
		var df = dfs[i], val = df.value;
		if (val && ewForms[val])
			if (!ewForms[val].Validate())
				return false;
	}
	return true;
}
// Form_CustomValidate event
fOrdersedit.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fOrdersedit.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fOrdersedit.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<div class="ewToolbar">
<% If Orders.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If Orders.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% Orders_edit.ShowPageHeader() %>
<% Orders_edit.ShowMessage %>
<form name="fOrdersedit" id="fOrdersedit" class="form-horizontal ewForm ewEditForm" action="<%= ew_CurrentPage %>" method="post">
<% If Orders_edit.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= Orders_edit.Token %>">
<% End If %>
<input type="hidden" name="a_table" id="a_table" value="Orders">
<input type="hidden" name="a_edit" id="a_edit" value="U">
<div>
<% If Orders.ID.Visible Then ' ID %>
	<div id="r_ID" class="form-group">
		<label id="elh_Orders_ID" class="col-sm-2 control-label ewLabel"><%= Orders.ID.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.ID.CellAttributes %>>
<span id="el_Orders_ID">
<span<%= Orders.ID.ViewAttributes %>>
<p class="form-control-static"><%= Orders.ID.EditValue %></p>
</span>
</span>
<input type="hidden" data-field="x_ID" name="x_ID" id="x_ID" value="<%= Server.HTMLEncode(Orders.ID.CurrentValue&"") %>">
<%= Orders.ID.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.CreationDate.Visible Then ' CreationDate %>
	<div id="r_CreationDate" class="form-group">
		<label id="elh_Orders_CreationDate" for="x_CreationDate" class="col-sm-2 control-label ewLabel"><%= Orders.CreationDate.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.CreationDate.CellAttributes %>>
<span id="el_Orders_CreationDate">
<input type="text" data-field="x_CreationDate" name="x_CreationDate" id="x_CreationDate" placeholder="<%= Orders.CreationDate.PlaceHolder %>" value="<%= Orders.CreationDate.EditValue %>"<%= Orders.CreationDate.EditAttributes %>>
</span>
<%= Orders.CreationDate.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.OrderDate.Visible Then ' OrderDate %>
	<div id="r_OrderDate" class="form-group">
		<label id="elh_Orders_OrderDate" for="x_OrderDate" class="col-sm-2 control-label ewLabel"><%= Orders.OrderDate.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.OrderDate.CellAttributes %>>
<span id="el_Orders_OrderDate">
<input type="text" data-field="x_OrderDate" name="x_OrderDate" id="x_OrderDate" placeholder="<%= Orders.OrderDate.PlaceHolder %>" value="<%= Orders.OrderDate.EditValue %>"<%= Orders.OrderDate.EditAttributes %>>
</span>
<%= Orders.OrderDate.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.DeliveryType.Visible Then ' DeliveryType %>
	<div id="r_DeliveryType" class="form-group">
		<label id="elh_Orders_DeliveryType" for="x_DeliveryType" class="col-sm-2 control-label ewLabel"><%= Orders.DeliveryType.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.DeliveryType.CellAttributes %>>
<span id="el_Orders_DeliveryType">
<input type="text" data-field="x_DeliveryType" name="x_DeliveryType" id="x_DeliveryType" size="30" maxlength="255" placeholder="<%= Orders.DeliveryType.PlaceHolder %>" value="<%= Orders.DeliveryType.EditValue %>"<%= Orders.DeliveryType.EditAttributes %>>
</span>
<%= Orders.DeliveryType.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.DeliveryTime.Visible Then ' DeliveryTime %>
	<div id="r_DeliveryTime" class="form-group">
		<label id="elh_Orders_DeliveryTime" for="x_DeliveryTime" class="col-sm-2 control-label ewLabel"><%= Orders.DeliveryTime.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.DeliveryTime.CellAttributes %>>
<span id="el_Orders_DeliveryTime">
<input type="text" data-field="x_DeliveryTime" name="x_DeliveryTime" id="x_DeliveryTime" placeholder="<%= Orders.DeliveryTime.PlaceHolder %>" value="<%= Orders.DeliveryTime.EditValue %>"<%= Orders.DeliveryTime.EditAttributes %>>
</span>
<%= Orders.DeliveryTime.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.PaymentType.Visible Then ' PaymentType %>
	<div id="r_PaymentType" class="form-group">
		<label id="elh_Orders_PaymentType" for="x_PaymentType" class="col-sm-2 control-label ewLabel"><%= Orders.PaymentType.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.PaymentType.CellAttributes %>>
<span id="el_Orders_PaymentType">
<input type="text" data-field="x_PaymentType" name="x_PaymentType" id="x_PaymentType" size="30" maxlength="255" placeholder="<%= Orders.PaymentType.PlaceHolder %>" value="<%= Orders.PaymentType.EditValue %>"<%= Orders.PaymentType.EditAttributes %>>
</span>
<%= Orders.PaymentType.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.SubTotal.Visible Then ' SubTotal %>
	<div id="r_SubTotal" class="form-group">
		<label id="elh_Orders_SubTotal" for="x_SubTotal" class="col-sm-2 control-label ewLabel"><%= Orders.SubTotal.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.SubTotal.CellAttributes %>>
<span id="el_Orders_SubTotal">
<input type="text" data-field="x_SubTotal" name="x_SubTotal" id="x_SubTotal" size="30" placeholder="<%= Orders.SubTotal.PlaceHolder %>" value="<%= Orders.SubTotal.EditValue %>"<%= Orders.SubTotal.EditAttributes %>>
</span>
<%= Orders.SubTotal.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.ShippingFee.Visible Then ' ShippingFee %>
	<div id="r_ShippingFee" class="form-group">
		<label id="elh_Orders_ShippingFee" for="x_ShippingFee" class="col-sm-2 control-label ewLabel"><%= Orders.ShippingFee.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.ShippingFee.CellAttributes %>>
<span id="el_Orders_ShippingFee">
<input type="text" data-field="x_ShippingFee" name="x_ShippingFee" id="x_ShippingFee" size="30" placeholder="<%= Orders.ShippingFee.PlaceHolder %>" value="<%= Orders.ShippingFee.EditValue %>"<%= Orders.ShippingFee.EditAttributes %>>
</span>
<%= Orders.ShippingFee.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.OrderTotal.Visible Then ' OrderTotal %>
	<div id="r_OrderTotal" class="form-group">
		<label id="elh_Orders_OrderTotal" for="x_OrderTotal" class="col-sm-2 control-label ewLabel"><%= Orders.OrderTotal.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.OrderTotal.CellAttributes %>>
<span id="el_Orders_OrderTotal">
<input type="text" data-field="x_OrderTotal" name="x_OrderTotal" id="x_OrderTotal" size="30" placeholder="<%= Orders.OrderTotal.PlaceHolder %>" value="<%= Orders.OrderTotal.EditValue %>"<%= Orders.OrderTotal.EditAttributes %>>
</span>
<%= Orders.OrderTotal.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
	<div id="r_IdBusinessDetail" class="form-group">
		<label id="elh_Orders_IdBusinessDetail" for="x_IdBusinessDetail" class="col-sm-2 control-label ewLabel"><%= Orders.IdBusinessDetail.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.IdBusinessDetail.CellAttributes %>>
<span id="el_Orders_IdBusinessDetail">
<input type="text" data-field="x_IdBusinessDetail" name="x_IdBusinessDetail" id="x_IdBusinessDetail" size="30" placeholder="<%= Orders.IdBusinessDetail.PlaceHolder %>" value="<%= Orders.IdBusinessDetail.EditValue %>"<%= Orders.IdBusinessDetail.EditAttributes %>>
</span>
<%= Orders.IdBusinessDetail.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.SessionId.Visible Then ' SessionId %>
	<div id="r_SessionId" class="form-group">
		<label id="elh_Orders_SessionId" for="x_SessionId" class="col-sm-2 control-label ewLabel"><%= Orders.SessionId.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.SessionId.CellAttributes %>>
<span id="el_Orders_SessionId">
<input type="text" data-field="x_SessionId" name="x_SessionId" id="x_SessionId" size="30" maxlength="255" placeholder="<%= Orders.SessionId.PlaceHolder %>" value="<%= Orders.SessionId.EditValue %>"<%= Orders.SessionId.EditAttributes %>>
</span>
<%= Orders.SessionId.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.FirstName.Visible Then ' FirstName %>
	<div id="r_FirstName" class="form-group">
		<label id="elh_Orders_FirstName" for="x_FirstName" class="col-sm-2 control-label ewLabel"><%= Orders.FirstName.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.FirstName.CellAttributes %>>
<span id="el_Orders_FirstName">
<input type="text" data-field="x_FirstName" name="x_FirstName" id="x_FirstName" size="30" maxlength="255" placeholder="<%= Orders.FirstName.PlaceHolder %>" value="<%= Orders.FirstName.EditValue %>"<%= Orders.FirstName.EditAttributes %>>
</span>
<%= Orders.FirstName.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.LastName.Visible Then ' LastName %>
	<div id="r_LastName" class="form-group">
		<label id="elh_Orders_LastName" for="x_LastName" class="col-sm-2 control-label ewLabel"><%= Orders.LastName.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.LastName.CellAttributes %>>
<span id="el_Orders_LastName">
<input type="text" data-field="x_LastName" name="x_LastName" id="x_LastName" size="30" maxlength="255" placeholder="<%= Orders.LastName.PlaceHolder %>" value="<%= Orders.LastName.EditValue %>"<%= Orders.LastName.EditAttributes %>>
</span>
<%= Orders.LastName.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.zEmail.Visible Then ' Email %>
	<div id="r_zEmail" class="form-group">
		<label id="elh_Orders_zEmail" for="x_zEmail" class="col-sm-2 control-label ewLabel"><%= Orders.zEmail.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.zEmail.CellAttributes %>>
<span id="el_Orders_zEmail">
<input type="text" data-field="x_zEmail" name="x_zEmail" id="x_zEmail" size="30" maxlength="255" placeholder="<%= Orders.zEmail.PlaceHolder %>" value="<%= Orders.zEmail.EditValue %>"<%= Orders.zEmail.EditAttributes %>>
</span>
<%= Orders.zEmail.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.Phone.Visible Then ' Phone %>
	<div id="r_Phone" class="form-group">
		<label id="elh_Orders_Phone" for="x_Phone" class="col-sm-2 control-label ewLabel"><%= Orders.Phone.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.Phone.CellAttributes %>>
<span id="el_Orders_Phone">
<input type="text" data-field="x_Phone" name="x_Phone" id="x_Phone" size="30" maxlength="255" placeholder="<%= Orders.Phone.PlaceHolder %>" value="<%= Orders.Phone.EditValue %>"<%= Orders.Phone.EditAttributes %>>
</span>
<%= Orders.Phone.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.Address.Visible Then ' Address %>
	<div id="r_Address" class="form-group">
		<label id="elh_Orders_Address" for="x_Address" class="col-sm-2 control-label ewLabel"><%= Orders.Address.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.Address.CellAttributes %>>
<span id="el_Orders_Address">
<input type="text" data-field="x_Address" name="x_Address" id="x_Address" size="30" maxlength="255" placeholder="<%= Orders.Address.PlaceHolder %>" value="<%= Orders.Address.EditValue %>"<%= Orders.Address.EditAttributes %>>
</span>
<%= Orders.Address.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.PostalCode.Visible Then ' PostalCode %>
	<div id="r_PostalCode" class="form-group">
		<label id="elh_Orders_PostalCode" for="x_PostalCode" class="col-sm-2 control-label ewLabel"><%= Orders.PostalCode.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.PostalCode.CellAttributes %>>
<span id="el_Orders_PostalCode">
<input type="text" data-field="x_PostalCode" name="x_PostalCode" id="x_PostalCode" size="30" maxlength="255" placeholder="<%= Orders.PostalCode.PlaceHolder %>" value="<%= Orders.PostalCode.EditValue %>"<%= Orders.PostalCode.EditAttributes %>>
</span>
<%= Orders.PostalCode.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.Notes.Visible Then ' Notes %>
	<div id="r_Notes" class="form-group">
		<label id="elh_Orders_Notes" for="x_Notes" class="col-sm-2 control-label ewLabel"><%= Orders.Notes.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.Notes.CellAttributes %>>
<span id="el_Orders_Notes">
<textarea data-field="x_Notes" name="x_Notes" id="x_Notes" cols="35" rows="4" placeholder="<%= Orders.Notes.PlaceHolder %>"<%= Orders.Notes.EditAttributes %>><%= Orders.Notes.EditValue %></textarea>
</span>
<%= Orders.Notes.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.ttest.Visible Then ' ttest %>
	<div id="r_ttest" class="form-group">
		<label id="elh_Orders_ttest" for="x_ttest" class="col-sm-2 control-label ewLabel"><%= Orders.ttest.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.ttest.CellAttributes %>>
<span id="el_Orders_ttest">
<input type="text" data-field="x_ttest" name="x_ttest" id="x_ttest" size="30" maxlength="255" placeholder="<%= Orders.ttest.PlaceHolder %>" value="<%= Orders.ttest.EditValue %>"<%= Orders.ttest.EditAttributes %>>
</span>
<%= Orders.ttest.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.cancelleddate.Visible Then ' cancelleddate %>
	<div id="r_cancelleddate" class="form-group">
		<label id="elh_Orders_cancelleddate" for="x_cancelleddate" class="col-sm-2 control-label ewLabel"><%= Orders.cancelleddate.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.cancelleddate.CellAttributes %>>
<span id="el_Orders_cancelleddate">
<input type="text" data-field="x_cancelleddate" name="x_cancelleddate" id="x_cancelleddate" placeholder="<%= Orders.cancelleddate.PlaceHolder %>" value="<%= Orders.cancelleddate.EditValue %>"<%= Orders.cancelleddate.EditAttributes %>>
</span>
<%= Orders.cancelleddate.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.cancelledby.Visible Then ' cancelledby %>
	<div id="r_cancelledby" class="form-group">
		<label id="elh_Orders_cancelledby" for="x_cancelledby" class="col-sm-2 control-label ewLabel"><%= Orders.cancelledby.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.cancelledby.CellAttributes %>>
<span id="el_Orders_cancelledby">
<input type="text" data-field="x_cancelledby" name="x_cancelledby" id="x_cancelledby" size="30" maxlength="255" placeholder="<%= Orders.cancelledby.PlaceHolder %>" value="<%= Orders.cancelledby.EditValue %>"<%= Orders.cancelledby.EditAttributes %>>
</span>
<%= Orders.cancelledby.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.cancelledreason.Visible Then ' cancelledreason %>
	<div id="r_cancelledreason" class="form-group">
		<label id="elh_Orders_cancelledreason" for="x_cancelledreason" class="col-sm-2 control-label ewLabel"><%= Orders.cancelledreason.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.cancelledreason.CellAttributes %>>
<span id="el_Orders_cancelledreason">
<input type="text" data-field="x_cancelledreason" name="x_cancelledreason" id="x_cancelledreason" size="30" maxlength="255" placeholder="<%= Orders.cancelledreason.PlaceHolder %>" value="<%= Orders.cancelledreason.EditValue %>"<%= Orders.cancelledreason.EditAttributes %>>
</span>
<%= Orders.cancelledreason.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.acknowledgeddate.Visible Then ' acknowledgeddate %>
	<div id="r_acknowledgeddate" class="form-group">
		<label id="elh_Orders_acknowledgeddate" for="x_acknowledgeddate" class="col-sm-2 control-label ewLabel"><%= Orders.acknowledgeddate.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.acknowledgeddate.CellAttributes %>>
<span id="el_Orders_acknowledgeddate">
<input type="text" data-field="x_acknowledgeddate" name="x_acknowledgeddate" id="x_acknowledgeddate" placeholder="<%= Orders.acknowledgeddate.PlaceHolder %>" value="<%= Orders.acknowledgeddate.EditValue %>"<%= Orders.acknowledgeddate.EditAttributes %>>
</span>
<%= Orders.acknowledgeddate.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.delivereddate.Visible Then ' delivereddate %>
	<div id="r_delivereddate" class="form-group">
		<label id="elh_Orders_delivereddate" for="x_delivereddate" class="col-sm-2 control-label ewLabel"><%= Orders.delivereddate.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.delivereddate.CellAttributes %>>
<span id="el_Orders_delivereddate">
<input type="text" data-field="x_delivereddate" name="x_delivereddate" id="x_delivereddate" size="30" maxlength="255" placeholder="<%= Orders.delivereddate.PlaceHolder %>" value="<%= Orders.delivereddate.EditValue %>"<%= Orders.delivereddate.EditAttributes %>>
</span>
<%= Orders.delivereddate.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.cancelled.Visible Then ' cancelled %>
	<div id="r_cancelled" class="form-group">
		<label id="elh_Orders_cancelled" for="x_cancelled" class="col-sm-2 control-label ewLabel"><%= Orders.cancelled.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.cancelled.CellAttributes %>>
<span id="el_Orders_cancelled">
<input type="text" data-field="x_cancelled" name="x_cancelled" id="x_cancelled" size="30" placeholder="<%= Orders.cancelled.PlaceHolder %>" value="<%= Orders.cancelled.EditValue %>"<%= Orders.cancelled.EditAttributes %>>
</span>
<%= Orders.cancelled.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.acknowledged.Visible Then ' acknowledged %>
	<div id="r_acknowledged" class="form-group">
		<label id="elh_Orders_acknowledged" for="x_acknowledged" class="col-sm-2 control-label ewLabel"><%= Orders.acknowledged.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.acknowledged.CellAttributes %>>
<span id="el_Orders_acknowledged">
<input type="text" data-field="x_acknowledged" name="x_acknowledged" id="x_acknowledged" size="30" placeholder="<%= Orders.acknowledged.PlaceHolder %>" value="<%= Orders.acknowledged.EditValue %>"<%= Orders.acknowledged.EditAttributes %>>
</span>
<%= Orders.acknowledged.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.outfordelivery.Visible Then ' outfordelivery %>
	<div id="r_outfordelivery" class="form-group">
		<label id="elh_Orders_outfordelivery" for="x_outfordelivery" class="col-sm-2 control-label ewLabel"><%= Orders.outfordelivery.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.outfordelivery.CellAttributes %>>
<span id="el_Orders_outfordelivery">
<input type="text" data-field="x_outfordelivery" name="x_outfordelivery" id="x_outfordelivery" size="30" placeholder="<%= Orders.outfordelivery.PlaceHolder %>" value="<%= Orders.outfordelivery.EditValue %>"<%= Orders.outfordelivery.EditAttributes %>>
</span>
<%= Orders.outfordelivery.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.vouchercodediscount.Visible Then ' vouchercodediscount %>
	<div id="r_vouchercodediscount" class="form-group">
		<label id="elh_Orders_vouchercodediscount" for="x_vouchercodediscount" class="col-sm-2 control-label ewLabel"><%= Orders.vouchercodediscount.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.vouchercodediscount.CellAttributes %>>
<span id="el_Orders_vouchercodediscount">
<input type="text" data-field="x_vouchercodediscount" name="x_vouchercodediscount" id="x_vouchercodediscount" size="30" placeholder="<%= Orders.vouchercodediscount.PlaceHolder %>" value="<%= Orders.vouchercodediscount.EditValue %>"<%= Orders.vouchercodediscount.EditAttributes %>>
</span>
<%= Orders.vouchercodediscount.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.vouchercode.Visible Then ' vouchercode %>
	<div id="r_vouchercode" class="form-group">
		<label id="elh_Orders_vouchercode" for="x_vouchercode" class="col-sm-2 control-label ewLabel"><%= Orders.vouchercode.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.vouchercode.CellAttributes %>>
<span id="el_Orders_vouchercode">
<input type="text" data-field="x_vouchercode" name="x_vouchercode" id="x_vouchercode" size="30" maxlength="255" placeholder="<%= Orders.vouchercode.PlaceHolder %>" value="<%= Orders.vouchercode.EditValue %>"<%= Orders.vouchercode.EditAttributes %>>
</span>
<%= Orders.vouchercode.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.printed.Visible Then ' printed %>
	<div id="r_printed" class="form-group">
		<label id="elh_Orders_printed" for="x_printed" class="col-sm-2 control-label ewLabel"><%= Orders.printed.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.printed.CellAttributes %>>
<span id="el_Orders_printed">
<input type="text" data-field="x_printed" name="x_printed" id="x_printed" size="30" placeholder="<%= Orders.printed.PlaceHolder %>" value="<%= Orders.printed.EditValue %>"<%= Orders.printed.EditAttributes %>>
</span>
<%= Orders.printed.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.deliverydistance.Visible Then ' deliverydistance %>
	<div id="r_deliverydistance" class="form-group">
		<label id="elh_Orders_deliverydistance" for="x_deliverydistance" class="col-sm-2 control-label ewLabel"><%= Orders.deliverydistance.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.deliverydistance.CellAttributes %>>
<span id="el_Orders_deliverydistance">
<input type="text" data-field="x_deliverydistance" name="x_deliverydistance" id="x_deliverydistance" size="30" maxlength="255" placeholder="<%= Orders.deliverydistance.PlaceHolder %>" value="<%= Orders.deliverydistance.EditValue %>"<%= Orders.deliverydistance.EditAttributes %>>
</span>
<%= Orders.deliverydistance.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.asaporder.Visible Then ' asaporder %>
	<div id="r_asaporder" class="form-group">
		<label id="elh_Orders_asaporder" for="x_asaporder" class="col-sm-2 control-label ewLabel"><%= Orders.asaporder.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.asaporder.CellAttributes %>>
<span id="el_Orders_asaporder">
<input type="text" data-field="x_asaporder" name="x_asaporder" id="x_asaporder" size="30" maxlength="255" placeholder="<%= Orders.asaporder.PlaceHolder %>" value="<%= Orders.asaporder.EditValue %>"<%= Orders.asaporder.EditAttributes %>>
</span>
<%= Orders.asaporder.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.DeliveryLat.Visible Then ' DeliveryLat %>
	<div id="r_DeliveryLat" class="form-group">
		<label id="elh_Orders_DeliveryLat" for="x_DeliveryLat" class="col-sm-2 control-label ewLabel"><%= Orders.DeliveryLat.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.DeliveryLat.CellAttributes %>>
<span id="el_Orders_DeliveryLat">
<input type="text" data-field="x_DeliveryLat" name="x_DeliveryLat" id="x_DeliveryLat" size="30" maxlength="50" placeholder="<%= Orders.DeliveryLat.PlaceHolder %>" value="<%= Orders.DeliveryLat.EditValue %>"<%= Orders.DeliveryLat.EditAttributes %>>
</span>
<%= Orders.DeliveryLat.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.DeliveryLng.Visible Then ' DeliveryLng %>
	<div id="r_DeliveryLng" class="form-group">
		<label id="elh_Orders_DeliveryLng" for="x_DeliveryLng" class="col-sm-2 control-label ewLabel"><%= Orders.DeliveryLng.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.DeliveryLng.CellAttributes %>>
<span id="el_Orders_DeliveryLng">
<input type="text" data-field="x_DeliveryLng" name="x_DeliveryLng" id="x_DeliveryLng" size="30" maxlength="50" placeholder="<%= Orders.DeliveryLng.PlaceHolder %>" value="<%= Orders.DeliveryLng.EditValue %>"<%= Orders.DeliveryLng.EditAttributes %>>
</span>
<%= Orders.DeliveryLng.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.ServiceCharge.Visible Then ' ServiceCharge %>
	<div id="r_ServiceCharge" class="form-group">
		<label id="elh_Orders_ServiceCharge" for="x_ServiceCharge" class="col-sm-2 control-label ewLabel"><%= Orders.ServiceCharge.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.ServiceCharge.CellAttributes %>>
<span id="el_Orders_ServiceCharge">
<input type="text" data-field="x_ServiceCharge" name="x_ServiceCharge" id="x_ServiceCharge" size="30" placeholder="<%= Orders.ServiceCharge.PlaceHolder %>" value="<%= Orders.ServiceCharge.EditValue %>"<%= Orders.ServiceCharge.EditAttributes %>>
</span>
<%= Orders.ServiceCharge.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.PaymentSurcharge.Visible Then ' PaymentSurcharge %>
	<div id="r_PaymentSurcharge" class="form-group">
		<label id="elh_Orders_PaymentSurcharge" for="x_PaymentSurcharge" class="col-sm-2 control-label ewLabel"><%= Orders.PaymentSurcharge.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.PaymentSurcharge.CellAttributes %>>
<span id="el_Orders_PaymentSurcharge">
<input type="text" data-field="x_PaymentSurcharge" name="x_PaymentSurcharge" id="x_PaymentSurcharge" size="30" placeholder="<%= Orders.PaymentSurcharge.PlaceHolder %>" value="<%= Orders.PaymentSurcharge.EditValue %>"<%= Orders.PaymentSurcharge.EditAttributes %>>
</span>
<%= Orders.PaymentSurcharge.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.FromIP.Visible Then ' FromIP %>
	<div id="r_FromIP" class="form-group">
		<label id="elh_Orders_FromIP" for="x_FromIP" class="col-sm-2 control-label ewLabel"><%= Orders.FromIP.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.FromIP.CellAttributes %>>
<span id="el_Orders_FromIP">
<input type="text" data-field="x_FromIP" name="x_FromIP" id="x_FromIP" size="30" maxlength="30" placeholder="<%= Orders.FromIP.PlaceHolder %>" value="<%= Orders.FromIP.EditValue %>"<%= Orders.FromIP.EditAttributes %>>
</span>
<%= Orders.FromIP.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.SentEmail.Visible Then ' SentEmail %>
	<div id="r_SentEmail" class="form-group">
		<label id="elh_Orders_SentEmail" for="x_SentEmail" class="col-sm-2 control-label ewLabel"><%= Orders.SentEmail.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.SentEmail.CellAttributes %>>
<span id="el_Orders_SentEmail">
<input type="text" data-field="x_SentEmail" name="x_SentEmail" id="x_SentEmail" size="30" maxlength="255" placeholder="<%= Orders.SentEmail.PlaceHolder %>" value="<%= Orders.SentEmail.EditValue %>"<%= Orders.SentEmail.EditAttributes %>>
</span>
<%= Orders.SentEmail.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.Tax_Rate.Visible Then ' Tax_Rate %>
	<div id="r_Tax_Rate" class="form-group">
		<label id="elh_Orders_Tax_Rate" for="x_Tax_Rate" class="col-sm-2 control-label ewLabel"><%= Orders.Tax_Rate.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.Tax_Rate.CellAttributes %>>
<span id="el_Orders_Tax_Rate">
<input type="text" data-field="x_Tax_Rate" name="x_Tax_Rate" id="x_Tax_Rate" size="30" placeholder="<%= Orders.Tax_Rate.PlaceHolder %>" value="<%= Orders.Tax_Rate.EditValue %>"<%= Orders.Tax_Rate.EditAttributes %>>
</span>
<%= Orders.Tax_Rate.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.Tax_Amount.Visible Then ' Tax_Amount %>
	<div id="r_Tax_Amount" class="form-group">
		<label id="elh_Orders_Tax_Amount" for="x_Tax_Amount" class="col-sm-2 control-label ewLabel"><%= Orders.Tax_Amount.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.Tax_Amount.CellAttributes %>>
<span id="el_Orders_Tax_Amount">
<input type="text" data-field="x_Tax_Amount" name="x_Tax_Amount" id="x_Tax_Amount" size="30" placeholder="<%= Orders.Tax_Amount.PlaceHolder %>" value="<%= Orders.Tax_Amount.EditValue %>"<%= Orders.Tax_Amount.EditAttributes %>>
</span>
<%= Orders.Tax_Amount.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.Tip_Rate.Visible Then ' Tip_Rate %>
	<div id="r_Tip_Rate" class="form-group">
		<label id="elh_Orders_Tip_Rate" for="x_Tip_Rate" class="col-sm-2 control-label ewLabel"><%= Orders.Tip_Rate.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.Tip_Rate.CellAttributes %>>
<span id="el_Orders_Tip_Rate">
<input type="text" data-field="x_Tip_Rate" name="x_Tip_Rate" id="x_Tip_Rate" size="30" maxlength="255" placeholder="<%= Orders.Tip_Rate.PlaceHolder %>" value="<%= Orders.Tip_Rate.EditValue %>"<%= Orders.Tip_Rate.EditAttributes %>>
</span>
<%= Orders.Tip_Rate.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.Tip_Amount.Visible Then ' Tip_Amount %>
	<div id="r_Tip_Amount" class="form-group">
		<label id="elh_Orders_Tip_Amount" for="x_Tip_Amount" class="col-sm-2 control-label ewLabel"><%= Orders.Tip_Amount.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.Tip_Amount.CellAttributes %>>
<span id="el_Orders_Tip_Amount">
<input type="text" data-field="x_Tip_Amount" name="x_Tip_Amount" id="x_Tip_Amount" size="30" placeholder="<%= Orders.Tip_Amount.PlaceHolder %>" value="<%= Orders.Tip_Amount.EditValue %>"<%= Orders.Tip_Amount.EditAttributes %>>
</span>
<%= Orders.Tip_Amount.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.Card_Debit.Visible Then ' Card_Debit %>
	<div id="r_Card_Debit" class="form-group">
		<label id="elh_Orders_Card_Debit" for="x_Card_Debit" class="col-sm-2 control-label ewLabel"><%= Orders.Card_Debit.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.Card_Debit.CellAttributes %>>
<span id="el_Orders_Card_Debit">
<input type="text" data-field="x_Card_Debit" name="x_Card_Debit" id="x_Card_Debit" size="30" placeholder="<%= Orders.Card_Debit.PlaceHolder %>" value="<%= Orders.Card_Debit.EditValue %>"<%= Orders.Card_Debit.EditAttributes %>>
</span>
<%= Orders.Card_Debit.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.Card_Credit.Visible Then ' Card_Credit %>
	<div id="r_Card_Credit" class="form-group">
		<label id="elh_Orders_Card_Credit" for="x_Card_Credit" class="col-sm-2 control-label ewLabel"><%= Orders.Card_Credit.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.Card_Credit.CellAttributes %>>
<span id="el_Orders_Card_Credit">
<input type="text" data-field="x_Card_Credit" name="x_Card_Credit" id="x_Card_Credit" size="30" placeholder="<%= Orders.Card_Credit.PlaceHolder %>" value="<%= Orders.Card_Credit.EditValue %>"<%= Orders.Card_Credit.EditAttributes %>>
</span>
<%= Orders.Card_Credit.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.deliverydelay.Visible Then ' deliverydelay %>
	<div id="r_deliverydelay" class="form-group">
		<label id="elh_Orders_deliverydelay" for="x_deliverydelay" class="col-sm-2 control-label ewLabel"><%= Orders.deliverydelay.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.deliverydelay.CellAttributes %>>
<span id="el_Orders_deliverydelay">
<input type="text" data-field="x_deliverydelay" name="x_deliverydelay" id="x_deliverydelay" size="30" placeholder="<%= Orders.deliverydelay.PlaceHolder %>" value="<%= Orders.deliverydelay.EditValue %>"<%= Orders.deliverydelay.EditAttributes %>>
</span>
<%= Orders.deliverydelay.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.collectiondelay.Visible Then ' collectiondelay %>
	<div id="r_collectiondelay" class="form-group">
		<label id="elh_Orders_collectiondelay" for="x_collectiondelay" class="col-sm-2 control-label ewLabel"><%= Orders.collectiondelay.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.collectiondelay.CellAttributes %>>
<span id="el_Orders_collectiondelay">
<input type="text" data-field="x_collectiondelay" name="x_collectiondelay" id="x_collectiondelay" size="30" placeholder="<%= Orders.collectiondelay.PlaceHolder %>" value="<%= Orders.collectiondelay.EditValue %>"<%= Orders.collectiondelay.EditAttributes %>>
</span>
<%= Orders.collectiondelay.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.lng_report.Visible Then ' lng_report %>
	<div id="r_lng_report" class="form-group">
		<label id="elh_Orders_lng_report" for="x_lng_report" class="col-sm-2 control-label ewLabel"><%= Orders.lng_report.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.lng_report.CellAttributes %>>
<span id="el_Orders_lng_report">
<input type="text" data-field="x_lng_report" name="x_lng_report" id="x_lng_report" size="30" maxlength="255" placeholder="<%= Orders.lng_report.PlaceHolder %>" value="<%= Orders.lng_report.EditValue %>"<%= Orders.lng_report.EditAttributes %>>
</span>
<%= Orders.lng_report.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.lat_report.Visible Then ' lat_report %>
	<div id="r_lat_report" class="form-group">
		<label id="elh_Orders_lat_report" for="x_lat_report" class="col-sm-2 control-label ewLabel"><%= Orders.lat_report.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.lat_report.CellAttributes %>>
<span id="el_Orders_lat_report">
<input type="text" data-field="x_lat_report" name="x_lat_report" id="x_lat_report" size="30" maxlength="255" placeholder="<%= Orders.lat_report.PlaceHolder %>" value="<%= Orders.lat_report.EditValue %>"<%= Orders.lat_report.EditAttributes %>>
</span>
<%= Orders.lat_report.CustomMsg %></div></div>
	</div>
<% End If %>
<% If Orders.Payment_status.Visible Then ' Payment_status %>
	<div id="r_Payment_status" class="form-group">
		<label id="elh_Orders_Payment_status" for="x_Payment_status" class="col-sm-2 control-label ewLabel"><%= Orders.Payment_status.FldCaption %></label>
		<div class="col-sm-10"><div<%= Orders.Payment_status.CellAttributes %>>
<span id="el_Orders_Payment_status">
<input type="text" data-field="x_Payment_status" name="x_Payment_status" id="x_Payment_status" size="30" maxlength="255" placeholder="<%= Orders.Payment_status.PlaceHolder %>" value="<%= Orders.Payment_status.EditValue %>"<%= Orders.Payment_status.EditAttributes %>>
</span>
<%= Orders.Payment_status.CustomMsg %></div></div>
	</div>
<% End If %>
</div>
<div class="form-group">
	<div class="col-sm-offset-2 col-sm-10">
<button class="btn btn-primary ewButton" name="btnAction" id="btnAction" type="submit"><%= Language.Phrase("SaveBtn") %></button>
	</div>
</div>
</form>
<script type="text/javascript">
fOrdersedit.Init();
</script>
<%
Orders_edit.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set Orders_edit = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cOrders_edit

	' Page ID
	Public Property Get PageID()
		PageID = "edit"
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
		PageObjName = "Orders_edit"
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
		EW_PAGE_ID = "edit"

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

		' Create form object
		'If ew_IsHttpPost() Then

			Set ObjForm = New cFormObj

		'Else
		'	Set ObjForm = ew_GetUploadObj()
		'End If

		Orders.CurrentAction = ew_IIf(Request.QueryString("a").Count > 0, Request.QueryString("a") & "", ObjForm.GetValue("a_list") & "") ' Set up current action
		Orders.ID.Visible = Not Orders.IsAdd() And Not Orders.IsCopy() And Not Orders.IsGridAdd()

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
	Dim DisplayRecs
	Dim StartRec, StopRec, TotalRecs, RecRange
	Dim RecCnt
	Dim Recordset

	' -----------------------------------------------------------------
	' Page main processing
	'
	Sub Page_Main()
		Dim sReturnUrl
		sReturnUrl = ""

		' Load key from QueryString
		If Request.QueryString("ID").Count > 0 Then
			Orders.ID.QueryStringValue = Request.QueryString("ID")
		End If

		' Set up Breadcrumb
		SetupBreadcrumb()

		' Process form if post back
		If ObjForm.GetValue("a_edit")&"" <> "" Then
			Orders.CurrentAction = ObjForm.GetValue("a_edit") ' Get action code
			Call LoadFormValues() ' Get form values
		Else
			Orders.CurrentAction = "I" ' Default action is display
		End If

		' Check if valid key
		If Orders.ID.CurrentValue = "" Then Call Page_Terminate("Orderslist.asp") ' Invalid key, return to list

		' Validate form if post back
		If ObjForm.GetValue("a_edit")&"" <> "" Then
			If Not ValidateForm() Then
				Orders.CurrentAction = "" ' Form error, reset action
				FailureMessage = gsFormError
				Orders.EventCancelled = True ' Event cancelled
				Call LoadRow() ' Restore row
				Call RestoreFormValues() ' Restore form values if validate failed
			End If
		End If
		Select Case Orders.CurrentAction
			Case "I" ' Get a record to display
				If Not LoadRow() Then ' Load Record based on key
					If FailureMessage = "" Then FailureMessage = Language.Phrase("NoRecord") ' No record found
					Call Page_Terminate("Orderslist.asp") ' No matching record, return to list
				End If
			Case "U" ' Update
				Orders.SendEmail = True ' Send email on update success
				If EditRow() Then ' Update Record based on key
					If SuccessMessage = "" Then SuccessMessage = Language.Phrase("UpdateSuccess") ' Update success
					sReturnUrl = Orders.ReturnUrl
					Call Page_Terminate(sReturnUrl) ' Return to caller
				Else
					Orders.EventCancelled = True ' Event cancelled
					Call LoadRow() ' Restore row
					Call RestoreFormValues() ' Restore form values if update failed
				End If
		End Select

		' Render the record
		Orders.RowType = EW_ROWTYPE_EDIT ' Render as edit

		' Render row
		Call Orders.ResetAttrs()
		Call RenderRow()
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
	' Function Get upload files
	'
	Function GetUploadFiles()

		' Get upload data
	End Function

	' -----------------------------------------------------------------
	' Load form values
	'
	Function LoadFormValues()

		' Load values from form
		If Not Orders.ID.FldIsDetailKey Then Orders.ID.FormValue = ObjForm.GetValue("x_ID")
		If Not Orders.CreationDate.FldIsDetailKey Then Orders.CreationDate.FormValue = ObjForm.GetValue("x_CreationDate")
		If Not Orders.CreationDate.FldIsDetailKey Then Orders.CreationDate.CurrentValue = ew_UnFormatDateTime(Orders.CreationDate.CurrentValue, 9)
		If Not Orders.OrderDate.FldIsDetailKey Then Orders.OrderDate.FormValue = ObjForm.GetValue("x_OrderDate")
		If Not Orders.OrderDate.FldIsDetailKey Then Orders.OrderDate.CurrentValue = ew_UnFormatDateTime(Orders.OrderDate.CurrentValue, 9)
		If Not Orders.DeliveryType.FldIsDetailKey Then Orders.DeliveryType.FormValue = ObjForm.GetValue("x_DeliveryType")
		If Not Orders.DeliveryTime.FldIsDetailKey Then Orders.DeliveryTime.FormValue = ObjForm.GetValue("x_DeliveryTime")
		If Not Orders.DeliveryTime.FldIsDetailKey Then Orders.DeliveryTime.CurrentValue = ew_UnFormatDateTime(Orders.DeliveryTime.CurrentValue, 9)
		If Not Orders.PaymentType.FldIsDetailKey Then Orders.PaymentType.FormValue = ObjForm.GetValue("x_PaymentType")
		If Not Orders.SubTotal.FldIsDetailKey Then Orders.SubTotal.FormValue = ObjForm.GetValue("x_SubTotal")
		If Not Orders.ShippingFee.FldIsDetailKey Then Orders.ShippingFee.FormValue = ObjForm.GetValue("x_ShippingFee")
		If Not Orders.OrderTotal.FldIsDetailKey Then Orders.OrderTotal.FormValue = ObjForm.GetValue("x_OrderTotal")
		If Not Orders.IdBusinessDetail.FldIsDetailKey Then Orders.IdBusinessDetail.FormValue = ObjForm.GetValue("x_IdBusinessDetail")
		If Not Orders.SessionId.FldIsDetailKey Then Orders.SessionId.FormValue = ObjForm.GetValue("x_SessionId")
		If Not Orders.FirstName.FldIsDetailKey Then Orders.FirstName.FormValue = ObjForm.GetValue("x_FirstName")
		If Not Orders.LastName.FldIsDetailKey Then Orders.LastName.FormValue = ObjForm.GetValue("x_LastName")
		If Not Orders.zEmail.FldIsDetailKey Then Orders.zEmail.FormValue = ObjForm.GetValue("x_zEmail")
		If Not Orders.Phone.FldIsDetailKey Then Orders.Phone.FormValue = ObjForm.GetValue("x_Phone")
		If Not Orders.Address.FldIsDetailKey Then Orders.Address.FormValue = ObjForm.GetValue("x_Address")
		If Not Orders.PostalCode.FldIsDetailKey Then Orders.PostalCode.FormValue = ObjForm.GetValue("x_PostalCode")
		If Not Orders.Notes.FldIsDetailKey Then Orders.Notes.FormValue = ObjForm.GetValue("x_Notes")
		If Not Orders.ttest.FldIsDetailKey Then Orders.ttest.FormValue = ObjForm.GetValue("x_ttest")
		If Not Orders.cancelleddate.FldIsDetailKey Then Orders.cancelleddate.FormValue = ObjForm.GetValue("x_cancelleddate")
		If Not Orders.cancelleddate.FldIsDetailKey Then Orders.cancelleddate.CurrentValue = ew_UnFormatDateTime(Orders.cancelleddate.CurrentValue, 9)
		If Not Orders.cancelledby.FldIsDetailKey Then Orders.cancelledby.FormValue = ObjForm.GetValue("x_cancelledby")
		If Not Orders.cancelledreason.FldIsDetailKey Then Orders.cancelledreason.FormValue = ObjForm.GetValue("x_cancelledreason")
		If Not Orders.acknowledgeddate.FldIsDetailKey Then Orders.acknowledgeddate.FormValue = ObjForm.GetValue("x_acknowledgeddate")
		If Not Orders.acknowledgeddate.FldIsDetailKey Then Orders.acknowledgeddate.CurrentValue = ew_UnFormatDateTime(Orders.acknowledgeddate.CurrentValue, 9)
		If Not Orders.delivereddate.FldIsDetailKey Then Orders.delivereddate.FormValue = ObjForm.GetValue("x_delivereddate")
		If Not Orders.cancelled.FldIsDetailKey Then Orders.cancelled.FormValue = ObjForm.GetValue("x_cancelled")
		If Not Orders.acknowledged.FldIsDetailKey Then Orders.acknowledged.FormValue = ObjForm.GetValue("x_acknowledged")
		If Not Orders.outfordelivery.FldIsDetailKey Then Orders.outfordelivery.FormValue = ObjForm.GetValue("x_outfordelivery")
		If Not Orders.vouchercodediscount.FldIsDetailKey Then Orders.vouchercodediscount.FormValue = ObjForm.GetValue("x_vouchercodediscount")
		If Not Orders.vouchercode.FldIsDetailKey Then Orders.vouchercode.FormValue = ObjForm.GetValue("x_vouchercode")
		If Not Orders.printed.FldIsDetailKey Then Orders.printed.FormValue = ObjForm.GetValue("x_printed")
		If Not Orders.deliverydistance.FldIsDetailKey Then Orders.deliverydistance.FormValue = ObjForm.GetValue("x_deliverydistance")
		If Not Orders.asaporder.FldIsDetailKey Then Orders.asaporder.FormValue = ObjForm.GetValue("x_asaporder")
		If Not Orders.DeliveryLat.FldIsDetailKey Then Orders.DeliveryLat.FormValue = ObjForm.GetValue("x_DeliveryLat")
		If Not Orders.DeliveryLng.FldIsDetailKey Then Orders.DeliveryLng.FormValue = ObjForm.GetValue("x_DeliveryLng")
		If Not Orders.ServiceCharge.FldIsDetailKey Then Orders.ServiceCharge.FormValue = ObjForm.GetValue("x_ServiceCharge")
		If Not Orders.PaymentSurcharge.FldIsDetailKey Then Orders.PaymentSurcharge.FormValue = ObjForm.GetValue("x_PaymentSurcharge")
		If Not Orders.FromIP.FldIsDetailKey Then Orders.FromIP.FormValue = ObjForm.GetValue("x_FromIP")
		If Not Orders.SentEmail.FldIsDetailKey Then Orders.SentEmail.FormValue = ObjForm.GetValue("x_SentEmail")
		If Not Orders.Tax_Rate.FldIsDetailKey Then Orders.Tax_Rate.FormValue = ObjForm.GetValue("x_Tax_Rate")
		If Not Orders.Tax_Amount.FldIsDetailKey Then Orders.Tax_Amount.FormValue = ObjForm.GetValue("x_Tax_Amount")
		If Not Orders.Tip_Rate.FldIsDetailKey Then Orders.Tip_Rate.FormValue = ObjForm.GetValue("x_Tip_Rate")
		If Not Orders.Tip_Amount.FldIsDetailKey Then Orders.Tip_Amount.FormValue = ObjForm.GetValue("x_Tip_Amount")
		If Not Orders.Card_Debit.FldIsDetailKey Then Orders.Card_Debit.FormValue = ObjForm.GetValue("x_Card_Debit")
		If Not Orders.Card_Credit.FldIsDetailKey Then Orders.Card_Credit.FormValue = ObjForm.GetValue("x_Card_Credit")
		If Not Orders.deliverydelay.FldIsDetailKey Then Orders.deliverydelay.FormValue = ObjForm.GetValue("x_deliverydelay")
		If Not Orders.collectiondelay.FldIsDetailKey Then Orders.collectiondelay.FormValue = ObjForm.GetValue("x_collectiondelay")
		If Not Orders.lng_report.FldIsDetailKey Then Orders.lng_report.FormValue = ObjForm.GetValue("x_lng_report")
		If Not Orders.lat_report.FldIsDetailKey Then Orders.lat_report.FormValue = ObjForm.GetValue("x_lat_report")
		If Not Orders.Payment_status.FldIsDetailKey Then Orders.Payment_status.FormValue = ObjForm.GetValue("x_Payment_status")
	End Function

	' -----------------------------------------------------------------
	' Restore form values
	'
	Function RestoreFormValues()
		Call LoadRow()
		Orders.ID.CurrentValue = Orders.ID.FormValue
		Orders.CreationDate.CurrentValue = Orders.CreationDate.FormValue
		Orders.CreationDate.CurrentValue = ew_UnFormatDateTime(Orders.CreationDate.CurrentValue, 9)
		Orders.OrderDate.CurrentValue = Orders.OrderDate.FormValue
		Orders.OrderDate.CurrentValue = ew_UnFormatDateTime(Orders.OrderDate.CurrentValue, 9)
		Orders.DeliveryType.CurrentValue = Orders.DeliveryType.FormValue
		Orders.DeliveryTime.CurrentValue = Orders.DeliveryTime.FormValue
		Orders.DeliveryTime.CurrentValue = ew_UnFormatDateTime(Orders.DeliveryTime.CurrentValue, 9)
		Orders.PaymentType.CurrentValue = Orders.PaymentType.FormValue
		Orders.SubTotal.CurrentValue = Orders.SubTotal.FormValue
		Orders.ShippingFee.CurrentValue = Orders.ShippingFee.FormValue
		Orders.OrderTotal.CurrentValue = Orders.OrderTotal.FormValue
		Orders.IdBusinessDetail.CurrentValue = Orders.IdBusinessDetail.FormValue
		Orders.SessionId.CurrentValue = Orders.SessionId.FormValue
		Orders.FirstName.CurrentValue = Orders.FirstName.FormValue
		Orders.LastName.CurrentValue = Orders.LastName.FormValue
		Orders.zEmail.CurrentValue = Orders.zEmail.FormValue
		Orders.Phone.CurrentValue = Orders.Phone.FormValue
		Orders.Address.CurrentValue = Orders.Address.FormValue
		Orders.PostalCode.CurrentValue = Orders.PostalCode.FormValue
		Orders.Notes.CurrentValue = Orders.Notes.FormValue
		Orders.ttest.CurrentValue = Orders.ttest.FormValue
		Orders.cancelleddate.CurrentValue = Orders.cancelleddate.FormValue
		Orders.cancelleddate.CurrentValue = ew_UnFormatDateTime(Orders.cancelleddate.CurrentValue, 9)
		Orders.cancelledby.CurrentValue = Orders.cancelledby.FormValue
		Orders.cancelledreason.CurrentValue = Orders.cancelledreason.FormValue
		Orders.acknowledgeddate.CurrentValue = Orders.acknowledgeddate.FormValue
		Orders.acknowledgeddate.CurrentValue = ew_UnFormatDateTime(Orders.acknowledgeddate.CurrentValue, 9)
		Orders.delivereddate.CurrentValue = Orders.delivereddate.FormValue
		Orders.cancelled.CurrentValue = Orders.cancelled.FormValue
		Orders.acknowledged.CurrentValue = Orders.acknowledged.FormValue
		Orders.outfordelivery.CurrentValue = Orders.outfordelivery.FormValue
		Orders.vouchercodediscount.CurrentValue = Orders.vouchercodediscount.FormValue
		Orders.vouchercode.CurrentValue = Orders.vouchercode.FormValue
		Orders.printed.CurrentValue = Orders.printed.FormValue
		Orders.deliverydistance.CurrentValue = Orders.deliverydistance.FormValue
		Orders.asaporder.CurrentValue = Orders.asaporder.FormValue
		Orders.DeliveryLat.CurrentValue = Orders.DeliveryLat.FormValue
		Orders.DeliveryLng.CurrentValue = Orders.DeliveryLng.FormValue
		Orders.ServiceCharge.CurrentValue = Orders.ServiceCharge.FormValue
		Orders.PaymentSurcharge.CurrentValue = Orders.PaymentSurcharge.FormValue
		Orders.FromIP.CurrentValue = Orders.FromIP.FormValue
		Orders.SentEmail.CurrentValue = Orders.SentEmail.FormValue
		Orders.Tax_Rate.CurrentValue = Orders.Tax_Rate.FormValue
		Orders.Tax_Amount.CurrentValue = Orders.Tax_Amount.FormValue
		Orders.Tip_Rate.CurrentValue = Orders.Tip_Rate.FormValue
		Orders.Tip_Amount.CurrentValue = Orders.Tip_Amount.FormValue
		Orders.Card_Debit.CurrentValue = Orders.Card_Debit.FormValue
		Orders.Card_Credit.CurrentValue = Orders.Card_Credit.FormValue
		Orders.deliverydelay.CurrentValue = Orders.deliverydelay.FormValue
		Orders.collectiondelay.CurrentValue = Orders.collectiondelay.FormValue
		Orders.lng_report.CurrentValue = Orders.lng_report.FormValue
		Orders.lat_report.CurrentValue = Orders.lat_report.FormValue
		Orders.Payment_status.CurrentValue = Orders.Payment_status.FormValue
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

		' ----------
		'  Edit Row
		' ----------

		ElseIf Orders.RowType = EW_ROWTYPE_EDIT Then ' Edit row

			' ID
			Orders.ID.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.ID.EditCustomAttributes = ""
			Orders.ID.EditValue = Orders.ID.CurrentValue
			Orders.ID.ViewCustomAttributes = ""

			' CreationDate
			Orders.CreationDate.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.CreationDate.EditCustomAttributes = ""
			Orders.CreationDate.EditValue = ew_HtmlEncode(Orders.CreationDate.CurrentValue)
			Orders.CreationDate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.CreationDate.FldCaption))

			' OrderDate
			Orders.OrderDate.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.OrderDate.EditCustomAttributes = ""
			Orders.OrderDate.EditValue = ew_HtmlEncode(Orders.OrderDate.CurrentValue)
			Orders.OrderDate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.OrderDate.FldCaption))

			' DeliveryType
			Orders.DeliveryType.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.DeliveryType.EditCustomAttributes = ""
			Orders.DeliveryType.EditValue = ew_HtmlEncode(Orders.DeliveryType.CurrentValue)
			Orders.DeliveryType.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.DeliveryType.FldCaption))

			' DeliveryTime
			Orders.DeliveryTime.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.DeliveryTime.EditCustomAttributes = ""
			Orders.DeliveryTime.EditValue = ew_HtmlEncode(Orders.DeliveryTime.CurrentValue)
			Orders.DeliveryTime.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.DeliveryTime.FldCaption))

			' PaymentType
			Orders.PaymentType.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.PaymentType.EditCustomAttributes = ""
			Orders.PaymentType.EditValue = ew_HtmlEncode(Orders.PaymentType.CurrentValue)
			Orders.PaymentType.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.PaymentType.FldCaption))

			' SubTotal
			Orders.SubTotal.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.SubTotal.EditCustomAttributes = ""
			Orders.SubTotal.EditValue = ew_HtmlEncode(Orders.SubTotal.CurrentValue)
			Orders.SubTotal.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.SubTotal.FldCaption))
			If Orders.SubTotal.EditValue&"" <> "" And IsNumeric(Orders.SubTotal.EditValue) Then Orders.SubTotal.EditValue = ew_FormatNumber2(Orders.SubTotal.EditValue, -2)

			' ShippingFee
			Orders.ShippingFee.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.ShippingFee.EditCustomAttributes = ""
			Orders.ShippingFee.EditValue = ew_HtmlEncode(Orders.ShippingFee.CurrentValue)
			Orders.ShippingFee.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.ShippingFee.FldCaption))
			If Orders.ShippingFee.EditValue&"" <> "" And IsNumeric(Orders.ShippingFee.EditValue) Then Orders.ShippingFee.EditValue = ew_FormatNumber2(Orders.ShippingFee.EditValue, -2)

			' OrderTotal
			Orders.OrderTotal.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.OrderTotal.EditCustomAttributes = ""
			Orders.OrderTotal.EditValue = ew_HtmlEncode(Orders.OrderTotal.CurrentValue)
			Orders.OrderTotal.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.OrderTotal.FldCaption))
			If Orders.OrderTotal.EditValue&"" <> "" And IsNumeric(Orders.OrderTotal.EditValue) Then Orders.OrderTotal.EditValue = ew_FormatNumber2(Orders.OrderTotal.EditValue, -2)

			' IdBusinessDetail
			Orders.IdBusinessDetail.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.IdBusinessDetail.EditCustomAttributes = ""
			Orders.IdBusinessDetail.EditValue = ew_HtmlEncode(Orders.IdBusinessDetail.CurrentValue)
			Orders.IdBusinessDetail.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.IdBusinessDetail.FldCaption))

			' SessionId
			Orders.SessionId.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.SessionId.EditCustomAttributes = ""
			Orders.SessionId.EditValue = ew_HtmlEncode(Orders.SessionId.CurrentValue)
			Orders.SessionId.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.SessionId.FldCaption))

			' FirstName
			Orders.FirstName.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.FirstName.EditCustomAttributes = ""
			Orders.FirstName.EditValue = ew_HtmlEncode(Orders.FirstName.CurrentValue)
			Orders.FirstName.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.FirstName.FldCaption))

			' LastName
			Orders.LastName.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.LastName.EditCustomAttributes = ""
			Orders.LastName.EditValue = ew_HtmlEncode(Orders.LastName.CurrentValue)
			Orders.LastName.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.LastName.FldCaption))

			' Email
			Orders.zEmail.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.zEmail.EditCustomAttributes = ""
			Orders.zEmail.EditValue = ew_HtmlEncode(Orders.zEmail.CurrentValue)
			Orders.zEmail.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.zEmail.FldCaption))

			' Phone
			Orders.Phone.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.Phone.EditCustomAttributes = ""
			Orders.Phone.EditValue = ew_HtmlEncode(Orders.Phone.CurrentValue)
			Orders.Phone.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.Phone.FldCaption))

			' Address
			Orders.Address.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.Address.EditCustomAttributes = ""
			Orders.Address.EditValue = ew_HtmlEncode(Orders.Address.CurrentValue)
			Orders.Address.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.Address.FldCaption))

			' PostalCode
			Orders.PostalCode.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.PostalCode.EditCustomAttributes = ""
			Orders.PostalCode.EditValue = ew_HtmlEncode(Orders.PostalCode.CurrentValue)
			Orders.PostalCode.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.PostalCode.FldCaption))

			' Notes
			Orders.Notes.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.Notes.EditCustomAttributes = ""
			Orders.Notes.EditValue = ew_HtmlEncode(Orders.Notes.CurrentValue)
			Orders.Notes.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.Notes.FldCaption))

			' ttest
			Orders.ttest.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.ttest.EditCustomAttributes = ""
			Orders.ttest.EditValue = ew_HtmlEncode(Orders.ttest.CurrentValue)
			Orders.ttest.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.ttest.FldCaption))

			' cancelleddate
			Orders.cancelleddate.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.cancelleddate.EditCustomAttributes = ""
			Orders.cancelleddate.EditValue = ew_HtmlEncode(Orders.cancelleddate.CurrentValue)
			Orders.cancelleddate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.cancelleddate.FldCaption))

			' cancelledby
			Orders.cancelledby.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.cancelledby.EditCustomAttributes = ""
			Orders.cancelledby.EditValue = ew_HtmlEncode(Orders.cancelledby.CurrentValue)
			Orders.cancelledby.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.cancelledby.FldCaption))

			' cancelledreason
			Orders.cancelledreason.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.cancelledreason.EditCustomAttributes = ""
			Orders.cancelledreason.EditValue = ew_HtmlEncode(Orders.cancelledreason.CurrentValue)
			Orders.cancelledreason.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.cancelledreason.FldCaption))

			' acknowledgeddate
			Orders.acknowledgeddate.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.acknowledgeddate.EditCustomAttributes = ""
			Orders.acknowledgeddate.EditValue = ew_HtmlEncode(Orders.acknowledgeddate.CurrentValue)
			Orders.acknowledgeddate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.acknowledgeddate.FldCaption))

			' delivereddate
			Orders.delivereddate.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.delivereddate.EditCustomAttributes = ""
			Orders.delivereddate.EditValue = ew_HtmlEncode(Orders.delivereddate.CurrentValue)
			Orders.delivereddate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.delivereddate.FldCaption))

			' cancelled
			Orders.cancelled.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.cancelled.EditCustomAttributes = ""
			Orders.cancelled.EditValue = ew_HtmlEncode(Orders.cancelled.CurrentValue)
			Orders.cancelled.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.cancelled.FldCaption))

			' acknowledged
			Orders.acknowledged.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.acknowledged.EditCustomAttributes = ""
			Orders.acknowledged.EditValue = ew_HtmlEncode(Orders.acknowledged.CurrentValue)
			Orders.acknowledged.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.acknowledged.FldCaption))

			' outfordelivery
			Orders.outfordelivery.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.outfordelivery.EditCustomAttributes = ""
			Orders.outfordelivery.EditValue = ew_HtmlEncode(Orders.outfordelivery.CurrentValue)
			Orders.outfordelivery.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.outfordelivery.FldCaption))

			' vouchercodediscount
			Orders.vouchercodediscount.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.vouchercodediscount.EditCustomAttributes = ""
			Orders.vouchercodediscount.EditValue = ew_HtmlEncode(Orders.vouchercodediscount.CurrentValue)
			Orders.vouchercodediscount.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.vouchercodediscount.FldCaption))

			' vouchercode
			Orders.vouchercode.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.vouchercode.EditCustomAttributes = ""
			Orders.vouchercode.EditValue = ew_HtmlEncode(Orders.vouchercode.CurrentValue)
			Orders.vouchercode.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.vouchercode.FldCaption))

			' printed
			Orders.printed.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.printed.EditCustomAttributes = ""
			Orders.printed.EditValue = ew_HtmlEncode(Orders.printed.CurrentValue)
			Orders.printed.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.printed.FldCaption))

			' deliverydistance
			Orders.deliverydistance.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.deliverydistance.EditCustomAttributes = ""
			Orders.deliverydistance.EditValue = ew_HtmlEncode(Orders.deliverydistance.CurrentValue)
			Orders.deliverydistance.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.deliverydistance.FldCaption))

			' asaporder
			Orders.asaporder.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.asaporder.EditCustomAttributes = ""
			Orders.asaporder.EditValue = ew_HtmlEncode(Orders.asaporder.CurrentValue)
			Orders.asaporder.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.asaporder.FldCaption))

			' DeliveryLat
			Orders.DeliveryLat.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.DeliveryLat.EditCustomAttributes = ""
			Orders.DeliveryLat.EditValue = ew_HtmlEncode(Orders.DeliveryLat.CurrentValue)
			Orders.DeliveryLat.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.DeliveryLat.FldCaption))

			' DeliveryLng
			Orders.DeliveryLng.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.DeliveryLng.EditCustomAttributes = ""
			Orders.DeliveryLng.EditValue = ew_HtmlEncode(Orders.DeliveryLng.CurrentValue)
			Orders.DeliveryLng.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.DeliveryLng.FldCaption))

			' ServiceCharge
			Orders.ServiceCharge.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.ServiceCharge.EditCustomAttributes = ""
			Orders.ServiceCharge.EditValue = ew_HtmlEncode(Orders.ServiceCharge.CurrentValue)
			Orders.ServiceCharge.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.ServiceCharge.FldCaption))
			If Orders.ServiceCharge.EditValue&"" <> "" And IsNumeric(Orders.ServiceCharge.EditValue) Then Orders.ServiceCharge.EditValue = ew_FormatNumber2(Orders.ServiceCharge.EditValue, -2)

			' PaymentSurcharge
			Orders.PaymentSurcharge.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.PaymentSurcharge.EditCustomAttributes = ""
			Orders.PaymentSurcharge.EditValue = ew_HtmlEncode(Orders.PaymentSurcharge.CurrentValue)
			Orders.PaymentSurcharge.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.PaymentSurcharge.FldCaption))
			If Orders.PaymentSurcharge.EditValue&"" <> "" And IsNumeric(Orders.PaymentSurcharge.EditValue) Then Orders.PaymentSurcharge.EditValue = ew_FormatNumber2(Orders.PaymentSurcharge.EditValue, -2)

			' FromIP
			Orders.FromIP.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.FromIP.EditCustomAttributes = ""
			Orders.FromIP.EditValue = ew_HtmlEncode(Orders.FromIP.CurrentValue)
			Orders.FromIP.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.FromIP.FldCaption))

			' SentEmail
			Orders.SentEmail.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.SentEmail.EditCustomAttributes = ""
			Orders.SentEmail.EditValue = ew_HtmlEncode(Orders.SentEmail.CurrentValue)
			Orders.SentEmail.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.SentEmail.FldCaption))

			' Tax_Rate
			Orders.Tax_Rate.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.Tax_Rate.EditCustomAttributes = ""
			Orders.Tax_Rate.EditValue = ew_HtmlEncode(Orders.Tax_Rate.CurrentValue)
			Orders.Tax_Rate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.Tax_Rate.FldCaption))

			' Tax_Amount
			Orders.Tax_Amount.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.Tax_Amount.EditCustomAttributes = ""
			Orders.Tax_Amount.EditValue = ew_HtmlEncode(Orders.Tax_Amount.CurrentValue)
			Orders.Tax_Amount.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.Tax_Amount.FldCaption))
			If Orders.Tax_Amount.EditValue&"" <> "" And IsNumeric(Orders.Tax_Amount.EditValue) Then Orders.Tax_Amount.EditValue = ew_FormatNumber2(Orders.Tax_Amount.EditValue, -2)

			' Tip_Rate
			Orders.Tip_Rate.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.Tip_Rate.EditCustomAttributes = ""
			Orders.Tip_Rate.EditValue = ew_HtmlEncode(Orders.Tip_Rate.CurrentValue)
			Orders.Tip_Rate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.Tip_Rate.FldCaption))

			' Tip_Amount
			Orders.Tip_Amount.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.Tip_Amount.EditCustomAttributes = ""
			Orders.Tip_Amount.EditValue = ew_HtmlEncode(Orders.Tip_Amount.CurrentValue)
			Orders.Tip_Amount.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.Tip_Amount.FldCaption))
			If Orders.Tip_Amount.EditValue&"" <> "" And IsNumeric(Orders.Tip_Amount.EditValue) Then Orders.Tip_Amount.EditValue = ew_FormatNumber2(Orders.Tip_Amount.EditValue, -2)

			' Card_Debit
			Orders.Card_Debit.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.Card_Debit.EditCustomAttributes = ""
			Orders.Card_Debit.EditValue = ew_HtmlEncode(Orders.Card_Debit.CurrentValue)
			Orders.Card_Debit.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.Card_Debit.FldCaption))

			' Card_Credit
			Orders.Card_Credit.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.Card_Credit.EditCustomAttributes = ""
			Orders.Card_Credit.EditValue = ew_HtmlEncode(Orders.Card_Credit.CurrentValue)
			Orders.Card_Credit.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.Card_Credit.FldCaption))

			' deliverydelay
			Orders.deliverydelay.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.deliverydelay.EditCustomAttributes = ""
			Orders.deliverydelay.EditValue = ew_HtmlEncode(Orders.deliverydelay.CurrentValue)
			Orders.deliverydelay.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.deliverydelay.FldCaption))

			' collectiondelay
			Orders.collectiondelay.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.collectiondelay.EditCustomAttributes = ""
			Orders.collectiondelay.EditValue = ew_HtmlEncode(Orders.collectiondelay.CurrentValue)
			Orders.collectiondelay.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.collectiondelay.FldCaption))

			' lng_report
			Orders.lng_report.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.lng_report.EditCustomAttributes = ""
			Orders.lng_report.EditValue = ew_HtmlEncode(Orders.lng_report.CurrentValue)
			Orders.lng_report.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.lng_report.FldCaption))

			' lat_report
			Orders.lat_report.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.lat_report.EditCustomAttributes = ""
			Orders.lat_report.EditValue = ew_HtmlEncode(Orders.lat_report.CurrentValue)
			Orders.lat_report.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.lat_report.FldCaption))

			' Payment_status
			Orders.Payment_status.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.Payment_status.EditCustomAttributes = ""
			Orders.Payment_status.EditValue = ew_HtmlEncode(Orders.Payment_status.CurrentValue)
			Orders.Payment_status.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.Payment_status.FldCaption))

			' Edit refer script
			' ID

			Orders.ID.HrefValue = ""

			' CreationDate
			Orders.CreationDate.HrefValue = ""

			' OrderDate
			Orders.OrderDate.HrefValue = ""

			' DeliveryType
			Orders.DeliveryType.HrefValue = ""

			' DeliveryTime
			Orders.DeliveryTime.HrefValue = ""

			' PaymentType
			Orders.PaymentType.HrefValue = ""

			' SubTotal
			Orders.SubTotal.HrefValue = ""

			' ShippingFee
			Orders.ShippingFee.HrefValue = ""

			' OrderTotal
			Orders.OrderTotal.HrefValue = ""

			' IdBusinessDetail
			Orders.IdBusinessDetail.HrefValue = ""

			' SessionId
			Orders.SessionId.HrefValue = ""

			' FirstName
			Orders.FirstName.HrefValue = ""

			' LastName
			Orders.LastName.HrefValue = ""

			' Email
			Orders.zEmail.HrefValue = ""

			' Phone
			Orders.Phone.HrefValue = ""

			' Address
			Orders.Address.HrefValue = ""

			' PostalCode
			Orders.PostalCode.HrefValue = ""

			' Notes
			Orders.Notes.HrefValue = ""

			' ttest
			Orders.ttest.HrefValue = ""

			' cancelleddate
			Orders.cancelleddate.HrefValue = ""

			' cancelledby
			Orders.cancelledby.HrefValue = ""

			' cancelledreason
			Orders.cancelledreason.HrefValue = ""

			' acknowledgeddate
			Orders.acknowledgeddate.HrefValue = ""

			' delivereddate
			Orders.delivereddate.HrefValue = ""

			' cancelled
			Orders.cancelled.HrefValue = ""

			' acknowledged
			Orders.acknowledged.HrefValue = ""

			' outfordelivery
			Orders.outfordelivery.HrefValue = ""

			' vouchercodediscount
			Orders.vouchercodediscount.HrefValue = ""

			' vouchercode
			Orders.vouchercode.HrefValue = ""

			' printed
			Orders.printed.HrefValue = ""

			' deliverydistance
			Orders.deliverydistance.HrefValue = ""

			' asaporder
			Orders.asaporder.HrefValue = ""

			' DeliveryLat
			Orders.DeliveryLat.HrefValue = ""

			' DeliveryLng
			Orders.DeliveryLng.HrefValue = ""

			' ServiceCharge
			Orders.ServiceCharge.HrefValue = ""

			' PaymentSurcharge
			Orders.PaymentSurcharge.HrefValue = ""

			' FromIP
			Orders.FromIP.HrefValue = ""

			' SentEmail
			Orders.SentEmail.HrefValue = ""

			' Tax_Rate
			Orders.Tax_Rate.HrefValue = ""

			' Tax_Amount
			Orders.Tax_Amount.HrefValue = ""

			' Tip_Rate
			Orders.Tip_Rate.HrefValue = ""

			' Tip_Amount
			Orders.Tip_Amount.HrefValue = ""

			' Card_Debit
			Orders.Card_Debit.HrefValue = ""

			' Card_Credit
			Orders.Card_Credit.HrefValue = ""

			' deliverydelay
			Orders.deliverydelay.HrefValue = ""

			' collectiondelay
			Orders.collectiondelay.HrefValue = ""

			' lng_report
			Orders.lng_report.HrefValue = ""

			' lat_report
			Orders.lat_report.HrefValue = ""

			' Payment_status
			Orders.Payment_status.HrefValue = ""
		End If
		If Orders.RowType = EW_ROWTYPE_ADD Or Orders.RowType = EW_ROWTYPE_EDIT Or Orders.RowType = EW_ROWTYPE_SEARCH Then ' Add / Edit / Search row
			Call Orders.SetupFieldTitles()
		End If

		' Call Row Rendered event
		If Orders.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call Orders.Row_Rendered()
		End If
	End Sub

	' -----------------------------------------------------------------
	' Validate form
	'
	Function ValidateForm()

		' Initialize
		gsFormError = ""

		' Check if validation required
		If Not EW_SERVER_VALIDATE Then
			ValidateForm = (gsFormError = "")
			Exit Function
		End If
		If Not ew_CheckNumber(Orders.SubTotal.FormValue) Then
			Call ew_AddMessage(gsFormError, Orders.SubTotal.FldErrMsg)
		End If
		If Not ew_CheckNumber(Orders.ShippingFee.FormValue) Then
			Call ew_AddMessage(gsFormError, Orders.ShippingFee.FldErrMsg)
		End If
		If Not ew_CheckNumber(Orders.OrderTotal.FormValue) Then
			Call ew_AddMessage(gsFormError, Orders.OrderTotal.FldErrMsg)
		End If
		If Not ew_CheckInteger(Orders.IdBusinessDetail.FormValue) Then
			Call ew_AddMessage(gsFormError, Orders.IdBusinessDetail.FldErrMsg)
		End If
		If Not ew_CheckInteger(Orders.cancelled.FormValue) Then
			Call ew_AddMessage(gsFormError, Orders.cancelled.FldErrMsg)
		End If
		If Not ew_CheckInteger(Orders.acknowledged.FormValue) Then
			Call ew_AddMessage(gsFormError, Orders.acknowledged.FldErrMsg)
		End If
		If Not ew_CheckInteger(Orders.outfordelivery.FormValue) Then
			Call ew_AddMessage(gsFormError, Orders.outfordelivery.FldErrMsg)
		End If
		If Not ew_CheckInteger(Orders.vouchercodediscount.FormValue) Then
			Call ew_AddMessage(gsFormError, Orders.vouchercodediscount.FldErrMsg)
		End If
		If Not ew_CheckInteger(Orders.printed.FormValue) Then
			Call ew_AddMessage(gsFormError, Orders.printed.FldErrMsg)
		End If
		If Not ew_CheckNumber(Orders.ServiceCharge.FormValue) Then
			Call ew_AddMessage(gsFormError, Orders.ServiceCharge.FldErrMsg)
		End If
		If Not ew_CheckNumber(Orders.PaymentSurcharge.FormValue) Then
			Call ew_AddMessage(gsFormError, Orders.PaymentSurcharge.FldErrMsg)
		End If
		If Not ew_CheckInteger(Orders.Tax_Rate.FormValue) Then
			Call ew_AddMessage(gsFormError, Orders.Tax_Rate.FldErrMsg)
		End If
		If Not ew_CheckNumber(Orders.Tax_Amount.FormValue) Then
			Call ew_AddMessage(gsFormError, Orders.Tax_Amount.FldErrMsg)
		End If
		If Not ew_CheckNumber(Orders.Tip_Amount.FormValue) Then
			Call ew_AddMessage(gsFormError, Orders.Tip_Amount.FldErrMsg)
		End If
		If Not ew_CheckInteger(Orders.Card_Debit.FormValue) Then
			Call ew_AddMessage(gsFormError, Orders.Card_Debit.FldErrMsg)
		End If
		If Not ew_CheckInteger(Orders.Card_Credit.FormValue) Then
			Call ew_AddMessage(gsFormError, Orders.Card_Credit.FldErrMsg)
		End If
		If Not ew_CheckInteger(Orders.deliverydelay.FormValue) Then
			Call ew_AddMessage(gsFormError, Orders.deliverydelay.FldErrMsg)
		End If
		If Not ew_CheckInteger(Orders.collectiondelay.FormValue) Then
			Call ew_AddMessage(gsFormError, Orders.collectiondelay.FldErrMsg)
		End If

		' Return validate result
		ValidateForm = (gsFormError = "")

		' Call Form Custom Validate event
		Dim sFormCustomError
		sFormCustomError = ""
		ValidateForm = ValidateForm And Form_CustomValidate(sFormCustomError)
		If sFormCustomError <> "" Then
			Call ew_AddMessage(gsFormError, sFormCustomError)
		End If
	End Function

	' -----------------------------------------------------------------
	' Update record based on key values
	'
	Function EditRow()
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		Dim Rs, sSql, sFilter
		Dim RsChk, sSqlChk, sFilterChk
		Dim bUpdateRow
		Dim RsOld, RsNew
		Dim sIdxErrMsg

		' Clear any previous errors
		Err.Clear
		sFilter = Orders.KeyFilter
		Orders.CurrentFilter  = sFilter
		sSql = Orders.SQL
		Set Rs = Server.CreateObject("ADODB.Recordset")
		Rs.CursorLocation = EW_CURSORLOCATION
		Rs.Open sSql, Conn, 1, EW_RECORDSET_LOCKTYPE
		If Err.Number <> 0 Then
			Message = Err.Description
			Rs.Close
			Set Rs = Nothing
			EditRow = False
			Exit Function
		End If

		' Clone old recordset object
		Set RsOld = ew_CloneRs(Rs)
		Call LoadDbValues(RsOld)
		If Rs.Eof Then
			EditRow = False ' Update Failed
		Else

			' Field CreationDate
			Call Orders.CreationDate.SetDbValue(Rs, Orders.CreationDate.CurrentValue, Null, Orders.CreationDate.ReadOnly)

			' Field OrderDate
			Call Orders.OrderDate.SetDbValue(Rs, Orders.OrderDate.CurrentValue, Null, Orders.OrderDate.ReadOnly)

			' Field DeliveryType
			Call Orders.DeliveryType.SetDbValue(Rs, Orders.DeliveryType.CurrentValue, Null, Orders.DeliveryType.ReadOnly)

			' Field DeliveryTime
			Call Orders.DeliveryTime.SetDbValue(Rs, Orders.DeliveryTime.CurrentValue, Null, Orders.DeliveryTime.ReadOnly)

			' Field PaymentType
			Call Orders.PaymentType.SetDbValue(Rs, Orders.PaymentType.CurrentValue, Null, Orders.PaymentType.ReadOnly)

			' Field SubTotal
			Call Orders.SubTotal.SetDbValue(Rs, Orders.SubTotal.CurrentValue, Null, Orders.SubTotal.ReadOnly)

			' Field ShippingFee
			Call Orders.ShippingFee.SetDbValue(Rs, Orders.ShippingFee.CurrentValue, Null, Orders.ShippingFee.ReadOnly)

			' Field OrderTotal
			Call Orders.OrderTotal.SetDbValue(Rs, Orders.OrderTotal.CurrentValue, Null, Orders.OrderTotal.ReadOnly)

			' Field IdBusinessDetail
			Call Orders.IdBusinessDetail.SetDbValue(Rs, Orders.IdBusinessDetail.CurrentValue, Null, Orders.IdBusinessDetail.ReadOnly)

			' Field SessionId
			Call Orders.SessionId.SetDbValue(Rs, Orders.SessionId.CurrentValue, Null, Orders.SessionId.ReadOnly)

			' Field FirstName
			Call Orders.FirstName.SetDbValue(Rs, Orders.FirstName.CurrentValue, Null, Orders.FirstName.ReadOnly)

			' Field LastName
			Call Orders.LastName.SetDbValue(Rs, Orders.LastName.CurrentValue, Null, Orders.LastName.ReadOnly)

			' Field Email
			Call Orders.zEmail.SetDbValue(Rs, Orders.zEmail.CurrentValue, Null, Orders.zEmail.ReadOnly)

			' Field Phone
			Call Orders.Phone.SetDbValue(Rs, Orders.Phone.CurrentValue, Null, Orders.Phone.ReadOnly)

			' Field Address
			Call Orders.Address.SetDbValue(Rs, Orders.Address.CurrentValue, Null, Orders.Address.ReadOnly)

			' Field PostalCode
			Call Orders.PostalCode.SetDbValue(Rs, Orders.PostalCode.CurrentValue, Null, Orders.PostalCode.ReadOnly)

			' Field Notes
			Call Orders.Notes.SetDbValue(Rs, Orders.Notes.CurrentValue, Null, Orders.Notes.ReadOnly)

			' Field ttest
			Call Orders.ttest.SetDbValue(Rs, Orders.ttest.CurrentValue, Null, Orders.ttest.ReadOnly)

			' Field cancelleddate
			Call Orders.cancelleddate.SetDbValue(Rs, Orders.cancelleddate.CurrentValue, Null, Orders.cancelleddate.ReadOnly)

			' Field cancelledby
			Call Orders.cancelledby.SetDbValue(Rs, Orders.cancelledby.CurrentValue, Null, Orders.cancelledby.ReadOnly)

			' Field cancelledreason
			Call Orders.cancelledreason.SetDbValue(Rs, Orders.cancelledreason.CurrentValue, Null, Orders.cancelledreason.ReadOnly)

			' Field acknowledgeddate
			Call Orders.acknowledgeddate.SetDbValue(Rs, Orders.acknowledgeddate.CurrentValue, Null, Orders.acknowledgeddate.ReadOnly)

			' Field delivereddate
			Call Orders.delivereddate.SetDbValue(Rs, Orders.delivereddate.CurrentValue, Null, Orders.delivereddate.ReadOnly)

			' Field cancelled
			Call Orders.cancelled.SetDbValue(Rs, Orders.cancelled.CurrentValue, Null, Orders.cancelled.ReadOnly)

			' Field acknowledged
			Call Orders.acknowledged.SetDbValue(Rs, Orders.acknowledged.CurrentValue, Null, Orders.acknowledged.ReadOnly)

			' Field outfordelivery
			Call Orders.outfordelivery.SetDbValue(Rs, Orders.outfordelivery.CurrentValue, Null, Orders.outfordelivery.ReadOnly)

			' Field vouchercodediscount
			Call Orders.vouchercodediscount.SetDbValue(Rs, Orders.vouchercodediscount.CurrentValue, Null, Orders.vouchercodediscount.ReadOnly)

			' Field vouchercode
			Call Orders.vouchercode.SetDbValue(Rs, Orders.vouchercode.CurrentValue, Null, Orders.vouchercode.ReadOnly)

			' Field printed
			Call Orders.printed.SetDbValue(Rs, Orders.printed.CurrentValue, Null, Orders.printed.ReadOnly)

			' Field deliverydistance
			Call Orders.deliverydistance.SetDbValue(Rs, Orders.deliverydistance.CurrentValue, Null, Orders.deliverydistance.ReadOnly)

			' Field asaporder
			Call Orders.asaporder.SetDbValue(Rs, Orders.asaporder.CurrentValue, Null, Orders.asaporder.ReadOnly)

			' Field DeliveryLat
			Call Orders.DeliveryLat.SetDbValue(Rs, Orders.DeliveryLat.CurrentValue, Null, Orders.DeliveryLat.ReadOnly)

			' Field DeliveryLng
			Call Orders.DeliveryLng.SetDbValue(Rs, Orders.DeliveryLng.CurrentValue, Null, Orders.DeliveryLng.ReadOnly)

			' Field ServiceCharge
			Call Orders.ServiceCharge.SetDbValue(Rs, Orders.ServiceCharge.CurrentValue, Null, Orders.ServiceCharge.ReadOnly)

			' Field PaymentSurcharge
			Call Orders.PaymentSurcharge.SetDbValue(Rs, Orders.PaymentSurcharge.CurrentValue, Null, Orders.PaymentSurcharge.ReadOnly)

			' Field FromIP
			Call Orders.FromIP.SetDbValue(Rs, Orders.FromIP.CurrentValue, Null, Orders.FromIP.ReadOnly)

			' Field SentEmail
			Call Orders.SentEmail.SetDbValue(Rs, Orders.SentEmail.CurrentValue, Null, Orders.SentEmail.ReadOnly)

			' Field Tax_Rate
			Call Orders.Tax_Rate.SetDbValue(Rs, Orders.Tax_Rate.CurrentValue, Null, Orders.Tax_Rate.ReadOnly)

			' Field Tax_Amount
			Call Orders.Tax_Amount.SetDbValue(Rs, Orders.Tax_Amount.CurrentValue, Null, Orders.Tax_Amount.ReadOnly)

			' Field Tip_Rate
			Call Orders.Tip_Rate.SetDbValue(Rs, Orders.Tip_Rate.CurrentValue, Null, Orders.Tip_Rate.ReadOnly)

			' Field Tip_Amount
			Call Orders.Tip_Amount.SetDbValue(Rs, Orders.Tip_Amount.CurrentValue, Null, Orders.Tip_Amount.ReadOnly)

			' Field Card_Debit
			Call Orders.Card_Debit.SetDbValue(Rs, Orders.Card_Debit.CurrentValue, Null, Orders.Card_Debit.ReadOnly)

			' Field Card_Credit
			Call Orders.Card_Credit.SetDbValue(Rs, Orders.Card_Credit.CurrentValue, Null, Orders.Card_Credit.ReadOnly)

			' Field deliverydelay
			Call Orders.deliverydelay.SetDbValue(Rs, Orders.deliverydelay.CurrentValue, Null, Orders.deliverydelay.ReadOnly)

			' Field collectiondelay
			Call Orders.collectiondelay.SetDbValue(Rs, Orders.collectiondelay.CurrentValue, Null, Orders.collectiondelay.ReadOnly)

			' Field lng_report
			Call Orders.lng_report.SetDbValue(Rs, Orders.lng_report.CurrentValue, Null, Orders.lng_report.ReadOnly)

			' Field lat_report
			Call Orders.lat_report.SetDbValue(Rs, Orders.lat_report.CurrentValue, Null, Orders.lat_report.ReadOnly)

			' Field Payment_status
			Call Orders.Payment_status.SetDbValue(Rs, Orders.Payment_status.CurrentValue, Null, Orders.Payment_status.ReadOnly)

			' Check recordset update error
			If Err.Number <> 0 Then
				FailureMessage = Err.Description
				Rs.Close
				Set Rs = Nothing
				EditRow = False
				Exit Function
			End If

			' Call Row Updating event
			bUpdateRow = Orders.Row_Updating(RsOld, Rs)
			If bUpdateRow Then

				' Clone new recordset object
				Set RsNew = ew_CloneRs(Rs)
				EditRow = True
				If EditRow Then
					Rs.Update
				End If
				If Err.Number <> 0 Or Not EditRow Then
					If Err.Description <> "" Then FailureMessage = Err.Description
					EditRow = False
				Else
					EditRow = True
				End If
				If EditRow Then
				End If
			Else
				Rs.CancelUpdate

				' Set up error message
				If SuccessMessage <> "" Or FailureMessage <> "" Then

					' Use the message, do nothing
				ElseIf Orders.CancelMessage <> "" Then
					FailureMessage = Orders.CancelMessage
					Orders.CancelMessage = ""
				Else
					FailureMessage = Language.Phrase("UpdateCancelled")
				End If
				EditRow = False
			End If
		End If

		' Call Row Updated event
		If EditRow Then
			Call Orders.Row_Updated(RsOld, RsNew)
		End If
		Rs.Close
		Set Rs = Nothing
		If IsObject(RsOld) Then
			RsOld.Close
			Set RsOld = Nothing
		End If
		If IsObject(RsNew) Then
			RsNew.Close
			Set RsNew = Nothing
		End If
	End Function

	' Set up Breadcrumb
	Sub SetupBreadcrumb()
		Dim PageId, url
		Set Breadcrumb = New cBreadcrumb
		url = Mid(ew_CurrentUrl, InStrRev(ew_CurrentUrl, "/")+1)
		Call Breadcrumb.Add("list", Orders.TableVar, "Orderslist.asp", "", Orders.TableVar, True)
		PageId = "edit"
		Call Breadcrumb.Add("edit", PageId, url, "", "", False)
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
End Class
%>
