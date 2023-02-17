# frozen_string_literal: true

class CreateCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :coupons do |t|
      t.string :code_name
      t.datetime :valid_til

      t.timestamps
    end
  end
end
