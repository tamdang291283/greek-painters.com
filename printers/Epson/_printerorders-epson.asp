<!-- #include file="../../Config.asp" -->
<% 
    If request.querystring("id") & "" <> "" Then
        session("restaurantid")=request.querystring("id")
        
    End IF 
    
 %>
<!-- #include file="../../timezone.asp" -->
<!-- #include file="../../restaurantsettings.asp" --><%
  textreceipt =  true

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

Function ReplaceSpecialCharacter(sInput)
    Dim sOutput
    sOutput = Replace(sInput,"&","&amp;")
    sOutput = Replace(sOutput,"<","&lt;")
    sOutput = Replace(sOutput,">","&gt;")
    sOutput = Replace(sOutput,"'","&apos;")
    sOutput = Replace(sOutput,"""","&quot;")
    ReplaceSpecialCharacter = sOutput
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
        Latitude_DMS =   CStr(d) & "°" & _
        CStr(m) & "&apos;"  & CStr(s) & "&quot;" & sign
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
        Longitude_DMS = CStr(d) & "°" & _
        CStr(m) & "&apos;" & CStr(s) & "&quot;" & sign
   
End Function 

Dim tempOrderId, tempRestaurantId, tempPrinterID ,PrintJobId
    tempOrderId = Session("TempPOID")
    tempRestaurantId = session("restaurantid")
    tempPrinterID = Session("Printer_ID")
    PrintJobId = Session("PrintJobId")
dim fs,f

  For Each sItem In Request.Form
        WriteLog Server.MapPath("dump.txt"),"StoreID[" &session("restaurantid")& "] " &  sItem    
        WriteLog Server.MapPath("dump.txt")," - [" & Request.Form(sItem) & "]" & vbCrLf
  Next

  WriteLog Server.MapPath("dump.txt"),"StoreID[" &session("restaurantid")& "]---------------------------------" & vbCrLf

if request.form("ConnectionType")="SetResponse" then

    WriteLog Server.MapPath("dump.txt"),"StoreID[" &session("restaurantid")& "] SetResponse" & vbCrLf
    xml=request.form("ResponseFile")
    s1=instr(xml,"<printjobid>")
    lll=len(xml)-s1-11
    r=right(xml,lll)
    s2=instr(r,"</printjobid>")
    nodeid=left(r,s2-1)

    WriteLog Server.MapPath("dump.txt"),"StoreID[" &session("restaurantid")& "]------- printjob id = " &  nodeid & "--------------------------" & vbCrLf
	if instr(xml,"true") then
          WriteLog Server.MapPath("dump.txt"),"StoreID[" &session("restaurantid")& "]------- success = true for id = " &  nodeid & "--------------------------" & vbCrLf
         Set objCon2 = Server.CreateObject("ADODB.Connection")
             objCon2.Open sConnString
             objCon2.execute(" Update Orders set printed = 1 where id= " & nodeid )
             objCon2.Close 
             set objCon2 = nothing   
	end if
else

set fs=nothing
   
if SEND_ORDERS_TO_PRINTER="EPSON" then
    ooo=""
    Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 
	 objCon.Open sConnString
    Dim sQuery
     If Session("TempPOID") & "" <> "" Then
        sQuery = "SELECT *  FROM view_paid_orders  WHERE ID = " & Session("TempPOID") & " AND  IdBusinessDetail = " & session("restaurantid") & " "        
   
        objRds.Open sQuery, objCon
        Session("TempPOID") = ""
    Else
        sQuery = "SELECT *  FROM orders  WHERE IdBusinessDetail = " & session("restaurantid") & "  "
        objRds.Open sQuery, objCon
    End If
       
    if NOT objRds.Eof then
        Set objRds20 = Server.CreateObject("ADODB.Recordset") 
        objRds20.Open "SELECT Name,Address,telephone,email,AverageDeliveryTime,AverageCollectionTime FROM BusinessDetails WHERE Id = " & session("restaurantid"), objCon 
        if not objRds20.eof then
	        name=objRds20("Name")
	        address= objRds20("Address") 
	        telephone=objRds20("telephone") 
	        email=  objRds20("email") 
	        vaveragedel = objRds20("AverageDeliveryTime")
	        vaveragecol = objRds20("AverageCollectionTime")
	    end if
             objRds20.close()
        set objRds20 =  nothing
     
       
	 %><?xml version="1.0" encoding="utf-8"?>
<PrintRequestInfo Version="2.00">
<% 
'	 Do While NOT objRds.Eof
	 deliverytype=""
	 if objRds("DeliveryType")="c" then
	    deliverytype="Collection"
	 else
	    deliverytype="Delivery"
	 end if
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
        
        Dim PaymentSurcharge, ServiceCharge, vvouchercode, vvouchercodediscount,VoucherDiscontType
        PaymentSurcharge = objRds("PaymentSurcharge")
        If PaymentSurcharge & "" = "" Then
            PaymentSurcharge = "0"
        End If

        dim Tax_Amount,Tip_Amount
        Tax_Amount = objRds("Tax_Amount")
        Tip_Amount = objRds("Tip_Amount")
         If Tax_Amount & "" = "" Then
            Tax_Amount = "0"
        End If
         If Tip_Amount & "" = "" Then
            Tip_Amount = "0"
        End If
        Dim TipRate : TipRate = objRds("Tip_Rate")
        if TipRate  & "" = "" then
            TipRate = "0"
        end if
        if TipRate & "" <> "custom" then
            TipRate =  TipRate & "%"
        end if
        ServiceCharge = objRds("ServiceCharge")
        If ServiceCharge & "" = "" Then
            ServiceCharge = "0"
        End If
        vvouchercode = ""
        vvouchercodediscount = ""
        vvouchercodediscount = objRds("vouchercodediscount")
		vvouchercode=objRds("vouchercode")
          VoucherDiscontType=objRds("DiscountType")  
          dim numberOfOrder : numberOfOrder  = 0
            if Show_Ordernumner_printer = "yes" then
                  Set objRds20 = Server.CreateObject("ADODB.Recordset") 
                      objRds20.Open "select count(ID) as numberoforder from orders where Email = '" &  replace(objRds("email"),"'","''") & "' and IdBusinessDetail=" & session("restaurantid"), objCon             
                    if not objRds20.EOF then
                        numberOfOrder = objRds20("numberoforder")
                    end if   
                    objRds20.close()
                set objRds20 = nothing    
          end if 
	    'vvouchercode="Test voucher 12"
        'vvouchercodediscount = 12
        'PaymentSurcharge = 1.2
        'ServiceCharge = 2.3
	 
	 
	 Set objRds2 = Server.CreateObject("ADODB.Recordset") 
	 
     objRds2.Open "select oi.*,mi.Name, mip.Name as PropertyName,mip.printingname as Propertyprintingname, mi.PrintingName from ( OrderItems oi  inner join MenuItems mi on oi.MenuItemId = mi.Id )  left join MenuItemProperties mip on oi.MenuItemPropertyId = mip.Id where oi.OrderId = " & objRds("id"), objCon
	 oooo=""
	Do While NOT objRds2.Eof
          if instr(PrintJobId,"PN") > 0 then
              dim dishname : dishname = objRds2("Name")
              if objRds2("Propertyprintingname") & "" <> "" Then
                    dishname = objRds2("Propertyprintingname")
              elseif objRds2("PropertyName") & "" <> "" Then
                    dishname = objRds2("PropertyName")
              elseIf objRds2("PrintingName") & "" <> "" Then
                    dishname = objRds2("PrintingName")
              end if               
    
            oooo=oooo & "<text>&#10;</text><text width=""2"" height=""2""/><text reverse=""false"" ul=""false"" em=""false"" color=""color_1""/> <text lang=""zh-cn"" /><text>" & objRds2("Qta") & " x " &  ReplaceSpecialCharacter(dishname) &"</text><text width=""1"" height=""1""/><text lang=""en"" />"
         else
            oooo=oooo & "<text>&#10;</text><text width=""1"" height=""1""/><text reverse=""false"" ul=""false"" em=""false"" color=""color_1""/><text>" & objRds2("Qta") & " x " & ReplaceSpecialCharacter(objRds2("Name")) &"</text><text width=""1"" height=""1""/>"
         end if
        
        ttabs="&#9;&#9;&#9;&#9;"
        oooo=oooo & "<text x=""450""/><text>" &    FormatNumber(objRds2("Total"), 2) & "&#10;</text>"
	 if objRds2("PropertyName")<>"" and instr(PrintJobId,"PN") = 0 then
	    oooo=oooo & "<text>" & "    " & ReplaceSpecialCharacter(objRds2("PropertyName")) &"&#10;</text>"
	 end if
	 
	                If objRds2("dishpropertiesids") <> "" Then
						dishpropertiessplit=split(objRds2("dishpropertiesids"),",")
                        
                            
					    for i=0 to ubound(dishpropertiessplit)
					        dishpropertiessplit2=split(dishpropertiessplit(i),"|")
					        Set objRds_dishpropertiesprice = Server.CreateObject("ADODB.Recordset") 
	                        objRds_dishpropertiesprice.Open "SELECT MenuDishproperties.ID, MenuDishproperties.dishproperty, MenuDishproperties.printingname as dishpropertyPrintingname, MenuDishproperties.dishpropertyprice, MenuDishpropertiesGroups.dishpropertypricetype, MenuDishpropertiesGroups.dishpropertygroup, MenuDishpropertiesGroups.printingname as dishpropertygroupPrintingname FROM MenuDishproperties INNER JOIN MenuDishpropertiesGroups ON MenuDishproperties.dishpropertygroupid = MenuDishpropertiesGroups.ID where (((MenuDishproperties.ID)=" & dishpropertiessplit2(1)  & "))", objCon
                                if not objRds_dishpropertiesprice.EOF then
                                    dim dishpropertygroup : dishpropertygroup = objRds_dishpropertiesprice("dishpropertygroup") & "" 
                                    dim dishproperty : dishproperty = objRds_dishpropertiesprice("dishproperty") & "" 
                                     if  instr(PrintJobId,"PN") > 0  then
                                                if objRds_dishpropertiesprice("dishpropertygroupPrintingname") & "" <> "" then
                                                         dishpropertygroup = objRds_dishpropertiesprice("dishpropertygroupPrintingname") & "" 
                                                end if
                             
                                                if objRds_dishpropertiesprice("dishpropertyPrintingname") & "" <> "" then
                                                         dishproperty = objRds_dishpropertiesprice("dishpropertyPrintingname") & "" 
                                                end if
                                            oooo=oooo & "<text width=""2"" height=""2""/><text reverse=""false"" ul=""false"" em=""false"" color=""color_1""/> <text lang=""zh-cn"" /><text>" &"    " & ReplaceSpecialCharacter(dishpropertygroup) & ": " & ReplaceSpecialCharacter(dishproperty) & "</text><text width=""1"" height=""1""/><text lang=""en"" /><text>&#10;</text>"
                                    else
                                            oooo=oooo & "<text>" &"    "&  ReplaceSpecialCharacter(dishpropertygroup) & "</text><text>: " & ReplaceSpecialCharacter(dishproperty) & "&#10;</text>"
                                    end if
                                end if
                                
                                set objRds_dishpropertiesprice= nothing
					    next
                        
					end if
					
					toppingtext=""
                    dim toppingGroup : toppingGroup = "" 
					If objRds2("toppingids") <> "" Then 
						
						Set objRds_toppingids = Server.CreateObject("ADODB.Recordset") 
                        'Set objRds_toppingids = Server.CreateObject("ADODB.Recordset") 
                        Set objRds_toppingids_group = Server.CreateObject("ADODB.Recordset") 
                        dim  SQLtopping : SQLtopping = "" 
                             SQLtopping = "select top 1 ID, toppingsgroup,printingname  from Menutoppingsgroups  where id in (select toppinggroupid from menutoppings where id  in (" & objRds2("toppingids")& ")  ) "
                             objRds_toppingids_group.Open SQLtopping, objCon
                            if not objRds_toppingids_group.EOF then
                                    toppingGroup = objRds_toppingids_group("toppingsgroup")
                                if  instr(PrintJobId,"PN") > 0 and objRds_toppingids_group("printingname") & "" <> ""  then
                                    toppingGroup =   objRds_toppingids_group("printingname") 
                                end if
                            end if
						    objRds_toppingids_group.close()
                        set objRds_toppingids_group = nothing

                            if toppingGroup & "" = "" then
                                toppingGroup = "Toppings"
                            end if         
                            objRds_toppingids.Open "SELECT topping,printingname FROM MenuToppings where id in (" & objRds2("toppingids") & ")", objCon
				            Do While NOT objRds_toppingids.Eof 
				                 dim topping : topping =  objRds_toppingids("topping")
                                 if  instr(PrintJobId,"PN") > 0 and objRds_toppingids("printingname") & "" <> ""  then
                                     topping =  objRds_toppingids("printingname")
                                 end if
						             toppingtext = toppingtext & topping & ", "

				                objRds_toppingids.MoveNext
				            loop
                            objRds_toppingids.close()
                        set objRds_toppingids  = nothing    

						    if toppingtext<>"" then
							    toppingtext=left(toppingtext,len(toppingtext)-2)						
                                IF instr(PrintJobId,"PN") > 0 then
                                    oooo=oooo & "<text width=""2"" height=""2""/><text reverse=""false"" ul=""false"" em=""false"" color=""color_1""/> <text lang=""zh-cn"" /><text>"&"    " &ReplaceSpecialCharacter(toppingGroup) &": " & ReplaceSpecialCharacter(toppingtext)  & "</text><text width=""1"" height=""1""/><text lang=""en"" /><text>&#10;</text>"
                                else
						            oooo=oooo & "<text>"&"    " & ReplaceSpecialCharacter(toppingGroup) &": " & ReplaceSpecialCharacter(toppingtext) & "&#10;</text>"
                                end if
						    end if
				      End If  
	 objRds2.MoveNext    
	 Loop
	    objRds2.close()
    set objRds2 = nothing
	 %><ePOSPrint>
<Parameter><% If Session("Printer_ID")& "" <> "" Then %><devid><%=Session("Printer_ID") %></devid><% Session("Printer_ID") = "" %><% Else %><devid>local_printer</devid><% end if %><timeout>10000</timeout><% If Session("PrintJobId") & "" <> "" Then %><printjobid><%=Session("PrintJobId") %></printjobid><% Session("PrintJobId") = "" %><% else %><printjobid><%=objRds("id") %></printjobid><% end if %></Parameter>
<PrintData>
<epos-print xmlns="http://www.epson-pos.com/schemas/2011/03/epos-print">  
<text smooth="true" />
<text align="center" />
<text font="font_a" />
<text dw="true" dh="true" /><%dim OrderType
                    If objRds("DeliveryType") = "d" Then
                        OrderType ="Delivery"
                    else
                         OrderType ="Collection"
                    end if
                    plaintextTemplate = replace(plaintextTemplate,"[DELTYPE]",OrderType)
            
                    plaintextTemplate = replace(plaintextTemplate,"[ORDERTIME]", formatDateTimeC(objRds("orderdate")))
                    dim requestfor 
                    if objRds("asaporder") = "n" then
                        if objRds("DeliveryType") = "c" then
                             requestfor = DateAdd("n",vaveragecol,objRds("orderdate"))  
                        else
                            requestfor ="ASAP"
                        end if
                    else
                        requestfor = formatDateTimeC(objRds("DeliveryTime"))
                    end if
                    dim paymentstatus 
                    if  objRds("PaymentType")="Stripe-Paid" or objRds("PaymentType")="Paypal-Paid" or objRds("PaymentType")="NoChex-Paid" or objRds("PaymentType")="Worldpay-Paid" or Ucase(objRds("Payment_status") & "")="PAID"   then
                        paymentstatus = "ORDER PAID"
                    else
                        paymentstatus = "ORDER UNPAID"
                    end if

%><text><%=OrderType %> &#10;&#10;</text>
<text dw="false" dh="false"/>
<text>[<%=requestfor %>] &#10;</text>
<text><%=paymentstatus %> &#10;</text>
<text dw="false" dh="false" />
<text align="center" />
<text reverse="false" ul="false" em="true" color="color_1"/>
<text>Order <%=objRds("id")%> from <%= ReplaceSpecialCharacter(name) %>&#10;&#10;</text>
<% If ShowRestaurantDetailOnReceipt & "" = "1" Then %>
<text reverse="false" ul="false" em="false" color="color_1"/>
<text><%=ReplaceSpecialCharacter(name)%>&#10;</text>
<text><%=ReplaceSpecialCharacter(address)%>&#10;</text>
<text>Tel. <%=ReplaceSpecialCharacter(telephone)%>&#10;</text>
<text>Email: <%=ReplaceSpecialCharacter(email)%>&#10;&#10;</text>
<% End if %>
 <text align="left" /> 
<text reverse="false" ul="false" em="true" color="color_1"/>
<text>Customer Details&#10;</text>
<text reverse="false" ul="false" em="false" color="color_1"/>
<text>-----------&#10;</text>
<text align="left" />
<text dw="false" dh="false" />
<text><%=ReplaceSpecialCharacter(objRds("firstname"))%>&#160;<%=ReplaceSpecialCharacter(objRds("lastname"))%>&#10;</text>
<text><%=ReplaceSpecialCharacter(objRds("address"))%>,&#10;</text>
<text><%=ReplaceSpecialCharacter(objRds("postalcode"))%>&#10;</text>
<text>Phone: <%=ReplaceSpecialCharacter(objRds("phone"))%>&#10;</text>
<text>Email: <%=ReplaceSpecialCharacter(objRds("Email"))%>&#10;</text>
 <% If objRds("DeliveryLat") & "" <> "" Then %>
<text>Lat/Long: <%= objRds("DeliveryLat") & "," & objRds("DeliveryLng")%>&#10;</text>
<text>GPS: <%=Latitude_DMS(objRds("DeliveryLat")) & " ," & Longitude_DMS(objRds("DeliveryLng")) %>&#10;</text>
<% End If %>
 <text>&#10;</text>
 <text align="left" />
<text reverse="false" ul="false" em="true" color="color_1"/>
<text>Order Details&#10;</text>
<text reverse="false" ul="false" em="false" color="color_1"/>
<text>-----------&#10;</text>
<text align="left" />
<text>Order Number: <%=objRds("id")%> &#10;</text>
<text>Order Time: <%response.write(formatDateTimeC(objRds("orderdate")))%>%>&#10;</text>
<text>Order Type: <% If objRds("DeliveryType") = "d" Then %>Delivery<% Else %>Collection<% End If %>&#10;</text>
<text>Requested for: <%if objRds("asaporder") = "n" then%>  <%if objRds("DeliveryType") = "c" then%><%=formatDateTimeC(DateAdd("n",vaveragecol,objRds("orderdate")))%><%else%>ASAP<%end if%><%else%><%= formatDateTimeC(objRds("DeliveryTime")) %><%end if%>&#10;</text>
<text><%if objRds("asaporder") = "n" then
if objRds("DeliveryType") = "d" then
mintoadd=vaveragedel '+ 5
else
mintoadd=vaveragecol '+ 5
end if
%>Accepted to: <%=DateAdd("n",mintoadd,objRds("orderdate"))%>&#10;<%end if%></text>
<text>Payment Status: <%if  objRds("PaymentType")="Stripe-Paid" or objRds("PaymentType")="Paypal-Paid" or objRds("PaymentType")="NoChex-Paid" or objRds("PaymentType")="Worldpay-Paid" or Ucase(objRds("Payment_status") & "")="PAID"  then  %>ORDER PAID
<%else%>ORDER UNPAID<%end if%></text>
<text>&#10;&#10;</text>
<text align="left" />
<%=oooo%><text>&#10;</text>
<text align="center" />
<text>-----------&#10;</text>
<text align="left" />
<%if vvouchercode & "" <>"" then%><text>Discount code:&#9;&#9;&#9;-<%=CURRENCYSYMBOL%><%if VoucherDiscontType <> "Amount" then %> <%= FormatNumber((( objRds("SubTotal") * 100 )/(100- Cdbl(Replace(Replace(Replace(vvouchercodediscount,"-",""),"%","")," ",""))) - objRds("SubTotal") ),2) %><%else %><%=FormatNumber(Cdbl(Replace(Replace(Replace(vvouchercodediscount,"-",""),"%","")," ","")),2) %><%end if %>  &#10;</text>				
<text><%=ReplaceSpecialCharacter(vvouchercode&"")%><%if VoucherDiscontType <> "Amount" then %> (-<%=ReplaceSpecialCharacter(vvouchercodediscount)%>%)&#10;<%end if %></text>
<%end if%>
<%end if%><text>SubTotal:&#9;&#9;&#9;<%= FormatNumber(objRds("SubTotal"), 2)  %>&#10;</text>
<text>Delivery Fee:&#9;&#9;&#9;<%= FormatNumber(vShippingFee, 2)  %>&#10;</text>
<%if  Cdbl(PaymentSurcharge) > 0 then  %>
<text>Credit card surcharge:&#9;&#9;<%= FormatNumber(PaymentSurcharge, 2)  %>&#10;</text>
<%end if %>
<%if  Cdbl(ServiceCharge) > 0 then  %>
<text>Service charge:&#9;&#9;&#9;<%= FormatNumber(ServiceCharge, 2)  %>&#10;</text>
<%end if %>
<%if  Cdbl(Tax_Amount) > 0 then  %>
<text>Tax(<%=Tax_Percent %>%):&#9;&#9;&#9;<%= FormatNumber(Tax_Amount, 2)  %>&#10;</text>
<%end if %>
<%if  Cdbl(Tip_Amount) > 0 then  %>
<text>Tax(<%=TipRate %>):&#9;&#9;&#9;<%= FormatNumber(Tip_Amount, 2)  %>&#10;</text>
<%end if %>
<text reverse="false" ul="false" em="true" color="color_1"/>
<text>TOTAL&#9;&#9;&#9;&#9;<%=FormatNumber(objRds("ordertotal"),2)%>&#10;&#10;</text>
<text reverse="false" ul="false" em="false" color="color_1"/>

<%if objRds("notes")<>"" then%><text reverse="false" ul="false" em="true" color="color_1"/>
<text>Special Instructions&#10;</text>
<text reverse="false" ul="false" em="false" color="color_1"/>
<text>-----------&#10;</text>
<text align="left" />
<text><%=ReplaceSpecialCharacter(objRds("notes"))%>&#10;</text>
<%end if%><text align="left" />
    <% if Show_Ordernumner_printer = "yes" then %>
<text>-----------&#10;</text>
<text>Number of orders: <%=numberOfOrder%> &#10;</text>
   <%end if %>
<text align="left" />
<feed unit="12"/>
<cut type="feed"/>
</epos-print>
</PrintData>
</ePOSPrint>
</PrintRequestInfo>
<%
end if
        objRds.close
    set objRds = nothing
    objCon.close()
    set objCon = nothing
end if
'end if



%>