class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable,
    :trackable, :validatable, :registerable, :rememberable
    :omniauthable # TODO: :confirmable, :invitable

  include DeviseTokenAuth::Concerns::User

  has_many :invitations, class_name: 'Invite', foreign_key: 'recipient_id'
  has_many :sent_invites, class_name: 'Invite', foreign_key: 'sender_id'

  has_many :memberships, dependent: :destroy
  has_many :teams, through: :memberships
  has_many :projects, through: :teams

  # Delegations

  # # Use friendly_id on Users
  # extend FriendlyId
  # friendly_id :friendify, use: :slugged

  # # necessary to override friendly_id reserved words
  # def friendify
  #   if username.downcase == 'admin'
  #     "user-#{username}"
  #   else
  #     "#{username}"
  #   end
  # end
  #

  # # Validations
  # # :username
  # validates :username, uniqueness: { case_sensitive: false }
  # validates_format_of :username, with: /\A[a-zA-Z0-9]*\z/, on: :create, message: 'can only contain letters and digits'
  # validates :username, length: { in: 4..15 }

  # :email
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates :email, uniqueness: true
end
