# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ExceptionHandler
  include Pundit::Authorization

  protect_from_forgery with: :exception, unless: -> { ENV['RAILS_ENV'] == 'test' }
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :initialize_cart_session
  before_action :load_cart, :set_query
  after_action :discard_flash
  before_action :authenticate_user!

  protected

  def set_query
    @query = Product.ransack(params[:q])
  end

  def initialize_cart_session
    session[:cart] ||= []
    session[:quantity] ||= []
    session[:user]
  end

  def discard_flash
    flash.discard(:notice)
    flash.discard(:alert)
  end

  def load_cart
    @cart = Product.find(session[:cart])
    session[:user] = current_user if user_signed_in?
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :avatar) }

    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :email, :avatar, :password, :current_password)
    end
  end
end
