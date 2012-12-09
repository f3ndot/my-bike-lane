class RemoveViolationIdFromViolator < ActiveRecord::Migration
  def up
    remove_index :violators, :violation_id
    remove_column :violators, :violation_id
  end

  def down
    add_column :violators, :violation_id, :integer
    add_index :violators, :violation_id
  end
end
