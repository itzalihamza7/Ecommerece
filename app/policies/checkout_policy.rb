# frozen_string_literal: true

class CheckoutPolicy < ApplicationPolicy
  def initialize(user, record)
    @user = user
    @record = record
    super
  end

  def success?
    user && user == record
  end

  def checkout_cart?
    @cart = Product.find(record[:cart])
    @cart.each do |item|
      return false unless user && user != item.user
    end
  end

  def buy_now?
    user && user != record.user
  end
end
