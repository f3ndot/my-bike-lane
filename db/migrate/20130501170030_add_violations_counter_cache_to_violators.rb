class AddViolationsCounterCacheToViolators < ActiveRecord::Migration
  def up
    add_column :violators, :violations_count, :integer, :default => 0
    # Organization.find_each do |org|
    #   org.update_attribute(:violators_count, org.violators.length)
    #   org.save
    # end
  end

  def down
    remove_column :violators, :violations_count
  end
end
