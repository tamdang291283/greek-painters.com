<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../../Config.asp" -->
<!-- #include file="../../timezone.asp" -->
<%
    session("restaurantid")=Request.QueryString("id_r")
     %>
<!-- #include file="../../restaurantsettings.asp" -->
<% 

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
    Dim EpsonJSPrinterURL
    
    vRestaurantId = Request.QueryString("id_r")
    vOrderId = Request.QueryString("id_o")

    objCon.Open sConnString
    objRds.Open "SELECT * FROM BusinessDetails WHERE Id = " & vRestaurantId, objCon    
    vaveragedel = objRds("AverageDeliveryTime")
	vaveragecol = objRds("AverageCollectionTime")
    EpsonJSPrinterURL =  objRds("EpsonJSPrinterURL") 
    if Not IsNull(objRds("AverageDeliveryTime")) Then sAverageDeliveryTime = Cdbl(objRds("AverageDeliveryTime"))
    if Not IsNull(objRds("AverageCollectionTime")) Then sAverageCollectionTime = Cdbl(objRds("AverageCollectionTime"))   

        
	name=objRds("Name")
	address= objRds("Address") 
	telephone=objRds("telephone") 
	email=  objRds("email")       
        objRds.Close
       ' objCon.Close       
        
        ' objCon.Open sConnString
        objRds.Open "select * from [Orders]  " & _
            "where Id = " & vOrderId, objCon
    
        dim vShippingFee
        dim vSubTotal
        dim vOrderTotal
        Dim servicecharge, paymentsurcharge, vvouchercode, vvouchercodediscount
        dim Tax_Amount,Tip_Amount
        if  objRds("deliverydelay") & "" <> "" then
                vaveragedel = cint(objRds("deliverydelay"))
        end if
        if  objRds("collectiondelay") & "" <> "" then
                vaveragecol = cint(objRds("collectiondelay"))
        end if
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
        vShippingFee = objRds("ShippingFee")
        vSubTotal = objRds("SubTotal")
        vOrderTotal = objRds("OrderTotal")
        servicecharge  = objRds("servicecharge")
        paymentsurcharge  = objRds("paymentsurcharge")
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
    .big-printing-size {font-size:<%=51*PrinterFontSizeRatio%>px;}
    <% else %>
     .title-size {font-size:36px;}
    .heading-size {font-size:34px;}
    .item-size {font-size:31px;}
    .big-printing-size {font-size:51px;}
    <% end if %>
</style>

