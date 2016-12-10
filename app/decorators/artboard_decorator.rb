class ArtboardDecorator < Draper::Decorator
  delegate_all

  def to_json
    ret = as_json(except: %i(artboardImageContentType
                             artboardImageFileName artboardImageFileSize artboardImageUpdatedAt))

    ret[:full_image]  = artboard_image.url(:large)
    ret[:thumb_image] = artboard_image.url(:thumb)
    ret[:layers]      = layers
    ret[:notes]       = notes.decorate.to_json
    ret[:tags]        = tags.decorate.to_json
    ret[:assignee]    = UserDecorator.decorate(assignee).to_json if assignee

    ret
  end
end
