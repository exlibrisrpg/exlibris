Rails.application.routes.draw do
  resources :entries
  resources :tags

  root to: "entries#index"
end
