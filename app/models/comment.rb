class Comment < ActiveRecord::Base
  attr_accessible :comment_text, :service
    belongs_to :service
end
