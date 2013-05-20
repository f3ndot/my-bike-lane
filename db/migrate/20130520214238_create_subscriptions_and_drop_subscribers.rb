class CreateSubscriptionsAndDropSubscribers < ActiveRecord::Migration
  def change
    drop_table :subscribers
    create_table :subscriptions do |t|
      t.integer :user_id, :null => true
      t.string :email
      t.string :type
      t.boolean :active, :default => false

      t.timestamps
    end
  end
end
