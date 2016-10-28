class AddArtboardImageProcessingToArtboards < ActiveRecord::Migration[5.0]
  def change
    add_column :artboards, :artboard_image_processing, :boolean
  end
end
