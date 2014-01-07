Hos::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  match '/player/:id', to: 'players#show', as: :player, constraints: { id: /.*/ }
  match '/franchise/render_list', to: 'franchise#render_list'
  match '/autocomplete', to: 'players#autocomplete'
  resources :about
  resources :articles
  resources :position
  resources :consensus
  resources :franchise, only: %w{ index show } do
    collection { get :charts, :all_data }
    member { get :render_list }
  end
  root to: 'players#index'
end
