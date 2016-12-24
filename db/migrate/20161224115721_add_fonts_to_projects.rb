class AddFontsToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :fonts, :json
  end
end
