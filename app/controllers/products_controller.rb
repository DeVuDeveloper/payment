class ProductsController < ApplicationController
  before_action :set_cart

  def index
    @user = current_user
    @products = Product.all
  end

  def cart_products
    @products_ids = @cart.product_ids
    @cart_products = Product.where(id: @products_ids)
    @cart_empty = @cart_products.empty?
  end

  def create_product_ids
    cart_data = params["cart_data"]
    @cart_data = cart_data.map { |item| item[:id] }
    puts "Cart data: #{@cart_data}"
    product_ids = @cart_data.map(&:to_i)
    puts "IDS: #{product_ids}"
    if @cart
      @cart.update(product_ids:)
    else
      @cart = Cart.create(product_ids:)
    end

    respond_to do |format|
      format.html { redirect_to cart_products_products_path }
      format.turbo_stream
    end
  end

  def add_to_cart
    @product = Product.find_by(id: params[:id])
    quantity = params[:quantity].to_i
    current_orderable = @cart.orderables.find_by(product_id: @product.id)

    if current_orderable
      if quantity.positive?
        current_orderable.update(quantity: current_orderable.quantity + 1)
      elsif quantity.negative?
        new_quantity = current_orderable.quantity > 1 ? current_orderable.quantity - 1 : 1
        current_orderable.update(quantity: new_quantity)
      else
        current_orderable.destroy
      end
    elsif quantity.positive?
      @cart.orderables.create(product: @product, quantity: 1)
    end

    return unless @cart.save

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [turbo_stream.replace("quantity_#{@product.id}",
                                                   partial: "products/cart_product_quantity",
                                                   locals: { product: @product }),
                              turbo_stream.replace(@product),
                              turbo_stream.replace("price_#{@product.id}",
                                                   partial: "products/total_product_price",
                                                   locals: { product: @product }),
                              turbo_stream.replace("cart_total", partial: "products/cart_total")]
      end
    end
  end

  def remove_from_cart
    product_id = params[:product_id].to_i
    orderable = @cart.orderables.find_by(product_id:)

    return unless orderable

    orderable.destroy

    @products_ids = @cart.product_ids
    @cart_products = Product.where(id: @products_ids)
    @cart_empty = @cart_products.empty?

    respond_to do |format|
      format.html { redirect_to cart_products_products_path }
      format.turbo_stream do
        turbo_stream_actions = [turbo_stream.remove("cart_product_#{product_id}"),
                                turbo_stream.replace("cart_total", partial: "products/cart_total")]
        turbo_stream_actions << turbo_stream.replace("cart_products", partial: "products/empty_state") if @cart_empty
        render turbo_stream: turbo_stream_actions
      end
    end
  end

  private

  def set_cart
    @cart = Cart.last
  end
end
