class Photo < ActiveRecord::Base
  attr_accessible :title, :description

  belongs_to :violation

  mount_uploader :image, PhotoUploader
end
