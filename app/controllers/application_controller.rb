class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    #protect_from_forgery with: :exception
    
    before_action :authenticate_user!, only: [:secure_action]

  def secure_action
    redirect_to root_path
  end

  def after_sign_in_path_for(resource)
    if current_user
      user_path(current_user)
    else
      root_path
    end
  end

#ログアウト時の動き
  def after_sign_out_path_for(resource)
    #flash[:notice] = "Signed out successfully."
    root_path
  end


  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
  
end
