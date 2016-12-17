class Attachment < ApplicationRecord
  # Constants
  PAPERCLIP_CONVERT_PROC = proc do |instance|
    instance.attachable_type.eql?('Artboard') ? '-gravity north -thumbnail 270x179^ -extent 270x179' : ''
  end

  PAPERCLIP_SLICE_IMAGE_STYLES = {
    thumb: { geometry: '100x100^', convert_options: PAPERCLIP_CONVERT_PROC },
    large: { geometry: '' },
  }

  # Relations
  belongs_to :attachable, polymorphic: true

  # Extensions
  ## Paperclip
  has_attached_file :payload, path: 'attachments/:attachment/:id/:hash/:style/:filename',
    hash_secret: 'sticky_notes', # styles: lambda {
  #   |attachment| {
  #     thumb: (
  #       attachment.instance.paperclip_styles
  #     ),
  #     large: (
  #       attachment.instance.attachable_type.eql?('Artboard')? '50%' : ''
  #     )
  #   }
  # },
  styles: PAPERCLIP_SLICE_IMAGE_STYLES,
  # convert_options: { thumb: '-gravity north -thumbnail 270x179^ -extent 270x179' },
  # processors: %i(thumbnail compression)

  # Validations
  validates :payload, attachment_presence: true
  validates_attachment_content_type :payload, content_type: %w(image/jpg image/png image/svg+xml image/tif application/pdf)
end
