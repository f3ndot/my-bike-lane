class Violation < ActiveRecord::Base
  attr_accessible :address, :description, :title, :violator_id
end
