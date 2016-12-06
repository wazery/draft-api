class ArtboardsController < BaseController
  before_action :set_artboard, only: %i(destroy set_due_date set_status add_assignee)

  ################# Documentation ##############################################
  api :DELETE, '/projects/:project_id/artboards/:id', 'Does not return anything'
  param :artboard_id, Integer, desc: 'Artboard ID', required: true
  error code: 401, desc: 'You have no access to this project!'
  error code: 422, desc: 'Please open Draft and create a project!'
  error code: 404, desc: 'Project not found'
  ################# /Documentation #############################################
  def destroy
    @artboard.destroy
  end

  ################# Documentation ##############################################
  api :POST, '/projects/:project_id/artboards/:id/set_due_date', 'Sets the due date for the artboard'
  example <<-EOS
    [
      {
        full_image:
        thumb_image:
        due_date:
        status:
        layers: [
        ]
        notes:
        slices:
        exportables:
      }
    ]
  EOS
  param :artboard_id, Integer, desc: 'Artboard ID', required: true
  param :due_date, Date, desc: 'Artboard new due date', required: true
  error code: 401, desc: 'Authentication failed'
  error code: 404, desc: 'Artboard not found'
  ################# /Documentation #############################################
  def set_due_date
    return unless params[:due_date].present?

    if @artboard.update(due_date: params[:due_date])
      render json: @artboard.decorate.to_json
    else
      render json: @artboard.errors, status: :unprocessable_entity
    end
  end

  ################# Documentation ##############################################
  api :POST, '/projects/:project_id/artboards/:id/set_status', 'Sets the status for the artboard'
  example <<-EOS
    [
      {
        full_image:
        thumb_image:
        due_date:
        status:
        layers: [
        ]
        notes:
        slices:
        exportables:
      }
    ]
  EOS
  param :artboard_id, Integer, desc: 'Artboard ID', required: true
  param :status, String, desc: 'Artboard new status', required: true
  error code: 401, desc: 'Authentication failed'
  error code: 404, desc: 'Artboard not found'
  ################# /Documentation #############################################
  def set_status
    return unless params[:status].present?

    if @artboard.update(status: params[:status])
      render json: @artboard.decorate.to_json
    else
      render json: @artboard.errors, status: :unprocessable_entity
    end
  end

  ################# Documentation ##############################################
  api :POST, '/projects/:project_id/artboards/:id/add_assignees', 'Sets the status for the artboard'
  example <<-EOS
    [
      {
        full_image:
        thumb_image:
        due_date:
        status:
        layers: [
        ]
        notes:
        slices:
        exportables:
      }
    ]
  EOS
  param :artboard_id, Integer, desc: 'Artboard ID', required: true
  param :user_id, Integer, desc: 'User ID to be added', required: true
  error code: 401, desc: 'Authentication failed'
  error code: 402, desc: 'There was a problem assigning the users, please try again'
  error code: 404, desc: 'Artboard not found'
  ################# /Documentation #############################################
  def add_assignee
    @artboard.assignees.push(User.find(params[:user_id]))

    if @artboard.save
      render json: @artboard.decorate.to_json, status: :ok
    else
      render json: { errors: ['There was a problem assigning the users, please try again'] }, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artboard
      @artboard = Artboard.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def artboard_params
      params.require(:artboard).permit(:page_name, :page_object_id, :name, :slug, :object_id, :width, :height, :image_path, :layers_data)
    end
end
