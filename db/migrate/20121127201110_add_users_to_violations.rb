class AddUsersToViolations < ActiveRecord::Migration
  def change
    add_column :violations, :user_id, :integer
    add_index :violations, :user_id
  end
end
