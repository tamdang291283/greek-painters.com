<%@LANGUAGE="VBSCRIPT"%>


<%


dim filesys, filetxt
Const ForReading = 1, ForWriting = 2, ForAppending = 8
Set filesys = CreateObject("Scripting.FileSystemObject")
Set filetxt = filesys.OpenTextFile(server.mappath("_responseepson.txt"), ForAppending, True)
filetxt.WriteLine("Querystring:" & request.querystring)
filetxt.WriteLine("Form:" & request.form)
filetxt.Close 

%>

