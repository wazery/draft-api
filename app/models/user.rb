class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable,
    :trackable, :validatable, :registerable,
    :omniauthable

  include DeviseTokenAuth::Concerns::User

  has_many :projects

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

  # def self.from_omniauth(auth)
  #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #     user.provider = auth.provider
  #     user.uid      = auth.uid
  #     user.email    = auth.info.email
  #     user.password = Devise.friendly_token[0, 20]
  #   end
  # end
end
