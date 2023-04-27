# frozen_string_literal: true

module StripeCoupon
  extend ActiveSupport::Concern

  included do
    after_create do
      coupon = Stripe::Coupon.create(id: coupon, name: code_name, percent_off: percentage_off, currency: 'usd',
                                     duration: 'repeating', duration_in_months: duration_in_months)
      promotion = Stripe::PromotionCode.create(coupon: coupon.id, code: code_name)
      update(stripe_promotion_id: promotion.id)
      update(stripe_coupon_id: coupon.id)
    end

    after_destroy do
      Stripe::Coupon.delete(stripe_coupon_id)
    end
  end

  def duration_in_months
    years = valid_til.year - Time.current.year
    valid_til.month + years * 12 - Time.current.month
  end
end
