class CreateViolators < ActiveRecord::Migration
  def change
    create_table :violators do |t|
      t.string :license
      t.text :description
      t.integer :violation_id
      t.integer :organization_id
      t.timestamps
    end
    add_index :violators, :violation_id
    add_index :violators, :organization_id
  end
end
