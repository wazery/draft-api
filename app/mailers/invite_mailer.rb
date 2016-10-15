class InviteMailer < ApplicationMailer
  # TODO: Test this
  def new_user_invite(invite)
    invitation_url = "#{host}/register?invite_token=#{invite.token}"
  end

  protected

  def host
    ActionMailer::Base.default_url_options[:host]
  end
end
