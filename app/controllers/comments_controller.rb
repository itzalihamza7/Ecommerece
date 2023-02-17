# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_product
  before_action :set_comment, only: %i[edit update destroy]
  before_action :authorize_user, only: %i[edit update destroy]

  def edit; end

  def create
    @comment = @set_product.comments.new(comment_params)
    authorize @comment unless @comment.nil?
    @comment.user = current_user unless @comment.nil?
    if @comment.save
      flash[:notice] = 'Comment was successfully created.'
    else
      flash[:alert] = 'Comment was not created.'
    end
  end

  def update
    if @comment.update(comment_params)
      flash[:notice] = 'Comment was successfully updated.'
    else
      flash[:alert] = 'Comment was not updated.'
    end
  end

  def destroy
    if @comment.destroy
      flash[:notice] = 'Comment was successfully destroyed.'
    else
      flash[:alert] = 'Comment was not destroyed.'
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_product
    @set_product = Product.find(params[:product_id])
  end

  def authorize_user
    authorize @comment
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
