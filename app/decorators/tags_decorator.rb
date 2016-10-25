class TagsDecorator < Draper::CollectionDecorator
  def to_json
    object.map do |tag|
      tag.as_json
    end
  end
end
