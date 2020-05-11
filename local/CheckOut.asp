<%
    
      if Session("ResID") & "" <> "" then            
        session("restaurantid") = Session("ResID")
        Session("ResID") = ""
    else
         if request.querystring("id_r") & "" <> "" then
            session("restaurantid") = request.querystring("id_r")
        end if
    end if
    
    if session("restaurantid") &"" ="" or Session.SessionID & "" = ""  then
       
         response.redirect(SITE_URL & "local/menu.asp?id_r=" & session("restaurantid") & "&timeout=yes")
    end if
 
    %>

<!-- #include file="../Config.asp" -->
<!-- #include file="../timezone.asp" -->
<!-- #include file="../restaurantsettings.asp" -->


<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Checkout</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">

	<!--link rel="stylesheet/less" href="../less/bootstrap.less" type="text/css" /-->
	<!--link rel="stylesheet/less" href="../less/responsive.less" type="text/css" /-->
	<!--script src="../Scripts/less-1.3.3.min.js"></script-->
	<!--append ‘#!watch’ to the browser URL, then refresh the page. -->
	

	<link href="<%=SITE_URL %>css/bootstrap.css" rel="stylesheet">
	<link href="<%=SITE_URL %>css/style.css" rel="stylesheet">
    
	<link href="<%=SITE_URL %>css/datepicker.css" rel="stylesheet">
      <link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="<%=SITE_URL %>css/addtohomescreen.css">
  <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
    <script src="../Scripts/html5shiv.js"></script>
  <![endif]-->

  <!-- Fav and touch icons -->
 <% If FAVICONURL & "" <> "" Then %> <link rel='shortcut icon' href='<%=FAVICONURL %>' type='image/x-icon'/ > <% end If %>
  
	<script type="text/javascript" src="<%=SITE_URL %>Scripts/jquery.min.js"></script>
	<script type="text/javascript" src="<%=SITE_URL %>Scripts/bootstrap.min.js"></script>
	<script type="text/javascript" src="<%=SITE_URL %>Scripts/scripts.js"></script>
	
    <script src="<%=SITE_URL %>Scripts/jquery.validate.min.js" type="text/javascript"></script>

    <script src="<%=SITE_URL %>Scripts/bootstrap-datepicker.js" type="text/javascript"></script>
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=<%= GMAP_API_KEY %>&sensor=false"></script>
    
 <style type="text/css">
        small.error 
        {
            display: inline;    
            color: #B94A48; 
        }
		#wholepage {
padding-top:0px !important;
}
        .hightlight1 {
            border-color: rgb(102, 175, 233);
	        outline: 0px none;
	        box-shadow: 0px 1px 1px rgba(0, 0, 0, 0.075) inset, 0px 0px 8px rgba(102, 175, 233, 0.6);
        }
    </style>

<% 
    Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 

    Dim vRestaurantId
    dim vOrderId
    dim vOrderShipTotal
    dim vOrderSubTotal
    dim vOrderTotal
    Dim sPostalCode
    Dim sDeliveryDistance
    Dim sDeliveryFreeDistance
    Dim vaveragecol

    vRestaurantId = session("restaurantid")  
     objCon.Open sConnString
          '' Get Url Menu, checkout , thanks
    dim MenuURL,CheckoutURL,ThankURL
     
    MenuURL =  SITE_URL & "local/menu.asp?id_r=" & vRestaurantId
    if vRestaurantId & "" <> "" then
           dim rs_url :  set rs_url = Server.CreateObject("ADODB.Recordset")
               rs_url.open "SELECT FromLink FROM URL_REWRITE a inner join BusinessDetails b on (a.RestaurantID=b.ID )  where RestaurantID=" & vRestaurantId & " and EnableUrlRewrite = 'Yes' and status = 'ACIVE' " ,objCon
            while not rs_url.eof 
               Dim fromlink : fromlink =  lcase(rs_url("FromLink"))
               if  instr(fromlink,lcase(SITE_URL)) > 0 then
                   fromlink = replace(fromlink,lcase(SITE_URL),lcase(SITE_URL) & "local/")  
               else 
                   if instr( lcase(SITE_URL),"https") > 0 then
                      fromlink  = replace(fromlink,"http://","https://")
                      fromlink = replace(fromlink,lcase(SITE_URL),lcase(SITE_URL) & "local/")  
                   else
                      fromlink  = replace(fromlink,"https://","http://")
                      fromlink = replace(fromlink,lcase(SITE_URL),lcase(SITE_URL) & "local/")     
                   end if
               end if
               if instr(fromlink,"/menu") > 0 then
                     MenuURL = fromlink 
               elseif  instr(fromlink,"/checkout") > 0 then
                     CheckoutURL = fromlink 
               end if 
               rs_url.movenext()
           wend
            rs_url.close()
        set rs_url =  nothing
        if instr( lcase(SITE_URL) ,"https://") then
            MenuURL  = replace(MenuURL,"http://","https://")    
            CheckoutURL  = replace(CheckoutURL,"http://","https://")    
            ThankURL  = replace(ThankURL,"http://","https://")    
         end if  
    end if
    '' end 
   
    objRds.Open "SELECT * FROM BusinessDetails WHERE Id = " & vRestaurantId, objCon
    sPostalCode = objRds("PostalCode")
    sDeliveryMaxDistance = Cdbl(objRds("DeliveryMaxDistance"))
    sDeliveryFreeDistance= Cdbl(objRds("DeliveryFreeDistance"))
    vaveragecol = objRds("AverageCollectionTime")
    sDeliveryChargeOverrideByOrderValue = 1000000000

    if Not isnull(objRds("DeliveryChargeOverrideByOrderValue")) Then
	    sDeliveryChargeOverrideByOrderValue= Cdbl(objRds("DeliveryChargeOverrideByOrderValue"))
    End If
    vOrderShipTotal = Cdbl(objRds("DeliveryFee"))   
    
