# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_one_attached(:header_image) }
    it { is_expected.to have_many_attached(:description_images) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:orderproducts).dependent(:destroy) }
    it { is_expected.to have_many(:orders).through(:orderproducts).dependent(:destroy) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_least(5).is_at_most(20) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_length_of(:description).is_at_least(10).is_at_most(200) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than(0) }
  end

  describe 'methods' do
    it 'returns a formatted serial number' do
      product = create(:product)
      expect(product.serial_number).to eq("PLN-#{format('%.6d', product.id)}")
    end
  end
end
