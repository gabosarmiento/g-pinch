class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  protected
  def after_sign_in_path_for(resource)
    jobs_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
  
  def user_not_authorized(exception)
   policy_name = exception.policy.class.to_s.underscore

   flash[:error] = I18n.t "pundit.#{policy_name}.#{exception.query}",
     default: 'You cannot perform this action.'
   redirect_to(request.referrer || root_path)
  end
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:name, :email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:name, :email, :password, :password_confirmation)
    end
  end
end
