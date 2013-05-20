class CreateSubscribers < ActiveRecord::Migration
  def change
    create_table :subscribers do |t|
      t.integer :user_id, :null => true
      t.string :email
      t.string :type
      t.boolean :active, :default => false

      t.timestamps
    end
  end
end
