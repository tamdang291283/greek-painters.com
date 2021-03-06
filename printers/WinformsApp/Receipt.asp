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
        
        Dim PaymentSurcharge, ServiceCharge, vvouchercode, vvouchercodediscount,VoucherDiscountType
        PaymentSurcharge = objRds("PaymentSurcharge")
        If PaymentSurcharge & "" = "" Then
            PaymentSurcharge = "0"
        End If
        ServiceCharge = objRds("ServiceCharge")
        If ServiceCharge & "" = "" Then
            ServiceCharge = "0"
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
        vvouchercode = ""
        vvouchercodediscount = ""
        vvouchercodediscount = objRds("vouchercodediscount")
		vvouchercode=objRds("vouchercode")
        VoucherDiscountType = objRds("DiscountType")
        dim numberOfOrder : numberOfOrder  = 0
            if Show_Ordernumner_printer = "yes" then
                Set objRds1 = Server.CreateObject("ADODB.Recordset") 
                    objRds1.Open "select count(ID) as numberoforder from orders where Email = '" &  replace(objRds("email"),"'","''") & "' and IdBusinessDetail=" & vRestaurantId, objCon 
        
                if not objRds1.EOF then
                    numberOfOrder = objRds1("numberoforder")
                end if   
                objRds1.close()
            set objRds1 = nothing
            end if
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
    
 <div class="row">
        <div class="span12">
           <div align="center">
			<p class="title-size">Order <%=Request.QueryString("id_o")%> from <%= name %> </p></div>
        </div>
    </div>
	<div style="width: 492px;margin-left:auto;margin-right:auto;margin-bottom:30px;">
        <div class="">
           <div class="">
               <div align="center">
                   <table> <tbody><tr> <td><img style="width: 86.4px;vertical-align: -3px;" src="<%=SITE_URL %>images/<% If objRds("DeliveryType") = "d" Then %>Delivery<% Else %>Collection<% End If %>-order.png"> </td>
<td style="align-items: center;"> <span class="shop-name heading-size" style="border-bottom: 1px solid rgb(229, 229, 229);width: 100%;display: inline-block;padding-top: 14px;"><%if objRds("PaymentType")="Stripe-Paid" or objRds("PaymentType")="Paypal-Paid" or objRds("PaymentType")="NoChex-Paid" or objRds("PaymentType")="Worldpay-Paid" or Ucase(objRds("Payment_status") & "")="PAID"  then  %><b>ORDER PAID</b><%else%><b>ORDER UNPAID</b><%end if%></span> 
                       <span style="display: block;padding-top: 10px;font-family: font-family;font-weight: bold;font-size:24px;align: center; text-align: center;">
                            
                              <% if objRds("asaporder") = "n" then%> 
                            [ASAP]
                           <%else %>
                           [<%response.write(formatDateTimeC(objRds("DeliveryTime")))%> ]
                           <%end if %>
                           

                       </span></td>
         </tr></tbody></table>
                   
                

               </div>
            </div>
        </div>
    </div>
	<% If ShowRestaurantDetailOnReceipt & "" = "1" Then %>
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
<div class="heading-size" style="   display: block;width: 100%;padding: 0;margin-bottom: 3px; line-height: inherit;color: #000;border: 0; border-bottom: 1px solid #e5e5e5; font-weight:bolder;">
                Customer Details
            </div>
			
            <%= objRds("FirstName") %>&nbsp;<%= objRds("LastName") %><br />
            <% If objRds("DeliveryType") = "d" Then %>
            <%= objRds("Address") %>,&nbsp;<%= objRds("PostalCode") %><br />
            <%end if %>
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
  <div class="heading-size" style="   display: block;width: 100%;padding: 0;margin-bottom: 3px; line-height: inherit;color: #000;border: 0; border-bottom: 1px solid #e5e5e5;font-weight:bolder;">Order Details</div>

Order Number: <%=Request.QueryString("id_o")%>


<br>
			
			 Order Time: <%response.write(formatDateTimeC(objRds("orderdate")))%>
