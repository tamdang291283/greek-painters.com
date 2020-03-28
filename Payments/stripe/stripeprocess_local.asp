<%@ LANGUAGE = "VBSCRIPT" %>

<!-- #include file="../../Config.asp" -->
<!-- #include file="../../timezone.asp" -->
<!-- #include file="../../restaurantsettings.asp" -->
<%
 
    Dim StripeURL, APIKey
        StripeURL = "https://api.stripe.com/v1/charges"
        APIKey = STRIPEAPIKEY
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
	requestBody = "currency=gbp&amount=" & cost &"&source="& token	
	chargeCardWithToken = makeStripeAPICall(requestBody)
End Function
        dim objCon , objRds
      dim OrderID : OrderID = Request.Form("txtOrderID")
     ' Response.Write("OrderID " & OrderID )
       Set objCon = Server.CreateObject("ADODB.Connection")
      Set objRds = Server.CreateObject("ADODB.Recordset") 
       
     objCon.Open sConnString
     objRds.Open "select * from [OrdersLocal] where Id = " & OrderID, objCon

   
    iPayerEmail = objRds("Email")
    iRestaurantId = objRds("IdBusinessDetail")
    objRds.Close
   ' objCon.Close 
   

      dim iRestaurantId :  iRestaurantId = Request.Form("iRestaurantId")
      dim result : result =  chargeCardWithToken(Request.Form("stripeToken"),Request.Form("txtAmount") ) 

   ' objCon.Open sConnString
    'objRds.Open "select * from [BusinessDetails]  " & _
     '       "where Id = " & iRestaurantId, objCon

    'iRestaurantEmail = objRds("Email")
    
   ' objRds.Close
    'objCon.Close

        WriteLog server.MapPath("Stripe-process_local.txt"),"Start stripeprocess_local.asp  OrderID =  " & OrderID & " " & result   
      if instr(result ,"""status"": ""succeeded""") > 0 then
          '  Set objCon = Server.CreateObject("ADODB.Connection")
            Set objRds = Server.CreateObject("ADODB.Recordset") 
          '  objCon.Open sConnString

             dim ThankURL
                  ThankURL =  SITE_URL &"Thanks.asp?id_o=" & OrderID & "&id_r=" & iRestaurantId 
               dim rs_url :  set rs_url = Server.CreateObject("ADODB.Recordset")
                       rs_url.open "SELECT FromLink FROM URL_REWRITE a inner join BusinessDetails b on (a.RestaurantID=b.ID )  where RestaurantID=" & iRestaurantId & " and EnableUrlRewrite = 'Yes' and status = 'ACTIVE' "    ,objCon
                    while not rs_url.eof 
                      if instr(lcase(rs_url("FromLink")),"/thanks") > 0 then
                             ThankURL = rs_url("FromLink") & "/" & OrderID
                       end if 
                       rs_url.movenext()
                   wend
                    rs_url.close()
                set rs_url =  nothing
                if instr( lcase(SITE_URL) ,"https://") > 0  then
                    ThankURL  = replace(ThankURL,"http://","https://")  
                end if
                ThankURL  = replace(lcase(ThankURL),lcase(SITE_URL),lcase(SITE_URL)&"local/")

            objRds.Open "SELECT * FROM [OrdersLocal] WHERE Id = " & OrderID, objCon, 1, 3 
            'objRds("PaymentType") = "Stripe-Paid"
            objRds("Payment_Status") = "Paid"
            objRds.Update 
    
            objRds.Close
            set objRds =  nothing
            objCon.Close 
            set objCon = nothing
           'Response.Write("iRestaurantEmail " & iRestaurantEmail & " iPayerEmail " & iPayerEmail)
          
          ' SendEmail MAIL_SUBJECT, SITE_URL & "Email.asp?id_o=" & OrderID & "&id_r=" & iRestaurantId  , iRestaurantEmail
          ' SendEmail MAIL_CUSTOMER_SUBJECT, SITE_URL & "Email.asp?id_o=" & OrderID & "&id_r=" & iRestaurantId  , iPayerEmail
            Response.Clear
            Response.Write("OK:" & ThankURL  )  
         Response.End
      end if  
      set objRds =  nothing
            objCon.Close 
            set objCon = nothing
     Response.Write("failed")
     %>