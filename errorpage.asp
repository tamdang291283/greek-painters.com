<%@ LANGUAGE = "VBSCRIPT" %>
<!-- #include file="settings.ini" -->
<%
   Dim ErrorMessage : ErrorMessage  = "" 
   Dim EmailReport : EmailReport = "tam.dang832912@gmail.com"

    Function SendEmailV2(ByVal Subject, ByVal BodyContent, ByVal SendTo)
  
    Dim iMsg
    dim iSchema

    iSchema = "http://schemas.microsoft.com/cdo/configuration/"

  Set iMsg = CreateObject("CDO.Message")
    iMsg.To = SendTo
    iMsg.From ="daniele@greek-painters.com"
    iMsg.Subject = Subject
	'response.write BodyContent
    iMsg.TextBody = BodyContent
    iMsg.BodyPart.Charset = "utf-8" 
    iMsg.TextBodyPart.Charset = "utf-8" 
'iMsg.HTMLBodyPart.Charset = "utf-8"
    iMsg.Configuration.Fields.Item(iSchema & "sendusing") = 2
    iMsg.Configuration.Fields.Item(iSchema & "smtpserver") =  "greek-painters.com"
    iMsg.Configuration.Fields.Item(iSchema & "smtpserverport") = 25
    if true Then 
	
        iMsg.Configuration.Fields.Item(iSchema & "smtpauthenticate") = True
        iMsg.Configuration.Fields.Item(iSchema & "sendusername") ="daniele@greek-painters.com"
        iMsg.Configuration.Fields.Item(iSchema & "sendpassword") =  "5r8$9mzZ"
    end if
    if false Then iMsg.Configuration.Fields.Item(iSchema & "smtpusessl") = 1
    iMsg.Configuration.Fields.Update
    iMsg.Send

    set iMsg = nothing
   
    
