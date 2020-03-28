<%@LANGUAGE="VBSCRIPT"%>
<%Server.ScriptTimeout=86400%>
<!-- #include file="../Config.asp" -->
<!-- #include file="timezone.asp" -->
<%
If Session("MM_id")  & "" <> "" Then
    Set objCon = Server.CreateObject("ADODB.Connection")
        Set objRds = Server.CreateObject("ADODB.Recordset") 
				      objCon.Open sConnStringcms
                      

    objRds.Open "SELECT * FROM ORDERS where (paymenttype='Paypal-Paid' or paymenttype='NoChex-Paid' or paymenttype='Worldpay-Paid' or paymenttype='Cash on Delivery') and IdBusinessDetail=" & Session("MM_id") & " and (IIf ( IsNull ( [OrderDate] ) , '',Format([OrderDate],'dd/mm/yyyy')) ='" & date() & "')  ORDER BY id desc" , objCon


    cnt=0
                            Do While NOT objRds.Eof
						
						    cnt=cnt+1
						
                                objRds.MoveNext    
                            Loop
                   
                            objRds.Close
                            objCon.Close
                           Response.Write(cnt)
   Else
        Response.Write("-1")
    End If 
    
    %>