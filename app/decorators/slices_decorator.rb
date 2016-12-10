class SlicesDecorator < Draper::CollectionDecorator
  def to_json
    object.map do |slice|
      slice.decorate.to_json
    end
  end
end
