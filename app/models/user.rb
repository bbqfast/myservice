class User < ActiveRecord::Base
  attr_accessible :email, :first, :last, :login, :password_digest, :password_hash, :password_salt, :role, :password, :password_confirmation

  has_secure_password

validates_presence_of :password, :on => :create  

end
