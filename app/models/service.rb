class Service < ActiveRecord::Base
  attr_accessible :completion_date, :customer, :description, :name, :owner, :service_type, :status, :submitter, :customer_id
  belongs_to :customer
  belongs_to :owner
end
