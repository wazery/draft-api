class ArtboardImageAttachment < Attachment 
  # Constants
  PAPERCLIP_CONVERT_PROC = proc do |instance|
    '-gravity north -thumbnail 270x179^ -extent 270x179'
  end

  PAPERCLIP_ARTBOARD_IMAGE_STYLES = {
    thumb: { geometry: '270x179^', convert_options: PAPERCLIP_CONVERT_PROC },
    large: { geometry: '50%' },
  }

  # Extensions
  ## Paperclip
  has_attached_file :payload, path: 'attachments/:attachment/:id/:hash/:style/:filename',
    hash_secret: 'sticky_notes',
    styles: PAPERCLIP_ARTBOARD_IMAGE_STYLES,
    processors: %i(thumbnail compression)
end
