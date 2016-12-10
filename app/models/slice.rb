class Slice < ApplicationRecord
  # Relations
  has_many :exportables, dependent: :destroy
  belongs_to :project

  accepts_nested_attributes_for :exportables
end
