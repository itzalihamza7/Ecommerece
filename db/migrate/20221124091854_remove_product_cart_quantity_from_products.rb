# frozen_string_literal: true

class RemoveProductCartQuantityFromProducts < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :given_cart_quantity, :integer
  end
end
