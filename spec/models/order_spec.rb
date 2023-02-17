# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:orderproducts).dependent(:destroy) }
    it { is_expected.to have_many(:products).through(:orderproducts).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:total_amount) }
    it { is_expected.to validate_numericality_of(:total_amount).is_greater_than(0) }
  end
end
