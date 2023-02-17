# frozen_string_literal: true

class RemoveSerialNumberFromProducts < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :serial_number, :string
  end
end
