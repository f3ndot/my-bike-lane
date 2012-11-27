class Violation < ActiveRecord::Base
  attr_accessible :address, :description, :title, :violator_id, :user_id
  belongs_to :user

  validates_presence_of :title, :address
end
