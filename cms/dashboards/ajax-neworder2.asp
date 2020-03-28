<%@LANGUAGE="VBSCRIPT"%>
<%Server.ScriptTimeout=86400%>
<!-- #include file="../../Config.asp" -->

<!-- #include file="../../timezone.asp" -->
<%

If Session("MM_id") & "" <> "" Then
Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 
				  objCon.Open sConnStringcms
				          function formatDateTimeCMS(byval strdate)
                            dim result 
	                   
		                        strdate = cdate(strdate)
			                    result = Month(strdate) & "/" & day(strdate) & "/" & Year(strdate) & " " & addZeroWithNumber(Hour(strdate)) & ":" & addZeroWithNumber(Minute(strdate)) & ":" &  addZeroWithNumber(Second(strdate))
                            formatDateTimeCMS = result 
                        end function
                        dim sQuery,DateCondition 
                            
               
                                DateCondition = formatDateTimeCMS( cdate(DateAdd("h",houroffset,now)) )
                             dim yyyy1,mm1,dd1,hh1,nn1,ss1
                                yyyy1 = DatePart("yyyy", DateCondition)
                                mm1= DatePart("m", DateCondition)
                                dd1 = DatePart("d", DateCondition)
                                hh1 = DatePart("h", DateCondition)
                                nn1 = DatePart("n", DateCondition)
                                ss1 = DatePart("s", DateCondition)
                            
                                
                               ' Get Avarage time for delivery and collection 
                            dim vaveragedel : vaveragedel = 0 
                            dim vaveragecol : vaveragecol = 0
                            if Session("MM_id") & "" <> "" then
                                dim rs_BusinessDetails : set rs_BusinessDetails = Server.CreateObject("ADODB.Recordset")
                                rs_BusinessDetails.Open "SELECT AverageDeliveryTime,AverageCollectionTime FROM BusinessDetails  WHERE Id = " & Session("MM_id") , objCon    
                                if not rs_BusinessDetails.eof then  
                                    vaveragedel = rs_BusinessDetails("AverageDeliveryTime")
	                                vaveragecol = rs_BusinessDetails("AverageCollectionTime")
                                end if
                                rs_BusinessDetails.close()
                           
                            end if
                        ' End
                            sQuery = " SELECT count(*) as numberrow FROM view_paid_orders where  IdBusinessDetail= "  & Session("MM_id")  
                            sQuery =sQuery &  " and cancelled=0 "  
                            sQuery = sQuery & " AND  "  &config_prefix_sql_function&  "FNC_DeliveryTime(asaporder,deliverytype,deliverydelay,orderdate,collectiondelay,deliverytime)  >= '"& DateCondition &"'"  
				       
                        objRds.Open sQuery , objCon
                            Response.Write(objRds("numberrow"))
                        
                         objRds.Close
                        set objRds = nothing
                        objCon.Close
                        set objCon = nothing
                        
   else
        Response.Write("-1")
    End If%>