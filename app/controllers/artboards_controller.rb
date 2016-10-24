class ArtboardsController < BaseController
  before_action :set_artboard, only: %i(show update destroy set_due_date set_status)

  # GET /artboards
  def index
    @artboards = Artboard.all

    render json: @artboards
  end

  # GET /artboards/1
  def show
    render json: @artboard
  end

  # POST /artboards
  def create
    @artboard = Artboard.new(artboard_params)

    if @artboard.save
      render json: @artboard, status: :created, location: @artboard
    else
      render json: @artboard.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /artboards/1
  def update
    if @artboard.update(artboard_params)
      render json: @artboard
    else
      render json: @artboard.errors, status: :unprocessable_entity
    end
  end

  # DELETE /artboards/1
  def destroy
    @artboard.destroy
  end

  ################# Documentation ##############################################
  api :GET, '/projects/:project_id/artboards/:id/set_due_date', 'Sets the due date for the artboard'
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
  api :GET, '/projects/:project_id/artboards/:id/set_status', 'Sets the status for the artboard'
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
