# frozen_string_literal: true

module StripeCustomer
  extend ActiveSupport::Concern

  included do
    after_create do
      customer = Stripe::Customer.create(email: email)
      update(stripe_customer_id: customer.id)
    end

    after_update :update_stripe_customer, if: :saved_change_to_email?

    after_destroy do
      Stripe::Customer.delete(stripe_customer_id)
    end
  end

  def update_stripe_customer
    customer = Stripe::Customer.retrieve(stripe_customer_id)
    customer.email = email
    customer.save
  end

  def password?
    password.present?
  end
end
