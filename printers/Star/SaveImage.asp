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
                        set objRds1 = nothing
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
                           
                         SQLCheck = "select ID from orders where IdBusinessDetail=" & resid & " and ID = "& orderid & "   and DateDiff(day,Orderdate ,'" &DateCondition& "')   <= 1 "  
                         RS_Order1.Open SQLCheck , objCon1, 1, 3              
                            if not RS_Order1.EOF then
                                SQL_insert =  "Insert into Order_Receipt_tracking(OrderID,s_filename,s_printtype,IdBusinessDetail,t_createdDate,s_printstatus) "
                                SQL_insert = SQL_insert & " values(" & orderid &",'" &  filename  &"','"&printtype&"'," & resid & ",'" & DateAdd("h",houroffset,now) & "','New') ; "     
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
        
        Dim logobjFSO, logFile
        set logobjFSO = CreateObject("Scripting.FileSystemObject")
        set logFile = logobjFSO.OpenTextFile(logFilePath,8,true) ' 8 is for appending
        logFile.WriteLine(now() & ": " & logContent)
        set logFile = nothing
        set logobjFSO = nothing
    End sub
   Dim b64, oId, rId

   b64 = Request.Form("img")
   oId = Request.Form("o_id")
   rId = Request.Form("r_id")
     dim isprint : isprint = request.Form("isprint")
    WriteLog Server.MapPath("StartPostImageAndPrint.txt"),"Pagename  = Saveimage.asp [Refer URL] " & Request.ServerVariables ("HTTP_REFERER")
   b64 = Replace(b64,"data:image/png;base64,","")
    If b64 & "" <> "" AND oId & "" <> "" AND rId & "" <> "" Then
        WriteLog Server.MapPath("StartPostImageAndPrint.txt"),"Pagename  = Saveimage.asp start saving " 
        Dim objFSO
        Set objFSO=CreateObject("Scripting.FileSystemObject")
        oId = Replace(oId,".","")
        rId = Replace(rId,".","")
        Dim FileMod
        FileMod = ""
        if Request.form("mod") & "" = "printingname" Then
            FileMod = "-PN"
        End IF
        
         ' Check Print = Y don't allow create image
                    ' End    
         dim s_filenamesave : s_filenamesave = rId & "-" & oId & FileMod & ".png"
         call checkInsertForReceiptNotCreate(oId,rId,s_filenamesave,"star") 
         dim createdReceipt : createdReceipt =     isCreate(oId, s_filenamesave,"star",rId)
        ' How to write file
        Dim outFile, outFilePath, printingFilePath
        outFilePath= Server.MapPath("ReceiptImage")
        
        if createdReceipt = false then
            If b64 = "-1" Then
                Dim objFile
                Set objFile = objFSO.CreateTextFile(outFilePath & "\" & rId & "-" & oId & FileMod & ".txt",True)
                objFile.Write b64
                objFile.Close
                set objFile =  nothing
            Else
              
                Dim CanvasStream
                Set CanvasStream = Base64Data2Stream(b64)
            
                CanvasStream.SaveToFile outFilePath & "\" & rId & "-" & oId & FileMod & ".png", 2 'adSaveCreateOverWrite
                call WriteOrderReceiptLog(oId, s_filenamesave,"star",rId)
                WriteLog Server.MapPath("StartPostImageAndPrint.txt"),"Pagename  = Saveimage.asp Done create receipt file   " &  rId & "-" & oId & FileMod & ".png"
                set CanvasStream = nothing
            End If
        else
            Response.Write("NODATA")
        end if
        'printingFilePath = Server.MapPath("ReceiptImage\Printing\")
        'outFile = outFile & "\" & rId & "-" & oId & ".png"
        set objFSO = nothing
        Response.Write("OK")
    Else
        Response.Write("NODATA")
    End if

Function Base64Data2Stream(sData)
    Set Base64Data2Stream = Server.CreateObject("Adodb.Stream")
        Base64Data2Stream.Type = 1 'adTypeBinary
        Base64Data2Stream.Open
    With Server.CreateObject("MSXML2.DomDocument.6.0").createElement("b64")
        .dataType = "bin.base64"
        .text = sData
        Base64Data2Stream.Write .nodeTypedValue 'write bytes of decoded base64 to stream
        Base64Data2Stream.Position = 0
    End With
End Function

     %>