class DestroyProjectJob < ApplicationJob
  queue_as :default

  def perform(args = {})
    project          = Project.find(args[:project_id])
    project.destroy
  end
end
