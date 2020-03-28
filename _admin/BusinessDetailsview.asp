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
Dim BusinessDetails_view
Set BusinessDetails_view = New cBusinessDetails_view
Set Page = BusinessDetails_view

' Page init processing
BusinessDetails_view.Page_Init()

' Page main processing
BusinessDetails_view.Page_Main()

' Global Page Rendering event (in userfn*.asp)
Page_Rendering()

' Page Render event
BusinessDetails_view.Page_Render()
%>
<!--#include file="header.asp"-->
<% If BusinessDetails.Export = "" Then %>
<script type="text/javascript">
// Page object
var BusinessDetails_view = new ew_Page("BusinessDetails_view");
BusinessDetails_view.PageID = "view"; // Page ID
var EW_PAGE_ID = BusinessDetails_view.PageID; // For backward compatibility
// Form object
var fBusinessDetailsview = new ew_Form("fBusinessDetailsview");
// Form_CustomValidate event
fBusinessDetailsview.Form_CustomValidate = 
 function(fobj) { // DO NOT CHANGE THIS LINE!
 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
// Use JavaScript validation or not
<% If EW_CLIENT_VALIDATE Then %>
fBusinessDetailsview.ValidateRequired = true; // Use JavaScript validation
<% Else %>
fBusinessDetailsview.ValidateRequired = false; // No JavaScript validation
<% End If %>
// Dynamic selection lists
// Form object for search
</script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<% End If %>
<% If BusinessDetails.Export = "" Then %>
<div class="ewToolbar">
<% If BusinessDetails.Export = "" Then %>
<% Breadcrumb.Render() %>
<% End If %>
<%
	BusinessDetails_view.ExportOptions.Render "body", "", "", "", "", ""
	BusinessDetails_view.ActionOptions.Render "body", "", "", "", "", ""
	BusinessDetails_view.DetailOptions.Render "body", "", "", "", "", ""
%>
<% If BusinessDetails.Export = "" Then %>
<%= Language.SelectionForm %>
<% End If %>
<div class="clearfix"></div>
</div>
<% End If %>
<% BusinessDetails_view.ShowPageHeader() %>
<% BusinessDetails_view.ShowMessage %>
<% If BusinessDetails.Export = "" Then %>
<form name="ewPagerForm" class="form-inline ewForm ewPagerForm" action="<%= ew_CurrentPage %>">
<% If Not IsObject(BusinessDetails_view.Pager) Then Set BusinessDetails_view.Pager = ew_NewPrevNextPager(BusinessDetails_view.StartRec, BusinessDetails_view.DisplayRecs, BusinessDetails_view.TotalRecs) %>
<% If BusinessDetails_view.Pager.RecordCount > 0 Then %>
<div class="ewPager">
<span><%= Language.Phrase("Page") %>&nbsp;</span>
<div class="ewPrevNext"><div class="input-group">
<div class="input-group-btn">
<!--first page button-->
	<% If BusinessDetails_view.Pager.FirstButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerFirst") %>" href="<%= BusinessDetails_view.PageUrl %>start=<%= BusinessDetails_view.Pager.FirstButton.Start %>"><span class="icon-first ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerFirst") %>"><span class="icon-first ewIcon"></span></a>
	<% End If %>
<!--previous page button-->
	<% If BusinessDetails_view.Pager.PrevButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerPrevious") %>" href="<%= BusinessDetails_view.PageUrl %>start=<%= BusinessDetails_view.Pager.PrevButton.Start %>"><span class="icon-prev ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerPrevious") %>"><span class="icon-prev ewIcon"></span></a>
	<% End If %>
</div>
<!--current page number-->
	<input class="form-control input-sm" type="text" name="<%= EW_TABLE_PAGE_NO %>" value="<%= BusinessDetails_view.Pager.CurrentPage %>">
<div class="input-group-btn">
<!--next page button-->
	<% If BusinessDetails_view.Pager.NextButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerNext") %>" href="<%= BusinessDetails_view.PageUrl %>start=<%= BusinessDetails_view.Pager.NextButton.Start %>"><span class="icon-next ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerNext") %>"><span class="icon-next ewIcon"></span></a>
	<% End If %>
<!--last page button-->
	<% If BusinessDetails_view.Pager.LastButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerLast") %>" href="<%= BusinessDetails_view.PageUrl %>start=<%= BusinessDetails_view.Pager.LastButton.Start %>"><span class="icon-last ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerLast") %>"><span class="icon-last ewIcon"></span></a>
	<% End If %>
</div>
</div>
</div>
<span>&nbsp;<%= Language.Phrase("of") %>&nbsp;<%= BusinessDetails_view.Pager.PageCount %></span>
</div>
<% End If %>
<div class="clearfix"></div>
</form>
<% End If %>
<form name="fBusinessDetailsview" id="fBusinessDetailsview" class="form-inline ewForm ewViewForm" action="<%= ew_CurrentPage %>" method="post">
<% If BusinessDetails_view.CheckToken Then %>
<input type="hidden" name="<%= EW_TOKEN_NAME %>" value="<%= BusinessDetails_view.Token %>">
<% End If %>
<input type="hidden" name="t" value="BusinessDetails">
<table class="table table-bordered table-striped ewViewTable">
<% If BusinessDetails.ID.Visible Then ' ID %>
	<tr id="r_ID">
		<td><span id="elh_BusinessDetails_ID"><%= BusinessDetails.ID.FldCaption %></span></td>
		<td<%= BusinessDetails.ID.CellAttributes %>>
<span id="el_BusinessDetails_ID" class="form-group">
<span<%= BusinessDetails.ID.ViewAttributes %>>
<%= BusinessDetails.ID.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.Name.Visible Then ' Name %>
	<tr id="r_Name">
		<td><span id="elh_BusinessDetails_Name"><%= BusinessDetails.Name.FldCaption %></span></td>
		<td<%= BusinessDetails.Name.CellAttributes %>>
<span id="el_BusinessDetails_Name" class="form-group">
<span<%= BusinessDetails.Name.ViewAttributes %>>
<%= BusinessDetails.Name.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.Address.Visible Then ' Address %>
	<tr id="r_Address">
		<td><span id="elh_BusinessDetails_Address"><%= BusinessDetails.Address.FldCaption %></span></td>
		<td<%= BusinessDetails.Address.CellAttributes %>>
<span id="el_BusinessDetails_Address" class="form-group">
<span<%= BusinessDetails.Address.ViewAttributes %>>
<%= BusinessDetails.Address.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.PostalCode.Visible Then ' PostalCode %>
	<tr id="r_PostalCode">
		<td><span id="elh_BusinessDetails_PostalCode"><%= BusinessDetails.PostalCode.FldCaption %></span></td>
		<td<%= BusinessDetails.PostalCode.CellAttributes %>>
<span id="el_BusinessDetails_PostalCode" class="form-group">
<span<%= BusinessDetails.PostalCode.ViewAttributes %>>
<%= BusinessDetails.PostalCode.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.FoodType.Visible Then ' FoodType %>
	<tr id="r_FoodType">
		<td><span id="elh_BusinessDetails_FoodType"><%= BusinessDetails.FoodType.FldCaption %></span></td>
		<td<%= BusinessDetails.FoodType.CellAttributes %>>
<span id="el_BusinessDetails_FoodType" class="form-group">
<span<%= BusinessDetails.FoodType.ViewAttributes %>>
<%= BusinessDetails.FoodType.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.DeliveryMinAmount.Visible Then ' DeliveryMinAmount %>
	<tr id="r_DeliveryMinAmount">
		<td><span id="elh_BusinessDetails_DeliveryMinAmount"><%= BusinessDetails.DeliveryMinAmount.FldCaption %></span></td>
		<td<%= BusinessDetails.DeliveryMinAmount.CellAttributes %>>
<span id="el_BusinessDetails_DeliveryMinAmount" class="form-group">
<span<%= BusinessDetails.DeliveryMinAmount.ViewAttributes %>>
<%= BusinessDetails.DeliveryMinAmount.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.DeliveryMaxDistance.Visible Then ' DeliveryMaxDistance %>
	<tr id="r_DeliveryMaxDistance">
		<td><span id="elh_BusinessDetails_DeliveryMaxDistance"><%= BusinessDetails.DeliveryMaxDistance.FldCaption %></span></td>
		<td<%= BusinessDetails.DeliveryMaxDistance.CellAttributes %>>
<span id="el_BusinessDetails_DeliveryMaxDistance" class="form-group">
<span<%= BusinessDetails.DeliveryMaxDistance.ViewAttributes %>>
<%= BusinessDetails.DeliveryMaxDistance.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.DeliveryFreeDistance.Visible Then ' DeliveryFreeDistance %>
	<tr id="r_DeliveryFreeDistance">
		<td><span id="elh_BusinessDetails_DeliveryFreeDistance"><%= BusinessDetails.DeliveryFreeDistance.FldCaption %></span></td>
		<td<%= BusinessDetails.DeliveryFreeDistance.CellAttributes %>>
<span id="el_BusinessDetails_DeliveryFreeDistance" class="form-group">
<span<%= BusinessDetails.DeliveryFreeDistance.ViewAttributes %>>
<%= BusinessDetails.DeliveryFreeDistance.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.AverageDeliveryTime.Visible Then ' AverageDeliveryTime %>
	<tr id="r_AverageDeliveryTime">
		<td><span id="elh_BusinessDetails_AverageDeliveryTime"><%= BusinessDetails.AverageDeliveryTime.FldCaption %></span></td>
		<td<%= BusinessDetails.AverageDeliveryTime.CellAttributes %>>
<span id="el_BusinessDetails_AverageDeliveryTime" class="form-group">
<span<%= BusinessDetails.AverageDeliveryTime.ViewAttributes %>>
<%= BusinessDetails.AverageDeliveryTime.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.AverageCollectionTime.Visible Then ' AverageCollectionTime %>
	<tr id="r_AverageCollectionTime">
		<td><span id="elh_BusinessDetails_AverageCollectionTime"><%= BusinessDetails.AverageCollectionTime.FldCaption %></span></td>
		<td<%= BusinessDetails.AverageCollectionTime.CellAttributes %>>
<span id="el_BusinessDetails_AverageCollectionTime" class="form-group">
<span<%= BusinessDetails.AverageCollectionTime.ViewAttributes %>>
<%= BusinessDetails.AverageCollectionTime.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.DeliveryFee.Visible Then ' DeliveryFee %>
	<tr id="r_DeliveryFee">
		<td><span id="elh_BusinessDetails_DeliveryFee"><%= BusinessDetails.DeliveryFee.FldCaption %></span></td>
		<td<%= BusinessDetails.DeliveryFee.CellAttributes %>>
<span id="el_BusinessDetails_DeliveryFee" class="form-group">
<span<%= BusinessDetails.DeliveryFee.ViewAttributes %>>
<%= BusinessDetails.DeliveryFee.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.ImgUrl.Visible Then ' ImgUrl %>
	<tr id="r_ImgUrl">
		<td><span id="elh_BusinessDetails_ImgUrl"><%= BusinessDetails.ImgUrl.FldCaption %></span></td>
		<td<%= BusinessDetails.ImgUrl.CellAttributes %>>
