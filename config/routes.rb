Rails.application.routes.draw do
  # Rutas para productos
  resources :products

  # Rutas para ventas
  resources :sales
   get "sales/record", to: "sales#record", as: "record_sale"

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
