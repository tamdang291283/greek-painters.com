
<%
 
     if Session("ResID") & "" <> "" then            
        session("restaurantid") = Session("ResID")
        Session("ResID") = ""
    else
         if request.querystring("id_r") & "" <> "" then
            session("restaurantid") = request.querystring("id_r")
        end if
    end if
   
if session("restaurantid")="" then
     if request.querystring("id_r") & "" <> "" then
        response.redirect(SITE_URL & "menu.asp?id_r=" & request.querystring("id_r") & "&timeout=yes")
      else 
        response.redirect(SITE_URL & "error.asp")
    end if
end if
   
    %>

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
	
	<link href="<%=SITE_URL %>css/bootstrap.min.css" rel="stylesheet">
	<link href="<%=SITE_URL %>css/style.css" rel="stylesheet">    
	<link href="<%=SITE_URL %>css/datepicker.css" rel="stylesheet">
    <!--<link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css" rel="stylesheet">-->
    <link href=" //stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">

  <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
    <script src="Scripts/html5shiv.js"></script>
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

    function ShippingFee(byval DistanceMile,byval UserDistance, byval DeliveryFeev, byval freeDistnace,byval DeliveryCostUpTo, byval DeliveryUptoMile)
   
            Dim Ratio,numbermod  
            Dim Result : Result = 0
          '  Response.Write("DeliveryFeev " & DeliveryFeev & " DistanceMile " & DistanceMile & " UserDistance " & UserDistance & " freeDistnace " & freeDistnace & "<br/>")
            if UserDistance & "" = "" then
                    UserDistance = 0
            end if
             ' Response.Write("UserDistance " & UserDistance & " freeDistnace " & freeDistnace & "<br/>")
            if cdbl(UserDistance) <= cdbl(freeDistnace) and cdbl(freeDistnace) > 0 then
                Result = 0
            elseif ( DistanceMile & "" <> "" and DistanceMile & "" <> "0")  or (cdbl(DeliveryCostUpTo) > 0 and   cdbl(DeliveryUptoMile) > 0)  then
               
                'UserDistance =cdbl( UserDistance) - cdbl(freeDistnace)
                UserDistance =cdbl( UserDistance)
                dim DeliveryExtraCost : DeliveryExtraCost = 0
                if  cdbl( DeliveryCostUpTo) > 0 and  cdbl( DeliveryUptoMile) > 0 then
                    if cdbl( UserDistance) > cdbl(DeliveryUptoMile) then
                        UserDistance =cdbl( UserDistance) - cdbl(DeliveryUptoMile)
                        DeliveryExtraCost = cdbl(DeliveryCostUpTo)
                    else
                        UserDistance = 0
                        DeliveryExtraCost = cdbl(DeliveryCostUpTo)
                    end if

                end if  
        
                DistanceMile = cdbl(DistanceMile)
                if (UserDistance * 100) mod (DistanceMile * 100) > 0  then
                    Ratio = 1 + ( UserDistance * 100 - ((UserDistance * 100) mod (DistanceMile * 100))) / (DistanceMile * 100 )
                else
                    Ratio = ( UserDistance * 100 ) / (DistanceMile * 100)
                end if
                      
                  Result = Ratio * DeliveryFeev + DeliveryExtraCost
  
                       ' Response.End
            else
                   Result = distancefee
            end if
            'Response.Write("Result " & Result & "<br/>")
            ShippingFee = Result

    end function 

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
      '' Get Url Menu, checkout , thanks
    dim MenuURL,CheckoutURL,ThankURL
     objCon.Open sConnString
    MenuURL =  SITE_URL & "menu.asp?id_r=" & vRestaurantId
    if vRestaurantId & "" <> "" then
           dim rs_url :  set rs_url = Server.CreateObject("ADODB.Recordset")
               rs_url.open "SELECT FromLink FROM URL_REWRITE a   inner join BusinessDetails b   on (a.RestaurantID=b.ID )  where RestaurantID=" & vRestaurantId & " and EnableUrlRewrite = 'Yes' and status = 'ACIVE' " ,objCon
            while not rs_url.eof 
               
               if instr(lcase(rs_url("FromLink")),"/menu") > 0 then
                     MenuURL = rs_url("FromLink")
               elseif  instr(lcase(rs_url("FromLink")),"/checkout") > 0 then
                     CheckoutURL = rs_url("FromLink")
               elseif instr(lcase(rs_url("FromLink")),"/thanks") > 0 then
                     ThankURL = rs_url("FromLink")
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

   
    objRds.Open "SELECT * FROM BusinessDetails   WHERE Id = " & vRestaurantId, objCon
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

    Dim DeliveryCostUpTo : DeliveryCostUpTo = objRds("DeliveryCostUpTo") & ""
    if DeliveryCostUpTo = "" then
        DeliveryCostUpTo = 0
    end if
   
    Dim DeliveryUptoMile : DeliveryUptoMile = objRds("DeliveryUptoMile") & ""
     if DeliveryUptoMile = "" then
        DeliveryUptoMile = 0
    end if
    Dim DeliveryFee : DeliveryFee = objRds("DeliveryFee") & ""
    if DeliveryFee <> "" then
       DeliveryFee  =cdbl(DeliveryFee)
    else
        DeliveryFee = 0 
    end if
    Dim DistanceMile : DistanceMile = objRds("DeliveryMile") & ""

    if DistanceMile <> "" then
       DistanceMile  =cdbl(DistanceMile)
    else
        DistanceMile = 0 
    end if

    vOrderShipTotal = ShippingFee( DistanceMile, Request.Form("deliveryDistance"),DeliveryFee,sDeliveryFreeDistance,DeliveryCostUpTo,DeliveryUptoMile)
    
     
     
     Dim FirstNameCustomer,LastNameCustomer,EmailCustomer,PostaLCodeCustomer,AddressCustomer,Telno
   
    if Request.Cookies("FormAddress") & ""  <> "" and Request.Cookies("FormPostCode") & "" <> ""  then
        FirstNameCustomer = replace(Request.Cookies("FormFirstName") & "","[space]"," ")
        LastNameCustomer = replace(Request.Cookies("FormLastName") & "","[space]"," ")
        EmailCustomer = replace(Request.Cookies("FormEmail") & "","[space]"," ")
       ' Response.Write("EmailCustomer " & EmailCustomer & " <br/> ")
        Telno = replace( Request.Cookies("FormPhoneNumber") & "","[space]"," ")
        AddressCustomer  = replace( Request.Cookies("FormAddress") & "","[space]"," ")
       ' Response.Write(AddressCustomer)
        PostaLCodeCustomer = replace(Request.Cookies("FormPostCode") & "","[space]"," ")
       ' Response.Write("AddressCustomer " & AddressCustomer & " <br/>")
        if AddressCustomer& ""  <> "" then
            dim arrAddressCustomer : arrAddressCustomer =  split(AddressCustomer,",")
            dim lindex : lindex = 0 
             for  lindex = 0 to ubound(arrAddressCustomer)
                if arrAddressCustomer(lindex) & "" <> "" then
                    if lindex = ubound(arrAddressCustomer) then                  
                        Address2Customer = arrAddressCustomer(lindex)
                    else
                        Address1Customer = Address1Customer & arrAddressCustomer(lindex) & ","
                    end if
                end if
                
             next
      
             if Address1Customer & "" <> "" then
                Address1Customer  = left(Address1Customer,len(Address1Customer)-1)
             end if

          
             if Address1Customer <> "" then
                lindex = 0
                dim arrAddress1Customer : arrAddress1Customer = split(Address1Customer," ")
                Address1Customer= ""
                for  lindex = 0 to ubound(arrAddress1Customer)
                    if HouseNumberCustomer  ="" then
                        HouseNumberCustomer = arrAddress1Customer(lindex)
                    else
                        Address1Customer = Address1Customer & arrAddress1Customer(lindex) & " "
                    end if     
                next
              end if
            
        end if
     
    else
        FirstNameCustomer = Request.Cookies("firstname") & "" 
        LastNameCustomer = Request.Cookies("LastName") & ""
        EmailCustomer = Request.Cookies("Email") & ""
        PostaLCodeCustomer =  Request.Cookies("PostCode") & ""
       ' AddressCustomer = RSCustomerInfo("PostalCode") & "" 
        Telno =  Request.Cookies("Phone") & ""
        HouseNumberCustomer = Request.Cookies("HouseNumber") & "" 
        Address1Customer = Request.Cookies("Address") & "" 
        Address2Customer = Request.Cookies("Address2") & "" 
    end if
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
        <div class="col-md-12 col-xs-12" style="padding-bottom:10px;" id="topmenumobile">
            <div class="media">
                 <a href="#" class="pull-left"><img src="<%= objRds("ImgUrl") %>" width=70 class="media-object" alt="<%= objRds("Name") %>"></a>
                <div class="media-body">
                    <h4 class="media-heading">                
                <div style="float:right;">                
                <div class="hidden-xs u-display-block">
          <% if URL_Facebook & "" <> "" or _ 
              URL_Twitter & "" <> "" or _  
              URL_Google & "" <> "" or _  
              URL_Linkin & "" <> "" or _ 
              URL_YouTube & "" <> "" or _ 
              URL_Intagram & "" <> "" or _ 
              URL_Tripadvisor & "" <> "" then  %>
        <div class="social-header dis-hide">
            <% if URL_Facebook & "" <> "" then  %>
            <a href="<%=URL_Facebook %>" title="facebook" target="_blank"><i class="fa fa-facebook" aria-hidden="true"></i></a>
            <% end if %>
            <% if URL_Twitter & "" <> "" then  %>
            <a href="<%=URL_Twitter %>" title="twitter"  target="_blank"><i class="fa fa-twitter" aria-hidden="true"></i></a>
            <% end if %>
            <% if URL_Google & "" <> "" then  %>
            <a href="<%=URL_Google %>" title="google plus"  target="_blank"><i class="fa fa-google-plus" aria-hidden="true"></i></a>
            <% end if  %>
            <% if URL_Linkin & "" <> "" then  %>
            <a href="<%=URL_Linkin %>" title="linkedin"  target="_blank"><i class="fa fa-linkedin" aria-hidden="true"></i></a>
            <% end if %>
             
            <% if URL_Intagram & "" <> "" then  %>
            <a href="<%=URL_Intagram %>" title="instagram"  target="_blank"><i class="fa fa-instagram" aria-hidden="true"></i></a>
            <% end if %>
              <% if URL_YouTube & "" <> "" then  %>
            <a href="<%=URL_YouTube %>" title="youtube"  target="_blank"><i class="fa fa-youtube" aria-hidden="true"></i></a>
            <% end if %>
             
              <% if URL_Tripadvisor & "" <> "" then  %>
            <a href="<%=URL_Tripadvisor %>" title="tripadvisor"  target="_blank"><i class="fa fa-tripadvisor" aria-hidden="true"></i></a>
            <% end if %>
        </div>

        <% end if %>
                <i class="fa fa-phone"></i> <%= objRds("Telephone") %> 
