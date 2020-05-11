<!-- Powered by Naxtech.com  -->

<%
    if Session("ResID")& "" <> "" then
            
        session("restaurantid")=Session("ResID")
        Session("ResID") = ""
    else
        session("restaurantid")=Request.QueryString("id_r")
    end if

%>
<!-- #include file="Config.asp" -->
<!-- #include file="timezone.asp" -->
<!-- #include file="restaurantsettings.asp" -->
<% 
    dim FormAddress ,FormPostCode
    dim OrderType : OrderType = "Online"
    if Request.Cookies("Telephone") & ""  <> "" then
        OrderType = Request.Cookies("Telephone") & "" 
    end if
     if Request.Cookies("FormAddress") & ""  <> "" and Request.Cookies("FormPostCode") & "" <> ""  then
          FormAddress  = replace( Request.Cookies("FormAddress") & "","[space]"," ")       
          FormPostCode = replace(Request.Cookies("FormPostCode") & "","[space]"," ")
          Response.Cookies("Address") =   FormAddress
          Response.Cookies("Postcode") = FormPostCode

          Response.Cookies("FormAddress") =    Request.Cookies("FormAddress")
          Response.Cookies("FormPostCode") =  Request.Cookies("FormPostCode")
          Response.Cookies("FormFirstName") =    Request.Cookies("FormFirstName")
          Response.Cookies("FormLastName") =    Request.Cookies("FormLastName")
          Response.Cookies("FormEmail") =  Request.Cookies("FormEmail")
          Response.Cookies("FormPhoneNumber") =    Request.Cookies("FormPhoneNumber")
          OrderType = "Telephone"
     else
          'Response.Cookies("Address") =   ""
          'Response.Cookies("Postcode") = ""

          Response.Cookies("FormAddress") =   ""
          Response.Cookies("FormPostCode") =  ""
          Response.Cookies("FormFirstName") =   ""
          Response.Cookies("FormLastName") =    ""
          Response.Cookies("FormEmail") =  ""
          Response.Cookies("FormPhoneNumber") =   ""
          FormAddress  =""
          FormPostCode  =""
     end if
    Dim CurrentURL, CurrentFilename    
   If UCase(Request.ServerVariables("HTTPS")) = "ON" Then
        CurrentURL = "https://" & Request.ServerVariables("SERVER_NAME")  &  Request.ServerVariables("URL") 
    Else
        CurrentURL = "http://" & Request.ServerVariables("SERVER_NAME")  &  Request.ServerVariables("URL") 
    End If
    
   'CurrentURL 404;https://www.greek-painters.com:443/vo/food/7-4-Dang/Demo-Place-SK13-8AQ-01313135588/Menu<br/>


    CurrentFilename = Right(CurrentURL, Len(CurrentURL) - InstrRev(CurrentURL,"/"))

    If UCASE(SITE_URL & CurrentFilename) <> UCASE(CurrentURL) and instr( lcase(CurrentURL),"urlrewrite.asp") =0  Then
        if Request.ServerVariables("QUERY_STRING")  & "" <> "" then
            CurrentFilename  = CurrentFilename & "?"&  Request.ServerVariables("QUERY_STRING")
        end if
   
        Response.Redirect(SITE_URL & CurrentFilename)
    elseif UCase(Request.ServerVariables("HTTPS")) = "OFF" and  instr( lcase(CurrentURL),"urlrewrite.asp") > 0 and instr(lcase(SITE_URL),"https") > 0   then
            Dim httpsURL :  httpsURL = Request.ServerVariables("QUERY_STRING") 
            httpsURL  = replace(httpsURL,"404;http:","https:")
            httpsURL  = replace(httpsURL,":80","")
            Response.Redirect(httpsURL)
    End If
   
   
    Set objCon = Server.CreateObject("ADODB.Connection")
        objCon.Open sConnString
    Set objRds = Server.CreateObject("ADODB.Recordset") 
    dim objRdsMainCategory
    Set objRdsMainCategory = Server.CreateObject("ADODB.Recordset") 
    
    Dim vRestaurantId
    vRestaurantId = session("restaurantid")
    '' Get Url Menu, checkout , thanks
    dim MenuURL,CheckoutURL,ThankURL
        CheckoutURL = SITE_URL& "CheckOut.asp?id_r=" & vRestaurantId
    Dim StrAllergen : StrAllergen = ""

    function FindAllergen(byval allergen )
             allergens  = "," & replace(allergens," ","") & ","   
            dim result : result = ""
            dim allergenID : allergenID = ""
        if StrAllergen <> "" then
           dim arrAllergen : arrAllergen =  split(StrAllergen,"[**]")
               dim index :  index = 0
            for index = 0 to ubound(arrAllergen) 
                if arrAllergen(index) & "" <> "" then
                    allergenID = split(arrAllergen(index),"|")(0)
                    if allergen = allergenID  then
                        result = arrAllergen(index)
                    end if 
                end if
            next
        end if
        FindAllergen = result
    end function

    if vRestaurantId & "" <> "" and 1 <> 1  then       
           dim rs_url :  set rs_url = Server.CreateObject("ADODB.Recordset")               
               rs_url.open  "SELECT FromLink FROM URL_REWRITE  a  with(nolock)  inner join BusinessDetails   b  with(nolock)  on (a.RestaurantID=b.ID )  where RestaurantID=" & vRestaurantId & " and EnableUrlRewrite = 'Yes' and status = 'ACTIVE' " ,objCon
    
           while not rs_url.eof 
               
               if instr(lcase(rs_url("FromLink")),"/menu") > 0 then
                     if instr(lcase(CurrentURL),"urlrewrite.asp") = 0 then
                        Dim sURLRedirect : sURLRedirect  = Replace( lcase( rs_url("FromLink")& ""),"http://","https://")
                            rs_url.close()
                            set rs_url = nothing
                            objCon.close()
                            set objCon = nothing
                        if instr( lcase(SITE_URL),"https://") = 0 then
                            sURLRedirect = replace(sURLRedirect,"https://","http://") 
                        end if

                       Response.Redirect( sURLRedirect ) 
                     end if   
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
   ' CheckoutURL = "/checkout.asp?id_r=2"
    '' end 
    ' Task 267 
    Dim s_IconApple,s_UrlApple,s_IconGoogle,s_UrlGoogle
    ' end
    Dim sDayOfWeek
    Dim sHour
    Dim sIsOpen
    Dim sName
    Dim sPostalCode
    Dim sDeliveryFee
    dim DistanceMile
    Dim sDeliveryDistance
    Dim sDeliveryMinAmount
    Dim sAverageDeliveryTime
    Dim sAverageCollectionTime
    Dim Mon_Delivery,Tue_Delivery,Wed_Delivery,Thu_Delivery,Fri_Delivery,Sat_Delivery,Sun_Delivery
    Dim Mon_Collection,Tue_Collection,Wed_Collection,Thu_Collection,Fri_Collection,Sat_Collection,Sun_Collection
    Dim sRestaurantLat
    Dim sRestaurantLng
    Dim sDistanceCalMethod
    dim inmenuannouncement
    Dim announcement_Filter
    sRestaurantLat = ""
    sRestaurantLng = ""
   
    sDayOfWeek = DatePart("w", DateAdd("h",houroffset,now), vbMonday, 1)
    
    sHour = CDate(FormatDateTime(DateAdd("h",houroffset,now), vbShortTime))
  
    function formatHourMin(byval hh, byval mm)
        dim result :  result = ""
        if hh < 10 then
            hh = "0" & hh
        end if
        if mm < 10 then
            mm = "0" & mm
        end if
        result = hh & ":" & mm
        formatHourMin = result
    end function
     Dim hhmm1 : hhmm1=  formatHourMin(Hour(DateAdd("h",houroffset,now)),Minute(DateAdd("h",houroffset,now)))
     objRds.Open "SELECT *  FROM BusinessDetails    WHERE Id = " & vRestaurantId, objCon
     Dim limittopping , s_BannerURL 
    dim Close_StartDate,Close_EndDate
    dim Close_StartDate_JS,Close_EndDate_JS
    dim IsCloseRestaurant : IsCloseRestaurant =  false 
    if not objRds.EOF then
        Close_StartDate = objRds("Close_StartDate")
        Close_EndDate  = objRds("Close_EndDate")
        s_BannerURL = trim( objRds("s_BannerURL") & "" ) 
        if Close_StartDate & "" <> "" and Close_EndDate & "" <> "" then
            Close_StartDate_JS =  cdate(Close_StartDate)
           
            Close_EndDate_JS = cdate(Close_EndDate)
            if cdate(Close_StartDate & " 00:00:01") <= DateAdd("h",houroffset,Now()) and DateAdd("h",houroffset,Now()) <= cdate(Close_EndDate & " 23:59:59") then
                Close_StartDate =  cdate(Close_StartDate)                
                Close_EndDate =  cdate(Close_EndDate)                
                Close_StartDate = Day(Close_StartDate)  & " " & left( MonthName( Month(Close_StartDate)),3) & " " & Year(Close_StartDate)
                Close_EndDate  =  Day(Close_EndDate)  & " " & left( MonthName( Month(Close_EndDate)),3) & " " & Year(Close_EndDate) 
                IsCloseRestaurant = true
            end if
        end if
    end if

'check opening times
Set objRds2 = Server.CreateObject("ADODB.Recordset") 
   
objRds2.Open "SELECT  convert(varchar, Hour_From, 8)  as Hour_From, convert(varchar, Hour_To, 8)  as Hour_To  FROM openingtimes     where IdBusinessDetail = " & objRds("Id") & " and DayOfWeek=" & sDayOfWeek & " order by DayOfWeek, Hour_From", objCon
'loop through opening time
isopen=false
     dim PreDeliveryOpen 
     PreDeliveryOpen = "false"
dim PreCollectionOpen 
     PreCollectionOpen = "false"
dim Hour_To : Hour_To = 0 
dim PrevStillOpen : PrevStillOpen = false
dim PrevStillLasttime : PrevStillLasttime = 0
dim googleecommercetrackingcode 

dim EnableAllergen,EnableSuitableFor
Do While NOT objRds2.Eof

    Dim o_Hour_From : o_Hour_From = cdate(FormatTimeC(objRds2("Hour_From"),8) )
    Dim o_Hour_To : o_Hour_To = cdate( FormatTimeC(objRds2("Hour_To"),8))
   
 if DateDiff("n",o_Hour_From,o_Hour_To)<0 then
   
	if (sHour >= o_Hour_From and sHour <= "23:59:00")  Then
		isopen=true
         
	end if
 else
	if (o_Hour_From <= sHour and o_Hour_To >= sHour) Then
		isopen=true
       
	end if
end if
objRds2.MoveNext    
Loop
 
objRds2.Close
set objRds2 = nothing
'if it is has found not to be open and time is early morning then check previous days time
if isopen=false and DateDiff("n",sHour,"12:00:00")>0 then

sDayOfWeekprev=sDayOfWeek-1
if sDayOfWeekprev=0 then
sDayOfWeekprev=7
end if
 Set objRds2 = Server.CreateObject("ADODB.Recordset") 
objRds2.Open "SELECT  convert(varchar, Hour_From, 8)  as Hour_From, convert(varchar, Hour_To, 8)  as Hour_To  ,delivery,collection  FROM openingtimes  where IdBusinessDetail = " & objRds("Id") & " and DayOfWeek=" & sDayOfWeekprev, objCon
Do While NOT objRds2.Eof
    o_Hour_From = cdate(  FormatTimeC(objRds2("Hour_From"),8) )
    o_Hour_To = cdate( FormatTimeC(objRds2("Hour_To"),8))
 if DateDiff("n",o_Hour_From,o_Hour_To)<0 then
   
	if (sHour <= o_Hour_To) Then
         
		isopen=true
        PrevStillOpen =  true
        if lcase(objRds2("delivery")) = "y" then
           PreDeliveryOpen = "true"
        end if
        if lcase(objRds2("collection")) = "y" then
           PreCollectionOpen = "true"
        end if
        PrevStillLasttime = cdate( FormatTimeC(objRds2("Hour_To"),5 ) )
        
	end if
end if
objRds2.MoveNext    
Loop
    objRds2.close()
    set objRds2 = nothing
end if
     ' Task 267 
     s_IconApple = objRds("s_IconApple") & ""
     s_UrlApple  = objRds("s_UrlApple") & ""
     s_IconGoogle = objRds("s_IconGoogle") & ""
     s_UrlGoogle = objRds("s_UrlGoogle") & ""
    ' end
    EnableAllergen = objRds("EnableAllergen") & ""
    EnableSuitableFor = objRds("EnableSuitableFor") & ""
    if EnableAllergen = "" then
        EnableAllergen = "No"
    end if 
    if EnableSuitableFor = "" then
        EnableSuitableFor = "No"
    end if 

    Dim SQL1 : SQL1 = "select ID,Name,icon,Type from allergen with(nolock) order by Name "
    if EnableAllergen = "Yes" and EnableSuitableFor = "No"  then
        SQL1 = SQL1 &  " where type ='Allergen' " 
    elseif EnableAllergen = "No" and EnableSuitableFor = "Yes"  then
        SQL1 = SQL1 &  " where type ='SuitableFor' " 
    elseif EnableAllergen = "No" and EnableSuitableFor = "No"  then
         SQL1 = SQL1 &  " where 1 != 1 " 
    end if
   
    Dim Rs_Allergen : set Rs_Allergen =  Server.CreateObject("ADODB.Recordset")
        Rs_Allergen.open  SQL1 ,objCon
    while not Rs_Allergen.EOF 
        if StrAllergen = "" then
            StrAllergen =   Rs_Allergen("ID") & "|" & Rs_Allergen("Name") & "|" & Rs_Allergen("icon") & "|" & Rs_Allergen("Type")
        else
            StrAllergen =  StrAllergen & "[**]" & Rs_Allergen("ID") & "|" & Rs_Allergen("Name") & "|" & Rs_Allergen("icon") & "|" & Rs_Allergen("Type")
        end if
     
        Rs_Allergen.movenext() 
    wend
        Rs_Allergen.close()
    set Rs_Allergen = nothing

    enablereorder = objRds("enablereorder")
    EnableBooking = objRds("EnableBooking")
    sName = objRds("Name")
    sPostalCode = objRds("PostalCode")
    sDeliveryFreeDistance  = 0
    sDeliveryMaxDistance  = 0
    sDeliveryFee = 0
    DistanceMile = 0
    sDeliveryMinAmount  = 0
	menupagetext=objRds("menupagetext")
	sorderonlywhenopen = objRds("orderonlywhenopen")
	sorderdisablelater = objRds("disablelaterdelivery")
	individualpostcodeschecking=objRds("individualpostcodeschecking")
    googleecommercetrackingcode = objRds("googleecommercetrackingcode")
    inmenuannouncement = objRds("inmenuannouncement")
    announcement_Filter = replace(replace(objRds("announcement_Filter"),vbCrLf,"<BR>"),"'","\'") 
    sDistanceCalMethod = ""
	s_DeliveryZonesPath = objRds("s_DeliveryZonesPath")  & ""

	if not isnull(objRds("individualpostcodes")) then
	
	individualpostcodes="|" & replace(objRds("individualpostcodes"),",","|") & "|"
	end if
    sDeliveryChargeOverrideByOrderValue = 1000000000
    if Not IsNull(objRds("DeliveryMaxDistance")) Then sDeliveryMaxDistance = Cdbl(objRds("DeliveryMaxDistance"))
    if Not IsNull(objRds("DeliveryFreeDistance")) Then sDeliveryFreeDistance = Cdbl(objRds("DeliveryFreeDistance"))
    if Not IsNull(objRds("DeliveryMinAmount")) Then sDeliveryMinAmount = Cdbl(objRds("DeliveryMinAmount"))
    
    if Not IsNull(objRds("DeliveryFee")) Then sDeliveryFee = Cdbl(objRds("DeliveryFee"))
    if Not IsNull(objRds("DeliveryMile")) Then DistanceMile = Cdbl(objRds("DeliveryMile"))  
     
     Dim DeliveryUptoMile : DeliveryUptoMile = objRds("DeliveryUptoMile") & ""
     if DeliveryUptoMile = "" then
        DeliveryUptoMile = 0
    end if
    Dim DeliveryCostUpTo : DeliveryCostUpTo = objRds("DeliveryCostUpTo") & ""
    if DeliveryCostUpTo = "" then
        DeliveryCostUpTo = 0
    end if

    if Not IsNull(objRds("AverageDeliveryTime")) Then sAverageDeliveryTime = Cdbl(objRds("AverageDeliveryTime"))
    if Not IsNull(objRds("AverageCollectionTime")) Then sAverageCollectionTime = Cdbl(objRds("AverageCollectionTime"))

    if Not IsNull(objRds("Mon_Delivery")) Then Mon_Delivery = Cdbl(objRds("Mon_Delivery"))
    if Not IsNull(objRds("Tue_Delivery")) Then Tue_Delivery = Cdbl(objRds("Tue_Delivery"))
    if Not IsNull(objRds("Wed_Delivery")) Then Wed_Delivery = Cdbl(objRds("Wed_Delivery"))
    if Not IsNull(objRds("Thu_Delivery")) Then Thu_Delivery = Cdbl(objRds("Thu_Delivery"))
    if Not IsNull(objRds("Fri_Delivery")) Then Fri_Delivery = Cdbl(objRds("Fri_Delivery"))
    if Not IsNull(objRds("Sat_Delivery")) Then Sat_Delivery = Cdbl(objRds("Sat_Delivery"))
    if Not IsNull(objRds("Sun_Delivery")) Then Sun_Delivery = Cdbl(objRds("Sun_Delivery"))
    if Not IsNull(objRds("Mon_Collection")) Then Mon_Collection = Cdbl(objRds("Mon_Collection"))
    if Not IsNull(objRds("Tue_Collection")) Then Tue_Collection = Cdbl(objRds("Tue_Collection"))
    if Not IsNull(objRds("Wed_Collection")) Then Wed_Collection = Cdbl(objRds("Wed_Collection"))
    if Not IsNull(objRds("Thu_Collection")) Then Thu_Collection = Cdbl(objRds("Thu_Collection"))
    if Not IsNull(objRds("Fri_Collection")) Then Fri_Collection = Cdbl(objRds("Fri_Collection"))
    if Not IsNull(objRds("Sat_Collection")) Then Sat_Collection = Cdbl(objRds("Sat_Collection"))
    if Not IsNull(objRds("Sun_Collection")) Then Sun_Collection = Cdbl(objRds("Sun_Collection"))
    sub ExportsAverageDel_ColTime(byval dayofweek, byref sAverageDeliveryTime, byref sAverageCollectionTime)
        select case dayofweek 
            case 1 
                  if Mon_Delivery & "" <> "" and Mon_Collection & "" <> ""  then
                    sAverageDeliveryTime = Mon_Delivery
                    sAverageCollectionTime = Mon_Collection
                  end if
                  
            case 2
                  if Tue_Delivery & "" <> "" and Tue_Collection & "" <> ""  then
                    sAverageDeliveryTime = Tue_Delivery
                    sAverageCollectionTime = Tue_Collection
                  end if
            case 3
                 if Wed_Delivery & "" <> "" and Wed_Collection & "" <> ""  then
                    sAverageDeliveryTime = Wed_Delivery
                    sAverageCollectionTime = Wed_Collection
                  end if
            case 4
                 if Thu_Delivery & "" <> "" and Thu_Collection & "" <> ""  then
                    sAverageDeliveryTime = Thu_Delivery
                    sAverageCollectionTime = Thu_Collection
                  end if
            case 5
                if Fri_Delivery & "" <> "" and Fri_Collection & "" <> ""  then
                    sAverageDeliveryTime = Fri_Delivery
                    sAverageCollectionTime = Fri_Collection
                  end if
            case 6
                  if Sat_Delivery & "" <> "" and Sat_Collection & "" <> ""  then
                    sAverageDeliveryTime = Sat_Delivery
                    sAverageCollectionTime = Sat_Collection
                  end if
            case 7 
                 if Sun_Delivery & "" <> "" and Sun_Collection & "" <> ""  then
                    sAverageDeliveryTime = Sun_Delivery
                    sAverageCollectionTime = Sun_Collection
                  end if
        end select 
    end sub
    call ExportsAverageDel_ColTime(sDayOfWeek, sAverageDeliveryTime, sAverageCollectionTime)
   ' Response.Write("sAverageDeliveryTime " & sAverageDeliveryTime & " sAverageCollectionTime " & sAverageCollectionTime & "<br/>")

	if Not IsNull(objRds("DeliveryChargeOverrideByOrderValue")) Then sDeliveryChargeOverrideByOrderValue = Cdbl(objRds("DeliveryChargeOverrideByOrderValue"))
	if Not IsNull(objRds("Latitude")) Then sRestaurantLat = objRds("Latitude")
    if Not IsNull(objRds("Longitude")) Then sRestaurantLng = objRds("Longitude")
    If not IsNull(objRds("distancecalmethod")) Then sDistanceCalMethod = objRds("distancecalmethod")
	 if objRds("businessclosed")=1 then
	 response.redirect SITE_URL & "closed.asp?id_r=" & vRestaurantId
	 end if
%>


<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Menu - <%= objRds("Name")%></title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <meta name="description" content="">
  <meta name="author" content="">
  
  <link rel="dns-prefetch" href="<%=SITE_URL %>">
  
   
  <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
    <script src="Scripts/html5shiv.js"></script>
  <![endif]-->

  <!-- Fav and touch icons -->
 <% If FAVICONURL & "" <> "" Then %> <link rel="shortcut icon" href="<%=FAVICONURL %>" type="image/x-icon" /> <% end If %>
 
 

<meta name="apple-mobile-web-app-title" content="<%= objRds("Name")%>">
 <% dim platform : platform = ""
     if (  s_IconApple & "" <> "" and s_UrlApple <> "" ) or (s_IconGoogle & "" <> "" and s_UrlGoogle <> "") then %>
    <!-- Start SmartBanner configuration -->
<meta name="smartbanner:title" content="<%=objRds("Name") %>">
<meta name="smartbanner:author" content="Order Your Food Online">
<meta name="smartbanner:price" content="FREE">
<meta name="smartbanner:price-suffix-apple" content=" - On the App Store">
<meta name="smartbanner:price-suffix-google" content=" - In Google Play">
    <% if s_IconApple & "" <> "" and s_UrlApple <> "" then
        platform="ios"
         %>
<meta name="smartbanner:icon-apple" content="<%=s_IconApple %>">
<meta name="smartbanner:button-url-apple" content="<%=s_UrlApple %>">
    <% end if %>
<meta name="smartbanner:button" content="VIEW">
    <% if s_IconGoogle & "" <> "" and s_UrlGoogle <> "" then
        if platform = "" then
            platform ="android"
        else
            platform = platform & ",android"
        end if
         %>
<meta name="smartbanner:icon-google" content="<%=s_IconGoogle %>">
<meta name="smartbanner:button-url-google" content="<%=s_UrlGoogle %>">
    <% end if %>
<meta name="smartbanner:enabled-platforms" content="<%=platform %>">
<meta name="smartbanner:close-label" content="Close">
<link rel="stylesheet" href="<%=SITE_URL %>css/smartbanner.css">
<script src="<%=SITE_URL %>Scripts/smartbanner.js"></script>
<!-- End SmartBanner configuration -->
    <%end if %>
<% If ADDTOHOMESCREENURL & "" <> "" Then %>
<link rel="apple-touch-icon-precomposed" sizes="152x152" href="<%=ADDTOHOMESCREENURL %>">
<link rel="apple-touch-icon-precomposed" sizes="144x144" href="<%=ADDTOHOMESCREENURL %>">
<link rel="apple-touch-icon-precomposed" sizes="120x120" href="<%=ADDTOHOMESCREENURL %>">
<link rel="apple-touch-icon-precomposed" sizes="114x114" href="<%=ADDTOHOMESCREENURL %>">
<link rel="apple-touch-icon-precomposed" sizes="76x76" href="<%=ADDTOHOMESCREENURL %>">
<link rel="apple-touch-icon-precomposed" sizes="72x72" href="<%=ADDTOHOMESCREENURL %>">
<link rel="apple-touch-icon-precomposed" href="<%=ADDTOHOMESCREENURL %>">

<link rel="apple-touch-icon" href="<%=ADDTOHOMESCREENURL %>">
<link rel="apple-touch-icon" sizes="180x180" href="<%=ADDTOHOMESCREENURL %>">
<link rel="apple-touch-icon" sizes="167x167" href="<%=ADDTOHOMESCREENURL %>">

<% end if %>

    

  <script type="text/javascript">
      var IncludeDelivery_Collection ="";
    function checkboxlimit(checkgroup, limit){          
          $("[toppinggroup=" + checkgroup + "]").each(function(){
              $(this).bind("click",function(){
                  var checkedcount=0;
                  $("[toppinggroup=" + checkgroup + "]").each(function(){
                      if($(this).is(":checked"))
                          checkedcount+=1;
                  });
                  if (checkedcount>limit){
                      alert("You can only select a maximum of "+limit+" checkboxes");
                      $(this).prop("checked", false);
                  }
              });
          });  
         
      }
   var disabledelivery ="<%=disabledelivery %>";
   var disablecollection = "<%=disablecollection%>";
   var ismobileSelected = false;
   var alertTime =  false; 
   var individualpostcodeschecking ;
     <% if individualpostcodeschecking = 0 then %>  
      individualpostcodeschecking = false;
      <% else %>
     individualpostcodeschecking = true;

      <% end if %>

  </script>

    <script   type="text/javascript" src="<%=SITE_URL %>Scripts/jquery.min.js"></script>
    <script  defer type="text/javascript" src="<%=SITE_URL %>Scripts/jquery.lazy.min.js"></script>
	<script  defer  type="text/javascript" src="<%=SITE_URL %>Scripts/js.cookie.js"></script>
	<script   type="text/javascript" src="<%=SITE_URL %>Scripts/bootstrap.min.js"></script>
	<script  defer type="text/javascript" src="<%=SITE_URL %>Scripts/scripts.js"></script>
    <script  defer src="<%=SITE_URL %>Scripts/jquery.validate.min.js" type="text/javascript"></script>
    <script   src="<%=SITE_URL %>Scripts/bootstrap-datepicker.js?v=2.0" type="text/javascript"></script>
    <script defer src="<%=SITE_URL %>Scripts/bootstrap-select.js?v=2.7"></script>
    <!--<script src="Scripts/bootstrap-datepicker.min.js" type="text/javascript"></script>-->
    
    <script defer type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=<%= GMAP_API_KEY %>&libraries=places,geometry&language=en-GB&types=address"></script>
	

    <script defer type="text/javascript" src="<%=SITE_URL %>scripts/fancybox/jquery.fancybox.pack.js?v=2.1.5"></script>	
        <%' if individualpostcodeschecking = 0 then %>  
    <script type="text/javascript">
      var  imagegooglemarker="<%=SITE_URL%>images/googlemarker.png";
    </script>
    <script defer src="<%=SITE_URL %>scripts/Locationpicker.js?v=3.0"></script>
 
    <%' end if %>



    <link href="<%=SITE_URL %>css/bootstrap.css" rel="stylesheet">
    
    <link href="stylesheet" href="<%=SITE_URL %>css/bootstrap-select.css">
	<link href="<%=SITE_URL %>css/style.css?v=1.7" rel="stylesheet">	
    <link href="<%=SITE_URL %>css/product_test.css?v=1.9" rel="stylesheet">
	<link href="<%=SITE_URL %>css/datepicker.css" rel="stylesheet">
    <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">     
	<link rel="stylesheet" type="text/css" href="<%=SITE_URL %>css/addtohomescreen.css">
    <link rel="stylesheet" type="text/css" href="<%=SITE_URL %>scripts/fancybox/jquery.fancybox.css?v=2.1.5">




	<style media="screen" type="text/css">
     img.lazy {
        
      
        display: block;
    }
<%= objRds("css")%>
.loader {
	position: fixed;
	left: 0px;
	top: 0px;
	width: 100%;
	height: 100%;
	z-index: 9999;
	background: url('<%= objRds("ImgUrl") %>') 50% 50% no-repeat rgb(249,249,249);
}


#modalDivOrderType .modal-dialog
{
    width: 600px !important;
}

#modalDivOrderType .delblock + .delblock
{
    float: right;
}
#modalDivOrderType .delblock
{
    margin-right: 0;
    margin-bottom: 12px;
    margin-left: 0;
    padding: 6px;
    padding-left: 18px;
    padding-left: 20px;
}



#modalDivOrderType #DeliveryDistance,
#modalDivOrderType #DeliveryTime
{
    margin-top: 8px;
}

#modalDivOrderType  #placeOrderContinue
{
    margin-right: 10px;
}

#modalDivOrderType .input-group-btn > .btn
{
    border: 1px solid #999;
    border-left: 0;
    border-top-left-radius: 0;
    border-bottom-left-radius: 0;
}
#modalDivOrderType #fancyBoxMap
{
    padding-top: 12px !important;
    padding-bottom: 8px;
}

#modalDivOrderType #DeliveryTime::after,
#modalDivOrderType .delblock::after
{
    display: block;
    clear: both;

    content: '';
}

#modalDivOrderType #DeliveryTime > .input-group
{
    width: 47% !important;
    margin-right: 15px;
}
#modalDivOrderType #nowlater
{
    margin: 0;
    padding: 3px;
    font-size: 14px;
    padding-bottom: 6px;
}

#modalDivOrderType input[type='radio'],
#modalDivOrderType input[type='checkbox']
{
    position: relative;
    top: 6px;
    width: 18px;
    height: 18px;
    top: 3px;
}


#modalDivOrderType  #ordertimeoverride{
    margin-left:10px;
}
#modalDivOrderType .fa-user,
#modalDivOrderType  .fa-truck{
    margin-right: 10px;
}


@media only screen and (max-width: 767px){

.social-thumb{
display:block;
margin-top: 5px;
}
.social-text{display: none}
.link-book-table{margin-top:0;}
#topmenumobile .thumb-special-offers{
margin-bottom: 10px;
}
.icon-thumb{
text-align: right;
}
#mainmenu{
top: 0;
}
}

#topmenumobile .media:first-child{
padding: 0 15px;
}

#wholepage{
padding-top: 0px;
}

#header{
position: static;
margin-bottom: 15px;
padding: 15px 0!important;
}
div#topmenumobile {
    display: flex;
    align-items: center;
}
.social-info {
    min-width: 125px;
    margin-left: auto;
text-align: right;
}

.media, .media .media {
    margin-top: 0px;
}

@media only screen and (max-width: 767px){

  /*
      #topmenumobile .media > a {
        float: none !important;
        display:block;
        margin-bottom: 10px
    }
  */ 

    #topmenumobile .media-body div, #topmenumobile .media-body i{
        font-size: 12px;
    }

   
      .social-info{
        min-width: 182px;
    }
   

}

	   
       
@media only screen and (max-width: 413px){
    .social-info{
        min-width: 135px;
    }
    #topmenumobile .media-body div{font-size: 10px}
  
}

#topmenumobile .u-display-block .glyphicon {
    font: normal normal normal 14px/1 FontAwesome;
}

.social-info.social-info{
-ms-flex-item-align: start;align-self: flex-start;
}

@media only screen and (max-width: 767px){
  .link-book-table{
    padding: 6px 8px;
  }
  
  #topmenumobile .media-heading{
    font-size: 16px;
  }

.link-review{
  display: inline-block !important;
}

}

.social-thumb .social-icon{padding-left: 5px}
#topmenumobile .media:first-child{padding-left:0;padding-right:0;}
@media only screen and (max-width: 413px){
    .social-info {
        min-width: 155px;
    }
     #topmenumobile .media > a{float: none !important;}
}
.photo img {
        width: 30px  !important;
    }

    .photo .overlay{
        width: 100% !important;
        max-width: 100% !important;
    }
@media (min-width: 768px){

    .photo img {
        width: 90px !important;
    }

}

</style>

<script type="text/javascript">


    
    
function scrollToV2(id)
{
    console.log("ID " + id);
  // Scroll
  $('html,body').animate({scrollTop: $("#"+id).offset().top-170},'slow');
}
function scrollToV3(id,farTop)
{
    // Scroll
    console.log("scrollToV3 " + id + "  " + farTop );
  $('html,body').animate({scrollTop: $("."+id).offset().top - farTop },'slow');
}

  var affixWidth ;
  var _scrollTopHeight;
$(window).load(function() {

 if ($(window).width() <= 992) {  

             $(window).off('.affix');
$('#rightaffix').removeData('bs.affix').removeClass('affix affix-top affix-bottom');

       }

if($(window).width() <= 768) {  
_scrollTopHeight = 300;
} else {_scrollTopHeight = 277}

  
$(window).resize(function(){

       if ($(window).width() <= 992) {  
             $(window).off('.affix');
$('#rightaffix').removeData('bs.affix').removeClass('affix affix-top affix-bottom');

       }

       if($(window).width() <= 768) {  
           _scrollTopHeight = 300;//257;
} else {_scrollTopHeight = 277}
      
});


$('.movedown').click(function(e){
$('#navbar-menu-mobile').slideToggle();
if(($(window).scrollTop()>80)){
  //  alert("80 " + _scrollTopHeight);
    scrollToV3($(this).attr('data'),80);
}
else{
 
    scrollToV3($(this).attr('data'),_scrollTopHeight);
}
});





$('.btnadd').click(function(e){
 
   
    $('#addtobasket').fadeIn('slow', function(){
        $('#addtobasket').delay(1000).fadeOut('slow');
		
    });	
});

$( "#butcontinue" ).click(function() {
    if($("#beforeorder").html() !="")
        scrollToV2("beforeorder");
    else if($("#modalDivOrderTypeBody").html() !="")
        scrollToV2("modalDivOrderTypeBody");
});


$( "#butbasket" ).click(function() {
scrollToV2("basket");
});

$( ".catlink" ).click(function() {
$(".catlink").css({'background-color':'#f3f3f3'});
$(this).css({'background-color':'#c0c0c0'});
});




});



