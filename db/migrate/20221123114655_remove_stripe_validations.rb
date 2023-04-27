# frozen_string_literal: true

class RemoveStripeValidations < ActiveRecord::Migration[5.2]
  def change
    change_column_null :products, :stripe_product_id, true
    change_column_null :products, :stripe_price_id, true
    change_column_null :users, :stripe_customer_id, true
    change_column_null :coupons, :stripe_coupon_id, true
    change_column_null :coupons, :stripe_promotion_id, true
  end
end
