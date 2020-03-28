<script language=jscript runat=server>
    function currentUTC() {
        var d, s;
        d = new Date();
        s = "Server current UTC time is: ";
        s += d.toUTCString();
        return (s);
    }
 </script>

<script language=jscript runat=server>

    var x = new Date()
    Application("ServerGMTOffset") = new Date().getTimezoneOffset() // GMT offset in minutes of the server (sign inversed to bring into line with reality)

</script>





<% 
Session.LCID = 2057
Server.ScriptTimeout=1800
response.codepage = 65001 


'Response.Expires = -1
'Response.ExpiresAbsolute = Now() -1 
'Response.AddHeader "pragma", "no-store"
'Response.AddHeader "cache-control","no-store, no-cache, must-revalidate"

  '  if Request.QueryString("id_r") & "" <> "" then
  '      if not IsNumeric(Request.QueryString("id_r") ) then
  '          Response.Write("This URL is Blocked")
  '          Response.End
  '      end if
  '  end if

%>

<!-- #include file="settings.ini" -->
<%

Function JXIsoDate(dteDate)
'Version 1.0
   If IsDate(dteDate) = True Then
      DIM dteDay, dteMonth, dteYear
      dteDay = Day(dteDate)
      dteMonth = Month(dteDate)
      dteYear   = Year(dteDate)
      JXIsoDate = dteYear & _
         "-" & Right(Cstr(dteMonth + 100),2) & _
         "-" & Right(Cstr(dteDay + 100),2)
   Else
      JXIsoDate = Null
   End If
End Function

Function InsertSMSToQueue(ByVal ToPhoneNumber, ByVal SMSContent, ByVal senddate,ByVal businessID)
  
    Dim objConSMS, objRdsSMS
    Set objConSMS = Server.CreateObject("ADODB.Connection")
Set objRdsSMS = Server.CreateObject("ADODB.Recordset") 
   objConSMS.Open sConnString
    objRdsSMS.Open "SELECT * FROM [SMSEmailQueue] WHERE 1 = 0", objConSMS, 1, 3 
    objRdsSMS.AddNew 
     objRdsSMS("PhoneNumber") = ToPhoneNumber
     objRdsSMS("Content") = SMSContent
    objRdsSMS("PlanSendDate") = senddate
    objRdsSMS("BusinessDetailID") = businessID
    objRdsSMS("SendType") = "SMS"
    objRdsSMS("IsSent") =0
    
    objRdsSMS.Update 
	objRdsSMS.Close
    objConSMS.Close
    Set objRdsSMS = nothing
    Set objConSMS = nothing
End Function

  
Function WriteErrorLog(logFilePath, logContent)
        Dim logobjFSO, logFile
        set logobjFSO = CreateObject("Scripting.FileSystemObject")
        set logFile = logobjFSO.OpenTextFile(logFilePath,8,true) ' 8 is for appending
        logFile.WriteLine(now() & ": " & logContent)
        set logFile = nothing
        set logobjFSO = nothing
    End Function

Function SendEmail(ByVal Subject, ByVal BodyUrl, ByVal SendTo)
      On Error Resume Next
    Dim iMsg
    dim iSchema
    'Response.Write(BodyUrl)
   ' Response.End
    iSchema = "http://schemas.microsoft.com/cdo/configuration/"

  Set iMsg = CreateObject("CDO.Message")
  'response.write "sendto:" & SendTo & "<BR>"
  'response.write "MAIL_FROM:" & MAIL_FROM & "<BR>"
   ' response.write "SMTP_SERVER:" & SMTP_SERVER & "<BR>"
	'  response.write "SMTP_PORT:" & SMTP_PORT & "<BR>"
	  '  response.write "SMTP_AUTENTICATE:" & SMTP_AUTENTICATE & "<BR>"
		'  response.write "SMTP_USERNAME:" & SMTP_USERNAME & "<BR>"
		'    response.write "SMTP_PASSWORD:" & SMTP_PASSWORD & "<BR>"
			
			'response.write "Subject:" & Subject & "<BR>"
		'	response.write "BodyUrl:" & BodyUrl & "<BR>"
		'	response.write "SMTP_USESSL:" & SMTP_USESSL & "<BR>"
				
    iMsg.To = SendTo
    iMsg.From = MAIL_FROM
    iMsg.Subject = Subject

    iMsg.CreateMHTMLBody BodyUrl

    iMsg.BodyPart.Charset = "utf-8" 
    iMsg.TextBodyPart.Charset = "utf-8" 
    iMsg.HTMLBodyPart.Charset = "utf-8"
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
          Response.Write "Error Occurred on function SendEmail in file config.asp<br/>Error Detail: " & err.Description 
          WriteErrorLog Server.MapPath("errorlog.txt"), "Error Occurred on function SendEmail in file config.asp "& vbCrLf &"Error Detail: " & err.Description  
          Response.End
      end if
 

    On Error GoTo 0
    	
