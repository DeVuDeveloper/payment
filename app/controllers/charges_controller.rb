class ChargesController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery with: :null_session
  before_action :set_cart

  include BraintreeGatewayConcern

  def new
    @client_token = gateway.client_token.dig("data", "createClientToken", "clientToken")
    return unless @cart

    @cart_products = @cart.orderables.includes(:product).map(&:product)
  end

  def create
    amount = params["amount"]
    nonce = params["payment_method_nonce"]

    begin
      result = gateway.transaction(nonce, amount)
      id = result.dig("data", "chargePaymentMethod", "transaction", "id")

      raise BraintreeGateway::GraphQLError, result unless id

      redirect_to new_charge_path
      flash[:notice] = "Transaction was successful!"
    rescue BraintreeGateway::GraphQLError => e
      _flash_errors(e)
      redirect_to new_charge_path
    end
  end

  private

  def set_cart
    @cart = Cart.last
  end

  def gateway
    @gateway ||= BraintreeGateway.new(HTTParty)
  end

  def _flash_errors(error)
    flash[:error] = if !error.messages.nil? && !error.messages.empty?
                      error.messages
                    else
                      ["Error: Something unexpected went wrong! Try again."]
                    end
  end
end
