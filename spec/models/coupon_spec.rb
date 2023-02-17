# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Coupon, type: :model do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:code_name) }
    it { is_expected.to allow_value(Faker::Code.asin).for(:code_name) }
    it { is_expected.not_to allow_value(Faker::Code.ean).for(:code_name) }
    it { is_expected.to validate_presence_of(:percentage_off) }
    it { is_expected.to validate_numericality_of(:percentage_off).is_greater_than(0).is_less_than_or_equal_to(100) }
    it { is_expected.to validate_inclusion_of(:valid_til).in_range(Time.zone.today..Time.zone.today + 5.years) }
  end
end
