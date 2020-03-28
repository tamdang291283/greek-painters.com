<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../../Config.asp" -->
<!-- #include file="../timezone.asp" -->
<!-- #include file="../restaurantsettings.asp" -->
<%
    dim objCon :   Set objCon = Server.CreateObject("ADODB.Connection")
                objCon.Open sConnStringcms
    dim OrderID : OrderID = Request.QueryString("oid")
    dim tip : tip = Request.QueryString("tip")
    dim card : card  = Request.QueryString("card")
    dim isUpdateTip : isUpdateTip = Request.QueryString("edittip")
    if OrderID & "" <> "" then
        if IsNumeric(OrderID) then
            dim SQL :SQL = "Update orders set Tip_Amount = " & tip & "" 
                     if card = "D" then
                      SQL = SQL & ",payment_status='Paid',Card_Debit=1,Card_Credit=0 "      
                     elseif card = "C" then  
                        SQL = SQL & ",payment_status='Paid',Card_Debit=0,Card_Credit=1 "    
                     elseif card = "Cash" then
                        SQL = SQL & ",paymenttype='Cash on Delivery',Card_Debit=0,Card_Credit=0 "  
                     end if  
                     if isUpdateTip = "y" then 
                        SQL = SQL & ",Tip_Rate='custom' "   
                     end if
                     SQL = SQL & " where ID = " &   OrderID
            objCon.execute(SQL)
             objCon.close()
            set objCon = nothing
                Response.Write("OK")
                
                Response.End
        end if
    end if
     %>