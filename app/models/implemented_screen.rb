class ImplementedScreen < ApplicationRecord
  belongs_to :project

  PAPERCLIP_STYLE = {
    thumb: { geometry: '270x179^', convert_options: PAPERCLIP_CONVERT_PROC },
    large: { geometry: '50%' },
  }

  has_attached_file :payload, path: 'implemented_screens/:attachment/:id/:hash/:style/:filename',
    hash_secret: 'implemented_screen',
    styles: PAPERCLIP_STYLE,
    processors: %i(thumbnail compression)

  validates :payload, attachment_presence: true
  validates_attachment_content_type :payload, content_type: %w(image/jpg image/png)
end
