class BlogPost < ActiveRecord::Base
  attr_accessible :title, :user_id, :slug, :text

  extend FriendlyId
  friendly_id :title, :use => [:slugged, :history]

  belongs_to :user

  validates_presence_of :title, :text, :user_id
end
