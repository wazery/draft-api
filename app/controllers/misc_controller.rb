class MiscController < ApplicationController
  skip_before_filter :api_session_token_authenticate!

  def ping
    render json: { status: 'OK' }
  end
end
