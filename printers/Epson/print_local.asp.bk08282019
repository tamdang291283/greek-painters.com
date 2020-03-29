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
     Dim LocalEpsonJSPrinterURL

    vRestaurantId = Request.QueryString("id_r")
    vOrderId = Request.QueryString("id_o")

    objCon.Open sConnString
    objRds.Open "SELECT * FROM BusinessDetails WHERE Id = " & vRestaurantId, objCon    
    vaveragedel = objRds("AverageDeliveryTime")
	vaveragecol = objRds("AverageCollectionTime")
    if Not IsNull(objRds("AverageDeliveryTime")) Then sAverageDeliveryTime = Cdbl(objRds("AverageDeliveryTime"))
    if Not IsNull(objRds("AverageCollectionTime")) Then sAverageCollectionTime = Cdbl(objRds("AverageCollectionTime"))   
     LocalEpsonJSPrinterURL =  objRds("LocalPrinterURL") 
        
	name=objRds("Name")
	address= objRds("Address") 
	telephone=objRds("telephone") 
	email=  objRds("email")       
        objRds.Close
        objCon.Close       
      


         objCon.Open sConnString
        objRds.Open "select * from [Orderslocal]  " & _
            "where Id = " & vOrderId, objCon
        If objRds.EOF Then
            Response.Write("Invalid order!")
            Response.end()
        End If 

        dim vShippingFee
        dim vSubTotal
        dim vOrderTotal
        Dim ServiceCharge , vvouchercode, vvouchercodediscount,PaymentSurcharge
        PaymentSurcharge = objRds("PaymentSurcharge")
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
         If PaymentSurcharge & "" = "" Then
            PaymentSurcharge = "0"
        End If
        vShippingFee = objRds("ShippingFee")
        vSubTotal = objRds("SubTotal")
        vOrderTotal = objRds("OrderTotal")
        
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
    .big-printing-size {font-size:<%=51*PrinterFontSizeRatio%>px;}
    .tb-item-size {font-size:<%=31*PrinterFontSizeRatio%>px;table-layout:fixed;}
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
        padding: 3px 0;
    }
    <% end if %>
       * {    
         font-family: Arial;
        }
</style>
<body style="width:512px;">
    <script type="text/javascript" src="js/html2canvas.js"></script>
    <script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" src="js/epos-print-5.0.0.js"></script>
    <script type="text/javascript" src="js/js.cookie.js"></script>

 <div class="row">
        <div class="span12">
           <div align="center">
			<p class="title-size">In-Store - Order <%=Request.QueryString("id_o")%> </p></div>
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
                      
                       $.post("saveimage.asp", { img: myBuilder.message, o_id: <%=vOrderId%>, r_id: <%=vRestaurantId %>,isprint:'<%=Request.QueryString("isPrint") %>', mod: '<%=Request.QueryString("mod") %>',local:'Y' ,idlist: '<%=Request.QueryString("idlist") %>'});
                      /*
                        myBuilder.addImage(canvas.getContext('2d'), 0, 0, canvas.width, canvas.height, "color_1", "mono");      
                        myBuilder.addCut(myBuilder.CUT_FEED);
                        
                        var epos = new epson.ePOSPrint('<%=LocalEpsonJSPrinterURL %>');
                        epos.onreceive = function (res) { <% if request.querystring("f") = "2" then %>window.close(); <% end if %> };
                        epos.onerror = function (err) { alert("Printing failed with error status:" + err.status);  <% if request.querystring("f") = "2" then %>window.close(); <% end if %>  };
                        epos.oncoveropen = function () { alert('coveropen'); };
                        epos.send(myBuilder.toString());            
                      */
                      
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
               <div align="center"> <img src="../../images/in-restaurant.png" style="vertical-align: middle;"> 
                   
                  
                   <span class="shop-name heading-size" style="border-bottom: 1px solid #e5e5e5;width: 100%;"><%if objRds("PaymentType")="Stripe-Paid" or objRds("PaymentType")="Paypal-Paid" or objRds("PaymentType")="NoChex-Paid" or objRds("PaymentType")="Worldpay-Paid" or Ucase(objRds("Payment_status") & "")="PAID"  then  %><b>ORDER PAID</b><%else%><b>ORDER UNPAID</b><%end if%></span>  </div>
            </div>
        </div>
    </div>
	<% 'if 1=2 then %>
	   <div style="width: 492px;margin-left:auto;margin-right:auto;" class="item-size">
        <div class="">
           <div class="shop-info">
                <span class="shop-name"><%=name %></span><br />
                <span class="shop-address"><%=address%></span><br />
                <span class="shop-name">Tel. <%=telephone %></span><br />                       
                <span class="shop-address">Email: <%=email %></span><br />
                <!-- <span class="vat-no">VAT No. 733843524</span><br /><br /> -->
            </div>
        </div>
    </div>
	<% 'End If %>
	


    <div style="width: 492px; clear:both;margin-left:auto;margin-right:auto" class="item-size">
        <br />
