# frozen_string_literal: true

class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_at, :user

  belongs_to :user
  belongs_to :product
end
