FactoryBot.define do
  factory :orderable do
    association :cart, factory: :cart
    association :product, factory: :product
    quantity { 1 }
  end
end
