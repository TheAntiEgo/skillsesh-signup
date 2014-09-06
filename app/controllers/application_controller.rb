class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

    
  protected
  
  def current_user
    @current_user ||= User.find_by(:remember_token => session[:remember_token])
  end
  
  def logged_in?
    redirect_to(root_path, :alert => "You're not down with the crew! Join up!") unless session[:remember_token]
  end
end