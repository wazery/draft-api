class CreateAssignments < ActiveRecord::Migration[5.0]
  def change
    create_table :assignments do |t|
      t.integer :artboard_id
      t.integer :assignee_id
    end
  end
end