<span id="el_BusinessDetails_ImgUrl" class="form-group">
<span<%= BusinessDetails.ImgUrl.ViewAttributes %>>
<%= BusinessDetails.ImgUrl.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.Telephone.Visible Then ' Telephone %>
	<tr id="r_Telephone">
		<td><span id="elh_BusinessDetails_Telephone"><%= BusinessDetails.Telephone.FldCaption %></span></td>
		<td<%= BusinessDetails.Telephone.CellAttributes %>>
<span id="el_BusinessDetails_Telephone" class="form-group">
<span<%= BusinessDetails.Telephone.ViewAttributes %>>
<%= BusinessDetails.Telephone.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.zEmail.Visible Then ' Email %>
	<tr id="r_zEmail">
		<td><span id="elh_BusinessDetails_zEmail"><%= BusinessDetails.zEmail.FldCaption %></span></td>
		<td<%= BusinessDetails.zEmail.CellAttributes %>>
<span id="el_BusinessDetails_zEmail" class="form-group">
<span<%= BusinessDetails.zEmail.ViewAttributes %>>
<%= BusinessDetails.zEmail.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.pswd.Visible Then ' pswd %>
	<tr id="r_pswd">
		<td><span id="elh_BusinessDetails_pswd"><%= BusinessDetails.pswd.FldCaption %></span></td>
		<td<%= BusinessDetails.pswd.CellAttributes %>>
<span id="el_BusinessDetails_pswd" class="form-group">
<span<%= BusinessDetails.pswd.ViewAttributes %>>
<%= BusinessDetails.pswd.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.businessclosed.Visible Then ' businessclosed %>
	<tr id="r_businessclosed">
		<td><span id="elh_BusinessDetails_businessclosed"><%= BusinessDetails.businessclosed.FldCaption %></span></td>
		<td<%= BusinessDetails.businessclosed.CellAttributes %>>
<span id="el_BusinessDetails_businessclosed" class="form-group">
<span<%= BusinessDetails.businessclosed.ViewAttributes %>>
<%= BusinessDetails.businessclosed.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.announcement.Visible Then ' announcement %>
	<tr id="r_announcement">
		<td><span id="elh_BusinessDetails_announcement"><%= BusinessDetails.announcement.FldCaption %></span></td>
		<td<%= BusinessDetails.announcement.CellAttributes %>>
<span id="el_BusinessDetails_announcement" class="form-group">
<span<%= BusinessDetails.announcement.ViewAttributes %>>
<%= BusinessDetails.announcement.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.css.Visible Then ' css %>
	<tr id="r_css">
		<td><span id="elh_BusinessDetails_css"><%= BusinessDetails.css.FldCaption %></span></td>
		<td<%= BusinessDetails.css.CellAttributes %>>
<span id="el_BusinessDetails_css" class="form-group">
<span<%= BusinessDetails.css.ViewAttributes %>>
<%= BusinessDetails.css.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.SMTP_AUTENTICATE.Visible Then ' SMTP_AUTENTICATE %>
	<tr id="r_SMTP_AUTENTICATE">
		<td><span id="elh_BusinessDetails_SMTP_AUTENTICATE"><%= BusinessDetails.SMTP_AUTENTICATE.FldCaption %></span></td>
		<td<%= BusinessDetails.SMTP_AUTENTICATE.CellAttributes %>>
<span id="el_BusinessDetails_SMTP_AUTENTICATE" class="form-group">
<span<%= BusinessDetails.SMTP_AUTENTICATE.ViewAttributes %>>
<%= BusinessDetails.SMTP_AUTENTICATE.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.MAIL_FROM.Visible Then ' MAIL_FROM %>
	<tr id="r_MAIL_FROM">
		<td><span id="elh_BusinessDetails_MAIL_FROM"><%= BusinessDetails.MAIL_FROM.FldCaption %></span></td>
		<td<%= BusinessDetails.MAIL_FROM.CellAttributes %>>
<span id="el_BusinessDetails_MAIL_FROM" class="form-group">
<span<%= BusinessDetails.MAIL_FROM.ViewAttributes %>>
<%= BusinessDetails.MAIL_FROM.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.PAYPAL_URL.Visible Then ' PAYPAL_URL %>
	<tr id="r_PAYPAL_URL">
		<td><span id="elh_BusinessDetails_PAYPAL_URL"><%= BusinessDetails.PAYPAL_URL.FldCaption %></span></td>
		<td<%= BusinessDetails.PAYPAL_URL.CellAttributes %>>
<span id="el_BusinessDetails_PAYPAL_URL" class="form-group">
<span<%= BusinessDetails.PAYPAL_URL.ViewAttributes %>>
<%= BusinessDetails.PAYPAL_URL.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.PAYPAL_PDT.Visible Then ' PAYPAL_PDT %>
	<tr id="r_PAYPAL_PDT">
		<td><span id="elh_BusinessDetails_PAYPAL_PDT"><%= BusinessDetails.PAYPAL_PDT.FldCaption %></span></td>
		<td<%= BusinessDetails.PAYPAL_PDT.CellAttributes %>>
<span id="el_BusinessDetails_PAYPAL_PDT" class="form-group">
<span<%= BusinessDetails.PAYPAL_PDT.ViewAttributes %>>
<%= BusinessDetails.PAYPAL_PDT.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.SMTP_PASSWORD.Visible Then ' SMTP_PASSWORD %>
	<tr id="r_SMTP_PASSWORD">
		<td><span id="elh_BusinessDetails_SMTP_PASSWORD"><%= BusinessDetails.SMTP_PASSWORD.FldCaption %></span></td>
		<td<%= BusinessDetails.SMTP_PASSWORD.CellAttributes %>>
<span id="el_BusinessDetails_SMTP_PASSWORD" class="form-group">
<span<%= BusinessDetails.SMTP_PASSWORD.ViewAttributes %>>
<%= BusinessDetails.SMTP_PASSWORD.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.GMAP_API_KEY.Visible Then ' GMAP_API_KEY %>
	<tr id="r_GMAP_API_KEY">
		<td><span id="elh_BusinessDetails_GMAP_API_KEY"><%= BusinessDetails.GMAP_API_KEY.FldCaption %></span></td>
		<td<%= BusinessDetails.GMAP_API_KEY.CellAttributes %>>
<span id="el_BusinessDetails_GMAP_API_KEY" class="form-group">
<span<%= BusinessDetails.GMAP_API_KEY.ViewAttributes %>>
<%= BusinessDetails.GMAP_API_KEY.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.SMTP_USERNAME.Visible Then ' SMTP_USERNAME %>
	<tr id="r_SMTP_USERNAME">
		<td><span id="elh_BusinessDetails_SMTP_USERNAME"><%= BusinessDetails.SMTP_USERNAME.FldCaption %></span></td>
		<td<%= BusinessDetails.SMTP_USERNAME.CellAttributes %>>
<span id="el_BusinessDetails_SMTP_USERNAME" class="form-group">
<span<%= BusinessDetails.SMTP_USERNAME.ViewAttributes %>>
<%= BusinessDetails.SMTP_USERNAME.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.SMTP_USESSL.Visible Then ' SMTP_USESSL %>
	<tr id="r_SMTP_USESSL">
		<td><span id="elh_BusinessDetails_SMTP_USESSL"><%= BusinessDetails.SMTP_USESSL.FldCaption %></span></td>
		<td<%= BusinessDetails.SMTP_USESSL.CellAttributes %>>
<span id="el_BusinessDetails_SMTP_USESSL" class="form-group">
<span<%= BusinessDetails.SMTP_USESSL.ViewAttributes %>>
<%= BusinessDetails.SMTP_USESSL.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.MAIL_SUBJECT.Visible Then ' MAIL_SUBJECT %>
	<tr id="r_MAIL_SUBJECT">
		<td><span id="elh_BusinessDetails_MAIL_SUBJECT"><%= BusinessDetails.MAIL_SUBJECT.FldCaption %></span></td>
		<td<%= BusinessDetails.MAIL_SUBJECT.CellAttributes %>>
<span id="el_BusinessDetails_MAIL_SUBJECT" class="form-group">
<span<%= BusinessDetails.MAIL_SUBJECT.ViewAttributes %>>
<%= BusinessDetails.MAIL_SUBJECT.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.CURRENCYSYMBOL.Visible Then ' CURRENCYSYMBOL %>
	<tr id="r_CURRENCYSYMBOL">
		<td><span id="elh_BusinessDetails_CURRENCYSYMBOL"><%= BusinessDetails.CURRENCYSYMBOL.FldCaption %></span></td>
		<td<%= BusinessDetails.CURRENCYSYMBOL.CellAttributes %>>
<span id="el_BusinessDetails_CURRENCYSYMBOL" class="form-group">
<span<%= BusinessDetails.CURRENCYSYMBOL.ViewAttributes %>>
<%= BusinessDetails.CURRENCYSYMBOL.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.SMTP_SERVER.Visible Then ' SMTP_SERVER %>
	<tr id="r_SMTP_SERVER">
		<td><span id="elh_BusinessDetails_SMTP_SERVER"><%= BusinessDetails.SMTP_SERVER.FldCaption %></span></td>
		<td<%= BusinessDetails.SMTP_SERVER.CellAttributes %>>
<span id="el_BusinessDetails_SMTP_SERVER" class="form-group">
<span<%= BusinessDetails.SMTP_SERVER.ViewAttributes %>>
<%= BusinessDetails.SMTP_SERVER.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.CREDITCARDSURCHARGE.Visible Then ' CREDITCARDSURCHARGE %>
	<tr id="r_CREDITCARDSURCHARGE">
		<td><span id="elh_BusinessDetails_CREDITCARDSURCHARGE"><%= BusinessDetails.CREDITCARDSURCHARGE.FldCaption %></span></td>
		<td<%= BusinessDetails.CREDITCARDSURCHARGE.CellAttributes %>>
<span id="el_BusinessDetails_CREDITCARDSURCHARGE" class="form-group">
<span<%= BusinessDetails.CREDITCARDSURCHARGE.ViewAttributes %>>
<%= BusinessDetails.CREDITCARDSURCHARGE.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.SMTP_PORT.Visible Then ' SMTP_PORT %>
	<tr id="r_SMTP_PORT">
		<td><span id="elh_BusinessDetails_SMTP_PORT"><%= BusinessDetails.SMTP_PORT.FldCaption %></span></td>
		<td<%= BusinessDetails.SMTP_PORT.CellAttributes %>>
<span id="el_BusinessDetails_SMTP_PORT" class="form-group">
<span<%= BusinessDetails.SMTP_PORT.ViewAttributes %>>
<%= BusinessDetails.SMTP_PORT.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.STICK_MENU.Visible Then ' STICK_MENU %>
	<tr id="r_STICK_MENU">
		<td><span id="elh_BusinessDetails_STICK_MENU"><%= BusinessDetails.STICK_MENU.FldCaption %></span></td>
		<td<%= BusinessDetails.STICK_MENU.CellAttributes %>>
