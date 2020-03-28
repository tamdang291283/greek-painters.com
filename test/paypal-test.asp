<%
    Dim Item_name, Item_number, Payment_status, Payment_amount
Dim Txn_id, Receiver_email, Payer_email
Dim objHttp, str
' read post from PayPal system and add 'cmd'
str = Request.Form & "&cmd=_notify-validate"
    str = "mc_gross=20.40&protection_eligibility=Eligible&address_status=confirmed&payer_id=EM65VADNWXYV2&tax=0.00&address_street=Add+1%0D%0AAdd+2&payment_date=07%3A37%3A58+Jun+21%2C+2016+PDT&payment_status=Pending&charset=windows-1252&address_zip=95134&first_name=test&address_country_code=US&address_name=test+buyer&notify_version=3.8&custom=&payer_status=verified&business=danghai88-facilitator%40gmail.com&address_country=United+States&address_city=San+jose&quantity=1&verify_sign=AZenMl5LsTknAP1wvQY.IJnuNDytAd9iUCEaGuV7F0tgiHZC54pcBDA-&payer_email=danghai88-buyer%40gmail.com&txn_id=22W39306M2992905A&payment_type=instant&last_name=buyer&address_state=CA&receiver_email=danghai88-facilitator%40gmail.com&receiver_id=KA9RM8QASHLTQ&pending_reason=multi_currency&txn_type=web_accept&item_name=Order+Nr.+1271&mc_currency=GBP&item_number=1271&residence_country=US&test_ipn=1&handling_amount=0.00&transaction_subject=&payment_gross=&shipping=0.00&ipn_track_id=ca5474797f53" & "&cmd=_notify-validate"
' post back to PayPal system to validate


'objHttp = Server.CreateObject("WinHttp.WinHttpRequest.5.1")
'objHttp.option (9) = 2720

set objHttp = Server.CreateObject("Microsoft.XMLHTTP")

' set objHttp = Server.CreateObject("MSXML4.ServerXMLHTTP")

'Set objhttp = Server.CreateObject ("MSXML4.XMLHTTP.6.0")


'objHttp.open "POST", "https://www.paypal.com/cgi-bin/webscr", false

objHttp.open "POST", "https://www.sandbox.paypal.com/cgi-bin/webscr", false
'objHttp.setOption 2, 13056
'objHttp.setOption 3,"certificate store name/friendlyname of certificate"
Response.Write("Request to paypal: " & "https://www.sandbox.paypal.com/cgi-bin/webscr")
objHttp.setRequestHeader "Content-type", "application/x-www-form-urlencoded"
objHttp.Send str  
Response.Write("<br /> Request status code: " & objHttp.status)
Response.Write("<br /> Response text: " & objHttp.responseText)
    Response.end()
     %>