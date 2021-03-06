class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_order

  rescue_from ActiveRecord::RecordNotFound do
    flash[:warning] = 'Resource not found.'
    redirect_back_or root_path
  end

  def current_order
    if !session[:order_id].nil?
      Order.find(session[:order_id])
    else
      Order.new
    end
  end

  def redirect_back_or(path)
    redirect_to request.referer || path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name alias role_ids])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name alias])
  end
end
