class ProjectsDecorator < Draper::CollectionDecorator
  def to_json
    object.map do |project|
      project.decorate.to_index_json
    end
  end
end
