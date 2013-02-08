class Organization < ActiveRecord::Base
  attr_accessible :name, :description

  has_many :violators
  has_many :violations, :through => :violators

  validates_presence_of :name
  validates_uniqueness_of :name

end
