FactoryBot.define do
  factory :cart do
    after(:create) do |cart|
      cart.product_ids = create_list(:product, 3).map(&:id)
      cart.save
    end
  end
end
