Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github,         ENV['github_key'],   ENV['github_secret'], { scope: 'email,profile' }
  provider :dropbox, ENV['DROPBOX_KEY'],  ENV['DROPBOX_SECRET']
end
