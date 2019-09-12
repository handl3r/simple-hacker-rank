# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { sessions: 'users/sessions' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'sign_up', to: 'devise/registrations#new'
  end
  resources :challenges #, only: %i[show index]
  root to: 'challenges#index'

  # Post to /process to test and submit code of user
  post 'process', to: 'challenges#process_post'

  # Post to /default_code to get default code of challange from server
  post 'default_code', to: 'challenges#default_code'

  get 'default_code', to: 'challenges#default_code'
end
