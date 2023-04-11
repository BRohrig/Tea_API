FactoryBot.define do
  factory :subscription do
    nickname { Faker::Superhero.name }
    price { Faker::Number.number(digits: 2)}
    status { ["Active", "Inactive"].sample }
    frequency { ["Daily", "Weekly", "Montly", "Bimonthly", "Yearly"].sample }
  end
end