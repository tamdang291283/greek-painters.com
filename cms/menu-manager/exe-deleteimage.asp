<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="../include/cls_Imager.asp"-->
<!-- #include file="../../Config.asp" -->>
<!--#INCLUDE file="../include/clsUpload.asp"-->
<!--#include file="../include/clsImage.asp"-->
<%



Set objCon = Server.CreateObject("ADODB.Connection")
    
    objCon.Open sConnStringcms
    objCon.execute( "UPDATE menuitems SET photo='' WHERE id=" & request.querystring("id") )
    objCon.close()
    set objCon= nothing
    						
   

Response.Redirect("menu.asp?catid=" & request.querystring("catid"))
%>

