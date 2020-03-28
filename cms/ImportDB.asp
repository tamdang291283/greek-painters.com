<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../Config.asp" -->

<!-- #include file="include/clsuploadv2.asp" -->
<!-- #include file="include/clsfieldv2.asp" -->
<%Server.ScriptTimeout=86400%>
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers=""
MM_authFailedURL="index.asp?e=2"
MM_grantAccess=false
If Session("MM_Username") <> "" Then
  If (true Or CStr(Session("MM_UserAuthorization"))="") Or _
         (InStr(1,MM_authorizedUsers,Session("MM_UserAuthorization"))>=1) Then
    MM_grantAccess = true
  End If
End If
If Not MM_grantAccess Then
  MM_qsChar = "?"
  If (InStr(1,MM_authFailedURL,"?") >= 1) Then MM_qsChar = "&"
  MM_referrer = Request.ServerVariables("URL")
  if (Len(Request.QueryString()) > 0) Then MM_referrer = MM_referrer & "?" & Request.QueryString()
  MM_authFailedURL = MM_authFailedURL & MM_qsChar & "accessdenied=" & Server.URLEncode(MM_referrer)
  Response.Redirect(MM_authFailedURL)
End If
 Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 
   Dim message
    message = ""
    Dim objUpload 
    Dim strFile, strPath, temps
    Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
    oldFile = Server.MapPath("..\Data\Menu.mdb") 
    temps = FormatDateTime(Now(),2)
    temps = Replace(Replace(temps,"\",""),"/","")
    temps = temps & FormatDateTime(Now(),4)
    temps = Replace(temps,":","")
    newFile =  Server.MapPath("..\Data\Menu.bk" & temps & ".mdb") 
    'Response.Write(oldFile & "|" & newFile)
    If objFSO.FileExists(oldFile) Then
         objFSO.MoveFile oldFile, newFile
    End If
    ' Instantiate Upload Class '
    Set objUpload = New clsUpload
  
    strFile = objUpload.Fields("dbUpload").FileName

    'Response.Write("AA" & strFile)
  
    strPath = oldFile
    'Response.Write("BB"&strPath)
    
  '  Response.End()
    ' Save the binary data to the file system '
    objUpload("dbUpload").SaveAs strPath
    
    Dim isSuccess 
    isSuccess = false
    If objFSO.FileExists(oldFile) Then
        isSuccess = true
    Else 
        objFSO.MoveFile newFile ,oldFile
    End If
    Set objUpload = Nothing
    set objFSO = nothing
    'Response.End()
    'Response.redirect("dbtasks.asp")
%>
<html>
    <body>
        <% if isSuccess Then %>
        Database Restore Successful. Please click <a href="DBTasks.asp">here</a>  to go back
       
        <% else %>
        Restore Failed. No changes were made. Please click <a href="DBTasks.asp">here</a> to return Database Functions page.
        <% End IF %>
    </body>


</html>
