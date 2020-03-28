<!-- #include file="Config.asp" -->
<!-- #include file="timezone.asp" -->
<!-- #include file="restaurantsettings.asp" -->
<!--#include file="payments/worldpay/worldpayconfig.asp"-->
<!--#include file="md5.asp"-->
<%if session("restaurantid")="" or Request.Form("order_id") & "" = ""  then
    response.redirect("error.asp")
end if%>
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
    function IsDifferentSubTotal(byval OrderID, byval conn,byval ResID, byval vOrderSubTotal)
        dim result : result = false 
        dim objRds 
        set objRds_Order = Server.CreateObject("ADODB.Recordset")   
        objRds_Order.Open "SELECT vouchercodediscount,Vouchercode,SubTotal, isnull((select  Sum(Total)  from OrderItems with(nolock)  where OrderId  = " &OrderID& "),0) as subtotalcart   FROM Orders with(nolock)  WHERE Id = " & OrderID, conn, 1, 3 
        dim Subtotal : Subtotal  = 0
        dim subtotalcart : subtotalcart  = 0
        dim Vouchercode : Vouchercode = ""
        dim vouchercodediscount : vouchercodediscount = ""
        if not objRds_Order.EOF then
            'Subtotal = cdbl( objRds_Order("SubTotal"))
            subtotalcart = cdbl(objRds_Order("subtotalcart"))
            Vouchercode = objRds_Order("Vouchercode")
            vouchercodediscount = objRds_Order("vouchercodediscount")
            if  Vouchercode & "" <> "" then   
                dim RS_VoucherCode : set RS_VoucherCode  = Server.CreateObject("ADODB.Recordset")
                    RS_VoucherCode.Open "SELECT minimumamount,vouchercodediscount FROM vouchercodes with(nolock)   where IdBusinessDetail=" & ResID & " and vouchercode='" & Vouchercode & "'", conn, 1, 3 
                if not RS_VoucherCode.EOF then
                    if cdbl(RS_VoucherCode("minimumamount"))  > subtotalcart then
                        dim RS_OrderItem : set  RS_OrderItem = Server.CreateObject("ADODB.Recordset")
                            RS_OrderItem.Open "Select isnull(Sum(Total),0)  As Total from [OrderItems]     " & _
                                              " Where OrderId = " & OrderID & " And MenuItemPropertyId Is Null and  MenuItemId in (select Id from MenuItems   where hidedish  = 1 )  ", conn ,1,3  
                            if not RS_OrderItem.EOF then
                                if subtotalcart & "" <> ""  and RS_OrderItem("Total") & "" <> "" then
                                    subtotalcart  = CDbl(subtotalcart) - CDbl(RS_OrderItem("Total") )
                                end if
                            end if
                                RS_OrderItem.close()
                            set RS_OrderItem = nothing 
                    else
                          subtotalcart=subtotalcart-((subtotalcart/100)*RS_VoucherCode("vouchercodediscount"))
                    end if
                end if
                        RS_VoucherCode.close()
                    set RS_VoucherCode = nothing
            end if
        end if
        objRds_Order.close()
        set objRds_Order = nothing 
            
            if vOrderSubTotal  <> subtotalcart then
                result =  true
            end if
        IsDifferentSubTotal = result
    end function 
if Request.Form("cookies")="yes" then
    Response.Cookies("FirstName").Expires=dateadd("D",90,Date())
    Response.Cookies("LastName").Expires=dateadd("D",90,Date())
    Response.Cookies("Email").Expires=dateadd("D",90,Date())
    Response.Cookies("Phone").Expires=dateadd("D",90,Date())
    Response.Cookies("HouseNumber").Expires=dateadd("D",90,Date())
    Response.Cookies("Address").Expires=dateadd("D",90,Date())
    Response.Cookies("Address2").Expires=dateadd("D",90,Date())
    Response.Cookies("Postcode").Expires=dateadd("D",90,Date())
    Response.Cookies("DeliveryDistance").Expires=dateadd("D",90,Date())
    Response.Cookies("FirstName")=Request.Form("FirstName")
    Response.Cookies("LastName")=Request.Form("LastName")
    Response.Cookies("Email")=Request.Form("Email")
    Response.Cookies("Phone")=Request.Form("Phone")
    Response.Cookies("HouseNumber")=Request.Form("HouseNumber")
    Response.Cookies("Address")=Request.Form("Address")
    Response.Cookies("Address2")=Request.Form("Address2")
    Response.Cookies("Postcode")=Request.Form("Postcode")
    Response.Cookies("DeliveryDistance")=Request.Form("delivery_distance")   
end if


