class Note < ApplicationRecord
  include PublicActivity::Common
  after_create :create_note_activity

  belongs_to :artboard
  belongs_to :user

  # Validations
  validates :object_id, uniqueness: true

  # Delegations
  delegate :project_id, to: :artboard

  def create_note_activity
    create_activity(owner: user, action: 'create_note',
                    project_id: project_id,
                    params: { type: 1, where: artboard.name, message: note })
  end
end
