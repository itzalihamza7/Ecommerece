# frozen_string_literal: true

class Coupon < ApplicationRecord
  include StripeCoupon

  validates :code_name, presence: true, format: { with: /\A(?=.*[0-9].*)(?=.*[A-Z].*)([A-Z0-9]{4,10})\z/ }
  validates :percentage_off, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 100 }
  validates :valid_til, inclusion: { in: ->(_date) { Time.zone.today..Time.zone.today + 5.years } }
end
