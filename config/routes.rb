Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  apipie

  root to: 'misc#ping'

  match 'pong', to: 'misc#pong', via: :post
  match 'beta_welcome_email', to: 'mails_viewer#welcome_email', via: :get

  resources :beta_requesters, except: 'index' do
    get :confirm_request, on: :member, param: :confirmation_token
  end

  resources :invites
  resources :tags

  resources :projects do
    get :project_names, on: :collection
    post :set_status, on: :member

    resources :artboards do
      resources :notes
      resources :links

      post :set_due_date, on: :member
      post :set_status, on: :member
    end
  end

  mount_devise_token_auth_for 'User', at: 'auth',
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  # scope :api do
    # mount Sidekiq::Web, at: '/sidekiq'
  # end
end
