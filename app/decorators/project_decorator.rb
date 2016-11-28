class ProjectDecorator < Draper::Decorator
  delegate_all

  def to_json(options = {})
    ret                   = as_json
    ret[:artboards]       = artboards.paginate(page: options[:page]).decorate.to_json
    ret[:artboards_count] = artboards_count
    ret[:styleguide_id]   = styleguide.id
    ret[:slices]          = slices # FIXME: Needs to be moved to artboards
    ret[:colors]          = colors

    ret[:tags]            = tags.decorate.to_json
    ret[:team]            = team.decorate.to_json if team.present?

    ret
  end

  def to_index_json
    ret = as_json(except: %i(slices colors))

    ret[:team]  = team.decorate.to_json if team.present?

    ret
  end
end
