<%session("restaurantid")=Request.QueryString("id_r")%>
<!-- #include file="../Config.asp" -->
<!-- #include file="../timezone.asp" -->
<!-- #include file="../restaurantsettings.asp" -->

<%

    
    dim mode : mode = request.QueryString("m")
    dim vRestaurantId : vRestaurantId = request.QueryString("id_r")
    dim  username : username = Request.Form("name")
    dim  telno : telno = request.Form("tel")
    dim  bookdate : bookdate =  request.Form("dt")
    dim  comment : comment = request.Form("comment")
    dim cartitemhtml :  cartitemhtml = request.Form("item")
    dim numberpeople : numberpeople  = request.Form("numberpeople")
    dim email : email = request.Form("email")
    dim isSendmail :  isSendmail = true
    if username = "" or telno = "" or bookdate  ="" or email = "" then
        isSendmail =  false
    end if
    dim bookid
    dim objCon,objRds
    Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 
    'Response.Write("cartitemhtml " & cartitemhtml)
    'Response.End
    objCon.Open sConnString
    objRds.Open "SELECT *  FROM BusinessDetails  WHERE Id = " & vRestaurantId, objCon
    dim resName,resEmail,telephone,address
    if not objRds.EOF then
        resName = objRds("Name")
        resEmail = objRds("Email")
        address = objRds("address")
        telephone  = objRds("telephone")
        '' Insert to Data base
              dim submitCommand ,coltime
              Set   MM_editCmd = Server.CreateObject ("ADODB.Recordset")
                dim   coltimesplit
                coltimesplit=split(bookdate," ")
	    	    coltime=coltimesplit(1)

                MM_editCmd.Open "SELECT * FROM [Customer_Book_Table] WHERE 1 = 0", objCon, 1, 3 
                MM_editCmd.AddNew 
                MM_editCmd("Name") = username
                MM_editCmd("Phone") = telno
                MM_editCmd("bookdate") =JXIsoDate(bookdate) + " " + coltime
                MM_editCmd("IdBusinessDetail") = vRestaurantId
                MM_editCmd("numberpeople") = numberpeople
                MM_editCmd("createddate") =  DateAdd("h",houroffset,now)
                MM_editCmd("email") =  email
                MM_editCmd("comment") = comment
                MM_editCmd("s_contentemail") = cartitemhtml
                MM_editCmd.Update 
                bookid = MM_editCmd("ID")
                MM_editCmd.close()
            set MM_editCmd = nothing
            objCon.close()
            set objCon = nothing
         
        if isSendmail = true then
             SendEmail "Table Booking Request", SITE_URL & "TableBooking/EmailBookingTable.asp?b_id=" & bookid & "&id_r=" & vRestaurantId  , resEmail 
             SendEmail "Table Booking Request", SITE_URL & "TableBooking/EmailBookingTable.asp?b_id=" & bookid & "&id_r=" & vRestaurantId  , email 
            ' Response.Write("send mail " & SITE_URL & "TableBooking/EmailBookingTable.asp?b_id=" & bookid & "&id_r=" & vRestaurantId & " <br/>" )
        end if
           
         Response.Write("OK")
         Response.End
    end if
    objRds.close()
    set objRds = nothing
    objCon.close()
    set objCon = nothing
    
%>