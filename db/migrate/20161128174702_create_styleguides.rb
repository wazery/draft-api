class CreateStyleguides < ActiveRecord::Migration[5.0]
  def change
    create_table :styleguides do |t|
      t.references :project
      t.json :colors
      t.json :fonts

      t.timestamps
    end
  end
end
