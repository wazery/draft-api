class NoteRepliesDecorator < Draper::CollectionDecorator
  def to_json
    object.map do |note_reply|
      note_reply.decorate.to_json
    end
  end
end
