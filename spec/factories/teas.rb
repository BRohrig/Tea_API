FactoryBot.define do
  factory :tea do
    name { Faker::Tea.variety }
    variety { Faker::Tea.type }
    brew_time { Faker::Number.within(range: 0.5..4.0) }
  end
end