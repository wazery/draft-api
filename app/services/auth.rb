module Github
  # Basic authentication service for Github
  module Auth
    extend Endpoints

    # Exceptions
    NotAuthorized = Class.new(Exception)

    module_function

    # Authenticates the hacker with the public access application
    # This method is used in login only
    #
    # @param github_params [String]
    # @return auth_status [Hash]
    def basic_auth_with_github(github_params)
      # TODO: add login counters, time, and date
      begin
        github_profile, access_token = fetch_github_hacker_profile(github_params)
      rescue NotAuthorized
        return { status: false, message: 'Authenication Failed' }
      end

      unless github_profile[:id]
        return { status: false, message: github_profile[:message] }
      end

      hacker = Hacker.where(github_uid: github_profile[:id]).first
      unless hacker
        hacker = Hacker.sign_up(
          email: github_profile[:email],
          avatar_url: github_profile[:avatar_url],
          name: github_profile[:login],
          github_uid: github_profile[:id],
          display_name: github_profile[:name],
          company: github_profile[:company],
          public_gists: github_profile[:public_gists],
          raw_data: github_profile,
          github_token: access_token,
          current_scope: ''
        )

        return { status: true, hacker: hacker, new_hacker: true }
      end

      { status: true, hacker: hacker, new_hacker: false }
    end

    # Authenticates the hacker with the private access application
    # This method is used to add permissions to access private repos and hacker info
    #
    # @param github_params [String]
    # @return auth_status [Hash]
    def auth_private_access(github_params)
      github_profile, access_token = fetch_github_hacker_profile(github_params)

      unless github_profile[:id]
        return { status: false, message: github_profile[:message] }
      end

      hacker = Hacker.where(github_uid: github_profile[:id]).first

      if hacker
        hacker.update_attributes(
          email: github_profile[:email],
          private_gists:       github_profile[:private_gists],
          total_private_repos: github_profile[:total_private_repos],
          owned_private_repos: github_profile[:owned_private_repos],
          private_app_github_access_token: access_token,
          raw_data: github_profile,
          current_scope: 'user, repo'
        )

        return { status: true, hacker: hacker }
      end

      { status: false, error: 'You should sign in first hacker' }
    end

    # Fetches the hacker profile data from Github API
    # based on the access_token
    #
    # @param github_params [String]
    # @return github_profile, access_token [Hash, String]
    def fetch_github_hacker_profile(github_params)
      access_token = fetch_github_access_token(github_params)

      conn = Faraday.new(url: github_api_base_url)

      response = conn.get '/user' do |req|
        req.headers = { Authorization: "token #{access_token}" }
      end

      [(MultiJson.load response.body, symbolize_keys: true), access_token]
    end

    # Fetches an access token from the Github API
    # based on the github_params, which contains the client_id and code.
    #
    # @param github_params [String]
    # @return access_token [String]
    def fetch_github_access_token(github_params)
      conn = Faraday.new(url: github_base_url)

      response = conn.get '/login/oauth/access_token' do |req|
        req.params = github_params
      end

      fail NotAuthorized, 'Failed fetching access token' if response.status == 404
      response.body.match('\=(.*?)\&')[1]
    end
  end
end
