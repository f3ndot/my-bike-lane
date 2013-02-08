class Organization < ActiveRecord::Base
  attr_accessible :name, :description

  has_many :violators
  has_many :violations, :through => :violators

end
