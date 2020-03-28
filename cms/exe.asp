<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../Config.asp" -->
<%session("restaurantid")=Session("MM_id")%>
<!-- #include file="../timezone.asp" -->
<!-- #include file="restaurantsettings.asp" -->
<%
   

' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers=""
MM_authFailedURL="index.asp?e=2"
MM_grantAccess=false
If Session("MM_Username") <> "" Then
  If (true Or CStr(Session("MM_UserAuthorization"))="") Or _
         (InStr(1,MM_authorizedUsers,Session("MM_UserAuthorization"))>=1) Then
    MM_grantAccess = true
  End If
End If
If Not MM_grantAccess Then
  MM_qsChar = "?"
  If (InStr(1,MM_authFailedURL,"?") >= 1) Then MM_qsChar = "&"
  MM_referrer = Request.ServerVariables("URL")
  if (Len(Request.QueryString()) > 0) Then MM_referrer = MM_referrer & "?" & Request.QueryString()
  MM_authFailedURL = MM_authFailedURL & MM_qsChar & "accessdenied=" & Server.URLEncode(MM_referrer)
  Response.Redirect(MM_authFailedURL)
End If

Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 
  Dim ActualPhoneNumber
%>

<%

  
' update announcement restaurant
       Dim MM_editCmd
if request.form("action")="announcement" then
    dim startdatefrm,enddatefrm
    startdatefrm = request.form("startdate") & ""
    enddatefrm = request.form("enddate") & ""
    if startdatefrm & "" = "" and enddatefrm & "" <> "" then
        startdatefrm = enddatefrm
    elseif  startdatefrm & "" <> "" and enddatefrm & "" = "" then
        enddatefrm = startdatefrm
    end if
    Set MM_editCmd = Server.CreateObject ("ADODB.Command")
    MM_editCmd.ActiveConnection = sConnStringcms
    MM_editCmd.CommandText = "UPDATE businessdetails SET announcement = ?,inmenuannouncement= ?,Close_StartDate = ?,Close_EndDate = ?,announcement_Filter=?  WHERE ID = " & request.form("id")
    MM_editCmd.Prepared = true
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 202, 1, 4000, request.form("announcement") )
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 202, 1, 4000, request.form("in-menu-announcement") )
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param3", 202, 1, 255, startdatefrm)
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param4", 202, 1, 255, enddatefrm)
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param4", 202, 1, 4000, request.form("announcement_Filter") )
    MM_editCmd.Execute
    MM_editCmd.ActiveConnection.Close

    'objCon.Open sConnStringcms
    'Response.Write("UPDATE businessdetails SET announcement='" & request.form("announcement") & "',inmenuannouncement='" & request.form("in-menu-announcement")  & "', Close_StartDate='"& request.form("startdate") &"', Close_EndDate='"&  request.form("enddate") &"'  WHERE id=" & request.form("id"))
    'Response.End
    'objRds.Open "UPDATE businessdetails SET announcement='" & request.form("announcement") & "',inmenuannouncement='" & request.form("in-menu-announcement")  & "', Close_StartDate='"& request.form("startdate") &"', Close_EndDate='"&  request.form("enddate") &"'  WHERE id=" & request.form("id"), objCon

    'objRds.close()
    'set objRds = nothing
    'objCon.close()
    'set objCon = nothing
    response.redirect "../cms/dashboards/loggedin.asp"
end if

' update css
if request.form("action")="css" then
    objCon.Open sConnStringcms
    objRds.Open "UPDATE businessdetails SET css='" & request.form("css") & "' WHERE id=" & request.form("id"), objCon
   ' objRds.close()
    set objRds = nothing
    objCon.close()
    set objCon = nothing
    response.redirect "../cms/dashboards/loggedin.asp"
end if

' open/close restaurant
if request.querystring("action")="close" then
  objCon.Open sConnStringcms
    objRds.Open "UPDATE businessdetails SET businessclosed=0 WHERE id=" & Session("MM_id"), objCon
   ' objRds.close()
    set objRds = nothing
    objCon.close()
    set objCon = nothing
    response.redirect "../cms/dashboards/loggedin.asp"
