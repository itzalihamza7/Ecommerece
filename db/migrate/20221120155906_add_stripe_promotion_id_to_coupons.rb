# frozen_string_literal: true

class AddStripePromotionIdToCoupons < ActiveRecord::Migration[5.2]
  def change
    add_column :coupons, :stripe_promotion_id, :string
  end
end
