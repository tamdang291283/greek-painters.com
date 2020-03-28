<%
    Dim OrderResID : OrderResID = Request.QueryString("id_o")

    if Request.QueryString("id_r") & "" <>"" then 
        session("restaurantid") =  Request.QueryString("id_r")
    elseIf session("restaurantid") & "" = "" AND Session("ResID") & ""  <> "" Then
        session("restaurantid")= Session("ResID") 
   
    End If
    if Session("OrderID") & "" <> "" and  Session("OrderID") & "" <> "0"  then
        OrderResID = Session("OrderID") 
    end if
    
  
     If ( session("vOrderId")  & "" = "" AND OrderResID & "" <> "" ) OR Request.QueryString("isPrint") & "" = "Y" Then
        session("vOrderId")= OrderResID
   
    End If
    
     %>

<!-- #include file="Config.asp" -->

<!-- #include file="timezone.asp" -->

<!-- #include file="restaurantsettings.asp" -->

<!DOCTYPE html>
<html lang="en">
<%
                                                
    function isCreate(byval orderid, byval receiptbyname,byval s_type,byval resid )
            dim objCon1, result
            result = false
            Set objCon1 = Server.CreateObject("ADODB.Connection")
            objCon1.Open sConnString

            dim   DateCondition : DateCondition = cdate(DateAdd("h",houroffset,now))
                DateCondition = DatePart("m", DateCondition)&"/"&DatePart("d", DateCondition)&_
                               "/"&DatePart("yyyy", DateCondition)&" "&DatePart("h", DateCondition)&":"&_
                               DatePart("n", DateCondition)&":" & DatePart("s", DateCondition)

            dim RS_Order : set RS_Order  = Server.CreateObject("ADODB.Recordset")
            dim SQLCheck 
                 SQLCheck = "select orderid from [Order_Receipt_tracking]  where orderid = " & orderid & " and s_filename='" & receiptbyname & "' and s_printtype='" &s_type& "' and IdBusinessDetail = " & resid 
           
                RS_Order.Open SQLCheck , objCon1, 1, 3 
                if not RS_Order.eof then
                    result =  true
                end if
                RS_Order.close()
                set RS_Order = nothing
              WriteLog Server.MapPath("EpsonPostImageAndPrint.txt"),"PageName = thanks.asp = " & orderid & " receiptbyname " & receiptbyname & " isCreate 1 " &  result
              if result = false then
                set RS_Order  = Server.CreateObject("ADODB.Recordset") 
                
                SQLCheck = "select ID from orders where IdBusinessDetail=" & resid & " and ID = "& orderid & "  and DateDiff(day,Orderdate ,'" &DateCondition& "')   <= 1 "
               
                RS_Order.Open SQLCheck , objCon1, 1, 3 
                    if RS_Order.EOF then
                        result =  true
                        WriteLog Server.MapPath("EpsonPostImageAndPrint.txt"),"PageName = thanks.asp = " & orderid  & " receiptbyname " & receiptbyname &  " isCreate 2 " &  result
                    end if 
                RS_Order.close()
                set RS_Order = nothing
              end if
       
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


if CStr(session("vOrderId"))<>CStr(OrderResID) or session("vOrderId")=""  then
      
response.redirect(SITE_URL & "error.asp")
end if
   
    
%>

<% 
    WriteLog Server.MapPath("receiptpage.txt"),"PageName  = Thanks.asp Start Page [Orderid] " & OrderResID
    Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 

    objCon.Open sConnString

     dim MenuURL
        MenuURL = SITE_URL & "menu.asp?id_r=" & session("restaurantid")

    if session("restaurantid") & "" <> "" then
           dim rs_url :  set rs_url = Server.CreateObject("ADODB.Recordset")        
               rs_url.open  "SELECT FromLink FROM URL_REWRITE a inner join BusinessDetails b on (a.RestaurantID=b.ID )  where RestaurantID=" & session("restaurantid") & " and EnableUrlRewrite = 'Yes' and status = 'ACTIVE' "  ,objCon
            while not rs_url.eof 
               
               if instr(lcase(rs_url("FromLink")),"/menu") > 0 then
                     MenuURL = rs_url("FromLink")             
               end if 
               rs_url.movenext()
           wend
            rs_url.close()
        set rs_url =  nothing
        if instr( lcase(SITE_URL) ,"https://") then
            MenuURL  = replace(MenuURL,"http://","https://")    
         
         end if  
    end if

    objRds.Open "SELECT * FROM BusinessDetails WHERE Id = " & session("restaurantid"), objCon       
	backtohometext=objRds("backtohometext")
	bringgtracking=objRds("bringg")
	bringgurl=objRds("bringgurl")
	
	googleecommercetracking=objRds("googleecommercetracking")
	googleecommercetrackingcode=objRds("googleecommercetrackingcode")
