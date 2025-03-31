FactoryBot.define do
  factory :user do
    first_name { "John" }
    last_name { "Doe" }
    email { Faker::Internet.email }
    # phone_number { "1224567899" } # Ensure it's exactly 10 digits
    # sequence(:phone_number) { |n| "123456789#{n}" } # Ensure unique phone numbers
    # phone_number { Faker::Number.number(digits: 10) } # Ensure it is exactly 10 digits
    phone_number { Faker::Number.leading_zero_number(digits: 10) }
    password { "password123" }
    password_confirmation { "password123" }
  end

  trait :admin do
    after(:create) { |user| user.add_role(:admin) } # Assuming you're using rolify or a similar role management gem
  end
end
