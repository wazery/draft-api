class AddUserIdToArtboards < ActiveRecord::Migration[5.0]
  def change
    add_reference :artboards, :user, foreign_key: true
  end
end
