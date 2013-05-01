class Violator < ActiveRecord::Base
  attr_accessible :license, :description, :organization, :organization_id

  extend FriendlyId
  friendly_id :license, :use => [:slugged, :history]

  has_many :violations
  belongs_to :organization, :counter_cache => true

  validates_presence_of :license
  validates_uniqueness_of :license

  scope :worst, lambda {|limit| order(:violations_count).limit(limit) } 

end
