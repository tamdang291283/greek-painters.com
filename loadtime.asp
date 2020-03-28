<%session("restaurantid")=Request.QueryString("rid")%>
<!-- #include file="Config.asp" -->
<!-- #include file="timezone.asp" -->
<!-- #include file="restaurantsettings.asp" -->
<%
    function getMinTimeMaxTime(byval currentTime, byval currentTimeZone, byval Hour_From, byval Hour_to,byval MinAcceptOrderBeforeClose)
        dim minMin,minHour,maxMin,maxhour,mindate,maxdate,MinAcceptOrderBeforeCloseValue
            minMin = 0
            minHour = 0
            maxMin = 0
            maxhour = 0
            mindate = 0
            maxdate = 0
        if  cint(MinAcceptOrderBeforeClose) < 0 then
            MinAcceptOrderBeforeCloseValue = 0
        else
            MinAcceptOrderBeforeCloseValue = MinAcceptOrderBeforeClose
        end if

         if  DateDiff("n",cdate(Hour_From),cdate(Hour_to)) > 0 then

     
     'Response.End
                if cdate(currentTimeZone) <= cdate(currentTime &" "& Hour_From) then   
    
                        'Response.Write("Current time " & currentTimeZone & "<br/>")
                        'Response.Write("Min time " & cdate(currentTime & " " &  Hour_From) & "<br/>")

                       ' Response.Write("time 1 " & cdate(currentTime &" "& Hour_From) & "<br/>")
                        'Response.Write("time 2 " & cdate(currentTime & " " & Hour_to)  & "<br/>")
                                                
                        minMin =  dateadd("n",deliverytime,cdate(currentTime & " " &  Hour_From))
                       
                        minHour =  Hour(minMin)
                        minMin = Minute(minMin)

                        if minMin mod 5 > 2 then
                            minMin = 5 + (minMin - (minMin mod 5 ))
                        else
                             minMin = (minMin - (minMin mod 5 ))   
                        end if
                        maxhour = split(Hour_To,":")(0)
                        maxMin = split(Hour_to,":")(1)  
                     '   Response.Write("minHour " & minHour & " minMin " & minMin  & "<br/>")
                elseif asap="n" and cint(MinAcceptOrderBeforeClose) >= 0 and cdate(currentTimeZone)  > cdate(currentTime & " " & Hour_From) and  currentTimeZone <= DateAdd("n", -1 * MinAcceptOrderBeforeClose, cdate(currentTime & " " & Hour_to)) then 
                            minMin =  currentTimeZone                           
                            minHour =  Hour(minMin)
                            minMin = Minute(minMin)
                            if minMin mod 5 > 2 then
                                minMin =5 +  (minMin - (minMin mod 5 ))
                            else
                                  minMin = (minMin - (minMin mod 5 ))  
                            end if   
                            maxMin = cdate(currentTime &" "& Hour_to)
                     
                            maxhour = hour(maxMin)
                            maxMin = Minute(maxMin) 
                elseif cdate( currentTimeZone)  > cdate(currentTime & " " & Hour_From) and _ 
                    dateadd("n",deliverytime,currentTimeZone) <= cdate(currentTime & " " & Hour_to) then
                            
                            minMin =  dateadd("n",cdate(deliverytime),cdate(currentTimeZone))
                           
                            minHour =  Hour(minMin)
                            minMin = Minute(minMin)
                            if minMin mod 5 > 2 then
                                minMin =5 +  (minMin - (minMin mod 5 ))
                            else
                                  minMin = (minMin - (minMin mod 5 ))  
                            end if   
                           ' maxMin = DateAdd("n",-1 * MinAcceptOrderBeforeCloseValue,cdate(currentTime &" "& objRds("Hour_To")))
                             maxMin = cdate(currentTime &" "& Hour_to)
                                
                            maxhour = hour(maxMin)
                            maxMin = Minute(maxMin) 
                            
                end if
        elseif DateDiff("n",Hour_From,Hour_to) < 0 then
           
                dim nextCurrentDate : nextCurrentDate = dateadd("d",1, cdate(currentTime & " 00:00:00"))
                    nextCurrentDate = day(nextCurrentDate)&"/" & month(nextCurrentDate) & "/" & year(nextCurrentDate)
               
                if cdate(currentTimeZone ) <= cdate(currentTime &" "& Hour_From) then                           
                        minMin =  dateadd("n",cdate(deliverytime),cdate(currentTime & " " &  Hour_From))
                        minHour =  Hour(minMin)
                        minMin = Minute(minMin)
                        if minMin mod 5 > 2 then
                            minMin =5+ (minMin - (minMin mod 5 ))
                        else
                            minMin  = (minMin - (minMin mod 5 ))
                        end if
                        maxhour = split(Hour_to,":")(0)
                        maxMin = split(Hour_to,":")(1)  
                elseif asap = "n" and MinAcceptOrderBeforeClose >= 0 and cdate(currentTimeZone)  > cdate(currentTime & " " & Hour_From) and cdate(currentTimeZone) <= DateAdd("n",-1*MinAcceptOrderBeforeClose, cdate(nextCurrentDate & " " & Hour_to))  then
                        mindate = currentTimeZone
                        minMin =  mindate
                        minHour =  Hour(minMin)
                        minMin = Minute(minMin)
                        if minMin mod 5 > 2 then
                            minMin = 5+  (minMin - (minMin mod 5 ))
                        else
                            minMin = minMin - (minMin mod 5 )
                        end if   
                            
                        maxdate =  cdate(nextCurrentDate &" "& Hour_to)
                        maxMin = maxdate
                       
                        maxhour = hour(maxMin)
                        maxMin = Minute(maxMin) 
                elseif cdate(currentTimeZone)  > cdate(currentTime & " " & Hour_From) and _ 
                    dateadd("n",cdate(deliverytime),cdate(currentTimeZone)) <= cdate(nextCurrentDate & " " & Hour_to) then
                            mindate = dateadd("n",cdate(deliverytime) ,cdate(currentTimeZone))
                            minMin =  mindate
                            minHour =  Hour(minMin)
                            minMin = Minute(minMin)
                            if minMin mod 5 > 2 then
                                minMin = 5+  (minMin - (minMin mod 5 ))
                            else
                                minMin = minMin - (minMin mod 5 )
                            end if   
                            
                            'maxdate =  DateAdd("n",-1 * MinAcceptOrderBeforeCloseValue, cdate(nextCurrentDate &" "& Hour_to))
                            maxdate =   cdate(nextCurrentDate &" "& Hour_to)
                            maxMin = maxdate
                            maxhour = hour(maxMin)
                            maxMin = Minute(maxMin) 
                end if
        end if
          
        getMinTimeMaxTime= minHour & ":"  & minMin & "|" & maxhour   & ":" &  maxMin & "|" & mindate & "|" & maxdate
    end function
    dim objCon,objRds
    Set objCon = Server.CreateObject("ADODB.Connection")
        objCon.Open sConnString
    Set objRds = Server.CreateObject("ADODB.Recordset") 
    dim deliverytime : deliverytime = Request.QueryString("time")
    dim asap : asap = Request.QueryString("asap")
    dim t :  t = request.QueryString("t")
    dim dateselect : dateselect = request.QueryString("date")  
    Dim sDayOfWeek
    Dim sHour,vRestaurantId 
    vRestaurantId = Request.QueryString("rid")
    dim RS_Close_Setting :  set RS_Close_Setting = Server.CreateObject("ADODB.Recordset")
        RS_Close_Setting.Open "SELECT Close_StartDate,Close_EndDate  FROM BusinessDetails   WHERE Id = " & vRestaurantId, objCon
        dim Close_StartDate,Close_EndDate
     if not RS_Close_Setting.EOF then
        Close_StartDate = RS_Close_Setting("Close_StartDate")
        Close_EndDate  = RS_Close_Setting("Close_EndDate")       
    end if
    RS_Close_Setting.close()
    set RS_Close_Setting  =  nothing

    dim currentTimeZone : currentTimeZone = DateAdd("h",houroffset,now)
    'Response.Write("currentTimeZone" & currentTimeZone & "<br/>")
    'if dateselect & "" <> "" then
    '    currentTimeZone = cdate(dateselect & " " & Hour(currentTimeZone) & ":" & Minute(currentTimeZone))
    'end if
        
    dim listoftime
    dim mintime,maxtime, minHour,maxhour,minMin,maxMin
    dim mindatetime,maxdatetime
    dim currentTime 
        if dateselect & "" = "" then
            currentTime = cdate(day(currentTimeZone) & "/" & month(currentTimeZone) & "/" & year(currentTimeZone))
        else
            currentTime = cdate(dateselect)
        end if

    dim nextcurrenttime
        nextcurrenttime =  DateAdd("d",1,currentTime)
        nextcurrenttime = day(nextcurrenttime) & "/" & month(nextcurrenttime) & "/" & year(nextcurrenttime)

    sDayOfWeek = DatePart("w", currentTime, vbMonday, 1)
   
    dim previousday : previousday = sDayOfWeek - 1
        if previousday = 0 then
            previousday = 7
        end if
    dim objRdsPrev : set objRdsPrev = Server.CreateObject("ADODB.Recordset")     
           
        objRdsPrev.Open "SELECT DayOfWeek,  convert(varchar, Hour_From, 8)  as Hour_From, convert(varchar, Hour_To, 8)  as Hour_To ,delivery,collection,MinAcceptOrderBeforeClose  FROM openingtimes   where IdBusinessDetail = "& vRestaurantId &" and DayOfWeek=" & previousday & " order by DayOfWeek, Hour_From", objCon
    

    dim MinAcceptOrderBeforeClose,MinAcceptOrderBeforeCloseValue 
    while not objRdsPrev.EOF
            dim Prev_Hour_From,Prev_Hour_To 
                Prev_Hour_From = cdate(FormatTimeC(objRdsPrev("Hour_From"),5))
                Prev_Hour_To  = cdate(FormatTimeC( objRdsPrev("Hour_To") ,5))
            MinAcceptOrderBeforeClose = 0 
            if objRdsPrev("MinAcceptOrderBeforeClose") & "" <> ""  then
                MinAcceptOrderBeforeClose = cint(objRdsPrev("MinAcceptOrderBeforeClose"))
            end if
            if cint(MinAcceptOrderBeforeClose) < 0 then
               MinAcceptOrderBeforeCloseValue = 0 
            else
              MinAcceptOrderBeforeCloseValue= MinAcceptOrderBeforeClose
            end if
            isAllow =  true
            if t = "d"  and objRdsPrev("delivery") = "n" then
                isAllow = false
            elseif t = "c"  and objRdsPrev("collection") = "n" then
                isAllow = false
            end if
          if isAllow = true then
             
              if DateDiff("n",Prev_Hour_From,Prev_Hour_To) < 0 and mindatetime & "" = "" and maxdatetime & "" = "" then              
                      '  Response.Write("ok 1 <br/>" )
                         
                    if MinAcceptOrderBeforeClose >= 0 and asap="n" and currentTimeZone  <= DateAdd("n",-1*MinAcceptOrderBeforeClose, cdate(currentTime & " " & (Prev_Hour_To & "") )) then
                     
                        mindatetime = currentTimeZone
                        maxdatetime = cdate(currentTime & " " & (Prev_Hour_To&""))  
                    elseif  DateAdd("n", deliverytime  ,currentTimeZone) <= cdate(currentTime & " " & (Prev_Hour_From & ""))  then     
                        '   Response.Write("currentTimeZone " & DateAdd("n", deliverytime  ,currentTimeZone) & "<br/> " & cdate(currentTime & " " & (Prev_Hour_From & ""))& "<br/>")                                 
                        mindatetime = currentTime
                        maxdatetime = cdate(currentTime & " " & Prev_Hour_To) 
                       ' Response.Write("mindatetime " & mindatetime & " maxdatetime " & maxdatetime & "<br/>" )
                    elseif DateAdd("n", deliverytime  ,currentTimeZone) <= cdate(currentTime & " " & (Prev_Hour_To&""))  then
                        mindatetime = DateAdd("n", deliverytime  ,currentTimeZone)
                        maxdatetime = cdate(currentTime & " " & (Prev_Hour_To&"")) 
                                   
                    end if
                   ' Response.Write("mindatetime " & mindatetime & "<br/>")
                   ' Response.Write("maxdatetime " & maxdatetime & "<br/>")
              end if
          end if
        objRdsPrev.movenext()
    wend
       
        objRdsPrev.close()
    set objRdsPrev = nothing
    dim counrow : counrow = 1 
    dim isAllow :  isAllow =  true
    dim dayname
    dim isclosed : isclosed = false 
    'Response.Write("mindatetime "  & mindatetime & " maxdatetime " & maxdatetime & "<br/>")
     if cdate(Close_StartDate & " 00:00:01") <= DateAdd("d",-1,maxdatetime) and  DateAdd("d",-1,maxdatetime) <= cdate(Close_EndDate & " 23:59:59") then
        isclosed  = true
     end if
    if mindatetime & "" <> "" and maxdatetime & "" <> "" and isclosed =  false then
      
        dayname = WeekdayName(DatePart("w", mindatetime, vbMonday, 1),false,0)
        minMin = Minute(mindatetime)
        minHour = hour(mindatetime)
        maxMin = Minute(maxdatetime)
        maxhour = hour(maxdatetime)
       '  Response.Write("minHour " & minHour & " maxhour " & maxhour & " minMin " & minMin & " maxMin " & maxMin   &"<br/>")
     
         while  ( (cint(minHour) < cint(maxhour) ) or  (cint(minHour) <= cint(maxhour) and cint(minMin) <= cint(maxMin)) ) and counrow < 100      
                        if minMin mod 5 > 2 then
                                minMin = 5+  (minMin - (minMin mod 5 ))
                        else
                                minMin = minMin - (minMin mod 5 )
                        end if                 
                       if  cint(minMin) < 10 then
                            listoftime=listoftime & dayname & " " &  minHour & ":0" &  minMin & "[*]"
                        else
                            listoftime=listoftime & dayname & " " &  minHour & ":" &  minMin & "[*]"
                        end if
                         

                            minMin = cint(minMin) + 5 
                        
                        if minMin = 60 then
                            minHour= minHour +1 
                            minMin = 0
                        end if                       
                        counrow = counrow +1
          wend

    end if
        
    mindatetime =  ""
    maxdatetime = ""
  
    objRds.Open "SELECT DayOfWeek,convert(varchar, Hour_From, 8)  as Hour_From, convert(varchar, Hour_To, 8)  as Hour_To,delivery,collection,MinAcceptOrderBeforeClose  FROM openingtimes   where IdBusinessDetail = " &vRestaurantId& " and DayOfWeek=" & sDayOfWeek & " order by DayOfWeek, Hour_From", objCon
    while not objRds.EOF
                dim Current_Hour_From,Current_Hour_To
                    Current_Hour_From = cdate(FormatTimeC(objRds("Hour_From"),5))
                    Current_Hour_To =  cdate(FormatTimeC(objRds("Hour_To"),5))
               ' Response.Write("date from " & objRds("Hour_From") & " date to " & objRds("Hour_To") & "</br>")
                 MinAcceptOrderBeforeClose = 0 
                if objRds("MinAcceptOrderBeforeClose") & "" <> "" then
                    MinAcceptOrderBeforeClose = cint(objRds("MinAcceptOrderBeforeClose"))
                end if
                'if cint(MinAcceptOrderBeforeClose) < 0 then
                '   MinAcceptOrderBeforeClose = 0 
                'end if
                isAllow =  true
                if t = "d"  and objRds("delivery") = "n" then
                    isAllow = false
                elseif t = "c"  and objRds("collection") = "n" then
                    isAllow = false
                end if
                dim validtime    
            if  isAllow = true then
                        
                        if  DateDiff("n",Current_Hour_From,Current_Hour_To) > 0 then  
                                ' Response.Write("Current_Hour_From " & Current_Hour_From & " Current_Hour_To " & Current_Hour_To & "<br/>" )
                           ' Response.Write("currentTime " & currentTime & " currentTimeZone " & currentTimeZone & "<br/>")                     
                           validtime = getMinTimeMaxTime(currentTime,currentTimeZone,Current_Hour_From,Current_Hour_To,MinAcceptOrderBeforeClose)    
                           ' Response.Write("Current_Hour_From " & Current_Hour_From & " Current_Hour_To " & Current_Hour_To & "<br/>")
                           'Response.Write("validtime " & validtime & "<br/>")
                          ' Response.Write("currentTimeZone" & currentTimeZone & " deliverytime " & deliverytime & " validtime " & validtime & " MinAcceptOrderBeforeClose " & MinAcceptOrderBeforeClose  & "<br/>")
                           minTime =  split(validtime,"|")(0)
                           maxtime = split(validtime,"|")(1)
                            minHour = 0 
                            minMin = 0
                            maxhour = 0
                            maxmin = 0    
                         ' Response.Write("minTime " & minTime & " maxtime " & maxtime & "<br/>")
                            if minTime <> "0:0" and maxTime <> "0:0" then
                         
                                 minHour = split(minTime,":")(0)
                                 minMin = split(minTime,":")(1)
                                 maxhour = split(maxtime,":")(0)
                                 maxmin = split(maxtime,":")(1)
                         
                           end if
                                counrow = 1        
                   ' Response.Write("minTime " & minTime & " maxtime " & maxtime & "<br/>")
                  'Response.Write("minHour " & minHour & " maxhour " & maxhour & " minMin " & minMin & " maxMin " & maxMin   & "<br/>" )
                        if cint(minHour) > 0 or cint(maxhour) > 0 or cint(minMin) > 0 or cint(maxMin) > 0  then
                          while ( (cint(minHour) < cint(maxhour)) or (cint(minHour) <= cint(maxhour) and cint(minMin) <= cint(maxMin)) ) and counrow <= 2000 
                               '  Response.Write("minMin " & minMin & " minHour " & minHour & " maxMin " & maxMin & " maxhour " & maxhour & "<br/>")  
                                 dayname = WeekdayName(sDayOfWeek,false,0)
                                if  cint(minMin) < 10 then
                                    listoftime=listoftime & dayname & " " &  minHour & ":0" &  minMin & "[*]"
                                else
                                    listoftime=listoftime & dayname & " " &  minHour & ":" &  minMin & "[*]"
                                end if
                         
                                 minMin = cint(minMin) + 5 
                        
                                if minMin = 60 then
                                    minHour= minHour +1 
                                    minMin = 0
                                end if
                      
                                counrow = counrow +1
                          wend  
                        end if
                            
                        elseif DateDiff("n",Current_Hour_From,Current_Hour_To) < 0 and mindatetime & "" = "" and maxdatetime & "" = "" then
                          '  Response.Write("currentTime " & currentTime & " currentTimeZone " &  currentTimeZone & " <br/>")
                           validtime = getMinTimeMaxTime(currentTime,currentTimeZone,Current_Hour_From,Current_Hour_To,MinAcceptOrderBeforeClose)
                           
                          '  Response.Write("validtime " & validtime& "<br/>")
                           minTime =  split(validtime,"|")(0)
                           maxtime = split(validtime,"|")(1)
                            minHour = 0 
                            minMin = 0
                            maxhour = 0
                            maxmin = 0 
                           if minTime <> "0:0" and maxTime <> "0:0" then
                         
                                 minHour = split(minTime,":")(0)
                                 minMin = split(minTime,":")(1)
                                 maxhour = split(maxtime,":")(0)
                                 maxmin = split(maxtime,":")(1)
                                 if cint(maxhour) < cint(minHour) then
                                    maxhour = cint(maxhour) + 24  
                                 else
                                     if sDayOfWeek = 7 then
                                                sDayOfWeek = 0
                                     end if  
                                    sDayOfWeek =  sDayOfWeek +1
                                 end if
                           end if
                            counrow = 1      

                           if cint(minHour) > 0 or cint(maxhour) > 0 or cint(minMin) > 0 or cint(maxMin) > 0  then
                              while (cint(minHour) < cint(maxhour)) or (cint(minHour) <= cint(maxhour) and cint(minMin) <= cint(maxMin)) 
                                  '  response.Write("sDayOfWeek " & sDayOfWeek & "<br/>")
                                     isclosed  = false
                                     if cint(minHour) >= 24  then
                                            if sDayOfWeek = 7 then
                                                sDayOfWeek = 0
                                            end if
                                            dayname = WeekdayName(sDayOfWeek + 1,false,0)
                                             if cdate(Close_StartDate & " 00:00:01") <= DateAdd("d",1,currentTime & " 00:00:01" ) and  DateAdd("d",1,currentTime & " 00:00:01") <= cdate(Close_EndDate & " 23:59:59") then
                                                isclosed  = true
                                             end if
                                      else
                                            dayname = WeekdayName(sDayOfWeek,false,0)
                                      end if
                                    if isclosed =  false then
                                        if  cint(minMin) < 10 then
                                            listoftime=listoftime & dayname & " " &  ( cint(minHour) mod 24) & ":0" &  minMin & "[*]"
                                        else
                                            listoftime=listoftime & dayname & " " &  ( cint(minHour) mod 24 ) & ":" &  minMin & "[*]"
                                        end if
                                    end if
                         
                                     minMin = cint(minMin) + 5 
                        
                                    if minMin = 60 then
                                        minHour= minHour +1 
                                        minMin = 0
                                    end if
                      
                                    counrow = counrow +1
                              wend  
                          end if
                         ' mindatetime = split(validtime,"|")(2)
                         ' maxdatetime = split(validtime,"|")(3)            
                        end if

            end if    
          'end if

        objRds.movenext()
    wend
    objRds.close()
    set objRds = nothing
    objCon.close()
    set objCon = nothing
   Response.Write(listoftime)
   Response.End

%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
    <meta charset="utf-8">
    <title>Order</title>
</head>

<style>
    .title-size {
        font-size: 32.4px;
    }

    .heading-size {
        font-size: 30.6px;
    }

    .item-size {
        font-size: 27.9px;
    }

    .tb-item-size {
        font-size: 27.9px;
        table-layout: fixed;
    }

    .big-printing-size {
        font-size: 45.9px;
    }

    .tb-item-size td {
        padding: 3px 0;
    }

    * {
        font-family: Arial;
    }
</style>
<body style="width:512px;">

  	<script type="text/javascript" src="Scripts/jquery.min.js"></script>


    <div class="row">
        <div class="span12">
            <div align="center">
                <p class="title-size">Order 10175 from Red Dragon  </p>
            </div>
        </div>
    </div>

        <script>
        var s = $('<select/>');
        var listoftime = "<%=listoftime %>";
        var arraylistoftime = listoftime.split("[*]");
       $(arraylistoftime).each(function(){
                s.append($('<option/>').html(this));
            });
        $('body').append(s);

    </script>
</body>
</html>