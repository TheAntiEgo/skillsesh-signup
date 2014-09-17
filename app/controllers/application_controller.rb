class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  rescue_from ActiveRecord::ActiveRecordError, :with => :catch_activerecorderror
  
  
  
  protected
  
  def current_user?
    @user ||= User.find_by(:remember_token => session[:remember_token])
  end
  
  def logged_in?
    session[:remember_token] && User.exists?(:remember_token => session[:remember_token])
  end
  
  def authenticated?
    if !logged_in?
      redirect_to root_path
      return
    end
  end
  
  def redirect_back_or_to_root
    redirect_to(request.env['HTTP_REFERER'] || root_path, :notice => "Why don't you share us with your friends too!")
  end
  
  def catch_activerecorderror(e)
    logger.error "It looks like had a problem with #{e.cause}"
    logger.error e.message
    logger.error e.full_trace
    redirect_to root_url, :alert => "Something went wrong! Try again or contact us for help"
  end
  
  helper_method :current_user?, :logged_in?
end