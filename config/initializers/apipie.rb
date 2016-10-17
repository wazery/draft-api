Apipie.configure do |config|
  config.app_name                = 'Draft'
  config.api_base_url            = ''
  config.doc_base_url            = '/docs'
  config.app_info                = 'API documentation for the agnostic Rails API that powers draftapp.io'
  config.copyright               = 'All copyrights are reserved for Draft'
  config.markup                  = Apipie::Markup::Markdown.new
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/*.rb"
  config.validate				         = false

  config.authenticate            = proc do
    authenticate_or_request_with_http_basic do |username, password|
      [username, password] == [DraftAppApi::Application::HTTP_AUTH_USERNAME, DraftAppApi::Application::HTTP_AUTH_PASSWORD]
    end
  end
end
