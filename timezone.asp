<%

dim offset : offset=Application("ServerGMTOffset")
  
dim houroffset, houroffsetreal
dim DSTMinute : DSTMinute = 0   
if session("restaurantid") & "" <>"" then
        if IsNumeric(trim(session("restaurantid") & "")) = false or instr(trim(session("restaurantid") & ""),",") > 0 or instr(trim(session("restaurantid") & ""),".") > 0 then
            Response.Redirect(SITE_URL & "error.asp")
            Response.End
        end if
        Set timezone_cmd = Server.CreateObject ("ADODB.Command")
        timezone_cmd.ActiveConnection = sConnString
        sql = "SELECT  BusinessDetails.ID,  timezones.offset, timezones.offsetdst FROM BusinessDetails  INNER JOIN timezones  ON BusinessDetails.timezone = timezones.ID WHERE (((BusinessDetails.ID)=" & session("restaurantid") & "));"
        timezone_cmd.CommandText = sql
        timezone_cmd.Prepared = true
        Set timezone = timezone_cmd.Execute
        
        dim timezonesOffset,timezonesOffsettime,timezonesOffsetDST,timezonesOffsetDSTTime 
        dim HourDST : HourDST = 0
            timezonesOffset = 0 
            timezonesOffsetDST = 0 
            if not timezone.EOF then
                timezonesOffsettime  = timezone.Fields.Item("offset").Value
                timezonesOffsetDSTTime = timezone.Fields.Item("offsetdst").Value
            end if
            ' Get offset time
                if timezonesOffsettime & "" <> "" then
                    timezonesOffset = Replace(Replace(split(timezonesOffsettime,":")(0) & "","-",""),"-","")
                end if
                if timezonesOffset & "" <> "" then
                    timezonesOffset = cint(timezonesOffset)
                end if
            ' Get offset time DST
                if timezonesOffsetDSTTime & "" <> "" then
                    timezonesOffsetDST = Replace(Replace(split(timezonesOffsetDSTTime,":")(0) & "","-",""),"-","")
                end if

                if timezonesOffsetDST & "" <> "" then
                    timezonesOffsetDST = cint(timezonesOffsetDST)
                end if
            ' Check have setup DST or not
            if  timezonesOffsetDST > 0 and timezonesOffsetDST >  timezonesOffset then
                HourDST = timezonesOffsetDST - timezonesOffset
            end if


        timezoney = datepart("yyyy", date())
        ' REM EUROPEAN UNION CALCULATION:
        DST_EU_SPRING = (31 - ((5*timezoney -5*timezoney mod 4)/4  + 4) mod 7)
        DST_EU_FALL = (31 - ((5*timezoney -5*timezoney mod 4)/4  + 1) mod 7)

        'Response.Write("DST_EU_SPRING " & DST_EU_SPRING & "<br/>")
       ' Response.Write("DST_EU_FALL " & DST_EU_FALL & "<br/>")
        'date1=CDate(DST_EU_SPRING & "/3/" & timezoney)
        'date2=CDate(DST_EU_FALL & "/10/" & timezoney)
        date1=CDate(DST_EU_SPRING & "/3/" & timezoney & " 01:00:00")
        date2=CDate(DST_EU_FALL & "/10/" & timezoney & " 02:00:00" )
        if Now() > date1 AND Now() < date2  then 'if (DateDiff("d",date1,now)>1) and (DateDiff("d",now,date2)>1) then
            offset = offset + HourDST * 60
            DSTMinute = HourDST * 60
            if Request.QueryString("test") = "y" then
                Response.Write("offset " & offset  & " DSTMinute " & DSTMinute  & "<br/>")
            end if
        end if

        houroffset=offset/60
        houroffsetreal=offset/60

        if instr(timezonesOffsettime,"-") then
            houroffset=houroffset-cint(timezonesOffset)
        else
            houroffset=houroffset+cint(timezonesOffset)
        end if
            timezone.close()
        set timezone = nothing  
        set timezone_cmd = nothing
       ' Response.Write("houroffset " & houroffset & "<br/>")
end if
    
    %>