<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../../Config.asp" -->
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
    sub UpdateOrderOnline(byval orderid , byval resid)
        dim objCon ,objRds
        Set objCon = Server.CreateObject("ADODB.Connection")         
        set objRds = Server.CreateObject("ADODB.Recordset")  
            objCon.Open sConnString 
           ' Response.Write("Update orders set printed = 0 where ID = " & orderid & " and IdBusinessDetail = " & resid)
            objCon.execute("Update orders set printed = 0 where ID = " & orderid & " and IdBusinessDetail = " & resid)          
            objCon.close()
            set objCon = nothing
            WriteLog Server.MapPath("forceprintLocal.txt"),"PageName  = " & Request.ServerVariables ("HTTP_REFERER") & " Start Page [Orderid] " & orderid 
    end sub
    sub UpdateOrderInStore(byval orderid , byval resid )
         dim objCon 
        Set objCon = Server.CreateObject("ADODB.Connection")   
            objCon.Open sConnString 
            objCon.execute("Update OrdersLocal set printed = 0 where ID = " & orderid & " and IdBusinessDetail =" & resid )
            objCon.close()
            set objCon = nothing
            WriteLog Server.MapPath("forceprintLocal.txt"),"PageName  = " & Request.ServerVariables ("HTTP_REFERER") & " Start Page [Orderid] " & orderid 
    end sub
    dim OrderID :  OrderID = Request.QueryString("oid")
    dim Restaurant : Restaurant = Request.QueryString("res")
    dim ResID : ResID =   Request.QueryString("ResID")
    if OrderID & "" <> "" and Restaurant & "" <> "" then 
        if IsNumeric(OrderID) then
            if Restaurant = "online" then
                call UpdateOrderOnline(OrderID,ResID)
                Response.Write("ok")
            elseif Restaurant = "instore" then
                call UpdateOrderInStore(OrderID,ResID)
                Response.Write("ok")
            else
                Response.Write("fail")
            end if      
        end if
    else
         Response.Write("fail") 
    end if

%>