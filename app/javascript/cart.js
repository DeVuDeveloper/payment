document.addEventListener('turbo:load', function () {
  function updateCartInNavbar() {
    const cartCountElement = document.getElementById('cart-count');


    const cartProducts = JSON.parse(localStorage.getItem('cart-products')) || [];

    if (cartCountElement) {
      cartCountElement.textContent = cartProducts.length;
    }
  }

  document.body.addEventListener('click', function (event) {
    if (event.target.classList.contains('cart-button')) {
      const button = event.target;
      const productId = button.getAttribute('data-product-id');
      console.log('Kliknut proizvod ID:', productId);

      let carts = JSON.parse(localStorage.getItem('cart-products')) || [];
      
      console.log('Podaci o korpi pre dodavanja:', carts);

      if (!carts.some(product => product.id === productId)) {
        carts.push({ id: productId });
        button.classList.add('active');

        localStorage.setItem('cart-products', JSON.stringify(carts));

        console.log('Podaci o korpi nakon dodavanja:', carts);

      } else {
        const index = carts.findIndex(product => product.id === productId);
        if (index > -1) {
          carts.splice(index, 1);
          button.classList.remove('active');

          localStorage.setItem('cart-products', JSON.stringify(carts));

          console.log('Podaci o korpi nakon uklanjanja:', carts);
        }
      }

      updateCartInNavbar();
    }
  });

  updateCartInNavbar();
});

