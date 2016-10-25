class TagsController < BaseController
  before_action :set_tag, only: %i(show update destroy)

  ################# Documentation ##############################################
  api :GET, '/tags', 'Returns all tags for the taggable'
  example <<-EOS
    [
      {
        id:
        name:
      }
    ]
  EOS
  param :taggable_id, Integer, desc: 'Taggable ID (artboard, project)', required: true
  param :taggable_type, String, desc: 'Taggable type (artboard, project)', required: true
  error code: 401, desc: 'Authentication failed'
  error code: 404, desc: 'Artboard not found'
  ################# /Documentation #############################################
  def index
    taggings_ids = Tagging.where(taggable_id: params[:taggable_id],
                                 taggable_type: params[:taggable_type]).map(&:tag_id)
    @tags = Tag.where(id: taggings_ids)

    render json: @tags.decorate.to_json
  end

  ################# Documentation ##############################################
  api :GET, '/tags/:id', 'Returns the requested tag or the errors'
  example <<-EOS
    {
      id:
      name:
    }
  EOS
  param :id, Integer, desc: 'Tag ID', required: true
  error code: 400, desc: 'Bad request, when empty project hash is passed'
  error code: 401, desc: 'Authentication failed'
  error code: 404, desc: 'Project not found'
  ################# /Documentation #############################################
  def show
    render json: @tag
  end

  ################# Documentation ##############################################
  api :POST, '/tags', 'Returns the created tag or the errors'
  example <<-EOS
    {
      id:
      name:
    }
  EOS
  param :taggable_id, Integer, desc: 'Taggable ID (artboard, project)', required: true
  param :taggable_type, String, desc: 'Taggable type (artboard, project)', required: true
  param :tag, Hash, required: true do
    param :name, String, desc: 'Tag name', required: true
  end
  error code: 400, desc: 'Bad request, when empty project hash is passed'
  error code: 401, desc: 'Authentication failed'
  error code: 404, desc: 'Project not found'
  ################# /Documentation #############################################
  def create
    @tag = Tag.find_or_create_by(name: tag_params[:name])
    @tagging = Tagging.find_or_create_by(tag_id: @tag.id,
                                         taggable_id: params[:taggable_id],
                                         taggable_type: params[:taggable_type])

    render json: @tag, status: :ok
  end

  ################# Documentation ##############################################
  api :PUT, '/tags', 'Returns the updated tag or the errors'
  example <<-EOS
    {
      id:
      name:
    }
  EOS
  param :taggable_id, Integer, desc: 'Taggable ID (artboard, project)', required: false
  param :taggable_type, String, desc: 'Taggable type (artboard, project)', required: false
  param :tag, Hash, required: true do
    param :name, String, desc: 'Tag name', required: true
  end
  error code: 400, desc: 'Bad request, when empty project hash is passed'
  error code: 401, desc: 'Authentication failed'
  error code: 404, desc: 'Tag not found'
  ################# /Documentation #############################################
  def update
    if params[:taggable_id] && params[:taggable_type]
      @tag = Tagging.find_by(taggable_id: params[:taggable_id],
                             taggable_type: params[:taggable_type]).tag
    end

    if @tag.update(tag_params)
      render json: @tag
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  ################# Documentation ##############################################
  api :DELETE, '/tags/:id', 'Does not return anything'
  error code: 401, desc: 'Authentication failed'
  error code: 404, desc: 'Tag not found'
  ################# /Documentation #############################################
  def destroy
    render json: {}, status: :ok if @tag.destroy
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
