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
Dim BusinessDetails_delete
Set BusinessDetails_delete = New cBusinessDetails_delete
Set Page = BusinessDetails_delete

' Page init processing
BusinessDetails_delete.Page_Init()

' Page main processing
BusinessDetails_delete.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
BusinessDetails_delete.Page_Render()
%>
<!--#include file="header.asp"-->
<script type="text/javascript">
// Page object
var BusinessDetails_delete = new ew_Page("BusinessDetails_delete");
BusinessDetails_delete.PageID = "delete"; // Page ID
var EW_PAGE_ID = BusinessDetails_delete.PageID; // For backward compatibility
// Form object
var fBusinessDetailsdelete = new ew_Form("fBusinessDetailsdelete");
// Form_CustomValidate event
fBusinessDetailsdelete.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fBusinessDetailsdelete.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fBusinessDetailsdelete.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<%

' Load records for display
Set BusinessDetails_delete.Recordset = BusinessDetails_delete.LoadRecordset()
BusinessDetails_delete.TotalRecs = BusinessDetails_delete.Recordset.RecordCount ' Get record count
If BusinessDetails_delete.TotalRecs <= 0 Then ' No record found, exit
	BusinessDetails_delete.Recordset.Close
	Set BusinessDetails_delete.Recordset = Nothing
	Call BusinessDetails_delete.Page_Terminate("BusinessDetailslist.asp") ' Return to list
End If
%>
<div class="ewToolbar">
<% If BusinessDetails.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<% If BusinessDetails.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% BusinessDetails_delete.ShowPageHeader() %>
<% BusinessDetails_delete.ShowMessage %>
<form name="fBusinessDetailsdelete" id="fBusinessDetailsdelete" class="form-inline ewForm ewDeleteForm" action="<%= ew_CurrentPage() %>" method="post">
<% If BusinessDetails_delete.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= BusinessDetails_delete.Token %>">
<% End If %>
<input type="hidden" name="t" value="BusinessDetails">
<input type="hidden" name="a_delete" id="a_delete" value="D">
<% For i = 0 to UBound(BusinessDetails_delete.RecKeys) %>
<input type="hidden" name="key_m" id="key_m" value="<%= ew_HtmlEncode(ew_GetKeyValue(BusinessDetails_delete.RecKeys(i))) %>">
<% Next %>
<div class="ewGrid">
<div class="<% If ew_IsResponsiveLayout() Then Response.Write "table-responsive " %>ewGridMiddlePanel">
<table class="table ewTable">
<%= BusinessDetails.TableCustomInnerHtml %>
	<thead>
	<tr class="ewTableHeader">
