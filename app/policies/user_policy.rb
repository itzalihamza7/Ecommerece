# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def initialize(user, record)
    @user = user
    @record = record
    super
  end

  def show?
    user && user == record || user.Admin?
  end

  def index?
    show?
  end

  def update_role?
    show?
  end
end
