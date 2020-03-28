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
    Function WriteLogBat(logFilePath, logContent)
        On Error Resume Next
            Dim logobjFSO, logFile
            set logobjFSO = CreateObject("Scripting.FileSystemObject")
            set logFile = logobjFSO.OpenTextFile(logFilePath,8,true) ' 8 is for appending
            logFile.WriteLine( logContent)
            set logFile = nothing
            set logobjFSO = nothing
        On Error GoTo 0
    End Function

    sub RecreateByIE(byval strmod,byval orderid, byval resid)
        
        dim buildURL : buildURL =replace( replace(SITE_URL,"http://",""),"https://","") & "printers/epson/print_t.asp?mod=" & strmod & "&id_o=" &orderid& "&id_r=" & resid & "&isPrint=&idlist="
        WriteLog Server.MapPath("EpsonPostImageAndPrint.txt"),"PageName = reprintxml_order.asp RecreateByIE  " & buildURL
        Set WshShell = CreateObject("WScript.Shell")
            'Return = WshShell.Run("iexplore.exe http://my.outsource.com/test/serverbrowse/write-file.asp", 1)
      
        Return = WshShell.Run("iexplore.exe " & buildURL, 1)    
      
         for m=1 to 1000
                        For i = 1 To 50000
                        next
              next   
        Set WshShell = nothing
         WriteLog Server.MapPath("EpsonPostImageAndPrint.txt"),"PageName = reprintxml_order.asp End  RecreateByIE  OrderID = " & orderid
    end sub

    sub RecreateByPlainText(byval strmod,byval orderid, byval resid,byval Conn)
        
       
    end sub


    sub ReCreateReceipt(byval strmod,byval orderid, byval resid, byval rootpath,byval RePrintReceiptWays,byval Conn,byval PrinterIDList)
       ' On Error Resume Next
        Dim objFSOPT
       Set objFSOPT=CreateObject("Scripting.FileSystemObject")
        ' Create Bat file 
        dim batfilepath : batfilepath = Server.MapPath(rootpath + "/" & orderid & "-" & resid & "-" & strmod & ".bat")
            if lcase(RePrintReceiptWays &"") = "ie" then              
               call RecreateByIE(strmod,orderid,resid)
                exit sub
            elseif lcase(RePrintReceiptWays &"") = "plaintext" then             
                'call RecreateByPlainText(strmod,orderid,resid,Conn)
                exit sub
            
            end if
            WriteLogBat batfilepath,split(batfilepath,":")(0) & ":"
            WriteLogBat batfilepath,"cd "  & Server.MapPath(rootpath)
            WriteLogBat batfilepath,"phantomjs "& Server.MapPath(rootpath) &"\exe.js " & SITE_URL & "printers/epson/print_t.asp " & strmod & " " & orderid & " " & resid & " " & "N" & " " & PrinterIDList 
            WriteLog Server.MapPath("EpsonPostImageAndPrint.txt"),"PageName = reprintxml_order.asp ReCreateReceipt  ORDER =  " & orderid 
            Dim WshShell 
            Set WshShell = CreateObject("WScript.Shell") 
            'dim objFSO : objFSO = Set objFSO=CreateObject("Scripting.FileSystemObject")
              WriteLog Server.MapPath("EpsonPostImageAndPrint.txt"),"PageName =reprintxml_order.asp ReCreateReceipt  END Order = " & orderid & " batfilepath = " & batfilepath 
               WshShell.Run batfilepath 
             for m=1 to 1000
                        For i = 1 To 30000
                        next
              next
            
             objFSOPT.DeleteFile batfilepath, true
            set WshShell = nothing
            'WshShell =  nothing
            set objFSOPT = nothing 
        ' End
         WriteLog Server.MapPath("EpsonPostImageAndPrint.txt"),"PageName = reprintxml_order.asp ReCreateReceipt  END Order = " & orderid
       ' On Error GoTo 0
    end sub
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
      
     WriteLog Server.MapPath("EpsonPostImageAndPrint.txt"),"PageName = reprintxml_order.asp Start "

    Dim objCon2,objRds2
    Set objCon2 = Server.CreateObject("ADODB.Connection")
    Set objRds2 = Server.CreateObject("ADODB.Recordset") 
   
    ' Check if Order didn't create receipt in 2 minutes
         On Error Resume Next
        if RePrintReceiptWays & "" = "" then
            RePrintReceiptWays = "none"
        end if
       
       if printingtype = "text" then
            newWay = true
       end if
      
       if ( rID  & "" <> "" and RePrintReceiptWays <> "none" and newWay = false)   then
      
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
               SQL = "  SELECT  ID,OrderDate,'' as s_filename FROM view_paid_orders o  "
               SQL = SQL & " WHERE "
               SQL = SQL & "   "
               SQL = SQL & "  printed = 0 and DateDiff(second,Orderdate ,'" &DateCondition& "')   >=30    and IdBusinessDetail=" & rID    
               SQL = SQL & " and id not in (select orderid from Order_Receipt_tracking ort where ort.orderid = o.id  )  and o.OrderDate is not null "
              ' SQL = SQL & " ORDER BY ORDERS.OrderDate  "
               SQL = SQL & " Union "    
               SQL = SQL & " select top 1   o.ID,o.OrderDate,s_filename  from view_paid_orders as o , Order_Receipt_tracking b  where o.ID  = b.Orderid and b.s_printstatus = 'NEW' "
               SQL = SQL & "  "
               
                SQL = SQL & "  and  DateDiff(second,Orderdate ,'" &DateCondition& "')   >=30    and o.IdBusinessDetail=" & rID
          
               objCon2.Open sConnString
           set objRds21 = Server.CreateObject("ADODB.Recordset")
               objRds21.Open SQL, objCon2
           dim  isDualPrint_temp : isDualPrint_temp = isDualPrint
           dim  PrinterIDList_temp : PrinterIDList_temp = PrinterIDList 
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
                  WriteLog Server.MapPath("EpsonPostImageAndPrint.txt"),"PageName = reprintxml_order.asp Start reCreate Receipt for ORDER =  " & objRds21("ID")  & " Order Date " & objRds21("OrderDate") & " Server Time " & DateCondition
                If UCase(SEND_ORDERS_TO_PRINTER) = "EPSON" Then    
                    
                     if isDualPrint  =  true and RePrintReceiptWays <> "plaintext" then
                            dim s_filenamepreprint : s_filenamepreprint = objRds21("s_filename") & ""
                                s_filenamepreprint = ""

    

                            if trim(s_filenamepreprint) = "" then
                                call ReCreateReceipt("dishname",objRds21("ID"),rID,RootDefaultPath & "/printers/epson/ptjs",RePrintReceiptWays,objCon2,PrinterIDList)
                                call ReCreateReceipt("printingname",objRds21("ID"),rID,RootDefaultPath & "/printers/epson/ptjs",RePrintReceiptWays,objCon2,PrinterIDList)   
                                
                            else
                               
                                if instr(s_filenamepreprint,"PN.txt") > 0 then
                                     call ReCreateReceipt("printingname",objRds21("ID"),rID,RootDefaultPath & "/printers/epson/ptjs",RePrintReceiptWays,objCon2,PrinterIDList)   
                                else
                                     call ReCreateReceipt("dishname",objRds21("ID"),rID,RootDefaultPath & "/printers/epson/ptjs",RePrintReceiptWays,objCon2,PrinterIDList)                
                                end if
                            end if                      
                      else
                           call ReCreateReceipt("dishname",objRds21("ID"),rID,RootDefaultPath & "/printers/epson/ptjs",RePrintReceiptWays,objCon2,PrinterIDList)
                     end if
                    ' Wait for receipt created 
                    
                end if
            objRds21.movenext()
          wend
            objRds21.close()
            set objRds21  =  nothing
           objCon2.close()
       end if
       On Error GoTo 0
       

    

 %>