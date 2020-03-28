<%
Response.Write(strLineBreak & strLineBreak)
towritetofile="<%" & vbcrlf
  For Each sItem In Request.Form
  vvv=Request.Form(sItem)
  if instr(sitem,"|1") then
  vvv="""" & vvv & """"
  end if
  towritetofile = towritetofile & left(sitem,len(sitem)-2) & "=" & vvv & vbcrlf
   
  Next
  towritetofile = towritetofile 
  
  %>
  
  <%
dim fs,f
set fs=Server.CreateObject("Scripting.FileSystemObject") 
set f=fs.OpenTextFile(Server.MapPath("../settings.ini"),2,true)
f.write(towritetofile)
f.write(chr(37) & ">")
f.close
set f=nothing
set fs=nothing
response.redirect "loggedin.asp"
%>