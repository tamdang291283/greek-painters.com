

<!-- #include file="../../Config.asp" -->



<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
</head>
<body>
    <%
         Dim objFSO
             Set objFSO=CreateObject("Scripting.FileSystemObject")
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
            WriteLogBat batfilepath,"phantomjs "& Server.MapPath(rootpath) &"\exe.js http://www.greek-painters.com/vo/food/7-2-dang/printers/epson/print_t.asp " & strmod & " " & orderid & " " & resid 
           
            Response.Write(batfilepath & "</br>")

            Dim WshShell 
           Set WshShell = CreateObject("WScript.Shell") 
           'dim objFSO : objFSO = Set objFSO=CreateObject("Scripting.FileSystemObject")
            '  WriteLog Server.MapPath("EpsonPostImageAndPrint.txt"),"PageName = pintXML_v2.xml ReCreateReceipt  END Order = " & orderid & " batfilepath = " & batfilepath 
               WshShell.Run batfilepath ,1,true
              for m=1 to 1000
                        For i = 1 To 60000
                       next
              next
            objFSO.DeleteFile batfilepath, true
            set WshShell = nothing
            WshShell =  nothing
            'objFSO = nothing 
        ' End
        Response.Write(batfilepath)
        On Error GoTo 0
    end sub


   
        call ReCreateReceipt("dishname",2842,2,RootDefaultPath & "/printers/epson/ptjs","")
    set objFSO = nothing
     %>
</body>
</html>



