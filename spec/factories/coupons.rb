# frozen_string_literal: true

FactoryBot.define do
  factory :coupon do
    code_name { Faker::Code.asin }
    percentage_off { Faker::Number.between(from: 1, to: 100) }
    valid_til { Faker::Date.forward(days: 30) }
  end
end
