# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  let(:non_comment_user) { create(:user) }
  let(:comment_user) { create(:user) }
  let(:comment_product) { create(:product, user: comment_user) }
  let(:comment) { create(:comment, user: comment_user, product: comment_product) }
  let(:valid_attributes) { { body: Faker::Lorem.paragraph } }
  let(:invalid_attributes) { { body: '' } }

  describe 'GET /edit' do
    subject(:edit_comment) { get edit_product_comment_path(comment_product, comment), xhr: true }

    context 'when comment user is signed in' do
      before { sign_in comment_user }

      it 'shows the edit page' do
        expect(edit_comment).to render_template(:edit)
      end
    end

    context 'when non-comment user is signed in' do
      before { sign_in non_comment_user }

      it 'does not show the edit page' do
        edit_comment

        expect(flash[:alert]).to eq('You are not authorized to perform this action.')
      end
    end

    context 'when no user is signed in' do
      it 'does not show the edit page' do
        edit_comment

        expect(response.body).to eq 'You need to sign in or sign up before continuing.'
      end
    end
  end

  describe 'POST /create' do
    subject(:create_comment) do
      post product_comments_path(comment_product), params: { comment: valid_attributes }, xhr: true
    end

    context 'when comment user is signed in' do
      before { sign_in comment_user }

      it 'creates a comment with valid body' do
        create_comment

        expect(flash[:notice]).to eq 'Comment was successfully created.'
      end

      it 'does not create a comment with invalid body' do
        post product_comments_path(comment_product), params: { comment: invalid_attributes }, xhr: true
        expect(flash[:alert]).to eq 'Comment was not created.'
      end
    end

    context 'when no user is signed in' do
      it 'does not create a comment' do
        create_comment

        expect(response.body).to eq 'You need to sign in or sign up before continuing.'
      end
    end
  end

  describe 'PATCH /update' do
    subject(:update_comment) do
      patch product_comment_path(comment_product, comment), params: { comment: valid_attributes }, xhr: true
    end

    context 'when comment user is signed in' do
      before { sign_in comment_user }

      it 'updates a comment with valid body' do
        update_comment

        expect(flash[:notice]).to eq 'Comment was successfully updated.'
      end

      it 'does not update a comment with invalid body' do
        patch product_comment_path(comment_product, comment), params: { comment: invalid_attributes }, xhr: true

        expect(flash[:alert]).to eq 'Comment was not updated.'
      end
    end

    context 'when non-comment user is signed in' do
      before { sign_in non_comment_user }

      it 'does not update a comment' do
        update_comment

        expect(flash[:alert]).to eq 'You are not authorized to perform this action.'
      end
    end

    context 'when no user is signed in' do
      it 'does not update a comment' do
        update_comment

        expect(response.body).to eq 'You need to sign in or sign up before continuing.'
      end
    end
  end

  describe 'DELETE /destroy' do
    subject(:destroy_comment) { delete product_comment_path(comment_product, comment), xhr: true }

    context 'when comment user is signed in' do
      before { sign_in comment_user }

      it 'destroys a comment' do
        destroy_comment

        expect(flash[:notice]).to eq 'Comment was successfully destroyed.'
      end

      it 'does not destroy a comment' do
        allow(comment).to receive(:destroy).and_return(false)
        allow(Comment).to receive(:find).and_return(comment)
        destroy_comment

        expect(flash[:alert]).to eq 'Comment was not destroyed.'
      end
    end

    context 'when non-comment user is signed in' do
      before { sign_in non_comment_user }

      it 'does not destroy a comment' do
        destroy_comment

        expect(flash[:alert]).to eq 'You are not authorized to perform this action.'
      end
    end

    context 'when no user is signed in' do
      it 'does not destroy a comment' do
        destroy_comment

        expect(response.body).to eq 'You need to sign in or sign up before continuing.'
      end
    end
  end
end
