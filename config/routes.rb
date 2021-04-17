Rails.application.routes.draw do
  resource :search, only: :show

  resources :entries, only: [:index, :show]
  resources :tags

  namespace :admin do
    resources :entries

    root to: "entries#index"
  end

  root to: "entries#index"
end
