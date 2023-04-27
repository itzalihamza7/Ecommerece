# frozen_string_literal: true

class ChangeDataTypeForPriceInProducts < ActiveRecord::Migration[5.2]
  def change
    change_column :products, :price, :integer
  end
end
