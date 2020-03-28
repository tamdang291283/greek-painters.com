<!-- #include file="../../Config.asp" -->
<% 
    If request.querystring("id_r") & "" <> "" Then
        session("restaurantid")=request.querystring("id_r")
    End IF 
    
 %>
<!-- #include file="../../timezone.asp" -->
<!-- #include file="../../restaurantsettings.asp" --><%
    textreceipt = true
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
    'For trailing cardinal letter (adjust sign setting above)
    '  Longitude_DMS = CStr(d) & Chr(176) & Chr(32) & _
    '    CStr(m) & Chr(39) & Chr(32) & CStr(s) & Chr(34) & Chr(32) & sign
    End Function 
Dim tempOrderId, tempRestaurantId, tempPrinterID ,PrintJobId
 
    'Session("TempPOID") = 2873
    'session("restaurantid") = 2
    'Session("Printer_ID") = "local_printer"
    'Session("PrintJobId") = "2-2873-local_printer-0"
   
tempOrderId = Request.QueryString("TempPOID") ' Session("TempPOID")
tempRestaurantId = Request.QueryString("id_r") ' session("restaurantid")
'tempPrinterID = Session("Printer_ID")
PrintJobId = Request.QueryString("PrintJobId") 'Session("PrintJobId")

if SEND_ORDERS_TO_PRINTER="EPSON" then
    ooo=""
    Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 
	 objCon.Open sConnString
    Dim sQuery
     If tempOrderId& "" <> "" Then
        sQuery = "SELECT *  FROM view_paid_orderslocal  WHERE ID = " & tempOrderId & " "        
        objRds.Open sQuery, objCon
    End If
       
	 if NOT objRds.Eof then

	
    Set objRds20 = Server.CreateObject("ADODB.Recordset") 
	
    objRds20.Open "SELECT * FROM BusinessDetails WHERE Id = " & tempRestaurantId, objCon 
	name=objRds20("Name")
	address= objRds20("Address") 
	telephone=objRds20("telephone") 
	email=  objRds20("email") 
	vaveragedel = objRds20("AverageDeliveryTime")
	vaveragecol = objRds20("AverageCollectionTime")
	 
 
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

        vShippingFee = objRds("ShippingFee")
        vSubTotal = objRds("SubTotal")
        vOrderTotal = objRds("OrderTotal")
        
        Dim PaymentSurcharge, ServiceCharge, vvouchercode, vvouchercodediscount
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

	    'vvouchercode="Test voucher 12"
        'vvouchercodediscount = 12
        'PaymentSurcharge = 1.2
        'ServiceCharge = 2.3


	 
	 Set objRds2 = Server.CreateObject("ADODB.Recordset") 	 
     objRds2.Open "select oi.*,mi.Name, mip.Name as PropertyName,mip.printingname as Propertyprintingname, mi.PrintingName from ( OrderItemsLocal oi  inner join MenuItems mi on oi.MenuItemId = mi.Id )  left join MenuItemProperties mip on oi.MenuItemPropertyId = mip.Id where oi.OrderId = " & objRds("id"), objCon
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
             if instr(dishname,"[NEWL2]") > 0 then
               dim arr : arr = split(dishname,"[NEWL2]")  
               dim i 
                oooo=oooo & "<text>&#10;</text><text width=""2"" height=""2""/><text reverse=""false"" ul=""false"" em=""false"" color=""color_1""/> <text lang=""zh-cn"" /><text>" & objRds2("Qta") & " x </text> "
               for i = 0 to ubound(arr)   
                  if i  = 0 then
                     oooo=oooo & "<text width=""2"" height=""2""/><text>"  & ReplaceSpecialCharacter(arr(i)) & "</text>" 
                  else
                     oooo=oooo & "<text>&#10;</text><text width=""1"" height=""1""/><text reverse=""false"" ul=""false"" em=""false"" color=""color_1""/> <text lang=""zh-cn"" /><text>&#9;"  & trim( ReplaceSpecialCharacter(arr(i))) & "</text>" 
                  end if
               next 
               oooo=oooo & "<text width=""1"" height=""1""/><text lang=""en"" />"
            else
                oooo=oooo & "<text>&#10;</text><text width=""2"" height=""2""/><text reverse=""false"" ul=""false"" em=""false"" color=""color_1""/> <text lang=""zh-cn"" /><text>" & objRds2("Qta") & " x " &  ReplaceSpecialCharacter(dishname) &"</text><text width=""1"" height=""1""/><text lang=""en"" />"
            end if
             'oooo=oooo & "<text>&#10;</text><text width=""2"" height=""2""/><text reverse=""false"" ul=""false"" em=""false"" color=""color_1""/> <text lang=""zh-cn"" /><text>" & objRds2("Qta") & " x " &  ReplaceSpecialCharacter(dishname) &"</text><text width=""1"" height=""1""/><text lang=""en"" />"
         else
            oooo=oooo & "<text>&#10;</text><text width=""1"" height=""1""/><text reverse=""false"" ul=""false"" em=""false"" color=""color_1""/><text>" & objRds2("Qta") & " x " & ReplaceSpecialCharacter(objRds2("Name")) &"</text><text width=""1"" height=""1""/>"
         end if


