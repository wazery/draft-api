class ActivitiesDecorator < Draper::CollectionDecorator
  def to_index_json
    object
      .group_by { |x| x.created_at.strftime('%A, %e') }
      .map { |key, value| { day: key, activities: value.map { |activity| ActivityDecorator.decorate(activity).to_json } } }
  end
end
