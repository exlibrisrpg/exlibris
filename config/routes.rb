Rails.application.routes.draw do
  scope path: Avo.configuration.root_path, module: "avo" do
    get "dashboard", to: "tools#dashboard"
    mount Avo::Engine => "/"
  end

  resource :search, only: :show

  resources :entries, only: [:index, :show]
  resources :tags, only: [:index, :show]

  # Avo requires a specific named path to show sign out link
  delete "/sign_out", to: "clearance/sessions#destroy", as: "destroy_user_session"

  get :about, to: "pages#about"
  get :credits, to: "pages#credits"

  root to: "dashboards#show"

  if Rails.env.development?
    mount Lookbook::Engine, at: "/lookbook"
  end
end