<span class="glyphicon glyphicon glyphicon-envelope"></span>  <%= objRds("Email") %></div>

<div class="visible-xs icon-thumb">

    <script>
       var isconfirm = false;
       
        function confimBookTable()
        {
            if(isconfirm==false)
               isconfirm = confirm("Note: You can add food to your table booking by putting dishes in your shopping-basket and then clicking on the 'book a table' link again");
            var htmlItem = "";
            if(isconfirm==true)
                {
                    
                      //  listitemincart

                    htmlItem="";
                    $("#divShoppingCartSroll table tr").each(function(){
                            htmlItem += "<tr>";
                                    htmlItem += "<td name=\"itemName\">" + $(this).find("[name=itemName]").html()  + "</td>";
                                    htmlItem += "<td name=\"itemPrice\" style=\"vertical-align:top\">" + $(this).find("[name=itemPrice]").html() + "</td>";
                            htmlItem += "</tr>";
                    });
                    if(htmlItem!="")
                        {
                            var wrapItem ="";
                            wrapItem="<div class=\"panel panel-primary\">";
                            wrapItem+="    <div class=\"panel-heading\">";
                            wrapItem+="        <h3 class=\"panel-title\"><span class=\"glyphicon glyphicon glyphicon-shopping-cart\"></span>Your Order</h3>";
                            wrapItem+="    </div> ";
                            wrapItem+="    <div class=\"panel-body\" style=\"padding:15px 8px 15px 8px;\">";
                            wrapItem+="        <div> ";
                            wrapItem+="            <div class=\"shoppingCartScroll\"> ";
                            wrapItem+="                <table style=\"width: 100%\"> ";
                            wrapItem+="                    <tbody> ";
                            wrapItem+=htmlItem;

                            wrapItem+="                     </tbody> ";
                            wrapItem+="                 </table> ";
                            wrapItem+="             </div> ";
             
                            wrapItem+="         </div> ";
                            wrapItem+="     </div> ";
                            wrapItem+=" </div>";
                            htmlItem = wrapItem;
                        }
                      
                        //htmlItem = "<div class=\"w3-padding w3-white notranslate\"><table class=\"table table-bordered\"><tbody>" + htmlItem + "</tbody></table></div>";
                }
            if(htmlItem=="")
        
                htmlItem = "<div class='row'><div class='col-md-1 col-xs-1'><i class='fa'>&#xf022;</i></div> <div class='col-md-11 col-xs-11'><label style='color:darkolivegreen ;'>You can add food to your table booking by putting dishes in your shopping-basket and then clicking on the 'book a table' link again.</label></div> </div>";
            $("#listitemincart").html(htmlItem);
            return true;
        }
        
    </script>
