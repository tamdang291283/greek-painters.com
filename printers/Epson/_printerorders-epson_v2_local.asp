<!-- #include file="../../Config.asp" -->
<%
 
    session("restaurantid")=Request.QueryString("id_r")
     WriteLog Server.MapPath("EpsonPostTextV2.txt"),"Local StoreID[" &session("restaurantid")& "]  " 
     %>

<!-- #include file="../../timezone.asp" -->
<!-- #include file="../../restaurantsettings.asp" -->
<%
     dim newWay : newWay = false
       if printingtype = "text" then
            newWay = true
       end if
    if newWay = false then
        Response.End
    end if
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

     function GetContentPrint(byval OrderID, byval resid, byval isDualPrint,byval printername,byval index)
                dim s_ContentBatchReceipt : s_ContentBatchReceipt = ""
                oId = OrderID
                rId =resid
                dim FileModListArr : FileModListArr = split(FileModList,",")
                dim FileMod : FileMod = ""
                dim FileModList 
                dim jobid : jobid = resid & "-order-" & OrderID  & "order-" & index 
                if instr(printername ,"PN") > 0 and isDualPrint = false then
                    s_ContentBatchReceipt = ""
                else 
                    dim iQuery                                         
                    dim s_filenameEPSON                                               
                    if  instr(printername ,"PN") > 0  then
                        FileMod = "-PN"
                    else
                        FileMod = "-EN"                
                    end if 
                    If FileMod = "-PN"  Then                                                                                        
                        s_filenameEPSON = rId & "-" & oId & "-" & Replace(printername,"PN:","") & "-" & i & FileMod 
                            iQuery = "TempPOID=" &  oId & "&id_r=" & rId & "&PrintJobId=" & s_filenameEPSON
                            s_ContentBatchReceipt = PostRequestURL(replace(SITE_URL,"https","http") & "printers/epson/orders-epson_item_local.asp" ,iQuery)
                    ElseIf  FileMod = "-EN"  Then
                            FileMod = ""                                                   
                            s_filenameEPSON =  rId & "-" & oId & "-" & printername& "-" & i  & FileMod 
                            iQuery = "TempPOID=" &  oId & "&id_r=" & rId & "&PrintJobId=" & s_filenameEPSON                                                      
                            s_ContentBatchReceipt =  PostRequestURL(replace(SITE_URL,"https","http") & "printers/epson/orders-epson_item_local.asp" ,iQuery)                                                        
                    End If
                end if
                dim xmlprinter : xmlprinter = ""
                if s_ContentBatchReceipt <> "" then
                        xmlprinter = "<ePOSPrint>"
                        xmlprinter =xmlprinter & "<Parameter>"
                        xmlprinter =xmlprinter & "<devid>" & Replace(printername,"PN:","")  & "</devid>"
                        xmlprinter =xmlprinter & "<timeout>10000</timeout>"    
                        xmlprinter =xmlprinter & "<printjobid>" & jobid & "</printjobid>"
                        xmlprinter =xmlprinter & "</Parameter>"
                        xmlprinter =xmlprinter & "<PrintData>"                                
                        xmlprinter =xmlprinter & "<epos-print xmlns=""http://www.epson-pos.com/schemas/2011/03/epos-print"">"
                        xmlprinter =xmlprinter &  s_ContentBatchReceipt    
                        xmlprinter =xmlprinter & "</epos-print>"
                        xmlprinter =xmlprinter & "</PrintData>"
                        xmlprinter =xmlprinter & "</ePOSPrint>"
                end if
            GetContentPrint = xmlprinter
    end function

    function PostRequestURL(byval URL, byval iQuery)
        'Response.Write(URL & "?" & iQuery)
      '  Response.End
        dim sContent 
        set objHttp = Server.CreateObject("Microsoft.XMLHTTP")
        objHttp.open "POST", URL & "?" & iQuery, false
        objHttp.setRequestHeader "Content-type", "application/x-www-form-urlencoded"
        objHttp.Send ""
        if objHttp.status <> 200  then
           sContent =  "HTTP ERROR " & objHttp.status
        elseif  instr( objHttp.responseText,"TOTAL") > 0  then
            sContent = objHttp.responseText
        end if
        set objHttp = nothing
        PostRequestURL = sContent
    end function
        Dim objCon2,objRds2,SQL
        Set objCon2 = Server.CreateObject("ADODB.Connection")
        Set objRds2 = Server.CreateObject("ADODB.Recordset") 
            objCon2.Open sConnString

         If Request.Form & "" <> "" AND  request.form("ConnectionType") <> "GetRequest" Then
                'WriteLog Server.MapPath("EpsonPostTextLocalV2.txt"),Request.Form            
            End If
        dim checkstatus :  checkstatus = true      
             if request.form("ConnectionType")="SetResponse" and checkstatus = true then        
                Dim ResponseContent
                    ResponseContent=request.form("ResponseFile")   
                   ' WriteLog Server.MapPath("EpsonPostTextV2.txt"),ResponseContent
                    Dim tXMLDoc, joborderid , isprinted
                      isprinted = false
                        dim arreopepson : arreopepson = split(ResponseContent,"</ePOSPrint>")
                        dim indexrespo : indexrespo = 0
                        for  indexrespo = 0 to ubound(arreopepson)
                             if instr(arreopepson(indexrespo),"success=""true""") > 0 and instr(arreopepson(indexrespo),"local_printer") > 0 then
                                  isprinted =  true  
                             end if
                        next
                   If InStr(ResponseContent,"success=""true""") > 1 Then 
                      ' isprinted =  true
                       joborderid =  split(ResponseContent,"order-")(1)
                   end if 
                     If isprinted =  true and joborderid & "" <> "" and IsNumeric(joborderid&"") Then                       
                        objCon2.execute("Update Orderslocal set printed = 1 where ID = " & joborderid)
                    end if  
            end if

        dim   DateCondition : DateCondition = FormatDateTime(DateAdd("h",houroffset,now))
          WriteLog Server.MapPath("EpsonPostTextV2.txt"),"Local StoreID[" &session("restaurantid")& "] DateCondition "   & DateCondition
            dim datet : datet = split( DateCondition ," ")(0)
            dim datetime : datetime = ""
                if  ubound(split( DateCondition ," ")) > 0 then
                    datetime =" " &  split( DateCondition ," ")(1)
                end if
             if ubound(split(datet,"/")) > 1 then
                DateCondition = split(datet,"/")(1) & "/" & split(datet,"/")(0) & "/" & split(datet,"/")(2)  & datetime
            end if
            
           ' DateCondition = cdate(DateAdd("h",houroffset,now))
        SQL  = "Select top 1 ID from view_paid_orderslocal where  IdBusinessDetail ="  & Request.QueryString("id_r")  &  "  "
        
		SQL = SQL & "  and   ( printed = 0 )  order by orderdate " 

        objRds2.Open SQL, objCon2
         Dim isDualPrint
            isDualPrint = false

            If LCase(IsDualReceiptPrinting & "") = "1" Then 
                isDualPrint = true
            End If
        PrinterIDList = InRestaurantEpsonPrinterIdList & ""
        if not objRds2.EOF then
                SQL =  "select oi.*," & _
                    "mi.Name, mip.Name as PropertyName ,  mi.PrintingName " & _
                    "from ( OrderItems oi " & _
                    "inner join MenuItems mi on oi.MenuItemId = mi.Id ) " & _
                    "left join MenuItemProperties mip on oi.MenuItemPropertyId = mip.Id " & _
                    "where oi.OrderId = " & objRds2("ID")
                 dim objRds3 :   Set objRds3 = Server.CreateObject("ADODB.Recordset") 
                 objRds3.Open SQL, objCon2
                
                 Do While NOT objRds3.Eof
                    If objRds3("PrintingName") & "" = "" Then
                        isDualPrint = false
                    End If                    
                    objRds3.MoveNext   
                Loop
                    objRds3.close()
                set objRds3 = nothing
                 if PrinterIDList ="" then
                    PrinterIDList = "local_printer"
                end if
                 oId = objRds2("ID")
                 rId = Request.QueryString("id_r")
                dim s_ContentBatchReceipt : s_ContentBatchReceipt = ""
                   
                if PrinterIDList & "" <> "" then
                    dim arrPrinterIDList : arrPrinterIDList = split( PrinterIDList,";")
                    dim index : index = 0
                    for index = 0 to ubound(arrPrinterIDList)
                        s_ContentBatchReceipt = s_ContentBatchReceipt & GetContentPrint(oId,rId,isDualPrint,arrPrinterIDList(index),index)
                    next
                end if 
                                if s_ContentBatchReceipt <> "" then
                                    if instr(s_ContentBatchReceipt,"ERROR") > 0 then
                                        s_ContentBatchReceipt = "<text>ORDERID " &oId& " printed error &#10;&#10;</text>"
                                    end if
                                    Response.Clear()
                                    Response.Clear()
                                    Response.Write("<?xml version=""1.0"" encoding=""utf-8""?>")
                                    Response.Write("<PrintRequestInfo Version=""2.00"">")
                                    Response.Write(s_ContentBatchReceipt)
                                    Response.Write("</PrintRequestInfo>")
                                    Response.Flush()
                                    if checkstatus = false  then
                                        objCon2.execute("Update Orderslocal set printed = 1 where ID = " & oId)
                                    end if
                                end if
        end if
            objRds2.close()
            set objRds2 = nothing
            objCon2.close()
        set objCon2 = nothing
%>