<% If BusinessDetails.ID.Visible Then ' ID %>
		<th><span id="elh_BusinessDetails_ID" class="BusinessDetails_ID"><%= BusinessDetails.ID.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.Name.Visible Then ' Name %>
		<th><span id="elh_BusinessDetails_Name" class="BusinessDetails_Name"><%= BusinessDetails.Name.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.Address.Visible Then ' Address %>
		<th><span id="elh_BusinessDetails_Address" class="BusinessDetails_Address"><%= BusinessDetails.Address.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.PostalCode.Visible Then ' PostalCode %>
		<th><span id="elh_BusinessDetails_PostalCode" class="BusinessDetails_PostalCode"><%= BusinessDetails.PostalCode.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.FoodType.Visible Then ' FoodType %>
		<th><span id="elh_BusinessDetails_FoodType" class="BusinessDetails_FoodType"><%= BusinessDetails.FoodType.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.DeliveryMinAmount.Visible Then ' DeliveryMinAmount %>
		<th><span id="elh_BusinessDetails_DeliveryMinAmount" class="BusinessDetails_DeliveryMinAmount"><%= BusinessDetails.DeliveryMinAmount.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.DeliveryMaxDistance.Visible Then ' DeliveryMaxDistance %>
		<th><span id="elh_BusinessDetails_DeliveryMaxDistance" class="BusinessDetails_DeliveryMaxDistance"><%= BusinessDetails.DeliveryMaxDistance.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.DeliveryFreeDistance.Visible Then ' DeliveryFreeDistance %>
		<th><span id="elh_BusinessDetails_DeliveryFreeDistance" class="BusinessDetails_DeliveryFreeDistance"><%= BusinessDetails.DeliveryFreeDistance.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.AverageDeliveryTime.Visible Then ' AverageDeliveryTime %>
		<th><span id="elh_BusinessDetails_AverageDeliveryTime" class="BusinessDetails_AverageDeliveryTime"><%= BusinessDetails.AverageDeliveryTime.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.AverageCollectionTime.Visible Then ' AverageCollectionTime %>
		<th><span id="elh_BusinessDetails_AverageCollectionTime" class="BusinessDetails_AverageCollectionTime"><%= BusinessDetails.AverageCollectionTime.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.DeliveryFee.Visible Then ' DeliveryFee %>
		<th><span id="elh_BusinessDetails_DeliveryFee" class="BusinessDetails_DeliveryFee"><%= BusinessDetails.DeliveryFee.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.ImgUrl.Visible Then ' ImgUrl %>
		<th><span id="elh_BusinessDetails_ImgUrl" class="BusinessDetails_ImgUrl"><%= BusinessDetails.ImgUrl.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.Telephone.Visible Then ' Telephone %>
		<th><span id="elh_BusinessDetails_Telephone" class="BusinessDetails_Telephone"><%= BusinessDetails.Telephone.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.zEmail.Visible Then ' Email %>
		<th><span id="elh_BusinessDetails_zEmail" class="BusinessDetails_zEmail"><%= BusinessDetails.zEmail.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.pswd.Visible Then ' pswd %>
		<th><span id="elh_BusinessDetails_pswd" class="BusinessDetails_pswd"><%= BusinessDetails.pswd.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.businessclosed.Visible Then ' businessclosed %>
		<th><span id="elh_BusinessDetails_businessclosed" class="BusinessDetails_businessclosed"><%= BusinessDetails.businessclosed.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.SMTP_AUTENTICATE.Visible Then ' SMTP_AUTENTICATE %>
		<th><span id="elh_BusinessDetails_SMTP_AUTENTICATE" class="BusinessDetails_SMTP_AUTENTICATE"><%= BusinessDetails.SMTP_AUTENTICATE.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.MAIL_FROM.Visible Then ' MAIL_FROM %>
		<th><span id="elh_BusinessDetails_MAIL_FROM" class="BusinessDetails_MAIL_FROM"><%= BusinessDetails.MAIL_FROM.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.PAYPAL_URL.Visible Then ' PAYPAL_URL %>
		<th><span id="elh_BusinessDetails_PAYPAL_URL" class="BusinessDetails_PAYPAL_URL"><%= BusinessDetails.PAYPAL_URL.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.PAYPAL_PDT.Visible Then ' PAYPAL_PDT %>
		<th><span id="elh_BusinessDetails_PAYPAL_PDT" class="BusinessDetails_PAYPAL_PDT"><%= BusinessDetails.PAYPAL_PDT.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.SMTP_PASSWORD.Visible Then ' SMTP_PASSWORD %>
		<th><span id="elh_BusinessDetails_SMTP_PASSWORD" class="BusinessDetails_SMTP_PASSWORD"><%= BusinessDetails.SMTP_PASSWORD.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.GMAP_API_KEY.Visible Then ' GMAP_API_KEY %>
		<th><span id="elh_BusinessDetails_GMAP_API_KEY" class="BusinessDetails_GMAP_API_KEY"><%= BusinessDetails.GMAP_API_KEY.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.SMTP_USERNAME.Visible Then ' SMTP_USERNAME %>
		<th><span id="elh_BusinessDetails_SMTP_USERNAME" class="BusinessDetails_SMTP_USERNAME"><%= BusinessDetails.SMTP_USERNAME.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.SMTP_USESSL.Visible Then ' SMTP_USESSL %>
		<th><span id="elh_BusinessDetails_SMTP_USESSL" class="BusinessDetails_SMTP_USESSL"><%= BusinessDetails.SMTP_USESSL.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.MAIL_SUBJECT.Visible Then ' MAIL_SUBJECT %>
		<th><span id="elh_BusinessDetails_MAIL_SUBJECT" class="BusinessDetails_MAIL_SUBJECT"><%= BusinessDetails.MAIL_SUBJECT.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.CURRENCYSYMBOL.Visible Then ' CURRENCYSYMBOL %>
		<th><span id="elh_BusinessDetails_CURRENCYSYMBOL" class="BusinessDetails_CURRENCYSYMBOL"><%= BusinessDetails.CURRENCYSYMBOL.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.SMTP_SERVER.Visible Then ' SMTP_SERVER %>
		<th><span id="elh_BusinessDetails_SMTP_SERVER" class="BusinessDetails_SMTP_SERVER"><%= BusinessDetails.SMTP_SERVER.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.CREDITCARDSURCHARGE.Visible Then ' CREDITCARDSURCHARGE %>
		<th><span id="elh_BusinessDetails_CREDITCARDSURCHARGE" class="BusinessDetails_CREDITCARDSURCHARGE"><%= BusinessDetails.CREDITCARDSURCHARGE.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.SMTP_PORT.Visible Then ' SMTP_PORT %>
		<th><span id="elh_BusinessDetails_SMTP_PORT" class="BusinessDetails_SMTP_PORT"><%= BusinessDetails.SMTP_PORT.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.STICK_MENU.Visible Then ' STICK_MENU %>
		<th><span id="elh_BusinessDetails_STICK_MENU" class="BusinessDetails_STICK_MENU"><%= BusinessDetails.STICK_MENU.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.MAIL_CUSTOMER_SUBJECT.Visible Then ' MAIL_CUSTOMER_SUBJECT %>
		<th><span id="elh_BusinessDetails_MAIL_CUSTOMER_SUBJECT" class="BusinessDetails_MAIL_CUSTOMER_SUBJECT"><%= BusinessDetails.MAIL_CUSTOMER_SUBJECT.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.Visible Then ' CONFIRMATION_EMAIL_ADDRESS %>
		<th><span id="elh_BusinessDetails_CONFIRMATION_EMAIL_ADDRESS" class="BusinessDetails_CONFIRMATION_EMAIL_ADDRESS"><%= BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.SEND_ORDERS_TO_PRINTER.Visible Then ' SEND_ORDERS_TO_PRINTER %>
		<th><span id="elh_BusinessDetails_SEND_ORDERS_TO_PRINTER" class="BusinessDetails_SEND_ORDERS_TO_PRINTER"><%= BusinessDetails.SEND_ORDERS_TO_PRINTER.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.timezone.Visible Then ' timezone %>
		<th><span id="elh_BusinessDetails_timezone" class="BusinessDetails_timezone"><%= BusinessDetails.timezone.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.PAYPAL_ADDR.Visible Then ' PAYPAL_ADDR %>
		<th><span id="elh_BusinessDetails_PAYPAL_ADDR" class="BusinessDetails_PAYPAL_ADDR"><%= BusinessDetails.PAYPAL_ADDR.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.nochex.Visible Then ' nochex %>
		<th><span id="elh_BusinessDetails_nochex" class="BusinessDetails_nochex"><%= BusinessDetails.nochex.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.nochexmerchantid.Visible Then ' nochexmerchantid %>
		<th><span id="elh_BusinessDetails_nochexmerchantid" class="BusinessDetails_nochexmerchantid"><%= BusinessDetails.nochexmerchantid.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.paypal.Visible Then ' paypal %>
		<th><span id="elh_BusinessDetails_paypal" class="BusinessDetails_paypal"><%= BusinessDetails.paypal.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.IBT_API_KEY.Visible Then ' IBT_API_KEY %>
		<th><span id="elh_BusinessDetails_IBT_API_KEY" class="BusinessDetails_IBT_API_KEY"><%= BusinessDetails.IBT_API_KEY.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.IBP_API_PASSWORD.Visible Then ' IBP_API_PASSWORD %>
		<th><span id="elh_BusinessDetails_IBP_API_PASSWORD" class="BusinessDetails_IBP_API_PASSWORD"><%= BusinessDetails.IBP_API_PASSWORD.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.disable_delivery.Visible Then ' disable_delivery %>
		<th><span id="elh_BusinessDetails_disable_delivery" class="BusinessDetails_disable_delivery"><%= BusinessDetails.disable_delivery.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.disable_collection.Visible Then ' disable_collection %>
		<th><span id="elh_BusinessDetails_disable_collection" class="BusinessDetails_disable_collection"><%= BusinessDetails.disable_collection.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.worldpay.Visible Then ' worldpay %>
		<th><span id="elh_BusinessDetails_worldpay" class="BusinessDetails_worldpay"><%= BusinessDetails.worldpay.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.worldpaymerchantid.Visible Then ' worldpaymerchantid %>
		<th><span id="elh_BusinessDetails_worldpaymerchantid" class="BusinessDetails_worldpaymerchantid"><%= BusinessDetails.worldpaymerchantid.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.DeliveryChargeOverrideByOrderValue.Visible Then ' DeliveryChargeOverrideByOrderValue %>
		<th><span id="elh_BusinessDetails_DeliveryChargeOverrideByOrderValue" class="BusinessDetails_DeliveryChargeOverrideByOrderValue"><%= BusinessDetails.DeliveryChargeOverrideByOrderValue.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.individualpostcodeschecking.Visible Then ' individualpostcodeschecking %>
		<th><span id="elh_BusinessDetails_individualpostcodeschecking" class="BusinessDetails_individualpostcodeschecking"><%= BusinessDetails.individualpostcodeschecking.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.longitude.Visible Then ' longitude %>
		<th><span id="elh_BusinessDetails_longitude" class="BusinessDetails_longitude"><%= BusinessDetails.longitude.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.latitude.Visible Then ' latitude %>
		<th><span id="elh_BusinessDetails_latitude" class="BusinessDetails_latitude"><%= BusinessDetails.latitude.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.googleecommercetracking.Visible Then ' googleecommercetracking %>
		<th><span id="elh_BusinessDetails_googleecommercetracking" class="BusinessDetails_googleecommercetracking"><%= BusinessDetails.googleecommercetracking.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.googleecommercetrackingcode.Visible Then ' googleecommercetrackingcode %>
		<th><span id="elh_BusinessDetails_googleecommercetrackingcode" class="BusinessDetails_googleecommercetrackingcode"><%= BusinessDetails.googleecommercetrackingcode.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.bringg.Visible Then ' bringg %>
		<th><span id="elh_BusinessDetails_bringg" class="BusinessDetails_bringg"><%= BusinessDetails.bringg.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.bringgurl.Visible Then ' bringgurl %>
		<th><span id="elh_BusinessDetails_bringgurl" class="BusinessDetails_bringgurl"><%= BusinessDetails.bringgurl.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.bringgcompanyid.Visible Then ' bringgcompanyid %>
		<th><span id="elh_BusinessDetails_bringgcompanyid" class="BusinessDetails_bringgcompanyid"><%= BusinessDetails.bringgcompanyid.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.orderonlywhenopen.Visible Then ' orderonlywhenopen %>
		<th><span id="elh_BusinessDetails_orderonlywhenopen" class="BusinessDetails_orderonlywhenopen"><%= BusinessDetails.orderonlywhenopen.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.disablelaterdelivery.Visible Then ' disablelaterdelivery %>
		<th><span id="elh_BusinessDetails_disablelaterdelivery" class="BusinessDetails_disablelaterdelivery"><%= BusinessDetails.disablelaterdelivery.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.ordertodayonly.Visible Then ' ordertodayonly %>
		<th><span id="elh_BusinessDetails_ordertodayonly" class="BusinessDetails_ordertodayonly"><%= BusinessDetails.ordertodayonly.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.mileskm.Visible Then ' mileskm %>
		<th><span id="elh_BusinessDetails_mileskm" class="BusinessDetails_mileskm"><%= BusinessDetails.mileskm.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.worldpaylive.Visible Then ' worldpaylive %>
		<th><span id="elh_BusinessDetails_worldpaylive" class="BusinessDetails_worldpaylive"><%= BusinessDetails.worldpaylive.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.worldpayinstallationid.Visible Then ' worldpayinstallationid %>
		<th><span id="elh_BusinessDetails_worldpayinstallationid" class="BusinessDetails_worldpayinstallationid"><%= BusinessDetails.worldpayinstallationid.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.DistanceCalMethod.Visible Then ' DistanceCalMethod %>
		<th><span id="elh_BusinessDetails_DistanceCalMethod" class="BusinessDetails_DistanceCalMethod"><%= BusinessDetails.DistanceCalMethod.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.PrinterIDList.Visible Then ' PrinterIDList %>
		<th><span id="elh_BusinessDetails_PrinterIDList" class="BusinessDetails_PrinterIDList"><%= BusinessDetails.PrinterIDList.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.EpsonJSPrinterURL.Visible Then ' EpsonJSPrinterURL %>
		<th><span id="elh_BusinessDetails_EpsonJSPrinterURL" class="BusinessDetails_EpsonJSPrinterURL"><%= BusinessDetails.EpsonJSPrinterURL.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.SMSEnable.Visible Then ' SMSEnable %>
		<th><span id="elh_BusinessDetails_SMSEnable" class="BusinessDetails_SMSEnable"><%= BusinessDetails.SMSEnable.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.SMSOnDelivery.Visible Then ' SMSOnDelivery %>
		<th><span id="elh_BusinessDetails_SMSOnDelivery" class="BusinessDetails_SMSOnDelivery"><%= BusinessDetails.SMSOnDelivery.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.SMSSupplierDomain.Visible Then ' SMSSupplierDomain %>
		<th><span id="elh_BusinessDetails_SMSSupplierDomain" class="BusinessDetails_SMSSupplierDomain"><%= BusinessDetails.SMSSupplierDomain.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.SMSOnOrder.Visible Then ' SMSOnOrder %>
		<th><span id="elh_BusinessDetails_SMSOnOrder" class="BusinessDetails_SMSOnOrder"><%= BusinessDetails.SMSOnOrder.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.SMSOnOrderAfterMin.Visible Then ' SMSOnOrderAfterMin %>
		<th><span id="elh_BusinessDetails_SMSOnOrderAfterMin" class="BusinessDetails_SMSOnOrderAfterMin"><%= BusinessDetails.SMSOnOrderAfterMin.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.SMSOnOrderContent.Visible Then ' SMSOnOrderContent %>
		<th><span id="elh_BusinessDetails_SMSOnOrderContent" class="BusinessDetails_SMSOnOrderContent"><%= BusinessDetails.SMSOnOrderContent.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.DefaultSMSCountryCode.Visible Then ' DefaultSMSCountryCode %>
		<th><span id="elh_BusinessDetails_DefaultSMSCountryCode" class="BusinessDetails_DefaultSMSCountryCode"><%= BusinessDetails.DefaultSMSCountryCode.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.MinimumAmountForCardPayment.Visible Then ' MinimumAmountForCardPayment %>
		<th><span id="elh_BusinessDetails_MinimumAmountForCardPayment" class="BusinessDetails_MinimumAmountForCardPayment"><%= BusinessDetails.MinimumAmountForCardPayment.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.FavIconUrl.Visible Then ' FavIconUrl %>
		<th><span id="elh_BusinessDetails_FavIconUrl" class="BusinessDetails_FavIconUrl"><%= BusinessDetails.FavIconUrl.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.AddToHomeScreenURL.Visible Then ' AddToHomeScreenURL %>
		<th><span id="elh_BusinessDetails_AddToHomeScreenURL" class="BusinessDetails_AddToHomeScreenURL"><%= BusinessDetails.AddToHomeScreenURL.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.SMSOnAcknowledgement.Visible Then ' SMSOnAcknowledgement %>
		<th><span id="elh_BusinessDetails_SMSOnAcknowledgement" class="BusinessDetails_SMSOnAcknowledgement"><%= BusinessDetails.SMSOnAcknowledgement.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.LocalPrinterURL.Visible Then ' LocalPrinterURL %>
		<th><span id="elh_BusinessDetails_LocalPrinterURL" class="BusinessDetails_LocalPrinterURL"><%= BusinessDetails.LocalPrinterURL.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.ShowRestaurantDetailOnReceipt.Visible Then ' ShowRestaurantDetailOnReceipt %>
		<th><span id="elh_BusinessDetails_ShowRestaurantDetailOnReceipt" class="BusinessDetails_ShowRestaurantDetailOnReceipt"><%= BusinessDetails.ShowRestaurantDetailOnReceipt.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.PrinterFontSizeRatio.Visible Then ' PrinterFontSizeRatio %>
		<th><span id="elh_BusinessDetails_PrinterFontSizeRatio" class="BusinessDetails_PrinterFontSizeRatio"><%= BusinessDetails.PrinterFontSizeRatio.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.ServiceChargePercentage.Visible Then ' ServiceChargePercentage %>
		<th><span id="elh_BusinessDetails_ServiceChargePercentage" class="BusinessDetails_ServiceChargePercentage"><%= BusinessDetails.ServiceChargePercentage.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.InRestaurantServiceChargeOnly.Visible Then ' InRestaurantServiceChargeOnly %>
		<th><span id="elh_BusinessDetails_InRestaurantServiceChargeOnly" class="BusinessDetails_InRestaurantServiceChargeOnly"><%= BusinessDetails.InRestaurantServiceChargeOnly.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.IsDualReceiptPrinting.Visible Then ' IsDualReceiptPrinting %>
		<th><span id="elh_BusinessDetails_IsDualReceiptPrinting" class="BusinessDetails_IsDualReceiptPrinting"><%= BusinessDetails.IsDualReceiptPrinting.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.PrintingFontSize.Visible Then ' PrintingFontSize %>
		<th><span id="elh_BusinessDetails_PrintingFontSize" class="BusinessDetails_PrintingFontSize"><%= BusinessDetails.PrintingFontSize.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.InRestaurantEpsonPrinterIDList.Visible Then ' InRestaurantEpsonPrinterIDList %>
		<th><span id="elh_BusinessDetails_InRestaurantEpsonPrinterIDList" class="BusinessDetails_InRestaurantEpsonPrinterIDList"><%= BusinessDetails.InRestaurantEpsonPrinterIDList.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.BlockIPEmailList.Visible Then ' BlockIPEmailList %>
		<th><span id="elh_BusinessDetails_BlockIPEmailList" class="BusinessDetails_BlockIPEmailList"><%= BusinessDetails.BlockIPEmailList.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.RePrintReceiptWays.Visible Then ' RePrintReceiptWays %>
		<th><span id="elh_BusinessDetails_RePrintReceiptWays" class="BusinessDetails_RePrintReceiptWays"><%= BusinessDetails.RePrintReceiptWays.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.printingtype.Visible Then ' printingtype %>
		<th><span id="elh_BusinessDetails_printingtype" class="BusinessDetails_printingtype"><%= BusinessDetails.printingtype.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.Stripe_Key_Secret.Visible Then ' Stripe_Key_Secret %>
		<th><span id="elh_BusinessDetails_Stripe_Key_Secret" class="BusinessDetails_Stripe_Key_Secret"><%= BusinessDetails.Stripe_Key_Secret.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.Stripe.Visible Then ' Stripe %>
		<th><span id="elh_BusinessDetails_Stripe" class="BusinessDetails_Stripe"><%= BusinessDetails.Stripe.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.Stripe_Api_Key.Visible Then ' Stripe_Api_Key %>
		<th><span id="elh_BusinessDetails_Stripe_Api_Key" class="BusinessDetails_Stripe_Api_Key"><%= BusinessDetails.Stripe_Api_Key.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.EnableBooking.Visible Then ' EnableBooking %>
		<th><span id="elh_BusinessDetails_EnableBooking" class="BusinessDetails_EnableBooking"><%= BusinessDetails.EnableBooking.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.URL_Facebook.Visible Then ' URL_Facebook %>
		<th><span id="elh_BusinessDetails_URL_Facebook" class="BusinessDetails_URL_Facebook"><%= BusinessDetails.URL_Facebook.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.URL_Twitter.Visible Then ' URL_Twitter %>
		<th><span id="elh_BusinessDetails_URL_Twitter" class="BusinessDetails_URL_Twitter"><%= BusinessDetails.URL_Twitter.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.URL_Google.Visible Then ' URL_Google %>
		<th><span id="elh_BusinessDetails_URL_Google" class="BusinessDetails_URL_Google"><%= BusinessDetails.URL_Google.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.URL_Intagram.Visible Then ' URL_Intagram %>
		<th><span id="elh_BusinessDetails_URL_Intagram" class="BusinessDetails_URL_Intagram"><%= BusinessDetails.URL_Intagram.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.URL_YouTube.Visible Then ' URL_YouTube %>
		<th><span id="elh_BusinessDetails_URL_YouTube" class="BusinessDetails_URL_YouTube"><%= BusinessDetails.URL_YouTube.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.URL_Tripadvisor.Visible Then ' URL_Tripadvisor %>
		<th><span id="elh_BusinessDetails_URL_Tripadvisor" class="BusinessDetails_URL_Tripadvisor"><%= BusinessDetails.URL_Tripadvisor.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.URL_Special_Offer.Visible Then ' URL_Special_Offer %>
		<th><span id="elh_BusinessDetails_URL_Special_Offer" class="BusinessDetails_URL_Special_Offer"><%= BusinessDetails.URL_Special_Offer.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.URL_Linkin.Visible Then ' URL_Linkin %>
		<th><span id="elh_BusinessDetails_URL_Linkin" class="BusinessDetails_URL_Linkin"><%= BusinessDetails.URL_Linkin.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.Currency_PAYPAL.Visible Then ' Currency_PAYPAL %>
		<th><span id="elh_BusinessDetails_Currency_PAYPAL" class="BusinessDetails_Currency_PAYPAL"><%= BusinessDetails.Currency_PAYPAL.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.Currency_STRIPE.Visible Then ' Currency_STRIPE %>
		<th><span id="elh_BusinessDetails_Currency_STRIPE" class="BusinessDetails_Currency_STRIPE"><%= BusinessDetails.Currency_STRIPE.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.Currency_WOLRDPAY.Visible Then ' Currency_WOLRDPAY %>
		<th><span id="elh_BusinessDetails_Currency_WOLRDPAY" class="BusinessDetails_Currency_WOLRDPAY"><%= BusinessDetails.Currency_WOLRDPAY.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.Tip_percent.Visible Then ' Tip_percent %>
		<th><span id="elh_BusinessDetails_Tip_percent" class="BusinessDetails_Tip_percent"><%= BusinessDetails.Tip_percent.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.Tax_Percent.Visible Then ' Tax_Percent %>
		<th><span id="elh_BusinessDetails_Tax_Percent" class="BusinessDetails_Tax_Percent"><%= BusinessDetails.Tax_Percent.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.InRestaurantTaxChargeOnly.Visible Then ' InRestaurantTaxChargeOnly %>
		<th><span id="elh_BusinessDetails_InRestaurantTaxChargeOnly" class="BusinessDetails_InRestaurantTaxChargeOnly"><%= BusinessDetails.InRestaurantTaxChargeOnly.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.InRestaurantTipChargeOnly.Visible Then ' InRestaurantTipChargeOnly %>
		<th><span id="elh_BusinessDetails_InRestaurantTipChargeOnly" class="BusinessDetails_InRestaurantTipChargeOnly"><%= BusinessDetails.InRestaurantTipChargeOnly.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.isCheckCapcha.Visible Then ' isCheckCapcha %>
		<th><span id="elh_BusinessDetails_isCheckCapcha" class="BusinessDetails_isCheckCapcha"><%= BusinessDetails.isCheckCapcha.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.Close_StartDate.Visible Then ' Close_StartDate %>
		<th><span id="elh_BusinessDetails_Close_StartDate" class="BusinessDetails_Close_StartDate"><%= BusinessDetails.Close_StartDate.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.Close_EndDate.Visible Then ' Close_EndDate %>
		<th><span id="elh_BusinessDetails_Close_EndDate" class="BusinessDetails_Close_EndDate"><%= BusinessDetails.Close_EndDate.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.Stripe_Country.Visible Then ' Stripe_Country %>
		<th><span id="elh_BusinessDetails_Stripe_Country" class="BusinessDetails_Stripe_Country"><%= BusinessDetails.Stripe_Country.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.enable_StripePaymentButton.Visible Then ' enable_StripePaymentButton %>
		<th><span id="elh_BusinessDetails_enable_StripePaymentButton" class="BusinessDetails_enable_StripePaymentButton"><%= BusinessDetails.enable_StripePaymentButton.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.enable_CashPayment.Visible Then ' enable_CashPayment %>
		<th><span id="elh_BusinessDetails_enable_CashPayment" class="BusinessDetails_enable_CashPayment"><%= BusinessDetails.enable_CashPayment.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.DeliveryMile.Visible Then ' DeliveryMile %>
		<th><span id="elh_BusinessDetails_DeliveryMile" class="BusinessDetails_DeliveryMile"><%= BusinessDetails.DeliveryMile.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.Mon_Delivery.Visible Then ' Mon_Delivery %>
		<th><span id="elh_BusinessDetails_Mon_Delivery" class="BusinessDetails_Mon_Delivery"><%= BusinessDetails.Mon_Delivery.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.Mon_Collection.Visible Then ' Mon_Collection %>
		<th><span id="elh_BusinessDetails_Mon_Collection" class="BusinessDetails_Mon_Collection"><%= BusinessDetails.Mon_Collection.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.Tue_Delivery.Visible Then ' Tue_Delivery %>
		<th><span id="elh_BusinessDetails_Tue_Delivery" class="BusinessDetails_Tue_Delivery"><%= BusinessDetails.Tue_Delivery.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.Tue_Collection.Visible Then ' Tue_Collection %>
		<th><span id="elh_BusinessDetails_Tue_Collection" class="BusinessDetails_Tue_Collection"><%= BusinessDetails.Tue_Collection.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.Wed_Delivery.Visible Then ' Wed_Delivery %>
		<th><span id="elh_BusinessDetails_Wed_Delivery" class="BusinessDetails_Wed_Delivery"><%= BusinessDetails.Wed_Delivery.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.Wed_Collection.Visible Then ' Wed_Collection %>
		<th><span id="elh_BusinessDetails_Wed_Collection" class="BusinessDetails_Wed_Collection"><%= BusinessDetails.Wed_Collection.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.Thu_Delivery.Visible Then ' Thu_Delivery %>
		<th><span id="elh_BusinessDetails_Thu_Delivery" class="BusinessDetails_Thu_Delivery"><%= BusinessDetails.Thu_Delivery.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.Thu_Collection.Visible Then ' Thu_Collection %>
		<th><span id="elh_BusinessDetails_Thu_Collection" class="BusinessDetails_Thu_Collection"><%= BusinessDetails.Thu_Collection.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.Fri_Delivery.Visible Then ' Fri_Delivery %>
		<th><span id="elh_BusinessDetails_Fri_Delivery" class="BusinessDetails_Fri_Delivery"><%= BusinessDetails.Fri_Delivery.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.Fri_Collection.Visible Then ' Fri_Collection %>
		<th><span id="elh_BusinessDetails_Fri_Collection" class="BusinessDetails_Fri_Collection"><%= BusinessDetails.Fri_Collection.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.Sat_Delivery.Visible Then ' Sat_Delivery %>
		<th><span id="elh_BusinessDetails_Sat_Delivery" class="BusinessDetails_Sat_Delivery"><%= BusinessDetails.Sat_Delivery.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.Sat_Collection.Visible Then ' Sat_Collection %>
		<th><span id="elh_BusinessDetails_Sat_Collection" class="BusinessDetails_Sat_Collection"><%= BusinessDetails.Sat_Collection.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.Sun_Delivery.Visible Then ' Sun_Delivery %>
		<th><span id="elh_BusinessDetails_Sun_Delivery" class="BusinessDetails_Sun_Delivery"><%= BusinessDetails.Sun_Delivery.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.Sun_Collection.Visible Then ' Sun_Collection %>
		<th><span id="elh_BusinessDetails_Sun_Collection" class="BusinessDetails_Sun_Collection"><%= BusinessDetails.Sun_Collection.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.EnableUrlRewrite.Visible Then ' EnableUrlRewrite %>
		<th><span id="elh_BusinessDetails_EnableUrlRewrite" class="BusinessDetails_EnableUrlRewrite"><%= BusinessDetails.EnableUrlRewrite.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.DeliveryCostUpTo.Visible Then ' DeliveryCostUpTo %>
		<th><span id="elh_BusinessDetails_DeliveryCostUpTo" class="BusinessDetails_DeliveryCostUpTo"><%= BusinessDetails.DeliveryCostUpTo.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.DeliveryUptoMile.Visible Then ' DeliveryUptoMile %>
		<th><span id="elh_BusinessDetails_DeliveryUptoMile" class="BusinessDetails_DeliveryUptoMile"><%= BusinessDetails.DeliveryUptoMile.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.Show_Ordernumner_printer.Visible Then ' Show_Ordernumner_printer %>
		<th><span id="elh_BusinessDetails_Show_Ordernumner_printer" class="BusinessDetails_Show_Ordernumner_printer"><%= BusinessDetails.Show_Ordernumner_printer.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.Show_Ordernumner_Receipt.Visible Then ' Show_Ordernumner_Receipt %>
		<th><span id="elh_BusinessDetails_Show_Ordernumner_Receipt" class="BusinessDetails_Show_Ordernumner_Receipt"><%= BusinessDetails.Show_Ordernumner_Receipt.FldCaption %></span></th>
