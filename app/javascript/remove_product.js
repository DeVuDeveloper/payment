document.addEventListener("turbo:load", function () {
  const cartButtons = document.querySelectorAll(".remove-from-cart");

  cartButtons.forEach((button) => {
    button.addEventListener("click", function () {
      const productId = button.dataset.productId;
      console.log("productId:", productId);

      const cartCountElement = document.getElementById("cart-count");
      let cartCount = parseInt(cartCountElement.textContent);
      cartCount -= 1;
      cartCountElement.textContent = cartCount;

      removeFromLocalStorage(productId);
    });
  });

  function removeFromLocalStorage(productId) {
    const cartItems = JSON.parse(localStorage.getItem("cart_products")) || [];

    const updatedCartItems = cartItems.filter((item) => item.id !== productId);
    if (updatedCartItems > -1) {
      cartItems.splice(updatedCartItems, 1);
      localStorage.setItem("cart-products", JSON.stringify(cartItems));
    }
  }
});
