class StyleguidesController < ApplicationController
  before_action :set_styleguide, only: %i(show destroy add_color add_font)

  ################# Documentation ##############################################
  api :GET, 'projects/:project_id/styleguides/:id', 'Returns the specified styleguide'
  example <<-EOS
    {
      id:
      colors: [
        {
        }
      ]
      fonts: [
        {
        }
      ]
    }
  EOS
  param :project_id, Integer, desc: 'Styleguide ID', required: true
  param :id, Integer, desc: 'Styleguide ID', required: true
  error code: 401, desc: 'You have no access to this project!'
  error code: 422, desc: 'Please open Draft and create a project!'
  error code: 404, desc: 'Project not found'
  ################# /Documentation #############################################
  def show
    render json: @styleguide.decorate.to_json
  end

  ################# Documentation ##############################################
  api :POST, 'projects/:project_id/styleguides/:id/add_color', 'Returns the updated styleguide'
  example <<-EOS
    {
      id:
      colors: [
        {
        }
      ]
      fonts: [
        {
        }
      ]
    }
  EOS
  param :project_id, Integer, desc: 'Styleguide ID', required: true
  param :id, Integer, desc: 'Styleguide ID', required: true
  param :colors, Array, desc: 'Colors to be added', required: true
  error code: 401, desc: 'You have no access to this project!'
  error code: 422, desc: 'Please open Draft and create a project!'
  error code: 404, desc: 'Project not found'
  ################# /Documentation #############################################
  def add_color
    if @styleguide.colors.present?
      @styleguide.colors.push(*params[:colors])
    else
      @styleguide.colors = params[:colors]
    end

    if @styleguide.save
      render json: @styleguide.decorate.to_json, status: :ok
    else
      render json: @styleguide.errors, status: :unprocessable_entity
    end
  end

  ################# Documentation ##############################################
  api :POST, 'projects/:project_id/styleguides/:id/add_font', 'Returns the updated styleguide'
  example <<-EOS
    {
      id:
      colors: [
        {
        }
      ]
      fonts: [
        {
        }
      ]
    }
  EOS
  param :project_id, Integer, desc: 'Project ID', required: true
  param :id, Integer, desc: 'Styleguide ID', required: true
  param :fonts, Array, desc: 'Fonts to be added', required: true
  error code: 401, desc: 'You have no access to this project!'
  error code: 422, desc: 'Please open Draft and create a project!'
  error code: 404, desc: 'Project not found'
  ################# /Documentation #############################################
  def add_font
    if @styleguide.fonts.present?
      @styleguide.fonts.push(*params[:fonts])
    else
      @styleguide.fonts = params[:fonts]
    end

    if @styleguide.save
      render json: @styleguide.decorate.to_json, status: :ok
    else
      render json: @styleguide.errors, status: :unprocessable_entity
    end
  end

  # DELETE /styleguides/1
  def destroy
    @styleguide.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_styleguide
      @styleguide = Styleguide.find(params[:id])

      return render json: {errors: ['Something went wrong!']}, status: :unprocessable_entity unless @styleguide
    end

    # Only allow a trusted parameter "white list" through.
    def styleguide_params
      params.require(:styleguide).permit(:colors, :fonts)
    end
end
