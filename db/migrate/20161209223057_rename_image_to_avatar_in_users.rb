class RenameImageToAvatarInUsers < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :image_file_name, :avatar_file_name
    rename_column :users, :image_content_type, :avatar_content_type
    rename_column :users, :image_file_size, :avatar_file_size
    rename_column :users, :image_updated_at, :avatar_updated_at
  end
end
