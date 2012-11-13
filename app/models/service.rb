class Service < ActiveRecord::Base
  attr_accessible :completion_date, :customer, :description, :name, :owner, :service_type, :status, :submitter
end