Set objCon = Server.CreateObject("ADODB.Connection")
Set objRds = Server.CreateObject("ADODB.Recordset") 
objCon.Open sConnString
objRds.Open "SELECT * FROM [Orders] WHERE Id = " & Request.Form("order_id"), objCon, 1, 3 
    
iItemNumber = objRds("ID")
iRestaurantId = objRds("IdBusinessDetail")
dim vOrderSubTotal : vOrderSubTotal  = Request.Form("vOrderSubTotal")

         dim ThankURL
  '   objCon.Open sConnString
   
    if iRestaurantId & "" <> "" then
             dim MenuURL 
                 MenuURL =  SITE_URL & "menu.asp?id_r=" & iRestaurantId

            ThankURL = SITE_URL & "Thanks.asp?id_o=" & iItemNumber & "&id_r=" & iRestaurantId  
           dim rs_url :  set rs_url = Server.CreateObject("ADODB.Recordset")
               rs_url.open  "SELECT FromLink FROM URL_REWRITE a inner join BusinessDetails b on (a.RestaurantID=b.ID )  where RestaurantID=" & iRestaurantId & " and EnableUrlRewrite = 'Yes' and status = 'ACTIVE' "  ,objCon
            while not rs_url.eof 
              if instr(lcase(rs_url("FromLink")),"/menu") > 0 then
                     MenuURL = rs_url("FromLink")
               elseif instr(lcase(rs_url("FromLink")),"/thanks") > 0 then
                     ThankURL = rs_url("FromLink") & "/" & iItemNumber
               end if 
               rs_url.movenext()
           wend
            rs_url.close()
        set rs_url =  nothing
             if instr( lcase(SITE_URL) ,"https://") > 0  then
                    ThankURL  = replace(ThankURL,"http://","https://")  
            end if
           ' ThankURL  = replace(lcase(ThankURL),lcase(SITE_URL),lcase(SITE_URL)&"local/")
        if vOrderSubTotal & "" <> "" then
                if IsDifferentSubTotal(iItemNumber,objCon,iRestaurantId,cdbl( vOrderSubTotal)) = true then
                        objRds.Close
                        objCon.Close  
                    set objRds = nothing
                    set objCon = nothing
                    %>
                          <script type="text/javascript">
                              alert("Shopping cart contents do not match payment value.  Please start again...");
                              document.location.href="<%=MenuURL%>";
                          </script>  
                    <%
                end if
        end if 

    end if

    
    
'if  instr( lcase( objRds("PaymentType") & "" ),"-paid") > 0 then       
    if objRds("Payment_Status") = "Paid" then
           objRds.Close
           objCon.Close  
          set objRds = nothing
            set objCon = nothing
         'Response.Redirect "Thanks.asp?id_o=" & iItemNumber & "&id_r=" & iRestaurantId  
        Response.Redirect ThankURL
elseif objRds("OrderDate")  & "" <> "" and objRds("PaymentType")  = "Cash on Delivery" then         
          objRds.Close
          objCon.Close
             set objRds = nothing
            set objCon = nothing
        ' Response.Redirect "Thanks.asp?id_o=" & iItemNumber & "&id_r=" & iRestaurantId  
        Response.Redirect ThankURL
end if
'objRds("OrderDate") = DateAdd("h",houroffsetreal,now)
objRds("OrderDate") = DateAdd("h",houroffset,now)
objRds("FirstName") = Request.Form("FirstName")
objRds("LastName") = Request.Form("LastName")
objRds("Email") = Request.Form("Email")
objRds("Phone") = Request.Form("Phone")

Dim tempAddress
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
   ' if  instr( lcase( objRds("PaymentType") & "" ),"-paid") = 0 then
     if objRds("Payment_Status") & "" <>  "Paid" then
        objRds("PaymentType") = "Paypal"
    end if
else
    if Request.Form("payment_type") = "nochex" then
       ' if  instr( lcase( objRds("PaymentType") & "" ),"-paid") = 0 then
          if objRds("Payment_Status") & "" <>  "Paid" then
            objRds("PaymentType") = "nochex"
        end if
    elseif Request.Form("payment_type") = "stripe" or Request.Form("Stripe_Token") & "" <> ""  then
        ' if  instr( lcase( objRds("PaymentType") & "" ),"-paid") = 0 then
        if objRds("Payment_Status") & "" <>  "Paid" then
            objRds("PaymentType") = "Stripe"
        end if
    else
        if Request.Form("payment_type") = "worldpay" then
           ' if  instr( lcase( objRds("PaymentType") & "" ),"-paid") = 0 then
            if objRds("Payment_Status") & "" <>  "Paid" then
                objRds("PaymentType") = "worldpay"
            end if
        else
            
                objRds("PaymentType") = "Cash on Delivery"
            
        end if

    end if
