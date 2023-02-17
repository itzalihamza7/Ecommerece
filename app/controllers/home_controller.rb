# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @products = Product.all
    if @products.present?
      flash[:notice] = 'Showing all the store Products'
    else
      flash[:alert] = 'No products in store'
    end
  end

  def show; end
end
