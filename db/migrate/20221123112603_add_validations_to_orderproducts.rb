# frozen_string_literal: true

class AddValidationsToOrderproducts < ActiveRecord::Migration[5.2]
  def change
    change_column_null :orderproducts, :quantity, false
    change_column_null :orderproducts, :product_id, false
    change_column_null :orderproducts, :order_id, false
  end
end