ttabs=""
ttabs="&#9;&#9;&#9;&#9;"
         oooo=oooo & "<text x=""450""/><text>" &   FormatNumber(objRds2("Total"), 2) & "&#10;</text>"
	 if objRds2("PropertyName")<>"" and  instr(PrintJobId,"PN") = 0 then
	 oooo=oooo & "<text>" &"    " & ReplaceSpecialCharacter(objRds2("PropertyName")) &"&#10;</text>"
	 'response.write " - " & objRds2("PropertyName")
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
                                        oooo=oooo & "<text width=""2"" height=""2""/><text reverse=""false"" ul=""false"" em=""false"" color=""color_1""/> <text lang=""zh-cn"" /><text>" & "    " &  ReplaceSpecialCharacter(dishpropertygroup) & ": " & ReplaceSpecialCharacter(dishproperty) & "</text><text width=""1"" height=""1""/><text lang=""en"" /><text>&#10;</text>"
                             else
                                        oooo=oooo & "<text>" & "    " &  ReplaceSpecialCharacter(dishpropertygroup) & "</text><text>: " & ReplaceSpecialCharacter(dishproperty) & "&#10;</text>"
                             end if
					                        'response.write "%%" & objRds_dishpropertiesprice("dishpropertygroup") & ":" & objRds_dishpropertiesprice("dishproperty")
                        end if
					next
					end if
					
					toppingtext=""
                    dim toppingGroup : toppingGroup = "" 
					If objRds2("toppingids") <> "" Then 
						    
							     
                            Set objRds_toppingids = Server.CreateObject("ADODB.Recordset") 
                            Set objRds_toppingids_group = Server.CreateObject("ADODB.Recordset")     
                            dim SQLtopping : SQLtopping = "" 
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
                        objRds_toppingids.Open "SELECT * FROM MenuToppings where id in (" & objRds2("toppingids") & ")", objCon
				        Do While NOT objRds_toppingids.Eof 
						    dim topping : topping =  objRds_toppingids("topping")
                             if  instr(PrintJobId,"PN") > 0 and objRds_toppingids("printingname") & "" <> ""  then
                                 topping =  objRds_toppingids("printingname")
                             end if
						    toppingtext = toppingtext & topping & ", "
						objRds_toppingids.MoveNext
						loop
                            objRds_toppingids.close()
                        set objRds_toppingids = nothing
						if toppingtext<>"" then
							toppingtext=left(toppingtext,len(toppingtext)-2)
						'response.write "%%Toppings: " & toppingtext 
						    IF instr(PrintJobId,"PN") > 0 then
                                oooo=oooo & "<text width=""2"" height=""2""/><text reverse=""false"" ul=""false"" em=""false"" color=""color_1""/> <text lang=""zh-cn"" /><text>" & "    " & ReplaceSpecialCharacter(toppingGroup) &": " & ReplaceSpecialCharacter(toppingtext)  & "</text><text width=""1"" height=""1""/><text lang=""en"" /><text>&#10;</text>"
                            else
						        oooo=oooo & "<text>" & "    " & ReplaceSpecialCharacter(toppingGroup) &": " & ReplaceSpecialCharacter(toppingtext) & "&#10;</text>"
                            end if
						end if
						 End If  
					
					'response.write  ";" & FormatNumber(objRds2("Total"), 2) & ";"
	 
	
	 objRds2.MoveNext    
	 Loop
	objRds2.close()
    set objRds2 = nothing
	 %>
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
                             requestfor = formatDateTimeC(DateAdd("n",vaveragecol,objRds("orderdate")))  
                        else
                            requestfor ="ASAP"
                        end if
                    else
                        requestfor = formatDateTimeC(objRds("DeliveryTime")) 
                    end if
                    dim paymentstatus 
                    if  objRds("PaymentType")="Stripe-Paid" or objRds("PaymentType")="Paypal-Paid" or objRds("PaymentType")="NoChex-Paid" or objRds("PaymentType")="Worldpay-Paid" or Ucase(objRds("Payment_status") & "")="PAID"  then
                        paymentstatus = "ORDER PAID"
                    else
                        paymentstatus = "ORDER UNPAID"
                    end if