$(document).ready(function() {
        $(window).bind("pageshow", function(event) {
        if (event.originalEvent.persisted) {
          
            window.location.reload() 
        }
    });
    //responsive();
    $(window).resize(function() { responsive(); });
	$("form").keypress(function(e) {
  //Enter key
  if (e.which == 13) {
CheckDistance();
    return false;
  }
});

    
    <% 
    if IsCloseRestaurant =  true then
     %>        
        <% if Close_StartDate & "" <> Close_EndDate & "" then  %>
        $("#RestCloseModal div.modal-body").html("Sorry, <%=objRds("Name") %> is closed  from <%=Close_StartDate %> - <%=Close_EndDate %>");
        $("#RestCloseModal").modal();
         <% else %>
        $("#RestCloseModal div.modal-body").html("Sorry, <%=objRds("Name") %> is closed today");
        $("#RestCloseModal").modal();
        <%end if %>
    <% end if %>
<%if  request.querystring("timeout")="yes" then%>

                $("#SessionTimeout").modal();
				
<%end if%>

<%if  objRds("announcement")<>"" and IsCloseRestaurant = false then%>

$("#AnnouncementModal div.modal-body").html('<%=replace(replace(objRds("announcement"),vbCrLf,"<BR>"),"'","\'")%>');
$("#AnnouncementModal").modal();
				
<%end if%>
	
});


	


function responsive(){
   var winWidth = $(window).width();
     //var winHeight = $(window).height();
   if(winWidth < 992 ) { 

   	//$("#header").addClass("navbar-fixed-top");
  //$("body").css( "padding-top", "80px" );
   $("#divShoppingCartSroll").removeClass("shoppingCartScroll");
  
    }  else {
	//$("#header").removeClass("navbar-fixed-top");
	// $("body").css( "padding-top", "0px" );
     $("#divShoppingCartSroll").addClass("shoppingCartScroll");
	}

    
}




</script>
	
	
	<script>
var nua = navigator.userAgent;
var is_android = ((nua.indexOf('Mozilla/5.0') > -1 && nua.indexOf('Android ') > -1 && nua.indexOf('AppleWebKit') > -1) && !(nua.indexOf('Chrome') > -1));
if(is_android) {
        $('#bs-example-navbar-collapse-1').removeClass("scrollable-menu");
		

}

</script>

</head>
 <%
     Dim AddressRestaurant : AddressRestaurant =  objRds("Name") & "<br/>" & objRds("Address") &"<br/>Tel. " & objRds("Telephone")
      %>
<body>
  <!--<%     Response.Write("Start Time " & Now() & "<br/>") %>-->
<input type="hidden" value="<%= lcase(PrevStillOpen & "") %>" name="PrevStillOpen" />
<input type="hidden" value="<%=PrevStillLasttime %>" name="PrevStillLasttime" />
 <input type="hidden" value="<%= lcase(PreDeliveryOpen & "") %>" name="PreDeliveryOpen" />
<input type="hidden" value="<%=lcase( PreCollectionOpen & "")  %>" name="PreCollectionOpen" />
<div class="fake-header" style="display:none;"></div>
<div class="loader"></div>
<div  id="wholepage" style="padding-bottom:100px;display:none;">

	<div class="row clearfix headerbox" id="header">
		<div class="col-md-12 col-xs-12" style="padding-bottom:10px;" id="topmenumobile">
            <div class="media">
				 <a href="#" class="pull-left"><img src="<%= objRds("ImgUrl") %>"  width=70 class="media-object" alt="<%= objRds("Name") %>"></a>
				<div class="media-body">
					<h4 class="media-heading">
				
				
						 <%= objRds("Name") %>
                           <div class="rating" style="display:inline-block;">
                                <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                                <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                                <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                                <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                                <span class="glyphicon glyphicon-star-empty" aria-hidden="true"></span>
                                <a class="link-review dis-hide" href="#" data-toggle="modal" data-target="#reviewsModal">(Reviews)</a>
                            </div>

					</h4><div>
                            <%= objRds("Address") %> <br>
                        </div>

<i> <%= objRds("FoodType") %> </i>				
			</div>
			</div>
            <div class="social-info">				
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
            <a href="<%=URL_Facebook %>" title="facebook"  target="_blank"><i class="fa fa-facebook" aria-hidden="true"></i></a>
            <% end if %>
            <% if URL_Twitter & "" <> "" then  %>
            <a href="<%=URL_Twitter %>" title="twitter"  target="_blank"><i class="fa fa-twitter" aria-hidden="true"></i></a>
            <% end if %>
            <% if URL_Google & "" <> "" then  %>
            <a href="<%=URL_Google %>" title="google plus"  target="_blank"><i class="fa fa-google-plus" aria-hidden="true"></i></a>
            <% end if  %>
            <% if URL_Linkin & "" <> ""  then  %>
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
				<i class="fa fa-phone"></i> <a style="color:black;" href="tel:<%= objRds("Telephone") %> "> <%= objRds("Telephone") %></a>
<span class="glyphicon glyphicon glyphicon-envelope"></span>  <a style="color:black;"  href="mailto:<%= objRds("Email") %>">  <%= objRds("Email") %></a></div>

