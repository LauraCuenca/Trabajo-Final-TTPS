class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :username, :phone, :joined_on, :role_ids ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :username, :phone, :joined_on, :role_ids ])
  end
end
