class ArtboardDecorator < Draper::Decorator
  delegate_all

  def to_json
    ret = as_json(except: %i(artboardImageContentType
                             artboardImageFileName artboardImageFileSize artboardImageUpdatedAt))

    ret[:full_image]  = attachment_url(artboard_image, :large)
    ret[:thumb_image] = attachment_url(artboard_image, :thumb)
    ret[:layers]      = layers
    ret[:notes]       = notes.decorate.to_json
    ret[:slices]      = slices
    ret[:exportables] = exportables

    ret
  end

  private

  def attachment_url(file, style = :original)
    "#{h.request.protocol}#{h.request.host_with_port}#{file.url(style)}"
  end
end
