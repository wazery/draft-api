class RemoveArtboardImageFromArtboards < ActiveRecord::Migration[5.0]
  def change
    remove_column :artboards, :artboard_image_file_name, :string
    remove_column :artboards, :artboard_image_content_type, :string
    remove_column :artboards, :artboard_image_file_size, :integer
    remove_column :artboards, :artboard_image_updated_at, :datetime
  end
end
