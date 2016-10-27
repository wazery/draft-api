Devise.setup do |config|
  # The e-mail address that mail will appear to be sent from
  # If absent, mail is sent from "please-change-me-at-config-initializers-devise@example.com"
  config.mailer_sender = 'support@draftapp.io'

  # If using rails-api, you may want to tell devise to not use ActionDispatch::Flash
  # middleware b/c rails-api does not include it.
  # See: http://stackoverflow.com/q/19600905/806956
  config.navigational_formats = %i(json)

  config.remember_for = 2.weeks

  config.omniauth :github, ENV['github_key'], ENV['github_secret'], { scope: 'email,profile' }
end