<% End If %>
<% If BusinessDetails.Show_Ordernumner_Dashboard.Visible Then ' Show_Ordernumner_Dashboard %>
		<th><span id="elh_BusinessDetails_Show_Ordernumner_Dashboard" class="BusinessDetails_Show_Ordernumner_Dashboard"><%= BusinessDetails.Show_Ordernumner_Dashboard.FldCaption %></span></th>
<% End If %>
	</tr>
	</thead>
	<tbody>
<%
BusinessDetails_delete.RecCnt = 0
BusinessDetails_delete.RowCnt = 0
Do While (Not BusinessDetails_delete.Recordset.Eof)
	BusinessDetails_delete.RecCnt = BusinessDetails_delete.RecCnt + 1
	BusinessDetails_delete.RowCnt = BusinessDetails_delete.RowCnt + 1

	' Set row properties
	Call BusinessDetails.ResetAttrs()
	BusinessDetails.RowType = EW_ROWTYPE_VIEW ' view

	' Get the field contents
	Call BusinessDetails_delete.LoadRowValues(BusinessDetails_delete.Recordset)

	' Render row
	Call BusinessDetails_delete.RenderRow()
%>
	<tr<%= BusinessDetails.RowAttributes %>>
<% If BusinessDetails.ID.Visible Then ' ID %>
		<td<%= BusinessDetails.ID.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_ID" class="form-group BusinessDetails_ID">
