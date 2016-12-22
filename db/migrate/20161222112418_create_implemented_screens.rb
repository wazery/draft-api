class CreateImplementedScreens < ActiveRecord::Migration[5.0]
  def change
    create_table :implemented_screens do |t|
      t.attachment :payload
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
