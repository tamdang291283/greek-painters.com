
<%
    if request.querystring("id_r") & "" <> "" then
        session("restaurantid") = request.querystring("id_r")
    end if
if session("restaurantid")="" then
     if request.querystring("id_r") & "" <> "" then
        response.redirect("menu_new.asp?id_r=" & request.querystring("id_r") & "&timeout=yes")
      else 
        response.redirect("error.asp")
    end if
end if%>

<!-- #include file="Config.asp" -->
<!-- #include file="timezone.asp" -->
<!-- #include file="restaurantsettings.asp" -->


<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Checkout</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">

	<!--link rel="stylesheet/less" href="less/bootstrap.less" type="text/css" /-->
	<!--link rel="stylesheet/less" href="less/responsive.less" type="text/css" /-->
	<!--script src="Scripts/less-1.3.3.min.js"></script-->
	<!--append ‘#!watch’ to the browser URL, then refresh the page. -->
	
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">
	<link href="css/datepicker.css" rel="stylesheet">

  <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
    <script src="Scripts/html5shiv.js"></script>
  <![endif]-->

  <!-- Fav and touch icons -->
 <% If FAVICONURL & "" <> "" Then %> <link rel='shortcut icon' href='<%=FAVICONURL %>' type='image/x-icon'/ > <% end If %>
  
	<script type="text/javascript" src="Scripts/jquery.min.js"></script>
	<script type="text/javascript" src="Scripts/bootstrap.min.js"></script>
	<script type="text/javascript" src="Scripts/scripts.js"></script>
	
    <script src="Scripts/jquery.validate.min.js" type="text/javascript"></script>

    <script src="Scripts/bootstrap-datepicker.js" type="text/javascript"></script>
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

    vRestaurantId = Request.QueryString("id_r")

    objCon.Open sConnString
    objRds.Open "SELECT * FROM BusinessDetails WHERE Id = " & vRestaurantId, objCon
    sPostalCode = objRds("PostalCode")
    sDeliveryMaxDistance = Cdbl(objRds("DeliveryMaxDistance"))
    sDeliveryFreeDistance= Cdbl(objRds("DeliveryFreeDistance"))
    vaveragecol = objRds("AverageCollectionTime")
    sDeliveryChargeOverrideByOrderValue = 1000000000
    individualpostcodeschecking=objRds("individualpostcodeschecking")
    dim googleecommercetrackingcode
    googleecommercetrackingcode = objRds("googleecommercetrackingcode")

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
				<span class="glyphicon glyphicon glyphicon-earphone"></span> <%= objRds("Telephone") %> 
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
        objCon.Close

        if Session.SessionID & "" = "" then
             response.redirect("error.asp")
        end if
        objCon.Open sConnString
        objRds.Open "select o.* from [Orders] o " & _
            " Where o.IdBusinessDetail = " & vRestaurantId & _
            " And o.SessionId = '" & Session.SessionID & "'", objCon, 1, 3 
            
			discountcodeused=""
        vouchercode = ""
    if objRds.EOF then
        response.redirect("error.asp")
    end if
	if objRds("vouchercodediscount")<>0 then
	    discountcodeused= "-" & objRds("vouchercodediscount") & "%"
        vouchercode = objRds("vouchercode")
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
		
			
		Dim OrderDate, deliverytime, orderTotalAmount, serviceChargeAmount
   

       OrderDate =  DateAdd("h",houroffset,now)
        objRds("OrderDate") = DateAdd("h",houroffset,now)
        objRds("DeliveryType") = Request.Form("deliveryType")
        if Request.Form("deliveryTime") & ""  <> "" and instr( trim(Request.Form("deliveryTime"))," ") > 0  then
		    coltimesplit=split(Request.Form("deliveryTime")," ")
		    coltime=coltimesplit(1)
		end if
        if Request.Form("deliveryTime") & "" <> "" and request.Form("h_p_hour") & "" <> "" then
           if WeekdayName(DatePart("w", cdate(Request.Form("deliveryTime")), vbMonday, 1),true,0)  <> left(request.Form("h_p_hour"),3) then
                objRds("DeliveryTime") = JXIsoDate( DateAdd("d",1,cdate(Request.Form("deliveryTime")))) + " " + coltime
           else
                objRds("DeliveryTime") = JXIsoDate(Request.Form("deliveryTime")) + " " + coltime
           end if
        end if
        
        deliverytime = trim( objRds("DeliveryTime") & "" )
      
        if deliverytime & "" = "" then 
            
           response.redirect("menu_new.asp?id_r=" & request.querystring("id_r") )
        end if
        objRds("asaporder") = Request.Form("asaporder")
         objRds("PaymentSurcharge") = 0
        objRds("SubTotal") = vOrderSubTotal
        objRds("ShippingFee") = vOrderShipTotal
        objRds("OrderTotal") = vOrderSubTotal + vOrderShipTotal

        If ServiceChargePercentage & "" <> "" AND ServiceChargePercentage & "" <> "0" AND InRestaurantServiceChargeOnly = "false" Then
            objRds("ServiceCharge")  = (Cdbl(ServiceChargePercentage)*0.01*CDbl(vOrderSubTotal))
            'objRds("OrderTotal") = (Cdbl(ServiceChargePercentage)*0.01*CDbl(objRds("SubTotal"))) + CDbl(objRds("OrderTotal"))
        Else
            objRds("ServiceCharge") = 0
        End If
        serviceChargeAmount = objRds("ServiceCharge")
        orderTotalAmount = vOrderSubTotal + vOrderShipTotal + serviceChargeAmount
        objRds("DeliveryLat") = Request.Form("deliveryLat")
        objRds("DeliveryLng") = Request.Form("deliveryLng")

        objRds.Update 
    
        objRds.Close
        objCon.Close 

       
        vOrderTotal = vOrderSubTotal + vOrderShipTotal + serviceChargeAmount
    %>

        
    <form id="frmMakeOrder" action="MakeOrder.asp" method="post">

        <input type="hidden" name="order_id" value="<%= vOrderId%>"/>
        <input type="hidden" name="item_name" value="Order Nr. <%= vOrderId%>"/>
        <input type="hidden" name="amount" value="<%= vOrderTotal%>"/>
         <input type="hidden" name="delivery_distance" value="<%= Request.Form("deliveryDistance")%>"/>
       <div class="row clearfix" >

			<div class="col-md-6  column">
           
                <fieldset>
                <legend>Personal Details</legend>

                <div class="control-group">
                    <label class="control-label" for="FirstName">First Name *</label>
                    <div class="controls">
                        <input type="text" id="FirstName" name="FirstName" class="form-control" required placeholder="Your First Name" value="<%=Request.Cookies("firstname")%>" />



                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="LastName">Last Name *</label>
                    <div class="controls">
                        <input type="text" id="LastName" name="LastName" class="form-control" required placeholder="Your Last Name" value="<%=Request.Cookies("LastName")%>" />
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="Email">Email Address *</label>
                    <div class="controls">
                        <input  id="Email" name="Email" class="form-control" required placeholder="Your Email Address" value="<%=Request.Cookies("Email")%>"  pattern="^\s*\(?(020[7,8]{1}\)?[ ]?[1-9]{1}[0-9{2}[ ]?[0-9]{4})|(0[1-8]{1}[0-9]{3}\)?[ ]?[1-9]{1}[0-9]{2}[ ]?[0-9]{3})\s*$" />
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="Phone">Telephone *</label>
                    <div class="controls">
                      
                        <input type="text" id="Phone" name="Phone" class="form-control" required placeholder="Your Phone" value="<%= Request.Cookies("Phone")%>" />
                    </div>
                </div>

            </fieldset> 
            			
                <fieldset>
                <legend>Your Address</legend>
                    <%
                        Dim Add1, Add2, IsFromGoogle, FromGoogleHighlight, HouseNumber, PostCode
                        IsFromGoogle = true
                        FromGoogleHighlight = "" 'hightlight1
                        HouseNumber = ""
                        IF Request.Cookies("HouseNumber") & "" <> "" ANd Request.Cookies("PostCode") & "" <> "" AND (Request.Form("isChangeExistingAddress") & "" = "" or Request.Form("isChangeExistingAddress") & "" = "N")  Then
                            PostCode = Request.Cookies("PostCode")
                            HouseNumber = Request.Cookies("HouseNumber")
                            Add1 = Request.Cookies("Address")
                            Add2 = Request.Cookies("Address2")
                        Else
                            If Request.Form("deliveryAddress") & "" <> "" AND InStr(Request.Form("deliveryAddress"),"[*]") > 1 Then
                                Dim tempArrAddress 
                                tempArrAddress = Split(Request.Form("deliveryAddress"),"[*]")
                       
                                If Ubound(tempArrAddress) = 2 Then
                                    HouseNumber = tempArrAddress(0)
                                    Add1 = tempArrAddress(1)
                                    Add2 = tempArrAddress(2)
                                Else
                                    Add1 = tempArrAddress(0)
                                    Add2 = tempArrAddress(1)
                                End If
                            ElseIf Request.Form("deliveryAddress") & "" <> "" Then
                                Add1 = ""
                                Add2 = Request.Form("deliveryAddress")
                            Else
                                FromGoogleHighlight = ""
                                IsFromGoogle = false
                                Add1 = Request.Cookies("Address")
                                Add2 = Request.Cookies("Address2")
                                HouseNumber = Request.Cookies("HouseNumber")
                            End If
                            If Request.Form("deliveryPostCode") & "" <> "" Then
                                If InStr(Replace(Request.Cookies("PostCode")," ",""),Replace(Request.Form("deliveryPostCode")," ","")) > 0 AND Len(Request.Cookies("PostCode")) > Len(Request.Form("deliveryPostCode")) Then
                                    PostCode = Request.Cookies("PostCode")
                                Else
                                    PostCode = Request.Form("deliveryPostCode")
                                End If
                            ElseIf Request.Form("deliveryPC") & "" <> "" Then
                                PostCode = Request.Form("deliveryPC")
                            Else
                                PostCode = Request.Cookies("PostCode")
                            End If
                        End If
                        If IsFromGoogle OR 1 = 1 Then
                        '<label style="color:red">Your address was prefilled using Google Maps.  Please check it to ensure it is correct.</label>
                         %>
                        <div class="control-group col-sm-6 col-md-6" style="padding-left:0px;padding-right:0px">
                    <label class="control-label" for="House Number">House Number/Name *</label>                    
                    <div class="controls">
                        <input type="text" id="HouseNumber" name="HouseNumber"  class="form-control <%=FromGoogleHighlight %>" required value="<%=HouseNumber %>" />                        
                        <% if 1 = 2 Then %><input type="checkbox" id="chkNoHouseNumber" name="chkNoHouseNumber" value="Y"/><label style="font-weight:normal;">No House Number/Name</label> <% end if %>
                    </div>
                    </div> 
                        <div style="padding-left:0px;padding-right:0px" class="control-group col-sm-6 col-md-6">
                    <label class="control-label" for="Address">Street Name *</label>
                    <div class="controls">
                      
                        <input type="text" id="Address" name="Address" class="form-control <%=FromGoogleHighlight %>" required value="<%=Add1%>" />
                    </div>
                    </div> 
                     <% Else %>   
                        <div style="padding-left:0px;padding-right:0px" class="control-group col-sm-12 col-md-12">
                    <label class="control-label" for="Address">Street Name *</label>
                    <div class="controls">
                      
                        <input type="text" id="Address" name="Address" class="form-control <%=FromGoogleHighlight %>" required value="<%=Add1%>" />
                    </div>
                    </div> 
                        
                    <% End If  %>
                                     

                 <div class="control-group col-sm-12 col-md-12" style="padding-left:0px;padding-right:0px;">
                    <label class="control-label" for="Address2">Town/City *</label>
                    <div class="controls">
                        <input type="text" id="Address2" name="Address2" class="form-control <%=FromGoogleHighlight %>" required value="<%=Add2%>" />
                    </div>
                </div>
                 <div class="control-group col-sm-12 col-md-12" style="padding-left:0px;padding-right:0px;">
                    <label class="control-label" for="Postcode">Postcode *</label>
                    <div class="controls">
                        <input type="text" id="Postcode" name="Postcode" required class="form-control <%=FromGoogleHighlight %>" value="<%=PostCode %>" <% If Request.Form("deliveryType") = "d" AND Request.Form("deliveryPC") & "" <> "" then %>  readonly="true" <% end if %>  />
                    </div>
                </div>
                 <div class="control-group col-sm-12 col-md-12" style="padding-left:0px;padding-right:0px;">
                    <label class="control-label" for="Special">Special Instructions</label>
                    <div class="controls">
                        <textarea id="Special" name="Special" rows="4" class="form-control" ><%=Request.Form("Special")%></textarea>
                    </div>
                </div>
				   <div class="control-group col-sm-12 col-md-12" style="padding-left:0px;padding-right:0px;">
              
                    <div class="controls">
                        <input type="checkbox" id="cookies" name="cookies" value="yes" checked><b> Remember my details for 90 days</b>
                    </div>
                </div>
				<a href="javascript:window.history.back();" name="payment_type" value="nochex" class="btn btn-primary col-md-12" style="width: 180px; padding: 8px"><span class="