<span<%= BusinessDetails.ID.ViewAttributes %>>
<%= BusinessDetails.ID.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.Name.Visible Then ' Name %>
		<td<%= BusinessDetails.Name.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_Name" class="form-group BusinessDetails_Name">
<span<%= BusinessDetails.Name.ViewAttributes %>>
<%= BusinessDetails.Name.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.Address.Visible Then ' Address %>
		<td<%= BusinessDetails.Address.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_Address" class="form-group BusinessDetails_Address">
<span<%= BusinessDetails.Address.ViewAttributes %>>
<%= BusinessDetails.Address.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.PostalCode.Visible Then ' PostalCode %>
		<td<%= BusinessDetails.PostalCode.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_PostalCode" class="form-group BusinessDetails_PostalCode">
<span<%= BusinessDetails.PostalCode.ViewAttributes %>>
<%= BusinessDetails.PostalCode.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.FoodType.Visible Then ' FoodType %>
		<td<%= BusinessDetails.FoodType.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_FoodType" class="form-group BusinessDetails_FoodType">
<span<%= BusinessDetails.FoodType.ViewAttributes %>>
<%= BusinessDetails.FoodType.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.DeliveryMinAmount.Visible Then ' DeliveryMinAmount %>
		<td<%= BusinessDetails.DeliveryMinAmount.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_DeliveryMinAmount" class="form-group BusinessDetails_DeliveryMinAmount">
<span<%= BusinessDetails.DeliveryMinAmount.ViewAttributes %>>
<%= BusinessDetails.DeliveryMinAmount.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.DeliveryMaxDistance.Visible Then ' DeliveryMaxDistance %>
		<td<%= BusinessDetails.DeliveryMaxDistance.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_DeliveryMaxDistance" class="form-group BusinessDetails_DeliveryMaxDistance">
<span<%= BusinessDetails.DeliveryMaxDistance.ViewAttributes %>>
<%= BusinessDetails.DeliveryMaxDistance.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.DeliveryFreeDistance.Visible Then ' DeliveryFreeDistance %>
		<td<%= BusinessDetails.DeliveryFreeDistance.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_DeliveryFreeDistance" class="form-group BusinessDetails_DeliveryFreeDistance">
<span<%= BusinessDetails.DeliveryFreeDistance.ViewAttributes %>>
<%= BusinessDetails.DeliveryFreeDistance.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.AverageDeliveryTime.Visible Then ' AverageDeliveryTime %>
		<td<%= BusinessDetails.AverageDeliveryTime.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_AverageDeliveryTime" class="form-group BusinessDetails_AverageDeliveryTime">
<span<%= BusinessDetails.AverageDeliveryTime.ViewAttributes %>>
<%= BusinessDetails.AverageDeliveryTime.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.AverageCollectionTime.Visible Then ' AverageCollectionTime %>
		<td<%= BusinessDetails.AverageCollectionTime.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_AverageCollectionTime" class="form-group BusinessDetails_AverageCollectionTime">
<span<%= BusinessDetails.AverageCollectionTime.ViewAttributes %>>
<%= BusinessDetails.AverageCollectionTime.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.DeliveryFee.Visible Then ' DeliveryFee %>
		<td<%= BusinessDetails.DeliveryFee.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_DeliveryFee" class="form-group BusinessDetails_DeliveryFee">
<span<%= BusinessDetails.DeliveryFee.ViewAttributes %>>
<%= BusinessDetails.DeliveryFee.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.ImgUrl.Visible Then ' ImgUrl %>
		<td<%= BusinessDetails.ImgUrl.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_ImgUrl" class="form-group BusinessDetails_ImgUrl">
<span<%= BusinessDetails.ImgUrl.ViewAttributes %>>
<%= BusinessDetails.ImgUrl.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.Telephone.Visible Then ' Telephone %>
		<td<%= BusinessDetails.Telephone.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_Telephone" class="form-group BusinessDetails_Telephone">
<span<%= BusinessDetails.Telephone.ViewAttributes %>>
<%= BusinessDetails.Telephone.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.zEmail.Visible Then ' Email %>
		<td<%= BusinessDetails.zEmail.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_zEmail" class="form-group BusinessDetails_zEmail">
<span<%= BusinessDetails.zEmail.ViewAttributes %>>
<%= BusinessDetails.zEmail.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.pswd.Visible Then ' pswd %>
		<td<%= BusinessDetails.pswd.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_pswd" class="form-group BusinessDetails_pswd">
<span<%= BusinessDetails.pswd.ViewAttributes %>>
<%= BusinessDetails.pswd.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.businessclosed.Visible Then ' businessclosed %>
		<td<%= BusinessDetails.businessclosed.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_businessclosed" class="form-group BusinessDetails_businessclosed">
<span<%= BusinessDetails.businessclosed.ViewAttributes %>>
<%= BusinessDetails.businessclosed.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.SMTP_AUTENTICATE.Visible Then ' SMTP_AUTENTICATE %>
		<td<%= BusinessDetails.SMTP_AUTENTICATE.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_SMTP_AUTENTICATE" class="form-group BusinessDetails_SMTP_AUTENTICATE">
<span<%= BusinessDetails.SMTP_AUTENTICATE.ViewAttributes %>>
<%= BusinessDetails.SMTP_AUTENTICATE.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.MAIL_FROM.Visible Then ' MAIL_FROM %>
		<td<%= BusinessDetails.MAIL_FROM.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_MAIL_FROM" class="form-group BusinessDetails_MAIL_FROM">
<span<%= BusinessDetails.MAIL_FROM.ViewAttributes %>>
<%= BusinessDetails.MAIL_FROM.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.PAYPAL_URL.Visible Then ' PAYPAL_URL %>
		<td<%= BusinessDetails.PAYPAL_URL.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_PAYPAL_URL" class="form-group BusinessDetails_PAYPAL_URL">
<span<%= BusinessDetails.PAYPAL_URL.ViewAttributes %>>
<%= BusinessDetails.PAYPAL_URL.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.PAYPAL_PDT.Visible Then ' PAYPAL_PDT %>
		<td<%= BusinessDetails.PAYPAL_PDT.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_PAYPAL_PDT" class="form-group BusinessDetails_PAYPAL_PDT">
<span<%= BusinessDetails.PAYPAL_PDT.ViewAttributes %>>
<%= BusinessDetails.PAYPAL_PDT.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.SMTP_PASSWORD.Visible Then ' SMTP_PASSWORD %>
		<td<%= BusinessDetails.SMTP_PASSWORD.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_SMTP_PASSWORD" class="form-group BusinessDetails_SMTP_PASSWORD">
<span<%= BusinessDetails.SMTP_PASSWORD.ViewAttributes %>>
<%= BusinessDetails.SMTP_PASSWORD.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.GMAP_API_KEY.Visible Then ' GMAP_API_KEY %>
		<td<%= BusinessDetails.GMAP_API_KEY.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_GMAP_API_KEY" class="form-group BusinessDetails_GMAP_API_KEY">
