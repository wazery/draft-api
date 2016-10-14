class CreateBetaRequesters < ActiveRecord::Migration[5.0]
  def change
    create_table :beta_requesters do |t|
      t.string :full_name
      t.string :email

      t.timestamps
    end
  end
end
