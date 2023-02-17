# frozen_string_literal: true

class User < ApplicationRecord
  include StripeCustomer
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar
  has_many :products, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :avatar, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg', 'image/webp'] }
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  enum role: { Customer: 0, Seller: 1, Admin: 2 }

  def avatar_thumbnail
    avatar.variant(resize: '300x300') if avatar.attached?
  end
end
