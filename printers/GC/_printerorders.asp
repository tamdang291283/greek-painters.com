<%@Language=VBScript CodePage = 65001%>
<%
Session.CodePage = 65001
Response.charset ="utf-8"
Session.LCID     = 1033 'en-US
%>
<!-- #include file="../../Config.asp" -->
<%
   
session("restaurantid")=request.querystring("id")%>
<!-- #include file="../../timezone.asp" -->
<!-- #include file="../../restaurantsettings.asp" -->
<% 
   '   Response.Write("AAAAA" & SEND_ORDERS_TO_PRINTER)
  '  Response.end()
if SEND_ORDERS_TO_PRINTER="GC" then

dim filesys
dim tempStr, objCon, objRds
tempStr = ""
Const ForReading = 1, ForWriting = 2, ForAppending = 8
Dim objStream
Set objStream = CreateObject("ADODB.Stream")
objStream.Type= 2
objStream.CharSet = "utf-8"
objStream.Open

    Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 
	
	   objCon.Open sConnString
     objRds.Open "SELECT *  FROM view_paid_orders  WHERE IdBusinessDetail = " & request.querystring("id") & " and printed=0 ", objCon
	 
	 Do While NOT objRds.Eof
	 objStream.WriteText "#2*"
	 if objRds("DeliveryType")="c" then
	 objStream.WriteText "2*"
	 else
	 objStream.WriteText "1*"
	 end if
	 objStream.WriteText objRds("id") & "*"
	 
	 Set objCon2 = Server.CreateObject("ADODB.Connection")
	 Set objRds2 = Server.CreateObject("ADODB.Recordset") 
	 objCon2.Open sConnString
     objRds2.Open "select oi.*,mi.Name, mip.Name as PropertyName from ( OrderItems oi  inner join MenuItems mi on oi.MenuItemId = mi.Id )  left join MenuItemProperties mip on oi.MenuItemPropertyId = mip.Id where oi.OrderId = " & objRds("id"), objCon
	 
	 Do While NOT objRds2.Eof
	
	 objStream.WriteText objRds2("Qta") & ";" & CStr(objRds2("Name"))
	 if objRds2("PropertyName")<>"" then
	 objStream.WriteText " - " & objRds2("PropertyName")
	 end if
	 
	 If objRds2("dishpropertiesids") <> "" Then
						 
						dishpropertiessplit=split(objRds2("dishpropertiesids"),",")
					for i=0 to ubound(dishpropertiessplit)
					
					        dishpropertiessplit2=split(dishpropertiessplit(i),"|")	
					        Set objRds_dishpropertiesprice = Server.CreateObject("ADODB.Recordset") 					        
	                        objRds_dishpropertiesprice.Open "SELECT MenuDishproperties.ID, MenuDishproperties.dishproperty, MenuDishproperties.dishpropertyprice, MenuDishpropertiesGroups.dishpropertypricetype, MenuDishpropertiesGroups.dishpropertygroup FROM MenuDishproperties INNER JOIN MenuDishpropertiesGroups ON MenuDishproperties.dishpropertygroupid = MenuDishpropertiesGroups.ID where (((MenuDishproperties.ID)=" & dishpropertiessplit2(1)  & "))", objCon
                            if not objRds_dishpropertiesprice.EOF then
	                            objStream.WriteText "%%" & objRds_dishpropertiesprice("dishpropertygroup") & ":" & objRds_dishpropertiesprice("dishproperty")
                            end if
                            objRds_dishpropertiesprice.close()
                        set objRds_dishpropertiesprice =  nothing
					next
					end if
					
					toppingtext=""
					If objRds2("toppingids") <> "" Then 
						    Set objRds_toppingids = Server.CreateObject("ADODB.Recordset") 
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
                            objRds_toppingids.close()
                        set objRds_toppingids =  nothing

						        if toppingtext<>"" then
                                     if toppinggroup & "" = "" then
                                        toppinggroup = "Toppings"
                                    end if
							        toppingtext=left(toppingtext,len(toppingtext)-2)
						            objStream.WriteText "%%"&toppinggroup&": " & toppingtext 
						        end if
				    End If  
					
					objStream.WriteText  ";" & FormatNumber(objRds2("Total"), 2) & ";"
	 
	 
	 objRds2.MoveNext    
	 Loop
	    objRds2.close()
    set objRds2 =  nothing
