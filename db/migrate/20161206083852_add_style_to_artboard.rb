class AddStyleToArtboard < ActiveRecord::Migration[5.0]
  def change
    add_column :artboards, :style, :string
  end
end