<span<%= BusinessDetails.GMAP_API_KEY.ViewAttributes %>>
<%= BusinessDetails.GMAP_API_KEY.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.SMTP_USERNAME.Visible Then ' SMTP_USERNAME %>
		<td<%= BusinessDetails.SMTP_USERNAME.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_SMTP_USERNAME" class="form-group BusinessDetails_SMTP_USERNAME">
<span<%= BusinessDetails.SMTP_USERNAME.ViewAttributes %>>
<%= BusinessDetails.SMTP_USERNAME.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.SMTP_USESSL.Visible Then ' SMTP_USESSL %>
		<td<%= BusinessDetails.SMTP_USESSL.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_SMTP_USESSL" class="form-group BusinessDetails_SMTP_USESSL">
<span<%= BusinessDetails.SMTP_USESSL.ViewAttributes %>>
<%= BusinessDetails.SMTP_USESSL.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.MAIL_SUBJECT.Visible Then ' MAIL_SUBJECT %>
		<td<%= BusinessDetails.MAIL_SUBJECT.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_MAIL_SUBJECT" class="form-group BusinessDetails_MAIL_SUBJECT">
<span<%= BusinessDetails.MAIL_SUBJECT.ViewAttributes %>>
<%= BusinessDetails.MAIL_SUBJECT.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.CURRENCYSYMBOL.Visible Then ' CURRENCYSYMBOL %>
		<td<%= BusinessDetails.CURRENCYSYMBOL.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_CURRENCYSYMBOL" class="form-group BusinessDetails_CURRENCYSYMBOL">
<span<%= BusinessDetails.CURRENCYSYMBOL.ViewAttributes %>>
<%= BusinessDetails.CURRENCYSYMBOL.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.SMTP_SERVER.Visible Then ' SMTP_SERVER %>
		<td<%= BusinessDetails.SMTP_SERVER.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_SMTP_SERVER" class="form-group BusinessDetails_SMTP_SERVER">
<span<%= BusinessDetails.SMTP_SERVER.ViewAttributes %>>
<%= BusinessDetails.SMTP_SERVER.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.CREDITCARDSURCHARGE.Visible Then ' CREDITCARDSURCHARGE %>
		<td<%= BusinessDetails.CREDITCARDSURCHARGE.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_CREDITCARDSURCHARGE" class="form-group BusinessDetails_CREDITCARDSURCHARGE">
<span<%= BusinessDetails.CREDITCARDSURCHARGE.ViewAttributes %>>
<%= BusinessDetails.CREDITCARDSURCHARGE.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.SMTP_PORT.Visible Then ' SMTP_PORT %>
		<td<%= BusinessDetails.SMTP_PORT.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_SMTP_PORT" class="form-group BusinessDetails_SMTP_PORT">
<span<%= BusinessDetails.SMTP_PORT.ViewAttributes %>>
<%= BusinessDetails.SMTP_PORT.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.STICK_MENU.Visible Then ' STICK_MENU %>
		<td<%= BusinessDetails.STICK_MENU.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_STICK_MENU" class="form-group BusinessDetails_STICK_MENU">
<span<%= BusinessDetails.STICK_MENU.ViewAttributes %>>
<%= BusinessDetails.STICK_MENU.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.MAIL_CUSTOMER_SUBJECT.Visible Then ' MAIL_CUSTOMER_SUBJECT %>
		<td<%= BusinessDetails.MAIL_CUSTOMER_SUBJECT.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_MAIL_CUSTOMER_SUBJECT" class="form-group BusinessDetails_MAIL_CUSTOMER_SUBJECT">
<span<%= BusinessDetails.MAIL_CUSTOMER_SUBJECT.ViewAttributes %>>
<%= BusinessDetails.MAIL_CUSTOMER_SUBJECT.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.Visible Then ' CONFIRMATION_EMAIL_ADDRESS %>
		<td<%= BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_CONFIRMATION_EMAIL_ADDRESS" class="form-group BusinessDetails_CONFIRMATION_EMAIL_ADDRESS">
<span<%= BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.ViewAttributes %>>
<%= BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.SEND_ORDERS_TO_PRINTER.Visible Then ' SEND_ORDERS_TO_PRINTER %>
		<td<%= BusinessDetails.SEND_ORDERS_TO_PRINTER.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_SEND_ORDERS_TO_PRINTER" class="form-group BusinessDetails_SEND_ORDERS_TO_PRINTER">
<span<%= BusinessDetails.SEND_ORDERS_TO_PRINTER.ViewAttributes %>>
<%= BusinessDetails.SEND_ORDERS_TO_PRINTER.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.timezone.Visible Then ' timezone %>
		<td<%= BusinessDetails.timezone.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_timezone" class="form-group BusinessDetails_timezone">
<span<%= BusinessDetails.timezone.ViewAttributes %>>
<%= BusinessDetails.timezone.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.PAYPAL_ADDR.Visible Then ' PAYPAL_ADDR %>
		<td<%= BusinessDetails.PAYPAL_ADDR.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_PAYPAL_ADDR" class="form-group BusinessDetails_PAYPAL_ADDR">
<span<%= BusinessDetails.PAYPAL_ADDR.ViewAttributes %>>
<%= BusinessDetails.PAYPAL_ADDR.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.nochex.Visible Then ' nochex %>
		<td<%= BusinessDetails.nochex.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_nochex" class="form-group BusinessDetails_nochex">
<span<%= BusinessDetails.nochex.ViewAttributes %>>
<%= BusinessDetails.nochex.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.nochexmerchantid.Visible Then ' nochexmerchantid %>
		<td<%= BusinessDetails.nochexmerchantid.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_nochexmerchantid" class="form-group BusinessDetails_nochexmerchantid">
<span<%= BusinessDetails.nochexmerchantid.ViewAttributes %>>
<%= BusinessDetails.nochexmerchantid.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.paypal.Visible Then ' paypal %>
		<td<%= BusinessDetails.paypal.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_paypal" class="form-group BusinessDetails_paypal">
<span<%= BusinessDetails.paypal.ViewAttributes %>>
<%= BusinessDetails.paypal.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.IBT_API_KEY.Visible Then ' IBT_API_KEY %>
		<td<%= BusinessDetails.IBT_API_KEY.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_IBT_API_KEY" class="form-group BusinessDetails_IBT_API_KEY">
<span<%= BusinessDetails.IBT_API_KEY.ViewAttributes %>>
<%= BusinessDetails.IBT_API_KEY.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.IBP_API_PASSWORD.Visible Then ' IBP_API_PASSWORD %>
		<td<%= BusinessDetails.IBP_API_PASSWORD.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_IBP_API_PASSWORD" class="form-group BusinessDetails_IBP_API_PASSWORD">
<span<%= BusinessDetails.IBP_API_PASSWORD.ViewAttributes %>>
<%= BusinessDetails.IBP_API_PASSWORD.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.disable_delivery.Visible Then ' disable_delivery %>
		<td<%= BusinessDetails.disable_delivery.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_disable_delivery" class="form-group BusinessDetails_disable_delivery">
<span<%= BusinessDetails.disable_delivery.ViewAttributes %>>
<%= BusinessDetails.disable_delivery.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.disable_collection.Visible Then ' disable_collection %>
		<td<%= BusinessDetails.disable_collection.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_disable_collection" class="form-group BusinessDetails_disable_collection">
<span<%= BusinessDetails.disable_collection.ViewAttributes %>>
<%= BusinessDetails.disable_collection.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.worldpay.Visible Then ' worldpay %>
		<td<%= BusinessDetails.worldpay.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_worldpay" class="form-group BusinessDetails_worldpay">
<span<%= BusinessDetails.worldpay.ViewAttributes %>>
<%= BusinessDetails.worldpay.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.worldpaymerchantid.Visible Then ' worldpaymerchantid %>
		<td<%= BusinessDetails.worldpaymerchantid.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_worldpaymerchantid" class="form-group BusinessDetails_worldpaymerchantid">
<span<%= BusinessDetails.worldpaymerchantid.ViewAttributes %>>
<%= BusinessDetails.worldpaymerchantid.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.DeliveryChargeOverrideByOrderValue.Visible Then ' DeliveryChargeOverrideByOrderValue %>
		<td<%= BusinessDetails.DeliveryChargeOverrideByOrderValue.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_DeliveryChargeOverrideByOrderValue" class="form-group BusinessDetails_DeliveryChargeOverrideByOrderValue">
<span<%= BusinessDetails.DeliveryChargeOverrideByOrderValue.ViewAttributes %>>
<%= BusinessDetails.DeliveryChargeOverrideByOrderValue.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.individualpostcodeschecking.Visible Then ' individualpostcodeschecking %>
		<td<%= BusinessDetails.individualpostcodeschecking.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_individualpostcodeschecking" class="form-group BusinessDetails_individualpostcodeschecking">
<span<%= BusinessDetails.individualpostcodeschecking.ViewAttributes %>>
<%= BusinessDetails.individualpostcodeschecking.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.longitude.Visible Then ' longitude %>
		<td<%= BusinessDetails.longitude.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_longitude" class="form-group BusinessDetails_longitude">
<span<%= BusinessDetails.longitude.ViewAttributes %>>
<%= BusinessDetails.longitude.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.latitude.Visible Then ' latitude %>
		<td<%= BusinessDetails.latitude.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_latitude" class="form-group BusinessDetails_latitude">
<span<%= BusinessDetails.latitude.ViewAttributes %>>
<%= BusinessDetails.latitude.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.googleecommercetracking.Visible Then ' googleecommercetracking %>
		<td<%= BusinessDetails.googleecommercetracking.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_googleecommercetracking" class="form-group BusinessDetails_googleecommercetracking">
<span<%= BusinessDetails.googleecommercetracking.ViewAttributes %>>
<%= BusinessDetails.googleecommercetracking.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.googleecommercetrackingcode.Visible Then ' googleecommercetrackingcode %>
		<td<%= BusinessDetails.googleecommercetrackingcode.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_googleecommercetrackingcode" class="form-group BusinessDetails_googleecommercetrackingcode">
<span<%= BusinessDetails.googleecommercetrackingcode.ViewAttributes %>>
<%= BusinessDetails.googleecommercetrackingcode.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.bringg.Visible Then ' bringg %>
		<td<%= BusinessDetails.bringg.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_bringg" class="form-group BusinessDetails_bringg">
<span<%= BusinessDetails.bringg.ViewAttributes %>>
<%= BusinessDetails.bringg.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.bringgurl.Visible Then ' bringgurl %>
		<td<%= BusinessDetails.bringgurl.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_bringgurl" class="form-group BusinessDetails_bringgurl">
