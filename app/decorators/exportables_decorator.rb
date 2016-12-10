class ExportablesDecorator < Draper::CollectionDecorator
  def to_json
    object.map do |exportable|
      exportable.decorate.to_json
    end
  end
end
