class AddArchivedToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :archived, :boolean, default: false, null: false
  end
end
