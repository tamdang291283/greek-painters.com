<%
    session("restaurantid")= 2
     %>
<!-- #include file="Config.asp" -->
<!-- #include file="timezone.asp" -->
<!-- #include file="restaurantsettings.asp" -->

<%
      Function WriteLogBat(logFilePath, logContent)
        On Error Resume Next
            Dim logobjFSO, logFile
            set logobjFSO = CreateObject("Scripting.FileSystemObject")
            set logFile = logobjFSO.OpenTextFile(logFilePath,8,true) ' 8 is for appending
            logFile.WriteLine( logContent)
            set logFile = nothing
            set logobjFSO = nothing
        On Error GoTo 0
    End Function
    sub ReCreateReceipt(byval strmod,byval orderid, byval resid, byval rootpath,byval RePrintReceiptWays)
        On Error Resume Next

        ' Create Bat file 
        dim batfilepath : batfilepath = Server.MapPath(rootpath + "/" & orderid & "-" & resid & "-" & strmod & ".bat")
           
            WriteLogBat batfilepath,split(batfilepath,":")(0) & ":"
            WriteLogBat batfilepath,"cd "  & Server.MapPath(rootpath)
            WriteLogBat batfilepath,"phantomjs "& Server.MapPath(rootpath) &"\exe.js " & SITE_URL & "printers/epson/print_t.asp " & strmod & " " & orderid & " " & resid 
            WriteLog Server.MapPath("EpsonPostImageAndPrint.txt"),"PageName = pintXML_v2.xml ReCreateReceipt  ORDER =  " & orderid 
            Response.Write(batfilepath)

            Dim WshShell 
            Set WshShell = CreateObject("WScript.Shell") 
            'dim objFSO : objFSO = Set objFSO=CreateObject("Scripting.FileSystemObject")
              WriteLog Server.MapPath("EpsonPostImageAndPrint.txt"),"PageName = pintXML_v2.xml ReCreateReceipt  END Order = " & orderid & " batfilepath = " & batfilepath 
               WshShell.Run batfilepath ,3,true 
          
            
             objFSO.DeleteFile batfilepath, true
            set WshShell = nothing
            'WshShell =  nothing
            'objFSO = nothing 
        ' End
         WriteLog Server.MapPath("EpsonPostImageAndPrint.txt"),"PageName = pintXML_v2.xml ReCreateReceipt  END Order = " & orderid
        On Error GoTo 0
    end sub
    call ReCreateReceipt("dishname",2838,2,RootDefaultPath & "/printers/epson/ptjs","")
     %>