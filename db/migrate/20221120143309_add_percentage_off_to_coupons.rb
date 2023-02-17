# frozen_string_literal: true

class AddPercentageOffToCoupons < ActiveRecord::Migration[5.2]
  def change
    add_column :coupons, :percentage_off, :integer
  end
end