<body style="width:512px;">
    <script type="text/javascript" src="js/html2canvas.js"></script>
    <script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" src="js/epos-print-5.0.0.js"></script>
   
 <div class="row">
        <div class="span12">
           <div align="center">
			<p class="title-size">Order <%=Request.QueryString("id_o")%> from <%= name %> </p></div>
        </div>
    </div>

 
    
        
  
     
    <script>

        var CanvasToBMP = {

            /**
             * Convert a canvas element to ArrayBuffer containing a BMP file
             * with support for 32-bit (alpha).
             *
             * Note that CORS requirement must be fulfilled.
             *
             * @param {HTMLCanvasElement} canvas - the canvas element to convert
             * @return {ArrayBuffer}
             */
            toArrayBuffer: function (canvas) {

                var w = canvas.width,
                    h = canvas.height,
                    w4 = w * 4,
                    idata = canvas.getContext("2d").getImageData(0, 0, w, h),
                    data32 = new Uint32Array(idata.data.buffer), // 32-bit representation of canvas

                    stride = Math.floor((32 * w + 31) / 32) * 4, // row length incl. padding
                    pixelArraySize = stride * h,                 // total bitmap size
                    fileLength = 122 + pixelArraySize,           // header size is known + bitmap

                    file = new ArrayBuffer(fileLength),          // raw byte buffer (returned)
                    view = new DataView(file),                   // handle endian, reg. width etc.
                    pos = 0, x, y = 0, p, s = 0, a, v;

                // write file header
                setU16(0x4d42);          // BM
                setU32(fileLength);      // total length
                pos += 4;                // skip unused fields
                setU32(0x7a);            // offset to pixels

                // DIB header
                setU32(0x6c);            // header size (108)
                setU32(w);
                setU32(-h >>> 0);        // negative = top-to-bottom
                setU16(1);               // 1 plane
                setU16(32);              // 32-bits (RGBA)
                setU32(3);               // no compression (BI_BITFIELDS, 3)
                setU32(pixelArraySize);  // bitmap size incl. padding (stride x height)
                setU32(2835);            // pixels/meter h (~72 DPI x 39.3701 inch/m)
                setU32(2835);            // pixels/meter v
                pos += 8;                // skip color/important colors
                setU32(0xff0000);        // red channel mask
                setU32(0xff00);          // green channel mask
                setU32(0xff);            // blue channel mask
                setU32(0xff000000);      // alpha channel mask
                setU32(0x57696e20);      // " win" color space

                // bitmap data, change order of ABGR to BGRA (msb-order)
                while (y < h) {
                    p = 0x7a + y * stride; // offset + stride x height
                    x = 0;
                    while (x < w4) {
                        v = data32[s++];                     // get ABGR
                        a = v >>> 24;                        // alpha channel
                        view.setUint32(p + x, (v << 8) | a); // set BGRA (msb order)
                        x += 4;
                    }
                    y++
                }

                return file;

                // helper method to move current buffer position
                function setU16(data) { view.setUint16(pos, data, true); pos += 2 }
                function setU32(data) { view.setUint32(pos, data, true); pos += 4 }
            },

            /**
             * Converts a canvas to BMP file, returns a Blob representing the
             * file. This can be used with URL.createObjectURL().
             * Note that CORS requirement must be fulfilled.
             *
             * @param {HTMLCanvasElement} canvas - the canvas element to convert
             * @return {Blob}
             */
            toBlob: function (canvas) {
                return new Blob([this.toArrayBuffer(canvas)], {
                    type: "image/bmp"
                });
            },

            /**
             * Converts the canvas to a data-URI representing a BMP file.
             * Note that CORS requirement must be fulfilled.
             *
             * @param canvas
             * @return {string}
             */
            toDataURL: function (canvas) {
                var buffer = new Uint8Array(this.toArrayBuffer(canvas)),
                    bs = "", i = 0, l = buffer.length;
                while (i < l) bs += String.fromCharCode(buffer[i++]);
                return "data:image/bmp;base64," + btoa(bs);
            }
        };
     
     
         $(window).on("load",function () {
            try{
          <% if PrinterFontSizeRatio & "" <> "" Then %>
            $("img").width( $("img").width() * <%=PrinterFontSizeRatio %> );
          <% end if %>
            if(isCanvasSupported()){
                html2canvas(document.body, {
                    onrendered: function (canvas) {

                        document.body.appendChild(canvas);

                      
                        var ctx = canvas.getContext("2d");
                        var myBuilder = new epson.ePOSBuilder();
                    
                        myBuilder.addImage(canvas.getContext('2d'), 0, 0, canvas.width, canvas.height, "color_1", "mono");      
                        myBuilder.addCut(myBuilder.CUT_FEED);
                        
                        var epos = new epson.ePOSPrint('<%=EpsonJSPrinterURL %>');
                        epos.onreceive = function (res) { alert("Printed successfully. " +  res.success); window.close() ; };
                        epos.onerror = function (err) { alert("Printing failed with error status:" + err.status); };
                        epos.oncoveropen = function () { alert('coveropen'); };
                        epos.send(myBuilder.toString());            
                      
                      
                   // $("body").html("<div style='display:block; margin:0 auto;'> The order is printing... Please wait for the notification! </div> ");
                    },
                    width: 512
                });
            }
           
           }
        catch(err){
       
        $("body").hide();
        }

        });
       
         function isCanvasSupported(){
            var elem = document.createElement('canvas');
            return !!(elem.getContext && elem.getContext('2d'));
         }
    </script>
	<div style="width: 492px;margin-left:auto;margin-right:auto;margin-bottom:30px;">
        <div class="">
           <div class="">
               <div align="center"> <img src="../../images/<% If objRds("DeliveryType") = "d" Then %>Delivery<% Else %>Collection<% End If %>-order.png" style="vertical-align: middle;"> <span class="shop-name heading-size" style="border-bottom: 1px solid #e5e5e5;width: 100%;"><%if  objRds("PaymentType")="Paypal-Paid" or objRds("PaymentType")="NoChex-Paid" or objRds("PaymentType")="Worldpay-Paid" or Ucase(objRds("Payment_status") & "")="PAID"  then  %><b>ORDER PAID</b><%else%><b>ORDER UNPAID</b><%end if%></span>  </div>
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
	<% End If %>
	


    <div style="width: 492px; clear:both;margin-left:auto;margin-right:auto;" class="item-size">
