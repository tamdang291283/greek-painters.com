<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../../Config.asp" -->

<!-- #include file="../../timezone.asp" -->
<%
     
    
     Dim lngBytesCount, RequestContent
    lngBytesCount = 0
    RequestContent = ""
    If Request.TotalBytes > 0 Then    
        RequestContent  =  BytesToStr(Request.BinaryRead(Request.TotalBytes))  
    End If
   
    Dim objFSO, rID, objCon2,objRds2
    Dim imgFolder, fo, objFile, strContent, printingFolder, pfo, isPrinting, isPendingPrinting, printingName, pendingName
    rID = Request.QueryString("id_r") 
    If Instr(rID,"?") > 0 Then
        rID = left(rID,Instr(rID,"?") - 1)
    End If

     If RequestContent & "" <> "" Then
        Call WriteLog(Server.MapPath("l.txt"), rID & "|" & Request.ServerVariables("REQUEST_METHOD") & "|" & Request.QueryString & "|Content:" & RequestContent )
    Else
        Call WriteLog(Server.MapPath("l.txt"), rID & "|" &  Request.ServerVariables("REQUEST_METHOD") & "|" & Request.QueryString  & "|Form:" & Request.Form )
    
    End If
   
    If rID & "" = "" Then
        Response.Redirect("../../error.asp")
    End If
    session("restaurantid")=rID
   
     %>
