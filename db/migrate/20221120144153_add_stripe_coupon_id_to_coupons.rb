# frozen_string_literal: true

class AddStripeCouponIdToCoupons < ActiveRecord::Migration[5.2]
  def change
    add_column :coupons, :stripe_coupon_id, :string
  end
end