<div class="visible-xs icon-thumb">

    <script type="text/javascript">
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
                    var itemname = "",itemprice="";
                    $("#divShoppingCartSroll table tr").each(function(){
                             
                        if($(this).find("[name=itemName]").length > 0)
                            itemname = $(this).find("[name=itemName]").html();
                        if($(this).find("[name=itemPrice]").length > 0)
                            itemprice = $(this).find("[name=itemPrice]").html();
                        if(itemname!="" && itemprice!="")
                        {
                            htmlItem += "<tr>";
                                htmlItem += "<td name=\"itemName\">" + itemname  + "</td>";                          
                                htmlItem += "<td name=\"itemPrice\" style=\"vertical-align:top\">" + itemprice + "</td>";
                            htmlItem += "</tr>";
                            itemname = "";
                            itemprice = "";
                        }
                            
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
<a class="link-book-table" href="https://www.google.co.uk/maps?q=<%= objRds("Address") %>" target="_blank"><span  style="margin-left:0px !important;" class="glyphicon glyphicon-map-marker"></span></a>
<a class="link-book-table" href="tel:<%= objRds("Telephone") %>"><span style="margin-left:0px !important;" class="glyphicon glyphicon-earphone"></span></a>
<a class="link-book-table" href="mailto:<%= objRds("Email") %>"><span style="margin-left:0px !important;"  class="glyphicon glyphicon-envelope"></span></a>
<% if URL_Special_Offer & "" <> "" then %>
<a  href="<%=URL_Special_Offer %>" title="gift" class="social-icon-visible link-book-table" >
	<span style="margin:0px !important;">
    	<i class="fa fa-gift" aria-hidden="true"></i>
    </span>
</a>
<% End if %>
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
       <% if URL_Linkin & "" <> ""  then %>
  <a href="<%=URL_Linkin %>" title="linkedin" class="social-icon"  target="_blank"><i class="fa fa-linkedin" aria-hidden="true"></i></a>
    <% end if %>
  <% if URL_Intagram & "" <> "" then %>
  <a href="<%=URL_Intagram %>" title="instagram" class="social-icon"  target="_blank"><i class="fa fa-instagram" aria-hidden="true"></i></a>
    <% end if %>
       <% if URL_YouTube & "" <> "" then %>
  <a href="<%=URL_YouTube %>" title="youtube" class="social-icon" target="_blank"><i class="fa fa-youtube" aria-hidden="true"></i></a>
    <% end if %>
     
     <% if URL_Tripadvisor & "" <> "" then %>
  <a href="<%=URL_Tripadvisor %>" title="tripadvisor" class="social-icon" target="_blank"><i class="fa fa-tripadvisor"  aria-hidden="true"></i></a>
    <% end if %>
</div>
<% end if %>
</div>

<div class="link-header">
    <% if URL_Special_Offer & "" <> "" then %>
    <div class="u-display-block thumb-special-offers">
        <a class="link-special-offers" href="<%=URL_Special_Offer %>" target="_blank">Sign up for special offers</a>
    </div>
    <%end if %>
    <div class="hidden-xs u-display-block">
        <a class="link-login" data-toggle="modal" data-target="#loginModal" href="http://demo.food-ordering.co.uk/!#"><i class="fa fa-user" aria-hidden="true"></i>Login</a>
    </div>
    <% if EnableBooking = "Yes" then %>
        <div class="block-search-top">
             <a class="link-book-table" data-toggle="modal" onclick="confimBookTable();" data-target="#booktableModal" href="#"><i class="fa fa-list-alt" aria-hidden="true"></i>Book a Table</a> 
        </div>
    <% end if %>
</div>

</div>	
			
		</div>
		 <%            
            objRds.Close
            
        %>	

	</div> <!-- end header -->
    <div class="container">
    <% if s_BannerURL & "" <> "" then %>
    <div  style="overflow:hidden;" class="banner">
        <img src="<%=s_BannerURL %>" style="padding-bottom:15px;width:100%;" />
    </div>
        <div style="height:15px;"></div>
    <%end if %>
        <style>
            
.nav-stacked.nav-stacked.nav-pills.navdesktop li:nth-child(2){
padding-top:0;
}
.sidebar-header.sidebar-header{
background-color: #94b604;
    z-index: 100;
    width: 192px;
    color: #fff;
    border-color: #94b604;
    border: 1px solid #94b604;
    border-radius: 4px;
    padding: 10px 10px;
    border-bottom: 0px solid transparent;
    border-bottom-right-radius: 0px;
    border-bottom-left-radius: 0px;
    font-size: 18px;
}
.nav-stacked.nav-pills.navdesktop{
    border-top-right-radius: 0px;
    border-top-left-radius: 0px;
}

@media only screen and (max-width: 1199px){
.sidebar-header.sidebar-header{
max-width: 154.3px;
}

}
@media only screen and (max-width: 991px){
.sidebar-header.sidebar-header {
    display: none!important;
}
}


        </style>
	<div class="row clearfix">
		<div class="col-md-2" id="categories">		
		<div data-spy="affix" data-offset-top="300" data-offset-bottom="200">
			<div style="width:165px; height : 450px; overflow : auto; " class="hidden-xs hidden-sm">
                <div class="sidebar-header">
	                <b>Categories</b>
                </div>
                <ul class="nav nav-stacked nav-pills navdesktop" style="width:155px;overflow : auto;height: 80vh;border-top-right-radius: 0px;border-top-left-radius: 0px;">
				
				  <%
                  'objCon.Open sConnString
                Dim SQLCategory 
                    SQLCategory ="  SELECT DISTINCT   mc.id, mc.NAME, mc.description, displayorder   "
                    SQLCategory = SQLCategory & " FROM   ( menucategories   mc  with(nolock)    "
                    SQLCategory = SQLCategory & "        INNER JOIN Category_Openning_Time  ct  with(nolock)  "
                    SQLCategory = SQLCategory & "          on ( ct.categoryid = mc.id and ct.DayValue= " & sDayOfWeek & "   and ct.hour_from <= '" & hhmm1&"' and hour_to >= '"&hhmm1&"' and ct.status = 'ACTIVE'  )  ) "
                    SQLCategory = SQLCategory & "        INNER JOIN menuitems  mi  with(nolock)  "
                    SQLCategory = SQLCategory & "                ON mc.id = mi.idmenucategory "
                    SQLCategory = SQLCategory & "  WHERE  mc.idbusinessdetail = " & vRestaurantId & "  "
                    SQLCategory = SQLCategory & "        AND (( ( mi.idbusinessdetail ) = " & vRestaurantId & "  )) "
                    SQLCategory = SQLCategory & "        AND mi.hidedish <> 1 "
                    SQLCategory = SQLCategory & " ORDER  BY mc.displayorder; "

                   '   Response.Write(SQLCategory & "<br/>")
                
                      objRdsMainCategory.Open SQLCategory , objCon
                      
                        if not objRdsMainCategory.EOF then
                        
                            Do While NOT objRdsMainCategory.Eof
						        '' Check openning Time
                                
                            %>
                            <li ><a href="#menucat_<%=objRdsMainCategory("ID") %>" class="catlink" onclick="SelectLeftategory(<%=objRdsMainCategory("ID") %>);">
                                <%= objRdsMainCategory("Name") %></a> </li>
                            <%
                                objRdsMainCategory.MoveNext    
                            Loop
                            objRdsMainCategory.MoveFirst()
                        end if
                        %>
			</ul>
			</div></div>
		</div>
		<div class="col-md-6half column" id="mainmenu">
			    <ul class="nav nav-stacked nav-pills">
			
				</ul>

<script>
    function SelectLeftategory(ID)
    {
            $("#txtSearch").val("");
            $("#tabmenu").trigger("click");
            $(".product-line-heading").show();
            $("[data-type=group-cate]").each(function(){
                var categroup  = $(this);
                categroup.find(".product-line").each(function(){
                        $(this).show();
                });
            });
        
        $("#categroup-" + ID ).hide();
        $("#categroup-" + ID ).show();
        document.location.href = document.location.href.replace(document.location.hash,"") + "#menucat_" +  ID;
    }
</script>
<!-- Begin update html menu bar -->

<div class="menu-bar-wrapper">
         <% if  inmenuannouncement & "" <>"" then %>
            <div class="announmentinmenu" style="margin-bottom:20px;"><p><%=replace(replace(inmenuannouncement,vbCrLf,"<BR>"),"'","\'")  %></p></div>
         <%end if %>

<div class="menu-bar">
    <div class="menu-bar__item menu-bar__menu active" id="tabmenu" onclick="window.scrollTo(0,0);if($('#txtSearch').val() !='') { $('#txtSearch').val('');SearchTerms('txtSearch'); }  $('#navbar-menu-mobile').slideToggle();$('.js-menu-custom-item').slideUp();">
        <span class="glyphicon glyphicon-align-justify"></span> <span class="menu-text"> Menu</span>
    </div>
    
    <div class="menu-bar__item menu-bar__search" onclick="if($('#txtSearch').val() !='') { $('#txtSearch').val('');SearchTerms('txtSearch'); } $('.js-menu-custom-item').slideToggle('fast');$('#navbar-menu-mobile').slideUp();">
        <span class=" glyphicon glyphicon-search"></span>
        <span class="menu-text">Search</span>
    </div>
      <% if StrAllergen & "" <> "" then %>
      <div   class="menu-bar__item menu-bar__booking"   data-toggle="modal" data-backdrop="static" data-target="#FilterModal">
        <span class="glyphicon glyphicon-filter" id="icoAllergenFilter"></span>
        <span class="menu-text">Filter</span>
    </div>
    <% end if %>
    <div class="menu-bar__item menu-bar__login" data-toggle="modal" data-target="#loginModal">
        <span class="glyphicon glyphicon-user"></span>
        <span class="menu-text">Login</span>
    </div>
    <div class="menu-bar__item menu-bar__review" data-toggle="modal" data-target="#reviewsModal" >
        <span class="glyphicon glyphicon-comment"></span>
        <span class="menu-text">Review</span>
    </div>

    <div id="tabOpenTime" class="menu-bar__item menu-bar__openclock" data-toggle="modal" onclick=" scrollToV2('openninghours');" >        
        <span class="fa fa-clock-o" aria-hidden="true"></span>
        <span class="menu-text">Opening Times</span>
    </div>
    
</div>

<div class="collapse scrollable-menu hidden-lg hidden-md" id="navbar-menu-mobile" style="display:none;">
    <ul class="nav navbar-nav">
        <%
        if not objRdsMainCategory.EOF then
            Do While NOT objRdsMainCategory.Eof
        
            %>
            <li ><a class="movedown" data="categroup-<%=objRdsMainCategory("ID") %>"  onclick="CategorySelection('categroup-<%=objRdsMainCategory("ID") %>');">
                <%=objRdsMainCategory("Name") %></a> </li>
            <%
                objRdsMainCategory.MoveNext    
            Loop
            objRdsMainCategory.MoveFirst()
        end if
    %>
    </ul>   
</div>
  
<div class="alpha-search-custom js-menu-custom-item">
    <div class="input-group" style="width:100%;">
    <input type="search" class="search-query form-control clearable" spellcheck="false"  autocapitalize="off" autocomplete="off" autocorrect="off" onfocus="SearchTerms('txtSearch');"  id="txtSearch"  onkeyup="window.scrollTo(0,0);SearchTerms('txtSearch');" placeholder="Search as you type" />
   <!-- <span class="input-group-btn">
        <button class="btn btn-primary"  type="button">Search</button>
      </span>-->
    </div>
</div>
   
</div>
 
          

<!-- End update menu bar -->
                    <!--task 282 Reorder-->
                        <% 
                            if lcase(enablereorder &"")=  "yes" then
                                Dim CustomerEmail : CustomerEmail = Request.Cookies("Email") 
                                    if Request.Cookies("Email")  & "" <> "" then
                                        CustomerEmail = Request.Cookies("Email")  & ""
                                    end if
                               ' CustomerEmail = "tam.dang832912@gmail.com"
                                if trim(CustomerEmail & "") <> "" then
                                        Dim  SQL_Order : SQL_Order = "select top 2 ID,orderdate from Orders with(nolock) where Email ='"&CustomerEmail&"' " 
                                             SQL_Order =  SQL_Order  & " and exists "
                                             SQL_Order =  SQL_Order  & "  ( select top 1 1 from  OrderItems oi inner join MenuItems mi on oi.MenuItemId = mi.Id  where hidedish <> 1 and oi.OrderId = Orders.ID  )  "
                                             SQL_Order =  SQL_Order & " order by ID desc"
                                        Dim  RS_Order : set RS_Order = Server.CreateObject("ADODB.Recordset")
                                             RS_Order.Open SQL_Order , objCon
                                if not RS_Order.EOF then
                                    %>
                                                <div class="previous-order-heading panel panel-default" style="margin-bottom: 0;border-radius: 0;">
                                                    <div class="panel-heading product-line-heading clearfix" onclick="ShowdishpropertiesV2('PreviousOrder');">
                                                        <h4 class="panel-title">Previous Orders</h4>
                                                        <div class="product-line-heading__icon-wrapper is-vertical-center">
                                                                <img class="product-line-heading__icon arrow-icon-down" src="https://www.greek-painters.com/vo/food/7-6-Dang/images/menu-category-collapse--retina.png" alt="" id="imgPreviousOrder">
                                                        </div>
                                                    </div>
                                                    <div class="panel-body" id="PreviousOrder" style="display:none;">

                                      
                                    <%
                                                     While not RS_Order.EOF
                                                
                                                    dim orderdatef :    orderdatef =  cdate(RS_Order("orderdate"))
                                            
                                                    orderdatef = day(orderdatef) & " " & MonthName(month(orderdatef)) & " " & Year(orderdatef) 
                                                    Dim OrderInfo : OrderInfo = ""
                                    %>  
                                                <div class="group-ptoduct-line">
                                                    <div class="product-line">
                                                        <div class="product-line__content-left"><b><%=orderdatef %></b><br />
                                                            <span id="order<%=RS_Order("ID") %>" style="font-size:10px;"></span>
                                                        </div>
                                                        <div class="product-line__content-right"><span class="btn btn-success btnadd" onclick="ReOrder(<%=RS_Order("ID") %>)">Re-Order</span></div>
                                                    </div>
                                                     <%
                                                              '' Load Order Item 
                                                            set     objRds_Item = Server.CreateObject("ADODB.Recordset")                                                          
                                                                    objRds_Item.Open "select oi.Total,oi.toppingids,oi.dishpropertiesids,oi.MenuItemId,oi.MenuItemPropertyId,oi.Qta," & _
                                                                            "mi.Name, mip.Name as PropertyName ,isnull(mi.ApplyTo,'b') as ApplyTo, mi.hidedish " & _
                                                                            "from ( OrderItems oi " & _
                                                                            "inner join MenuItems mi on oi.MenuItemId = mi.Id ) " & _
                                                                            "left join MenuItemProperties mip on oi.MenuItemPropertyId = mip.Id " & _
                                                                            "where oi.OrderId = " & RS_Order("ID") & " order by oi.ID desc" , objCon
                                                           while not objRds_Item.eof 
                                                                Dim dishpropertiesprice : dishpropertiesprice = ""
                                                                Dim dishpropertiessplit ,dishpropertiessplit2
                                                                Dim toppingtext
                                                            If objRds_Item("dishpropertiesids") <> "" Then						 
						                                        dishpropertiessplit=split(objRds_Item("dishpropertiesids"),",")
					                                                for i=0 to ubound(dishpropertiessplit)					
					                                                    dishpropertiessplit2=split(dishpropertiessplit(i),"|")
					                                                    if dishpropertiessplit2(1)<>0 then					
					                                                        Set objRds_dishpropertiesprice = Server.CreateObject("ADODB.Recordset") 					
	                                                                            objRds_dishpropertiesprice.Open "SELECT MenuDishproperties.ID, MenuDishproperties.dishproperty, MenuDishproperties.dishpropertyprice, MenuDishpropertiesGroups.dishpropertypricetype, MenuDishpropertiesGroups.dishpropertygroup FROM MenuDishproperties   INNER JOIN MenuDishpropertiesGroups    ON MenuDishproperties.dishpropertygroupid = MenuDishpropertiesGroups.ID where (((MenuDishproperties.ID)=" & dishpropertiessplit2(1)  & "))", objCon
					                                                            dishpropertiesprice =  "<BR> <small>" & objRds_dishpropertiesprice("dishpropertygroup") & ":" & objRds_dishpropertiesprice("dishproperty") & "</small>" 
					                                                            objRds_dishpropertiesprice.close()
                                                                            set objRds_dishpropertiesprice = nothing
					                                                    end if
					
					                                                next
					                                        end if

                                                            toppingtext=""
						                                If objRds_Item("toppingids") <> "" Then 
                                                                 Dim SQLTopping 
                                                                    SQLTopping = "  SELECT distinct a.toppinggroupid,ap.toppingsgroup FROM MenuToppings a with(nolock)  "
                                                                    SQLTopping = SQLTopping & "  join Menutoppingsgroups ap with(nolock) on a.toppinggroupid = ap.ID "
                                                                    SQLTopping = SQLTopping & " where a.id in  (" & objRds_Item("toppingids") & ") "
                                                                dim objRds_toppingids_group : Set objRds_toppingids_group = Server.CreateObject("ADODB.Recordset") 
                                                                    objRds_toppingids_group.Open SQLTopping, objCon
                                                             while not objRds_toppingids_group.eof
								                                    Set objRds_toppingids = Server.CreateObject("ADODB.Recordset")                                                                
                                                                    SQLTopping = "SELECT m.topping,isnull(mp.toppingsgroup,'') as toppingsgroup FROM MenuToppings m "
                                                                    SQLTopping =SQLTopping & "  left join Menutoppingsgroups mp on  m.toppinggroupid = mp.ID"
                                                                    SQLTopping =SQLTopping & "    where m.id in ("& objRds_Item("toppingids") &") and  m.toppinggroupid=" & objRds_toppingids_group("toppinggroupid")
                                                                    objRds_toppingids.Open SQLTopping, objCon
				                                                    toppingtext=""
                                                                    Dim toppinggroup : toppinggroup = ""
                                                                    toppingtext=""    
                                                                    toppinggroup = objRds_toppingids_group("toppingsgroup")

				                                                    Do While NOT objRds_toppingids.Eof 
						                                                toppingtext = toppingtext & objRds_toppingids("topping") & ", "
                                                                        'toppinggroup = objRds_toppingids("toppingsgroup")
						                                                objRds_toppingids.MoveNext
						                                            loop
                                                                        objRds_toppingids.close()
                                                                    set objRds_toppingids = nothing
						                                            if toppingtext<>"" then
							                                              if toppinggroup & "" = "" then
                                                                            toppinggroup = "Toppings"
                                                                          end if  
                                                                         toppingtext=left(toppingtext,len(toppingtext)-2)
						                                                toppingtext = "<small><br>"&toppinggroup&": " & toppingtext & "</small>"
						                                            end if
                                                                objRds_toppingids_group.movenext()
                                                             wend
                                                                objRds_toppingids_group.close()
                                                            set objRds_toppingids_group = nothing
						                                 End If

                                                                dim ItemPrice : ItemPrice = cdbl(objRds_Item("Total"))/cdbl(objRds_Item("Qta"))
                                                                OrderInfo =  "<div>" &   OrderInfo & objRds_Item("Qta") & " x " & objRds_Item("Name") & " " &  objRds_Item("PropertyName") & dishpropertiesprice & toppingtext &   "</div>"
                                                             %>
                                                    <div class="product-line">                                           
                                                        <div class="product-line__content-left">
                                                          
                                                             <%= objRds_Item("Name") %>&nbsp;<%= objRds_Item("PropertyName") %> 
                                                            <%=dishpropertiesprice %>  
                                                            <%=toppingtext %>  
                                                        </div>
                                                        <div class="product-line__content-right">
                                                            <div class="d-flex-center d-flex-end">
                                                            <% if objRds_Item("hidedish") & "" <> "1" then %> 
                                                                    <div class="product-line__price"><b><%=CURRENCYSYMBOL%><%= FormatNumber(ItemPrice, 2) %></b></div>  
                                                            <% end if %>                                        
                                                             <div align="right">    
                                                                 <% if objRds_Item("hidedish") & "" = "1" then %> 
                                                                    <b>unavailable</b>
                                                                 <%else %>
                                                                    <button class="btn btn-success btnadd"  onclick="AdditemTocart('<%=objRds_Item("MenuItemId")&""%>','<%=objRds_Item("MenuItemPropertyId")&""%>' ,'<%=objRds_Item("toppingids")&""%>' ,'<%=objRds_Item("dishpropertiesids")&""%>' ,'1')">
                                                                          <span class="glyphicon glyphicon-plus"></span>
                                                                    </button>         
                                                                 <%end if %>   
                                                            </div>	
                                                                </div>				
                                                    </div>

                                                
                                                    </div>
                                                        <%  objRds_Item.movenext
                                                            wend
                                                            objRds_Item.close()
                                                            set objRds_Item = nothing
                                                             %>
                                                        
                                                          <script type="text/javascript">
                                                              $("#order<%=RS_Order("ID") %>").html('<%=OrderInfo%>');
                                                          </script>  
                                         
                                                </div>
                                            <% 
                                                RS_Order.movenext()
                                                wend %>
                                                 </div>
                                               </div>
                                       <% end if
                               RS_Order.close()
                               set RS_Order = nothing
                                %> 
                             <% end if 
                            
                         End if%>
                    <!--End reorder-->
                    <% 
                
                Dim vCategoryId                
                Dim vMenuItemId
                Dim vMenuItemPrice
                Dim f  
                
                dim SQL 
                   
                    'SQL =SQL & " ORDER BY mi.code,mi.Name,mip.Name; "
               
                dim categoryID,CategoryName,CategoryDescription
                
                while not objRdsMainCategory.EOF
                        categoryID = objRdsMainCategory("ID")
                        CategoryName = objRdsMainCategory("Name")
                        CategoryDescription = objRdsMainCategory("Description")
                        %>
                            <div class="categroup-<%=categoryID %> "></div>
                            <div id="group-categroup-<%=categoryID %>" class="product-line-heading clearfix" onclick="ShowdishpropertiesV2('categroup-<%=categoryID %>')">
                            <h4 class="product-line-heading__cat pull-left" >
                            <a id="menucat_<%=categoryID %>" name="menucat_<%=categoryID %>" ></a>
                            <%= CategoryName%>   
                            </h4>
                            
                            <div class="product-line-heading__icon-wrapper is-vertical-center">
                                <img class="product-line-heading__icon" src="<%=SITE_URL %>images/menu-category-collapse--retina.png" alt="" id="imgcategroup-<%=categoryID %>">
                            </div>   
                            <% if CategoryDescription & "" <> "" then %>
                            <div class="product-line-heading__cat-des">
                                <%= CategoryDescription %>
                            </div>    
                            <% end if %>     
                        
                                </div>
                        <div id="categroup-<%=categoryID %>" class="group-ptoduct-line" data-type="group-cate">
                        <%
                         ' Load Menu Item 
                            SQL = " SELECT mi.IdMenuCategory,mi.Id,mi.Code,mi.Description,mi.dishpropertygroupid,mi.hidedish,mi.Name,mi.Photo,mi.Price,mi.PrintingName,mi.Spicyness,mi.i_displaysort, "
                            SQL =SQL & " mip.Id AS PropertyId, mip.Name AS PropertyName, "
                            SQL =SQL & "mip.Price AS PropertyPrice,  mi.allowtoppings AS miallowtoppings, "
                            SQL =SQL & " mi.ToppingGroupIDs AS ToppingGroupIDs,mip.ToppingGroupIDs AS MToppingGroupIDs, "
                            SQL =SQL & " mip.allowtoppings AS mipallowtoppings,mip.i_displaysort  "
                            SQL = SQL & ",mip.s_ContainAllergen as s_ContainAllergen_p,mip.s_MayContainAllergen as s_MayContainAllergen_p,mip.s_SuitableFor as s_SuitableFor_p "
                            SQL = SQL & ",mi.s_ContainAllergen as s_ContainAllergen_m,mi.s_MayContainAllergen as s_MayContainAllergen_m,mi.s_SuitableFor as s_SuitableFor_m "
                            SQL =SQL & " FROM  MenuItems  mi  with(nolock)  "
                            SQL =SQL & " LEFT JOIN MenuItemProperties  mip with(nolock)  ON mi.Id = mip.IdMenuItem "
                            SQL =SQL & "WHERE    mi.idbusinessdetail =  " & vRestaurantId & "  AND mi.hidedish<>1 and mi.IdMenuCategory=" & categoryID
                            SQL =SQL & " ORDER BY mi.i_displaysort,mi.id,mip.i_displaysort,mip.Id; "
                            
                           ' objRds_MenuItem.Filter =  " IdMenuCategory = " & categoryID  & ""
                              dim objRds_MenuItem : set objRds_MenuItem  =  Server.CreateObject("ADODB.Recordset") 
                            objRds_MenuItem.Open SQL, objCon 
                            dim Code,MenuDescription,dishpropertygroupid,hidedish
                            dim MenuItemName,Photo,MenuPrice,menuPrintingName,Spicyness,Vegetarian
                            dim PropertyName,PropertyId,PropertyPrice,miallowtoppings,mipallowtoppings,ToppingGroupIDs,MToppingGroupIDs
                            
                            MenuItemName = ""
                            dim menuItemNameID : menuItemNameID = ""
                            dim s_ContainAllergen_p,s_MayContainAllergen_p,s_SuitableFor_p 
                            dim s_ContainAllergen_m,s_MayContainAllergen_m,s_SuitableFor_m
                            while not objRds_MenuItem.EOF
                                    s_ContainAllergen_m = replace(objRds_MenuItem("s_ContainAllergen_m") & ""," ","")
                                    s_MayContainAllergen_m = replace(objRds_MenuItem("s_MayContainAllergen_m") & ""," ","")
                                    s_SuitableFor_m = replace(objRds_MenuItem("s_SuitableFor_m") & ""," ","")
                            
                                    s_ContainAllergen_p = replace(objRds_MenuItem("s_ContainAllergen_p") & ""," ","")
                                    s_MayContainAllergen_p = replace(objRds_MenuItem("s_MayContainAllergen_p") & ""," ","")
                                    s_SuitableFor_p = replace(objRds_MenuItem("s_SuitableFor_p") & ""," ","")

                                    
                                   vMenuItemId = objRds_MenuItem("Id")
                                   Code =  objRds_MenuItem("Code")
                                   MenuDescription = objRds_MenuItem("Description")
                                   dishpropertygroupid = objRds_MenuItem("dishpropertygroupid")
                                   hidedish = objRds_MenuItem("hidedish")
                                   MenuItemName = objRds_MenuItem("Name")
                                   Photo = objRds_MenuItem("Photo")
                                   MenuPrice = objRds_MenuItem("Price")
                                   menuPrintingName = objRds_MenuItem("PrintingName")
                                   Spicyness = objRds_MenuItem("Spicyness")
                                   'Vegetarian = objRds_MenuItem("Vegetarian")
                                   PropertyName = objRds_MenuItem("PropertyName")
                                    PropertyId = "-1"
                                     If Not IsNull(objRds_MenuItem("PropertyId")) Then
                                        PropertyId = objRds_MenuItem("PropertyId")
                                        PropertyPrice = objRds_MenuItem("PropertyPrice")    
                                         if MenuPrice & "" = "0" or MenuPrice & "" = ""  then 
                                            MenuPrice = PropertyPrice
                                        end if                      
                                    End If
                                   
                                   miallowtoppings = objRds_MenuItem("miallowtoppings")
                                   mipallowtoppings = objRds_MenuItem("mipallowtoppings")
                                   ToppingGroupIDs = objRds_MenuItem("ToppingGroupIDs")
                                   MToppingGroupIDs = objRds_MenuItem("MToppingGroupIDs")

                           
                            
                                    dim class_noborder : class_noborder = ""
                                    if menuItemNameID = vMenuItemId then
                                        class_noborder = " no-border"
                                    End if
                                    dim parent : parent = "" 
                                     if menuItemNameID <> vMenuItemId then
                                            parent = "parent='0'"
                                    end if
                                       %>

                              
                                <div class="product-line <%=class_noborder %>" name="<%=vMenuItemId %>" <%=parent %>>
                                    <!--Menu Item Name-->                                  
                                   
                                        <% 
                                          
                                            if menuItemNameID <> vMenuItemId then  %>
                                                 <div class="product-line__content-left<%=class_noborder %>">
                                                    <div class="d-flex-center d-flex-start">
                                             <%
                                                 dim styleMarginleft : styleMarginleft =""
								            If Photo <> "" Then 
                                                 styleMarginleft = "style='margin-left:12px;' "
								               photo=1%>
                                                   <div  class="product10w photo" data-toggle="modal" data-target="#lightbox">  
                                                        <img data-src="<%=SITE_URL %>Images/<%=vRestaurantId %>/<%= objRds_MenuItem("Photo")%>" class="img-rounded lazy" alt="<%= MenuItemName%>" style="vertical-align: top;width:30px;max-width:40px;" /> 
                                                            <div class="overlay">
                                                                    <a href="javascript:;"  class="magnifying-glass-icon foobox" style="top:12px;left:20px;">
                                                                    <i class="fa fa-search"></i>
                                                                    </a>
                                                            </div>
						                            </div>	
                                            <%End If %>
                                            
                                            <div class="product-line__number" <%=styleMarginleft %>>
                                            <% If Code <> "" Then 
								                code=1%>
                                                   
                                                    <%= objRds_MenuItem("Code")  %>.
                                                <%End If %>
                                             </div>
                                             

                                            <div class="product-line__description desc " s_ContainAllergen_m="<%=s_ContainAllergen_m & "|" & s_MayContainAllergen_m %>" s_MayContainAllergen_m="<%=s_MayContainAllergen_m %>" s_SuitableFor_m="<%=s_SuitableFor_m %>" >
                                            <%=MenuItemName %>

                                            <%If Vegetarian Then %> 
                                                <!--<img src="<%=SITE_URL %>Images/veggie_small.png"  alt="veggie" />-->
                                            <%End If %>
                                            
                                            <%
                                                dim index_m ,s_contain
                                           
                                                 if s_ContainAllergen_m & "" <> "" then 
                                                  ''FindAllergen
                                                    dim   arr_s_ContainAllergen_m : arr_s_ContainAllergen_m = split(s_ContainAllergen_m,",")
                                                     index_m = 0
                                                    for index_m = 0 to ubound(arr_s_ContainAllergen_m)
                                                         s_contain = FindAllergen(arr_s_ContainAllergen_m(index_m) )
                                                        if s_contain & "" <> "" then
                                                                %>
                                                                    <img width="17" height="17" data-container="body" data-toggle="tooltip"  src="<%=SITE_URL %>Images/allergen/png/<%=replace( split(s_contain,"|")(2),"amber","red")   %>" title="Contains <%=split(s_contain,"|")(1) %>"  alt="Contains <%=split(s_contain,"|")(1) %>" />
                                                                <%
                                                        end if
                                                    next
                                                %>

                                            <% end if %>

                                             <% if s_MayContainAllergen_m & "" <> "" then 
                                                  ''FindAllergen
                                                    dim arr_s_MayContainAllergen_m : arr_s_MayContainAllergen_m= split(s_MayContainAllergen_m,",")
                                                  index_m = 0
                                                    for index_m = 0 to ubound(arr_s_MayContainAllergen_m)
                                                        s_contain =FindAllergen(arr_s_MayContainAllergen_m(index_m) )
                                                        if s_contain & "" <> "" then%>
                                                                    <img width="17" height="17" data-container="body" data-toggle="tooltip"  src="<%=SITE_URL %>Images/allergen/png/<%=split(s_contain,"|")(2)  %>" title="May contain <%=split(s_contain,"|")(1) %>" alt="May contain <%=split(s_contain,"|")(1) %>" />
                                                                <%
                                                        end if
                                                    next
                                                %>

                                            <% end if %>

                                                  <% if s_SuitableFor_m & "" <> "" then 
                                                  ''FindAllergen
                                                    dim arr_s_SuitableFor_m : arr_s_SuitableFor_m= split(s_SuitableFor_m,",")
                                                    index_m = 0
                                                    for index_m = 0 to ubound(arr_s_SuitableFor_m)
                                                         s_contain =FindAllergen( arr_s_SuitableFor_m(index_m) )
                                                        if s_contain & "" <> "" then%>
                                                                    <img width="17" height="17" data-container="body" data-toggle="tooltip"  src="<%=SITE_URL %>Images/allergen/png/<%=split(s_contain,"|")(2)  %>"  title="<%=split(s_contain,"|")(1) %>" alt="<%=split(s_contain,"|")(1) %>"  />
                                                                <%
                                                        end if
                                                    next
                                                %>

                                            <% end if %>


                                            <%
                                                dim spicytitle  : spicytitle = "Mildly Spicy" 
                                                
                                                if Spicyness = 2  then
                                                    spicytitle = "Spicy" 
                                                elseif Spicyness = 3  then
                                                    spicytitle = "Very Spicy" 
                                                end if
                                                If Spicyness> 0 Then %>
                                                <img src="<%=SITE_URL %>Images/spicy_<%= Spicyness %>.png?v=1.1"  height="17" alt="<%=spicytitle %>" title="<%=spicytitle %>"  data-container="body" data-toggle="tooltip"  />
                                            <%End If %><br />
                                            <% if MenuDescription & "" <> "" then %>
                                                <i><span class="small"><%= MenuDescription %></span></i>
                                            <% end if %>

                                            </div>
                                         </div>
                                     </div>
                                        <% end if
                                            menuItemNameID = vMenuItemId
                                        %>
                                       
                                    <!--Propertyname and Price-->
                                    <!--<div style="width:30%;float:left;">-->
                                        <!--PropertyName-->
                                        
                                        <div class="product-line__content-right" style="width:85%">
                                        <!--<div style="display:none;" class="hidden-product-name"><%=MenuItemName %></div>-->
                                        <div class="d-flex-center d-flex-end">
                                        <div class="product-line__property-name" s_ContainAllergen_p="<%=s_ContainAllergen_p & "|" & s_MayContainAllergen_p %>" s_MayContainAllergen_p="<%=s_MayContainAllergen_p %>"  s_SuitableFor_p="<%=s_SuitableFor_p %>"  ><%=PropertyName %>
                                              <%
                                                 if s_ContainAllergen_p & "" <> "" then 
                                                  ''FindAllergen
                                                    dim   arr_s_ContainAllergen_p : arr_s_ContainAllergen_p = split(s_ContainAllergen_p,",")
                                                     index_m = 0
                                                    for index_m = 0 to ubound(arr_s_ContainAllergen_p)
                                                         s_contain = FindAllergen(arr_s_ContainAllergen_p(index_m) )
                                                        if s_contain & "" <> "" then
                                                                %>
                                                                    <img width="17" height="17" data-toggle="tooltip"  src="<%=SITE_URL %>Images/allergen/png/<%=replace(split(s_contain,"|")(2),"amber","red")  %>" title="Contains <%=split(s_contain,"|")(1) %>"  alt="Contains <%=split(s_contain,"|")(1) %>" />
                                                                <%
                                                        end if
                                                    next
                                                %>

                                            <% end if %>

                                             <% if s_MayContainAllergen_p & "" <> "" then 
                                                  ''FindAllergen
                                                    dim arr_s_MayContainAllergen_p : arr_s_MayContainAllergen_p= split(s_MayContainAllergen_p,",")
                                                  index_m = 0
                                                    for index_m = 0 to ubound(arr_s_MayContainAllergen_p)
                                                        s_contain =FindAllergen(arr_s_MayContainAllergen_p(index_m) )
                                                        if s_contain & "" <> "" then%>
                                                                    <img width="17" height="17" data-toggle="tooltip"  src="<%=SITE_URL %>Images/allergen/png/<%=split(s_contain,"|")(2)  %>" title="May contain <%=split(s_contain,"|")(1) %>"  alt="May contain <%=split(s_contain,"|")(1) %>" />
                                                                <%
                                                        end if
                                                    next
                                                %>

                                            <% end if %>

                                                  <% if s_SuitableFor_p & "" <> "" then 
                                                  ''FindAllergen
                                                    dim arr_s_SuitableFor_p : arr_s_SuitableFor_p= split(s_SuitableFor_p,",")
                                                    index_m = 0
                                                    for index_m = 0 to ubound(arr_s_SuitableFor_p)
                                                         s_contain =FindAllergen( arr_s_SuitableFor_p(index_m) )
                                                        if s_contain & "" <> "" then%>
                                                                    <img width="17" height="17" data-toggle="tooltip"  src="<%=SITE_URL %>Images/allergen/png/<%=split(s_contain,"|")(2)  %>" title="<%=split(s_contain,"|")(1) %>" alt="<%=split(s_contain,"|")(1) %>"  />
                                                                <%
                                                        end if
                                                    next
                                                %>

                                            <% end if %>

                                        </div> 

                                         <% donotshowprice="n"
								            dishpropertiestext=""
								            pricefrom=0
								        ' code to check if other dish properties are applicable to this product
								        if dishpropertygroupid & "" <>"" then%>
								        <%
								        'Set objCon_properties = Server.CreateObject("ADODB.Connection")
								        Set objRds_properties = Server.CreateObject("ADODB.Recordset") 
          
								        'objCon_properties.Open sConnString
                                            objRds_properties.Open "SELECT dishpropertypricetype,dishpropertyrequired,i_displaysort,dishpropertygroup, id FROM MenuDishpropertiesGroups with(nolock)   where id in (" & dishpropertygroupid & ") order by i_displaysort, id ", objCon
				                            While NOT objRds_properties.Eof 
                                                dishpropertiestext =  dishpropertiestext & "<div class=""dishproperties__title"">" & objRds_properties("dishpropertygroup") & " </div> "
                                                 
                                                 dishpropertiestext =  dishpropertiestext & " <select name=""" & objRds_properties("id") & """ id=""" & objRds_properties("id") & """ class=""form-control selectpicker"" data-group=""dishproperties" & vMenuItemId & "-" & PropertyId & """"
                                            if objRds_properties("dishpropertyrequired")<>1  then
                                                dishpropertiestext = dishpropertiestext & " data-required=""n"">"
                                                dishpropertiestext = dishpropertiestext & "><option value=""0"">-- select --</option>"
                                            else
                                                dishpropertiestext = dishpropertiestext & " data-required=""y"" data-caption=""Please choose " & replace(objRds_properties("dishpropertygroup"),"""","") & """>"
                                                dishpropertiestext = dishpropertiestext & "><option value=""0"">-- select --</option>"
                                            end if
						
								                'Set objCon_propertiesitems = Server.CreateObject("ADODB.Connection")
								                Set objRds_propertiesitems = Server.CreateObject("ADODB.Recordset") 
								                'objCon_propertiesitems.Open sConnString
                                                'SQL = "SELECT * FROM MenuDishproperties where dishpropertygroupid=" & objRds_properties("id") & " order by dishpropertyprice"
                                                SQL = "SELECT dishproperty,dishpropertyprice,id,i_displaysort,s_ContainAllergen,s_MayContainAllergen,s_SuitableFor FROM MenuDishproperties with(nolock)    where dishpropertygroupid=" & objRds_properties("id")  & " order by i_displaysort, id "
                                                objRds_propertiesitems.Open SQL, objCon
				                                dim s_ContainAllergen_dp,s_MayContainAllergen_dp,s_SuitableFor_dp  
                                                dim htmltooltip : htmltooltip = "" 
				                                While NOT objRds_propertiesitems.Eof 
                                                    dim htmlicon : htmlicon = ""
                                                     '   htmltooltip = ""
                                                    s_ContainAllergen_dp = replace(objRds_propertiesitems("s_ContainAllergen") & ""," ","") 
                                                    s_MayContainAllergen_dp = replace(objRds_propertiesitems("s_MayContainAllergen") & "" ," ","") 
                                                    s_SuitableFor_dp  = replace(objRds_propertiesitems("s_SuitableFor") & ""," ","") 
                                                     htmltooltip = htmltooltip & "<b>" &  objRds_propertiesitems("dishproperty") & "</b>"  & "<br/>"
                                                     dim htmltooltip1 : htmltooltip1 = ""
                                                     Dim isAllergen : isAllergen = false
                                                     if s_ContainAllergen_dp & "" <> "" then                                                   
                                                        dim   arr_s_ContainAllergen_dp : arr_s_ContainAllergen_dp = split(s_ContainAllergen_dp,",")
                                                         index_m = 0
                                                        for index_m = 0 to ubound(arr_s_ContainAllergen_dp)
                                                             s_contain = FindAllergen(arr_s_ContainAllergen_dp(index_m) )
                                                            if s_contain & "" <> "" then
                                                                if instr(htmltooltip1,"Contains") = 0 then
                                                                     htmltooltip1 = htmltooltip1 &  "Contains: " 
                                                                end if
                                                                     htmltooltip1 =  htmltooltip1 & " <img width=""17"" height=""17""  src=""" & SITE_URL & "Images/allergen/png/" & replace( split(s_contain,"|")(2),"amber","red") & """ /> "
                                                                     htmltooltip1 =  htmltooltip1 &  split(s_contain,"|")(1) & ", "
                                                                       htmlicon = htmlicon &  SITE_URL &  "Images/allergen/png/"  & replace(split(s_contain,"|")(2),"amber","red")  & ";"                                                                
                                                            end if
                                                        next
                                                    end if
                                                        if htmltooltip1 & "" <> "" then
                                                            isAllergen =  true
                                                            htmltooltip1 =  left(trim(htmltooltip1),len(trim(htmltooltip1))-1)
                                                            htmltooltip = htmltooltip & "<span class=""tip-allergen"">" &  htmltooltip1 & "</span><br/>"
                                                         end if
                                                    htmltooltip1  =""
                                                    if s_MayContainAllergen_dp & "" <> "" then                                                   
                                                        dim   arr_s_MayContainAllergen_dp : arr_s_MayContainAllergen_dp = split(s_MayContainAllergen_dp,",")
                                                         index_m = 0
                                                        for index_m = 0 to ubound(arr_s_MayContainAllergen_dp)
                                                             s_contain = FindAllergen(arr_s_MayContainAllergen_dp(index_m) )
                                                            if s_contain & "" <> "" then
                                                                       if instr(htmltooltip1,"May Contain") = 0 then
                                                                             htmltooltip1 = htmltooltip1 &  "May Contain: " 
                                                                        end if
                                                                        htmltooltip1 =  htmltooltip1 & " <img width=""17"" height=""17""  src=""" & SITE_URL & "Images/allergen/png/" & split(s_contain,"|")(2) & """ /> "
                                                                        htmltooltip1 =  htmltooltip1 & split(s_contain,"|")(1) & ", "
                                                                       htmlicon = htmlicon &  SITE_URL &  "Images/allergen/png/"  & split(s_contain,"|")(2)  & ";"   
                                                            end if
                                                        next
                                                    end if
                                                     if htmltooltip1 & "" <> "" then
                                                            isAllergen =  true
                                                            htmltooltip1 =  left(trim(htmltooltip1),len(trim(htmltooltip1))-1)
                                                            htmltooltip = htmltooltip & "<span class=""tip-allergen"">" &  htmltooltip1 & "</span><br/>"
                                                         end if
                                                    htmltooltip1  =""
                                                    if s_SuitableFor_dp & "" <> "" then                                                   
                                                        dim   arr_s_SuitableFor_dp : arr_s_SuitableFor_dp = split(s_SuitableFor_dp,",")
                                                         index_m = 0
                                                        for index_m = 0 to ubound(arr_s_SuitableFor_dp)
                                                             s_contain = FindAllergen(arr_s_SuitableFor_dp(index_m) )
                                                            if s_contain & "" <> "" then
                                                                       if instr(htmltooltip1,"Suitable For") = 0 then
                                                                             htmltooltip1 = htmltooltip1 &  "Suitable For: " 
                                                                        end if
                                                                        htmltooltip1 =  htmltooltip1 & " <img width=""17"" height=""17""  src=""" & SITE_URL & "Images/allergen/png/" & split(s_contain,"|")(2) & """ /> "
                                                                        htmltooltip1 =  htmltooltip1 & split(s_contain,"|")(1) & ", "
                                                                      htmlicon = htmlicon &  SITE_URL &  "Images/allergen/png/"  & split(s_contain,"|")(2)  & ";"   
                                                            end if
                                                        next
                                                    end if
                                                     if htmltooltip1 & "" <> "" then
                                                            isAllergen =  true
                                                            htmltooltip1 =  left(trim(htmltooltip1),len(trim(htmltooltip1))-1)
                                                            htmltooltip = htmltooltip & "<span class=""tip-allergen"">" &  htmltooltip1 & "</span><br/>"
                                                     end if
                                                     if isAllergen =false  then
                                                         htmltooltip = htmltooltip & "<span class=""tip-allergen"">No Allergens</span><br/>"
                                                     end if   
                                                  '  htmltooltip =  htmltooltip & "<br/>"
                                                    
				                                    add=""
				                                    if objRds_properties("dishpropertypricetype")="add" then
				                                        add=" - add "
				                                    else
				                                        donotshowprice="y"
				                                        if pricefrom & "" = "0" or pricefrom & "" = ""  then
					                                        pricefrom=objRds_propertiesitems("dishpropertyprice")
				                                        end if
				                                    end if
                                                    if add = "" then
                                                        add = " - "    
                                                    end if     
				                                    dishpropertiestext = dishpropertiestext & "<option data-thumbnail=""" & htmlicon & """ s_SuitableFor_dp="""& s_SuitableFor_dp &"""  s_MayContainAllergen_dp="""& s_MayContainAllergen_dp  &""" s_ContainAllergen_dp="""& s_ContainAllergen_dp & "|" & s_MayContainAllergen_dp &""" value=""" & objRds_propertiesitems("id") & """>" & objRds_propertiesitems("dishproperty") & add & " " &  CURRENCYSYMBOL & FormatNumber(objRds_propertiesitems("dishpropertyprice"),2) & "</option>"
				    		                        objRds_propertiesitems.MoveNext
							                    wend 
                                                objRds_propertiesitems.close()
                                            set objRds_propertiesitems =  nothing
                                           
                                            dishpropertiestext = dishpropertiestext & "</select> "
                                            
                                            '' Add Add tooltip here
                                                if instr(htmltooltip,"Contains:") =  0 and instr(htmltooltip,"May Contain:") =  0 and  instr(htmltooltip,"Suitable For:") =  0 then
                                                        htmltooltip = ""
                                                else
                                                    dishpropertiestext =  dishpropertiestext & "   <span class=""glyphicon glyphicon-exclamation-sign append text-info tip"" data-tip=""tip-"&objRds_properties("id")&""" ></span> <br>"    
                                                    dishpropertiestext = dishpropertiestext & "<div id=""tip-" & objRds_properties("id") & """ class=""tip-content hidden tooltip-custom""> "
                                                    dishpropertiestext=  dishpropertiestext &    htmltooltip
                                                    dishpropertiestext = dishpropertiestext & "</div>"
                                                end if
                                                  
                                            '' end 
						                    objRds_properties.MoveNext
                                            wend 
                                            objRds_properties.close()
                                            set objRds_properties = nothing
                                        End if

                                  
								' code to check if toppings are applicable to this product
								dishtoppingstext=""
								'if (miallowtoppings & "" <> "0" and trim( miallowtoppings & "") <> "") or ( mipallowtoppings & "" <> "0" and trim( mipallowtoppings & "") <> "")  then
                                            
                                            if ToppingGroupIDs & "" <> "" or MToppingGroupIDs & "" <> ""  then
                                                dim listtoppinggroupid : listtoppinggroupid = ""
                                                    if trim( miallowtoppings & "") <> "0" and trim( miallowtoppings & "") <> ""   then
                                                        listtoppinggroupid = miallowtoppings
                                                    end if

                                            if trim( mipallowtoppings & "") <> "0" and  trim( mipallowtoppings & "") <> ""  then
                                                if listtoppinggroupid = "" then
                                                    listtoppinggroupid =mipallowtoppings
                                                else
                                                    listtoppinggroupid =listtoppinggroupid &  "," & mipallowtoppings
                                                end if
                                            end if
                                             'Response.Write("ToppingGroupIDs " & ToppingGroupIDs & " MToppingGroupIDs" & MToppingGroupIDs & "<br/>")
                                            if ToppingGroupIDs & "" <> "" then
                                                listtoppinggroupid =  ToppingGroupIDs
                                            else
                                                listtoppinggroupid = MToppingGroupIDs
                                            end if    
                                              
                                          '  Response.Write("miallowtoppings " & miallowtoppings & " mipallowtoppings " & mipallowtoppings)
                                        Set objRds_toppings_Group = Server.CreateObject("ADODB.Recordset")  
                                            SQL = "select ID,toppingsgroup,i_displaysort,isnull(limittopping,0) as limittopping  from Menutoppingsgroups with(nolock)    where IdBusinessDetail = " &   vRestaurantId & " and ID in (" &listtoppinggroupid& ") order by i_displaysort,id "       
                                          
                                            objRds_toppings_Group.Open SQL, objCon
                                            dishtoppingstext = ""
                                        while not objRds_toppings_Group.EOF 
                                                Set objRds_toppings = Server.CreateObject("ADODB.Recordset")           
                                                    SQL = "SELECT id,topping,toppingprice,i_displaysort,s_ContainAllergen,s_MayContainAllergen,s_SuitableFor FROM MenuToppings with(nolock)    where  IdBusinessDetail=" & vRestaurantId                                               
                                                    SQL =SQL & " and toppinggroupid=" & objRds_toppings_Group("ID")    & " order by i_displaysort,id "                                         
                                            
                                                objRds_toppings.Open SQL, objCon
                                                if dishtoppingstext & "" <> "" then
                                                    dishtoppingstext = dishtoppingstext & "<br/>"
                                                end if
                                                dishtoppingstext =dishtoppingstext &  "<div class=""dishproperties__title"">" & objRds_toppings_Group("toppingsgroup") & " </div> "
                                                dim s_ContainAllergen_t,s_MayContainAllergen_t,s_SuitableFor_t 
                                                While NOT objRds_toppings.Eof 
                                                    s_ContainAllergen_t = Replace(objRds_toppings("s_ContainAllergen")& ""," ","") 
                                                    s_MayContainAllergen_t  =Replace( objRds_toppings("s_MayContainAllergen")&""," ","")
                                                    s_SuitableFor_t  = Replace( objRds_toppings("s_SuitableFor")&""," ","")
                                                    dim shtmlicons : shtmlicons = ""

                                                     if s_ContainAllergen_t & "" <> "" then 
                                                          ''FindAllergen
                                                            dim   arr_s_ContainAllergen_t : arr_s_ContainAllergen_t = split(s_ContainAllergen_t,",")
                                                             index_m = 0
                                                            for index_m = 0 to ubound(arr_s_ContainAllergen_t)
                                                                 s_contain = FindAllergen(arr_s_ContainAllergen_t(index_m) )
                                                                if s_contain & "" <> "" then
                                                                        shtmlicons = shtmlicons &  "<img width=""17"" data-toggle=""tooltip""  height=""17"" src=""" & SITE_URL & "Images/allergen/png/" & replace(split(s_contain,"|")(2),"amber","red") & """    title=""Contains "&split(s_contain,"|")(1)&"""  alt=""Contains "&split(s_contain,"|")(1)&""" />"
                                                                end if
                                                            next
                                                    end if

                                                    if s_MayContainAllergen_t & "" <> "" then 
                                                          ''FindAllergen
                                                            dim   arr_s_MayContainAllergen_t : arr_s_MayContainAllergen_t = split(s_MayContainAllergen_t,",")
                                                             index_m = 0
                                                            for index_m = 0 to ubound(arr_s_MayContainAllergen_t)
                                                                 s_contain = FindAllergen(arr_s_MayContainAllergen_t(index_m) )
                                                                if s_contain & "" <> "" then
                                                                        shtmlicons = shtmlicons &  "<img width=""17"" height=""17"" data-toggle=""tooltip""  src=""" & SITE_URL & "Images/allergen/png/" & split(s_contain,"|")(2) & """    title=""May contain "&split(s_contain,"|")(1)&"""  alt=""May contain "&split(s_contain,"|")(1)&""" />"
                                                                end if
                                                            next
                                                    end if

                                                    if s_SuitableFor_t & "" <> "" then 
                                                          ''FindAllergen
                                                            dim   arr_s_SuitableFor_t : arr_s_SuitableFor_t = split(s_SuitableFor_t,",")
                                                             index_m = 0
                                                            for index_m = 0 to ubound(arr_s_SuitableFor_t)
                                                                 s_contain = FindAllergen(arr_s_SuitableFor_t(index_m) )
                                                                if s_contain & "" <> "" then
                                                                        shtmlicons = shtmlicons &  "<img width=""17"" height=""17"" data-toggle=""tooltip""  src=""" & SITE_URL & "Images/allergen/png/" & split(s_contain,"|")(2) & """    title="""&split(s_contain,"|")(1)&"""  alt="""&split(s_contain,"|")(1)&""" />"
                                                                end if
                                                            next
                                                    end if
                                             
                                                    dishtoppingstext = dishtoppingstext &  "<span s_ContainAllergen_t="""  & s_ContainAllergen_t & "|" & s_MayContainAllergen_t & """  s_MayContainAllergen_t="""  & s_MayContainAllergen_t & """  s_SuitableFor_t="""  & s_SuitableFor_t & """  class=""topping d-flex""> " 
                                                        dishtoppingstext = dishtoppingstext &  " <span class=""mr-5""> " 
                                                        dishtoppingstext = dishtoppingstext &  "    <input type=""checkbox"" toppinggroup=""topping_" & objRds_toppings_Group("ID") &""" name=""" & objRds_toppings("topping") & """ value=""" & objRds_toppings("id") & """ data-group=""toppings" & vMenuItemId & "-" & PropertyId & """> " & objRds_toppings("topping") & shtmlicons 
                                                        dishtoppingstext = dishtoppingstext &  " </span> " 
                                                        dishtoppingstext = dishtoppingstext &  " <span  class=""ml-auto""> " 
                                                        dishtoppingstext = dishtoppingstext &  CURRENCYSYMBOL & FormatNumber(objRds_toppings("toppingprice"),2)  
                                                        dishtoppingstext = dishtoppingstext &  " </span> " 
                                                    dishtoppingstext = dishtoppingstext &  "</span>"

								                    objRds_toppings.MoveNext
                                                wend                                                 
                                                    objRds_toppings.close()
                                                set objRds_toppings = nothing
                                                if cint( objRds_toppings_Group("limittopping")) > 0 then
                                                    dishtoppingstext  = dishtoppingstext & "<script>checkboxlimit('topping_" & objRds_toppings_Group("ID") & "'," &  objRds_toppings_Group("limittopping")  &  ");</script>"
                                                end if
                                            objRds_toppings_Group.movenext()
                                        wend 
                                            objRds_toppings_Group.close()
                                            set objRds_toppings_Group = nothing
                                end if
								%> 
                                
                                <% 
                                    
                                    noprice=0
                                    If Not IsNull(MenuPrice) and donotshowprice="n" Then %>
                                    <div class="product-line__price"><b><%=CURRENCYSYMBOL%><%= FormatNumber(MenuPrice, 2) %></b></div> 
                                
                                <%  noprice=1
                                    End If %>
							
                                <%if pricefrom & "" <> "0" then%>
                               
                                 <div class="product-line__price"><b>from <%=CURRENCYSYMBOL%><%= FormatNumber(pricefrom, 2) %></b></div>    
                                <%noprice=1
                                end if%>


                                  
                                        <!--Add to cart-->
                                        <div class="product-line__action-btn">	
                                            <div align="right">
                                            <% if dishpropertiestext & "" <> ""  or dishtoppingstext & "" <> "" then  %>
                                                <button class="btn btn-success" onclick="Showdishproperties('dishproperties<%=vMenuItemId %>-<%=objRds_MenuItem("PropertyId") %>');">
                                                    <span style="top:2px;" class="glyphicon glyphicon-plus-sign"></span>
                                                </button>
                                            <% else %>
                                                <button class="btn btn-success btnadd" onclick="Add(<%=vMenuItemId %>,<%=PropertyId %>,this);">
                                                  <span class="glyphicon glyphicon-plus"></span>
                                                  <span class="fa fa-refresh fa-spin" aria-hidden="true" style=" width: 1em;display:none;"></span>
                                                </button>    
                                            <% end if %>
                                            </div>					
                                        </div>

                                        </div>
                                    </div>
                                        <!--End Add to cart-->

                                       
                                    </div>
                                <!--</div>-->
                                <%if dishpropertiestext<>"" or dishtoppingstext<>"" then%>
					                <div class="dishproperties" id="dishproperties<%=vMenuItemId %>-<%=objRds_MenuItem("PropertyId") %>">
					                    <div class="row dishproperties__inner">

					                    <div  class="col-md-5 col-sm-5 desc pr-0 desc">
					                        <%if dishtoppingstext<>"" then%>
                                                    <div class="dishproperties__heading">    
					                                <b>Toppings</b>
                                                    </div>
					                                <%=dishtoppingstext%>
					                        <%end if%>
					                    </div>

                                        <div  class="col-md-6 col-sm-6 desc">
					                    <%if dishpropertiestext<>"" then%>
                                            <div class="dishproperties__heading" name="dishproperties__heading">
					                            <b>Dish Options</b>
                                            </div>
					                        <%=dishpropertiestext%>
                                            <script type="text/javascript">
                                                $(function(){
                                                    $('.tip').each(function () {
                                                        $(this).tooltip(
                                                        {
                                                            html: true,
                                                            title: "<div class='tooltip-custom'>" + $('#' + $(this).data('tip')).html().trim() + "</div>",
                                                            container: 'body'
                                                        });
                                                    });

                                                });
                                            </script>
					                    <%end if%>
					                    </div>
                                        <div class="col-md-1 col-sm-1 dishproperties__btn is-vertical-center">
                                               <div align="left">
						                       <button class="btn btn-success btnadd" onclick="Add(<%=vMenuItemId %>,<%=PropertyId%>,this);">
                                                    <span class="glyphicon glyphicon-plus"></span>
                                                   <span class="fa fa-refresh fa-spin" aria-hidden="true" style=" width: 1em;display:none;"></span>
						                       </button></div>
                                        </div>
                                        </div>
					                </div>
					
					            <%end if%>

                               
                             <%
                                   objRds_MenuItem.MoveNext 
                            wend
                                 objRds_MenuItem.close()
                                 set objRds_MenuItem =  nothing
                           %>
                            </div>
                            <%
                         'end 
                    objRdsMainCategory.MoveNext
                wend
				    'objRds_MenuItem.Close()
                'set objRds_MenuItem = nothing
                    objRdsMainCategory.close()
                set objRdsMainCategory = nothing
              

                                 %>

		</div>
		<div class="col-md-3half column" id="pricecolumn">
		
		
		<div class="panel panel-default" id="noorders" style="display:none;">
  <div class="panel-heading" >
    <h3 class="panel-title">Ordering available during opening hours only</h3>
  </div></div>
            <div class="panel panel-default" id="closeRest" style="display: none;">
                <div class="panel-heading">
                   <% if  Close_StartDate = Close_EndDate then %>
                        <h3 class="panel-title">Sorry, We are closed today.</h3>
                    <% else
                         
                         %>                 
                    <h3 class="panel-title">Sorry, We are closed  from <%=Close_StartDate %> - <%=Close_EndDate %></h3>
                    <%end if %>
                </div>
            </div>
		
	

	<div id="rightaffix" <%if STICK_MENU="Yes" then%>data-spy="affix" data-offset-top="300" data-offset-bottom="200"<%end if%>>
<div class="panel panel-primary"  id="basket"  >
  <div class="panel-heading">
    <h3 class="panel-title"><span class="glyphicon glyphicon glyphicon-shopping-cart"></span> Your Order</h3>
  </div>
  <div class="panel-body" style="padding:15px 8px 15px 8px;" id="footerbasket">
    <form id="CheckOutForm" action="<%=CheckoutURL %>" method="post">                
    <input type="hidden" name="deliveryDistance" id="distance" value="" />
    <input type="hidden" name="deliveryType" value="" />
	<input type="hidden" name="deliverydelay" id="deliverydelay" value="<%=sAverageDeliveryTime%>" />
	<input type="hidden" name="collectiondelay" id="collectiondelay" value="<%=sAverageCollectionTime%>" />
    <input type="hidden" name="deliveryPC" value="<%=request.querystring("postcode")%>" />
    <input type ="hidden" name="h_p_hour" value="" />
    <input type="hidden" name="deliveryTime" value="" />
	<input type="hidden" name="asaporder" value="" />
	<input type="hidden" name="special" value="" />
    <input type="hidden" name="deliveryLat" value="" />
    <input type="hidden" name="deliveryLng" value="" />
    <input type="hidden" readonly name="hidLat" id="hidLat" />
    <input type="hidden" readonly name="hidLng" id="hidLng" />
    <input type="hidden" name="deliveryAddress" value="" />
    <input type="hidden" name="deliveryPostCode" value="" />
    <input type="hidden" id="isChangeExistingAddress"  name="isChangeExistingAddress" value="N" />
</form>
<div id="shoppingcart"></div>    
  </div>
    <div id="divVoucherCode" style="display:none;padding:0px 8px 15px 8px;">
     <button type="button" class="btn btn-xs btn-block" id="vouchercodeshow" style="background-color:#eeeeee;color:#7d7c7c  ;"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> Add Voucher Code</button>
	<button type="button" class="btn  btn-xs btn-block" id="vouchercodehide"  style="display:none;background-color: #eeeeee;color:#7d7c7c  ;"><span class="glyphicon glyphicon-minus" aria-hidden="true"></span> Close</button>
	
    <div class="panel panel-default" style="display:none;" id="divVoucherCode1" >
 
        <div class="panel-body">           
                        
						
						
						<div class="row">
  <div class="col-xs-7">
  
    <label class="sr-only" for="vouchercode">Enter Code</label>
    <input type="text" class="form-control noSubmit" id="vouchercode" name="vouchercode" placeholder="Enter code">
  </div> <div class="col-xs-3">
  
   
  
   <button  class="btn btn-default" onclick="VoucherCode();">Submit</button>
 </div>
 
 <div class="col-xs-1">&nbsp;</div>
 
              
                    </div>
    </div>
    <div id="divVoucherCodeAlert" style="margin: 1px auto;text-align: center;color:red;"> </div>
 </div>
        </div>
      <div id="divFancyMap" style="width:100%; height:80%; display:none; position: absolute;">
                <fieldset class="gllpLatlonPicker" id="gllpLatlonPicker1">
                    <p style="display:block;text-align:center">Type a location name or mark it on the map:</p>
           
                    <input type="text" style="display:block;margin:3px auto;width:80%;max-width:400px;" class="gllpSearchField pac-input" id="txtFancySearch" />
                    <input type="button" style="display:block;margin:10px auto;background-color:#FEC752;border-color:#FEC752;" class="btn btn-default gllpSearchButton" value="Search" />            
            
                    <div class="gllpMap">Google Maps</div>
                    <div style="width:100%;text-align:center;">
                    <span style="display:block;" id="spnLocationAddress"></span>
                    <input type="button" style="margin:10px auto;background-color:#FEC752;border-color:#FEC752;" class="btn btn-default" value="Mark my coordinates" onclick="CloseMap(true);" />
                    <input type="button" style="margin:10px auto;background-color:#fedf9a;border-color:#fedf9a;" class="btn btn-default" value="Cancel" onclick="CloseMap(false);" />
                        </div>
                    <input type="hidden" readonly class="gllpLatitude" value="20" />
                    <input type="hidden" readonly  class="gllpLongitude" value="20" />
                    <input type="hidden" readonly  class="gllpZoom" value="3" />
            
                </fieldset>


             </div>   
    <div class="panel panel-default" id="beforeorder" >
          <div class="panel-heading" style="color: #fff;background-color: #94b604;border-color: #94b604;">
            <h3 class="panel-title"><span class="glyphicon glyphicon-time"></span> Order Type</h3>
          </div>
          <div class="panel-body" style="padding:10px;">
						        <div class="delblock" <%if disabledelivery="Yes" then%>style="visibility:hidden;"<%end if%>>						
						         <div style="float:left;padding:5px 3px 0 3px;"> <i class="fa fa-truck fa-2x"></i></div>
						 
						         <div style="line-height: 14px;">
						
						
                                  <input type="radio" name="orderTypePicker" value="d" <%if disabledelivery="Yes" then%>disabled<%end if%>  <%if disablecollection="Yes" and disabledelivery<>"Yes" then%> checked<%end if%>/> Delivery<br>
						  
						          <span style="font-size:0.8em;">Approx: <span style="color: red"><%= sAverageDeliveryTime%>min</span></span>
                           </div>
						
						        </div><div class="delblock" <%if disablecollection="Yes" then%>style="visibility:hidden;"<%end if%>>
						
						        <div style="float:left;padding:5px 3px 0 3px;"> <i class="fa fa-user fa-2x"></i></div>
						
						
						         <div style="line-height: 14px;"><input type="radio" name="orderTypePicker" value="c"  <%if disablecollection="Yes" then%>disabled<%end if%> <%if disabledelivery="Yes" and disablecollection<>"Yes" then%> checked<%end if%>/> Collection<br>

						          <span style="font-size:0.8em;"> Approx:&nbsp;<span style="color: red"><%= sAverageCollectionTime%>min</span>
                           </div>
						        </div>
						
                       
					         <div class="hidepanel" id="nowlater"> 
					          <div align="center">  <input type="radio" name="ordertimeoverride" id="ordertimeoverride" value="n" checked> Now /   <input type="radio" id="ordertimeoverride" name="ordertimeoverride" value="l" <%if sorderdisablelater=1 then%>disabled<%end if%>> Later </div>

                                  </div>
					            <div id="DeliveryTimeNowD" class="hidepanel alert alert-warning" style="text-align:center;display:none;padding:7px;" >
                                </div>
                                <div id="DeliveryTimeNowC" class="hidepanel alert alert-warning" style="text-align:center;display:none;padding:7px;" >
                                </div>
                                 <div id="DeliveryTime" class="form-group hidepanel" style="text-align:center;" >
                                    <label for="control-label">
                                        <%if disabledelivery="Yes" then%>Collection<%else%>Delivery<%end if%> Time *</label>
									        <div class="clearfix"></div>
									        <div class="input-group" style="width:130px;float:left;">
	                                        <%if ordertodayonly=1 then%>
                                                <div id="OrderDate"  data-date="<%= FormatEngDate(DateAdd("h",houroffset,now)) %>" data-date-weekStart="1" data-date-format="dd/mm/yyyy">
                                                <div class="input-group">
                                             <input size="11" type="text"  value="<%= FormatEngDate(DateAdd("h",houroffset,now)) %>" id="OrderDateBox" class="  form-control" style="padding-left:3px;" disabled="disabled" onload="javascript:document.getElementById('OrderDateBox').disabled = true;" />
  
                                               </div>
                                            <%else%>
                                              <div id="OrderDate"  data-date="<%= FormatEngDate(DateAdd("h",houroffset,now)) %>" data-date-weekStart="1" data-date-format="dd/mm/yyyy">
                                                <div class="input-group">
                                                 <input size="11" type="text"  value="<%= FormatEngDate(DateAdd("h",houroffset,now)) %>" id="OrderDateBox" class="  form-control" style="padding-left:3px;"/>
                                                   <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                                   </div>
                                           <%end if%>
                                                </div>
                                              </div>
									
                                    
                          	        <div class="visible-md"><br><br></div>       
                                        <select name="p_hour" style="float:left;vertical-align:middle;" class="form-control">                                          
                                        </select>
                                                             
                                    </div>
						
						        <div id="DeliveryDistance" class="control-group row-fluid hidepanel">
                                     <div id="PreFillDistance" class="alert alert-success" style="text-align:center;display:none;padding:7px;font-size: 11px;" >
                                         Last Delivery Address: <%= Request.Cookies("validate_pc") %> If you use the same address please continue.
                                         Otherwise Change Address.
                                </div>
                                    <form id="updateFullPostcode" class="">													
                                    <p class="delPostcodeLabel text-centered">
                                        <strong>Delivery Postcode:</strong>
                                    </p>
                                    <p style="margin-left: 33px;" class="text-centered">
							
							    <div class="input-group" id="input-group-pc">    
                                <%  dim UserAddress
                                        UserAddress = ""
                                    Dim PostCodeDiff : PostCodeDiff =  false
                                    %>
                                <input type="text" class="form-control clearable" value="" name="validate_pc" id="validate_pc" >
                                 
                                <input type="hidden" readonly name="hidFormattedAdd" id="hidFormattedAdd" />
                                <input type="hidden" readonly name="hidPostCode" id="hidPostCode" />                                          
	                            <span class="input-group-btn"><button class="btn btn-default btngreen" type="button" onclick="CheckDistance();" data-placement="top" title="Remember to Check your address" id="updateFullPostcodeSubmit" >Check</button></span>
                                <script>
                                <% if UserAddress & "" <> "" Then %>
                                    $(document).ready(function(){
                                     var geocoder = new google.maps.Geocoder();
                                        geocoder.geocode({"address":'<%=Replace(UserAddress ,"'","")%>' }, function(results, status) {
                                            if (status == google.maps.GeocoderStatus.OK && results[0]) {
                                                //do nothing
                                            }
                                            else { 
                                               if('<%= Request.Cookies("Postcode") %>' != '' )
                                                    $("#validate_pc").val('<%= Request.Cookies("Postcode") %>' );
                                                } 
                                    });
                                    });
                            <% end if
                                    if  FormAddress & ""  = "" and FormPostCode & "" = "" and  Request.Cookies("Postcode") & "" <> "" and Request.Cookies("validate_pc") & "" <> "" and instr(Request.Cookies("validate_pc"),Request.Cookies("Postcode")) = 0 then
                                            PostCodeDiff  = true
                                    %>
                                        $("#validate_pc").val('<%= Request.Cookies("Postcode") %>' );
                                    <%    
                                    end if
                                     %>
                                   
                                // CLEARABLE INPUT
                        function tog(v){return v?'addClass':'removeClass';} 

                        $(document).on('input', '.clearable', function(){
                            $(this)[tog(this.value)]('x');
                        }).on('mousemove', '.x', function( e ){
                            $(this)[tog(this.offsetWidth-18 < e.clientX-this.getBoundingClientRect().left)]('onX');
                        }).on('touchstart click', '.onX', function( ev ){
                            ev.preventDefault();
                            $(this).removeClass('x onX').val('').change();
                            SearchTerms('txtSearch');
                        });

                                    $(".clearable").trigger("input");
                            </script>
                                </div>
                                <div class="pick-a-location">
                 <a id="aUseCurrentLoc" style="display:none;padding-top:5px;" class="text-centered"  href="#"><img src="<%=SITE_URL %>images/current-position.png"  style="height: 15px;">Use current location</a>
                 <% if individualpostcodeschecking = 0 then %>    <a id="fancyBoxMap" style="display:block;padding-top:5px;" class="fancybox text-centered"  data-popup="#divFancyMap" href="#divFancyMap"><img src="<%=SITE_URL %>images/picklocation.png"  style="height: 15px;"> Pick a Location </a> <% End If %>
          
            </div>
		                        <div id="showdistance" align="center" style="clear:both;"></div>					
			                    <div class="delivery_info alert alert-danger" style="display:visible;" id="delivery-info">    
                                        <span id="df">Delivery Charge: <span id="delivery_fee"><%=CURRENCYSYMBOL%><%=DeliveryCostUpTo %> up to <%=DeliveryUptoMile %> miles  and  <%=CURRENCYSYMBOL %><%=sDeliveryFee %> per <%=DistanceMile %>&nbsp;<%=mileskm %> thereafter</span></span><br />
								        Max. delivery distance: <%=sDeliveryMaxDistance%> <%=mileskm%><br>
								        <%if sDeliveryFreeDistance>0 then%>Free delivery up to: <%=sDeliveryFreeDistance %> <%=mileskm%><br><%end if%>
								        <% if sDeliveryChargeOverrideByOrderValue <> 1000000000 Then %>Free delivery for orders over <%=CURRENCYSYMBOL%><%=sDeliveryChargeOverrideByOrderValue%><br> <%end if %> 
				                        Minimum Order: <%=CURRENCYSYMBOL%><%= sDeliveryMinAmount %>		
                                    </div>
                                </form>
                                   <div class="alert alert-danger" id="missingPostcodeAlert" style="display:none;margin: 2px 8px 2px 2px;"><span style="color:#49cb29;font-weight:bold;">Check</span> delivery is available, then click <span style="color:#49cb29;font-weight:bold;">Checkout</span> to continue</strong><br></div>
                                   <div class="alert alert-danger" style="margin: 2px 8px 2px 2px;" id="missingPostcodeAlert2">We don't deliver to that postcode.</div>
                                   <div class="alert alert-danger" id="missingPostcodeAlert3" style="margin: 2px 8px 2px 2px;">Postcode is invalid.</div>
                                </div>
						        <div class="clear-both"></div>
                      <div id="CollectionAddress" class="hidepanel alert alert-success" style="clear:both;text-align:center; padding: 7px; font-size: 11px; display: none;margin: 8px 8px 2px 2px;" data-original-title="" title=""><span style="font-weight: bold;"><span style="color:red;">Collect from:</span><br/> <%=AddressRestaurant %></span></div>
                                                                              
                     
          </div>
                                
        </div>
         <p class="text-centered" id="btnPlaceOrder" style="display:none;">
        <button type="button" onclick="CheckOrder('confirm');" class="btn btn-success" style="width: 160px; padding: 8px">
        Checkout</button><br>
		<br>
    </p>
</div>
       <script type="text/javascript">
       var htmlpostcode  =  $("#delivery-info").html();
   </script>
<div class="panel panel-danger" >
  <div class="panel-heading"  >
          <h3 class="panel-title">Opening Hours</h3>
  </div>
        <div class="panel-body">           
                        <table border="0" width="100%" id="openninghours">
                            <% 
                         
                        objRds.Open "SELECT oi.minacceptorderbeforeclose,  convert(varchar, Hour_From, 8)  as Hour_From, convert(varchar, Hour_To, 8)  as Hour_To ,DayOfWeek,delivery,collection  " & _
                        " FROM openingtimes oi    " & _
                        " where oi.IdBusinessDetail = " & vRestaurantId & _
                        " order by DayOfWeek, Hour_From", objCon
                        Dim jsDate, tempminacceptorderbeforeclose
                        jsDate = ""
						jscnt=0
						currentdayofweek=""
                        
                        
                        Do While NOT objRds.Eof 
             jscnt=jscnt+1
                            if ISNULL(objRds("minacceptorderbeforeclose")) OR objRds("minacceptorderbeforeclose") & "" = "" Then
                               tempminacceptorderbeforeclose = -1
                         Else
                                tempminacceptorderbeforeclose = objRds("minacceptorderbeforeclose")
                        End If
                             Dim o1_Hour_From : o1_Hour_From =   FormatTimeC(objRds("Hour_From"),5) 
                             Dim o1_Hour_To : o1_Hour_To =  FormatTimeC(objRds("Hour_To"),5) 
                            if jsDate <> "" Then jsDate = jsDate & ","
                            jsDate = jsDate & jscnt & ": { min:Date.parse('01/01/2011 " & o1_Hour_From & "'),  max: Date.parse('01/01/2011 " & o1_Hour_To & "'), d:'" & objRds("DayOfWeek") & "', delivery:'" & objRds("delivery") & "', collection:'" & objRds("collection") & "',minacceptorderbeforeclose:" & tempminacceptorderbeforeclose &"}"
                                dim isavailable : isavailable ="y"
                                if objRds("collection")="n" and objRds("delivery")="n" then
                                            isavailable = "n"
                                end if
                          %>
                            <tr name="nameopentime" <% if objRds("DayOfWeek") = Weekday(DateAdd("h",houroffset,now), vbMonday)  then %> style="font-weight:bold;" <% end if %> nameopentime="<%=objRds("DayOfWeek") %>" available="<%=isavailable %>">
                                <td style="width: 30px">
								<%if currentdayofweek<>objRds("DayOfWeek") then%>
                                    <%= WeekdayName(objRds("DayOfWeek"), false, vbMonday) %>
									<%end if%>
                                </td>
                                <td>
                                  <div align="right"> <%if objRds("collection")="n" then%><img src="<%=SITE_URL %>Images/no-collection.gif" width="18" data-toggle="tooltip" data-placement="left" title="Collection is not available during this time slot"></i> <%end if%> <%if objRds("delivery")="n" then%><img src="<%=SITE_URL %>Images/no-delivery.gif" width="18" data-toggle="tooltip" data-placement="left" title="Delivery is not available during this time slot"></i> <%end if%> <%= o1_Hour_From %>
                                    - <%= o1_Hour_To  %></div>  <%' objRds("minacceptorderbeforeclose") & "|" & ISNULL(objRds("minacceptorderbeforeclose")) & "|" & (objRds("minacceptorderbeforeclose") & "" = "") & "|" & tempminacceptorderbeforeclose %>
                                </td>
                               <script type="text/javascript">
                                   $(function () {
                                       $("[data-toggle=tooltip]").tooltip();
                                   });
</script>
                               
                            </tr>
                            <%currentdayofweek=objRds("DayOfWeek")
                            objRds.MoveNext    
                        Loop
                    
                        objRds.Close
                        set objRds =  nothing
                        objCon.Close
						
                            %>
                        </table>
                    </div>
                    
        
    </div>
	<%=menupagetext%>
	
</div>
	</div>
	</div>
	
</div>
    </div>
 

<script type="text/javascript">   
    $(function() {
        var  loadedElements = 0;

        $('.lazy').lazy({
            beforeLoad: function(element){
                console.log('image  is about to be loaded');
            },
            afterLoad: function(element) {
                loadedElements++;
 
                console.log('image  was '  + loadedElements+' loaded successfully');
            },
            onError: function(element) {
                loadedElements++;             
                console.log('image could not be ' +loadedElements+' loaded');
            },
            onFinishedAll: function() {
                console.log('finished loading  elements ' + loadedElements);
                console.log('lazy instance is about to be destroyed' + loadedElements)
            }
        });
    });
  

        // process for product line no border 
    $(".no-border").each(function(){
        $("[name='" +$(this).attr("name")+ "']").addClass("no-border");
    });
    $(".no-border").filter("[parent='0']").each(function(){
        var obj =   $(this).find(".product-line__content-right").clone();
        
        var newline = '<div class="product-line  no-border" name="'+ $(this).attr("name") +'" fishversion="true">';
                
                $(newline +  $(obj).wrapAll('<div class="abc">').parent().html() + "</div>").insertAfter(this);
                $(this).find(".product-line__content-right").remove();
                $(this).find(".product-line__content-left").removeClass("product-line__content-left").addClass("product-line__content");
    });
    $("[fishversion=true]").find(".product-line__content-right").css("border-top","none");
    function CategorySelection(ID)
    {
        $("#txtSearch").val("");
        $(".product-line-heading").show();
        $("[data-type=group-cate]").each(function(){
            var categroup  = $(this);
            categroup.find(".product-line").each(function(){
                $(this).show();
            });
        });
        $("[data-type='group-cate']").each(function(){
            $(this).hide();
            $(this).prev().find(".product-line-heading__icon").addClass("arrow-icon-down").removeClass("arrow-icon-up");
        });
        $("#" + ID).prev().find(".product-line-heading__icon").addClass("arrow-icon-up").removeClass("arrow-icon-down");        
        $("#" + ID).slideDown("slow");

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
    var ExpectedtimeD ="";
    var ExpectedtimeC ="";
    var currenttime  =  new Date();

    currenttime = currenttime.getHours() + ":" + currenttime.getMinutes();
    //currenttime = Date.parse('01/01/2011 ' + currenttime) + <%=(houroffset * 60) - Application("ServerGMTOffset") - DSTMinute%>  * 60000;    
    currenttime = Date.parse('01/01/2011 ' + currenttime) ; 
    var CurrentDate = 1;
    var jsDate = {
        <%=jsDate %>
        };
    var myDays= ["Monday","Tuesday","Wednesday",
        "Thursday","Friday","Saturday","Sunday"]

    function ReloadShop() {
		
        $("#shoppingcart").load("<%=SITE_URL %>ShoppingCart.asp?id_r=<%= vRestaurantId %>"); 
	                
    }

    function Add(mi, mip,obj) {
		
		
        //add toppings chosen to querystring
        toppingschosen = $("input[data-group='toppings" + mi + "-" + mip + "']:checked").map(function() {return this.value;}).get().join(',');
        //alert(toppingschosen);
        optionsnotchosen="";
        //add dishproperties chosen to querystring format "id|value,id|value...."
        var dishproperties = [];
        $("select[data-group='dishproperties" + mi + "-" + mip + "']").each(function(){
            if ($(this).attr('data-required')=='y' && $(this).val()==0 ) {
                optionsnotchosen="y";
                alert($(this).attr('data-caption'));
		
            }
            dishproperties.push( $(this).attr('id')  + "|" + $(this).val()  );
		 
        });
        dishproperties.join(",");
        //alert(dishproperties);
		
        if (optionsnotchosen=='') {
            $(obj).find("span:eq(0)").hide();
            $(obj).find("span:eq(1)").show();
           // alert("<%=SITE_URL%>ShoppingCart.asp?ot=<%=OrderType%>&id_r=<%= vRestaurantId %>&op=add&mi=" + mi + "&mip=" + mip + "&toppingids=" + toppingschosen + "&dishproperties=" + dishproperties);
            $("#shoppingcart").load("<%=SITE_URL%>ShoppingCart.asp?ot=<%=OrderType%>&id_r=<%= vRestaurantId %>&op=add&mi=" + mi + "&mip=" + mip + "&toppingids=" + toppingschosen + "&dishproperties=" + dishproperties,function(){
               
                $(obj).find("span:eq(1)").hide();
                $(obj).find("span:eq(0)").show();
            });
        }
 
    }
		
	
    function ReOrder(orderID)
    {
        $("#shoppingcart").load("<%=SITE_URL%>ShoppingCart.asp?id_r=<%= vRestaurantId %>&ot=online&op=reorder&RID=" + orderID);
    }
    function AdditemTocart(mi,mip,toppingids,dishproperties,qta)
    {
        $("#shoppingcart").load("<%=SITE_URL%>ShoppingCart.asp?id_r=<%= vRestaurantId %>&ot=online&op=add&mi=" +mi+"&mip="+mip+"&toppingids="+toppingids+"&dishproperties="+dishproperties+"&qta=" + qta);
    }
    function Delc(itemId) {	
        $("#shoppingcart").load("<%=SITE_URL%>ShoppingCart.asp?id_r=<%= vRestaurantId %>&op=del&id=" + itemId);
    }
    function Del(itemId,qty)
    {
        $("#shoppingcart").load("<%=SITE_URL%>ShoppingCart.asp?id_r=<%= vRestaurantId %>&op=del&qty="+qty+"&id=" + itemId + "&top=" + jQuery('#divShoppingCartSroll').scrollTop() );
    }
		
    function Showdishproperties(itemtoshow) {
	
        $("#" + itemtoshow).slideToggle();
           
    }
    function ShowdishpropertiesV2( itemtoshow) {
        if($("#" + itemtoshow).is(":visible") ){
            $("#img" + itemtoshow).addClass("arrow-icon-down").removeClass("arrow-icon-up");
            $("#" + itemtoshow).slideUp("slow");
        }
        else{
            $("#img" + itemtoshow).addClass("arrow-icon-up").removeClass("arrow-icon-down");
            $("#" + itemtoshow).slideDown("slow");
        }
    }
		
   

    function VoucherCode() {
	
	
        $("#shoppingcart").load("<%=SITE_URL%>ShoppingCart.asp?id_r=<%= vRestaurantId %>&op=vouchercode&vouchercode=" + $('#vouchercode').val());
        return false;

    }


        
    function GetDistance(postalCode) {

        var deferred = $.Deferred();

        var service = new google.maps.DistanceMatrixService();
        service.getDistanceMatrix({
            origins: ['<%=sPostalCode %>'],
            destinations: [postalCode],
            travelMode: google.maps.TravelMode.DRIVING,
            unitSystem: google.maps.UnitSystem.METRIC,
            avoidHighways: false,
            avoidTolls: false
        }, function callback(response, status) {
            deferred.resolve(response) ;
        });
        
        return deferred.promise();
    }
    function GetDistanceGMLatLng(oLat, oLng, dLat, dLng) {

        var deferred = $.Deferred();

        var service = new google.maps.DistanceMatrixService();
        service.getDistanceMatrix({
            origins: [new google.maps.LatLng(oLat, oLng)],
            destinations: [new google.maps.LatLng(dLat, dLng) ],
            travelMode: google.maps.TravelMode.DRIVING,
            unitSystem: google.maps.UnitSystem.METRIC,
            avoidHighways: false,
            avoidTolls: false
        }, function callback(response, status) {
            if(status == google.maps.DistanceMatrixStatus.OK)
                if(response.rows[0].elements[0].status == "OK")
                    CheckDistanceLatLng( parseFloat(response.rows[0].elements[0].distance.value/1000).toFixed(2) );
                else
                    CheckDistanceLatLng(100000);
                
        });        
           
    }

   
    function CheckDistance() {
           
       
        <%if individualpostcodeschecking=0 then%>
         CheckDistanceLatLng();
        return false;
        
    <%else%>
         var tempAdd = $("#validate_pc").val();
          var form = $("#CheckOutForm");       
        if(!tempAdd || tempAdd == '')
        {
            $('#DeliveryDistance div.delivery_info').hide();   
            $("#missingPostcodeAlert").show();
            $("#missingPostcodeAlert").html('<strong>Postal Code Required!</strong>');
            $('input[name=distance]', form).val('');
            $('.delivery_info').addClass('alert-danger');
            $('.delivery_info').removeClass('alert-success'); 
            return false;
        }

        if (($("#hidLat").val() == "" || $("#hidLng").val() == "")) {

            if ($("#validate_pc").val().indexOf(",") > -1)
                var firstResult = $("#validate_pc").val().replace(/ /g, "+");
            else
                var firstResult = $("#validate_pc").val().replace(/ /g, "");

            var geocoder = new google.maps.Geocoder();
            geocoder.geocode({ "address": firstResult }, function (results, status) {
                if (status == google.maps.GeocoderStatus.OK && results[0]) {
                    // Start from new update for task #157  
                    var indexResponse = 0;
                                       
                    if (results.length > 0) {
                        var formatted_address = "";
                        for (var i = 0; i < results.length; i++) {
                            if (formatted_address.length < results[i].formatted_address.length)
                                indexResponse = i;
                        }
                    }


                    var tempLat = results[indexResponse].geometry.location.lat(),
                        tempLng = results[indexResponse].geometry.location.lng();
                    var deliverZoneResult = CheckPointInDeliveryZone(tempLat, tempLng);

                    if (deliverZoneResult == 0) {
                        $('.delivery_info').hide();
                        $("#missingPostcodeAlert").show();
                        $("#missingPostcodeAlert").html('This Takeaway Only Offers <strong>Collection</strong> To Your Postcode');
                        $('input[name=distance]', form).val('');
                        $('input[name=deliveryDistance]', form).val('');
                        $('.delivery_info').addClass('alert-danger');
                        $('.delivery_info').removeClass('alert-success');
                    }
                    else { CheckDistanceInvidualPostCode(deliverZoneResult); }

                }
                else {
                    $('#DeliveryDistance div.delivery_info').hide();


                    $("#updateFullPostcode").show();
                    if ($("#PreFillDistance").length > 0) {
                        OnChangePrefillAddress();
                    }
                    else {
                        $("#missingPostcodeAlert").show();
                        $("#missingPostcodeAlert").html('<strong>We can not find valid location with your input. Please input valid address/searches or pick your location on a map !</strong>');
                    }
                    $('input[name=distance]', form).val('');
                    $('.delivery_info').addClass('alert-danger');
                    $('.delivery_info').removeClass('alert-success');
                    return false;
                }
            });
            return;
        }
        else {
            var deliverZoneResult = CheckPointInDeliveryZone($("#hidLat").val(), $("#hidLng").val());                    
                      
                        if (deliverZoneResult == 0) {
                            $('.delivery_info').hide();
                            $("#missingPostcodeAlert").show();
                            $("#missingPostcodeAlert").html('This Takeaway Only Offers <strong>Collection</strong> To Your Postcode');
                            $('input[name=distance]', form).val('');
                            $('input[name=deliveryDistance]', form).val('');
                            $('.delivery_info').addClass('alert-danger');
                            $('.delivery_info').removeClass('alert-success');
                        }
            else { CheckDistanceInvidualPostCode(deliverZoneResult); }
        }
        
						
    <%end if%>
                                       
    }

    
    function CheckDistanceInvidualPostCode(_inDeliveryZone) {
       
           var zipcode = $("#validate_pc").val();
       var form = $("#CheckOutForm");          
    if(!zipcode || zipcode == '')
    {
        $('#DeliveryDistance div.delivery_info').hide();   
        $("#missingPostcodeAlert").show();
        $("#missingPostcodeAlert").html('<strong>Postal Code Required!</strong>');
        $('input[name=distance]', form).val('');
        $('.delivery_info').addClass('alert-danger');
        $('.delivery_info').removeClass('alert-success'); 
        return false;
    }
    var miles;
    var distance;
    var form = $("#CheckOutForm");
    zipcode =  zipcode.replace(/\+/gi, " ");
    $('.delivery_info').hide();
    if(zipcode.length >= 6 && zipcode.length <= 8){

        individualpostcodes = "<%=individualpostcodes%>";
        individualpostcodes = individualpostcodes.toLowerCase();
        individualpostcodes = individualpostcodes.replace(/ /gi, "");


        zipcode = zipcode.replace(/ /gi, "");
        var chars4ofzipcode = "|" + zipcode.substr(0, 4) + "|";
        var chars5ofzipcode = "|" + zipcode.substr(0, 5) + "|";

        var isMatchZipcode = false; 
        if(individualpostcodes.indexOf(chars4ofzipcode) >= 0 || individualpostcodes.indexOf(chars5ofzipcode) >= 0 )
            isMatchZipcode = true;
       
       
        if( ( isMatchZipcode && _inDeliveryZone == -1) || _inDeliveryZone == 1){
			
			
            $("#missingPostcodeAlert").hide();
            $("#missingPostcodeAlert3").hide();
            $("#missingPostcodeAlert2").hide();	
	
	
		    
            $('.delivery_info').show();
					
            $('#delivery_fee').text('<%= FormatNumber(sDeliveryFee, 2) %>');
            var zipcode = $("#validate_pc").val();


            $.when(GetDistance(zipcode)).then(function(data) {
                distance = -1;
                if (data.rows && data.rows.length > 0) {
                    if (data.rows[0].elements && data.rows[0].elements.length > 0) {
                        if (data.rows[0].elements[0].status == 'OK') {
                            distance = data.rows[0].elements[0].distance.value;
                        }
                    }
                }
                <%if mileskm="miles" then%>
                                    var miles = distance * .6214;
                <%else%>
                var miles = distance;
                <%end if%>
                miles=(Math.round(miles / 10) / 100);
                $('input[name=deliveryDistance]', form).val(miles);
                $('#showdistance').html(miles + ' <%=mileskm%>');
                $.ajax({url: "<%=SITE_URL %>ajaxdeliverydistance.asp?d=" + miles , success: function(result){
                    ReloadShop();
                }});
                $('input[name=deliveryPC]', form).val(zipcode);
                $('input[name=deliveryPostCode]', form).val(zipcode);
                   
            }

            )        
                      
            $('div.beforeorder').css('border-color', '#E9EAEB');
            $('.delivery_info').removeClass('alert-danger');
            $("#delivery-info").html("Great! Continue ordering");
            $('.delivery_info').addClass('alert-success');
        } else {
            $('input[name=deliveryDistance]').val("");
            $("#missingPostcodeAlert").hide();
            $("#missingPostcodeAlert3").hide();
            $("#missingPostcodeAlert2").show();	
        }
    } else {
        $('input[name=deliveryDistance]').val("");
        $("#missingPostcodeAlert").hide();
        $("#missingPostcodeAlert2").hide();
        $("#missingPostcodeAlert3").show();	
    }
			
    }
   
   
    var xhr
        var Mon_Delivery='<%=Mon_Delivery%>',Tue_Delivery='<%=Tue_Delivery%>',Wed_Delivery='<%=Wed_Delivery%>',Thu_Delivery='<%=Thu_Delivery%>',Fri_Delivery='<%=Fri_Delivery%>',Sat_Delivery='<%=Sat_Delivery%>',Sun_Delivery='<%=Sun_Delivery%>';
        var Mon_Collection='<%=Mon_Collection%>',Tue_Collection='<%=Tue_Collection%>',Wed_Collection='<%=Wed_Collection%>',Thu_Collection='<%=Thu_Collection%>',Fri_Collection='<%=Fri_Collection%>',Sat_Collection='<%=Sat_Collection%>',Sun_Collection='<%=Sun_Collection%>';
        function GetDel_ColAvarage(dayofweek,mode)
        {
            var result ="";
            dayofweek =  dayofweek ;
            switch(dayofweek)
            {
                case 0 : 
                    if(mode=="d"){
                        if(Sun_Delivery!="") result = Sun_Delivery;
                    }
                    else if(mode=="c")
                    {
                        if(Sun_Collection!="") result = Sun_Collection;
                    }                        
                    break;
                case 1 : 
                    if(mode=="d"){
                        if(Mon_Delivery!="") result = Mon_Delivery;
                    }
                    else if(mode=="c")
                    {
                        if(Mon_Collection!="") result = Mon_Collection;
                    }                        
                    break;
                case 2 : 
                    if(mode=="d"){
                        if(Tue_Delivery!="") result = Tue_Delivery;
                    }
                    else if(mode=="c")
                    {
                        if(Tue_Collection!="") result = Tue_Collection;
                    }                        
                    break;
                case 3 : 
                    if(mode=="d"){
                        if(Wed_Delivery!="") result = Wed_Delivery;
                    }
                    else if(mode=="c")
                    {
                        if(Wed_Collection!="") result = Wed_Collection;
                    }                        
                    break;
                case 4 : 
                    if(mode=="d"){
                        if(Thu_Delivery!="") result = Thu_Delivery;
                    }
                    else if(mode=="c")
                    {
                        if(Thu_Collection!="") result = Thu_Collection;
                    }                        
                    break;
                case 5 : 
                    if(mode=="d"){
                        if(Fri_Delivery!="") result = Fri_Delivery;
                    }
                    else if(mode=="c")
                    {
                        if(Fri_Collection!="") result = Fri_Collection;
                    }                        
                    break;
                case 6 : 
                    if(mode=="d"){
                        if(Sat_Delivery!="") result = Sat_Delivery;
                    }
                    else if(mode=="c")
                    {
                        if(Sat_Collection!="") result = Sat_Collection;
                    }                        
                    break;
               
            }
            return result;
        }
    function LoadTimes() {
        var deliverymethod = $("[name=orderTypePicker]:checked").val();
        if(typeof deliverymethod == "undefined")
            return false;
       
                $('#deliverydelay').val(<%=sAverageDeliveryTime%>);
                $('#collectiondelay').val(<%=sAverageCollectionTime%>);
              var deliverytype = $("[name=ordertimeoverride]:checked").val();
              var deliveryDate="";
              var deliverytime =0;
              var deliverytimeDynamid = ""
               if(deliverytype == "l"){
                   deliveryDate = $("#OrderDateBox").val();
                
                   var datebox  =  new Date(deliveryDate.split("/")[1] + "/" +   deliveryDate.split("/")[0] +"/" + deliveryDate.split("/")[2]);
                   deliverytimeDynamid = GetDel_ColAvarage(datebox.getDay(),deliverymethod);
               }
                  
               if(deliverymethod=="d"){
                   deliverytime  =  $('#deliverydelay').val();
                   if(deliverytimeDynamid!="")
                       deliverytime =    deliverytimeDynamid;  
                   $('#deliverydelay').val(deliverytime);
               }
                   
               else if(deliverymethod=="c")   
               {
                   deliverytime=$('#collectiondelay').val();
                   if(deliverytimeDynamid!="")
                       deliverytime =    deliverytimeDynamid;  
                   $('#collectiondelay').val(deliverytime);
               }
                     
              if(xhr!=null)
                  xhr.abort();
              xhr = $.ajax({url: "<%=SITE_URL %>loadtime.asp?rid=<%=vRestaurantId%>&date=" + deliveryDate + "&time=" + deliverytime + "&t=" + deliverymethod + "&asap=" + deliverytype , success: function(result){
                 $("[name=p_hour]").find("option").remove();
                var s = $("[name=p_hour]");
                if($.trim(result) !="")
                    {   
                        var listoftime = result;
                         var arraylistoftime = listoftime.split("[*]");
                           $(arraylistoftime).each(function(){
                                    if( $.trim(this)!="")
                                        s.append($('<option value="' +this+'"/>').html(this));
                         });
                         //if(deliverytype=="l"){
                         //       if( getCookie("p_hour") != "" &&  getCookie("p_hour")!=null)
                         //           $("select[name=p_hour]").val(getCookie("p_hour"));
                         //   }
                         if(typeof $("[name=p_hour]").val() == "undefined" || $("[name=p_hour]").val() == null)
                            $("[name=p_hour]").val($("[name=p_hour] option:eq(0)").val())
                }else {
                    s.append($('<option/>').html("Unavailable"));
                }
              }});
    }

    function CheckDeliveryTime_new()
    {
        if($("select[name=p_hour]").val() =="" || $("select[name=p_hour]").val() == null || $("select[name=p_hour]").val() =="Unavailable"){
            $("#msgTitle").html("Closed or Unavailable")    
            $("#ClosedModal div.modal-body").html('Not available, on the selected date/time!');
            $("#ClosedModal").modal();
            return false;
        } 
        return true;
    }
   
    var allergenvalues="",suitableforvalue="";
    var containmaycontain =  false;
    function SearchAllergen(obj,mode,id)
    {
        if($(obj).find(".icon-check").length > 0 )
            $(obj).find(".icon-check").remove();
        else
        {
            if(mode=="Allergen")
                $('<span class="glyphicon glyphicon-remove icon-check" attrvalue="' + id.replace("filter_","")+ '"></span>').insertBefore("#" + id);
            else
                $('<span class="glyphicon glyphicon-ok icon-check" attrvalue="' + id.replace("filter_","")+ '"></span>').insertBefore("#" + id);    
        }

        
    }
    function ClearFilter()
    {
        if ($("#FilterModal").find(".icon-check").length > 0) {
            $("#FilterModal").find(".icon-check").remove();
            $('#icoAllergenFilter').removeClass('glyphicon-filtered');
        }
        
   
        //Filter();
     
    }
    function Filter()
    {
        if($("#filter-may").is(":checked"))
            containmaycontain  = true;
        else
            containmaycontain  = false;
        allergenvalues="";
        suitableforvalue="";
        $("#allergenlist").find("li").each(function(){
            if( $(this).find(".icon-check").length > 0)
                allergenvalues += $(this).find(".icon-check").attr("attrvalue") +",";
        });
        $("#suitableforlist").find("li").each(function(){
            if($(this).find(".icon-check").length >0)
                suitableforvalue += $(this).find(".icon-check").attr("attrvalue") +",";
        });


     
        $("[data-type=group-cate]").each(function(){
            var categroup  = $(this);
            categroup.find(".product-line").each(function(){
                    
                if(screenmode=="mobile")
                {
                    categroup.hide();
                    $(this).show();
                    $(categroup).prev().find(".product-line-heading__icon").addClass("arrow-icon-down").removeClass("arrow-icon-up");
                }else
                {
                    $(this).show();
                }
                    
                    
            });
        });
        $("#FilterModal").modal("hide");

        $(".product-line__property-name").show();
        $(".topping").show();
        $("[name='ContainAllergen_dp']").show();                
        $(".product-line-heading").show();
        if(allergenvalues !="" || suitableforvalue !="" || screenmode!="mobile")
        {
            $("[data-type='group-cate']").each(function(){
                $(this).show();
                $(this).prev().find(".product-line-heading__icon").addClass("arrow-icon-up").removeClass("arrow-icon-down");
            });
        }else
        {
            if(screenmode=="mobile")
            {
                $("[data-type='group-cate']").each(function(){
                    $(this).hide();
                    $(this).prev().find(".product-line-heading__icon").addClass("arrow-icon-down").removeClass("arrow-icon-up");
                });
            }
        }

        if (allergenvalues != "" || suitableforvalue != "") $('#icoAllergenFilter').addClass('glyphicon-filtered');
        else $('#icoAllergenFilter').removeClass('glyphicon-filtered');

        filterSearchAllergen(allergenvalues);
        filterSearchSuitable(suitableforvalue);
        
    }
    function isMatchFilterSeachAllergen(valueseach, valueproperty)
    {
        var result =  false;
        
        if(valueseach == "" || typeof valueproperty == "undefined" )
            result = false;
        else if(valueseach != "")
        {
            if(typeof valueproperty != "undefined")
            {
                var scontain = valueproperty.split("|")[0];
                var maycontain = valueproperty.split("|")[1];
                if(containmaycontain == false)
                    valueproperty = scontain;
                else
                {
                    valueproperty = scontain;
                    if(maycontain.trim() !="")
                        valueproperty +="," + maycontain;
                }
                valueproperty.split(",").forEach(function(value,index){
                    if(value !="")
                    {
                        valueseach.split(",").forEach(function(value2,index2){
                       
                            if(value2!="" && value2.trim() == value.trim())
                                result =  true;
                        });
                    }
                });
            }
        }
        return result;
    }
    function isMatchFilterSeachSuitable(valueseach, valueproperty)
    {
        var result =  false;
        
        if(valueseach == "" || typeof valueproperty == "undefined" )
            result = true;
        else if(valueseach != "")
        {
            if(typeof valueproperty != "undefined")
            {
                valueproperty.split(",").forEach(function(value,index){
                    if(value !="")
                    {
                        valueseach.split(",").forEach(function(value2,index2){
                       
                            if(value2!="" && value2.trim() == value.trim())
                                result =  true;
                        });
                    }
                });
            }
        }
        return result;
    }
    function getouterHTML($obj){
        if(typeof $obj !="undefined" && $($obj).length > 0)
            return $obj[0].outerHTML;
    }
    function CheckPropertyMatch(searchtext,obj,attrid,mode)
    {
        var result =  false;
        if(searchtext=="")        
            result =  true;       
        else{
            if(mode=="allergen")
            {   
                result =  true;
                obj.each(function(){
                    var $this  = $(this);
                    if(typeof  $this.attr(attrid) != "undefined" && $this.attr(attrid) !="-1" && $this.attr(attrid) !="|"  )
                    {
                        var scontain = $this.attr(attrid).split("|")[0];
                        var maycontain = $this.attr(attrid).split("|")[1];
                        var valueproperty ="";
                        if(containmaycontain == false)
                            valueproperty = scontain;
                        else
                        {
                            valueproperty = scontain;
                            if(maycontain.trim() !="")
                                valueproperty +="," + maycontain;
                        }

                        valueproperty.split(",").forEach(function(value,index){
                            if(value !="")
                            {
                                searchtext.split(",").forEach(function(value2,index2){                               
                                   if(value2!="" && value2.trim() == value.trim() )                            
                                        result =  false;
                                });
                            }
                            
                        });
                    }

                });
            }else{
                attrid = attrid.replace("s_containallergen_","s_SuitableFor_");
                obj.each(function(){
                    var $this  = $(this);
                    if(typeof  $this.attr(attrid) != "undefined" && $this.attr(attrid)!="-1")
                    {
                        $this.attr(attrid).split(",").forEach(function(value,index){
                            if(value !="")
                            {
                                searchtext.split(",").forEach(function(value2,index2){                               
                                    if(value2!="" && value2.trim() == value.trim())                                
                                        result =  true;                               
                                });
                            }
                        });
                    }
                });
            }
            
        }
        return result;
    }
       
    function filterToppingProperty(searchtext,obj,attrid,mode)
    {
        var result =  false;
        if(searchtext==""){
           // $(idsearch).show();
            result =  true;
        }
        else{
            if(mode=="allergen")
            {                
                obj.each(function(){
                    var $this  = $(this);
                    if(typeof  $this.attr(attrid) != "undefined" && $this.attr(attrid) !="-1" )
                    {
                        var scontain = $this.attr(attrid).split("|")[0];
                        var maycontain = $this.attr(attrid).split("|")[1];
                        var valueproperty ="";
                        if(containmaycontain == false)
                            valueproperty = scontain;
                        else
                        {
                            valueproperty = scontain;
                            if(maycontain.trim() !="")
                                valueproperty +="," + maycontain;
                        }
                        if(valueproperty=="")
                        {
                            result =  true;
                        }
                        else
                        {
                            valueproperty.split(",").forEach(function(value,index){
                                if(value !="")
                                {  
                               
                                    searchtext.split(",").forEach(function(value2,index2){                               
                                        if(value2!="" && value2.trim() == value.trim())
                                        {                                        
                                            //if($this.is(":visible") || typeof $this.attr("style")=="undefined")
                                            $this.hide();                                        
                                        }else if(value2!=""  )                               
                                            result =  true;
                                    });
                                }else
                                {
                                    //if($this.is(":visible"))
                                    //    $this.hide(); 
                                    result =  true;
                                }
                            });
                        }
                        
                    }
                });
            }else{
                attrid = attrid.replace("s_containallergen_","s_SuitableFor_");
                obj.each(function(){
                    var $this  = $(this);
                    if(typeof  $this.attr(attrid) != "undefined" && $this.attr(attrid)!="-1")
                    {
                        $this.attr(attrid).split(",").forEach(function(value,index){
                            if(value !="")
                            {
                                searchtext.split(",").forEach(function(value2,index2){                               
                                    if(value2!="" && value2.trim() != value.trim() &&  $this.is(":visible"))
                                    {
                                       // if($this.is(":visible"))
                                            $this.hide();
                                      
                                    }else if(value2!="" && value2.trim() == value.trim())                                
                                        result =  true;
                                
                                });
                            }else
                            {
                                if($this.is(":visible"))
                                    $this.hide();
                            }
                        });
                    }
                });
            }
            
        }
        return result;
        
    }
    function filterSearchAllergen(allergenlist)
    {
        var searchtext =  allergenlist;
        var itemsearch  = "s_containallergen_m";
        var propertysearch  = "s_containallergen_p";
        var dishpropertysearch  = "s_containallergen_dp";
        var toppingsearch  = "s_containallergen_t";
        var mode = "allergen";
        if(searchtext!=""){
            $(".dishproperties").hide();
            $(".product-line-heading").hide();
            $("[data-type=group-cate]").each(function(){
                var categroup  = $(this);
                categroup.find(".product-line").each(function(){                    
                    var nameid = $(this).attr("name");
                    //if(nameid + "" == "439")
                    //    debugger;
                    var istopping =  false;
                    var isdishname = true;                       
                    var isdishproperty = false;
                    if($(this).find(".product-line__content-left").length > 0)
                    {
                        //check property
                        if($(this).find(".product-line__description").length > 0) 
                        {                            
                                if(isMatchFilterSeachAllergen(searchtext,$(this).find(".product-line__description").attr("" +  itemsearch)))                        
                                    isdishname = false;         
                        }                       
                        //dishproperties468-
                        if($("#dishproperties"  + nameid + "-").length > 0 && isdishname == true)
                        {
                                isdishname = filterToppingProperty(searchtext,$("#dishproperties"  + nameid + "-").find(".topping"),"s_containallergen_t",mode);
                            if(isdishname == false)
                                isdishname =  filterToppingProperty(searchtext,$("#dishproperties"  + nameid + "-").find("[name='ContainAllergen_dp']"),"s_containallergen_dp",mode);                           
                        }
                        //if(nameid + "" == "439")
                        //    console.log("isdishname1 " + isdishname);
                    }else{
                        var _flag = false;
                        var isShowParent  = true;
                        categroup.find('[name="' + nameid + '"]').each(function(){
                            var propertyObj = $(this);
                            var isshowproperty = false;
                            if(typeof propertyObj.attr("Parent") == "undefined" )
                            {   
                                if(isShowParent == true)
                                {
                                    isshowproperty = CheckPropertyMatch(searchtext,propertyObj.find(".product-line__property-name:first"),"s_containallergen_p",mode);   
                                    if(isshowproperty==true)
                                    {
                                        var nextobj =  propertyObj.next();                                 
                                        if(nextobj.attr("class")=="dishproperties")
                                        {
                                            // check all property meet search 
                                            var isshowtopping = filterToppingProperty(searchtext,nextobj.find(".topping"),"s_containallergen_t",mode) ;
                                            var isshowproperty  = filterToppingProperty(searchtext,nextobj.find("[name='ContainAllergen_dp']"),"s_containallergen_dp",mode)
                                            if(isshowtopping ==false && isshowproperty == false )
                                                isshowproperty =  false;                                            
                                        }
                                    }
                                    if(isshowproperty==false && propertyObj.is(":visible"))
                                        propertyObj.hide();
                                    if(isshowproperty == true){
                                        isdishname = true;
                                        _flag  = true;
                                    }   
                                }
                                                                 
                            } else
                            {
                                if(propertyObj.find(".product-line__description").length > 0) 
                                {                    
                                if(isMatchFilterSeachAllergen(searchtext,propertyObj.find(".product-line__description").attr("" +  itemsearch)))
                                    {
                                        _flag = false;         
                                        isShowParent =  false;
                                    }
                                        
                                }      
                            }
                        });
                        isdishname = _flag;
                    }
                   
                    if( isdishname == false)
                    {
                        if( $(this).is(":visible"))
                            $(this).hide();
                    }
                    if($(this).is(":visible"))
                    {
                        categroup.show();
                        $("#group-" + categroup.attr("id")).show();
                        $("#group-" + categroup.attr("id")).find("img").removeClass("arrow-icon-down").addClass("arrow-icon-up");
                    }
                });
            });
        }
        
    }

    function filterSearchSuitable(allergenlist,mode)
    {
        var searchtext =  allergenlist;
        var itemsearch  = "s_suitablefor_m";
        var propertysearch  = "s_suitablefor_p";
        var dishpropertysearch  = "s_suitablefor_dp";
        var toppingsearch  = "s_suitablefor_t";
        var mode = "SuitableFor";
        if(searchtext!=""){
            $(".dishproperties").hide();
            $(".product-line-heading").hide();
            $("[data-type=group-cate]").each(function(){
                var categroup  = $(this);
                categroup.find(".product-line").each(function(){                    
                    var nameid = $(this).attr("name");
                    var istopping =  false;
                    var isdishname = false;    
                    var isdishproperty = false;
                    if($(this).find(".product-line__content-left").length > 0)
                    {
                        //check property
                        if($(this).find(".product-line__description").length > 0) 
                        {       
                                if(isMatchFilterSeachSuitable(searchtext,$(this).find(".product-line__description").attr("" +  itemsearch)))                        
                                    isdishname = true;                           
                        }                       
                        //dishproperties468-
                        if($("#dishproperties"  + nameid + "-").length > 0 && isdishname == false)
                        {
                            isdishname = filterToppingProperty(searchtext,$("#dishproperties"  + nameid + "-").find(".topping"),"s_containallergen_t",mode);
                            if(isdishname == false)
                                isdishname =  filterToppingProperty(searchtext,$("#dishproperties"  + nameid + "-").find("[name='ContainAllergen_dp']"),"s_containallergen_dp",mode);                           
                        }
                    }else{
                        categroup.find('[name="' + nameid + '"]').each(function(){
                            var propertyObj = $(this);
                            var isshowproperty = false;
                            if(typeof propertyObj.attr("Parent") == "undefined")
                            {   
                                
                                    isshowproperty = CheckPropertyMatch(searchtext,propertyObj,"s_containallergen_p",mode);
                                    if(isshowproperty==false)
                                    {
                                        var nextobj =  propertyObj.next();                                 
                                        if(nextobj.attr("class")=="dishproperties")
                                        {
                                            // check all property meet search 
                                            isshowproperty =  filterToppingProperty(searchtext,nextobj.find(".topping"),"s_containallergen_t",mode);
                                            if(isshowproperty==false)
                                                isshowproperty =  filterToppingProperty(searchtext,nextobj.find("[name='ContainAllergen_dp']"),"s_containallergen_dp",mode);
                                        }
                                    }
                                if(isshowproperty==false && propertyObj.is(":visible"))
                                    propertyObj.hide();
                                if(isshowproperty == true)
                                   isdishname = true;
                            }  
                        });
                    }
                        if( isdishname == false)
                        {
                            if( $(this).is(":visible"))
                                $(this).hide();
                        }
                       
                        if($(this).is(":visible"))
                        {
                            categroup.show();
                            $("#group-" + categroup.attr("id")).show();
                            $("#group-" + categroup.attr("id")).find("img").removeClass("arrow-icon-down").addClass("arrow-icon-up");
                        }
                    
                });
            });
        }
       
    }
    function IsMatchSearch(terms, text)
    {
        var arrTerms  = terms.split(" ");
        var result = false;
        for(var i= 0 ; i< arrTerms.length;i++)
        {
            if(arrTerms[i].toLowerCase()!="")
            {
                result = text.toLowerCase().indexOf(arrTerms[i].toLowerCase()) >-1? true:false
                if(result == false)
                    break;      
            }              
        }
        return result;
    }
    function SearchTerms(objID)
    {
        var searchtext =  $("#" + objID).val().trim();
        if(searchtext!=""){
            $(".dishproperties").hide();
            $(".product-line-heading").hide();
            ClearFilter();
            $("[data-type=group-cate]").each(function(){
                var categroup  = $(this);
                categroup.find(".product-line").each(function(){
                    //product-line__number
                    if( ( $(this).find(".hidden-product-name").length > 0 
                           &&  IsMatchSearch(searchtext, $(this).find(".hidden-product-name").html().trim()) ) || (  $(this).find(".product-line__description").length > 0 
                           &&  IsMatchSearch(searchtext, $(this).find(".product-line__description").html().trim())) || 
                            (  $(this).find(".product-line__number").length > 0 
                           &&  IsMatchSearch(searchtext, $(this).find(".product-line__number").html().trim()))
                        )
                    {
                        $(this).show();
                        categroup.show();
                        $("#group-" + categroup.attr("id")).show();
                        $("#group-" + categroup.attr("id")).find("img").removeClass("arrow-icon-down").addClass("arrow-icon-up");
                    }else
                    {
                        $(this).hide();
                    }
                });
            });
        }else
        {
            $(".product-line-heading").show();
            $("[data-type=group-cate]").each(function(){
                var categroup  = $(this);
                categroup.find(".product-line").each(function(){
                    
                    if(screenmode=="mobile")
                    {
                        categroup.hide();
                        $(this).show();
                        $(categroup).prev().find(".product-line-heading__icon").addClass("arrow-icon-down").removeClass("arrow-icon-up");
                    }else
                    {
                        $(this).show();
                    }
                    
                    
                });
            });
        }
    }
    function lookupdayinarray(Json,day)
    {
        var result = false; 
        for (key in jsDate) {
            if (jsDate[key].d==day) {
                result = true; 
            }
        }       
        return result;
    }
    function CheckOrder(mode) {
        if(mode=="confirm")
        {
            if( $.trim($("#modalDivOrderTypeBody").html()) !=""){
                $("#modalDivOrderType").modal("show");
                $("[name='orderTypePicker']:checked").trigger("click");
                LoadTimes();
                //InitCollectionDelivery();    
                //InitCollectionDelivery2();
            }
            return false;
        }   
        var delivery_type  = $("input[name='orderTypePicker']:checked").val();
        // check valid Item
        var checkApplyto =  true;
        $("[name=menuapplyto]").each(function(){
            if($(this).val() !="b" && $(this).val() != delivery_type)
                checkApplyto = false;
        });
        if(checkApplyto==false && delivery_type !="")
        {   var delivery_typeText = "Delivery";
            if(delivery_type =="c")
                delivery_typeText = "Collection";
            alert("Some of the selected items are not allowed for the order type " + delivery_typeText );
            return false;
        }
        // end 
        var AcceptFor = 0;
        var offsetmins,offsetmins2;
        if (delivery_type == 'd') {
            offsetmins=$('#deliverydelay').val();
        } else {
            offsetmins=$('#collectiondelay').val();
        }
        offsetmins2 = parseInt(offsetmins) ; //parseInt(offsetmins)+5;
        if ($("input[name='ordertimeoverride']:checked").val() == 'n') { 
             var dt1 = new Date();
            var dt1Day = dt1.getDay();
            var nextOpeningTime = new Date();
            if (dt1Day == 0) dt1Day = 7;
                    if(delivery_type == "d" && $("[name=PreDeliveryOpen]").val()=="true"){
                        var datemin =Date.parse('01/01/2011 00:00') ; 
                            nextOpeningTime.setTime(datemin);
                    }
                    else if(delivery_type == "c" && $("[name=PreCollectionOpen]").val()=="true"){
                            
                    }
                    else 
                        nextOpeningTime = GetOpeningTimeExt(currenttime,dt1Day,delivery_type);
               
                    var OrderBeforeTime = false;     
            if(nextOpeningTime !=null && ( dt1.getHours() < nextOpeningTime.getHours() || (dt1.getHours() == nextOpeningTime.getHours() && dt1.getMinutes() < nextOpeningTime.getMinutes())) ){
                dt1.setHours(nextOpeningTime.getHours());
                dt1.setMinutes(nextOpeningTime.getMinutes());
                $("input[name='ordertimeoverride'][value=l]").prop('checked',true);
                OrderBeforeTime =  true;
            }                
            AcceptFor = GetOrderAcceptFor(currenttime,dt1Day,delivery_type)
            if(AcceptFor >= 0)
                AcceptFor =   offsetmins2;
            else
                AcceptFor=0;  

            var dt = new Date(dt1.getTime() + (offsetmins2 - AcceptFor)*60000);          
            var time = dt.getHours() + ":" + dt.getMinutes() + ":" + dt.getSeconds();          
            $("select[name=p_hour]").trigger("change");            
            $("#OrderDate input").val(dt.getDate()  + "/" + (dt.getMonth() +1) + "/" + dt.getFullYear());	
        }
        //try
        //{
            if(!delivery_type || $("[name=ordertimeoverride]:checked").length ==0)
            {
                if($("#beforeorder").html() !=""){
                    $('#beforeorder').css('border-color', 'red');
                    $('#beforeorder').css('border-width', '4px');
                    scrollToV2("beforeorder");
                }
                else if($("#modalDivOrderTypeBody").html() !=""){
                    $('#modalDivOrderTypeBody #input-group-pc').css('border', 'solid 1px red');                    
                    scrollToV2("modalDivOrderTypeBody");
                }
                return false;
            }

            var form = $("#CheckOutForm");
            $('input[name=deliveryType]', form).val(delivery_type);
            $('input[name=special]', form).val($("#Specialinput").val());
            $('input[name=asaporder]', form).val($("input[name='ordertimeoverride']:checked").val());
            if(delivery_type == 'd'){
                if(isSetLatLng){
                    $('input[name=deliveryLat]', form).val($("#hidLat").val());
                    $('input[name=deliveryLng]', form).val($("#hidLng").val());
                }else{
                    $('input[name=deliveryLat]', form).val('');
                    $('input[name=deliveryLng]', form).val('');
                }
                $('input[name=deliveryPostCode]', form).val($("#hidPostCode").val());
                $('input[name=deliveryAddress]', form).val($("#hidFormattedAdd").val());
            }
            else{
                $('input[name=deliveryLat]', form).val('');
                $('input[name=deliveryLng]', form).val('');
                $('input[name=deliveryPostCode]', form).val('');
                $('input[name=deliveryAddress]', form).val('');
            }
			 
            if(delivery_type == 'd')
            {
                //CheckDistance();
                var distance = $('input[name=deliveryDistance]', form).val();
                if(!distance)
                {
               
                    if($("#beforeorder").html() !=""){
                        $('#beforeorder').css('border-color', 'red');
                    
                        scrollToV2("beforeorder");
                    }
                    else if($("#modalDivOrderTypeBody").html() !=""){
                        $('#modalDivOrderTypeBody #input-group-pc').css('border', 'solid 1px red');
                        scrollToV2("modalDivOrderTypeBody");
                    }

                    //$("#BeforeYouOrder").modal();
                    return false;
                }

                var min_amount = <%= sDeliveryMinAmount %>;
                var total = parseFloat($("#SubTotal").val());
                if(min_amount > 0 && total < min_amount)
                {
                    $("#DeliveryModal div.modal-body").html('Sorry. Minimum Order for Delivery is <%=CURRENCYSYMBOL%> ' + min_amount);
                    $("#DeliveryModal").modal();
                    return false;
                }
            }

               
            // check to see if current time is greater than delivery or collection time 
            //var dt = $("#DeliveryTime");
            var _sTime = $("select[name=p_hour]").val().replace(/[A-z]+ /i,"") ;
            //    _time = Date.parse('01/01/2011 ' + _sTime);
            //var parts = $("#OrderDate input").val().split('/');
            //var p_hour,p_minute;            
            //    p_hour = $("select[name=p_hour]").val().replace(/[A-z]+ /i,"").replace(/:\d+/,"")
            //    p_minute = $("select[name=p_hour]").val().replace(/[A-z]+ /i,"").replace(/\d+:/,"")
            //var _selecteddateandtime =  new Date(parts[2], parts[1]-1, parts[0],  p_hour,p_minute);
            //var currdt = new Date();
		
            //if(delivery_type == 'd') {
            //    var newcurrdt = new Date(currdt.getTime() + (offsetmins2-AcceptFor)*60000 - 5 * 60000); //-2 min to make sure curent date will less than the time we set at p_hour
	
            //} else {
            //    var newcurrdt = new Date(currdt.getTime() + (offsetmins2 -AcceptFor) *60000  - 5 * 60000 ); //-2 min to make sure curent date will less than the time we set at p_hour
            //}
				
            if(!CheckDeliveryTime_new())
            { 
                return false;
            }
				
            //if($("input[name='orderTypePicker']:checked").val() == "c" && !CheckCollectionTime())
            //{ 
			//	return false;
            //}

            $('#beforeorder').css('border-color', '#E9EAEB');
            $("[name=h_p_hour]").val($("select[name=p_hour]").val());
            $("[name=deliveryTime]").val($("#OrderDateBox").val() + " " + _sTime);
            StoreCookieDelivery();
            if(IncludeDelivery_Collection !="")
            {
                if(IncludeDelivery_Collection != delivery_type)
                {
                    if(delivery_type=="d")
                        alert("The voucher used does not apply to Delivery.  Please use another one.");
                    else
                        alert("The voucher used does not apply to Collection.  Please use another one.");
                    return false;
                }
            }
            $('#CheckOutForm').submit();
            return true;
			   
        //}
        //catch(ex)
        //{
        //    console.log(ex);
        //    return false;
        //}


    }
        
    function round5(x)
    {
        x2=(x % 5) >= 2.5 ? parseInt(x / 5) * 5 + 5 : parseInt(x / 5) * 5;
        if (x2==60) { x2=0; }
        return(x2);
    }

    $(function () {
        
        var viewport_width = $( window ).width();
        //  if(viewport_width < 748)
        //  {
        //       $("div[data-spy]")
        //           .removeAttr('data-spy')
        //           .removeAttr('data-offset-top');
        //  }

        var _date = new Date();
        var hour = _date.getHours();
        var minutes = _date.getMinutes();
        var dt = $("#DeliveryTime");
			
        if (hour==23) {
			
            $("select[name=p_hour]", dt).val(0);
            _date.setDate(_date.getDate() + 1); 
            boxdate=("0" + (_date.getMonth() + 1)).slice(-2)
            boxday=("0" + (_date.getDate())).slice(-2)
            ddate20=boxday.toString() + "/" + boxdate.toString() + "/"  + _date.getFullYear().toString()
            $("#OrderDateBox").val(ddate20);
        } else {
            $("select[name=p_hour]", dt).val(hour + 1);
			
        }


			
        var nowTemp = new Date();
        var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);
        var Close_StartDate_JS ,Close_EndDate_JS;
   
        if('<%=Close_StartDate_JS%>' !='')
            Close_StartDate_JS  = new Date(<%=Year(Close_StartDate_JS)%>, <%=(Month(Close_StartDate_JS)-1)%>, <%=Day(Close_StartDate_JS)%>, 0, 0, 0, 0);
        if('<%=Close_EndDate_JS%>' !='')
            Close_EndDate_JS  = new Date(<%=Year(Close_EndDate_JS)%>, <%=(Month(Close_EndDate_JS)-1)%>, <%=Day(Close_EndDate_JS)%>, 0, 0, 0, 0);

         

        <%if ordertodayonly<>1 then%>
                var checkout = $('#OrderDate').datepicker({
			
                    onRender: function(date) {
                        if(typeof Close_StartDate_JS !="undefined" && typeof Close_EndDate_JS !="undefined")
                            return (date.valueOf() < now.valueOf() || (Close_StartDate_JS.valueOf() <= date.valueOf() &&  date.valueOf()  <= Close_EndDate_JS.valueOf() )) ? 'disabled' : '';
                        else
                           return date.valueOf() < now.valueOf()  ? 'disabled' : '';

                    }
			
			
                }).on('changeDate', function (ev) {
                    ddate=ev.date;
                    pickeddate=("0" + (ddate.getMonth() + 1)).slice(-2)
                    pickedday=("0" + (ddate.getDate())).slice(-2)
                    ddate2=pickedday.toString() + "/" + pickeddate.toString() + "/"  + ddate.getFullYear().toString()
			
                    $("#OrderDateBox").val(ddate2);
                    StoreToC($("#OrderDateBox"),"OrderDate"); <% ' Store value to cookie for back button remember value%>
                    checkout.hide();
                    LoadTimes();
                }).data('datepicker');
        <%end if	%>
                 $("input[name='ordertimeoverride']").click(function() {
                 $.ajax({url: "<%=SITE_URL %>ajaxdelivery.asp?d=" + $("input[name='orderTypePicker']:checked").val() , success: function(result){
                 ReloadShop();
        }});
	
          if ($("input[name='ordertimeoverride']:checked").val() == 'n') { 	  
            if ($("input[name='orderTypePicker']:checked").val() == 'c') { 
                offsetmins=$('#collectiondelay').val();
                var dt1 = new Date();
                offsetmins2 = parseInt(offsetmins) ; //parseInt(offsetmins)+5;
                var dt = new Date(dt1.getTime() + offsetmins2*60000);
                var time = dt.getHours() + ":" + dt.getMinutes() + ":" + dt.getSeconds();
                $("select[name=p_hour]", dt).val(dt.getHours());
 
            }
        } 
          if ($("input[name='ordertimeoverride']:checked").val() == 'n') { 	  
                    if ($("input[name='orderTypePicker']:checked").val() == 'd') { 	
                        $("#DeliveryDistance").show();  
                        $("#PreFillDistance").tooltip({trigger: 'manual'}).tooltip('show');
                            setTimeout(function () {
                            $("#PreFillDistance").tooltip('hide');
                        }, 3000);
                        $("#DeliveryTime").hide();     
                        $("#DeliveryTime label").text("Delivery Time *");
                        $('#DeliveryTimeNowD').show();
                        $('#DeliveryTimeNowC').hide(); 
                        $('#CollectionAddress').hide();    
                        console.log("hide 1");
                    } else {
                        $("#DeliveryDistance").hide(); 
                        $("#DeliveryTime label").text("Collection Time *");
                        $("#DeliveryTime").hide();
                        $('#DeliveryTimeNowC').show();
                        $('#CollectionAddress').show();
                        console.log("Show 1");
                        $('#DeliveryTimeNowD').hide();
	
                    }
        } 	
                if ($("input[name='ordertimeoverride']:checked").val() == 'l') { 
                $('#DeliveryTimeNowD').hide();
                $('#DeliveryTimeNowC').hide();
               // $('#CollectionAddress').hide();
             if ($("input[name='orderTypePicker']:checked").val() == 'd') { 
		        $('#CollectionAddress').hide();
                console.log("hide 2");
             $("#DeliveryDistance").show();               
            $("#PreFillDistance").tooltip({trigger: 'manual'}).tooltip('show');
             setTimeout(function () {
                    $("#PreFillDistance").tooltip('hide');
        }, 3000);
              $("#DeliveryTime").show();  
              $("#DeliveryTime label").text("Delivery Time *"); 		  
        offsetmins=$('#deliverydelay').val();
        var dt1 = new Date();
        offsetmins2 = parseInt(offsetmins);//parseInt(offsetmins)+5;
        var dt = new Date(dt1.getTime() + offsetmins2*60000);	
        var time = dt.getHours() + ":" + dt.getMinutes() + ":" + dt.getSeconds();
        $("select[name=p_hour]", dt).val(dt.getHours());

	
        } else {  
              $("#DeliveryDistance").hide();
               $("#DeliveryTime label").text("Collection Time *");
                $("#DeliveryTime").show(); 
                if ($("input[name='orderTypePicker']:checked").val() == 'c') { 
        offsetmins=$('#collectiondelay').val();
        var dt1 = new Date();
        offsetmins2 = parseInt(offsetmins) ;// parseInt(offsetmins)+5;
        var dt = new Date(dt1.getTime() + offsetmins2*60000);
	
        var time = dt.getHours() + ":" + dt.getMinutes() + ":" + dt.getSeconds();
        $("select[name=p_hour]", dt).val(dt.getHours());

        }
        }
	 
        } 	 
        });
        $("input[name=orderTypePicker]").click(function() {
            ismobileSelected =true;
            $("#nowlater").show();
			
            $.ajax({url: "<%=SITE_URL %>ajaxdelivery.asp?d=" + $("input[name='orderTypePicker']:checked").val() , success: function(result){
                ReloadShop();
            }});
	
            if ($("input[name='ordertimeoverride']:checked").val() == 'n') { 	  
                if ($("input[name='orderTypePicker']:checked").val() == 'c') { 
                    offsetmins=$('#collectiondelay').val();
                    var dt1 = new Date();
                    offsetmins2 = parseInt(offsetmins); //parseInt(offsetmins)+5;
                    var dt = new Date(dt1.getTime() + offsetmins2*60000);
	
                    var time = dt.getHours() + ":" + dt.getMinutes() + ":" + dt.getSeconds();
                    $("select[name=p_hour]", dt).val(dt.getHours());
                }
            }
            if ($("input[name='ordertimeoverride']:checked").val() == 'n') { 
                if ($("input[name='orderTypePicker']:checked").val() == 'd') {
                    $("#DeliveryDistance").show();  
                    $("#PreFillDistance").tooltip({trigger: 'manual'}).tooltip('show');
                    setTimeout(function () {
                        $("#PreFillDistance").tooltip('hide');
                    }, 3000);
                    $("#DeliveryTime").hide();  
                    $("#DeliveryTime label").text("Delivery Time *");
                    $('#DeliveryTimeNowD').show();
                    $('#DeliveryTimeNowC').hide();
                    $('#CollectionAddress').hide();
                    console.log("hide 3");
                } else {
                    $("#DeliveryDistance").hide(); 
                    $("#DeliveryTime label").text("Collection Time *"); 
                    $("#DeliveryTime").hide();
                    $('#DeliveryTimeNowC').show();
                    $('#CollectionAddress').show();
                    console.log("show 3");
                    $('#DeliveryTimeNowD').hide();
                }
            } 	
            if ($("input[name='ordertimeoverride']:checked").val() == 'l') { 
                if ($("input[name='orderTypePicker']:checked").val() == 'd') { $("#DeliveryDistance").show(); 
                    $("#PreFillDistance").tooltip({trigger: 'manual'}).tooltip('show');
                    setTimeout(function () {
                        $("#PreFillDistance").tooltip('hide');
                    }, 3000);
                    $("#DeliveryTime").show();  $("#DeliveryTime label").text("Delivery Time *");    } else {  $("#DeliveryDistance").hide(); $("#DeliveryTime label").text("Collection Time *"); $("#DeliveryTime").show(); 
                }
	 
            } 	
	  	 
            if ($("input[name='orderTypePicker']:checked").val() == 'c') {
                console.log("show 4");
                $('#CollectionAddress').show();
            }
                
				 
        });

        jQuery.validator.setDefaults({
            errorPlacement: function (error, element) {
                if (element.parent().hasClass('input-prepend') || element.parent().hasClass('input-append')) {
                    error.insertAfter(element.parent());
                } else {
                    error.insertAfter(element);
                }
            },
            errorElement: "small", 
            wrapper: "div", 
            highlight: function (element) {
                $(element).closest('.control-group').addClass('error'); 
            },
            success: function (element) {
                $(element).closest('.control-group').removeClass('error');
            }
        });

        $("form").removeAttr("novalidate");
        $("form").validate();

        $.ajaxSetup ({
            cache: false
        });
            
        ReloadShop();            
        <%if IsCloseRestaurant = true then %>
                $("#butcontinue").unbind("click");
                $("#butcontinue").bind("click",function(){
                    return false; 
                });
                $("#butcontinue").hide();
                $("#basket").hide();
                $("#idOpenHour").hide();            
                $("#closeRest").show();
         <%elseIf Not isopen  then %>
            $("#ClosedModal").modal();
            <%if sorderonlywhenopen=1  then%>
                $("#butcontinue").unbind("click");
                $("#butcontinue").bind("click",function(){
                  
                return false; 
                });
                $("#butcontinue").hide();
                $("#basket").hide();
                $("#idOpenHour").hide();    
                $("#beforeorder").hide();
                $("#noorders").show();
            <%end if%>
        
        <% End If %>

    });
		
		
		
    $("input[name='ordertimeoverride']").change(function(){
		
        if ($(this).val() == 'n') {	
            if ($("input[name='orderTypePicker']:checked").val() == 'd') {
                $('#CollectionAddress').hide();
                console.log("hide 5");
                offsetmins=$('#deliverydelay').val();
            } else {
                offsetmins=$('#collectiondelay').val();
                $('#CollectionAddress').show();
                console.log("show 5");    
            }
            var dt1 = new Date();
            var dt = new Date(dt1.getTime() + offsetmins*60000);
	
            var time = dt.getHours() + ":" + dt.getMinutes() + ":" + dt.getSeconds();
            $("select[name=p_hour]", dt).val(dt.getHours());

	
            if ($("input[name='orderTypePicker']:checked").val() == 'd') { $("#DeliveryDistance").show();  
                $("#PreFillDistance").tooltip({trigger: 'manual'}).tooltip('show');
                setTimeout(function () {
                    $("#PreFillDistance").tooltip('hide');
                }, 3000);
                $("#DeliveryTime").hide();  $("#DeliveryTime label").text("Delivery Time *");  	} else {
                $("#DeliveryDistance").hide(); $("#DeliveryTime label").text("Collection Time *"); $("#DeliveryTime").hide();
	
            }
        };
	
        if ($(this).val() == 'l') {
            if ($("input[name='orderTypePicker']:checked").val() == 'd') { $("#DeliveryDistance").show(); 
                $("#PreFillDistance").tooltip({trigger: 'manual'}).tooltip('show');
                setTimeout(function () {
                    $("#PreFillDistance").tooltip('hide');
                }, 3000);
                $("#DeliveryTime").show();  $("#DeliveryTime label").text("Delivery Time *");   } else {  $("#DeliveryDistance").hide(); $("#DeliveryTime label").text("Collection Time *"); $("#DeliveryTime").show(); 
            }
   
        } 
    });
</script>
     
<nav class="navbar navbar-default navbar-fixed-bottom" role="navigation">
				
				
				
				<div class="navbar-header" style="float:right;">
					
					
					
					 <div class="navbar-brand" >  <span class="label label-success" id="addtobasket" style="float:left;margin-right:10px;">Added</span>
                          <% 
                              dim ishowPlaceOrder : ishowPlaceOrder = true
                              dim messageClose : messageClose = " However, you can place an order now for a later time."
                                 If isopen=false then 
                                    if sorderonlywhenopen=1   then
                                        ishowPlaceOrder = false
                                        messageClose = "Ordering available during opening hours only."
                                    
                                    end if
                                 end if
                          
                                
                            if ishowPlaceOrder=true and IsCloseRestaurant = false then
                              
                               %>
                                <button type="button" id="butcontinue" class="btn btn-primary btn-sm" style="float:right;margin-left:10px;">Checkout <span class="glyphicon glyphicon-chevron-right"></span></button>  
                             
            
                         <button type="button"  id="butbasket" class="btn btn-warning btn-sm"><span class="glyphicon glyphicon-shopping-cart"></span> <b>Basket</b> <%=CURRENCYSYMBOL%>  <span id="shoppingcart2"></span></button>
                         <%end if %>

</div>
				</div>
				
				
				
			</nav>



			
    <div id="ClosedModal" class="modal fade">
	  <div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;</button>
            <h3 style="color: red" id="msgTitle">
                Closed</h3>
        </div>
  
        <div class="modal-body">
            <p id="msgclose" style="display:none;">Sorry, we are closed today</p>
            <p id="msgcurrent">
                Sorry, <b>
                    <%=sName %></b> is closed at the moment.<br />
               <%=messageClose %><br />
            </p>
        </div>

        <div class="modal-footer">
            <a href="#" data-dismiss="modal" class="btn btn-primary">Ok!</a>
        </div>
    </div></div></div>
    <div id="DeliveryModal" class="modal fade">
		  <div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;</button>
            <h3 style="color: red">
                Delivery not possible</h3>
        </div>
        <div class="modal-body">
            
        </div>
        <div class="modal-footer">
            <a href="#" data-dismiss="modal" class="btn btn-primary">Ok!</a>
        </div>   </div>   </div>
    </div>
	
	<div id="AnnouncementModal" class="modal fade">
		  <div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;</button>
            <h3 style="color: red">
              Announcement</h3>
        </div>
        <div class="modal-body">
            
        </div>
        <div class="modal-footer">
            <a href="#" data-dismiss="modal" class="btn btn-primary">Ok!</a>
        </div>   </div>   </div>
    </div>
	
    <div id="RestCloseModal" class="modal fade">
		  <div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;</button>
            <h3 style="color: red">
              Closed</h3>
        </div>
        <div class="modal-body">
            
        </div>
        <div class="modal-footer">
            <a href="#" data-dismiss="modal" class="btn btn-primary">Ok!</a>
        </div>   </div>   </div>
    </div>
	
	
	<div id="SessionTimeout" class="modal fade">
		  <div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;</button>
            <h3 style="color: red">
              Timeout</h3>
        </div>
        <div class="modal-body">
            Sorry, Your session has expired. Please click OK to restart.
        </div>
        <div class="modal-footer">
            <a href="javascript:void(0);" onclick="location.href='<%="menu.asp?id_r=" & request.querystring("id_r") %>'" data-dismiss="modal" class="btn btn-primary">Ok!</a>
        </div>   </div>   </div>
    </div>
	
	
	
	<div id="timeslotModal" class="modal fade">
		  <div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;</button>
            <h3 style="color: red">
              Warning</h3>
        </div>
        <div class="modal-body">
            Delivery is not available during your selected timeslot. Please check our opening times.
        </div>
        <div class="modal-footer">
            <a href="#" data-dismiss="modal" class="btn btn-primary">Ok!</a>
        </div>   </div>   </div>
    </div>
	
	<div id="timeslotModal2" class="modal fade">
		  <div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;</button>
            <h3 style="color: red">
              Warning</h3>
        </div>
        <div class="modal-body">
            Collection is not available during your selected timeslot. Please check our opening times.
        </div>
        <div class="modal-footer">
            <a href="#" data-dismiss="modal" class="btn btn-primary">Ok!</a>
        </div>   </div>   </div>
    </div>
	<div id="tooEarlyOrder" class="modal fade">
		  <div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;</button>
            <h3 style="color: red">
              Warning</h3>
        </div>
        <div class="modal-body">
            Your selected delivery/collection time is too near the opening time. We need to adjust it to allow enough time to prepare your order.
        </div>
        <div class="modal-footer">
            <a href="#" data-dismiss="modal" class="btn btn-primary">Ok!</a>
        </div>   </div>   </div>
    </div>
	
	
	<div id="lightbox" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" style="margin-top: 20px;
    margin-left: 20px;">
    <div class="modal-dialog">
        <button type="button" class="close hidden" data-dismiss="modal" aria-hidden="true">x</button>
        <div class="modal-content">
            <div class="modal-body">
                <img src="" alt=""  />
            </div>
        </div>
    </div>
</div>
<div id="modalDivOrderType" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" style="margin-top: 20px;
    margin-left: 20px;z-index:1045;">
    <div class="modal-dialog">
        <button type="button" class="close hidden" data-dismiss="modal" aria-hidden="true">x</button>
        <div class="modal-content">
            <div class="modal-body" id="modalDivOrderTypeBody">
                
            </div>
        </div>
    </div>
</div>   
    <script>
        var curnumday = <%=Weekday(DateAdd("h",houroffset,now),vbMonday) %>;
         function isDayClose(iday)
    {
        var isClose = true;   
        $("[name=nameopentime]").each(function(){
            if($(this).attr("nameopentime")==iday && $(this).attr("available")=="y")
                isClose =  false;
        });
        
        if(isClose==true && $('[nameopentime='+iday+']').length > 0){
            $('[nameopentime='+iday+']').slice(1).remove();
            $('[nameopentime='+iday+'] td:eq(1)').html("<div align='right'>Closed</div>");
            

            isClose = false;
        }
            
        return isClose;
    }
    var ArrDay =[1,2,3,4,5,6,7];
    var ArrNameDay =["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"];

    for(var iday = 0; iday<ArrDay.length;iday++)
    {
        if(isDayClose(ArrDay[iday]))
        {   var styleCurrentday ="";
                if(ArrDay[iday]==curnumday)
                    styleCurrentday="font-weight:bold;";
            if(ArrDay[iday]==1)
            {
                $( "#openninghours" ).prepend( "<tr name='nameopentime' nameopentime='" +ArrDay[iday]+"' style='" + styleCurrentday + "'><td style='width:30px;'>" +ArrNameDay[iday] + "</td><td><div align='right'>Closed</div></td></tr>" );
            }
            else
            {   var pday  = ArrDay[iday]-1;
              
                $("<tr name='nameopentime' nameopentime='" +ArrDay[iday]+"' style='"+styleCurrentday+"'><td style='width:30px;'>" +ArrNameDay[iday] + "</td><td><div align='right'>Closed</div></td></tr>").insertAfter("[nameopentime="+pday+"] :last");
            }
        }
    }
        
        if($.trim($("[nameopentime="+curnumday+"] div").html()) == "Closed")
        {
            $("#msgclose").show();
            $("#msgcurrent").hide();
            
        }
    </script>
<!-- Begin Login Modal -->
    <script>
       function checkPattern(str,paterm) {
           
            var re =paterm;

            return re.test(str);
        }
       function submitBooking()
        {

     
                var name,tel,bookdate,comment,itemBooking="",txtNumberPeople,email;
                name  = $("#txtCustomerName").val();
                tel = $("#txtTel").val();
                bookdate = $("#txtDate").val();
                comment = $("#txtComment").val();
                email = $("#txtEmail").val();
                txtNumberPeople = $("#txtNumberPeople").val();
                if(name=="")
                {
                    alert("Please input your name!");
                    return false;
                }
                if(tel=="")
                {
                    alert("Please input your mobile number!");
                    return false;
                }
  
                if(email == "")
                {
                    alert("Please input your email!");
                    return false;
                }else if(!checkPattern(email,/\S+@\S+\.\S+$/) )
                {
                     alert("email must be xxx@yyy.zzz!");
                     return false;
                }
                if(txtNumberPeople=="")
                {
                    alert("Please input number of people!");
                    return false;
                }
                else if(!checkPattern(txtNumberPeople,/^[0-9]+$/))
                {
                    alert("Number of people must be number!");
                    return false;
                }
                if(bookdate=="")
                {
                    alert("Please input date!");
                    return false;
                }
//                if(comment=="")
//                {
//                    alert("Please leave your comment!");
//                    return false;
//                }
                
                $("#booktableModal table tr").each(function(){
                    if(typeof $(this).find("[name=itemName]").html() !="undefined" && 
                       typeof $(this).find("[name=itemPrice]").html() !="undefined"    )
                    itemBooking += $.trim( $(this).find("[name=itemName]").html())+ "[*]" + $.trim($(this).find("[name=itemPrice]").html()) + "[**]";

                });
                
                comment =  comment.replace(/\r?\n/g, '<br />');
                 bookdate = bookdate + " " + $("#slTime").val() + ":00";
                $.post("<%=SITE_URL %>TableBooking/booktable.asp?id_r=<%=vRestaurantId %>&r="+Math.random(), { name: name, tel:tel, dt:bookdate,comment:comment, item: itemBooking,numberpeople:txtNumberPeople,email:email},
                function(data,status){
                    alert("Your request has been sent and will be dealt with as soon as possible.");
                    $("#booktableModal").modal("hide");
                    isconfirm =  false;
                });
     


          
       

        }
    </script>

 <div id="booktableModal" class="modal fade">
    <div class="modal-dialog modal-lm">
        <div class="modal-content">

            <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                ×</button>
                <h4>Table Booking Request</h4>
                
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="input-customer-name">Full Name</label>
                    <input type="text" class="form-control" id="txtCustomerName" placeholder="Customer Name" >
                </div>
                <div class="form-group">
                    <label for="input-tel-no">Telephone number</label>
                    <input type="text" class="form-control" id="txtTel" placeholder="Tel.No" required>
                </div>
                <div class="form-group">
                    <label for="input-tel-no">Email</label>
                    <input type="text" class="form-control" id="txtEmail" placeholder="Email Address" >
                </div>
                <div class="form-group">
                    <label for="input-tel-no">Number of people</label>
                    <input type="text" class="form-control" id="txtNumberPeople" placeholder="Number of people" >
                </div>
                <div class="row">
                    <div class="form-group col-md-4 col-xs-6">
                        <label for="input-Date">Date</label>                    
                        <input type="text" class="form-control datepicker" id="txtDate" name="txtDate"   data-date-weekStart="1" data-date-format="dd/mm/yyyy">
                        <div id="custom-pos"></div> 
                         <style>
                             #custom-pos .datepicker {
                                 top:-241px;
                                 /*position:inherit!important;*/
                             } 
                             #custom-pos .datepicker:before {
                           
                               top: auto;
                               left: 6px;
                               bottom: -7px;
                               border-bottom: 0;
                               border-top: 7px solid rgba(0,0,0,.15);
                            } 
                           #custom-pos .datepicker:after {
                            
                               top: auto;
                               left: 7px;
                               bottom: -6px;
                               border-bottom: 0;
                               border-top: 6px solid #fff;
                            } 
                         </style>
                        <script>
                             var nowTemp1 = new Date(); 
                              var now1 = new Date(nowTemp1.getFullYear(), nowTemp1.getMonth(), nowTemp1.getDate(), 0, 0, 0, 0);
                               var Close_StartDate_JS1 ,Close_EndDate_JS1;   
                                if('<%=Close_StartDate_JS%>' !='')
                                    Close_StartDate_JS1  = new Date(<%=Year(Close_StartDate_JS)%>, <%=(Month(Close_StartDate_JS)-1)%>, <%=Day(Close_StartDate_JS)%>, 0, 0, 0, 0);
                                if('<%=Close_EndDate_JS%>' !='')
                                    Close_EndDate_JS1  = new Date(<%=Year(Close_EndDate_JS)%>, <%=(Month(Close_EndDate_JS)-1)%>, <%=Day(Close_EndDate_JS)%>, 0, 0, 0, 0);

                               var datePopup =  $('#txtDate').datepicker({                   
			                            orientation: 'bottom auto',
                                        container:"#custom-pos",
                                        onRender: function(date) {
                                           // return date.valueOf() < now1.valueOf() ? 'disabled' : '';
                                            if(typeof Close_StartDate_JS1 !="undefined" && typeof Close_EndDate_JS1 !="undefined")
                                                return (date.valueOf() < now1.valueOf() || (Close_StartDate_JS1.valueOf() <= date.valueOf() &&  date.valueOf()  <= Close_EndDate_JS1.valueOf() )) ? 'disabled' : '';
                                            else
                                                return date.valueOf() < now1.valueOf()  ? 'disabled' : '';
                                        }
                                    }).on('changeDate', function (ev) {
                                        datePopup.hide();
              
                                    }).data('datepicker');
                        </script>
                    </div>
                    <div class="form-group col-md-4 col-xs-5">
                         <label for="input-Date">Time</label>    
                    <select name="slTime" id="slTime" style="float:left;vertical-align:middle;" class="form-control">
                        <% 
                            dim irun : irun  = 0
                            dim hhmm
                            for irun = 0 to 1410  step + 30
                                dim ihour, imin
                                if irun > 0 and irun mod 60 = 0 then
                                    ihour =  irun / 60 
                                    imin = 0
                                 elseif    irun > 0 and irun mod 60 > 0  then
                                    ihour = ( irun -  ( irun mod 60) ) / 60 
                                    imin = 30
                                  else
                                    ihour  = 0 
                                    imin = 0
                                  end if
                                  if ihour = 0 and imin  = 0 then
                                      hhmm = "00:00"
                                  else
                                       if  ihour < 10 then
                                        hhmm = "0" & ihour
                                       else
                                        hhmm = ihour
                                       end if
                                       hhmm= hhmm & ":" 
                                        if  imin < 10 then
                                        hhmm =hhmm &  "00"
                                       else
                                        hhmm =hhmm &  imin
                                       end if
                                  end if
                                    
                               %>
                                <option value="<%=hhmm %>"><%=hhmm %></option>
                        <%
                            next %>
                        

                    </select>
                    </div>
                     <div class="form-group col-md-4 col-xs-5">
                        <label for="input-Date">&nbsp;</label>                    
                       
                    </div>
                </div>
                <div class="form-group">
                    <label for="input-Date">Comments</label>
                    <textarea  class="form-control" id="txtComment" placeholder="Comments" rows="6" cols="10"></textarea>
                </div>
                <div class="form-group" id="listitemincart">
                    <div class="row">
                        <div class="col-md-1 col-xs-1">
                            <i class="fa">&#xf022;</i>
                        </div>
                        <div  class="col-md-11 col-xs-11">
                            <label  style='color:darkolivegreen ;'>You can add food to your table booking by putting dishes in your shopping-basket and then clicking on the 'book a table' link again.</label>
                         </div>
                    <div></div>
                </div>
            </div>
            <div class="modal-footer">
                <a href="#" data-dismiss="modal" class="btn btn-default">Cancel</a>
                <a href="#"  class="btn btn-primary" onclick="submitBooking();">Submit</a>
             
            </div>
         
        </div>
    </div>
