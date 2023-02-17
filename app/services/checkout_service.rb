# frozen_string_literal: true

class CheckoutService
  def initialize(items, user, successpath, cancelpath, quantity)
    @items = items
    @user = user
    @successpath = successpath
    @cancelpath = cancelpath
    @quantity = quantity
  end

  def cart_checkout
    Stripe::Checkout::Session.create({
                                       mode: 'payment',
                                       payment_method_types: ['card'],
                                       customer: @user.stripe_customer_id,
                                       allow_promotion_codes: true,
                                       line_items: @items.collect do |product|
                                                     product.to_json(@quantity[product.id]).attributes!
                                                   end,
                                       success_url: "#{@successpath}?session_id={CHECKOUT_SESSION_ID}",
                                       cancel_url: @cancelpath
                                     })
  end

  def product_checkout
    Stripe::Checkout::Session.create({
                                       mode: 'payment',
                                       payment_method_types: ['card'],
                                       customer: @user.stripe_customer_id,
                                       allow_promotion_codes: true,
                                       line_items: [{
                                         price: @items.stripe_price_id,
                                         quantity: 1
                                       }],
                                       success_url: "#{@successpath}?session_id={CHECKOUT_SESSION_ID}",
                                       cancel_url: @cancelpath
                                     })
  end
end
