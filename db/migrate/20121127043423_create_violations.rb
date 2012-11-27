class CreateViolations < ActiveRecord::Migration
  def change
    create_table :violations do |t|
      t.string :title
      t.text :description
      t.string :address
      t.integer :violator_id

      t.timestamps
    end
    add_index :violations, :violator_id
  end
end
