# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Products', type: :request do
  let(:user) { create(:user) }
  let(:seller) { create(:user, :Seller) }
  let(:customer) { create(:user, :Customer) }
  let(:product) { create(:product, user: seller) }
  let(:invalid_product_params) do
    { title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph, price: 0, quantity: 0 }
  end
  let(:valid_product_params) do
    { title: Faker::Lorem.sentence.truncate(20), description: Faker::Lorem.sentence, price: 1000, quantity: 10 }
  end

  describe 'GET /index' do
    subject(:get_products) {  get products_path, params: { id: seller.id } }

    context 'when seller is signed in' do
      before { sign_in seller }

      it 'shows the products when present' do
        product
        get_products

        expect(flash[:notice]).to eq('Showing your products')
      end

      it 'shows no products when not present' do
        get_products

        expect(flash[:alert]).to eq('You have no products')
      end
    end

    context 'when customer is signed in' do
      before { sign_in seller }

      it 'tells not authorized' do
        product
        seller.update(role: 'Customer')
        get products_path, params: { id: customer.id }

        expect(flash[:alert]).to eq('You are not authorized to perform this action.')
      end
    end

    it 'redirects to the sign in page when not signed in' do
      get_products

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'GET /show' do
    subject(:get_product) { get product_path(product) }

    context 'when user is signed in' do
      before { sign_in user }

      it 'comments are present it shows comments' do
        create(:comment, user: user, product: product)
        get_product
        expect(flash[:notice]).to eq('Showing all comments and post')
      end

      it 'shows no comments when not present' do
        get_product

        expect(flash[:alert]).to eq('no comments on post')
      end
    end
  end

  describe 'GET /new' do
    subject(:new_product) { get new_product_path }

    context 'when seller is signed in' do
      before { sign_in seller }

      it 'shows the new product form' do
        new_product

        expect(response).to have_http_status(:ok)
      end
    end

    context 'when customer is signed in' do
      before { sign_in customer }

      it 'shows not authorized' do
        new_product

        flash[:alert] = 'You are not authorized to perform this action.'
      end
    end

    it 'redirects to the sign in page when not signed in' do
      new_product

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'GET /edit' do
    subject(:edit_product) { get edit_product_path(product) }

    context 'when seller is signed in' do
      before { sign_in seller }

      it 'shows the edit product form' do
        edit_product

        expect(response).to have_http_status(:ok)
      end
    end

    context 'when customer is signed in' do
      before { sign_in customer }

      it 'shows not authorized' do
        edit_product

        flash[:alert] = 'You are not authorized to perform this action.'
      end
    end

    it 'redirects to the sign in page when not signed in' do
      edit_product

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'POST /create' do
    subject(:create_product) { post products_path, params: { product: valid_product_params } }

    context 'when seller is signed in' do
      before { sign_in seller }

      it 'creates a product with valid params' do
        create_product

        expect(response).to redirect_to(edit_product_path(Product.last))
      end

      it 'does not create a product with invalid params' do
        post products_path, params: { product: invalid_product_params }
        expect(flash[:alert]).to eq('Product could not be created.')
      end
    end

    context 'when customer is signed in' do
      before { sign_in customer }

      it 'shows not authorized' do
        create_product

        expect(flash[:alert]).to eq('You are not authorized to perform this action.')
      end
    end

    it 'redirects to the sign in page when not signed in' do
      create_product

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'PATCH /update' do
    subject(:update_product) { patch product_path(product), params: { product: valid_product_params } }

    context 'when seller is signed in' do
      before { sign_in seller }

      it 'updates a product with valid params' do
        update_product

        expect(response).to render_template(:index)
      end

      it 'does not update a product with invalid params' do
        patch product_path(product), params: { product: invalid_product_params }

        expect(flash[:alert]).to eq('Product could not be updated.')
      end
    end

    context 'when customer is signed in' do
      before { sign_in customer }

      it 'shows not authorized' do
        update_product

        expect(flash[:alert]).to eq('You are not authorized to perform this action.')
      end
    end

    it 'redirects to the sign in page when not signed in' do
      update_product

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'DELETE /destroy' do
    subject(:delete_product) { delete product_path(product) }

    context 'when seller is signed in' do
      before { sign_in seller }

      it 'deletes a product' do
        delete_product

        expect(response).to redirect_to(products_path)
      end

      it 'does not delete a product' do
        allow(product).to receive(:destroy).and_return(false)
        allow(Product).to receive(:find).and_return(product)
        delete_product

        expect(flash[:alert]).to eq('Product could not be deleted.')
      end
    end

    context 'when customer is signed in' do
      before { sign_in customer }

      it 'shows not authorized' do
        delete_product

        flash[:alert] = 'You are not authorized to perform this action.'
      end
    end

    it 'redirects to the sign in page when not signed in' do
      delete_product

      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
