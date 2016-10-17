class UsersDecorator < Draper::CollectionDecorator
  def to_json
    object.map do |user|
      user.decorate.to_index_json
    end
  end
end
