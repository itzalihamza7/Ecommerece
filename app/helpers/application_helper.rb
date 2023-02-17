# frozen_string_literal: true

module ApplicationHelper
  def cart_total(cart)
    cart.collect { |product| product.price * session[:quantity][product.id] }.sum / 100
  end

  def cart_to_json(cart)
    cart.collect { |product| product.to_json(session[:quantity][product.id]).attributes! }
  end

  def price(product)
    product.price / 100
  end

  def find_product_by_stripe_price(line_item)
    Product.find_by(stripe_price_id: line_item.price.id)
  end

  def order_product_total(orderproduct)
    orderproduct.product.price * orderproduct.quantity / 100
  end

  def order_product_quantity(orderproduct)
    orderproduct.quantity
  end

  def order_product_price(orderproduct)
    orderproduct.product.price / 100
  end

  def order_product_title(orderproduct)
    orderproduct.product.title
  end

  def couresal_first_image(image, product)
    image == product.description_images.first ? 'active' : ''
  end

  def valid_checkout_user(product)
    current_user.nil? || current_user != product.user && current_user.Customer?
  end
end
