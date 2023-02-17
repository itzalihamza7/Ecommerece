# frozen_string_literal: true

class AddValidationsToUser < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :name, false
    change_column_null :users, :stripe_customer_id, false
  end
end
