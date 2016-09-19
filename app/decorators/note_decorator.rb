class NoteDecorator < Draper::Decorator
  # delegate_all

  def to_json
    ret = {}

    ret[:id]          = object.id
    ret[:artboard_id] = object.artboard_id
    ret[:object_id]   = object.object_id
    ret[:note]        = object.note
    ret[:rect]        = object.rect

    ret
  end
end
