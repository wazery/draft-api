class BetaMailer < ApplicationMailer
  def welcome_email(beta_requester)
    @beta_requester = beta_requester
    @from_browser = false

    mail(to: @beta_requester.email, subject: 'Welcome to Draft Private Beta')
  end

  def invite_email(beta_requester)
    @beta_requester = beta_requester
    @from_browser = false

    mail(from: 'ramy@draftapp.io', to: @beta_requester.email, subject: 'Your invitation to Draft App beta test is here!')
  end
end
