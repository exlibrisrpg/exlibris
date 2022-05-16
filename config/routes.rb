Rails.application.routes.draw do
  # Project domain
  constraints subdomain: ["", "www"] do
    # Redirects for original morkborg pages
    get "/entries(*any)" => redirect(subdomain: "morkborg")
    get "/tags(*any)" => redirect(subdomain: "morkborg")
    get "/search(*any)" => redirect(subdomain: "morkborg")

    # Avo routes
    scope path: Avo.configuration.root_path do
      scope module: "avo" do
        get "dashboard", to: "tools#dashboard"
        mount Avo::Engine => "/"
      end

      scope module: "clearance" do
        # Clearance routes
        resources :passwords, controller: "passwords", only: [:create, :new]
        resource :session, controller: "sessions", only: [:create]
        resources :users, controller: "users", only: [:create] do
          resource :password,
            controller: "passwords",
            only: [:edit, :update]
        end
        get "/sign_in" => "sessions#new", :as => "sign_in"
        delete "/sign_out" => "sessions#destroy", :as => "sign_out"
        get "/sign_up" => "users#new", :as => "sign_up"

        # Avo requires a specific named path to show sign out link
        delete "/sign_out", to: "sessions#destroy", as: "destroy_user_session"
      end
    end
  end

  # System subdomains
  constraints subdomain: /.*/ do
    resource :search, only: :show
    resources :entries, only: [:index, :show]
    resources :tags, only: [:index, :show]
  end

  # Static pages
  get :about, to: "pages#about"
  get :credits, to: "pages#credits"

  # Redirects for recently moved routes
  get "/sign_in" => redirect(subdomain: "", path: "/admin/sign_in")

  root to: "dashboards#show"

  if Rails.env.development?
    mount Lookbook::Engine, at: "/lookbook"
  end
end
