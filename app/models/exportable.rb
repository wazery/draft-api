class Exportable < ApplicationRecord
  # Relations
  belongs_to :slices

  # Attachments
  has_attached_file :file, styles: { large: '', thumb: ''},
    convert_options: { thumb: '-gravity north -thumbnail 120x120^ -extent 120x120' },
    processors: %i(thumbnail compression)

  # Validations
  validates :file, attachment_presence: true
  validates_attachment_content_type :file, content_type: %w(image/jpg image/png image/svg image/tif application/pdf)
end
