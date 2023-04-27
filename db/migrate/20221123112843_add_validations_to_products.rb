# frozen_string_literal: true

class AddValidationsToProducts < ActiveRecord::Migration[5.2]
  def change
    change_column_null :products, :title, false
    change_column_null :products, :price, false
    change_column_null :products, :description, false
    change_column_null :products, :stripe_product_id, false
    change_column_null :products, :stripe_price_id, false
    change_column :products, :description, :text, limit: 1000
  end
end
