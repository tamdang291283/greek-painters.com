<%
  Dim b64, oId, rId
   b64 =  Request.Form("img")
   oId = Request.Form("o_id")
   rId = Request.Form("r_id")
    If b64 & "" <> "" AND oId & "" <> "" AND rId & "" <> "" Then
        Dim objFSO
        Set objFSO=CreateObject("Scripting.FileSystemObject")
        oId = Replace(oId,".","")
        rId = Replace(rId,".","")
        ' How to write file
        outFile= Server.MapPath("ReceiptImage")
        outFile = outFile & "\" & rId & "-" & oId & ".txt"
        Set objFile = objFSO.CreateTextFile(outFile,True)
        objFile.Write b64
        objFile.Close
        Set objFile = nothing
        set objFSO = nothing
        Response.Write("OK")
    Else
        Response.Write("NODATA")
    End if
     %>