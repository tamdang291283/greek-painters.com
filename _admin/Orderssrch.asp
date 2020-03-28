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
Dim Orders_search
Set Orders_search = New cOrders_search
Set Page = Orders_search

' Page init processing
Orders_search.Page_Init()

' Page main processing
Orders_search.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
Orders_search.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var Orders_search = new ew_Page("Orders_search");
Orders_search.PageID = "search"; // Page ID
var EW_PAGE_ID = Orders_search.PageID; // For backward compatibility
// Form object
var fOrderssearch = new ew_Form("fOrderssearch");
// Form_CustomValidate event
fOrderssearch.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fOrderssearch.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fOrderssearch.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
// Validate function for search
fOrderssearch.Validate = function(fobj) {
	if (!this.ValidateRequired)
		return true; // Ignore validation
	fobj = fobj || this.Form;
	this.PostAutoSuggest();
	var infix = "";
	elm = this.GetElements("x" + infix + "_ID");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(Orders.ID.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_CreationDate");
	if (elm && !ew_CheckDate(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(Orders.CreationDate.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_OrderDate");
	if (elm && !ew_CheckDate(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(Orders.OrderDate.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_DeliveryTime");
	if (elm && !ew_CheckDate(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(Orders.DeliveryTime.FldErrMsg) %>");
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
	elm = this.GetElements("x" + infix + "_cancelleddate");
	if (elm && !ew_CheckDate(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(Orders.cancelleddate.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_acknowledgeddate");
	if (elm && !ew_CheckDate(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(Orders.acknowledgeddate.FldErrMsg) %>");
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
	return true;
}
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<% If Not Orders_search.IsModal Then %>
<div class="ewToolbar">
<% If Orders.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If Orders.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% End If %>
<% Orders_search.ShowPageHeader() %>
<% Orders_search.ShowMessage %>
<form name="fOrderssearch" id="fOrderssearch" class="form-horizontal ewForm ewSearchForm" action="<%= ew_CurrentPage %>" method="post">
<% If Orders_search.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= Orders_search.Token %>">
<% End If %>
<input type="hidden" name="t" value="Orders">
<input type="hidden" name="a_search" id="a_search" value="S">
<% If Orders_search.IsModal Then %>
<input type="hidden" name="modal" value="1">
<% End If %>
<div>
<% If Orders.ID.Visible Then ' ID %>
	<div id="r_ID" class="form-group">
		<label for="x_ID" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_ID"><%= Orders.ID.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_ID" id="z_ID" value="="></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.ID.CellAttributes %>>
			<span id="el_Orders_ID">
<input type="text" data-field="x_ID" name="x_ID" id="x_ID" placeholder="<%= Orders.ID.PlaceHolder %>" value="<%= Orders.ID.EditValue %>"<%= Orders.ID.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.CreationDate.Visible Then ' CreationDate %>
	<div id="r_CreationDate" class="form-group">
		<label for="x_CreationDate" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_CreationDate"><%= Orders.CreationDate.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_CreationDate" id="z_CreationDate" value="="></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.CreationDate.CellAttributes %>>
			<span id="el_Orders_CreationDate">
<input type="text" data-field="x_CreationDate" name="x_CreationDate" id="x_CreationDate" placeholder="<%= Orders.CreationDate.PlaceHolder %>" value="<%= Orders.CreationDate.EditValue %>"<%= Orders.CreationDate.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.OrderDate.Visible Then ' OrderDate %>
	<div id="r_OrderDate" class="form-group">
		<label for="x_OrderDate" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_OrderDate"><%= Orders.OrderDate.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_OrderDate" id="z_OrderDate" value="="></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.OrderDate.CellAttributes %>>
			<span id="el_Orders_OrderDate">
<input type="text" data-field="x_OrderDate" name="x_OrderDate" id="x_OrderDate" placeholder="<%= Orders.OrderDate.PlaceHolder %>" value="<%= Orders.OrderDate.EditValue %>"<%= Orders.OrderDate.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.DeliveryType.Visible Then ' DeliveryType %>
	<div id="r_DeliveryType" class="form-group">
		<label for="x_DeliveryType" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_DeliveryType"><%= Orders.DeliveryType.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_DeliveryType" id="z_DeliveryType" value="LIKE"></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.DeliveryType.CellAttributes %>>
			<span id="el_Orders_DeliveryType">
<input type="text" data-field="x_DeliveryType" name="x_DeliveryType" id="x_DeliveryType" size="30" maxlength="255" placeholder="<%= Orders.DeliveryType.PlaceHolder %>" value="<%= Orders.DeliveryType.EditValue %>"<%= Orders.DeliveryType.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.DeliveryTime.Visible Then ' DeliveryTime %>
	<div id="r_DeliveryTime" class="form-group">
		<label for="x_DeliveryTime" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_DeliveryTime"><%= Orders.DeliveryTime.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_DeliveryTime" id="z_DeliveryTime" value="="></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.DeliveryTime.CellAttributes %>>
			<span id="el_Orders_DeliveryTime">
<input type="text" data-field="x_DeliveryTime" name="x_DeliveryTime" id="x_DeliveryTime" placeholder="<%= Orders.DeliveryTime.PlaceHolder %>" value="<%= Orders.DeliveryTime.EditValue %>"<%= Orders.DeliveryTime.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.PaymentType.Visible Then ' PaymentType %>
	<div id="r_PaymentType" class="form-group">
		<label for="x_PaymentType" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_PaymentType"><%= Orders.PaymentType.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_PaymentType" id="z_PaymentType" value="LIKE"></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.PaymentType.CellAttributes %>>
			<span id="el_Orders_PaymentType">
<input type="text" data-field="x_PaymentType" name="x_PaymentType" id="x_PaymentType" size="30" maxlength="255" placeholder="<%= Orders.PaymentType.PlaceHolder %>" value="<%= Orders.PaymentType.EditValue %>"<%= Orders.PaymentType.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.SubTotal.Visible Then ' SubTotal %>
	<div id="r_SubTotal" class="form-group">
		<label for="x_SubTotal" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_SubTotal"><%= Orders.SubTotal.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_SubTotal" id="z_SubTotal" value="="></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.SubTotal.CellAttributes %>>
			<span id="el_Orders_SubTotal">
<input type="text" data-field="x_SubTotal" name="x_SubTotal" id="x_SubTotal" size="30" placeholder="<%= Orders.SubTotal.PlaceHolder %>" value="<%= Orders.SubTotal.EditValue %>"<%= Orders.SubTotal.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.ShippingFee.Visible Then ' ShippingFee %>
	<div id="r_ShippingFee" class="form-group">
		<label for="x_ShippingFee" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_ShippingFee"><%= Orders.ShippingFee.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_ShippingFee" id="z_ShippingFee" value="="></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.ShippingFee.CellAttributes %>>
			<span id="el_Orders_ShippingFee">
<input type="text" data-field="x_ShippingFee" name="x_ShippingFee" id="x_ShippingFee" size="30" placeholder="<%= Orders.ShippingFee.PlaceHolder %>" value="<%= Orders.ShippingFee.EditValue %>"<%= Orders.ShippingFee.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.OrderTotal.Visible Then ' OrderTotal %>
	<div id="r_OrderTotal" class="form-group">
		<label for="x_OrderTotal" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_OrderTotal"><%= Orders.OrderTotal.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_OrderTotal" id="z_OrderTotal" value="="></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.OrderTotal.CellAttributes %>>
			<span id="el_Orders_OrderTotal">
<input type="text" data-field="x_OrderTotal" name="x_OrderTotal" id="x_OrderTotal" size="30" placeholder="<%= Orders.OrderTotal.PlaceHolder %>" value="<%= Orders.OrderTotal.EditValue %>"<%= Orders.OrderTotal.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.IdBusinessDetail.Visible Then ' IdBusinessDetail %>
	<div id="r_IdBusinessDetail" class="form-group">
		<label for="x_IdBusinessDetail" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_IdBusinessDetail"><%= Orders.IdBusinessDetail.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_IdBusinessDetail" id="z_IdBusinessDetail" value="="></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.IdBusinessDetail.CellAttributes %>>
			<span id="el_Orders_IdBusinessDetail">
<input type="text" data-field="x_IdBusinessDetail" name="x_IdBusinessDetail" id="x_IdBusinessDetail" size="30" placeholder="<%= Orders.IdBusinessDetail.PlaceHolder %>" value="<%= Orders.IdBusinessDetail.EditValue %>"<%= Orders.IdBusinessDetail.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.SessionId.Visible Then ' SessionId %>
	<div id="r_SessionId" class="form-group">
		<label for="x_SessionId" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_SessionId"><%= Orders.SessionId.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_SessionId" id="z_SessionId" value="LIKE"></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.SessionId.CellAttributes %>>
			<span id="el_Orders_SessionId">
<input type="text" data-field="x_SessionId" name="x_SessionId" id="x_SessionId" size="30" maxlength="255" placeholder="<%= Orders.SessionId.PlaceHolder %>" value="<%= Orders.SessionId.EditValue %>"<%= Orders.SessionId.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.FirstName.Visible Then ' FirstName %>
	<div id="r_FirstName" class="form-group">
		<label for="x_FirstName" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_FirstName"><%= Orders.FirstName.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_FirstName" id="z_FirstName" value="LIKE"></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.FirstName.CellAttributes %>>
			<span id="el_Orders_FirstName">
<input type="text" data-field="x_FirstName" name="x_FirstName" id="x_FirstName" size="30" maxlength="255" placeholder="<%= Orders.FirstName.PlaceHolder %>" value="<%= Orders.FirstName.EditValue %>"<%= Orders.FirstName.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.LastName.Visible Then ' LastName %>
	<div id="r_LastName" class="form-group">
		<label for="x_LastName" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_LastName"><%= Orders.LastName.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_LastName" id="z_LastName" value="LIKE"></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.LastName.CellAttributes %>>
			<span id="el_Orders_LastName">
<input type="text" data-field="x_LastName" name="x_LastName" id="x_LastName" size="30" maxlength="255" placeholder="<%= Orders.LastName.PlaceHolder %>" value="<%= Orders.LastName.EditValue %>"<%= Orders.LastName.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.zEmail.Visible Then ' Email %>
	<div id="r_zEmail" class="form-group">
		<label for="x_zEmail" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_zEmail"><%= Orders.zEmail.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_zEmail" id="z_zEmail" value="LIKE"></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.zEmail.CellAttributes %>>
			<span id="el_Orders_zEmail">
<input type="text" data-field="x_zEmail" name="x_zEmail" id="x_zEmail" size="30" maxlength="255" placeholder="<%= Orders.zEmail.PlaceHolder %>" value="<%= Orders.zEmail.EditValue %>"<%= Orders.zEmail.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.Phone.Visible Then ' Phone %>
	<div id="r_Phone" class="form-group">
		<label for="x_Phone" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_Phone"><%= Orders.Phone.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_Phone" id="z_Phone" value="LIKE"></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.Phone.CellAttributes %>>
			<span id="el_Orders_Phone">
<input type="text" data-field="x_Phone" name="x_Phone" id="x_Phone" size="30" maxlength="255" placeholder="<%= Orders.Phone.PlaceHolder %>" value="<%= Orders.Phone.EditValue %>"<%= Orders.Phone.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.Address.Visible Then ' Address %>
	<div id="r_Address" class="form-group">
		<label for="x_Address" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_Address"><%= Orders.Address.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_Address" id="z_Address" value="LIKE"></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.Address.CellAttributes %>>
			<span id="el_Orders_Address">
<input type="text" data-field="x_Address" name="x_Address" id="x_Address" size="30" maxlength="255" placeholder="<%= Orders.Address.PlaceHolder %>" value="<%= Orders.Address.EditValue %>"<%= Orders.Address.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.PostalCode.Visible Then ' PostalCode %>
	<div id="r_PostalCode" class="form-group">
		<label for="x_PostalCode" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_PostalCode"><%= Orders.PostalCode.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_PostalCode" id="z_PostalCode" value="LIKE"></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.PostalCode.CellAttributes %>>
			<span id="el_Orders_PostalCode">
<input type="text" data-field="x_PostalCode" name="x_PostalCode" id="x_PostalCode" size="30" maxlength="255" placeholder="<%= Orders.PostalCode.PlaceHolder %>" value="<%= Orders.PostalCode.EditValue %>"<%= Orders.PostalCode.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.Notes.Visible Then ' Notes %>
	<div id="r_Notes" class="form-group">
		<label for="x_Notes" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_Notes"><%= Orders.Notes.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_Notes" id="z_Notes" value="LIKE"></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.Notes.CellAttributes %>>
			<span id="el_Orders_Notes">
<input type="text" data-field="x_Notes" name="x_Notes" id="x_Notes" size="30" maxlength="255" placeholder="<%= Orders.Notes.PlaceHolder %>" value="<%= Orders.Notes.EditValue %>"<%= Orders.Notes.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.ttest.Visible Then ' ttest %>
	<div id="r_ttest" class="form-group">
		<label for="x_ttest" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_ttest"><%= Orders.ttest.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_ttest" id="z_ttest" value="LIKE"></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.ttest.CellAttributes %>>
			<span id="el_Orders_ttest">
<input type="text" data-field="x_ttest" name="x_ttest" id="x_ttest" size="30" maxlength="255" placeholder="<%= Orders.ttest.PlaceHolder %>" value="<%= Orders.ttest.EditValue %>"<%= Orders.ttest.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.cancelleddate.Visible Then ' cancelleddate %>
	<div id="r_cancelleddate" class="form-group">
		<label for="x_cancelleddate" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_cancelleddate"><%= Orders.cancelleddate.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_cancelleddate" id="z_cancelleddate" value="="></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.cancelleddate.CellAttributes %>>
			<span id="el_Orders_cancelleddate">
<input type="text" data-field="x_cancelleddate" name="x_cancelleddate" id="x_cancelleddate" placeholder="<%= Orders.cancelleddate.PlaceHolder %>" value="<%= Orders.cancelleddate.EditValue %>"<%= Orders.cancelleddate.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.cancelledby.Visible Then ' cancelledby %>
	<div id="r_cancelledby" class="form-group">
		<label for="x_cancelledby" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_cancelledby"><%= Orders.cancelledby.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_cancelledby" id="z_cancelledby" value="LIKE"></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.cancelledby.CellAttributes %>>
			<span id="el_Orders_cancelledby">
<input type="text" data-field="x_cancelledby" name="x_cancelledby" id="x_cancelledby" size="30" maxlength="255" placeholder="<%= Orders.cancelledby.PlaceHolder %>" value="<%= Orders.cancelledby.EditValue %>"<%= Orders.cancelledby.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.cancelledreason.Visible Then ' cancelledreason %>
	<div id="r_cancelledreason" class="form-group">
		<label for="x_cancelledreason" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_cancelledreason"><%= Orders.cancelledreason.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_cancelledreason" id="z_cancelledreason" value="LIKE"></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.cancelledreason.CellAttributes %>>
			<span id="el_Orders_cancelledreason">
<input type="text" data-field="x_cancelledreason" name="x_cancelledreason" id="x_cancelledreason" size="30" maxlength="255" placeholder="<%= Orders.cancelledreason.PlaceHolder %>" value="<%= Orders.cancelledreason.EditValue %>"<%= Orders.cancelledreason.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.acknowledgeddate.Visible Then ' acknowledgeddate %>
	<div id="r_acknowledgeddate" class="form-group">
		<label for="x_acknowledgeddate" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_acknowledgeddate"><%= Orders.acknowledgeddate.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_acknowledgeddate" id="z_acknowledgeddate" value="="></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.acknowledgeddate.CellAttributes %>>
			<span id="el_Orders_acknowledgeddate">
<input type="text" data-field="x_acknowledgeddate" name="x_acknowledgeddate" id="x_acknowledgeddate" placeholder="<%= Orders.acknowledgeddate.PlaceHolder %>" value="<%= Orders.acknowledgeddate.EditValue %>"<%= Orders.acknowledgeddate.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.delivereddate.Visible Then ' delivereddate %>
	<div id="r_delivereddate" class="form-group">
		<label for="x_delivereddate" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_delivereddate"><%= Orders.delivereddate.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_delivereddate" id="z_delivereddate" value="LIKE"></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.delivereddate.CellAttributes %>>
			<span id="el_Orders_delivereddate">
<input type="text" data-field="x_delivereddate" name="x_delivereddate" id="x_delivereddate" size="30" maxlength="255" placeholder="<%= Orders.delivereddate.PlaceHolder %>" value="<%= Orders.delivereddate.EditValue %>"<%= Orders.delivereddate.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.cancelled.Visible Then ' cancelled %>
	<div id="r_cancelled" class="form-group">
		<label for="x_cancelled" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_cancelled"><%= Orders.cancelled.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_cancelled" id="z_cancelled" value="="></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.cancelled.CellAttributes %>>
			<span id="el_Orders_cancelled">
<input type="text" data-field="x_cancelled" name="x_cancelled" id="x_cancelled" size="30" placeholder="<%= Orders.cancelled.PlaceHolder %>" value="<%= Orders.cancelled.EditValue %>"<%= Orders.cancelled.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.acknowledged.Visible Then ' acknowledged %>
	<div id="r_acknowledged" class="form-group">
		<label for="x_acknowledged" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_acknowledged"><%= Orders.acknowledged.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_acknowledged" id="z_acknowledged" value="="></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.acknowledged.CellAttributes %>>
			<span id="el_Orders_acknowledged">
<input type="text" data-field="x_acknowledged" name="x_acknowledged" id="x_acknowledged" size="30" placeholder="<%= Orders.acknowledged.PlaceHolder %>" value="<%= Orders.acknowledged.EditValue %>"<%= Orders.acknowledged.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.outfordelivery.Visible Then ' outfordelivery %>
	<div id="r_outfordelivery" class="form-group">
		<label for="x_outfordelivery" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_outfordelivery"><%= Orders.outfordelivery.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_outfordelivery" id="z_outfordelivery" value="="></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.outfordelivery.CellAttributes %>>
			<span id="el_Orders_outfordelivery">
<input type="text" data-field="x_outfordelivery" name="x_outfordelivery" id="x_outfordelivery" size="30" placeholder="<%= Orders.outfordelivery.PlaceHolder %>" value="<%= Orders.outfordelivery.EditValue %>"<%= Orders.outfordelivery.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.vouchercodediscount.Visible Then ' vouchercodediscount %>
	<div id="r_vouchercodediscount" class="form-group">
		<label for="x_vouchercodediscount" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_vouchercodediscount"><%= Orders.vouchercodediscount.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_vouchercodediscount" id="z_vouchercodediscount" value="="></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.vouchercodediscount.CellAttributes %>>
			<span id="el_Orders_vouchercodediscount">
<input type="text" data-field="x_vouchercodediscount" name="x_vouchercodediscount" id="x_vouchercodediscount" size="30" placeholder="<%= Orders.vouchercodediscount.PlaceHolder %>" value="<%= Orders.vouchercodediscount.EditValue %>"<%= Orders.vouchercodediscount.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.vouchercode.Visible Then ' vouchercode %>
	<div id="r_vouchercode" class="form-group">
		<label for="x_vouchercode" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_vouchercode"><%= Orders.vouchercode.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_vouchercode" id="z_vouchercode" value="LIKE"></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.vouchercode.CellAttributes %>>
			<span id="el_Orders_vouchercode">
<input type="text" data-field="x_vouchercode" name="x_vouchercode" id="x_vouchercode" size="30" maxlength="255" placeholder="<%= Orders.vouchercode.PlaceHolder %>" value="<%= Orders.vouchercode.EditValue %>"<%= Orders.vouchercode.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.printed.Visible Then ' printed %>
	<div id="r_printed" class="form-group">
		<label for="x_printed" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_printed"><%= Orders.printed.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_printed" id="z_printed" value="="></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.printed.CellAttributes %>>
			<span id="el_Orders_printed">
<input type="text" data-field="x_printed" name="x_printed" id="x_printed" size="30" placeholder="<%= Orders.printed.PlaceHolder %>" value="<%= Orders.printed.EditValue %>"<%= Orders.printed.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.deliverydistance.Visible Then ' deliverydistance %>
	<div id="r_deliverydistance" class="form-group">
		<label for="x_deliverydistance" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_deliverydistance"><%= Orders.deliverydistance.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_deliverydistance" id="z_deliverydistance" value="LIKE"></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.deliverydistance.CellAttributes %>>
			<span id="el_Orders_deliverydistance">
<input type="text" data-field="x_deliverydistance" name="x_deliverydistance" id="x_deliverydistance" size="30" maxlength="255" placeholder="<%= Orders.deliverydistance.PlaceHolder %>" value="<%= Orders.deliverydistance.EditValue %>"<%= Orders.deliverydistance.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.asaporder.Visible Then ' asaporder %>
	<div id="r_asaporder" class="form-group">
		<label for="x_asaporder" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_asaporder"><%= Orders.asaporder.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_asaporder" id="z_asaporder" value="LIKE"></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.asaporder.CellAttributes %>>
			<span id="el_Orders_asaporder">
<input type="text" data-field="x_asaporder" name="x_asaporder" id="x_asaporder" size="30" maxlength="255" placeholder="<%= Orders.asaporder.PlaceHolder %>" value="<%= Orders.asaporder.EditValue %>"<%= Orders.asaporder.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.DeliveryLat.Visible Then ' DeliveryLat %>
	<div id="r_DeliveryLat" class="form-group">
		<label for="x_DeliveryLat" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_DeliveryLat"><%= Orders.DeliveryLat.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_DeliveryLat" id="z_DeliveryLat" value="LIKE"></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.DeliveryLat.CellAttributes %>>
			<span id="el_Orders_DeliveryLat">
<input type="text" data-field="x_DeliveryLat" name="x_DeliveryLat" id="x_DeliveryLat" size="30" maxlength="50" placeholder="<%= Orders.DeliveryLat.PlaceHolder %>" value="<%= Orders.DeliveryLat.EditValue %>"<%= Orders.DeliveryLat.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.DeliveryLng.Visible Then ' DeliveryLng %>
	<div id="r_DeliveryLng" class="form-group">
		<label for="x_DeliveryLng" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_DeliveryLng"><%= Orders.DeliveryLng.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_DeliveryLng" id="z_DeliveryLng" value="LIKE"></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.DeliveryLng.CellAttributes %>>
			<span id="el_Orders_DeliveryLng">
<input type="text" data-field="x_DeliveryLng" name="x_DeliveryLng" id="x_DeliveryLng" size="30" maxlength="50" placeholder="<%= Orders.DeliveryLng.PlaceHolder %>" value="<%= Orders.DeliveryLng.EditValue %>"<%= Orders.DeliveryLng.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.ServiceCharge.Visible Then ' ServiceCharge %>
	<div id="r_ServiceCharge" class="form-group">
		<label for="x_ServiceCharge" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_ServiceCharge"><%= Orders.ServiceCharge.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_ServiceCharge" id="z_ServiceCharge" value="="></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.ServiceCharge.CellAttributes %>>
			<span id="el_Orders_ServiceCharge">
<input type="text" data-field="x_ServiceCharge" name="x_ServiceCharge" id="x_ServiceCharge" size="30" placeholder="<%= Orders.ServiceCharge.PlaceHolder %>" value="<%= Orders.ServiceCharge.EditValue %>"<%= Orders.ServiceCharge.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.PaymentSurcharge.Visible Then ' PaymentSurcharge %>
	<div id="r_PaymentSurcharge" class="form-group">
		<label for="x_PaymentSurcharge" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_PaymentSurcharge"><%= Orders.PaymentSurcharge.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_PaymentSurcharge" id="z_PaymentSurcharge" value="="></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.PaymentSurcharge.CellAttributes %>>
			<span id="el_Orders_PaymentSurcharge">
<input type="text" data-field="x_PaymentSurcharge" name="x_PaymentSurcharge" id="x_PaymentSurcharge" size="30" placeholder="<%= Orders.PaymentSurcharge.PlaceHolder %>" value="<%= Orders.PaymentSurcharge.EditValue %>"<%= Orders.PaymentSurcharge.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.FromIP.Visible Then ' FromIP %>
	<div id="r_FromIP" class="form-group">
		<label for="x_FromIP" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_FromIP"><%= Orders.FromIP.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_FromIP" id="z_FromIP" value="LIKE"></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.FromIP.CellAttributes %>>
			<span id="el_Orders_FromIP">
<input type="text" data-field="x_FromIP" name="x_FromIP" id="x_FromIP" size="30" maxlength="30" placeholder="<%= Orders.FromIP.PlaceHolder %>" value="<%= Orders.FromIP.EditValue %>"<%= Orders.FromIP.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.Tax_Rate.Visible Then ' Tax_Rate %>
	<div id="r_Tax_Rate" class="form-group">
		<label for="x_Tax_Rate" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_Tax_Rate"><%= Orders.Tax_Rate.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_Tax_Rate" id="z_Tax_Rate" value="="></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.Tax_Rate.CellAttributes %>>
			<span id="el_Orders_Tax_Rate">
<input type="text" data-field="x_Tax_Rate" name="x_Tax_Rate" id="x_Tax_Rate" size="30" placeholder="<%= Orders.Tax_Rate.PlaceHolder %>" value="<%= Orders.Tax_Rate.EditValue %>"<%= Orders.Tax_Rate.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.Tax_Amount.Visible Then ' Tax_Amount %>
	<div id="r_Tax_Amount" class="form-group">
		<label for="x_Tax_Amount" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_Tax_Amount"><%= Orders.Tax_Amount.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_Tax_Amount" id="z_Tax_Amount" value="="></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.Tax_Amount.CellAttributes %>>
			<span id="el_Orders_Tax_Amount">
<input type="text" data-field="x_Tax_Amount" name="x_Tax_Amount" id="x_Tax_Amount" size="30" placeholder="<%= Orders.Tax_Amount.PlaceHolder %>" value="<%= Orders.Tax_Amount.EditValue %>"<%= Orders.Tax_Amount.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.Tip_Rate.Visible Then ' Tip_Rate %>
	<div id="r_Tip_Rate" class="form-group">
		<label for="x_Tip_Rate" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_Tip_Rate"><%= Orders.Tip_Rate.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_Tip_Rate" id="z_Tip_Rate" value="LIKE"></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.Tip_Rate.CellAttributes %>>
			<span id="el_Orders_Tip_Rate">
<input type="text" data-field="x_Tip_Rate" name="x_Tip_Rate" id="x_Tip_Rate" size="30" maxlength="255" placeholder="<%= Orders.Tip_Rate.PlaceHolder %>" value="<%= Orders.Tip_Rate.EditValue %>"<%= Orders.Tip_Rate.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.Tip_Amount.Visible Then ' Tip_Amount %>
	<div id="r_Tip_Amount" class="form-group">
		<label for="x_Tip_Amount" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_Tip_Amount"><%= Orders.Tip_Amount.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_Tip_Amount" id="z_Tip_Amount" value="="></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.Tip_Amount.CellAttributes %>>
			<span id="el_Orders_Tip_Amount">
<input type="text" data-field="x_Tip_Amount" name="x_Tip_Amount" id="x_Tip_Amount" size="30" placeholder="<%= Orders.Tip_Amount.PlaceHolder %>" value="<%= Orders.Tip_Amount.EditValue %>"<%= Orders.Tip_Amount.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.Card_Debit.Visible Then ' Card_Debit %>
	<div id="r_Card_Debit" class="form-group">
		<label for="x_Card_Debit" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_Card_Debit"><%= Orders.Card_Debit.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_Card_Debit" id="z_Card_Debit" value="="></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.Card_Debit.CellAttributes %>>
			<span id="el_Orders_Card_Debit">
<input type="text" data-field="x_Card_Debit" name="x_Card_Debit" id="x_Card_Debit" size="30" placeholder="<%= Orders.Card_Debit.PlaceHolder %>" value="<%= Orders.Card_Debit.EditValue %>"<%= Orders.Card_Debit.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.Card_Credit.Visible Then ' Card_Credit %>
	<div id="r_Card_Credit" class="form-group">
		<label for="x_Card_Credit" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_Card_Credit"><%= Orders.Card_Credit.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_Card_Credit" id="z_Card_Credit" value="="></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.Card_Credit.CellAttributes %>>
			<span id="el_Orders_Card_Credit">
<input type="text" data-field="x_Card_Credit" name="x_Card_Credit" id="x_Card_Credit" size="30" placeholder="<%= Orders.Card_Credit.PlaceHolder %>" value="<%= Orders.Card_Credit.EditValue %>"<%= Orders.Card_Credit.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.SentEmail.Visible Then ' SentEmail %>
	<div id="r_SentEmail" class="form-group">
		<label for="x_SentEmail" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_SentEmail"><%= Orders.SentEmail.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_SentEmail" id="z_SentEmail" value="LIKE"></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.SentEmail.CellAttributes %>>
			<span id="el_Orders_SentEmail">
<input type="text" data-field="x_SentEmail" name="x_SentEmail" id="x_SentEmail" size="30" maxlength="255" placeholder="<%= Orders.SentEmail.PlaceHolder %>" value="<%= Orders.SentEmail.EditValue %>"<%= Orders.SentEmail.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.deliverydelay.Visible Then ' deliverydelay %>
	<div id="r_deliverydelay" class="form-group">
		<label for="x_deliverydelay" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_deliverydelay"><%= Orders.deliverydelay.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_deliverydelay" id="z_deliverydelay" value="="></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.deliverydelay.CellAttributes %>>
			<span id="el_Orders_deliverydelay">
<input type="text" data-field="x_deliverydelay" name="x_deliverydelay" id="x_deliverydelay" size="30" placeholder="<%= Orders.deliverydelay.PlaceHolder %>" value="<%= Orders.deliverydelay.EditValue %>"<%= Orders.deliverydelay.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.collectiondelay.Visible Then ' collectiondelay %>
	<div id="r_collectiondelay" class="form-group">
		<label for="x_collectiondelay" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_collectiondelay"><%= Orders.collectiondelay.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_collectiondelay" id="z_collectiondelay" value="="></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.collectiondelay.CellAttributes %>>
			<span id="el_Orders_collectiondelay">
<input type="text" data-field="x_collectiondelay" name="x_collectiondelay" id="x_collectiondelay" size="30" placeholder="<%= Orders.collectiondelay.PlaceHolder %>" value="<%= Orders.collectiondelay.EditValue %>"<%= Orders.collectiondelay.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.paymentstatus.Visible Then ' paymentstatus %>
	<div id="r_paymentstatus" class="form-group">
		<label for="x_paymentstatus" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_paymentstatus"><%= Orders.paymentstatus.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_paymentstatus" id="z_paymentstatus" value="LIKE"></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.paymentstatus.CellAttributes %>>
			<span id="el_Orders_paymentstatus">
<input type="text" data-field="x_paymentstatus" name="x_paymentstatus" id="x_paymentstatus" size="30" maxlength="255" placeholder="<%= Orders.paymentstatus.PlaceHolder %>" value="<%= Orders.paymentstatus.EditValue %>"<%= Orders.paymentstatus.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.lng_report.Visible Then ' lng_report %>
	<div id="r_lng_report" class="form-group">
		<label for="x_lng_report" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_lng_report"><%= Orders.lng_report.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_lng_report" id="z_lng_report" value="LIKE"></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.lng_report.CellAttributes %>>
			<span id="el_Orders_lng_report">
<input type="text" data-field="x_lng_report" name="x_lng_report" id="x_lng_report" size="30" maxlength="255" placeholder="<%= Orders.lng_report.PlaceHolder %>" value="<%= Orders.lng_report.EditValue %>"<%= Orders.lng_report.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.lat_report.Visible Then ' lat_report %>
	<div id="r_lat_report" class="form-group">
		<label for="x_lat_report" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_lat_report"><%= Orders.lat_report.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_lat_report" id="z_lat_report" value="LIKE"></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.lat_report.CellAttributes %>>
			<span id="el_Orders_lat_report">
<input type="text" data-field="x_lat_report" name="x_lat_report" id="x_lat_report" size="30" maxlength="255" placeholder="<%= Orders.lat_report.PlaceHolder %>" value="<%= Orders.lat_report.EditValue %>"<%= Orders.lat_report.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If Orders.Payment_status.Visible Then ' Payment_status %>
	<div id="r_Payment_status" class="form-group">
		<label for="x_Payment_status" class="<%= Orders_search.SearchLabelClass %>"><span id="elh_Orders_Payment_status"><%= Orders.Payment_status.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_Payment_status" id="z_Payment_status" value="LIKE"></p>
		</label>
		<div class="<%= Orders_search.SearchRightColumnClass %>"><div<%= Orders.Payment_status.CellAttributes %>>
			<span id="el_Orders_Payment_status">
<input type="text" data-field="x_Payment_status" name="x_Payment_status" id="x_Payment_status" size="30" maxlength="255" placeholder="<%= Orders.Payment_status.PlaceHolder %>" value="<%= Orders.Payment_status.EditValue %>"<%= Orders.Payment_status.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
</div>
<% If Not Orders_search.IsModal Then %>
<div class="form-group">
	<div class="col-sm-offset-3 col-sm-9">
<button class="btn btn-primary ewButton" name="btnAction" id="btnAction" type="submit"><%= Language.Phrase("Search") %></button>
<button class="btn btn-default ewButton" name="btnReset" id="btnReset" type="button" onclick="ew_ClearForm(this.form);"><%= Language.Phrase("Reset") %></button>
	</div>
</div>
<% End If %>
</form>
<script type="text/javascript">
fOrderssearch.Init();
</script>
<%
Orders_search.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set Orders_search = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cOrders_search

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
		TableName = "Orders"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "Orders_search"
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
		EW_PAGE_ID = "search"

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
			Orders.CurrentAction = ObjForm.GetValue("a_search")
			Select Case Orders.CurrentAction
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
						sSrchStr = Orders.UrlParm(sSrchStr)
						sSrchStr = "Orderslist.asp" & "?" & sSrchStr
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
		Orders.RowType = EW_ROWTYPE_SEARCH
		Call RenderRow()
	End Sub

	' -----------------------------------------------------------------
	' Build advanced search
	'
	Function BuildAdvancedSearch()
		Dim sSrchUrl
		sSrchUrl = ""
		Call BuildSearchUrl(sSrchUrl, Orders.ID, False) ' ID
		Call BuildSearchUrl(sSrchUrl, Orders.CreationDate, False) ' CreationDate
		Call BuildSearchUrl(sSrchUrl, Orders.OrderDate, False) ' OrderDate
		Call BuildSearchUrl(sSrchUrl, Orders.DeliveryType, False) ' DeliveryType
		Call BuildSearchUrl(sSrchUrl, Orders.DeliveryTime, False) ' DeliveryTime
		Call BuildSearchUrl(sSrchUrl, Orders.PaymentType, False) ' PaymentType
		Call BuildSearchUrl(sSrchUrl, Orders.SubTotal, False) ' SubTotal
		Call BuildSearchUrl(sSrchUrl, Orders.ShippingFee, False) ' ShippingFee
		Call BuildSearchUrl(sSrchUrl, Orders.OrderTotal, False) ' OrderTotal
		Call BuildSearchUrl(sSrchUrl, Orders.IdBusinessDetail, False) ' IdBusinessDetail
		Call BuildSearchUrl(sSrchUrl, Orders.SessionId, False) ' SessionId
		Call BuildSearchUrl(sSrchUrl, Orders.FirstName, False) ' FirstName
		Call BuildSearchUrl(sSrchUrl, Orders.LastName, False) ' LastName
		Call BuildSearchUrl(sSrchUrl, Orders.zEmail, False) ' Email
		Call BuildSearchUrl(sSrchUrl, Orders.Phone, False) ' Phone
		Call BuildSearchUrl(sSrchUrl, Orders.Address, False) ' Address
		Call BuildSearchUrl(sSrchUrl, Orders.PostalCode, False) ' PostalCode
		Call BuildSearchUrl(sSrchUrl, Orders.Notes, False) ' Notes
		Call BuildSearchUrl(sSrchUrl, Orders.ttest, False) ' ttest
		Call BuildSearchUrl(sSrchUrl, Orders.cancelleddate, False) ' cancelleddate
		Call BuildSearchUrl(sSrchUrl, Orders.cancelledby, False) ' cancelledby
		Call BuildSearchUrl(sSrchUrl, Orders.cancelledreason, False) ' cancelledreason
		Call BuildSearchUrl(sSrchUrl, Orders.acknowledgeddate, False) ' acknowledgeddate
		Call BuildSearchUrl(sSrchUrl, Orders.delivereddate, False) ' delivereddate
		Call BuildSearchUrl(sSrchUrl, Orders.cancelled, False) ' cancelled
		Call BuildSearchUrl(sSrchUrl, Orders.acknowledged, False) ' acknowledged
		Call BuildSearchUrl(sSrchUrl, Orders.outfordelivery, False) ' outfordelivery
		Call BuildSearchUrl(sSrchUrl, Orders.vouchercodediscount, False) ' vouchercodediscount
		Call BuildSearchUrl(sSrchUrl, Orders.vouchercode, False) ' vouchercode
		Call BuildSearchUrl(sSrchUrl, Orders.printed, False) ' printed
		Call BuildSearchUrl(sSrchUrl, Orders.deliverydistance, False) ' deliverydistance
		Call BuildSearchUrl(sSrchUrl, Orders.asaporder, False) ' asaporder
		Call BuildSearchUrl(sSrchUrl, Orders.DeliveryLat, False) ' DeliveryLat
		Call BuildSearchUrl(sSrchUrl, Orders.DeliveryLng, False) ' DeliveryLng
		Call BuildSearchUrl(sSrchUrl, Orders.ServiceCharge, False) ' ServiceCharge
		Call BuildSearchUrl(sSrchUrl, Orders.PaymentSurcharge, False) ' PaymentSurcharge
		Call BuildSearchUrl(sSrchUrl, Orders.FromIP, False) ' FromIP
		Call BuildSearchUrl(sSrchUrl, Orders.Tax_Rate, False) ' Tax_Rate
		Call BuildSearchUrl(sSrchUrl, Orders.Tax_Amount, False) ' Tax_Amount
		Call BuildSearchUrl(sSrchUrl, Orders.Tip_Rate, False) ' Tip_Rate
		Call BuildSearchUrl(sSrchUrl, Orders.Tip_Amount, False) ' Tip_Amount
		Call BuildSearchUrl(sSrchUrl, Orders.Card_Debit, False) ' Card_Debit
		Call BuildSearchUrl(sSrchUrl, Orders.Card_Credit, False) ' Card_Credit
		Call BuildSearchUrl(sSrchUrl, Orders.SentEmail, False) ' SentEmail
		Call BuildSearchUrl(sSrchUrl, Orders.deliverydelay, False) ' deliverydelay
		Call BuildSearchUrl(sSrchUrl, Orders.collectiondelay, False) ' collectiondelay
		Call BuildSearchUrl(sSrchUrl, Orders.paymentstatus, False) ' paymentstatus
		Call BuildSearchUrl(sSrchUrl, Orders.lng_report, False) ' lng_report
		Call BuildSearchUrl(sSrchUrl, Orders.lat_report, False) ' lat_report
		Call BuildSearchUrl(sSrchUrl, Orders.Payment_status, False) ' Payment_status
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
		Orders.ID.AdvancedSearch.SearchValue = ObjForm.GetValue("x_ID")
		Orders.ID.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_ID")
		Orders.CreationDate.AdvancedSearch.SearchValue = ObjForm.GetValue("x_CreationDate")
		Orders.CreationDate.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_CreationDate")
		Orders.OrderDate.AdvancedSearch.SearchValue = ObjForm.GetValue("x_OrderDate")
		Orders.OrderDate.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_OrderDate")
		Orders.DeliveryType.AdvancedSearch.SearchValue = ObjForm.GetValue("x_DeliveryType")
		Orders.DeliveryType.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_DeliveryType")
		Orders.DeliveryTime.AdvancedSearch.SearchValue = ObjForm.GetValue("x_DeliveryTime")
		Orders.DeliveryTime.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_DeliveryTime")
		Orders.PaymentType.AdvancedSearch.SearchValue = ObjForm.GetValue("x_PaymentType")
		Orders.PaymentType.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_PaymentType")
		Orders.SubTotal.AdvancedSearch.SearchValue = ObjForm.GetValue("x_SubTotal")
		Orders.SubTotal.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_SubTotal")
		Orders.ShippingFee.AdvancedSearch.SearchValue = ObjForm.GetValue("x_ShippingFee")
		Orders.ShippingFee.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_ShippingFee")
		Orders.OrderTotal.AdvancedSearch.SearchValue = ObjForm.GetValue("x_OrderTotal")
		Orders.OrderTotal.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_OrderTotal")
		Orders.IdBusinessDetail.AdvancedSearch.SearchValue = ObjForm.GetValue("x_IdBusinessDetail")
		Orders.IdBusinessDetail.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_IdBusinessDetail")
		Orders.SessionId.AdvancedSearch.SearchValue = ObjForm.GetValue("x_SessionId")
		Orders.SessionId.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_SessionId")
		Orders.FirstName.AdvancedSearch.SearchValue = ObjForm.GetValue("x_FirstName")
		Orders.FirstName.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_FirstName")
		Orders.LastName.AdvancedSearch.SearchValue = ObjForm.GetValue("x_LastName")
		Orders.LastName.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_LastName")
		Orders.zEmail.AdvancedSearch.SearchValue = ObjForm.GetValue("x_zEmail")
		Orders.zEmail.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_zEmail")
		Orders.Phone.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Phone")
		Orders.Phone.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Phone")
		Orders.Address.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Address")
		Orders.Address.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Address")
		Orders.PostalCode.AdvancedSearch.SearchValue = ObjForm.GetValue("x_PostalCode")
		Orders.PostalCode.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_PostalCode")
		Orders.Notes.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Notes")
		Orders.Notes.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Notes")
		Orders.ttest.AdvancedSearch.SearchValue = ObjForm.GetValue("x_ttest")
		Orders.ttest.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_ttest")
		Orders.cancelleddate.AdvancedSearch.SearchValue = ObjForm.GetValue("x_cancelleddate")
		Orders.cancelleddate.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_cancelleddate")
		Orders.cancelledby.AdvancedSearch.SearchValue = ObjForm.GetValue("x_cancelledby")
		Orders.cancelledby.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_cancelledby")
		Orders.cancelledreason.AdvancedSearch.SearchValue = ObjForm.GetValue("x_cancelledreason")
		Orders.cancelledreason.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_cancelledreason")
		Orders.acknowledgeddate.AdvancedSearch.SearchValue = ObjForm.GetValue("x_acknowledgeddate")
		Orders.acknowledgeddate.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_acknowledgeddate")
		Orders.delivereddate.AdvancedSearch.SearchValue = ObjForm.GetValue("x_delivereddate")
		Orders.delivereddate.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_delivereddate")
		Orders.cancelled.AdvancedSearch.SearchValue = ObjForm.GetValue("x_cancelled")
		Orders.cancelled.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_cancelled")
		Orders.acknowledged.AdvancedSearch.SearchValue = ObjForm.GetValue("x_acknowledged")
		Orders.acknowledged.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_acknowledged")
		Orders.outfordelivery.AdvancedSearch.SearchValue = ObjForm.GetValue("x_outfordelivery")
		Orders.outfordelivery.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_outfordelivery")
		Orders.vouchercodediscount.AdvancedSearch.SearchValue = ObjForm.GetValue("x_vouchercodediscount")
		Orders.vouchercodediscount.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_vouchercodediscount")
		Orders.vouchercode.AdvancedSearch.SearchValue = ObjForm.GetValue("x_vouchercode")
		Orders.vouchercode.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_vouchercode")
		Orders.printed.AdvancedSearch.SearchValue = ObjForm.GetValue("x_printed")
		Orders.printed.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_printed")
		Orders.deliverydistance.AdvancedSearch.SearchValue = ObjForm.GetValue("x_deliverydistance")
		Orders.deliverydistance.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_deliverydistance")
		Orders.asaporder.AdvancedSearch.SearchValue = ObjForm.GetValue("x_asaporder")
		Orders.asaporder.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_asaporder")
		Orders.DeliveryLat.AdvancedSearch.SearchValue = ObjForm.GetValue("x_DeliveryLat")
		Orders.DeliveryLat.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_DeliveryLat")
		Orders.DeliveryLng.AdvancedSearch.SearchValue = ObjForm.GetValue("x_DeliveryLng")
		Orders.DeliveryLng.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_DeliveryLng")
		Orders.ServiceCharge.AdvancedSearch.SearchValue = ObjForm.GetValue("x_ServiceCharge")
		Orders.ServiceCharge.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_ServiceCharge")
		Orders.PaymentSurcharge.AdvancedSearch.SearchValue = ObjForm.GetValue("x_PaymentSurcharge")
		Orders.PaymentSurcharge.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_PaymentSurcharge")
		Orders.FromIP.AdvancedSearch.SearchValue = ObjForm.GetValue("x_FromIP")
		Orders.FromIP.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_FromIP")
		Orders.Tax_Rate.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Tax_Rate")
		Orders.Tax_Rate.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Tax_Rate")
		Orders.Tax_Amount.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Tax_Amount")
		Orders.Tax_Amount.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Tax_Amount")
		Orders.Tip_Rate.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Tip_Rate")
		Orders.Tip_Rate.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Tip_Rate")
		Orders.Tip_Amount.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Tip_Amount")
		Orders.Tip_Amount.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Tip_Amount")
		Orders.Card_Debit.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Card_Debit")
		Orders.Card_Debit.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Card_Debit")
		Orders.Card_Credit.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Card_Credit")
		Orders.Card_Credit.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Card_Credit")
		Orders.SentEmail.AdvancedSearch.SearchValue = ObjForm.GetValue("x_SentEmail")
		Orders.SentEmail.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_SentEmail")
		Orders.deliverydelay.AdvancedSearch.SearchValue = ObjForm.GetValue("x_deliverydelay")
		Orders.deliverydelay.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_deliverydelay")
		Orders.collectiondelay.AdvancedSearch.SearchValue = ObjForm.GetValue("x_collectiondelay")
		Orders.collectiondelay.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_collectiondelay")
		Orders.paymentstatus.AdvancedSearch.SearchValue = ObjForm.GetValue("x_paymentstatus")
		Orders.paymentstatus.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_paymentstatus")
		Orders.lng_report.AdvancedSearch.SearchValue = ObjForm.GetValue("x_lng_report")
		Orders.lng_report.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_lng_report")
		Orders.lat_report.AdvancedSearch.SearchValue = ObjForm.GetValue("x_lat_report")
		Orders.lat_report.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_lat_report")
		Orders.Payment_status.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Payment_status")
		Orders.Payment_status.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Payment_status")
	End Function

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
		' Tax_Rate
		' Tax_Amount
		' Tip_Rate
		' Tip_Amount
		' Card_Debit
		' Card_Credit
		' SentEmail
		' deliverydelay
		' collectiondelay
		' paymentstatus
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
			Orders.CreationDate.ViewValue = ew_FormatDateTime(Orders.CreationDate.ViewValue, 9)
			Orders.CreationDate.ViewCustomAttributes = ""

			' OrderDate
			Orders.OrderDate.ViewValue = Orders.OrderDate.CurrentValue
			Orders.OrderDate.ViewValue = ew_FormatDateTime(Orders.OrderDate.ViewValue, 9)
			Orders.OrderDate.ViewCustomAttributes = ""

			' DeliveryType
			Orders.DeliveryType.ViewValue = Orders.DeliveryType.CurrentValue
			Orders.DeliveryType.ViewCustomAttributes = ""

			' DeliveryTime
			Orders.DeliveryTime.ViewValue = Orders.DeliveryTime.CurrentValue
			Orders.DeliveryTime.ViewValue = ew_FormatDateTime(Orders.DeliveryTime.ViewValue, 9)
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
			Orders.cancelleddate.ViewValue = ew_FormatDateTime(Orders.cancelleddate.ViewValue, 9)
			Orders.cancelleddate.ViewCustomAttributes = ""

			' cancelledby
			Orders.cancelledby.ViewValue = Orders.cancelledby.CurrentValue
			Orders.cancelledby.ViewCustomAttributes = ""

			' cancelledreason
			Orders.cancelledreason.ViewValue = Orders.cancelledreason.CurrentValue
			Orders.cancelledreason.ViewCustomAttributes = ""

			' acknowledgeddate
			Orders.acknowledgeddate.ViewValue = Orders.acknowledgeddate.CurrentValue
			Orders.acknowledgeddate.ViewValue = ew_FormatDateTime(Orders.acknowledgeddate.ViewValue, 9)
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

			' SentEmail
			Orders.SentEmail.ViewValue = Orders.SentEmail.CurrentValue
			Orders.SentEmail.ViewCustomAttributes = ""

			' deliverydelay
			Orders.deliverydelay.ViewValue = Orders.deliverydelay.CurrentValue
			Orders.deliverydelay.ViewCustomAttributes = ""

			' collectiondelay
			Orders.collectiondelay.ViewValue = Orders.collectiondelay.CurrentValue
			Orders.collectiondelay.ViewCustomAttributes = ""

			' paymentstatus
			Orders.paymentstatus.ViewValue = Orders.paymentstatus.CurrentValue
			Orders.paymentstatus.ViewCustomAttributes = ""

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

			' SentEmail
			Orders.SentEmail.LinkCustomAttributes = ""
			Orders.SentEmail.HrefValue = ""
			Orders.SentEmail.TooltipValue = ""

			' deliverydelay
			Orders.deliverydelay.LinkCustomAttributes = ""
			Orders.deliverydelay.HrefValue = ""
			Orders.deliverydelay.TooltipValue = ""

			' collectiondelay
			Orders.collectiondelay.LinkCustomAttributes = ""
			Orders.collectiondelay.HrefValue = ""
			Orders.collectiondelay.TooltipValue = ""

			' paymentstatus
			Orders.paymentstatus.LinkCustomAttributes = ""
			Orders.paymentstatus.HrefValue = ""
			Orders.paymentstatus.TooltipValue = ""

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

		' ------------
		'  Search Row
		' ------------

		ElseIf Orders.RowType = EW_ROWTYPE_SEARCH Then ' Search row

			' ID
			Orders.ID.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.ID.EditCustomAttributes = ""
			Orders.ID.EditValue = ew_HtmlEncode(Orders.ID.AdvancedSearch.SearchValue)
			Orders.ID.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.ID.FldCaption))

			' CreationDate
			Orders.CreationDate.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.CreationDate.EditCustomAttributes = ""
			Orders.CreationDate.EditValue = ew_FormatDateTime(ew_UnFormatDateTime(Orders.CreationDate.AdvancedSearch.SearchValue, 9), 9)
			Orders.CreationDate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.CreationDate.FldCaption))

			' OrderDate
			Orders.OrderDate.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.OrderDate.EditCustomAttributes = ""
			Orders.OrderDate.EditValue = ew_FormatDateTime(ew_UnFormatDateTime(Orders.OrderDate.AdvancedSearch.SearchValue, 9), 9)
			Orders.OrderDate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.OrderDate.FldCaption))

			' DeliveryType
			Orders.DeliveryType.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.DeliveryType.EditCustomAttributes = ""
			Orders.DeliveryType.EditValue = ew_HtmlEncode(Orders.DeliveryType.AdvancedSearch.SearchValue)
			Orders.DeliveryType.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.DeliveryType.FldCaption))

			' DeliveryTime
			Orders.DeliveryTime.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.DeliveryTime.EditCustomAttributes = ""
			Orders.DeliveryTime.EditValue = ew_FormatDateTime(ew_UnFormatDateTime(Orders.DeliveryTime.AdvancedSearch.SearchValue, 9), 9)
			Orders.DeliveryTime.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.DeliveryTime.FldCaption))

			' PaymentType
			Orders.PaymentType.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.PaymentType.EditCustomAttributes = ""
			Orders.PaymentType.EditValue = ew_HtmlEncode(Orders.PaymentType.AdvancedSearch.SearchValue)
			Orders.PaymentType.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.PaymentType.FldCaption))

			' SubTotal
			Orders.SubTotal.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.SubTotal.EditCustomAttributes = ""
			Orders.SubTotal.EditValue = ew_HtmlEncode(Orders.SubTotal.AdvancedSearch.SearchValue)
			Orders.SubTotal.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.SubTotal.FldCaption))

			' ShippingFee
			Orders.ShippingFee.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.ShippingFee.EditCustomAttributes = ""
			Orders.ShippingFee.EditValue = ew_HtmlEncode(Orders.ShippingFee.AdvancedSearch.SearchValue)
			Orders.ShippingFee.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.ShippingFee.FldCaption))

			' OrderTotal
			Orders.OrderTotal.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.OrderTotal.EditCustomAttributes = ""
			Orders.OrderTotal.EditValue = ew_HtmlEncode(Orders.OrderTotal.AdvancedSearch.SearchValue)
			Orders.OrderTotal.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.OrderTotal.FldCaption))

			' IdBusinessDetail
			Orders.IdBusinessDetail.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.IdBusinessDetail.EditCustomAttributes = ""
			Orders.IdBusinessDetail.EditValue = ew_HtmlEncode(Orders.IdBusinessDetail.AdvancedSearch.SearchValue)
			Orders.IdBusinessDetail.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.IdBusinessDetail.FldCaption))

			' SessionId
			Orders.SessionId.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.SessionId.EditCustomAttributes = ""
			Orders.SessionId.EditValue = ew_HtmlEncode(Orders.SessionId.AdvancedSearch.SearchValue)
			Orders.SessionId.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.SessionId.FldCaption))

			' FirstName
			Orders.FirstName.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.FirstName.EditCustomAttributes = ""
			Orders.FirstName.EditValue = ew_HtmlEncode(Orders.FirstName.AdvancedSearch.SearchValue)
			Orders.FirstName.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.FirstName.FldCaption))

			' LastName
			Orders.LastName.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.LastName.EditCustomAttributes = ""
			Orders.LastName.EditValue = ew_HtmlEncode(Orders.LastName.AdvancedSearch.SearchValue)
			Orders.LastName.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.LastName.FldCaption))

			' Email
			Orders.zEmail.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.zEmail.EditCustomAttributes = ""
			Orders.zEmail.EditValue = ew_HtmlEncode(Orders.zEmail.AdvancedSearch.SearchValue)
			Orders.zEmail.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.zEmail.FldCaption))

			' Phone
			Orders.Phone.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.Phone.EditCustomAttributes = ""
			Orders.Phone.EditValue = ew_HtmlEncode(Orders.Phone.AdvancedSearch.SearchValue)
			Orders.Phone.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.Phone.FldCaption))

			' Address
			Orders.Address.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.Address.EditCustomAttributes = ""
			Orders.Address.EditValue = ew_HtmlEncode(Orders.Address.AdvancedSearch.SearchValue)
			Orders.Address.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.Address.FldCaption))

			' PostalCode
			Orders.PostalCode.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.PostalCode.EditCustomAttributes = ""
			Orders.PostalCode.EditValue = ew_HtmlEncode(Orders.PostalCode.AdvancedSearch.SearchValue)
			Orders.PostalCode.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.PostalCode.FldCaption))

			' Notes
			Orders.Notes.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.Notes.EditCustomAttributes = ""
			Orders.Notes.EditValue = ew_HtmlEncode(Orders.Notes.AdvancedSearch.SearchValue)
			Orders.Notes.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.Notes.FldCaption))

			' ttest
			Orders.ttest.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.ttest.EditCustomAttributes = ""
			Orders.ttest.EditValue = ew_HtmlEncode(Orders.ttest.AdvancedSearch.SearchValue)
			Orders.ttest.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.ttest.FldCaption))

			' cancelleddate
			Orders.cancelleddate.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.cancelleddate.EditCustomAttributes = ""
			Orders.cancelleddate.EditValue = ew_FormatDateTime(ew_UnFormatDateTime(Orders.cancelleddate.AdvancedSearch.SearchValue, 9), 9)
			Orders.cancelleddate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.cancelleddate.FldCaption))

			' cancelledby
			Orders.cancelledby.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.cancelledby.EditCustomAttributes = ""
			Orders.cancelledby.EditValue = ew_HtmlEncode(Orders.cancelledby.AdvancedSearch.SearchValue)
			Orders.cancelledby.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.cancelledby.FldCaption))

			' cancelledreason
			Orders.cancelledreason.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.cancelledreason.EditCustomAttributes = ""
			Orders.cancelledreason.EditValue = ew_HtmlEncode(Orders.cancelledreason.AdvancedSearch.SearchValue)
			Orders.cancelledreason.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.cancelledreason.FldCaption))

			' acknowledgeddate
			Orders.acknowledgeddate.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.acknowledgeddate.EditCustomAttributes = ""
			Orders.acknowledgeddate.EditValue = ew_FormatDateTime(ew_UnFormatDateTime(Orders.acknowledgeddate.AdvancedSearch.SearchValue, 9), 9)
			Orders.acknowledgeddate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.acknowledgeddate.FldCaption))

			' delivereddate
			Orders.delivereddate.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.delivereddate.EditCustomAttributes = ""
			Orders.delivereddate.EditValue = ew_HtmlEncode(Orders.delivereddate.AdvancedSearch.SearchValue)
			Orders.delivereddate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.delivereddate.FldCaption))

			' cancelled
			Orders.cancelled.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.cancelled.EditCustomAttributes = ""
			Orders.cancelled.EditValue = ew_HtmlEncode(Orders.cancelled.AdvancedSearch.SearchValue)
			Orders.cancelled.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.cancelled.FldCaption))

			' acknowledged
			Orders.acknowledged.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.acknowledged.EditCustomAttributes = ""
			Orders.acknowledged.EditValue = ew_HtmlEncode(Orders.acknowledged.AdvancedSearch.SearchValue)
			Orders.acknowledged.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.acknowledged.FldCaption))

			' outfordelivery
			Orders.outfordelivery.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.outfordelivery.EditCustomAttributes = ""
			Orders.outfordelivery.EditValue = ew_HtmlEncode(Orders.outfordelivery.AdvancedSearch.SearchValue)
			Orders.outfordelivery.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.outfordelivery.FldCaption))

			' vouchercodediscount
			Orders.vouchercodediscount.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.vouchercodediscount.EditCustomAttributes = ""
			Orders.vouchercodediscount.EditValue = ew_HtmlEncode(Orders.vouchercodediscount.AdvancedSearch.SearchValue)
			Orders.vouchercodediscount.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.vouchercodediscount.FldCaption))

			' vouchercode
			Orders.vouchercode.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.vouchercode.EditCustomAttributes = ""
			Orders.vouchercode.EditValue = ew_HtmlEncode(Orders.vouchercode.AdvancedSearch.SearchValue)
			Orders.vouchercode.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.vouchercode.FldCaption))

			' printed
			Orders.printed.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.printed.EditCustomAttributes = ""
			Orders.printed.EditValue = ew_HtmlEncode(Orders.printed.AdvancedSearch.SearchValue)
			Orders.printed.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.printed.FldCaption))

			' deliverydistance
			Orders.deliverydistance.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.deliverydistance.EditCustomAttributes = ""
			Orders.deliverydistance.EditValue = ew_HtmlEncode(Orders.deliverydistance.AdvancedSearch.SearchValue)
			Orders.deliverydistance.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.deliverydistance.FldCaption))

			' asaporder
			Orders.asaporder.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.asaporder.EditCustomAttributes = ""
			Orders.asaporder.EditValue = ew_HtmlEncode(Orders.asaporder.AdvancedSearch.SearchValue)
			Orders.asaporder.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.asaporder.FldCaption))

			' DeliveryLat
			Orders.DeliveryLat.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.DeliveryLat.EditCustomAttributes = ""
			Orders.DeliveryLat.EditValue = ew_HtmlEncode(Orders.DeliveryLat.AdvancedSearch.SearchValue)
			Orders.DeliveryLat.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.DeliveryLat.FldCaption))

			' DeliveryLng
			Orders.DeliveryLng.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.DeliveryLng.EditCustomAttributes = ""
			Orders.DeliveryLng.EditValue = ew_HtmlEncode(Orders.DeliveryLng.AdvancedSearch.SearchValue)
			Orders.DeliveryLng.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.DeliveryLng.FldCaption))

			' ServiceCharge
			Orders.ServiceCharge.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.ServiceCharge.EditCustomAttributes = ""
			Orders.ServiceCharge.EditValue = ew_HtmlEncode(Orders.ServiceCharge.AdvancedSearch.SearchValue)
			Orders.ServiceCharge.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.ServiceCharge.FldCaption))

			' PaymentSurcharge
			Orders.PaymentSurcharge.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.PaymentSurcharge.EditCustomAttributes = ""
			Orders.PaymentSurcharge.EditValue = ew_HtmlEncode(Orders.PaymentSurcharge.AdvancedSearch.SearchValue)
			Orders.PaymentSurcharge.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.PaymentSurcharge.FldCaption))

			' FromIP
			Orders.FromIP.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.FromIP.EditCustomAttributes = ""
			Orders.FromIP.EditValue = ew_HtmlEncode(Orders.FromIP.AdvancedSearch.SearchValue)
			Orders.FromIP.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.FromIP.FldCaption))

			' Tax_Rate
			Orders.Tax_Rate.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.Tax_Rate.EditCustomAttributes = ""
			Orders.Tax_Rate.EditValue = ew_HtmlEncode(Orders.Tax_Rate.AdvancedSearch.SearchValue)
			Orders.Tax_Rate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.Tax_Rate.FldCaption))

			' Tax_Amount
			Orders.Tax_Amount.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.Tax_Amount.EditCustomAttributes = ""
			Orders.Tax_Amount.EditValue = ew_HtmlEncode(Orders.Tax_Amount.AdvancedSearch.SearchValue)
			Orders.Tax_Amount.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.Tax_Amount.FldCaption))

			' Tip_Rate
			Orders.Tip_Rate.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.Tip_Rate.EditCustomAttributes = ""
			Orders.Tip_Rate.EditValue = ew_HtmlEncode(Orders.Tip_Rate.AdvancedSearch.SearchValue)
			Orders.Tip_Rate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.Tip_Rate.FldCaption))

			' Tip_Amount
			Orders.Tip_Amount.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.Tip_Amount.EditCustomAttributes = ""
			Orders.Tip_Amount.EditValue = ew_HtmlEncode(Orders.Tip_Amount.AdvancedSearch.SearchValue)
			Orders.Tip_Amount.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.Tip_Amount.FldCaption))

			' Card_Debit
			Orders.Card_Debit.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.Card_Debit.EditCustomAttributes = ""
			Orders.Card_Debit.EditValue = ew_HtmlEncode(Orders.Card_Debit.AdvancedSearch.SearchValue)
			Orders.Card_Debit.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.Card_Debit.FldCaption))

			' Card_Credit
			Orders.Card_Credit.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.Card_Credit.EditCustomAttributes = ""
			Orders.Card_Credit.EditValue = ew_HtmlEncode(Orders.Card_Credit.AdvancedSearch.SearchValue)
			Orders.Card_Credit.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.Card_Credit.FldCaption))

			' SentEmail
			Orders.SentEmail.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.SentEmail.EditCustomAttributes = ""
			Orders.SentEmail.EditValue = ew_HtmlEncode(Orders.SentEmail.AdvancedSearch.SearchValue)
			Orders.SentEmail.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.SentEmail.FldCaption))

			' deliverydelay
			Orders.deliverydelay.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.deliverydelay.EditCustomAttributes = ""
			Orders.deliverydelay.EditValue = ew_HtmlEncode(Orders.deliverydelay.AdvancedSearch.SearchValue)
			Orders.deliverydelay.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.deliverydelay.FldCaption))

			' collectiondelay
			Orders.collectiondelay.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.collectiondelay.EditCustomAttributes = ""
			Orders.collectiondelay.EditValue = ew_HtmlEncode(Orders.collectiondelay.AdvancedSearch.SearchValue)
			Orders.collectiondelay.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.collectiondelay.FldCaption))

			' paymentstatus
			Orders.paymentstatus.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.paymentstatus.EditCustomAttributes = ""
			Orders.paymentstatus.EditValue = ew_HtmlEncode(Orders.paymentstatus.AdvancedSearch.SearchValue)
			Orders.paymentstatus.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.paymentstatus.FldCaption))

			' lng_report
			Orders.lng_report.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.lng_report.EditCustomAttributes = ""
			Orders.lng_report.EditValue = ew_HtmlEncode(Orders.lng_report.AdvancedSearch.SearchValue)
			Orders.lng_report.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.lng_report.FldCaption))

			' lat_report
			Orders.lat_report.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.lat_report.EditCustomAttributes = ""
			Orders.lat_report.EditValue = ew_HtmlEncode(Orders.lat_report.AdvancedSearch.SearchValue)
			Orders.lat_report.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.lat_report.FldCaption))

			' Payment_status
			Orders.Payment_status.EditAttrs.UpdateAttribute "class", "form-control"
			Orders.Payment_status.EditCustomAttributes = ""
			Orders.Payment_status.EditValue = ew_HtmlEncode(Orders.Payment_status.AdvancedSearch.SearchValue)
			Orders.Payment_status.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Orders.Payment_status.FldCaption))
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
		If Not ew_CheckInteger(Orders.ID.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, Orders.ID.FldErrMsg)
		End If
		If Not ew_CheckDate(Orders.CreationDate.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, Orders.CreationDate.FldErrMsg)
		End If
		If Not ew_CheckDate(Orders.OrderDate.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, Orders.OrderDate.FldErrMsg)
		End If
		If Not ew_CheckDate(Orders.DeliveryTime.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, Orders.DeliveryTime.FldErrMsg)
		End If
		If Not ew_CheckNumber(Orders.SubTotal.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, Orders.SubTotal.FldErrMsg)
		End If
		If Not ew_CheckNumber(Orders.ShippingFee.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, Orders.ShippingFee.FldErrMsg)
		End If
		If Not ew_CheckNumber(Orders.OrderTotal.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, Orders.OrderTotal.FldErrMsg)
		End If
		If Not ew_CheckInteger(Orders.IdBusinessDetail.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, Orders.IdBusinessDetail.FldErrMsg)
		End If
		If Not ew_CheckDate(Orders.cancelleddate.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, Orders.cancelleddate.FldErrMsg)
		End If
		If Not ew_CheckDate(Orders.acknowledgeddate.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, Orders.acknowledgeddate.FldErrMsg)
		End If
		If Not ew_CheckInteger(Orders.cancelled.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, Orders.cancelled.FldErrMsg)
		End If
		If Not ew_CheckInteger(Orders.acknowledged.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, Orders.acknowledged.FldErrMsg)
		End If
		If Not ew_CheckInteger(Orders.outfordelivery.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, Orders.outfordelivery.FldErrMsg)
		End If
		If Not ew_CheckInteger(Orders.vouchercodediscount.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, Orders.vouchercodediscount.FldErrMsg)
		End If
		If Not ew_CheckInteger(Orders.printed.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, Orders.printed.FldErrMsg)
		End If
		If Not ew_CheckNumber(Orders.ServiceCharge.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, Orders.ServiceCharge.FldErrMsg)
		End If
		If Not ew_CheckNumber(Orders.PaymentSurcharge.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, Orders.PaymentSurcharge.FldErrMsg)
		End If
		If Not ew_CheckInteger(Orders.Tax_Rate.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, Orders.Tax_Rate.FldErrMsg)
		End If
		If Not ew_CheckNumber(Orders.Tax_Amount.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, Orders.Tax_Amount.FldErrMsg)
		End If
		If Not ew_CheckNumber(Orders.Tip_Amount.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, Orders.Tip_Amount.FldErrMsg)
		End If
		If Not ew_CheckInteger(Orders.Card_Debit.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, Orders.Card_Debit.FldErrMsg)
		End If
		If Not ew_CheckInteger(Orders.Card_Credit.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, Orders.Card_Credit.FldErrMsg)
		End If
		If Not ew_CheckInteger(Orders.deliverydelay.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, Orders.deliverydelay.FldErrMsg)
		End If
		If Not ew_CheckInteger(Orders.collectiondelay.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, Orders.collectiondelay.FldErrMsg)
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
		Call Orders.ID.AdvancedSearch.Load()
		Call Orders.CreationDate.AdvancedSearch.Load()
		Call Orders.OrderDate.AdvancedSearch.Load()
		Call Orders.DeliveryType.AdvancedSearch.Load()
		Call Orders.DeliveryTime.AdvancedSearch.Load()
		Call Orders.PaymentType.AdvancedSearch.Load()
		Call Orders.SubTotal.AdvancedSearch.Load()
		Call Orders.ShippingFee.AdvancedSearch.Load()
		Call Orders.OrderTotal.AdvancedSearch.Load()
		Call Orders.IdBusinessDetail.AdvancedSearch.Load()
		Call Orders.SessionId.AdvancedSearch.Load()
		Call Orders.FirstName.AdvancedSearch.Load()
		Call Orders.LastName.AdvancedSearch.Load()
		Call Orders.zEmail.AdvancedSearch.Load()
		Call Orders.Phone.AdvancedSearch.Load()
		Call Orders.Address.AdvancedSearch.Load()
		Call Orders.PostalCode.AdvancedSearch.Load()
		Call Orders.Notes.AdvancedSearch.Load()
		Call Orders.ttest.AdvancedSearch.Load()
		Call Orders.cancelleddate.AdvancedSearch.Load()
		Call Orders.cancelledby.AdvancedSearch.Load()
		Call Orders.cancelledreason.AdvancedSearch.Load()
		Call Orders.acknowledgeddate.AdvancedSearch.Load()
		Call Orders.delivereddate.AdvancedSearch.Load()
		Call Orders.cancelled.AdvancedSearch.Load()
		Call Orders.acknowledged.AdvancedSearch.Load()
		Call Orders.outfordelivery.AdvancedSearch.Load()
		Call Orders.vouchercodediscount.AdvancedSearch.Load()
		Call Orders.vouchercode.AdvancedSearch.Load()
		Call Orders.printed.AdvancedSearch.Load()
		Call Orders.deliverydistance.AdvancedSearch.Load()
		Call Orders.asaporder.AdvancedSearch.Load()
		Call Orders.DeliveryLat.AdvancedSearch.Load()
		Call Orders.DeliveryLng.AdvancedSearch.Load()
		Call Orders.ServiceCharge.AdvancedSearch.Load()
		Call Orders.PaymentSurcharge.AdvancedSearch.Load()
		Call Orders.FromIP.AdvancedSearch.Load()
		Call Orders.Tax_Rate.AdvancedSearch.Load()
		Call Orders.Tax_Amount.AdvancedSearch.Load()
		Call Orders.Tip_Rate.AdvancedSearch.Load()
		Call Orders.Tip_Amount.AdvancedSearch.Load()
		Call Orders.Card_Debit.AdvancedSearch.Load()
		Call Orders.Card_Credit.AdvancedSearch.Load()
		Call Orders.SentEmail.AdvancedSearch.Load()
		Call Orders.deliverydelay.AdvancedSearch.Load()
		Call Orders.collectiondelay.AdvancedSearch.Load()
		Call Orders.paymentstatus.AdvancedSearch.Load()
		Call Orders.lng_report.AdvancedSearch.Load()
		Call Orders.lat_report.AdvancedSearch.Load()
		Call Orders.Payment_status.AdvancedSearch.Load()
End Function

	' Set up Breadcrumb
	Sub SetupBreadcrumb()
		Dim PageId, url
		Set Breadcrumb = New cBreadcrumb
		url = Mid(ew_CurrentUrl, InStrRev(ew_CurrentUrl, "/")+1)
		Call Breadcrumb.Add("list", Orders.TableVar, "Orderslist.asp", "", Orders.TableVar, True)
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
