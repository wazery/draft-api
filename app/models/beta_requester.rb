class BetaRequester < ApplicationRecord
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates :email, uniqueness: true
  validates :email, presence: true
  validates :full_name, presence: true

  before_create :generate_token

  def generate_token
    self.confirmation_token = Digest::SHA1.hexdigest([id, Time.now, rand].join)
  end
end
