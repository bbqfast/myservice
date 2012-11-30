class ApplicationController < ActionController::Base
  protect_from_forgery
  
helper_method :display 
def display
  if not defined? @@display
    @@display = {}
  end
    return @@display 
end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user  


end
