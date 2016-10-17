class CreateInvites < ActiveRecord::Migration[5.0]
  def change
    create_table :invites do |t|
      t.string :email
      t.references :team
      t.references :sender
      t.references :recipient
      t.string :token

      t.timestamps

      t.index :email
      t.index :token
      # t.index :sender_id
      # t.index :recipient_id
    end
  end
end
