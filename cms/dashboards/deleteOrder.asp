<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../../Config.asp" -->
<!-- #include file="../timezone.asp" -->
<!-- #include file="../restaurantsettings.asp" -->
<%
       dim objCon :   Set objCon = Server.CreateObject("ADODB.Connection")
           objCon.Open sConnStringcms
       Dim from :  from  = Request.QueryString("from")
       Dim OrderID :  OrderID  = Request.QueryString("OrderID")
       Dim Mode : Mode = Request.QueryString("mul")
       Dim action : action = Request.QueryString("action")
    
       if OrderID & "" <> "" then
           
           if from = "local" then
                    if action = "delete" then   
                        objCon.execute("delete from  orderitemslocal where OrderId in (" & OrderID & ") " )  
                        objCon.execute("delete from  orderslocal where ID in (" & OrderID  & ") ") 
                    elseif action = "print" then 
                        objCon.execute("update orderslocal set printed = 0 where ID in (" & OrderID & " ) " )                            
                    end if
           else     
                 if action = "delete" or action & "" = "" then         
                    objCon.execute("delete from  orderitems where OrderId in (" & OrderID & " ) ")  
                    objCon.execute("delete from orders where ID in (" & OrderID & " ) " )   
                 elseif action = "print" then         
                    objCon.execute("update orders set printed = 0 where ID in (" & OrderID & " ) " )    
                    objCon.execute("delete from order_receipt_tracking  where orderid in (" & OrderID & " ) " )    
                end if
           end if 
       end if
            objCon.close()
            set objCon = nothing
        Response.Write("OK")
     %>