class BetaMailer < ApplicationMailer
  def welcome_email(beta_requester)
    @beta_requester = beta_requester
    @from_browser = false

    mail(to: @beta_requester.email, subject: 'Welcome to Draft Private Beta')
  end

  def invite_email(email, name)
    @email = email
    @name  = name
    @beta_requester = BetaRequester.find_by(email: email)

    mail(from: 'Ramy Doss <ramy@draftapp.io>',
         to: @email,
         subject: 'Your invitation to Draft App beta test is here!')
  end
end