%>


<body onunload="">

<!-- Safari iOS reload page, without loading from cache -->
<iframe style="height:0px;width:0px;visibility:hidden" src="about:blank">
    this frame prevents back forward cache
</iframe>


<script>
$(window).bind("pageshow", function(event) {
    if (event.originalEvent.persisted) {
        window.location.reload() 
    }
});
</script>


<input type="hidden" id="refreshed" value="no">
<script type="text/javascript">
onload=function(){
var e=document.getElementById("refreshed");
if(e.value=="no")e.value="yes";
else{e.value="no";location.reload();}
}
</script>
<!-- Safari iOS reload page, without loading from cache -->



<div class="container" id="wholepage" style="padding-bottom:100px;">

	<div class="row clearfix headerbox" id="header">
<div class="col-md-12 col-xs-12" style="padding-bottom:10px;">
			<div class="media">
				 <a href="#" class="pull-left"><img src="<%= objRds("ImgUrl") %>" width=70 class="media-object" alt="<%= objRds("Name") %>"></a>
				<div class="media-body">
					<h4 class="media-heading">
				
				<div style="float:right;">
				
				<div class="hidden-xs">
                 <i class="fa fa-phone"></i>
				 <%= objRds("Telephone") %> 
<span class="glyphicon glyphicon glyphicon-envelope"></span>  <%= objRds("Email") %></div>
<div class="visible-xs">
<a href="https://www.google.co.uk/maps?q=<%= objRds("Address") %>" target="_blank"><span class="glyphicon glyphicon-map-marker"></span></a>
<a href="tel:<%= objRds("Telephone") %>"><span class="glyphicon glyphicon-earphone"></span></a>
<a href="mailto:<%= objRds("Email") %>"><span class="glyphicon glyphicon-envelope"></span></a></div>
</div>	
						 <%= objRds("Name") %>
					</h4><div class="hidden-xs"><b><%= objRds("Address") %> </b><br></div>
