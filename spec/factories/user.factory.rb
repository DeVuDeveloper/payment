FactoryBot.define do
  factory :user do
    email { "admin@example.com" }
    password { "password" }
    role { "admin" }
  end
end