</div>
 </div>
   
<div id="loginModal" class="modal fade">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                ×</button>
                <h4>Login</h4>
                
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="input-user-name">User Name</label>
                    <input type="text" class="form-control" id="input-user-name" placeholder="User Name">
                </div>
                <div class="form-group">
                    <label for="input-password">Password</label>
                    <input type="text" class="form-control" id="input-password" placeholder="Password">
                </div>
            </div>
            <div class="modal-footer">
                <a href="#" data-dismiss="modal" class="btn btn-default">Cancel</a>
                <a href="#" data-dismiss="modal" class="btn btn-primary">Login</a>
            </div>
        </div>
    </div>
</div>
<!-- End Login Modal -->

<!-- Begin reviews Modal -->

<div id="reviewsModal" class="modal fade">
    <div class="modal-dialog modal-md">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                ×</button>
                <h4>Reviews</h4>

            </div>
            <div class="modal-body">
                <div class="product-line "  name="437" parent="0">
                    <!--Menu Item Name-->


                    <div class="product-line__content-left" style="border-top: 0;">
                        <div class="d-flex-center d-flex-start">

                            <div class="product-line__number"> 02.</div>


                            <div class="product-line__description desc ">
                                Prawn Coctail 
                                <div class="rating" style="display:inline-block;">
                                    <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                                    <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                                    <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                                    <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                                    <span class="glyphicon glyphicon-star-empty" aria-hidden="true"></span>
                                </div>


                            </div>
                        </div>
                    </div>


                    <!--Propertyname and Price-->
                    <!--<div style="width:30%;float:left;">-->
                    <!--PropertyName-->
                    <div class="product-line__content-right " style="border-top: 0;">
                        <div class="d-flex-center d-flex-end">
                            <div class="product-line__property-name"></div>

                            <div class="product-line__price"><b>£3.70</b></div>

                        </div>
                    </div>
                    <!--End Add to cart-->


                </div>

                 <div class="product-line " name="437" parent="0">
                    <!--Menu Item Name-->


                    <div class="product-line__content-left">
                        <div class="d-flex-center d-flex-start">

                            <div class="product-line__number"> 02.</div>


                            <div class="product-line__description desc ">
                                Prawn Coctail 
                                <div class="rating" style="display:inline-block;">
                                    <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                                    <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                                    <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                                    <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                                    <span class="glyphicon glyphicon-star-empty" aria-hidden="true"></span>
                                </div>


                            </div>
                        </div>
                    </div>


                    <!--Propertyname and Price-->
                    <!--<div style="width:30%;float:left;">-->
                    <!--PropertyName-->
                    <div class="product-line__content-right ">
                        <div class="d-flex-center d-flex-end">
                            <div class="product-line__property-name"></div>

                            <div class="product-line__price"><b>£3.70</b></div>

                        </div>
                    </div>
                    <!--End Add to cart-->


                </div>

                 <div class="product-line " name="437" parent="0">
                    <!--Menu Item Name-->


                    <div class="product-line__content-left">
                        <div class="d-flex-center d-flex-start">

                            <div class="product-line__number"> 02.</div>


                            <div class="product-line__description desc ">
                                Prawn Coctail 
                                <div class="rating" style="display:inline-block;">
                                    <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                                    <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                                    <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                                    <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                                    <span class="glyphicon glyphicon-star-empty" aria-hidden="true"></span>
                                </div>


                            </div>
                        </div>
                    </div>


                    <!--Propertyname and Price-->
                    <!--<div style="width:30%;float:left;">-->
                    <!--PropertyName-->
                    <div class="product-line__content-right ">
                        <div class="d-flex-center d-flex-end">
                            <div class="product-line__property-name"></div>

                            <div class="product-line__price"><b>£3.70</b></div>

                        </div>
                    </div>
                    <!--End Add to cart-->


                </div>

                 <div class="product-line " name="437" parent="0">
                    <!--Menu Item Name-->


                    <div class="product-line__content-left">
                        <div class="d-flex-center d-flex-start">

                            <div class="product-line__number"> 02.</div>


                            <div class="product-line__description desc ">
                                Prawn Coctail 
                                <div class="rating" style="display:inline-block;">
                                    <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                                    <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                                    <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                                    <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                                    <span class="glyphicon glyphicon-star-empty" aria-hidden="true"></span>
                                </div>


                            </div>
                        </div>
                    </div>


                    <!--Propertyname and Price-->
                    <!--<div style="width:30%;float:left;">-->
                    <!--PropertyName-->
                    <div class="product-line__content-right ">
                        <div class="d-flex-center d-flex-end">
                            <div class="product-line__property-name"></div>

                            <div class="product-line__price"><b>£3.70</b></div>

                        </div>
                    </div>
                    <!--End Add to cart-->


                </div>
            </div>     
            <div class="modal-footer">
                <a href="#" data-dismiss="modal" class="btn btn-primary">Close</a>
            </div>       
        </div>
    </div>