<a href="https://www.google.co.uk/maps?q=<%= objRds("Address") %>" target="_blank"><span class="glyphicon glyphicon-map-marker"></span></a>
<a href="tel:<%= objRds("Telephone") %>"><span class="glyphicon glyphicon-earphone"></span></a>
<a href="mailto:<%= objRds("Email") %>"><span class="glyphicon glyphicon-envelope"></span></a>
<a href="#" title="gift" class="social-icon-visible"><span><i class="fa fa-gift" aria-hidden="true"></i></span></a>
   <% if URL_Facebook & "" <> "" or _ 
              URL_Twitter & "" <> "" or _  
              URL_Google & "" <> "" or _  
              URL_Linkin & "" <> "" or _ 
              URL_YouTube & "" <> "" or _ 
              URL_Intagram & "" <> "" or _ 
              URL_Tripadvisor & "" <> "" then  %>

<div class="social-thumb dis-hide">
  <span class="social-text">|</span>
    <% if URL_Facebook & "" <> "" then %>
  <a href="<%=URL_Facebook %>" title="facebook" class="social-icon"  target="_blank"><i class="fa fa-facebook" aria-hidden="true"></i></a>
    <% end if %>
        <% if URL_Twitter & "" <> "" then %>
  <a href="<%=URL_Twitter %>" title="twitter" class="social-icon"  target="_blank"><i class="fa fa-twitter" aria-hidden="true"></i></a>
    <% end if %>
         <% if URL_Google & "" <> "" then %>
  <a href="<%=URL_Google %>" title="google plus" class="social-icon"  target="_blank"><i class="fa fa-google-plus" aria-hidden="true"></i></a>
    <% end if %>
       <% if URL_Linkin & "" <> "" then %>
  <a href="<%=URL_Linkin %>" title="linkedin" class="social-icon"  target="_blank"><i class="fa fa-linkedin" aria-hidden="true"></i></a>
    <% end if %>
    <% if URL_Intagram & "" <> "" then %>
  <a href="<%=URL_Intagram %>" title="instagram" class="social-icon"   target="_blank"><i class="fa fa-instagram" aria-hidden="true"></i></a>
    <% end if %>
     <% if URL_YouTube & "" <> "" then %>
  <a href="<%=URL_YouTube %>" title="youtube" class="social-icon"   target="_blank"><i class="fa fa-youtube" aria-hidden="true"></i></a>
    <% end if %>
     
     <% if URL_Tripadvisor & "" <> "" then %>
  <a href="<%=URL_Tripadvisor %>" title="tripadvisor" class="social-icon"   target="_blank"><i class="fa fa-tripadvisor" aria-hidden="true"></i></a>
    <% end if %>
