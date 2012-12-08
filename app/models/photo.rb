class Photo < ActiveRecord::Base
  attr_accessible :title, :description, :violation_id, :image, :user_id

  belongs_to :violation
  belongs_to :user

  mount_uploader :image, ImageUploader

  validates_presence_of :image
  before_destroy :remove_uploaded_file

  # validates_presence_of :violation_id

  # Some magic to allow CarrierWave file uploads to work with nested forms
  # def image=(val)
  #   if !val.is_a?(String) && valid?
  #     image_will_change!
  #     super
  #   end
  # end
  def remove_uploaded_file
    remove_image!
  end

  # Override to silently ignore trying to remove missing
  # previous image when destroying a Photo.
  def remove_image!
    begin
      super
    rescue Fog::Storage::Rackspace::NotFound
    end
  end

  # Override to silently ignore trying to remove missing
  # previous image when saving a new one.
  def remove_previously_stored_image
    begin
      super
    rescue Fog::Storage::Rackspace::NotFound
      @previous_model_for_image = nil
    end
  end

end
