# frozen_string_literal: true

class Product < ApplicationRecord
  include StripeProduct

  belongs_to :user
  has_one_attached :header_image
  has_many_attached :description_images
  has_many :comments, dependent: :destroy
  has_many :orderproducts, dependent: :destroy
  has_many :orders, through: :orderproducts, dependent: :destroy

  validates :header_image, :description_images,
            blob: { content_type: ['image/png', 'image/jpg', 'image/webp', 'image/jpeg'] }
  validates :title, presence: true, length: { minimum: 5, maximum: 20 }
  validates :description, presence: true, length: { minimum: 10, maximum: 200 }
  validates :price, presence: true, numericality: { greater_than: 0 }

  def serial_number
    format('PLN-%.6d', id)
  end
end
