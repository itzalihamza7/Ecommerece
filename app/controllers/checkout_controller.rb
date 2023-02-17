# frozen_string_literal: true

class CheckoutController < ApplicationController
  include CheckoutOrder

  before_action :set_product, :authorize_user, only: [:buy_now]
  before_action :authorize_cart, only: [:checkout_cart]
  after_action :create_order, only: [:success]

  def success
    session[:cart] = []
    @session_with_product = Stripe::Checkout::Session.retrieve(id: params[:session_id], expand: ['line_items'])
    authorize User.find_by(stripe_customer_id: @session_with_product.customer), policy_class: CheckoutPolicy
    if @session_with_product.payment_status == 'paid'
      flash[:notice] = 'Payment successful'
    else
      flash[:alert] = 'Payment failed'
    end
  end

  def buy_now
    @session = CheckoutService.new(@product, current_user, success_checkout_index_url, root_url, 1).product_checkout
    if @session.present?
      flash[:notice] = 'Checkout successful'
    else
      flash[:alert] = 'You cannot buy your own product'
    end
  end

  def checkout_cart
    @session = CheckoutService.new(@cart, current_user, success_checkout_index_url, root_url,
                                   session[:quantity]).cart_checkout
    if @session.present?
      flash[:notice] = 'Checkout successful'
    else
      flash[:alert] = 'You cannot buy your own product'
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def authorize_cart
    authorize session, policy_class: CheckoutPolicy
  end

  def authorize_user
    authorize @product, policy_class: CheckoutPolicy
  end
end
