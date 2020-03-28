<%@ LANGUAGE = "VBSCRIPT" %>
<!-- #include file="../../Config.asp" -->
<!DOCTYPE html>
<html>
<head>
    <title></title>
	<meta charset="utf-8" />

</head>
<body>
   
   <form action="<%=SITE_URL %>test/stripe/testprocess.asp" method="POST">
  <script
    src="https://checkout.stripe.com/checkout.js" class="stripe-button"
    data-key="pk_test_msFLtboqHE37UUP0S6gVNK8p"
    data-amount="999"
    data-name="Demo Site"
    data-description="Example charge"
    data-image="https://stripe.com/img/documentation/checkout/marketplace.png"
    data-locale="auto">
  </script>
       <input type="hidden" value="999" name="txtAmount" />
</form>
</body>
</html>
