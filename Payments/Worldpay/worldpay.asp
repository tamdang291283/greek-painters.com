<!-- #include file="../../Config.asp" -->


<%
 
    Function WriteLog(logFilePath, logContent)
        On Error Resume Next
            Dim logobjFSO, logFile
            set logobjFSO = CreateObject("Scripting.FileSystemObject")
            set logFile = logobjFSO.OpenTextFile(logFilePath,8,true) ' 8 is for appending
            logFile.WriteLine(now() & ": " & logContent)
            set logFile = nothing
            set logobjFSO = nothing
        On Error GoTo 0
    End Function
Dim iTxnId
Dim iItemNumber, iPaymentStatus, iPaymentAmount, iRestaurantId
Dim iPayerEmail, iRestaurantEmail


iItemNumber = Request.form("cartId")
If Instr(UCase(iItemNumber),"IR-") > 0 Then
   Server.Transfer("../../local/worldpay/worldpay.asp")
End If

iPaymentAmount = Request.form("authAmount")
iPaymentStatus = Request.form("transStatus")

dim filesys, filetxt
Const ForReading = 1, ForWriting = 2, ForAppending = 8
Set filesys = CreateObject("Scripting.FileSystemObject")
Set filetxt = filesys.OpenTextFile(server.mappath("worldpay.txt"), ForAppending, True)

filetxt.WriteLine("iItemNumber:" & Request.form("cartId"))
filetxt.WriteLine("iPaymentAmount:" & Request.form("authAmount"))
filetxt.WriteLine("iPaymentStatus:" & Request.form("transStatus"))
filetxt.Close 
   ' Response.Write(now & " houroffset1 " & DateAdd("h",houroffset,now) & "<br/>")
    ' Response.Write("houroffset " & houroffset & "<br/>")
    if iItemNumber & "" = "" then
                 WriteLog server.MapPath("worldpay.txt"),"Start Paypal.asp  OrderID = empty "  
                Response.End
    end if

    Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 
    
     objCon.Open sConnString
     objRds.Open "select * from [Orders]  " & _
            "where Id = " & iItemNumber, objCon

    iPayerEmail = objRds("Email")
    iRestaurantId = objRds("IdBusinessDetail")
	session("restaurantid")=objRds("IdBusinessDetail")
   
	%>
<!-- #include file="../../timezone.asp" -->
<!-- #include file="../../restaurantsettings.asp" -->
<%
    WriteLog server.MapPath("worldpay.txt"),"OrderID = "  & iItemNumber   & "  iRestaurantId ="  & iRestaurantId & " houroffset " & houroffset & " time  " & DateAdd("h",houroffset,now)
      
    'check1 = iPaymentStatus = "Y" Or True
    check1 = iPaymentStatus = "Y"
    check2 = Not objRds.Eof
    if iPaymentAmount & "" = ""  then
        iPaymentAmount = 0
    end if

    dim vOrderTotal : vOrderTotal = cdbl (objRds("OrderTotal") & "") +  Cdbl(objRds("PaymentSurcharge")) 
     if vOrderTotal & "" = ""  then
        vOrderTotal = 0
    end if

    check3 = cdbl(iPaymentAmount) = cdbl(vOrderTotal)  Or True
    
    objRds.Close
   ' objCon.Close

  '  objCon.Open sConnString
    objRds.Open "select * from [BusinessDetails]  " & _
            "where Id = " & iRestaurantId, objCon

    iRestaurantEmail = objRds("CONFIRMATION_EMAIL_ADDRESS")
    
    objRds.Close
   ' objCon.Close

    'response.write SITE_URL & "Email.asp?id_o=" & iItemNumber & "&id_r=" & iRestaurantId
	response.write "Processing..."
     WriteLog server.MapPath("worldpay.txt"),"OrderID = "  & iItemNumber   & "  iRestaurantId ="  & iRestaurantId & " check1 " & check1 & " check2 " & check2 & " check3 " & check3 
 if check1 and check2 and check3  then

    'Session.Abandon
	'    objCon.Open sConnString
    dim ThankURL
    ThankURL =  SITE_URL &"Thanks.asp?id_o=" & iItemNumber & "&id_r=" & iRestaurantId 
    dim rs_url :  set rs_url = Server.CreateObject("ADODB.Recordset")
        rs_url.open "SELECT FromLink FROM URL_REWRITE a inner join BusinessDetails b on (a.RestaurantID=b.ID )  where RestaurantID=" & iRestaurantId & " and EnableUrlRewrite = 'Yes' and status = 'ACTIVE' "    ,objCon
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
    'ThankURL  = replace(lcase(ThankURL),lcase(SITE_URL),lcase(SITE_URL)&"local/")

    objRds.Open "SELECT * FROM [Orders] WHERE Id = " & iItemNumber, objCon, 1, 3 
    objRds("OrderTotal") = Cdbl(objRds("PaymentSurcharge")) + CDbl(objRds("OrderTotal"))
    'objRds("PaymentType") = "Worldpay-Paid"
    objRds("Payment_Status") = "Paid"
    objRds("OrderDate") = DateAdd("h",houroffset,now)

    objRds.Update 
    
    objRds.Close
   ' objCon.Close 

   SendEmail MAIL_SUBJECT, SITE_URL & "Email.asp?id_o=" & iItemNumber & "&id_r=" & iRestaurantId  , iRestaurantEmail
   SendEmail MAIL_CUSTOMER_SUBJECT, SITE_URL & "Email.asp?id_o=" & iItemNumber & "&id_r=" & iRestaurantId  , iPayerEmail
   'Response.Redirect "Thanks.asp?id_o=" & iItemNumber & "&id_r=" & iRestaurantId  
   WriteLog server.MapPath("worldpay.txt"),"Start worldpay.asp  OrderID = "  & iItemNumber   & "  iRestaurantId ="  & iRestaurantId
   WriteLog server.MapPath("worldpay.txt"),"Start worldpay.asp  ThankURL = "  & ThankURL 

   %>
 <META http-equiv="refresh" content="2;<%=ThankURL%>">

<%
   
 else
    Response.write "DATI PAGAMENTO NON CORRETTI"
 end if

    set objRds = nothing 
    objCon.close()
    set objCon = nothing

set objHttp = nothing

%>
