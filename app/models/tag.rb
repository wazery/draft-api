class Tag < ApplicationRecord
  # Relations
  belongs_to :artboard

  # Scopes
  # default_scope -> { order('id ASC') }
end
