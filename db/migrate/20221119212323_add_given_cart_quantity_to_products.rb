# frozen_string_literal: true

class AddGivenCartQuantityToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :given_cart_quantity, :integer
  end
end
