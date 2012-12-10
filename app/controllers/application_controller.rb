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

  def broadcast(channel, &block)
    message = {:channel => channel, :data => capture(&block)}
    uri = URI.parse("http://localhost:9292/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)
  end

  def broadcast2(channel, text)
    message = {:channel => channel, :data => text}
    uri = URI.parse(Myservice::Application.config.faye_url)
    Net::HTTP.post_form(uri, :message => message.to_json)
  end

  helper_method :current_user  


end
