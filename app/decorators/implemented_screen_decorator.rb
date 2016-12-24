class ImplementedScreenDecorator < Draper::Decorator
  delegate_all

  def to_json
    ret = {}

    ret[:url]        = payload.url(:original)
    ret[:thumb]      = payload.url(:thumb)
    ret[:project_id] = project_id

    ret
  end
end
