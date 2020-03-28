<!-- #include file="../Config.asp" -->
<!--#include file="../md5.asp"-->
<%
    if session("restaurantid")="" or Request.Form("order_id") & "" = "" then
response.redirect(SITE_URL & "/error.asp")
end if%>
<!-- #include file="../timezone.asp" -->
<!-- #include file="../restaurantsettings.asp" -->
<!--#include file="../payments/worldpay/worldpayconfig.asp"-->

<% 
 sub WriteLog(logFilePath, logContent)
         if setWriteLog = false then
                exit sub
          end if 
        On Error Resume Next
            Dim logobjFSO, logFile
            set logobjFSO = CreateObject("Scripting.FileSystemObject")
            set logFile = logobjFSO.OpenTextFile(logFilePath,8,true) ' 8 is for appending
            logFile.WriteLine(now() & ": " & logContent)
            set logFile = nothing
            set logobjFSO = nothing
        On Error GoTo 0
    End sub

Response.Cookies("validate_pc").Expires=dateadd("D",-1,Date())



Set objCon = Server.CreateObject("ADODB.Connection")
Set objRds = Server.CreateObject("ADODB.Recordset") 

        
objCon.Open sConnString
objRds.Open "SELECT * FROM [Orderslocal] WHERE Id = " & Request.Form("order_id"), objCon, 1, 3 

Dim iItemNumber, iRestaurantId, iRestaurantEmail, iEmail
iItemNumber = objRds("ID")
iRestaurantId = objRds("IdBusinessDetail")

     dim ThankURL
  '   objCon.Open sConnString
    if iRestaurantId & "" <> "" then
            ThankURL = SITE_URL & "Thanks.asp?id_o=" & iItemNumber & "&id_r=" & iRestaurantId  
           dim rs_url :  set rs_url = Server.CreateObject("ADODB.Recordset")
               rs_url.open  "SELECT FromLink FROM URL_REWRITE a inner join BusinessDetails b on (a.RestaurantID=b.ID )  where RestaurantID=" & iRestaurantId & " and EnableUrlRewrite = 'Yes' and status = 'ACTIVE' "  ,objCon
            while not rs_url.eof 
              if instr(lcase(rs_url("FromLink")),"/thanks") > 0 then
                     ThankURL = rs_url("FromLink") & "/" & iItemNumber
               end if 
               rs_url.movenext()
           wend
            rs_url.close()
        set rs_url =  nothing
             if instr( lcase(SITE_URL) ,"https://") > 0  then
                    ThankURL  = replace(ThankURL,"http://","https://")  
            end if
            ThankURL  = replace(lcase(ThankURL),lcase(SITE_URL),lcase(SITE_URL)&"local/")
    end if

if  objRds("Payment_Status") & "" = "Paid" then       
           objRds.Close
           objCon.Close  
             set objRds = nothing
            set objCon = nothing
         Response.Redirect ThankURL
elseif objRds("OrderDate")  & "" <> "" and objRds("PaymentType")  = "Cash on Delivery" then         
          objRds.Close
          objCon.Close
         set objRds = nothing
        set objCon = nothing
         Response.Redirect ThankURL
end if

objRds("OrderDate") = DateAdd("h",houroffsetreal,now)

Dim tempAddress, OrderTotal
tempAddress = Request.Form("Address")

If Request.Form("HouseNumber") & "" <> "" Then
    tempAddress = Request.Form("HouseNumber") & " " & tempAddress
End If

If Request.Form("Address2") & "" <> "" Then
    tempAddress = tempAddress & ", " & Request.Form("Address2")
End If

objRds("Address") = tempAddress

objRds("PostalCode") = Request.Form("Postcode")
objRds("Notes") = Request.Form("Special")
  
if Request.Form("payment_type") = "paypal" then
    if  objRds("Payment_Status") & "" <> "Paid" then
        objRds("PaymentType") = "Paypal"
    end if
else
if Request.Form("payment_type") = "nochex" then
    if  objRds("Payment_Status") & "" <> "Paid" then
        objRds("PaymentType") = "nochex"
    end if
 elseif Request.Form("payment_type") = "stripe" or Request.Form("Stripe_Token") & "" <> ""  then
         if  objRds("Payment_Status") & "" <> "Paid" then
            objRds("PaymentType") = "stripe"
        end if