<%= objRds("FoodType") %>
			</div>
			</div>
		</div></div>
    <%            
        objRds.Close
       ' objCon.Close
      '  objCon.Open sConnString
        objRds.Open "select o.* from [Orderslocal]  o  " & _
            " Where o.IdBusinessDetail = " & vRestaurantId & _
            " And o.SessionId = '" & Session.SessionID & "'", objCon, 1, 3 

			discountcodeused=""
            vouchercode = ""
        if objRds.EOF then
            response.redirect(SITE_URL &  "local/menu.asp?id_r=" & session("restaurantid"))
        end if
        dim VoucherDiscontType : VoucherDiscontType =""
	    if objRds("vouchercodediscount") <> 0  or objRds("vouchercode")  & "" <> ""  then
	          discountcodeused= "-" & objRds("vouchercodediscount") & "%"
              vouchercode = objRds("vouchercode") 
              VoucherDiscontType = objRds("DiscountType")
	    end if
			
        vOrderId = objRds("Id")
        vOrderSubTotal = cdbl(objRds("SubTotal"))
		
        If Request.Form("deliveryType") <> "d" Then
            vOrderShipTotal = 0
        elseIf Request.Form("deliveryDistance") <> "" and sDeliveryFreeDistance<>0 Then
            dim UserDistance
            UserDistance = cdbl(Request.Form("deliveryDistance"))
            If UserDistance <= sDeliveryFreeDistance Then vOrderShipTotal = 0                              
        end if

		if vOrderSubTotal > sDeliveryChargeOverrideByOrderValue then
			vOrderShipTotal = 0
		end if
		
	 
		Dim OrderDate, deliverytime, orderTotalAmount
       OrderDate =  DateAdd("h",houroffset,now)
       
        objRds("OrderDate") = DateAdd("h",houroffset,now)
        objRds("DeliveryType") = "Collection"'Request.Form("deliveryType")
		'coltimesplit=split(Request.Form("deliveryTime"))
		'coltime=coltimesplit(1)
		
        objRds("DeliveryTime") = DateAdd("n",sAverageCollectionTime,DateAdd("h",houroffset,now)) 'Now()'JXIsoDate(Request.Form("deliveryTime")) + " " + coltime
        dim customername 
            customername = Request.Form("TableNumberCheckout") & "" 
            if customername = "" then
                customername =  Request.Cookies("firstname")
            end if
        if customername & "" = "" then
                response.redirect(SITE_URL & "local/menu.asp?id_r=" & session("restaurantid"))
        end if
          objRds("FirstName") = Request.Form("TableNumberCheckout")
        deliverytime = objRds("DeliveryTime") 
        objRds("asaporder") = "Y"'Request.Form("asaporder")
         objRds("PaymentSurcharge") = 0
        objRds("SubTotal") = vOrderSubTotal
        objRds("ShippingFee") = vOrderShipTotal

        If ServiceChargePercentage & "" <> "" AND ServiceChargePercentage & "" <> "0"  Then
            objRds("ServiceCharge")  = (Cdbl(ServiceChargePercentage)*0.01*CDbl(vOrderSubTotal))
            'objRds("OrderTotal") = (Cdbl(ServiceChargePercentage)*0.01*CDbl(objRds("SubTotal"))) + CDbl(objRds("OrderTotal"))
        Else
            objRds("ServiceCharge") = 0
        End If

         '' Calculate Tax 
             If Tax_Percent & "" <> "" AND Tax_Percent & "" <> "0"  Then
                objRds("Tax_Amount")  = (Cdbl(Tax_Percent)*0.01*CDbl(vOrderSubTotal + vOrderShipTotal))
                objRds("Tax_Rate")  =Tax_Percent
            Else
                objRds("Tax_Amount") = 0
                objRds("Tax_Rate")  =0
            End If
        '' End 
           '' Calculate Tip 
            Dim Tip_Rate : Tip_Rate = 0
                Tip_Rate = objRds("Tip_Rate")
             If Tip_percent & "" <> "" AND Tip_percent & "" <> "0"  Then
                if objRds("Tip_Rate") & "" <> "custom" and objRds("Tip_Rate") & ""  <> "" then
                        Tip_percent = objRds("Tip_Rate")
                 end if
                if objRds("Tip_Rate") & "" <> "custom"   then
                     objRds("Tip_Amount")  = (Cdbl(Tip_Percent)*0.01*CDbl(vOrderSubTotal ))
                     objRds("Tip_Rate")  =Tip_percent
                    Tip_Rate = Tip_percent
                end if
            Else
                objRds("Tip_Amount") = 0
                objRds("Tip_Rate")  =0
            End If
        dim TaxAmount,TipAmount
        '' End 
        TaxAmount = objRds("Tax_Amount")
        TipAmount = objRds("Tip_Amount")

        serviceChargeAmount = objRds("ServiceCharge")
        objRds("OrderTotal") = vOrderSubTotal + vOrderShipTotal + serviceChargeAmount + TaxAmount + TipAmount

        orderTotalAmount = vOrderSubTotal + vOrderShipTotal
        objRds("DeliveryLat") ="" ' Request.Form("deliveryLat")
        objRds("DeliveryLng") = "" 'Request.Form("deliveryLng")

        objRds.Update 
    
        objRds.Close
       ' objCon.Close 

        
        vOrderTotal = FormatNumber(vOrderSubTotal + vOrderShipTotal + serviceChargeAmount, 2)  + TaxAmount + TipAmount
    %>

        
    <form id="frmMakeOrder" action="<%=SITE_URL %>local/MakeOrder.asp" method="post">
        <input type="hidden" name="Stripe_Token" id="Stripe_Token" value="" />
        <input type="hidden" name="order_id" value="<%= vOrderId%>"/>
        <input type="hidden" name="item_name" value="Order Nr. <%= vOrderId%>"/>
        <input type="hidden" name="amount" value="<%= FormatNumber(vOrderTotal, 2)%>"/>
        
       <div class="row clearfix" >

			<div class="col-md-6  column" style="margin: 0 auto;">
                 <fieldset>
                <legend>Your Order</legend>
                <b> <% If Request.Form("deliveryType") = "d" Then %>Delivery<% Else %>Collection<% End If %>
                      (<%=formatDateTimeC(DateAdd("n",vaveragecol,OrderDate))%>)
                    </b> <br />
                <b>Customer:&nbsp;<%=customername %></b>     
                     <br /><br />
            <%
                
               ' objCon.Open sConnString
                objRds.Open "select oi.*," & _
                        "mi.Name, mip.Name as PropertyName " & _
                        "from ( OrderItemslocal oi " & _
                        "inner join MenuItems mi on oi.MenuItemId = mi.Id ) " & _
                        "left join MenuItemProperties mip on oi.MenuItemPropertyId = mip.Id " & _
                        "where oi.OrderId = " & vOrderId, objCon


            if objRds.Eof then 
                objRds.Close
                set objRds = nothing
                objCon.Close
                set objCon =  nothing
                response.redirect(SITE_URL & "local/menu.asp?id_r=" & session("restaurantid") & "&timeout=yes")
            else %>

               
                    <table style="width: 100%" id="panel-item">  

                      <%
                    Do While NOT objRds.Eof  %>
                            <tr>
                                <td><%If objRds("Qta") > 1 Then %> 
                            (x <%= objRds("Qta") %>)
                        <% End If %> <%= objRds("Name") %>&nbsp;<%= objRds("PropertyName") %> 
						
						<%
						'display toppings in basket area
						If objRds("dishpropertiesids") <> "" Then
						 
						dishpropertiessplit=split(objRds("dishpropertiesids"),",")
					for i=0 to ubound(dishpropertiessplit)
					
					    dishpropertiessplit2=split(dishpropertiessplit(i),"|")
					
					    'Set objCon_dishpropertiesprice = Server.CreateObject("ADODB.Connection")
					    Set objRds_dishpropertiesprice = Server.CreateObject("ADODB.Recordset") 
					    'objCon_dishpropertiesprice.Open sConnString
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
						'Set objCon_toppingids = Server.CreateObject("ADODB.Connection")
						            Dim SQLTopping                              
                                        SQL = "  SELECT distinct a.toppinggroupid,ap.toppingsgroup FROM MenuToppings a with(nolock)  "
                                        SQL = SQL & "  join Menutoppingsgroups ap with(nolock) on a.toppinggroupid = ap.ID "
                                        SQL = SQL & " where a.id in  (" & objRds("toppingids") & ") "
                                    dim objRds_toppingids_group : Set objRds_toppingids_group = Server.CreateObject("ADODB.Recordset") 
                                        objRds_toppingids_group.Open SQL, objCon
                                    Dim toppinggroup : toppinggroup = ""
                                    while not objRds_toppingids_group.EOF 
                                        toppingtext=""    
                                        toppinggroup = objRds_toppingids_group("toppingsgroup")
                                        Set objRds_toppingids = Server.CreateObject("ADODB.Recordset") 
                                            SQLTopping = "SELECT m.topping,isnull(mp.toppingsgroup,'') as toppingsgroup FROM MenuToppings m "
                                            SQLTopping =SQLTopping & "  left join Menutoppingsgroups mp on  m.toppinggroupid = mp.ID"
                                            SQLTopping =SQLTopping & "    where m.id in ("& objRds("toppingids") &") and m.toppinggroupid=  " & objRds_toppingids_group("toppinggroupid")
                                            objRds_toppingids.Open SQLTopping, objCon
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
						                    response.write "<small><br>"&toppinggroup&": " & toppingtext & "</small>"
						                end if
                                        objRds_toppingids_group.movenext()
                                    wend
                                        objRds_toppingids_group.close()    
                                    set objRds_toppingids_group = nothing
						 End If  %>
						</td>
                                <td style="padding-right: 20px; text-align: right;" valign="top"><%=CURRENCYSYMBOL%><%= FormatNumber(objRds("Total"), 2) %></td>                                    
                            </tr>
                    <%  
                        objRds.MoveNext        
                    Loop 
    
                    objRds.Close
                    set objRds = nothing
                   ' objCon.Close
               

                    %>
     
                         <tr>

                            <td style="padding-top: 5px">&nbsp;</td>
                            <td style="padding-top: 5px">&nbsp;</td>
                            <td style="padding-top: 5px">&nbsp;</td>
                        </tr>
						
							<%
                            function CalculateSubtotalWithDiscount( byval orderID, byval discountvalue,byval VoucherMainType, byval ListID)
                            
                            dim result : result = 0
       
                            if ( VoucherMainType = "Dishes" or VoucherMainType ="Categories" )  then
                                    result = 0 
                                dim SQL : SQL = "" 
                                    SQL = "select  MenuItemId,Total,IdMenuCategory from  orderitemslocal oi with(nolock)   " 
			                        SQL= SQL & "  join MenuItems mi with(nolock) on oi.MenuItemId = mi.id "
			                        SQL= SQL & " where oi.orderid  = " & orderID
                                 '   Response.Write(SQL & " ListID " & ListID  )
                                 '   Response.End
            
                                    dim RS_OrderTotal : set RS_OrderTotal = Server.CreateObject("ADODB.Recordset")
                                    RS_OrderTotal.Open SQL , objCon
                                    while not RS_OrderTotal.EOF
                                        if VoucherMainType = "Dishes" then
        
                                            if  instr("," & ListID,"," &  RS_OrderTotal("MenuItemId") & ",") > 0 then                            
                                                 result = result +  0.01 * cdbl(RS_OrderTotal("Total")) *  discountvalue    
                                        
                                            end if
                                        elseif VoucherMainType = "Categories" then
                                             if  instr("," & ListID,RS_OrderTotal("IdMenuCategory")) > 0 then
                                                 result = result + 0.01*  cdbl(RS_OrderTotal("Total")) *  discountvalue 
                               
                                            end if
                                        end if
                                        RS_OrderTotal.movenext()
                                    wend
                                       RS_OrderTotal.close()
                                       set RS_OrderTotal = nothing   
                            end if
                          CalculateSubtotalWithDiscount =   result
                        end function 
                        dim discountValueDisCat : discountValueDisCat = -1
                        if discountcodeused <>"" then                                       
                                Dim objRdsV,ListIncludeID,IncludeDishes_Categories
                            Set objRdsV = Server.CreateObject("ADODB.Recordset") 
                                objRdsV.Open "SELECT ListID,IncludeDishes_Categories FROM vouchercodes  with(nolock)  where IdBusinessDetail=" & vRestaurantId & " and vouchercode='" & vouchercode & "'", objCon, 1, 3 
                            if not objRdsV.eof then
                                    ListIncludeID = objRdsV("ListID")
                                    IncludeDishes_Categories = objRdsV("IncludeDishes_Categories")
                            end if
                                if (IncludeDishes_Categories = "Dishes" or IncludeDishes_Categories = "Categories") and ListIncludeID & "" <> ""  then
                                    discountValueDisCat  = CalculateSubtotalWithDiscount(vOrderId,abs(Replace(discountcodeused,"%","")),IncludeDishes_Categories,ListIncludeID)                         
                                end if
                                  if VoucherDiscontType = "Amount" then  
                                        discountValueDisCat = abs(Replace(discountcodeused,"%",""))
                                    end if 
                            objRdsV.close()
                            set objRdsV = nothing
                                %>

							
		<tr>
            <td style="padding-top: 5px; border-top: 1px dotted black;"><b>Voucher</b><br /><%=vouchercode %><%if  VoucherDiscontType & "" <> "Amount" then%>(<%=discountcodeused%>)<%end if %> </td>
            <td style="padding-top: 5px; border-top: 1px dotted black;text-align: right;padding-right: 20px;">
			<%  if VoucherDiscontType = "Amount" then  %>
                    <span id="voucher">-<%=CURRENCYSYMBOL%><%= FormatNumber(discountValueDisCat,2) %></span>
                <%else %>
			        <% if discountValueDisCat >= 0 then  %>
                        <span id="voucher">-<%=CURRENCYSYMBOL%><%= FormatNumber(discountValueDisCat,2) %></span>
                    <%else %>
			            <span id="voucher">-<%=CURRENCYSYMBOL%><%= FormatNumber((( vOrderSubTotal * 100 )/(100- Cdbl(Replace(Replace(Replace(discountcodeused,"-",""),"%","")," ",""))) - vOrderSubTotal ),2) %> </span>
                     <%end if %> 
             <%end if %> 
            </td>
            <td style="padding-top: 5px; border-top: 1px dotted black;">&nbsp;</td>
        </tr>
		<%end if
                 objCon.Close
                    set objCon  = nothing
            %>
        
        
                         <tr>
                            <td style="padding-top: 5px; border-top: 1px dotted black;">SubTotal</td>
                            <td style="padding-top: 5px; padding-right: 20px; text-align: right; border-top: 1px dotted black;"><%=CURRENCYSYMBOL%><%= FormatNumber(vOrderSubTotal, 2)  %>
                                <input type="hidden" id="subtotal" value="<%=vOrderSubTotal %>"/>
                            </td>
                            <td style="padding-top: 5px; border-top: 1px dotted black;">&nbsp;</td>
                        </tr>       
                        
                        <% If vOrderShipTotal > 0 Then  %>
                        <tr>
                            <td style="padding-top: 5px;">Delivery Fee</td>
                            <td style="padding-top: 5px; padding-right: 20px; text-align: right;"><%=CURRENCYSYMBOL%><%= FormatNumber(vOrderShipTotal, 2)  %></td>
                            <td style="padding-top: 5px;">&nbsp;</td>
                        </tr>       
                        <% End If
                            If CDbl(serviceChargeAmount) > 0 Then %>
                         <tr>
                            <td style="padding-top: 5px;">Service Charge</td>
                            <td style="padding-top: 5px; padding-right: 20px; text-align: right;"><%=CURRENCYSYMBOL%><%= FormatNumber(serviceChargeAmount, 2)  %></td>
                            <td style="padding-top: 5px;">&nbsp;</td>
                        </tr>     
                        <% End if %>
                        <% if cdbl(TaxAmount) > 0 then %>
                              <tr>
                                <td style="padding-top: 5px;">Tax(<%=Tax_Percent %>%)</td>
                                <td style="padding-top: 5px; padding-right: 20px; text-align: right;"><%=CURRENCYSYMBOL%><%= FormatNumber(TaxAmount, 2)  %></td>
                                <td style="padding-top: 5px;">&nbsp;</td>
                            </tr> 
                        <% end if %>
                         <% if cdbl(TipAmount) > 0 then %>
                              
                                   <% function WriteCheck(byval value1, byval value2)
                                        dim result : result = "" 
                                        if value1 & "" = value2 & ""  then
                                            result = "selected"
                                        end if
                                        WriteCheck = result
                                    end function
                             %>
                             <tr>
                                <td style="padding-top: 5px;">Tip<select  id="tip_custom" style="display:none;margin-left:10px;width:80px;" onchange="ChangeTip(this);">
                                                                     <%  dim x
                                                                        for x = 1 to 25 
                                                                        if x mod 5 = 0 then
                                                                         %>
                                                                        <option <%=WriteCheck(x,Tip_Rate) %> value="<%=x %>" style="font-weight:bold"><%=x %>%</option>
                                                                        <% else %>
                                                                        <option <%=WriteCheck(x,Tip_Rate) %> value="<%=x %>"><%=x %>%</option>
                                                                        <% end if %>
                                                                     <%next %>    
                                                                    <option <%=WriteCheck("custom",Tip_Rate) %> value="custom">custom</option>
                                                                 </select>
                                    <% if Tip_Rate = "custom" then %>
                                     <input type="text" id ="tip_value" value="<%=FormatNumber(TipAmount, 2) %>" style="display:none;width:50px;"/>
                                    <%else %>
                                    <input type="text" readonly="readonly" id ="tip_value" value="<%=FormatNumber(TipAmount, 2) %>" style="display:none;width:70px;"/>
                                    <% end if %>
                                    <span style="text-decoration:underline;color:blue;cursor:pointer;" id="tip_edit" onclick="edit();">Edit</span>
                                    <span style="text-decoration:underline;color:blue;cursor:pointer;display:none;" id="tip_update" onclick="UpdateTip();">Update</span></td>
                                <td style="padding-top: 5px; padding-right: 20px; text-align: right;" id="lbTipmount"><%=CURRENCYSYMBOL%><%= FormatNumber(TipAmount, 2)  %></td>
                                <td style="padding-top: 5px;">&nbsp;</td>
                            </tr>  
                        <% end if %>
                        <tr>
                            <td style="padding-top: 5px;"><b>Total</b></td>
                            <td style="padding-top: 5px; padding-right: 20px; text-align: right;"><%=CURRENCYSYMBOL%><b><%= FormatNumber(vOrderTotal, 2)  %></b></td>
                            <td style="padding-top: 5px;">&nbsp;</td>
                        </tr>    
                    <tr><td colspan="3" style="text-align:center;"><br /><br /><br /></td></tr>
                            </table>
                     <table style="width:100%">

                          <tr>
                            <td colspan="3">

                                <div id="divVoucherCode" style="padding:0px 8px 15px 8px;">
                                     <button type="button" class="btn btn-xs btn-block" id="vouchercodeshow" style="background-color:#eeeeee;color:#7d7c7c  ;height:45px;margin-bottom:20px;"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> Add Voucher Code</button>
	                                <button type="button" class="btn  btn-xs btn-block" id="vouchercodehide"  style="display:none;background-color: #eeeeee;color:#7d7c7c  ;"><span class="glyphicon glyphicon-minus" aria-hidden="true"></span> Close</button>	
                                    <div class="panel panel-default" style="display:none;" id="divVoucherCode1" >
                                        <div class="panel-body">           
						                                <div class="row">
                                  <div class="col-xs-7">
                                    <label class="sr-only" for="vouchercode">Enter Code</label>
                                    <input type="text" class="form-control noSubmit" id="vouchercode" name="vouchercode" placeholder="Enter code">
                                  </div> <div class="col-xs-3">
  
   
  
                                   <input  class="btn btn-default" type="button" onclick="VoucherCode();" value="Submit"/>
                                 </div>
 
                                 <div class="col-xs-1">&nbsp;</div>
 
              
                                                    </div>
                                    </div>
                                    <div id="divVoucherCodeAlert" style="margin: 1px auto;text-align: center;color:red;"> </div>
                                 </div>
                                        </div>
                            </td>    
                        </tr>
                     </table>
                     <table style="width: 100%">    
                         <tr>
                            <td colspan="3"><div class="control-group col-sm-12 col-md-12" style="padding-left:0px;padding-right:0px;padding-top:15px;padding-bottom:15px;">


