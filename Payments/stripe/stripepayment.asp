                                    <script src="https://js.stripe.com/v3/"></script>
                                    <div id="payment-request-button" style="display:none;"></div>
                                    <script type="text/javascript">
                                        var stripe = Stripe('<%=STRIPEKEY%>');
                                        var paymentRequest = stripe.paymentRequest({
                                            country: '<%=Stripe_Country%>',
                                            currency: '<%=lcase(Currency_STRIPE)%>',
                                            total: {
                                                label: 'Order Total',
                                                 amount: <%=cdbl(FormatNumber(vOrderTotal + CREDITCARDSURCHARGE,2)) * 100 %>,
                                                
                                            },
                                            requestPayerName: true,
                                            requestPayerEmail: true,
                                        });

                                        var elements = stripe.elements();
                                        var prButton = elements.create('paymentRequestButton', {
                                            paymentRequest: paymentRequest,
                                        });
                                        // Check the availability of the Payment Request API first.
                                        paymentRequest.canMakePayment().then(function(result) {
                                            
                                            if (result) {
                                                prButton.mount('#payment-request-button');
                                                $("#idsurchage").show();   
                                            } else {
                                                document.getElementById('payment-request-button').style.display = 'none';
                                            }
                                        });

                                        paymentRequest.on('token', function(ev) {
                                            // Send the token to your server to charge it!
                                            console.log(ev);
                                            $("#Stripe_Token").val(ev.token.id);
                                            $("#frmMakeOrder").submit();
                                            /*
                                            fetch('/charges', {
                                                method: 'POST',
                                                body: JSON.stringify({token: ev.token.id}),
                                                headers: {'content-type': 'application/json'},
                                            })
                                            .then(function(response) {
                                                if (response.ok) {
                                                    // Report to the browser that the payment was successful, prompting
                                                    // it to close the browser payment interface.
                                                    ev.complete('success');
                                                } else {
                                                    // Report to the browser that the payment failed, prompting it to
                                                    // re-show the payment interface, or show an error message and close
                                                    // the payment interface.
                                                    ev.complete('fail');
                                                }
                                            });
                                            */
                                        });
                                        elements.create('paymentRequestButton', {
                                            paymentRequest: paymentRequest,
                                            style: {
                                                paymentRequestButton: {
                                                    type: 'default' | 'donate' | 'buy', // default: 'default'
                                                    theme: 'dark' | 'light' | 'light-outline', // default: 'dark'
                                                    height: '64px', // default: '40px', the width is always '100%'
                                                },
                                            },
                                        });
                                    </script>