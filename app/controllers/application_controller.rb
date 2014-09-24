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
  
  def set_remember_token(user)
    session[:remember_token] = user.remember_token
  end
  
  def redirect_back_or_to_root
    redirect_to(request.env['HTTP_REFERER'] || root_path, :notice => "Why don't you share us with your friends too!")
  end
  
  def catch_activerecorderror(e)
    logger.error e.message
    redirect_to root_url, :alert => "Something went wrong! Try again or contact us for help"
  end
  
  def stringify(collection)
    value = []
    collection.each do |item|
      value.push(item.name)
    end
    value.join(", ")
  end    
  
  helper_method :current_user?, :logged_in?, :stringify
end
