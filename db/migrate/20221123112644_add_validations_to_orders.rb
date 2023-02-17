# frozen_string_literal: true

class AddValidationsToOrders < ActiveRecord::Migration[5.2]
  def change
    change_column_null :orders, :user_id, false
    change_column_null :orders, :total_amount, false
  end
end