glyphicon glyphicon-chevron-left" aria-hidden="true"></span> Back to Menu</a>
            </fieldset>        
                          
		    </div>
        
		

			<div class="col-md-6">
                 <fieldset>
                <legend>Your Order</legend>
                <b> <% If Request.Form("deliveryType") = "d" Then %>Delivery<% Else %>Collection<% End If %>
               (<%if Request.Form("asaporder") = "n" then%>  <%if Request.Form("deliveryType") = "c" then%>
				   <%=DateAdd("n",vaveragecol,OrderDate)%>
				   <%else%>
				   ASAP
				   <%end if%><%else%><%= FormatDateTime(deliverytime, 2) %>&nbsp;<%= FormatDateTime(deliverytime, 4) %><%end if%>) </b><br /><br />
            <%
                
                objCon.Open sConnString
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
                objCon.Close

            else %>

               
                    <table style="width: 100%">  

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
					
					Set objCon_dishpropertiesprice = Server.CreateObject("ADODB.Connection")
					Set objRds_dishpropertiesprice = Server.CreateObject("ADODB.Recordset") 
					objCon_dishpropertiesprice.Open sConnString
	                objRds_dishpropertiesprice.Open "SELECT MenuDishproperties.ID, MenuDishproperties.dishproperty, MenuDishproperties.dishpropertyprice, MenuDishpropertiesGroups.dishpropertypricetype, MenuDishpropertiesGroups.dishpropertygroup FROM MenuDishproperties INNER JOIN MenuDishpropertiesGroups ON MenuDishproperties.dishpropertygroupid = MenuDishpropertiesGroups.ID where (((MenuDishproperties.ID)=" & dishpropertiessplit2(1)  & "))", objCon
					if not objRds_dishpropertiesprice.EOF then
					response.write "<BR> <small>" & objRds_dishpropertiesprice("dishpropertygroup") & ":" & objRds_dishpropertiesprice("dishproperty") & "</small>"
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
						toppingtext = toppingtext & objRds_toppingids("topping") & ", "
						objRds_toppingids.MoveNext
						loop
						if toppingtext<>"" then
							toppingtext=left(toppingtext,len(toppingtext)-2)
						response.write "<small><br>Toppings: " & toppingtext & "</small>"
						end if
						 End If  %>
						</td>
                                <td style="padding-right: 20px; text-align: right;" valign="top"><%=CURRENCYSYMBOL%><%= FormatNumber(objRds("Total"), 2) %></td>                                    
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
						

							<%if discountcodeused<>"" then%>
		<tr>
            <td style="padding-top: 5px; border-top: 1px dotted black;"><b>Voucher</b><br /><%=vouchercode %>(<%=discountcodeused%>) </td>
            <td style="padding-top: 5px; border-top: 1px dotted black;text-align: right;padding-right: 20px;">
			
			
			<span id="voucher">-<%=CURRENCYSYMBOL%><%= FormatNumber((( vOrderSubTotal * 100 )/(100- Cdbl(Replace(Replace(Replace(discountcodeused,"-",""),"%","")," ",""))) - vOrderSubTotal ),2) %> </span></td>
            <td style="padding-top: 5px; border-top: 1px dotted black;">&nbsp;</td>
        </tr>
		<%end if%>
        
        
                         <tr>
                            <td style="padding-top: 5px; border-top: 1px dotted black;">SubTotal</td>
                            <td style="padding-top: 5px; padding-right: 20px; text-align: right; border-top: 1px dotted black;"><%=CURRENCYSYMBOL%><%= FormatNumber(vOrderSubTotal, 2)  %></td>
                            <td style="padding-top: 5px; border-top: 1px dotted black;">&nbsp;</td>
                        </tr>       
                        
                        <% if CDbl(vOrderShipTotal) > 0 Then %>
                        <tr>
                            <td style="padding-top: 5px;">Delivery Fee</td>
                            <td style="padding-top: 5px; padding-right: 20px; text-align: right;"><%=CURRENCYSYMBOL%><%= FormatNumber(vOrderShipTotal, 2)  %></td>
                            <td style="padding-top: 5px;">&nbsp;</td>
                        </tr>       
                        <% End if 
                        If CDBl(serviceChargeAmount) > 0 Then
                            %>
                         <tr>
                            <td style="padding-top: 5px;">Service Charge</td>
                            <td style="padding-top: 5px; padding-right: 20px; text-align: right;"><%=CURRENCYSYMBOL%><%= FormatNumber(serviceChargeAmount, 2)  %></td>
                            <td style="padding-top: 5px;">&nbsp;</td>
                        </tr>       
                        <% End If %>
                        <tr>
                            <td style="padding-top: 5px;"><b>Total</b></td>
                            <td style="padding-top: 5px; padding-right: 20px; text-align: right;"><%=CURRENCYSYMBOL%><b><%= FormatNumber(vOrderTotal, 2)  %></b></td>
                            <td style="padding-top: 5px;">&nbsp;</td>
                        </tr>    
                           
                        <tr>
                            <td colspan="3">&nbsp;</td>    
                        </tr>

                        <tr>
                            <td colspan="3" style="text-align: center" >
                                <div id="processpayment" class="processpaymentblock"  style="max-width:555px;">
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
                             isOrder =  true
                            divCount = divCount + 1%>
                               <!--<div style="float:left;padding:2px;" <%=popoverAttr %>>
							<button <%=disableButton %> type="submit" name="payment_type" value="nochex"  class="btn btn-primary" style="width: 180px; padding: 8px">Pay by Debit/Credit Card<br>
