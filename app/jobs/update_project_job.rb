class UpdateProjectJob < ApplicationJob
  queue_as :default

  # FIXME: This needs to be idempotent
  def perform(args = {})
    project          = Project.find(args[:project_id])
    project_settings = args[:project_settings]
    project_params   = args[:project_params]
    current_user     = args[:current_user]

    project.update_settings(project_settings)

    if project_params[:artboards_attributes].present?
      project.add_or_update_artboards(project_params[:artboards_attributes])
    end

    project.slices = project_params[:slices] if project_params[:slices].present?
    project.colors = project_params[:colors] if project_params[:colors].present?

    project.save
  end
end
