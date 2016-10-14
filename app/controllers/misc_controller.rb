class MiscController < ApplicationController
  def ping
    render json: { status: 'OK' }
  end

  def pong
    # byebug
    render json: { status: 'OK'}, status: 404
  end
end