(Nochex)<br>(<%=CURRENCYSYMBOL%><%=CREDITCARDSURCHARGE%> surcharge)</button> </div>-->
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
                           

                                  <!-- <div style="float:left;padding:2px;" <%=popoverAttr %>>
                              <button <%=disableButton %>  type="submit" name="payment_type" value="paypal"  class="btn btn-danger" style="width: 180px; padding: 8px">Pay by Debit/Credit Card<br>
(Paypal)<br>(<%=CURRENCYSYMBOL%><%=CREDITCARDSURCHARGE%> surcharge)</button>      </div>-->
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
                            <!--<div style="float:left;padding:2px;" <%=popoverAttr %>>
							<button <%=disableButton %>  type="submit" name="payment_type" value="worldpay"  class="btn btn-primary" style="width: 180px; padding: 8px">Pay by Debit/Credit Card<br>
(Worldpay)<br>(<%=CURRENCYSYMBOL%><%=CREDITCARDSURCHARGE%> surcharge)</button>   </div>-->
                              <div class="block-direct" <%=popoverAttr %>>
                              <button <%=disableButton %>  type="submit" name="payment_type" value="worldpay"  class="btn btn-primary btn-block btn-worldpay" ><!--Pay by Debit/Credit Card (Worldpay)--><br><br>(<%=CURRENCYSYMBOL%><%=CREDITCARDSURCHARGE%> surcharge)</button>
                            </div>
					<%end if%>	
					  <!--<div style="<%if divCount < 3 Then %>float:left;<% end if %>padding:2px;" id="paybycash">
                                <button type="submit" name="payment_type"  value="cash_delivery" class="btn btn-success" style="width: 180px; padding: 8px"><br>
