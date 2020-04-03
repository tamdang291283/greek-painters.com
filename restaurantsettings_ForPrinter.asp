<%

    
   ' Response.Write(formatDateTimeC(Now()))
sub WriteLogBlockIP(logFilePath, logContent)
         if setWriteLog = false then
            exit sub
         end if
         On Error Resume Next
            Dim logobjFSO, logFile
            set logobjFSO = CreateObject("Scripting.FileSystemObject")
            set logFile = logobjFSO.OpenTextFile(logFilePath,8,true) ' 8 is for appending
            logFile.WriteLine(now() & ": " & logContent)
            set logFile = nothing
            set logobjFSO = nothing
        On Error GoTo 0
    End sub

Set objConconfig = Server.CreateObject("ADODB.Connection")
Set objRdsconfig = Server.CreateObject("ADODB.Recordset") 
if session("restaurantid")="" then
 
response.redirect(SITE_URL & "error.asp")
end if
objConconfig.Open sConnString
objRdsconfig.Open "SELECT  PrinterIDList , CONFIRMATION_EMAIL_ADDRESS ,BlockIPEmailList,InRestaurantEpsonPrinterIdList, IsDualReceiptPrinting, PrinterFontSizeRatio , SEND_ORDERS_TO_PRINTER FROM BusinessDetails   WHERE Id = " & session("restaurantid"), objConconfig
  
Do While NOT objRdsconfig.Eof
'Check blocked list

If objRdsconfig("BlockIPEmailList") & "" <> ""  Then
   
  'dim vIP : vIP = Request.ServerVariables("REMOTE_ADDR")
   ' vIP = "86.28.235.14"
   If Instr(";" &LCase(objRdsconfig("BlockIPEmailList")) & ";",";" & Request.ServerVariables("REMOTE_ADDR") & ";") > 0 OR Instr(";" &LCase(objRdsconfig("BlockIPEmailList")) & ";",";" & Lcase( URLDecode(Request.Cookies("Email"))  ) & ";") > 0  Then
       call WriteLogBlockIP(Server.MapPath("BlockIP.txt"),"PageName =  " & Request.ServerVariables("HTTP_URL")   & " NlockIP " & LCase(objRdsconfig("BlockIPEmailList"))    & " ClinetIP =   " & Request.ServerVariables("REMOTE_ADDR") & " Email " & Lcase( URLDecode(Request.Cookies("Email"))))
        objRdsconfig.Close()    
        objConconfig.Close()
        Set objRdsconfig = nothing
        Set objConconfig = nothing
        Response.end()
    End If
End If

InRestaurantEpsonPrinterIdList = objRdsconfig("InRestaurantEpsonPrinterIdList") & ""
PrinterIDList = objRdsconfig("PrinterIDList") & ""
RestaurantNotificationEmail = objRdsconfig("CONFIRMATION_EMAIL_ADDRESS") & ""

If Not IsNull(objRdsconfig("PrinterFontSizeRatio")) Then
    PrinterFontSizeRatio = Lcase(objRdsconfig("PrinterFontSizeRatio"))
Else
    PrinterFontSizeRatio = 1
End If

     
If Not IsNull(objRdsconfig("IsDualReceiptPrinting")) Then
    IsDualReceiptPrinting = Lcase(objRdsconfig("IsDualReceiptPrinting"))
Else
    IsDualReceiptPrinting = "0"
End If
   SEND_ORDERS_TO_PRINTER=objRdsconfig("SEND_ORDERS_TO_PRINTER")

objRdsconfig.MoveNext    
Loop
    objRdsconfig.Close
    objConconfig.Close 
set objRdsconfig = nothing
set objConconfig = nothing


Function URLDecode(ByVal What)
'URL decode Function
'2001 Antonin Foller, PSTRUH Software, http://www.motobit.com
  Dim Pos, pPos

  'replace + To Space
  What = Replace(What, "+", " ")

  on error resume Next
  Dim Stream: Set Stream = CreateObject("ADODB.Stream")
  If err = 0 Then 'URLDecode using ADODB.Stream, If possible
    on error goto 0
    Stream.Type = 2 'String
    Stream.Open

    'replace all %XX To character
    Pos = InStr(1, What, "%")
    pPos = 1
    Do While Pos > 0
      Stream.WriteText Mid(What, pPos, Pos - pPos) + _
        Chr(CLng("&H" & Mid(What, Pos + 1, 2)))
      pPos = Pos + 3
      Pos = InStr(pPos, What, "%")
    Loop
    Stream.WriteText Mid(What, pPos)

    'Read the text stream
    Stream.Position = 0
    URLDecode = Stream.ReadText

    'Free resources
    Stream.Close
  Else 'URL decode using string concentation
    on error goto 0
    'UfUf, this is a little slow method. 
    'Do Not use it For data length over 100k
    Pos = InStr(1, What, "%")
    Do While Pos>0 
      What = Left(What, Pos-1) + _
        Chr(Clng("&H" & Mid(What, Pos+1, 2))) + _
        Mid(What, Pos+3)
      Pos = InStr(Pos+1, What, "%")
    Loop
    URLDecode = What
  End If
End Function

	 %>