document.addEventListener('turbo:load', function () {
  const cartButtons = document.querySelectorAll('.cart-send');

  cartButtons.forEach(function (cartButton) {
    cartButton.addEventListener('click', function (event) {
      event.preventDefault();

      setTimeout(function () {
        const cartData = JSON.parse(localStorage.getItem('cart-products')) || [];
     
      fetch('/products/create_product_ids', {
          method: 'POST',
          headers: {
            "Content-Type": "application/json",
            Accept: "text/html",
            "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').getAttribute("content"),
          },
          body: JSON.stringify({ cart_data: cartData })

        }).then(response => {
          if (response.ok) {
            console.log('Data about cart successfully sent to server');
          } else {
            console.error('Error during sending data to server.');
          }
        }).catch(error => {
          console.error('Error during sending data to server:', error);
        });

      }, 1000);
    });
  });
});



  