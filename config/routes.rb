Rails.application.routes.draw do
  mount Avo::Engine => Avo.configuration.root_path

  resource :search, only: :show

  resources :entries, only: [:index, :show]
  resources :tags, only: [:index, :show]

  # Avo requires a specific named path to show sign out link
  delete "/sign_out", to: "clearance/sessions#destroy", as: "destroy_user_session"

  root to: "dashboards#show"
end
