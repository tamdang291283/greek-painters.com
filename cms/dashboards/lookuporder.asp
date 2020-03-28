<%@LANGUAGE="VBSCRIPT"%>
<%Server.ScriptTimeout=86400%>
<!-- #include file="../../Config.asp" -->
<!-- #include file="../timezone.asp" -->
<%
    dim oid,resid
    oid = Request.QueryString("oid") & "" 
    
    if oid <> "" then
         Set objRds = Server.CreateObject("ADODB.Recordset") 
           Set objCon = Server.CreateObject("ADODB.Connection")
             objCon.Open sConnStringcms

        objRds.Open "SELECT top 1 1  FROM orders where  id=" & oid  , objCon
        dim result : result = "no"
        if not objRds.EOF then
           result = "yes"
        end if
            objRds.close()
        set objRds = nothing
            objCon.close()
        set objCon = nothing 
        Response.Write(result)
        Response.End()
    end if
    Response.Write("no")
    Response.End
     %>