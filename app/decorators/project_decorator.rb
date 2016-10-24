class ProjectDecorator < Draper::Decorator
  delegate_all

  def to_json(options = {})
    ret             = as_json
    ret[:artboards] = artboards.paginate(page: options[:page]).decorate.to_json
    ret[:slices]    = slices # FIXME: Needs to be moved to artboards
    ret[:colors]    = colors

    ret[:team_id]   = team.id

    ret
  end

  def to_index_json
    ret = as_json(except: %i(slices colors))

    ret[:team] = team.decorate.to_json

    ret
  end
end
