class ChangeWeeklySummayToBoolean < ActiveRecord::Migration[5.0]
  def change
    remove_column :notification_settings, :weekly_summary
    add_column :notification_settings, :weekly_summary, :boolean
  end
end