</div>
<% end if %>
</div>



</div>  
                         <%= objRds("Name") %>
                         

                    </h4><div class="hidden-xs">
                            <b><%= objRds("Address") %> </b><br>
                        </div>


<%= objRds("FoodType") %>
                    
            </div>
            </div>
        </div>
         

    </div> <!-- end header -->




       

        
    <%            
        objRds.Close      
        set  objRds =  nothing 
        'objCon.Close

        if Session.SessionID & "" = "" then
             objCon.close()
            set objCon = nothing
             response.redirect(SITE_URL & "error.asp")
        end if
        'objCon.Open sConnString
        set objRds = Server.CreateObject("ADODB.Recordset")
        objRds.Open "select o.* from [Orders] o  " & _
            " Where o.IdBusinessDetail = " & vRestaurantId & _
            " And o.SessionId = '" & Session.SessionID & "'", objCon, 1, 3 
            
			discountcodeused=""
        vouchercode = ""
    if objRds.EOF then
            objRds.close()
        set objRds =  nothing
            objCon.close()
        set objCon = nothing
        response.redirect(SITE_URL &  "error.asp")
    end if
        dim VoucherDiscontType : VoucherDiscontType =""
	if objRds("vouchercodediscount") <> 0 or objRds("vouchercode") & "" <> ""  then
	    discountcodeused= "-" & objRds("vouchercodediscount") & "%"
        vouchercode = objRds("vouchercode")
        VoucherDiscontType = objRds("DiscountType")
	end if
			
        vOrderId = objRds("Id")
        vOrderSubTotal = cdbl(objRds("SubTotal"))
		
		 ' Response.Write("Mod " & (100 * 2.3 mod 100 * 0.5 ) & "<br/>")
          'Response.Write("UserDistance " & Request.Form("deliveryDistance") & " sDeliveryFreeDistance " & sDeliveryFreeDistance & " Delivery Fee " & DeliveryFee & " distance mile " & DistanceMile & "<br/>")
     
        If Request.Form("deliveryType") <> "d" Then
            vOrderShipTotal = 0
        elseIf Request.Form("deliveryDistance") <> "" and cdbl(sDeliveryFreeDistance) > 0 Then
        'elseIf Request.Form("deliveryDistance") <> ""  Then
            dim UserDistance : UserDistance = cdbl(Request.Form("deliveryDistance"))
            vOrderShipTotal =  ShippingFee( DistanceMile, UserDistance,DeliveryFee,sDeliveryFreeDistance,DeliveryCostUpTo,DeliveryUptoMile)
           ' Response.Write("vOrderShipTotal " & vOrderShipTotal & " sDeliveryFreeDistance " & sDeliveryFreeDistance & "<br/>")
            If UserDistance <= sDeliveryFreeDistance Then vOrderShipTotal = 0                              
        end if
   
		if cdbl( vOrderSubTotal) > cdbl( sDeliveryChargeOverrideByOrderValue) then
            
			vOrderShipTotal = 0
		end if
		'Response.Write("vOrderShipTotal " &vOrderShipTotal & " sDeliveryChargeOverrideByOrderValue " & sDeliveryChargeOverrideByOrderValue & "<br/>")
			
		Dim OrderDate, deliverytime, orderTotalAmount, serviceChargeAmount
      
        OrderDate =  DateAdd("h",houroffset,now)
        objRds("OrderDate") = DateAdd("h",houroffset,now)
        objRds("DeliveryType") = Request.Form("deliveryType")
        objRds("deliverydelay") = Request.Form("deliverydelay")
        objRds("collectiondelay") = Request.Form("collectiondelay")
        if Request.Form("deliveryTime") & ""  <> "" and instr( trim(Request.Form("deliveryTime"))," ") > 0  then
		    coltimesplit=split(Request.Form("deliveryTime")," ")
		    coltime=coltimesplit(1)
		end if
        objRds("DeliveryTime") = JXIsoDate(Request.Form("deliveryTime")) + " " + coltime
        deliverytime = JXIsoDate(Request.Form("deliveryTime")) + " " + coltime
        if deliverytime & "" = "" then 
                 'objRds.close()
            set objRds =  nothing
                objCon.close()
            set objCon = nothing
            response.redirect(MenuURL)
        end if
        objRds("asaporder") = Request.Form("asaporder")
         objRds("PaymentSurcharge") = 0
        objRds("SubTotal") = vOrderSubTotal
        objRds("ShippingFee") = vOrderShipTotal
        objRds("OrderTotal") = vOrderSubTotal + vOrderShipTotal

        If ServiceChargePercentage & "" <> "" AND ServiceChargePercentage & "" <> "0" AND InRestaurantServiceChargeOnly = "0" Then
            objRds("ServiceCharge")  = (Cdbl(ServiceChargePercentage)*0.01*CDbl(vOrderSubTotal))
            'objRds("OrderTotal") = (Cdbl(ServiceChargePercentage)*0.01*CDbl(objRds("SubTotal"))) + CDbl(objRds("OrderTotal"))
        Else
            objRds("ServiceCharge") = 0
        End If

        '' Calculate Tax 
             If Tax_Percent & "" <> "" AND Tax_Percent & "" <> "0" AND InRestaurantTaxChargeOnly = "0" Then
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
             If Tip_percent & "" <> "" AND Tip_percent & "" <> "0" AND InRestaurantTipChargeOnly = "0" Then
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
                'objRds("Tip_Rate")  =0
            End If
        dim TaxAmount,TipAmount
        '' End 
        TaxAmount = objRds("Tax_Amount")
        TipAmount = objRds("Tip_Amount")
        serviceChargeAmount = objRds("ServiceCharge")
        objRds("OrderTotal") = vOrderSubTotal + vOrderShipTotal + serviceChargeAmount + TaxAmount + TipAmount
        orderTotalAmount = vOrderSubTotal + vOrderShipTotal + serviceChargeAmount + TaxAmount + TipAmount
       Dim deliveryLat,deliveryLng
           deliveryLat =  Request.Form("deliveryLat") 
           deliveryLng = Request.Form("deliveryLng")
            if Request.Form("deliveryType") = "d" then
                    if deliveryLat & "" = "" and request.Form("hidLat") & "" <> ""   then
                                objRds("lng_report")  =  Request.Form("hidLng") 
                                objRds("lat_report")  =   Request.Form("hidLat") 
                     else
                                objRds("lng_report")  =  deliveryLng
                                objRds("lat_report")  =  deliveryLat 
                    end if
            end if
        objRds("DeliveryLat") = Request.Form("deliveryLat")
        objRds("DeliveryLng") = Request.Form("deliveryLng")

        objRds.Update 
    
            objRds.Close
        set objRds =  nothing
        'objCon.Close 
        'Response.Write("vOrderSubTotal " & vOrderSubTotal & " vOrderShipTotal " & vOrderShipTotal & " serviceChargeAmount " & serviceChargeAmount & " TaxAmount " & round(TaxAmount,2) & " TipAmount " & round(TipAmount,2) & "<br/>")
        vOrderTotal = vOrderSubTotal + vOrderShipTotal + round(serviceChargeAmount,2) + round(TaxAmount,2) + round(TipAmount,2)
    %>

        
    <form id="frmMakeOrder" action="<%=SITE_URL %>MakeOrder.asp" method="post">
        <input type="hidden" name="Stripe_Token" id="Stripe_Token" value="" />
        <input type="hidden" name="order_id" value="<%= vOrderId%>"/>
        <input type="hidden" name="item_name" value="Order Nr. <%= vOrderId%>"/>
        <input type="hidden" name="amount" value="<%= FormatNumber(vOrderTotal, 2)%>"/>
        <input type="hidden" name="vOrderSubTotal" value="<%=vOrderSubTotal %>" />
         <input type="hidden" name="delivery_distance" value="<%= Request.Form("deliveryDistance")%>"/>
       <div class="row clearfix" >
			<div class="col-md-6  column" id="panel-left">
                <fieldset>
                <legend>Personal Details</legend>
                <div class="control-group">
                    <label class="control-label" for="FirstName">First Name *</label>
                    <div class="controls">
                        <input type="text" id="FirstName" name="FirstName" class="form-control" required placeholder="Your First Name" value="<%=FirstNameCustomer%>" />
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="LastName">Last Name *</label>
                    <div class="controls">
                        <input type="text" id="LastName" name="LastName" class="form-control" required placeholder="Your Last Name" value="<%=LastNameCustomer%>" />
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="Email">Email Address *</label>
                    <div class="controls">
                        <input  id="Email" name="Email" class="form-control" required placeholder="Your Email Address" value="<%=EmailCustomer%>"  type="email" />
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="Phone">Telephone *</label>
                    <div class="controls">
                      
                        <input id="Phone" name="Phone" class="form-control" required placeholder="Your Phone" value="<%=Telno%>" type="number" pattern="\d+" />
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
                   
                        IF HouseNumberCustomer & "" <> "" ANd PostaLCodeCustomer & "" <> "" AND (Request.Form("isChangeExistingAddress") & "" = "" or Request.Form("isChangeExistingAddress") & "" = "N")  Then
                           ' Response.Write("ok1<br/>")
                            PostCode = PostaLCodeCustomer 'Request.Cookies("PostCode")
                            HouseNumber =HouseNumberCustomer 'Request.Cookies("HouseNumber")
                            Add1 = Address1Customer 'Request.Cookies("Address")
                            Add2 = Address2Customer 'Request.Cookies("Address2")
                            
                        Else
                     '   Response.Write("ok2<br/>")
                         
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
                                Add1 = Address1Customer 'Request.Cookies("Address")
                                Add2 = Address2Customer 'Request.Cookies("Address2")
                                HouseNumber =  HouseNumberCustomer 'Request.Cookies("HouseNumber")
                              
                            End If
                            If Request.Form("deliveryPostCode") & "" <> "" Then
                                If InStr(Replace(PostaLCodeCustomer," ",""),Replace(Request.Form("deliveryPostCode")," ","")) > 0 AND Len(PostaLCodeCustomer) > Len(Request.Form("deliveryPostCode")) Then
                                    PostCode = PostaLCodeCustomer'Request.Cookies("PostCode")
                                Else
                                    PostCode = Request.Form("deliveryPostCode")
                                End If
                            ElseIf Request.Form("deliveryPC") & "" <> "" Then
                                PostCode = Request.Form("deliveryPC")
                            Else
                                PostCode = PostaLCodeCustomer 'Request.Cookies("PostCode")
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
                        
                    <% End If
                     
                          %>
                  
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
                    <% if isCheckCapcha  = "Yes" then %>
                    <div class="control-group col-sm-12 col-md-12" style="padding-left:0px;padding-right:0px;">
                    <iframe id="frmCapcha" height="101" width="100%" src="<%=SITE_URL %>iframeCapcha.html?v=3" scrolling="no" style="border:none;"></iframe>
                    </div>
                    <% end if %>
				   <div class="control-group col-sm-12 col-md-12" style="padding-left:0px;padding-right:0px;">              
                    <div class="controls">
                        <input type="checkbox" id="cookies" name="cookies" value="yes" checked><b> Remember my details for 90 days</b>
                    </div>
                </div>
				<a href="javascript:window.history.back();" name="payment_type" value="nochex" class="btn btn-primary col-md-12" style="width: 180px; padding: 8px;margin-top:20px;"><span class="
