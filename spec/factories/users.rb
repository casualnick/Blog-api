FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "example#{n}@email.com" }
    password { "12345678" }
    password_confirmation { "12345678" }
    name { Faker::Name.name }
  end
end
