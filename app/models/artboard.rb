class Artboard < ApplicationRecord
  # extend FriendlyId
  # friendly_id :slug, use: :slugged

  # Relations
  has_many :notes
  has_many :tags
  # has_many :notification_logs, as: :loggable
  belongs_to :project, counter_cache: true

  # Validations
  validates :object_id, uniqueness: true

  accepts_nested_attributes_for :notes
end
