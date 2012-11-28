class Violation < ActiveRecord::Base
  attr_accessible :address, :description, :title, :violator_id, :user_id

  belongs_to :user
  has_many :photos

  validates_presence_of :title, :address
end
