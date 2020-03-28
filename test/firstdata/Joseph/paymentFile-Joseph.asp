<!-- #include file="ipg-util.asp"-->

<html>

<head><title>IPG Connect Sample for ASP</title></head>

<body>

<p><h1>Order Form</h1></p>

<form method="post" action=" https://test.ipg-online.com/connect/gateway/processing ">

<input type="hidden" name="txntype" value="sale">

<input type="hidden" name="timezone" value="Europe/London"/>

<input type="hidden" name="txndatetime" value="<% getDateTime() %>"/>

<input type="hidden" name="hash_algorithm" value="SHA256"/>

<input type="hidden" name="hash" value="<% call createHash( "13.00","826" ) %>"/>

<input type="hidden" name="storename" value="10123456789" />

<input type="hidden" name="mode" value="payonly"/>

<input type="hidden" name="paymentMethod" value="M"/>

<input type="text" name="chargetotal" value="13.00" />

<input type="hidden" name="currency" value="826"/>

<input type="submit" value="Submit">

</form>

</body>

</html>