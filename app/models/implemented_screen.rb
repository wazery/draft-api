class ImplementedScreen < ApplicationRecord
  belongs_to :project

  validates :payload, attachment_presence: true
  validates_attachment_content_type :payload, content_type: %w(image/jpg image/png)
end