<br />
           Order Type: <% If objRds("DeliveryType") = "d" Then %>Delivery<% Else %>Collection<% End If %>
              
				<br>Requested for:&nbsp;<%if objRds("asaporder") = "n" then%>
				    <%if objRds("DeliveryType") = "c" then
                        dim requestfor : requestfor =  DateAdd("n",vaveragecol,objRds("orderdate"))
                        %><%=formatDateTimeC(requestfor)%>
				   <%else%>
				   ASAP
				   <%end if%>
                   <%else%><%= formatDateTimeC(objRds("DeliveryTime")) %><%end if%><br>
				
<%
if  objRds("deliverydelay") & "" <> "" then
        vaveragedel = cint(objRds("deliverydelay"))
end if
if  objRds("collectiondelay") & "" <> "" then
        vaveragecol = cint(objRds("collectiondelay"))
end if
if objRds("asaporder") = "n" then
if objRds("DeliveryType") = "d" then
mintoadd=vaveragedel '+ 5 ' Add + 5 to match with front end
else
mintoadd=vaveragecol '+ 5 ' Add + 5 to match with front end
end if
    dim acceptedfor : acceptedfor = DateAdd("n",mintoadd,objRds("orderdate"))
%>
Accepted for:&nbsp;<%=formatDateTimeC(acceptedfor)%>
<br>
<%end if%>
          

          
			
			<div style="border-bottom: 1px solid #e5e5e5;width: 100%;">
			Payment Status:&nbsp;<%if objRds("PaymentType")="Stripe-Paid" or objRds("PaymentType")="Paypal-Paid" or  objRds("PaymentType")="NoChex-Paid" or  objRds("PaymentType")="Worldpay-Paid" or Ucase(objRds("Payment_status") & "")="PAID"  then  %>ORDER PAID<%else%>ORDER UNPAID<%end if%></div><br>
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
                                  <td  style="vertical-align: text-top;text-top;width:60%;"> <!-- <span class="big-printing-size"><%=objRds("PrintingName") %></span>-->
                                      <% if objRds("Propertyprintingname") & "" <> "" then  %>
                                        <span class="big-printing-size"> <%= objRds("Propertyprintingname") %> </span>
                                      <% elseif objRds("PropertyName")  & "" <> "" then %>
                                        <span class="big-printing-size"> <%= objRds("PropertyName") %> </span>
                                      <%else %>
                                        <span class="big-printing-size"><%=objRds("PrintingName") %></span>
                                     <%end if %>
                                <% end if %>  

						<%
						'display toppings in basket area
						If objRds("dishpropertiesids") <> "" Then
						 
						dishpropertiessplit=split(objRds("dishpropertiesids"),",")
					for i=0 to ubound(dishpropertiessplit)
					
					    dishpropertiessplit2=split(dishpropertiessplit(i),"|")
					    Set objRds_dishpropertiesprice = Server.CreateObject("ADODB.Recordset") 
					
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
					                    'response.write "<BR> <small>" & dishpropertygroup & ":" & dishproperty & "</small>"
                                        if  namePrintingMode & "" = "printingname" then
					                        response.write "<BR> <small><span class=""big-printing-size"">" & dishpropertygroup & ":" & dishproperty & "</span></small>"
                                        else
                                            response.write "<BR> <small>" & dishpropertygroup & ":" & dishproperty & "</small>"
                                        end if

                            end if
					    next
					end if%>
						
						
						<%
						toppingtext=""
                        dim toppingGroup : toppingGroup = "" 
						If objRds("toppingids") <> "" Then 
						        
								Set objRds_toppingids = Server.CreateObject("ADODB.Recordset")           
								    
                                Set objRds_toppingids_group = Server.CreateObject("ADODB.Recordset")     
                                dim SQLtopping : SQLtopping = "" 
                                    SQLtopping = "select top 1 ID, toppingsgroup,printingname  from Menutoppingsgroups  where id in (select toppinggroupid from menutoppings where id  in (" & objRds("toppingids")& ")  ) "
                                objRds_toppingids_group.Open SQLtopping, objCon
                                if not objRds_toppingids_group.EOF then
                                    toppingGroup = objRds_toppingids_group("toppingsgroup")
                                    if  namePrintingMode & "" = "printingname" and objRds_toppingids_group("printingname") & "" <> ""  then
                                        toppingGroup =   objRds_toppingids_group("printingname") 
                                    end if
                                end if
						         objRds_toppingids_group.close()
                                set objRds_toppingids_group = nothing
                                if toppingGroup & "" = "" then
                                    toppingGroup = "Toppings"
                                end if
                        objRds_toppingids.Open "SELECT * FROM MenuToppings where id in (" & objRds("toppingids") & ")", objCon
				        Do While NOT objRds_toppingids.Eof 
                         dim topping : topping =  objRds_toppingids("topping")
                             if  namePrintingMode & "" = "printingname" and objRds_toppingids("printingname") & "" <> ""  then
                                 topping =  objRds_toppingids("printingname")
                             end if

						toppingtext = toppingtext & topping & ", "
						objRds_toppingids.MoveNext
						loop
                         objRds_toppingids.close()
                         set objRds_toppingids = nothing
						if toppingtext<>"" then
							toppingtext=left(toppingtext,len(toppingtext)-2)
						    'response.write "<small><br>Toppings: " & toppingtext & "</small>"
                             if  namePrintingMode & "" = "printingname" then
                                response.write "<small><br><span class=""big-printing-size"">"& toppingGroup  &": " & toppingtext & "</span></small>"
                            else
						        response.write "<small><br>"& toppingGroup  &": " & toppingtext & "</small>"
                            end if
						end if
						 End If %>
						</td>
                                <td style="padding-right: 20px; text-align: right;width:25%;" valign="top"><%=CURRENCYSYMBOL%><%= FormatNumber(objRds("Total"), 2) %></td>                                    
                            </tr>
                    <%  
                        objRds.MoveNext        
                    Loop 
    
                    objRds.Close
                    Set objRds = nothing

                    %>
     
                        <tr>
                         <td style="padding-top: 5px">&nbsp;</td>
                        <td style="padding-top: 5px">&nbsp;</td>
                        <td style="padding-top: 5px">&nbsp;</td>
                    </tr>
                        <%if vvouchercode<>"" then%>
					<tr>
                        <td colspan="2" style="padding-top: 5px; text-align: right; border-top: 1px dotted black;">Discount code:&nbsp;<br /> <%=vvouchercode%><% if VoucherDiscountType & "" <> "Amount" then %> (-<%=vvouchercodediscount%>%)<%end if %>&nbsp; </td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right; border-top: 1px dotted black;">-<%=CURRENCYSYMBOL%><% if VoucherDiscountType & "" <> "Amount" then %><%= FormatNumber((( vSubTotal * 100 )/(100- Cdbl(Replace(Replace(Replace(vvouchercodediscount,"-",""),"%","")," ",""))) - vSubTotal ),2) %><%else %><%=FormatNumber(Cdbl(Replace(Replace(Replace(vvouchercodediscount,"-",""),"%","")," ","")),2) %><%end if %> </td>
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
                     <%if CDbl(Tax_Amount) > 0  then  %>
					<tr>
                        <td colspan="2" style="padding-top: 5px; text-align: right;">Tax(<%=Tax_percent %>%):</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right;"> <%=CURRENCYSYMBOL%><%= FormatNumber(Tax_Amount, 2)  %>  </td>
                    </tr>
					<%end if%>  
                     <%if CDbl(Tip_Amount) > 0  then  %>
					<tr>
                        <td colspan="2" style="padding-top: 5px; text-align: right;">Tip:(<%=TipRate %>)</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right;"> <%=CURRENCYSYMBOL%><%= FormatNumber(Tip_Amount, 2)  %>  </td>
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
            <div class="heading-size" style="   display: block;width: 100%;padding: 0;margin-bottom: 3px; line-height: inherit;color: #000;border: 0; border-bottom: 1px solid #e5e5e5;font-weight:bolder;">Special instructions:</div>
               <%= (replace(notes,chr(13),"<br />")) %>
                        
        </div>
    <% End If %>    
        <% if Show_Ordernumner_printer = "yes" then %>
         <div style="width: 512px;margin-left:auto;margin-right:auto;" class="item-size">
            <div  style="   display: block;width: 100%;padding: 0;margin-bottom: 3px; line-height: inherit;color: #000;border: 0; border-bottom: 1px solid #e5e5e5;">Number of Orders: <%=numberOfOrder %></div>
        </div> 
        <%end if %>
                   
	</div>
	<% 
          objCon.Close
        Set objCon= nothing     
      
        WriteLog Server.MapPath("EpsonPostImageAndPrint.txt"),"PageName  = print_t.asp End Page [Orderid] " & vOrderId  
              %>
	</body>
</html>
