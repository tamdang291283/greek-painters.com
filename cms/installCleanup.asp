<%@LANGUAGE="VBSCRIPT"%>
<%
       dim fs,f
    
   
       set fs=Server.CreateObject("Scripting.FileSystemObject") 
        if fs.FileExists(Server.MapPath("__install.asp")) Then
            fs.DeleteFile(Server.MapPath("__install.asp"))
        End If
        fs.MoveFile  Server.MapPath("install.asp"),Server.MapPath("__install.asp")
        set fs=nothing
    Response.Redirect("index.asp")
    Response.End()
     %>