else
if Request.Form("payment_type") = "worldpay" then
    if  objRds("Payment_Status") & "" <> "Paid" then
        objRds("PaymentType") = "worldpay"
    end if
else
    objRds("PaymentType") = "Cash on Delivery"
end if
end if
end if

'If ServiceChargePercentage & "" <> "" AND ServiceChargePercentage & "" <> "0"  Then
'    objRds("ServiceCharge")  = (Cdbl(ServiceChargePercentage)*0.01*CDbl(objRds("SubTotal")))
'    objRds("OrderTotal") = FormatNumber( (Cdbl(ServiceChargePercentage)*0.01*CDbl(objRds("SubTotal"))) + CDbl(objRds("SubTotal")),2)
'Else
'    objRds("ServiceCharge") = 0
'End If
if Request.Form("payment_type") = "stripe" or Request.Form("Stripe_Token") & "" <> "" or  Request.Form("payment_type") = "paypal" or Request.Form("payment_type") = "nochex"  or Request.Form("payment_type") = "worldpay" then
    If CREDITCARDSURCHARGE & "" <> "" And CREDITCARDSURCHARGE & "" <> "0" Then
         if objRds("PaymentSurcharge") & "" = "" or objRds("PaymentSurcharge") &"" = "0" then
            objRds("PaymentSurcharge") = CREDITCARDSURCHARGE
          ' objRds("OrderTotal") = Cdbl(objRds("PaymentSurcharge")) + CDbl(objRds("OrderTotal"))
        end if
    Else
        objRds("PaymentSurcharge") = 0
    End If
Else 
      if objRds("PaymentSurcharge") & "" <> "" and objRds("PaymentType") = "Cash on Delivery"  then
        objRds("OrderTotal") =  CDbl(objRds("OrderTotal")) - Cdbl(objRds("PaymentSurcharge")) 
    end if 
    objRds("PaymentSurcharge") = 0
End If
OrderTotal = objRds("OrderTotal")

iEmail = Request.Form("Email")

objRds.Update 
    
     
objRds.Close
  '  set objRds = nothing
'objCon.Close    
 '   set objCon = nothing

%>
   <script type="text/javascript" src="<%=SITE_URL %>/Scripts/jquery.min.js"></script>
    <style>
         .modal {
           
            position:   fixed;
            z-index:    1000;
            top:        30%;
            left:       0;
            right:0;            
            height:     100%;
            width:      500px;
            margin: 0 auto;
            text-align:center;       
            opacity: 0.80;
            -ms-filter: progid:DXImageTransform.Microsoft.Alpha(Opacity = 80);
            filter: alpha(opacity = 80);

        }
            .modal span {
                display:block;
                clear:both;
                margin-top:10px;
                font-size:20px;
            }
       
    </style>

         <div class="modal">
             <img  src="<%=SITE_URL %>images/animation.gif"/>
             <span>Processing....</span>
         </div>
<%  if  Request.Form("payment_type") = "paypal" or Request.Form("payment_type") = "nochex"  or Request.Form("payment_type") = "worldpay" or Request.Form("payment_type") = "stripe" or Request.Form("Stripe_Token") & "" <> "" then

   ' Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 
   ' objCon.Open sConnString
    objRds.Open "SELECT * FROM BusinessDetails WHERE Id = " & iRestaurantId, objCon
    PAYPAL_ADDR=objRds("PAYPAL_ADDR")
    objRds.Close
  
 %>

        <%if Request.Form("payment_type") = "paypal" then%>
     
        <form action="<%= PAYPAL_URL %>" method="post">

            <input type="hidden" name="cmd" value="_xclick" />
            <input type="hidden" name="business" value="<%=PAYPAL_ADDR%>"/>
            <input type="hidden" name="item_name" value="Order Nr. <%= Request.Form("order_id")%>"/>
            <input type="hidden" name="item_number" value="<%= "IR-" & Request.Form("order_id")%>"/>    
            <input type="hidden" name="amount" value="<%= FormatNumber(cdbl(OrderTotal), 2) %>"/>
            <!--<input type="hidden" name="amount" value="10" />-->
            <input type="hidden" name="currency_code" value="<%=Currency_PAYPAL %>"/>
            <input type="hidden" name="bn" value="PP-BuyNowBF"/>
	        <input type="hidden" name="rm" value="2"/>
            <input type="hidden" name="return" value="<%= SITE_URL %>local/paypal/Paypal.asp"/>
            <input type="hidden" name="shipping" value="0"/>
        </form>

        <script language="javascript">    
            document.forms[0].submit();
        </script>

        <%  
            

         end if%>


