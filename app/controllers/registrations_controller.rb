class RegistrationsController < DeviseTokenAuth::RegistrationsController
  def create
    @new_user = build_user(user_params)
    @new_user.save
    @token = params[:invite_token]

    if @token
      team = Invite.find_by(token: @token).team # Find the user group attached to the invite
      @new_user.teams.push(team) # Add this user to the new user group as a member
    end
  end
end
