<%@LANGUAGE="VBSCRIPT"%>


<%
    dim SMTP_SERVER : SMTP_SERVER = Request.Form("SMTP_SERVER")
    dim SMTP_PORT : SMTP_PORT = Request.Form("SMTP_PORT")
    dim SMTP_USERNAME : SMTP_USERNAME = Request.Form("SMTP_USERNAME")
    dim SMTP_PASSWORD : SMTP_PASSWORD = Request.Form("SMTP_PASSWORD")
    dim SMTP_USESSL : SMTP_USESSL  = Request.Form("SMTP_USESSL")
    dim MAIL_FROM : MAIL_FROM = Request.Form("MAIL_FROM")
    Function SendEmailV2(ByVal Subject, ByVal BodyContent, ByVal SendTo)
   On Error Resume Next
    Dim iMsg
    dim iSchema

    iSchema = "http://schemas.microsoft.com/cdo/configuration/"

  Set iMsg = CreateObject("CDO.Message")

				
    iMsg.To = SendTo
    iMsg.From = MAIL_FROM
    iMsg.Subject = Subject
	'response.write BodyContent
    iMsg.TextBody = BodyContent
    iMsg.BodyPart.Charset = "utf-8" 
    iMsg.TextBodyPart.Charset = "utf-8" 
'iMsg.HTMLBodyPart.Charset = "utf-8"
    iMsg.Configuration.Fields.Item(iSchema & "sendusing") = 2
    iMsg.Configuration.Fields.Item(iSchema & "smtpserver") = SMTP_SERVER
    iMsg.Configuration.Fields.Item(iSchema & "smtpserverport") = SMTP_PORT
    'if SMTP_AUTENTICATE Then 
	
        iMsg.Configuration.Fields.Item(iSchema & "smtpauthenticate") = True
        iMsg.Configuration.Fields.Item(iSchema & "sendusername") = SMTP_USERNAME
        iMsg.Configuration.Fields.Item(iSchema & "sendpassword") =  SMTP_PASSWORD 
    'end if
    if SMTP_USESSL Then iMsg.Configuration.Fields.Item(iSchema & "smtpusessl") = 1
    iMsg.Configuration.Fields.Update

    iMsg.Send

    set iMsg = nothing
    
     
    if err.Description & "" <> "" then
        Response.Clear 
        Response.Write "Error: " & err.Description        
        
        
    end if
    

    On Error GoTo 0
	  
End Function

    dim Email : Email =  Request.Form("email")
    
    SendEmailV2 "Email Testing", "Test send email Time:" & Now , Email

%>

