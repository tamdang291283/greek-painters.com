<%

'response.write(server.mappath("."))
'response.end


dim fs,f
set fs=Server.CreateObject("Scripting.FileSystemObject")
set f=fs.CreateTextFile("D:\hshome\naxtech\greek-painters.com\vo\food\7-2-Dang\test\serverbrowse\111test.txt")
f.write("Hello World!")
f.write("How are you today?")
f.close
set f=nothing
set fs=nothing
%>