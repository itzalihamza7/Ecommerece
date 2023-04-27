# frozen_string_literal: true

module StripeProduct
  extend ActiveSupport::Concern

  included do
    after_update :update_price, if: :saved_change_to_price?
    after_update :update_stripe_product, if: :saved_change_to_title?

    after_create do
      product = Stripe::Product.create(name: title)
      price = Stripe::Price.create(product: product.id, unit_amount: self.price, currency: 'usd')
      update(stripe_product_id: product.id)
      update(stripe_price_id: price.id)
      product.images = ['https://assets.adidas.com/images/w_766,h_766,f_auto,q_auto,fl_lossy,c_fill,g_auto/aa6f6d655b3d40a1a71cae680085031a_9366/al-rihla-pro-ball.jpg']
      product.save
    end

    after_destroy do
      Stripe::Price.update(stripe_price_id, active: false)
      Stripe::Product.update(stripe_product_id, active: false)
    end
  end

  def update_price
    Stripe::Price.update(stripe_price_id, active: false)
    price = Stripe::Price.create(product: stripe_product_id, unit_amount: self.price, currency: 'usd')
    update(stripe_price_id: price.id)
  end

  def update_stripe_product
    Stripe::Product.update(stripe_product_id, name: title)
  end

  def to_json(cart_quantity)
    Jbuilder.new do |product|
      product.price stripe_price_id
      product.quantity cart_quantity
    end
  end
end
