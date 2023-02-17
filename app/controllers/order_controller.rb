# frozen_string_literal: true

class OrderController < ApplicationController
  before_action :find_order, :authorize_user, only: %i[show]

  def index
    @orders = current_user.orders
    authorize @orders.first unless @orders.empty?
    if @orders.present?
      flash[:notice] = 'Showing all your orders'
    else
      flash[:alert] = 'You have no orders'
    end
  end

  def show
    @orderproducts = @order.orderproducts
    if @orderproducts.present?
      flash[:notice] = 'your order details are shown below'
    else
      flash[:alert] = 'you have no products in this order'
    end
  end

  private

  def find_order
    @order = Order.find(params[:id])
  end

  def authorize_user
    authorize @order
  end
end
