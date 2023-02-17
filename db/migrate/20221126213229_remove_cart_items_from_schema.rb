# frozen_string_literal: true

class RemoveCartItemsFromSchema < ActiveRecord::Migration[5.2]
  def change
    drop_table :cart_items do |t|
      t.integer :quantity
      t.references :product, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
