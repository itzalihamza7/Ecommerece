# frozen_string_literal: true

module CheckoutOrder
  extend ActiveSupport::Concern

  def create_order
    orderservice = OrderService.new(@session_with_product, current_user)
    if orderservice.create_order
      flash[:notice] = 'Order was successfully created.'
    else
      flash[:alert] = 'Order was not created.'
    end
  end
end
