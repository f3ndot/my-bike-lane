class Violation < ActiveRecord::Base
  attr_accessible :address, :description, :title, :violator_id, :user_id, :photos_attributes

  belongs_to :user
  has_many :photos
  
  accepts_nested_attributes_for :photos
  
  validates_presence_of :title, :address
end
