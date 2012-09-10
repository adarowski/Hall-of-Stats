Hos::Application.routes.draw do
  match '/player/:id', to: 'players#show', as: :player
  root to: 'players#index'
end
