# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    title { Faker::Commerce.product_name.truncate(20) }
    description { Faker::Lorem.paragraph }
    price { Faker::Number.decimal(l_digits: 2) }
    association :user

    trait :with_header_image do
      header_image { Faker::LoremFlickr.image }
    end

    trait :with_description_images do
      description_images { Faker::LoremFlickr.image }
    end
  end
end
