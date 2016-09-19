class Note < ApplicationRecord
  belongs_to :artboard

  # Validations
  validates :object_id, uniqueness: true
end
