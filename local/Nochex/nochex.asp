<!-- #include file="../../Config.asp" -->
<!-- #include file="../../timezone.asp" -->

<%



    iItemNumber = Request.QueryString("iItemNumber")

    iItemNumber = Replace(iItemNumber,"IR-","")

    Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 
    
     objCon.Open sConnString
     objRds.Open "select * from [OrdersLocal]  " & _
            "where Id = " & iItemNumber, objCon

    iPayerEmail = objRds("Email")
    iRestaurantId = objRds("IdBusinessDetail")

	
	session("restaurantid")=iRestaurantId
	session("vOrderId")=objRds("id")
	%>
	<!-- #include file="../../restaurantsettings.asp" -->
	<%
    
    objRds.Close
   ' objCon.Close

   ' objCon.Open sConnString
    objRds.Open "select * from [BusinessDetails]  " & _
            "where Id = " & iRestaurantId, objCon

    iRestaurantEmail = objRds("Email")
    
    objRds.Close
   ' objCon.Close

   

    'Session.Abandon
	'    objCon.Open sConnString
    objRds.Open "SELECT * FROM [OrdersLocal] WHERE Id = " & iItemNumber, objCon, 1, 3     
    objRds("Payment_Status") = "Paid"
    objRds.Update 
    
    objRds.Close
    set objRds = nothing
    objCon.Close 
    set objCon = nothing

   'SendEmail MAIL_SUBJECT, SITE_URL & "Email.asp?id_o=" & iItemNumber & "&id_r=" & iRestaurantId  , iRestaurantEmail
   'SendEmail MAIL_CUSTOMER_SUBJECT, SITE_URL & "Email.asp?id_o=" & iItemNumber & "&id_r=" & iRestaurantId  , iPayerEmail
   Response.Redirect SITE_URL & "local/Thanks.asp?id_o=" & iItemNumber & "&id_r=" & iRestaurantId  
   




%>
