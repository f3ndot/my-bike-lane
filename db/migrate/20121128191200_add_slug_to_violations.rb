class AddSlugToViolations < ActiveRecord::Migration
  def change
    add_column :violations, :slug, :string
    add_index :violations, :slug, :unique => true
  end
end
