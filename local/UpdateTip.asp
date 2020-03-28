<% if session("restaurantid") & "" = "" Then
    session("restaurantid")=Request.QueryString("id_r")
        
    End If %>
<!-- #include file="Config.asp" -->
<!-- #include file="../timezone.asp" -->
<!-- #include file="../restaurantsettings.asp" -->

<%
    dim vRestaurantId,vOrderSubTotal,vOrderShipTotal,Tax_Amount,ServiceCharge,orderTotalAmount,orderid
Set objCon = Server.CreateObject("ADODB.Connection")
Set objRds = Server.CreateObject("ADODB.Recordset") 
    vRestaurantId = Request.QueryString("id_r")
    orderid = Request.QueryString("oid")
    dim tipValue : tipValue =  Request.QueryString("tipamount")
    dim tipRate : tipRate =  Request.QueryString("tr")

        objCon.Open sConnString
        objRds.Open "select o.* from [OrdersLocal] o " & _
            " Where o.IdBusinessDetail = " & vRestaurantId & _
            " And o.ID = " & orderid , objCon, 1, 3 
        tipValue = replace(tipValue,CURRENCYSYMBOL,"")
        objRds("Tip_Amount") = cdbl(tipValue) 
        objRds("Tip_Rate") = tipRate
        vOrderSubTotal = cdbl(objRds("SubTotal"))
		vOrderShipTotal = cdbl(objRds("ShippingFee"))
        Tax_Amount = cdbl(objRds("Tax_Amount"))
        ServiceCharge = cdbl(objRds("ServiceCharge"))
	    orderTotalAmount = vOrderSubTotal + vOrderShipTotal + ServiceCharge + Tax_Amount + cdbl(tipValue)
         objRds("OrderTotal") = orderTotalAmount
        objRds.Update 
    
        objRds.Close
        objCon.Close 
        Response.Write(FormatNumber(orderTotalAmount,2))

     %>