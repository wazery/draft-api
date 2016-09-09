class CreateArtboards < ActiveRecord::Migration[5.0]
  def change
    create_table :artboards do |t|
      t.references :project
      t.string :page_name
      t.string :page_object_id
      t.string :name
      t.string :slug
      t.string :object_id
      t.integer :width
      t.integer :height
      t.string :image_path
      t.json :layers
      t.json :slices
      t.json :exportables

      t.timestamps
    end
  end
end
