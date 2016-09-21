class ProjectMembersController < ApplicationController
  before_action :set_project_member, only: %i(show update destroy)
  before_action :set_project, only: %i(index create)

  # GET /projects/:project_id/project_members
  def index
    @project_members = @project.project_members

    render json: @project_members
  end

  # GET /projects/:project_id/project_members/1
  def show
    render json: @project_member
  end

  # POST /projects/:project_id/project_members
  # Check if member exists
  #  if not send invitation
  #  if yes return already invited message
  param :email, String
  param :firstname, String
  param :lastname, String
  error code: 401, desc: 'Authentication failed'
  error code: 403, desc: 'Email already exists; developer already in application'
  def create
    byebug
    if User.find_by(email: params[:email])
      render json: { message: 'This user is already invited into this project!' }, status: 403
    else
      # user = current_user.invite!(email: params[:email], firstname: params[:firstname], lastname: params[:lastname])
      user = User.invite!(email: params[:email], firstname: params[:firstname], lastname: params[:lastname])
      @project_member = @project.project_members.create(user: user)

      if @project_member
        render json: @project_member, status: :created, location: @project_member
      else
        render json: @project_member.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /projects/:project_id/project_members/1
  def update
    if @project_member.update(project_member_params)
      render json: @project_member
    else
      render json: @project_member.errors, status: :unprocessable_entity
    end
  end

  # DELETE /projects/:project_id/project_members/1
  def destroy
    @project_member.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_member
      @project_member = Member.find(params[:id])
    end

    def set_project
      @project = Project.find(params[:project_id])
    end

    # Only allow a trusted parameter "white list" through.
    # def project_member_params
    #   params.require(:project_member).permit(:project_id, :user_id)
    # end
end
