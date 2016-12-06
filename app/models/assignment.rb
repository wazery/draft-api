class Assignment < ActiveRecord::Base
  belongs_to :artboard
  belongs_to :assignee, class_name: 'User'
end
