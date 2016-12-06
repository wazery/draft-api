class Note < ApplicationRecord
  include PublicActivity::Common

  has_many :note_replies
  belongs_to :artboard
  belongs_to :user

  # Validations
  validates :object_id, uniqueness: true

  # Delegations
  delegate :project_id, to: :artboard

  # Callbacks
  before_save :assign_object_id
  after_create :create_note_activity

  def create_note_activity
    create_activity(owner: user, action: 'create_note',
                    project_id: project_id,
                    params: { type: 1, where: artboard.name, message: note })
  end

  def assign_object_id
    return if object_id

    self.object_id = Digest::SHA1.hexdigest([user_id, Time.now, rand].join)
  end
end
