class Gmail < ActionMailer::Base
  default :from => "notifications@example.com"

  def welcome_email(user)
    @user = user
    @url  = "http://example.com/login"
    mail(:to => user.email, :subject => "Welcome to My Awesome Site")
  end

  def email(addr)
    #@user = user
    #@url  = "http://example.com/login"
    mail(:to => addr, :subject => "Welcome to My Awesome Site")
  end
end