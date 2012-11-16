class ApplicationController < ActionController::Base
  protect_from_forgery
  
helper_method :display 
def display
  if not defined? @@display
    @@display = {}
  end
    return @@display 
end


end