Cash Payment<br>
<br>
</button>       </div>-->
                                      <%   if isOrder = true then
                                    %>
                                         <div class="divider-or">OR</div>
                                                <%
                                    end if
                                    %>
                        
                                    <div class="block-cash">
							        <button  type="submit" name="payment_type" value="cash_delivery"  class="btn btn-info btn-block">Pay by Cash</button>   
                                    </div>
                                    </div>
                            </td>
                        </tr>

                    </table>
          
                <%
                End If
                %>  
            </fieldset>
		    </div>	
		                
	    </div>

    </form>

</div>

   

<script type="text/javascript">
    function CheckDistanceLatLng(firstResult) {

            var geocoder = new google.maps.Geocoder();
            geocoder.geocode({"address":firstResult }, function(results, status) {
                if (status == google.maps.GeocoderStatus.OK && results[0]) {
                    var tempLat = results[0].geometry.location.lat(),
                        tempLng = results[0].geometry.location.lng();
               
                  
                    var tempStreetNumber2 = '', tempRouteName2 = '', tempLocalcity2= '';
		              
                    for (i = 0; i < results[0].address_components.length; i++)
                    {
                        if (results[0].address_components[i].types[0] == "street_number") {
                            tempStreetNumber2 = results[0].address_components[i].short_name + ' ';
                        }
                        else if (results[0].address_components[i].types[0] == "route") {
                            tempRouteName2 = results[0].address_components[i].short_name;
                        }
                        else if (results[0].address_components[i].types[0] == "locality") {
                            tempLocalcity2 = results[0].address_components[i].short_name;
                        }
                        else if (results[0].address_components[i].types[0] == "postal_town") {
                            tempLocalcity2 = results[0].address_components[i].short_name;
                        }
                    }
                    if(tempStreetNumber2!="")
                        $("#Address").val(tempStreetNumber2);
                    else if(tempRouteName2!="") $("#Address").val(tempRouteName2);
                    if(tempLocalcity2!="")
                        $("#Address2").val(tempLocalcity2);
                                  
                      
                    
                }
                
            });  
            return ;          
    }
    <% if individualpostcodeschecking <> 0 then %>
    CheckDistanceLatLng('<%=PostCode%>');
    <% end if %>
    $(document).ready(function () {
        if($("#processpayment button").length==4){
            if($("#processpayment").width() <=550){
                $("#paybycash").css("float","left");
                
            }else{
                $("#paybycash").css("float","none");
            }
        }
        $(window).on('resize', function () {
            if($("#processpayment button").length==4){
                if($("#processpayment").width() <=550){
                    $("#paybycash").css("float","left");
                    
                }else{
                    $("#paybycash").css("float","none");
                    
                }
            }
        }); 

        var hour = <%= DatePart("h", DateAdd("h",houroffset,now), vbMonday, 1) + 1%>;
        if(hour < 10) hour = '0' + hour;
        $("select[name=p_hour]").find('option[value=' + hour + ']').attr("selected", true);

       

        //        $.validator.addMethod(
        //            "zipcode",
        //            function (value, element) {
        //                alert('');
        //                var url = 'http://maps.googleapis.com/maps/api/distancematrix/json?origins=<%=sPostalCode %>&destinations=';
        //                var distance = -1;
        //                $.ajax({
        //                    type: 'GET',
        //                    url: url + value + "&mode=auto&language=en&sensor=false",
        //                    dataType: 'json',
        //                    success: function (data) {
        //                        if (data.rows
        //                        && data.rows.length > 0) {
        //                            if (data.rows[0].elements
        //                            && data.rows[0].elements.length > 0) {
        //                                if (data.rows[0].elements[0].status == 'OK')
        //                                    distance = data.rows[0].elements[0].distance.value;
        //                            }
        //                        }
        //                    },
        //                    data: {},
        //                    async: false
        //                });

        //                if (distance >= 0)
        //                    $("#OrderMinModal div.modal-body").html("Sorry, the maximum distance for delivery is " + (max_km / 1000).toFixed(2) + " Km <br />");

        //                return distance >= 0;
        //            },
        //            "ZipCode Not Correct"
        //        );

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
                return true;
            }
          
        });
        
       

        $('[data-toggle="popover"]').popover({ trigger: "hover" });   

    });
	
	
</script>

    <script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

  ga('create', '<%=googleecommercetrackingcode %>', 'auto');
  ga('send', 'pageview');

</script>

</body>
</html>

