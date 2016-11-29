class StyleguideDecorator < Draper::Decorator
  delegate_all

  def to_json(options = {})
    as_json(except: %i(project_id))
  end
end