%>

<head>
  <meta charset="utf-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">

	<!--link rel="stylesheet/less" href="less/bootstrap.less" type="text/css" /-->
	<!--link rel="stylesheet/less" href="less/responsive.less" type="text/css" /-->
	<!--script src="Scripts/less-1.3.3.min.js"></script-->
	<!--append ‘#!watch’ to the browser URL, then refresh the page. -->
	
	<link href="<%=SITE_URL %>css/bootstrap.min.css" rel="stylesheet">
	<link href="<%=SITE_URL %>css/style.css" rel="stylesheet">
	<link href="<%=SITE_URL %>css/datepicker.css" rel="stylesheet">

  <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
    <script src="Scripts/html5shiv.js"></script>
  <![endif]-->

  <!-- Fav and touch icons -->
 <% If FAVICONURL & "" <> "" Then %> <link rel='shortcut icon' href='<%=FAVICONURL %>' type='image/x-icon'/ > <% end If %>
  
	<script type="text/javascript" src="<%=SITE_URL %>Scripts/jquery.min.js"></script>
	<script type="text/javascript" src="<%=SITE_URL %>Scripts/js.cookie.js"></script>
	<script type="text/javascript" src="<%=SITE_URL %>Scripts/bootstrap.min.js"></script>
	<script type="text/javascript" src="<%=SITE_URL %>Scripts/scripts.js"></script>
	
    <script src="<%=SITE_URL %>Scripts/jquery.validate.min.js" type="text/javascript"></script>

    <script src="<%=SITE_URL %>Scripts/bootstrap-datepicker.js" type="text/javascript"></script>
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=<%= GMAP_API_KEY %>&sensor=false"></script>
	
	<script>
$.cookie("Specialinput", ""); 
</script>
	 <style type="text/css">
        small.error 
        {
            display: inline;    
            color: #B94A48; 
        }
		#wholepage {
padding-top:0px !important;
}
    </style>
   
    <style>body{overflow:hidden;}#preloader{position:fixed;top:0;left:0;right:0;bottom:0;background-color:#000;z-index:99;}#status{width:200px;height:200px;position:absolute;left:50%;top:50%;background-image:url(<%=objRds("imgURL") %>);background-repeat:no-repeat;background-position:center;margin:-100px 0 0 -100px;}</style>

</head>
<body>
<%
    objRds.Close
             set objRds = nothing
      voucherused=""
voucherusedtype=""
'Set objCon = Server.CreateObject("ADODB.Connection")
Set objRds = Server.CreateObject("ADODB.Recordset") 
'objCon.Open sConnString
objRds.Open "SELECT * FROM orders WHERE Id = " & OrderResID, objCon     
if  objRds.BOF then
   
    objRds.Close
     set objRds = nothing
     objCon.close()
    set objCon = nothing
    ' Response.Write(MenuURL)
  '  Response.End 
   %>
     <p style="text-align:center;font-weight:bold;font-size:16px;">Sorry, I could not find that order</p>
     </body>
    </html>
    <%
  
    'Response.Redirect(MenuURL)
  Response.End
end if  

     %>
   <div id="preloader">
<div id="status">&nbsp;</div>
</div>

<div class="container" id="wholepage" style="padding-bottom:100px;">
  <div class="container">
		 <%            
             