</div>
<!-- End reveiws Modal -->
      
    <div id="FilterModal" class="modal fade">
    <div class="modal-dialog modal-md">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                ×</button>
                <h4>Filter</h4>

            </div>
            <div class="modal-body">
                
      <% if StrAllergen & "" <> "" then
                    dim arrStrAllergen : arrStrAllergen = split(StrAllergen,"[**]")
                    dim indexAllergen : indexAllergen = 0
                    dim AllergenID,AllergenName,AllergenIcon,AllergenType
                  %> 
                <style>
.span-icon br {
  display: none;
}
.eicon-list.eicon-list li {
    width: auto;
    margin-bottom: 0;
    padding-top: 6px;
    padding-bottom: 6px;
    position: relative;
}

.span-icon img {
  margin-right: 3px;
}
.icon-check.glyphicon-remove {
  color: red;
}
.icon-check.glyphicon-ok {
  color: green;
}
.eicon-list .icon-check {
    top: 10px;
    left: 8px;
    right: auto;
    position: absolute;
    font-size: 18px;
    
}
/* <span class="glyphicon glyphicon-remove icon-check icon-check--remove"></span> */
t-action.list-action {
  margin-bottom: 0;
  height: 37px;
  display: inline-flex;
  align-items: center;
}
.list-action .fa {
  margin-right: 9px;
  font-size: 22px;
  color: black;
}
.mt-20 {
  margin-top: 20px;
}
.mb-5 {
  margin-bottom: 5px;
}
.list-collapse .will-hide {
  display: none;
}
.eicon-list.eicon-list {
  padding-left: 15px;
  padding-right: 15px;
  background-color: whitesmoke;
}
.bootstrap-select-wrapper.bootstrap-select-wrapper,
.dishproperties .bootstrap-select {
  padding: 0;
}
.bootstrap-select-wrapper.bootstrap-select-wrapper .dropdown-toggle,
.dishproperties .dropdown-toggle {
  width: 100%;
}