<span id="el_BusinessDetails_STICK_MENU" class="form-group">
<span<%= BusinessDetails.STICK_MENU.ViewAttributes %>>
<%= BusinessDetails.STICK_MENU.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.MAIL_CUSTOMER_SUBJECT.Visible Then ' MAIL_CUSTOMER_SUBJECT %>
	<tr id="r_MAIL_CUSTOMER_SUBJECT">
		<td><span id="elh_BusinessDetails_MAIL_CUSTOMER_SUBJECT"><%= BusinessDetails.MAIL_CUSTOMER_SUBJECT.FldCaption %></span></td>
		<td<%= BusinessDetails.MAIL_CUSTOMER_SUBJECT.CellAttributes %>>
<span id="el_BusinessDetails_MAIL_CUSTOMER_SUBJECT" class="form-group">
<span<%= BusinessDetails.MAIL_CUSTOMER_SUBJECT.ViewAttributes %>>
<%= BusinessDetails.MAIL_CUSTOMER_SUBJECT.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.Visible Then ' CONFIRMATION_EMAIL_ADDRESS %>
	<tr id="r_CONFIRMATION_EMAIL_ADDRESS">
		<td><span id="elh_BusinessDetails_CONFIRMATION_EMAIL_ADDRESS"><%= BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.FldCaption %></span></td>
		<td<%= BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.CellAttributes %>>
<span id="el_BusinessDetails_CONFIRMATION_EMAIL_ADDRESS" class="form-group">
<span<%= BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.ViewAttributes %>>
<%= BusinessDetails.CONFIRMATION_EMAIL_ADDRESS.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.SEND_ORDERS_TO_PRINTER.Visible Then ' SEND_ORDERS_TO_PRINTER %>
	<tr id="r_SEND_ORDERS_TO_PRINTER">
		<td><span id="elh_BusinessDetails_SEND_ORDERS_TO_PRINTER"><%= BusinessDetails.SEND_ORDERS_TO_PRINTER.FldCaption %></span></td>
		<td<%= BusinessDetails.SEND_ORDERS_TO_PRINTER.CellAttributes %>>
<span id="el_BusinessDetails_SEND_ORDERS_TO_PRINTER" class="form-group">
<span<%= BusinessDetails.SEND_ORDERS_TO_PRINTER.ViewAttributes %>>
<%= BusinessDetails.SEND_ORDERS_TO_PRINTER.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.timezone.Visible Then ' timezone %>
	<tr id="r_timezone">
		<td><span id="elh_BusinessDetails_timezone"><%= BusinessDetails.timezone.FldCaption %></span></td>
		<td<%= BusinessDetails.timezone.CellAttributes %>>
<span id="el_BusinessDetails_timezone" class="form-group">
<span<%= BusinessDetails.timezone.ViewAttributes %>>
<%= BusinessDetails.timezone.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.PAYPAL_ADDR.Visible Then ' PAYPAL_ADDR %>
	<tr id="r_PAYPAL_ADDR">
		<td><span id="elh_BusinessDetails_PAYPAL_ADDR"><%= BusinessDetails.PAYPAL_ADDR.FldCaption %></span></td>
		<td<%= BusinessDetails.PAYPAL_ADDR.CellAttributes %>>
<span id="el_BusinessDetails_PAYPAL_ADDR" class="form-group">
<span<%= BusinessDetails.PAYPAL_ADDR.ViewAttributes %>>
<%= BusinessDetails.PAYPAL_ADDR.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.nochex.Visible Then ' nochex %>
	<tr id="r_nochex">
		<td><span id="elh_BusinessDetails_nochex"><%= BusinessDetails.nochex.FldCaption %></span></td>
		<td<%= BusinessDetails.nochex.CellAttributes %>>
<span id="el_BusinessDetails_nochex" class="form-group">
<span<%= BusinessDetails.nochex.ViewAttributes %>>
<%= BusinessDetails.nochex.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.nochexmerchantid.Visible Then ' nochexmerchantid %>
	<tr id="r_nochexmerchantid">
		<td><span id="elh_BusinessDetails_nochexmerchantid"><%= BusinessDetails.nochexmerchantid.FldCaption %></span></td>
		<td<%= BusinessDetails.nochexmerchantid.CellAttributes %>>
<span id="el_BusinessDetails_nochexmerchantid" class="form-group">
<span<%= BusinessDetails.nochexmerchantid.ViewAttributes %>>
<%= BusinessDetails.nochexmerchantid.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.paypal.Visible Then ' paypal %>
	<tr id="r_paypal">
		<td><span id="elh_BusinessDetails_paypal"><%= BusinessDetails.paypal.FldCaption %></span></td>
		<td<%= BusinessDetails.paypal.CellAttributes %>>
<span id="el_BusinessDetails_paypal" class="form-group">
<span<%= BusinessDetails.paypal.ViewAttributes %>>
<%= BusinessDetails.paypal.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.IBT_API_KEY.Visible Then ' IBT_API_KEY %>
	<tr id="r_IBT_API_KEY">
		<td><span id="elh_BusinessDetails_IBT_API_KEY"><%= BusinessDetails.IBT_API_KEY.FldCaption %></span></td>
		<td<%= BusinessDetails.IBT_API_KEY.CellAttributes %>>
<span id="el_BusinessDetails_IBT_API_KEY" class="form-group">
<span<%= BusinessDetails.IBT_API_KEY.ViewAttributes %>>
<%= BusinessDetails.IBT_API_KEY.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.IBP_API_PASSWORD.Visible Then ' IBP_API_PASSWORD %>
	<tr id="r_IBP_API_PASSWORD">
		<td><span id="elh_BusinessDetails_IBP_API_PASSWORD"><%= BusinessDetails.IBP_API_PASSWORD.FldCaption %></span></td>
		<td<%= BusinessDetails.IBP_API_PASSWORD.CellAttributes %>>
<span id="el_BusinessDetails_IBP_API_PASSWORD" class="form-group">
<span<%= BusinessDetails.IBP_API_PASSWORD.ViewAttributes %>>
<%= BusinessDetails.IBP_API_PASSWORD.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.disable_delivery.Visible Then ' disable_delivery %>
	<tr id="r_disable_delivery">
		<td><span id="elh_BusinessDetails_disable_delivery"><%= BusinessDetails.disable_delivery.FldCaption %></span></td>
		<td<%= BusinessDetails.disable_delivery.CellAttributes %>>
<span id="el_BusinessDetails_disable_delivery" class="form-group">
<span<%= BusinessDetails.disable_delivery.ViewAttributes %>>
<%= BusinessDetails.disable_delivery.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.disable_collection.Visible Then ' disable_collection %>
	<tr id="r_disable_collection">
		<td><span id="elh_BusinessDetails_disable_collection"><%= BusinessDetails.disable_collection.FldCaption %></span></td>
		<td<%= BusinessDetails.disable_collection.CellAttributes %>>
<span id="el_BusinessDetails_disable_collection" class="form-group">
<span<%= BusinessDetails.disable_collection.ViewAttributes %>>
<%= BusinessDetails.disable_collection.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.worldpay.Visible Then ' worldpay %>
	<tr id="r_worldpay">
		<td><span id="elh_BusinessDetails_worldpay"><%= BusinessDetails.worldpay.FldCaption %></span></td>
		<td<%= BusinessDetails.worldpay.CellAttributes %>>
<span id="el_BusinessDetails_worldpay" class="form-group">
<span<%= BusinessDetails.worldpay.ViewAttributes %>>
<%= BusinessDetails.worldpay.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.worldpaymerchantid.Visible Then ' worldpaymerchantid %>
	<tr id="r_worldpaymerchantid">
		<td><span id="elh_BusinessDetails_worldpaymerchantid"><%= BusinessDetails.worldpaymerchantid.FldCaption %></span></td>
		<td<%= BusinessDetails.worldpaymerchantid.CellAttributes %>>
<span id="el_BusinessDetails_worldpaymerchantid" class="form-group">
<span<%= BusinessDetails.worldpaymerchantid.ViewAttributes %>>
<%= BusinessDetails.worldpaymerchantid.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.backtohometext.Visible Then ' backtohometext %>
	<tr id="r_backtohometext">
		<td><span id="elh_BusinessDetails_backtohometext"><%= BusinessDetails.backtohometext.FldCaption %></span></td>
		<td<%= BusinessDetails.backtohometext.CellAttributes %>>
<span id="el_BusinessDetails_backtohometext" class="form-group">
<span<%= BusinessDetails.backtohometext.ViewAttributes %>>
<%= BusinessDetails.backtohometext.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.closedtext.Visible Then ' closedtext %>
	<tr id="r_closedtext">
		<td><span id="elh_BusinessDetails_closedtext"><%= BusinessDetails.closedtext.FldCaption %></span></td>
		<td<%= BusinessDetails.closedtext.CellAttributes %>>
<span id="el_BusinessDetails_closedtext" class="form-group">
<span<%= BusinessDetails.closedtext.ViewAttributes %>>
<%= BusinessDetails.closedtext.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.DeliveryChargeOverrideByOrderValue.Visible Then ' DeliveryChargeOverrideByOrderValue %>
	<tr id="r_DeliveryChargeOverrideByOrderValue">
		<td><span id="elh_BusinessDetails_DeliveryChargeOverrideByOrderValue"><%= BusinessDetails.DeliveryChargeOverrideByOrderValue.FldCaption %></span></td>
		<td<%= BusinessDetails.DeliveryChargeOverrideByOrderValue.CellAttributes %>>
<span id="el_BusinessDetails_DeliveryChargeOverrideByOrderValue" class="form-group">
<span<%= BusinessDetails.DeliveryChargeOverrideByOrderValue.ViewAttributes %>>
<%= BusinessDetails.DeliveryChargeOverrideByOrderValue.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.individualpostcodes.Visible Then ' individualpostcodes %>
	<tr id="r_individualpostcodes">
		<td><span id="elh_BusinessDetails_individualpostcodes"><%= BusinessDetails.individualpostcodes.FldCaption %></span></td>
		<td<%= BusinessDetails.individualpostcodes.CellAttributes %>>
<span id="el_BusinessDetails_individualpostcodes" class="form-group">
<span<%= BusinessDetails.individualpostcodes.ViewAttributes %>>
<%= BusinessDetails.individualpostcodes.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.individualpostcodeschecking.Visible Then ' individualpostcodeschecking %>
	<tr id="r_individualpostcodeschecking">
		<td><span id="elh_BusinessDetails_individualpostcodeschecking"><%= BusinessDetails.individualpostcodeschecking.FldCaption %></span></td>
		<td<%= BusinessDetails.individualpostcodeschecking.CellAttributes %>>
<span id="el_BusinessDetails_individualpostcodeschecking" class="form-group">
<span<%= BusinessDetails.individualpostcodeschecking.ViewAttributes %>>
<%= BusinessDetails.individualpostcodeschecking.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.longitude.Visible Then ' longitude %>
	<tr id="r_longitude">
		<td><span id="elh_BusinessDetails_longitude"><%= BusinessDetails.longitude.FldCaption %></span></td>
		<td<%= BusinessDetails.longitude.CellAttributes %>>
<span id="el_BusinessDetails_longitude" class="form-group">
<span<%= BusinessDetails.longitude.ViewAttributes %>>
<%= BusinessDetails.longitude.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.latitude.Visible Then ' latitude %>
	<tr id="r_latitude">
		<td><span id="elh_BusinessDetails_latitude"><%= BusinessDetails.latitude.FldCaption %></span></td>
		<td<%= BusinessDetails.latitude.CellAttributes %>>
