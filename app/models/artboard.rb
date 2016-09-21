class Artboard < ApplicationRecord
  # extend FriendlyId
  # friendly_id :slug, use: :slugged

  # Relations
  has_many :notes
  has_many :tags
  has_one :link
  belongs_to :project, counter_cache: true
  # has_many :notification_logs, as: :loggable

  # Validations
  validates :object_id, uniqueness: true

  accepts_nested_attributes_for :notes

  # Callbacks
  before_create :add_token

  private

  def add_token
    begin
      self.token = SecureRandom.hex[0,10].upcase
    rescue ActiveRecord::RecordNotUnique
      retry
    end
  end
end