End Function


   Function WriteLog(logFilePath, logContent)
        Dim logobjFSO, logFile
        set logobjFSO = CreateObject("Scripting.FileSystemObject")
        set logFile = logobjFSO.OpenTextFile(logFilePath,8,true) ' 8 is for appending
        logFile.WriteLine(now() & ": " & logContent)
        set logFile = nothing
        set logobjFSO = nothing
    End Function

     
    dim AspErr
    Set AspErr = Server.GetLastError()
    
    if AspErr.Description & "" <> "" then
        'Response.Write(Now & " - ERROR - ASPCode:" & ASPErr.ASPCode & " ASPDescription: " & ASPErr.ASPDescription & " Category: " & ASPErr.Category & " Description: " & ASPErr.Description & " File: " & ASPErr.File & " Line: " & ASPErr.Line & " Source: " & ASPErr.Source )

        ' Response.End
        call AddTo500Log()
      '  Response.Write(Now & " - ERROR - ASPCode:" & ASPErr.ASPCode & " ASPDescription: " & ASPErr.ASPDescription & " Category: " & ASPErr.Category & " Description: " & ASPErr.Description & " File: " & ASPErr.File & " Line: " & ASPErr.Line & " Source: " & ASPErr.Source )
      ' Response.End
    end if


   
    Function GetFullCurrentPath()
	 GetFullCurrentPath = SITE_URL & Request.ServerVariables("HTTP_URL") 
    End function
   Response.Write(GetFullCurrentPath())
   Response.End

       ' Response.Clear()
	'	Response.Status = "500 internal server error"        
	'	Response.Write("dsd")
		'Response.End()	
    Sub AddTo500Log()    
    'Response.Write("<br/> 1234 " )
   ' Response.End
	'Dim fso, ilogpath, filetxt, Where_When, iTEMP, itxt
	Dim  itxt
	Dim iBrowser, iIPAddress, iScriptName, s_Referer, logCustomerId, cartIdClient
    
   ' On Error Resume Next
	'---------------------------------------
	cartIdClient = ""
	iBrowser    = Request.ServerVariables("HTTP_USER_AGENT")
	'iIPAddress  = Request.ServerVariables("REMOTE_HOST")
	iIPAddress = Request.ServerVariables("HTTP_X_FORWARDED_FOR")
	If iIPAddress = "" Then
	  iIPAddress = Request.ServerVariables("REMOTE_ADDR")
	Else
		If InStr(iIPAddress,",") > 0 Then
			iIPAddress = Split(iIPAddress,",")(0)
		End If
	End If
	iScriptName =  GetFullCurrentPath()
	
	s_Referer = Request.ServerVariables ("HTTP_REFERER")

	
	'---------------------------------------

	'========================================================================
	' Grab the important error details...
	'========================================================================
	itxt = (AspErr.Category) & " error '" & (AspErr.ASPCode & LCase(Hex(ASPErr.Number))) & "' "
	itxt = itxt & (AspErr.Description) & " " & AspErr.File & ", line " & (AspErr.Line)
	'========================================================================

	'Open the log file and write this new line...
	'Set filetxt = fso.OpenTextFile(ilogpath, 8, True) 
	'Where_When = Now() & "(:)" & iIPAddress & "(:)" & iBrowser & "(:)" & iScriptName & "?" & Cstr(Request.Querystring()) & "(:)"
	'filetxt.WriteLine(Where_When & Replace(itxt,"(:)"," : ") & "(:)")
	'filetxt.Close
	'Set filetxt = Nothing
	'Set fso = Nothing
   
    iBrowser=Replace(iBrowser,"'","''")
    iScriptName=Replace(iScriptName,"'","''")
    itxt=Replace(itxt,"'","''")
  
	'Response.Write(m_sql)
    dim messageresponse : messageresponse = ""
    messageresponse = messageresponse & "IpAdddress: " & iIPAddress & "<br/>"
    messageresponse = messageresponse & "Browser: " & iBrowser & "<br/>"
    messageresponse = messageresponse & "physicalfile: " & iScriptName & "<br/>"
    messageresponse = messageresponse & "URL: " & Server.HTMLEncode(Request.ServerVariables("URL")) & "<br/>"
    messageresponse = messageresponse & "Content Type: " & Server.HTMLEncode(Request.ServerVariables("CONTENT_TYPE")) & "<br/>"
    messageresponse = messageresponse & "Content Length: " & iIPAddress & "<br/>"
    messageresponse = messageresponse & "ErrorDeatils: " & itxt& "<br/>"
    messageresponse = messageresponse & "LOCAL_ADDR: " & Request.ServerVariables("LOCAL_ADDR") & "<br/>"
    messageresponse = messageresponse & "s_Referer: " & s_Referer & "<br/>"
    dim contentlog 
        contentlog = "   <ErrorLog Version=""2.00""> " & vbCrLf
        contentlog = contentlog & "    <IpAdddress>" & iIPAddress & "</IpAdddress> " & vbCrLf
        contentlog = contentlog & "    <Browser>" & iBrowser & "</iBrowser> " & vbCrLf
        contentlog = contentlog & "    <physicalfile>" & iScriptName & "<physicalfile> "  & vbCrLf

        contentlog = contentlog & "    <URL> " & Server.HTMLEncode(Request.ServerVariables("URL")) & " </URL> "  & vbCrLf
     contentlog = contentlog & "    <Content Type> " & Server.HTMLEncode(Request.ServerVariables("CONTENT_TYPE")) & " </Content Type> "  & vbCrLf
    contentlog = contentlog & "    <Content Length> " & Server.HTMLEncode(Request.ServerVariables("CONTENT_LENGTH")) & " </Content Length> "  & vbCrLf
        contentlog = contentlog & "    <ErrorDeatils>" & itxt & "</LOCAL_ADDR> "  & vbCrLf
        contentlog = contentlog & "    <LOCAL_ADDR>" & Request.ServerVariables("LOCAL_ADDR")  & "</LOCAL_ADDR> " & vbCrLf
        contentlog = contentlog & "    <Server Variables:>" & Server.HTMLEncode(Request.ServerVariables("ALL_HTTP"))  & "</Server Variables:> " & vbCrLf 
    contentlog = contentlog & "    <s_Referer>" & s_Referer & "</s_Referer> " & vbCrLf 
        contentlog = contentlog & "  </ErrorLog> " & vbCrLf
	  
	WriteLog Server.MapPath("errorlog.txt"), contentlog
    Response.Write(messageresponse)
    if instr(itxt, "Microsoft JET Database Engine error ''80004005''") > 0   then            
            if Application("errorpage") & "" = ""  then
                call SendEmailV2("Error Page",contentlog,EmailReport)
                Application("errorpage") = Now()
            elseif  DateDiff("n",cdate(Application("errorpage")),Now()) >= 30 then
                call SendEmailV2("Error Page",contentlog,EmailReport)
                Application("errorpage") = Now()
            end if

    end if

     	

    
    
    
    'Ruud end updated
	'On Error GoTo 0	
	
End Sub
    

     %>