end if
dim paymentType : paymentType = objRds("PaymentType")
Dim OrderTotal
' Task 277
WriteLog server.MapPath("PaymentSurcharge.txt")," before makeorder.asp  OrderID = "  &  Request.Form("order_id") & " PaymentSurcharge "  & objRds("PaymentSurcharge")
if Request.Form("payment_type") = "stripe" or Request.Form("Stripe_Token") & "" <> "" or Request.Form("payment_type") = "paypal" or Request.Form("payment_type") = "nochex"  or Request.Form("payment_type") = "worldpay" then
    If CREDITCARDSURCHARGE & "" <> "" And CREDITCARDSURCHARGE & "" <> "0" Then
          
        if objRds("PaymentSurcharge") & "" = "" or objRds("PaymentSurcharge") &"" = "0" then
            objRds("PaymentSurcharge") = CREDITCARDSURCHARGE
            'objRds("OrderTotal") = Cdbl(objRds("PaymentSurcharge")) + CDbl(objRds("OrderTotal"))
        end if
    Else
        objRds("PaymentSurcharge") = 0
    End If
Else 
    if objRds("PaymentSurcharge") & "" <> "" and objRds("PaymentType") = "Cash on Delivery"  then
        'objRds("OrderTotal") =  CDbl(objRds("OrderTotal")) - Cdbl(objRds("PaymentSurcharge")) 
    end if 
    objRds("PaymentSurcharge") = 0
End If
' Task 277
WriteLog server.MapPath("PaymentSurcharge.txt")," after makeorder.asp  OrderID = "  &  Request.Form("order_id") & " PaymentSurcharge "  & objRds("PaymentSurcharge")
OrderTotal = CDbl( objRds("OrderTotal")) + cdbl( objRds("PaymentSurcharge"))
Dim iItemNumber, iRestaurantId, iRestaurantEmail, iEmail


iEmail = Request.Form("Email")

objRds.Update 
 if not objRds.EOF then
    WriteLog server.MapPath("receiptpage.txt")," MakeOrder.asp  OrderID = "  &  Request.Form("order_id") & " payment type "  & objRds("PaymentType")
 end if
     
