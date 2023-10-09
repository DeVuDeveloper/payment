document.addEventListener('turbo:load', function () {
  const cartButtons = document.querySelectorAll('.cart-send');

  cartButtons.forEach(function (cartButton) {
    cartButton.addEventListener('click', function (event) {
      event.preventDefault();

      console.log('Klik na ikonu korpe detektovan.');

      setTimeout(function () {
        const cartData = JSON.parse(localStorage.getItem('cart-products')) || [];
        console.log('Podaci iz localStorage:', cartData);

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
            console.log('Podaci o korpi su uspešno poslati na server.');
          } else {
            console.error('Greška prilikom slanja podataka na server.');
          }
        }).catch(error => {
          console.error('Greška prilikom slanja podataka na server:', error);
        });

      }, 1000); // 1000 ms (1 sekunda) kašnjenja prije nego što se preuzmu podaci iz localStorage i šalju na server
    });
  });
});



  