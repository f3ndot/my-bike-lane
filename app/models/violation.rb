class Violation < ActiveRecord::Base
  attr_accessible :address, :description, :title, :violator_id

  validates_presence_of :title, :address
end
