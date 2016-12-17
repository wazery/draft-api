class ArtboardDecorator < Draper::Decorator
  delegate_all

  def to_json
    ret = as_json

    ret[:full_image]  = artboard_image_attachment.payload(:large) if artboard_image_attachment
    ret[:thumb_image] = artboard_image_attachment.payload(:thumb) if artboard_image_attachment
    ret[:object_id]   = object.object_id # To avoid returing Ruby#object_id
    ret[:layers]      = layers
    ret[:notes]       = notes.decorate.to_json
    ret[:tags]        = tags.decorate.to_json
    ret[:assignee]    = assignee.decorate.to_index_json if assignee

    ret
  end
end
