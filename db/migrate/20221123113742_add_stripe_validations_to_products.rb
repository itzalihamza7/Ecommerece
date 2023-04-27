# frozen_string_literal: true

class AddStripeValidationsToProducts < ActiveRecord::Migration[5.2]
  def change
    change_column_null :products, :stripe_product_id, false
    change_column_null :products, :stripe_price_id, false
  end
end
