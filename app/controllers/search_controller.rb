# frozen_string_literal: true

class SearchController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @query = Product.ransack(params[:q])
    @products = @query.result(distinct: true)

    if @products.present?
      flash[:notice] = 'Products found'
    else
      flash[:alert] = 'No products in search results'
    end
  end
end
