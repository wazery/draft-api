class CreateNotificationSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :notification_settings do |t|
      t.boolean :summary
      t.boolean :mention_me
      t.boolean :create_project
      t.string :weekly_summary
      t.boolean :project_comment
      t.boolean :new_features

      t.timestamps
    end
  end
end
