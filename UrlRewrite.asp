
  <!-- #include file="Config.asp" -->
<%
 
Dim Current_Path, Requested_Page, Requested_File, urw_Split, ASPErr	
    Current_Path = Replace(Request.ServerVariables("SCRIPT_NAME"),"URLrewrite.asp","",1,-1,vbTextCompare)
    Requested_Page = Replace(Request.ServerVariables("QUERY_STRING"),"404;","")
    Requested_Page = Replace(Requested_Page,"403;","")
If Right(Requested_Page,1) = "/" Then
    Requested_Page = left(Requested_Page,len(Requested_Page) - 1)
End If
    %>


    <%
      
 
    call ChangeUrlRewrite301(Requested_Page)



'Ruud added to change url rewrite 301
sub ChangeUrlRewrite301(byval strFullURL)
  
	strFullURL = Replace(strFullUrl, "gcp-www", "www")
	'strFullURL = Replace(strFullUrl, "gcp-m", "m")
	strFullURL=replace(strFullURL,":80/","/")
    strFullURL=replace(strFullURL,"https:","http:")
	strFullURL=replace(strFullURL,":443","")
   	
    '------Fixed SQL injection
    strFullURL = Replace(UCase(strFullURL), "%28", "(")
    strFullURL = Replace(UCase(strFullURL), "%29", ")")
    strFullURL = Replace(UCase(strFullURL), "'", "")
	strFullURL = Replace(UCase(strFullURL), """", "")
	strFullURL = Replace(UCase(strFullURL), ")", "")
	strFullURL = Replace(UCase(strFullURL), "(", "")
	strFullURL = Replace(UCase(strFullURL), ";", "")		
	strFullURL = Replace(UCase(strFullURL), "|", "")
      
	dim parameter
    parameter = ""
    if instr(strFullURL,"?")>0 then
        parameter = right(strFullURL,len(strFullURL)-instr(strFullURL,"?") + 1)
        strFullURL = Replace(strFullURL,parameter,"")
    end if
        
	If Right(strFullURL,1) = "/" AND Len(strFullURL) > 1 Then
		strFullURL = Left(strFullURL, Len(strFullURL) - 1)
	End if
       
	dim strFullURL_Original
	strFullURL_Original = strFullURL
	
    dim m_rs,m_command,sql,m_conn
    set m_rs = Server.CreateObject("ADODB.Recordset")
    'Set m_conn = Server.CreateObject("ADODB.Connection")	
    Set m_command = Server.CreateObject("ADODB.Command")    
    m_command.CommandTimeout = 0
  '  m_conn.ConnectionTimeout = 0
    	
  '  m_conn.Open sConnString
    m_command.ActiveConnection = sConnString 
    dim orderID : orderID = 0
	if instr(LCase(strFullURL_Original),"/thanks") > 0 then
        dim arrL : arrL =  Split(LCase(strFullURL_Original),"/")
            orderID = arrL(ubound(arrL))
            if orderID & "" <> "" then
                if IsNumeric(orderID & "") then
                    dim Indexi : Indexi = 0
                    strFullURL_Original  = ""
                    for Indexi = 0 to ubound(arrL) -1 
                          if Indexi =  ubound(arrL) -1  then
                                strFullURL_Original = strFullURL_Original & arrL(Indexi) 
                          else
                                strFullURL_Original = strFullURL_Original & arrL(Indexi) & "/"
                          end if
                    next
                end if
            end if
         
           ' strFullURL_Original = replace(LCase(strFullURL_Original),"/" & orderID,"")
            if orderID & "" = "" or not IsNumeric(orderID) then
                orderID = 0    
            end if
           
          
    end if
       
      
    strFullURL_Original = lcase(strFullURL_Original)
    Dim isLocal : isLocal =  false
     if instr(strFullURL_Original,"/local") > 0 then
        isLocal =  true
        strFullURL_Original = replace(strFullURL_Original,"/local","")
    end if
    sql = "SELECT a.ID,FromLink,ToLink,a.RestaurantID,Status FROM URL_REWRITE a  where (  FromLink='"& LCase(strFullURL_Original)  &"' or FromLink='"& Replace(LCase(strFullURL_Original),"http://","https://")  &"' )    and Status = 'ACTIVE' "

	m_command.CommandText = sql
    set m_rs = m_command.Execute()
 'Response.Write("RestaurantID " & sql  & "<br/>")
	If not m_rs.EOF then
             
        'inner join BusinessDetails b on (a.RestaurantID=b.ID ) 
        'if lcase( m_rs("EnableUrlRewrite") & "")  <> "yes" then
                  
                dim RestaurantID : RestaurantID = m_rs("RestaurantID") 
                  
                if  RestaurantID & "" <> "" then
                        sql = "select top 1 1 from BusinessDetails where ID=" & RestaurantID & " and EnableUrlRewrite <> 'yes' "
                       
                        m_command.CommandText = sql
                    dim m_rs1 : set m_rs1 = Server.CreateObject("ADODB.Recordset")
                    set m_rs1 = m_command.Execute()
                    if not m_rs1.EOF then
                        
                            m_rs1.Close()
	                    Set m_rs1 = Nothing	
                        m_command.ActiveConnection.Close
                        Set m_command = Nothing

	                   ' m_rs.Close()
	                    Set m_rs = Nothing	
	                   ' m_conn.Close()	
                        if isLocal =  true then
                            Response.Redirect(SITE_URL & "local/menu.asp?id_r=" &  RestaurantID )
                        else
                            Response.Redirect(SITE_URL & "menu.asp?id_r=" &  RestaurantID )
                        end if
                    end if
                end if
      '  end if
		Session("ResID") = m_rs("RestaurantID")
       
        if instr(lcase( m_rs("ToLink")),"thanks.asp") > 0 and orderID > 0  then
           Session("OrderID") = orderID
        
        end if
      
            dim s_tolink : s_tolink =  m_rs("ToLink")
             m_command.ActiveConnection.Close
        	Set m_command = Nothing
	        
	        Set m_rs = Nothing		            
            'set m_conn = nothing
       if instr(s_tolink,"?") > 0 then
        s_tolink  = left(s_tolink,instr(s_tolink,"?")-1)
       end if
      
        if isLocal = true then
            Server.Transfer("local/" & s_tolink)     
        else
            Server.Transfer(s_tolink)     
        end if
	End If
    
    m_command.ActiveConnection.Close
	Set m_command = Nothing
	'm_rs.Close()
	Set m_rs = Nothing	
	'set m_conn = nothing

        Set ASPErr = Server.GetLastError()

    If ASPErr.Description <> "" Then
       Response.Write("Error " & ASPErr.Description )
        Response.End
    End if
    Response.Write("Page Not Found")
End sub
'Ruud end 




%>