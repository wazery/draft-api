class StyleguideDecorator < Draper::Decorator
  delegate_all

  def to_json(options = {})
    as_json
  end
end