<span id="el_BusinessDetails_latitude" class="form-group">
<span<%= BusinessDetails.latitude.ViewAttributes %>>
<%= BusinessDetails.latitude.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.googleecommercetracking.Visible Then ' googleecommercetracking %>
	<tr id="r_googleecommercetracking">
		<td><span id="elh_BusinessDetails_googleecommercetracking"><%= BusinessDetails.googleecommercetracking.FldCaption %></span></td>
		<td<%= BusinessDetails.googleecommercetracking.CellAttributes %>>
<span id="el_BusinessDetails_googleecommercetracking" class="form-group">
<span<%= BusinessDetails.googleecommercetracking.ViewAttributes %>>
<%= BusinessDetails.googleecommercetracking.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.googleecommercetrackingcode.Visible Then ' googleecommercetrackingcode %>
	<tr id="r_googleecommercetrackingcode">
		<td><span id="elh_BusinessDetails_googleecommercetrackingcode"><%= BusinessDetails.googleecommercetrackingcode.FldCaption %></span></td>
		<td<%= BusinessDetails.googleecommercetrackingcode.CellAttributes %>>
<span id="el_BusinessDetails_googleecommercetrackingcode" class="form-group">
<span<%= BusinessDetails.googleecommercetrackingcode.ViewAttributes %>>
<%= BusinessDetails.googleecommercetrackingcode.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.bringg.Visible Then ' bringg %>
	<tr id="r_bringg">
		<td><span id="elh_BusinessDetails_bringg"><%= BusinessDetails.bringg.FldCaption %></span></td>
		<td<%= BusinessDetails.bringg.CellAttributes %>>
<span id="el_BusinessDetails_bringg" class="form-group">
<span<%= BusinessDetails.bringg.ViewAttributes %>>
<%= BusinessDetails.bringg.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.bringgurl.Visible Then ' bringgurl %>
	<tr id="r_bringgurl">
		<td><span id="elh_BusinessDetails_bringgurl"><%= BusinessDetails.bringgurl.FldCaption %></span></td>
		<td<%= BusinessDetails.bringgurl.CellAttributes %>>
<span id="el_BusinessDetails_bringgurl" class="form-group">
<span<%= BusinessDetails.bringgurl.ViewAttributes %>>
<%= BusinessDetails.bringgurl.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.bringgcompanyid.Visible Then ' bringgcompanyid %>
	<tr id="r_bringgcompanyid">
		<td><span id="elh_BusinessDetails_bringgcompanyid"><%= BusinessDetails.bringgcompanyid.FldCaption %></span></td>
		<td<%= BusinessDetails.bringgcompanyid.CellAttributes %>>
<span id="el_BusinessDetails_bringgcompanyid" class="form-group">
<span<%= BusinessDetails.bringgcompanyid.ViewAttributes %>>
<%= BusinessDetails.bringgcompanyid.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.orderonlywhenopen.Visible Then ' orderonlywhenopen %>
	<tr id="r_orderonlywhenopen">
		<td><span id="elh_BusinessDetails_orderonlywhenopen"><%= BusinessDetails.orderonlywhenopen.FldCaption %></span></td>
		<td<%= BusinessDetails.orderonlywhenopen.CellAttributes %>>
<span id="el_BusinessDetails_orderonlywhenopen" class="form-group">
<span<%= BusinessDetails.orderonlywhenopen.ViewAttributes %>>
<%= BusinessDetails.orderonlywhenopen.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.disablelaterdelivery.Visible Then ' disablelaterdelivery %>
	<tr id="r_disablelaterdelivery">
		<td><span id="elh_BusinessDetails_disablelaterdelivery"><%= BusinessDetails.disablelaterdelivery.FldCaption %></span></td>
		<td<%= BusinessDetails.disablelaterdelivery.CellAttributes %>>
<span id="el_BusinessDetails_disablelaterdelivery" class="form-group">
<span<%= BusinessDetails.disablelaterdelivery.ViewAttributes %>>
<%= BusinessDetails.disablelaterdelivery.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.menupagetext.Visible Then ' menupagetext %>
	<tr id="r_menupagetext">
		<td><span id="elh_BusinessDetails_menupagetext"><%= BusinessDetails.menupagetext.FldCaption %></span></td>
		<td<%= BusinessDetails.menupagetext.CellAttributes %>>
<span id="el_BusinessDetails_menupagetext" class="form-group">
<span<%= BusinessDetails.menupagetext.ViewAttributes %>>
<%= BusinessDetails.menupagetext.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.ordertodayonly.Visible Then ' ordertodayonly %>
	<tr id="r_ordertodayonly">
		<td><span id="elh_BusinessDetails_ordertodayonly"><%= BusinessDetails.ordertodayonly.FldCaption %></span></td>
		<td<%= BusinessDetails.ordertodayonly.CellAttributes %>>
<span id="el_BusinessDetails_ordertodayonly" class="form-group">
<span<%= BusinessDetails.ordertodayonly.ViewAttributes %>>
<%= BusinessDetails.ordertodayonly.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.mileskm.Visible Then ' mileskm %>
	<tr id="r_mileskm">
		<td><span id="elh_BusinessDetails_mileskm"><%= BusinessDetails.mileskm.FldCaption %></span></td>
		<td<%= BusinessDetails.mileskm.CellAttributes %>>
<span id="el_BusinessDetails_mileskm" class="form-group">
<span<%= BusinessDetails.mileskm.ViewAttributes %>>
<%= BusinessDetails.mileskm.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.worldpaylive.Visible Then ' worldpaylive %>
	<tr id="r_worldpaylive">
		<td><span id="elh_BusinessDetails_worldpaylive"><%= BusinessDetails.worldpaylive.FldCaption %></span></td>
		<td<%= BusinessDetails.worldpaylive.CellAttributes %>>
<span id="el_BusinessDetails_worldpaylive" class="form-group">
<span<%= BusinessDetails.worldpaylive.ViewAttributes %>>
<%= BusinessDetails.worldpaylive.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.worldpayinstallationid.Visible Then ' worldpayinstallationid %>
	<tr id="r_worldpayinstallationid">
		<td><span id="elh_BusinessDetails_worldpayinstallationid"><%= BusinessDetails.worldpayinstallationid.FldCaption %></span></td>
		<td<%= BusinessDetails.worldpayinstallationid.CellAttributes %>>
<span id="el_BusinessDetails_worldpayinstallationid" class="form-group">
<span<%= BusinessDetails.worldpayinstallationid.ViewAttributes %>>
<%= BusinessDetails.worldpayinstallationid.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.DistanceCalMethod.Visible Then ' DistanceCalMethod %>
	<tr id="r_DistanceCalMethod">
		<td><span id="elh_BusinessDetails_DistanceCalMethod"><%= BusinessDetails.DistanceCalMethod.FldCaption %></span></td>
		<td<%= BusinessDetails.DistanceCalMethod.CellAttributes %>>
<span id="el_BusinessDetails_DistanceCalMethod" class="form-group">
<span<%= BusinessDetails.DistanceCalMethod.ViewAttributes %>>
<%= BusinessDetails.DistanceCalMethod.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.PrinterIDList.Visible Then ' PrinterIDList %>
	<tr id="r_PrinterIDList">
		<td><span id="elh_BusinessDetails_PrinterIDList"><%= BusinessDetails.PrinterIDList.FldCaption %></span></td>
		<td<%= BusinessDetails.PrinterIDList.CellAttributes %>>
<span id="el_BusinessDetails_PrinterIDList" class="form-group">
<span<%= BusinessDetails.PrinterIDList.ViewAttributes %>>
<%= BusinessDetails.PrinterIDList.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.EpsonJSPrinterURL.Visible Then ' EpsonJSPrinterURL %>
	<tr id="r_EpsonJSPrinterURL">
		<td><span id="elh_BusinessDetails_EpsonJSPrinterURL"><%= BusinessDetails.EpsonJSPrinterURL.FldCaption %></span></td>
		<td<%= BusinessDetails.EpsonJSPrinterURL.CellAttributes %>>
<span id="el_BusinessDetails_EpsonJSPrinterURL" class="form-group">
<span<%= BusinessDetails.EpsonJSPrinterURL.ViewAttributes %>>
<%= BusinessDetails.EpsonJSPrinterURL.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.SMSEnable.Visible Then ' SMSEnable %>
	<tr id="r_SMSEnable">
		<td><span id="elh_BusinessDetails_SMSEnable"><%= BusinessDetails.SMSEnable.FldCaption %></span></td>
		<td<%= BusinessDetails.SMSEnable.CellAttributes %>>
<span id="el_BusinessDetails_SMSEnable" class="form-group">
<span<%= BusinessDetails.SMSEnable.ViewAttributes %>>
<%= BusinessDetails.SMSEnable.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.SMSOnDelivery.Visible Then ' SMSOnDelivery %>
	<tr id="r_SMSOnDelivery">
		<td><span id="elh_BusinessDetails_SMSOnDelivery"><%= BusinessDetails.SMSOnDelivery.FldCaption %></span></td>
		<td<%= BusinessDetails.SMSOnDelivery.CellAttributes %>>
<span id="el_BusinessDetails_SMSOnDelivery" class="form-group">
<span<%= BusinessDetails.SMSOnDelivery.ViewAttributes %>>
<%= BusinessDetails.SMSOnDelivery.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.SMSSupplierDomain.Visible Then ' SMSSupplierDomain %>
	<tr id="r_SMSSupplierDomain">
		<td><span id="elh_BusinessDetails_SMSSupplierDomain"><%= BusinessDetails.SMSSupplierDomain.FldCaption %></span></td>
		<td<%= BusinessDetails.SMSSupplierDomain.CellAttributes %>>
<span id="el_BusinessDetails_SMSSupplierDomain" class="form-group">
<span<%= BusinessDetails.SMSSupplierDomain.ViewAttributes %>>
<%= BusinessDetails.SMSSupplierDomain.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.SMSOnOrder.Visible Then ' SMSOnOrder %>
	<tr id="r_SMSOnOrder">
		<td><span id="elh_BusinessDetails_SMSOnOrder"><%= BusinessDetails.SMSOnOrder.FldCaption %></span></td>
		<td<%= BusinessDetails.SMSOnOrder.CellAttributes %>>
<span id="el_BusinessDetails_SMSOnOrder" class="form-group">
<span<%= BusinessDetails.SMSOnOrder.ViewAttributes %>>
<%= BusinessDetails.SMSOnOrder.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.SMSOnOrderAfterMin.Visible Then ' SMSOnOrderAfterMin %>
	<tr id="r_SMSOnOrderAfterMin">
		<td><span id="elh_BusinessDetails_SMSOnOrderAfterMin"><%= BusinessDetails.SMSOnOrderAfterMin.FldCaption %></span></td>
		<td<%= BusinessDetails.SMSOnOrderAfterMin.CellAttributes %>>
<span id="el_BusinessDetails_SMSOnOrderAfterMin" class="form-group">
<span<%= BusinessDetails.SMSOnOrderAfterMin.ViewAttributes %>>
<%= BusinessDetails.SMSOnOrderAfterMin.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.SMSOnOrderContent.Visible Then ' SMSOnOrderContent %>
	<tr id="r_SMSOnOrderContent">
		<td><span id="elh_BusinessDetails_SMSOnOrderContent"><%= BusinessDetails.SMSOnOrderContent.FldCaption %></span></td>
		<td<%= BusinessDetails.SMSOnOrderContent.CellAttributes %>>
