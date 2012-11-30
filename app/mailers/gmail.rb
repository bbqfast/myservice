
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

  def new_comment(addr, comment)
    mail(:to => addr, :subject => "Welcome to My Awesome Site") do |format|
      format.text { render :text => 'A new comment had been added:' + comment }
    end
   
  end
end