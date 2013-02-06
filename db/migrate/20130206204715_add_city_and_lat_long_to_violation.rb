class AddCityAndLatLongToViolation < ActiveRecord::Migration
  def change
    add_column :violations, :city, :string
    add_column :violations, :latitude, :float
    add_column :violations, :longitude, :float
  end
end