voucherused=objRds("vouchercode")   
    
 If LCase(SMSEnable&"")  = "1" AND Lcase(SMSOnOrder&"") = "1" AND objRds("Phone") & "" <> "" AND SMSOnOrderContent & "" <> "" Then
    
    Dim SendDate
    SendDate = DateAdd("h",houroffsetreal,now)
    If SMSOnOrderAfterMin & ""<> "" Then
        SendDate = DateAdd("n",SMSOnOrderAfterMin,SendDate)
    End If

   'Response.End()
    Dim ActualPhoneNumber
    ActualPhoneNumber = ""

    If objRds("Phone") & "" <> "" Then
        ActualPhoneNumber = objRds("Phone")
         If Left(ActualPhoneNumber,Len(DefaultSMSCountryCode)) = DefaultSMSCountryCode And Len(ActualPhoneNumber) > 1 Then
            ActualPhoneNumber = Right(ActualPhoneNumber,Len(ActualPhoneNumber) - Len(DefaultSMSCountryCode))
        End If
        If Left(ActualPhoneNumber,1) = "0" And Len(ActualPhoneNumber) > 1 Then
            ActualPhoneNumber = Right(ActualPhoneNumber,Len(ActualPhoneNumber) - 1)
        End If
    
    End If
    ActualPhoneNumber = DefaultSMSCountryCode & ActualPhoneNumber
    InsertSMSToQueue ActualPhoneNumber, SMSOnOrderContent, SendDate, session("restaurantid")
End If
     

    objRds.Close
    set objRds = nothing
'objCon.Close
if voucherused<>"" then

'Set objCon = Server.CreateObject("ADODB.Connection")
Set objRds = Server.CreateObject("ADODB.Recordset") 
'objCon.Open sConnString
objRds.Open "SELECT * FROM vouchercodes WHERE IdBusinessDetail=" & session("restaurantid") & " and vouchercode = '" & voucherused & "'", objCon 
if not  objRds.EOF then 
voucherusedtype=objRds("vouchertype")   
end if
objRds.Close
set objRds = nothing
'objCon.Close
end if

if voucherusedtype="once" then


'Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 
mySQL="DELETE from vouchercodes  WHERE IdBusinessDetail=" & session("restaurantid") & " and vouchercode = '" & voucherused & "'"
'Set Conn = Server.CreateObject("ADODB.Connection")
'Conn.Open(sConnString)
objCon.Execute(mySQL)
'Conn.Close


end if
    Dim isDualPrint
    isDualPrint = false

    If LCase(IsDualReceiptPrinting & "") = "1" Then 
        isDualPrint = true
    End If
    objCon.close()  
    set objCon = nothing
   
%>     
     
    <!-- #include file="Receipt.asp" -->

 
	
</div>

<div align="center"><br>
<br>
</div>

<div align="center">  Please check your email for confirmation of your order, including potential delivery time changes
  <br />
<br />
<%
     
    Set objCon = Server.CreateObject("ADODB.Connection")
    objCon.Open(sConnString)
    if backtohometext<>"" then
response.write backtohometext
else%>  
<a style="display:none;" href="<%=MenuURL %>">Click here to return to the homepage</a>
<a href="<%=MenuURL %>"  class="btn btn-primary" style="width: 280px; padding: 8px"><span class="
glyphicon glyphicon-chevron-left" aria-hidden="true"></span> Click here to return to the homepage</a>
<%end if%>

<br>
  <br></div>
  <script>

      function deleteAllCookies() {
    var cookies = document.cookie.split(";");

    for (var i = 0; i < cookies.length; i++) {
    	var cookie = cookies[i];
    	var eqPos = cookie.indexOf("=");
    	var name = eqPos > -1 ? cookie.substr(0, eqPos) : cookie;
    	 setCookie(name, "", -1000);
      //document.cookie = name + "=;expires=Thu, 01 Jan 1970 00:00:01 GMT";
    }
}
      
    function setCookie(cname, cvalue, exmins) {
        var d = new Date();
        d.setTime(d.getTime() + (exmins*60*1000));
        var expires = "expires="+ d.toGMTString();
        document.cookie = encodeURIComponent(cname) + "=" + encodeURIComponent(cvalue) + "; " + expires + ";  path=/";
    }
    setCookie("orderTypePicker","",-10);
    setCookie("p_hour","",-10);
       setCookie("p_minute","",-10);
      deleteAllCookies() ;
  </script>

<%if googleecommercetracking="Yes" AND UCase(Request.QueryString("isPrint")) <> "Y" then%>
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

  ga('create', '<%=googleecommercetrackingcode%>', 'auto');
  ga('send', 'pageview');
  ga('require', 'ecommerce');
  
