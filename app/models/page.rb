class Page < ActiveRecord::Base
  attr_accessible :body, :published, :title

  validates_presence_of :title, :body
end
