class ActivitiesController < BaseController
  ################# Documentation ##############################################
  api :GET, '/projects/:project_id/activities', "Returns the specified project's activities"
  example <<-EOS
    [
      {
        day:
        activities: [
          {
            user:
            type:
            what:
            where:
            message:
            created_at:
          }
        ]
      }
    ]
  EOS
  param :project_id, Integer, desc: 'Project ID', required: true
  error code: 401, desc: 'Authentication failed'
  ################# /Documentation #############################################
  def index
    # FIXME: Fix this when we create a seperate umbrella resoure for our resources (company)
    @activities =
      ActivityDecorator.decorate_collection(PublicActivity::Activity.where(
        project_id: current_user.projects.map(&:id)))

    render json: @activities.to_index_json, status: :ok
  end

  ################# Documentation ##############################################
  api :POST, '/projects/:project_id/activities', "Returns the created activity"
  example <<-EOS
    [
      {
        user:
        type:
        what:
        where:
        message:
        created_at:
      }
    ]
  EOS
  param :project_id, Integer, desc: 'Project ID', required: true
  param :message, String, desc: 'Message', required: true
  param :user_id, String, desc: 'The user that create', required: true
  error code: 401, desc: 'Authentication failed'
  error code: 422, desc: 'Unprocessable entity'
  ################# /Documentation #############################################
  def create
    @activity = Activity.new(activity_params
      .reverse_merge(user_id: current_user.id, type: 5 what: 'Post'))

    if @activity.save
      render json: @activity.decorate.to_json, status: :created
    else
      render json: @activity.errors, status: :unprocessable_entity
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def activity_params
    params.permit(:message)
  end
end
