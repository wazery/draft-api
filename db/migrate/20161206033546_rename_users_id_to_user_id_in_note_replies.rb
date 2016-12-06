class RenameUsersIdToUserIdInNoteReplies < ActiveRecord::Migration[5.0]
  def change
    rename_column :note_replies, :users_id, :user_id
  end
end
