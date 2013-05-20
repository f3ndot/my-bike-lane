class RenameTypeToSubscriptionType < ActiveRecord::Migration
  def change
    rename_column :subscriptions, :type, :notification_type
  end
end
