class ActivityDecorator < Draper::Decorator
  delegate_all

  def to_json
    ret = as_json(only: :created_at)

    ret[:type]    = parameters[:type]    if parameters.key? :type
    ret[:where]   = parameters[:where]   if parameters.key? :where
    ret[:message] = parameters[:message] if parameters.key? :message
    ret[:to]      = parameters[:to]      if parameters.key? :to
    ret[:what]    = trackable_type
    ret[:user]    = owner.name if owner

    ret
  end
end
