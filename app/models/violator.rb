class Violator < ActiveRecord::Base
  attr_accessible :license, :description, :organization_id

  has_many :violations
  belongs_to :organization

  validates_presence_of :license
  validates_uniqueness_of :license
end
