class CreateSlices < ActiveRecord::Migration[5.0]
  def change
    create_table :slices do |t|
      t.references :project
      t.string :name
      t.string :object_id
      t.json :rect
      # t.json :exportable

      t.timestamps
    end
  end
end
