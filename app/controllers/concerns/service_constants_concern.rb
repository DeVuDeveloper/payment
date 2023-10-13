module ServiceConstantsConcern
  extend ActiveSupport::Concern

  LOGGER = ::Logger.new($stdout)
  ENDPOINT = "https://payments.sandbox.braintree-api.com/graphql".freeze
  CONTENT_TYPE = "application/json".freeze
  VERSION = ENV["BRAINTREE_VERSION"]
  BASIC_AUTH_USERNAME = ENV["BRAINTREE_PUBLIC_KEY"]
  BASIC_AUTH_PASSWORD = ENV["BRAINTREE_PRIVATE_KEY"]
end
