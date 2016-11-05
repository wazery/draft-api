class ActivitiesController < ApplicationController
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
    @activities =
      ActivityDecorator.decorate_collection(PublicActivity::Activity.where(
        project_id: params[:project_id]))

    render json: @activities.to_index_json, status: :ok
  end
end