glyphicon glyphicon-chevron-left" aria-hidden="true"></span> Back to Menu</a>
            </fieldset>        
                          
		    </div>
        
		

			<div class="col-md-6">
                 <fieldset>
                <legend>Your Order</legend>
                <b> <% If Request.Form("deliveryType") = "d" Then %>Delivery<% Else %>Collection<% End If %>
               (<%if Request.Form("asaporder") = "n" then%>  <%if Request.Form("deliveryType") = "c" then%>
				   <%=formatDateTimeC( DateAdd("n",vaveragecol,OrderDate))%>
				   <%else%>
				   ASAP
				   <%end if%><%else%><%= formatDateTimeC(deliverytime) %><%end if%>) </b><br /><br />
            <%
                
                'objCon.Open sConnString
                Set objRds = Server.CreateObject("ADODB.Recordset") 
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
                set objRds = nothing
                objCon.Close
                set objCon = nothing
                
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
					            Set objRds_dishpropertiesprice = Server.CreateObject("ADODB.Recordset") 
	                                objRds_dishpropertiesprice.Open "SELECT MenuDishproperties.ID, MenuDishproperties.dishproperty, MenuDishproperties.dishpropertyprice, MenuDishpropertiesGroups.dishpropertypricetype, MenuDishpropertiesGroups.dishpropertygroup FROM MenuDishproperties   INNER JOIN MenuDishpropertiesGroups   ON MenuDishproperties.dishpropertygroupid = MenuDishpropertiesGroups.ID where (((MenuDishproperties.ID)=" & dishpropertiessplit2(1)  & "))", objCon
					            if not objRds_dishpropertiesprice.EOF then
					                response.write "<BR> <small>" & objRds_dishpropertiesprice("dishpropertygroup") & ":" & objRds_dishpropertiesprice("dishproperty") & "</small>"
                                end if
					            objRds_dishpropertiesprice.close()
                                set objRds_dishpropertiesprice =  nothing
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
						 End If  %>
						</td>
                                <td style="padding-right: 20px; text-align: right;" valign="top"><%=CURRENCYSYMBOL%><%= FormatNumber(objRds("Total"), 2) %></td>                                    
                            </tr>
                    <%  
                        objRds.MoveNext        
                    Loop 
    
                            objRds.Close
                        set objRds = nothing
                          
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
                SQL = "select  MenuItemId,Total,IdMenuCategory from  OrderItems oi with(nolock)   " 
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
                                    <td style="padding-top: 5px; border-top: 1px dotted black;"><b>Voucher</b><br /><%=vouchercode %><%if  VoucherDiscontType & "" <> "Amount" then%>(<%=discountcodeused%>)<%end if%> </td>
                                    <td style="padding-top: 5px; border-top: 1px dotted black;text-align: right;padding-right: 20px;">
			                         <% if VoucherDiscontType & "" = "Amount" then    %>
                                            <span id="voucher">-<%=CURRENCYSYMBOL%><%= FormatNumber(Cdbl(Replace(Replace(Replace(discountcodeused,"-",""),"%","")," ","")) ,2) %> </span></td>
                                     <%else %>
			                                    <% 
                                                    if discountValueDisCat >= 0 then  %>
			                                        <span id="voucher">-<%=CURRENCYSYMBOL%><%= FormatNumber(discountValueDisCat,2) %> </span></td>
                                                <%else %>
                                                    <span id="voucher">-<%=CURRENCYSYMBOL%><%= FormatNumber((( vOrderSubTotal * 100 )/(100- Cdbl(Replace(Replace(Replace(discountcodeused,"-",""),"%","")," ",""))) - vOrderSubTotal ),2) %> </span></td>
                                                <%end if %>
                                    <%end if %>
                                    <td style="padding-top: 5px; border-top: 1px dotted black;">&nbsp;</td>
                                </tr>
		                        <%end if%>
        
        
                         <tr>
                            <td style="padding-top: 5px; border-top: 1px dotted black;">SubTotal</td>
                            <td style="padding-top: 5px; padding-right: 20px; text-align: right; border-top: 1px dotted black;"><%=CURRENCYSYMBOL%><%= FormatNumber(vOrderSubTotal, 2)  %>
                                <input type="hidden" id="subtotal" value="<%=vOrderSubTotal %>"/>

                            </td>
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
                        <% if cdbl(TaxAmount) > 0 then  %>
                            <tr>
                                <td style="padding-top: 5px;">Tax(<%=Tax_Percent %>%)</td>
                                <td style="padding-top: 5px; padding-right: 20px; text-align: right;"><%=CURRENCYSYMBOL%><%= FormatNumber(TaxAmount, 2)  %></td>
                                <td style="padding-top: 5px;">&nbsp;</td>
                            </tr>   
                        <% end if %>
                        <% if cdbl(TipAmount) > 0 then  %>
                           
                             <% function WriteCheck(byval value1, byval value2)
                                    dim result : result = "" 
                                    if value1 & "" = value2 & ""  then
                                        result = "selected"
                                    end if
                                    WriteCheck = result
                                end function
                             '    Response.Write("Tip_Rate " & Tip_Rate & "<br/>")
                             %>
                            <tr>
                                <td style="padding-top: 5px;">Tip<select  id="tip_custom" style="display:none;margin-left:10px;width:80px;" onchange="ChangeTip(this);">
                                                                    <% 
                                                                         dim x
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
                            <td style="padding-top: 5px; padding-right: 20px; text-align: right;"><%=CURRENCYSYMBOL%><b id="ordertotal"><%= FormatNumber(vOrderTotal, 2)  %></b></td>
                            <td style="padding-top: 5px;">&nbsp;</td>
                        </tr>    
                         
                        <tr>
                            <td colspan="3">&nbsp;</td>    
                        </tr>
                        </table>
                         
                     <table style="width:100%">

                          <tr>
                            <td colspan="3">

                                <div id="divVoucherCode" style="padding:0px 8px 15px 8px;">
                                     <button type="button" class="btn btn-xs btn-block" id="vouchercodeshow" style="background-color:#eeeeee;color:#7d7c7c  ;"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> Add Voucher Code</button>
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
                                    } else if(!IsInvalidTip($("#tip_value").val()))
                                    {
                                        alert("The tip must be a positive number.");
                                        return false;
                                    }   
                                    $.ajax({url: "<%=SITE_URL%>UpdateTip.asp?id_r=<%=vRestaurantId%>&oid=<%=vOrderId%>&tipamount=" + $("#tip_value").val() + "&tr=" + $("#tip_custom").val() , success: function(result){
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
                                    $("#panel-item").load("<%=SITE_URL%>applydiscount.asp?id_r=<%= vRestaurantId %>&o=<%=vOrderId%>&op=vouchercode&vouchercode=" + $('#vouchercode').val());
                                   
                                    //$.ajax({url: "<%=SITE_URL%>applydiscount.asp?id_r=<%= vRestaurantId %>&op=vouchercode&vouchercode=" + $('#vouchercode').val() , success: function(result){
                                    //    $("#panel-item").htm(result);
                                    //}});
                                    return false;
                                }
                            </script>
                        <table style="width:100%">
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
								 <br><br>(<%=CURRENCYSYMBOL%><%=CREDITCARDSURCHARGE%> surcharge)</button>
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
                                                 isOrder  = true
                                    end if
                                            
                                    %>
                                    <div class="block-direct" <%=popoverAttr %>>
                                        <% if disableButton = "" and enable_StripePaymentButton = "Yes" then %>
                                        <br/><br/>
                                    <!-- #include file="Payments/stripe/stripepayment.asp" -->
                                        <div id="idsurchage" style="display:none;color:grey;">(<%=CURRENCYSYMBOL%><%=CREDITCARDSURCHARGE%> surcharge)</div>
                                          <%end if %>
                                    </div>
                                     <% 
                                
                                         if enable_CashPayment = "Yes" then  
                                           if isOrder = true then
                                            %>
                                                 <div class="divider-or">OR</div>
                                                        <%
                                            end if %>
                                    <div class="block-cash">
							        <button  type="submit" name="payment_type" value="cash_delivery"  class="btn btn-info btn-block">Pay by Cash</button>   
                                    </div>
                                    <% end if %>
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

   <%  objCon.Close
        set objCon = nothing %>

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

        $("#frmMakeOrder").removeAttr("novalidate");
        // $("form").validate();
        if (1 == 2) {
        $("#frmMakeOrder").validate({
            rules: {
                Email: {
                    required: true,
                    email: true
                }
            }
        });
        }

        var isFormSubmitted = false;
        $("#frmMakeOrder").submit(function() {    
            $("#frmMakeOrder").validate();
            var isCheckCapcha = true;
                if($("#frmCapcha").length > 0 )
                    {
                            var x = document.getElementById("frmCapcha");
                            var y = (x.contentWindow || x.contentDocument);
                           var className =  $(y.document.getElementById("txtcapcha")).attr("class");
                        if(className == "jCaptcha valid error"){
                                  $(y.document.getElementById("txtcapcha")).focus();  
                             return false;
                           }
                           
                    }

            if($("form").valid() ){
                if(isFormSubmitted) return false;     
                return true;
            }
        });
        $('[data-toggle="popover"]').popover({ trigger: "hover" });   
    });
	
    function checkShowButtonStripe()
    {
        $("#frmMakeOrder").validate();
        var isCheckCapcha = true;
        if($("#frmCapcha").length > 0 )
        {
            var x = document.getElementById("frmCapcha");
            var y = (x.contentWindow || x.contentDocument);
            var className =  $(y.document.getElementById("txtcapcha")).attr("class");
            if(typeof className == "undefined" ||  className == "jCaptcha valid error"){
                //$(y.document.getElementById("txtcapcha")).focus();  
                return false;
            }
                           
        }
        if($("form").valid() ){
            $("#payment-request-button").show();
            if($("#payment-request-button").length > 0 && $.trim( $("#payment-request-button").html()) !="")
                $("#idsurchage").show();
        }else
        {
            $("#payment-request-button").hide();
            $("#idsurchage").hide();
        }
    }
    $(function(){
        checkShowButtonStripe();
        $("#panel-left").find("input").bind("change",function(){
            checkShowButtonStripe();
            
        });
        

    })
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

