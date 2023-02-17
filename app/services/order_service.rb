# frozen_string_literal: true

class OrderService
  def initialize(session_with_product, user)
    @session_with_product = session_with_product
    @user = user
  end

  def create_order
    @order = Order.new(user_id: @user.id, total_amount: @session_with_product.amount_total)
    @session_with_product.line_items.data.each do |item|
      product = Product.find_by(stripe_price_id: item.price.id)
      @order.orderproducts.new(product_id: product.id, quantity: item.quantity)
      @order.save
    end
  end
end
