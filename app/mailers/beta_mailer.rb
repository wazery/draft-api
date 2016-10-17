class BetaMailer < ApplicationMailer
  def welcome_email(beta_requester)
    @beta_requester = beta_requester
    @from_browser = false

    mail(to: @beta_requester.email, subject: 'Welcome to Draft Private Beta')
  end
end
