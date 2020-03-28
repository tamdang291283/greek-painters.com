<%@LANGUAGE="VBSCRIPT"%>
<%
    If  Request.QueryString("id_r") & "" = "" Then
        Response.End()
    End If
    session("restaurantid")= Request.QueryString("id_r")
    Session("MM_id")= Request.QueryString("id_r") %>
<!-- #include file="../Config.asp" -->
<!-- #include file="timezone.asp" -->
<!-- #include file="restaurantsettings.asp" -->
<%Server.ScriptTimeout=86400%>
<%
   

    Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 
     Dim objConSMS, objRdsSMS
   
        objCon.Open sConnStringcms
        objRds.Open " Select * from [SMSEmailQueue]  where PlanSendDate < now() and IsSent = false and BusinessDetailID =  " & session("restaurantid") , objCon,1,3
        While NOT objRds.EOF
            If LCase(objRds("SendType") ) = "email" Then
                'Response.Write("Send : "&  "Message from " & BUSINESSNAME & "|" &  objRds("Content") & "|To:" &  objRds("ToEmailAddress"))
                SendEmailV2 "Message from " & BUSINESSNAME, objRds("Content"), objRds("ToEmailAddress")
            Else
                'Send mail to SMS service
                'Response.Write("Send : "&  "Message from " & BUSINESSNAME & "|" &  objRds("Content") & "|To:" &  objRds("PhoneNumber") & SMSSupplierDomain)
                SendEmailV2 "Message from " & BUSINESSNAME, objRds("Content"), objRds("PhoneNumber") & SMSSupplierDomain
            End If
            objRds("IsSent") = "True"
            objRds("SendTime") = Now()
            'Set objConTemp = Server.CreateObject("ADODB.Connection")
            'Set objRdsTemp = Server.CreateObject("ADODB.Recordset") 

        
            'objConTemp.Open sConnStringcms
            'objRdsTemp.Open "SELECT * FROM [SMSEmailQueue] WHERE Id = " & objRds("ID"), objConTemp
            'If not objRdsTemp.EOF Then
            '    objRdsTemp("IsSent") = "True"
            '    objRdsTemp("SendTime") = Now()
            'End If
            'objRdsTemp.Close()
            'objConTemp.Close()
            'Set objRdsTemp = nothing
            'set objConTemp = nothing
	        objRds.MoveNext()
	    Wend
        objRds.UpdateBatch()
        objRds.close()
        objCon.close()
      set objRds = nothing
      set objCon = nothing

%>
