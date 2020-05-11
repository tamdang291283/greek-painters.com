<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../../Config.asp" -->
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
            If Instr(f.Name,rID&"-") = 1 AND  Instr(f.Name,"-PN") > 0 Then
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
                If Instr(f.Name,rID&"-") = 1   AND  Instr(f.Name,"-PN") > 0 Then
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
            If Instr(f.Name,rID&"-") = 1  AND  Instr(f.Name,"-PN") > 0 Then
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
                If Instr(f.Name,rID&"-") = 1  AND  Instr(f.Name,"-PN") > 0 Then
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
                If Instr(f.Name,rID&"-") > 0  AND  Instr(f.Name,"-PN") > 0 Then
                    isPrinting = true
                    printingName = f.Name
                    Exit For
                End If 
            Next
            If printingName & "" <> "" Then
                Dim tOid
                tOid = Replace(printingName,rID&"-","")
                tOid = Replace(tOid,".png","")
                tOid = Replace(tOid,".txt","")
                   
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
     
     Function WriteLog(logFilePath, logContent)
        Dim logobjFSO, logFile
        set logobjFSO = CreateObject("Scripting.FileSystemObject")
        set logFile = logobjFSO.OpenTextFile(logFilePath,8,true) ' 8 is for appending
        logFile.WriteLine(now() & ": " & logContent)
        set logFile = nothing
        set logobjFSO = nothing
    End Function
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
                            objRds2.Close
                            objCon2.Close 
                            'SendEmailV2 "Printer failed3", "Last
                            SendEmailV2 "Star Printer Error", "Printer has failed to print.  Detail Information from the printer: " & content, RestaurantNotificationEmail
                            Application(rID&"_LastSendMail") = Now()
                            Application(rID&"_PrintFailCount") = 0
                        End If
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
        if  objRds("deliverydelay") & "" <> "" then
                vaveragedel = cint(objRds("deliverydelay"))
        end if
        if  objRds("collectiondelay") & "" <> "" then
                vaveragecol = cint(objRds("collectiondelay"))
        end if
        vShippingFee = objRds("ShippingFee")
        vSubTotal = objRds("SubTotal")
        vOrderTotal = objRds("OrderTotal")
    Dim Receipttext
    Receipttext =" Order " & Oid & " from " & name & vbCrLf & vbCrLf
    if  objRds("PaymentType")="Paypal-Paid" or objRds("PaymentType")="NoChex-Paid" or objRds("PaymentType")="Worldpay-Paid" or Ucase(objRds("Payment_status") & "")="PAID"  then  
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
    if  objRds("PaymentType")="Paypal-Paid" or  objRds("PaymentType")="NoChex-Paid" or  objRds("PaymentType")="Worldpay-Paid" or Ucase(objRds("Payment_status") & "")="PAID"  then
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
   ' objCon.Open sConnString
    set objRds = Server.CreateObject("ADODB.Recordset")
    objRds.Open "select oi.*," & _
            "mi.Name, mip.Name as PropertyName, mi.PrintingName " & _
            "from ( OrderItems oi " & _
            "inner join MenuItems mi on oi.MenuItemId = mi.Id ) " & _
            "left join MenuItemProperties mip on oi.MenuItemPropertyId = mip.Id " & _
            "where oi.OrderId = " & Oid, objCon


     if objRds.Eof then
         Receipttext = Receipttext & "No Items In Your Order." & vbCrLf  
         objRds.close()
         set objRds = nothing
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
				    Set objRds_dishpropertiesprice = Server.CreateObject("ADODB.Recordset") 
	                objRds_dishpropertiesprice.Open "SELECT MenuDishproperties.ID, MenuDishproperties.dishproperty, MenuDishproperties.dishpropertyprice, MenuDishpropertiesGroups.dishpropertypricetype, MenuDishpropertiesGroups.dishpropertygroup FROM MenuDishproperties INNER JOIN MenuDishpropertiesGroups ON MenuDishproperties.dishpropertygroupid = MenuDishpropertiesGroups.ID where (((MenuDishproperties.ID)=" & dishpropertiessplit2(1)  & "))", objCon
                    if not objRds_dishpropertiesprice.EOF then
					     Receipttext =   Receipttext & vbCrLf    &   objRds_dishpropertiesprice("dishpropertygroup") & ":" & objRds_dishpropertiesprice("dishproperty") & vbCrLf
                    end if
                    objRds_dishpropertiesprice.close()
                    set objRds_dishpropertiesprice = nothing
                 next
            End If
            toppingtext=""
			If objRds("toppingids") <> "" Then 
			    
			   
                Dim SQLTopping 
                Dim toppinggroup : toppinggroup  =""
                 Set objRds_toppingids_group = Server.CreateObject("ADODB.Recordset")     
                dim SQLtopping : SQLtopping = "" 
                SQLtopping = "select top 1 ID, toppingsgroup,printingname  from Menutoppingsgroups  where id in (select toppinggroupid from menutoppings where id  in (" & objRds("toppingids")& ")  ) "
                objRds_toppingids_group.Open SQLtopping, objCon_toppingids                            
                while not objRds_toppingids_group.EOF
                        toppingGroup = objRds_toppingids_group("toppingsgroup")
                        toppingtext = ""
                        'if  namePrintingMode & "" = "printingname" and objRds_toppingids_group("printingname") & "" <> ""  then
                        '    toppingGroup =   objRds_toppingids_group("printingname") 
                        'end if
                        Set objRds_toppingids = Server.CreateObject("ADODB.Recordset")   
                            SQLTopping = "SELECT m.topping,isnull(mp.toppingsgroup,'') as toppingsgroup FROM MenuToppings m "
                            SQLTopping =SQLTopping & "  left join Menutoppingsgroups mp on  m.toppinggroupid = mp.ID"
                            SQLTopping =SQLTopping & "    where m.id in ("& objRds("toppingids") &") and   m.toppinggroupid ="  & objRds_toppingids_group("ID")
                        objRds_toppingids.Open SQLTopping , objCon
			            Do While NOT objRds_toppingids.Eof 
				            toppingtext = toppingtext & objRds_toppingids("topping") & ", "
                           ' toppinggroup = objRds_toppingids("toppingsgroup")
				            objRds_toppingids.MoveNext
			            loop
                            objRds_toppingids.close()
                        set objRds_toppingids = nothing
			            if toppingtext<>"" then
                             if toppinggroup & "" = "" then
                                toppinggroup = "Toppings"
                             end if
				            toppingtext=left(toppingtext,len(toppingtext)-2)
			                Receipttext =   Receipttext & vbCrLf & toppinggroup & ": " & toppingtext
			            end if
                        objRds_toppingids_group.movenext()
                wend
                objRds_toppingids_group.close()
                set objRds_toppingids_group = nothing
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
    Receipttext =   Receipttext & "SubTotal: " & CURRENCYSYMBOL &  FormatNumber(vSubTotal, 2) & vbCrLf
    Receipttext =   Receipttext & "Delivery Fee: " & CURRENCYSYMBOL & FormatNumber(vShippingFee, 2) & vbCrLf    
    Receipttext =   Receipttext & "Total: " & CURRENCYSYMBOL & FormatNumber(vOrderTotal, 2) & vbCrLf
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