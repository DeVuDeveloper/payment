FactoryBot.define do
  factory :charge do
    user { nil }
    amount { "9.99" }
    transaction_id { "MyString" }
    status { "MyString" }
  end
end
