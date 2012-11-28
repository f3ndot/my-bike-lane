class Page < ActiveRecord::Base
  attr_accessible :body, :published, :title, :slug

  extend FriendlyId
  friendly_id :title, :use => [:slugged, :history]

  validates_presence_of :title, :body

  def self.published
    where(:published => true)
  end
end
