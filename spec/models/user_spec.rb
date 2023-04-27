# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Associations' do
    it { is_expected.to have_one_attached(:avatar) }
    it { is_expected.to have_many(:products).dependent(:destroy) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:orders).dependent(:destroy) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to allow_value('a@mail.com').for(:email) }
    it { is_expected.not_to allow_value('amail.com').for(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
  end

  describe 'Enums' do
    it { is_expected.to define_enum_for(:role).with_values(Customer: 0, Seller: 1, Admin: 2) }
  end

  describe 'Methods' do
    it 'returns a formatted avatar' do
      user = create(:user, :with_avatar)
      expect(user.avatar_thumbnail.variation.transformations).to eq({ resize: '300x300' }) if user.avatar.attached?
    end
  end
end
