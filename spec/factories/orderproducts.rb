# frozen_string_literal: true

FactoryBot.define do
  factory :orderproduct do
    quantity { Faker::Number.between(from: 1, to: 5) }
    association :product
    association :order
  end
end