<span id="el_BusinessDetails_SMSOnOrderContent" class="form-group">
<span<%= BusinessDetails.SMSOnOrderContent.ViewAttributes %>>
<%= BusinessDetails.SMSOnOrderContent.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.DefaultSMSCountryCode.Visible Then ' DefaultSMSCountryCode %>
	<tr id="r_DefaultSMSCountryCode">
		<td><span id="elh_BusinessDetails_DefaultSMSCountryCode"><%= BusinessDetails.DefaultSMSCountryCode.FldCaption %></span></td>
		<td<%= BusinessDetails.DefaultSMSCountryCode.CellAttributes %>>
<span id="el_BusinessDetails_DefaultSMSCountryCode" class="form-group">
<span<%= BusinessDetails.DefaultSMSCountryCode.ViewAttributes %>>
<%= BusinessDetails.DefaultSMSCountryCode.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.MinimumAmountForCardPayment.Visible Then ' MinimumAmountForCardPayment %>
	<tr id="r_MinimumAmountForCardPayment">
		<td><span id="elh_BusinessDetails_MinimumAmountForCardPayment"><%= BusinessDetails.MinimumAmountForCardPayment.FldCaption %></span></td>
		<td<%= BusinessDetails.MinimumAmountForCardPayment.CellAttributes %>>
<span id="el_BusinessDetails_MinimumAmountForCardPayment" class="form-group">
<span<%= BusinessDetails.MinimumAmountForCardPayment.ViewAttributes %>>
<%= BusinessDetails.MinimumAmountForCardPayment.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.FavIconUrl.Visible Then ' FavIconUrl %>
	<tr id="r_FavIconUrl">
		<td><span id="elh_BusinessDetails_FavIconUrl"><%= BusinessDetails.FavIconUrl.FldCaption %></span></td>
		<td<%= BusinessDetails.FavIconUrl.CellAttributes %>>
<span id="el_BusinessDetails_FavIconUrl" class="form-group">
<span<%= BusinessDetails.FavIconUrl.ViewAttributes %>>
<%= BusinessDetails.FavIconUrl.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.AddToHomeScreenURL.Visible Then ' AddToHomeScreenURL %>
	<tr id="r_AddToHomeScreenURL">
		<td><span id="elh_BusinessDetails_AddToHomeScreenURL"><%= BusinessDetails.AddToHomeScreenURL.FldCaption %></span></td>
		<td<%= BusinessDetails.AddToHomeScreenURL.CellAttributes %>>
<span id="el_BusinessDetails_AddToHomeScreenURL" class="form-group">
<span<%= BusinessDetails.AddToHomeScreenURL.ViewAttributes %>>
<%= BusinessDetails.AddToHomeScreenURL.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.SMSOnAcknowledgement.Visible Then ' SMSOnAcknowledgement %>
	<tr id="r_SMSOnAcknowledgement">
		<td><span id="elh_BusinessDetails_SMSOnAcknowledgement"><%= BusinessDetails.SMSOnAcknowledgement.FldCaption %></span></td>
		<td<%= BusinessDetails.SMSOnAcknowledgement.CellAttributes %>>
<span id="el_BusinessDetails_SMSOnAcknowledgement" class="form-group">
<span<%= BusinessDetails.SMSOnAcknowledgement.ViewAttributes %>>
<%= BusinessDetails.SMSOnAcknowledgement.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.LocalPrinterURL.Visible Then ' LocalPrinterURL %>
	<tr id="r_LocalPrinterURL">
		<td><span id="elh_BusinessDetails_LocalPrinterURL"><%= BusinessDetails.LocalPrinterURL.FldCaption %></span></td>
		<td<%= BusinessDetails.LocalPrinterURL.CellAttributes %>>
<span id="el_BusinessDetails_LocalPrinterURL" class="form-group">
<span<%= BusinessDetails.LocalPrinterURL.ViewAttributes %>>
<%= BusinessDetails.LocalPrinterURL.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.ShowRestaurantDetailOnReceipt.Visible Then ' ShowRestaurantDetailOnReceipt %>
	<tr id="r_ShowRestaurantDetailOnReceipt">
		<td><span id="elh_BusinessDetails_ShowRestaurantDetailOnReceipt"><%= BusinessDetails.ShowRestaurantDetailOnReceipt.FldCaption %></span></td>
		<td<%= BusinessDetails.ShowRestaurantDetailOnReceipt.CellAttributes %>>
<span id="el_BusinessDetails_ShowRestaurantDetailOnReceipt" class="form-group">
<span<%= BusinessDetails.ShowRestaurantDetailOnReceipt.ViewAttributes %>>
<%= BusinessDetails.ShowRestaurantDetailOnReceipt.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.PrinterFontSizeRatio.Visible Then ' PrinterFontSizeRatio %>
	<tr id="r_PrinterFontSizeRatio">
		<td><span id="elh_BusinessDetails_PrinterFontSizeRatio"><%= BusinessDetails.PrinterFontSizeRatio.FldCaption %></span></td>
		<td<%= BusinessDetails.PrinterFontSizeRatio.CellAttributes %>>
<span id="el_BusinessDetails_PrinterFontSizeRatio" class="form-group">
<span<%= BusinessDetails.PrinterFontSizeRatio.ViewAttributes %>>
<%= BusinessDetails.PrinterFontSizeRatio.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.ServiceChargePercentage.Visible Then ' ServiceChargePercentage %>
	<tr id="r_ServiceChargePercentage">
		<td><span id="elh_BusinessDetails_ServiceChargePercentage"><%= BusinessDetails.ServiceChargePercentage.FldCaption %></span></td>
		<td<%= BusinessDetails.ServiceChargePercentage.CellAttributes %>>
<span id="el_BusinessDetails_ServiceChargePercentage" class="form-group">
<span<%= BusinessDetails.ServiceChargePercentage.ViewAttributes %>>
<%= BusinessDetails.ServiceChargePercentage.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.InRestaurantServiceChargeOnly.Visible Then ' InRestaurantServiceChargeOnly %>
	<tr id="r_InRestaurantServiceChargeOnly">
		<td><span id="elh_BusinessDetails_InRestaurantServiceChargeOnly"><%= BusinessDetails.InRestaurantServiceChargeOnly.FldCaption %></span></td>
		<td<%= BusinessDetails.InRestaurantServiceChargeOnly.CellAttributes %>>
<span id="el_BusinessDetails_InRestaurantServiceChargeOnly" class="form-group">
<span<%= BusinessDetails.InRestaurantServiceChargeOnly.ViewAttributes %>>
<%= BusinessDetails.InRestaurantServiceChargeOnly.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.IsDualReceiptPrinting.Visible Then ' IsDualReceiptPrinting %>
	<tr id="r_IsDualReceiptPrinting">
		<td><span id="elh_BusinessDetails_IsDualReceiptPrinting"><%= BusinessDetails.IsDualReceiptPrinting.FldCaption %></span></td>
		<td<%= BusinessDetails.IsDualReceiptPrinting.CellAttributes %>>
<span id="el_BusinessDetails_IsDualReceiptPrinting" class="form-group">
<span<%= BusinessDetails.IsDualReceiptPrinting.ViewAttributes %>>
<%= BusinessDetails.IsDualReceiptPrinting.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.PrintingFontSize.Visible Then ' PrintingFontSize %>
	<tr id="r_PrintingFontSize">
		<td><span id="elh_BusinessDetails_PrintingFontSize"><%= BusinessDetails.PrintingFontSize.FldCaption %></span></td>
		<td<%= BusinessDetails.PrintingFontSize.CellAttributes %>>
<span id="el_BusinessDetails_PrintingFontSize" class="form-group">
<span<%= BusinessDetails.PrintingFontSize.ViewAttributes %>>
<%= BusinessDetails.PrintingFontSize.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.InRestaurantEpsonPrinterIDList.Visible Then ' InRestaurantEpsonPrinterIDList %>
	<tr id="r_InRestaurantEpsonPrinterIDList">
		<td><span id="elh_BusinessDetails_InRestaurantEpsonPrinterIDList"><%= BusinessDetails.InRestaurantEpsonPrinterIDList.FldCaption %></span></td>
		<td<%= BusinessDetails.InRestaurantEpsonPrinterIDList.CellAttributes %>>
<span id="el_BusinessDetails_InRestaurantEpsonPrinterIDList" class="form-group">
<span<%= BusinessDetails.InRestaurantEpsonPrinterIDList.ViewAttributes %>>
<%= BusinessDetails.InRestaurantEpsonPrinterIDList.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.BlockIPEmailList.Visible Then ' BlockIPEmailList %>
	<tr id="r_BlockIPEmailList">
		<td><span id="elh_BusinessDetails_BlockIPEmailList"><%= BusinessDetails.BlockIPEmailList.FldCaption %></span></td>
		<td<%= BusinessDetails.BlockIPEmailList.CellAttributes %>>
<span id="el_BusinessDetails_BlockIPEmailList" class="form-group">
<span<%= BusinessDetails.BlockIPEmailList.ViewAttributes %>>
<%= BusinessDetails.BlockIPEmailList.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.inmenuannouncement.Visible Then ' inmenuannouncement %>
	<tr id="r_inmenuannouncement">
		<td><span id="elh_BusinessDetails_inmenuannouncement"><%= BusinessDetails.inmenuannouncement.FldCaption %></span></td>
		<td<%= BusinessDetails.inmenuannouncement.CellAttributes %>>
<span id="el_BusinessDetails_inmenuannouncement" class="form-group">
<span<%= BusinessDetails.inmenuannouncement.ViewAttributes %>>
<%= BusinessDetails.inmenuannouncement.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.RePrintReceiptWays.Visible Then ' RePrintReceiptWays %>
	<tr id="r_RePrintReceiptWays">
		<td><span id="elh_BusinessDetails_RePrintReceiptWays"><%= BusinessDetails.RePrintReceiptWays.FldCaption %></span></td>
		<td<%= BusinessDetails.RePrintReceiptWays.CellAttributes %>>
<span id="el_BusinessDetails_RePrintReceiptWays" class="form-group">
<span<%= BusinessDetails.RePrintReceiptWays.ViewAttributes %>>
<%= BusinessDetails.RePrintReceiptWays.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.printingtype.Visible Then ' printingtype %>
	<tr id="r_printingtype">
		<td><span id="elh_BusinessDetails_printingtype"><%= BusinessDetails.printingtype.FldCaption %></span></td>
		<td<%= BusinessDetails.printingtype.CellAttributes %>>
<span id="el_BusinessDetails_printingtype" class="form-group">
<span<%= BusinessDetails.printingtype.ViewAttributes %>>
<%= BusinessDetails.printingtype.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.Stripe_Key_Secret.Visible Then ' Stripe_Key_Secret %>
	<tr id="r_Stripe_Key_Secret">
		<td><span id="elh_BusinessDetails_Stripe_Key_Secret"><%= BusinessDetails.Stripe_Key_Secret.FldCaption %></span></td>
		<td<%= BusinessDetails.Stripe_Key_Secret.CellAttributes %>>
