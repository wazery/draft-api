class SliceDecorator < Draper::Decorator
  delegate_all

  def to_json
    ret = as_json

    ret[:object_id]    = object.object_id # To avoid returing Ruby#object_id
    ret[:exportables]  = exportables.decorate.to_json

    ret
  end
end
