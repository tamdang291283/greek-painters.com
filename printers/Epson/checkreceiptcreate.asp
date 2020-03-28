<!-- #include file="../../Config.asp" -->
<%
         Function WriteLog(logFilePath, logContent)
         On Error Resume Next
            Dim logobjFSO, logFile
            set logobjFSO = CreateObject("Scripting.FileSystemObject")
            set logFile = logobjFSO.OpenTextFile(logFilePath,8,true) ' 8 is for appending
            logFile.WriteLine(now() & ": " & logContent)
            set logFile = nothing
            set logobjFSO = nothing
        On Error GoTo 0
    End Function
        
        dim OrderID : OrderID =  Request.QueryString("o_id") 
        dim ResID : ResID =  Request.QueryString("r_id") 
        dim stype : stype =  Request.QueryString("type")  
         WriteLog Server.MapPath("EpsonPostImageAndPrint.txt"),"PageName  = checkreceiptcreate.asp Start Page [Orderid] " & OrderID  
         WriteLog Server.MapPath("EpsonPostImageAndPrint.txt"),"Pagename  = checkreceiptcreate.asp [Refer URL] " & Request.ServerVariables ("HTTP_REFERER")
        function numberoffile(byval orderid, byval s_type,byval resid )

            dim objCon1, result
            result = ""
            Set objCon1 = Server.CreateObject("ADODB.Connection")
            objCon1.Open sConnString
            dim RS_Order : set RS_Order  = Server.CreateObject("ADODB.Recordset")
             
                RS_Order.Open "select count(*) as numbercount from [Order_Receipt_tracking]  where orderid = " & orderid & " and s_printtype='" &s_type& "' and IdBusinessDetail = " & resid , objCon1, 1, 3 
              
                 result = RS_Order("numbercount")
            RS_Order.close()
            set RS_Order = nothing
            objCon1.close()
            set objCon1 = nothing
            numberoffile = result
        end function
        if OrderID & "" = "" or ResID & "" =""  then
             Response.Clear()
             Response.Write("ERROR")
            Response.End()
        end if
        Response.Clear()
        Response.Write(numberoffile(OrderID,stype,ResID))
     WriteLog Server.MapPath("EpsonPostImageAndPrint.txt"),"Pagename  = checkreceiptcreate.asp  DONE "
     %>