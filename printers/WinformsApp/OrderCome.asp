<!-- #include file="../../Config.asp" -->
<%
    session("restaurantid")=Request.QueryString("id_r")
     %>

<!-- #include file="../../timezone.asp" -->
<!-- #include file="../../restaurantsettings.asp" -->
<%

   
    

    Dim   objFSO, rID 
          rID = Request.QueryString("id_r") 
          Set objFSO=CreateObject("Scripting.FileSystemObject")
          Dim imgFolder, fo, objFile, strContent, printingFolder, pfo, isPrinting
          imgFolder = Server.MapPath("ReceiptImage\")
          printingFolder = Server.MapPath("ReceiptImage\Printing\")

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
   
    function isDualPrintFNC(byval OrderID,byval Conn)
             On Error Resume Next
                    dim Result : Result = true 
                    dim objRds : set objRds = Server.CreateObject("ADODB.Recordset")
                        dim SQL 
                            SQL  = "select  mi.PrintingName " 
                            SQL  = SQL & " from ( OrderItems oi " 
                            SQL  = SQL &  " inner join MenuItems mi on oi.MenuItemId = mi.Id ) "
                            SQL  = SQL &  " left join MenuItemProperties mip on oi.MenuItemPropertyId = mip.Id   " 
                            SQL  = SQL &  " where oi.OrderId = " & OrderID
                           
                     objRds.Open SQL , Conn
                     Do While NOT objRds.Eof
                            If objRds("PrintingName") & "" = "" Then
                                Result = false
                            End If                    
                            objRds.MoveNext   
                    Loop
                    objRds.close()
                    set objRds = nothing
            isDualPrintFNC = Result
            On Error GoTo 0
    end function

      
    function isDualPrintFNCLocal(byval OrderID,byval Conn)
             On Error Resume Next
                    dim Result : Result = true 
                    dim objRds : set objRds = Server.CreateObject("ADODB.Recordset")
                        dim SQL 
                             SQL =  "select oi.*," & _
                                "mi.Name, mip.Name as PropertyName ,  mi.PrintingName " & _
                                "from ( OrderItems oi " & _
                                "inner join MenuItems mi on oi.MenuItemId = mi.Id ) " & _
                                "left join MenuItemProperties mip on oi.MenuItemPropertyId = mip.Id " & _
                                "where oi.OrderId = " & OrderID
                           
                     objRds.Open SQL , Conn
                     Do While NOT objRds.Eof
                            If objRds("PrintingName") & "" = "" Then
                                Result = false
                            End If                    
                            objRds.MoveNext   
                    Loop
                    objRds.close()
                    set objRds = nothing
            isDualPrintFNCLocal = Result
            On Error GoTo 0
    end function

     WriteLog Server.MapPath("OrderCome.txt"),"PageName = OrderCome.asp Start "

    Dim objCon2,objRds2
    Set objCon2 = Server.CreateObject("ADODB.Connection")
    Set objRds2 = Server.CreateObject("ADODB.Recordset") 
   
  
       dim printerURLList : printerURLList = "" 
       if rID  & "" <> ""  then
             Dim isDualPrint
                isDualPrint = false
                If LCase(IsDualReceiptPrinting & "") = "1" Then 
                    isDualPrint = true
                End If
          dim   DateCondition : DateCondition = cdate(DateAdd("h",houroffset,now))
                DateCondition = DatePart("m", DateCondition)&"/"&DatePart("d", DateCondition)&_
                               "/"&DatePart("yyyy", DateCondition)&" "&DatePart("h", DateCondition)&":"&_
                               DatePart("n", DateCondition)&":" & DatePart("s", DateCondition)

           dim SQL,objRds21 
               SQL = "  SELECT top 1  ID,OrderDate,'' as s_filename FROM view_paid_orders "
               SQL = SQL & " WHERE "
               SQL = SQL & "  "
               SQL = SQL & "  printed = 0  and DateDiff(day,Orderdate ,'" &DateCondition& "')  <= 1   and IdBusinessDetail=" & rID    
               SQL = SQL & "  and OrderDate is not null "
               SQL = SQL & " ORDER BY OrderDate  " 
              
               objCon2.Open sConnString
           set objRds21 = Server.CreateObject("ADODB.Recordset")
               objRds21.Open SQL, objCon2
           dim  isDualPrint_temp : isDualPrint_temp = isDualPrint
           dim  PrinterIDList_temp : PrinterIDList_temp = PrinterIDList 
           
           dim strReceiptList
           dim OrderID 
           dim URL ,urlimage
           dim isPrintDualSetting
            dim arrPrinterList
            dim printerIndex
           while not objRds21.EOF 
                isDualPrint = isDualPrint_temp
                PrinterIDList = PrinterIDList_temp
                  isPrintDualSetting = isDualPrintFNC(objRds21("ID"),objCon2)
              
                if isPrintDualSetting = false then
                    isDualPrint =  false
                end if
                if PrinterIDList = "" or isDualPrint = false then
                    PrinterIDList = "local_printer"
                end if
                WriteLog Server.MapPath("OrderCome.txt"),"PageName = OrderCome.asp Start reCreate Receipt for ORDER =  " & objRds21("ID")  & " Order Date " & objRds21("OrderDate") & " Server Time " & DateCondition
                OrderID = objRds21("ID")
               
                arrPrinterList = split( PrinterIDList,";")
                printerIndex = 0 
                for printerIndex = 0 to ubound(arrPrinterList)
                    if arrPrinterList(printerIndex) & "" <> "" then
                        
                            if instr(arrPrinterList(printerIndex) & "","PN") > 0  then
                                URL = SITE_URL & "printers/WinformsApp/Receipt.asp?mod=printingname&id_o=" & objRds21("ID")  & "&id_r=" & rID &"&isPrint=&idlist="
                             
                            else
                                URL = SITE_URL & "printers/WinformsApp/Receipt.asp?mod=dishname&id_o=" & objRds21("ID")  & "&id_r=" & rID &"&isPrint=&idlist="
                            end if
                          if printerURLList = "" then
                                printerURLList = URL
                          else 
                                printerURLList = printerURLList & "|" & URL 
                          end if  
                    end if
                next
                
            objRds21.movenext()
          wend
             objRds21.close()
            set objRds21  =  nothing
           
            if printerURLList & "" <> "" then
                printerURLList = printerURLList & "[**]" & OrderID&"[**]" & rID
            end if 
        ' Build List URL Local 
                dim printerURLListLocal : printerURLListLocal = "" 
                OrderID = 0
                SQL  = "Select top 1 ID,OrderDate from view_paid_orderslocal where    "
                SQL = SQL & "   ( printed = 0 )    and DateDiff(day,[orderdate],'" & DateCondition & "') <= 1 order by orderdate " 
                set objRds21 = Server.CreateObject("ADODB.Recordset")
                    objRds21.Open SQL, objCon2
                    PrinterIDList_temp = InRestaurantEpsonPrinterIdList
                   
                while not objRds21.EOF 
                        isDualPrint = isDualPrint_temp
                        PrinterIDList = PrinterIDList_temp
                        isPrintDualSetting = isDualPrintFNCLocal(objRds21("ID"),objCon2)
                        ' Response.Write("isPrintDualSetting " & isPrintDualSetting & "<br/>")
                        if isPrintDualSetting = false then
                            isDualPrint =  false
                        end if
                        if PrinterIDList = "" or isDualPrint = false then
                            PrinterIDList = "local_printer"
                        end if
                        WriteLog Server.MapPath("OrderCome.txt"),"PageName = OrderCome.asp Start reCreate Receipt Local  for ORDER =  " & objRds21("ID")  & " Order Date " & objRds21("OrderDate") & " Server Time " & DateCondition
                        OrderID = objRds21("ID")
               
                arrPrinterList = split( PrinterIDList,";")
                printerIndex = 0 
                for printerIndex = 0 to ubound(arrPrinterList)
                    if arrPrinterList(printerIndex) & "" <> "" then                         
                            if instr(arrPrinterList(printerIndex) & "","PN") > 0  then
                                URL = SITE_URL & "printers/WinformsApp/Receipt_local.asp?mod=printingname&id_o=" & objRds21("ID")  & "&id_r=" & rID &"&isPrint=&idlist="
                             
                            else
                                URL = SITE_URL & "printers/WinformsApp/Receipt_local.asp?mod=dishname&id_o=" & objRds21("ID")  & "&id_r=" & rID &"&isPrint=&idlist="
                            end if
                          if printerURLListLocal = "" then
                                printerURLListLocal = URL
                          else 
                                printerURLListLocal = printerURLListLocal & "|" & URL 
                          end if  
                    end if
                next
                
            objRds21.movenext()
          wend          
          
          objRds21.close()
         set objRds21 = nothing
          objCon2.close()
       end if
        if printerURLListLocal & "" <> "" then
            printerURLList = printerURLList &  "[***]" & printerURLListLocal & "[**]" & OrderID&"[**]" & rID
        end if
       if printerURLList <> "" then
            Response.Write(printerURLList)
       else
            Response.Write("NOTFOUND")
       end if
       On Error GoTo 0
       

    

 %>