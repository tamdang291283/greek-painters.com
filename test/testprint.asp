<!-- #include file="../Config.asp" -->
<%
 
    session("restaurantid")=2
     %>

<!-- #include file="../timezone.asp" -->
<!-- #include file="../restaurantsettings.asp" -->
<%
   
        dim rID : rID = 2 
        Dim objCon2,objRds2,SQL
        Set objCon2 = Server.CreateObject("ADODB.Connection")
        Set objRds2 = Server.CreateObject("ADODB.Recordset") 
            objCon2.Open sConnString
        dim   DateCondition : DateCondition = FormatDateTime(cdate(DateAdd("h",houroffset,now)))
        dim datet : datet = split( DateCondition ," ")(0)
            dim datetime : datetime = split( DateCondition ," ")(1)
            DateCondition = split(datet,"/")(1) & "/" & split(datet,"/")(0) & "/" & split(datet,"/")(2) & " " & datetime
        SQL = "  SELECT  ID,OrderDate,'' as s_filename FROM ORDERS "
               SQL = SQL & " WHERE "
               SQL = SQL & "  (paymenttype='Paypal-Paid' or paymenttype='NoChex-Paid' or paymenttype='Worldpay-Paid' "
               SQL = SQL & " or paymenttype='Cash on Delivery' ) and printed = no  and  DateDiff('s',[orderdate],'" & DateCondition & "') >=30 and DateDiff('d',[orderdate],'" & DateCondition & "') <= 1   and IdBusinessDetail=" & rID    
               SQL = SQL & " and id not in (select orderid from Order_Receipt_tracking ort where ort.orderid = ORDERS.id  )  and ORDERS.OrderDate is not null "
               SQL = SQL & " ORDER BY ORDERS.OrderDate  "
               SQL = SQL & " Union "    
               SQL = SQL & " select top 1   o.ID,o.OrderDate,s_filename  from ORDERS as o , Order_Receipt_tracking b  where o.ID  = b.Orderid and b.s_printstatus = 'NEW' "
               SQL = SQL & " and  (paymenttype='Paypal-Paid' or paymenttype='NoChex-Paid' or paymenttype='Worldpay-Paid' "
               SQL = SQL & " or paymenttype='Cash on Delivery' ) and DateDiff('s',[orderdate],'" & DateCondition & "') >=30 and DateDiff('d',[orderdate],'" & DateCondition & "') <= 1   and o.IdBusinessDetail=" & rID
     
        objRds2.Open SQL, objCon2
       
            Response.Write(SQL & "<br/>")

        while  not objRds2.EOF 
                Response.Write("OrderID " & objRds2("ID") & " file name " & objRds2("s_filename")  & "<br/>")
                objRds2.movenext()
        wend
                objRds2.close()
            set objRds2 = nothing
            objCon2.close()
        set objCon2 = nothing
%>