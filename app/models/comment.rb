class Comment < ActiveRecord::Base
  attr_accessible :comment_text, :service, :service_id, :created_at
    belongs_to :service
end