<br>
<a href="javascript:window.history.back();" name="payment_type" value="nochex" class="btn btn-primary col-md-12" style="width: 180px; padding: 8px;float:none;"><span class="
glyphicon glyphicon-chevron-left" aria-hidden="true"></span> Back to Menu</a>
<br><br>


                    <label class="control-label" for="Special">Special Instructions</label>
                    <div class="controls">
                        <textarea id="Special" name="Special" rows="4" class="form-control" ><%=Request.Form("Special")%></textarea>
                    </div>
                </div> </td>    
                        </tr>
                            <tr><td colspan="3" style="text-align:center;"><br /><br /><br /></td></tr>
                    </table>
          
                <%
                End If
                %>  
            </fieldset>
		    </div>	
           <script type="text/javascript">
                                  function IsInvalidTip(str)
                                  {
                                      var patt = new RegExp(/^(\d*\.)?\d+$/);
                                      var res = patt.test(str);
                                      return res;
                                  }
                                  
                                function ChangeTip(obj)
                                {
                                    var tipetype = $(obj).val();
                                    if(tipetype != "custom"){
                                        $("#tip_value").attr("readonly","true");
                                        
                                        var TipValue = parseFloat($("#subtotal").val()) * tipetype * 1.0 / 100;
                                        TipValue = parseFloat(TipValue).toFixed(2);
                                        $("#tip_value").val(TipValue); 
                                    }else
                                        $("#tip_value").removeAttr("readonly");   
                                }
                                function UpdateTip()
                                {
                                    if($("#tip_value").val()=="")
                                    {
                                        alert("Please input tip amount. Thanks!");
                                        return false;
                                    }   
                                    else if(!IsInvalidTip($("#tip_value").val()))
                                    {
                                        alert("The tip must be a positive number.");
                                        return false;
                                    }
                                    $.ajax({url: "<%=SITE_URL%>local/UpdateTip.asp?id_r=<%=vRestaurantId%>&oid=<%=vOrderId%>&tipamount=" + $("#tip_value").val() + "&tr=" + $("#tip_custom").val() , success: function(result){
                                        $("#tip_custom").hide();
                                        $("#tip_value").hide();
                                        $("#tip_edit").show();
                                        $("#tip_update").hide();
                                        $("#ordertotal").html(result);
                                        $("[name=amount]").val(result);
                                        $("#lbTipmount").html("<%=CURRENCYSYMBOL%>" + parseFloat($("#tip_value").val()).toFixed(2));
                                        location.reload();
                                    }});
                                }
                                function edit()
                                {
                                    $("#tip_custom").show();
                                    $("#tip_value").show();
                                    $("#tip_edit").hide();
                                    $("#tip_update").show();
                                }
                                $("#vouchercodeshow").click(function(){
                                    $("#divVoucherCode1").show();
                                    $("#vouchercodeshow").hide();
                                    $("#vouchercodehide").show();
                                });

                                $("#vouchercodehide").click(function(){
                                    $("#divVoucherCode1").hide();
                                    $("#vouchercodeshow").show();
                                    $("#vouchercodehide").hide();
                                });
                                $(function(){
                                    $("input.noSubmit").keypress(function(e){
                                        var k=e.keyCode || e.which;
                                        if(k==13){
                                            e.preventDefault();
                                        }
                                    });
                                });
                                function VoucherCode() {
                                    //$("#panel-item").load("<%=SITE_URL%>local/applydiscount.asp?id_r=<%= vRestaurantId %>&op=vouchercode&vouchercode=" + $('#vouchercode').val());
                                   
                                    $.ajax({url:"<%=SITE_URL%>local/applydiscount.asp?id_r=<%= vRestaurantId %>&o=<%=vOrderId%>&op=vouchercode&vouchercode=" + $('#vouchercode').val() , success: function(result){
                                        $("#panel-item").html(result);
                                    }});
                                    return false;
                                }
                            </script>
           <div class="col-md-6" id="right-payment-button">
               <table width="100%">
                   <tr>
                            <td colspan="3" style="text-align: center">
                                <div id="processpayment" class="localprocesspaymentblock"  style="max-width:768px;">
					<% Dim disableButton, popoverAttr, divCount
                            divCount = 0
                            disableButton = "disabled"
                             popoverAttr = "data-trigger=""hover"" data-toggle=""popover"" data-placement=""top"" data-content=""Minimum order " & CURRENCYSYMBOL & MinimumAmountForCardPayment & """"
                            If orderTotalAmount >= MinimumAmountForCardPayment Then 
                            
                                disableButton = ""
                                popoverAttr = ""
                             End If %>
						<% 
                            dim isOrder : isOrder =  false 
                            IF NOCHEX="Yes" THEN
                            isOrder = true
                            divCount = divCount + 1%>
                              <div class="block-direct" <%=popoverAttr %>>
							        <button  <%=disableButton %>   type="submit" name="payment_type" value="nochex"  class="btn btn-primary btn-block" >Pay by Debit/Credit Card (Nochex)<br>(<%=CURRENCYSYMBOL%><%=CREDITCARDSURCHARGE%> surcharge)</button> 
                            </div>
					<%end if%>		
					<% IF PAYPAL="Yes" THEN
                        divCount = divCount + 1 
                         if isOrder = true then
                          %>
                          <div class="divider-or">OR</div>
                          <%
                         end if
                               isOrder = true
                        %>
                                   <div class="block-direct" <%=popoverAttr %>>
                              <button <%=disableButton %>  type="submit" name="payment_type" value="paypal"  class="btn btn-primary btn-block btn-paypal">
								 <!-- Pay by Debit/Credit Card (Paypal) --> <br><br>(<%=CURRENCYSYMBOL%><%=CREDITCARDSURCHARGE%> surcharge)</button>
                            </div>
                    <%end if%>	    

<% IF WORLDPAY="Yes" THEN
    divCount = divCount + 1 
    if isOrder = true then
    %>
            <div class="divider-or">OR</div>
                <%
    end if
    isOrder =  true
    %>
                        <div class="block-direct" <%=popoverAttr %>>
                              <button <%=disableButton %>  type="submit" name="payment_type" value="worldpay"  class="btn btn-primary btn-block btn-worldpay" ><!--Pay by Debit/Credit Card (Worldpay)--><br><br>(<%=CURRENCYSYMBOL%><%=CREDITCARDSURCHARGE%> surcharge)</button>
                            </div>
					<%end if%>	
                      <%

                        if  ISSTRIPE = "Yes" then
                            divCount = divCount + 1
                            if isOrder = true then
                            %>
                                <div class="divider-or">OR</div>               
                            <%
                            end if
                                    %>                                               
                                    <div class="block-direct" <%=popoverAttr %>>
                                        <button <%=disableButton %>  type="submit" name="payment_type" value="stripe"  class="btn btn-primary btn-block btn-stripe" ><br><br>(<%=CURRENCYSYMBOL%><%=CREDITCARDSURCHARGE%> surcharge)</button>
                                    </div>

                                    <%  
                                        isOrder =  true 
                        end if
                        %>
                           <div class="block-direct" <%=popoverAttr %>>
                                        <% if disableButton = "" and enable_StripePaymentButton = "Yes" then %>
                                        <br/><br/>
                                    <!-- #include file="../Payments/stripe/stripepayment.asp" -->
                                        <div id="idsurchage" style="color:grey;display:none;">(<%=CURRENCYSYMBOL%><%=CREDITCARDSURCHARGE%> surcharge)</div>
                                            <script type="text/javascript">
                                                $(function(){
                                                    $("#payment-request-button").show();
                                                    if($("#payment-request-button").length > 0 && $.trim( $("#payment-request-button").html()) !="")
                                                        $("#idsurchage").show();   
                                                });
                                                

                                            </script>
                                          <%end if %>
                                    </div>
                   <% 
                       if enable_CashPayment = "Yes" then  
                         if isOrder = true then
                        %>
                                <div class="divider-or">OR</div>
                                    <%
                        end if
                        %>
					     <div class="block-cash">
						    <button  type="submit" name="payment_type" value="cash_delivery"  class="btn btn-info btn-block">Pay by Cash</button>   
                        </div>
                    <% end if %>
                                    </div>
                            </td>
                        </tr>
               </table>

           </div>
		                
	    </div>

    </form>
      <div id="ResetSessionModal" class="modal fade">
	  <div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;</button>
          <!--  <h3 style="color: red">
                Closed</h3>-->
        </div>
        <div class="modal-body" style="text-align: center;">
            
        </div>
        <div class="modal-footer" style="text-align: center;">
            <a onclick="PopupRestartOnclick(false);" href="#" data-dismiss="modal" class="btn btn-primary">Yes</a>
			&nbsp;&nbsp;&nbsp;&nbsp;
            <a onclick="PopupRestartOnclick(true);" href="#" data-dismiss="modal" class="btn btn-primary">No</a>
        </div>
    </div></div></div>
</div>


<script type="text/javascript">
    $(document).ready(function () {
        if($("#processpayment").width() > 600){
            $("#right-payment-button").css("margin-top","-60px");
        }
        else
            $("#right-payment-button").css("margin-top","30px");

        $(window).on('resize', function () {
            if($("#processpayment").width() > 600){
                $("#right-payment-button").css("margin-top","-60px");
            }
            else
                $("#right-payment-button").css("margin-top","30px");
        }); 
    });
    var pendingReload = 0;
    var reloadCountdownInterval ;
    var idleTime = 0;
    var idleInterval;
    function initIdleTimeoutReset(){
        //Increment the idle time counter every minute.
        idleInterval = setInterval(timerIncrement, 1000); 

        //Zero the idle timer on mouse movement.
        $(this).mousemove(function (e) {
            idleTime = 0;
        });
        $(this).keypress(function (e) {
            idleTime = 0;
        });
    }
  function timerIncrement() {
    idleTime = idleTime + 1;
    if (idleTime > 60) { //1 min idle
        clearInterval(idleInterval);
        $("#ResetSessionModal div.modal-body").html('<span style="font-weight:bold;font-size:20px;"> Would you like to continue with your order? <br><br> Time remaining: 10 sec.</span>');
        $("#ResetSessionModal").modal();       
        reloadCountdownInterval = setInterval(resetCountDown, 1000); 
        pendingReload = 10;      
    }
 }  
 function resetCountDown(){
    if(pendingReload==1)
        window.location.href = "<%=SITE_URL%>local/resetsession.asp?r=<%=session("restaurantid") %>";
    pendingReload = pendingReload -1;
   
    $("#ResetSessionModal div.modal-body").html('<span style="font-weight:bold;font-size:20px;"> Would you like to continue with your order? <br><br> Time remaining: ' + pendingReload + ' sec. </span>');
 }
    function PopupRestartOnclick(isRestart){
        if(isRestart)
            window.location.href = "<%=SITE_URL%>local/resetsession.asp?r=<%=session("restaurantid") %>";
    else{
           idleTime = 0;
        clearInterval(reloadCountdownInterval);
        idleInterval = setInterval(timerIncrement, 1000); 

    }
    }
    $(document).ready(function () {
        initIdleTimeoutReset();
        var hour = <%= DatePart("h", DateAdd("h",houroffset,now), vbMonday, 1) + 1%>;
        if(hour < 10) hour = '0' + hour;
        $("select[name=p_hour]").find('option[value=' + hour + ']').attr("selected", true);

       


        jQuery.validator.setDefaults({
            errorPlacement: function (error, element) {
                // if the input has a prepend or append element, put the validation msg after the parent div
                if (element.parent().hasClass('input-prepend') || element.parent().hasClass('input-append')) {
                    error.insertAfter(element.parent());
                    // else just place the validation message immediatly after the input
                } else {
                    error.insertAfter(element);
                }
            },
            errorElement: "small", // contain the error msg in a small tag
            wrapper: "div", // wrap the error message and small tag in a div
            highlight: function (element) {
                $(element).closest('.control-group').addClass('error'); // add the Bootstrap error class to the control group
            },
            success: function (element) {
                $(element).closest('.control-group').removeClass('error'); // remove the Boostrap error class from the control group
            }
        });

        $("form").removeAttr("novalidate");
        // $("form").validate();
                $("form").validate({
                    rules: {
                        Email: {
                            required: true,
                            email: true
                        }
                    }
                });
    
        var isFormSubmitted = false;

        $("form").submit(function() {    
            $("form").validate();
            if($("form").valid()){
                if(isFormSubmitted) return false;         
           
               // isFormSubmitted = true;         
                return true;
            }
          
        });
        $('[data-toggle="popover"]').popover({ trigger: "hover" });   
    });
	
	
</script>



</body>
</html>
