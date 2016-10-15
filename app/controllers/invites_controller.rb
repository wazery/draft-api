class InvitesController < ApplicationController
  before_action :set_invite, only: %i(show update destroy)

  # GET /invites
  def index
    @invites = Invite.all

    render json: @invites
  end

  # GET /invites/1
  def show
    render json: @invite
  end

  # POST /invites
  def create
    @invite = Invite.new(invite_params)
    @invite.sender_id = current_user.id

    if @invite.save
      if @invite.recipient # If the user already exists
        # TODO: Send a notification email
        # InviteMailer.existing_user_invite(@invite).deliver

        # Add the user to the team
        @invite.add_user_to_team(@invite.team)
      else
        InviteMailer.new_user_invite(@invite).deliver
      end

      render json: @invite, status: :created, location: @invite
    else
      # oh no, creating an new invitation failed
      render json: @invite.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /invites/1
  def update
    if @invite.update(invite_params)
      render json: @invite
    else
      render json: @invite.errors, status: :unprocessable_entity
    end
  end

  # DELETE /invites/1
  def destroy
    @invite.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invite
      @invite = Invite.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def invite_params
      params.require(:invite).permit(:email, :team_id, :sender_id, :recipient_idt, :token)
    end
end
