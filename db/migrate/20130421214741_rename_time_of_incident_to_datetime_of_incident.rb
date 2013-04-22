class RenameTimeOfIncidentToDatetimeOfIncident < ActiveRecord::Migration
  def change
    rename_column :violations, :time_of_incident, :datetime_of_incident
  end
end