end if
if request.querystring("action")="open" then
    objCon.Open sConnStringcms
    objRds.Open "UPDATE businessdetails SET businessclosed=1 WHERE id=" & Session("MM_id"), objCon
   ' objRds.close()
    set objRds = nothing
    objCon.close()
    set objCon = nothing
    response.redirect "../cms/dashboards/loggedin.asp"
					
end if

    dim urlreferer : urlreferer = lcase(Request.ServerVariables("HTTP_REFERER")&"")

dim pathUrl  : pathUrl =""
    if instr(urlreferer,"dashboards") > 0 then
       pathUrl = "../cms/dashboards/"
    end if

'cancel order
if request.querystring("action")="cancel" then
   
  objCon.Open sConnStringcms
                      
     objRds.Open "SELECT * FROM [Orders] WHERE Id = " &  Request.QueryString("id"), objCon, 1, 3 
     objRds("cancelled") = 1
     objRds("cancelleddate") = DateAdd("h",houroffset,now)
     objRds.Update 
     objRds.close()
    set objRds = nothing
'objCon.Close
'objCon.Open sConnStringcms
     Set objRds = Server.CreateObject("ADODB.Recordset") 
    objRds.Open "SELECT * FROM ORDERS where id=" & Request.QueryString("id") & " ORDER BY id desc" , objCon
     
        SendEmail "Order Cancelled", SITE_URL & "EmailOrderUpdate.asp?id_o=" & request.querystring("id") & "&id_r=" & Session("MM_id") & "&message=", objRds("email")
     
         'SendEmail "Order Cancelled", SITE_URL & "emailcancel.asp?id_o=" & request.querystring("id") & "&id_r=" &  Session("MM_id")  , objRds("email") 

        if objRds("PaymentType")="Stripe-Paid" or objRds("PaymentType")="Paypal-Paid" or objRds("PaymentType")="NoChex-Paid" or objRds("PaymentType")="Worldpay-Paid" or Ucase(objRds("Payment_status") & "")="PAID"  then
            SendEmail "Order Cancelled - Refund Customer", SITE_URL & "EmailOrderUpdate.asp?id_o=" & request.querystring("id") & "&id_r=" & Session("MM_id") & "&message=Order Cancelled refund customer", Session("MM_email") 
            'SendEmail "Order Cancelled - Refund Customer", SITE_URL & "emailcancel.asp?id_o=" & request.querystring("id") & "&id_r=" &  Session("MM_id")  ,  Session("MM_email") 
        end if


        dim requestpage : requestpage = request.querystring("page")
            requestpage =pathUrl & requestpage 
        
        objRds.close()
        set objRds = nothing
        objCon.close()
        set objCon = nothing
      
		response.redirect  requestpage & ".asp"


end if



'acknowledge order
if request.querystring("action")="acknowledge" then
  objCon.Open sConnStringcms
          
       


    objRds.Open "SELECT * FROM [Orders] WHERE Id = " &  Request.QueryString("id"), objCon, 1, 3 
    objRds("acknowledged") = 1
    objRds("acknowledgeddate") = DateAdd("h",houroffset,now)
    objRds.Update 
    objRds.close()
    set objRds = nothing
 
    Set objRds = Server.CreateObject("ADODB.Recordset") 
objRds.Open "SELECT * FROM ORDERS where id=" & Request.QueryString("id") & " ORDER BY id desc" , objCon
   
if request.querystring("sendemail") & "" <>"no" then
SendEmail "Your order is confirmed", SITE_URL & "EmailOrderUpdate.asp?id_o=" & request.querystring("id") & "&id_r=" & Session("MM_id") & "&message=Order Acknowledged"  , objRds("email")

end if
  