ga('ecommerce:addTransaction', {
  'id': '<%=Request.QueryString("id_o")%>',                     // Transaction ID. Required.
  'affiliation': '<%=vdeliverytype%>',   // Affiliation or store name.
  'revenue': '<%=FormatNumber(vOrderTotal, 2)%>',               // Grand Total.
  'shipping': '<%=FormatNumber(vShippingFee, 2)%>'                  // Shipping.

});

<%=analyticsitems%>

ga('ecommerce:send');

</script>
<%end if%>

<%
     
    if bringgtracking="Yes" and vdeliverytype="delivery" AND UCase(Request.QueryString("isPrint")) <> "Y"  then
set xmlhttp = CreateObject("MSXML2.ServerXMLHTTP") 
xmlhttp.open "POST", bringgurl, false 
xmlhttp.setRequestHeader "Content-type","application/json"
xmlhttp.setRequestHeader "Accept","application/json"
xmlhttp.send bringg
'response.write bringg
vAnswer = xmlhttp.responseText  
'   Response.Write("<br />Bringg:"& vAnswer)
end if%>
  <% 
   
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
        WriteLog Server.MapPath("EpsonPostImageAndPrint.txt"),"PageName = pintXML_v2.xml RecreateByIE  " & buildURL
        Set WshShell = CreateObject("WScript.Shell")
            'Return = WshShell.Run("iexplore.exe http://my.outsource.com/test/serverbrowse/write-file.asp", 1)
      
        Return = WshShell.Run("iexplore.exe " & buildURL, 1)    
      
         for m=1 to 1000
                        For i = 1 To 20000
                        next
              next   
        Set WshShell = nothing
         WriteLog Server.MapPath("EpsonPostImageAndPrint.txt"),"PageName = pintXML_v2.xml End  RecreateByIE  OrderID = " & orderid
    end sub
  
     sub WriteReceiptPlaintext(byval filename,content)          
            dim fs,f
            set fs=Server.CreateObject("Scripting.FileSystemObject") 
          
            set f=fs.OpenTextFile(server.MapPath(RootDefaultPath & "\printers\Epson\ReceiptImage\" & filename),8,true)
                f.Write( "")
                'f.Write(content)       
                f.close
            set f=nothing
            set fs=nothing
        end sub

Function ReplaceSpecialCharacter(sInput)
    Dim sOutput
    sOutput = Replace(sInput,"&","&amp;")
    sOutput = Replace(sOutput,"<","&lt;")
    sOutput = Replace(sOutput,">","&gt;")
    sOutput = Replace(sOutput,"'","&apos;")
    sOutput = Replace(sOutput,"""","&quot;")
    ReplaceSpecialCharacter = sOutput
End Function 
 

sub CreateReceiptByPlainText(byval OrderID,byval RestID,byval s_finame)       

                call WriteReceiptPlaintext(s_finame,"")
      

end sub


  sub ReCreateReceipt(byval strmod,byval orderid, byval resid, byval rootpath,byval RePrintReceiptWays,byval Conn,byval PrinterIDList )
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
            ' WriteLog Server.MapPath("StarPrinter.txt"),split(batfilepath,":")(0) & ":"
            '  WriteLog Server.MapPath("StarPrinter.txt"),"cd "  & Server.MapPath(rootpath)
            WriteLogBat batfilepath,split(batfilepath,":")(0) & ":"
            WriteLogBat batfilepath,"cd "  & Server.MapPath(rootpath)
            if  UCase(SEND_ORDERS_TO_PRINTER) = "STAR" then
                 WriteLogBat batfilepath,"phantomjs "& Server.MapPath(rootpath) &"\exe.js " & SITE_URL & "printers/star/print_t.asp " & strmod & " " & orderid & " " & resid & " " & "N" & " " &  PrinterIDList
                 WriteLog Server.MapPath("StarPrinter.txt"),"phantomjs "& Server.MapPath(rootpath) &"\exe.js " & SITE_URL & "printers/star/print_t.asp " & strmod & " " & orderid & " " & resid & " " & "N" & " " &  PrinterIDList
            else 
                WriteLogBat batfilepath,"phantomjs "& Server.MapPath(rootpath) &"\exe.js " & SITE_URL & "printers/epson/print_t.asp " & strmod & " " & orderid & " " & resid  & " " & "N" & " " &  PrinterIDList
            end if
         
            WriteLog Server.MapPath("EpsonPostImageAndPrint.txt"),"PageName = pintXML_v2.xml ReCreateReceipt  ORDER =  " & orderid 
            Dim WshShell 
            Set WshShell = CreateObject("WScript.Shell") 
            'dim objFSO : objFSO = Set objFSO=CreateObject("Scripting.FileSystemObject")
              WriteLog Server.MapPath("EpsonPostImageAndPrint.txt"),"PageName = pintXML_v2.xml ReCreateReceipt  END Order = " & orderid & " batfilepath = " & batfilepath 
               WshShell.Run batfilepath 
             for m=1 to 1000
                        For i = 1 To 20000
                        next
              next
             if objFSOPT.FileExists(batfilepath) then
                objFSOPT.DeleteFile batfilepath, true
             end if
            set WshShell = nothing
            'WshShell =  nothing
            set objFSOPT = nothing 
        ' End
         WriteLog Server.MapPath("EpsonPostImageAndPrint.txt"),"PageName = pintXML_v2.xml ReCreateReceipt  END Order = " & orderid
     '   On Error GoTo 0
    end sub
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
                        else
                          objRds1("s_printstatus") = "created"
                        end if
                        
                        objRds1.Update 
                        objRds1.close()    
                        set objRds1 = nothing
                        objCon1.close
                        set objCon1 = nothing
            
    end sub
        
     if Request.QueryString("idlist") & "" <> "" then
        PrinterIDList = Request.QueryString("idlist")
     end if


      ' iNSERT pRINTING QUEUE 
      dim newWay : newWay = false
       if printingtype = "text" and UCase(SEND_ORDERS_TO_PRINTER) = "EPSON" then
            newWay = true
       end if
      dim kindofprinter 
       if  UCase(SEND_ORDERS_TO_PRINTER) = "EPSON" then
            kindofprinter = "epson"
       else
            kindofprinter = "star"
       end if
      if kindofprinter = "star" and RePrintReceiptWays = "plaintext"  then
          RePrintReceiptWays = "phantomjs"
      end if
      dim iCountPrint : iCountPrint = 0
      if UCase(Request.QueryString("isPrint")) <> "Y" and newWay = false then
                    Dim objFSO
                    Set objFSO=CreateObject("Scripting.FileSystemObject")

                    Dim outFile, outFilePath, printingFilePath
                    outFilePath= Server.MapPath("ReceiptImage")
                    dim rId,oId
                    rId = session("restaurantid")
                    oId = OrderResID
                    printingFilePath = Server.MapPath("ReceiptImage\Printing\")
                      if PrinterIDList ="" then
                            PrinterIDList = "local_printer"
                      end if
                      dim SQL_insert : SQL_insert = "" 
                      
                     if UCase(SEND_ORDERS_TO_PRINTER) = "EPSON" then
                               dim FileModList 
                               if not isDualPrint then
                                    PrinterIDList = "local_printer"
                              
                               end if
                              
                               dim FileModListArr : FileModListArr = split(FileModList,",")
                               dim FileMod : FileMod = ""
                              
                                             
                                    arrPrinter = Split(PrinterIDList,";")
                                          For i = 0 To UBound(arrPrinter)
                                            If arrPrinter(i) & "" <> "" Then
                                                iCountPrint =  iCountPrint + 1     
                                                dim s_filenameEPSON 
                                                dim s_printstatus : s_printstatus ="New"
                                                    if RePrintReceiptWays = "plaintext" then
                                                            s_printstatus  ="created"
                                                    end if
                                                if  Instr(arrPrinter(i) & "","PN:") > 0 then
                                                    FileMod = "-PN"
                                                else
                                                    FileMod = "-EN"                
                                                end if
                                                If FileMod = "-PN" AND Instr(arrPrinter(i) & "","PN:") > 0 Then
                                                    outFile = outFilePath & "\" & rId & "-" & oId & "-" & Replace(arrPrinter(i),"PN:","") & "-" & i & FileMod & ".txt"                                          
                                                    s_filenameEPSON = rId & "-" & oId & "-" & Replace(arrPrinter(i),"PN:","") & "-" & i & FileMod & ".txt"
                                                                  
                                                            if NOT objFSO.FileExists(printingFilePath & "\" &  s_filenameEPSON ) and   isCreate(oId,   s_filenameEPSON ,kindofprinter,rId) = false  Then  
                                                                   
                                                                    if RePrintReceiptWays = "plaintext" then
                                                                        call CreateReceiptByPlainText(  oId,      rId,  s_filenameEPSON)     
                                                                    end if                           
                                                                SQL_insert =  "Insert into Order_Receipt_tracking(OrderID,s_filename,s_printtype,IdBusinessDetail,t_createdDate,s_printstatus) "
                                                                SQL_insert = SQL_insert & " values(" & oId &",'" &  s_filenameEPSON  &"','epson'," & rId & ",'" & DateAdd("h",houroffset,now) & "','"&s_printstatus&"') ; "     
                                                                objCon.Execute(SQL_insert)
                                                                 
                                                             End If
                  
                                                ElseIf  FileMod = "-EN" AND Instr(arrPrinter(i) & "","PN:") < 1 Then
                                                        FileMod = ""
                                                    outFile = outFilePath & "\" & rId & "-" & oId & "-" & arrPrinter(i) & "-" & i & FileMod & ".txt"
                                                        s_filenameEPSON =  rId & "-" & oId & "-" & arrPrinter(i) & "-" & i  & FileMod  & ".txt"
                                                         
                                                        if NOT objFSO.FileExists(printingFilePath & "\" & s_filenameEPSON ) and isCreate(oId, s_filenameEPSON ,kindofprinter,rId) = false  Then
                                                          
                                                            if RePrintReceiptWays = "plaintext" then
                                                             call CreateReceiptByPlainText(  oId,      rId,  s_filenameEPSON)
                                                            end if
                                                            SQL_insert =  "Insert into Order_Receipt_tracking(OrderID,s_filename,s_printtype,IdBusinessDetail,t_createdDate,s_printstatus) "
                                                            SQL_insert = SQL_insert & " values(" & oId &",'" & s_filenameEPSON  &"','epson'," & rId & ",'" & formatDateTimemdy(DateAdd("h",houroffset,now)) & "','"&s_printstatus&"') ; "  
                                                         
                                                             objCon.Execute(SQL_insert)   
                                                        End If
                                                End If
                                            End if 
                                        Next   
                         
                         
                   End if
      
                  set objFSO = nothing 
      end if

      ' End
  
      if Request.QueryString("isPrint") = "Y" and newWay = true  then  
            objCon.execute("Update orders set printed = 0 where ID = " & OrderResID )
      end if 
      If UCase(SEND_ORDERS_TO_PRINTER) = "EPSON"  Then  
                
              If Not isDualPrint Then
                       if  Request.QueryString("isPrint") <> "Y" and newWay = false then
                            if RePrintReceiptWays <> "none" then
                                call ReCreateReceipt("dishname",OrderResID,session("restaurantid"),RootDefaultPath & "/printers/epson/ptjs",RePrintReceiptWays,objCon,PrinterIDList)
                            else
                            %>
                                 <iframe style="visibility:hidden;position:absolute;opacity:0;" id='ifPrint'  src="<%=SITE_URL %>printers/epson/print_t.asp?mod=dishname&id_o=<%=OrderResID %>&id_r=<%=session("restaurantid")%>&isPrint=<%=Request.QueryString("isPrint") %>&idlist=<%=PrinterIDList %>" ></iframe>
                            <%
                            end if
                       elseif Request.QueryString("isPrint") = "Y" and newWay =  false  then 
                %>
                    <iframe style="visibility:hidden;position:absolute;opacity:0;" id='ifPrint'  src="<%=SITE_URL %>printers/epson/print_t.asp?mod=dishname&id_o=<%=OrderResID %>&id_r=<%=session("restaurantid") %>&isPrint=<%=Request.QueryString("isPrint") %>&idlist=<%=PrinterIDList %>" ></iframe>
              <% 
                     end if

                  else

                    if  Request.QueryString("isPrint") <> "Y" and newWay = false and RePrintReceiptWays <> "none" then
                            
                            call ReCreateReceipt("dishname",OrderResID,session("restaurantid"),RootDefaultPath & "/printers/epson/ptjs",RePrintReceiptWays,objCon,PrinterIDList)
                            call ReCreateReceipt("printingname",OrderResID,session("restaurantid"),RootDefaultPath & "/printers/epson/ptjs",RePrintReceiptWays,objCon,PrinterIDList) 
                    elseif (Request.QueryString("isPrint") = "Y" and newWay = false) or ( RePrintReceiptWays = "none" and printingtype <> "text")  then 
                   %>
                       <iframe style="visibility:hidden;position:absolute;opacity:0;" id='ifPrint'  src="<%=SITE_URL %>printers/epson/print_t.asp?mod=dishname&id_o=<%=OrderResID %>&id_r=<%=session("restaurantid") %>&isPrint=<%=Request.QueryString("isPrint") %>&idlist=<%=PrinterIDList %>" ></iframe>
                       <iframe style="visibility:hidden;position:absolute;opacity:0;" id='ifPrint2'  src="<%=SITE_URL %>printers/epson/print_t.asp?mod=printingname&id_o=<%=OrderResID %>&id_r=<%=session("restaurantid") %>&isPrint=<%=Request.QueryString("isPrint") %>&idlist=<%=PrinterIDList %>" ></iframe>
            <%      end if
                end if %>
    <% ElseIf UCase(SEND_ORDERS_TO_PRINTER) = "STAR" Then  
         If Not isDualPrint Then
             if RePrintReceiptWays = "phantomjs" then
                    call ReCreateReceipt("dishname",OrderResID,session("restaurantid"),RootDefaultPath & "/printers/epson/ptjs",RePrintReceiptWays,objCon,PrinterIDList)
             else
         %>    
                <iframe style="visibility:hidden;position:absolute;opacity:0;" id='ifPrint'  src="<%=SITE_URL %>printers/star/print_t.asp?id_o=<%=OrderResID %>&id_r=<%=session("restaurantid") %>&isPrint=<%=Request.QueryString("isPrint") %>&idlist=<%=PrinterIDList %>" ></iframe>
            <% end if %>
          <%
               else
                    if RePrintReceiptWays = "phantomjs" then
                        call ReCreateReceipt("dishname",OrderResID,session("restaurantid"),RootDefaultPath & "/printers/epson/ptjs",RePrintReceiptWays,objCon,PrinterIDList)
                        call ReCreateReceipt("printingname",OrderResID,session("restaurantid"),RootDefaultPath & "/printers/epson/ptjs",RePrintReceiptWays,objCon,PrinterIDList) 
                    else
               %>
                        <iframe style="visibility:hidden;position:absolute;opacity:0;" id='ifPrint'  src="<%=SITE_URL %>printers/star/print_t.asp?mod=dishname&id_o=<%=OrderResID %>&id_r=<%=session("restaurantid")%>&isPrint=<%=Request.QueryString("isPrint") %>&idlist=<%=PrinterIDList %>" ></iframe>
                        <iframe style="visibility:hidden;position:absolute;opacity:0;" id='ifPrint2'  src="<%=SITE_URL %>printers/star/print_t.asp?mod=printingname&id_o=<%=OrderResID %>&id_r=<%=session("restaurantid") %>&isPrint=<%=Request.QueryString("isPrint") %>&idlist=<%=PrinterIDList %>" ></iframe>
                  <% end if %>
        <% end if %>
     <% end if %>
  
    <% 
            Session("OrderID")  = 0
            Session("ResID")  = ""
        If UCase(Request.QueryString("isPrint")) = "Y" then %>
    <script> setTimeout("window.close()", 10000);</script>
    <% else 
        Session.Abandon %>
    <% end if
        
         WriteLog Server.MapPath("receiptpage.txt"),"PageName  = Thanks.asp Done [Orderid] " & OrderResID
          objCon.close()
          set objCon = nothing
         %>

     <script type="text/javascript">
         //<![CDATA[
         var intervalID;
         var countInterval = 1
         $(window).load(function () { // makes sure the whole site is loaded            
                 $('#status').fadeOut(); // will first fade out the loading animation
                 $('#preloader').delay(450).fadeOut('slow'); // will fade out the white DIV that covers the website.
                 $('body').delay(450).css({ 'overflow': 'visible' });
           

         })
         //]]>
</script>

</body>
</html>
