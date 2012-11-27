class AddUserAttrsToUser < ActiveRecord::Migration
  def change
    add_column :users, :hometown, :string
    add_column :users, :given_name, :string
    add_column :users, :family_name, :string
    add_column :users, :gender, :string
    add_column :users, :bio, :text
    add_column :users, :birthday, :date
  end
end
