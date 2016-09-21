class ProjectsController < ApplicationController
  before_action :set_project, only: %i(show create update destroy)

  # GET /projects
  def index
    @projects = current_user.projects

    render json: @projects.decorate.to_json, status: :ok
  end

  # GET /projects/project_names
  # List user's projects for Sketch plugin
  def project_names
    @projects = current_user.projects

    render json: @projects.map { |project| { name: project.name, slug: project.slug } }
  end

  # GET /projects/1
  def show
    render json: @project.decorate.to_json.deep_transform_keys { |k| k.to_s.camelize(:lower) }
  end

  # POST /projects
  def create
    if @project
      @project.update_settings(project_settings)

      @project.add_or_update_artboards(project_params[:artboards_attributes]) if project_params[:artboards_attributes].present?

      # TODO: Move slices to be inside artboards
      @project.slices = project_params[:slices] if project_params[:slices].present?
      @project.colors = project_params[:colors] if project_params[:colors].present?

      @project.save
    else
      @project = Project.new(project_params)
      @project.user_id = current_user.id

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
      @project = Project.find_by(slug: project_params[:slug], user_id: current_user.id)
    end

    def project_settings
      project_params.select { |key| key.to_sym.in? Project::SETTINGS }
    end

    # Only allow a trusted parameter 'white list' through.
    def project_params
      params.require(:project).permit(:slug,
                                      :scale,
                                      :unit,
                                      :color_format,
                                      artboards_attributes: [
                                        :page_name, :page_object_id, :name, :slug, :object_id,
                                        :width, :height, :image_path,
                                        layers: [
                                          :object_id, :type, :name, :rotation, :radius, :opacity,
                                          :style_name, :font_size, :font_face, :text_align, :letter_spacing,
                                          :line_height, :content, rect: [
                                            :x, :y, :width, :height
                                          ], css: [], borders: [
                                            :fill_type, :position, :thickness,
                                            color: [
                                              :r, :g, :b, :a, :color_hex, :argb_hex, :css_rgba, :ui_color
                                            ]
                                          ],
                                          fills: [
                                            :fill_type, gradient: [
                                              :type, from: [:x, :y], to: [:x, :y],
                                              color_stops: [
                                                :position,
                                                color: [
                                                :r, :g, :b, :a, :color_hex, :argb_hex, :css_rgba, :ui_color
                                                ]
                                              ]
                                            ],
                                            color: [
                                              :r, :g, :b, :a, :color_hex, :argb_hex, :css_rgba, :ui_color
                                            ],
                                          ], shadows: [], color: [
                                            :r, :g, :b, :a, :color_hex, :argb_hex, :css_rgba, :ui_color
                                          ], exportable: [
                                            :name, :density, :format, :path
                                          ]
                                        ],
                                        notes_attributes: [
                                          :object_id,
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
                                        exportable: [
                                          :name, :density, :format, :path
                                        ]
                                      ],
                                      colors: [
                                        :name, color: [
                                          :r, :g, :b, :a, :color_hex, :argb_hex, :css_rgba, :ui_color
                                        ]
                                      ]
                                     )
    end
end
