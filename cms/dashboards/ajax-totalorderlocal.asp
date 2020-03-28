<%@LANGUAGE="VBSCRIPT"%>
<%Server.ScriptTimeout=86400%>
<!-- #include file="../../Config.asp" -->
<!-- #include file="../timezone.asp" -->

<%
If Session("MM_id")  & "" <> "" Then
    Set objCon = Server.CreateObject("ADODB.Connection")
        Set objRds = Server.CreateObject("ADODB.Recordset") 
				      objCon.Open sConnStringcms
                       function formatDateTimeCMS(byval strdate)
                            dim result 
	                   
		                        strdate = cdate(strdate)
			                    result = Month(strdate) & "/" & day(strdate) & "/" & Year(strdate) & " " & addZeroWithNumber(Hour(strdate)) & ":" & addZeroWithNumber(Minute(strdate)) & ":" &  addZeroWithNumber(Second(strdate))
                            formatDateTimeCMS = result 
                        end function
                            dim   DateCondition
                             DateCondition = formatDateTimeCMS( cdate(DateAdd("h",houroffset,now)))
                             dim yyyy1,mm1,dd1,hh1,nn1,ss1
                                yyyy1 = DatePart("yyyy", DateCondition)
                                mm1= DatePart("m", DateCondition)
                                dd1 = DatePart("d", DateCondition)
                                hh1 =0 'DatePart("h", DateCondition)
                                nn1 =0' DatePart("n", DateCondition)
                                ss1 =1' DatePart("s", DateCondition)
    objRds.Open "SELECT * FROM view_paid_orderslocal where  IdBusinessDetail=" & Session("MM_id") & "  and  CreationDate >= '" &DateCondition& "'  and isnull(subtotal,0)  > 0 and isnull(firstname,'')  <> '' ORDER BY id desc" , objCon
        
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