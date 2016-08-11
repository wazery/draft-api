class SessionsController < ApplicationController
  include Config
  include Github::Endpoints

  skip_before_filter :api_session_token_authenticate!, only: %w(create login_callback)

  # Documentation
  api :POST, '/sessions/', 'Create a new session'
  description <<-EOS
    returns:{
      token: '',
      last_seen: '',
      hacker: {
        id:
        token:
        email:
        name:
      }
    }
  EOS
  param :code, String, required: true
  error code: 401, desc: 'Authentication failed'
  # /Documentation
  def create
    # TODO: Handle the reject access case, and expired tokens

    github_params = {
      client_id: github_client_id,
      redirect_uri: params[:redirect_uri],
      client_secret: github_client_secret,
      code: params[:code]
    }

    auth_status = Github::Auth.basic_auth_with_github github_params

    if auth_status[:status]
      hacker = auth_status[:hacker]
      current_api_session_token.hacker = hacker

      render json: { token: current_api_session_token.token,
                     last_seen: current_api_session_token.last_seen,
                     hacker: (HackerSerializer.new current_hacker, root: false) }
    else
      render json: { error: auth_status[:message] }, status: :unauthorized
    end
  end

  def show
    respond_with current_api_session_token
  end

  def destroy
    current_api_session_token.delete!

    render nothing: true, status: 204
  end

  # def login_callback
  #   if params[:source] == 'Angular'
  #     redirect_to "#{request.env['HTTP_REFERER']}?code=#{params[:code]}"
  #   else
  #     create_session({ client_id: github_client_id, code: params[:code], redirect_uri: github_base_url })
  #   end
  # end

  private

  def api_session_token_url(token)
    api_sessions_path(token)
  end
end

