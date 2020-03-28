<!-- #include file="../../Config.asp" -->
<%
    session("restaurantid")=Request.QueryString("id_r")
     %>

<!-- #include file="../../timezone.asp" -->
<!-- #include file="../../restaurantsettings.asp" -->
<%
    Dim   OrderID, rID, localmode  
          rID = Request.QueryString("id_r") 
          OrderID =  Request.QueryString("o_id") 
          localmode  =   Request.QueryString("local") 
         
        sub WriteLog(logFilePath, logContent)
            if setWriteLog = false then
                    exit sub
              end if 
            On Error Resume Next
                Dim logobjFSO, logFile
                set logobjFSO = CreateObject("Scripting.FileSystemObject")
                set logFile = logobjFSO.OpenTextFile(logFilePath,8,true) ' 8 is for appending
                logFile.WriteLine(now() & ": " & logContent)
                set logFile = nothing
                set logobjFSO = nothing
            On Error GoTo 0
        End sub
       WriteLog Server.MapPath("Updateprinted.txt"),"PageName = Updateprinted.asp Res=" & rID
       dim printerURLList : printerURLList = "" 
       if rID  & "" <> "" and OrderID & "" <> ""   then
            Dim objCon2
            Set objCon2 = Server.CreateObject("ADODB.Connection")
            objCon2.Open sConnString
           dim SQL 
                if localmode & "" <> ""  then
                    SQL = " update  Orderslocal set printed = 1 where ID = " & OrderID & " and IdBusinessDetail=" & rID  
                else
                    SQL = " update  ORDERS set printed = 1 where ID = " & OrderID & " and IdBusinessDetail=" & rID              
                end if
               objCon2.Execute(SQL)
            objCon2.close()
            set objCon2 = nothing
        Response.Write("success")
        WriteLog Server.MapPath("Updateprinted.txt"),"PageName = Updateprinted.asp Success Res=" & rID & " Order = " & OrderID
        
       end if
       WriteLog Server.MapPath("Updateprinted.txt"),"PageName = Updateprinted.asp End Res=" & rID & " Order = " & OrderID
 %>