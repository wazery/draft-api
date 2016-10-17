class ProjectsController < BaseController
  before_action :set_project, only: %i(show create update destroy)

  def_param_group :project do
    param :project, Hash do
      param :slug, String, desc: 'Project slug', required: true
    end
  end

  ################# Documentation ##############################################
  api :GET, '/projects', 'Returns all projects for user'
  param_group :project
  example <<-EOS
    [
      {
        id:
        name:
        slug:
        platform:
        thumb:
        scale:
        unit:
        color_format:
        artboards_count:
        created_at:
        team: {
          id:
          project_id:
          users: [
            {
              name:
              image:
              email:
            }
          ]
        }
      }
    ]
  EOS
  error code: 401, desc: 'Authentication failed'
  error code: 422, desc: 'Please open Draft and create a project!'
  error code: 404, desc: 'Project not found'
  ################# /Documentation #############################################
  def index
    @projects = current_user.projects

    render json: @projects.decorate.to_json, status: :ok
  end

  # GET /projects/project_names
  # List user's projects for Sketch plugin
  def project_names
    @projects = current_user.projects

    render json: @projects.map { |project| { name: project.name, slug: project.slug } }, status: 200
  end

  ################# Documentation ##############################################
  api :GET, '/projects/:id', 'Returns the specified project'
  example <<-EOS
    {
      id:
      name:
      slug:
      platform:
      thumb:
      scale:
      unit:
      colorFormat:
      artboardsCount:
      slices:
      colors:
      artboards:
      teamId:
    }
  EOS
  param_group :project
  error code: 401, desc: 'Authentication failed'
  error code: 422, desc: 'Please open Draft and create a project!'
  error code: 404, desc: 'Project not found'
  ################# /Documentation #############################################
  def show
    render json: @project.decorate.to_json.deep_transform_keys { |k| k.to_s.camelize(:lower) }
  end

  ################# Documentation ##############################################
  api :POST, '/projects', 'Returns the created project or the errors'
  example <<-EOS
    {
      id:
      name:
      slug:
      platform:
      thumb:
      scale:
      unit:
      colorFormat:
      artboardsCount:
      slices:
      colors:
      artboards:
      teamId:
    }
  EOS
  param_group :project
  error code: 401, desc: 'Authentication failed'
  error code: 404, desc: 'Project not found'
  ################# /Documentation #############################################
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
      team = Team.create(project_id: @project.id)
      Membership.create(project_id: @project.id, team_id: team.id)

      render json: @project.errors, status: :unprocessable_entity && return unless @project.save
    end

    # TODO: Return the location of the project sharing link
    render json: @project.decorate.to_json.deep_transform_keys { |k| k.to_s.camelize(:lower) }, status: :created, location: @project
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
    # @project = Project.find_by(slug: project_params[:slug]) # TODO: Remove this
    return render json: { errors: ['Please open Draft and create a project!'] }, status: 422 if project_params[:slug] == 'empty'

    @project = Project.find_by(slug: project_params[:slug], user_id: current_user.id)

    return render json:  { errors: ['Project not found!'] }, status: 404 unless @project
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
                                      :width, :height, :image_path, :artboard_image,
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
