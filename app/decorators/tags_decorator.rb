class TagsDecorator < Draper::CollectionDecorator
  def to_json
    object.map do |tag|
      tag.decorate.to_json
    end
  end
end
