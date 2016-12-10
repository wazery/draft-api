class RemoveExportablesFromArtboard < ActiveRecord::Migration[5.0]
  def change
    remove_column :artboards, :exportables, :json
  end
end
