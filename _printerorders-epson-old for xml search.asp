<?xml version="1.0" encoding="utf-8"?>
<!-- #include file="Config.asp" --><%session("restaurantid")=request.querystring("id")%><!-- #include file="timezone.asp" -->
<!-- #include file="restaurantsettings.asp" -->

<%
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
Set objXML = Server.CreateObject("Microsoft.XMLDOM")
objXML.LoadXML (xml)
'etc'

Dim nodes
set nodes = objXML.selectNodes("//PrintResponseInfo/ePOSPrint/Parameter/")

For each node in nodes
if node.nodename="printjobid" then
f.write("printjobid" & vbCrLf)

	if instr(xml,"success=""true""") then
   
   f.write("true" & vbCrLf)
     Set objCon2 = Server.CreateObject("ADODB.Connection")

  Set objRds2 = Server.CreateObject("ADODB.Recordset") 
	
	 
objCon2.Open sConnString
objRds2.Open "SELECT * FROM [Orders] WHERE Id = " & node.text, objCon, 1, 3 
 objRds2("printed") = -1

objRds2.Update 
    
     
objRds2.Close
objCon2.Close 
   
	
	end if
	end if

Next

end if

  f.close
  set f=nothing
set fs=nothing

%>

<% if SEND_ORDERS_TO_PRINTER="EPSON" then
ooo=""
%>
<PrintRequestInfo Version="2.00">
<%
    Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 
	
	   objCon.Open sConnString
     objRds.Open "SELECT *  FROM orders  WHERE  IdBusinessDetail = " & request.querystring("id") & " and printed=0 and (paymenttype='NoChex-Paid' or paymenttype='Paypal-Paid' or paymenttype='Worldpay-Paid' or paymenttype='Cash on Delivery')", objCon
	 
	 Do While NOT objRds.Eof
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
     objRds2.Open "select oi.*,mi.Name, mip.Name as PropertyName from ( OrderItems oi  inner join MenuItems mi on oi.MenuItemId = mi.Id )  left join MenuItemProperties mip on oi.MenuItemPropertyId = mip.Id where oi.OrderId = " & objRds("id"), objCon
	 
	Do While NOT objRds2.Eof
oooo=oooo & "<text>&#10;</text><text width=""1"" height=""1""/><text reverse=""false"" ul=""false"" em=""false"" color=""color_1""/><text>" & objRds2("Qta") & " x " & replace(objRds2("Name"),"&","&amp;") &"</text><text>"

'calc no. of tabs
ttabs=""
if len(replace(objRds2("Name"),"&","&amp;"))<9 then
ttabs="&#9;&#9;&#9;"
end if
if len(replace(objRds2("Name"),"&","&amp;"))>=9 and  len(replace(objRds2("Name"),"&","&amp;"))<17 then
ttabs="&#9;&#9;"
end if
if len(replace(objRds2("Name"),"&","&amp;"))>=17 and  len(replace(objRds2("Name"),"&","&amp;"))<25 then
ttabs="&#9;"
end if

oooo=oooo & ttabs &  "</text><text>&#9;" & FormatNumber(objRds2("Total"), 2) & "&#10;</text>"
	 'response.write objRds2("Qta") & ";" &objRds2("Name")  
	 if objRds2("PropertyName")<>"" then
	 oooo=oooo & "<text>" & objRds2("PropertyName") &"&#10;</text>"
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
oooo=oooo & "<text>" & replace(objRds_dishpropertiesprice("dishpropertygroup"),"&","&amp;") & "</text><text>&#9;&#9;&#9;" & replace(objRds_dishpropertiesprice("dishproperty"),"&","&amp;") & "&#10;</text>"
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
						oooo=oooo & "<text>Toppings&#9;&#9;" & replace(toppingtext,"&","&amp;") & "&#10;</text>"
						end if
						 End If  
					
					'response.write  ";" & FormatNumber(objRds2("Total"), 2) & ";"
	 
	 
	 objRds2.MoveNext    
	 Loop
	 
	 
	 
	 %>
	 <ePOSPrint>
    <Parameter>
      <devid>local_printer</devid>
      <timeout>10000</timeout>
	  <printjobid><%=objRds("id")%></printjobid>
    </Parameter>
    <PrintData>
      <epos-print xmlns="http://www.epson-pos.com/schemas/2011/03/epos-print">
        <text lang="en"/>
        <text smooth="true"/>
        <text align="center"/>
        <feed unit="30"/>
		<text lang="en" />
<text smooth="true" />
<text align="center" />
<text font="font_a" />
<text dw="true" dh="true" />
<text>Receipt &#10;</text>
<text dw="false" dh="false" />	
<text align="center" />
<text>-----------&#10;</text>
<text align="center" />
<text>Order Date &#10;</text>
<text><%response.write(FormatDateTime(objRds("orderdate"),2))%>&#9; <%response.write(FormatDateTime(objRds("orderdate"),4) )%> &#10;</text>



<text><%=deliverytype%> &#10;</text>
<text><%=objRds("DeliveryTime")%> &#10;</text>


<% If objRds("DeliveryType") = "d" Then %>
<text>Average Delivery Time: <%=sAverageDeliveryTime%> minutes&#10;</text>
                  
                <% Else %>
				<text> Average Collection Time:  <%=sAverageCollectionTime%> &#10;</text>
           
                <% End If %>

<text align="center" />
<text>-----------&#10;</text>
<text align="center" />
<text dw="false" dh="false" />
<text>Order <%=objRds("id")%> &#10; </text>
<text align="center" />
<text>-----------&#10;</text>
<text><%if  objRds("PaymentType")="Paypal-Paid" or objRds("PaymentType")="NoChex-Paid" or objRds("PaymentType")="Worldpay-Paid" then  %>ORDER PAID&#10;<%else%>ORDER UNPAID&#10;<%end if%> </text>
<text dw="false" dh="false" />
<text align="center" />

<text>-----------&#10;</text>
<text align="left" />
<%=oooo%> 
<text>&#10;</text>

<%if objRds("notes")<>"" then%>
<text align="center" />
<text>-----------&#10;</text>
<text align="left" />
<text>Notes&#9;&#9;<%=objRds("notes")%>&#10;</text>
<%end if%>
<text align="center" />
<text>-----------&#10;</text>
<text align="center" />
<text dw="false" dh="false" />
<text><%=objRds("firstname")%>&#10;<%=objRds("lastname")%>&#10;</text>

<text><%=objRds("address")%>&#10;</text>
<text><%=objRds("postalcode")%>&#10;</text>
<text>Phone: <%=objRds("phone")%>&#10;</text>

<text align="center" />
<text>-----------&#10;</text>
<text>TOTAL <%=FormatNumber(objRds("ordertotal"),2)%>&#10;</text>
<text align="left" />
<text dw="true" dh="true" />
<feed unit="12"/>
<cut type="feed"/>
		
		
		
		
    
      </epos-print>
    </PrintData>
  </ePOSPrint>

	 

<%'    Set objCon2 = Server.CreateObject("ADODB.Connection")
'    Set objRds2 = Server.CreateObject("ADODB.Recordset") 
	
	 
'objCon2.Open sConnString
'objRds2.Open "SELECT * FROM [Orders] WHERE Id = " & objRds("id"), objCon, 1, 3 
' objRds2("printed") = -1

'objRds2.Update 
    
     
'objRds2.Close
'objCon2.Close 

	 objRds.MoveNext    
Loop%>
</PrintRequestInfo><%
end if



%>