Hos::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  match '/player/:id', to: 'players#show', as: :player
  root to: 'players#index'
end
