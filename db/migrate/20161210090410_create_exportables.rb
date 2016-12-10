class CreateExportables < ActiveRecord::Migration[5.0]
  def change
    create_table :exportables do |t|
      t.references :slice
      t.string :name
      t.string :density
      t.string :format
      t.string :path
      t.attachment :file

      t.timestamps
    end
  end
end
