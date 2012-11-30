# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Myservice::Application.initialize!
#require 'smtp_tls'
require 'tls_smtp'
ActionMailer::Base.delivery_method = :smtp
#ActionMailer::Base.delivery_method = :sendmail
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true
#config.action_mailer.delivery_method = :sendmail
# Defaults to:
# config.action_mailer.sendmail_settings = {
#   :location => '/usr/sbin/sendmail',
#   :arguments => '-i -t'
# }
#config.action_mailer.perform_deliveries = true
#config.action_mailer.raise_delivery_errors = true



ActionMailer::Base.smtp_settings = {
  :enable_starttls_auto => true,
  :address  => "smtp.gmail.com",
  :port  => 587,
 # :tls => true,
  :user_name  => "chungthov@gmail.com",
  :password  => "rubyonrails",
  :authentication  => :plain
}

ActionMailer::Base.default_url_options[:host] = "localhost:3000"

Date::DATE_FORMATS.merge!(:default => "%m/%d/%Y")
Date::DATE_FORMATS[:default] = '%m/%d/%Y' 