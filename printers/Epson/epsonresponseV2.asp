<%@LANGUAGE="VBSCRIPT"%>


<%


dim filesys, filetxt
Const ForReading = 1, ForWriting = 2, ForAppending = 8
Set filesys = CreateObject("Scripting.FileSystemObject")
Set filetxt = filesys.OpenTextFile(server.mappath("_responseepsonv2.txt"), ForAppending, True)
filetxt.WriteLine("Querystring:" & request.querystring)
filetxt.WriteLine("Form:" & request.form)
filetxt.Close 


If InStr(Request.Form,"success=""true""") > 1 Then
    Dim objFSO, rID
    Set objFSO=CreateObject("Scripting.FileSystemObject")
    Dim imgFolder, fo, objFile, strContent, printingFolder, pfo, PrintingFileName
    printingFolder = Server.MapPath("ReceiptImage/Printing")
    set pfo = objFSO.GetFolder(printingFolder)
    for each f in pfo.files
        PrintingFileName = f.Name
        If PrintingFileName& "" <> "" Then
            If Instr(Request.Form,"<printjobid>" & Replace(PrintingFileName,".txt","") & "</printjobid>") > 1 Then
                objFSO.DeleteFile printingFolder & "/" & PrintingFileName, true
                Exit For
            End If
        End If
        
    next
    
    set pfo = nothing
    set objFSO = nothing
End If

%>

