class AddSlugToViolators < ActiveRecord::Migration
  def change
    add_column :violators, :slug, :string
    add_index :violators, :slug, unique: true
  end
end
