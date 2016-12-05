class NoteReplyDecorator < Draper::Decorator
  delegate_all

  def to_json
    ret = as_json(only: %i(id created_at updated_at))

    ret[:note] = text

    reply_user = user
    if reply_user
      ret[:user_name]  = user.name
      ret[:user_email] = user.email
      ret[:user_image] = user.image
    end

    ret
  end
end