<%
     dim StripeResult : StripeResult =  true
     if Request.Form("Stripe_Token") & "" <> "" then        
         Dim StripeURL, APIKey
             StripeURL = "https://api.stripe.com/v1/charges"
             APIKey = STRIPEAPIKEY
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
	    requestBody = "currency=" & Currency_STRIPE &  "&amount=" & (cdbl(cost) * 100)  &"&source="& token	
   
	    chargeCardWithToken = makeStripeAPICall(requestBody)
    End Function
    dim iPayerEmail 
    iPayerEmail = iEmail 
    
      dim result : result =  chargeCardWithToken(Request.Form("Stripe_Token"),Request.Form("amount") ) 
      iRestaurantEmail = CONFIRMATION_EMAIL_ADDRESS 
        WriteLog server.MapPath("Payments/stripe/Stripe-process.txt"),"stripeToken=  " &  Request.Form("stripeToken")& " Amount " & Request.Form("amount")  
       WriteLog server.MapPath("Payments/stripe/Stripe-process.txt"),"Start stripeprocess.asp  OrderID =  " & Request.Form("order_id") & " " & result  
   
      if instr(result ,"""status"": ""succeeded""") > 0  then
            ' set objCon = Server.CreateObject("ADODB.Connection")
            ' objCon.Open sConnString
            Set objRds = Server.CreateObject("ADODB.Recordset") 
            objRds.Open "SELECT * FROM [OrdersLocal] WHERE Id = " & Request.Form("order_id"), objCon, 1, 3 
            objRds("OrderTotal") = Request.Form("amount") + objRds("PaymentSurcharge")
            objRds("PaymentType") = "Stripe"
            objRds("Payment_Status")  = "Paid"
            objRds.Update 
    
            objRds.Close
            set objRds = nothing
            objCon.Close 
           set objCon =  nothing
           
          
           'SendEmail MAIL_SUBJECT, SITE_URL & "Email.asp?id_o=" & Request.Form("order_id") & "&id_r=" & iRestaurantId  , iRestaurantEmail
           'SendEmail MAIL_CUSTOMER_SUBJECT, SITE_URL & "Email.asp?id_o=" & Request.Form("order_id") & "&id_r=" & iRestaurantId  , iPayerEmail
          '  Response.Redirect SITE_URL &"Thanks.asp?id_o=" & OrderID & "&id_r=" & iRestaurantId   
            Response.Clear
             Response.Redirect ThankURL
         Response.End
      end if  
     StripeResult = false
     elseif Request.Form("payment_type") = "stripe" then 
            
        %>
 <script src="https://checkout.stripe.com/checkout.js"></script>
 
    <button id="customButton" style="visibility:hidden;">Processing</button>

    <script>
    var isOpen = false;
    var handler = StripeCheckout.configure({
        key: '<%=STRIPEKEY %>',
        image: 'https://stripe.com/img/documentation/checkout/marketplace.png',
        locale: 'auto',
        token: function(token) {
        //console.log(token);
        isOpen = false;
        $.ajax({
            type: "POST",
            url: "<%=SITE_URL %>payments/stripe/stripeprocess_local.asp",
            data: {txtAmount:<%=FormatNumber(OrderTotal,2) * 100  %>,iRestaurantId:<%=iRestaurantId %>,txtOrderID:<%=Request.Form("order_id") %>,stripeToken:token.id},
            success: function(response){
                                       
                if(response.indexOf("OK:") > -1)
                    {
                        location.href =     response.replace("OK:",""); 
                    }
                else
                {
                    alert("Process card is failed!");
                            window.history.back();
                }
            }
                                
        });
        },
        opened: function() {
  	    console.log("Form opened");
        isOpen =  true;
        },
        closed: function() {  	                            
        
            if(isOpen==true)
                window.history.back();
             else
                $(".modal").show();  
            console.log("ok2");
        }
    });

    document.getElementById('customButton').addEventListener('click', function(e) {
        // Open Checkout with further options:
        handler.open({
        name: '<%=Request.Form("FirstName") & " " & Request.Form("LastName") %>',
        description: 'Payment Charge',
        amount: <%=FormatNumber(OrderTotal,2) * 100 %>,
        currency:'<%=Currency_STRIPE %>',

        });
        e.preventDefault();
    });

    // Close Checkout on page navigation:
    window.addEventListener('popstate', function() {
        handler.close();
                              
    });
        <% if instr(paymentType,"-paid") >  0 then   %>
            location.href= "<%=ThankURL %>";
        <% else %>
       document.getElementById("customButton").click()
        <% end if %>
    </script>

        <%
     end if
    
     %>
