<!-- #include file="../Config.asp" --><% 
    If request.querystring("id") & "" <> "" Then
        session("restaurantid")=request.querystring("id")
        
    End IF 
    Session("TempPOID") = 2866
    session("restaurantid") = 2
    Session("PrintJobId") = "2-2866-local_printer-1-PN"
     dim PrintJobId : PrintJobId =Session("PrintJobId")
   
 %>
<!-- #include file="../timezone.asp" -->
<!-- #include file="../restaurantsettings.asp" --><%
Function ReplaceSpecialCharacter(sInput)
    Dim sOutput
    sOutput = Replace(sInput,"&","&amp;")
    sOutput = Replace(sOutput,"<","&lt;")
    sOutput = Replace(sOutput,">","&gt;")
    sOutput = Replace(sOutput,"'","&apos;")
    sOutput = Replace(sOutput,"""","&quot;")
    ReplaceSpecialCharacter = sOutput
End Function 

Dim tempOrderId, tempRestaurantId, tempPrinterID 
tempOrderId = Session("TempPOID")
tempRestaurantId = session("restaurantid")
tempPrinterID = Session("Printer_ID")
dim fs,f
set fs=Server.CreateObject("Scripting.FileSystemObject") 
set f=fs.OpenTextFile(server.mappath("dump.txt"),8, true)

For Each sItem In Request.Form
    f.write(sItem)
    f.write(" - [" & Request.Form(sItem) & "]" & vbCrLf)
  Next
     f.write("---------------------------------" & vbCrLf)


if request.form("ConnectionType")="SetResponse" then

f.write("SetResponse" & vbCrLf)

xml=request.form("ResponseFile")


s1=instr(xml,"<printjobid>")
lll=len(xml)-s1-11
r=right(xml,lll)
s2=instr(r,"</printjobid>")
nodeid=left(r,s2-1)

f.write("------- printjob id = " &  nodeid & "--------------------------" & vbCrLf)

	if instr(xml,"true") then
   

   
  f.write("------- success = true for id = " &  nodeid & "--------------------------" & vbCrLf)

     Set objCon2 = Server.CreateObject("ADODB.Connection")

  Set objRds2 = Server.CreateObject("ADODB.Recordset") 
	
	 
objCon2.Open sConnString
objRds2.Open "SELECT * FROM [Orders] WHERE Id = " & nodeid, objCon2, 1, 3 
 objRds2("printed") = -1

objRds2.Update 
    
     
objRds2.Close
objCon2.Close 
   
	
	end if
	
else

  f.close
  set f=nothing
set fs=nothing
   
if SEND_ORDERS_TO_PRINTER="EPSON" then
ooo=""
    Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 
	 objCon.Open sConnString
    Dim sQuery
     If Session("TempPOID") & "" <> "" Then
        sQuery = "SELECT *  FROM orders  WHERE ID = " & Session("TempPOID") & " AND  IdBusinessDetail = " & session("restaurantid") & "  and (paymenttype='NoChex-Paid' or paymenttype='Paypal-Paid' or paymenttype='Worldpay-Paid' or paymenttype='Cash on Delivery')"        
   
        objRds.Open sQuery, objCon
        Session("TempPOID") = ""
    Else
        sQuery = "SELECT *  FROM orders  WHERE IdBusinessDetail = " & session("restaurantid") & "   and (paymenttype='NoChex-Paid' or paymenttype='Paypal-Paid' or paymenttype='Worldpay-Paid' or paymenttype='Cash on Delivery')"
        objRds.Open sQuery, objCon
    End If
       
	 if NOT objRds.Eof then

	  Set objCon20 = Server.CreateObject("ADODB.Connection")
    Set objRds20 = Server.CreateObject("ADODB.Recordset") 
	 objCon20.Open sConnString
    objRds20.Open "SELECT * FROM BusinessDetails WHERE Id = " & session("restaurantid"), objCon 
	name=objRds20("Name")
	address= objRds20("Address") 
	telephone=objRds20("telephone") 
	email=  objRds20("email") 
	vaveragedel = objRds20("AverageDeliveryTime")
	vaveragecol = objRds20("AverageCollectionTime")
	 
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
	 'response.write objRds("id") & "*"
	 
	 Set objCon2 = Server.CreateObject("ADODB.Connection")
	 Set objRds2 = Server.CreateObject("ADODB.Recordset") 
	 objCon2.Open sConnString
     objRds2.Open "select oi.*,mi.Name, mip.Name as PropertyName, mi.PrintingName from ( OrderItems oi  inner join MenuItems mi on oi.MenuItemId = mi.Id )  left join MenuItemProperties mip on oi.MenuItemPropertyId = mip.Id where oi.OrderId = " & objRds("id"), objCon
	 oooo=""
	Do While NOT objRds2.Eof
         if instr(PrintJobId,"PN") > 0 then
              dim dishname : dishname = objRds2("Name")
              If objRds2("PrintingName") & "" <> "" Then
                    dishname = objRds2("PrintingName")
              end if               
    
            oooo=oooo & "<text>&#10;</text><text width=""2"" height=""2""/><text reverse=""false"" ul=""false"" em=""false"" color=""color_1""/> <text lang=""zh-cn"" /><text>" & objRds2("Qta") & " x " &  ReplaceSpecialCharacter(dishname) &"</text><text width=""1"" height=""1""/><text lang=""en"" /><text>"
         else
            oooo=oooo & "<text>&#10;</text><text width=""1"" height=""1""/><text reverse=""false"" ul=""false"" em=""false"" color=""color_1""/><text>" & objRds2("Qta") & " x " & ReplaceSpecialCharacter(objRds2("Name")) &"</text><text width=""1"" height=""1""/><text>"
         end if

'calc no. of tabs
ttabs=""
'texttocheck=objRds2("Qta") & " x " & objRds2("Name")
'if len(texttocheck)<=7 then
'ttabs="&#9;&#9;&#9;&#9;"
'end if
'if len(texttocheck)>7 and  len(texttocheck)<=15 then
'ttabs="&#9;&#9;&#9;"
'end if
'if len(texttocheck)>15 and  len(texttocheck)<=23 then
'ttabs="&#9;&#9;"
'end if
'if len(texttocheck)>23 and  len(texttocheck)<=30 then
'ttabs="&#9;"
'end if
'if len(texttocheck)>30 then
ttabs="&#10;&#9;&#9;&#9;&#9;"
'end if

oooo=oooo & ttabs &  FormatNumber(objRds2("Total"), 2) & "&#10;</text>"
	 'response.write objRds2("Qta") & ";" &objRds2("Name")  
	 if objRds2("PropertyName")<>"" then
	 oooo=oooo & "<text>" & ReplaceSpecialCharacter(objRds2("PropertyName")) &"&#10;</text>"
	 'response.write " - " & objRds2("PropertyName")
	 end if
	 
	 If objRds2("dishpropertiesids") <> "" Then
						 
						dishpropertiessplit=split(objRds2("dishpropertiesids"),",")
					for i=0 to ubound(dishpropertiessplit)
					
					dishpropertiessplit2=split(dishpropertiessplit(i),"|")
					
					Set objCon_dishpropertiesprice = Server.CreateObject("ADODB.Connection")
					Set objRds_dishpropertiesprice = Server.CreateObject("ADODB.Recordset") 
					objCon_dishpropertiesprice.Open sConnString
	                objRds_dishpropertiesprice.Open "SELECT MenuDishproperties.ID, MenuDishproperties.dishproperty, MenuDishproperties.dishpropertyprice, MenuDishpropertiesGroups.dishpropertypricetype, MenuDishpropertiesGroups.dishpropertygroup FROM MenuDishproperties INNER JOIN MenuDishpropertiesGroups ON MenuDishproperties.dishpropertygroupid = MenuDishpropertiesGroups.ID where (((MenuDishproperties.ID)=" & dishpropertiessplit2(1)  & "))", objCon
if not objRds_dishpropertiesprice.EOF then
oooo=oooo & "<text>" & ReplaceSpecialCharacter(objRds_dishpropertiesprice("dishpropertygroup")) & "</text><text>&#9;&#9;&#9;" & ReplaceSpecialCharacter(objRds_dishpropertiesprice("dishproperty")) & "&#10;</text>"
					'response.write "%%" & objRds_dishpropertiesprice("dishpropertygroup") & ":" & objRds_dishpropertiesprice("dishproperty")
end if
					
					
					
					next
					end if
					
					toppingtext=""
					If objRds2("toppingids") <> "" Then 
						Set objCon_toppingids = Server.CreateObject("ADODB.Connection")
								Set objRds_toppingids = Server.CreateObject("ADODB.Recordset") 
          
								objCon_toppingids.Open sConnString
                objRds_toppingids.Open "SELECT * FROM MenuToppings where id in (" & objRds2("toppingids") & ")", objCon
				Do While NOT objRds_toppingids.Eof 
						toppingtext = toppingtext & objRds_toppingids("topping") & ", "
						objRds_toppingids.MoveNext
						loop
						if toppingtext<>"" then
							toppingtext=left(toppingtext,len(toppingtext)-2)
						'response.write "%%Toppings: " & toppingtext 
						oooo=oooo & "<text>Toppings&#9;&#9;" & ReplaceSpecialCharacter(toppingtext) & "&#10;</text>"
						end if
						 End If  
					
					'response.write  ";" & FormatNumber(objRds2("Total"), 2) & ";"
	 
	 
	 objRds2.MoveNext    
	 Loop
	 
	
	
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
            
                    plaintextTemplate = replace(plaintextTemplate,"[ORDERTIME]", FormatDateTime(objRds("orderdate"), 2) & "&#160;" & FormatDateTime(objRds("orderdate"), 4) )
                    dim requestfor 
                    if objRds("asaporder") = "n" then
                        if objRds("DeliveryType") = "c" then
                             requestfor = DateAdd("n",vaveragecol,objRds("orderdate"))  
                        else
                            requestfor ="ASAP"
                        end if
                    else
                        requestfor = FormatDateTime(objRds("DeliveryTime"), 2) & "&#160;" & FormatDateTime(objRds("DeliveryTime"), 4) 
                    end if
                    dim paymentstatus 
                    if  objRds("PaymentType")="Paypal-Paid" or objRds("PaymentType")="NoChex-Paid" or objRds("PaymentType")="Worldpay-Paid" then
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
<text reverse="false" ul="false" em="false" color="color_1"/>
<text><%=ReplaceSpecialCharacter(name)%>&#10;</text>
<text><%=ReplaceSpecialCharacter(address)%>&#10;</text>
<text>Tel. <%=telephone%>&#10;</text>
<text>Email: <%=email%>&#10;&#10;</text>
 <text align="left" /> 
<text reverse="false" ul="false" em="true" color="color_1"/>
<text>Customer Details&#10;</text>
 <text align="center" /> 
<text reverse="false" ul="false" em="false" color="color_1"/>
<text>-----------&#10;</text>
<text align="left" />
<text dw="false" dh="false" />
<text><%=ReplaceSpecialCharacter(objRds("firstname"))%>&#160;<%=ReplaceSpecialCharacter(objRds("lastname"))%>&#10;</text>
<text><%=ReplaceSpecialCharacter(objRds("address"))%>,&#10;</text>
<text><%=ReplaceSpecialCharacter(objRds("postalcode"))%>&#10;</text>
<text>Phone: <%=objRds("phone")%>&#10;&#10;</text><% If objRds("DeliveryLat") & "" <> "" Then %>
<text>Lat/Long: <%= objRds("DeliveryLat") & "," & objRds("DeliveryLng")%>&#10;</text>
<text>GPS: <%=Latitude_DMS(objRds("DeliveryLat")) & " ," & Longitude_DMS(objRds("DeliveryLng")) %>&#10;</text>
<% End If %><text align="left" />
<text reverse="false" ul="false" em="true" color="color_1"/>
<text>Order Details&#10;</text>
<text align="center" />
<text reverse="false" ul="false" em="false" color="color_1"/>
<text>-----------&#10;</text>
<text align="left" />
<text>Order Number: <%=objRds("id")%> &#10;</text>
<text>Order Time: <%response.write(FormatDateTime(objRds("orderdate"),2))%>&#160;<%response.write(FormatDateTime(objRds("orderdate"),4) )%>&#10;</text>
<text>Order Type: <% If objRds("DeliveryType") = "d" Then %>Delivery<% Else %>Collection<% End If %>&#10;</text>
<text>Requested for:  <%if objRds("asaporder") = "n" then%>  <%if objRds("DeliveryType") = "c" then%><%=DateAdd("n",vaveragecol,objRds("orderdate"))%><%else%>ASAP<%end if%><%else%><%= FormatDateTime(objRds("DeliveryTime"), 2) %>&#160;<%= FormatDateTime(objRds("DeliveryTime"), 4) %><%end if%>&#10;</text>
<text><%if objRds("asaporder") = "n" then
if objRds("DeliveryType") = "d" then
mintoadd=vaveragedel '+ 5
else
mintoadd=vaveragecol '+ 5
end if
%>Accepted to: <%=DateAdd("n",mintoadd,objRds("orderdate"))%>&#10;<%end if%></text>
<text>Payment Status: <%if  objRds("PaymentType")="Paypal-Paid" or objRds("PaymentType")="NoChex-Paid" or objRds("PaymentType")="Worldpay-Paid" then  %>ORDER PAID
<%else%>ORDER UNPAID<%end if%></text>
<text align="center" />
<text>&#10;&#10;</text>
<text align="left" />
<%=oooo%><text>&#10;</text>
<text align="center" />
<text>-----------&#10;</text>
<text align="left" />
<%if objRds("vouchercode")<>"" then%><text>Discount code:&#9;&#9;&#9;<%=ReplaceSpecialCharacter(objRds("vouchercode"))%> - <%=ReplaceSpecialCharacter(objRds("vouchercodediscount"))%>%&#10;</text>				
<%end if%><text>SubTotal:&#9;&#9;&#9;<%if objRds("SubTotal")<10 then%>0<%end if%><%= FormatNumber(objRds("SubTotal"), 2)  %>&#10;</text>
<text>Delivery Fee:&#9;&#9;&#9;<%if objRds("ShippingFee")<10 then%>0<%end if%><%= FormatNumber(objRds("ShippingFee"), 2)  %>&#10;</text>
<text reverse="false" ul="false" em="true" color="color_1"/>
<text>TOTAL&#9;&#9;&#9;&#9;<%=FormatNumber(objRds("ordertotal"),2)%>&#10;&#10;</text>
<text reverse="false" ul="false" em="false" color="color_1"/>
<%if objRds("notes")<>"" then%><text align="center" />
<text reverse="false" ul="false" em="true" color="color_1"/>
<text>Special Instructions&#10;</text>
<text reverse="false" ul="false" em="false" color="color_1"/>
<text>-----------&#10;</text>
<text align="left" />
<text><%=ReplaceSpecialCharacter(objRds("notes"))%>&#10;</text>
<%end if%><text align="left" />
<text dw="true" dh="true" />
<feed unit="12"/>
<cut type="feed"/>
</epos-print>
</PrintData>
</ePOSPrint>
</PrintRequestInfo><%
end if
end if
end if



%>