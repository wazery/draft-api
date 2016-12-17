class CreateAttachment < ActiveRecord::Migration[5.0]
  def change
    create_table :attachments do |t|
      t.attachment :payload
      t.integer :attachable_id
      t.string :attachable_type
    end
  end
end
