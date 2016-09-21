class LinkDecorator < Draper::Decorator
  delegate_all

  def to_json
    as_json(except: %i(created_at updated_at))
  end
end
