<%
' WorldPay Hosted Payment Page (HTML Redirect) - Select Junior Integration - worldpayconfig.asp
' Copyright (C) 2013 WorldPay
' Support: support@worldpay.com

' ------------------------------------------------------

' Created:		11/02/2013
' Created By:	Bruno Leite, WorldPay
' Version:		1.0
' Language: 	ASP Classic

' ------------------------------------------------------

' Terms of Use:

' These terms are supplemental to your relevant Merchant Services Agreement with WorldPay and apply to your use of the attached software, code, scripts documentation and files (the "Code"). 

' The Code may be modified without limitation by WorldPay.

' The Code is provided solely for the purpose of integrating the Customer's system with the relevanht WorldPay Gateway and must not be used or modified in any way to allow it to work with any other gateway/payment system other than that which is provided by the WorldPay group of companies.

' ------------------------------------------------------

' Disclaimer: 
' The Code is provided 'as is' without warranty of any kind, either express or implied, including, but not limited to, the implied warranties of fitness for a purpose, or the warranty of non-infringement. Without limiting the foregoing,WorldPay makes no warranty that:
' i.the Code will meet your requirements
' ii.the Code will be uninterrupted, timely, secure or error-free
' iii any errors in the Code obtained will be corrected.

' WorldPay assumes no responsibility for errors or ommissions in the Code.

' In no event shall WorldPay be liable to the Customer or any third parties for any special, punitive, incidental, indirect or consequential damages of any kind, or any damages whatsoever, including, without limitation, those resulting from loss of use, data or profits, whether or not WorldPay has been advised of the possibility of such damages, and on any theory of liability, arising out of or in connection with the use of the Code.

' The use of the Code is at the Customer's own discretion and risk and with agreement that the Customer will be solely responsible for any damage to its computer system or loss of data that results from such activities. No advice or information, whether oral or written, obtained by the Customer from WorldPay shall create any warranty for the Code.
' This code is provided on an "as is" basis and no warranty express or implied is provided. It is the responsibility of the customer to test its implementation and function.

' Any use of the Code shall be deemed to be confirmation of the Customer's agreement to these supplemental terms.

' ------------------------------------------------------

'You will need to edit this file and set the various variable values below BEFORE you upload the files to your server.

'
'Mandatory Parameters to submit a transaction. The mandatory parameters to be submit a transaction to WorldPay are the instId, cartId, description, amount(which is populated in the paymentToken.asp), 
'**********************************************

'You can find your installation ID by logging into your Merchant Administration Interface (MAI) at http://www.worldpay.com/admin. Once logged in if you click on installations, you will be able to see your installation ID. This is usually a six digit number.


'If your website is still in test mode please change the parameter to Y. If it is in live mode please change to N. Please note that selecting "testing" to "Y" will change the submission URL from "https://secure.worldpay.com/wcc/purchase" to "https://secure-test.worldpay.com/wcc/purchase" and the testMode value will change from "0" to "100".
'testing = "N"'(Y/N)

'cartPrefix is what will be appended before your cartId parameter being passed to WorldPay. For example if you would like to generate a unique order code with your company name before you could do so by using the cartPrefix.
cartPrefix = "World-"

'The currencyCode indicates the currency that your WorldPay account currently supports. Please see a list of the following currencies.
'GBP - Great British Pounds
'USD - US Dollars
'EUR - Euros
'CAD - Canadian Dollars
currencyCode = "GBP"

'captureDelay indicates how long it will take for a transaction to be captured once it has been authorised. The captureDelay parameter should be the same as you currently have in your WorldPay account. To find this information, once you have logged into your worldPay account, if you click on "Profile" and then "Configuration Details" you will be able to see the "Capture Delay" set. The values will vary between 0-14 days and Off. 
'Please note that we only recommend that the capture delay is set to a maximum of 5 days, as anything longer increases the chances of a chargeback or the order not being successfully captured.  
captureDelay = 0

'**********************************************
'End of mandatory parameters


'Optional parameters
'**********************************************

'MD5 Secret Key. This can be set under your installation ID in the field "MD5 Secret for transactions". For this to be able to work you will need to set the following in the "Signature Fields" field.
'currency:amount:testMode:instId
MD5secretKey = ""

'The preferredMerchantAccount parameters will enable you to select which merchant code you would like payments to go through. You can select a total of three diferent ones. So for example if you would like payments to go through a specific merchant account you can input your preferred WorldPay merchant account between the "". The first one to be used will be "preferredMerchantAccount1", if for some reason we cannot use the first one (incorrect currency, different capture delay settings, etc.), we will use the "preferredMerchantAccount2" and then "prefferedMerchantAccount3". If you do not know this information or you only have one merchant account you may leave these fields blank.
preferredMerchantAccount1 = "MERCHANTCODE1"
preferredMerchantAccount2 = "MERCHANTCODE2"
preferredMerchantAccount3 = ""

'buttonText allows you to change the name of the submit button, for example if instead of taking payments on your website you were taking donations.
buttonText = "Make Payment"

