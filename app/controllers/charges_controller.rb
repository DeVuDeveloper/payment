class ChargesController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery with: :null_session
  include BraintreeGatewayConcern

  def new
    @client_token = @gateway.client_token.generate
    @cart = Cart.first
    @cart_products = @cart.orderables.includes(:product).map(&:product)
    @charge = Charge.new
  end

  def create
    amount = params["amount"]
    nonce = params["payment_method_nonce"]

    result = @gateway.transaction.sale(
      amount: amount,
      payment_method_nonce: nonce,
      options: {
        submit_for_settlement: true,
      },
    )

    if result.success? || result.transaction
      flash[:notice] = "Transaction was successful!"
    else
      error_messages = result.errors.map { |error| "Error: #{error.code}: #{error.message}" }
      flash[:alert] = error_messages
    end

    redirect_to new_charge_path
  end
end
