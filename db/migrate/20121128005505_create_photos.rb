class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|

      t.string :title
      t.string :description
      t.string :photo
      t.integer :violation_id

      t.timestamps
    end
    add_index :photos, :violation_id
  end
end
