# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  def initialize(user, record)
    @user = user
    @record = record
    super
  end

  def create?
    user
  end

  def edit?
    user && user == record.user
  end

  def update?
    edit?
  end

  def destroy?
    edit? || user.Admin?
  end
end
