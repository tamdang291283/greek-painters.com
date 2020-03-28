<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="../include/cls_Imager.asp"-->
<!-- #include file="../../Config.asp" -->
<!--#INCLUDE file="../include/clsUpload.asp"-->
<!--#include file="../include/clsImage.asp"-->
<%
Server.ScriptTimeout = 100000

Dim objUpload
Dim strFileName
Dim objConn
Dim objRs
Dim lngFileID

' Instantiate Upload Class
Set objUpload = New clsUpload
strFileName = CStr(objUpload("File1").FileName)

id=CStr(objUpload.Fields("id").value)
catid=CStr(objUpload.Fields("catid").value)


' Grab the file name


Set Image = New clsImage

Image.DataStream = objUpload.Fields("File1").BinaryData

origw=Image.Width
origh=Image.Height

neww=110
newh=round((110/origw)*origh)



if len(strFileName)>1 then
    dim fs
    set fs=Server.CreateObject("Scripting.FileSystemObject")
  if not fs.FolderExists(Server.MapPath("..\..\images\" & Session("MM_id") )) then
        fs.CreateFolder(Server.MapPath("..\..\images\" & Session("MM_id") ))   
  end if
    set fs =  nothing
strPath = Server.MapPath("..\..\images\" & Session("MM_id") & "\" & strFileName  )

objUpload("File1").SaveAs strPath




Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset")
objCon.Open sConnStringcms
objRds.Open "UPDATE menuitems SET photo='" & strFileName & "' WHERE id=" & id, objCon
						
   
   
end if


Set objUpload = Nothing





Response.Redirect("menu.asp?catid=" & catid)
%>

