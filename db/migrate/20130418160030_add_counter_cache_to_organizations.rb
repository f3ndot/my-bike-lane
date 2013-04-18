class AddCounterCacheToOrganizations < ActiveRecord::Migration
  def up
    add_column :organizations, :violations_count, :integer, :default => 0
    Organization.find_each do |org|
      org.update_attribute(:violations_count, org.violations.length)
      org.save
    end
  end

  def down
    remove_column :organizations, :violations_count
  end
end
