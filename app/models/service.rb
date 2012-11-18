class Service < ActiveRecord::Base
  attr_accessible :completion_date, :customer,
  :description, :name, :owner, :service_type,
  :status, :submitter, :submitter_id, :customer_id, :comments, :est_completion, :service_type_id
  
  belongs_to :customer
  belongs_to :owner
  belongs_to :submitter
  belongs_to :service_type
  has_many :comments
end
