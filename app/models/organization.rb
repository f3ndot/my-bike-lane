class Organization < ActiveRecord::Base
  attr_accessible :name, :description

  has_many :violators
end
