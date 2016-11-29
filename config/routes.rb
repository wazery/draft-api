require 'sidekiq/web'

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Sidekiq::Web, at: '/sidekiq'
  apipie

  root to: 'misc#ping'

  match 'beta_welcome_email', to: 'mails_viewer#welcome_email', via: :get

  resources :beta_requesters, except: 'index' do
    get :confirm_request, on: :member, param: :confirmation_token
  end

  resources :invites
  resources :tags

  resources :projects do
    get :project_names, on: :collection
    post :set_status, on: :member
    post :add_team_member, on: :member
    post :remove_team_member, on: :member

    resources :activities, only: :index

    resources :styleguides, only: %i(show destroy) do
      post :add_color, on: :member
      post :add_font, on: :member
    end

    resources :artboards, except: %i(index show create update) do
      resources :notes
      resources :links

      post :set_due_date, on: :member
      post :set_status, on: :member
    end
  end

  mount_devise_token_auth_for 'User', at: 'auth',
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
end
