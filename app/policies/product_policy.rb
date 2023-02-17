# frozen_string_literal: true

class ProductPolicy < ApplicationPolicy
  def initialize(user, record)
    @user = user
    @record = record
    super
  end

  def show?
    true
  end

  def index?
    user && user == record.user && user.Seller? || user.Admin? unless record.nil?
  end

  def edit?
    user.Seller? && user == record.user || user.Admin?
  end

  def create?
    user.Seller? || user.Admin?
  end

  def update?
    index?
  end

  def destroy?
    update?
  end
end
