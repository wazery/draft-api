class NoteReplyDecorator < Draper::Decorator
  delegate_all

  def to_json
    ret = as_json
  end
end
