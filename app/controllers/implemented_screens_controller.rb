class ImplementedScreensController < ApplicationController
  before_action :set_implemented_screen, only: %i(show update destroy)

  ################# Documentation ##############################################
  api :GET, '/projects/:project_id/implemented_screens', "Returns the specified project's implemented_screens"
  example <<-EOS
    [
      {
        url:
        thumb:
        project_id:
      }
    ]
  EOS
  param :project_id, Integer, desc: 'Project ID', required: true
  error code: 401, desc: 'Authentication failed'
  ################# /Documentation #############################################
  def index
    @project = Project.find(params[:project_id])
    @implemented_screens = @project.implemented_screens

    render json: ImplementedScreenDecorator.decorate_collection(@implemented_screens)
  end

  ################# Documentation ##############################################
  api :GET, '/projects/:project_id/implemented_screens/:id', 'Returns the specified implemented_screen'
  example <<-EOS
    {
      url:
      thumb:
      project_id:
    }
  EOS
  param :project_id, Integer, desc: 'Project ID', required: true
  error code: 401, desc: 'Authentication failed'
  ################# /Documentation #############################################
  def show
    render json: @implemented_screen.decorate.to_json
  end

  ################# Documentation ##############################################
  api :POST, '/projects/:project_id/implemented_screens', 'Returns the created implemented_screen'
  example <<-EOS
    {
      url:
      thumb:
      project_id:
    }
  EOS
  param :project_id, Integer, desc: 'Project ID', required: true
  error code: 401, desc: 'Authentication failed'
  ################# /Documentation #############################################
  def create
    @implemented_screen = ImplementedScreen.new(implemented_screen_params)

    if @implemented_screen.save
      render json: @implemented_screen.decorate.to_json, status: :created, location: @implemented_screen
    else
      render json: @implemented_screen.errors, status: :unprocessable_entity
    end
  end

  ################# Documentation ##############################################
  api :PUT, '/projects/:project_id/implemented_screens/:id', 'Returns the updated implemented_screen'
  example <<-EOS
    {
      url:
      thumb:
      project_id:
    }
  EOS
  param :project_id, Integer, desc: 'Project ID', required: true
  error code: 401, desc: 'Authentication failed'
  ################# /Documentation #############################################
  def update
    if @implemented_screen.update(implemented_screen_params)
      render json: @implemented_screen.decorate.to_json
    else
      render json: @implemented_screen.errors, status: :unprocessable_entity
    end
  end

  # DELETE /implemented_screens/1
  ################# Documentation ##############################################
  api :DELETE, '/projects/:project_id/implemented_screens/:id', 'Returns nothing'
  example <<-EOS
    {
      url:
      thumb:
      project_id:
    }
  EOS
  param :project_id, Integer, desc: 'Project ID', required: true
  error code: 401, desc: 'Authentication failed'
  ################# /Documentation #############################################
  def destroy
    @implemented_screen.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_implemented_screen
      @implemented_screen = ImplementedScreen.find(params[:id], project_id: params[:project_id])
    end

    # Only allow a trusted parameter "white list" through.
    def implemented_screen_params
      params.require(:implemented_screen).permit(:payload, :project_id)
    end
end
