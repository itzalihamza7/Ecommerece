# frozen_string_literal: true

class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show]
  before_action :set_product, only: %i[show edit update destroy]
  before_action :authorize_user, only: %i[show edit update destroy]

  def index
    @products = current_user.products
    authorize @products.first unless @products.empty?
    if @products.present?
      flash[:notice] = 'Showing your products'
    else
      flash[:alert] = 'You have no products'
    end
  end

  def show
    @comments = @set_product.comments.includes(:user).order(created_at: :desc)
    if @comments.present?
      flash[:notice] = 'Showing all comments and post'
    else
      flash[:alert] = 'no comments on post'
    end
  end

  def new
    @product = current_user.products.new
    authorize @product
  end

  def edit; end

  def create
    @product = current_user.products.new(product_params)
    authorize @product
    if @product.save
      flash[:notice] = 'Product was successfully created.'
      redirect_to edit_product_path(@product)
    else
      flash[:alert] = 'Product could not be created.'
    end
  end

  def update
    if @set_product.update(product_params)
      flash[:notice] = 'Product was successfully updated.'
      render :index
    else
      flash[:alert] = 'Product could not be updated.'

    end
  end

  def destroy
    if @set_product.destroy
      flash[:notice] = 'Product was successfully deleted.'
    else
      flash[:alert] = 'Product could not be deleted.'
    end
    redirect_to products_path
  end

  private

  def authorize_user
    authorize @set_product unless @set_product.nil?
  end

  def set_product
    @set_product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :quantity, :header_image, description_images: [])
  end
end
