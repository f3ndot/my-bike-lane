class AddSpammedToViolations < ActiveRecord::Migration
  def change
    add_column :violations, :spammed, :boolean, :default => false
    change_column :violations, :flagged, :boolean, :default => false
  end
end
