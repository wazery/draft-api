class CreateNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :notes do |t|
      t.references :artboard
      t.string :object_id
      t.text :note
      t.json :rect

      t.timestamps
    end
  end
end
