# frozen_string_literal: true

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :products do
    resources :comments, only: %i[edit create update destroy]
  end

  devise_for :users
  resources :order, only: %i[index show]
  resources :search, only: :index
  resources :cart, only: %i[index create update destroy]
  resources :webhooks, only: :create
  resources :checkout, only: [] do
    post :checkout_cart, on: :collection
    post :buy_now, on: :collection
    get :success, on: :collection
  end

  resources :attachements, only: %i[destroy]
  resources :home, only: %i[index show]
  resource :users, only: %i[show] do
    patch :update_role, on: :member
  end

  root to: 'home#index'
end
