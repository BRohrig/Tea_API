# frozen_string_literal: true

FactoryBot.define do
  factory :subscription do
    nickname { Faker::Superhero.name }
    price { Faker::Number.number(digits: 2) }
    status { %w[Active Inactive].sample }
    frequency { %w[Daily Weekly Montly Bimonthly Yearly].sample }
  end
end
