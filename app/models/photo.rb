class Photo < ActiveRecord::Base
  attr_accessible :title, :description, :violation_id

  belongs_to :violation

  mount_uploader :image, PhotoUploader
end