<% if StripeResult =  false then %>
  <a href="javascript:window.history.back();">The transaction was unsuccessful.  Please go back and try again."</a>
            <script type="text/javascript">
                alert("The transaction was unsuccessful.  Please go back and try again.")
                window.history.back();
            </script>
<% 
        set objRds = nothing
                 objCon.Close  
             set objCon =  nothing 
    Response.End

       

    end if %>
<%if Request.Form("payment_type") = "worldpay" then%>
     

<form  method="post" action="<%=urlLink%>">
<input type="hidden" name="instId" value="<%=installationID%>" />
<input type="hidden" name="amount" value="<%= FormatNumber(cdbl(OrderTotal), 2) %>" />
<input type="hidden" name="cartId" value="<%= "IR-" & Request.Form("order_id")%>" />
<input type="hidden" name="currency" value="<%=currencyCode%>" />
<input type="hidden" name="testMode" value="<%=testMode%>"  />
<input type="hidden" name="desc" value="Online Payment"/>
<input type="hidden" name="authMode" value="<%=authMode%>"/><%=authModeError%>
<input type="hidden" name="name" value="<%=Request.Form("FirstName")%> <%=Request.Form("LastName")%>" />
<input type="hidden" name="address1" value="<%=Request.Form("HouseNumber") & " " & Request.Form("Address")%>" />
<input type="hidden" name="town" value="<%=Request.Form("Address2")%>" />
<input type="hidden" name="postcode" value="<%=Request.Form("Postcode")%>" />
<input type="hidden" name="email" value="<%=Request.Form("Email")%>" />
<input type="hidden" name="signature" value="<%=md5 (""& MD5secretKey &":" & SignatureFields & "") %>" />


</form>

<script language="javascript">    
    document.forms[0].submit();
</script>




<%
  

    end if%>

<%if Request.Form("payment_type") = "nochex" then%>
     
<form method="POST" action="https://secure.nochex.com/">
<input type="hidden" name="merchant_id" value="<%=NOCHEXMERCHANTID%>">
<input type="hidden" name="amount" value="<%= FormatNumber(cdbl(OrderTotal), 2) %>">
<input type="hidden" name="description" value="Order Payment">
<input type="hidden" name="success_url" value="<%= SITE_URL %>local/nochex/nochex.asp?iItemNumber=<%= Request.Form("order_id")%>">
<input type="hidden" name="order_id" value="<%= "IR-" & Request.Form("order_id")%>">
</form>

<script language="javascript">    
    document.forms[0].submit();
</script>

<%
    end if%>

<%
	session("vOrderId")=Request.Form("order_id")
     set objRds = nothing
        objCon.Close  
    set objCon =  nothing 

 Else 
    ' Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 
   ' objCon.Open sConnString
    objRds.Open "SELECT bd.* " & _
            " FROM BusinessDetails bd " & _
            " WHERE bd.Id = " & iRestaurantId, objCon 

    iRestaurantEmail =  objRds("Email")

    objRds.Close

    objCon.Close


    'Session.Abandon
	session("vOrderId")=Request.Form("order_id")

'response.write "subject=" & MAIL_SUBJECT & "<BR>"
'response.write "url=" & SITE_URL & "Email.asp?id_o=" & iItemNumber & "&id_r=" & iRestaurantId & "<BR>"
'response.write "email=" & iRestaurantEmail & "<BR>"
'response.write "customersubject=" & MAIL_CUSTOMER_SUBJECT & "<BR>"
response.write "email=" & iEmail & "<BR>"

  '  SendEmail MAIL_SUBJECT, SITE_URL & "Email.asp?id_o=" & iItemNumber & "&id_r=" & iRestaurantId  , CONFIRMATION_EMAIL_ADDRESS
   ' SendEmail MAIL_CUSTOMER_SUBJECT, SITE_URL & "Email.asp?id_o=" & iItemNumber & "&id_r=" & iRestaurantId  , iEmail
    set objRds = nothing
    set objCon = nothing
    Response.Redirect ThankURL 

End If %>