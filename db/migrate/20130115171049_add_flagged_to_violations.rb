class AddFlaggedToViolations < ActiveRecord::Migration
  def change
    add_column :violations, :flagged, :boolean
  end
end
