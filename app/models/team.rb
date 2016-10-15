class Team < ApplicationRecord
  # Relations
  has_many :invites
  has_many :memberships
  has_many :users, through: :memberships

  belongs_to :project
end
