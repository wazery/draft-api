module Config
  module_function

  # Returns the Github application client id token
  #
  # @return github_client_id [String]
  def github_client_id
    Rails.application.secrets.github_client_id
  end

  # Returns the Github application client secret token
  #
  # @return github_client_secret [String]
  def github_client_secret
    Rails.application.secrets.github_client_secret
  end

  # Returns the time to live for the application tokens
  #
  # @return app_token_ttl [String]
  def app_token_ttl
    Rails.application.secrets.app_token_ttl
  end

  # Returns the JWT secret token
  #
  # @return app_jwt_token_secret [String]
  def app_jwt_token_secret
    Rails.application.secrets.app_jwt_token_secret
  end
end