<div class="heading-size" style="   display: block;width: 100%;padding: 0;margin-bottom: 3px;line-height: inherit;color: #333;border: 0; border-bottom: 1px solid #e5e5e5; font-weight:bolder;">
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
              
				<br>
				
				   Requested for:     &nbsp;<%if objRds("asaporder") = "n" then%>
				   
				   <%if objRds("DeliveryType") = "c" then%>
				   <%=DateAdd("n",vaveragecol,objRds("orderdate"))%>
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
%>
Accepted for:&nbsp;<%=DateAdd("n",mintoadd,objRds("orderdate"))%>
<br>
<%end if%>
          

          
			
			<div style="border-bottom: 1px solid #e5e5e5;width: 100%;">
			Payment Status:&nbsp;<%if  objRds("PaymentType")="Paypal-Paid" or  objRds("PaymentType")="NoChex-Paid" or  objRds("PaymentType")="Worldpay-Paid" or Ucase(objRds("Payment_status") & "")="PAID"  then  %>ORDER PAID<%else%>ORDER UNPAID<%end if%></div><br>
<br>
  <%notes=objRds("Notes")
        objRds.Close
        'objCon.Close
     %>
        <%
                
          '  objCon.Open sConnString
            objRds.Open "select oi.*," & _
                    "mi.Name, mip.Name as PropertyName " & _
                    "from ( OrderItems oi " & _
                    "inner join MenuItems mi on oi.MenuItemId = mi.Id ) " & _
                    "left join MenuItemProperties mip on oi.MenuItemPropertyId = mip.Id " & _
                    "where oi.OrderId = " & vOrderId, objCon


        if objRds.Eof then %>
    
            No Items In Your Order.

        <% 
            objRds.Close
            set objRds  = nothing
            objCon.Close
            set objCon = nothing

        else %>

               
                <table style="width: 100%;" class="item-size">  

                 <%
                    Do While NOT objRds.Eof  %>
                            <tr>
                                <td style="vertical-align: text-top;"><%= objRds("Name") %>&nbsp;<%= objRds("PropertyName") %> <%If objRds("Qta") > 1 Then %>  (x <%= objRds("Qta") %>)
                        <% End If %>
						
						<%
						'display toppings in basket area
						If objRds("dishpropertiesids") <> "" Then
						 
						dishpropertiessplit=split(objRds("dishpropertiesids"),",")
					for i=0 to ubound(dishpropertiessplit)					
					    dishpropertiessplit2=split(dishpropertiessplit(i),"|")
					    Set objRds_dishpropertiesprice = Server.CreateObject("ADODB.Recordset") 					
	                    objRds_dishpropertiesprice.Open "SELECT MenuDishproperties.ID, MenuDishproperties.dishproperty, MenuDishproperties.dishpropertyprice, MenuDishpropertiesGroups.dishpropertypricetype, MenuDishpropertiesGroups.dishpropertygroup FROM MenuDishproperties INNER JOIN MenuDishpropertiesGroups ON MenuDishproperties.dishpropertygroupid = MenuDishpropertiesGroups.ID where (((MenuDishproperties.ID)=" & dishpropertiessplit2(1)  & "))", objCon
                            if not objRds_dishpropertiesprice.EOF then
	                            response.write "<BR> <small>" & objRds_dishpropertiesprice("dishpropertygroup") & ":" & objRds_dishpropertiesprice("dishproperty") & "</small>"
                            end if
					             objRds_dishpropertiesprice.close()
                            set objRds_dishpropertiesprice = nothing
					    next
					end if%>
						
						
						<%
						toppingtext=""
						If objRds("toppingids") <> "" Then 
				Set objRds_toppingids = Server.CreateObject("ADODB.Recordset") 
                             Dim SQLTopping 
                             Dim toppinggroup : toppinggroup  =""
                                SQLTopping = "SELECT m.topping,isnull(mp.toppingsgroup,'') as toppingsgroup FROM MenuToppings m "
                                SQLTopping =SQLTopping & "  left join Menutoppingsgroups mp on  m.toppinggroupid = mp.ID"
                                SQLTopping =SQLTopping & "    where m.id in ("& objRds("toppingids") &")"
                objRds_toppingids.Open SQLTopping , objCon
				        Do While NOT objRds_toppingids.Eof 
						        toppingtext = toppingtext & objRds_toppingids("topping") & ", "
                                toppinggroup = objRds_toppingids("toppingsgroup")
						        objRds_toppingids.MoveNext
						loop
                            objRds_toppingids.close()
                        set objRds_toppingids = nothing
						if toppingtext<>"" then
                             if toppinggroup & "" = "" then
                                    toppinggroup = "Toppings"
                                  end if
							toppingtext=left(toppingtext,len(toppingtext)-2)
						    response.write "<small><br>" & toppinggroup & ": " & toppingtext & "</small>"
						end if
						 End If %>
						</td>
                                <td style="padding-right: 20px; text-align: right;" valign="top"><%=CURRENCYSYMBOL%><%= FormatNumber(objRds("Total"), 2) %></td>                                    
                            </tr>
                    <%  
                        objRds.MoveNext        
                    Loop 
    
                    objRds.Close
                    set objRds = nothing
                    objCon.Close
                    set objCon  = nothing

                    %>
     
                        <tr>
                        <td style="padding-top: 5px">&nbsp;</td>
                        <td style="padding-top: 5px">&nbsp;</td>
                    </tr>
                               <%if vvouchercode<>"" then%>
					<tr>
                        <td style="padding-top: 5px; text-align: right; border-top: 1px dotted black;">Discount code:&nbsp;<br /><%=vvouchercode%> (-<%=vvouchercodediscount%>%)&nbsp;</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right; border-top: 1px dotted black;">-<%=CURRENCYSYMBOL%><%= FormatNumber((( vSubTotal * 100 )/(100- Cdbl(Replace(Replace(Replace(vvouchercodediscount,"-",""),"%","")," ",""))) - vSubTotal ),2) %> </td>
                    </tr>
					<%end if%>
                        <tr>
                        <td style="padding-top: 5px; text-align: right; border-top: 1px dotted black;">SubTotal:</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right; border-top: 1px dotted black;"><%=CURRENCYSYMBOL%><%= FormatNumber(vSubTotal, 2)  %></td>
                    </tr>       
                     <% if Cdbl(vShippingFee) > 0 then %>   
                    <tr>
                        <td style="padding-top: 5px; text-align: right;">Delivery Fee:</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right;"><%=CURRENCYSYMBOL%><%= FormatNumber(vShippingFee, 2)  %></td>
                    </tr>  
                    <% end if %>
                    <%if CDbl(PaymentSurcharge) > 0 then  %>
					<tr>
                        <td style="padding-top: 5px; text-align: right;">Credit card surcharge:</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right;"> <%=CURRENCYSYMBOL%><%= FormatNumber(PaymentSurcharge, 2)  %>  </td>
                    </tr>
					<%end if%>     
                      <%if CDbl(ServiceCharge) > 0  then  %>
					<tr>
                        <td style="padding-top: 5px; text-align: right;">Service charge:</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right;"> <%=CURRENCYSYMBOL%><%= FormatNumber(ServiceCharge, 2)  %>  </td>
                    </tr>
					<%end if%>    
                     <%if CDbl(Tax_Amount) > 0  then  %>
					<tr>
                        <td style="padding-top: 5px; text-align: right;">Tax(<%=Tax_percent %>%):</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right;"> <%=CURRENCYSYMBOL%><%= FormatNumber(Tax_Amount, 2)  %>  </td>
                    </tr>
					<%end if%>  
                     <%if CDbl(Tip_Amount) > 0  then  %>
					<tr>
                        <td style="padding-top: 5px; text-align: right;">Tip:</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right;"> <%=CURRENCYSYMBOL%><%= FormatNumber(Tip_Amount, 2)  %>  </td>
                    </tr>
					<%end if%>             
                    <tr>
                        <td style="padding-top: 5px;text-align: right;"><b>Total:</b></td>
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
	
	</body>
</html>
