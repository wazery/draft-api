class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.references :user
      t.string :name
      t.string :slug
      t.string :platform
      t.string :thumb
      t.string :scale
      t.string :unit
      t.string :color_format
      t.integer :artboards_count, default: 0
      t.json :slices
      t.json :colors

      t.timestamps
    end

    add_index :projects, %i(user_id slug)
  end
end
