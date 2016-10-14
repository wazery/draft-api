class BetaRequestersController < ApplicationController
  before_action :set_beta_requester, only: [:show, :update, :destroy]

  # GET /beta_requesters
  def index
    @beta_requesters = BetaRequester.all

    render json: @beta_requesters
  end

  # GET /beta_requesters/1
  def show
    render json: @beta_requester
  end

  # POST /beta_requesters
  def create
    @beta_requester = BetaRequester.new(beta_requester_params)

    if @beta_requester.save
      BetaMailer.welcome_email(@beta_requester).deliver

      render json: @beta_requester, status: :created, location: @beta_requester
    else
      render json: @beta_requester.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /beta_requesters/1
  def update
    if @beta_requester.update(beta_requester_params)
      render json: @beta_requester
    else
      render json: @beta_requester.errors, status: :unprocessable_entity
    end
  end

  # DELETE /beta_requesters/1
  def destroy
    @beta_requester.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_beta_requester
      @beta_requester = BetaRequester.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def beta_requester_params
      params.require(:beta_requester).permit(:full_name, :email)
    end
end
