class Artboard < ApplicationRecord
  # Relations
  has_many :notes
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings
  has_one :link
  belongs_to :project, counter_cache: true
  # has_many :notification_logs, as: :loggable

  # Attachments
  has_attached_file :artboard_image, styles: { large: '50%', thumb: ''},
    convert_options: { thumb: '-gravity north -thumbnail 270x179^ -extent 270x179' },
    processors: %i(thumbnail compression)

  # Validations
  # validates_uniqueness_of :object_id, scope: :project_id
  validates :artboard_image, attachment_presence: true
  validates_attachment_content_type :artboard_image, content_type: /\Aimage\/.*\z/

  accepts_nested_attributes_for :notes

  # Callbacks
  before_create :add_token

  # self.per_page = 4

  def artboard_thumb
    artboard_image.url(:thumb)
  end

  private

  def add_token
    begin
      self.token = SecureRandom.hex[0,10].upcase
    rescue ActiveRecord::RecordNotUnique
      retry
    end
  end
end