'The card logo section below allows you to add the specific card logos that your WorldPay account supports.
cardVisa = "N" '(Y/N)
cardMastercard = "Y" '(Y/N)
cardMaestro = "Y" '(Y/N)
cardJCB = "N" '(Y/N)
cardAmex = "N" '(Y/N)
cardELV = "Y" '(Y/N)

'billingAddress allows you to pass the customers billing address to WorldPays payment pages without the customer having to input their details again.
billingAddress = "N"'(Y/N)

'withDelivery allows you to have an additional field in our payment pages. If you would like to pass the details through the your page before coming to please enable the deliveryAdddress.
withDelivery = "Y"' (Y/N)

'deliveryAddress allows you to pass the delivery address details to WorldPays payment pages without the customer having to input their details again.
deliveryAddress = "Y"' (Y/N)

'fixedDetails means that the customer can see the billing details that your system has passed through to us but it will not let them edit the details. When enabling this feature please ensure that "billingAddress" is set to "Y" otherwise you will encounter an error message.
fixedContactDetails = "Y"' (Y/N)

'hideDetails will make sure that the details that the customer passes through cannot be seen or edited. It is similar to the "fixedDetails" feature however it will not display the details passed. When enabling this feature please ensure that "billingAddress" is set to "Y" otherwise you will encounter an error message. If "hideDetails" and "fixedDetails" are enabled, "hideDetails" will override "fixedDetails"
hideContactDetails = "N"' (Y/N)

'**********************************************
'End of optional parameters



'YOU DO NOT NEED TO CONFIGURE ANYTHING BELOW THIS LINE.
'______________________________________________________________

'Capture Delay script
'**********************************************
capDelay = CStr(captureDelay)
Dim captureDelay, authModeError
If capDelay = Off Then
	authMode = "E"
ElseIf capDelay =< 14 Then
	authMode = "A"
Else
	authModeError=("This is not a valid Capture Delay setting. This will be set to 0 days by default.")
	authMOde = "A"

End If	
'**********************************************


'Testmode script
'**********************************************
Dim testing
If testing = "Y" Then
	urlLink = "https://secure-test.worldpay.com/wcc/purchase"
	testMode = 100
Else
	urlLink = "https://secure.worldpay.com/wcc/purchase"
	testMode = 0
End If
'**********************************************


'Manual card logo display script.
'**********************************************
'Visa Display script

displayVisa = ""
Dim cardVisa
If cardVisa = "Y" then
	displayVisa = "<img src=http://www.worldpay.com/images/cardlogos/VISA.gif border=0 alt='Visa Credit payments supported by WorldPay'>"
End If

'Mastercard Display script
displayMastercard = ""
Dim cardMastercard
If cardMastercard = "Y" then
	displayMastercard = "<img src=http://www.worldpay.com/images/cardlogos/mastercard.gif border=0 alt='Mastercard payments supported by WorldPay'>"
End If

'Maestro Display script
displayMaestro = ""
Dim cardMaestro
If cardMaestro = "Y" then
	displayMaestro = "<img src=http://www.worldpay.com/images/cardlogos/maestro.gif border=0 alt='Maestro payments supported by WorldPay'>"
End If

'JCB Display script
displayJCB = ""
Dim cardJCB
If cardJCB = "Y" then
	displayJCB = "<img src=http://www.worldpay.com/images/cardlogos/JCB.gif border=0 alt='JCB payments supported by WorldPay'>"
End If

'Amex Display script
displayAmex = ""
Dim cardAmex
If cardAmex = "Y" then
	displayAmex = "<img src=http://www.worldpay.com/images/cardlogos/AMEX.gif border=0 alt='American Express payments supported by WorldPay'>"
End If

'ELV Display script
displayELV = ""
Dim cardELV
If cardELV = "Y" then
	displayELV = "<img src=http://www.worldpay.com/images/cardlogos/ELV.gif border=0 alt='ELV payments supported by WorldPay'>"
End If
'**********************************************

'billingAddress script
'**********************************************
billingDetails = "<!--"
billingClose = "-->"
Dim billingAddress
If billingAddress = "Y" Then
	billingDetails = ""
	billingClose = ""
End If
'**********************************************

'withDelivery script
'**********************************************
Dim withDelivery
If withDelivery = "Y" Then
	delivery = "true"
Else
	delivery = "false"	
End If
'**********************************************

'deliveryAddress script
'**********************************************
deliveryDetails = "<!--"
deliveryClose = "-->"
If deliveryAddress = "Y" Then
	deliveryDetails = ""
	deliveryClose = ""
	delivery = "true"
End If
'**********************************************

'fixedDetails script
'**********************************************
fixContact = "false"
If fixedContactDetails = "Y" Then
	fixContact = "true"
End If
'**********************************************

'hideDetails script
'**********************************************
hideContact = "false"
If hideContactDetails = "Y" Then
	hideContact = "true"
End If
'**********************************************

%>