objRds.Close
set objRds = nothing
'objCon.Close    
'set objCon = nothing
%>
 <script type="text/javascript" src="<%=SITE_URL %>Scripts/jquery.min.js"></script>
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
<%  if Request.Form("payment_type") = "paypal" or Request.Form("Stripe_Token") & "" <> "" or Request.Form("payment_type") = "nochex"  or Request.Form("payment_type") = "worldpay" or Request.Form("payment_type") = "stripe"  then

          if Request.Form("payment_type") = "paypal" then %>
     
                <form action="<%= PAYPAL_URL %>" method="post">
                    <input type="hidden" name="cmd" value="_xclick" />
                    <input type="hidden" name="business" value="<%=PAYPAL_ADDR%>"/>
                    <input type="hidden" name="item_name" value="Order Nr. <%= Request.Form("order_id")%>"/>
                    <input type="hidden" name="item_number" value="<%= Request.Form("order_id")%>"/>    
                    <input type="hidden" name="amount" value="<%= FormatNumber(OrderTotal,2) %>"/>
                    <!--<input type="hidden" name="amount" value="10" />-->
                    <input type="hidden" name="currency_code" value="<%=Currency_PAYPAL %>"/>
                    <input type="hidden" name="bn" value="PP-BuyNowBF"/>
	                <input type="hidden" name="rm" value="2"/>
                    <input type="hidden" name="return" value="<%= SITE_URL %>payments/paypal/Paypal.asp"/>
                    <input type="hidden" name="shipping" value="0"/>
                </form>

                <script language="javascript">    
                    document.forms[0].submit();
                </script>

        <%end if%>


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
                    Set objRds = Server.CreateObject("ADODB.Recordset") 
                    objRds.Open "SELECT * FROM [Orders] WHERE Id = " & Request.Form("order_id"), objCon, 1, 3 
                    objRds("OrderTotal") = Request.Form("amount") + objRds("PaymentSurcharge")
                    objRds("PaymentType") = "Stripe"
                     objRds("Payment_Status") = "Paid"
                    objRds.Update 
    
                    objRds.Close
                    objCon.Close 
           
          
                   SendEmail MAIL_SUBJECT, SITE_URL & "Email.asp?id_o=" & Request.Form("order_id") & "&id_r=" & iRestaurantId  , iRestaurantEmail
                   SendEmail MAIL_CUSTOMER_SUBJECT, SITE_URL & "Email.asp?id_o=" & Request.Form("order_id") & "&id_r=" & iRestaurantId  , iPayerEmail
                  '  Response.Redirect SITE_URL &"Thanks.asp?id_o=" & OrderID & "&id_r=" & iRestaurantId   
                    Response.Clear
                    'Response.Redirect "Thanks.asp?id_o=" & Request.Form("order_id") & "&id_r=" & iRestaurantId  
                    Response.Redirect ThankURL
                 Response.End
              end if  
             StripeResult = false

     elseif Request.Form("payment_type") = "stripe" then 
        %>
            <script src="https://checkout.stripe.com/checkout.js"></script>
           
            <button id="customButton" style="visibility:hidden;">Processing</button>

            <script type="text/javascript">
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
                    url: "<%=SITE_URL %>payments/stripe/stripeprocess.asp",
                    data: {txtAmount:<%= CDbl(FormatNumber(OrderTotal,2)) * 100  %>,iRestaurantId:<%=iRestaurantId %>,txtOrderID:<%=Request.Form("order_id") %>,stripeToken:token.id},
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
                amount: <%= cdbl( FormatNumber(OrderTotal,2)) * 100 %>,
                currency:'<%=Currency_STRIPE%>',

                });
                e.preventDefault();
            });

            // Close Checkout on page navigation:
            window.addEventListener('popstate', function() {
                handler.close();
                              
            });
                <% if instr(paymentType,"-paid") >  0 then   %>
                    location.href= "<%=ThankURL%>";
                <% else %>
                $("#customButton").click();
                <% end if %>
            </script>

        <%
     end if
    if StripeResult = false then
    %>
            <a href="javascript:window.history.back();">The transaction was unsuccessful.  Please go back and try again."</a>
            <script type="text/javascript">
                alert("The transaction was unsuccessful.  Please go back and try again.")
                window.history.back();
            </script>

    <%
        Response.End
    end if
     %>

    <%if Request.Form("payment_type") = "worldpay" then%>
        <form  method="post" action="<%=urlLink%>">
        <input type="hidden" name="instId" value="<%=installationID%>" />
        <input type="hidden" name="amount" value="<%= OrderTotal %>" />
        <input type="hidden" name="cartId" value="<%= Request.Form("order_id")%>" />
        <input type="hidden" name="currency" value="<%=Currency_WOLRDPAY%>" />
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
    <%end if%>

    <%if Request.Form("payment_type") = "nochex" then%>
     
        <form method="POST" action="https://secure.nochex.com/">
        <input type="hidden" name="merchant_id" value="<%=NOCHEXMERCHANTID%>">
        <input type="hidden" name="amount" value="<%= OrderTotal %>">
        <input type="hidden" name="description" value="Order Payment">
        <input type="hidden" name="success_url" value="<%= SITE_URL %>nochex.asp?iItemNumber=<%= Request.Form("order_id")%>">
        <input type="hidden" name="order_id" value="<%= Request.Form("order_id")%>">
        </form>
        <script language="javascript">    
            document.forms[0].submit();
        </script>

    <%end if%>

<%
	session("vOrderId")=Request.Form("order_id")

 Else 

    'objCon.Open sConnString
    Set objRds = Server.CreateObject("ADODB.Recordset") 
    objRds.Open "SELECT bd.* " & _
            " FROM BusinessDetails bd " & _
            " WHERE bd.Id = " & iRestaurantId, objCon 

    iRestaurantEmail =  objRds("Email")
     MAIL_FROM = objRds("MAIL_FROM")
     MAIL_SUBJECT=objRds("MAIL_SUBJECT")
     MAIL_CUSTOMER_SUBJECT=objRds("MAIL_CUSTOMER_SUBJECT")
        objRds.Close
    set objRds = nothing
        objCon.Close
    set objCon = nothing
    'Session.Abandon
	session("vOrderId")=Request.Form("order_id")

'response.write "subject=" & MAIL_SUBJECT & "<BR>"
'response.write "url=" & SITE_URL & "Email.asp?id_o=" & iItemNumber & "&id_r=" & iRestaurantId & "<BR>"
'response.write "email=" & iRestaurantEmail & "<BR>"
'response.write "customersubject=" & MAIL_CUSTOMER_SUBJECT & "<BR>"
'response.write "email=" & iEmail & "<BR>"
    'Response.Write( SITE_URL & "Email.asp?id_o=" & iItemNumber & "&id_r=" & iRestaurantId)
    'Response.End
   SendEmail MAIL_SUBJECT, SITE_URL & "Email.asp?id_o=" & iItemNumber & "&id_r=" & iRestaurantId  , CONFIRMATION_EMAIL_ADDRESS
   SendEmail MAIL_CUSTOMER_SUBJECT, SITE_URL & "Email.asp?id_o=" & iItemNumber & "&id_r=" & iRestaurantId  , iEmail

    'Response.Redirect "Thanks.asp?id_o=" & iItemNumber & "&id_r=" & iRestaurantId  
    Response.Redirect ThankURL

End If %>