.open > .dropdown-menu {
  padding-top: 0;
}
.dropdown-menu.dropdown-menu.inner {
  position: relative;
  float: none;
  min-width: auto;
  border: 0;
  top: 100%;
  background: #ffffff;
}
.row-md-flex{
    margin-left: 0;
    margin-right: 0;
}
@media only screen and (min-width: 768px){
    .row-md-flex{
        display: flex;
        margin-left: 0;
        margin-right: 0;
        align-items: flex-start;
    }
    .flex-md-auto{
        flex: 0 0 auto;
        width: auto;
        float: none;
        width: 108px;
        padding-left: 0;
        padding-right: 0;
        padding-top: 6px;
    }
    .flex-md-expand{
        flex: 1;
        width: auto;
        float: none;
       
    }
}
@media only screen and (min-width: 768px) and (max-width: 991px){
    .flex-md-auto{
         width: 118px;
    }
}
/*task 263 */
.bootstrap-select.w-select{
width: calc(100% - 20px);
}

.tooltip .tooltip-inner{
   width: auto;
  max-width: 100%;
  padding-top:5px;
  padding-bottom: 5px;
  text-align: left;
  font-size: 12px;
}
.tip{
  color: #fec752;
} 
.tip-allergen{margin-left:10px;}

.pr-0{padding-right: 0px !important;}
.pl-0{padding-left: 0px !important;}
.d-flex{display: flex;border-bottom:1px dotted #d4d4d4;}
.mr-5{margin-right:5px}
.ml-5{margin-left:5px}
.ml-auto{margin-left: auto;}

.dishproperties .dropdown-menu.dropdown-menu.inner{
    min-width: 288px !important;
}

.dishproperties .dropdown-menu > li > a{
    padding: 3px 10px;
}

.toggle__input-main {
    -webkit-appearance: none;
    position: absolute;
    width: inherit;
    height: inherit;
    opacity: 0;
    left: 0;
    top: 0;
}

.toggle__input-main:checked+.toggle__label {
    padding-left: 33px;
}

.toggle__input-main:checked+.toggle__label:before {
    content: attr(data-on);
    left: 1px;
    top: 1px;
}

.toggle__input-main:checked+.toggle__label:after {
    margin: 1px;
}

.toggle__label {
    cursor: pointer;
    display: inline-block;
    position: relative;
    height: 25px;
    width: 58px;
    font-size: 10px;
    font-weight: 600;
    line-height: 20px;
    text-align: center;
    text-transform: uppercase;
    font-family: Helvetica,Arial,sans-serif;
    -webkit-transition: .3s ease-out;
    -moz-transition: .3s ease-out;
    -o-transition: .3s ease-out;
    transition: .3s ease-out;
    border-radius: 13px;
    margin-bottom: 0;
}

.toggle__label:before {
    width: 33px;
    content: attr(data-off);
    position: absolute;
    top: 1px;
    right: 3px;
}

.toggle__label:after {
    content: "�";
    width: 19px;
    height: 19px;
    margin: 1px;
    font: 20px/20px Times,Serif;
    display: block;
    -webkit-border-radius: 13px;
    -moz-border-radius: 13px;
    -o-border-radius: 13px;
    border-radius: 13px;
}

.toggle_transparent-white .toggle__label {
    border: 1px solid #fff;
}

.toggle_white .toggle__label {
    background: #fff;
    border: 2px solid #fff;
}

.toggle__text_red .toggle__label {
    color: #bb2021;
}

.toggle__text_pink .toggle__label {
    color: #cd0040;
}

.toggle__text_black .toggle__label {
    color: #000;
}

.toggle__after_red .toggle__label:after {
    color: #bb2021;
    background: #bb2021;
}

.toggle__after_orange .toggle__label:after {
    color: #f25c2a;
    background: #f25c2a;
}

.toggle__after_green .toggle__label:after {
    color: #018000;
    background: #018000;
}

.toggle__after_pink .toggle__label:after {
    color: #cd0040;
    background: #cd0040;
}

.toggle__after_black .toggle__label:after {
    color: #000;
    background: #000;
}

.toggle__after_white .toggle__label:after {
    color: #fff;
    background: #fff;
}

.filter-may {
    display: table;
    padding-bottom: 10px;
    padding:6px;
    margin-bottom:10px;
    background-color:#e4e3e3;
}

.filter-may__toggle {
    display: table-cell;
    vertical-align: middle;
    padding-right: 10px;
}

.filter-may__text {
    display: table-cell;
    vertical-align: middle;
    padding-right: 10px;
    font-size: 14px;
}

.filter-may_w100 {
    width: 100%;
}

.filter-may__min-width260 {
    min-width: 260px;
}
.glyphicon-filtered {
    color: orange!important;
    border: 1px dotted;
}
@media (max-width: 767px) {
  .dishproperties__heading {
    padding-top:15px;
  }
}
.dropdown-menu > li > a:focus {
    outline: 0;
}

.tooltip-inner.tooltip-inner{   background-color: #fff;   color: #000;padding-top:0px;   border: 1px solid #000;}
.list-expand .hidden-xs{ display: inline-block !important;;}
.tooltip {  font-weight: bold;}
.tooltip .tooltip-custom{  font-weight: initial;}
@media (max-width: 767px) { .more.more{   display: inline-block !important;   cursor: pointer; }}.list-expand .more{   display: none !important; }

@media (max-width: 767px) {
    .previous-order-heading{margin-top: 15px;border-bottom: 0;}
}
.previous-order-heading .product-line-heading{margin-top:0;margin-bottom: 0;}
    </style>
              

                
                <!--<script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>-->
                
    <div class="row row-md-flex mt-20">
             
            <% if ucase(EnableAllergen & "") = "YES" then %>
            <div class="col-sm-3 flex-md-auto mb-5">Select without:</div>
             
            <ul class="eicon-list flex-md-expand col-sm-9 ng-scope list-inline" id="allergenlist">
                <li>
                    <div class="filter-may">
                        <div class="filter-may__text" data-bind="text:$root.staticResources().filterMayContain">Exclude dishes that "may contain" selected allergens</div>
                        <div class="toggle toggle_white toggle__after_orange toggle__text_black filter-may__toggle prn">
                            <input class="toggle__input-main"
                                    id="filter-may"
                                    name="filter-may"
                                    type="checkbox"
                                    value="true"
                                    checked="checked" data-bind="checked: includeMayValue" />
                            <label for="filter-may" data-on="YES" data-off="NO" class="toggle__label"></label>
                            <input type="hidden" value="false" name="filter-may" class="toggle__input-helper">
                        </div>
                    </div>
                </li>
                <% 
                    dim allergenline : allergenline = 1
                    dim classwillhide
                    for indexAllergen = 0 to ubound(arrStrAllergen)
                        if arrStrAllergen(indexAllergen) & "" <> "" then
                            AllergenID = split(arrStrAllergen(indexAllergen),"|")(0)
                            AllergenName = trim( split(arrStrAllergen(indexAllergen),"|")(1))
                            AllergenIcon = split(arrStrAllergen(indexAllergen),"|")(2)
                            AllergenType = split(arrStrAllergen(indexAllergen),"|")(3)
                                    if trim(AllergenType & "") = "Allergen" then    
                                        classwillhide = ""
                                         
                                        if allergenline >= 4 then
                                            classwillhide = "hidden-xs"
                                        end if
                                             
                                            
                            %>
                                <li class="<%=classwillhide %>"  onclick="SearchAllergen(this,'Allergen','filter_<%=AllergenID %>')">                                    
                                    <span class="span-icon">                                        
                                        <img  id="filter_<%=AllergenID %>"  width="25" src="<%=SITE_URL %>Images/allergen/png/<%=replace(trim(AllergenIcon & ""),"amber","red") %>" alt="<%=AllergenName %>" title="  <%=AllergenName %>"/>   <br />                                  
                                        <span class="icon-name" style="color:black;"><%=AllergenName %></span>
                                    </span>
                                    
                                </li>
                            <%
                                allergenline = allergenline +1
                                end if
                        end if
                    next
                     %>
                        <% if allergenline >= 4 then %>
                        
                        <li class="visible-xs more" onclick="$(this).closest('#allergenlist').addClass('list-expand');">
                            <span class="more-vert" style="height: 18px;line-height: 18px;width: 18px;vertical-align: text-bottom;display: inline-block;"><svg focusable="false" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M12 8c1.1 0 2-.9 2-2s-.9-2-2-2-2 .9-2 2 .9 2 2 2zm0 2c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2zm0 6c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2z"></path></svg></span>More
                        </li>
                        <%end if %>
                                
            </ul>
            <%end if %>
       
        </div>
  
     <div class="row row-md-flex"> 
                <% if ucase(EnableSuitableFor & "") = "YES" then %>
                        <div class="col-sm-3 flex-md-auto mb-5">Suitable for:</div>
                        <ul class="eicon-list flex-md-expand col-sm-9 ng-scope list-collapse list-inline" id="suitableforlist">
                <% 
                     allergenline = 1
                     
                    for indexAllergen = 0 to ubound(arrStrAllergen)
                        if arrStrAllergen(indexAllergen) & "" <> "" then
                            AllergenID = trim(split(arrStrAllergen(indexAllergen),"|")(0))
                            AllergenName = trim(split(arrStrAllergen(indexAllergen),"|")(1))
                            AllergenIcon = split(arrStrAllergen(indexAllergen),"|")(2)
                            AllergenType = split(arrStrAllergen(indexAllergen),"|")(3)
                                    if trim(AllergenType & "") = "SuitableFor" then 
                                         classwillhide= ""   
                                         if allergenline >= 3 then
                                            classwillhide = "hidden-xs"
                                        end if     
                            %>
                                <li class="<%=classwillhide %>" onclick="SearchAllergen(this,'SuitableFor','filter_<%=AllergenID %>')">
                                    <span class="span-icon">
                                        <img id="filter_<%=AllergenID %>" width="25" src="<%=SITE_URL %>Images/allergen/png/<%=trim(AllergenIcon & "")%>"  alt="<%=AllergenName %>" title="  <%=AllergenName %>" />                                        
                                          <br />    <span class="icon-name" style="color:black;"><%=AllergenName %></span>
                                    </span>
                                     
                                </li>
                            <%  
                                allergenline = allergenline +1
                                end if
                        end if
                    next
                     %>
                             <% if allergenline > 3 then %>
                        
                            <li class="visible-xs more" onclick="$(this).closest('#suitableforlist').addClass('list-expand');">
                            <span class="more-vert" style="height: 18px;line-height: 18px;width: 18px;vertical-align: text-bottom;display: inline-block;"><svg focusable="false" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M12 8c1.1 0 2-.9 2-2s-.9-2-2-2-2 .9-2 2 .9 2 2 2zm0 2c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2zm0 6c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2z"></path></svg></span>More
                        </li>
                        <%end if %>
            </ul>
             <%end if %>
      </div>
     <% end if %>
                 <% if  announcement_Filter & "" <> "" then %>
                <div class="announmentinmenu" style="margin-bottom:20px;"><p><%=replace(replace(announcement_Filter,vbCrLf,"<BR>"),"'","\'")  %></p></div>
            <% end if %>
            </div>     
           
         
            <div class="modal-footer">

               <a href="#"  onclick="ClearFilter();" class="btn btn-primary">Clear Filters</a> 
               <a href="#" data-dismiss="modal" onclick="Filter();" class="btn btn-primary">Continue</a>
            </div>       
        </div>
    </div>
</div>

    <input type="hidden" value="<%=isopen %>"  name ="sisopen" />
<script type="text/javascript">
    $(window).load(function() {
        $(".loader").fadeOut("slow");
        $("#wholepage").show();
	
    })
</script>

<script  src="<%=SITE_URL %>scripts/addtohomescreen.js?v=2"></script>
<script type="text/javascript" >
addToHomescreen();
</script>

	


<%if request.querystring("postcode")<>"" then%>
<script>
$(document).ready(function(){
$("#validate_pc").val("<%=request.querystring("postcode")%>");
CheckDistance();

    $("select [name='p_hour']").bind("changed",function(){StoreToC(this,"p_hour");});



  });


</script>
<%end if%>


  <script>
      
    var tempBeforeOrderHTML = '';
    function StoreCookieDelivery()
    {
        StoreToC($("#OrderDateBox"),"OrderDate");
        StoreToC($("[name=p_hour]"),"p_hour");

        
    }
    function LoadDesktop()
    {
            
          if($('#beforeorder').html()!=""){
              tempBeforeOrderHTML = $('#beforeorder').html();
              tempBeforeOrderHTML += '<button type="button" id="placeOrderBack" onclick="javascript:$(\'#modalDivOrderType\').modal(\'hide\');" class="btn btn-primary" style="float:left;margin-left:10px;padding:8px;"> <span class="glyphicon glyphicon-chevron-left"></span>Back to Menu</button>';
              tempBeforeOrderHTML += '<button type="button" id="placeOrderContinue" onclick="CheckOrder(\'submit\');" class="btn btn-success" style="width: 80px; padding: 8px; float:right;">Continue</button>';
              tempBeforeOrderHTML += '<div style="clear:both;" id="placeOrdeClear"></div>';
              $("#modalDivOrderTypeBody").html(tempBeforeOrderHTML);
              $('#beforeorder').html('');
              InitCollectionDelivery();    
              InitCollectionDelivery2();
               $("#butcontinue").unbind("click");
               $("#butcontinue").bind("click",function(){
                  
                      CheckOrder('confirm');  
               });
                $("#btnPlaceOrder button").unbind("click");
                $("#btnPlaceOrder button").bind("click",function(){
                    CheckOrder('confirm');  
                });
                if(typeof AutocompleteFNC !== "undefined")
                    AutocompleteFNC();
                registerlistener();
        }
    }
    var screenmode = "deskstop";
    
    function detechScreen()
    {
        if($(window).width() <=992 && screenmode=="deskstop"){
                $("[data-type='group-cate']").each(function(){
                    $(this).hide();
                    $(this).prev().find(".product-line-heading__icon").addClass("arrow-icon-down").removeClass("arrow-icon-up");
                });
                
                screenmode= "mobile";
                scrollMobile();
                
       }else if($(window).width() > 992 && screenmode=="mobile"){
                $("[data-type='group-cate']").each(function(){
                    $(this).show();
                    $(this).prev().find(".product-line-heading__icon").addClass("arrow-icon-up").removeClass("arrow-icon-down");
                });
                screenmode= "deskstop";
        }
    }
    
    function LoadMobile()
    {
        //$('#modalDivOrderType').modal('hide');
        if($('#beforeorder').html()=='' && $("#modalDivOrderTypeBody").html() !='')
        {
            $("#placeOrderContinue").remove();
            
            $("#placeOrderBack").remove();
            $("#placeOrderClear").remove();
            $('#beforeorder').html($("#modalDivOrderTypeBody").html());
            $("#modalDivOrderTypeBody").html('');
        }
        InitCollectionDelivery();    
        InitCollectionDelivery2();
        $("#butcontinue").unbind("click");
        $("#butcontinue").bind("click",function(){          
                 CheckOrder('submit');  
        });

        $("#btnPlaceOrder button").bind("click",function(){
                
                CheckOrder('submit');  
        });
        if(typeof AutocompleteFNC !== "undefined")
             AutocompleteFNC();
        registerlistener();
         LoadTimes();
       
        $("[name=orderTypePicker]:checked").trigger("click");
        
    
        if(disabledelivery == "Yes" || disablecollection =="Yes")
            $("[name=ordertimeoverride]").removeAttr("checked"); 
        ismobileSelected = false;
    }
   $(window).on('resize', function () {
        detechScreen();
    });     
  
    function registerlistener()
    {
         $("#validate_pc").keydown(function(e) {
            $('#modalDivOrderTypeBody #input-group-pc').css('border', 'none');
           if(!$("#DeliveryDistance").find('.tooltip').hasClass('in'))
                $("#updateFullPostcodeSubmit").tooltip({trigger: 'manual'}).tooltip('show');    
          if (e.keyCode == 13 || e.which ==13) {
                $("#hidLat").val('');
                $("#hidLng").val('');
               $("#updateFullPostcodeSubmit").trigger("click");
                 e.preventDefault();
            }
         
        });     
     $("#validate_pc").change(function() {
        ismobileSelected = true;
         $('#modalDivOrderTypeBody #input-group-pc').css('border', 'none');   
         if(isSetLatLng) isSetLatLng =false;
         else{
             $("#hidLat").val('');
             $("#hidLng").val('');    
            }
         
          
        });    
    }
      
      function scrollMobile()
        {
            $(window).scroll(function(){
                  var heightextend = 0;
                    if($(".banner").length > 0) heightextend+=$(".banner").height();
                    if($(".announmentinmenu").length > 0) heightextend+=$(".announmentinmenu").height();
                    if($("#topmenumobile").length > 0) heightextend+=$("#topmenumobile").height();
                  if($(window).scrollTop()>80 + heightextend)
		            {
			           // $("#topmenumobile").hide();
                       var menuWidth = $('.menu-bar-wrapper').width();
                       $('.menu-bar-wrapper').css('width',menuWidth);
                        $('.menu-bar-wrapper').addClass('fix-header');
                        
                        $(".fake-header").show();
                        $(".announmentinmenu").hide();

		            }
		            else
		            {  // $("#topmenumobile").show();
                        $('.menu-bar-wrapper').removeClass('fix-header');
                        $('.menu-bar-wrapper').css('width','auto');
			            $(".fake-header").hide();
                        $(".announmentinmenu").show();
	                }
	        });
 
           
        }
      $(document).ready(function(){
        
          if($(window).width() <=992){
             scrollMobile();
             LoadMobile();
             

              $("[data-type='group-cate']").each(function(){
                    $(this).hide();
                    $(this).prev().find(".product-line-heading__icon").addClass("arrow-icon-down").removeClass("arrow-icon-up");
                });
                
                screenmode= "mobile";
            setTimeout(function(){
                            $("[name=orderTypePicker]:checked").trigger("click");
                },200);
            }else{
             LoadDesktop();
              $("[data-type='group-cate']").each(function(){
                    $(this).show();
                    $(this).prev().find(".product-line-heading__icon").addClass("arrow-icon-up").removeClass("arrow-icon-down");
                });
                screenmode= "deskstop";
          }
            <% if IsCloseRestaurant = true then %>
                    $("#butcontinue").unbind("click");
                    $("#butcontinue").bind("click",function(){
                        return false; 
                    });
                    $("#butcontinue").hide();
                    $("#basket").hide();
                    $("#idOpenHour").hide();            
                    $("#closeRest").show();
           <% elseIf Not isopen then %>
                $("#ClosedModal").modal();
                <%if sorderonlywhenopen=1 then%>
                    $("#butcontinue").unbind("click");
                    $("#butcontinue").bind("click",function(){
                        return false; 
                    });
                    $("#butcontinue").hide();
                    $("#basket").hide();
                    $("#idOpenHour").hide();            
                    $("#noorders").show();
                  
                <%end if%>
           
            <% End If %>

      });

       

      function GetOpeningTimeExt(currenttime,dt1Day,mode)
        {
            var minTime =0,maxTime=0;
            var opentime = new Date();

             for (key in jsDate) {
                    if (jsDate[key].d==dt1Day) {
                        var openMinTime = jsDate[key].min ;
                         var openMaxTime = jsDate[key].max ;
                     
                        if(openMaxTime <  openMinTime)
                                openMaxTime = openMaxTime + 24 * 60 * 60000;
                         if(mode=="d" && jsDate[key].delivery=="y" ){
                            if( currenttime < jsDate[key].min && minTime == 0  ){
                                       minTime =  jsDate[key].min;
                                       maxTime =  jsDate[key].max;
                             }
                            if(currenttime > openMinTime && currenttime < openMaxTime  )
                            {
                                   minTime  = jsDate[key].min;
                                   maxTime =  jsDate[key].max;
                            }
                        }else if(mode == "c" && jsDate[key].collection=="y") 
                        {
                              if( currenttime < jsDate[key].min && minTime == 0  ){
                                       minTime =  jsDate[key].min;
                                       maxTime =  jsDate[key].max;
                             }    
                             if(currenttime > openMinTime && currenttime < openMaxTime )
                            {
                                   minTime  = jsDate[key].min;
                                   maxTime =  jsDate[key].max;
                            }      
                        }
                    }
                }
        // check Previous day
        dt1Day = dt1Day -1;
        if(dt1Day==0) dt1Day = 7;
          for (key in jsDate) {
                if (jsDate[key].d==dt1Day) {
                     if(openMaxTime <  openMinTime){
                        var openMinTime = jsDate[key].min ;
                        var openMaxTime = jsDate[key].max ;
                         if(mode=="d" && jsDate[key].delivery=="y" ){
                                 if(currenttime > openMinTime && currenttime < openMaxTime)
                                    {
                                   minTime  = jsDate[key].min;
                                   maxTime =  jsDate[key].max;
                                     }
                         }else if(mode == "c" && jsDate[key].collection=="y") 
                        {
                                 if(currenttime > openMinTime && currenttime < openMaxTime)
                                    {
                                   minTime  = jsDate[key].min;
                                   maxTime =  jsDate[key].max;
                                    }
                       }
                    }
                }
          }
        if(minTime > 0 && maxTime > 0)
             opentime.setTime(minTime);
        else 
            return null;

        return opentime;
        
        }
    
   function GetOpeningTimePrev(currenttime,dt1Day)
    {
        var minTime =0,maxTime=0;
        var opentime = new Date();
        var MinDateTime = new Date();
            MinDateTime = Date.parse('01/01/2011 ' + '00:00:01') ; 
        var MaxDateTime = new Date();
        dt1Day = dt1Day-1;
        if(dt1Day==0) dt1Day=7

        for (key in jsDate) {
            if (jsDate[key].d==dt1Day) {
                maxTime = jsDate[key].max;
                minTime = MinDateTime.getTime();
            }
        }
        

    if(minTime > 0 && maxTime > 0)
         opentime.setTime(minTime);
    else
        return null;
    return opentime;
        
    }
    function GetOpeningTime(currenttime,dt1Day)
    {
        var minTime =0,maxTime=0;
        var opentime = new Date();

         for (key in jsDate) {
                if (jsDate[key].d==dt1Day) {
                    var openMinTime = jsDate[key].min ;
                     var openMaxTime = jsDate[key].max ;
                     
                    if(openMaxTime <  openMinTime)
                            openMaxTime = openMaxTime + 24 * 60 * 60000;
                     if( currenttime < jsDate[key].min && minTime == 0 
                                 && (jsDate[key].delivery=="y" ||  jsDate[key].collection=="y") ){
                                   minTime =  jsDate[key].min;
                                   maxTime =  jsDate[key].max;
                     }
                     if(currenttime > openMinTime && currenttime < openMaxTime && (jsDate[key].delivery=="y" ||  jsDate[key].collection=="y") )
                            {
                                   minTime  = jsDate[key].min;
                                   maxTime =  jsDate[key].max;
                            }
                }
            }
        
    if(minTime > 0 && maxTime > 0)
         opentime.setTime(minTime);
    else
         return null;   
    
    return opentime;
        
    }
    function GetOrderAcceptFor(currenttime,dt1Day,delivery_type)
      {
            var offsetmins;
           if (delivery_type == 'd') {
                offsetmins=$('#deliverydelay').val();
            } else {
                offsetmins=$('#collectiondelay').val();
            }
        
      if(dt1Day==0)dt1Day=7;
        var result = -1;
         for (key in jsDate) {
                if (jsDate[key].d==dt1Day) {
                            var openMinTime = jsDate[key].min ;
                     var openMaxTime = jsDate[key].max ;
                        if(openMaxTime < openMinTime)
                            openMaxTime = openMaxTime + 24 * 60 * 60000;
                        if(delivery_type=="d" && jsDate[key].delivery == "y"){
                            if(currenttime >= openMinTime + offsetmins * 60000  && currenttime <= openMaxTime )
                                result = jsDate[key].minacceptorderbeforeclose;
                        }else if(delivery_type=="c" && jsDate[key].collection == "y"){
                            if(currenttime   >= openMinTime + offsetmins * 60000 && currenttime <= openMaxTime )
                                result = jsDate[key].minacceptorderbeforeclose;
                        }
                }
        }
      // second check previous day
      dt1Day  =dt1Day -1;
      if(dt1Day==0)dt1Day=7;
      if(result==-1){
       for (key in jsDate) {
                if (jsDate[key].d==dt1Day) {
                            var openMinTime = jsDate[key].min ;
                     var openMaxTime = jsDate[key].max ;
                       if(openMaxTime < openMinTime)
                        {
                            currenttime  =currenttime + 24 * 60 * 60000;
                            openMaxTime = openMaxTime + 24 * 60 * 60000;
                            if(currenttime >= openMinTime && currenttime <= openMaxTime )
                                result = jsDate[key].minacceptorderbeforeclose;
                            }
                        } 
                        
                }
         }
      

        return result;
      }
    function GetMin_Max_Expexted_Time(currenttime,mode,delay,dt1Day)
    {
        var result = "";
        var minTime = 0;
        var maxTime = 0;
        var opentime = new Date();
      var previousmintime,previousmaxtime
          for (key in jsDate) {
                if (jsDate[key].d==dt1Day) {
                     var openMinTime = jsDate[key].min ;
                     var openMaxTime = jsDate[key].max ;
                        
                        if(openMaxTime <  openMinTime)
                            openMaxTime = openMaxTime + 24 * 60 * 60000;
                       
                        if(mode=="d"){
                             if(jsDate[key].delivery == "y")
                                {
                                    if(openMinTime== previousmaxtime)
                                    {
                                      openMinTime =   previousmintime 
                                    }
                                    previousmintime = openMinTime;
                                    previousmaxtime = openMaxTime;
                                }
                             //var isLessThanMin  = (currenttime >= openMinTime && currenttime <= openMaxTime );
                            /*|| (currenttime >= openMinTime && currenttime <= openMaxTime ) */ 
                            if(currenttime >= openMinTime && currenttime <= openMaxTime
                                    && jsDate[key].delivery =="y"
                                    && minTime == 0)
                            {
                                   minTime =  openMinTime;
                                   maxTime =  openMaxTime;
                                   if((minTime + delay * 60000) <= maxTime){
                                       minTime = 0;
                                       maxTime = 0;
                                       break; 
                                    }
                                    
                                    minTime = 0;
                                    maxTime = 0;
                                     
                            }
                            else if(( (currenttime < openMinTime) ) 
                                && jsDate[key].delivery =="y"
                                && minTime == 0){
                                   minTime =  openMinTime;
                                   maxTime =  openMaxTime;
                                   if((minTime + delay * 60000) <= maxTime)
                                       minTime =   minTime + delay * 60000  ;
                                    else {
                                       minTime = 0;
                                       maxTime = 0;
                                    } 
                                  
                            }
                        }else
                        {
                            /*|| (currenttime >= openMinTime && currenttime <= openMaxTime )*/
                            if(jsDate[key].collection == "y")
                                {
                                    if(openMinTime== previousmaxtime)
                                    {
                                      openMinTime =   previousmintime 
                                    }
                                    previousmintime = openMinTime;
                                    previousmaxtime = openMaxTime;
                                }
                        if(currenttime >= openMinTime && currenttime <= openMaxTime 
                                    && jsDate[key].collection =="y" 
                                    && minTime == 0 )
                            {
                                   minTime =  openMinTime;
                                   maxTime =  openMaxTime;
                                   if((minTime + delay * 60000) <= maxTime){
                                       minTime = 0;
                                       maxTime = 0;
                                       break; 
                                    }
                                   
                                    minTime = 0;
                                    maxTime = 0;
                                  
                            }   
                        else if(( (currenttime < openMinTime ) ) 
                                && jsDate[key].collection =="y"
                                && minTime == 0){
                               minTime =  openMinTime;
                               maxTime =  openMaxTime;
                               if((minTime + delay * 60000) <= maxTime)
                                   minTime =   minTime + delay * 60000  ;
                                else {
                                   minTime = 0;
                                   maxTime = 0;
                                } 
                                
                            }
                            
                        }

                }
            }
       
        if(minTime > 0 && maxTime > 0)
            opentime.setTime(minTime);
        else
            return null;
        return opentime;
      
    }
        var minuteCDefault = 0;
      var minuteDDefault = 0;
    function InitCollectionDelivery(){
    $("select[name='p_hour']").change(function(){StoreToC(this,"p_hour");});

      $("#OrderDateBox").change(function(){StoreToC(this,"OrderDate");LoadTimes();ismobileSelected=true;});
    $("input[name='orderTypePicker']").change(function(){
      ismobileSelected= true;
      if ($("input[name='orderTypePicker']:checked").val() == 'c') {
            console.log("show 6");
            $('#CollectionAddress').show();
        }       
      else {
                $('#CollectionAddress').hide();
                console.log("hide 6");
           }
      StoreToC($("input[name='orderTypePicker']:checked"),"orderTypePicker");
      });
    $("input[name='ordertimeoverride']").change(function(){StoreToC($("input[name='ordertimeoverride']:checked"),"ordertimeoverride");ismobileSelected=true;});

    if( getCookie('orderTypePicker') != '')
        { 
            $("input[name='orderTypePicker'][value='" +getCookie('orderTypePicker') + "']").attr('checked','checked');
            $("input[name='orderTypePicker'][value='" +getCookie('orderTypePicker') + "']").trigger("click");
            if (getCookie('orderTypePicker') == 'c') {
                $('#CollectionAddress').show();
                console.log("show 7");    
                }
            else {
                console.log("hide 7");
                $('#CollectionAddress').hide();
                }
    }else
      {
        if(screenmode=="mobile"){
           if( ( disabledelivery =="Yes" && disablecollection !="Yes")  ||  ( disabledelivery !="Yes" && disablecollection =="Yes")  )
            {
                if(disabledelivery == "Yes")
                    $("input[name='orderTypePicker'][value='c']").attr('checked','checked');
                else if(disablecollection == "Yes") 
                    $("input[name='orderTypePicker'][value='d']").attr('checked','checked');
            }
        }
      }
    if( getCookie('ordertimeoverride') != ''){
         $("input[name='ordertimeoverride'][value='" +getCookie('ordertimeoverride') + "']").attr('checked','checked');
     $("input[name='ordertimeoverride'][value='" +getCookie('ordertimeoverride') + "']").trigger("click");
    }
    if( getCookie('p_hour') != '')
         $("select[name='p_hour']").val(getCookie('p_hour'));

    if( getCookie('OrderDate') != '')
         $("#OrderDateBox").val(getCookie('OrderDate'));
    
    //alert("validate_pc " + getCookie("validate_pc") + " Postcode " +  getCookie("Postcode") );
    
    if(getCookie("validate_pc") != "" &&  ( getCookie("Address") == "" || $("#isChangeExistingAddress").val() == "Y")  ){
         if('<%= lcase(PostCodeDiff) %>' =='false') 
            $("#validate_pc").val(getCookie("validate_pc") ); 
            
           $("#PreFillDistance").html('Delivery Address (<a id=\'aChangeAdress\' style=\'cursor:pointer;\' onclick="OnChangePrefillAddress();$(\'#validate_pc\').val(\'\');$(\'#delivery-info\').html(htmlpostcode);$(\'.delivery_info\').addClass(\'alert-danger\');$(\'.delivery_info\').removeClass(\'alert-success\'); $(\'#showdistance\').html(\'\');$(\'#missingPostcodeAlert\').hide();$(\'.delivery_info\').show(); ">Change</a>)<br/> <span style="font-weight: bold;">' + getCookie("validate_pc") + '.</span>');
           $("#PreFillDistance").show();
        
            CheckDistance();  
            $("#updateFullPostcode").hide();    
    }
    else if( getCookie("Address") != "" && ($("#hidLat").val() == "" || $("#hidLng").val() == "")){       
        var tempAdress = getCookie("Address");
        
        if(getCookie('HouseNumber') != '')
            tempAdress = getCookie('HouseNumber') + ' ' +  tempAdress;
        if(getCookie('Address2') != '') 
            tempAdress = tempAdress + ", " + getCookie('Address2');
        if(getCookie('Postcode') != '') 
            tempAdress = tempAdress + ", " + getCookie('Postcode');
        tempAdress = tempAdress.replace(/\+/g,' ');
        tempAdress = unescape(tempAdress);
        
       // $("#validate_pc").val(getCookie('Postcode'));
       if( getCookie("validate_pc") !="" && typeof getCookie("validate_pc") !="undefined"  && getCookie('Postcode') !="" && '<%= lcase(PostCodeDiff) %>' =='false')
            $("#validate_pc").val(getCookie("validate_pc") );
      else
            $("#validate_pc").val(getCookie('Postcode'));
    

      $("#PreFillDistance").html('Delivery Address (<a id=\'aChangeAdress\' style=\'cursor:pointer;\' onclick="OnChangePrefillAddress();$(\'#validate_pc\').val(\'\');$(\'#delivery-info\').html(htmlpostcode);$(\'.delivery_info\').addClass(\'alert-danger\');$(\'.delivery_info\').removeClass(\'alert-success\'); $(\'#showdistance\').html(\'\');$(\'#missingPostcodeAlert\').hide();$(\'.delivery_info\').show();">Change</a>)<br/> <span style="font-weight: bold;">' + tempAdress + '.</span>');           
            $("#PreFillDistance").show();
            CheckDistance();  
            $("#updateFullPostcode").hide();     
        }
    else{
         $("#PreFillDistance").remove();
         $("#updateFullPostcode").show();
    }
   
    
    var offsetminsD=$('#deliverydelay').val();   
    var offsetminsC=$('#collectiondelay').val();    
    var dt1 = new Date();
       var Close_StartDate_JS ,Close_EndDate_JS;
   
        if('<%=Close_StartDate_JS%>' !='')
            Close_StartDate_JS  = new Date(<%=Year(Close_StartDate_JS)%>, <%=(Month(Close_StartDate_JS)-1)%>, <%=Day(Close_StartDate_JS)%>, 0, 0, 0, 0);
        if('<%=Close_EndDate_JS%>' !='')
            Close_EndDate_JS  = new Date(<%=Year(Close_EndDate_JS)%>, <%=(Month(Close_EndDate_JS)-1)%>, <%=Day(Close_EndDate_JS)%>, 0, 0, 0, 0);

       if(typeof Close_StartDate_JS !="undefined" && typeof Close_EndDate_JS !="undefined")
      {
        if(Close_StartDate_JS.valueOf() <= dt1.valueOf() &&  dt1.valueOf()  <= Close_EndDate_JS.valueOf() )
            return false;
      }
    offsetminsD = parseInt(offsetminsD);
    offsetminsC = parseInt(offsetminsC);
    var dt1Day = dt1.getDay();
    var nextOpeningTime = new Date();
    if (dt1Day == 0) dt1Day = 7;

            if($("[name=PrevStillOpen]").val()=="true"){
                var datemin =Date.parse('01/01/2011 00:00') ; 
                nextOpeningTime.setTime(datemin);
                }
            else
                nextOpeningTime = GetOpeningTime(currenttime,dt1Day);

    if(nextOpeningTime !=null && (dt1.getHours() < nextOpeningTime.getHours() || (dt1.getHours() == nextOpeningTime.getHours() && dt1.getMinutes() < nextOpeningTime.getMinutes())) ){
        
        var newTime = new Date();
        newTime.setTime(nextOpeningTime.getTime() );
        var timeString = '';
        var minStr = '';   
        newTime.setTime(nextOpeningTime.getTime());
        timeString = '';
       
        if(newTime.getMinutes() < 10)
            minStr = '0' + newTime.getMinutes();
        else
            minStr =  newTime.getMinutes();
        if(newTime.getHours() < 12)
            timeString = newTime.getHours() + ":" + minStr + " AM";
        else if(newTime.getHours() == 12)
            timeString = newTime.getHours() + ":" + minStr + " PM";
        else
            timeString = (newTime.getHours()-12) + ":" + minStr + " PM";
        if($("#idOpenHour").length==0) {    
                $('#rightaffix').before('<div id="idOpenHour" class="hidepanel alert alert-warning" style="text-align: center; padding: 7px; display: block;"><b>Opens at: '+ timeString + '</b></div>');       
        }
    }
    var isExpected  = false; 
    // render Expected time for Delivery 
          if($("[name=PreDeliveryOpen]").val()=="true"){
                var datemin =Date.parse('01/01/2011 00:00') ; 
                nextOpeningTime.setTime(datemin);
                }
        else
                nextOpeningTime = GetMin_Max_Expexted_Time(currenttime,"d",offsetminsD,dt1Day);

        if(nextOpeningTime !=null && (CurrentDate != nextOpeningTime.getDate() || ((dt1.getHours() < nextOpeningTime.getHours() || (dt1.getHours() == nextOpeningTime.getHours() && dt1.getMinutes() < nextOpeningTime.getMinutes())))) ){
            isExpected = true;
            ExpectedtimeD = nextOpeningTime;
            var newTime = nextOpeningTime;
            //newTime.setTime(nextOpeningTime.getTime() + offsetminsD * 60000);
            var timeString = '';
            var minStr = '';    
            if(newTime.getMinutes() < 10)
                minStr = '0' + newTime.getMinutes();
            else
                minStr =  newTime.getMinutes();
            if(newTime.getHours() < 12)
                timeString = newTime.getHours() + ":" + minStr + " AM";
            else if(newTime.getHours() == 12)
                timeString = newTime.getHours() + ":" + minStr + " PM";
            else
                timeString = (newTime.getHours()-12) + ":" + minStr + " PM";
        
             $('#DeliveryTimeNowD').html('<b>Expected delivery time: '+ timeString +'.</b> <br />Please proceed with your order');
        }
    // End 
      if(isExpected==false)
        {
         $('#DeliveryTimeNowD').remove();
       
        }
    isExpected  =false;
    // render Expected time for Collection
          if($("[name=PreCollectionOpen]").val()=="true"){
                var datemin =Date.parse('01/01/2011 00:00') ; 
                nextOpeningTime.setTime(datemin);
                }
        else
                nextOpeningTime = GetMin_Max_Expexted_Time(currenttime,"c",offsetminsC,dt1Day);
        if(nextOpeningTime !=null && (CurrentDate != nextOpeningTime.getDate() || (dt1.getHours() < nextOpeningTime.getHours() || (dt1.getHours() == nextOpeningTime.getHours() && dt1.getMinutes() < nextOpeningTime.getMinutes())))  ){
        
            isExpected = true;
            ExpectedtimeC = nextOpeningTime;
            var newTime = nextOpeningTime;
            //newTime.setTime(nextOpeningTime.getTime() + offsetminsC * 60000);
            var timeString = '';
            var minStr = '';    
            if(newTime.getMinutes() < 10)
                minStr = '0' + newTime.getMinutes();
            else
                minStr =  newTime.getMinutes();

            if(newTime.getHours() < 12)
            timeString = newTime.getHours() + ":" + minStr + " AM";
            else if(newTime.getHours() == 12)
            timeString = newTime.getHours() + ":" + minStr + " PM";
            else
            timeString = (newTime.getHours()-12) + ":" +minStr + " PM";
            $('#DeliveryTimeNowC').html('<b>Expected collection time: '+ timeString +'.</b> <br />Please proceed with your order.');
        }
    // End 
    if(isExpected==false)
    {
      
        $('#DeliveryTimeNowC').remove();
    }
    /*
    if(dt1.getHours() < nextOpeningTime.getHours() || (dt1.getHours() == nextOpeningTime.getHours() && dt1.getMinutes() < nextOpeningTime.getMinutes())){
        var newTime = new Date();
        newTime.setTime(nextOpeningTime.getTime() + offsetminsD * 60000);
        var timeString = '';
        var minStr = '';    
        if(newTime.getMinutes() < 10)
            minStr = '0' + newTime.getMinutes();
        else
            minStr =  newTime.getMinutes();
        if(newTime.getHours() < 12)
            timeString = newTime.getHours() + ":" + minStr + " AM";
        else if(newTime.getHours() == 12)
            timeString = newTime.getHours() + ":" + minStr + " PM";
        else
            timeString = (newTime.getHours()-12) + ":" + minStr + " PM";
        
         $('#DeliveryTimeNowD').html('<b>Expected delivery time: '+ timeString +'.</b> <br />Please proceed with your order');
        
        newTime.setTime(nextOpeningTime.getTime() + offsetminsC * 60000);
         timeString = '';
         if(newTime.getMinutes() < 10)
            minStr = '0' + newTime.getMinutes();
        else
            minStr =  newTime.getMinutes();
        if(newTime.getHours() < 12)
            timeString = newTime.getHours() + ":" + minStr + " AM";
        else if(newTime.getHours() == 12)
            timeString = newTime.getHours() + ":" + minStr + " PM";
        else
            timeString = (newTime.getHours()-12) + ":" +minStr + " PM";
         $('#DeliveryTimeNowC').html('<b>Expected collection time: '+ timeString +'.</b> <br />Please proceed with your order.');


        newTime.setTime(nextOpeningTime.getTime());
         timeString = '';
       
        if(newTime.getMinutes() < 10)
            minStr = '0' + newTime.getMinutes();
        else
            minStr =  newTime.getMinutes();
        if(newTime.getHours() < 12)
            timeString = newTime.getHours() + ":" + minStr + " AM";
        else if(newTime.getHours() == 12)
            timeString = newTime.getHours() + ":" + minStr + " PM";
        else
            timeString = (newTime.getHours()-12) + ":" + minStr + " PM";
        if($("#idOpenHour").length==0) {    
                $('#rightaffix').before('<div id="idOpenHour" class="hidepanel alert alert-warning" style="text-align: center; padding: 7px; display: block;"><b>Opens at: '+ timeString + '</b></div>');       
        }

        
    }   
    else{
        $('#DeliveryTimeNowD').remove();
        $('#DeliveryTimeNowC').remove();
    }     */        

    }
  
    function InitCollectionDelivery2() {
             
        var viewport_width = $( window ).width();
       

        var _date = new Date();
        var hour = _date.getHours();
        var minutes = _date.getMinutes();
        var dt = $("#DeliveryTime");
			
        if (hour==23) {
			
            $("select[name=p_hour]", dt).val(0);
            _date.setDate(_date.getDate() + 1); 
            boxdate=("0" + (_date.getMonth() + 1)).slice(-2)
            boxday=("0" + (_date.getDate())).slice(-2)
            ddate20=boxday.toString() + "/" + boxdate.toString() + "/"  + _date.getFullYear().toString()
            $("#OrderDateBox").val(ddate20);
        } else {
            if( getCookie("p_hour") == "" || getCookie("p_hour")==null)
             $("select[name=p_hour]", dt).val(hour);
        }

         
    

			
        var nowTemp = new Date();
        var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);
         if('<%=Close_StartDate_JS%>' !='')
            Close_StartDate_JS  = new Date(<%=Year(Close_StartDate_JS)%>, <%=(Month(Close_StartDate_JS)-1)%>, <%=Day(Close_StartDate_JS)%>, 0, 0, 0, 0);
        if('<%=Close_EndDate_JS%>' !='')
            Close_EndDate_JS  = new Date(<%=Year(Close_EndDate_JS)%>, <%=(Month(Close_EndDate_JS)-1)%>, <%=Day(Close_EndDate_JS)%>, 0, 0, 0, 0);


        <%if ordertodayonly<>1 then%>
                var checkout = $('#OrderDate').datepicker({
			
                    onRender: function(date) {
                       // return date.valueOf() < now.valueOf() ? 'disabled' : '';
                          if(typeof Close_StartDate_JS !="undefined" && typeof Close_EndDate_JS !="undefined")
                            return (date.valueOf() < now.valueOf() || (Close_StartDate_JS.valueOf() <= date.valueOf() &&  date.valueOf()  <= Close_EndDate_JS.valueOf() )) ? 'disabled' : '';
                        else
                           return date.valueOf() < now.valueOf()  ? 'disabled' : '';
                    }
			
			
                }).on('changeDate', function (ev) {
                    ddate=ev.date;
                    pickeddate=("0" + (ddate.getMonth() + 1)).slice(-2)
                    pickedday=("0" + (ddate.getDate())).slice(-2)
                    ddate2=pickedday.toString() + "/" + pickeddate.toString() + "/"  + ddate.getFullYear().toString()
			
                    $("#OrderDateBox").val(ddate2);
                    StoreToC($("#OrderDateBox"),"OrderDate"); <% ' Store value to cookie for back button remember value%>
                    checkout.hide();
                    LoadTimes();
                }).data('datepicker');
        <%end if	%>
			
			
			
			
			
			
                 $("input[name='ordertimeoverride']").click(function() {
			            
                     $.ajax({url: "<%=SITE_URL %>ajaxdelivery.asp?d=" + $("input[name='orderTypePicker']:checked").val() , success: function(result){
        ReloadShop();
        }});
	
          if ($("input[name='ordertimeoverride']:checked").val() == 'n') { 
	  
                if ($("input[name='orderTypePicker']:checked").val() == 'c') { 
                    offsetmins=$('#collectiondelay').val();
                    var dt1 = new Date();
                    offsetmins2 = parseInt(offsetmins) ; //parseInt(offsetmins)+5;
                    if(ExpectedtimeC == "" || ExpectedtimeC == null ){
                       
                         var dt = new Date(dt1.getTime() + offsetmins2*60000);
                          //  minuteCDefault = offsetmins2*60000;
                        
                    }  
                    else{
                        var dt = ExpectedtimeC;
                                 minuteCDefault = 0;
                    }
	
                    var time = dt.getHours() + ":" + dt.getMinutes() + ":" + dt.getSeconds();
                   
                    
                    if(getCookie("p_hour")=="" || getCookie("p_hour") == null)
                        $("select[name=p_hour]", dt).val(dt.getHours());
                
                }
                else  if ($("input[name='orderTypePicker']:checked").val() == 'd') { 
                        
                        offsetmins=$('#deliverydelay').val();
                    var dt1 = new Date();
                    offsetmins2 = parseInt(offsetmins) ; //parseInt(offsetmins)+5;
                    if(ExpectedtimeD == "" || ExpectedtimeD == null ){
                        var dt = new Date(dt1.getTime() + offsetmins2*60000);
                           //minuteDDefault = offsetmins2*60000;
                           

                       } 
                    else{
                        var dt = ExpectedtimeD;
                        minutDDefault= 0
                   
	    }
                    var time = dt.getHours() + ":" + dt.getMinutes() + ":" + dt.getSeconds();
                    if(getCookie("p_hour")=="" || getCookie("p_hour") == null)
                        $("select[name=p_hour]", dt).val(dt.getHours());
                 
                }
                
	
        }
	
				 
          if ($("input[name='ordertimeoverride']:checked").val() == 'n') { 
	  
                if ($("input[name='orderTypePicker']:checked").val() == 'd') { 	
                    $("#DeliveryDistance").show();  
                    $("#PreFillDistance").tooltip({trigger: 'manual'}).tooltip('show');
                        setTimeout(function () {
                        $("#PreFillDistance").tooltip('hide');
                    }, 3000);
                    $("#DeliveryTime").hide();     
                    $("#DeliveryTime label").text("Delivery Time *");
                    $('#DeliveryTimeNowD').show();
                    $('#DeliveryTimeNowC').hide(); 
                    $('#CollectionAddress').hide();
                    console.log("hide 10");
                } else {
                    $("#DeliveryDistance").hide(); 
                    $("#DeliveryTime label").text("Collection Time *");
                    $("#DeliveryTime").hide();
                    $('#DeliveryTimeNowC').show();
                    $('#CollectionAddress').show();
                    $('#DeliveryTimeNowD').hide();	
                    console.log("show 10");
                }
        } 	
	  
                if ($("input[name='ordertimeoverride']:checked").val() == 'l') { 
                        $('#DeliveryTimeNowD').hide();$('#DeliveryTimeNowC').hide();
                      //  $('#CollectionAddress').hide();
                 if ($("input[name='orderTypePicker']:checked").val() == 'd') { 		
                            $("#DeliveryDistance").show(); 
                            $("#PreFillDistance").tooltip({trigger: 'manual'}).tooltip('show');
                            setTimeout(function () {
                                $("#PreFillDistance").tooltip('hide');
                            }, 3000);
                            $("#DeliveryTime").show();  
                            $("#DeliveryTime label").text("Delivery Time *"); 		  
                            offsetmins=$('#deliverydelay').val();
                            var dt1 = new Date();
                            offsetmins2 = parseInt(offsetmins);//parseInt(offsetmins)+5;
                            var dt = new Date(dt1.getTime() + offsetmins2*60000);
	
                            var time = dt.getHours() + ":" + dt.getMinutes() + ":" + dt.getSeconds();
                            if(getCookie("p_hour")=="" || getCookie("p_hour") == null)
                                $("select[name=p_hour]", dt).val(dt.getHours());
                       
	
                } else {  
                        $("#DeliveryDistance").hide();
                        $("#DeliveryTime label").text("Collection Time *");
                        $("#DeliveryTime").show(); 
                        if ($("input[name='orderTypePicker']:checked").val() == 'c') { 
                            offsetmins=$('#collectiondelay').val();
                            var dt1 = new Date();
                            offsetmins2 = parseInt(offsetmins) ;// parseInt(offsetmins)+5;
                            var dt = new Date(dt1.getTime() + offsetmins2*60000);
	
                            var time = dt.getHours() + ":" + dt.getMinutes() + ":" + dt.getSeconds();
                            $("select[name=p_hour]", dt).val(dt.getHours());
                      
                        }
                }
	 
        } 	
			 
        });
            

        $("input[name='orderTypePicker']").click(function() {
			 if ($("input[name='orderTypePicker']:checked").val() == 'c') {
                $('#CollectionAddress').show();                
             }
             else {
                $('#CollectionAddress').hide();
                console.log("hide 11");
                }
            $("#nowlater").show();
			
            $.ajax({url: "<%=SITE_URL %>ajaxdelivery.asp?d=" + $("input[name='orderTypePicker']:checked").val() , success: function(result){
                ReloadShop();
            }});
	
            if ($("input[name='ordertimeoverride']:checked").val() == 'n') { 
	  
                if ($("input[name='orderTypePicker']:checked").val() == 'c') { 
                    offsetmins=$('#collectiondelay').val();
                    var dt1 = new Date();
                    offsetmins2 = parseInt(offsetmins); //parseInt(offsetmins)+5;
                    var dt = new Date(dt1.getTime() + offsetmins2*60000);
	
                    var time = dt.getHours() + ":" + dt.getMinutes() + ":" + dt.getSeconds();
                    $("select[name=p_hour]", dt).val(dt.getHours());
            
                }
	
            }
	
				 
            if ($("input[name='ordertimeoverride']:checked").val() == 'n') { 
	  
                if ($("input[name='orderTypePicker']:checked").val() == 'd') { 
	
                    $("#DeliveryDistance").show();  
                    $("#PreFillDistance").tooltip({trigger: 'manual'}).tooltip('show');
                    setTimeout(function () {
                        $("#PreFillDistance").tooltip('hide');
                    }, 3000);
                    $("#DeliveryTime").hide();  
                    $("#DeliveryTime label").text("Delivery Time *");
                    $('#DeliveryTimeNowD').show();
                    $('#DeliveryTimeNowC').hide();
	                $('#CollectionAddress').hide();
                    console.log("hide 12");
                } else {
                    $("#DeliveryDistance").hide(); 
                    $("#DeliveryTime label").text("Collection Time *"); 
                    $("#DeliveryTime").hide();
                    $('#DeliveryTimeNowC').show();
                    $('#CollectionAddress').show();
                    $('#DeliveryTimeNowD').hide();
                    console.log("show 12");
                }
	 
	 
            } 	
	  
            if ($("input[name='ordertimeoverride']:checked").val() == 'l') { 
	  
                if ($("input[name='orderTypePicker']:checked").val() == 'd') { $("#DeliveryDistance").show(); 
                    $("#PreFillDistance").tooltip({trigger: 'manual'}).tooltip('show');
                    setTimeout(function () {
                        $("#PreFillDistance").tooltip('hide');
                    }, 3000);
                    $("#DeliveryTime").show();  $("#DeliveryTime label").text("Delivery Time *");    } else {  $("#DeliveryDistance").hide(); $("#DeliveryTime label").text("Collection Time *"); $("#DeliveryTime").show(); 
                }
	 
            } 	
	  	 
			LoadTimes();	 
				 
        });

        jQuery.validator.setDefaults({
            errorPlacement: function (error, element) {
                if (element.parent().hasClass('input-prepend') || element.parent().hasClass('input-append')) {
                    error.insertAfter(element.parent());
                } else {
                    error.insertAfter(element);
                }
            },
            errorElement: "small", 
            wrapper: "div", 
            highlight: function (element) {
                $(element).closest('.control-group').addClass('error'); 
            },
            success: function (element) {
                $(element).closest('.control-group').removeClass('error');
            }
        });

        $("form").removeAttr("novalidate");
        $("form").validate();

        $.ajaxSetup ({
            cache: false
        });
            
        ReloadShop();            

       

         $("input[name='ordertimeoverride']").change(function(){
		
             if ($(this).val() == 'n') {	
                 if ($("input[name='orderTypePicker']:checked").val() == 'd') {
                     offsetmins=$('#deliverydelay').val();
                 } else {
                     offsetmins=$('#collectiondelay').val();
                 }
                 var dt1 = new Date();
                 var dt = new Date(dt1.getTime() + offsetmins*60000);
	
                 var time = dt.getHours() + ":" + dt.getMinutes() + ":" + dt.getSeconds();
                 $("select[name=p_hour]", dt).val(dt.getHours());
               
	
                 if ($("input[name='orderTypePicker']:checked").val() == 'd') { $("#DeliveryDistance").show();  
                     $("#PreFillDistance").tooltip({trigger: 'manual'}).tooltip('show');
                     setTimeout(function () {
                         $("#PreFillDistance").tooltip('hide');
                     }, 3000);
                     $("#DeliveryTime").hide();  $("#DeliveryTime label").text("Delivery Time *");  	} else {
                     $("#DeliveryDistance").hide(); $("#DeliveryTime label").text("Collection Time *"); $("#DeliveryTime").hide();
	
                 }
             };
	
             if ($(this).val() == 'l') {
                 if ($("input[name='orderTypePicker']:checked").val() == 'd') { $("#DeliveryDistance").show(); 
                     $("#PreFillDistance").tooltip({trigger: 'manual'}).tooltip('show');
                     setTimeout(function () {
                         $("#PreFillDistance").tooltip('hide');
                     }, 3000);
                     $("#DeliveryTime").show();  $("#DeliveryTime label").text("Delivery Time *");   } else {  $("#DeliveryDistance").hide(); $("#DeliveryTime label").text("Collection Time *"); $("#DeliveryTime").show(); 
                 }
   
             } 
             LoadTimes();
         });

    }

 function OnChangePrefillAddress(){
    $('#updateFullPostcode').show();
    $('#PreFillDistance').remove();
    $('#isChangeExistingAddress').val('Y');
    setCookie("DeliveryDistance",'');
    $('#hidLat').val('');
    $('#hidLng').val('');
      $('input[name=deliveryDistance]').val('');
        if( getCookie("validate_pc") !="" && typeof getCookie("validate_pc") != "undefined" && getCookie('Postcode') !="")
                $("#validate_pc").val(getCookie("validate_pc") );
        else if(getCookie('Postcode') != '' && getCookie('Postcode') != null && getCookie('Postcode') != undefined){
            $("#validate_pc").val(getCookie('Postcode').replace(/\+/g,' '));
    }
  
    }
 function StoreToC(obj,cname)
 {
    if($(obj).val() != "" )
    setCookie(cname,$(obj).val(),15);
        
 }
    function setCookie(cname, cvalue, exmins) {
    var d = new Date();
    d.setTime(d.getTime() + (exmins*60*1000));
    var expires = "expires="+ d.toGMTString();
    document.cookie = encodeURIComponent(cname) + "=" + encodeURIComponent(cvalue) + "; " + expires + ";  path=/";
}
    function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i = 0; i <ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return decodeURIComponent(c.substring(name.length,c.length));
        }
    }
    return "";
}
     


      function CheckPointInDeliveryZone(_lat,_lng){
       
         <% if s_DeliveryZonesPath & "" = "" Then %>  
      
         return -1; /* no zones defined */

       <%else %>
        var geocoder = new google.maps.Geocoder();
        var deliveryLat = '';
        var deliveryLng = '';
        var deliveryZones = JSON.parse('<%=s_DeliveryZonesPath %>');
        for(var i = 0; i < deliveryZones.Zones.length; i++){
            var deliveryZone = new google.maps.Polygon({
            path:deliveryZones.Zones[i],
            strokeWeight : 0.5,				 
		    fillOpacity : 0.6,
            fillColor:'#d3f3c8',
            editable: false,
            draggable: false
            });
       
            if(google.maps.geometry.poly.containsLocation(new google.maps.LatLng(_lat, _lng), deliveryZone)) return 1;
         }
      return 0;
        
         <% end if %>
    }


    function CheckDistanceLatLng(_distance) {
            _distance =_distance || -1;
             var form = $("#CheckOutForm");
            if(($("#hidLat").val() == "" || $("#hidLng").val() == "") && _distance < 0) {
                
                 if($("#validate_pc").val().indexOf(",") > -1 )
                    var firstResult = $("#validate_pc").val().replace(/ /g,"+");
                 else
                    var firstResult = $("#validate_pc").val().replace(/ /g,"");

                var geocoder = new google.maps.Geocoder();
                geocoder.geocode({"address":firstResult }, function(results, status) {
                    if (status == google.maps.GeocoderStatus.OK && results[0]) {
                       // Start from new update for task #157  
                        var indexResponse = 0;
                        if(results.length > 0)
                        {
                              var formatted_address = "";
                              for(var i = 0 ; i < results.length ;i++)
                              {
                                    if(formatted_address.length < results[i].formatted_address.length)
                                          indexResponse = i;  
                              }    
                        }
                        var tempLat = results[indexResponse].geometry.location.lat(),
                            tempLng = results[indexResponse].geometry.location.lng();
                            $("#validate_pc").val(results[indexResponse].formatted_address);
                        $("#hidLat").val(tempLat);
                         $("#hidLng").val(tempLng);

                        var tempStreetNumber2 = '', tempRouteName2 = '', tempLocalcity2= '', tempPostalTown2 = '';
		              
                        for (i = 0; i < results[indexResponse].address_components.length; i++)
		                {
		                    if (results[indexResponse].address_components[i].types[0] == "postal_code") {
		                        $("#hidPostCode").val(results[indexResponse].address_components[i].short_name);		                
		                    }
		                    else if (results[indexResponse].address_components[i].types[0] == "street_number") {
		                        tempStreetNumber2 = results[indexResponse].address_components[i].short_name + ' ';
		                    }
		                    else if (results[indexResponse].address_components[i].types[0] == "route") {
		                        tempRouteName2 = results[indexResponse].address_components[i].short_name;
		                    }
		                    else if (results[indexResponse].address_components[i].types[0] == "locality") {
		                        tempLocalcity2 = results[indexResponse].address_components[i].short_name;
		                    }
                            else if (results[indexResponse].address_components[i].types[0] == "postal_town") {
		                        tempPostalTown2 = results[indexResponse].address_components[i].short_name;
		                    }
                        }
                        // End from new update for task #157  
                        var tempHidFormatAddress ="";
                        if (tempStreetNumber2 != '') 
                            tempHidFormatAddress += tempStreetNumber2 + '[*]';
                        if (tempRouteName2 != '') 
                            tempHidFormatAddress += tempRouteName2 + '[*]';
                        if(tempLocalcity2 != '')
                            tempHidFormatAddress += tempLocalcity2 + '[*]';
                        else if(tempPostalTown2 != '')
                            tempHidFormatAddress += tempPostalTown2 + '[*]';
                        if(tempHidFormatAddress.length >3 ) tempHidFormatAddress =  tempHidFormatAddress.substring(0, tempHidFormatAddress.length -3);

                        $("#hidFormattedAdd").val(tempHidFormatAddress);                                         
                      
                        CheckDistanceLatLng(_distance);
                    }
                    else 
                    {
                        $('#DeliveryDistance div.delivery_info').hide();  
                        
    
                        $("#updateFullPostcode").show();
                        if($("#PreFillDistance").length > 0 ) {
                          OnChangePrefillAddress();
                        }
                        else {
                             $("#missingPostcodeAlert").show();
                        $("#missingPostcodeAlert").html('<strong>We can not find valid location with your input. Please input valid address/searches or pick your location on a map !</strong>');
                       }
                        $('input[name=distance]', form).val('');
				        $('.delivery_info').addClass('alert-danger');
						$('.delivery_info').removeClass('alert-success'); 
                        return false; 
                    }
                });  
              return ;          
            }

            var DeliveryLat = $("#hidLat").val();
            var DeliveryLng = $("#hidLng").val();    
            if((DeliveryLng == "" || DeliveryLat == '') &&  _distance < 0)
            {
                $('#DeliveryDistance div.delivery_info').hide();   
                $("#missingPostcodeAlert").show();
                $("#missingPostcodeAlert").html('<strong>Please select your deliver location or pick a location on a map!</strong>');
                $('input[name=distance]', form).val('');
				$('.delivery_info').addClass('alert-danger');
						$('.delivery_info').removeClass('alert-success'); 
                return false;
            }
                var isInDeliveryZone = true, isDeliveryZoneExist = true;
                var deliverZoneResult = CheckPointInDeliveryZone(DeliveryLat,DeliveryLng);

                if(deliverZoneResult == -1) isDeliveryZoneExist = false;
                else if (deliverZoneResult == 0) isInDeliveryZone = false;
               
              
                var distance;
                 <% if sDistanceCalMethod = "googleapi" then %>
                  
                if(_distance == -1)
                    {
                    GetDistanceGMLatLng(<%=sRestaurantLat %>,<%=sRestaurantLng %>, DeliveryLat, DeliveryLng);
                    return;
                   }
                else distance = _distance;
                 <% else %>
                     
                if(_distance == -1){
                distance = GetDistanceLatLng(DeliveryLat,DeliveryLng,<%=sRestaurantLat %>,<%=sRestaurantLng %>,'K');
                    }
                 else distance = _distance;
                <% end if %>            

                

                if(distance >= 0) 
                {
                    var free_miles = parseFloat('<%=sDeliveryFreeDistance %>');
                    var max_miles = parseFloat('<%=sDeliveryMaxDistance %>');
                   
					<%if mileskm="miles" then%>
					var miles = distance * .6214;
					<%else%>
					var miles = distance;
					<%end if%>
					miles=(Math.round(miles *100) / 100);
                    $("#DeliverySpan").html("Distance: " + miles + " m");
                    //console.log(distance, free_miles, max_miles);
                    if((miles > max_miles && isDeliveryZoneExist  == false ) || (isDeliveryZoneExist   && isInDeliveryZone == false))
                    {
                        $('.delivery_info').hide();   
                        $("#missingPostcodeAlert").show();
                        $("#missingPostcodeAlert").html('This Takeaway Only Offers <strong>Collection</strong> To Your Postcode');                       
                        $('input[name=distance]', form).val('');
                          $('input[name=deliveryDistance]', form).val('');
						$('.delivery_info').addClass('alert-danger');
						$('.delivery_info').removeClass('alert-success'); 
                    }
                    else
                    {
						var total = parseFloat($("#SubTotal").val());
					
					    //setCookie("validate_pc", $("#validate_pc").val(), 60*24);
                        //alert($("#validate_pc").val());
                        StoreToC($("#validate_pc"),"validate_pc");
                        //alert(getCookie("validate_pc"));
						if (total><%=sDeliveryChargeOverrideByOrderValue%>) {
						
						$("#missingPostcodeAlert").hide();
					
                        $('.delivery_info').show();
						$('#delivery_fee').text('0'); 
                        $('input[name=deliveryDistance]', form).val(miles);
						 $('#showdistance').html(miles + ' <%=mileskm%>');
						  $.ajax({url: "<%=SITE_URL %>ajaxdeliverydistance.asp?d=" + miles , success: function(result){
	                ReloadShop();
                    }});
                       
                        $('div.beforeorder').css('border-color', '#E9EAEB');
						
						$('.delivery_info').removeClass('alert-danger');
                        $("#delivery-info").html("Great! Continue ordering");
						$('.delivery_info').addClass('alert-success');
						
						
						} else {
					
                        $("#missingPostcodeAlert").hide();
					
                        $('.delivery_info').show();
                        if(miles <= free_miles) {
						$('#delivery_fee').text('0'); 
						$('#df').css('color', '#3c763d');
						} else  {
					
						$('#delivery_fee').text('<%= FormatNumber(sDeliveryFee, 2) %>');
						}
                        $('input[name=deliveryDistance]', form).val(miles);
						$('#showdistance').html(miles + ' <%=mileskm%>');
						
						  $.ajax({url: "<%=SITE_URL %>ajaxdeliverydistance.asp?d=" + miles , success: function(result){
                             $("#updateFullPostcodeSubmit").tooltip("destroy");  
                                 $("#updateFullPostcodeSubmit").attr("title","You can now Continue to place your order");
                              $("#updateFullPostcodeSubmit").attr("data-original-title","You can now Continue to place your order");
                              $("#updateFullPostcodeSubmit").tooltip({trigger: 'manual'}).tooltip('show');
                               setTimeout(function(){
                        
                                    $("#updateFullPostcodeSubmit").tooltip('destroy');
                                    $("#updateFullPostcodeSubmit").attr("data-original-title","Remember to Check your address");
                                }, 3000);  
	ReloadShop();
    }});
                       
                        $('div.beforeorder').css('border-color', '#E9EAEB');
						
						$('.delivery_info').removeClass('alert-danger');
                        $("#delivery-info").html("Great! Continue ordering");
						$('.delivery_info').addClass('alert-success');
						}
                    }
                }
                else 
                {
                    $("#DeliverySpan").html("Distance: --");
                    $("#missingPostcodeAlert").html('Your Postcode code seems to be <strong>invalid</strong>');                   
                    $('input[name=distance]', form).val('');
                }     

                return false; 
    
           
			
                                       
        }
    
    
    function GetDistanceLatLng(lat1, lon1, lat2, lon2, unit) {
	var radlat1 = Math.PI * lat1/180
	var radlat2 = Math.PI * lat2/180
	var theta = lon1-lon2
	var radtheta = Math.PI * theta/180
	var dist = Math.sin(radlat1) * Math.sin(radlat2) + Math.cos(radlat1) * Math.cos(radlat2) * Math.cos(radtheta);
	dist = Math.acos(dist)
	dist = dist * 180/Math.PI
	dist = dist * 60 * 1.1515
	if (unit=="K") { dist = dist * 1.609344 }
	if (unit=="N") { dist = dist * 0.8684 }
	return dist
}

