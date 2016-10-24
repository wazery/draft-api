class TeamDecorator < Draper::Decorator
  delegate_all

  def to_json
    ret         = as_json(except: %i(project_id))
    ret[:users] = users.decorate.to_json

    ret
  end
end
