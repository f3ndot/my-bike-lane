class AddUserInfoToViolations < ActiveRecord::Migration
  def change
    add_column :violations, :user_ip, :string
    add_column :violations, :user_agent, :string
    add_column :violations, :referrer, :string
  end
end
