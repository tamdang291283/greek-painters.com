<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="include/cls_Imager.asp"-->
<!-- #include file="../Config.asp" -->>
<!--#INCLUDE FILE="include/clsUpload.asp"-->
<!--#include file="include/clsImage.asp"-->
<%



Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset")
objCon.Open sConnStringcms
objRds.Open "UPDATE menuitems SET photo='' WHERE id=" & request.querystring("id"), objCon
						
   

Response.Redirect("menu.asp?catid=" & request.querystring("catid"))
%>

