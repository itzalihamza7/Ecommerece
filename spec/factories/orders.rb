# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    total_amount { Faker::Number.decimal(l_digits: 4) }
    association :user
  end
end