<span id="el_BusinessDetails_Stripe_Key_Secret" class="form-group">
<span<%= BusinessDetails.Stripe_Key_Secret.ViewAttributes %>>
<%= BusinessDetails.Stripe_Key_Secret.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.Stripe.Visible Then ' Stripe %>
	<tr id="r_Stripe">
		<td><span id="elh_BusinessDetails_Stripe"><%= BusinessDetails.Stripe.FldCaption %></span></td>
		<td<%= BusinessDetails.Stripe.CellAttributes %>>
<span id="el_BusinessDetails_Stripe" class="form-group">
<span<%= BusinessDetails.Stripe.ViewAttributes %>>
<%= BusinessDetails.Stripe.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.Stripe_Api_Key.Visible Then ' Stripe_Api_Key %>
	<tr id="r_Stripe_Api_Key">
		<td><span id="elh_BusinessDetails_Stripe_Api_Key"><%= BusinessDetails.Stripe_Api_Key.FldCaption %></span></td>
		<td<%= BusinessDetails.Stripe_Api_Key.CellAttributes %>>
<span id="el_BusinessDetails_Stripe_Api_Key" class="form-group">
<span<%= BusinessDetails.Stripe_Api_Key.ViewAttributes %>>
<%= BusinessDetails.Stripe_Api_Key.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.EnableBooking.Visible Then ' EnableBooking %>
	<tr id="r_EnableBooking">
		<td><span id="elh_BusinessDetails_EnableBooking"><%= BusinessDetails.EnableBooking.FldCaption %></span></td>
		<td<%= BusinessDetails.EnableBooking.CellAttributes %>>
<span id="el_BusinessDetails_EnableBooking" class="form-group">
<span<%= BusinessDetails.EnableBooking.ViewAttributes %>>
<%= BusinessDetails.EnableBooking.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.URL_Facebook.Visible Then ' URL_Facebook %>
	<tr id="r_URL_Facebook">
		<td><span id="elh_BusinessDetails_URL_Facebook"><%= BusinessDetails.URL_Facebook.FldCaption %></span></td>
		<td<%= BusinessDetails.URL_Facebook.CellAttributes %>>
<span id="el_BusinessDetails_URL_Facebook" class="form-group">
<span<%= BusinessDetails.URL_Facebook.ViewAttributes %>>
<%= BusinessDetails.URL_Facebook.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.URL_Twitter.Visible Then ' URL_Twitter %>
	<tr id="r_URL_Twitter">
		<td><span id="elh_BusinessDetails_URL_Twitter"><%= BusinessDetails.URL_Twitter.FldCaption %></span></td>
		<td<%= BusinessDetails.URL_Twitter.CellAttributes %>>
<span id="el_BusinessDetails_URL_Twitter" class="form-group">
<span<%= BusinessDetails.URL_Twitter.ViewAttributes %>>
<%= BusinessDetails.URL_Twitter.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.URL_Google.Visible Then ' URL_Google %>
	<tr id="r_URL_Google">
		<td><span id="elh_BusinessDetails_URL_Google"><%= BusinessDetails.URL_Google.FldCaption %></span></td>
		<td<%= BusinessDetails.URL_Google.CellAttributes %>>
<span id="el_BusinessDetails_URL_Google" class="form-group">
<span<%= BusinessDetails.URL_Google.ViewAttributes %>>
<%= BusinessDetails.URL_Google.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.URL_Intagram.Visible Then ' URL_Intagram %>
	<tr id="r_URL_Intagram">
		<td><span id="elh_BusinessDetails_URL_Intagram"><%= BusinessDetails.URL_Intagram.FldCaption %></span></td>
		<td<%= BusinessDetails.URL_Intagram.CellAttributes %>>
<span id="el_BusinessDetails_URL_Intagram" class="form-group">
<span<%= BusinessDetails.URL_Intagram.ViewAttributes %>>
<%= BusinessDetails.URL_Intagram.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.URL_YouTube.Visible Then ' URL_YouTube %>
	<tr id="r_URL_YouTube">
		<td><span id="elh_BusinessDetails_URL_YouTube"><%= BusinessDetails.URL_YouTube.FldCaption %></span></td>
		<td<%= BusinessDetails.URL_YouTube.CellAttributes %>>
<span id="el_BusinessDetails_URL_YouTube" class="form-group">
<span<%= BusinessDetails.URL_YouTube.ViewAttributes %>>
<%= BusinessDetails.URL_YouTube.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.URL_Tripadvisor.Visible Then ' URL_Tripadvisor %>
	<tr id="r_URL_Tripadvisor">
		<td><span id="elh_BusinessDetails_URL_Tripadvisor"><%= BusinessDetails.URL_Tripadvisor.FldCaption %></span></td>
		<td<%= BusinessDetails.URL_Tripadvisor.CellAttributes %>>
<span id="el_BusinessDetails_URL_Tripadvisor" class="form-group">
<span<%= BusinessDetails.URL_Tripadvisor.ViewAttributes %>>
<%= BusinessDetails.URL_Tripadvisor.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.URL_Special_Offer.Visible Then ' URL_Special_Offer %>
	<tr id="r_URL_Special_Offer">
		<td><span id="elh_BusinessDetails_URL_Special_Offer"><%= BusinessDetails.URL_Special_Offer.FldCaption %></span></td>
		<td<%= BusinessDetails.URL_Special_Offer.CellAttributes %>>
<span id="el_BusinessDetails_URL_Special_Offer" class="form-group">
<span<%= BusinessDetails.URL_Special_Offer.ViewAttributes %>>
<%= BusinessDetails.URL_Special_Offer.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.URL_Linkin.Visible Then ' URL_Linkin %>
	<tr id="r_URL_Linkin">
		<td><span id="elh_BusinessDetails_URL_Linkin"><%= BusinessDetails.URL_Linkin.FldCaption %></span></td>
		<td<%= BusinessDetails.URL_Linkin.CellAttributes %>>
<span id="el_BusinessDetails_URL_Linkin" class="form-group">
<span<%= BusinessDetails.URL_Linkin.ViewAttributes %>>
<%= BusinessDetails.URL_Linkin.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.Currency_PAYPAL.Visible Then ' Currency_PAYPAL %>
	<tr id="r_Currency_PAYPAL">
		<td><span id="elh_BusinessDetails_Currency_PAYPAL"><%= BusinessDetails.Currency_PAYPAL.FldCaption %></span></td>
		<td<%= BusinessDetails.Currency_PAYPAL.CellAttributes %>>
<span id="el_BusinessDetails_Currency_PAYPAL" class="form-group">
<span<%= BusinessDetails.Currency_PAYPAL.ViewAttributes %>>
<%= BusinessDetails.Currency_PAYPAL.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.Currency_STRIPE.Visible Then ' Currency_STRIPE %>
	<tr id="r_Currency_STRIPE">
		<td><span id="elh_BusinessDetails_Currency_STRIPE"><%= BusinessDetails.Currency_STRIPE.FldCaption %></span></td>
		<td<%= BusinessDetails.Currency_STRIPE.CellAttributes %>>
<span id="el_BusinessDetails_Currency_STRIPE" class="form-group">
<span<%= BusinessDetails.Currency_STRIPE.ViewAttributes %>>
<%= BusinessDetails.Currency_STRIPE.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.Currency_WOLRDPAY.Visible Then ' Currency_WOLRDPAY %>
	<tr id="r_Currency_WOLRDPAY">
		<td><span id="elh_BusinessDetails_Currency_WOLRDPAY"><%= BusinessDetails.Currency_WOLRDPAY.FldCaption %></span></td>
		<td<%= BusinessDetails.Currency_WOLRDPAY.CellAttributes %>>
<span id="el_BusinessDetails_Currency_WOLRDPAY" class="form-group">
<span<%= BusinessDetails.Currency_WOLRDPAY.ViewAttributes %>>
<%= BusinessDetails.Currency_WOLRDPAY.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.Tip_percent.Visible Then ' Tip_percent %>
	<tr id="r_Tip_percent">
		<td><span id="elh_BusinessDetails_Tip_percent"><%= BusinessDetails.Tip_percent.FldCaption %></span></td>
		<td<%= BusinessDetails.Tip_percent.CellAttributes %>>
<span id="el_BusinessDetails_Tip_percent" class="form-group">
<span<%= BusinessDetails.Tip_percent.ViewAttributes %>>
<%= BusinessDetails.Tip_percent.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.Tax_Percent.Visible Then ' Tax_Percent %>
	<tr id="r_Tax_Percent">
		<td><span id="elh_BusinessDetails_Tax_Percent"><%= BusinessDetails.Tax_Percent.FldCaption %></span></td>
		<td<%= BusinessDetails.Tax_Percent.CellAttributes %>>
<span id="el_BusinessDetails_Tax_Percent" class="form-group">
<span<%= BusinessDetails.Tax_Percent.ViewAttributes %>>
<%= BusinessDetails.Tax_Percent.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.InRestaurantTaxChargeOnly.Visible Then ' InRestaurantTaxChargeOnly %>
	<tr id="r_InRestaurantTaxChargeOnly">
		<td><span id="elh_BusinessDetails_InRestaurantTaxChargeOnly"><%= BusinessDetails.InRestaurantTaxChargeOnly.FldCaption %></span></td>
		<td<%= BusinessDetails.InRestaurantTaxChargeOnly.CellAttributes %>>
<span id="el_BusinessDetails_InRestaurantTaxChargeOnly" class="form-group">
<span<%= BusinessDetails.InRestaurantTaxChargeOnly.ViewAttributes %>>
<%= BusinessDetails.InRestaurantTaxChargeOnly.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.InRestaurantTipChargeOnly.Visible Then ' InRestaurantTipChargeOnly %>
	<tr id="r_InRestaurantTipChargeOnly">
		<td><span id="elh_BusinessDetails_InRestaurantTipChargeOnly"><%= BusinessDetails.InRestaurantTipChargeOnly.FldCaption %></span></td>
		<td<%= BusinessDetails.InRestaurantTipChargeOnly.CellAttributes %>>
<span id="el_BusinessDetails_InRestaurantTipChargeOnly" class="form-group">
<span<%= BusinessDetails.InRestaurantTipChargeOnly.ViewAttributes %>>
<%= BusinessDetails.InRestaurantTipChargeOnly.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.isCheckCapcha.Visible Then ' isCheckCapcha %>
	<tr id="r_isCheckCapcha">
		<td><span id="elh_BusinessDetails_isCheckCapcha"><%= BusinessDetails.isCheckCapcha.FldCaption %></span></td>
		<td<%= BusinessDetails.isCheckCapcha.CellAttributes %>>
<span id="el_BusinessDetails_isCheckCapcha" class="form-group">
<span<%= BusinessDetails.isCheckCapcha.ViewAttributes %>>
<%= BusinessDetails.isCheckCapcha.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.Close_StartDate.Visible Then ' Close_StartDate %>
	<tr id="r_Close_StartDate">
		<td><span id="elh_BusinessDetails_Close_StartDate"><%= BusinessDetails.Close_StartDate.FldCaption %></span></td>
		<td<%= BusinessDetails.Close_StartDate.CellAttributes %>>
