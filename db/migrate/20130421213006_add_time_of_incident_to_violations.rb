class AddTimeOfIncidentToViolations < ActiveRecord::Migration
  def change
    add_column :violations, :time_of_incident, :datetime, :null => true, :default => :null
  end
end
