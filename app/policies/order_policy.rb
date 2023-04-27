# frozen_string_literal: true

class OrderPolicy < ApplicationPolicy
  def initialize(user, record)
    @user = user
    @record = record
    super
  end

  def index?
    user && user == record.user || user.Admin?
  end

  def show?
    index?
  end
end
