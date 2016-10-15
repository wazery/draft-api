class Invite < ApplicationRecord
  belongs_to :team
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  before_create :generate_token
  before_save :check_user_existence

  def check_user_existence
    recipient = User.find_by_email(email)
    self.recipient_id = recipient.id if recipient
  end

  def add_user_to_team(team)
    recipient.teams.push(team)
  end

  protected

  def generate_token
    self.token = Digest::SHA1.hexdigest([self.team_id, Time.now, rand].join)
  end
end
