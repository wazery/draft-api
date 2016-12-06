class NoteReplyDecorator < Draper::Decorator
  delegate_all

  def to_json
    ret = as_json(only: %i(id text created_at updated_at))

    reply_user = user
    if reply_user
      ret[:user_name]  = reply_user.name
      ret[:user_email] = reply_user.email
      ret[:user_image] = reply_user.image
    end

    ret
  end
end