%>
<text align="center" />
<text>In-Store&#10;</text>
<text><%=paymentstatus %> &#10;&#10;</text>
<text dw="false" dh="false" />
<text align="left" />
<text reverse="false" ul="false" em="true" color="color_1"/>
<% If ShowRestaurantDetailOnReceipt & "" = "1" Then %>
<text reverse="false" ul="false" em="false" color="color_1"/>
<text><%=ReplaceSpecialCharacter(name)%>&#10;</text>
<text><%=ReplaceSpecialCharacter(address)%>&#10;</text>
<text>Tel. <%=telephone%>&#10;</text>
<text>Email: <%=email%>&#10;&#10;</text>
<% End if %>
 <text align="left" /> 
<text reverse="false" ul="false" em="true" color="color_1"/>
<text>Customer&#10;</text>
<text align="left" />
<text dw="false" dh="false" />
<text><%=ReplaceSpecialCharacter(objRds("firstname"))%>&#10;</text>
<text>&#10;</text>
<text align="left" />
<text reverse="false" ul="false" em="true" color="color_1"/>
<text>Order Details&#10;</text>
<text reverse="false" ul="false" em="false" color="color_1"/>
<text>-----------&#10;</text>
<text align="left" />
<text>Order Number: <%=objRds("id")%> &#10;</text>
<text>Order Time: <%response.write(formatDateTimeC(objRds("orderdate")))%>&#10;</text>
<text>Payment Status: <%=paymentstatus%> &#10;</text>
<text align="left" />
<%=oooo%><text>&#10;</text>
<text align="center" />
<text>-----------&#10;</text>
<text align="left" />
<%if vvouchercode & "" <>"" then%>
<text>Discount code:</text><text x="450"/><text>-<%= FormatNumber((( objRds("SubTotal") * 100 )/(100- Cdbl(Replace(Replace(Replace(vvouchercodediscount,"-",""),"%","")," ",""))) - objRds("SubTotal") ),2) %>&#10;</text>				
<text><%=ReplaceSpecialCharacter(vvouchercode&"")%> (-<%=ReplaceSpecialCharacter(vvouchercodediscount)%>%)&#10;</text>
<%end if%><text>SubTotal:</text><text x="450"/><text><%= FormatNumber(objRds("SubTotal"), 2)  %>&#10;</text>
<text>Delivery Fee:</text><text x="450"/><text><%= FormatNumber(vShippingFee, 2)  %>&#10;</text>
<%if  Cdbl(PaymentSurcharge) > 0 then  %>
<text>Credit card surcharge:</text><text x="450"/><text><%= FormatNumber(PaymentSurcharge, 2)  %>&#10;</text>
<%end if %>
<%if  Cdbl(ServiceCharge) > 0 then  %>
<text>Service charge:</text><text x="450"/><text><%= FormatNumber(ServiceCharge, 2)  %>&#10;</text>
<%end if %>
<%if  Cdbl(Tax_Amount) > 0 then  %>
<text>Tax(<%=Tax_Percent %>%):</text><text x="450"/><text><%= FormatNumber(Tax_Amount, 2)  %>&#10;</text>
<%end if %>
<%if  Cdbl(Tip_Amount) > 0 then  %>
<text>Tip:(<%=TipRate %>)</text><text x="450"/><text><%= FormatNumber(Tip_Amount, 2)  %>&#10;</text>
<%end if %>
<text reverse="false" ul="false" em="true" color="color_1"/>
<text>TOTAL</text><text x="450"/><text><%=FormatNumber(objRds("ordertotal"),2)%>&#10;&#10;</text>
<text reverse="false" ul="false" em="false" color="color_1"/>
<%if objRds("notes")<>"" then%><text reverse="false" ul="false" em="true" color="color_1"/>
<text>Special Instructions&#10;</text>
<text reverse="false" ul="false" em="false" color="color_1"/>
<text>-----------&#10;</text>
<text align="left" />
<text><%=ReplaceSpecialCharacter(objRds("notes"))%>&#10;</text>
<%end if%>
<text align="left" />
<text dw="true" dh="true" />
<feed unit="12"/>
<cut type="feed"/>
<%
end if
    objRds.close()
    set objRds = nothing
    objCon.close()
    set objCon = nothing
end if
%>