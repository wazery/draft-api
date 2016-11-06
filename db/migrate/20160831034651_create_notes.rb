class CreateNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :notes do |t|
      t.references :artboard
      t.references :user
      t.string :object_id
      t.boolean :resolved
      t.text :note
      t.json :rect

      t.timestamps
    end
  end
end
