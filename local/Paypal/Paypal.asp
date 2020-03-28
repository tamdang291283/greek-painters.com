<!-- #include file="../../Config.asp" -->
<!-- #include file="../../timezone.asp" -->
<!-- #include file="../../restaurantsettings.asp" -->
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

Dim iTxnId
Dim iItemNumber, iPaymentStatus, iPaymentAmount, iRestaurantId
Dim iPayerEmail, iRestaurantEmail


iTxnId = Request.QueryString("tx")
if iTxnId <> "" then 
    iItemNumber = Request.QueryString("item_number")
Else 
    iTxnId = Request.Form("tx")
    iItemNumber = Request.Form("item_number")
end if
  WriteLog server.MapPath("Paypal-IPN.txt"),"Request Data:" & Request.Form
iItemNumber = Replace(UCase(iItemNumber),"IR-","")
response.write iItemNumber  & "<BR>"
dim iQuery
iQuery = "cmd=_notify-synch&tx=" & iTxnId & "&at=" & PAYPAL_PDT

'set objHttp = Server.CreateObject("Microsoft.XMLHTTP")
    set objHttp = Server.CreateObject("MSXML2.ServerXMLHTTP")
objHttp.open "POST", PAYPAL_URL, false
objHttp.setRequestHeader "Content-type", "application/x-www-form-urlencoded"
objHttp.Send iQuery
response.write PAYPAL_URL & "<BR>"
response.write iQuery & "<BR>"
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
    
     objCon.Open sConnString
     objRds.Open "select * from [OrdersLocal]  " & _
            "where Id = " & iItemNumber, objCon

    iPayerEmail = objRds("Email")
    iRestaurantId = objRds("IdBusinessDetail")

    check1 = iPaymentStatus = "Completed" Or True
    'check1 = iPaymentStatus = "Completed" 
    check2 = Not objRds.Eof
    check3 = cdbl(iPaymentAmount) = cdbl(objRds("OrderTotal")) Or True
    
    objRds.Close
   ' objCon.Close

   ' objCon.Open sConnString
    objRds.Open "select * from [BusinessDetails]  " & _
            "where Id = " & iRestaurantId, objCon

    iRestaurantEmail = objRds("Email")
    
    objRds.Close
   ' objCon.Close

    'response.write SITE_URL & "Email.asp?id_o=" & iItemNumber & "&id_r=" & iRestaurantId

 if check1 and check2 and check3  then

    'Session.Abandon
	  '  objCon.Open sConnString
    objRds.Open "SELECT * FROM [OrdersLocal] WHERE Id = " & iItemNumber, objCon, 1, 3 
    objRds("Payment_Status") = "Paid"
    objRds.Update 
    
    objRds.Close
 

   'SendEmail MAIL_SUBJECT, SITE_URL & "Email.asp?id_o=" & iItemNumber & "&id_r=" & iRestaurantId  , iRestaurantEmail
   'SendEmail MAIL_CUSTOMER_SUBJECT, SITE_URL & "Email.asp?id_o=" & iItemNumber & "&id_r=" & iRestaurantId  , iPayerEmail
    dim ThankURL
      ThankURL =SITE_URL &   "Thanks.asp?id_o=" & iItemNumber & "&id_r=" & iRestaurantId  
    if iItemNumber & "" <> "" then
       ' dim objCon1
       ' Set objCon1 = Server.CreateObject("ADODB.Connection")
        '    objCon1.Open sConnString
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
        ThankURL  = replace(lcase(ThankURL),lcase(SITE_URL),lcase(SITE_URL)&"local/")
       ' objCon1.Close 
    end if
        set objRds = nothing
        objCon.Close 
    set    objCon = nothing   
   Response.Redirect ThankURL
   
 else
                set objRds = nothing
           objCon.Close 
    set    objCon = nothing  
    Response.write "DATI PAGAMENTO NON CORRETTI"
 end if

else
  Response.write "PAYPAL INVALID " & objHttp.responseText
end if


set objHttp = nothing

%>
