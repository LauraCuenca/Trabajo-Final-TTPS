Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "home#index"

  # Defines the routes for the home controller
  get "productos/listar"
  get "productos/agregar"
  get "productos/modificar"
  get "productos/eliminar"
  get "productos/cambiar_stock"

  # Defines the routes for the ventas controller
  get "ventas/listar"
  get "ventas/asentar"
  get "ventas/cancelar"

  # Defines the routes for the users controller
  resources :users, only: [ :index, :new, :create ]
  get "users/new", to: "users#new", as: "users_new"

  devise_for :users, path: "", path_names: {
  sign_in: "login",
  sign_out: "logout",
  sign_up: "register"
}
  get "up" => "rails/health#show", as: :rails_health_check
end
