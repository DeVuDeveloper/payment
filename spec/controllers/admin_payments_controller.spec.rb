require 'rails_helper'

RSpec.describe Admin::PaymentsController, type: :controller do
  let(:user) { create(:user) }

  before do
    user.update(role: 'admin', verified: true)
    sign_in user
  end

  describe "GET #index" do
    it "returns http success" do
      mock_successful_fetched_transaction = {
        "data": {
          "transaction": {
            "id": "my_id",
            "amount": {
              "value": "12.12",
              "currencyIsoCode": "EUR"
            }
          }
        },
        "extensions": {
          "requestId": "abc-request-123-id"
        }
      }

      gateway_double = instance_double(Braintree::Gateway)

      allow(gateway_double).to receive_message_chain(:transaction, :search)
        .and_return(mock_successful_fetched_transaction)

      controller.instance_variable_set(:@gateway, gateway_double)

      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
