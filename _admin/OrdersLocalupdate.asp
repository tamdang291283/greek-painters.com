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
Dim OrdersLocal_update
Set OrdersLocal_update = New cOrdersLocal_update
Set Page = OrdersLocal_update

' Page init processing
OrdersLocal_update.Page_Init()

' Page main processing
OrdersLocal_update.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
OrdersLocal_update.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var OrdersLocal_update = new ew_Page("OrdersLocal_update");
OrdersLocal_update.PageID = "update"; // Page ID
var EW_PAGE_ID = OrdersLocal_update.PageID; // For backward compatibility
// Form object
var fOrdersLocalupdate = new ew_Form("fOrdersLocalupdate");
// Validate form
fOrdersLocalupdate.Validate = function() {
	if (!this.ValidateRequired)
		return true; // Ignore validation
	var $ = jQuery, fobj = this.GetForm(), $fobj = $(fobj);
	this.PostAutoSuggest();
	if ($fobj.find("#a_confirm").val() == "F")
		return true;
	if (!ew_UpdateSelected(fobj)) {
		alert(ewLanguage.Phrase("NoFieldSelected"));
		return false;
	}
	var elm, felm, uelm, addcnt = 0;
	var $k = $fobj.find("#" + this.FormKeyCountName); // Get key_count
	var rowcnt = ($k[0]) ? parseInt($k.val(), 10) : 1;
	var startcnt = (rowcnt == 0) ? 0 : 1; // Check rowcnt == 0 => Inline-Add
	var gridinsert = $fobj.find("#a_list").val() == "gridinsert";
	for (var i = startcnt; i <= rowcnt; i++) {
		var infix = ($k[0]) ? String(i) : "";
		$fobj.data("rowindex", infix);
			elm = this.GetElements("x" + infix + "_CreationDate");
			uelm = this.GetElements("u" + infix + "_CreationDate");
			if (uelm && uelm.checked && elm && !ew_CheckDate(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(OrdersLocal.CreationDate.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_OrderDate");
			uelm = this.GetElements("u" + infix + "_OrderDate");
			if (uelm && uelm.checked && elm && !ew_CheckDate(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(OrdersLocal.OrderDate.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_DeliveryTime");
			uelm = this.GetElements("u" + infix + "_DeliveryTime");
			if (uelm && uelm.checked && elm && !ew_CheckDate(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(OrdersLocal.DeliveryTime.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_SubTotal");
			uelm = this.GetElements("u" + infix + "_SubTotal");
			if (uelm && uelm.checked && elm && !ew_CheckNumber(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(OrdersLocal.SubTotal.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_ShippingFee");
			uelm = this.GetElements("u" + infix + "_ShippingFee");
			if (uelm && uelm.checked && elm && !ew_CheckNumber(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(OrdersLocal.ShippingFee.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_OrderTotal");
			uelm = this.GetElements("u" + infix + "_OrderTotal");
			if (uelm && uelm.checked && elm && !ew_CheckNumber(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(OrdersLocal.OrderTotal.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_IdBusinessDetail");
			uelm = this.GetElements("u" + infix + "_IdBusinessDetail");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(OrdersLocal.IdBusinessDetail.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_cancelleddate");
			uelm = this.GetElements("u" + infix + "_cancelleddate");
			if (uelm && uelm.checked && elm && !ew_CheckDate(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(OrdersLocal.cancelleddate.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_acknowledgeddate");
			uelm = this.GetElements("u" + infix + "_acknowledgeddate");
			if (uelm && uelm.checked && elm && !ew_CheckDate(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(OrdersLocal.acknowledgeddate.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_cancelled");
			uelm = this.GetElements("u" + infix + "_cancelled");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(OrdersLocal.cancelled.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_acknowledged");
			uelm = this.GetElements("u" + infix + "_acknowledged");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(OrdersLocal.acknowledged.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_outfordelivery");
			uelm = this.GetElements("u" + infix + "_outfordelivery");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(OrdersLocal.outfordelivery.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_vouchercodediscount");
			uelm = this.GetElements("u" + infix + "_vouchercodediscount");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(OrdersLocal.vouchercodediscount.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_printed");
			uelm = this.GetElements("u" + infix + "_printed");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(OrdersLocal.printed.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_ServiceCharge");
			uelm = this.GetElements("u" + infix + "_ServiceCharge");
			if (uelm && uelm.checked && elm && !ew_CheckNumber(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(OrdersLocal.ServiceCharge.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_PaymentSurcharge");
			uelm = this.GetElements("u" + infix + "_PaymentSurcharge");
			if (uelm && uelm.checked && elm && !ew_CheckNumber(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(OrdersLocal.PaymentSurcharge.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_Tax_Rate");
			uelm = this.GetElements("u" + infix + "_Tax_Rate");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(OrdersLocal.Tax_Rate.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_Tax_Amount");
			uelm = this.GetElements("u" + infix + "_Tax_Amount");
			if (uelm && uelm.checked && elm && !ew_CheckNumber(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(OrdersLocal.Tax_Amount.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_Tip_Amount");
			uelm = this.GetElements("u" + infix + "_Tip_Amount");
			if (uelm && uelm.checked && elm && !ew_CheckNumber(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(OrdersLocal.Tip_Amount.FldErrMsg) %>");
			// Set up row object
			ew_ElementsToRow(fobj);
			// Fire Form_CustomValidate event
			if (!this.Form_CustomValidate(fobj))
				return false;
	}
	return true;
}
// Form_CustomValidate event
fOrdersLocalupdate.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fOrdersLocalupdate.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fOrdersLocalupdate.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<div class="ewToolbar">
<% If OrdersLocal.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If OrdersLocal.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% OrdersLocal_update.ShowPageHeader() %>
<% OrdersLocal_update.ShowMessage %>
<form name="fOrdersLocalupdate" id="fOrdersLocalupdate" class="form-horizontal ewForm ewUpdateForm" action="<%= ew_CurrentPage %>" method="post">
<% If OrdersLocal_update.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= OrdersLocal_update.Token %>">
<% End If %>
<input type="hidden" name="t" value="OrdersLocal">
<input type="hidden" name="a_update" id="a_update" value="U">
<% For i = 0 to UBound(OrdersLocal_update.RecKeys) %>
<input type="hidden" name="key_m" id="key_m" value="<%= ew_HtmlEncode(ew_GetKeyValue(OrdersLocal_update.RecKeys(i))) %>">
<% Next %>
<div id="tbl_OrdersLocalupdate">
	<div class="form-group">
		<label class="col-sm-2"><input type="checkbox" name="u" id="u" onclick="ew_SelectAll(this);"> <%= Language.Phrase("UpdateSelectAll") %></label>
	</div>
<% If OrdersLocal.CreationDate.Visible Then ' CreationDate %>
	<div id="r_CreationDate" class="form-group">
		<label for="x_CreationDate" class="col-sm-2 control-label">
<input type="checkbox" name="u_CreationDate" id="u_CreationDate" value="1"<% If OrdersLocal.CreationDate.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrdersLocal.CreationDate.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrdersLocal.CreationDate.CellAttributes %>>
<span id="el_OrdersLocal_CreationDate">
<input type="text" data-field="x_CreationDate" name="x_CreationDate" id="x_CreationDate" placeholder="<%= OrdersLocal.CreationDate.PlaceHolder %>" value="<%= OrdersLocal.CreationDate.EditValue %>"<%= OrdersLocal.CreationDate.EditAttributes %>>
</span>
<%= OrdersLocal.CreationDate.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrdersLocal.OrderDate.Visible Then ' OrderDate %>
	<div id="r_OrderDate" class="form-group">
		<label for="x_OrderDate" class="col-sm-2 control-label">
<input type="checkbox" name="u_OrderDate" id="u_OrderDate" value="1"<% If OrdersLocal.OrderDate.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrdersLocal.OrderDate.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrdersLocal.OrderDate.CellAttributes %>>
<span id="el_OrdersLocal_OrderDate">
<input type="text" data-field="x_OrderDate" name="x_OrderDate" id="x_OrderDate" placeholder="<%= OrdersLocal.OrderDate.PlaceHolder %>" value="<%= OrdersLocal.OrderDate.EditValue %>"<%= OrdersLocal.OrderDate.EditAttributes %>>
</span>
<%= OrdersLocal.OrderDate.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrdersLocal.DeliveryType.Visible Then ' DeliveryType %>
	<div id="r_DeliveryType" class="form-group">
		<label for="x_DeliveryType" class="col-sm-2 control-label">
<input type="checkbox" name="u_DeliveryType" id="u_DeliveryType" value="1"<% If OrdersLocal.DeliveryType.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrdersLocal.DeliveryType.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrdersLocal.DeliveryType.CellAttributes %>>
<span id="el_OrdersLocal_DeliveryType">
<input type="text" data-field="x_DeliveryType" name="x_DeliveryType" id="x_DeliveryType" size="30" maxlength="255" placeholder="<%= OrdersLocal.DeliveryType.PlaceHolder %>" value="<%= OrdersLocal.DeliveryType.EditValue %>"<%= OrdersLocal.DeliveryType.EditAttributes %>>
</span>
<%= OrdersLocal.DeliveryType.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrdersLocal.DeliveryTime.Visible Then ' DeliveryTime %>
	<div id="r_DeliveryTime" class="form-group">
		<label for="x_DeliveryTime" class="col-sm-2 control-label">
<input type="checkbox" name="u_DeliveryTime" id="u_DeliveryTime" value="1"<% If OrdersLocal.DeliveryTime.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrdersLocal.DeliveryTime.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrdersLocal.DeliveryTime.CellAttributes %>>
<span id="el_OrdersLocal_DeliveryTime">
<input type="text" data-field="x_DeliveryTime" name="x_DeliveryTime" id="x_DeliveryTime" placeholder="<%= OrdersLocal.DeliveryTime.PlaceHolder %>" value="<%= OrdersLocal.DeliveryTime.EditValue %>"<%= OrdersLocal.DeliveryTime.EditAttributes %>>
</span>
<%= OrdersLocal.DeliveryTime.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrdersLocal.PaymentType.Visible Then ' PaymentType %>
	<div id="r_PaymentType" class="form-group">
		<label for="x_PaymentType" class="col-sm-2 control-label">
<input type="checkbox" name="u_PaymentType" id="u_PaymentType" value="1"<% If OrdersLocal.PaymentType.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrdersLocal.PaymentType.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrdersLocal.PaymentType.CellAttributes %>>
<span id="el_OrdersLocal_PaymentType">
<input type="text" data-field="x_PaymentType" name="x_PaymentType" id="x_PaymentType" size="30" maxlength="255" placeholder="<%= OrdersLocal.PaymentType.PlaceHolder %>" value="<%= OrdersLocal.PaymentType.EditValue %>"<%= OrdersLocal.PaymentType.EditAttributes %>>
</span>
<%= OrdersLocal.PaymentType.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrdersLocal.SubTotal.Visible Then ' SubTotal %>
	<div id="r_SubTotal" class="form-group">
		<label for="x_SubTotal" class="col-sm-2 control-label">
<input type="checkbox" name="u_SubTotal" id="u_SubTotal" value="1"<% If OrdersLocal.SubTotal.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrdersLocal.SubTotal.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrdersLocal.SubTotal.CellAttributes %>>
<span id="el_OrdersLocal_SubTotal">
<input type="text" data-field="x_SubTotal" name="x_SubTotal" id="x_SubTotal" size="30" placeholder="<%= OrdersLocal.SubTotal.PlaceHolder %>" value="<%= OrdersLocal.SubTotal.EditValue %>"<%= OrdersLocal.SubTotal.EditAttributes %>>
</span>
<%= OrdersLocal.SubTotal.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrdersLocal.ShippingFee.Visible Then ' ShippingFee %>
	<div id="r_ShippingFee" class="form-group">
		<label for="x_ShippingFee" class="col-sm-2 control-label">
<input type="checkbox" name="u_ShippingFee" id="u_ShippingFee" value="1"<% If OrdersLocal.ShippingFee.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrdersLocal.ShippingFee.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrdersLocal.ShippingFee.CellAttributes %>>
<span id="el_OrdersLocal_ShippingFee">
<input type="text" data-field="x_ShippingFee" name="x_ShippingFee" id="x_ShippingFee" size="30" placeholder="<%= OrdersLocal.ShippingFee.PlaceHolder %>" value="<%= OrdersLocal.ShippingFee.EditValue %>"<%= OrdersLocal.ShippingFee.EditAttributes %>>
</span>
<%= OrdersLocal.ShippingFee.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrdersLocal.OrderTotal.Visible Then ' OrderTotal %>
	<div id="r_OrderTotal" class="form-group">
		<label for="x_OrderTotal" class="col-sm-2 control-label">
<input type="checkbox" name="u_OrderTotal" id="u_OrderTotal" value="1"<% If OrdersLocal.OrderTotal.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrdersLocal.OrderTotal.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrdersLocal.OrderTotal.CellAttributes %>>
<span id="el_OrdersLocal_OrderTotal">
<input type="text" data-field="x_OrderTotal" name="x_OrderTotal" id="x_OrderTotal" size="30" placeholder="<%= OrdersLocal.OrderTotal.PlaceHolder %>" value="<%= OrdersLocal.OrderTotal.EditValue %>"<%= OrdersLocal.OrderTotal.EditAttributes %>>
</span>
<%= OrdersLocal.OrderTotal.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrdersLocal.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
	<div id="r_IdBusinessDetail" class="form-group">
		<label for="x_IdBusinessDetail" class="col-sm-2 control-label">
<input type="checkbox" name="u_IdBusinessDetail" id="u_IdBusinessDetail" value="1"<% If OrdersLocal.IdBusinessDetail.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrdersLocal.IdBusinessDetail.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrdersLocal.IdBusinessDetail.CellAttributes %>>
<span id="el_OrdersLocal_IdBusinessDetail">
<input type="text" data-field="x_IdBusinessDetail" name="x_IdBusinessDetail" id="x_IdBusinessDetail" size="30" placeholder="<%= OrdersLocal.IdBusinessDetail.PlaceHolder %>" value="<%= OrdersLocal.IdBusinessDetail.EditValue %>"<%= OrdersLocal.IdBusinessDetail.EditAttributes %>>
</span>
<%= OrdersLocal.IdBusinessDetail.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrdersLocal.SessionId.Visible Then ' SessionId %>
	<div id="r_SessionId" class="form-group">
		<label for="x_SessionId" class="col-sm-2 control-label">
<input type="checkbox" name="u_SessionId" id="u_SessionId" value="1"<% If OrdersLocal.SessionId.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrdersLocal.SessionId.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrdersLocal.SessionId.CellAttributes %>>
<span id="el_OrdersLocal_SessionId">
<input type="text" data-field="x_SessionId" name="x_SessionId" id="x_SessionId" size="30" maxlength="255" placeholder="<%= OrdersLocal.SessionId.PlaceHolder %>" value="<%= OrdersLocal.SessionId.EditValue %>"<%= OrdersLocal.SessionId.EditAttributes %>>
</span>
<%= OrdersLocal.SessionId.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrdersLocal.FirstName.Visible Then ' FirstName %>
	<div id="r_FirstName" class="form-group">
		<label for="x_FirstName" class="col-sm-2 control-label">
<input type="checkbox" name="u_FirstName" id="u_FirstName" value="1"<% If OrdersLocal.FirstName.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrdersLocal.FirstName.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrdersLocal.FirstName.CellAttributes %>>
<span id="el_OrdersLocal_FirstName">
<input type="text" data-field="x_FirstName" name="x_FirstName" id="x_FirstName" size="30" maxlength="255" placeholder="<%= OrdersLocal.FirstName.PlaceHolder %>" value="<%= OrdersLocal.FirstName.EditValue %>"<%= OrdersLocal.FirstName.EditAttributes %>>
</span>
<%= OrdersLocal.FirstName.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrdersLocal.LastName.Visible Then ' LastName %>
	<div id="r_LastName" class="form-group">
		<label for="x_LastName" class="col-sm-2 control-label">
<input type="checkbox" name="u_LastName" id="u_LastName" value="1"<% If OrdersLocal.LastName.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrdersLocal.LastName.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrdersLocal.LastName.CellAttributes %>>
<span id="el_OrdersLocal_LastName">
<input type="text" data-field="x_LastName" name="x_LastName" id="x_LastName" size="30" maxlength="255" placeholder="<%= OrdersLocal.LastName.PlaceHolder %>" value="<%= OrdersLocal.LastName.EditValue %>"<%= OrdersLocal.LastName.EditAttributes %>>
</span>
<%= OrdersLocal.LastName.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrdersLocal.zEmail.Visible Then ' Email %>
	<div id="r_zEmail" class="form-group">
		<label for="x_zEmail" class="col-sm-2 control-label">
<input type="checkbox" name="u_zEmail" id="u_zEmail" value="1"<% If OrdersLocal.zEmail.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrdersLocal.zEmail.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrdersLocal.zEmail.CellAttributes %>>
<span id="el_OrdersLocal_zEmail">
<input type="text" data-field="x_zEmail" name="x_zEmail" id="x_zEmail" size="30" maxlength="255" placeholder="<%= OrdersLocal.zEmail.PlaceHolder %>" value="<%= OrdersLocal.zEmail.EditValue %>"<%= OrdersLocal.zEmail.EditAttributes %>>
</span>
<%= OrdersLocal.zEmail.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrdersLocal.Phone.Visible Then ' Phone %>
	<div id="r_Phone" class="form-group">
		<label for="x_Phone" class="col-sm-2 control-label">
<input type="checkbox" name="u_Phone" id="u_Phone" value="1"<% If OrdersLocal.Phone.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrdersLocal.Phone.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrdersLocal.Phone.CellAttributes %>>
<span id="el_OrdersLocal_Phone">
<input type="text" data-field="x_Phone" name="x_Phone" id="x_Phone" size="30" maxlength="255" placeholder="<%= OrdersLocal.Phone.PlaceHolder %>" value="<%= OrdersLocal.Phone.EditValue %>"<%= OrdersLocal.Phone.EditAttributes %>>
</span>
<%= OrdersLocal.Phone.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrdersLocal.Address.Visible Then ' Address %>
	<div id="r_Address" class="form-group">
		<label for="x_Address" class="col-sm-2 control-label">
<input type="checkbox" name="u_Address" id="u_Address" value="1"<% If OrdersLocal.Address.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrdersLocal.Address.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrdersLocal.Address.CellAttributes %>>
<span id="el_OrdersLocal_Address">
<input type="text" data-field="x_Address" name="x_Address" id="x_Address" size="30" maxlength="255" placeholder="<%= OrdersLocal.Address.PlaceHolder %>" value="<%= OrdersLocal.Address.EditValue %>"<%= OrdersLocal.Address.EditAttributes %>>
</span>
<%= OrdersLocal.Address.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrdersLocal.PostalCode.Visible Then ' PostalCode %>
	<div id="r_PostalCode" class="form-group">
		<label for="x_PostalCode" class="col-sm-2 control-label">
<input type="checkbox" name="u_PostalCode" id="u_PostalCode" value="1"<% If OrdersLocal.PostalCode.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrdersLocal.PostalCode.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrdersLocal.PostalCode.CellAttributes %>>
<span id="el_OrdersLocal_PostalCode">
<input type="text" data-field="x_PostalCode" name="x_PostalCode" id="x_PostalCode" size="30" maxlength="255" placeholder="<%= OrdersLocal.PostalCode.PlaceHolder %>" value="<%= OrdersLocal.PostalCode.EditValue %>"<%= OrdersLocal.PostalCode.EditAttributes %>>
</span>
<%= OrdersLocal.PostalCode.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrdersLocal.Notes.Visible Then ' Notes %>
	<div id="r_Notes" class="form-group">
		<label for="x_Notes" class="col-sm-2 control-label">
<input type="checkbox" name="u_Notes" id="u_Notes" value="1"<% If OrdersLocal.Notes.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrdersLocal.Notes.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrdersLocal.Notes.CellAttributes %>>
<span id="el_OrdersLocal_Notes">
<input type="text" data-field="x_Notes" name="x_Notes" id="x_Notes" size="30" maxlength="255" placeholder="<%= OrdersLocal.Notes.PlaceHolder %>" value="<%= OrdersLocal.Notes.EditValue %>"<%= OrdersLocal.Notes.EditAttributes %>>
</span>
<%= OrdersLocal.Notes.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrdersLocal.ttest.Visible Then ' ttest %>
	<div id="r_ttest" class="form-group">
		<label for="x_ttest" class="col-sm-2 control-label">
<input type="checkbox" name="u_ttest" id="u_ttest" value="1"<% If OrdersLocal.ttest.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrdersLocal.ttest.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrdersLocal.ttest.CellAttributes %>>
<span id="el_OrdersLocal_ttest">
<input type="text" data-field="x_ttest" name="x_ttest" id="x_ttest" size="30" maxlength="255" placeholder="<%= OrdersLocal.ttest.PlaceHolder %>" value="<%= OrdersLocal.ttest.EditValue %>"<%= OrdersLocal.ttest.EditAttributes %>>
</span>
<%= OrdersLocal.ttest.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrdersLocal.cancelleddate.Visible Then ' cancelleddate %>
	<div id="r_cancelleddate" class="form-group">
		<label for="x_cancelleddate" class="col-sm-2 control-label">
<input type="checkbox" name="u_cancelleddate" id="u_cancelleddate" value="1"<% If OrdersLocal.cancelleddate.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrdersLocal.cancelleddate.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrdersLocal.cancelleddate.CellAttributes %>>
<span id="el_OrdersLocal_cancelleddate">
<input type="text" data-field="x_cancelleddate" name="x_cancelleddate" id="x_cancelleddate" placeholder="<%= OrdersLocal.cancelleddate.PlaceHolder %>" value="<%= OrdersLocal.cancelleddate.EditValue %>"<%= OrdersLocal.cancelleddate.EditAttributes %>>
</span>
<%= OrdersLocal.cancelleddate.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrdersLocal.cancelledby.Visible Then ' cancelledby %>
	<div id="r_cancelledby" class="form-group">
		<label for="x_cancelledby" class="col-sm-2 control-label">
<input type="checkbox" name="u_cancelledby" id="u_cancelledby" value="1"<% If OrdersLocal.cancelledby.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrdersLocal.cancelledby.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrdersLocal.cancelledby.CellAttributes %>>
<span id="el_OrdersLocal_cancelledby">
<input type="text" data-field="x_cancelledby" name="x_cancelledby" id="x_cancelledby" size="30" maxlength="255" placeholder="<%= OrdersLocal.cancelledby.PlaceHolder %>" value="<%= OrdersLocal.cancelledby.EditValue %>"<%= OrdersLocal.cancelledby.EditAttributes %>>
</span>
<%= OrdersLocal.cancelledby.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrdersLocal.cancelledreason.Visible Then ' cancelledreason %>
	<div id="r_cancelledreason" class="form-group">
		<label for="x_cancelledreason" class="col-sm-2 control-label">
<input type="checkbox" name="u_cancelledreason" id="u_cancelledreason" value="1"<% If OrdersLocal.cancelledreason.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrdersLocal.cancelledreason.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrdersLocal.cancelledreason.CellAttributes %>>
<span id="el_OrdersLocal_cancelledreason">
<input type="text" data-field="x_cancelledreason" name="x_cancelledreason" id="x_cancelledreason" size="30" maxlength="255" placeholder="<%= OrdersLocal.cancelledreason.PlaceHolder %>" value="<%= OrdersLocal.cancelledreason.EditValue %>"<%= OrdersLocal.cancelledreason.EditAttributes %>>
</span>
<%= OrdersLocal.cancelledreason.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrdersLocal.acknowledgeddate.Visible Then ' acknowledgeddate %>
	<div id="r_acknowledgeddate" class="form-group">
		<label for="x_acknowledgeddate" class="col-sm-2 control-label">
<input type="checkbox" name="u_acknowledgeddate" id="u_acknowledgeddate" value="1"<% If OrdersLocal.acknowledgeddate.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrdersLocal.acknowledgeddate.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrdersLocal.acknowledgeddate.CellAttributes %>>
<span id="el_OrdersLocal_acknowledgeddate">
<input type="text" data-field="x_acknowledgeddate" name="x_acknowledgeddate" id="x_acknowledgeddate" placeholder="<%= OrdersLocal.acknowledgeddate.PlaceHolder %>" value="<%= OrdersLocal.acknowledgeddate.EditValue %>"<%= OrdersLocal.acknowledgeddate.EditAttributes %>>
</span>
<%= OrdersLocal.acknowledgeddate.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrdersLocal.delivereddate.Visible Then ' delivereddate %>
	<div id="r_delivereddate" class="form-group">
		<label for="x_delivereddate" class="col-sm-2 control-label">
<input type="checkbox" name="u_delivereddate" id="u_delivereddate" value="1"<% If OrdersLocal.delivereddate.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrdersLocal.delivereddate.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrdersLocal.delivereddate.CellAttributes %>>
<span id="el_OrdersLocal_delivereddate">
<input type="text" data-field="x_delivereddate" name="x_delivereddate" id="x_delivereddate" size="30" maxlength="255" placeholder="<%= OrdersLocal.delivereddate.PlaceHolder %>" value="<%= OrdersLocal.delivereddate.EditValue %>"<%= OrdersLocal.delivereddate.EditAttributes %>>
</span>
<%= OrdersLocal.delivereddate.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrdersLocal.cancelled.Visible Then ' cancelled %>
	<div id="r_cancelled" class="form-group">
		<label for="x_cancelled" class="col-sm-2 control-label">
<input type="checkbox" name="u_cancelled" id="u_cancelled" value="1"<% If OrdersLocal.cancelled.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrdersLocal.cancelled.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrdersLocal.cancelled.CellAttributes %>>
<span id="el_OrdersLocal_cancelled">
<input type="text" data-field="x_cancelled" name="x_cancelled" id="x_cancelled" size="30" placeholder="<%= OrdersLocal.cancelled.PlaceHolder %>" value="<%= OrdersLocal.cancelled.EditValue %>"<%= OrdersLocal.cancelled.EditAttributes %>>
</span>
<%= OrdersLocal.cancelled.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrdersLocal.acknowledged.Visible Then ' acknowledged %>
	<div id="r_acknowledged" class="form-group">
		<label for="x_acknowledged" class="col-sm-2 control-label">
<input type="checkbox" name="u_acknowledged" id="u_acknowledged" value="1"<% If OrdersLocal.acknowledged.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrdersLocal.acknowledged.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrdersLocal.acknowledged.CellAttributes %>>
<span id="el_OrdersLocal_acknowledged">
<input type="text" data-field="x_acknowledged" name="x_acknowledged" id="x_acknowledged" size="30" placeholder="<%= OrdersLocal.acknowledged.PlaceHolder %>" value="<%= OrdersLocal.acknowledged.EditValue %>"<%= OrdersLocal.acknowledged.EditAttributes %>>
</span>
<%= OrdersLocal.acknowledged.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrdersLocal.outfordelivery.Visible Then ' outfordelivery %>
	<div id="r_outfordelivery" class="form-group">
		<label for="x_outfordelivery" class="col-sm-2 control-label">
<input type="checkbox" name="u_outfordelivery" id="u_outfordelivery" value="1"<% If OrdersLocal.outfordelivery.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrdersLocal.outfordelivery.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrdersLocal.outfordelivery.CellAttributes %>>
<span id="el_OrdersLocal_outfordelivery">
<input type="text" data-field="x_outfordelivery" name="x_outfordelivery" id="x_outfordelivery" size="30" placeholder="<%= OrdersLocal.outfordelivery.PlaceHolder %>" value="<%= OrdersLocal.outfordelivery.EditValue %>"<%= OrdersLocal.outfordelivery.EditAttributes %>>
</span>
<%= OrdersLocal.outfordelivery.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrdersLocal.vouchercodediscount.Visible Then ' vouchercodediscount %>
	<div id="r_vouchercodediscount" class="form-group">
		<label for="x_vouchercodediscount" class="col-sm-2 control-label">
<input type="checkbox" name="u_vouchercodediscount" id="u_vouchercodediscount" value="1"<% If OrdersLocal.vouchercodediscount.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrdersLocal.vouchercodediscount.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrdersLocal.vouchercodediscount.CellAttributes %>>
<span id="el_OrdersLocal_vouchercodediscount">
<input type="text" data-field="x_vouchercodediscount" name="x_vouchercodediscount" id="x_vouchercodediscount" size="30" placeholder="<%= OrdersLocal.vouchercodediscount.PlaceHolder %>" value="<%= OrdersLocal.vouchercodediscount.EditValue %>"<%= OrdersLocal.vouchercodediscount.EditAttributes %>>
</span>
<%= OrdersLocal.vouchercodediscount.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrdersLocal.vouchercode.Visible Then ' vouchercode %>
	<div id="r_vouchercode" class="form-group">
		<label for="x_vouchercode" class="col-sm-2 control-label">
<input type="checkbox" name="u_vouchercode" id="u_vouchercode" value="1"<% If OrdersLocal.vouchercode.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrdersLocal.vouchercode.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrdersLocal.vouchercode.CellAttributes %>>
<span id="el_OrdersLocal_vouchercode">
<input type="text" data-field="x_vouchercode" name="x_vouchercode" id="x_vouchercode" size="30" maxlength="255" placeholder="<%= OrdersLocal.vouchercode.PlaceHolder %>" value="<%= OrdersLocal.vouchercode.EditValue %>"<%= OrdersLocal.vouchercode.EditAttributes %>>
</span>
<%= OrdersLocal.vouchercode.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrdersLocal.printed.Visible Then ' printed %>
	<div id="r_printed" class="form-group">
		<label for="x_printed" class="col-sm-2 control-label">
<input type="checkbox" name="u_printed" id="u_printed" value="1"<% If OrdersLocal.printed.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrdersLocal.printed.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrdersLocal.printed.CellAttributes %>>
<span id="el_OrdersLocal_printed">
<input type="text" data-field="x_printed" name="x_printed" id="x_printed" size="30" placeholder="<%= OrdersLocal.printed.PlaceHolder %>" value="<%= OrdersLocal.printed.EditValue %>"<%= OrdersLocal.printed.EditAttributes %>>
</span>
<%= OrdersLocal.printed.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrdersLocal.deliverydistance.Visible Then ' deliverydistance %>
	<div id="r_deliverydistance" class="form-group">
		<label for="x_deliverydistance" class="col-sm-2 control-label">
<input type="checkbox" name="u_deliverydistance" id="u_deliverydistance" value="1"<% If OrdersLocal.deliverydistance.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrdersLocal.deliverydistance.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrdersLocal.deliverydistance.CellAttributes %>>
<span id="el_OrdersLocal_deliverydistance">
<input type="text" data-field="x_deliverydistance" name="x_deliverydistance" id="x_deliverydistance" size="30" maxlength="255" placeholder="<%= OrdersLocal.deliverydistance.PlaceHolder %>" value="<%= OrdersLocal.deliverydistance.EditValue %>"<%= OrdersLocal.deliverydistance.EditAttributes %>>
</span>
<%= OrdersLocal.deliverydistance.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrdersLocal.asaporder.Visible Then ' asaporder %>
	<div id="r_asaporder" class="form-group">
		<label for="x_asaporder" class="col-sm-2 control-label">
<input type="checkbox" name="u_asaporder" id="u_asaporder" value="1"<% If OrdersLocal.asaporder.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrdersLocal.asaporder.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrdersLocal.asaporder.CellAttributes %>>
<span id="el_OrdersLocal_asaporder">
<input type="text" data-field="x_asaporder" name="x_asaporder" id="x_asaporder" size="30" maxlength="255" placeholder="<%= OrdersLocal.asaporder.PlaceHolder %>" value="<%= OrdersLocal.asaporder.EditValue %>"<%= OrdersLocal.asaporder.EditAttributes %>>
</span>
<%= OrdersLocal.asaporder.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrdersLocal.DeliveryLat.Visible Then ' DeliveryLat %>
	<div id="r_DeliveryLat" class="form-group">
		<label for="x_DeliveryLat" class="col-sm-2 control-label">
<input type="checkbox" name="u_DeliveryLat" id="u_DeliveryLat" value="1"<% If OrdersLocal.DeliveryLat.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrdersLocal.DeliveryLat.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrdersLocal.DeliveryLat.CellAttributes %>>
<span id="el_OrdersLocal_DeliveryLat">
<input type="text" data-field="x_DeliveryLat" name="x_DeliveryLat" id="x_DeliveryLat" size="30" maxlength="50" placeholder="<%= OrdersLocal.DeliveryLat.PlaceHolder %>" value="<%= OrdersLocal.DeliveryLat.EditValue %>"<%= OrdersLocal.DeliveryLat.EditAttributes %>>
</span>
<%= OrdersLocal.DeliveryLat.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrdersLocal.DeliveryLng.Visible Then ' DeliveryLng %>
	<div id="r_DeliveryLng" class="form-group">
		<label for="x_DeliveryLng" class="col-sm-2 control-label">
<input type="checkbox" name="u_DeliveryLng" id="u_DeliveryLng" value="1"<% If OrdersLocal.DeliveryLng.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrdersLocal.DeliveryLng.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrdersLocal.DeliveryLng.CellAttributes %>>
<span id="el_OrdersLocal_DeliveryLng">
<input type="text" data-field="x_DeliveryLng" name="x_DeliveryLng" id="x_DeliveryLng" size="30" maxlength="50" placeholder="<%= OrdersLocal.DeliveryLng.PlaceHolder %>" value="<%= OrdersLocal.DeliveryLng.EditValue %>"<%= OrdersLocal.DeliveryLng.EditAttributes %>>
</span>
<%= OrdersLocal.DeliveryLng.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrdersLocal.ServiceCharge.Visible Then ' ServiceCharge %>
	<div id="r_ServiceCharge" class="form-group">
		<label for="x_ServiceCharge" class="col-sm-2 control-label">
<input type="checkbox" name="u_ServiceCharge" id="u_ServiceCharge" value="1"<% If OrdersLocal.ServiceCharge.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrdersLocal.ServiceCharge.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrdersLocal.ServiceCharge.CellAttributes %>>
<span id="el_OrdersLocal_ServiceCharge">
<input type="text" data-field="x_ServiceCharge" name="x_ServiceCharge" id="x_ServiceCharge" size="30" placeholder="<%= OrdersLocal.ServiceCharge.PlaceHolder %>" value="<%= OrdersLocal.ServiceCharge.EditValue %>"<%= OrdersLocal.ServiceCharge.EditAttributes %>>
</span>
<%= OrdersLocal.ServiceCharge.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrdersLocal.PaymentSurcharge.Visible Then ' PaymentSurcharge %>
	<div id="r_PaymentSurcharge" class="form-group">
		<label for="x_PaymentSurcharge" class="col-sm-2 control-label">
<input type="checkbox" name="u_PaymentSurcharge" id="u_PaymentSurcharge" value="1"<% If OrdersLocal.PaymentSurcharge.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrdersLocal.PaymentSurcharge.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrdersLocal.PaymentSurcharge.CellAttributes %>>
<span id="el_OrdersLocal_PaymentSurcharge">
<input type="text" data-field="x_PaymentSurcharge" name="x_PaymentSurcharge" id="x_PaymentSurcharge" size="30" placeholder="<%= OrdersLocal.PaymentSurcharge.PlaceHolder %>" value="<%= OrdersLocal.PaymentSurcharge.EditValue %>"<%= OrdersLocal.PaymentSurcharge.EditAttributes %>>
</span>
<%= OrdersLocal.PaymentSurcharge.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrdersLocal.Tax_Rate.Visible Then ' Tax_Rate %>
	<div id="r_Tax_Rate" class="form-group">
		<label for="x_Tax_Rate" class="col-sm-2 control-label">
<input type="checkbox" name="u_Tax_Rate" id="u_Tax_Rate" value="1"<% If OrdersLocal.Tax_Rate.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrdersLocal.Tax_Rate.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrdersLocal.Tax_Rate.CellAttributes %>>
<span id="el_OrdersLocal_Tax_Rate">
<input type="text" data-field="x_Tax_Rate" name="x_Tax_Rate" id="x_Tax_Rate" size="30" placeholder="<%= OrdersLocal.Tax_Rate.PlaceHolder %>" value="<%= OrdersLocal.Tax_Rate.EditValue %>"<%= OrdersLocal.Tax_Rate.EditAttributes %>>
</span>
<%= OrdersLocal.Tax_Rate.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrdersLocal.Tax_Amount.Visible Then ' Tax_Amount %>
	<div id="r_Tax_Amount" class="form-group">
		<label for="x_Tax_Amount" class="col-sm-2 control-label">
<input type="checkbox" name="u_Tax_Amount" id="u_Tax_Amount" value="1"<% If OrdersLocal.Tax_Amount.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrdersLocal.Tax_Amount.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrdersLocal.Tax_Amount.CellAttributes %>>
<span id="el_OrdersLocal_Tax_Amount">
<input type="text" data-field="x_Tax_Amount" name="x_Tax_Amount" id="x_Tax_Amount" size="30" placeholder="<%= OrdersLocal.Tax_Amount.PlaceHolder %>" value="<%= OrdersLocal.Tax_Amount.EditValue %>"<%= OrdersLocal.Tax_Amount.EditAttributes %>>
</span>
<%= OrdersLocal.Tax_Amount.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrdersLocal.Tip_Rate.Visible Then ' Tip_Rate %>
	<div id="r_Tip_Rate" class="form-group">
		<label for="x_Tip_Rate" class="col-sm-2 control-label">
<input type="checkbox" name="u_Tip_Rate" id="u_Tip_Rate" value="1"<% If OrdersLocal.Tip_Rate.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrdersLocal.Tip_Rate.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrdersLocal.Tip_Rate.CellAttributes %>>
<span id="el_OrdersLocal_Tip_Rate">
<input type="text" data-field="x_Tip_Rate" name="x_Tip_Rate" id="x_Tip_Rate" size="30" maxlength="255" placeholder="<%= OrdersLocal.Tip_Rate.PlaceHolder %>" value="<%= OrdersLocal.Tip_Rate.EditValue %>"<%= OrdersLocal.Tip_Rate.EditAttributes %>>
</span>
<%= OrdersLocal.Tip_Rate.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrdersLocal.Tip_Amount.Visible Then ' Tip_Amount %>
	<div id="r_Tip_Amount" class="form-group">
		<label for="x_Tip_Amount" class="col-sm-2 control-label">
<input type="checkbox" name="u_Tip_Amount" id="u_Tip_Amount" value="1"<% If OrdersLocal.Tip_Amount.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrdersLocal.Tip_Amount.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrdersLocal.Tip_Amount.CellAttributes %>>
<span id="el_OrdersLocal_Tip_Amount">
<input type="text" data-field="x_Tip_Amount" name="x_Tip_Amount" id="x_Tip_Amount" size="30" placeholder="<%= OrdersLocal.Tip_Amount.PlaceHolder %>" value="<%= OrdersLocal.Tip_Amount.EditValue %>"<%= OrdersLocal.Tip_Amount.EditAttributes %>>
</span>
<%= OrdersLocal.Tip_Amount.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrdersLocal.paymentstatus.Visible Then ' paymentstatus %>
	<div id="r_paymentstatus" class="form-group">
		<label for="x_paymentstatus" class="col-sm-2 control-label">
<input type="checkbox" name="u_paymentstatus" id="u_paymentstatus" value="1"<% If OrdersLocal.paymentstatus.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrdersLocal.paymentstatus.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrdersLocal.paymentstatus.CellAttributes %>>
<span id="el_OrdersLocal_paymentstatus">
<input type="text" data-field="x_paymentstatus" name="x_paymentstatus" id="x_paymentstatus" size="30" maxlength="255" placeholder="<%= OrdersLocal.paymentstatus.PlaceHolder %>" value="<%= OrdersLocal.paymentstatus.EditValue %>"<%= OrdersLocal.paymentstatus.EditAttributes %>>
</span>
<%= OrdersLocal.paymentstatus.CustomMsg %></div></div>
	</div>
<% End If %>
<% If OrdersLocal.Payment_Status.Visible Then ' Payment_Status %>
	<div id="r_Payment_Status" class="form-group">
		<label for="x_Payment_Status" class="col-sm-2 control-label">
<input type="checkbox" name="u_Payment_Status" id="u_Payment_Status" value="1"<% If OrdersLocal.Payment_Status.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= OrdersLocal.Payment_Status.FldCaption %></label>
		<div class="col-sm-10"><div<%= OrdersLocal.Payment_Status.CellAttributes %>>
<span id="el_OrdersLocal_Payment_Status">
<input type="text" data-field="x_Payment_Status" name="x_Payment_Status" id="x_Payment_Status" size="30" maxlength="255" placeholder="<%= OrdersLocal.Payment_Status.PlaceHolder %>" value="<%= OrdersLocal.Payment_Status.EditValue %>"<%= OrdersLocal.Payment_Status.EditAttributes %>>
</span>
<%= OrdersLocal.Payment_Status.CustomMsg %></div></div>
	</div>
<% End If %>
	<div class="form-group">
		<div class="col-sm-offset-2 col-sm-10">
<button class="btn btn-primary ewButton" name="btnAction" id="btnAction" type="submit"><%= Language.Phrase("UpdateBtn") %></button>
		</div>
	</div>
</div>
</form>
<script type="text/javascript">
fOrdersLocalupdate.Init();
</script>
<%
OrdersLocal_update.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set OrdersLocal_update = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cOrdersLocal_update

	' Page ID
	Public Property Get PageID()
		PageID = "update"
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
		PageObjName = "OrdersLocal_update"
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
		EW_PAGE_ID = "update"

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

		' Create form object
		'If ew_IsHttpPost() Then

			Set ObjForm = New cFormObj

		'Else
		'	Set ObjForm = ew_GetUploadObj()
		'End If

		OrdersLocal.CurrentAction = ew_IIf(Request.QueryString("a").Count > 0, Request.QueryString("a") & "", ObjForm.GetValue("a_list") & "") ' Set up current action

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

	Dim RecKeys
	Dim Disabled
	Dim Recordset
	Dim UpdateCount

	' -----------------------------------------------------------------
	' Page main processing
	'
	Sub Page_Main()
		Dim sKeyName
		Dim sKey
		Dim nKeySelected
		Dim bUpdateSelected
		UpdateCount = 0

		' Set up Breadcrumb
		SetupBreadcrumb()
		RecKeys = OrdersLocal.GetRecordKeys() ' Load record keys
		If ObjForm.GetValue("a_update")&"" <> "" Then

			' Get action
			OrdersLocal.CurrentAction = ObjForm.GetValue("a_update")
			Call LoadFormValues() ' Get form values

			' Validate form
			If Not ValidateForm() Then
				OrdersLocal.CurrentAction = "I" ' Form error, reset action
				FailureMessage = gsFormError
			End If
		Else
			Call LoadMultiUpdateValues() ' Load initial values to form
		End If
		If Not IsArray(RecKeys) Then
			Call Page_Terminate("OrdersLocallist.asp") ' No records selected, return to list
		End If
		Select Case OrdersLocal.CurrentAction
			Case "U" ' Update
				If UpdateRows() Then ' Update Records based on key
					If SuccessMessage = "" Then SuccessMessage = Language.Phrase("UpdateSuccess") ' Set update success message
					Call Page_Terminate(OrdersLocal.ReturnUrl) ' Return to caller
				Else
					Call RestoreFormValues() ' Restore form values
				End If
		End Select

		' Render row
		OrdersLocal.RowType = EW_ROWTYPE_EDIT ' Render edit

		' Render row
		Call OrdersLocal.ResetAttrs()
		Call RenderRow()
	End Sub

	' -----------------------------------------------------------------
	' Load initial values to form if field values are identical in all selected records
	'
	Sub LoadMultiUpdateValues()
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		Dim Rs, i, OldValue, NewValue
		OrdersLocal.CurrentFilter = OrdersLocal.GetKeyFilter()

		' Load recordset
		Set Rs = LoadRecordset()
		i = 1
		Do While Not Rs.Eof
			If i = 1 Then
				OrdersLocal.CreationDate.DbValue = ew_Conv(Rs("CreationDate"), Rs("CreationDate").Type)
				OrdersLocal.OrderDate.DbValue = ew_Conv(Rs("OrderDate"), Rs("OrderDate").Type)
				OrdersLocal.DeliveryType.DbValue = ew_Conv(Rs("DeliveryType"), Rs("DeliveryType").Type)
				OrdersLocal.DeliveryTime.DbValue = ew_Conv(Rs("DeliveryTime"), Rs("DeliveryTime").Type)
				OrdersLocal.PaymentType.DbValue = ew_Conv(Rs("PaymentType"), Rs("PaymentType").Type)
				OrdersLocal.SubTotal.DbValue = ew_Conv(Rs("SubTotal"), Rs("SubTotal").Type)
				OrdersLocal.ShippingFee.DbValue = ew_Conv(Rs("ShippingFee"), Rs("ShippingFee").Type)
				OrdersLocal.OrderTotal.DbValue = ew_Conv(Rs("OrderTotal"), Rs("OrderTotal").Type)
				OrdersLocal.IdBusinessDetail.DbValue = ew_Conv(Rs("IdBusinessDetail"), Rs("IdBusinessDetail").Type)
				OrdersLocal.SessionId.DbValue = ew_Conv(Rs("SessionId"), Rs("SessionId").Type)
				OrdersLocal.FirstName.DbValue = ew_Conv(Rs("FirstName"), Rs("FirstName").Type)
				OrdersLocal.LastName.DbValue = ew_Conv(Rs("LastName"), Rs("LastName").Type)
				OrdersLocal.zEmail.DbValue = ew_Conv(Rs("Email"), Rs("Email").Type)
				OrdersLocal.Phone.DbValue = ew_Conv(Rs("Phone"), Rs("Phone").Type)
				OrdersLocal.Address.DbValue = ew_Conv(Rs("Address"), Rs("Address").Type)
				OrdersLocal.PostalCode.DbValue = ew_Conv(Rs("PostalCode"), Rs("PostalCode").Type)
				OrdersLocal.Notes.DbValue = ew_Conv(Rs("Notes"), Rs("Notes").Type)
				OrdersLocal.ttest.DbValue = ew_Conv(Rs("ttest"), Rs("ttest").Type)
				OrdersLocal.cancelleddate.DbValue = ew_Conv(Rs("cancelleddate"), Rs("cancelleddate").Type)
				OrdersLocal.cancelledby.DbValue = ew_Conv(Rs("cancelledby"), Rs("cancelledby").Type)
				OrdersLocal.cancelledreason.DbValue = ew_Conv(Rs("cancelledreason"), Rs("cancelledreason").Type)
				OrdersLocal.acknowledgeddate.DbValue = ew_Conv(Rs("acknowledgeddate"), Rs("acknowledgeddate").Type)
				OrdersLocal.delivereddate.DbValue = ew_Conv(Rs("delivereddate"), Rs("delivereddate").Type)
				OrdersLocal.cancelled.DbValue = ew_Conv(Rs("cancelled"), Rs("cancelled").Type)
				OrdersLocal.acknowledged.DbValue = ew_Conv(Rs("acknowledged"), Rs("acknowledged").Type)
				OrdersLocal.outfordelivery.DbValue = ew_Conv(Rs("outfordelivery"), Rs("outfordelivery").Type)
				OrdersLocal.vouchercodediscount.DbValue = ew_Conv(Rs("vouchercodediscount"), Rs("vouchercodediscount").Type)
				OrdersLocal.vouchercode.DbValue = ew_Conv(Rs("vouchercode"), Rs("vouchercode").Type)
				OrdersLocal.printed.DbValue = ew_Conv(Rs("printed"), Rs("printed").Type)
				OrdersLocal.deliverydistance.DbValue = ew_Conv(Rs("deliverydistance"), Rs("deliverydistance").Type)
				OrdersLocal.asaporder.DbValue = ew_Conv(Rs("asaporder"), Rs("asaporder").Type)
				OrdersLocal.DeliveryLat.DbValue = ew_Conv(Rs("DeliveryLat"), Rs("DeliveryLat").Type)
				OrdersLocal.DeliveryLng.DbValue = ew_Conv(Rs("DeliveryLng"), Rs("DeliveryLng").Type)
				OrdersLocal.ServiceCharge.DbValue = ew_Conv(Rs("ServiceCharge"), Rs("ServiceCharge").Type)
				OrdersLocal.PaymentSurcharge.DbValue = ew_Conv(Rs("PaymentSurcharge"), Rs("PaymentSurcharge").Type)
				OrdersLocal.Tax_Rate.DbValue = ew_Conv(Rs("Tax_Rate"), Rs("Tax_Rate").Type)
				OrdersLocal.Tax_Amount.DbValue = ew_Conv(Rs("Tax_Amount"), Rs("Tax_Amount").Type)
				OrdersLocal.Tip_Rate.DbValue = ew_Conv(Rs("Tip_Rate"), Rs("Tip_Rate").Type)
				OrdersLocal.Tip_Amount.DbValue = ew_Conv(Rs("Tip_Amount"), Rs("Tip_Amount").Type)
				OrdersLocal.paymentstatus.DbValue = ew_Conv(Rs("paymentstatus"), Rs("paymentstatus").Type)
				OrdersLocal.Payment_Status.DbValue = ew_Conv(Rs("Payment_Status"), Rs("Payment_Status").Type)
			Else
				OldValue = OrdersLocal.CreationDate.DbValue
				NewValue = ew_Conv(Rs("CreationDate"), Rs("CreationDate").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrdersLocal.CreationDate.CurrentValue = Null
				End If
				OldValue = OrdersLocal.OrderDate.DbValue
				NewValue = ew_Conv(Rs("OrderDate"), Rs("OrderDate").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrdersLocal.OrderDate.CurrentValue = Null
				End If
				OldValue = OrdersLocal.DeliveryType.DbValue
				NewValue = ew_Conv(Rs("DeliveryType"), Rs("DeliveryType").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrdersLocal.DeliveryType.CurrentValue = Null
				End If
				OldValue = OrdersLocal.DeliveryTime.DbValue
				NewValue = ew_Conv(Rs("DeliveryTime"), Rs("DeliveryTime").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrdersLocal.DeliveryTime.CurrentValue = Null
				End If
				OldValue = OrdersLocal.PaymentType.DbValue
				NewValue = ew_Conv(Rs("PaymentType"), Rs("PaymentType").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrdersLocal.PaymentType.CurrentValue = Null
				End If
				OldValue = OrdersLocal.SubTotal.DbValue
				NewValue = ew_Conv(Rs("SubTotal"), Rs("SubTotal").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrdersLocal.SubTotal.CurrentValue = Null
				End If
				OldValue = OrdersLocal.ShippingFee.DbValue
				NewValue = ew_Conv(Rs("ShippingFee"), Rs("ShippingFee").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrdersLocal.ShippingFee.CurrentValue = Null
				End If
				OldValue = OrdersLocal.OrderTotal.DbValue
				NewValue = ew_Conv(Rs("OrderTotal"), Rs("OrderTotal").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrdersLocal.OrderTotal.CurrentValue = Null
				End If
				OldValue = OrdersLocal.IdBusinessDetail.DbValue
				NewValue = ew_Conv(Rs("IdBusinessDetail"), Rs("IdBusinessDetail").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrdersLocal.IdBusinessDetail.CurrentValue = Null
				End If
				OldValue = OrdersLocal.SessionId.DbValue
				NewValue = ew_Conv(Rs("SessionId"), Rs("SessionId").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrdersLocal.SessionId.CurrentValue = Null
				End If
				OldValue = OrdersLocal.FirstName.DbValue
				NewValue = ew_Conv(Rs("FirstName"), Rs("FirstName").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrdersLocal.FirstName.CurrentValue = Null
				End If
				OldValue = OrdersLocal.LastName.DbValue
				NewValue = ew_Conv(Rs("LastName"), Rs("LastName").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrdersLocal.LastName.CurrentValue = Null
				End If
				OldValue = OrdersLocal.zEmail.DbValue
				NewValue = ew_Conv(Rs("Email"), Rs("Email").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrdersLocal.zEmail.CurrentValue = Null
				End If
				OldValue = OrdersLocal.Phone.DbValue
				NewValue = ew_Conv(Rs("Phone"), Rs("Phone").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrdersLocal.Phone.CurrentValue = Null
				End If
				OldValue = OrdersLocal.Address.DbValue
				NewValue = ew_Conv(Rs("Address"), Rs("Address").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrdersLocal.Address.CurrentValue = Null
				End If
				OldValue = OrdersLocal.PostalCode.DbValue
				NewValue = ew_Conv(Rs("PostalCode"), Rs("PostalCode").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrdersLocal.PostalCode.CurrentValue = Null
				End If
				OldValue = OrdersLocal.Notes.DbValue
				NewValue = ew_Conv(Rs("Notes"), Rs("Notes").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrdersLocal.Notes.CurrentValue = Null
				End If
				OldValue = OrdersLocal.ttest.DbValue
				NewValue = ew_Conv(Rs("ttest"), Rs("ttest").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrdersLocal.ttest.CurrentValue = Null
				End If
				OldValue = OrdersLocal.cancelleddate.DbValue
				NewValue = ew_Conv(Rs("cancelleddate"), Rs("cancelleddate").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrdersLocal.cancelleddate.CurrentValue = Null
				End If
				OldValue = OrdersLocal.cancelledby.DbValue
				NewValue = ew_Conv(Rs("cancelledby"), Rs("cancelledby").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrdersLocal.cancelledby.CurrentValue = Null
				End If
				OldValue = OrdersLocal.cancelledreason.DbValue
				NewValue = ew_Conv(Rs("cancelledreason"), Rs("cancelledreason").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrdersLocal.cancelledreason.CurrentValue = Null
				End If
				OldValue = OrdersLocal.acknowledgeddate.DbValue
				NewValue = ew_Conv(Rs("acknowledgeddate"), Rs("acknowledgeddate").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrdersLocal.acknowledgeddate.CurrentValue = Null
				End If
				OldValue = OrdersLocal.delivereddate.DbValue
				NewValue = ew_Conv(Rs("delivereddate"), Rs("delivereddate").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrdersLocal.delivereddate.CurrentValue = Null
				End If
				OldValue = OrdersLocal.cancelled.DbValue
				NewValue = ew_Conv(Rs("cancelled"), Rs("cancelled").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrdersLocal.cancelled.CurrentValue = Null
				End If
				OldValue = OrdersLocal.acknowledged.DbValue
				NewValue = ew_Conv(Rs("acknowledged"), Rs("acknowledged").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrdersLocal.acknowledged.CurrentValue = Null
				End If
				OldValue = OrdersLocal.outfordelivery.DbValue
				NewValue = ew_Conv(Rs("outfordelivery"), Rs("outfordelivery").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrdersLocal.outfordelivery.CurrentValue = Null
				End If
				OldValue = OrdersLocal.vouchercodediscount.DbValue
				NewValue = ew_Conv(Rs("vouchercodediscount"), Rs("vouchercodediscount").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrdersLocal.vouchercodediscount.CurrentValue = Null
				End If
				OldValue = OrdersLocal.vouchercode.DbValue
				NewValue = ew_Conv(Rs("vouchercode"), Rs("vouchercode").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrdersLocal.vouchercode.CurrentValue = Null
				End If
				OldValue = OrdersLocal.printed.DbValue
				NewValue = ew_Conv(Rs("printed"), Rs("printed").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrdersLocal.printed.CurrentValue = Null
				End If
				OldValue = OrdersLocal.deliverydistance.DbValue
				NewValue = ew_Conv(Rs("deliverydistance"), Rs("deliverydistance").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrdersLocal.deliverydistance.CurrentValue = Null
				End If
				OldValue = OrdersLocal.asaporder.DbValue
				NewValue = ew_Conv(Rs("asaporder"), Rs("asaporder").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrdersLocal.asaporder.CurrentValue = Null
				End If
				OldValue = OrdersLocal.DeliveryLat.DbValue
				NewValue = ew_Conv(Rs("DeliveryLat"), Rs("DeliveryLat").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrdersLocal.DeliveryLat.CurrentValue = Null
				End If
				OldValue = OrdersLocal.DeliveryLng.DbValue
				NewValue = ew_Conv(Rs("DeliveryLng"), Rs("DeliveryLng").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrdersLocal.DeliveryLng.CurrentValue = Null
				End If
				OldValue = OrdersLocal.ServiceCharge.DbValue
				NewValue = ew_Conv(Rs("ServiceCharge"), Rs("ServiceCharge").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrdersLocal.ServiceCharge.CurrentValue = Null
				End If
				OldValue = OrdersLocal.PaymentSurcharge.DbValue
				NewValue = ew_Conv(Rs("PaymentSurcharge"), Rs("PaymentSurcharge").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrdersLocal.PaymentSurcharge.CurrentValue = Null
				End If
				OldValue = OrdersLocal.Tax_Rate.DbValue
				NewValue = ew_Conv(Rs("Tax_Rate"), Rs("Tax_Rate").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrdersLocal.Tax_Rate.CurrentValue = Null
				End If
				OldValue = OrdersLocal.Tax_Amount.DbValue
				NewValue = ew_Conv(Rs("Tax_Amount"), Rs("Tax_Amount").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrdersLocal.Tax_Amount.CurrentValue = Null
				End If
				OldValue = OrdersLocal.Tip_Rate.DbValue
				NewValue = ew_Conv(Rs("Tip_Rate"), Rs("Tip_Rate").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrdersLocal.Tip_Rate.CurrentValue = Null
				End If
				OldValue = OrdersLocal.Tip_Amount.DbValue
				NewValue = ew_Conv(Rs("Tip_Amount"), Rs("Tip_Amount").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrdersLocal.Tip_Amount.CurrentValue = Null
				End If
				OldValue = OrdersLocal.paymentstatus.DbValue
				NewValue = ew_Conv(Rs("paymentstatus"), Rs("paymentstatus").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrdersLocal.paymentstatus.CurrentValue = Null
				End If
				OldValue = OrdersLocal.Payment_Status.DbValue
				NewValue = ew_Conv(Rs("Payment_Status"), Rs("Payment_Status").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					OrdersLocal.Payment_Status.CurrentValue = Null
				End If
			End If
			i = i + 1
			Rs.MoveNext
		Loop
		Rs.Close
		Set Rs = Nothing
	End Sub

	' -----------------------------------------------------------------
	'  Set up key value
	'
	Function SetupKeyValues(key)
		Dim sKeyFld
		Dim sWrkFilter, sFilter
		sKeyFld = key
		If Not IsNumeric(sKeyFld) Then
			SetupKeyValues = False
			Exit Function
		End If
		OrdersLocal.ID.CurrentValue = sKeyFld ' Set up key value
		SetupKeyValues = True
	End Function

	' -----------------------------------------------------------------
	' Update all selected rows
	'
	Function UpdateRows()
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		Dim sKey, sThisKey
		Dim Rs, RsOld, RsNew, sSql, i
		Conn.BeginTrans

		' Get old recordset
		OrdersLocal.CurrentFilter = OrdersLocal.GetKeyFilter()
		sSql = OrdersLocal.SQL
		Set Rs = Server.CreateObject("ADODB.Recordset")
		Rs.CursorLocation = EW_CURSORLOCATION
		Rs.Open sSql, Conn, 1, EW_RECORDSET_LOCKTYPE
		Set RsOld = ew_CloneRs(Rs)

		' Update all rows
		sKey = ""
		For i = 0 to UBound(RecKeys)
			If SetupKeyValues(RecKeys(i)) Then
				sThisKey = RecKeys(i)
				OrdersLocal.SendEmail = False ' Do not send email on update success
				UpdateCount = UpdateCount + 1 ' Update record count for records being updated
				UpdateRows = EditRow() ' Update this row
			Else
				UpdateRows = False
			End If
			If Not UpdateRows Then Exit For ' Update failed
			If sKey <> "" Then sKey = sKey & ", "
			sKey = sKey & sThisKey
		Next
		If UpdateRows Then
			Conn.CommitTrans ' Commit transaction

			' Get new recordset
			Set Rs = Conn.Execute(sSql)
			Set RsNew = ew_CloneRs(Rs)
		Else
			Conn.RollbackTrans ' Rollback transaction
		End If
		Set Rs = Nothing
		Set RsOld = Nothing
		Set RsNew = Nothing
	End Function

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
		If Not OrdersLocal.CreationDate.FldIsDetailKey Then OrdersLocal.CreationDate.FormValue = ObjForm.GetValue("x_CreationDate")
		If Not OrdersLocal.CreationDate.FldIsDetailKey Then OrdersLocal.CreationDate.CurrentValue = ew_UnFormatDateTime(OrdersLocal.CreationDate.CurrentValue, 9)
		OrdersLocal.CreationDate.MultiUpdate = ObjForm.GetValue("u_CreationDate")
		If Not OrdersLocal.OrderDate.FldIsDetailKey Then OrdersLocal.OrderDate.FormValue = ObjForm.GetValue("x_OrderDate")
		If Not OrdersLocal.OrderDate.FldIsDetailKey Then OrdersLocal.OrderDate.CurrentValue = ew_UnFormatDateTime(OrdersLocal.OrderDate.CurrentValue, 9)
		OrdersLocal.OrderDate.MultiUpdate = ObjForm.GetValue("u_OrderDate")
		If Not OrdersLocal.DeliveryType.FldIsDetailKey Then OrdersLocal.DeliveryType.FormValue = ObjForm.GetValue("x_DeliveryType")
		OrdersLocal.DeliveryType.MultiUpdate = ObjForm.GetValue("u_DeliveryType")
		If Not OrdersLocal.DeliveryTime.FldIsDetailKey Then OrdersLocal.DeliveryTime.FormValue = ObjForm.GetValue("x_DeliveryTime")
		If Not OrdersLocal.DeliveryTime.FldIsDetailKey Then OrdersLocal.DeliveryTime.CurrentValue = ew_UnFormatDateTime(OrdersLocal.DeliveryTime.CurrentValue, 9)
		OrdersLocal.DeliveryTime.MultiUpdate = ObjForm.GetValue("u_DeliveryTime")
		If Not OrdersLocal.PaymentType.FldIsDetailKey Then OrdersLocal.PaymentType.FormValue = ObjForm.GetValue("x_PaymentType")
		OrdersLocal.PaymentType.MultiUpdate = ObjForm.GetValue("u_PaymentType")
		If Not OrdersLocal.SubTotal.FldIsDetailKey Then OrdersLocal.SubTotal.FormValue = ObjForm.GetValue("x_SubTotal")
		OrdersLocal.SubTotal.MultiUpdate = ObjForm.GetValue("u_SubTotal")
		If Not OrdersLocal.ShippingFee.FldIsDetailKey Then OrdersLocal.ShippingFee.FormValue = ObjForm.GetValue("x_ShippingFee")
		OrdersLocal.ShippingFee.MultiUpdate = ObjForm.GetValue("u_ShippingFee")
		If Not OrdersLocal.OrderTotal.FldIsDetailKey Then OrdersLocal.OrderTotal.FormValue = ObjForm.GetValue("x_OrderTotal")
		OrdersLocal.OrderTotal.MultiUpdate = ObjForm.GetValue("u_OrderTotal")
		If Not OrdersLocal.IdBusinessDetail.FldIsDetailKey Then OrdersLocal.IdBusinessDetail.FormValue = ObjForm.GetValue("x_IdBusinessDetail")
		OrdersLocal.IdBusinessDetail.MultiUpdate = ObjForm.GetValue("u_IdBusinessDetail")
		If Not OrdersLocal.SessionId.FldIsDetailKey Then OrdersLocal.SessionId.FormValue = ObjForm.GetValue("x_SessionId")
		OrdersLocal.SessionId.MultiUpdate = ObjForm.GetValue("u_SessionId")
		If Not OrdersLocal.FirstName.FldIsDetailKey Then OrdersLocal.FirstName.FormValue = ObjForm.GetValue("x_FirstName")
		OrdersLocal.FirstName.MultiUpdate = ObjForm.GetValue("u_FirstName")
		If Not OrdersLocal.LastName.FldIsDetailKey Then OrdersLocal.LastName.FormValue = ObjForm.GetValue("x_LastName")
		OrdersLocal.LastName.MultiUpdate = ObjForm.GetValue("u_LastName")
		If Not OrdersLocal.zEmail.FldIsDetailKey Then OrdersLocal.zEmail.FormValue = ObjForm.GetValue("x_zEmail")
		OrdersLocal.zEmail.MultiUpdate = ObjForm.GetValue("u_zEmail")
		If Not OrdersLocal.Phone.FldIsDetailKey Then OrdersLocal.Phone.FormValue = ObjForm.GetValue("x_Phone")
		OrdersLocal.Phone.MultiUpdate = ObjForm.GetValue("u_Phone")
		If Not OrdersLocal.Address.FldIsDetailKey Then OrdersLocal.Address.FormValue = ObjForm.GetValue("x_Address")
		OrdersLocal.Address.MultiUpdate = ObjForm.GetValue("u_Address")
		If Not OrdersLocal.PostalCode.FldIsDetailKey Then OrdersLocal.PostalCode.FormValue = ObjForm.GetValue("x_PostalCode")
		OrdersLocal.PostalCode.MultiUpdate = ObjForm.GetValue("u_PostalCode")
		If Not OrdersLocal.Notes.FldIsDetailKey Then OrdersLocal.Notes.FormValue = ObjForm.GetValue("x_Notes")
		OrdersLocal.Notes.MultiUpdate = ObjForm.GetValue("u_Notes")
		If Not OrdersLocal.ttest.FldIsDetailKey Then OrdersLocal.ttest.FormValue = ObjForm.GetValue("x_ttest")
		OrdersLocal.ttest.MultiUpdate = ObjForm.GetValue("u_ttest")
		If Not OrdersLocal.cancelleddate.FldIsDetailKey Then OrdersLocal.cancelleddate.FormValue = ObjForm.GetValue("x_cancelleddate")
		If Not OrdersLocal.cancelleddate.FldIsDetailKey Then OrdersLocal.cancelleddate.CurrentValue = ew_UnFormatDateTime(OrdersLocal.cancelleddate.CurrentValue, 9)
		OrdersLocal.cancelleddate.MultiUpdate = ObjForm.GetValue("u_cancelleddate")
		If Not OrdersLocal.cancelledby.FldIsDetailKey Then OrdersLocal.cancelledby.FormValue = ObjForm.GetValue("x_cancelledby")
		OrdersLocal.cancelledby.MultiUpdate = ObjForm.GetValue("u_cancelledby")
		If Not OrdersLocal.cancelledreason.FldIsDetailKey Then OrdersLocal.cancelledreason.FormValue = ObjForm.GetValue("x_cancelledreason")
		OrdersLocal.cancelledreason.MultiUpdate = ObjForm.GetValue("u_cancelledreason")
		If Not OrdersLocal.acknowledgeddate.FldIsDetailKey Then OrdersLocal.acknowledgeddate.FormValue = ObjForm.GetValue("x_acknowledgeddate")
		If Not OrdersLocal.acknowledgeddate.FldIsDetailKey Then OrdersLocal.acknowledgeddate.CurrentValue = ew_UnFormatDateTime(OrdersLocal.acknowledgeddate.CurrentValue, 9)
		OrdersLocal.acknowledgeddate.MultiUpdate = ObjForm.GetValue("u_acknowledgeddate")
		If Not OrdersLocal.delivereddate.FldIsDetailKey Then OrdersLocal.delivereddate.FormValue = ObjForm.GetValue("x_delivereddate")
		OrdersLocal.delivereddate.MultiUpdate = ObjForm.GetValue("u_delivereddate")
		If Not OrdersLocal.cancelled.FldIsDetailKey Then OrdersLocal.cancelled.FormValue = ObjForm.GetValue("x_cancelled")
		OrdersLocal.cancelled.MultiUpdate = ObjForm.GetValue("u_cancelled")
		If Not OrdersLocal.acknowledged.FldIsDetailKey Then OrdersLocal.acknowledged.FormValue = ObjForm.GetValue("x_acknowledged")
		OrdersLocal.acknowledged.MultiUpdate = ObjForm.GetValue("u_acknowledged")
		If Not OrdersLocal.outfordelivery.FldIsDetailKey Then OrdersLocal.outfordelivery.FormValue = ObjForm.GetValue("x_outfordelivery")
		OrdersLocal.outfordelivery.MultiUpdate = ObjForm.GetValue("u_outfordelivery")
		If Not OrdersLocal.vouchercodediscount.FldIsDetailKey Then OrdersLocal.vouchercodediscount.FormValue = ObjForm.GetValue("x_vouchercodediscount")
		OrdersLocal.vouchercodediscount.MultiUpdate = ObjForm.GetValue("u_vouchercodediscount")
		If Not OrdersLocal.vouchercode.FldIsDetailKey Then OrdersLocal.vouchercode.FormValue = ObjForm.GetValue("x_vouchercode")
		OrdersLocal.vouchercode.MultiUpdate = ObjForm.GetValue("u_vouchercode")
		If Not OrdersLocal.printed.FldIsDetailKey Then OrdersLocal.printed.FormValue = ObjForm.GetValue("x_printed")
		OrdersLocal.printed.MultiUpdate = ObjForm.GetValue("u_printed")
		If Not OrdersLocal.deliverydistance.FldIsDetailKey Then OrdersLocal.deliverydistance.FormValue = ObjForm.GetValue("x_deliverydistance")
		OrdersLocal.deliverydistance.MultiUpdate = ObjForm.GetValue("u_deliverydistance")
		If Not OrdersLocal.asaporder.FldIsDetailKey Then OrdersLocal.asaporder.FormValue = ObjForm.GetValue("x_asaporder")
		OrdersLocal.asaporder.MultiUpdate = ObjForm.GetValue("u_asaporder")
		If Not OrdersLocal.DeliveryLat.FldIsDetailKey Then OrdersLocal.DeliveryLat.FormValue = ObjForm.GetValue("x_DeliveryLat")
		OrdersLocal.DeliveryLat.MultiUpdate = ObjForm.GetValue("u_DeliveryLat")
		If Not OrdersLocal.DeliveryLng.FldIsDetailKey Then OrdersLocal.DeliveryLng.FormValue = ObjForm.GetValue("x_DeliveryLng")
		OrdersLocal.DeliveryLng.MultiUpdate = ObjForm.GetValue("u_DeliveryLng")
		If Not OrdersLocal.ServiceCharge.FldIsDetailKey Then OrdersLocal.ServiceCharge.FormValue = ObjForm.GetValue("x_ServiceCharge")
		OrdersLocal.ServiceCharge.MultiUpdate = ObjForm.GetValue("u_ServiceCharge")
		If Not OrdersLocal.PaymentSurcharge.FldIsDetailKey Then OrdersLocal.PaymentSurcharge.FormValue = ObjForm.GetValue("x_PaymentSurcharge")
		OrdersLocal.PaymentSurcharge.MultiUpdate = ObjForm.GetValue("u_PaymentSurcharge")
		If Not OrdersLocal.Tax_Rate.FldIsDetailKey Then OrdersLocal.Tax_Rate.FormValue = ObjForm.GetValue("x_Tax_Rate")
		OrdersLocal.Tax_Rate.MultiUpdate = ObjForm.GetValue("u_Tax_Rate")
		If Not OrdersLocal.Tax_Amount.FldIsDetailKey Then OrdersLocal.Tax_Amount.FormValue = ObjForm.GetValue("x_Tax_Amount")
		OrdersLocal.Tax_Amount.MultiUpdate = ObjForm.GetValue("u_Tax_Amount")
		If Not OrdersLocal.Tip_Rate.FldIsDetailKey Then OrdersLocal.Tip_Rate.FormValue = ObjForm.GetValue("x_Tip_Rate")
		OrdersLocal.Tip_Rate.MultiUpdate = ObjForm.GetValue("u_Tip_Rate")
		If Not OrdersLocal.Tip_Amount.FldIsDetailKey Then OrdersLocal.Tip_Amount.FormValue = ObjForm.GetValue("x_Tip_Amount")
		OrdersLocal.Tip_Amount.MultiUpdate = ObjForm.GetValue("u_Tip_Amount")
		If Not OrdersLocal.paymentstatus.FldIsDetailKey Then OrdersLocal.paymentstatus.FormValue = ObjForm.GetValue("x_paymentstatus")
		OrdersLocal.paymentstatus.MultiUpdate = ObjForm.GetValue("u_paymentstatus")
		If Not OrdersLocal.Payment_Status.FldIsDetailKey Then OrdersLocal.Payment_Status.FormValue = ObjForm.GetValue("x_Payment_Status")
		OrdersLocal.Payment_Status.MultiUpdate = ObjForm.GetValue("u_Payment_Status")
		If Not OrdersLocal.ID.FldIsDetailKey Then OrdersLocal.ID.FormValue = ObjForm.GetValue("x_ID")
	End Function

	' -----------------------------------------------------------------
	' Restore form values
	'
	Function RestoreFormValues()
		OrdersLocal.CreationDate.CurrentValue = OrdersLocal.CreationDate.FormValue
		OrdersLocal.CreationDate.CurrentValue = ew_UnFormatDateTime(OrdersLocal.CreationDate.CurrentValue, 9)
		OrdersLocal.OrderDate.CurrentValue = OrdersLocal.OrderDate.FormValue
		OrdersLocal.OrderDate.CurrentValue = ew_UnFormatDateTime(OrdersLocal.OrderDate.CurrentValue, 9)
		OrdersLocal.DeliveryType.CurrentValue = OrdersLocal.DeliveryType.FormValue
		OrdersLocal.DeliveryTime.CurrentValue = OrdersLocal.DeliveryTime.FormValue
		OrdersLocal.DeliveryTime.CurrentValue = ew_UnFormatDateTime(OrdersLocal.DeliveryTime.CurrentValue, 9)
		OrdersLocal.PaymentType.CurrentValue = OrdersLocal.PaymentType.FormValue
		OrdersLocal.SubTotal.CurrentValue = OrdersLocal.SubTotal.FormValue
		OrdersLocal.ShippingFee.CurrentValue = OrdersLocal.ShippingFee.FormValue
		OrdersLocal.OrderTotal.CurrentValue = OrdersLocal.OrderTotal.FormValue
		OrdersLocal.IdBusinessDetail.CurrentValue = OrdersLocal.IdBusinessDetail.FormValue
		OrdersLocal.SessionId.CurrentValue = OrdersLocal.SessionId.FormValue
		OrdersLocal.FirstName.CurrentValue = OrdersLocal.FirstName.FormValue
		OrdersLocal.LastName.CurrentValue = OrdersLocal.LastName.FormValue
		OrdersLocal.zEmail.CurrentValue = OrdersLocal.zEmail.FormValue
		OrdersLocal.Phone.CurrentValue = OrdersLocal.Phone.FormValue
		OrdersLocal.Address.CurrentValue = OrdersLocal.Address.FormValue
		OrdersLocal.PostalCode.CurrentValue = OrdersLocal.PostalCode.FormValue
		OrdersLocal.Notes.CurrentValue = OrdersLocal.Notes.FormValue
		OrdersLocal.ttest.CurrentValue = OrdersLocal.ttest.FormValue
		OrdersLocal.cancelleddate.CurrentValue = OrdersLocal.cancelleddate.FormValue
		OrdersLocal.cancelleddate.CurrentValue = ew_UnFormatDateTime(OrdersLocal.cancelleddate.CurrentValue, 9)
		OrdersLocal.cancelledby.CurrentValue = OrdersLocal.cancelledby.FormValue
		OrdersLocal.cancelledreason.CurrentValue = OrdersLocal.cancelledreason.FormValue
		OrdersLocal.acknowledgeddate.CurrentValue = OrdersLocal.acknowledgeddate.FormValue
		OrdersLocal.acknowledgeddate.CurrentValue = ew_UnFormatDateTime(OrdersLocal.acknowledgeddate.CurrentValue, 9)
		OrdersLocal.delivereddate.CurrentValue = OrdersLocal.delivereddate.FormValue
		OrdersLocal.cancelled.CurrentValue = OrdersLocal.cancelled.FormValue
		OrdersLocal.acknowledged.CurrentValue = OrdersLocal.acknowledged.FormValue
		OrdersLocal.outfordelivery.CurrentValue = OrdersLocal.outfordelivery.FormValue
		OrdersLocal.vouchercodediscount.CurrentValue = OrdersLocal.vouchercodediscount.FormValue
		OrdersLocal.vouchercode.CurrentValue = OrdersLocal.vouchercode.FormValue
		OrdersLocal.printed.CurrentValue = OrdersLocal.printed.FormValue
		OrdersLocal.deliverydistance.CurrentValue = OrdersLocal.deliverydistance.FormValue
		OrdersLocal.asaporder.CurrentValue = OrdersLocal.asaporder.FormValue
		OrdersLocal.DeliveryLat.CurrentValue = OrdersLocal.DeliveryLat.FormValue
		OrdersLocal.DeliveryLng.CurrentValue = OrdersLocal.DeliveryLng.FormValue
		OrdersLocal.ServiceCharge.CurrentValue = OrdersLocal.ServiceCharge.FormValue
		OrdersLocal.PaymentSurcharge.CurrentValue = OrdersLocal.PaymentSurcharge.FormValue
		OrdersLocal.Tax_Rate.CurrentValue = OrdersLocal.Tax_Rate.FormValue
		OrdersLocal.Tax_Amount.CurrentValue = OrdersLocal.Tax_Amount.FormValue
		OrdersLocal.Tip_Rate.CurrentValue = OrdersLocal.Tip_Rate.FormValue
		OrdersLocal.Tip_Amount.CurrentValue = OrdersLocal.Tip_Amount.FormValue
		OrdersLocal.paymentstatus.CurrentValue = OrdersLocal.paymentstatus.FormValue
		OrdersLocal.Payment_Status.CurrentValue = OrdersLocal.Payment_Status.FormValue
		OrdersLocal.ID.CurrentValue = OrdersLocal.ID.FormValue
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
		OrdersLocal.paymentstatus.DbValue = RsRow("paymentstatus")
		OrdersLocal.Payment_Status.DbValue = RsRow("Payment_Status")
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
		OrdersLocal.paymentstatus.m_DbValue = Rs("paymentstatus")
		OrdersLocal.Payment_Status.m_DbValue = Rs("Payment_Status")
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
		' paymentstatus
		' Payment_Status
		' -----------
		'  View  Row
		' -----------

		If OrdersLocal.RowType = EW_ROWTYPE_VIEW Then ' View row

			' ID
			OrdersLocal.ID.ViewValue = OrdersLocal.ID.CurrentValue
			OrdersLocal.ID.ViewCustomAttributes = ""

			' CreationDate
			OrdersLocal.CreationDate.ViewValue = OrdersLocal.CreationDate.CurrentValue
			OrdersLocal.CreationDate.ViewValue = ew_FormatDateTime(OrdersLocal.CreationDate.ViewValue, 9)
			OrdersLocal.CreationDate.ViewCustomAttributes = ""

			' OrderDate
			OrdersLocal.OrderDate.ViewValue = OrdersLocal.OrderDate.CurrentValue
			OrdersLocal.OrderDate.ViewValue = ew_FormatDateTime(OrdersLocal.OrderDate.ViewValue, 9)
			OrdersLocal.OrderDate.ViewCustomAttributes = ""

			' DeliveryType
			OrdersLocal.DeliveryType.ViewValue = OrdersLocal.DeliveryType.CurrentValue
			OrdersLocal.DeliveryType.ViewCustomAttributes = ""

			' DeliveryTime
			OrdersLocal.DeliveryTime.ViewValue = OrdersLocal.DeliveryTime.CurrentValue
			OrdersLocal.DeliveryTime.ViewValue = ew_FormatDateTime(OrdersLocal.DeliveryTime.ViewValue, 9)
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
			OrdersLocal.cancelleddate.ViewValue = ew_FormatDateTime(OrdersLocal.cancelleddate.ViewValue, 9)
			OrdersLocal.cancelleddate.ViewCustomAttributes = ""

			' cancelledby
			OrdersLocal.cancelledby.ViewValue = OrdersLocal.cancelledby.CurrentValue
			OrdersLocal.cancelledby.ViewCustomAttributes = ""

			' cancelledreason
			OrdersLocal.cancelledreason.ViewValue = OrdersLocal.cancelledreason.CurrentValue
			OrdersLocal.cancelledreason.ViewCustomAttributes = ""

			' acknowledgeddate
			OrdersLocal.acknowledgeddate.ViewValue = OrdersLocal.acknowledgeddate.CurrentValue
			OrdersLocal.acknowledgeddate.ViewValue = ew_FormatDateTime(OrdersLocal.acknowledgeddate.ViewValue, 9)
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

			' paymentstatus
			OrdersLocal.paymentstatus.ViewValue = OrdersLocal.paymentstatus.CurrentValue
			OrdersLocal.paymentstatus.ViewCustomAttributes = ""

			' Payment_Status
			OrdersLocal.Payment_Status.ViewValue = OrdersLocal.Payment_Status.CurrentValue
			OrdersLocal.Payment_Status.ViewCustomAttributes = ""

			' View refer script
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

			' paymentstatus
			OrdersLocal.paymentstatus.LinkCustomAttributes = ""
			OrdersLocal.paymentstatus.HrefValue = ""
			OrdersLocal.paymentstatus.TooltipValue = ""

			' Payment_Status
			OrdersLocal.Payment_Status.LinkCustomAttributes = ""
			OrdersLocal.Payment_Status.HrefValue = ""
			OrdersLocal.Payment_Status.TooltipValue = ""

		' ----------
		'  Edit Row
		' ----------

		ElseIf OrdersLocal.RowType = EW_ROWTYPE_EDIT Then ' Edit row

			' CreationDate
			OrdersLocal.CreationDate.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.CreationDate.EditCustomAttributes = ""
			OrdersLocal.CreationDate.EditValue = ew_FormatDateTime(OrdersLocal.CreationDate.CurrentValue, 9)
			OrdersLocal.CreationDate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.CreationDate.FldCaption))

			' OrderDate
			OrdersLocal.OrderDate.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.OrderDate.EditCustomAttributes = ""
			OrdersLocal.OrderDate.EditValue = ew_FormatDateTime(OrdersLocal.OrderDate.CurrentValue, 9)
			OrdersLocal.OrderDate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.OrderDate.FldCaption))

			' DeliveryType
			OrdersLocal.DeliveryType.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.DeliveryType.EditCustomAttributes = ""
			OrdersLocal.DeliveryType.EditValue = ew_HtmlEncode(OrdersLocal.DeliveryType.CurrentValue)
			OrdersLocal.DeliveryType.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.DeliveryType.FldCaption))

			' DeliveryTime
			OrdersLocal.DeliveryTime.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.DeliveryTime.EditCustomAttributes = ""
			OrdersLocal.DeliveryTime.EditValue = ew_FormatDateTime(OrdersLocal.DeliveryTime.CurrentValue, 9)
			OrdersLocal.DeliveryTime.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.DeliveryTime.FldCaption))

			' PaymentType
			OrdersLocal.PaymentType.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.PaymentType.EditCustomAttributes = ""
			OrdersLocal.PaymentType.EditValue = ew_HtmlEncode(OrdersLocal.PaymentType.CurrentValue)
			OrdersLocal.PaymentType.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.PaymentType.FldCaption))

			' SubTotal
			OrdersLocal.SubTotal.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.SubTotal.EditCustomAttributes = ""
			OrdersLocal.SubTotal.EditValue = ew_HtmlEncode(OrdersLocal.SubTotal.CurrentValue)
			OrdersLocal.SubTotal.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.SubTotal.FldCaption))
			If OrdersLocal.SubTotal.EditValue&"" <> "" And IsNumeric(OrdersLocal.SubTotal.EditValue) Then OrdersLocal.SubTotal.EditValue = ew_FormatNumber2(OrdersLocal.SubTotal.EditValue, -2)

			' ShippingFee
			OrdersLocal.ShippingFee.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.ShippingFee.EditCustomAttributes = ""
			OrdersLocal.ShippingFee.EditValue = ew_HtmlEncode(OrdersLocal.ShippingFee.CurrentValue)
			OrdersLocal.ShippingFee.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.ShippingFee.FldCaption))
			If OrdersLocal.ShippingFee.EditValue&"" <> "" And IsNumeric(OrdersLocal.ShippingFee.EditValue) Then OrdersLocal.ShippingFee.EditValue = ew_FormatNumber2(OrdersLocal.ShippingFee.EditValue, -2)

			' OrderTotal
			OrdersLocal.OrderTotal.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.OrderTotal.EditCustomAttributes = ""
			OrdersLocal.OrderTotal.EditValue = ew_HtmlEncode(OrdersLocal.OrderTotal.CurrentValue)
			OrdersLocal.OrderTotal.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.OrderTotal.FldCaption))
			If OrdersLocal.OrderTotal.EditValue&"" <> "" And IsNumeric(OrdersLocal.OrderTotal.EditValue) Then OrdersLocal.OrderTotal.EditValue = ew_FormatNumber2(OrdersLocal.OrderTotal.EditValue, -2)

			' IdBusinessDetail
			OrdersLocal.IdBusinessDetail.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.IdBusinessDetail.EditCustomAttributes = ""
			OrdersLocal.IdBusinessDetail.EditValue = ew_HtmlEncode(OrdersLocal.IdBusinessDetail.CurrentValue)
			OrdersLocal.IdBusinessDetail.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.IdBusinessDetail.FldCaption))

			' SessionId
			OrdersLocal.SessionId.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.SessionId.EditCustomAttributes = ""
			OrdersLocal.SessionId.EditValue = ew_HtmlEncode(OrdersLocal.SessionId.CurrentValue)
			OrdersLocal.SessionId.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.SessionId.FldCaption))

			' FirstName
			OrdersLocal.FirstName.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.FirstName.EditCustomAttributes = ""
			OrdersLocal.FirstName.EditValue = ew_HtmlEncode(OrdersLocal.FirstName.CurrentValue)
			OrdersLocal.FirstName.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.FirstName.FldCaption))

			' LastName
			OrdersLocal.LastName.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.LastName.EditCustomAttributes = ""
			OrdersLocal.LastName.EditValue = ew_HtmlEncode(OrdersLocal.LastName.CurrentValue)
			OrdersLocal.LastName.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.LastName.FldCaption))

			' Email
			OrdersLocal.zEmail.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.zEmail.EditCustomAttributes = ""
			OrdersLocal.zEmail.EditValue = ew_HtmlEncode(OrdersLocal.zEmail.CurrentValue)
			OrdersLocal.zEmail.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.zEmail.FldCaption))

			' Phone
			OrdersLocal.Phone.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.Phone.EditCustomAttributes = ""
			OrdersLocal.Phone.EditValue = ew_HtmlEncode(OrdersLocal.Phone.CurrentValue)
			OrdersLocal.Phone.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.Phone.FldCaption))

			' Address
			OrdersLocal.Address.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.Address.EditCustomAttributes = ""
			OrdersLocal.Address.EditValue = ew_HtmlEncode(OrdersLocal.Address.CurrentValue)
			OrdersLocal.Address.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.Address.FldCaption))

			' PostalCode
			OrdersLocal.PostalCode.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.PostalCode.EditCustomAttributes = ""
			OrdersLocal.PostalCode.EditValue = ew_HtmlEncode(OrdersLocal.PostalCode.CurrentValue)
			OrdersLocal.PostalCode.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.PostalCode.FldCaption))

			' Notes
			OrdersLocal.Notes.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.Notes.EditCustomAttributes = ""
			OrdersLocal.Notes.EditValue = ew_HtmlEncode(OrdersLocal.Notes.CurrentValue)
			OrdersLocal.Notes.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.Notes.FldCaption))

			' ttest
			OrdersLocal.ttest.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.ttest.EditCustomAttributes = ""
			OrdersLocal.ttest.EditValue = ew_HtmlEncode(OrdersLocal.ttest.CurrentValue)
			OrdersLocal.ttest.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.ttest.FldCaption))

			' cancelleddate
			OrdersLocal.cancelleddate.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.cancelleddate.EditCustomAttributes = ""
			OrdersLocal.cancelleddate.EditValue = ew_FormatDateTime(OrdersLocal.cancelleddate.CurrentValue, 9)
			OrdersLocal.cancelleddate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.cancelleddate.FldCaption))

			' cancelledby
			OrdersLocal.cancelledby.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.cancelledby.EditCustomAttributes = ""
			OrdersLocal.cancelledby.EditValue = ew_HtmlEncode(OrdersLocal.cancelledby.CurrentValue)
			OrdersLocal.cancelledby.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.cancelledby.FldCaption))

			' cancelledreason
			OrdersLocal.cancelledreason.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.cancelledreason.EditCustomAttributes = ""
			OrdersLocal.cancelledreason.EditValue = ew_HtmlEncode(OrdersLocal.cancelledreason.CurrentValue)
			OrdersLocal.cancelledreason.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.cancelledreason.FldCaption))

			' acknowledgeddate
			OrdersLocal.acknowledgeddate.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.acknowledgeddate.EditCustomAttributes = ""
			OrdersLocal.acknowledgeddate.EditValue = ew_FormatDateTime(OrdersLocal.acknowledgeddate.CurrentValue, 9)
			OrdersLocal.acknowledgeddate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.acknowledgeddate.FldCaption))

			' delivereddate
			OrdersLocal.delivereddate.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.delivereddate.EditCustomAttributes = ""
			OrdersLocal.delivereddate.EditValue = ew_HtmlEncode(OrdersLocal.delivereddate.CurrentValue)
			OrdersLocal.delivereddate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.delivereddate.FldCaption))

			' cancelled
			OrdersLocal.cancelled.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.cancelled.EditCustomAttributes = ""
			OrdersLocal.cancelled.EditValue = ew_HtmlEncode(OrdersLocal.cancelled.CurrentValue)
			OrdersLocal.cancelled.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.cancelled.FldCaption))

			' acknowledged
			OrdersLocal.acknowledged.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.acknowledged.EditCustomAttributes = ""
			OrdersLocal.acknowledged.EditValue = ew_HtmlEncode(OrdersLocal.acknowledged.CurrentValue)
			OrdersLocal.acknowledged.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.acknowledged.FldCaption))

			' outfordelivery
			OrdersLocal.outfordelivery.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.outfordelivery.EditCustomAttributes = ""
			OrdersLocal.outfordelivery.EditValue = ew_HtmlEncode(OrdersLocal.outfordelivery.CurrentValue)
			OrdersLocal.outfordelivery.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.outfordelivery.FldCaption))

			' vouchercodediscount
			OrdersLocal.vouchercodediscount.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.vouchercodediscount.EditCustomAttributes = ""
			OrdersLocal.vouchercodediscount.EditValue = ew_HtmlEncode(OrdersLocal.vouchercodediscount.CurrentValue)
			OrdersLocal.vouchercodediscount.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.vouchercodediscount.FldCaption))

			' vouchercode
			OrdersLocal.vouchercode.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.vouchercode.EditCustomAttributes = ""
			OrdersLocal.vouchercode.EditValue = ew_HtmlEncode(OrdersLocal.vouchercode.CurrentValue)
			OrdersLocal.vouchercode.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.vouchercode.FldCaption))

			' printed
			OrdersLocal.printed.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.printed.EditCustomAttributes = ""
			OrdersLocal.printed.EditValue = ew_HtmlEncode(OrdersLocal.printed.CurrentValue)
			OrdersLocal.printed.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.printed.FldCaption))

			' deliverydistance
			OrdersLocal.deliverydistance.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.deliverydistance.EditCustomAttributes = ""
			OrdersLocal.deliverydistance.EditValue = ew_HtmlEncode(OrdersLocal.deliverydistance.CurrentValue)
			OrdersLocal.deliverydistance.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.deliverydistance.FldCaption))

			' asaporder
			OrdersLocal.asaporder.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.asaporder.EditCustomAttributes = ""
			OrdersLocal.asaporder.EditValue = ew_HtmlEncode(OrdersLocal.asaporder.CurrentValue)
			OrdersLocal.asaporder.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.asaporder.FldCaption))

			' DeliveryLat
			OrdersLocal.DeliveryLat.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.DeliveryLat.EditCustomAttributes = ""
			OrdersLocal.DeliveryLat.EditValue = ew_HtmlEncode(OrdersLocal.DeliveryLat.CurrentValue)
			OrdersLocal.DeliveryLat.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.DeliveryLat.FldCaption))

			' DeliveryLng
			OrdersLocal.DeliveryLng.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.DeliveryLng.EditCustomAttributes = ""
			OrdersLocal.DeliveryLng.EditValue = ew_HtmlEncode(OrdersLocal.DeliveryLng.CurrentValue)
			OrdersLocal.DeliveryLng.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.DeliveryLng.FldCaption))

			' ServiceCharge
			OrdersLocal.ServiceCharge.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.ServiceCharge.EditCustomAttributes = ""
			OrdersLocal.ServiceCharge.EditValue = ew_HtmlEncode(OrdersLocal.ServiceCharge.CurrentValue)
			OrdersLocal.ServiceCharge.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.ServiceCharge.FldCaption))
			If OrdersLocal.ServiceCharge.EditValue&"" <> "" And IsNumeric(OrdersLocal.ServiceCharge.EditValue) Then OrdersLocal.ServiceCharge.EditValue = ew_FormatNumber2(OrdersLocal.ServiceCharge.EditValue, -2)

			' PaymentSurcharge
			OrdersLocal.PaymentSurcharge.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.PaymentSurcharge.EditCustomAttributes = ""
			OrdersLocal.PaymentSurcharge.EditValue = ew_HtmlEncode(OrdersLocal.PaymentSurcharge.CurrentValue)
			OrdersLocal.PaymentSurcharge.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.PaymentSurcharge.FldCaption))
			If OrdersLocal.PaymentSurcharge.EditValue&"" <> "" And IsNumeric(OrdersLocal.PaymentSurcharge.EditValue) Then OrdersLocal.PaymentSurcharge.EditValue = ew_FormatNumber2(OrdersLocal.PaymentSurcharge.EditValue, -2)

			' Tax_Rate
			OrdersLocal.Tax_Rate.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.Tax_Rate.EditCustomAttributes = ""
			OrdersLocal.Tax_Rate.EditValue = ew_HtmlEncode(OrdersLocal.Tax_Rate.CurrentValue)
			OrdersLocal.Tax_Rate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.Tax_Rate.FldCaption))

			' Tax_Amount
			OrdersLocal.Tax_Amount.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.Tax_Amount.EditCustomAttributes = ""
			OrdersLocal.Tax_Amount.EditValue = ew_HtmlEncode(OrdersLocal.Tax_Amount.CurrentValue)
			OrdersLocal.Tax_Amount.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.Tax_Amount.FldCaption))
			If OrdersLocal.Tax_Amount.EditValue&"" <> "" And IsNumeric(OrdersLocal.Tax_Amount.EditValue) Then OrdersLocal.Tax_Amount.EditValue = ew_FormatNumber2(OrdersLocal.Tax_Amount.EditValue, -2)

			' Tip_Rate
			OrdersLocal.Tip_Rate.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.Tip_Rate.EditCustomAttributes = ""
			OrdersLocal.Tip_Rate.EditValue = ew_HtmlEncode(OrdersLocal.Tip_Rate.CurrentValue)
			OrdersLocal.Tip_Rate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.Tip_Rate.FldCaption))

			' Tip_Amount
			OrdersLocal.Tip_Amount.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.Tip_Amount.EditCustomAttributes = ""
			OrdersLocal.Tip_Amount.EditValue = ew_HtmlEncode(OrdersLocal.Tip_Amount.CurrentValue)
			OrdersLocal.Tip_Amount.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.Tip_Amount.FldCaption))
			If OrdersLocal.Tip_Amount.EditValue&"" <> "" And IsNumeric(OrdersLocal.Tip_Amount.EditValue) Then OrdersLocal.Tip_Amount.EditValue = ew_FormatNumber2(OrdersLocal.Tip_Amount.EditValue, -2)

			' paymentstatus
			OrdersLocal.paymentstatus.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.paymentstatus.EditCustomAttributes = ""
			OrdersLocal.paymentstatus.EditValue = ew_HtmlEncode(OrdersLocal.paymentstatus.CurrentValue)
			OrdersLocal.paymentstatus.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.paymentstatus.FldCaption))

			' Payment_Status
			OrdersLocal.Payment_Status.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.Payment_Status.EditCustomAttributes = ""
			OrdersLocal.Payment_Status.EditValue = ew_HtmlEncode(OrdersLocal.Payment_Status.CurrentValue)
			OrdersLocal.Payment_Status.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.Payment_Status.FldCaption))

			' Edit refer script
			' CreationDate

			OrdersLocal.CreationDate.HrefValue = ""

			' OrderDate
			OrdersLocal.OrderDate.HrefValue = ""

			' DeliveryType
			OrdersLocal.DeliveryType.HrefValue = ""

			' DeliveryTime
			OrdersLocal.DeliveryTime.HrefValue = ""

			' PaymentType
			OrdersLocal.PaymentType.HrefValue = ""

			' SubTotal
			OrdersLocal.SubTotal.HrefValue = ""

			' ShippingFee
			OrdersLocal.ShippingFee.HrefValue = ""

			' OrderTotal
			OrdersLocal.OrderTotal.HrefValue = ""

			' IdBusinessDetail
			OrdersLocal.IdBusinessDetail.HrefValue = ""

			' SessionId
			OrdersLocal.SessionId.HrefValue = ""

			' FirstName
			OrdersLocal.FirstName.HrefValue = ""

			' LastName
			OrdersLocal.LastName.HrefValue = ""

			' Email
			OrdersLocal.zEmail.HrefValue = ""

			' Phone
			OrdersLocal.Phone.HrefValue = ""

			' Address
			OrdersLocal.Address.HrefValue = ""

			' PostalCode
			OrdersLocal.PostalCode.HrefValue = ""

			' Notes
			OrdersLocal.Notes.HrefValue = ""

			' ttest
			OrdersLocal.ttest.HrefValue = ""

			' cancelleddate
			OrdersLocal.cancelleddate.HrefValue = ""

			' cancelledby
			OrdersLocal.cancelledby.HrefValue = ""

			' cancelledreason
			OrdersLocal.cancelledreason.HrefValue = ""

			' acknowledgeddate
			OrdersLocal.acknowledgeddate.HrefValue = ""

			' delivereddate
			OrdersLocal.delivereddate.HrefValue = ""

			' cancelled
			OrdersLocal.cancelled.HrefValue = ""

			' acknowledged
			OrdersLocal.acknowledged.HrefValue = ""

			' outfordelivery
			OrdersLocal.outfordelivery.HrefValue = ""

			' vouchercodediscount
			OrdersLocal.vouchercodediscount.HrefValue = ""

			' vouchercode
			OrdersLocal.vouchercode.HrefValue = ""

			' printed
			OrdersLocal.printed.HrefValue = ""

			' deliverydistance
			OrdersLocal.deliverydistance.HrefValue = ""

			' asaporder
			OrdersLocal.asaporder.HrefValue = ""

			' DeliveryLat
			OrdersLocal.DeliveryLat.HrefValue = ""

			' DeliveryLng
			OrdersLocal.DeliveryLng.HrefValue = ""

			' ServiceCharge
			OrdersLocal.ServiceCharge.HrefValue = ""

			' PaymentSurcharge
			OrdersLocal.PaymentSurcharge.HrefValue = ""

			' Tax_Rate
			OrdersLocal.Tax_Rate.HrefValue = ""

			' Tax_Amount
			OrdersLocal.Tax_Amount.HrefValue = ""

			' Tip_Rate
			OrdersLocal.Tip_Rate.HrefValue = ""

			' Tip_Amount
			OrdersLocal.Tip_Amount.HrefValue = ""

			' paymentstatus
			OrdersLocal.paymentstatus.HrefValue = ""

			' Payment_Status
			OrdersLocal.Payment_Status.HrefValue = ""
		End If
		If OrdersLocal.RowType = EW_ROWTYPE_ADD Or OrdersLocal.RowType = EW_ROWTYPE_EDIT Or OrdersLocal.RowType = EW_ROWTYPE_SEARCH Then ' Add / Edit / Search row
			Call OrdersLocal.SetupFieldTitles()
		End If

		' Call Row Rendered event
		If OrdersLocal.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call OrdersLocal.Row_Rendered()
		End If
	End Sub

	' -----------------------------------------------------------------
	' Validate form
	'
	Function ValidateForm()

		' Initialize
		gsFormError = ""
		Dim lUpdateCnt
		lUpdateCnt = 0
		If OrdersLocal.CreationDate.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrdersLocal.OrderDate.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrdersLocal.DeliveryType.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrdersLocal.DeliveryTime.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrdersLocal.PaymentType.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrdersLocal.SubTotal.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrdersLocal.ShippingFee.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrdersLocal.OrderTotal.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrdersLocal.IdBusinessDetail.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrdersLocal.SessionId.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrdersLocal.FirstName.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrdersLocal.LastName.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrdersLocal.zEmail.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrdersLocal.Phone.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrdersLocal.Address.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrdersLocal.PostalCode.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrdersLocal.Notes.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrdersLocal.ttest.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrdersLocal.cancelleddate.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrdersLocal.cancelledby.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrdersLocal.cancelledreason.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrdersLocal.acknowledgeddate.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrdersLocal.delivereddate.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrdersLocal.cancelled.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrdersLocal.acknowledged.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrdersLocal.outfordelivery.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrdersLocal.vouchercodediscount.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrdersLocal.vouchercode.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrdersLocal.printed.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrdersLocal.deliverydistance.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrdersLocal.asaporder.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrdersLocal.DeliveryLat.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrdersLocal.DeliveryLng.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrdersLocal.ServiceCharge.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrdersLocal.PaymentSurcharge.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrdersLocal.Tax_Rate.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrdersLocal.Tax_Amount.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrdersLocal.Tip_Rate.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrdersLocal.Tip_Amount.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrdersLocal.paymentstatus.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If OrdersLocal.Payment_Status.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If lUpdateCnt = 0 Then
			gsFormError = Language.Phrase("NoFieldSelected")
			ValidateForm = False
			Exit Function
		End If

		' Check if validation required
		If Not EW_SERVER_VALIDATE Then
			ValidateForm = (gsFormError = "")
			Exit Function
		End If
		If OrdersLocal.CreationDate.MultiUpdate <> "" Then
			If Not ew_CheckDate(OrdersLocal.CreationDate.FormValue) Then
				Call ew_AddMessage(gsFormError, OrdersLocal.CreationDate.FldErrMsg)
			End If
		End If
		If OrdersLocal.OrderDate.MultiUpdate <> "" Then
			If Not ew_CheckDate(OrdersLocal.OrderDate.FormValue) Then
				Call ew_AddMessage(gsFormError, OrdersLocal.OrderDate.FldErrMsg)
			End If
		End If
		If OrdersLocal.DeliveryTime.MultiUpdate <> "" Then
			If Not ew_CheckDate(OrdersLocal.DeliveryTime.FormValue) Then
				Call ew_AddMessage(gsFormError, OrdersLocal.DeliveryTime.FldErrMsg)
			End If
		End If
		If OrdersLocal.SubTotal.MultiUpdate <> "" Then
			If Not ew_CheckNumber(OrdersLocal.SubTotal.FormValue) Then
				Call ew_AddMessage(gsFormError, OrdersLocal.SubTotal.FldErrMsg)
			End If
		End If
		If OrdersLocal.ShippingFee.MultiUpdate <> "" Then
			If Not ew_CheckNumber(OrdersLocal.ShippingFee.FormValue) Then
				Call ew_AddMessage(gsFormError, OrdersLocal.ShippingFee.FldErrMsg)
			End If
		End If
		If OrdersLocal.OrderTotal.MultiUpdate <> "" Then
			If Not ew_CheckNumber(OrdersLocal.OrderTotal.FormValue) Then
				Call ew_AddMessage(gsFormError, OrdersLocal.OrderTotal.FldErrMsg)
			End If
		End If
		If OrdersLocal.IdBusinessDetail.MultiUpdate <> "" Then
			If Not ew_CheckInteger(OrdersLocal.IdBusinessDetail.FormValue) Then
				Call ew_AddMessage(gsFormError, OrdersLocal.IdBusinessDetail.FldErrMsg)
			End If
		End If
		If OrdersLocal.cancelleddate.MultiUpdate <> "" Then
			If Not ew_CheckDate(OrdersLocal.cancelleddate.FormValue) Then
				Call ew_AddMessage(gsFormError, OrdersLocal.cancelleddate.FldErrMsg)
			End If
		End If
		If OrdersLocal.acknowledgeddate.MultiUpdate <> "" Then
			If Not ew_CheckDate(OrdersLocal.acknowledgeddate.FormValue) Then
				Call ew_AddMessage(gsFormError, OrdersLocal.acknowledgeddate.FldErrMsg)
			End If
		End If
		If OrdersLocal.cancelled.MultiUpdate <> "" Then
			If Not ew_CheckInteger(OrdersLocal.cancelled.FormValue) Then
				Call ew_AddMessage(gsFormError, OrdersLocal.cancelled.FldErrMsg)
			End If
		End If
		If OrdersLocal.acknowledged.MultiUpdate <> "" Then
			If Not ew_CheckInteger(OrdersLocal.acknowledged.FormValue) Then
				Call ew_AddMessage(gsFormError, OrdersLocal.acknowledged.FldErrMsg)
			End If
		End If
		If OrdersLocal.outfordelivery.MultiUpdate <> "" Then
			If Not ew_CheckInteger(OrdersLocal.outfordelivery.FormValue) Then
				Call ew_AddMessage(gsFormError, OrdersLocal.outfordelivery.FldErrMsg)
			End If
		End If
		If OrdersLocal.vouchercodediscount.MultiUpdate <> "" Then
			If Not ew_CheckInteger(OrdersLocal.vouchercodediscount.FormValue) Then
				Call ew_AddMessage(gsFormError, OrdersLocal.vouchercodediscount.FldErrMsg)
			End If
		End If
		If OrdersLocal.printed.MultiUpdate <> "" Then
			If Not ew_CheckInteger(OrdersLocal.printed.FormValue) Then
				Call ew_AddMessage(gsFormError, OrdersLocal.printed.FldErrMsg)
			End If
		End If
		If OrdersLocal.ServiceCharge.MultiUpdate <> "" Then
			If Not ew_CheckNumber(OrdersLocal.ServiceCharge.FormValue) Then
				Call ew_AddMessage(gsFormError, OrdersLocal.ServiceCharge.FldErrMsg)
			End If
		End If
		If OrdersLocal.PaymentSurcharge.MultiUpdate <> "" Then
			If Not ew_CheckNumber(OrdersLocal.PaymentSurcharge.FormValue) Then
				Call ew_AddMessage(gsFormError, OrdersLocal.PaymentSurcharge.FldErrMsg)
			End If
		End If
		If OrdersLocal.Tax_Rate.MultiUpdate <> "" Then
			If Not ew_CheckInteger(OrdersLocal.Tax_Rate.FormValue) Then
				Call ew_AddMessage(gsFormError, OrdersLocal.Tax_Rate.FldErrMsg)
			End If
		End If
		If OrdersLocal.Tax_Amount.MultiUpdate <> "" Then
			If Not ew_CheckNumber(OrdersLocal.Tax_Amount.FormValue) Then
				Call ew_AddMessage(gsFormError, OrdersLocal.Tax_Amount.FldErrMsg)
			End If
		End If
		If OrdersLocal.Tip_Amount.MultiUpdate <> "" Then
			If Not ew_CheckNumber(OrdersLocal.Tip_Amount.FormValue) Then
				Call ew_AddMessage(gsFormError, OrdersLocal.Tip_Amount.FldErrMsg)
			End If
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
		sFilter = OrdersLocal.KeyFilter
		OrdersLocal.CurrentFilter  = sFilter
		sSql = OrdersLocal.SQL
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
			Call OrdersLocal.CreationDate.SetDbValue(Rs, ew_UnFormatDateTime(OrdersLocal.CreationDate.CurrentValue, 9), Null, OrdersLocal.CreationDate.ReadOnly Or OrdersLocal.CreationDate.MultiUpdate&"" <> "1")

			' Field OrderDate
			Call OrdersLocal.OrderDate.SetDbValue(Rs, ew_UnFormatDateTime(OrdersLocal.OrderDate.CurrentValue, 9), Null, OrdersLocal.OrderDate.ReadOnly Or OrdersLocal.OrderDate.MultiUpdate&"" <> "1")

			' Field DeliveryType
			Call OrdersLocal.DeliveryType.SetDbValue(Rs, OrdersLocal.DeliveryType.CurrentValue, Null, OrdersLocal.DeliveryType.ReadOnly Or OrdersLocal.DeliveryType.MultiUpdate&"" <> "1")

			' Field DeliveryTime
			Call OrdersLocal.DeliveryTime.SetDbValue(Rs, ew_UnFormatDateTime(OrdersLocal.DeliveryTime.CurrentValue, 9), Null, OrdersLocal.DeliveryTime.ReadOnly Or OrdersLocal.DeliveryTime.MultiUpdate&"" <> "1")

			' Field PaymentType
			Call OrdersLocal.PaymentType.SetDbValue(Rs, OrdersLocal.PaymentType.CurrentValue, Null, OrdersLocal.PaymentType.ReadOnly Or OrdersLocal.PaymentType.MultiUpdate&"" <> "1")

			' Field SubTotal
			Call OrdersLocal.SubTotal.SetDbValue(Rs, OrdersLocal.SubTotal.CurrentValue, Null, OrdersLocal.SubTotal.ReadOnly Or OrdersLocal.SubTotal.MultiUpdate&"" <> "1")

			' Field ShippingFee
			Call OrdersLocal.ShippingFee.SetDbValue(Rs, OrdersLocal.ShippingFee.CurrentValue, Null, OrdersLocal.ShippingFee.ReadOnly Or OrdersLocal.ShippingFee.MultiUpdate&"" <> "1")

			' Field OrderTotal
			Call OrdersLocal.OrderTotal.SetDbValue(Rs, OrdersLocal.OrderTotal.CurrentValue, Null, OrdersLocal.OrderTotal.ReadOnly Or OrdersLocal.OrderTotal.MultiUpdate&"" <> "1")

			' Field IdBusinessDetail
			Call OrdersLocal.IdBusinessDetail.SetDbValue(Rs, OrdersLocal.IdBusinessDetail.CurrentValue, Null, OrdersLocal.IdBusinessDetail.ReadOnly Or OrdersLocal.IdBusinessDetail.MultiUpdate&"" <> "1")

			' Field SessionId
			Call OrdersLocal.SessionId.SetDbValue(Rs, OrdersLocal.SessionId.CurrentValue, Null, OrdersLocal.SessionId.ReadOnly Or OrdersLocal.SessionId.MultiUpdate&"" <> "1")

			' Field FirstName
			Call OrdersLocal.FirstName.SetDbValue(Rs, OrdersLocal.FirstName.CurrentValue, Null, OrdersLocal.FirstName.ReadOnly Or OrdersLocal.FirstName.MultiUpdate&"" <> "1")

			' Field LastName
			Call OrdersLocal.LastName.SetDbValue(Rs, OrdersLocal.LastName.CurrentValue, Null, OrdersLocal.LastName.ReadOnly Or OrdersLocal.LastName.MultiUpdate&"" <> "1")

			' Field Email
			Call OrdersLocal.zEmail.SetDbValue(Rs, OrdersLocal.zEmail.CurrentValue, Null, OrdersLocal.zEmail.ReadOnly Or OrdersLocal.zEmail.MultiUpdate&"" <> "1")

			' Field Phone
			Call OrdersLocal.Phone.SetDbValue(Rs, OrdersLocal.Phone.CurrentValue, Null, OrdersLocal.Phone.ReadOnly Or OrdersLocal.Phone.MultiUpdate&"" <> "1")

			' Field Address
			Call OrdersLocal.Address.SetDbValue(Rs, OrdersLocal.Address.CurrentValue, Null, OrdersLocal.Address.ReadOnly Or OrdersLocal.Address.MultiUpdate&"" <> "1")

			' Field PostalCode
			Call OrdersLocal.PostalCode.SetDbValue(Rs, OrdersLocal.PostalCode.CurrentValue, Null, OrdersLocal.PostalCode.ReadOnly Or OrdersLocal.PostalCode.MultiUpdate&"" <> "1")

			' Field Notes
			Call OrdersLocal.Notes.SetDbValue(Rs, OrdersLocal.Notes.CurrentValue, Null, OrdersLocal.Notes.ReadOnly Or OrdersLocal.Notes.MultiUpdate&"" <> "1")

			' Field ttest
			Call OrdersLocal.ttest.SetDbValue(Rs, OrdersLocal.ttest.CurrentValue, Null, OrdersLocal.ttest.ReadOnly Or OrdersLocal.ttest.MultiUpdate&"" <> "1")

			' Field cancelleddate
			Call OrdersLocal.cancelleddate.SetDbValue(Rs, ew_UnFormatDateTime(OrdersLocal.cancelleddate.CurrentValue, 9), Null, OrdersLocal.cancelleddate.ReadOnly Or OrdersLocal.cancelleddate.MultiUpdate&"" <> "1")

			' Field cancelledby
			Call OrdersLocal.cancelledby.SetDbValue(Rs, OrdersLocal.cancelledby.CurrentValue, Null, OrdersLocal.cancelledby.ReadOnly Or OrdersLocal.cancelledby.MultiUpdate&"" <> "1")

			' Field cancelledreason
			Call OrdersLocal.cancelledreason.SetDbValue(Rs, OrdersLocal.cancelledreason.CurrentValue, Null, OrdersLocal.cancelledreason.ReadOnly Or OrdersLocal.cancelledreason.MultiUpdate&"" <> "1")

			' Field acknowledgeddate
			Call OrdersLocal.acknowledgeddate.SetDbValue(Rs, ew_UnFormatDateTime(OrdersLocal.acknowledgeddate.CurrentValue, 9), Null, OrdersLocal.acknowledgeddate.ReadOnly Or OrdersLocal.acknowledgeddate.MultiUpdate&"" <> "1")

			' Field delivereddate
			Call OrdersLocal.delivereddate.SetDbValue(Rs, OrdersLocal.delivereddate.CurrentValue, Null, OrdersLocal.delivereddate.ReadOnly Or OrdersLocal.delivereddate.MultiUpdate&"" <> "1")

			' Field cancelled
			Call OrdersLocal.cancelled.SetDbValue(Rs, OrdersLocal.cancelled.CurrentValue, Null, OrdersLocal.cancelled.ReadOnly Or OrdersLocal.cancelled.MultiUpdate&"" <> "1")

			' Field acknowledged
			Call OrdersLocal.acknowledged.SetDbValue(Rs, OrdersLocal.acknowledged.CurrentValue, Null, OrdersLocal.acknowledged.ReadOnly Or OrdersLocal.acknowledged.MultiUpdate&"" <> "1")

			' Field outfordelivery
			Call OrdersLocal.outfordelivery.SetDbValue(Rs, OrdersLocal.outfordelivery.CurrentValue, Null, OrdersLocal.outfordelivery.ReadOnly Or OrdersLocal.outfordelivery.MultiUpdate&"" <> "1")

			' Field vouchercodediscount
			Call OrdersLocal.vouchercodediscount.SetDbValue(Rs, OrdersLocal.vouchercodediscount.CurrentValue, Null, OrdersLocal.vouchercodediscount.ReadOnly Or OrdersLocal.vouchercodediscount.MultiUpdate&"" <> "1")

			' Field vouchercode
			Call OrdersLocal.vouchercode.SetDbValue(Rs, OrdersLocal.vouchercode.CurrentValue, Null, OrdersLocal.vouchercode.ReadOnly Or OrdersLocal.vouchercode.MultiUpdate&"" <> "1")

			' Field printed
			Call OrdersLocal.printed.SetDbValue(Rs, OrdersLocal.printed.CurrentValue, Null, OrdersLocal.printed.ReadOnly Or OrdersLocal.printed.MultiUpdate&"" <> "1")

			' Field deliverydistance
			Call OrdersLocal.deliverydistance.SetDbValue(Rs, OrdersLocal.deliverydistance.CurrentValue, Null, OrdersLocal.deliverydistance.ReadOnly Or OrdersLocal.deliverydistance.MultiUpdate&"" <> "1")

			' Field asaporder
			Call OrdersLocal.asaporder.SetDbValue(Rs, OrdersLocal.asaporder.CurrentValue, Null, OrdersLocal.asaporder.ReadOnly Or OrdersLocal.asaporder.MultiUpdate&"" <> "1")

			' Field DeliveryLat
			Call OrdersLocal.DeliveryLat.SetDbValue(Rs, OrdersLocal.DeliveryLat.CurrentValue, Null, OrdersLocal.DeliveryLat.ReadOnly Or OrdersLocal.DeliveryLat.MultiUpdate&"" <> "1")

			' Field DeliveryLng
			Call OrdersLocal.DeliveryLng.SetDbValue(Rs, OrdersLocal.DeliveryLng.CurrentValue, Null, OrdersLocal.DeliveryLng.ReadOnly Or OrdersLocal.DeliveryLng.MultiUpdate&"" <> "1")

			' Field ServiceCharge
			Call OrdersLocal.ServiceCharge.SetDbValue(Rs, OrdersLocal.ServiceCharge.CurrentValue, Null, OrdersLocal.ServiceCharge.ReadOnly Or OrdersLocal.ServiceCharge.MultiUpdate&"" <> "1")

			' Field PaymentSurcharge
			Call OrdersLocal.PaymentSurcharge.SetDbValue(Rs, OrdersLocal.PaymentSurcharge.CurrentValue, Null, OrdersLocal.PaymentSurcharge.ReadOnly Or OrdersLocal.PaymentSurcharge.MultiUpdate&"" <> "1")

			' Field Tax_Rate
			Call OrdersLocal.Tax_Rate.SetDbValue(Rs, OrdersLocal.Tax_Rate.CurrentValue, Null, OrdersLocal.Tax_Rate.ReadOnly Or OrdersLocal.Tax_Rate.MultiUpdate&"" <> "1")

			' Field Tax_Amount
			Call OrdersLocal.Tax_Amount.SetDbValue(Rs, OrdersLocal.Tax_Amount.CurrentValue, Null, OrdersLocal.Tax_Amount.ReadOnly Or OrdersLocal.Tax_Amount.MultiUpdate&"" <> "1")

			' Field Tip_Rate
			Call OrdersLocal.Tip_Rate.SetDbValue(Rs, OrdersLocal.Tip_Rate.CurrentValue, Null, OrdersLocal.Tip_Rate.ReadOnly Or OrdersLocal.Tip_Rate.MultiUpdate&"" <> "1")

			' Field Tip_Amount
			Call OrdersLocal.Tip_Amount.SetDbValue(Rs, OrdersLocal.Tip_Amount.CurrentValue, Null, OrdersLocal.Tip_Amount.ReadOnly Or OrdersLocal.Tip_Amount.MultiUpdate&"" <> "1")

			' Field paymentstatus
			Call OrdersLocal.paymentstatus.SetDbValue(Rs, OrdersLocal.paymentstatus.CurrentValue, Null, OrdersLocal.paymentstatus.ReadOnly Or OrdersLocal.paymentstatus.MultiUpdate&"" <> "1")

			' Field Payment_Status
			Call OrdersLocal.Payment_Status.SetDbValue(Rs, OrdersLocal.Payment_Status.CurrentValue, Null, OrdersLocal.Payment_Status.ReadOnly Or OrdersLocal.Payment_Status.MultiUpdate&"" <> "1")

			' Check recordset update error
			If Err.Number <> 0 Then
				FailureMessage = Err.Description
				Rs.Close
				Set Rs = Nothing
				EditRow = False
				Exit Function
			End If

			' Call Row Updating event
			bUpdateRow = OrdersLocal.Row_Updating(RsOld, Rs)
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
				ElseIf OrdersLocal.CancelMessage <> "" Then
					FailureMessage = OrdersLocal.CancelMessage
					OrdersLocal.CancelMessage = ""
				Else
					FailureMessage = Language.Phrase("UpdateCancelled")
				End If
				EditRow = False
			End If
		End If

		' Call Row Updated event
		If EditRow Then
			Call OrdersLocal.Row_Updated(RsOld, RsNew)
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
		Call Breadcrumb.Add("list", OrdersLocal.TableVar, "OrdersLocallist.asp", "", OrdersLocal.TableVar, True)
		PageId = "update"
		Call Breadcrumb.Add("update", PageId, url, "", "", False)
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
