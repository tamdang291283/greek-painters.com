<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Google test</title>
	
	<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-70697130-1', 'auto');
  ga('send', 'pageview');
  ga('require', 'ecommerce');
  
ga('ecommerce:addTransaction', {
  'id': '1234',                     // Transaction ID. Required.
  'affiliation': 'Acme Clothing',   // Affiliation or store name.
  'revenue': '11.99',               // Grand Total.
  'shipping': '5',                  // Shipping.
  'tax': '1.29'                     // Tax.
});

ga('ecommerce:addItem', {
  'id': '1234',                     // Transaction ID. Required.
  'name': 'Fluffy Pink Bunnies',    // Product name. Required.
  'sku': 'DD23444',                 // SKU/code.
  'category': 'Party Toys',         // Category or variation.
  'price': '11.99',                 // Unit price.
  'quantity': '1'                   // Quantity.
});

ga('ecommerce:send');

</script>

</head>

<body>





</body>
</html>
