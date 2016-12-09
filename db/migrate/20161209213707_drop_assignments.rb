class DropAssignments < ActiveRecord::Migration[5.0]
  def change
    drop_table :assignments
  end
end
