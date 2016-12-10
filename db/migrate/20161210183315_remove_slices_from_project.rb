class RemoveSlicesFromProject < ActiveRecord::Migration[5.0]
  def change
    remove_column :projects, :slices, :json
  end
end
