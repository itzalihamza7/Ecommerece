# frozen_string_literal: true

class CartPolicy < ApplicationPolicy
  def initialize(user, record)
    @user = user
    @record = record
    super
  end

  def index?
    user == record[:user] || user.Admin? || user.blank?
  end

  def update?
    index?
  end

  def create?
    user.blank? || user != record.user && user.Customer? || user.Admin?
  end

  def destroy?
    index?
  end
end
