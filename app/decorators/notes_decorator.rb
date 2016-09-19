class NotesDecorator < Draper::CollectionDecorator
  def to_json
    object.map do |note|
      note.decorate.to_json
    end
  end
end
