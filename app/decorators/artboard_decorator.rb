class ArtboardDecorator < Draper::Decorator
  delegate_all

  def to_json
    ret = as_json(except: %i(created_at updated_at))

    ret[:layers] = layers
    ret[:notes] = notes.decorate.to_json
    ret[:slices] = slices
    ret[:exportables] = exportables
    byebug

    ret
  end
end
