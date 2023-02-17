# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Orderproduct, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:product) }
    it { is_expected.to belong_to(:order) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_numericality_of(:quantity).is_greater_than(0) }
  end
end