'	  response.write  ";Date%%" &  FormatDateTime(objRds("orderdate"),2) & " " & FormatDateTime(objRds("orderdate"),4) & ";"
	 
'	 If objRds("DeliveryType") = "d" Then 
'	  response.write  ";Delivery%%" &  FormatDateTime(objRds("DeliveryTime"), 4) & ";"
'	 Else
'	 response.write  ";Collection%%" &  FormatDateTime(objRds("DeliveryTime"), 4) & ";"
	 
'	 End If 
	 
'	 response.write  ";" & objRds("DeliveryTime") & ";"
    if objRds("vouchercode") & "" <> "" Then
        if objRds("vouchercode") <> "Amount" then
            objStream.WriteText "*Discount Amount%%" & "-" & FormatNumber((( objRds("SubTotal") * 100 )/(100- Cdbl(Replace(Replace(Replace(objRds("vouchercodediscount"),"-",""),"%","")," ",""))) -  objRds("SubTotal") ),2) & "*" 
        else
            objStream.WriteText "*Discount Amount%%" & "-" & FormatNumber(Cdbl(Replace(Replace(Replace(objRds("vouchercodediscount"),"-",""),"%","")," ",""))),2) & "*" 
        end if
    End If
	 objStream.WriteText "*" & objRds("ShippingFee") & "*"
	 objStream.WriteText ";"
     objStream.WriteText "*Payment Surcharge%%" & objRds("PaymentSurcharge") & "*"
	 objStream.WriteText ";"
     objStream.WriteText "*Service Charge%%" & objRds("ServiceCharge") & "*"
	 objStream.WriteText ";"
    objStream.WriteText "*Tax%%" & objRds("Tax_Amount") & "*"
	 objStream.WriteText ";"
    objStream.WriteText "*Tip%%" & objRds("Tip_Amount") & "*"
	 objStream.WriteText ";"
	 objStream.WriteText objRds("ordertotal") & ";"
	 objStream.WriteText "5;"
	 objStream.WriteText objRds("firstname") & " " & objRds("lastname") & ";"
	 objStream.WriteText objRds("address") & " " & objRds("postalcode") & ";"
	 if objRds("asaporder") = "l" then
	 objStream.WriteText objRds("DeliveryTime") & ";"
	 else
	 objStream.WriteText "ASAP;"
	 end if
	 objStream.WriteText "0;"
	 'payment status needs setting
	 if objRds("paymenttype")="NoChex-Paid" or lcase(objRds("paymenttype"))="stripe-paid" or objRds("paymenttype")="Paypal-Paid"  or objRds("paymenttype")="Worldpay-Paid" or Ucase(objRds("Payment_status") & "")="PAID"  then
	objStream.WriteText "6;"
	 else
	 objStream.WriteText "7;"
	 end if
	 objStream.WriteText ";"
	objStream.WriteText objRds("phone") & ";"
	 objStream.WriteText "*" & objRds("notes") & "#"
	 objStream.WriteText vbCrLf 
    'objStream.WriteText vbCrLf
	 objRds.MoveNext    
Loop
    objRds.close()
    set objRds = nothing
    objCon.close()
    set objCon =  nothing
Dim textFileName
textFileName = "_printerorders.txt" 
 
If session("restaurantid") & "" <> "" Then
    textFileName = "_printerorders-" & session("restaurantid") & ".txt" 
End If
objStream.SaveToFile Server.MapPath(textFileName), 2
set objStream = nothing

If textFileName & "" <> "" Then
    server.transfer(textFileName)
Else
    server.transfer("_printerorders.txt")
End If

end if

'server.transfer("_printerorders2.asp")

%>

