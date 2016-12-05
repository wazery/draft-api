class NoteDecorator < Draper::Decorator
  delegate_all

  def to_json
    ret = {}
    note_user = user

    ret[:id]          = id
    ret[:artboard_id] = artboard_id
    ret[:object_id]   = note.object_id
    ret[:text]        = note.note
    ret[:rect]        = rect
    ret[:replies]     = note_replies.decorate.to_json
    ret[:date]        = created_at

    if note_user
      ret[:user_name]   = note_user.name || note_user.firstname + ' ' + note_user.lastname
      ret[:user_email]  = note_user.email
      ret[:user_img]    = note_user.image
    end

    ret
  end
end
