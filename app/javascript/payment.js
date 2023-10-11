document.addEventListener('turbo:load', function() {
    const form = document.querySelector('#payment-form');
    const client_token = document.querySelector('[name="client_token"]').value;
  
    braintree.dropin.create({
      authorization: client_token,
      container: '#bt-dropin',
      paypal: {
        flow: 'vault'
      }
    }, function (createErr, instance) {
      form.addEventListener('submit', function (event) {
        event.preventDefault();
  
        instance.requestPaymentMethod(function (err, payload) {
          if (err) {
            console.log('Error', err);
            return;
          }
  
          document.querySelector('#nonce').value = payload.nonce;
          form.submit();
        });
      });
    });
  
  });