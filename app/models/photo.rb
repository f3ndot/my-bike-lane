class Photo < ActiveRecord::Base
  attr_accessible :title, :description, :violation_id, :image, :user_id

  belongs_to :violation
  belongs_to :user

  mount_uploader :image, ImageUploader

  validates_presence_of :image
  validates_presence_of :violation_id

  # Some magic to allow CarrierWave file uploads to work with nested forms
  def image=(val)
    if !val.is_a?(String) && valid?
      image_will_change!
      super
    end
  end
  
end
