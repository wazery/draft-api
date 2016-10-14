class Artboard < ApplicationRecord
  # extend FriendlyId
  # friendly_id :slug, use: :slugged

  # Relations
  has_many :notes
  has_many :tags
  has_one :link
  belongs_to :project, counter_cache: true
  # has_many :notification_logs, as: :loggable

  # Attachments
  has_attached_file :artboard_image, styles: { thumb: '191x335>' },
    processors: %i(thumbnail compression)

  # Validations
  validates :object_id, uniqueness: true
  validates :artboard_image, attachment_presence: true
  validates_attachment_content_type :artboard_image, content_type: /\Aimage\/.*\z/

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