<span<%= BusinessDetails.bringgurl.ViewAttributes %>>
<%= BusinessDetails.bringgurl.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.bringgcompanyid.Visible Then ' bringgcompanyid %>
		<td<%= BusinessDetails.bringgcompanyid.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_bringgcompanyid" class="form-group BusinessDetails_bringgcompanyid">
<span<%= BusinessDetails.bringgcompanyid.ViewAttributes %>>
<%= BusinessDetails.bringgcompanyid.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.orderonlywhenopen.Visible Then ' orderonlywhenopen %>
		<td<%= BusinessDetails.orderonlywhenopen.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_orderonlywhenopen" class="form-group BusinessDetails_orderonlywhenopen">
<span<%= BusinessDetails.orderonlywhenopen.ViewAttributes %>>
<%= BusinessDetails.orderonlywhenopen.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.disablelaterdelivery.Visible Then ' disablelaterdelivery %>
		<td<%= BusinessDetails.disablelaterdelivery.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_disablelaterdelivery" class="form-group BusinessDetails_disablelaterdelivery">
<span<%= BusinessDetails.disablelaterdelivery.ViewAttributes %>>
<%= BusinessDetails.disablelaterdelivery.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.ordertodayonly.Visible Then ' ordertodayonly %>
		<td<%= BusinessDetails.ordertodayonly.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_ordertodayonly" class="form-group BusinessDetails_ordertodayonly">
<span<%= BusinessDetails.ordertodayonly.ViewAttributes %>>
<%= BusinessDetails.ordertodayonly.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.mileskm.Visible Then ' mileskm %>
		<td<%= BusinessDetails.mileskm.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_mileskm" class="form-group BusinessDetails_mileskm">
<span<%= BusinessDetails.mileskm.ViewAttributes %>>
<%= BusinessDetails.mileskm.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.worldpaylive.Visible Then ' worldpaylive %>
		<td<%= BusinessDetails.worldpaylive.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_worldpaylive" class="form-group BusinessDetails_worldpaylive">
<span<%= BusinessDetails.worldpaylive.ViewAttributes %>>
<%= BusinessDetails.worldpaylive.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.worldpayinstallationid.Visible Then ' worldpayinstallationid %>
		<td<%= BusinessDetails.worldpayinstallationid.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_worldpayinstallationid" class="form-group BusinessDetails_worldpayinstallationid">
<span<%= BusinessDetails.worldpayinstallationid.ViewAttributes %>>
<%= BusinessDetails.worldpayinstallationid.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.DistanceCalMethod.Visible Then ' DistanceCalMethod %>
		<td<%= BusinessDetails.DistanceCalMethod.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_DistanceCalMethod" class="form-group BusinessDetails_DistanceCalMethod">
<span<%= BusinessDetails.DistanceCalMethod.ViewAttributes %>>
<%= BusinessDetails.DistanceCalMethod.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.PrinterIDList.Visible Then ' PrinterIDList %>
		<td<%= BusinessDetails.PrinterIDList.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_PrinterIDList" class="form-group BusinessDetails_PrinterIDList">
<span<%= BusinessDetails.PrinterIDList.ViewAttributes %>>
<%= BusinessDetails.PrinterIDList.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.EpsonJSPrinterURL.Visible Then ' EpsonJSPrinterURL %>
		<td<%= BusinessDetails.EpsonJSPrinterURL.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_EpsonJSPrinterURL" class="form-group BusinessDetails_EpsonJSPrinterURL">
<span<%= BusinessDetails.EpsonJSPrinterURL.ViewAttributes %>>
<%= BusinessDetails.EpsonJSPrinterURL.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.SMSEnable.Visible Then ' SMSEnable %>
		<td<%= BusinessDetails.SMSEnable.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_SMSEnable" class="form-group BusinessDetails_SMSEnable">
<span<%= BusinessDetails.SMSEnable.ViewAttributes %>>
<%= BusinessDetails.SMSEnable.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.SMSOnDelivery.Visible Then ' SMSOnDelivery %>
		<td<%= BusinessDetails.SMSOnDelivery.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_SMSOnDelivery" class="form-group BusinessDetails_SMSOnDelivery">
<span<%= BusinessDetails.SMSOnDelivery.ViewAttributes %>>
<%= BusinessDetails.SMSOnDelivery.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.SMSSupplierDomain.Visible Then ' SMSSupplierDomain %>
		<td<%= BusinessDetails.SMSSupplierDomain.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_SMSSupplierDomain" class="form-group BusinessDetails_SMSSupplierDomain">
<span<%= BusinessDetails.SMSSupplierDomain.ViewAttributes %>>
<%= BusinessDetails.SMSSupplierDomain.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.SMSOnOrder.Visible Then ' SMSOnOrder %>
		<td<%= BusinessDetails.SMSOnOrder.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_SMSOnOrder" class="form-group BusinessDetails_SMSOnOrder">
<span<%= BusinessDetails.SMSOnOrder.ViewAttributes %>>
<%= BusinessDetails.SMSOnOrder.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.SMSOnOrderAfterMin.Visible Then ' SMSOnOrderAfterMin %>
		<td<%= BusinessDetails.SMSOnOrderAfterMin.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_SMSOnOrderAfterMin" class="form-group BusinessDetails_SMSOnOrderAfterMin">
<span<%= BusinessDetails.SMSOnOrderAfterMin.ViewAttributes %>>
<%= BusinessDetails.SMSOnOrderAfterMin.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.SMSOnOrderContent.Visible Then ' SMSOnOrderContent %>
		<td<%= BusinessDetails.SMSOnOrderContent.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_SMSOnOrderContent" class="form-group BusinessDetails_SMSOnOrderContent">
<span<%= BusinessDetails.SMSOnOrderContent.ViewAttributes %>>
<%= BusinessDetails.SMSOnOrderContent.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.DefaultSMSCountryCode.Visible Then ' DefaultSMSCountryCode %>
		<td<%= BusinessDetails.DefaultSMSCountryCode.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_DefaultSMSCountryCode" class="form-group BusinessDetails_DefaultSMSCountryCode">
<span<%= BusinessDetails.DefaultSMSCountryCode.ViewAttributes %>>
<%= BusinessDetails.DefaultSMSCountryCode.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.MinimumAmountForCardPayment.Visible Then ' MinimumAmountForCardPayment %>
		<td<%= BusinessDetails.MinimumAmountForCardPayment.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_MinimumAmountForCardPayment" class="form-group BusinessDetails_MinimumAmountForCardPayment">
<span<%= BusinessDetails.MinimumAmountForCardPayment.ViewAttributes %>>
<%= BusinessDetails.MinimumAmountForCardPayment.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.FavIconUrl.Visible Then ' FavIconUrl %>
		<td<%= BusinessDetails.FavIconUrl.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_FavIconUrl" class="form-group BusinessDetails_FavIconUrl">
<span<%= BusinessDetails.FavIconUrl.ViewAttributes %>>
<%= BusinessDetails.FavIconUrl.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.AddToHomeScreenURL.Visible Then ' AddToHomeScreenURL %>
		<td<%= BusinessDetails.AddToHomeScreenURL.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_AddToHomeScreenURL" class="form-group BusinessDetails_AddToHomeScreenURL">
<span<%= BusinessDetails.AddToHomeScreenURL.ViewAttributes %>>
<%= BusinessDetails.AddToHomeScreenURL.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.SMSOnAcknowledgement.Visible Then ' SMSOnAcknowledgement %>
		<td<%= BusinessDetails.SMSOnAcknowledgement.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_SMSOnAcknowledgement" class="form-group BusinessDetails_SMSOnAcknowledgement">
<span<%= BusinessDetails.SMSOnAcknowledgement.ViewAttributes %>>
<%= BusinessDetails.SMSOnAcknowledgement.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.LocalPrinterURL.Visible Then ' LocalPrinterURL %>
		<td<%= BusinessDetails.LocalPrinterURL.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_LocalPrinterURL" class="form-group BusinessDetails_LocalPrinterURL">
<span<%= BusinessDetails.LocalPrinterURL.ViewAttributes %>>
<%= BusinessDetails.LocalPrinterURL.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.ShowRestaurantDetailOnReceipt.Visible Then ' ShowRestaurantDetailOnReceipt %>
		<td<%= BusinessDetails.ShowRestaurantDetailOnReceipt.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_ShowRestaurantDetailOnReceipt" class="form-group BusinessDetails_ShowRestaurantDetailOnReceipt">
<span<%= BusinessDetails.ShowRestaurantDetailOnReceipt.ViewAttributes %>>
<%= BusinessDetails.ShowRestaurantDetailOnReceipt.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.PrinterFontSizeRatio.Visible Then ' PrinterFontSizeRatio %>
		<td<%= BusinessDetails.PrinterFontSizeRatio.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_PrinterFontSizeRatio" class="form-group BusinessDetails_PrinterFontSizeRatio">
<span<%= BusinessDetails.PrinterFontSizeRatio.ViewAttributes %>>
<%= BusinessDetails.PrinterFontSizeRatio.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.ServiceChargePercentage.Visible Then ' ServiceChargePercentage %>
		<td<%= BusinessDetails.ServiceChargePercentage.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_ServiceChargePercentage" class="form-group BusinessDetails_ServiceChargePercentage">
<span<%= BusinessDetails.ServiceChargePercentage.ViewAttributes %>>
<%= BusinessDetails.ServiceChargePercentage.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.InRestaurantServiceChargeOnly.Visible Then ' InRestaurantServiceChargeOnly %>
		<td<%= BusinessDetails.InRestaurantServiceChargeOnly.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_InRestaurantServiceChargeOnly" class="form-group BusinessDetails_InRestaurantServiceChargeOnly">
<span<%= BusinessDetails.InRestaurantServiceChargeOnly.ViewAttributes %>>
<%= BusinessDetails.InRestaurantServiceChargeOnly.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.IsDualReceiptPrinting.Visible Then ' IsDualReceiptPrinting %>
		<td<%= BusinessDetails.IsDualReceiptPrinting.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_IsDualReceiptPrinting" class="form-group BusinessDetails_IsDualReceiptPrinting">
<span<%= BusinessDetails.IsDualReceiptPrinting.ViewAttributes %>>
<%= BusinessDetails.IsDualReceiptPrinting.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.PrintingFontSize.Visible Then ' PrintingFontSize %>
		<td<%= BusinessDetails.PrintingFontSize.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_PrintingFontSize" class="form-group BusinessDetails_PrintingFontSize">
