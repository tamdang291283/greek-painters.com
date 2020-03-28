<?php
// Include stripe-php as you usually do, either with composer as shown,
// or with a direct require, as commented out.
//require_once("vendor/autoload.php");
 require_once("/stripe-php/init.php");

\Stripe\Stripe::setApiKey("sk_test_BQokikJOvBiI2HlWgH4olfQ2");
\Stripe\Stripe::$apiBase = "https://api-tls12.stripe.com";
try {
  \Stripe\Charge::all();
  echo "TLS 1.2 supported, no action required.";
} catch (\Stripe\Error\ApiConnection $e) {
  echo "TLS 1.2 is not supported. You will need to upgrade your integration.";
}
?>