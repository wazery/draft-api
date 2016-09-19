class ArtboardsDecorator < Draper::CollectionDecorator
  def to_json
    object.map do |artboard|
      artboard.decorate.to_json
    end
  end
end
