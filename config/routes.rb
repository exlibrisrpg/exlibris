Rails.application.routes.draw do
  resource :search, only: :show

  resources :entries, only: [:index, :show]
  resources :tags, only: [:index, :show]

  namespace :admin do
    resources :entries
    resources :tags

    root to: "entries#index"
  end

  root to: "entries#index"
end
