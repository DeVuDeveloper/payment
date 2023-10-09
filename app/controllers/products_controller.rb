class ProductsController < ApplicationController
  before_action :set_cart

  def index
    @user = current_user
    @products = Product.all
  end

  def cart_products
    @products_ids = @cart.product_ids
    @cart_products = Product.where(id: @products_ids)
  end

  def create_product_ids
    cart_data = params["cart_data"]
    @cart_data = cart_data.map { |item| item[:id] }
    puts "Cart data: #{@cart_data}"
    product_ids = @cart_data.map(&:to_i)
    puts "IDS: #{product_ids}"
    if @cart
      @cart.update(product_ids: product_ids)
    else
      @cart = Cart.create(product_ids: product_ids)
    end

    respond_to do |format|
      format.html { redirect_to cart_products_products_path }
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "cart_products",
          partial: "products/cart_products",
          locals: { cart_products: @cart_products },
        )
      end
    end
  end

  def add_to_cart
    @product = Product.find_by(id: params[:id])
    quantity = params[:quantity].to_i
    current_orderable = @cart.orderables.find_by(product_id: @product.id)

    if current_orderable
      if quantity > 0
        current_orderable.update(quantity: current_orderable.quantity + 1)
      elsif quantity < 0
        new_quantity = current_orderable.quantity > 1 ? current_orderable.quantity - 1 : 1 # Ovde se postavlja minimalna vrednost na 1
        current_orderable.update(quantity: new_quantity)
      else
        current_orderable.destroy
      end
    elsif quantity > 0
      @cart.orderables.create(product: @product, quantity: 1)
    end

    if @cart.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [turbo_stream.replace("quantity_#{@product.id}",
                                                     partial: "products/cart_product_quantity",
                                                     locals: { product: @product }),
                                turbo_stream.replace(@product)]
        end
      end
    end
  end

  def remove_from_cart
    product_id = params[:product_id].to_i
    orderable = @cart.orderables.find_by(product_id: product_id)
  
    if orderable
      orderable.destroy
  
      respond_to do |format|
        format.html { redirect_to cart_products_products_path }
        format.turbo_stream do
          render turbo_stream: turbo_stream.remove("cart_product_#{product_id}")
        end
      end
    end
  end
  
  private

  def set_cart
    @cart = Cart.last
  end
end
