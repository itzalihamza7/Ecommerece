# frozen_string_literal: true

class SetDefaultToGivenCartQuantityToProducts < ActiveRecord::Migration[5.2]
  def change
    change_column :products, :given_cart_quantity, :integer, default: 1
  end
end
