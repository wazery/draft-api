class BetaRequestersController < ApplicationController
  before_action :set_beta_requester, only: %i(confirm_request destroy)

  # GET /beta_requesters
  def index
    @beta_requesters = BetaRequester.all

    render json: @beta_requesters
  end

  # POST /beta_requesters
  def create
    @beta_requester = BetaRequester.new(full_name: params[:full_name],
                                        email: params[:email])

    if @beta_requester.save
      BetaMailer.welcome_email(@beta_requester).deliver

      redirect_to 'http://draftapp.io'
      # render json: @beta_requester, status: :created, location: @beta_requester
    else
      render json: @beta_requester.errors, status: :unprocessable_entity
    end
  end

  def confirm_request
    return unless @beta_requester
    return if @beta_requester.confirmed_at || @beta_requester.confirmation_token != params[:confirmation_token]

    @beta_requester.confirmed_at = Time.now

    if @beta_requester.save
      render template: 'beta_mailer/confirmed.html.erb', locals: { confirmed: true, beta_requester: @beta_requester }
    else
      render template: 'beta_mailer/confirmed.html.erb', locals: { confirmed: false, beta_requester: @beta_requester }
    end
  end

  # DELETE /beta_requesters/1
  def destroy
    @beta_requester.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_beta_requester
    @beta_requester = BetaRequester.find_by(confirmation_token: params[:confirmation_token])
  end
end
