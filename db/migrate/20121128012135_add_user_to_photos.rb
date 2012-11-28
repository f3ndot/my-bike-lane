class AddUserToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :user_id, :integer
    add_index :photos, :user_id
  end
end
