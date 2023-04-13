# frozen_string_literal: true

FactoryBot.define do
  factory :tea do
    name { Faker::Tea.variety }
    variety { Faker::Tea.type }
    brew_time { Faker::Number.within(range: 0.5..4.0) }
    price { Faker::Number.number(digits: 2) }
  end
end
