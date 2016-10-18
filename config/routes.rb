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
  resources :projects do
    get :project_names, on: :collection

    resources :artboards do
      resources :notes
      resources :tags
      resources :links

      post :set_due_date, on: :member
      post :set_status, on: :member
    end
  end

  mount_devise_token_auth_for 'User', at: 'auth'

  scope :api do
    # resources :users, only: %i(show update)
    # resource :sessions, only: %i(create show destroy)

    # get 'private_access_callback', to: 'sessions#private_access_callback'

    # mount Sidekiq::Web, at: '/sidekiq'
  end
end
