class MailsViewerController < ApplicationController
  def welcome_email
    beta_requester = BetaRequester.find_by(email: params[:email])

    render partial: 'beta_mailer/welcome_email', locals: { beta_requester: beta_requester, from_browser: true }
  end
end
