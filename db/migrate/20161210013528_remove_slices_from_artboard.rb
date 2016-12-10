class RemoveSlicesFromArtboard < ActiveRecord::Migration[5.0]
  def change
    remove_column :artboards, :slices, :json
  end
end
