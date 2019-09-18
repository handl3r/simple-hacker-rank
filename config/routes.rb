# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { sessions: 'users/sessions' }
  devise_scope :user do
    get 'login', to: 'users/sessions#new'
    get 'sign_up', to: 'users/registrations#new'
  end
  resources :users, only: [:show]
  resources :challenges #, only: %i[show index]
  root to: 'challenges#index'
  get 'forum', to: 'forum#home'
  # Post to /process to test and submit code of user
  post 'process', to: 'challenges#process_post'

  # Post to /default_code to get default code of challange from server
  post 'default_code', to: 'challenges#default_code'
  get 'default_code', to: 'challenges#default_code'
end