<span id="el_BusinessDetails_Close_StartDate" class="form-group">
<span<%= BusinessDetails.Close_StartDate.ViewAttributes %>>
<%= BusinessDetails.Close_StartDate.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.Close_EndDate.Visible Then ' Close_EndDate %>
	<tr id="r_Close_EndDate">
		<td><span id="elh_BusinessDetails_Close_EndDate"><%= BusinessDetails.Close_EndDate.FldCaption %></span></td>
		<td<%= BusinessDetails.Close_EndDate.CellAttributes %>>
<span id="el_BusinessDetails_Close_EndDate" class="form-group">
<span<%= BusinessDetails.Close_EndDate.ViewAttributes %>>
<%= BusinessDetails.Close_EndDate.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.Stripe_Country.Visible Then ' Stripe_Country %>
	<tr id="r_Stripe_Country">
		<td><span id="elh_BusinessDetails_Stripe_Country"><%= BusinessDetails.Stripe_Country.FldCaption %></span></td>
		<td<%= BusinessDetails.Stripe_Country.CellAttributes %>>
<span id="el_BusinessDetails_Stripe_Country" class="form-group">
<span<%= BusinessDetails.Stripe_Country.ViewAttributes %>>
<%= BusinessDetails.Stripe_Country.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.enable_StripePaymentButton.Visible Then ' enable_StripePaymentButton %>
	<tr id="r_enable_StripePaymentButton">
		<td><span id="elh_BusinessDetails_enable_StripePaymentButton"><%= BusinessDetails.enable_StripePaymentButton.FldCaption %></span></td>
		<td<%= BusinessDetails.enable_StripePaymentButton.CellAttributes %>>
<span id="el_BusinessDetails_enable_StripePaymentButton" class="form-group">
<span<%= BusinessDetails.enable_StripePaymentButton.ViewAttributes %>>
<%= BusinessDetails.enable_StripePaymentButton.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.enable_CashPayment.Visible Then ' enable_CashPayment %>
	<tr id="r_enable_CashPayment">
		<td><span id="elh_BusinessDetails_enable_CashPayment"><%= BusinessDetails.enable_CashPayment.FldCaption %></span></td>
		<td<%= BusinessDetails.enable_CashPayment.CellAttributes %>>
<span id="el_BusinessDetails_enable_CashPayment" class="form-group">
<span<%= BusinessDetails.enable_CashPayment.ViewAttributes %>>
<%= BusinessDetails.enable_CashPayment.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.DeliveryMile.Visible Then ' DeliveryMile %>
	<tr id="r_DeliveryMile">
		<td><span id="elh_BusinessDetails_DeliveryMile"><%= BusinessDetails.DeliveryMile.FldCaption %></span></td>
		<td<%= BusinessDetails.DeliveryMile.CellAttributes %>>
<span id="el_BusinessDetails_DeliveryMile" class="form-group">
<span<%= BusinessDetails.DeliveryMile.ViewAttributes %>>
<%= BusinessDetails.DeliveryMile.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.Mon_Delivery.Visible Then ' Mon_Delivery %>
	<tr id="r_Mon_Delivery">
		<td><span id="elh_BusinessDetails_Mon_Delivery"><%= BusinessDetails.Mon_Delivery.FldCaption %></span></td>
		<td<%= BusinessDetails.Mon_Delivery.CellAttributes %>>
<span id="el_BusinessDetails_Mon_Delivery" class="form-group">
<span<%= BusinessDetails.Mon_Delivery.ViewAttributes %>>
<%= BusinessDetails.Mon_Delivery.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.Mon_Collection.Visible Then ' Mon_Collection %>
	<tr id="r_Mon_Collection">
		<td><span id="elh_BusinessDetails_Mon_Collection"><%= BusinessDetails.Mon_Collection.FldCaption %></span></td>
		<td<%= BusinessDetails.Mon_Collection.CellAttributes %>>
<span id="el_BusinessDetails_Mon_Collection" class="form-group">
<span<%= BusinessDetails.Mon_Collection.ViewAttributes %>>
<%= BusinessDetails.Mon_Collection.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.Tue_Delivery.Visible Then ' Tue_Delivery %>
	<tr id="r_Tue_Delivery">
		<td><span id="elh_BusinessDetails_Tue_Delivery"><%= BusinessDetails.Tue_Delivery.FldCaption %></span></td>
		<td<%= BusinessDetails.Tue_Delivery.CellAttributes %>>
<span id="el_BusinessDetails_Tue_Delivery" class="form-group">
<span<%= BusinessDetails.Tue_Delivery.ViewAttributes %>>
<%= BusinessDetails.Tue_Delivery.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.Tue_Collection.Visible Then ' Tue_Collection %>
	<tr id="r_Tue_Collection">
		<td><span id="elh_BusinessDetails_Tue_Collection"><%= BusinessDetails.Tue_Collection.FldCaption %></span></td>
		<td<%= BusinessDetails.Tue_Collection.CellAttributes %>>
<span id="el_BusinessDetails_Tue_Collection" class="form-group">
<span<%= BusinessDetails.Tue_Collection.ViewAttributes %>>
<%= BusinessDetails.Tue_Collection.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.Wed_Delivery.Visible Then ' Wed_Delivery %>
	<tr id="r_Wed_Delivery">
		<td><span id="elh_BusinessDetails_Wed_Delivery"><%= BusinessDetails.Wed_Delivery.FldCaption %></span></td>
		<td<%= BusinessDetails.Wed_Delivery.CellAttributes %>>
<span id="el_BusinessDetails_Wed_Delivery" class="form-group">
<span<%= BusinessDetails.Wed_Delivery.ViewAttributes %>>
<%= BusinessDetails.Wed_Delivery.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.Wed_Collection.Visible Then ' Wed_Collection %>
	<tr id="r_Wed_Collection">
		<td><span id="elh_BusinessDetails_Wed_Collection"><%= BusinessDetails.Wed_Collection.FldCaption %></span></td>
		<td<%= BusinessDetails.Wed_Collection.CellAttributes %>>
<span id="el_BusinessDetails_Wed_Collection" class="form-group">
<span<%= BusinessDetails.Wed_Collection.ViewAttributes %>>
<%= BusinessDetails.Wed_Collection.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.Thu_Delivery.Visible Then ' Thu_Delivery %>
	<tr id="r_Thu_Delivery">
		<td><span id="elh_BusinessDetails_Thu_Delivery"><%= BusinessDetails.Thu_Delivery.FldCaption %></span></td>
		<td<%= BusinessDetails.Thu_Delivery.CellAttributes %>>
<span id="el_BusinessDetails_Thu_Delivery" class="form-group">
<span<%= BusinessDetails.Thu_Delivery.ViewAttributes %>>
<%= BusinessDetails.Thu_Delivery.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.Thu_Collection.Visible Then ' Thu_Collection %>
	<tr id="r_Thu_Collection">
		<td><span id="elh_BusinessDetails_Thu_Collection"><%= BusinessDetails.Thu_Collection.FldCaption %></span></td>
		<td<%= BusinessDetails.Thu_Collection.CellAttributes %>>
<span id="el_BusinessDetails_Thu_Collection" class="form-group">
<span<%= BusinessDetails.Thu_Collection.ViewAttributes %>>
<%= BusinessDetails.Thu_Collection.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.Fri_Delivery.Visible Then ' Fri_Delivery %>
	<tr id="r_Fri_Delivery">
		<td><span id="elh_BusinessDetails_Fri_Delivery"><%= BusinessDetails.Fri_Delivery.FldCaption %></span></td>
		<td<%= BusinessDetails.Fri_Delivery.CellAttributes %>>
<span id="el_BusinessDetails_Fri_Delivery" class="form-group">
<span<%= BusinessDetails.Fri_Delivery.ViewAttributes %>>
<%= BusinessDetails.Fri_Delivery.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.Fri_Collection.Visible Then ' Fri_Collection %>
	<tr id="r_Fri_Collection">
		<td><span id="elh_BusinessDetails_Fri_Collection"><%= BusinessDetails.Fri_Collection.FldCaption %></span></td>
		<td<%= BusinessDetails.Fri_Collection.CellAttributes %>>
<span id="el_BusinessDetails_Fri_Collection" class="form-group">
<span<%= BusinessDetails.Fri_Collection.ViewAttributes %>>
<%= BusinessDetails.Fri_Collection.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.Sat_Delivery.Visible Then ' Sat_Delivery %>
	<tr id="r_Sat_Delivery">
		<td><span id="elh_BusinessDetails_Sat_Delivery"><%= BusinessDetails.Sat_Delivery.FldCaption %></span></td>
		<td<%= BusinessDetails.Sat_Delivery.CellAttributes %>>
<span id="el_BusinessDetails_Sat_Delivery" class="form-group">
<span<%= BusinessDetails.Sat_Delivery.ViewAttributes %>>
<%= BusinessDetails.Sat_Delivery.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.Sat_Collection.Visible Then ' Sat_Collection %>
	<tr id="r_Sat_Collection">
		<td><span id="elh_BusinessDetails_Sat_Collection"><%= BusinessDetails.Sat_Collection.FldCaption %></span></td>
		<td<%= BusinessDetails.Sat_Collection.CellAttributes %>>
<span id="el_BusinessDetails_Sat_Collection" class="form-group">
<span<%= BusinessDetails.Sat_Collection.ViewAttributes %>>
<%= BusinessDetails.Sat_Collection.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.Sun_Delivery.Visible Then ' Sun_Delivery %>
	<tr id="r_Sun_Delivery">
		<td><span id="elh_BusinessDetails_Sun_Delivery"><%= BusinessDetails.Sun_Delivery.FldCaption %></span></td>
		<td<%= BusinessDetails.Sun_Delivery.CellAttributes %>>
<span id="el_BusinessDetails_Sun_Delivery" class="form-group">
<span<%= BusinessDetails.Sun_Delivery.ViewAttributes %>>
<%= BusinessDetails.Sun_Delivery.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.Sun_Collection.Visible Then ' Sun_Collection %>
	<tr id="r_Sun_Collection">
		<td><span id="elh_BusinessDetails_Sun_Collection"><%= BusinessDetails.Sun_Collection.FldCaption %></span></td>
		<td<%= BusinessDetails.Sun_Collection.CellAttributes %>>
<span id="el_BusinessDetails_Sun_Collection" class="form-group">
<span<%= BusinessDetails.Sun_Collection.ViewAttributes %>>
<%= BusinessDetails.Sun_Collection.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.EnableUrlRewrite.Visible Then ' EnableUrlRewrite %>
	<tr id="r_EnableUrlRewrite">
		<td><span id="elh_BusinessDetails_EnableUrlRewrite"><%= BusinessDetails.EnableUrlRewrite.FldCaption %></span></td>
		<td<%= BusinessDetails.EnableUrlRewrite.CellAttributes %>>
<span id="el_BusinessDetails_EnableUrlRewrite" class="form-group">
<span<%= BusinessDetails.EnableUrlRewrite.ViewAttributes %>>
<%= BusinessDetails.EnableUrlRewrite.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.DeliveryCostUpTo.Visible Then ' DeliveryCostUpTo %>
	<tr id="r_DeliveryCostUpTo">
		<td><span id="elh_BusinessDetails_DeliveryCostUpTo"><%= BusinessDetails.DeliveryCostUpTo.FldCaption %></span></td>
		<td<%= BusinessDetails.DeliveryCostUpTo.CellAttributes %>>
