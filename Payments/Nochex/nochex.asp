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

    iItemNumber = Request.QueryString("iItemNumber")
    Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 
     
     objCon.Open sConnString
     objRds.Open "select * from [Orders] with(nolock) where Id = " & iItemNumber, objCon
            

    iPayerEmail = objRds("Email")
    iRestaurantId = objRds("IdBusinessDetail")

	
	session("restaurantid")=iRestaurantId
	session("vOrderId")=objRds("id")
	%>
    <!-- #include file="../../timezone.asp" -->
	<!-- #include file="../../restaurantsettings.asp" -->
	<%
    WriteLog server.MapPath("nochek.txt"),"OrderID = "  & iItemNumber   & "  iRestaurantId ="  & iRestaurantId & " houroffset " & houroffset & " time  " & DateAdd("h",houroffset,now)
    objRds.Close
   ' objCon.Close

    'objCon.Open sConnString
    objRds.Open "select * from [BusinessDetails]  " & _
            "where Id = " & iRestaurantId, objCon

    iRestaurantEmail = objRds("CONFIRMATION_EMAIL_ADDRESS")
    
    objRds.Close
   ' objCon.Close

   

    'Session.Abandon
	'    objCon.Open sConnString

    dim ThankURL
        ThankURL =  SITE_URL & "Thanks.asp?id_o=" & iItemNumber & "&id_r=" & iRestaurantId  
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
            if instr( lcase(SITE_URL) ,"https://") then
                    ThankURL  = replace(ThankURL,"http://","https://")  
            end if
    objRds.Open "SELECT * FROM [Orders] WHERE Id = " & iItemNumber, objCon, 1, 3 
    objRds("OrderTotal") = Cdbl(objRds("PaymentSurcharge")) + CDbl(objRds("OrderTotal"))

    objRds("Payment_Status") = "Paid"
    objRds("OrderDate") = DateAdd("h",houroffset,now)
    objRds.Update 
    
    objRds.Close
    set objRds = nothing
        objCon.Close 
        set objCon = nothing
   SendEmail MAIL_SUBJECT, SITE_URL & "Email.asp?id_o=" & iItemNumber & "&id_r=" & iRestaurantId  , iRestaurantEmail
   SendEmail MAIL_CUSTOMER_SUBJECT, SITE_URL & "Email.asp?id_o=" & iItemNumber & "&id_r=" & iRestaurantId  , iPayerEmail
  
         
   Response.Redirect ThankURL
   




%>
