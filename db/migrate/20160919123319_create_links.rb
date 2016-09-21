class CreateLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :links do |t|
      t.references :artboard
      t.string :link
      t.boolean :public

      t.timestamps
    end
  end
end