function createCookie(name, value, days) {
    var expires;
    if (days) {
        var date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        expires = "; expires=" + date.toGMTString();
    }
    else expires = "";
    document.cookie = name + "=" + value + expires + "; path=/";
}

function readCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') c = c.substring(1, c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
    }
    return null;
}

function eraseCookie(name) {
    createCookie(name, "", -1);
}

function areCookiesEnabled() {
    var r = false;
    createCookie("testing", "Hello", 1);
    if (readCookie("testing") != null) {
        r = true;
        eraseCookie("testing");
    }
    return r;
}





    var isSetLatLng = false;
    $(document).ready(function(){
    if(!areCookiesEnabled()){
    alert("Your browser does not seem to accept cookies and this can affect your order.  Please ensure that your browser accepts cookies.");   

    }
    var localTime = new Date();
   
    if(<%=(houroffset * 60) - Application("ServerGMTOffset") - DSTMinute  %> != -localTime.getTimezoneOffset()  - <%=DSTMinute %> ) {
        alertTime = true;
        alert("The server date/time seems to be different from your device. Please check your device settings or contact us.");   
    } 

    $("#validate_pc").keydown(function(e) {
           if(!$("#DeliveryDistance").find('.tooltip').hasClass('in'))
                $("#updateFullPostcodeSubmit").tooltip({trigger: 'manual'}).tooltip('show');    
          if (e.keyCode == 13) {
                $("#hidLat").val('');
                $("#hidLng").val('');
               $("#updateFullPostcodeSubmit").trigger("click");
            }
         
        });     
     $("#validate_pc").change(function() {
         if(isSetLatLng) isSetLatLng =false;
         else{
             $("#hidLat").val('');
             $("#hidLng").val('');    
            }
         
          
        });     
    
    });

   window.onunload = function(){}; 
    /*! Reloads page on every visit */
    function Reload() {
        try {
        var headElement = document.getElementsByTagName("head")[0];
        if (headElement && headElement.innerHTML)
            headElement.innerHTML += " ";
        } catch (e) {}
    }

    /*! Reloads on every visit in mobile safari */
    if ((/iphone|ipod|ipad.*os 5/gi).test(navigator.appVersion)) {
        window.onpageshow = function(evt) {
            if (evt.persisted) {
                document.body.style.display = "none";
                location.reload();
            }
        };
    }
