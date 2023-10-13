module Admin
  class PaymentsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin!
    before_action :set_product, only: %i[edit update destroy]
    layout "admin"

    include BraintreeGatewayConcern

    def index
      @transactions = @set_gateway.transaction.search do |search|
        search.status.in(TRANSACTION_SUCCESS_STATUSES)
      end

      @page_title = "Transactions"
    end

    private

    def authorize_admin!
      return if current_user&.admin?

      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end
