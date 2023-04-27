# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user
  has_many :orderproducts, dependent: :destroy
  has_many :products, through: :orderproducts, dependent: :destroy

  validates :total_amount, presence: true, numericality: { greater_than: 0 }
end
