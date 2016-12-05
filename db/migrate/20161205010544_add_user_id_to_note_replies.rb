class AddUserIdToNoteReplies < ActiveRecord::Migration[5.0]
  def change
    add_reference :note_replies, :users, foreign_key: true
  end
end
