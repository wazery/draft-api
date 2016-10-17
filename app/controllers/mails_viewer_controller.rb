class MailsViewerController < ApplicationController
  def welcome_email
    beta_requester = BetaRequester.find_by(email: params[:email])

    render template: 'beta_mailer/welcome_email.html.erb', locals: { beta_requester: beta_requester, from_browser: true }
  end
end
