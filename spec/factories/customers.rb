# frozen_string_literal: true

FactoryBot.define do
  factory :customer do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    zip_code { Faker::Address.zip_code }
    email { Faker::Internet.email }
    password { Faker::Alphanumeric.alphanumeric(number: 6) }
  end
end
