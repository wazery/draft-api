class MiscController < ApplicationController
  def ping
    render json: { status: 'OK' }
  end
end
