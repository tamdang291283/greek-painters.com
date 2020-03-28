<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../../Config.asp" -->
<%
    session("restaurantid")=Request.QueryString("id_r")
     %>
<!-- #include file="../../timezone.asp" -->
<!-- #include file="../../restaurantsettings.asp" -->
<% 
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
    Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 

    Dim vRestaurantId
    dim vOrderId
     Dim sAverageDeliveryTime
    Dim sAverageCollectionTime
    
    vRestaurantId = Request.QueryString("id_r")
    vOrderId = Request.QueryString("id_o")
     WriteLog Server.MapPath("EpsonPostImageAndPrint.txt"),"PageName  = print_t.asp Start Page [Orderid] " & vOrderId  
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
        objCon.Close       
        
         objCon.Open sConnString
        objRds.Open "select * from [Orders]  " & _
            "where Id = " & vOrderId, objCon
      if Lcase(objRds("printed")) =  "true" AND 1=2 Then 
         objRds.Close
        objCon.Close    
        Set objRds = nothing
        set objCon = nothing
        Response.end()
    End If
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
        ServiceCharge = objRds("ServiceCharge")
        If ServiceCharge & "" = "" Then
            ServiceCharge = "0"
        End If
        vvouchercode = ""
        vvouchercodediscount = ""
        vvouchercodediscount = objRds("vouchercodediscount")
		vvouchercode=objRds("vouchercode")
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<meta charset="utf-8">
	<title>Order</title>
</head>

<style>
     <% if PrinterFontSizeRatio & "" <> "" Then %>
    .title-size {font-size:<%=36*PrinterFontSizeRatio%>px;}
    .heading-size {font-size:<%=34*PrinterFontSizeRatio%>px;}
    .item-size {font-size:<%=31*PrinterFontSizeRatio%>px;}
    .tb-item-size {font-size:<%=31*PrinterFontSizeRatio%>px;table-layout:fixed;}
    .big-printing-size {font-size:<%=51*PrinterFontSizeRatio%>px;}
    .tb-item-size  td {
        padding: 3px 0;
    }
    <% else %>
     .title-size {font-size:36px;}
    .heading-size {font-size:34px;}
    .item-size {font-size:31px;}
    .tb-item-size {font-size:31px;table-layout:fixed;}
    .big-printing-size {font-size:51px;}
     .tb-item-size  td {
        padding: 10px 0;
    }
    <% end if %>
     * {    
         font-family: Arial;
        }
</style>
<body style="width:512px;">
    <script type="text/javascript" src="../../windownform/js/jquery-1.7.1.min.js"></script>
 <div class="row">
        <div class="span12">
           <div align="center">
			<p class="title-size">Order <%=Request.QueryString("id_o")%> from <%= name %> </p></div>
        </div>
    </div>
	<div style="width: 492px;margin-left:auto;margin-right:auto;margin-bottom:30px;">
        <div class="">
           <div class="">
               <div align="center"> <img style="width: 86.4px;vertical-align: -3px;" src="../../images/<% If objRds("DeliveryType") = "d" Then %>Delivery<% Else %>Collection<% End If %>-order.png" style="vertical-align: middle;"> 
                   <p style="display: inline-block; margin: 0px; line-height: 100%;">
                   <span class="shop-name heading-size" style="border-bottom: 1px solid rgb(229, 229, 229); width: 100%; display: inline-block; padding-bottom: 10px;"><%if  objRds("PaymentType")="Paypal-Paid" or objRds("PaymentType")="NoChex-Paid" or objRds("PaymentType")="Worldpay-Paid" then  %><b>ORDER PAID</b><%else%><b>ORDER UNPAID</b><%end if%></span> 
                       <span style="display: block;padding-top: 10px;font-family: font-family;font-weight: bold;font-size:24px;">
                           <% if objRds("asaporder") = "n" then%> 
                            [ASAP]
                           <%else %>
                           [<%response.write(FormatDateTime(objRds("DeliveryTime"),2))%> / <%response.write(FormatDateTime(objRds("DeliveryTime"),4) )%>]
                           <%end if %>

                       </span>
                    </p>

               </div>
            </div>
        </div>
    </div>
	<% If ShowRestaurantDetailOnReceipt & "" = "true" Then %>
	   <div style="width: 492px;margin-left:auto;margin-right:auto;" class="item-size">
        <div class="">
           <div class="shop-info">
                <span class="shop-name"><%=name %></span><br />
                <span class="shop-address"><%=address%></span><br />
                <span class="shop-name">Tel. <%=telephone %></span><br />                       
                <span class="shop-address">Email: <%=email %></span><br /><br />
            </div>
        </div>
    </div>
	<% end If %>
	


    <div style="width: 492px; clear:both;margin-left:auto;margin-right:auto" class="item-size">
