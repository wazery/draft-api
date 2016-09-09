class ArtboardsController < ApplicationController
  before_action :set_artboard, only: [:show, :update, :destroy]

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
