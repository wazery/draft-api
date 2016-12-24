class ImplementedScreensDecorator < Draper::CollectionDecorator
  def to_json
    object.map do |implemented_screen|
      implemented_screen.decorate.to_json
    end
  end
end