<span id="el_BusinessDetails_DeliveryCostUpTo" class="form-group">
<span<%= BusinessDetails.DeliveryCostUpTo.ViewAttributes %>>
<%= BusinessDetails.DeliveryCostUpTo.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.DeliveryUptoMile.Visible Then ' DeliveryUptoMile %>
	<tr id="r_DeliveryUptoMile">
		<td><span id="elh_BusinessDetails_DeliveryUptoMile"><%= BusinessDetails.DeliveryUptoMile.FldCaption %></span></td>
		<td<%= BusinessDetails.DeliveryUptoMile.CellAttributes %>>
<span id="el_BusinessDetails_DeliveryUptoMile" class="form-group">
<span<%= BusinessDetails.DeliveryUptoMile.ViewAttributes %>>
<%= BusinessDetails.DeliveryUptoMile.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.Show_Ordernumner_printer.Visible Then ' Show_Ordernumner_printer %>
	<tr id="r_Show_Ordernumner_printer">
		<td><span id="elh_BusinessDetails_Show_Ordernumner_printer"><%= BusinessDetails.Show_Ordernumner_printer.FldCaption %></span></td>
		<td<%= BusinessDetails.Show_Ordernumner_printer.CellAttributes %>>
<span id="el_BusinessDetails_Show_Ordernumner_printer" class="form-group">
<span<%= BusinessDetails.Show_Ordernumner_printer.ViewAttributes %>>
<%= BusinessDetails.Show_Ordernumner_printer.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.Show_Ordernumner_Receipt.Visible Then ' Show_Ordernumner_Receipt %>
	<tr id="r_Show_Ordernumner_Receipt">
		<td><span id="elh_BusinessDetails_Show_Ordernumner_Receipt"><%= BusinessDetails.Show_Ordernumner_Receipt.FldCaption %></span></td>
		<td<%= BusinessDetails.Show_Ordernumner_Receipt.CellAttributes %>>
<span id="el_BusinessDetails_Show_Ordernumner_Receipt" class="form-group">
<span<%= BusinessDetails.Show_Ordernumner_Receipt.ViewAttributes %>>
<%= BusinessDetails.Show_Ordernumner_Receipt.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
<% If BusinessDetails.Show_Ordernumner_Dashboard.Visible Then ' Show_Ordernumner_Dashboard %>
	<tr id="r_Show_Ordernumner_Dashboard">
		<td><span id="elh_BusinessDetails_Show_Ordernumner_Dashboard"><%= BusinessDetails.Show_Ordernumner_Dashboard.FldCaption %></span></td>
		<td<%= BusinessDetails.Show_Ordernumner_Dashboard.CellAttributes %>>
<span id="el_BusinessDetails_Show_Ordernumner_Dashboard" class="form-group">
<span<%= BusinessDetails.Show_Ordernumner_Dashboard.ViewAttributes %>>
<%= BusinessDetails.Show_Ordernumner_Dashboard.ViewValue %>
</span>
</span>
</td>
	</tr>
<% End If %>
</table>
<% If BusinessDetails.Export = "" Then %>
<% If Not IsObject(BusinessDetails_view.Pager) Then Set BusinessDetails_view.Pager = ew_NewPrevNextPager(BusinessDetails_view.StartRec, BusinessDetails_view.DisplayRecs, BusinessDetails_view.TotalRecs) %>
<% If BusinessDetails_view.Pager.RecordCount > 0 Then %>
<div class="ewPager">
<span><%= Language.Phrase("Page") %>&nbsp;</span>
<div class="ewPrevNext"><div class="input-group">
<div class="input-group-btn">
<!--first page button-->
	<% If BusinessDetails_view.Pager.FirstButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerFirst") %>" href="<%= BusinessDetails_view.PageUrl %>start=<%= BusinessDetails_view.Pager.FirstButton.Start %>"><span class="icon-first ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerFirst") %>"><span class="icon-first ewIcon"></span></a>
	<% End If %>
<!--previous page button-->
	<% If BusinessDetails_view.Pager.PrevButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerPrevious") %>" href="<%= BusinessDetails_view.PageUrl %>start=<%= BusinessDetails_view.Pager.PrevButton.Start %>"><span class="icon-prev ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerPrevious") %>"><span class="icon-prev ewIcon"></span></a>
	<% End If %>
</div>
<!--current page number-->
	<input class="form-control input-sm" type="text" name="<%= EW_TABLE_PAGE_NO %>" value="<%= BusinessDetails_view.Pager.CurrentPage %>">
<div class="input-group-btn">
<!--next page button-->
	<% If BusinessDetails_view.Pager.NextButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerNext") %>" href="<%= BusinessDetails_view.PageUrl %>start=<%= BusinessDetails_view.Pager.NextButton.Start %>"><span class="icon-next ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerNext") %>"><span class="icon-next ewIcon"></span></a>
	<% End If %>
<!--last page button-->
	<% If BusinessDetails_view.Pager.LastButton.Enabled Then %>
	<a class="btn btn-default btn-sm" title="<%= Language.Phrase("PagerLast") %>" href="<%= BusinessDetails_view.PageUrl %>start=<%= BusinessDetails_view.Pager.LastButton.Start %>"><span class="icon-last ewIcon"></span></a>
	<% Else %>
	<a class="btn btn-default btn-sm disabled" title="<%= Language.Phrase("PagerLast") %>"><span class="icon-last ewIcon"></span></a>
	<% End If %>
</div>
</div>
</div>
<span>&nbsp;<%= Language.Phrase("of") %>&nbsp;<%= BusinessDetails_view.Pager.PageCount %></span>
</div>
<% End If %>
<div class="clearfix"></div>
<% End If %>
</form>
<% If BusinessDetails.Export <> "" Then %>
<script type="text/javascript">
ew_ApplyTemplate("body", "", "BusinessDetailsview", "<%= BusinessDetails.CustomExport %>");
</script>
<% End If %>
<script type="text/javascript">
fBusinessDetailsview.Init();
</script>
<%
BusinessDetails_view.ShowPageFooter()
If EW_DEBUG_ENABLED Then Response.Write ew_DebugMsg()
%>
<% If BusinessDetails.Export = "" Then %>
<script type="text/javascript">
// Write your table-specific startup script here
// document.write("page loaded");
</script>
<% End If %>
<!--#include file="footer.asp"-->
<%

' Drop page object
Set BusinessDetails_view = Nothing
%>
<%

' -----------------------------------------------------------------
' Page Class
'
Class cBusinessDetails_view

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
		TableName = "BusinessDetails"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "BusinessDetails_view"
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
		EW_TABLE_NAME = "BusinessDetails"

		' Open connection to the database
		If IsEmpty(Conn) Then Call ew_Connect()

		' Export options
		Set ExportOptions = New cListOptions
		ExportOptions.TableVar = BusinessDetails.TableVar
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
		If BusinessDetails.Export = "" Then
			SetupBreadcrumb()
		End If
		If IsPageRequest Then ' Validate request
			If Request.QueryString("ID").Count > 0 Then
				BusinessDetails.ID.QueryStringValue = Request.QueryString("ID")
			ElseIf Request.Form("ID").Count > 0 Then
				BusinessDetails.ID.FormValue = Request.Form("ID")
			Else
				bLoadCurrentRecord = True
			End If

			' Get action
			BusinessDetails.CurrentAction = "I" ' Display form
			Select Case BusinessDetails.CurrentAction
				Case "I" ' Get a record to display
					StartRec = 1 ' Initialize start position
					Set Recordset = LoadRecordset() ' Load records
					TotalRecs = Recordset.RecordCount ' Get record count
					If TotalRecs <= 0 Then ' No record found
						If SuccessMessage = "" And FailureMessage = "" Then
							FailureMessage = Language.Phrase("NoRecord") ' Set no record message
						End If
						sReturnUrl = "BusinessDetailslist.asp"
					ElseIf bLoadCurrentRecord Then ' Load current record position
						SetUpStartRec() ' Set up start record position

						' Point to current record
						If CLng(StartRec) <= CLng(TotalRecs) Then
							bMatchRecord = True
							Recordset.Move StartRec-1
						End If
					Else ' Match key values
						Do While Not Recordset.Eof
							If CStr(BusinessDetails.ID.CurrentValue&"") = CStr(Recordset("ID")&"") Then
								BusinessDetails.StartRecordNumber = StartRec ' Save record position
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
						sReturnUrl = "BusinessDetailslist.asp" ' No matching record, return to list
					Else
						Call LoadRowValues(Recordset) ' Load row values
					End If
			End Select
		Else
			sReturnUrl = "BusinessDetailslist.asp" ' Not page request, return to list
		End If
		If sReturnUrl <> "" Then Call Page_Terminate(sReturnUrl)

		' Render row
		BusinessDetails.RowType = EW_ROWTYPE_VIEW
		Call BusinessDetails.ResetAttrs()
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
				BusinessDetails.StartRecordNumber = StartRec
			ElseIf Request.QueryString(EW_TABLE_PAGE_NO).Count > 0 Then
				PageNo = Request.QueryString(EW_TABLE_PAGE_NO)
				If IsNumeric(PageNo) Then
					StartRec = (PageNo-1)*DisplayRecs+1
					If StartRec <= 0 Then
						StartRec = 1
					ElseIf StartRec >= ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1 Then
						StartRec = ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1
					End If
					BusinessDetails.StartRecordNumber = StartRec
				End If
			End If
		End If
		StartRec = BusinessDetails.StartRecordNumber

		' Check if correct start record counter
		If Not IsNumeric(StartRec) Or StartRec = "" Then ' Avoid invalid start record counter
			StartRec = 1 ' Reset start record counter
			BusinessDetails.StartRecordNumber = StartRec
		ElseIf CLng(StartRec) > CLng(TotalRecs) Then ' Avoid starting record > total records
			StartRec = ((TotalRecs-1)\DisplayRecs)*DisplayRecs+1 ' Point to last page first record
			BusinessDetails.StartRecordNumber = StartRec
		ElseIf (StartRec-1) Mod DisplayRecs <> 0 Then
			StartRec = ((StartRec-1)\DisplayRecs)*DisplayRecs+1 ' Point to page boundary
			BusinessDetails.StartRecordNumber = StartRec
		End If
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
		AddUrl = BusinessDetails.AddUrl("")
		EditUrl = BusinessDetails.EditUrl("")
		CopyUrl = BusinessDetails.CopyUrl("")
		DeleteUrl = BusinessDetails.DeleteUrl
		ListUrl = BusinessDetails.ListUrl
		SetupOtherOptions()

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
		End If

		' Call Row Rendered event
		If BusinessDetails.RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call BusinessDetails.Row_Rendered()
		End If
	End Sub

	' Set up Breadcrumb
	Sub SetupBreadcrumb()
		Dim PageId, url
		Set Breadcrumb = New cBreadcrumb
		url = Mid(ew_CurrentUrl, InStrRev(ew_CurrentUrl, "/")+1)
		Call Breadcrumb.Add("list", BusinessDetails.TableVar, "BusinessDetailslist.asp", "", BusinessDetails.TableVar, True)
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
