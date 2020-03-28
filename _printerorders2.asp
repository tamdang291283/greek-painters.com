<%@ LANGUAGE = "VBSCRIPT" %>

<%
Option Explicit
' :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
' FileExists() - Check if a file exists on the server
' :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
Public Function FileExists(ByVal PassedFileName)

	Dim FILENAMEANDPATH, fs
'	On Error Resume Next

	'Get full path if necessary
	If Mid(PassedFileName, 2, 1) <> ":" AND Mid(PassedFileName, 1, 2) <> "\\" Then
		If InStr(PassedFileName,":") > 0 OR InStr(PassedFileName,"?") > 0 Then
			FileExists = False
			exit function
		Else
			FILENAMEANDPATH = Server.MapPath(PassedFileName)
		End If
	else
		FILENAMEANDPATH = PassedFileName
	End If

	Set fs = CreateObject("Scripting.FileSystemObject")
	FileExists = fs.fileexists(FILENAMEANDPATH)
	set fs = nothing

End Function
    
Function readBinary(path)
    Dim a
    Dim fso
    Dim file
    Dim i
    Dim ts
    Set fso = CreateObject("Scripting.FileSystemObject")
    Set file = fso.getFile(path)
    If isNull(file) Then
        MsgBox("File not found: " & path)
        Exit Function
    End If
    Set ts = file.OpenAsTextStream()
    a = makeArray(file.size)
    i = 0
    ' Do not replace the following block by readBinary = by ts.readAll(), it would result in broken output, because that method is not intended for binary data 
    While Not ts.atEndOfStream
        a(i) = ts.read(1)
    i = i + 1
    Wend
    ts.close
    readBinary = Join(a,"")
End Function



function WriteByBinary(isRange,filename,iStart,iEnd)
  	
	  'extract($GLOBALS);
	  Dim FilePath, FileContent, FileLength, contentRange, rangesize, Fso, File, FileStream, sStr1
	  FilePath= filename
      FileContent = ""
      
	  If NOT FileExists(FilePath) Then
		WriteByBinary = 0
        Exit Function
	  End IF
	  Set Fso = CreateObject("Scripting.FileSystemObject")
      Set File = Fso.getFile(FilePath)
      
	  if  isNull(file) Then
		WriteByBinary = 0
	  End IF
      Set FileStream = File.OpenAsTextStream()
	  FileLength = File.size
      dim FileContentArray()
      Redim FileContentArray(FileLength)   

	  if isRange>0 Then

		if iEnd>=FileLength Then
		
			if FileLength>1 Then
			  iEnd=FileLength -1
			Else
				iEnd=1
			End If
			  
		End IF 
	
	  
       
       Dim i      
       
		if iStart>FileLength Then
			
		  iStart=iEnd
		  'Response.AddHeader("HTTP/1.1 416 Request Range Not Satisfialbe");
          Response.Status = "416 Requested Range Not Satisfiable"
		  Response.Write("")
          Response.End()
		  'print substr($sStr1,$startBytes+1-1,$toBytes+1-$startBytes);
	
		else
		
	      Response.Clear() 
    	

		  
		  contentRange ="bytes " & (iStart)  & "-" & (iEnd) & "/" & (FileLength)
		  Response.AddHeader "Content-Range",contentRange
		  Response.AddHeader "Content-type","application/octet-stream"
          If (iEnd - iStart) > 0 Then
            rangesize = (iEnd - iStart)
          Else
            rangesize = 0
          End If
          
          
           i = iStart
           Dim j 
           j = 0
           'Response.Write(iStart & "|" & iEnd & "|" & rangesize & "<br />")
           If iStart > 0 Then
                FileStream.Skip(iStart-1)
           End IF
           While Not FileStream.atEndOfStream AND i < iEnd              
              FileContentArray(j) = FileStream.read(1)
              j = j + 1
              i = i + 1             
            Wend
          
		  sStr1 = Join(FileContentArray,"")
		  Response.AddHeader "Content-Length", rangesize 
				
		  Response.Write sStr1
          Response.Flush()
		  'ob_flush(); 
		  'flush(); 

		End If 
	
	  
    else
	  
	
		iStart=0
		iEnd= fileLength
        rangesize = fileLength
              
        i = iStart
        Response.AddHeader "Content-type","application/octet-stream"
        Redim FileContentArray(rangesize)   
        While Not FileStream.atEndOfStream
            FileContentArray(i) = FileStream.read(1)
            i = i + 1
        Wend
		sStr1 = Join(FileContentArray,"")
		Response.Write(sStr1)
	End IF 
	
	
	  FileStream.close 
      Set FileStream = nothing
	  Set Fso = nothing
      Set File = nothing
	  WriteByBinary = 1
End Function


Dim sRange, sUserAgent,  useraccount, userpwd, defaultaccount, defaultpwd, fileName
sRange = ""
sUserAgent = ""
useraccount = ""
userpwd = ""

defaultaccount = ""
defaultpwd=""
fileName="_printerorders.txt"
If Request.ServerVariables("HTTP_RANGE") <> "" Then
	 sRange= Request.ServerVariables("HTTP_RANGE")
End If

If Request.ServerVariables("HTTP_USER_AGENT") <> "" Then
	 sUserAgent= Request.ServerVariables("HTTP_USER_AGENT")
End If

fileName = Server.MapPath(fileName)
    'Response.Write(sRange)
    'Response.End()
If  Request.QueryString("u") <> "" Then
 useraccount= LCase(Request.QueryString("u"))
End If

If  Request.QueryString("p") <> "" Then
 userpwd= LCase(Request.QueryString("p"))
End If
'sRange = "bytes=0-1000" 
   
If useraccount = defaultaccount AND userpwd = defaultpwd  Then
	
	if sRange <> "" Then
		
	  Response.Status = "206 Partial Content"
	 
	  Dim RangeArr,startBytes,toBytes
	  RangeArr=Split(Split(sRange,"=")(1),"-")
	
	  startBytes= CInt(RangeArr(0))
	  toBytes= CInt(RangeArr(1))
    
	  WriteByBinary 1,fileName,startBytes,toBytes
	
	Else
	  
	   WriteByBinary 0,fileName,0,0
	End If 
Else
	Response.Write("")
End IF
%>
