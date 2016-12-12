class ArtboardDecorator < Draper::Decorator
  delegate_all

  def to_json
    ret = as_json(except: %i(artboard_image_content_type
                             artboard_image_file_name artboard_image_file_size artboard_image_updated_at))

    ret[:full_image]  = artboard_image.url(:large)
    ret[:thumb_image] = artboard_image.url(:thumb)
    ret[:object_id]   = object.object_id # To avoid returing Ruby#object_id
    ret[:layers]      = layers
    ret[:notes]       = notes.decorate.to_json
    ret[:tags]        = tags.decorate.to_json
    ret[:assignee]    = UserDecorator.decorate(assignee).to_json if assignee

    ret
  end
end
