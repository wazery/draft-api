class CreateArtboards < ActiveRecord::Migration[5.0]
  def change
    create_table :artboards do |t|
      t.references :project
      t.string :object_id
      t.string :page_object_id
      t.string :page_name
      t.string :name
      t.string :slug
      t.integer :status, default: 0
      t.integer :width
      t.integer :height
      t.datetime :due_date
      t.string :token
      t.json :layers
      t.json :slices
      t.json :exportables

      t.timestamps
    end

    add_attachment :artboards, :artboard_image
  end
end
