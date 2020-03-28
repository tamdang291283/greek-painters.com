<script language=jscript runat=server>
 function currentUTC(){
 var d, s;
 d = new Date();
 s = "Server current UTC time is: ";
 s += d.toUTCString();
 return(s);
 }
 </script>

<script language=jscript runat=server>

  var x = new Date()
  Application("ServerGMTOffset") =  new Date().getTimezoneOffset() // GMT offset in minutes of the server (sign inversed to bring into line with reality)
 
</script>





<% 
Session.LCID = 2057
Server.ScriptTimeout=1800
y = datepart("yyyy", date())
' REM EUROPEAN UNION CALCULATION:
DST_EU_SPRING = (31 - (5*y/4 + 4) mod 7)
DST_EU_FALL = (31 - (5*y/4 + 1) mod 7)
'response.write("<BR><br>EU_SPRING: Sunday, " & DST_EU_SPRING & " March " & y)
'response.write("<BR><br>EU_FALL: Sunday, " & DST_EU_FALL & " October " & y)
date1=CDate(DST_EU_SPRING & "/3/" & y)
date2=CDate(DST_EU_FALL & "/10/" & y)

if (DateDiff("d",date1,now)>1) and (DateDiff("d",now,date2)>1) then
'response.write "<BR><br>It is currently DST"
offset=Application("ServerGMTOffset")+60
else
offset=Application("ServerGMTOffset")
end if


houroffset=offset/60
houroffsetreal=offset/60

response.codepage = 65001 


%>

<!-- #include file="../settings.ini" -->
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

Function SendEmail(ByVal Subject, ByVal BodyUrl, ByVal SendTo)
    
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
	response.write BodyUrl
    iMsg.CreateMHTMLBody BodyUrl
iMsg.BodyPart.Charset = "utf-8" 
iMsg.TextBodyPart.Charset = "utf-8" 
iMsg.HTMLBodyPart.Charset = "utf-8"
    iMsg.Configuration.Fields.Item(iSchema & "sendusing") = 2
    iMsg.Configuration.Fields.Item(iSchema & "smtpserver") = SMTP_SERVER
    iMsg.Configuration.Fields.Item(iSchema & "smtpserverport") = SMTP_PORT
    if SMTP_AUTENTICATE Then 
	
        iMsg.Configuration.Fields.Item(iSchema & "smtpauthenticate") = True
        iMsg.Configuration.Fields.Item(iSchema & "sendusername") = SMTP_USERNAME
        iMsg.Configuration.Fields.Item(iSchema & "sendpassword") =  SMTP_PASSWORD
    end if
    if SMTP_USESSL Then iMsg.Configuration.Fields.Item(iSchema & "smtpusessl") = 1
    iMsg.Configuration.Fields.Update

    iMsg.Send

    set iMsg = nothing
    
End Function
    
Function SendEmailV2(ByVal Subject, ByVal BodyContent, ByVal SendTo)
    
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
    if SMTP_AUTENTICATE Then 
	
        iMsg.Configuration.Fields.Item(iSchema & "smtpauthenticate") = True
        iMsg.Configuration.Fields.Item(iSchema & "sendusername") = SMTP_USERNAME
        iMsg.Configuration.Fields.Item(iSchema & "sendpassword") =  SMTP_PASSWORD
    end if
    if SMTP_USESSL Then iMsg.Configuration.Fields.Item(iSchema & "smtpusessl") = 1
    iMsg.Configuration.Fields.Update

    iMsg.Send

    set iMsg = nothing
    
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