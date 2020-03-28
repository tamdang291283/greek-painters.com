<!-- #include file="../../Config.asp" -->
<!-- #include file="../../timezone.asp" -->
<!-- #include file="../../restaurantsettings.asp" -->
<%
Dim iTxnId
Dim iItemNumber, iPaymentStatus, iPaymentAmount, iRestaurantId
Dim iPayerEmail, iRestaurantEmail
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

iTxnId = Request.QueryString("tx")
if iTxnId <> "" then 
    iItemNumber = Request.QueryString("item_number")
    if iItemNumber & "" = "" then
        iItemNumber = Request.QueryString("item_number1")
    end if
Else 
    iTxnId = Request.Form("tx")
    iItemNumber = Request.Form("item_number")
    if iItemNumber & "" = "" then
        iItemNumber = Request.Form("item_number1")
    end if
end if
    if iItemNumber & "" = "" then
        WriteLog server.MapPath("Paypal-IPN.txt"),"Start Paypal.asp  OrderID = empty "  
        Response.End
    end if
    WriteLog server.MapPath("Paypal-IPN.txt"),"Start Paypal.asp  OrderID = "  & iItemNumber  
response.write iItemNumber  & "<BR>"
dim iQuery
iQuery = "cmd=_notify-synch&tx=" & iTxnId & "&at=" & PAYPAL_PDT

    
    'Response.Write("PAYPAL_URL " & PAYPAL_URL & "<br/>")
    'Response.Write("iQuery " & iQuery & "<br/>")
    'Response.End

   ' WriteLog server.MapPath("Paypal-IPN.txt"),"PAYPAL_URL = "  & PAYPAL_URL  
'set objHttp = Server.CreateObject("Microsoft.XMLHTTP")
    set objHttp = Server.CreateObject("MSXML2.ServerXMLHTTP")
    
 ' set objHttp =  Server.CreateObject ("MSXML2.XMLHTTP.6.0")
objHttp.open "POST", PAYPAL_URL, false
objHttp.setRequestHeader "Content-type", "application/x-www-form-urlencoded"
objHttp.Send iQuery
response.write PAYPAL_URL & "<BR>"
response.write iQuery & "<BR>"
    
   WriteLog server.MapPath("Paypal-IPN.txt")," OrderID = "  & iItemNumber & " responseText = " & objHttp.responseText & " objHttp.statu " & objHttp.status

if (objHttp.status <> 200 ) then
   Response.write "HTTP ERROR " & objHttp.status
