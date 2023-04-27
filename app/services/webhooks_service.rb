# frozen_string_literal: true

class WebhooksService
  def initialize(request)
    @request = request
  end

  def create_event
    payload = @request.body.read
    sig_header = @request.env['HTTP_STRIPE_SIGNATURE']
    event = nil
    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, Rails.application.credentials[:stripe][Rails.env.production? ? :webhook_p : :webhook_d]
      )
    rescue JSON::ParserError
      status 400
      nil
    rescue Stripe::SignatureVerificationError
      status 400
      return
    end
    event
  end

  def handle_stripe_event(event)
    case event.type
    when 'checkout.session.completed'
      handle_checkout_session_completed(event)
    when 'product.created'
      handle_product_created
    when 'customer.created'
      handle_customer_created
    when 'coupon.created'
      handle_coupon_created
    when 'coupon.deleted'
      handle_coupon_deleted
    end
  end

  def handle_checkout_session_completed(event)
    session = event.data.object
    session_with_product = Stripe::Checkout::Session.retrieve(id: session.id, expand: ['line_items'])
    session_with_product.line_items.data.each do |line_item|
      product = Product.find_by(stripe_price_id: line_item.price.id)
      product.quantity = product.quantity - line_item.quantity
      product.save
    end
  end

  def handle_product_created
    flash[:notice] = 'Product created'
  end

  def handle_customer_created
    flash[:notice] = 'Customer created'
  end

  def handle_coupon_created
    flash[:notice] = 'Coupon created'
  end

  def handle_coupon_deleted
    flash[:notice] = 'Coupon deleted'
  end
end
