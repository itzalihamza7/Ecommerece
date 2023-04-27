# frozen_string_literal: true

class CartController < ApplicationController
  before_action :set_product, only: %i[create update destroy]
  skip_before_action :authenticate_user!
  before_action :authorize_user, only: %i[index update destroy]
  before_action :authorize_add_to_cart, only: %i[create]

  def index
    if @cart.present?
      flash[:notice] = 'Showing your cart'
    else
      flash[:alert] = 'Your cart is empty'
    end
  end

  def create
    if session[:cart] << set_product.id
      session[:quantity][set_product.id] = 1
      flash[:notice] = 'Product added to cart'
    else
      flash[:alert] = 'Product already in cart'
    end

    redirect_to cart_index_path
  end

  def update
    if (session[:quantity][set_product.id] = params[:quantity].to_i)
      flash[:notice] = 'Quantity updated'
    else
      flash[:alert] = 'Quantity not updated'
    end
    render :index
  end

  def destroy
    session[:quantity][set_product.id] = 0
    if session[:cart].delete(set_product.id)
      flash[:notice] = 'Product removed from cart'
    else
      flash[:alert] = 'Product not in cart'
    end
    redirect_to cart_index_path
  end

  private

  def authorize_user
    authorize session, policy_class: CartPolicy unless @cart.nil?
  end

  def authorize_add_to_cart
    authorize @set_product, policy_class: CartPolicy unless @set_product.nil?
  end

  def set_product
    @set_product ||= Product.find(params[:id])
  end
end
