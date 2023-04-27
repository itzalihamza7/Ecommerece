# frozen_string_literal: true

class AddValidationsToCoupons < ActiveRecord::Migration[5.2]
  def change
    change_column :coupons, :code_name, :string, null: false
    change_column :coupons, :valid_til, :datetime, null: false
    change_column :coupons, :percentage_off, :integer, null: false, limit: 2
    change_column :coupons, :stripe_coupon_id, :string, null: false
    change_column :coupons, :stripe_promotion_id, :string, null: false
  end
end
