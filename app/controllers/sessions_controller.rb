class SessionsController < ApplicationController
  def login
  end

  def create
    user = User.find_by_login(params[:user][:login])
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect_to :controller => 'service', :action => 'list', :notice => "Logged in!"
    else
      #flash.now.alert = "Invalid email or password"
       params[:notice]='Invalid email or password'
      render "login"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :controller => 'service', :action => 'list', :notice => "Logged out!"
  end
end