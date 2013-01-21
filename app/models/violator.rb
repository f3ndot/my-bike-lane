class Violator < ActiveRecord::Base
  attr_accessible :license, :description, :organization_id

  extend FriendlyId
  friendly_id :license, :use => [:slugged, :history]

  has_many :violations
  belongs_to :organization

  validates_presence_of :license
  validates_uniqueness_of :license
end