<div class="heading-size" style="   display: block;width: 100%;padding: 0;margin-bottom: 3px; line-height: inherit;color: #333;border: 0; border-bottom: 1px solid #e5e5e5; font-weight:bolder;">
                Customer Details
            </div>
			
            <%= objRds("FirstName") %>&nbsp;<%= objRds("LastName") %><br />
            <%= objRds("Address") %>,&nbsp;<%= objRds("PostalCode") %><br />
            <%= objRds("Phone") %><br />
            <%= objRds("Email") %>
            <% If objRds("DeliveryLat") & "" <> "" Then %>
            <br />Lat/Long: <%= objRds("DeliveryLat") & "," & objRds("DeliveryLng")%>
            <br />GPS: <%=Latitude_DMS(objRds("DeliveryLat")) & " ," & Longitude_DMS(objRds("DeliveryLng")) %>
            <% End If %>
            <br />
           
               
                
  
    </div>
    <br />

    <br />
          
    

    
   
    
  
        
    <div style="width: 492px;margin-left:auto;margin-right:auto;" class="item-size">
  <div class="heading-size" style="   display: block;width: 100%;padding: 0;margin-bottom: 3px; line-height: inherit;color: #333;border: 0; border-bottom: 1px solid #e5e5e5;font-weight:bolder;">Order Details</div>

Order Number: <%=Request.QueryString("id_o")%>


<br>
			
			 Order Time: <%response.write(FormatDateTime(objRds("orderdate"),2))%>&nbsp;<%response.write(FormatDateTime(objRds("orderdate"),4) )%>
<br />
           Order Type: <% If objRds("DeliveryType") = "d" Then %>Delivery<% Else %>Collection<% End If %>
              
				<br>Requested for:&nbsp;<%if objRds("asaporder") = "n" then%>
				    <%if objRds("DeliveryType") = "c" then
                        dim requestfor : requestfor =  DateAdd("n",vaveragecol,objRds("orderdate"))
                        %><%=FormatDateTime(requestfor,2)%>&nbsp;<%=FormatDateTime(requestfor,4)%>
				   <%else%>
				   ASAP
				   <%end if%>
                   <%else%><%= FormatDateTime(objRds("DeliveryTime"), 2) %>&nbsp;<%= FormatDateTime(objRds("DeliveryTime"), 4) %><%end if%><br>
				
<%if objRds("asaporder") = "n" then
if objRds("DeliveryType") = "d" then
mintoadd=vaveragedel '+ 5 ' Add + 5 to match with front end
else
mintoadd=vaveragecol '+ 5 ' Add + 5 to match with front end
end if
    dim acceptedfor : acceptedfor = DateAdd("n",mintoadd,objRds("orderdate"))
%>
Accepted for:&nbsp;<%=FormatDateTime(acceptedfor,2)%>&nbsp;<%=FormatDateTime(acceptedfor,4)%>
<br>
<%end if%>
          

          
			
			<div style="border-bottom: 1px solid #e5e5e5;width: 100%;">
			Payment Status:&nbsp;<%if  objRds("PaymentType")="Paypal-Paid" or  objRds("PaymentType")="NoChex-Paid" or  objRds("PaymentType")="Worldpay-Paid" then  %>ORDER PAID<%else%>ORDER UNPAID<%end if%></div><br>
