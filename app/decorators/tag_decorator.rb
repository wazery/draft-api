class TagDecorator < Draper::Decorator
  delegate_all

  def to_json
    as_json
  end
end
