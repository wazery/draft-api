class Tag < ApplicationRecord
  # Relations
  has_many :taggings

  with_options through: :taggings, source: :taggable do |tag|
    tag.has_many :projects, source_type: 'Project'
    tag.has_many :artboards, source_type: 'Artboard'
  end
end