elseif Mid(objHttp.responseText, 1, 7)  = "SUCCESS" then
    
    Dim sParts, iParts, aParts
    iQuery = Mid(objHttp.responseText, 9)

    sParts = Split(iQuery, " ")
    iParts = UBound(sParts) - 1
    ReDim sResults(iParts, 1)
    
    For i = 0 To iParts
        aParts = Split(sParts(i), "=")
        sKey = aParts(0)
        sValue = aParts(1)
        sResults(i, 0) = sKey
        sResults(i, 1) = sValue
        Response.write sKey
        Select Case sKey
            Case "payment_status"
                iPaymentStatus = sValue
            Case "mc_gross"
                iPaymentAmount = cdbl(sValue)
        End Select
    Next

    Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 
     dim sentEmail : sentEmail  = ""
     objCon.Open sConnString
     objRds.Open "select * from [Orders]  " & _
            "where Id = " & iItemNumber, objCon

    iPayerEmail = objRds("Email")
    sentEmail = objRds("SentEmail")
    iRestaurantId = objRds("IdBusinessDetail")
     WriteLog server.MapPath("Paypal-IPN.txt")," OrderID = "  & iItemNumber & " Paypal Status = " & objHttp.responseText
    check1 = iPaymentStatus = "Completed" Or True
    'check1 = iPaymentStatus = "Completed" 
    check2 = Not objRds.Eof
    check3 = cdbl(iPaymentAmount) = (cdbl(objRds("OrderTotal")) + Cdbl(objRds("PaymentSurcharge")) ) Or True
    
    objRds.Close
    'objCon.Close

    'objCon.Open sConnString
    objRds.Open "select * from [BusinessDetails]  " & _
            "where Id = " & iRestaurantId, objCon

    'iRestaurantEmail = objRds("Email")
    iRestaurantEmail = objRds("CONFIRMATION_EMAIL_ADDRESS")
    
    objRds.Close
    'objCon.Close

    response.write SITE_URL & "Email.asp?id_o=" & iItemNumber & "&id_r=" & iRestaurantId

 if check1 and check2 and check3  then

    'Session.Abandon
	    'objCon.Open sConnString
    objRds.Open "SELECT * FROM [Orders] WHERE Id = " & iItemNumber, objCon, 1, 3 
    if objRds("PaymentType") & "" <> "Paypal-Paid" and  objRds("Payment_Status") & "" <> "Paid" then
        objRds("OrderTotal") = Cdbl(objRds("PaymentSurcharge")) + CDbl(objRds("OrderTotal"))
    end if
    objRds("Payment_Status") = "Paid"
    objRds("OrderDate") = DateAdd("h",houroffset,now)
    if sentEmail & "" <> "yes" then
        objRds("SentEmail") = "yes"
    end if
    objRds.Update 
    
    objRds.Close
    'objCon.Close 
    if sentEmail & "" <> "yes" then
       SendEmail MAIL_SUBJECT, SITE_URL & "Email.asp?id_o=" & iItemNumber & "&id_r=" & iRestaurantId  , iRestaurantEmail
       SendEmail MAIL_CUSTOMER_SUBJECT, SITE_URL & "Email.asp?id_o=" & iItemNumber & "&id_r=" & iRestaurantId  , iPayerEmail
        WriteLog server.MapPath("Paypal-IPN.txt"),"Paypal.asp OrderID = "  & Item_number & " CONFIRMATION_EMAIL_ADDRESS  =  " & iRestaurantEmail & " iPayerEmail " & iPayerEmail
    end if


  dim ThankURL
      ThankURL =SITE_URL &   "Thanks.asp?id_o=" & iItemNumber & "&id_r=" & iRestaurantId  
   WriteLog server.MapPath("Paypal-IPN.txt"),"Redirect Thanks.asp page OrderID = "  & iItemNumber & " iRestaurantId " & iRestaurantId
    if iItemNumber & "" <> "" then
        'dim objCon1
        'Set objCon1 = Server.CreateObject("ADODB.Connection")
         '   objCon1.Open sConnString
        dim objRds1 : set objRds1 = Server.CreateObject("ADODB.Recordset")
        objRds1.Open "SELECT * FROM [Orders] WHERE Id = " & iItemNumber, objCon, 1, 3 
        if not objRds1.EOF then
             WriteLog server.MapPath("Paypal-IPN.txt")," Paypal-ipn-new.asp End OrderID = "  & iItemNumber & " PaymentType " & objRds1("PaymentType")
        end if
        objRds1.Close
        set objRds1 = nothing
         
                   dim rs_url :  set rs_url = Server.CreateObject("ADODB.Recordset")
                       rs_url.open "SELECT FromLink FROM URL_REWRITE a inner join BusinessDetails b on (a.RestaurantID=b.ID )  where RestaurantID=" & iRestaurantId & " and EnableUrlRewrite = 'Yes' and status = 'ACTIVE' "   ,objCon
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
        'objCon1.Close 
        'set objCon1 = nothing
    end if
    set objRds = nothing
    objCon.close()
    set objCon = nothing

   Response.Redirect ThankURL 
   
 else
    WriteLog server.MapPath("Paypal-IPN.txt"),"DATI PAGAMENTO NON CORRETTI  OrderID = "  & iItemNumber 
    Response.write "DATI PAGAMENTO NON CORRETTI"
 end if

else
    WriteLog server.MapPath("Paypal-IPN.txt"),"PAYPAL INVALID  OrderID = "  & iItemNumber 
  Response.write "PAYPAL INVALID " & objHttp.responseText
end if

     set objRds = nothing
       ' objCon.close()
    set objCon = nothing
set objHttp = nothing

%>
