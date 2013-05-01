class AddViolatorCounterCacheToOrganizations < ActiveRecord::Migration
  def up
    add_column :organizations, :violators_count, :integer, :default => 0
    # Organization.find_each do |org|
    #   org.update_attribute(:violators_count, org.violators.length)
    #   org.save
    # end
  end

  def down
    remove_column :organizations, :violators_count
  end
end
