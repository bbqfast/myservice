# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Myservice::Application.initialize!
#require 'smtp_tls'
ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
  :address  => "smtp.gmail.com",
  :port  => 25,
  :user_name  => "",
  :password  => "",
  :authentication  => :login
}

Date::DATE_FORMATS.merge!(:default => "%m/%d/%Y")
Date::DATE_FORMATS[:default] = '%m/%d/%Y' 