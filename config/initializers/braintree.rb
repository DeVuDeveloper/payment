# Dotenv.load

if !ENV['BRAINTREE_ENV'] || !ENV["BRAINTREE_MERCHANT_ID"] || !ENV['BRAINTREE_PUBLIC_KEY']|| !ENV['BRAINTREE_PRIVATE_KEY']
  raise "Cannot find necessary environmental variables.";
end
