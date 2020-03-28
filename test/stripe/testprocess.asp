<%@ LANGUAGE = "VBSCRIPT" %>
<%
    
    Dim StripeURL, APIKey
        StripeURL = "https://api.stripe.com/v1/charges"
        APIKey = "sk_test_1BP2gvrVMfLXVwRkcOZqJmfZ"

Function makeStripeAPICall(requestBody)
	Dim objXmlHttpMain
	
	Set objXmlHttpMain = CreateObject("Msxml2.ServerXMLHTTP") 
	On Error Resume Next
	objXmlHttpMain.open "POST", StripeURL, False
	objXmlHttpMain.setRequestHeader "Authorization", "Bearer "& APIKey
	objXmlHttpMain.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
	objXmlHttpMain.send requestBody

	makeStripeAPICall = objXmlHttpMain.responseText
End Function

Function chargeCard(month, year, cvc, number, cost)
	Dim cardDetails, requestBody
	cardDetails = "source[exp_month]="& month &"&source[exp_year]="& year &"&source[number]="& number &"&source[cvc]="& cvc
	requestBody = "currency=usd&amount="& cost &"&source[object]=card&"& cardDetails
	
	chargeCard = makeStripeAPICall(requestBody)
End Function

Function chargeCardWithToken(byval token,byval cost)
	Dim requestBody
	requestBody = "currency=usd&amount=" & cost &"&source="& token	
	chargeCardWithToken = makeStripeAPICall(requestBody)
End Function

    Response.Write(chargeCardWithToken(Request.Form("stripeToken"),999) )
    'Response.End
'call chargeCard("01", "20", "123", "4242424242424242", "400")


     %>