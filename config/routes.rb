Rails.application.routes.draw do
  # Rutas para productos
  resources :products, only: [ :index, :show, :new, :create, :edit, :update, :destroy ]
  get "/productos/buscar", to: "products#search", as: :buscar_productos
  get "productos/:category(/:subcategory)", to: "products#category", as: "filtered_products"
  get "/products/:id/price", to: "products#price"

  # Rutas para ventas
  resources :sales do
    member do
      patch :cancel
    end
  end

  # Rutas para usuarios
  resources :users, only: [ :index, :new, :create, :show, :update ] do
    member do
      patch :deactivate
      patch :reactivate
    end
  end

  # Rutas de autenticación con Devise
  devise_for :users, path: "", path_names: {
    sign_in: "login",
    sign_out: "logout"
  }

  # Ruta de salud del sistema
  get "up", to: "rails/health#show", as: :rails_health_check

  # Ruta raíz
  root "home#index"
end
