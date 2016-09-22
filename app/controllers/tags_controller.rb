class TagsController < BaseController
  before_action :set_tag, only: %i(show update destroy)

  # GET /tags
  def index
    @tags = Artboard.find(params[:artboard_id]).tags

    render json: @tags.decorate.to_json
  end

  # GET /tags/1
  def show
    render json: @tag
  end

  # POST /tags
  def create
    @tag = Tag.find_or_create_by(name: tag_params[:name],
                                 artboard_id: params[:artboard_id])

    render json: @tag.decorate.to_json, status: :ok
  end

  # PATCH/PUT /tags/1
  def update
    if @tag.update(tag_params)
      render json: @tag
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tags/1
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
