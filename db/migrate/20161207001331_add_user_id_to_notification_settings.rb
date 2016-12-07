class AddUserIdToNotificationSettings < ActiveRecord::Migration[5.0]
  def change
    add_reference :notification_settings, :users, foreign_key: true
  end
end
