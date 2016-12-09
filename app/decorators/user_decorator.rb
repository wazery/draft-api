class UserDecorator < Draper::Decorator
  delegate_all

  def to_index_json
    ret = as_json(only: %i(id email name firstname lastname role))
    ret[:name]  = firstname + ' ' + lastname if firstname && lastname && !name
    ret[:image] = avatar.file? ? avatar.url : image

    ret
  end
end
