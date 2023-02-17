# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, :authorize_user

  def show
    if @user.present?
      flash[:notice] = 'Showing user details'
    else
      flash[:alert] = 'User not found'
    end
  end

  def update_role
    if @user.update(role: params[:role])
      flash[:notice] = 'Role updated'
    else
      flash[:alert] = 'Role not updated'
    end

    redirect_to root_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_user
    authorize @user
  end
end