End Function
    
Function SendEmailV2(ByVal Subject, ByVal BodyContent, ByVal SendTo)
   On Error Resume Next
    Dim iMsg
    dim iSchema

    iSchema = "http://schemas.microsoft.com/cdo/configuration/"

  Set iMsg = CreateObject("CDO.Message")
  'response.write "sendto:" & SendTo & "<BR>"
  'response.write "MAIL_FROM:" & MAIL_FROM & "<BR>"
   ' response.write "SMTP_SERVER:" & SMTP_SERVER & "<BR>"
	'  response.write "SMTP_PORT:" & SMTP_PORT & "<BR>"
	  '  response.write "SMTP_AUTENTICATE:" & SMTP_AUTENTICATE & "<BR>"
		'  response.write "SMTP_USERNAME:" & SMTP_USERNAME & "<BR>"
		'    response.write "SMTP_PASSWORD:" & SMTP_PASSWORD & "<BR>"
			
			'response.write "Subject:" & Subject & "<BR>"
		'	response.write "BodyUrl:" & BodyUrl & "<BR>"
		'	response.write "SMTP_USESSL:" & SMTP_USESSL & "<BR>"
				
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
        Response.Write "Error Occurred on function SendEmailV2 in file config.asp<br/>Error Detail: " & err.Description        
        WriteErrorLog Server.MapPath("errorlog.txt"), "Error Occurred on function SendEmailV2 in file config.asp "& vbCrLf &"Error Detail: " & err.Description  
        
    end if
    

    On Error GoTo 0
	  
End Function


Function FormatEngDate(dteDate)
    If IsDate(dteDate) = True Then
        Dim dteDay, dteMonth, dteYear
        dteDay = Day(dteDate)
        dteMonth = Month(dteDate)
        dteYear   = Year(dteDate)
        FormatEngDate = Right(Cstr(dteDay + 100),2) & "/" & Right(Cstr(dteMonth + 100),2)  & "/" & dteYear
        Else
        FormatEngDate = Null
    End If
End Function

Function FormatISODate(dteDate)
    If IsDate(dteDate) = True Then
        Dim dteDay, dteMonth, dteYear
        dteDay = Day(dteDate)
        dteMonth = Month(dteDate)
        dteYear   = Year(dteDate)
        FormatISODate = dteYear & "/" & Right(Cstr(dteMonth + 100),2) & "/" & Right(Cstr(dteDay + 100),2)
        Else
        FormatISODate = Null
    End If
End Function
function FormatTimeC(byval value, byval numberofletter)

	dim result : result = left(value,cint(numberofletter))
	FormatTimeC = result
end function
 function formatDateTimemdy(byval strdate)
    dim result 
	                   
		strdate = cdate(strdate)
		result = Month(strdate) & "/" & day(strdate) & "/" & Year(strdate) & " " & addZeroWithNumber(Hour(strdate)) & ":" & addZeroWithNumber(Minute(strdate)) & ":" &  addZeroWithNumber(Second(strdate))
    formatDateTimeCMS = result 
end function
 %>