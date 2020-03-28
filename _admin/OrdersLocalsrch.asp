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
Dim OrdersLocal_search
Set OrdersLocal_search = New cOrdersLocal_search
Set Page = OrdersLocal_search

' Page init processing
OrdersLocal_search.Page_Init()

' Page main processing
OrdersLocal_search.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
OrdersLocal_search.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var OrdersLocal_search = new ew_Page("OrdersLocal_search");
OrdersLocal_search.PageID = "search"; // Page ID
var EW_PAGE_ID = OrdersLocal_search.PageID; // For backward compatibility
// Form object
var fOrdersLocalsearch = new ew_Form("fOrdersLocalsearch");
// Form_CustomValidate event
fOrdersLocalsearch.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fOrdersLocalsearch.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fOrdersLocalsearch.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
// Validate function for search
fOrdersLocalsearch.Validate = function(fobj) {
	if (!this.ValidateRequired)
		return true; // Ignore validation
	fobj = fobj || this.Form;
	this.PostAutoSuggest();
	var infix = "";
	elm = this.GetElements("x" + infix + "_ID");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(OrdersLocal.ID.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_CreationDate");
	if (elm && !ew_CheckDate(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(OrdersLocal.CreationDate.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_OrderDate");
	if (elm && !ew_CheckDate(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(OrdersLocal.OrderDate.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_DeliveryTime");
	if (elm && !ew_CheckDate(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(OrdersLocal.DeliveryTime.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_SubTotal");
	if (elm && !ew_CheckNumber(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(OrdersLocal.SubTotal.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_ShippingFee");
	if (elm && !ew_CheckNumber(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(OrdersLocal.ShippingFee.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_OrderTotal");
	if (elm && !ew_CheckNumber(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(OrdersLocal.OrderTotal.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_IdBusinessDetail");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(OrdersLocal.IdBusinessDetail.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_cancelleddate");
	if (elm && !ew_CheckDate(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(OrdersLocal.cancelleddate.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_acknowledgeddate");
	if (elm && !ew_CheckDate(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(OrdersLocal.acknowledgeddate.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_cancelled");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(OrdersLocal.cancelled.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_acknowledged");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(OrdersLocal.acknowledged.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_outfordelivery");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(OrdersLocal.outfordelivery.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_vouchercodediscount");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(OrdersLocal.vouchercodediscount.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_printed");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(OrdersLocal.printed.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_ServiceCharge");
	if (elm && !ew_CheckNumber(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(OrdersLocal.ServiceCharge.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_PaymentSurcharge");
	if (elm && !ew_CheckNumber(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(OrdersLocal.PaymentSurcharge.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_Tax_Rate");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(OrdersLocal.Tax_Rate.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_Tax_Amount");
	if (elm && !ew_CheckNumber(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(OrdersLocal.Tax_Amount.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_Tip_Amount");
	if (elm && !ew_CheckNumber(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(OrdersLocal.Tip_Amount.FldErrMsg) %>");
	// Set up row object
	ew_ElementsToRow(fobj);
	// Fire Form_CustomValidate event
	if (!this.Form_CustomValidate(fobj))
		return false;
	return true;
}
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<% If Not OrdersLocal_search.IsModal Then %>
<div class="ewToolbar">
<% If OrdersLocal.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If OrdersLocal.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% End If %>
<% OrdersLocal_search.ShowPageHeader() %>
<% OrdersLocal_search.ShowMessage %>
<form name="fOrdersLocalsearch" id="fOrdersLocalsearch" class="form-horizontal ewForm ewSearchForm" action="<%= ew_CurrentPage %>" method="post">
<% If OrdersLocal_search.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= OrdersLocal_search.Token %>">
<% End If %>
<input type="hidden" name="t" value="OrdersLocal">
<input type="hidden" name="a_search" id="a_search" value="S">
<% If OrdersLocal_search.IsModal Then %>
<input type="hidden" name="modal" value="1">
<% End If %>
<div>
<% If OrdersLocal.ID.Visible Then ' ID %>
	<div id="r_ID" class="form-group">
		<label for="x_ID" class="<%= OrdersLocal_search.SearchLabelClass %>"><span id="elh_OrdersLocal_ID"><%= OrdersLocal.ID.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_ID" id="z_ID" value="="></p>
		</label>
		<div class="<%= OrdersLocal_search.SearchRightColumnClass %>"><div<%= OrdersLocal.ID.CellAttributes %>>
			<span id="el_OrdersLocal_ID">
<input type="text" data-field="x_ID" name="x_ID" id="x_ID" placeholder="<%= OrdersLocal.ID.PlaceHolder %>" value="<%= OrdersLocal.ID.EditValue %>"<%= OrdersLocal.ID.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrdersLocal.CreationDate.Visible Then ' CreationDate %>
	<div id="r_CreationDate" class="form-group">
		<label for="x_CreationDate" class="<%= OrdersLocal_search.SearchLabelClass %>"><span id="elh_OrdersLocal_CreationDate"><%= OrdersLocal.CreationDate.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_CreationDate" id="z_CreationDate" value="="></p>
		</label>
		<div class="<%= OrdersLocal_search.SearchRightColumnClass %>"><div<%= OrdersLocal.CreationDate.CellAttributes %>>
			<span id="el_OrdersLocal_CreationDate">
<input type="text" data-field="x_CreationDate" name="x_CreationDate" id="x_CreationDate" placeholder="<%= OrdersLocal.CreationDate.PlaceHolder %>" value="<%= OrdersLocal.CreationDate.EditValue %>"<%= OrdersLocal.CreationDate.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrdersLocal.OrderDate.Visible Then ' OrderDate %>
	<div id="r_OrderDate" class="form-group">
		<label for="x_OrderDate" class="<%= OrdersLocal_search.SearchLabelClass %>"><span id="elh_OrdersLocal_OrderDate"><%= OrdersLocal.OrderDate.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_OrderDate" id="z_OrderDate" value="="></p>
		</label>
		<div class="<%= OrdersLocal_search.SearchRightColumnClass %>"><div<%= OrdersLocal.OrderDate.CellAttributes %>>
			<span id="el_OrdersLocal_OrderDate">
<input type="text" data-field="x_OrderDate" name="x_OrderDate" id="x_OrderDate" placeholder="<%= OrdersLocal.OrderDate.PlaceHolder %>" value="<%= OrdersLocal.OrderDate.EditValue %>"<%= OrdersLocal.OrderDate.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrdersLocal.DeliveryType.Visible Then ' DeliveryType %>
	<div id="r_DeliveryType" class="form-group">
		<label for="x_DeliveryType" class="<%= OrdersLocal_search.SearchLabelClass %>"><span id="elh_OrdersLocal_DeliveryType"><%= OrdersLocal.DeliveryType.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_DeliveryType" id="z_DeliveryType" value="LIKE"></p>
		</label>
		<div class="<%= OrdersLocal_search.SearchRightColumnClass %>"><div<%= OrdersLocal.DeliveryType.CellAttributes %>>
			<span id="el_OrdersLocal_DeliveryType">
<input type="text" data-field="x_DeliveryType" name="x_DeliveryType" id="x_DeliveryType" size="30" maxlength="255" placeholder="<%= OrdersLocal.DeliveryType.PlaceHolder %>" value="<%= OrdersLocal.DeliveryType.EditValue %>"<%= OrdersLocal.DeliveryType.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrdersLocal.DeliveryTime.Visible Then ' DeliveryTime %>
	<div id="r_DeliveryTime" class="form-group">
		<label for="x_DeliveryTime" class="<%= OrdersLocal_search.SearchLabelClass %>"><span id="elh_OrdersLocal_DeliveryTime"><%= OrdersLocal.DeliveryTime.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_DeliveryTime" id="z_DeliveryTime" value="="></p>
		</label>
		<div class="<%= OrdersLocal_search.SearchRightColumnClass %>"><div<%= OrdersLocal.DeliveryTime.CellAttributes %>>
			<span id="el_OrdersLocal_DeliveryTime">
<input type="text" data-field="x_DeliveryTime" name="x_DeliveryTime" id="x_DeliveryTime" placeholder="<%= OrdersLocal.DeliveryTime.PlaceHolder %>" value="<%= OrdersLocal.DeliveryTime.EditValue %>"<%= OrdersLocal.DeliveryTime.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrdersLocal.PaymentType.Visible Then ' PaymentType %>
	<div id="r_PaymentType" class="form-group">
		<label for="x_PaymentType" class="<%= OrdersLocal_search.SearchLabelClass %>"><span id="elh_OrdersLocal_PaymentType"><%= OrdersLocal.PaymentType.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_PaymentType" id="z_PaymentType" value="LIKE"></p>
		</label>
		<div class="<%= OrdersLocal_search.SearchRightColumnClass %>"><div<%= OrdersLocal.PaymentType.CellAttributes %>>
			<span id="el_OrdersLocal_PaymentType">
<input type="text" data-field="x_PaymentType" name="x_PaymentType" id="x_PaymentType" size="30" maxlength="255" placeholder="<%= OrdersLocal.PaymentType.PlaceHolder %>" value="<%= OrdersLocal.PaymentType.EditValue %>"<%= OrdersLocal.PaymentType.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrdersLocal.SubTotal.Visible Then ' SubTotal %>
	<div id="r_SubTotal" class="form-group">
		<label for="x_SubTotal" class="<%= OrdersLocal_search.SearchLabelClass %>"><span id="elh_OrdersLocal_SubTotal"><%= OrdersLocal.SubTotal.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_SubTotal" id="z_SubTotal" value="="></p>
		</label>
		<div class="<%= OrdersLocal_search.SearchRightColumnClass %>"><div<%= OrdersLocal.SubTotal.CellAttributes %>>
			<span id="el_OrdersLocal_SubTotal">
<input type="text" data-field="x_SubTotal" name="x_SubTotal" id="x_SubTotal" size="30" placeholder="<%= OrdersLocal.SubTotal.PlaceHolder %>" value="<%= OrdersLocal.SubTotal.EditValue %>"<%= OrdersLocal.SubTotal.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrdersLocal.ShippingFee.Visible Then ' ShippingFee %>
	<div id="r_ShippingFee" class="form-group">
		<label for="x_ShippingFee" class="<%= OrdersLocal_search.SearchLabelClass %>"><span id="elh_OrdersLocal_ShippingFee"><%= OrdersLocal.ShippingFee.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_ShippingFee" id="z_ShippingFee" value="="></p>
		</label>
		<div class="<%= OrdersLocal_search.SearchRightColumnClass %>"><div<%= OrdersLocal.ShippingFee.CellAttributes %>>
			<span id="el_OrdersLocal_ShippingFee">
<input type="text" data-field="x_ShippingFee" name="x_ShippingFee" id="x_ShippingFee" size="30" placeholder="<%= OrdersLocal.ShippingFee.PlaceHolder %>" value="<%= OrdersLocal.ShippingFee.EditValue %>"<%= OrdersLocal.ShippingFee.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrdersLocal.OrderTotal.Visible Then ' OrderTotal %>
	<div id="r_OrderTotal" class="form-group">
		<label for="x_OrderTotal" class="<%= OrdersLocal_search.SearchLabelClass %>"><span id="elh_OrdersLocal_OrderTotal"><%= OrdersLocal.OrderTotal.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_OrderTotal" id="z_OrderTotal" value="="></p>
		</label>
		<div class="<%= OrdersLocal_search.SearchRightColumnClass %>"><div<%= OrdersLocal.OrderTotal.CellAttributes %>>
			<span id="el_OrdersLocal_OrderTotal">
<input type="text" data-field="x_OrderTotal" name="x_OrderTotal" id="x_OrderTotal" size="30" placeholder="<%= OrdersLocal.OrderTotal.PlaceHolder %>" value="<%= OrdersLocal.OrderTotal.EditValue %>"<%= OrdersLocal.OrderTotal.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrdersLocal.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
	<div id="r_IdBusinessDetail" class="form-group">
		<label for="x_IdBusinessDetail" class="<%= OrdersLocal_search.SearchLabelClass %>"><span id="elh_OrdersLocal_IdBusinessDetail"><%= OrdersLocal.IdBusinessDetail.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_IdBusinessDetail" id="z_IdBusinessDetail" value="="></p>
		</label>
		<div class="<%= OrdersLocal_search.SearchRightColumnClass %>"><div<%= OrdersLocal.IdBusinessDetail.CellAttributes %>>
			<span id="el_OrdersLocal_IdBusinessDetail">
<input type="text" data-field="x_IdBusinessDetail" name="x_IdBusinessDetail" id="x_IdBusinessDetail" size="30" placeholder="<%= OrdersLocal.IdBusinessDetail.PlaceHolder %>" value="<%= OrdersLocal.IdBusinessDetail.EditValue %>"<%= OrdersLocal.IdBusinessDetail.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrdersLocal.SessionId.Visible Then ' SessionId %>
	<div id="r_SessionId" class="form-group">
		<label for="x_SessionId" class="<%= OrdersLocal_search.SearchLabelClass %>"><span id="elh_OrdersLocal_SessionId"><%= OrdersLocal.SessionId.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_SessionId" id="z_SessionId" value="LIKE"></p>
		</label>
		<div class="<%= OrdersLocal_search.SearchRightColumnClass %>"><div<%= OrdersLocal.SessionId.CellAttributes %>>
			<span id="el_OrdersLocal_SessionId">
<input type="text" data-field="x_SessionId" name="x_SessionId" id="x_SessionId" size="30" maxlength="255" placeholder="<%= OrdersLocal.SessionId.PlaceHolder %>" value="<%= OrdersLocal.SessionId.EditValue %>"<%= OrdersLocal.SessionId.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrdersLocal.FirstName.Visible Then ' FirstName %>
	<div id="r_FirstName" class="form-group">
		<label for="x_FirstName" class="<%= OrdersLocal_search.SearchLabelClass %>"><span id="elh_OrdersLocal_FirstName"><%= OrdersLocal.FirstName.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_FirstName" id="z_FirstName" value="LIKE"></p>
		</label>
		<div class="<%= OrdersLocal_search.SearchRightColumnClass %>"><div<%= OrdersLocal.FirstName.CellAttributes %>>
			<span id="el_OrdersLocal_FirstName">
<input type="text" data-field="x_FirstName" name="x_FirstName" id="x_FirstName" size="30" maxlength="255" placeholder="<%= OrdersLocal.FirstName.PlaceHolder %>" value="<%= OrdersLocal.FirstName.EditValue %>"<%= OrdersLocal.FirstName.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrdersLocal.LastName.Visible Then ' LastName %>
	<div id="r_LastName" class="form-group">
		<label for="x_LastName" class="<%= OrdersLocal_search.SearchLabelClass %>"><span id="elh_OrdersLocal_LastName"><%= OrdersLocal.LastName.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_LastName" id="z_LastName" value="LIKE"></p>
		</label>
		<div class="<%= OrdersLocal_search.SearchRightColumnClass %>"><div<%= OrdersLocal.LastName.CellAttributes %>>
			<span id="el_OrdersLocal_LastName">
<input type="text" data-field="x_LastName" name="x_LastName" id="x_LastName" size="30" maxlength="255" placeholder="<%= OrdersLocal.LastName.PlaceHolder %>" value="<%= OrdersLocal.LastName.EditValue %>"<%= OrdersLocal.LastName.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrdersLocal.zEmail.Visible Then ' Email %>
	<div id="r_zEmail" class="form-group">
		<label for="x_zEmail" class="<%= OrdersLocal_search.SearchLabelClass %>"><span id="elh_OrdersLocal_zEmail"><%= OrdersLocal.zEmail.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_zEmail" id="z_zEmail" value="LIKE"></p>
		</label>
		<div class="<%= OrdersLocal_search.SearchRightColumnClass %>"><div<%= OrdersLocal.zEmail.CellAttributes %>>
			<span id="el_OrdersLocal_zEmail">
<input type="text" data-field="x_zEmail" name="x_zEmail" id="x_zEmail" size="30" maxlength="255" placeholder="<%= OrdersLocal.zEmail.PlaceHolder %>" value="<%= OrdersLocal.zEmail.EditValue %>"<%= OrdersLocal.zEmail.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrdersLocal.Phone.Visible Then ' Phone %>
	<div id="r_Phone" class="form-group">
		<label for="x_Phone" class="<%= OrdersLocal_search.SearchLabelClass %>"><span id="elh_OrdersLocal_Phone"><%= OrdersLocal.Phone.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_Phone" id="z_Phone" value="LIKE"></p>
		</label>
		<div class="<%= OrdersLocal_search.SearchRightColumnClass %>"><div<%= OrdersLocal.Phone.CellAttributes %>>
			<span id="el_OrdersLocal_Phone">
<input type="text" data-field="x_Phone" name="x_Phone" id="x_Phone" size="30" maxlength="255" placeholder="<%= OrdersLocal.Phone.PlaceHolder %>" value="<%= OrdersLocal.Phone.EditValue %>"<%= OrdersLocal.Phone.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrdersLocal.Address.Visible Then ' Address %>
	<div id="r_Address" class="form-group">
		<label for="x_Address" class="<%= OrdersLocal_search.SearchLabelClass %>"><span id="elh_OrdersLocal_Address"><%= OrdersLocal.Address.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_Address" id="z_Address" value="LIKE"></p>
		</label>
		<div class="<%= OrdersLocal_search.SearchRightColumnClass %>"><div<%= OrdersLocal.Address.CellAttributes %>>
			<span id="el_OrdersLocal_Address">
<input type="text" data-field="x_Address" name="x_Address" id="x_Address" size="30" maxlength="255" placeholder="<%= OrdersLocal.Address.PlaceHolder %>" value="<%= OrdersLocal.Address.EditValue %>"<%= OrdersLocal.Address.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrdersLocal.PostalCode.Visible Then ' PostalCode %>
	<div id="r_PostalCode" class="form-group">
		<label for="x_PostalCode" class="<%= OrdersLocal_search.SearchLabelClass %>"><span id="elh_OrdersLocal_PostalCode"><%= OrdersLocal.PostalCode.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_PostalCode" id="z_PostalCode" value="LIKE"></p>
		</label>
		<div class="<%= OrdersLocal_search.SearchRightColumnClass %>"><div<%= OrdersLocal.PostalCode.CellAttributes %>>
			<span id="el_OrdersLocal_PostalCode">
<input type="text" data-field="x_PostalCode" name="x_PostalCode" id="x_PostalCode" size="30" maxlength="255" placeholder="<%= OrdersLocal.PostalCode.PlaceHolder %>" value="<%= OrdersLocal.PostalCode.EditValue %>"<%= OrdersLocal.PostalCode.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrdersLocal.Notes.Visible Then ' Notes %>
	<div id="r_Notes" class="form-group">
		<label for="x_Notes" class="<%= OrdersLocal_search.SearchLabelClass %>"><span id="elh_OrdersLocal_Notes"><%= OrdersLocal.Notes.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_Notes" id="z_Notes" value="LIKE"></p>
		</label>
		<div class="<%= OrdersLocal_search.SearchRightColumnClass %>"><div<%= OrdersLocal.Notes.CellAttributes %>>
			<span id="el_OrdersLocal_Notes">
<input type="text" data-field="x_Notes" name="x_Notes" id="x_Notes" size="30" maxlength="255" placeholder="<%= OrdersLocal.Notes.PlaceHolder %>" value="<%= OrdersLocal.Notes.EditValue %>"<%= OrdersLocal.Notes.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrdersLocal.ttest.Visible Then ' ttest %>
	<div id="r_ttest" class="form-group">
		<label for="x_ttest" class="<%= OrdersLocal_search.SearchLabelClass %>"><span id="elh_OrdersLocal_ttest"><%= OrdersLocal.ttest.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_ttest" id="z_ttest" value="LIKE"></p>
		</label>
		<div class="<%= OrdersLocal_search.SearchRightColumnClass %>"><div<%= OrdersLocal.ttest.CellAttributes %>>
			<span id="el_OrdersLocal_ttest">
<input type="text" data-field="x_ttest" name="x_ttest" id="x_ttest" size="30" maxlength="255" placeholder="<%= OrdersLocal.ttest.PlaceHolder %>" value="<%= OrdersLocal.ttest.EditValue %>"<%= OrdersLocal.ttest.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrdersLocal.cancelleddate.Visible Then ' cancelleddate %>
	<div id="r_cancelleddate" class="form-group">
		<label for="x_cancelleddate" class="<%= OrdersLocal_search.SearchLabelClass %>"><span id="elh_OrdersLocal_cancelleddate"><%= OrdersLocal.cancelleddate.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_cancelleddate" id="z_cancelleddate" value="="></p>
		</label>
		<div class="<%= OrdersLocal_search.SearchRightColumnClass %>"><div<%= OrdersLocal.cancelleddate.CellAttributes %>>
			<span id="el_OrdersLocal_cancelleddate">
<input type="text" data-field="x_cancelleddate" name="x_cancelleddate" id="x_cancelleddate" placeholder="<%= OrdersLocal.cancelleddate.PlaceHolder %>" value="<%= OrdersLocal.cancelleddate.EditValue %>"<%= OrdersLocal.cancelleddate.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrdersLocal.cancelledby.Visible Then ' cancelledby %>
	<div id="r_cancelledby" class="form-group">
		<label for="x_cancelledby" class="<%= OrdersLocal_search.SearchLabelClass %>"><span id="elh_OrdersLocal_cancelledby"><%= OrdersLocal.cancelledby.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_cancelledby" id="z_cancelledby" value="LIKE"></p>
		</label>
		<div class="<%= OrdersLocal_search.SearchRightColumnClass %>"><div<%= OrdersLocal.cancelledby.CellAttributes %>>
			<span id="el_OrdersLocal_cancelledby">
<input type="text" data-field="x_cancelledby" name="x_cancelledby" id="x_cancelledby" size="30" maxlength="255" placeholder="<%= OrdersLocal.cancelledby.PlaceHolder %>" value="<%= OrdersLocal.cancelledby.EditValue %>"<%= OrdersLocal.cancelledby.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrdersLocal.cancelledreason.Visible Then ' cancelledreason %>
	<div id="r_cancelledreason" class="form-group">
		<label for="x_cancelledreason" class="<%= OrdersLocal_search.SearchLabelClass %>"><span id="elh_OrdersLocal_cancelledreason"><%= OrdersLocal.cancelledreason.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_cancelledreason" id="z_cancelledreason" value="LIKE"></p>
		</label>
		<div class="<%= OrdersLocal_search.SearchRightColumnClass %>"><div<%= OrdersLocal.cancelledreason.CellAttributes %>>
			<span id="el_OrdersLocal_cancelledreason">
<input type="text" data-field="x_cancelledreason" name="x_cancelledreason" id="x_cancelledreason" size="30" maxlength="255" placeholder="<%= OrdersLocal.cancelledreason.PlaceHolder %>" value="<%= OrdersLocal.cancelledreason.EditValue %>"<%= OrdersLocal.cancelledreason.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrdersLocal.acknowledgeddate.Visible Then ' acknowledgeddate %>
	<div id="r_acknowledgeddate" class="form-group">
		<label for="x_acknowledgeddate" class="<%= OrdersLocal_search.SearchLabelClass %>"><span id="elh_OrdersLocal_acknowledgeddate"><%= OrdersLocal.acknowledgeddate.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_acknowledgeddate" id="z_acknowledgeddate" value="="></p>
		</label>
		<div class="<%= OrdersLocal_search.SearchRightColumnClass %>"><div<%= OrdersLocal.acknowledgeddate.CellAttributes %>>
			<span id="el_OrdersLocal_acknowledgeddate">
<input type="text" data-field="x_acknowledgeddate" name="x_acknowledgeddate" id="x_acknowledgeddate" placeholder="<%= OrdersLocal.acknowledgeddate.PlaceHolder %>" value="<%= OrdersLocal.acknowledgeddate.EditValue %>"<%= OrdersLocal.acknowledgeddate.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrdersLocal.delivereddate.Visible Then ' delivereddate %>
	<div id="r_delivereddate" class="form-group">
		<label for="x_delivereddate" class="<%= OrdersLocal_search.SearchLabelClass %>"><span id="elh_OrdersLocal_delivereddate"><%= OrdersLocal.delivereddate.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_delivereddate" id="z_delivereddate" value="LIKE"></p>
		</label>
		<div class="<%= OrdersLocal_search.SearchRightColumnClass %>"><div<%= OrdersLocal.delivereddate.CellAttributes %>>
			<span id="el_OrdersLocal_delivereddate">
<input type="text" data-field="x_delivereddate" name="x_delivereddate" id="x_delivereddate" size="30" maxlength="255" placeholder="<%= OrdersLocal.delivereddate.PlaceHolder %>" value="<%= OrdersLocal.delivereddate.EditValue %>"<%= OrdersLocal.delivereddate.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrdersLocal.cancelled.Visible Then ' cancelled %>
	<div id="r_cancelled" class="form-group">
		<label for="x_cancelled" class="<%= OrdersLocal_search.SearchLabelClass %>"><span id="elh_OrdersLocal_cancelled"><%= OrdersLocal.cancelled.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_cancelled" id="z_cancelled" value="="></p>
		</label>
		<div class="<%= OrdersLocal_search.SearchRightColumnClass %>"><div<%= OrdersLocal.cancelled.CellAttributes %>>
			<span id="el_OrdersLocal_cancelled">
<input type="text" data-field="x_cancelled" name="x_cancelled" id="x_cancelled" size="30" placeholder="<%= OrdersLocal.cancelled.PlaceHolder %>" value="<%= OrdersLocal.cancelled.EditValue %>"<%= OrdersLocal.cancelled.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrdersLocal.acknowledged.Visible Then ' acknowledged %>
	<div id="r_acknowledged" class="form-group">
		<label for="x_acknowledged" class="<%= OrdersLocal_search.SearchLabelClass %>"><span id="elh_OrdersLocal_acknowledged"><%= OrdersLocal.acknowledged.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_acknowledged" id="z_acknowledged" value="="></p>
		</label>
		<div class="<%= OrdersLocal_search.SearchRightColumnClass %>"><div<%= OrdersLocal.acknowledged.CellAttributes %>>
			<span id="el_OrdersLocal_acknowledged">
<input type="text" data-field="x_acknowledged" name="x_acknowledged" id="x_acknowledged" size="30" placeholder="<%= OrdersLocal.acknowledged.PlaceHolder %>" value="<%= OrdersLocal.acknowledged.EditValue %>"<%= OrdersLocal.acknowledged.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrdersLocal.outfordelivery.Visible Then ' outfordelivery %>
	<div id="r_outfordelivery" class="form-group">
		<label for="x_outfordelivery" class="<%= OrdersLocal_search.SearchLabelClass %>"><span id="elh_OrdersLocal_outfordelivery"><%= OrdersLocal.outfordelivery.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_outfordelivery" id="z_outfordelivery" value="="></p>
		</label>
		<div class="<%= OrdersLocal_search.SearchRightColumnClass %>"><div<%= OrdersLocal.outfordelivery.CellAttributes %>>
			<span id="el_OrdersLocal_outfordelivery">
<input type="text" data-field="x_outfordelivery" name="x_outfordelivery" id="x_outfordelivery" size="30" placeholder="<%= OrdersLocal.outfordelivery.PlaceHolder %>" value="<%= OrdersLocal.outfordelivery.EditValue %>"<%= OrdersLocal.outfordelivery.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrdersLocal.vouchercodediscount.Visible Then ' vouchercodediscount %>
	<div id="r_vouchercodediscount" class="form-group">
		<label for="x_vouchercodediscount" class="<%= OrdersLocal_search.SearchLabelClass %>"><span id="elh_OrdersLocal_vouchercodediscount"><%= OrdersLocal.vouchercodediscount.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_vouchercodediscount" id="z_vouchercodediscount" value="="></p>
		</label>
		<div class="<%= OrdersLocal_search.SearchRightColumnClass %>"><div<%= OrdersLocal.vouchercodediscount.CellAttributes %>>
			<span id="el_OrdersLocal_vouchercodediscount">
<input type="text" data-field="x_vouchercodediscount" name="x_vouchercodediscount" id="x_vouchercodediscount" size="30" placeholder="<%= OrdersLocal.vouchercodediscount.PlaceHolder %>" value="<%= OrdersLocal.vouchercodediscount.EditValue %>"<%= OrdersLocal.vouchercodediscount.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrdersLocal.vouchercode.Visible Then ' vouchercode %>
	<div id="r_vouchercode" class="form-group">
		<label for="x_vouchercode" class="<%= OrdersLocal_search.SearchLabelClass %>"><span id="elh_OrdersLocal_vouchercode"><%= OrdersLocal.vouchercode.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_vouchercode" id="z_vouchercode" value="LIKE"></p>
		</label>
		<div class="<%= OrdersLocal_search.SearchRightColumnClass %>"><div<%= OrdersLocal.vouchercode.CellAttributes %>>
			<span id="el_OrdersLocal_vouchercode">
<input type="text" data-field="x_vouchercode" name="x_vouchercode" id="x_vouchercode" size="30" maxlength="255" placeholder="<%= OrdersLocal.vouchercode.PlaceHolder %>" value="<%= OrdersLocal.vouchercode.EditValue %>"<%= OrdersLocal.vouchercode.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrdersLocal.printed.Visible Then ' printed %>
	<div id="r_printed" class="form-group">
		<label for="x_printed" class="<%= OrdersLocal_search.SearchLabelClass %>"><span id="elh_OrdersLocal_printed"><%= OrdersLocal.printed.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_printed" id="z_printed" value="="></p>
		</label>
		<div class="<%= OrdersLocal_search.SearchRightColumnClass %>"><div<%= OrdersLocal.printed.CellAttributes %>>
			<span id="el_OrdersLocal_printed">
<input type="text" data-field="x_printed" name="x_printed" id="x_printed" size="30" placeholder="<%= OrdersLocal.printed.PlaceHolder %>" value="<%= OrdersLocal.printed.EditValue %>"<%= OrdersLocal.printed.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrdersLocal.deliverydistance.Visible Then ' deliverydistance %>
	<div id="r_deliverydistance" class="form-group">
		<label for="x_deliverydistance" class="<%= OrdersLocal_search.SearchLabelClass %>"><span id="elh_OrdersLocal_deliverydistance"><%= OrdersLocal.deliverydistance.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_deliverydistance" id="z_deliverydistance" value="LIKE"></p>
		</label>
		<div class="<%= OrdersLocal_search.SearchRightColumnClass %>"><div<%= OrdersLocal.deliverydistance.CellAttributes %>>
			<span id="el_OrdersLocal_deliverydistance">
<input type="text" data-field="x_deliverydistance" name="x_deliverydistance" id="x_deliverydistance" size="30" maxlength="255" placeholder="<%= OrdersLocal.deliverydistance.PlaceHolder %>" value="<%= OrdersLocal.deliverydistance.EditValue %>"<%= OrdersLocal.deliverydistance.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrdersLocal.asaporder.Visible Then ' asaporder %>
	<div id="r_asaporder" class="form-group">
		<label for="x_asaporder" class="<%= OrdersLocal_search.SearchLabelClass %>"><span id="elh_OrdersLocal_asaporder"><%= OrdersLocal.asaporder.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_asaporder" id="z_asaporder" value="LIKE"></p>
		</label>
		<div class="<%= OrdersLocal_search.SearchRightColumnClass %>"><div<%= OrdersLocal.asaporder.CellAttributes %>>
			<span id="el_OrdersLocal_asaporder">
<input type="text" data-field="x_asaporder" name="x_asaporder" id="x_asaporder" size="30" maxlength="255" placeholder="<%= OrdersLocal.asaporder.PlaceHolder %>" value="<%= OrdersLocal.asaporder.EditValue %>"<%= OrdersLocal.asaporder.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrdersLocal.DeliveryLat.Visible Then ' DeliveryLat %>
	<div id="r_DeliveryLat" class="form-group">
		<label for="x_DeliveryLat" class="<%= OrdersLocal_search.SearchLabelClass %>"><span id="elh_OrdersLocal_DeliveryLat"><%= OrdersLocal.DeliveryLat.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_DeliveryLat" id="z_DeliveryLat" value="LIKE"></p>
		</label>
		<div class="<%= OrdersLocal_search.SearchRightColumnClass %>"><div<%= OrdersLocal.DeliveryLat.CellAttributes %>>
			<span id="el_OrdersLocal_DeliveryLat">
<input type="text" data-field="x_DeliveryLat" name="x_DeliveryLat" id="x_DeliveryLat" size="30" maxlength="50" placeholder="<%= OrdersLocal.DeliveryLat.PlaceHolder %>" value="<%= OrdersLocal.DeliveryLat.EditValue %>"<%= OrdersLocal.DeliveryLat.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrdersLocal.DeliveryLng.Visible Then ' DeliveryLng %>
	<div id="r_DeliveryLng" class="form-group">
		<label for="x_DeliveryLng" class="<%= OrdersLocal_search.SearchLabelClass %>"><span id="elh_OrdersLocal_DeliveryLng"><%= OrdersLocal.DeliveryLng.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_DeliveryLng" id="z_DeliveryLng" value="LIKE"></p>
		</label>
		<div class="<%= OrdersLocal_search.SearchRightColumnClass %>"><div<%= OrdersLocal.DeliveryLng.CellAttributes %>>
			<span id="el_OrdersLocal_DeliveryLng">
<input type="text" data-field="x_DeliveryLng" name="x_DeliveryLng" id="x_DeliveryLng" size="30" maxlength="50" placeholder="<%= OrdersLocal.DeliveryLng.PlaceHolder %>" value="<%= OrdersLocal.DeliveryLng.EditValue %>"<%= OrdersLocal.DeliveryLng.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrdersLocal.ServiceCharge.Visible Then ' ServiceCharge %>
	<div id="r_ServiceCharge" class="form-group">
		<label for="x_ServiceCharge" class="<%= OrdersLocal_search.SearchLabelClass %>"><span id="elh_OrdersLocal_ServiceCharge"><%= OrdersLocal.ServiceCharge.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_ServiceCharge" id="z_ServiceCharge" value="="></p>
		</label>
		<div class="<%= OrdersLocal_search.SearchRightColumnClass %>"><div<%= OrdersLocal.ServiceCharge.CellAttributes %>>
			<span id="el_OrdersLocal_ServiceCharge">
<input type="text" data-field="x_ServiceCharge" name="x_ServiceCharge" id="x_ServiceCharge" size="30" placeholder="<%= OrdersLocal.ServiceCharge.PlaceHolder %>" value="<%= OrdersLocal.ServiceCharge.EditValue %>"<%= OrdersLocal.ServiceCharge.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrdersLocal.PaymentSurcharge.Visible Then ' PaymentSurcharge %>
	<div id="r_PaymentSurcharge" class="form-group">
		<label for="x_PaymentSurcharge" class="<%= OrdersLocal_search.SearchLabelClass %>"><span id="elh_OrdersLocal_PaymentSurcharge"><%= OrdersLocal.PaymentSurcharge.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_PaymentSurcharge" id="z_PaymentSurcharge" value="="></p>
		</label>
		<div class="<%= OrdersLocal_search.SearchRightColumnClass %>"><div<%= OrdersLocal.PaymentSurcharge.CellAttributes %>>
			<span id="el_OrdersLocal_PaymentSurcharge">
<input type="text" data-field="x_PaymentSurcharge" name="x_PaymentSurcharge" id="x_PaymentSurcharge" size="30" placeholder="<%= OrdersLocal.PaymentSurcharge.PlaceHolder %>" value="<%= OrdersLocal.PaymentSurcharge.EditValue %>"<%= OrdersLocal.PaymentSurcharge.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrdersLocal.Tax_Rate.Visible Then ' Tax_Rate %>
	<div id="r_Tax_Rate" class="form-group">
		<label for="x_Tax_Rate" class="<%= OrdersLocal_search.SearchLabelClass %>"><span id="elh_OrdersLocal_Tax_Rate"><%= OrdersLocal.Tax_Rate.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_Tax_Rate" id="z_Tax_Rate" value="="></p>
		</label>
		<div class="<%= OrdersLocal_search.SearchRightColumnClass %>"><div<%= OrdersLocal.Tax_Rate.CellAttributes %>>
			<span id="el_OrdersLocal_Tax_Rate">
<input type="text" data-field="x_Tax_Rate" name="x_Tax_Rate" id="x_Tax_Rate" size="30" placeholder="<%= OrdersLocal.Tax_Rate.PlaceHolder %>" value="<%= OrdersLocal.Tax_Rate.EditValue %>"<%= OrdersLocal.Tax_Rate.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrdersLocal.Tax_Amount.Visible Then ' Tax_Amount %>
	<div id="r_Tax_Amount" class="form-group">
		<label for="x_Tax_Amount" class="<%= OrdersLocal_search.SearchLabelClass %>"><span id="elh_OrdersLocal_Tax_Amount"><%= OrdersLocal.Tax_Amount.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_Tax_Amount" id="z_Tax_Amount" value="="></p>
		</label>
		<div class="<%= OrdersLocal_search.SearchRightColumnClass %>"><div<%= OrdersLocal.Tax_Amount.CellAttributes %>>
			<span id="el_OrdersLocal_Tax_Amount">
<input type="text" data-field="x_Tax_Amount" name="x_Tax_Amount" id="x_Tax_Amount" size="30" placeholder="<%= OrdersLocal.Tax_Amount.PlaceHolder %>" value="<%= OrdersLocal.Tax_Amount.EditValue %>"<%= OrdersLocal.Tax_Amount.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrdersLocal.Tip_Rate.Visible Then ' Tip_Rate %>
	<div id="r_Tip_Rate" class="form-group">
		<label for="x_Tip_Rate" class="<%= OrdersLocal_search.SearchLabelClass %>"><span id="elh_OrdersLocal_Tip_Rate"><%= OrdersLocal.Tip_Rate.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_Tip_Rate" id="z_Tip_Rate" value="LIKE"></p>
		</label>
		<div class="<%= OrdersLocal_search.SearchRightColumnClass %>"><div<%= OrdersLocal.Tip_Rate.CellAttributes %>>
			<span id="el_OrdersLocal_Tip_Rate">
<input type="text" data-field="x_Tip_Rate" name="x_Tip_Rate" id="x_Tip_Rate" size="30" maxlength="255" placeholder="<%= OrdersLocal.Tip_Rate.PlaceHolder %>" value="<%= OrdersLocal.Tip_Rate.EditValue %>"<%= OrdersLocal.Tip_Rate.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrdersLocal.Tip_Amount.Visible Then ' Tip_Amount %>
	<div id="r_Tip_Amount" class="form-group">
		<label for="x_Tip_Amount" class="<%= OrdersLocal_search.SearchLabelClass %>"><span id="elh_OrdersLocal_Tip_Amount"><%= OrdersLocal.Tip_Amount.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_Tip_Amount" id="z_Tip_Amount" value="="></p>
		</label>
		<div class="<%= OrdersLocal_search.SearchRightColumnClass %>"><div<%= OrdersLocal.Tip_Amount.CellAttributes %>>
			<span id="el_OrdersLocal_Tip_Amount">
<input type="text" data-field="x_Tip_Amount" name="x_Tip_Amount" id="x_Tip_Amount" size="30" placeholder="<%= OrdersLocal.Tip_Amount.PlaceHolder %>" value="<%= OrdersLocal.Tip_Amount.EditValue %>"<%= OrdersLocal.Tip_Amount.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrdersLocal.paymentstatus.Visible Then ' paymentstatus %>
	<div id="r_paymentstatus" class="form-group">
		<label for="x_paymentstatus" class="<%= OrdersLocal_search.SearchLabelClass %>"><span id="elh_OrdersLocal_paymentstatus"><%= OrdersLocal.paymentstatus.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_paymentstatus" id="z_paymentstatus" value="LIKE"></p>
		</label>
		<div class="<%= OrdersLocal_search.SearchRightColumnClass %>"><div<%= OrdersLocal.paymentstatus.CellAttributes %>>
			<span id="el_OrdersLocal_paymentstatus">
<input type="text" data-field="x_paymentstatus" name="x_paymentstatus" id="x_paymentstatus" size="30" maxlength="255" placeholder="<%= OrdersLocal.paymentstatus.PlaceHolder %>" value="<%= OrdersLocal.paymentstatus.EditValue %>"<%= OrdersLocal.paymentstatus.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If OrdersLocal.Payment_Status.Visible Then ' Payment_Status %>
	<div id="r_Payment_Status" class="form-group">
		<label for="x_Payment_Status" class="<%= OrdersLocal_search.SearchLabelClass %>"><span id="elh_OrdersLocal_Payment_Status"><%= OrdersLocal.Payment_Status.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_Payment_Status" id="z_Payment_Status" value="LIKE"></p>
		</label>
		<div class="<%= OrdersLocal_search.SearchRightColumnClass %>"><div<%= OrdersLocal.Payment_Status.CellAttributes %>>
			<span id="el_OrdersLocal_Payment_Status">
<input type="text" data-field="x_Payment_Status" name="x_Payment_Status" id="x_Payment_Status" size="30" maxlength="255" placeholder="<%= OrdersLocal.Payment_Status.PlaceHolder %>" value="<%= OrdersLocal.Payment_Status.EditValue %>"<%= OrdersLocal.Payment_Status.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
</div>
<% If Not OrdersLocal_search.IsModal Then %>
<div class="form-group">
	<div class="col-sm-offset-3 col-sm-9">
<button class="btn btn-primary ewButton" name="btnAction" id="btnAction" type="submit"><%= Language.Phrase("Search") %></button>
<button class="btn btn-default ewButton" name="btnReset" id="btnReset" type="button" onclick="ew_ClearForm(this.form);"><%= Language.Phrase("Reset") %></button>
	</div>
</div>
<% End If %>
</form>
<script type="text/javascript">
fOrdersLocalsearch.Init();
</script>
<%
OrdersLocal_search.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set OrdersLocal_search = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cOrdersLocal_search

	' Page ID
	Public Property Get PageID()
		PageID = "search"
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
		PageObjName = "OrdersLocal_search"
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
		EW_PAGE_ID = "search"

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
		OrdersLocal.ID.Visible = Not OrdersLocal.IsAdd() And Not OrdersLocal.IsCopy() And Not OrdersLocal.IsGridAdd()

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

	Dim IsModal
	Dim SearchLabelClass
	Dim SearchRightColumnClass

	' -----------------------------------------------------------------
	' Page main processing
	'
	Sub Page_Main()

		' Set up Breadcrumb
		SetupBreadcrumb()
		SearchLabelClass = "col-sm-3 control-label ewLabel"
		SearchRightColumnClass = "col-sm-9"

		' Check modal
		IsModal = (Request.QueryString("modal")&"" = "1" Or Request.Form("modal")&"" = "1")
		If IsModal Then
			gbSkipHeaderFooter = True
		End If
		If IsPageRequest Then ' Validate request

			' Get action
			OrdersLocal.CurrentAction = ObjForm.GetValue("a_search")
			Select Case OrdersLocal.CurrentAction
				Case "S" ' Get Search Criteria

					' Build search string for advanced search, remove blank field
					Dim sSrchStr
					Call LoadSearchValues() ' Get search values
					If ValidateSearch() Then
						sSrchStr = BuildAdvancedSearch()
					Else
						sSrchStr = ""
						FailureMessage = gsSearchError
					End If
					If sSrchStr <> "" Then
						sSrchStr = OrdersLocal.UrlParm(sSrchStr)
						sSrchStr = "OrdersLocallist.asp" & "?" & sSrchStr
						If IsModal Then
							Dim row
							ReDim row(0,0)
							row(0,0) = Array("url", sSrchStr)
							Response.Write ew_ArrayToJson(row, 0)
							Call Page_Terminate("")
							Response.End
						Else
							Call Page_Terminate(sSrchStr) ' Go to list page
						End If
					End If
			End Select
		End If

		' Restore search settings from Session
		If gsSearchError = "" Then
			Call LoadAdvancedSearch()
		End If

		' Render row for search
		OrdersLocal.RowType = EW_ROWTYPE_SEARCH
		Call RenderRow()
	End Sub

	' -----------------------------------------------------------------
	' Build advanced search
	'
	Function BuildAdvancedSearch()
		Dim sSrchUrl
		sSrchUrl = ""
		Call BuildSearchUrl(sSrchUrl, OrdersLocal.ID, False) ' ID
		Call BuildSearchUrl(sSrchUrl, OrdersLocal.CreationDate, False) ' CreationDate
		Call BuildSearchUrl(sSrchUrl, OrdersLocal.OrderDate, False) ' OrderDate
		Call BuildSearchUrl(sSrchUrl, OrdersLocal.DeliveryType, False) ' DeliveryType
		Call BuildSearchUrl(sSrchUrl, OrdersLocal.DeliveryTime, False) ' DeliveryTime
		Call BuildSearchUrl(sSrchUrl, OrdersLocal.PaymentType, False) ' PaymentType
		Call BuildSearchUrl(sSrchUrl, OrdersLocal.SubTotal, False) ' SubTotal
		Call BuildSearchUrl(sSrchUrl, OrdersLocal.ShippingFee, False) ' ShippingFee
		Call BuildSearchUrl(sSrchUrl, OrdersLocal.OrderTotal, False) ' OrderTotal
		Call BuildSearchUrl(sSrchUrl, OrdersLocal.IdBusinessDetail, False) ' IdBusinessDetail
		Call BuildSearchUrl(sSrchUrl, OrdersLocal.SessionId, False) ' SessionId
		Call BuildSearchUrl(sSrchUrl, OrdersLocal.FirstName, False) ' FirstName
		Call BuildSearchUrl(sSrchUrl, OrdersLocal.LastName, False) ' LastName
		Call BuildSearchUrl(sSrchUrl, OrdersLocal.zEmail, False) ' Email
		Call BuildSearchUrl(sSrchUrl, OrdersLocal.Phone, False) ' Phone
		Call BuildSearchUrl(sSrchUrl, OrdersLocal.Address, False) ' Address
		Call BuildSearchUrl(sSrchUrl, OrdersLocal.PostalCode, False) ' PostalCode
		Call BuildSearchUrl(sSrchUrl, OrdersLocal.Notes, False) ' Notes
		Call BuildSearchUrl(sSrchUrl, OrdersLocal.ttest, False) ' ttest
		Call BuildSearchUrl(sSrchUrl, OrdersLocal.cancelleddate, False) ' cancelleddate
		Call BuildSearchUrl(sSrchUrl, OrdersLocal.cancelledby, False) ' cancelledby
		Call BuildSearchUrl(sSrchUrl, OrdersLocal.cancelledreason, False) ' cancelledreason
		Call BuildSearchUrl(sSrchUrl, OrdersLocal.acknowledgeddate, False) ' acknowledgeddate
		Call BuildSearchUrl(sSrchUrl, OrdersLocal.delivereddate, False) ' delivereddate
		Call BuildSearchUrl(sSrchUrl, OrdersLocal.cancelled, False) ' cancelled
		Call BuildSearchUrl(sSrchUrl, OrdersLocal.acknowledged, False) ' acknowledged
		Call BuildSearchUrl(sSrchUrl, OrdersLocal.outfordelivery, False) ' outfordelivery
		Call BuildSearchUrl(sSrchUrl, OrdersLocal.vouchercodediscount, False) ' vouchercodediscount
		Call BuildSearchUrl(sSrchUrl, OrdersLocal.vouchercode, False) ' vouchercode
		Call BuildSearchUrl(sSrchUrl, OrdersLocal.printed, False) ' printed
		Call BuildSearchUrl(sSrchUrl, OrdersLocal.deliverydistance, False) ' deliverydistance
		Call BuildSearchUrl(sSrchUrl, OrdersLocal.asaporder, False) ' asaporder
		Call BuildSearchUrl(sSrchUrl, OrdersLocal.DeliveryLat, False) ' DeliveryLat
		Call BuildSearchUrl(sSrchUrl, OrdersLocal.DeliveryLng, False) ' DeliveryLng
		Call BuildSearchUrl(sSrchUrl, OrdersLocal.ServiceCharge, False) ' ServiceCharge
		Call BuildSearchUrl(sSrchUrl, OrdersLocal.PaymentSurcharge, False) ' PaymentSurcharge
		Call BuildSearchUrl(sSrchUrl, OrdersLocal.Tax_Rate, False) ' Tax_Rate
		Call BuildSearchUrl(sSrchUrl, OrdersLocal.Tax_Amount, False) ' Tax_Amount
		Call BuildSearchUrl(sSrchUrl, OrdersLocal.Tip_Rate, False) ' Tip_Rate
		Call BuildSearchUrl(sSrchUrl, OrdersLocal.Tip_Amount, False) ' Tip_Amount
		Call BuildSearchUrl(sSrchUrl, OrdersLocal.paymentstatus, False) ' paymentstatus
		Call BuildSearchUrl(sSrchUrl, OrdersLocal.Payment_Status, False) ' Payment_Status
		If sSrchUrl <> "" Then sSrchUrl = sSrchUrl & "&"
		sSrchUrl = sSrchUrl & "cmd=search"
		BuildAdvancedSearch = sSrchUrl
	End Function

	' -----------------------------------------------------------------
	' Function to build search URL
	'
	Sub BuildSearchUrl(Url, Fld, OprOnly)
		Dim FldVal, FldOpr, FldCond, FldVal2, FldOpr2
		Dim FldParm
		Dim IsValidValue, sWrk
		sWrk = ""
		FldParm = Mid(Fld.FldVar, 3)
		FldVal = ObjForm.GetValue("x_" & FldParm)
		FldOpr = ObjForm.GetValue("z_" & FldParm)
		FldCond = ObjForm.GetValue("v_" & FldParm)
		FldVal2 = ObjForm.GetValue("y_" & FldParm)
		FldOpr2 = ObjForm.GetValue("w_" & FldParm)
		FldOpr = UCase(Trim(FldOpr))
		Dim lFldDataType
		If Fld.FldIsVirtual Then
			lFldDataType = EW_DATATYPE_STRING
		Else
			lFldDataType = Fld.FldDataType
		End If
		If FldOpr = "BETWEEN" Then
			IsValidValue = (lFldDataType <> EW_DATATYPE_NUMBER) Or _
				(lFldDataType = EW_DATATYPE_NUMBER And SearchValueIsNumeric(Fld, FldVal) And SearchValueIsNumeric(Fld, FldVal2))
			If FldVal <> "" And FldVal2 <> "" And IsValidValue Then
				sWrk = "x_" & FldParm & "=" & ew_Encode(FldVal) & _
					"&y_" & FldParm & "=" & ew_Encode(FldVal2) & _
					"&z_" & FldParm & "=" & ew_Encode(FldOpr)
			End If
		Else
			IsValidValue = (lFldDataType <> EW_DATATYPE_NUMBER) Or _
				(lFldDataType = EW_DATATYPE_NUMBER And SearchValueIsNumeric(Fld, FldVal))
			If FldVal <> "" And IsValidValue And ew_IsValidOpr(FldOpr, lFldDataType) Then
				sWrk = "x_" & FldParm & "=" & ew_Encode(FldVal) & _
					"&z_" & FldParm & "=" & ew_Encode(FldOpr)
			ElseIf FldOpr = "IS NULL" Or FldOpr = "IS NOT NULL" Or (FldOpr <> "" And OprOnly And ew_IsValidOpr(FldOpr, lFldDataType)) Then
				sWrk = "z_" & FldParm & "=" & ew_Encode(FldOpr)
			End If
			IsValidValue = (lFldDataType <> EW_DATATYPE_NUMBER) Or _
				(lFldDataType = EW_DATATYPE_NUMBER And SearchValueIsNumeric(Fld, FldVal2))
			If FldVal2 <> "" And IsValidValue And ew_IsValidOpr(FldOpr2, lFldDataType) Then
				If sWrk <> "" Then sWrk = sWrk & "&v_" & FldParm & "=" & FldCond & "&"
				sWrk = sWrk & "y_" & FldParm & "=" & ew_Encode(FldVal2) & _
					"&w_" & FldParm & "=" & ew_Encode(FldOpr2)
			ElseIf FldOpr2 = "IS NULL" Or FldOpr2 = "IS NOT NULL" Or (FldOpr2 <> "" And OprOnly And ew_IsValidOpr(FldOpr2, lFldDataType)) Then
				If sWrk <> "" Then sWrk = sWrk & "&v_" & FldParm & "=" & FldCond & "&"
				sWrk = sWrk & "w_" & FldParm & "=" & ew_Encode(FldOpr2)
			End If
		End If
		If sWrk <> "" Then
			If Url <> "" Then Url = Url & "&"
			Url = Url & sWrk
		End If
	End Sub

	Function SearchValueIsNumeric(Fld, Value)
		Dim wrkValue
		wrkValue = Value
		If ew_IsFloatFormat(Fld.FldType) Then wrkValue = ew_StrToFloat(wrkValue)
		SearchValueIsNumeric = IsNumeric(Value)
	End Function

	' -----------------------------------------------------------------
	'  Load search values for validation
	'
	Function LoadSearchValues()

		' Load search values
		OrdersLocal.ID.AdvancedSearch.SearchValue = ObjForm.GetValue("x_ID")
		OrdersLocal.ID.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_ID")
		OrdersLocal.CreationDate.AdvancedSearch.SearchValue = ObjForm.GetValue("x_CreationDate")
		OrdersLocal.CreationDate.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_CreationDate")
		OrdersLocal.OrderDate.AdvancedSearch.SearchValue = ObjForm.GetValue("x_OrderDate")
		OrdersLocal.OrderDate.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_OrderDate")
		OrdersLocal.DeliveryType.AdvancedSearch.SearchValue = ObjForm.GetValue("x_DeliveryType")
		OrdersLocal.DeliveryType.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_DeliveryType")
		OrdersLocal.DeliveryTime.AdvancedSearch.SearchValue = ObjForm.GetValue("x_DeliveryTime")
		OrdersLocal.DeliveryTime.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_DeliveryTime")
		OrdersLocal.PaymentType.AdvancedSearch.SearchValue = ObjForm.GetValue("x_PaymentType")
		OrdersLocal.PaymentType.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_PaymentType")
		OrdersLocal.SubTotal.AdvancedSearch.SearchValue = ObjForm.GetValue("x_SubTotal")
		OrdersLocal.SubTotal.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_SubTotal")
		OrdersLocal.ShippingFee.AdvancedSearch.SearchValue = ObjForm.GetValue("x_ShippingFee")
		OrdersLocal.ShippingFee.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_ShippingFee")
		OrdersLocal.OrderTotal.AdvancedSearch.SearchValue = ObjForm.GetValue("x_OrderTotal")
		OrdersLocal.OrderTotal.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_OrderTotal")
		OrdersLocal.IdBusinessDetail.AdvancedSearch.SearchValue = ObjForm.GetValue("x_IdBusinessDetail")
		OrdersLocal.IdBusinessDetail.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_IdBusinessDetail")
		OrdersLocal.SessionId.AdvancedSearch.SearchValue = ObjForm.GetValue("x_SessionId")
		OrdersLocal.SessionId.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_SessionId")
		OrdersLocal.FirstName.AdvancedSearch.SearchValue = ObjForm.GetValue("x_FirstName")
		OrdersLocal.FirstName.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_FirstName")
		OrdersLocal.LastName.AdvancedSearch.SearchValue = ObjForm.GetValue("x_LastName")
		OrdersLocal.LastName.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_LastName")
		OrdersLocal.zEmail.AdvancedSearch.SearchValue = ObjForm.GetValue("x_zEmail")
		OrdersLocal.zEmail.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_zEmail")
		OrdersLocal.Phone.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Phone")
		OrdersLocal.Phone.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Phone")
		OrdersLocal.Address.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Address")
		OrdersLocal.Address.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Address")
		OrdersLocal.PostalCode.AdvancedSearch.SearchValue = ObjForm.GetValue("x_PostalCode")
		OrdersLocal.PostalCode.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_PostalCode")
		OrdersLocal.Notes.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Notes")
		OrdersLocal.Notes.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Notes")
		OrdersLocal.ttest.AdvancedSearch.SearchValue = ObjForm.GetValue("x_ttest")
		OrdersLocal.ttest.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_ttest")
		OrdersLocal.cancelleddate.AdvancedSearch.SearchValue = ObjForm.GetValue("x_cancelleddate")
		OrdersLocal.cancelleddate.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_cancelleddate")
		OrdersLocal.cancelledby.AdvancedSearch.SearchValue = ObjForm.GetValue("x_cancelledby")
		OrdersLocal.cancelledby.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_cancelledby")
		OrdersLocal.cancelledreason.AdvancedSearch.SearchValue = ObjForm.GetValue("x_cancelledreason")
		OrdersLocal.cancelledreason.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_cancelledreason")
		OrdersLocal.acknowledgeddate.AdvancedSearch.SearchValue = ObjForm.GetValue("x_acknowledgeddate")
		OrdersLocal.acknowledgeddate.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_acknowledgeddate")
		OrdersLocal.delivereddate.AdvancedSearch.SearchValue = ObjForm.GetValue("x_delivereddate")
		OrdersLocal.delivereddate.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_delivereddate")
		OrdersLocal.cancelled.AdvancedSearch.SearchValue = ObjForm.GetValue("x_cancelled")
		OrdersLocal.cancelled.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_cancelled")
		OrdersLocal.acknowledged.AdvancedSearch.SearchValue = ObjForm.GetValue("x_acknowledged")
		OrdersLocal.acknowledged.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_acknowledged")
		OrdersLocal.outfordelivery.AdvancedSearch.SearchValue = ObjForm.GetValue("x_outfordelivery")
		OrdersLocal.outfordelivery.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_outfordelivery")
		OrdersLocal.vouchercodediscount.AdvancedSearch.SearchValue = ObjForm.GetValue("x_vouchercodediscount")
		OrdersLocal.vouchercodediscount.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_vouchercodediscount")
		OrdersLocal.vouchercode.AdvancedSearch.SearchValue = ObjForm.GetValue("x_vouchercode")
		OrdersLocal.vouchercode.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_vouchercode")
		OrdersLocal.printed.AdvancedSearch.SearchValue = ObjForm.GetValue("x_printed")
		OrdersLocal.printed.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_printed")
		OrdersLocal.deliverydistance.AdvancedSearch.SearchValue = ObjForm.GetValue("x_deliverydistance")
		OrdersLocal.deliverydistance.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_deliverydistance")
		OrdersLocal.asaporder.AdvancedSearch.SearchValue = ObjForm.GetValue("x_asaporder")
		OrdersLocal.asaporder.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_asaporder")
		OrdersLocal.DeliveryLat.AdvancedSearch.SearchValue = ObjForm.GetValue("x_DeliveryLat")
		OrdersLocal.DeliveryLat.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_DeliveryLat")
		OrdersLocal.DeliveryLng.AdvancedSearch.SearchValue = ObjForm.GetValue("x_DeliveryLng")
		OrdersLocal.DeliveryLng.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_DeliveryLng")
		OrdersLocal.ServiceCharge.AdvancedSearch.SearchValue = ObjForm.GetValue("x_ServiceCharge")
		OrdersLocal.ServiceCharge.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_ServiceCharge")
		OrdersLocal.PaymentSurcharge.AdvancedSearch.SearchValue = ObjForm.GetValue("x_PaymentSurcharge")
		OrdersLocal.PaymentSurcharge.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_PaymentSurcharge")
		OrdersLocal.Tax_Rate.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Tax_Rate")
		OrdersLocal.Tax_Rate.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Tax_Rate")
		OrdersLocal.Tax_Amount.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Tax_Amount")
		OrdersLocal.Tax_Amount.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Tax_Amount")
		OrdersLocal.Tip_Rate.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Tip_Rate")
		OrdersLocal.Tip_Rate.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Tip_Rate")
		OrdersLocal.Tip_Amount.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Tip_Amount")
		OrdersLocal.Tip_Amount.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Tip_Amount")
		OrdersLocal.paymentstatus.AdvancedSearch.SearchValue = ObjForm.GetValue("x_paymentstatus")
		OrdersLocal.paymentstatus.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_paymentstatus")
		OrdersLocal.Payment_Status.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Payment_Status")
		OrdersLocal.Payment_Status.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Payment_Status")
	End Function

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

			' paymentstatus
			OrdersLocal.paymentstatus.LinkCustomAttributes = ""
			OrdersLocal.paymentstatus.HrefValue = ""
			OrdersLocal.paymentstatus.TooltipValue = ""

			' Payment_Status
			OrdersLocal.Payment_Status.LinkCustomAttributes = ""
			OrdersLocal.Payment_Status.HrefValue = ""
			OrdersLocal.Payment_Status.TooltipValue = ""

		' ------------
		'  Search Row
		' ------------

		ElseIf OrdersLocal.RowType = EW_ROWTYPE_SEARCH Then ' Search row

			' ID
			OrdersLocal.ID.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.ID.EditCustomAttributes = ""
			OrdersLocal.ID.EditValue = ew_HtmlEncode(OrdersLocal.ID.AdvancedSearch.SearchValue)
			OrdersLocal.ID.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.ID.FldCaption))

			' CreationDate
			OrdersLocal.CreationDate.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.CreationDate.EditCustomAttributes = ""
			OrdersLocal.CreationDate.EditValue = ew_FormatDateTime(ew_UnFormatDateTime(OrdersLocal.CreationDate.AdvancedSearch.SearchValue, 9), 9)
			OrdersLocal.CreationDate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.CreationDate.FldCaption))

			' OrderDate
			OrdersLocal.OrderDate.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.OrderDate.EditCustomAttributes = ""
			OrdersLocal.OrderDate.EditValue = ew_FormatDateTime(ew_UnFormatDateTime(OrdersLocal.OrderDate.AdvancedSearch.SearchValue, 9), 9)
			OrdersLocal.OrderDate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.OrderDate.FldCaption))

			' DeliveryType
			OrdersLocal.DeliveryType.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.DeliveryType.EditCustomAttributes = ""
			OrdersLocal.DeliveryType.EditValue = ew_HtmlEncode(OrdersLocal.DeliveryType.AdvancedSearch.SearchValue)
			OrdersLocal.DeliveryType.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.DeliveryType.FldCaption))

			' DeliveryTime
			OrdersLocal.DeliveryTime.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.DeliveryTime.EditCustomAttributes = ""
			OrdersLocal.DeliveryTime.EditValue = ew_FormatDateTime(ew_UnFormatDateTime(OrdersLocal.DeliveryTime.AdvancedSearch.SearchValue, 9), 9)
			OrdersLocal.DeliveryTime.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.DeliveryTime.FldCaption))

			' PaymentType
			OrdersLocal.PaymentType.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.PaymentType.EditCustomAttributes = ""
			OrdersLocal.PaymentType.EditValue = ew_HtmlEncode(OrdersLocal.PaymentType.AdvancedSearch.SearchValue)
			OrdersLocal.PaymentType.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.PaymentType.FldCaption))

			' SubTotal
			OrdersLocal.SubTotal.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.SubTotal.EditCustomAttributes = ""
			OrdersLocal.SubTotal.EditValue = ew_HtmlEncode(OrdersLocal.SubTotal.AdvancedSearch.SearchValue)
			OrdersLocal.SubTotal.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.SubTotal.FldCaption))

			' ShippingFee
			OrdersLocal.ShippingFee.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.ShippingFee.EditCustomAttributes = ""
			OrdersLocal.ShippingFee.EditValue = ew_HtmlEncode(OrdersLocal.ShippingFee.AdvancedSearch.SearchValue)
			OrdersLocal.ShippingFee.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.ShippingFee.FldCaption))

			' OrderTotal
			OrdersLocal.OrderTotal.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.OrderTotal.EditCustomAttributes = ""
			OrdersLocal.OrderTotal.EditValue = ew_HtmlEncode(OrdersLocal.OrderTotal.AdvancedSearch.SearchValue)
			OrdersLocal.OrderTotal.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.OrderTotal.FldCaption))

			' IdBusinessDetail
			OrdersLocal.IdBusinessDetail.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.IdBusinessDetail.EditCustomAttributes = ""
			OrdersLocal.IdBusinessDetail.EditValue = ew_HtmlEncode(OrdersLocal.IdBusinessDetail.AdvancedSearch.SearchValue)
			OrdersLocal.IdBusinessDetail.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.IdBusinessDetail.FldCaption))

			' SessionId
			OrdersLocal.SessionId.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.SessionId.EditCustomAttributes = ""
			OrdersLocal.SessionId.EditValue = ew_HtmlEncode(OrdersLocal.SessionId.AdvancedSearch.SearchValue)
			OrdersLocal.SessionId.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.SessionId.FldCaption))

			' FirstName
			OrdersLocal.FirstName.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.FirstName.EditCustomAttributes = ""
			OrdersLocal.FirstName.EditValue = ew_HtmlEncode(OrdersLocal.FirstName.AdvancedSearch.SearchValue)
			OrdersLocal.FirstName.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.FirstName.FldCaption))

			' LastName
			OrdersLocal.LastName.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.LastName.EditCustomAttributes = ""
			OrdersLocal.LastName.EditValue = ew_HtmlEncode(OrdersLocal.LastName.AdvancedSearch.SearchValue)
			OrdersLocal.LastName.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.LastName.FldCaption))

			' Email
			OrdersLocal.zEmail.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.zEmail.EditCustomAttributes = ""
			OrdersLocal.zEmail.EditValue = ew_HtmlEncode(OrdersLocal.zEmail.AdvancedSearch.SearchValue)
			OrdersLocal.zEmail.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.zEmail.FldCaption))

			' Phone
			OrdersLocal.Phone.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.Phone.EditCustomAttributes = ""
			OrdersLocal.Phone.EditValue = ew_HtmlEncode(OrdersLocal.Phone.AdvancedSearch.SearchValue)
			OrdersLocal.Phone.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.Phone.FldCaption))

			' Address
			OrdersLocal.Address.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.Address.EditCustomAttributes = ""
			OrdersLocal.Address.EditValue = ew_HtmlEncode(OrdersLocal.Address.AdvancedSearch.SearchValue)
			OrdersLocal.Address.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.Address.FldCaption))

			' PostalCode
			OrdersLocal.PostalCode.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.PostalCode.EditCustomAttributes = ""
			OrdersLocal.PostalCode.EditValue = ew_HtmlEncode(OrdersLocal.PostalCode.AdvancedSearch.SearchValue)
			OrdersLocal.PostalCode.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.PostalCode.FldCaption))

			' Notes
			OrdersLocal.Notes.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.Notes.EditCustomAttributes = ""
			OrdersLocal.Notes.EditValue = ew_HtmlEncode(OrdersLocal.Notes.AdvancedSearch.SearchValue)
			OrdersLocal.Notes.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.Notes.FldCaption))

			' ttest
			OrdersLocal.ttest.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.ttest.EditCustomAttributes = ""
			OrdersLocal.ttest.EditValue = ew_HtmlEncode(OrdersLocal.ttest.AdvancedSearch.SearchValue)
			OrdersLocal.ttest.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.ttest.FldCaption))

			' cancelleddate
			OrdersLocal.cancelleddate.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.cancelleddate.EditCustomAttributes = ""
			OrdersLocal.cancelleddate.EditValue = ew_FormatDateTime(ew_UnFormatDateTime(OrdersLocal.cancelleddate.AdvancedSearch.SearchValue, 9), 9)
			OrdersLocal.cancelleddate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.cancelleddate.FldCaption))

			' cancelledby
			OrdersLocal.cancelledby.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.cancelledby.EditCustomAttributes = ""
			OrdersLocal.cancelledby.EditValue = ew_HtmlEncode(OrdersLocal.cancelledby.AdvancedSearch.SearchValue)
			OrdersLocal.cancelledby.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.cancelledby.FldCaption))

			' cancelledreason
			OrdersLocal.cancelledreason.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.cancelledreason.EditCustomAttributes = ""
			OrdersLocal.cancelledreason.EditValue = ew_HtmlEncode(OrdersLocal.cancelledreason.AdvancedSearch.SearchValue)
			OrdersLocal.cancelledreason.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.cancelledreason.FldCaption))

			' acknowledgeddate
			OrdersLocal.acknowledgeddate.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.acknowledgeddate.EditCustomAttributes = ""
			OrdersLocal.acknowledgeddate.EditValue = ew_FormatDateTime(ew_UnFormatDateTime(OrdersLocal.acknowledgeddate.AdvancedSearch.SearchValue, 9), 9)
			OrdersLocal.acknowledgeddate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.acknowledgeddate.FldCaption))

			' delivereddate
			OrdersLocal.delivereddate.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.delivereddate.EditCustomAttributes = ""
			OrdersLocal.delivereddate.EditValue = ew_HtmlEncode(OrdersLocal.delivereddate.AdvancedSearch.SearchValue)
			OrdersLocal.delivereddate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.delivereddate.FldCaption))

			' cancelled
			OrdersLocal.cancelled.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.cancelled.EditCustomAttributes = ""
			OrdersLocal.cancelled.EditValue = ew_HtmlEncode(OrdersLocal.cancelled.AdvancedSearch.SearchValue)
			OrdersLocal.cancelled.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.cancelled.FldCaption))

			' acknowledged
			OrdersLocal.acknowledged.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.acknowledged.EditCustomAttributes = ""
			OrdersLocal.acknowledged.EditValue = ew_HtmlEncode(OrdersLocal.acknowledged.AdvancedSearch.SearchValue)
			OrdersLocal.acknowledged.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.acknowledged.FldCaption))

			' outfordelivery
			OrdersLocal.outfordelivery.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.outfordelivery.EditCustomAttributes = ""
			OrdersLocal.outfordelivery.EditValue = ew_HtmlEncode(OrdersLocal.outfordelivery.AdvancedSearch.SearchValue)
			OrdersLocal.outfordelivery.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.outfordelivery.FldCaption))

			' vouchercodediscount
			OrdersLocal.vouchercodediscount.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.vouchercodediscount.EditCustomAttributes = ""
			OrdersLocal.vouchercodediscount.EditValue = ew_HtmlEncode(OrdersLocal.vouchercodediscount.AdvancedSearch.SearchValue)
			OrdersLocal.vouchercodediscount.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.vouchercodediscount.FldCaption))

			' vouchercode
			OrdersLocal.vouchercode.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.vouchercode.EditCustomAttributes = ""
			OrdersLocal.vouchercode.EditValue = ew_HtmlEncode(OrdersLocal.vouchercode.AdvancedSearch.SearchValue)
			OrdersLocal.vouchercode.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.vouchercode.FldCaption))

			' printed
			OrdersLocal.printed.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.printed.EditCustomAttributes = ""
			OrdersLocal.printed.EditValue = ew_HtmlEncode(OrdersLocal.printed.AdvancedSearch.SearchValue)
			OrdersLocal.printed.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.printed.FldCaption))

			' deliverydistance
			OrdersLocal.deliverydistance.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.deliverydistance.EditCustomAttributes = ""
			OrdersLocal.deliverydistance.EditValue = ew_HtmlEncode(OrdersLocal.deliverydistance.AdvancedSearch.SearchValue)
			OrdersLocal.deliverydistance.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.deliverydistance.FldCaption))

			' asaporder
			OrdersLocal.asaporder.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.asaporder.EditCustomAttributes = ""
			OrdersLocal.asaporder.EditValue = ew_HtmlEncode(OrdersLocal.asaporder.AdvancedSearch.SearchValue)
			OrdersLocal.asaporder.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.asaporder.FldCaption))

			' DeliveryLat
			OrdersLocal.DeliveryLat.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.DeliveryLat.EditCustomAttributes = ""
			OrdersLocal.DeliveryLat.EditValue = ew_HtmlEncode(OrdersLocal.DeliveryLat.AdvancedSearch.SearchValue)
			OrdersLocal.DeliveryLat.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.DeliveryLat.FldCaption))

			' DeliveryLng
			OrdersLocal.DeliveryLng.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.DeliveryLng.EditCustomAttributes = ""
			OrdersLocal.DeliveryLng.EditValue = ew_HtmlEncode(OrdersLocal.DeliveryLng.AdvancedSearch.SearchValue)
			OrdersLocal.DeliveryLng.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.DeliveryLng.FldCaption))

			' ServiceCharge
			OrdersLocal.ServiceCharge.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.ServiceCharge.EditCustomAttributes = ""
			OrdersLocal.ServiceCharge.EditValue = ew_HtmlEncode(OrdersLocal.ServiceCharge.AdvancedSearch.SearchValue)
			OrdersLocal.ServiceCharge.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.ServiceCharge.FldCaption))

			' PaymentSurcharge
			OrdersLocal.PaymentSurcharge.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.PaymentSurcharge.EditCustomAttributes = ""
			OrdersLocal.PaymentSurcharge.EditValue = ew_HtmlEncode(OrdersLocal.PaymentSurcharge.AdvancedSearch.SearchValue)
			OrdersLocal.PaymentSurcharge.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.PaymentSurcharge.FldCaption))

			' Tax_Rate
			OrdersLocal.Tax_Rate.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.Tax_Rate.EditCustomAttributes = ""
			OrdersLocal.Tax_Rate.EditValue = ew_HtmlEncode(OrdersLocal.Tax_Rate.AdvancedSearch.SearchValue)
			OrdersLocal.Tax_Rate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.Tax_Rate.FldCaption))

			' Tax_Amount
			OrdersLocal.Tax_Amount.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.Tax_Amount.EditCustomAttributes = ""
			OrdersLocal.Tax_Amount.EditValue = ew_HtmlEncode(OrdersLocal.Tax_Amount.AdvancedSearch.SearchValue)
			OrdersLocal.Tax_Amount.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.Tax_Amount.FldCaption))

			' Tip_Rate
			OrdersLocal.Tip_Rate.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.Tip_Rate.EditCustomAttributes = ""
			OrdersLocal.Tip_Rate.EditValue = ew_HtmlEncode(OrdersLocal.Tip_Rate.AdvancedSearch.SearchValue)
			OrdersLocal.Tip_Rate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.Tip_Rate.FldCaption))

			' Tip_Amount
			OrdersLocal.Tip_Amount.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.Tip_Amount.EditCustomAttributes = ""
			OrdersLocal.Tip_Amount.EditValue = ew_HtmlEncode(OrdersLocal.Tip_Amount.AdvancedSearch.SearchValue)
			OrdersLocal.Tip_Amount.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.Tip_Amount.FldCaption))

			' paymentstatus
			OrdersLocal.paymentstatus.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.paymentstatus.EditCustomAttributes = ""
			OrdersLocal.paymentstatus.EditValue = ew_HtmlEncode(OrdersLocal.paymentstatus.AdvancedSearch.SearchValue)
			OrdersLocal.paymentstatus.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.paymentstatus.FldCaption))

			' Payment_Status
			OrdersLocal.Payment_Status.EditAttrs.UpdateAttribute "class", "form-control"
			OrdersLocal.Payment_Status.EditCustomAttributes = ""
			OrdersLocal.Payment_Status.EditValue = ew_HtmlEncode(OrdersLocal.Payment_Status.AdvancedSearch.SearchValue)
			OrdersLocal.Payment_Status.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrdersLocal.Payment_Status.FldCaption))
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
	' Validate search
	'
	Function ValidateSearch()

		' Initialize
		gsSearchError = ""

		' Check if validation required
		If Not EW_SERVER_VALIDATE Then
			ValidateSearch = True
			Exit Function
		End If
		If Not ew_CheckInteger(OrdersLocal.ID.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, OrdersLocal.ID.FldErrMsg)
		End If
		If Not ew_CheckDate(OrdersLocal.CreationDate.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, OrdersLocal.CreationDate.FldErrMsg)
		End If
		If Not ew_CheckDate(OrdersLocal.OrderDate.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, OrdersLocal.OrderDate.FldErrMsg)
		End If
		If Not ew_CheckDate(OrdersLocal.DeliveryTime.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, OrdersLocal.DeliveryTime.FldErrMsg)
		End If
		If Not ew_CheckNumber(OrdersLocal.SubTotal.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, OrdersLocal.SubTotal.FldErrMsg)
		End If
		If Not ew_CheckNumber(OrdersLocal.ShippingFee.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, OrdersLocal.ShippingFee.FldErrMsg)
		End If
		If Not ew_CheckNumber(OrdersLocal.OrderTotal.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, OrdersLocal.OrderTotal.FldErrMsg)
		End If
		If Not ew_CheckInteger(OrdersLocal.IdBusinessDetail.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, OrdersLocal.IdBusinessDetail.FldErrMsg)
		End If
		If Not ew_CheckDate(OrdersLocal.cancelleddate.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, OrdersLocal.cancelleddate.FldErrMsg)
		End If
		If Not ew_CheckDate(OrdersLocal.acknowledgeddate.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, OrdersLocal.acknowledgeddate.FldErrMsg)
		End If
		If Not ew_CheckInteger(OrdersLocal.cancelled.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, OrdersLocal.cancelled.FldErrMsg)
		End If
		If Not ew_CheckInteger(OrdersLocal.acknowledged.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, OrdersLocal.acknowledged.FldErrMsg)
		End If
		If Not ew_CheckInteger(OrdersLocal.outfordelivery.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, OrdersLocal.outfordelivery.FldErrMsg)
		End If
		If Not ew_CheckInteger(OrdersLocal.vouchercodediscount.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, OrdersLocal.vouchercodediscount.FldErrMsg)
		End If
		If Not ew_CheckInteger(OrdersLocal.printed.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, OrdersLocal.printed.FldErrMsg)
		End If
		If Not ew_CheckNumber(OrdersLocal.ServiceCharge.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, OrdersLocal.ServiceCharge.FldErrMsg)
		End If
		If Not ew_CheckNumber(OrdersLocal.PaymentSurcharge.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, OrdersLocal.PaymentSurcharge.FldErrMsg)
		End If
		If Not ew_CheckInteger(OrdersLocal.Tax_Rate.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, OrdersLocal.Tax_Rate.FldErrMsg)
		End If
		If Not ew_CheckNumber(OrdersLocal.Tax_Amount.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, OrdersLocal.Tax_Amount.FldErrMsg)
		End If
		If Not ew_CheckNumber(OrdersLocal.Tip_Amount.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, OrdersLocal.Tip_Amount.FldErrMsg)
		End If

		' Return validate result
		ValidateSearch = (gsSearchError = "")

		' Call Form Custom Validate event
		Dim sFormCustomError
		sFormCustomError = ""
		ValidateSearch = ValidateSearch And Form_CustomValidate(sFormCustomError)
		If sFormCustomError <> "" Then
			Call ew_AddMessage(gsSearchError, sFormCustomError)
		End If
	End Function

	' -----------------------------------------------------------------
	' Load advanced search
	'
	Function LoadAdvancedSearch()
		Call OrdersLocal.ID.AdvancedSearch.Load()
		Call OrdersLocal.CreationDate.AdvancedSearch.Load()
		Call OrdersLocal.OrderDate.AdvancedSearch.Load()
		Call OrdersLocal.DeliveryType.AdvancedSearch.Load()
		Call OrdersLocal.DeliveryTime.AdvancedSearch.Load()
		Call OrdersLocal.PaymentType.AdvancedSearch.Load()
		Call OrdersLocal.SubTotal.AdvancedSearch.Load()
		Call OrdersLocal.ShippingFee.AdvancedSearch.Load()
		Call OrdersLocal.OrderTotal.AdvancedSearch.Load()
		Call OrdersLocal.IdBusinessDetail.AdvancedSearch.Load()
		Call OrdersLocal.SessionId.AdvancedSearch.Load()
		Call OrdersLocal.FirstName.AdvancedSearch.Load()
		Call OrdersLocal.LastName.AdvancedSearch.Load()
		Call OrdersLocal.zEmail.AdvancedSearch.Load()
		Call OrdersLocal.Phone.AdvancedSearch.Load()
		Call OrdersLocal.Address.AdvancedSearch.Load()
		Call OrdersLocal.PostalCode.AdvancedSearch.Load()
		Call OrdersLocal.Notes.AdvancedSearch.Load()
		Call OrdersLocal.ttest.AdvancedSearch.Load()
		Call OrdersLocal.cancelleddate.AdvancedSearch.Load()
		Call OrdersLocal.cancelledby.AdvancedSearch.Load()
		Call OrdersLocal.cancelledreason.AdvancedSearch.Load()
		Call OrdersLocal.acknowledgeddate.AdvancedSearch.Load()
		Call OrdersLocal.delivereddate.AdvancedSearch.Load()
		Call OrdersLocal.cancelled.AdvancedSearch.Load()
		Call OrdersLocal.acknowledged.AdvancedSearch.Load()
		Call OrdersLocal.outfordelivery.AdvancedSearch.Load()
		Call OrdersLocal.vouchercodediscount.AdvancedSearch.Load()
		Call OrdersLocal.vouchercode.AdvancedSearch.Load()
		Call OrdersLocal.printed.AdvancedSearch.Load()
		Call OrdersLocal.deliverydistance.AdvancedSearch.Load()
		Call OrdersLocal.asaporder.AdvancedSearch.Load()
		Call OrdersLocal.DeliveryLat.AdvancedSearch.Load()
		Call OrdersLocal.DeliveryLng.AdvancedSearch.Load()
		Call OrdersLocal.ServiceCharge.AdvancedSearch.Load()
		Call OrdersLocal.PaymentSurcharge.AdvancedSearch.Load()
		Call OrdersLocal.Tax_Rate.AdvancedSearch.Load()
		Call OrdersLocal.Tax_Amount.AdvancedSearch.Load()
		Call OrdersLocal.Tip_Rate.AdvancedSearch.Load()
		Call OrdersLocal.Tip_Amount.AdvancedSearch.Load()
		Call OrdersLocal.paymentstatus.AdvancedSearch.Load()
		Call OrdersLocal.Payment_Status.AdvancedSearch.Load()
End Function

	' Set up Breadcrumb
	Sub SetupBreadcrumb()
		Dim PageId, url
		Set Breadcrumb = New cBreadcrumb
		url = Mid(ew_CurrentUrl, InStrRev(ew_CurrentUrl, "/")+1)
		Call Breadcrumb.Add("list", OrdersLocal.TableVar, "OrdersLocallist.asp", "", OrdersLocal.TableVar, True)
		PageId = "search"
		Call Breadcrumb.Add("search", PageId, url, "", "", False)
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