</script>

<script> 
$(document).ready(function () {
 jQuery('.nav-stacked .catlink').on('click', function(e){
  jQuery('.nav-stacked .catlink').removeClass('cat-active');
  jQuery('.nav-stacked li').removeClass('link-active');
  jQuery(this).addClass('cat-active');
  jQuery(this).closest('li').addClass('link-active');
 });
});
</script>


<% if googleecommercetrackingcode<>"" then %>
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

  ga('create', '<%=googleecommercetrackingcode %>', 'auto');
  ga('send', 'pageview');
</script>
<% end if %>




    
    


<script type="text/javascript">
    $(function(){
        $('select.selectpicker').selectpicker({
            caretIcon: 'glyphicon glyphicon-menu-down'
        });
    });
    
 
/*! loadCSS. [c]2017 Filament Group, Inc. MIT License */
/* This file is meant as a standalone workflow for
- testing support for link[rel=preload]
- enabling async CSS loading in browsers that do not support rel=preload
- applying rel preload css once loaded, whether supported or not.
*/
(function( w ){
	"use strict";
	// rel=preload support test
	if( !w.loadCSS ){
		w.loadCSS = function(){};
	}
	// define on the loadCSS obj
	var rp = loadCSS.relpreload = {};
	// rel=preload feature support test
	// runs once and returns a function for compat purposes
	rp.support = (function(){
		var ret;
		try {
			ret = w.document.createElement( "link" ).relList.supports( "preload" );
		} catch (e) {
			ret = false;
		}
		return function(){
			return ret;
		};
	})();

	// if preload isn't supported, get an asynchronous load by using a non-matching media attribute
	// then change that media back to its intended value on load
	rp.bindMediaToggle = function( link ){
		// remember existing media attr for ultimate state, or default to 'all'
		var finalMedia = link.media || "all";

		function enableStylesheet(){
			// unbind listeners
			if( link.addEventListener ){
				link.removeEventListener( "load", enableStylesheet );
			} else if( link.attachEvent ){
				link.detachEvent( "onload", enableStylesheet );
			}
			link.setAttribute( "onload", null ); 
			link.media = finalMedia;
		}

		// bind load handlers to enable media
		if( link.addEventListener ){
			link.addEventListener( "load", enableStylesheet );
		} else if( link.attachEvent ){
			link.attachEvent( "onload", enableStylesheet );
		}

		// Set rel and non-applicable media type to start an async request
		// note: timeout allows this to happen async to let rendering continue in IE
		setTimeout(function(){
			link.rel = "stylesheet";
			link.media = "only x";
		});
		// also enable media after 3 seconds,
		// which will catch very old browsers (android 2.x, old firefox) that don't support onload on link
		setTimeout( enableStylesheet, 3000 );
	};

	// loop through link elements in DOM
	rp.poly = function(){
		// double check this to prevent external calls from running
		if( rp.support() ){
			return;
		}
		var links = w.document.getElementsByTagName( "link" );
		for( var i = 0; i < links.length; i++ ){
			var link = links[ i ];
			// qualify links to those with rel=preload and as=style attrs
			if( link.rel === "preload" && link.getAttribute( "as" ) === "style" && !link.getAttribute( "data-loadcss" ) ){
				// prevent rerunning on link
				link.setAttribute( "data-loadcss", true );
				// bind listeners to toggle media back
				rp.bindMediaToggle( link );
			}
		}
	};

	// if unsupported, run the polyfill
	if( !rp.support() ){
		// run once at least
		rp.poly();

		// rerun poly on an interval until onload
		var run = w.setInterval( rp.poly, 500 );
		if( w.addEventListener ){
			w.addEventListener( "load", function(){
				rp.poly();
				w.clearInterval( run );
			} );
		} else if( w.attachEvent ){
			w.attachEvent( "onload", function(){
				rp.poly();
				w.clearInterval( run );
			} );
		}
	}


	// commonjs
	if( typeof exports !== "undefined" ){
		exports.loadCSS = loadCSS;
	}
	else {
		w.loadCSS = loadCSS;
	}
}( typeof global !== "undefined" ? global : this ) );
$(document).ready(function(){
    $('[data-toggle="tooltip"]').tooltip();
});
</script>

<!--<% Response.Write("End Time " & Now() & "<br/>") %>-->


</body>
</html>
