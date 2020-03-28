<%@LANGUAGE="VBSCRIPT"%>
<%Server.ScriptTimeout=86400%>
<!-- #include file="../../Config.asp" -->
<!-- #include file="../timezone.asp" -->
<%
If Session("MM_id")  & "" <> "" Then
    Set objCon = Server.CreateObject("ADODB.Connection")
        Set objRds = Server.CreateObject("ADODB.Recordset") 
				      objCon.Open sConnStringcms
                      
       dim datetoday : datetoday = cdate( DateAdd("h",houroffset,now))  
                       datetoday = formatdatecustom(datetoday,"mm/dd/yyyy")
   

    objRds.Open "SELECT * FROM view_paid_orders where  IdBusinessDetail=" & Session("MM_id") & " and cast(orderdate as date) = '" &datetoday&"'  ORDER BY id desc" , objCon


    cnt=0
                            Do While NOT objRds.Eof
						
						    cnt=cnt+1
						
                                objRds.MoveNext    
                            Loop
                   
                           objRds.Close
                        set objRds = nothing
                        objCon.Close
                        set objCon = nothing
                           Response.Write(cnt)
   Else
        Response.Write("-1")
    End If 
    
    %>