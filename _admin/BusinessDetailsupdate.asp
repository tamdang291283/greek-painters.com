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
Dim BusinessDetails_update
Set BusinessDetails_update = New cBusinessDetails_update
Set Page = BusinessDetails_update

' Page init processing
BusinessDetails_update.Page_Init()

' Page main processing
BusinessDetails_update.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
BusinessDetails_update.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var BusinessDetails_update = new ew_Page("BusinessDetails_update");
BusinessDetails_update.PageID = "update"; // Page ID
var EW_PAGE_ID = BusinessDetails_update.PageID; // For backward compatibility
// Form object
var fBusinessDetailsupdate = new ew_Form("fBusinessDetailsupdate");
// Validate form
fBusinessDetailsupdate.Validate = function() {
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
			elm = this.GetElements("x" + infix + "_DeliveryMinAmount");
			uelm = this.GetElements("u" + infix + "_DeliveryMinAmount");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.DeliveryMinAmount.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_DeliveryMaxDistance");
			uelm = this.GetElements("u" + infix + "_DeliveryMaxDistance");
			if (uelm && uelm.checked && elm && !ew_CheckNumber(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.DeliveryMaxDistance.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_DeliveryFreeDistance");
			uelm = this.GetElements("u" + infix + "_DeliveryFreeDistance");
			if (uelm && uelm.checked && elm && !ew_CheckNumber(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.DeliveryFreeDistance.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_AverageDeliveryTime");
			uelm = this.GetElements("u" + infix + "_AverageDeliveryTime");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.AverageDeliveryTime.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_AverageCollectionTime");
			uelm = this.GetElements("u" + infix + "_AverageCollectionTime");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.AverageCollectionTime.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_DeliveryFee");
			uelm = this.GetElements("u" + infix + "_DeliveryFee");
			if (uelm && uelm.checked && elm && !ew_CheckNumber(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.DeliveryFee.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_businessclosed");
			uelm = this.GetElements("u" + infix + "_businessclosed");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.businessclosed.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_timezone");
			uelm = this.GetElements("u" + infix + "_timezone");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.timezone.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_individualpostcodeschecking");
			uelm = this.GetElements("u" + infix + "_individualpostcodeschecking");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.individualpostcodeschecking.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_orderonlywhenopen");
			uelm = this.GetElements("u" + infix + "_orderonlywhenopen");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.orderonlywhenopen.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_disablelaterdelivery");
			uelm = this.GetElements("u" + infix + "_disablelaterdelivery");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.disablelaterdelivery.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_ordertodayonly");
			uelm = this.GetElements("u" + infix + "_ordertodayonly");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.ordertodayonly.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_worldpaylive");
			uelm = this.GetElements("u" + infix + "_worldpaylive");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.worldpaylive.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_SMSEnable");
			uelm = this.GetElements("u" + infix + "_SMSEnable");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.SMSEnable.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_SMSOnDelivery");
			uelm = this.GetElements("u" + infix + "_SMSOnDelivery");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.SMSOnDelivery.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_SMSOnOrder");
			uelm = this.GetElements("u" + infix + "_SMSOnOrder");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.SMSOnOrder.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_SMSOnOrderAfterMin");
			uelm = this.GetElements("u" + infix + "_SMSOnOrderAfterMin");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.SMSOnOrderAfterMin.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_MinimumAmountForCardPayment");
			uelm = this.GetElements("u" + infix + "_MinimumAmountForCardPayment");
			if (uelm && uelm.checked && elm && !ew_CheckNumber(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.MinimumAmountForCardPayment.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_SMSOnAcknowledgement");
			uelm = this.GetElements("u" + infix + "_SMSOnAcknowledgement");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.SMSOnAcknowledgement.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_ShowRestaurantDetailOnReceipt");
			uelm = this.GetElements("u" + infix + "_ShowRestaurantDetailOnReceipt");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.ShowRestaurantDetailOnReceipt.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_PrinterFontSizeRatio");
			uelm = this.GetElements("u" + infix + "_PrinterFontSizeRatio");
			if (uelm && uelm.checked && elm && !ew_CheckNumber(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.PrinterFontSizeRatio.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_ServiceChargePercentage");
			uelm = this.GetElements("u" + infix + "_ServiceChargePercentage");
			if (uelm && uelm.checked && elm && !ew_CheckNumber(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.ServiceChargePercentage.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_InRestaurantServiceChargeOnly");
			uelm = this.GetElements("u" + infix + "_InRestaurantServiceChargeOnly");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.InRestaurantServiceChargeOnly.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_IsDualReceiptPrinting");
			uelm = this.GetElements("u" + infix + "_IsDualReceiptPrinting");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.IsDualReceiptPrinting.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_PrintingFontSize");
			uelm = this.GetElements("u" + infix + "_PrintingFontSize");
			if (uelm && uelm.checked && elm && !ew_CheckNumber(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.PrintingFontSize.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_Tip_percent");
			uelm = this.GetElements("u" + infix + "_Tip_percent");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.Tip_percent.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_Tax_Percent");
			uelm = this.GetElements("u" + infix + "_Tax_Percent");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.Tax_Percent.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_InRestaurantTaxChargeOnly");
			uelm = this.GetElements("u" + infix + "_InRestaurantTaxChargeOnly");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.InRestaurantTaxChargeOnly.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_InRestaurantTipChargeOnly");
			uelm = this.GetElements("u" + infix + "_InRestaurantTipChargeOnly");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.InRestaurantTipChargeOnly.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_DeliveryMile");
			uelm = this.GetElements("u" + infix + "_DeliveryMile");
			if (uelm && uelm.checked && elm && !ew_CheckNumber(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.DeliveryMile.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_Mon_Delivery");
			uelm = this.GetElements("u" + infix + "_Mon_Delivery");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.Mon_Delivery.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_Mon_Collection");
			uelm = this.GetElements("u" + infix + "_Mon_Collection");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.Mon_Collection.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_Tue_Delivery");
			uelm = this.GetElements("u" + infix + "_Tue_Delivery");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.Tue_Delivery.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_Tue_Collection");
			uelm = this.GetElements("u" + infix + "_Tue_Collection");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.Tue_Collection.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_Wed_Delivery");
			uelm = this.GetElements("u" + infix + "_Wed_Delivery");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.Wed_Delivery.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_Wed_Collection");
			uelm = this.GetElements("u" + infix + "_Wed_Collection");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.Wed_Collection.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_Thu_Delivery");
			uelm = this.GetElements("u" + infix + "_Thu_Delivery");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.Thu_Delivery.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_Thu_Collection");
			uelm = this.GetElements("u" + infix + "_Thu_Collection");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.Thu_Collection.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_Fri_Delivery");
			uelm = this.GetElements("u" + infix + "_Fri_Delivery");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.Fri_Delivery.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_Fri_Collection");
			uelm = this.GetElements("u" + infix + "_Fri_Collection");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.Fri_Collection.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_Sat_Delivery");
			uelm = this.GetElements("u" + infix + "_Sat_Delivery");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.Sat_Delivery.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_Sat_Collection");
			uelm = this.GetElements("u" + infix + "_Sat_Collection");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.Sat_Collection.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_Sun_Delivery");
			uelm = this.GetElements("u" + infix + "_Sun_Delivery");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.Sun_Delivery.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_Sun_Collection");
			uelm = this.GetElements("u" + infix + "_Sun_Collection");
			if (uelm && uelm.checked && elm && !ew_CheckInteger(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.Sun_Collection.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_DeliveryCostUpTo");
			uelm = this.GetElements("u" + infix + "_DeliveryCostUpTo");
			if (uelm && uelm.checked && elm && !ew_CheckNumber(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.DeliveryCostUpTo.FldErrMsg) %>");
			elm = this.GetElements("x" + infix + "_DeliveryUptoMile");
			uelm = this.GetElements("u" + infix + "_DeliveryUptoMile");
			if (uelm && uelm.checked && elm && !ew_CheckNumber(elm.value))
					return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.DeliveryUptoMile.FldErrMsg) %>");
			// Set up row object
			ew_ElementsToRow(fobj);
			// Fire Form_CustomValidate event
			if (!this.Form_CustomValidate(fobj))
				return false;
	}
	return true;
}
// Form_CustomValidate event
fBusinessDetailsupdate.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fBusinessDetailsupdate.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fBusinessDetailsupdate.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<div class="ewToolbar">
<% If BusinessDetails.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If BusinessDetails.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% BusinessDetails_update.ShowPageHeader() %>
<% BusinessDetails_update.ShowMessage %>
<form name="fBusinessDetailsupdate" id="fBusinessDetailsupdate" class="form-horizontal ewForm ewUpdateForm" action="<%= ew_CurrentPage %>" method="post">
<% If BusinessDetails_update.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= BusinessDetails_update.Token %>">
<% End If %>
<input type="hidden" name="t" value="BusinessDetails">
<input type="hidden" name="a_update" id="a_update" value="U">
<% For i = 0 to UBound(BusinessDetails_update.RecKeys) %>
<input type="hidden" name="key_m" id="key_m" value="<%= ew_HtmlEncode(ew_GetKeyValue(BusinessDetails_update.RecKeys(i))) %>">
<% Next %>
<div id="tbl_BusinessDetailsupdate">
	<div class="form-group">
		<label class="col-sm-2"><input type="checkbox" name="u" id="u" onclick="ew_SelectAll(this);"> <%= Language.Phrase("UpdateSelectAll") %></label>
	</div>
<% If BusinessDetails.Name.Visible Then ' Name %>
	<div id="r_Name" class="form-group">
		<label for="x_Name" class="col-sm-2 control-label">
<input type="checkbox" name="u_Name" id="u_Name" value="1"<% If BusinessDetails.Name.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.Name.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.Name.CellAttributes %>>
<span id="el_BusinessDetails_Name">
<input type="text" data-field="x_Name" name="x_Name" id="x_Name" size="30" maxlength="255" placeholder="<%= BusinessDetails.Name.PlaceHolder %>" value="<%= BusinessDetails.Name.EditValue %>"<%= BusinessDetails.Name.EditAttributes %>>
</span>
<%= BusinessDetails.Name.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.Address.Visible Then ' Address %>
	<div id="r_Address" class="form-group">
		<label for="x_Address" class="col-sm-2 control-label">
<input type="checkbox" name="u_Address" id="u_Address" value="1"<% If BusinessDetails.Address.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.Address.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.Address.CellAttributes %>>
<span id="el_BusinessDetails_Address">
<input type="text" data-field="x_Address" name="x_Address" id="x_Address" size="30" maxlength="255" placeholder="<%= BusinessDetails.Address.PlaceHolder %>" value="<%= BusinessDetails.Address.EditValue %>"<%= BusinessDetails.Address.EditAttributes %>>
</span>
<%= BusinessDetails.Address.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.PostalCode.Visible Then ' PostalCode %>
	<div id="r_PostalCode" class="form-group">
		<label for="x_PostalCode" class="col-sm-2 control-label">
<input type="checkbox" name="u_PostalCode" id="u_PostalCode" value="1"<% If BusinessDetails.PostalCode.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.PostalCode.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.PostalCode.CellAttributes %>>
<span id="el_BusinessDetails_PostalCode">
<input type="text" data-field="x_PostalCode" name="x_PostalCode" id="x_PostalCode" size="30" maxlength="255" placeholder="<%= BusinessDetails.PostalCode.PlaceHolder %>" value="<%= BusinessDetails.PostalCode.EditValue %>"<%= BusinessDetails.PostalCode.EditAttributes %>>
</span>
<%= BusinessDetails.PostalCode.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.FoodType.Visible Then ' FoodType %>
	<div id="r_FoodType" class="form-group">
		<label for="x_FoodType" class="col-sm-2 control-label">
<input type="checkbox" name="u_FoodType" id="u_FoodType" value="1"<% If BusinessDetails.FoodType.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.FoodType.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.FoodType.CellAttributes %>>
<span id="el_BusinessDetails_FoodType">
<input type="text" data-field="x_FoodType" name="x_FoodType" id="x_FoodType" size="30" maxlength="255" placeholder="<%= BusinessDetails.FoodType.PlaceHolder %>" value="<%= BusinessDetails.FoodType.EditValue %>"<%= BusinessDetails.FoodType.EditAttributes %>>
</span>
<%= BusinessDetails.FoodType.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.DeliveryMinAmount.Visible Then ' DeliveryMinAmount %>
	<div id="r_DeliveryMinAmount" class="form-group">
		<label for="x_DeliveryMinAmount" class="col-sm-2 control-label">
<input type="checkbox" name="u_DeliveryMinAmount" id="u_DeliveryMinAmount" value="1"<% If BusinessDetails.DeliveryMinAmount.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.DeliveryMinAmount.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.DeliveryMinAmount.CellAttributes %>>
<span id="el_BusinessDetails_DeliveryMinAmount">
<input type="text" data-field="x_DeliveryMinAmount" name="x_DeliveryMinAmount" id="x_DeliveryMinAmount" size="30" placeholder="<%= BusinessDetails.DeliveryMinAmount.PlaceHolder %>" value="<%= BusinessDetails.DeliveryMinAmount.EditValue %>"<%= BusinessDetails.DeliveryMinAmount.EditAttributes %>>
</span>
<%= BusinessDetails.DeliveryMinAmount.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.DeliveryMaxDistance.Visible Then ' DeliveryMaxDistance %>
	<div id="r_DeliveryMaxDistance" class="form-group">
		<label for="x_DeliveryMaxDistance" class="col-sm-2 control-label">
<input type="checkbox" name="u_DeliveryMaxDistance" id="u_DeliveryMaxDistance" value="1"<% If BusinessDetails.DeliveryMaxDistance.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.DeliveryMaxDistance.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.DeliveryMaxDistance.CellAttributes %>>
<span id="el_BusinessDetails_DeliveryMaxDistance">
<input type="text" data-field="x_DeliveryMaxDistance" name="x_DeliveryMaxDistance" id="x_DeliveryMaxDistance" size="30" placeholder="<%= BusinessDetails.DeliveryMaxDistance.PlaceHolder %>" value="<%= BusinessDetails.DeliveryMaxDistance.EditValue %>"<%= BusinessDetails.DeliveryMaxDistance.EditAttributes %>>
</span>
<%= BusinessDetails.DeliveryMaxDistance.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.DeliveryFreeDistance.Visible Then ' DeliveryFreeDistance %>
	<div id="r_DeliveryFreeDistance" class="form-group">
		<label for="x_DeliveryFreeDistance" class="col-sm-2 control-label">
<input type="checkbox" name="u_DeliveryFreeDistance" id="u_DeliveryFreeDistance" value="1"<% If BusinessDetails.DeliveryFreeDistance.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.DeliveryFreeDistance.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.DeliveryFreeDistance.CellAttributes %>>
<span id="el_BusinessDetails_DeliveryFreeDistance">
<input type="text" data-field="x_DeliveryFreeDistance" name="x_DeliveryFreeDistance" id="x_DeliveryFreeDistance" size="30" placeholder="<%= BusinessDetails.DeliveryFreeDistance.PlaceHolder %>" value="<%= BusinessDetails.DeliveryFreeDistance.EditValue %>"<%= BusinessDetails.DeliveryFreeDistance.EditAttributes %>>
</span>
<%= BusinessDetails.DeliveryFreeDistance.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.AverageDeliveryTime.Visible Then ' AverageDeliveryTime %>
	<div id="r_AverageDeliveryTime" class="form-group">
		<label for="x_AverageDeliveryTime" class="col-sm-2 control-label">
<input type="checkbox" name="u_AverageDeliveryTime" id="u_AverageDeliveryTime" value="1"<% If BusinessDetails.AverageDeliveryTime.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.AverageDeliveryTime.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.AverageDeliveryTime.CellAttributes %>>
<span id="el_BusinessDetails_AverageDeliveryTime">
<input type="text" data-field="x_AverageDeliveryTime" name="x_AverageDeliveryTime" id="x_AverageDeliveryTime" size="30" placeholder="<%= BusinessDetails.AverageDeliveryTime.PlaceHolder %>" value="<%= BusinessDetails.AverageDeliveryTime.EditValue %>"<%= BusinessDetails.AverageDeliveryTime.EditAttributes %>>
</span>
<%= BusinessDetails.AverageDeliveryTime.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.AverageCollectionTime.Visible Then ' AverageCollectionTime %>
	<div id="r_AverageCollectionTime" class="form-group">
		<label for="x_AverageCollectionTime" class="col-sm-2 control-label">
<input type="checkbox" name="u_AverageCollectionTime" id="u_AverageCollectionTime" value="1"<% If BusinessDetails.AverageCollectionTime.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.AverageCollectionTime.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.AverageCollectionTime.CellAttributes %>>
<span id="el_BusinessDetails_AverageCollectionTime">
<input type="text" data-field="x_AverageCollectionTime" name="x_AverageCollectionTime" id="x_AverageCollectionTime" size="30" placeholder="<%= BusinessDetails.AverageCollectionTime.PlaceHolder %>" value="<%= BusinessDetails.AverageCollectionTime.EditValue %>"<%= BusinessDetails.AverageCollectionTime.EditAttributes %>>
</span>
<%= BusinessDetails.AverageCollectionTime.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.DeliveryFee.Visible Then ' DeliveryFee %>
	<div id="r_DeliveryFee" class="form-group">
		<label for="x_DeliveryFee" class="col-sm-2 control-label">
<input type="checkbox" name="u_DeliveryFee" id="u_DeliveryFee" value="1"<% If BusinessDetails.DeliveryFee.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.DeliveryFee.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.DeliveryFee.CellAttributes %>>
<span id="el_BusinessDetails_DeliveryFee">
<input type="text" data-field="x_DeliveryFee" name="x_DeliveryFee" id="x_DeliveryFee" size="30" placeholder="<%= BusinessDetails.DeliveryFee.PlaceHolder %>" value="<%= BusinessDetails.DeliveryFee.EditValue %>"<%= BusinessDetails.DeliveryFee.EditAttributes %>>
</span>
<%= BusinessDetails.DeliveryFee.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.ImgUrl.Visible Then ' ImgUrl %>
	<div id="r_ImgUrl" class="form-group">
		<label for="x_ImgUrl" class="col-sm-2 control-label">
<input type="checkbox" name="u_ImgUrl" id="u_ImgUrl" value="1"<% If BusinessDetails.ImgUrl.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.ImgUrl.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.ImgUrl.CellAttributes %>>
<span id="el_BusinessDetails_ImgUrl">
<input type="text" data-field="x_ImgUrl" name="x_ImgUrl" id="x_ImgUrl" size="30" maxlength="255" placeholder="<%= BusinessDetails.ImgUrl.PlaceHolder %>" value="<%= BusinessDetails.ImgUrl.EditValue %>"<%= BusinessDetails.ImgUrl.EditAttributes %>>
</span>
<%= BusinessDetails.ImgUrl.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.Telephone.Visible Then ' Telephone %>
	<div id="r_Telephone" class="form-group">
		<label for="x_Telephone" class="col-sm-2 control-label">
<input type="checkbox" name="u_Telephone" id="u_Telephone" value="1"<% If BusinessDetails.Telephone.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.Telephone.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.Telephone.CellAttributes %>>
<span id="el_BusinessDetails_Telephone">
<input type="text" data-field="x_Telephone" name="x_Telephone" id="x_Telephone" size="30" maxlength="255" placeholder="<%= BusinessDetails.Telephone.PlaceHolder %>" value="<%= BusinessDetails.Telephone.EditValue %>"<%= BusinessDetails.Telephone.EditAttributes %>>
</span>
<%= BusinessDetails.Telephone.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.zEmail.Visible Then ' Email %>
	<div id="r_zEmail" class="form-group">
		<label for="x_zEmail" class="col-sm-2 control-label">
<input type="checkbox" name="u_zEmail" id="u_zEmail" value="1"<% If BusinessDetails.zEmail.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.zEmail.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.zEmail.CellAttributes %>>
<span id="el_BusinessDetails_zEmail">
<input type="text" data-field="x_zEmail" name="x_zEmail" id="x_zEmail" size="30" maxlength="255" placeholder="<%= BusinessDetails.zEmail.PlaceHolder %>" value="<%= BusinessDetails.zEmail.EditValue %>"<%= BusinessDetails.zEmail.EditAttributes %>>
</span>
<%= BusinessDetails.zEmail.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.pswd.Visible Then ' pswd %>
	<div id="r_pswd" class="form-group">
		<label for="x_pswd" class="col-sm-2 control-label">
<input type="checkbox" name="u_pswd" id="u_pswd" value="1"<% If BusinessDetails.pswd.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.pswd.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.pswd.CellAttributes %>>
<span id="el_BusinessDetails_pswd">
<input type="text" data-field="x_pswd" name="x_pswd" id="x_pswd" size="30" maxlength="255" placeholder="<%= BusinessDetails.pswd.PlaceHolder %>" value="<%= BusinessDetails.pswd.EditValue %>"<%= BusinessDetails.pswd.EditAttributes %>>
</span>
<%= BusinessDetails.pswd.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.businessclosed.Visible Then ' businessclosed %>
	<div id="r_businessclosed" class="form-group">
		<label for="x_businessclosed" class="col-sm-2 control-label">
<input type="checkbox" name="u_businessclosed" id="u_businessclosed" value="1"<% If BusinessDetails.businessclosed.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.businessclosed.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.businessclosed.CellAttributes %>>
<span id="el_BusinessDetails_businessclosed">
<input type="text" data-field="x_businessclosed" name="x_businessclosed" id="x_businessclosed" size="30" placeholder="<%= BusinessDetails.businessclosed.PlaceHolder %>" value="<%= BusinessDetails.businessclosed.EditValue %>"<%= BusinessDetails.businessclosed.EditAttributes %>>
</span>
<%= BusinessDetails.businessclosed.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.announcement.Visible Then ' announcement %>
	<div id="r_announcement" class="form-group">
		<label for="x_announcement" class="col-sm-2 control-label">
<input type="checkbox" name="u_announcement" id="u_announcement" value="1"<% If BusinessDetails.announcement.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.announcement.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.announcement.CellAttributes %>>
<span id="el_BusinessDetails_announcement">
<textarea data-field="x_announcement" name="x_announcement" id="x_announcement" cols="35" rows="4" placeholder="<%= BusinessDetails.announcement.PlaceHolder %>"<%= BusinessDetails.announcement.EditAttributes %>><%= BusinessDetails.announcement.EditValue %></textarea>
</span>
<%= BusinessDetails.announcement.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.css.Visible Then ' css %>
	<div id="r_css" class="form-group">
		<label for="x_css" class="col-sm-2 control-label">
<input type="checkbox" name="u_css" id="u_css" value="1"<% If BusinessDetails.css.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.css.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.css.CellAttributes %>>
<span id="el_BusinessDetails_css">
<textarea data-field="x_css" name="x_css" id="x_css" cols="35" rows="4" placeholder="<%= BusinessDetails.css.PlaceHolder %>"<%= BusinessDetails.css.EditAttributes %>><%= BusinessDetails.css.EditValue %></textarea>
</span>
<%= BusinessDetails.css.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.SMTP_AUTENTICATE.Visible Then ' SMTP_AUTENTICATE %>
	<div id="r_SMTP_AUTENTICATE" class="form-group">
		<label for="x_SMTP_AUTENTICATE" class="col-sm-2 control-label">
<input type="checkbox" name="u_SMTP_AUTENTICATE" id="u_SMTP_AUTENTICATE" value="1"<% If BusinessDetails.SMTP_AUTENTICATE.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.SMTP_AUTENTICATE.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.SMTP_AUTENTICATE.CellAttributes %>>
<span id="el_BusinessDetails_SMTP_AUTENTICATE">
<input type="text" data-field="x_SMTP_AUTENTICATE" name="x_SMTP_AUTENTICATE" id="x_SMTP_AUTENTICATE" size="30" maxlength="255" placeholder="<%= BusinessDetails.SMTP_AUTENTICATE.PlaceHolder %>" value="<%= BusinessDetails.SMTP_AUTENTICATE.EditValue %>"<%= BusinessDetails.SMTP_AUTENTICATE.EditAttributes %>>
</span>
<%= BusinessDetails.SMTP_AUTENTICATE.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.MAIL_FROM.Visible Then ' MAIL_FROM %>
	<div id="r_MAIL_FROM" class="form-group">
		<label for="x_MAIL_FROM" class="col-sm-2 control-label">
<input type="checkbox" name="u_MAIL_FROM" id="u_MAIL_FROM" value="1"<% If BusinessDetails.MAIL_FROM.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.MAIL_FROM.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.MAIL_FROM.CellAttributes %>>
<span id="el_BusinessDetails_MAIL_FROM">
<input type="text" data-field="x_MAIL_FROM" name="x_MAIL_FROM" id="x_MAIL_FROM" size="30" maxlength="255" placeholder="<%= BusinessDetails.MAIL_FROM.PlaceHolder %>" value="<%= BusinessDetails.MAIL_FROM.EditValue %>"<%= BusinessDetails.MAIL_FROM.EditAttributes %>>
</span>
<%= BusinessDetails.MAIL_FROM.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.PAYPAL_URL.Visible Then ' PAYPAL_URL %>
	<div id="r_PAYPAL_URL" class="form-group">
		<label for="x_PAYPAL_URL" class="col-sm-2 control-label">
<input type="checkbox" name="u_PAYPAL_URL" id="u_PAYPAL_URL" value="1"<% If BusinessDetails.PAYPAL_URL.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.PAYPAL_URL.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.PAYPAL_URL.CellAttributes %>>
<span id="el_BusinessDetails_PAYPAL_URL">
<input type="text" data-field="x_PAYPAL_URL" name="x_PAYPAL_URL" id="x_PAYPAL_URL" size="30" maxlength="255" placeholder="<%= BusinessDetails.PAYPAL_URL.PlaceHolder %>" value="<%= BusinessDetails.PAYPAL_URL.EditValue %>"<%= BusinessDetails.PAYPAL_URL.EditAttributes %>>
</span>
<%= BusinessDetails.PAYPAL_URL.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.PAYPAL_PDT.Visible Then ' PAYPAL_PDT %>
	<div id="r_PAYPAL_PDT" class="form-group">
		<label for="x_PAYPAL_PDT" class="col-sm-2 control-label">
<input type="checkbox" name="u_PAYPAL_PDT" id="u_PAYPAL_PDT" value="1"<% If BusinessDetails.PAYPAL_PDT.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.PAYPAL_PDT.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.PAYPAL_PDT.CellAttributes %>>
<span id="el_BusinessDetails_PAYPAL_PDT">
<input type="text" data-field="x_PAYPAL_PDT" name="x_PAYPAL_PDT" id="x_PAYPAL_PDT" size="30" maxlength="255" placeholder="<%= BusinessDetails.PAYPAL_PDT.PlaceHolder %>" value="<%= BusinessDetails.PAYPAL_PDT.EditValue %>"<%= BusinessDetails.PAYPAL_PDT.EditAttributes %>>
</span>
<%= BusinessDetails.PAYPAL_PDT.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.SMTP_PASSWORD.Visible Then ' SMTP_PASSWORD %>
	<div id="r_SMTP_PASSWORD" class="form-group">
		<label for="x_SMTP_PASSWORD" class="col-sm-2 control-label">
<input type="checkbox" name="u_SMTP_PASSWORD" id="u_SMTP_PASSWORD" value="1"<% If BusinessDetails.SMTP_PASSWORD.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.SMTP_PASSWORD.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.SMTP_PASSWORD.CellAttributes %>>
<span id="el_BusinessDetails_SMTP_PASSWORD">
<input type="text" data-field="x_SMTP_PASSWORD" name="x_SMTP_PASSWORD" id="x_SMTP_PASSWORD" size="30" maxlength="255" placeholder="<%= BusinessDetails.SMTP_PASSWORD.PlaceHolder %>" value="<%= BusinessDetails.SMTP_PASSWORD.EditValue %>"<%= BusinessDetails.SMTP_PASSWORD.EditAttributes %>>
</span>
<%= BusinessDetails.SMTP_PASSWORD.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.GMAP_API_KEY.Visible Then ' GMAP_API_KEY %>
	<div id="r_GMAP_API_KEY" class="form-group">
		<label for="x_GMAP_API_KEY" class="col-sm-2 control-label">
<input type="checkbox" name="u_GMAP_API_KEY" id="u_GMAP_API_KEY" value="1"<% If BusinessDetails.GMAP_API_KEY.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.GMAP_API_KEY.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.GMAP_API_KEY.CellAttributes %>>
<span id="el_BusinessDetails_GMAP_API_KEY">
<input type="text" data-field="x_GMAP_API_KEY" name="x_GMAP_API_KEY" id="x_GMAP_API_KEY" size="30" maxlength="255" placeholder="<%= BusinessDetails.GMAP_API_KEY.PlaceHolder %>" value="<%= BusinessDetails.GMAP_API_KEY.EditValue %>"<%= BusinessDetails.GMAP_API_KEY.EditAttributes %>>
</span>
<%= BusinessDetails.GMAP_API_KEY.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.SMTP_USERNAME.Visible Then ' SMTP_USERNAME %>
	<div id="r_SMTP_USERNAME" class="form-group">
		<label for="x_SMTP_USERNAME" class="col-sm-2 control-label">
<input type="checkbox" name="u_SMTP_USERNAME" id="u_SMTP_USERNAME" value="1"<% If BusinessDetails.SMTP_USERNAME.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.SMTP_USERNAME.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.SMTP_USERNAME.CellAttributes %>>
<span id="el_BusinessDetails_SMTP_USERNAME">
<input type="text" data-field="x_SMTP_USERNAME" name="x_SMTP_USERNAME" id="x_SMTP_USERNAME" size="30" maxlength="255" placeholder="<%= BusinessDetails.SMTP_USERNAME.PlaceHolder %>" value="<%= BusinessDetails.SMTP_USERNAME.EditValue %>"<%= BusinessDetails.SMTP_USERNAME.EditAttributes %>>
</span>
<%= BusinessDetails.SMTP_USERNAME.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.SMTP_USESSL.Visible Then ' SMTP_USESSL %>
	<div id="r_SMTP_USESSL" class="form-group">
		<label for="x_SMTP_USESSL" class="col-sm-2 control-label">
<input type="checkbox" name="u_SMTP_USESSL" id="u_SMTP_USESSL" value="1"<% If BusinessDetails.SMTP_USESSL.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.SMTP_USESSL.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.SMTP_USESSL.CellAttributes %>>
<span id="el_BusinessDetails_SMTP_USESSL">
<input type="text" data-field="x_SMTP_USESSL" name="x_SMTP_USESSL" id="x_SMTP_USESSL" size="30" maxlength="255" placeholder="<%= BusinessDetails.SMTP_USESSL.PlaceHolder %>" value="<%= BusinessDetails.SMTP_USESSL.EditValue %>"<%= BusinessDetails.SMTP_USESSL.EditAttributes %>>
</span>
<%= BusinessDetails.SMTP_USESSL.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.MAIL_SUBJECT.Visible Then ' MAIL_SUBJECT %>
	<div id="r_MAIL_SUBJECT" class="form-group">
		<label for="x_MAIL_SUBJECT" class="col-sm-2 control-label">
<input type="checkbox" name="u_MAIL_SUBJECT" id="u_MAIL_SUBJECT" value="1"<% If BusinessDetails.MAIL_SUBJECT.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.MAIL_SUBJECT.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.MAIL_SUBJECT.CellAttributes %>>
<span id="el_BusinessDetails_MAIL_SUBJECT">
<input type="text" data-field="x_MAIL_SUBJECT" name="x_MAIL_SUBJECT" id="x_MAIL_SUBJECT" size="30" maxlength="255" placeholder="<%= BusinessDetails.MAIL_SUBJECT.PlaceHolder %>" value="<%= BusinessDetails.MAIL_SUBJECT.EditValue %>"<%= BusinessDetails.MAIL_SUBJECT.EditAttributes %>>
</span>
<%= BusinessDetails.MAIL_SUBJECT.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.CURRENCYSYMBOL.Visible Then ' CURRENCYSYMBOL %>
	<div id="r_CURRENCYSYMBOL" class="form-group">
		<label for="x_CURRENCYSYMBOL" class="col-sm-2 control-label">
<input type="checkbox" name="u_CURRENCYSYMBOL" id="u_CURRENCYSYMBOL" value="1"<% If BusinessDetails.CURRENCYSYMBOL.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.CURRENCYSYMBOL.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.CURRENCYSYMBOL.CellAttributes %>>
<span id="el_BusinessDetails_CURRENCYSYMBOL">
<input type="text" data-field="x_CURRENCYSYMBOL" name="x_CURRENCYSYMBOL" id="x_CURRENCYSYMBOL" size="30" maxlength="255" placeholder="<%= BusinessDetails.CURRENCYSYMBOL.PlaceHolder %>" value="<%= BusinessDetails.CURRENCYSYMBOL.EditValue %>"<%= BusinessDetails.CURRENCYSYMBOL.EditAttributes %>>
</span>
<%= BusinessDetails.CURRENCYSYMBOL.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.SMTP_SERVER.Visible Then ' SMTP_SERVER %>
	<div id="r_SMTP_SERVER" class="form-group">
		<label for="x_SMTP_SERVER" class="col-sm-2 control-label">
<input type="checkbox" name="u_SMTP_SERVER" id="u_SMTP_SERVER" value="1"<% If BusinessDetails.SMTP_SERVER.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.SMTP_SERVER.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.SMTP_SERVER.CellAttributes %>>
<span id="el_BusinessDetails_SMTP_SERVER">
<input type="text" data-field="x_SMTP_SERVER" name="x_SMTP_SERVER" id="x_SMTP_SERVER" size="30" maxlength="255" placeholder="<%= BusinessDetails.SMTP_SERVER.PlaceHolder %>" value="<%= BusinessDetails.SMTP_SERVER.EditValue %>"<%= BusinessDetails.SMTP_SERVER.EditAttributes %>>
</span>
<%= BusinessDetails.SMTP_SERVER.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.CREDITCARDSURCHARGE.Visible Then ' CREDITCARDSURCHARGE %>
	<div id="r_CREDITCARDSURCHARGE" class="form-group">
		<label for="x_CREDITCARDSURCHARGE" class="col-sm-2 control-label">
<input type="checkbox" name="u_CREDITCARDSURCHARGE" id="u_CREDITCARDSURCHARGE" value="1"<% If BusinessDetails.CREDITCARDSURCHARGE.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.CREDITCARDSURCHARGE.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.CREDITCARDSURCHARGE.CellAttributes %>>
<span id="el_BusinessDetails_CREDITCARDSURCHARGE">
<input type="text" data-field="x_CREDITCARDSURCHARGE" name="x_CREDITCARDSURCHARGE" id="x_CREDITCARDSURCHARGE" size="30" maxlength="255" placeholder="<%= BusinessDetails.CREDITCARDSURCHARGE.PlaceHolder %>" value="<%= BusinessDetails.CREDITCARDSURCHARGE.EditValue %>"<%= BusinessDetails.CREDITCARDSURCHARGE.EditAttributes %>>
</span>
<%= BusinessDetails.CREDITCARDSURCHARGE.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.SMTP_PORT.Visible Then ' SMTP_PORT %>
	<div id="r_SMTP_PORT" class="form-group">
		<label for="x_SMTP_PORT" class="col-sm-2 control-label">
<input type="checkbox" name="u_SMTP_PORT" id="u_SMTP_PORT" value="1"<% If BusinessDetails.SMTP_PORT.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.SMTP_PORT.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.SMTP_PORT.CellAttributes %>>
<span id="el_BusinessDetails_SMTP_PORT">
<input type="text" data-field="x_SMTP_PORT" name="x_SMTP_PORT" id="x_SMTP_PORT" size="30" maxlength="255" placeholder="<%= BusinessDetails.SMTP_PORT.PlaceHolder %>" value="<%= BusinessDetails.SMTP_PORT.EditValue %>"<%= BusinessDetails.SMTP_PORT.EditAttributes %>>
</span>
<%= BusinessDetails.SMTP_PORT.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.STICK_MENU.Visible Then ' STICK_MENU %>
	<div id="r_STICK_MENU" class="form-group">
		<label for="x_STICK_MENU" class="col-sm-2 control-label">
<input type="checkbox" name="u_STICK_MENU" id="u_STICK_MENU" value="1"<% If BusinessDetails.STICK_MENU.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.STICK_MENU.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.STICK_MENU.CellAttributes %>>
<span id="el_BusinessDetails_STICK_MENU">
<input type="text" data-field="x_STICK_MENU" name="x_STICK_MENU" id="x_STICK_MENU" size="30" maxlength="255" placeholder="<%= BusinessDetails.STICK_MENU.PlaceHolder %>" value="<%= BusinessDetails.STICK_MENU.EditValue %>"<%= BusinessDetails.STICK_MENU.EditAttributes %>>
</span>
<%= BusinessDetails.STICK_MENU.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.MAIL_CUSTOMER_SUBJECT.Visible Then ' MAIL_CUSTOMER_SUBJECT %>
	<div id="r_MAIL_CUSTOMER_SUBJECT" class="form-group">
		<label for="x_MAIL_CUSTOMER_SUBJECT" class="col-sm-2 control-label">
<input type="checkbox" name="u_MAIL_CUSTOMER_SUBJECT" id="u_MAIL_CUSTOMER_SUBJECT" value="1"<% If BusinessDetails.MAIL_CUSTOMER_SUBJECT.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.MAIL_CUSTOMER_SUBJECT.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.MAIL_CUSTOMER_SUBJECT.CellAttributes %>>
<span id="el_BusinessDetails_MAIL_CUSTOMER_SUBJECT">
<input type="text" data-field="x_MAIL_CUSTOMER_SUBJECT" name="x_MAIL_CUSTOMER_SUBJECT" id="x_MAIL_CUSTOMER_SUBJECT" size="30" maxlength="255" placeholder="<%= BusinessDetails.MAIL_CUSTOMER_SUBJECT.PlaceHolder %>" value="<%= BusinessDetails.MAIL_CUSTOMER_SUBJECT.EditValue %>"<%= BusinessDetails.MAIL_CUSTOMER_SUBJECT.EditAttributes %>>
</span>
<%= BusinessDetails.MAIL_CUSTOMER_SUBJECT.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.Visible Then ' CONFIRMATION_EMAIL_ADDRESS %>
	<div id="r_CONFIRMATION_EMAIL_ADDRESS" class="form-group">
		<label for="x_CONFIRMATION_EMAIL_ADDRESS" class="col-sm-2 control-label">
<input type="checkbox" name="u_CONFIRMATION_EMAIL_ADDRESS" id="u_CONFIRMATION_EMAIL_ADDRESS" value="1"<% If BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.CellAttributes %>>
<span id="el_BusinessDetails_CONFIRMATION_EMAIL_ADDRESS">
<input type="text" data-field="x_CONFIRMATION_EMAIL_ADDRESS" name="x_CONFIRMATION_EMAIL_ADDRESS" id="x_CONFIRMATION_EMAIL_ADDRESS" size="30" maxlength="255" placeholder="<%= BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.PlaceHolder %>" value="<%= BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.EditValue %>"<%= BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.EditAttributes %>>
</span>
<%= BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.SEND_ORDERS_TO_PRINTER.Visible Then ' SEND_ORDERS_TO_PRINTER %>
	<div id="r_SEND_ORDERS_TO_PRINTER" class="form-group">
		<label for="x_SEND_ORDERS_TO_PRINTER" class="col-sm-2 control-label">
<input type="checkbox" name="u_SEND_ORDERS_TO_PRINTER" id="u_SEND_ORDERS_TO_PRINTER" value="1"<% If BusinessDetails.SEND_ORDERS_TO_PRINTER.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.SEND_ORDERS_TO_PRINTER.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.SEND_ORDERS_TO_PRINTER.CellAttributes %>>
<span id="el_BusinessDetails_SEND_ORDERS_TO_PRINTER">
<input type="text" data-field="x_SEND_ORDERS_TO_PRINTER" name="x_SEND_ORDERS_TO_PRINTER" id="x_SEND_ORDERS_TO_PRINTER" size="30" maxlength="255" placeholder="<%= BusinessDetails.SEND_ORDERS_TO_PRINTER.PlaceHolder %>" value="<%= BusinessDetails.SEND_ORDERS_TO_PRINTER.EditValue %>"<%= BusinessDetails.SEND_ORDERS_TO_PRINTER.EditAttributes %>>
</span>
<%= BusinessDetails.SEND_ORDERS_TO_PRINTER.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.timezone.Visible Then ' timezone %>
	<div id="r_timezone" class="form-group">
		<label for="x_timezone" class="col-sm-2 control-label">
<input type="checkbox" name="u_timezone" id="u_timezone" value="1"<% If BusinessDetails.timezone.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.timezone.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.timezone.CellAttributes %>>
<span id="el_BusinessDetails_timezone">
<input type="text" data-field="x_timezone" name="x_timezone" id="x_timezone" size="30" placeholder="<%= BusinessDetails.timezone.PlaceHolder %>" value="<%= BusinessDetails.timezone.EditValue %>"<%= BusinessDetails.timezone.EditAttributes %>>
</span>
<%= BusinessDetails.timezone.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.PAYPAL_ADDR.Visible Then ' PAYPAL_ADDR %>
	<div id="r_PAYPAL_ADDR" class="form-group">
		<label for="x_PAYPAL_ADDR" class="col-sm-2 control-label">
<input type="checkbox" name="u_PAYPAL_ADDR" id="u_PAYPAL_ADDR" value="1"<% If BusinessDetails.PAYPAL_ADDR.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.PAYPAL_ADDR.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.PAYPAL_ADDR.CellAttributes %>>
<span id="el_BusinessDetails_PAYPAL_ADDR">
<input type="text" data-field="x_PAYPAL_ADDR" name="x_PAYPAL_ADDR" id="x_PAYPAL_ADDR" size="30" maxlength="255" placeholder="<%= BusinessDetails.PAYPAL_ADDR.PlaceHolder %>" value="<%= BusinessDetails.PAYPAL_ADDR.EditValue %>"<%= BusinessDetails.PAYPAL_ADDR.EditAttributes %>>
</span>
<%= BusinessDetails.PAYPAL_ADDR.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.nochex.Visible Then ' nochex %>
	<div id="r_nochex" class="form-group">
		<label for="x_nochex" class="col-sm-2 control-label">
<input type="checkbox" name="u_nochex" id="u_nochex" value="1"<% If BusinessDetails.nochex.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.nochex.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.nochex.CellAttributes %>>
<span id="el_BusinessDetails_nochex">
<input type="text" data-field="x_nochex" name="x_nochex" id="x_nochex" size="30" maxlength="255" placeholder="<%= BusinessDetails.nochex.PlaceHolder %>" value="<%= BusinessDetails.nochex.EditValue %>"<%= BusinessDetails.nochex.EditAttributes %>>
</span>
<%= BusinessDetails.nochex.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.nochexmerchantid.Visible Then ' nochexmerchantid %>
	<div id="r_nochexmerchantid" class="form-group">
		<label for="x_nochexmerchantid" class="col-sm-2 control-label">
<input type="checkbox" name="u_nochexmerchantid" id="u_nochexmerchantid" value="1"<% If BusinessDetails.nochexmerchantid.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.nochexmerchantid.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.nochexmerchantid.CellAttributes %>>
<span id="el_BusinessDetails_nochexmerchantid">
<input type="text" data-field="x_nochexmerchantid" name="x_nochexmerchantid" id="x_nochexmerchantid" size="30" maxlength="255" placeholder="<%= BusinessDetails.nochexmerchantid.PlaceHolder %>" value="<%= BusinessDetails.nochexmerchantid.EditValue %>"<%= BusinessDetails.nochexmerchantid.EditAttributes %>>
</span>
<%= BusinessDetails.nochexmerchantid.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.paypal.Visible Then ' paypal %>
	<div id="r_paypal" class="form-group">
		<label for="x_paypal" class="col-sm-2 control-label">
<input type="checkbox" name="u_paypal" id="u_paypal" value="1"<% If BusinessDetails.paypal.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.paypal.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.paypal.CellAttributes %>>
<span id="el_BusinessDetails_paypal">
<input type="text" data-field="x_paypal" name="x_paypal" id="x_paypal" size="30" maxlength="255" placeholder="<%= BusinessDetails.paypal.PlaceHolder %>" value="<%= BusinessDetails.paypal.EditValue %>"<%= BusinessDetails.paypal.EditAttributes %>>
</span>
<%= BusinessDetails.paypal.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.IBT_API_KEY.Visible Then ' IBT_API_KEY %>
	<div id="r_IBT_API_KEY" class="form-group">
		<label for="x_IBT_API_KEY" class="col-sm-2 control-label">
<input type="checkbox" name="u_IBT_API_KEY" id="u_IBT_API_KEY" value="1"<% If BusinessDetails.IBT_API_KEY.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.IBT_API_KEY.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.IBT_API_KEY.CellAttributes %>>
<span id="el_BusinessDetails_IBT_API_KEY">
<input type="text" data-field="x_IBT_API_KEY" name="x_IBT_API_KEY" id="x_IBT_API_KEY" size="30" maxlength="255" placeholder="<%= BusinessDetails.IBT_API_KEY.PlaceHolder %>" value="<%= BusinessDetails.IBT_API_KEY.EditValue %>"<%= BusinessDetails.IBT_API_KEY.EditAttributes %>>
</span>
<%= BusinessDetails.IBT_API_KEY.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.IBP_API_PASSWORD.Visible Then ' IBP_API_PASSWORD %>
	<div id="r_IBP_API_PASSWORD" class="form-group">
		<label for="x_IBP_API_PASSWORD" class="col-sm-2 control-label">
<input type="checkbox" name="u_IBP_API_PASSWORD" id="u_IBP_API_PASSWORD" value="1"<% If BusinessDetails.IBP_API_PASSWORD.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.IBP_API_PASSWORD.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.IBP_API_PASSWORD.CellAttributes %>>
<span id="el_BusinessDetails_IBP_API_PASSWORD">
<input type="text" data-field="x_IBP_API_PASSWORD" name="x_IBP_API_PASSWORD" id="x_IBP_API_PASSWORD" size="30" maxlength="255" placeholder="<%= BusinessDetails.IBP_API_PASSWORD.PlaceHolder %>" value="<%= BusinessDetails.IBP_API_PASSWORD.EditValue %>"<%= BusinessDetails.IBP_API_PASSWORD.EditAttributes %>>
</span>
<%= BusinessDetails.IBP_API_PASSWORD.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.disable_delivery.Visible Then ' disable_delivery %>
	<div id="r_disable_delivery" class="form-group">
		<label for="x_disable_delivery" class="col-sm-2 control-label">
<input type="checkbox" name="u_disable_delivery" id="u_disable_delivery" value="1"<% If BusinessDetails.disable_delivery.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.disable_delivery.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.disable_delivery.CellAttributes %>>
<span id="el_BusinessDetails_disable_delivery">
<input type="text" data-field="x_disable_delivery" name="x_disable_delivery" id="x_disable_delivery" size="30" maxlength="255" placeholder="<%= BusinessDetails.disable_delivery.PlaceHolder %>" value="<%= BusinessDetails.disable_delivery.EditValue %>"<%= BusinessDetails.disable_delivery.EditAttributes %>>
</span>
<%= BusinessDetails.disable_delivery.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.disable_collection.Visible Then ' disable_collection %>
	<div id="r_disable_collection" class="form-group">
		<label for="x_disable_collection" class="col-sm-2 control-label">
<input type="checkbox" name="u_disable_collection" id="u_disable_collection" value="1"<% If BusinessDetails.disable_collection.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.disable_collection.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.disable_collection.CellAttributes %>>
<span id="el_BusinessDetails_disable_collection">
<input type="text" data-field="x_disable_collection" name="x_disable_collection" id="x_disable_collection" size="30" maxlength="255" placeholder="<%= BusinessDetails.disable_collection.PlaceHolder %>" value="<%= BusinessDetails.disable_collection.EditValue %>"<%= BusinessDetails.disable_collection.EditAttributes %>>
</span>
<%= BusinessDetails.disable_collection.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.worldpay.Visible Then ' worldpay %>
	<div id="r_worldpay" class="form-group">
		<label for="x_worldpay" class="col-sm-2 control-label">
<input type="checkbox" name="u_worldpay" id="u_worldpay" value="1"<% If BusinessDetails.worldpay.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.worldpay.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.worldpay.CellAttributes %>>
<span id="el_BusinessDetails_worldpay">
<input type="text" data-field="x_worldpay" name="x_worldpay" id="x_worldpay" size="30" maxlength="255" placeholder="<%= BusinessDetails.worldpay.PlaceHolder %>" value="<%= BusinessDetails.worldpay.EditValue %>"<%= BusinessDetails.worldpay.EditAttributes %>>
</span>
<%= BusinessDetails.worldpay.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.worldpaymerchantid.Visible Then ' worldpaymerchantid %>
	<div id="r_worldpaymerchantid" class="form-group">
		<label for="x_worldpaymerchantid" class="col-sm-2 control-label">
<input type="checkbox" name="u_worldpaymerchantid" id="u_worldpaymerchantid" value="1"<% If BusinessDetails.worldpaymerchantid.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.worldpaymerchantid.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.worldpaymerchantid.CellAttributes %>>
<span id="el_BusinessDetails_worldpaymerchantid">
<input type="text" data-field="x_worldpaymerchantid" name="x_worldpaymerchantid" id="x_worldpaymerchantid" size="30" maxlength="255" placeholder="<%= BusinessDetails.worldpaymerchantid.PlaceHolder %>" value="<%= BusinessDetails.worldpaymerchantid.EditValue %>"<%= BusinessDetails.worldpaymerchantid.EditAttributes %>>
</span>
<%= BusinessDetails.worldpaymerchantid.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.backtohometext.Visible Then ' backtohometext %>
	<div id="r_backtohometext" class="form-group">
		<label for="x_backtohometext" class="col-sm-2 control-label">
<input type="checkbox" name="u_backtohometext" id="u_backtohometext" value="1"<% If BusinessDetails.backtohometext.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.backtohometext.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.backtohometext.CellAttributes %>>
<span id="el_BusinessDetails_backtohometext">
<textarea data-field="x_backtohometext" name="x_backtohometext" id="x_backtohometext" cols="35" rows="4" placeholder="<%= BusinessDetails.backtohometext.PlaceHolder %>"<%= BusinessDetails.backtohometext.EditAttributes %>><%= BusinessDetails.backtohometext.EditValue %></textarea>
</span>
<%= BusinessDetails.backtohometext.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.closedtext.Visible Then ' closedtext %>
	<div id="r_closedtext" class="form-group">
		<label for="x_closedtext" class="col-sm-2 control-label">
<input type="checkbox" name="u_closedtext" id="u_closedtext" value="1"<% If BusinessDetails.closedtext.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.closedtext.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.closedtext.CellAttributes %>>
<span id="el_BusinessDetails_closedtext">
<textarea data-field="x_closedtext" name="x_closedtext" id="x_closedtext" cols="35" rows="4" placeholder="<%= BusinessDetails.closedtext.PlaceHolder %>"<%= BusinessDetails.closedtext.EditAttributes %>><%= BusinessDetails.closedtext.EditValue %></textarea>
</span>
<%= BusinessDetails.closedtext.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.DeliveryChargeOverrideByOrderValue.Visible Then ' DeliveryChargeOverrideByOrderValue %>
	<div id="r_DeliveryChargeOverrideByOrderValue" class="form-group">
		<label for="x_DeliveryChargeOverrideByOrderValue" class="col-sm-2 control-label">
<input type="checkbox" name="u_DeliveryChargeOverrideByOrderValue" id="u_DeliveryChargeOverrideByOrderValue" value="1"<% If BusinessDetails.DeliveryChargeOverrideByOrderValue.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.DeliveryChargeOverrideByOrderValue.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.DeliveryChargeOverrideByOrderValue.CellAttributes %>>
<span id="el_BusinessDetails_DeliveryChargeOverrideByOrderValue">
<input type="text" data-field="x_DeliveryChargeOverrideByOrderValue" name="x_DeliveryChargeOverrideByOrderValue" id="x_DeliveryChargeOverrideByOrderValue" size="30" maxlength="255" placeholder="<%= BusinessDetails.DeliveryChargeOverrideByOrderValue.PlaceHolder %>" value="<%= BusinessDetails.DeliveryChargeOverrideByOrderValue.EditValue %>"<%= BusinessDetails.DeliveryChargeOverrideByOrderValue.EditAttributes %>>
</span>
<%= BusinessDetails.DeliveryChargeOverrideByOrderValue.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.individualpostcodes.Visible Then ' individualpostcodes %>
	<div id="r_individualpostcodes" class="form-group">
		<label for="x_individualpostcodes" class="col-sm-2 control-label">
<input type="checkbox" name="u_individualpostcodes" id="u_individualpostcodes" value="1"<% If BusinessDetails.individualpostcodes.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.individualpostcodes.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.individualpostcodes.CellAttributes %>>
<span id="el_BusinessDetails_individualpostcodes">
<textarea data-field="x_individualpostcodes" name="x_individualpostcodes" id="x_individualpostcodes" cols="35" rows="4" placeholder="<%= BusinessDetails.individualpostcodes.PlaceHolder %>"<%= BusinessDetails.individualpostcodes.EditAttributes %>><%= BusinessDetails.individualpostcodes.EditValue %></textarea>
</span>
<%= BusinessDetails.individualpostcodes.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.individualpostcodeschecking.Visible Then ' individualpostcodeschecking %>
	<div id="r_individualpostcodeschecking" class="form-group">
		<label for="x_individualpostcodeschecking" class="col-sm-2 control-label">
<input type="checkbox" name="u_individualpostcodeschecking" id="u_individualpostcodeschecking" value="1"<% If BusinessDetails.individualpostcodeschecking.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.individualpostcodeschecking.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.individualpostcodeschecking.CellAttributes %>>
<span id="el_BusinessDetails_individualpostcodeschecking">
<input type="text" data-field="x_individualpostcodeschecking" name="x_individualpostcodeschecking" id="x_individualpostcodeschecking" size="30" placeholder="<%= BusinessDetails.individualpostcodeschecking.PlaceHolder %>" value="<%= BusinessDetails.individualpostcodeschecking.EditValue %>"<%= BusinessDetails.individualpostcodeschecking.EditAttributes %>>
</span>
<%= BusinessDetails.individualpostcodeschecking.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.longitude.Visible Then ' longitude %>
	<div id="r_longitude" class="form-group">
		<label for="x_longitude" class="col-sm-2 control-label">
<input type="checkbox" name="u_longitude" id="u_longitude" value="1"<% If BusinessDetails.longitude.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.longitude.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.longitude.CellAttributes %>>
<span id="el_BusinessDetails_longitude">
<input type="text" data-field="x_longitude" name="x_longitude" id="x_longitude" size="30" maxlength="255" placeholder="<%= BusinessDetails.longitude.PlaceHolder %>" value="<%= BusinessDetails.longitude.EditValue %>"<%= BusinessDetails.longitude.EditAttributes %>>
</span>
<%= BusinessDetails.longitude.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.latitude.Visible Then ' latitude %>
	<div id="r_latitude" class="form-group">
		<label for="x_latitude" class="col-sm-2 control-label">
<input type="checkbox" name="u_latitude" id="u_latitude" value="1"<% If BusinessDetails.latitude.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.latitude.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.latitude.CellAttributes %>>
<span id="el_BusinessDetails_latitude">
<input type="text" data-field="x_latitude" name="x_latitude" id="x_latitude" size="30" maxlength="255" placeholder="<%= BusinessDetails.latitude.PlaceHolder %>" value="<%= BusinessDetails.latitude.EditValue %>"<%= BusinessDetails.latitude.EditAttributes %>>
</span>
<%= BusinessDetails.latitude.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.googleecommercetracking.Visible Then ' googleecommercetracking %>
	<div id="r_googleecommercetracking" class="form-group">
		<label for="x_googleecommercetracking" class="col-sm-2 control-label">
<input type="checkbox" name="u_googleecommercetracking" id="u_googleecommercetracking" value="1"<% If BusinessDetails.googleecommercetracking.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.googleecommercetracking.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.googleecommercetracking.CellAttributes %>>
<span id="el_BusinessDetails_googleecommercetracking">
<input type="text" data-field="x_googleecommercetracking" name="x_googleecommercetracking" id="x_googleecommercetracking" size="30" maxlength="255" placeholder="<%= BusinessDetails.googleecommercetracking.PlaceHolder %>" value="<%= BusinessDetails.googleecommercetracking.EditValue %>"<%= BusinessDetails.googleecommercetracking.EditAttributes %>>
</span>
<%= BusinessDetails.googleecommercetracking.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.googleecommercetrackingcode.Visible Then ' googleecommercetrackingcode %>
	<div id="r_googleecommercetrackingcode" class="form-group">
		<label for="x_googleecommercetrackingcode" class="col-sm-2 control-label">
<input type="checkbox" name="u_googleecommercetrackingcode" id="u_googleecommercetrackingcode" value="1"<% If BusinessDetails.googleecommercetrackingcode.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.googleecommercetrackingcode.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.googleecommercetrackingcode.CellAttributes %>>
<span id="el_BusinessDetails_googleecommercetrackingcode">
<input type="text" data-field="x_googleecommercetrackingcode" name="x_googleecommercetrackingcode" id="x_googleecommercetrackingcode" size="30" maxlength="255" placeholder="<%= BusinessDetails.googleecommercetrackingcode.PlaceHolder %>" value="<%= BusinessDetails.googleecommercetrackingcode.EditValue %>"<%= BusinessDetails.googleecommercetrackingcode.EditAttributes %>>
</span>
<%= BusinessDetails.googleecommercetrackingcode.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.bringg.Visible Then ' bringg %>
	<div id="r_bringg" class="form-group">
		<label for="x_bringg" class="col-sm-2 control-label">
<input type="checkbox" name="u_bringg" id="u_bringg" value="1"<% If BusinessDetails.bringg.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.bringg.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.bringg.CellAttributes %>>
<span id="el_BusinessDetails_bringg">
<input type="text" data-field="x_bringg" name="x_bringg" id="x_bringg" size="30" maxlength="255" placeholder="<%= BusinessDetails.bringg.PlaceHolder %>" value="<%= BusinessDetails.bringg.EditValue %>"<%= BusinessDetails.bringg.EditAttributes %>>
</span>
<%= BusinessDetails.bringg.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.bringgurl.Visible Then ' bringgurl %>
	<div id="r_bringgurl" class="form-group">
		<label for="x_bringgurl" class="col-sm-2 control-label">
<input type="checkbox" name="u_bringgurl" id="u_bringgurl" value="1"<% If BusinessDetails.bringgurl.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.bringgurl.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.bringgurl.CellAttributes %>>
<span id="el_BusinessDetails_bringgurl">
<input type="text" data-field="x_bringgurl" name="x_bringgurl" id="x_bringgurl" size="30" maxlength="255" placeholder="<%= BusinessDetails.bringgurl.PlaceHolder %>" value="<%= BusinessDetails.bringgurl.EditValue %>"<%= BusinessDetails.bringgurl.EditAttributes %>>
</span>
<%= BusinessDetails.bringgurl.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.bringgcompanyid.Visible Then ' bringgcompanyid %>
	<div id="r_bringgcompanyid" class="form-group">
		<label for="x_bringgcompanyid" class="col-sm-2 control-label">
<input type="checkbox" name="u_bringgcompanyid" id="u_bringgcompanyid" value="1"<% If BusinessDetails.bringgcompanyid.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.bringgcompanyid.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.bringgcompanyid.CellAttributes %>>
<span id="el_BusinessDetails_bringgcompanyid">
<input type="text" data-field="x_bringgcompanyid" name="x_bringgcompanyid" id="x_bringgcompanyid" size="30" maxlength="255" placeholder="<%= BusinessDetails.bringgcompanyid.PlaceHolder %>" value="<%= BusinessDetails.bringgcompanyid.EditValue %>"<%= BusinessDetails.bringgcompanyid.EditAttributes %>>
</span>
<%= BusinessDetails.bringgcompanyid.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.orderonlywhenopen.Visible Then ' orderonlywhenopen %>
	<div id="r_orderonlywhenopen" class="form-group">
		<label for="x_orderonlywhenopen" class="col-sm-2 control-label">
<input type="checkbox" name="u_orderonlywhenopen" id="u_orderonlywhenopen" value="1"<% If BusinessDetails.orderonlywhenopen.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.orderonlywhenopen.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.orderonlywhenopen.CellAttributes %>>
<span id="el_BusinessDetails_orderonlywhenopen">
<input type="text" data-field="x_orderonlywhenopen" name="x_orderonlywhenopen" id="x_orderonlywhenopen" size="30" placeholder="<%= BusinessDetails.orderonlywhenopen.PlaceHolder %>" value="<%= BusinessDetails.orderonlywhenopen.EditValue %>"<%= BusinessDetails.orderonlywhenopen.EditAttributes %>>
</span>
<%= BusinessDetails.orderonlywhenopen.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.disablelaterdelivery.Visible Then ' disablelaterdelivery %>
	<div id="r_disablelaterdelivery" class="form-group">
		<label for="x_disablelaterdelivery" class="col-sm-2 control-label">
<input type="checkbox" name="u_disablelaterdelivery" id="u_disablelaterdelivery" value="1"<% If BusinessDetails.disablelaterdelivery.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.disablelaterdelivery.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.disablelaterdelivery.CellAttributes %>>
<span id="el_BusinessDetails_disablelaterdelivery">
<input type="text" data-field="x_disablelaterdelivery" name="x_disablelaterdelivery" id="x_disablelaterdelivery" size="30" placeholder="<%= BusinessDetails.disablelaterdelivery.PlaceHolder %>" value="<%= BusinessDetails.disablelaterdelivery.EditValue %>"<%= BusinessDetails.disablelaterdelivery.EditAttributes %>>
</span>
<%= BusinessDetails.disablelaterdelivery.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.menupagetext.Visible Then ' menupagetext %>
	<div id="r_menupagetext" class="form-group">
		<label for="x_menupagetext" class="col-sm-2 control-label">
<input type="checkbox" name="u_menupagetext" id="u_menupagetext" value="1"<% If BusinessDetails.menupagetext.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.menupagetext.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.menupagetext.CellAttributes %>>
<span id="el_BusinessDetails_menupagetext">
<textarea data-field="x_menupagetext" name="x_menupagetext" id="x_menupagetext" cols="35" rows="4" placeholder="<%= BusinessDetails.menupagetext.PlaceHolder %>"<%= BusinessDetails.menupagetext.EditAttributes %>><%= BusinessDetails.menupagetext.EditValue %></textarea>
</span>
<%= BusinessDetails.menupagetext.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.ordertodayonly.Visible Then ' ordertodayonly %>
	<div id="r_ordertodayonly" class="form-group">
		<label for="x_ordertodayonly" class="col-sm-2 control-label">
<input type="checkbox" name="u_ordertodayonly" id="u_ordertodayonly" value="1"<% If BusinessDetails.ordertodayonly.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.ordertodayonly.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.ordertodayonly.CellAttributes %>>
<span id="el_BusinessDetails_ordertodayonly">
<input type="text" data-field="x_ordertodayonly" name="x_ordertodayonly" id="x_ordertodayonly" size="30" placeholder="<%= BusinessDetails.ordertodayonly.PlaceHolder %>" value="<%= BusinessDetails.ordertodayonly.EditValue %>"<%= BusinessDetails.ordertodayonly.EditAttributes %>>
</span>
<%= BusinessDetails.ordertodayonly.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.mileskm.Visible Then ' mileskm %>
	<div id="r_mileskm" class="form-group">
		<label for="x_mileskm" class="col-sm-2 control-label">
<input type="checkbox" name="u_mileskm" id="u_mileskm" value="1"<% If BusinessDetails.mileskm.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.mileskm.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.mileskm.CellAttributes %>>
<span id="el_BusinessDetails_mileskm">
<input type="text" data-field="x_mileskm" name="x_mileskm" id="x_mileskm" size="30" maxlength="255" placeholder="<%= BusinessDetails.mileskm.PlaceHolder %>" value="<%= BusinessDetails.mileskm.EditValue %>"<%= BusinessDetails.mileskm.EditAttributes %>>
</span>
<%= BusinessDetails.mileskm.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.worldpaylive.Visible Then ' worldpaylive %>
	<div id="r_worldpaylive" class="form-group">
		<label for="x_worldpaylive" class="col-sm-2 control-label">
<input type="checkbox" name="u_worldpaylive" id="u_worldpaylive" value="1"<% If BusinessDetails.worldpaylive.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.worldpaylive.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.worldpaylive.CellAttributes %>>
<span id="el_BusinessDetails_worldpaylive">
<input type="text" data-field="x_worldpaylive" name="x_worldpaylive" id="x_worldpaylive" size="30" placeholder="<%= BusinessDetails.worldpaylive.PlaceHolder %>" value="<%= BusinessDetails.worldpaylive.EditValue %>"<%= BusinessDetails.worldpaylive.EditAttributes %>>
</span>
<%= BusinessDetails.worldpaylive.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.worldpayinstallationid.Visible Then ' worldpayinstallationid %>
	<div id="r_worldpayinstallationid" class="form-group">
		<label for="x_worldpayinstallationid" class="col-sm-2 control-label">
<input type="checkbox" name="u_worldpayinstallationid" id="u_worldpayinstallationid" value="1"<% If BusinessDetails.worldpayinstallationid.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.worldpayinstallationid.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.worldpayinstallationid.CellAttributes %>>
<span id="el_BusinessDetails_worldpayinstallationid">
<input type="text" data-field="x_worldpayinstallationid" name="x_worldpayinstallationid" id="x_worldpayinstallationid" size="30" maxlength="255" placeholder="<%= BusinessDetails.worldpayinstallationid.PlaceHolder %>" value="<%= BusinessDetails.worldpayinstallationid.EditValue %>"<%= BusinessDetails.worldpayinstallationid.EditAttributes %>>
</span>
<%= BusinessDetails.worldpayinstallationid.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.DistanceCalMethod.Visible Then ' DistanceCalMethod %>
	<div id="r_DistanceCalMethod" class="form-group">
		<label for="x_DistanceCalMethod" class="col-sm-2 control-label">
<input type="checkbox" name="u_DistanceCalMethod" id="u_DistanceCalMethod" value="1"<% If BusinessDetails.DistanceCalMethod.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.DistanceCalMethod.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.DistanceCalMethod.CellAttributes %>>
<span id="el_BusinessDetails_DistanceCalMethod">
<input type="text" data-field="x_DistanceCalMethod" name="x_DistanceCalMethod" id="x_DistanceCalMethod" size="30" maxlength="255" placeholder="<%= BusinessDetails.DistanceCalMethod.PlaceHolder %>" value="<%= BusinessDetails.DistanceCalMethod.EditValue %>"<%= BusinessDetails.DistanceCalMethod.EditAttributes %>>
</span>
<%= BusinessDetails.DistanceCalMethod.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.PrinterIDList.Visible Then ' PrinterIDList %>
	<div id="r_PrinterIDList" class="form-group">
		<label for="x_PrinterIDList" class="col-sm-2 control-label">
<input type="checkbox" name="u_PrinterIDList" id="u_PrinterIDList" value="1"<% If BusinessDetails.PrinterIDList.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.PrinterIDList.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.PrinterIDList.CellAttributes %>>
<span id="el_BusinessDetails_PrinterIDList">
<input type="text" data-field="x_PrinterIDList" name="x_PrinterIDList" id="x_PrinterIDList" size="30" maxlength="255" placeholder="<%= BusinessDetails.PrinterIDList.PlaceHolder %>" value="<%= BusinessDetails.PrinterIDList.EditValue %>"<%= BusinessDetails.PrinterIDList.EditAttributes %>>
</span>
<%= BusinessDetails.PrinterIDList.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.EpsonJSPrinterURL.Visible Then ' EpsonJSPrinterURL %>
	<div id="r_EpsonJSPrinterURL" class="form-group">
		<label for="x_EpsonJSPrinterURL" class="col-sm-2 control-label">
<input type="checkbox" name="u_EpsonJSPrinterURL" id="u_EpsonJSPrinterURL" value="1"<% If BusinessDetails.EpsonJSPrinterURL.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.EpsonJSPrinterURL.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.EpsonJSPrinterURL.CellAttributes %>>
<span id="el_BusinessDetails_EpsonJSPrinterURL">
<input type="text" data-field="x_EpsonJSPrinterURL" name="x_EpsonJSPrinterURL" id="x_EpsonJSPrinterURL" size="30" maxlength="128" placeholder="<%= BusinessDetails.EpsonJSPrinterURL.PlaceHolder %>" value="<%= BusinessDetails.EpsonJSPrinterURL.EditValue %>"<%= BusinessDetails.EpsonJSPrinterURL.EditAttributes %>>
</span>
<%= BusinessDetails.EpsonJSPrinterURL.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.SMSEnable.Visible Then ' SMSEnable %>
	<div id="r_SMSEnable" class="form-group">
		<label for="x_SMSEnable" class="col-sm-2 control-label">
<input type="checkbox" name="u_SMSEnable" id="u_SMSEnable" value="1"<% If BusinessDetails.SMSEnable.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.SMSEnable.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.SMSEnable.CellAttributes %>>
<span id="el_BusinessDetails_SMSEnable">
<input type="text" data-field="x_SMSEnable" name="x_SMSEnable" id="x_SMSEnable" size="30" placeholder="<%= BusinessDetails.SMSEnable.PlaceHolder %>" value="<%= BusinessDetails.SMSEnable.EditValue %>"<%= BusinessDetails.SMSEnable.EditAttributes %>>
</span>
<%= BusinessDetails.SMSEnable.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.SMSOnDelivery.Visible Then ' SMSOnDelivery %>
	<div id="r_SMSOnDelivery" class="form-group">
		<label for="x_SMSOnDelivery" class="col-sm-2 control-label">
<input type="checkbox" name="u_SMSOnDelivery" id="u_SMSOnDelivery" value="1"<% If BusinessDetails.SMSOnDelivery.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.SMSOnDelivery.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.SMSOnDelivery.CellAttributes %>>
<span id="el_BusinessDetails_SMSOnDelivery">
<input type="text" data-field="x_SMSOnDelivery" name="x_SMSOnDelivery" id="x_SMSOnDelivery" size="30" placeholder="<%= BusinessDetails.SMSOnDelivery.PlaceHolder %>" value="<%= BusinessDetails.SMSOnDelivery.EditValue %>"<%= BusinessDetails.SMSOnDelivery.EditAttributes %>>
</span>
<%= BusinessDetails.SMSOnDelivery.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.SMSSupplierDomain.Visible Then ' SMSSupplierDomain %>
	<div id="r_SMSSupplierDomain" class="form-group">
		<label for="x_SMSSupplierDomain" class="col-sm-2 control-label">
<input type="checkbox" name="u_SMSSupplierDomain" id="u_SMSSupplierDomain" value="1"<% If BusinessDetails.SMSSupplierDomain.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.SMSSupplierDomain.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.SMSSupplierDomain.CellAttributes %>>
<span id="el_BusinessDetails_SMSSupplierDomain">
<input type="text" data-field="x_SMSSupplierDomain" name="x_SMSSupplierDomain" id="x_SMSSupplierDomain" size="30" maxlength="100" placeholder="<%= BusinessDetails.SMSSupplierDomain.PlaceHolder %>" value="<%= BusinessDetails.SMSSupplierDomain.EditValue %>"<%= BusinessDetails.SMSSupplierDomain.EditAttributes %>>
</span>
<%= BusinessDetails.SMSSupplierDomain.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.SMSOnOrder.Visible Then ' SMSOnOrder %>
	<div id="r_SMSOnOrder" class="form-group">
		<label for="x_SMSOnOrder" class="col-sm-2 control-label">
<input type="checkbox" name="u_SMSOnOrder" id="u_SMSOnOrder" value="1"<% If BusinessDetails.SMSOnOrder.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.SMSOnOrder.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.SMSOnOrder.CellAttributes %>>
<span id="el_BusinessDetails_SMSOnOrder">
<input type="text" data-field="x_SMSOnOrder" name="x_SMSOnOrder" id="x_SMSOnOrder" size="30" placeholder="<%= BusinessDetails.SMSOnOrder.PlaceHolder %>" value="<%= BusinessDetails.SMSOnOrder.EditValue %>"<%= BusinessDetails.SMSOnOrder.EditAttributes %>>
</span>
<%= BusinessDetails.SMSOnOrder.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.SMSOnOrderAfterMin.Visible Then ' SMSOnOrderAfterMin %>
	<div id="r_SMSOnOrderAfterMin" class="form-group">
		<label for="x_SMSOnOrderAfterMin" class="col-sm-2 control-label">
<input type="checkbox" name="u_SMSOnOrderAfterMin" id="u_SMSOnOrderAfterMin" value="1"<% If BusinessDetails.SMSOnOrderAfterMin.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.SMSOnOrderAfterMin.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.SMSOnOrderAfterMin.CellAttributes %>>
<span id="el_BusinessDetails_SMSOnOrderAfterMin">
<input type="text" data-field="x_SMSOnOrderAfterMin" name="x_SMSOnOrderAfterMin" id="x_SMSOnOrderAfterMin" size="30" placeholder="<%= BusinessDetails.SMSOnOrderAfterMin.PlaceHolder %>" value="<%= BusinessDetails.SMSOnOrderAfterMin.EditValue %>"<%= BusinessDetails.SMSOnOrderAfterMin.EditAttributes %>>
</span>
<%= BusinessDetails.SMSOnOrderAfterMin.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.SMSOnOrderContent.Visible Then ' SMSOnOrderContent %>
	<div id="r_SMSOnOrderContent" class="form-group">
		<label for="x_SMSOnOrderContent" class="col-sm-2 control-label">
<input type="checkbox" name="u_SMSOnOrderContent" id="u_SMSOnOrderContent" value="1"<% If BusinessDetails.SMSOnOrderContent.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.SMSOnOrderContent.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.SMSOnOrderContent.CellAttributes %>>
<span id="el_BusinessDetails_SMSOnOrderContent">
<input type="text" data-field="x_SMSOnOrderContent" name="x_SMSOnOrderContent" id="x_SMSOnOrderContent" size="30" maxlength="255" placeholder="<%= BusinessDetails.SMSOnOrderContent.PlaceHolder %>" value="<%= BusinessDetails.SMSOnOrderContent.EditValue %>"<%= BusinessDetails.SMSOnOrderContent.EditAttributes %>>
</span>
<%= BusinessDetails.SMSOnOrderContent.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.DefaultSMSCountryCode.Visible Then ' DefaultSMSCountryCode %>
	<div id="r_DefaultSMSCountryCode" class="form-group">
		<label for="x_DefaultSMSCountryCode" class="col-sm-2 control-label">
<input type="checkbox" name="u_DefaultSMSCountryCode" id="u_DefaultSMSCountryCode" value="1"<% If BusinessDetails.DefaultSMSCountryCode.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.DefaultSMSCountryCode.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.DefaultSMSCountryCode.CellAttributes %>>
<span id="el_BusinessDetails_DefaultSMSCountryCode">
<input type="text" data-field="x_DefaultSMSCountryCode" name="x_DefaultSMSCountryCode" id="x_DefaultSMSCountryCode" size="30" maxlength="10" placeholder="<%= BusinessDetails.DefaultSMSCountryCode.PlaceHolder %>" value="<%= BusinessDetails.DefaultSMSCountryCode.EditValue %>"<%= BusinessDetails.DefaultSMSCountryCode.EditAttributes %>>
</span>
<%= BusinessDetails.DefaultSMSCountryCode.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.MinimumAmountForCardPayment.Visible Then ' MinimumAmountForCardPayment %>
	<div id="r_MinimumAmountForCardPayment" class="form-group">
		<label for="x_MinimumAmountForCardPayment" class="col-sm-2 control-label">
<input type="checkbox" name="u_MinimumAmountForCardPayment" id="u_MinimumAmountForCardPayment" value="1"<% If BusinessDetails.MinimumAmountForCardPayment.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.MinimumAmountForCardPayment.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.MinimumAmountForCardPayment.CellAttributes %>>
<span id="el_BusinessDetails_MinimumAmountForCardPayment">
<input type="text" data-field="x_MinimumAmountForCardPayment" name="x_MinimumAmountForCardPayment" id="x_MinimumAmountForCardPayment" size="30" placeholder="<%= BusinessDetails.MinimumAmountForCardPayment.PlaceHolder %>" value="<%= BusinessDetails.MinimumAmountForCardPayment.EditValue %>"<%= BusinessDetails.MinimumAmountForCardPayment.EditAttributes %>>
</span>
<%= BusinessDetails.MinimumAmountForCardPayment.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.FavIconUrl.Visible Then ' FavIconUrl %>
	<div id="r_FavIconUrl" class="form-group">
		<label for="x_FavIconUrl" class="col-sm-2 control-label">
<input type="checkbox" name="u_FavIconUrl" id="u_FavIconUrl" value="1"<% If BusinessDetails.FavIconUrl.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.FavIconUrl.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.FavIconUrl.CellAttributes %>>
<span id="el_BusinessDetails_FavIconUrl">
<input type="text" data-field="x_FavIconUrl" name="x_FavIconUrl" id="x_FavIconUrl" size="30" maxlength="255" placeholder="<%= BusinessDetails.FavIconUrl.PlaceHolder %>" value="<%= BusinessDetails.FavIconUrl.EditValue %>"<%= BusinessDetails.FavIconUrl.EditAttributes %>>
</span>
<%= BusinessDetails.FavIconUrl.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.AddToHomeScreenURL.Visible Then ' AddToHomeScreenURL %>
	<div id="r_AddToHomeScreenURL" class="form-group">
		<label for="x_AddToHomeScreenURL" class="col-sm-2 control-label">
<input type="checkbox" name="u_AddToHomeScreenURL" id="u_AddToHomeScreenURL" value="1"<% If BusinessDetails.AddToHomeScreenURL.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.AddToHomeScreenURL.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.AddToHomeScreenURL.CellAttributes %>>
<span id="el_BusinessDetails_AddToHomeScreenURL">
<input type="text" data-field="x_AddToHomeScreenURL" name="x_AddToHomeScreenURL" id="x_AddToHomeScreenURL" size="30" maxlength="255" placeholder="<%= BusinessDetails.AddToHomeScreenURL.PlaceHolder %>" value="<%= BusinessDetails.AddToHomeScreenURL.EditValue %>"<%= BusinessDetails.AddToHomeScreenURL.EditAttributes %>>
</span>
<%= BusinessDetails.AddToHomeScreenURL.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.SMSOnAcknowledgement.Visible Then ' SMSOnAcknowledgement %>
	<div id="r_SMSOnAcknowledgement" class="form-group">
		<label for="x_SMSOnAcknowledgement" class="col-sm-2 control-label">
<input type="checkbox" name="u_SMSOnAcknowledgement" id="u_SMSOnAcknowledgement" value="1"<% If BusinessDetails.SMSOnAcknowledgement.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.SMSOnAcknowledgement.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.SMSOnAcknowledgement.CellAttributes %>>
<span id="el_BusinessDetails_SMSOnAcknowledgement">
<input type="text" data-field="x_SMSOnAcknowledgement" name="x_SMSOnAcknowledgement" id="x_SMSOnAcknowledgement" size="30" placeholder="<%= BusinessDetails.SMSOnAcknowledgement.PlaceHolder %>" value="<%= BusinessDetails.SMSOnAcknowledgement.EditValue %>"<%= BusinessDetails.SMSOnAcknowledgement.EditAttributes %>>
</span>
<%= BusinessDetails.SMSOnAcknowledgement.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.LocalPrinterURL.Visible Then ' LocalPrinterURL %>
	<div id="r_LocalPrinterURL" class="form-group">
		<label for="x_LocalPrinterURL" class="col-sm-2 control-label">
<input type="checkbox" name="u_LocalPrinterURL" id="u_LocalPrinterURL" value="1"<% If BusinessDetails.LocalPrinterURL.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.LocalPrinterURL.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.LocalPrinterURL.CellAttributes %>>
<span id="el_BusinessDetails_LocalPrinterURL">
<input type="text" data-field="x_LocalPrinterURL" name="x_LocalPrinterURL" id="x_LocalPrinterURL" size="30" maxlength="255" placeholder="<%= BusinessDetails.LocalPrinterURL.PlaceHolder %>" value="<%= BusinessDetails.LocalPrinterURL.EditValue %>"<%= BusinessDetails.LocalPrinterURL.EditAttributes %>>
</span>
<%= BusinessDetails.LocalPrinterURL.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.ShowRestaurantDetailOnReceipt.Visible Then ' ShowRestaurantDetailOnReceipt %>
	<div id="r_ShowRestaurantDetailOnReceipt" class="form-group">
		<label for="x_ShowRestaurantDetailOnReceipt" class="col-sm-2 control-label">
<input type="checkbox" name="u_ShowRestaurantDetailOnReceipt" id="u_ShowRestaurantDetailOnReceipt" value="1"<% If BusinessDetails.ShowRestaurantDetailOnReceipt.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.ShowRestaurantDetailOnReceipt.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.ShowRestaurantDetailOnReceipt.CellAttributes %>>
<span id="el_BusinessDetails_ShowRestaurantDetailOnReceipt">
<input type="text" data-field="x_ShowRestaurantDetailOnReceipt" name="x_ShowRestaurantDetailOnReceipt" id="x_ShowRestaurantDetailOnReceipt" size="30" placeholder="<%= BusinessDetails.ShowRestaurantDetailOnReceipt.PlaceHolder %>" value="<%= BusinessDetails.ShowRestaurantDetailOnReceipt.EditValue %>"<%= BusinessDetails.ShowRestaurantDetailOnReceipt.EditAttributes %>>
</span>
<%= BusinessDetails.ShowRestaurantDetailOnReceipt.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.PrinterFontSizeRatio.Visible Then ' PrinterFontSizeRatio %>
	<div id="r_PrinterFontSizeRatio" class="form-group">
		<label for="x_PrinterFontSizeRatio" class="col-sm-2 control-label">
<input type="checkbox" name="u_PrinterFontSizeRatio" id="u_PrinterFontSizeRatio" value="1"<% If BusinessDetails.PrinterFontSizeRatio.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.PrinterFontSizeRatio.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.PrinterFontSizeRatio.CellAttributes %>>
<span id="el_BusinessDetails_PrinterFontSizeRatio">
<input type="text" data-field="x_PrinterFontSizeRatio" name="x_PrinterFontSizeRatio" id="x_PrinterFontSizeRatio" size="30" placeholder="<%= BusinessDetails.PrinterFontSizeRatio.PlaceHolder %>" value="<%= BusinessDetails.PrinterFontSizeRatio.EditValue %>"<%= BusinessDetails.PrinterFontSizeRatio.EditAttributes %>>
</span>
<%= BusinessDetails.PrinterFontSizeRatio.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.ServiceChargePercentage.Visible Then ' ServiceChargePercentage %>
	<div id="r_ServiceChargePercentage" class="form-group">
		<label for="x_ServiceChargePercentage" class="col-sm-2 control-label">
<input type="checkbox" name="u_ServiceChargePercentage" id="u_ServiceChargePercentage" value="1"<% If BusinessDetails.ServiceChargePercentage.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.ServiceChargePercentage.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.ServiceChargePercentage.CellAttributes %>>
<span id="el_BusinessDetails_ServiceChargePercentage">
<input type="text" data-field="x_ServiceChargePercentage" name="x_ServiceChargePercentage" id="x_ServiceChargePercentage" size="30" placeholder="<%= BusinessDetails.ServiceChargePercentage.PlaceHolder %>" value="<%= BusinessDetails.ServiceChargePercentage.EditValue %>"<%= BusinessDetails.ServiceChargePercentage.EditAttributes %>>
</span>
<%= BusinessDetails.ServiceChargePercentage.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.InRestaurantServiceChargeOnly.Visible Then ' InRestaurantServiceChargeOnly %>
	<div id="r_InRestaurantServiceChargeOnly" class="form-group">
		<label for="x_InRestaurantServiceChargeOnly" class="col-sm-2 control-label">
<input type="checkbox" name="u_InRestaurantServiceChargeOnly" id="u_InRestaurantServiceChargeOnly" value="1"<% If BusinessDetails.InRestaurantServiceChargeOnly.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.InRestaurantServiceChargeOnly.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.InRestaurantServiceChargeOnly.CellAttributes %>>
<span id="el_BusinessDetails_InRestaurantServiceChargeOnly">
<input type="text" data-field="x_InRestaurantServiceChargeOnly" name="x_InRestaurantServiceChargeOnly" id="x_InRestaurantServiceChargeOnly" size="30" placeholder="<%= BusinessDetails.InRestaurantServiceChargeOnly.PlaceHolder %>" value="<%= BusinessDetails.InRestaurantServiceChargeOnly.EditValue %>"<%= BusinessDetails.InRestaurantServiceChargeOnly.EditAttributes %>>
</span>
<%= BusinessDetails.InRestaurantServiceChargeOnly.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.IsDualReceiptPrinting.Visible Then ' IsDualReceiptPrinting %>
	<div id="r_IsDualReceiptPrinting" class="form-group">
		<label for="x_IsDualReceiptPrinting" class="col-sm-2 control-label">
<input type="checkbox" name="u_IsDualReceiptPrinting" id="u_IsDualReceiptPrinting" value="1"<% If BusinessDetails.IsDualReceiptPrinting.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.IsDualReceiptPrinting.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.IsDualReceiptPrinting.CellAttributes %>>
<span id="el_BusinessDetails_IsDualReceiptPrinting">
<input type="text" data-field="x_IsDualReceiptPrinting" name="x_IsDualReceiptPrinting" id="x_IsDualReceiptPrinting" size="30" placeholder="<%= BusinessDetails.IsDualReceiptPrinting.PlaceHolder %>" value="<%= BusinessDetails.IsDualReceiptPrinting.EditValue %>"<%= BusinessDetails.IsDualReceiptPrinting.EditAttributes %>>
</span>
<%= BusinessDetails.IsDualReceiptPrinting.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.PrintingFontSize.Visible Then ' PrintingFontSize %>
	<div id="r_PrintingFontSize" class="form-group">
		<label for="x_PrintingFontSize" class="col-sm-2 control-label">
<input type="checkbox" name="u_PrintingFontSize" id="u_PrintingFontSize" value="1"<% If BusinessDetails.PrintingFontSize.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.PrintingFontSize.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.PrintingFontSize.CellAttributes %>>
<span id="el_BusinessDetails_PrintingFontSize">
<input type="text" data-field="x_PrintingFontSize" name="x_PrintingFontSize" id="x_PrintingFontSize" size="30" placeholder="<%= BusinessDetails.PrintingFontSize.PlaceHolder %>" value="<%= BusinessDetails.PrintingFontSize.EditValue %>"<%= BusinessDetails.PrintingFontSize.EditAttributes %>>
</span>
<%= BusinessDetails.PrintingFontSize.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.InRestaurantEpsonPrinterIDList.Visible Then ' InRestaurantEpsonPrinterIDList %>
	<div id="r_InRestaurantEpsonPrinterIDList" class="form-group">
		<label for="x_InRestaurantEpsonPrinterIDList" class="col-sm-2 control-label">
<input type="checkbox" name="u_InRestaurantEpsonPrinterIDList" id="u_InRestaurantEpsonPrinterIDList" value="1"<% If BusinessDetails.InRestaurantEpsonPrinterIDList.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.InRestaurantEpsonPrinterIDList.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.InRestaurantEpsonPrinterIDList.CellAttributes %>>
<span id="el_BusinessDetails_InRestaurantEpsonPrinterIDList">
<input type="text" data-field="x_InRestaurantEpsonPrinterIDList" name="x_InRestaurantEpsonPrinterIDList" id="x_InRestaurantEpsonPrinterIDList" size="30" maxlength="128" placeholder="<%= BusinessDetails.InRestaurantEpsonPrinterIDList.PlaceHolder %>" value="<%= BusinessDetails.InRestaurantEpsonPrinterIDList.EditValue %>"<%= BusinessDetails.InRestaurantEpsonPrinterIDList.EditAttributes %>>
</span>
<%= BusinessDetails.InRestaurantEpsonPrinterIDList.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.BlockIPEmailList.Visible Then ' BlockIPEmailList %>
	<div id="r_BlockIPEmailList" class="form-group">
		<label for="x_BlockIPEmailList" class="col-sm-2 control-label">
<input type="checkbox" name="u_BlockIPEmailList" id="u_BlockIPEmailList" value="1"<% If BusinessDetails.BlockIPEmailList.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.BlockIPEmailList.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.BlockIPEmailList.CellAttributes %>>
<span id="el_BusinessDetails_BlockIPEmailList">
<input type="text" data-field="x_BlockIPEmailList" name="x_BlockIPEmailList" id="x_BlockIPEmailList" size="30" maxlength="255" placeholder="<%= BusinessDetails.BlockIPEmailList.PlaceHolder %>" value="<%= BusinessDetails.BlockIPEmailList.EditValue %>"<%= BusinessDetails.BlockIPEmailList.EditAttributes %>>
</span>
<%= BusinessDetails.BlockIPEmailList.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.inmenuannouncement.Visible Then ' inmenuannouncement %>
	<div id="r_inmenuannouncement" class="form-group">
		<label for="x_inmenuannouncement" class="col-sm-2 control-label">
<input type="checkbox" name="u_inmenuannouncement" id="u_inmenuannouncement" value="1"<% If BusinessDetails.inmenuannouncement.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.inmenuannouncement.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.inmenuannouncement.CellAttributes %>>
<span id="el_BusinessDetails_inmenuannouncement">
<textarea data-field="x_inmenuannouncement" name="x_inmenuannouncement" id="x_inmenuannouncement" cols="35" rows="4" placeholder="<%= BusinessDetails.inmenuannouncement.PlaceHolder %>"<%= BusinessDetails.inmenuannouncement.EditAttributes %>><%= BusinessDetails.inmenuannouncement.EditValue %></textarea>
</span>
<%= BusinessDetails.inmenuannouncement.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.RePrintReceiptWays.Visible Then ' RePrintReceiptWays %>
	<div id="r_RePrintReceiptWays" class="form-group">
		<label for="x_RePrintReceiptWays" class="col-sm-2 control-label">
<input type="checkbox" name="u_RePrintReceiptWays" id="u_RePrintReceiptWays" value="1"<% If BusinessDetails.RePrintReceiptWays.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.RePrintReceiptWays.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.RePrintReceiptWays.CellAttributes %>>
<span id="el_BusinessDetails_RePrintReceiptWays">
<input type="text" data-field="x_RePrintReceiptWays" name="x_RePrintReceiptWays" id="x_RePrintReceiptWays" size="30" maxlength="255" placeholder="<%= BusinessDetails.RePrintReceiptWays.PlaceHolder %>" value="<%= BusinessDetails.RePrintReceiptWays.EditValue %>"<%= BusinessDetails.RePrintReceiptWays.EditAttributes %>>
</span>
<%= BusinessDetails.RePrintReceiptWays.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.printingtype.Visible Then ' printingtype %>
	<div id="r_printingtype" class="form-group">
		<label for="x_printingtype" class="col-sm-2 control-label">
<input type="checkbox" name="u_printingtype" id="u_printingtype" value="1"<% If BusinessDetails.printingtype.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.printingtype.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.printingtype.CellAttributes %>>
<span id="el_BusinessDetails_printingtype">
<input type="text" data-field="x_printingtype" name="x_printingtype" id="x_printingtype" size="30" maxlength="255" placeholder="<%= BusinessDetails.printingtype.PlaceHolder %>" value="<%= BusinessDetails.printingtype.EditValue %>"<%= BusinessDetails.printingtype.EditAttributes %>>
</span>
<%= BusinessDetails.printingtype.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.Stripe_Key_Secret.Visible Then ' Stripe_Key_Secret %>
	<div id="r_Stripe_Key_Secret" class="form-group">
		<label for="x_Stripe_Key_Secret" class="col-sm-2 control-label">
<input type="checkbox" name="u_Stripe_Key_Secret" id="u_Stripe_Key_Secret" value="1"<% If BusinessDetails.Stripe_Key_Secret.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.Stripe_Key_Secret.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.Stripe_Key_Secret.CellAttributes %>>
<span id="el_BusinessDetails_Stripe_Key_Secret">
<input type="text" data-field="x_Stripe_Key_Secret" name="x_Stripe_Key_Secret" id="x_Stripe_Key_Secret" size="30" maxlength="255" placeholder="<%= BusinessDetails.Stripe_Key_Secret.PlaceHolder %>" value="<%= BusinessDetails.Stripe_Key_Secret.EditValue %>"<%= BusinessDetails.Stripe_Key_Secret.EditAttributes %>>
</span>
<%= BusinessDetails.Stripe_Key_Secret.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.Stripe.Visible Then ' Stripe %>
	<div id="r_Stripe" class="form-group">
		<label for="x_Stripe" class="col-sm-2 control-label">
<input type="checkbox" name="u_Stripe" id="u_Stripe" value="1"<% If BusinessDetails.Stripe.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.Stripe.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.Stripe.CellAttributes %>>
<span id="el_BusinessDetails_Stripe">
<input type="text" data-field="x_Stripe" name="x_Stripe" id="x_Stripe" size="30" maxlength="255" placeholder="<%= BusinessDetails.Stripe.PlaceHolder %>" value="<%= BusinessDetails.Stripe.EditValue %>"<%= BusinessDetails.Stripe.EditAttributes %>>
</span>
<%= BusinessDetails.Stripe.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.Stripe_Api_Key.Visible Then ' Stripe_Api_Key %>
	<div id="r_Stripe_Api_Key" class="form-group">
		<label for="x_Stripe_Api_Key" class="col-sm-2 control-label">
<input type="checkbox" name="u_Stripe_Api_Key" id="u_Stripe_Api_Key" value="1"<% If BusinessDetails.Stripe_Api_Key.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.Stripe_Api_Key.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.Stripe_Api_Key.CellAttributes %>>
<span id="el_BusinessDetails_Stripe_Api_Key">
<input type="text" data-field="x_Stripe_Api_Key" name="x_Stripe_Api_Key" id="x_Stripe_Api_Key" size="30" maxlength="255" placeholder="<%= BusinessDetails.Stripe_Api_Key.PlaceHolder %>" value="<%= BusinessDetails.Stripe_Api_Key.EditValue %>"<%= BusinessDetails.Stripe_Api_Key.EditAttributes %>>
</span>
<%= BusinessDetails.Stripe_Api_Key.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.EnableBooking.Visible Then ' EnableBooking %>
	<div id="r_EnableBooking" class="form-group">
		<label for="x_EnableBooking" class="col-sm-2 control-label">
<input type="checkbox" name="u_EnableBooking" id="u_EnableBooking" value="1"<% If BusinessDetails.EnableBooking.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.EnableBooking.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.EnableBooking.CellAttributes %>>
<span id="el_BusinessDetails_EnableBooking">
<input type="text" data-field="x_EnableBooking" name="x_EnableBooking" id="x_EnableBooking" size="30" maxlength="255" placeholder="<%= BusinessDetails.EnableBooking.PlaceHolder %>" value="<%= BusinessDetails.EnableBooking.EditValue %>"<%= BusinessDetails.EnableBooking.EditAttributes %>>
</span>
<%= BusinessDetails.EnableBooking.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.URL_Facebook.Visible Then ' URL_Facebook %>
	<div id="r_URL_Facebook" class="form-group">
		<label for="x_URL_Facebook" class="col-sm-2 control-label">
<input type="checkbox" name="u_URL_Facebook" id="u_URL_Facebook" value="1"<% If BusinessDetails.URL_Facebook.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.URL_Facebook.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.URL_Facebook.CellAttributes %>>
<span id="el_BusinessDetails_URL_Facebook">
<input type="text" data-field="x_URL_Facebook" name="x_URL_Facebook" id="x_URL_Facebook" size="30" maxlength="255" placeholder="<%= BusinessDetails.URL_Facebook.PlaceHolder %>" value="<%= BusinessDetails.URL_Facebook.EditValue %>"<%= BusinessDetails.URL_Facebook.EditAttributes %>>
</span>
<%= BusinessDetails.URL_Facebook.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.URL_Twitter.Visible Then ' URL_Twitter %>
	<div id="r_URL_Twitter" class="form-group">
		<label for="x_URL_Twitter" class="col-sm-2 control-label">
<input type="checkbox" name="u_URL_Twitter" id="u_URL_Twitter" value="1"<% If BusinessDetails.URL_Twitter.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.URL_Twitter.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.URL_Twitter.CellAttributes %>>
<span id="el_BusinessDetails_URL_Twitter">
<input type="text" data-field="x_URL_Twitter" name="x_URL_Twitter" id="x_URL_Twitter" size="30" maxlength="255" placeholder="<%= BusinessDetails.URL_Twitter.PlaceHolder %>" value="<%= BusinessDetails.URL_Twitter.EditValue %>"<%= BusinessDetails.URL_Twitter.EditAttributes %>>
</span>
<%= BusinessDetails.URL_Twitter.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.URL_Google.Visible Then ' URL_Google %>
	<div id="r_URL_Google" class="form-group">
		<label for="x_URL_Google" class="col-sm-2 control-label">
<input type="checkbox" name="u_URL_Google" id="u_URL_Google" value="1"<% If BusinessDetails.URL_Google.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.URL_Google.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.URL_Google.CellAttributes %>>
<span id="el_BusinessDetails_URL_Google">
<input type="text" data-field="x_URL_Google" name="x_URL_Google" id="x_URL_Google" size="30" maxlength="255" placeholder="<%= BusinessDetails.URL_Google.PlaceHolder %>" value="<%= BusinessDetails.URL_Google.EditValue %>"<%= BusinessDetails.URL_Google.EditAttributes %>>
</span>
<%= BusinessDetails.URL_Google.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.URL_Intagram.Visible Then ' URL_Intagram %>
	<div id="r_URL_Intagram" class="form-group">
		<label for="x_URL_Intagram" class="col-sm-2 control-label">
<input type="checkbox" name="u_URL_Intagram" id="u_URL_Intagram" value="1"<% If BusinessDetails.URL_Intagram.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.URL_Intagram.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.URL_Intagram.CellAttributes %>>
<span id="el_BusinessDetails_URL_Intagram">
<input type="text" data-field="x_URL_Intagram" name="x_URL_Intagram" id="x_URL_Intagram" size="30" maxlength="255" placeholder="<%= BusinessDetails.URL_Intagram.PlaceHolder %>" value="<%= BusinessDetails.URL_Intagram.EditValue %>"<%= BusinessDetails.URL_Intagram.EditAttributes %>>
</span>
<%= BusinessDetails.URL_Intagram.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.URL_YouTube.Visible Then ' URL_YouTube %>
	<div id="r_URL_YouTube" class="form-group">
		<label for="x_URL_YouTube" class="col-sm-2 control-label">
<input type="checkbox" name="u_URL_YouTube" id="u_URL_YouTube" value="1"<% If BusinessDetails.URL_YouTube.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.URL_YouTube.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.URL_YouTube.CellAttributes %>>
<span id="el_BusinessDetails_URL_YouTube">
<input type="text" data-field="x_URL_YouTube" name="x_URL_YouTube" id="x_URL_YouTube" size="30" maxlength="255" placeholder="<%= BusinessDetails.URL_YouTube.PlaceHolder %>" value="<%= BusinessDetails.URL_YouTube.EditValue %>"<%= BusinessDetails.URL_YouTube.EditAttributes %>>
</span>
<%= BusinessDetails.URL_YouTube.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.URL_Tripadvisor.Visible Then ' URL_Tripadvisor %>
	<div id="r_URL_Tripadvisor" class="form-group">
		<label for="x_URL_Tripadvisor" class="col-sm-2 control-label">
<input type="checkbox" name="u_URL_Tripadvisor" id="u_URL_Tripadvisor" value="1"<% If BusinessDetails.URL_Tripadvisor.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.URL_Tripadvisor.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.URL_Tripadvisor.CellAttributes %>>
<span id="el_BusinessDetails_URL_Tripadvisor">
<input type="text" data-field="x_URL_Tripadvisor" name="x_URL_Tripadvisor" id="x_URL_Tripadvisor" size="30" maxlength="255" placeholder="<%= BusinessDetails.URL_Tripadvisor.PlaceHolder %>" value="<%= BusinessDetails.URL_Tripadvisor.EditValue %>"<%= BusinessDetails.URL_Tripadvisor.EditAttributes %>>
</span>
<%= BusinessDetails.URL_Tripadvisor.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.URL_Special_Offer.Visible Then ' URL_Special_Offer %>
	<div id="r_URL_Special_Offer" class="form-group">
		<label for="x_URL_Special_Offer" class="col-sm-2 control-label">
<input type="checkbox" name="u_URL_Special_Offer" id="u_URL_Special_Offer" value="1"<% If BusinessDetails.URL_Special_Offer.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.URL_Special_Offer.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.URL_Special_Offer.CellAttributes %>>
<span id="el_BusinessDetails_URL_Special_Offer">
<input type="text" data-field="x_URL_Special_Offer" name="x_URL_Special_Offer" id="x_URL_Special_Offer" size="30" maxlength="255" placeholder="<%= BusinessDetails.URL_Special_Offer.PlaceHolder %>" value="<%= BusinessDetails.URL_Special_Offer.EditValue %>"<%= BusinessDetails.URL_Special_Offer.EditAttributes %>>
</span>
<%= BusinessDetails.URL_Special_Offer.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.URL_Linkin.Visible Then ' URL_Linkin %>
	<div id="r_URL_Linkin" class="form-group">
		<label for="x_URL_Linkin" class="col-sm-2 control-label">
<input type="checkbox" name="u_URL_Linkin" id="u_URL_Linkin" value="1"<% If BusinessDetails.URL_Linkin.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.URL_Linkin.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.URL_Linkin.CellAttributes %>>
<span id="el_BusinessDetails_URL_Linkin">
<input type="text" data-field="x_URL_Linkin" name="x_URL_Linkin" id="x_URL_Linkin" size="30" maxlength="255" placeholder="<%= BusinessDetails.URL_Linkin.PlaceHolder %>" value="<%= BusinessDetails.URL_Linkin.EditValue %>"<%= BusinessDetails.URL_Linkin.EditAttributes %>>
</span>
<%= BusinessDetails.URL_Linkin.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.Currency_PAYPAL.Visible Then ' Currency_PAYPAL %>
	<div id="r_Currency_PAYPAL" class="form-group">
		<label for="x_Currency_PAYPAL" class="col-sm-2 control-label">
<input type="checkbox" name="u_Currency_PAYPAL" id="u_Currency_PAYPAL" value="1"<% If BusinessDetails.Currency_PAYPAL.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.Currency_PAYPAL.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.Currency_PAYPAL.CellAttributes %>>
<span id="el_BusinessDetails_Currency_PAYPAL">
<input type="text" data-field="x_Currency_PAYPAL" name="x_Currency_PAYPAL" id="x_Currency_PAYPAL" size="30" maxlength="255" placeholder="<%= BusinessDetails.Currency_PAYPAL.PlaceHolder %>" value="<%= BusinessDetails.Currency_PAYPAL.EditValue %>"<%= BusinessDetails.Currency_PAYPAL.EditAttributes %>>
</span>
<%= BusinessDetails.Currency_PAYPAL.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.Currency_STRIPE.Visible Then ' Currency_STRIPE %>
	<div id="r_Currency_STRIPE" class="form-group">
		<label for="x_Currency_STRIPE" class="col-sm-2 control-label">
<input type="checkbox" name="u_Currency_STRIPE" id="u_Currency_STRIPE" value="1"<% If BusinessDetails.Currency_STRIPE.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.Currency_STRIPE.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.Currency_STRIPE.CellAttributes %>>
<span id="el_BusinessDetails_Currency_STRIPE">
<input type="text" data-field="x_Currency_STRIPE" name="x_Currency_STRIPE" id="x_Currency_STRIPE" size="30" maxlength="255" placeholder="<%= BusinessDetails.Currency_STRIPE.PlaceHolder %>" value="<%= BusinessDetails.Currency_STRIPE.EditValue %>"<%= BusinessDetails.Currency_STRIPE.EditAttributes %>>
</span>
<%= BusinessDetails.Currency_STRIPE.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.Currency_WOLRDPAY.Visible Then ' Currency_WOLRDPAY %>
	<div id="r_Currency_WOLRDPAY" class="form-group">
		<label for="x_Currency_WOLRDPAY" class="col-sm-2 control-label">
<input type="checkbox" name="u_Currency_WOLRDPAY" id="u_Currency_WOLRDPAY" value="1"<% If BusinessDetails.Currency_WOLRDPAY.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.Currency_WOLRDPAY.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.Currency_WOLRDPAY.CellAttributes %>>
<span id="el_BusinessDetails_Currency_WOLRDPAY">
<input type="text" data-field="x_Currency_WOLRDPAY" name="x_Currency_WOLRDPAY" id="x_Currency_WOLRDPAY" size="30" maxlength="255" placeholder="<%= BusinessDetails.Currency_WOLRDPAY.PlaceHolder %>" value="<%= BusinessDetails.Currency_WOLRDPAY.EditValue %>"<%= BusinessDetails.Currency_WOLRDPAY.EditAttributes %>>
</span>
<%= BusinessDetails.Currency_WOLRDPAY.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.Tip_percent.Visible Then ' Tip_percent %>
	<div id="r_Tip_percent" class="form-group">
		<label for="x_Tip_percent" class="col-sm-2 control-label">
<input type="checkbox" name="u_Tip_percent" id="u_Tip_percent" value="1"<% If BusinessDetails.Tip_percent.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.Tip_percent.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.Tip_percent.CellAttributes %>>
<span id="el_BusinessDetails_Tip_percent">
<input type="text" data-field="x_Tip_percent" name="x_Tip_percent" id="x_Tip_percent" size="30" placeholder="<%= BusinessDetails.Tip_percent.PlaceHolder %>" value="<%= BusinessDetails.Tip_percent.EditValue %>"<%= BusinessDetails.Tip_percent.EditAttributes %>>
</span>
<%= BusinessDetails.Tip_percent.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.Tax_Percent.Visible Then ' Tax_Percent %>
	<div id="r_Tax_Percent" class="form-group">
		<label for="x_Tax_Percent" class="col-sm-2 control-label">
<input type="checkbox" name="u_Tax_Percent" id="u_Tax_Percent" value="1"<% If BusinessDetails.Tax_Percent.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.Tax_Percent.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.Tax_Percent.CellAttributes %>>
<span id="el_BusinessDetails_Tax_Percent">
<input type="text" data-field="x_Tax_Percent" name="x_Tax_Percent" id="x_Tax_Percent" size="30" placeholder="<%= BusinessDetails.Tax_Percent.PlaceHolder %>" value="<%= BusinessDetails.Tax_Percent.EditValue %>"<%= BusinessDetails.Tax_Percent.EditAttributes %>>
</span>
<%= BusinessDetails.Tax_Percent.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.InRestaurantTaxChargeOnly.Visible Then ' InRestaurantTaxChargeOnly %>
	<div id="r_InRestaurantTaxChargeOnly" class="form-group">
		<label for="x_InRestaurantTaxChargeOnly" class="col-sm-2 control-label">
<input type="checkbox" name="u_InRestaurantTaxChargeOnly" id="u_InRestaurantTaxChargeOnly" value="1"<% If BusinessDetails.InRestaurantTaxChargeOnly.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.InRestaurantTaxChargeOnly.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.InRestaurantTaxChargeOnly.CellAttributes %>>
<span id="el_BusinessDetails_InRestaurantTaxChargeOnly">
<input type="text" data-field="x_InRestaurantTaxChargeOnly" name="x_InRestaurantTaxChargeOnly" id="x_InRestaurantTaxChargeOnly" size="30" placeholder="<%= BusinessDetails.InRestaurantTaxChargeOnly.PlaceHolder %>" value="<%= BusinessDetails.InRestaurantTaxChargeOnly.EditValue %>"<%= BusinessDetails.InRestaurantTaxChargeOnly.EditAttributes %>>
</span>
<%= BusinessDetails.InRestaurantTaxChargeOnly.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.InRestaurantTipChargeOnly.Visible Then ' InRestaurantTipChargeOnly %>
	<div id="r_InRestaurantTipChargeOnly" class="form-group">
		<label for="x_InRestaurantTipChargeOnly" class="col-sm-2 control-label">
<input type="checkbox" name="u_InRestaurantTipChargeOnly" id="u_InRestaurantTipChargeOnly" value="1"<% If BusinessDetails.InRestaurantTipChargeOnly.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.InRestaurantTipChargeOnly.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.InRestaurantTipChargeOnly.CellAttributes %>>
<span id="el_BusinessDetails_InRestaurantTipChargeOnly">
<input type="text" data-field="x_InRestaurantTipChargeOnly" name="x_InRestaurantTipChargeOnly" id="x_InRestaurantTipChargeOnly" size="30" placeholder="<%= BusinessDetails.InRestaurantTipChargeOnly.PlaceHolder %>" value="<%= BusinessDetails.InRestaurantTipChargeOnly.EditValue %>"<%= BusinessDetails.InRestaurantTipChargeOnly.EditAttributes %>>
</span>
<%= BusinessDetails.InRestaurantTipChargeOnly.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.isCheckCapcha.Visible Then ' isCheckCapcha %>
	<div id="r_isCheckCapcha" class="form-group">
		<label for="x_isCheckCapcha" class="col-sm-2 control-label">
<input type="checkbox" name="u_isCheckCapcha" id="u_isCheckCapcha" value="1"<% If BusinessDetails.isCheckCapcha.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.isCheckCapcha.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.isCheckCapcha.CellAttributes %>>
<span id="el_BusinessDetails_isCheckCapcha">
<input type="text" data-field="x_isCheckCapcha" name="x_isCheckCapcha" id="x_isCheckCapcha" size="30" maxlength="255" placeholder="<%= BusinessDetails.isCheckCapcha.PlaceHolder %>" value="<%= BusinessDetails.isCheckCapcha.EditValue %>"<%= BusinessDetails.isCheckCapcha.EditAttributes %>>
</span>
<%= BusinessDetails.isCheckCapcha.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.Close_StartDate.Visible Then ' Close_StartDate %>
	<div id="r_Close_StartDate" class="form-group">
		<label for="x_Close_StartDate" class="col-sm-2 control-label">
<input type="checkbox" name="u_Close_StartDate" id="u_Close_StartDate" value="1"<% If BusinessDetails.Close_StartDate.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.Close_StartDate.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.Close_StartDate.CellAttributes %>>
<span id="el_BusinessDetails_Close_StartDate">
<input type="text" data-field="x_Close_StartDate" name="x_Close_StartDate" id="x_Close_StartDate" size="30" maxlength="255" placeholder="<%= BusinessDetails.Close_StartDate.PlaceHolder %>" value="<%= BusinessDetails.Close_StartDate.EditValue %>"<%= BusinessDetails.Close_StartDate.EditAttributes %>>
</span>
<%= BusinessDetails.Close_StartDate.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.Close_EndDate.Visible Then ' Close_EndDate %>
	<div id="r_Close_EndDate" class="form-group">
		<label for="x_Close_EndDate" class="col-sm-2 control-label">
<input type="checkbox" name="u_Close_EndDate" id="u_Close_EndDate" value="1"<% If BusinessDetails.Close_EndDate.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.Close_EndDate.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.Close_EndDate.CellAttributes %>>
<span id="el_BusinessDetails_Close_EndDate">
<input type="text" data-field="x_Close_EndDate" name="x_Close_EndDate" id="x_Close_EndDate" size="30" maxlength="255" placeholder="<%= BusinessDetails.Close_EndDate.PlaceHolder %>" value="<%= BusinessDetails.Close_EndDate.EditValue %>"<%= BusinessDetails.Close_EndDate.EditAttributes %>>
</span>
<%= BusinessDetails.Close_EndDate.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.Stripe_Country.Visible Then ' Stripe_Country %>
	<div id="r_Stripe_Country" class="form-group">
		<label for="x_Stripe_Country" class="col-sm-2 control-label">
<input type="checkbox" name="u_Stripe_Country" id="u_Stripe_Country" value="1"<% If BusinessDetails.Stripe_Country.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.Stripe_Country.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.Stripe_Country.CellAttributes %>>
<span id="el_BusinessDetails_Stripe_Country">
<input type="text" data-field="x_Stripe_Country" name="x_Stripe_Country" id="x_Stripe_Country" size="30" maxlength="255" placeholder="<%= BusinessDetails.Stripe_Country.PlaceHolder %>" value="<%= BusinessDetails.Stripe_Country.EditValue %>"<%= BusinessDetails.Stripe_Country.EditAttributes %>>
</span>
<%= BusinessDetails.Stripe_Country.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.enable_StripePaymentButton.Visible Then ' enable_StripePaymentButton %>
	<div id="r_enable_StripePaymentButton" class="form-group">
		<label for="x_enable_StripePaymentButton" class="col-sm-2 control-label">
<input type="checkbox" name="u_enable_StripePaymentButton" id="u_enable_StripePaymentButton" value="1"<% If BusinessDetails.enable_StripePaymentButton.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.enable_StripePaymentButton.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.enable_StripePaymentButton.CellAttributes %>>
<span id="el_BusinessDetails_enable_StripePaymentButton">
<input type="text" data-field="x_enable_StripePaymentButton" name="x_enable_StripePaymentButton" id="x_enable_StripePaymentButton" size="30" maxlength="255" placeholder="<%= BusinessDetails.enable_StripePaymentButton.PlaceHolder %>" value="<%= BusinessDetails.enable_StripePaymentButton.EditValue %>"<%= BusinessDetails.enable_StripePaymentButton.EditAttributes %>>
</span>
<%= BusinessDetails.enable_StripePaymentButton.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.enable_CashPayment.Visible Then ' enable_CashPayment %>
	<div id="r_enable_CashPayment" class="form-group">
		<label for="x_enable_CashPayment" class="col-sm-2 control-label">
<input type="checkbox" name="u_enable_CashPayment" id="u_enable_CashPayment" value="1"<% If BusinessDetails.enable_CashPayment.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.enable_CashPayment.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.enable_CashPayment.CellAttributes %>>
<span id="el_BusinessDetails_enable_CashPayment">
<input type="text" data-field="x_enable_CashPayment" name="x_enable_CashPayment" id="x_enable_CashPayment" size="30" maxlength="255" placeholder="<%= BusinessDetails.enable_CashPayment.PlaceHolder %>" value="<%= BusinessDetails.enable_CashPayment.EditValue %>"<%= BusinessDetails.enable_CashPayment.EditAttributes %>>
</span>
<%= BusinessDetails.enable_CashPayment.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.DeliveryMile.Visible Then ' DeliveryMile %>
	<div id="r_DeliveryMile" class="form-group">
		<label for="x_DeliveryMile" class="col-sm-2 control-label">
<input type="checkbox" name="u_DeliveryMile" id="u_DeliveryMile" value="1"<% If BusinessDetails.DeliveryMile.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.DeliveryMile.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.DeliveryMile.CellAttributes %>>
<span id="el_BusinessDetails_DeliveryMile">
<input type="text" data-field="x_DeliveryMile" name="x_DeliveryMile" id="x_DeliveryMile" size="30" placeholder="<%= BusinessDetails.DeliveryMile.PlaceHolder %>" value="<%= BusinessDetails.DeliveryMile.EditValue %>"<%= BusinessDetails.DeliveryMile.EditAttributes %>>
</span>
<%= BusinessDetails.DeliveryMile.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.Mon_Delivery.Visible Then ' Mon_Delivery %>
	<div id="r_Mon_Delivery" class="form-group">
		<label for="x_Mon_Delivery" class="col-sm-2 control-label">
<input type="checkbox" name="u_Mon_Delivery" id="u_Mon_Delivery" value="1"<% If BusinessDetails.Mon_Delivery.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.Mon_Delivery.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.Mon_Delivery.CellAttributes %>>
<span id="el_BusinessDetails_Mon_Delivery">
<input type="text" data-field="x_Mon_Delivery" name="x_Mon_Delivery" id="x_Mon_Delivery" size="30" placeholder="<%= BusinessDetails.Mon_Delivery.PlaceHolder %>" value="<%= BusinessDetails.Mon_Delivery.EditValue %>"<%= BusinessDetails.Mon_Delivery.EditAttributes %>>
</span>
<%= BusinessDetails.Mon_Delivery.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.Mon_Collection.Visible Then ' Mon_Collection %>
	<div id="r_Mon_Collection" class="form-group">
		<label for="x_Mon_Collection" class="col-sm-2 control-label">
<input type="checkbox" name="u_Mon_Collection" id="u_Mon_Collection" value="1"<% If BusinessDetails.Mon_Collection.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.Mon_Collection.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.Mon_Collection.CellAttributes %>>
<span id="el_BusinessDetails_Mon_Collection">
<input type="text" data-field="x_Mon_Collection" name="x_Mon_Collection" id="x_Mon_Collection" size="30" placeholder="<%= BusinessDetails.Mon_Collection.PlaceHolder %>" value="<%= BusinessDetails.Mon_Collection.EditValue %>"<%= BusinessDetails.Mon_Collection.EditAttributes %>>
</span>
<%= BusinessDetails.Mon_Collection.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.Tue_Delivery.Visible Then ' Tue_Delivery %>
	<div id="r_Tue_Delivery" class="form-group">
		<label for="x_Tue_Delivery" class="col-sm-2 control-label">
<input type="checkbox" name="u_Tue_Delivery" id="u_Tue_Delivery" value="1"<% If BusinessDetails.Tue_Delivery.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.Tue_Delivery.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.Tue_Delivery.CellAttributes %>>
<span id="el_BusinessDetails_Tue_Delivery">
<input type="text" data-field="x_Tue_Delivery" name="x_Tue_Delivery" id="x_Tue_Delivery" size="30" placeholder="<%= BusinessDetails.Tue_Delivery.PlaceHolder %>" value="<%= BusinessDetails.Tue_Delivery.EditValue %>"<%= BusinessDetails.Tue_Delivery.EditAttributes %>>
</span>
<%= BusinessDetails.Tue_Delivery.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.Tue_Collection.Visible Then ' Tue_Collection %>
	<div id="r_Tue_Collection" class="form-group">
		<label for="x_Tue_Collection" class="col-sm-2 control-label">
<input type="checkbox" name="u_Tue_Collection" id="u_Tue_Collection" value="1"<% If BusinessDetails.Tue_Collection.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.Tue_Collection.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.Tue_Collection.CellAttributes %>>
<span id="el_BusinessDetails_Tue_Collection">
<input type="text" data-field="x_Tue_Collection" name="x_Tue_Collection" id="x_Tue_Collection" size="30" placeholder="<%= BusinessDetails.Tue_Collection.PlaceHolder %>" value="<%= BusinessDetails.Tue_Collection.EditValue %>"<%= BusinessDetails.Tue_Collection.EditAttributes %>>
</span>
<%= BusinessDetails.Tue_Collection.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.Wed_Delivery.Visible Then ' Wed_Delivery %>
	<div id="r_Wed_Delivery" class="form-group">
		<label for="x_Wed_Delivery" class="col-sm-2 control-label">
<input type="checkbox" name="u_Wed_Delivery" id="u_Wed_Delivery" value="1"<% If BusinessDetails.Wed_Delivery.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.Wed_Delivery.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.Wed_Delivery.CellAttributes %>>
<span id="el_BusinessDetails_Wed_Delivery">
<input type="text" data-field="x_Wed_Delivery" name="x_Wed_Delivery" id="x_Wed_Delivery" size="30" placeholder="<%= BusinessDetails.Wed_Delivery.PlaceHolder %>" value="<%= BusinessDetails.Wed_Delivery.EditValue %>"<%= BusinessDetails.Wed_Delivery.EditAttributes %>>
</span>
<%= BusinessDetails.Wed_Delivery.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.Wed_Collection.Visible Then ' Wed_Collection %>
	<div id="r_Wed_Collection" class="form-group">
		<label for="x_Wed_Collection" class="col-sm-2 control-label">
<input type="checkbox" name="u_Wed_Collection" id="u_Wed_Collection" value="1"<% If BusinessDetails.Wed_Collection.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.Wed_Collection.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.Wed_Collection.CellAttributes %>>
<span id="el_BusinessDetails_Wed_Collection">
<input type="text" data-field="x_Wed_Collection" name="x_Wed_Collection" id="x_Wed_Collection" size="30" placeholder="<%= BusinessDetails.Wed_Collection.PlaceHolder %>" value="<%= BusinessDetails.Wed_Collection.EditValue %>"<%= BusinessDetails.Wed_Collection.EditAttributes %>>
</span>
<%= BusinessDetails.Wed_Collection.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.Thu_Delivery.Visible Then ' Thu_Delivery %>
	<div id="r_Thu_Delivery" class="form-group">
		<label for="x_Thu_Delivery" class="col-sm-2 control-label">
<input type="checkbox" name="u_Thu_Delivery" id="u_Thu_Delivery" value="1"<% If BusinessDetails.Thu_Delivery.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.Thu_Delivery.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.Thu_Delivery.CellAttributes %>>
<span id="el_BusinessDetails_Thu_Delivery">
<input type="text" data-field="x_Thu_Delivery" name="x_Thu_Delivery" id="x_Thu_Delivery" size="30" placeholder="<%= BusinessDetails.Thu_Delivery.PlaceHolder %>" value="<%= BusinessDetails.Thu_Delivery.EditValue %>"<%= BusinessDetails.Thu_Delivery.EditAttributes %>>
</span>
<%= BusinessDetails.Thu_Delivery.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.Thu_Collection.Visible Then ' Thu_Collection %>
	<div id="r_Thu_Collection" class="form-group">
		<label for="x_Thu_Collection" class="col-sm-2 control-label">
<input type="checkbox" name="u_Thu_Collection" id="u_Thu_Collection" value="1"<% If BusinessDetails.Thu_Collection.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.Thu_Collection.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.Thu_Collection.CellAttributes %>>
<span id="el_BusinessDetails_Thu_Collection">
<input type="text" data-field="x_Thu_Collection" name="x_Thu_Collection" id="x_Thu_Collection" size="30" placeholder="<%= BusinessDetails.Thu_Collection.PlaceHolder %>" value="<%= BusinessDetails.Thu_Collection.EditValue %>"<%= BusinessDetails.Thu_Collection.EditAttributes %>>
</span>
<%= BusinessDetails.Thu_Collection.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.Fri_Delivery.Visible Then ' Fri_Delivery %>
	<div id="r_Fri_Delivery" class="form-group">
		<label for="x_Fri_Delivery" class="col-sm-2 control-label">
<input type="checkbox" name="u_Fri_Delivery" id="u_Fri_Delivery" value="1"<% If BusinessDetails.Fri_Delivery.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.Fri_Delivery.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.Fri_Delivery.CellAttributes %>>
<span id="el_BusinessDetails_Fri_Delivery">
<input type="text" data-field="x_Fri_Delivery" name="x_Fri_Delivery" id="x_Fri_Delivery" size="30" placeholder="<%= BusinessDetails.Fri_Delivery.PlaceHolder %>" value="<%= BusinessDetails.Fri_Delivery.EditValue %>"<%= BusinessDetails.Fri_Delivery.EditAttributes %>>
</span>
<%= BusinessDetails.Fri_Delivery.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.Fri_Collection.Visible Then ' Fri_Collection %>
	<div id="r_Fri_Collection" class="form-group">
		<label for="x_Fri_Collection" class="col-sm-2 control-label">
<input type="checkbox" name="u_Fri_Collection" id="u_Fri_Collection" value="1"<% If BusinessDetails.Fri_Collection.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.Fri_Collection.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.Fri_Collection.CellAttributes %>>
<span id="el_BusinessDetails_Fri_Collection">
<input type="text" data-field="x_Fri_Collection" name="x_Fri_Collection" id="x_Fri_Collection" size="30" placeholder="<%= BusinessDetails.Fri_Collection.PlaceHolder %>" value="<%= BusinessDetails.Fri_Collection.EditValue %>"<%= BusinessDetails.Fri_Collection.EditAttributes %>>
</span>
<%= BusinessDetails.Fri_Collection.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.Sat_Delivery.Visible Then ' Sat_Delivery %>
	<div id="r_Sat_Delivery" class="form-group">
		<label for="x_Sat_Delivery" class="col-sm-2 control-label">
<input type="checkbox" name="u_Sat_Delivery" id="u_Sat_Delivery" value="1"<% If BusinessDetails.Sat_Delivery.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.Sat_Delivery.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.Sat_Delivery.CellAttributes %>>
<span id="el_BusinessDetails_Sat_Delivery">
<input type="text" data-field="x_Sat_Delivery" name="x_Sat_Delivery" id="x_Sat_Delivery" size="30" placeholder="<%= BusinessDetails.Sat_Delivery.PlaceHolder %>" value="<%= BusinessDetails.Sat_Delivery.EditValue %>"<%= BusinessDetails.Sat_Delivery.EditAttributes %>>
</span>
<%= BusinessDetails.Sat_Delivery.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.Sat_Collection.Visible Then ' Sat_Collection %>
	<div id="r_Sat_Collection" class="form-group">
		<label for="x_Sat_Collection" class="col-sm-2 control-label">
<input type="checkbox" name="u_Sat_Collection" id="u_Sat_Collection" value="1"<% If BusinessDetails.Sat_Collection.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.Sat_Collection.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.Sat_Collection.CellAttributes %>>
<span id="el_BusinessDetails_Sat_Collection">
<input type="text" data-field="x_Sat_Collection" name="x_Sat_Collection" id="x_Sat_Collection" size="30" placeholder="<%= BusinessDetails.Sat_Collection.PlaceHolder %>" value="<%= BusinessDetails.Sat_Collection.EditValue %>"<%= BusinessDetails.Sat_Collection.EditAttributes %>>
</span>
<%= BusinessDetails.Sat_Collection.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.Sun_Delivery.Visible Then ' Sun_Delivery %>
	<div id="r_Sun_Delivery" class="form-group">
		<label for="x_Sun_Delivery" class="col-sm-2 control-label">
<input type="checkbox" name="u_Sun_Delivery" id="u_Sun_Delivery" value="1"<% If BusinessDetails.Sun_Delivery.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.Sun_Delivery.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.Sun_Delivery.CellAttributes %>>
<span id="el_BusinessDetails_Sun_Delivery">
<input type="text" data-field="x_Sun_Delivery" name="x_Sun_Delivery" id="x_Sun_Delivery" size="30" placeholder="<%= BusinessDetails.Sun_Delivery.PlaceHolder %>" value="<%= BusinessDetails.Sun_Delivery.EditValue %>"<%= BusinessDetails.Sun_Delivery.EditAttributes %>>
</span>
<%= BusinessDetails.Sun_Delivery.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.Sun_Collection.Visible Then ' Sun_Collection %>
	<div id="r_Sun_Collection" class="form-group">
		<label for="x_Sun_Collection" class="col-sm-2 control-label">
<input type="checkbox" name="u_Sun_Collection" id="u_Sun_Collection" value="1"<% If BusinessDetails.Sun_Collection.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.Sun_Collection.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.Sun_Collection.CellAttributes %>>
<span id="el_BusinessDetails_Sun_Collection">
<input type="text" data-field="x_Sun_Collection" name="x_Sun_Collection" id="x_Sun_Collection" size="30" placeholder="<%= BusinessDetails.Sun_Collection.PlaceHolder %>" value="<%= BusinessDetails.Sun_Collection.EditValue %>"<%= BusinessDetails.Sun_Collection.EditAttributes %>>
</span>
<%= BusinessDetails.Sun_Collection.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.EnableUrlRewrite.Visible Then ' EnableUrlRewrite %>
	<div id="r_EnableUrlRewrite" class="form-group">
		<label for="x_EnableUrlRewrite" class="col-sm-2 control-label">
<input type="checkbox" name="u_EnableUrlRewrite" id="u_EnableUrlRewrite" value="1"<% If BusinessDetails.EnableUrlRewrite.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.EnableUrlRewrite.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.EnableUrlRewrite.CellAttributes %>>
<span id="el_BusinessDetails_EnableUrlRewrite">
<input type="text" data-field="x_EnableUrlRewrite" name="x_EnableUrlRewrite" id="x_EnableUrlRewrite" size="30" maxlength="255" placeholder="<%= BusinessDetails.EnableUrlRewrite.PlaceHolder %>" value="<%= BusinessDetails.EnableUrlRewrite.EditValue %>"<%= BusinessDetails.EnableUrlRewrite.EditAttributes %>>
</span>
<%= BusinessDetails.EnableUrlRewrite.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.DeliveryCostUpTo.Visible Then ' DeliveryCostUpTo %>
	<div id="r_DeliveryCostUpTo" class="form-group">
		<label for="x_DeliveryCostUpTo" class="col-sm-2 control-label">
<input type="checkbox" name="u_DeliveryCostUpTo" id="u_DeliveryCostUpTo" value="1"<% If BusinessDetails.DeliveryCostUpTo.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.DeliveryCostUpTo.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.DeliveryCostUpTo.CellAttributes %>>
<span id="el_BusinessDetails_DeliveryCostUpTo">
<input type="text" data-field="x_DeliveryCostUpTo" name="x_DeliveryCostUpTo" id="x_DeliveryCostUpTo" size="30" placeholder="<%= BusinessDetails.DeliveryCostUpTo.PlaceHolder %>" value="<%= BusinessDetails.DeliveryCostUpTo.EditValue %>"<%= BusinessDetails.DeliveryCostUpTo.EditAttributes %>>
</span>
<%= BusinessDetails.DeliveryCostUpTo.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.DeliveryUptoMile.Visible Then ' DeliveryUptoMile %>
	<div id="r_DeliveryUptoMile" class="form-group">
		<label for="x_DeliveryUptoMile" class="col-sm-2 control-label">
<input type="checkbox" name="u_DeliveryUptoMile" id="u_DeliveryUptoMile" value="1"<% If BusinessDetails.DeliveryUptoMile.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.DeliveryUptoMile.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.DeliveryUptoMile.CellAttributes %>>
<span id="el_BusinessDetails_DeliveryUptoMile">
<input type="text" data-field="x_DeliveryUptoMile" name="x_DeliveryUptoMile" id="x_DeliveryUptoMile" size="30" placeholder="<%= BusinessDetails.DeliveryUptoMile.PlaceHolder %>" value="<%= BusinessDetails.DeliveryUptoMile.EditValue %>"<%= BusinessDetails.DeliveryUptoMile.EditAttributes %>>
</span>
<%= BusinessDetails.DeliveryUptoMile.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.Show_Ordernumner_printer.Visible Then ' Show_Ordernumner_printer %>
	<div id="r_Show_Ordernumner_printer" class="form-group">
		<label for="x_Show_Ordernumner_printer" class="col-sm-2 control-label">
<input type="checkbox" name="u_Show_Ordernumner_printer" id="u_Show_Ordernumner_printer" value="1"<% If BusinessDetails.Show_Ordernumner_printer.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.Show_Ordernumner_printer.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.Show_Ordernumner_printer.CellAttributes %>>
<span id="el_BusinessDetails_Show_Ordernumner_printer">
<input type="text" data-field="x_Show_Ordernumner_printer" name="x_Show_Ordernumner_printer" id="x_Show_Ordernumner_printer" size="30" maxlength="255" placeholder="<%= BusinessDetails.Show_Ordernumner_printer.PlaceHolder %>" value="<%= BusinessDetails.Show_Ordernumner_printer.EditValue %>"<%= BusinessDetails.Show_Ordernumner_printer.EditAttributes %>>
</span>
<%= BusinessDetails.Show_Ordernumner_printer.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.Show_Ordernumner_Receipt.Visible Then ' Show_Ordernumner_Receipt %>
	<div id="r_Show_Ordernumner_Receipt" class="form-group">
		<label for="x_Show_Ordernumner_Receipt" class="col-sm-2 control-label">
<input type="checkbox" name="u_Show_Ordernumner_Receipt" id="u_Show_Ordernumner_Receipt" value="1"<% If BusinessDetails.Show_Ordernumner_Receipt.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.Show_Ordernumner_Receipt.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.Show_Ordernumner_Receipt.CellAttributes %>>
<span id="el_BusinessDetails_Show_Ordernumner_Receipt">
<input type="text" data-field="x_Show_Ordernumner_Receipt" name="x_Show_Ordernumner_Receipt" id="x_Show_Ordernumner_Receipt" size="30" maxlength="255" placeholder="<%= BusinessDetails.Show_Ordernumner_Receipt.PlaceHolder %>" value="<%= BusinessDetails.Show_Ordernumner_Receipt.EditValue %>"<%= BusinessDetails.Show_Ordernumner_Receipt.EditAttributes %>>
</span>
<%= BusinessDetails.Show_Ordernumner_Receipt.CustomMsg %></div></div>
	</div>
<% End If %>
<% If BusinessDetails.Show_Ordernumner_Dashboard.Visible Then ' Show_Ordernumner_Dashboard %>
	<div id="r_Show_Ordernumner_Dashboard" class="form-group">
		<label for="x_Show_Ordernumner_Dashboard" class="col-sm-2 control-label">
<input type="checkbox" name="u_Show_Ordernumner_Dashboard" id="u_Show_Ordernumner_Dashboard" value="1"<% If BusinessDetails.Show_Ordernumner_Dashboard.MultiUpdate = "1" Then Response.Write " checked=""checked""" %>>
 <%= BusinessDetails.Show_Ordernumner_Dashboard.FldCaption %></label>
		<div class="col-sm-10"><div<%= BusinessDetails.Show_Ordernumner_Dashboard.CellAttributes %>>
<span id="el_BusinessDetails_Show_Ordernumner_Dashboard">
<input type="text" data-field="x_Show_Ordernumner_Dashboard" name="x_Show_Ordernumner_Dashboard" id="x_Show_Ordernumner_Dashboard" size="30" maxlength="255" placeholder="<%= BusinessDetails.Show_Ordernumner_Dashboard.PlaceHolder %>" value="<%= BusinessDetails.Show_Ordernumner_Dashboard.EditValue %>"<%= BusinessDetails.Show_Ordernumner_Dashboard.EditAttributes %>>
</span>
<%= BusinessDetails.Show_Ordernumner_Dashboard.CustomMsg %></div></div>
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
fBusinessDetailsupdate.Init();
</script>
<%
BusinessDetails_update.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set BusinessDetails_update = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cBusinessDetails_update

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
		TableName = "BusinessDetails"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "BusinessDetails_update"
	End Property

	' Page Name
	Public Property Get PageName()
		PageName = ew_CurrentPage()
	End Property

	' Page Url
	Public Property Get PageUrl()
		PageUrl = ew_CurrentPage() & "?"
		If BusinessDetails.UseTokenInUrl Then PageUrl = PageUrl & "t=" & BusinessDetails.TableVar & "&" ' add page token
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

		' Initialize urls
		' Initialize form object

		Set ObjForm = Nothing

		' Intialize page id (for backward compatibility)
		EW_PAGE_ID = "update"

		' Initialize table name (for backward compatibility)
		EW_TABLE_NAME = "BusinessDetails"

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

		BusinessDetails.CurrentAction = ew_IIf(Request.QueryString("a").Count > 0, Request.QueryString("a") & "", ObjForm.GetValue("a_list") & "") ' Set up current action

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
		RecKeys = BusinessDetails.GetRecordKeys() ' Load record keys
		If ObjForm.GetValue("a_update")&"" <> "" Then

			' Get action
			BusinessDetails.CurrentAction = ObjForm.GetValue("a_update")
			Call LoadFormValues() ' Get form values

			' Validate form
			If Not ValidateForm() Then
				BusinessDetails.CurrentAction = "I" ' Form error, reset action
				FailureMessage = gsFormError
			End If
		Else
			Call LoadMultiUpdateValues() ' Load initial values to form
		End If
		If Not IsArray(RecKeys) Then
			Call Page_Terminate("BusinessDetailslist.asp") ' No records selected, return to list
		End If
		Select Case BusinessDetails.CurrentAction
			Case "U" ' Update
				If UpdateRows() Then ' Update Records based on key
					If SuccessMessage = "" Then SuccessMessage = Language.Phrase("UpdateSuccess") ' Set update success message
					Call Page_Terminate(BusinessDetails.ReturnUrl) ' Return to caller
				Else
					Call RestoreFormValues() ' Restore form values
				End If
		End Select

		' Render row
		BusinessDetails.RowType = EW_ROWTYPE_EDIT ' Render edit

		' Render row
		Call BusinessDetails.ResetAttrs()
		Call RenderRow()
	End Sub

	' -----------------------------------------------------------------
	' Load initial values to form if field values are identical in all selected records
	'
	Sub LoadMultiUpdateValues()
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		Dim Rs, i, OldValue, NewValue
		BusinessDetails.CurrentFilter = BusinessDetails.GetKeyFilter()

		' Load recordset
		Set Rs = LoadRecordset()
		i = 1
		Do While Not Rs.Eof
			If i = 1 Then
				BusinessDetails.Name.DbValue = ew_Conv(Rs("Name"), Rs("Name").Type)
				BusinessDetails.Address.DbValue = ew_Conv(Rs("Address"), Rs("Address").Type)
				BusinessDetails.PostalCode.DbValue = ew_Conv(Rs("PostalCode"), Rs("PostalCode").Type)
				BusinessDetails.FoodType.DbValue = ew_Conv(Rs("FoodType"), Rs("FoodType").Type)
				BusinessDetails.DeliveryMinAmount.DbValue = ew_Conv(Rs("DeliveryMinAmount"), Rs("DeliveryMinAmount").Type)
				BusinessDetails.DeliveryMaxDistance.DbValue = ew_Conv(Rs("DeliveryMaxDistance"), Rs("DeliveryMaxDistance").Type)
				BusinessDetails.DeliveryFreeDistance.DbValue = ew_Conv(Rs("DeliveryFreeDistance"), Rs("DeliveryFreeDistance").Type)
				BusinessDetails.AverageDeliveryTime.DbValue = ew_Conv(Rs("AverageDeliveryTime"), Rs("AverageDeliveryTime").Type)
				BusinessDetails.AverageCollectionTime.DbValue = ew_Conv(Rs("AverageCollectionTime"), Rs("AverageCollectionTime").Type)
				BusinessDetails.DeliveryFee.DbValue = ew_Conv(Rs("DeliveryFee"), Rs("DeliveryFee").Type)
				BusinessDetails.ImgUrl.DbValue = ew_Conv(Rs("ImgUrl"), Rs("ImgUrl").Type)
				BusinessDetails.Telephone.DbValue = ew_Conv(Rs("Telephone"), Rs("Telephone").Type)
				BusinessDetails.zEmail.DbValue = ew_Conv(Rs("Email"), Rs("Email").Type)
				BusinessDetails.pswd.DbValue = ew_Conv(Rs("pswd"), Rs("pswd").Type)
				BusinessDetails.businessclosed.DbValue = ew_Conv(Rs("businessclosed"), Rs("businessclosed").Type)
				BusinessDetails.announcement.DbValue = ew_Conv(Rs("announcement"), Rs("announcement").Type)
				BusinessDetails.css.DbValue = ew_Conv(Rs("css"), Rs("css").Type)
				BusinessDetails.SMTP_AUTENTICATE.DbValue = ew_Conv(Rs("SMTP_AUTENTICATE"), Rs("SMTP_AUTENTICATE").Type)
				BusinessDetails.MAIL_FROM.DbValue = ew_Conv(Rs("MAIL_FROM"), Rs("MAIL_FROM").Type)
				BusinessDetails.PAYPAL_URL.DbValue = ew_Conv(Rs("PAYPAL_URL"), Rs("PAYPAL_URL").Type)
				BusinessDetails.PAYPAL_PDT.DbValue = ew_Conv(Rs("PAYPAL_PDT"), Rs("PAYPAL_PDT").Type)
				BusinessDetails.SMTP_PASSWORD.DbValue = ew_Conv(Rs("SMTP_PASSWORD"), Rs("SMTP_PASSWORD").Type)
				BusinessDetails.GMAP_API_KEY.DbValue = ew_Conv(Rs("GMAP_API_KEY"), Rs("GMAP_API_KEY").Type)
				BusinessDetails.SMTP_USERNAME.DbValue = ew_Conv(Rs("SMTP_USERNAME"), Rs("SMTP_USERNAME").Type)
				BusinessDetails.SMTP_USESSL.DbValue = ew_Conv(Rs("SMTP_USESSL"), Rs("SMTP_USESSL").Type)
				BusinessDetails.MAIL_SUBJECT.DbValue = ew_Conv(Rs("MAIL_SUBJECT"), Rs("MAIL_SUBJECT").Type)
				BusinessDetails.CURRENCYSYMBOL.DbValue = ew_Conv(Rs("CURRENCYSYMBOL"), Rs("CURRENCYSYMBOL").Type)
				BusinessDetails.SMTP_SERVER.DbValue = ew_Conv(Rs("SMTP_SERVER"), Rs("SMTP_SERVER").Type)
				BusinessDetails.CREDITCARDSURCHARGE.DbValue = ew_Conv(Rs("CREDITCARDSURCHARGE"), Rs("CREDITCARDSURCHARGE").Type)
				BusinessDetails.SMTP_PORT.DbValue = ew_Conv(Rs("SMTP_PORT"), Rs("SMTP_PORT").Type)
				BusinessDetails.STICK_MENU.DbValue = ew_Conv(Rs("STICK_MENU"), Rs("STICK_MENU").Type)
				BusinessDetails.MAIL_CUSTOMER_SUBJECT.DbValue = ew_Conv(Rs("MAIL_CUSTOMER_SUBJECT"), Rs("MAIL_CUSTOMER_SUBJECT").Type)
				BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.DbValue = ew_Conv(Rs("CONFIRMATION_EMAIL_ADDRESS"), Rs("CONFIRMATION_EMAIL_ADDRESS").Type)
				BusinessDetails.SEND_ORDERS_TO_PRINTER.DbValue = ew_Conv(Rs("SEND_ORDERS_TO_PRINTER"), Rs("SEND_ORDERS_TO_PRINTER").Type)
				BusinessDetails.timezone.DbValue = ew_Conv(Rs("timezone"), Rs("timezone").Type)
				BusinessDetails.PAYPAL_ADDR.DbValue = ew_Conv(Rs("PAYPAL_ADDR"), Rs("PAYPAL_ADDR").Type)
				BusinessDetails.nochex.DbValue = ew_Conv(Rs("nochex"), Rs("nochex").Type)
				BusinessDetails.nochexmerchantid.DbValue = ew_Conv(Rs("nochexmerchantid"), Rs("nochexmerchantid").Type)
				BusinessDetails.paypal.DbValue = ew_Conv(Rs("paypal"), Rs("paypal").Type)
				BusinessDetails.IBT_API_KEY.DbValue = ew_Conv(Rs("IBT_API_KEY"), Rs("IBT_API_KEY").Type)
				BusinessDetails.IBP_API_PASSWORD.DbValue = ew_Conv(Rs("IBP_API_PASSWORD"), Rs("IBP_API_PASSWORD").Type)
				BusinessDetails.disable_delivery.DbValue = ew_Conv(Rs("disable_delivery"), Rs("disable_delivery").Type)
				BusinessDetails.disable_collection.DbValue = ew_Conv(Rs("disable_collection"), Rs("disable_collection").Type)
				BusinessDetails.worldpay.DbValue = ew_Conv(Rs("worldpay"), Rs("worldpay").Type)
				BusinessDetails.worldpaymerchantid.DbValue = ew_Conv(Rs("worldpaymerchantid"), Rs("worldpaymerchantid").Type)
				BusinessDetails.backtohometext.DbValue = ew_Conv(Rs("backtohometext"), Rs("backtohometext").Type)
				BusinessDetails.closedtext.DbValue = ew_Conv(Rs("closedtext"), Rs("closedtext").Type)
				BusinessDetails.DeliveryChargeOverrideByOrderValue.DbValue = ew_Conv(Rs("DeliveryChargeOverrideByOrderValue"), Rs("DeliveryChargeOverrideByOrderValue").Type)
				BusinessDetails.individualpostcodes.DbValue = ew_Conv(Rs("individualpostcodes"), Rs("individualpostcodes").Type)
				BusinessDetails.individualpostcodeschecking.DbValue = ew_Conv(Rs("individualpostcodeschecking"), Rs("individualpostcodeschecking").Type)
				BusinessDetails.longitude.DbValue = ew_Conv(Rs("longitude"), Rs("longitude").Type)
				BusinessDetails.latitude.DbValue = ew_Conv(Rs("latitude"), Rs("latitude").Type)
				BusinessDetails.googleecommercetracking.DbValue = ew_Conv(Rs("googleecommercetracking"), Rs("googleecommercetracking").Type)
				BusinessDetails.googleecommercetrackingcode.DbValue = ew_Conv(Rs("googleecommercetrackingcode"), Rs("googleecommercetrackingcode").Type)
				BusinessDetails.bringg.DbValue = ew_Conv(Rs("bringg"), Rs("bringg").Type)
				BusinessDetails.bringgurl.DbValue = ew_Conv(Rs("bringgurl"), Rs("bringgurl").Type)
				BusinessDetails.bringgcompanyid.DbValue = ew_Conv(Rs("bringgcompanyid"), Rs("bringgcompanyid").Type)
				BusinessDetails.orderonlywhenopen.DbValue = ew_Conv(Rs("orderonlywhenopen"), Rs("orderonlywhenopen").Type)
				BusinessDetails.disablelaterdelivery.DbValue = ew_Conv(Rs("disablelaterdelivery"), Rs("disablelaterdelivery").Type)
				BusinessDetails.menupagetext.DbValue = ew_Conv(Rs("menupagetext"), Rs("menupagetext").Type)
				BusinessDetails.ordertodayonly.DbValue = ew_Conv(Rs("ordertodayonly"), Rs("ordertodayonly").Type)
				BusinessDetails.mileskm.DbValue = ew_Conv(Rs("mileskm"), Rs("mileskm").Type)
				BusinessDetails.worldpaylive.DbValue = ew_Conv(Rs("worldpaylive"), Rs("worldpaylive").Type)
				BusinessDetails.worldpayinstallationid.DbValue = ew_Conv(Rs("worldpayinstallationid"), Rs("worldpayinstallationid").Type)
				BusinessDetails.DistanceCalMethod.DbValue = ew_Conv(Rs("DistanceCalMethod"), Rs("DistanceCalMethod").Type)
				BusinessDetails.PrinterIDList.DbValue = ew_Conv(Rs("PrinterIDList"), Rs("PrinterIDList").Type)
				BusinessDetails.EpsonJSPrinterURL.DbValue = ew_Conv(Rs("EpsonJSPrinterURL"), Rs("EpsonJSPrinterURL").Type)
				BusinessDetails.SMSEnable.DbValue = ew_Conv(Rs("SMSEnable"), Rs("SMSEnable").Type)
				BusinessDetails.SMSOnDelivery.DbValue = ew_Conv(Rs("SMSOnDelivery"), Rs("SMSOnDelivery").Type)
				BusinessDetails.SMSSupplierDomain.DbValue = ew_Conv(Rs("SMSSupplierDomain"), Rs("SMSSupplierDomain").Type)
				BusinessDetails.SMSOnOrder.DbValue = ew_Conv(Rs("SMSOnOrder"), Rs("SMSOnOrder").Type)
				BusinessDetails.SMSOnOrderAfterMin.DbValue = ew_Conv(Rs("SMSOnOrderAfterMin"), Rs("SMSOnOrderAfterMin").Type)
				BusinessDetails.SMSOnOrderContent.DbValue = ew_Conv(Rs("SMSOnOrderContent"), Rs("SMSOnOrderContent").Type)
				BusinessDetails.DefaultSMSCountryCode.DbValue = ew_Conv(Rs("DefaultSMSCountryCode"), Rs("DefaultSMSCountryCode").Type)
				BusinessDetails.MinimumAmountForCardPayment.DbValue = ew_Conv(Rs("MinimumAmountForCardPayment"), Rs("MinimumAmountForCardPayment").Type)
				BusinessDetails.FavIconUrl.DbValue = ew_Conv(Rs("FavIconUrl"), Rs("FavIconUrl").Type)
				BusinessDetails.AddToHomeScreenURL.DbValue = ew_Conv(Rs("AddToHomeScreenURL"), Rs("AddToHomeScreenURL").Type)
				BusinessDetails.SMSOnAcknowledgement.DbValue = ew_Conv(Rs("SMSOnAcknowledgement"), Rs("SMSOnAcknowledgement").Type)
				BusinessDetails.LocalPrinterURL.DbValue = ew_Conv(Rs("LocalPrinterURL"), Rs("LocalPrinterURL").Type)
				BusinessDetails.ShowRestaurantDetailOnReceipt.DbValue = ew_Conv(Rs("ShowRestaurantDetailOnReceipt"), Rs("ShowRestaurantDetailOnReceipt").Type)
				BusinessDetails.PrinterFontSizeRatio.DbValue = ew_Conv(Rs("PrinterFontSizeRatio"), Rs("PrinterFontSizeRatio").Type)
				BusinessDetails.ServiceChargePercentage.DbValue = ew_Conv(Rs("ServiceChargePercentage"), Rs("ServiceChargePercentage").Type)
				BusinessDetails.InRestaurantServiceChargeOnly.DbValue = ew_Conv(Rs("InRestaurantServiceChargeOnly"), Rs("InRestaurantServiceChargeOnly").Type)
				BusinessDetails.IsDualReceiptPrinting.DbValue = ew_Conv(Rs("IsDualReceiptPrinting"), Rs("IsDualReceiptPrinting").Type)
				BusinessDetails.PrintingFontSize.DbValue = ew_Conv(Rs("PrintingFontSize"), Rs("PrintingFontSize").Type)
				BusinessDetails.InRestaurantEpsonPrinterIDList.DbValue = ew_Conv(Rs("InRestaurantEpsonPrinterIDList"), Rs("InRestaurantEpsonPrinterIDList").Type)
				BusinessDetails.BlockIPEmailList.DbValue = ew_Conv(Rs("BlockIPEmailList"), Rs("BlockIPEmailList").Type)
				BusinessDetails.inmenuannouncement.DbValue = ew_Conv(Rs("inmenuannouncement"), Rs("inmenuannouncement").Type)
				BusinessDetails.RePrintReceiptWays.DbValue = ew_Conv(Rs("RePrintReceiptWays"), Rs("RePrintReceiptWays").Type)
				BusinessDetails.printingtype.DbValue = ew_Conv(Rs("printingtype"), Rs("printingtype").Type)
				BusinessDetails.Stripe_Key_Secret.DbValue = ew_Conv(Rs("Stripe_Key_Secret"), Rs("Stripe_Key_Secret").Type)
				BusinessDetails.Stripe.DbValue = ew_Conv(Rs("Stripe"), Rs("Stripe").Type)
				BusinessDetails.Stripe_Api_Key.DbValue = ew_Conv(Rs("Stripe_Api_Key"), Rs("Stripe_Api_Key").Type)
				BusinessDetails.EnableBooking.DbValue = ew_Conv(Rs("EnableBooking"), Rs("EnableBooking").Type)
				BusinessDetails.URL_Facebook.DbValue = ew_Conv(Rs("URL_Facebook"), Rs("URL_Facebook").Type)
				BusinessDetails.URL_Twitter.DbValue = ew_Conv(Rs("URL_Twitter"), Rs("URL_Twitter").Type)
				BusinessDetails.URL_Google.DbValue = ew_Conv(Rs("URL_Google"), Rs("URL_Google").Type)
				BusinessDetails.URL_Intagram.DbValue = ew_Conv(Rs("URL_Intagram"), Rs("URL_Intagram").Type)
				BusinessDetails.URL_YouTube.DbValue = ew_Conv(Rs("URL_YouTube"), Rs("URL_YouTube").Type)
				BusinessDetails.URL_Tripadvisor.DbValue = ew_Conv(Rs("URL_Tripadvisor"), Rs("URL_Tripadvisor").Type)
				BusinessDetails.URL_Special_Offer.DbValue = ew_Conv(Rs("URL_Special_Offer"), Rs("URL_Special_Offer").Type)
				BusinessDetails.URL_Linkin.DbValue = ew_Conv(Rs("URL_Linkin"), Rs("URL_Linkin").Type)
				BusinessDetails.Currency_PAYPAL.DbValue = ew_Conv(Rs("Currency_PAYPAL"), Rs("Currency_PAYPAL").Type)
				BusinessDetails.Currency_STRIPE.DbValue = ew_Conv(Rs("Currency_STRIPE"), Rs("Currency_STRIPE").Type)
				BusinessDetails.Currency_WOLRDPAY.DbValue = ew_Conv(Rs("Currency_WOLRDPAY"), Rs("Currency_WOLRDPAY").Type)
				BusinessDetails.Tip_percent.DbValue = ew_Conv(Rs("Tip_percent"), Rs("Tip_percent").Type)
				BusinessDetails.Tax_Percent.DbValue = ew_Conv(Rs("Tax_Percent"), Rs("Tax_Percent").Type)
				BusinessDetails.InRestaurantTaxChargeOnly.DbValue = ew_Conv(Rs("InRestaurantTaxChargeOnly"), Rs("InRestaurantTaxChargeOnly").Type)
				BusinessDetails.InRestaurantTipChargeOnly.DbValue = ew_Conv(Rs("InRestaurantTipChargeOnly"), Rs("InRestaurantTipChargeOnly").Type)
				BusinessDetails.isCheckCapcha.DbValue = ew_Conv(Rs("isCheckCapcha"), Rs("isCheckCapcha").Type)
				BusinessDetails.Close_StartDate.DbValue = ew_Conv(Rs("Close_StartDate"), Rs("Close_StartDate").Type)
				BusinessDetails.Close_EndDate.DbValue = ew_Conv(Rs("Close_EndDate"), Rs("Close_EndDate").Type)
				BusinessDetails.Stripe_Country.DbValue = ew_Conv(Rs("Stripe_Country"), Rs("Stripe_Country").Type)
				BusinessDetails.enable_StripePaymentButton.DbValue = ew_Conv(Rs("enable_StripePaymentButton"), Rs("enable_StripePaymentButton").Type)
				BusinessDetails.enable_CashPayment.DbValue = ew_Conv(Rs("enable_CashPayment"), Rs("enable_CashPayment").Type)
				BusinessDetails.DeliveryMile.DbValue = ew_Conv(Rs("DeliveryMile"), Rs("DeliveryMile").Type)
				BusinessDetails.Mon_Delivery.DbValue = ew_Conv(Rs("Mon_Delivery"), Rs("Mon_Delivery").Type)
				BusinessDetails.Mon_Collection.DbValue = ew_Conv(Rs("Mon_Collection"), Rs("Mon_Collection").Type)
				BusinessDetails.Tue_Delivery.DbValue = ew_Conv(Rs("Tue_Delivery"), Rs("Tue_Delivery").Type)
				BusinessDetails.Tue_Collection.DbValue = ew_Conv(Rs("Tue_Collection"), Rs("Tue_Collection").Type)
				BusinessDetails.Wed_Delivery.DbValue = ew_Conv(Rs("Wed_Delivery"), Rs("Wed_Delivery").Type)
				BusinessDetails.Wed_Collection.DbValue = ew_Conv(Rs("Wed_Collection"), Rs("Wed_Collection").Type)
				BusinessDetails.Thu_Delivery.DbValue = ew_Conv(Rs("Thu_Delivery"), Rs("Thu_Delivery").Type)
				BusinessDetails.Thu_Collection.DbValue = ew_Conv(Rs("Thu_Collection"), Rs("Thu_Collection").Type)
				BusinessDetails.Fri_Delivery.DbValue = ew_Conv(Rs("Fri_Delivery"), Rs("Fri_Delivery").Type)
				BusinessDetails.Fri_Collection.DbValue = ew_Conv(Rs("Fri_Collection"), Rs("Fri_Collection").Type)
				BusinessDetails.Sat_Delivery.DbValue = ew_Conv(Rs("Sat_Delivery"), Rs("Sat_Delivery").Type)
				BusinessDetails.Sat_Collection.DbValue = ew_Conv(Rs("Sat_Collection"), Rs("Sat_Collection").Type)
				BusinessDetails.Sun_Delivery.DbValue = ew_Conv(Rs("Sun_Delivery"), Rs("Sun_Delivery").Type)
				BusinessDetails.Sun_Collection.DbValue = ew_Conv(Rs("Sun_Collection"), Rs("Sun_Collection").Type)
				BusinessDetails.EnableUrlRewrite.DbValue = ew_Conv(Rs("EnableUrlRewrite"), Rs("EnableUrlRewrite").Type)
				BusinessDetails.DeliveryCostUpTo.DbValue = ew_Conv(Rs("DeliveryCostUpTo"), Rs("DeliveryCostUpTo").Type)
				BusinessDetails.DeliveryUptoMile.DbValue = ew_Conv(Rs("DeliveryUptoMile"), Rs("DeliveryUptoMile").Type)
				BusinessDetails.Show_Ordernumner_printer.DbValue = ew_Conv(Rs("Show_Ordernumner_printer"), Rs("Show_Ordernumner_printer").Type)
				BusinessDetails.Show_Ordernumner_Receipt.DbValue = ew_Conv(Rs("Show_Ordernumner_Receipt"), Rs("Show_Ordernumner_Receipt").Type)
				BusinessDetails.Show_Ordernumner_Dashboard.DbValue = ew_Conv(Rs("Show_Ordernumner_Dashboard"), Rs("Show_Ordernumner_Dashboard").Type)
			Else
				OldValue = BusinessDetails.Name.DbValue
				NewValue = ew_Conv(Rs("Name"), Rs("Name").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.Name.CurrentValue = Null
				End If
				OldValue = BusinessDetails.Address.DbValue
				NewValue = ew_Conv(Rs("Address"), Rs("Address").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.Address.CurrentValue = Null
				End If
				OldValue = BusinessDetails.PostalCode.DbValue
				NewValue = ew_Conv(Rs("PostalCode"), Rs("PostalCode").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.PostalCode.CurrentValue = Null
				End If
				OldValue = BusinessDetails.FoodType.DbValue
				NewValue = ew_Conv(Rs("FoodType"), Rs("FoodType").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.FoodType.CurrentValue = Null
				End If
				OldValue = BusinessDetails.DeliveryMinAmount.DbValue
				NewValue = ew_Conv(Rs("DeliveryMinAmount"), Rs("DeliveryMinAmount").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.DeliveryMinAmount.CurrentValue = Null
				End If
				OldValue = BusinessDetails.DeliveryMaxDistance.DbValue
				NewValue = ew_Conv(Rs("DeliveryMaxDistance"), Rs("DeliveryMaxDistance").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.DeliveryMaxDistance.CurrentValue = Null
				End If
				OldValue = BusinessDetails.DeliveryFreeDistance.DbValue
				NewValue = ew_Conv(Rs("DeliveryFreeDistance"), Rs("DeliveryFreeDistance").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.DeliveryFreeDistance.CurrentValue = Null
				End If
				OldValue = BusinessDetails.AverageDeliveryTime.DbValue
				NewValue = ew_Conv(Rs("AverageDeliveryTime"), Rs("AverageDeliveryTime").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.AverageDeliveryTime.CurrentValue = Null
				End If
				OldValue = BusinessDetails.AverageCollectionTime.DbValue
				NewValue = ew_Conv(Rs("AverageCollectionTime"), Rs("AverageCollectionTime").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.AverageCollectionTime.CurrentValue = Null
				End If
				OldValue = BusinessDetails.DeliveryFee.DbValue
				NewValue = ew_Conv(Rs("DeliveryFee"), Rs("DeliveryFee").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.DeliveryFee.CurrentValue = Null
				End If
				OldValue = BusinessDetails.ImgUrl.DbValue
				NewValue = ew_Conv(Rs("ImgUrl"), Rs("ImgUrl").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.ImgUrl.CurrentValue = Null
				End If
				OldValue = BusinessDetails.Telephone.DbValue
				NewValue = ew_Conv(Rs("Telephone"), Rs("Telephone").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.Telephone.CurrentValue = Null
				End If
				OldValue = BusinessDetails.zEmail.DbValue
				NewValue = ew_Conv(Rs("Email"), Rs("Email").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.zEmail.CurrentValue = Null
				End If
				OldValue = BusinessDetails.pswd.DbValue
				NewValue = ew_Conv(Rs("pswd"), Rs("pswd").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.pswd.CurrentValue = Null
				End If
				OldValue = BusinessDetails.businessclosed.DbValue
				NewValue = ew_Conv(Rs("businessclosed"), Rs("businessclosed").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.businessclosed.CurrentValue = Null
				End If
				OldValue = BusinessDetails.announcement.DbValue
				NewValue = ew_Conv(Rs("announcement"), Rs("announcement").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.announcement.CurrentValue = Null
				End If
				OldValue = BusinessDetails.css.DbValue
				NewValue = ew_Conv(Rs("css"), Rs("css").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.css.CurrentValue = Null
				End If
				OldValue = BusinessDetails.SMTP_AUTENTICATE.DbValue
				NewValue = ew_Conv(Rs("SMTP_AUTENTICATE"), Rs("SMTP_AUTENTICATE").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.SMTP_AUTENTICATE.CurrentValue = Null
				End If
				OldValue = BusinessDetails.MAIL_FROM.DbValue
				NewValue = ew_Conv(Rs("MAIL_FROM"), Rs("MAIL_FROM").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.MAIL_FROM.CurrentValue = Null
				End If
				OldValue = BusinessDetails.PAYPAL_URL.DbValue
				NewValue = ew_Conv(Rs("PAYPAL_URL"), Rs("PAYPAL_URL").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.PAYPAL_URL.CurrentValue = Null
				End If
				OldValue = BusinessDetails.PAYPAL_PDT.DbValue
				NewValue = ew_Conv(Rs("PAYPAL_PDT"), Rs("PAYPAL_PDT").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.PAYPAL_PDT.CurrentValue = Null
				End If
				OldValue = BusinessDetails.SMTP_PASSWORD.DbValue
				NewValue = ew_Conv(Rs("SMTP_PASSWORD"), Rs("SMTP_PASSWORD").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.SMTP_PASSWORD.CurrentValue = Null
				End If
				OldValue = BusinessDetails.GMAP_API_KEY.DbValue
				NewValue = ew_Conv(Rs("GMAP_API_KEY"), Rs("GMAP_API_KEY").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.GMAP_API_KEY.CurrentValue = Null
				End If
				OldValue = BusinessDetails.SMTP_USERNAME.DbValue
				NewValue = ew_Conv(Rs("SMTP_USERNAME"), Rs("SMTP_USERNAME").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.SMTP_USERNAME.CurrentValue = Null
				End If
				OldValue = BusinessDetails.SMTP_USESSL.DbValue
				NewValue = ew_Conv(Rs("SMTP_USESSL"), Rs("SMTP_USESSL").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.SMTP_USESSL.CurrentValue = Null
				End If
				OldValue = BusinessDetails.MAIL_SUBJECT.DbValue
				NewValue = ew_Conv(Rs("MAIL_SUBJECT"), Rs("MAIL_SUBJECT").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.MAIL_SUBJECT.CurrentValue = Null
				End If
				OldValue = BusinessDetails.CURRENCYSYMBOL.DbValue
				NewValue = ew_Conv(Rs("CURRENCYSYMBOL"), Rs("CURRENCYSYMBOL").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.CURRENCYSYMBOL.CurrentValue = Null
				End If
				OldValue = BusinessDetails.SMTP_SERVER.DbValue
				NewValue = ew_Conv(Rs("SMTP_SERVER"), Rs("SMTP_SERVER").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.SMTP_SERVER.CurrentValue = Null
				End If
				OldValue = BusinessDetails.CREDITCARDSURCHARGE.DbValue
				NewValue = ew_Conv(Rs("CREDITCARDSURCHARGE"), Rs("CREDITCARDSURCHARGE").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.CREDITCARDSURCHARGE.CurrentValue = Null
				End If
				OldValue = BusinessDetails.SMTP_PORT.DbValue
				NewValue = ew_Conv(Rs("SMTP_PORT"), Rs("SMTP_PORT").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.SMTP_PORT.CurrentValue = Null
				End If
				OldValue = BusinessDetails.STICK_MENU.DbValue
				NewValue = ew_Conv(Rs("STICK_MENU"), Rs("STICK_MENU").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.STICK_MENU.CurrentValue = Null
				End If
				OldValue = BusinessDetails.MAIL_CUSTOMER_SUBJECT.DbValue
				NewValue = ew_Conv(Rs("MAIL_CUSTOMER_SUBJECT"), Rs("MAIL_CUSTOMER_SUBJECT").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.MAIL_CUSTOMER_SUBJECT.CurrentValue = Null
				End If
				OldValue = BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.DbValue
				NewValue = ew_Conv(Rs("CONFIRMATION_EMAIL_ADDRESS"), Rs("CONFIRMATION_EMAIL_ADDRESS").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.CurrentValue = Null
				End If
				OldValue = BusinessDetails.SEND_ORDERS_TO_PRINTER.DbValue
				NewValue = ew_Conv(Rs("SEND_ORDERS_TO_PRINTER"), Rs("SEND_ORDERS_TO_PRINTER").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.SEND_ORDERS_TO_PRINTER.CurrentValue = Null
				End If
				OldValue = BusinessDetails.timezone.DbValue
				NewValue = ew_Conv(Rs("timezone"), Rs("timezone").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.timezone.CurrentValue = Null
				End If
				OldValue = BusinessDetails.PAYPAL_ADDR.DbValue
				NewValue = ew_Conv(Rs("PAYPAL_ADDR"), Rs("PAYPAL_ADDR").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.PAYPAL_ADDR.CurrentValue = Null
				End If
				OldValue = BusinessDetails.nochex.DbValue
				NewValue = ew_Conv(Rs("nochex"), Rs("nochex").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.nochex.CurrentValue = Null
				End If
				OldValue = BusinessDetails.nochexmerchantid.DbValue
				NewValue = ew_Conv(Rs("nochexmerchantid"), Rs("nochexmerchantid").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.nochexmerchantid.CurrentValue = Null
				End If
				OldValue = BusinessDetails.paypal.DbValue
				NewValue = ew_Conv(Rs("paypal"), Rs("paypal").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.paypal.CurrentValue = Null
				End If
				OldValue = BusinessDetails.IBT_API_KEY.DbValue
				NewValue = ew_Conv(Rs("IBT_API_KEY"), Rs("IBT_API_KEY").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.IBT_API_KEY.CurrentValue = Null
				End If
				OldValue = BusinessDetails.IBP_API_PASSWORD.DbValue
				NewValue = ew_Conv(Rs("IBP_API_PASSWORD"), Rs("IBP_API_PASSWORD").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.IBP_API_PASSWORD.CurrentValue = Null
				End If
				OldValue = BusinessDetails.disable_delivery.DbValue
				NewValue = ew_Conv(Rs("disable_delivery"), Rs("disable_delivery").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.disable_delivery.CurrentValue = Null
				End If
				OldValue = BusinessDetails.disable_collection.DbValue
				NewValue = ew_Conv(Rs("disable_collection"), Rs("disable_collection").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.disable_collection.CurrentValue = Null
				End If
				OldValue = BusinessDetails.worldpay.DbValue
				NewValue = ew_Conv(Rs("worldpay"), Rs("worldpay").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.worldpay.CurrentValue = Null
				End If
				OldValue = BusinessDetails.worldpaymerchantid.DbValue
				NewValue = ew_Conv(Rs("worldpaymerchantid"), Rs("worldpaymerchantid").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.worldpaymerchantid.CurrentValue = Null
				End If
				OldValue = BusinessDetails.backtohometext.DbValue
				NewValue = ew_Conv(Rs("backtohometext"), Rs("backtohometext").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.backtohometext.CurrentValue = Null
				End If
				OldValue = BusinessDetails.closedtext.DbValue
				NewValue = ew_Conv(Rs("closedtext"), Rs("closedtext").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.closedtext.CurrentValue = Null
				End If
				OldValue = BusinessDetails.DeliveryChargeOverrideByOrderValue.DbValue
				NewValue = ew_Conv(Rs("DeliveryChargeOverrideByOrderValue"), Rs("DeliveryChargeOverrideByOrderValue").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.DeliveryChargeOverrideByOrderValue.CurrentValue = Null
				End If
				OldValue = BusinessDetails.individualpostcodes.DbValue
				NewValue = ew_Conv(Rs("individualpostcodes"), Rs("individualpostcodes").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.individualpostcodes.CurrentValue = Null
				End If
				OldValue = BusinessDetails.individualpostcodeschecking.DbValue
				NewValue = ew_Conv(Rs("individualpostcodeschecking"), Rs("individualpostcodeschecking").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.individualpostcodeschecking.CurrentValue = Null
				End If
				OldValue = BusinessDetails.longitude.DbValue
				NewValue = ew_Conv(Rs("longitude"), Rs("longitude").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.longitude.CurrentValue = Null
				End If
				OldValue = BusinessDetails.latitude.DbValue
				NewValue = ew_Conv(Rs("latitude"), Rs("latitude").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.latitude.CurrentValue = Null
				End If
				OldValue = BusinessDetails.googleecommercetracking.DbValue
				NewValue = ew_Conv(Rs("googleecommercetracking"), Rs("googleecommercetracking").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.googleecommercetracking.CurrentValue = Null
				End If
				OldValue = BusinessDetails.googleecommercetrackingcode.DbValue
				NewValue = ew_Conv(Rs("googleecommercetrackingcode"), Rs("googleecommercetrackingcode").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.googleecommercetrackingcode.CurrentValue = Null
				End If
				OldValue = BusinessDetails.bringg.DbValue
				NewValue = ew_Conv(Rs("bringg"), Rs("bringg").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.bringg.CurrentValue = Null
				End If
				OldValue = BusinessDetails.bringgurl.DbValue
				NewValue = ew_Conv(Rs("bringgurl"), Rs("bringgurl").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.bringgurl.CurrentValue = Null
				End If
				OldValue = BusinessDetails.bringgcompanyid.DbValue
				NewValue = ew_Conv(Rs("bringgcompanyid"), Rs("bringgcompanyid").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.bringgcompanyid.CurrentValue = Null
				End If
				OldValue = BusinessDetails.orderonlywhenopen.DbValue
				NewValue = ew_Conv(Rs("orderonlywhenopen"), Rs("orderonlywhenopen").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.orderonlywhenopen.CurrentValue = Null
				End If
				OldValue = BusinessDetails.disablelaterdelivery.DbValue
				NewValue = ew_Conv(Rs("disablelaterdelivery"), Rs("disablelaterdelivery").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.disablelaterdelivery.CurrentValue = Null
				End If
				OldValue = BusinessDetails.menupagetext.DbValue
				NewValue = ew_Conv(Rs("menupagetext"), Rs("menupagetext").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.menupagetext.CurrentValue = Null
				End If
				OldValue = BusinessDetails.ordertodayonly.DbValue
				NewValue = ew_Conv(Rs("ordertodayonly"), Rs("ordertodayonly").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.ordertodayonly.CurrentValue = Null
				End If
				OldValue = BusinessDetails.mileskm.DbValue
				NewValue = ew_Conv(Rs("mileskm"), Rs("mileskm").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.mileskm.CurrentValue = Null
				End If
				OldValue = BusinessDetails.worldpaylive.DbValue
				NewValue = ew_Conv(Rs("worldpaylive"), Rs("worldpaylive").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.worldpaylive.CurrentValue = Null
				End If
				OldValue = BusinessDetails.worldpayinstallationid.DbValue
				NewValue = ew_Conv(Rs("worldpayinstallationid"), Rs("worldpayinstallationid").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.worldpayinstallationid.CurrentValue = Null
				End If
				OldValue = BusinessDetails.DistanceCalMethod.DbValue
				NewValue = ew_Conv(Rs("DistanceCalMethod"), Rs("DistanceCalMethod").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.DistanceCalMethod.CurrentValue = Null
				End If
				OldValue = BusinessDetails.PrinterIDList.DbValue
				NewValue = ew_Conv(Rs("PrinterIDList"), Rs("PrinterIDList").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.PrinterIDList.CurrentValue = Null
				End If
				OldValue = BusinessDetails.EpsonJSPrinterURL.DbValue
				NewValue = ew_Conv(Rs("EpsonJSPrinterURL"), Rs("EpsonJSPrinterURL").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.EpsonJSPrinterURL.CurrentValue = Null
				End If
				OldValue = BusinessDetails.SMSEnable.DbValue
				NewValue = ew_Conv(Rs("SMSEnable"), Rs("SMSEnable").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.SMSEnable.CurrentValue = Null
				End If
				OldValue = BusinessDetails.SMSOnDelivery.DbValue
				NewValue = ew_Conv(Rs("SMSOnDelivery"), Rs("SMSOnDelivery").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.SMSOnDelivery.CurrentValue = Null
				End If
				OldValue = BusinessDetails.SMSSupplierDomain.DbValue
				NewValue = ew_Conv(Rs("SMSSupplierDomain"), Rs("SMSSupplierDomain").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.SMSSupplierDomain.CurrentValue = Null
				End If
				OldValue = BusinessDetails.SMSOnOrder.DbValue
				NewValue = ew_Conv(Rs("SMSOnOrder"), Rs("SMSOnOrder").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.SMSOnOrder.CurrentValue = Null
				End If
				OldValue = BusinessDetails.SMSOnOrderAfterMin.DbValue
				NewValue = ew_Conv(Rs("SMSOnOrderAfterMin"), Rs("SMSOnOrderAfterMin").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.SMSOnOrderAfterMin.CurrentValue = Null
				End If
				OldValue = BusinessDetails.SMSOnOrderContent.DbValue
				NewValue = ew_Conv(Rs("SMSOnOrderContent"), Rs("SMSOnOrderContent").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.SMSOnOrderContent.CurrentValue = Null
				End If
				OldValue = BusinessDetails.DefaultSMSCountryCode.DbValue
				NewValue = ew_Conv(Rs("DefaultSMSCountryCode"), Rs("DefaultSMSCountryCode").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.DefaultSMSCountryCode.CurrentValue = Null
				End If
				OldValue = BusinessDetails.MinimumAmountForCardPayment.DbValue
				NewValue = ew_Conv(Rs("MinimumAmountForCardPayment"), Rs("MinimumAmountForCardPayment").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.MinimumAmountForCardPayment.CurrentValue = Null
				End If
				OldValue = BusinessDetails.FavIconUrl.DbValue
				NewValue = ew_Conv(Rs("FavIconUrl"), Rs("FavIconUrl").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.FavIconUrl.CurrentValue = Null
				End If
				OldValue = BusinessDetails.AddToHomeScreenURL.DbValue
				NewValue = ew_Conv(Rs("AddToHomeScreenURL"), Rs("AddToHomeScreenURL").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.AddToHomeScreenURL.CurrentValue = Null
				End If
				OldValue = BusinessDetails.SMSOnAcknowledgement.DbValue
				NewValue = ew_Conv(Rs("SMSOnAcknowledgement"), Rs("SMSOnAcknowledgement").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.SMSOnAcknowledgement.CurrentValue = Null
				End If
				OldValue = BusinessDetails.LocalPrinterURL.DbValue
				NewValue = ew_Conv(Rs("LocalPrinterURL"), Rs("LocalPrinterURL").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.LocalPrinterURL.CurrentValue = Null
				End If
				OldValue = BusinessDetails.ShowRestaurantDetailOnReceipt.DbValue
				NewValue = ew_Conv(Rs("ShowRestaurantDetailOnReceipt"), Rs("ShowRestaurantDetailOnReceipt").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.ShowRestaurantDetailOnReceipt.CurrentValue = Null
				End If
				OldValue = BusinessDetails.PrinterFontSizeRatio.DbValue
				NewValue = ew_Conv(Rs("PrinterFontSizeRatio"), Rs("PrinterFontSizeRatio").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.PrinterFontSizeRatio.CurrentValue = Null
				End If
				OldValue = BusinessDetails.ServiceChargePercentage.DbValue
				NewValue = ew_Conv(Rs("ServiceChargePercentage"), Rs("ServiceChargePercentage").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.ServiceChargePercentage.CurrentValue = Null
				End If
				OldValue = BusinessDetails.InRestaurantServiceChargeOnly.DbValue
				NewValue = ew_Conv(Rs("InRestaurantServiceChargeOnly"), Rs("InRestaurantServiceChargeOnly").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.InRestaurantServiceChargeOnly.CurrentValue = Null
				End If
				OldValue = BusinessDetails.IsDualReceiptPrinting.DbValue
				NewValue = ew_Conv(Rs("IsDualReceiptPrinting"), Rs("IsDualReceiptPrinting").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.IsDualReceiptPrinting.CurrentValue = Null
				End If
				OldValue = BusinessDetails.PrintingFontSize.DbValue
				NewValue = ew_Conv(Rs("PrintingFontSize"), Rs("PrintingFontSize").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.PrintingFontSize.CurrentValue = Null
				End If
				OldValue = BusinessDetails.InRestaurantEpsonPrinterIDList.DbValue
				NewValue = ew_Conv(Rs("InRestaurantEpsonPrinterIDList"), Rs("InRestaurantEpsonPrinterIDList").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.InRestaurantEpsonPrinterIDList.CurrentValue = Null
				End If
				OldValue = BusinessDetails.BlockIPEmailList.DbValue
				NewValue = ew_Conv(Rs("BlockIPEmailList"), Rs("BlockIPEmailList").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.BlockIPEmailList.CurrentValue = Null
				End If
				OldValue = BusinessDetails.inmenuannouncement.DbValue
				NewValue = ew_Conv(Rs("inmenuannouncement"), Rs("inmenuannouncement").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.inmenuannouncement.CurrentValue = Null
				End If
				OldValue = BusinessDetails.RePrintReceiptWays.DbValue
				NewValue = ew_Conv(Rs("RePrintReceiptWays"), Rs("RePrintReceiptWays").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.RePrintReceiptWays.CurrentValue = Null
				End If
				OldValue = BusinessDetails.printingtype.DbValue
				NewValue = ew_Conv(Rs("printingtype"), Rs("printingtype").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.printingtype.CurrentValue = Null
				End If
				OldValue = BusinessDetails.Stripe_Key_Secret.DbValue
				NewValue = ew_Conv(Rs("Stripe_Key_Secret"), Rs("Stripe_Key_Secret").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.Stripe_Key_Secret.CurrentValue = Null
				End If
				OldValue = BusinessDetails.Stripe.DbValue
				NewValue = ew_Conv(Rs("Stripe"), Rs("Stripe").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.Stripe.CurrentValue = Null
				End If
				OldValue = BusinessDetails.Stripe_Api_Key.DbValue
				NewValue = ew_Conv(Rs("Stripe_Api_Key"), Rs("Stripe_Api_Key").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.Stripe_Api_Key.CurrentValue = Null
				End If
				OldValue = BusinessDetails.EnableBooking.DbValue
				NewValue = ew_Conv(Rs("EnableBooking"), Rs("EnableBooking").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.EnableBooking.CurrentValue = Null
				End If
				OldValue = BusinessDetails.URL_Facebook.DbValue
				NewValue = ew_Conv(Rs("URL_Facebook"), Rs("URL_Facebook").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.URL_Facebook.CurrentValue = Null
				End If
				OldValue = BusinessDetails.URL_Twitter.DbValue
				NewValue = ew_Conv(Rs("URL_Twitter"), Rs("URL_Twitter").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.URL_Twitter.CurrentValue = Null
				End If
				OldValue = BusinessDetails.URL_Google.DbValue
				NewValue = ew_Conv(Rs("URL_Google"), Rs("URL_Google").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.URL_Google.CurrentValue = Null
				End If
				OldValue = BusinessDetails.URL_Intagram.DbValue
				NewValue = ew_Conv(Rs("URL_Intagram"), Rs("URL_Intagram").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.URL_Intagram.CurrentValue = Null
				End If
				OldValue = BusinessDetails.URL_YouTube.DbValue
				NewValue = ew_Conv(Rs("URL_YouTube"), Rs("URL_YouTube").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.URL_YouTube.CurrentValue = Null
				End If
				OldValue = BusinessDetails.URL_Tripadvisor.DbValue
				NewValue = ew_Conv(Rs("URL_Tripadvisor"), Rs("URL_Tripadvisor").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.URL_Tripadvisor.CurrentValue = Null
				End If
				OldValue = BusinessDetails.URL_Special_Offer.DbValue
				NewValue = ew_Conv(Rs("URL_Special_Offer"), Rs("URL_Special_Offer").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.URL_Special_Offer.CurrentValue = Null
				End If
				OldValue = BusinessDetails.URL_Linkin.DbValue
				NewValue = ew_Conv(Rs("URL_Linkin"), Rs("URL_Linkin").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.URL_Linkin.CurrentValue = Null
				End If
				OldValue = BusinessDetails.Currency_PAYPAL.DbValue
				NewValue = ew_Conv(Rs("Currency_PAYPAL"), Rs("Currency_PAYPAL").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.Currency_PAYPAL.CurrentValue = Null
				End If
				OldValue = BusinessDetails.Currency_STRIPE.DbValue
				NewValue = ew_Conv(Rs("Currency_STRIPE"), Rs("Currency_STRIPE").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.Currency_STRIPE.CurrentValue = Null
				End If
				OldValue = BusinessDetails.Currency_WOLRDPAY.DbValue
				NewValue = ew_Conv(Rs("Currency_WOLRDPAY"), Rs("Currency_WOLRDPAY").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.Currency_WOLRDPAY.CurrentValue = Null
				End If
				OldValue = BusinessDetails.Tip_percent.DbValue
				NewValue = ew_Conv(Rs("Tip_percent"), Rs("Tip_percent").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.Tip_percent.CurrentValue = Null
				End If
				OldValue = BusinessDetails.Tax_Percent.DbValue
				NewValue = ew_Conv(Rs("Tax_Percent"), Rs("Tax_Percent").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.Tax_Percent.CurrentValue = Null
				End If
				OldValue = BusinessDetails.InRestaurantTaxChargeOnly.DbValue
				NewValue = ew_Conv(Rs("InRestaurantTaxChargeOnly"), Rs("InRestaurantTaxChargeOnly").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.InRestaurantTaxChargeOnly.CurrentValue = Null
				End If
				OldValue = BusinessDetails.InRestaurantTipChargeOnly.DbValue
				NewValue = ew_Conv(Rs("InRestaurantTipChargeOnly"), Rs("InRestaurantTipChargeOnly").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.InRestaurantTipChargeOnly.CurrentValue = Null
				End If
				OldValue = BusinessDetails.isCheckCapcha.DbValue
				NewValue = ew_Conv(Rs("isCheckCapcha"), Rs("isCheckCapcha").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.isCheckCapcha.CurrentValue = Null
				End If
				OldValue = BusinessDetails.Close_StartDate.DbValue
				NewValue = ew_Conv(Rs("Close_StartDate"), Rs("Close_StartDate").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.Close_StartDate.CurrentValue = Null
				End If
				OldValue = BusinessDetails.Close_EndDate.DbValue
				NewValue = ew_Conv(Rs("Close_EndDate"), Rs("Close_EndDate").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.Close_EndDate.CurrentValue = Null
				End If
				OldValue = BusinessDetails.Stripe_Country.DbValue
				NewValue = ew_Conv(Rs("Stripe_Country"), Rs("Stripe_Country").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.Stripe_Country.CurrentValue = Null
				End If
				OldValue = BusinessDetails.enable_StripePaymentButton.DbValue
				NewValue = ew_Conv(Rs("enable_StripePaymentButton"), Rs("enable_StripePaymentButton").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.enable_StripePaymentButton.CurrentValue = Null
				End If
				OldValue = BusinessDetails.enable_CashPayment.DbValue
				NewValue = ew_Conv(Rs("enable_CashPayment"), Rs("enable_CashPayment").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.enable_CashPayment.CurrentValue = Null
				End If
				OldValue = BusinessDetails.DeliveryMile.DbValue
				NewValue = ew_Conv(Rs("DeliveryMile"), Rs("DeliveryMile").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.DeliveryMile.CurrentValue = Null
				End If
				OldValue = BusinessDetails.Mon_Delivery.DbValue
				NewValue = ew_Conv(Rs("Mon_Delivery"), Rs("Mon_Delivery").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.Mon_Delivery.CurrentValue = Null
				End If
				OldValue = BusinessDetails.Mon_Collection.DbValue
				NewValue = ew_Conv(Rs("Mon_Collection"), Rs("Mon_Collection").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.Mon_Collection.CurrentValue = Null
				End If
				OldValue = BusinessDetails.Tue_Delivery.DbValue
				NewValue = ew_Conv(Rs("Tue_Delivery"), Rs("Tue_Delivery").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.Tue_Delivery.CurrentValue = Null
				End If
				OldValue = BusinessDetails.Tue_Collection.DbValue
				NewValue = ew_Conv(Rs("Tue_Collection"), Rs("Tue_Collection").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.Tue_Collection.CurrentValue = Null
				End If
				OldValue = BusinessDetails.Wed_Delivery.DbValue
				NewValue = ew_Conv(Rs("Wed_Delivery"), Rs("Wed_Delivery").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.Wed_Delivery.CurrentValue = Null
				End If
				OldValue = BusinessDetails.Wed_Collection.DbValue
				NewValue = ew_Conv(Rs("Wed_Collection"), Rs("Wed_Collection").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.Wed_Collection.CurrentValue = Null
				End If
				OldValue = BusinessDetails.Thu_Delivery.DbValue
				NewValue = ew_Conv(Rs("Thu_Delivery"), Rs("Thu_Delivery").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.Thu_Delivery.CurrentValue = Null
				End If
				OldValue = BusinessDetails.Thu_Collection.DbValue
				NewValue = ew_Conv(Rs("Thu_Collection"), Rs("Thu_Collection").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.Thu_Collection.CurrentValue = Null
				End If
				OldValue = BusinessDetails.Fri_Delivery.DbValue
				NewValue = ew_Conv(Rs("Fri_Delivery"), Rs("Fri_Delivery").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.Fri_Delivery.CurrentValue = Null
				End If
				OldValue = BusinessDetails.Fri_Collection.DbValue
				NewValue = ew_Conv(Rs("Fri_Collection"), Rs("Fri_Collection").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.Fri_Collection.CurrentValue = Null
				End If
				OldValue = BusinessDetails.Sat_Delivery.DbValue
				NewValue = ew_Conv(Rs("Sat_Delivery"), Rs("Sat_Delivery").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.Sat_Delivery.CurrentValue = Null
				End If
				OldValue = BusinessDetails.Sat_Collection.DbValue
				NewValue = ew_Conv(Rs("Sat_Collection"), Rs("Sat_Collection").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.Sat_Collection.CurrentValue = Null
				End If
				OldValue = BusinessDetails.Sun_Delivery.DbValue
				NewValue = ew_Conv(Rs("Sun_Delivery"), Rs("Sun_Delivery").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.Sun_Delivery.CurrentValue = Null
				End If
				OldValue = BusinessDetails.Sun_Collection.DbValue
				NewValue = ew_Conv(Rs("Sun_Collection"), Rs("Sun_Collection").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.Sun_Collection.CurrentValue = Null
				End If
				OldValue = BusinessDetails.EnableUrlRewrite.DbValue
				NewValue = ew_Conv(Rs("EnableUrlRewrite"), Rs("EnableUrlRewrite").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.EnableUrlRewrite.CurrentValue = Null
				End If
				OldValue = BusinessDetails.DeliveryCostUpTo.DbValue
				NewValue = ew_Conv(Rs("DeliveryCostUpTo"), Rs("DeliveryCostUpTo").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.DeliveryCostUpTo.CurrentValue = Null
				End If
				OldValue = BusinessDetails.DeliveryUptoMile.DbValue
				NewValue = ew_Conv(Rs("DeliveryUptoMile"), Rs("DeliveryUptoMile").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.DeliveryUptoMile.CurrentValue = Null
				End If
				OldValue = BusinessDetails.Show_Ordernumner_printer.DbValue
				NewValue = ew_Conv(Rs("Show_Ordernumner_printer"), Rs("Show_Ordernumner_printer").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.Show_Ordernumner_printer.CurrentValue = Null
				End If
				OldValue = BusinessDetails.Show_Ordernumner_Receipt.DbValue
				NewValue = ew_Conv(Rs("Show_Ordernumner_Receipt"), Rs("Show_Ordernumner_Receipt").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.Show_Ordernumner_Receipt.CurrentValue = Null
				End If
				OldValue = BusinessDetails.Show_Ordernumner_Dashboard.DbValue
				NewValue = ew_Conv(Rs("Show_Ordernumner_Dashboard"), Rs("Show_Ordernumner_Dashboard").Type)
				If Not ew_CompareValue(OldValue, NewValue) Then
					BusinessDetails.Show_Ordernumner_Dashboard.CurrentValue = Null
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
		BusinessDetails.ID.CurrentValue = sKeyFld ' Set up key value
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
		BusinessDetails.CurrentFilter = BusinessDetails.GetKeyFilter()
		sSql = BusinessDetails.SQL
		Set Rs = Server.CreateObject("ADODB.Recordset")
		Rs.CursorLocation = EW_CURSORLOCATION
		Rs.Open sSql, Conn, 1, EW_RECORDSET_LOCKTYPE
		Set RsOld = ew_CloneRs(Rs)

		' Update all rows
		sKey = ""
		For i = 0 to UBound(RecKeys)
			If SetupKeyValues(RecKeys(i)) Then
				sThisKey = RecKeys(i)
				BusinessDetails.SendEmail = False ' Do not send email on update success
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
		If Not BusinessDetails.Name.FldIsDetailKey Then BusinessDetails.Name.FormValue = ObjForm.GetValue("x_Name")
		BusinessDetails.Name.MultiUpdate = ObjForm.GetValue("u_Name")
		If Not BusinessDetails.Address.FldIsDetailKey Then BusinessDetails.Address.FormValue = ObjForm.GetValue("x_Address")
		BusinessDetails.Address.MultiUpdate = ObjForm.GetValue("u_Address")
		If Not BusinessDetails.PostalCode.FldIsDetailKey Then BusinessDetails.PostalCode.FormValue = ObjForm.GetValue("x_PostalCode")
		BusinessDetails.PostalCode.MultiUpdate = ObjForm.GetValue("u_PostalCode")
		If Not BusinessDetails.FoodType.FldIsDetailKey Then BusinessDetails.FoodType.FormValue = ObjForm.GetValue("x_FoodType")
		BusinessDetails.FoodType.MultiUpdate = ObjForm.GetValue("u_FoodType")
		If Not BusinessDetails.DeliveryMinAmount.FldIsDetailKey Then BusinessDetails.DeliveryMinAmount.FormValue = ObjForm.GetValue("x_DeliveryMinAmount")
		BusinessDetails.DeliveryMinAmount.MultiUpdate = ObjForm.GetValue("u_DeliveryMinAmount")
		If Not BusinessDetails.DeliveryMaxDistance.FldIsDetailKey Then BusinessDetails.DeliveryMaxDistance.FormValue = ObjForm.GetValue("x_DeliveryMaxDistance")
		BusinessDetails.DeliveryMaxDistance.MultiUpdate = ObjForm.GetValue("u_DeliveryMaxDistance")
		If Not BusinessDetails.DeliveryFreeDistance.FldIsDetailKey Then BusinessDetails.DeliveryFreeDistance.FormValue = ObjForm.GetValue("x_DeliveryFreeDistance")
		BusinessDetails.DeliveryFreeDistance.MultiUpdate = ObjForm.GetValue("u_DeliveryFreeDistance")
		If Not BusinessDetails.AverageDeliveryTime.FldIsDetailKey Then BusinessDetails.AverageDeliveryTime.FormValue = ObjForm.GetValue("x_AverageDeliveryTime")
		BusinessDetails.AverageDeliveryTime.MultiUpdate = ObjForm.GetValue("u_AverageDeliveryTime")
		If Not BusinessDetails.AverageCollectionTime.FldIsDetailKey Then BusinessDetails.AverageCollectionTime.FormValue = ObjForm.GetValue("x_AverageCollectionTime")
		BusinessDetails.AverageCollectionTime.MultiUpdate = ObjForm.GetValue("u_AverageCollectionTime")
		If Not BusinessDetails.DeliveryFee.FldIsDetailKey Then BusinessDetails.DeliveryFee.FormValue = ObjForm.GetValue("x_DeliveryFee")
		BusinessDetails.DeliveryFee.MultiUpdate = ObjForm.GetValue("u_DeliveryFee")
		If Not BusinessDetails.ImgUrl.FldIsDetailKey Then BusinessDetails.ImgUrl.FormValue = ObjForm.GetValue("x_ImgUrl")
		BusinessDetails.ImgUrl.MultiUpdate = ObjForm.GetValue("u_ImgUrl")
		If Not BusinessDetails.Telephone.FldIsDetailKey Then BusinessDetails.Telephone.FormValue = ObjForm.GetValue("x_Telephone")
		BusinessDetails.Telephone.MultiUpdate = ObjForm.GetValue("u_Telephone")
		If Not BusinessDetails.zEmail.FldIsDetailKey Then BusinessDetails.zEmail.FormValue = ObjForm.GetValue("x_zEmail")
		BusinessDetails.zEmail.MultiUpdate = ObjForm.GetValue("u_zEmail")
		If Not BusinessDetails.pswd.FldIsDetailKey Then BusinessDetails.pswd.FormValue = ObjForm.GetValue("x_pswd")
		BusinessDetails.pswd.MultiUpdate = ObjForm.GetValue("u_pswd")
		If Not BusinessDetails.businessclosed.FldIsDetailKey Then BusinessDetails.businessclosed.FormValue = ObjForm.GetValue("x_businessclosed")
		BusinessDetails.businessclosed.MultiUpdate = ObjForm.GetValue("u_businessclosed")
		If Not BusinessDetails.announcement.FldIsDetailKey Then BusinessDetails.announcement.FormValue = ObjForm.GetValue("x_announcement")
		BusinessDetails.announcement.MultiUpdate = ObjForm.GetValue("u_announcement")
		If Not BusinessDetails.css.FldIsDetailKey Then BusinessDetails.css.FormValue = ObjForm.GetValue("x_css")
		BusinessDetails.css.MultiUpdate = ObjForm.GetValue("u_css")
		If Not BusinessDetails.SMTP_AUTENTICATE.FldIsDetailKey Then BusinessDetails.SMTP_AUTENTICATE.FormValue = ObjForm.GetValue("x_SMTP_AUTENTICATE")
		BusinessDetails.SMTP_AUTENTICATE.MultiUpdate = ObjForm.GetValue("u_SMTP_AUTENTICATE")
		If Not BusinessDetails.MAIL_FROM.FldIsDetailKey Then BusinessDetails.MAIL_FROM.FormValue = ObjForm.GetValue("x_MAIL_FROM")
		BusinessDetails.MAIL_FROM.MultiUpdate = ObjForm.GetValue("u_MAIL_FROM")
		If Not BusinessDetails.PAYPAL_URL.FldIsDetailKey Then BusinessDetails.PAYPAL_URL.FormValue = ObjForm.GetValue("x_PAYPAL_URL")
		BusinessDetails.PAYPAL_URL.MultiUpdate = ObjForm.GetValue("u_PAYPAL_URL")
		If Not BusinessDetails.PAYPAL_PDT.FldIsDetailKey Then BusinessDetails.PAYPAL_PDT.FormValue = ObjForm.GetValue("x_PAYPAL_PDT")
		BusinessDetails.PAYPAL_PDT.MultiUpdate = ObjForm.GetValue("u_PAYPAL_PDT")
		If Not BusinessDetails.SMTP_PASSWORD.FldIsDetailKey Then BusinessDetails.SMTP_PASSWORD.FormValue = ObjForm.GetValue("x_SMTP_PASSWORD")
		BusinessDetails.SMTP_PASSWORD.MultiUpdate = ObjForm.GetValue("u_SMTP_PASSWORD")
		If Not BusinessDetails.GMAP_API_KEY.FldIsDetailKey Then BusinessDetails.GMAP_API_KEY.FormValue = ObjForm.GetValue("x_GMAP_API_KEY")
		BusinessDetails.GMAP_API_KEY.MultiUpdate = ObjForm.GetValue("u_GMAP_API_KEY")
		If Not BusinessDetails.SMTP_USERNAME.FldIsDetailKey Then BusinessDetails.SMTP_USERNAME.FormValue = ObjForm.GetValue("x_SMTP_USERNAME")
		BusinessDetails.SMTP_USERNAME.MultiUpdate = ObjForm.GetValue("u_SMTP_USERNAME")
		If Not BusinessDetails.SMTP_USESSL.FldIsDetailKey Then BusinessDetails.SMTP_USESSL.FormValue = ObjForm.GetValue("x_SMTP_USESSL")
		BusinessDetails.SMTP_USESSL.MultiUpdate = ObjForm.GetValue("u_SMTP_USESSL")
		If Not BusinessDetails.MAIL_SUBJECT.FldIsDetailKey Then BusinessDetails.MAIL_SUBJECT.FormValue = ObjForm.GetValue("x_MAIL_SUBJECT")
		BusinessDetails.MAIL_SUBJECT.MultiUpdate = ObjForm.GetValue("u_MAIL_SUBJECT")
		If Not BusinessDetails.CURRENCYSYMBOL.FldIsDetailKey Then BusinessDetails.CURRENCYSYMBOL.FormValue = ObjForm.GetValue("x_CURRENCYSYMBOL")
		BusinessDetails.CURRENCYSYMBOL.MultiUpdate = ObjForm.GetValue("u_CURRENCYSYMBOL")
		If Not BusinessDetails.SMTP_SERVER.FldIsDetailKey Then BusinessDetails.SMTP_SERVER.FormValue = ObjForm.GetValue("x_SMTP_SERVER")
		BusinessDetails.SMTP_SERVER.MultiUpdate = ObjForm.GetValue("u_SMTP_SERVER")
		If Not BusinessDetails.CREDITCARDSURCHARGE.FldIsDetailKey Then BusinessDetails.CREDITCARDSURCHARGE.FormValue = ObjForm.GetValue("x_CREDITCARDSURCHARGE")
		BusinessDetails.CREDITCARDSURCHARGE.MultiUpdate = ObjForm.GetValue("u_CREDITCARDSURCHARGE")
		If Not BusinessDetails.SMTP_PORT.FldIsDetailKey Then BusinessDetails.SMTP_PORT.FormValue = ObjForm.GetValue("x_SMTP_PORT")
		BusinessDetails.SMTP_PORT.MultiUpdate = ObjForm.GetValue("u_SMTP_PORT")
		If Not BusinessDetails.STICK_MENU.FldIsDetailKey Then BusinessDetails.STICK_MENU.FormValue = ObjForm.GetValue("x_STICK_MENU")
		BusinessDetails.STICK_MENU.MultiUpdate = ObjForm.GetValue("u_STICK_MENU")
		If Not BusinessDetails.MAIL_CUSTOMER_SUBJECT.FldIsDetailKey Then BusinessDetails.MAIL_CUSTOMER_SUBJECT.FormValue = ObjForm.GetValue("x_MAIL_CUSTOMER_SUBJECT")
		BusinessDetails.MAIL_CUSTOMER_SUBJECT.MultiUpdate = ObjForm.GetValue("u_MAIL_CUSTOMER_SUBJECT")
		If Not BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.FldIsDetailKey Then BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.FormValue = ObjForm.GetValue("x_CONFIRMATION_EMAIL_ADDRESS")
		BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.MultiUpdate = ObjForm.GetValue("u_CONFIRMATION_EMAIL_ADDRESS")
		If Not BusinessDetails.SEND_ORDERS_TO_PRINTER.FldIsDetailKey Then BusinessDetails.SEND_ORDERS_TO_PRINTER.FormValue = ObjForm.GetValue("x_SEND_ORDERS_TO_PRINTER")
		BusinessDetails.SEND_ORDERS_TO_PRINTER.MultiUpdate = ObjForm.GetValue("u_SEND_ORDERS_TO_PRINTER")
		If Not BusinessDetails.timezone.FldIsDetailKey Then BusinessDetails.timezone.FormValue = ObjForm.GetValue("x_timezone")
		BusinessDetails.timezone.MultiUpdate = ObjForm.GetValue("u_timezone")
		If Not BusinessDetails.PAYPAL_ADDR.FldIsDetailKey Then BusinessDetails.PAYPAL_ADDR.FormValue = ObjForm.GetValue("x_PAYPAL_ADDR")
		BusinessDetails.PAYPAL_ADDR.MultiUpdate = ObjForm.GetValue("u_PAYPAL_ADDR")
		If Not BusinessDetails.nochex.FldIsDetailKey Then BusinessDetails.nochex.FormValue = ObjForm.GetValue("x_nochex")
		BusinessDetails.nochex.MultiUpdate = ObjForm.GetValue("u_nochex")
		If Not BusinessDetails.nochexmerchantid.FldIsDetailKey Then BusinessDetails.nochexmerchantid.FormValue = ObjForm.GetValue("x_nochexmerchantid")
		BusinessDetails.nochexmerchantid.MultiUpdate = ObjForm.GetValue("u_nochexmerchantid")
		If Not BusinessDetails.paypal.FldIsDetailKey Then BusinessDetails.paypal.FormValue = ObjForm.GetValue("x_paypal")
		BusinessDetails.paypal.MultiUpdate = ObjForm.GetValue("u_paypal")
		If Not BusinessDetails.IBT_API_KEY.FldIsDetailKey Then BusinessDetails.IBT_API_KEY.FormValue = ObjForm.GetValue("x_IBT_API_KEY")
		BusinessDetails.IBT_API_KEY.MultiUpdate = ObjForm.GetValue("u_IBT_API_KEY")
		If Not BusinessDetails.IBP_API_PASSWORD.FldIsDetailKey Then BusinessDetails.IBP_API_PASSWORD.FormValue = ObjForm.GetValue("x_IBP_API_PASSWORD")
		BusinessDetails.IBP_API_PASSWORD.MultiUpdate = ObjForm.GetValue("u_IBP_API_PASSWORD")
		If Not BusinessDetails.disable_delivery.FldIsDetailKey Then BusinessDetails.disable_delivery.FormValue = ObjForm.GetValue("x_disable_delivery")
		BusinessDetails.disable_delivery.MultiUpdate = ObjForm.GetValue("u_disable_delivery")
		If Not BusinessDetails.disable_collection.FldIsDetailKey Then BusinessDetails.disable_collection.FormValue = ObjForm.GetValue("x_disable_collection")
		BusinessDetails.disable_collection.MultiUpdate = ObjForm.GetValue("u_disable_collection")
		If Not BusinessDetails.worldpay.FldIsDetailKey Then BusinessDetails.worldpay.FormValue = ObjForm.GetValue("x_worldpay")
		BusinessDetails.worldpay.MultiUpdate = ObjForm.GetValue("u_worldpay")
		If Not BusinessDetails.worldpaymerchantid.FldIsDetailKey Then BusinessDetails.worldpaymerchantid.FormValue = ObjForm.GetValue("x_worldpaymerchantid")
		BusinessDetails.worldpaymerchantid.MultiUpdate = ObjForm.GetValue("u_worldpaymerchantid")
		If Not BusinessDetails.backtohometext.FldIsDetailKey Then BusinessDetails.backtohometext.FormValue = ObjForm.GetValue("x_backtohometext")
		BusinessDetails.backtohometext.MultiUpdate = ObjForm.GetValue("u_backtohometext")
		If Not BusinessDetails.closedtext.FldIsDetailKey Then BusinessDetails.closedtext.FormValue = ObjForm.GetValue("x_closedtext")
		BusinessDetails.closedtext.MultiUpdate = ObjForm.GetValue("u_closedtext")
		If Not BusinessDetails.DeliveryChargeOverrideByOrderValue.FldIsDetailKey Then BusinessDetails.DeliveryChargeOverrideByOrderValue.FormValue = ObjForm.GetValue("x_DeliveryChargeOverrideByOrderValue")
		BusinessDetails.DeliveryChargeOverrideByOrderValue.MultiUpdate = ObjForm.GetValue("u_DeliveryChargeOverrideByOrderValue")
		If Not BusinessDetails.individualpostcodes.FldIsDetailKey Then BusinessDetails.individualpostcodes.FormValue = ObjForm.GetValue("x_individualpostcodes")
		BusinessDetails.individualpostcodes.MultiUpdate = ObjForm.GetValue("u_individualpostcodes")
		If Not BusinessDetails.individualpostcodeschecking.FldIsDetailKey Then BusinessDetails.individualpostcodeschecking.FormValue = ObjForm.GetValue("x_individualpostcodeschecking")
		BusinessDetails.individualpostcodeschecking.MultiUpdate = ObjForm.GetValue("u_individualpostcodeschecking")
		If Not BusinessDetails.longitude.FldIsDetailKey Then BusinessDetails.longitude.FormValue = ObjForm.GetValue("x_longitude")
		BusinessDetails.longitude.MultiUpdate = ObjForm.GetValue("u_longitude")
		If Not BusinessDetails.latitude.FldIsDetailKey Then BusinessDetails.latitude.FormValue = ObjForm.GetValue("x_latitude")
		BusinessDetails.latitude.MultiUpdate = ObjForm.GetValue("u_latitude")
		If Not BusinessDetails.googleecommercetracking.FldIsDetailKey Then BusinessDetails.googleecommercetracking.FormValue = ObjForm.GetValue("x_googleecommercetracking")
		BusinessDetails.googleecommercetracking.MultiUpdate = ObjForm.GetValue("u_googleecommercetracking")
		If Not BusinessDetails.googleecommercetrackingcode.FldIsDetailKey Then BusinessDetails.googleecommercetrackingcode.FormValue = ObjForm.GetValue("x_googleecommercetrackingcode")
		BusinessDetails.googleecommercetrackingcode.MultiUpdate = ObjForm.GetValue("u_googleecommercetrackingcode")
		If Not BusinessDetails.bringg.FldIsDetailKey Then BusinessDetails.bringg.FormValue = ObjForm.GetValue("x_bringg")
		BusinessDetails.bringg.MultiUpdate = ObjForm.GetValue("u_bringg")
		If Not BusinessDetails.bringgurl.FldIsDetailKey Then BusinessDetails.bringgurl.FormValue = ObjForm.GetValue("x_bringgurl")
		BusinessDetails.bringgurl.MultiUpdate = ObjForm.GetValue("u_bringgurl")
		If Not BusinessDetails.bringgcompanyid.FldIsDetailKey Then BusinessDetails.bringgcompanyid.FormValue = ObjForm.GetValue("x_bringgcompanyid")
		BusinessDetails.bringgcompanyid.MultiUpdate = ObjForm.GetValue("u_bringgcompanyid")
		If Not BusinessDetails.orderonlywhenopen.FldIsDetailKey Then BusinessDetails.orderonlywhenopen.FormValue = ObjForm.GetValue("x_orderonlywhenopen")
		BusinessDetails.orderonlywhenopen.MultiUpdate = ObjForm.GetValue("u_orderonlywhenopen")
		If Not BusinessDetails.disablelaterdelivery.FldIsDetailKey Then BusinessDetails.disablelaterdelivery.FormValue = ObjForm.GetValue("x_disablelaterdelivery")
		BusinessDetails.disablelaterdelivery.MultiUpdate = ObjForm.GetValue("u_disablelaterdelivery")
		If Not BusinessDetails.menupagetext.FldIsDetailKey Then BusinessDetails.menupagetext.FormValue = ObjForm.GetValue("x_menupagetext")
		BusinessDetails.menupagetext.MultiUpdate = ObjForm.GetValue("u_menupagetext")
		If Not BusinessDetails.ordertodayonly.FldIsDetailKey Then BusinessDetails.ordertodayonly.FormValue = ObjForm.GetValue("x_ordertodayonly")
		BusinessDetails.ordertodayonly.MultiUpdate = ObjForm.GetValue("u_ordertodayonly")
		If Not BusinessDetails.mileskm.FldIsDetailKey Then BusinessDetails.mileskm.FormValue = ObjForm.GetValue("x_mileskm")
		BusinessDetails.mileskm.MultiUpdate = ObjForm.GetValue("u_mileskm")
		If Not BusinessDetails.worldpaylive.FldIsDetailKey Then BusinessDetails.worldpaylive.FormValue = ObjForm.GetValue("x_worldpaylive")
		BusinessDetails.worldpaylive.MultiUpdate = ObjForm.GetValue("u_worldpaylive")
		If Not BusinessDetails.worldpayinstallationid.FldIsDetailKey Then BusinessDetails.worldpayinstallationid.FormValue = ObjForm.GetValue("x_worldpayinstallationid")
		BusinessDetails.worldpayinstallationid.MultiUpdate = ObjForm.GetValue("u_worldpayinstallationid")
		If Not BusinessDetails.DistanceCalMethod.FldIsDetailKey Then BusinessDetails.DistanceCalMethod.FormValue = ObjForm.GetValue("x_DistanceCalMethod")
		BusinessDetails.DistanceCalMethod.MultiUpdate = ObjForm.GetValue("u_DistanceCalMethod")
		If Not BusinessDetails.PrinterIDList.FldIsDetailKey Then BusinessDetails.PrinterIDList.FormValue = ObjForm.GetValue("x_PrinterIDList")
		BusinessDetails.PrinterIDList.MultiUpdate = ObjForm.GetValue("u_PrinterIDList")
		If Not BusinessDetails.EpsonJSPrinterURL.FldIsDetailKey Then BusinessDetails.EpsonJSPrinterURL.FormValue = ObjForm.GetValue("x_EpsonJSPrinterURL")
		BusinessDetails.EpsonJSPrinterURL.MultiUpdate = ObjForm.GetValue("u_EpsonJSPrinterURL")
		If Not BusinessDetails.SMSEnable.FldIsDetailKey Then BusinessDetails.SMSEnable.FormValue = ObjForm.GetValue("x_SMSEnable")
		BusinessDetails.SMSEnable.MultiUpdate = ObjForm.GetValue("u_SMSEnable")
		If Not BusinessDetails.SMSOnDelivery.FldIsDetailKey Then BusinessDetails.SMSOnDelivery.FormValue = ObjForm.GetValue("x_SMSOnDelivery")
		BusinessDetails.SMSOnDelivery.MultiUpdate = ObjForm.GetValue("u_SMSOnDelivery")
		If Not BusinessDetails.SMSSupplierDomain.FldIsDetailKey Then BusinessDetails.SMSSupplierDomain.FormValue = ObjForm.GetValue("x_SMSSupplierDomain")
		BusinessDetails.SMSSupplierDomain.MultiUpdate = ObjForm.GetValue("u_SMSSupplierDomain")
		If Not BusinessDetails.SMSOnOrder.FldIsDetailKey Then BusinessDetails.SMSOnOrder.FormValue = ObjForm.GetValue("x_SMSOnOrder")
		BusinessDetails.SMSOnOrder.MultiUpdate = ObjForm.GetValue("u_SMSOnOrder")
		If Not BusinessDetails.SMSOnOrderAfterMin.FldIsDetailKey Then BusinessDetails.SMSOnOrderAfterMin.FormValue = ObjForm.GetValue("x_SMSOnOrderAfterMin")
		BusinessDetails.SMSOnOrderAfterMin.MultiUpdate = ObjForm.GetValue("u_SMSOnOrderAfterMin")
		If Not BusinessDetails.SMSOnOrderContent.FldIsDetailKey Then BusinessDetails.SMSOnOrderContent.FormValue = ObjForm.GetValue("x_SMSOnOrderContent")
		BusinessDetails.SMSOnOrderContent.MultiUpdate = ObjForm.GetValue("u_SMSOnOrderContent")
		If Not BusinessDetails.DefaultSMSCountryCode.FldIsDetailKey Then BusinessDetails.DefaultSMSCountryCode.FormValue = ObjForm.GetValue("x_DefaultSMSCountryCode")
		BusinessDetails.DefaultSMSCountryCode.MultiUpdate = ObjForm.GetValue("u_DefaultSMSCountryCode")
		If Not BusinessDetails.MinimumAmountForCardPayment.FldIsDetailKey Then BusinessDetails.MinimumAmountForCardPayment.FormValue = ObjForm.GetValue("x_MinimumAmountForCardPayment")
		BusinessDetails.MinimumAmountForCardPayment.MultiUpdate = ObjForm.GetValue("u_MinimumAmountForCardPayment")
		If Not BusinessDetails.FavIconUrl.FldIsDetailKey Then BusinessDetails.FavIconUrl.FormValue = ObjForm.GetValue("x_FavIconUrl")
		BusinessDetails.FavIconUrl.MultiUpdate = ObjForm.GetValue("u_FavIconUrl")
		If Not BusinessDetails.AddToHomeScreenURL.FldIsDetailKey Then BusinessDetails.AddToHomeScreenURL.FormValue = ObjForm.GetValue("x_AddToHomeScreenURL")
		BusinessDetails.AddToHomeScreenURL.MultiUpdate = ObjForm.GetValue("u_AddToHomeScreenURL")
		If Not BusinessDetails.SMSOnAcknowledgement.FldIsDetailKey Then BusinessDetails.SMSOnAcknowledgement.FormValue = ObjForm.GetValue("x_SMSOnAcknowledgement")
		BusinessDetails.SMSOnAcknowledgement.MultiUpdate = ObjForm.GetValue("u_SMSOnAcknowledgement")
		If Not BusinessDetails.LocalPrinterURL.FldIsDetailKey Then BusinessDetails.LocalPrinterURL.FormValue = ObjForm.GetValue("x_LocalPrinterURL")
		BusinessDetails.LocalPrinterURL.MultiUpdate = ObjForm.GetValue("u_LocalPrinterURL")
		If Not BusinessDetails.ShowRestaurantDetailOnReceipt.FldIsDetailKey Then BusinessDetails.ShowRestaurantDetailOnReceipt.FormValue = ObjForm.GetValue("x_ShowRestaurantDetailOnReceipt")
		BusinessDetails.ShowRestaurantDetailOnReceipt.MultiUpdate = ObjForm.GetValue("u_ShowRestaurantDetailOnReceipt")
		If Not BusinessDetails.PrinterFontSizeRatio.FldIsDetailKey Then BusinessDetails.PrinterFontSizeRatio.FormValue = ObjForm.GetValue("x_PrinterFontSizeRatio")
		BusinessDetails.PrinterFontSizeRatio.MultiUpdate = ObjForm.GetValue("u_PrinterFontSizeRatio")
		If Not BusinessDetails.ServiceChargePercentage.FldIsDetailKey Then BusinessDetails.ServiceChargePercentage.FormValue = ObjForm.GetValue("x_ServiceChargePercentage")
		BusinessDetails.ServiceChargePercentage.MultiUpdate = ObjForm.GetValue("u_ServiceChargePercentage")
		If Not BusinessDetails.InRestaurantServiceChargeOnly.FldIsDetailKey Then BusinessDetails.InRestaurantServiceChargeOnly.FormValue = ObjForm.GetValue("x_InRestaurantServiceChargeOnly")
		BusinessDetails.InRestaurantServiceChargeOnly.MultiUpdate = ObjForm.GetValue("u_InRestaurantServiceChargeOnly")
		If Not BusinessDetails.IsDualReceiptPrinting.FldIsDetailKey Then BusinessDetails.IsDualReceiptPrinting.FormValue = ObjForm.GetValue("x_IsDualReceiptPrinting")
		BusinessDetails.IsDualReceiptPrinting.MultiUpdate = ObjForm.GetValue("u_IsDualReceiptPrinting")
		If Not BusinessDetails.PrintingFontSize.FldIsDetailKey Then BusinessDetails.PrintingFontSize.FormValue = ObjForm.GetValue("x_PrintingFontSize")
		BusinessDetails.PrintingFontSize.MultiUpdate = ObjForm.GetValue("u_PrintingFontSize")
		If Not BusinessDetails.InRestaurantEpsonPrinterIDList.FldIsDetailKey Then BusinessDetails.InRestaurantEpsonPrinterIDList.FormValue = ObjForm.GetValue("x_InRestaurantEpsonPrinterIDList")
		BusinessDetails.InRestaurantEpsonPrinterIDList.MultiUpdate = ObjForm.GetValue("u_InRestaurantEpsonPrinterIDList")
		If Not BusinessDetails.BlockIPEmailList.FldIsDetailKey Then BusinessDetails.BlockIPEmailList.FormValue = ObjForm.GetValue("x_BlockIPEmailList")
		BusinessDetails.BlockIPEmailList.MultiUpdate = ObjForm.GetValue("u_BlockIPEmailList")
		If Not BusinessDetails.inmenuannouncement.FldIsDetailKey Then BusinessDetails.inmenuannouncement.FormValue = ObjForm.GetValue("x_inmenuannouncement")
		BusinessDetails.inmenuannouncement.MultiUpdate = ObjForm.GetValue("u_inmenuannouncement")
		If Not BusinessDetails.RePrintReceiptWays.FldIsDetailKey Then BusinessDetails.RePrintReceiptWays.FormValue = ObjForm.GetValue("x_RePrintReceiptWays")
		BusinessDetails.RePrintReceiptWays.MultiUpdate = ObjForm.GetValue("u_RePrintReceiptWays")
		If Not BusinessDetails.printingtype.FldIsDetailKey Then BusinessDetails.printingtype.FormValue = ObjForm.GetValue("x_printingtype")
		BusinessDetails.printingtype.MultiUpdate = ObjForm.GetValue("u_printingtype")
		If Not BusinessDetails.Stripe_Key_Secret.FldIsDetailKey Then BusinessDetails.Stripe_Key_Secret.FormValue = ObjForm.GetValue("x_Stripe_Key_Secret")
		BusinessDetails.Stripe_Key_Secret.MultiUpdate = ObjForm.GetValue("u_Stripe_Key_Secret")
		If Not BusinessDetails.Stripe.FldIsDetailKey Then BusinessDetails.Stripe.FormValue = ObjForm.GetValue("x_Stripe")
		BusinessDetails.Stripe.MultiUpdate = ObjForm.GetValue("u_Stripe")
		If Not BusinessDetails.Stripe_Api_Key.FldIsDetailKey Then BusinessDetails.Stripe_Api_Key.FormValue = ObjForm.GetValue("x_Stripe_Api_Key")
		BusinessDetails.Stripe_Api_Key.MultiUpdate = ObjForm.GetValue("u_Stripe_Api_Key")
		If Not BusinessDetails.EnableBooking.FldIsDetailKey Then BusinessDetails.EnableBooking.FormValue = ObjForm.GetValue("x_EnableBooking")
		BusinessDetails.EnableBooking.MultiUpdate = ObjForm.GetValue("u_EnableBooking")
		If Not BusinessDetails.URL_Facebook.FldIsDetailKey Then BusinessDetails.URL_Facebook.FormValue = ObjForm.GetValue("x_URL_Facebook")
		BusinessDetails.URL_Facebook.MultiUpdate = ObjForm.GetValue("u_URL_Facebook")
		If Not BusinessDetails.URL_Twitter.FldIsDetailKey Then BusinessDetails.URL_Twitter.FormValue = ObjForm.GetValue("x_URL_Twitter")
		BusinessDetails.URL_Twitter.MultiUpdate = ObjForm.GetValue("u_URL_Twitter")
		If Not BusinessDetails.URL_Google.FldIsDetailKey Then BusinessDetails.URL_Google.FormValue = ObjForm.GetValue("x_URL_Google")
		BusinessDetails.URL_Google.MultiUpdate = ObjForm.GetValue("u_URL_Google")
		If Not BusinessDetails.URL_Intagram.FldIsDetailKey Then BusinessDetails.URL_Intagram.FormValue = ObjForm.GetValue("x_URL_Intagram")
		BusinessDetails.URL_Intagram.MultiUpdate = ObjForm.GetValue("u_URL_Intagram")
		If Not BusinessDetails.URL_YouTube.FldIsDetailKey Then BusinessDetails.URL_YouTube.FormValue = ObjForm.GetValue("x_URL_YouTube")
		BusinessDetails.URL_YouTube.MultiUpdate = ObjForm.GetValue("u_URL_YouTube")
		If Not BusinessDetails.URL_Tripadvisor.FldIsDetailKey Then BusinessDetails.URL_Tripadvisor.FormValue = ObjForm.GetValue("x_URL_Tripadvisor")
		BusinessDetails.URL_Tripadvisor.MultiUpdate = ObjForm.GetValue("u_URL_Tripadvisor")
		If Not BusinessDetails.URL_Special_Offer.FldIsDetailKey Then BusinessDetails.URL_Special_Offer.FormValue = ObjForm.GetValue("x_URL_Special_Offer")
		BusinessDetails.URL_Special_Offer.MultiUpdate = ObjForm.GetValue("u_URL_Special_Offer")
		If Not BusinessDetails.URL_Linkin.FldIsDetailKey Then BusinessDetails.URL_Linkin.FormValue = ObjForm.GetValue("x_URL_Linkin")
		BusinessDetails.URL_Linkin.MultiUpdate = ObjForm.GetValue("u_URL_Linkin")
		If Not BusinessDetails.Currency_PAYPAL.FldIsDetailKey Then BusinessDetails.Currency_PAYPAL.FormValue = ObjForm.GetValue("x_Currency_PAYPAL")
		BusinessDetails.Currency_PAYPAL.MultiUpdate = ObjForm.GetValue("u_Currency_PAYPAL")
		If Not BusinessDetails.Currency_STRIPE.FldIsDetailKey Then BusinessDetails.Currency_STRIPE.FormValue = ObjForm.GetValue("x_Currency_STRIPE")
		BusinessDetails.Currency_STRIPE.MultiUpdate = ObjForm.GetValue("u_Currency_STRIPE")
		If Not BusinessDetails.Currency_WOLRDPAY.FldIsDetailKey Then BusinessDetails.Currency_WOLRDPAY.FormValue = ObjForm.GetValue("x_Currency_WOLRDPAY")
		BusinessDetails.Currency_WOLRDPAY.MultiUpdate = ObjForm.GetValue("u_Currency_WOLRDPAY")
		If Not BusinessDetails.Tip_percent.FldIsDetailKey Then BusinessDetails.Tip_percent.FormValue = ObjForm.GetValue("x_Tip_percent")
		BusinessDetails.Tip_percent.MultiUpdate = ObjForm.GetValue("u_Tip_percent")
		If Not BusinessDetails.Tax_Percent.FldIsDetailKey Then BusinessDetails.Tax_Percent.FormValue = ObjForm.GetValue("x_Tax_Percent")
		BusinessDetails.Tax_Percent.MultiUpdate = ObjForm.GetValue("u_Tax_Percent")
		If Not BusinessDetails.InRestaurantTaxChargeOnly.FldIsDetailKey Then BusinessDetails.InRestaurantTaxChargeOnly.FormValue = ObjForm.GetValue("x_InRestaurantTaxChargeOnly")
		BusinessDetails.InRestaurantTaxChargeOnly.MultiUpdate = ObjForm.GetValue("u_InRestaurantTaxChargeOnly")
		If Not BusinessDetails.InRestaurantTipChargeOnly.FldIsDetailKey Then BusinessDetails.InRestaurantTipChargeOnly.FormValue = ObjForm.GetValue("x_InRestaurantTipChargeOnly")
		BusinessDetails.InRestaurantTipChargeOnly.MultiUpdate = ObjForm.GetValue("u_InRestaurantTipChargeOnly")
		If Not BusinessDetails.isCheckCapcha.FldIsDetailKey Then BusinessDetails.isCheckCapcha.FormValue = ObjForm.GetValue("x_isCheckCapcha")
		BusinessDetails.isCheckCapcha.MultiUpdate = ObjForm.GetValue("u_isCheckCapcha")
		If Not BusinessDetails.Close_StartDate.FldIsDetailKey Then BusinessDetails.Close_StartDate.FormValue = ObjForm.GetValue("x_Close_StartDate")
		BusinessDetails.Close_StartDate.MultiUpdate = ObjForm.GetValue("u_Close_StartDate")
		If Not BusinessDetails.Close_EndDate.FldIsDetailKey Then BusinessDetails.Close_EndDate.FormValue = ObjForm.GetValue("x_Close_EndDate")
		BusinessDetails.Close_EndDate.MultiUpdate = ObjForm.GetValue("u_Close_EndDate")
		If Not BusinessDetails.Stripe_Country.FldIsDetailKey Then BusinessDetails.Stripe_Country.FormValue = ObjForm.GetValue("x_Stripe_Country")
		BusinessDetails.Stripe_Country.MultiUpdate = ObjForm.GetValue("u_Stripe_Country")
		If Not BusinessDetails.enable_StripePaymentButton.FldIsDetailKey Then BusinessDetails.enable_StripePaymentButton.FormValue = ObjForm.GetValue("x_enable_StripePaymentButton")
		BusinessDetails.enable_StripePaymentButton.MultiUpdate = ObjForm.GetValue("u_enable_StripePaymentButton")
		If Not BusinessDetails.enable_CashPayment.FldIsDetailKey Then BusinessDetails.enable_CashPayment.FormValue = ObjForm.GetValue("x_enable_CashPayment")
		BusinessDetails.enable_CashPayment.MultiUpdate = ObjForm.GetValue("u_enable_CashPayment")
		If Not BusinessDetails.DeliveryMile.FldIsDetailKey Then BusinessDetails.DeliveryMile.FormValue = ObjForm.GetValue("x_DeliveryMile")
		BusinessDetails.DeliveryMile.MultiUpdate = ObjForm.GetValue("u_DeliveryMile")
		If Not BusinessDetails.Mon_Delivery.FldIsDetailKey Then BusinessDetails.Mon_Delivery.FormValue = ObjForm.GetValue("x_Mon_Delivery")
		BusinessDetails.Mon_Delivery.MultiUpdate = ObjForm.GetValue("u_Mon_Delivery")
		If Not BusinessDetails.Mon_Collection.FldIsDetailKey Then BusinessDetails.Mon_Collection.FormValue = ObjForm.GetValue("x_Mon_Collection")
		BusinessDetails.Mon_Collection.MultiUpdate = ObjForm.GetValue("u_Mon_Collection")
		If Not BusinessDetails.Tue_Delivery.FldIsDetailKey Then BusinessDetails.Tue_Delivery.FormValue = ObjForm.GetValue("x_Tue_Delivery")
		BusinessDetails.Tue_Delivery.MultiUpdate = ObjForm.GetValue("u_Tue_Delivery")
		If Not BusinessDetails.Tue_Collection.FldIsDetailKey Then BusinessDetails.Tue_Collection.FormValue = ObjForm.GetValue("x_Tue_Collection")
		BusinessDetails.Tue_Collection.MultiUpdate = ObjForm.GetValue("u_Tue_Collection")
		If Not BusinessDetails.Wed_Delivery.FldIsDetailKey Then BusinessDetails.Wed_Delivery.FormValue = ObjForm.GetValue("x_Wed_Delivery")
		BusinessDetails.Wed_Delivery.MultiUpdate = ObjForm.GetValue("u_Wed_Delivery")
		If Not BusinessDetails.Wed_Collection.FldIsDetailKey Then BusinessDetails.Wed_Collection.FormValue = ObjForm.GetValue("x_Wed_Collection")
		BusinessDetails.Wed_Collection.MultiUpdate = ObjForm.GetValue("u_Wed_Collection")
		If Not BusinessDetails.Thu_Delivery.FldIsDetailKey Then BusinessDetails.Thu_Delivery.FormValue = ObjForm.GetValue("x_Thu_Delivery")
		BusinessDetails.Thu_Delivery.MultiUpdate = ObjForm.GetValue("u_Thu_Delivery")
		If Not BusinessDetails.Thu_Collection.FldIsDetailKey Then BusinessDetails.Thu_Collection.FormValue = ObjForm.GetValue("x_Thu_Collection")
		BusinessDetails.Thu_Collection.MultiUpdate = ObjForm.GetValue("u_Thu_Collection")
		If Not BusinessDetails.Fri_Delivery.FldIsDetailKey Then BusinessDetails.Fri_Delivery.FormValue = ObjForm.GetValue("x_Fri_Delivery")
		BusinessDetails.Fri_Delivery.MultiUpdate = ObjForm.GetValue("u_Fri_Delivery")
		If Not BusinessDetails.Fri_Collection.FldIsDetailKey Then BusinessDetails.Fri_Collection.FormValue = ObjForm.GetValue("x_Fri_Collection")
		BusinessDetails.Fri_Collection.MultiUpdate = ObjForm.GetValue("u_Fri_Collection")
		If Not BusinessDetails.Sat_Delivery.FldIsDetailKey Then BusinessDetails.Sat_Delivery.FormValue = ObjForm.GetValue("x_Sat_Delivery")
		BusinessDetails.Sat_Delivery.MultiUpdate = ObjForm.GetValue("u_Sat_Delivery")
		If Not BusinessDetails.Sat_Collection.FldIsDetailKey Then BusinessDetails.Sat_Collection.FormValue = ObjForm.GetValue("x_Sat_Collection")
		BusinessDetails.Sat_Collection.MultiUpdate = ObjForm.GetValue("u_Sat_Collection")
		If Not BusinessDetails.Sun_Delivery.FldIsDetailKey Then BusinessDetails.Sun_Delivery.FormValue = ObjForm.GetValue("x_Sun_Delivery")
		BusinessDetails.Sun_Delivery.MultiUpdate = ObjForm.GetValue("u_Sun_Delivery")
		If Not BusinessDetails.Sun_Collection.FldIsDetailKey Then BusinessDetails.Sun_Collection.FormValue = ObjForm.GetValue("x_Sun_Collection")
		BusinessDetails.Sun_Collection.MultiUpdate = ObjForm.GetValue("u_Sun_Collection")
		If Not BusinessDetails.EnableUrlRewrite.FldIsDetailKey Then BusinessDetails.EnableUrlRewrite.FormValue = ObjForm.GetValue("x_EnableUrlRewrite")
		BusinessDetails.EnableUrlRewrite.MultiUpdate = ObjForm.GetValue("u_EnableUrlRewrite")
		If Not BusinessDetails.DeliveryCostUpTo.FldIsDetailKey Then BusinessDetails.DeliveryCostUpTo.FormValue = ObjForm.GetValue("x_DeliveryCostUpTo")
		BusinessDetails.DeliveryCostUpTo.MultiUpdate = ObjForm.GetValue("u_DeliveryCostUpTo")
		If Not BusinessDetails.DeliveryUptoMile.FldIsDetailKey Then BusinessDetails.DeliveryUptoMile.FormValue = ObjForm.GetValue("x_DeliveryUptoMile")
		BusinessDetails.DeliveryUptoMile.MultiUpdate = ObjForm.GetValue("u_DeliveryUptoMile")
		If Not BusinessDetails.Show_Ordernumner_printer.FldIsDetailKey Then BusinessDetails.Show_Ordernumner_printer.FormValue = ObjForm.GetValue("x_Show_Ordernumner_printer")
		BusinessDetails.Show_Ordernumner_printer.MultiUpdate = ObjForm.GetValue("u_Show_Ordernumner_printer")
		If Not BusinessDetails.Show_Ordernumner_Receipt.FldIsDetailKey Then BusinessDetails.Show_Ordernumner_Receipt.FormValue = ObjForm.GetValue("x_Show_Ordernumner_Receipt")
		BusinessDetails.Show_Ordernumner_Receipt.MultiUpdate = ObjForm.GetValue("u_Show_Ordernumner_Receipt")
		If Not BusinessDetails.Show_Ordernumner_Dashboard.FldIsDetailKey Then BusinessDetails.Show_Ordernumner_Dashboard.FormValue = ObjForm.GetValue("x_Show_Ordernumner_Dashboard")
		BusinessDetails.Show_Ordernumner_Dashboard.MultiUpdate = ObjForm.GetValue("u_Show_Ordernumner_Dashboard")
		If Not BusinessDetails.ID.FldIsDetailKey Then BusinessDetails.ID.FormValue = ObjForm.GetValue("x_ID")
	End Function

	' -----------------------------------------------------------------
	' Restore form values
	'
	Function RestoreFormValues()
		BusinessDetails.Name.CurrentValue = BusinessDetails.Name.FormValue
		BusinessDetails.Address.CurrentValue = BusinessDetails.Address.FormValue
		BusinessDetails.PostalCode.CurrentValue = BusinessDetails.PostalCode.FormValue
		BusinessDetails.FoodType.CurrentValue = BusinessDetails.FoodType.FormValue
		BusinessDetails.DeliveryMinAmount.CurrentValue = BusinessDetails.DeliveryMinAmount.FormValue
		BusinessDetails.DeliveryMaxDistance.CurrentValue = BusinessDetails.DeliveryMaxDistance.FormValue
		BusinessDetails.DeliveryFreeDistance.CurrentValue = BusinessDetails.DeliveryFreeDistance.FormValue
		BusinessDetails.AverageDeliveryTime.CurrentValue = BusinessDetails.AverageDeliveryTime.FormValue
		BusinessDetails.AverageCollectionTime.CurrentValue = BusinessDetails.AverageCollectionTime.FormValue
		BusinessDetails.DeliveryFee.CurrentValue = BusinessDetails.DeliveryFee.FormValue
		BusinessDetails.ImgUrl.CurrentValue = BusinessDetails.ImgUrl.FormValue
		BusinessDetails.Telephone.CurrentValue = BusinessDetails.Telephone.FormValue
		BusinessDetails.zEmail.CurrentValue = BusinessDetails.zEmail.FormValue
		BusinessDetails.pswd.CurrentValue = BusinessDetails.pswd.FormValue
		BusinessDetails.businessclosed.CurrentValue = BusinessDetails.businessclosed.FormValue
		BusinessDetails.announcement.CurrentValue = BusinessDetails.announcement.FormValue
		BusinessDetails.css.CurrentValue = BusinessDetails.css.FormValue
		BusinessDetails.SMTP_AUTENTICATE.CurrentValue = BusinessDetails.SMTP_AUTENTICATE.FormValue
		BusinessDetails.MAIL_FROM.CurrentValue = BusinessDetails.MAIL_FROM.FormValue
		BusinessDetails.PAYPAL_URL.CurrentValue = BusinessDetails.PAYPAL_URL.FormValue
		BusinessDetails.PAYPAL_PDT.CurrentValue = BusinessDetails.PAYPAL_PDT.FormValue
		BusinessDetails.SMTP_PASSWORD.CurrentValue = BusinessDetails.SMTP_PASSWORD.FormValue
		BusinessDetails.GMAP_API_KEY.CurrentValue = BusinessDetails.GMAP_API_KEY.FormValue
		BusinessDetails.SMTP_USERNAME.CurrentValue = BusinessDetails.SMTP_USERNAME.FormValue
		BusinessDetails.SMTP_USESSL.CurrentValue = BusinessDetails.SMTP_USESSL.FormValue
		BusinessDetails.MAIL_SUBJECT.CurrentValue = BusinessDetails.MAIL_SUBJECT.FormValue
		BusinessDetails.CURRENCYSYMBOL.CurrentValue = BusinessDetails.CURRENCYSYMBOL.FormValue
		BusinessDetails.SMTP_SERVER.CurrentValue = BusinessDetails.SMTP_SERVER.FormValue
		BusinessDetails.CREDITCARDSURCHARGE.CurrentValue = BusinessDetails.CREDITCARDSURCHARGE.FormValue
		BusinessDetails.SMTP_PORT.CurrentValue = BusinessDetails.SMTP_PORT.FormValue
		BusinessDetails.STICK_MENU.CurrentValue = BusinessDetails.STICK_MENU.FormValue
		BusinessDetails.MAIL_CUSTOMER_SUBJECT.CurrentValue = BusinessDetails.MAIL_CUSTOMER_SUBJECT.FormValue
		BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.CurrentValue = BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.FormValue
		BusinessDetails.SEND_ORDERS_TO_PRINTER.CurrentValue = BusinessDetails.SEND_ORDERS_TO_PRINTER.FormValue
		BusinessDetails.timezone.CurrentValue = BusinessDetails.timezone.FormValue
		BusinessDetails.PAYPAL_ADDR.CurrentValue = BusinessDetails.PAYPAL_ADDR.FormValue
		BusinessDetails.nochex.CurrentValue = BusinessDetails.nochex.FormValue
		BusinessDetails.nochexmerchantid.CurrentValue = BusinessDetails.nochexmerchantid.FormValue
		BusinessDetails.paypal.CurrentValue = BusinessDetails.paypal.FormValue
		BusinessDetails.IBT_API_KEY.CurrentValue = BusinessDetails.IBT_API_KEY.FormValue
		BusinessDetails.IBP_API_PASSWORD.CurrentValue = BusinessDetails.IBP_API_PASSWORD.FormValue
		BusinessDetails.disable_delivery.CurrentValue = BusinessDetails.disable_delivery.FormValue
		BusinessDetails.disable_collection.CurrentValue = BusinessDetails.disable_collection.FormValue
		BusinessDetails.worldpay.CurrentValue = BusinessDetails.worldpay.FormValue
		BusinessDetails.worldpaymerchantid.CurrentValue = BusinessDetails.worldpaymerchantid.FormValue
		BusinessDetails.backtohometext.CurrentValue = BusinessDetails.backtohometext.FormValue
		BusinessDetails.closedtext.CurrentValue = BusinessDetails.closedtext.FormValue
		BusinessDetails.DeliveryChargeOverrideByOrderValue.CurrentValue = BusinessDetails.DeliveryChargeOverrideByOrderValue.FormValue
		BusinessDetails.individualpostcodes.CurrentValue = BusinessDetails.individualpostcodes.FormValue
		BusinessDetails.individualpostcodeschecking.CurrentValue = BusinessDetails.individualpostcodeschecking.FormValue
		BusinessDetails.longitude.CurrentValue = BusinessDetails.longitude.FormValue
		BusinessDetails.latitude.CurrentValue = BusinessDetails.latitude.FormValue
		BusinessDetails.googleecommercetracking.CurrentValue = BusinessDetails.googleecommercetracking.FormValue
		BusinessDetails.googleecommercetrackingcode.CurrentValue = BusinessDetails.googleecommercetrackingcode.FormValue
		BusinessDetails.bringg.CurrentValue = BusinessDetails.bringg.FormValue
		BusinessDetails.bringgurl.CurrentValue = BusinessDetails.bringgurl.FormValue
		BusinessDetails.bringgcompanyid.CurrentValue = BusinessDetails.bringgcompanyid.FormValue
		BusinessDetails.orderonlywhenopen.CurrentValue = BusinessDetails.orderonlywhenopen.FormValue
		BusinessDetails.disablelaterdelivery.CurrentValue = BusinessDetails.disablelaterdelivery.FormValue
		BusinessDetails.menupagetext.CurrentValue = BusinessDetails.menupagetext.FormValue
		BusinessDetails.ordertodayonly.CurrentValue = BusinessDetails.ordertodayonly.FormValue
		BusinessDetails.mileskm.CurrentValue = BusinessDetails.mileskm.FormValue
		BusinessDetails.worldpaylive.CurrentValue = BusinessDetails.worldpaylive.FormValue
		BusinessDetails.worldpayinstallationid.CurrentValue = BusinessDetails.worldpayinstallationid.FormValue
		BusinessDetails.DistanceCalMethod.CurrentValue = BusinessDetails.DistanceCalMethod.FormValue
		BusinessDetails.PrinterIDList.CurrentValue = BusinessDetails.PrinterIDList.FormValue
		BusinessDetails.EpsonJSPrinterURL.CurrentValue = BusinessDetails.EpsonJSPrinterURL.FormValue
		BusinessDetails.SMSEnable.CurrentValue = BusinessDetails.SMSEnable.FormValue
		BusinessDetails.SMSOnDelivery.CurrentValue = BusinessDetails.SMSOnDelivery.FormValue
		BusinessDetails.SMSSupplierDomain.CurrentValue = BusinessDetails.SMSSupplierDomain.FormValue
		BusinessDetails.SMSOnOrder.CurrentValue = BusinessDetails.SMSOnOrder.FormValue
		BusinessDetails.SMSOnOrderAfterMin.CurrentValue = BusinessDetails.SMSOnOrderAfterMin.FormValue
		BusinessDetails.SMSOnOrderContent.CurrentValue = BusinessDetails.SMSOnOrderContent.FormValue
		BusinessDetails.DefaultSMSCountryCode.CurrentValue = BusinessDetails.DefaultSMSCountryCode.FormValue
		BusinessDetails.MinimumAmountForCardPayment.CurrentValue = BusinessDetails.MinimumAmountForCardPayment.FormValue
		BusinessDetails.FavIconUrl.CurrentValue = BusinessDetails.FavIconUrl.FormValue
		BusinessDetails.AddToHomeScreenURL.CurrentValue = BusinessDetails.AddToHomeScreenURL.FormValue
		BusinessDetails.SMSOnAcknowledgement.CurrentValue = BusinessDetails.SMSOnAcknowledgement.FormValue
		BusinessDetails.LocalPrinterURL.CurrentValue = BusinessDetails.LocalPrinterURL.FormValue
		BusinessDetails.ShowRestaurantDetailOnReceipt.CurrentValue = BusinessDetails.ShowRestaurantDetailOnReceipt.FormValue
		BusinessDetails.PrinterFontSizeRatio.CurrentValue = BusinessDetails.PrinterFontSizeRatio.FormValue
		BusinessDetails.ServiceChargePercentage.CurrentValue = BusinessDetails.ServiceChargePercentage.FormValue
		BusinessDetails.InRestaurantServiceChargeOnly.CurrentValue = BusinessDetails.InRestaurantServiceChargeOnly.FormValue
		BusinessDetails.IsDualReceiptPrinting.CurrentValue = BusinessDetails.IsDualReceiptPrinting.FormValue
		BusinessDetails.PrintingFontSize.CurrentValue = BusinessDetails.PrintingFontSize.FormValue
		BusinessDetails.InRestaurantEpsonPrinterIDList.CurrentValue = BusinessDetails.InRestaurantEpsonPrinterIDList.FormValue
		BusinessDetails.BlockIPEmailList.CurrentValue = BusinessDetails.BlockIPEmailList.FormValue
		BusinessDetails.inmenuannouncement.CurrentValue = BusinessDetails.inmenuannouncement.FormValue
		BusinessDetails.RePrintReceiptWays.CurrentValue = BusinessDetails.RePrintReceiptWays.FormValue
		BusinessDetails.printingtype.CurrentValue = BusinessDetails.printingtype.FormValue
		BusinessDetails.Stripe_Key_Secret.CurrentValue = BusinessDetails.Stripe_Key_Secret.FormValue
		BusinessDetails.Stripe.CurrentValue = BusinessDetails.Stripe.FormValue
		BusinessDetails.Stripe_Api_Key.CurrentValue = BusinessDetails.Stripe_Api_Key.FormValue
		BusinessDetails.EnableBooking.CurrentValue = BusinessDetails.EnableBooking.FormValue
		BusinessDetails.URL_Facebook.CurrentValue = BusinessDetails.URL_Facebook.FormValue
		BusinessDetails.URL_Twitter.CurrentValue = BusinessDetails.URL_Twitter.FormValue
		BusinessDetails.URL_Google.CurrentValue = BusinessDetails.URL_Google.FormValue
		BusinessDetails.URL_Intagram.CurrentValue = BusinessDetails.URL_Intagram.FormValue
		BusinessDetails.URL_YouTube.CurrentValue = BusinessDetails.URL_YouTube.FormValue
		BusinessDetails.URL_Tripadvisor.CurrentValue = BusinessDetails.URL_Tripadvisor.FormValue
		BusinessDetails.URL_Special_Offer.CurrentValue = BusinessDetails.URL_Special_Offer.FormValue
		BusinessDetails.URL_Linkin.CurrentValue = BusinessDetails.URL_Linkin.FormValue
		BusinessDetails.Currency_PAYPAL.CurrentValue = BusinessDetails.Currency_PAYPAL.FormValue
		BusinessDetails.Currency_STRIPE.CurrentValue = BusinessDetails.Currency_STRIPE.FormValue
		BusinessDetails.Currency_WOLRDPAY.CurrentValue = BusinessDetails.Currency_WOLRDPAY.FormValue
		BusinessDetails.Tip_percent.CurrentValue = BusinessDetails.Tip_percent.FormValue
		BusinessDetails.Tax_Percent.CurrentValue = BusinessDetails.Tax_Percent.FormValue
		BusinessDetails.InRestaurantTaxChargeOnly.CurrentValue = BusinessDetails.InRestaurantTaxChargeOnly.FormValue
		BusinessDetails.InRestaurantTipChargeOnly.CurrentValue = BusinessDetails.InRestaurantTipChargeOnly.FormValue
		BusinessDetails.isCheckCapcha.CurrentValue = BusinessDetails.isCheckCapcha.FormValue
		BusinessDetails.Close_StartDate.CurrentValue = BusinessDetails.Close_StartDate.FormValue
		BusinessDetails.Close_EndDate.CurrentValue = BusinessDetails.Close_EndDate.FormValue
		BusinessDetails.Stripe_Country.CurrentValue = BusinessDetails.Stripe_Country.FormValue
		BusinessDetails.enable_StripePaymentButton.CurrentValue = BusinessDetails.enable_StripePaymentButton.FormValue
		BusinessDetails.enable_CashPayment.CurrentValue = BusinessDetails.enable_CashPayment.FormValue
		BusinessDetails.DeliveryMile.CurrentValue = BusinessDetails.DeliveryMile.FormValue
		BusinessDetails.Mon_Delivery.CurrentValue = BusinessDetails.Mon_Delivery.FormValue
		BusinessDetails.Mon_Collection.CurrentValue = BusinessDetails.Mon_Collection.FormValue
		BusinessDetails.Tue_Delivery.CurrentValue = BusinessDetails.Tue_Delivery.FormValue
		BusinessDetails.Tue_Collection.CurrentValue = BusinessDetails.Tue_Collection.FormValue
		BusinessDetails.Wed_Delivery.CurrentValue = BusinessDetails.Wed_Delivery.FormValue
		BusinessDetails.Wed_Collection.CurrentValue = BusinessDetails.Wed_Collection.FormValue
		BusinessDetails.Thu_Delivery.CurrentValue = BusinessDetails.Thu_Delivery.FormValue
		BusinessDetails.Thu_Collection.CurrentValue = BusinessDetails.Thu_Collection.FormValue
		BusinessDetails.Fri_Delivery.CurrentValue = BusinessDetails.Fri_Delivery.FormValue
		BusinessDetails.Fri_Collection.CurrentValue = BusinessDetails.Fri_Collection.FormValue
		BusinessDetails.Sat_Delivery.CurrentValue = BusinessDetails.Sat_Delivery.FormValue
		BusinessDetails.Sat_Collection.CurrentValue = BusinessDetails.Sat_Collection.FormValue
		BusinessDetails.Sun_Delivery.CurrentValue = BusinessDetails.Sun_Delivery.FormValue
		BusinessDetails.Sun_Collection.CurrentValue = BusinessDetails.Sun_Collection.FormValue
		BusinessDetails.EnableUrlRewrite.CurrentValue = BusinessDetails.EnableUrlRewrite.FormValue
		BusinessDetails.DeliveryCostUpTo.CurrentValue = BusinessDetails.DeliveryCostUpTo.FormValue
		BusinessDetails.DeliveryUptoMile.CurrentValue = BusinessDetails.DeliveryUptoMile.FormValue
		BusinessDetails.Show_Ordernumner_printer.CurrentValue = BusinessDetails.Show_Ordernumner_printer.FormValue
		BusinessDetails.Show_Ordernumner_Receipt.CurrentValue = BusinessDetails.Show_Ordernumner_Receipt.FormValue
		BusinessDetails.Show_Ordernumner_Dashboard.CurrentValue = BusinessDetails.Show_Ordernumner_Dashboard.FormValue
		BusinessDetails.ID.CurrentValue = BusinessDetails.ID.FormValue
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

	' -----------------------------------------------------------------
	' Render row values based on field settings
	'
	Sub RenderRow()

		' Initialize urls
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

			' announcement
			BusinessDetails.announcement.ViewValue = BusinessDetails.announcement.CurrentValue
			BusinessDetails.announcement.ViewCustomAttributes = ""

			' css
			BusinessDetails.css.ViewValue = BusinessDetails.css.CurrentValue
			BusinessDetails.css.ViewCustomAttributes = ""

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

			' backtohometext
			BusinessDetails.backtohometext.ViewValue = BusinessDetails.backtohometext.CurrentValue
			BusinessDetails.backtohometext.ViewCustomAttributes = ""

			' closedtext
			BusinessDetails.closedtext.ViewValue = BusinessDetails.closedtext.CurrentValue
			BusinessDetails.closedtext.ViewCustomAttributes = ""

			' DeliveryChargeOverrideByOrderValue
			BusinessDetails.DeliveryChargeOverrideByOrderValue.ViewValue = BusinessDetails.DeliveryChargeOverrideByOrderValue.CurrentValue
			BusinessDetails.DeliveryChargeOverrideByOrderValue.ViewCustomAttributes = ""

			' individualpostcodes
			BusinessDetails.individualpostcodes.ViewValue = BusinessDetails.individualpostcodes.CurrentValue
			BusinessDetails.individualpostcodes.ViewCustomAttributes = ""

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

			' menupagetext
			BusinessDetails.menupagetext.ViewValue = BusinessDetails.menupagetext.CurrentValue
			BusinessDetails.menupagetext.ViewCustomAttributes = ""

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

			' inmenuannouncement
			BusinessDetails.inmenuannouncement.ViewValue = BusinessDetails.inmenuannouncement.CurrentValue
			BusinessDetails.inmenuannouncement.ViewCustomAttributes = ""

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

			' announcement
			BusinessDetails.announcement.LinkCustomAttributes = ""
			BusinessDetails.announcement.HrefValue = ""
			BusinessDetails.announcement.TooltipValue = ""

			' css
			BusinessDetails.css.LinkCustomAttributes = ""
			BusinessDetails.css.HrefValue = ""
			BusinessDetails.css.TooltipValue = ""

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

			' backtohometext
			BusinessDetails.backtohometext.LinkCustomAttributes = ""
			BusinessDetails.backtohometext.HrefValue = ""
			BusinessDetails.backtohometext.TooltipValue = ""

			' closedtext
			BusinessDetails.closedtext.LinkCustomAttributes = ""
			BusinessDetails.closedtext.HrefValue = ""
			BusinessDetails.closedtext.TooltipValue = ""

			' DeliveryChargeOverrideByOrderValue
			BusinessDetails.DeliveryChargeOverrideByOrderValue.LinkCustomAttributes = ""
			BusinessDetails.DeliveryChargeOverrideByOrderValue.HrefValue = ""
			BusinessDetails.DeliveryChargeOverrideByOrderValue.TooltipValue = ""

			' individualpostcodes
			BusinessDetails.individualpostcodes.LinkCustomAttributes = ""
			BusinessDetails.individualpostcodes.HrefValue = ""
			BusinessDetails.individualpostcodes.TooltipValue = ""

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

			' menupagetext
			BusinessDetails.menupagetext.LinkCustomAttributes = ""
			BusinessDetails.menupagetext.HrefValue = ""
			BusinessDetails.menupagetext.TooltipValue = ""

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

			' inmenuannouncement
			BusinessDetails.inmenuannouncement.LinkCustomAttributes = ""
			BusinessDetails.inmenuannouncement.HrefValue = ""
			BusinessDetails.inmenuannouncement.TooltipValue = ""

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

		' ----------
		'  Edit Row
		' ----------

		ElseIf BusinessDetails.RowType = EW_ROWTYPE_EDIT Then ' Edit row

			' Name
			BusinessDetails.Name.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Name.EditCustomAttributes = ""
			BusinessDetails.Name.EditValue = ew_HtmlEncode(BusinessDetails.Name.CurrentValue)
			BusinessDetails.Name.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Name.FldCaption))

			' Address
			BusinessDetails.Address.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Address.EditCustomAttributes = ""
			BusinessDetails.Address.EditValue = ew_HtmlEncode(BusinessDetails.Address.CurrentValue)
			BusinessDetails.Address.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Address.FldCaption))

			' PostalCode
			BusinessDetails.PostalCode.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.PostalCode.EditCustomAttributes = ""
			BusinessDetails.PostalCode.EditValue = ew_HtmlEncode(BusinessDetails.PostalCode.CurrentValue)
			BusinessDetails.PostalCode.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.PostalCode.FldCaption))

			' FoodType
			BusinessDetails.FoodType.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.FoodType.EditCustomAttributes = ""
			BusinessDetails.FoodType.EditValue = ew_HtmlEncode(BusinessDetails.FoodType.CurrentValue)
			BusinessDetails.FoodType.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.FoodType.FldCaption))

			' DeliveryMinAmount
			BusinessDetails.DeliveryMinAmount.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.DeliveryMinAmount.EditCustomAttributes = ""
			BusinessDetails.DeliveryMinAmount.EditValue = ew_HtmlEncode(BusinessDetails.DeliveryMinAmount.CurrentValue)
			BusinessDetails.DeliveryMinAmount.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.DeliveryMinAmount.FldCaption))

			' DeliveryMaxDistance
			BusinessDetails.DeliveryMaxDistance.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.DeliveryMaxDistance.EditCustomAttributes = ""
			BusinessDetails.DeliveryMaxDistance.EditValue = ew_HtmlEncode(BusinessDetails.DeliveryMaxDistance.CurrentValue)
			BusinessDetails.DeliveryMaxDistance.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.DeliveryMaxDistance.FldCaption))
			If BusinessDetails.DeliveryMaxDistance.EditValue&"" <> "" And IsNumeric(BusinessDetails.DeliveryMaxDistance.EditValue) Then BusinessDetails.DeliveryMaxDistance.EditValue = ew_FormatNumber2(BusinessDetails.DeliveryMaxDistance.EditValue, -2)

			' DeliveryFreeDistance
			BusinessDetails.DeliveryFreeDistance.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.DeliveryFreeDistance.EditCustomAttributes = ""
			BusinessDetails.DeliveryFreeDistance.EditValue = ew_HtmlEncode(BusinessDetails.DeliveryFreeDistance.CurrentValue)
			BusinessDetails.DeliveryFreeDistance.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.DeliveryFreeDistance.FldCaption))
			If BusinessDetails.DeliveryFreeDistance.EditValue&"" <> "" And IsNumeric(BusinessDetails.DeliveryFreeDistance.EditValue) Then BusinessDetails.DeliveryFreeDistance.EditValue = ew_FormatNumber2(BusinessDetails.DeliveryFreeDistance.EditValue, -2)

			' AverageDeliveryTime
			BusinessDetails.AverageDeliveryTime.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.AverageDeliveryTime.EditCustomAttributes = ""
			BusinessDetails.AverageDeliveryTime.EditValue = ew_HtmlEncode(BusinessDetails.AverageDeliveryTime.CurrentValue)
			BusinessDetails.AverageDeliveryTime.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.AverageDeliveryTime.FldCaption))

			' AverageCollectionTime
			BusinessDetails.AverageCollectionTime.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.AverageCollectionTime.EditCustomAttributes = ""
			BusinessDetails.AverageCollectionTime.EditValue = ew_HtmlEncode(BusinessDetails.AverageCollectionTime.CurrentValue)
			BusinessDetails.AverageCollectionTime.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.AverageCollectionTime.FldCaption))

			' DeliveryFee
			BusinessDetails.DeliveryFee.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.DeliveryFee.EditCustomAttributes = ""
			BusinessDetails.DeliveryFee.EditValue = ew_HtmlEncode(BusinessDetails.DeliveryFee.CurrentValue)
			BusinessDetails.DeliveryFee.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.DeliveryFee.FldCaption))
			If BusinessDetails.DeliveryFee.EditValue&"" <> "" And IsNumeric(BusinessDetails.DeliveryFee.EditValue) Then BusinessDetails.DeliveryFee.EditValue = ew_FormatNumber2(BusinessDetails.DeliveryFee.EditValue, -2)

			' ImgUrl
			BusinessDetails.ImgUrl.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.ImgUrl.EditCustomAttributes = ""
			BusinessDetails.ImgUrl.EditValue = ew_HtmlEncode(BusinessDetails.ImgUrl.CurrentValue)
			BusinessDetails.ImgUrl.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.ImgUrl.FldCaption))

			' Telephone
			BusinessDetails.Telephone.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Telephone.EditCustomAttributes = ""
			BusinessDetails.Telephone.EditValue = ew_HtmlEncode(BusinessDetails.Telephone.CurrentValue)
			BusinessDetails.Telephone.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Telephone.FldCaption))

			' Email
			BusinessDetails.zEmail.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.zEmail.EditCustomAttributes = ""
			BusinessDetails.zEmail.EditValue = ew_HtmlEncode(BusinessDetails.zEmail.CurrentValue)
			BusinessDetails.zEmail.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.zEmail.FldCaption))

			' pswd
			BusinessDetails.pswd.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.pswd.EditCustomAttributes = ""
			BusinessDetails.pswd.EditValue = ew_HtmlEncode(BusinessDetails.pswd.CurrentValue)
			BusinessDetails.pswd.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.pswd.FldCaption))

			' businessclosed
			BusinessDetails.businessclosed.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.businessclosed.EditCustomAttributes = ""
			BusinessDetails.businessclosed.EditValue = ew_HtmlEncode(BusinessDetails.businessclosed.CurrentValue)
			BusinessDetails.businessclosed.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.businessclosed.FldCaption))

			' announcement
			BusinessDetails.announcement.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.announcement.EditCustomAttributes = ""
			BusinessDetails.announcement.EditValue = ew_HtmlEncode(BusinessDetails.announcement.CurrentValue)
			BusinessDetails.announcement.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.announcement.FldCaption))

			' css
			BusinessDetails.css.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.css.EditCustomAttributes = ""
			BusinessDetails.css.EditValue = ew_HtmlEncode(BusinessDetails.css.CurrentValue)
			BusinessDetails.css.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.css.FldCaption))

			' SMTP_AUTENTICATE
			BusinessDetails.SMTP_AUTENTICATE.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.SMTP_AUTENTICATE.EditCustomAttributes = ""
			BusinessDetails.SMTP_AUTENTICATE.EditValue = ew_HtmlEncode(BusinessDetails.SMTP_AUTENTICATE.CurrentValue)
			BusinessDetails.SMTP_AUTENTICATE.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.SMTP_AUTENTICATE.FldCaption))

			' MAIL_FROM
			BusinessDetails.MAIL_FROM.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.MAIL_FROM.EditCustomAttributes = ""
			BusinessDetails.MAIL_FROM.EditValue = ew_HtmlEncode(BusinessDetails.MAIL_FROM.CurrentValue)
			BusinessDetails.MAIL_FROM.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.MAIL_FROM.FldCaption))

			' PAYPAL_URL
			BusinessDetails.PAYPAL_URL.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.PAYPAL_URL.EditCustomAttributes = ""
			BusinessDetails.PAYPAL_URL.EditValue = ew_HtmlEncode(BusinessDetails.PAYPAL_URL.CurrentValue)
			BusinessDetails.PAYPAL_URL.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.PAYPAL_URL.FldCaption))

			' PAYPAL_PDT
			BusinessDetails.PAYPAL_PDT.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.PAYPAL_PDT.EditCustomAttributes = ""
			BusinessDetails.PAYPAL_PDT.EditValue = ew_HtmlEncode(BusinessDetails.PAYPAL_PDT.CurrentValue)
			BusinessDetails.PAYPAL_PDT.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.PAYPAL_PDT.FldCaption))

			' SMTP_PASSWORD
			BusinessDetails.SMTP_PASSWORD.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.SMTP_PASSWORD.EditCustomAttributes = ""
			BusinessDetails.SMTP_PASSWORD.EditValue = ew_HtmlEncode(BusinessDetails.SMTP_PASSWORD.CurrentValue)
			BusinessDetails.SMTP_PASSWORD.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.SMTP_PASSWORD.FldCaption))

			' GMAP_API_KEY
			BusinessDetails.GMAP_API_KEY.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.GMAP_API_KEY.EditCustomAttributes = ""
			BusinessDetails.GMAP_API_KEY.EditValue = ew_HtmlEncode(BusinessDetails.GMAP_API_KEY.CurrentValue)
			BusinessDetails.GMAP_API_KEY.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.GMAP_API_KEY.FldCaption))

			' SMTP_USERNAME
			BusinessDetails.SMTP_USERNAME.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.SMTP_USERNAME.EditCustomAttributes = ""
			BusinessDetails.SMTP_USERNAME.EditValue = ew_HtmlEncode(BusinessDetails.SMTP_USERNAME.CurrentValue)
			BusinessDetails.SMTP_USERNAME.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.SMTP_USERNAME.FldCaption))

			' SMTP_USESSL
			BusinessDetails.SMTP_USESSL.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.SMTP_USESSL.EditCustomAttributes = ""
			BusinessDetails.SMTP_USESSL.EditValue = ew_HtmlEncode(BusinessDetails.SMTP_USESSL.CurrentValue)
			BusinessDetails.SMTP_USESSL.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.SMTP_USESSL.FldCaption))

			' MAIL_SUBJECT
			BusinessDetails.MAIL_SUBJECT.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.MAIL_SUBJECT.EditCustomAttributes = ""
			BusinessDetails.MAIL_SUBJECT.EditValue = ew_HtmlEncode(BusinessDetails.MAIL_SUBJECT.CurrentValue)
			BusinessDetails.MAIL_SUBJECT.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.MAIL_SUBJECT.FldCaption))

			' CURRENCYSYMBOL
			BusinessDetails.CURRENCYSYMBOL.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.CURRENCYSYMBOL.EditCustomAttributes = ""
			BusinessDetails.CURRENCYSYMBOL.EditValue = ew_HtmlEncode(BusinessDetails.CURRENCYSYMBOL.CurrentValue)
			BusinessDetails.CURRENCYSYMBOL.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.CURRENCYSYMBOL.FldCaption))

			' SMTP_SERVER
			BusinessDetails.SMTP_SERVER.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.SMTP_SERVER.EditCustomAttributes = ""
			BusinessDetails.SMTP_SERVER.EditValue = ew_HtmlEncode(BusinessDetails.SMTP_SERVER.CurrentValue)
			BusinessDetails.SMTP_SERVER.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.SMTP_SERVER.FldCaption))

			' CREDITCARDSURCHARGE
			BusinessDetails.CREDITCARDSURCHARGE.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.CREDITCARDSURCHARGE.EditCustomAttributes = ""
			BusinessDetails.CREDITCARDSURCHARGE.EditValue = ew_HtmlEncode(BusinessDetails.CREDITCARDSURCHARGE.CurrentValue)
			BusinessDetails.CREDITCARDSURCHARGE.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.CREDITCARDSURCHARGE.FldCaption))

			' SMTP_PORT
			BusinessDetails.SMTP_PORT.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.SMTP_PORT.EditCustomAttributes = ""
			BusinessDetails.SMTP_PORT.EditValue = ew_HtmlEncode(BusinessDetails.SMTP_PORT.CurrentValue)
			BusinessDetails.SMTP_PORT.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.SMTP_PORT.FldCaption))

			' STICK_MENU
			BusinessDetails.STICK_MENU.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.STICK_MENU.EditCustomAttributes = ""
			BusinessDetails.STICK_MENU.EditValue = ew_HtmlEncode(BusinessDetails.STICK_MENU.CurrentValue)
			BusinessDetails.STICK_MENU.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.STICK_MENU.FldCaption))

			' MAIL_CUSTOMER_SUBJECT
			BusinessDetails.MAIL_CUSTOMER_SUBJECT.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.MAIL_CUSTOMER_SUBJECT.EditCustomAttributes = ""
			BusinessDetails.MAIL_CUSTOMER_SUBJECT.EditValue = ew_HtmlEncode(BusinessDetails.MAIL_CUSTOMER_SUBJECT.CurrentValue)
			BusinessDetails.MAIL_CUSTOMER_SUBJECT.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.MAIL_CUSTOMER_SUBJECT.FldCaption))

			' CONFIRMATION_EMAIL_ADDRESS
			BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.EditCustomAttributes = ""
			BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.EditValue = ew_HtmlEncode(BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.CurrentValue)
			BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.FldCaption))

			' SEND_ORDERS_TO_PRINTER
			BusinessDetails.SEND_ORDERS_TO_PRINTER.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.SEND_ORDERS_TO_PRINTER.EditCustomAttributes = ""
			BusinessDetails.SEND_ORDERS_TO_PRINTER.EditValue = ew_HtmlEncode(BusinessDetails.SEND_ORDERS_TO_PRINTER.CurrentValue)
			BusinessDetails.SEND_ORDERS_TO_PRINTER.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.SEND_ORDERS_TO_PRINTER.FldCaption))

			' timezone
			BusinessDetails.timezone.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.timezone.EditCustomAttributes = ""
			BusinessDetails.timezone.EditValue = ew_HtmlEncode(BusinessDetails.timezone.CurrentValue)
			BusinessDetails.timezone.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.timezone.FldCaption))

			' PAYPAL_ADDR
			BusinessDetails.PAYPAL_ADDR.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.PAYPAL_ADDR.EditCustomAttributes = ""
			BusinessDetails.PAYPAL_ADDR.EditValue = ew_HtmlEncode(BusinessDetails.PAYPAL_ADDR.CurrentValue)
			BusinessDetails.PAYPAL_ADDR.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.PAYPAL_ADDR.FldCaption))

			' nochex
			BusinessDetails.nochex.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.nochex.EditCustomAttributes = ""
			BusinessDetails.nochex.EditValue = ew_HtmlEncode(BusinessDetails.nochex.CurrentValue)
			BusinessDetails.nochex.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.nochex.FldCaption))

			' nochexmerchantid
			BusinessDetails.nochexmerchantid.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.nochexmerchantid.EditCustomAttributes = ""
			BusinessDetails.nochexmerchantid.EditValue = ew_HtmlEncode(BusinessDetails.nochexmerchantid.CurrentValue)
			BusinessDetails.nochexmerchantid.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.nochexmerchantid.FldCaption))

			' paypal
			BusinessDetails.paypal.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.paypal.EditCustomAttributes = ""
			BusinessDetails.paypal.EditValue = ew_HtmlEncode(BusinessDetails.paypal.CurrentValue)
			BusinessDetails.paypal.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.paypal.FldCaption))

			' IBT_API_KEY
			BusinessDetails.IBT_API_KEY.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.IBT_API_KEY.EditCustomAttributes = ""
			BusinessDetails.IBT_API_KEY.EditValue = ew_HtmlEncode(BusinessDetails.IBT_API_KEY.CurrentValue)
			BusinessDetails.IBT_API_KEY.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.IBT_API_KEY.FldCaption))

			' IBP_API_PASSWORD
			BusinessDetails.IBP_API_PASSWORD.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.IBP_API_PASSWORD.EditCustomAttributes = ""
			BusinessDetails.IBP_API_PASSWORD.EditValue = ew_HtmlEncode(BusinessDetails.IBP_API_PASSWORD.CurrentValue)
			BusinessDetails.IBP_API_PASSWORD.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.IBP_API_PASSWORD.FldCaption))

			' disable_delivery
			BusinessDetails.disable_delivery.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.disable_delivery.EditCustomAttributes = ""
			BusinessDetails.disable_delivery.EditValue = ew_HtmlEncode(BusinessDetails.disable_delivery.CurrentValue)
			BusinessDetails.disable_delivery.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.disable_delivery.FldCaption))

			' disable_collection
			BusinessDetails.disable_collection.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.disable_collection.EditCustomAttributes = ""
			BusinessDetails.disable_collection.EditValue = ew_HtmlEncode(BusinessDetails.disable_collection.CurrentValue)
			BusinessDetails.disable_collection.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.disable_collection.FldCaption))

			' worldpay
			BusinessDetails.worldpay.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.worldpay.EditCustomAttributes = ""
			BusinessDetails.worldpay.EditValue = ew_HtmlEncode(BusinessDetails.worldpay.CurrentValue)
			BusinessDetails.worldpay.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.worldpay.FldCaption))

			' worldpaymerchantid
			BusinessDetails.worldpaymerchantid.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.worldpaymerchantid.EditCustomAttributes = ""
			BusinessDetails.worldpaymerchantid.EditValue = ew_HtmlEncode(BusinessDetails.worldpaymerchantid.CurrentValue)
			BusinessDetails.worldpaymerchantid.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.worldpaymerchantid.FldCaption))

			' backtohometext
			BusinessDetails.backtohometext.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.backtohometext.EditCustomAttributes = ""
			BusinessDetails.backtohometext.EditValue = ew_HtmlEncode(BusinessDetails.backtohometext.CurrentValue)
			BusinessDetails.backtohometext.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.backtohometext.FldCaption))

			' closedtext
			BusinessDetails.closedtext.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.closedtext.EditCustomAttributes = ""
			BusinessDetails.closedtext.EditValue = ew_HtmlEncode(BusinessDetails.closedtext.CurrentValue)
			BusinessDetails.closedtext.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.closedtext.FldCaption))

			' DeliveryChargeOverrideByOrderValue
			BusinessDetails.DeliveryChargeOverrideByOrderValue.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.DeliveryChargeOverrideByOrderValue.EditCustomAttributes = ""
			BusinessDetails.DeliveryChargeOverrideByOrderValue.EditValue = ew_HtmlEncode(BusinessDetails.DeliveryChargeOverrideByOrderValue.CurrentValue)
			BusinessDetails.DeliveryChargeOverrideByOrderValue.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.DeliveryChargeOverrideByOrderValue.FldCaption))

			' individualpostcodes
			BusinessDetails.individualpostcodes.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.individualpostcodes.EditCustomAttributes = ""
			BusinessDetails.individualpostcodes.EditValue = ew_HtmlEncode(BusinessDetails.individualpostcodes.CurrentValue)
			BusinessDetails.individualpostcodes.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.individualpostcodes.FldCaption))

			' individualpostcodeschecking
			BusinessDetails.individualpostcodeschecking.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.individualpostcodeschecking.EditCustomAttributes = ""
			BusinessDetails.individualpostcodeschecking.EditValue = ew_HtmlEncode(BusinessDetails.individualpostcodeschecking.CurrentValue)
			BusinessDetails.individualpostcodeschecking.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.individualpostcodeschecking.FldCaption))

			' longitude
			BusinessDetails.longitude.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.longitude.EditCustomAttributes = ""
			BusinessDetails.longitude.EditValue = ew_HtmlEncode(BusinessDetails.longitude.CurrentValue)
			BusinessDetails.longitude.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.longitude.FldCaption))

			' latitude
			BusinessDetails.latitude.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.latitude.EditCustomAttributes = ""
			BusinessDetails.latitude.EditValue = ew_HtmlEncode(BusinessDetails.latitude.CurrentValue)
			BusinessDetails.latitude.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.latitude.FldCaption))

			' googleecommercetracking
			BusinessDetails.googleecommercetracking.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.googleecommercetracking.EditCustomAttributes = ""
			BusinessDetails.googleecommercetracking.EditValue = ew_HtmlEncode(BusinessDetails.googleecommercetracking.CurrentValue)
			BusinessDetails.googleecommercetracking.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.googleecommercetracking.FldCaption))

			' googleecommercetrackingcode
			BusinessDetails.googleecommercetrackingcode.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.googleecommercetrackingcode.EditCustomAttributes = ""
			BusinessDetails.googleecommercetrackingcode.EditValue = ew_HtmlEncode(BusinessDetails.googleecommercetrackingcode.CurrentValue)
			BusinessDetails.googleecommercetrackingcode.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.googleecommercetrackingcode.FldCaption))

			' bringg
			BusinessDetails.bringg.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.bringg.EditCustomAttributes = ""
			BusinessDetails.bringg.EditValue = ew_HtmlEncode(BusinessDetails.bringg.CurrentValue)
			BusinessDetails.bringg.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.bringg.FldCaption))

			' bringgurl
			BusinessDetails.bringgurl.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.bringgurl.EditCustomAttributes = ""
			BusinessDetails.bringgurl.EditValue = ew_HtmlEncode(BusinessDetails.bringgurl.CurrentValue)
			BusinessDetails.bringgurl.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.bringgurl.FldCaption))

			' bringgcompanyid
			BusinessDetails.bringgcompanyid.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.bringgcompanyid.EditCustomAttributes = ""
			BusinessDetails.bringgcompanyid.EditValue = ew_HtmlEncode(BusinessDetails.bringgcompanyid.CurrentValue)
			BusinessDetails.bringgcompanyid.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.bringgcompanyid.FldCaption))

			' orderonlywhenopen
			BusinessDetails.orderonlywhenopen.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.orderonlywhenopen.EditCustomAttributes = ""
			BusinessDetails.orderonlywhenopen.EditValue = ew_HtmlEncode(BusinessDetails.orderonlywhenopen.CurrentValue)
			BusinessDetails.orderonlywhenopen.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.orderonlywhenopen.FldCaption))

			' disablelaterdelivery
			BusinessDetails.disablelaterdelivery.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.disablelaterdelivery.EditCustomAttributes = ""
			BusinessDetails.disablelaterdelivery.EditValue = ew_HtmlEncode(BusinessDetails.disablelaterdelivery.CurrentValue)
			BusinessDetails.disablelaterdelivery.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.disablelaterdelivery.FldCaption))

			' menupagetext
			BusinessDetails.menupagetext.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.menupagetext.EditCustomAttributes = ""
			BusinessDetails.menupagetext.EditValue = ew_HtmlEncode(BusinessDetails.menupagetext.CurrentValue)
			BusinessDetails.menupagetext.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.menupagetext.FldCaption))

			' ordertodayonly
			BusinessDetails.ordertodayonly.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.ordertodayonly.EditCustomAttributes = ""
			BusinessDetails.ordertodayonly.EditValue = ew_HtmlEncode(BusinessDetails.ordertodayonly.CurrentValue)
			BusinessDetails.ordertodayonly.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.ordertodayonly.FldCaption))

			' mileskm
			BusinessDetails.mileskm.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.mileskm.EditCustomAttributes = ""
			BusinessDetails.mileskm.EditValue = ew_HtmlEncode(BusinessDetails.mileskm.CurrentValue)
			BusinessDetails.mileskm.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.mileskm.FldCaption))

			' worldpaylive
			BusinessDetails.worldpaylive.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.worldpaylive.EditCustomAttributes = ""
			BusinessDetails.worldpaylive.EditValue = ew_HtmlEncode(BusinessDetails.worldpaylive.CurrentValue)
			BusinessDetails.worldpaylive.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.worldpaylive.FldCaption))

			' worldpayinstallationid
			BusinessDetails.worldpayinstallationid.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.worldpayinstallationid.EditCustomAttributes = ""
			BusinessDetails.worldpayinstallationid.EditValue = ew_HtmlEncode(BusinessDetails.worldpayinstallationid.CurrentValue)
			BusinessDetails.worldpayinstallationid.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.worldpayinstallationid.FldCaption))

			' DistanceCalMethod
			BusinessDetails.DistanceCalMethod.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.DistanceCalMethod.EditCustomAttributes = ""
			BusinessDetails.DistanceCalMethod.EditValue = ew_HtmlEncode(BusinessDetails.DistanceCalMethod.CurrentValue)
			BusinessDetails.DistanceCalMethod.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.DistanceCalMethod.FldCaption))

			' PrinterIDList
			BusinessDetails.PrinterIDList.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.PrinterIDList.EditCustomAttributes = ""
			BusinessDetails.PrinterIDList.EditValue = ew_HtmlEncode(BusinessDetails.PrinterIDList.CurrentValue)
			BusinessDetails.PrinterIDList.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.PrinterIDList.FldCaption))

			' EpsonJSPrinterURL
			BusinessDetails.EpsonJSPrinterURL.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.EpsonJSPrinterURL.EditCustomAttributes = ""
			BusinessDetails.EpsonJSPrinterURL.EditValue = ew_HtmlEncode(BusinessDetails.EpsonJSPrinterURL.CurrentValue)
			BusinessDetails.EpsonJSPrinterURL.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.EpsonJSPrinterURL.FldCaption))

			' SMSEnable
			BusinessDetails.SMSEnable.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.SMSEnable.EditCustomAttributes = ""
			BusinessDetails.SMSEnable.EditValue = ew_HtmlEncode(BusinessDetails.SMSEnable.CurrentValue)
			BusinessDetails.SMSEnable.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.SMSEnable.FldCaption))

			' SMSOnDelivery
			BusinessDetails.SMSOnDelivery.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.SMSOnDelivery.EditCustomAttributes = ""
			BusinessDetails.SMSOnDelivery.EditValue = ew_HtmlEncode(BusinessDetails.SMSOnDelivery.CurrentValue)
			BusinessDetails.SMSOnDelivery.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.SMSOnDelivery.FldCaption))

			' SMSSupplierDomain
			BusinessDetails.SMSSupplierDomain.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.SMSSupplierDomain.EditCustomAttributes = ""
			BusinessDetails.SMSSupplierDomain.EditValue = ew_HtmlEncode(BusinessDetails.SMSSupplierDomain.CurrentValue)
			BusinessDetails.SMSSupplierDomain.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.SMSSupplierDomain.FldCaption))

			' SMSOnOrder
			BusinessDetails.SMSOnOrder.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.SMSOnOrder.EditCustomAttributes = ""
			BusinessDetails.SMSOnOrder.EditValue = ew_HtmlEncode(BusinessDetails.SMSOnOrder.CurrentValue)
			BusinessDetails.SMSOnOrder.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.SMSOnOrder.FldCaption))

			' SMSOnOrderAfterMin
			BusinessDetails.SMSOnOrderAfterMin.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.SMSOnOrderAfterMin.EditCustomAttributes = ""
			BusinessDetails.SMSOnOrderAfterMin.EditValue = ew_HtmlEncode(BusinessDetails.SMSOnOrderAfterMin.CurrentValue)
			BusinessDetails.SMSOnOrderAfterMin.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.SMSOnOrderAfterMin.FldCaption))

			' SMSOnOrderContent
			BusinessDetails.SMSOnOrderContent.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.SMSOnOrderContent.EditCustomAttributes = ""
			BusinessDetails.SMSOnOrderContent.EditValue = ew_HtmlEncode(BusinessDetails.SMSOnOrderContent.CurrentValue)
			BusinessDetails.SMSOnOrderContent.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.SMSOnOrderContent.FldCaption))

			' DefaultSMSCountryCode
			BusinessDetails.DefaultSMSCountryCode.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.DefaultSMSCountryCode.EditCustomAttributes = ""
			BusinessDetails.DefaultSMSCountryCode.EditValue = ew_HtmlEncode(BusinessDetails.DefaultSMSCountryCode.CurrentValue)
			BusinessDetails.DefaultSMSCountryCode.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.DefaultSMSCountryCode.FldCaption))

			' MinimumAmountForCardPayment
			BusinessDetails.MinimumAmountForCardPayment.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.MinimumAmountForCardPayment.EditCustomAttributes = ""
			BusinessDetails.MinimumAmountForCardPayment.EditValue = ew_HtmlEncode(BusinessDetails.MinimumAmountForCardPayment.CurrentValue)
			BusinessDetails.MinimumAmountForCardPayment.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.MinimumAmountForCardPayment.FldCaption))
			If BusinessDetails.MinimumAmountForCardPayment.EditValue&"" <> "" And IsNumeric(BusinessDetails.MinimumAmountForCardPayment.EditValue) Then BusinessDetails.MinimumAmountForCardPayment.EditValue = ew_FormatNumber2(BusinessDetails.MinimumAmountForCardPayment.EditValue, -2)

			' FavIconUrl
			BusinessDetails.FavIconUrl.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.FavIconUrl.EditCustomAttributes = ""
			BusinessDetails.FavIconUrl.EditValue = ew_HtmlEncode(BusinessDetails.FavIconUrl.CurrentValue)
			BusinessDetails.FavIconUrl.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.FavIconUrl.FldCaption))

			' AddToHomeScreenURL
			BusinessDetails.AddToHomeScreenURL.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.AddToHomeScreenURL.EditCustomAttributes = ""
			BusinessDetails.AddToHomeScreenURL.EditValue = ew_HtmlEncode(BusinessDetails.AddToHomeScreenURL.CurrentValue)
			BusinessDetails.AddToHomeScreenURL.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.AddToHomeScreenURL.FldCaption))

			' SMSOnAcknowledgement
			BusinessDetails.SMSOnAcknowledgement.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.SMSOnAcknowledgement.EditCustomAttributes = ""
			BusinessDetails.SMSOnAcknowledgement.EditValue = ew_HtmlEncode(BusinessDetails.SMSOnAcknowledgement.CurrentValue)
			BusinessDetails.SMSOnAcknowledgement.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.SMSOnAcknowledgement.FldCaption))

			' LocalPrinterURL
			BusinessDetails.LocalPrinterURL.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.LocalPrinterURL.EditCustomAttributes = ""
			BusinessDetails.LocalPrinterURL.EditValue = ew_HtmlEncode(BusinessDetails.LocalPrinterURL.CurrentValue)
			BusinessDetails.LocalPrinterURL.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.LocalPrinterURL.FldCaption))

			' ShowRestaurantDetailOnReceipt
			BusinessDetails.ShowRestaurantDetailOnReceipt.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.ShowRestaurantDetailOnReceipt.EditCustomAttributes = ""
			BusinessDetails.ShowRestaurantDetailOnReceipt.EditValue = ew_HtmlEncode(BusinessDetails.ShowRestaurantDetailOnReceipt.CurrentValue)
			BusinessDetails.ShowRestaurantDetailOnReceipt.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.ShowRestaurantDetailOnReceipt.FldCaption))

			' PrinterFontSizeRatio
			BusinessDetails.PrinterFontSizeRatio.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.PrinterFontSizeRatio.EditCustomAttributes = ""
			BusinessDetails.PrinterFontSizeRatio.EditValue = ew_HtmlEncode(BusinessDetails.PrinterFontSizeRatio.CurrentValue)
			BusinessDetails.PrinterFontSizeRatio.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.PrinterFontSizeRatio.FldCaption))
			If BusinessDetails.PrinterFontSizeRatio.EditValue&"" <> "" And IsNumeric(BusinessDetails.PrinterFontSizeRatio.EditValue) Then BusinessDetails.PrinterFontSizeRatio.EditValue = ew_FormatNumber2(BusinessDetails.PrinterFontSizeRatio.EditValue, -2)

			' ServiceChargePercentage
			BusinessDetails.ServiceChargePercentage.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.ServiceChargePercentage.EditCustomAttributes = ""
			BusinessDetails.ServiceChargePercentage.EditValue = ew_HtmlEncode(BusinessDetails.ServiceChargePercentage.CurrentValue)
			BusinessDetails.ServiceChargePercentage.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.ServiceChargePercentage.FldCaption))
			If BusinessDetails.ServiceChargePercentage.EditValue&"" <> "" And IsNumeric(BusinessDetails.ServiceChargePercentage.EditValue) Then BusinessDetails.ServiceChargePercentage.EditValue = ew_FormatNumber2(BusinessDetails.ServiceChargePercentage.EditValue, -2)

			' InRestaurantServiceChargeOnly
			BusinessDetails.InRestaurantServiceChargeOnly.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.InRestaurantServiceChargeOnly.EditCustomAttributes = ""
			BusinessDetails.InRestaurantServiceChargeOnly.EditValue = ew_HtmlEncode(BusinessDetails.InRestaurantServiceChargeOnly.CurrentValue)
			BusinessDetails.InRestaurantServiceChargeOnly.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.InRestaurantServiceChargeOnly.FldCaption))

			' IsDualReceiptPrinting
			BusinessDetails.IsDualReceiptPrinting.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.IsDualReceiptPrinting.EditCustomAttributes = ""
			BusinessDetails.IsDualReceiptPrinting.EditValue = ew_HtmlEncode(BusinessDetails.IsDualReceiptPrinting.CurrentValue)
			BusinessDetails.IsDualReceiptPrinting.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.IsDualReceiptPrinting.FldCaption))

			' PrintingFontSize
			BusinessDetails.PrintingFontSize.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.PrintingFontSize.EditCustomAttributes = ""
			BusinessDetails.PrintingFontSize.EditValue = ew_HtmlEncode(BusinessDetails.PrintingFontSize.CurrentValue)
			BusinessDetails.PrintingFontSize.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.PrintingFontSize.FldCaption))
			If BusinessDetails.PrintingFontSize.EditValue&"" <> "" And IsNumeric(BusinessDetails.PrintingFontSize.EditValue) Then BusinessDetails.PrintingFontSize.EditValue = ew_FormatNumber2(BusinessDetails.PrintingFontSize.EditValue, -2)

			' InRestaurantEpsonPrinterIDList
			BusinessDetails.InRestaurantEpsonPrinterIDList.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.InRestaurantEpsonPrinterIDList.EditCustomAttributes = ""
			BusinessDetails.InRestaurantEpsonPrinterIDList.EditValue = ew_HtmlEncode(BusinessDetails.InRestaurantEpsonPrinterIDList.CurrentValue)
			BusinessDetails.InRestaurantEpsonPrinterIDList.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.InRestaurantEpsonPrinterIDList.FldCaption))

			' BlockIPEmailList
			BusinessDetails.BlockIPEmailList.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.BlockIPEmailList.EditCustomAttributes = ""
			BusinessDetails.BlockIPEmailList.EditValue = ew_HtmlEncode(BusinessDetails.BlockIPEmailList.CurrentValue)
			BusinessDetails.BlockIPEmailList.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.BlockIPEmailList.FldCaption))

			' inmenuannouncement
			BusinessDetails.inmenuannouncement.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.inmenuannouncement.EditCustomAttributes = ""
			BusinessDetails.inmenuannouncement.EditValue = ew_HtmlEncode(BusinessDetails.inmenuannouncement.CurrentValue)
			BusinessDetails.inmenuannouncement.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.inmenuannouncement.FldCaption))

			' RePrintReceiptWays
			BusinessDetails.RePrintReceiptWays.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.RePrintReceiptWays.EditCustomAttributes = ""
			BusinessDetails.RePrintReceiptWays.EditValue = ew_HtmlEncode(BusinessDetails.RePrintReceiptWays.CurrentValue)
			BusinessDetails.RePrintReceiptWays.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.RePrintReceiptWays.FldCaption))

			' printingtype
			BusinessDetails.printingtype.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.printingtype.EditCustomAttributes = ""
			BusinessDetails.printingtype.EditValue = ew_HtmlEncode(BusinessDetails.printingtype.CurrentValue)
			BusinessDetails.printingtype.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.printingtype.FldCaption))

			' Stripe_Key_Secret
			BusinessDetails.Stripe_Key_Secret.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Stripe_Key_Secret.EditCustomAttributes = ""
			BusinessDetails.Stripe_Key_Secret.EditValue = ew_HtmlEncode(BusinessDetails.Stripe_Key_Secret.CurrentValue)
			BusinessDetails.Stripe_Key_Secret.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Stripe_Key_Secret.FldCaption))

			' Stripe
			BusinessDetails.Stripe.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Stripe.EditCustomAttributes = ""
			BusinessDetails.Stripe.EditValue = ew_HtmlEncode(BusinessDetails.Stripe.CurrentValue)
			BusinessDetails.Stripe.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Stripe.FldCaption))

			' Stripe_Api_Key
			BusinessDetails.Stripe_Api_Key.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Stripe_Api_Key.EditCustomAttributes = ""
			BusinessDetails.Stripe_Api_Key.EditValue = ew_HtmlEncode(BusinessDetails.Stripe_Api_Key.CurrentValue)
			BusinessDetails.Stripe_Api_Key.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Stripe_Api_Key.FldCaption))

			' EnableBooking
			BusinessDetails.EnableBooking.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.EnableBooking.EditCustomAttributes = ""
			BusinessDetails.EnableBooking.EditValue = ew_HtmlEncode(BusinessDetails.EnableBooking.CurrentValue)
			BusinessDetails.EnableBooking.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.EnableBooking.FldCaption))

			' URL_Facebook
			BusinessDetails.URL_Facebook.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.URL_Facebook.EditCustomAttributes = ""
			BusinessDetails.URL_Facebook.EditValue = ew_HtmlEncode(BusinessDetails.URL_Facebook.CurrentValue)
			BusinessDetails.URL_Facebook.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.URL_Facebook.FldCaption))

			' URL_Twitter
			BusinessDetails.URL_Twitter.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.URL_Twitter.EditCustomAttributes = ""
			BusinessDetails.URL_Twitter.EditValue = ew_HtmlEncode(BusinessDetails.URL_Twitter.CurrentValue)
			BusinessDetails.URL_Twitter.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.URL_Twitter.FldCaption))

			' URL_Google
			BusinessDetails.URL_Google.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.URL_Google.EditCustomAttributes = ""
			BusinessDetails.URL_Google.EditValue = ew_HtmlEncode(BusinessDetails.URL_Google.CurrentValue)
			BusinessDetails.URL_Google.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.URL_Google.FldCaption))

			' URL_Intagram
			BusinessDetails.URL_Intagram.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.URL_Intagram.EditCustomAttributes = ""
			BusinessDetails.URL_Intagram.EditValue = ew_HtmlEncode(BusinessDetails.URL_Intagram.CurrentValue)
			BusinessDetails.URL_Intagram.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.URL_Intagram.FldCaption))

			' URL_YouTube
			BusinessDetails.URL_YouTube.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.URL_YouTube.EditCustomAttributes = ""
			BusinessDetails.URL_YouTube.EditValue = ew_HtmlEncode(BusinessDetails.URL_YouTube.CurrentValue)
			BusinessDetails.URL_YouTube.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.URL_YouTube.FldCaption))

			' URL_Tripadvisor
			BusinessDetails.URL_Tripadvisor.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.URL_Tripadvisor.EditCustomAttributes = ""
			BusinessDetails.URL_Tripadvisor.EditValue = ew_HtmlEncode(BusinessDetails.URL_Tripadvisor.CurrentValue)
			BusinessDetails.URL_Tripadvisor.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.URL_Tripadvisor.FldCaption))

			' URL_Special_Offer
			BusinessDetails.URL_Special_Offer.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.URL_Special_Offer.EditCustomAttributes = ""
			BusinessDetails.URL_Special_Offer.EditValue = ew_HtmlEncode(BusinessDetails.URL_Special_Offer.CurrentValue)
			BusinessDetails.URL_Special_Offer.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.URL_Special_Offer.FldCaption))

			' URL_Linkin
			BusinessDetails.URL_Linkin.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.URL_Linkin.EditCustomAttributes = ""
			BusinessDetails.URL_Linkin.EditValue = ew_HtmlEncode(BusinessDetails.URL_Linkin.CurrentValue)
			BusinessDetails.URL_Linkin.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.URL_Linkin.FldCaption))

			' Currency_PAYPAL
			BusinessDetails.Currency_PAYPAL.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Currency_PAYPAL.EditCustomAttributes = ""
			BusinessDetails.Currency_PAYPAL.EditValue = ew_HtmlEncode(BusinessDetails.Currency_PAYPAL.CurrentValue)
			BusinessDetails.Currency_PAYPAL.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Currency_PAYPAL.FldCaption))

			' Currency_STRIPE
			BusinessDetails.Currency_STRIPE.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Currency_STRIPE.EditCustomAttributes = ""
			BusinessDetails.Currency_STRIPE.EditValue = ew_HtmlEncode(BusinessDetails.Currency_STRIPE.CurrentValue)
			BusinessDetails.Currency_STRIPE.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Currency_STRIPE.FldCaption))

			' Currency_WOLRDPAY
			BusinessDetails.Currency_WOLRDPAY.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Currency_WOLRDPAY.EditCustomAttributes = ""
			BusinessDetails.Currency_WOLRDPAY.EditValue = ew_HtmlEncode(BusinessDetails.Currency_WOLRDPAY.CurrentValue)
			BusinessDetails.Currency_WOLRDPAY.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Currency_WOLRDPAY.FldCaption))

			' Tip_percent
			BusinessDetails.Tip_percent.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Tip_percent.EditCustomAttributes = ""
			BusinessDetails.Tip_percent.EditValue = ew_HtmlEncode(BusinessDetails.Tip_percent.CurrentValue)
			BusinessDetails.Tip_percent.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Tip_percent.FldCaption))

			' Tax_Percent
			BusinessDetails.Tax_Percent.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Tax_Percent.EditCustomAttributes = ""
			BusinessDetails.Tax_Percent.EditValue = ew_HtmlEncode(BusinessDetails.Tax_Percent.CurrentValue)
			BusinessDetails.Tax_Percent.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Tax_Percent.FldCaption))

			' InRestaurantTaxChargeOnly
			BusinessDetails.InRestaurantTaxChargeOnly.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.InRestaurantTaxChargeOnly.EditCustomAttributes = ""
			BusinessDetails.InRestaurantTaxChargeOnly.EditValue = ew_HtmlEncode(BusinessDetails.InRestaurantTaxChargeOnly.CurrentValue)
			BusinessDetails.InRestaurantTaxChargeOnly.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.InRestaurantTaxChargeOnly.FldCaption))

			' InRestaurantTipChargeOnly
			BusinessDetails.InRestaurantTipChargeOnly.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.InRestaurantTipChargeOnly.EditCustomAttributes = ""
			BusinessDetails.InRestaurantTipChargeOnly.EditValue = ew_HtmlEncode(BusinessDetails.InRestaurantTipChargeOnly.CurrentValue)
			BusinessDetails.InRestaurantTipChargeOnly.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.InRestaurantTipChargeOnly.FldCaption))

			' isCheckCapcha
			BusinessDetails.isCheckCapcha.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.isCheckCapcha.EditCustomAttributes = ""
			BusinessDetails.isCheckCapcha.EditValue = ew_HtmlEncode(BusinessDetails.isCheckCapcha.CurrentValue)
			BusinessDetails.isCheckCapcha.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.isCheckCapcha.FldCaption))

			' Close_StartDate
			BusinessDetails.Close_StartDate.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Close_StartDate.EditCustomAttributes = ""
			BusinessDetails.Close_StartDate.EditValue = ew_HtmlEncode(BusinessDetails.Close_StartDate.CurrentValue)
			BusinessDetails.Close_StartDate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Close_StartDate.FldCaption))

			' Close_EndDate
			BusinessDetails.Close_EndDate.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Close_EndDate.EditCustomAttributes = ""
			BusinessDetails.Close_EndDate.EditValue = ew_HtmlEncode(BusinessDetails.Close_EndDate.CurrentValue)
			BusinessDetails.Close_EndDate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Close_EndDate.FldCaption))

			' Stripe_Country
			BusinessDetails.Stripe_Country.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Stripe_Country.EditCustomAttributes = ""
			BusinessDetails.Stripe_Country.EditValue = ew_HtmlEncode(BusinessDetails.Stripe_Country.CurrentValue)
			BusinessDetails.Stripe_Country.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Stripe_Country.FldCaption))

			' enable_StripePaymentButton
			BusinessDetails.enable_StripePaymentButton.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.enable_StripePaymentButton.EditCustomAttributes = ""
			BusinessDetails.enable_StripePaymentButton.EditValue = ew_HtmlEncode(BusinessDetails.enable_StripePaymentButton.CurrentValue)
			BusinessDetails.enable_StripePaymentButton.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.enable_StripePaymentButton.FldCaption))

			' enable_CashPayment
			BusinessDetails.enable_CashPayment.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.enable_CashPayment.EditCustomAttributes = ""
			BusinessDetails.enable_CashPayment.EditValue = ew_HtmlEncode(BusinessDetails.enable_CashPayment.CurrentValue)
			BusinessDetails.enable_CashPayment.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.enable_CashPayment.FldCaption))

			' DeliveryMile
			BusinessDetails.DeliveryMile.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.DeliveryMile.EditCustomAttributes = ""
			BusinessDetails.DeliveryMile.EditValue = ew_HtmlEncode(BusinessDetails.DeliveryMile.CurrentValue)
			BusinessDetails.DeliveryMile.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.DeliveryMile.FldCaption))
			If BusinessDetails.DeliveryMile.EditValue&"" <> "" And IsNumeric(BusinessDetails.DeliveryMile.EditValue) Then BusinessDetails.DeliveryMile.EditValue = ew_FormatNumber2(BusinessDetails.DeliveryMile.EditValue, -2)

			' Mon_Delivery
			BusinessDetails.Mon_Delivery.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Mon_Delivery.EditCustomAttributes = ""
			BusinessDetails.Mon_Delivery.EditValue = ew_HtmlEncode(BusinessDetails.Mon_Delivery.CurrentValue)
			BusinessDetails.Mon_Delivery.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Mon_Delivery.FldCaption))

			' Mon_Collection
			BusinessDetails.Mon_Collection.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Mon_Collection.EditCustomAttributes = ""
			BusinessDetails.Mon_Collection.EditValue = ew_HtmlEncode(BusinessDetails.Mon_Collection.CurrentValue)
			BusinessDetails.Mon_Collection.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Mon_Collection.FldCaption))

			' Tue_Delivery
			BusinessDetails.Tue_Delivery.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Tue_Delivery.EditCustomAttributes = ""
			BusinessDetails.Tue_Delivery.EditValue = ew_HtmlEncode(BusinessDetails.Tue_Delivery.CurrentValue)
			BusinessDetails.Tue_Delivery.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Tue_Delivery.FldCaption))

			' Tue_Collection
			BusinessDetails.Tue_Collection.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Tue_Collection.EditCustomAttributes = ""
			BusinessDetails.Tue_Collection.EditValue = ew_HtmlEncode(BusinessDetails.Tue_Collection.CurrentValue)
			BusinessDetails.Tue_Collection.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Tue_Collection.FldCaption))

			' Wed_Delivery
			BusinessDetails.Wed_Delivery.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Wed_Delivery.EditCustomAttributes = ""
			BusinessDetails.Wed_Delivery.EditValue = ew_HtmlEncode(BusinessDetails.Wed_Delivery.CurrentValue)
			BusinessDetails.Wed_Delivery.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Wed_Delivery.FldCaption))

			' Wed_Collection
			BusinessDetails.Wed_Collection.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Wed_Collection.EditCustomAttributes = ""
			BusinessDetails.Wed_Collection.EditValue = ew_HtmlEncode(BusinessDetails.Wed_Collection.CurrentValue)
			BusinessDetails.Wed_Collection.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Wed_Collection.FldCaption))

			' Thu_Delivery
			BusinessDetails.Thu_Delivery.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Thu_Delivery.EditCustomAttributes = ""
			BusinessDetails.Thu_Delivery.EditValue = ew_HtmlEncode(BusinessDetails.Thu_Delivery.CurrentValue)
			BusinessDetails.Thu_Delivery.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Thu_Delivery.FldCaption))

			' Thu_Collection
			BusinessDetails.Thu_Collection.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Thu_Collection.EditCustomAttributes = ""
			BusinessDetails.Thu_Collection.EditValue = ew_HtmlEncode(BusinessDetails.Thu_Collection.CurrentValue)
			BusinessDetails.Thu_Collection.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Thu_Collection.FldCaption))

			' Fri_Delivery
			BusinessDetails.Fri_Delivery.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Fri_Delivery.EditCustomAttributes = ""
			BusinessDetails.Fri_Delivery.EditValue = ew_HtmlEncode(BusinessDetails.Fri_Delivery.CurrentValue)
			BusinessDetails.Fri_Delivery.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Fri_Delivery.FldCaption))

			' Fri_Collection
			BusinessDetails.Fri_Collection.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Fri_Collection.EditCustomAttributes = ""
			BusinessDetails.Fri_Collection.EditValue = ew_HtmlEncode(BusinessDetails.Fri_Collection.CurrentValue)
			BusinessDetails.Fri_Collection.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Fri_Collection.FldCaption))

			' Sat_Delivery
			BusinessDetails.Sat_Delivery.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Sat_Delivery.EditCustomAttributes = ""
			BusinessDetails.Sat_Delivery.EditValue = ew_HtmlEncode(BusinessDetails.Sat_Delivery.CurrentValue)
			BusinessDetails.Sat_Delivery.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Sat_Delivery.FldCaption))

			' Sat_Collection
			BusinessDetails.Sat_Collection.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Sat_Collection.EditCustomAttributes = ""
			BusinessDetails.Sat_Collection.EditValue = ew_HtmlEncode(BusinessDetails.Sat_Collection.CurrentValue)
			BusinessDetails.Sat_Collection.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Sat_Collection.FldCaption))

			' Sun_Delivery
			BusinessDetails.Sun_Delivery.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Sun_Delivery.EditCustomAttributes = ""
			BusinessDetails.Sun_Delivery.EditValue = ew_HtmlEncode(BusinessDetails.Sun_Delivery.CurrentValue)
			BusinessDetails.Sun_Delivery.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Sun_Delivery.FldCaption))

			' Sun_Collection
			BusinessDetails.Sun_Collection.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Sun_Collection.EditCustomAttributes = ""
			BusinessDetails.Sun_Collection.EditValue = ew_HtmlEncode(BusinessDetails.Sun_Collection.CurrentValue)
			BusinessDetails.Sun_Collection.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Sun_Collection.FldCaption))

			' EnableUrlRewrite
			BusinessDetails.EnableUrlRewrite.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.EnableUrlRewrite.EditCustomAttributes = ""
			BusinessDetails.EnableUrlRewrite.EditValue = ew_HtmlEncode(BusinessDetails.EnableUrlRewrite.CurrentValue)
			BusinessDetails.EnableUrlRewrite.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.EnableUrlRewrite.FldCaption))

			' DeliveryCostUpTo
			BusinessDetails.DeliveryCostUpTo.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.DeliveryCostUpTo.EditCustomAttributes = ""
			BusinessDetails.DeliveryCostUpTo.EditValue = ew_HtmlEncode(BusinessDetails.DeliveryCostUpTo.CurrentValue)
			BusinessDetails.DeliveryCostUpTo.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.DeliveryCostUpTo.FldCaption))
			If BusinessDetails.DeliveryCostUpTo.EditValue&"" <> "" And IsNumeric(BusinessDetails.DeliveryCostUpTo.EditValue) Then BusinessDetails.DeliveryCostUpTo.EditValue = ew_FormatNumber2(BusinessDetails.DeliveryCostUpTo.EditValue, -2)

			' DeliveryUptoMile
			BusinessDetails.DeliveryUptoMile.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.DeliveryUptoMile.EditCustomAttributes = ""
			BusinessDetails.DeliveryUptoMile.EditValue = ew_HtmlEncode(BusinessDetails.DeliveryUptoMile.CurrentValue)
			BusinessDetails.DeliveryUptoMile.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.DeliveryUptoMile.FldCaption))
			If BusinessDetails.DeliveryUptoMile.EditValue&"" <> "" And IsNumeric(BusinessDetails.DeliveryUptoMile.EditValue) Then BusinessDetails.DeliveryUptoMile.EditValue = ew_FormatNumber2(BusinessDetails.DeliveryUptoMile.EditValue, -2)

			' Show_Ordernumner_printer
			BusinessDetails.Show_Ordernumner_printer.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Show_Ordernumner_printer.EditCustomAttributes = ""
			BusinessDetails.Show_Ordernumner_printer.EditValue = ew_HtmlEncode(BusinessDetails.Show_Ordernumner_printer.CurrentValue)
			BusinessDetails.Show_Ordernumner_printer.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Show_Ordernumner_printer.FldCaption))

			' Show_Ordernumner_Receipt
			BusinessDetails.Show_Ordernumner_Receipt.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Show_Ordernumner_Receipt.EditCustomAttributes = ""
			BusinessDetails.Show_Ordernumner_Receipt.EditValue = ew_HtmlEncode(BusinessDetails.Show_Ordernumner_Receipt.CurrentValue)
			BusinessDetails.Show_Ordernumner_Receipt.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Show_Ordernumner_Receipt.FldCaption))

			' Show_Ordernumner_Dashboard
			BusinessDetails.Show_Ordernumner_Dashboard.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Show_Ordernumner_Dashboard.EditCustomAttributes = ""
			BusinessDetails.Show_Ordernumner_Dashboard.EditValue = ew_HtmlEncode(BusinessDetails.Show_Ordernumner_Dashboard.CurrentValue)
			BusinessDetails.Show_Ordernumner_Dashboard.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Show_Ordernumner_Dashboard.FldCaption))

			' Edit refer script
			' Name

			BusinessDetails.Name.HrefValue = ""

			' Address
			BusinessDetails.Address.HrefValue = ""

			' PostalCode
			BusinessDetails.PostalCode.HrefValue = ""

			' FoodType
			BusinessDetails.FoodType.HrefValue = ""

			' DeliveryMinAmount
			BusinessDetails.DeliveryMinAmount.HrefValue = ""

			' DeliveryMaxDistance
			BusinessDetails.DeliveryMaxDistance.HrefValue = ""

			' DeliveryFreeDistance
			BusinessDetails.DeliveryFreeDistance.HrefValue = ""

			' AverageDeliveryTime
			BusinessDetails.AverageDeliveryTime.HrefValue = ""

			' AverageCollectionTime
			BusinessDetails.AverageCollectionTime.HrefValue = ""

			' DeliveryFee
			BusinessDetails.DeliveryFee.HrefValue = ""

			' ImgUrl
			BusinessDetails.ImgUrl.HrefValue = ""

			' Telephone
			BusinessDetails.Telephone.HrefValue = ""

			' Email
			BusinessDetails.zEmail.HrefValue = ""

			' pswd
			BusinessDetails.pswd.HrefValue = ""

			' businessclosed
			BusinessDetails.businessclosed.HrefValue = ""

			' announcement
			BusinessDetails.announcement.HrefValue = ""

			' css
			BusinessDetails.css.HrefValue = ""

			' SMTP_AUTENTICATE
			BusinessDetails.SMTP_AUTENTICATE.HrefValue = ""

			' MAIL_FROM
			BusinessDetails.MAIL_FROM.HrefValue = ""

			' PAYPAL_URL
			BusinessDetails.PAYPAL_URL.HrefValue = ""

			' PAYPAL_PDT
			BusinessDetails.PAYPAL_PDT.HrefValue = ""

			' SMTP_PASSWORD
			BusinessDetails.SMTP_PASSWORD.HrefValue = ""

			' GMAP_API_KEY
			BusinessDetails.GMAP_API_KEY.HrefValue = ""

			' SMTP_USERNAME
			BusinessDetails.SMTP_USERNAME.HrefValue = ""

			' SMTP_USESSL
			BusinessDetails.SMTP_USESSL.HrefValue = ""

			' MAIL_SUBJECT
			BusinessDetails.MAIL_SUBJECT.HrefValue = ""

			' CURRENCYSYMBOL
			BusinessDetails.CURRENCYSYMBOL.HrefValue = ""

			' SMTP_SERVER
			BusinessDetails.SMTP_SERVER.HrefValue = ""

			' CREDITCARDSURCHARGE
			BusinessDetails.CREDITCARDSURCHARGE.HrefValue = ""

			' SMTP_PORT
			BusinessDetails.SMTP_PORT.HrefValue = ""

			' STICK_MENU
			BusinessDetails.STICK_MENU.HrefValue = ""

			' MAIL_CUSTOMER_SUBJECT
			BusinessDetails.MAIL_CUSTOMER_SUBJECT.HrefValue = ""

			' CONFIRMATION_EMAIL_ADDRESS
			BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.HrefValue = ""

			' SEND_ORDERS_TO_PRINTER
			BusinessDetails.SEND_ORDERS_TO_PRINTER.HrefValue = ""

			' timezone
			BusinessDetails.timezone.HrefValue = ""

			' PAYPAL_ADDR
			BusinessDetails.PAYPAL_ADDR.HrefValue = ""

			' nochex
			BusinessDetails.nochex.HrefValue = ""

			' nochexmerchantid
			BusinessDetails.nochexmerchantid.HrefValue = ""

			' paypal
			BusinessDetails.paypal.HrefValue = ""

			' IBT_API_KEY
			BusinessDetails.IBT_API_KEY.HrefValue = ""

			' IBP_API_PASSWORD
			BusinessDetails.IBP_API_PASSWORD.HrefValue = ""

			' disable_delivery
			BusinessDetails.disable_delivery.HrefValue = ""

			' disable_collection
			BusinessDetails.disable_collection.HrefValue = ""

			' worldpay
			BusinessDetails.worldpay.HrefValue = ""

			' worldpaymerchantid
			BusinessDetails.worldpaymerchantid.HrefValue = ""

			' backtohometext
			BusinessDetails.backtohometext.HrefValue = ""

			' closedtext
			BusinessDetails.closedtext.HrefValue = ""

			' DeliveryChargeOverrideByOrderValue
			BusinessDetails.DeliveryChargeOverrideByOrderValue.HrefValue = ""

			' individualpostcodes
			BusinessDetails.individualpostcodes.HrefValue = ""

			' individualpostcodeschecking
			BusinessDetails.individualpostcodeschecking.HrefValue = ""

			' longitude
			BusinessDetails.longitude.HrefValue = ""

			' latitude
			BusinessDetails.latitude.HrefValue = ""

			' googleecommercetracking
			BusinessDetails.googleecommercetracking.HrefValue = ""

			' googleecommercetrackingcode
			BusinessDetails.googleecommercetrackingcode.HrefValue = ""

			' bringg
			BusinessDetails.bringg.HrefValue = ""

			' bringgurl
			BusinessDetails.bringgurl.HrefValue = ""

			' bringgcompanyid
			BusinessDetails.bringgcompanyid.HrefValue = ""

			' orderonlywhenopen
			BusinessDetails.orderonlywhenopen.HrefValue = ""

			' disablelaterdelivery
			BusinessDetails.disablelaterdelivery.HrefValue = ""

			' menupagetext
			BusinessDetails.menupagetext.HrefValue = ""

			' ordertodayonly
			BusinessDetails.ordertodayonly.HrefValue = ""

			' mileskm
			BusinessDetails.mileskm.HrefValue = ""

			' worldpaylive
			BusinessDetails.worldpaylive.HrefValue = ""

			' worldpayinstallationid
			BusinessDetails.worldpayinstallationid.HrefValue = ""

			' DistanceCalMethod
			BusinessDetails.DistanceCalMethod.HrefValue = ""

			' PrinterIDList
			BusinessDetails.PrinterIDList.HrefValue = ""

			' EpsonJSPrinterURL
			BusinessDetails.EpsonJSPrinterURL.HrefValue = ""

			' SMSEnable
			BusinessDetails.SMSEnable.HrefValue = ""

			' SMSOnDelivery
			BusinessDetails.SMSOnDelivery.HrefValue = ""

			' SMSSupplierDomain
			BusinessDetails.SMSSupplierDomain.HrefValue = ""

			' SMSOnOrder
			BusinessDetails.SMSOnOrder.HrefValue = ""

			' SMSOnOrderAfterMin
			BusinessDetails.SMSOnOrderAfterMin.HrefValue = ""

			' SMSOnOrderContent
			BusinessDetails.SMSOnOrderContent.HrefValue = ""

			' DefaultSMSCountryCode
			BusinessDetails.DefaultSMSCountryCode.HrefValue = ""

			' MinimumAmountForCardPayment
			BusinessDetails.MinimumAmountForCardPayment.HrefValue = ""

			' FavIconUrl
			BusinessDetails.FavIconUrl.HrefValue = ""

			' AddToHomeScreenURL
			BusinessDetails.AddToHomeScreenURL.HrefValue = ""

			' SMSOnAcknowledgement
			BusinessDetails.SMSOnAcknowledgement.HrefValue = ""

			' LocalPrinterURL
			BusinessDetails.LocalPrinterURL.HrefValue = ""

			' ShowRestaurantDetailOnReceipt
			BusinessDetails.ShowRestaurantDetailOnReceipt.HrefValue = ""

			' PrinterFontSizeRatio
			BusinessDetails.PrinterFontSizeRatio.HrefValue = ""

			' ServiceChargePercentage
			BusinessDetails.ServiceChargePercentage.HrefValue = ""

			' InRestaurantServiceChargeOnly
			BusinessDetails.InRestaurantServiceChargeOnly.HrefValue = ""

			' IsDualReceiptPrinting
			BusinessDetails.IsDualReceiptPrinting.HrefValue = ""

			' PrintingFontSize
			BusinessDetails.PrintingFontSize.HrefValue = ""

			' InRestaurantEpsonPrinterIDList
			BusinessDetails.InRestaurantEpsonPrinterIDList.HrefValue = ""

			' BlockIPEmailList
			BusinessDetails.BlockIPEmailList.HrefValue = ""

			' inmenuannouncement
			BusinessDetails.inmenuannouncement.HrefValue = ""

			' RePrintReceiptWays
			BusinessDetails.RePrintReceiptWays.HrefValue = ""

			' printingtype
			BusinessDetails.printingtype.HrefValue = ""

			' Stripe_Key_Secret
			BusinessDetails.Stripe_Key_Secret.HrefValue = ""

			' Stripe
			BusinessDetails.Stripe.HrefValue = ""

			' Stripe_Api_Key
			BusinessDetails.Stripe_Api_Key.HrefValue = ""

			' EnableBooking
			BusinessDetails.EnableBooking.HrefValue = ""

			' URL_Facebook
			BusinessDetails.URL_Facebook.HrefValue = ""

			' URL_Twitter
			BusinessDetails.URL_Twitter.HrefValue = ""

			' URL_Google
			BusinessDetails.URL_Google.HrefValue = ""

			' URL_Intagram
			BusinessDetails.URL_Intagram.HrefValue = ""

			' URL_YouTube
			BusinessDetails.URL_YouTube.HrefValue = ""

			' URL_Tripadvisor
			BusinessDetails.URL_Tripadvisor.HrefValue = ""

			' URL_Special_Offer
			BusinessDetails.URL_Special_Offer.HrefValue = ""

			' URL_Linkin
			BusinessDetails.URL_Linkin.HrefValue = ""

			' Currency_PAYPAL
			BusinessDetails.Currency_PAYPAL.HrefValue = ""

			' Currency_STRIPE
			BusinessDetails.Currency_STRIPE.HrefValue = ""

			' Currency_WOLRDPAY
			BusinessDetails.Currency_WOLRDPAY.HrefValue = ""

			' Tip_percent
			BusinessDetails.Tip_percent.HrefValue = ""

			' Tax_Percent
			BusinessDetails.Tax_Percent.HrefValue = ""

			' InRestaurantTaxChargeOnly
			BusinessDetails.InRestaurantTaxChargeOnly.HrefValue = ""

			' InRestaurantTipChargeOnly
			BusinessDetails.InRestaurantTipChargeOnly.HrefValue = ""

			' isCheckCapcha
			BusinessDetails.isCheckCapcha.HrefValue = ""

			' Close_StartDate
			BusinessDetails.Close_StartDate.HrefValue = ""

			' Close_EndDate
			BusinessDetails.Close_EndDate.HrefValue = ""

			' Stripe_Country
			BusinessDetails.Stripe_Country.HrefValue = ""

			' enable_StripePaymentButton
			BusinessDetails.enable_StripePaymentButton.HrefValue = ""

			' enable_CashPayment
			BusinessDetails.enable_CashPayment.HrefValue = ""

			' DeliveryMile
			BusinessDetails.DeliveryMile.HrefValue = ""

			' Mon_Delivery
			BusinessDetails.Mon_Delivery.HrefValue = ""

			' Mon_Collection
			BusinessDetails.Mon_Collection.HrefValue = ""

			' Tue_Delivery
			BusinessDetails.Tue_Delivery.HrefValue = ""

			' Tue_Collection
			BusinessDetails.Tue_Collection.HrefValue = ""

			' Wed_Delivery
			BusinessDetails.Wed_Delivery.HrefValue = ""

			' Wed_Collection
			BusinessDetails.Wed_Collection.HrefValue = ""

			' Thu_Delivery
			BusinessDetails.Thu_Delivery.HrefValue = ""

			' Thu_Collection
			BusinessDetails.Thu_Collection.HrefValue = ""

			' Fri_Delivery
			BusinessDetails.Fri_Delivery.HrefValue = ""

			' Fri_Collection
			BusinessDetails.Fri_Collection.HrefValue = ""

			' Sat_Delivery
			BusinessDetails.Sat_Delivery.HrefValue = ""

			' Sat_Collection
			BusinessDetails.Sat_Collection.HrefValue = ""

			' Sun_Delivery
			BusinessDetails.Sun_Delivery.HrefValue = ""

			' Sun_Collection
			BusinessDetails.Sun_Collection.HrefValue = ""

			' EnableUrlRewrite
			BusinessDetails.EnableUrlRewrite.HrefValue = ""

			' DeliveryCostUpTo
			BusinessDetails.DeliveryCostUpTo.HrefValue = ""

			' DeliveryUptoMile
			BusinessDetails.DeliveryUptoMile.HrefValue = ""

			' Show_Ordernumner_printer
			BusinessDetails.Show_Ordernumner_printer.HrefValue = ""

			' Show_Ordernumner_Receipt
			BusinessDetails.Show_Ordernumner_Receipt.HrefValue = ""

			' Show_Ordernumner_Dashboard
			BusinessDetails.Show_Ordernumner_Dashboard.HrefValue = ""
		End If
		If BusinessDetails.RowType = EW_ROWTYPE_ADD Or BusinessDetails.RowType = EW_ROWTYPE_EDIT Or BusinessDetails.RowType = EW_ROWTYPE_SEARCH Then ' Add / Edit / Search row
			Call BusinessDetails.SetupFieldTitles()
		End If

		' Call Row Rendered event
		If BusinessDetails.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call BusinessDetails.Row_Rendered()
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
		If BusinessDetails.Name.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.Address.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.PostalCode.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.FoodType.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.DeliveryMinAmount.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.DeliveryMaxDistance.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.DeliveryFreeDistance.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.AverageDeliveryTime.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.AverageCollectionTime.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.DeliveryFee.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.ImgUrl.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.Telephone.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.zEmail.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.pswd.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.businessclosed.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.announcement.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.css.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.SMTP_AUTENTICATE.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.MAIL_FROM.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.PAYPAL_URL.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.PAYPAL_PDT.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.SMTP_PASSWORD.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.GMAP_API_KEY.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.SMTP_USERNAME.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.SMTP_USESSL.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.MAIL_SUBJECT.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.CURRENCYSYMBOL.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.SMTP_SERVER.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.CREDITCARDSURCHARGE.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.SMTP_PORT.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.STICK_MENU.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.MAIL_CUSTOMER_SUBJECT.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.SEND_ORDERS_TO_PRINTER.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.timezone.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.PAYPAL_ADDR.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.nochex.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.nochexmerchantid.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.paypal.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.IBT_API_KEY.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.IBP_API_PASSWORD.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.disable_delivery.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.disable_collection.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.worldpay.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.worldpaymerchantid.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.backtohometext.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.closedtext.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.DeliveryChargeOverrideByOrderValue.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.individualpostcodes.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.individualpostcodeschecking.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.longitude.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.latitude.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.googleecommercetracking.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.googleecommercetrackingcode.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.bringg.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.bringgurl.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.bringgcompanyid.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.orderonlywhenopen.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.disablelaterdelivery.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.menupagetext.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.ordertodayonly.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.mileskm.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.worldpaylive.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.worldpayinstallationid.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.DistanceCalMethod.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.PrinterIDList.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.EpsonJSPrinterURL.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.SMSEnable.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.SMSOnDelivery.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.SMSSupplierDomain.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.SMSOnOrder.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.SMSOnOrderAfterMin.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.SMSOnOrderContent.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.DefaultSMSCountryCode.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.MinimumAmountForCardPayment.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.FavIconUrl.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.AddToHomeScreenURL.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.SMSOnAcknowledgement.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.LocalPrinterURL.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.ShowRestaurantDetailOnReceipt.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.PrinterFontSizeRatio.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.ServiceChargePercentage.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.InRestaurantServiceChargeOnly.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.IsDualReceiptPrinting.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.PrintingFontSize.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.InRestaurantEpsonPrinterIDList.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.BlockIPEmailList.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.inmenuannouncement.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.RePrintReceiptWays.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.printingtype.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.Stripe_Key_Secret.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.Stripe.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.Stripe_Api_Key.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.EnableBooking.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.URL_Facebook.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.URL_Twitter.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.URL_Google.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.URL_Intagram.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.URL_YouTube.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.URL_Tripadvisor.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.URL_Special_Offer.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.URL_Linkin.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.Currency_PAYPAL.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.Currency_STRIPE.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.Currency_WOLRDPAY.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.Tip_percent.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.Tax_Percent.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.InRestaurantTaxChargeOnly.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.InRestaurantTipChargeOnly.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.isCheckCapcha.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.Close_StartDate.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.Close_EndDate.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.Stripe_Country.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.enable_StripePaymentButton.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.enable_CashPayment.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.DeliveryMile.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.Mon_Delivery.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.Mon_Collection.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.Tue_Delivery.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.Tue_Collection.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.Wed_Delivery.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.Wed_Collection.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.Thu_Delivery.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.Thu_Collection.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.Fri_Delivery.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.Fri_Collection.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.Sat_Delivery.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.Sat_Collection.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.Sun_Delivery.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.Sun_Collection.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.EnableUrlRewrite.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.DeliveryCostUpTo.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.DeliveryUptoMile.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.Show_Ordernumner_printer.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.Show_Ordernumner_Receipt.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
		If BusinessDetails.Show_Ordernumner_Dashboard.MultiUpdate = "1" Then lUpdateCnt = lUpdateCnt + 1
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
		If BusinessDetails.DeliveryMinAmount.MultiUpdate <> "" Then
			If Not ew_CheckInteger(BusinessDetails.DeliveryMinAmount.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.DeliveryMinAmount.FldErrMsg)
			End If
		End If
		If BusinessDetails.DeliveryMaxDistance.MultiUpdate <> "" Then
			If Not ew_CheckNumber(BusinessDetails.DeliveryMaxDistance.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.DeliveryMaxDistance.FldErrMsg)
			End If
		End If
		If BusinessDetails.DeliveryFreeDistance.MultiUpdate <> "" Then
			If Not ew_CheckNumber(BusinessDetails.DeliveryFreeDistance.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.DeliveryFreeDistance.FldErrMsg)
			End If
		End If
		If BusinessDetails.AverageDeliveryTime.MultiUpdate <> "" Then
			If Not ew_CheckInteger(BusinessDetails.AverageDeliveryTime.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.AverageDeliveryTime.FldErrMsg)
			End If
		End If
		If BusinessDetails.AverageCollectionTime.MultiUpdate <> "" Then
			If Not ew_CheckInteger(BusinessDetails.AverageCollectionTime.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.AverageCollectionTime.FldErrMsg)
			End If
		End If
		If BusinessDetails.DeliveryFee.MultiUpdate <> "" Then
			If Not ew_CheckNumber(BusinessDetails.DeliveryFee.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.DeliveryFee.FldErrMsg)
			End If
		End If
		If BusinessDetails.businessclosed.MultiUpdate <> "" Then
			If Not ew_CheckInteger(BusinessDetails.businessclosed.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.businessclosed.FldErrMsg)
			End If
		End If
		If BusinessDetails.timezone.MultiUpdate <> "" Then
			If Not ew_CheckInteger(BusinessDetails.timezone.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.timezone.FldErrMsg)
			End If
		End If
		If BusinessDetails.individualpostcodeschecking.MultiUpdate <> "" Then
			If Not ew_CheckInteger(BusinessDetails.individualpostcodeschecking.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.individualpostcodeschecking.FldErrMsg)
			End If
		End If
		If BusinessDetails.orderonlywhenopen.MultiUpdate <> "" Then
			If Not ew_CheckInteger(BusinessDetails.orderonlywhenopen.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.orderonlywhenopen.FldErrMsg)
			End If
		End If
		If BusinessDetails.disablelaterdelivery.MultiUpdate <> "" Then
			If Not ew_CheckInteger(BusinessDetails.disablelaterdelivery.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.disablelaterdelivery.FldErrMsg)
			End If
		End If
		If BusinessDetails.ordertodayonly.MultiUpdate <> "" Then
			If Not ew_CheckInteger(BusinessDetails.ordertodayonly.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.ordertodayonly.FldErrMsg)
			End If
		End If
		If BusinessDetails.worldpaylive.MultiUpdate <> "" Then
			If Not ew_CheckInteger(BusinessDetails.worldpaylive.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.worldpaylive.FldErrMsg)
			End If
		End If
		If BusinessDetails.SMSEnable.MultiUpdate <> "" Then
			If Not ew_CheckInteger(BusinessDetails.SMSEnable.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.SMSEnable.FldErrMsg)
			End If
		End If
		If BusinessDetails.SMSOnDelivery.MultiUpdate <> "" Then
			If Not ew_CheckInteger(BusinessDetails.SMSOnDelivery.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.SMSOnDelivery.FldErrMsg)
			End If
		End If
		If BusinessDetails.SMSOnOrder.MultiUpdate <> "" Then
			If Not ew_CheckInteger(BusinessDetails.SMSOnOrder.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.SMSOnOrder.FldErrMsg)
			End If
		End If
		If BusinessDetails.SMSOnOrderAfterMin.MultiUpdate <> "" Then
			If Not ew_CheckInteger(BusinessDetails.SMSOnOrderAfterMin.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.SMSOnOrderAfterMin.FldErrMsg)
			End If
		End If
		If BusinessDetails.MinimumAmountForCardPayment.MultiUpdate <> "" Then
			If Not ew_CheckNumber(BusinessDetails.MinimumAmountForCardPayment.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.MinimumAmountForCardPayment.FldErrMsg)
			End If
		End If
		If BusinessDetails.SMSOnAcknowledgement.MultiUpdate <> "" Then
			If Not ew_CheckInteger(BusinessDetails.SMSOnAcknowledgement.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.SMSOnAcknowledgement.FldErrMsg)
			End If
		End If
		If BusinessDetails.ShowRestaurantDetailOnReceipt.MultiUpdate <> "" Then
			If Not ew_CheckInteger(BusinessDetails.ShowRestaurantDetailOnReceipt.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.ShowRestaurantDetailOnReceipt.FldErrMsg)
			End If
		End If
		If BusinessDetails.PrinterFontSizeRatio.MultiUpdate <> "" Then
			If Not ew_CheckNumber(BusinessDetails.PrinterFontSizeRatio.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.PrinterFontSizeRatio.FldErrMsg)
			End If
		End If
		If BusinessDetails.ServiceChargePercentage.MultiUpdate <> "" Then
			If Not ew_CheckNumber(BusinessDetails.ServiceChargePercentage.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.ServiceChargePercentage.FldErrMsg)
			End If
		End If
		If BusinessDetails.InRestaurantServiceChargeOnly.MultiUpdate <> "" Then
			If Not ew_CheckInteger(BusinessDetails.InRestaurantServiceChargeOnly.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.InRestaurantServiceChargeOnly.FldErrMsg)
			End If
		End If
		If BusinessDetails.IsDualReceiptPrinting.MultiUpdate <> "" Then
			If Not ew_CheckInteger(BusinessDetails.IsDualReceiptPrinting.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.IsDualReceiptPrinting.FldErrMsg)
			End If
		End If
		If BusinessDetails.PrintingFontSize.MultiUpdate <> "" Then
			If Not ew_CheckNumber(BusinessDetails.PrintingFontSize.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.PrintingFontSize.FldErrMsg)
			End If
		End If
		If BusinessDetails.Tip_percent.MultiUpdate <> "" Then
			If Not ew_CheckInteger(BusinessDetails.Tip_percent.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.Tip_percent.FldErrMsg)
			End If
		End If
		If BusinessDetails.Tax_Percent.MultiUpdate <> "" Then
			If Not ew_CheckInteger(BusinessDetails.Tax_Percent.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.Tax_Percent.FldErrMsg)
			End If
		End If
		If BusinessDetails.InRestaurantTaxChargeOnly.MultiUpdate <> "" Then
			If Not ew_CheckInteger(BusinessDetails.InRestaurantTaxChargeOnly.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.InRestaurantTaxChargeOnly.FldErrMsg)
			End If
		End If
		If BusinessDetails.InRestaurantTipChargeOnly.MultiUpdate <> "" Then
			If Not ew_CheckInteger(BusinessDetails.InRestaurantTipChargeOnly.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.InRestaurantTipChargeOnly.FldErrMsg)
			End If
		End If
		If BusinessDetails.DeliveryMile.MultiUpdate <> "" Then
			If Not ew_CheckNumber(BusinessDetails.DeliveryMile.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.DeliveryMile.FldErrMsg)
			End If
		End If
		If BusinessDetails.Mon_Delivery.MultiUpdate <> "" Then
			If Not ew_CheckInteger(BusinessDetails.Mon_Delivery.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.Mon_Delivery.FldErrMsg)
			End If
		End If
		If BusinessDetails.Mon_Collection.MultiUpdate <> "" Then
			If Not ew_CheckInteger(BusinessDetails.Mon_Collection.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.Mon_Collection.FldErrMsg)
			End If
		End If
		If BusinessDetails.Tue_Delivery.MultiUpdate <> "" Then
			If Not ew_CheckInteger(BusinessDetails.Tue_Delivery.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.Tue_Delivery.FldErrMsg)
			End If
		End If
		If BusinessDetails.Tue_Collection.MultiUpdate <> "" Then
			If Not ew_CheckInteger(BusinessDetails.Tue_Collection.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.Tue_Collection.FldErrMsg)
			End If
		End If
		If BusinessDetails.Wed_Delivery.MultiUpdate <> "" Then
			If Not ew_CheckInteger(BusinessDetails.Wed_Delivery.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.Wed_Delivery.FldErrMsg)
			End If
		End If
		If BusinessDetails.Wed_Collection.MultiUpdate <> "" Then
			If Not ew_CheckInteger(BusinessDetails.Wed_Collection.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.Wed_Collection.FldErrMsg)
			End If
		End If
		If BusinessDetails.Thu_Delivery.MultiUpdate <> "" Then
			If Not ew_CheckInteger(BusinessDetails.Thu_Delivery.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.Thu_Delivery.FldErrMsg)
			End If
		End If
		If BusinessDetails.Thu_Collection.MultiUpdate <> "" Then
			If Not ew_CheckInteger(BusinessDetails.Thu_Collection.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.Thu_Collection.FldErrMsg)
			End If
		End If
		If BusinessDetails.Fri_Delivery.MultiUpdate <> "" Then
			If Not ew_CheckInteger(BusinessDetails.Fri_Delivery.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.Fri_Delivery.FldErrMsg)
			End If
		End If
		If BusinessDetails.Fri_Collection.MultiUpdate <> "" Then
			If Not ew_CheckInteger(BusinessDetails.Fri_Collection.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.Fri_Collection.FldErrMsg)
			End If
		End If
		If BusinessDetails.Sat_Delivery.MultiUpdate <> "" Then
			If Not ew_CheckInteger(BusinessDetails.Sat_Delivery.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.Sat_Delivery.FldErrMsg)
			End If
		End If
		If BusinessDetails.Sat_Collection.MultiUpdate <> "" Then
			If Not ew_CheckInteger(BusinessDetails.Sat_Collection.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.Sat_Collection.FldErrMsg)
			End If
		End If
		If BusinessDetails.Sun_Delivery.MultiUpdate <> "" Then
			If Not ew_CheckInteger(BusinessDetails.Sun_Delivery.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.Sun_Delivery.FldErrMsg)
			End If
		End If
		If BusinessDetails.Sun_Collection.MultiUpdate <> "" Then
			If Not ew_CheckInteger(BusinessDetails.Sun_Collection.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.Sun_Collection.FldErrMsg)
			End If
		End If
		If BusinessDetails.DeliveryCostUpTo.MultiUpdate <> "" Then
			If Not ew_CheckNumber(BusinessDetails.DeliveryCostUpTo.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.DeliveryCostUpTo.FldErrMsg)
			End If
		End If
		If BusinessDetails.DeliveryUptoMile.MultiUpdate <> "" Then
			If Not ew_CheckNumber(BusinessDetails.DeliveryUptoMile.FormValue) Then
				Call ew_AddMessage(gsFormError, BusinessDetails.DeliveryUptoMile.FldErrMsg)
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
		sFilter = BusinessDetails.KeyFilter
		BusinessDetails.CurrentFilter  = sFilter
		sSql = BusinessDetails.SQL
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

			' Field Name
			Call BusinessDetails.Name.SetDbValue(Rs, BusinessDetails.Name.CurrentValue, Null, BusinessDetails.Name.ReadOnly Or BusinessDetails.Name.MultiUpdate&"" <> "1")

			' Field Address
			Call BusinessDetails.Address.SetDbValue(Rs, BusinessDetails.Address.CurrentValue, Null, BusinessDetails.Address.ReadOnly Or BusinessDetails.Address.MultiUpdate&"" <> "1")

			' Field PostalCode
			Call BusinessDetails.PostalCode.SetDbValue(Rs, BusinessDetails.PostalCode.CurrentValue, Null, BusinessDetails.PostalCode.ReadOnly Or BusinessDetails.PostalCode.MultiUpdate&"" <> "1")

			' Field FoodType
			Call BusinessDetails.FoodType.SetDbValue(Rs, BusinessDetails.FoodType.CurrentValue, Null, BusinessDetails.FoodType.ReadOnly Or BusinessDetails.FoodType.MultiUpdate&"" <> "1")

			' Field DeliveryMinAmount
			Call BusinessDetails.DeliveryMinAmount.SetDbValue(Rs, BusinessDetails.DeliveryMinAmount.CurrentValue, Null, BusinessDetails.DeliveryMinAmount.ReadOnly Or BusinessDetails.DeliveryMinAmount.MultiUpdate&"" <> "1")

			' Field DeliveryMaxDistance
			Call BusinessDetails.DeliveryMaxDistance.SetDbValue(Rs, BusinessDetails.DeliveryMaxDistance.CurrentValue, Null, BusinessDetails.DeliveryMaxDistance.ReadOnly Or BusinessDetails.DeliveryMaxDistance.MultiUpdate&"" <> "1")

			' Field DeliveryFreeDistance
			Call BusinessDetails.DeliveryFreeDistance.SetDbValue(Rs, BusinessDetails.DeliveryFreeDistance.CurrentValue, Null, BusinessDetails.DeliveryFreeDistance.ReadOnly Or BusinessDetails.DeliveryFreeDistance.MultiUpdate&"" <> "1")

			' Field AverageDeliveryTime
			Call BusinessDetails.AverageDeliveryTime.SetDbValue(Rs, BusinessDetails.AverageDeliveryTime.CurrentValue, Null, BusinessDetails.AverageDeliveryTime.ReadOnly Or BusinessDetails.AverageDeliveryTime.MultiUpdate&"" <> "1")

			' Field AverageCollectionTime
			Call BusinessDetails.AverageCollectionTime.SetDbValue(Rs, BusinessDetails.AverageCollectionTime.CurrentValue, Null, BusinessDetails.AverageCollectionTime.ReadOnly Or BusinessDetails.AverageCollectionTime.MultiUpdate&"" <> "1")

			' Field DeliveryFee
			Call BusinessDetails.DeliveryFee.SetDbValue(Rs, BusinessDetails.DeliveryFee.CurrentValue, Null, BusinessDetails.DeliveryFee.ReadOnly Or BusinessDetails.DeliveryFee.MultiUpdate&"" <> "1")

			' Field ImgUrl
			Call BusinessDetails.ImgUrl.SetDbValue(Rs, BusinessDetails.ImgUrl.CurrentValue, Null, BusinessDetails.ImgUrl.ReadOnly Or BusinessDetails.ImgUrl.MultiUpdate&"" <> "1")

			' Field Telephone
			Call BusinessDetails.Telephone.SetDbValue(Rs, BusinessDetails.Telephone.CurrentValue, Null, BusinessDetails.Telephone.ReadOnly Or BusinessDetails.Telephone.MultiUpdate&"" <> "1")

			' Field Email
			Call BusinessDetails.zEmail.SetDbValue(Rs, BusinessDetails.zEmail.CurrentValue, Null, BusinessDetails.zEmail.ReadOnly Or BusinessDetails.zEmail.MultiUpdate&"" <> "1")

			' Field pswd
			Call BusinessDetails.pswd.SetDbValue(Rs, BusinessDetails.pswd.CurrentValue, Null, BusinessDetails.pswd.ReadOnly Or BusinessDetails.pswd.MultiUpdate&"" <> "1")

			' Field businessclosed
			Call BusinessDetails.businessclosed.SetDbValue(Rs, BusinessDetails.businessclosed.CurrentValue, Null, BusinessDetails.businessclosed.ReadOnly Or BusinessDetails.businessclosed.MultiUpdate&"" <> "1")

			' Field announcement
			Call BusinessDetails.announcement.SetDbValue(Rs, BusinessDetails.announcement.CurrentValue, Null, BusinessDetails.announcement.ReadOnly Or BusinessDetails.announcement.MultiUpdate&"" <> "1")

			' Field css
			Call BusinessDetails.css.SetDbValue(Rs, BusinessDetails.css.CurrentValue, Null, BusinessDetails.css.ReadOnly Or BusinessDetails.css.MultiUpdate&"" <> "1")

			' Field SMTP_AUTENTICATE
			Call BusinessDetails.SMTP_AUTENTICATE.SetDbValue(Rs, BusinessDetails.SMTP_AUTENTICATE.CurrentValue, Null, BusinessDetails.SMTP_AUTENTICATE.ReadOnly Or BusinessDetails.SMTP_AUTENTICATE.MultiUpdate&"" <> "1")

			' Field MAIL_FROM
			Call BusinessDetails.MAIL_FROM.SetDbValue(Rs, BusinessDetails.MAIL_FROM.CurrentValue, Null, BusinessDetails.MAIL_FROM.ReadOnly Or BusinessDetails.MAIL_FROM.MultiUpdate&"" <> "1")

			' Field PAYPAL_URL
			Call BusinessDetails.PAYPAL_URL.SetDbValue(Rs, BusinessDetails.PAYPAL_URL.CurrentValue, Null, BusinessDetails.PAYPAL_URL.ReadOnly Or BusinessDetails.PAYPAL_URL.MultiUpdate&"" <> "1")

			' Field PAYPAL_PDT
			Call BusinessDetails.PAYPAL_PDT.SetDbValue(Rs, BusinessDetails.PAYPAL_PDT.CurrentValue, Null, BusinessDetails.PAYPAL_PDT.ReadOnly Or BusinessDetails.PAYPAL_PDT.MultiUpdate&"" <> "1")

			' Field SMTP_PASSWORD
			Call BusinessDetails.SMTP_PASSWORD.SetDbValue(Rs, BusinessDetails.SMTP_PASSWORD.CurrentValue, Null, BusinessDetails.SMTP_PASSWORD.ReadOnly Or BusinessDetails.SMTP_PASSWORD.MultiUpdate&"" <> "1")

			' Field GMAP_API_KEY
			Call BusinessDetails.GMAP_API_KEY.SetDbValue(Rs, BusinessDetails.GMAP_API_KEY.CurrentValue, Null, BusinessDetails.GMAP_API_KEY.ReadOnly Or BusinessDetails.GMAP_API_KEY.MultiUpdate&"" <> "1")

			' Field SMTP_USERNAME
			Call BusinessDetails.SMTP_USERNAME.SetDbValue(Rs, BusinessDetails.SMTP_USERNAME.CurrentValue, Null, BusinessDetails.SMTP_USERNAME.ReadOnly Or BusinessDetails.SMTP_USERNAME.MultiUpdate&"" <> "1")

			' Field SMTP_USESSL
			Call BusinessDetails.SMTP_USESSL.SetDbValue(Rs, BusinessDetails.SMTP_USESSL.CurrentValue, Null, BusinessDetails.SMTP_USESSL.ReadOnly Or BusinessDetails.SMTP_USESSL.MultiUpdate&"" <> "1")

			' Field MAIL_SUBJECT
			Call BusinessDetails.MAIL_SUBJECT.SetDbValue(Rs, BusinessDetails.MAIL_SUBJECT.CurrentValue, Null, BusinessDetails.MAIL_SUBJECT.ReadOnly Or BusinessDetails.MAIL_SUBJECT.MultiUpdate&"" <> "1")

			' Field CURRENCYSYMBOL
			Call BusinessDetails.CURRENCYSYMBOL.SetDbValue(Rs, BusinessDetails.CURRENCYSYMBOL.CurrentValue, Null, BusinessDetails.CURRENCYSYMBOL.ReadOnly Or BusinessDetails.CURRENCYSYMBOL.MultiUpdate&"" <> "1")

			' Field SMTP_SERVER
			Call BusinessDetails.SMTP_SERVER.SetDbValue(Rs, BusinessDetails.SMTP_SERVER.CurrentValue, Null, BusinessDetails.SMTP_SERVER.ReadOnly Or BusinessDetails.SMTP_SERVER.MultiUpdate&"" <> "1")

			' Field CREDITCARDSURCHARGE
			Call BusinessDetails.CREDITCARDSURCHARGE.SetDbValue(Rs, BusinessDetails.CREDITCARDSURCHARGE.CurrentValue, Null, BusinessDetails.CREDITCARDSURCHARGE.ReadOnly Or BusinessDetails.CREDITCARDSURCHARGE.MultiUpdate&"" <> "1")

			' Field SMTP_PORT
			Call BusinessDetails.SMTP_PORT.SetDbValue(Rs, BusinessDetails.SMTP_PORT.CurrentValue, Null, BusinessDetails.SMTP_PORT.ReadOnly Or BusinessDetails.SMTP_PORT.MultiUpdate&"" <> "1")

			' Field STICK_MENU
			Call BusinessDetails.STICK_MENU.SetDbValue(Rs, BusinessDetails.STICK_MENU.CurrentValue, Null, BusinessDetails.STICK_MENU.ReadOnly Or BusinessDetails.STICK_MENU.MultiUpdate&"" <> "1")

			' Field MAIL_CUSTOMER_SUBJECT
			Call BusinessDetails.MAIL_CUSTOMER_SUBJECT.SetDbValue(Rs, BusinessDetails.MAIL_CUSTOMER_SUBJECT.CurrentValue, Null, BusinessDetails.MAIL_CUSTOMER_SUBJECT.ReadOnly Or BusinessDetails.MAIL_CUSTOMER_SUBJECT.MultiUpdate&"" <> "1")

			' Field CONFIRMATION_EMAIL_ADDRESS
			Call BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.SetDbValue(Rs, BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.CurrentValue, Null, BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.ReadOnly Or BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.MultiUpdate&"" <> "1")

			' Field SEND_ORDERS_TO_PRINTER
			Call BusinessDetails.SEND_ORDERS_TO_PRINTER.SetDbValue(Rs, BusinessDetails.SEND_ORDERS_TO_PRINTER.CurrentValue, Null, BusinessDetails.SEND_ORDERS_TO_PRINTER.ReadOnly Or BusinessDetails.SEND_ORDERS_TO_PRINTER.MultiUpdate&"" <> "1")

			' Field timezone
			Call BusinessDetails.timezone.SetDbValue(Rs, BusinessDetails.timezone.CurrentValue, Null, BusinessDetails.timezone.ReadOnly Or BusinessDetails.timezone.MultiUpdate&"" <> "1")

			' Field PAYPAL_ADDR
			Call BusinessDetails.PAYPAL_ADDR.SetDbValue(Rs, BusinessDetails.PAYPAL_ADDR.CurrentValue, Null, BusinessDetails.PAYPAL_ADDR.ReadOnly Or BusinessDetails.PAYPAL_ADDR.MultiUpdate&"" <> "1")

			' Field nochex
			Call BusinessDetails.nochex.SetDbValue(Rs, BusinessDetails.nochex.CurrentValue, Null, BusinessDetails.nochex.ReadOnly Or BusinessDetails.nochex.MultiUpdate&"" <> "1")

			' Field nochexmerchantid
			Call BusinessDetails.nochexmerchantid.SetDbValue(Rs, BusinessDetails.nochexmerchantid.CurrentValue, Null, BusinessDetails.nochexmerchantid.ReadOnly Or BusinessDetails.nochexmerchantid.MultiUpdate&"" <> "1")

			' Field paypal
			Call BusinessDetails.paypal.SetDbValue(Rs, BusinessDetails.paypal.CurrentValue, Null, BusinessDetails.paypal.ReadOnly Or BusinessDetails.paypal.MultiUpdate&"" <> "1")

			' Field IBT_API_KEY
			Call BusinessDetails.IBT_API_KEY.SetDbValue(Rs, BusinessDetails.IBT_API_KEY.CurrentValue, Null, BusinessDetails.IBT_API_KEY.ReadOnly Or BusinessDetails.IBT_API_KEY.MultiUpdate&"" <> "1")

			' Field IBP_API_PASSWORD
			Call BusinessDetails.IBP_API_PASSWORD.SetDbValue(Rs, BusinessDetails.IBP_API_PASSWORD.CurrentValue, Null, BusinessDetails.IBP_API_PASSWORD.ReadOnly Or BusinessDetails.IBP_API_PASSWORD.MultiUpdate&"" <> "1")

			' Field disable_delivery
			Call BusinessDetails.disable_delivery.SetDbValue(Rs, BusinessDetails.disable_delivery.CurrentValue, Null, BusinessDetails.disable_delivery.ReadOnly Or BusinessDetails.disable_delivery.MultiUpdate&"" <> "1")

			' Field disable_collection
			Call BusinessDetails.disable_collection.SetDbValue(Rs, BusinessDetails.disable_collection.CurrentValue, Null, BusinessDetails.disable_collection.ReadOnly Or BusinessDetails.disable_collection.MultiUpdate&"" <> "1")

			' Field worldpay
			Call BusinessDetails.worldpay.SetDbValue(Rs, BusinessDetails.worldpay.CurrentValue, Null, BusinessDetails.worldpay.ReadOnly Or BusinessDetails.worldpay.MultiUpdate&"" <> "1")

			' Field worldpaymerchantid
			Call BusinessDetails.worldpaymerchantid.SetDbValue(Rs, BusinessDetails.worldpaymerchantid.CurrentValue, Null, BusinessDetails.worldpaymerchantid.ReadOnly Or BusinessDetails.worldpaymerchantid.MultiUpdate&"" <> "1")

			' Field backtohometext
			Call BusinessDetails.backtohometext.SetDbValue(Rs, BusinessDetails.backtohometext.CurrentValue, Null, BusinessDetails.backtohometext.ReadOnly Or BusinessDetails.backtohometext.MultiUpdate&"" <> "1")

			' Field closedtext
			Call BusinessDetails.closedtext.SetDbValue(Rs, BusinessDetails.closedtext.CurrentValue, Null, BusinessDetails.closedtext.ReadOnly Or BusinessDetails.closedtext.MultiUpdate&"" <> "1")

			' Field DeliveryChargeOverrideByOrderValue
			Call BusinessDetails.DeliveryChargeOverrideByOrderValue.SetDbValue(Rs, BusinessDetails.DeliveryChargeOverrideByOrderValue.CurrentValue, Null, BusinessDetails.DeliveryChargeOverrideByOrderValue.ReadOnly Or BusinessDetails.DeliveryChargeOverrideByOrderValue.MultiUpdate&"" <> "1")

			' Field individualpostcodes
			Call BusinessDetails.individualpostcodes.SetDbValue(Rs, BusinessDetails.individualpostcodes.CurrentValue, Null, BusinessDetails.individualpostcodes.ReadOnly Or BusinessDetails.individualpostcodes.MultiUpdate&"" <> "1")

			' Field individualpostcodeschecking
			Call BusinessDetails.individualpostcodeschecking.SetDbValue(Rs, BusinessDetails.individualpostcodeschecking.CurrentValue, Null, BusinessDetails.individualpostcodeschecking.ReadOnly Or BusinessDetails.individualpostcodeschecking.MultiUpdate&"" <> "1")

			' Field longitude
			Call BusinessDetails.longitude.SetDbValue(Rs, BusinessDetails.longitude.CurrentValue, Null, BusinessDetails.longitude.ReadOnly Or BusinessDetails.longitude.MultiUpdate&"" <> "1")

			' Field latitude
			Call BusinessDetails.latitude.SetDbValue(Rs, BusinessDetails.latitude.CurrentValue, Null, BusinessDetails.latitude.ReadOnly Or BusinessDetails.latitude.MultiUpdate&"" <> "1")

			' Field googleecommercetracking
			Call BusinessDetails.googleecommercetracking.SetDbValue(Rs, BusinessDetails.googleecommercetracking.CurrentValue, Null, BusinessDetails.googleecommercetracking.ReadOnly Or BusinessDetails.googleecommercetracking.MultiUpdate&"" <> "1")

			' Field googleecommercetrackingcode
			Call BusinessDetails.googleecommercetrackingcode.SetDbValue(Rs, BusinessDetails.googleecommercetrackingcode.CurrentValue, Null, BusinessDetails.googleecommercetrackingcode.ReadOnly Or BusinessDetails.googleecommercetrackingcode.MultiUpdate&"" <> "1")

			' Field bringg
			Call BusinessDetails.bringg.SetDbValue(Rs, BusinessDetails.bringg.CurrentValue, Null, BusinessDetails.bringg.ReadOnly Or BusinessDetails.bringg.MultiUpdate&"" <> "1")

			' Field bringgurl
			Call BusinessDetails.bringgurl.SetDbValue(Rs, BusinessDetails.bringgurl.CurrentValue, Null, BusinessDetails.bringgurl.ReadOnly Or BusinessDetails.bringgurl.MultiUpdate&"" <> "1")

			' Field bringgcompanyid
			Call BusinessDetails.bringgcompanyid.SetDbValue(Rs, BusinessDetails.bringgcompanyid.CurrentValue, Null, BusinessDetails.bringgcompanyid.ReadOnly Or BusinessDetails.bringgcompanyid.MultiUpdate&"" <> "1")

			' Field orderonlywhenopen
			Call BusinessDetails.orderonlywhenopen.SetDbValue(Rs, BusinessDetails.orderonlywhenopen.CurrentValue, Null, BusinessDetails.orderonlywhenopen.ReadOnly Or BusinessDetails.orderonlywhenopen.MultiUpdate&"" <> "1")

			' Field disablelaterdelivery
			Call BusinessDetails.disablelaterdelivery.SetDbValue(Rs, BusinessDetails.disablelaterdelivery.CurrentValue, Null, BusinessDetails.disablelaterdelivery.ReadOnly Or BusinessDetails.disablelaterdelivery.MultiUpdate&"" <> "1")

			' Field menupagetext
			Call BusinessDetails.menupagetext.SetDbValue(Rs, BusinessDetails.menupagetext.CurrentValue, Null, BusinessDetails.menupagetext.ReadOnly Or BusinessDetails.menupagetext.MultiUpdate&"" <> "1")

			' Field ordertodayonly
			Call BusinessDetails.ordertodayonly.SetDbValue(Rs, BusinessDetails.ordertodayonly.CurrentValue, Null, BusinessDetails.ordertodayonly.ReadOnly Or BusinessDetails.ordertodayonly.MultiUpdate&"" <> "1")

			' Field mileskm
			Call BusinessDetails.mileskm.SetDbValue(Rs, BusinessDetails.mileskm.CurrentValue, Null, BusinessDetails.mileskm.ReadOnly Or BusinessDetails.mileskm.MultiUpdate&"" <> "1")

			' Field worldpaylive
			Call BusinessDetails.worldpaylive.SetDbValue(Rs, BusinessDetails.worldpaylive.CurrentValue, Null, BusinessDetails.worldpaylive.ReadOnly Or BusinessDetails.worldpaylive.MultiUpdate&"" <> "1")

			' Field worldpayinstallationid
			Call BusinessDetails.worldpayinstallationid.SetDbValue(Rs, BusinessDetails.worldpayinstallationid.CurrentValue, Null, BusinessDetails.worldpayinstallationid.ReadOnly Or BusinessDetails.worldpayinstallationid.MultiUpdate&"" <> "1")

			' Field DistanceCalMethod
			Call BusinessDetails.DistanceCalMethod.SetDbValue(Rs, BusinessDetails.DistanceCalMethod.CurrentValue, Null, BusinessDetails.DistanceCalMethod.ReadOnly Or BusinessDetails.DistanceCalMethod.MultiUpdate&"" <> "1")

			' Field PrinterIDList
			Call BusinessDetails.PrinterIDList.SetDbValue(Rs, BusinessDetails.PrinterIDList.CurrentValue, Null, BusinessDetails.PrinterIDList.ReadOnly Or BusinessDetails.PrinterIDList.MultiUpdate&"" <> "1")

			' Field EpsonJSPrinterURL
			Call BusinessDetails.EpsonJSPrinterURL.SetDbValue(Rs, BusinessDetails.EpsonJSPrinterURL.CurrentValue, Null, BusinessDetails.EpsonJSPrinterURL.ReadOnly Or BusinessDetails.EpsonJSPrinterURL.MultiUpdate&"" <> "1")

			' Field SMSEnable
			Call BusinessDetails.SMSEnable.SetDbValue(Rs, BusinessDetails.SMSEnable.CurrentValue, Null, BusinessDetails.SMSEnable.ReadOnly Or BusinessDetails.SMSEnable.MultiUpdate&"" <> "1")

			' Field SMSOnDelivery
			Call BusinessDetails.SMSOnDelivery.SetDbValue(Rs, BusinessDetails.SMSOnDelivery.CurrentValue, Null, BusinessDetails.SMSOnDelivery.ReadOnly Or BusinessDetails.SMSOnDelivery.MultiUpdate&"" <> "1")

			' Field SMSSupplierDomain
			Call BusinessDetails.SMSSupplierDomain.SetDbValue(Rs, BusinessDetails.SMSSupplierDomain.CurrentValue, Null, BusinessDetails.SMSSupplierDomain.ReadOnly Or BusinessDetails.SMSSupplierDomain.MultiUpdate&"" <> "1")

			' Field SMSOnOrder
			Call BusinessDetails.SMSOnOrder.SetDbValue(Rs, BusinessDetails.SMSOnOrder.CurrentValue, Null, BusinessDetails.SMSOnOrder.ReadOnly Or BusinessDetails.SMSOnOrder.MultiUpdate&"" <> "1")

			' Field SMSOnOrderAfterMin
			Call BusinessDetails.SMSOnOrderAfterMin.SetDbValue(Rs, BusinessDetails.SMSOnOrderAfterMin.CurrentValue, Null, BusinessDetails.SMSOnOrderAfterMin.ReadOnly Or BusinessDetails.SMSOnOrderAfterMin.MultiUpdate&"" <> "1")

			' Field SMSOnOrderContent
			Call BusinessDetails.SMSOnOrderContent.SetDbValue(Rs, BusinessDetails.SMSOnOrderContent.CurrentValue, Null, BusinessDetails.SMSOnOrderContent.ReadOnly Or BusinessDetails.SMSOnOrderContent.MultiUpdate&"" <> "1")

			' Field DefaultSMSCountryCode
			Call BusinessDetails.DefaultSMSCountryCode.SetDbValue(Rs, BusinessDetails.DefaultSMSCountryCode.CurrentValue, Null, BusinessDetails.DefaultSMSCountryCode.ReadOnly Or BusinessDetails.DefaultSMSCountryCode.MultiUpdate&"" <> "1")

			' Field MinimumAmountForCardPayment
			Call BusinessDetails.MinimumAmountForCardPayment.SetDbValue(Rs, BusinessDetails.MinimumAmountForCardPayment.CurrentValue, Null, BusinessDetails.MinimumAmountForCardPayment.ReadOnly Or BusinessDetails.MinimumAmountForCardPayment.MultiUpdate&"" <> "1")

			' Field FavIconUrl
			Call BusinessDetails.FavIconUrl.SetDbValue(Rs, BusinessDetails.FavIconUrl.CurrentValue, Null, BusinessDetails.FavIconUrl.ReadOnly Or BusinessDetails.FavIconUrl.MultiUpdate&"" <> "1")

			' Field AddToHomeScreenURL
			Call BusinessDetails.AddToHomeScreenURL.SetDbValue(Rs, BusinessDetails.AddToHomeScreenURL.CurrentValue, Null, BusinessDetails.AddToHomeScreenURL.ReadOnly Or BusinessDetails.AddToHomeScreenURL.MultiUpdate&"" <> "1")

			' Field SMSOnAcknowledgement
			Call BusinessDetails.SMSOnAcknowledgement.SetDbValue(Rs, BusinessDetails.SMSOnAcknowledgement.CurrentValue, Null, BusinessDetails.SMSOnAcknowledgement.ReadOnly Or BusinessDetails.SMSOnAcknowledgement.MultiUpdate&"" <> "1")

			' Field LocalPrinterURL
			Call BusinessDetails.LocalPrinterURL.SetDbValue(Rs, BusinessDetails.LocalPrinterURL.CurrentValue, Null, BusinessDetails.LocalPrinterURL.ReadOnly Or BusinessDetails.LocalPrinterURL.MultiUpdate&"" <> "1")

			' Field ShowRestaurantDetailOnReceipt
			Call BusinessDetails.ShowRestaurantDetailOnReceipt.SetDbValue(Rs, BusinessDetails.ShowRestaurantDetailOnReceipt.CurrentValue, Null, BusinessDetails.ShowRestaurantDetailOnReceipt.ReadOnly Or BusinessDetails.ShowRestaurantDetailOnReceipt.MultiUpdate&"" <> "1")

			' Field PrinterFontSizeRatio
			Call BusinessDetails.PrinterFontSizeRatio.SetDbValue(Rs, BusinessDetails.PrinterFontSizeRatio.CurrentValue, Null, BusinessDetails.PrinterFontSizeRatio.ReadOnly Or BusinessDetails.PrinterFontSizeRatio.MultiUpdate&"" <> "1")

			' Field ServiceChargePercentage
			Call BusinessDetails.ServiceChargePercentage.SetDbValue(Rs, BusinessDetails.ServiceChargePercentage.CurrentValue, Null, BusinessDetails.ServiceChargePercentage.ReadOnly Or BusinessDetails.ServiceChargePercentage.MultiUpdate&"" <> "1")

			' Field InRestaurantServiceChargeOnly
			Call BusinessDetails.InRestaurantServiceChargeOnly.SetDbValue(Rs, BusinessDetails.InRestaurantServiceChargeOnly.CurrentValue, Null, BusinessDetails.InRestaurantServiceChargeOnly.ReadOnly Or BusinessDetails.InRestaurantServiceChargeOnly.MultiUpdate&"" <> "1")

			' Field IsDualReceiptPrinting
			Call BusinessDetails.IsDualReceiptPrinting.SetDbValue(Rs, BusinessDetails.IsDualReceiptPrinting.CurrentValue, Null, BusinessDetails.IsDualReceiptPrinting.ReadOnly Or BusinessDetails.IsDualReceiptPrinting.MultiUpdate&"" <> "1")

			' Field PrintingFontSize
			Call BusinessDetails.PrintingFontSize.SetDbValue(Rs, BusinessDetails.PrintingFontSize.CurrentValue, Null, BusinessDetails.PrintingFontSize.ReadOnly Or BusinessDetails.PrintingFontSize.MultiUpdate&"" <> "1")

			' Field InRestaurantEpsonPrinterIDList
			Call BusinessDetails.InRestaurantEpsonPrinterIDList.SetDbValue(Rs, BusinessDetails.InRestaurantEpsonPrinterIDList.CurrentValue, Null, BusinessDetails.InRestaurantEpsonPrinterIDList.ReadOnly Or BusinessDetails.InRestaurantEpsonPrinterIDList.MultiUpdate&"" <> "1")

			' Field BlockIPEmailList
			Call BusinessDetails.BlockIPEmailList.SetDbValue(Rs, BusinessDetails.BlockIPEmailList.CurrentValue, Null, BusinessDetails.BlockIPEmailList.ReadOnly Or BusinessDetails.BlockIPEmailList.MultiUpdate&"" <> "1")

			' Field inmenuannouncement
			Call BusinessDetails.inmenuannouncement.SetDbValue(Rs, BusinessDetails.inmenuannouncement.CurrentValue, Null, BusinessDetails.inmenuannouncement.ReadOnly Or BusinessDetails.inmenuannouncement.MultiUpdate&"" <> "1")

			' Field RePrintReceiptWays
			Call BusinessDetails.RePrintReceiptWays.SetDbValue(Rs, BusinessDetails.RePrintReceiptWays.CurrentValue, Null, BusinessDetails.RePrintReceiptWays.ReadOnly Or BusinessDetails.RePrintReceiptWays.MultiUpdate&"" <> "1")

			' Field printingtype
			Call BusinessDetails.printingtype.SetDbValue(Rs, BusinessDetails.printingtype.CurrentValue, Null, BusinessDetails.printingtype.ReadOnly Or BusinessDetails.printingtype.MultiUpdate&"" <> "1")

			' Field Stripe_Key_Secret
			Call BusinessDetails.Stripe_Key_Secret.SetDbValue(Rs, BusinessDetails.Stripe_Key_Secret.CurrentValue, Null, BusinessDetails.Stripe_Key_Secret.ReadOnly Or BusinessDetails.Stripe_Key_Secret.MultiUpdate&"" <> "1")

			' Field Stripe
			Call BusinessDetails.Stripe.SetDbValue(Rs, BusinessDetails.Stripe.CurrentValue, Null, BusinessDetails.Stripe.ReadOnly Or BusinessDetails.Stripe.MultiUpdate&"" <> "1")

			' Field Stripe_Api_Key
			Call BusinessDetails.Stripe_Api_Key.SetDbValue(Rs, BusinessDetails.Stripe_Api_Key.CurrentValue, Null, BusinessDetails.Stripe_Api_Key.ReadOnly Or BusinessDetails.Stripe_Api_Key.MultiUpdate&"" <> "1")

			' Field EnableBooking
			Call BusinessDetails.EnableBooking.SetDbValue(Rs, BusinessDetails.EnableBooking.CurrentValue, Null, BusinessDetails.EnableBooking.ReadOnly Or BusinessDetails.EnableBooking.MultiUpdate&"" <> "1")

			' Field URL_Facebook
			Call BusinessDetails.URL_Facebook.SetDbValue(Rs, BusinessDetails.URL_Facebook.CurrentValue, Null, BusinessDetails.URL_Facebook.ReadOnly Or BusinessDetails.URL_Facebook.MultiUpdate&"" <> "1")

			' Field URL_Twitter
			Call BusinessDetails.URL_Twitter.SetDbValue(Rs, BusinessDetails.URL_Twitter.CurrentValue, Null, BusinessDetails.URL_Twitter.ReadOnly Or BusinessDetails.URL_Twitter.MultiUpdate&"" <> "1")

			' Field URL_Google
			Call BusinessDetails.URL_Google.SetDbValue(Rs, BusinessDetails.URL_Google.CurrentValue, Null, BusinessDetails.URL_Google.ReadOnly Or BusinessDetails.URL_Google.MultiUpdate&"" <> "1")

			' Field URL_Intagram
			Call BusinessDetails.URL_Intagram.SetDbValue(Rs, BusinessDetails.URL_Intagram.CurrentValue, Null, BusinessDetails.URL_Intagram.ReadOnly Or BusinessDetails.URL_Intagram.MultiUpdate&"" <> "1")

			' Field URL_YouTube
			Call BusinessDetails.URL_YouTube.SetDbValue(Rs, BusinessDetails.URL_YouTube.CurrentValue, Null, BusinessDetails.URL_YouTube.ReadOnly Or BusinessDetails.URL_YouTube.MultiUpdate&"" <> "1")

			' Field URL_Tripadvisor
			Call BusinessDetails.URL_Tripadvisor.SetDbValue(Rs, BusinessDetails.URL_Tripadvisor.CurrentValue, Null, BusinessDetails.URL_Tripadvisor.ReadOnly Or BusinessDetails.URL_Tripadvisor.MultiUpdate&"" <> "1")

			' Field URL_Special_Offer
			Call BusinessDetails.URL_Special_Offer.SetDbValue(Rs, BusinessDetails.URL_Special_Offer.CurrentValue, Null, BusinessDetails.URL_Special_Offer.ReadOnly Or BusinessDetails.URL_Special_Offer.MultiUpdate&"" <> "1")

			' Field URL_Linkin
			Call BusinessDetails.URL_Linkin.SetDbValue(Rs, BusinessDetails.URL_Linkin.CurrentValue, Null, BusinessDetails.URL_Linkin.ReadOnly Or BusinessDetails.URL_Linkin.MultiUpdate&"" <> "1")

			' Field Currency_PAYPAL
			Call BusinessDetails.Currency_PAYPAL.SetDbValue(Rs, BusinessDetails.Currency_PAYPAL.CurrentValue, Null, BusinessDetails.Currency_PAYPAL.ReadOnly Or BusinessDetails.Currency_PAYPAL.MultiUpdate&"" <> "1")

			' Field Currency_STRIPE
			Call BusinessDetails.Currency_STRIPE.SetDbValue(Rs, BusinessDetails.Currency_STRIPE.CurrentValue, Null, BusinessDetails.Currency_STRIPE.ReadOnly Or BusinessDetails.Currency_STRIPE.MultiUpdate&"" <> "1")

			' Field Currency_WOLRDPAY
			Call BusinessDetails.Currency_WOLRDPAY.SetDbValue(Rs, BusinessDetails.Currency_WOLRDPAY.CurrentValue, Null, BusinessDetails.Currency_WOLRDPAY.ReadOnly Or BusinessDetails.Currency_WOLRDPAY.MultiUpdate&"" <> "1")

			' Field Tip_percent
			Call BusinessDetails.Tip_percent.SetDbValue(Rs, BusinessDetails.Tip_percent.CurrentValue, Null, BusinessDetails.Tip_percent.ReadOnly Or BusinessDetails.Tip_percent.MultiUpdate&"" <> "1")

			' Field Tax_Percent
			Call BusinessDetails.Tax_Percent.SetDbValue(Rs, BusinessDetails.Tax_Percent.CurrentValue, Null, BusinessDetails.Tax_Percent.ReadOnly Or BusinessDetails.Tax_Percent.MultiUpdate&"" <> "1")

			' Field InRestaurantTaxChargeOnly
			Call BusinessDetails.InRestaurantTaxChargeOnly.SetDbValue(Rs, BusinessDetails.InRestaurantTaxChargeOnly.CurrentValue, Null, BusinessDetails.InRestaurantTaxChargeOnly.ReadOnly Or BusinessDetails.InRestaurantTaxChargeOnly.MultiUpdate&"" <> "1")

			' Field InRestaurantTipChargeOnly
			Call BusinessDetails.InRestaurantTipChargeOnly.SetDbValue(Rs, BusinessDetails.InRestaurantTipChargeOnly.CurrentValue, Null, BusinessDetails.InRestaurantTipChargeOnly.ReadOnly Or BusinessDetails.InRestaurantTipChargeOnly.MultiUpdate&"" <> "1")

			' Field isCheckCapcha
			Call BusinessDetails.isCheckCapcha.SetDbValue(Rs, BusinessDetails.isCheckCapcha.CurrentValue, Null, BusinessDetails.isCheckCapcha.ReadOnly Or BusinessDetails.isCheckCapcha.MultiUpdate&"" <> "1")

			' Field Close_StartDate
			Call BusinessDetails.Close_StartDate.SetDbValue(Rs, BusinessDetails.Close_StartDate.CurrentValue, Null, BusinessDetails.Close_StartDate.ReadOnly Or BusinessDetails.Close_StartDate.MultiUpdate&"" <> "1")

			' Field Close_EndDate
			Call BusinessDetails.Close_EndDate.SetDbValue(Rs, BusinessDetails.Close_EndDate.CurrentValue, Null, BusinessDetails.Close_EndDate.ReadOnly Or BusinessDetails.Close_EndDate.MultiUpdate&"" <> "1")

			' Field Stripe_Country
			Call BusinessDetails.Stripe_Country.SetDbValue(Rs, BusinessDetails.Stripe_Country.CurrentValue, Null, BusinessDetails.Stripe_Country.ReadOnly Or BusinessDetails.Stripe_Country.MultiUpdate&"" <> "1")

			' Field enable_StripePaymentButton
			Call BusinessDetails.enable_StripePaymentButton.SetDbValue(Rs, BusinessDetails.enable_StripePaymentButton.CurrentValue, Null, BusinessDetails.enable_StripePaymentButton.ReadOnly Or BusinessDetails.enable_StripePaymentButton.MultiUpdate&"" <> "1")

			' Field enable_CashPayment
			Call BusinessDetails.enable_CashPayment.SetDbValue(Rs, BusinessDetails.enable_CashPayment.CurrentValue, Null, BusinessDetails.enable_CashPayment.ReadOnly Or BusinessDetails.enable_CashPayment.MultiUpdate&"" <> "1")

			' Field DeliveryMile
			Call BusinessDetails.DeliveryMile.SetDbValue(Rs, BusinessDetails.DeliveryMile.CurrentValue, Null, BusinessDetails.DeliveryMile.ReadOnly Or BusinessDetails.DeliveryMile.MultiUpdate&"" <> "1")

			' Field Mon_Delivery
			Call BusinessDetails.Mon_Delivery.SetDbValue(Rs, BusinessDetails.Mon_Delivery.CurrentValue, Null, BusinessDetails.Mon_Delivery.ReadOnly Or BusinessDetails.Mon_Delivery.MultiUpdate&"" <> "1")

			' Field Mon_Collection
			Call BusinessDetails.Mon_Collection.SetDbValue(Rs, BusinessDetails.Mon_Collection.CurrentValue, Null, BusinessDetails.Mon_Collection.ReadOnly Or BusinessDetails.Mon_Collection.MultiUpdate&"" <> "1")

			' Field Tue_Delivery
			Call BusinessDetails.Tue_Delivery.SetDbValue(Rs, BusinessDetails.Tue_Delivery.CurrentValue, Null, BusinessDetails.Tue_Delivery.ReadOnly Or BusinessDetails.Tue_Delivery.MultiUpdate&"" <> "1")

			' Field Tue_Collection
			Call BusinessDetails.Tue_Collection.SetDbValue(Rs, BusinessDetails.Tue_Collection.CurrentValue, Null, BusinessDetails.Tue_Collection.ReadOnly Or BusinessDetails.Tue_Collection.MultiUpdate&"" <> "1")

			' Field Wed_Delivery
			Call BusinessDetails.Wed_Delivery.SetDbValue(Rs, BusinessDetails.Wed_Delivery.CurrentValue, Null, BusinessDetails.Wed_Delivery.ReadOnly Or BusinessDetails.Wed_Delivery.MultiUpdate&"" <> "1")

			' Field Wed_Collection
			Call BusinessDetails.Wed_Collection.SetDbValue(Rs, BusinessDetails.Wed_Collection.CurrentValue, Null, BusinessDetails.Wed_Collection.ReadOnly Or BusinessDetails.Wed_Collection.MultiUpdate&"" <> "1")

			' Field Thu_Delivery
			Call BusinessDetails.Thu_Delivery.SetDbValue(Rs, BusinessDetails.Thu_Delivery.CurrentValue, Null, BusinessDetails.Thu_Delivery.ReadOnly Or BusinessDetails.Thu_Delivery.MultiUpdate&"" <> "1")

			' Field Thu_Collection
			Call BusinessDetails.Thu_Collection.SetDbValue(Rs, BusinessDetails.Thu_Collection.CurrentValue, Null, BusinessDetails.Thu_Collection.ReadOnly Or BusinessDetails.Thu_Collection.MultiUpdate&"" <> "1")

			' Field Fri_Delivery
			Call BusinessDetails.Fri_Delivery.SetDbValue(Rs, BusinessDetails.Fri_Delivery.CurrentValue, Null, BusinessDetails.Fri_Delivery.ReadOnly Or BusinessDetails.Fri_Delivery.MultiUpdate&"" <> "1")

			' Field Fri_Collection
			Call BusinessDetails.Fri_Collection.SetDbValue(Rs, BusinessDetails.Fri_Collection.CurrentValue, Null, BusinessDetails.Fri_Collection.ReadOnly Or BusinessDetails.Fri_Collection.MultiUpdate&"" <> "1")

			' Field Sat_Delivery
			Call BusinessDetails.Sat_Delivery.SetDbValue(Rs, BusinessDetails.Sat_Delivery.CurrentValue, Null, BusinessDetails.Sat_Delivery.ReadOnly Or BusinessDetails.Sat_Delivery.MultiUpdate&"" <> "1")

			' Field Sat_Collection
			Call BusinessDetails.Sat_Collection.SetDbValue(Rs, BusinessDetails.Sat_Collection.CurrentValue, Null, BusinessDetails.Sat_Collection.ReadOnly Or BusinessDetails.Sat_Collection.MultiUpdate&"" <> "1")

			' Field Sun_Delivery
			Call BusinessDetails.Sun_Delivery.SetDbValue(Rs, BusinessDetails.Sun_Delivery.CurrentValue, Null, BusinessDetails.Sun_Delivery.ReadOnly Or BusinessDetails.Sun_Delivery.MultiUpdate&"" <> "1")

			' Field Sun_Collection
			Call BusinessDetails.Sun_Collection.SetDbValue(Rs, BusinessDetails.Sun_Collection.CurrentValue, Null, BusinessDetails.Sun_Collection.ReadOnly Or BusinessDetails.Sun_Collection.MultiUpdate&"" <> "1")

			' Field EnableUrlRewrite
			Call BusinessDetails.EnableUrlRewrite.SetDbValue(Rs, BusinessDetails.EnableUrlRewrite.CurrentValue, Null, BusinessDetails.EnableUrlRewrite.ReadOnly Or BusinessDetails.EnableUrlRewrite.MultiUpdate&"" <> "1")

			' Field DeliveryCostUpTo
			Call BusinessDetails.DeliveryCostUpTo.SetDbValue(Rs, BusinessDetails.DeliveryCostUpTo.CurrentValue, Null, BusinessDetails.DeliveryCostUpTo.ReadOnly Or BusinessDetails.DeliveryCostUpTo.MultiUpdate&"" <> "1")

			' Field DeliveryUptoMile
			Call BusinessDetails.DeliveryUptoMile.SetDbValue(Rs, BusinessDetails.DeliveryUptoMile.CurrentValue, Null, BusinessDetails.DeliveryUptoMile.ReadOnly Or BusinessDetails.DeliveryUptoMile.MultiUpdate&"" <> "1")

			' Field Show_Ordernumner_printer
			Call BusinessDetails.Show_Ordernumner_printer.SetDbValue(Rs, BusinessDetails.Show_Ordernumner_printer.CurrentValue, Null, BusinessDetails.Show_Ordernumner_printer.ReadOnly Or BusinessDetails.Show_Ordernumner_printer.MultiUpdate&"" <> "1")

			' Field Show_Ordernumner_Receipt
			Call BusinessDetails.Show_Ordernumner_Receipt.SetDbValue(Rs, BusinessDetails.Show_Ordernumner_Receipt.CurrentValue, Null, BusinessDetails.Show_Ordernumner_Receipt.ReadOnly Or BusinessDetails.Show_Ordernumner_Receipt.MultiUpdate&"" <> "1")

			' Field Show_Ordernumner_Dashboard
			Call BusinessDetails.Show_Ordernumner_Dashboard.SetDbValue(Rs, BusinessDetails.Show_Ordernumner_Dashboard.CurrentValue, Null, BusinessDetails.Show_Ordernumner_Dashboard.ReadOnly Or BusinessDetails.Show_Ordernumner_Dashboard.MultiUpdate&"" <> "1")

			' Check recordset update error
			If Err.Number <> 0 Then
				FailureMessage = Err.Description
				Rs.Close
				Set Rs = Nothing
				EditRow = False
				Exit Function
			End If

			' Call Row Updating event
			bUpdateRow = BusinessDetails.Row_Updating(RsOld, Rs)
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
				ElseIf BusinessDetails.CancelMessage <> "" Then
					FailureMessage = BusinessDetails.CancelMessage
					BusinessDetails.CancelMessage = ""
				Else
					FailureMessage = Language.Phrase("UpdateCancelled")
				End If
				EditRow = False
			End If
		End If

		' Call Row Updated event
		If EditRow Then
			Call BusinessDetails.Row_Updated(RsOld, RsNew)
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
		Call Breadcrumb.Add("list", BusinessDetails.TableVar, "BusinessDetailslist.asp", "", BusinessDetails.TableVar, True)
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
