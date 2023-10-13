module BraintreeGatewayConcern
  extend ActiveSupport::Concern

  TRANSACTION_SUCCESS_STATUSES = [
    Braintree::Transaction::Status::Authorizing,
    Braintree::Transaction::Status::Authorized,
    Braintree::Transaction::Status::Settled,
    Braintree::Transaction::Status::SettlementConfirmed,
    Braintree::Transaction::Status::SettlementPending,
    Braintree::Transaction::Status::Settling,
    Braintree::Transaction::Status::SubmittedForSettlement
  ].freeze

  included do
    before_action :set_gateway, only: %i[index]
  end

  private

  def set_gateway
    env = ENV["BRAINTREE_ENV"]
    @gateway ||= Braintree::Gateway.new(
      environment: env&.to_sym,
      merchant_id: ENV["BRAINTREE_MERCHANT_ID"],
      public_key: ENV["BRAINTREE_PUBLIC_KEY"],
      private_key: ENV["BRAINTREE_PRIVATE_KEY"]
    )
  end
end
