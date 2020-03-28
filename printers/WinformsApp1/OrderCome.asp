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
      
     WriteLog Server.MapPath("OrderCome.txt"),"PageName = OrderCome.asp Start "

    Dim objCon2,objRds2
    Set objCon2 = Server.CreateObject("ADODB.Connection")
    Set objRds2 = Server.CreateObject("ADODB.Recordset") 
   
  
       dim printerURLList : printerURLList = "" 
       if rID  & "" <> ""  then
             Dim isDualPrint
                isDualPrint = false
                If LCase(IsDualReceiptPrinting & "") = "true" Then 
                    isDualPrint = true
                End If
          dim   DateCondition : DateCondition = cdate(DateAdd("h",houroffset,now))
                DateCondition = DatePart("m", DateCondition)&"/"&DatePart("d", DateCondition)&_
                               "/"&DatePart("yyyy", DateCondition)&" "&DatePart("h", DateCondition)&":"&_
                               DatePart("n", DateCondition)&":" & DatePart("s", DateCondition)

           dim SQL,objRds21 
               SQL = "  SELECT top 1  ID,OrderDate,'' as s_filename FROM ORDERS "
               SQL = SQL & " WHERE "
               SQL = SQL & "  (paymenttype='Paypal-Paid' or paymenttype='NoChex-Paid' or paymenttype='Worldpay-Paid' "
               SQL = SQL & " or paymenttype='Cash on Delivery' ) and printed = no  and IIf ( IsNull ( [OrderDate] ) ,2, DateDiff('s',Format(Orderdate,'mm/dd/yyyy hh:nn:ss AM/PM') ,'" &DateCondition& "'))  >=30 and IIf ( IsNull ( [OrderDate] ) ,2, DateDiff('d',Format(Orderdate,'mm/dd/yyyy hh:nn:ss AM/PM') ,'" &DateCondition& "'))  <= 1   and IdBusinessDetail=" & rID    
               SQL = SQL & "  and ORDERS.OrderDate is not null "
               SQL = SQL & " ORDER BY ORDERS.OrderDate  " 
              
               objCon2.Open sConnString
           set objRds21 = Server.CreateObject("ADODB.Recordset")
               objRds21.Open SQL, objCon2
           dim  isDualPrint_temp : isDualPrint_temp = isDualPrint
           dim  PrinterIDList_temp : PrinterIDList_temp = PrinterIDList 
           
           dim strReceiptList
           dim OrderID 
           while not objRds21.EOF 
                isDualPrint = isDualPrint_temp
                PrinterIDList = PrinterIDList_temp
                dim isPrintDualSetting : isPrintDualSetting = isDualPrintFNC(objRds21("ID"),objCon2)
              
                if isPrintDualSetting = false then
                    isDualPrint =  false
                end if
                if PrinterIDList = "" or isDualPrint = false then
                    PrinterIDList = "local_printer"
                end if
                WriteLog Server.MapPath("OrderCome.txt"),"PageName = OrderCome.asp Start reCreate Receipt for ORDER =  " & objRds21("ID")  & " Order Date " & objRds21("OrderDate") & " Server Time " & DateCondition
                OrderID = objRds21("ID")
               
                dim arrPrinterList : arrPrinterList = split( PrinterIDList,";")
                dim printerIndex :  printerIndex = 0 
                for printerIndex = 0 to ubound(arrPrinterList)
                    if arrPrinterList(printerIndex) & "" <> "" then
                         dim URL ,urlimage
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
           objCon2.close()
            if printerURLList & "" <> "" then
                printerURLList = printerURLList & "[**]" & OrderID&"[**]" & rID
            end if 
       end if
       if printerURLList <> "" then
            Response.Write(printerURLList)
       else
            Response.Write("NOTFOUND")
       end if
       On Error GoTo 0
       

    

 %>