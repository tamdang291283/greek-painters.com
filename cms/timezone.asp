<%
'Session.LCID = 2057 
'Response.Write("2057 UK " & Now() & "  LCID " &Session.LCID& "</br>")
dim offset : offset=Application("ServerGMTOffset")
dim houroffset, houroffsetreal
dim DSTMinute : DSTMinute = 0   
if Session("MM_id") & "" <>"" then
        if IsNumeric(trim(Session("MM_id") & "")) = false or instr(trim(Session("MM_id") & ""),",") > 0 or instr(trim(Session("MM_id") & ""),".") > 0 then
            Response.Redirect(SITE_URL & "error.asp")
            Response.End
        end if
        Set timezone_cmd = Server.CreateObject ("ADODB.Command")
        timezone_cmd.ActiveConnection = sConnString
        sql = "SELECT  BusinessDetails.ID,  timezones.offset, timezones.offsetdst FROM BusinessDetails INNER JOIN timezones ON BusinessDetails.timezone = timezones.ID WHERE (((BusinessDetails.ID)=" & Session("MM_id") & "));"
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
                timezone.close()
            set timezone  =  nothing 
                  timezone_cmd.ActiveConnection.Close
            set timezone_cmd = nothing
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
        'DST_EU_SPRING = (31 - (5*timezoney/4 + 4) mod 7)
        'DST_EU_FALL = (31 - (5*timezoney/4 + 1) mod 7)
        DST_EU_SPRING = (31 - ((5*timezoney -5*timezoney mod 4)/4  + 4) mod 7)
        DST_EU_FALL = (31 - ((5*timezoney -5*timezoney mod 4)/4  + 1) mod 7)
        'date1=CDate(DST_EU_SPRING & "/3/" & timezoney)
        'date2=CDate(DST_EU_FALL & "/10/" & timezoney)
        date1=CDate(DST_EU_SPRING & "/3/" & timezoney & " 00:00:01")
        date2=CDate(DST_EU_FALL & "/10/" & timezoney)
        if Now() > date1 and Now() < date2  then 'if (DateDiff("d",date1,now)>1) and (DateDiff("d",now,date2)>1) then
            offset = offset + HourDST * 60
            DSTMinute = HourDST * 60
        end if

        houroffset=offset/60
        houroffsetreal=offset/60

        if instr(timezonesOffsettime,"-") then
            houroffset=houroffset-cint(timezonesOffset)
        else
            houroffset=houroffset+cint(timezonesOffset)
        end if
end if
    function formatdatecustom(byval date1,byval formatpatterm)
        dim result : result = date1
   
        select case formatpatterm
               case "mm/dd/yyyy"
                    result = Month(date1)  & "/" & Day(date1) & "/" &  Year(date1)
                case "dd/mm/yyyy"
                    result = Day(date1)  & "/" &  Month(date1) & "/" &  Year(date1)
                case "yyyy/mm/dd"
                    result = Year(date1)   & "/" &  Month(date1) & "/" &  Day(date1)
        end select

        formatdatecustom = result 'cdate(result)
    end function
    %>