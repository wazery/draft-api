class Tagging < ActiveRecord::Base
  belongs_to :tag
  belong_to :taggable, polymorphic: true
end