<br>
  <%notes=objRds("Notes")
        objRds.Close
        objCon.Close
     %>
        <%
                
            objCon.Open sConnString
            objRds.Open "select oi.*," & _
                    "mi.Name, mip.Name as PropertyName,mip.printingname as Propertyprintingname, mi.PrintingName " & _
                    "from ( OrderItems oi " & _
                    "inner join MenuItems mi on oi.MenuItemId = mi.Id ) " & _
                    "left join MenuItemProperties mip on oi.MenuItemPropertyId = mip.Id " & _
                    "where oi.OrderId = " & vOrderId, objCon


        if objRds.Eof then %>
    
            No Items In Your Order.

        <% 
            objRds.Close
            objCon.Close

        else 
            Dim namePrintingMode
            namePrintingMode = Request.QueryString("mod")
            
            %>

               
                <table style="width: 100%;" class="item-size">  

                 <%
                    Do While NOT objRds.Eof  %>
                            <tr>
                                <% 
                                 
                                    if  namePrintingMode & "" = "printingname" then  %>
                                
                                <td style="width:15%; vertical-align: text-top;">   <span class="big-printing-size"><%=objRds("Qta") %> </span> x     &nbsp;</td>
                                <% else %>
                                 <td style="width:15%; vertical-align: text-top;text-top;">   <%= objRds("Qta") %>  x  &nbsp;</td>
                                <% end if %>

                                <% If namePrintingMode & "" = "" then  %>
                                <td style="vertical-align: text-top;text-top;width:60%;">  <%= objRds("Name") %> <% If objRds("PrintingName") & "" <> "" Then %> <br /><span class="big-printing-size"><%=objRds("PrintingName") %></span><% End If %>
                                      <% if objRds("PropertyName")  & "" <> "" then %>
                                    <br /> <%= objRds("PropertyName") %> 
                                     <%end if %>

                                  
						         <% elseIf namePrintingMode & "" = "dishname" then  %>    
                                 <td style="vertical-align: text-top;width:60%;">  <%= objRds("Name") %> 
                                     <% if objRds("PropertyName")  & "" <> "" then %>
                                    <br /> <%= objRds("PropertyName") %> 
                                     <%end if %>
                                <% elseif  namePrintingMode & "" = "printingname" then  %>
                                  <td  style="vertical-align: text-top;text-top;width:60%;">  <span class="big-printing-size"><%=objRds("PrintingName") %></span>
                                       <% if objRds("Propertyprintingname") & "" <> "" then  %> 
                                        <br /><span  class="big-printing-size"> <%= objRds("Propertyprintingname") %> </span>
                                      <% elseif objRds("PropertyName")  & "" <> "" then %>
                                      
                                    <br /><span> <%= objRds("PropertyName") %> </span>
                                     <%end if %>
                                <% end if %>  

						<%
						'display toppings in basket area
						If objRds("dishpropertiesids") <> "" Then
						 
						dishpropertiessplit=split(objRds("dishpropertiesids"),",")
					for i=0 to ubound(dishpropertiessplit)
					
					dishpropertiessplit2=split(dishpropertiessplit(i),"|")
					
					Set objCon_dishpropertiesprice = Server.CreateObject("ADODB.Connection")
					Set objRds_dishpropertiesprice = Server.CreateObject("ADODB.Recordset") 
					objCon_dishpropertiesprice.Open sConnString
	                objRds_dishpropertiesprice.Open "SELECT MenuDishproperties.ID, MenuDishproperties.dishproperty, MenuDishproperties.printingname as dishpropertyPrintingname, MenuDishproperties.dishpropertyprice, MenuDishpropertiesGroups.dishpropertypricetype, MenuDishpropertiesGroups.dishpropertygroup, MenuDishpropertiesGroups.printingname as dishpropertygroupPrintingname FROM MenuDishproperties INNER JOIN MenuDishpropertiesGroups ON MenuDishproperties.dishpropertygroupid = MenuDishpropertiesGroups.ID where (((MenuDishproperties.ID)=" & dishpropertiessplit2(1)  & "))", objCon
                    if not objRds_dishpropertiesprice.EOF then
                             dim dishpropertygroup : dishpropertygroup = objRds_dishpropertiesprice("dishpropertygroup") & "" 
                             dim dishproperty : dishproperty = objRds_dishpropertiesprice("dishproperty") & "" 
                                 if  namePrintingMode & "" = "printingname" then
                                        if objRds_dishpropertiesprice("dishpropertygroupPrintingname") & "" <> "" then
                                                 dishpropertygroup = objRds_dishpropertiesprice("dishpropertygroupPrintingname") & "" 
                                        end if
                             
                                        if objRds_dishpropertiesprice("dishpropertyPrintingname") & "" <> "" then
                                                 dishproperty = objRds_dishpropertiesprice("dishpropertyPrintingname") & "" 
                                        end if
                                end if
					response.write "<BR> <small>" & dishpropertygroup & ":" & dishproperty & "</small>"
                    end if
					
					
					
					next
					end if%>
						
						
						<%
						toppingtext=""
						If objRds("toppingids") <> "" Then 
						Set objCon_toppingids = Server.CreateObject("ADODB.Connection")
								Set objRds_toppingids = Server.CreateObject("ADODB.Recordset") 
          
								objCon_toppingids.Open sConnString
                objRds_toppingids.Open "SELECT * FROM MenuToppings where id in (" & objRds("toppingids") & ")", objCon
				        Do While NOT objRds_toppingids.Eof 
                         dim topping : topping =  objRds_toppingids("topping")
                             if  namePrintingMode & "" = "printingname" and objRds_toppingids("printingname") & "" <> ""  then
                                 topping =  objRds_toppingids("printingname")
                             end if

						toppingtext = toppingtext & topping & ", "
						objRds_toppingids.MoveNext
						loop
						if toppingtext<>"" then
							toppingtext=left(toppingtext,len(toppingtext)-2)
						    response.write "<small><br>Toppings: " & toppingtext & "</small>"
						end if
						 End If %>
						</td>
                                <td style="padding-right: 20px; text-align: right;width:25%;" valign="top"><%=CURRENCYSYMBOL%><%= FormatNumber(objRds("Total"), 2) %></td>                                    
                            </tr>
                    <%  
                        objRds.MoveNext        
                    Loop 
    
                    objRds.Close
                    objCon.Close

                    %>
     
                        <tr>
                         <td style="padding-top: 5px">&nbsp;</td>
                        <td style="padding-top: 5px">&nbsp;</td>
                        <td style="padding-top: 5px">&nbsp;</td>
                    </tr>
                        <%if vvouchercode<>"" then%>
					<tr>
                        <td colspan="2" style="padding-top: 5px; text-align: right; border-top: 1px dotted black;">Discount code:&nbsp;<br /> <%=vvouchercode%> (-<%=vvouchercodediscount%>%)&nbsp; </td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right; border-top: 1px dotted black;">-<%=CURRENCYSYMBOL%><%= FormatNumber((( vSubTotal * 100 )/(100- Cdbl(Replace(Replace(Replace(vvouchercodediscount,"-",""),"%","")," ",""))) - vSubTotal ),2) %> </td>
                    </tr>
					<%end if%>
                        <tr>
                        <td colspan="2" style="padding-top: 5px; text-align: right; border-top: 1px dotted black;">SubTotal:</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right; border-top: 1px dotted black;"><%=CURRENCYSYMBOL%><%= FormatNumber(vSubTotal, 2)  %></td>
                    </tr>       
                    <% If Cdbl(vShippingFee) > 0 Then %>    
                    <tr>
                        <td colspan="2" style="padding-top: 5px; text-align: right;">Delivery Fee:</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right;"><%=CURRENCYSYMBOL%><%= FormatNumber(vShippingFee, 2)  %></td>
                    </tr>       
                    <% End If %>
                     <%if  Cdbl(PaymentSurcharge) > 0 then  %>
					<tr>
                         <td colspan="2" style="padding-top: 5px; text-align: right;">Credit card surcharge:</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right;"><%=CURRENCYSYMBOL%><%= FormatNumber(PaymentSurcharge, 2)  %></td>
                      
                    </tr>
					<%end if%>     
                      <%if  Cdbl(ServiceCharge) > 0 then  %>
					<tr>
                        <td colspan="2" style="padding-top: 5px; text-align: right;">Service charge:</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right;"><%=CURRENCYSYMBOL%><%= FormatNumber(ServiceCharge, 2)  %></td>                      
                     </tr>
					<%end if%> 
                    <tr>
                        <td colspan="2" style="padding-top: 5px;text-align: right;"><b>Total:</b></td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right;"><b><%=CURRENCYSYMBOL%><%= FormatNumber(vOrderTotal, 2)  %></b></td>
                    </tr>    
                </table>
          
            <% End If %>  
       	
		
		  <% If notes <> "" Then %>
      <div style="width: 512px;margin-left:auto;margin-right:auto;" class="item-size">
            <div class="heading-size" style="   display: block;width: 100%;padding: 0;margin-bottom: 3px; line-height: inherit;color: #333;border: 0; border-bottom: 1px solid #e5e5e5;font-weight:bolder;">Special instructions:</div>
               <%= (replace(notes,chr(13),"<br />")) %>
                        
        </div>
    <% End If %>                
	</div>
	<% Set objRds = nothing
        Set objCon= nothing     
      
        WriteLog Server.MapPath("EpsonPostImageAndPrint.txt"),"PageName  = print_t.asp End Page [Orderid] " & vOrderId  
              %>
	</body>
</html>
