<!-- #include file="../../Config.asp" -->
<%
     
    sub WriteOrderReceiptLog(byval orderid, byval receiptbyname,byval s_type,byval resid )
             
                    dim objCon1
                    Set objCon1 = Server.CreateObject("ADODB.Connection")
                        objCon1.Open sConnString
                    dim SQL_Update 
                        'SQL_Update= "Update Order_Receipt_tracking set s_printstatus  = 'created' where OrderID=" & orderid & " and IdBusinessDetail=" & resid & " and s_printtype='" &s_type &  "' and s_filename='"& receiptbyname &"' ;"
                        'objCon1.Execute(SQL_Update)      
                        dim objRds1 : set objRds1 = Server.CreateObject("ADODB.Recordset")
                       ' objCon.Open sConnString
          
                        objRds1.Open "SELECT * FROM Order_Receipt_tracking  WHERE orderid= " & orderid & " and IdBusinessDetail=" & resid & " and s_printtype='" & s_type & "' and s_filename='" &receiptbyname&"'", objCon1, 1, 3 
                        if objRds1.EOF then
                            objRds1.AddNew 
                            objRds1("orderid") = orderid
                            objRds1("IdBusinessDetail") = resid
                            objRds1("s_printtype") = s_type
                            objRds1("s_filename") = receiptbyname
                            objRds1("t_createdDate") = DateAdd("h",houroffset,now)
                          objRds1("s_printstatus") = "created"
                            objRds1.Update 
                        else
                          while not objRds1.EOF 
                                objRds1("s_printstatus") = "created"
                                  objRds1.Update 
                            objRds1.movenext
                          wend
                         
                        end if
                        
                            objRds1.close()
                       set  objRds1 = nothing  
                    objCon1.close
                    set objCon1 = nothing    
            
    end sub
    sub checkInsertForReceiptNotCreate(byval orderid, byval resid,byval filename,byval printtype)
        dim    SQL   ,SQL_insert     
        SQL = " select distinct top 1  Orderid from Order_Receipt_tracking b  where    IdBusinessDetail=" & resid & " and Orderid=" & orderid & " and s_printtype='"& printtype & "' and s_filename='" & filename & "'"
   
      dim objCon1, result
            result = true
            Set objCon1 = Server.CreateObject("ADODB.Connection")
            objCon1.Open sConnString
            dim RS_Order : set RS_Order  = Server.CreateObject("ADODB.Recordset")
                RS_Order.Open SQL , objCon1, 1, 3 
                if RS_Order.eof then                    
                    
                        dim   DateCondition : DateCondition = cdate(DateAdd("h",houroffset,now))
                              DateCondition = DatePart("m", DateCondition)&"/"&DatePart("d", DateCondition)&_
                               "/"&DatePart("yyyy", DateCondition)&" "&DatePart("h", DateCondition)&":"&_
                               DatePart("n", DateCondition)&":" & DatePart("s", DateCondition)

                        dim SQLCheck,RS_Order1 
                            set RS_Order1 = Server.CreateObject("ADODB.Recordset")
                          
                         SQLCheck = "select ID from orders where IdBusinessDetail=" & resid & " and ID = "& orderid & " and DateDiff(day,Orderdate ,'" &DateCondition& "') )  <= 1 "  
                         RS_Order1.Open SQLCheck , objCon1, 1, 3              
                            if not RS_Order1.EOF then
                                SQL_insert =  "Insert into Order_Receipt_tracking(OrderID,s_filename,s_printtype,IdBusinessDetail,t_createdDate,s_printstatus) "
                                SQL_insert = SQL_insert & " values(" & orderid &",'" &  filename  &"','epson'," & resid & ",'" & DateAdd("h",houroffset,now) & "','New') ; "     
                                objCon1.Execute(SQL_insert)
                            end if
                            RS_Order1.close()
                        set RS_Order1 = nothing
                end if
            RS_Order.close()
            set RS_Order = nothing
            objCon1.close()
            set objCon1 = nothing
           

    end sub

    function isCreateLocal(byval orderid, byval receiptbyname,byval s_type,byval resid )

            dim objCon1, result
            result = false
            Set objCon1 = Server.CreateObject("ADODB.Connection")
            objCon1.Open sConnString
            dim RS_Order : set RS_Order  = Server.CreateObject("ADODB.Recordset")
                RS_Order.Open "select s_printstatus from [Order_Receipt_tracking]  where orderid = " & orderid & " and s_filename='" & receiptbyname & "' and s_printtype='" &s_type& "' and IdBusinessDetail = " & resid , objCon1, 1, 3 
                if not RS_Order.eof then
                    result =  true
                end if
                RS_Order.close()
            set RS_Order = nothing
            objCon1.close()
            set objCon1 = nothing
            isCreateLocal = result
    end function

    function isCreate(byval orderid, byval receiptbyname,byval s_type,byval resid )

            dim objCon1, result
            result = true
            Set objCon1 = Server.CreateObject("ADODB.Connection")
            objCon1.Open sConnString
            dim RS_Order : set RS_Order  = Server.CreateObject("ADODB.Recordset")
                RS_Order.Open "select s_printstatus from [Order_Receipt_tracking]  where s_printstatus = 'new' and  orderid = " & orderid & " and s_filename='" & receiptbyname & "' and s_printtype='" &s_type& "' and IdBusinessDetail = " & resid , objCon1, 1, 3 
                if not RS_Order.eof then
                    result =  false
                end if
            RS_Order.close()
            set RS_Order = nothing
            objCon1.close()
            set objCon1 = nothing
            isCreate = result
    end function
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

    WriteLog Server.MapPath("EpsonPostImageAndPrint.txt"),"Pagename  = Saveimage.asp " 
    
        
   Dim b64, oId, rId
   b64 =  Request.Form("img")
   oId = Request.Form("o_id")

   rId = Request.Form("r_id")
  dim isprint : isprint = request.Form("isprint")
     WriteLog Server.MapPath("EpsonPostImageAndPrint.txt"),"Pagename  = Saveimage.asp [Refer URL] " & Request.ServerVariables ("HTTP_REFERER")
    If b64 & "" <> "" AND oId & "" <> "" AND rId & "" <> "" Then
        WriteLog Server.MapPath("EpsonPostImageAndPrint.txt"),"Pagename  = Saveimage.asp start saving " 
        Dim objFSO
        Set objFSO=CreateObject("Scripting.FileSystemObject")
        oId = Replace(oId,".","")
        rId = Replace(rId,".","")
        Dim FileMod
        FileMod = ""
        if Request.form("mod") & "" = "printingname" Then
            FileMod = "-PN"
            
        End IF
        ' How to write file
        Dim outFile, outFilePath, printingFilePath
        outFilePath= Server.MapPath("ReceiptImage")
        printingFilePath = Server.MapPath("ReceiptImage\Printing\")
        'outFile = outFile & "\" & rId & "-" & oId & ".txt"
        
        
        Dim objCon2,objRds2
        Set objCon2 = Server.CreateObject("ADODB.Connection")
        Set objRds2 = Server.CreateObject("ADODB.Recordset") 

            objCon2.Open sConnString            
            objRds2.Open "SELECT * FROM [BusinessDetails] WHERE Id = " & rId, objCon2, 1, 3 
            Dim PrinterList
            dim fromLocal : fromLocal = false 
            
            If UCase(Request.Form("local")) ="Y" Then
                 fromLocal = true
                 if Request.Form("idlist") & "" <> "" then
                     PrinterList =  Request.Form("idlist") & ""
                 elseIf objRds2("InRestaurantEpsonPrinterIdList") & "" <> "" Then
                    PrinterList = objRds2("InRestaurantEpsonPrinterIdList")                            
                Else
                    PrinterList = "local_printer"
                End If
            elseif Request.Form("idlist") & "" <> "" Then
                PrinterList =  Request.Form("idlist") & ""
            Else
                If objRds2("PrinterIDList") & "" <> "" Then
                    PrinterList = objRds2("PrinterIDList")                            
                Else
                    PrinterList = "local_printer"
                End If
            End If
            objRds2.Close
            objCon2.Close

       
        Set objRds2 = nothing
        Set objCon2 = nothing

        Dim arrPrinter, i 
         WriteLog Server.MapPath("EpsonPostImageAndPrint.txt")," PrinterList  " & PrinterList
        arrPrinter = Split(PrinterList,";")
        '' Write log start write image
            WriteLog Server.MapPath("EpsonPostImageAndPrint.txt"),"Pagename  = Saveimage.asp [Orderid]  = " &  oId      
        For i = 0 To UBound(arrPrinter)
            
            dim printtingtype : printtingtype = "epson"
            if fromLocal = true then
                 printtingtype ="local_printer"
            end if
            If arrPrinter(i) & "" <> "" Then
              dim isCheckImageExist  : isCheckImageExist = true
                dim s_filenamesave
                If FileMod & "" = "-PN" AND Instr(arrPrinter(i) & "","PN:") > 0 Then
                    s_filenamesave = rId & "-" & oId & "-" & Replace(arrPrinter(i),"PN:","") & "-" & i & FileMod & ".txt"
                    outFile = outFilePath & "\" & s_filenamesave
                    if fromLocal = false then
                        call checkInsertForReceiptNotCreate(oId,rId,s_filenamesave,"epson")
                    end if
                    isCheckImageExist = isCreateLocal(oId,  s_filenamesave,printtingtype,rId) 
                    ' WriteLog Server.MapPath("EpsonPostImageAndPrint.txt"),"Pagename  = Saveimage.asp isCheckImageExist  " & isCheckImageExist
                    if isprint & "" = "Y"  or   isCreate(oId,  s_filenamesave,printtingtype,rId) = false or (fromLocal=true and isCheckImageExist = false )  then
                            WriteLog Server.MapPath("EpsonPostImageAndPrint.txt"),"Pagename  = Saveimage.asp before create image -PN  = " &  printingFilePath & "\" & s_filenamesave
                            if NOT objFSO.FileExists(printingFilePath & "\" & s_filenamesave ) Then
                                Set objFile = objFSO.CreateTextFile(outFile,True)
                                objFile.Write b64
                                objFile.Close
                                Set objFile = nothing
                                call WriteOrderReceiptLog(oId, s_filenamesave,printtingtype,rId)
                                WriteLog Server.MapPath("EpsonPostImageAndPrint.txt"),"Pagename  = Saveimage.asp Done write file PN   = " & outFile
                            End If
                    end if
                ElseIf  FileMod & "" = "" AND Instr(arrPrinter(i) & "","PN:") < 1 Then
                    s_filenamesave =  rId & "-" & oId & "-" & arrPrinter(i) & "-" & i & FileMod & ".txt"
                    outFile = outFilePath & "\" &s_filenamesave
                    if fromLocal = false then
                        call checkInsertForReceiptNotCreate(oId,rId,s_filenamesave,"epson")
                    end if
                    'Response.Write("FileMod " & FileMod &  "  fromLocal" &  fromLocal )
                      isCheckImageExist = isCreateLocal(oId,  s_filenamesave,printtingtype,rId) 
                    if isprint & "" = "Y"  or  isCreate(oId, s_filenamesave,printtingtype,rId) = false  or ( fromLocal=true and isCheckImageExist = false )   then
                        WriteLog Server.MapPath("EpsonPostImageAndPrint.txt"),"Pagename  = Saveimage.asp before create image 0  = " &  printingFilePath & "\" & s_filenamesave   
                        if NOT objFSO.FileExists(printingFilePath & "\" & s_filenamesave) Then
                            Set objFile = objFSO.CreateTextFile(outFile,True)
                            objFile.Write b64
                            objFile.Close
                            Set objFile = nothing
                             call  WriteOrderReceiptLog(oId,s_filenamesave,printtingtype,rId)
                             WriteLog Server.MapPath("EpsonPostImageAndPrint.txt"),"Pagename  = Saveimage.asp Done write file 0  = " & outFile
                        End If
                    end if
                End If
            End if 
        Next         
        set objFSO = nothing
        Response.Write("OK")
    Else
        Response.Write("NODATA")
    End if
     %>