<!-- #include file="../../restaurantsettings.asp" -->
<%
   
    
  sub WriteLog(logFilePath, logContent)
      
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
    sub ReCreateReceipt(byval strmod,byval orderid, byval resid, byval rootpath,byval RePrintReceiptWays,byval Conn)
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
            WriteLogBat batfilepath,"phantomjs "& Server.MapPath(rootpath) &"\exe.js " & SITE_URL & "printers/star/print_t.asp " & strmod & " " & orderid & " " & resid 
            WriteLog Server.MapPath("StarPrintReceipt.txt"),"PageName = starprinting.asp ReCreateReceipt  ORDER =  " & orderid 
            Dim WshShell 
            Set WshShell = CreateObject("WScript.Shell") 
            'dim objFSO : objFSO = Set objFSO=CreateObject("Scripting.FileSystemObject")
              WriteLog Server.MapPath("StarPrintReceipt.txt"),"PageName starprinting.asp ReCreateReceipt  END Order = " & orderid & " batfilepath = " & batfilepath 
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
         WriteLog Server.MapPath("StarPrintReceipt.txt"),"PageName = starprinting.asp ReCreateReceipt  END Order = " & orderid
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

     if rID  & "" <> ""  and Request.QueryString("pt")="Y"  then
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
               SQL = "  SELECT  ID,OrderDate,'' as s_filename FROM view_paid_orders o "
               SQL = SQL & " WHERE "
               SQL = SQL & "  "
               SQL = SQL & "  printed = 0  and DateDiff(second,Orderdate ,'" &DateCondition& "') >=30   and IdBusinessDetail=" & rID    
               SQL = SQL & " and id not in (select orderid from Order_Receipt_tracking ort where ort.orderid = o.id  )  and o.OrderDate is not null "
              ' SQL = SQL & " ORDER BY ORDERS.OrderDate  "
               SQL = SQL & " Union "    
               SQL = SQL & " select top 1   o.ID,o.OrderDate,s_filename  from view_paid_orders as o , Order_Receipt_tracking b  where o.ID  = b.Orderid and b.s_printstatus = 'NEW'  "
               SQL = SQL & " "
               SQL = SQL & "  and DateDiff(second,Orderdate ,'" &DateCondition& "') >=30   and o.IdBusinessDetail=" & rID
       
         Set objCon2 = Server.CreateObject("ADODB.Connection")
               objCon2.Open sConnString
           set objRds21 = Server.CreateObject("ADODB.Recordset")
               objRds21.Open SQL, objCon2
           while not objRds21.EOF 
                dim isPrintDualSetting : isPrintDualSetting = isDualPrintFNC(objRds21("ID"),objCon2)
                if isPrintDualSetting = false then
                    isDualPrint =  false
                end if
            
                  WriteLog Server.MapPath("StarPrintReceipt.txt"),"PageName = starprinting.asp Start reCreate Receipt for ORDER =  " & objRds21("ID")  & " Order Date " & objRds21("OrderDate") & " Server Time " & DateCondition
                If UCase(SEND_ORDERS_TO_PRINTER) = "STAR" Then    
                     if isDualPrint  =  true  then
                            dim s_filenamepreprint : s_filenamepreprint = objRds21("s_filename") & ""
                                s_filenamepreprint = ""
                          
                                call ReCreateReceipt("dishname",objRds21("ID"),rID,RootDefaultPath & "/printers/epson/ptjs",RePrintReceiptWays,objCon2)
                                call ReCreateReceipt("printingname",objRds21("ID"),rID,RootDefaultPath & "/printers/epson/ptjs",RePrintReceiptWays,objCon2)   
                                          
                      else
                           call ReCreateReceipt("dishname",objRds21("ID"),rID,RootDefaultPath & "/printers/epson/ptjs",RePrintReceiptWays,objCon2)
                     end if
                    ' Wait for receipt created 
                    
                end if
            objRds21.movenext()
          wend
            objRds21.close()
            set objRds21  =  nothing
           objCon2.close()
           set objCon2 = nothing
       end if

     
   
    printingName = ""
    pendingName = ""
    If Request.ServerVariables("REQUEST_METHOD")= "POST" Then   
        If RequestContent & "" <> "" Then
            If Instr(RequestContent,"""status"": ""2") = 0 Then
                SendAlertEmail("postdata:" & RequestContent  & " .Request.Querystring:" & Request.QueryString) 
                Response.End()
            End If
        Else 

            Response.End()
        End if
        Set objFSO=CreateObject("Scripting.FileSystemObject")
        
        isPrinting = false
        imgFolder = Server.MapPath("ReceiptImage\")
        printingFolder = Server.MapPath("ReceiptImage\Printing\")   
        set pfo = objFSO.GetFolder(printingFolder)
        for each f in pfo.files
            If Instr(f.Name,rID&"-") = 1   Then
                printingName = f.Name
                isPrinting = true
                Exit For
            End If 
        Next
       
        Response.ContentType = "application/json"
        Response.Status = "200 OK"
        If isPrinting Then
            'Response.Write("{""jobReady"": false,""mediaTypes"": [ ""image/png"" ],""deleteMethod"": ""GET""}")  '
             If Instr(printingName,".txt") > 0 Then
                Response.Write("{""jobReady"": true,""mediaTypes"": [ ""text/plain"" ],""deleteMethod"": ""GET""}")  '
            Else
                Response.Write("{""jobReady"": true,""mediaTypes"": [ ""image/png"" ],""deleteMethod"": ""GET""}")  '
            End If
        Else
            set pfo = nothing
            set pfo = objFSO.GetFolder(imgFolder)
            isPendingPrinting = false
            for each f in pfo.files
                If Instr(f.Name,rID&"-") = 1    Then
                    isPendingPrinting = true
                    pendingName = f.name
                    Exit For
                End If 
            Next
            If isPendingPrinting Then
                If Instr(pendingName,".txt") > 0 Then
                    Response.Write("{""jobReady"": true,""mediaTypes"": [ ""text/plain"" ],""deleteMethod"": ""GET""}")  '
                Else
                    Response.Write("{""jobReady"": true,""mediaTypes"": [ ""image/png"" ],""deleteMethod"": ""GET""}")  '
                End If
            Else
                Response.Write("{""jobReady"": false,""mediaTypes"": [ ""image/png"" ],""deleteMethod"": ""GET""}")  '
            End If
        End If
        set pfo = nothing
        Set objFSO = nothing
        Response.end()
    ElseIf Request.ServerVariables("REQUEST_METHOD")= "GET" AND  Instr(Lcase(Request.QueryString),"delete") < 1 Then
        
         Set objFSO=CreateObject("Scripting.FileSystemObject")
        
        isPrinting = false
        imgFolder = Server.MapPath("ReceiptImage\")
        printingFolder = Server.MapPath("ReceiptImage\Printing\")   
        set pfo = objFSO.GetFolder(printingFolder)
        for each f in pfo.files
            If Instr(f.Name,rID&"-") = 1    Then
                isPrinting = true
                printingName = f.Name
                Exit For
            End If 
        Next
        If isPrinting Then
            Response.Status = "200 OK"
            If Instr(printingName,".txt") > 0 Then
                Response.ContentType = "text/plain"
                Response.Write(PrintTextOrder(Replace(Replace(printingName,".txt",""),rID&"-",""), rID) )
            Else
                Response.ContentType = "image/png"
                Response.BinaryWrite(ReadBinaryFile(printingFolder  & "/" & printingName ))
            End If
        Else
            set pfo = nothing
            set pfo = objFSO.GetFolder(imgFolder)
            isPendingPrinting = false
            for each f in pfo.files
                If Instr(f.Name,rID&"-") = 1    Then
                    isPendingPrinting = true
                    pendingName = f.Name
                    Exit For
                End If 
            Next
            If isPendingPrinting Then
                Response.Status = "200 OK"
                If Instr(pendingName,".txt") > 0 Then
                    Response.ContentType = "text/plain"
                    Response.Write(PrintTextOrder(Replace(Replace(pendingName,".txt",""),rID&"-",""), rID) )
                Else
                    Response.ContentType = "image/png"
                
                    Response.BinaryWrite(ReadBinaryFile(imgFolder  & "/" & pendingName ))
                End If
                objFSO.MoveFile imgFolder&"/"&pendingName,printingFolder & "/"&pendingName
            Else
                Response.Status = "404 NOT FOUND"
                Response.ContentType = "image/png"
                Response.Write("NOT FOUND")  '
            End If
        End If
        set pfo = nothing
        Set objFSO = nothing
         Response.end()
    ElseIf Request.ServerVariables("REQUEST_METHOD")= "GET" AND Instr(Lcase(Request.QueryString),"delete") > 0 Then
       ' Response.Write("AAAAA" & Lcase(Request.QueryString) )
        If Instr(Lcase(Request.QueryString) & "","200") > 0 Then ' Print ok. Delete currenting printing file
            
            Set objFSO=CreateObject("Scripting.FileSystemObject")
        
            isPrinting = false
            imgFolder = Server.MapPath("ReceiptImage\")
            printingFolder = Server.MapPath("ReceiptImage\Printing\")   
            set pfo = objFSO.GetFolder(printingFolder)
            for each f in pfo.files
                If Instr(f.Name,rID&"-") > 0  Then
                    isPrinting = true
                    printingName = f.Name
                    Exit For
                End If 
            Next
            If printingName & "" <> "" Then
                Dim tOid
                'tOid = Replace(printingName,rID&"-","")
                tOid = Right(printingName ,Len(printingName) - Len(rID & "-"))
                tOid = Replace(tOid,".png","")
                tOid = Replace(tOid,".txt","")
                tOid = Replace(tOid,"-PN","")
        
                Set objCon2 = Server.CreateObject("ADODB.Connection")
                Set objRds2 = Server.CreateObject("ADODB.Recordset") 
                objCon2.Open sConnString
               
                objRds2.Open "SELECT * FROM [Orders] WHERE Id = " & tOid, objCon2, 1, 3 
                objRds2("printed") = 1
                objRds2.Update 
                            
                objRds2.Close
                objCon2.Close 
                set objRds2 = nothing
                set objCon2 = nothing
                objFSO.DeleteFile printingFolder & "/" & printingName, true
            End If
             set pfo = nothing
            Set objFSO = nothing
            Response.Status = "200 OK"
        Else
             SendAlertEmail("Query string:" & Request.QueryString) 
             Response.End()
        End If
         'Response.ContentType = "image/png"
         'Response.BinaryWrite(ReadBinaryFile(Server.MapPath("s.png")))
         'Response.end()
    End If
     
   
Function ReadBinaryFile(strFileName) 
        on error resume next 
        Set oStream = Server.CreateObject("ADODB.Stream") 
        if Err.Number <> 0 then 
                ReadBinaryFile=Err.Description 
                Err.Clear 
                exit function 
        end if 
        oStream.Type = 1  
        oStream.Open 

        oStream.LoadFromFile strFileName 
        if Err.Number<>0 then 
                ReadBinaryFile=Err.Description 
                Err.Clear 
                exit function 
        end if 
        ReadBinaryFile=oStream.Read 
        oStream.Close 
        set oStream = nothing 
        if Err.Number<>0 then ReadBinaryFile=Err.Description 
End Function  
      Function BytesToStr(bytes)
        Dim Stream
        Set Stream = Server.CreateObject("Adodb.Stream")
            Stream.Type = 1 'adTypeBinary
            Stream.Open
            Stream.Write bytes
            Stream.Position = 0
            Stream.Type = 2 'adTypeText
            Stream.Charset = "iso-8859-1"
            BytesToStr = Stream.ReadText
            Stream.Close
        Set Stream = Nothing
    End Function
Function SendAlertEmail(content)
         'rID = Request.QueryString("id_r") 
        If rID & "" = "" Then
            Exit Function
        End iF
        If Application(rID&"_PrintFailCount") & "" = "" Then
                Application(rID&"_PrintFailCount") = 1
        Else 
                Application(rID&"_PrintFailCount") = CInt(Application(rID&"_PrintFailCount")) +  1
                If Cint(Application(rID&"_PrintFailCount")) >= 5  Then
                    If  Application(rID&"_LastSendMail") & "" <> "" Then
                        If DateAdd("n",5,CDate(Application(rID&"_LastSendMail"))) < now() Then
                            Application(rID&"_LastSendMail") = ""
                        End If
                    End If
                    'SendEmailV2 "Printer failed1","Now:" & Now() & " Last Sent:" & Application(rID&"_LastSendMail") & ". Print Count:" & Application(rID&"_PrintFailCount") , "danghai88@gmail.com"
                    If Application(rID&"_LastSendMail") = ""  Then
                        
                        Set objCon2 = Server.CreateObject("ADODB.Connection")
                        Set objRds2 = Server.CreateObject("ADODB.Recordset") 
                        objCon2.Open sConnString
                        objRds2.Open "SELECT *  FROM BusinessDetails  WHERE Id = " & rID, objCon2
                        
                        If Not objRds2.EOF Then
                            Dim RestaurantNotificationEmail
                            RestaurantNotificationEmail = objRds2("CONFIRMATION_EMAIL_ADDRESS")
                          
                            'SendEmailV2 "Printer failed3", "Last
                            SendEmailV2 "Star Printer Error", "Printer has failed to print.  Detail Information from the printer: " & content, RestaurantNotificationEmail
                            Application(rID&"_LastSendMail") = Now()
                            Application(rID&"_PrintFailCount") = 0
                        End If
                          objRds2.Close
                          objCon2.Close 
                        set objRds2 = nothing
                        set objCon2 = nothing
                    End If
                End If
        End If
End Function

Function PrintTextOrder(Oid, vRestaurantId) 
    Dim objCon, objRds
    Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 
    objCon.Open sConnString

    objRds.Open "SELECT * FROM BusinessDetails WHERE Id = " & vRestaurantId, objCon    
    vaveragedel = objRds("AverageDeliveryTime")
	vaveragecol = objRds("AverageCollectionTime")
    if Not IsNull(objRds("AverageDeliveryTime")) Then sAverageDeliveryTime = Cdbl(objRds("AverageDeliveryTime"))
    if Not IsNull(objRds("AverageCollectionTime")) Then sAverageCollectionTime = Cdbl(objRds("AverageCollectionTime"))   

        
	name=objRds("Name")
	address= objRds("Address") 
	telephone=objRds("telephone") 
	email=  objRds("email")       
        objRds.Close
        set objRds = nothing
        'objCon.Close       
        
        ' objCon.Open sConnString
        Set objRds = Server.CreateObject("ADODB.Recordset") 
        objRds.Open "select * from [Orders]  " & _
            "where Id = " & Oid, objCon
      dim vShippingFee
        dim vSubTotal
        dim vOrderTotal

        vShippingFee = objRds("ShippingFee")
        vSubTotal = objRds("SubTotal")
        vOrderTotal = objRds("OrderTotal")
    Dim Receipttext
    Receipttext =" Order " & Oid & " from " & name & vbCrLf & vbCrLf
    if objRds("PaymentType")="Stripe-Paid" or objRds("PaymentType")="Paypal-Paid" or objRds("PaymentType")="NoChex-Paid" or objRds("PaymentType")="Worldpay-Paid" or Ucase(objRds("Payment_status") & "")="PAID"  then  
         Receipttext = Receipttext & "   ORDER PAID "  & vbCrLf  & vbCrLf
    else
        Receipttext = Receipttext & "    ORDER UNPAID "  & vbCrLf  & vbCrLf
    end if
     Receipttext = Receipttext & name & vbCrLf 
    Receipttext = Receipttext & address & vbCrLf 
    Receipttext = Receipttext & "Tel. " & telephone & vbCrLf 
    Receipttext = Receipttext & "Email: " & email & vbCrLf 
    Receipttext = Receipttext & vbCrLf & vbCrLf  
    Receipttext = Receipttext & "Customer Details "  & vbCrLf
    Receipttext = Receipttext & "-----------------------------------" & vbCrLf  
    Receipttext = Receipttext &   objRds("FirstName") & " " &  objRds("LastName")   & vbCrLf 
    Receipttext = Receipttext &   objRds("Address") & " " &  objRds("PostalCode")    & vbCrLf 
    Receipttext = Receipttext &   objRds("Phone")   & vbCrLf      
    Receipttext = Receipttext &   objRds("Email")   & vbCrLf      
     If objRds("DeliveryLat") & "" <> "" Then
           Receipttext = Receipttext & "Lat/Long: " &  objRds("DeliveryLat") & "," & objRds("DeliveryLng")  & vbCrLf 
           Receipttext = Receipttext & "GPS: " & Latitude_DMS(objRds("DeliveryLat")) & " ," & Longitude_DMS(objRds("DeliveryLng"))  & vbCrLf 
     End If 
      Receipttext = Receipttext & vbCrLf  & vbCrLf  
    Receipttext = Receipttext & "Order Details "  & vbCrLf
    Receipttext = Receipttext & "-----------------------------------" & vbCrLf  
    Receipttext = Receipttext & "Order Number: " & Oid & vbCrLf
    Receipttext = Receipttext & "Order Time: " &FormatDateTime(objRds("orderdate"),2) & " " & FormatDateTime(objRds("orderdate"),4)   & vbCrLf
    If objRds("DeliveryType") = "d" Then
        Receipttext = Receipttext & "Order Type: Delivery"  & vbCrLf
    Else      
        Receipttext = Receipttext & "Order Type: Collection"  & vbCrLf
	End If

    if objRds("asaporder") = "n" then
        if objRds("DeliveryType") = "c" then
            Receipttext = Receipttext & "Requested for: " & DateAdd("n",vaveragecol,objRds("orderdate"))  & vbCrLf
        Else
            Receipttext = Receipttext & "Requested for: ASAP" & vbCrLf
        End If
    Else
        Receipttext = Receipttext & "Requested for: " & FormatDateTime(objRds("DeliveryTime"), 2)  & " " & FormatDateTime(objRds("DeliveryTime"), 4) & vbCrLf
    End If
				  
	if objRds("asaporder") = "n" then
        if objRds("DeliveryType") = "d" then
            mintoadd=vaveragedel + 5 ' Add + 5 to match with front end
        else
            mintoadd=vaveragecol + 5 ' Add + 5 to match with front end
        end if 
        Receipttext = Receipttext & " Accepted for: " &  DateAdd("n",mintoadd,objRds("orderdate"))  & vbCrLf
    End If
    if objRds("PaymentType")="Stripe-Paid" or objRds("PaymentType")="Paypal-Paid" or  objRds("PaymentType")="NoChex-Paid" or  objRds("PaymentType")="Worldpay-Paid" or Ucase(objRds("Payment_status") & "")="PAID"  then
        Receipttext = Receipttext & "Payment Status: ORDER PAID" & vbCrLf
    Else
        Receipttext = Receipttext & "Payment Status: ORDER UNPAID" & vbCrLf
    End If
  
    'Receipttext = Receipttext & notes=objRds("Notes")  & vbCrLf
    notes=objRds("Notes")
    objRds.Close
    set objRds = nothing
    'objCon.Close
     Receipttext = Receipttext & "-----------------------------------" & vbCrLf  
    'objCon.Open sConnString
    set objRds = Server.CreateObject("ADODB.Recordset")
    objRds.Open "select oi.*," & _
            "mi.Name, mip.Name as PropertyName, mi.PrintingName " & _
            "from ( OrderItems oi " & _
            "inner join MenuItems mi on oi.MenuItemId = mi.Id ) " & _
            "left join MenuItemProperties mip on oi.MenuItemPropertyId = mip.Id " & _
            "where oi.OrderId = " & Oid, objCon


     if objRds.Eof then
         Receipttext = Receipttext & "No Items In Your Order." & vbCrLf  
          objRds.Close()
    Set objRds = nothing
    Else 
        Do While NOT objRds.Eof
            Receipttext = Receipttext & vbCrLf &  objRds("Qta") & " X " & REplace( objRds("Name"),"<br/>",vbCrLf)
            If objRds("PrintingName") & "" <> "" Then
                Receipttext = Receipttext & vbCrLf  & objRds("PrintingName")
            End If
            Receipttext = Receipttext & "  " & objRds("PropertyName")
            
            If objRds("dishpropertiesids") <> "" Then
                dishpropertiessplit=split(objRds("dishpropertiesids"),",")
				for i=0 to ubound(dishpropertiessplit)
					
				    dishpropertiessplit2=split(dishpropertiessplit(i),"|")
					
				    Set objCon_dishpropertiesprice = Server.CreateObject("ADODB.Connection")
				    Set objRds_dishpropertiesprice = Server.CreateObject("ADODB.Recordset") 
				    objCon_dishpropertiesprice.Open sConnString
	                objRds_dishpropertiesprice.Open "SELECT MenuDishproperties.ID, MenuDishproperties.dishproperty, MenuDishproperties.dishpropertyprice, MenuDishpropertiesGroups.dishpropertypricetype, MenuDishpropertiesGroups.dishpropertygroup FROM MenuDishproperties INNER JOIN MenuDishpropertiesGroups ON MenuDishproperties.dishpropertygroupid = MenuDishpropertiesGroups.ID where (((MenuDishproperties.ID)=" & dishpropertiessplit2(1)  & "))", objCon
                    if not objRds_dishpropertiesprice.EOF then
					     Receipttext =   Receipttext & vbCrLf    &   objRds_dishpropertiesprice("dishpropertygroup") & ":" & objRds_dishpropertiesprice("dishproperty") & vbCrLf
                    end if
                 next
            End If
            toppingtext=""
			If objRds("toppingids") <> "" Then 
			    Set objCon_toppingids = Server.CreateObject("ADODB.Connection")
			    Set objRds_toppingids = Server.CreateObject("ADODB.Recordset") 
                objCon_toppingids.Open sConnString
                    Dim SQLTopping 
                    Dim toppinggroup : toppinggroup  =""
                        SQLTopping = "SELECT m.topping,isnull(mp.toppingsgroup,'') as toppingsgroup FROM MenuToppings m "
                        SQLTopping =SQLTopping & "  left join Menutoppingsgroups mp on  m.toppinggroupid = mp.ID"
                        SQLTopping =SQLTopping & "    where m.id in ("& objRds("toppingids") &")"
                objRds_toppingids.Open SQLTopping, objCon
			    Do While NOT objRds_toppingids.Eof 
				    toppingtext = toppingtext & objRds_toppingids("topping") & ", "
                    toppinggroup = objRds_toppingids("toppingsgroup")
				    objRds_toppingids.MoveNext
			    loop
			    if toppingtext<>"" then
                    if toppinggroup & "" = "" then
                        toppinggroup = "Toppings"
                    end if
				    toppingtext=left(toppingtext,len(toppingtext)-2)
			        Receipttext =   Receipttext & vbCrLf & toppinggroup & ": " & toppingtext
			    end if
			End If
           Receipttext =   Receipttext & CURRENCYSYMBOL & FormatNumber(objRds("Total"), 2) 
            objRds.MoveNext
        Loop
         objRds.Close()
    Set objRds = nothing
    End If
   
    objCon.Close()
    Set objCon = nothing
    Receipttext =   Receipttext & vbCrLf  & vbCrLf
    Receipttext =   Receipttext & "SubTotal: " &   FormatNumber(vSubTotal, 2) & vbCrLf
    Receipttext =   Receipttext & "Delivery Fee: "   & FormatNumber(vShippingFee, 2) & vbCrLf    
    Receipttext =   Receipttext & "Total: "   & FormatNumber(vOrderTotal, 2) & vbCrLf
     If notes <> "" Then
        Receipttext =   Receipttext & vbCrLf & "Special instructions: "  & vbCrLf & notes
    End If
   
    PrintTextOrder = Receipttext
End Function

        Function Latitude_DMS (Lat)
      n = Sgn(Lat)
     ' sign = Trim(Mid("-  ", n + 2, 1))
    '  sign = Trim(Mid("- +", n + 2, 1))
      sign = Trim(Mid("S N", n + 2, 1))
      s = Abs(Lat) * 3600
      s = Int(s * 10000 + 0.5) / 10000
      m = Int(s / 60)
      d = Int(m / 60)
      m = m - d * 60
      s = s - m * 60 - d * 3600
      s = Int(s * 100  + 0.5) / 100
    'For leading - and/or + (adjust sign setting above)
      Latitude_DMS =   CStr(d) & "&deg;" & _
        CStr(m) & Chr(39) & Chr(32) & CStr(s) & Chr(34) & Chr(32) & sign
    'For trailing cardinal letter (adjust sign setting above)
    '  Latitude_DMS = CStr(d) & Chr(176) & Chr(32) & _
    '    CStr(m) & Chr(39) & Chr(32) & CStr(s) & Chr(34) & Chr(32) & sign
    End Function

    Function Longitude_DMS(Lng)
      n = Sgn(Lng)
     ' sign = LTrim(Mid("-  ", n + 2, 1))
    '  sign = LTrim(Mid("- +", n + 2, 1))
      sign = LTrim(Mid("W E", n + 2, 1))
      s = Abs(Lng) * 3600
      s = Int(s * 10000 + 0.5) / 10000
      m = Int(s / 60)
      d = Int(m / 60)
      m = m - d * 60
      s = s - m * 60 - d * 3600
      s = Int(s * 100  + 0.5) / 100
    'For leading - and/or + (adjust sign setting above)
      Longitude_DMS = CStr(d) & "&deg;" & _
        CStr(m) & Chr(39) & Chr(32) & CStr(s) & Chr(34) & Chr(32) & sign
    'For trailing cardinal letter (adjust sign setting above)
    '  Longitude_DMS = CStr(d) & Chr(176) & Chr(32) & _
    '    CStr(m) & Chr(39) & Chr(32) & CStr(s) & Chr(34) & Chr(32) & sign
    End Function 


     %>