class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :update, :destroy]

  # GET /projects
  def index
    @projects = Project.all

    render json: @projects.to_json
  end

  # GET /projects/project_names
  # List all projects for Sketch plugin
  def project_names
    # FIXME: Check if this is working after enabling authenticate_user!
    @projects = current_user.projects

    render json: @projects.map { |p| { name: p.name, slug: p.slug } }
  end

  # GET /projects/1
  def show
    # TODO: Write the decorator for this
    render json: @project
  end

  # POST /projects
  def create
    # 1. Check projects settings for change
    # 2. Check if project exists
    #   1. If yes, add artboards data to it
    #   2. If no, create a new one with that name, and add artboards data to it
    if @project
      @project.update_settings(project_settings)
      @project.add_or_update_artboards(project_params[:artboards]) if project_params[:artboards].present?
    else
      byebug # TODO: Remove this after testing after fixing getting projects inside the plugin
      @project = Project.new(project_params)

      render json: @project.errors, status: :unprocessable_entity && return unless @project.save
    end

    render json: @project, status: :created, location: @project
  end

  # PATCH/PUT /projects/1
  def update
    if @project.update(project_params)
      render json: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # DELETE /projects/1
  def destroy
    @project.destroy
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find_by(slug: project_params[:slug])
    end

    def project_settings
      project_params.select { |key| key.in? Project::SETTINGS }
    end

    # Only allow a trusted parameter 'white list' through.
    def project_params
      params.require(:project).permit(:slug,
                                      :scale,
                                      :unit,
                                      :color_format,
                                      artboards_attributes: [
                                        :page_name, :page_object_id, :name, :slug, :object_id, :width, :height, :image_path,
                                        layers: [
                                          :object_id, :type, :name, :rotation, :radius, :opacity, :style_name, :font_size, :font_face, :text_align, :letter_spacing, :line_height, :content, rect: [], css: [], borders: [], fills: [], shadows: [], color: []
                                        ],
                                        notes_attributes: [
                                          :note,
                                          rect: [
                                            :x, :y, :width, :height
                                          ]
                                        ]
                                      ],
                                      slices: [
                                        :name, :object_id,
                                        rect: [
                                          :x, :y, :width, :height
                                        ],
                                        exportable: []
                                      ],
                                      colors: []
                                     )
    end
end
