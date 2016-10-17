class UserDecorator < Draper::Decorator
  delegate_all

  def to_index_json
    ret = as_json(only: %i(email name firstname lastname image))

    ret
  end
end
