class CreateNoteReplies < ActiveRecord::Migration[5.0]
  def change
    create_table :note_replies do |t|
      t.string :text
      t.references :note

      t.timestamps
    end
  end
end
