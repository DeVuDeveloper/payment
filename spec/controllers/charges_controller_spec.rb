require 'rails_helper'
require 'support/braintree_mock_data'

RSpec.describe ChargesController, type: :controller do
  let(:user) { create(:user) }

  render_views
  include_context 'braintree_mock_data'

  before do
    user.update(verified: true)
    sign_in user
    @mock_gateway = instance_double("BraintreeGateway")
    allow(@mock_gateway).to receive(:client_token).and_return({
                                                                "data" => {
                                                                  "createClientToken" => {
                                                                    "clientToken" => "your_client_token"
                                                                  }
                                                                }
                                                              })

    allow(BraintreeGateway).to receive(:new).and_return(@mock_gateway)
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "adds the Braintree client token to the page" do
      get :new
      expect(response.body).to match(/your_client_token/)
    end
  end

  describe "POST #create" do
    it "returns http success" do
      amount = "10.00"
      nonce = "fake-valid-nonce"

      allow(@mock_gateway).to receive(:transaction).and_return(mock_created_transaction)

      post :create, params: { payment_method_nonce: nonce, amount: }

      expect(response).to redirect_to("/charges/new")
    end

    context "when braintree returns an error" do
      it "displays graphql errors" do
        amount = "nine and three quarters"
        nonce = "fake-valid-nonce"

        allow(@mock_gateway).to receive(:transaction).and_raise(
          BraintreeGateway::GraphQLError.new(mock_transaction_graphql_error)
        )

        post :create, params: { payment_method_nonce: nonce, amount: }

        expect(flash[:error]).to eq([
                                      "Error: Variable 'amount' has an invalid value. Values of type Amount must contain exactly 0, 2 or 3 decimal places."
                                    ])
      end

      it "displays validation errors" do
        amount = "9.75"
        nonce = "non-fake-invalid-nonce"

        allow(@mock_gateway).to receive(:transaction).and_raise(
          BraintreeGateway::GraphQLError.new(mock_transaction_validation_error)
        )

        post :create, params: { payment_method_nonce: nonce, amount: }

        expect(flash[:error]).to eq([
                                      "Error: Unknown or expired payment method ID."
                                    ])
      end

      it "redirects to the new_checkout_path" do
        amount = "not_a_valid_amount"
        nonce = "not_a_valid_nonce"

        allow(@mock_gateway).to receive(:transaction).and_raise(
          BraintreeGateway::GraphQLError.new(mock_transaction_graphql_error)
        )

        post :create, params: { payment_method_nonce: nonce, amount: }

        expect(response).to redirect_to(new_charge_path)
      end

      it "gracefully handles unexpected errors" do
        amount = "10.10"
        nonce = "a-very-valid-nonce"

        allow(@mock_gateway).to receive(:transaction).and_raise(
          BraintreeGateway::GraphQLError.new({
                                               "data" => nil,
                                               "errors" => nil
                                             })
        )

        post :create, params: { payment_method_nonce: nonce, amount: }

        expect(flash[:error]).to eq([
                                      "Error: Something unexpected went wrong! Try again."
                                    ])
        expect(response).to redirect_to(new_charge_path)
      end
    end
  end
end