<span<%= BusinessDetails.PrintingFontSize.ViewAttributes %>>
<%= BusinessDetails.PrintingFontSize.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.InRestaurantEpsonPrinterIDList.Visible Then ' InRestaurantEpsonPrinterIDList %>
		<td<%= BusinessDetails.InRestaurantEpsonPrinterIDList.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_InRestaurantEpsonPrinterIDList" class="form-group BusinessDetails_InRestaurantEpsonPrinterIDList">
<span<%= BusinessDetails.InRestaurantEpsonPrinterIDList.ViewAttributes %>>
<%= BusinessDetails.InRestaurantEpsonPrinterIDList.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.BlockIPEmailList.Visible Then ' BlockIPEmailList %>
		<td<%= BusinessDetails.BlockIPEmailList.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_BlockIPEmailList" class="form-group BusinessDetails_BlockIPEmailList">
<span<%= BusinessDetails.BlockIPEmailList.ViewAttributes %>>
<%= BusinessDetails.BlockIPEmailList.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.RePrintReceiptWays.Visible Then ' RePrintReceiptWays %>
		<td<%= BusinessDetails.RePrintReceiptWays.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_RePrintReceiptWays" class="form-group BusinessDetails_RePrintReceiptWays">
<span<%= BusinessDetails.RePrintReceiptWays.ViewAttributes %>>
<%= BusinessDetails.RePrintReceiptWays.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.printingtype.Visible Then ' printingtype %>
		<td<%= BusinessDetails.printingtype.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_printingtype" class="form-group BusinessDetails_printingtype">
<span<%= BusinessDetails.printingtype.ViewAttributes %>>
<%= BusinessDetails.printingtype.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.Stripe_Key_Secret.Visible Then ' Stripe_Key_Secret %>
		<td<%= BusinessDetails.Stripe_Key_Secret.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_Stripe_Key_Secret" class="form-group BusinessDetails_Stripe_Key_Secret">
<span<%= BusinessDetails.Stripe_Key_Secret.ViewAttributes %>>
<%= BusinessDetails.Stripe_Key_Secret.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.Stripe.Visible Then ' Stripe %>
		<td<%= BusinessDetails.Stripe.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_Stripe" class="form-group BusinessDetails_Stripe">
<span<%= BusinessDetails.Stripe.ViewAttributes %>>
<%= BusinessDetails.Stripe.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.Stripe_Api_Key.Visible Then ' Stripe_Api_Key %>
		<td<%= BusinessDetails.Stripe_Api_Key.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_Stripe_Api_Key" class="form-group BusinessDetails_Stripe_Api_Key">
<span<%= BusinessDetails.Stripe_Api_Key.ViewAttributes %>>
<%= BusinessDetails.Stripe_Api_Key.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.EnableBooking.Visible Then ' EnableBooking %>
		<td<%= BusinessDetails.EnableBooking.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_EnableBooking" class="form-group BusinessDetails_EnableBooking">
<span<%= BusinessDetails.EnableBooking.ViewAttributes %>>
<%= BusinessDetails.EnableBooking.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.URL_Facebook.Visible Then ' URL_Facebook %>
		<td<%= BusinessDetails.URL_Facebook.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_URL_Facebook" class="form-group BusinessDetails_URL_Facebook">
<span<%= BusinessDetails.URL_Facebook.ViewAttributes %>>
<%= BusinessDetails.URL_Facebook.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.URL_Twitter.Visible Then ' URL_Twitter %>
		<td<%= BusinessDetails.URL_Twitter.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_URL_Twitter" class="form-group BusinessDetails_URL_Twitter">
<span<%= BusinessDetails.URL_Twitter.ViewAttributes %>>
<%= BusinessDetails.URL_Twitter.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.URL_Google.Visible Then ' URL_Google %>
		<td<%= BusinessDetails.URL_Google.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_URL_Google" class="form-group BusinessDetails_URL_Google">
<span<%= BusinessDetails.URL_Google.ViewAttributes %>>
<%= BusinessDetails.URL_Google.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.URL_Intagram.Visible Then ' URL_Intagram %>
		<td<%= BusinessDetails.URL_Intagram.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_URL_Intagram" class="form-group BusinessDetails_URL_Intagram">
<span<%= BusinessDetails.URL_Intagram.ViewAttributes %>>
<%= BusinessDetails.URL_Intagram.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.URL_YouTube.Visible Then ' URL_YouTube %>
		<td<%= BusinessDetails.URL_YouTube.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_URL_YouTube" class="form-group BusinessDetails_URL_YouTube">
<span<%= BusinessDetails.URL_YouTube.ViewAttributes %>>
<%= BusinessDetails.URL_YouTube.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.URL_Tripadvisor.Visible Then ' URL_Tripadvisor %>
		<td<%= BusinessDetails.URL_Tripadvisor.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_URL_Tripadvisor" class="form-group BusinessDetails_URL_Tripadvisor">
<span<%= BusinessDetails.URL_Tripadvisor.ViewAttributes %>>
<%= BusinessDetails.URL_Tripadvisor.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.URL_Special_Offer.Visible Then ' URL_Special_Offer %>
		<td<%= BusinessDetails.URL_Special_Offer.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_URL_Special_Offer" class="form-group BusinessDetails_URL_Special_Offer">
<span<%= BusinessDetails.URL_Special_Offer.ViewAttributes %>>
<%= BusinessDetails.URL_Special_Offer.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.URL_Linkin.Visible Then ' URL_Linkin %>
		<td<%= BusinessDetails.URL_Linkin.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_URL_Linkin" class="form-group BusinessDetails_URL_Linkin">
<span<%= BusinessDetails.URL_Linkin.ViewAttributes %>>
<%= BusinessDetails.URL_Linkin.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.Currency_PAYPAL.Visible Then ' Currency_PAYPAL %>
		<td<%= BusinessDetails.Currency_PAYPAL.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_Currency_PAYPAL" class="form-group BusinessDetails_Currency_PAYPAL">
<span<%= BusinessDetails.Currency_PAYPAL.ViewAttributes %>>
<%= BusinessDetails.Currency_PAYPAL.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.Currency_STRIPE.Visible Then ' Currency_STRIPE %>
		<td<%= BusinessDetails.Currency_STRIPE.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_Currency_STRIPE" class="form-group BusinessDetails_Currency_STRIPE">
<span<%= BusinessDetails.Currency_STRIPE.ViewAttributes %>>
<%= BusinessDetails.Currency_STRIPE.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.Currency_WOLRDPAY.Visible Then ' Currency_WOLRDPAY %>
		<td<%= BusinessDetails.Currency_WOLRDPAY.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_Currency_WOLRDPAY" class="form-group BusinessDetails_Currency_WOLRDPAY">
<span<%= BusinessDetails.Currency_WOLRDPAY.ViewAttributes %>>
<%= BusinessDetails.Currency_WOLRDPAY.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.Tip_percent.Visible Then ' Tip_percent %>
		<td<%= BusinessDetails.Tip_percent.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_Tip_percent" class="form-group BusinessDetails_Tip_percent">
<span<%= BusinessDetails.Tip_percent.ViewAttributes %>>
<%= BusinessDetails.Tip_percent.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.Tax_Percent.Visible Then ' Tax_Percent %>
		<td<%= BusinessDetails.Tax_Percent.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_Tax_Percent" class="form-group BusinessDetails_Tax_Percent">
<span<%= BusinessDetails.Tax_Percent.ViewAttributes %>>
<%= BusinessDetails.Tax_Percent.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.InRestaurantTaxChargeOnly.Visible Then ' InRestaurantTaxChargeOnly %>
		<td<%= BusinessDetails.InRestaurantTaxChargeOnly.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_InRestaurantTaxChargeOnly" class="form-group BusinessDetails_InRestaurantTaxChargeOnly">
<span<%= BusinessDetails.InRestaurantTaxChargeOnly.ViewAttributes %>>
<%= BusinessDetails.InRestaurantTaxChargeOnly.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.InRestaurantTipChargeOnly.Visible Then ' InRestaurantTipChargeOnly %>
		<td<%= BusinessDetails.InRestaurantTipChargeOnly.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_InRestaurantTipChargeOnly" class="form-group BusinessDetails_InRestaurantTipChargeOnly">
<span<%= BusinessDetails.InRestaurantTipChargeOnly.ViewAttributes %>>
<%= BusinessDetails.InRestaurantTipChargeOnly.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.isCheckCapcha.Visible Then ' isCheckCapcha %>
		<td<%= BusinessDetails.isCheckCapcha.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_isCheckCapcha" class="form-group BusinessDetails_isCheckCapcha">
<span<%= BusinessDetails.isCheckCapcha.ViewAttributes %>>
<%= BusinessDetails.isCheckCapcha.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.Close_StartDate.Visible Then ' Close_StartDate %>
		<td<%= BusinessDetails.Close_StartDate.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_Close_StartDate" class="form-group BusinessDetails_Close_StartDate">
<span<%= BusinessDetails.Close_StartDate.ViewAttributes %>>
<%= BusinessDetails.Close_StartDate.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.Close_EndDate.Visible Then ' Close_EndDate %>
		<td<%= BusinessDetails.Close_EndDate.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_Close_EndDate" class="form-group BusinessDetails_Close_EndDate">
<span<%= BusinessDetails.Close_EndDate.ViewAttributes %>>
<%= BusinessDetails.Close_EndDate.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.Stripe_Country.Visible Then ' Stripe_Country %>
		<td<%= BusinessDetails.Stripe_Country.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_Stripe_Country" class="form-group BusinessDetails_Stripe_Country">
<span<%= BusinessDetails.Stripe_Country.ViewAttributes %>>
<%= BusinessDetails.Stripe_Country.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.enable_StripePaymentButton.Visible Then ' enable_StripePaymentButton %>
		<td<%= BusinessDetails.enable_StripePaymentButton.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_enable_StripePaymentButton" class="form-group BusinessDetails_enable_StripePaymentButton">
<span<%= BusinessDetails.enable_StripePaymentButton.ViewAttributes %>>
<%= BusinessDetails.enable_StripePaymentButton.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.enable_CashPayment.Visible Then ' enable_CashPayment %>
		<td<%= BusinessDetails.enable_CashPayment.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_enable_CashPayment" class="form-group BusinessDetails_enable_CashPayment">
<span<%= BusinessDetails.enable_CashPayment.ViewAttributes %>>
<%= BusinessDetails.enable_CashPayment.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.DeliveryMile.Visible Then ' DeliveryMile %>
		<td<%= BusinessDetails.DeliveryMile.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_DeliveryMile" class="form-group BusinessDetails_DeliveryMile">
