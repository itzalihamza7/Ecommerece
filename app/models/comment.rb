# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :product
  belongs_to :user
  validates :body, presence: true, length: { maximum: 1000 }
end
