FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.paragraphs }
    sequence(:post_id) { |n| "#{n}" }
    sequence(:user_id) { |n| "#{n}" }
  end
end