If  Lcase(SMSEnable&"") = "1" AND  Lcase(SMSOnAcknowledgement&"") = "1" AND objRds("phone") & "" <> "" Then
     ' objRds("phone"), "Your order is out or delivery", Now(),Session("MM_id")
    
    ActualPhoneNumber = ""

   
        ActualPhoneNumber = objRds("phone")
       If Left(ActualPhoneNumber,Len(DefaultSMSCountryCode)) = DefaultSMSCountryCode And Len(ActualPhoneNumber) > 1 Then
            ActualPhoneNumber = Right(ActualPhoneNumber,Len(ActualPhoneNumber) - Len(DefaultSMSCountryCode))
        End If
        If Left(ActualPhoneNumber,1) = "0" And Len(ActualPhoneNumber) > 1 Then
            ActualPhoneNumber = Right(ActualPhoneNumber,Len(ActualPhoneNumber) - 1)
        End If
     ActualPhoneNumber = DefaultSMSCountryCode & ActualPhoneNumber
     SendEmailV2 "Your order is confirmed", "Your order is confirmed", ActualPhoneNumber&SMSSupplierDomain
End If
        objRds.close()
        set objRds = nothing
        objCon.close()
    set objCon = nothing
response.redirect pathUrl &  request.querystring("page") & ".asp"
end if


'order out for delivery
if request.querystring("action")="outfordelivery" then
  objCon.Open sConnStringcms
  objCon.execute("UPDATE orders SET outfordelivery=1, delivereddate='" & (DateAdd("h",houroffset,now)) & "' WHERE id=" & Request.QueryString("id"))

    Set objRds = Server.CreateObject("ADODB.Recordset") 
objRds.Open "SELECT * FROM ORDERS where id=" & Request.QueryString("id") & " ORDER BY id desc" , objCon
SendEmail "Your order is out or delivery", SITE_URL & "EmailOrderUpdate.asp?id_o=" & request.querystring("id") & "&id_r=" & Session("MM_id") & "&message=Order Out For Delivery"  , objRds("email")
    
If  Lcase(SMSEnable&"") = "1" AND  Lcase(SMSOnDelivery&"") = "1" AND objRds("phone") & "" <> "" Then
     ' objRds("phone"), "Your order is out or delivery", Now(),Session("MM_id")
    
    ActualPhoneNumber = ""

   
        ActualPhoneNumber = objRds("phone")
       If Left(ActualPhoneNumber,Len(DefaultSMSCountryCode)) = DefaultSMSCountryCode And Len(ActualPhoneNumber) > 1 Then
            ActualPhoneNumber = Right(ActualPhoneNumber,Len(ActualPhoneNumber) - Len(DefaultSMSCountryCode))
        End If
        If Left(ActualPhoneNumber,1) = "0" And Len(ActualPhoneNumber) > 1 Then
            ActualPhoneNumber = Right(ActualPhoneNumber,Len(ActualPhoneNumber) - 1)
        End If
        ActualPhoneNumber = DefaultSMSCountryCode & ActualPhoneNumber
     SendEmailV2 "Your order is out or delivery", "Your order is out or delivery", ActualPhoneNumber&SMSSupplierDomain
End If
      objRds.close()
    set objRds = nothing  
      objCon.close()
    set objCon = nothing
response.redirect pathUrl &  request.querystring("page") & ".asp"
end if


'collected
if request.querystring("action")="collected" then
  objCon.Open sConnStringcms
  objCon.execute("UPDATE orders SET outfordelivery=1, delivereddate='" & (DateAdd("h",houroffset,now)) & "' WHERE id=" & Request.QueryString("id")) 

   ' Set objRds = Server.CreateObject("ADODB.Recordset") 
'objRds.Open "SELECT * FROM ORDERS where id=" & Request.QueryString("id") & " ORDER BY id desc" , objCon
'SendEmail "Order Out For Delivery", SITE_URL & "EmailOrderUpdate.asp?id_o=" & request.querystring("id") & "&id_r=" & Session("MM_id") & "&message=Order Out For Delivery"  , objRds("email")

      objCon.close()
    set objCon = nothing

response.redirect pathUrl &  request.querystring("page") & ".asp"
end if
%>