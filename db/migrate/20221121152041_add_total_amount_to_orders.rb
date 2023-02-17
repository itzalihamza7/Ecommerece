# frozen_string_literal: trues

class AddTotalAmountToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :total_amount, :integer
  end
end
