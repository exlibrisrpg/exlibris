Rails.application.routes.draw do
  resource :search, only: :show

  resources :entries
  resources :tags

  root to: "entries#index"
end
