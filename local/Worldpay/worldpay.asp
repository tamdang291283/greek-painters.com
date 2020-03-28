<!-- #include file="../../Config.asp" -->
<!-- #include file="../../timezone.asp" -->

<%

Dim iTxnId
Dim iItemNumber, iPaymentStatus, iPaymentAmount, iRestaurantId
Dim iPayerEmail, iRestaurantEmail


iItemNumber = Request.form("cartId")
iPaymentAmount = Request.form("authAmount")
iPaymentStatus = Request.form("transStatus")
iItemNumber = Replace(UCase(iItemNumber),"IR-","")
dim filesys, filetxt
Const ForReading = 1, ForWriting = 2, ForAppending = 8
Set filesys = CreateObject("Scripting.FileSystemObject")
Set filetxt = filesys.OpenTextFile(server.mappath("worldpay.txt"), ForAppending, True)

filetxt.WriteLine("iItemNumber:" & Request.form("cartId"))
filetxt.WriteLine("iPaymentAmount:" & Request.form("authAmount"))
filetxt.WriteLine("iPaymentStatus:" & Request.form("transStatus"))
filetxt.Close 



    Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 
    
     objCon.Open sConnString
     objRds.Open "select * from [OrdersLocal]  " & _
            "where Id = " & iItemNumber, objCon

    iPayerEmail = objRds("Email")
    iRestaurantId = objRds("IdBusinessDetail")
	session("restaurantid")=objRds("IdBusinessDetail")
	%>
<!-- #include file="../../restaurantsettings.asp" -->
<%


    'check1 = iPaymentStatus = "Y" Or True
    check1 = iPaymentStatus = "Y"
    check2 = Not objRds.Eof
    check3 = cdbl(iPaymentAmount) = cdbl(objRds("OrderTotal")) Or True
    
    objRds.Close
    objCon.Close

    objCon.Open sConnString
    objRds.Open "select * from [BusinessDetails]  " & _
            "where Id = " & iRestaurantId, objCon

    iRestaurantEmail = objRds("Email")
    
    objRds.Close
   ' objCon.Close

    'response.write SITE_URL & "Email.asp?id_o=" & iItemNumber & "&id_r=" & iRestaurantId
	response.write "Processing..."

 if check1 and check2 and check3  then

    'Session.Abandon
	'    objCon.Open sConnString
     dim ThankURL
    ThankURL =  SITE_URL &"Thanks.asp?id_o=" & OrderID & "&id_r=" & iRestaurantId 
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
     ThankURL  = replace(lcase(ThankURL),lcase(SITE_URL),lcase(SITE_URL)&"local/")
    objRds.Open "SELECT * FROM [OrdersLocal] WHERE Id = " & iItemNumber, objCon, 1, 3 
    'objRds("PaymentType") = "Worldpay-Paid"
    objRds("Payment_Status") = "Paid"
    objRds.Update 
    
    objRds.Close
    set objRds = nothing
    objCon.Close 
    set objCon = nothing
   'SendEmail MAIL_SUBJECT, SITE_URL & "Email.asp?id_o=" & iItemNumber & "&id_r=" & iRestaurantId  , iRestaurantEmail
   'SendEmail MAIL_CUSTOMER_SUBJECT, SITE_URL & "Email.asp?id_o=" & iItemNumber & "&id_r=" & iRestaurantId  , iPayerEmail
   'Response.Redirect "Thanks.asp?id_o=" & iItemNumber & "&id_r=" & iRestaurantId  
   
   %>
 <META http-equiv="refresh" content="2;<%=ThankURL%>">

<%
   
 else
      set objRds = nothing
    objCon.Close 
    set objCon = nothing
    Response.write "DATI PAGAMENTO NON CORRETTI"
 end if



set objHttp = nothing

%>