<span<%= BusinessDetails.DeliveryMile.ViewAttributes %>>
<%= BusinessDetails.DeliveryMile.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.Mon_Delivery.Visible Then ' Mon_Delivery %>
		<td<%= BusinessDetails.Mon_Delivery.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_Mon_Delivery" class="form-group BusinessDetails_Mon_Delivery">
<span<%= BusinessDetails.Mon_Delivery.ViewAttributes %>>
<%= BusinessDetails.Mon_Delivery.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.Mon_Collection.Visible Then ' Mon_Collection %>
		<td<%= BusinessDetails.Mon_Collection.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_Mon_Collection" class="form-group BusinessDetails_Mon_Collection">
<span<%= BusinessDetails.Mon_Collection.ViewAttributes %>>
<%= BusinessDetails.Mon_Collection.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.Tue_Delivery.Visible Then ' Tue_Delivery %>
		<td<%= BusinessDetails.Tue_Delivery.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_Tue_Delivery" class="form-group BusinessDetails_Tue_Delivery">
<span<%= BusinessDetails.Tue_Delivery.ViewAttributes %>>
<%= BusinessDetails.Tue_Delivery.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.Tue_Collection.Visible Then ' Tue_Collection %>
		<td<%= BusinessDetails.Tue_Collection.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_Tue_Collection" class="form-group BusinessDetails_Tue_Collection">
<span<%= BusinessDetails.Tue_Collection.ViewAttributes %>>
<%= BusinessDetails.Tue_Collection.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.Wed_Delivery.Visible Then ' Wed_Delivery %>
		<td<%= BusinessDetails.Wed_Delivery.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_Wed_Delivery" class="form-group BusinessDetails_Wed_Delivery">
<span<%= BusinessDetails.Wed_Delivery.ViewAttributes %>>
<%= BusinessDetails.Wed_Delivery.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.Wed_Collection.Visible Then ' Wed_Collection %>
		<td<%= BusinessDetails.Wed_Collection.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_Wed_Collection" class="form-group BusinessDetails_Wed_Collection">
<span<%= BusinessDetails.Wed_Collection.ViewAttributes %>>
<%= BusinessDetails.Wed_Collection.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.Thu_Delivery.Visible Then ' Thu_Delivery %>
		<td<%= BusinessDetails.Thu_Delivery.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_Thu_Delivery" class="form-group BusinessDetails_Thu_Delivery">
<span<%= BusinessDetails.Thu_Delivery.ViewAttributes %>>
<%= BusinessDetails.Thu_Delivery.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.Thu_Collection.Visible Then ' Thu_Collection %>
		<td<%= BusinessDetails.Thu_Collection.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_Thu_Collection" class="form-group BusinessDetails_Thu_Collection">
<span<%= BusinessDetails.Thu_Collection.ViewAttributes %>>
<%= BusinessDetails.Thu_Collection.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.Fri_Delivery.Visible Then ' Fri_Delivery %>
		<td<%= BusinessDetails.Fri_Delivery.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_Fri_Delivery" class="form-group BusinessDetails_Fri_Delivery">
<span<%= BusinessDetails.Fri_Delivery.ViewAttributes %>>
<%= BusinessDetails.Fri_Delivery.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.Fri_Collection.Visible Then ' Fri_Collection %>
		<td<%= BusinessDetails.Fri_Collection.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_Fri_Collection" class="form-group BusinessDetails_Fri_Collection">
<span<%= BusinessDetails.Fri_Collection.ViewAttributes %>>
<%= BusinessDetails.Fri_Collection.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.Sat_Delivery.Visible Then ' Sat_Delivery %>
		<td<%= BusinessDetails.Sat_Delivery.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_Sat_Delivery" class="form-group BusinessDetails_Sat_Delivery">
<span<%= BusinessDetails.Sat_Delivery.ViewAttributes %>>
<%= BusinessDetails.Sat_Delivery.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.Sat_Collection.Visible Then ' Sat_Collection %>
		<td<%= BusinessDetails.Sat_Collection.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_Sat_Collection" class="form-group BusinessDetails_Sat_Collection">
<span<%= BusinessDetails.Sat_Collection.ViewAttributes %>>
<%= BusinessDetails.Sat_Collection.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.Sun_Delivery.Visible Then ' Sun_Delivery %>
		<td<%= BusinessDetails.Sun_Delivery.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_Sun_Delivery" class="form-group BusinessDetails_Sun_Delivery">
<span<%= BusinessDetails.Sun_Delivery.ViewAttributes %>>
<%= BusinessDetails.Sun_Delivery.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.Sun_Collection.Visible Then ' Sun_Collection %>
		<td<%= BusinessDetails.Sun_Collection.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_Sun_Collection" class="form-group BusinessDetails_Sun_Collection">
<span<%= BusinessDetails.Sun_Collection.ViewAttributes %>>
<%= BusinessDetails.Sun_Collection.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.EnableUrlRewrite.Visible Then ' EnableUrlRewrite %>
		<td<%= BusinessDetails.EnableUrlRewrite.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_EnableUrlRewrite" class="form-group BusinessDetails_EnableUrlRewrite">
<span<%= BusinessDetails.EnableUrlRewrite.ViewAttributes %>>
<%= BusinessDetails.EnableUrlRewrite.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.DeliveryCostUpTo.Visible Then ' DeliveryCostUpTo %>
		<td<%= BusinessDetails.DeliveryCostUpTo.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_DeliveryCostUpTo" class="form-group BusinessDetails_DeliveryCostUpTo">
<span<%= BusinessDetails.DeliveryCostUpTo.ViewAttributes %>>
<%= BusinessDetails.DeliveryCostUpTo.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.DeliveryUptoMile.Visible Then ' DeliveryUptoMile %>
		<td<%= BusinessDetails.DeliveryUptoMile.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_DeliveryUptoMile" class="form-group BusinessDetails_DeliveryUptoMile">
<span<%= BusinessDetails.DeliveryUptoMile.ViewAttributes %>>
<%= BusinessDetails.DeliveryUptoMile.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.Show_Ordernumner_printer.Visible Then ' Show_Ordernumner_printer %>
		<td<%= BusinessDetails.Show_Ordernumner_printer.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_Show_Ordernumner_printer" class="form-group BusinessDetails_Show_Ordernumner_printer">
<span<%= BusinessDetails.Show_Ordernumner_printer.ViewAttributes %>>
<%= BusinessDetails.Show_Ordernumner_printer.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.Show_Ordernumner_Receipt.Visible Then ' Show_Ordernumner_Receipt %>
		<td<%= BusinessDetails.Show_Ordernumner_Receipt.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_Show_Ordernumner_Receipt" class="form-group BusinessDetails_Show_Ordernumner_Receipt">
<span<%= BusinessDetails.Show_Ordernumner_Receipt.ViewAttributes %>>
<%= BusinessDetails.Show_Ordernumner_Receipt.ListViewValue %>
</span>
</span>
</td>
<% End If %>
<% If BusinessDetails.Show_Ordernumner_Dashboard.Visible Then ' Show_Ordernumner_Dashboard %>
		<td<%= BusinessDetails.Show_Ordernumner_Dashboard.CellAttributes %>>
<span id="el<%= BusinessDetails_delete.RowCnt %>_BusinessDetails_Show_Ordernumner_Dashboard" class="form-group BusinessDetails_Show_Ordernumner_Dashboard">
<span<%= BusinessDetails.Show_Ordernumner_Dashboard.ViewAttributes %>>
<%= BusinessDetails.Show_Ordernumner_Dashboard.ListViewValue %>
</span>
</span>
</td>
<% End If %>
	</tr>
<%
	BusinessDetails_delete.Recordset.MoveNext
Loop
BusinessDetails_delete.Recordset.Close
Set BusinessDetails_delete.Recordset = Nothing
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
fBusinessDetailsdelete.Init();
</script>
<%
BusinessDetails_delete.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set BusinessDetails_delete = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cBusinessDetails_delete

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
		TableName = "BusinessDetails"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "BusinessDetails_delete"
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
		EW_PAGE_ID = "delete"

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
		RecKeys = BusinessDetails.GetRecordKeys() ' Load record keys
		sFilter = BusinessDetails.GetKeyFilter()
		If sFilter = "" Then
			Call Page_Terminate("BusinessDetailslist.asp") ' Prevent SQL injection, return to list
		End If

		' Set up filter (Sql Where Clause) and get Return Sql
		' Sql constructor in BusinessDetails class, BusinessDetailsinfo.asp

		BusinessDetails.CurrentFilter = sFilter

		' Get action
		If Request.Form("a_delete").Count > 0 Then
			BusinessDetails.CurrentAction = Request.Form("a_delete")
		Else
			BusinessDetails.CurrentAction = "D"	' Delete record directly
		End If
		Select Case BusinessDetails.CurrentAction
			Case "D" ' Delete
				BusinessDetails.SendEmail = True ' Send email on delete success
				If DeleteRows() Then ' Delete rows
					If SuccessMessage = "" Then SuccessMessage = Language.Phrase("DeleteSuccess") ' Set up success message
					Call Page_Terminate(BusinessDetails.ReturnUrl) ' Return to caller
				End If
		End Select
	End Sub

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

			' DeliveryChargeOverrideByOrderValue
			BusinessDetails.DeliveryChargeOverrideByOrderValue.ViewValue = BusinessDetails.DeliveryChargeOverrideByOrderValue.CurrentValue
			BusinessDetails.DeliveryChargeOverrideByOrderValue.ViewCustomAttributes = ""

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

			' DeliveryChargeOverrideByOrderValue
			BusinessDetails.DeliveryChargeOverrideByOrderValue.LinkCustomAttributes = ""
			BusinessDetails.DeliveryChargeOverrideByOrderValue.HrefValue = ""
			BusinessDetails.DeliveryChargeOverrideByOrderValue.TooltipValue = ""

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
		End If

		' Call Row Rendered event
		If BusinessDetails.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call BusinessDetails.Row_Rendered()
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
		sSql = BusinessDetails.SQL
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
				DeleteRows = BusinessDetails.Row_Deleting(RsDelete)
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
			ElseIf BusinessDetails.CancelMessage <> "" Then
				FailureMessage = BusinessDetails.CancelMessage
				BusinessDetails.CancelMessage = ""
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
				Call BusinessDetails.Row_Deleted(RsOld)
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
		Call Breadcrumb.Add("list", BusinessDetails.TableVar, "BusinessDetailslist.asp", "", BusinessDetails.TableVar, True)
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
