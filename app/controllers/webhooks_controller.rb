# frozen_string_literal: true

class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!

  def create
    webhook = WebhooksService.new(request)
    if webhook.handle_stripe_event(webhook.create_event)
      flash[:notice] = 'Your order has been placed'
    else
      flash[:alert] = 'Your order has not been placed'
    end
  end
end
