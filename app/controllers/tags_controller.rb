class TagsController < BaseController
  before_action :set_tag, only: %i(show update destroy)

  ################# Documentation ##############################################
  api :GET, '/projects/:project_id/artboards/:artboard_id/tags', 'Returns all tags for artboards'
  example <<-EOS
    [
      {
        id:
        name:
      }
    ]
  EOS
  param :artboard_id, Integer, desc: 'Artboard ID', required: true
  error code: 401, desc: 'Authentication failed'
  error code: 404, desc: 'Artboard not found'
  ################# /Documentation #############################################
  def index
    @tags = Artboard.find(params[:artboard_id]).tags

    render json: @tags.decorate.to_json
  end

  ################# Documentation ##############################################
  api :GET, '/projects/:project_id/artboards/:artboard_id/tags/:id', 'Returns the created tags or the errors'
  example <<-EOS
    {
      id:
      name:
    }
  EOS
  param :artboard_id, Integer, desc: 'Artboard ID', required: true
  error code: 400, desc: 'Bad request, when empty project hash is passed'
  error code: 401, desc: 'Authentication failed'
  error code: 404, desc: 'Project not found'
  ################# /Documentation #############################################
  def show
    render json: @tag
  end

  ################# Documentation ##############################################
  api :POST, '/projects/:project_id/artboards/:artboard_id/tags', 'Returns the created tags or the errors'
  example <<-EOS
    {
      id:
      name:
    }
  EOS
  param :artboard_id, Integer, desc: 'Artboard ID', required: true
  param :tag, Hash, required: true do
    param :name, String, desc: 'Tag name', required: true
  end
  error code: 400, desc: 'Bad request, when empty project hash is passed'
  error code: 401, desc: 'Authentication failed'
  error code: 404, desc: 'Project not found'
  ################# /Documentation #############################################
  def create
    @tag = Tag.find_or_create_by(name: tag_params[:name],
                                 artboard_id: params[:artboard_id])

    render json: @tag.decorate.to_json, status: :ok
  end

  ################# Documentation ##############################################
  api :POST, '/projects/:project_id/artboards/:artboard_id/tags', 'Returns the updated tags or the errors'
  example <<-EOS
    {
      id:
      name:
    }
  EOS
  param :artboard_id, Integer, desc: 'Artboard ID', required: true
  param :tag, Hash, required: true do
    param :name, String, desc: 'Tag name', required: true
  end
  error code: 400, desc: 'Bad request, when empty project hash is passed'
  error code: 401, desc: 'Authentication failed'
  error code: 404, desc: 'Tag not found'
  ################# /Documentation #############################################
  def update
    if @tag.update(tag_params)
      render json: @tag
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  ################# Documentation ##############################################
  api :DELETE, '/projects/:project_id/artboards/:artboard_id/tags/:id', 'Does not return anything'
  error code: 401, desc: 'Authentication failed'
  error code: 404, desc: 'Tag not found'
  ################# /Documentation #############################################
  def destroy
    @tag.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tag_params
      params.require(:tag).permit(:name)
    end
end
