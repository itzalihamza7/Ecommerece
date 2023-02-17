# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError do |e|
      flash[:alert] = e.message
      redirect_back(fallback_location: root_path)
    end

    rescue_from ActiveRecord::RecordNotFound do |e|
      flash[:alert] = e.message
      redirect_back(fallback_location: root_path)
    end

    rescue_from Pundit::NotAuthorizedError do
      flash[:alert] = 'You are not authorized to perform this action.'
      redirect_back(fallback_location: root_path)
    end

    rescue_from Stripe::CardError do |e|
      flash[:alert] = e.message
      redirect_back(fallback_location: root_path)
    end

    rescue_from Stripe::APIConnectionError do |e|
      flash[:alert] = e.message
      redirect_back(fallback_location: root_path)
    end

    rescue_from Stripe::StripeError do |e|
      flash[:alert] = e.message
      redirect_back(fallback_location: root_path)
    end
  end
end
