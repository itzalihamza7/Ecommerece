# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :user do
    name { Faker::Lorem.sentence }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    password_confirmation { password }

    trait :with_avatar do
      avatar { Rack::Test::UploadedFile.new('spec/support/images/user.JPEG', 'image/JPEG') }
    end

    trait :Admin do
      role { :Admin }
    end

    trait :Seller do
      role { :Seller }
    end

    trait :Customer do
      role { :Customer }
    end
  end
end