<div class="heading-size" style="   display: block;width: 100%;padding: 0;margin-bottom: 3px; line-height: inherit;color: #333;border: 0; border-bottom: 1px solid #e5e5e5; font-weight:bolder;">
              Customer
            </div>
			<% If request.QueryString("table") & "" <> "" Then 
                    Response.Write("<span>" & request.QueryString("table") & "</span>")
               Else %>
                <span><%= objRds("FirstName") %>&nbsp;<%= objRds("LastName") %>  </span>     
                <% If objRds("DeliveryLat") & "" <> "" Then %>
                <br /><span>Lat/Long: <%= objRds("DeliveryLat") & "," & objRds("DeliveryLng")%></span>
                <br /><span>GPS: <%=Latitude_DMS(objRds("DeliveryLat")) & " ," & Longitude_DMS(objRds("DeliveryLng")) %></span>
                <% End If %>
                <br />
           <% End if %>
    </div>
    <br />
    <br />
    <div style="width: 492px;margin-left:auto;margin-right:auto;" class="item-size">
  <div class="heading-size" style="   display: block;width: 100%;padding: 0;margin-bottom: 3px; line-height: inherit;color: #333;border: 0; border-bottom: 1px solid #e5e5e5;font-weight:bolder;">Order Details</div>
    <span>Order Number: <%=Request.QueryString("id_o")%></span>
    <br>		
            <span>Order Time: <%response.write(formatDateTimeC(objRds("orderdate")))%><br /></span> 
			<span>Payment Status:&nbsp;<%if objRds("PaymentType")="Stripe-Paid" or objRds("PaymentType")="Paypal-Paid" or  objRds("PaymentType")="NoChex-Paid" or  objRds("PaymentType")="Worldpay-Paid" or Ucase(objRds("Payment_status") & "")="PAID"  then  %>ORDER PAID<%else%>ORDER UNPAID<%end if%><br><br></span> 

  <%notes=objRds("Notes")
   
      if notes & "" = "" And Request.Cookies("Specialinput") & "" <> "" Then
        notes = Request.Cookies("Specialinput")
      End if
        objRds.Close
       set objRds = nothing
      '  objCon.Close
    '  set objCon =  nothing
     %>
        <%
                
          '  objCon.Open sConnString
             Set objRds = Server.CreateObject("ADODB.Recordset") 
            objRds.Open "select oi.*," & _
                    "mi.Name, mip.Name as PropertyName,mip.printingname as Propertyprintingname, mi.PrintingName " & _
                    "from ( OrderItemsLocal oi " & _
                    "inner join MenuItems mi on oi.MenuItemId = mi.Id ) " & _
                    "left join MenuItemProperties mip on oi.MenuItemPropertyId = mip.Id " & _
                    "where oi.OrderId = " & vOrderId, objCon


        if objRds.Eof then %>
    
            No Items In Your Order.

        <% 
                objRds.Close
            set objRds = nothing
                objCon.Close
            set objCon = nothing

        else
              Dim namePrintingMode
            namePrintingMode = Request.QueryString("mod")
             %>

               
                <table style="width: 100%;" class="item-size">  

                 <%
                    Do While NOT objRds.Eof  %>
                            <tr>
                                <% if  namePrintingMode & "" = "printingname" then  %>
                                    <td style="width:15%; vertical-align: text-top;"> <span class="big-printing-size">  <%= objRds("Qta") %>   </span> x &nbsp;</td>
                                <% else %>
                                    <td style="width:15%; vertical-align: text-top;text-top;">   <%= objRds("Qta") %>  x  &nbsp;</td>
                                <% end if %>
                                
                                    <% If namePrintingMode & "" = "" then  %>
                                <td style="vertical-align: text-top;width:60%;"> <span> <%= objRds("Name") %> </span> <% If objRds("PrintingName") & "" <> "" Then %> <br /><span class="big-printing-size"><%=objRds("PrintingName") %></span><% End If %>
                                      <% if objRds("PropertyName") & "" <> "" then %>
                                        <br/><span> <%= objRds("PropertyName") %> </span> 
                                        <% end if %>
						         <% elseIf namePrintingMode & "" = "dishname" then  %>    
                                 <td style="vertical-align: text-top;" > <span>  <%= objRds("Name") %> </span>
                                     <% if objRds("PropertyName") & "" <> "" then %>
                                         <br /><span> <%= objRds("PropertyName") %> </span>
                                        <% end if %>
                                <% elseif  namePrintingMode & "" = "printingname" then  %>
                                  <td style="vertical-align: text-top;text-top;width:60%;"> <!-- <span class="big-printing-size"><%=objRds("PrintingName") %></span>-->
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
                    set objRds = nothing
                        objCon.Close
                    set objCon = nothing

                    %>
     
                        <tr>
                         <td style="padding-top: 5px">&nbsp;</td>
                        <td style="padding-top: 5px">&nbsp;</td>
                        <td style="padding-top: 5px">&nbsp;</td>
                    </tr>
                            <%if vvouchercode<>"" then%>
					<tr>
                        <td colspan="2" style="padding-top: 5px; text-align: right; border-top: 1px dotted black;">Discount code:&nbsp;<br /><%=vvouchercode%> (-<%=vvouchercodediscount%>%)&nbsp;</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right; border-top: 1px dotted black;"> -<%=CURRENCYSYMBOL%><%= FormatNumber((( vSubTotal * 100 )/(100- Cdbl(Replace(Replace(Replace(vvouchercodediscount,"-",""),"%","")," ",""))) - vSubTotal ),2) %> </td>
                    </tr>
					<%end if%>   
                        <tr>
                        <td colspan="2" style="padding-top: 5px; text-align: right; border-top: 1px dotted black;">SubTotal:</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right; border-top: 1px dotted black;"><%=CURRENCYSYMBOL%><%= FormatNumber(vSubTotal, 2)  %></td>
                    </tr>    
                     <%if  Cdbl(PaymentSurcharge) > 0 then  %>
					<tr>
                         <td colspan="2" style="padding-top: 5px; text-align: right;">Credit card surcharge:</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right;"><%=CURRENCYSYMBOL%><%= FormatNumber(PaymentSurcharge, 2)  %></td>
                      
                    </tr>
					<%end if%>     
                     <% If CDbl(ServiceCharge) > 0 Then   %>   
                    <tr>
                        <td colspan="2" style="padding-top: 5px; text-align: right;">Service charge:</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right;"><%=CURRENCYSYMBOL%><%= FormatNumber(ServiceCharge, 2)  %></td>
                    </tr>    
                   <% end If  %> 
                     <%if CDbl(Tax_Amount) > 0  then  %>
					<tr>
                        <td style="padding-top: 5px; text-align: right;">Tax(<%=Tax_percent %>%):</td>
                        <td style="padding-top: 5px; padding-right: 20px; text-align: right;"> <%=CURRENCYSYMBOL%><%= FormatNumber(Tax_Amount, 2)  %>  </td>
                    </tr>
					<%end if%>  
                     <%if CDbl(Tip_Amount) > 0  then  %>
					<tr>
                        <td style="padding-top: 5px; text-align: right;">Tip:(<%=TipRate %>)</td>
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
            <div class="heading-size" style="   display: block;width: 100%;padding: 0;margin-bottom: 3px; line-height: inherit;color: #333;border: 0; border-bottom: 1px solid #e5e5e5;font-weight:bolder;">Special instructions:</div>
               <%= (replace(notes,chr(10),"<br />")) %>
                        
        </div>
    <% End If %>                
	</div>
		<script>
$.cookie("Specialinput", "",{ path: "/" }); 
</script>
	</body>

    <%
      'objCon.Open sConnStringcms
   'Response.Write("Delete from OrderItemsLocal where orderid in (select id from OrdersLocal where id <> "& vOrderId & " AND idbusinessdetail = " & vRestaurantId & " ) ")
   ' response.Write(" <br /> Delete from OrdersLocal where id <> vOrderId  AND idbusinessdetail = " & vRestaurantId )
   ' objCon.Execute("Delete from OrderItemsLocal where orderid in (select id from OrdersLocal where id <> "& vOrderId & " AND idbusinessdetail = " & vRestaurantId & " ) ")
   'objCon.Execute("Delete from OrdersLocal where id <> "& vOrderId & "  AND idbusinessdetail = " & vRestaurantId )
   ' objCon.Close()
    Set objCon = nothing
    if request.querystring("f") <> "2" AND UCase(Request.QueryString("isPrint")) <> "Y" Then
          Session.Abandon
    End If
         %>

</html>
