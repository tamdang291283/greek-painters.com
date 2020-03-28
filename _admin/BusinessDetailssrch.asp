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
Dim BusinessDetails_search
Set BusinessDetails_search = New cBusinessDetails_search
Set Page = BusinessDetails_search

' Page init processing
BusinessDetails_search.Page_Init()

' Page main processing
BusinessDetails_search.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
BusinessDetails_search.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var BusinessDetails_search = new ew_Page("BusinessDetails_search");
BusinessDetails_search.PageID = "search"; // Page ID
var EW_PAGE_ID = BusinessDetails_search.PageID; // For backward compatibility
// Form object
var fBusinessDetailssearch = new ew_Form("fBusinessDetailssearch");
// Form_CustomValidate event
fBusinessDetailssearch.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fBusinessDetailssearch.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fBusinessDetailssearch.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
// Validate function for search
fBusinessDetailssearch.Validate = function(fobj) {
	if (!this.ValidateRequired)
		return true; // Ignore validation
	fobj = fobj || this.Form;
	this.PostAutoSuggest();
	var infix = "";
	elm = this.GetElements("x" + infix + "_ID");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.ID.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_DeliveryMinAmount");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.DeliveryMinAmount.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_DeliveryMaxDistance");
	if (elm && !ew_CheckNumber(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.DeliveryMaxDistance.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_DeliveryFreeDistance");
	if (elm && !ew_CheckNumber(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.DeliveryFreeDistance.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_AverageDeliveryTime");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.AverageDeliveryTime.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_AverageCollectionTime");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.AverageCollectionTime.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_DeliveryFee");
	if (elm && !ew_CheckNumber(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.DeliveryFee.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_businessclosed");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.businessclosed.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_timezone");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.timezone.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_individualpostcodeschecking");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.individualpostcodeschecking.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_orderonlywhenopen");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.orderonlywhenopen.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_disablelaterdelivery");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.disablelaterdelivery.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_ordertodayonly");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.ordertodayonly.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_worldpaylive");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.worldpaylive.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_SMSEnable");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.SMSEnable.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_SMSOnDelivery");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.SMSOnDelivery.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_SMSOnOrder");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.SMSOnOrder.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_SMSOnOrderAfterMin");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.SMSOnOrderAfterMin.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_MinimumAmountForCardPayment");
	if (elm && !ew_CheckNumber(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.MinimumAmountForCardPayment.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_SMSOnAcknowledgement");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.SMSOnAcknowledgement.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_ShowRestaurantDetailOnReceipt");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.ShowRestaurantDetailOnReceipt.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_PrinterFontSizeRatio");
	if (elm && !ew_CheckNumber(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.PrinterFontSizeRatio.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_ServiceChargePercentage");
	if (elm && !ew_CheckNumber(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.ServiceChargePercentage.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_InRestaurantServiceChargeOnly");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.InRestaurantServiceChargeOnly.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_IsDualReceiptPrinting");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.IsDualReceiptPrinting.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_PrintingFontSize");
	if (elm && !ew_CheckNumber(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.PrintingFontSize.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_Tip_percent");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.Tip_percent.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_Tax_Percent");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.Tax_Percent.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_InRestaurantTaxChargeOnly");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.InRestaurantTaxChargeOnly.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_InRestaurantTipChargeOnly");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.InRestaurantTipChargeOnly.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_DeliveryMile");
	if (elm && !ew_CheckNumber(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.DeliveryMile.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_Mon_Delivery");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.Mon_Delivery.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_Mon_Collection");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.Mon_Collection.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_Tue_Delivery");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.Tue_Delivery.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_Tue_Collection");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.Tue_Collection.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_Wed_Delivery");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.Wed_Delivery.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_Wed_Collection");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.Wed_Collection.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_Thu_Delivery");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.Thu_Delivery.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_Thu_Collection");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.Thu_Collection.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_Fri_Delivery");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.Fri_Delivery.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_Fri_Collection");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.Fri_Collection.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_Sat_Delivery");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.Sat_Delivery.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_Sat_Collection");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.Sat_Collection.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_Sun_Delivery");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.Sun_Delivery.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_Sun_Collection");
	if (elm && !ew_CheckInteger(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.Sun_Collection.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_DeliveryCostUpTo");
	if (elm && !ew_CheckNumber(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.DeliveryCostUpTo.FldErrMsg) %>");
	elm = this.GetElements("x" + infix + "_DeliveryUptoMile");
	if (elm && !ew_CheckNumber(elm.value))
		return this.OnError(elm, "<%= ew_JsEncode2(BusinessDetails.DeliveryUptoMile.FldErrMsg) %>");
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
<% If Not BusinessDetails_search.IsModal Then %>
<div class="ewToolbar">
<% If BusinessDetails.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If BusinessDetails.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% End If %>
<% BusinessDetails_search.ShowPageHeader() %>
<% BusinessDetails_search.ShowMessage %>
<form name="fBusinessDetailssearch" id="fBusinessDetailssearch" class="form-horizontal ewForm ewSearchForm" action="<%= ew_CurrentPage %>" method="post">
<% If BusinessDetails_search.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= BusinessDetails_search.Token %>">
<% End If %>
<input type="hidden" name="t" value="BusinessDetails">
<input type="hidden" name="a_search" id="a_search" value="S">
<% If BusinessDetails_search.IsModal Then %>
<input type="hidden" name="modal" value="1">
<% End If %>
<div>
<% If BusinessDetails.ID.Visible Then ' ID %>
	<div id="r_ID" class="form-group">
		<label for="x_ID" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_ID"><%= BusinessDetails.ID.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_ID" id="z_ID" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.ID.CellAttributes %>>
			<span id="el_BusinessDetails_ID">
<input type="text" data-field="x_ID" name="x_ID" id="x_ID" placeholder="<%= BusinessDetails.ID.PlaceHolder %>" value="<%= BusinessDetails.ID.EditValue %>"<%= BusinessDetails.ID.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.Name.Visible Then ' Name %>
	<div id="r_Name" class="form-group">
		<label for="x_Name" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_Name"><%= BusinessDetails.Name.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_Name" id="z_Name" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.Name.CellAttributes %>>
			<span id="el_BusinessDetails_Name">
<input type="text" data-field="x_Name" name="x_Name" id="x_Name" size="30" maxlength="255" placeholder="<%= BusinessDetails.Name.PlaceHolder %>" value="<%= BusinessDetails.Name.EditValue %>"<%= BusinessDetails.Name.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.Address.Visible Then ' Address %>
	<div id="r_Address" class="form-group">
		<label for="x_Address" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_Address"><%= BusinessDetails.Address.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_Address" id="z_Address" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.Address.CellAttributes %>>
			<span id="el_BusinessDetails_Address">
<input type="text" data-field="x_Address" name="x_Address" id="x_Address" size="30" maxlength="255" placeholder="<%= BusinessDetails.Address.PlaceHolder %>" value="<%= BusinessDetails.Address.EditValue %>"<%= BusinessDetails.Address.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.PostalCode.Visible Then ' PostalCode %>
	<div id="r_PostalCode" class="form-group">
		<label for="x_PostalCode" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_PostalCode"><%= BusinessDetails.PostalCode.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_PostalCode" id="z_PostalCode" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.PostalCode.CellAttributes %>>
			<span id="el_BusinessDetails_PostalCode">
<input type="text" data-field="x_PostalCode" name="x_PostalCode" id="x_PostalCode" size="30" maxlength="255" placeholder="<%= BusinessDetails.PostalCode.PlaceHolder %>" value="<%= BusinessDetails.PostalCode.EditValue %>"<%= BusinessDetails.PostalCode.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.FoodType.Visible Then ' FoodType %>
	<div id="r_FoodType" class="form-group">
		<label for="x_FoodType" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_FoodType"><%= BusinessDetails.FoodType.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_FoodType" id="z_FoodType" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.FoodType.CellAttributes %>>
			<span id="el_BusinessDetails_FoodType">
<input type="text" data-field="x_FoodType" name="x_FoodType" id="x_FoodType" size="30" maxlength="255" placeholder="<%= BusinessDetails.FoodType.PlaceHolder %>" value="<%= BusinessDetails.FoodType.EditValue %>"<%= BusinessDetails.FoodType.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.DeliveryMinAmount.Visible Then ' DeliveryMinAmount %>
	<div id="r_DeliveryMinAmount" class="form-group">
		<label for="x_DeliveryMinAmount" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_DeliveryMinAmount"><%= BusinessDetails.DeliveryMinAmount.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_DeliveryMinAmount" id="z_DeliveryMinAmount" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.DeliveryMinAmount.CellAttributes %>>
			<span id="el_BusinessDetails_DeliveryMinAmount">
<input type="text" data-field="x_DeliveryMinAmount" name="x_DeliveryMinAmount" id="x_DeliveryMinAmount" size="30" placeholder="<%= BusinessDetails.DeliveryMinAmount.PlaceHolder %>" value="<%= BusinessDetails.DeliveryMinAmount.EditValue %>"<%= BusinessDetails.DeliveryMinAmount.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.DeliveryMaxDistance.Visible Then ' DeliveryMaxDistance %>
	<div id="r_DeliveryMaxDistance" class="form-group">
		<label for="x_DeliveryMaxDistance" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_DeliveryMaxDistance"><%= BusinessDetails.DeliveryMaxDistance.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_DeliveryMaxDistance" id="z_DeliveryMaxDistance" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.DeliveryMaxDistance.CellAttributes %>>
			<span id="el_BusinessDetails_DeliveryMaxDistance">
<input type="text" data-field="x_DeliveryMaxDistance" name="x_DeliveryMaxDistance" id="x_DeliveryMaxDistance" size="30" placeholder="<%= BusinessDetails.DeliveryMaxDistance.PlaceHolder %>" value="<%= BusinessDetails.DeliveryMaxDistance.EditValue %>"<%= BusinessDetails.DeliveryMaxDistance.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.DeliveryFreeDistance.Visible Then ' DeliveryFreeDistance %>
	<div id="r_DeliveryFreeDistance" class="form-group">
		<label for="x_DeliveryFreeDistance" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_DeliveryFreeDistance"><%= BusinessDetails.DeliveryFreeDistance.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_DeliveryFreeDistance" id="z_DeliveryFreeDistance" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.DeliveryFreeDistance.CellAttributes %>>
			<span id="el_BusinessDetails_DeliveryFreeDistance">
<input type="text" data-field="x_DeliveryFreeDistance" name="x_DeliveryFreeDistance" id="x_DeliveryFreeDistance" size="30" placeholder="<%= BusinessDetails.DeliveryFreeDistance.PlaceHolder %>" value="<%= BusinessDetails.DeliveryFreeDistance.EditValue %>"<%= BusinessDetails.DeliveryFreeDistance.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.AverageDeliveryTime.Visible Then ' AverageDeliveryTime %>
	<div id="r_AverageDeliveryTime" class="form-group">
		<label for="x_AverageDeliveryTime" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_AverageDeliveryTime"><%= BusinessDetails.AverageDeliveryTime.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_AverageDeliveryTime" id="z_AverageDeliveryTime" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.AverageDeliveryTime.CellAttributes %>>
			<span id="el_BusinessDetails_AverageDeliveryTime">
<input type="text" data-field="x_AverageDeliveryTime" name="x_AverageDeliveryTime" id="x_AverageDeliveryTime" size="30" placeholder="<%= BusinessDetails.AverageDeliveryTime.PlaceHolder %>" value="<%= BusinessDetails.AverageDeliveryTime.EditValue %>"<%= BusinessDetails.AverageDeliveryTime.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.AverageCollectionTime.Visible Then ' AverageCollectionTime %>
	<div id="r_AverageCollectionTime" class="form-group">
		<label for="x_AverageCollectionTime" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_AverageCollectionTime"><%= BusinessDetails.AverageCollectionTime.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_AverageCollectionTime" id="z_AverageCollectionTime" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.AverageCollectionTime.CellAttributes %>>
			<span id="el_BusinessDetails_AverageCollectionTime">
<input type="text" data-field="x_AverageCollectionTime" name="x_AverageCollectionTime" id="x_AverageCollectionTime" size="30" placeholder="<%= BusinessDetails.AverageCollectionTime.PlaceHolder %>" value="<%= BusinessDetails.AverageCollectionTime.EditValue %>"<%= BusinessDetails.AverageCollectionTime.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.DeliveryFee.Visible Then ' DeliveryFee %>
	<div id="r_DeliveryFee" class="form-group">
		<label for="x_DeliveryFee" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_DeliveryFee"><%= BusinessDetails.DeliveryFee.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_DeliveryFee" id="z_DeliveryFee" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.DeliveryFee.CellAttributes %>>
			<span id="el_BusinessDetails_DeliveryFee">
<input type="text" data-field="x_DeliveryFee" name="x_DeliveryFee" id="x_DeliveryFee" size="30" placeholder="<%= BusinessDetails.DeliveryFee.PlaceHolder %>" value="<%= BusinessDetails.DeliveryFee.EditValue %>"<%= BusinessDetails.DeliveryFee.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.ImgUrl.Visible Then ' ImgUrl %>
	<div id="r_ImgUrl" class="form-group">
		<label for="x_ImgUrl" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_ImgUrl"><%= BusinessDetails.ImgUrl.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_ImgUrl" id="z_ImgUrl" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.ImgUrl.CellAttributes %>>
			<span id="el_BusinessDetails_ImgUrl">
<input type="text" data-field="x_ImgUrl" name="x_ImgUrl" id="x_ImgUrl" size="30" maxlength="255" placeholder="<%= BusinessDetails.ImgUrl.PlaceHolder %>" value="<%= BusinessDetails.ImgUrl.EditValue %>"<%= BusinessDetails.ImgUrl.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.Telephone.Visible Then ' Telephone %>
	<div id="r_Telephone" class="form-group">
		<label for="x_Telephone" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_Telephone"><%= BusinessDetails.Telephone.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_Telephone" id="z_Telephone" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.Telephone.CellAttributes %>>
			<span id="el_BusinessDetails_Telephone">
<input type="text" data-field="x_Telephone" name="x_Telephone" id="x_Telephone" size="30" maxlength="255" placeholder="<%= BusinessDetails.Telephone.PlaceHolder %>" value="<%= BusinessDetails.Telephone.EditValue %>"<%= BusinessDetails.Telephone.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.zEmail.Visible Then ' Email %>
	<div id="r_zEmail" class="form-group">
		<label for="x_zEmail" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_zEmail"><%= BusinessDetails.zEmail.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_zEmail" id="z_zEmail" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.zEmail.CellAttributes %>>
			<span id="el_BusinessDetails_zEmail">
<input type="text" data-field="x_zEmail" name="x_zEmail" id="x_zEmail" size="30" maxlength="255" placeholder="<%= BusinessDetails.zEmail.PlaceHolder %>" value="<%= BusinessDetails.zEmail.EditValue %>"<%= BusinessDetails.zEmail.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.pswd.Visible Then ' pswd %>
	<div id="r_pswd" class="form-group">
		<label for="x_pswd" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_pswd"><%= BusinessDetails.pswd.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_pswd" id="z_pswd" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.pswd.CellAttributes %>>
			<span id="el_BusinessDetails_pswd">
<input type="text" data-field="x_pswd" name="x_pswd" id="x_pswd" size="30" maxlength="255" placeholder="<%= BusinessDetails.pswd.PlaceHolder %>" value="<%= BusinessDetails.pswd.EditValue %>"<%= BusinessDetails.pswd.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.businessclosed.Visible Then ' businessclosed %>
	<div id="r_businessclosed" class="form-group">
		<label for="x_businessclosed" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_businessclosed"><%= BusinessDetails.businessclosed.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_businessclosed" id="z_businessclosed" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.businessclosed.CellAttributes %>>
			<span id="el_BusinessDetails_businessclosed">
<input type="text" data-field="x_businessclosed" name="x_businessclosed" id="x_businessclosed" size="30" placeholder="<%= BusinessDetails.businessclosed.PlaceHolder %>" value="<%= BusinessDetails.businessclosed.EditValue %>"<%= BusinessDetails.businessclosed.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.announcement.Visible Then ' announcement %>
	<div id="r_announcement" class="form-group">
		<label for="x_announcement" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_announcement"><%= BusinessDetails.announcement.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_announcement" id="z_announcement" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.announcement.CellAttributes %>>
			<span id="el_BusinessDetails_announcement">
<input type="text" data-field="x_announcement" name="x_announcement" id="x_announcement" size="35" placeholder="<%= BusinessDetails.announcement.PlaceHolder %>" value="<%= BusinessDetails.announcement.EditValue %>"<%= BusinessDetails.announcement.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.css.Visible Then ' css %>
	<div id="r_css" class="form-group">
		<label for="x_css" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_css"><%= BusinessDetails.css.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_css" id="z_css" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.css.CellAttributes %>>
			<span id="el_BusinessDetails_css">
<input type="text" data-field="x_css" name="x_css" id="x_css" size="35" placeholder="<%= BusinessDetails.css.PlaceHolder %>" value="<%= BusinessDetails.css.EditValue %>"<%= BusinessDetails.css.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.SMTP_AUTENTICATE.Visible Then ' SMTP_AUTENTICATE %>
	<div id="r_SMTP_AUTENTICATE" class="form-group">
		<label for="x_SMTP_AUTENTICATE" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_SMTP_AUTENTICATE"><%= BusinessDetails.SMTP_AUTENTICATE.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_SMTP_AUTENTICATE" id="z_SMTP_AUTENTICATE" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.SMTP_AUTENTICATE.CellAttributes %>>
			<span id="el_BusinessDetails_SMTP_AUTENTICATE">
<input type="text" data-field="x_SMTP_AUTENTICATE" name="x_SMTP_AUTENTICATE" id="x_SMTP_AUTENTICATE" size="30" maxlength="255" placeholder="<%= BusinessDetails.SMTP_AUTENTICATE.PlaceHolder %>" value="<%= BusinessDetails.SMTP_AUTENTICATE.EditValue %>"<%= BusinessDetails.SMTP_AUTENTICATE.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.MAIL_FROM.Visible Then ' MAIL_FROM %>
	<div id="r_MAIL_FROM" class="form-group">
		<label for="x_MAIL_FROM" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_MAIL_FROM"><%= BusinessDetails.MAIL_FROM.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_MAIL_FROM" id="z_MAIL_FROM" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.MAIL_FROM.CellAttributes %>>
			<span id="el_BusinessDetails_MAIL_FROM">
<input type="text" data-field="x_MAIL_FROM" name="x_MAIL_FROM" id="x_MAIL_FROM" size="30" maxlength="255" placeholder="<%= BusinessDetails.MAIL_FROM.PlaceHolder %>" value="<%= BusinessDetails.MAIL_FROM.EditValue %>"<%= BusinessDetails.MAIL_FROM.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.PAYPAL_URL.Visible Then ' PAYPAL_URL %>
	<div id="r_PAYPAL_URL" class="form-group">
		<label for="x_PAYPAL_URL" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_PAYPAL_URL"><%= BusinessDetails.PAYPAL_URL.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_PAYPAL_URL" id="z_PAYPAL_URL" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.PAYPAL_URL.CellAttributes %>>
			<span id="el_BusinessDetails_PAYPAL_URL">
<input type="text" data-field="x_PAYPAL_URL" name="x_PAYPAL_URL" id="x_PAYPAL_URL" size="30" maxlength="255" placeholder="<%= BusinessDetails.PAYPAL_URL.PlaceHolder %>" value="<%= BusinessDetails.PAYPAL_URL.EditValue %>"<%= BusinessDetails.PAYPAL_URL.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.PAYPAL_PDT.Visible Then ' PAYPAL_PDT %>
	<div id="r_PAYPAL_PDT" class="form-group">
		<label for="x_PAYPAL_PDT" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_PAYPAL_PDT"><%= BusinessDetails.PAYPAL_PDT.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_PAYPAL_PDT" id="z_PAYPAL_PDT" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.PAYPAL_PDT.CellAttributes %>>
			<span id="el_BusinessDetails_PAYPAL_PDT">
<input type="text" data-field="x_PAYPAL_PDT" name="x_PAYPAL_PDT" id="x_PAYPAL_PDT" size="30" maxlength="255" placeholder="<%= BusinessDetails.PAYPAL_PDT.PlaceHolder %>" value="<%= BusinessDetails.PAYPAL_PDT.EditValue %>"<%= BusinessDetails.PAYPAL_PDT.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.SMTP_PASSWORD.Visible Then ' SMTP_PASSWORD %>
	<div id="r_SMTP_PASSWORD" class="form-group">
		<label for="x_SMTP_PASSWORD" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_SMTP_PASSWORD"><%= BusinessDetails.SMTP_PASSWORD.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_SMTP_PASSWORD" id="z_SMTP_PASSWORD" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.SMTP_PASSWORD.CellAttributes %>>
			<span id="el_BusinessDetails_SMTP_PASSWORD">
<input type="text" data-field="x_SMTP_PASSWORD" name="x_SMTP_PASSWORD" id="x_SMTP_PASSWORD" size="30" maxlength="255" placeholder="<%= BusinessDetails.SMTP_PASSWORD.PlaceHolder %>" value="<%= BusinessDetails.SMTP_PASSWORD.EditValue %>"<%= BusinessDetails.SMTP_PASSWORD.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.GMAP_API_KEY.Visible Then ' GMAP_API_KEY %>
	<div id="r_GMAP_API_KEY" class="form-group">
		<label for="x_GMAP_API_KEY" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_GMAP_API_KEY"><%= BusinessDetails.GMAP_API_KEY.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_GMAP_API_KEY" id="z_GMAP_API_KEY" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.GMAP_API_KEY.CellAttributes %>>
			<span id="el_BusinessDetails_GMAP_API_KEY">
<input type="text" data-field="x_GMAP_API_KEY" name="x_GMAP_API_KEY" id="x_GMAP_API_KEY" size="30" maxlength="255" placeholder="<%= BusinessDetails.GMAP_API_KEY.PlaceHolder %>" value="<%= BusinessDetails.GMAP_API_KEY.EditValue %>"<%= BusinessDetails.GMAP_API_KEY.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.SMTP_USERNAME.Visible Then ' SMTP_USERNAME %>
	<div id="r_SMTP_USERNAME" class="form-group">
		<label for="x_SMTP_USERNAME" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_SMTP_USERNAME"><%= BusinessDetails.SMTP_USERNAME.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_SMTP_USERNAME" id="z_SMTP_USERNAME" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.SMTP_USERNAME.CellAttributes %>>
			<span id="el_BusinessDetails_SMTP_USERNAME">
<input type="text" data-field="x_SMTP_USERNAME" name="x_SMTP_USERNAME" id="x_SMTP_USERNAME" size="30" maxlength="255" placeholder="<%= BusinessDetails.SMTP_USERNAME.PlaceHolder %>" value="<%= BusinessDetails.SMTP_USERNAME.EditValue %>"<%= BusinessDetails.SMTP_USERNAME.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.SMTP_USESSL.Visible Then ' SMTP_USESSL %>
	<div id="r_SMTP_USESSL" class="form-group">
		<label for="x_SMTP_USESSL" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_SMTP_USESSL"><%= BusinessDetails.SMTP_USESSL.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_SMTP_USESSL" id="z_SMTP_USESSL" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.SMTP_USESSL.CellAttributes %>>
			<span id="el_BusinessDetails_SMTP_USESSL">
<input type="text" data-field="x_SMTP_USESSL" name="x_SMTP_USESSL" id="x_SMTP_USESSL" size="30" maxlength="255" placeholder="<%= BusinessDetails.SMTP_USESSL.PlaceHolder %>" value="<%= BusinessDetails.SMTP_USESSL.EditValue %>"<%= BusinessDetails.SMTP_USESSL.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.MAIL_SUBJECT.Visible Then ' MAIL_SUBJECT %>
	<div id="r_MAIL_SUBJECT" class="form-group">
		<label for="x_MAIL_SUBJECT" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_MAIL_SUBJECT"><%= BusinessDetails.MAIL_SUBJECT.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_MAIL_SUBJECT" id="z_MAIL_SUBJECT" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.MAIL_SUBJECT.CellAttributes %>>
			<span id="el_BusinessDetails_MAIL_SUBJECT">
<input type="text" data-field="x_MAIL_SUBJECT" name="x_MAIL_SUBJECT" id="x_MAIL_SUBJECT" size="30" maxlength="255" placeholder="<%= BusinessDetails.MAIL_SUBJECT.PlaceHolder %>" value="<%= BusinessDetails.MAIL_SUBJECT.EditValue %>"<%= BusinessDetails.MAIL_SUBJECT.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.CURRENCYSYMBOL.Visible Then ' CURRENCYSYMBOL %>
	<div id="r_CURRENCYSYMBOL" class="form-group">
		<label for="x_CURRENCYSYMBOL" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_CURRENCYSYMBOL"><%= BusinessDetails.CURRENCYSYMBOL.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_CURRENCYSYMBOL" id="z_CURRENCYSYMBOL" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.CURRENCYSYMBOL.CellAttributes %>>
			<span id="el_BusinessDetails_CURRENCYSYMBOL">
<input type="text" data-field="x_CURRENCYSYMBOL" name="x_CURRENCYSYMBOL" id="x_CURRENCYSYMBOL" size="30" maxlength="255" placeholder="<%= BusinessDetails.CURRENCYSYMBOL.PlaceHolder %>" value="<%= BusinessDetails.CURRENCYSYMBOL.EditValue %>"<%= BusinessDetails.CURRENCYSYMBOL.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.SMTP_SERVER.Visible Then ' SMTP_SERVER %>
	<div id="r_SMTP_SERVER" class="form-group">
		<label for="x_SMTP_SERVER" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_SMTP_SERVER"><%= BusinessDetails.SMTP_SERVER.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_SMTP_SERVER" id="z_SMTP_SERVER" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.SMTP_SERVER.CellAttributes %>>
			<span id="el_BusinessDetails_SMTP_SERVER">
<input type="text" data-field="x_SMTP_SERVER" name="x_SMTP_SERVER" id="x_SMTP_SERVER" size="30" maxlength="255" placeholder="<%= BusinessDetails.SMTP_SERVER.PlaceHolder %>" value="<%= BusinessDetails.SMTP_SERVER.EditValue %>"<%= BusinessDetails.SMTP_SERVER.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.CREDITCARDSURCHARGE.Visible Then ' CREDITCARDSURCHARGE %>
	<div id="r_CREDITCARDSURCHARGE" class="form-group">
		<label for="x_CREDITCARDSURCHARGE" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_CREDITCARDSURCHARGE"><%= BusinessDetails.CREDITCARDSURCHARGE.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_CREDITCARDSURCHARGE" id="z_CREDITCARDSURCHARGE" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.CREDITCARDSURCHARGE.CellAttributes %>>
			<span id="el_BusinessDetails_CREDITCARDSURCHARGE">
<input type="text" data-field="x_CREDITCARDSURCHARGE" name="x_CREDITCARDSURCHARGE" id="x_CREDITCARDSURCHARGE" size="30" maxlength="255" placeholder="<%= BusinessDetails.CREDITCARDSURCHARGE.PlaceHolder %>" value="<%= BusinessDetails.CREDITCARDSURCHARGE.EditValue %>"<%= BusinessDetails.CREDITCARDSURCHARGE.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.SMTP_PORT.Visible Then ' SMTP_PORT %>
	<div id="r_SMTP_PORT" class="form-group">
		<label for="x_SMTP_PORT" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_SMTP_PORT"><%= BusinessDetails.SMTP_PORT.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_SMTP_PORT" id="z_SMTP_PORT" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.SMTP_PORT.CellAttributes %>>
			<span id="el_BusinessDetails_SMTP_PORT">
<input type="text" data-field="x_SMTP_PORT" name="x_SMTP_PORT" id="x_SMTP_PORT" size="30" maxlength="255" placeholder="<%= BusinessDetails.SMTP_PORT.PlaceHolder %>" value="<%= BusinessDetails.SMTP_PORT.EditValue %>"<%= BusinessDetails.SMTP_PORT.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.STICK_MENU.Visible Then ' STICK_MENU %>
	<div id="r_STICK_MENU" class="form-group">
		<label for="x_STICK_MENU" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_STICK_MENU"><%= BusinessDetails.STICK_MENU.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_STICK_MENU" id="z_STICK_MENU" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.STICK_MENU.CellAttributes %>>
			<span id="el_BusinessDetails_STICK_MENU">
<input type="text" data-field="x_STICK_MENU" name="x_STICK_MENU" id="x_STICK_MENU" size="30" maxlength="255" placeholder="<%= BusinessDetails.STICK_MENU.PlaceHolder %>" value="<%= BusinessDetails.STICK_MENU.EditValue %>"<%= BusinessDetails.STICK_MENU.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.MAIL_CUSTOMER_SUBJECT.Visible Then ' MAIL_CUSTOMER_SUBJECT %>
	<div id="r_MAIL_CUSTOMER_SUBJECT" class="form-group">
		<label for="x_MAIL_CUSTOMER_SUBJECT" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_MAIL_CUSTOMER_SUBJECT"><%= BusinessDetails.MAIL_CUSTOMER_SUBJECT.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_MAIL_CUSTOMER_SUBJECT" id="z_MAIL_CUSTOMER_SUBJECT" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.MAIL_CUSTOMER_SUBJECT.CellAttributes %>>
			<span id="el_BusinessDetails_MAIL_CUSTOMER_SUBJECT">
<input type="text" data-field="x_MAIL_CUSTOMER_SUBJECT" name="x_MAIL_CUSTOMER_SUBJECT" id="x_MAIL_CUSTOMER_SUBJECT" size="30" maxlength="255" placeholder="<%= BusinessDetails.MAIL_CUSTOMER_SUBJECT.PlaceHolder %>" value="<%= BusinessDetails.MAIL_CUSTOMER_SUBJECT.EditValue %>"<%= BusinessDetails.MAIL_CUSTOMER_SUBJECT.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.Visible Then ' CONFIRMATION_EMAIL_ADDRESS %>
	<div id="r_CONFIRMATION_EMAIL_ADDRESS" class="form-group">
		<label for="x_CONFIRMATION_EMAIL_ADDRESS" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_CONFIRMATION_EMAIL_ADDRESS"><%= BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_CONFIRMATION_EMAIL_ADDRESS" id="z_CONFIRMATION_EMAIL_ADDRESS" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.CellAttributes %>>
			<span id="el_BusinessDetails_CONFIRMATION_EMAIL_ADDRESS">
<input type="text" data-field="x_CONFIRMATION_EMAIL_ADDRESS" name="x_CONFIRMATION_EMAIL_ADDRESS" id="x_CONFIRMATION_EMAIL_ADDRESS" size="30" maxlength="255" placeholder="<%= BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.PlaceHolder %>" value="<%= BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.EditValue %>"<%= BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.SEND_ORDERS_TO_PRINTER.Visible Then ' SEND_ORDERS_TO_PRINTER %>
	<div id="r_SEND_ORDERS_TO_PRINTER" class="form-group">
		<label for="x_SEND_ORDERS_TO_PRINTER" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_SEND_ORDERS_TO_PRINTER"><%= BusinessDetails.SEND_ORDERS_TO_PRINTER.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_SEND_ORDERS_TO_PRINTER" id="z_SEND_ORDERS_TO_PRINTER" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.SEND_ORDERS_TO_PRINTER.CellAttributes %>>
			<span id="el_BusinessDetails_SEND_ORDERS_TO_PRINTER">
<input type="text" data-field="x_SEND_ORDERS_TO_PRINTER" name="x_SEND_ORDERS_TO_PRINTER" id="x_SEND_ORDERS_TO_PRINTER" size="30" maxlength="255" placeholder="<%= BusinessDetails.SEND_ORDERS_TO_PRINTER.PlaceHolder %>" value="<%= BusinessDetails.SEND_ORDERS_TO_PRINTER.EditValue %>"<%= BusinessDetails.SEND_ORDERS_TO_PRINTER.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.timezone.Visible Then ' timezone %>
	<div id="r_timezone" class="form-group">
		<label for="x_timezone" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_timezone"><%= BusinessDetails.timezone.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_timezone" id="z_timezone" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.timezone.CellAttributes %>>
			<span id="el_BusinessDetails_timezone">
<input type="text" data-field="x_timezone" name="x_timezone" id="x_timezone" size="30" placeholder="<%= BusinessDetails.timezone.PlaceHolder %>" value="<%= BusinessDetails.timezone.EditValue %>"<%= BusinessDetails.timezone.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.PAYPAL_ADDR.Visible Then ' PAYPAL_ADDR %>
	<div id="r_PAYPAL_ADDR" class="form-group">
		<label for="x_PAYPAL_ADDR" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_PAYPAL_ADDR"><%= BusinessDetails.PAYPAL_ADDR.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_PAYPAL_ADDR" id="z_PAYPAL_ADDR" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.PAYPAL_ADDR.CellAttributes %>>
			<span id="el_BusinessDetails_PAYPAL_ADDR">
<input type="text" data-field="x_PAYPAL_ADDR" name="x_PAYPAL_ADDR" id="x_PAYPAL_ADDR" size="30" maxlength="255" placeholder="<%= BusinessDetails.PAYPAL_ADDR.PlaceHolder %>" value="<%= BusinessDetails.PAYPAL_ADDR.EditValue %>"<%= BusinessDetails.PAYPAL_ADDR.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.nochex.Visible Then ' nochex %>
	<div id="r_nochex" class="form-group">
		<label for="x_nochex" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_nochex"><%= BusinessDetails.nochex.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_nochex" id="z_nochex" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.nochex.CellAttributes %>>
			<span id="el_BusinessDetails_nochex">
<input type="text" data-field="x_nochex" name="x_nochex" id="x_nochex" size="30" maxlength="255" placeholder="<%= BusinessDetails.nochex.PlaceHolder %>" value="<%= BusinessDetails.nochex.EditValue %>"<%= BusinessDetails.nochex.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.nochexmerchantid.Visible Then ' nochexmerchantid %>
	<div id="r_nochexmerchantid" class="form-group">
		<label for="x_nochexmerchantid" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_nochexmerchantid"><%= BusinessDetails.nochexmerchantid.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_nochexmerchantid" id="z_nochexmerchantid" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.nochexmerchantid.CellAttributes %>>
			<span id="el_BusinessDetails_nochexmerchantid">
<input type="text" data-field="x_nochexmerchantid" name="x_nochexmerchantid" id="x_nochexmerchantid" size="30" maxlength="255" placeholder="<%= BusinessDetails.nochexmerchantid.PlaceHolder %>" value="<%= BusinessDetails.nochexmerchantid.EditValue %>"<%= BusinessDetails.nochexmerchantid.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.paypal.Visible Then ' paypal %>
	<div id="r_paypal" class="form-group">
		<label for="x_paypal" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_paypal"><%= BusinessDetails.paypal.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_paypal" id="z_paypal" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.paypal.CellAttributes %>>
			<span id="el_BusinessDetails_paypal">
<input type="text" data-field="x_paypal" name="x_paypal" id="x_paypal" size="30" maxlength="255" placeholder="<%= BusinessDetails.paypal.PlaceHolder %>" value="<%= BusinessDetails.paypal.EditValue %>"<%= BusinessDetails.paypal.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.IBT_API_KEY.Visible Then ' IBT_API_KEY %>
	<div id="r_IBT_API_KEY" class="form-group">
		<label for="x_IBT_API_KEY" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_IBT_API_KEY"><%= BusinessDetails.IBT_API_KEY.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_IBT_API_KEY" id="z_IBT_API_KEY" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.IBT_API_KEY.CellAttributes %>>
			<span id="el_BusinessDetails_IBT_API_KEY">
<input type="text" data-field="x_IBT_API_KEY" name="x_IBT_API_KEY" id="x_IBT_API_KEY" size="30" maxlength="255" placeholder="<%= BusinessDetails.IBT_API_KEY.PlaceHolder %>" value="<%= BusinessDetails.IBT_API_KEY.EditValue %>"<%= BusinessDetails.IBT_API_KEY.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.IBP_API_PASSWORD.Visible Then ' IBP_API_PASSWORD %>
	<div id="r_IBP_API_PASSWORD" class="form-group">
		<label for="x_IBP_API_PASSWORD" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_IBP_API_PASSWORD"><%= BusinessDetails.IBP_API_PASSWORD.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_IBP_API_PASSWORD" id="z_IBP_API_PASSWORD" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.IBP_API_PASSWORD.CellAttributes %>>
			<span id="el_BusinessDetails_IBP_API_PASSWORD">
<input type="text" data-field="x_IBP_API_PASSWORD" name="x_IBP_API_PASSWORD" id="x_IBP_API_PASSWORD" size="30" maxlength="255" placeholder="<%= BusinessDetails.IBP_API_PASSWORD.PlaceHolder %>" value="<%= BusinessDetails.IBP_API_PASSWORD.EditValue %>"<%= BusinessDetails.IBP_API_PASSWORD.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.disable_delivery.Visible Then ' disable_delivery %>
	<div id="r_disable_delivery" class="form-group">
		<label for="x_disable_delivery" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_disable_delivery"><%= BusinessDetails.disable_delivery.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_disable_delivery" id="z_disable_delivery" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.disable_delivery.CellAttributes %>>
			<span id="el_BusinessDetails_disable_delivery">
<input type="text" data-field="x_disable_delivery" name="x_disable_delivery" id="x_disable_delivery" size="30" maxlength="255" placeholder="<%= BusinessDetails.disable_delivery.PlaceHolder %>" value="<%= BusinessDetails.disable_delivery.EditValue %>"<%= BusinessDetails.disable_delivery.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.disable_collection.Visible Then ' disable_collection %>
	<div id="r_disable_collection" class="form-group">
		<label for="x_disable_collection" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_disable_collection"><%= BusinessDetails.disable_collection.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_disable_collection" id="z_disable_collection" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.disable_collection.CellAttributes %>>
			<span id="el_BusinessDetails_disable_collection">
<input type="text" data-field="x_disable_collection" name="x_disable_collection" id="x_disable_collection" size="30" maxlength="255" placeholder="<%= BusinessDetails.disable_collection.PlaceHolder %>" value="<%= BusinessDetails.disable_collection.EditValue %>"<%= BusinessDetails.disable_collection.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.worldpay.Visible Then ' worldpay %>
	<div id="r_worldpay" class="form-group">
		<label for="x_worldpay" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_worldpay"><%= BusinessDetails.worldpay.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_worldpay" id="z_worldpay" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.worldpay.CellAttributes %>>
			<span id="el_BusinessDetails_worldpay">
<input type="text" data-field="x_worldpay" name="x_worldpay" id="x_worldpay" size="30" maxlength="255" placeholder="<%= BusinessDetails.worldpay.PlaceHolder %>" value="<%= BusinessDetails.worldpay.EditValue %>"<%= BusinessDetails.worldpay.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.worldpaymerchantid.Visible Then ' worldpaymerchantid %>
	<div id="r_worldpaymerchantid" class="form-group">
		<label for="x_worldpaymerchantid" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_worldpaymerchantid"><%= BusinessDetails.worldpaymerchantid.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_worldpaymerchantid" id="z_worldpaymerchantid" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.worldpaymerchantid.CellAttributes %>>
			<span id="el_BusinessDetails_worldpaymerchantid">
<input type="text" data-field="x_worldpaymerchantid" name="x_worldpaymerchantid" id="x_worldpaymerchantid" size="30" maxlength="255" placeholder="<%= BusinessDetails.worldpaymerchantid.PlaceHolder %>" value="<%= BusinessDetails.worldpaymerchantid.EditValue %>"<%= BusinessDetails.worldpaymerchantid.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.backtohometext.Visible Then ' backtohometext %>
	<div id="r_backtohometext" class="form-group">
		<label for="x_backtohometext" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_backtohometext"><%= BusinessDetails.backtohometext.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_backtohometext" id="z_backtohometext" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.backtohometext.CellAttributes %>>
			<span id="el_BusinessDetails_backtohometext">
<input type="text" data-field="x_backtohometext" name="x_backtohometext" id="x_backtohometext" size="35" placeholder="<%= BusinessDetails.backtohometext.PlaceHolder %>" value="<%= BusinessDetails.backtohometext.EditValue %>"<%= BusinessDetails.backtohometext.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.closedtext.Visible Then ' closedtext %>
	<div id="r_closedtext" class="form-group">
		<label for="x_closedtext" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_closedtext"><%= BusinessDetails.closedtext.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_closedtext" id="z_closedtext" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.closedtext.CellAttributes %>>
			<span id="el_BusinessDetails_closedtext">
<input type="text" data-field="x_closedtext" name="x_closedtext" id="x_closedtext" size="35" placeholder="<%= BusinessDetails.closedtext.PlaceHolder %>" value="<%= BusinessDetails.closedtext.EditValue %>"<%= BusinessDetails.closedtext.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.DeliveryChargeOverrideByOrderValue.Visible Then ' DeliveryChargeOverrideByOrderValue %>
	<div id="r_DeliveryChargeOverrideByOrderValue" class="form-group">
		<label for="x_DeliveryChargeOverrideByOrderValue" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_DeliveryChargeOverrideByOrderValue"><%= BusinessDetails.DeliveryChargeOverrideByOrderValue.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_DeliveryChargeOverrideByOrderValue" id="z_DeliveryChargeOverrideByOrderValue" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.DeliveryChargeOverrideByOrderValue.CellAttributes %>>
			<span id="el_BusinessDetails_DeliveryChargeOverrideByOrderValue">
<input type="text" data-field="x_DeliveryChargeOverrideByOrderValue" name="x_DeliveryChargeOverrideByOrderValue" id="x_DeliveryChargeOverrideByOrderValue" size="30" maxlength="255" placeholder="<%= BusinessDetails.DeliveryChargeOverrideByOrderValue.PlaceHolder %>" value="<%= BusinessDetails.DeliveryChargeOverrideByOrderValue.EditValue %>"<%= BusinessDetails.DeliveryChargeOverrideByOrderValue.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.individualpostcodes.Visible Then ' individualpostcodes %>
	<div id="r_individualpostcodes" class="form-group">
		<label for="x_individualpostcodes" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_individualpostcodes"><%= BusinessDetails.individualpostcodes.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_individualpostcodes" id="z_individualpostcodes" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.individualpostcodes.CellAttributes %>>
			<span id="el_BusinessDetails_individualpostcodes">
<input type="text" data-field="x_individualpostcodes" name="x_individualpostcodes" id="x_individualpostcodes" size="35" placeholder="<%= BusinessDetails.individualpostcodes.PlaceHolder %>" value="<%= BusinessDetails.individualpostcodes.EditValue %>"<%= BusinessDetails.individualpostcodes.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.individualpostcodeschecking.Visible Then ' individualpostcodeschecking %>
	<div id="r_individualpostcodeschecking" class="form-group">
		<label for="x_individualpostcodeschecking" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_individualpostcodeschecking"><%= BusinessDetails.individualpostcodeschecking.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_individualpostcodeschecking" id="z_individualpostcodeschecking" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.individualpostcodeschecking.CellAttributes %>>
			<span id="el_BusinessDetails_individualpostcodeschecking">
<input type="text" data-field="x_individualpostcodeschecking" name="x_individualpostcodeschecking" id="x_individualpostcodeschecking" size="30" placeholder="<%= BusinessDetails.individualpostcodeschecking.PlaceHolder %>" value="<%= BusinessDetails.individualpostcodeschecking.EditValue %>"<%= BusinessDetails.individualpostcodeschecking.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.longitude.Visible Then ' longitude %>
	<div id="r_longitude" class="form-group">
		<label for="x_longitude" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_longitude"><%= BusinessDetails.longitude.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_longitude" id="z_longitude" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.longitude.CellAttributes %>>
			<span id="el_BusinessDetails_longitude">
<input type="text" data-field="x_longitude" name="x_longitude" id="x_longitude" size="30" maxlength="255" placeholder="<%= BusinessDetails.longitude.PlaceHolder %>" value="<%= BusinessDetails.longitude.EditValue %>"<%= BusinessDetails.longitude.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.latitude.Visible Then ' latitude %>
	<div id="r_latitude" class="form-group">
		<label for="x_latitude" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_latitude"><%= BusinessDetails.latitude.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_latitude" id="z_latitude" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.latitude.CellAttributes %>>
			<span id="el_BusinessDetails_latitude">
<input type="text" data-field="x_latitude" name="x_latitude" id="x_latitude" size="30" maxlength="255" placeholder="<%= BusinessDetails.latitude.PlaceHolder %>" value="<%= BusinessDetails.latitude.EditValue %>"<%= BusinessDetails.latitude.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.googleecommercetracking.Visible Then ' googleecommercetracking %>
	<div id="r_googleecommercetracking" class="form-group">
		<label for="x_googleecommercetracking" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_googleecommercetracking"><%= BusinessDetails.googleecommercetracking.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_googleecommercetracking" id="z_googleecommercetracking" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.googleecommercetracking.CellAttributes %>>
			<span id="el_BusinessDetails_googleecommercetracking">
<input type="text" data-field="x_googleecommercetracking" name="x_googleecommercetracking" id="x_googleecommercetracking" size="30" maxlength="255" placeholder="<%= BusinessDetails.googleecommercetracking.PlaceHolder %>" value="<%= BusinessDetails.googleecommercetracking.EditValue %>"<%= BusinessDetails.googleecommercetracking.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.googleecommercetrackingcode.Visible Then ' googleecommercetrackingcode %>
	<div id="r_googleecommercetrackingcode" class="form-group">
		<label for="x_googleecommercetrackingcode" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_googleecommercetrackingcode"><%= BusinessDetails.googleecommercetrackingcode.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_googleecommercetrackingcode" id="z_googleecommercetrackingcode" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.googleecommercetrackingcode.CellAttributes %>>
			<span id="el_BusinessDetails_googleecommercetrackingcode">
<input type="text" data-field="x_googleecommercetrackingcode" name="x_googleecommercetrackingcode" id="x_googleecommercetrackingcode" size="30" maxlength="255" placeholder="<%= BusinessDetails.googleecommercetrackingcode.PlaceHolder %>" value="<%= BusinessDetails.googleecommercetrackingcode.EditValue %>"<%= BusinessDetails.googleecommercetrackingcode.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.bringg.Visible Then ' bringg %>
	<div id="r_bringg" class="form-group">
		<label for="x_bringg" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_bringg"><%= BusinessDetails.bringg.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_bringg" id="z_bringg" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.bringg.CellAttributes %>>
			<span id="el_BusinessDetails_bringg">
<input type="text" data-field="x_bringg" name="x_bringg" id="x_bringg" size="30" maxlength="255" placeholder="<%= BusinessDetails.bringg.PlaceHolder %>" value="<%= BusinessDetails.bringg.EditValue %>"<%= BusinessDetails.bringg.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.bringgurl.Visible Then ' bringgurl %>
	<div id="r_bringgurl" class="form-group">
		<label for="x_bringgurl" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_bringgurl"><%= BusinessDetails.bringgurl.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_bringgurl" id="z_bringgurl" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.bringgurl.CellAttributes %>>
			<span id="el_BusinessDetails_bringgurl">
<input type="text" data-field="x_bringgurl" name="x_bringgurl" id="x_bringgurl" size="30" maxlength="255" placeholder="<%= BusinessDetails.bringgurl.PlaceHolder %>" value="<%= BusinessDetails.bringgurl.EditValue %>"<%= BusinessDetails.bringgurl.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.bringgcompanyid.Visible Then ' bringgcompanyid %>
	<div id="r_bringgcompanyid" class="form-group">
		<label for="x_bringgcompanyid" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_bringgcompanyid"><%= BusinessDetails.bringgcompanyid.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_bringgcompanyid" id="z_bringgcompanyid" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.bringgcompanyid.CellAttributes %>>
			<span id="el_BusinessDetails_bringgcompanyid">
<input type="text" data-field="x_bringgcompanyid" name="x_bringgcompanyid" id="x_bringgcompanyid" size="30" maxlength="255" placeholder="<%= BusinessDetails.bringgcompanyid.PlaceHolder %>" value="<%= BusinessDetails.bringgcompanyid.EditValue %>"<%= BusinessDetails.bringgcompanyid.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.orderonlywhenopen.Visible Then ' orderonlywhenopen %>
	<div id="r_orderonlywhenopen" class="form-group">
		<label for="x_orderonlywhenopen" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_orderonlywhenopen"><%= BusinessDetails.orderonlywhenopen.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_orderonlywhenopen" id="z_orderonlywhenopen" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.orderonlywhenopen.CellAttributes %>>
			<span id="el_BusinessDetails_orderonlywhenopen">
<input type="text" data-field="x_orderonlywhenopen" name="x_orderonlywhenopen" id="x_orderonlywhenopen" size="30" placeholder="<%= BusinessDetails.orderonlywhenopen.PlaceHolder %>" value="<%= BusinessDetails.orderonlywhenopen.EditValue %>"<%= BusinessDetails.orderonlywhenopen.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.disablelaterdelivery.Visible Then ' disablelaterdelivery %>
	<div id="r_disablelaterdelivery" class="form-group">
		<label for="x_disablelaterdelivery" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_disablelaterdelivery"><%= BusinessDetails.disablelaterdelivery.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_disablelaterdelivery" id="z_disablelaterdelivery" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.disablelaterdelivery.CellAttributes %>>
			<span id="el_BusinessDetails_disablelaterdelivery">
<input type="text" data-field="x_disablelaterdelivery" name="x_disablelaterdelivery" id="x_disablelaterdelivery" size="30" placeholder="<%= BusinessDetails.disablelaterdelivery.PlaceHolder %>" value="<%= BusinessDetails.disablelaterdelivery.EditValue %>"<%= BusinessDetails.disablelaterdelivery.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.menupagetext.Visible Then ' menupagetext %>
	<div id="r_menupagetext" class="form-group">
		<label for="x_menupagetext" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_menupagetext"><%= BusinessDetails.menupagetext.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_menupagetext" id="z_menupagetext" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.menupagetext.CellAttributes %>>
			<span id="el_BusinessDetails_menupagetext">
<input type="text" data-field="x_menupagetext" name="x_menupagetext" id="x_menupagetext" size="35" placeholder="<%= BusinessDetails.menupagetext.PlaceHolder %>" value="<%= BusinessDetails.menupagetext.EditValue %>"<%= BusinessDetails.menupagetext.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.ordertodayonly.Visible Then ' ordertodayonly %>
	<div id="r_ordertodayonly" class="form-group">
		<label for="x_ordertodayonly" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_ordertodayonly"><%= BusinessDetails.ordertodayonly.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_ordertodayonly" id="z_ordertodayonly" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.ordertodayonly.CellAttributes %>>
			<span id="el_BusinessDetails_ordertodayonly">
<input type="text" data-field="x_ordertodayonly" name="x_ordertodayonly" id="x_ordertodayonly" size="30" placeholder="<%= BusinessDetails.ordertodayonly.PlaceHolder %>" value="<%= BusinessDetails.ordertodayonly.EditValue %>"<%= BusinessDetails.ordertodayonly.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.mileskm.Visible Then ' mileskm %>
	<div id="r_mileskm" class="form-group">
		<label for="x_mileskm" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_mileskm"><%= BusinessDetails.mileskm.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_mileskm" id="z_mileskm" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.mileskm.CellAttributes %>>
			<span id="el_BusinessDetails_mileskm">
<input type="text" data-field="x_mileskm" name="x_mileskm" id="x_mileskm" size="30" maxlength="255" placeholder="<%= BusinessDetails.mileskm.PlaceHolder %>" value="<%= BusinessDetails.mileskm.EditValue %>"<%= BusinessDetails.mileskm.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.worldpaylive.Visible Then ' worldpaylive %>
	<div id="r_worldpaylive" class="form-group">
		<label for="x_worldpaylive" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_worldpaylive"><%= BusinessDetails.worldpaylive.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_worldpaylive" id="z_worldpaylive" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.worldpaylive.CellAttributes %>>
			<span id="el_BusinessDetails_worldpaylive">
<input type="text" data-field="x_worldpaylive" name="x_worldpaylive" id="x_worldpaylive" size="30" placeholder="<%= BusinessDetails.worldpaylive.PlaceHolder %>" value="<%= BusinessDetails.worldpaylive.EditValue %>"<%= BusinessDetails.worldpaylive.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.worldpayinstallationid.Visible Then ' worldpayinstallationid %>
	<div id="r_worldpayinstallationid" class="form-group">
		<label for="x_worldpayinstallationid" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_worldpayinstallationid"><%= BusinessDetails.worldpayinstallationid.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_worldpayinstallationid" id="z_worldpayinstallationid" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.worldpayinstallationid.CellAttributes %>>
			<span id="el_BusinessDetails_worldpayinstallationid">
<input type="text" data-field="x_worldpayinstallationid" name="x_worldpayinstallationid" id="x_worldpayinstallationid" size="30" maxlength="255" placeholder="<%= BusinessDetails.worldpayinstallationid.PlaceHolder %>" value="<%= BusinessDetails.worldpayinstallationid.EditValue %>"<%= BusinessDetails.worldpayinstallationid.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.DistanceCalMethod.Visible Then ' DistanceCalMethod %>
	<div id="r_DistanceCalMethod" class="form-group">
		<label for="x_DistanceCalMethod" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_DistanceCalMethod"><%= BusinessDetails.DistanceCalMethod.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_DistanceCalMethod" id="z_DistanceCalMethod" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.DistanceCalMethod.CellAttributes %>>
			<span id="el_BusinessDetails_DistanceCalMethod">
<input type="text" data-field="x_DistanceCalMethod" name="x_DistanceCalMethod" id="x_DistanceCalMethod" size="30" maxlength="255" placeholder="<%= BusinessDetails.DistanceCalMethod.PlaceHolder %>" value="<%= BusinessDetails.DistanceCalMethod.EditValue %>"<%= BusinessDetails.DistanceCalMethod.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.PrinterIDList.Visible Then ' PrinterIDList %>
	<div id="r_PrinterIDList" class="form-group">
		<label for="x_PrinterIDList" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_PrinterIDList"><%= BusinessDetails.PrinterIDList.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_PrinterIDList" id="z_PrinterIDList" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.PrinterIDList.CellAttributes %>>
			<span id="el_BusinessDetails_PrinterIDList">
<input type="text" data-field="x_PrinterIDList" name="x_PrinterIDList" id="x_PrinterIDList" size="30" maxlength="255" placeholder="<%= BusinessDetails.PrinterIDList.PlaceHolder %>" value="<%= BusinessDetails.PrinterIDList.EditValue %>"<%= BusinessDetails.PrinterIDList.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.EpsonJSPrinterURL.Visible Then ' EpsonJSPrinterURL %>
	<div id="r_EpsonJSPrinterURL" class="form-group">
		<label for="x_EpsonJSPrinterURL" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_EpsonJSPrinterURL"><%= BusinessDetails.EpsonJSPrinterURL.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_EpsonJSPrinterURL" id="z_EpsonJSPrinterURL" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.EpsonJSPrinterURL.CellAttributes %>>
			<span id="el_BusinessDetails_EpsonJSPrinterURL">
<input type="text" data-field="x_EpsonJSPrinterURL" name="x_EpsonJSPrinterURL" id="x_EpsonJSPrinterURL" size="30" maxlength="128" placeholder="<%= BusinessDetails.EpsonJSPrinterURL.PlaceHolder %>" value="<%= BusinessDetails.EpsonJSPrinterURL.EditValue %>"<%= BusinessDetails.EpsonJSPrinterURL.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.SMSEnable.Visible Then ' SMSEnable %>
	<div id="r_SMSEnable" class="form-group">
		<label for="x_SMSEnable" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_SMSEnable"><%= BusinessDetails.SMSEnable.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_SMSEnable" id="z_SMSEnable" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.SMSEnable.CellAttributes %>>
			<span id="el_BusinessDetails_SMSEnable">
<input type="text" data-field="x_SMSEnable" name="x_SMSEnable" id="x_SMSEnable" size="30" placeholder="<%= BusinessDetails.SMSEnable.PlaceHolder %>" value="<%= BusinessDetails.SMSEnable.EditValue %>"<%= BusinessDetails.SMSEnable.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.SMSOnDelivery.Visible Then ' SMSOnDelivery %>
	<div id="r_SMSOnDelivery" class="form-group">
		<label for="x_SMSOnDelivery" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_SMSOnDelivery"><%= BusinessDetails.SMSOnDelivery.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_SMSOnDelivery" id="z_SMSOnDelivery" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.SMSOnDelivery.CellAttributes %>>
			<span id="el_BusinessDetails_SMSOnDelivery">
<input type="text" data-field="x_SMSOnDelivery" name="x_SMSOnDelivery" id="x_SMSOnDelivery" size="30" placeholder="<%= BusinessDetails.SMSOnDelivery.PlaceHolder %>" value="<%= BusinessDetails.SMSOnDelivery.EditValue %>"<%= BusinessDetails.SMSOnDelivery.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.SMSSupplierDomain.Visible Then ' SMSSupplierDomain %>
	<div id="r_SMSSupplierDomain" class="form-group">
		<label for="x_SMSSupplierDomain" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_SMSSupplierDomain"><%= BusinessDetails.SMSSupplierDomain.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_SMSSupplierDomain" id="z_SMSSupplierDomain" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.SMSSupplierDomain.CellAttributes %>>
			<span id="el_BusinessDetails_SMSSupplierDomain">
<input type="text" data-field="x_SMSSupplierDomain" name="x_SMSSupplierDomain" id="x_SMSSupplierDomain" size="30" maxlength="100" placeholder="<%= BusinessDetails.SMSSupplierDomain.PlaceHolder %>" value="<%= BusinessDetails.SMSSupplierDomain.EditValue %>"<%= BusinessDetails.SMSSupplierDomain.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.SMSOnOrder.Visible Then ' SMSOnOrder %>
	<div id="r_SMSOnOrder" class="form-group">
		<label for="x_SMSOnOrder" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_SMSOnOrder"><%= BusinessDetails.SMSOnOrder.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_SMSOnOrder" id="z_SMSOnOrder" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.SMSOnOrder.CellAttributes %>>
			<span id="el_BusinessDetails_SMSOnOrder">
<input type="text" data-field="x_SMSOnOrder" name="x_SMSOnOrder" id="x_SMSOnOrder" size="30" placeholder="<%= BusinessDetails.SMSOnOrder.PlaceHolder %>" value="<%= BusinessDetails.SMSOnOrder.EditValue %>"<%= BusinessDetails.SMSOnOrder.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.SMSOnOrderAfterMin.Visible Then ' SMSOnOrderAfterMin %>
	<div id="r_SMSOnOrderAfterMin" class="form-group">
		<label for="x_SMSOnOrderAfterMin" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_SMSOnOrderAfterMin"><%= BusinessDetails.SMSOnOrderAfterMin.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_SMSOnOrderAfterMin" id="z_SMSOnOrderAfterMin" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.SMSOnOrderAfterMin.CellAttributes %>>
			<span id="el_BusinessDetails_SMSOnOrderAfterMin">
<input type="text" data-field="x_SMSOnOrderAfterMin" name="x_SMSOnOrderAfterMin" id="x_SMSOnOrderAfterMin" size="30" placeholder="<%= BusinessDetails.SMSOnOrderAfterMin.PlaceHolder %>" value="<%= BusinessDetails.SMSOnOrderAfterMin.EditValue %>"<%= BusinessDetails.SMSOnOrderAfterMin.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.SMSOnOrderContent.Visible Then ' SMSOnOrderContent %>
	<div id="r_SMSOnOrderContent" class="form-group">
		<label for="x_SMSOnOrderContent" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_SMSOnOrderContent"><%= BusinessDetails.SMSOnOrderContent.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_SMSOnOrderContent" id="z_SMSOnOrderContent" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.SMSOnOrderContent.CellAttributes %>>
			<span id="el_BusinessDetails_SMSOnOrderContent">
<input type="text" data-field="x_SMSOnOrderContent" name="x_SMSOnOrderContent" id="x_SMSOnOrderContent" size="30" maxlength="255" placeholder="<%= BusinessDetails.SMSOnOrderContent.PlaceHolder %>" value="<%= BusinessDetails.SMSOnOrderContent.EditValue %>"<%= BusinessDetails.SMSOnOrderContent.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.DefaultSMSCountryCode.Visible Then ' DefaultSMSCountryCode %>
	<div id="r_DefaultSMSCountryCode" class="form-group">
		<label for="x_DefaultSMSCountryCode" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_DefaultSMSCountryCode"><%= BusinessDetails.DefaultSMSCountryCode.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_DefaultSMSCountryCode" id="z_DefaultSMSCountryCode" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.DefaultSMSCountryCode.CellAttributes %>>
			<span id="el_BusinessDetails_DefaultSMSCountryCode">
<input type="text" data-field="x_DefaultSMSCountryCode" name="x_DefaultSMSCountryCode" id="x_DefaultSMSCountryCode" size="30" maxlength="10" placeholder="<%= BusinessDetails.DefaultSMSCountryCode.PlaceHolder %>" value="<%= BusinessDetails.DefaultSMSCountryCode.EditValue %>"<%= BusinessDetails.DefaultSMSCountryCode.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.MinimumAmountForCardPayment.Visible Then ' MinimumAmountForCardPayment %>
	<div id="r_MinimumAmountForCardPayment" class="form-group">
		<label for="x_MinimumAmountForCardPayment" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_MinimumAmountForCardPayment"><%= BusinessDetails.MinimumAmountForCardPayment.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_MinimumAmountForCardPayment" id="z_MinimumAmountForCardPayment" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.MinimumAmountForCardPayment.CellAttributes %>>
			<span id="el_BusinessDetails_MinimumAmountForCardPayment">
<input type="text" data-field="x_MinimumAmountForCardPayment" name="x_MinimumAmountForCardPayment" id="x_MinimumAmountForCardPayment" size="30" placeholder="<%= BusinessDetails.MinimumAmountForCardPayment.PlaceHolder %>" value="<%= BusinessDetails.MinimumAmountForCardPayment.EditValue %>"<%= BusinessDetails.MinimumAmountForCardPayment.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.FavIconUrl.Visible Then ' FavIconUrl %>
	<div id="r_FavIconUrl" class="form-group">
		<label for="x_FavIconUrl" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_FavIconUrl"><%= BusinessDetails.FavIconUrl.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_FavIconUrl" id="z_FavIconUrl" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.FavIconUrl.CellAttributes %>>
			<span id="el_BusinessDetails_FavIconUrl">
<input type="text" data-field="x_FavIconUrl" name="x_FavIconUrl" id="x_FavIconUrl" size="30" maxlength="255" placeholder="<%= BusinessDetails.FavIconUrl.PlaceHolder %>" value="<%= BusinessDetails.FavIconUrl.EditValue %>"<%= BusinessDetails.FavIconUrl.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.AddToHomeScreenURL.Visible Then ' AddToHomeScreenURL %>
	<div id="r_AddToHomeScreenURL" class="form-group">
		<label for="x_AddToHomeScreenURL" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_AddToHomeScreenURL"><%= BusinessDetails.AddToHomeScreenURL.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_AddToHomeScreenURL" id="z_AddToHomeScreenURL" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.AddToHomeScreenURL.CellAttributes %>>
			<span id="el_BusinessDetails_AddToHomeScreenURL">
<input type="text" data-field="x_AddToHomeScreenURL" name="x_AddToHomeScreenURL" id="x_AddToHomeScreenURL" size="30" maxlength="255" placeholder="<%= BusinessDetails.AddToHomeScreenURL.PlaceHolder %>" value="<%= BusinessDetails.AddToHomeScreenURL.EditValue %>"<%= BusinessDetails.AddToHomeScreenURL.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.SMSOnAcknowledgement.Visible Then ' SMSOnAcknowledgement %>
	<div id="r_SMSOnAcknowledgement" class="form-group">
		<label for="x_SMSOnAcknowledgement" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_SMSOnAcknowledgement"><%= BusinessDetails.SMSOnAcknowledgement.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_SMSOnAcknowledgement" id="z_SMSOnAcknowledgement" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.SMSOnAcknowledgement.CellAttributes %>>
			<span id="el_BusinessDetails_SMSOnAcknowledgement">
<input type="text" data-field="x_SMSOnAcknowledgement" name="x_SMSOnAcknowledgement" id="x_SMSOnAcknowledgement" size="30" placeholder="<%= BusinessDetails.SMSOnAcknowledgement.PlaceHolder %>" value="<%= BusinessDetails.SMSOnAcknowledgement.EditValue %>"<%= BusinessDetails.SMSOnAcknowledgement.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.LocalPrinterURL.Visible Then ' LocalPrinterURL %>
	<div id="r_LocalPrinterURL" class="form-group">
		<label for="x_LocalPrinterURL" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_LocalPrinterURL"><%= BusinessDetails.LocalPrinterURL.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_LocalPrinterURL" id="z_LocalPrinterURL" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.LocalPrinterURL.CellAttributes %>>
			<span id="el_BusinessDetails_LocalPrinterURL">
<input type="text" data-field="x_LocalPrinterURL" name="x_LocalPrinterURL" id="x_LocalPrinterURL" size="30" maxlength="255" placeholder="<%= BusinessDetails.LocalPrinterURL.PlaceHolder %>" value="<%= BusinessDetails.LocalPrinterURL.EditValue %>"<%= BusinessDetails.LocalPrinterURL.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.ShowRestaurantDetailOnReceipt.Visible Then ' ShowRestaurantDetailOnReceipt %>
	<div id="r_ShowRestaurantDetailOnReceipt" class="form-group">
		<label for="x_ShowRestaurantDetailOnReceipt" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_ShowRestaurantDetailOnReceipt"><%= BusinessDetails.ShowRestaurantDetailOnReceipt.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_ShowRestaurantDetailOnReceipt" id="z_ShowRestaurantDetailOnReceipt" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.ShowRestaurantDetailOnReceipt.CellAttributes %>>
			<span id="el_BusinessDetails_ShowRestaurantDetailOnReceipt">
<input type="text" data-field="x_ShowRestaurantDetailOnReceipt" name="x_ShowRestaurantDetailOnReceipt" id="x_ShowRestaurantDetailOnReceipt" size="30" placeholder="<%= BusinessDetails.ShowRestaurantDetailOnReceipt.PlaceHolder %>" value="<%= BusinessDetails.ShowRestaurantDetailOnReceipt.EditValue %>"<%= BusinessDetails.ShowRestaurantDetailOnReceipt.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.PrinterFontSizeRatio.Visible Then ' PrinterFontSizeRatio %>
	<div id="r_PrinterFontSizeRatio" class="form-group">
		<label for="x_PrinterFontSizeRatio" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_PrinterFontSizeRatio"><%= BusinessDetails.PrinterFontSizeRatio.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_PrinterFontSizeRatio" id="z_PrinterFontSizeRatio" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.PrinterFontSizeRatio.CellAttributes %>>
			<span id="el_BusinessDetails_PrinterFontSizeRatio">
<input type="text" data-field="x_PrinterFontSizeRatio" name="x_PrinterFontSizeRatio" id="x_PrinterFontSizeRatio" size="30" placeholder="<%= BusinessDetails.PrinterFontSizeRatio.PlaceHolder %>" value="<%= BusinessDetails.PrinterFontSizeRatio.EditValue %>"<%= BusinessDetails.PrinterFontSizeRatio.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.ServiceChargePercentage.Visible Then ' ServiceChargePercentage %>
	<div id="r_ServiceChargePercentage" class="form-group">
		<label for="x_ServiceChargePercentage" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_ServiceChargePercentage"><%= BusinessDetails.ServiceChargePercentage.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_ServiceChargePercentage" id="z_ServiceChargePercentage" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.ServiceChargePercentage.CellAttributes %>>
			<span id="el_BusinessDetails_ServiceChargePercentage">
<input type="text" data-field="x_ServiceChargePercentage" name="x_ServiceChargePercentage" id="x_ServiceChargePercentage" size="30" placeholder="<%= BusinessDetails.ServiceChargePercentage.PlaceHolder %>" value="<%= BusinessDetails.ServiceChargePercentage.EditValue %>"<%= BusinessDetails.ServiceChargePercentage.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.InRestaurantServiceChargeOnly.Visible Then ' InRestaurantServiceChargeOnly %>
	<div id="r_InRestaurantServiceChargeOnly" class="form-group">
		<label for="x_InRestaurantServiceChargeOnly" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_InRestaurantServiceChargeOnly"><%= BusinessDetails.InRestaurantServiceChargeOnly.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_InRestaurantServiceChargeOnly" id="z_InRestaurantServiceChargeOnly" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.InRestaurantServiceChargeOnly.CellAttributes %>>
			<span id="el_BusinessDetails_InRestaurantServiceChargeOnly">
<input type="text" data-field="x_InRestaurantServiceChargeOnly" name="x_InRestaurantServiceChargeOnly" id="x_InRestaurantServiceChargeOnly" size="30" placeholder="<%= BusinessDetails.InRestaurantServiceChargeOnly.PlaceHolder %>" value="<%= BusinessDetails.InRestaurantServiceChargeOnly.EditValue %>"<%= BusinessDetails.InRestaurantServiceChargeOnly.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.IsDualReceiptPrinting.Visible Then ' IsDualReceiptPrinting %>
	<div id="r_IsDualReceiptPrinting" class="form-group">
		<label for="x_IsDualReceiptPrinting" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_IsDualReceiptPrinting"><%= BusinessDetails.IsDualReceiptPrinting.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_IsDualReceiptPrinting" id="z_IsDualReceiptPrinting" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.IsDualReceiptPrinting.CellAttributes %>>
			<span id="el_BusinessDetails_IsDualReceiptPrinting">
<input type="text" data-field="x_IsDualReceiptPrinting" name="x_IsDualReceiptPrinting" id="x_IsDualReceiptPrinting" size="30" placeholder="<%= BusinessDetails.IsDualReceiptPrinting.PlaceHolder %>" value="<%= BusinessDetails.IsDualReceiptPrinting.EditValue %>"<%= BusinessDetails.IsDualReceiptPrinting.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.PrintingFontSize.Visible Then ' PrintingFontSize %>
	<div id="r_PrintingFontSize" class="form-group">
		<label for="x_PrintingFontSize" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_PrintingFontSize"><%= BusinessDetails.PrintingFontSize.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_PrintingFontSize" id="z_PrintingFontSize" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.PrintingFontSize.CellAttributes %>>
			<span id="el_BusinessDetails_PrintingFontSize">
<input type="text" data-field="x_PrintingFontSize" name="x_PrintingFontSize" id="x_PrintingFontSize" size="30" placeholder="<%= BusinessDetails.PrintingFontSize.PlaceHolder %>" value="<%= BusinessDetails.PrintingFontSize.EditValue %>"<%= BusinessDetails.PrintingFontSize.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.InRestaurantEpsonPrinterIDList.Visible Then ' InRestaurantEpsonPrinterIDList %>
	<div id="r_InRestaurantEpsonPrinterIDList" class="form-group">
		<label for="x_InRestaurantEpsonPrinterIDList" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_InRestaurantEpsonPrinterIDList"><%= BusinessDetails.InRestaurantEpsonPrinterIDList.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_InRestaurantEpsonPrinterIDList" id="z_InRestaurantEpsonPrinterIDList" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.InRestaurantEpsonPrinterIDList.CellAttributes %>>
			<span id="el_BusinessDetails_InRestaurantEpsonPrinterIDList">
<input type="text" data-field="x_InRestaurantEpsonPrinterIDList" name="x_InRestaurantEpsonPrinterIDList" id="x_InRestaurantEpsonPrinterIDList" size="30" maxlength="128" placeholder="<%= BusinessDetails.InRestaurantEpsonPrinterIDList.PlaceHolder %>" value="<%= BusinessDetails.InRestaurantEpsonPrinterIDList.EditValue %>"<%= BusinessDetails.InRestaurantEpsonPrinterIDList.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.BlockIPEmailList.Visible Then ' BlockIPEmailList %>
	<div id="r_BlockIPEmailList" class="form-group">
		<label for="x_BlockIPEmailList" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_BlockIPEmailList"><%= BusinessDetails.BlockIPEmailList.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_BlockIPEmailList" id="z_BlockIPEmailList" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.BlockIPEmailList.CellAttributes %>>
			<span id="el_BusinessDetails_BlockIPEmailList">
<input type="text" data-field="x_BlockIPEmailList" name="x_BlockIPEmailList" id="x_BlockIPEmailList" size="30" maxlength="255" placeholder="<%= BusinessDetails.BlockIPEmailList.PlaceHolder %>" value="<%= BusinessDetails.BlockIPEmailList.EditValue %>"<%= BusinessDetails.BlockIPEmailList.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.inmenuannouncement.Visible Then ' inmenuannouncement %>
	<div id="r_inmenuannouncement" class="form-group">
		<label for="x_inmenuannouncement" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_inmenuannouncement"><%= BusinessDetails.inmenuannouncement.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_inmenuannouncement" id="z_inmenuannouncement" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.inmenuannouncement.CellAttributes %>>
			<span id="el_BusinessDetails_inmenuannouncement">
<input type="text" data-field="x_inmenuannouncement" name="x_inmenuannouncement" id="x_inmenuannouncement" size="35" placeholder="<%= BusinessDetails.inmenuannouncement.PlaceHolder %>" value="<%= BusinessDetails.inmenuannouncement.EditValue %>"<%= BusinessDetails.inmenuannouncement.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.RePrintReceiptWays.Visible Then ' RePrintReceiptWays %>
	<div id="r_RePrintReceiptWays" class="form-group">
		<label for="x_RePrintReceiptWays" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_RePrintReceiptWays"><%= BusinessDetails.RePrintReceiptWays.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_RePrintReceiptWays" id="z_RePrintReceiptWays" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.RePrintReceiptWays.CellAttributes %>>
			<span id="el_BusinessDetails_RePrintReceiptWays">
<input type="text" data-field="x_RePrintReceiptWays" name="x_RePrintReceiptWays" id="x_RePrintReceiptWays" size="30" maxlength="255" placeholder="<%= BusinessDetails.RePrintReceiptWays.PlaceHolder %>" value="<%= BusinessDetails.RePrintReceiptWays.EditValue %>"<%= BusinessDetails.RePrintReceiptWays.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.printingtype.Visible Then ' printingtype %>
	<div id="r_printingtype" class="form-group">
		<label for="x_printingtype" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_printingtype"><%= BusinessDetails.printingtype.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_printingtype" id="z_printingtype" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.printingtype.CellAttributes %>>
			<span id="el_BusinessDetails_printingtype">
<input type="text" data-field="x_printingtype" name="x_printingtype" id="x_printingtype" size="30" maxlength="255" placeholder="<%= BusinessDetails.printingtype.PlaceHolder %>" value="<%= BusinessDetails.printingtype.EditValue %>"<%= BusinessDetails.printingtype.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.Stripe_Key_Secret.Visible Then ' Stripe_Key_Secret %>
	<div id="r_Stripe_Key_Secret" class="form-group">
		<label for="x_Stripe_Key_Secret" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_Stripe_Key_Secret"><%= BusinessDetails.Stripe_Key_Secret.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_Stripe_Key_Secret" id="z_Stripe_Key_Secret" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.Stripe_Key_Secret.CellAttributes %>>
			<span id="el_BusinessDetails_Stripe_Key_Secret">
<input type="text" data-field="x_Stripe_Key_Secret" name="x_Stripe_Key_Secret" id="x_Stripe_Key_Secret" size="30" maxlength="255" placeholder="<%= BusinessDetails.Stripe_Key_Secret.PlaceHolder %>" value="<%= BusinessDetails.Stripe_Key_Secret.EditValue %>"<%= BusinessDetails.Stripe_Key_Secret.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.Stripe.Visible Then ' Stripe %>
	<div id="r_Stripe" class="form-group">
		<label for="x_Stripe" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_Stripe"><%= BusinessDetails.Stripe.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_Stripe" id="z_Stripe" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.Stripe.CellAttributes %>>
			<span id="el_BusinessDetails_Stripe">
<input type="text" data-field="x_Stripe" name="x_Stripe" id="x_Stripe" size="30" maxlength="255" placeholder="<%= BusinessDetails.Stripe.PlaceHolder %>" value="<%= BusinessDetails.Stripe.EditValue %>"<%= BusinessDetails.Stripe.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.Stripe_Api_Key.Visible Then ' Stripe_Api_Key %>
	<div id="r_Stripe_Api_Key" class="form-group">
		<label for="x_Stripe_Api_Key" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_Stripe_Api_Key"><%= BusinessDetails.Stripe_Api_Key.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_Stripe_Api_Key" id="z_Stripe_Api_Key" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.Stripe_Api_Key.CellAttributes %>>
			<span id="el_BusinessDetails_Stripe_Api_Key">
<input type="text" data-field="x_Stripe_Api_Key" name="x_Stripe_Api_Key" id="x_Stripe_Api_Key" size="30" maxlength="255" placeholder="<%= BusinessDetails.Stripe_Api_Key.PlaceHolder %>" value="<%= BusinessDetails.Stripe_Api_Key.EditValue %>"<%= BusinessDetails.Stripe_Api_Key.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.EnableBooking.Visible Then ' EnableBooking %>
	<div id="r_EnableBooking" class="form-group">
		<label for="x_EnableBooking" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_EnableBooking"><%= BusinessDetails.EnableBooking.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_EnableBooking" id="z_EnableBooking" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.EnableBooking.CellAttributes %>>
			<span id="el_BusinessDetails_EnableBooking">
<input type="text" data-field="x_EnableBooking" name="x_EnableBooking" id="x_EnableBooking" size="30" maxlength="255" placeholder="<%= BusinessDetails.EnableBooking.PlaceHolder %>" value="<%= BusinessDetails.EnableBooking.EditValue %>"<%= BusinessDetails.EnableBooking.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.URL_Facebook.Visible Then ' URL_Facebook %>
	<div id="r_URL_Facebook" class="form-group">
		<label for="x_URL_Facebook" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_URL_Facebook"><%= BusinessDetails.URL_Facebook.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_URL_Facebook" id="z_URL_Facebook" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.URL_Facebook.CellAttributes %>>
			<span id="el_BusinessDetails_URL_Facebook">
<input type="text" data-field="x_URL_Facebook" name="x_URL_Facebook" id="x_URL_Facebook" size="30" maxlength="255" placeholder="<%= BusinessDetails.URL_Facebook.PlaceHolder %>" value="<%= BusinessDetails.URL_Facebook.EditValue %>"<%= BusinessDetails.URL_Facebook.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.URL_Twitter.Visible Then ' URL_Twitter %>
	<div id="r_URL_Twitter" class="form-group">
		<label for="x_URL_Twitter" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_URL_Twitter"><%= BusinessDetails.URL_Twitter.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_URL_Twitter" id="z_URL_Twitter" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.URL_Twitter.CellAttributes %>>
			<span id="el_BusinessDetails_URL_Twitter">
<input type="text" data-field="x_URL_Twitter" name="x_URL_Twitter" id="x_URL_Twitter" size="30" maxlength="255" placeholder="<%= BusinessDetails.URL_Twitter.PlaceHolder %>" value="<%= BusinessDetails.URL_Twitter.EditValue %>"<%= BusinessDetails.URL_Twitter.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.URL_Google.Visible Then ' URL_Google %>
	<div id="r_URL_Google" class="form-group">
		<label for="x_URL_Google" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_URL_Google"><%= BusinessDetails.URL_Google.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_URL_Google" id="z_URL_Google" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.URL_Google.CellAttributes %>>
			<span id="el_BusinessDetails_URL_Google">
<input type="text" data-field="x_URL_Google" name="x_URL_Google" id="x_URL_Google" size="30" maxlength="255" placeholder="<%= BusinessDetails.URL_Google.PlaceHolder %>" value="<%= BusinessDetails.URL_Google.EditValue %>"<%= BusinessDetails.URL_Google.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.URL_Intagram.Visible Then ' URL_Intagram %>
	<div id="r_URL_Intagram" class="form-group">
		<label for="x_URL_Intagram" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_URL_Intagram"><%= BusinessDetails.URL_Intagram.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_URL_Intagram" id="z_URL_Intagram" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.URL_Intagram.CellAttributes %>>
			<span id="el_BusinessDetails_URL_Intagram">
<input type="text" data-field="x_URL_Intagram" name="x_URL_Intagram" id="x_URL_Intagram" size="30" maxlength="255" placeholder="<%= BusinessDetails.URL_Intagram.PlaceHolder %>" value="<%= BusinessDetails.URL_Intagram.EditValue %>"<%= BusinessDetails.URL_Intagram.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.URL_YouTube.Visible Then ' URL_YouTube %>
	<div id="r_URL_YouTube" class="form-group">
		<label for="x_URL_YouTube" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_URL_YouTube"><%= BusinessDetails.URL_YouTube.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_URL_YouTube" id="z_URL_YouTube" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.URL_YouTube.CellAttributes %>>
			<span id="el_BusinessDetails_URL_YouTube">
<input type="text" data-field="x_URL_YouTube" name="x_URL_YouTube" id="x_URL_YouTube" size="30" maxlength="255" placeholder="<%= BusinessDetails.URL_YouTube.PlaceHolder %>" value="<%= BusinessDetails.URL_YouTube.EditValue %>"<%= BusinessDetails.URL_YouTube.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.URL_Tripadvisor.Visible Then ' URL_Tripadvisor %>
	<div id="r_URL_Tripadvisor" class="form-group">
		<label for="x_URL_Tripadvisor" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_URL_Tripadvisor"><%= BusinessDetails.URL_Tripadvisor.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_URL_Tripadvisor" id="z_URL_Tripadvisor" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.URL_Tripadvisor.CellAttributes %>>
			<span id="el_BusinessDetails_URL_Tripadvisor">
<input type="text" data-field="x_URL_Tripadvisor" name="x_URL_Tripadvisor" id="x_URL_Tripadvisor" size="30" maxlength="255" placeholder="<%= BusinessDetails.URL_Tripadvisor.PlaceHolder %>" value="<%= BusinessDetails.URL_Tripadvisor.EditValue %>"<%= BusinessDetails.URL_Tripadvisor.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.URL_Special_Offer.Visible Then ' URL_Special_Offer %>
	<div id="r_URL_Special_Offer" class="form-group">
		<label for="x_URL_Special_Offer" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_URL_Special_Offer"><%= BusinessDetails.URL_Special_Offer.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_URL_Special_Offer" id="z_URL_Special_Offer" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.URL_Special_Offer.CellAttributes %>>
			<span id="el_BusinessDetails_URL_Special_Offer">
<input type="text" data-field="x_URL_Special_Offer" name="x_URL_Special_Offer" id="x_URL_Special_Offer" size="30" maxlength="255" placeholder="<%= BusinessDetails.URL_Special_Offer.PlaceHolder %>" value="<%= BusinessDetails.URL_Special_Offer.EditValue %>"<%= BusinessDetails.URL_Special_Offer.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.URL_Linkin.Visible Then ' URL_Linkin %>
	<div id="r_URL_Linkin" class="form-group">
		<label for="x_URL_Linkin" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_URL_Linkin"><%= BusinessDetails.URL_Linkin.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_URL_Linkin" id="z_URL_Linkin" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.URL_Linkin.CellAttributes %>>
			<span id="el_BusinessDetails_URL_Linkin">
<input type="text" data-field="x_URL_Linkin" name="x_URL_Linkin" id="x_URL_Linkin" size="30" maxlength="255" placeholder="<%= BusinessDetails.URL_Linkin.PlaceHolder %>" value="<%= BusinessDetails.URL_Linkin.EditValue %>"<%= BusinessDetails.URL_Linkin.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.Currency_PAYPAL.Visible Then ' Currency_PAYPAL %>
	<div id="r_Currency_PAYPAL" class="form-group">
		<label for="x_Currency_PAYPAL" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_Currency_PAYPAL"><%= BusinessDetails.Currency_PAYPAL.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_Currency_PAYPAL" id="z_Currency_PAYPAL" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.Currency_PAYPAL.CellAttributes %>>
			<span id="el_BusinessDetails_Currency_PAYPAL">
<input type="text" data-field="x_Currency_PAYPAL" name="x_Currency_PAYPAL" id="x_Currency_PAYPAL" size="30" maxlength="255" placeholder="<%= BusinessDetails.Currency_PAYPAL.PlaceHolder %>" value="<%= BusinessDetails.Currency_PAYPAL.EditValue %>"<%= BusinessDetails.Currency_PAYPAL.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.Currency_STRIPE.Visible Then ' Currency_STRIPE %>
	<div id="r_Currency_STRIPE" class="form-group">
		<label for="x_Currency_STRIPE" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_Currency_STRIPE"><%= BusinessDetails.Currency_STRIPE.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_Currency_STRIPE" id="z_Currency_STRIPE" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.Currency_STRIPE.CellAttributes %>>
			<span id="el_BusinessDetails_Currency_STRIPE">
<input type="text" data-field="x_Currency_STRIPE" name="x_Currency_STRIPE" id="x_Currency_STRIPE" size="30" maxlength="255" placeholder="<%= BusinessDetails.Currency_STRIPE.PlaceHolder %>" value="<%= BusinessDetails.Currency_STRIPE.EditValue %>"<%= BusinessDetails.Currency_STRIPE.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.Currency_WOLRDPAY.Visible Then ' Currency_WOLRDPAY %>
	<div id="r_Currency_WOLRDPAY" class="form-group">
		<label for="x_Currency_WOLRDPAY" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_Currency_WOLRDPAY"><%= BusinessDetails.Currency_WOLRDPAY.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_Currency_WOLRDPAY" id="z_Currency_WOLRDPAY" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.Currency_WOLRDPAY.CellAttributes %>>
			<span id="el_BusinessDetails_Currency_WOLRDPAY">
<input type="text" data-field="x_Currency_WOLRDPAY" name="x_Currency_WOLRDPAY" id="x_Currency_WOLRDPAY" size="30" maxlength="255" placeholder="<%= BusinessDetails.Currency_WOLRDPAY.PlaceHolder %>" value="<%= BusinessDetails.Currency_WOLRDPAY.EditValue %>"<%= BusinessDetails.Currency_WOLRDPAY.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.Tip_percent.Visible Then ' Tip_percent %>
	<div id="r_Tip_percent" class="form-group">
		<label for="x_Tip_percent" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_Tip_percent"><%= BusinessDetails.Tip_percent.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_Tip_percent" id="z_Tip_percent" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.Tip_percent.CellAttributes %>>
			<span id="el_BusinessDetails_Tip_percent">
<input type="text" data-field="x_Tip_percent" name="x_Tip_percent" id="x_Tip_percent" size="30" placeholder="<%= BusinessDetails.Tip_percent.PlaceHolder %>" value="<%= BusinessDetails.Tip_percent.EditValue %>"<%= BusinessDetails.Tip_percent.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.Tax_Percent.Visible Then ' Tax_Percent %>
	<div id="r_Tax_Percent" class="form-group">
		<label for="x_Tax_Percent" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_Tax_Percent"><%= BusinessDetails.Tax_Percent.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_Tax_Percent" id="z_Tax_Percent" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.Tax_Percent.CellAttributes %>>
			<span id="el_BusinessDetails_Tax_Percent">
<input type="text" data-field="x_Tax_Percent" name="x_Tax_Percent" id="x_Tax_Percent" size="30" placeholder="<%= BusinessDetails.Tax_Percent.PlaceHolder %>" value="<%= BusinessDetails.Tax_Percent.EditValue %>"<%= BusinessDetails.Tax_Percent.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.InRestaurantTaxChargeOnly.Visible Then ' InRestaurantTaxChargeOnly %>
	<div id="r_InRestaurantTaxChargeOnly" class="form-group">
		<label for="x_InRestaurantTaxChargeOnly" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_InRestaurantTaxChargeOnly"><%= BusinessDetails.InRestaurantTaxChargeOnly.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_InRestaurantTaxChargeOnly" id="z_InRestaurantTaxChargeOnly" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.InRestaurantTaxChargeOnly.CellAttributes %>>
			<span id="el_BusinessDetails_InRestaurantTaxChargeOnly">
<input type="text" data-field="x_InRestaurantTaxChargeOnly" name="x_InRestaurantTaxChargeOnly" id="x_InRestaurantTaxChargeOnly" size="30" placeholder="<%= BusinessDetails.InRestaurantTaxChargeOnly.PlaceHolder %>" value="<%= BusinessDetails.InRestaurantTaxChargeOnly.EditValue %>"<%= BusinessDetails.InRestaurantTaxChargeOnly.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.InRestaurantTipChargeOnly.Visible Then ' InRestaurantTipChargeOnly %>
	<div id="r_InRestaurantTipChargeOnly" class="form-group">
		<label for="x_InRestaurantTipChargeOnly" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_InRestaurantTipChargeOnly"><%= BusinessDetails.InRestaurantTipChargeOnly.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_InRestaurantTipChargeOnly" id="z_InRestaurantTipChargeOnly" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.InRestaurantTipChargeOnly.CellAttributes %>>
			<span id="el_BusinessDetails_InRestaurantTipChargeOnly">
<input type="text" data-field="x_InRestaurantTipChargeOnly" name="x_InRestaurantTipChargeOnly" id="x_InRestaurantTipChargeOnly" size="30" placeholder="<%= BusinessDetails.InRestaurantTipChargeOnly.PlaceHolder %>" value="<%= BusinessDetails.InRestaurantTipChargeOnly.EditValue %>"<%= BusinessDetails.InRestaurantTipChargeOnly.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.isCheckCapcha.Visible Then ' isCheckCapcha %>
	<div id="r_isCheckCapcha" class="form-group">
		<label for="x_isCheckCapcha" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_isCheckCapcha"><%= BusinessDetails.isCheckCapcha.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_isCheckCapcha" id="z_isCheckCapcha" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.isCheckCapcha.CellAttributes %>>
			<span id="el_BusinessDetails_isCheckCapcha">
<input type="text" data-field="x_isCheckCapcha" name="x_isCheckCapcha" id="x_isCheckCapcha" size="30" maxlength="255" placeholder="<%= BusinessDetails.isCheckCapcha.PlaceHolder %>" value="<%= BusinessDetails.isCheckCapcha.EditValue %>"<%= BusinessDetails.isCheckCapcha.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.Close_StartDate.Visible Then ' Close_StartDate %>
	<div id="r_Close_StartDate" class="form-group">
		<label for="x_Close_StartDate" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_Close_StartDate"><%= BusinessDetails.Close_StartDate.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_Close_StartDate" id="z_Close_StartDate" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.Close_StartDate.CellAttributes %>>
			<span id="el_BusinessDetails_Close_StartDate">
<input type="text" data-field="x_Close_StartDate" name="x_Close_StartDate" id="x_Close_StartDate" size="30" maxlength="255" placeholder="<%= BusinessDetails.Close_StartDate.PlaceHolder %>" value="<%= BusinessDetails.Close_StartDate.EditValue %>"<%= BusinessDetails.Close_StartDate.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.Close_EndDate.Visible Then ' Close_EndDate %>
	<div id="r_Close_EndDate" class="form-group">
		<label for="x_Close_EndDate" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_Close_EndDate"><%= BusinessDetails.Close_EndDate.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_Close_EndDate" id="z_Close_EndDate" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.Close_EndDate.CellAttributes %>>
			<span id="el_BusinessDetails_Close_EndDate">
<input type="text" data-field="x_Close_EndDate" name="x_Close_EndDate" id="x_Close_EndDate" size="30" maxlength="255" placeholder="<%= BusinessDetails.Close_EndDate.PlaceHolder %>" value="<%= BusinessDetails.Close_EndDate.EditValue %>"<%= BusinessDetails.Close_EndDate.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.Stripe_Country.Visible Then ' Stripe_Country %>
	<div id="r_Stripe_Country" class="form-group">
		<label for="x_Stripe_Country" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_Stripe_Country"><%= BusinessDetails.Stripe_Country.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_Stripe_Country" id="z_Stripe_Country" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.Stripe_Country.CellAttributes %>>
			<span id="el_BusinessDetails_Stripe_Country">
<input type="text" data-field="x_Stripe_Country" name="x_Stripe_Country" id="x_Stripe_Country" size="30" maxlength="255" placeholder="<%= BusinessDetails.Stripe_Country.PlaceHolder %>" value="<%= BusinessDetails.Stripe_Country.EditValue %>"<%= BusinessDetails.Stripe_Country.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.enable_StripePaymentButton.Visible Then ' enable_StripePaymentButton %>
	<div id="r_enable_StripePaymentButton" class="form-group">
		<label for="x_enable_StripePaymentButton" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_enable_StripePaymentButton"><%= BusinessDetails.enable_StripePaymentButton.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_enable_StripePaymentButton" id="z_enable_StripePaymentButton" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.enable_StripePaymentButton.CellAttributes %>>
			<span id="el_BusinessDetails_enable_StripePaymentButton">
<input type="text" data-field="x_enable_StripePaymentButton" name="x_enable_StripePaymentButton" id="x_enable_StripePaymentButton" size="30" maxlength="255" placeholder="<%= BusinessDetails.enable_StripePaymentButton.PlaceHolder %>" value="<%= BusinessDetails.enable_StripePaymentButton.EditValue %>"<%= BusinessDetails.enable_StripePaymentButton.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.enable_CashPayment.Visible Then ' enable_CashPayment %>
	<div id="r_enable_CashPayment" class="form-group">
		<label for="x_enable_CashPayment" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_enable_CashPayment"><%= BusinessDetails.enable_CashPayment.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_enable_CashPayment" id="z_enable_CashPayment" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.enable_CashPayment.CellAttributes %>>
			<span id="el_BusinessDetails_enable_CashPayment">
<input type="text" data-field="x_enable_CashPayment" name="x_enable_CashPayment" id="x_enable_CashPayment" size="30" maxlength="255" placeholder="<%= BusinessDetails.enable_CashPayment.PlaceHolder %>" value="<%= BusinessDetails.enable_CashPayment.EditValue %>"<%= BusinessDetails.enable_CashPayment.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.DeliveryMile.Visible Then ' DeliveryMile %>
	<div id="r_DeliveryMile" class="form-group">
		<label for="x_DeliveryMile" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_DeliveryMile"><%= BusinessDetails.DeliveryMile.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_DeliveryMile" id="z_DeliveryMile" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.DeliveryMile.CellAttributes %>>
			<span id="el_BusinessDetails_DeliveryMile">
<input type="text" data-field="x_DeliveryMile" name="x_DeliveryMile" id="x_DeliveryMile" size="30" placeholder="<%= BusinessDetails.DeliveryMile.PlaceHolder %>" value="<%= BusinessDetails.DeliveryMile.EditValue %>"<%= BusinessDetails.DeliveryMile.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.Mon_Delivery.Visible Then ' Mon_Delivery %>
	<div id="r_Mon_Delivery" class="form-group">
		<label for="x_Mon_Delivery" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_Mon_Delivery"><%= BusinessDetails.Mon_Delivery.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_Mon_Delivery" id="z_Mon_Delivery" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.Mon_Delivery.CellAttributes %>>
			<span id="el_BusinessDetails_Mon_Delivery">
<input type="text" data-field="x_Mon_Delivery" name="x_Mon_Delivery" id="x_Mon_Delivery" size="30" placeholder="<%= BusinessDetails.Mon_Delivery.PlaceHolder %>" value="<%= BusinessDetails.Mon_Delivery.EditValue %>"<%= BusinessDetails.Mon_Delivery.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.Mon_Collection.Visible Then ' Mon_Collection %>
	<div id="r_Mon_Collection" class="form-group">
		<label for="x_Mon_Collection" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_Mon_Collection"><%= BusinessDetails.Mon_Collection.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_Mon_Collection" id="z_Mon_Collection" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.Mon_Collection.CellAttributes %>>
			<span id="el_BusinessDetails_Mon_Collection">
<input type="text" data-field="x_Mon_Collection" name="x_Mon_Collection" id="x_Mon_Collection" size="30" placeholder="<%= BusinessDetails.Mon_Collection.PlaceHolder %>" value="<%= BusinessDetails.Mon_Collection.EditValue %>"<%= BusinessDetails.Mon_Collection.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.Tue_Delivery.Visible Then ' Tue_Delivery %>
	<div id="r_Tue_Delivery" class="form-group">
		<label for="x_Tue_Delivery" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_Tue_Delivery"><%= BusinessDetails.Tue_Delivery.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_Tue_Delivery" id="z_Tue_Delivery" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.Tue_Delivery.CellAttributes %>>
			<span id="el_BusinessDetails_Tue_Delivery">
<input type="text" data-field="x_Tue_Delivery" name="x_Tue_Delivery" id="x_Tue_Delivery" size="30" placeholder="<%= BusinessDetails.Tue_Delivery.PlaceHolder %>" value="<%= BusinessDetails.Tue_Delivery.EditValue %>"<%= BusinessDetails.Tue_Delivery.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.Tue_Collection.Visible Then ' Tue_Collection %>
	<div id="r_Tue_Collection" class="form-group">
		<label for="x_Tue_Collection" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_Tue_Collection"><%= BusinessDetails.Tue_Collection.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_Tue_Collection" id="z_Tue_Collection" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.Tue_Collection.CellAttributes %>>
			<span id="el_BusinessDetails_Tue_Collection">
<input type="text" data-field="x_Tue_Collection" name="x_Tue_Collection" id="x_Tue_Collection" size="30" placeholder="<%= BusinessDetails.Tue_Collection.PlaceHolder %>" value="<%= BusinessDetails.Tue_Collection.EditValue %>"<%= BusinessDetails.Tue_Collection.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.Wed_Delivery.Visible Then ' Wed_Delivery %>
	<div id="r_Wed_Delivery" class="form-group">
		<label for="x_Wed_Delivery" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_Wed_Delivery"><%= BusinessDetails.Wed_Delivery.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_Wed_Delivery" id="z_Wed_Delivery" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.Wed_Delivery.CellAttributes %>>
			<span id="el_BusinessDetails_Wed_Delivery">
<input type="text" data-field="x_Wed_Delivery" name="x_Wed_Delivery" id="x_Wed_Delivery" size="30" placeholder="<%= BusinessDetails.Wed_Delivery.PlaceHolder %>" value="<%= BusinessDetails.Wed_Delivery.EditValue %>"<%= BusinessDetails.Wed_Delivery.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.Wed_Collection.Visible Then ' Wed_Collection %>
	<div id="r_Wed_Collection" class="form-group">
		<label for="x_Wed_Collection" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_Wed_Collection"><%= BusinessDetails.Wed_Collection.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_Wed_Collection" id="z_Wed_Collection" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.Wed_Collection.CellAttributes %>>
			<span id="el_BusinessDetails_Wed_Collection">
<input type="text" data-field="x_Wed_Collection" name="x_Wed_Collection" id="x_Wed_Collection" size="30" placeholder="<%= BusinessDetails.Wed_Collection.PlaceHolder %>" value="<%= BusinessDetails.Wed_Collection.EditValue %>"<%= BusinessDetails.Wed_Collection.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.Thu_Delivery.Visible Then ' Thu_Delivery %>
	<div id="r_Thu_Delivery" class="form-group">
		<label for="x_Thu_Delivery" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_Thu_Delivery"><%= BusinessDetails.Thu_Delivery.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_Thu_Delivery" id="z_Thu_Delivery" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.Thu_Delivery.CellAttributes %>>
			<span id="el_BusinessDetails_Thu_Delivery">
<input type="text" data-field="x_Thu_Delivery" name="x_Thu_Delivery" id="x_Thu_Delivery" size="30" placeholder="<%= BusinessDetails.Thu_Delivery.PlaceHolder %>" value="<%= BusinessDetails.Thu_Delivery.EditValue %>"<%= BusinessDetails.Thu_Delivery.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.Thu_Collection.Visible Then ' Thu_Collection %>
	<div id="r_Thu_Collection" class="form-group">
		<label for="x_Thu_Collection" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_Thu_Collection"><%= BusinessDetails.Thu_Collection.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_Thu_Collection" id="z_Thu_Collection" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.Thu_Collection.CellAttributes %>>
			<span id="el_BusinessDetails_Thu_Collection">
<input type="text" data-field="x_Thu_Collection" name="x_Thu_Collection" id="x_Thu_Collection" size="30" placeholder="<%= BusinessDetails.Thu_Collection.PlaceHolder %>" value="<%= BusinessDetails.Thu_Collection.EditValue %>"<%= BusinessDetails.Thu_Collection.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.Fri_Delivery.Visible Then ' Fri_Delivery %>
	<div id="r_Fri_Delivery" class="form-group">
		<label for="x_Fri_Delivery" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_Fri_Delivery"><%= BusinessDetails.Fri_Delivery.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_Fri_Delivery" id="z_Fri_Delivery" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.Fri_Delivery.CellAttributes %>>
			<span id="el_BusinessDetails_Fri_Delivery">
<input type="text" data-field="x_Fri_Delivery" name="x_Fri_Delivery" id="x_Fri_Delivery" size="30" placeholder="<%= BusinessDetails.Fri_Delivery.PlaceHolder %>" value="<%= BusinessDetails.Fri_Delivery.EditValue %>"<%= BusinessDetails.Fri_Delivery.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.Fri_Collection.Visible Then ' Fri_Collection %>
	<div id="r_Fri_Collection" class="form-group">
		<label for="x_Fri_Collection" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_Fri_Collection"><%= BusinessDetails.Fri_Collection.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_Fri_Collection" id="z_Fri_Collection" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.Fri_Collection.CellAttributes %>>
			<span id="el_BusinessDetails_Fri_Collection">
<input type="text" data-field="x_Fri_Collection" name="x_Fri_Collection" id="x_Fri_Collection" size="30" placeholder="<%= BusinessDetails.Fri_Collection.PlaceHolder %>" value="<%= BusinessDetails.Fri_Collection.EditValue %>"<%= BusinessDetails.Fri_Collection.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.Sat_Delivery.Visible Then ' Sat_Delivery %>
	<div id="r_Sat_Delivery" class="form-group">
		<label for="x_Sat_Delivery" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_Sat_Delivery"><%= BusinessDetails.Sat_Delivery.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_Sat_Delivery" id="z_Sat_Delivery" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.Sat_Delivery.CellAttributes %>>
			<span id="el_BusinessDetails_Sat_Delivery">
<input type="text" data-field="x_Sat_Delivery" name="x_Sat_Delivery" id="x_Sat_Delivery" size="30" placeholder="<%= BusinessDetails.Sat_Delivery.PlaceHolder %>" value="<%= BusinessDetails.Sat_Delivery.EditValue %>"<%= BusinessDetails.Sat_Delivery.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.Sat_Collection.Visible Then ' Sat_Collection %>
	<div id="r_Sat_Collection" class="form-group">
		<label for="x_Sat_Collection" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_Sat_Collection"><%= BusinessDetails.Sat_Collection.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_Sat_Collection" id="z_Sat_Collection" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.Sat_Collection.CellAttributes %>>
			<span id="el_BusinessDetails_Sat_Collection">
<input type="text" data-field="x_Sat_Collection" name="x_Sat_Collection" id="x_Sat_Collection" size="30" placeholder="<%= BusinessDetails.Sat_Collection.PlaceHolder %>" value="<%= BusinessDetails.Sat_Collection.EditValue %>"<%= BusinessDetails.Sat_Collection.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.Sun_Delivery.Visible Then ' Sun_Delivery %>
	<div id="r_Sun_Delivery" class="form-group">
		<label for="x_Sun_Delivery" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_Sun_Delivery"><%= BusinessDetails.Sun_Delivery.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_Sun_Delivery" id="z_Sun_Delivery" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.Sun_Delivery.CellAttributes %>>
			<span id="el_BusinessDetails_Sun_Delivery">
<input type="text" data-field="x_Sun_Delivery" name="x_Sun_Delivery" id="x_Sun_Delivery" size="30" placeholder="<%= BusinessDetails.Sun_Delivery.PlaceHolder %>" value="<%= BusinessDetails.Sun_Delivery.EditValue %>"<%= BusinessDetails.Sun_Delivery.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.Sun_Collection.Visible Then ' Sun_Collection %>
	<div id="r_Sun_Collection" class="form-group">
		<label for="x_Sun_Collection" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_Sun_Collection"><%= BusinessDetails.Sun_Collection.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_Sun_Collection" id="z_Sun_Collection" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.Sun_Collection.CellAttributes %>>
			<span id="el_BusinessDetails_Sun_Collection">
<input type="text" data-field="x_Sun_Collection" name="x_Sun_Collection" id="x_Sun_Collection" size="30" placeholder="<%= BusinessDetails.Sun_Collection.PlaceHolder %>" value="<%= BusinessDetails.Sun_Collection.EditValue %>"<%= BusinessDetails.Sun_Collection.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.EnableUrlRewrite.Visible Then ' EnableUrlRewrite %>
	<div id="r_EnableUrlRewrite" class="form-group">
		<label for="x_EnableUrlRewrite" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_EnableUrlRewrite"><%= BusinessDetails.EnableUrlRewrite.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_EnableUrlRewrite" id="z_EnableUrlRewrite" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.EnableUrlRewrite.CellAttributes %>>
			<span id="el_BusinessDetails_EnableUrlRewrite">
<input type="text" data-field="x_EnableUrlRewrite" name="x_EnableUrlRewrite" id="x_EnableUrlRewrite" size="30" maxlength="255" placeholder="<%= BusinessDetails.EnableUrlRewrite.PlaceHolder %>" value="<%= BusinessDetails.EnableUrlRewrite.EditValue %>"<%= BusinessDetails.EnableUrlRewrite.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.DeliveryCostUpTo.Visible Then ' DeliveryCostUpTo %>
	<div id="r_DeliveryCostUpTo" class="form-group">
		<label for="x_DeliveryCostUpTo" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_DeliveryCostUpTo"><%= BusinessDetails.DeliveryCostUpTo.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_DeliveryCostUpTo" id="z_DeliveryCostUpTo" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.DeliveryCostUpTo.CellAttributes %>>
			<span id="el_BusinessDetails_DeliveryCostUpTo">
<input type="text" data-field="x_DeliveryCostUpTo" name="x_DeliveryCostUpTo" id="x_DeliveryCostUpTo" size="30" placeholder="<%= BusinessDetails.DeliveryCostUpTo.PlaceHolder %>" value="<%= BusinessDetails.DeliveryCostUpTo.EditValue %>"<%= BusinessDetails.DeliveryCostUpTo.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.DeliveryUptoMile.Visible Then ' DeliveryUptoMile %>
	<div id="r_DeliveryUptoMile" class="form-group">
		<label for="x_DeliveryUptoMile" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_DeliveryUptoMile"><%= BusinessDetails.DeliveryUptoMile.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("=") %><input type="hidden" name="z_DeliveryUptoMile" id="z_DeliveryUptoMile" value="="></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.DeliveryUptoMile.CellAttributes %>>
			<span id="el_BusinessDetails_DeliveryUptoMile">
<input type="text" data-field="x_DeliveryUptoMile" name="x_DeliveryUptoMile" id="x_DeliveryUptoMile" size="30" placeholder="<%= BusinessDetails.DeliveryUptoMile.PlaceHolder %>" value="<%= BusinessDetails.DeliveryUptoMile.EditValue %>"<%= BusinessDetails.DeliveryUptoMile.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.Show_Ordernumner_printer.Visible Then ' Show_Ordernumner_printer %>
	<div id="r_Show_Ordernumner_printer" class="form-group">
		<label for="x_Show_Ordernumner_printer" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_Show_Ordernumner_printer"><%= BusinessDetails.Show_Ordernumner_printer.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_Show_Ordernumner_printer" id="z_Show_Ordernumner_printer" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.Show_Ordernumner_printer.CellAttributes %>>
			<span id="el_BusinessDetails_Show_Ordernumner_printer">
<input type="text" data-field="x_Show_Ordernumner_printer" name="x_Show_Ordernumner_printer" id="x_Show_Ordernumner_printer" size="30" maxlength="255" placeholder="<%= BusinessDetails.Show_Ordernumner_printer.PlaceHolder %>" value="<%= BusinessDetails.Show_Ordernumner_printer.EditValue %>"<%= BusinessDetails.Show_Ordernumner_printer.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.Show_Ordernumner_Receipt.Visible Then ' Show_Ordernumner_Receipt %>
	<div id="r_Show_Ordernumner_Receipt" class="form-group">
		<label for="x_Show_Ordernumner_Receipt" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_Show_Ordernumner_Receipt"><%= BusinessDetails.Show_Ordernumner_Receipt.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_Show_Ordernumner_Receipt" id="z_Show_Ordernumner_Receipt" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.Show_Ordernumner_Receipt.CellAttributes %>>
			<span id="el_BusinessDetails_Show_Ordernumner_Receipt">
<input type="text" data-field="x_Show_Ordernumner_Receipt" name="x_Show_Ordernumner_Receipt" id="x_Show_Ordernumner_Receipt" size="30" maxlength="255" placeholder="<%= BusinessDetails.Show_Ordernumner_Receipt.PlaceHolder %>" value="<%= BusinessDetails.Show_Ordernumner_Receipt.EditValue %>"<%= BusinessDetails.Show_Ordernumner_Receipt.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
<% If BusinessDetails.Show_Ordernumner_Dashboard.Visible Then ' Show_Ordernumner_Dashboard %>
	<div id="r_Show_Ordernumner_Dashboard" class="form-group">
		<label for="x_Show_Ordernumner_Dashboard" class="<%= BusinessDetails_search.SearchLabelClass %>"><span id="elh_BusinessDetails_Show_Ordernumner_Dashboard"><%= BusinessDetails.Show_Ordernumner_Dashboard.FldCaption %></span>	
		<p class="form-control-static ewSearchOperator"><%= Language.Phrase("LIKE") %><input type="hidden" name="z_Show_Ordernumner_Dashboard" id="z_Show_Ordernumner_Dashboard" value="LIKE"></p>
		</label>
		<div class="<%= BusinessDetails_search.SearchRightColumnClass %>"><div<%= BusinessDetails.Show_Ordernumner_Dashboard.CellAttributes %>>
			<span id="el_BusinessDetails_Show_Ordernumner_Dashboard">
<input type="text" data-field="x_Show_Ordernumner_Dashboard" name="x_Show_Ordernumner_Dashboard" id="x_Show_Ordernumner_Dashboard" size="30" maxlength="255" placeholder="<%= BusinessDetails.Show_Ordernumner_Dashboard.PlaceHolder %>" value="<%= BusinessDetails.Show_Ordernumner_Dashboard.EditValue %>"<%= BusinessDetails.Show_Ordernumner_Dashboard.EditAttributes %>>
</span>
		</div></div>
	</div>
<% End If %>
</div>
<% If Not BusinessDetails_search.IsModal Then %>
<div class="form-group">
	<div class="col-sm-offset-3 col-sm-9">
<button class="btn btn-primary ewButton" name="btnAction" id="btnAction" type="submit"><%= Language.Phrase("Search") %></button>
<button class="btn btn-default ewButton" name="btnReset" id="btnReset" type="button" onclick="ew_ClearForm(this.form);"><%= Language.Phrase("Reset") %></button>
	</div>
</div>
<% End If %>
</form>
<script type="text/javascript">
fBusinessDetailssearch.Init();
</script>
<%
BusinessDetails_search.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set BusinessDetails_search = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cBusinessDetails_search

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
		TableName = "BusinessDetails"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "BusinessDetails_search"
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
		EW_PAGE_ID = "search"

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
		BusinessDetails.ID.Visible = Not BusinessDetails.IsAdd() And Not BusinessDetails.IsCopy() And Not BusinessDetails.IsGridAdd()

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
			BusinessDetails.CurrentAction = ObjForm.GetValue("a_search")
			Select Case BusinessDetails.CurrentAction
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
						sSrchStr = BusinessDetails.UrlParm(sSrchStr)
						sSrchStr = "BusinessDetailslist.asp" & "?" & sSrchStr
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
		BusinessDetails.RowType = EW_ROWTYPE_SEARCH
		Call RenderRow()
	End Sub

	' -----------------------------------------------------------------
	' Build advanced search
	'
	Function BuildAdvancedSearch()
		Dim sSrchUrl
		sSrchUrl = ""
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.ID, False) ' ID
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.Name, False) ' Name
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.Address, False) ' Address
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.PostalCode, False) ' PostalCode
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.FoodType, False) ' FoodType
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.DeliveryMinAmount, False) ' DeliveryMinAmount
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.DeliveryMaxDistance, False) ' DeliveryMaxDistance
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.DeliveryFreeDistance, False) ' DeliveryFreeDistance
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.AverageDeliveryTime, False) ' AverageDeliveryTime
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.AverageCollectionTime, False) ' AverageCollectionTime
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.DeliveryFee, False) ' DeliveryFee
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.ImgUrl, False) ' ImgUrl
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.Telephone, False) ' Telephone
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.zEmail, False) ' Email
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.pswd, False) ' pswd
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.businessclosed, False) ' businessclosed
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.announcement, False) ' announcement
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.css, False) ' css
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.SMTP_AUTENTICATE, False) ' SMTP_AUTENTICATE
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.MAIL_FROM, False) ' MAIL_FROM
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.PAYPAL_URL, False) ' PAYPAL_URL
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.PAYPAL_PDT, False) ' PAYPAL_PDT
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.SMTP_PASSWORD, False) ' SMTP_PASSWORD
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.GMAP_API_KEY, False) ' GMAP_API_KEY
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.SMTP_USERNAME, False) ' SMTP_USERNAME
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.SMTP_USESSL, False) ' SMTP_USESSL
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.MAIL_SUBJECT, False) ' MAIL_SUBJECT
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.CURRENCYSYMBOL, False) ' CURRENCYSYMBOL
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.SMTP_SERVER, False) ' SMTP_SERVER
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.CREDITCARDSURCHARGE, False) ' CREDITCARDSURCHARGE
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.SMTP_PORT, False) ' SMTP_PORT
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.STICK_MENU, False) ' STICK_MENU
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.MAIL_CUSTOMER_SUBJECT, False) ' MAIL_CUSTOMER_SUBJECT
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.CONFIRMATION_EMAIL_ADDRESS, False) ' CONFIRMATION_EMAIL_ADDRESS
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.SEND_ORDERS_TO_PRINTER, False) ' SEND_ORDERS_TO_PRINTER
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.timezone, False) ' timezone
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.PAYPAL_ADDR, False) ' PAYPAL_ADDR
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.nochex, False) ' nochex
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.nochexmerchantid, False) ' nochexmerchantid
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.paypal, False) ' paypal
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.IBT_API_KEY, False) ' IBT_API_KEY
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.IBP_API_PASSWORD, False) ' IBP_API_PASSWORD
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.disable_delivery, False) ' disable_delivery
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.disable_collection, False) ' disable_collection
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.worldpay, False) ' worldpay
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.worldpaymerchantid, False) ' worldpaymerchantid
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.backtohometext, False) ' backtohometext
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.closedtext, False) ' closedtext
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.DeliveryChargeOverrideByOrderValue, False) ' DeliveryChargeOverrideByOrderValue
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.individualpostcodes, False) ' individualpostcodes
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.individualpostcodeschecking, False) ' individualpostcodeschecking
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.longitude, False) ' longitude
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.latitude, False) ' latitude
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.googleecommercetracking, False) ' googleecommercetracking
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.googleecommercetrackingcode, False) ' googleecommercetrackingcode
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.bringg, False) ' bringg
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.bringgurl, False) ' bringgurl
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.bringgcompanyid, False) ' bringgcompanyid
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.orderonlywhenopen, False) ' orderonlywhenopen
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.disablelaterdelivery, False) ' disablelaterdelivery
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.menupagetext, False) ' menupagetext
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.ordertodayonly, False) ' ordertodayonly
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.mileskm, False) ' mileskm
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.worldpaylive, False) ' worldpaylive
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.worldpayinstallationid, False) ' worldpayinstallationid
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.DistanceCalMethod, False) ' DistanceCalMethod
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.PrinterIDList, False) ' PrinterIDList
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.EpsonJSPrinterURL, False) ' EpsonJSPrinterURL
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.SMSEnable, False) ' SMSEnable
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.SMSOnDelivery, False) ' SMSOnDelivery
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.SMSSupplierDomain, False) ' SMSSupplierDomain
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.SMSOnOrder, False) ' SMSOnOrder
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.SMSOnOrderAfterMin, False) ' SMSOnOrderAfterMin
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.SMSOnOrderContent, False) ' SMSOnOrderContent
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.DefaultSMSCountryCode, False) ' DefaultSMSCountryCode
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.MinimumAmountForCardPayment, False) ' MinimumAmountForCardPayment
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.FavIconUrl, False) ' FavIconUrl
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.AddToHomeScreenURL, False) ' AddToHomeScreenURL
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.SMSOnAcknowledgement, False) ' SMSOnAcknowledgement
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.LocalPrinterURL, False) ' LocalPrinterURL
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.ShowRestaurantDetailOnReceipt, False) ' ShowRestaurantDetailOnReceipt
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.PrinterFontSizeRatio, False) ' PrinterFontSizeRatio
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.ServiceChargePercentage, False) ' ServiceChargePercentage
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.InRestaurantServiceChargeOnly, False) ' InRestaurantServiceChargeOnly
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.IsDualReceiptPrinting, False) ' IsDualReceiptPrinting
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.PrintingFontSize, False) ' PrintingFontSize
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.InRestaurantEpsonPrinterIDList, False) ' InRestaurantEpsonPrinterIDList
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.BlockIPEmailList, False) ' BlockIPEmailList
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.inmenuannouncement, False) ' inmenuannouncement
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.RePrintReceiptWays, False) ' RePrintReceiptWays
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.printingtype, False) ' printingtype
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.Stripe_Key_Secret, False) ' Stripe_Key_Secret
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.Stripe, False) ' Stripe
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.Stripe_Api_Key, False) ' Stripe_Api_Key
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.EnableBooking, False) ' EnableBooking
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.URL_Facebook, False) ' URL_Facebook
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.URL_Twitter, False) ' URL_Twitter
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.URL_Google, False) ' URL_Google
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.URL_Intagram, False) ' URL_Intagram
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.URL_YouTube, False) ' URL_YouTube
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.URL_Tripadvisor, False) ' URL_Tripadvisor
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.URL_Special_Offer, False) ' URL_Special_Offer
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.URL_Linkin, False) ' URL_Linkin
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.Currency_PAYPAL, False) ' Currency_PAYPAL
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.Currency_STRIPE, False) ' Currency_STRIPE
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.Currency_WOLRDPAY, False) ' Currency_WOLRDPAY
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.Tip_percent, False) ' Tip_percent
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.Tax_Percent, False) ' Tax_Percent
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.InRestaurantTaxChargeOnly, False) ' InRestaurantTaxChargeOnly
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.InRestaurantTipChargeOnly, False) ' InRestaurantTipChargeOnly
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.isCheckCapcha, False) ' isCheckCapcha
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.Close_StartDate, False) ' Close_StartDate
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.Close_EndDate, False) ' Close_EndDate
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.Stripe_Country, False) ' Stripe_Country
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.enable_StripePaymentButton, False) ' enable_StripePaymentButton
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.enable_CashPayment, False) ' enable_CashPayment
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.DeliveryMile, False) ' DeliveryMile
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.Mon_Delivery, False) ' Mon_Delivery
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.Mon_Collection, False) ' Mon_Collection
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.Tue_Delivery, False) ' Tue_Delivery
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.Tue_Collection, False) ' Tue_Collection
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.Wed_Delivery, False) ' Wed_Delivery
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.Wed_Collection, False) ' Wed_Collection
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.Thu_Delivery, False) ' Thu_Delivery
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.Thu_Collection, False) ' Thu_Collection
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.Fri_Delivery, False) ' Fri_Delivery
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.Fri_Collection, False) ' Fri_Collection
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.Sat_Delivery, False) ' Sat_Delivery
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.Sat_Collection, False) ' Sat_Collection
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.Sun_Delivery, False) ' Sun_Delivery
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.Sun_Collection, False) ' Sun_Collection
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.EnableUrlRewrite, False) ' EnableUrlRewrite
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.DeliveryCostUpTo, False) ' DeliveryCostUpTo
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.DeliveryUptoMile, False) ' DeliveryUptoMile
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.Show_Ordernumner_printer, False) ' Show_Ordernumner_printer
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.Show_Ordernumner_Receipt, False) ' Show_Ordernumner_Receipt
		Call BuildSearchUrl(sSrchUrl, BusinessDetails.Show_Ordernumner_Dashboard, False) ' Show_Ordernumner_Dashboard
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
		BusinessDetails.ID.AdvancedSearch.SearchValue = ObjForm.GetValue("x_ID")
		BusinessDetails.ID.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_ID")
		BusinessDetails.Name.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Name")
		BusinessDetails.Name.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Name")
		BusinessDetails.Address.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Address")
		BusinessDetails.Address.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Address")
		BusinessDetails.PostalCode.AdvancedSearch.SearchValue = ObjForm.GetValue("x_PostalCode")
		BusinessDetails.PostalCode.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_PostalCode")
		BusinessDetails.FoodType.AdvancedSearch.SearchValue = ObjForm.GetValue("x_FoodType")
		BusinessDetails.FoodType.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_FoodType")
		BusinessDetails.DeliveryMinAmount.AdvancedSearch.SearchValue = ObjForm.GetValue("x_DeliveryMinAmount")
		BusinessDetails.DeliveryMinAmount.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_DeliveryMinAmount")
		BusinessDetails.DeliveryMaxDistance.AdvancedSearch.SearchValue = ObjForm.GetValue("x_DeliveryMaxDistance")
		BusinessDetails.DeliveryMaxDistance.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_DeliveryMaxDistance")
		BusinessDetails.DeliveryFreeDistance.AdvancedSearch.SearchValue = ObjForm.GetValue("x_DeliveryFreeDistance")
		BusinessDetails.DeliveryFreeDistance.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_DeliveryFreeDistance")
		BusinessDetails.AverageDeliveryTime.AdvancedSearch.SearchValue = ObjForm.GetValue("x_AverageDeliveryTime")
		BusinessDetails.AverageDeliveryTime.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_AverageDeliveryTime")
		BusinessDetails.AverageCollectionTime.AdvancedSearch.SearchValue = ObjForm.GetValue("x_AverageCollectionTime")
		BusinessDetails.AverageCollectionTime.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_AverageCollectionTime")
		BusinessDetails.DeliveryFee.AdvancedSearch.SearchValue = ObjForm.GetValue("x_DeliveryFee")
		BusinessDetails.DeliveryFee.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_DeliveryFee")
		BusinessDetails.ImgUrl.AdvancedSearch.SearchValue = ObjForm.GetValue("x_ImgUrl")
		BusinessDetails.ImgUrl.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_ImgUrl")
		BusinessDetails.Telephone.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Telephone")
		BusinessDetails.Telephone.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Telephone")
		BusinessDetails.zEmail.AdvancedSearch.SearchValue = ObjForm.GetValue("x_zEmail")
		BusinessDetails.zEmail.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_zEmail")
		BusinessDetails.pswd.AdvancedSearch.SearchValue = ObjForm.GetValue("x_pswd")
		BusinessDetails.pswd.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_pswd")
		BusinessDetails.businessclosed.AdvancedSearch.SearchValue = ObjForm.GetValue("x_businessclosed")
		BusinessDetails.businessclosed.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_businessclosed")
		BusinessDetails.announcement.AdvancedSearch.SearchValue = ObjForm.GetValue("x_announcement")
		BusinessDetails.announcement.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_announcement")
		BusinessDetails.css.AdvancedSearch.SearchValue = ObjForm.GetValue("x_css")
		BusinessDetails.css.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_css")
		BusinessDetails.SMTP_AUTENTICATE.AdvancedSearch.SearchValue = ObjForm.GetValue("x_SMTP_AUTENTICATE")
		BusinessDetails.SMTP_AUTENTICATE.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_SMTP_AUTENTICATE")
		BusinessDetails.MAIL_FROM.AdvancedSearch.SearchValue = ObjForm.GetValue("x_MAIL_FROM")
		BusinessDetails.MAIL_FROM.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_MAIL_FROM")
		BusinessDetails.PAYPAL_URL.AdvancedSearch.SearchValue = ObjForm.GetValue("x_PAYPAL_URL")
		BusinessDetails.PAYPAL_URL.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_PAYPAL_URL")
		BusinessDetails.PAYPAL_PDT.AdvancedSearch.SearchValue = ObjForm.GetValue("x_PAYPAL_PDT")
		BusinessDetails.PAYPAL_PDT.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_PAYPAL_PDT")
		BusinessDetails.SMTP_PASSWORD.AdvancedSearch.SearchValue = ObjForm.GetValue("x_SMTP_PASSWORD")
		BusinessDetails.SMTP_PASSWORD.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_SMTP_PASSWORD")
		BusinessDetails.GMAP_API_KEY.AdvancedSearch.SearchValue = ObjForm.GetValue("x_GMAP_API_KEY")
		BusinessDetails.GMAP_API_KEY.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_GMAP_API_KEY")
		BusinessDetails.SMTP_USERNAME.AdvancedSearch.SearchValue = ObjForm.GetValue("x_SMTP_USERNAME")
		BusinessDetails.SMTP_USERNAME.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_SMTP_USERNAME")
		BusinessDetails.SMTP_USESSL.AdvancedSearch.SearchValue = ObjForm.GetValue("x_SMTP_USESSL")
		BusinessDetails.SMTP_USESSL.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_SMTP_USESSL")
		BusinessDetails.MAIL_SUBJECT.AdvancedSearch.SearchValue = ObjForm.GetValue("x_MAIL_SUBJECT")
		BusinessDetails.MAIL_SUBJECT.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_MAIL_SUBJECT")
		BusinessDetails.CURRENCYSYMBOL.AdvancedSearch.SearchValue = ObjForm.GetValue("x_CURRENCYSYMBOL")
		BusinessDetails.CURRENCYSYMBOL.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_CURRENCYSYMBOL")
		BusinessDetails.SMTP_SERVER.AdvancedSearch.SearchValue = ObjForm.GetValue("x_SMTP_SERVER")
		BusinessDetails.SMTP_SERVER.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_SMTP_SERVER")
		BusinessDetails.CREDITCARDSURCHARGE.AdvancedSearch.SearchValue = ObjForm.GetValue("x_CREDITCARDSURCHARGE")
		BusinessDetails.CREDITCARDSURCHARGE.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_CREDITCARDSURCHARGE")
		BusinessDetails.SMTP_PORT.AdvancedSearch.SearchValue = ObjForm.GetValue("x_SMTP_PORT")
		BusinessDetails.SMTP_PORT.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_SMTP_PORT")
		BusinessDetails.STICK_MENU.AdvancedSearch.SearchValue = ObjForm.GetValue("x_STICK_MENU")
		BusinessDetails.STICK_MENU.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_STICK_MENU")
		BusinessDetails.MAIL_CUSTOMER_SUBJECT.AdvancedSearch.SearchValue = ObjForm.GetValue("x_MAIL_CUSTOMER_SUBJECT")
		BusinessDetails.MAIL_CUSTOMER_SUBJECT.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_MAIL_CUSTOMER_SUBJECT")
		BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.AdvancedSearch.SearchValue = ObjForm.GetValue("x_CONFIRMATION_EMAIL_ADDRESS")
		BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_CONFIRMATION_EMAIL_ADDRESS")
		BusinessDetails.SEND_ORDERS_TO_PRINTER.AdvancedSearch.SearchValue = ObjForm.GetValue("x_SEND_ORDERS_TO_PRINTER")
		BusinessDetails.SEND_ORDERS_TO_PRINTER.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_SEND_ORDERS_TO_PRINTER")
		BusinessDetails.timezone.AdvancedSearch.SearchValue = ObjForm.GetValue("x_timezone")
		BusinessDetails.timezone.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_timezone")
		BusinessDetails.PAYPAL_ADDR.AdvancedSearch.SearchValue = ObjForm.GetValue("x_PAYPAL_ADDR")
		BusinessDetails.PAYPAL_ADDR.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_PAYPAL_ADDR")
		BusinessDetails.nochex.AdvancedSearch.SearchValue = ObjForm.GetValue("x_nochex")
		BusinessDetails.nochex.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_nochex")
		BusinessDetails.nochexmerchantid.AdvancedSearch.SearchValue = ObjForm.GetValue("x_nochexmerchantid")
		BusinessDetails.nochexmerchantid.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_nochexmerchantid")
		BusinessDetails.paypal.AdvancedSearch.SearchValue = ObjForm.GetValue("x_paypal")
		BusinessDetails.paypal.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_paypal")
		BusinessDetails.IBT_API_KEY.AdvancedSearch.SearchValue = ObjForm.GetValue("x_IBT_API_KEY")
		BusinessDetails.IBT_API_KEY.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_IBT_API_KEY")
		BusinessDetails.IBP_API_PASSWORD.AdvancedSearch.SearchValue = ObjForm.GetValue("x_IBP_API_PASSWORD")
		BusinessDetails.IBP_API_PASSWORD.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_IBP_API_PASSWORD")
		BusinessDetails.disable_delivery.AdvancedSearch.SearchValue = ObjForm.GetValue("x_disable_delivery")
		BusinessDetails.disable_delivery.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_disable_delivery")
		BusinessDetails.disable_collection.AdvancedSearch.SearchValue = ObjForm.GetValue("x_disable_collection")
		BusinessDetails.disable_collection.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_disable_collection")
		BusinessDetails.worldpay.AdvancedSearch.SearchValue = ObjForm.GetValue("x_worldpay")
		BusinessDetails.worldpay.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_worldpay")
		BusinessDetails.worldpaymerchantid.AdvancedSearch.SearchValue = ObjForm.GetValue("x_worldpaymerchantid")
		BusinessDetails.worldpaymerchantid.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_worldpaymerchantid")
		BusinessDetails.backtohometext.AdvancedSearch.SearchValue = ObjForm.GetValue("x_backtohometext")
		BusinessDetails.backtohometext.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_backtohometext")
		BusinessDetails.closedtext.AdvancedSearch.SearchValue = ObjForm.GetValue("x_closedtext")
		BusinessDetails.closedtext.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_closedtext")
		BusinessDetails.DeliveryChargeOverrideByOrderValue.AdvancedSearch.SearchValue = ObjForm.GetValue("x_DeliveryChargeOverrideByOrderValue")
		BusinessDetails.DeliveryChargeOverrideByOrderValue.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_DeliveryChargeOverrideByOrderValue")
		BusinessDetails.individualpostcodes.AdvancedSearch.SearchValue = ObjForm.GetValue("x_individualpostcodes")
		BusinessDetails.individualpostcodes.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_individualpostcodes")
		BusinessDetails.individualpostcodeschecking.AdvancedSearch.SearchValue = ObjForm.GetValue("x_individualpostcodeschecking")
		BusinessDetails.individualpostcodeschecking.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_individualpostcodeschecking")
		BusinessDetails.longitude.AdvancedSearch.SearchValue = ObjForm.GetValue("x_longitude")
		BusinessDetails.longitude.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_longitude")
		BusinessDetails.latitude.AdvancedSearch.SearchValue = ObjForm.GetValue("x_latitude")
		BusinessDetails.latitude.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_latitude")
		BusinessDetails.googleecommercetracking.AdvancedSearch.SearchValue = ObjForm.GetValue("x_googleecommercetracking")
		BusinessDetails.googleecommercetracking.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_googleecommercetracking")
		BusinessDetails.googleecommercetrackingcode.AdvancedSearch.SearchValue = ObjForm.GetValue("x_googleecommercetrackingcode")
		BusinessDetails.googleecommercetrackingcode.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_googleecommercetrackingcode")
		BusinessDetails.bringg.AdvancedSearch.SearchValue = ObjForm.GetValue("x_bringg")
		BusinessDetails.bringg.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_bringg")
		BusinessDetails.bringgurl.AdvancedSearch.SearchValue = ObjForm.GetValue("x_bringgurl")
		BusinessDetails.bringgurl.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_bringgurl")
		BusinessDetails.bringgcompanyid.AdvancedSearch.SearchValue = ObjForm.GetValue("x_bringgcompanyid")
		BusinessDetails.bringgcompanyid.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_bringgcompanyid")
		BusinessDetails.orderonlywhenopen.AdvancedSearch.SearchValue = ObjForm.GetValue("x_orderonlywhenopen")
		BusinessDetails.orderonlywhenopen.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_orderonlywhenopen")
		BusinessDetails.disablelaterdelivery.AdvancedSearch.SearchValue = ObjForm.GetValue("x_disablelaterdelivery")
		BusinessDetails.disablelaterdelivery.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_disablelaterdelivery")
		BusinessDetails.menupagetext.AdvancedSearch.SearchValue = ObjForm.GetValue("x_menupagetext")
		BusinessDetails.menupagetext.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_menupagetext")
		BusinessDetails.ordertodayonly.AdvancedSearch.SearchValue = ObjForm.GetValue("x_ordertodayonly")
		BusinessDetails.ordertodayonly.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_ordertodayonly")
		BusinessDetails.mileskm.AdvancedSearch.SearchValue = ObjForm.GetValue("x_mileskm")
		BusinessDetails.mileskm.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_mileskm")
		BusinessDetails.worldpaylive.AdvancedSearch.SearchValue = ObjForm.GetValue("x_worldpaylive")
		BusinessDetails.worldpaylive.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_worldpaylive")
		BusinessDetails.worldpayinstallationid.AdvancedSearch.SearchValue = ObjForm.GetValue("x_worldpayinstallationid")
		BusinessDetails.worldpayinstallationid.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_worldpayinstallationid")
		BusinessDetails.DistanceCalMethod.AdvancedSearch.SearchValue = ObjForm.GetValue("x_DistanceCalMethod")
		BusinessDetails.DistanceCalMethod.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_DistanceCalMethod")
		BusinessDetails.PrinterIDList.AdvancedSearch.SearchValue = ObjForm.GetValue("x_PrinterIDList")
		BusinessDetails.PrinterIDList.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_PrinterIDList")
		BusinessDetails.EpsonJSPrinterURL.AdvancedSearch.SearchValue = ObjForm.GetValue("x_EpsonJSPrinterURL")
		BusinessDetails.EpsonJSPrinterURL.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_EpsonJSPrinterURL")
		BusinessDetails.SMSEnable.AdvancedSearch.SearchValue = ObjForm.GetValue("x_SMSEnable")
		BusinessDetails.SMSEnable.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_SMSEnable")
		BusinessDetails.SMSOnDelivery.AdvancedSearch.SearchValue = ObjForm.GetValue("x_SMSOnDelivery")
		BusinessDetails.SMSOnDelivery.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_SMSOnDelivery")
		BusinessDetails.SMSSupplierDomain.AdvancedSearch.SearchValue = ObjForm.GetValue("x_SMSSupplierDomain")
		BusinessDetails.SMSSupplierDomain.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_SMSSupplierDomain")
		BusinessDetails.SMSOnOrder.AdvancedSearch.SearchValue = ObjForm.GetValue("x_SMSOnOrder")
		BusinessDetails.SMSOnOrder.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_SMSOnOrder")
		BusinessDetails.SMSOnOrderAfterMin.AdvancedSearch.SearchValue = ObjForm.GetValue("x_SMSOnOrderAfterMin")
		BusinessDetails.SMSOnOrderAfterMin.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_SMSOnOrderAfterMin")
		BusinessDetails.SMSOnOrderContent.AdvancedSearch.SearchValue = ObjForm.GetValue("x_SMSOnOrderContent")
		BusinessDetails.SMSOnOrderContent.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_SMSOnOrderContent")
		BusinessDetails.DefaultSMSCountryCode.AdvancedSearch.SearchValue = ObjForm.GetValue("x_DefaultSMSCountryCode")
		BusinessDetails.DefaultSMSCountryCode.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_DefaultSMSCountryCode")
		BusinessDetails.MinimumAmountForCardPayment.AdvancedSearch.SearchValue = ObjForm.GetValue("x_MinimumAmountForCardPayment")
		BusinessDetails.MinimumAmountForCardPayment.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_MinimumAmountForCardPayment")
		BusinessDetails.FavIconUrl.AdvancedSearch.SearchValue = ObjForm.GetValue("x_FavIconUrl")
		BusinessDetails.FavIconUrl.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_FavIconUrl")
		BusinessDetails.AddToHomeScreenURL.AdvancedSearch.SearchValue = ObjForm.GetValue("x_AddToHomeScreenURL")
		BusinessDetails.AddToHomeScreenURL.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_AddToHomeScreenURL")
		BusinessDetails.SMSOnAcknowledgement.AdvancedSearch.SearchValue = ObjForm.GetValue("x_SMSOnAcknowledgement")
		BusinessDetails.SMSOnAcknowledgement.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_SMSOnAcknowledgement")
		BusinessDetails.LocalPrinterURL.AdvancedSearch.SearchValue = ObjForm.GetValue("x_LocalPrinterURL")
		BusinessDetails.LocalPrinterURL.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_LocalPrinterURL")
		BusinessDetails.ShowRestaurantDetailOnReceipt.AdvancedSearch.SearchValue = ObjForm.GetValue("x_ShowRestaurantDetailOnReceipt")
		BusinessDetails.ShowRestaurantDetailOnReceipt.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_ShowRestaurantDetailOnReceipt")
		BusinessDetails.PrinterFontSizeRatio.AdvancedSearch.SearchValue = ObjForm.GetValue("x_PrinterFontSizeRatio")
		BusinessDetails.PrinterFontSizeRatio.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_PrinterFontSizeRatio")
		BusinessDetails.ServiceChargePercentage.AdvancedSearch.SearchValue = ObjForm.GetValue("x_ServiceChargePercentage")
		BusinessDetails.ServiceChargePercentage.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_ServiceChargePercentage")
		BusinessDetails.InRestaurantServiceChargeOnly.AdvancedSearch.SearchValue = ObjForm.GetValue("x_InRestaurantServiceChargeOnly")
		BusinessDetails.InRestaurantServiceChargeOnly.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_InRestaurantServiceChargeOnly")
		BusinessDetails.IsDualReceiptPrinting.AdvancedSearch.SearchValue = ObjForm.GetValue("x_IsDualReceiptPrinting")
		BusinessDetails.IsDualReceiptPrinting.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_IsDualReceiptPrinting")
		BusinessDetails.PrintingFontSize.AdvancedSearch.SearchValue = ObjForm.GetValue("x_PrintingFontSize")
		BusinessDetails.PrintingFontSize.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_PrintingFontSize")
		BusinessDetails.InRestaurantEpsonPrinterIDList.AdvancedSearch.SearchValue = ObjForm.GetValue("x_InRestaurantEpsonPrinterIDList")
		BusinessDetails.InRestaurantEpsonPrinterIDList.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_InRestaurantEpsonPrinterIDList")
		BusinessDetails.BlockIPEmailList.AdvancedSearch.SearchValue = ObjForm.GetValue("x_BlockIPEmailList")
		BusinessDetails.BlockIPEmailList.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_BlockIPEmailList")
		BusinessDetails.inmenuannouncement.AdvancedSearch.SearchValue = ObjForm.GetValue("x_inmenuannouncement")
		BusinessDetails.inmenuannouncement.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_inmenuannouncement")
		BusinessDetails.RePrintReceiptWays.AdvancedSearch.SearchValue = ObjForm.GetValue("x_RePrintReceiptWays")
		BusinessDetails.RePrintReceiptWays.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_RePrintReceiptWays")
		BusinessDetails.printingtype.AdvancedSearch.SearchValue = ObjForm.GetValue("x_printingtype")
		BusinessDetails.printingtype.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_printingtype")
		BusinessDetails.Stripe_Key_Secret.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Stripe_Key_Secret")
		BusinessDetails.Stripe_Key_Secret.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Stripe_Key_Secret")
		BusinessDetails.Stripe.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Stripe")
		BusinessDetails.Stripe.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Stripe")
		BusinessDetails.Stripe_Api_Key.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Stripe_Api_Key")
		BusinessDetails.Stripe_Api_Key.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Stripe_Api_Key")
		BusinessDetails.EnableBooking.AdvancedSearch.SearchValue = ObjForm.GetValue("x_EnableBooking")
		BusinessDetails.EnableBooking.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_EnableBooking")
		BusinessDetails.URL_Facebook.AdvancedSearch.SearchValue = ObjForm.GetValue("x_URL_Facebook")
		BusinessDetails.URL_Facebook.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_URL_Facebook")
		BusinessDetails.URL_Twitter.AdvancedSearch.SearchValue = ObjForm.GetValue("x_URL_Twitter")
		BusinessDetails.URL_Twitter.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_URL_Twitter")
		BusinessDetails.URL_Google.AdvancedSearch.SearchValue = ObjForm.GetValue("x_URL_Google")
		BusinessDetails.URL_Google.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_URL_Google")
		BusinessDetails.URL_Intagram.AdvancedSearch.SearchValue = ObjForm.GetValue("x_URL_Intagram")
		BusinessDetails.URL_Intagram.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_URL_Intagram")
		BusinessDetails.URL_YouTube.AdvancedSearch.SearchValue = ObjForm.GetValue("x_URL_YouTube")
		BusinessDetails.URL_YouTube.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_URL_YouTube")
		BusinessDetails.URL_Tripadvisor.AdvancedSearch.SearchValue = ObjForm.GetValue("x_URL_Tripadvisor")
		BusinessDetails.URL_Tripadvisor.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_URL_Tripadvisor")
		BusinessDetails.URL_Special_Offer.AdvancedSearch.SearchValue = ObjForm.GetValue("x_URL_Special_Offer")
		BusinessDetails.URL_Special_Offer.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_URL_Special_Offer")
		BusinessDetails.URL_Linkin.AdvancedSearch.SearchValue = ObjForm.GetValue("x_URL_Linkin")
		BusinessDetails.URL_Linkin.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_URL_Linkin")
		BusinessDetails.Currency_PAYPAL.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Currency_PAYPAL")
		BusinessDetails.Currency_PAYPAL.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Currency_PAYPAL")
		BusinessDetails.Currency_STRIPE.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Currency_STRIPE")
		BusinessDetails.Currency_STRIPE.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Currency_STRIPE")
		BusinessDetails.Currency_WOLRDPAY.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Currency_WOLRDPAY")
		BusinessDetails.Currency_WOLRDPAY.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Currency_WOLRDPAY")
		BusinessDetails.Tip_percent.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Tip_percent")
		BusinessDetails.Tip_percent.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Tip_percent")
		BusinessDetails.Tax_Percent.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Tax_Percent")
		BusinessDetails.Tax_Percent.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Tax_Percent")
		BusinessDetails.InRestaurantTaxChargeOnly.AdvancedSearch.SearchValue = ObjForm.GetValue("x_InRestaurantTaxChargeOnly")
		BusinessDetails.InRestaurantTaxChargeOnly.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_InRestaurantTaxChargeOnly")
		BusinessDetails.InRestaurantTipChargeOnly.AdvancedSearch.SearchValue = ObjForm.GetValue("x_InRestaurantTipChargeOnly")
		BusinessDetails.InRestaurantTipChargeOnly.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_InRestaurantTipChargeOnly")
		BusinessDetails.isCheckCapcha.AdvancedSearch.SearchValue = ObjForm.GetValue("x_isCheckCapcha")
		BusinessDetails.isCheckCapcha.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_isCheckCapcha")
		BusinessDetails.Close_StartDate.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Close_StartDate")
		BusinessDetails.Close_StartDate.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Close_StartDate")
		BusinessDetails.Close_EndDate.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Close_EndDate")
		BusinessDetails.Close_EndDate.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Close_EndDate")
		BusinessDetails.Stripe_Country.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Stripe_Country")
		BusinessDetails.Stripe_Country.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Stripe_Country")
		BusinessDetails.enable_StripePaymentButton.AdvancedSearch.SearchValue = ObjForm.GetValue("x_enable_StripePaymentButton")
		BusinessDetails.enable_StripePaymentButton.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_enable_StripePaymentButton")
		BusinessDetails.enable_CashPayment.AdvancedSearch.SearchValue = ObjForm.GetValue("x_enable_CashPayment")
		BusinessDetails.enable_CashPayment.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_enable_CashPayment")
		BusinessDetails.DeliveryMile.AdvancedSearch.SearchValue = ObjForm.GetValue("x_DeliveryMile")
		BusinessDetails.DeliveryMile.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_DeliveryMile")
		BusinessDetails.Mon_Delivery.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Mon_Delivery")
		BusinessDetails.Mon_Delivery.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Mon_Delivery")
		BusinessDetails.Mon_Collection.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Mon_Collection")
		BusinessDetails.Mon_Collection.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Mon_Collection")
		BusinessDetails.Tue_Delivery.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Tue_Delivery")
		BusinessDetails.Tue_Delivery.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Tue_Delivery")
		BusinessDetails.Tue_Collection.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Tue_Collection")
		BusinessDetails.Tue_Collection.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Tue_Collection")
		BusinessDetails.Wed_Delivery.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Wed_Delivery")
		BusinessDetails.Wed_Delivery.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Wed_Delivery")
		BusinessDetails.Wed_Collection.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Wed_Collection")
		BusinessDetails.Wed_Collection.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Wed_Collection")
		BusinessDetails.Thu_Delivery.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Thu_Delivery")
		BusinessDetails.Thu_Delivery.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Thu_Delivery")
		BusinessDetails.Thu_Collection.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Thu_Collection")
		BusinessDetails.Thu_Collection.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Thu_Collection")
		BusinessDetails.Fri_Delivery.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Fri_Delivery")
		BusinessDetails.Fri_Delivery.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Fri_Delivery")
		BusinessDetails.Fri_Collection.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Fri_Collection")
		BusinessDetails.Fri_Collection.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Fri_Collection")
		BusinessDetails.Sat_Delivery.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Sat_Delivery")
		BusinessDetails.Sat_Delivery.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Sat_Delivery")
		BusinessDetails.Sat_Collection.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Sat_Collection")
		BusinessDetails.Sat_Collection.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Sat_Collection")
		BusinessDetails.Sun_Delivery.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Sun_Delivery")
		BusinessDetails.Sun_Delivery.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Sun_Delivery")
		BusinessDetails.Sun_Collection.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Sun_Collection")
		BusinessDetails.Sun_Collection.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Sun_Collection")
		BusinessDetails.EnableUrlRewrite.AdvancedSearch.SearchValue = ObjForm.GetValue("x_EnableUrlRewrite")
		BusinessDetails.EnableUrlRewrite.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_EnableUrlRewrite")
		BusinessDetails.DeliveryCostUpTo.AdvancedSearch.SearchValue = ObjForm.GetValue("x_DeliveryCostUpTo")
		BusinessDetails.DeliveryCostUpTo.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_DeliveryCostUpTo")
		BusinessDetails.DeliveryUptoMile.AdvancedSearch.SearchValue = ObjForm.GetValue("x_DeliveryUptoMile")
		BusinessDetails.DeliveryUptoMile.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_DeliveryUptoMile")
		BusinessDetails.Show_Ordernumner_printer.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Show_Ordernumner_printer")
		BusinessDetails.Show_Ordernumner_printer.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Show_Ordernumner_printer")
		BusinessDetails.Show_Ordernumner_Receipt.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Show_Ordernumner_Receipt")
		BusinessDetails.Show_Ordernumner_Receipt.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Show_Ordernumner_Receipt")
		BusinessDetails.Show_Ordernumner_Dashboard.AdvancedSearch.SearchValue = ObjForm.GetValue("x_Show_Ordernumner_Dashboard")
		BusinessDetails.Show_Ordernumner_Dashboard.AdvancedSearch.SearchOperator = ObjForm.GetValue("z_Show_Ordernumner_Dashboard")
	End Function

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

		' ------------
		'  Search Row
		' ------------

		ElseIf BusinessDetails.RowType = EW_ROWTYPE_SEARCH Then ' Search row

			' ID
			BusinessDetails.ID.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.ID.EditCustomAttributes = ""
			BusinessDetails.ID.EditValue = ew_HtmlEncode(BusinessDetails.ID.AdvancedSearch.SearchValue)
			BusinessDetails.ID.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.ID.FldCaption))

			' Name
			BusinessDetails.Name.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Name.EditCustomAttributes = ""
			BusinessDetails.Name.EditValue = ew_HtmlEncode(BusinessDetails.Name.AdvancedSearch.SearchValue)
			BusinessDetails.Name.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Name.FldCaption))

			' Address
			BusinessDetails.Address.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Address.EditCustomAttributes = ""
			BusinessDetails.Address.EditValue = ew_HtmlEncode(BusinessDetails.Address.AdvancedSearch.SearchValue)
			BusinessDetails.Address.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Address.FldCaption))

			' PostalCode
			BusinessDetails.PostalCode.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.PostalCode.EditCustomAttributes = ""
			BusinessDetails.PostalCode.EditValue = ew_HtmlEncode(BusinessDetails.PostalCode.AdvancedSearch.SearchValue)
			BusinessDetails.PostalCode.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.PostalCode.FldCaption))

			' FoodType
			BusinessDetails.FoodType.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.FoodType.EditCustomAttributes = ""
			BusinessDetails.FoodType.EditValue = ew_HtmlEncode(BusinessDetails.FoodType.AdvancedSearch.SearchValue)
			BusinessDetails.FoodType.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.FoodType.FldCaption))

			' DeliveryMinAmount
			BusinessDetails.DeliveryMinAmount.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.DeliveryMinAmount.EditCustomAttributes = ""
			BusinessDetails.DeliveryMinAmount.EditValue = ew_HtmlEncode(BusinessDetails.DeliveryMinAmount.AdvancedSearch.SearchValue)
			BusinessDetails.DeliveryMinAmount.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.DeliveryMinAmount.FldCaption))

			' DeliveryMaxDistance
			BusinessDetails.DeliveryMaxDistance.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.DeliveryMaxDistance.EditCustomAttributes = ""
			BusinessDetails.DeliveryMaxDistance.EditValue = ew_HtmlEncode(BusinessDetails.DeliveryMaxDistance.AdvancedSearch.SearchValue)
			BusinessDetails.DeliveryMaxDistance.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.DeliveryMaxDistance.FldCaption))

			' DeliveryFreeDistance
			BusinessDetails.DeliveryFreeDistance.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.DeliveryFreeDistance.EditCustomAttributes = ""
			BusinessDetails.DeliveryFreeDistance.EditValue = ew_HtmlEncode(BusinessDetails.DeliveryFreeDistance.AdvancedSearch.SearchValue)
			BusinessDetails.DeliveryFreeDistance.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.DeliveryFreeDistance.FldCaption))

			' AverageDeliveryTime
			BusinessDetails.AverageDeliveryTime.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.AverageDeliveryTime.EditCustomAttributes = ""
			BusinessDetails.AverageDeliveryTime.EditValue = ew_HtmlEncode(BusinessDetails.AverageDeliveryTime.AdvancedSearch.SearchValue)
			BusinessDetails.AverageDeliveryTime.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.AverageDeliveryTime.FldCaption))

			' AverageCollectionTime
			BusinessDetails.AverageCollectionTime.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.AverageCollectionTime.EditCustomAttributes = ""
			BusinessDetails.AverageCollectionTime.EditValue = ew_HtmlEncode(BusinessDetails.AverageCollectionTime.AdvancedSearch.SearchValue)
			BusinessDetails.AverageCollectionTime.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.AverageCollectionTime.FldCaption))

			' DeliveryFee
			BusinessDetails.DeliveryFee.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.DeliveryFee.EditCustomAttributes = ""
			BusinessDetails.DeliveryFee.EditValue = ew_HtmlEncode(BusinessDetails.DeliveryFee.AdvancedSearch.SearchValue)
			BusinessDetails.DeliveryFee.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.DeliveryFee.FldCaption))

			' ImgUrl
			BusinessDetails.ImgUrl.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.ImgUrl.EditCustomAttributes = ""
			BusinessDetails.ImgUrl.EditValue = ew_HtmlEncode(BusinessDetails.ImgUrl.AdvancedSearch.SearchValue)
			BusinessDetails.ImgUrl.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.ImgUrl.FldCaption))

			' Telephone
			BusinessDetails.Telephone.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Telephone.EditCustomAttributes = ""
			BusinessDetails.Telephone.EditValue = ew_HtmlEncode(BusinessDetails.Telephone.AdvancedSearch.SearchValue)
			BusinessDetails.Telephone.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Telephone.FldCaption))

			' Email
			BusinessDetails.zEmail.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.zEmail.EditCustomAttributes = ""
			BusinessDetails.zEmail.EditValue = ew_HtmlEncode(BusinessDetails.zEmail.AdvancedSearch.SearchValue)
			BusinessDetails.zEmail.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.zEmail.FldCaption))

			' pswd
			BusinessDetails.pswd.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.pswd.EditCustomAttributes = ""
			BusinessDetails.pswd.EditValue = ew_HtmlEncode(BusinessDetails.pswd.AdvancedSearch.SearchValue)
			BusinessDetails.pswd.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.pswd.FldCaption))

			' businessclosed
			BusinessDetails.businessclosed.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.businessclosed.EditCustomAttributes = ""
			BusinessDetails.businessclosed.EditValue = ew_HtmlEncode(BusinessDetails.businessclosed.AdvancedSearch.SearchValue)
			BusinessDetails.businessclosed.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.businessclosed.FldCaption))

			' announcement
			BusinessDetails.announcement.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.announcement.EditCustomAttributes = ""
			BusinessDetails.announcement.EditValue = ew_HtmlEncode(BusinessDetails.announcement.AdvancedSearch.SearchValue)
			BusinessDetails.announcement.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.announcement.FldCaption))

			' css
			BusinessDetails.css.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.css.EditCustomAttributes = ""
			BusinessDetails.css.EditValue = ew_HtmlEncode(BusinessDetails.css.AdvancedSearch.SearchValue)
			BusinessDetails.css.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.css.FldCaption))

			' SMTP_AUTENTICATE
			BusinessDetails.SMTP_AUTENTICATE.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.SMTP_AUTENTICATE.EditCustomAttributes = ""
			BusinessDetails.SMTP_AUTENTICATE.EditValue = ew_HtmlEncode(BusinessDetails.SMTP_AUTENTICATE.AdvancedSearch.SearchValue)
			BusinessDetails.SMTP_AUTENTICATE.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.SMTP_AUTENTICATE.FldCaption))

			' MAIL_FROM
			BusinessDetails.MAIL_FROM.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.MAIL_FROM.EditCustomAttributes = ""
			BusinessDetails.MAIL_FROM.EditValue = ew_HtmlEncode(BusinessDetails.MAIL_FROM.AdvancedSearch.SearchValue)
			BusinessDetails.MAIL_FROM.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.MAIL_FROM.FldCaption))

			' PAYPAL_URL
			BusinessDetails.PAYPAL_URL.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.PAYPAL_URL.EditCustomAttributes = ""
			BusinessDetails.PAYPAL_URL.EditValue = ew_HtmlEncode(BusinessDetails.PAYPAL_URL.AdvancedSearch.SearchValue)
			BusinessDetails.PAYPAL_URL.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.PAYPAL_URL.FldCaption))

			' PAYPAL_PDT
			BusinessDetails.PAYPAL_PDT.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.PAYPAL_PDT.EditCustomAttributes = ""
			BusinessDetails.PAYPAL_PDT.EditValue = ew_HtmlEncode(BusinessDetails.PAYPAL_PDT.AdvancedSearch.SearchValue)
			BusinessDetails.PAYPAL_PDT.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.PAYPAL_PDT.FldCaption))

			' SMTP_PASSWORD
			BusinessDetails.SMTP_PASSWORD.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.SMTP_PASSWORD.EditCustomAttributes = ""
			BusinessDetails.SMTP_PASSWORD.EditValue = ew_HtmlEncode(BusinessDetails.SMTP_PASSWORD.AdvancedSearch.SearchValue)
			BusinessDetails.SMTP_PASSWORD.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.SMTP_PASSWORD.FldCaption))

			' GMAP_API_KEY
			BusinessDetails.GMAP_API_KEY.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.GMAP_API_KEY.EditCustomAttributes = ""
			BusinessDetails.GMAP_API_KEY.EditValue = ew_HtmlEncode(BusinessDetails.GMAP_API_KEY.AdvancedSearch.SearchValue)
			BusinessDetails.GMAP_API_KEY.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.GMAP_API_KEY.FldCaption))

			' SMTP_USERNAME
			BusinessDetails.SMTP_USERNAME.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.SMTP_USERNAME.EditCustomAttributes = ""
			BusinessDetails.SMTP_USERNAME.EditValue = ew_HtmlEncode(BusinessDetails.SMTP_USERNAME.AdvancedSearch.SearchValue)
			BusinessDetails.SMTP_USERNAME.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.SMTP_USERNAME.FldCaption))

			' SMTP_USESSL
			BusinessDetails.SMTP_USESSL.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.SMTP_USESSL.EditCustomAttributes = ""
			BusinessDetails.SMTP_USESSL.EditValue = ew_HtmlEncode(BusinessDetails.SMTP_USESSL.AdvancedSearch.SearchValue)
			BusinessDetails.SMTP_USESSL.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.SMTP_USESSL.FldCaption))

			' MAIL_SUBJECT
			BusinessDetails.MAIL_SUBJECT.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.MAIL_SUBJECT.EditCustomAttributes = ""
			BusinessDetails.MAIL_SUBJECT.EditValue = ew_HtmlEncode(BusinessDetails.MAIL_SUBJECT.AdvancedSearch.SearchValue)
			BusinessDetails.MAIL_SUBJECT.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.MAIL_SUBJECT.FldCaption))

			' CURRENCYSYMBOL
			BusinessDetails.CURRENCYSYMBOL.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.CURRENCYSYMBOL.EditCustomAttributes = ""
			BusinessDetails.CURRENCYSYMBOL.EditValue = ew_HtmlEncode(BusinessDetails.CURRENCYSYMBOL.AdvancedSearch.SearchValue)
			BusinessDetails.CURRENCYSYMBOL.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.CURRENCYSYMBOL.FldCaption))

			' SMTP_SERVER
			BusinessDetails.SMTP_SERVER.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.SMTP_SERVER.EditCustomAttributes = ""
			BusinessDetails.SMTP_SERVER.EditValue = ew_HtmlEncode(BusinessDetails.SMTP_SERVER.AdvancedSearch.SearchValue)
			BusinessDetails.SMTP_SERVER.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.SMTP_SERVER.FldCaption))

			' CREDITCARDSURCHARGE
			BusinessDetails.CREDITCARDSURCHARGE.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.CREDITCARDSURCHARGE.EditCustomAttributes = ""
			BusinessDetails.CREDITCARDSURCHARGE.EditValue = ew_HtmlEncode(BusinessDetails.CREDITCARDSURCHARGE.AdvancedSearch.SearchValue)
			BusinessDetails.CREDITCARDSURCHARGE.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.CREDITCARDSURCHARGE.FldCaption))

			' SMTP_PORT
			BusinessDetails.SMTP_PORT.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.SMTP_PORT.EditCustomAttributes = ""
			BusinessDetails.SMTP_PORT.EditValue = ew_HtmlEncode(BusinessDetails.SMTP_PORT.AdvancedSearch.SearchValue)
			BusinessDetails.SMTP_PORT.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.SMTP_PORT.FldCaption))

			' STICK_MENU
			BusinessDetails.STICK_MENU.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.STICK_MENU.EditCustomAttributes = ""
			BusinessDetails.STICK_MENU.EditValue = ew_HtmlEncode(BusinessDetails.STICK_MENU.AdvancedSearch.SearchValue)
			BusinessDetails.STICK_MENU.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.STICK_MENU.FldCaption))

			' MAIL_CUSTOMER_SUBJECT
			BusinessDetails.MAIL_CUSTOMER_SUBJECT.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.MAIL_CUSTOMER_SUBJECT.EditCustomAttributes = ""
			BusinessDetails.MAIL_CUSTOMER_SUBJECT.EditValue = ew_HtmlEncode(BusinessDetails.MAIL_CUSTOMER_SUBJECT.AdvancedSearch.SearchValue)
			BusinessDetails.MAIL_CUSTOMER_SUBJECT.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.MAIL_CUSTOMER_SUBJECT.FldCaption))

			' CONFIRMATION_EMAIL_ADDRESS
			BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.EditCustomAttributes = ""
			BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.EditValue = ew_HtmlEncode(BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.AdvancedSearch.SearchValue)
			BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.FldCaption))

			' SEND_ORDERS_TO_PRINTER
			BusinessDetails.SEND_ORDERS_TO_PRINTER.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.SEND_ORDERS_TO_PRINTER.EditCustomAttributes = ""
			BusinessDetails.SEND_ORDERS_TO_PRINTER.EditValue = ew_HtmlEncode(BusinessDetails.SEND_ORDERS_TO_PRINTER.AdvancedSearch.SearchValue)
			BusinessDetails.SEND_ORDERS_TO_PRINTER.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.SEND_ORDERS_TO_PRINTER.FldCaption))

			' timezone
			BusinessDetails.timezone.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.timezone.EditCustomAttributes = ""
			BusinessDetails.timezone.EditValue = ew_HtmlEncode(BusinessDetails.timezone.AdvancedSearch.SearchValue)
			BusinessDetails.timezone.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.timezone.FldCaption))

			' PAYPAL_ADDR
			BusinessDetails.PAYPAL_ADDR.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.PAYPAL_ADDR.EditCustomAttributes = ""
			BusinessDetails.PAYPAL_ADDR.EditValue = ew_HtmlEncode(BusinessDetails.PAYPAL_ADDR.AdvancedSearch.SearchValue)
			BusinessDetails.PAYPAL_ADDR.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.PAYPAL_ADDR.FldCaption))

			' nochex
			BusinessDetails.nochex.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.nochex.EditCustomAttributes = ""
			BusinessDetails.nochex.EditValue = ew_HtmlEncode(BusinessDetails.nochex.AdvancedSearch.SearchValue)
			BusinessDetails.nochex.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.nochex.FldCaption))

			' nochexmerchantid
			BusinessDetails.nochexmerchantid.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.nochexmerchantid.EditCustomAttributes = ""
			BusinessDetails.nochexmerchantid.EditValue = ew_HtmlEncode(BusinessDetails.nochexmerchantid.AdvancedSearch.SearchValue)
			BusinessDetails.nochexmerchantid.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.nochexmerchantid.FldCaption))

			' paypal
			BusinessDetails.paypal.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.paypal.EditCustomAttributes = ""
			BusinessDetails.paypal.EditValue = ew_HtmlEncode(BusinessDetails.paypal.AdvancedSearch.SearchValue)
			BusinessDetails.paypal.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.paypal.FldCaption))

			' IBT_API_KEY
			BusinessDetails.IBT_API_KEY.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.IBT_API_KEY.EditCustomAttributes = ""
			BusinessDetails.IBT_API_KEY.EditValue = ew_HtmlEncode(BusinessDetails.IBT_API_KEY.AdvancedSearch.SearchValue)
			BusinessDetails.IBT_API_KEY.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.IBT_API_KEY.FldCaption))

			' IBP_API_PASSWORD
			BusinessDetails.IBP_API_PASSWORD.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.IBP_API_PASSWORD.EditCustomAttributes = ""
			BusinessDetails.IBP_API_PASSWORD.EditValue = ew_HtmlEncode(BusinessDetails.IBP_API_PASSWORD.AdvancedSearch.SearchValue)
			BusinessDetails.IBP_API_PASSWORD.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.IBP_API_PASSWORD.FldCaption))

			' disable_delivery
			BusinessDetails.disable_delivery.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.disable_delivery.EditCustomAttributes = ""
			BusinessDetails.disable_delivery.EditValue = ew_HtmlEncode(BusinessDetails.disable_delivery.AdvancedSearch.SearchValue)
			BusinessDetails.disable_delivery.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.disable_delivery.FldCaption))

			' disable_collection
			BusinessDetails.disable_collection.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.disable_collection.EditCustomAttributes = ""
			BusinessDetails.disable_collection.EditValue = ew_HtmlEncode(BusinessDetails.disable_collection.AdvancedSearch.SearchValue)
			BusinessDetails.disable_collection.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.disable_collection.FldCaption))

			' worldpay
			BusinessDetails.worldpay.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.worldpay.EditCustomAttributes = ""
			BusinessDetails.worldpay.EditValue = ew_HtmlEncode(BusinessDetails.worldpay.AdvancedSearch.SearchValue)
			BusinessDetails.worldpay.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.worldpay.FldCaption))

			' worldpaymerchantid
			BusinessDetails.worldpaymerchantid.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.worldpaymerchantid.EditCustomAttributes = ""
			BusinessDetails.worldpaymerchantid.EditValue = ew_HtmlEncode(BusinessDetails.worldpaymerchantid.AdvancedSearch.SearchValue)
			BusinessDetails.worldpaymerchantid.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.worldpaymerchantid.FldCaption))

			' backtohometext
			BusinessDetails.backtohometext.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.backtohometext.EditCustomAttributes = ""
			BusinessDetails.backtohometext.EditValue = ew_HtmlEncode(BusinessDetails.backtohometext.AdvancedSearch.SearchValue)
			BusinessDetails.backtohometext.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.backtohometext.FldCaption))

			' closedtext
			BusinessDetails.closedtext.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.closedtext.EditCustomAttributes = ""
			BusinessDetails.closedtext.EditValue = ew_HtmlEncode(BusinessDetails.closedtext.AdvancedSearch.SearchValue)
			BusinessDetails.closedtext.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.closedtext.FldCaption))

			' DeliveryChargeOverrideByOrderValue
			BusinessDetails.DeliveryChargeOverrideByOrderValue.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.DeliveryChargeOverrideByOrderValue.EditCustomAttributes = ""
			BusinessDetails.DeliveryChargeOverrideByOrderValue.EditValue = ew_HtmlEncode(BusinessDetails.DeliveryChargeOverrideByOrderValue.AdvancedSearch.SearchValue)
			BusinessDetails.DeliveryChargeOverrideByOrderValue.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.DeliveryChargeOverrideByOrderValue.FldCaption))

			' individualpostcodes
			BusinessDetails.individualpostcodes.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.individualpostcodes.EditCustomAttributes = ""
			BusinessDetails.individualpostcodes.EditValue = ew_HtmlEncode(BusinessDetails.individualpostcodes.AdvancedSearch.SearchValue)
			BusinessDetails.individualpostcodes.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.individualpostcodes.FldCaption))

			' individualpostcodeschecking
			BusinessDetails.individualpostcodeschecking.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.individualpostcodeschecking.EditCustomAttributes = ""
			BusinessDetails.individualpostcodeschecking.EditValue = ew_HtmlEncode(BusinessDetails.individualpostcodeschecking.AdvancedSearch.SearchValue)
			BusinessDetails.individualpostcodeschecking.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.individualpostcodeschecking.FldCaption))

			' longitude
			BusinessDetails.longitude.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.longitude.EditCustomAttributes = ""
			BusinessDetails.longitude.EditValue = ew_HtmlEncode(BusinessDetails.longitude.AdvancedSearch.SearchValue)
			BusinessDetails.longitude.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.longitude.FldCaption))

			' latitude
			BusinessDetails.latitude.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.latitude.EditCustomAttributes = ""
			BusinessDetails.latitude.EditValue = ew_HtmlEncode(BusinessDetails.latitude.AdvancedSearch.SearchValue)
			BusinessDetails.latitude.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.latitude.FldCaption))

			' googleecommercetracking
			BusinessDetails.googleecommercetracking.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.googleecommercetracking.EditCustomAttributes = ""
			BusinessDetails.googleecommercetracking.EditValue = ew_HtmlEncode(BusinessDetails.googleecommercetracking.AdvancedSearch.SearchValue)
			BusinessDetails.googleecommercetracking.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.googleecommercetracking.FldCaption))

			' googleecommercetrackingcode
			BusinessDetails.googleecommercetrackingcode.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.googleecommercetrackingcode.EditCustomAttributes = ""
			BusinessDetails.googleecommercetrackingcode.EditValue = ew_HtmlEncode(BusinessDetails.googleecommercetrackingcode.AdvancedSearch.SearchValue)
			BusinessDetails.googleecommercetrackingcode.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.googleecommercetrackingcode.FldCaption))

			' bringg
			BusinessDetails.bringg.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.bringg.EditCustomAttributes = ""
			BusinessDetails.bringg.EditValue = ew_HtmlEncode(BusinessDetails.bringg.AdvancedSearch.SearchValue)
			BusinessDetails.bringg.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.bringg.FldCaption))

			' bringgurl
			BusinessDetails.bringgurl.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.bringgurl.EditCustomAttributes = ""
			BusinessDetails.bringgurl.EditValue = ew_HtmlEncode(BusinessDetails.bringgurl.AdvancedSearch.SearchValue)
			BusinessDetails.bringgurl.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.bringgurl.FldCaption))

			' bringgcompanyid
			BusinessDetails.bringgcompanyid.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.bringgcompanyid.EditCustomAttributes = ""
			BusinessDetails.bringgcompanyid.EditValue = ew_HtmlEncode(BusinessDetails.bringgcompanyid.AdvancedSearch.SearchValue)
			BusinessDetails.bringgcompanyid.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.bringgcompanyid.FldCaption))

			' orderonlywhenopen
			BusinessDetails.orderonlywhenopen.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.orderonlywhenopen.EditCustomAttributes = ""
			BusinessDetails.orderonlywhenopen.EditValue = ew_HtmlEncode(BusinessDetails.orderonlywhenopen.AdvancedSearch.SearchValue)
			BusinessDetails.orderonlywhenopen.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.orderonlywhenopen.FldCaption))

			' disablelaterdelivery
			BusinessDetails.disablelaterdelivery.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.disablelaterdelivery.EditCustomAttributes = ""
			BusinessDetails.disablelaterdelivery.EditValue = ew_HtmlEncode(BusinessDetails.disablelaterdelivery.AdvancedSearch.SearchValue)
			BusinessDetails.disablelaterdelivery.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.disablelaterdelivery.FldCaption))

			' menupagetext
			BusinessDetails.menupagetext.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.menupagetext.EditCustomAttributes = ""
			BusinessDetails.menupagetext.EditValue = ew_HtmlEncode(BusinessDetails.menupagetext.AdvancedSearch.SearchValue)
			BusinessDetails.menupagetext.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.menupagetext.FldCaption))

			' ordertodayonly
			BusinessDetails.ordertodayonly.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.ordertodayonly.EditCustomAttributes = ""
			BusinessDetails.ordertodayonly.EditValue = ew_HtmlEncode(BusinessDetails.ordertodayonly.AdvancedSearch.SearchValue)
			BusinessDetails.ordertodayonly.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.ordertodayonly.FldCaption))

			' mileskm
			BusinessDetails.mileskm.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.mileskm.EditCustomAttributes = ""
			BusinessDetails.mileskm.EditValue = ew_HtmlEncode(BusinessDetails.mileskm.AdvancedSearch.SearchValue)
			BusinessDetails.mileskm.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.mileskm.FldCaption))

			' worldpaylive
			BusinessDetails.worldpaylive.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.worldpaylive.EditCustomAttributes = ""
			BusinessDetails.worldpaylive.EditValue = ew_HtmlEncode(BusinessDetails.worldpaylive.AdvancedSearch.SearchValue)
			BusinessDetails.worldpaylive.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.worldpaylive.FldCaption))

			' worldpayinstallationid
			BusinessDetails.worldpayinstallationid.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.worldpayinstallationid.EditCustomAttributes = ""
			BusinessDetails.worldpayinstallationid.EditValue = ew_HtmlEncode(BusinessDetails.worldpayinstallationid.AdvancedSearch.SearchValue)
			BusinessDetails.worldpayinstallationid.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.worldpayinstallationid.FldCaption))

			' DistanceCalMethod
			BusinessDetails.DistanceCalMethod.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.DistanceCalMethod.EditCustomAttributes = ""
			BusinessDetails.DistanceCalMethod.EditValue = ew_HtmlEncode(BusinessDetails.DistanceCalMethod.AdvancedSearch.SearchValue)
			BusinessDetails.DistanceCalMethod.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.DistanceCalMethod.FldCaption))

			' PrinterIDList
			BusinessDetails.PrinterIDList.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.PrinterIDList.EditCustomAttributes = ""
			BusinessDetails.PrinterIDList.EditValue = ew_HtmlEncode(BusinessDetails.PrinterIDList.AdvancedSearch.SearchValue)
			BusinessDetails.PrinterIDList.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.PrinterIDList.FldCaption))

			' EpsonJSPrinterURL
			BusinessDetails.EpsonJSPrinterURL.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.EpsonJSPrinterURL.EditCustomAttributes = ""
			BusinessDetails.EpsonJSPrinterURL.EditValue = ew_HtmlEncode(BusinessDetails.EpsonJSPrinterURL.AdvancedSearch.SearchValue)
			BusinessDetails.EpsonJSPrinterURL.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.EpsonJSPrinterURL.FldCaption))

			' SMSEnable
			BusinessDetails.SMSEnable.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.SMSEnable.EditCustomAttributes = ""
			BusinessDetails.SMSEnable.EditValue = ew_HtmlEncode(BusinessDetails.SMSEnable.AdvancedSearch.SearchValue)
			BusinessDetails.SMSEnable.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.SMSEnable.FldCaption))

			' SMSOnDelivery
			BusinessDetails.SMSOnDelivery.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.SMSOnDelivery.EditCustomAttributes = ""
			BusinessDetails.SMSOnDelivery.EditValue = ew_HtmlEncode(BusinessDetails.SMSOnDelivery.AdvancedSearch.SearchValue)
			BusinessDetails.SMSOnDelivery.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.SMSOnDelivery.FldCaption))

			' SMSSupplierDomain
			BusinessDetails.SMSSupplierDomain.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.SMSSupplierDomain.EditCustomAttributes = ""
			BusinessDetails.SMSSupplierDomain.EditValue = ew_HtmlEncode(BusinessDetails.SMSSupplierDomain.AdvancedSearch.SearchValue)
			BusinessDetails.SMSSupplierDomain.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.SMSSupplierDomain.FldCaption))

			' SMSOnOrder
			BusinessDetails.SMSOnOrder.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.SMSOnOrder.EditCustomAttributes = ""
			BusinessDetails.SMSOnOrder.EditValue = ew_HtmlEncode(BusinessDetails.SMSOnOrder.AdvancedSearch.SearchValue)
			BusinessDetails.SMSOnOrder.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.SMSOnOrder.FldCaption))

			' SMSOnOrderAfterMin
			BusinessDetails.SMSOnOrderAfterMin.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.SMSOnOrderAfterMin.EditCustomAttributes = ""
			BusinessDetails.SMSOnOrderAfterMin.EditValue = ew_HtmlEncode(BusinessDetails.SMSOnOrderAfterMin.AdvancedSearch.SearchValue)
			BusinessDetails.SMSOnOrderAfterMin.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.SMSOnOrderAfterMin.FldCaption))

			' SMSOnOrderContent
			BusinessDetails.SMSOnOrderContent.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.SMSOnOrderContent.EditCustomAttributes = ""
			BusinessDetails.SMSOnOrderContent.EditValue = ew_HtmlEncode(BusinessDetails.SMSOnOrderContent.AdvancedSearch.SearchValue)
			BusinessDetails.SMSOnOrderContent.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.SMSOnOrderContent.FldCaption))

			' DefaultSMSCountryCode
			BusinessDetails.DefaultSMSCountryCode.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.DefaultSMSCountryCode.EditCustomAttributes = ""
			BusinessDetails.DefaultSMSCountryCode.EditValue = ew_HtmlEncode(BusinessDetails.DefaultSMSCountryCode.AdvancedSearch.SearchValue)
			BusinessDetails.DefaultSMSCountryCode.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.DefaultSMSCountryCode.FldCaption))

			' MinimumAmountForCardPayment
			BusinessDetails.MinimumAmountForCardPayment.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.MinimumAmountForCardPayment.EditCustomAttributes = ""
			BusinessDetails.MinimumAmountForCardPayment.EditValue = ew_HtmlEncode(BusinessDetails.MinimumAmountForCardPayment.AdvancedSearch.SearchValue)
			BusinessDetails.MinimumAmountForCardPayment.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.MinimumAmountForCardPayment.FldCaption))

			' FavIconUrl
			BusinessDetails.FavIconUrl.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.FavIconUrl.EditCustomAttributes = ""
			BusinessDetails.FavIconUrl.EditValue = ew_HtmlEncode(BusinessDetails.FavIconUrl.AdvancedSearch.SearchValue)
			BusinessDetails.FavIconUrl.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.FavIconUrl.FldCaption))

			' AddToHomeScreenURL
			BusinessDetails.AddToHomeScreenURL.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.AddToHomeScreenURL.EditCustomAttributes = ""
			BusinessDetails.AddToHomeScreenURL.EditValue = ew_HtmlEncode(BusinessDetails.AddToHomeScreenURL.AdvancedSearch.SearchValue)
			BusinessDetails.AddToHomeScreenURL.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.AddToHomeScreenURL.FldCaption))

			' SMSOnAcknowledgement
			BusinessDetails.SMSOnAcknowledgement.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.SMSOnAcknowledgement.EditCustomAttributes = ""
			BusinessDetails.SMSOnAcknowledgement.EditValue = ew_HtmlEncode(BusinessDetails.SMSOnAcknowledgement.AdvancedSearch.SearchValue)
			BusinessDetails.SMSOnAcknowledgement.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.SMSOnAcknowledgement.FldCaption))

			' LocalPrinterURL
			BusinessDetails.LocalPrinterURL.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.LocalPrinterURL.EditCustomAttributes = ""
			BusinessDetails.LocalPrinterURL.EditValue = ew_HtmlEncode(BusinessDetails.LocalPrinterURL.AdvancedSearch.SearchValue)
			BusinessDetails.LocalPrinterURL.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.LocalPrinterURL.FldCaption))

			' ShowRestaurantDetailOnReceipt
			BusinessDetails.ShowRestaurantDetailOnReceipt.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.ShowRestaurantDetailOnReceipt.EditCustomAttributes = ""
			BusinessDetails.ShowRestaurantDetailOnReceipt.EditValue = ew_HtmlEncode(BusinessDetails.ShowRestaurantDetailOnReceipt.AdvancedSearch.SearchValue)
			BusinessDetails.ShowRestaurantDetailOnReceipt.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.ShowRestaurantDetailOnReceipt.FldCaption))

			' PrinterFontSizeRatio
			BusinessDetails.PrinterFontSizeRatio.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.PrinterFontSizeRatio.EditCustomAttributes = ""
			BusinessDetails.PrinterFontSizeRatio.EditValue = ew_HtmlEncode(BusinessDetails.PrinterFontSizeRatio.AdvancedSearch.SearchValue)
			BusinessDetails.PrinterFontSizeRatio.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.PrinterFontSizeRatio.FldCaption))

			' ServiceChargePercentage
			BusinessDetails.ServiceChargePercentage.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.ServiceChargePercentage.EditCustomAttributes = ""
			BusinessDetails.ServiceChargePercentage.EditValue = ew_HtmlEncode(BusinessDetails.ServiceChargePercentage.AdvancedSearch.SearchValue)
			BusinessDetails.ServiceChargePercentage.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.ServiceChargePercentage.FldCaption))

			' InRestaurantServiceChargeOnly
			BusinessDetails.InRestaurantServiceChargeOnly.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.InRestaurantServiceChargeOnly.EditCustomAttributes = ""
			BusinessDetails.InRestaurantServiceChargeOnly.EditValue = ew_HtmlEncode(BusinessDetails.InRestaurantServiceChargeOnly.AdvancedSearch.SearchValue)
			BusinessDetails.InRestaurantServiceChargeOnly.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.InRestaurantServiceChargeOnly.FldCaption))

			' IsDualReceiptPrinting
			BusinessDetails.IsDualReceiptPrinting.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.IsDualReceiptPrinting.EditCustomAttributes = ""
			BusinessDetails.IsDualReceiptPrinting.EditValue = ew_HtmlEncode(BusinessDetails.IsDualReceiptPrinting.AdvancedSearch.SearchValue)
			BusinessDetails.IsDualReceiptPrinting.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.IsDualReceiptPrinting.FldCaption))

			' PrintingFontSize
			BusinessDetails.PrintingFontSize.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.PrintingFontSize.EditCustomAttributes = ""
			BusinessDetails.PrintingFontSize.EditValue = ew_HtmlEncode(BusinessDetails.PrintingFontSize.AdvancedSearch.SearchValue)
			BusinessDetails.PrintingFontSize.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.PrintingFontSize.FldCaption))

			' InRestaurantEpsonPrinterIDList
			BusinessDetails.InRestaurantEpsonPrinterIDList.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.InRestaurantEpsonPrinterIDList.EditCustomAttributes = ""
			BusinessDetails.InRestaurantEpsonPrinterIDList.EditValue = ew_HtmlEncode(BusinessDetails.InRestaurantEpsonPrinterIDList.AdvancedSearch.SearchValue)
			BusinessDetails.InRestaurantEpsonPrinterIDList.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.InRestaurantEpsonPrinterIDList.FldCaption))

			' BlockIPEmailList
			BusinessDetails.BlockIPEmailList.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.BlockIPEmailList.EditCustomAttributes = ""
			BusinessDetails.BlockIPEmailList.EditValue = ew_HtmlEncode(BusinessDetails.BlockIPEmailList.AdvancedSearch.SearchValue)
			BusinessDetails.BlockIPEmailList.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.BlockIPEmailList.FldCaption))

			' inmenuannouncement
			BusinessDetails.inmenuannouncement.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.inmenuannouncement.EditCustomAttributes = ""
			BusinessDetails.inmenuannouncement.EditValue = ew_HtmlEncode(BusinessDetails.inmenuannouncement.AdvancedSearch.SearchValue)
			BusinessDetails.inmenuannouncement.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.inmenuannouncement.FldCaption))

			' RePrintReceiptWays
			BusinessDetails.RePrintReceiptWays.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.RePrintReceiptWays.EditCustomAttributes = ""
			BusinessDetails.RePrintReceiptWays.EditValue = ew_HtmlEncode(BusinessDetails.RePrintReceiptWays.AdvancedSearch.SearchValue)
			BusinessDetails.RePrintReceiptWays.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.RePrintReceiptWays.FldCaption))

			' printingtype
			BusinessDetails.printingtype.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.printingtype.EditCustomAttributes = ""
			BusinessDetails.printingtype.EditValue = ew_HtmlEncode(BusinessDetails.printingtype.AdvancedSearch.SearchValue)
			BusinessDetails.printingtype.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.printingtype.FldCaption))

			' Stripe_Key_Secret
			BusinessDetails.Stripe_Key_Secret.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Stripe_Key_Secret.EditCustomAttributes = ""
			BusinessDetails.Stripe_Key_Secret.EditValue = ew_HtmlEncode(BusinessDetails.Stripe_Key_Secret.AdvancedSearch.SearchValue)
			BusinessDetails.Stripe_Key_Secret.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Stripe_Key_Secret.FldCaption))

			' Stripe
			BusinessDetails.Stripe.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Stripe.EditCustomAttributes = ""
			BusinessDetails.Stripe.EditValue = ew_HtmlEncode(BusinessDetails.Stripe.AdvancedSearch.SearchValue)
			BusinessDetails.Stripe.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Stripe.FldCaption))

			' Stripe_Api_Key
			BusinessDetails.Stripe_Api_Key.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Stripe_Api_Key.EditCustomAttributes = ""
			BusinessDetails.Stripe_Api_Key.EditValue = ew_HtmlEncode(BusinessDetails.Stripe_Api_Key.AdvancedSearch.SearchValue)
			BusinessDetails.Stripe_Api_Key.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Stripe_Api_Key.FldCaption))

			' EnableBooking
			BusinessDetails.EnableBooking.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.EnableBooking.EditCustomAttributes = ""
			BusinessDetails.EnableBooking.EditValue = ew_HtmlEncode(BusinessDetails.EnableBooking.AdvancedSearch.SearchValue)
			BusinessDetails.EnableBooking.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.EnableBooking.FldCaption))

			' URL_Facebook
			BusinessDetails.URL_Facebook.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.URL_Facebook.EditCustomAttributes = ""
			BusinessDetails.URL_Facebook.EditValue = ew_HtmlEncode(BusinessDetails.URL_Facebook.AdvancedSearch.SearchValue)
			BusinessDetails.URL_Facebook.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.URL_Facebook.FldCaption))

			' URL_Twitter
			BusinessDetails.URL_Twitter.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.URL_Twitter.EditCustomAttributes = ""
			BusinessDetails.URL_Twitter.EditValue = ew_HtmlEncode(BusinessDetails.URL_Twitter.AdvancedSearch.SearchValue)
			BusinessDetails.URL_Twitter.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.URL_Twitter.FldCaption))

			' URL_Google
			BusinessDetails.URL_Google.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.URL_Google.EditCustomAttributes = ""
			BusinessDetails.URL_Google.EditValue = ew_HtmlEncode(BusinessDetails.URL_Google.AdvancedSearch.SearchValue)
			BusinessDetails.URL_Google.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.URL_Google.FldCaption))

			' URL_Intagram
			BusinessDetails.URL_Intagram.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.URL_Intagram.EditCustomAttributes = ""
			BusinessDetails.URL_Intagram.EditValue = ew_HtmlEncode(BusinessDetails.URL_Intagram.AdvancedSearch.SearchValue)
			BusinessDetails.URL_Intagram.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.URL_Intagram.FldCaption))

			' URL_YouTube
			BusinessDetails.URL_YouTube.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.URL_YouTube.EditCustomAttributes = ""
			BusinessDetails.URL_YouTube.EditValue = ew_HtmlEncode(BusinessDetails.URL_YouTube.AdvancedSearch.SearchValue)
			BusinessDetails.URL_YouTube.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.URL_YouTube.FldCaption))

			' URL_Tripadvisor
			BusinessDetails.URL_Tripadvisor.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.URL_Tripadvisor.EditCustomAttributes = ""
			BusinessDetails.URL_Tripadvisor.EditValue = ew_HtmlEncode(BusinessDetails.URL_Tripadvisor.AdvancedSearch.SearchValue)
			BusinessDetails.URL_Tripadvisor.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.URL_Tripadvisor.FldCaption))

			' URL_Special_Offer
			BusinessDetails.URL_Special_Offer.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.URL_Special_Offer.EditCustomAttributes = ""
			BusinessDetails.URL_Special_Offer.EditValue = ew_HtmlEncode(BusinessDetails.URL_Special_Offer.AdvancedSearch.SearchValue)
			BusinessDetails.URL_Special_Offer.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.URL_Special_Offer.FldCaption))

			' URL_Linkin
			BusinessDetails.URL_Linkin.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.URL_Linkin.EditCustomAttributes = ""
			BusinessDetails.URL_Linkin.EditValue = ew_HtmlEncode(BusinessDetails.URL_Linkin.AdvancedSearch.SearchValue)
			BusinessDetails.URL_Linkin.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.URL_Linkin.FldCaption))

			' Currency_PAYPAL
			BusinessDetails.Currency_PAYPAL.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Currency_PAYPAL.EditCustomAttributes = ""
			BusinessDetails.Currency_PAYPAL.EditValue = ew_HtmlEncode(BusinessDetails.Currency_PAYPAL.AdvancedSearch.SearchValue)
			BusinessDetails.Currency_PAYPAL.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Currency_PAYPAL.FldCaption))

			' Currency_STRIPE
			BusinessDetails.Currency_STRIPE.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Currency_STRIPE.EditCustomAttributes = ""
			BusinessDetails.Currency_STRIPE.EditValue = ew_HtmlEncode(BusinessDetails.Currency_STRIPE.AdvancedSearch.SearchValue)
			BusinessDetails.Currency_STRIPE.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Currency_STRIPE.FldCaption))

			' Currency_WOLRDPAY
			BusinessDetails.Currency_WOLRDPAY.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Currency_WOLRDPAY.EditCustomAttributes = ""
			BusinessDetails.Currency_WOLRDPAY.EditValue = ew_HtmlEncode(BusinessDetails.Currency_WOLRDPAY.AdvancedSearch.SearchValue)
			BusinessDetails.Currency_WOLRDPAY.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Currency_WOLRDPAY.FldCaption))

			' Tip_percent
			BusinessDetails.Tip_percent.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Tip_percent.EditCustomAttributes = ""
			BusinessDetails.Tip_percent.EditValue = ew_HtmlEncode(BusinessDetails.Tip_percent.AdvancedSearch.SearchValue)
			BusinessDetails.Tip_percent.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Tip_percent.FldCaption))

			' Tax_Percent
			BusinessDetails.Tax_Percent.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Tax_Percent.EditCustomAttributes = ""
			BusinessDetails.Tax_Percent.EditValue = ew_HtmlEncode(BusinessDetails.Tax_Percent.AdvancedSearch.SearchValue)
			BusinessDetails.Tax_Percent.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Tax_Percent.FldCaption))

			' InRestaurantTaxChargeOnly
			BusinessDetails.InRestaurantTaxChargeOnly.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.InRestaurantTaxChargeOnly.EditCustomAttributes = ""
			BusinessDetails.InRestaurantTaxChargeOnly.EditValue = ew_HtmlEncode(BusinessDetails.InRestaurantTaxChargeOnly.AdvancedSearch.SearchValue)
			BusinessDetails.InRestaurantTaxChargeOnly.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.InRestaurantTaxChargeOnly.FldCaption))

			' InRestaurantTipChargeOnly
			BusinessDetails.InRestaurantTipChargeOnly.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.InRestaurantTipChargeOnly.EditCustomAttributes = ""
			BusinessDetails.InRestaurantTipChargeOnly.EditValue = ew_HtmlEncode(BusinessDetails.InRestaurantTipChargeOnly.AdvancedSearch.SearchValue)
			BusinessDetails.InRestaurantTipChargeOnly.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.InRestaurantTipChargeOnly.FldCaption))

			' isCheckCapcha
			BusinessDetails.isCheckCapcha.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.isCheckCapcha.EditCustomAttributes = ""
			BusinessDetails.isCheckCapcha.EditValue = ew_HtmlEncode(BusinessDetails.isCheckCapcha.AdvancedSearch.SearchValue)
			BusinessDetails.isCheckCapcha.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.isCheckCapcha.FldCaption))

			' Close_StartDate
			BusinessDetails.Close_StartDate.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Close_StartDate.EditCustomAttributes = ""
			BusinessDetails.Close_StartDate.EditValue = ew_HtmlEncode(BusinessDetails.Close_StartDate.AdvancedSearch.SearchValue)
			BusinessDetails.Close_StartDate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Close_StartDate.FldCaption))

			' Close_EndDate
			BusinessDetails.Close_EndDate.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Close_EndDate.EditCustomAttributes = ""
			BusinessDetails.Close_EndDate.EditValue = ew_HtmlEncode(BusinessDetails.Close_EndDate.AdvancedSearch.SearchValue)
			BusinessDetails.Close_EndDate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Close_EndDate.FldCaption))

			' Stripe_Country
			BusinessDetails.Stripe_Country.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Stripe_Country.EditCustomAttributes = ""
			BusinessDetails.Stripe_Country.EditValue = ew_HtmlEncode(BusinessDetails.Stripe_Country.AdvancedSearch.SearchValue)
			BusinessDetails.Stripe_Country.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Stripe_Country.FldCaption))

			' enable_StripePaymentButton
			BusinessDetails.enable_StripePaymentButton.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.enable_StripePaymentButton.EditCustomAttributes = ""
			BusinessDetails.enable_StripePaymentButton.EditValue = ew_HtmlEncode(BusinessDetails.enable_StripePaymentButton.AdvancedSearch.SearchValue)
			BusinessDetails.enable_StripePaymentButton.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.enable_StripePaymentButton.FldCaption))

			' enable_CashPayment
			BusinessDetails.enable_CashPayment.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.enable_CashPayment.EditCustomAttributes = ""
			BusinessDetails.enable_CashPayment.EditValue = ew_HtmlEncode(BusinessDetails.enable_CashPayment.AdvancedSearch.SearchValue)
			BusinessDetails.enable_CashPayment.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.enable_CashPayment.FldCaption))

			' DeliveryMile
			BusinessDetails.DeliveryMile.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.DeliveryMile.EditCustomAttributes = ""
			BusinessDetails.DeliveryMile.EditValue = ew_HtmlEncode(BusinessDetails.DeliveryMile.AdvancedSearch.SearchValue)
			BusinessDetails.DeliveryMile.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.DeliveryMile.FldCaption))

			' Mon_Delivery
			BusinessDetails.Mon_Delivery.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Mon_Delivery.EditCustomAttributes = ""
			BusinessDetails.Mon_Delivery.EditValue = ew_HtmlEncode(BusinessDetails.Mon_Delivery.AdvancedSearch.SearchValue)
			BusinessDetails.Mon_Delivery.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Mon_Delivery.FldCaption))

			' Mon_Collection
			BusinessDetails.Mon_Collection.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Mon_Collection.EditCustomAttributes = ""
			BusinessDetails.Mon_Collection.EditValue = ew_HtmlEncode(BusinessDetails.Mon_Collection.AdvancedSearch.SearchValue)
			BusinessDetails.Mon_Collection.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Mon_Collection.FldCaption))

			' Tue_Delivery
			BusinessDetails.Tue_Delivery.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Tue_Delivery.EditCustomAttributes = ""
			BusinessDetails.Tue_Delivery.EditValue = ew_HtmlEncode(BusinessDetails.Tue_Delivery.AdvancedSearch.SearchValue)
			BusinessDetails.Tue_Delivery.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Tue_Delivery.FldCaption))

			' Tue_Collection
			BusinessDetails.Tue_Collection.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Tue_Collection.EditCustomAttributes = ""
			BusinessDetails.Tue_Collection.EditValue = ew_HtmlEncode(BusinessDetails.Tue_Collection.AdvancedSearch.SearchValue)
			BusinessDetails.Tue_Collection.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Tue_Collection.FldCaption))

			' Wed_Delivery
			BusinessDetails.Wed_Delivery.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Wed_Delivery.EditCustomAttributes = ""
			BusinessDetails.Wed_Delivery.EditValue = ew_HtmlEncode(BusinessDetails.Wed_Delivery.AdvancedSearch.SearchValue)
			BusinessDetails.Wed_Delivery.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Wed_Delivery.FldCaption))

			' Wed_Collection
			BusinessDetails.Wed_Collection.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Wed_Collection.EditCustomAttributes = ""
			BusinessDetails.Wed_Collection.EditValue = ew_HtmlEncode(BusinessDetails.Wed_Collection.AdvancedSearch.SearchValue)
			BusinessDetails.Wed_Collection.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Wed_Collection.FldCaption))

			' Thu_Delivery
			BusinessDetails.Thu_Delivery.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Thu_Delivery.EditCustomAttributes = ""
			BusinessDetails.Thu_Delivery.EditValue = ew_HtmlEncode(BusinessDetails.Thu_Delivery.AdvancedSearch.SearchValue)
			BusinessDetails.Thu_Delivery.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Thu_Delivery.FldCaption))

			' Thu_Collection
			BusinessDetails.Thu_Collection.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Thu_Collection.EditCustomAttributes = ""
			BusinessDetails.Thu_Collection.EditValue = ew_HtmlEncode(BusinessDetails.Thu_Collection.AdvancedSearch.SearchValue)
			BusinessDetails.Thu_Collection.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Thu_Collection.FldCaption))

			' Fri_Delivery
			BusinessDetails.Fri_Delivery.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Fri_Delivery.EditCustomAttributes = ""
			BusinessDetails.Fri_Delivery.EditValue = ew_HtmlEncode(BusinessDetails.Fri_Delivery.AdvancedSearch.SearchValue)
			BusinessDetails.Fri_Delivery.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Fri_Delivery.FldCaption))

			' Fri_Collection
			BusinessDetails.Fri_Collection.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Fri_Collection.EditCustomAttributes = ""
			BusinessDetails.Fri_Collection.EditValue = ew_HtmlEncode(BusinessDetails.Fri_Collection.AdvancedSearch.SearchValue)
			BusinessDetails.Fri_Collection.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Fri_Collection.FldCaption))

			' Sat_Delivery
			BusinessDetails.Sat_Delivery.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Sat_Delivery.EditCustomAttributes = ""
			BusinessDetails.Sat_Delivery.EditValue = ew_HtmlEncode(BusinessDetails.Sat_Delivery.AdvancedSearch.SearchValue)
			BusinessDetails.Sat_Delivery.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Sat_Delivery.FldCaption))

			' Sat_Collection
			BusinessDetails.Sat_Collection.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Sat_Collection.EditCustomAttributes = ""
			BusinessDetails.Sat_Collection.EditValue = ew_HtmlEncode(BusinessDetails.Sat_Collection.AdvancedSearch.SearchValue)
			BusinessDetails.Sat_Collection.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Sat_Collection.FldCaption))

			' Sun_Delivery
			BusinessDetails.Sun_Delivery.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Sun_Delivery.EditCustomAttributes = ""
			BusinessDetails.Sun_Delivery.EditValue = ew_HtmlEncode(BusinessDetails.Sun_Delivery.AdvancedSearch.SearchValue)
			BusinessDetails.Sun_Delivery.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Sun_Delivery.FldCaption))

			' Sun_Collection
			BusinessDetails.Sun_Collection.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Sun_Collection.EditCustomAttributes = ""
			BusinessDetails.Sun_Collection.EditValue = ew_HtmlEncode(BusinessDetails.Sun_Collection.AdvancedSearch.SearchValue)
			BusinessDetails.Sun_Collection.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Sun_Collection.FldCaption))

			' EnableUrlRewrite
			BusinessDetails.EnableUrlRewrite.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.EnableUrlRewrite.EditCustomAttributes = ""
			BusinessDetails.EnableUrlRewrite.EditValue = ew_HtmlEncode(BusinessDetails.EnableUrlRewrite.AdvancedSearch.SearchValue)
			BusinessDetails.EnableUrlRewrite.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.EnableUrlRewrite.FldCaption))

			' DeliveryCostUpTo
			BusinessDetails.DeliveryCostUpTo.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.DeliveryCostUpTo.EditCustomAttributes = ""
			BusinessDetails.DeliveryCostUpTo.EditValue = ew_HtmlEncode(BusinessDetails.DeliveryCostUpTo.AdvancedSearch.SearchValue)
			BusinessDetails.DeliveryCostUpTo.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.DeliveryCostUpTo.FldCaption))

			' DeliveryUptoMile
			BusinessDetails.DeliveryUptoMile.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.DeliveryUptoMile.EditCustomAttributes = ""
			BusinessDetails.DeliveryUptoMile.EditValue = ew_HtmlEncode(BusinessDetails.DeliveryUptoMile.AdvancedSearch.SearchValue)
			BusinessDetails.DeliveryUptoMile.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.DeliveryUptoMile.FldCaption))

			' Show_Ordernumner_printer
			BusinessDetails.Show_Ordernumner_printer.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Show_Ordernumner_printer.EditCustomAttributes = ""
			BusinessDetails.Show_Ordernumner_printer.EditValue = ew_HtmlEncode(BusinessDetails.Show_Ordernumner_printer.AdvancedSearch.SearchValue)
			BusinessDetails.Show_Ordernumner_printer.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Show_Ordernumner_printer.FldCaption))

			' Show_Ordernumner_Receipt
			BusinessDetails.Show_Ordernumner_Receipt.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Show_Ordernumner_Receipt.EditCustomAttributes = ""
			BusinessDetails.Show_Ordernumner_Receipt.EditValue = ew_HtmlEncode(BusinessDetails.Show_Ordernumner_Receipt.AdvancedSearch.SearchValue)
			BusinessDetails.Show_Ordernumner_Receipt.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Show_Ordernumner_Receipt.FldCaption))

			' Show_Ordernumner_Dashboard
			BusinessDetails.Show_Ordernumner_Dashboard.EditAttrs.UpdateAttribute "class", "form-control"
			BusinessDetails.Show_Ordernumner_Dashboard.EditCustomAttributes = ""
			BusinessDetails.Show_Ordernumner_Dashboard.EditValue = ew_HtmlEncode(BusinessDetails.Show_Ordernumner_Dashboard.AdvancedSearch.SearchValue)
			BusinessDetails.Show_Ordernumner_Dashboard.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BusinessDetails.Show_Ordernumner_Dashboard.FldCaption))
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
		If Not ew_CheckInteger(BusinessDetails.ID.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.ID.FldErrMsg)
		End If
		If Not ew_CheckInteger(BusinessDetails.DeliveryMinAmount.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.DeliveryMinAmount.FldErrMsg)
		End If
		If Not ew_CheckNumber(BusinessDetails.DeliveryMaxDistance.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.DeliveryMaxDistance.FldErrMsg)
		End If
		If Not ew_CheckNumber(BusinessDetails.DeliveryFreeDistance.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.DeliveryFreeDistance.FldErrMsg)
		End If
		If Not ew_CheckInteger(BusinessDetails.AverageDeliveryTime.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.AverageDeliveryTime.FldErrMsg)
		End If
		If Not ew_CheckInteger(BusinessDetails.AverageCollectionTime.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.AverageCollectionTime.FldErrMsg)
		End If
		If Not ew_CheckNumber(BusinessDetails.DeliveryFee.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.DeliveryFee.FldErrMsg)
		End If
		If Not ew_CheckInteger(BusinessDetails.businessclosed.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.businessclosed.FldErrMsg)
		End If
		If Not ew_CheckInteger(BusinessDetails.timezone.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.timezone.FldErrMsg)
		End If
		If Not ew_CheckInteger(BusinessDetails.individualpostcodeschecking.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.individualpostcodeschecking.FldErrMsg)
		End If
		If Not ew_CheckInteger(BusinessDetails.orderonlywhenopen.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.orderonlywhenopen.FldErrMsg)
		End If
		If Not ew_CheckInteger(BusinessDetails.disablelaterdelivery.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.disablelaterdelivery.FldErrMsg)
		End If
		If Not ew_CheckInteger(BusinessDetails.ordertodayonly.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.ordertodayonly.FldErrMsg)
		End If
		If Not ew_CheckInteger(BusinessDetails.worldpaylive.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.worldpaylive.FldErrMsg)
		End If
		If Not ew_CheckInteger(BusinessDetails.SMSEnable.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.SMSEnable.FldErrMsg)
		End If
		If Not ew_CheckInteger(BusinessDetails.SMSOnDelivery.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.SMSOnDelivery.FldErrMsg)
		End If
		If Not ew_CheckInteger(BusinessDetails.SMSOnOrder.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.SMSOnOrder.FldErrMsg)
		End If
		If Not ew_CheckInteger(BusinessDetails.SMSOnOrderAfterMin.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.SMSOnOrderAfterMin.FldErrMsg)
		End If
		If Not ew_CheckNumber(BusinessDetails.MinimumAmountForCardPayment.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.MinimumAmountForCardPayment.FldErrMsg)
		End If
		If Not ew_CheckInteger(BusinessDetails.SMSOnAcknowledgement.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.SMSOnAcknowledgement.FldErrMsg)
		End If
		If Not ew_CheckInteger(BusinessDetails.ShowRestaurantDetailOnReceipt.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.ShowRestaurantDetailOnReceipt.FldErrMsg)
		End If
		If Not ew_CheckNumber(BusinessDetails.PrinterFontSizeRatio.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.PrinterFontSizeRatio.FldErrMsg)
		End If
		If Not ew_CheckNumber(BusinessDetails.ServiceChargePercentage.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.ServiceChargePercentage.FldErrMsg)
		End If
		If Not ew_CheckInteger(BusinessDetails.InRestaurantServiceChargeOnly.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.InRestaurantServiceChargeOnly.FldErrMsg)
		End If
		If Not ew_CheckInteger(BusinessDetails.IsDualReceiptPrinting.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.IsDualReceiptPrinting.FldErrMsg)
		End If
		If Not ew_CheckNumber(BusinessDetails.PrintingFontSize.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.PrintingFontSize.FldErrMsg)
		End If
		If Not ew_CheckInteger(BusinessDetails.Tip_percent.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.Tip_percent.FldErrMsg)
		End If
		If Not ew_CheckInteger(BusinessDetails.Tax_Percent.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.Tax_Percent.FldErrMsg)
		End If
		If Not ew_CheckInteger(BusinessDetails.InRestaurantTaxChargeOnly.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.InRestaurantTaxChargeOnly.FldErrMsg)
		End If
		If Not ew_CheckInteger(BusinessDetails.InRestaurantTipChargeOnly.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.InRestaurantTipChargeOnly.FldErrMsg)
		End If
		If Not ew_CheckNumber(BusinessDetails.DeliveryMile.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.DeliveryMile.FldErrMsg)
		End If
		If Not ew_CheckInteger(BusinessDetails.Mon_Delivery.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.Mon_Delivery.FldErrMsg)
		End If
		If Not ew_CheckInteger(BusinessDetails.Mon_Collection.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.Mon_Collection.FldErrMsg)
		End If
		If Not ew_CheckInteger(BusinessDetails.Tue_Delivery.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.Tue_Delivery.FldErrMsg)
		End If
		If Not ew_CheckInteger(BusinessDetails.Tue_Collection.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.Tue_Collection.FldErrMsg)
		End If
		If Not ew_CheckInteger(BusinessDetails.Wed_Delivery.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.Wed_Delivery.FldErrMsg)
		End If
		If Not ew_CheckInteger(BusinessDetails.Wed_Collection.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.Wed_Collection.FldErrMsg)
		End If
		If Not ew_CheckInteger(BusinessDetails.Thu_Delivery.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.Thu_Delivery.FldErrMsg)
		End If
		If Not ew_CheckInteger(BusinessDetails.Thu_Collection.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.Thu_Collection.FldErrMsg)
		End If
		If Not ew_CheckInteger(BusinessDetails.Fri_Delivery.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.Fri_Delivery.FldErrMsg)
		End If
		If Not ew_CheckInteger(BusinessDetails.Fri_Collection.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.Fri_Collection.FldErrMsg)
		End If
		If Not ew_CheckInteger(BusinessDetails.Sat_Delivery.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.Sat_Delivery.FldErrMsg)
		End If
		If Not ew_CheckInteger(BusinessDetails.Sat_Collection.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.Sat_Collection.FldErrMsg)
		End If
		If Not ew_CheckInteger(BusinessDetails.Sun_Delivery.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.Sun_Delivery.FldErrMsg)
		End If
		If Not ew_CheckInteger(BusinessDetails.Sun_Collection.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.Sun_Collection.FldErrMsg)
		End If
		If Not ew_CheckNumber(BusinessDetails.DeliveryCostUpTo.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.DeliveryCostUpTo.FldErrMsg)
		End If
		If Not ew_CheckNumber(BusinessDetails.DeliveryUptoMile.AdvancedSearch.SearchValue) Then
			Call ew_AddMessage(gsSearchError, BusinessDetails.DeliveryUptoMile.FldErrMsg)
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
		Call BusinessDetails.ID.AdvancedSearch.Load()
		Call BusinessDetails.Name.AdvancedSearch.Load()
		Call BusinessDetails.Address.AdvancedSearch.Load()
		Call BusinessDetails.PostalCode.AdvancedSearch.Load()
		Call BusinessDetails.FoodType.AdvancedSearch.Load()
		Call BusinessDetails.DeliveryMinAmount.AdvancedSearch.Load()
		Call BusinessDetails.DeliveryMaxDistance.AdvancedSearch.Load()
		Call BusinessDetails.DeliveryFreeDistance.AdvancedSearch.Load()
		Call BusinessDetails.AverageDeliveryTime.AdvancedSearch.Load()
		Call BusinessDetails.AverageCollectionTime.AdvancedSearch.Load()
		Call BusinessDetails.DeliveryFee.AdvancedSearch.Load()
		Call BusinessDetails.ImgUrl.AdvancedSearch.Load()
		Call BusinessDetails.Telephone.AdvancedSearch.Load()
		Call BusinessDetails.zEmail.AdvancedSearch.Load()
		Call BusinessDetails.pswd.AdvancedSearch.Load()
		Call BusinessDetails.businessclosed.AdvancedSearch.Load()
		Call BusinessDetails.announcement.AdvancedSearch.Load()
		Call BusinessDetails.css.AdvancedSearch.Load()
		Call BusinessDetails.SMTP_AUTENTICATE.AdvancedSearch.Load()
		Call BusinessDetails.MAIL_FROM.AdvancedSearch.Load()
		Call BusinessDetails.PAYPAL_URL.AdvancedSearch.Load()
		Call BusinessDetails.PAYPAL_PDT.AdvancedSearch.Load()
		Call BusinessDetails.SMTP_PASSWORD.AdvancedSearch.Load()
		Call BusinessDetails.GMAP_API_KEY.AdvancedSearch.Load()
		Call BusinessDetails.SMTP_USERNAME.AdvancedSearch.Load()
		Call BusinessDetails.SMTP_USESSL.AdvancedSearch.Load()
		Call BusinessDetails.MAIL_SUBJECT.AdvancedSearch.Load()
		Call BusinessDetails.CURRENCYSYMBOL.AdvancedSearch.Load()
		Call BusinessDetails.SMTP_SERVER.AdvancedSearch.Load()
		Call BusinessDetails.CREDITCARDSURCHARGE.AdvancedSearch.Load()
		Call BusinessDetails.SMTP_PORT.AdvancedSearch.Load()
		Call BusinessDetails.STICK_MENU.AdvancedSearch.Load()
		Call BusinessDetails.MAIL_CUSTOMER_SUBJECT.AdvancedSearch.Load()
		Call BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.AdvancedSearch.Load()
		Call BusinessDetails.SEND_ORDERS_TO_PRINTER.AdvancedSearch.Load()
		Call BusinessDetails.timezone.AdvancedSearch.Load()
		Call BusinessDetails.PAYPAL_ADDR.AdvancedSearch.Load()
		Call BusinessDetails.nochex.AdvancedSearch.Load()
		Call BusinessDetails.nochexmerchantid.AdvancedSearch.Load()
		Call BusinessDetails.paypal.AdvancedSearch.Load()
		Call BusinessDetails.IBT_API_KEY.AdvancedSearch.Load()
		Call BusinessDetails.IBP_API_PASSWORD.AdvancedSearch.Load()
		Call BusinessDetails.disable_delivery.AdvancedSearch.Load()
		Call BusinessDetails.disable_collection.AdvancedSearch.Load()
		Call BusinessDetails.worldpay.AdvancedSearch.Load()
		Call BusinessDetails.worldpaymerchantid.AdvancedSearch.Load()
		Call BusinessDetails.backtohometext.AdvancedSearch.Load()
		Call BusinessDetails.closedtext.AdvancedSearch.Load()
		Call BusinessDetails.DeliveryChargeOverrideByOrderValue.AdvancedSearch.Load()
		Call BusinessDetails.individualpostcodes.AdvancedSearch.Load()
		Call BusinessDetails.individualpostcodeschecking.AdvancedSearch.Load()
		Call BusinessDetails.longitude.AdvancedSearch.Load()
		Call BusinessDetails.latitude.AdvancedSearch.Load()
		Call BusinessDetails.googleecommercetracking.AdvancedSearch.Load()
		Call BusinessDetails.googleecommercetrackingcode.AdvancedSearch.Load()
		Call BusinessDetails.bringg.AdvancedSearch.Load()
		Call BusinessDetails.bringgurl.AdvancedSearch.Load()
		Call BusinessDetails.bringgcompanyid.AdvancedSearch.Load()
		Call BusinessDetails.orderonlywhenopen.AdvancedSearch.Load()
		Call BusinessDetails.disablelaterdelivery.AdvancedSearch.Load()
		Call BusinessDetails.menupagetext.AdvancedSearch.Load()
		Call BusinessDetails.ordertodayonly.AdvancedSearch.Load()
		Call BusinessDetails.mileskm.AdvancedSearch.Load()
		Call BusinessDetails.worldpaylive.AdvancedSearch.Load()
		Call BusinessDetails.worldpayinstallationid.AdvancedSearch.Load()
		Call BusinessDetails.DistanceCalMethod.AdvancedSearch.Load()
		Call BusinessDetails.PrinterIDList.AdvancedSearch.Load()
		Call BusinessDetails.EpsonJSPrinterURL.AdvancedSearch.Load()
		Call BusinessDetails.SMSEnable.AdvancedSearch.Load()
		Call BusinessDetails.SMSOnDelivery.AdvancedSearch.Load()
		Call BusinessDetails.SMSSupplierDomain.AdvancedSearch.Load()
		Call BusinessDetails.SMSOnOrder.AdvancedSearch.Load()
		Call BusinessDetails.SMSOnOrderAfterMin.AdvancedSearch.Load()
		Call BusinessDetails.SMSOnOrderContent.AdvancedSearch.Load()
		Call BusinessDetails.DefaultSMSCountryCode.AdvancedSearch.Load()
		Call BusinessDetails.MinimumAmountForCardPayment.AdvancedSearch.Load()
		Call BusinessDetails.FavIconUrl.AdvancedSearch.Load()
		Call BusinessDetails.AddToHomeScreenURL.AdvancedSearch.Load()
		Call BusinessDetails.SMSOnAcknowledgement.AdvancedSearch.Load()
		Call BusinessDetails.LocalPrinterURL.AdvancedSearch.Load()
		Call BusinessDetails.ShowRestaurantDetailOnReceipt.AdvancedSearch.Load()
		Call BusinessDetails.PrinterFontSizeRatio.AdvancedSearch.Load()
		Call BusinessDetails.ServiceChargePercentage.AdvancedSearch.Load()
		Call BusinessDetails.InRestaurantServiceChargeOnly.AdvancedSearch.Load()
		Call BusinessDetails.IsDualReceiptPrinting.AdvancedSearch.Load()
		Call BusinessDetails.PrintingFontSize.AdvancedSearch.Load()
		Call BusinessDetails.InRestaurantEpsonPrinterIDList.AdvancedSearch.Load()
		Call BusinessDetails.BlockIPEmailList.AdvancedSearch.Load()
		Call BusinessDetails.inmenuannouncement.AdvancedSearch.Load()
		Call BusinessDetails.RePrintReceiptWays.AdvancedSearch.Load()
		Call BusinessDetails.printingtype.AdvancedSearch.Load()
		Call BusinessDetails.Stripe_Key_Secret.AdvancedSearch.Load()
		Call BusinessDetails.Stripe.AdvancedSearch.Load()
		Call BusinessDetails.Stripe_Api_Key.AdvancedSearch.Load()
		Call BusinessDetails.EnableBooking.AdvancedSearch.Load()
		Call BusinessDetails.URL_Facebook.AdvancedSearch.Load()
		Call BusinessDetails.URL_Twitter.AdvancedSearch.Load()
		Call BusinessDetails.URL_Google.AdvancedSearch.Load()
		Call BusinessDetails.URL_Intagram.AdvancedSearch.Load()
		Call BusinessDetails.URL_YouTube.AdvancedSearch.Load()
		Call BusinessDetails.URL_Tripadvisor.AdvancedSearch.Load()
		Call BusinessDetails.URL_Special_Offer.AdvancedSearch.Load()
		Call BusinessDetails.URL_Linkin.AdvancedSearch.Load()
		Call BusinessDetails.Currency_PAYPAL.AdvancedSearch.Load()
		Call BusinessDetails.Currency_STRIPE.AdvancedSearch.Load()
		Call BusinessDetails.Currency_WOLRDPAY.AdvancedSearch.Load()
		Call BusinessDetails.Tip_percent.AdvancedSearch.Load()
		Call BusinessDetails.Tax_Percent.AdvancedSearch.Load()
		Call BusinessDetails.InRestaurantTaxChargeOnly.AdvancedSearch.Load()
		Call BusinessDetails.InRestaurantTipChargeOnly.AdvancedSearch.Load()
		Call BusinessDetails.isCheckCapcha.AdvancedSearch.Load()
		Call BusinessDetails.Close_StartDate.AdvancedSearch.Load()
		Call BusinessDetails.Close_EndDate.AdvancedSearch.Load()
		Call BusinessDetails.Stripe_Country.AdvancedSearch.Load()
		Call BusinessDetails.enable_StripePaymentButton.AdvancedSearch.Load()
		Call BusinessDetails.enable_CashPayment.AdvancedSearch.Load()
		Call BusinessDetails.DeliveryMile.AdvancedSearch.Load()
		Call BusinessDetails.Mon_Delivery.AdvancedSearch.Load()
		Call BusinessDetails.Mon_Collection.AdvancedSearch.Load()
		Call BusinessDetails.Tue_Delivery.AdvancedSearch.Load()
		Call BusinessDetails.Tue_Collection.AdvancedSearch.Load()
		Call BusinessDetails.Wed_Delivery.AdvancedSearch.Load()
		Call BusinessDetails.Wed_Collection.AdvancedSearch.Load()
		Call BusinessDetails.Thu_Delivery.AdvancedSearch.Load()
		Call BusinessDetails.Thu_Collection.AdvancedSearch.Load()
		Call BusinessDetails.Fri_Delivery.AdvancedSearch.Load()
		Call BusinessDetails.Fri_Collection.AdvancedSearch.Load()
		Call BusinessDetails.Sat_Delivery.AdvancedSearch.Load()
		Call BusinessDetails.Sat_Collection.AdvancedSearch.Load()
		Call BusinessDetails.Sun_Delivery.AdvancedSearch.Load()
		Call BusinessDetails.Sun_Collection.AdvancedSearch.Load()
		Call BusinessDetails.EnableUrlRewrite.AdvancedSearch.Load()
		Call BusinessDetails.DeliveryCostUpTo.AdvancedSearch.Load()
		Call BusinessDetails.DeliveryUptoMile.AdvancedSearch.Load()
		Call BusinessDetails.Show_Ordernumner_printer.AdvancedSearch.Load()
		Call BusinessDetails.Show_Ordernumner_Receipt.AdvancedSearch.Load()
		Call BusinessDetails.Show_Ordernumner_Dashboard.AdvancedSearch.Load()
End Function

	' Set up Breadcrumb
	Sub SetupBreadcrumb()
		Dim PageId, url
		Set Breadcrumb = New cBreadcrumb
		url = Mid(ew_CurrentUrl, InStrRev(ew_CurrentUrl, "/")+1)
		Call Breadcrumb.Add("list", BusinessDetails.TableVar, "BusinessDetailslist.asp", "", BusinessDetails.TableVar, True)
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
