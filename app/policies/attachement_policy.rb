# frozen_string_literal: true

class AttachementPolicy < ApplicationPolicy
  def initialize(user, record)
    @user = user
    @record = record
    super
  end

  def destroy?
    user && user == record.record.user || user.Admin?
  end
end
