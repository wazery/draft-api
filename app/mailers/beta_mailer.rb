class BetaMailer < ApplicationMailer
  def welcome_email(beta_requester)
    @beta_requester = beta_requester

    mail(to: @beta_requester.email, subject: 'Welcome to Draft Private Beta')
  end
end
