class DefaultTrueToActiveInSubscriptions < ActiveRecord::Migration
  def change
    change_column :subscriptions, :active, :boolean, :default => true
  end
end
